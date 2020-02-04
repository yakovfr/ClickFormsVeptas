unit UMail;

interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;
type
  TMail = class(TObject)
    constructor Create;
    destructor Destroy; override;
  private
    { Private declarations }
    FSubject: string;
    FMailtext: string;
    FFromName: string;
    FFromAdress: string;
    FTOAdr: TStrings;
    FCCAdr: TStrings;
    FBCCAdr: TStrings;
    FAttachedFileName: TStrings;
    FDisplayFileName: TStrings;
    FShowDialog: Boolean;
  public
    { Public declarations }
    procedure SetSubject(newValue: string);
    procedure SetBody(newValue: string);
    procedure SetFromName(newValue: string);
    procedure SetFromAdress(newValue: string);
    procedure SetToAddr(newValue: TStrings);
    procedure SetCCAddr(newValue: TStrings);
    procedure SetBCCAddr(newValue: TStrings);
    procedure SetAttachedFileName(newValue: TStrings);
    procedure SetDisplayFileName(newValue: TStrings);
    procedure SetShowDialog(newValue: boolean);
    procedure Reset();
    procedure SendMail();
  end;


implementation
uses
  Mapi, UStatus;


constructor TMail.Create();
begin
  inherited Create;
  FSubject := '';
  FMailtext := '';
  FFromName := '';
  FFromAdress := '';
  FTOAdr := TStringList.Create;
  FCCAdr := TStringList.Create;
  FBCCAdr := TStringList.Create;
  FAttachedFileName := TStringList.Create;
  FDisplayFileName := TStringList.Create;
  FShowDialog := False;
end;

destructor TMail.Destroy;
begin
  FTOAdr.Free;
  FCCAdr.Free;
  FBCCAdr.Free;
  FAttachedFileName.Free;
  FDisplayFileName.Free;
  inherited destroy;
end;

procedure TMail.Reset;
begin
  FSubject := '';
  FMailtext := '';
  FFromName := '';
  FFromAdress := '';
  FTOAdr.Clear;
  FCCAdr.Clear;
  FBCCAdr.Clear;
  FAttachedFileName.Clear;
  FDisplayFileName.Clear;
end;

procedure TMail.SetToAddr(newValue: TStrings);
begin
  FToAdr.Assign(newValue);
end;

procedure TMail.SetCCAddr(newValue: TStrings);
begin
  FCCAdr.Assign(newValue);
end;

procedure TMail.SetBCCAddr(newValue: TStrings);
begin
  FBCCAdr.Assign(newValue);
end;

procedure TMail.SetSubject(newValue: string);
begin
  FSubject:= newValue;
end;

procedure TMail.SetShowDialog(newValue: Boolean);
begin
  FShowDialog:= newValue;
end;

procedure TMail.SetBody(newValue: string);
begin
  FMailtext:= newValue;
end;

procedure TMail.SetFromName(newValue: string);
begin
  FFromName:= newValue;
end;

procedure TMail.SetFromAdress(newValue: string);
begin
  FFromAdress:= newValue;
end;

procedure TMail.SetAttachedFileName(newValue: TStrings);
begin
  FAttachedFileName.Assign(newValue);
end;

procedure TMail.SetDisplayFileName(newValue: TStrings);
begin
  FDisplayFileName.Assign(newValue);
end;

procedure TMail.Sendmail;
var
  MapiMessage: TMapiMessage;
  MError: Cardinal;
  Sender: TMapiRecipDesc;
  PRecip, Recipients: PMapiRecipDesc;
  PFiles, Attachments: PMapiFileDesc;
  i: Integer;
