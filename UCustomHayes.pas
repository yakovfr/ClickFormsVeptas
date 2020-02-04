unit UCustomHayes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,ComCtrls,IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdFTPCommon, IdFTP, IdExplicitTLSClientServerBase,
  UContainer, UForms;

type
  TCustomHayes = class(TAdvancedForm)
    rdoSendOption1: TRadioButton;
    rdoSendOption2: TRadioButton;
    btnSend: TButton;
    btnCancel: TButton;
    FTPClient: TIdFTP;
    ProgressBar: TProgressBar;
    ProgressLabel: TLabel;
    procedure btnSendClick(Sender: TObject);
  private
    FMode: Integer;
    FDoc: TContainer;
    FFolder1: String;
    FFolder2: String;
    FFolder3: String;
    FFileName1: String;
    FFileName2: String;
    FFileName3: String;
    FUser: String;
    FPsw: String;
    FHost: String;
    FDocID: String;         //file number
  public
    procedure GetFTPServerInfo;
    procedure GetDocID;
    function GetAcctInfo: TStream;
    function GetOrderInfo: TStream;
    function GetPercentValueStr(Percent: String): String;
    procedure TransferFiles;
  end;


  procedure SendToHayes(doc: TContainer);

var
  CustomHayes: TCustomHayes;

implementation

{$R *.dfm}

uses
  IniFiles,
  UGlobals, UUtil1, UForm, UStatus;

const
  TabChar = #9;
  CRChar  = #13;
  LFChar  = #10;

type
  ESendError = class(Exception);



procedure SendToHayes(doc: TContainer);
var
  Hayes: TCustomHayes;
begin
  Hayes := TCustomHayes.Create(nil);
  try
    Hayes.FMode := 0; //sending mode
    Hayes.FDoc := doc;
    if assigned(doc) then doc.save;              //make sure we have a file
    Hayes.rdoSendOption1.Checked := True;        //set default
    Hayes.ShowModal;
  finally
    Hayes.Free;
  end;
end;

procedure TCustomHayes.TransferFiles;
var
  dataStream: TStream;
begin
  try
    GetDocID;                          //get the report file number
    GetFTPServerInfo;                  //get the connection info
    FTPClient.Host := FHost;
    FTPClient.Username := FUser;
    FTPClient.Password := FPsw;
    FTPClient.AutoLogin := true;
    FTPClient.Connect;                 //open

    if rdoSendOption1.Checked then
      begin
        ProgressBar.Position := 10;
        dataStream :=GetOrderInfo;
        FTPCLient.ChangeDir(FFolder1);
        FTPClient.TransferType := ftASCII;
        FTPClient.Put(dataStream, FFileName1, True);
        dataStream.Free;
        ProgressLabel.Caption := 'Completed';
        ProgressBar.Position := 100;
      end
    else
      begin
        if not FileExists(FDoc.docFullPath) then
          raise ESendError.Create('Please save the report before sending.');

        ProgressBar.Position := 10;
        dataStream := GetAcctInfo;
        FTPCLient.ChangeDir(FFolder2);
        FTPClient.TransferType := ftASCII;
        FTPClient.Put(dataStream, FFileName2, True);
        dataStream.Free;
        ProgressBar.Position := 100;

        ProgressLabel.Caption := 'Report';
        ProgressBar.Position := 10;
        //now ftp the report file
        FTPCLient.ChangeDirUp;
        FTPCLient.ChangeDirUp;
        FTPCLient.ChangeDir(FFolder3);
        FTPClient.TransferType := ftBinary;
        FFileName3 := FDocID + '.clk';
        FTPClient.Put(FDoc.docFullPath, FFileName3, False);
        ProgressLabel.Caption := 'Completed';
        ProgressBar.Position := 100;
      end;
  except
    on E: Exception do
      begin
        ShowNotice(E.Message);
      end;
  end;
  FTPClient.Quit;           //close

  btnSend.Caption := 'Ok';
  FMode := 1;   //complete mode
end;

procedure TCustomHayes.GetFTPServerInfo;
var
  customEMail: TIniFile;
