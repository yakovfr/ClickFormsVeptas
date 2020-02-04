
{
  ClickFORMS
  (C) Copyright 1998 - 2010, Bradford Technologies, Inc.
  All Rights Reserved.

  Purpose: A portal to the Pictometry imagery service.
}

unit UPortPictometry;

interface

uses
  Classes,
  PictometryService,
  SysUtils,
  UContainer,
  UFormPictometry, 
  UAWSI_Utils,
  AWSI_Server_Pictometry,
  UWinUtils,
  uPictometry,
  uServices,
  UCRMServices,ExtCtrls;

type
  /// summary: An enumeration of directions for which Pictometry provides imagery.
  TDirection = (dOrthogonal, dNorth, dEast, dSouth, dWest);

  /// summary: An enumeration of faces for which Pictometry provides imagery.
  TFace = (fOverhead, fFront, fBack, fLeft, fRight);

  /// summary: A portal to the Pictometry imagery service.
  TPictometryPortal = class
  private
    FDocument: TContainer;
    FImageEast: TMemoryStream;
    FImageNorth: TMemoryStream;
    FImageOrthogonal: TMemoryStream;
    FImageSouth: TMemoryStream;
    FImageWest: TMemoryStream;
    FPictometryForm: TPictometryForm;
    FUserCredentials: UserCredentials;
    FMapWidth: Integer;  //Ticket #1561
    FMapHeight: Integer;  //Ticket #1561
    procedure ActionSearchByAddressOnExecute(Sender: TObject);
    procedure ActionTransferOnExecute(Sender: TObject);
    function GetFaceImageStream(const Face: TFace): TStream;
    function GetFaceImageStream2(const Face: TFace; var ImageCaption: String): TStream;
    procedure HandleServiceError(const E: Exception);
    function GetCFDB_SearchByAddress(const Street: String; const City: String; const State: String; const Zip: String): Boolean;
    function GetCFAW_SearchByAddress(const Street: String; const City: String; const State: String; const Zip: String): Boolean;
    function LoadImageViewToStream(ImageString:WideString; var aStream: TMemoryStream):Boolean;
    procedure LoadImageFromStream(var AImage: TImage; aStream: TStream);
    procedure LoadCRMPictometryImages(Pictometry:TPictometry);
    procedure ReadPictometryMapSettingsFromIni;
   protected
    procedure FillFormSubjectAerialPhoto;
    procedure Reset;
    procedure SetDocument(const Document: TContainer);
    procedure ShowModal;
  public
    constructor Create;
    destructor Destroy; override;
    property Document: TContainer read FDocument write SetDocument;
    class procedure Execute(const Document: TContainer);
  end;

implementation

uses
  Controls,
  Forms,
  InvokeRegistry,
  RIO,
  SoapHTTPClient,
  Types,
  UCell,
  UCustomerServices,
  UDebugTools,
  UExceptions,
  UForm,
  UGlobals,
  ULicUser,
  UMain,
  UStatus,
  UStrings,
  UUtil1,
  UWebConfig,
  Jpeg,
  UBase64,
  iniFiles;

const
// number of images to download
  nPictImages = 5;
  errNotAllImagesAvailable = 'Only %d images available for the address!';

// *** BTWSI Service Error Codes **********************************************

  /// summary: Error code for the message, 'UnknownError'
  CServiceError_UnknownError = 1;

  /// summary: Error code for the message, 'Invalid Credential'
  CServiceError_AuthorizationFailed = 2;

  /// summary: Error code for the message, 'Customer does not exist on DB'
  CServiceError_InvalidCustomer = 3;

  /// summary: Error code for the message, 'Customer does not have the service'
  CServiceError_NoActiveSubscription = 4;

  /// summary: Error code for the message, 'No available service units'
  CServiceError_AllUnitsConsumed = 5;

  /// summary: Error code for the message, 'Service Expired'
  CServiceError_AllUnitsExpired = 6;

  /// summary: Error code for the message, 'Unknown Error, please try later'
  CServiceError_WaitSubsequentRequestDelay = 7;

  /// summary: Error code for the message, 'Can not get images from Pictometry Service'
  CServiceError_ImagesUnavailable = 8;

  /// summary: Error code for the message, 'Cannot update service usage'
  CServiceError_DatabaseError = 9;

// *** Service Configuration **************************************************

  /// summary: Timeout in milliseconds for Pictometry service calls.
  CTimeoutPictometryService = 90000;  // 90 seconds

// *** Unit ******************************************************************

/// summary: Loads a dynamic byte array into a stream.
procedure ByteDynArrayToStream(const ByteDynArray: TByteDynArray; const Stream: TStream);
var
  Size: Integer;
