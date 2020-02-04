unit UCC_MLS_Dialog;

{  MLS Mapping Module     }
{  Bradford Technologies, Inc. }
{  All Rights Reserved         }
{  Source Code Copyrighted © 1998-2012 by Bradford Technologies, Inc. }

{ Dialog display }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,UForms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, UContainer,  UStatus, RzLabel, {UCC_Appraisal,}
  UGlobals, UStrings, UWinUtils, IdHTTP, IdMessage, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdMessageClient, IdSMTP,UCC_Globals,
  IdExplicitTLSClientServerBase, IdSMTPBase, UMail, AWSI_Server_Access, UBase64,
  Grids_ts, TSGrid, ShellApi, USysInfo;

const
  sLineBreak = {$IFDEF LINUX} #10 {$ENDIF} {$IFDEF MSWINDOWS} #13#10 {$ENDIF};

type
  TMLSDialog = class(TAdvancedForm)
    Panel1: TPanel;
    btnSendEmail: TBitBtn;
    btnContinue: TBitBtn;
    btnCancel: TBitBtn;
    Memo1: TMemo;
    Label3: TLabel;
    Panel2: TPanel;
    Label4: TLabel;
    lbMLSName: TLabel;
    Label6: TLabel;
    lbMLSFile: TLabel;
    Panel3: TPanel;
    lbSend: TLabel;
    Panel4: TPanel;
    Label2: TLabel;
    Panel5: TPanel;
    Panel6: TPanel;
    lbxFieldList: TListBox;
    lblVisitAppraisalWorld: TLabel;
    Label8: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    procedure FormShow(Sender: TObject);
    procedure SendToMLSTeamClick(Sender: TObject);
    procedure VisitAppraisalWorldClick(Sender: TObject);
  private
//    FAppraisal: TAppraisal;
    FMLSName : String;
    FMLSId   : Integer;
    FMLSFile : String;
    FType  : Integer;
    function SendMail : Boolean;
    function SendExportFileToCatchAllBox : Boolean;
    function GetFileName(AFile : String) : String;
    procedure AdjustDPISettings;
   protected
      procedure CreateParams(var Params: TCreateParams); override;
  public
    procedure LoadExtraFields(List : TStringList);
    Property MLSName : String read FMLSName write FMLSName;
    Property MLSId : Integer read FMLSId write FMLSId;
    Property MLSFile : String read FMLSFile write FMLSFile;
    Property msgType : Integer read FType write FType;
//    Property Appraisal: TAppraisal read FAppraisal write FAppraisal;
  end;

  procedure OpenmlsDialog(doc : TContainer);

var
  MLSDialog: TMLSDialog;


implementation

//Uses
//	UCC_Utils;

{$R *.dfm}

procedure OpenMLSDialog(doc : TContainer);
begin
  MLSDialog := TMLSDialog.Create(nil);
  try
    try
      MLSDialog.ShowModal;
    except
      ShowAlert(atWarnAlert, 'Problems were encountered during the MLS data validation process.');
    end;
  finally
    MLSDialog.Free;
  end;
end;



//This is setup in an attempt to resolve the issue of buried dialog boxes which is supposedly caused by an issue in XP in terms
//of how the Z Order of siblings is handled.
procedure TMLSDialog.CreateParams(var params: TCreateParams);             
begin
  inherited;

  params.WndParent := Screen.ActiveForm.Handle;

  if (params.WndParent <> 0) and (IsIconic(params.WndParent)
    or not IsWindowVisible(params.WndParent)
    or not IsWindowEnabled(params.WndParent)) then
    params.WndParent := 0;

  if params.WndParent = 0 then
    params.WndParent := Application.Handle;
end;

procedure TMLSDialog.AdjustDPISettings;
begin
  btnContinue.left := btnSendEmail.left + btnSendEmail.width + 240;
  btnCancel.left := btnContinue.left + btnContinue.width + 24;
  Panel1.width := btnCancel.left + btnCancel.width + 15;
  self.width := memo1.width + 25;
  self.height := Panel1.height + Panel2.height + Panel3.height + 5;
  self.Constraints.minHeight := self.height;
  self.Constraints.minWidth := self.Width;
end;

procedure TMLSDialog.FormShow(Sender: TObject);
begin
  lbMLSName.Caption:= MLSName;
  lbMLSFile.Caption := MLSFile;
  AdjustDPISettings;
  lbxFieldList.Sorted := True;
  SendExportFileToCatchAllBox;
end;

function TMLSDialog.GetFileName(AFile : String) : String;
var
 filename,str : String;
 n,numcar : integer;
