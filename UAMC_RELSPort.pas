unit UAMC_RELSPort;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2008 by Bradford Technologies, Inc. }

{ This unit is used to connect to the RELS/NAsoft web service for getting }
{ order details, validating the appraisal (mismo xml format) and sending  }
{ the final (validated) report with the PDF embedded in it.               }


(*

cSoftwareName = "ClickForms";
cSoftwarePasswordDevelopment = "92d@C0CCUJ23";
cSoftwarePasswordProduction = "kp2v9x7z";

       string GetRELSOrder(
            string baseUrl,
            string appIdentity, string appPassword,
            int orderNumber, string VID, string VPsw, string UID, string UPsw,
            out bool relsSuccess, out string relsErrorMessage, out string relsErrorKind);

 

        string GetRELSData(
            string baseUrl,
            string appIdentity, string appPassword,
            int orderNumber, bool declined, string VID, string VPsw, string UID, string UPsw,
            out bool relsSuccess, out string relsErrorMessage, out string relsErrorKind);

 

        string GetRELSValidation(
            string baseUrl,
            string appIdentity, string appPassword,
            int orderNumber, string xmlData, string VID, string VPsw, string UID, string UPsw,
            out bool relsSuccess, out string relsErrorMessage, out string relsErrorKind);

 

        string SubmitRELSReport(
            string baseUrl,
            string appIdentity, string appPassword,
            int orderNumber, string xmlData, string VID, string VPsw, string UID, string UPsw,
            out bool relsSuccess, out string relsErrorMessage, out string relsErrorKind);

 


*)
interface

uses
 Windows, Messages, SysUtils, Variants, RELSWseClient_TLB, ComObj, Controls,
 UGlobals, UWinUtils, UWebConfig, UAMC_RELSOrder, UAMC_RELSLogin;

const
  {Different types of Validation Results}
  relsStatSuccess = 0;
  relsStatWarning = 1;
  relsStatError = 3;

  {RELS ErrorTypes (kinds)}
  relsSuccess = 0;                  //Success
  relsRequiredFieldsMissing = 1;    //RequiredFieldsMissing
  relsAuthenticationFailed = 2;     //AuthenticationFailed
  relsUnauthorizedUser = 3;         //UnauthorizedUser
  relsRetriesExceeded = 4;          //RetriesExceeded
  relsInvalidData = 5;              //InvalidData
  relsValidationError = 6;          //ValidationError
  relsValidationWarning = 7;        //ValidationWarning
  relsValidationInfo = 8;           //ValidationInfo
  relsEnvUrl =  9;                  //error getting Env Url
  relsOther = 10;                    //Other
  relsSystemException = 11;         //SystemException

  {Needed to parse XML data received for result status}
  tagResponseGroup  = 'RESPONSE_GROUP';
  tagResponse       = 'RESPONSE';
  tagResponseData   = 'RESPONSE_DATA';
  tagRELSResponse   = 'RELS_VALIDATION_RESPONSE';

function RELSGetOrder(orderNo: Integer; RELSUser: RELSUserUID; out ErrCode: Integer; out ErrKind: string; out ErrMessage: string): string;
function RELSValidateXML(Order: RELSOrderInfo; XMLData: string;Guid: String; out ErrCode: Integer; out ErrKind: string; out ErrMessage: string): string;
function RELSSubmitGetToken(Order: RELSOrderInfo; XMLData: string;Guid: String; out ErrCode: Integer; out ErrKind: string; out ErrMessage: string): string;
function RELSGetData(Order: RELSOrderInfo; Declined: Boolean; out ErrCode: Integer; out ErrKind: string; out ErrMessage: string): string;
function RELSGetDAA(orderNo: Integer; RELSUser: RELSUserUID; out ErrCode: Integer; out ErrKind: string; out ErrMessage: string): string;
function RELSGetAcceptPageURL(token: String; out ErrCode: Integer; out ErrKind: String; out ErrMessage: string): string;

implementation

uses
  idHTTP, XmlDom, XmlDoc, XmlIntf, Forms, Classes,
  UStatus, UContainer, UUtil1, UProgress;


Const
  VendorID                  = '0';    //It constants now for any appraiser
  VendorPSW                 = 'CLVS-SAE';

  errCOMFailure = 'The RELS Connection module could not be found. Make sure it is correctly installed.';

function RELSErrKindToErrCode(ErrKind: String): Integer; forward;
procedure GetValidationStatus(XMLData: String; var hasWarning: Boolean; var statusCondition, statusDesc: String); forward;