begin
  if not (Assigned(ByteDynArray) and Assigned(Stream)) then
    //raise EArgumentException.Create('Parameter is nil');
    exit;
  Size := Length(ByteDynArray);
  Stream.WriteBuffer(PChar(ByteDynArray)^, Size);
end;

// *** TPictometryPortal *****************************************************


/// summary: Creates a new instance of TPictometryPortal.
constructor TPictometryPortal.Create;
begin
  try
      FImageEast := TMemoryStream.Create;
      FImageNorth := TMemoryStream.Create;
      FImageOrthogonal := TMemoryStream.Create;
      FImageSouth := TMemoryStream.Create;
      FImageWest := TMemoryStream.Create;
      FPictometryForm := TPictometryForm.Create(nil);
      FUserCredentials := UserCredentials.Create;
      inherited Create;
      ReadPictometryMapSettingsFromIni;  //Ticket #1561: store both map width and height in the ini file

      // hook-up the UI
      FPictometryForm.ActionSearchByAddress.OnExecute := ActionSearchByAddressOnExecute;
      FPictometryForm.ActionTransfer.OnExecute := ActionTransferOnExecute;
   except on E:Exception do
     begin
        HandleServiceError(E);
        Abort;
     end;
   end;
end;

/// summary: Frees memory and releases resources.
destructor TPictometryPortal.Destroy;
begin
  FreeAndNil(FImageEast);
  FreeAndNil(FImageNorth);
  FreeAndNil(FImageOrthogonal);
  FreeAndNil(FImageSouth);
  FreeAndNil(FImageWest);
  FreeAndNil(FPictometryForm);
  FreeAndNil(FUserCredentials);
  inherited;
end;

procedure TPictometryPortal.ReadPictometryMapSettingsFromIni;
var
  iniFile:TIniFile;
begin
  INIFile := TINIFile.Create(IncludeTrailingPathDelimiter(appPref_DirPref) + cClickFormsINI);
  try
    FMapWidth := INIFile.ReadInteger('Pictometry', 'Width', 0);
    FMapHeight := INIFile.ReadInteger('Pictometry', 'Height', 0);
    if FMapWidth = 0 then  //save default 500 back to the ini file
      begin
        INIFile.WriteInteger('Pictometry', 'Width', 500);
        INIFile.WriteInteger('Pictometry', 'Height', 500);
        INIFile.UpdateFile;
      end;
  finally
    INIFile.Free;
  end;
end;


function TPictometryPortal.LoadImageViewToStream(ImageString:WideString; var aStream:TMemoryStream):Boolean;
var
  ImageData: String;
  JPEGImg: TJPEGImage;
begin
  result := False;
  if length(ImageString) > 0 then
    begin
      ImageData := Base64Decode(ImageString);
       try
         JPEGImg := TJPEGImage.Create;
         try
           LoadJPEGFromByteArray(ImageData,JPEGImg);
           JPEGImg.SaveToStream(aStream); // save into FFloodClient
          // JPEGImg.SaveToFile('C:\temp\image.jpg');

           result := True;
         finally
           JPEGImg.Free;
         end;
       except
          raise Exception.Create('There was a problem loading the map image file.');
        end;

    end;
end;

procedure TPictometryPortal.LoadImageFromStream(var AImage: TImage; aStream: TStream);
var
  JPEGImage: TJPEGImage;
begin
  aStream.Position := 0;
  JPEGImage := TJPEGImage.Create;
  try
    JPEGImage.LoadFromStream(aStream);
    AImage.Picture.Assign(JPEGImage);
  finally
    JPEGImage.Free;
  end;
end;

procedure TPictometryPortal.LoadCRMPictometryImages(Pictometry:TPictometry);
var
  aImageStr:String;
  nImages: Integer;