begin
  filename := '';
  for n := length(AFile) downto 1 do
    begin
      str := Copy(AFile,n,1);
      if str = '\' then
        begin
          numcar := n;
          break;
        end;
    end;

  filename := Copy(AFile, numcar+1, length(AFile));
  Result := filename;
end;

procedure TMLSDialog.LoadExtraFields(List : TStringList);
var
 i : integer;
begin
// This list was commented out to make room for the updated MLS Data Compliance
// Review Dialog box 6/3/2014

{
  tsGridExtra.Rows := List.Count;
  for i := 0 to List.Count - 1 do
    begin
      tsGridExtra.Cell[1,i] := List.Strings[i];
    end;
    }
end;

function TMLSDialog.SendMail : Boolean;
var
  member: clsSendMessageCredentials;
  msg:  clsSendMessageRequest;
  attach: clsAttachmentList;
  response: clsSendMessageResponse;
  AddressTo: clsToList;                 //clsToList = array of clsToListItem;
  sl: TStringList;
  strMsg, ExtraFieldList, MissingFieldList: String;
  strSubject: String;
  i: integer;
begin
 result := False;
 try
   member := clsSendMessageCredentials.Create;
{PAM
   member.Username := Appraisal.Appraiser.AWUserID;
   member.Password := Appraisal.Appraiser.AWUserPsw;
}
   SetLength(AddressTo,1);
   AddressTo[0] :=  clsToListItem.Create;
   AddressTo[0].Name_ := 'Redstone';                     // You can test your own email.
   AddressTo[0].Address := 'exports@appraisalworld.com';     //exports@appraisalworld.com

  // Create Attach file need send raw data in Base 64
   if FileExists(lbMLSFile.Caption) then
     begin
       sl := TStringList.Create;
       sl.LoadFromFile(lbMLSFile.Caption);

       SetLength(attach,1);
       attach[0] := clsAttachmentListItem.Create;
       attach[0].Filename := GetFileName(lbMLSFile.Caption);
       attach[0].Data :=  Base64Encode(sl.Text);
     end;

   //## Start Body ##//

   //## create a list of extra fields from MLS export
   // This list was commented out to make room for the updated MLS Data Compliance
   // Review Dialog box 6/3/2014

   {
   if tsGridExtra.Rows > 0 then
    begin
       ExtraFieldList := 'MLS Field' +' | '+ 'Description' + '<br/>';
      for i := 1 to tsGridExtra.Rows- 1 do
        begin
          ExtraFieldList := ExtraFieldList + tsGridExtra.Cell[1,i] +' | '+tsGridExtra.Cell[2,i] + '<br/>';
        end;
    end;
    }
   //## create a lits of missing fields from MLS export
   if lbxFieldList.Count > 0 then
     begin
       for i := 0 to lbxFieldList.Count -1 do
         begin
           MissingFieldList := MissingFieldList + lbxFieldList.Items[i] + '<br/>';
         end;
     end;

   if msgType = 0 then
     begin           // display MLS Id and MLS Name on Subjetc - Add May 14 - 2012
       strSubject := IntToStr(MLSId)+' '+ lbMLSName.Caption;//'Missing Fields in MLS File.';
     end;

   if msgType = 1 then
     begin
       strSubject := 'MLS need Map';
     end;
{PAM
   strMsg := '<html>'+
            '<body>'+
            '<p><strong><font size="4" color="Black">'+strSubject+'</font></strong></p>'+
            '<b>Sent by appraiser Id :  </b>'+ Appraisal.Appraiser.AWUserID +'<br/><br/>'+
            '<b>MLS Id / Name : </b>'+IntToStr(MLSId)+' '+ lbMLSName.Caption +'<br/><br/>'+
            '<b>Appraiser Comments :</b><br/>'+
             Memo1.Text+'<br/><br/>'+
            '<b>Missing Fields in MLS File :</b><br/>'+
             MissingFieldList+'<br/><br/>'+
     //       '<b>Extra Fields found in MLS File :</b><br/>'+
     //        ExtraFieldList + '<br/>'+
            '<b>Software : </b>Redstone<br/>'+
            '</body>'+
            '</html>';

}
   msg := clsSendMessageRequest.Create;
   msg.From := 'exports@appraisalworld.com';
   msg.ToList := AddressTo;
   if Assigned(attach) then
     msg.AttachmentList := attach;
   msg.MessageText := strMsg;
   msg.SubjectText := strSubject;

   with GetAwsiAccessServerPortType(False, awsiServer) do
     begin
       response := AwsiAccessService_SendMessage(member,msg);
       if response.Results.Code = 0 then
        Result := True
       else
         Result := False;
     end;

  finally
    if assigned(member) then
      member.Free;
    if assigned(msg) then
      msg.Free;
    if assigned(sl) then
      sl.Free;
    if assigned(AddressTo[0]) then
      AddressTo[0].free;
    if assigned(attach) then
      attach[0].free;

    //free array space
    SetLength(AddressTo, 0);
    AddressTo := nil;

    SetLength(attach,0);
    attach := nil;
  end;