begin

  PFiles := nil;

  MapiMessage.nRecipCount := FTOAdr.Count + FCCAdr.Count + FBCCAdr.Count;
  GetMem(Recipients, MapiMessage.nRecipCount * sizeof(TMapiRecipDesc));

  try
    with MapiMessage do
      begin
        ulReserved := 0;
        if length(FSubject)>0 then
          lpszSubject := PChar(FSubject)
        else
          lpszSubject := nil;

        if length(FSubject)>0 then
          lpszNoteText := PChar(FMailText)
        else
          lpszNoteText := nil;
        lpszMessageType := nil;
        lpszDateReceived := nil;
        lpszConversationID := nil;
        flFlags := 0;
        Sender.ulReserved := 0;
        Sender.ulRecipClass := MAPI_ORIG;
        if length(FFromName)>0 then
          Sender.lpszName := PChar(FFromName)
        else
          Sender.lpszName := nil;
        if length(FFromAdress)>0 then
          Sender.lpszAddress := PChar(FFromAdress)
        else
          Sender.lpszAddress := nil;
        Sender.ulEIDSize := 0;
        Sender.lpEntryID := nil;
        lpOriginator := @Sender;
        PRecip := Recipients;
        if nRecipCount > 0 then
          begin
            //TO:
            for i := 1 to FTOAdr.Count do
              begin
                PRecip^.ulReserved := 0;
                PRecip^.ulRecipClass := MAPI_TO;
                PRecip^.lpszName := PChar(FTOAdr.Strings[i - 1]);
                PRecip^.lpszAddress := StrNew(PChar('SMTP:' + FTOAdr.Strings[i - 1]));
                PRecip^.ulEIDSize := 0;
                PRecip^.lpEntryID := nil;
                Inc(PRecip);
              end;
            //CC:
            for i := 1 to FCCAdr.Count do
              begin
                PRecip^.ulReserved := 0;
                PRecip^.ulRecipClass := MAPI_CC;
                PRecip^.lpszName := PChar(FCCAdr.Strings[i - 1]);
                PRecip^.lpszAddress := StrNew(PChar('SMTP:' + FCCAdr.Strings[i - 1]));
                PRecip^.ulEIDSize := 0;
                PRecip^.lpEntryID := nil;
                Inc(PRecip);
              end;
            //BCC:
            for i := 1 to FBCCAdr.Count do
              begin
                PRecip^.ulReserved := 0;
                PRecip^.ulRecipClass := MAPI_BCC;
                PRecip^.lpszName := PChar(FBCCAdr.Strings[i - 1]);
                PRecip^.lpszAddress := StrNew(PChar('SMTP:' + FBCCAdr.Strings[i - 1]));
                PRecip^.ulEIDSize := 0;
                PRecip^.lpEntryID := nil;
                Inc(PRecip);
              end;
          end;
        lpRecips := Recipients;
        nFileCount := FAttachedFileName.Count;
        if nFileCount > 0 then
          begin
            GetMem(Attachments, nFileCount * sizeof(TMapiFileDesc));
            PFiles := Attachments;
            FDisplayFileName.Clear;
            for i := 1 to FAttachedFileName.Count do
              FDisplayFileName.Add(ExtractFileName(FAttachedFileName[i - 1]));

            if nFileCount > 0 then
              begin
                for i := 1 to FAttachedFileName.Count do
                  begin
                    Attachments^.lpszPathName := PChar(FAttachedFileName.Strings[i - 1]);
                    Attachments^.lpszFileName := PChar(FDisplayFileName.Strings[i - 1]);
                    Attachments^.ulReserved := 0;
                    Attachments^.flFlags := 0;
                    { Position has to be -1 ???}
                    Attachments^.nPosition := Cardinal(-1);
                    Attachments^.lpFileType := nil;
                    Inc(Attachments);
                  end;
              end;
            lpFiles := PFiles;
          end
        else
          begin
            nFileCount := 0;
            lpFiles := nil;
          end;
      end;


    if FShowDialog then
                                //Application.Handle
      MError := MapiSendMail(0, GetDesktopWindow, MapiMessage, MAPI_DIALOG or MAPI_LOGON_UI or MAPI_NEW_SESSION, 0)
    else
      MError := MapiSendMail(0, GetDesktopWindow, MapiMessage, 0, 0);


    case MError of
