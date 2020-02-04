unit UCRMLicRegistration;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 2018 by Bradford Technologies, Inc. }

{ This unit allows the user to enter information to register the  }
{ software for either evaluation or a paid license}


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, RzLabel, Buttons, Grids,
  {ULicUser,}UCRMLicUser, UForms, {ULicConfirmation,}UCRMLicConfirmation;

const
  {Paid Lic Registraion OR Eval Lic Registration}
  {Registration Type}
  rtPaidLicMode    = 1;
  rtEvalLicMode    = 2;


type
  TCRMRegistration = class(TAdvancedForm)
    Panel1: TPanel;
    btnCancel: TButton;
    btnPrev: TButton;
    btnNext: TButton;
    PageControl: TPageControl;
    tabAWLogin: TTabSheet;
    Label1: TLabel;
    btnSignIn: TButton;
    lblUsername: TLabel;
    edtUserLoginEmail: TEdit;
    lblPassword: TLabel;
    edtUserPassword: TEdit;
    tabContact: TTabSheet;
    lblForgotPassword: TRzURLLabel;
    Label31: TLabel;
    Label19: TLabel;
    edtName: TEdit;
    Label20: TLabel;
    edtCompany: TEdit;
    Label23: TLabel;
    edtAddress: TEdit;
    Label21: TLabel;
    edtCity: TEdit;
    lblState: TLabel;
    edtState: TEdit;
    LblZip: TLabel;
    edtZip: TEdit;
    Label6: TLabel;
    Label27: TLabel;
    Label29: TLabel;
    lblEMail: TLabel;
    edtEMail: TEdit;
    edtCell: TEdit;
    edtPhone: TEdit;
    cbxCountry: TComboBox;
    tabSigner: TTabSheet;
    Label3: TLabel;
    edtLicName: TEdit;
    edtLicCoName: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    tabRegister: TTabSheet;
    tabIntro: TTabSheet;
    Label7: TLabel;
    lblLicOptionHelp: TLabel;
    lblLicDesc: TLabel;
    lblThanks: TLabel;
    btnRegister: TBitBtn;
    lblRegType: TLabel;
    btnSave: TButton;
    tabAppraisalLic: TTabSheet;
    lblLicState: TLabel;
    lblCertNo1: TLabel;
    lblCertExp1: TLabel;
    lblSetDefault: TLabel;
    edtWrkLicState1: TEdit;
    edtWrkLicState2: TEdit;
    edtWrkLicState3: TEdit;
    edtWrkLicNumber1: TEdit;
    edtWrkLicNumber2: TEdit;
    edtWrkLicNumber3: TEdit;
    edtWrkLicExp1: TEdit;
    edtWrkLicExp2: TEdit;
    edtWrkLicExp3: TEdit;
    rbtnUseWrkLic1: TRadioButton;
    rbtnUseWrkLic2: TRadioButton;
    rbtnUseWrkLic3: TRadioButton;
    lblRegResult: TLabel;
    lblCongrats: TLabel;
    lblRegMsg: TLabel;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    rbtnUseLic: TRadioButton;
    rbtnUseCert: TRadioButton;
    tabUserList: TTabSheet;
    UserRegList: TStringGrid;
    lblSelectUser: TLabel;
    procedure tabAWLoginShow(Sender: TObject);
    procedure btnSignInClick(Sender: TObject);
    procedure btnPrevClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnRegisterClick(Sender: TObject);
    procedure tabRegisterShow(Sender: TObject);
  private
    FRegSucceeded: Boolean;
    FAWMemberID: String;
    FIsAWMember: Boolean;                         //flag to remeber they have logged in successfully
    FFirstPage: TTabSheet;
    FCurUser: TCRMLicensedUser;
    FLicMode: Integer;
    FUserLicInfo: TCRMUserLicInfo;                   //used to pass data between UserLic and AW
    FModified: Boolean;
    FLoadLicInfo: Boolean;
    function NoData(Str: String): Boolean;        //utility if length(str) = 0
    function ValidateLoginInfo: Boolean;
    function ValidateIsAWMember: Boolean;
    function ValidatedContactInfo: Boolean;
    function ValidateAppraisalCerts: Boolean;
    function ValidatedReportSigner: Boolean;
    procedure SetupIntroPage;
    procedure LoadToDisplayFrom(UserInfo: TCRMUserLicInfo);        //displays it
    procedure SaveFromDisplayTo(UserInfo: TCRMUserLicInfo);        //captures user input
    procedure SaveRegistrationToLicenseFile;
    procedure ConfirmEvaluationSoftwareLicense_CRM(UserInfo: TCRMUserLicInfo);
    procedure ConfirmPaidSoftwareLicense_CRM(UserInfo: TCRMUserLicInfo);
    procedure ConfirmAppraisalWorldMembership_CRM(UserInfo: TCRMUserLicInfo;LoadLicInfo:Boolean=True);
    function ValidateUserSelected: Boolean;
    procedure LoadAllLicensedUsers;
    procedure LoadLicensedUser(User: TCRMLicensedUser);
  public
    constructor CreateRegistar(AOWner: TComponent; AUser: TCRMLicensedUser; LicMode: Integer; ShowUserSelection:Boolean);
    destructor Destroy;   override;

    procedure RegisterSoftwareUsage_CRM;
    property AWMemberID: String read FAWMemberID write FAWMemberID;
  end;



  function RegisterClickFORMSSoftware_CRM(AOwner: TComponent; User: TCRMLicensedUser; LicMode: Integer; ShowUserSelection:Boolean=True): Boolean;