end;

// This is a duplicate of the SendMail function above.  However this function
// sends the MLS Export automatically to mlsExportFiles@appraisalworld.com so
// that we have a record of MLS header information.
function TMLSDialog.SendExportFileToCatchAllBox: Boolean;
var
 member: clsSendMessageCredentials;
 msg:  clsSendMessageRequest;
 attach: clsAttachmentList;
 response: clsSendMessageResponse;
 AddressTo: clsToList;                 //clsToList = array of clsToListItem;
 sl: TStringList;
 strMsg,ExtraFieldList,MissingFieldList: String;
 strSubject: String;
 i: integer;
begin
  result := False;

  try
    member := clsSendMessageCredentials.Create;
{PAM
    member.Username := Appraisal.Appraiser.AWUserID;
    member.Password := Appraisal.Appraiser.AWUserPsw;
}
    SetLength(AddressTo,1);
    AddressTo[0] :=  clsToListItem.Create;
//PAM    AddressTo[0].Name_ := AppTitleRedstone;                     // You can test your own email.
    AddressTo[0].Address := 'mlsExportFiles@appraisalworld.com';


    // Create Attach file need send raw data in Base 64
    if FileExists(lbMLSFile.Caption) then
      begin
        sl := TStringList.Create;
        sl.LoadFromFile(lbMLSFile.Caption);

        SetLength(attach,1);
        attach[0] := clsAttachmentListItem.Create;
        attach[0].Filename := GetFileName(lbMLSFile.Caption);
        attach[0].Data :=  Base64Encode(sl.Text);
      end;

    //## Start Body ##//
    if msgType = 0 then
      strSubject := IntToStr(MLSId)+' '+ lbMLSName.Caption  //'Missing Fields in MLS File.'
    else if msgType = 1 then
      strSubject := 'MLS need Map';
{PAM
    strMsg := '<html>'+
            '<body>'+
            '<p><strong><font size="4" color="Black">'+strSubject+'</font></strong></p>'+
            '<b>Sent by appraiser Id :  </b>'+ Appraisal.Appraiser.AWUserID +'<br/><br/>'+
            '<b>MLS Id / Name : </b>'+IntToStr(MLSId)+' '+ lbMLSName.Caption +'<br/><br/>'+
            '</body>'+
            '</html>';

}
    msg := clsSendMessageRequest.Create;
    msg.From := 'mlsExportFiles@appraisalworld.com';
    msg.ToList := AddressTo;
    if Assigned(attach) then
      msg.AttachmentList := attach;
     msg.MessageText := strMsg;
    msg.SubjectText := strSubject;

    with GetAwsiAccessServerPortType(False, awsiServer) do
      begin
        response := AwsiAccessService_SendMessage(member,msg);
        if response.Results.Code = 0 then
          Result := True
        else
          Result := False;
      end;
  finally
    if assigned(member) then
      member.Free;
    if assigned(msg) then
      msg.Free;
    if assigned(sl) then
      sl.Free;
    if assigned(AddressTo[0]) then
      AddressTo[0].free;
    if assigned(attach) then
      attach[0].free;

    //free array space
    SetLength(AddressTo, 0);
    AddressTo := nil;

    SetLength(attach,0);
    attach := nil;
  end;
end;

procedure TMLSDialog.SendToMLSTeamClick(Sender: TObject);
begin
  PushMouseCursor(crHourglass);
  try
    try
      lbSend.Caption := 'Sending...';     //needs to be replaced with PROGRESS BAR
      Application.ProcessMessages;
      if SendMail then
        if OK2Continue('Your MLS data has been successfully sent to the Mapping Team. Do you want to continue importing the current data file?') then
          btnContinue.Click
        else
          Close;
    except
      lbSend.Caption := 'Error ??';
    end;
  finally
    PopMouseCursor;
  end;
end;

procedure TMLSDialog.VisitAppraisalWorldClick(Sender: TObject);
var
  MyLink: string;
begin
  MyLink := 'http://www.appraisalworld.com/i2/mls-data-compliance.html';
  ShellExecute(Application.Handle, PChar('open'), PChar(MyLink),
   nil, nil, SW_SHOW);
end;

end.

