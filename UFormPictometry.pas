
{
  ClickFORMS
  (C) Copyright 1998 - 2010, Bradford Technologies, Inc.
  All Rights Reserved.

  Purpose: A form for interfacing with the Pictometry imagery service.
}

unit UFormPictometry;

interface

uses
  ActnList,
  Classes,
  Controls,
  ExtCtrls,
  StdCtrls,
  UContainer,
  UForms,
  UGridMgr,
  uCell,
//  uGeoCoder,
  uUtil2,
  uForm,
  uStatus,
  uStrings;

type

  AddrInfo = record  //structure to hold lat/lon and address info
    Lat: String;
    Lon: String;
    StreetNum: String;
    StreetName: String;
    City: String;
    State: String;
    Zip: String;
    UnitNo: String;
  end;

  /// summary: A form for interfacing with the Pictometry imagery service.
  TPictometryForm = class(TVistaAdvancedForm)
    LabelStreet: TLabel;
    LabelCity: TLabel;
    LabelState: TLabel;
    LabelZip: TLabel;
    EditStreet: TEdit;
    EditCity: TEdit;
    EditState: TEdit;
    EditZip: TEdit;
    ButtonSearchByAddress: TButton;
    ActionList: TActionList;
    ActionSearchByAddress: TAction;
    ActionCancel: TAction;
    ButtonCancel: TButton;
    PanelImages: TPanel;
    ImageNorth: TImage;
    ImageEast: TImage;
    ImageSouth: TImage;
    ImageWest: TImage;
    ShapeImageNorth: TShape;
    ShapeImageEast: TShape;
    ShapeImageSouth: TShape;
    ShapeImageWest: TShape;
    ActionTransfer: TAction;
    PanelAddress: TPanel;
    ButtonTransfer: TButton;
    ShapeImageOrthogonal: TShape;
    ImageOrthogonal: TImage;
    LabelSouth: TLabel;
    LabelNorth: TLabel;
    LabelEast: TLabel;
    LabelWest: TLabel;
    RadioButtonFrontNorth: TRadioButton;
    RadioButtonFrontEast: TRadioButton;
    RadioButtonFrontSouth: TRadioButton;
    RadioButtonFrontWest: TRadioButton;
    LabelOverhead: TLabel;
    LabelSelectFrontImage: TLabel;
    procedure ActionCancelExecute(Sender: TObject);
    procedure ActionCancelUpdate(Sender: TObject);
    procedure ActionSearchByAddressUpdate(Sender: TObject);
    procedure ActionTransferUpdate(Sender: TObject);
    procedure EditAddressChange(Sender: TObject);
  private
    FAddressChanged: Boolean;
    FDocument: TContainer;
//    procedure GetGEOCode(var prop: AddrInfo);

  public
    FImagesLoaded: Boolean;
    procedure LoadFormData(const Document: TContainer);
    function LoadFormImages(const Orthogonal: TStream; const North: TStream; const South: TStream; const West: TStream; const East: TStream): Integer;
//    procedure GetSubjectLatLon(var Lat,Lon: Double);
    procedure TransferParcelViewToReport(ParcelImageView: WideString);
  end;

implementation

{$R *.dfm}

uses
  Jpeg,
  SysUtils,
  UGlobals, UMain;

// *** TPictometryForm *******************************************************

/// summary: Closes the form.
procedure TPictometryForm.ActionCancelExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
  Close;
end;

/// summary: Updates the cancel action.
procedure TPictometryForm.ActionCancelUpdate(Sender: TObject);
var
  Action: TAction;
begin
  if Assigned(Sender) and (Sender is TAction) then
    begin
      Action := Sender as TAction;
      Action.Enabled := True;
    end;
end;

/// summary: Updates the search by address action.
procedure TPictometryForm.ActionSearchByAddressUpdate(Sender: TObject);
var
  Action: TAction;
  Enabled: Boolean;
