unit UPrefFUserFHADigSignatures;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 2019 by Bradford Technologies, Inc. }

{ This preference unit is used to create the public & private keys for a user as}
{ well the digital certificate for each of the user's appraisal certs or licenses}


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, Grids, ExtCtrls,
  Ucontainer, ULicUser, Grids_ts, TSGrid, RzGrids, BaseGrid, AdvGrid,
  AdvCGrid;

type
  TFHADigitalSignatures = class(TFrame)
    Panel1: TPanel;
    btnCreateCert: TButton;
    LicUsersList: TAdvColumnGrid;
    btnRenewCert: TButton;
    StaticText1: TStaticText;
    procedure btnRenewCertClick(Sender: TObject);
    procedure btnCreateCertClick(Sender: TObject);
    //procedure btnImportCertificateClick(Sender: TObject);
   //procedure btnBackupCertificatesClick(Sender: TObject);
    procedure LicUsersListSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
  private
    FDoc: TContainer;
    FSelectedRow: Integer;
    procedure SetupLicUserList;
    procedure LoadUserList;
   // function CopyDigitalFiles(SourceDir,DestDir:String; var Counter: Integer):Boolean;
  public
    constructor CreateFrame(AOwner: TComponent; ADoc: TContainer);
    procedure ShowCertWindow;
  end;

implementation

uses
  UDigitalSignatureUtils, UStatus, UGlobals, UUtil1,UFileUtils,UMyClickForms,FileCtrl;


{$R *.dfm}


constructor TFHADigitalSignatures.CreateFrame(AOwner: TComponent; ADoc: TContainer);
begin
  inherited Create(AOwner);
  
  FDoc := ADoc;
end;

procedure TFHADigitalSignatures.ShowCertWindow;
begin
  Repaint;

  SetupLicUserList;

  LoadUserList;

  FSelectedRow := 1;
end;

procedure TFHADigitalSignatures.SetupLicUserList;
begin
  LicUsersList.HideColumn(5);     //this col carries the user lic file name
end;

procedure TFHADigitalSignatures.LoadUserList;
var
  i, ValidUserNum: Integer;
  userFileName: String;
  LicName, licST, licNo: String;
  AUser: TLicensedUser;
  DigitalMgr: TDigitalSignatureMgr;
begin
  ValidUserNum := 0;
  if assigned(LicensedUsers) then
    begin
      DigitalMgr := TDigitalSignatureMgr.Create;
      try
        for i := 0 to LicensedUsers.count-1 do
          begin
            userFileName := TUser(LicensedUsers.Items[i]).FFileName;
            AUser := TLicensedUser.create;
            try
              AUser.LoadUserLicFile(userFileName);

              LicName := AUser.SWLicenseName;
              licST   := '';
              licNo   := '';
              if AUser.WorkLic.Count > 0 then
                begin
                  licST := AUser.WorkLic.License[0].State;
                  licNo := AUser.WorkLic.License[0].Number;
                end;
              inc(ValidUserNum);
              if ValidUserNum > 1 then LicUsersList.AddRow;            //because we start w/1 empty row
              LicUsersList.Cells[0,ValidUserNum] := LicName;         //appraiser Lic name
              LicUsersList.Cells[1,ValidUserNum] := licST;           //state
              LicUsersList.Cells[2,ValidUserNum] := licNo;           //lic/cert number

              userFileName := GetNameOnly(userFileName);    //remove the extension
              LicUsersList.Cells[5,ValidUserNum] := userFileName;    //name used for files (.lic, .pem)

              //now find the cert belonging to this user
              //DigitalMgr.InitDigitalMgr;
              DigitalMgr.SetupDigitalMgr(LicName, licST, licNo, userFileName);  //note userFileNmae cannot have extension

              DigitalMgr.GetDigitalCertInfo;
              //LicUsersList.Cells[3,ValidUserNum] := DigitalMgr.UserCertNumber;
              LicUsersList.Cells[3,ValidUserNum] := DigitalMgr.UserCertExpDate;
            finally
              AUser.Free;
            end;
          end;
      finally
        DigitalMgr.Free;
      end;
    end;
end;

procedure TFHADigitalSignatures.btnCreateCertClick(Sender: TObject);
var
  errMsg: String;
  LicName, licST, licNo, licFName: String;
  DigitalMgr: TDigitalSignatureMgr;
begin
  LicName   := LicUsersList.Cells[0,FSelectedRow];     //appraiser Lic name
  licST     := LicUsersList.Cells[1,FSelectedRow];     //state
  licNo     := LicUsersList.Cells[2,FSelectedRow];     //lic/cert number
  licFName  := LicUsersList.Cells[5,FSelectedRow];     //name used for files (.lic, .pem)

  DigitalMgr := TDigitalSignatureMgr.Create;
  try
    DigitalMgr.InitDigitalMgr;
    DigitalMgr.SetupDigitalMgr(LicName, licST, licNo, licFName);
    if DigitalMgr.CreateCertificate(errMsg) then  //this is also saving it
      begin //show results
        //LicUsersList.Cells[3,FSelectedRow] := DigitalMgr.UserCertNumber;
        LicUsersList.Cells[3,FSelectedRow] := DigitalMgr.UserCertExpDate;

        ShowNotice('Your Digital Certificate has been created. It is valid for five years.');
      end
    else
      ShowNotice(errMsg);
  finally
    DigitalMgr.Free;
    ShowCertWindow;
  end;
end;

procedure TFHADigitalSignatures.btnRenewCertClick(Sender: TObject);
var
  errMsg: String;
  LicName, licST, licNo, licFName: String;
  DigitalMgr: TDigitalSignatureMgr;
begin
  LicName   := LicUsersList.Cells[0,FSelectedRow];     //appraiser Lic name
  licST     := LicUsersList.Cells[1,FSelectedRow];     //state
  licNo     := LicUsersList.Cells[2,FSelectedRow];     //lic/cert number
  licFName  := LicUsersList.Cells[5,FSelectedRow];     //name used for files (.lic, .pem)

  DigitalMgr := TDigitalSignatureMgr.Create;
  try
    //DigitalMgr.InitDigitalMgr;
    DigitalMgr.SetupDigitalMgr(LicName, licST, licNo, licFName);
    if DigitalMgr.ReNewCertificate(errMsg) then   //this is also saving it
      begin
        //LicUsersList.Cells[3,FSelectedRow] := DigitalMgr.UserCertNumber;
        LicUsersList.Cells[3,FSelectedRow] := DigitalMgr.UserCertExpDate;

        ShowNotice('Your Digital Certificate has been renewed for another five years.');
      end
    else
      ShowNotice(errMsg);
  finally
    DigitalMgr.Free;
    ShowCertWindow;
  end;
end;

{procedure TFHADigitalSignatures.btnImportCertificateClick(Sender: TObject);
var
  aMsg, SourceDir, DestDir: String;
  counter: Integer;
begin
  DestDir := appPref_DirLicenses;
  SourceDir := DestDir; //initial folder
  if SelectDirectory('Please select the folder to restore your certificate files from','', SourceDir) then
    if  CopyDigitalFiles(SourceDir, DestDir, counter) then
      begin
        aMsg := Format(IntToStr(counter) + ' Digital Signature files were restored from %s successfully.',[DestDir]);
        ShowNotice(aMsg);
      end;
end;


procedure TFHADigitalSignatures.btnBackupCertificatesClick(Sender: TObject);
var
  aMsg, SourceDir, DestDir: String;
  counter: Integer;
begin
  SourceDir := appPref_DirLicenses;  //Source folder is \user license folder
  DestDir := SourceDir;  //initial folder
  if SelectDirectory('Please select the folder to backup your certificate files to','', DestDir) then
    if CopyDigitalFiles(appPref_DirLicenses, DestDir, counter) then
      begin
        aMsg := Format(IntToStr(counter) + ' Digital Signature files were backed up to %s successfully.',[DestDir]);
        ShowNotice(aMsg);
      end;
end;

function TFHADigitalSignatures.CopyDigitalFiles(SourceDir, DestDir: String; var counter: Integer): Boolean;
var
   f: TSearchRec;
   sourceFile, DestFile, Ext: String;
begin
  //transfer all the user digital files (*.pem) files

  result := False;
  FileMode :=0;
  counter := 0;
  if FindFirst(SourceDir + '\*.*', faAnyFile,f) = 0 then
    repeat
       try
         SourceFile := IncludeTrailingPathDelimiter(SourceDir) + f.Name;
         Ext := ExtractFileExt(SourceFile);
         if compareText(Ext, '.pem') = 0 then   //copy only digital signature files (*.pem) file
            begin
              DestFile := IncludeTrailingPathDelimiter(DestDir) + f.Name;
              CopyFile(PChar(SourceFile), PChar(DestFile), false);
              counter := counter + 1;
            end;
         result := True;
       except
        on e: exception do
          ShowNotice(E.Message);
       end;
    until findNext(f) <> 0;
end;           }

procedure TFHADigitalSignatures.LicUsersListSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
begin
  FSelectedRow := ARow;

  btnCreateCert.Caption := 'Create Certificate for ' + LicUsersList.Cells[0,FSelectedRow];
  btnRenewCert.Caption  := 'Renew Certificate for ' + LicUsersList.Cells[0,FSelectedRow];

  CanSelect := True;
end;

end.
