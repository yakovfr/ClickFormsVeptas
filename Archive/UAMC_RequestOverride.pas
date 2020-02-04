unit UAMC_RequestOverride;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UForms, UContainer, AWSI_Server_Access, StdCtrls;

const
  pcvOverrideEmail = 'GetCodeOverride@pcvmurcor.com';
  pcvName = 'PCV Murcor';
  
type

  AMCReviewOverride = record
    amcID: integer;
    orderID: string;
    overrideCode: string;
    date: TDateTime;
  end;

  TAMCRequestOverride = class(TAdvancedForm)
    Label1: TLabel;
    edtApprName: TEdit;
    Label2: TLabel;
    edtApprPhone: TEdit;
    Label3: TLabel;
    edtApprEmail: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    edtOrder: TEdit;
    GroupBox1: TGroupBox;
    Label6: TLabel;
    edtPropAddress: TEdit;
    Label7: TLabel;
    edtPropCity: TEdit;
    Label8: TLabel;
    edtPropState: TEdit;
    Label9: TLabel;
    edtPropZip: TEdit;
    btnSubmit: TButton;
    btnCancel: TButton;
    memComment: TMemo;
    procedure onFormShow(Sender: TObject);
    procedure onExitEditControl(Sender: TObject);
    procedure btnSubmitClick(Sender: TObject);
  private
    { Private declarations }
    function CreateEmailText(overrideCode: String): String;
    procedure CreateAttachmentItem(var attchm: clsAttachmentListItem);
  public
    { Public declarations }
     FDoc: Tcontainer;
     amcID: integer;
  end;

function ReadAMCReviewOverrideData(doc: Tcontainer): AMCReviewOverride;
procedure WriteAMCReviewOverrideData(rec: AMCReviewOverride; doc: TContainer);

var
  RequestOverride: TAMCRequestOverride;

implementation
  uses
    UGlobals, UDocDataMgr, UFileUtils, UUtil1, UUtil3, UStatus, UGSEUploadXML, UBase64, UWebConfig, ULicUser;

{$R *.dfm}
function ReadAMCReviewOverrideData(doc: TContainer): AMCReviewOverride;
var
  strm: Tstream;
begin
  result.amcID := 0;
  result.orderID := '';
  result.overridecode := '';
  result.date := 0;

  strm := doc.docData.FindData(ddAMCReviewOverride);
  if assigned(strm) then
    begin
      result.amcID := StrToIntDef(ReadStringFromStream(strm),0);
      result.orderID := ReadStringFromStream(strm);
      result.overrideCode := ReadStringFromStream(strm);
      result.date := ReadDateFromStream(strm);
    end
end;

procedure WriteAMCReviewOverrideData(rec: AMCReviewOverride; doc: TContainer);
var
  strm: TMemoryStream;
begin
  strm := TMemoryStream.Create;
  try
    WriteStringToStream(IntTostr(rec.amcID),strm);
    WriteStringToStream(rec.orderID,strm);
    WriteStringToStream(rec.overrideCode,strm);
    WriteDateToStream(rec.date,strm);
    doc.docData.UpdateData(ddAMCReviewOverride,strm);
  finally
    strm.Free;
  end;
end;

procedure TAMCRequestOverride.onFormShow(Sender: TObject);
begin
    btnSubmit.Enabled := false;
   if assigned(FDoc.GetCellByID(cSubjectAddressCellID)) then //report has subject address cells
    begin
      edtApprName.Text := CurrentUser.SWLicenseName;
      edtApprPhone.Text := CurrentUser.UserInfo.Phone;
      edtPropAddress.Text := FDoc.GetCellTextByID(cSubjectAddressCellID);      //street address
      edtPropCity.Text := FDoc.GetCellTextByID(cSubjectCityCellID);    //city
      edtPropState.Text := FDoc.GetCellTextByID(cSubjectStateCellID);     //state
      edtPropZip.Text := FDoc.GetCellTextByID(cSubjectZipCellID);   //zip
    end
end;