begin
  if Assigned(Sender) and (Sender is TAction) then
    begin
      Action := Sender as TAction;

      Enabled := FAddressChanged;
      Enabled := Enabled and (EditStreet.Text <> '');
      Enabled := Enabled and (EditCity.Text <> '');
      Enabled := Enabled and (EditState.Text <> '');
      Enabled := Enabled and (EditZip.Text <> '');
      Enabled := Enabled and (TMethod(Action.OnExecute).Code <> nil);
      Action.Enabled := Enabled;
    end;
end;

/// summary: Updates the transfer action.
procedure TPictometryForm.ActionTransferUpdate(Sender: TObject);
var
  Action: TAction;
  Enabled: Boolean;
begin
  if Assigned(Sender) and (Sender is TAction) then
    begin
      Action := Sender as TAction;

      Enabled := False;
      Enabled := Enabled or RadioButtonFrontNorth.Checked;
      Enabled := Enabled or RadioButtonFrontEast.Checked;
      Enabled := Enabled or RadioButtonFrontSouth.Checked;
      Enabled := Enabled or RadioButtonFrontWest.Checked;
      Enabled := Enabled and FImagesLoaded;
      Enabled := Enabled and (TMethod(Action.OnExecute).Code <> nil);
      Action.Enabled := Enabled;
    end;
end;

/// summary: Flags the address as changed when the address has been changed.
procedure TPictometryForm.EditAddressChange(Sender: TObject);
begin
  FAddressChanged := True;
end;

/// summary: Loads data into the form from the document.
procedure TPictometryForm.LoadFormData(const Document: TContainer);
const
  CellID_Address = CSubjectAddressCellID;
  CellID_City = 47;
  CellID_State = 48;
  CellID_Zip = 49;
begin
  if Assigned(Document) then
    begin
      FDocument := Document;
      EditStreet.Text := Document.GetCellTextByID(CellID_Address);
      EditCity.Text := Document.GetCellTextByID(CellID_City);
      EditState.Text := Document.GetCellTextByID(CellID_State);
      EditZip.Text := Document.GetCellTextByID(CellID_Zip);
      FAddressChanged := True;
    end
  else
    begin
      EditStreet.Text := '';
      EditCity.Text := '';
      EditState.Text := '';
      EditZip.Text := '';
      FAddressChanged := False;
    end
end;


/// summary: Loads images into the form from the specified JPEG streams.
function TPictometryForm.LoadFormImages(const Orthogonal: TStream; const North: TStream; const South: TStream; const West: TStream; const East: TStream): Integer;
 function LoadImage(const Stream: TStream; const Image: TImage): Boolean;
  var
    TempImage: TJpegImage;
  begin
    result := false;
    if Assigned(Stream) and (stream.Size > 0) and Assigned(Image) then
      begin
        TempImage := TJpegImage.Create;
        try
          TempImage.LoadFromStream(Stream);
          Image.Picture.Graphic := TempImage; // copy
          FImagesLoaded := True;
        finally
          FreeAndNIl(TempImage);
        end;
        result := true;
      end
    else
      Image.Picture.Graphic := nil;
  end;
begin
  result := 0;
  FAddressChanged := False;
  FImagesLoaded := False;
  if LoadImage(Orthogonal, ImageOrthogonal) then inc(result);
  if LoadImage(North, ImageNorth) then inc(result);
  if LoadImage(South, ImageSouth) then inc(result);
  if LoadImage(West, ImageWest) then inc(result);
  if LoadImage(East, ImageEast) then inc(result);;
end;

function GetFullAddress(sNum,sName,sCity,sState,sZip: String):String;
begin
  result := Format('%s %s %s, %s %s',[sNum, sName, sCity, sState, sZip]);
end;

