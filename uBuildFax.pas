unit uBuildFax;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids_ts, TSGrid, UForms, PartnerBuildFaxReportServer,UContainer, UBase, UGlobals,
  ULicUser, UStatus, StdCtrls, UGridMgr, UUtil2, MSXML6_TLB,UWebConfig, invokeRegistry,
  UBase64, UCustomerServices, ComCtrls, UWinUtils, UInsertMgr, UInsertPDF, UMyClickForms,
  UWebUtils, UCell, WinInet, ClfCustServices2014, ExtCtrls, OleCtrls,
  GdPicturePro5_TLB, Buttons, UAWSI_Utils, AWSI_Server_BuildFax, USendHelp, UStrings,Jpeg,
  uEditor;


  function LoadBuildFax(doc: TContainer; AddrInfo: AddrInfoRec; var Abort: Boolean; var sl: TStringList):Boolean;


implementation


uses
  UUtil1;




var
      FPDFDataStr: String;
      FNAddrLimit: Integer;
      Viewer: TGdViewer;
      FCurPage: Integer;

const
  //cell & form IDs
  cidBFaxPDFCell     = 451;
  fidBuildFaxExhibit = 987;









function VerifyRequest(AddrInfo:AddrInfoRec): boolean;
var
  AddrLen, CityLen, StateLen, ZipLen, Plus4Len, Idx: Integer;
begin
  AddrLen := Length(Trim(AddrInfo.StreetAddr));
  CityLen := Length(Trim(AddrInfo.City));
  StateLen := Length(Trim(AddrInfo.State));
  ZipLen := Length(GetFirstNumInStr(AddrInfo.Zip, True, Idx));
  Result := (AddrLen > 0) and (CityLen > 0) and (StateLen = 2) and (ZipLen = 5);
end;


function GetCF_BuildFaxData(AddrInfo: AddrInfoRec; var dataXML: string; var badAddrs: String; var Abort: Boolean; var resultMsg: String; var sl:TStringList): Boolean;
var
  dwSize, exsRecevingTimeout, receiveTimeout : DWORD;
  BTPartnerCredential: PartnerBuildFaxReportServer.clsUserCredentials;
  addrNo, nAddrs : integer;
  servAddresses: Array of clsSearchAddress;
  servResponse: clsGetReportResponse;
begin
  result := false;
  dataXML := '';
  badAddrs := '';
  resultMsg := '';

  BTPartnerCredential := PartnerBuildFaxReportServer.clsUserCredentials.Create;
  try
    //set service credentials
    BTPartnerCredential.Username := partnerBuildFaxBTID;
    BTPartnerCredential.Password := partnerBuildFaxBTPassword;
    BTPartnerCredential.CustomerOrderNumber := Format('%s',[CurrentUser.UserCustUID]);

    SetLength(servAddresses, length(servAddresses) + 1);
    servAddresses[length(servAddresses) - 1] := clsSearchAddress.Create;
    with servAddresses[length(servAddresses) - 1] do
     begin
        AddressID := addrNo;
        StreetAddress := AddrInfo.StreetAddr;
        City := AddrInfo.City;
        State := AddrInfo.State;
        Zip := AddrInfo.Zip;
        Title := 'Subject';
      end;

    //the service is slow, let's expend timeout
    dwSize := sizeof(exsRecevingTimeout);
    receiveTimeout := 300000;  //5 minutes

    Application.ProcessMessages;

    InternetQueryOption(nil,INTERNET_OPTION_RECEIVE_TIMEOUT,@exsRecevingTimeout,dwSize);
    InternetSetOption(nil,INTERNET_OPTION_RECEIVE_TIMEOUT,@receiveTimeout,dwSize);

    //get buildfax data
    with GetPartnerBuildFaxReportServerPortType(True, GetURLForPartnerBuildfaxService) do
      begin
        PushMouseCursor(crHourGlass);
        try
          Application.ProcessMessages;
          servResponse := PartnerBuildFaxReportService_GetReport(BTPartnerCredential,clsGetReportSearchAddresses(servAddresses));
          Application.ProcessMessages;
          if servResponse.Results.Code <> 0 then
            begin
              resultMsg := servResponse.Results.Description;
              sl.Add(resultMsg);
              Abort := not OK2Continue(servResponse.Results.Description+ '. Continue?');
              //ShowNotice(servResponse.Results.Description);
              exit;
            end;
        except
          on e: Exception do  //unknown generic error
            begin
              resultMsg := e.Message;
              sl.Add(resultMsg);
              Abort := not Ok2Continue(resultMsg + '.  Continue?');
              //ShowNotice(e.Message);
              exit;
            end;
        end;
      end;

      //we got data
      result := true;
      try
        resultMsg := servResponse.Results.Description;
        sl.Add(resultMsg);
        FPDFDataStr := Base64decode(servResponse.ResponseData.BuildFaxReport);
        viewer.DisplayFromString(FPDFDataStr);
        // 120811 JWyatt Position the scroll bar so data appears in top-down order
        Viewer.SetVScrollBarPosition(0);
        FCurPage := Viewer.CurrentPage;     //set this so button state works
      except
      end;

      dataXML := servResponse.ResponseData.Data;
      badAddrs := servResponse.ResponseData.BadAddresses;
      sl.Add('Bad Address: '+badAddrs);
  finally
    PopMouseCursor;
    FreeAndNil(BTPartnerCredential);
    SetLength(servAddresses,0);
  end;
