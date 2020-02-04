unit UNewsDeskThread;

 {  ClickForms Application                }
 {  Bradford Technologies, Inc.           }
 {  All Rights Reserved                   }
 {  Source Code Copyrighted © 1998-2008 by Bradford Technologies, Inc. }


interface

uses
  Classes, Windows, SysUtils, WinInet, IniFiles,
  {$IFNDEF VER180}ActiveX {$ELSE}OLE2{$ENDIF}, Graphics, Registry,
  UGlobals, UMyClickForms, UAutoUpdate, {IDFtp,}InvokeRegistry, ExtActns,
  UCustomerServices;

type
  TNewsDeskThread = class(TThread)
  private
    FOK2Show:       Boolean;
    FShowRed:       Boolean;
    FSubscription:  Boolean;
    FAutoStarted:   Boolean;
    FCustID:        Integer;
    //FService:       TStringList;
    FHTMLPg:        TStringList;
    FLinks:         TStringList;
    FRules:         TMemIniFile;
    FStartMsg:      integer;
    FEndMsg:        Integer;
    FLastClickTalk: string;
//    ftp1:           TIdFTP;
    FFromMessages:  boolean;


//    procedure SetName;
    procedure LoadDefFiles;
    //procedure GetServiceStatuses;
    procedure SendResult;
    //procedure MergeAllStatuses;
    procedure doMRU;
    procedure doTemplates;
    procedure doRegularUserStatus;
    //procedure doSubscriptionUserStatus;
    //procedure doTrialUserStatus;
    // function IsDate(str: string): boolean;
    // function StringToDate(str: string): TDateTime;
    function GetInetFile(const fileURL, FileName: string): Boolean;
    function GetInetFileDate(const URL: String): TDateTime;
   // function DaysOrDate(daysRem: integer; origDate: string): String;
  protected
    procedure Execute; override;
    function BuildServicesHTML: String;
  public
    FShowNewsDesk:  Boolean;
    FFromStartUp:  Boolean;
    FShowAgain: boolean;
    FShowLinks: boolean;
    FRefreshOnly: boolean;
    FShowClickTalk: boolean;
    constructor Create(CreateSuspended: Boolean);
    destructor Destroy; override;
    property CustomerID: Integer read FCustID write FCustID;
    property OnSubscription: Boolean read FSubscription write FSubscription;
    property AutoStarted: Boolean read FAutoStarted write FAutoStarted;
    function doConnectFTP: boolean;
    function GetFlashListNumber: integer;
    procedure LoadLastClickTalk(URL: string);
    procedure CreateMessages;
    procedure LoadLinks;
    procedure loadmessages;
    procedure GetStdLinks;
    function GetFileSize(const FileName: string): LongInt;
  end;

function Download_HTM(const sURL, sLocalFileName : string): boolean;

var
  lastdefaultpage: string;
  NewsDeskBaseURL: string;
implementation

uses
  AWSI_Server_Clickforms,
  ClfCustServicesEx,
  DateUtils,
  IdHTTP,
  StrUtils,
  Types,
  ULicUser,
  UMain,
  UNewsDesk,
  Uutil1,
  UUtil2,
  UWebConfig,
  UWebUtils;

const
  CINISectionNewsDesk = 'NewsDesk';  // do not localize
  CINIValueLastDateViewed = 'LastDateViewed';  // do not localize
  CTimeout = 30000;  // 30 seconds

(*
{$IFDEF MSWINDOWS}
type
  TThreadNameInfo = record
    FType:     longword;     // must be 0x1000
    FName:     PChar;        // pointer to name (in user address space)
    FThreadID: longword;     // thread ID (-1 indicates caller thread)
    FFlags:    longword;     // reserved for future use, must be zero
  end;
{$ENDIF}
*)

function Download_HTM(const sURL, sLocalFileName : string): boolean;
begin
  Result := True;
  with TDownLoadURL.Create(nil) do
  try
    URL:=sURL;
    Filename:=sLocalFileName;
    try
      ExecuteTarget(nil) ;
    except
      Result:=False
    end;
  finally
    Free;
  end;
end;


{ TNewsDeskThread }

constructor TNewsDeskThread.Create(CreateSuspended: Boolean);
begin
  inherited Create(CreateSuspended);

  NewsDeskBaseURL := IncludeTrailingPathDelimiter(AppPref_DirPref) + 'NewsDesk\';
  if directoryexists(NewsDeskBaseURL)=false then
    createdir(NewsDeskBaseURL);
  FreeOnTerminate := True;
  FFromMessages := false;
  FShowClickTalk := False;
  FRefreshOnly := false;
  FShowAgain := false;
  FFromStartUp := false;
  FShowLinks := False;
  //create string lists
  FHTMLPg := TStringList.Create;
  //FService := TStringList.Create;
  FLinks := TStringList.Create;
  //set the flags
//  FShowNewsDesk := True;
  FOK2Show := False;
end;

destructor TNewsDeskThread.Destroy;
begin
  FHTMLPg.Free;
  //FService.Free;
  FRules.Free;

  inherited;
end;

function TNewsDeskThread.GetFileSize(const FileName: string): LongInt;
var
  SearchRec: TSearchRec;
begin
  try
    if FindFirst(ExpandFileName(FileName), faAnyFile, SearchRec) = 0 then
      Result := SearchRec.Size
    else Result := -1;
  finally
    SysUtils.FindClose(SearchRec);
  end;
end;

(*
procedure TNewsDeskThread.SetName;
{$IFDEF MSWINDOWS}
var
  ThreadNameInfo: TThreadNameInfo;
{$ENDIF}
begin
{$IFDEF MSWINDOWS}
  ThreadNameInfo.FType     := $1000;
  ThreadNameInfo.FName     := 'MyCFThread';
  ThreadNameInfo.FThreadID := $FFFFFFFF;
  ThreadNameInfo.FFlags    := 0;
  try
    RaiseException($406D1388, 0, sizeof(ThreadNameInfo) div sizeof(longword), @ThreadNameInfo);
  except
  end;
{$ENDIF}
end;
*)

procedure TNewsDeskThread.Execute;
begin
//  SetName;
  //GetServiceStatuses;
  //MergeAllStatuses;
{  if FOK2Show = false then
    exit;
}
  LoadDefFiles;
//  Loadfiles2;
  If FOK2Show = false then
    exit;
   //setup service status for different type of user
  {if CustomerID = 0 then    //they are a trial user - not registered yet
    doTrialUserStatus
  //else if (CustomerID > 0) and OnSubscription then  //they are on subscription
    //doSubscriptionUserStatus
  else   }
    doRegularUserStatus;    //they are a regular user


//  loadlastClickTalk('http://www.bradfordsoftware.com/news/ClickTALK_2008/clicktalk153.html');
//  GetStdLinks;

//  doTemplates;              //create the display
//  doMRU;
//  FLinks.SaveToFile(NewsDeskBaseURL + 'Links.html');
//  if FFromMessages=false then  loadlastclicktalk;


  Synchronize(SendResult);
end;

procedure TNewsDeskThread.SendResult;
var
  newsDeskHTML: String;
begin

  try
    if FOK2Show = true then
    begin
      newsDeskHTML := NewsDeskBaseURL + cNewsDeskHTML;

      if FileExists(newsDeskHTML) then
        DeleteFile(newsDeskHTML);

      FHTMLPg.SaveToFile(newsDeskHTML);

      if FShowRed then
        begin
          main.styler2.RightHandleColor   := clRed;
          main.styler2.RightHandleColorTo := clMaroon;
        end
      else
        begin
          main.styler2.RightHandleColor   := $00F1A675;
          main.styler2.righthandlecolorto := $00913500;
        end;

      if FShowNewsDesk then
       begin
        If FRefreshOnly = false then
          CreateNewsDesk
          else
          NewsDesk.Browser.Refresh;
       end;
    end
  except
  end;
end;

procedure TNewsDeskThread.GetStdLinks;
var slx: TStringList;
i: integer;
LinkName, LinkURL: string;
MRUT: string;
begin
doMRU;
doTemplates;
slx := TStringlist.Create;
    {Get News Links}
    slx.Clear;
    for i := 1 to 10 do
    begin
      LinkName := FRules.ReadString('WebsiteLinks', 'Link' + IntToStr(i) + 'Name', '');
      LinkURL  := FRules.ReadString('WebsiteLinks', 'Link' + IntToStr(i) + 'URL', '');
      if (LinkName <> '') and (LinkURL <> '') then
      begin
        if pos('DEFAULTPAGE',uppercase(LinkName))>0 then
          begin
            lastdefaultpage := LinkURL;
            if FLastClickTalk<>LinkURL then
              FShowLinks := false;
          end
          else
            slx.Add('           <FONT SIZE="2"><FONT FACE="Arial,Helvetica,Monaco"><A HREF="' + LinkURL +
              '" TARGET="_blank">' + LinkName + '</A></FONT></FONT><BR>');
      end;
    end;
    MRUT        := SLx.Text;
    MRUT        := MRUT + '<BR>';
    i           := pos('[WWW]', FLinks.Text);
    FLinks.Text := copy(FLinks.Text, 1, i - 1) + MRUT + copy(FLinks.Text, i + 5, length(FLinks.Text));

    {Get BT Links}
    slx.Clear;
    for i := 1 to 10 do
    begin
      LinkName := FRules.ReadString('BTLinks', 'Link' + IntToStr(i) + 'Name', '');
      LinkURL  := FRules.ReadString('BTLinks', 'Link' + IntToStr(i) + 'URL', '');
      if (LinkName <> '') and (LinkURL <> '') then
      begin
        if pos('DEFAULTPAGE',uppercase(LinkName))>0 then
          begin
            lastdefaultpage := LinkURL;
            if FLastClickTalk<>LinkURL then
              FShowLinks := false;
          end
          else
            slx.Add('           <FONT SIZE="2"><FONT FACE="Arial,Helvetica,Monaco"><A HREF="' + LinkURL +
              '" TARGET="_blank">' + LinkName + '</A></FONT></FONT><BR>');
      end;
    end;

    MRUT        := SLx.Text;
    MRUT        := MRUT + '<BR>';
    i           := pos('[BTL]', FLinks.Text);
    FLinks.Text := copy(FLinks.Text, 1, i - 1) + MRUT + copy(FLinks.Text, i + 5, length(FLinks.Text));
FLinks.SaveToFile(NewsDeskBaseURL + 'Links.html');
end;