begin
  if Length(appPref_CustomEmailPath) > 0 then    //we have a custom email
    begin
      customEMail := TIniFile.Create(appPref_CustomEmailPath);  //create the INI reader
      try
        FFolder1 := customEMail.ReadString('CustomSendTo','Folder1', '');
        FFolder2 := customEMail.ReadString('CustomSendTo','Folder2', '');
        FFolder3 := customEMail.ReadString('CustomSendTo','Folder3', '');

        FFileName1 := customEMail.ReadString('CustomSendTo','FileName1', '');
        FFileName2 := customEMail.ReadString('CustomSendTo','FileName2', '');
        FFileName3 := customEMail.ReadString('CustomSendTo','FileName3', '');

        FUser := customEMail.ReadString('CustomSendTo','User', '');
        FPsw := customEMail.ReadString('CustomSendTo','PSW', '');
        FHost := customEMail.ReadString('CustomSendTo','HOST', '');
      finally
        customEMail.Free;
      end;
    end;

  if (length(FUser)=0) or (length(FPsw)=0) or (length(FHost)=0) then
    raise ESendError.Create('Some of the connection info is blank. Will not be able to connect.');
end;

procedure TCustomHayes.GetDocID;
begin
  if FDoc <> nil then
    FDocID := FDoc.GetCellTextByID(2);
  if length(FDocID)=0 then
    raise ESendError.Create('This report does not have a file number.');
end;

//converts string percent in to string of value percent 20% = 0.20
function TCustomHayes.GetPercentValueStr(Percent: String): String;
var
  PValue: Double;
begin
  result := '';
  if length(Percent)>0 then
    if IsValidNumber(Percent, PValue) then
      result := FloatToStrF(PValue/100.0, ffFixed, 15, 5)
    else
      raise ESendError.Create('The fee split is not a valid number');
end;

//This info will be go to the Incoming Acct folder
function TCustomHayes.GetAcctInfo: TStream;
var
  dForm: TDocForm;
  dataStr, feeSplit: String;
  dataStrLen: Integer;
  dataStream: TMemoryStream;
begin
  dForm := FDoc.GetFormByOccurance(709,0,False);
  dataStr := '';
  try
    dataStr := dForm.GetCellText(1,1) + TabChar;    //file no
    dataStr := dataStr + dForm.GetCellText(1,4) + TabChar;    //borrower
    dataStr := dataStr + dForm.GetCellText(1,5) + TabChar;    //address
    dataStr := dataStr + dForm.GetCellText(1,6) + TabChar;    //unit no
    dataStr := dataStr + dForm.GetCellText(1,7) + TabChar;    //city
    dataStr := dataStr + dForm.GetCellText(1,8) + TabChar;    //state
    dataStr := dataStr + dForm.GetCellText(1,9) + TabChar;    //zip code
    dataStr := dataStr + dForm.GetCellText(1,30) + TabChar;    //lender ID
    dataStr := dataStr + dForm.GetCellText(1,29) + TabChar;    //lender company
    dataStr := dataStr + dForm.GetCellText(1,28) + TabChar;    //loan No
    dataStr := dataStr + dForm.GetCellText(1,26) + TabChar;    //lender first name
    dataStr := dataStr + dForm.GetCellText(1,27) + TabChar;    //lender last name
    dataStr := dataStr + dForm.GetCellText(1,74) + TabChar;    //invoice item 1
    dataStr := dataStr + dForm.GetCellText(1,75) + TabChar;    //invoice amt 1
    dataStr := dataStr + dForm.GetCellText(1,76) + TabChar;    //invoice item 2
    dataStr := dataStr + dForm.GetCellText(1,77) + TabChar;    //invoice amt 2
    dataStr := dataStr + dForm.GetCellText(1,78) + TabChar;    //invoice item 3
    dataStr := dataStr + dForm.GetCellText(1,79) + TabChar;    //invoice amt 3
    dataStr := dataStr + dForm.GetCellText(1,91) + TabChar;    //tax amt
    dataStr := dataStr + dForm.GetCellText(1,93) + TabChar;    //appraiser ID

    feeSplit := GetPercentValueStr(dForm.GetCellText(1,95));
    dataStr := dataStr +feeSplit + TabChar;                    //appraiser fee split ### div 100
    dataStr := dataStr + dForm.GetCellText(1,97) + TabChar;    //supervisor ID

    feeSplit := GetPercentValueStr(dForm.GetCellText(1,99));
    dataStr := dataStr + feeSplit + TabChar;                   //supervisor fee split
    dataStr := dataStr + dForm.GetCellText(1,101) + TabChar;   //assistant ID

    feeSplit := GetPercentValueStr(dForm.GetCellText(1,103));
    dataStr := dataStr + feeSplit + TabChar;                   //assistant fee split
    dataStr := dataStr + dForm.GetCellText(1,105) + TabChar;   //comment 1
    dataStr := dataStr + dForm.GetCellText(1,106) + TabChar;   //comment 2
    dataStr := dataStr + dForm.GetCellText(1,107) + CRChar + LFChar;   //comment 3

    dataStream := TMemoryStream.Create;
    dataStrLen := length(dataStr);
    dataStream.WriteBuffer(Pointer(dataStr)^, dataStrLen);    //write the text
    dataStream.Position := 0;   //rewind
    result := dataStream;
  except
    raise ESendError.Create('Could not gather the accounting data. Make sure you have the correct form and the fee splits are numbers.');
  end;
