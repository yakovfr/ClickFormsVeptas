unit CFThread;

interface

uses
  Classes {$IFDEF MSWINDOWS} , Windows {$ENDIF}, SysUtils, WinInet,
  {$IFNDEF VER180}ActiveX {$ELSE}OLE2{$ENDIF}, Graphics, Registry,
  UGlobals, UMyClickForms, UAutoUpdate;

type
  TMyCFThread = class(TThread)

    ShowNotify: boolean;
  private
    procedure SetName;
    procedure GetSummary;
    procedure SendResult;
    procedure doMRU;
    procedure dotemplates;
    procedure loadhtml;
    procedure dostatus;
    procedure doOnSubscription;
    procedure doTrialUser;
    //procedure loadrss(URL: string);
    function isdate(str: string): boolean;
    //function isnumeric(str: string): boolean;
    function GetInetFile(const fileURL, FileName: string): boolean;
    //function posnext(s, srch: string; lastpos: integer): integer;
    procedure MergeAllStatuses; {takes stauses returned and merges them with all statuses}
    function DaysOrDate(daysrem: integer; origDate: string): string;
  protected
    constructor Create(CreateSuspended: boolean);
    procedure Execute; override;
  end;

implementation

uses
  ULicUser,{ UStatus,} UWebConfig, {UWinUtils,} UMain, IniFiles,
  messagingservice, UWebUtils, Uutil1, UNotify;

var
  OK2Show: boolean;
  SL:      TStringList;
  SLMain:  TStringList;
  showred: boolean;
  showfloodwarning: boolean;

{$IFDEF MSWINDOWS}
type
  TThreadNameInfo = record
    FType:     longword;     // must be 0x1000
    FName:     PChar;        // pointer to name (in user address space)
    FThreadID: longword;     // thread ID (-1 indicates caller thread)
    FFlags:    longword;     // reserved for future use, must be zero
  end;

{$ENDIF}

{ TMyCFThread }
{
function TMyCFThread.posnext(s, srch: string; lastpos: integer): integer;
var
  t: string;
  x: integer;
begin
  t := copy(s, lastpos + length(srch), maxint);
  x := pos(srch, t);
  if x > 0 then
    Result := lastpos + x
  else
    Result := 0;
end;
}

{
function TMyCFThread.isnumeric(str: string): boolean;
var
  i: integer;
begin
  Result := true;
  try
    i := round(strtofloat(str));
  except
    Result := false;
  end;
end;
}


function TMyCFThread.DaysOrDate(daysrem: integer; origDate: string): string;
begin
    if daysrem>30 then
      Result := origDate
    else
      Result := inttostr(daysrem) + ' days';
end;


procedure TMyCFThread.MergeAllStatuses;
var
   FullServiceList: TStringList;
   i, f: integer;
   txtPos1, txtPos2: integer;
   FormalName, DisplayName, txt1, txt2, txt3, txt4: string;
   FoundMatch: boolean;
begin
   FullServiceList := TStringList.Create;
   FullServiceList.Add(SL[0]);
   FullServiceList.Add(SL[1]);
   FullServiceList.Add(SL[2]);
   FullServiceList.Add('Location Maps~Location Maps');
   FullServiceList.Add('AppraisalPort Connection~Appraisal Port Connection');
   FullServiceList.Add('Lighthouse Connection~Lighthouse Connection');
   FullServiceList.Add('Data Import Connection~Data Import Connection');
   FullServiceList.Add('Flood Maps~Flood Maps');
   FullServiceList.Add('Flood Risk Determination~Flood Data Only');
   FullServiceList.Add('Fidelity National Information Service~Fidelity Property Data');
   FullServiceList.Add('VeroValue Reports~VeroValue Reports');
//   FullServiceList.Add('MLS Connection~MLS Connection');
   FullServiceList.Add('Marshall & Swift Service~Marshall & Swift Service');

   sl.SaveToFile('c:\premerge.txt');

   for i:=3 to FullServiceList.Count-1 do
    begin
       FormalName := FullServiceList[i];
       txtPos1 := pos('~',FormalName);
       FormalName := copy(FormalName,1,txtPos1-1);
       DisplayName := copy(FullServiceList[i],txtPos1+1,length(FullServiceList[i]));
       f:=3;
       FoundMatch:=false;
       if sl.count>3 then
       begin
        Repeat
          txt1 := SL[f];
          if pos(uppercase(FormalName), uppercase(txt1))>0 then FOundMatch :=true;
          f := f + 1;
        Until FoundMatch or (f=SL.count);
       end;

       if foundmatch then
          FullServiceList[i] :=sl[f-1] + '~' + DisplayName
       else
          FullServiceList[i] := FormalName + '~None~Not Subscribed~' + DisplayName;

    end;
FullServiceList.SaveToFile('c:\MyFullServiceLis.txt');
sl.Assign(FullServiceList);
FullServiceList.Free;

end;

function TMyCFThread.isdate(str: string): boolean;
var
  dt: TDateTime;
begin
  Result := true;
  try
    dt := StrToDate(str);
  except
    Result := false;
  end;
end;

function TMyCFThread.GetInetFile(const fileURL, FileName: string): boolean;
const
  BufferSize = 1024;
var
  hSession, hURL: HInternet;
  Buffer:   array[1..10000] of byte;
  BufferLen: DWORD;
  f:        file;
  sAppName: string;
  Flags:    DWord;
begin

  Result := false;
  if InternetGetConnectedState(@flags, 0) = false then
    exit;

  sAppName := 'CFN.txt';//ExtractFileName(Application.ExeName) ;
  hSession := InternetOpen(PChar(sAppName), INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);
  try
    hURL := InternetOpenURL(hSession, PChar(fileURL), nil, 0, 0, 0);
    try
      AssignFile(f, FileName);
      Rewrite(f, 1);
      repeat
        InternetReadFile(hURL, @Buffer, SizeOf(hURL), BufferLen);
        BlockWrite(f, Buffer, BufferLen);
      until BufferLen = 0;
      CloseFile(f);
      Result := true;
    finally
      InternetCloseHandle(hURL)
    end
  finally
    InternetCloseHandle(hSession);
  end;
end;


constructor TMyCFThread.Create(createSuspended: boolean);
begin
  inherited Create(CreateSuspended);
  FreeOnTerminate := true;

end;

procedure TMyCFThread.SetName;
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
  FreeOnTerminate          := true;
  try
    RaiseException($406D1388, 0, sizeof(ThreadNameInfo) div sizeof(longword), @ThreadNameInfo);
  except
  end;
{$ENDIF}
end;

procedure TMyCFThread.SendResult;
begin
  try
    if OK2Show = true then
    begin
      SLMain.SaveToFile(IncludeTrailingPathDelimiter(AppPref_DirPref) + 'CFNTest.html');
      if showred then
      begin
        main.styler2.RightHandleColor   := clRed;
        main.styler2.RightHandleColorTo := clMaroon;
      end
      else
      begin
        main.styler2.RightHandleColor   := $00F1A675;
        main.styler2.righthandlecolorto := $00913500;
      end;
      if ShowNotify = true then
        begin
          if showfloodwarning then sl.Insert(0,'OK');
          main.ShowServiceStatus(SL);
        end;
      SL.Free;
    end
  except
  end;
end;