implementation

{$R *.dfm}

Uses
  UGlobals, UStatus, UUtil2, UStrings;



const
  msgNeedLicName    = 'The users license name is missing. Please enter it.';
  msgNeedLicCoName  = 'A company name is required. Please enter it.';
  msgNoContact      = 'Some or all of your contact information is missing. Please enter it.';




function RegisterClickFORMSSoftware_CRM(AOwner: TComponent; User: TCRMLicensedUser; LicMode: Integer; ShowUserSelection:Boolean=True): Boolean;
var
  UserReg: TCRMRegistration;
begin
  try
    UserReg := TCRMRegistration.CreateRegistar(nil, User, LicMode, ShowUserSelection);
    result := UserReg.ShowModal = mrOK;
   finally
    UserReg.Free;
  end;
end;



{ TCRMRegistration }

constructor TCRMRegistration.CreateRegistar(AOWner: TComponent; AUser: TCRMLicensedUser; LicMode: Integer; ShowUserSelection:Boolean);
begin
  inherited Create(AOwner);
  LicensedUsers.GatherUserLicFiles;   //get the latest  -- in case there is a preference change
  if (LicensedUsers.count > 1) and ShowUserSelection then
    begin
      PageControl.ActivePage := tabUserList;
      FFirstPage := tabUserList;
      LoadAllLicensedUsers;
    end
  else
    begin
      PageControl.Activepage := tabIntro;      //set the first page
      FFirstPage := tabIntro;
    end;

    FLicMode := LicMode;       //either eval or paid license
    FCurUser := AUser;         //may not be CurrentUser, so handle as if not

  FUserLicInfo := TCRMUserLicInfo.Create;

  FLoadLicInfo := ShowUserSelection;
//setup the display components
  {appraisal credentials}
  if IsAmericanVersion then
    begin
      rbtnUseCert.Visible := True;
      rbtnUseLic.Visible  := True;

      rbtnUseWrkLic1.Visible := True;
      rbtnUseWrkLic2.Visible := True;
      rbtnUseWrkLic3.Visible := True;

      lblLicState.Caption := 'State';
      lblState.Caption    := 'State';  //PAM: need to change the caption state/zip for AmericanVersion
      LblZip.Caption      := 'Zip';

      edtWrkLicState1.Visible   := True;
      edtWrkLicNumber1.Visible  := True;
      edtWrkLicExp1.Visible     := True;

      edtWrkLicState2.Visible   := True;
      edtWrkLicNumber2.Visible  := True;
      edtWrkLicExp2.Visible     := True;

      edtWrkLicState3.Visible   := True;
      edtWrkLicNumber3.Visible  := True;
      edtWrkLicExp3.Visible     := True;

      {default setting}
      rbtnUseCert.Checked := True;
      rbtnUseWrkLic1.Checked := True;
    end
  else if IsCanadianVersion then
    begin
      rbtnUseCert.Visible := False;
      rbtnUseLic.Visible  := False;

      lblLicState.Caption := 'Province';

      lblSetDefault.Visible     := False;
      rbtnUseWrkLic1.Visible    := False;
      rbtnUseWrkLic2.Visible    := False;
      rbtnUseWrkLic3.Visible    := False;

      edtWrkLicState1.Visible   := True;
      edtWrkLicNumber1.Visible  := True;
      edtWrkLicExp1.Visible     := True;

      edtWrkLicState2.Visible   := False;
      edtWrkLicNumber2.Visible  := False;
      edtWrkLicExp2.Visible     := False;

      edtWrkLicState3.Visible   := False;
      edtWrkLicNumber3.Visible  := False;
      edtWrkLicExp3.Visible     := False;
    end;


