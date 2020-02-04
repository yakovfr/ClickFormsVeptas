unit UDriveHQ;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2006 by Bradford Technologies, Inc. }

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}


interface


uses
  Registry, SysUtils, Variants, Classes, Windows, Controls;


const DEFAULT_TASK_NAME       = 'defaultCFBackupTask';
const DEFAULT_LIC_TASK_NAME   = 'defaultCFLicBackupTask';

const FILECENTER_REG_LOC      = 'Software\Bradford\ClickForms2\FileCenter';
const DRIVEHQ_FILEMANAGER_KEY = 'Software\File Center\FileManager';
const DRIVEHQ_WWWBACKUP_KEY   = 'Software\File Center\Backup';
const DRIVEHQ_TARGET_FOLDER   = '\FileCenterData\File Center Backup\Data\' + DEFAULT_TASK_NAME;

const PARAM_ADD_FILE          = 'Param_new.ini';
const PARAM_DEL_FILE          = 'Param_del.ini';
const PARAM_LIST_FILE         = 'Param_getlist.ini';

const PARAM_ADD_LIC_FILE      = 'Param_Lic_new.ini';
const PARAM_DEL_LIC_FILE      = 'Param_Lic_del.ini';

const PARAM_RESULT_FILE_ADD   = 'createBackupResult.ini';
const PARAM_RESULT_FILE_DEL   = 'deleteBackupResult.ini';
const PARAM_RESULT_FILE_LIST  = 'listBackupTasks.ini';


const errCannotRunFileManager = 'Cannot run the File Manager. Please check %s.';
const errCannotRunBackup      = 'Cannot run the WWWBackup. Please check %s.';
const errEmptyPath            = 'ClickFORMS could not read the %s file path in registry.';
const errFileNotExists        = 'ClickFORMS was unable to find %s on your system.';
const errNotConnectedToWeb    = 'Could not connect to Server. Check your internet connection.';
const errException            = 'ClickFORMS encountered an unknown exception. ' +#13#10+ '%s';

//I don't think this will ever get called.
const errTaskExists           = 'ClickFORMS Default Backup Task already exists and some files may'+ #10
                               +'have already been backed up to the FileCenter.'+#13#10 + #13#10
                               +'Please make sure you have restored all necessary files from the'+ #10
                               +'FileCenter then delete the task named "'+ DEFAULT_TASK_NAME +'"'+ #10
                               +'from FileCenter Backup and try again.';

type
  TDriveHQ = class(TObject)
  private
    function GetFileManagerPath : string;
    function GetWWWBackupPath: string;
    //function CheckDriveHQSubscription(Out sMsg:widestring): Integer;
    procedure SetIsDefaultBackupTasksCreated;
    function CreateAddTaskINIFile(sFilePath: String): Boolean;
    function CreateGetListINIFile(sFilePath: String): Boolean;
    function IsDefaultBackupExists(sFilePath: String): Boolean;
    function CreateDefaultBackupTask: Boolean;
    //procedure InstallBackupDefaultTaskFirstTime;
  published
    function LaunchFileManager: boolean;
    function LaunchWWWbackup(sParams: string): boolean;
end;

//these functions are used from outside this unit
procedure LaunchFCBackup;
procedure LaunchDefaultFCBackupTaskCreator;
procedure LaunchDefaultFCBackupTaskReCreator;
procedure LaunchFCFileManager;

function IsDefaultBackupTasksCreated: Boolean;
function IsFileCenterBackupInstalled: Boolean;
function IsFileCenterFileManagerInstalled: Boolean;



implementation

uses ULicUser,UMyClickForms, UGlobals, UWebUtils, DriveHQService, UWebConfig, UStatus, uMain;

//launches file center backup only
procedure LaunchFCBackup;
var
  tempDHQ: TDriveHQ;
begin
  if not IsFileCenterBackupInstalled then
    ShowNotice('You need to purchase and install the Online File Center Backup module before it can be used.' +#13#10 + #13#10+
               'Please contact your Account Manager at 1-800-622-8727 for more information on File Center and how to purchase it.')
  else begin
    tempDHQ := TDriveHQ.Create;
    try
      try
        tempDHQ.LaunchWWWbackup('');
      except
        on E: Exception do ShowNotice(e.Message);
      end;
    finally
      tempDHQ.Free;
    end;
  end;
