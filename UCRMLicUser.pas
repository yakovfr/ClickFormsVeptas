unit UCRMLicUser;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted � 2018 by Bradford Technologies, Inc. }

{This unit handles all the functions of the Current User including}
{product license validation, available products, and signatures. }

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}


interface

uses
	Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
	StdCtrls, Mask, ExtCtrls, ComCtrls, Contnrs,USubscriptionMgr,UServiceLoginForm,
  UGraphics, UCRMLicConfirmation,AWSI_Server_Clickforms;

const
{File Version IDs}
  cLicFileVers2  = 2;
  cLicFileVers3  = 3;    //added AW Credentials, unfortunately - no AW Version#
  cLicFileVers4  = 4;    //expanded AW Credentials, now with version#
  cLicFileVers5  = 5;    // 9/2018 consolidated US and Canadian Lic Files

{CompareDate TValueRelationship constant}
  LessThanValue    = -1;
  EqualsValue      = 0;
  GreaterThanValue = 1;
  

{File Object Version IDs}
  cContactVers1  = 1;
  cContactVers2  = 2;    // 8/2018 - removed unused strings
  cWorkLicVers1  = 1;
  cSWLicVers1    = 1;
  cSWLicVers2    = 2;
  cSWLicVers3    = 3;
  cSWLicVers4    = 4;   // 7/2018 simplified registration - removed PIDs, Serials Groups, etc
  cSWLicVers5    = 5;   // 8/2018 combined US and Canadian lic file structures
  cAWCredVers2   = 2;    //added version to AW Credentials - use FileVersion to distinguish
  cAWCredVers3   = 3;    // 9/2018 - consolidated US and Canadian


{Types of Worker Licenses}
  cCertType = 1;
  cLicType  = 2;

{New License Types}
  ltUndefinedLic    = 0;
  ltSubscriptionLic = 1;
  ltEvaluationLic   = 2;
  ltExpiredLic      = 3;   //NOTE: New Expired and Old have same vlaue
  ltForceUpdate     = 4;   //

  ltTermYearly = 12;   //yearly subscription
  ltTermMonthly = 1;   //monthly subscription

{OLD - License types}
  ltValidLic  = 1;
  ltTempLic   = 2;
//ltExpiredLic= 3;         //NOTE: Old Expired value = New Expired value
  ltUDEFLic   = 4;

{ NOTE: There are License Codes and License Types}
{OLD - Codes represented Types in LicFile}
  cTempLicCode    = 7195;                 // temp lic code
  cValidLicCode   = 8943;                 // valid lic code
  cExpiredCode    = 1894;                 // expired lic code
  cUDEFLicCode    = 0;                    // undefinded lic code

  LicFileExt    = '.Lic';
  cLicPrefs     = 'LicensePref.ini';    //simple ini file

//AWCeredential Encryption keys
  AWEncryptKey1:Word = 27531;     //login
  AWEncryptKey2:Word = 24687;     //password



//Proucts IDs
///PAM_REG: check some of the services are using these 
  pidClickForms         = 0;
  pidAppWorldConnection = 1;  //removed in version 5.5, make sure no one depends on it in CustDB
  pidOnlineLocMaps      = 2;
  pidOnlineFloodMaps    = 3;
  pidTechSupport        = 4;  //not used - Basic Technical Support
  pidClickFormsUpdates  = 5;  //ClickForms Maintenance
  pidMercuryNetwork     = 7;  //Ticket 1202
  pidSwiftEstimator     = 8;
  pidAreaSketchDesktop  = 9;
  pidAreaSketchPPC      = 10;  //not used
  pidAppraisalPort      = 11;
//  pidLightHouse         = 12; //not used
  pidPropertyDataImport = 13;
  pidMLSDataImport      = 14;
  pidRelsConnection     = 15;
  pidUndefined1         = 16;  //not used
  pidUndefined2         = 17;  //not used
  pidUADForms           = 18;
  pidMCAnalysis         = 20;
  pidPictometry         = 21;
  pidBuildFax           = 22;
  pidPhoenixMobile      = 23;
  pidRapidSketch        = 24;  //not used
  pidAPEX               = 25;  //not used
  pidAWAppraisalSentry  = 26;  //not used
  pidAWRovAvm           = 27;  //not used
  pidAWValuationResearch = 28;  //not used

///PAM_REG: we need all these pid below for the service calls  
  MaxPid = 28;
  pidCF: array[0..MaxPid] of Integer = (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,0,0,19,1,1,1,1,1,0,0,0,0,0);
  pidAW: array[0..MaxPid] of Integer = (101,0,102,3,103,101,4,160,40,111,0,104,0,105,109,106,0,0,107,5,8,41,13,32,0,0,7,38,36);
  pidExpires: array[0..MaxPid] of Boolean = (True,True,True,True,False,True,True,False,True,True,False,True,
                                             False,True,True,True,False,False,True,False,False,False,False,False,
                                             False,False,False,False,False);
  pidUsage: array[0..MaxPid] of Boolean = (False,False,True,True,False,False,True,False,True,False,False,False,
                                           True,False,False,False,False,False,False,True,False,False,False,False,
                                           False,False,False,False,False);
  pidCFUsageName: array[0..MaxPid] of String = ('ClickForms Maintenance','','Location Maps','Flood Maps','ClickForms Support',
                                                '','VeroValue Reports','','Marshall & Swift Service','','','AppraisalPort Connection',
                                                'Lighthouse Connection','Data Import Connection','MLS Connection','RELS Connection','','',
                                                'UAD Compliance Module','Fidelity National Information Service','Market Conditions Analysis',
                                                'Pictometry','BuildFax','PhoenixMobile','','','','','');
  pidCFRegName: array[0..MaxPid] of String = ('ClickFORMS Software','AppraisalWorld Connection','OnLine Location Maps','OnLine Flood Maps',
                                              'Technical Support','ClickFORMS Updates','VeroValue Reports','','Marshall & Swift Service',
                                              'AreaSketch-Desktop','AreaSketch PocketPC','AppraisalPort','Lighthouse','VendorPropertyDataImport','MLS Connection',
                                              'Rels Connection','','','UAD Service','Fidelity National Information Service','Market Conditions Analysis',
                                              'Pictometry','BuildFax','PhoenixMobile','','','','','');

type
  //this is contact info for the license user
  TContact  = class(TObject)
		FVers: Integer;         //version of this record
    FCount: Integer;
		FName: String;          //name of the individual
    FFirstName: String;
    FLastName: String;
		FCompany: String;
		FAddress: String;
		FCity: String;
		FState: String;         //more than 2 for international
		FZip: String;
    FCountry: String;
		FPhone: String;        //21 to handle international numbers
    FCell: String;
		FEmail: String;
  public
    constructor Create;
    procedure Clear;
    procedure ReadFromStreamV1(Stream: TFileStream);
    Procedure ReadFromStream(Stream: TFileStream);
    procedure WriteToStream(Stream: TFileStream);
		Property Name: String read FName write FName;
    property FirstName: String read FFirstName write FFirstName;
    property LastName: String read FLastName write FLastName;
		Property Company: String read FCompany write FCompany;
		Property Address: String read FAddress write FAddress;
		Property City: String read FCity write FCity;
		Property State: String read FState write FState;
		Property Zip: String read FZip write FZip;
		Property Country: String read FCountry write FCountry;
		Property Phone: String read FPhone write FPhone;
		Property Cell: String read FCell write FCell;
		Property Email: String read FEmail write FEmail;
  end;

  //This is structure that hold the user's work license info
  //each user can have up to 3 work related licenses
  WorkLicRec = record
    Number: String[31];
    State: String[7];
    ExpDate: String[11];
  end;

  //this is user's indusrty license info
  TWorkLicMgr = class(TObject)
  private
    FRecVers: Integer;
    FLicType: Integer;                //License or Certification (user only has one type)
    FPrimaryLic: Integer;             //which is primary license (opt 1, opt 2, opt 3)
    function GetCount: Integer;
    procedure SetCount(value: Integer);
    function GetLic(Index: Integer): WorkLicRec;
    procedure PutLic(Index: Integer; const Value: WorkLicRec);
    function GetLicCertNo(Index: Integer): String;
    function GetLicLicNo(Index: Integer): String;
    procedure PutLicLicNo(Index: Integer; const value: String);
    function GetLicState(Index: Integer): String;
    procedure PutLicState(Index: Integer; const Value: String);
    function GetLicExpiration(Index: Integer): String;
    procedure PutLicExpiration(Index: Integer; const Value: String);
  public
    FLicenses: Array of WorkLicRec;
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    Procedure ReadFromStream(Stream: TFileStream);
    procedure WriteToStream(Stream: TFileStream);
    property LicenseType: Integer read FLicType write FLicType;
    property PrimaryLic: Integer read FPrimaryLic write FPrimaryLic;
    property Count: Integer read GetCount write SetCount;
    property License[Index: Integer]: WorkLicRec read GetLic write PutLic; default;
    property CertNo[Index: Integer]: String read GetLicCertNo;
    property LicNo[Index: Integer]: String read GetLicLicNo write PutLicLicNo;
    property State[Index: Integer]: String read GetLicState write PutLicState;
    property Expiration[Index: Integer]: String read GetLicExpiration write PutLicExpiration;
  end;

// DATA NOT USED
// Kept so we can read old license files
//version 1 of ProdLic
  ProdCodeRec = record
    ProdID: Integer;
    UnLockCode: LongInt;
  end;

// DATA NOT USED
// Kept so we can read old license files
//version 2 of ProdLic
  TProdLic = class(TObject)
    FProdID: Integer;
    FUnLockCode: LongInt;
    FExpires: String;       //should be TDateTime;
    FUsageLeft: Integer;    //not being used
    FExtra1: LongInt;
    FExtra2: LongInt;
    FExtra3: LongInt;
    FExtra4: LongInt;
    //set after syncing with installed products
    FProductName: String;         //name of the product
    FProdUserVers: String;        //(ie: 1.1.215)
    FProdRelease: Integer;        //product release number, 1, 2, 3, 4
    FProdVersSeed: Longint;       //the unique product seed for this version
  public
    constructor Create(PID: Integer);
    procedure WriteToStream(Stream: TStream);
    procedure ReadFromStream(Stream: TStream);
  end;

