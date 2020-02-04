{
  ClickFORMS
  (C) Copyright 1998 - 2010, Bradford Technologies, Inc.
  All Rights Reserved.

  Purpose: A portal to the Pictometry imagery service.
}

unit UPictometry;

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
  UGlobals;

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
    FUserCredentials: UserCredentials;
    function GetFaceImageStream(const Face: TFace): TStream;
    function GetFaceImageStream2(const Face: TFace; var ImageCaption: String): TStream;
    procedure HandleServiceError(const E: Exception);
    function GetCFDB_SearchByAddress(const Street: String; const City: String; const State: String; const Zip: String): Boolean;
    procedure GetCFAW_SearchByAddress(const Street: String; const City: String; const State: String; const Zip: String);
    procedure ReadMapSettingsFromIni;
  protected
    procedure FillFormSubjectAerialPhoto;
    procedure Reset;
    procedure SetDocument(const Document: TContainer);
    procedure ShowModal;
    procedure GetPictometryFromService(AddrInfo: AddrInfoRec);
    procedure TransferPictometryToReport(doc: TContainer);

  public
    FPictometryWidth,FPictometryHeight: Integer;
    constructor Create;
    destructor Destroy; override;


    property Document: TContainer read FDocument write SetDocument;
    class procedure Execute(const Document: TContainer);
  end;

  procedure LoadPictometry(doc: TContainer; AddrInfo: AddrInfoRec);
  function LoadSubjectParceView(Lat, Lon: Double; var ParcelImageView: WideString): Boolean;
  function LoadSubjectParceViewByAddr(Street, city, state, zip: String; var ParcelImageView: WideString): Boolean;




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
      FUserCredentials := UserCredentials.Create;

      ReadMapSettingsFromIni;

      inherited Create;

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
  FreeAndNil(FUserCredentials);
  inherited;
end;

procedure TPictometryPortal.ReadMapSettingsFromIni;
var
  INIFile: TINIFile;
  Region: TRect;
begin
  INIFile := TINIFile.Create(IncludeTrailingPathDelimiter(appPref_DirPref) + cClickFormsINI);
  try
  finally
    INIFile.Free;
  end;
end;


/// summary: Responds to the OnExecute event of the SearchByAddress action on the pictometry form.
procedure TPictometryPortal.GetPictometryFromService(AddrInfo: AddrInfoRec);
var
  PreviousEnabled: Boolean;
  nImages: Integer;
begin
  PushMouseCursor(crHourglass);
  try
    if not GetCFDB_SearchByAddress(AddrInfo.StreetAddr, AddrInfo.City, AddrInfo.State, AddrInfo.Zip) then
      if CurrentUser.OK2UseAWProduct(pidPictometry, False, False) then
        GetCFAW_SearchByAddress(AddrInfo.StreetAddr, AddrInfo.City, AddrInfo.State, AddrInfo.Zip);
    FImageOrthogonal.Position := 0;
    FImageNorth.Position := 0;
    FImageSouth.Position := 0;
    FImageWest.Position := 0;
    FImageEast.Position := 0;
//    nImages := FPictometryForm.LoadFormImages(FImageOrthogonal, FImageNorth, FImageSouth, FImageWest, FImageEast);
//    if nImages  < nPictImages then
//      ShowNotice(Format(errNotAllImagesAvailable,[nImages]));
  finally
    PopMouseCursor;
  end;
end;

/// summary: Responds to the OnExecute event of the Transfer action on the pictometry form.
///          Transfers Pictometry images to the report.
procedure TPictometryPortal.TransferPictometryToReport(doc:TContainer);
begin
  try
    if not Assigned(doc) then
      doc := Main.NewEmptyContainer;
    FillFormSubjectAerialPhoto;
    doc.docView.Invalidate;
  finally
  end;
end;

/// summary: Gets the Pictometry image stream for the specified face.
function TPictometryPortal.GetFaceImageStream(const Face: TFace): TStream;
var
  Front: TDirection;