end;



// -1 = Service unavailable
//  1 = regular service available
//  2 = demo is available
function IsServiceAvailable: Integer;
var
  servInfo: serviceInfo;
  msgText: String;
begin
  result := statusNotApplicable;   // service is unavailable
  try
    RefreshServStatuses;
    servInfo := GetServiceByServID(stBuildFax);
  except
    on e: Exception do
      begin
        msgText := e.Message;
        ShowNotice(msgText);
        exit;
      end;
  end;

  case servInfo.status of
    statusOK:
      result := servInfo.servType;
    statusNoUnits:
      begin
        {msgText := 'You do not have any available BuildFAX Report units.'#13#10 +
                'Please contact Bradford Technologies at ' + OurPhoneNumber + ' to purchase additional units ';
        ShowNotice(msgText);    } // no message to user, check AWSI
        exit;
      end
    else
      begin
        {msgText := 'You are not registered for the BuildFax service.'#13#10 +
                  'Please contact Bradford Technologies at ' + OurPhoneNumber + 'to purchase it.';
        ShowNotice(msgText);  }   // no message to user, check AWSI
        exit;
      end;
  end;
end;

function GetCFAW_BuidFaxData(AddrInfo: AddrInfoRec; var dataXML: string; var badAddrs: String; var Abort:Boolean; sl:TStringList): Boolean;
const
  rspLogin  = 6;
var
  dwSize, exsRecevingTimeout, receiveTimeout : DWORD;
  Credentials : AWSI_Server_BuildFax.clsUserCredentials;
  Token,CompanyKey,OrderKey : WideString;
  addrNo, nAddrs, rsp : integer;
  servAddresses: Array of clsSearchAddress;
  servResponse: clsGetBatchAddressesResponse;
  ACKResponse: clsAcknowledgement;
