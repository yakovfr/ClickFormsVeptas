unit UAppInstances;

interface

uses
  Windows, Messages, SysUtils, Classes, Forms;


  function HasMultipleInstances(AllowOnlyOne: Boolean): Boolean;
  procedure FreeMultipleInstanceCheck;

var
  Mutex: THandle;

implementation

Uses
  UGlobals;

  



(*
--- Used Mutex instead checking Windows, Dual Processors will allow two instances

function CheckAllWindows(Handle: HWND; temp: LongInt): Bool; StdCall;
var
  WName, CName: array[0..MAX_PATH] of char;
begin
  if (GetClassName(Handle, CName, SizeOf(CName)) > 0) and
     (StrComp(AppClassName, CName) = 0) and
     (GetWindowText(Handle, WName, SizeOf(WName)) > 0) and
     (StrComp(AppName, WName) = 0) then
  begin
    Inc(NumInstances);
    if Handle <> Application.Handle then
      OtherInstance := Handle;
  end;

  result := True;
end;
*)

procedure SendParametersTo(AppInstance: HWND);
var
  S: String;
  i: Integer;
  Atom: TAtom;
begin
  S := '';
  for i := 0 to ParamCount do
    begin
      S := S + '"' + ParamStr(i) + '"' + ' ';
      if POS('.EXE', UpperCase(S))>0 then S := '';    //remove the exe from params
    end;
  if S = '' then Exit;    //nothing to do

  Atom := GlobalAddAtom(Pchar(S));
  SendMessage(AppInstance, CLK_PARAMSTR, Atom, 0);
  GlobalDeleteAtom(Atom);
end;

//Used Mutex instead checking Windows, Dual Processors will allow two instances
function HasMultipleInstances(AllowOnlyOne: Boolean): Boolean;
var
  lastPopup: HWND;
  OtherInstance: HWND;
  ExistingWindowName: string;
begin
  result := False;
  if not AllowOnlyOne then exit;     //can have many, so don't check

  //this allows ClickFORMS to run, but not multiple instances.
  if AppIsClickForms then
    begin
      Mutex := CreateMutex(nil,True,'ClickForms_Instance');
      if GetLastError = ERROR_ALREADY_EXISTS then
        begin
          ExistingWindowName := AppTitleClickFORMS;
          result := True;
        end;
    end;

  if result then
    begin
      Application.Title := 'Not Me';
      OtherInstance := FindWindow('TApplication', PAnsiChar(ExistingWindowName));
      if OtherInstance <> 0 then
        begin
          SetForegroundWindow(OtherInstance);
          if IsIconic(OtherInstance) then
            SendMessage(OtherInstance, WM_SYSCOMMAND, SC_RESTORE, 0);

          //lastPopup := FindWindow('TMain', PAnsiChar(ExistingWindowName));
         lastPopup := GetLastActivePopup(OtherInstance);
          SendParametersTo(lastPopup);
        end;
    end;
end;

procedure FreeMultipleInstanceCheck;
begin
  if Mutex <> 0 then
    CloseHandle(Mutex);
end;

initialization
  Mutex := 0;
  
end.