begin
  Front := dNorth;
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
  Front := dNorth;
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
  if length(CurrentUser.UserCustUID) = 0 then
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
    Options.MapWidth := Trunc(ImageSize.cx * 1.3);
    Options.MapHeight := Trunc(ImageSize.cy * 1.3);
    Options.MapQuality := CImageQuality;
    FUserCredentials.CustID := CurrentUser.UserCustUID;
    FUserCredentials.Password := WS_Pictometry_Password;
    PictometryService := GetPictometryServiceSoap(True, GetURLForPictometryService);
    RIO := (PictometryService as IRIOAccess).RIO as THTTPRIO;
    RIO.HTTPWebNode.ReceiveTimeout := CTimeoutPictometryService;
    RIO.HTTPWebNode.SendTimeout := CTimeoutPictometryService;
    RIO.SOAPHeaders.SetOwnsSentHeaders(False);
    RIO.SOAPHeaders.Send(FUserCredentials);
    try
      Maps := PictometryService.SearchByAddress(Address, Options);
      ByteDynArrayToStream(Maps.EastView, FImageEast);
      ByteDynArrayToStream(Maps.NorthView, FImageNorth);
      ByteDynArrayToStream(Maps.OrthogonalView, FImageOrthogonal);
      ByteDynArrayToStream(Maps.SouthView, FImageSouth);
      ByteDynArrayToStream(Maps.WestView, FImageWest);
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
procedure TPictometryPortal.GetCFAW_SearchByAddress(const Street: String; const City: String; const State: String; const Zip: String);
const
  CImageQuality = 90;
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
  {Get Token,CompanyKey and OrderKey}
  if AWSI_GetCFSecurityToken(AWCustomerEmail, AWCustomerPSW, CurrentUser.UserCustUID, Token, CompanyKey, OrderKey) then
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
    searchModifiers.MapHeight   := 300;
    searchModifiers.MapWidth    := 400;
    searchModifiers.MapQuality  := 90;
    try
      with GetPictometryServerPortType(False, GetAWURLForPictometryService) do
        begin
          Response := PictometryService_SearchByAddress(Credentials, AddressRequest, SearchModifiers);
          {if zero is sucess call}
          if Response.Results.Code = 0 then
            begin
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
//  FPictometryForm.LoadFormData(nil);
//  FPictometryForm.LoadFormImages(nil, nil, nil, nil, nil);
end;

/// summary: Sets the document for use with the Pictometry service.
procedure TPictometryPortal.SetDocument(const Document: TContainer);
begin
  if (Document <> FDocument) then
    begin
      FDocument := Document;
//      FPictometryForm.LoadFormData(FDocument);
    end;
end;

/// summary: Shows the Pictometry service user interface in a modal window.
procedure TPictometryPortal.ShowModal;
begin
//  if (FPictometryForm.ShowModal <> mrOK) then
//    Abort;
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

procedure LoadPictometry(doc: TContainer; AddrInfo: AddrInfoRec);
var
  PictometryPortal: TPictometryPortal;
begin
  PictometryPortal := TPictometryPortal.Create;
  try
    PictometryPortal.FDocument := doc;
    PictometryPortal.GetPictometryFromService(AddrInfo);
    PictometryPortal.TransferPictometryToReport(doc);
  finally
    PictometryPortal.Free;
  end;
end;


function DoGetParcelImage(Lat, Lon: Double; var ParcelImageView: WideString ): Boolean;
var
  Credentials : clsUserCredentials;
  SearchModifiers : clsPictometrySearchWithParcelModifiers;
  GeoSearch: clsPictometrySearchByGeocodeRequest;
  GeoResponse: clsSearchByGeocodeResponse;
  Parcel: clsParcelInfo;
  Token, CompanyKey, OrderKey : WideString;
  dataPics: clsPictometryData;
  Acknowledgement : clsAcknowledgement;
  AerialImages: clsDownloadMapsResponse;
begin
  {Get Token,CompanyKey and OrderKey}
  if AWSI_GetCFSecurityToken(AWCustomerEmail, AWCustomerPSW, CurrentUser.UserCustUID, Token, CompanyKey, OrderKey) then
  try
    {User Credentials}
    Credentials := clsUserCredentials.Create;
    Credentials.Username := AWCustomerEmail;
    Credentials.Password := Token;
    Credentials.CompanyKey := CompanyKey;
    Credentials.OrderNumberKey := OrderKey;
    Credentials.Purchase := 0;

   {Load Subject GeoCode}
    GeoSearch := clsPictometrySearchByGeocodeRequest.Create;
    GeoSearch.Longitude := Lon;
    GeoSearch.Latitude  := Lat;

  {Parcel View Settings}
  Parcel := clsParcelInfo.Create;
  Parcel.StrokeColor := 'ffff00';
  Parcel.StrokeOpacity := 1.0;