// DATA NOT USED
// Kept so we can read old license files
  TProdLicenses = Class(TObjectList)
    FModified: Boolean;
  public
    procedure WriteToStream(Stream: TStream);
    procedure ReadFromStream(Stream: TStream);
  end;


  TSWLicense = class(TObject)
  private
		FVers: Integer;               //version of this record
    FModified: Boolean;           //need to know if license hsa been modified or version read
    function GetValidUsage: Boolean;
    procedure SetValidUsage(Value: Boolean);
  public
    FLicName: String;             //Users name on the form
    FLicCoName: String;           //users company name on the form
    FLicLockedCo: Boolean;        //is the company name locked
    FLicType: Integer;            //UnDef,  Subscription, Evaluation, Expired
    FLicTerm: Integer;            //Year, Month
    FLicEndDate: String;          //end date of usage (server date)
    FLastChkInDate: String;       //holds last date subscription checked, comes form server
    FChkInterval: Integer;        //interval (days) between check in to registry server
    FGracePeriod: Integer;        //grace period after end date
    FEvalGracePeriod: Integer;    //evaluation grace period (nrmally zero)

    FIsValidUser: Boolean;        //PAM: This flag is set at when we save to license file TRUE when RegSubOK

    FLicVersion: Integer;         //PAM: This is the version # from the license file.  Use this to decide to backup license or not 
    constructor Create;
    destructor Destroy; override;
    procedure Clear;

    function ConvertOldCode2LicType(ALicCode: LongInt): LongInt;
    procedure ReadFromStreamV1(Stream: TFileStream);
    procedure ReadFromStreamV2(Stream: TFileStream);

    procedure ReadFromStreamV3(Stream: TFileStream);      //released version
    Procedure ReadFromStream(Stream: TFileStream);
    Procedure WriteToStream(Stream: TFileStream);         //new registry version

    function UsageDaysRemaining: Integer;
    function GraceDaysRemaining: Integer;
    function EvalGraceDaysRemaining: Integer;
    function LicenseCheckInRequired: Boolean;

    property LicName: String read FLicName write FLicName;             //Users name on the form
    property LicCoName: String read FLicCoName write FLicCoName;           //users company name on the form
    property LicLockedCo: Boolean read FLicLockedCo write FLicLockedCo;        //is the company name locked
    property LicType: Integer read FLicType write FLicType;                 //UnDef,  Subscription, Evaluation, Expired
    property LicTerm: Integer read FLicTerm write FLicTerm;                 //Year, Month
    property LicEndDate: String read FLicEndDate write FLicEndDate;         //end date of usage
    property GracePeriod: Integer read FGracePeriod write FGracePeriod;     //grace period after end date
    property EvalGracePeriod: Integer read FEvalGracePeriod write FEvalGracePeriod;
    property LastChkInDate: String read FLastChkInDate write FLastChkInDate;   //of subscription status
    property HasValidSubscription: Boolean read GetValidUsage write SetValidUsage;
    property CurLicVersion: Integer read FVers write FVers;       //this is the current license version #
  end;

  TAWCredentials = class(TObject)
  private
    FVersion: Integer;            //version for reading & writing
    FLoginEmail: String;          //AW login name = email address
    FPassword: String;            //AW password
    FAWUID: String;               //AppraisalWorld Unique ID: String;
    FCustUID: String;             //CustDB Unique ID
    FUserCRMUID: String;          //User's CRM Unique ID
    FIsExtraUser: Boolean;        //Extra User for CF
    FAWProfileUpdated: String;    //last date modified of AW Profile
  public
    constructor Create;
    procedure Clear;
    procedure Assign(Source: TAWCredentials);
    procedure ReadFromStreamV1(Stream: TFileStream);
    procedure ReadFromStreamV2(Stream: TFileStream);
    procedure ReadFromStream(Stream: TFileStream);
    procedure WriteToStream(Stream: TFileStream);

    property UserLoginEmail: String read FLoginEmail write FLoginEmail;
    property UserPassWord: String read FPassword write FPassword;
    property UserAWUID: String read FAWUID write FAWUID;
    property UserCustUID: String read FCustUID write FCustUID;
    property UserCRMUID: String read FUserCRMUID write FUserCRMUID;
    property IsExtraUser: Boolean read FIsExtraUser write FIsExtraUser;
    property ProfileUpdated: String read FAWProfileUpdated write FAWProfileUpdated;

    property AWIdentifier: String read FAWUID write FAWUID;
    property CustDBIdentifier: String read FCustUID write FCustUID;

  end;

  TUserSignature = class(TObject)
    FPassword: Longint;
    FUsePSW: Boolean;
    FOffsetX: Integer;
    FOffsetY: Integer;
    FDestRect: TRect;
    FImageLen: Longint;  //Signature data follows this long
    FImage: TMemoryStream;
    constructor Create;
    destructor Destroy; Override;
    procedure Clear;
    Procedure ReadFromStream(Stream: TFileStream);
    Procedure WriteToStream(Stream: TFileStream);
    property Image: TMemoryStream read FImage write FImage;
  end;


  //This is the CurrentUser
  TCRMLicensedUser = class(TObject)
  private
    FModified: Boolean;
    FCurFile: String;          //the name of User's Lic File
    FLoadAttempted: Boolean;

    //###NOTE GetFirstLastName(edtLicName.text);   to get Greeting name
    FGreetingName: String;    //for "Hi Bob"

    {main parts of license}         //objects that make up the license;
    FContact: TContact;             //user contact info
    FWkLicMgr: TWorkLicMgr;         //appraisal credentials
    FSWLic: TSWLicense;             //software lic info
    FSignature: TUserSignature;     //user signature image
    FAWUserInfo: TAWCredentials;    //AW credentials

    function GetModified: Boolean;
    function GetSWLicTyp: Integer;
    procedure SetSWLicTyp(const Value: Integer);
    function GetSWLicCoName: String;
    function GetSWLicName: String;
    procedure SetSWLicCoName(const Value: String);
    procedure SetSWLicName(const Value: String);
    procedure SetSWLicLockCo(const Value: Boolean);
    function GetSWLicLockCo: Boolean;
    function GetHasSigImage: Boolean;
    function GetUserFileName: String;
    function GetUserCustUID: string;
    function PIDInTrialFree(PIDIdx:Integer):Boolean;
  protected
    procedure LoadFromFile(const FileName: String);
    procedure SaveToFile(const FileName: String);
    procedure LoadFromStream(Stream: TFileStream);
    procedure SaveToStream(stream: TFileStream);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure SaveUserLicFile;
    procedure LoadUserLicFile(const UserName: String);     //takes username.lic, no path
    procedure LoadDefaultUserFile;
    procedure LoadFromUserLicenseTo(UserLicInfo: TCRMUserLicInfo);    //loads from TLicenseUser
    procedure SaveToUserLicenseFrom(UserLicInfo: TCRMUserLicInfo);    //saves to TLcenseUser
    procedure GetUserAWLoginByLicType(PIDIdx: Integer; var AUserName, AUserPSW, AUserCustUID: String);

    function UsageDaysRemaining: Integer;
    function GraceDaysRemaining: Integer;
    function EvalGraceDaysRemaining: Integer;
    function LicenseCheckInRequired: Boolean;
    function HasValidSubscription: Boolean;
    function OK2UseAW1004MCProduct(PIDIdx: Integer; Silent: Boolean=False): Boolean;
    function OK2UseAWProduct(PIDIdx: Integer; var AWRespData: clsGetUsageAvailabilityData; Silent: Boolean=True; AvailabilityOnlyChk: Boolean=True): Boolean; overload;
    function OK2UseAWProduct(PIDIdx: Integer; Silent: Boolean=True; AvailabilityOnlyChk: Boolean=True): Boolean; overload;
    function OK2UseCustDBproduct(PIDIDx: Integer): Boolean;

    function OK2UseCustDBOrAWProduct(PIDIdx: Integer; NoChkNeeded: Boolean=False; Silent: Boolean=True; AvailabilityOnlyChk: Boolean=True): Boolean;
    function BackupLicenseFile(aLicFile:String):Boolean;

    function IsMonthlySubscription: Boolean; //#1450: add this for the pop up only when is yearly
    //main user info section
    property UserInfo:    TContact read FContact write FContact;
    property AWUserInfo:  TAWCredentials read FAWUserInfo write FAWUserInfo;
    property WorkLic:     TWorkLicMgr read FWkLicMgr write FWkLicMgr;
    property LicInfo:     TSWLicense read FSWLic write FSWLic;
    property Signature:   TUserSignature read FSignature write FSignature;

    //main points of interest
    property SWLicenseType : Integer read GetSWLicTyp write SetSWLicTyp;
    property SWLicenseName: String read GetSWLicName write SetSWLicName;
    property SWLicenseCoName: String read GetSWLicCoName write SetSWLicCoName;
    property SWLicenseCoNameLocked: Boolean read GetSWLicLockCo write SetSWLicLockCo;
    property GreetingName: String read FGreetingName write FGreetingName;
    property UserFileName: String read GetUserFileName;
    property HasSignature: Boolean read GetHasSigImage;
    property UserCustUID: string read GetUserCustUID;
    property Modified: Boolean read GetModified write FModified;
  end;



//This a small object that represents a user license file
//its a way to reference all licensed users without using TLicensedUser
  TUser = class(TObject)
    FLicName: String;             //user's signature name
    FLicCoName: String;
    FLicCoNameLocked: Boolean;
    FFileName: String;            //name of the file (normally users name)
    FFilePath: String;            //full path to the file
    FIsValidUser: Boolean;        //flag to quickly tell if user is valid
    function LicFileExists: Boolean;
    function IsRegistered: Boolean;
    function IsLicensedToUse(AProduct: Integer): Boolean;
  end;

  //List of user license files found during startup
  TUserList = class(TObjectList)
  private
    FDefaultUserFile: String;
    function GetDefaultUserName: String;
  protected
    function GetLockedCoName: String;
    function GetDefaultUser: String;
    procedure SetDefaultUser(Value: String);
    procedure ProcessLicFile(Sender: TObject; FileName: string);  //proc during fileSearch
  public
    procedure SaveLicensePref;     //We need the save/load for  preference save default user
    procedure LoadLicensePref;

    procedure GatherUserLicFiles;
    procedure SetInitialCurrentUser;
    procedure WriteDefaultUserPreference;
    procedure ReadDefaultUserPreference;

    function HasRegisteredUserFor(AProduct: Integer): Boolean;   //###Check: we still need this for some products like area sketch

    function SelectOneUserLicFile: String;   //shows list for selection
    function UserFileExists(FName: String): Boolean;
    function UserFilePath(Const UserLicName: String): String;
    function UserIsRegistered(Const UserLicName: String): Boolean;
    property LockedCoName: String read GetLockedCoName;  //###REMOVE - Not used
    property DefaultUser: String read GetDefaultUser write SetDefaultUser;
    property DefaultUserName: String read GetDefaultUserName;
  end;

var
  CurrentUser: TCRMLicensedUser;       //current user of ClickForms
  LicensedUsers: TUserList;         //list of user lic files in License Folder

  procedure InitLicensedUsers;


implementation

uses
  IniFiles,Registry,DateUtils,IdHTTP, IdBaseComponent, IdAntiFreezeBase, IdAntiFreeze,
  UGlobals, UStatus, UUtil1, UUtil2, UUtil3, UFileGlobals, UFileUtils, USysInfo,
  UFileFinder, UCRMLicSelectUser, UWinUtils, UWebConfig, UWebUtils,
  UStrings, UAWSI_Utils, UServices, uSendHelp,UCustomerServices,ClfCustServices2014;



{ TAWCredentials }

//need to encode/decode these strings
constructor TAWCredentials.Create;
begin
  FVersion := cAWCredVers3;

  Clear;
end;

procedure TAWCredentials.Clear;
begin
  FLoginEmail         := '';
  FPassword           := '';
  FAWUID              := '';    //AppraisalWorld Unique ID
  FCustUID            := '';    //Bradford Customer ID
  FUserCRMUID         := '';
  FIsExtraUser        := False;
  FAWProfileUpdated   := '';    //last date modified of AW Profile
end;

procedure TAWCredentials.Assign(Source: TAWCredentials);
begin
  FLoginEmail         := Source.FLoginEmail;
  FPassword           := Source.FPassword;
  FAWUID              := Source.FAWUID;             //AppraisalWorld Unique ID
  FCustUID            := Source.FCustUID;           //Bradford Customer ID
  FUserCRMUID         := Source.FUserCRMUID;        //User UID in CRM
  FIsExtraUser        := Source.FIsExtraUser;       //Extra User for CF, not used in CC
  FAWProfileUpdated   := Source.FAWProfileUpdated;  //last date modified of AW Profile
end;

//this is version 1: but replaced Extra 1 & 2 with AWID and CustID
//only created in License File version 3
procedure TAWCredentials.ReadFromStreamV1(Stream: TFileStream);
var
  decryptStr: String;
  Extra1,Extra2,Extra3,Extra4,Extra5: String;    //don't care about these
  BillPref, EmailOrder, TxMsgOrder: String;      //but need to read
begin
  decryptStr  := ReadStringFromStream(Stream);
  FLoginEmail  := DecryptString(decryptStr, AWEncryptKey1);

  decryptStr  := ReadStringFromStream(Stream);
  FPassword   :=  DecryptString(decryptStr, AWEncryptKey2);

  decryptStr  := ReadStringFromStream(Stream);
  BillPref   := DecryptString(decryptStr, AWEncryptKey1);

  decryptStr  := ReadStringFromStream(Stream);
  EmailOrder := DecryptString(decryptStr, AWEncryptKey2);

  decryptStr  := ReadStringFromStream(Stream);
  TxMsgOrder := DecryptString(decryptStr, AWEncryptKey2);

  decryptStr  := ReadStringFromStream(Stream);
  Extra1     := DecryptString(decryptStr, AWEncryptKey1);

  decryptStr  := ReadStringFromStream(Stream);
  Extra2     := DecryptString(decryptStr, AWEncryptKey1);

  decryptStr  := ReadStringFromStream(Stream);
  Extra3     := DecryptString(decryptStr, AWEncryptKey1);

  decryptStr  := ReadStringFromStream(Stream);
  Extra4     := DecryptString(decryptStr, AWEncryptKey1);

  decryptStr  := ReadStringFromStream(Stream);
  Extra5     := DecryptString(decryptStr, AWEncryptKey1);
