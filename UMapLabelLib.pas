unit UMapLabelLib;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted 2003 by Bradford Technologies, Inc. }


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ToolWin, ImgList, RzButton, ExtCtrls,
  RzPanel, UForms;

{ -- NOTE -- }

  //Each Label is identifed by FRefID and FCatID.
  //The FRefID is 0,1,2,3...;
  //The FCatID indicates if the category the property is in: Comps, Rentals, etc.
  //The Subecjt is always FRefID = 0 and FCatID = 0;

type
  TMapLabelLib = class(TAdvancedForm)
    ToolBar1: TToolBar;
    tbtnRed: TToolButton;
    tbtnYellow: TToolButton;
    tbtnWhite: TToolButton;
    tbtnTrash: TToolButton;
    tbtnColors: TToolButton;
    tbtnNewLabel: TToolButton;
    LabelList: TListBox;
    ImageList1: TImageList;
    ColorDialog: TColorDialog;
    RzStatusBar1: TRzStatusBar;
    btnRestoreDefaults: TRzButton;
    procedure LabelListDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure LabelListStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tbtnNewLabelClick(Sender: TObject);
    procedure tbtnTrashClick(Sender: TObject);
    procedure tbtnColorPickerClick(Sender: TObject);
    procedure tbtnChangeColorClick(Sender: TObject);
    procedure btnRestoreDefaultsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FModified: Boolean;
    procedure ReadFromStream(Stream: TStream);
    procedure WriteToStream(Stream: TStream);
    procedure SetModified(const Value: Boolean);
    function CanRestoreDefaults: Boolean;
  protected
    function GetLabel(LabelCategory, LabelID: Integer): TObject;
    procedure SaveToFile(const FileName: String);
    procedure LoadFromFile(const fileName: String);
  public
    constructor Create(AOwner: TComponent); override;
    procedure LoadDefaultList;
    procedure LoadCustomLabels;
    procedure SaveCustomLabels;
    function GetMapLabelColor(LabelCategory, LabelID: Integer): TColor;
    property Modified: Boolean read FModified write SetModified;
  end;

var
  MapLabelLibrary: TMapLabelLib;



implementation

uses
  UGlobals, UUtil1, UDrag, UPgAnnotation, UStatus, UFileGlobals, UFileUtils,
  UMapUtils;


const
  ReservedLabelCount = 20;
  cMapLabelVersion   = 1;
  cMapLabelFileName  = 'MapLabelList.lst';

type
  TLabelInfo = class(TObject)
    FName: String;
    FRefID: Integer;
    FCatID: Integer;
    FColor: TColor;
    FAngle: Integer;       //if -1 use default orientation
    FShape: Integer;       //reserved
  end;



{$R *.dfm}

constructor TMapLabelLib.Create(AOwner: TComponent);
var
  Control: TControl;
  dpiX: Integer;
  dpiY: Integer;
begin
  inherited Create(AOwner);
  SettingsName := CFormSettings_MapLabelLib;

  // default position
  if Assigned(Owner) and (Owner is TControl) then
    begin
      Control := Owner as TControl;
      dpiX := GetDeviceCaps(Canvas.Handle, LOGPIXELSX);
      dpiY := GetDeviceCaps(Canvas.Handle, LOGPIXELSY);
      Left := Control.Left + Control.Width - Trunc(dpiX * 2) - (dpiX div 2);
      Top := Control.Top + dpiY;
      Width := Trunc(dpiX * 2);
    end;

  if LabelList.Items.count > 0 then       //if we have a list
    LabelList.ItemIndex := 0;             //select the first one

  LabelList.clear;
  LoadCustomLabels;
end;

procedure TMapLabelLib.LabelListDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  offset: Integer;
  Pts: Array of TPoint;