//  Parcel.StrokeWidth := '2';
  Parcel.StrokeWidth := '4';
  Parcel.FillColor := 'ffffff';
  Parcel.FillOpacity := '0.0';
  Parcel.FeatureBuffer := 100;
  Parcel.Orientations := 'O';

  {Modifiers Config}
  searchModifiers := clsPictometrySearchWithParcelModifiers.Create;
  searchModifiers.MapHeight   := 1100;
  searchModifiers.MapWidth    := 720;
  searchModifiers.MapQuality  := 200;
  searchModifiers.ParcelInfo :=  Parcel;

  try
    with GetPictometryServerPortType(false, awsiPictometry) do
      begin
        GeoResponse := PictometryService_SearchByGeocodeWithParcel(Credentials,GeoSearch,searchModifiers);
        if GeoResponse.Results.Code = 0 then
          begin
            {Load Data Object to be send Back}
            dataPics := clsPictometryData.Create;
            dataPics.OrthogonalView  := GeoResponse.ResponseData.OrthogonalView;

            {Get parcel view}
            AerialImages := PictometryService_DownloadMaps(Credentials, dataPics);

            if AerialImages.Results.Code = 0 then
              begin
                //If Success Send Back Acknowledgement}
                try
                  Acknowledgement := clsAcknowledgement.Create;
                  Acknowledgement.Received := 1;
                  if Assigned(GeoResponse.ResponseData) then
                     Acknowledgement.ServiceAcknowledgement := AerialImages.ResponseData.ServiceAcknowledgement;
                  with GetPictometryServerPortType(false, awsiPictometry) do
                     PictometryService_Acknowledgement(Credentials, Acknowledgement);
                finally
                  Acknowledgement.Free;
                end;
               {Decode base64 data string }
                ParcelImageView := Base64Decode(AerialImages.ResponseData.OrthogonalView);
                result := True;
              end
            else
              result := False; //AerialImages.Results.Code is not 0
          end
        else
          result := False;  //GeoResponse.Results.Code is not 0

      //if Fail alert user and send back failure acknowledgement
      if not result then
        begin
          ShowAlert(atWarnAlert, GeoResponse.Results.Description);

          try
            Acknowledgement := clsAcknowledgement.Create;
            Acknowledgement.Received := 0;
            if Assigned(GeoResponse.ResponseData) then
              Acknowledgement.ServiceAcknowledgement := GeoResponse.ResponseData.ServiceAcknowledgement;
            with GetPictometryServerPortType(false, awsiPictometry) do
              PictometryService_Acknowledgement(Credentials, Acknowledgement);
          finally
            Acknowledgement.Free;
          end;
        end;
    end; //with
    except on E:Exception do
      ShowAlert(atWarnAlert, 'Error in getting Subject Parcel Map: '+e.Message);
    end;
  finally
    Credentials.Free;
    GeoSearch.Free;
    searchModifiers.Free;
  end;
end;


function LoadSubjectParceView(Lat, Lon: Double; var ParcelImageView: WideString): Boolean;
var
  Credentials : clsUserCredentials;
  SearchModifiers : clsPictometrySearchWithParcelModifiers;
  GeoSearch: clsPictometrySearchByGeocodeRequest;
  GeoResponse: clsSearchByGeocodeResponse;
  Parcel: clsParcelInfo;
  Token, CompanyKey, OrderKey : WideString;
  dataPics: clsPictometryData;
  Acknowledgement : clsAcknowledgement;
  AerialImages: clsDownloadMapsResponse;
begin
    PushMouseCursor(crHourglass);
    {Get Token,CompanyKey and OrderKey}
//    if AWSI_GetCFSecurityToken(AWCustomerEmail, AWCustomerPSW, CurrentUser.LicInfo.UserCustID, Token, CompanyKey, OrderKey) then
  if GetFREEAWSISecutityToken(Token) then
    begin
      try
        {User Credentials}
        Credentials := clsUserCredentials.Create;