end;

//only created in License File Version 4
procedure TAWCredentials.ReadFromStreamV2(Stream: TFileStream);
var
  decryptStr: String;
  //don't care about these but need to read
  Extra1,Extra2,Extra3,Extra4,Extra5: String;
  BillPref, EmailOrder, TxMsgOrder, AWProfileUpdated: String;
  AWLicValidated, AWSignatureUpdated: String;
  vers: LongInt;
begin
  vers        := ReadLongFromStream(Stream);    //read the version here, throw away

  decryptStr  := ReadStringFromStream(Stream);
  FLoginEmail  := DecryptString(decryptStr, AWEncryptKey1);

  decryptStr  := ReadStringFromStream(Stream);
  FPassword   :=  DecryptString(decryptStr, AWEncryptKey2);

  decryptStr  := ReadStringFromStream(Stream);
  BillPref   := DecryptString(decryptStr, AWEncryptKey1);

  decryptStr  := ReadStringFromStream(Stream);
  EmailOrder := DecryptString(decryptStr, AWEncryptKey2);

  decryptStr  := ReadStringFromStream(Stream);
  TxMsgOrder := DecryptString(decryptStr, AWEncryptKey2);

  decryptStr  := ReadStringFromStream(Stream);
  FAWUID      := DecryptString(decryptStr, AWEncryptKey1);

  decryptStr  := ReadStringFromStream(Stream);
  FCustUID    := DecryptString(decryptStr, AWEncryptKey1);

  FIsExtraUser := ReadBoolFromStream(Stream);

  decryptStr  := ReadStringFromStream(Stream);
  AWProfileUpdated := DecryptString(decryptStr, AWEncryptKey2);

  decryptStr  := ReadStringFromStream(Stream);
  AWLicValidated := DecryptString(decryptStr, AWEncryptKey1);

  decryptStr  := ReadStringFromStream(Stream);
  AWSignatureUpdated := DecryptString(decryptStr, AWEncryptKey2);

  //extras
  decryptStr  := ReadStringFromStream(Stream);
  Extra1     := DecryptString(decryptStr, AWEncryptKey1);

  decryptStr  := ReadStringFromStream(Stream);
  Extra2     := DecryptString(decryptStr, AWEncryptKey1);

  decryptStr  := ReadStringFromStream(Stream);
  Extra3     := DecryptString(decryptStr, AWEncryptKey1);

  decryptStr  := ReadStringFromStream(Stream);
  Extra4     := DecryptString(decryptStr, AWEncryptKey1);

  decryptStr  := ReadStringFromStream(Stream);
  Extra5     := DecryptString(decryptStr, AWEncryptKey1);
end;

// this version has AW vers = 3, format started in Lic File v5
procedure TAWCredentials.ReadFromStream(Stream: TFileStream);
var
  Vers: LongInt;
  //don't care about these but need to read
  Extra1,Extra2,Extra3,Extra4,Extra5: String;
begin
  Vers := ReadLongFromStream(Stream);             //we are using LicFileVersion to read this object

  FLoginEmail       := ReadStringFromStream(Stream);
  FPassword         := ReadStringFromStream(Stream);
  FAWUID            := ReadStringFromStream(Stream);
  FCustUID          := ReadStringFromStream(Stream);
  FUserCRMUID       := ReadStringFromStream(Stream);
  FIsExtraUser      := ReadBoolFromStream(Stream);
  FAWProfileUpdated := ReadStringFromStream(Stream);

  //read extras
  Extra1  := ReadStringFromStream(Stream);
  Extra2  := ReadStringFromStream(Stream);
  Extra3  := ReadStringFromStream(Stream);
  Extra4  := ReadStringFromStream(Stream);
  Extra5  := ReadStringFromStream(Stream);
end;

procedure TAWCredentials.WriteToStream(Stream: TFileStream);
var
  Extra1,Extra2,Extra3,Extra4,Extra5: String;
begin
  WriteLongToStream(FVersion, Stream);

  WriteStringToStream(FLoginEmail, Stream);
  WriteStringToStream(FPassword, Stream);
  WriteStringToStream(FAWUID, Stream);
  WriteStringToStream(FCustUID, Stream);
  WriteStringToStream(FUserCRMUID, Stream);
  WriteBoolToStream(FIsExtraUser, Stream);
  WriteStringToStream(FAWProfileUpdated, Stream);

  //write five extras
  Extra1  := '';
  Extra2  := '';
  Extra3  := '';
  Extra4  := '';
  Extra5  := '';
  WriteStringToStream(Extra1, Stream);
  WriteStringToStream(Extra2, Stream);
  WriteStringToStream(Extra3, Stream);
  WriteStringToStream(Extra4, Stream);
  WriteStringToStream(Extra5, Stream);
end;


{ TCRMLicensedUser }

constructor TCRMLicensedUser.Create;
begin
  inherited;

  FLoadAttempted  := False;
  FCurFile        := '';
  FModified       := False;
  FGreetingName   := '';

  FContact    := TContact.Create;
  FWkLicMgr   := TWorkLicMgr.Create;
  FSWLic      := TSWLicense.Create;
  FSignature  := TUserSignature.Create;
  FAWUserInfo := TAWCredentials.Create;
end;

destructor TCRMLicensedUser.Destroy;
begin
  If assigned(FContact)   then FContact.Free;
  If assigned(FWkLicMgr)  then FWkLicMgr.Free;
  if assigned(FSWLic)     then FSWLic.Free;
  if assigned(FSignature) then FSignature.Free;
  if assigned(FAWUserInfo)then FAWUserInfo.Free;
  
  inherited;
end;

procedure TCRMLicensedUser.Clear;
begin
  FLoadAttempted  := False;
  FCurFile        := '';
  FModified       := False;
  FGreetingName   := '';

  FContact.Clear;
  FWkLicMgr.Clear;
  FSWLic.Clear;
  FSignature.Clear;
  FAWUserInfo.Clear;
end;

function TCRMLicensedUser.GetModified: Boolean;
begin
  result := FModified or LicInfo.FModified;
end;

function TCRMLicensedUser.GetSWLicTyp: Integer;
begin
  result := FSWLic.FLicType;
end;

procedure TCRMLicensedUser.SetSWLicTyp(const Value: Integer);
begin
  FSWLic.FLicType := Value;
  FModified := True;
end;

function TCRMLicensedUser.GetSWLicCoName: String;
begin
  result := FSWLic.FLicCoName;
end;

procedure TCRMLicensedUser.SetSWLicCoName(const Value: String);
begin
  FSWLic.FLicCoName := value;
  FModified := True;
end;

function TCRMLicensedUser.GetSWLicName: String;
begin
  result := FSWLic.FLicName;
end;

procedure TCRMLicensedUser.SetSWLicName(const Value: String);
begin
  FSWLic.FLicName := Value;
  FModified := True;
end;

procedure TCRMLicensedUser.SetSWLicLockCo(const Value: Boolean);
begin
  FSWLic.FLicLockedCo := Value;
end;

function TCRMLicensedUser.GetSWLicLockCo: Boolean;
begin
  result := FSWLic.FLicLockedCo;
  FModified := True;
end;

procedure TCRMLicensedUser.LoadUserLicFile(const UserName: String);
begin
  if length(UserName)> 0 then   //actually found one
    begin
      FCurFile := IncludeTrailingPathDelimiter(appPref_DirLicenses) + UserName;
      if FileExists(FCurFile) then
        LoadFromFile(FCurFile);
    end;
  FLoadAttempted := True;       //we tried, but maybe failed
end;

procedure TCRMLicensedUser.LoadDefaultUserFile;
var
  UserFile: String;
begin
  UserFile := LicensedUsers.DefaultUser;     //go find a user lic file

  if length(UserFile)> 0 then                  //actually found one
    begin
      FCurFile := IncludeTrailingPathDelimiter(appPref_DirLicenses) + UserFile;
      if FileExists(FCurFile) then
        LoadFromFile(FCurFile)
      else
        FCurFile := '';
    end;

  FLoadAttempted := True;       //we tried, but maybe failed
end;

procedure TCRMLicensedUser.LoadFromStream(Stream: TFileStream);
var
  GH: GenericIDHeader;
  bakPath,bakFile, origPath,origFile: String;
begin
  try
    ReadGenericIDHeader(Stream, GH);        //### check for user type & version
    case GH.fFileVers of
      cLicFileVers2: begin  //###NOTE - this is the original Canadian User Lic File
        GreetingName := ReadStringFromStream(Stream);
        FContact.ReadFromStream(Stream);
        FWkLicMgr.ReadFromStream(Stream);
        FSWLic.ReadFromStream(Stream);
        FSignature.ReadFromStream(Stream);
        FSWLic.FLicType := ltUndefinedLic;   //set to undefined after we read from old version;
      end;

      cLicFileVers3: begin
        GreetingName := ReadStringFromStream(Stream);
        FContact.ReadFromStream(Stream);
        FAWUserInfo.ReadFromStreamV1(Stream);      //added AWUser in file v3
        FWkLicMgr.ReadFromStream(Stream);
        FSWLic.ReadFromStream(Stream);
        FSignature.ReadFromStream(Stream);
        FSWLic.FLicType := ltUndefinedLic;   //set to undefined after we read from old version;
      end;

      cLicFileVers4: begin
        GreetingName := ReadStringFromStream(Stream);
        FContact.ReadFromStream(Stream);
        FAWUserInfo.ReadFromStreamV2(Stream);      //added vers number & expanded AWUser in v4, Only in File v4
        FWkLicMgr.ReadFromStream(Stream);
        FSWLic.ReadFromStream(Stream);
        FSignature.ReadFromStream(Stream);
        ///PAM: set to undefined for the first time to read from old license file
        FSWLic.FLicType := ltUndefinedLic;   //set to undefined after we read from old version;
      end;

      cLicFileVers5: begin
      //###CHECK DECRYPT THE STREAM FIRST
        GreetingName := ReadStringFromStream(Stream);
        FContact.ReadFromStream(Stream);
        FAWUserInfo.ReadFromStream(Stream);      //modified entire object
        FWkLicMgr.ReadFromStream(Stream);
        FSWLic.ReadFromStream(Stream);
        FSignature.ReadFromStream(Stream);
	    end;
    end;
  except
    ShowNotice('Could not read the User License information for '+ GreetingName+'.');
  end;
end;

procedure TCRMLicensedUser.LoadFromFile(const FileName: String);
var
  fStream: TFileStream;
begin
  fStream := TFileStream.Create(FileName, fmOpenRead);
  try
    try
      LoadFromStream(fStream);
    except
      ShowNotice('Could not read the User License file: '+ ExtractFileName(fileName));
    end;
  finally
    fStream.Free;
    FLoadAttempted := True;    //avoid endless loop in searching for users (try once)
  end;
end;

procedure TCRMLicensedUser.SaveToStream(stream: TFileStream);
begin
  try
    WriteGenericIDHeader2(Stream, cUSERFile, cLicFileVers5);     //this is user file, vers# 5
    WriteStringToStream(FGreetingName, Stream);
    FContact.WriteToStream(Stream);
    FAWUserInfo.WriteToStream(Stream);
    FWkLicMgr.WriteToStream(Stream);
    FSWLic.WriteToStream(Stream);
    FSignature.WriteToStream(Stream);

  //###CHECK ENCRYPT THE STREAM
  except
    ShowNotice('There was a problem saving the User License information. The information was not saved.');
  end;
end;

procedure TCRMLicensedUser.SaveToFile(const FileName: String);
var
  fStream: TFileStream;
begin
  fStream := TFileStream.Create(FileName, fmCreate);
  try
    SaveToStream(fStream);
  finally
    fStream.Free;
  end;