{ This routine retrieves the order details from the RELS Service}
function RELSGetOrder(orderNo: Integer; RELSUser: RELSUserUID; out ErrCode: Integer; out ErrKind: string; out ErrMessage: string): string;
var
  RELSErrMsg: WideString;      //detailed message returned from RELS
  RELSErrKind: WideString;     //category/kind of error returned
  RELSSuccess: WordBool;       //was it successful
  handle: IConnection;
  XMLstring: WideString;
  Progress: TProgress;
begin
  RELSSuccess := False;      //assume failure
  ErrMessage := '';
  ErrKind := '';
  XMLstring := '';

  Progress := TProgress.Create(nil, 0, 10, 1, 'Retrieving Order Details');
  Progress.IncrementProgress;
  try
    //create the com object
    handle :=  CreateComObject(CLASS_RelsConnectionToCLF) as IConnection;
    if not assigned(handle) then
      begin
        ErrMessage := errCOMFailure;
        ErrCode := relsOther;
        ErrKind :=  'Other';
      end
    else
      try
        Progress.AnimateProgress(500, 8);

        XMLstring := handle.GetRELSOrder(GetBaseURLForRELS, cRELSSoftwareID, GetPSWForRELS,
                orderNo, RELSUser.VendorID, VendorPSW, RELSUser.UserId, RELSUser.UserPSW,
                RELSSuccess, RELSErrMsg, RELSErrKind);

        Progress.IncrementProgress;
        if RELSSuccess then
          begin
            ErrMessage := RELSErrMsg;
            ErrKind := RELSErrKind;
            ErrCode := RELSErrKindToErrCode(ErrKind); // := relsSuccess
            result := XMLstring;
          end
        else
          begin
            ErrMessage := RELSErrMsg;
            ErrKind := RELSErrKind;
            ErrCode := RELSErrKindToErrCode(ErrKind);
            result := '';
          end;

      except
        on E: Exception do
          begin
            ErrMessage := 'CLVS connection failure. ' + E.Message;
            ErrKind := 'SystemException';
            ErrCode := relsSystemException;
            result := '';
          end;
      end;
      Progress.IncrementProgress;
  finally
    Progress.Hide;
    Progress.Free;
  end;
end;

{ This routine validates the MISMO XML representation of the report}
{ You can have Success with Warnings & Failure with Error mesages  }
function RELSValidateXML(Order: RELSOrderInfo; XMLData: string; GUID : string; out ErrCode: Integer; out ErrKind: string; out ErrMessage: string): string;
var
  RELSErrMsg: WideString;      //detailed message returned from RELS
  RELSErrKind: WideString;     //category/kind of error returned
  RELSValidated: WordBool;     //was it successful
  hasWarning: Boolean;
  handle: IConnection;
  XMLstring: WideString;

begin
  RELSValidated := False;      //assume failure
  ErrMessage := '';
  ErrKind := '';
  XMLstring := '';


  try
  //create the com object
  handle :=  CreateComObject(CLASS_RelsConnectionToCLF) as IConnection;
  if not assigned(handle) then
    begin
      ErrMessage := errCOMFailure;
      ErrCode := relsOther;
      ErrKind :=  'Other';
    end
  else
    try

      XMLstring := Handle.GetRELSValidation(GetBaseURLForRELS,Guid, cRELSSoftwareID, GetPSWForRELS,
                   Order.OrderID, XMLData, VendorID, VendorPSW, Order.UserId, Order.UserPSW,
                   RELSValidated, RELSErrMsg, RELSErrKind);


      if RELSValidated then //passed validation
        begin
          //Have to look into XML for real status - should get from web service
          GetValidationStatus(XMLstring, hasWarning, ErrKind, ErrMessage);
          ErrCode := relsSuccess;      //force success
          if hasWarning then
            result := XMLstring;
        end
      else //validation found errors
        begin
          ErrMessage := RELSErrMsg;
          ErrKind := RELSErrKind;
          ErrCode := RELSErrKindToErrCode(ErrKind);
          result := XMLstring;
        end;

    except
      on E: Exception do
        begin
          ErrMessage := 'CLVS connection failure. ' + E.Message;
          ErrKind := 'SystemException';
          ErrCode := relsSystemException;
          result := '';
        end;
    end;

  finally

  end;
end;

{ This routine submits the vaidated report XML with an embedded PDF, ENV and gets token for env url}
function RELSSubmitGetToken(Order: RELSOrderInfo; XMLData: string; GUID : string;  out ErrCode: Integer; out ErrKind: string; out ErrMessage: string): string;
var
  RELSErrMsg: WideString;      //detailed message returned from RELS
  RELSErrKind: WideString;     //category/kind of error returned
  RELSAccepted: WordBool;      //was it successful
  handle: IConnection;
  token: WideString;