procedure TMyCFThread.Execute;
var UserType: integer;
begin
  FreeOnTerminate := true;
  OK2Show         := false;
  showfloodwarning:=false;
  SetName;
  SLMain := TStringList.Create;
  if fileexists(IncludeTrailingPathDelimiter(AppPref_DirPref) + 'CFNTest.html') then
    deletefile(IncludeTrailingPathDelimiter(AppPref_DirPref) + 'CFNTest.html');
  GetSummary;
  MergeAllStatuses;

  if OK2Show = false then
    exit;
  loadhtml;
  //  GetInetFile('http://originatortimes.com/content/rss.aspx','c:\myTest.xml');
  if OK2Show = false then
    exit;
  doMRU;

UserType:=1; //0 = unsubscribed, 1 = On Subscription, 2 = Standard User

  Case UserType of
    0:  doTrialUser;
    1:  doOnSubscription;
    2:  dostatus;
  end;

  dotemplates;

  Synchronize(SendResult);

end;

procedure TMyCFThread.GetSummary;
var
  StatusArray:   ArrayOfServiceStatus;
  expDate:       TDateTime;
  i, iCustID:    integer;
  sMsg:          WideString;
  st1, st2, st3: string;
  IsConnected:   boolean;
  flags:         DWord;
  TempSL: TStringList;
begin
  iCustID := StrToIntDef(CurrentUser.LicInfo.UserCustID, 0);

  if iCustID = 0 then
    exit;
{    begin
      SL:=TStringlist.Create;
      SL.Add('  </P>  <P ALIGN=CENTER>');
      SL.Add('       <B><I><FONT FACE="Verdana,Arial,Times New I2"><A HREF="https://secure.appraisalworld.com/store/" TARGET="_blank">Buy ClickForms<FONT SIZE="2"><SUP>(TM)</SUP></FONT> Online Now</A></FONT></I></B><BR>');
      SL.Add('       <B><I><FONT FACE="Verdana,Arial,Times New I2"></FONT></I></B><BR>  <B><FONT FACE="Verdana,Arial,Times New I2">or</FONT></B><BR>');
      SL.Add('       <B><I><FONT FACE="Verdana,Arial,Times New I2"></FONT></I></B><BR>  <B><I><FONT FACE="Verdana,Arial,Times New I2">Call 1-800-622-URAR</FONT></I></B></TD>');
      OK2SHow:=true;
      doMRU;
      dotemplates;
      dostatus;
      exit;
    end;}
  try
    CoInitialize(nil);
    IsConnected := InternetGetConnectedState(@flags, 0);

    if IsConnected then
    begin
      SL := TStringList.Create;
      TempSL:= TStringList.Create;
      try
        with GetMessagingServiceSoap(true, UWebConfig.GetURLForClientMessaging) do
        begin
          try
            try
              GetServiceStatusSummary(iCustID, WSMessaging_Password, StatusArray, sMsg);

              //set the software maintenance expriation date
              expDate := StatusArray[0].ExpiresOn.AsDateTime;
              SL.Add(datetostr(expDate));
              TempSL.add(statusarray[0].ServiceName + ', ' + Statusarray[0].CurrentStatus + ', ' + datetostr(statusArray[0].ExpiresOn.AsDateTime));
              //set the LiveSupport expiration date
              expDate := StatusArray[1].ExpiresOn.AsDateTime;
              SL.Add(datetostr(expDate));
              TempSL.add(statusarray[1].ServiceName + ', ' + Statusarray[1].CurrentStatus + ', ' + datetostr(statusArray[1].ExpiresOn.AsDateTime));

              //set the AppraisalWorld Connection expiration date
              expDate := StatusArray[2].ExpiresOn.AsDateTime;    //commented by vivek 05/07/2007
              SL.Add(datetostr(expDate));
              TempSL.add(statusarray[2].ServiceName + ', ' + Statusarray[2].CurrentStatus + ', ' + datetostr(statusArray[2].ExpiresOn.AsDateTime));

            except
              exit;
            end;

            //now display the data

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
                if (StatusArray[i].ExpiresOn.AsDateTime < StrToDateTime('01/01/2002')) then  //changed by Vivek 05/07/2007
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

                sl.Add(st1 + '~' + st2 + '~' + st3);
              end;

            finally
              // free all the elements of this array
              for i := 0 to Length(StatusArray) - 1 do
                StatusArray[i].Free;
            end;
            OK2SHow := true;

          except
          end;
        end;
      except
        exit;
      end;
    end;
  except
    exit;
  end;
  CoUninitialize;
end;

procedure TMyCFThread.dostatus;
var
  daysrem:     integer;
  daysrem2: string;
  SLx:         TStringList;
  f, p, i:     integer;
  notsub:      boolean;
  nm, qty, exp, tmp, RealName: string;
  MRUT:        string;
  CompOp, CompOpTime: integer;
  typ:         integer;
  Rules:       TMemIniFile;
  internetFile, localFileName: string;
  do2:         boolean;
  RegKy, BURL, SVC, MURL, MXURL: string;
  XReg:        TRegistry;
  SvcName, LinkName, LinkURL: string;
  UpdateAvail: boolean;
  TempS, MaintExpDate, AvailVer: string;
  newcol: string;
  daysremstring: string;
