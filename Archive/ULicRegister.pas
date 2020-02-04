unit ULicRegister;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{ This is the registration interface licensing ClickForms and }                               
{ other products and services that are used within ClickForms.}

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}


interface

uses
	Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
	StdCtrls, Mask, ExtCtrls, ComCtrls,
  UGlobals, ULicUser, Grids_ts, TSGrid, Buttons, IdMessage,
  IdMessageClient, IdSMTP, IdURI, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP, IdBaseComponent, IdAntiFreezeBase, IdAntiFreeze,
  IdExplicitTLSClientServerBase, IdSMTPBase, Grids, UForms, RzLabel;

type
	TRegistration = class(TAdvancedForm)
    pnlPrevNextClose: TPanel;
    btnClose: TButton;
    PageControl: TPageControl;
    PgContact: TTabSheet;
    PgWorkInfo: TTabSheet;
    PgRegister: TTabSheet;
    lblContactInfo: TLabel;
    lblCompany: TLabel;
    edtCompany: TEdit;
    lblAddress: TLabel;
    edtAddress: TEdit;
    lblCity: TLabel;
    edtCity: TEdit;
    lblState: TLabel;
    edtState: TEdit;
    lblZip: TLabel;
    edtZip: TEdit;
    lblPhone: TLabel;
    edtPhone: TEdit;
    lblFax: TLabel;
    edtFax: TEdit;
    lblEMail: TLabel;
    edtEMail: TEdit;
    edtLicName: TEdit;
    lblEnterPrintName: TLabel;
    edtSerial1: TEdit;
    edtSerial2: TEdit;
    edtSerial3: TEdit;
    edtSerial4: TEdit;
    lblSerialN: TLabel;
    edtCertNo1: TEdit;
    edtLicNo1: TEdit;
    edtCertSt1: TEdit;
    edtLicSt1: TEdit;
    edtCertExp1: TEdit;
    edtLicExp1: TEdit;
    lblCertExp1: TLabel;
    lblLicExp1: TLabel;
    lblLicSt1: TLabel;
    edtCellPhone: TEdit;
    lblCellPhone: TLabel;
    lblPager: TLabel;
    edtPager: TEdit;
    lblCertNo1: TLabel;
    lblLicNo1: TLabel;
    rbtnUseCert: TRadioButton;
    rbtnUseLic: TRadioButton;
    lblLicName: TLabel;
    lblLicCoName: TLabel;
    edtLicCoName: TEdit;
    lblCountry: TLabel;
    lblLicSt2: TLabel;
    edtLicSt2: TEdit;
    lblLicNo2: TLabel;
    edtLicNo2: TEdit;
    lblLicExp2: TLabel;
    edtLicExp2: TEdit;
    lblLicSt3: TLabel;
    lblLicNo3: TLabel;
    lblLicExp3: TLabel;
    edtLicSt3: TEdit;
    edtLicNo3: TEdit;
    edtLicExp3: TEdit;
    lblCertSt1: TLabel;
    lblCertSt2: TLabel;
    lblCertSt3: TLabel;
    edtCertSt2: TEdit;
    edtCertSt3: TEdit;
    lblCertNo2: TLabel;
    lblCertNo3: TLabel;
    edtCertNo2: TEdit;
    edtCertNo3: TEdit;
    edtCertExp2: TEdit;
    edtCertExp3: TEdit;
    lblCertExp2: TLabel;
    lblCertExp3: TLabel;
    cbxCountry: TComboBox;
    edtRegN: TEdit;
    btnPrev: TButton;
    btnNext: TButton;
    PgValidate: TTabSheet;
    PgFinished: TTabSheet;
    lblEnterLicCert: TLabel;
    btnPrint: TButton;
    lblPrintRegInfo: TLabel;
    FinishedNote: TLabel;
    FinishedMsg: TLabel;
    HTTP: TIdHTTP;
    SMTPMailer: TIdSMTP;
    EmailMsg: TIdMessage;
    ProductGrid: TtsGrid;
    ExpireMsg: TLabel;
    PgUserList: TTabSheet;
    lblSelectUser: TLabel;
    UserRegList: TStringGrid;
    lblRegN: TLabel;
    PgGetCodes: TTabSheet;
    rdoOnLine: TRadioButton;
    rdoFax: TRadioButton;
    btnFax: TBitBtn;
    btnOnLine: TBitBtn;
    btnPhone: TBitBtn;
    CSNComment: TLabel;
    lblGetCodes: TLabel;
    Button1: TButton;
    rdoSkip: TRadioButton;
    lblEnterUnlockCodes: TLabel;
    lblSameRegInfo: TLabel;
    PgAWLogin: TTabSheet;
    lblFirstName: TLabel;
    edtFirstName: TEdit;
    lblLastName: TLabel;
    edtLastName: TEdit;
    PgOrderNotice: TTabSheet;
    lblEnterAWLogin: TLabel;
    lblAWLogin: TLabel;
    edtAWLogin: TEdit;
    //lblAWPassword: TLabel;
    edtAWPassword: TEdit;
    lblRcvNotices: TLabel;
    lblNoticesByTextMsg: TLabel;
    edtTxMsgOrder: TEdit;
    lblNoticesByEmail: TLabel;
    edtEmailOrder: TEdit;
    lblForgotPassword: TRzURLLabel;
    cbSaveAWLogin: TCheckBox;
    procedure btnCloseClick(Sender: TObject);
    procedure InfoChanged(Sender: TObject);
    procedure LicNameChange(Sender: TObject);