procedure TAMCRequestOverride.onExitEditControl(Sender: TObject);
begin
  btnSubmit.Enabled := false;
  if (length(edtApprName.Text) > 0) and (length(edtApprPhone.Text) > 0) and (length(edtApprEmail.Text) > 0)
    and (length(edtOrder.Text) >0) and (length(edtPropAddress.Text) > 0) and (length(edtPropCity.Text) > 0)
    and (length(edtPropState.Text) > 0) and (length(edtPropZip.Text) > 0) then
      btnSubmit.Enabled := true;
end;

procedure TAMCRequestOverride.btnSubmitClick(Sender: TObject);
var
  overrideCode: String;
  emailRequest: clsSendExternalEmailRequest;
  toList: clsToList;
  toListItem: clsToListItem;
  attchList: clsAttachmentList;
  attchItem: clsAttachmentListItem;
  response: clsSendExternalEmailResponse;
  overrideRec: AMCReviewOverride;
  existCursor: TCursor;
begin
  modalResult := mrCancel;
  existCursor := Screen.Cursor;
  emailRequest := clsSendExternalEmailRequest.Create;
  toListItem := clsToListItem.Create;
  attchItem := clsAttachmentListItem.Create;
  try
    
    emailRequest.From := edtApprEmail.Text;
    emailRequest.SubjectText := 'ClickFORMS Override Request: Order # ' + edtOrder.Text;
    FDoc.docData.DeleteData(ddAMCReviewOverride);
    case amcID of
      amcPortalPCVID:
        begin
           //toListItem.Address := 'jpavon@pcvmurcor.com';  //test test test
          toListItem.Address := pcvOverrideEmail;
          toListItem.Name_ := pcvName;
        end;
    end;
    setLength(toList,1);
    toList[0] := toListItem;
    emailRequest.ToList := toList;

    overrideCode := CreateRandomString(4);
    emailRequest.MessageText := CreateEmailText(overrideCode);
    CreateAttachmentItem(attchItem);
    setLength(attchList,1);
    attchList[0] := attchItem;
    emailrequest.AttachmentList := attchList;
    Screen.Cursor := crHourglass;
    with GetAwsiAccessServerPortType(false, GetAWURLForAccessService) do
      begin
        response := AwsiAccessService_SendExternalEmail(emailRequest);
        if response.Results.Code = 0 then
          begin
            overrideRec.amcID := amcID;
            overrideRec.orderID := edtOrder.Text;
            overrideRec.overrideCode := overrideCode;
            overrideRec.date := now;
            WriteAMCReviewOverrideData(overrideRec,FDoc);
            modalResult := mrOK;
          end
        else
          ShowNotice('Cannot send request to PCV Murcor: ' + response.results.Description);
      end;
  finally
    Screen.Cursor := existCursor;
    toListItem.Free;
    attchItem.Free;
    //emailRequest.Free;     //It looks it is destroyed automatically
  end;
end;

function TAMCRequestOverride.CreateEmailText(overrideCode: String): String;
begin
  result := 'Vendor Name: ' + edtApprName.Text + #13#10;
  result := result + 'Vendor Phone Number: ' + edtApprPhone.Text + #13#10;
  result := result + #13#10;
  result := result + 'Property Address:' + #13#10;
  result := result + '      ' + edtPropAddress.Text + ', ' + edtPropCity.Text + ', ' + edtPropState.Text + ' ' + edtPropZip.Text + #13#10;
  result := result + #13#10;
  result := result + 'Override Code: ' + overrideCode + #13#10;
  result := result + #13#10;
  result := result + 'Comments:' + #13#10;
  result := result + '       ' + memComment.Lines.Text;
end;

procedure TAMCRequestOverride.CreateAttachmentItem(var attchm: clsAttachmentListItem);
var
  strm: TFileStream;
  report: String;
begin
  strm := TFileStream.Create(FDoc.docFullPath,fmOpenRead);
  try
    strm.Seek(0,soFromBeginning);
    setlength(report, strm.Size);
    strm.Read(PChar(report)^,strm.Size);
  finally
    strm.Free;
  end;
  report := Base64Encode(report);
  attchm.Filename := FDoc.docFileName;
  attchm.Data := report;
end;

end.
