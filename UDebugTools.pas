unit UDebugTools;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted 1998 - 2011 by Bradford Technologies, Inc. }

interface

uses
  Classes,
  InvokeRegistry,
  SoapHTTPClient,
  SysUtils,
  UContainer,
  UForm;

const
  netapi32 = 'netapi32.dll';

type
  TCIDReferences = array of integer;

  TDebugTools = class
    private
      FConsoleHandle: THandle;

    private
      function CountCIDReferences(const container: TContainer; var references: TCIDReferences): TCIDReferences;
      procedure ServiceAfterExecute(const MethodName: string; SOAPResponse: TStream);
      procedure ServiceBeforeExecute(const MethodName: string; var SOAPRequest: InvString);
      procedure WriteCIDsHeaderCSV(const stream: TStream);
      procedure WriteCellDataHeaderCSV(const stream: TStream);
      function GetConsoleAllocated: Boolean;

    public
      procedure DebugSOAPService(const service: THTTPRIO);
      procedure AllocConsole;
      procedure HideConsole;
      procedure ShowConsole;

    public
      property ConsoleAllocated: Boolean read GetConsoleAllocated;

    public
      class function Debugger: TDebugTools;
      class procedure ExportCIDsCSV(const stream: TStream; const container: TContainer);
      class procedure ExportCellDataCSV(const stream: TStream; const container: TContainer);
      class procedure ShowMessage(const Msg: String);
      class procedure WriteLine(const Text: String);
  end;

 WKSTA_INFO_100 = record
   wki100_platform_id: Integer;
   wki100_computername: PWideChar;
   wki100_langroup: PWideChar;
   wki100_ver_major: Integer;
   wki100_ver_minor: Integer;
 end;
 PWKSTA_INFO_100 = ^WKSTA_INFO_100;

function GetDomainName: String;
function NetApiBufferFree(BufPtr: Pointer): Integer; stdcall; external netapi32 name 'NetApiBufferFree';
function NetWkstaGetInfo(ServerName: PChar; Level: Integer; var BufPtr: Pointer): Integer; stdcall; external netapi32 name 'NetWkstaGetInfo';

implementation

uses
  Windows,
  AppEvnts,
  Controls,
  Dialogs,
  Forms,
  Messages,
  UCell,
  UFonts,
  UPage,
  UPaths,
  UWinUtils;

type
  TApplicationDebugEvents = class(TComponent)
    private
      FEvents: TApplicationEvents;
      FControlKeyDown: Boolean;
      FShiftKeyDown: Boolean;
    private
      procedure ProcessMessage(var Msg: TMsg; var Handled: Boolean);
    public
      constructor Create(AOwner: TComponent); override;
  end;

var
  Gdebugger: TDebugTools;

// --- TDebugTools ------------------------------------------------------------

function TDebugTools.CountCIDReferences(const container: TContainer; var references: TCIDReferences): TCIDReferences;
var
  cell: TBaseCell;
  form: TDocForm;
  indexCell: integer;
  indexForm: integer;
  indexPage: integer;
  page: TDocPage;
begin
  if not Assigned(container) then
    raise Exception.Create('Invalid parameter');

  // count CID references
  for indexForm := 0 to container.FormCount - 1 do
    begin
      form := container.docForm[indexForm];
      if Assigned(form.frmPage) then
        for indexPage := 0 to form.frmPage.Count - 1 do
          begin
            page := form.frmPage[indexPage];
            if Assigned(page.pgData) then
              for indexCell := 0 to page.pgData.Count - 1 do
                begin
                  cell := page.pgData[indexCell];
                  if (Length(references) < cell.FCellID + 1) then
                    SetLength(references, cell.FCellID + 1);
                  Inc(references[cell.FCellID]);
                end;  // cell
          end;  // page
    end;  // form
end;

procedure TDebugTools.DebugSOAPService(const service: THTTPRIO);
begin
  service.OnAfterExecute := ServiceAfterExecute;
  service.OnBeforeExecute := ServiceBeforeExecute;
end;

procedure TDebugTools.ServiceAfterExecute(const MethodName: string; SOAPResponse: TStream);
var
  filename: string;
  output: TFileStream;
begin
  filename := TCFFilePaths.AppData + 'Rx' + MethodName + '.xml';
  output := TFileStream.Create(filename, fmCreate or fmOpenWrite);
  try
    SOAPResponse.Position := 0;
    SysUtils.DeleteFile(filename);
    output.CopyFrom(SOAPResponse, SOAPResponse.Size);
  finally
    FreeAndNil(output);
  end;