begin
  RegKy        := MyFolderPrefs.basekey;
  XReg         := TRegistry.Create;
  XReg.RootKey := HKEY_CURRENT_USER;
  //XReg.OpenKey(RegKy, True);

  SLx := TStringList.Create;


  UpdateAvail := (AutoUpdateStatus.UpdateAvailable = 1);

  notsub        := false;
  showred       := false;
  internetFile  := NewsDesk_Rules;
  localFileName := IncludeTrailingPathDelimiter(AppPref_DirPref) + 'CNTest.rul';
  try
    GetInetFile(internetFile, localFileName);
  except
    OK2Show := false;
    exit;
  end;

  Rules := TMemIniFile.Create(IncludeTrailingPathDelimiter(AppPref_DirPref) + 'CNTest.rul');

  MaintExpDate := SL[0];
  daysrem      := round(strtodate(sl[0]) - now);

  TempS := Rules.ReadString('Maintenance', 'Time', '1');
  p     := pos(',', TempS);
  if p > 0 then
    Temps := copy(TempS, 1, p - 1);
  CompOp := StrToInt(Temps);

  BURL := Rules.ReadString('Maintenance', 'URL', 'https://secure.appraisalworld.com/store/');
  SVC  := Rules.ReadString('Maintenance', 'WebSvc', '');
  if SVC <> '' then
    MURL := 'WebSvc' + SVC + '-' + BURL
  else
    MURL := BURL;
  MXURL := MURL;

  newcol := '<TD WIDTH="25%" VALIGN=CENTER ALIGN=CENTER BGCOLOR="SILVER"><FONT SIZE="2"><B>Expires</B></FONT></TD>';
  SLx.add('<FONT FACE="Arial,Helvetica,Monaco"><TABLE WIDTH="100%" CELLPADDING="0" CELLSPACING="0" BORDER="1"><FONT SIZE="2"><FONT FACE="Arial,Helvetica,Monaco">');
  AvailVer := '            <TR><TD WIDTH="60%" VALIGN=CENTER ALIGN=CENTER BGCOLOR="SILVER"><FONT SIZE="2"><B>Service</B></FONT></TD><TD WIDTH="15%" VALIGN=CENTER ALIGN=CENTER BGCOLOR="SILVER"><FONT SIZE="2"><B>Qty</B></FONT></TD>' + newcol + '</TR>';
  SLx.add(AvailVer);

  if daysrem>=0 then
    daysrem2:=inttostr(daysrem)
  else
    daysrem2:='<FONT COLOR="RED">Expired</FONT>';

  if daysrem < 0 then
  begin
    notsub   := true;
    AvailVer := '            <TR><TD WIDTH="60%" VALIGN=CENTER><A HREF="' + MURL +
      '" TARGET="_self"><B><FONT SIZE="2">ClickForms Maintenance</FONT></B>';
      AvailVer := AvailVer + '</TD><TD WIDTH="15%" VALIGN=CENTER>&nbsp</TD><TD WIDTH="25%" VALIGN=CENTER ALIGN=CENTER><FONT SIZE="2">'
        + '<FONT COLOR="RED">Expired</FONT></FONT></TD></TR>';

    SLx.add(AvailVer);

    showred := true;
  end;

  if daysrem > 0 then
  begin

    if daysrem > CompOp then
    begin
      AvailVer := '            <TR><TD WIDTH="60%" VALIGN=CENTER><FONT SIZE="2">ClickForms Maintenance</FONT>';
        AvailVer := AvailVer + '</TD><TD WIDTH="15%" VALIGN=CENTER>&nbsp</TD><TD WIDTH="25%" VALIGN=CENTER ALIGN=CENTER><FONT SIZE="2">'
          + DaysorDate(daysrem,SL[0]) + '</FONT></TD></TR>';
      SLx.add(AvailVer);
    end
    else
    begin
      AvailVer := '            <TR><TD WIDTH="60%" VALIGN=CENTER><A HREF="' + MURL +
        '" TARGET="_self"><B><FONT SIZE="2">ClickForms Maintenance</FONT></B>';
        AvailVer := AvailVer + '</TD><TD WIDTH="15%" VALIGN=CENTER>&nbsp</TD><TD WIDTH="25%" VALIGN=CENTER ALIGN=CENTER><FONT SIZE="2">'
          + DaysorDate(daysrem,SL[0]) + '</FONT></TD></TR>';
      SLx.add(AvailVer);

      showred := true;
    end;
  end;

  {Set Registry Info}
  XReg.OpenKey(RegKy + '\renewal', true);
  XReg.WriteString('Name', 'renewal');
  XReg.WriteInteger('Qty', daysrem);
  XReg.WriteDate('ExpDate', strtodate(sl[0]));
  XReg.WriteInteger('RuleType', 0);
  XReg.WriteInteger('QtyRule', 0);
  XReg.WriteInteger('TimeRule', CompOp);
  XReg.WriteString('URL', BURL);
  XReg.WriteString('WebSvc', SVC);
  if XReg.KeyExists('RequiresNotification') = false then
    XReg.WriteBool('RequiresNotification', showred);
  XReg.WriteDate('LastCheckDate', date);
  XReg.closekey;

  //Check for ClickForms Support
  daysrem := round(strtodate(sl[1]) - now);

  TempS := Rules.ReadString('Live Support', 'Time', '1');
  p     := pos(',', TempS);
  if p > 0 then
    Temps := copy(TempS, 1, p - 1);
  CompOp := StrToInt(Temps);

  BURL := Rules.ReadString('Program', 'SupportURL', 'https://secure.appraisalworld.com/store/');
  SVC  := Rules.ReadString('Program', 'SupportWebSvc', '');
  if SVC <> '' then
    MURL := 'WebSvc' + SVC + '-' + BURL
  else
    MURL := BURL;
  if daysrem < 0 then
  begin
    AvailVer := '            <TR><TD WIDTH="60%" VALIGN=CENTER><A HREF="' + MURL +
      '" TARGET="_self"><FONT SIZE="2">ClickForms Support</FONT></A></TD><TD>&nbsp</TD><TD WIDTH="25%" VALIGN=CENTER ALIGN=CENTER><FONT SIZE="2">'
      + '<FONT COLOR="RED">Expired</FONT></FONT></TD></TR>';
    SLx.add(AvailVer);

    showred := true;
  end;
  if daysrem > 0 then
  begin

    if daysrem > CompOp then
    begin
      AvailVer :=
        '            <TR><TD WIDTH="60%" VALIGN=CENTER><FONT SIZE="2">ClickForms Support</FONT></TD><TD>&nbsp</TD><TD WIDTH="25%" VALIGN=CENTER ALIGN=CENTER><FONT SIZE="2">'
        + DaysorDate(daysrem,SL[1]) + ' days</FONT></TD></TR>';
      SLx.add(AvailVer);
    end
    else
    begin
      AvailVer := '            <TR><TD WIDTH="60%" VALIGN=CENTER><A HREF="' + MURL +
        '" TARGET="_self"><FONT SIZE="2">ClickForms Support</FONT></A></TD><TD>&nbsp</TD><TD WIDTH="25%" VALIGN=CENTER ALIGN=CENTER><FONT SIZE="2">'
        + DaysorDate(daysrem,SL[1]) + '</FONT></TD></TR>';
      SLx.add(AvailVer);
      showred  := true;
    end;
  end;

  {Set Registry Info}
  XReg.RootKey := HKEY_CURRENT_USER;
  XReg.OpenKey(RegKy + '\livesupport', true);
  XReg.WriteString('Name', 'livesupport');
  XReg.WriteInteger('Qty', daysrem);
  XReg.WriteDate('ExpDate', strtodate(sl[0]));
  XReg.WriteInteger('RuleType', 0);
  XReg.WriteInteger('QtyRule', 0);
  XReg.WriteInteger('TimeRule', CompOp);
  XReg.WriteString('URL', BURL);
  XReg.WriteString('WebSvc', SVC);
  if XReg.KeyExists('RequiresNotification') = false then
    XReg.WriteBool('RequiresNotification', showred);
  XReg.WriteDate('LastCheckDate', date);
  XReg.CloseKey;

  //Check Appraisal World Subscription
  {
  daysrem:=round(strtodate(sl[2])-now);
  CompOp:=Rules.ReadInteger('Program','AppraisalWorld',1);
  MURL:=Rules.ReadString('Program','AppraisalWorldURL','https://secure.appraisalworld.com/store/');
  if daysrem<0 then
  begin
//    notsub:=true;
    SLx.Add('       <FONT SIZE="2"><FONT FACE="Arial,Helvetica,Monaco"><A HREF="' + MURL + '" TARGET="_self"><B>AppraisalWorld Membership Has Expired</B></FONT></A></FONT></FONT><BR>');
    SLx.add('       <FONT SIZE="2"><FONT FACE="Arial,Helvetica,Monaco">&nbsp;&nbsp;&nbsp;<A HREF="' + MURL + '" TARGET="_self">Order Online</A></FONT></FONT><BR>');
  end;
  if daysrem>0 then
  begin
    if daysrem>CompOp then
    begin
      SLx.Add('       <FONT SIZE="2"><FONT FACE="Arial,Helvetica,Monaco"><I>AppraisalWorld Membership</I> has ' + inttostr(daysrem) + ' days remaining.</FONT></FONT><BR>');
    end
    else
    begin
      SLx.Add('       <FONT SIZE="2"><FONT FACE="Arial,Helvetica,Monaco"><A HREF="' + MURL + '" TARGET="_self"><I>AppraisalWorld Membership</I> has only ' + inttostr(daysrem) + ' days remaining.</FONT></FONT><BR>');
      SLx.add('       <FONT SIZE="2"><FONT FACE="Arial,Helvetica,Monaco">&nbsp;&nbsp;&nbsp;<A HREF="' + MURL + '" TARGET="_self">Order Online</A></FONT></FONT><BR>');
    end;
  end;
}




  for f := 3 to sl.Count - 1 do
  begin
    CompOp     := 0;
    CompOpTime := 0;
    tmp        := sl[f];
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


    BURL       := Rules.ReadString(nm, 'URL', 'https://secure.appraisalworld.com/store/');
    SVC        := Rules.ReadString(nm, 'WebSvc', '');
    if SVC <> '' then
      MURL := 'WebSvc' + SVC + '-' + BURL
    else
      MURL := BURL;

    if {(qty <>'NA') and }(qty <> 'Not Subscribed') and (qty <> 'None') and (exp<> 'Not Subscribed') then
      //and (qty<>'On Subscription') then
    begin
      typ := Rules.ReadInteger(nm, 'Method', 3);
      if typ = 3 then  //Dependent on Maintenance
      begin
      daysrem := round(strtodate(sl[0]) - now);

      daysrem2 := inttostr(daysrem);
        if notsub = true then
        begin
          daysrem2:='<FONT COLOR="RED"><FONT SIZE="2">Expired</FONT></FONT>';
          SLx.add('            <TR><TD WIDTH="60%" VALIGN=CENTER><A HREF="' + MURL +
            '" TARGET="_self"><B><FONT SIZE="2">' + nm +
            '</FONT></B></TD><TD WIDTH="15%" VALIGN=CENTER>&nbsp</TD><TD WIDTH="25%" VALIGN=CENTER ALIGN=CENTER>' +
            daysrem2 + '</TD></TR>');
        end
        else
          SLx.Add('            <TR><TD WIDTH="60%" VALIGN=CENTER><FONT SIZE="2">' + nm +
            '</FONT></TD><TD WIDTH="15%" VALIGN=CENTER>&nbsp</TD><TD WIDTH="25%" VALIGN=CENTER ALIGN=CENTER><FONT SIZE="2">' +
            daysrem2 + '</FONT></TD></TR>');
      end;
      if typ = 0 then  //Time Only
      begin
        if isdate(exp) then
          daysrem := round(strtodate(exp) - now)
        else
          daysrem := 0;

        TempS := Rules.ReadString(nm, 'Time', '0');
        p     := pos(',', TempS);
        if p > 0 then
          Temps := copy(TempS, 1, p - 1);
        CompOpTime := StrToInt(Temps);

        if daysrem <= CompOpTime then
        begin
          SLx.add('            <TR><TD WIDTH="60%" VALIGN=CENTER><A HREF="' + MURL +
            '" TARGET="_self"><B><FONT SIZE="2">' + nm +
            '</FONT></B></TD><TD WIDTH="15%" VALIGN=CENTER>&nbsp</TD><TD WIDTH="25%" VALIGN=CENTER ALIGN=CENTER><FONT SIZE="2">' +
              '<FONT COLOR="RED">Expired</FONT></FONT></TD></TR>');
        end
        else
        begin
          SLx.Add('            <TR><TD WIDTH="60%" VALIGN=CENTER><FONT SIZE="2">' + nm +
            '</FONT></TD><TD WIDTH="15%" VALIGN=CENTER>&nbsp</TD><TD WIDTH="25%" VALIGN=CENTER ALIGN=CENTER><FONT SIZE="2">' +
            DaysorDate(daysrem,exp) + '</FONT></TD></TR>');
          showred := true;
        end;
      end;

      if typ = 1 then //Units Only
      begin
        TempS := Rules.ReadString(nm, 'Units', '0');
        p     := pos(',', TempS);
        if p > 0 then
          Temps := copy(TempS, 1, p - 1);
        CompOp := StrToInt(Temps);

        if StrToInt(qty) <= CompOp then
        begin
          SLx.add('            <TR><TD WIDTH="60%" VALIGN=CENTER><A HREF="' + MURL +
            '" TARGET="_self"><B><FONT SIZE="2">' + nm + '</FONT></B></TD><TD WIDTH="15%" VALIGN=CENTER ALIGN=CENTER><FONT SIZE="2">' +
            qty + '</FONT></TD><TD WIDTH="25%" VALIGN=CENTER>&nbsp</TD></TR>');
        end
        else
        begin
          SLx.Add('            <TR><TD WIDTH="60%" VALIGN=CENTER><FONT SIZE="2">' + nm +
            '</FONT></TD><TD WIDTH="15%" VALIGN=CENTER ALIGN=CENTER><FONT SIZE="2">' + qty +
            '</TD><TD WIDTH="25%" VALIGN=CENTER>&nbsp</TD></TR>');
          showred := true;
        end;
      end;

      if typ = 2 then //Time and Units
      begin
        if isdate(exp) then
          daysrem := round(strtodate(exp) - now)
        else
          daysrem := 0;

        TempS := Rules.ReadString(nm, 'Time', '0');
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

        TempS := Rules.ReadString(nm, 'Units', '0');
        p     := pos(',', TempS);
        if p > 0 then
          Temps := copy(TempS, 1, p - 1);
        CompOp := StrToInt(Temps);

        if StrToInt(qty) <= CompOp then
          do2 := true;

        if do2 = true then
        begin
          showfloodwarning:=true;
          SLx.add('            <TR><TD WIDTH="60%" VALIGN=CENTER><A HREF="' + MURL +
            '" TARGET="_self"><B><FONT SIZE = "2">' + nm + '</FONT></B></TD><TD WIDTH="15%" VALIGN=CENTER ALIGN=CENTER><FONT SIZE="2">' +
            qty + '</FONT></TD><TD ALIGN=CENTER><FONT SIZE="2">' + daysrem2 + '</FONT></TD></TR>');
        end
        else
        begin
          SLx.Add('            <TR><TD WIDTH="60%" VALIGN=CENTER><FONT SIZE="2">' + nm +
            '</FONT></TD><TD WIDTH="15%" VALIGN=CENTER ALIGN=CENTER><FONT SIZE = "2">' + qty +
            '</TD><TD ALIGN=CENTER><FONT SIZE="2">' + DaysorDate(daysrem,exp) + ' days</FONT></TD></TR>');
          showred := true;
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
          XReg.RootKey := HKEY_CURRENT_USER;
          XReg.OpenKey(RegKy + '\' + SvcName, true);
          XReg.WriteString('Name', SvcName);
          XReg.WriteInteger('Qty', StrToInt(qty));
          if isdate(exp) = false then
            exp := '01/01/2005';
          XReg.WriteDate('ExpDate', strtodate(exp));
          XReg.WriteInteger('RuleType', typ);
          XReg.WriteInteger('QtyRule', CompOp);
          XReg.WriteInteger('TimeRule', CompOpTime);
          XReg.WriteString('URL', BURL);
          XReg.WriteString('WebSvc', SVC);
          if XReg.KeyExists('RequiresNotification') = false then
            XReg.WriteBool('RequiresNotification', showred);
          XReg.WriteDate('LastCheckDate', date);
          XReg.CloseKey;
        end;
      end;
    end
    else
    begin
         SLx.Add('            <TR><TD WIDTH="60%" VALIGN=CENTER><FONT SIZE="2">' + nm +
            '</FONT></TD><TD WIDTH="15%" VALIGN=CENTER ALIGN=CENTER><FONT SIZE = "2">N/A' +
            '</TD><TD ALIGN=CENTER><FONT SIZE="2">N/A</FONT></TD></TR>');

    end;;
  end;
  SLx.add('</FONT></FONT></TABLE></FONT>');

  MRUT := SLx.Text;
  if MRUT = '' then
    MRUT := '<FONT SIZE="2"><FONT FACE="Arial,Helvetica,Monaco">None</FONT></FONT><BR>';
  i           := pos('[CF]', SLMain.Text);
  SLMain.Text := copy(SLMain.Text, 1, i - 1) + MRUT + copy(SLMain.Text, i + 4, length(SLMain.Text));

{Insert Update Status}
  i := pos('[AUTOSTATUS]', SLMain.Text);
  if UpdateAvail then
    MRUT := '<A HREF="[UPDATE]" TARGET="_self"><FONT SIZE="3">An update is available!</FONT></A><BR>'
  else
    MRUT := '<FONT SIZE="2">You have the latest version available.</FONT><BR>';
  SLMain.Text := copy(SLMain.Text, 1, i - 1) + MRUT + copy(SLMain.Text, i + 12, length(SLMain.Text));



  {Get News Links}
  slx.Clear;
  for i := 1 to 10 do
  begin
    LinkName := Rules.ReadString('WebsiteLinks', 'Link' + IntToStr(i) + 'Name', '');
    LinkURL  := Rules.ReadString('WebsiteLinks', 'Link' + IntToStr(i) + 'URL', '');
    if (LinkName <> '') and (LinkURL <> '') then
    begin
      slx.Add('           <FONT SIZE="2"><FONT FACE="Arial,Helvetica,Monaco"><A HREF="' + LinkURL +
        '" TARGET="_blank">' + LinkName + '</A></FONT></FONT><BR>');
    end;
  end;
  MRUT        := SLx.Text;
  MRUT        := MRUT + '<BR>';
  i           := pos('[WWW]', SLMain.Text);
  SLMain.Text := copy(SLMain.Text, 1, i - 1) + MRUT + copy(SLMain.Text, i + 5, length(SLMain.Text));

  {Get Promo Links}
  slx.Clear;
  for i := 1 to 10 do
  begin
    LinkName := Rules.ReadString('PromoLinks', 'Link' + IntToStr(i) + 'Name', '');
    LinkURL  := Rules.ReadString('PromoLinks', 'Link' + IntToStr(i) + 'URL', '');
    if (LinkName <> '') and (LinkURL <> '') then
    begin
      slx.Add('           <FONT SIZE="2"><FONT FACE="Arial,Helvetica,Monaco"><A HREF="' + LinkURL +
        '" TARGET="_blank">' + LinkName + '</A></FONT></FONT><BR>');
    end;
  end;
  MRUT        := SLx.Text;
  MRUT        := MRUT + '<BR>';
  i           := pos('[PROMO]', SLMain.Text);
  SLMain.Text := copy(SLMain.Text, 1, i - 1) + MRUT + copy(SLMain.Text, i + 7, length(SLMain.Text));

  {Get BT Links}
  slx.Clear;
  for i := 1 to 10 do
  begin
    LinkName := Rules.ReadString('BTLinks', 'Link' + IntToStr(i) + 'Name', '');
    LinkURL  := Rules.ReadString('BTLinks', 'Link' + IntToStr(i) + 'URL', '');
    if (LinkName <> '') and (LinkURL <> '') then
    begin
      slx.Add('           <FONT SIZE="2"><FONT FACE="Arial,Helvetica,Monaco"><A HREF="' + LinkURL +
        '" TARGET="_blank">' + LinkName + '</A></FONT></FONT><BR>');
    end;
  end;
  MRUT        := SLx.Text;
  MRUT        := MRUT + '<BR>';
  i           := pos('[BTL]', SLMain.Text);
  SLMain.Text := copy(SLMain.Text, 1, i - 1) + MRUT + copy(SLMain.Text, i + 5, length(SLMain.Text));



{
RSSURL:=Rules.ReadString('RSS','URL','');
if RSSURL<>'' then
  loadrss(RSSURL);
}

end;

{
procedure TMyCFThread.loadrss(URL: string);
var
  Sl, SLx:        TStringList;
  p1, p2, i:      integer;
  HCaption, HURL: string;
  MRUT, XText:    string;
begin
  SLx   := TStringList.Create;
  SL    := TStringList.Create;
  //Originator Time > 'http://originatortimes.com/content/rss.aspx'
  GetInetFile(URL, IncludeTrailingPathDelimiter(AppPref_DirPref) + 'RssFeed.xml');
  SLx.LoadFromFile(IncludeTrailingPathDelimiter(AppPref_DirPref) + 'RssFeed.xml');
  p1    := 1;
  XText := '';
  repeat
    p1 := posnext(uppercase(SLx.Text), '<TITLE', p1);
    if p1 <> 0 then
    begin
      p1       := posnext(uppercase(SLx.Text), '>', p1);
      p2       := posnext(uppercase(SLx.Text), '</', p1);
      HCaption := copy(SLx.Text, (p1 + 1), p2 - (p1));
      p1       := posnext(uppercase(SLx.Text), '<LINK>', p2);
      p2       := posnext(uppercase(SLx.Text), '</LINK>', p1);
      HURL     := copy(SLx.Text, p1 + 11, p2 - (p1 + 5));
      XText    := XText + ('<FONT SIZE="2"><FONT FACE="Arial,Helvetica,Monaco"><A HREF="' + HURL +
        '" TARGET="_blank">' + HCaption + '</A></FONT></FONT><BR><BR>');
      p1       := p2;
    end;
  until posnext(uppercase(SLx.Text), '<TITLE', p1) = 0;

  MRUT := XText;//SL.Text;

  i := pos('[RSS]', SLMain.Text);
  if i > 0 then
    SLMain.Text := copy(SLMain.Text, 1, i - 1) + MRUT + copy(SLMain.Text, i + 5, length(SLMain.Text));

end;
}

procedure TMyCFThread.doMRU;
var
  idx:  integer;
  SLx:  TStringList;
  MRUT: string;
  MT:   string;
begin
  SLx := TStringList.Create;

  MT := SLMain.Text;

  for idx := 0 to appPref_MRUS.Count - 1 do
  begin
    if (idx < 10) then //only want the top ten maximum of templates
    begin
      if fileexists(appPref_MRUS.Strings[idx]) then
        slx.Add('<FONT SIZE="2"><FONT FACE="Arial,Helvetica,Monaco"><A HREF="file:' +
          appPref_MRUS.Strings[idx] + '" TARGET="_self">' + extractfilename(appPref_MRUS.Strings[idx]) + '</A></FONT></FONT><BR>');
    end;
  end;

  MRUT := SLx.Text;
  MRUT := MRUT + '<BR>';
  if MRUT = '' then
    MRUT := '<FONT SIZE="2"><FONT FACE="Arial,Helvetica,Monaco">None</FONT></FONT><BR>';
  idx := pos('[MRU]', SLMain.Text);
  if idx > 0 then
    SLMain.Text := copy(SLMain.Text, 1, idx - 1) + MRUT + copy(SLMain.Text, idx + 5, length(SLMain.Text));

end;

procedure TMyCFThread.dotemplates;
var
  i:    integer;
  SLx:  TStringList;
  MRUT: string;
begin
  SLx := TStringList.Create;

  if AppTemplates.Count > 0 then
    for i := 0 to AppTemplates.Count - 1 do
    begin
      if i = 7 then
        break;
      slx.Add('<FONT SIZE="2"><FONT FACE="Arial,Helvetica,Monaco"><A HREF="file:' + AppTemplates.Strings[i] +
        '" TARGET="_self">' + ExtractFileName(AppTemplates.Strings[i]) + '</A></FONT></FONT><BR>');
    end;
  MRUT := SLx.Text;
  if MRUT = '' then
    MRUT := '<FONT SIZE="2"><FONT FACE="Arial,Helvetica,Monaco">None</FONT></FONT><BR>';
  i := pos('[TEMPLATES]', SLMain.Text);
  if i > 0 then
    SLMain.Text := copy(SLMain.Text, 1, i - 1) + MRUT + copy(SLMain.Text, i + 11, length(SLMain.Text));

end;

procedure TMyCFThread.loadhtml;
var
  internetFile, localFileName: string;

begin
  OK2Show := true;
  try
    internetFile := NewsDesk_HTML_Template;
    localFileName := IncludeTrailingPathDelimiter(AppPref_DirPref) + 'CNTemplate.ssh';
    GetInetFile(internetFile, localFileName);
    SLMain.LoadFromFile(localFileName);
  except
    OK2Show := false;
  end;

end;

procedure TMyCFThread.doOnSubscription;
var
  daysrem:     integer;
  daysrem2: string;
  SLx:         TStringList;
  f, p, i:     integer;
  notsub:      boolean;
  nm, qty, exp, tmp, RealName: string;
  MRUT:        string;
  CompOp, CompOpTime: integer;
  typ:         integer;
  Rules:       TMemIniFile;
  internetFile, localFileName: string;
  do2:         boolean;
  RegKy, BURL, SVC, MURL, MXURL: string;
  XReg:        TRegistry;
  SvcName, LinkName, LinkURL: string;
  UpdateAvail: boolean;
  TempS, MaintExpDate, AvailVer: string;
  newcol: string;
begin
  RegKy        := MyFolderPrefs.basekey;
  XReg         := TRegistry.Create;
  XReg.RootKey := HKEY_CURRENT_USER;
  //XReg.OpenKey(RegKy, True);

  SLx := TStringList.Create;


  UpdateAvail := (AutoUpdateStatus.UpdateAvailable = 1);
/////////////  AutoUpdateStatus.UpdaterVersion

  notsub        := false;
  showred       := false;
  internetFile  := NewsDesk_Rules;
  localFileName := IncludeTrailingPathDelimiter(AppPref_DirPref) + 'CNTest.rul';
  try
    GetInetFile(internetFile, localFileName);
  except
    OK2Show := false;
    exit;
  end;

  Rules := TMemIniFile.Create(IncludeTrailingPathDelimiter(AppPref_DirPref) + 'CNTest.rul');

  MaintExpDate := SL[0];
  daysrem      := round(strtodate(sl[0]) - now);

  TempS := Rules.ReadString('Maintenance', 'Time', '1');
  p     := pos(',', TempS);
  if p > 0 then
    Temps := copy(TempS, 1, p - 1);
  CompOp := StrToInt(Temps);

  BURL := Rules.ReadString('Maintenance', 'URL', 'https://secure.appraisalworld.com/store/');
  SVC  := Rules.ReadString('Maintenance', 'WebSvc', '');
  if SVC <> '' then
    MURL := 'WebSvc' + SVC + '-' + BURL
  else
    MURL := BURL;
  MXURL := MURL;

  newcol :='';// '<TD WIDTH="25%" VALIGN=CENTER ALIGN=CENTER BGCOLOR="SILVER"><FONT SIZE="2"><B>Expires</B></FONT></TD>';
  SLx.add('<FONT FACE="Arial,Helvetica,Monaco"><TABLE WIDTH="100%" CELLPADDING="0" CELLSPACING="0" BORDER="1"><FONT SIZE="2"><FONT FACE="Arial,Helvetica,Monaco">');
  AvailVer := '            <TR><TD WIDTH="60%" VALIGN=CENTER ALIGN=CENTER BGCOLOR="SILVER"><FONT SIZE="2"><B>Service</B></FONT></TD><TD WIDTH="40%" VALIGN=CENTER ALIGN=CENTER BGCOLOR="SILVER"><FONT SIZE="2"><B>Status</B></FONT></TD></TR>';
  SLx.add(AvailVer);

  if daysrem>=0 then
    daysrem2:=inttostr(daysrem)
  else
    daysrem2:='<FONT COLOR="RED">Expired</FONT>';

  if daysrem < 0 then
  begin
    notsub   := true;
    AvailVer := '            <TR><TD WIDTH="60%" VALIGN=CENTER><A HREF="' + MURL +
      '" TARGET="_self"><B><FONT SIZE="2">ClickForms Maintenance</FONT></B>';
      AvailVer := AvailVer + '</TD><TD WIDTH="40%"  VALIGN=CENTER ALIGN=CENTER><FONT SIZE="2">Expired</FONT></TD></TR>';

    SLx.add(AvailVer);

    showred := true;
  end;

  if daysrem > 0 then
  begin
      AvailVer := '            <TR><TD WIDTH="60%" VALIGN=CENTER><FONT SIZE="2">ClickForms Maintenance</FONT>';
        AvailVer := AvailVer + '</TD><TD WIDTH="40%"  VALIGN=CENTER ALIGN=CENTER><FONT SIZE="2"><FONT COLOR="#007F00">On Subscription</FONT></FONT></TD></TR>';
      SLx.add(AvailVer);
  end
  else
  begin
      AvailVer := '            <TR><TD WIDTH="60%" VALIGN=CENTER><FONT SIZE="2">ClickForms Maintenance</FONT>';
        AvailVer := AvailVer + '</TD><TD WIDTH="40%"  VALIGN=CENTER ALIGN=CENTER><FONT SIZE="2">Expired</FONT></TD></TR>';
      SLx.add(AvailVer);
  end;


  //Check for ClickForms Support
  daysrem := round(strtodate(sl[1]) - now);

  TempS := Rules.ReadString('Live Support', 'Time', '1');
  p     := pos(',', TempS);
  if p > 0 then
    Temps := copy(TempS, 1, p - 1);
  CompOp := StrToInt(Temps);

  BURL := Rules.ReadString('Program', 'SupportURL', 'https://secure.appraisalworld.com/store/');
  SVC  := Rules.ReadString('Program', 'SupportWebSvc', '');
  if SVC <> '' then
    MURL := 'WebSvc' + SVC + '-' + BURL
  else
    MURL := BURL;
  if daysrem < 0 then
  begin
    AvailVer := '            <TR><TD WIDTH="60%" VALIGN=CENTER><A HREF="' + MURL +
      '" TARGET="_self"><FONT SIZE="2">ClickForms Support</FONT></A></TD><TD WIDTH="40%" VALIGN=CENTER ALIGN=CENTER><FONT SIZE="2">'
      + '<FONT COLOR="RED">Expired</FONT></FONT></TD></TR>';
    SLx.add(AvailVer);

    showred := true;
  end;
  if daysrem > 0 then
  begin
      AvailVer :=
        '            <TR><TD WIDTH="60%" VALIGN=CENTER><FONT SIZE="2">ClickForms Support</FONT></TD><TD WIDTH="40%" VALIGN=CENTER ALIGN=CENTER><FONT SIZE="2">'
        + '<FONT COLOR="#007F00">On Subscription</FONT></FONT></TD></TR>';
      SLx.add(AvailVer);
  end;


  for f := 3 to sl.Count - 1 do
  begin
    CompOp     := 0;
    CompOpTime := 0;
    tmp        := sl[f];
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


    BURL       := Rules.ReadString(nm, 'URL', 'https://secure.appraisalworld.com/store/');
    SVC        := Rules.ReadString(nm, 'WebSvc', '');
    if SVC <> '' then
      MURL := 'WebSvc' + SVC + '-' + BURL
    else
      MURL := BURL;

    if {(qty <>'NA') and }(qty <> 'Not Subscribed') and (qty <> 'None') and (exp <> ' Not Subscribed') then
      //and (qty<>'On Subscription') then
    begin
      typ := Rules.ReadInteger(nm, 'Method', 3);
      if typ = 3 then  //Dependent on Maintenance
      begin
      daysrem := round(strtodate(sl[0]) - now);

      daysrem2 := inttostr(daysrem);
        if notsub = true then
        begin
          daysrem2:='<FONT COLOR="RED"><FONT SIZE="2">Expired</FONT></FONT>';
          SLx.add('            <TR><TD WIDTH="60%"  VALIGN=CENTER><A HREF="' + MURL +
            '" TARGET="_self"><B><FONT SIZE="2">' + nm + '</FONT></B></TD><TD WIDTH="40%"  VALIGN=CENTER ALIGN=CENTER>' +
            daysrem2 + '</TD></TR>');
        end
        else
          SLx.Add('            <TR><TD WIDTH="60%" VALIGN=CENTER><FONT SIZE="2">' + nm +
            '<FONT SIZE="2"></TD><TD WIDTH="40%"  VALIGN=CENTER ALIGN=CENTER><FONT SIZE="2"><FONT COLOR="#007F00">On Subscription</FONT></FONT></TD></TR>');
      end;
      if typ = 0 then  //Time Only
      begin
        if isdate(exp) then
          daysrem := round(strtodate(exp) - now)
        else
          daysrem := 0;

        TempS := Rules.ReadString(nm, 'Time', '0');
        p     := pos(',', TempS);
        if p > 0 then
          Temps := copy(TempS, 1, p - 1);
        CompOpTime := StrToInt(Temps);

        if (daysrem <= 0) or notsub then
        begin
          SLx.add('            <TR><TD WIDTH="60%" VALIGN=CENTER><A HREF="' + MURL +
            '" TARGET="_self"><B><FONT SIZE="2">' + nm +
            '</FONT></B></TD><TD WIDTH="40%" VALIGN=CENTER ALIGN=CENTER><FONT SIZE="2">' +
              '<FONT COLOR="RED">Expired</FONT></FONT></TD></TR>');
        end
        else
        begin
          SLx.Add('            <TR><TD WIDTH="60%" VALIGN=CENTER><FONT SIZE="2">' + nm +
            '</FONT></TD><TD WIDTH="40%" VALIGN=CENTER ALIGN=CENTER><FONT SIZE="2"><FONT COLOR="#007F00">On Subscription</FONT></FONT></TD></TR>');
          showred := true;
        end;
      end;

      if typ = 1 then //Units Only
      begin
        TempS := Rules.ReadString(nm, 'Units', '0');
        p     := pos(',', TempS);
        if p > 0 then
          Temps := copy(TempS, 1, p - 1);
        CompOp := StrToInt(Temps);

        if (StrToInt(qty) <= 0) or notsub then
        begin
          SLx.add('            <TR><TD WIDTH="60%" VALIGN=CENTER><A HREF="' + MURL +
            '" TARGET="_self"><B><FONT SIZE="2">' + nm + '</FONT></B></TD><TD WIDTH="40%" VALIGN=CENTER ALIGN=CENTER><FONT SIZE="2">Expired</FONT></TD></TR>');
        end
        else
        begin
          SLx.Add('            <TR><TD WIDTH="60%" VALIGN=CENTER><FONT SIZE="2">' + nm +
            '</FONT></TD><TD WIDTH="40%" VALIGN=CENTER ALIGN=CENTER><FONT SIZE="2"><FONT COLOR="#007F00">On Subscription</FONT></TD></TR>');
          showred := true;
        end;
      end;

      if typ = 2 then //Time and Units
      begin
        if isdate(exp) then
          daysrem := round(strtodate(exp) - now)
        else
          daysrem := 0;

        TempS := Rules.ReadString(nm, 'Time', '0');
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

        TempS := Rules.ReadString(nm, 'Units', '0');
        p     := pos(',', TempS);
        if p > 0 then
          Temps := copy(TempS, 1, p - 1);
        CompOp := StrToInt(Temps);

        if StrToInt(qty) <= 0 then
          do2 := true;

        if (do2 = true) or notsub then
        begin
          showfloodwarning:=true;
          SLx.add('            <TR><TD WIDTH="60%" VALIGN=CENTER><A HREF="' + MURL +
            '" TARGET="_self"><B><FONT SIZE = "2">' + nm + '</FONT></B></TD><TD WIDTH="40%" VALIGN=CENTER ALIGN=CENTER><FONT SIZE="2">Expired</FONT></TD></TR>');
          showred := true;
        end
        else
        begin
          SLx.Add('            <TR><TD WIDTH="60%" VALIGN=CENTER><FONT SIZE="2">' + nm +
            '</FONT></TD><TD WIDTH="40%" VALIGN=CENTER ALIGN=CENTER><FONT SIZE = "2"><FONT COLOR="#007F00">On Subscription</FONT></FONT></TD></TR>');

        end;
      end;
    end
    else
    begin
      SLx.Add('            <TR><TD WIDTH="60%" VALIGN=CENTER><FONT SIZE="2">' + nm +
        '<FONT SIZE="2"></TD><TD WIDTH="40%"  VALIGN=CENTER ALIGN=CENTER><FONT SIZE="2"><I>Not Subscribed</I></FONT></TD></TR>');

    end;
  end;
  SLx.add('</FONT></FONT></TABLE></FONT>');

  MRUT := SLx.Text;
  if MRUT = '' then
    MRUT := '<FONT SIZE="2"><FONT FACE="Arial,Helvetica,Monaco">None</FONT></FONT><BR>';
  i           := pos('[CF]', SLMain.Text);
  SLMain.Text := copy(SLMain.Text, 1, i - 1) + MRUT + copy(SLMain.Text, i + 4, length(SLMain.Text));

{Insert Update Status}
  i := pos('[AUTOSTATUS]', SLMain.Text);
  if UpdateAvail then
    MRUT := '<A HREF="[UPDATE]" TARGET="_self"><FONT SIZE="3">An update is available!</FONT></A><BR>'
  else
    MRUT := '<FONT SIZE="2">You have the latest version available.</FONT><BR>';
  SLMain.Text := copy(SLMain.Text, 1, i - 1) + MRUT + copy(SLMain.Text, i + 12, length(SLMain.Text));



  {Get News Links}
  slx.Clear;
  for i := 1 to 10 do
  begin
    LinkName := Rules.ReadString('WebsiteLinks', 'Link' + IntToStr(i) + 'Name', '');
    LinkURL  := Rules.ReadString('WebsiteLinks', 'Link' + IntToStr(i) + 'URL', '');
    if (LinkName <> '') and (LinkURL <> '') then
    begin
      slx.Add('           <FONT SIZE="2"><FONT FACE="Arial,Helvetica,Monaco"><A HREF="' + LinkURL +
        '" TARGET="_blank">' + LinkName + '</A></FONT></FONT><BR>');
    end;
  end;
  MRUT        := SLx.Text;
  MRUT        := MRUT + '<BR>';
  i           := pos('[WWW]', SLMain.Text);
  SLMain.Text := copy(SLMain.Text, 1, i - 1) + MRUT + copy(SLMain.Text, i + 5, length(SLMain.Text));

  {Get Promo Links}
  slx.Clear;
  for i := 1 to 10 do
  begin
    LinkName := Rules.ReadString('PromoLinks', 'Link' + IntToStr(i) + 'Name', '');
    LinkURL  := Rules.ReadString('PromoLinks', 'Link' + IntToStr(i) + 'URL', '');
    if (LinkName <> '') and (LinkURL <> '') then
    begin
      slx.Add('           <FONT SIZE="2"><FONT FACE="Arial,Helvetica,Monaco"><A HREF="' + LinkURL +
        '" TARGET="_blank">' + LinkName + '</A></FONT></FONT><BR>');
    end;
  end;
  MRUT        := SLx.Text;
  MRUT        := MRUT + '<BR>';
  i           := pos('[PROMO]', SLMain.Text);
  SLMain.Text := copy(SLMain.Text, 1, i - 1) + MRUT + copy(SLMain.Text, i + 7, length(SLMain.Text));

  {Get BT Links}
  slx.Clear;
  for i := 1 to 10 do
  begin
    LinkName := Rules.ReadString('BTLinks', 'Link' + IntToStr(i) + 'Name', '');
    LinkURL  := Rules.ReadString('BTLinks', 'Link' + IntToStr(i) + 'URL', '');
    if (LinkName <> '') and (LinkURL <> '') then
    begin
      slx.Add('           <FONT SIZE="2"><FONT FACE="Arial,Helvetica,Monaco"><A HREF="' + LinkURL +
        '" TARGET="_blank">' + LinkName + '</A></FONT></FONT><BR>');
    end;
  end;
  MRUT        := SLx.Text;
  MRUT        := MRUT + '<BR>';
  i           := pos('[BTL]', SLMain.Text);
  SLMain.Text := copy(SLMain.Text, 1, i - 1) + MRUT + copy(SLMain.Text, i + 5, length(SLMain.Text));
end;

procedure TMyCFThread.doTrialUser;
var
   SLx: TStringList;
   AvailVer, MRUT, LinkName, LinkURL: string;
   UpdateAvail: boolean;
  f, p, i:     integer;
  notsub:      boolean;
  nm, qty, exp, tmp, RealName: string;
  Rules:       TMemIniFile;
  internetFile, localFileName: string;

begin


SLx:= TStringList.Create;

  internetFile  := NewsDesk_Rules;
  localFileName := IncludeTrailingPathDelimiter(AppPref_DirPref) + 'CNTest.rul';
  try
    GetInetFile(internetFile, localFileName);
  except
    OK2Show := false;
    exit;
  end;

  Rules := TMemIniFile.Create(IncludeTrailingPathDelimiter(AppPref_DirPref) + 'CNTest.rul');

UpdateAvail := (AutoUpdateStatus.UpdateAvailable = 1);

  SLx.add('<FONT FACE="Arial,Helvetica,Monaco"><TABLE WIDTH="100%" CELLPADDING="0" CELLSPACING="0" BORDER="1"><FONT SIZE="2"><FONT FACE="Arial,Helvetica,Monaco">');
  AvailVer := '            <TR><TD WIDTH="60%" VALIGN=CENTER ALIGN=CENTER BGCOLOR="SILVER"><FONT SIZE="2"><B>Service</B></FONT></TD><TD WIDTH="40%" VALIGN=CENTER ALIGN=CENTER BGCOLOR="SILVER"><FONT SIZE="2"><B>Status</B></FONT></TD></TR>';
  SLx.add(AvailVer);

      AvailVer := '            <TR><TD WIDTH="60%" VALIGN=CENTER><FONT SIZE="2">ClickForms Maintenance</FONT>';
        AvailVer := AvailVer + '</TD><TD WIDTH="40%"  VALIGN=CENTER ALIGN=CENTER><FONT SIZE="2"><I>Not Purchased</I></FONT></TD></TR>';
  SLx.add(AvailVer);
      AvailVer := '            <TR><TD WIDTH="60%" VALIGN=CENTER><FONT SIZE="2">ClickForms Live Support</FONT>';
        AvailVer := AvailVer + '</TD><TD WIDTH="40%"  VALIGN=CENTER ALIGN=CENTER><FONT SIZE="2"><I>Not Purchased</I></FONT></TD></TR>';
  SLx.add(AvailVer);

  for f := 3 to sl.Count - 1 do
  begin
    tmp        := sl[f];
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

      SLx.Add('            <TR><TD WIDTH="60%" VALIGN=CENTER><FONT SIZE="2">' + nm +
        '<FONT SIZE="2"></TD><TD WIDTH="40%"  VALIGN=CENTER ALIGN=CENTER><FONT SIZE="2"><I>Not Purchased</I></FONT></TD></TR>');

  end;




  SLx.add('</FONT></FONT></TABLE></FONT>');

  MRUT := SLx.Text;
  if MRUT = '' then
    MRUT := '<FONT SIZE="2"><FONT FACE="Arial,Helvetica,Monaco">None</FONT></FONT><BR>';
  i           := pos('[CF]', SLMain.Text);
  SLMain.Text := copy(SLMain.Text, 1, i - 1) + MRUT + copy(SLMain.Text, i + 4, length(SLMain.Text));

{Insert Update Status}
  i := pos('[AUTOSTATUS]', SLMain.Text);
  if UpdateAvail then
    MRUT := '<A HREF="[UPDATE]" TARGET="_self"><FONT SIZE="3">An update is available!</FONT></A><BR>'
  else
    MRUT := '<FONT SIZE="2">You have the latest version available.</FONT><BR>';
  SLMain.Text := copy(SLMain.Text, 1, i - 1) + MRUT + copy(SLMain.Text, i + 12, length(SLMain.Text));



  {Get News Links}
  slx.Clear;
  for i := 1 to 10 do
  begin
    LinkName := Rules.ReadString('WebsiteLinks', 'Link' + IntToStr(i) + 'Name', '');
    LinkURL  := Rules.ReadString('WebsiteLinks', 'Link' + IntToStr(i) + 'URL', '');
    if (LinkName <> '') and (LinkURL <> '') then
    begin
      slx.Add('           <FONT SIZE="2"><FONT FACE="Arial,Helvetica,Monaco"><A HREF="' + LinkURL +
        '" TARGET="_blank">' + LinkName + '</A></FONT></FONT><BR>');
    end;
  end;
  MRUT        := SLx.Text;
  MRUT        := MRUT + '<BR>';
  i           := pos('[WWW]', SLMain.Text);
  SLMain.Text := copy(SLMain.Text, 1, i - 1) + MRUT + copy(SLMain.Text, i + 5, length(SLMain.Text));

  {Get Promo Links}
  slx.Clear;
  for i := 1 to 10 do
  begin
    LinkName := Rules.ReadString('PromoLinks', 'Link' + IntToStr(i) + 'Name', '');
    LinkURL  := Rules.ReadString('PromoLinks', 'Link' + IntToStr(i) + 'URL', '');
    if (LinkName <> '') and (LinkURL <> '') then
    begin
      slx.Add('           <FONT SIZE="2"><FONT FACE="Arial,Helvetica,Monaco"><A HREF="' + LinkURL +
        '" TARGET="_blank">' + LinkName + '</A></FONT></FONT><BR>');
    end;
  end;
  MRUT        := SLx.Text;
  MRUT        := MRUT + '<BR>';
  i           := pos('[PROMO]', SLMain.Text);
  SLMain.Text := copy(SLMain.Text, 1, i - 1) + MRUT + copy(SLMain.Text, i + 7, length(SLMain.Text));

  {Get BT Links}
  slx.Clear;
  for i := 1 to 10 do
  begin
    LinkName := Rules.ReadString('BTLinks', 'Link' + IntToStr(i) + 'Name', '');
    LinkURL  := Rules.ReadString('BTLinks', 'Link' + IntToStr(i) + 'URL', '');
    if (LinkName <> '') and (LinkURL <> '') then
    begin
      slx.Add('           <FONT SIZE="2"><FONT FACE="Arial,Helvetica,Monaco"><A HREF="' + LinkURL +
        '" TARGET="_blank">' + LinkName + '</A></FONT></FONT><BR>');
    end;
  end;
  MRUT        := SLx.Text;
  MRUT        := MRUT + '<BR>';
  i           := pos('[BTL]', SLMain.Text);
  SLMain.Text := copy(SLMain.Text, 1, i - 1) + MRUT + copy(SLMain.Text, i + 5, length(SLMain.Text));
end;



initialization
  CoInitialize(nil);

finalization
  CoUninitialize;

end.