procedure TNewsDeskThread.LoadLastClickTalk(URL: string);
var sl: TStringList;
begin
  sl := TStringList.Create;
  sl.LoadFromFile(NewsDeskBaseURL + cNewsDeskIndex);
  sl.Text := stringreplace(sl.Text,'CFFile.html',URL,[rfReplaceAll]);
  sl.savetofile(NewsDeskBaseURL + cNewsDeskFramedHTML);
  sl.Free;
end;

procedure TNewsDeskThread.LoadLinks;
var sl: TStringList;
begin
//GetStdLinks;
  sl := TStringList.Create;
  sl.LoadFromFile(NewsDeskBaseURL + cNewsDeskIndex);
  sl.Text := stringreplace(sl.Text,'CFFile.html','Links.html',[rfReplaceAll]);
  sl.savetofile(NewsDeskBaseURL + cNewsDeskFramedHTML);
  sl.Free;
end;

procedure TNewsDeskThread.LoadMessages;
var sl: TStringList;
begin
  sl := TStringList.Create;
  sl.LoadFromFile(NewsDeskBaseURL + cNewsDeskIndex);
  sl.Text := stringreplace(sl.Text,'CFFile.html','Messages.html',[rfReplaceAll]);
  sl.savetofile(NewsDeskBaseURL + cNewsDeskFramedHTML);
  sl.Free;
end;


procedure TNewsDeskThread.CreateMessages;
var f: integer;
  sl, sl2: TStringList;
  destdir: string;
  fdate: string;
  tempini: TIniFile;
  itexists: boolean;
