unit ULicRegStudent;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RegistrationService, RzBckgnd, UForms;

type
  TRegStudentActCode = class(TAdvancedForm)
    Label1: TLabel;
    edtActCode1: TEdit;
    edtActCode2: TEdit;
    edtActCode3: TEdit;
    edtActCode4: TEdit;
    btnGetActCode: TButton;
    btnRegister: TButton;
    btnCancel: TButton;
    Label2: TLabel;
    Label3: TLabel;
    lblEmail: TLabel;
    RzSeparator1: TRzSeparator;
    procedure btnRegisterClick(Sender: TObject);
    procedure btnCancelClk(Sender: TObject);
    procedure btnGetActCodeClk(Sender: TObject);
    procedure edtKeyUpFld1(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtKeyUpFld2(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtKeyUpFld3(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtKeyPress(Sender: TObject; var Key: Char);
    procedure edtKeyUpFld4(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure OnFormCreate(Sender: TObject);
  private
    function PreValidateActCode: Boolean;
    procedure SaveULicenseInfo(custSN, actCode: String);
    procedure SetEmailAddress(const Value: String);
  public
    StudInfo: StudentRequest;
    bRegistered: Boolean;
    property EmailAddress: String write SetEmailAddress;
  end;

var
  RegStudentActCode: TRegStudentActCode;

implementation

uses
  XSBuiltIns, UStatus, UUtil3, ULicUser, UStrings, UWebConfig, UWebUtils;

{$R *.dfm}



procedure TRegStudentActCode.btnRegisterClick(Sender: TObject);
var
  custSN: WideString;
  actCode: WideString;
  toDayDate, expDate: TXSDateTime;
  retCode: Integer;
begin
  if not PreValidateActCode then
    begin
      ShowAlert(atWarnAlert, 'You have entered an invaild Activation Code.');
      exit;
    end;
  actCode := edtActCode1.Text + edtActCode2.Text + edtActCode3.Text + edtActCode4.Text;
  toDayDate := TXSDateTime.Create;
  expDate := TXSDateTime.Create;
  try
    if IsConnectedToWeb then
      begin
        try
          with GetRegistrationServiceSoap(True,GetURLForStudentReg) do
            ValidateActivationCode(studInfo,actCode,WSStudent_Registration,retCode,custSN,expDate,toDayDate);
        except
          on e: exception do
            begin
              ShowNotice(FriendlyErrorMsg(e.message));
              exit
            end;
        end;
        case retCode of
          0:  begin
              SaveULicenseInfo(custSN,actCode);
              ShowNotice('Thank you '+ CurrentUser.GreetingName + msgThxStudentRegister);
              bRegistered := True;
              Close;
            end;
          4: ShowAlert(atWarnAlert, 'You have entered an invalid Activation Code.');
          3:  begin
              ShowNotice('Your Student Version of ClickFORMS has expired.');
              Close;
            end;
          else
            begin
              ShowAlert(atWarnAlert, 'Unknown error (# ' + IntToStr(retCode) + ') on the Web Service!' + #13#10 + 'Please try again later.');
              Close;
            end;
        end;
      end
    else
      ShowNotice('ClickFORMS could not connect to the Server. Please make sure you are connected to internet and your firewall is not blocking ClickFORMS to access the Internet.');
  finally
    toDayDate.Free;
    expDate.Free;
  end;
end;

procedure TRegStudentActCode.btnCancelClk(Sender: TObject);
begin
  Close;
end;

procedure TRegStudentActCode.btnGetActCodeClk(Sender: TObject);
var
  retCode: Integer;
begin
  try
    if IsConnectedToWeb then
      begin
        try
          with GetRegistrationServiceSoap(True,GetURLForStudentReg) do
            retCode := RequestActivationCode(studInfo,WSStudent_Registration);
        except
          on e: exception do
            begin
              ShowNotice(FriendlyErrorMsg(e.message));
              exit
            end;
        end;    
        case retCode of
          0: ShowNotice('You will receive your activation code by email shortly.');
          3: ShowAlert(atWarnAlert, 'Your Student Version of ClickForms has expired and can no longer be used.');
        else
          ShowNotice('Unknown error (# ' + IntToStr(retCode) + ') on the Web Service has occured.' + #13#10 + 'Please try again later.');
        end;
      end
    else
      ShowNotice('ClickFORMS could not connect to the Server. Please make sure you are connected to internet and your firewall is not blocking ClickFORMS to access the Internet.');
  finally
    Close;
  end;
end;

procedure TRegStudentActCode.edtKeyUpFld1(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if length(TEdit(Sender).Text) = 4 then
    ActiveControl := edtActCode2;
end;

procedure TRegStudentActCode.edtKeyUpFld2(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if length(TEdit(Sender).Text) = 4 then
    ActiveControl := edtActCode3;
end;

procedure TRegStudentActCode.edtKeyUpFld3(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if length(TEdit(Sender).Text) = 4 then
    ActiveControl := edtActCode4;
end;

procedure TRegStudentActCode.edtKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key in ['a' .. 'z'] then
    Key := char(ord(key) - 32);
end;

procedure TRegStudentActCode.edtKeyUpFld4(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if length(TEdit(Sender).Text) = 4 then
    ActiveControl := edtActCode1;
end;

function TRegStudentActCode.PreValidateActCode: Boolean;
const
  validChars: Set of Char = ['0'..'9','A'..'F'];  //heximal chars
var
  actCode: String;
  chr: Integer;
begin
  result := False;
  if (length(edtActCode1.Text) <> 4) or (length(edtActCode2.Text) <> 4) or
      (length(edtActCode3.Text) <> 4) or (length(edtActCode4.Text) <> 4) then
    exit;
  actCode := edtActCode1.Text + edtActCode2.Text + edtActCode3.Text + edtActCode4.Text;
  for chr := 1 to length(actCode) do
    if  not (actCode[chr] in validChars) then
      exit;
  result := True;
end;


procedure TRegStudentActCode.OnFormCreate(Sender: TObject);
begin
  with CurrentUser.LicInfo do
    if length(UserCustID) > 0 then
      begin
        edtActCode1.Text := IntToHex(Extra[1],4);
        edtActCode2.Text := IntToHex(Extra[2],4);
        edtActCode3.Text := IntToHex(Extra[3],4);
        edtActCode4.Text := IntToHex(Extra[4],4);
      end;
  bRegistered := False;
end;

procedure TRegStudentActCode.SaveULicenseInfo(custSN, actCode: String);
var
  curInt: Integer;
  prod: Integer;
  curPid: Integer;
begin
  with CurrentUser do
    with LicInfo do     //we already saved User Info
      begin
        FLicName := UserInfo.FName;
        FLicCoName := UserInfo.FCompany;
        FLicLockedCo := True;
        FSerialNo1 := Copy(custSN,1,5);
        FSerialNo2 := Copy(custSN,6,5);
        FSerialNo3 := Copy(custSN,11,5);
        FSerialNo4 := Copy(custSN,16,5);
        if TryStrToInt('$' + Copy(actCode,1,4),curInt) then
          Extra[1] := curInt
        else
          exit;
        if TryStrToInt('$' + Copy(actCode,5,4),curInt) then
          Extra[2] := curInt
        else
          exit;
        if TryStrToInt('$' + Copy(actCode,9,4),curInt) then
          Extra[3] := curInt
        else
          exit;
        if TryStrToInt('$' + Copy(actCode,13,4),curInt) then
          Extra[4] := curInt
        else
          exit;
        FRegistNo := CalcUserRegNumber;
        for prod := 1 to ProdLicenses.count do
          begin
            curPid := TProdLic(ProdLicenses[prod - 1]).FProdID;
            if (curPid = pidCF[pidOnlineLocMaps]) or (curPid = pidCF[pidOnlineFloodMaps]) then
              TProdLic(ProdLicenses[prod - 1]).UnlockProduct(FRegistNo);
          end;
        SaveUserLicFile;
      end;
end;

procedure TRegStudentActCode.SetEmailAddress(const Value: String);
begin
  lblEmail.Caption := Value;
end;

end.