//don't raise exception when user aborts
//      MAPI_E_USER_ABORT:
//        raise Exception.Create('Email Aborted');
      MAPI_E_FAILURE:
        raise Exception.Create('MAPI_E_FAILURE.');
      MAPI_E_LOGON_FAILURE:
        raise Exception.Create('MAPI_E_LOGON FAILURE. You may have 2 user profiles. Open your email program to set your preferred email profile before sending this email.');
      MAPI_E_DISK_FULL:
        raise Exception.Create('MAPI_E_DISK_FULL');
      MAPI_E_INSUFFICIENT_MEMORY:
        raise Exception.Create('MAPI_E_INSUFFICIENT_MEMORY');
      MAPI_E_ACCESS_DENIED:
        raise Exception.Create('MAPI_E_ACCESS_DENIED');
      MAPI_E_TOO_MANY_SESSIONS:
        raise Exception.Create('MAPI_E_TOO_MANY_SESSIONS');
      MAPI_E_TOO_MANY_FILES:
        raise Exception.Create('MAPI_E_TOO_MANY_FILES');
      MAPI_E_TOO_MANY_RECIPIENTS:
        raise Exception.Create('MAPI_E_TOO_MANY_RECIPIENTS');
      MAPI_E_ATTACHMENT_NOT_FOUND:
        raise Exception.Create('MAPI_E_ATTACHMENT_NOT_FOUND');
      MAPI_E_ATTACHMENT_OPEN_FAILURE:
        raise Exception.Create('MAPI_E_ATTACHMENT_OPEN_FAILURE');
      MAPI_E_ATTACHMENT_WRITE_FAILURE:
        raise Exception.Create('MAPI_E_ATTACHMENT_WRITE_FAILURE');
      MAPI_E_UNKNOWN_RECIPIENT:
        raise Exception.Create('MAPI_E_UNKNOWN_RECIPIENT');
      MAPI_E_BAD_RECIPTYPE:
        raise Exception.Create('MAPI_E_BAD_RECIPTYPE');
      MAPI_E_NO_MESSAGES:
        raise Exception.Create('MAPI_E_NO_MESSAGES');
      MAPI_E_INVALID_MESSAGE:
        raise Exception.Create('MAPI_E_INVALID_MESSAGE');
      MAPI_E_TEXT_TOO_LARGE:
        raise Exception.Create('MAPI_E_TEXT_TOO_LARGE');
      MAPI_E_INVALID_SESSION:
        raise Exception.Create('MAPI_E_INVALID_SESSION');
      MAPI_E_TYPE_NOT_SUPPORTED:
        raise Exception.Create('MAPI_E_TYPE_NOT_SUPPORTED');
      MAPI_E_AMBIGUOUS_RECIPIENT:
        raise Exception.Create('MAPI_E_AMBIGUOUS_RECIPIENT');
      MAPI_E_MESSAGE_IN_USE:
        raise Exception.Create('MAPI_E_MESSAGE_IN_USE');
      MAPI_E_NETWORK_FAILURE:
        raise Exception.Create('MAPI_E_NETWORK_FAILURE');
      MAPI_E_INVALID_EDITFIELDS:
        raise Exception.Create('MAPI_E_INVALID_EDITFIELDS');
      MAPI_E_INVALID_RECIPS:
        raise Exception.Create('MAPI_E_INVALID_RECIPS');
      MAPI_E_NOT_SUPPORTED:
        raise Exception.Create('MAPI_E_NOT_SUPPORTED');
      SUCCESS_SUCCESS:
    end;
  finally
    PRecip := Recipients;
    for i := 1 to MapiMessage.nRecipCount do
      begin
        StrDispose(PRecip^.lpszAddress);
        Inc(PRecip)
      end;
    FreeMem(Recipients, MapiMessage.nRecipCount * sizeof(TMapiRecipDesc));
    if Assigned(PFiles) then
      FreeMem(PFiles, MapiMessage.nFileCount * sizeof(TMapiFileDesc));
  end;

end;

END.