begin
  FImageOrthogonal.Position := 0;
  FImageNorth.Position := 0;
  FImageSouth.Position := 0;
  FImageWest.Position := 0;
  FImageEast.Position := 0;
  nImages := 0;

  aImageStr := Base64Decode(Pictometry.FNorthImage.ImageB64);  //Load north view
  if LoadImageViewToStream(Pictometry.FNorthImage.ImageB64, FImageNorth) then
    begin
      LoadImageFromStream(FPictometryForm.ImageNorth, FImageNorth);
      if not FPictometryForm.ImageNorth.Picture.Graphic.Empty then
        inc(nImages);
    end;
  aImageStr := Base64Decode(Pictometry.FSouthImage.ImageB64);  //Load south view
  if LoadImageViewToStream(Pictometry.FSouthImage.ImageB64, FImageSouth) then
    begin
      LoadImageFromStream(FPictometryForm.ImageSouth, FImageSouth);
      if not FPictometryForm.ImageSouth.Picture.Graphic.Empty then
        inc(nImages);
    end;
  aImageStr := Base64Decode(Pictometry.FWestImage.ImageB64);  //Load west view
  if LoadImageViewToStream(Pictometry.FWestImage.ImageB64, FImageWest) then
    begin
      LoadImageFromStream(FPictometryForm.ImageWest, FImageWest);
      if not FPictometryForm.ImageWest.Picture.Graphic.Empty then
        inc(nImages);
    end;
  aImageStr := Base64Decode(Pictometry.FEastImage.ImageB64);  //Load east view
  if LoadImageViewToStream(Pictometry.FEastImage.ImageB64, FImageEast) then
    begin
      LoadImageFromStream(FPictometryForm.ImageEast, FImageEast);
      if not FPictometryForm.ImageEast.Picture.Graphic.Empty then
        inc(nImages);
    end;
  aImageStr := Base64Decode(Pictometry.FDownImage.ImageB64);  //Load down view
  if LoadImageViewToStream(Pictometry.FDownImage.ImageB64, FImageOrthogonal) then
    begin
      LoadImageFromStream(FPictometryForm.ImageOrthogonal, FImageOrthogonal);
      if not FPictometryForm.ImageOrthogonal.Picture.Graphic.Empty then
        inc(nImages);
    end;
  if nImages > 0 then
    FPictometryForm.FImagesLoaded := True;

  if nImages < nPictImages then
    ShowNotice(Format(errNotAllImagesAvailable,[nImages]));
end;


/// summary: Responds to the OnExecute event of the SearchByAddress action on the pictometry form.
procedure TPictometryPortal.ActionSearchByAddressOnExecute(Sender: TObject);
var
  PreviousEnabled: Boolean;
  nImages: Integer;
  responseData,aImageStr:String;
  Pictometry: TPictometry;
  imageJPG:TJPEGImage;
  useCRM:Boolean;
begin
  PreviousEnabled := FPictometryForm.Enabled;
  PushMouseCursor(crHourglass);
  useCRM := False; //initialize to False so we can use CustDB or awsi first
  try
    FPictometryForm.Enabled := False;
    if not GetCFDB_SearchByAddress(FPictometryForm.EditStreet.Text, FPictometryForm.EditCity.Text, FPictometryForm.EditState.Text, FPictometryForm.EditZip.Text) then
      begin
        if CurrentUser.OK2UseAWProduct(pidPictometry) then //pop up warning if fail in getting server
          begin
            useCRM := not GetCFAW_SearchByAddress(FPictometryForm.EditStreet.Text, FPictometryForm.EditCity.Text, FPictometryForm.EditState.Text, FPictometryForm.EditZip.Text);
          end
        else
          useCRM := True;  //if both AWSI and CustDB fail use CRM
      end
    else
      useCRM := True; //if both custDB and AWSI fail, turn on this flag so we can call CRM Services.

    if not useCRM then
      begin
        FImageOrthogonal.Position := 0;
        FImageNorth.Position := 0;
        FImageSouth.Position := 0;
        FImageWest.Position := 0;
        FImageEast.Position := 0;
        nImages := FPictometryForm.LoadFormImages(FImageOrthogonal, FImageNorth, FImageSouth, FImageWest, FImageEast);
        if nImages  < nPictImages then
          ShowNotice(Format(errNotAllImagesAvailable,[nImages]));
      end
    else
      begin
        Pictometry := TPictometry.Create;
        try
          Pictometry.FAddress := FPictometryForm.EditStreet.Text;
          Pictometry.FCity    := FPictometryForm.EditCity.Text;
          Pictometry.FState   := FPictometryForm.EditState.Text;
          Pictometry.FZip     := FPictometryForm.EditZip.Text;
          try
            if GetCRM_Pictometry(CurrentUser.AWUserInfo, FMapWidth, FMapHeight, responseData, Pictometry) then
              LoadCRMPictometryImages(Pictometry);
          except on E:Exception do ; end;
        finally
          if assigned(Pictometry) then
            FreeAndNil(Pictometry);
        end;
      end;
  finally
    FPictometryForm.Enabled := PreviousEnabled;
    PopMouseCursor;
  end;
end;

/// summary: Responds to the OnExecute event of the Transfer action on the pictometry form.
///          Transfers Pictometry images to the report.
procedure TPictometryPortal.ActionTransferOnExecute(Sender: TObject);
var
  PreviousEnabled: Boolean;
  lat, lon: Double;
  ParcelImageView: WideString;