begin
  result := false;
  dataXML := '';
  badAddrs := '';

  {Get Token,CompanyKey and OrderKey}
  if AWSI_GetCFSecurityToken(AWCustomerEmail, AWCustomerPSW, CurrentUser.UserCustUID, Token, CompanyKey, OrderKey) then
    try
      {User Credentials}
      Credentials := AWSI_Server_BuildFax.clsUserCredentials.create;
      Credentials.Username := AWCustomerEmail;
      Credentials.Password := Token;
      Credentials.CompanyKey := CompanyKey;
      Credentials.OrderNumberKey := OrderKey;
      Credentials.Purchase := 0;

      //set addresses for the service
      SetLength(servAddresses, length(servAddresses) + 1);
      servAddresses[length(servAddresses) - 1] := clsSearchAddress.Create;
      with servAddresses[length(servAddresses) - 1] do
      begin
        StreetAddress := AddrInfo.StreetAddr;
        City := AddrInfo.City;
        State := AddrInfo.State;
        Zip := AddrInfo.Zip;
        Title := 'Subject';
      end;

      //the service is slow, let's expend timeout
      dwSize := sizeof(exsRecevingTimeout);
      receiveTimeout := 300000;  //5 minutes
      InternetQueryOption(nil,INTERNET_OPTION_RECEIVE_TIMEOUT,@exsRecevingTimeout,dwSize);
      InternetSetOption(nil,INTERNET_OPTION_RECEIVE_TIMEOUT,@receiveTimeout,dwSize);

      //get buildfax data
      with GetBuildFaxReportServerPortType(False, GetAWURLForPartnerBuildfaxService) do
        begin
          PushMouseCursor(crHourGlass);
          try
            Application.ProcessMessages;
            servResponse := BuildFaxReportService_GetReport(Credentials,clsSubmitBatchAddressesRequest(servAddresses));
            Application.ProcessMessages;
            if servResponse.Results.Code = 0 then
              begin
                sl.Add('Get Property Permit Data From AppraisalWorld.Com successfully.');
                //acknowledge response
                ACKResponse := clsAcknowledgement.Create;
                ACKResponse.Received := 1;
                ACKResponse.ServiceAcknowledgement := servResponse.ResponseData.ServiceAcknowledgement;
                BuildFaxReportService_Acknowledgement(Credentials, ACKResponse);
              end
            else
              begin
                // Note: The maximum length of the response message should be 230 characters or
                //  less. Otherwise it may overflow the space in the WarnWithOption12 dialog.
                //  This could change if the dialog display field is changed to a memo.
                rsp := WarnWithOption12('Purchase', 'Continue', servResponse.Results.Description, 1, False);
                sl.Add(servResponse.Results.Description);
                if rsp = rspLogin then
                  HelpCmdHandler(cmdHelpAWShop4Service, CurrentUser.UserCustUID, CurrentUser.AWUserInfo.UserLoginEmail);   //link to the AppraisalWorld store
                exit;
              end;
          except
            on e: Exception do  //unknown generic error
              begin
                //ShowNotice(e.Message);
                Abort := not Ok2Continue(e.Message+'. Continue?');
                exit;
              end;
          end;
        end;

        //we got data
        result := true;
        try
          FPDFDataStr := Base64decode(servResponse.ResponseData.BuildFaxReport);
          viewer.DisplayFromString(FPDFDataStr);
          sl.Add('Retrieving Property Permit PDF data...');
          // 120811 JWyatt Position the scroll bar so data appears in top-down order
          Viewer.SetVScrollBarPosition(0);
          FCurPage := Viewer.CurrentPage;     //set this so button state works
        except
        end;
        dataXML := servResponse.ResponseData.Data;
        badAddrs := servResponse.ResponseData.BadAddresses;
    finally
      PopMouseCursor;
      FreeAndNil(Credentials);

      SetLength(servAddresses,0);

      //restore internet receive timeout
      InternetSetOption(nil,INTERNET_OPTION_RECEIVE_TIMEOUT,@exsRecevingTimeout,dwSize);
    end;
end;

function ReadDataXml(xmlStr: String): Integer;
const
  xpathStr = '/BuildFaxData/PropertySummaryList/PropertySummary[%d]/%s';
var
  xmlDoc: IXMLDOMDocument2;
  propNo, nProps: Integer;
  curRow: Integer;
  isBadAddr: Boolean; 	//new
 begin
 result := 0;
  xmlDoc := CoDomDocument.Create;
  with xmlDoc do
    begin
      async := false;
      setProperty('SelectionLanguage', 'XPath');
      loadXML(xmlStr);
      if parseError.errorCode = 0 then
        result := 1;   //at least one good address
        //exit;

     //Save('c:\temp\data.xml');