begin
  SetLength(Pts, 5);
  offset := 25;
	with (Control as TListBox).Canvas do  { draw on control canvas, not on the form }
    begin
      FillRect(Rect);             //clear the rectangle
      InflateRect(Rect, -1,-2);   //add some margin
      Rect.Right := 120;

      Pen.Color := clBlack;
      Pen.Width := 1;
      Pen.Style := psSolid;
      Brush.Color := TLabelInfo(LabelList.Items.Objects[Index]).FColor;
      Brush.Style := bsSolid;
      Pts[0] := Point(Rect.Left, (Rect.Top+Rect.Bottom) div 2);
      Pts[1] := Point(Rect.left+20, Rect.bottom);
      Pts[2] := Point(Rect.right, Rect.bottom);
      Pts[3] := Point(Rect.right, Rect.top);
      Pts[4] := Point(Rect.left+20, Rect.top);
      Polygon(Pts);

      Font.Style := [fsBold];
      Brush.Style := bsClear;
      if odSelected in State then    //force black when hilighted
        Font.Color := clBlack;
      TextOut(Rect.Left + Offset, Rect.Top, (Control as TListBox).Items[Index]);
    end;
  Finalize(Pts);
end;

procedure TMapLabelLib.LabelListStartDrag(Sender: TObject; var DragObject: TDragObject);
var
  MapLabel: TDragLabel;
  iSelected: Integer;
begin
  iSelected := (Sender as TListBox).ItemIndex;
  if iSelected < (Sender as TListBox).Items.Count then
    begin
      //put doc into if FActiveLayer = alStdEntry then
      MapLabel := TDragLabel.Create;
      MapLabel.FLabelType := muMapPtr1;
      MapLabel.FLabelID := TLabelInfo(LabelList.Items.Objects[iSelected]).FRefID;
      MapLabel.FLabelCatID := TLabelInfo(LabelList.Items.Objects[iSelected]).FCatID;
      MapLabel.FLabelText := (Sender as TListBox).Items[iSelected];
      MapLabel.FLabelColor := TLabelInfo(LabelList.Items.Objects[iSelected]).FColor;
      if TLabelInfo(LabelList.Items.Objects[iSelected]).FAngle > 0 then
        MapLabel.FLabelAngle := TLabelInfo(LabelList.Items.Objects[iSelected]).FAngle;
      MapLabel.FLabelShape := 0;

      DragObject := MapLabel;
    end;
end;

//Closing or Hiding the Labrary
procedure TMapLabelLib.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  if Application.Terminated then
    Action := caFree
	else
    Action := caHide;

  SaveCustomLabels;
end;

//When it re-appears or is shown for the first time
procedure TMapLabelLib.FormShow(Sender: TObject);
begin
  Modified := CanRestoreDefaults;
end;

procedure TMapLabelLib.ReadFromStream(Stream: TStream);
var
  N, Count: Integer;
  ALabel: TLabelInfo;
begin
  ReadLongFromStream(Stream);    // version: do nothing with it for now
  count := ReadLongFromStream(Stream);      //number of labels saved

  for n := 0 to count -1 do
    begin
      ALabel := TLabelInfo.Create;
      ALabel.FName := ReadStringFromStream(Stream);
      ALabel.FRefID := ReadLongFromStream(Stream);
      ALabel.FCatID := ReadLongFromStream(Stream);
      ALabel.FColor := ReadLongFromStream(Stream);
      ALabel.FAngle := ReadLongFromStream(Stream);
      ALabel.FShape := ReadLongFromStream(Stream);
      LabelList.Items.AddObject(ALabel.FName, ALabel);
    end;
end;

procedure TMapLabelLib.WriteToStream(Stream: TStream);
var
  n, Count: Integer;
begin
  WriteLongToStream(cMapLabelVersion, stream);        //write version #

  Count := LabelList.Items.Count;
  WriteLongToStream(LabelList.Items.Count, Stream);   //write num of labels

  for n := 0 to Count-1 do                            //write each map label
    with TLabelInfo(LabelList.Items.Objects[n]) do
      begin
        WriteStringToStream(FName, Stream);
        WriteLongToStream(FRefID, Stream);
        WriteLongToStream(FCatID, Stream);
        WriteLongToStream(FColor, Stream);
        WriteLongToStream(FAngle, Stream);
        WriteLongToStream(FShape, Stream);
      end;
end;

procedure TMapLabelLib.SaveToFile(const FileName: String);
var
  fStream: TFileStream;
begin
  fStream := TFileStream.Create(FileName, fmCreate);
  try
    WriteGenericIDHeader(fStream, cLISTFile);
    WriteToStream(fStream);
  finally
    fStream.Free;
  end;
end;