end;

procedure TCRMLicensedUser.SaveUserLicFile;
var
  fStream: TFileStream;
begin
  if length(FCurFile) = 0 then   //never saved before
    begin
      GreetingName := GetGoodUserName(UserInfo.Name, 'Evaluator');   //save file under this name & greet with it
      FCurFile := IncludeTrailingPathDelimiter(appPref_DirLicenses) + GreetingName + LicFileExt;
      if CreateNewFile(FCurFile,  fStream) then
        try
          SaveToStream(fStream);
        finally
          fStream.free;
        end;
    end
  else
    SaveToFile(FCurFile);
end;

//loads the UserInfo object from data in User License object
procedure TCRMLicensedUser.LoadFromUserLicenseTo(UserLicInfo: TCRMUserLicInfo);   //NOTE from PAM: avoid to use UserInfo since the UserInfo here is for TContact
begin
  if assigned(UserLicInfo) then
    begin
    //appraisalWorld credentials
      UserLicInfo.AWUID          := AWUserInfo.UserAWUID;
      UserLicInfo.CustUID        := AWUserInfo.UserCustUID;
      UserLicInfo.IsExtraUser    := AWUserInfo.IsExtraUser;

    //License Information
      UserLicInfo.LicType         := LicInfo.LicType;
      UserLicInfo.LicTerm         := LicInfo.LicTerm;
      UserLicInfo.LicEndDate      := LicInfo.LicEndDate;       //end date of usage
      UserLicInfo.GracePeriod     := LicInfo.GracePeriod;      //grace period after end date
      UserLicInfo.EvalGracePeriod := LicInfo.EvalGracePeriod;  //grace period after evaluation
      UserLicInfo.FLastChkInDate  := LicInfo.LastChkInDate;   //of subscription status

    //contact Info
      UserLicInfo.Name           := UserInfo.Name;
      UserLicInfo.Company        := UserInfo.Company;
      UserLicInfo.Address        := UserInfo.Address;
      UserLicInfo.City           := UserInfo.City;
      UserLicInfo.State          := UserInfo.State;
      UserLicInfo.Zip            := UserInfo.Zip;
      UserLicInfo.Country        := UserInfo.Country;
      UserLicInfo.Phone          := UserInfo.Phone;
      UserLicInfo.Cell           := UserInfo.Cell;
      UserLicInfo.Email          := UserInfo.Email;

    //appraisl credentials
      UserLicInfo.WrkLicType     := WorkLic.LicenseType;
      UserLicInfo.WrkLicPrimary  := WorkLic.PrimaryLic;

      UserLicInfo.ClearWorkLicenses;     //clear previous data if any
      if WorkLic.Count > 0 then begin
        UserLicInfo.WrkLic1State   := WorkLic.License[0].State;
        UserLicInfo.WrkLic1Number  := WorkLic.License[0].Number;
        UserLicInfo.WrkLic1ExpDate := WorkLic.License[0].ExpDate;
      end;

      if WorkLic.Count > 1 then begin
        UserLicInfo.WrkLic2State   := WorkLic.License[1].State;
        UserLicInfo.WrkLic2Number  := WorkLic.License[1].Number;
        UserLicInfo.WrkLic2ExpDate := WorkLic.License[1].ExpDate;
      end;

      if WorkLic.Count > 2 then begin
        UserLicInfo.WrkLic3State   := WorkLic.License[2].State;
        UserLicInfo.WrkLic3Number  := WorkLic.License[2].Number;
        UserLicInfo.WrkLic3ExpDate := WorkLic.License[2].ExpDate;
      end;

    //Software license information
      UserLicInfo.LicName        := LicInfo.LicName;
      UserLicInfo.LicCoName      := LicInfo.LicCoName;
      UserLicInfo.FLicCoLocked   := LicInfo.LicLockedCo;

//TEST ONLY
//UserLicInfo.LicType := 1;
//UserLicInfo.LicEndDate := '2018/10/25';
//UserLicInfo.GracePeriod := 0;
//UserLicInfo.EvalGracePeriod := 0;
  end;
end;

//saves the info in UserInfo to User License object
procedure TCRMLicensedUser.SaveToUserLicenseFrom(UserLicInfo: TCRMUserLicInfo);  //NOTE from PAM: avoid to use UserInfo since the UserInfo here is for TContact
begin
  if assigned(UserLicInfo) then
    begin
    //appraisalWorld credentials
      AWUserInfo.UserAWUID     := UserLicInfo.AWUID;
      AWUserInfo.UserCustUID   := UserLicInfo.CustUID;
      AWUserInfo.IsExtraUser   := UserLicInfo.IsExtraUser;

    //software license info
      LicInfo.LicType         := UserLicInfo.LicType;
      LicInfo.LicTerm         := UserLicInfo.LicTerm;
      LicInfo.LicEndDate      := trim(UserLicInfo.LicEndDate);          //end date of usage
      LicInfo.GracePeriod     := UserLicInfo.GracePeriod;          //grace period after end date
      LicInfo.EvalGracePeriod := UserLicInfo.EvalGracePeriod;
      LicInfo.LastChkInDate   := trim(UserLicInfo.FLastChkInDate);   //of subscription status

    //contact Info
      UserInfo.Name    := trim(UserLicInfo.Name);
      UserInfo.Company := trim(UserLicInfo.Company);
      UserInfo.Address := trim(UserLicInfo.Address);
      UserInfo.City    := trim(UserLicInfo.City);
      UserInfo.State   := trim(UserLicInfo.State);
      UserInfo.Zip     := trim(UserLicInfo.Zip);
      UserInfo.Country := trim(UserLicInfo.Country);
      UserInfo.Phone   := trim(UserLicInfo.Phone);
      UserInfo.Cell    := trim(UserLicInfo.Cell);
      UserInfo.Email   := trim(UserLicInfo.Email);

    //appraisl credentials
      WorkLic.LicenseType  := UserLicInfo.WrkLicType;
      WorkLic.PrimaryLic   := UserLicInfo.WrkLicPrimary;

      WorkLic.Count := UserLicInfo.GetWorkLicensesCount;     //how many licenses do we have
      if WorkLic.Count > 0 then begin
        if trim(UserLicInfo.WrkLic1State) <> '' then
          WorkLic.FLicenses[0].State   := trim(UserLicInfo.WrkLic1State);
        if trim(UserLicInfo.WrkLic1Number) <> '' then
          WorkLic.FLicenses[0].Number  := trim(UserLicInfo.WrkLic1Number);
        if trim(UserLicInfo.WrkLic1ExpDate) <> '' then
          WorkLic.FLicenses[0].ExpDate := trim(UserLicInfo.WrkLic1ExpDate);
      end;
      if WorkLic.Count > 0 then begin
        if trim(UserLicInfo.WrkLic2State) <> '' then
          WorkLic.FLicenses[1].State   := trim(UserLicInfo.WrkLic2State);
        if trim(UserLicInfo.WrkLic2Number) <> '' then
          WorkLic.FLicenses[1].Number  := trim(UserLicInfo.WrkLic2Number);
        if trim(UserLicInfo.WrkLic2ExpDate) <> '' then
          WorkLic.FLicenses[1].ExpDate := trim(UserLicInfo.WrkLic2ExpDate);
      end;
      if WorkLic.Count > 0 then begin
        if trim(UserLicInfo.WrkLic3State) <> '' then
          WorkLic.FLicenses[2].State   := trim(UserLicInfo.WrkLic3State);
        if trim(UserLicInfo.WrkLic3Number) <> '' then
          WorkLic.FLicenses[2].Number  := trim(UserLicInfo.WrkLic3Number);
        if trim(UserLicInfo.WrkLic3ExpDate) <> '' then
          WorkLic.FLicenses[2].ExpDate := trim(UserLicInfo.WrkLic3ExpDate);
      end;

    //Software license information
      LicInfo.LicName       := trim(UserLicInfo.LicName);  //For some reason, we sometimes see LicInfo.LicoName has #0 at the end and this causing crashing
      LicInfo.LicCoName     := trim(UserLicInfo.LicCoName); //For some reason, we sometimes see LicInfo.LicoName has #0 at the end and this causing crashing
      LicInfo.LicLockedCo   := UserLicInfo.FLicCoLocked;
      LicInfo.FChkInterval  := UserLicInfo.FChkInterval;  //Need to save FChkInterval back to license file
      LicInfo.FIsValidUser  := UserLicInfo.FReplyID = rsSubsRegisteredOK;  //PAM: need to set the FIsValidUser
  end;
end;


function TCRMLicensedUser.OK2UseCustDBOrAWProduct(PIDIdx: Integer; NoChkNeeded: Boolean=False; Silent: Boolean=True; AvailabilityOnlyChk: Boolean=True): Boolean;
begin
  Result := NoChkNeeded;
  if not Result then
    begin
      //###PAM: call AWSI first if fail then call custDB
      Result := OK2UseAWProduct(PIDIdx, Silent, AvailabilityOnlyChk);
      if not Result then
        Result := OK2UseCustDBProduct(PIDIDx);
//      if PIDIDx in [pidAppraisalPort, pidPropertyDataImport, pidMLSDataImport, pidRelsConnection, pidUADForms] then
//        Result := OK2UseCustDBProduct(PIDIDx) and (LicInfo.LicType <> ltEvaluationLic);   //call custdb if not eval mode
//      if not Result then
//        Result := OK2UseAWProduct(PIDIdx, Silent, AvailabilityOnlyChk);
    end;
end;

function TCRMLicensedUser.IsMonthlySubscription: Boolean; //#1450: add this for the pop up only when is yearly
begin
  if (LicInfo.FLicType = ltSubscriptionLic) and (LicInfo.FLicTerm = ltTermMonthly) then //is monthly if not yearly
    result := True
  else
    result := False;
end;


function TCRMLicensedUser.GetHasSigImage: Boolean;
begin
  result := (Signature.FImage <> nil) and (Signature.FImage.Size > 0)
end;

function TCRMLicensedUser.GetUserFileName: String;
begin
  result := ExtractFileName(FCurFile);
end;

function TCRMLicensedUser.GraceDaysRemaining: Integer;
begin
  result := LicInfo.GraceDaysRemaining;
end;

function TCRMLicensedUser.EvalGraceDaysRemaining: Integer;
begin
  result := LicInfo.EvalGraceDaysRemaining;
end;

function TCRMLicensedUser.UsageDaysRemaining: Integer;
begin
  result := LicInfo.UsageDaysRemaining;
end;

function TCRMLicensedUser.LicenseCheckInRequired: Boolean;
begin
  result := LicInfo.LicenseCheckInRequired;
end;

function TCRMLicensedUser.HasValidSubscription: Boolean;
begin
  result := LicInfo.HasValidSubscription;
end;

function TCRMLicensedUser.GetUserCustUID: string;
begin
  result := AWUserInfo.FCustUID;
end;

//Ticket #1245: only allow these services for the trial customer
function TCRMLicensedUser.PIDInTrialFree(PIDIdx:Integer):Boolean;
begin
  result := False;
  case PIDIdx of
    pidClickForms,       //ClickFORMS maintenance
    pidOnlineLocMaps,    //Location Map
    pidOnlineFloodMaps,  //Flood Map
    pidMLSDataImport,    //MLS Data Import Wizard
    pidMCAnalysis:       //1004 MC
    Result := True;
  end;
end;

function TCRMLicensedUser.BackupLicenseFile(aLicFile:String):Boolean;
var
  origFile, bakPath, bakFile:String;
begin
  result := False;
  origFile := IncludeTrailingPathDelimiter(appPref_DirLicenses) + trim(aLicFile);
  if (origFile<>'') and FileExists(origFile) then
    begin
      bakPath := IncludeTrailingPathDelimiter(ExtractFilePath(origFile)) +'bak';
      ForceDirectories(bakPath);
      bakFile := bakPath+'\'+ExtractFileName(origFile);
      if FileExists(bakFile) then
        DeleteFile(bakFile);
      FileOperator.Mode := foCopy;
      FileOperator.Move(origFile, bakFile);
      result := True;
    end;