begin
  RELSAccepted := False;      //assume failure
  ErrMessage := '';
  ErrKind := '';
  token := '';
  try
    //create the com object
    handle :=  CreateComObject(CLASS_RelsConnectionToCLF) as IConnection;
    if not assigned(handle) then
      begin
        ErrMessage := errCOMFailure;
        ErrCode := relsOther;
        ErrKind :=  'Other';
      end
    else
      try
        token := handle.SubmitRelsReport(GetBaseURLForRELS,Guid, cRELSSoftwareID, GetPSWForRELS,
                    Order.OrderID, XMLData, VendorID, VendorPSW, Order.UserId, Order.UserPSW,
                    RELSAccepted, RELSErrMsg, RELSErrKind);

        if RELSAccepted then
          begin
            result := token;
          end
        else
          begin
            ErrMessage := RELSErrMsg;
            ErrKind := RELSErrKind;
            ErrCode := RELSErrKindToErrCode(ErrKind);
            result := '';
          end;

      except
        on E: Exception do
          begin
            ErrMessage := 'CLVS connection failure. ' + E.Message;
            ErrKind := 'SystemException';
            ErrCode := relsSystemException;
            result := '';
          end;
      end;
  finally
  end;
end;

//Get URL for APort site to accept or refuse submitting
function RELSGetAcceptPageURL(token: String; out ErrCode: Integer; out ErrKind: String; out ErrMessage: string): string;
var
  RELSErrMsg: WideString;      //detailed message returned from RELS
  RELSAccepted: WordBool;      //was it successful
  handle: IConnection;
  envUrl: WideString;
begin
  RELSAccepted := False;      //assume failure
  ErrMessage := '';
  ErrKind := '';
  envUrl := '';

  handle :=  CreateComObject(CLASS_RelsConnectionToCLF) as IConnection;
  if not assigned(handle) then
  begin
    ErrMessage := errCOMFailure;
    ErrCode := relsOther;
    ErrKind :=  'Other';
  end
    else
      try
        envUrl := handle.GetAcceptPageURL(GetBaseURLForRELS, token, RELSAccepted,RelsErrMsg);
       except
        on E: Exception do
          begin
            ErrMessage := 'CLVS connection failure. ' + E.Message;
            ErrKind := 'SystemException';
            ErrCode := relsSystemException;
            result := '';
          end;
       end;
  if not RelsAccepted then
   begin
      errMessage := RelsErrMsg;
      errKind := 'ErrorGettingEnvUrl';
      errCode := RELSErrKindToErrCode(errKind);
    end
  else
    errCode := relsSuccess;

  result :=  envUrl;
end;


{ This routine gets data from the RELS service ???}
function RELSGetData(Order: RELSOrderInfo; Declined: Boolean; out ErrCode: Integer; out ErrKind: string; out ErrMessage: string): string;
var
  RELSErrMsg: WideString;      //detailed message returned from RELS
  RELSErrKind: WideString;     //category/kind of error returned
  RELSSuccess: WordBool;       //was it successful
  handle: IConnection;
  XMLstring: WideString;
begin
  RELSSuccess := False;      //assume failure
  ErrMessage := '';
  ErrKind := '';
  XMLstring := '';

  //create the com object
  handle :=  CreateComObject(CLASS_RelsConnectionToCLF) as IConnection;
  if not assigned(handle) then
    begin
      ErrMessage := errCOMFailure;
      ErrCode := relsOther;
      ErrKind :=  'Other';
    end
  else
    try
//      handle.SetBaseURL(GetURLForRels);

      XMLstring := handle.GetRELSData(GetBaseURLForRELS, cRELSSoftwareID, GetPSWForRELS,
                    Order.OrderID, Declined, Order.VendorID, VendorPSW, Order.UserId, Order.UserPSW,
                    RELSSuccess, RELSErrMsg, RELSErrKind);

//      XMLstring := handle.GetRELSData(RELSSuccess, RELSErrMsg, RELSErrKind, Order.OrderID,
//                                      Declined, //boolean for something
//                                      Order.VendorID, VendorPSW, Order.UserId, Order.UserPSW);

      if RELSSuccess then
        begin
          ErrMessage := RELSErrMsg;
          ErrKind := RELSErrKind;
          ErrCode := RELSErrKindToErrCode(ErrKind); // := relsSuccess
          result := XMLstring;
        end
      else
        begin
          ErrMessage := RELSErrMsg;
          ErrKind := RELSErrKind;
          ErrCode := RELSErrKindToErrCode(ErrKind);
          result := '';
        end;

    except
      on E: Exception do
        begin
          ErrMessage := 'CLVS connection failure. ' + E.Message;
          ErrKind := 'SystemException';
          ErrCode := relsSystemException;
          result := '';
        end;
    end;
end;