begin
  PreviousEnabled := FPictometryForm.Enabled;
  try
    FPictometryForm.Enabled := False;
    if not Assigned(FDocument) then
      FDocument := Main.NewEmptyContainer;

    FillFormSubjectAerialPhoto;

    if LoadSubjectParceViewByAddr(FPictometryForm.EditStreet.Text, FPictometryForm.EditCity.Text,
                                  FPictometryForm.EditState.Text, FPictometryForm.EditZip.Text,
                                  ParcelImageView) then
    begin
      FPictometryForm.TransferParcelViewToReport(ParcelImageView);
    end;


    FPictometryForm.ModalResult := mrOK;
    FDocument.docView.Invalidate;
  finally
    FPictometryForm.Enabled := PreviousEnabled;
  end;
end;

/// summary: Gets the Pictometry image stream for the specified face.
function TPictometryPortal.GetFaceImageStream(const Face: TFace): TStream;
var
  Front: TDirection;
begin
  // find which direction is the front
  if FPictometryForm.RadioButtonFrontNorth.Checked then
    Front := dNorth
  else if FPictometryForm.RadioButtonFrontEast.Checked then
    Front := dEast
  else if FPictometryForm.RadioButtonFrontSouth.Checked then
    Front := dSouth
  else if FPictometryForm.RadioButtonFrontWest.Checked then
    Front := dWest
  else
    Front := dOrthogonal;

  // find the requested face based on which direction is front
  case Front of
    dNorth:
      case Face of
        fFront: Result := FImageNorth;
        fBack:  Result := FImageSouth;
        fLeft:  Result := FImageEast;
        fRight: Result := FImageWest;
      else
        Result := FImageOrthogonal;
      end;

    dEast:
      case Face of
        fFront: Result := FImageEast;
        fBack:  Result := FImageWest;
        fLeft:  Result := FImageSouth;
        fRight: Result := FImageNorth;
      else
        Result := FImageOrthogonal;
      end;

    dSouth:
      case Face of
        fFront: Result := FImageSouth;
        fBack:  Result := FImageNorth;
        fLeft:  Result := FImageWest;
        fRight: Result := FImageEast;
      else
        Result := FImageOrthogonal;
      end;

    dWest:
      case Face of
        fFront: Result := FImageWest;
        fBack:  Result := FImageEast;
        fLeft:  Result := FImageNorth;
        fRight: Result := FImageSouth;
      else
        Result := FImageOrthogonal;
      end;
  else
    Result := FImageOrthogonal;
  end;
end;


/// summary: Gets the Pictometry image stream for the specified face.
function TPictometryPortal.GetFaceImageStream2(const Face: TFace; var ImageCaption:String): TStream;
var
  Front: TDirection;
begin
  // find which direction is the front
  if FPictometryForm.RadioButtonFrontNorth.Checked then
    Front := dNorth
  else if FPictometryForm.RadioButtonFrontEast.Checked then
    Front := dEast
  else if FPictometryForm.RadioButtonFrontSouth.Checked then
    Front := dSouth
  else if FPictometryForm.RadioButtonFrontWest.Checked then
    Front := dWest
  else
    Front := dOrthogonal;

  // find the requested face based on which direction is front
  case Front of
    dNorth:
      case Face of
        fFront: begin Result := FImageNorth; ImageCaption := 'Aerial Front - North'; end;
        fBack:  begin Result := FImageSouth; ImageCaption := 'South'; end;
        fLeft:  begin Result := FImageEast;  ImageCaption := 'East'; end;
        fRight: begin Result := FImageWest;  ImageCaption := 'West'; end;
      else
        begin result := FImageOrthogonal; ImageCaption := 'Overhead'; end;
      end;

    dEast:
      case Face of
        fFront: begin Result := FImageEast;  ImageCaption := 'Aerial Front - East'; end;
        fBack:  begin Result := FImageWest;  ImageCaption := 'West'; end;
        fLeft:  begin Result := FImageSouth; ImageCaption := 'South'; end;
        fRight: begin Result := FImageNorth; ImageCaption := 'North'; end;
      else
        begin result := FImageOrthogonal; ImageCaption := 'Overhead'; end;
      end;

    dSouth:
      case Face of
        fFront: begin Result := FImageSouth; ImageCaption := 'Aerial Front- South'; end;
        fBack:  begin Result := FImageNorth; ImageCaption := 'North'; end;
        fLeft:  begin Result := FImageWest; ImageCaption := 'West'; end;
        fRight: begin Result := FImageEast; ImageCaption := 'East'; end;
      else
        begin result := FImageOrthogonal; ImageCaption := 'Overhead'; end;
      end;

    dWest:
      case Face of
        fFront: begin Result := FImageWest; ImageCaption := 'Aerial Front - West'; end;
        fBack:  begin Result := FImageEast; ImageCaption := 'East'; end;
        fLeft:  begin Result := FImageNorth; ImageCaption := 'North'; end;
        fRight: begin Result := FImageSouth; ImageCaption := 'South'; end;
      else
        begin result := FImageOrthogonal; ImageCaption := 'Overhead'; end;
      end;
  else
     begin result := FImageOrthogonal; ImageCaption := 'Overhead'; end;
  end;