end;

procedure TCRMLicensedUser.GetUserAWLoginByLicType(PIDIdx: Integer; var AUserName, AUserPSW, AUserCustUID: String);
begin
  if LicInfo.FLicType = ltEvaluationLic then    //Use Trial username/password to pass to server
    begin
      if PIDInTrialFree(PIDIdx) then
        begin
          AUserName     := CF_Trial_UserName;
          AUserPSW      := CF_Trial_Password;
          AUserCustUID  := CF_Trial_CustID;
        end;
    end
  else
    begin
      AUserName     := AWUserInfo.UserLoginEmail;
      AUserPSW      := AWUserInfo.UserPassWord;
      AUserCustUID  := AWUserInfo.UserCustUID;
    end;
end;
{ TContact }

constructor TContact.Create;
begin
  inherited;

  FVers := cContactVers2;

  Clear;
end;

procedure TContact.Clear;
begin
  FName       := '';
  FFirstName  := '';
  FLastName   := '';
  FCompany    := '';
  FAddress    := '';
  FCity       := '';
  FState      := '';
  FZip        := '';
  FCountry    := '';
  FPhone      := '';
  FCell       := '';
  FEmail      := '';
end;

procedure TContact.ReadFromStreamV1(Stream: TFileStream);
var
  ACount: Integer;            //don't need these items
  AFax,APager: String;        //but need to read to be compatible
begin
  ACount    := ReadLongFromStream(Stream);   //read the item count (for reading as array)
  FName     := ReadStringFromStream(Stream); //read each individual item
  FCompany  := ReadStringFromStream(Stream); //in the correct sequence
  FAddress  := ReadStringFromStream(Stream);
  FCity     := ReadStringFromStream(Stream);
  FState    := ReadStringFromStream(Stream);
  FZip      := ReadStringFromStream(Stream);
  FCountry  := ReadStringFromStream(Stream);
  FPhone    := ReadStringFromStream(Stream);
  AFax      := ReadStringFromStream(Stream);
  FCell     := ReadStringFromStream(Stream);
  APager    := ReadStringFromStream(Stream);
  FEmail    := ReadStringFromStream(Stream);
end;

procedure TContact.ReadFromStream(Stream: TFileStream);
var
  Vers: LongInt;
begin
  Vers := ReadLongFromStream(Stream);   //read the version

  if Vers = cContactVers1 then
    ReadFromStreamV1(Stream)

  else begin
    FName     := ReadStringFromStream(Stream); //read each individual item
    FCompany  := ReadStringFromStream(Stream); //in the correct sequence
    FAddress  := ReadStringFromStream(Stream);
    FCity     := ReadStringFromStream(Stream);
    FState    := ReadStringFromStream(Stream);
    FZip      := ReadStringFromStream(Stream);
    FCountry  := ReadStringFromStream(Stream);
    FPhone    := ReadStringFromStream(Stream);
    FCell     := ReadStringFromStream(Stream);
    FEmail    := ReadStringFromStream(Stream);
  end;
end;

procedure TContact.WriteToStream(Stream: TFileStream);
begin
  WriteLongToStream(FVers, Stream);          //write version

  WriteStringToStream(FName, Stream);        //write each contact item
  WriteStringToStream(FCompany, Stream);     //in the correct sequence
  WriteStringToStream(FAddress, Stream);
  WriteStringToStream(FCity, Stream);
  WriteStringToStream(FState, Stream);
  WriteStringToStream(FZip, Stream);
  WriteStringToStream(FCountry, Stream);
  WriteStringToStream(FPhone, Stream);
  WriteStringToStream(FCell, Stream);
  WriteStringToStream(FEmail, Stream);
end;


{ TWorkLicense }

constructor TWorkLicMgr.Create;
begin
  inherited;

  FRecVers := cWorkLicVers1;
  FLicType := cCertType;

  FLicenses := nil;                 //start empty
//  SetLength(FLicenses, 3);          //always hold three
end;

destructor TWorkLicMgr.Destroy;
begin
  FLicenses := nil;      //dispose the work lic array

  inherited;
end;

procedure TWorkLicMgr.Clear;
begin
  FLicType := cCertType;
  FLicenses := nil;
end;

procedure TWorkLicMgr.SetCount(value: Integer);
begin
  SetLength(FLicenses, value);
end;

function TWorkLicMgr.GetCount: Integer;
begin
  result := Length(FLicenses);
end;

function TWorkLicMgr.GetLic(Index: Integer): WorkLicRec;
begin
  //PAM: needs to clear out result so it won't take the previous one if index >= count
  result.Number := ''; result.State := ''; result.ExpDate := '';
  if (index > -1) and (index < count) then
    result := FLicenses[Index];
end;

procedure TWorkLicMgr.PutLic(Index: Integer; const Value: WorkLicRec);
begin
  if (index > -1) and (index < count) then
    FLicenses[Index] := Value;
end;

function TWorkLicMgr.GetLicCertNo(Index: Integer): String;
begin
  result := '';
  if LicenseType = cCertType then
    if (index > -1) and (index < count) then
      result := FLicenses[Index].Number;
end;

function TWorkLicMgr.GetLicLicNo(Index: Integer): String;
begin
  result := '';
  if LicenseType = cLicType then
    if (index > -1) and (index < count) then
      result := FLicenses[Index].Number;
end;

procedure TWorkLicMgr.PutLicLicNo(Index: Integer; const Value: String);
begin
  if (index > -1) and (index < count) then
    FLicenses[Index].Number := Value;
end;

function TWorkLicMgr.GetLicState(Index: Integer): String;
begin
  result := '';
  if (index > -1) and (index < count) then
    begin
      result := FLicenses[Index].State;
    end;
end;

procedure TWorkLicMgr.PutLicState(Index: Integer; const Value: String);
begin
  if (index > -1) and (index < count) then
    FLicenses[Index].State := Value;
end;

function TWorkLicMgr.GetLicExpiration(Index: Integer): String;
begin
  result := '';
  if (index > -1) and (index < count) then
    begin
      result := FLicenses[Index].ExpDate;
    end;
end;

procedure TWorkLicMgr.PutLicExpiration(Index: Integer; const Value: String);
begin
  if (index > -1) and (index < count) then
    begin
      FLicenses[Index].ExpDate := Value;
    end;
end;

procedure TWorkLicMgr.ReadFromStream(Stream: TFileStream);
var
  numRecs, amt: LongInt;
begin
  FRecVers := ReadLongFromStream(Stream);         //read version number
  FLicType := ReadLongFromStream(Stream);         //read license type
  numRecs := ReadLongFromStream(Stream);          //read number of lic recs

  if numRecs > 0 then begin
    SetLength(FLicenses, numRecs);                //make room for numRecs
    amt := numRecs * sizeOf(WorkLicRec);
    Stream.Read(Pointer(FLicenses)^, amt);        //load the array
  end;
end;

procedure TWorkLicMgr.WriteToStream(Stream: TFileStream);
var
  amt: Longint;
begin
  WriteLongToStream(FRecVers, Stream);       //write version number
  WriteLongToStream(FLicType, Stream);      //write license type
  WriteLongToStream(Count, Stream);         //write number of lic recs

  amt := Length(FLicenses) * sizeOf(WorkLicRec);
  if amt > 0 then
    Stream.WriteBuffer(Pointer(FLicenses)^, amt);        //write the array
end;


{ TSWLicense }

constructor TSWLicense.Create;
begin
  inherited;

  FModified     := False;
  FVers         := cSWLicVers4;        //set current version
  FLicType      := ltUndefinedLic;     //Important - user is unknown in begining

  FLicName        := '';                //this name on form
  FLicCoName      := '';                //company name on form
  FLicLockedCo    := False;             //company name is not locked
  FLastChkInDate  := '';

//  ###CHECK - what else needs initializing
end;

destructor TSWLicense.Destroy;
begin
  inherited;
end;

procedure TSWLicense.Clear;
begin
  FLicType        := ltUndefinedLic;    //Important - user is unknow in begining
  FLicName        := '';                //this name on form
  FLicCoName      := '';                //company name on form
  FLicLockedCo    := False;             //company name is not locked
  FLastChkInDate  := '';

//  ###CHECK - what else needs initializing
end;

//needed to convert code to LicTypes
function TSWLicense.ConvertOldCode2LicType(ALicCode: LongInt): LongInt;
var
  oldLicType: LongInt;
begin
  //convert License CODE to old License TYPE
  if ALicCode = cValidLicCode then
     oldLicType := ltValidLic

  else if ALicCode = cTempLicCode then
    oldLicType := ltTempLic

  else if ALicCode = cExpiredCode then
    oldLicType := ltExpiredLic

  else if ALicCode = cUDEFLicCode then
    oldLicType := ltUDEFLic
  else
    oldLicType := ltUDEFLic;

  //Convert Old License Type to New License Type
  case oldLicType of
    ltValidLic:
      result := ltSubscriptionLic;
    ltTempLic:
      result := ltEvaluationLic;
    ltExpiredLic:
      result := ltExpiredLic;
    ltUDEFLic:
      result := ltUndefinedLic;
  else
    result := ltUndefinedLic;
  end;
end;

procedure TSWLicense.ReadFromStreamV1(Stream: TFileStream);
var
  amt,numRecs: LongInt;
  ProdList: Array of ProdCodeRec;
  ALicCode: LongInt;
  ARegistNo: LongInt;       //not used- still need to read
  ASerialNo1: String;
  ASerialNo2: String;
  ASerialNo3: String;
  ASerialNo4: String;
  Extra1,Extra2,Extra3,Extra4,Extra5: LongInt;  //extra longs - spare space
begin
  ALicCode := ReadLongFromStream(Stream);        //read the current Lic code

  FLicType      := ConvertOldCode2LicType(ALicCode);
  FLicName      := ReadStringFromStream(Stream);      //read lic user name
  FLicCoName    := ReadStringFromStream(Stream);    //read the lic company name
  FLicLockedCo  := ReadBoolFromStream(Stream);

  ARegistNo := ReadLongFromStream(Stream);
  ASerialNo1 := ReadStringFromStream(Stream);
  ASerialNo2 := ReadStringFromStream(Stream);
  ASerialNo3 := ReadStringFromStream(Stream);
  ASerialNo4 := ReadStringFromStream(Stream);

  //this is old stuff - we just throw it away
  numRecs := ReadLongFromStream(Stream);          //read number of lic recs
  SetLength(ProdList, numRecs);                  //make room for numRecs
  amt := Length(ProdList) * sizeOf(ProdCodeRec);
  Stream.Read(Pointer(ProdList)^, amt);          //read the array of Prod Unlock codes
  ProdList := nil;                               //throw old stuff away

  Extra1 := ReadLongFromStream(Stream);
  Extra2 := ReadLongFromStream(Stream);
  Extra3 := ReadLongFromStream(Stream);
  Extra4 := ReadLongFromStream(Stream);
  Extra5 := ReadLongFromStream(Stream);

  FModified := True;       //need to write in newer format
end;

procedure TSWLicense.ReadFromStreamV2(Stream: TFileStream);
var
  ProdLics: TProdLicenses;
  ALicCode: Longint;
  ARegistNo: LongInt;       //not used- still need to read all these
  ASerialNo1: String;
  ASerialNo2: String;
  ASerialNo3: String;
  ASerialNo4: String;
  Extra1,Extra2,Extra3,Extra4,Extra5: LongInt;  //extra longs - spare space
begin
  ALicCode := ReadLongFromStream(Stream);        //read the current Lic code

  FLicType      := ConvertOldCode2LicType(ALicCode);
  FLicName      := ReadStringFromStream(Stream);      //read lic user name
  FLicCoName    := ReadStringFromStream(Stream);    //read the lic company name
  FLicLockedCo  := ReadBoolFromStream(Stream);

  ARegistNo := ReadLongFromStream(Stream);

  ASerialNo1 := ReadStringFromStream(Stream);
  ASerialNo2 := ReadStringFromStream(Stream);
  ASerialNo3 := ReadStringFromStream(Stream);
  ASerialNo4 := ReadStringFromStream(Stream);

  //Historical - read and discard
  ProdLics := TProdLicenses.Create(True);
  try
    ProdLics.ReadFromStream(Stream);             //added new prod licenses self-write
  finally
    FreeAndNil(ProdLics);
  end;

  Extra1 := ReadLongFromStream(Stream);
  Extra2 := ReadLongFromStream(Stream);
  Extra3 := ReadLongFromStream(Stream);
  Extra4 := ReadLongFromStream(Stream);
  Extra5 := ReadLongFromStream(Stream);

  FModified := True;       //need to write in newer format