(*
procedure TPictometryForm.GetGEOCode(var prop: AddrInfo);
var
  geoCoder: TGeoCoder;
  FullAddress, accuracy: String;
begin
    GeoCoder := TGeoCoder.Create(nil);
    try
      FullAddress := GetFullAddress(prop.StreetNum,prop.StreetName,prop.City,prop.State,prop.Zip);
      GeoCoder.GetGeoCodeProperty(FullAddress, accuracy, prop.lat, prop.lon);
    finally
      GeoCoder.Free;
    end;
end;
*)
{
procedure TPictometryForm.GetSubjectLatLon(var Lat, Lon: Double);
const
   gtSales   = 1;

var
  SubjCol: TCompColumn;
  DocCompTable: TCompMgr2;         //Grid Mgr for the report tables

  GeoCodedCell: TGeocodedGridCell;
  prop: AddrInfo;
  NeedGeoCode: Boolean;
  Street, CityStZip: String;
begin
  prop.StreetName := editStreet.Text;
  prop.City := EditCity.Text;
  prop.State := EditState.Text;
  prop.Zip := EditZip.Text;
  try
(*  User may change the address from original to new one, always use the one on the edit box.
    if assigned(FDocument) then
      begin
        DocCompTable := TCompMgr2.Create(True);
        DocCompTable.BuildGrid(FDocument, gtSales);
        if (DocCompTable = nil) then exit;
        if Assigned(DocCompTable) and (DocCompTable.Count > 0) then
          SubjCol := DocCompTable.Comp[0];    //subject column

        if assigned(SubjCol) and not SubjCol.IsEmpty then
          begin
            Street    := SubjCol.GetCellTextByID(925);
            CityStZip := SubjCol.GetCellTextByID(926);
            if POS(prop.StreetName, trim(street)) > 0 then
              // Get report subject geocodes
              if (SubjCol.GetCellByID(CGeocodedGridCellID) is TGeocodedGridCell) then
                begin
                  GeocodedCell := SubjCol.GetCellByID(CGeocodedGridCellID) as TGeocodedGridCell;
                  lat := GeocodedCell.Latitude;
                  lon := GeocodedCell.Longitude;
                end;
          end;
        end;
*)
    Lat := 0;  Lon := 0;  //clear before fill in
    NeedGeoCode := (lat = 0) or (lon = 0);
    if NeedGeoCode then
      begin
        //only do geocode if we have street address
        GetGEOCode(prop);
        if (length(prop.lat) <> 0) and (length(prop.lon)<>0) then
          begin
            lat := StrToFloatDef(prop.lat,0);
            lon := StrToFloatDef(prop.lon, 0);
          end;
      end;
  except ; end;
end;
}

procedure TPictometryForm.TransferParcelViewToReport(ParcelImageView: WideString);
const
  frmAerialPlatView = 4121;
var
  Cell: TGraphicCell;
  CreateForm: Boolean;
  Form: TDocForm;
  ParcelImage:TJPEGImage;
begin
  if not assigned(FDocument) then
    FDocument := Main.ActiveContainer;
  if not assigned(FDocument) then exit;
  Form := FDocument.GetFormByOccurance(frmAerialPlatView, 0, False);
  if Assigned(Form) then
    begin
      CreateForm := (mrNo = WhichOption12('Replace', 'Add', msgPictometryConfirmReplace));
      if CreateForm then
        Form := FDocument.GetFormByOccurance(frmAerialPlatView, -1, True);
    end
  else
    Form := FDocument.GetFormByOccurance(frmAerialPlatView, -1, True);

  if Assigned(Form) then
    begin
      ParcelImage     := TJPEGImage.Create;
      try
        {Transfer images to JPGs}
        LoadJPEGFromByteArray(ParcelImageView,ParcelImage);
//FOR DEBUG ONLY
        //ParcelImage.SaveToFile('c:\temp\parcel.jpg');
        if not ParcelImage.Empty then
          Form.SetCellJPEG(1,13, ParcelImage);
      finally
        ParcelImage.Free;
      end;
    end;
end;


end.