procedure TMapLabelLib.LoadFromFile(const fileName: String);
var
  fStream: TFileStream;
  GH: GenericIDHeader;
begin
  fStream := TFileStream.Create(FileName, fmOpenRead);
  try
    try
      ReadGenericIDHeader(fStream, GH);
      ReadFromStream(fStream);
    except
      ShowNotice('Could not read the Map Label Library file: '+ ExtractFileName(fileName));
    end;
  finally
    fStream.Free;
  end;
end;

procedure TMapLabelLib.SaveCustomLabels;
var
  fPath: String;
begin
  if FModified then
  try
    fPath := IncludeTrailingPathDelimiter(appPref_DirLists) + cMapLabelFileName;

    SaveToFile(fPath);
    Modified := False;
  except
    ShowNotice('There was a problem saving the list of Map Labels.');
  end;
end;

procedure TMapLabelLib.LoadCustomLabels;
var
  fPath: String;
begin
  try
    fPath := IncludeTrailingPathDelimiter(appPref_DirLists) + cMapLabelFileName;
    if not FileExists(fPath) then
      LoadDefaultList
    else
      LoadFromFile(fPath);
  except
    ShowNotice('There was a problem reading the list of Map Labels.');

    LoadDefaultList;   //problems revert to Defaults
  end;
end;

procedure TMapLabelLib.tbtnChangeColorClick(Sender: TObject);
var
  ClIndex, LabelIndex: Integer;
  newColor, curColor: TColor;
begin
  ClIndex := TToolButton(Sender).Tag;
  LabelIndex := LabelList.ItemIndex;

  if LabelIndex > -1 then
    begin
      case clIndex of
        1: newColor := clRed;
        2: newColor := clYellow;
        3: newColor := clWhite;
      else
        newColor := clRed;
      end;

      curColor :=  TLabelInfo(LabelList.Items.Objects[LabelIndex]).FColor;

      if newColor <> curColor then
        begin
          TLabelInfo(LabelList.Items.Objects[LabelIndex]).FColor := newColor;
          LabelList.Invalidate;
          Modified := True;
        end;
    end;
end;

procedure TMapLabelLib.tbtnColorPickerClick(Sender: TObject);
var
  LabelIndex: Integer;
begin
  if LabelList.ItemIndex > -1 then
    if ColorDialog.execute then
      begin
        LabelIndex := LabelList.ItemIndex;
        TLabelInfo(LabelList.Items.Objects[LabelIndex]).FColor := ColorDialog.color;
        Modified := True;
        LabelList.Invalidate;
      end;
end;

procedure TMapLabelLib.tbtnNewLabelClick(Sender: TObject);
var
  AName: String;
  ALabel: TLabelInfo;
begin
  AName := GetAName('New Map Label Title', 'Untitled');
  if Length(AName) > 0 then
    begin
      ALabel := TLabelInfo.Create;
      ALabel.FName := AName;
      ALabel.FRefID := 0;
      ALabel.FCatID := lcCUST;
      ALabel.FColor := clWhite;
      ALabel.FAngle := -1;
      LabelList.Items.AddObject(ALabel.FName, ALabel);

      LabelList.Invalidate;
      Modified := True;
    end;
end;

procedure TMapLabelLib.tbtnTrashClick(Sender: TObject);
begin
  if (LabelList.ItemIndex > -1) then
    if LabelList.ItemIndex < ReservedLabelCount then //itemIndex is zero based
      ShowNotice('You can only delete Map Labels that you have created.')
    else begin
      LabelList.Items.Delete(LabelList.ItemIndex);
      Modified := True;
    end
  else
    ShowNotice('Select a Map Label before attempting to delete it.');
end;

procedure TMapLabelLib.LoadDefaultList;
var
  ALabel: TLabelInfo;
begin
  LabelList.Clear;

  ALabel := TLabelInfo.Create;
  ALabel.FName := 'SUBJECT';
  ALabel.FRefID := 0;
  ALabel.FCatID := 0;
  ALabel.FColor := clRed;
  ALabel.FAngle := -1;
  ALabel.FShape := 0;
  LabelList.Items.AddObject(ALabel.FName, ALabel);