//    procedure btnOKClick(Sender: TObject);
    procedure SelectLicTypeClick(Sender: TObject);
    procedure UppercaseKeys(Sender: TObject; var Key: Char);
    procedure RegNChange(Sender: TObject);
    procedure RegInfoChanged(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtSerial1Change(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure edtSerial1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtSerial2KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtSerial3KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtSerial4KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnNextClick(Sender: TObject);
    procedure btnPrevClick(Sender: TObject);
    procedure rdoOnLineClick(Sender: TObject);
    procedure rdoFaxClick(Sender: TObject);
    procedure PgValidateShow(Sender: TObject);
    procedure btnPhoneClick(Sender: TObject);
    procedure btnFaxClick(Sender: TObject);
    procedure btnOnLineClick(Sender: TObject);
    procedure ProductGridCellEdit(Sender: TObject; DataCol,
      DataRow: Integer; ByUser: Boolean);
    procedure UserRegListDblClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure PgValidateHide(Sender: TObject);
    procedure rdoSkipClick(Sender: TObject);
    procedure PgGetCodesShow(Sender: TObject);
    procedure PgRegisterEnter(Sender: TObject);
	private
		FCurUser: TLicensedUser;   //either CurrentUser or Temp
    FFirstPage: TTabSheet;
    FChanged: Boolean;
    FRegApplied: Boolean;
    FLockInCo: Boolean;
    FRegistered: Boolean;
    FNoOnLine: Boolean;
    FShowMsg: Boolean;
    FUserIsSubcriber: Boolean;     //(T/F) if subscriber
    FValidSubscription: Boolean;   //(T/F) if subscription valid
    FServerDate: TDateTime;        //server date returned by registration
    FUserIsAWMember: Boolean;
    function NoData(Str: String): Boolean;
    function SumStr(S: String): LongInt;
    function GetRegistrationStr: String;
    function GetWorkLicCount: Integer;
    procedure SetBackDoorUnLockingKeys;
    function ValidateCSN(var noCSN: Boolean): Boolean;
    function ValidUserSelected: Boolean;
    function ValidatedContactInfo: Boolean;
    function ValidatedAWLogin: Boolean;
    function ValidateAppraisalInfo: Boolean;
    function ValidatedRegisterInfo: Boolean;
    function ValidateSWUsage: Boolean;
    function UserLicStatusMsg: Boolean;
    function HasUnlockCodes: Boolean;
    function DisplayRegistrationForm: TObject;
    function CreateAWSIRegResponse(expDate: TDateTime): TStringList;
	public
    constructor CreateRegistar(AOwner: TComponent; User: TLicensedUser);
    destructor Destroy; override;
    procedure LoadAllLicensedUsers;
    procedure LoadLicensedUser(User: TLicensedUser);
    procedure SaveLicenseInfoToUser(User: TLicensedUser);
    procedure SaveCurUserChanges;
    procedure PrintRegInfo(faxIt: Boolean);
    function SWRegDetailsForEmail(var CustIDStr, fromEAddr: String): TStrings;
    function SWRegDetailsForHTTP(var CustIDStr, fromEAddr: String): String;
    function ApplyRegistrationResults(rspStrings: TStrings): Boolean;
    //function ApplyAWRegistrationResults(AUserName, APassword: String; Silent: Boolean=False): Boolean;
    function SendOnLine: Boolean;
    function SendByEmail: Boolean;
    procedure SendEMailOldWay;
    function SendByFax: Boolean;
    procedure SendByPhone;
	end;


  //routine to call registration
  function RegisterClickFORMS(User: TLicensedUser): Boolean;

var
	Registration: TRegistration;


implementation

{$R *.DFM}

Uses
  ULicUtility2, ULicProd, ULicSerial, USend, UWinUtils,
	UStatus, UMain, UContainer, UForm, ULicUtility, UUtil1, UUtil2, UStrings,
  USendFax, UMail, UWebConfig, UWebUtils, ULicEval, {ULicAreaSketch,} UWelcome3, USysInfo,
  UUtil3, UAWSI_Utils, AWSI_Server_Clickforms;

const
  ClkSWRegForm  = 282;


  msgNeedLicName    = 'The users license name is missing. Please enter it.';
  msgNeedLicCoName  = 'A company name is required. Please enter it.';
  msgNoEmail        = 'Your email address is missing. Please enter it.';
  msgNoContact      = 'Some or all of your contact information is missing. Please enter it.';
  msgNoCSN          = 'You have not entered your Customer Serial Number.';
  msgLocateCSN      = '   NOTE: Your unique Customer Serial Number can be found on the product invoice.';
  msgCSNNotValid    = 'The Customer Serial Number is not valid. Please enter a valid CSN.';
  msgValidLic       = 'The new ClickFORMS License has been validated for use by %s. Thank you for using ClickFORMS.';
  msgNotValidLic    = 'The ClickFORMS License could not be validated for %s. Please ensure all the registration information and unlocking codes have been entered and are correct.';
  msgSWRegOK        = 'ClickFORMS has been successfully registered and unlocked.';
  msgSWRegNotOK     = 'ClickFORMS has not been unlocked';
  msgAWLoginNotValid = 'The AppraisalWorld Login Name and Password cannot be verified. Please check the name and password and try again.';
  msgAWLoginName    = 'A Login Name is required. Please enter it.';
  msgAWPassword     = 'A Password is required. Please enter it.';

  nextDirection     = 'Next >>>';
  prevDirection     = '<<< Previous';



{Function for displaying ClickForms Registration}

function RegisterClickFORMS(User: TLicensedUser): Boolean;
var
  UserReg: TRegistration;
  SelectMode: TSelectWorkMode3;
begin
  result := False;
  SelectMode := nil;
  UserReg := nil;

  try
    SelectMode := TSelectWorkMode3.Create(TRUE);     //PassThru = True
    UserReg := TRegistration.CreateRegistar(nil, User);

    if ISStudentVersion then
    begin
      SelectMode.SetupMsg(CurrentUser.GreetingName);
      result := SelectMode.ShowModal = mrOK;
    end else begin
      UserReg.ShowModal;                        //handles the saves internally
      LicensedUsers.GatherUserLicFiles;         //changes were made, so update

      if assigned(User) then
        result := User.OK2UseClickForms;        //registered OK
    end;
  finally
    SelectMode.Free;
    UserReg.Free;
  end;
end;

{TRegistration}

constructor TRegistration.CreateRegistar(AOwner: TComponent; User: TLicensedUser);
begin
  inherited Create(AOwner);

  FNoOnLine := False;
  FChanged := False;
  FRegApplied := False;
  FLockInCo := False;
  FRegistered := False;
  FShowMsg := False;
  FUserIsAwMember := false;

  //default subscription flags
  FUserIsSubcriber := False;         //assume not on subscription
  FValidSubscription := False;
  FServerDate := defaultDate;


  FCurUser := nil;                        //no one selected yet

  //Note: if they just started evaluating, there is no user file yet, so user count could be 0
  if assigned(User) or (LicensedUsers.count <=1) then   //register this person
    begin
      PageControl.Activepage := PgContact;
      FFirstPage := PgContact;
      if not assigned(User) then
        LoadLicensedUser(CurrentUser)   //if only one, its current user
      else
        LoadLicensedUser(User);

      //should CoName be locked for this person?
//      edtCompany.ReadOnly := CurrentUser.SWLicenseCoNameLocked;
//      edtLicCoName.ReadOnly := CurrentUser.SWLicenseCoNameLocked;
    end
  else  //let user select licensee to be registered
    begin
      PageControl.Activepage := PgUserList;
      LoadAllLicensedUsers;
      FFirstPage := PgUserList;

      //company name field is locked when more than one user
//      edtCompany.ReadOnly := CurrentUser.SWLicenseCoNameLocked;
//      edtLicCoName.ReadOnly := CurrentUser.SWLicenseCoNameLocked;
    end;

  btnPrev.Enabled := False;
  CSNComment.Visible := False;

  FinishedMsg.Caption :=   msgSWRegNotOK;
end;

destructor TRegistration.Destroy;
begin
  if assigned(FCurUser) and (FCurUser <> CurrentUser) then
    FreeAndNil(FCurUser);

  inherited;
end;

procedure TRegistration.LoadAllLicensedUsers;
var
  i: Integer;
begin
  UserRegList.RowCount := LicensedUsers.Count+1;
  UserRegList.Cells[0,0] := 'User Name';
  UserRegList.Cells[1,0] := 'License File Name';

  for i := 1 to LicensedUsers.count do
    begin
      UserRegList.Cells[0,i] := TUser(LicensedUsers[i-1]).FLicName;
      UserRegList.Cells[1,i] := TUser(LicensedUsers[i-1]).FFileName;
    end;
end;

procedure TRegistration.SaveCurUserChanges;
begin
  if FChanged then
    if OK2Continue(Format(msgWant2SaveRegInfoB, [edtLicName.text])) then
      if assigned(FCurUser) then
        begin
          SaveLicenseInfoToUser(FCurUser);
          FCurUser.SaveUserLicFile;
        end;
end;

procedure TRegistration.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  UserFileName: String;
begin
  SaveCurUserChanges;
  UserFileName := CurrentUser.UserFileName;
  CurrentUser.Clear;
  CurrentUser.LoadUserLicFile(UserFileName);
  CanClose := True;
end;

//Clicked Close button
procedure TRegistration.btnCloseClick(Sender: TObject);
begin
  Close;
end;

//Clicked on Get Unlock Codes- Registration
procedure TRegistration.btnPrintClick(Sender: TObject);
begin
  PrintRegInfo(False);
end;

//any time text is edited, this called
procedure TRegistration.InfoChanged(Sender: TObject);
begin
  FChanged := True;
end;

procedure TRegistration.RegInfoChanged(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  FChanged := True;
end;

procedure TRegistration.ProductGridCellEdit(Sender: TObject; DataCol,
  DataRow: Integer; ByUser: Boolean);
begin
  FChanged := True;
  FShowMsg := False;
  FRegApplied := True;    //manually entered codes
end;

//As we type the user name & co, update the registration number
procedure TRegistration.LicNameChange(Sender: TObject);
begin
  edtRegN.Text := GetRegistrationStr;
end;

procedure TRegistration.RegNChange(Sender: TObject);
begin
//do nothing
end;

procedure TRegistration.edtSerial1Change(Sender: TObject);
begin
{ FLockInCo is set by online registration data}
{  FLockInCo := IsPartOfUserGroup(edtSerial1.Text);  }
  edtRegN.Text := GetRegistrationStr;
end;

procedure TRegistration.edtSerial1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Length(edtSerial1.Text) = 5 then
    activeControl := edtSerial2;
end;

procedure TRegistration.edtSerial2KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Length(edtSerial2.Text) = 5 then
    activeControl := edtSerial3;
end;

procedure TRegistration.edtSerial3KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Length(edtSerial3.Text) = 5 then
    activeControl := edtSerial4;
end;

procedure TRegistration.edtSerial4KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//  disabled edtRegN, so cannot focus on it
//  if Length(edtSerial4.Text) = 5 then
//    activeControl := edtRegN;
end;

procedure TRegistration.UppercaseKeys(Sender: TObject; var Key: Char);
begin
  if key in ['a'..'z'] then
    key := char(ord(key) - 32);
end;

//This function is duplicated in TLicensedUser.LicInfo
function TRegistration.SumStr(S: String): LongInt;
var
  Sum: LongInt;
  i: Integer;
begin
  Sum := 0;
  S := UpperCase(S);
  for i := 1 to length(S) do
    if S[i] in ['0'..'9', 'A'..'Z'] then
      Sum := Sum + Ord(S[i]);
  result := Sum;
end;

//calcs the user registration number
//This is duplicated in TLicensedUser.LicInifo
function TRegistration.GetRegistrationStr: String;
var
  regKey: LongInt;
begin
  regKey := SumStr(edtLicName.text) * 4713;        //4713 & 3219 are just random numbers
  if FLockInCo then
    regKey := regKey + SumStr(edtLicCoName.text) * 3219;

  result := IntToStr(regKey);
end;

procedure TRegistration.SetBackDoorUnLockingKeys;
var
  i: Integer;
begin
  ProductGrid.Rows := InstalledProducts.Count;
  with ProductGrid do
    for i := 1 to InstalledProducts.count do
      if length(edtRegN.Text)> 0 then
        begin
          Cell[3,i] := TProduct(InstalledProducts[i-1]).CalcUnlockKey(StrToInt(edtRegN.Text));
        end;
  FChanged := True;
end;

//hack to get count of number of work licenses
function TRegistration.GetWorkLicCount: Integer;
var
  i,j,k: Integer;
begin
  if rbtnUseCert.Checked then
    begin
      i := ord((length(edtCertSt1.text)>0) or
               (length(edtCertNo1.text)>0) or
               (length(edtCertExp1.text)>0));
      j := ord((length(edtCertSt2.text)>0) or
               (length(edtCertNo2.text)>0) or
               (length(edtCertExp2.text)>0));
      k := ord((length(edtCertSt3.text)>0) or
               (length(edtCertNo3.text)>0) or
               (length(edtCertExp3.text)>0));
    end
  else
    begin
      i := ord((length(edtLicSt1.text)>0) or
               (length(edtLicNo1.text)>0) or
               (length(edtLicExp1.text)>0));
      j := ord((length(edtLicSt2.text)>0) or
               (length(edtLicNo2.text)>0) or
               (length(edtLicExp2.text)>0));
      k := ord((length(edtLicSt3.text)>0) or
               (length(edtLicNo3.text)>0) or
               (length(edtLicExp3.text)>0));
    end;
  result := i+ j+ k;
end;

procedure TRegistration.LoadLicensedUser(User: TLicensedUser);
var
  i: Integer;
begin
  FCurUser := User;   //rember who we are working with

  with User do
    begin
      //load in the contact info
      if Trim(UserInfo.FirstName) = '' then
        begin
          edtFirstName.text := GetNamePart(UserInfo.Name, 1);
          edtLastName.text  := GetNamePart(UserInfo.Name, 2);
        end
      else
        begin
          edtFirstName.text := UserInfo.FirstName;
          edtLastName.text  := UserInfo.LastName;
        end;
      edtCompany.text := UserInfo.Company;
      edtAddress.text := UserInfo.Address;
      edtCity.text    := UserInfo.City;
      edtState.text   := UserInfo.State;
      edtZip.text     := UserInfo.Zip;
      cbxCountry.text := UserInfo.Country;
      edtPhone.text   := UserInfo.Phone;
      edtFax.text     := UserInfo.Fax;
      edtCellPhone.text := UserInfo.Cell;
      edtPager.text   := UserInfo.Pager;
      edtEMail.text   := UserInfo.Email;

      cbxCountry.ItemIndex := 0;

      //AW Credentials
      edtAWLogin.Text    := AWUserInfo.FLoginName;
      edtAWPassword.Text := AWUserInfo.FPassword;
      edtTxMsgOrder.text := AWUserInfo.FTxMsgOrder;
      edtEmailOrder.text := AWUserInfo.FEmailOrder;

      //load in the uer's Work Lic info
      if WorkLic.LicenseType = cCertType then
        begin
          rbtnUseCert.Checked := True;

          if WorkLic.Count > 0 then begin
            edtCertSt1.text   := WorkLic.License[0].State;
            edtCertNo1.text   := WorkLic.License[0].Number;
            edtCertExp1.text  := WorkLic.License[0].ExpDate;
          end;
          if WorkLic.Count > 1 then begin
            edtCertSt2.text   := WorkLic.License[1].State;
            edtCertNo2.text   := WorkLic.License[1].Number;
            edtCertExp2.text  := WorkLic.License[1].ExpDate;
          end;
          if WorkLic.Count > 2 then begin
            edtCertSt3.text   := WorkLic.License[2].State;
            edtCertNo3.text   := WorkLic.License[2].Number;
            edtCertExp3.text  := WorkLic.License[2].ExpDate;
          end;
        end
      else if WorkLic.LicenseType = cLicType then
        begin
          rbtnUseLic.checked := True;

          if WorkLic.Count > 0 then begin
            edtLicSt1.text   := WorkLic.License[0].State;
            edtLicNo1.text   := WorkLic.License[0].Number;
            edtLicExp1.text  := WorkLic.License[0].ExpDate;
          end;
          if WorkLic.Count > 1 then begin
            edtLicSt2.text   := WorkLic.License[1].State;
            edtLicNo2.text   := WorkLic.License[1].Number;
            edtLicExp2.text  := WorkLic.License[1].ExpDate;
          end;
          if WorkLic.Count > 2 then begin
            edtLicSt3.text   := WorkLic.License[2].State;
            edtLicNo3.text   := WorkLic.License[2].Number;
            edtLicExp3.text  := WorkLic.License[2].ExpDate;
          end;
        end;

      //load in the user registration info
      //special order so Reg No is auto calculated
      with LicInfo do
        begin
          FLockInCo := FLicLockedCo;           //Set this
          edtSerial1.text := FSerialNo1;       //customer serial# has flag for LockCo
          edtLicName.text := FLicName;         //Users name on the form
          edtLicCoName.text := FLicCoName;     //users company name on the form
          edtSerial2.text := FSerialNo2;
          edtSerial3.text := FSerialNo3;
          edtSerial4.text := FSerialNo4;
//          edtRegN.Text := UserRegNo;          //registration number

          FUserIsSubcriber := IsSubscriber;       //(T/F) if they are a subcriber
          FValidSubscription := OnSubscription;   //(T/F) if subscription valid
          FServerDate := LastStatusCheck;         //last date subscription checked
        end;

      //load in the Product Licenses & unlocking codes
      ProductGrid.Rows := LicInfo.ProdLicenses.Count;
      with ProductGrid do
        for i := 1 to LicInfo.ProdLicenses.count do
          begin
            Cell[1,i] := TProdLic(LicInfo.ProdLicenses.Items[i-1]).PName;
            Cell[2,i] := TProdLic(LicInfo.ProdLicenses.Items[i-1]).PVersion;
            Cell[3,i] := '';  //TProdLic(LicInfo.ProdLicenses.Items[i-1]).PUnlockCode;
            Cell[4,i] := '';  //TProdLic(LicInfo.ProdLicenses.Items[i-1]).PExpires;
          end;
    end;
end;

procedure TRegistration.SaveLicenseInfoToUser(User: TLicensedUser);
var
  i, wrkLicCount: Integer;
begin
  with User do
    begin
      Modified := FChanged;  //tell the User its info has changed

    //save the user info
      UserInfo.Name    := edtFirstName.text + ' ' + edtLastName.Text;
      UserInfo.FirstName := edtFirstName.text;
      UserInfo.LastName := edtLastName.text;
      UserInfo.Company := edtCompany.text;
      UserInfo.Address := edtAddress.text;
      UserInfo.City    := edtCity.text;
      UserInfo.State   := edtState.text;
      UserInfo.Zip     := edtZip.text;
      UserInfo.Country := cbxCountry.text;
      UserInfo.Phone   := edtPhone.text;
      UserInfo.Fax     := edtFax.text;
      UserInfo.Cell    := edtCellPhone.text;
      UserInfo.Pager   := edtPager.text;
      UserInfo.Email   := edtEMail.text;

      //AW Credentials
     // AWUserInfo.FLoginName   := Trim(edtAWLogin.Text);     //we already  save them in ValidateAWLogin
      //AWUserInfo.FPassword    := Trim(edtAWPassword.Text);  //we already  save them in ValidateAWLogin
      //AWUserInfo.FTxMsgOrder  := Trim(edtTxMsgOrder.text);  //never used
      //AWUserInfo.FEmailOrder  := Trim(edtEmailOrder.text);  //never used

    //save the working license count
      wrkLicCount := GetWorkLicCount;          //how many licenses do we have
      WorkLic.Count := wrkLicCount;

      if rbtnUseCert.Checked then
        begin
          WorkLic.LicenseType := cCertType;

          if WorkLic.Count > 0 then begin
            WorkLic.FLicenses[0].State := edtCertSt1.text;
            WorkLic.FLicenses[0].Number := edtCertNo1.text;
            WorkLic.FLicenses[0].ExpDate := edtCertExp1.text;
          end;
          if WorkLic.Count > 1 then begin
            WorkLic.FLicenses[1].State := edtCertSt2.text;
            WorkLic.FLicenses[1].Number := edtCertNo2.text;
            WorkLic.FLicenses[1].ExpDate := edtCertExp2.text;
          end;
          if WorkLic.Count > 2 then begin
            WorkLic.FLicenses[2].State := edtCertSt3.text;
            WorkLic.FLicenses[2].Number := edtCertNo3.text;
            WorkLic.FLicenses[2].ExpDate := edtCertExp3.text;
          end;
        end
      else if rbtnUseLic.checked then
        begin
           WorkLic.LicenseType := cLicType;

          if WorkLic.Count > 0 then begin
            WorkLic.FLicenses[0].State := edtLicSt1.text;
            WorkLic.FLicenses[0].Number := edtLicNo1.text;
            WorkLic.FLicenses[0].ExpDate := edtLicExp1.text;
          end;
          if WorkLic.Count > 1 then begin
            WorkLic.FLicenses[1].State := edtLicSt2.text;
            WorkLic.FLicenses[1].Number := edtLicNo2.text;
            WorkLic.FLicenses[1].ExpDate := edtLicExp2.text;
          end;
          if WorkLic.Count > 2 then begin
            WorkLic.FLicenses[2].State := edtLicSt3.text;
            WorkLic.FLicenses[2].Number := edtLicNo3.text;
            WorkLic.FLicenses[2].ExpDate := edtLicExp3.text;
          end;
        end;

    //save the registration info
      with LicInfo do
        begin
          FLicName := edtLicName.text;         //Users name on the form
          FLicCoName := edtLicCoName.text;     //users company name on the form
          FLicLockedCo:= FLockInCo;            //is the company name locked
          FSerialNo1 := edtSerial1.text;       //customer number in DB
          FSerialNo2 := edtSerial2.text;       //three part serial number
          FSerialNo3 := edtSerial3.text;
          FSerialNo4 := edtSerial4.text;
          UserRegNo := edtRegN.text;

          IsSubscriber := FUserIsSubcriber;       //(T/F) if they are a subcriber
          OnSubscription := FValidSubscription;   //(T/F) if subscription valid
          LastStatusCheck := FServerDate;         //last date subscription checked
        end;

      //save the unlocking Codes
        if FRegApplied then  //only remember codes if they have changed
          with ProductGrid do
            for i := 1 to Rows do
              begin
                TProdLic(LicInfo.ProdLicenses.Items[i-1]).PUnlockCode := Cell[3,i];
                TProdLic(LicInfo.ProdLicenses.Items[i-1]).PExpires := Cell[4,i];
              end;
(*
        //save Subscription flag only if license valid
        if OK2UseClickForms then
          with LicInfo do
            begin
              extra[1] := FUserIsSubcriber;
              extra[2] := 0;    //some beta testers for 5.0 had dates in here
              extra[3] := 0;    //remove for version 5.5
            end;
*)
    end; //with CurrentUser
end;

//specificly for appraisal licenses
procedure TRegistration.SelectLicTypeClick(Sender: TObject);
var
  UseLic, UseCert: Boolean;
begin
  UseLic := rbtnUseLic.checked;
  UseCert := not useLic;

//set the cert fields
  lblCertSt1.enabled := UseCert;
  lblCertSt2.enabled := UseCert;
  lblCertSt3.enabled := UseCert;
  lblCertNo1.enabled := UseCert;
  lblCertNo2.enabled := UseCert;
  lblCertNo3.enabled := UseCert;
  lblCertExp1.enabled := UseCert;
  lblCertExp2.enabled := UseCert;
  lblCertExp3.enabled := UseCert;
  edtCertSt1.enabled := UseCert;
  edtCertSt2.enabled := UseCert;
  edtCertSt3.enabled := UseCert;
  edtCertNo1.enabled := UseCert;
  edtCertNo2.enabled := UseCert;
  edtCertNo3.enabled := UseCert;
  edtCertExp1.enabled := UseCert;
  edtCertExp2.enabled := UseCert;
  edtCertExp3.enabled := UseCert;

//set the lic fields
  lblLicSt1.Enabled := UseLic;
  lblLicSt2.Enabled := UseLic;
  lblLicSt3.Enabled := UseLic;
  lblLicNo1.Enabled := UseLic;
  lblLicNo2.Enabled := UseLic;
  lblLicNo3.Enabled := UseLic;
  lblLicExp1.Enabled := UseLic;
  lblLicExp2.Enabled := UseLic;
  lblLicExp3.Enabled := UseLic;
  edtLicSt1.Enabled := UseLic;
  edtLicSt2.Enabled := UseLic;
  edtLicSt3.Enabled := UseLic;
  edtLicNo1.Enabled := UseLic;
  edtLicNo2.Enabled := UseLic;
  edtLicNo3.Enabled := UseLic;
  edtLicExp1.Enabled := UseLic;
  edtLicExp2.Enabled := UseLic;
  edtLicExp3.Enabled := UseLic;
end;

function TRegistration.DisplayRegistrationForm: TObject;
var
  doc: TContainer;
  form: TDocForm;
  i,c: integer;
begin
  doc := Main.NewEmptyDoc;
  try
    form := doc.GetFormByOccurance(ClkSWRegForm, 0, True);
    if assigned(form) then     //make sure we have a form
      begin
        //contact info
        form.SetCellText(1, 1, edtFirstName.text + ' ' + edtLastName.text);
        form.SetCellText(1, 2, edtCompany.text);
        form.SetCellText(1, 3, edtAddress.text);
        form.SetCellText(1, 4, edtCity.text);
        form.SetCellText(1, 5, edtState.text);
        form.SetCellText(1, 6, edtZip.text);
        form.SetCellText(1, 7, cbxCountry.text);
        form.SetCellText(1, 8, edtPhone.text);
        form.SetCellText(1, 9, edtFax.text);
        form.SetCellText(1, 10, edtCellPhone.text);
        form.SetCellText(1, 11, edtPager.text);
        form.SetCellText(1, 12, edtEMail.text);

        //registration info
        form.SetCellText(1, 13, edtLicName.text);
        form.SetCellText(1, 14, edtLicCoName.text);
        form.SetCellText(1, 15, edtSerial1.text);
        form.SetCellText(1, 16, edtSerial2.text);
        form.SetCellText(1, 17, edtSerial3.text);
        form.SetCellText(1, 18, edtSerial4.text);
        form.SetCellText(1, 19, edtRegN.text);

        //product unlocking codes
        i := 1;
        c := 20;
        try
          if ProductGrid.Rows > 0 then
            with ProductGrid do
              repeat
                form.SetCellText(1, c, Cell[1,i]);
                form.SetCellText(1, c+1, Cell[2,i]);
                form.SetCellText(1, c+2, Cell[3,i]);
                form.SetCellText(1, c+3, Cell[4,i]);
                inc(i);
                inc(c,4);
              until (i>ProductGrid.Rows) or (i>20);
              // 050511 JWyatt Increase allowable count to 20 to match max form rows
        except
          ShowNotice('There was a problem displaying the product information. Please check your unlocking codes.');
        end;
      end;
  except
    ShowNotice('There is a problem displaying the registration information. Please make sure the Software Registration form is available.');
    if assigned(doc) then
      FreeAndNil(doc);
  end;
  result := doc;
end;

procedure TRegistration.PrintRegInfo(faxIt: Boolean);
var
  doc: TContainer;
begin
  doc := TContainer(DisplayRegistrationForm);
  if assigned(doc) then
    if faxIt then
      SendContainer(doc, cmdFileSendFAX)
    else
      doc.PrintReport;
end;

function TRegistration.SWRegDetailsForHTTP(var CustIDStr, fromEAddr: String): String;
var
  custID: Integer;
  info, iStr, pidStr: String;
  i: Integer;
  noCSN: Boolean;
begin
  //try to get customer ID
  custID := 0;
  custIDStr := '';
  if ValidateCSN(noCSN) then
    custID := ExtractCustomerID(edtSerial1.text, edtSerial2.text, edtSerial3.text, edtSerial4.text);
  if custID > 0 then custIDStr := IntToStr(custID);

  fromEAddr := edtEMail.text;     //return this separately

  Info := 'EmailRegVersion=1';
  Info := Info + '&'+ 'CustomerID='+ custIDStr;
  Info := Info + '&'+ 'Name='+ URLEncode(edtFirstName.text + ' ' + edtLastName.text);
  Info := Info + '&'+ 'Company='+ URLEncode(edtCompany.text);
  Info := Info + '&'+ 'Address='+ URLEncode(edtAddress.text);
  Info := Info + '&'+ 'City='+ URLEncode(edtCity.text);
  Info := Info + '&'+ 'State='+ URLEncode(edtState.text);
  Info := Info + '&'+ 'Zip='+ URLEncode(edtZip.text);
  Info := Info + '&'+ 'Country='+ URLEncode(cbxCountry.text);
  Info := Info + '&'+ 'Phone='+ URLEncode(edtPhone.text);
  Info := Info + '&'+ 'Fax='+ URLEncode(edtFax.text);
  Info := Info + '&'+ 'Cell='+ URLEncode(edtCellPhone.text);
  Info := Info + '&'+ 'Pager='+ URLEncode(edtPager.text);
  Info := Info + '&'+ 'EMail='+ URLEncode(edtEMail.text);
  //registration info
  Info := Info + '&'+ 'LicName='+ URLEncode(edtLicName.text);
  Info := Info + '&'+ 'LicCompany='+ URLEncode(edtLicCoName.text);
  Info := Info + '&'+ 'Serial1='+ URLEncode(edtSerial1.text);
  Info := Info + '&'+ 'Serial2='+ URLEncode(edtSerial2.text);
  Info := Info + '&'+ 'Serial3='+ URLEncode(edtSerial3.text);
  Info := Info + '&'+ 'Serial4='+ URLEncode(edtSerial4.text);
  Info := Info + '&'+ 'RegNumber='+ URLEncode(edtRegN.text);
  Info := Info + '&'+ 'CFVersion='+ URLEncode(SysInfo.UserAppVersion);
  Info := Info + '&'+ 'ServiceID='+ URLEncode(IntToStr(ClickFormsSubscriptionSID));

  //count of products installed
  Info := Info + '&'+ 'ProductCount='+ IntToStr(ProductGrid.Rows);

  //Installed products & unlocking codes
  i := 1;
  if ProductGrid.Rows > 0 then
    with ProductGrid do
      repeat
        iStr := IntToStr(i);
        pidStr := IntToStr(TProdLic(FCurUser.LicInfo.ProdLicenses.Items[i-1]).FProdID);
        Info := Info + '&'+ 'Product'+iStr+'_PID='+ pidStr;
        Info := Info + '&'+ 'Product'+iStr+'_Name='+ URLEncode(Cell[1,i]);        //product name
        Info := Info + '&'+ 'Product'+iStr+'_Version='+ URLEncode(Cell[2,i]);     //product version
        Info := Info + '&'+ 'Product'+iStr+'_Unlocking='+ Cell[3,i];              //prodcut unlocking
        Info := Info + '&'+ 'Product'+iStr+'_Expires='+ URLEncode(Cell[4,i]);     //expiration
        inc(i);
      until (i>ProductGrid.Rows);// or (i>10);

  //return the results
  result := info;
end;

function TRegistration.SWRegDetailsForEmail(var CustIDStr, fromEAddr: String): TStrings;
var
  info: TStringList;
  custID: Integer;
  iStr, pidStr,relStr: String;
  i: Integer;
  noCSN: Boolean;
begin
  //try to get customer ID
  custID := 0;
  custIDStr := '';
  if ValidateCSN(noCSN) then
    custID := ExtractCustomerID(edtSerial1.text, edtSerial2.text, edtSerial3.text, edtSerial4.text);
  if custID > 0 then custIDStr := IntToStr(custID);

  fromEAddr := edtEMail.text;     //return this separately

  //gather the info
  Info := TStringList.create;

  Info.Add('EmailRegVersion=1');
  Info.Add('CustomerID='+ custIDStr);
  Info.Add('Name='+ edtFirstName.text + ' ' + edtLastName.text);
  Info.Add('Company='+ edtCompany.text);
  Info.Add('Address='+ edtAddress.text);
  Info.Add('City='+ edtCity.text);
  Info.Add('State='+ edtState.text);
  Info.Add('Zip='+ edtZip.text);
  Info.Add('Country='+ cbxCountry.text);
  Info.Add('Phone='+ edtPhone.text);
  Info.Add('Fax='+ edtFax.text);
  Info.Add('Cell='+ edtCellPhone.text);
  Info.Add('Pager='+ edtPager.text);
  Info.Add('EMail='+ edtEMail.text);

  //registration info
  Info.Add('LicName='+ edtLicName.text);
  Info.Add('LicCompany='+ edtLicCoName.text);
  Info.Add('Serial1='+ edtSerial1.text);
  Info.Add('Serial2='+ edtSerial2.text);
  Info.Add('Serial3='+ edtSerial3.text);
  Info.Add('Serial4='+ edtSerial4.text);
  Info.Add('RegNumber='+ edtRegN.text);

  //count of products installed
  Info.Add('ProductCount='+ IntToStr(ProductGrid.Rows));

  //Installed products & unlocking codes
  i := 1;
  if ProductGrid.Rows > 0 then
    with ProductGrid do
      repeat
        iStr := IntToStr(i);
        pidStr := IntToStr(TProdLic(FCurUser.LicInfo.ProdLicenses.Items[i-1]).FProdID);
        relStr := IntToStr(TProdLic(FCurUser.LicInfo.ProdLicenses.Items[i-1]).FProdRelease);
        Info.Add('Product'+iStr+'_PID='+ pidStr);            //product type identifier
        Info.Add('Product'+iStr+'_Rel='+ relStr);            //product release no.
        Info.Add('Product'+iStr+'_Name='+ Cell[1,i]);        //product name
        Info.Add('Product'+iStr+'_Version='+ Cell[2,i]);     //product version
        Info.Add('Product'+iStr+'_Unlocking='+ Cell[3,i]);   //prodcut unlocking
        Info.Add('Product'+iStr+'_Expires='+ Cell[4,i]);     //expiration
        inc(i);
      until (i>ProductGrid.Rows) or (i>10);

  //return the results
  result := info;
end;

function TRegistration.ApplyRegistrationResults(rspStrings: TStrings): Boolean;
const
  ourServerDateFormat = 'mm/dd/yyyy';
var
  i,n: Integer;
  nStr, iStr, yesStr, expStr: String;
  Yr, Mo, Dy: Word;
  Product: TProduct;
begin
  result := False;

  //set here and they will be saved with all other data
  FLockInCo := Boolean(StrToIntDef(rspStrings.values['LockCo'],0));
  edtLicName.text := rspStrings.values['LicName'];
  edtLicCoName.text := rspStrings.values['LicCo'];
  edtRegN.Text := GetRegistrationStr;

  //get subscription status and server date
  yesStr := rspStrings.values['IsSubscriber'];
  FUserIsSubcriber := CompareText(yesStr, 'Yes')=0;

  yesStr := rspStrings.values['SubscriptionValid'];
  FValidSubscription := CompareText(yesStr, 'Yes')=0;

  //registration server may have the different date format from that on the local computer
  try
    Mo := StrToInt(Copy(rspStrings.values['ServerDate'], 1, 2));
    Dy := StrToInt(Copy(rspStrings.values['ServerDate'], 4, 2));
    Yr := StrToInt(Copy(rspStrings.values['ServerDate'], 7, 4));
    TryEncodeDate(Yr, Mo, Dy, FServerDate);
  except
    FServerDate := 0;
  end;

  //now set the new product codes
  nStr := rspStrings.values['ProductCount'];
  n := StrToIntDef(nStr, 0);
  for i := 1 to n do
    begin
     try
      iStr := IntToStr(i);
      yesStr := rspStrings.values['Product'+iStr+ '_CanUse'];
      expStr := rspStrings.values['Product'+iStr+ '_Exp'];
      if compareText(yesStr, 'Yes')=0 then
        begin
          Product := InstalledProducts.GetProductByName(ProductGrid.Cell[1,i]);
          if assigned(Product) then
          begin
            ProductGrid.cell[3,i] := Product.CalcUnlockKey(StrToInt(edtRegN.Text));
            ProductGrid.cell[4,i] := expStr;
          end;
        end
      else
        begin
          ProductGrid.cell[3,i] := '';
          ProductGrid.cell[4,i] := expStr;
        end;
      except
      end;
    end;

//  ShowNotice('Lic Name :' + LicName + #10+ #13+ 'Lic Company :' + LicCo + #10+ #13+ 'Lock Company :' + LockCo + #10+ #13);

  FChanged := True;
  ShowNotice('Your new unlocking codes have been retrieved and entered for you.');
  try
    FRegApplied := True;
    FCurUser.ValidateClickFormsUsage;     //set the Lic File Type
    SaveLicenseInfoToUser(FCurUser);
    FCurUser.SaveUserLicFile;
    FChanged := False;
    result := True;
  except
    ShowAlert(atWarnAlert, 'The User License file could not be saved.');
  end;
end;

(* we do not use the function
function TRegistration.ApplyAWRegistrationResults(AUserName, APassword: String; Silent: Boolean=False): Boolean;
const
  ourServerDateFormat = 'mm/dd/yyyy';
var
  AUser: TLicensedUser;
  service : Integer;
  AWResponse: clsGetUsageAvailabilityData;
  AWUseOK: Boolean;
  AWExpDate: TDateTime;
  AWPIDIdx: Integer;
  SvcName: String;
  SvcExpDate: TDateTime;
begin
  result := False;

  AUser := TLicensedUser.Create;
  if GetAppraisalWorldMemberInfo(AUserName, APassword, AUser) then
    begin
      //set here and they will be saved with all other data
      FLockInCo := AUser.SWLicenseCoNameLocked;
      edtLicName.text := AUser.UserInfo.Name;
      edtLicCoName.text := AUser.UserInfo.Company;
      edtRegN.Text := GetRegistrationStr;

      //get subscription status and server date
      FUserIsSubcriber := AUser.LicInfo.IsSubscriber;

      FValidSubscription := AUser.LicInfo.OnSubscription;

      //registration server may have the different date format from that on the local computer
      FServerDate := AUser.LicInfo.LastStatusCheck;

      for AWPIDIdx := 0 to MaxPID do
        begin
          if pidCFRegName[AWPIDIdx] <> '' then
            begin
              AWUseOK := CurrentUser.OK2UseAWProduct(AWPIDIdx, AWResponse, True);
              if AWUseOK and (AWResponse <> nil) then
                begin
                  AWExpDate := StrToDateEx(AWResponse.AppraiserExpirationDate, 'yyyy-mm-dd','-');
                  SvcName := '';
                  SvcExpDate := 0;
                  service := 0;
                  repeat  //cycle through the grid to locate AW & CF name match
                    service := Succ(service);
                    if ProductGrid.Cell[1,service] = pidCFRegName[AWPIDIdx] then
                      begin
                        SvcName := pidCFRegName[AWPIDIdx];
                        if ProductGrid.Cell[4,service] = '' then
                          SvcExpDate := 0
                        else
                          SvcExpDate := StrToDateEx(ProductGrid.Cell[4,service], 'MM/dd/yyyy','/');
                      end;
                  until (SvcName <> '') or (service = ProductGrid.Rows);
                  // If SvcName is blank then it must not be a managed product (i.e. it has no PID)
                  if SvcName <> '' then      //CustDB name is not found - managed by AW
                    begin
                      ProductGrid.Cell[3,service] := TProduct(InstalledProducts[service-1]).CalcUnlockKey(StrToInt(edtRegN.Text));
                      if AWExpDate > SvcExpDate then
                        ProductGrid.Cell[4,service] := DateToStr(AWExpDate);
                    end;
                end;
            end;
        end;

      FChanged := True;
      if not Silent then
        ShowNotice('Your new unlocking codes have been retrieved and entered for you.');
      try
        FRegApplied := True;
        FCurUser.ValidateClickFormsUsage;     //set the Lic File Type
        SaveLicenseInfoToUser(FCurUser);
        FCurUser.SaveUserLicFile;
        FChanged := False;
        result := True;
      except
        ShowAlert(atWarnAlert, 'The User License file could not be saved.');
      end;
    end;
end;
*)
function TRegistration.NoData(Str: String): Boolean;
begin
  result := length(Str)=0;
end;

function TRegistration.ValidateCSN(var noCSN: Boolean): Boolean;
begin
  noCSN := NoData(edtSerial1.Text) or noData(edtSerial2.Text) or noData(edtSerial3.Text) or noData(edtSerial4.Text);
  result := ValidSerialNumbers(edtSerial1.Text,edtSerial2.Text,edtSerial3.Text,edtSerial4.Text);
end;

function TRegistration.ValidUserSelected: Boolean;
var
  userFileName: String;
begin
  result := True;

  //load the selected user, (list in sync with LicensedUsers List)
  if UserRegList.Row > -1 then
    userFileName := TUser(LicensedUsers[UserRegList.Row-1]).FFileName;

  if length(userFileName)> 0 then
    begin
      //finalize the prev user
      If assigned(FCurUser) then
        begin
          SaveCurUserChanges;
          //SaveLicenseInfoToUser(FCurUser);
          //FCurUser.SaveUserLicFile;
          if (FCurUser <> CurrentUser) then
            FreeAndNil(FCurUser);
        end;

      //load in the new user
      try
        FCurUser := TLicensedUser.create;
        FCurUser.LoadUserLicFile(userFileName);
        LoadLicensedUser(FCurUser);
        FChanged := False;
        result := True;
      except
        ShowNotice('The selected users license file could not be loaded.');
        result := False;
      end;
    end;
end;

function TRegistration.ValidatedContactInfo: Boolean;
begin
  result := True;

  if (NoData(edtFirstName.text) or NoData(edtLastName.text) or NoData(edtCompany.text) or NoData(edtAddress.text) or
     NoData(edtCity.text) or NoData(edtState.text) or NoData(edtZip.text)) then
    begin
      ShowNotice(msgNoContact);
      result := False;                  //Stop!
    end;

  if result and not ValidEmailAddress(edtEMail.text) then
    begin
      ShowNotice(msgNoEmail);
      result := False;                  //Stop!
    end;
end;

function TRegistration.ValidatedAWLogin: Boolean;
var
 AW_ID, BSS_ID: String;
begin
  result := false;
  {result := (NoData(edtAWLogin.text) and NoData(edtAWPassword.text)) or
            (not NoData(edtAWLogin.text) and NoData(edtAWPassword.text));

  if not result then
    if NoData(edtAWLogin.text) then
      ShowNotice(msgAWLoginName)
    else    }
    if not (NoData(edtAWLogin.text) or NoData(edtAWPassword.text))  then
      // Only check login if both the login name & password have data
      if IsUserAppraisalWorldMember(edtAWLogin.Text, edtAWPassword.Text, AW_ID, BSS_ID) then
        begin
          if cbSaveAWLogin.Checked then
            begin
              //AWCustomerEmail := edtAWLogin.Text;
              FCurUser.AWUserInfo.FLoginName := edtAWLogin.Text;
              //AWCustomerPSW := edtAWPassword.Text;
              FCurUser.AWUserInfo.FPassword := edtAWPassword.Text;
            end
          else
            begin
              //AWCustomerEmail := '';
              //AWCustomerPSW := '';
              FCurUser.AWUserInfo.FLoginName := '';
              FCurUser.AWUserInfo.FPassword :=  '';
            end;
          FCurUser.AWUserInfo.AWIdentifier := AW_ID;     //save any way
          FCurUser.AWUserInfo.CustDBIdentifier := BSS_ID;
          FUserIsAWMember := True;
          result := True;
        end
      else
        begin
          //AWCustomerEmail := '';        //leave what we had in license file  before
          //AWCustomerPSW := '';
          //CurrentUser.AWUserInfo.AWIdentifier := '0';
          //CurrentUser.AWUserInfo.CustDBIdentifier := '0';
          FUserIsAWMember := False;
          ShowNotice(msgAWLoginNotValid);
        end
    else       //the user did not fill out login fields. Let assume he does not want login at AW for now
      result := true;
end;

function TRegistration.ValidatedRegisterInfo: Boolean;
var
  noCSN: Boolean;
  isCSNvalid: Boolean;
begin
  result := True;
  if NoData(edtLicName.text)  then
    begin
      ShowNotice(msgNeedLicName);
      result := False;                  //Stop!
    end;

  if result and (NoData(edtLicCoName.text) {and reguired}) then
    begin
      ShowNotice(msgNeedLicCoName);
      result := False;                  //Stop!
    end;

  CSNComment.Visible := False;
  isCSNvalid := ValidateCSN(noCSN);
  if result and not isCSNvalid and (not FUserIsAWMember or (FUserIsAWMember and not noCSN)) then
    begin
      FNoOnLine := True;
      CSNComment.Visible := True;
      if noCSN then
        ShowAlert(atStopAlert, msgNoCSN + msgLocateCSN)
      else
        ShowAlert(atStopAlert, msgCSNNotValid + msgLocateCSN);
      result := True;
    end;
end;

function TRegistration.ValidateAppraisalInfo: Boolean;
begin
  result := True;
  if BackDoorDown then
    SetBackDoorUnLockingKeys;
end;

function TRegistration.UserLicStatusMsg: Boolean;
begin
  result := False;
  //if ValidateCSN(noCSN) then
    begin
      FCurUser.ValidateClickFormsUsage;     //set the Lic File Type
      if FCurUser.OK2UseClickForms then     //re-checks
        begin
          SetRegistrationMarker;      //writes a marker to registry

          FinishedNote.Caption := 'CONGRATULATIONS';
          FinishedMsg.Caption := msgSWRegOK;
          ExpireMsg.Visible := False;
          result := True;
        end;
    end;

  if not result then
    begin
      FinishedNote.Caption := 'NOTICE';
      FinishedMsg.Caption := msgSWRegNotOK;
      ExpireMsg.Visible := True;
      ExpireMsg.Caption := 'The software will expire in '+IntToStr(AppEvalUsageLeft)+ ' days';
    end;
end;

function TRegistration.HasUnlockCodes: Boolean;
var
  i: Integer;
begin
  result := false;
  //do we have any unlocking codes
  if ProductGrid.Rows > 0 then
    for i := 1 to ProductGrid.Rows do
      if length(ProductGrid.Cell[3,i]) > 0 then
        result := True;
end;

function TRegistration.ValidateSWUsage: Boolean;
var
  hasCodes: Boolean;
begin
  result := False;
  hasCodes := HasUnlockCodes;
  if hasCodes then
    if FChanged then
      //test if previously valid or not, could be temp, undefined
      case FCurUser.SWLicenseType of
        ltValidLic:
          begin
            if FChanged then
              begin
                SaveLicenseInfoToUser(FCurUser);
                FCurUser.SaveUserLicFile;
                result := UserLicStatusMsg;
                FChanged := False;
              end;
        (*                                        //they may be updating
          FCurUser.SaveBackupLicFile;
          SaveLicenseInfoToUser(FCurUser);
          if FCurUser.OK2useClickForms then
            FCurUser.SaveUserLicFile
          else begin
            FCurUser.LoadBackupLicFile
            ShowNotice('The changes have invalidated the ClickFORMS License.');
          end;
        *)
          end;
        ltTempLic:
          begin
            SaveLicenseInfoToUser(FCurUser);
            FCurUser.SaveUserLicFile;
            result := UserLicStatusMsg;
            FChanged := False;
          end;
        ltExpiredLic:
          begin
            SaveLicenseInfoToUser(FCurUser);
            FCurUser.SaveUserLicFile;
            result := UserLicStatusMsg;
            FChanged := False;
          end;
        ltUDEFLic:
          begin
            SaveLicenseInfoToUser(FCurUser);
            FCurUser.SaveUserLicFile;
            result := UserLicStatusMsg;
            FChanged := False;
          end;
      end
    else
      begin
        result := UserLicStatusMsg;
      end;
    
  if result then
    ShowNotice(Format(msgValidLic,[edtLicName.text]))
  else if not FShowMsg then
    begin
      if hasCodes then
        ShowNotice(Format(msgNotValidLic, [edtLicName.text]))
      else
        ShowNotice('You have not entered any unlocking codes.');
      FShowMsg := true;
      btnNext.caption := nextDirection;
    end
  else
    result := True;
end;

procedure TRegistration.PgRegisterEnter(Sender: TObject);
begin
  edtCompany.ReadOnly := FCurUser.SWLicenseCoNameLocked;
  edtLicCoName.ReadOnly := FCurUser.SWLicenseCoNameLocked;
end;

procedure TRegistration.UserRegListDblClick(Sender: TObject);
begin
  btnNextClick(nil);
end;

procedure TRegistration.btnNextClick(Sender: TObject);
var
  NextPage, CurPage: TTabSheet;
  canMove: Boolean;
begin
  CurPage := PageControl.ActivePage;
  NextPage := PageControl.FindNextPage(CurPage, True, False);

  canMove := True;
  if CurPage = PgUserList then
    canMove := ValidUserSelected
  else if CurPage = PgContact then
    canMove := ValidatedContactInfo
  else if curPage = PgWorkInfo then
    canMove := ValidateAppraisalInfo
  else if CurPage = PgAWLogin then
    canMove := ValidatedAWLogin
  else if CurPage = PgRegister then
    canMove := ValidatedRegisterInfo
  else if curPage = PgGetCodes then
    canMove := True {Validate Codes Requested}
  else if CurPage = PgValidate then
    canMove := ValidateSWUsage;

  if canMove then
    begin
      PageControl.ActivePage := NextPage;

      btnPrev.Enabled := True;
      if NextPage = PgFinished then
        btnNext.Enabled := False;
    end;
end;

procedure TRegistration.btnPrevClick(Sender: TObject);
var
  PrevPage, CurPage: TTabSheet;
begin
  CurPage := PageControl.ActivePage;
  PrevPage := PageControl.FindNextPage(CurPage, False, False);
  PageControl.ActivePage := PrevPage;

  btnNext.Enabled := True;
  if PrevPage = FFirstPage then
    btnPrev.Enabled := False;
end;

procedure TRegistration.rdoOnLineClick(Sender: TObject);
begin
  btnOnline.enabled := True;
  btnFax.enabled := False;

  btnNext.Enabled := False;
end;

procedure TRegistration.rdoFaxClick(Sender: TObject);
begin
  btnOnline.enabled := false;
  btnFax.enabled := True;

  btnNext.Enabled := False;
end;

procedure TRegistration.rdoSkipClick(Sender: TObject);
begin
  btnOnline.enabled := False;
  btnFax.enabled := False;

  btnNext.Enabled := True;   //user received codes, can move on
end;

procedure TRegistration.PgGetCodesShow(Sender: TObject);
begin
  if not rdoSkip.checked then
    rdoOnLine.checked := True;  //default to online registration

  if FNoOnLine then
    begin
      lblGetCodes.visible := False;
      btnFax.Visible := True;
      rdoFax.Visible := True;
      rdoFax.checked := True;
    end;

  btnNext.Enabled := False;   //cannot continue until users request codes
end;

procedure TRegistration.PgValidateShow(Sender: TObject);
begin
//  if HasUnlockCodes then
  btnNext.Enabled := True;
  btnNext.Caption := 'Finish';
end;

//avoid confusion - change text on button
procedure TRegistration.PgValidateHide(Sender: TObject);
begin
  btnNext.caption := nextDirection;
end;

procedure TRegistration.btnOnLineClick(Sender: TObject);
begin
  if SendOnLine then
    PageControl.ActivePage := PgValidate;
end;

procedure TRegistration.btnFaxClick(Sender: TObject);
begin
  if SendByFax then
    PageControl.ActivePage := PgFinished;
end;

procedure TRegistration.btnPhoneClick(Sender: TObject);
begin
  SendByPhone;
end;

{*****************************}
{         SendOnLine          }
{*****************************}
function TRegistration.SendOnLine: Boolean;
var
  regInfo, regResponse: String;
  custIDStr, fromAddr: String;
  httpAddress,httpGetStr: String;
  rspResults: TStringList;
  //IsAWRegistration: Boolean;
  AWResponse: clsGetUsageAvailabilityData;
  AWUseOK: Boolean;
  AWExpDate: TDateTime;
  noCSN: Boolean;
  custDBRegError: String;
begin
  PushMouseCursor(crHourglass);   //show wait cursor
  rspResults := TStringList.create;
  try
    result := False;
    try
      if validateCSN(noCSN) then    //custDB registration
        begin
          custDBRegError := '';
          regInfo := SWRegDetailsForHTTP(custIDStr, fromAddr);  //get all the info
          if length(custIDStr)>0 then  //we have a valid customer ID
            begin
              httpAddress := UWebConfig.GetURLForRegistration;
              httpGetStr := httpAddress + '?' + regInfo;
              regResponse := HTTP.Get(httpGetStr);            //request
              rspResults.text := regResponse;    // no decode and results are in name/value pairs
              if Length(rspResults.values['Error']) > 0 then
                custDBRegError := rspResults.values['Error']
              else
                begin
                  if Length(rspResults.values['Msg']) > 0 then
                    ShowNotice('The Information you provided for Registration does not match our records.'
                            + ' It has been changed.' + #13#10#13#10
                            + 'If you would like to change your Registration'
                            + ' Information, please contact your Account Representative'
                            + ' at 1-800-622-8727');
                  result := ApplyRegistrationResults(rspResults);
                end;
            end;
        end;
        if not result then
          if FUserIsAWMember then    //AWSI Registration
            begin
              AWUseOK := FCurUser.OK2UseAWProduct(pidClickForms, AWResponse, True,false);
              if (not AWUseOK) or (AWResponse = nil) then
                ShowAlert(atWarnAlert,AWResponse.Message_)
              else
                begin
                  rspResults.Free;
                  AWExpDate := StrToDateEx(AWResponse.AppraiserExpirationDate, 'yyyy-mm-dd','-');
                  rspResults := CreateAWSIRegResponse(AWExpDate);
                  result := ApplyRegistrationResults(rspResults);
                end;
            end
          else
            if length(custDBRegError) > 0 then
              ShowAlert(atStopAlert, custDBRegError)
            else   // no valid custid ,AW login
              ShowAlert(atStopAlert,Format(msgNotValidLic, [edtLicName.text]));
  {  //  The function rewwritten to call AW registration even customer doesnot have custID
  IsAWRegistration := False;
    regInfo := SWRegDetailsForHTTP(custIDStr, fromAddr);  //get all the info

    if length(custIDStr)>0 then  //we have a valid customer ID
      begin
        httpAddress := UWebConfig.GetURLForRegistration;
        httpGetStr := httpAddress + '?' + regInfo;
        try
          regResponse := HTTP.Get(httpGetStr);            //request
          rspResults := TStringList.create;
          try
            rspResults.text := regResponse;    // no decode

            //error and results are in name/value pairs
            if Length(rspResults.values['Error']) > 0 then
              begin
                regResponse := rspResults.values['Error'];
                AWUseOK := FCurUser.OK2UseAWProduct(pidClickForms, AWResponse, True);
                if (not AWUseOK) or (AWResponse = nil) then
                  ShowAlert(atWarnAlert,regResponse)
                else
                  begin
                    rspResults.Free;
                    AWExpDate := StrToDateEx(AWResponse.AppraiserExpirationDate, 'yyyy-mm-dd','-');
                    rspResults := CreateAWSIRegResponse(AWExpDate);
                  end;
              end;
(*
              begin

//                LicName := rspResults.values['LicName'];
//                LicCo := rspResults.values['LicCo'];
//                LockCo := rspResults.values['LockCo'];
//                //just used for display what i get back form registration server
//                ShowNotice('Lic Name :' + LicName + #10+ #13+ 'Lic Company :' + LicCo + #10+ #13+ 'Lock Company :' + LockCo + #10+ #13);

                // See if user is registered on AW - If no go then raise prior the exception
                if not IsUserAppraisalWorldMember(edtAWLogin.Text, edtAWPassword.Text, FCurUser.AWUserInfo.FAWUID, FCurUser.AWUserInfo.FCustID) then
                  begin
                    regResponse := rspResults.values['Error'];
                    raise Exception.create(regResponse);
                  end
                else
                  IsAwRegistration := True;
              end;
*)
            //the code that I added in this version

              if Length(rspResults.values['Msg']) > 0 then
               (* ShowNotice('The Company Name you provided for Registration does not match our records.'
                + ' You Company Name has been changed to match our records.');    *)
                   ShowNotice('The Information you provided for Registration does not match our records.'
                            + ' It has been changed.' + #13#10#13#10
                            + 'If you would like to change your Registration'
                            + ' Information, please contact your Account Representative'
                            + ' at 1-800-622-8727');

            //no errors, process
            result := ApplyRegistrationResults(rspResults);
(*
          if not IsAWRegistration then
            result := ApplyRegistrationResults(rspResults);   //BSS codes retrieved ok
          else
            result := ApplyAWRegistrationResults(edtAWLogin.Text, edtAWPassword.Text)   //AW codes retrieved ok
*)
          finally
            rspResults.free;
          end;
        except
          on E: Exception do
            ShowAlert(atStopAlert, 'Registration could not be handled online. '+ FriendlyErrorMsg(E.Message));
        end;
      end
    else
      ShowAlert(atStopAlert, 'Your customer serial number is not valid. You cannot use online registration. Please fax your request for unlocking codes.');
  }
    except
      on E: Exception do
        ShowAlert(atStopAlert, 'Registration could not be handled online. '+ FriendlyErrorMsg(E.Message));
    end;
  finally
    PopMouseCursor;
  end;
end;

{*****************************}
{          SendEMail          }
{*****************************}
function TRegistration.SendByEMail: Boolean;
var
  sentOK: Boolean;
  regInfo: TStrings;
  fromAddr, custIDStr: String;
begin
  PushMouseCursor(crHourglass);   //show wait cursor
  try
    try
      regInfo := SWRegDetailsForEmail(custIDStr, fromAddr);  //compose the Email

      EmailMsg.Clear;
      EmailMsg.From.Name := edtFirstName.text + ' ' + edtLastName.text;
      EmailMsg.From.Address := fromAddr;
      EmailMsg.Recipients.EmailAddresses := 'registration@bradfordSoftware.com';
      EmailMsg.ReceiptRecipient.Text := EmailMsg.From.Text;
      EmailMsg.Subject := custIDStr +': ClickFORMS Registration';
      EmailMsg.Body.assign(regInfo);
      regInfo.free;                   //copied data, now free it

      //send the EMail
      SMTPMailer.AuthType := atDefault;
      SMTPMailer.Username := 'smtpuser';
      SMTPMailer.Password := 'ma1luser';
      SMTPMailer.Host := 'smtp.bradfordsoftware.com';
      SMTPMailer.Port := 25;

      SMTPMailer.Connect;
      SMTPMailer.Send(EMailMsg);
      SentOK := True;
    except
      on E: Exception do
        begin
          ShowAlert(atStopAlert, 'There was a problem sending the email. '+ FriendlyErrorMsg(E.Message));
          SentOK := False;
        end;
    end;
  finally
    SMTPMailer.Disconnect;
    PopMouseCursor;
  end;

  if sentOK then
    begin
      ShowNotice('Your request for unlocking codes was sent successfully. You codes will be sent by email to your email address by the end of the next business day.');
    end;

  btnNext.caption := nextDirection;    //sent email, move on
  FShowMsg := true;                    //don't show msg about not validating

  result := SentOK;
end;

{*****************************}
{       SendEMailOldWay       }
{*****************************}
procedure TRegistration.SendEMailOldWay;
var
  sentOK: Boolean;
  EMail: TMail;
  regInfo: TStrings;
  Subject, fromAddr, custIDStr: String;
  ToAddress: TStringList;
begin
  sentOK := True;
  //compose the Email
  regInfo := SWRegDetailsForEmail(custIDStr, fromAddr);  //get all the info

  Subject := custIDStr+ ': ClickFORMS Registration';
  if length(custIDStr) > 0 then Subject := Subject + ' for '+custIDStr;

  EMail := TMail.Create;
  ToAddress := TStringList.create;
  try
    EMail.Reset;
    EMail.SetShowDialog(FALSE);

    //Set the suggestion email address
    ToAddress.Add('registeration@bradfordSoftware.com');
    EMail.SetToAddr(ToAddress);

    //Set the subject
    EMail.SetSubject(Subject);

    //Compose EMail
    EMail.SetBody(regInfo.text);
    try
      EMail.SendMail;
    Except
      on E: Exception do
        begin
          ShowNotice('There was a problem sending the email. '+ FriendlyErrorMsg(E.message));
          sentOK := False;
        end;
    end;
  finally
    ToAddress.Free;
    EMail.Free;
  end;

  if sentOK then
    begin
      ShowNotice('Your request for unlocking codes was sent successfully. You codes will be sent by email to your email address by the end of the next business day.');
    end;
end;


{*****************************}
{       SendFax               }
{*****************************}
function TRegistration.SendByFax: Boolean;
begin
  ShowNotice('To fax your request for unlocking codes, please select a fax driver. Or to print, select a printer driver.');
  PrintRegInfo(True);

  result := True;
end;


{*****************************}
{     SendByPhone             }
{*****************************}
procedure TRegistration.SendByPhone;
begin
  ShowNotice('To obtain unlocking codes by phone, please call (408) 360-8520. Please print the registration information before calling for easy reference. Ask for the Registration Department');
end;

//This is an imitation of register.dll' response for custDB users.
//It contains the only information needed to validate ClickForms usage
// Fake a CustDB valid registration when AW Registration returns ok. This is a temp fix
function TRegistration.CreateAWSIRegResponse(expDate: TDateTime): TStringList;
begin
  result := TStringList.Create;
  with result do
    begin
      Add('ServerDate=' + FormatDateTime('mm/dd/yyyy',Date));
      Add('isSubscriber=Yes');
      Add('ProductCount=1');
      Add('Product1_PID=1');
      Add('Product1_CanUse=Yes');
      //Add('Product1_Exp=' + FormatDateTime('mm/dd/yyyy',expDate));
      Add('Product1_Exp=On Subscription');  //maintenance on AWSI always subscription
      Add('LicName=' + edtLicName.Text);      //get existing license information
      Add('LicCo=' + edtLicCoName.Text);
      if FLockInCo  then
        Add('LockCo=1')
      else
        Add('LockCo=0');
    end;
end;

end.