end;

//
procedure TSWLicense.ReadFromStreamV3(Stream: TFileStream);
var
  ProdLics: TProdLicenses;
  ALicCode: Longint;
  ARegistNo: LongInt;       //not used- still need to read
  ASerialNo1: String;
  ASerialNo2: String;
  ASerialNo3: String;
  ASerialNo4: String;
  Extra1,Extra2,Extra3,Extra4,Extra5: LongInt;  //extra longs - spares
  AValidSubscriber, AValidSubscription: LongInt;
  ALastChkInDate: TDateTime;
begin
  ALicCode      := ReadLongFromStream(Stream);        //read the current Lic code

  FLicType      := ConvertOldCode2LicType(ALicCode);
  FLicName      := ReadStringFromStream(Stream);      //read lic user name
  FLicCoName    := ReadStringFromStream(Stream);      //read the lic company name
  FLicLockedCo  := ReadBoolFromStream(Stream);

  ARegistNo := ReadLongFromStream(Stream);

  ASerialNo1 := ReadStringFromStream(Stream);
  ASerialNo2 := ReadStringFromStream(Stream);
  ASerialNo3 := ReadStringFromStream(Stream);
  ASerialNo4 := ReadStringFromStream(Stream);

  //Historical - read and discard
  ProdLics := TProdLicenses.Create(True);
  try
    ProdLics.ReadFromStream(Stream);             //added new prod licenses self-write
  finally
    FreeAndNil(ProdLics);                       //not used anymore
  end;

  Extra1 := ReadLongFromStream(Stream);
  Extra2 := ReadLongFromStream(Stream);
  Extra3 := ReadLongFromStream(Stream);
  Extra4 := ReadLongFromStream(Stream);
  Extra5 := ReadLongFromStream(Stream);

  AValidSubscriber    := ReadLongFromStream(Stream);
  AValidSubscription  := ReadLongFromStream(Stream);
  ALastChkInDate      := ReadDateFromStream(Stream);

  FModified := True;       //need to write in newer format
end;

procedure TSWLicense.ReadFromStream(Stream: TFileStream);
var
  Vers: Integer;
  //extra strings - not used yet
  Extra1,Extra2,Extra3,Extra4,Extra5: LongInt;  //spare Longs
  ExStr1,ExStr2,ExStr3,ExStr4,ExStr5: String;   //spare strings
begin
  Vers := ReadLongFromStream(Stream);           //read version number
  FLicVersion := Vers;                          //use this version # from license file to decide to do backup or not
  if Vers = cSWLicVers1 then                    //branh on version
    ReadFromStreamV1(Stream)

  else if Vers = cSWLicVers2 then
    ReadFromStreamV2(Stream)

  else if Vers = cSWLicVers3 then
    ReadFromStreamV3(Stream)

  else if Vers = cSWLicVers4 then
    begin
      FLicName        := ReadStringFromStream(Stream);      //read lic user name
      FLicCoName      := ReadStringFromStream(Stream);    //read the lic company name
      FLicLockedCo    := ReadBoolFromStream(Stream);

      FLicType        := ReadLongFromStream(Stream);        //read the current Lic code
      FLicTerm        := ReadLongFromStream(Stream);
      FLicEndDate     := ReadStringFromStream(Stream);      //write lic user name
      FLastChkInDate  := ReadStringFromStream(Stream);
      FChkInterval    := ReadLongFromStream(Stream);        //interval (days) between check in to registry server
      FGracePeriod    := ReadLongFromStream(Stream);
      FIsValidUser    := ReadBoolFromStream(Stream);        //load FIsValidUser from license file

      ExStr1 := ReadStringFromStream(Stream);
      ExStr2 := ReadStringFromStream(Stream);
      ExStr3 := ReadStringFromStream(Stream);
      ExStr4 := ReadStringFromStream(Stream);
      ExStr5 := ReadStringFromStream(Stream);

      Extra1 := ReadLongFromStream(Stream);
      Extra2 := ReadLongFromStream(Stream);
      Extra3 := ReadLongFromStream(Stream);
      Extra4 := ReadLongFromStream(Stream);
      Extra5 := ReadLongFromStream(Stream);
    end;
end;

procedure TSWLicense.WriteToStream(Stream: TFileStream);
var
  Extra1,Extra2,Extra3,Extra4,Extra5: LongInt;    //spare longs
  ExStr1,ExStr2,ExStr3,ExStr4,ExStr5: String;     //spare strings
begin
  WriteLongToStream(FVers, Stream);           //write version number

  WriteStringToStream(FLicName, Stream);      //write lic user name
  WriteStringToStream(FLicCoName, Stream);    //write the lic company name
  WriteBoolToStream(FLicLockedCo, Stream);

  WriteLongToStream(FLicType, Stream);            //write Lic Type
  WriteLongToStream(FLicTerm, Stream);
  WriteStringToStream(FLicEndDate, Stream);       //write lic user name
  WriteStringToStream(FLastChkInDate, Stream);
  WriteLongToStream(FChkInterval, Stream);        //interval (days) between check in to registry server
  WriteLongToStream(FGracePeriod, Stream);
  WriteBoolToStream(FIsValidUser, Stream);        //PAM: write FIsValidUser to license file

  //write spare strings and longs
  ExStr1 := '';
  ExStr2 := '';
  ExStr3 := '';
  ExStr4 := '';
  ExStr5 := '';
  WriteStringToStream(ExStr1, Stream);
  WriteStringToStream(ExStr2, Stream);
  WriteStringToStream(ExStr3, Stream);
  WriteStringToStream(ExStr4, Stream);
  WriteStringToStream(ExStr5, Stream);

  Extra1 := 0;
  Extra2 := 0;
  Extra3 := 0;
  Extra4 := 0;
  Extra5 := 0;
  WriteLongToStream(Extra1, Stream);
  WriteLongToStream(Extra2, Stream);
  WriteLongToStream(Extra3, Stream);
  WriteLongToStream(Extra4, Stream);
  WriteLongToStream(Extra5, Stream);

  FModified := False;
end;

function TSWLicense.GetValidUsage: Boolean;
begin
  result := ((LicType = ltSubscriptionLic) or (LicType = ltEvaluationLic)) and FIsValidUser; //FIsValidUser = True when regSub OK
end;

procedure TSWLicense.SetValidUsage(Value: Boolean);
begin
  FIsValidUser := Value;
end;


function TSWLicense.UsageDaysRemaining: Integer;
var
  Days: Integer;
  EndDate: TDateTime;
begin
  Days := 0;

  if FLicType = ltSubscriptionLic then
    begin
      if IsValidXMLDate(FLicEndDate, EndDate) then
        begin
          if (CompareDate(Today, EndDate) = LessThanValue) then   //Today is < than endDate
            Days := Round(DaySpan(Today, EndDate) + 0.5);
        end;
    end

  else if FLicType = ltEvaluationLic then
    begin
      if IsValidXMLDate(FLicEndDate, EndDate) then
        begin
          if (CompareDate(Today, EndDate) = LessThanValue) then   //Today is < than endDate
            Days := Round(DaySpan(Today, EndDate) + 0.5)
        end;
    end;
//else if lic = expired or undefined - they have zero usage}

  result := Days;
end;


function TSWLicense.GraceDaysRemaining: Integer;
var
  days: Integer;
  EndDate, GraceEndDate: TDateTime;
begin
  Days := 0;

  if FLicType = ltSubscriptionLic then   {if Lic = Eval, Expired or Undef - no grace period for them}
    begin
      if IsValidXMLDate(FLicEndDate, EndDate) then
        begin
          GraceEndDate := IncDay(EndDate, FGracePeriod);
          //NOTE: the compareDate(A,B) can return -1 for A < B, 0 for A = B and 1 for A > B, if A > B means license is expired
          if (CompareDate(Today, GraceEndDate) <> GreaterThanValue) then   //Today is either <= endDate means not expired
            Days := Round(DaySpan(Today, GraceEndDate) + 0.5);
        end;
    end;
  Result := Days;
end;

function TSWLicense.EvalGraceDaysRemaining: Integer;
var
  days: Integer;
  EndDate, GraceEndDate: TDateTime;
begin
  Days := 0;

  if FLicType = ltEvaluationLic then   {if Lic = Expired or Undef - no grace period for them}
    begin
      if IsValidXMLDate(FLicEndDate, EndDate) then
        begin
          GraceEndDate := IncDay(EndDate, FEvalGracePeriod);

          //NOTE: the compareDate(A,B) can return -1 for A < B, 0 for A = B and 1 for A > B, if A > B means license is expired
          if (CompareDate(Today, GraceEndDate) <> GreaterThanValue) then   //Today is either <= enddate means not expired
            Days := Round(DaySpan(Today, GraceEndDate) + 0.5);
        end;
    end;

  Result := Days;
end;

//checkIn = true if
//If Today is => than License End Day
//or Today is => then checkin Interval day
//otherwise do not check in
function TSWLicense.LicenseCheckInRequired: Boolean;
var
  LastCheckin: TDateTime;
  CheckInDay: TDateTime;
  EndDate: TDateTime;
begin
  result := False;
  if IsValidXMLDate(FLicEndDate, EndDate) then
    if IsValidXMLDate(FLastChkInDate, LastCheckIn) then
      begin
        CheckInDay := IncDay(LastCheckIn, FChkInterval);
        if (CompareDate(Today, CheckInDay) <> LessThanValue) OR (CompareDate(Today, EndDate) <> LessThanValue) then   //Today is either = or > than endDate or checkinDate
          result := True;
      end
end;

{ TUserSignature }

constructor TUserSignature.Create;
begin
  inherited;

  FPassword := 0;
  FUsePSW := False;
  FOffsetX := 0;
  FOffsetY := 0;
  FDestRect := Rect(0,0,0,0);
  FImageLen := 0;
  FImage := nil;
end;

destructor TUserSignature.Destroy;
begin
  if assigned(FImage) then
    FImage.Free;

  inherited;
end;

procedure TUserSignature.Clear;
begin
  FPassword := 0;
  FUsePSW := False;
  FOffsetX := 0;
  FOffsetY := 0;
  FDestRect := Rect(0,0,0,0);
  FImageLen := 0;

  if assigned(FImage) then
    FreeAndNil(FImage);
end;

procedure TUserSignature.ReadFromStream(Stream: TFileStream);
begin
  FPassword := ReadLongFromStream(Stream);
  FUsePSW := ReadBoolFromStream(Stream);
  FOffsetX := ReadLongFromStream(Stream);
  FOffsetY := ReadLongFromStream(Stream);
  FDestRect := ReadRectFromStream(Stream);
  FImageLen := ReadLongFromStream(Stream);
  if FImageLen > 0 then
    begin
      FImage := TImageStream.Create;
      FImage.CopyFrom(Stream, FImageLen);
      FImage.Seek(0,soFromBeginning);
//      TImageStream(FImage).LoadFromStreamEx(Stream, FImageLen);
    end;
end;

procedure TUserSignature.WriteToStream(Stream: TFileStream);
begin
  WriteLongToStream(FPassword, Stream);
  WriteBoolToStream(FUsePSW, Stream);
  WriteLongToStream(FOffsetX, Stream);
  WriteLongToStream(FOffsetY, Stream);
  WriteRectToStream(FDestRect, Stream);
  WriteLongToStream(FImageLen, Stream);
  if FImage <> nil then
    FImage.SaveToStream(Stream);
end;