//Comps & Sales
  ALabel := TLabelInfo.Create;
  ALabel.FName := 'COMP 1';
  ALabel.FRefID := 1;
  ALabel.FCatID := lcCOMP;
  ALabel.FColor := clYellow;
  ALabel.FAngle := -1;
  ALabel.FShape := 0;
  LabelList.Items.AddObject(ALabel.FName, ALabel);

  ALabel := TLabelInfo.Create;
  ALabel.FName := 'COMP 2';
  ALabel.FRefID := 2;
  ALabel.FCatID := lcCOMP;
  ALabel.FColor := clYellow;
  ALabel.FAngle := -1;
  ALabel.FShape := 0;
  LabelList.Items.AddObject(ALabel.FName, ALabel);

  ALabel := TLabelInfo.Create;
  ALabel.FName := 'COMP 3';
  ALabel.FRefID := 3;
  ALabel.FCatID := lcCOMP;
  ALabel.FColor := clYellow;
  ALabel.FAngle := -1;
  ALabel.FShape := 0;
  LabelList.Items.AddObject(ALabel.FName, ALabel);

  ALabel := TLabelInfo.Create;
  ALabel.FName := 'COMP 4';
  ALabel.FRefID := 4;
  ALabel.FCatID := lcCOMP;
  ALabel.FColor := clYellow;
  ALabel.FAngle := -1;
  ALabel.FShape := 0;
  LabelList.Items.AddObject(ALabel.FName, ALabel);

  ALabel := TLabelInfo.Create;
  ALabel.FName := 'COMP 5';
  ALabel.FRefID := 5;
  ALabel.FCatID := lcCOMP;
  ALabel.FColor := clYellow;
  ALabel.FAngle := -1;
  ALabel.FShape := 0;
  LabelList.Items.AddObject(ALabel.FName, ALabel);

  ALabel := TLabelInfo.Create;
  ALabel.FName := 'COMP 6';
  ALabel.FRefID := 6;
  ALabel.FCatID := lcCOMP;
  ALabel.FColor := clYellow;
  ALabel.FAngle := -1;
  ALabel.FShape := 0;
  LabelList.Items.AddObject(ALabel.FName, ALabel);

//Rentals
  ALabel := TLabelInfo.Create;
  ALabel.FName := 'RENTAL 1';
  ALabel.FRefID := 1;
  ALabel.FCatID := lcRENT;
  ALabel.FColor := colorLabelRental;
  ALabel.FAngle := -1;
  ALabel.FShape := 0;
  LabelList.Items.AddObject(ALabel.FName, ALabel);

  ALabel := TLabelInfo.Create;
  ALabel.FName := 'RENTAL 2';
  ALabel.FRefID := 2;
  ALabel.FCatID := lcRENT;
  ALabel.FColor := colorLabelRental;
  ALabel.FAngle := -1;
  ALabel.FShape := 0;
  LabelList.Items.AddObject(ALabel.FName, ALabel);

  ALabel := TLabelInfo.Create;
  ALabel.FName := 'RENTAL 3';
  ALabel.FRefID := 3;
  ALabel.FCatID := lcRENT;
  ALabel.FColor := colorLabelRental;
  ALabel.FAngle := -1;
  ALabel.FShape := 0;
  LabelList.Items.AddObject(ALabel.FName, ALabel);

  ALabel := TLabelInfo.Create;
  ALabel.FName := 'RENTAL 4';
  ALabel.FRefID := 4;
  ALabel.FCatID := lcRENT;
  ALabel.FColor := colorLabelRental;
  ALabel.FAngle := -1;
  ALabel.FShape := 0;
  LabelList.Items.AddObject(ALabel.FName, ALabel);

  ALabel := TLabelInfo.Create;
  ALabel.FName := 'RENTAL 5';
  ALabel.FRefID := 5;
  ALabel.FCatID := lcRENT;
  ALabel.FColor := colorLabelRental;
  ALabel.FAngle := -1;
  ALabel.FShape := 0;
  LabelList.Items.AddObject(ALabel.FName, ALabel);

  ALabel := TLabelInfo.Create;
  ALabel.FName := 'RENTAL 6';
  ALabel.FRefID := 6;
  ALabel.FCatID := lcRENT;
  ALabel.FColor := colorLabelRental;
  ALabel.FAngle := -1;
  ALabel.FShape := 0;
  LabelList.Items.AddObject(ALabel.FName, ALabel);

