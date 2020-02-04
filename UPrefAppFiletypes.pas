unit UPrefAppFiletypes;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids_ts, TSGrid, ExtCtrls, StdCtrls, Registry, Buttons, IniFiles;

type
  clfFileAssociation = record
    extension: String;
    description: String;
    docType: String;
    end;

  TPrefAppFiletypes = class(TFrame)
    Panel1: TPanel;
    tsGrid: TtsGrid;
    gbAssociation: TGroupBox;
    lblExtension: TLabel;
    edtExt: TEdit;
    lblDesc: TLabel;
    edtDesc: TEdit;
    bbtnAdd: TBitBtn;
    bbtnEdit: TBitBtn;
    bbtnSave: TBitBtn;
    procedure tsGridClickCell(Sender: TObject; DataColDown, DataRowDown,
      DataColUp, DataRowUp: Integer; DownPos, UpPos: TtsClickPosition);
    procedure DisplayDataRow(DataRow: Integer);
    procedure SetGrpAndBtns(ItemID:Integer; SelRow: Integer=0);
    procedure bbtnEditClick(Sender: TObject);
    procedure bbtnAddClick(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
   private
    { Private declarations }
   public
    { Public declarations }
    constructor CreateFrame(AOwner: TComponent);
    procedure SetFileAssociations;
  end;

  function extractExePathFromRegValue(regString: String): String;
  function GetExePath(docType: String; var ExePath: String): Boolean;

implementation
uses
  UStatus, UGlobals;

const
  //document types and Registry Keys are hardcoded in ClickForms installer
  MaxStdAssociations = 6;
  docTypeClf = 'ClickForms.Document';
  docTypeOrder = 'OrderProcessor.Application';
  clfFileAssociations: Array[1..MaxStdAssociations] of clfFileAssociation = (
    (extension: '*.clk'; description: 'ClickFORMS Report'; docType: docTypeClf),
    (extension: '*.cft'; description: 'ClickFORMS Template'; docType: docTypeClf),
    (extension: '*.rxml'; description: 'CLVS XML Order'; docType: docTypeClf),
    (extension: '*.oxf'; description: 'Appraisal XML Order'; docType: docTypeClf),
    (extension: '*.uao'; description: 'Universal XML Order'; docType: docTypeOrder),
    (extension: '*.xap'; description: 'AppraisalPort, ETrack XML Orders'; docType: docTypeOrder)
     );

  colExt = 1;
  colDesc = 2;
  colStatus = 3;
  colDelete = 4;


  asterisk = '*';
  backslash = '\';
  exePathRegKey = '\shell\open\command';

  WEFileExtRegKey = '\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts';
  applString = 'Application';
  orderProcessorPath = '\Tools\Orders\OrderProcessor.exe';

{$R *.dfm}

//in windows Registry document command line looks like "exePath" "%1"
function extractExePathFromRegValue(regString: String): String;
const
  quote = '"';
var
  delim: Integer;
begin
  result := regstring;
  if length(result) = 0 then
    exit;
  delim := Pos(quote,result);
  if delim = 0 then
    exit;
  result := Copy(result,delim +1, length(result));
  if length(result) = 0 then
    exit;
  delim := Pos(quote,result);
  if delim > 0 then
    result :=  Copy(result,1,delim - 1);
end;

function GetExePath(docType: String; var ExePath: String): Boolean;
const
  //in present we use just 2 document type in Registry to associate file type
  clfRegKey = '\SOFTWARE\Bradford\ClickForms2';
  ClfRegPathName = 'Path';
var
  reg: TRegistry;
begin
  result := False;
  exePath := '';
  reg := TRegistry.Create;
  with reg do
  try
    RootKey := HKEY_LOCAL_MACHINE;
    if not OpenKey(clfRegKey,false) then
      exit;
    exePath := ReadString(ClfRegPathName);   //Clickforms Path
    if CompareText(docType,docTypeClf) = 0 then
      begin
        if FileExists(exePath) then
          result := True;
      end
    else
      if CompareText(docType, docTypeOrder) = 0 then
        begin
          exePath := ExtractFilePath(exePath) + OrderProcessorPath;
          if FileExists(exePath) then
            result := True;
        end;
  finally
    reg.Free;
  end;
end;

constructor TPrefAppFiletypes.CreateFrame(AOwner: TComponent);
const
  AssocSec = 'FileAssoc';
  Err = 'Error';
var
  AssocRow, index: integer;
  ClfIniFile: TInifile;
  RowStr, theExt, theDesc: String;
begin
  inherited Create(AOwner);
  with tsGrid do
    begin
      for index := low(clfFileAssociations) to high(clfFileAssociations) do
        begin
          if tsGrid.Rows < index then
            tsGrid.Rows := Succ(tsGrid.Rows);
          cell[colExt,index] := clfFileAssociations[index].extension;
          cell[colDesc,index] := clfFileAssociations[index].description;
          cellCheckBoxState[colStatus,index] := cbUnChecked;
          cellColor[colExt, index] := clInactiveBorder;
          cellReadOnly[colExt, index] := roOn;
          cellColor[colDesc, index] := clInactiveBorder;
          cellReadOnly[colDesc, index] := roOn;
          cellColor[colDelete, index] := clInactiveBorder;
          cellControlType[colDelete, index] := ctText;
          cellReadOnly[colDelete, index] := roOn;
        end;

        ClfIniFile := TIniFile.Create(IncludeTrailingPathDelimiter(appPref_DirPref) + cClickFormsINI);
        try
          AssocRow := 0;
          repeat
            AssocRow := Succ(AssocRow);
            RowStr := IntToStr(AssocRow);
            theExt := ClfIniFile.ReadString(AssocSec, ('Extension' + RowStr), Err);
            theDesc := ClfIniFile.ReadString(AssocSec, ('Description' + RowStr), Err);
            if (theExt <> '') and
               (theExt <> Err) and
               (theDesc <> '') and
               (theDesc <> Err) then
              begin
                tsGrid.Rows := tsGrid.Rows + 1;
                tsGrid.Cell[colExt, tsGrid.Rows] := theExt;
                tsGrid.Cell[colDesc, tsGrid.Rows] := theDesc;
                tsGrid.CellCheckBoxState[colStatus, tsGrid.Rows] := cbChecked;
                tsGrid.CellCheckBoxState[colDelete, tsGrid.Rows] := cbUnchecked;
              end;
          until (theExt = Err) or (theDesc = Err);
        finally
          ClfIniFile.Free;
        end;
      tsGrid.SelectRows(1, 1, True);
      DisplayDataRow(1);
    end;
end;

procedure TPrefAppFiletypes.SetFileAssociations;
const
  AssocSec = 'FileAssoc';
var
  reg: TRegistry;
  index: Integer;
  exePath: String;
  regKey: String;
  value: String;
  extStr: String;
  ClfIniFile: TIniFile;
  AssocRow, MaxAddRows: Integer;
  RowStr: String;
  DelOccurred: Boolean;

  function SetRegAssoc(theExt, theDocType: String; theReg: TRegistry; DelReg: Boolean): Boolean;
  begin
    Result := True;
    with theReg do
      begin
        //set document type
        RootKey := HKEY_CLASSES_ROOT;
        //remove asterick from extension
        regKey := StringReplace(theExt, asterisk, backslash,[]);
        if DelReg then
          theReg.DeleteKey(regKey)
        else
          begin
            OpenKey(regKey, true);
            WriteString('', theDocType);
            //set executable path
            CloseKey;
            GetExePath(theDocType, exePath);
            if not FileExists(exePath)  then
              begin
                ShowAlert(atWarnAlert, 'Cannot set the association with ' + theExt + ' files!');
                Result := False;
              end
            else
              begin
                regKey := Backslash + theDocType + exePathRegKey;
                openKey(regKey,true);
                value := '"' + exePath + '""%1"';
                WriteString('', value);
                //remove windows explore entry  if exists
                CloseKey;
                RootKey := HKEY_CURRENT_USER;
                //remove asterick from extension
                extStr := StringReplace(theExt, asterisk, backslash,[]);
                if OpenKey(WEFileExtRegKey + extStr, false) then
                  DeleteKey(WEFileExtRegKey + extStr);
              end;
          end;
      end;
  end;

begin
  reg := TRegistry.Create;
  try
    with reg do
      begin
        // Establish the standard and additional associations in the registry. Only
        //  establish additional associations if the "Set Assoc" box is checked AND
        //  the "Del Assoc" box is unchecked.
        for index := 1 to tsGrid.rows do
          if (tsGrid.CellCheckBoxState[colStatus,index] = cbChecked) then
            if (index <= MaxStdAssociations) then
              SetRegAssoc(clfFileAssociations[index].extension, clfFileAssociations[index].docType, reg, False)
            else
              if tsGrid.CellCheckBoxState[colDelete, index] = cbUnchecked then
                SetRegAssoc(tsGrid.Cell[colExt, index], docTypeClf, reg, False);
        ClfIniFile := TIniFile.Create(IncludeTrailingPathDelimiter(appPref_DirPref) + cClickFormsINI);
        try
          DelOccurred := False;
          // If the section exists remove it and we'll re-create the entire section
          //  if there are any additional associations
          if ClfIniFile.SectionExists(AssocSec) then
            ClfIniFile.EraseSection(AssocSec);
          if tsGrid.Rows > MaxStdAssociations then
            begin
              // Delete the rows from the grid before updating the INI file so the
              //  Extension and Description ident numbers will be in 1..n order
              AssocRow := tsGrid.Rows;
              repeat
                if tsGrid.CellCheckBoxState[colDelete, AssocRow] = cbChecked then
                  begin
                    DelOccurred := True;
                    SetRegAssoc(tsGrid.Cell[colExt, AssocRow], docTypeClf, reg, True);
                    tsGrid.DeleteRows(AssocRow, AssocRow);
                  end;
                AssocRow := Pred(AssocRow);
              until AssocRow = MaxStdAssociations;
              MaxAddRows := tsGrid.Rows - MaxStdAssociations;
              // If there are still rows beyond the standard associations then save
              //  the Extension and Description to the INI file.
              if MaxAddRows > 0 then
                begin
                  AssocRow := 0;
                  repeat
                    AssocRow := Succ(AssocRow);
                    RowStr := IntToStr(AssocRow);
                    if tsGrid.CellCheckBoxState[colDelete, (AssocRow + MaxStdAssociations)] = cbChecked then
                      begin
                        ClfIniFile.DeleteKey(AssocSec, ('Extension' + RowStr));
                        ClfIniFile.DeleteKey(AssocSec, ('Description' + RowStr));
                      end
                    else
                      begin
                        ClfIniFile.WriteString(AssocSec, ('Extension' + RowStr), tsGrid.Cell[colExt, (AssocRow + MaxStdAssociations)]);
                        ClfIniFile.WriteString(AssocSec, ('Description' + RowStr), tsGrid.Cell[colDesc, (AssocRow + MaxStdAssociations)]);
                      end;
                  until AssocRow = MaxAddRows;
                end;
              // If we deleted any rows then reposition to and display row number 1
              if DelOccurred then
                begin
                  tsGrid.SelectRows(1, 1, True);
                  DisplayDataRow(1);
                end;
            end;
        finally
          ClfIniFile.Free;
        end;
      end;
  finally
    reg.Free;
  end;
end;

procedure TPrefAppFiletypes.tsGridClickCell(Sender: TObject; DataColDown,
  DataRowDown, DataColUp, DataRowUp: Integer; DownPos,
  UpPos: TtsClickPosition);
begin
  DisplayDataRow(DataRowDown);
  {gbAssociation.Tag := DataRowDown;
  SetGrpAndBtns(0, DataRowDown);
  edtExt.Text := tsGrid.Cell[colExt, DataRowDown];
  edtDesc.Text := tsGrid.Cell[colDesc, DataRowDown];
  if gbAssociation.Tag <= MaxStdAssociations then
    tsGrid.Cell[colDelete, gbAssociation.Tag] := '';}
end;

procedure TPrefAppFiletypes.DisplayDataRow(DataRow: Integer);
begin
  gbAssociation.Tag := DataRow;
  SetGrpAndBtns(0, DataRow);
  edtExt.Text := tsGrid.Cell[colExt, DataRow];
  edtDesc.Text := tsGrid.Cell[colDesc, DataRow];
  if gbAssociation.Tag <= MaxStdAssociations then
    tsGrid.Cell[colDelete, gbAssociation.Tag] := '';
end;

procedure TPrefAppFiletypes.SetGrpAndBtns(ItemID:Integer; SelRow: Integer=0);

  procedure EnDisBtns(AddState, EditState, SaveState: Boolean);
  begin
    bbtnAdd.Enabled := AddState;
    bbtnEdit.Enabled := EditState;
    bbtnSave.Enabled := SaveState;
    edtExt.Enabled := SaveState;
    edtDesc.Enabled := SaveState;
  end;

begin
  case ItemID of
    0:
      begin
        gbAssociation.Caption := 'Displaying the Selected Association';
        EnDisBtns(True, (SelRow > MaxStdAssociations), False);
      end;
    1:
      begin
        gbAssociation.Caption := 'Edit the Selected Association';
        EnDisBtns(False, False, True);
        edtExt.SetFocus;
      end;
    2:
      begin
        gbAssociation.Caption := 'Add a New Association';
        edtExt.Text := '';
        edtDesc.Text := '';
        gbAssociation.Tag := 0;
        EnDisBtns(False, False, True);
        edtExt.SetFocus;
      end;
  end;
end;

procedure TPrefAppFiletypes.bbtnEditClick(Sender: TObject);
begin
  SetGrpAndBtns(bbtnEdit.Tag);
end;

procedure TPrefAppFiletypes.bbtnAddClick(Sender: TObject);
begin
  SetGrpAndBtns(bbtnAdd.Tag);
end;

procedure TPrefAppFiletypes.bbtnSaveClick(Sender: TObject);
begin
  if gbAssociation.Tag > 0 then
    begin
      tsGrid.Cell[colExt, gbAssociation.Tag] := edtExt.Text;
      tsGrid.Cell[colDesc, gbAssociation.Tag] := edtDesc.Text;
      tsGrid.CellCheckBoxState[colStatus, gbAssociation.Tag] := cbChecked;
      tsGrid.CellCheckBoxState[colDelete, gbAssociation.Tag] := cbUnchecked;
    end
  else
    begin
      tsGrid.Rows := tsGrid.Rows + 1;
      tsGrid.Cell[colExt, tsGrid.Rows] := edtExt.Text;
      tsGrid.Cell[colDesc, tsGrid.Rows] := edtDesc.Text;
      tsGrid.CellCheckBoxState[colStatus, tsGrid.Rows] := cbChecked;
      tsGrid.CellCheckBoxState[colDelete, tsGrid.Rows] := cbUnchecked;
    end;
  SetGrpAndBtns(0);
end;

end.