end;


/// summary: Handles errors returned by the the Pictometry service.
procedure TPictometryPortal.HandleServiceError(const E: Exception);
var
  ServiceError: EServStatusException;
  Text: String;
begin
  if ControlKeyDown or DebugMode then
    TDebugTools.Debugger.ShowConsole;

  if (E is ERemotableException) and SameText(E.Message, 'Error in the application.') then
    begin
      ServiceError := EServStatusException.Create(E as ERemotableException);
      TDebugTools.WriteLine(ServiceError.ClassName + ': ' + ServiceError.excDescr);
      case ServiceError.excCode of
        CServiceError_UnknownError:
          Text := 'The Pictometry Aerial Imagery service is temporarily unavailable.|' + E.Message;
        CServiceError_AuthorizationFailed:
          Text := 'A newer version of ClickFORMS is required to use this service.|' + E.Message;
        CServiceError_InvalidCustomer:
          Text := 'The Pictometry Aerial Imagery service is temporarily unavailable.|' + E.Message;
        CServiceError_NoActiveSubscription:
          Text := 'Please contact Bradford Technologies at ' + OurPhoneNumber + ' to purchase Pictometry Aerial Imagery.|' + E.Message;
        CServiceError_AllUnitsConsumed:
          Text := 'Please contact Bradford Technologies at ' + OurPhoneNumber + ' to purchase additional units of Pictometry Aerial Imagery.|' + E.Message;
        CServiceError_AllUnitsExpired:
          Text := 'Please contact Bradford Technologies at ' + OurPhoneNumber + ' to purchase additional units of Pictometry Aerial Imagery.|' + E.Message;
        CServiceError_WaitSubsequentRequestDelay:
          Text := 'The Pictometry Aerial Imagery service is busy.  Please try again later.|' + E.Message;
        CServiceError_ImagesUnavailable:
          Text := 'The Pictometry Aerial Imagery service is temporarily unavailable.|' + E.Message;
        CServiceError_DatabaseError:
          Text := 'The Pictometry Aerial Imagery service is temporarily unavailable.|' + E.Message;
      else
        Text := 'The Pictometry Aerial Imagery service encountered an error while processing your request.|' + E.Message;
      end;
    end
  else
    begin
      TDebugTools.WriteLine(E.ClassName + ': ' + E.Message);
      if (E is ERemotableException) and (Pos('404', E.Message) > 0) then
        Text := 'The address is outside the Pictometry coverage area.|' + E.Message
      else
        Text := 'The Pictometry Aerial Imagery service encountered an error while processing your request.|' + E.Message;
    end;

  // re-raise the exception as an informational error
  try
    raise EInformationalError.Create(Text);
  except
    on OE: Exception do
      Application.HandleException(Self);
  end;
end;

/// summary: Locates the subject property by address.
function TPictometryPortal.GetCFDB_SearchByAddress(const Street: String; const City: String; const State: String; const Zip: String): Boolean;
const
  CImageQuality = 90;
var
  Address: PictometryAddress;
  ImageSize: TSize;
  Maps: PictometryMaps;
  Options: PictometrySearchModifiers;
  PictometryService: PictometryServiceSoap;
  PreviousCursor: TCursor;
  RIO: THTTPRIO;