end;

//creates the default backup tasks
//This is not called anymore - Task is created at first launch of Backup Mgr
procedure LaunchDefaultFCBackupTaskCreator;
var
  tempDHQ: TDriveHQ;
begin
  if not IsFileCenterBackupInstalled then //the menu is disabled so no one should see this message
    ShowNotice('You need to purchase and install the Online File Center Backup module before you can set the default backup task.' +#13#10 + #13#10+
               'Please contact your Account Manager at 1-800-622-8727 for more information on File Center and how to purchase it.')

  else begin
    tempDHQ := TDriveHQ.Create;
    try
      try
        tempDHQ.CreateDefaultBackupTask;
      except
        on E: Exception do ShowNotice(e.Message);
      end;
    finally
      tempDHQ.Free;
    end;
  end;
end;

//recreates the default backup tasks
procedure LaunchDefaultFCBackupTaskReCreator;
var
  tempDHQ: TDriveHQ;
begin
  if not IsFileCenterBackupInstalled then //the menu is disabled so no one should see this message
    ShowNotice('You need to purchase and install the Online File Center Backup module before you can reset the default backup task.' +#13#10 + #13#10+
               'Please contact your Account Manager at 1-800-622-8727 for more information on File Center and how to purchase it.')
  else begin
    tempDHQ := TDriveHQ.Create;
    try
      try
         tempDHQ.CreateDefaultBackupTask;
      except
        on E: Exception do ShowNotice(e.Message);
      end;
    finally
      tempDHQ.Free;
    end;
  end;
end;

// launches file manager from outside to open and save files on file center
procedure LaunchFCFileManager;
var
  tempDHQ: TDriveHQ;
begin
  if not IsFileCenterFileManagerInstalled then
    ShowNotice('You need to purchase and install the Online File Center module before you can use it.' +#13#10 + #13#10+
               'Please contact your Account Manager at 1-800-622-8727 for more information on File Center and how to purchase it.')
  else begin
    tempDHQ := TDriveHQ.Create;
    try
      try
        tempDHQ.LaunchFileManager();
      except
        on E: Exception do ShowNotice(e.Message);
      end;
    finally
      tempDHQ.Free;
    end;
  end;
end;

//checks the drivehq subscription sever for user's eligibility to use file center applicaitons
{
function TDriveHQ.CheckDriveHQSubscription(Out sMsg:widestring): integer;
var
  iMsgCode, iCurCustID: integer;
begin
  try
    if not IsConnectedToWeb then
    begin
      Result := 4;
      Exit;
    end;

    iCurCustID := StrToIntDef(CurrentUser.LicInfo.UserCustID,0);

    with GetDriveHQServiceSoap(TRUE, GetURLForDriveHQ) do
    begin
      CanCusotmerUseDriveHQ(iCurCustID, WSDriveHQ_Password, sMsg, iMsgCode);
      Result := iMsgCode;
    end;
  except
    Result := 6;
  end;
end;
}


////////////////////////////////////////////////////////////////////////////////
// gets the path for Drive HQ File Manager from registry
//
////////////////////////////////////////////////////////////////////////////////

function TDriveHQ.CreateAddTaskINIFile(sFilePath: String): Boolean;
var
    FAdd: TextFile;