(*
  lblState.Caption    := gsaLongState[giCountryID];
  lblZip.Caption      := gsaShortZip[giCountryID];
  lblCertSt1.Caption  := gsaLongState[giCountryID];
  lblCertSt2.Caption  := gsaLongState[giCountryID];
  lblCertSt3.Caption  := gsaLongState[giCountryID];
  lblLicst1.Caption   := gsaLongState[giCountryID];
  lblLicst2.Caption   := gsaLongState[giCountryID];
  lblCertSt3.Caption  := gsaLongState[giCountryID];
*)

  SetupIntroPage;     //depending on FLicMode - set differnet messages


  //set the users login email
  edtUserLoginEmail.Text := FCurUser.AWUserInfo.UserLoginEmail;
  edtUserPassword.Text   := FCurUser.AWUserInfo.UserPassWord;
//  edtUserLoginEmail.Text := 'pam@bradfordsoftware.com';      //###TESTING   Expired Subscription
//  edtUserPassword.text   := 'kpmk1957';
//  edtUserLoginEmail.Text := 'jorge@appraisalworld.com';      //###TESTING  Valid Subscription
//  edtUserPassword.text   := 'p226231';


  btnPrev.Enabled := False;
  btnSave.Enabled := False;

  FRegSucceeded := False;
  FIsAWMember   := False;      //flag to remember successful login
  FModified     := False;      //nothing changed yet
end;

destructor TCRMRegistration.Destroy;
begin
  if assigned(FCurUser) and (FCurUser <> CurrentUser) then
    FreeAndNil(FCurUser);

  FUserLicInfo.Free;        //information packet

  inherited;
end;

procedure TCRMRegistration.LoadAllLicensedUsers;
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


procedure TCRMRegistration.SetupIntroPage;
begin
  if FLicMode = rtPaidLicMode then
    begin
      lblLicDesc.Caption := 'Paid Software License Registration';
      lblLicOptionHelp.Caption := 'Thank you for purchasing a license to use ClickFORMS.  Please follow the registration steps so your services can be activated and your appraisal credentials entered automatically into your reports.';
      lblThanks.Caption := 'Thank you for choosing ClickFORMS. We appreciate your business.';
    end

  else if FLicMode = rtEvalLicMode then
    begin
      lblLicDesc.Caption := 'Evaluation License Registration';
      lblLicOptionHelp.Caption := 'To experience the full capabilities and produce complete, signed appraisal reports, you must first register this copy of the ClickFORMS so we can activate the services for you.' + chr(13) + chr(13) + 'NOTE: There is no charge to evaluate ClickFORMS.';
      lblThanks.Caption := 'Thank you for your interst in using ClickFORMS';
    end;
end;


procedure TCRMRegistration.tabAWLoginShow(Sender: TObject);
begin
  btnNext.Enabled := FIsAWMember;    //need to remember in case user back up to login page
end;