begin
  result := false;
  try
    if length(CurrentUser.AWUserInfo.UserCustUID) = 0 then
      exit; //do not call if user does not have custID
    Address := nil;
    Maps := nil;
    Options := nil;
    PictometryService := nil;
    PreviousCursor := Screen.Cursor;
    try
      Screen.Cursor := crHourglass;
      Address := PictometryAddress.Create;
      Address.streetAddress := Street;
      Address.city := City;
      Address.state := State;
      Address.zip := Zip;
      ImageSize := TGraphicCell.CalculateImageSizeFromCellFrame(Rect(0, 0, 250, 250));
      Options := PictometrySearchModifiers.Create;
  //    Options.MapWidth := Trunc(ImageSize.cx * 1.3);  //map width calculation = 419
  //    Options.MapHeight := Trunc(ImageSize.cy * 1.3);
      Options.MapWidth := FMapWidth;   //Ticket #1560 load width and height from ini default as 500
      Options.MapHeight := FMapHeight;
      Options.MapQuality := CImageQuality;
      FUserCredentials.CustID := CurrentUser.AWUserInfo.UserCustUID;
      FUserCredentials.Password := WS_Pictometry_Password;
      PictometryService := GetPictometryServiceSoap(True, GetURLForPictometryService);
      RIO := (PictometryService as IRIOAccess).RIO as THTTPRIO;
      RIO.HTTPWebNode.ReceiveTimeout := CTimeoutPictometryService;
      RIO.HTTPWebNode.SendTimeout := CTimeoutPictometryService;
      RIO.SOAPHeaders.SetOwnsSentHeaders(False);
      RIO.SOAPHeaders.Send(FUserCredentials);
        Maps := PictometryService.SearchByAddress(Address, Options);
        ByteDynArrayToStream(Maps.EastView, FImageEast);
        ByteDynArrayToStream(Maps.NorthView, FImageNorth);
        ByteDynArrayToStream(Maps.OrthogonalView, FImageOrthogonal);
        ByteDynArrayToStream(Maps.SouthView, FImageSouth);
        ByteDynArrayToStream(Maps.WestView, FImageWest);

        //Ticket #1560: Fix to load images to the form
        if FImageNorth <> nil then
          LoadImageFromStream(FPictometryForm.ImageNorth, FImageNorth);
        if FImageSouth <> nil then
          LoadImageFromStream(FPictometryForm.ImageSouth, FImageSouth);
        if FImageWest <> nil then
          LoadImageFromStream(FPictometryForm.ImageWest, FImageWest);
        if FImageEast <> nil then
          LoadImageFromStream(FPictometryForm.ImageEast, FImageEast);
        if FImageOrthogonal <> nil then
          LoadImageFromStream(FPictometryForm.ImageOrthogonal, FImageOrthogonal);
        FPictometryForm.FImagesLoaded := not FPictometryForm.ImageOrthogonal.Picture.Graphic.Empty or
                                         not FPictometryForm.ImageNorth.Picture.Graphic.Empty or
                                         not FPictometryForm.ImageSouth.Picture.Graphic.Empty or
                                         not FPictometryForm.ImageWest.Picture.Graphic.Empty or
                                         not FPictometryForm.ImageEast.Picture.Graphic.Empty;

        Result := True;
      except
        Result := False;
      end;
  finally
    Screen.Cursor := PreviousCursor;
    try
      PictometryService := nil;
    except
      Pointer(PictometryService) := nil;
      result := False;
    end;
    FreeAndNil(Address);
    FreeAndNil(Maps);
    FreeAndNil(Options);
  end;
end;


//Insert a data array of bytes that represent an image and put it into a JPEG
procedure LoadJPEGFromByteArray(const dataArray: String; var JPGImg: TJPEGImage);
var
  msByte: TMemoryStream;
  iSize: Integer;
begin
  msByte := TMemoryStream.Create;
  try
    iSize := Length(DataArray);
    msByte.WriteBuffer(PChar(DataArray)^, iSize);
    msByte.Position:=0;

    if not assigned(JPGImg) then
      JPGImg := TJPEGImage.Create;

    JPGImg.LoadFromStream(msByte);
  finally
    msByte.Free;
  end;
end;

/// summary: Locates the subject property by address.
function TPictometryPortal.GetCFAW_SearchByAddress(const Street: String; const City: String; const State: String; const Zip: String):Boolean;
const
  CImageQuality = 90;
  Map_width     = 500;
  Map_Height    = 500;
var
  Credentials : clsUserCredentials;
  AddressRequest : clsPictometrySearchByAddressRequest;
  SearchModifiers : clsPictometrySearchModifiers;
  Response : clsSearchByAddressResponse;
  Token, CompanyKey, OrderKey : WideString;
  dataPics: clsPictometryData;
  AerialImages: clsDownloadMapsResponse;
  Acknowledgement : clsAcknowledgement;
  NorthView: String;
  EastView: String;
  SouthView: String;
  WestView: String;
  TopView: String;
  NorthJPG: TJPEGImage;
  EastJPG: TJPEGImage;
  SouthJPG: TJPEGImage;
  WestJPG: TJPEGImage;
  TopJPG: TJPEGImage;