end;

procedure TDebugTools.ServiceBeforeExecute(const MethodName: string; var SOAPRequest: InvString);
var
  filename: string;
  output: TStringList;
begin
  filename := TCFFilePaths.AppData + 'Tx' + MethodName + '.xml';
  output := TStringList.Create;
  try
    SysUtils.DeleteFile(filename);
    output.Text := SOAPRequest;
    output.SaveToFile(filename);
  finally
    FreeAndNil(output);
  end;
end;

procedure TDebugTools.WriteCIDsHeaderCSV(const stream: TStream);
var
  csv: string;
  properties: TStringList;
begin
  properties := TStringList.Create;
  try
    properties.Add('CID');
    properties.Add('References');
    properties.Add('FormName');
    properties.Add('FormID');
    properties.Add('Page');
    properties.Add('Sequence');

    csv := properties.CommaText + sLineBreak;
    stream.Write(PChar(csv)^, Length(csv));
  finally
    FreeAndNil(properties);
  end;
end;

procedure TDebugTools.WriteCellDataHeaderCSV(const stream: TStream);
var
  csv: string;
  properties: TStringList;
begin
  properties := TStringList.Create;
  try
    properties.Add('CID');
    properties.Add('XID');
    properties.Add('MathID');
    properties.Add('ContextID');
    properties.Add('LocalContextID');
    properties.Add('ResponseID');
    properties.Add('Group');
    properties.Add('FormName');
    properties.Add('FormID');
    properties.Add('Page');
    properties.Add('Sequence');
    properties.Add('PageItem');
    properties.Add('References');

    csv := properties.CommaText + sLineBreak;
    stream.Write(PChar(csv)^, Length(csv));
  finally
    FreeAndNil(properties);
  end;
end;

class procedure TDebugTools.ExportCIDsCSV(const stream: TStream; const container: TContainer);
var
  cell: TBaseCell;
  csv: string;
  form: TDocForm;
  index: integer;
  page: TDocPage;
  properties: TStringList;
  references: TCIDReferences;
begin
  if not Assigned(stream) or not Assigned(container) then
    raise Exception.Create('Invalid parameter');

  PushMouseCursor(crHourglass);
  try
    Debugger.CountCIDReferences(container, references);
    properties := TStringList.Create;
    try
      Debugger.WriteCIDsHeaderCSV(stream);
      for index := 0 to Length(references) - 1 do
        begin
          properties.Clear;
          properties.Add(IntToStr(index));
          properties.Add(IntToStr(references[index]));

          if (references[index] > 0) then
            begin
              cell := container.GetCellByID(index);
              if Assigned(cell) then
                begin
                  page := (cell.FParentPage as TDocPage);
                  form := (page.FParentForm as TDocForm);
                  properties.Add(form.frmInfo.fFormName);
                  properties.Add(IntToStr(form.frmInfo.fFormUID));
                  properties.Add(IntToStr(form.frmPage.IndexOf(page) + 1));
                  properties.Add(IntToStr(cell.GetCellIndex));
                end
            end;

          csv := properties.CommaText + sLineBreak;
          stream.Write(PChar(csv)^, Length(csv));
        end;
    finally
      FreeAndNil(properties);
    end;
  finally
    PopMouseCursor;
  end;
end;

class procedure TDebugTools.ExportCellDataCSV(const stream: TStream; const container: TContainer);
var
  cell: TBaseCell;
  csv: string;
  form: TDocForm;
  indexCell: integer;
  indexForm: integer;
  indexPage: integer;
  page: TDocPage;
  properties: TStringList;
  references: TCIDReferences;