//saves data in display items to the UserInfo object
procedure TCRMRegistration.SaveFromDisplayTo(UserInfo: TCRMUserLicInfo);
begin
  if assigned(UserInfo) then
    begin
    //save contact info
      UserInfo.Name    := Trim(edtName.text);
      UserInfo.Company := Trim(edtCompany.text);
      UserInfo.Address := Trim(edtAddress.text);
      UserInfo.City    := Trim(edtCity.text);
      UserInfo.State   := Trim(edtState.text);
      UserInfo.Zip     := Trim(edtZip.text);
      UserInfo.Country := Trim(cbxCountry.text);
      UserInfo.Phone   := Trim(edtPhone.text);
      UserInfo.Cell    := Trim(edtCell.text);
      UserInfo.Email   := Trim(edtEMail.text);

    //save the appraisal credentials
      {credentials type}
      if rbtnUseCert.checked then
        UserInfo.FWrkLicType := cCertType            //cCertType = 1
      else if rbtnUseLic.checked then
        UserInfo.FWrkLicType := cLicType;            //cLicType = 2

       {which state is primary}
      if rbtnUseWrkLic1.checked then
        UserInfo.FWrkPrimary := 1                   //state 1 is primary
      else if rbtnUseWrkLic2.checked then
        UserInfo.FWrkPrimary := 2                   //state 2 is primary
      else if rbtnUseWrkLic3.checked then
        UserInfo.FWrkPrimary := 3;                  //state 3 is primary

    {credential information}
      UserInfo.WrkLic1State   := Trim(edtWrkLicState1.text);
      UserInfo.WrkLic1Number  := Trim(edtWrkLicNumber1.text);
      UserInfo.WrkLic1ExpDate := Trim(edtWrkLicExp1.text);
      UserInfo.WrkLic2State   := Trim(edtWrkLicState2.text);
      UserInfo.WrkLic2Number  := Trim(edtWrkLicNumber2.text);
      UserInfo.WrkLic2ExpDate := Trim(edtWrkLicExp2.text);
      UserInfo.WrkLic3State   := Trim(edtWrkLicState3.text);
      UserInfo.WrkLic3Number  := Trim(edtWrkLicNumber3.text);
      UserInfo.WrkLic3ExpDate := Trim(edtWrkLicExp3.text);


    //save the users signature name and company name
      UserInfo.LicName     := Trim(edtLicName.text);       //Users name on the form
      UserInfo.LicCoName   := Trim(edtLicCoName.text);     //users company name on the form
//      UserInfo.FLicLockedCo := FLockInCo;            //is the company name locked

    end; //with UserInfo
end;

//loads the display objects from data in UserInfo
procedure TCRMRegistration.LoadToDisplayFrom(UserInfo: TCRMUserLicInfo);
begin
//  if false then
  if assigned(UserInfo) then
    begin
    //display contact Info
      edtName.text    := UserInfo.Name;
      edtCompany.text := UserInfo.Company;
      edtAddress.text := UserInfo.Address;
      edtCity.text    := UserInfo.City;
      edtState.text   := UserInfo.State;
      edtZip.text     := UserInfo.Zip;
      cbxCountry.text := UserInfo.Country;
      edtPhone.text   := UserInfo.Phone;
      edtCell.text    := UserInfo.Cell;
      edtEMail.text   := UserInfo.Email;

    //display the user appraisal credentials
      {set the credential type}
      if UserInfo.FWrkLicType = cCertType then
        rbtnUseCert.checked := True
      else if UserInfo.FWrkLicType = cLicType then
        rbtnUseLic.checked := True;

       {which state is primary}
      case UserInfo.FWrkPrimary of
        1: rbtnUseWrkLic1.checked := True;
        2: rbtnUseWrkLic2.checked := True;
        3: rbtnUseWrkLic3.checked := True;
      end;

      {appraisal credentials}
      edtWrkLicState1.text    := UserInfo.WrkLic1State;
      edtWrkLicNumber1.text   := UserInfo.WrkLic1Number;
      edtWrkLicExp1.text      := UserInfo.WrkLic1ExpDate;
      edtWrkLicState2.text    := UserInfo.WrkLic2State;
      edtWrkLicNumber2.text   := UserInfo.WrkLic2Number;
      edtWrkLicExp2.text      := UserInfo.WrkLic2ExpDate;
      edtWrkLicState3.text    := UserInfo.WrkLic3State;
      edtWrkLicNumber3.text   := UserInfo.WrkLic3Number;
      edtWrkLicExp3.text      := UserInfo.WrkLic3ExpDate;
      
    //report signature info
      edtLicName.text   := UserInfo.LicName;
      edtLicCoName.text := UserInfo.LicCoName;
    end;