//        Credentials.Username := AWCustomerEmail;
//        Credentials.CompanyKey := CompanyKey;
//        Credentials.OrderNumberKey := OrderKey;
//### Use free token for this call, since user already bought pictometry should get this one for free
        Credentials.Username := 'compcruncher@bradfordsoftware.com';
        Credentials.Password := Token;
        Credentials.CompanyKey :='ed77ee59-87b5-afdf-92aa-1a3b14ef4e8e';
        Credentials.OrderNumberKey := 'xxxxxxxxxxxnotrequiredxxxxxxxxxx';
        Credentials.Purchase := 0;

       {Load Subject GeoCode}
        GeoSearch := clsPictometrySearchByGeocodeRequest.Create;
        GeoSearch.Longitude := Lon;
        GeoSearch.Latitude  := Lat;

      {Parcel View Settings}
      Parcel := clsParcelInfo.Create;
      Parcel.StrokeColor := 'ffff00';
      Parcel.StrokeOpacity := 1.0;
    //  Parcel.StrokeWidth := '2';
      Parcel.StrokeWidth := '4';
      Parcel.FillColor := 'ffffff';
      Parcel.FillOpacity := '0.0';
      Parcel.FeatureBuffer := 100;
      Parcel.Orientations := 'O';

      {Modifiers Config}
      searchModifiers := clsPictometrySearchWithParcelModifiers.Create;
      searchModifiers.MapHeight   := 1100;
      searchModifiers.MapWidth    := 720;
      searchModifiers.MapQuality  := 200;
      searchModifiers.ParcelInfo :=  Parcel;

      try
        with GetPictometryServerPortType(false, awsiPictometry) do
          begin
            GeoResponse := PictometryService_SearchByGeocodeWithParcel(Credentials,GeoSearch,searchModifiers);
            if GeoResponse.Results.Code = 0 then
              begin
                {Load Data Object to be send Back}
                dataPics := clsPictometryData.Create;
                dataPics.OrthogonalView  := GeoResponse.ResponseData.OrthogonalView;

                {Get parcel view}
                AerialImages := PictometryService_DownloadMaps(Credentials, dataPics);

                if AerialImages.Results.Code = 0 then
                  begin
                    //If Success Send Back Acknowledgement}
                    try
                      Acknowledgement := clsAcknowledgement.Create;
                      Acknowledgement.Received := 1;
                      if Assigned(GeoResponse.ResponseData) then
                         Acknowledgement.ServiceAcknowledgement := AerialImages.ResponseData.ServiceAcknowledgement;
                      with GetPictometryServerPortType(false, awsiPictometry) do
                         PictometryService_Acknowledgement(Credentials, Acknowledgement);
                    finally
                      Acknowledgement.Free;
                    end;
                   {Decode base64 data string }
                    ParcelImageView := Base64Decode(AerialImages.ResponseData.OrthogonalView);
                    result := True;
                  end
                else
                  result := False; //AerialImages.Results.Code is not 0
              end
            else
              result := False;  //GeoResponse.Results.Code is not 0

          //if Fail alert user and send back failure acknowledgement
          if not result then
            begin
              ShowAlert(atWarnAlert, GeoResponse.Results.Description);

              try
                Acknowledgement := clsAcknowledgement.Create;
                Acknowledgement.Received := 0;
                if Assigned(GeoResponse.ResponseData) then
                  Acknowledgement.ServiceAcknowledgement := GeoResponse.ResponseData.ServiceAcknowledgement;
                with GetPictometryServerPortType(false, awsiPictometry) do
                  PictometryService_Acknowledgement(Credentials, Acknowledgement);
              finally
                Acknowledgement.Free;
              end;
            end;
        end; //with
        except on E:Exception do
          ShowAlert(atWarnAlert, 'Error in getting Subject Parcel Map: '+e.Message);
        end;
      finally
        Credentials.Free;
        GeoSearch.Free;
        searchModifiers.Free;
        PopMouseCursor;
      end;
  end;
end;

function LoadSubjectParceViewByAddr(Street, city, state, zip: String; var ParcelImageView: WideString): Boolean;
var
  Credentials : clsUserCredentials;
  SearchModifiers : clsPictometrySearchWithParcelModifiers;
  AddrSearch: clsPictometrySearchByAddressRequest;
  AddrResponse: clsSearchByAddressResponse;
  Parcel: clsParcelInfo;
  Token, CompanyKey, OrderKey : WideString;
  dataPics: clsPictometryData;
  Acknowledgement : clsAcknowledgement;
  AerialImages: clsDownloadMapsResponse;