(*
     nProps := selectNodes('/BuildFaxData/PropertySummaryList/PropertySummary').length;
     for propNo := 1 to nProps do
      with addrGrid do
        begin
          curRow := StrToIntDef(selectSingleNode(format(xPathStr,[propNo,'AddressId'])).text,0);
          isBadAddr := StrToIntDef(selectSingleNode(format(xPathStr,[propNo,'BadAddress'])).text,-1) > 0;
          if isBadAddr then
            continue;
          result := result + 1;
          cell[colLastPermit,curRow] := selectSingleNode(format(xPathStr,[propNo,'LatestPermit'])).text;
          cell[colPermits,currow] := selectSingleNode(format(xPathStr,[propNo,'NumberOfPermits'])).text;
          cell[colPermValuation,curRow] := selectSingleNode(format(xPathStr,[propNo,'PermitValuation'])).text;
        end;
*)
    end;
end;

procedure ReadBadDataXml(xmlStr: String);
const
  xpathStr = '/BadAddresses/Address[%d]/%s';
var
 xmlDoc: IXMLDOMDocument2;
  propNo, nProps: Integer;
  curRow: Integer;
begin
  xmlDoc := CoDomDocument.Create;
  with xmlDoc do
    begin
      async := false;
      setProperty('SelectionLanguage', 'XPath');
      loadXML(xmlStr);
      if parseError.errorCode <> 0 then
        exit; //can not happen

      //Save('c:\temp\BadData.xml');
      FNAddrLimit := StrToIntDef(SelectSingleNode('//AddressLimit').text,0);
(*
      nProps := selectNodes('/BadAddresses/Address').length;
      for propNo := 1 to nProps do
        with addrGrid do
          begin
            curRow := StrToIntDef(selectSingleNode(format(xPathStr,[propNo,'CallerAddressId'])).text,0);
            cell[colNote,curRow] := selectSingleNode(format(xPathStr,[propNo,'EntryType'])).text;
          end;
*)
    end;
end;

procedure InsertPDFIntoEditor(FDoc:TContainer; Page: Integer);
const
  CErrorMessage = 'There was a problem loading PDF page #%d. Continue importing?';
var
  Bitmap: TBitmap;
  JPEG: TJPEGImage;
  Stream: TMemoryStream;
begin
  Bitmap := nil;
  JPEG := nil;
  Stream := nil;

  if assigned(FDoc.docEditor) and (FDoc.docEditor is TGraphicEditor) then
    try
      Bitmap := TBitmap.Create;
      JPEG := TJPEGImage.Create;
      Stream := TMemoryStream.Create;
      try
        Viewer.DisplayFrame(Page);
        Bitmap.Handle := Viewer.GetHBitmap;  //Note: if use TGdViewerCnt can save directly to JPEG Stream
        if (Bitmap.Width = 0) and (Bitmap.Height = 0) then
          OutOfMemoryError;

        // get setup load a stream into editor
        JPEG.Assign(Bitmap);
        FreeAndNil(Bitmap);         //free some memory

        JPEG.SaveToStream(stream);
        FreeAndNil(JPEG);           //free some memory

        Stream.Position := 0;
        TGraphicEditor(FDoc.docEditor).LoadImageStream(Stream);
        FreeAndNil(Stream);         //free some mamory
      except
        on E: Exception do
          begin
            if not WarnOK2Continue(Format(CErrorMessage, [Page])) then
              Abort;
          end;
      end;
    finally
      if assigned(Bitmap) then
        FreeAndNil(Bitmap);
      if assigned(JPEG) then
        FreeAndNil(JPEG);
      if assigned(Stream) then
        FreeAndNil(Stream);
    end;
end;

function GetNewBFaxAddendumCell(FDoc: TContainer): TBaseCell;
var
  Cell: TBaseCell;
//  Form: TDocForm;
  FormUID: TFormUID;