{ This funciton converts the ErrTypes coming from RELS }
{ into codes for easier handling of the errTypes.}
function RELSErrKindToErrCode(ErrKind: String): Integer;
begin
  if compareText(ErrKind, 'Success') = 0 then
    result := relsSuccess
  else if compareText(ErrKind, 'RequiredFieldsMissing') = 0 then
    result := relsRequiredFieldsMissing
  else if compareText(ErrKind, 'AuthenticationFailed') = 0 then
    result := relsAuthenticationFailed
  else if compareText(ErrKind, 'UnauthorizedUser') = 0 then
    result := relsUnauthorizedUser
  else if compareText(ErrKind, 'RetriesExceeded') = 0 then
    result := relsRetriesExceeded
  else if compareText(ErrKind, 'InvalidData') = 0 then
    result := relsInvalidData
  else if compareText(ErrKind, 'ValidationError') = 0 then
    result := relsValidationError
  else if compareText(ErrKind, 'ValidationWarning') = 0 then
    result := relsValidationWarning
  else if compareText(ErrKind, 'ValidationInfo') = 0 then
    result := relsValidationInfo
  else if compareText(ErrKind,'ErrorGettingEnvUrl') = 0 then
    result := relsEnvUrl
  else if compareText(ErrKind, 'Other') = 0 then
    result := relsOther
  else if compareText(ErrKind, 'SystemException') = 0 then
    result := relsSystemException
  else
    result := relsOther;
end;

procedure GetValidationStatus(XMLData: String; var hasWarning: Boolean; var statusCondition, statusDesc: String);
const
  tagStatus         = 'STATUS';
  attrCondition     = '_Condition';
  attrDescription   = '_Description';
var
  xmlDoc: TXMLDocument;
  rootNode,rspNode,
  statNode,rspDataNode,
  relsValRspNode: IXMLNode;
begin
  xmlDoc := TXMLDocument.Create(Application.MainForm);
  xmlDoc.DOMVendor := GetDomVendor('MSXML');
  try
    try
      xmlDoc.LoadFromXML(XMLData);

      rootNode := xmlDoc.DocumentElement;
      if CompareText(rootNode.NodeName, tagResponseGroup) = 0 then
        if rootNode.HasChildNodes then
          begin
            rspNode := rootNode.ChildNodes.FindNode(tagResponse);
            statNode := rspNode.ChildNodes.FindNode(tagStatus);

            statusCondition := statNode.Attributes[attrCondition];
            statusDesc := statNode.Attributes[attrDescription];

            hasWarning := False;
            rspDataNode := rspNode.ChildNodes.FindNode(tagResponseData);
            if assigned(rspDataNode) then
              relsValRspNode := rspDataNode.ChildNodes.FindNode(tagRELSResponse);
            if assigned(relsValRspNode) then
              hasWarning := True;
          end;
    except
      raise Exception.Create('There is an error reading the RELS Validation Response.');
    end;
  finally
    xmlDoc.Free;
  end;
end;

{ This routine gets DAA data from the RELS service }
function RELSGetDAA(orderNo: Integer; RELSUser: RELSUserUID; out ErrCode: Integer; out ErrKind: string; out ErrMessage: string): string;
var
  RELSErrMsg: WideString;
  RELSErrKind: WideString;
  RELSSuccess: WordBool;
  handle: IConnection;
  XMLstring: WideString;

begin
  RELSSuccess := False;
  ErrMessage := '';
  ErrKind := '';
  XMLstring := '';

  handle :=  CreateComObject(CLASS_RelsConnectionToCLF) as IConnection;
  if not assigned(handle) then
    begin
      ErrMessage := errCOMFailure;
      ErrCode := relsOther;
      ErrKind :=  'Other';
     end
    else
      try
       XMLstring := handle.GetRELSDAA(GetBaseURLForRELS,'DAA_XML', cRELSSoftwareID, GetPSWForRELS,
                    orderNo,RELSUser.VendorID, VendorPSW, RELSUser.UserId, RELSUser.UserPSW,
                    RELSSuccess, RELSErrMsg, RELSErrKind);

        if RELSSuccess then
          begin
            ErrMessage := RELSErrMsg;
            ErrKind := RELSErrKind;
            ErrCode := RELSErrKindToErrCode(ErrKind);
            result := XMLstring;
          end
        else
          begin
            ErrMessage := RELSErrMsg;
            ErrKind := RELSErrKind;
            ErrCode := RELSErrKindToErrCode(ErrKind);
            result := '';
          end;

      except
        on E: Exception do
          begin
            ErrMessage := 'DAA connection failure. ' + E.Message;
            ErrKind := 'SystemException';
            ErrCode := relsSystemException;
            result := '';
          end;
      end;
end;

end.