begin
  if FileExists(pAnsiChar(sFilePath))then
  begin
    DeleteFile(pAnsiChar(sFilePath));
    DeleteFile(pAnsiChar(IncludeTrailingBackslash(UMyClickForms.MyFolderPrefs.PreferencesDir) + PARAM_RESULT_FILE_ADD));
  end;

  AssignFile(FAdd, sFilePath);
  try

    //-------------------------Start of param_add.ini----------------//
    //create the Add ini file
    Rewrite(FAdd);

    WriteLn(FAdd, '[CommonParam]');
    WriteLn(FAdd, 'mainparam = createBackup');
    WriteLn(FAdd, '');

    WriteLn(FAdd, 'ReceiveResultWndName = "Main"');
    WriteLn(FAdd, '; After wwwbackup process the command, it will send a message to this window. Please make sure there is only one window have this name.');
    WriteLn(FAdd, ';WM_WWWBACKUP_CMD = WM_USER +1000');
    WriteLn(FAdd, '');

    //get the myclickforms\drivehq folder
    WriteLn(FAdd, 'ResultFile =' + IncludeTrailingBackslash(UMyClickForms.MyFolderPrefs.PreferencesDir) + PARAM_RESULT_FILE_ADD);
    WriteLn(FAdd, '; some information returned by wwwbackup.');
    WriteLn(FAdd, '');

    WriteLn(FAdd, '[Params]');
    WriteLn(FAdd, 'TaskName = ' + DEFAULT_TASK_NAME);  //build a unique taskname
    WriteLn(FAdd, '');
    WriteLn(FAdd, 'TaskType = 0');
    WriteLn(FAdd, ';0:real time backup, 1: daily schedule backup, 2:weekly schedule backup, 3: one time backup schedule.');
    WriteLn(FAdd, '');
    //get the CF registry values and build these lines
    WriteLn(FAdd, 'CountofPath = 7 ;count of folder or files to be backed up. Please note the files and folders should be in the same top folder.');
    WriteLn(FAdd, 'Path1 = ' + UMyClickForms.MyFolderPrefs.DatabasesDir);
    WriteLn(FAdd, 'Path2 = ' + UMyClickForms.MyFolderPrefs.ListsDir);
    WriteLn(FAdd, 'Path3 = ' + UMyClickForms.MyFolderPrefs.LogoDir);
    WriteLn(FAdd, 'Path4 = ' + UMyClickForms.MyFolderPrefs.PreferencesDir);
    WriteLn(FAdd, 'Path5 = ' + UMyClickForms.MyFolderPrefs.ReportsDir);
    WriteLn(FAdd, 'Path6 = ' + UMyClickForms.MyFolderPrefs.ResponsesDir);
    WriteLn(FAdd, 'Path7 = ' + UMyClickForms.MyFolderPrefs.TemplatesDir);
    //WriteLn(F, 'Path8 = ' + appPref_DirLicenses);
    WriteLn(FAdd, '');

    WriteLn(FAdd, 'ScheduleTime =' + FormatDateTime('mm/dd/yyyy hh:mm:ss',now())); //06/21/2006 14:30:00 ;the next backup time scheduled.valid for schedule backup.';
    WriteLn(FAdd, ';the next backup time scheduled.valid for schedule backup.');
    WriteLn(FAdd, '');

    WriteLn(FAdd, ';the following param are optional.');
    WriteLn(FAdd, 'TaskDescription = Default ClickFORMS Backup Task');
    WriteLn(FAdd, ';can be null');
    WriteLn(FAdd, '');

    WriteLn(FAdd, 'EncryptionMode = 0');
    WriteLn(FAdd, ';0: not in encryption mode, 1: yes.');
    WriteLn(FAdd, '');

    WriteLn(FAdd, 'TargetFolder = ' + DRIVEHQ_TARGET_FOLDER);
    WriteLn(FAdd, '; Wwwbackup will create it automatically in default.');
    WriteLn(FAdd, '');

    WriteLn(FAdd, 'FilterExt =');
    WriteLn(FAdd, '');

    WriteLn(FAdd, ';valid from to');
    WriteLn(FAdd, 'Validfrom =');
    WriteLn(FAdd, ';//can be null and wwwbackup will set default to the current time.');
    WriteLn(FAdd, 'Validto =');
    WriteLn(FAdd, ';//can be null and wwwbackup will set default to 2099.');
    Result := True;
  finally
     Close(FAdd);
  end;
end;

function TDriveHQ.CreateGetListINIFile(sFilePath: String): Boolean;
var
    FGet: TextFile;