end;


procedure TCRMRegistration.btnPrevClick(Sender: TObject);
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

procedure TCRMRegistration.btnNextClick(Sender: TObject);
var
  NextPage, CurPage: TTabSheet;
  canMove: Boolean;
begin
  CurPage := PageControl.ActivePage;
  NextPage := PageControl.FindNextPage(CurPage, True, False);

  canMove := True;
  if CurPage = tabAWLogin then
    canMove := ValidateIsAWMember
  else if CurPage = tabContact then
    canMove := ValidatedContactInfo
  else if curPage = tabAppraisalLic then
    canMove := ValidateAppraisalCerts
  else if CurPage = tabSigner then
    canMove := ValidatedReportSigner                     //ValidatedRegisterInfo
  else if CurPage = tabUserList then
    canMove := ValidateUserSelected;

  if canMove then
    begin
      PageControl.ActivePage := NextPage;

      btnPrev.Enabled := True;
      if NextPage = tabRegister then
        btnNext.Enabled := False;

    end;
end;

//clear any messages
procedure TCRMRegistration.tabRegisterShow(Sender: TObject);
begin
  if FLicMode = rtPaidLicMode then
     lblRegType.caption := 'For Professional Appraisal Use'
  else if FLicMode = rtEvalLicMode then
    lblRegType.caption := 'For Evaluation Purposes';

  lblCongrats.caption   := '';
  lblRegResult.caption  := '';
  lblRegMsg.caption     := '';
end;

procedure TCRMRegistration.btnSignInClick(Sender: TObject);
begin
  ConfirmAppraisalWorldMembership_CRM(FUserLicInfo, FLoadLicInfo);
  //lock company name if the locking field is set to True
  edtLicCoName.ReadOnly := FUserLicInfo.FLicCoLocked;
end;

procedure TCRMRegistration.btnRegisterClick(Sender: TObject);
begin
  RegisterSoftwareUsage_CRM;
end;

procedure TCRMRegistration.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TCRMRegistration.btnSaveClick(Sender: TObject);
begin
  SaveRegistrationToLicenseFile;

  //do we let the user continue?
  if FRegSucceeded then     //set in Registration results
    ModalResult := mrOK     //only mrOK allows user to continue
  else
    ModalResult := mrCancel;
end;

procedure TCRMRegistration.SaveRegistrationToLicenseFile;
begin
  FCurUser.AWUserInfo.UserLoginEmail := Trim(edtUserLoginEmail.Text);
  FCurUser.AWUserInfo.UserPassWord   := Trim(edtUserPassword.Text);

  FCurUser.SaveToUserLicenseFrom(FUserLicInfo);        //saves to the Current User Lic File
  //PAM: if version # in the license file < the latest version (cSWLicVers4), back up license file
  if FCurUser.LicInfo.FLicVersion < FCurUser.LicInfo.CurLicVersion then
    begin
      FCurUser.BackupLicenseFile(FCurUser.UserFileName);
      FCurUser.LicInfo.FLicVersion := FCurUser.LicInfo.CurLicVersion;   //after we back up, we need to update the FLicVersion to the latest, since the reregistration through help will not load from file.
    end;
  FCurUser.SaveUserLicFile;                            //saves the User Lic file to disk

  if FUserLicInfo.FReplyID = 1 then
    begin
      ShowNotice('Your Online and Desktop ClickFORMS License has been updated and saved.');
    end;
  Close;
end;

procedure TCRMRegistration.ConfirmAppraisalWorldMembership_CRM(UserInfo: TCRMUserLicInfo; LoadLicInfo:Boolean=True);
var
  UserEmail, UserPassword: String;