{ TProdLicKey }
// - Kept for historical reasons so we can read old License files
constructor TProdLic.Create(PID: Integer);
begin
  FProdID := PID;
  FUnLockCode := 0;
  FExpires := '';
  FUsageLeft := 0;
  
  FExtra1 := 0;          //for future use
  FExtra2 := 0;
  FExtra3 := 0;
  FExtra4 := 0;

  //storage while running
  FProductName  := '';        //name of the product
  FProdUserVers := '';        //(ie: 1.1.215)
  FProdRelease  := 0;         //product release number, 1, 2, 3, 4
  FProdVersSeed := 0;         //the unique product seed for this version
end;

procedure TProdLic.WriteToStream(Stream: TStream);
begin
  WriteLongToStream(FProdID, Stream);
  WriteLongToStream(FUnLockCode, Stream);
  WriteStringToStream(FExpires, Stream);
  WriteLongToStream(FUsageLeft, Stream);
  WriteLongToStream(FExtra1, Stream);
  WriteLongToStream(FExtra2, Stream);
  WriteLongToStream(FExtra3, Stream);
  WriteLongToStream(FExtra4, Stream);
end;

procedure TProdLic.ReadFromStream(Stream: TStream);
begin
  FProdID := ReadLongFromStream(Stream);
  FUnLockCode := ReadLongFromStream(Stream);
  FExpires := ReadStringFromStream(Stream);
  FUsageLeft := ReadLongFromStream(Stream);
  FExtra1 := ReadLongFromStream(Stream);
  FExtra2 := ReadLongFromStream(Stream);
  FExtra3 := ReadLongFromStream(Stream);
  FExtra4 := ReadLongFromStream(Stream);
end;


{ TProdLicenses }

procedure TProdLicenses.WriteToStream(Stream: TStream);
var
  i: Integer;
  Vers: LongInt;
begin
  Vers := 1;                                //set this version at 1
  WriteLongToStream(Vers, Stream);
  WriteLongToStream(Count, Stream);         //write number of ProdLic objects

  for i := 1 to Count do                    //write each Lic Object
    TProdLic(Items[i-1]).WriteToStream(Stream);
end;

procedure TProdLicenses.ReadFromStream(Stream: TStream);
var
  i, N: Integer;
  ProdLic: TProdLic;
  {Vers: LongInt;}
begin
  {Vers := }ReadLongFromStream(Stream);          //read the version, not used yet
  N := ReadLongFromStream(Stream);               //read the ProdLic count
  for i := 1 to N do
    begin
      ProdLic := TProdLic.Create(0);             //create the holder
      ProdLic.ReadFromStream(Stream);            //read the data
      Add(ProdLic);                              //store the data
    end;
end;


{ TUser }

function TUser.LicFileExists: Boolean;
begin
  result := FileExists(FFilePath);
end;


function TUser.IsRegistered: Boolean;
begin
  result := FIsValidUser;      //may not be current
end;


function TUser.IsLicensedToUse(AProduct: Integer): Boolean;
var
  LicUser: TCRMLicensedUser;
begin
  result := False;
  if fileExists(FFilePath) then
  begin
    LicUser := TCRMLicensedUser.Create;
    try
      LicUser.LoadUserLicFile(FFileName);
      result := LicUser.OK2UseAWProduct(AProduct, True, True);
    finally
      LicUser.Free;
    end;
  end;
end;

{ TUserList }

procedure TUserList.GatherUserLicFiles;
begin
  Clear;
  FileFinder.OnFileFound := ProcessLicFile;
  FileFinder.Find(appPref_DirLicenses, False, '*.lic');     //find all lic files
end;

procedure TUserList.SaveLicensePref;
var
  PrefFile: TIniFile;
  IniFilePath : String;
begin
  IniFilePath := IncludeTrailingPathDelimiter(appPref_DirLicenses) + cLicPrefs;
  PrefFile := TIniFile.Create(IniFilePath);                   //create the INI writer
  With PrefFile do
    begin
      WriteString('UserLic', 'Default', FDefaultUserFile);
      UpdateFile;      // do it mow
    end;
  PrefFile.Free;
end;

procedure TUserList.LoadLicensePref;
var
  PrefFile: TIniFile;
  IniFilePath : String;
begin
  IniFilePath := IncludeTrailingPathDelimiter(appPref_DirLicenses) + cLicPrefs;
  PrefFile := TIniFile.Create(IniFilePath);                   //create the INI writer
  With PrefFile do
    begin
      FDefaultUserFile := ReadString('UserLic', 'Default', '');
    end;
  PrefFile.Free;
end;


procedure TUserList.ProcessLicFile(Sender: TObject; FileName: string);
var
  fName: String;
  User: TUser;
  tmpUser: TCRMLicensedUser;
begin
  fName := ExtractFileName(fileName);
  tmpUser := TCRMLicensedUser.Create;          //need to read the file
  try
    tmpUser.LoadFromFile(fileName);

    User := TUser.Create;
    User.FLicName           := tmpUser.SWLicenseName;         //signature name
    User.FLicCoName         := tmpUser.SWLicenseCoName;
    User.FLicCoNameLocked   := tmpUser.SWLicenseCoNameLocked;
    User.FFileName          := fName;                         //file name
    User.FFilePath          := fileName;                      //full path & name
    User.FIsValidUser       := tmpUser.LicInfo.GetValidUsage; //may not be uptodate
    Add(User);
  finally
    tmpUser.Free;
  end;
end;

//returns users signature name
function TUserList.GetDefaultUserName: String;
var
  I: Integer;
begin
  result := '';
  if length(FDefaultUserFile) > 0 then
    begin
      i := 0;
      while (i < Count) do
        begin
          if (compareText(FDefaultUserFile, TUser(Items[i]).FFileName) = 0) then
            begin
              result := TUser(Items[i]).FLicName;  //signature name
              break;
            end;
          inc(i);
        end;
    end;
end;
//###REMOVE- CHECK
function TUserList.GetLockedCoName: String;
var
  i: Integer;
  ALockedCoName: String;
begin
  ALockedCoName := '';

  //Get the first locked Co Name from the user list
  i := 0;
  while (i < Count) do
    begin
      if TUser(Items[i]).FLicCoNameLocked then
        begin
          ALockedCoName := TUser(Items[i]).FLicCoName;
          break;
        end;
      inc(i);
    end;

  //No locked CoNames, get the CoName of first registered users
  if length(ALockedCoName) = 0 then
    begin
      i := 0;
      while (i < Count) do
        begin
          if TUser(Items[i]).IsRegistered then
            begin
              ALockedCoName := TUser(Items[i]).FLicCoName;
              break;
            end;
          inc(i);
        end;
    end;

  if length(ALockedCoName) = 0 then
    ALockedCoName := 'Unregistered Company Name';

  result := ALockedCoName;
end;

function TUserList.UserFilePath(Const UserLicName: String): String;
var
  I: Integer;
begin
  result := '';
  if length(UserLicName) > 0 then
    begin
      i := 0;
      while (i < Count) do
        begin
          if (compareText(UserLicName, TUser(Items[i]).FLicName) = 0) then
            begin
              result := TUser(Items[i]).FFilePath;
              break;
            end;
          inc(i);
        end;
    end;
end;

function TUserList.UserIsRegistered(Const UserLicName: String): Boolean;
var
  I: Integer;
begin
  result := False;
  if length(UserLicName) > 0 then
    begin
      i := 0;
      while (i < Count) do
        begin
          if (compareText(UserLicName, TUser(Items[i]).FLicName) = 0) then
            begin
              result := TUser(Items[i]).IsRegistered;
              break;
            end;
          inc(i);
        end;
    end;
end;

///PAM_REG:  seems like we need this for area sketch
function TUserList.HasRegisteredUserFor(AProduct: Integer): Boolean;
var
  i: Integer;
begin
  result := True;
  i := 0;
  while (i < Count) do
    begin
      if TUser(Items[i]).IsLicensedToUse(AProduct) then
        begin
          result := True;
          break;
        end;
      inc(i);
    end;
end;


//called by Clickforms during startup when there is no default and multiusers
function TUserList.SelectOneUserLicFile: String;
var
  SelectAUser: TCRMSelectLicUser;
  i,j: Integer;
begin
  result := '';
  SelectAUser := TCRMSelectLicUser.Create(nil);
  try
    for i := 0 to count-1 do
      SelectAUser.UserList.Items.Add(TUser(Items[i]).FFileName);

    if SelectAUser.ShowModal = mrOK then
      begin
        j := SelectAUser.UserList.ItemIndex;
        result := SelectAUser.UserList.Items[j];

        if SelectAUser.cbxIsDefault.checked then
          begin
            DefaultUser := result;     //name of file
          end;
      end;
  finally
    SelectAUser.Free;
  end;
end;

function TUserList.UserFileExists(FName: String): Boolean;
var
  fullPath: String;
begin
  result := False;
  if length(FName) > 0 then
    begin
      fullPath := IncludeTrailingPathDelimiter(appPref_DirLicenses) + FName;
      result := FileExists(fullPath);
    end;
end;

procedure TUserList.WriteDefaultUserPreference;
var
  PrefFile: TIniFile;
  IniFilePath : String;
begin
  IniFilePath := IncludeTrailingPathDelimiter(appPref_DirLicenses) + cLicPrefs;
  PrefFile := TIniFile.Create(IniFilePath);                   //create the INI writer
  With PrefFile do
    begin
      WriteString('UserLic', 'Default', FDefaultUserFile);
      UpdateFile;      // do it mow
    end;
  PrefFile.Free;
end;

procedure TUserList.ReadDefaultUserPreference;
var
  PrefFile: TIniFile;
  IniFilePath: String;
begin
  IniFilePath := IncludeTrailingPathDelimiter(appPref_DirLicenses) + cLicPrefs;

  PrefFile := TIniFile.Create(IniFilePath);                   //create the INI writer
  With PrefFile do
    begin
      FDefaultUserFile := ReadString('UserLic', 'Default', '');
    end;
  PrefFile.Free;
end;

//=================================================

procedure TUserList.SetDefaultUser(Value: String);
begin
  FDefaultUserFile := Value;
end;

function TUserList.GetDefaultUser: String;      //GetDefaultUserFile

begin
  if count = 1 then                               //if only one user...
    result := TUser(Items[0]).FFileName

  else if UserFileExists(FDefaultUserFile) then  //if they have set a default
    begin
      result := FDefaultUserFile
    end

  else if (count > 1) then //more than one, no default, select
    result := SelectOneUserLicFile

  else
    result := '';
end;
//===================================================

//set the default or selected user into CurrentUser object
procedure TUserList.SetInitialCurrentUser;
var
  CurUserFile: String;
begin
  CurUserFile := '';                              //none selected

  if UserFileExists(FDefaultUserFile) then        //is there a default
    CurUserFile := FDefaultUserFile

  else if count = 1 then                          //if only one user...
    begin
      CurUserFile := TUser(Items[0]).FFileName;
      FDefaultUserFile := FDefaultUserFile;       //remember as default
    end

  else if (count > 1) then      //more than one, no default, must select
    CurUserFile := SelectOneUserLicFile;


  if length(CurUserFile) > 0 then                 // A user lic file existed, load as CurrentUser
    CurrentUser.LoadUserLicFile(CurUserFile);     // CurrentUser created on Initilization
//else
//  CurrentUser has default setting of (FLicType := ltUndefinedLic)
//  ULicAuthorize.Ok2Run will finalize CurrentUser usage
end;


function TCRMLicensedUser.OK2UseCustDBproduct(PIDIDx: Integer): Boolean;
  function GetCustDBServiceID(clfServiceID: integer): integer;
  begin
    result := 0;
    case clfServiceID of
      pidClickForms: result := stMaintanence;
      pidAppraisalPort: result := stAppraisalPort;
      pidPropertyDataImport: result := stDataImport;
      pidMLSDataImport: result := stMLS;
      pidRelsConnection: result := stRels;
      pidUADForms: result := stUAD;
      pidOnlineFloodMaps : result := stFloodMaps;
      pidMCAnalysis      : result := stMarketAnalyses;
      pidOnlineLocMaps   : result := stLocationMaps;
      pidSwiftEstimator  : result := stMarshalAndSwift;
      pidPictometry      : result := stPictometry;
      pidBuildFax        : result := stBuildfax;
    end;
  end;