begin
  if FileExists(pAnsiChar(sFilePath + PARAM_LIST_FILE))then
  begin
    DeleteFile(pAnsiChar(sFilePath + PARAM_LIST_FILE));
    DeleteFile(pAnsiChar(sFilePath + PARAM_RESULT_FILE_LIST));
  end;

  AssignFile(FGet, sFilePath + PARAM_LIST_FILE);
  try
    Rewrite(FGet);

    WriteLn(FGet, '[CommonParam]');
    WriteLn(FGet, 'mainparam = GetTaskList');

    WriteLn(FGet, 'ReceiveResultWndName = "Main"');
    WriteLn(FGet, '; After wwwbackup process the command, it will send a message to this window. Please make sure there is only one window have this name.');
    WriteLn(FGet, ';WM_WWWBACKUP_CMD = WM_USER +1000');

    WriteLn(FGet, 'ResultFile = ' + sFilePath + PARAM_RESULT_FILE_LIST);
    WriteLn(FGet, ';some information returned by wwwbackup.');

    WriteLn(FGet, '; The format of result file of this command is same as '+ sFilePath + PARAM_RESULT_FILE_LIST);
    Result := True;
  finally
     Close(FGet);
  end;
end;

function TDriveHQ.CreateDefaultBackupTask: boolean;
var
//    FFDel,FLicAdd,FLicDel: TextFile;
//    sMsgTxt: WideString;
    sDefaultINIPath: string;
begin
  Result := False;
  try
    //check if the add_param.ini file exists, delete the files if they exists
    sDefaultINIPath := IncludeTrailingPathDelimiter(UMyClickForms.MyFolderPrefs.PreferencesDir);

    //check if the default backup already exists, if it does ask user to delete manually and exit...
    if CreateGetListINIFile(sDefaultINIPath) then
    begin
      LaunchWWWbackup(sDefaultINIPath + PARAM_LIST_FILE);
      //wait for the list and then analyse the list to see if the default tasks exists
      Sleep(5000);
      if IsDefaultBackupExists(sDefaultINIPath+PARAM_RESULT_FILE_LIST) then
      begin
        //set the registry that the task has run once and make set default backup task menu invisible
        SetIsDefaultBackupTasksCreated;
        MessageBox(Main.Handle, errTaskExists, 'ClickFORMS', MB_OK + MB_ICONINFORMATION +	MB_SYSTEMMODAL);
        Exit;
      end;
    end;

    //create the default backup task
    if CreateAddTaskINIFile(sDefaultINIPath + PARAM_ADD_FILE) then
    begin
      //launch the backup to first delete the existing default task then create the new one
      LaunchWWWbackup(sDefaultINIPath + PARAM_ADD_FILE);
      SetIsDefaultBackupTasksCreated;
      Result := True;
    end;
  except on E: Exception do
    Raise Exception.CreateFmt(errException, [e.Message]);
  End;
end;

function TDriveHQ.GetFileManagerPath : string;
var
  Reg: TRegistry;
begin
  Result := '';
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if reg.OpenKey(DRIVEHQ_FILEMANAGER_KEY, False) then
    begin
      if Reg.ValueExists('path') then
        Result := Reg.ReadString('path');
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
// gets the path for Drive HQ WWWbackup from registry
//
////////////////////////////////////////////////////////////////////////////////
function TDriveHQ.GetWWWBackupPath: string;
var
  Reg: TRegistry;

begin
  Result := '';
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if reg.OpenKey(DRIVEHQ_WWWBACKUP_KEY, False) then
    begin
      if Reg.ValueExists('path') then
        Result := reg.ReadString('path');
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
end;
////////////////////////////////////////////////////////////////////////////////
// Launches Drive HQ File Manager from CF
////////////////////////////////////////////////////////////////////////////////
function TDriveHQ.LaunchFileManager: boolean;
var
  fmPath, cmdLine: String;
  startInfo: STARTUPINFO;
  procInfo: PROCESS_INFORMATION;