begin
  FormUID := TFormUID.Create;
  try
    result := nil;
    FormUID.Vers := 1;
    FormUID.ID := fidBuildFaxExhibit;

    Cell := FDoc.InsertFormUID(FormUID, True, -1).GetCellByID(cidBFaxPDFCell);
    if assigned(cell) then
      Result := Cell;
  finally
    FreeAndNil(FormUID);
  end;
end;



procedure TransferBuildFaxToReport(FDoc:TContainer);
var
  cell: TBaseCell;
  Page: Integer;
begin
  PushMouseCursor(crHourglass);
  try
    Application.ProcessMessages;   //redraw the container
    FDoc.FreezeCanvas := True;

    for Page := 1 to Viewer.PageCount do
      begin
        cell := GetNewBFaxAddendumCell(FDoc);
        if assigned(cell) then
          begin
            FDoc.MakeCurCell(Cell);       //make sure cell is active
            InsertPDFIntoEditor(FDoc, Page);    //make the PDF page active & insert
            Application.ProcessMessages;
          end;
      end;
  finally
    Viewer.LockControl := False;
    FDoc.FreezeCanvas := False;
    PopMouseCursor;
  end;
end;




function LoadBuildFax(doc: Tcontainer; AddrInfo: AddrInfoRec; var Abort: Boolean; var sl:TStringList):Boolean;
var
  dataXML, badAddrs: String;
  srvType: Integer;
  strSubjAddress: String;
  ServiceID: Integer;
  msg, ResultString: String;
 begin
  try
    FCurPage:= -1;
    Viewer := TGdViewer.Create(nil);
    Viewer.LicenseKEY := VIEWER_LIC_KEY;
    try
      srvType := isServiceAvailable;          // return servTypeRegular or servTypeDemo if user has units on custDB
      if srvType >= servTypeRegular then
        begin
          ServiceID := 1;  //the service on custDB

          if not GetCF_BuildFaxData(AddrInfo, dataXML,badAddrs, Abort, resultString, sl) then  // it cannot happens, we just check
          begin
            msg := 'Property Permit Data not Available in BradfordSoftware.com.';
            sl.Add(msg);
            Abort := not OK2Continue(msg + ' Continue?');
            exit;
          end;
        end
      else  //check AW BuildFax availibity
        begin
          ServiceID := 2;  //the service on AWSI
          if (not IsAWLoginOK(AWCustomerEmail, AWCustomerPSW)) or (not GetCFAW_BuidFaxData(AddrInfo, dataXML, badAddrs, Abort, sl)) then
          begin
            msg := 'Error in getting Property Permit Data From Appraisal World.';
            sl.Add(msg);
            Abort := not OK2Continue(msg +' Continue?');
            exit;  //we already show error message in GetBuildFaxData
          end;
        end;

      //update usage
        strSubjAddress := AddrInfo.StreetAddr + ', ' + AddrInfo.City + ', ' +
                          AddrInfo.State + ', ' + AddrInfo.Zip;
      //if we have at least 1 good address & we're using bradfordsoftware.com credits
      // otherwise, don't call UpdateServiceUsage, AW acknowledgment is in GetCFAW_BuidFaxData
      if (ReadDataXML(dataXML) > 0) and (ServiceID = 1) then
      begin
        sl.Add('We have at least 1 good address and we''re using BradfordSoftware.com Credits');
        UpdateServiceUsage(stBuildfax, srvType, strSubjAddress);
      end;
      //ReadDataXML(dataXML);
      ReadBadDataXml(badAddrs);
      TransferBuildFaxToReport(doc);
      sl.Add('Transfer Property Permit Data to Report.');
    finally
      Viewer.Free;
    end;
  except on E:Exception do
    begin
     //ShowAlert(atWarnAlert,errOnBuildFax+' | '+E.Message);
      Abort := not Ok2Continue(errOnBuildFax + ' | '+E.Message + '. Continu?');
    end;
  end;
end;


end.