begin
  if ValidateLoginInfo then
    begin
      UserEmail     := Trim(edtUserLoginEmail.text);
      UserPassword  := Trim(edtUserPassword.text);

      DoConfirmAppraisalWorldMembership_CRM(UserEmail, UserPassword, UserInfo, LoadLicInfo);

      case UserInfo.ReplyID of
        rsIsMemberYes:
          begin
            ShowNotice('Your AppraisalWorld Information has been retreived. Please verify it.');

            btnNext.Enabled := True;
            btnNextClick(nil);

            LoadToDisplayFrom(FUserLicInfo);
            FIsAWMember := True;                //remeber incase user backs up (don't reconfirm)
          end;

        rsInvalidCredentials:
          ShowAlert(atWarnAlert, 'Your AppraisalWorld account could not be located. Please reenter your login email address and/or password.');

        rsDatabaseError,
        rsInputDataError,
        rsFailed2Connect:
          ShowAlert(atWarnAlert, FUserLicInfo.ReplyMsg);
      else
        ShowAlert(atWarnAlert, FUserLicInfo.ReplyMsg);
      end;
    end;
end;

procedure TCRMRegistration.RegisterSoftwareUsage_CRM;
begin
  SaveFromDisplayTo(FUserLicInfo);             //gather the data

  if FLicMode = rtPaidLicMode then
    ConfirmPaidSoftwareLicense_CRM(FUserLicInfo)

  else if FLicMode = rtEvalLicMode then
    ConfirmEvaluationSoftwareLicense_CRM(FUserLicInfo);
end;

procedure TCRMRegistration.ConfirmPaidSoftwareLicense_CRM(UserInfo: TCRMUserLicInfo);
var
  UserAWUID: String;
begin

  DoConfirmPaidSoftwareLicense_CRM(UserAWUID, UserInfo);

  case UserInfo.ReplyID of
    rsSubsRegisteredOK:
      begin
        lblCongrats.caption   := 'Congratulations';
        lblRegResult.caption  := 'Registration Completed Successfully';
        lblRegMsg.caption     := 'Click SAVE to save the information to your ClickFORMS license file. For assistance please call 800-622-8727 Opt 2 or email support@bradfordsoftware.com';
//hide this message
//        ShowAlert(atInfoAlert, 'Congratulations, your subscription to ClickFORMS has been confirmed. Enjoy.');
        btnSave.Enabled   := True;
        btnCancel.enabled := False;
        FRegSucceeded := True;              //registration succeeded
      end;

    rsSubsNotPurchased:
      begin
        lblCongrats.caption   := 'Registration Failed';
        lblRegResult.caption  := 'Subscription Not Purchased';
        lblRegMsg.caption     := 'To purchase a ClickFORMS subscription, please login into AppraisalWorld.com or contact your account representative at 800-622-8727. Thank you.';
        ShowAlert(atWarnAlert, 'Our records indicate that a ClickFORMS subscription has not been purchased. Please purchase a subscription to enjoy the benefits of ClickFORMS.');
        btnSave.Enabled   := True;
        btnCancel.enabled := True;
      end;

    rsSubsPeriodExpired:
      begin
        lblCongrats.caption   := 'Registration Failed';
        lblRegResult.caption  := 'Your Subscription has Expired';
        lblRegMsg.caption     := 'To renew your ClickFORMS subscription, please login into AppraisalWorld.com or contact your account representative at 800-622-8727. Thank you.';
        ShowAlert(atWarnAlert, 'Your ClickFORMS subscription has expired. Please renew your subscription to continue using ClickFORMS.');
        btnSave.Enabled   := True;
        btnCancel.enabled := True;
      end;

    rsDatabaseError,
    rsInputDataError,
    rsFailed2Connect:
      ShowAlert(atWarnAlert, UserInfo.ReplyMsg);
  else
    ShowAlert(atWarnAlert, UserInfo.ReplyMsg);
  end;
end;

procedure TCRMRegistration.ConfirmEvaluationSoftwareLicense_CRM(UserInfo: TCRMUserLicInfo);
var
  UserAWUID: String;