end;

//This info will go to the Incoming QuickStart folder
function TCustomHayes.GetOrderInfo: TStream;
var
  dForm: TDocForm;
  dataStr: String;
  dataStrLen: Integer;
  dataStream: TMemoryStream;
begin
  dForm := FDoc.GetFormByOccurance(709,0,False);  //occur is zero based
  try
    dataStr := dForm.GetCellText(1,1) + TabChar;    //file no
    dataStr := dataStr + dForm.GetCellText(1,4) + TabChar;    //borrower
    dataStr := dataStr + dForm.GetCellText(1,5) + TabChar;    //address
    dataStr := dataStr + dForm.GetCellText(1,6) + TabChar;    //unit no
    dataStr := dataStr + dForm.GetCellText(1,7) + TabChar;    //city
    dataStr := dataStr + dForm.GetCellText(1,8) + TabChar;    //state
    dataStr := dataStr + dForm.GetCellText(1,9) + TabChar;    //zip code
    dataStr := dataStr + dForm.GetCellText(1,18) + TabChar;   //county
    dataStr := dataStr + dForm.GetCellText(1,26) + TabChar;    //lender first name
    dataStr := dataStr + dForm.GetCellText(1,27) + TabChar;    //lender last name
    dataStr := dataStr + dForm.GetCellText(1,30) + TabChar;    //lender ID
    dataStr := dataStr + dForm.GetCellText(1,29) + TabChar;    //lender company
    dataStr := dataStr + dForm.GetCellText(1,31) + TabChar;    //lender address
    dataStr := dataStr + dForm.GetCellText(1,32) + TabChar;    //lender city
    dataStr := dataStr + dForm.GetCellText(1,33) + TabChar;    //lender state
    dataStr := dataStr + dForm.GetCellText(1,34) + TabChar;    //lender zip
    dataStr := dataStr + dForm.GetCellText(1,35) + TabChar;    //lender phone
    dataStr := dataStr + dForm.GetCellText(1,36) + TabChar;    //lender fax
    dataStr := dataStr + dForm.GetCellText(1,37) + TabChar;    //lender email
    dataStr := dataStr + dForm.GetCellText(1,28) + TabChar;    //loan No
    dataStr := dataStr + dForm.GetCellText(1,38) + TabChar;    //appraiser name
    dataStr := dataStr + dForm.GetCellText(1,66) + TabChar;    //effective date
    dataStr := dataStr + dForm.GetCellText(1,69) + CRChar + LFChar;    //order date

    dataStream := TMemoryStream.Create;
    dataStrLen := length(dataStr);
    dataStream.WriteBuffer(Pointer(dataStr)^, dataStrLen);    //write the text
    dataStream.Position := 0;   //rewind
    result := dataStream;
  except
    raise ESendError.Create('Could not gather the order data. Make sure you have the correct form.');
  end;
end;

procedure TCustomHayes.btnSendClick(Sender: TObject);
begin
  if FMode = 0 then
    TransferFiles
  else
    ModalResult := mrOk;
end;

end.