begin
  if not Assigned(stream) or not Assigned(container) then
    raise Exception.Create('Invalid parameter');

  PushMouseCursor(crHourglass);
  try
    Debugger.CountCIDReferences(container, references);
    properties := TStringList.Create;
    try
      Debugger.WriteCellDataHeaderCSV(stream);
      for indexForm := 0 to container.docForm.Count - 1 do
        begin
          form := container.docForm[indexForm];
          if Assigned(form.frmPage) then
            for indexPage := 0 to form.frmPage.Count - 1 do
              begin
                page := form.frmPage[indexPage];
                if Assigned(page.pgData) then
                  for indexCell := 0 to page.pgData.Count - 1 do
                    begin
                      properties.Clear;
                      cell := page.pgData[indexCell];
                      properties.Add(IntToStr(cell.FCellID));
                      properties.Add(IntToStr(cell.FCellXID));
                      properties.Add(IntToStr(cell.FMathID));
                      properties.Add(IntToStr(cell.FContextID));
                      properties.Add(IntToStr(cell.FLocalCTxID));
                      properties.Add(IntToStr(cell.FResponseID));
                      properties.Add(IntToStr(cell.FGroup));
                      properties.Add(form.frmInfo.fFormName);
                      properties.Add(IntToStr(form.frmInfo.fFormUID));
                      properties.Add(IntToStr(indexPage + 1));
                      properties.Add(IntToStr(indexCell + 1));
                      properties.Add(cell.ClassName);
                      properties.Add(IntToStr(references[cell.FCellID]));

                      csv := properties.CommaText + sLineBreak;
                      stream.Write(PChar(csv)^, Length(csv));
                    end;  // cell
              end;  // page
        end;  // form
    finally
      FreeAndNil(properties);
    end;
  finally
    PopMouseCursor;
  end;
end;

class function TDebugTools.Debugger: TDebugTools;
begin
  if not Assigned(Gdebugger) then
    Gdebugger := TDebugTools.Create;

  result := Gdebugger;
end;

procedure TDebugTools.AllocConsole;
const
  CUniqueTitle = '{328a559b-8eb0-4205-8cf0-79294d6419ab}';
begin
  Windows.AllocConsole;

  repeat
    SetConsoleTitle(PChar(CUniqueTitle));
    FConsoleHandle := FindWindow(nil, PChar(CUniqueTitle));
  until (FConsoleHandle <> 0) or Application.Terminated;
  SetConsoleTitle(PChar(Application.Title + ' - Console'));
end;

function TDebugTools.GetConsoleAllocated: Boolean;
begin
  Result := (FConsoleHandle <> 0);
end;

procedure TDebugTools.HideConsole;
begin
  if ConsoleAllocated then
    ShowWindow(FConsoleHandle, SW_HIDE);
end;

procedure TDebugTools.ShowConsole;
begin
  if not ConsoleAllocated then
    AllocConsole;

  ShowWindow(FConsoleHandle, SW_SHOW);
end;

/// summary: Alias for Dialogs.ShowMessage.
class procedure TDebugTools.ShowMessage(const Msg: String);
begin
  Dialogs.ShowMessage(Msg);
end;

class procedure TDebugTools.WriteLine(const Text: String);
begin
  if Debugger.ConsoleAllocated then
    WriteLn(text);
end;

// --- TApplicationDebugEvents ------------------------------------------------

procedure TApplicationDebugEvents.ProcessMessage(var Msg: TMsg; var Handled: Boolean);
begin
  if (Msg.Message = WM_KEYDOWN) then
    begin
      if FControlKeyDown and FShiftKeyDown and SameText(GetDomainName, 'ATBX') then
        case Msg.wParam of
          VK_F1:
            begin
              TDebugTools.Debugger.ShowConsole;
              TDebugTools.WriteLine(Application.Title + ' console activated.');
              Handled := True;
            end;

          VK_F2:
            begin
              TAdvancedFont.UIFont.AssignToControls(Screen.ActiveForm, False);
              Handled := True;
            end;
        end
      else
        begin
          if (Msg.wParam = VK_CONTROL) then
            FControlKeyDown := True
          else if (Msg.wParam = VK_SHIFT) then
            FShiftKeyDown := True;
        end;
    end
  else if (Msg.Message = WM_KEYUP) then
    begin
      if (Msg.wParam = VK_CONTROL) then
        FControlKeyDown := False
      else if (Msg.wParam = VK_SHIFT) then
        FShiftKeyDown := False;
    end;

  if Handled then
    FEvents.CancelDispatch;
end;

constructor TApplicationDebugEvents.Create(AOwner: TComponent);
begin
  inherited;
  FEvents := TApplicationEvents.Create(Self);
  FEvents.OnMessage := ProcessMessage;
end;

// --- Unit -------------------------------------------------------------------

function GetDomainName: String;
var
 PInfo: PWKSTA_INFO_100;
begin
  NetWkstaGetInfo(nil, 100, Pointer(PInfo));
  Result := PInfo.wki100_langroup;
  NetApiBufferFree(PInfo);
end;

initialization
  Gdebugger := nil;
  TApplicationDebugEvents.Create(Application);

finalization
  FreeAndNil(Gdebugger);

end.