//Listings
  ALabel := TLabelInfo.Create;
  ALabel.FName := 'LISTING 1';
  ALabel.FRefID := 1;
  ALabel.FCatID := lcLIST;
  ALabel.FColor := colorLabelListing;
  ALabel.FAngle := -1;
  ALabel.FShape := 0;
  LabelList.Items.AddObject(ALabel.FName, ALabel);

  ALabel := TLabelInfo.Create;
  ALabel.FName := 'LISTING 2';
  ALabel.FRefID := 2;
  ALabel.FCatID := lcLIST;
  ALabel.FColor := colorLabelListing;
  ALabel.FAngle := -1;
  ALabel.FShape := 0;
  LabelList.Items.AddObject(ALabel.FName, ALabel);

  ALabel := TLabelInfo.Create;
  ALabel.FName := 'LISTING 3';
  ALabel.FRefID := 3;
  ALabel.FCatID := lcLIST;
  ALabel.FColor := colorLabelListing;
  ALabel.FAngle := -1;
  ALabel.FShape := 0;
  LabelList.Items.AddObject(ALabel.FName, ALabel);

  ALabel := TLabelInfo.Create;
  ALabel.FName := 'LISTING 4';
  ALabel.FRefID := 4;
  ALabel.FCatID := lcLIST;
  ALabel.FColor := colorLabelListing;
  ALabel.FAngle := -1;
  ALabel.FShape := 0;
  LabelList.Items.AddObject(ALabel.FName, ALabel);

  ALabel := TLabelInfo.Create;
  ALabel.FName := 'LISTING 5';
  ALabel.FRefID := 5;
  ALabel.FCatID := lcLIST;
  ALabel.FColor := colorLabelListing;
  ALabel.FAngle := -1;
  ALabel.FShape := 0;
  LabelList.Items.AddObject(ALabel.FName, ALabel);

  ALabel := TLabelInfo.Create;
  ALabel.FName := 'LISTING 6';
  ALabel.FRefID := 6;
  ALabel.FCatID := lcLIST;
  ALabel.FColor := colorLabelListing;
  ALabel.FAngle := -1;
  ALabel.FShape := 0;
  LabelList.Items.AddObject(ALabel.FName, ALabel);

  ALabel := TLabelInfo.Create;
  ALabel.FName := 'NORTH';
  ALabel.FRefID := 0;
  ALabel.FCatID := lcCUST;
  ALabel.FColor := clWhite;
  ALabel.FAngle := 270;
  ALabel.FShape := 0;
  LabelList.Items.AddObject(ALabel.FName, ALabel);

  LabelList.ItemIndex := 0;
  Modified := False;
end;

procedure TMapLabelLib.btnRestoreDefaultsClick(Sender: TObject);
var
  fPath: String;
begin
  LoadDefaultList;

  //loaded the defaults, delete custom file so we don't read it in
  fPath := IncludeTrailingPathDelimiter(appPref_DirLists) + cMapLabelFileName;
  if FileExists(fPath) then
    DeleteFile(fPath);
end;

procedure TMapLabelLib.SetModified(const Value: Boolean);
begin
  FModified := Value;
  btnRestoreDefaults.Enabled := Value;
end;

function TMapLabelLib.CanRestoreDefaults: Boolean;
begin
  result := FileExists(IncludeTrailingPathDelimiter(appPref_DirLists) + cMapLabelFileName);
end;

function TMapLabelLib.GetLabel(LabelCategory, LabelID: Integer): TObject;
var
  i: Integer;
  ALabel: TLabelInfo;
begin
  result := nil;
  i := 0;
  while (i < LabelList.Items.Count) and not assigned(result) do
    begin
      ALabel := TLabelInfo(LabelList.Items.Objects[i]);
      if (ALabel.FRefID = LabelID) and (ALabel.FCatID = LabelCategory) then
        result := ALabel;
      inc(i);
    end;
end;

function TMapLabelLib.GetMapLabelColor(LabelCategory, LabelID: Integer): TColor;
var
  ALabel: TLabelInfo;
begin
  result := clYellow;    //default

  ALabel := TLabelInfo(GetLabel(LabelCategory, LabelID));
  if assigned(ALabel) then
    result := ALabel.FColor;
end;

end.