begin
  fmPath := GetFileManagerPath(); // read the path from the registry

  if (Length(fmPath)<=0) then // exit out if no path
    raise EFCreateError.CreateFmt(errEmptyPath,[ExtractFileName(fmPath)]);

  if (FileExists(fmPath)=false) then // exit out if file not found
    raise EFCreateError.CreateFmt(errFileNotExists,[ExtractFileName(fmPath)]);

  //build the command line for file manager
  cmdLine := '"' + fmPath + '"';

  FillChar(startInfo,sizeof(startInfo),0);
  startInfo.cb := sizeof(startInfo);
  if not CreateProcess(nil,PChar(cmdLine),nil,nil,False,NORMAL_PRIORITY_CLASS,nil,nil,startInfo,procInfo) then
    raise EFCreateError.CreateFmt(errCannotRunFileManager,[ExtractFileName(fmPath)])
  else
  begin
    Result := True;
    CloseHandle(procInfo.hThread);
    CloseHandle(procInfo.hProcess);
  end;
end;

////////////////////////////////////////////////////////////////////////////////
// Launches Drive HQ WWWBackup from CF
////////////////////////////////////////////////////////////////////////////////

function TDriveHQ.LaunchWWWBackup(sParams: string): boolean;
var
  fmPath, cmdLine: String;
  startInfo: STARTUPINFO;
  procInfo: PROCESS_INFORMATION;
begin
  fmPath := GetWWWBackupPath(); // read the path from the registry

  if (Length(fmPath)<=0) then // exit out if no path
    raise EFCreateError.CreateFmt(errEmptyPath,[ExtractFileName(fmPath)]);

  if (FileExists(fmPath)=false) then // exit out if file not found
    raise EFCreateError.CreateFmt(errFileNotExists,[ExtractFileName(fmPath)]);

//  InstallBackupDefaultTaskFirstTime;

  //build the command line for file manager
  if Length(sParams) > 0 then
    cmdLine := '"' + fmPath + '" 100 "' + sParams + '"'
  else
    cmdLine := '"' + fmPath + '"';

  FillChar(startInfo,sizeof(startInfo),0);
  startInfo.cb := sizeof(startInfo);
  if not CreateProcess(nil,PChar(cmdLine),nil,nil,False,NORMAL_PRIORITY_CLASS,nil,nil,startInfo,procInfo) then
    raise EFCreateError.CreateFmt(errCannotRunBackup,[ExtractFileName(fmPath)])
  else
    begin
      Result := True;
      CloseHandle(procInfo.hThread);
      CloseHandle(procInfo.hProcess);
    end;
end;

//Installs the Default Backup Task Once
//Once created, do NOT reset the registry key!
{
procedure TDriveHQ.InstallBackupDefaultTaskFirstTime;
begin
  if not IsDefaultBackupTasksCreated then
    CreateDefaultBackupTask;
end;
}

procedure TDriveHQ.SetIsDefaultBackupTasksCreated;
var
  Reg: TRegistry;
begin
  //set the registry to not show it next time
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if reg.OpenKey(FILECENTER_REG_LOC, True) then
    begin
      reg.WriteInteger('IsDefaultBackupTasksCreated',1);
    end
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
end;

function TDriveHQ.IsDefaultBackupExists(sFilePath: String): Boolean;
var
  F: TextFile;
  S: string;
begin
  Result := False;

  if not FileExists(sFilePath) then Exit;

  try
    AssignFile(F, sFilePath);
    Reset(F);
    While not Eof(F) do
    begin
      ReadLn(F, S);
      if Pos( UpperCase(DEFAULT_TASK_NAME), UpperCase(S) ) > 0 then
      begin
        Result := True;
        Break;
      end;
    end;
  finally
    Close(F);
  end;
end;


{********************************************************}
{Utility Routines for testing if File Center is installed}
{********************************************************}

function IsDefaultBackupTasksCreated: Boolean;
var
  Reg: TRegistry;
begin
  Result := False;
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if reg.OpenKey(FILECENTER_REG_LOC, False) then
      begin
        if Reg.ValueExists('IsDefaultBackupTasksCreated') then
          if reg.ReadInteger('IsDefaultBackupTasksCreated') = 1 then Result := True;
      end
    else
      begin
        reg.OpenKey(FILECENTER_REG_LOC, True);
        reg.WriteInteger('IsDefaultBackupTasksCreated',0);
      end;
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
end;

