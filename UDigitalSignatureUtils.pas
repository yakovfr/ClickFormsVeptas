unit UDigitalSignatureUtils;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 2019 by Bradford Technologies, Inc. }

{ This is a utility unit used to create the public & private keys for a user as}
{ well the digital certificate for each of the user's appraisal certs or licenses}


interface

uses
  Forms, Controls, Classes, Chilkat_v9_5_0_TLB, UlkJSON, MSXML6_TLB, IdDateTimeStamp;

const
  //private, public keys and certificates store in "User Licences" folder: appPref_DirLicenses
  privKeyFileName   = '%s_PrivateKey.pem';      //where %s user licence name stripped of spaces
  publKeyFileName   = '%s_PublicKey.pem';       //where %s user licence name stripped of spaces
  digitCertFileName = '%s_%s_DigitalCert.pem';  //where first replacement is ser licence name stripped of spaces
                                                //second one is 2character state where appraiser state licence or certificate issued

  signNamespace  = 'http://www.w3.org/2000/09/xmldsig#';

type
  {CertificateInfoRecord = record
    state, LicNum, CertExpDate, fileName: String;
  end;    }

  KeyServiceRespRecord = record
    retCode: Integer;
    errMsg: String;
    privKey: String;
    publKey: String;
    cert: String;
  end;

  TDigitalSignatureMgr = Class(TObject)
    FMainWindow: TWinControl;     //needed by ChilKat DLL
    FUserLicFileName: String;
    FUserLicName: String;         //name used to sign report
    FUserLicState: String;        //state of lic or cert
    FUserLicNum: String;          //lic or cert number
    FUserCertState :String;       //state that comes from Cert files - can be used for double check
    FUserCertNo: String;          //users digital cert number
    FUserCertExpDate: String;     //users digital cert expiration

    FUserPrivateKey: String;      //users private key
    FUserPublicKey: String;       //users public key
    FUserDigitalCert: String;     //users dig cert for this state

    FHasPrivateKeyFile: Boolean;      //user has a private key file
    FHasPublicKeyFile: Boolean;       //user has a public key file
    FHasDigitalCertFile: Boolean;     //user has a digital cert for this state

    FPrivateKeyFilePath: String;  //path and file name of users private key
    FPublicKeyFilePath: String;   //path and file name of users public key
    FDigCertFilePath: String;     //path and file name of users public key

    function ConvertRFC822DateToTDateTime(RFC822Str: string): TDateTime;
    function CreateJSONCertRequest(apprLicName, privKey, State, LicNum: String): String;
    function ParseDistinguishedName(DN: string): string;
    function ParseKeyResponse(response: String; certJsName: string): KeyServiceRespRecord;
    function CreatePublKeyFromPrivateKey: string;

    function CreateMismoXmlDoc(xmlStr: String; var xmlDoc: IXMLDOMDocument3; var ErrMsg: string): Boolean;
    function PrepareMismoXMLtoSign(var xmlDoc: IXMLDOMDocument3; var errMsg: string): Boolean;
    function CreateSignedInfoNode(var xmlDoc: IXMLDOMDocument3; var signInfoNode: IXMLDOMNode;  var errMsg: string): Boolean;
    function GetRSAKeyValues(cert: TChilkatCert; var Modulus: String; var Exponent: String; var errMsg: String): Boolean;
    function CreateKeyInfoNode(var xmlDoc: IXMLDOMDocument3; var nodeKeyInfo: IXMLDOMNode; var errMsg: String): Boolean;
    function CreateSignatureValueNode(var xmlDoc: IXMLDOMDocument3; signedInfoNode: IXMLDomNode; var SignatureValueNode: IXMLDOMNode; var errMsg: string): Boolean;
    function SignMISMOXML(var xmlStr: String; {certName: String;} var errMsg: String): Boolean;
  private
     function  FHAPreprocess(srcXML: String): String;
  public
    constructor Create;
    Procedure InitDigitalMgr;
    function SetupDigitalMgrFor(AppraiserLicName, AppraiserLicState: String): Boolean;
    procedure SetupDigitalMgr(licName, LicST, LicNum, LicFName: String);
    function HasDigitalCertFilesToSignDoc: Boolean;

    procedure WriteToFilePrivateKey;
    procedure WriteToFilePublicKey;
    procedure WriteToFileCertificate;

    function ReadFromFilePrivateKey: Boolean;
    function ReadFromFilePublicKey: Boolean;
    function ReadFromFileDigitalCertificate: Boolean;

    procedure GetDigitalCertInfo;  //same as ParseKeyResponse

    function CreateCertificate(var errMsg: String): Boolean;
    function RenewCertificate(var errMsg: string): Boolean;

    property UserCertNumber: String read FUserCertNo write FUserCertNo;
    property UserCertExpDate: String read FUserCertExpDate write FUserCertExpDate;
    property UserHasCertificate: Boolean read FHasDigitalCertFile write FHasDigitalCertFile;
  end;


var
  userLicName: String;


implementation

uses
  SysUtils, StrUtils, DateUtils, Variants,
  ULicUser, UGlobals, UStatus, UWebUtils, UUtil1, UAMC_Utils;

const
  awKeyServiceID        = '20700EF5002EEE81B0240EB94DE16C6713EB414D8EFAE5F76910E6A64022D8E1E5D689DF260F8D8B227F252F74659867';
  awProdKeyServiceURL   = 'https://webservices.appraisalworld.com/ws/awsi/CreateKeyFiles.php';
  awDeveloKeyServiceURL = 'http://10.128.0.2/secure/ws/awsi/CreateKeyFiles.php';

  ChilkatLicUnlockCode = 'BRDFRD.CB1042020_BTKzuN7Z1CoI';   //unlocking code for DigCert Utility

  httpRespOK = 200;


{ TDigitalSignatureMgr }

constructor TDigitalSignatureMgr.Create;
begin
  inherited Create;

  InitDigitalMgr;
end;

Procedure TDigitalSignatureMgr.InitDigitalMgr;
var
  chilkatGlob: TChilkatGlobal;
begin
  FUserLicName        := '';      //name used to sign report
  FUserLicState       := '';      //state of lic or cert
  FUserLicNum         := '';      //lic or cert number
  FUserLicFileName    := ''; 
  FUserCertNo         := '';      //users cert number
  FUserCertExpDate    := '';      //users cert expiration

  FPrivateKeyFilePath := '';      //path and file name of users private key
  FPublicKeyFilePath  := '';      //path and file name of users public key
  FDigCertFilePath    := '';      //path and file name of users digital cert

  FUserPrivateKey     := '';      //users private key
  FUserPublicKey      := '';      //users public key
  FUserDigitalCert    := '';      //the users digital certificate for this state lic/cert

  FHasPrivateKeyFile  := False;   //user has a private key file
  FHasPublicKeyFile   := False;   //user has a public key file
  FHasDigitalCertFile := False;   //user has a digital cert for this state

  FMainWindow := Application.MainForm;  //needed by Clihkat DLL

  chilkatGlob := TChilkatGlobal.Create(FMainWindow);
  try
    if ChilkatGlob.UnlockStatus = 0 then  //0: locked; 1: demo mode; 2: license key
      chilkatGlob.UnlockBundle(ChilkatLicUnlockCode);
  finally
    chilkatGlob.Free;
  end;
end;

//get the AppraiserLicName from FDoc.GetCellTextByID(ApprNameCellID);
function TDigitalSignatureMgr.SetupDigitalMgrFor(AppraiserLicName, AppraiserLicState: String): Boolean;
var
  i: Integer;
  ALicName, licST, licNo: String;
  ALicFileName: String;
  AUser: TLicensedUser;
begin
  result := False;

  //find the appraisers license file by their signature name
  for i := 0 to LicensedUsers.count-1 do
    begin
      ALicName := TUser(LicensedUsers.Items[i]).FLicName;
      if CompareText(ALicName, AppraiserLicName) = 0 then            //match name on form
        begin
          ALicFileName := TUser(LicensedUsers.Items[i]).FFileName;
          AUser := TLicensedUser.create;
          try
            AUser.LoadUserLicFile(ALicFileName);

//            LicName := AUser.SWLicenseName;
            licST   := '';
            licNo   := '';
            if AUser.WorkLic.Count > 0 then
              begin
                licST := AUser.WorkLic.License[0].State;
                licNo := AUser.WorkLic.License[0].Number;
              end;

            if CompareText(licST, AppraiserLicState) = 0 then       //match state on form
              if (licST <> '') and  (licNo <> '') then
                begin
                  SetupDigitalMgr(ALicName, LicST, licNo, ALicFileName);

                  break;
                  result := True;
                end
          finally
            AUser.free;
          end;
        end;
    end;

  if not result then
    ShowNotice('None of the digital certificates matched any of the files in the User License folder.');
end;

procedure TDigitalSignatureMgr.SetupDigitalMgr(licName, LicST, LicNum, LicFName: String);
begin
  FUserLicName      := licName;      //name used to sign report
  FUserLicState     := LicST;        //state of lic or cert
  FUserLicNum       := LicNum;       //lic or cert number
  //FUserLicFileName  := LicFName;     //name of the user's lic file  NOT USED - CAN DELETE

  FUserCertNo       := 'Not Created Yet';   //users digital cert number
  FUserCertExpDate  := '';                  //users digital cert expiration

  FUserPrivateKey   := '';;         //users private key
  FUserPublicKey    := '';          //users public key
  FUserDigitalCert  := '';          //users dig cert


  FPrivateKeyFilePath := IncludeTrailingPathDelimiter(appPref_DirLicenses) + Format(privKeyFileName,[LicName]);  //path and file name of users private key
  FPublicKeyFilePath  := IncludeTrailingPathDelimiter(appPref_DirLicenses) + Format(publKeyFileName,[LicName]);  //path and file name of users public key
  FDigCertFilePath    := IncludeTrailingPathDelimiter(appPref_DirLicenses) + Format(digitCertFileName, [LicName,LicST]);   //path and file name of users public key
  FUserLicFileName    := IncludeTrailingPathDelimiter(appPref_DirLicenses) + LicName + '.lic';

  //determine if user has the files without loading them
  FHasPrivateKeyFile  := FileIsValid(FPrivateKeyFilePath);      //user has a private key file
  FHasPublicKeyFile   := FileIsValid(FPublicKeyFilePath);       //user has a public key file
  FHasDigitalCertFile := FileIsValid(FDigCertFilePath);         //user has a digital cert for this state
end;

function TDigitalSignatureMgr.HasDigitalCertFilesToSignDoc: Boolean;
begin
  result := FHasPrivateKeyFile and FHasPublicKeyFile and FHasDigitalCertFile; //we have the files
  if result then //check cert expire date
    begin
      //GetDigitalCertInfo;
      //check the expiration date
      //if expire date < today then result := false;
    end;
end;

function TDigitalSignatureMgr.CreateCertificate(var errMsg: String): Boolean;
var
  reqString, respString: String;
  respCertName: String;
  serviceRespRec: KeyServiceRespRecord;
begin
  result := false;
  errMsg := '';

  if FHasPrivateKeyFile and (FUserPrivateKey <> '') then   //has PrivateKey file, but not loaded
    ReadFromFilePrivateKey;

  reqString := CreateJSONCertRequest(FUserLicName, FUserPrivateKey, FUserLicState, FUserLicNum);
  respString := httpPost(awProdKeyServiceURL, reqString, errMsg);

  if length(respString) > 0 then
    begin
      respCertName := FUserLicState + '-' + FUserLicNum;
      serviceRespRec := ParseKeyResponse(respString, respCertName);

      if serviceRespRec.retCode = 0 then  //save the digital files
        begin

          FUserDigitalCert := serviceRespRec.cert;    //users dig cert for this state
          WriteToFileCertificate;                            //save the new cert

          if length(FUserPrivateKey) = 0 then  //were Private & Pub keys created
            begin
              FUserPrivateKey := serviceRespRec.privKey;      //users private key
              WriteToFilePrivateKey;

              FUserPublicKey  :=serviceRespRec.publKey;       //users public key
              WriteToFilePublicKey;
            end;

          GetDigitalCertInfo;

          result := True;
        end
      else
        errMsg := serviceRespRec.errMsg;
    end
  else //respStr = 0
    errMsg := 'The Digital Certificate service is not available.';
end;

function TDigitalSignatureMgr.RenewCertificate(var errMsg: string): Boolean;
var
  reqString, respString: String;
  respCertName: String;
  serviceRespRec: KeyServiceRespRecord;
begin
  result := false;
  errMsg := '';

  if FHasPrivateKeyFile then
    begin
      if (FUserPrivateKey <> '') then   //has PrivateKey file, but not loaded
        ReadFromFilePrivateKey;

      reqString := CreateJSONCertRequest(FUserLicName, FUserPrivateKey, FUserLicState, FUserLicNum);
      respString := httpPost(awProdKeyServiceURL, reqString, errMsg);

      if length(respString) > 0 then
        begin
          respCertName := FUserLicState + '-' + FUserLicNum;
          serviceRespRec := ParseKeyResponse(respString, respCertName);

          if serviceRespRec.retCode = 0 then
            begin
              FUserDigitalCert := serviceRespRec.cert;    //users dig cert for this state
              WriteToFileCertificate;                            //save the new cert

              GetDigitalCertInfo;   //sets FUserCertNo & FUserCertExpDate

              result := true;
            end
          else
            errMsg := serviceRespRec.errMsg;
        end
      else
        errMsg := 'The Digital Certificate service is not available.';
    end
  else
   ShowNotice('Your digital Private Key is missing. It is needed to renew your original Digital Certificate. ' +
      'Please restore your Private Key file from your backup location');
end;

procedure TDigitalSignatureMgr.WriteToFilePrivateKey;
var
  strm: TFileStream;
begin
  if length(FUserPrivateKey) > 0 then
    begin
      strm := TFileStream.Create(FPrivateKeyFilePath, fmCreate); //overwrite the existing one
      try
        strm.Write(PChar(FUserPrivateKey)^, length(FUserPrivateKey));
      finally
        strm.Free;
      end;
    end
  else
    ShowNotice('The Private Key is empty and cannot be saved.');
end;

procedure TDigitalSignatureMgr.WriteToFilePublicKey;
var
  strm: TFileStream;
begin
  if length(FUserPublicKey) > 0 then
    begin
      strm := TFileStream.Create(FPublicKeyFilePath, fmCreate); //overwrite the existing one
      try
        strm.Write(PChar(FUserPublicKey)^, length(FUserPublicKey));
      finally
        strm.Free;
      end
    end
  else
    ShowNotice('The Public Key is empty and cannot be saved.');
end;

procedure TDigitalSignatureMgr.WriteToFileCertificate;
var
  strm: TFileStream;
begin
  if length(FUserDigitalCert) > 0 then
    begin
      strm := TFileStream.Create(FDigCertFilePath, fmCreate);
      try
        strm.Write(PChar(FUserDigitalCert)^, length(FUserDigitalCert));
      finally
        strm.Free;
      end
    end
  else
    ShowNotice('The Digital Certificate is empty and cannot be saved.');
end;

function TDigitalSignatureMgr.ReadFromFilePrivateKey: Boolean;
var
  strm: TFileStream;
begin
  result := False;
  if FHasPrivateKeyFile then
    begin
      strm := TFileStream.Create(FPrivateKeyFilePath, fmOpenRead);
      try
        SetLength(FUserPrivateKey, strm.Size);
        strm.Read(PChar(FUserPrivateKey)^, length(FUserPrivateKey));
        result := True;
      finally
        strm.Free;
      end;
    end;
end;

function TDigitalSignatureMgr.ReadFromFilePublicKey: Boolean;
var
  strm: TFileStream;
begin
  result := False;
  if FHasPublicKeyFile then
    begin
      strm := TFileStream.Create(FPublicKeyFilePath, fmOpenRead);
      try
        SetLength(FUserPublicKey, strm.Size);
        strm.Read(PChar(FUserPublicKey)^, length(FUserPublicKey));
        result := True;
      finally
        strm.Free;
      end;
    end;
end;

function TDigitalSignatureMgr.ReadFromFileDigitalCertificate: Boolean;
var
  strm: TFileStream;
begin
  result := False;
  if FHasDigitalCertFile then
    begin
      strm := TFileStream.Create(FDigCertFilePath, fmOpenRead);
      try
        SetLength(FUserDigitalCert, strm.Size);
        strm.Read(PChar(FUserDigitalCert)^, length(FUserDigitalCert));
        result := True;
      finally
        strm.Free;
      end;
    end;
end;

function TDigitalSignatureMgr.ParseDistinguishedName(DN: string): String;
var
  delimPos: integer;
begin
  result := '';
  delimPos := Pos('OID', DN);
  if delimPos = 0 then
    exit;
  delimPos := PosEx('=',DN, delimPos);
  if delimPos = 0 then
    exit;

  Result :=  Copy(DN, delimPos +1, length(DN) - delimPos);
end;

procedure TDigitalSignatureMgr.GetDigitalCertInfo;
var
  cert: TChilkatCert;
begin
  if FHasDigitalCertFile then //this means there was a files with correct name
    begin
      cert := TChilkatCert.Create(FMainWindow);
      try
        if cert.LoadFromFile(FDigCertFilePath) = 1 then
          begin
            FUserCertState  := cert.SubjectS;     //can be used for checking
            FUserCertNo     := ParseDistinguishedName(cert.SubjectDN);
            DateTimeToString(FUserCertExpDate, 'mm/dd/yyyy', ConvertRFC822DateToTDateTime(cert.ValidToStr));
          end
        else
          ShowNotice('This certificate is invalid: ' + FDigCertFilePath);
      finally
        cert.Free;
      end;
    end;
end;

//This function is never called by anyone
function TDigitalSignatureMgr.CreatePublKeyFromPrivateKey: string;
var
  privKey: TPrivateKey;
  publKey : IPublicKey;
  retCode: Integer;
begin
  result := '';
  privKey := TPrivateKey.Create(FMainWindow);
  try
    retCode := privKey.LoadPemFile(FPrivateKeyFilePath);
    if retCode <> 1 then
      exit;

    publKey := privKey.getPublicKey;
    if not assigned(publKey) then
      exit;

    retCode := publKey.SavePemFile(0, FPublicKeyFilePath);
    if retCode <> 1 then
      exit;

    result := FPublicKeyFilePath;
  finally
    privKey.Free;
  end;
end;

function TDigitalSignatureMgr.ConvertRFC822DateToTDateTime(RFC822Str: string): TDateTime;
var
  indyDateTime: TIdDateTimeStamp;
begin
  indyDateTime := TIdDateTimeStamp.Create(FMainWindow);
  try
    indyDateTime.SetFromRFC822(RFC822Str);
    result := indyDateTime.AsTDateTime;
  finally
    indyDateTime.Free;
  end;
end;


function TDigitalSignatureMgr.CreateJSONCertRequest(apprLicName, privKey, State, LicNum: String): String;
const
  nameFullname    = 'fullname';
  nameID          = 'id';
  namePrivatekey  = 'private_key';
  nameLicences    = 'licenses';
  nameLicense     = 'license';
  nameIssueState  = 'issue_state';
var
  jsObjRequest, jsObjLic: TlkJSONObject;
  jsListLics: TlkJSONlist;
begin
  result := '';

  jsObjRequest  := TlkJSONObject.Create(true);
  jsObjLic      := TlkJSONObject.Create(true);
  jsListLics    := TlkJSONlist.Create;
  with jsObjRequest do
    begin
      Add(nameFullname,apprLicName);
      Add(nameID,awKeyServiceID);
      Add(namePrivatekey,privKey);
      jsObjLic.Add(nameLicense,LicNum);
      jsObjLic.Add(nameIssueState, state);
      jsListLics.Add(jsObjLic);
      Add(nameLicences, jsListLics);
    end;
  result := TlkJSON.GenerateText(jsObjRequest);
end;

function TDigitalSignatureMgr.ParseKeyResponse(response: String; certJsName: string): KeyServiceRespRecord;
  procedure EmptyResponseRec;
  begin
    result.retCode  := -1;
    result.errMsg   := '';
    result.privKey  := '';
    result.publKey  := '';
    result.cert     := '';
  end;
const
  nameResults     = 'Results';
  nameCode        = 'Code';
  nameDescription = 'Description';
  nameResponseData = 'ResponseData';
  namePrivateKey  = 'private_key';
  namePublicKey   = 'public_key';
  nameLicList     = 'csr_list';
var
  jsResponse: TlkJsonObject;
  retCode: Integer;
begin
  EmptyResponseRec;
  try
    jsResponse := TlkJSON.ParseText(response) as TlkJsonObject;
    retCode :=  StrToIntDef(VarToStr(TlkJsonObject(TlkJsonObject(jsResponse.Field[nameResults]).Field[nameCode]).Value), -1);
    if retCode <> 0 then
      begin
        EmptyResponseRec;
        result.retCode := retCode;
        result.errMsg := VarToStr(TlkJsonObject(TlkJsonObject(jsResponse.Field[nameResults]).Field[nameDescription]).Value);
        exit;
      end;
    result.retCode  := retCode;
    result.privKey  := VarToStr(TlkJsonObject(TlkJsonObject(jsResponse.Field[nameResponseData]).Field[namePrivateKey]).Value);
    result.publKey  := VarToStr(TlkJsonObject(TlkJsonObject(jsResponse.Field[nameResponseData]).Field[namePublicKey]).Value);
    result.cert     := VarToStr(TlkJsonObject(TlkJsonObject(TlkJsonObject(jsResponse.Field[nameResponseData]).Field[nameLicList]).Field[certJsName]).Value);
  except
    on E:Exception do
      begin
        EmptyResponseRec;
        result.errMsg := E.Message;
        exit;
      end;
  end;
end;

function TDigitalSignatureMgr.CreateMismoXmlDoc(xmlStr: String; var xmlDoc: IXMLDOMDocument3; var ErrMsg: string): Boolean;
const
  xpathReport = '/VALUATION_RESPONSE/REPORT';
var
  node: IXMLDomNode;
begin
  result := false;
  errMsg := '';

  xmlDoc := CoDomDocument60.Create;
  with xmlDoc do
    begin
      async := false;
      SetProperty('SelectionLanguage', 'XPath');

      try
        loadXML(xmlStr);
      except
        On E:exception do
          begin
            errMsg := 'Invalid Mismo XML: ' + E.message;
            exit;
          end;
      end;

      if parseError.errorCode <> 0 then
        begin
          errMsg := 'Invalid MISMO XML: ' +  parseError.reason;
          exit;
        end;

      node := SelectSingleNode(xpathReport);
      if not assigned(node) then
        begin
          errMsg := 'Invalid MISMO XML';
          exit;
        end;

      result := true;
    end;
end;

function TDigitalSignatureMgr.PrepareMismoXMLtoSign(var xmlDoc: IXMLDOMDocument3; var errMsg: string): Boolean;
const
  xPathPlaceForSignature = '/VALUATION_RESPONSE/REPORT/FORM/IMAGE/EMBEDDED_FILE[@_Type="DigitalSignature"]/DOCUMENT';
  xpathReport           = '/VALUATION_RESPONSE/REPORT';
  xPathForm             = '/VALUATION_RESPONSE/REPORT/FORM';
  elForm                = 'FORM';
  elImage               = 'IMAGE';
  elEmbeddedFile        = 'EMBEDDED_FILE';
  elDocument            = 'DOCUMENT';
  attrContentSequence   = 'AppraisalReportContentSequenceIdentifier';
  attrContentType       = 'AppraisalReportContentType';
  attrTypeOther         = 'AppraisalReportContentTypeOtherDescription';
  attrContentTypeValue  = 'Other';
  attrTypeOtherValue    = 'Signature';
  attrType              = '_Type';
  attrTypeValue         = 'DigitalSignature';
var
  reportNode,formNode,imageNode,embeddedFileNode, documentNode, firstNonFormReportChild, node: IXMLDomNode;
  existFormNodesNum, ReportChildCount: Integer;
  attr : IXMLDOMAttribute;
  reportNonFormChildExists: boolean;
  xmlStr: String;
begin
  result := false;
  errMsg := '';
  reportNonformChildExists := false;
  existFormNodesNum := 0;

  node := xmlDoc.selectSingleNode(xPathPlaceForSignature);
  if assigned(node) then
    begin
      result := true;  //XML already prepared for digital signature
      exit;
    end;

  reportNode := xmlDoc.selectSingleNode(xpathReport);
  if not assigned(reportNode) then  // it can not happen, we already check it
    begin
      errMsg := 'Invalid MISMO XML';
      exit;
    end;
  ReportChildCount := reportNode.childNodes.length;
  if ReportChildCount > 0 then
    existFormNodesNum := reportNode.selectNodes(xPathForm).length;
  if existFormNodesNum < ReportChildCount then  //there non form elements in the report node
    reportNonFormChildExists := true;

  formNode          := xmlDoc.createNode(NODE_ELEMENT, elForm, '');
  attr              := xmlDoc.createAttribute(attrContentSequence);
  attr.value        := intToStr(existFormNodesNum +1);
  formNode.attributes.SetNamedItem(attr);

  attr        := xmlDoc.createAttribute(attrContentType);
  attr.value  := attrContentTypeValue;
  formNode.attributes.SetNamedItem(attr);

  attr        := xmlDoc.createAttribute(attrTypeOther);
  attr.value  := attrTypeOtherValue;
  formNode.attributes.SetNamedItem(attr);

  imageNode := xmlDoc.createNode(NODE_ELEMENT, elImage, '');

  EmbeddedFileNode := xmlDoc.createNode(NODE_ELEMENT, elEmbeddedFile, '');

  attr        := xmlDoc.createAttribute(attrType);
  attr.Value  := attrTypeValue;
  EmbeddedFileNode.attributes.setNamedItem(attr);

  documentNode := xmlDoc.createNode(NODE_ELEMENT, elDocument, '');
  EmbeddedFileNode.appendChild(documentNode);
  imageNode.appendChild(EmbeddedFileNode);
  formNode.appendChild(imageNode);
  if reportNonFormChildExists then
    begin
      firstNonFormReportChild := reportNode.childNodes[existFormNodesNum];
      reportNode.insertBefore(formNode, firstNonFormReportChild);
    end
  else
    reportNode.appendChild(formNode);
  // get rid of CR, LF, tab character
  xmlStr := GetIXMLDocXMLString(xmlDoc);
  xmlStr := FHAPreprocess(xmlStr);
  //reload XmlDoc
  xmlDoc.loadXML(xmlStr);

  result := true;
end;

function TDigitalSignatureMgr.CreateSignedInfoNode(var xmlDoc: IXMLDOMDocument3; var signInfoNode: IXMLDOMNode;  var errMsg: string): Boolean;
const
  elSignedInfo      = 'SignedInfo';
  elCanonMethod     = 'CanonicalizationMethod';
  elSignatureMethod = 'SignatureMethod';
  elReference       = 'Reference';
  elTransforms      = 'Transforms';
  elTransform       = 'Transform';
  elDigestMethod    = 'DigestMethod';
  elDigestValue     = 'DigestValue';
  atrAlgorithm      = 'Algorithm';
  algCanonMethod    = 'http://www.w3.org/2001/10/xml-exc-c14n#';
  algSignatureMethod = 'http://www.w3.org/2000/09/xmldsig#rsa-sha1';
  algSignTransform  = 'http://www.w3.org/2000/09/xmldsig#enveloped-signature';
  algDigestMethod = 'http://www.w3.org/2000/09/xmldsig#sha1';
var
  canonicalXML: String;
  DSig: TChilkatXmlDSig;
  crypt: TChilkatCrypt2;
  hashStr: String;
  node, subNode, subSubNode: IXMLDOMNode;
  attr : IXMLDOMAttribute;
begin
  //canonicalization MISMO
  result := false;
  try
    DSig := TChilkatXmlDSig.Create(FMainWindow);
    try
      canonicalXML := DSig.CanonicalizeXml(GetIXMLDocXMLString(xmlDoc),'EXCL_C14N',0); //exclusive canonicalization, no comment
    finally
      DSig.Free;
    end;

    if length(canonicalXML) = 0 then
      begin
        errMsg := 'Cannot canonicalize the MISMO XML file';
        exit;
      end;

    //create MISMO hash
    crypt := TChilkatCrypt2.Create(FMainWindow);
    try
      crypt.HashAlgorithm := 'sha1';
      crypt.EncodingMode := 'base64';
      crypt.charset := 'utf-8';
      hashStr := crypt.HashStringENC(canonicalXML);
    finally
      crypt.Free;
    end;

    if length(hashStr) = 0 then
      begin
        errMsg := 'Cannot Create hash of the MISMO XML file';
        exit;
      end;

    //create XML node
    signInfoNode := xmlDoc.createNode(NODE_ELEMENT, elSignedInfo, signNamespace);

    node := xmlDoc.createNode(NODE_ELEMENT, elCanonMethod, signNamespace);
    attr := xmlDoc.createAttribute(atrAlgorithm);
    attr.value := algCanonMethod;
    node.attributes.setNamedItem(attr);
    signInfoNode.appendChild(node);

    node := xmlDoc.createNode(NODE_ELEMENT, elSignatureMethod, signNamespace);
    attr := xmlDoc.createAttribute(atrAlgorithm);
    attr.value := algSignatureMethod;
    node.attributes.setNamedItem(attr);
    signInfoNode.appendChild(node);

    node := xmlDoc.createNode(NODE_ELEMENT, elReference, signNamespace);
    subNode := xmlDoc.createNode(NODE_ELEMENT, elTransforms, signNamespace);

    subSubNode := xmlDoc.createNode(NODE_ELEMENT, elTransform, signNamespace);
    attr := xmlDoc.createAttribute(atrAlgorithm);
    attr.value := algSignTransform;
    subSubNode.attributes.setNamedItem(attr);
    subNode.appendChild(subSubNode);

    subSubNode := xmlDoc.createNode(NODE_ELEMENT, elTransform, signNamespace);
    attr := xmlDoc.createAttribute(atrAlgorithm);
    attr.value := algCanonMethod;
    subSubNode.attributes.setNamedItem(attr);
    subNode.appendChild(subSubNode);

    node.appendChild(subNode);

    subNode := xmlDoc.createNode(NODE_ELEMENT, elDigestMethod, signNamespace);
    attr := xmlDoc.createAttribute(atrAlgorithm);
    attr.value :=  algDigestMethod;
    subNode.attributes.setNamedItem(attr);
    node.appendChild(subNode);

    subNode := xmlDoc.createNode(NODE_ELEMENT, elDigestValue,signNamespace);
    subNode.appendChild(xmlDoc.createTextNode(hashStr));
    node.appendChild(subNode);

    signInfoNode.appendChild(node);
    except
      on E:Exception do
        begin
          errMsg := E.Message;
          exit;
        end;
    end;
    result := true;
end;

function TDigitalSignatureMgr.GetRSAKeyValues(cert: TChilkatCert; var Modulus: String; var Exponent: String; var errMsg: String): Boolean;
const
  xPathModulus      = '/RSAPublicKey/Modulus';
  xPathExponent     = '/RSAPublicKey/Exponent';
  xPathRSAPublicKey = '/RSAPublicKey';
var
  publKey: IPublicKey;
  publKeyXML: String;
  publKeyXMLDoc: IXMLDomDocument3;
  node : IXMLDomNode;
begin
  result      := false;
  errMsg      := '';
  modulus     := '';
  exponent    := '';
  publKey     := cert.ExportPublicKey;
  publKeyXML  := publKey.GetXml;

  publKeyXMLDoc := CoDomDocument60.Create;
  with publKeyXMLDoc do
  begin
    async := false;
    SetProperty('SelectionLanguage', 'XPath');
    try
      if not publKeyXMLDoc.loadXML(publKeyXML) then
        begin
          errMsg := 'Cannot extract Public Key from Certificate';
          exit;
        end
    except
      On E:exception do
        begin
          errMsg := 'Invalid certificate file: ' + E.message;
          exit;
        end;
    end;

    if parseError.errorCode <> 0 then
      begin
        errMsg := 'Invalid certificate file: ' +  parseError.reason;
        exit;
      end;

    node := publKeyXMLDoc.SelectSingleNode(xPathModulus);
    if not assigned(node) then
    begin
      errMsg := 'Invalid certificate file';
      exit;
    end;

    modulus   := node.text;
    node      := publKeyXMLDoc.selectSingleNode(xPathExponent);
    exponent   := node.text;

    result  := true;
  end;
end;

function TDigitalSignatureMgr.CreateKeyInfoNode(var xmlDoc: IXMLDOMDocument3; var nodeKeyInfo: IXMLDOMNode; var errMsg: String): Boolean;
const
  elKeyInfo           = 'KeyInfo';
  elX509Data          = 'X509Data';
  elX509SubjectName   = 'X509SubjectName';
  el509IssuerSerial   = 'X509IssuerSerial';
  el509IssuerName     = 'X509IssuerName';
  elX509SerialNumber  = 'X509SerialNumber';
  elX509Certificate   = 'X509Certificate';
  elKeyValue          = 'KeyValue';
  elRSAKeyValue       = 'RSAKeyValue';
  elModulius          = 'Modulus';
  elExponent          = 'Exponent';
var
  subjCNname, subjState, subjApprLicense: String;
  issuerCNname, issuerState, issuerLicense: String;
  certSerialNumber: string;
  cert: TChilkatCert;
  node, subNode, subSubNode: IXMLDomNode;
  modulus, exponent: String;
  subjectStr, issuerStr: String;
  encodCertStr: String;

  //FHA requires to escape some characters in XML elements X509subjectName and X509IssuerName
  function EscapePunctuationMarks(origString: string): String;
  const
      charsToEscape =  [',', '\', '#', '+', '<', '>', ';', '"', '='];
  var
    cntr, strLen: integer;
  begin
    result := '';
    strLen := length(origString);
    for cntr := 1 to strLen do
      if origString[cntr] in charsToEscape then
        result := result + '\' + origString[cntr]
      else
        result := result + origString[cntr];
  end;

begin
  result    := false;
  errMsg    := '';
  modulus   := '';
  exponent  := '';

  //certPath := IncludeTrailingPathDelimiter(appPref_DirLicenses) + certFName;      //### replace with object value
  if not FileExists(FDigCertFilePath) then  //cannot happens; we already check
    begin
      errMsg := 'Cannot find the Security Certificate.';
      exit;
    end;

  cert := TChilkatCert.Create(FMainWindow);
  try
    cert.LoadFromFile(FDigCertFilePath);
    if not GetRSAKeyValues(cert, modulus, exponent, errMsg) then
      begin
        errMsg := 'Cannot read Public Key';
        exit;
      end;

    subjCNName      := trim(EscapePunctuationMarks(cert.SubjectCN));
    subjState       := cert.SubjectS;
    subjApprLicense := trim(EscapePunctuationMarks(ParseDistinguishedName(cert.SubjectDN)));
    issuerCNname    := trim(EscapePunctuationMarks(cert.IssuerCN));
    issuerState     := cert.IssuerS;
    issuerLicense   := trim(EscapePunctuationMarks(ParseDistinguishedName(cert.IssuerDN)));
    certSerialNumber := cert.SerialDecimal;

    nodeKeyInfo := xmlDoc.createNode(NODE_ELEMENT, elKeyInfo, signNamespace);
    node        := xmlDoc.createNode(NODE_ELEMENT, elKeyValue, signNamespace);
    subNode     := xmlDoc.createNode(NODE_ELEMENT, elRSAKeyValue, signNamespace);

    subSubNode := xmlDoc.createNode(NODE_ELEMENT, elModulius, signNamespace);
    subSubNode.appendChild(xmlDoc.createTextNode(modulus));
    subNode.appendChild(subSubNode);

    subSubNode := xmlDoc.createNode(NODE_ELEMENT, elExponent, signNamespace);
    subSubNode.appendChild(xmlDoc.createTextNode(exponent));
    subNode.appendChild(subSubNode);

    node.appendChild(subNode);
    nodeKeyInfo.appendChild(node);

    node := xmlDoc.createNode(NODE_ELEMENT, elX509Data, signNamespace);

    subNode := xmlDoc.createNode(NODE_ELEMENT, elX509SubjectName, signNamespace);
    subjectStr := 'CN=' + subjCNname + ', ST=' + subjState + ', UID=' + subjApprLicense;
    subNode.appendChild(xmlDoc.createTextNode(subjectStr));
    node.appendChild(subNode);

    subNode := xmlDoc.CreateNode(NODE_ELEMENT, el509IssuerSerial, signNamespace);

    subSubNode := xmlDoc.createNode(NODE_ELEMENT, el509IssuerName, signNamespace);
    IssuerStr := 'CN=' + IssuerCNname + ', ST=' + IssuerState + ', UID=' + IssuerLicense;
    subSubNode.appendChild(xmlDoc.createTextNode(subjectStr));
    subNode.appendChild(subsubNode);

    subSubNode := xmldoc.createNode(NODE_ELEMENT, elX509SerialNumber, signNamespace);
    subSubNode.appendChild(xmlDoc.createTextNode(certSerialNumber));
    subNode.appendChild(subsubNode);
    node.appendChild(subNode);

    subNode := xmlDoc.createNode(NODE_ELEMENT, elX509Certificate, signNamespace);
    encodCertStr := cert.GetEncoded;
    if length(encodCertStr) = 0 then
      errMsg := 'Invalid Certificate.';      //###YAKOV - why continue if its invalid??

    subNode.appendChild(xmlDoc.createTextNode(encodCertStr));
    node.appendChild(subNode);
    nodeKeyInfo.appendChild(node);

    result := true;
  finally
    if assigned(cert) then
      cert.Free;
  end;
end;

function TDigitalSignatureMgr.CreateSignatureValueNode(var xmlDoc: IXMLDOMDocument3; signedInfoNode: IXMLDomNode; var SignatureValueNode: IXMLDOMNode; var errMsg: string): Boolean;
const
  elSignatureValue = 'SignatureValue';
var
  dsig: TChilkatXmlDSig;
  RSA: TChilkatRsa;
  privKey: TPrivateKey;
  privKeyXML: string;
  signatureValueStr: string;
begin
  result := false;
  //canonicalization
  dsig := TChilkatXmlDSig.Create(FMainWindow);
  try
    signatureValueStr := dsig.CanonicalizeXml(signedInfoNode.xml,'EXCL_C14N',0);
  finally
    dsig.Free;
  end;
  //sign with private key
  privKey := TPrivateKey.Create(FMainWindow);
  RSA     := TChilkatRsa.Create(FMainWindow);
  try
    if privKey.LoadPemFile(FPrivateKeyFilePath) <> 1 then
      begin
        errMsg := 'The report cannot be digitally signed. Private key errors encountered';
        exit;
      end;

    privKeyXML := privKey.GetXml;
    if length(privKeyXML) = 0 then
        begin
          errMsg := 'The report cannot be digitally signed. Private key errors encountered';
          exit
        end;

    if RSA.ImportPrivateKey(privkeyXml) <> 1 then
      begin
        errMsg := 'The report cannot be digitally signed. Private key errors encountered';
        exit;
      end;

    RSA.LittleEndian    := 0;
    RSA.EncodingMode    := 'base64';
    signatureValueStr   := RSA.SignStringENC(signatureValueStr,'sha-1');
    SignatureValueNode  := xmlDoc.createNode(NODE_ELEMENT, elSignatureValue, signNamespace);
    SignatureValueNode.appendChild(xmlDoc.createTextNode(signatureValueStr));

    result := true;
  finally
    privKey.Free;
    RSA.Free;
  end;
end;

function TDigitalSignatureMgr.SignMISMOXML(var xmlStr: String; {certName: String;} var errMsg: String): Boolean;
const
  xPathSignature  = '/VALUATION_RESPONSE/REPORT/FORM/IMAGE/EMBEDDED_FILE[@_Type="DigitalSignature"]/DOCUMENT/Signature';
  xPathDocument   = '/VALUATION_RESPONSE/REPORT/FORM/IMAGE/EMBEDDED_FILE[@_Type="DigitalSignature"]/DOCUMENT';
  elSignature     = 'Signature';
  attrId          = 'Id';
  attrIdValue     = 'APPRAISAL_SIGNATURE';
  attrSchemaInst = 'xmlns:xsi';
  attrSchema = 'xmlns:xsd';
  attrSchemaInstValue = 'http://www.w3.org/2001/XMLSchema-instance';
  attrSchemaValue = 'http://www.w3.org/2001/XMLSchema';
var
  xmlDoc: IXMLDOMDocument3;
  elSignedInfo, elKeyInfo, elSignatureValue: IXMLDomNode;
  documentNode, SignatureNode: IXMLDomNode;
  attr: IXMLDomAttribute;
begin
  errMsg := '';
  result := false;

  if not CreateMismoXmlDoc(xmlStr, xmlDoc, errMsg) then
    exit;
  if not PrepareMismoXMLtoSign(xmlDoc, errMsg) then
    exit;

  if not CreateSignedInfoNode(xmlDoc, elSignedInfo, errMsg) then
    exit;
  if not CreateKeyInfoNode(xmlDoc, elKeyInfo, errMsg) then
    exit;
  if not CreateSignatureValueNode(xmlDoc, elSignedInfo, elSignatureValue, errMsg) then
    exit;

  //do sign report
  documentNode := xmlDoc.selectSingleNode(xPathDocument);   //we just created it

  signatureNode := xmlDoc.createNode(NODE_ELEMENT, elSignature, signNamespace);
  attr := xmlDoc.createAttribute(attrSchemaInst);
  attr.value := attrSchemaInstValue;
  signatureNode.attributes.setNamedItem(attr);
  attr := xmlDoc.createAttribute(attrSchema);
  attr.value := attrSchemaValue;
  signatureNode.attributes.setNamedItem(attr);
  signatureNode.appendChild(elSignedInfo);
  signatureNode.appendChild(elSignatureValue);
  signatureNode.appendChild(elKeyInfo);
  attr := xmlDoc.createAttribute(attrID);
  attr.value := attrIdValue;
  signatureNode.attributes.setNamedItem(attr);

  documentNode.appendChild(signatureNode);

  xmlStr := GetIXMLDocXMLString(xmlDoc);
  result  := True;
end;

function  TDigitalSignatureMgr.FHAPreprocess(srcXML: String): String;
   // Pre-process the XML prior to canonicalization. FHA/Veros strips all linefeeds and
    //  element spacing (indenting) prior to hashing so we have to match.
   begin
    result := StringReplace(srcXml, #9, '', [rfReplaceAll]);
    result := StringReplace(result, #10, '', [rfReplaceAll]);
    result := StringReplace(result, #13, '', [rfReplaceAll]);
   end;

end.