begin
    PushMouseCursor(crHourglass);
    {Get Token,CompanyKey and OrderKey}
//    if AWSI_GetCFSecurityToken(AWCustomerEmail, AWCustomerPSW, CurrentUser.LicInfo.UserCustID, Token, CompanyKey, OrderKey) then
  if GetFREEAWSISecutityToken(Token) then
    begin
      try
        {User Credentials}
        Credentials := clsUserCredentials.Create;
//### Use free token for this call, since user already bought pictometry should get this one for free
        Credentials.Username := 'compcruncher@bradfordsoftware.com';
        Credentials.Password := Token;
        Credentials.CompanyKey :='ed77ee59-87b5-afdf-92aa-1a3b14ef4e8e';
        Credentials.OrderNumberKey := 'xxxxxxxxxxxnotrequiredxxxxxxxxxx';
        Credentials.Purchase := 0;

       {Load Subject GeoCode}
        AddrSearch := clsPictometrySearchByAddressRequest.Create;
        AddrSearch.StreetAddress := trim(Street);
        AddrSearch.City := trim(City);
        AddrSearch.State := trim(State);
        AddrSearch.Zip   := trim(zip);

      {Parcel View Settings}
      Parcel := clsParcelInfo.Create;
      Parcel.StrokeColor := 'ffff00';
      Parcel.StrokeOpacity := 1.0;
    //  Parcel.StrokeWidth := '2';
      Parcel.StrokeWidth := '4';
      Parcel.FillColor := 'ffffff';
      Parcel.FillOpacity := '0.0';
      Parcel.FeatureBuffer := 100;
      Parcel.Orientations := 'O';

      {Modifiers Config}
      searchModifiers := clsPictometrySearchWithParcelModifiers.Create;
      searchModifiers.MapHeight   := 1100;
      searchModifiers.MapWidth    := 720;
      searchModifiers.MapQuality  := 200;
      searchModifiers.ParcelInfo :=  Parcel;

      try
        with GetPictometryServerPortType(false, awsiPictometry) do
          begin
            AddrResponse := PictometryService_SearchByAddressWithParcel(Credentials,AddrSearch,searchModifiers);
            if AddrResponse.Results.Code = 0 then
              begin
                {Load Data Object to be send Back}
                dataPics := clsPictometryData.Create;
                dataPics.OrthogonalView  := AddrResponse.ResponseData.OrthogonalView;

                {Get parcel view}
                AerialImages := PictometryService_DownloadMaps(Credentials, dataPics);

                if AerialImages.Results.Code = 0 then
                  begin
                    //If Success Send Back Acknowledgement}
                    try
                      Acknowledgement := clsAcknowledgement.Create;
                      Acknowledgement.Received := 1;
                      if Assigned(AddrResponse.ResponseData) then
                         Acknowledgement.ServiceAcknowledgement := AerialImages.ResponseData.ServiceAcknowledgement;
                      with GetPictometryServerPortType(false, awsiPictometry) do
                         PictometryService_Acknowledgement(Credentials, Acknowledgement);
                    finally
                      Acknowledgement.Free;
                    end;
                   {Decode base64 data string }
                    ParcelImageView := Base64Decode(AerialImages.ResponseData.OrthogonalView);
                    result := True;
                  end
                else
                  result := False; //AerialImages.Results.Code is not 0
              end
            else
              result := False;  //GeoResponse.Results.Code is not 0

          //if Fail alert user and send back failure acknowledgement
          if not result then
            begin
              ShowAlert(atWarnAlert, AddrResponse.Results.Description);

              try
                Acknowledgement := clsAcknowledgement.Create;
                Acknowledgement.Received := 0;
                if Assigned(AddrResponse.ResponseData) then
                  Acknowledgement.ServiceAcknowledgement := AddrResponse.ResponseData.ServiceAcknowledgement;
                with GetPictometryServerPortType(false, awsiPictometry) do
                  PictometryService_Acknowledgement(Credentials, Acknowledgement);
              finally
                Acknowledgement.Free;
              end;
            end;
        end; //with
        except on E:Exception do
          ShowAlert(atWarnAlert, 'Error in getting Subject Parcel Map: '+e.Message);
        end;
      finally
        Credentials.Free;
        AddrSearch.Free;
        searchModifiers.Free;
        PopMouseCursor;
      end;
  end;
end;


end.