function IsFileCenterBackupInstalled: Boolean;
const
  DRIVEHQ_WWWBACKUP_KEY   = 'Software\File Center\Backup';
var
  Reg: TRegistry;
begin
  Result := False;
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if reg.OpenKey(DRIVEHQ_WWWBACKUP_KEY, False) then
    begin
      if Reg.ValueExists('path') then
        if Length(reg.ReadString('path')) > 0 then Result := True;
    end;
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
end;

function IsFileCenterFileManagerInstalled: Boolean;
const
  DRIVEHQ_FILEMANAGER_KEY   = 'Software\File Center\FileManager';
var
  Reg: TRegistry;
begin
  Result := False;
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if reg.OpenKey(DRIVEHQ_FILEMANAGER_KEY, False) then
    begin
      if Reg.ValueExists('path') then
        if Length(reg.ReadString('path')) > 0 then Result := True;
    end;
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
end;





{

    //sLicINIPath     := IncludeTrailingPathDelimiter(UMyClickForms.MyFolderPrefs.PreferencesDir);
    //DeleteFile(pAnsiChar(sLicINIPath + PARAM_ADD_LIC_FILE));
    //DeleteFile(pAnsiChar(sLicINIPath + PARAM_DEL_LIC_FILE));

    DeleteFile(pAnsiChar(sDefaultINIPath + PARAM_DEL_FILE));


    //-------------------------Start of param_Lic_del.ini----------------//
    //create the delete ini file to delete the existing job from the WWWBackup
    AssignFile(FLicDel, sLicINIPath + PARAM_DEL_LIC_FILE);
    Rewrite(FLicDel);
    WriteLn(FLicDel, '[CommonParam]');
    WriteLn(FLicDel, 'mainparam = deleteBackup');

    WriteLn(FLicDel, 'ReceiveResultWndName = "Window_DriveHQ_Bradford"');
    WriteLn(FLicDel, '; After wwwbackup process the command, it will send a message to this window. Please make sure there is only one window have this name.');
    WriteLn(FLicDel, ';WM_WWWBACKUP_CMD = WM_USER +1000');
    //get the myclickforms\drivehq folder
    WriteLn(FLicDel, 'ResultFile =' + IncludeTrailingBackslash(UMyClickForms.MyFolderPrefs.PreferencesDir) + PARAM_RESULT_FILE_DEL + '; some information returned by wwwbackup.');
    WriteLn(FLicDel, '[Params]');
    WriteLn(FLicDel, 'CountofTask = 1 ;count of taaskd to be deleted');
    WriteLn(FLicDel, 'TaskName1 = '+ DEFAULT_LIC_TASK_NAME);  //build a unique taskname

    Close(FLicDel);

    //launch to delete existing task with same name
    LaunchWWWbackup(sLicINIPath + PARAM_DEL_LIC_FILE);
    //-------------------------End of param_Lic_del.ini----------------//
    Sleep(2000);

    //-------------------------Start of param_add_Lic.ini----------------//
    //create the Add ini file
    AssignFile(FLicAdd, sLicINIPath + PARAM_ADD_LIC_FILE);
    Rewrite(FLicAdd);

    WriteLn(FLicAdd, '[CommonParam]');
    WriteLn(FLicAdd, 'mainparam = createBackup');
    WriteLn(FLicAdd, '');

    WriteLn(FLicAdd, 'ReceiveResultWndName = "Window_DriveHQ_Bradford"');
    WriteLn(FLicAdd, '; After wwwbackup process the command, it will send a message to this window. Please make sure there is only one window have this name.');
    WriteLn(FLicAdd, ';WM_WWWBACKUP_CMD = WM_USER +1000');
    WriteLn(FLicAdd, '');

    //get the myclickforms\drivehq folder
    WriteLn(FLicAdd, 'ResultFile =' + IncludeTrailingBackslash(UMyClickForms.MyFolderPrefs.PreferencesDir) + PARAM_RESULT_FILE_ADD);
    WriteLn(FLicAdd, '; some information returned by wwwbackup.');
    WriteLn(FLicAdd, '');

    WriteLn(FLicAdd, '[Params]');
    WriteLn(FLicAdd, 'TaskName = ' + DEFAULT_LIC_TASK_NAME);  //build a unique taskname
    WriteLn(FLicAdd, '');
    WriteLn(FLicAdd, 'TaskType = 0');
    WriteLn(FLicAdd, ';0:real time backup, 1: daily schedule backup, 2:weekly schedule backup, 3: one time backup schedule.');
    WriteLn(FLicAdd, '');
    //get the CF registry values and build these lines
    WriteLn(FLicAdd, 'CountofPath = 1 ;count of folder or files to be backed up. Please note the files and folders should be in the same top folder.');
    WriteLn(FLicAdd, 'Path1 = ' + appPref_DirLicenses);
    WriteLn(FLicAdd, '');

    WriteLn(FLicAdd, 'ScheduleTime =' + FormatDateTime('mm/dd/yyyy hh:mm:ss',now())); //06/21/2006 14:30:00 ;the next backup time scheduled.valid for schedule backup.';
    WriteLn(FLicAdd, ';the next backup time scheduled.valid for schedule backup.');
    WriteLn(FLicAdd, '');

    WriteLn(FLicAdd, ';the following param are optional.');
    WriteLn(FLicAdd, 'TaskDescription = Default ClickFORMS Backup Task');
    WriteLn(FLicAdd, ';can be null');
    WriteLn(FLicAdd, '');

    WriteLn(FLicAdd, 'EncryptionMode = 0');
    WriteLn(FLicAdd, ';0: not in encryption mode, 1: yes.');
    WriteLn(FLicAdd, '');

    WriteLn(FLicAdd, 'TargetFolder = \DriveHQData\DriveHQ WWWBackup\Data\'+DEFAULT_LIC_TASK_NAME);
    WriteLn(FLicAdd, '; Wwwbackup will create it automatically in default.');
    WriteLn(FLicAdd, '');

    WriteLn(FLicAdd, 'FilterExt =');
    WriteLn(FLicAdd, '');

    WriteLn(FLicAdd, ';valid from to');
    WriteLn(FLicAdd, 'Validfrom =');
    WriteLn(FLicAdd, ';//can be null and wwwbackup will set default to the current time.');
    WriteLn(FLicAdd, 'Validto =');
    WriteLn(FLicAdd, ';//can be null and wwwbackup will set default to 2099.');
    Close(FLicAdd);

    //launch the backup to first delete the existing default task then create the new one
    LaunchWWWbackup(sDefaultINIPath + PARAM_ADD_LIC_FILE);
    //-------------------------end of param_add_Lic.ini----------------//


    //-------------------------Start of param_del.ini----------------//
    //create the delete ini file to delete the existing job from the WWWBackup
    AssignFile(FDel, sDefaultINIPath + PARAM_DEL_FILE);
    Rewrite(FDel);
    WriteLn(FDel, '[CommonParam]');
    WriteLn(FDel, 'mainparam = deleteBackup');

    WriteLn(FDel, 'ReceiveResultWndName = "ClickFORMS"');
    WriteLn(FDel, '; After wwwbackup process the command, it will send a message to this window. Please make sure there is only one window have this name.');
    WriteLn(FDel, ';WM_WWWBACKUP_CMD = WM_USER +1000');
    //get the myclickforms\drivehq folder
    WriteLn(FDel, 'ResultFile =' + IncludeTrailingBackslash(UMyClickForms.MyFolderPrefs.PreferencesDir) + PARAM_RESULT_FILE_DEL + '; some information returned by wwwbackup.');
    WriteLn(FDel, '[Params]');
    WriteLn(FDel, 'CountofTask = 1 ;count of taaskd to be deleted');
    WriteLn(FDel, 'TaskName1 = '+ DEFAULT_TASK_NAME);  //build a unique taskname

    Close(FDel);
    //launch to delete existing task with same name
    LaunchWWWbackup(sDefaultINIPath + PARAM_DEL_FILE);
    //-------------------------End of param_del.ini----------------//
    Sleep(5000);
    }

end.    