begin
  result := False;
  {Get Token,CompanyKey and OrderKey}
  if AWSI_GetCFSecurityToken(AWCustomerEmail, AWCustomerPSW, CurrentUser.AWUserInfo.UserCustUID, Token, CompanyKey, OrderKey) then
  try
    {User Credentials}
    Credentials := clsUserCredentials.Create;
    Credentials.Username := AWCustomerEmail;
    Credentials.Password := Token;
    Credentials.CompanyKey := CompanyKey;
    Credentials.OrderNumberKey := OrderKey;
    Credentials.Purchase := 0;

    {Address Request}
    AddressRequest := clsPictometrySearchByAddressRequest.Create;
    AddressRequest.StreetAddress := Street;
    AddressRequest.City := City;
    AddressRequest.State := State;
    AddressRequest.Zip := Zip;

    {Search Modifiers}
    SearchModifiers := clsPictometrySearchModifiers.Create;
//    searchModifiers.MapHeight   := 300;
//    searchModifiers.MapWidth    := 400;
    searchModifiers.MapHeight   := FMapHeight;   //Ticket #1561 load settings from ini file
    searchModifiers.MapWidth    := FMapWidth;    //Ticket #1561
    searchModifiers.MapQuality  := 90;
    try
      with GetPictometryServerPortType(False, GetAWURLForPictometryService) do
        begin
          Response := PictometryService_SearchByAddress(Credentials, AddressRequest, SearchModifiers);
          {if zero is sucess call}
          if Response.Results.Code = 0 then
            begin
              result := True;
               {Load Data Object to be send Back}
              dataPics := clsPictometryData.Create;
              dataPics.NorthView       := Response.ResponseData.NorthView;
              dataPics.EastView        := Response.ResponseData.EastView;
              dataPics.SouthView       := Response.ResponseData.SouthView;
              dataPics.WestView        := Response.ResponseData.WestView;
              dataPics.OrthogonalView  := Response.ResponseData.OrthogonalView;

              {get Map photos}
              AerialImages := PictometryService_DownloadMaps(Credentials,dataPics);
              if AerialImages.Results.Code = 0 then
                begin
                  {Success call now Send Back Acknowledgement}
                  try
                    Acknowledgement := clsAcknowledgement.Create;
                    Acknowledgement.Received := 1;
                    if Assigned(Response.ResponseData) then
                       Acknowledgement.ServiceAcknowledgement := AerialImages.ResponseData.ServiceAcknowledgement;
                    with GetPictometryServerPortType(false,GetAWURLForPictometryService) do
                       PictometryService_Acknowledgement(Credentials,Acknowledgement);
                  finally
                    Acknowledgement.Free;
                  end;
                  {Decode base64 data string }
                  NorthView  := Base64Decode(AerialImages.ResponseData.NorthView);
                  WestView   := Base64Decode(AerialImages.ResponseData.WestView);
                  EastView   := Base64Decode(AerialImages.ResponseData.EastView);
                  SouthView  := Base64Decode(AerialImages.ResponseData.SouthView);
                  TopView    := Base64Decode(AerialImages.ResponseData.OrthogonalView);
                  {create JPGs}
                  NorthJPG := TJPEGImage.Create;
                  EastJPG  := TJPEGImage.Create;
                  SouthJPG := TJPEGImage.Create;
                  WestJPG  := TJPEGImage.Create;
                  TopJPG   := TJPEGImage.Create;
                  {Transfer images to JPGs}
                  LoadJPEGFromByteArray(NorthView,NorthJPG);
                  LoadJPEGFromByteArray(EastView,EastJPG);
                  LoadJPEGFromByteArray(WestView,WestJPG);
                  LoadJPEGFromByteArray(SouthView,SouthJPG);
                  LoadJPEGFromByteArray(TopView,TopJPG);
                  {Save MemoryStream To CF process}
                  NorthJPG.SaveToStream(FImageNorth);
                  EastJPG.SaveToStream(FImageEast);
                  WestJPG.SaveToStream(FImageWest);
                  SouthJPG.SaveToStream(FImageSouth);
                  TopJPG.SaveToStream(FImageOrthogonal);

                  CheckServiceAvailable(stPictometry);

                end;
              {ShowAlert(atInfoAlert, Response.Results.Description);}
            end
          else
            ShowAlert(atWarnAlert, Response.Results.Description);
        end;
     except
      on e: Exception do
        ShowAlert(atStopAlert, e.Message);
    end;
  finally
    Credentials.Free;
    AddressRequest.Free;
    SearchModifiers.Free;
    NorthJPG.Free;
    EastJPG.Free;
    SouthJPG.Free;
    WestJPG.Free;
    TopJPG.Free;
  end;
end;

/// summary: Fills the Subject Aerial Photo form (625)
///          with the images returned by the Pictometry service.
/// 09/30/2014: Replace form #625 with 9039.
procedure TPictometryPortal.FillFormSubjectAerialPhoto;
var
  Cell: TGraphicCell;
  CreateForm: Boolean;
  Form, sForm: TDocForm;
  Stream: TStream;
  ImageCaption: String;