begin
  DoConfirmEvaluationSoftwareLicense_CRM(UserAWUID, UserInfo);

  case UserInfo.ReplyID of
    rsEvalRegisteredOK:
      begin
        lblCongrats.caption   := 'Congratulations';
        lblRegResult.caption  := 'Registration Completed Successfully';
        lblRegMsg.caption     := 'Click SAVE to save the information to your ClickFORMS license file. For assistance please call 800-622-8727 or email support@bradfordsoftware.com';
        FRegSucceeded := True;              //registration succeeded
        btnSave.Enabled := True; //allow eval user to save licensen fil
        ShowAlert(atInfoAlert, 'Congratulations, your evaluation license has been confirmed. Enjoy using ClickFORMS.');
      end;

    rsEvalPeriodExpired:      //msgClickFORMSEvalExpired
      begin
        lblCongrats.caption   := 'Registration Failed';
        lblRegResult.caption  := 'Your Evaluation Period has Expired';
        lblRegMsg.caption     := 'To purchase a ClickFORMS license, please login into AppraisalWorld.com or contact your account representative at 800-622-8727. Thank you.';
        ShowAlert(atWarnAlert, 'Your evaluation period has expired. We hope you enjoyed ClickFORMS and found it to be easy and intuitive. To continue usuig it, please purchase a subscription.');
      end;

    rsDatabaseError,
    rsInputDataError,
    rsFailed2Connect:
      ShowAlert(atWarnAlert, UserInfo.ReplyMsg);
  else
    ShowAlert(atWarnAlert, UserInfo.ReplyMsg);
  end;
end;

function TCRMRegistration.NoData(Str: String): Boolean;
begin
  result := length(Str)=0;
end;

function TCRMRegistration.ValidateLoginInfo: Boolean;
begin
  edtUserLoginEmail.text := Trim(edtUserLoginEmail.text);
  edtUserPassword.text := Trim(edtUserPassword.text);

  result := False;
  if not (length(edtUserLoginEmail.text) > 0) then
    ShowAlert(atWarnAlert, 'Please enter your AppraisalWorld login email address.')
  else if not ValidEmailAddress(edtUserLoginEmail.text) then
    ShowAlert(atWarnAlert, 'Please enter a valid email address')
  else if not (length(edtUserPassword.text) > 0) then
    ShowAlert(atWarnAlert, 'Please enter your AppraisalWorld password.')
  else
    result := True;
end;

function TCRMRegistration.ValidateIsAWMember: Boolean;
begin
  result := length(FUserLicInfo.AWUID) > 0;   //the user has a UID, but may not be vaild
end;

function TCRMRegistration.ValidatedContactInfo: Boolean;
begin
  result := True;

  if (NoData(edtName.text) or NoData(edtCompany.text) or NoData(edtAddress.text) or
     NoData(edtCity.text) or NoData(edtState.text) or NoData(edtZip.text)) then
    begin
      ShowNotice(msgNoContact);
      result := False;                  //Stop!
    end;

  if result and not ValidEmailAddress(edtEMail.text) then
    begin
      ShowAlert(atWarnAlert, 'Please enter a valid email address');
      result := False;                  //Stop!
    end;
end;

function TCRMRegistration.ValidateAppraisalCerts: Boolean;
begin
//###CHECK if we want to force this here
// probably force credentials in the default set
  result := True;
end;

function TCRMRegistration.ValidatedReportSigner: Boolean;
begin
  result := True;
  if NoData(edtLicName.text)  then
    begin
      ShowNotice(msgNeedLicName);
      result := False;                  //Stop
    end;

  if result and (NoData(edtLicCoName.text) {and reguired}) then
    begin
      ShowNotice(msgNeedLicCoName);
      result := False;                  //Stop
    end;
end;

function TCRMRegistration.ValidateUserSelected: Boolean;
var
  userFileName: String;
begin
  result := True;

  //load the selected user, (list in sync with LicensedUsers List)
  if UserRegList.Row > -1 then
    userFileName := TUser(LicensedUsers[UserRegList.Row-1]).FFileName;

  if length(userFileName)> 0 then
    begin
      if (FCurUser.UserFileName <> userFileName) then
        begin
          FCurUser.LoadUserLicFile(userFileName);
          LoadLicensedUser(FCurUser);
          result := True;
        end;
     end;
end;

procedure TCRMRegistration.LoadLicensedUser(User: TCRMLicensedUser);
var
  i: Integer;
begin
  FCurUser := User;   //rember who we are working with

  with User do
    begin
      //load in the contact info
      //AW Credentials
      edtUserLoginEmail.Text := AWUserInfo.UserLoginEmail;
      edtUserPassword.Text   := AWUserInfo.UserPassWord;
    end;
end;



end.