begin
  sl := nil;
  sl2 := nil;
  tempini := nil;
  destdir := (NewsDeskBaseURL + 'Messages\');
  if directoryexists(destdir)=false then
    createdir(destdir);

try
//ftp1 := TIdFTP.Create(nil);
//if doConnectFTP then
if isconnectedtoweb then
  try
  sl := TStringList.Create;
  sl2 := TStringList.Create;
  for f := FStartMsg downto FEndMsg+1 do
    begin
     if fileexists(destdir + 'ClickFlash_' + inttostr(f) + '.txt')=false then
       begin
{         FTP1.Get('ClickFlash_' + inttostr(f) + '.txt',destdir + 'ClickFlash_' + inttostr(f) + '.txt', true);}
         itexists := Download_HTM(NewsDeskURLPath + 'ClickFlash_' + inttostr(f) + '.txt',destdir + 'ClickFlash_' + inttostr(f) + '.txt');
         if itexists then
           repeat
           until (fileexists(destdir + 'ClickFlash_' + inttostr(f) + '.txt')) and (getfilesize(destdir + 'ClickFlash_' + inttostr(f) + '.txt')>1);
       end;
     sl2.LoadFromFile(destdir + 'ClickFlash_' + inttostr(f) + '.txt');
     fdate := formatdatetime('mm/dd/yyyy', filedatetodatetime(fileage(destdir + 'ClickFlash_' + inttostr(f) + '.txt')));
     sl.Add('<TABLE WIDTH="100%" CELLPADDING="0" CELLSPACING="0" BORDER="0">');
     sl.add('    <TR>');
     sl.Add('     <TD WIDTH="100%" BGCOLOR="#CED6FF" VALIGN=TOP>');
     sl.Add('      <P>');
     sl.Add('       <B><U><FONT SIZE="3">' + 'Message #' + inttostr(f) + '  </FONT></B><i><FONT SIZE="2">' + fdate + '</FONT></i></U></TD>');
     sl.Add('    </TR>');
     sl.Add('    <TR>');
     sl.Add('     <TD WIDTH="100%" BGCOLOR="SILVER" VALIGN=TOP>');
     sl.Add('      <P>');
     if sl2.Count>0 then
       begin
         sl.Add('       <B><FONT SIZE="3"><I>' + sl2[0] + '</I></FONT></B></TD>');
         sl2.Delete(0);
       end
       else
         sl.Add('       <B><FONT SIZE="3"><I>Message Deleted</I></FONT></B></TD>');
     sl.Add('    </TR>');
     sl.Add('    <TR>');
     sl.Add('     <TD WIDTH="100%" VALIGN=TOP>');
     sl.Add('      <P><FONT SIZE="2">');
     sl.Add('       ' + sl2.Text + '</FONT></TD>');
     sl.Add('    </TR>');
     sl.Add('   </TABLE>');
     sl.Add('<BR>');
    end;

    sl2.Clear;
    sl2.LoadFromFile(NewsDeskBaseURL + 'CFFile.html');
    sl2.Text := stringreplace(sl2.Text,'[CFN]',sl.Text,[rfReplaceAll]);
    sl2.SaveToFile(NewsDeskBaseURL + 'Messages.html');
    if not FShowAgain then
      begin
        tempIni := TIniFile.Create(NewsDeskBaseURL + 'NewsDesk.ini');
        tempini.WriteInteger('NEWSDESK','LastMessage',FStartMsg);
      end;
  except
  end;
finally
{if ftp1.Connected then
  ftp1.Disconnect;
ftp1.free;}
sl.Free;
sl2.Free;
tempini.Free;
end;
end;

(*procedure TNewsDeskThread.MergeAllStatuses;
var
   FullServiceList: TStringList;
   i, f: integer;
   txtPos1: integer;
   FormalName, DisplayName, txt1: string;
   FoundMatch: boolean;
begin
   FullServiceList := TStringList.Create;
   try
     if FService.count>=3 then
        begin
          FullServiceList.Add(FService[0]);
          FullServiceList.Add(FService[1]);
          FullServiceList.Add(FService[2]);
        end
        else
        begin
          FullServiceList.Add('Maintenance~None~Not Subscribed~ClickFORMS Maintenance');
          FullServiceList.Add('Live Support~None~Not Subscribed~ClickFORMS Live Support');
          FullServiceList.Add('Appraisal World~None~Not Subscribed~Appraisal World');
        end;
     FullServiceList.Add('Location Maps~Location Maps');
     FullServiceList.Add('AppraisalPort Connection~Appraisal Port Connection');
     FullServiceList.Add('Lighthouse Connection~Lighthouse Connection');
     FullServiceList.Add('Data Import Connection~Data Import Connection');
     FullServiceList.Add('Flood Maps~Flood Maps');
     FullServiceList.Add('Flood Risk Determination~Flood Data Only');
     FullServiceList.Add('Fidelity National Information Service~Fidelity Property Data');
     FullServiceList.Add('VeroValue Reports~VeroValue Reports');
  //   FullServiceList.Add('MLS Connection~MLS Connection');
     FullServiceList.Add('Marshall & Swift Service~Swift Estimator');

     for i:=3 to FullServiceList.Count-1 do
      begin
         FormalName := FullServiceList[i];
         txtPos1 := pos('~',FormalName);
         FormalName := copy(FormalName,1,txtPos1-1);
         DisplayName := copy(FullServiceList[i],txtPos1+1,length(FullServiceList[i]));

         f:=3;
         FoundMatch:=false;
         if FService.count>3 then
         begin
          Repeat
            txt1 := FService[f];
            if pos(uppercase(FormalName), uppercase(txt1))>0 then FOundMatch :=true;
            f := f + 1;
          Until FoundMatch or (f = FService.count);
         end;

         if foundMatch then
            FullServiceList[i] :=FService[f-1] + '~' + DisplayName
         else
            FullServiceList[i] := FormalName + '~None~Not Subscribed~' + DisplayName;
      end;

    FService.Assign(FullServiceList);
  finally
    FullServiceList.Free;
  end;
end;    *)

{
function TNewsDeskThread.IsDate(str: string): boolean;
begin
  Result := true;
  try
    StrToDate(str);
  except
    Result := false;
  end;
end;
}

{
function TNewsDeskThread.StringToDate(str: string): TDateTime;
begin
  try
    Result := StrToDate(str);
  except
    Result := Now;
  end;
end;
}

(*function TNewsDeskThread.DaysOrDate(daysRem: Integer; origDate: String): String;
begin
  if daysRem > 30 then
    Result := origDate
  else
    Result := IntToStr(daysRem) + ' days';
end;    *)

function TNewsDeskThread.doConnectFTP: boolean;
begin
result:=IsConnectedToWeb;
end;

function TNewsDeskThread.GetFlashListNumber: integer;
var
 f: integer;
 destpath, fname : string;
 itexists: boolean;
begin
destpath := NewsDeskBaseURL + 'Messages\';
f := 1;

  repeat
    fname := 'ClickFlash_' + inttostr(f) + '.txt';
    itexists := true;
    if fileexists(destpath + fname)=true then
      f := f + 1
   else
    itexists := false;
{    begin
      itexists := Download_HTM(NewsDeskURLPath + fname,destpath + fname);
      if itexists then
        begin
          f := f + 1;
        end;
    end;     }
  until itexists = false;
result := f-1;

end;

function TNewsDeskThread.GetInetFile(const fileURL, FileName: String): boolean;
begin
  result := Download_HTM(NewsDeskURLPath + fileURL,FileName);
end;

function TNewsDeskThread.GetInetFileDate(const URL: String): TDateTime;
var
  Protocol: TIdHTTP;
begin
  Protocol := TIdHTTP.Create;
  try
    Protocol.ReadTimeout := CTimeout;
    Protocol.Head(URL);
    if Assigned(Protocol.Response) then
      Result := Protocol.Response.LastModified
    else
      Result := 0;
  finally
    FreeAndNil(Protocol);
  end;
end;

{
procedure TNewsDeskThread.GetServiceStatuses;
var
  StatusArray:   ArrayOfServiceStatus;
  expDate:       TDateTime;
  i, iCustID:    Integer;
  sMsg:          WideString;
  st1, st2, st3: string;
begin
  iCustID := StrToIntDef(CurrentUser.LicInfo.UserCustID, 0);
  if iCustID = 0 then
    exit;


 CoInitialize(nil);
  try
    with GetMessagingServiceSoap(true, UWebConfig.GetURLForClientMessaging) do
    begin
      try
        try
          GetServiceStatusSummary(iCustID, WSMessaging_Password, StatusArray, sMsg);

          //set the software maintenance expriation date
          expDate := StatusArray[0].ExpiresOn.AsDateTime;
          FService.Add(datetostr(expDate));

          //set the LiveSupport expiration date
          expDate := StatusArray[1].ExpiresOn.AsDateTime;
          FService.Add(datetostr(expDate));

          //set the AppraisalWorld Connection expiration date
          expDate := StatusArray[2].ExpiresOn.AsDateTime;    //commented by vivek 05/07/2007
          FService.Add(datetostr(expDate));
        except
          exit;
        end;

        try
          for i := 3 to Length(StatusArray) - 1 do          //count from zero
            begin
              st1 := '';
              st2 := '';
              st2 := '';
              //set the service name
              st1 := StatusArray[i].ServiceName;
              //set the units remaining
              if (StatusArray[i].CurrentStatus = '0') then          //none
                st2 := 'None'
              else                                                  //unit value
                st2 := StatusArray[i].CurrentStatus;

              //set the expiration date
              //if (StatusArray[i].ExpiresOn.AsDateTime < StrToDateTime('01/01/2002')) then  //changed by Vivek 05/07/2007
              if (StatusArray[i].ExpiresOn.AsDateTime < StrToDateEx('01/01/2002','MM/dd/yyyy','/')) then
                begin
                  if ((CompareText(st2, 'None') = 0) or (CompareText(st2, 'NA') = 0) or
                    (Length(st2) = 0)) then    //added by Vivek 05/07/2007
                    begin
                      st3 := 'Not Subscribed';
                      st2 := 'None';             //added by Vivek 05/07/2007
                    end
                  else
                    st3 := 'On Subscription';
                end
              else
                st3 := DateToStr(StatusArray[i].ExpiresOn.AsDateTime);

              FService.Add(st1 + '~' + st2 + '~' + st3);
            end;
        finally
          // free all the elements of this array
          for i := 0 to Length(StatusArray) - 1 do
            StatusArray[i].Free;
        end;
        FOK2SHow := true;
      except
      end;
    end;
  except
  end;
  CoUninitialize;
end;
                          }
//------------------------------------------------------------------------------
(*procedure TNewsDeskThread.doTrialUserStatus;
var
  SLx:  TStringList;
  AvailVer, MRUT:     String;
  LinkName, LinkURL:  String;
  nm, qty, exp:       String;
  tmp, RealName:      String;
  UpdateAvail: Boolean;
  f, p, i:     Integer;
begin
  SLx:= TStringList.Create;
  try
    //Call AutoUpdate service from the NewsDesk thread sometime make ClickForms to crash.
    // I moved this call in InitAutoUpdateStatus function before creating NewsDesk.
    //News desk just gets what ClickForms already checks rather than call AutoUpdate service by itself. YF 01/29/09
    //UpdateAvail := (AutoUpdateStatus.UpdateAvailable = 1);
    UpdateAvail := AutoUpdateStatus.NeedsToUpdate;
    SLx.add('<FONT FACE="Arial,Helvetica,Monaco"><TABLE WIDTH="100%" CELLPADDING="0" CELLSPACING="0" BORDER="1"><FONT SIZE="2"><FONT FACE="Arial,Helvetica,Monaco">');
    AvailVer := '            <TR><TD WIDTH="60%" VALIGN=CENTER ALIGN=CENTER BGCOLOR="SILVER"><FONT SIZE="2"><B>Service</B></FONT></TD><TD WIDTH="40%" VALIGN=CENTER ALIGN=CENTER BGCOLOR="SILVER"><FONT SIZE="2"><B>Status</B></FONT></TD></TR>';
    SLx.add(AvailVer);

    AvailVer := '            <TR><TD WIDTH="60%" VALIGN=CENTER><FONT SIZE="2">ClickForms Maintenance</FONT>';
    AvailVer := AvailVer + '</TD><TD WIDTH="40%"  VALIGN=CENTER ALIGN=CENTER><FONT SIZE="1"><I>Not Purchased</I></FONT></TD></TR>';
    SLx.add(AvailVer);
    AvailVer := '            <TR><TD WIDTH="60%" VALIGN=CENTER><FONT SIZE="2">ClickForms Live Support</FONT>';
    AvailVer := AvailVer + '</TD><TD WIDTH="40%"  VALIGN=CENTER ALIGN=CENTER><FONT SIZE="1"><I>Not Purchased</I></FONT></TD></TR>';
    SLx.add(AvailVer);

    for f := 3 to FService.Count - 1 do
    begin
      tmp        := FService[f];
      p          := pos('~', tmp);
      nm         := copy(tmp, 1, p - 1);
      tmp        := copy(tmp, p + 1, length(tmp));
      p          := pos('~', tmp);
      qty        := copy(tmp, 1, p - 1);
      tmp        := copy(tmp, p + 1, length(tmp));
      p          := pos('~', tmp);
      exp        := copy(tmp, 1, p-1);
      RealName   := copy(tmp,p+1, length(tmp));
      nm :=RealName;

      SLx.Add('            <TR><TD WIDTH="60%" VALIGN=CENTER><FONT SIZE="1">' + nm +
          '<FONT SIZE="2"></TD><TD WIDTH="40%"  VALIGN=CENTER ALIGN=CENTER><FONT SIZE="1"><I>Not Purchased</I></FONT></TD></TR>');
    end;

    SLx.add('</FONT></FONT></TABLE></FONT>');

    MRUT := SLx.Text;
    if MRUT = '' then
      MRUT := '<FONT SIZE="1"><FONT FACE="Arial,Helvetica,Monaco">None</FONT></FONT><BR>';
    i := pos('[CF]', FHTMLPg.Text);
    FHTMLPg.Text := copy(FHTMLPg.Text, 1, i - 1) + MRUT + copy(FHTMLPg.Text, i + 4, length(FHTMLPg.Text));

    {Insert Update Status}
    i := pos('[AUTOSTATUS]', FHTMLPg.Text);
    if UpdateAvail then
      MRUT := '<A HREF="[UPDATE]" TARGET="_self"><FONT SIZE="1">An update is available!</FONT></A><BR>'
    else
      MRUT := '<FONT SIZE="1">You have the latest version available.</FONT><BR>';
    FHTMLPg.Text := copy(FHTMLPg.Text, 1, i - 1) + MRUT + copy(FHTMLPg.Text, i + 12, length(FHTMLPg.Text));

    {Get News Links}
    slx.Clear;
    for i := 1 to 10 do
    begin
      LinkName := FRules.ReadString('WebsiteLinks', 'Link' + IntToStr(i) + 'Name', '');
      LinkURL  := FRules.ReadString('WebsiteLinks', 'Link' + IntToStr(i) + 'URL', '');
      if (LinkName <> '') and (LinkURL <> '') then
      begin
        if pos('DEFAULTPAGE',uppercase(LinkName))>0 then
          begin
            lastdefaultpage := LinkURL;
            if FLastClickTalk<>LinkURL then
              FShowLinks := false;
          end
          else
            slx.Add('           <FONT SIZE="1"><FONT FACE="Arial,Helvetica,Monaco"><A HREF="' + LinkURL +
              '" TARGET="_blank">' + LinkName + '</A></FONT></FONT><BR>');
      end;
    end;
    MRUT        := SLx.Text;
    MRUT        := MRUT + '<BR>';
    i           := pos('[WWW]', FLinks.Text);
    FLinks.Text := copy(FLinks.Text, 1, i - 1) + MRUT + copy(FLinks.Text, i + 5, length(FLinks.Text));

    {Get BT Links}
    slx.Clear;
    for i := 1 to 10 do
    begin
      LinkName := FRules.ReadString('BTLinks', 'Link' + IntToStr(i) + 'Name', '');
      LinkURL  := FRules.ReadString('BTLinks', 'Link' + IntToStr(i) + 'URL', '');
      if (LinkName <> '') and (LinkURL <> '') then
      begin
        if pos('DEFAULTPAGE',uppercase(LinkName))>0 then
          begin
            lastdefaultpage := LinkURL;
            if FLastClickTalk<>LinkURL then
              FShowLinks := false;
          end
          else
            slx.Add('           <FONT SIZE="1"><FONT FACE="Arial,Helvetica,Monaco"><A HREF="' + LinkURL +
              '" TARGET="_blank">' + LinkName + '</A></FONT></FONT><BR>');
      end;
    end;

    MRUT        := SLx.Text;
    MRUT        := MRUT + '<BR>';
    i           := pos('[BTL]', FLinks.Text);
    FLinks.Text := copy(FLinks.Text, 1, i - 1) + MRUT + copy(FLinks.Text, i + 5, length(FLinks.Text));

    {Get Promo Links}
    slx.Clear;
    for i := 1 to 10 do
    begin
      LinkName := FRules.ReadString('PromoLinks', 'Link' + IntToStr(i) + 'Name', '');
      LinkURL  := FRules.ReadString('PromoLinks', 'Link' + IntToStr(i) + 'URL', '');
      if (LinkName <> '') and (LinkURL <> '') then
      begin
        if pos('DEFAULTPAGE',uppercase(LinkName))>0 then
          begin
            lastdefaultpage := LinkURL;
            if FLastClickTalk<>LinkURL then
              FShowLinks := false;
          end
          else
            slx.Add('           <FONT SIZE="1"><FONT FACE="Arial,Helvetica,Monaco"><A HREF="' + LinkURL +
              '" TARGET="_blank">' + LinkName + '</A></FONT></FONT><BR>');
      end;
    end;
    MRUT        := SLx.Text;
    MRUT        := MRUT + '<BR>';
    i           := pos('[PROMO]', FHTMLPg.Text);
    FHTMLPg.Text := copy(FHTMLPg.Text, 1, i - 1) + MRUT + copy(FHTMLPg.Text, i + 7, length(FHTMLPg.Text));

  finally
    SLx.Free;
  end;
end;              *)

//-----------------------------------------------------------------------------
(*procedure TNewsDeskThread.doSubscriptionUserStatus;
var
  daysRem:     Integer;
  SLx:         TStringList;
//  XReg:        TRegistry;
  f, p, i:     Integer;
  notsub:      Boolean;
  daysrem2, MRUT, newCol: string;
  nm, qty, exp, tmp, RealName: string;
  {RegKy,} BURL, SVC, MURL, MXURL: string;
  TempS, MaintExpDate, AvailVer: string;
  LinkName, LinkURL: string;
  CompOp, CompOpTime: integer;
  typ:         integer;
  do2:         boolean;
  UpdateAvail: boolean;
begin
  SLx := TStringList.Create;
  try
    //Call AutoUpdate service from the NewsDesk thread sometime make ClickForms to crash.
    // I moved this call in InitAutoUpdateStatus function before creating NewsDesk.
    //News desk just gets what ClickForms already checks rather than call AutoUpdate service by itself. YF 01/29/09
    //UpdateAvail := (AutoUpdateStatus.UpdateAvailable = 1);
   UpdateAvail := AutoUpdateStatus.NeedsToUpdate;
    notsub        := false;
    FShowRed      := false;

    MaintExpDate := FService[0];
    daysrem      := round(StringToDate(FService[0]) - Now);

    TempS := FRules.ReadString('Maintenance', 'Time', '1');
    p     := pos(',', TempS);
    if p > 0 then
      Temps := copy(TempS, 1, p - 1);
    CompOp := StrToInt(Temps);

    BURL := FRules.ReadString('Maintenance', 'URL', 'https://secure.appraisalworld.com/store/');
    SVC  := FRules.ReadString('Maintenance', 'WebSvc', '');
    if SVC <> '' then
      MURL := 'WebSvc' + SVC + '-' + BURL
    else
      MURL := BURL;
    MXURL := MURL;

    newcol :='';// '<TD WIDTH="25%" VALIGN=CENTER ALIGN=CENTER BGCOLOR="SILVER"><FONT SIZE="1"><B>Expires</B></FONT></TD>';
    SLx.add('<FONT FACE="Arial,Helvetica,Monaco"><TABLE WIDTH="100%" CELLPADDING="0" CELLSPACING="0" BORDER="1"><FONT SIZE="1"><FONT FACE="Arial,Helvetica,Monaco">');
    AvailVer := '            <TR><TD WIDTH="60%" VALIGN=CENTER ALIGN=CENTER BGCOLOR="SILVER"><FONT SIZE="1"><B>Service</B></FONT></TD><TD WIDTH="40%" VALIGN=CENTER ALIGN=CENTER BGCOLOR="SILVER"><FONT SIZE="1"><B>Status</B></FONT></TD></TR>';
    SLx.add(AvailVer);

    if daysrem>=0 then
      daysrem2:=inttostr(daysrem)
    else
      daysrem2:='<FONT COLOR="RED">Expired</FONT>';

    if daysrem < 0 then
    begin
      notsub   := true;
      AvailVer := '            <TR><TD WIDTH="60%" VALIGN=CENTER><A HREF="' + MURL +
        '" TARGET="_self"><B><FONT SIZE="1">ClickForms Maintenance</FONT></B>';
        AvailVer := AvailVer + '</TD><TD WIDTH="40%"  VALIGN=CENTER ALIGN=CENTER><FONT SIZE="1">Expired</FONT></TD></TR>';

      SLx.add(AvailVer);
      FShowRed := true;
    end;

    if daysrem > 0 then
      begin
        AvailVer := '            <TR><TD WIDTH="60%" VALIGN=CENTER><FONT SIZE="1">ClickForms Maintenance</FONT>';
          AvailVer := AvailVer + '</TD><TD WIDTH="40%"  VALIGN=CENTER ALIGN=CENTER><FONT SIZE="1"><FONT COLOR="#007F00"><B>On Subscription</B></FONT></FONT></TD></TR>';
        SLx.add(AvailVer);
      end
    else
      begin
        AvailVer := '            <TR><TD WIDTH="60%" VALIGN=CENTER><FONT SIZE="1">ClickForms Maintenance</FONT>';
          AvailVer := AvailVer + '</TD><TD WIDTH="40%"  VALIGN=CENTER ALIGN=CENTER><FONT SIZE="1">Expired</FONT></TD></TR>';
        SLx.add(AvailVer);
      end;

    //Check for ClickForms Support
    daysrem := round(StringToDate(FService[1]) - Now);

    TempS := FRules.ReadString('Live Support', 'Time', '1');
    p     := pos(',', TempS);
    if p > 0 then
      Temps := copy(TempS, 1, p - 1);
    CompOp := StrToInt(Temps);

    BURL := FRules.ReadString('Program', 'SupportURL', 'https://secure.appraisalworld.com/store/');
    SVC  := FRules.ReadString('Program', 'SupportWebSvc', '');
    if SVC <> '' then
      MURL := 'WebSvc' + SVC + '-' + BURL
    else
      MURL := BURL;
    if daysrem < 0 then
    begin
      AvailVer := '            <TR><TD WIDTH="60%" VALIGN=CENTER><A HREF="' + MURL +
        '" TARGET="_self"><FONT SIZE="1">ClickForms Support</FONT></A></TD><TD WIDTH="40%" VALIGN=CENTER ALIGN=CENTER><FONT SIZE="1">'
        + '<FONT COLOR="RED">Expired</FONT></FONT></TD></TR>';
      SLx.add(AvailVer);

      FShowRed := true;
    end;
    if daysrem > 0 then
      begin
        AvailVer :=
          '            <TR><TD WIDTH="60%" VALIGN=CENTER><FONT SIZE="1">ClickForms Support</FONT></TD><TD WIDTH="40%" VALIGN=CENTER ALIGN=CENTER><FONT SIZE="1">'
          + '<FONT COLOR="#007F00"><B>On Subscription</B></FONT></FONT></TD></TR>';
        SLx.add(AvailVer);
      end;

    for f := 3 to FService.Count - 1 do
    begin
      CompOp     := 0;
      CompOpTime := 0;
      tmp        := FService[f];
      p          := pos('~', tmp);
      nm         := copy(tmp, 1, p - 1);
      tmp        := copy(tmp, p + 1, length(tmp));
      p          := pos('~', tmp);
      qty        := copy(tmp, 1, p - 1);
      tmp        := copy(tmp, p + 1, length(tmp));
      p          := pos('~', tmp);
      exp        := copy(tmp, 1, p-1);
      RealName   := copy(tmp,p+1, length(tmp));
//      nm :=RealName;


      BURL       := FRules.ReadString(nm, 'URL', 'https://secure.appraisalworld.com/store/');
      SVC        := FRules.ReadString(nm, 'WebSvc', '');
      if SVC <> '' then
        MURL := 'WebSvc' + SVC + '-' + BURL
      else
        MURL := BURL;

      if {(qty <>'NA') and }(qty <> 'Not Subscribed') and (qty <> 'None') and (exp <> ' Not Subscribed') then
        //and (qty<>'On Subscription') then
      begin
        typ := FRules.ReadInteger(nm, 'Method', 0);
        nm :=RealName;
        if typ = 3 then  //Dependent on Maintenance
        begin
        daysrem := round(StringToDate(FService[0]) - Now);

        daysrem2 := inttostr(daysrem);
          if notsub = true then
          begin
            daysrem2:='<FONT COLOR="RED"><FONT SIZE="1">Expired</FONT></FONT>';
            SLx.add('            <TR><TD WIDTH="60%"  VALIGN=CENTER><A HREF="' + MURL +
              '" TARGET="_self"><B><FONT SIZE="1">' + nm + '</FONT></B></TD><TD WIDTH="40%"  VALIGN=CENTER ALIGN=CENTER>' +
              daysrem2 + '</TD></TR>');
          end
          else
            SLx.Add('            <TR><TD WIDTH="60%" VALIGN=CENTER><FONT SIZE="1">' + nm +
              '<FONT SIZE="1"></TD><TD WIDTH="40%"  VALIGN=CENTER ALIGN=CENTER><FONT SIZE="1"><FONT COLOR="#007F00"><B>On Subscription</B></FONT></FONT></TD></TR>');
        end;
        if typ = 0 then  //Time Only
        begin
          if isdate(exp) then
            daysrem := round(StringToDate(exp) - Now)
          else
            daysrem := 0;

          TempS := FRules.ReadString(nm, 'Time', '0');
          p     := pos(',', TempS);
          if p > 0 then
            Temps := copy(TempS, 1, p - 1);
          CompOpTime := StrToInt(Temps);

          if (daysrem <= 0) or notsub then
          begin
            SLx.add('            <TR><TD WIDTH="60%" VALIGN=CENTER><A HREF="' + MURL +
              '" TARGET="_self"><B><FONT SIZE="1">' + nm +
              '</FONT></B></TD><TD WIDTH="40%" VALIGN=CENTER ALIGN=CENTER><FONT SIZE="1">' +
                '<FONT COLOR="RED">Expired</FONT></FONT></TD></TR>');
          end
          else
          begin
            SLx.Add('            <TR><TD WIDTH="60%" VALIGN=CENTER><FONT SIZE="1">' + nm +
              '</FONT></TD><TD WIDTH="40%" VALIGN=CENTER ALIGN=CENTER><FONT SIZE="1"><FONT COLOR="#007F00"><B>On Subscription</B></FONT></FONT></TD></TR>');
            FShowRed := true;
          end;
        end;

        if typ = 1 then //Units Only
        begin
          TempS := FRules.ReadString(nm, 'Units', '0');
          p     := pos(',', TempS);
          if p > 0 then
            Temps := copy(TempS, 1, p - 1);
          CompOp := StrToInt(Temps);
         if pos('FLO',nm)<1 then
         begin
          if (StrToInt(qty) <= 0) or notsub then
          begin
            SLx.add('            <TR><TD WIDTH="60%" VALIGN=CENTER><A HREF="' + MURL +
              '" TARGET="_self"><B><FONT SIZE="1">' + nm + '</FONT></B></TD><TD WIDTH="40%" VALIGN=CENTER ALIGN=CENTER><FONT SIZE="1">Expired</FONT></TD></TR>');
          end
          else
          begin
            SLx.Add('            <TR><TD WIDTH="60%" VALIGN=CENTER><FONT SIZE="1">' + nm +
              '</FONT></TD><TD WIDTH="40%" VALIGN=CENTER ALIGN=CENTER><FONT SIZE="1"><FONT COLOR="#007F00"><B>On Subscription</B></FONT></TD></TR>');
            FShowRed := true;
          end;
         end
         else
          begin
            SLx.Add('            <TR><TD WIDTH="60%" VALIGN=CENTER><FONT SIZE="1">' + nm +
              '</FONT></TD><TD WIDTH="40%" VALIGN=CENTER ALIGN=CENTER><FONT SIZE="1"><FONT COLOR="#007F00"><B>' + qty + '</B></FONT></TD></TR>');
            FShowRed := true;
          end;
        end;

        if typ = 2 then //Time and Units
        begin
          if isdate(exp) then
            daysrem := round(StringToDate(exp) - Now)
          else
            daysrem := 0;

          TempS := FRules.ReadString(nm, 'Time', '0');
          p     := pos(',', TempS);
          if p > 0 then
            Temps := copy(TempS, 1, p - 1);
          CompOpTime := StrToInt(Temps);

          do2 := false;
          daysrem2:=inttostr(daysrem);
  //        if daysrem <= 0 then
  //        begin
  //          do2 := true;
  //          daysrem2:='<FONT COLOR="RED">*Expired</FONT>';
  //        end;

          TempS := FRules.ReadString(nm, 'Units', '0');
          p     := pos(',', TempS);
          if p > 0 then
            Temps := copy(TempS, 1, p - 1);
          CompOp := StrToInt(Temps);

          if StrToInt(qty) <= 0 then
            do2 := true;

          if (do2 = true) or notsub then
          begin
            SLx.add('            <TR><TD WIDTH="60%" VALIGN=CENTER><A HREF="' + MURL +
              '" TARGET="_self"><B><FONT SIZE = "2">' + nm + '</FONT></B></TD><TD WIDTH="40%" VALIGN=CENTER ALIGN=CENTER><FONT SIZE="1">Expired</FONT></TD></TR>');
            FShowRed := true;
          end
          else
          begin
            SLx.Add('            <TR><TD WIDTH="60%" VALIGN=CENTER><FONT SIZE="1">' + nm +
              '</FONT></TD><TD WIDTH="40%" VALIGN=CENTER ALIGN=CENTER><FONT SIZE = "1"><FONT COLOR="#007F00"><B>On Subscription</B></FONT></FONT></TD></TR>');
          end;
        end;
      end
      else
      begin
        SLx.Add('            <TR><TD WIDTH="60%" VALIGN=CENTER><FONT SIZE="1">' + nm +
          '<FONT SIZE="1"></TD><TD WIDTH="40%"  VALIGN=CENTER ALIGN=CENTER><FONT SIZE="1"><I>Not Subscribed</I></FONT></TD></TR>');
      end;
    end;
    SLx.add('</FONT></FONT></TABLE></FONT>');

    MRUT := SLx.Text;
    if MRUT = '' then
      MRUT := '<FONT SIZE="1"><FONT FACE="Arial,Helvetica,Monaco">None</FONT></FONT><BR>';
    i           := pos('[CF]', FHTMLPg.Text);
    if i>0 then
      FHTMLPg.Text := copy(FHTMLPg.Text, 1, i - 1) + MRUT + copy(FHTMLPg.Text, i + 4, length(FHTMLPg.Text));

  {Insert Update Status}
    i := pos('[AUTOSTATUS]', FHTMLPg.Text);
    if UpdateAvail then
      MRUT := '<A HREF="[UPDATE]" TARGET="_self"><FONT SIZE="2">An update is available!</FONT></A><BR>'
    else
      MRUT := '<FONT SIZE="1">You have the latest version available.</FONT><BR>';
    if i>0 then
      FHTMLPg.Text := copy(FHTMLPg.Text, 1, i - 1) + MRUT + copy(FHTMLPg.Text, i + 12, length(FHTMLPg.Text));

    {Get News Links}
    slx.Clear;
    for i := 1 to 10 do
    begin
      LinkName := FRules.ReadString('WebsiteLinks', 'Link' + IntToStr(i) + 'Name', '');
      LinkURL  := FRules.ReadString('WebsiteLinks', 'Link' + IntToStr(i) + 'URL', '');
      if (LinkName <> '') and (LinkURL <> '') then
      begin
        if pos('DEFAULTPAGE',uppercase(LinkName))>0 then
            begin
              lastdefaultpage := LinkURL;

            end
            else
              slx.Add('           <FONT SIZE="1"><FONT FACE="Arial,Helvetica,Monaco"><A HREF="' + LinkURL +
                '" TARGET="_blank">' + LinkName + '</A></FONT></FONT><BR>');
      end;
    end;
    MRUT        := SLx.Text;
    MRUT        := MRUT + '<BR>';
    i           := pos('[WWW]', FLinks.Text);
      if i>0 then
    FLinks.Text := copy(FLinks.Text, 1, i - 1) + MRUT + copy(FLinks.Text, i + 5, length(FLinks.Text));

    {Get Promo Links}
    slx.Clear;
    for i := 1 to 10 do
    begin
      LinkName := FRules.ReadString('PromoLinks', 'Link' + IntToStr(i) + 'Name', '');
      LinkURL  := FRules.ReadString('PromoLinks', 'Link' + IntToStr(i) + 'URL', '');
      if (LinkName <> '') and (LinkURL <> '') then
      begin
        slx.Add('           <FONT SIZE="1"><FONT FACE="Arial,Helvetica,Monaco"><A HREF="' + LinkURL +
          '" TARGET="_blank">' + LinkName + '</A></FONT></FONT><BR>');
      end;
    end;
    MRUT        := SLx.Text;
    MRUT        := MRUT + '<BR>';
    i           := pos('[PROMO]', FHTMLPg.Text);
      if i>0 then
    FHTMLPg.Text := copy(FHTMLPg.Text, 1, i - 1) + MRUT + copy(FHTMLPg.Text, i + 7, length(FHTMLPg.Text));

    {Get BT Links}
    slx.Clear;
    for i := 1 to 10 do
    begin
      LinkName := FRules.ReadString('BTLinks', 'Link' + IntToStr(i) + 'Name', '');
      LinkURL  := FRules.ReadString('BTLinks', 'Link' + IntToStr(i) + 'URL', '');
      if (LinkName <> '') and (LinkURL <> '') then
      begin
        if pos('DEFAULTPAGE',uppercase(LinkName))>0 then
          begin
            lastdefaultpage := LinkURL;
            if FLastClickTalk<>LinkURL then
              FShowLinks := false;
          end;
        slx.Add('           <FONT SIZE="1"><FONT FACE="Arial,Helvetica,Monaco"><A HREF="' + LinkURL +
          '" TARGET="_blank">' + LinkName + '</A></FONT></FONT><BR>');
      end;
    end;

    MRUT        := SLx.Text;
    MRUT        := MRUT + '<BR>';
    i           := pos('[BTL]', FLinks.Text);
    if i>0 then
      FLinks.Text := copy(FLinks.Text, 1, i - 1) + MRUT + copy(FLinks.Text, i + 5, length(FLinks.Text));
  finally
    SLx.Free;
//    XReg.Free;
  end;
end;      *)

//-----------------------------------------------------------------------------
procedure TNewsDeskThread.doRegularUserStatus;
const
  msgNoServices = 'After logging in use the Service Usage Summary option from the Services menu to view your service status.';
//  msgNoServices = 'None';  // Original message prior to ver 8.0
var
  //daysRem:     integer;
  //daysRem2:    string;
  SLx:         TStringList;
//  XReg:        TRegistry;
  // f, p: integer
  i:     integer;
  //notsub:      boolean;
  MRUT:        string;
  //CompOp, CompOpTime: integer;
  //typ:         integer;
  //do2:         boolean;
  //{RegKy,} BURL, SVC, MURL, MXURL: string;
  //TempS, MaintExpDate, AvailVer: string;
  //nm, qty, exp, tmp, RealName: string;
  // SvcName: string;
  LinkName, LinkURL: string;
  //newcol: string;
  // UpdateResponse: integer;
begin
  SLx := TStringList.Create;
  try
   //the follow code replaced  with function BuildServicesHTML
   // Version 8.0.0 Removed population of SLX. Service usage is now only through the main menu.
   // SLX.Add(BuildServicesHTML);
  (*  notsub        := false;
    FShowRed      := false;


    //-----------------------------------------
    //        ClickForms Maintenance
    //-----------------------------------------
    MaintExpDate := FService[0];
    daysrem      := round(StringToDate(FService[0]) - Now);

    TempS := FRules.ReadString('Maintenance', 'Time', '1');
    p     := pos(',', TempS);
    if p > 0 then
      Temps := copy(TempS, 1, p - 1);
    CompOp := StrToInt(Temps);

    BURL := FRules.ReadString('Maintenance', 'URL', 'https://secure.appraisalworld.com/store/');
    SVC  := FRules.ReadString('Maintenance', 'WebSvc', '');
    if SVC <> '' then
      MURL := 'WebSvc' + SVC + '-' + BURL
    else
      MURL := BURL;
    MXURL := MURL;

    newcol := '<TD WIDTH="25%" VALIGN=CENTER ALIGN=CENTER BGCOLOR="SILVER"><FONT SIZE="1"><B>Expires</B></FONT></TD>';
    SLx.add('<FONT FACE="Arial,Helvetica,Monaco"><TABLE WIDTH="100%" CELLPADDING="0" CELLSPACING="0" BORDER="1"><FONT SIZE="1"><FONT FACE="Arial,Helvetica,Monaco">');
    AvailVer := '            <TR><TD WIDTH="60%" VALIGN=CENTER ALIGN=CENTER BGCOLOR="SILVER"><FONT SIZE="1"><B>Service</B></FONT></TD><TD WIDTH="15%" VALIGN=CENTER ALIGN=CENTER BGCOLOR="SILVER"><FONT SIZE="1"><B>Qty</B></FONT></TD>' + newcol + '</TR>';
    SLx.add(AvailVer);

    if daysrem>=0 then
      daysrem2:=inttostr(daysrem)
    else
      daysrem2:='<FONT COLOR="RED">Expired</FONT>';

    if daysrem < 0 then
    begin
      notsub   := true;
      AvailVer := '            <TR><TD WIDTH="60%" VALIGN=CENTER><A HREF="' + MURL +
        '" TARGET="_self"><B><FONT SIZE="1">ClickForms Maintenance</FONT></B>';
        AvailVer := AvailVer + '</TD><TD WIDTH="15%" VALIGN=CENTER>&nbsp</TD><TD WIDTH="25%" VALIGN=CENTER ALIGN=CENTER><FONT SIZE="1">'
          + '<FONT COLOR="RED">Expired</FONT></FONT></TD></TR>';

      SLx.add(AvailVer);

      FShowRed := true;
    end;

    if daysrem > 0 then
    begin
      if daysrem > CompOp then
        begin
          AvailVer := '            <TR><TD WIDTH="60%" VALIGN=CENTER><FONT SIZE="1">ClickForms Maintenance</FONT>';
            AvailVer := AvailVer + '</TD><TD WIDTH="15%" VALIGN=CENTER>&nbsp</TD><TD WIDTH="25%" VALIGN=CENTER ALIGN=CENTER><FONT SIZE="1">'
              + DaysOrDate(daysRem, FService[0]) + '</FONT></TD></TR>';
          SLx.add(AvailVer);
        end
      else
        begin
          AvailVer := '            <TR><TD WIDTH="60%" VALIGN=CENTER><A HREF="' + MURL +
            '" TARGET="_self"><B><FONT SIZE="1">ClickForms Maintenance</FONT></B>';
          AvailVer := AvailVer + '</TD><TD WIDTH="15%" VALIGN=CENTER>&nbsp</TD><TD WIDTH="25%" VALIGN=CENTER ALIGN=CENTER><FONT SIZE="1">'
              + DaysOrDate(daysRem, FService[0]) + '</FONT></TD></TR>';
          SLx.add(AvailVer);

          FShowRed := true;
        end;
    end;
    //-----------------------------------------
    //     Check for ClickForms Support
    //-----------------------------------------
    daysrem := round(StringToDate(FService[1]) - Now);

    TempS := FRules.ReadString('Live Support', 'Time', '1');
    p     := pos(',', TempS);
    if p > 0 then
      Temps := copy(TempS, 1, p - 1);
    CompOp := StrToInt(Temps);

    BURL := FRules.ReadString('Program', 'SupportURL', 'https://secure.appraisalworld.com/store/');
    SVC  := FRules.ReadString('Program', 'SupportWebSvc', '');
    if SVC <> '' then
      MURL := 'WebSvc' + SVC + '-' + BURL
    else
      MURL := BURL;
    if daysrem < 0 then
    begin
      AvailVer := '            <TR><TD WIDTH="60%" VALIGN=CENTER><A HREF="' + MURL +
        '" TARGET="_self"><FONT SIZE="1">ClickForms Support</FONT></A></TD><TD>&nbsp</TD><TD WIDTH="25%" VALIGN=CENTER ALIGN=CENTER><FONT SIZE="1">'
        + '<FONT COLOR="RED">Expired</FONT></FONT></TD></TR>';
      SLx.add(AvailVer);

      FShowRed := true;
    end;
    if daysrem > 0 then
    begin
      if daysrem > CompOp then
      begin
        AvailVer :=
          '            <TR><TD WIDTH="60%" VALIGN=CENTER><FONT SIZE="1">ClickForms Support</FONT></TD><TD>&nbsp</TD><TD WIDTH="25%" VALIGN=CENTER ALIGN=CENTER><FONT SIZE="1">'
          + DaysOrDate(daysRem, FService[1]) + '</FONT></TD></TR>';
        SLx.add(AvailVer);
      end
      else
      begin
        AvailVer := '            <TR><TD WIDTH="60%" VALIGN=CENTER><A HREF="' + MURL +
          '" TARGET="_self"><FONT SIZE="1">ClickForms Support</FONT></A></TD><TD>&nbsp</TD><TD WIDTH="25%" VALIGN=CENTER ALIGN=CENTER><FONT SIZE="1">'
          + DaysOrDate(daysRem, FService[1]) + '</FONT></TD></TR>';
        SLx.add(AvailVer);
        FShowRed  := true;
      end;
    end;

    //-----------------------------------------
    //       Other ClickForms Services
    //-----------------------------------------
    for f := 3 to FService.Count - 1 do
    begin
      CompOp     := 0;
      CompOpTime := 0;
      tmp        := FService[f];
      p          := pos('~', tmp);
      nm         := copy(tmp, 1, p - 1);
      tmp        := copy(tmp, p + 1, length(tmp));
      p          := pos('~', tmp);
      qty        := copy(tmp, 1, p - 1);
      tmp        := copy(tmp, p + 1, length(tmp));
      p          := pos('~', tmp);
      exp        := copy(tmp, 1, p-1);
      RealName   := copy(tmp,p+1, length(tmp));
      //nm :=RealName;

      BURL       := FRules.ReadString(nm, 'URL', 'https://secure.appraisalworld.com/store/');
      SVC        := FRules.ReadString(nm, 'WebSvc', '');
      if SVC <> '' then
        MURL := 'WebSvc' + SVC + '-' + BURL
      else
        MURL := BURL;

      if {(qty <>'NA') and }(qty <> 'Not Subscribed') and (qty <> 'None') and (exp<> 'Not Subscribed') then
        //and (qty<>'On Subscription') then
      begin
        typ := FRules.ReadInteger(nm, 'Method', 0);
        nm :=RealName;
        if typ = 3 then  //Dependent on Maintenance
        begin
          daysrem := round(StringToDate(FService[0]) - Now);
          daysrem2 := inttostr(daysrem);
          if notsub = true then
          begin
            daysrem2:='<FONT COLOR="RED"><FONT SIZE="1">Expired</FONT></FONT>';
            SLx.add('            <TR><TD WIDTH="60%" VALIGN=CENTER><A HREF="' + MURL +
              '" TARGET="_self"><B><FONT SIZE="1">' + nm +
              '</FONT></B></TD><TD WIDTH="15%" VALIGN=CENTER>&nbsp</TD><TD WIDTH="25%" VALIGN=CENTER ALIGN=CENTER>' +
              DaysOrDate(daysrem, FService[0]) + '</TD></TR>');
          end
          else
            SLx.Add('            <TR><TD WIDTH="60%" VALIGN=CENTER><FONT SIZE="1">' + nm +
              '</FONT></TD><TD WIDTH="15%" VALIGN=CENTER>&nbsp</TD><TD WIDTH="25%" VALIGN=CENTER ALIGN=CENTER><FONT SIZE="1">' +
              DaysOrDate(daysrem, FService[0]) + '</FONT></TD></TR>');
        end;

        if typ = 0 then  //Time Only
        begin
          if isdate(exp) then
            daysrem := round(StringToDate(exp) - Now)
          else
            daysrem := 0;

          TempS := FRules.ReadString(nm, 'Time', '0');
          p     := pos(',', TempS);
          if p > 0 then
            Temps := copy(TempS, 1, p - 1);
          CompOpTime := StrToInt(Temps);

          if daysrem <= CompOpTime then
          begin
            SLx.add('            <TR><TD WIDTH="60%" VALIGN=CENTER><A HREF="' + MURL +
              '" TARGET="_self"><B><FONT SIZE="1">' + nm +
              '</FONT></B></TD><TD WIDTH="15%" VALIGN=CENTER>&nbsp</TD><TD WIDTH="25%" VALIGN=CENTER ALIGN=CENTER><FONT SIZE="1">' +
                '<FONT COLOR="RED">Expired</FONT></FONT></TD></TR>');
          end
          else
          begin
            SLx.Add('            <TR><TD WIDTH="60%" VALIGN=CENTER><FONT SIZE="1">' + nm +
              '</FONT></TD><TD WIDTH="15%" VALIGN=CENTER>&nbsp</TD><TD WIDTH="25%" VALIGN=CENTER ALIGN=CENTER><FONT SIZE="1">' +
              DaysOrDate(daysRem, exp) + '</FONT></TD></TR>');
            FShowRed := true;
          end;
        end;

        if typ = 1 then //Units Only
        begin
          TempS := FRules.ReadString(nm, 'Units', '0');
          p     := pos(',', TempS);
          if p > 0 then
            Temps := copy(TempS, 1, p - 1);
          CompOp := StrToInt(Temps);

          if StrToInt(qty) <= CompOp then
          begin
            SLx.add('            <TR><TD WIDTH="60%" VALIGN=CENTER><A HREF="' + MURL +
              '" TARGET="_self"><B><FONT SIZE="1">' + nm + '</FONT></B></TD><TD WIDTH="15%" VALIGN=CENTER ALIGN=CENTER><FONT SIZE="1">' +
              qty + '</FONT></TD><TD WIDTH="25%" VALIGN=CENTER>&nbsp</TD></TR>');
          end
          else
          begin
            SLx.Add('            <TR><TD WIDTH="60%" VALIGN=CENTER><FONT SIZE="1">' + nm +
              '</FONT></TD><TD WIDTH="15%" VALIGN=CENTER ALIGN=CENTER><FONT SIZE="1">' + qty +
              '</TD><TD WIDTH="25%" VALIGN=CENTER>&nbsp</TD></TR>');
            FShowRed := true;
          end;
        end;

        if typ = 2 then //Time and Units
        begin
          if isdate(exp) then
            daysrem := round(StringToDate(exp) - Now)
          else
            daysrem := 0;

          TempS := FRules.ReadString(nm, 'Time', '0');
          p     := pos(',', TempS);
          if p > 0 then
            Temps := copy(TempS, 1, p - 1);
          CompOpTime := StrToInt(Temps);

          do2 := false;
          daysrem2:=inttostr(daysrem);
          if daysrem <= CompOpTime then
          begin
            do2 := true;
            daysrem2:='<FONT COLOR="RED">*Expired</FONT>';
          end;

          TempS := FRules.ReadString(nm, 'Units', '0');
          p     := pos(',', TempS);
          if p > 0 then
            Temps := copy(TempS, 1, p - 1);
          CompOp := StrToInt(Temps);

          if StrToInt(qty) <= CompOp then
            do2 := true;

          if do2 = true then
            begin
              SLx.add('            <TR><TD WIDTH="60%" VALIGN=CENTER><A HREF="' + MURL +
                '" TARGET="_self"><B><FONT SIZE = "1">' + nm + '</FONT></B></TD><TD WIDTH="15%" VALIGN=CENTER ALIGN=CENTER><FONT SIZE="1">' +
                qty + '</FONT></TD><TD ALIGN=CENTER><FONT SIZE="1">' + daysrem2 + ' days</FONT></TD></TR>');
            end
          else
            begin
              SLx.Add('            <TR><TD WIDTH="60%" VALIGN=CENTER><FONT SIZE="1">' + nm +
                '</FONT></TD><TD WIDTH="15%" VALIGN=CENTER ALIGN=CENTER><FONT SIZE = "1">' + qty +
                '</TD><TD ALIGN=CENTER><FONT SIZE="1">' + DaysOrDate(daysRem, exp) + '</FONT></TD></TR>');
              FShowRed := true;
            end;
        end;
        {Set Registry Info}
        if typ <> 3 then
        begin
          SvcName := '';
          if pos('MAR', Uppercase(nm)) > 0 then
            SvcName := 'swift';
          if pos('FLO', Uppercase(nm)) > 0 then
            SvcName := 'floodmaps';
          if pos('VERO', Uppercase(nm)) > 0 then
            SvcName := 'veros';
          if pos('FID', Uppercase(nm)) > 0 then
            SvcName := 'propertydata';
          if SvcName <> '' then
          begin
          end;
        end;
      end
      else
      begin
         SLx.Add('            <TR><TD WIDTH="60%" VALIGN=CENTER><FONT SIZE="1">' + nm +
            '</FONT></TD><TD WIDTH="15%" VALIGN=CENTER ALIGN=CENTER><FONT SIZE = "1">N/A' +
            '</TD><TD ALIGN=CENTER><FONT SIZE="1">N/A</FONT></TD></TR>');
      end;
    end;
    SLx.add('</FONT></FONT></TABLE></FONT>');     *)

    MRUT := SLx.Text;
    if MRUT = '' then
      MRUT := '<FONT SIZE="1"><FONT FACE="Arial,Helvetica,Monaco">' + msgNoServices + '</FONT></FONT><BR>';
    i  := pos('[CF]', FHTMLPg.Text);
    if i>0 then
    if i>0 then
        FHTMLPg.Text := copy(FHTMLPg.Text, 1, i - 1) + MRUT + copy(FHTMLPg.Text, i + 4, length(FHTMLPg.Text));

  {Insert Update Status}
    i := pos('[AUTOSTATUS]', FHTMLPg.Text);
    MRUT := '';
      if i>0 then
    FHTMLPg.Text := copy(FHTMLPg.Text, 1, i - 1) + MRUT + copy(FHTMLPg.Text, i + 12, length(FHTMLPg.Text));


    {Get News Links}
    slx.Clear;
    for i := 1 to 10 do
    begin
      LinkName := FRules.ReadString('WebsiteLinks', 'Link' + IntToStr(i) + 'Name', '');
      LinkURL  := FRules.ReadString('WebsiteLinks', 'Link' + IntToStr(i) + 'URL', '');
      if (LinkName <> '') and (LinkURL <> '') then
      begin
        if pos('DEFAULTPAGE',uppercase(LinkName))>0 then
          begin
            lastdefaultpage := LinkURL;
            if FLastClickTalk<>LinkURL then
              FShowLinks := false;
          end
          else
            slx.Add('           <FONT SIZE="1"><FONT FACE="Arial,Helvetica,Monaco"><A HREF="' + LinkURL +
              '" TARGET="_blank">' + LinkName + '</A></FONT></FONT><BR>');
      end;
    end;
    MRUT        := SLx.Text;
    MRUT        := MRUT + '<BR>';
    i := pos('[WWW]', FLinks.Text);
    if i>0 then
       FLinks.Text := copy(FLinks.Text, 1, i - 1) + MRUT + copy(FLinks.Text, i + 5, length(FLinks.Text));

    {Get Promo Links}
    slx.Clear;
    for i := 1 to 10 do
    begin
      LinkName := FRules.ReadString('PromoLinks', 'Link' + IntToStr(i) + 'Name', '');
      LinkURL  := FRules.ReadString('PromoLinks', 'Link' + IntToStr(i) + 'URL', '');
      if (LinkName <> '') and (LinkURL <> '') then
      begin
        if pos('DEFAULTPAGE',uppercase(LinkName))>0 then
          begin
            lastdefaultpage := LinkURL;
            if FLastClickTalk<>LinkURL then
              FShowLinks := false;
          end
          else
            slx.Add('           <FONT SIZE="1"><FONT FACE="Arial,Helvetica,Monaco"><A HREF="' + LinkURL +
              '" TARGET="_blank">' + LinkName + '</A></FONT></FONT><BR>');
      end;
    end;
    MRUT        := SLx.Text;
    MRUT        := MRUT + '<BR>';
    i           := pos('[PROMO]', FHTMLPg.Text);
    if i>0 then
      FHTMLPg.Text := copy(FHTMLPg.Text, 1, i - 1) + MRUT + copy(FHTMLPg.Text, i + 7, length(FHTMLPg.Text));

    {Get BT Links}
    slx.Clear;
    for i := 1 to 10 do
    begin
      LinkName := FRules.ReadString('BTLinks', 'Link' + IntToStr(i) + 'Name', '');
      LinkURL  := FRules.ReadString('BTLinks', 'Link' + IntToStr(i) + 'URL', '');
      if (LinkName <> '') and (LinkURL <> '') then
      begin
        if pos('DEFAULTPAGE',uppercase(LinkName))>0 then
          begin
            lastdefaultpage := LinkURL;
            if FLastClickTalk<>LinkURL then
              FShowLinks := false;
          end
          else
            slx.Add('           <FONT SIZE="1"><FONT FACE="Arial,Helvetica,Monaco"><A HREF="' + LinkURL +
              '" TARGET="_blank">' + LinkName + '</A></FONT></FONT><BR>');
      end;
    end;

    MRUT        := SLx.Text;
    MRUT        := MRUT + '<BR>';
    i           := pos('[BTL]', FLinks.Text);
    if i>0 then
      FLinks.Text := copy(FLinks.Text, 1, i - 1) + MRUT + copy(FLinks.Text, i + 5, length(FLinks.Text));
  finally
    SLx.Free;
//    XReg.Free;
  end;
end;

//-----------------------------------------------------------------------------
function TNewsDeskThread.BuildServicesHTML: String;
const
  htmlServicesHeader = '<TR>' +
                '<TD WIDTH="60%" VALIGN=CENTER ALIGN=CENTER BGCOLOR="SILVER"><FONT SIZE="1"><B>Service</B></FONT></TD>' +
                '<TD WIDTH="15%" VALIGN=CENTER ALIGN=CENTER BGCOLOR="SILVER"><FONT SIZE="1"><B>Qty</B></FONT></TD>' +
                '<TD WIDTH="25%" VALIGN=CENTER ALIGN=CENTER BGCOLOR="SILVER"><FONT SIZE="1"><B>Expires</B></FONT></TD>' +
                '</TR>';
  htmlServices = '<TABLE WIDTH="100%%" CELLPADDING="0" CELLSPACING="0" BORDER="1"><FONT SIZE="1" FACE="Arial,Helvetica,Monaco">' +
                '%s</FONT></TABLE';
  htmlNameTempl = '<TD WIDTH="60%%" VALIGN=CENTER><FONT SIZE="1">%s</FONT></TD>';
  htmlNameWLinkTempl = '<TD WIDTH="60%%" VALIGN=CENTER><A HREF="%s" TARGET="_self"><B><FONT SIZE="1">%s</FONT></B>';
  htmlUnitsTmpl = '<TD WIDTH="15%%" VALIGN=CENTER>%s</TD>';
  htmlExpiresTmpl = '<TD WIDTH="25%%" VALIGN=CENTER ALIGN=CENTER><FONT SIZE="1">%s</FONT></TD>';
  strEmpty = '&nbsp';
  strExpired = '<FONT COLOR="RED">Expired</FONT>';
  strNoUnits = '<FONT COLOR="RED">All spent</FONT>';
  strNotPurchased = 'Not Purchased';
  strDaysLeft = '%d days';
  DateOrDaysLimit = 30;
var
  htmlStr: String;
  service, nServices: Integer;
  expWarningRange, unitsWarningRange: Integer;
  status: ServiceInfo;
  CFUnitsLeft: Integer;
  bLink: Boolean;
  servName: String;
  tempStr: String;
  delimPos: Integer;
  storeLink, storeServName: String;
  expStr, unitsStr: String;
  daysBeforeExp: Integer;
  htmlExpires, htmlUnits, htmlName: String;
  CFExpDate, AWExpDate: TDateTime;
  AWExpDateStr: String;
  AWPIDIdx, AWUnitsLeft: Integer;
  AWUseOK: Boolean;
  AWResponse: clsGetUsageAvailabilityData;

begin
  htmlStr := htmlServicesHeader;

  nservices := GetServicesCount;
  for service:= 0 to nServices - 1 do
  begin
    status := GetServiceByIndex(service);
    CFUnitsLeft := Status.unitsLeft;
    bLink := False;

    //get service name in the Rules INI file
    servName := status.servName;
    case status.servID  of
      stMaintanence: servName := 'Maintenance'; //? name in ServiceWarning.txt differs what we wants to display
      stLiveSupport: servName := 'Live Support';  //the same
      stLocationMaps: servName := 'Maintenance';  //? Location maps does not have rules in  ServiceWarning.txt
    end;
    //get time range
    tempStr := FRules.ReadString(servName, 'Time', '0');
    delimPos := pos(',', tempStr);
    if delimPos > 0 then
      expWarningRange := StrToIntDef(copy(tempStr, 1, delimPos - 1),0)
    else
      expWarningRange := StrToIntDef(tempStr,0);
    //get units range
    tempStr := FRules.ReadString(servName, 'Units', '0');
    delimPos := pos(',', tempStr);
    if delimPos > 0 then
      unitsWarningRange := StrToIntDef(copy(tempStr, 1, delimPos - 1),0)
    else
      unitsWarningRange := StrToIntDef(tempStr,0);

    //get AW Store link
    storeLink := FRules.ReadString(servName, 'URL', 'https://secure.appraisalworld.com/store/');
    storeServName := FRules.ReadString(servName, 'WebSvc', '');
    if length(storeServName) > 0 then
      storeLink := 'WebSvc' + storeServName + '-' + storeLink;

    //build services html
    expStr := strNotPurchased; //default
    if status.status = notPurchased then
      begin
        unitsStr := strEmpty;
        bLink := True;
      end
    else if status.status = statusExpired then
      begin
        expStr := strExpired;
        unitsStr := strEmpty;
        bLink := True;
      end
    else if CompareText(status.expDate, ExpDateSubscr) = 0 then
      begin
        expStr := ExpDateSubscr;
        CFExpDate := StrToDateEx(status.expDate, 'MM/dd/yyyy','/');
        if CFUnitsLeft = notApplicable then
          begin
            CFUnitsLeft := 0;
            unitsStr := strEmpty;
          end
        else
          begin
            if CFUnitsLeft = 0 then
              begin
                unitsStr := strNoUnits;
                bLink := True;
              end
            else
              begin
                unitsStr := IntToStr(CFUnitsLeft);
                if CFUnitsLeft < unitsWarningRange then
                  bLink := true;
              end;
          end;
      end
    else
      begin
        CFExpDate := StrToDateEx(status.expDate, 'MM/dd/yyyy','/');
        if CFExpDate > 0 then //valid expiration date
          begin
            daysBeforeExp := DaysBetween(CFExpDate,Now);
            if daysBeforeExp < DateOrDaysLimit then
              expStr := Format(strDaysLeft,[daysBeforeExp])
            else
              expStr := status.expDate;
            if daysBeforeExp < expWarningRange then
              bLink := True;
            if CFUnitsLeft = notApplicable then
              begin
                CFUnitsLeft := 0;
                unitsStr := strEmpty;
              end
            else
              begin
                if CFUnitsLeft = 0 then
                  begin
                    unitsStr := strNoUnits;
                    bLink := True;
                  end
                else
                  begin
                    unitsStr := IntToStr(CFUnitsLeft);
                    if CFUnitsLeft < unitsWarningRange then
                      bLink := true;
                  end;
              end;
          end;
      end;

      // Now check AW to see if the expiration date and/or the number of units should be updated
      AWUnitsLeft := 0;
      AWExpDate := 0;
      AWPIDIdx := AnsiIndexStr(status.servName, pidCFUsageName);
      if AWPIDIdx >= 0 then
        begin
          AWUseOK := CurrentUser.OK2UseAWProduct(AWPIDIdx, AWResponse, True);
          if AWUseOK and (AWResponse <> nil) then
            begin
              AWUnitsLeft := AWResponse.AppraiserQuantity;
              AWExpDate := StrToDateEx(AWResponse.AppraiserExpirationDate, 'yyyy-mm-dd','-');
            end;
        end;
      if (AWExpDate > 0) then
        begin
          daysBeforeExp := DaysBetween(AWExpDate, Now);
          AWExpDateStr := DateToStr(AWExpDate);
          if (expStr = strNotPurchased) then
            begin
              if AWExpDate < Date then
                expStr := strExpired
              else
                begin
                  if daysBeforeExp < DateOrDaysLimit then
                    expStr := Format(strDaysLeft,[daysBeforeExp])
                  else
                    expStr := AWExpDateStr;
                  if AWUnitsLeft > 0 then
                    unitsStr := IntToStr(AWUnitsLeft);
                end;
            end
          else if (expStr = strExpired) then
            begin
              if AWExpDate >= Date then
                begin
                  if daysBeforeExp < DateOrDaysLimit then
                    expStr := Format(strDaysLeft,[daysBeforeExp])
                  else
                    expStr := AWExpDateStr;
                  if AWUnitsLeft > 0 then
                    unitsStr := IntToStr(AWUnitsLeft);
                end;
            end
          else if (expStr = ExpDateSubscr) then
            begin
              if AWExpDate >= CFExpDate then
                begin
                  if AWExpDate < Date then
                    expStr := strExpired
                  else if daysBeforeExp < DateOrDaysLimit then
                    expStr := Format(strDaysLeft,[daysBeforeExp])
                  else
                    expStr := AWExpDateStr;
                end;
              if AWUnitsLeft > 0 then
                unitsStr := IntToStr(CFUnitsLeft + AWUnitsLeft);
            end
          else
            begin
              if AWExpDate > CFExpDate then
                begin
                  if daysBeforeExp < DateOrDaysLimit then
                    expStr := Format(strDaysLeft,[daysBeforeExp])
                  else
                    expStr := AWExpDateStr;
                end;
              if AWUnitsLeft > 0 then
                unitsStr := IntToStr(CFUnitsLeft + AWUnitsLeft);
            end;
        end;

      htmlExpires := Format(htmlExpiresTmpl,[expStr]);
      htmlUnits := Format(htmlExpiresTmpl,[unitsStr]);
      if bLink then
        htmlName := Format(htmlNameWLinkTempl,[storeLink,status.servName])
      else
        htmlName := Format(htmlNameTempl,[status.servName]);

      htmlStr := htmlStr + '<TR>' +  htmlName + hTMLUnits + htmlExpires + '</TR>';
  end;
  result := Format(htmlServices,[htmlStr]);
end;

//-----------------------------------------------------------------------------
procedure TNewsDeskThread.doMRU;
var
  idx:  integer;
  SLx:  TStringList;
  MRUT: string;
begin
  SLx := TStringList.Create;
  try
    for idx := 0 to appPref_MRUS.Count - 1 do
      begin
        if (idx < 10) then //only want the top ten maximum of templates
        begin
          if FileExists(appPref_MRUS.Strings[idx]) then
            SLx.Add('<FONT SIZE="2"><FONT FACE="Arial,Helvetica,Monaco"><A HREF="file:' +
              appPref_MRUS.Strings[idx] + '" TARGET="_self">' + extractfilename(appPref_MRUS.Strings[idx]) + '</A></FONT></FONT><BR>');
        end;
      end;

    MRUT := SLx.Text;
    MRUT := MRUT + '<BR>';
    if MRUT = '' then
      MRUT := '<FONT SIZE="2"><FONT FACE="Arial,Helvetica,Monaco">None</FONT></FONT><BR>';

    idx := pos('[MRU]', FLinks.Text);
    if idx > 0 then
      FLinks.Text := copy(FLinks.Text, 1, idx - 1) + MRUT + copy(FLinks.Text, idx + 5, length(FLinks.Text));
  finally
    SLx.free;
  end;
end;

//-----------------------------------------------------------------------------
procedure TNewsDeskThread.doTemplates;
var
  i:    integer;
  SLx:  TStringList;
  MRUT: string;
begin
  SLx := TStringList.Create;
  try
    if AppTemplates.Count > 0 then
      for i := 0 to AppTemplates.Count - 1 do
        begin
          if i = 7 then
            break;
          SLx.Add('<FONT SIZE="2"><FONT FACE="Arial,Helvetica,Monaco"><A HREF="file:' + AppTemplates.Strings[i] +
            '" TARGET="_self">' + ExtractFileName(AppTemplates.Strings[i]) + '</A></FONT></FONT><BR>');
        end;
    MRUT := SLx.Text;
    if MRUT = '' then
      MRUT := '<FONT SIZE="2"><FONT FACE="Arial,Helvetica,Monaco">None</FONT></FONT><BR>';
    i := pos('[TEMPLATES]', FLinks.Text);
    if i > 0 then
      FLinks.Text := copy(FLinks.Text, 1, i - 1) + MRUT + copy(FLinks.Text, i + 11, length(FLinks.Text));
  finally
    SLx.Free;
  end;
end;


procedure TNewsDeskThread.LoadDefFiles;
var
  internetFile, localFileName: string;
  tempini: TIniFile;
  SServDate: String;        //server date returned
  SLocalDate: String;       //Local date
begin
  tempini := nil;
  FOK2Show := FShowNewsDesk;
  try

    {This is the default template for recent files, templates, news items}
    {This is displayed when there are no "urgent" items or when specifically chosen}
    {Always Get this file}
    internetFile := 'NewsDeskFilesTemplate.ssh';
    localFileName := NewsDeskBaseURL + internetFile;
      if GetInetFile(internetFile, localFileName)=true then
        begin
          repeat
          until (fileexists(localfilename)=true);// or (x = 200);
        end
        else
        begin
          FOK2Show := false;
          exit;
        end;
      copyfile(pchar(localFileName),pChar(NewsDeskBaseURL + 'Links.html'),false);
      localFileName := NewsDeskBaseURL + 'Links.html';
      FLinks.LoadFromFile(localfilename);

    {This is the template for displaying the ClickFlash notices}
    {Always Get this FIle}
    internetFile := 'ClickFlashTemplate.ssh';
    localFileName := NewsDeskBaseURL + internetFile;
        if GetInetFile(internetFile, localFileName) = true then
          begin
            repeat
            until (fileexists(localfilename)=true);// or (x = 200);
          end
          else
          begin
            FOK2Show := false;
            exit;
          end;
    copyfile(pchar(localFileName),pChar(NewsDeskBaseURL + 'CFFile.html'),false);
    localFileName := NewsDeskBaseURL + 'CFFile.html';

    {This is the image for the CLickFlash}
    {ONLY get this file if it doesn't exist}
    internetFile := 'ctheader.jpg';
    localFileName := NewsDeskBaseURL + 'ctheader.jpg';
    if fileexists(localfilename)=false then
    begin
     if GetInetFile(internetFile, localFileName) = true then
      begin
       repeat
       until (fileexists(localfilename)=true);// or (x = 200);
      end
      else
      begin
         FOK2Show := false;
         exit;
      end;
    end;

    {This is the framed index page into which the html pages are displayed}
    {Only get if doesn't exist}
    internetFile := cNewsDeskIndex;
    localFileName := NewsDeskBaseURL + cNewsDeskIndex;
    if fileexists(localFileName) = false then
    begin
      if GetInetFile(internetFile, localFileName) = true then
        begin
          repeat
          until (fileexists(localfilename)=true);// or (x = 200);
        end
        else
        begin
          FOK2Show := false;
          exit;
        end;
    end;

    {This is the default HTML template for the RIGHT frame which
      displays Promos, Update Availability, and Service Status}
    {Only get if doesnt exist}
    internetFile := NewsDesk_HTML_Template;
    localFileName := NewsDeskBaseURL + cNewsDeskSSH;
    if fileexists(localFileName)=false then
    begin
      if GetInetFile(internetFile, localFileName) = true then
        begin
          repeat
          until (fileexists(localfilename)=true);// or (x = 200);
        end
        else
        begin
          FOK2Show := false;
          exit;
        end;
    end;
    FHTMLPg.LoadFromFile(localFileName);

    {These are not only the rules at which level Service warnings are issued
     but also has the URL links to other items AND hold the
     "DefaultPage" URL}
    {Always Download this as this changes}
    internetFile  := ServiceWarning_Rules;
    localFileName := NewsDeskBaseURL + cServiceMsgRules;
      if GetInetFile(internetFile, localFileName) = true then
        begin
          repeat
          until (fileexists(localfilename)=true);// or (x = 200);
        end
        else
        begin
          FOK2Show := false;
          exit;
        end;

    FRules := TMemIniFile.Create(localFileName);    //delete on Destroy
    tempIni := TIniFile.Create(NewsDeskBaseURL + 'NewsDesk.ini');
    FEndMsg := tempini.ReadInteger('NEWSDESK','LastMessage',0);
    FLastClickTalk := tempini.ReadString('NEWSDESK','LastDefaultPage','');
    FStartMsg := GetFlashListNumber;
    GetStdLinks;
    if FShowAgain then
       FEndMsg := 0;
    if ((FStartMsg>FEndMsg) {and (FFromStartup=true)}) or (FShowAgain=true) then
      begin
        FOK2Show := True;
        FShowLinks := false;
        FShowNewsDesk := True;
        CreateMessages;
        tempini.WriteInteger('NEWSDESK','LastMessage',FStartMsg);
        loadmessages;
        FFromMessages := true;
      end
      else
      begin
        // force showing ClickTALK when the news has been updated
          SServDate  :=  DateTimeToStr(GetInetFileDate(NewsDeskURLPath + NewsDesk_HTML_ClickTALK));
          SLocalDate :=  tempini.ReadString(CINISectionNewsDesk, CINIValueLastDateViewed, '0');
        if SLocalDate <> SServDate then
          begin
            FOK2Show := True;
            FShowClickTalk := True;
            FShowLinks := False;
            FShowNewsDesk := True;
          end;
        //FShowLinks:=(FLastClickTalk=lastdefaultpage);
        if (FShowLinks=false) or (FShowCLickTalk=true) then
          begin
            FShowLinks := false;
            if FShowNewsDesk = false then
               FShowNewsDesk := (FLastClickTalk<>lastdefaultpage);
            FShowClickTalk := true;
            loadlastclicktalk(lastdefaultpage);
            tempini.WriteString('NEWSDESK','LastDefaultPage',lastdefaultpage);
          end
          else
          loadlinks;
      end;

    if FOK2Show and FShowNewsDesk then
       tempini.WriteString(CINISectionNewsDesk, CINIValueLastDateViewed,SServDate);
  except
    FOK2Show := False;
  end;

  tempini.Free;
end;


initialization

  CoInitializeEx(nil, COINIT_APARTMENTTHREADED);

finalization

  CoUninitialize();

end.