begin
  Form := FDocument.GetFormByOccurance(9039, 0, False);
  if Assigned(Form) then
    begin
      CreateForm := (mrNo = WhichOption12('Replace', 'Add', msgPictometryConfirmReplace));
      if CreateForm then
        Form := FDocument.GetFormByOccurance(9039, -1, True);
    end
  else
    Form := FDocument.GetFormByOccurance(9039, -1, True);

  if Assigned(Form) then
    begin
      //Get Subject Front view from 301 if found
      sForm := FDocument.GetFormByOccurance(301, 0, False);
      if Assigned(sForm) then //we found 301 form
        begin
          Form.SetCellText(1, 13, 'Street Front');
          Form.SetCellImageFromCell(1, 14, sForm.GetCell(1,15));        //Subject Front
        end;

//      Stream := GetFaceImageStream(fFront);
      Stream := GetFaceImageStream2(fFront, ImageCaption);
      Stream.Position := 0;
//      Cell := Form.GetCell(1, 13) as TGraphicCell;
      Form.SetCellText(1, 15, ImageCaption);
      Cell := Form.GetCell(1, 16) as TGraphicCell;
      Cell.LoadStreamData(Stream, Stream.Size, True);

      Stream := GetFaceImageStream2(fBack, ImageCaption);
      Stream.Position := 0;
//      Cell := Form.GetCell(1, 14) as TGraphicCell;
      Form.SetCellText(1, 17, ImageCaption);
      Cell := Form.GetCell(1, 18) as TGraphicCell;
      Cell.LoadStreamData(Stream, Stream.Size, True);

      Stream := GetFaceImageStream2(fOverhead, ImageCaption);
      Stream.Position := 0;
//      Cell := Form.GetCell(1, 15) as TGraphicCell;
      Form.SetCellText(1, 19, ImageCaption);
      Cell := Form.GetCell(1, 20) as TGraphicCell;
      Cell.LoadStreamData(Stream, Stream.Size, True);

      Stream := GetFaceImageStream2(fLeft, ImageCaption);
      Stream.Position := 0;
//      Cell := Form.GetCell(1, 16) as TGraphicCell;
      Form.SetCellText(1, 21, ImageCaption);
      Cell := Form.GetCell(1, 22) as TGraphicCell;
      Cell.LoadStreamData(Stream, Stream.Size, True);

      Stream := GetFaceImageStream2(fRight, ImageCaption);
      Stream.Position := 0;
      Form.SetCellText(1, 23, ImageCaption);
      Cell := Form.GetCell(1, 24) as TGraphicCell;
      Cell.LoadStreamData(Stream, Stream.Size, True);
    end;
end;

/// summary: Resets the Pictometry portal to its initial state containing no data.
procedure TPictometryPortal.Reset;
begin
  FImageEast.Clear;
  FImageNorth.Clear;
  FImageOrthogonal.Clear;
  FImageSouth.Clear;
  FImageWest.Clear;
  FDocument := nil;
  FPictometryForm.LoadFormData(nil);
  FPictometryForm.LoadFormImages(nil, nil, nil, nil, nil);
end;

/// summary: Sets the document for use with the Pictometry service.
procedure TPictometryPortal.SetDocument(const Document: TContainer);
begin
  if (Document <> FDocument) then
    begin
      FDocument := Document;
      FPictometryForm.LoadFormData(FDocument);
    end;
end;

/// summary: Shows the Pictometry service user interface in a modal window.
procedure TPictometryPortal.ShowModal;
begin
  if (FPictometryForm.ShowModal <> mrOK) then
    Abort;
end;

/// summary: Executes the Pictometry portal, filling the appraisal report
///          with aerial images of the subject property.
/// remarks: I am appalled that there is nothing in CurrentUser to say
///          that the user is running on an evaluation license of ClickFORMS.
///          I have spent FAR TOO MUCH TIME trying to figure this out.
///          CurrentUser.UsageLeft is useless (Use the global AppEvalUsageLeft instead).
///          CurrentUser.InTrialPeriod(picClickForms) is useless (Always results in TRUE).
///          CurrentUser.LicInfo.UserCustID is your only hope, under the assumption that
///          the result is an empty string.
class procedure TPictometryPortal.Execute(const Document: TContainer);
var
  Portal: TPictometryPortal;
begin
  if Assigned(Document) and Document.Locked then
    begin
      ShowNotice('Please unlock your report before using Pictometry.');
      Abort;
    end;

  Portal := TPictometryPortal.Create;
  try
    Portal.Reset;
    Portal.Document := Document;
    Portal.ShowModal;
  finally
    FreeAndNil(Portal);
  end;
end;




end.