var
  custDBServiceID: integer;
  servInfo: ServiceInfo;
begin
  result := false;
  RefreshServStatuses;   //Be sure global ServiceStatuses based only on custDB
  custDBServiceID := GetCustDBServiceID(PIDIDx);
  if custDBServiceID = 0 then
    exit;
  servINFo := GetServiceByServID(custDBServiceID);
  result := servInfo.status = statusOK;
end;

function TCRMLicensedUser.OK2UseAW1004MCProduct(PIDIdx: Integer; Silent: Boolean=False): Boolean;
const
  rspLogin  = 6;
var
  AWCredentials: clsUsageAccessCredentials;
  AWRespond: clsGetUsageAvailabilityResponse;
  AWRequest: clsRequestDetails;
  ErrType, rsp: Integer;
  awCustEmail, awCustPsw,awApprIDStr,custDBIDstr: String;
  aAWLogin, aAWPsw, aAWCustUID: String;
begin
  Result := False;
  CurrentUser.GetUserAWLoginByLicType(PIDIdx, aAWLogin, aAWPsw, aAWCustUID); //base on the license type to return either the Real user or trial user
  if IsAWLoginOK(aAWLogin, aAWPsw) then
    begin
      AWCredentials  := clsUsageAccessCredentials.Create;
      AWRequest := clsRequestDetails.Create;
      try
        AWCredentials.CustomerId := StrToIntDef(aAWCustUID,0);
        if AWCredentials.CustomerId = 0 then
          AWCredentials.CustomerId := StrToIntDef(AWUserInfo.CustDBIdentifier, 0); // this may be zero if not an AW member
          if IsUserAppraisalWorldMember(aAWLogin,aAWPsw,awApprIDStr,aAWCustUID) then
            AWCredentials.AppraiserId := StrToIntDef(awApprIDStr,0);

        //    AWCredentials.CustomerId := 1; // Note 20130809: This produces ResponseData = nil
        AWCredentials.ServiceId := awsi_CFProductAvailableID;
        AWRequest.ProductServiceId := pidAW[PIDIdx];

        with GetClickformsServerPortType(False, GetAWURLForClickFORMSService(True)) do
        begin
          AWRespond := ClickformsServices_GetUsageAvailability(AWCredentials, AWRequest);
          if AWRespond.Results = nil then
            ShowAlert(atWarnAlert, errOnAWResults)
          else
            if AWRespond.Results.Code = 0 then //call succeeded
              begin
                if AWRespond.ResponseData = nil then
                  begin
                    if not Silent then
                      ShowAlert(atWarnAlert, errOnAWResponse);
                  end
                else
                  begin
                    result  := CompareText(AWRespond.ResponseData.ProductAvailable,'Yes') = 0;
                    if (not result) and (not Silent) then
                      begin
                        // Note: The maximum length of the response message should be 230 characters or
                        //  less. Otherwise it may overflow the space in the WarnWithOption12 dialog.
                        //  This could change if the dialog display field is changed to a memo.
                        rsp := WarnWithOption12('Purchase', 'Cancel', ServiceWarning_TimebasedWhenExpired);
                        if rsp = rspLogin then
                          HelpCmdHandler(cmdHelpAWShop4Service, AWUserInfo.UserCustUID, CurrentUser.AWUserInfo.UserLoginEmail);   //link to the AppraisalWorld store
                      end;
                  end;
              end
            else if not Silent then
              begin
                if AWRespond.Results.Type_ = 'Info' then
                  ErrType := atInfoAlert
                else if AWRespond.Results.Type_ = 'Warn' then
                  ErrType := atWarnAlert
                else
                  ErrType := atStopAlert;
                ShowAlert(ErrType, AWRespond.Results.Description);
              end;
        end;
      finally
        AWRequest.Free;
        AWCredentials.Free;
      end;
  end;
end;



function TCRMLicensedUser.OK2UseAWProduct(PIDIdx: Integer; var AWRespData: clsGetUsageAvailabilityData;
    Silent: Boolean=True; AvailabilityOnlyChk: Boolean=True): Boolean;
const
  rspLogin  = 6;
var
  AWCredentials: clsUsageAccessCredentials;
  AWRespond: clsGetUsageAvailabilityResponse;
  AWRequest: clsRequestDetails;
  ErrType, rsp: Integer;
  awApprIDstr, aMsg: String;
  awApprID: Integer;
  aAWLogin, aAWPsw, aAWCustUID: String;
begin
  Result := False;
  try
    CurrentUser.GetUserAWLoginByLicType(PIDIdx, aAWLogin, aAWPsw, aAWCustUID); //base on the license type to return either the Real user or trial user
    if AvailabilityOnlyChk or IsAWLoginOK(aAWLogin, aAWPsw) then
      begin
        AWRespData := nil;
        awApprID := strToIntDef(AWUserInfo.AWIdentifier,0);
        if awApprID = 0 then //try to get AWAppraiserID
          if IsUserAppraisalWorldMember(aAWLogin,aAWPsw,awApprIDStr,aAWCustUID) then
              awApprID := StrToIntDef(awApprIDStr,0);
        AWCredentials  := clsUsageAccessCredentials.Create;
        AWRequest := clsRequestDetails.Create;
        try
          AWCredentials.CustomerId := StrToIntDef(aAWCustUID, 0);
          AWCredentials.AppraiserId := awApprID;

          if (AWCredentials.AppraiserId = 0) and (AWCredentials.CustomerId = 0) then  //no identification, do not call AWSI server
              exit;

          AWCredentials.ServiceId := awsi_CFProductAvailableID;
          AWRequest.ProductServiceId := pidAW[PIDIdx];
          with GetClickformsServerPortType(False, GetAWURLForClickFORMSService) do
          begin
            AWRespond := ClickformsServices_GetUsageAvailability(AWCredentials, AWRequest);
            if AWRespond.Results = nil then
              ShowAlert(atWarnAlert, errOnAWResults)
            else
              if AWRespond.Results.Code = 0 then //call succeeded
                begin
                  if AWRespond.ResponseData = nil then
                    ShowAlert(atWarnAlert, errOnAWResponse)
                  else
                    begin
                      AWRespData := AWRespond.ResponseData;
                      result  := CompareText(AWRespData.ProductAvailable,'Yes') = 0;
                      if (not result) and (not Silent) then
                        begin
                          if isUnitBasedWebService(AWRespData.WebServiceId) then
                            aMsg := ServiceWarning_UnitBasedWhenExipred
                          else
                            aMsg := ServiceWarning_TimebasedWhenExpired;

                          rsp := WarnWithOption12('Purchase', 'Cancel', aMsg);
                          if rsp = rspLogin then
                            HelpCmdHandler(cmdHelpAWShop4Service, AWUserInfo.UserCustUID, CurrentUser.AWUserInfo.UserLoginEmail);   //link to the AppraisalWorld store
                        end
                      else
                        begin
                          CheckServiceAvailable(AWRespData.WebServiceId);
                        end;
                    end;
                end
              else
                begin
                  if AWRespond.Results.Type_ = 'Info' then
                    ErrType := atInfoAlert
                  else if AWRespond.Results.Type_ = 'Warn' then
                    ErrType := atWarnAlert
                  else
                    ErrType := atStopAlert;
                  if not Silent then
                    ShowAlert(ErrType, AWRespond.Results.Description);
                end;
          end;
        finally
          AWRequest.Free;
          AWCredentials.Free;
        end;
    end;
  except on E:Exception do
    result := False;  //make sure we set result to False in case we fail to call AWSI so we can continue to call custdb
  end;
end;

function TCRMLicensedUser.OK2UseAWProduct(PIDIdx: Integer; Silent: Boolean=True;
    AvailabilityOnlyChk: Boolean=True): Boolean;
const
  rspLogin  = 6;
var
  AWCredentials: clsUsageAccessCredentials;
  AWRespond: clsGetUsageAvailabilityResponse;
  AWRequest: clsRequestDetails;
  ErrType, rsp: Integer;
  awApprIDstr, aMsg: String;
  aAWLogin, aAWPsw, aAWCustUID: String;
  awApprID: Integer;
begin
  Result := False;
  CurrentUser.GetUserAWLoginByLicType(PIDIdx, aAWLogin, aAWPsw, aAWCustUID); //base on the license type to return either the Real user or trial user
  if IsConnectedToWeb then               //can we connect?
    if AvailabilityOnlyChk or IsAWLoginOK(aAWLogin, aAWPsw) then
      begin
        awApprID := strToIntDef(AWUserInfo.AWIdentifier,0);
        if awApprID = 0 then //try to get AWAppraiserID
          if IsUserAppraisalWorldMember(aAWLogin,aAWPsw,awApprIDStr,aAWCustUID) then
            awApprID := StrToIntDef(awApprIDStr,0);
        AWCredentials  := clsUsageAccessCredentials.Create;
        AWRequest := clsRequestDetails.Create;
        try
          AWCredentials.CustomerId := StrToIntDef(aAWCustUID, 0);
          AWCredentials.AppraiserId := awApprID;

          if (AWCredentials.AppraiserId = 0) and (AWCredentials.CustomerId = 0) then  //no identification, do not call AWSI server
            exit;
          //    AWCredentials.CustomerId := 1; // Note 20130809: This produces ResponseData = nil
          AWCredentials.ServiceId := awsi_CFProductAvailableID;
          AWRequest.ProductServiceId := pidAW[PIDIdx];
          with GetClickformsServerPortType(False, GetAWURLForClickFORMSService) do
          begin
            AWRespond := ClickformsServices_GetUsageAvailability(AWCredentials, AWRequest);
            if AWRespond.Results = nil then
              ShowAlert(atWarnAlert, errOnAWResults)
            else
              if AWRespond.Results.Code = 0 then //call succeeded
                begin
                  if AWRespond.ResponseData = nil then
                    begin
                      if not Silent then
                        ShowAlert(atWarnAlert, errOnAWResponse);
                    end
                  else
                    begin
                      result  := CompareText(AWRespond.ResponseData.ProductAvailable,'Yes') = 0;
                      if (not result) and (not Silent) then
                        begin
                          if isUnitBasedWebService(AWRespond.ResponseData.WebServiceID) then
                            aMsg := ServiceWarning_UnitBasedWhenExipred
                          else if Comparetext(AWRespond.ResponseData.ProductAvailable,'No') = 0 then
                            aMsg := ServiceWarning_NotAvailable
                          else
                            aMsg := ServiceWarning_TimebasedWhenExpired;

                          rsp := WarnWithOption12('Purchase', 'Cancel', aMsg);
                          if rsp = rspLogin then
                            HelpCmdHandler(cmdHelpAWShop4Service, AWUserInfo.UserCustUID, CurrentUser.AWUserInfo.UserLoginEmail);   //link to the AppraisalWorld store
                        end;
                    end;
                end
              else if not Silent then
                begin
                  if AWRespond.Results.Type_ = 'Info' then
                    ErrType := atInfoAlert
                  else if AWRespond.Results.Type_ = 'Warn' then
                    ErrType := atWarnAlert
                  else
                    ErrType := atStopAlert;
                  ShowAlert(ErrType, AWRespond.Results.Description);
                end;
          end;
        finally
          AWRequest.Free;
          AWCredentials.Free;
        end;
      end;
end;



//===================================================
// Key Routine
// Called from Project Unit at startup to set the CurrentUser
procedure InitLicensedUsers;
begin
  LicensedUsers := TUserList.Create(True);      //create list to hold ref list to user's license files
  LicensedUsers.GatherUserLicFiles;             //get a list of users (user license files in User Licenses)
  LicensedUsers.ReadDefaultUserPreference;      //who is default user in Preferences
  LicensedUsers.SetInitialCurrentUser;          //determine who current should be and set CurrentUser
end;


{*************************************}
{    Initialization & Finalization    }
{    for Current User.                }
{*************************************}


initialization
  CurrentUser := TCRMLicensedUser.Create;


finalization

  if assigned(CurrentUser) then
    try
      if CurrentUser.FModified then
        CurrentUser.SaveUserLicFile;
    finally
      CurrentUser.Free;
    end;

end.
