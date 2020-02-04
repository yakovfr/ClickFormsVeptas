unit UAMC_SendPak;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{ This is the generic unit that actually sends the 'Appraisal Package' }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Contnrs, XmlIntf, XmlDoc,
  UContainer, UForm, UAMC_Base, UAMC_WorkflowBaseFrame, Grids_ts, TSGrid,
  osAdvDbGrid, ExtCtrls, UGlobals, UAMC_Port, UAMC_Login, UAMC_Qcp,
  CentractOrderService_TLB, NasoftOrderService_TLB, UCell, UAMC_XMLUtils;

type
  TCellID = class(TObject)   //YF Reviewer 04.08.02
    Form: Integer;          //form index in formList
    Pg: Integer;            //page index in form's pageList
    Num: Integer;           //cell index in page's cellList
    constructor Create;
  end;

  CellLocations = Array of TCellID;

  UserComment = record
    msgID: String;
    comment: String;
  end;
  UserComments = Array of UserComment;

  ValidationStatus = (valStatusNA, valStatusOK, valStatusOKwWarnings, valStatusErrors);

  ValidationMessage = record
    msgID: String;
    msgText: String;
    userComment: String;
    Locations: CellLocations;
  end;

  ValidationMessages = Array of ValidationMessage;
  TXMLValidation = class(TObject)
    public
      Messages: ValidationMessages;
      procedure ReadValidationFromQCP(msgType: QualityValidationMessageType; qcp: QualityControlPackage; FormList: BooleanArray);
      procedure ReadAMCValidationFromQCP(theDoc: TContainer;
        msgType: String; qcp: ValidateDataResponse; FormList: BooleanArray);
      destructor Destroy; override;
      procedure AddUserComments(cmnts: UserComments);
    private
      function IndexOF(msgID: String): Integer;
      function GetComment(index: Integer; var cmnt: String): Boolean;
      function ExtractUserComments: UserComments;
   end;

  TAMC_SendPak = class(TWorkflowBaseFrame)
    pnlAMCReview: TPanel;
    AMCErrorText: TLabel;
    XMLValidationMsgsGrid: TosAdvDbGrid;
    btnSave: TButton;
    btnAMCReview: TButton;
    stProcessWait: TStaticText;
    procedure btnSaveClick(Sender: TObject);
    procedure btnAMCReviewClick(Sender: TObject);
    procedure LocateValidationErrOnForm(locString: String);
    procedure EditValidationUserComment(Index: Integer);
    procedure OnComboCellLoaded(Sender: TObject; Combo: TtsComboGrid;
      DataCol, DataRow: Integer; var Value: Variant);
    procedure XMLValidationMsgsGridButtonClick(Sender: TObject; DataCol,
      DataRow: Integer);
    procedure XMLValidationMsgsGridDblClickCell(Sender: TObject; DataCol,
      DataRow: Integer; Pos: TtsClickPosition);
  private
    FProcessBusy: Boolean;        //True=busy performing send operation; do not allow next process
    FAMCOrder: AMCOrderInfo;      //holds key order info
    FErrors, FWarnings, FWarningComments, FAlerts: Integer;
    FMiscInfo: TMiscInfo;         //for transferring data to the UMISMO routines
    FXMLErrorList: TObjectList;
    FFormList: BooleanArray;
    FValidationErrors: TXMLValidation;
    FValidationWarnings: TXMLValidation;
    FValidationWarningsYesNo: TXMLValidation;
    FValidationAlerts: TXMLValidation;
    FValidationSignature: String;
    procedure ValidateXML;
    procedure SendXMLReport;
    function CreatePDF(showPDF: Boolean): String;
    function CreateXML(PDFPath: String): String;
    function TransmitXMLReport(XMLData: String): Integer;
    function FormRequestXML(theData: FormData; ProviderID: Integer): String;
    function SupvSignatureOK(Silent: Boolean=True): Boolean;
    procedure ShowSupvSignWarning(ApprSupv: String);
    procedure WriteUserCommentToReport;
    procedure WriteCommentToCommentPage;
    function GetValidationStatus: ValidationStatus;
    procedure UpdValidationErrCount;
    procedure ClearXMLValidationMsgsGrid;
    function CreateLocationStr(clID: TCellID): String;
    procedure InitLocationCombo(row: Integer; nLocations: Integer);
    procedure ShowValidationErrors(ProviderID: Integer);
  public
    destructor Destroy; override;
    procedure InitPackageData; override;
    procedure StartProcess; override;
    procedure DoProcessData; override;
  end;

var
  XIDSupv, XIDSupvAlt: Integer;

  procedure ExportToAMC(Doc: TContainer; SvcRow: Integer);
  procedure ParseQCPLocation(loc: QualityValidationMessageLocation; var clID: TCellID; FormList: BooleanArray);
  procedure ParseAMCQCPLocation(theCell: TBaseCell; var clID: TCellID; FormList: BooleanArray);
  function GetRuleText(FldStr, Msg: String): String;
  function GetQualityValidationComments(cmnts: UserComments): ArrayOfQualityValidationComment;
  function ReadUserCommentsFromReport(doc: TContainer): UserComments;

implementation

{$R *.dfm}

uses
  UUtil1, UAdobe, UAMC_Delivery, UAMC_Globals, UStatus, UMISMOInterface, UGSEInterface,
  UFileUtils, UWinUtils, UWordProcessor, UAMC_Utils, UDocDataMgr, UValidationUserComment,
  USignatures;

const
  errMsgInvalidVldnSignature = 'The report validation signature is not valid';
  errMsgNoXmlData = 'The XML was not created and could not be transmitted.';
  errMsgInvalidCmntForm = 'Quality Check Comments Form is not valid';
  errMsgInvalidProviderID = 'The Provider ID is not valid';
  // Message types
  MsgError = 'Error';
  MsgWarning = 'Warning';
  MsgWarn = 'Warn';
  MsgWarningYN = 'WarningRequiresYesNo';
  MsgAlert = 'Alert';
  PDFFileName = 'PDFFile.pdf';

  vldnColMsgType = 1;
  vldnColLocate = 2;
  vldnColResponse = 3;
  vldnColMsgID = 4;
  vldnColDescr = 5;
  vldnColRule = 6;
  vldnColSubRule = 7;
  vldnColLocation = 8;

  rldnColCell = 6;
  rldnColPage = 5;
  rldnColForm = 4;
  rldnColErrMsg = 3;
  rldnColLocate = 2;
  rldnColMsgType = 1;

procedure ParseQCPLocation(loc: QualityValidationMessageLocation; var clID: TCellID; FormList: BooleanArray);
const
  delim = '.';
  prefix = 'P';
var
  strCellID: String;
  delimPos: Integer;
  theFormNo, curFormNo, curClfFormNo: Integer;
begin
  theFormNo := StrToIntDef(loc.FormSeqID,-1);
  //find ClickForms sequence #, it is zero based
  if length(FormList) = 0 then
    exit;
  curFormNo := 0;
  for curClfFormNo := 0 to length(FormList) - 1 do
    begin
      if FormList[curClfFormNo] then
        inc(curFormNo);
      if curFormNo = theFormNo then
        break;
    end;
  if curClfFormNo = length(FormList) then // did not find ClickForms form
    exit
  else
    clID.Form := curClfFormNo;
  strCellID := loc.CellID;
  if CompareText(prefix,strCellID[1]) <> 0 then
    exit;
  delimPos := Pos(delim,strCellID);
  if delimPos = 0 then
    exit;
  clID.Pg := StrToIntDef(Copy(strCellID,2,delimPos - 1 - length(prefix)), -1);
  clID.Num := StrToIntDef(Copy(strCellID,delimPos + 1,length(strCellID) - delimPos), -1);
end;

procedure ParseAMCQCPLocation(theCell: TBaseCell; var clID: TCellID; FormList: BooleanArray);
var
  theFormNo, curFormNo, curClfFormNo: Integer;
begin
  theFormNo := theCell.UID.Form;
  //find ClickForms sequence #, it zero based
  if length(FormList) = 0 then
    exit;
  curFormNo := 0;
  for curClfFormNo := 0 to length(FormList) - 1 do
    begin
      if FormList[curClfFormNo] then
        inc(curFormNo);
      if curFormNo = theFormNo then
        break;
    end;
  if curClfFormNo = length(FormList) then // did not find ClickForms form for CIS sequence #
    exit
  else
    clID.Form := curClfFormNo;
  clID.Pg := Succ(theCell.UID.Pg);
  clID.Num := Succ(theCell.UID.Num);
end;

function GetRuleText(FldStr, Msg: String): String;
  const
    BegDelim = ':';
    EndDelim = ',';
  var
    FldPos, BegDelimPos, EndDelimPos: Integer;
    SubMsg : String;
  begin
    // FormID:1,FormSeqID:1,RuleID:20,SubRuleID:1,Rule:Building Type
    Result := '';
//    FldPos := 0;
//    BegDelimPos := 0;
//    EndDelimPos := 0;
    if FldStr <> '' then
      begin
        FldPos := Pos(FldStr, Msg);
        if FldPos > 0 then
          begin
            SubMsg := Copy(Msg, FldPos, Length(Msg));
            BegDelimPos := Pos(BegDelim, SubMsg);
            EndDelimPos := Pos(EndDelim, SubMsg);
            if BegDelimPos > 0 then
              if EndDelimPos > 0 then
                Result := Copy(SubMsg, Succ(BegDelimPos), (EndDelimPos - Succ(BegDelimPos)))
              else
                Result := Copy(SubMsg, Succ(BegDelimPos), Length(SubMsg));
          end;
      end;
  end;

constructor TCellID.Create;
begin
  inherited Create;

  Form := - 1;
  Pg := -1;
  Num := -1;
end;

procedure ExportToAMC(Doc: TContainer; SvcRow: Integer);
const
  StdSvcTimeout = 10;
  StdXIDSupv = 22;
begin
{  if Assigned(AMCExporter) then     //get rid of any previous version
    FreeAndNil(AMCExporter);

  if assigned(doc) then              //see if images need to be optimized
    doc.DocNeedsImageOptimization;
  // Version 6.9.9 JWyatt: Changed per Sharepoint Bug#319 - allows continuation
  //  to review screen even if images are optimized. Was:
  //    if doc.DocNeedsImageOptimization then
  //      Exit;

  AMCExporter := TExportAMCReport.Create(Doc);
  try
    theSvcIdx := SvcRow;
    theSvcID := AMCStdInfo[SvcRow].ID;
    theSvcName := AMCStdInfo[SvcRow].Name;
    theSvcAbbrev := AMCStdInfo[SvcRow].Abbrev;
    theSvcSupport := AMCStdInfo[SvcRow].SvcSupport;
    theSvcBillInfoName := AMCStdInfo[SvcRow].SvcBillInfoName;
    theSvcBillInfoUrl := AMCStdInfo[SvcRow].SvcBillInfoUrl;
    theSvcLocType := AMCStdInfo[SvcRow].XMLLocType;

    XIDSupv := AMCStdInfo[SvcRow].XIDSupv;
    if XIDSupv = 0 then
      XIDSupv := StdXIDSupv;
    XIDSupvAlt := AMCStdInfo[SvcRow].XIDSupvAlt;

    AMCSvcTimeout := AMCStdInfo[SvcRow].SvcTimeout;
    if AMCSvcTimeout = 0 then
      AMCStdInfo[SvcRow].SvcTimeout := StdSvcTimeout;
    AMCSvcTimeout := AMCSvcTimeout  * 60000;

    if (theSvcID = 0) then
      begin
        ShowNotice('Sorry, there is a service configuration problem ' +
                   'and the report cannot be transmitted to '  + theSvcName + '.');
        FreeAndNil(AMCExporter);
      end
    else
      begin
        AMCExporter.Caption := AMCExporter.Caption + theSvcName;
        if theSvcAbbrev = '' then
          theSvcAbbrev := theSvcName;
        AMCExporter.PgXMLValidationMsgsList.Caption :=
          theSvcName + AMCExporter.PgXMLValidationMsgsList.Caption;
        AMCExporter.bbtnAMCReview.Caption:=
          theSvcName + AMCExporter.bbtnAMCReview.Caption;
        if Trim(theSvcSupport) <> '' then
          AMCExporter.stAMCSupport.Caption := theSvcSupport;
        if Trim(theCFSupport) <> '' then
          AMCExporter.stAMCSupport.Caption := AMCExporter.stAMCSupport.Caption +
            ' ' + theCFSupport;
        AMCExporter.stAMCSupport.Caption := ' ' + AMCExporter.stAMCSupport.Caption + ' ';
        AMCExporter.Show;
      end;
  except
    on E: Exception do
      begin
        ShowAlert(atWarnAlert, errProblem + E.message);
        FreeAndNil(AMCExporter);
      end;
  end;}
end;

function GetQualityValidationComments(cmnts: UserComments): ArrayOfQualityValidationComment;
var
  cmntNo, nCmnts: Integer;
  qvc: QualityValidationComment;
begin
  setlength(result,0);
  nCmnts := length(cmnts);
  if nCmnts > 0 then
    for cmntNo := 0 to nCmnts - 1 do
      begin
        qvc := QualityValidationComment.Create;
        qvc.MessageID := cmnts[cmntNo].msgID;
        qvc.Text := cmnts[cmntNo].comment;
        setlength(result,length(result) + 1);
        result[high(result)] := qvc;
      end;
end;

function ReadUserCommentsFromReport(doc: TContainer): UserComments;
var
  cmntNo, nCmnts: Integer;
  cmnt: UserComment;
  strm: TStream;
begin
  setlength(result,0);
  if assigned(doc) then
    strm := doc.docData.FindData(ddAMCValidationUserComment)
  else
    exit;
  if not assigned(strm) then
    exit;
  nCmnts := ReadLongFromStream(strm);
  if nCmnts = 0 then
    exit;
  setlength(result, nCmnts);
  for cmntNo := 0 to nCmnts - 1 do
    begin
      cmnt.msgID := ReadStringFromStream(strm);
      cmnt.comment := ReadStringFromStream(strm);
      result[cmntNo] := cmnt;
    end;
end;

destructor TXMLValidation.Destroy;
var
  msgNo: Integer;
  locNo: Integer;
begin
  if length(messages) > 0 then
    for msgNo := 0 to length(messages) - 1 do
      if length(messages[msgNo].Locations) > 0 then
        for locNo := 0 to length(messages[msgNo].Locations) - 1 do
          messages[msgNo].Locations[locNo].Free;
    SetLength(messages,0);
  inherited Destroy;
end;

procedure TXMLValidation.ReadValidationFromQCP(msgType: QualityValidationMessageType;
  qcp: QualityControlPackage; FormList: BooleanArray);
var
  msgNo, locationNo: Integer;
  msg: ValidationMessage;
  qcpMsg: QualityValidationMessage;
  clID: TCellID;
begin
  setlength(messages,0);
  if length(qcp.QualityValidationMessages) = 0 then
        exit;
  for msgNo := 0 to length(qcp.QualityValidationMessages) - 1 do
    begin
      qcpMsg := qcp.QualityValidationMessages[msgNo];
      if qcpMsg.Type_ <> msgType then
        continue;
      msg.msgID := qcpMsg.MessageID;
      msg.msgText := qcpMsg.Text;
      if qcpMsg.Locations.Len > 0 then
        begin
          setlength(msg.locations,qcpMsg.Locations.Len);
          for locationNo := 0 to qcpMsg.Locations.Len -1 do
            begin
              clID := TCellID.Create;  //empty cellID: form,page, and cell = -1
              ParseQCPLocation(qcpMsg.Locations[locationNo],clID,FormList);
              msg.locations[locationNo] := clID;
            end;
        end
      else
        // Ver 6.9.5 JWyatt Added to ensure that the message location is initialized
        //  to no form, page and cell ID when no location information is supplied
        //  in the XML.
        begin
          setlength(msg.locations,1);
          clID := TCellID.Create;  //empty cellID: form,page, and cell = -1
          msg.locations[0] := clID;
        end;
      SetLength(messages, length(messages) + 1);
      messages[length(messages) - 1] := msg;
    end;
end;

procedure TXMLValidation.ReadAMCValidationFromQCP(theDoc: TContainer;
    msgType: String; qcp: ValidateDataResponse; FormList: BooleanArray);
const
  strRuleID = 'RuleID:';
var
  msgNo, locationNo: Integer;
  msg: ValidationMessage;
  qcpMsg: IXMLValidationMessageType;
  QCPXml: TXMLDocument;
  qcPkg: IXMLQualityControlPackage;
  clID: TCellID;
  LocCell: TBaseCell;
  LocText: String;
begin
  setlength(messages,0);
  if length(qcp.Response) = 0 then
    exit;
  QCPXml := TXMLDocument.Create(nil);
  QCPXml.Active := False;
  QCPXml.ParseOptions := [poResolveExternals,poValidateOnParse];
  QCPXml.XML.Text := qcp.Response;
  QCPXMl.Active := True;
  qcPkg := GetQualityControlPackage(QCPXml);

  if qcPkg.ValidationMessages.Count > 0 then
    begin
      for msgNo := 0 to Pred(qcPkg.ValidationMessages.Count) do
        begin
          qcpMsg := qcPkg.ValidationMessages.ValidationMessage[msgNo];
          // Make sure that it's a recognized message
          if qcpMsg.Type_ <> MsgType then
            continue;
          msg.msgID := strRuleID + qcpMsg.RuleID;
          msg.msgText := qcpMsg.Text.Text;
          if qcpMsg.Locations.Count > 0 then
            begin
              setlength(msg.Locations, qcpMsg.Locations.Count);
              for locationNo := 0 to Pred(qcpMsg.Locations.Count) do
                begin
                  LocText := '';
                  if qcpMsg.Locations.Location[locationNo].Locator[1] <> '"' then
                    LocText := qcpMsg.Locations.Location[locationNo].Locator
                  else
                    begin
                      LocText := qcpMsg.Locations.Location[locationNo].Locator;
                      LocText := Copy(LocText, 2, (Length(LocText) - 2));
                    end;
                  LocCell := theDoc.CellXPathList.GetCellByXPath(LocText);
                  clID := TCellID.Create;  //empty cellID: form,page, and cell = -1
                  if LocCell <> nil then
                    begin
                      ParseAMCQCPLocation(LocCell, clID, FormList);
                      msg.locations[locationNo] := clID;
                    end
                  else
                    msg.locations[locationNo] := nil;
                end;
            end
          else
            begin
              setlength(msg.locations,1);
              clID := TCellID.Create;  //empty cellID: form,page, and cell = -1
              msg.locations[0] := clID;
            end;
          SetLength(messages, length(messages) + 1);
          messages[length(messages) - 1] := msg;
        end;
    end;
//for debugging
  {theDoc.CellXPathList.SaveToFile('c:\temp\text.txt');}
//...for debugging
end;

function TXMLValidation.IndexOF(msgID: String): Integer;
var
  msgNo,nMsgs: Integer;
begin
  result := -1;
  nMsgs := length(messages);
  if nMsgs > 0 then
    for msgNo := 0 to nMsgs - 1 do
      if CompareText(messages[msgNo].msgID,msgID) = 0 then
        begin
          result := msgNo;
          break;
        end;
end;

function TXMLValidation.GetComment(index: Integer; var cmnt: String): Boolean;
const
  strRuleID = 'RuleID';
  Cr = #$D;
var
  msg: ValidationMessage;
  msgIDstart: Integer;
  strMsgID: String;
  YesNoResp: Boolean;
begin
  result := False;
  YesNoResp := False;
  cmnt := '';
  msg := messages[index];
  if length(trim(msg.userComment)) = 0 then
    exit;
  msgIDStart := Pos(strRuleID, msg.msgID);
  if msgIDStart = 0 then
    strMsgID := msg.msgID
  else
    strMsgID := Copy(msg.msgID, msgIDStart, length(msg.msgID));

  cmnt :=  'RuleID: ' + GetRuleText(strRuleID, strMsgID) + Cr + 'Description: ';
  if Copy(msg.msgText, 1, 3) = '[*]' then
    cmnt := cmnt + Copy(msg.msgText, 4, Length(msg.msgText)) + Cr
  else
    cmnt := cmnt + msg.msgText + Cr;

  if Copy(msg.userComment, 1, 3) = 'No|' then
    begin
      YesNoResp := True;
      cmnt := cmnt + 'Response: No' + Cr;
      msg.userComment := Copy(msg.userComment, 4, Length(msg.userComment));
    end
  else if Copy(msg.userComment, 1, 4) = 'Yes|' then
    begin
      YesNoResp := True;
      cmnt := cmnt + 'Response: Yes' + Cr;
      msg.userComment := Copy(msg.userComment, 5, Length(msg.userComment));
    end;

  // Version 7.1.3.19 052710 JWyatt Add the YesNoResp check to ensure that a
  //  space appears between a comment with only a Yes or No response and the
  //  following comment.
  if YesNoResp or (Trim(msg.userComment) <> '') then
    if Trim(msg.userComment) <> '' then
      cmnt := cmnt + 'Comment:' + msg.userComment + Cr + Cr
    else
      cmnt := cmnt + Cr;
  ClearLF(cmnt);
  result := True;
end;

function TXMLValidation.ExtractUserComments: UserComments;
var
  msgNo, nMsgs: Integer;
 begin
  setlength(result,0);
  nMsgs := length(messages);
  if nMsgs = 0 then
    exit;
  for msgNo := 0 to nMsgs - 1 do
    with messages[msgNo] do
      if length(trim(userComment)) > 0 then
        begin
          setlength(result,length(result) + 1);
          result[high(result)].msgID := msgID;
          result[high(result)].comment := userComment;
        end;
end;

procedure TXMLValidation.AddUserComments(cmnts: UserComments);
var
 msgNo, nMsgs, cmntNo, nCmnts: Integer;
begin
  nMsgs := length(messages);
  nCmnts := length(cmnts);
  if (nMsgs = 0) or (nCmnts = 0) then
    exit;
  for cmntNo := 0 to nCmnts - 1 do
    begin
      msgNo := indexOF(cmnts[cmntNo].msgID);
      if msgNo >= 0 then
        messages[msgNo].userComment := cmnts[cmntNo].comment;
    end;
end;

{ TAMC_DeliverPak }

destructor TAMC_SendPak.Destroy;
begin
  if assigned(FFormList) then
    FFormList := nil;

  if assigned(FXMLErrorList) then
    FXMLErrorList.Free;

  inherited;
end;

function TAMC_SendPak.GetValidationStatus: ValidationStatus;
var
  nErrors, nWarnings: Integer;
  isSignature: Boolean;
begin
  result := valStatusNA;
  nErrors := length(FValidationErrors.Messages);
  nWarnings := length(FValidationWarnings.Messages);
  if AMCStdInfo[FAMCOrder.ProviderIdx].XMLValSigReqd and (length(FValidationSignature) = 0) then
    isSignature := False
  else
    isSignature := True;
  if nErrors > 0 then
    result := valStatusErrors
  else
    if isSignature then
      if nWarnings > 0 then
        result := valStatusOKwWarnings
      else
        result := valStatusOK;
end;

procedure TAMC_SendPak.InitPackageData;
begin
  inherited;

  FXMLErrorList   := nil;
  AMCErrorText.caption := '';
  FProcessBusy := False;
  FValidationErrors := TXMLValidation.Create;
  setLength(FValidationErrors.Messages,0);
  FValidationWarnings := TXMLValidation.Create;
  setLength(FValidationWarnings.Messages,0);
  FValidationWarningsYesNo := TXMLValidation.Create;
  setLength(FValidationWarningsYesNo.Messages,0);
  FValidationAlerts := TXMLValidation.Create;
  setLength(FValidationAlerts.Messages,0);

  FXMLErrorList := TObjectList.create(True);
  FAMCOrder := FDoc.ReadAMCOrderInfoFromReport;   //has all info about order/user
  stProcessWait.Visible := False;
  if (FAMCOrder.ProviderIdx > -1) and (AMCStdInfo[FAMCOrder.ProviderIdx].XMLValReqd) then
    begin
      AMCErrorText.Visible := True;
      btnAMCReview.Visible := True;
      XMLValidationMsgsGrid.Visible := True;
    end
  else
    begin
      AMCErrorText.Visible := False;
      btnAMCReview.Visible := False;
      XMLValidationMsgsGrid.Visible := False;
      stProcessWait.Color := clLime;
      stProcessWait.Font.Color := clWindowText;
      stProcessWait.Caption := 'Click the Send button to Transmit Your Appraisal';
      stProcessWait.Visible := True;
      stProcessWait.Refresh;
    end;
  if AMCStdInfo[FAMCOrder.ProviderIdx].XMLExport then
    btnSave.Caption := 'Send'
  else
    btnSave.Caption := 'Save';

  FMiscInfo := TMiscInfo.create;
  FMiscInfo.FOrderID := FAMCOrder.OrderID;
  FMiscInfo.FAppraiserID := FAMCOrder.ProviderID;
  FMiscInfo.FHasUndueInfluence := False;
  FMiscInfo.FUndueInfluenceDesc := '';
  FMiscInfo.FRevOverride := False;
end;

procedure TAMC_SendPak.btnSaveClick(Sender: TObject);
var
  signList: TStringList;
begin
  if (FAMCOrder.ProviderIdx > -1) then
    begin
      signList := Fdoc.GetSignatureTypes;
      if assigned(signList) and (FDoc.docSignatures.SignatureIndexOf('Appraiser') < 0) then
        ShowNotice('The report cannot be sent to ' + Trim(FAMCOrder.SvcSendRptName) + '. ' +
                   'The signature of the Appraiser is not affixed.')
      else
        if (not assigned(signList)) or SupvSignatureOK(False) then
          begin
            stProcessWait.Color := clLime;
            stProcessWait.Font.Color := clWindowText;
            stProcessWait.Caption := 'Please Wait - Transmitting Your Appraisal';
            stProcessWait.Visible := True;
            stProcessWait.Refresh;
            SendXMLReport;
            stProcessWait.Visible := False;
          end
        else
          if SupvSignatureOK then
            stProcessWait.Visible := False
          else
            ShowSupvSignWarning('Supervisor')
    end;

  PackageData.FAlertMsg := 'Your Appraisal Report Package has been successfully uploaded.';

  TAMCDeliveryProcess(TPageControl(TTabSheet(Self.Owner).PageControl).Owner).MoveToNextProcess(nil);

end;

procedure TAMC_SendPak.SendXMLReport;
var
  xmlReport: String;
  TransmitOK: Integer;
  FTmpPDFPath: String;
begin
  // Disable the send button to prevent the user from double-clicking
  btnSave.Enabled := False;
  PushMouseCursor(crHourGlass);
  TransmitOK := cseOther;
  try
    try
      FTmpPDFPath := CreatePDF(False);        //create the PDF here as the user may have made changes
                                              //## this should be revised to use the LoadPDFToDataFile function

      if FileExists(FTmpPDFPath) then         //did the user cancel out of PDF Security
        begin
          xmlReport := CreateXML(FTmpPDFPath);  //create the XML file - it combines the PDF
          TransmitOK := TransmitXMLReport(xmlReport);   //transmit the XML file
        end;
    except
      on E: Exception do
        ShowAlert(atWarnAlert, errProblem + E.Message);
    end;
  finally
    if fileExists(FTmpPDFPath) then         //clean up temp storage
      DeleteFile(FTmpPDFPath);

    // If a connection, transmission or reported error occurs then re-enable the Send button
    if TransmitOK > cseOK then
      case TransmitOK of
        cseInvalidXMLSig:
          btnAMCReview.Enabled := True;
      else
        btnSave.Enabled := True;
      end;
    PopMouseCursor;
  end;
end;

function TAMC_SendPak.CreatePDF(showPDF: Boolean): String;
var
  tmpfPath: String;
  showPref: Boolean;
begin
  tmpfPath := CreateTempFilePath(PDFFileName);
  showPref := False;

  result := FDoc.CreateReportPDFEx(tmpfPath, showPDF, showPref, packageData.FProtectPDF, PackageData.FPgList);
end;

function TAMC_SendPak.CreateXML(PDFPath: String): String;
var
  XMLVer: String;
begin
  //set the parameter in the Info object
  if fileExists(PDFPath) then
    begin
      FMiscInfo.FEmbedPDF := True;
      FMiscInfo.FPDFFileToEmbed := PDFPath;
    end
  else
    begin
      FMiscInfo.FEmbedPDF := False;
      FMiscInfo.FPDFFileToEmbed := '';
    end;

  result := ComposeGSEAppraisalXMLReport(FDoc, XMLVer, PackageData.FormList, FMiscInfo, FXMLErrorList,
    AMCStdInfo[FAMCOrder.ProviderIdx].XMLLocType);
end;

//This routine transmits the report and also show the results
function TAMC_SendPak.TransmitXMLReport(XMLData: String): Integer;
var
  ErrCode: Integer;        //code for class/category of error
  ErrMsg: String;          //detailed error message for user
  data: FormData;
  qcSendDataResp: FulfillDataResponse;
  cmnts: UserComments;
  ProviderID: Integer;
  RequestXML: String;
  //for debugging
  {strm: TFileStream;
  xmlStr: String;}
  //...for debugging
begin
  result := cseOther;   //assume there are other, or unknown, errors
  if AMCStdInfo[FAMCOrder.ProviderIdx].XMLValSigReqd and (length(FValidationSignature) = 0) then
    begin
      ShowAlert(atWarnAlert, errMsgInvalidVldnSignature);
      exit;
    end;
  if (length(XMLData) = 0) then        //XML from final build
    begin
       ShowAlert(atWarnAlert, errMsgNoXmlData);
       exit;
    end;
  ProviderID := StrToInt(FAMCOrder.ProviderID);

  // Preliminary data checks are OK so form the XML packet and send
  data := FormData.Create;
  data.XmlSignature := FValidationSignature;
  data.OrderID := FAMCOrder.OrderID;
  data.FormXml := XMLData;
  // Add the comments from the container
  setlength(cmnts,0);
  cmnts := ReadUserCommentsFromReport(FDoc);
  data.Comments := GetQualityValidationComments(cmnts);
  PushMouseCursor(crHourGlass);
  RequestXML := FormRequestXML(data, ProviderID);

  //for debugging
  {xmlStr := data.FormXml;
  strm := TFileStream.Create('C:\TEMP\xmlToSend.xml',fmCreate);
  strm.Write(Pchar(xmlStr)^,length(xmlStr));
  strm.Free;}
  //...for debugging

  try
      // If there was no order (ex. sent by fax) then we may need to use
      //  the provider's default submission url.
      if Trim(FAMCOrder.SvcSendRptEndPointURL) = '' then
        FAMCOrder.SvcSendRptEndPointURL := AMCStdInfo[FAMCOrder.ProviderIdx].SvcSendRptUrl;
      case ProviderID of
        901:
          begin
            errCode := AMCSubmitReport(FAMCOrder.ProviderIdx, AMCUserId, AMCUserPassword,
                                        FAMCOrder.OrderID, FAMCOrder.SvcSendRptEndPointURL,
                                        RequestXml, qcSendDataResp, errMsg);
            if errCode = 7 then
              errCode := cseInvalidReport;
          end;
      else
        errCode := cseInvalidProvider;
        errMsg := errMsgInvalidProviderID;
      end;

    case errCode of
       cseOK:
        begin
          ShowAlert(atInfoAlert, 'Your appraisal report has been successfully transmitted.');
        end;
       cseInvalidXMLSig, cseInvalidReport:
        begin
          ShowAlert(atWarnAlert, errMsg);
        end;
       else //cseNotConnected, cseOrderNotFound, cseOther
        begin
          SaveAMCSvcErr('CISSubmitReport',
                        'Order:' + FAMCOrder.OrderID + ' ' + errMsg,
                        AMCStdInfo[FAMCOrder.ProviderIdx].ID,
                        ErrCode,
                        AMCStdInfo[FAMCOrder.ProviderIdx].SvcLogCount);
          ShowAlert(atWarnAlert, errMsg);
        end;
    end;
  finally
    PopMouseCursor;
  end;
end;

procedure TAMC_SendPak.btnAMCReviewClick(Sender: TObject);
begin
  ValidateXML;
end;

procedure TAMC_SendPak.ValidateXML;
const
  CrLf = #13#10;
var
  f,formKind: Integer;
  errCode: Integer;
  errMsg: String;
  Data: FormData;
  qcValDataResp: ValidateDataResponse;
  qcp: QualityControlPackage;
  crsr: TCursor;
  cmnts: UserComments;
  UserInfo: AMCUserUID;
  UserCanceled, ReSend: Boolean;
  ProviderID: Integer;
  RequestXML, AMCXMLVer: String;
  SvcName: String;
begin
  FErrors := 0;
  FWarningComments := 0;
  AMCErrorText.Caption := '';
  SvcName := AMCStdInfo[FAMCOrder.ProviderIdx].SvcInfoName;
  if not assigned(FDoc) then
    exit;
  if length(trim(FAMCOrder.OrderID)) = 0 then
    begin
      errMsg := 'This report does not have a valid ' + SvcName + ' order ID.';
      ShowAlert(atWarnAlert, errMsg);
      Exit;
    end;

  //exclude the Invoices and the Order forms
  SetLength(FFormList, FDoc.docForm.count);
  for f := 0 to FDoc.docForm.Count-1 do
    begin
      FFormList[f] := True;
      formKind := FDoc.docForm[f].frmInfo.fFormKindID;
      if (formKind = fkInvoice) or (formKind = fkOrder) then
        FFormList[f] := False;
    end;

  data := FormData.Create;
  qcValDataResp := ValidateDataResponse.Create;
  qcp := QualityControlPackage.Create;
  crsr := Screen.Cursor;
  Screen.Cursor := crHourGlass	;
  try
    FProcessBusy := True;
    stProcessWait.Color := clLime;
    stProcessWait.Font.Color := clWindowText;
    stProcessWait.Caption := 'Please Wait - ' + SvcName + ' is Reviewing Your Appraisal';
    stProcessWait.Visible := True;
    stProcessWait.Refresh;

    btnAMCReview.Enabled := False;
    btnSave.Visible := False;
    isXMLSetup;
    data.XmlSignature := '';
    data.OrderID := FAMCOrder.OrderID;

    // Compose the report xml and, if necessary, change formatting and add any headers
    //  or footers to accommodate provider requirements.
    if FAMCOrder.XMLVer = '2.4.1' then
      data.FormXml := UMISMOInterface.ComposeAppraisalXMLReport(FDoc, FFormList, FMiscInfo, FXMLErrorList)
    else
      begin
        AMCXMLVer := StringReplace(FAMCOrder.XMLVer, '.', '_', [rfReplaceAll]);
        data.FormXml := UGSEInterface.ComposeGSEAppraisalXMLReport(FDoc, AMCXMLVer, FFormList, FMiscInfo, FXMLErrorList, AMCStdInfo[FAMCOrder.ProviderIdx].XMLLocType);
      end;

    setlength(cmnts,0);
    cmnts := ReadUserCommentsFromReport(FDoc);
    data.Comments := GetQualityValidationComments(cmnts);

    ProviderID := StrToInt(FAMCOrder.ProviderID);
    RequestXml := FormRequestXML(data, ProviderID);

    repeat
      Resend := False;
      if Trim(FAMCOrder.SvcVerRptEndPointURL) = '' then
        FAMCOrder.SvcVerRptEndPointURL := AMCStdInfo[FAMCOrder.ProviderIdx].SvcVerRptUrl;
      case ProviderID of
        901:
          begin
            errCode := AMCVerifyReport(FAMCOrder.ProviderIdx, AMCUserId, AMCUserPassword,
                                       FAMCOrder.OrderID, FAMCOrder.SvcVerRptEndPointURL,
                                       RequestXml, qcValDataResp, errMsg);
            if errCode = 7 then
              errCode := cseInvalidReport;
          end;
      else
        errCode := cseInvalidProvider;
        errMsg := errMsgInvalidProviderID;
      end;
      case errCode of
       cseOK, cseInvalidReport:
        begin
          UserInfo.VendorID := FAMCOrder.ProviderID;
          UserInfo.UserId := AMCUserID;
          UserInfo.UserPSW := AMCUserPassword;
          SetAMCUserRegistryInfo(FAMCOrder.ProviderID, UserInfo);
        end;
       cseInvalidLogin:
        begin
          UserCanceled := GetAMCUserCredentials(UserInfo, SvcName);      //get users authentication info
          //  & set the resend flag to false
          if not UserCanceled then
            ReSend := True;
        end;
       else //cseNotConnected, cseOrderNotFound, cseOther
        begin
          SaveAMCSvcErr('AMCVerifyReport',
                        'Order:' + FAMCOrder.OrderID + ' ' + errMsg,
                        AMCStdInfo[FAMCOrder.ProviderIdx].ID,
                        ErrCode,
                        AMCStdInfo[FAMCOrder.ProviderIdx].SvcLogCount);
          stProcessWait.Visible := False;
          ShowAlert(atWarnAlert, SvcName + ' Error ' + IntToStr(errCode) + ': ' + errMsg);
          exit;
        end;
      end;
    until not ReSend;

    case ProviderID of
      901: // Nasoft-Woodfinn
        begin
          FValidationErrors.ReadAMCValidationFromQCP(FDoc, MsgError, qcValDataResp, FFormList);
          FValidationWarnings.ReadAMCValidationFromQCP(FDoc, MsgWarn, qcValDataResp, FFormList);
          FValidationWarnings.AddUserComments(cmnts);
          FValidationWarningsYesNo.ReadAMCValidationFromQCP(FDoc, MsgWarningYN, qcValDataResp, FFormList);
          FValidationWarningsYesNo.AddUserComments(cmnts);
          FValidationAlerts.ReadAMCValidationFromQCP(FDoc, MsgAlert, qcValDataResp, FFormList);
          FValidationAlerts.AddUserComments(cmnts);
          // Version 7.1.0.3 022210 JWyatt We need to check comment length in case there are
          //  no comments. If we don't then an empty comment form may be created.
          if Length(cmnts) > 0 then
            begin
              WriteCommentToCommentPage;
              WriteUserCommentToReport;
            end;
          FValidationSignature := qcp.XmlSignature;
        end;
    else
      begin
        FValidationErrors.ReadValidationFromQCP(Error,qcp,FFormList);
        FValidationWarnings.ReadValidationFromQCP(Warning,qcp,FFormList);
        FValidationWarnings.AddUserComments(cmnts);
        FValidationWarningsYesNo.ReadValidationFromQCP(WarningRequiresYesNo,qcp,FFormList);
        FValidationWarningsYesNo.AddUserComments(cmnts);
        // Version 7.1.0.3 022210 JWyatt We need to check comment length in case there are
        //  no comments. If we don't then an empty comment form may be created.
        if Length(cmnts) > 0 then
          begin
            WriteCommentToCommentPage;
            WriteUserCommentToReport;
          end;
        FValidationSignature := qcp.XmlSignature;
      end;
    end;

    btnSave.Visible := True;
    case GetValidationStatus of
      valStatusOK:
        begin
          stProcessWait.Visible := False;
          btnSave.Enabled := True;
          ShowValidationErrors(ProviderID);
          XMLValidationMsgsGrid.Rows := FAlerts;
          UpdValidationErrCount;
         end;
      valStatusOKwWarnings:
        begin
          stProcessWait.Visible := False;
          ShowValidationErrors(ProviderID);
          btnSave.Enabled := True;
        end;
      valStatusErrors:
        begin
          stProcessWait.Visible := False;
          ShowValidationErrors(ProviderID);
          btnSave.Enabled := False;
        end;
      valStatusNA:
        begin
          stProcessWait.Color := clWhite;
          stProcessWait.Font.Color := clRed;
          stProcessWait.Caption := 'Outstanding Errors / Warnings, please run the ' +
            SvcName + ' Quality Review';
          stProcessWait.Refresh;
          ShowValidationErrors(ProviderID);
          btnSave.Enabled := False;
        end;
    end;
  finally
    if (stProcessWait.Color <> clWhite) and (not SupvSignatureOK) then
      ShowSupvSignWarning('Supervisor');
    btnAMCReview.Enabled := True;
    btnSave.Visible := True;
    FProcessBusy := False;
    Screen.Cursor := crsr;
    data.Free;
    qcp.Free;
    qcValDataResp.Free;
  end;
end;

function TAMC_SendPak.FormRequestXML(theData: FormData; ProviderID: Integer): String;
const
  RuleID = 'RuleID:';
  RptDataBeg = '<ReportData>';
  RptDataEnd = '</ReportData>';
  RptXMLBeg = '<ReportXml>';
  RptXMLEnd = '</ReportXml>';
  XMLSigBeg = '<XmlSignature>';
  XMLSigEnd = '</XmlSignature>';
  CmntsBeg = '<ValidationComments>';
  CmntsEnd = '</ValidationComments>';
  CmntBeg = '<ValidationComment>';
  CmntEnd = '</ValidationComment>';
  UsrCmntsBeg = '<UserComments>';
  UsrCmntsEnd = '</UserComments>';
  LocsBeg = '<Locations>';
  LocsEnd = '</Locations>';
  LocBeg = '<Locator>';
  LocEnd = '</Locator>';
  RuleIDBeg = '<RuleID>';
  RuleIDEnd = '</RuleID>';
  TextBeg = '<Text>';
  TextEnd = '</Text>';
var
  xmlStr, msgID: String;
  cmntNo, nCmnts: Integer;
begin
  xmlStr := theData.FormXml;
  nCmnts := length(theData.Comments);
  case ProviderID of
    901:
      begin
        xmlStr := StringReplace(xmlStr, '<', '&lt;', [rfReplaceAll]);
        xmlStr := StringReplace(xmlStr, '>', '&gt;', [rfReplaceAll]);
        xmlStr := RptDataBeg +
                  XmlSigBeg + theData.XmlSignature + XmlSigEnd +
                  RptXMLBeg + xmlStr + RptXMLEnd + CmntsBeg;

        if nCmnts > 0 then
          for cmntNo := 0 to nCmnts - 1 do
            begin
              xmlStr := xmlStr + CmntBeg;
              xmlStr := xmlStr + LocsBeg + LocBeg + LocEnd + LocsEnd;
              xmlStr := xmlStr + RuleIDBeg;
              MsgID := theData.Comments[cmntNo].MessageID;
              // If the message begins with the RuleID text then strip it
              if Copy(MsgID, 1, Length(RuleID)) = RuleID then
                xmlStr := xmlStr + Copy(MsgID, Succ(Length(RuleID)), Length(MsgID))
              else
                xmlStr := xmlStr + MsgID;
              xmlStr := xmlStr + RuleIDEnd;
              xmlStr := xmlStr + TextBeg + theData.Comments[cmntNo].Text + TextEnd;
              xmlStr := xmlStr + CmntEnd;
           end;
        xmlStr := xmlStr + CmntsEnd;

        xmlStr := xmlStr + RptDataEnd;
        Result := xmlStr;
      end;
  else
    Result := xmlStr;
  end;
end;

function TAMC_SendPak.SupvSignatureOK(Silent: Boolean=True): Boolean;
var
  SupvSignReqd, hasSignature: Boolean;
  FormCounter: Integer;
  ThisForm: TDocForm;
begin
  Result := True;
  // Check to see if a supervisor's name is required. If so, make sure that it's affixed
  //  and the date has been set. If not, then send the report.
  SupvSignReqd := False; // default is no supervisor signature is required
  hasSignature := False;
  FormCounter := -1;
  repeat
    FormCounter := Succ(FormCounter);
    ThisForm := FDoc.docForm.Forms[FormCounter];
    //Is the supervisor's name on this form?
    if ((XIDSupv > 0) and (length(ThisForm.GetCellTextByXID_MISMO(XIDSupv)) > 0)) or
       ((XIDSupvAlt > 0) and (length(ThisForm.GetCellTextByXID_MISMO(XIDSupvAlt)) > 0)) then
      begin
        SupvSignReqd := True; // supervisor signature is required
        //Supervisor's Signature
        hasSignature := ((FDoc.docSignatures.SignatureIndexOf('Supervisor') > -1) or
                         (FDoc.docSignatures.SignatureIndexOf('Co-Appraiser') > -1));
      end;
  until (SupvSignReqd) or (FormCounter = Pred(FDoc.docForm.count));
  if SupvSignReqd and (not hasSignature) then
    begin
      if (not Silent) and
         (YesNoCancel('Sorry, the report cannot be sent to ' + AMCStdInfo[FAMCOrder.ProviderIdx].SvcInfoName + ' until ' +
                      'the Supervisor signature is affixed. ' +
                      'Do you want to affix the signature now?') = mrYes) then
        SignDocWithStamp(FDoc);
      Result := False;
    end;
end;

procedure TAMC_SendPak.ShowSupvSignWarning(ApprSupv: String);
begin
  stProcessWait.Color := clYellow;
  stProcessWait.Caption := 'The ' + Trim(ApprSupv) + ' has not signed the report';
  stProcessWait.Visible := True;
  stProcessWait.Refresh;
end;

procedure TAMC_SendPak.WriteUserCommentToReport;
var
  cmnts, cmntsYesNo: UserComments;
  cmnt: UserComment;
  cmntNo, nCmnts, nCmntsYesNo: Integer;
  strm: TStream;
begin
  if not assigned(FDoc) then
    exit;
  setlength(cmnts,0);
  cmnts := FValidationWarnings.ExtractUserComments;
  cmntsYesNo := FValidationWarningsYesNo.ExtractUserComments;
  nCmnts := length(cmnts);
  nCmntsYesNo := length(cmntsYesNo);
  strm := TMemoryStream.Create;
  try
    WriteLongToStream(nCmnts + nCmntsYesNo,strm);
    if nCmnts > 0 then
      for cmntNo := 0 to nCmnts - 1 do
        begin
          cmnt := cmnts[cmntNo];
          WriteStringToStream(cmnt.msgID,strm);
          WriteStringTostream(cmnt.comment,strm);
       end;
    if nCmntsYesNo > 0 then
      for cmntNo := 0 to nCmntsYesNo - 1 do
        begin
          cmnt := cmntsYesNo[cmntNo];
          WriteStringToStream(cmnt.msgID,strm);
          WriteStringTostream(cmnt.comment,strm);
       end;

    FDoc.docData.UpdateData(ddAMCValidationUserComment, strm);
    FDoc.docDataChged := True;      //force to save validation
  finally
    strm.Free;
  end;
end;

procedure TAMC_SendPak.WriteCommentToCommentPage;

  function GetNextCommentCell(doc:TContainer; var cmntCell,pcCell: TBaseCell; var occur: Integer;
                              cmntFormID: Integer;bCreateNewCmntPage: Boolean): Boolean;
  var
    cmntForm: TDocForm;
  begin
    result := False;
    cmntForm := doc.GetFormByOccurance(cmntFormID, occur, bCreateNewCmntPage);
    if assigned(cmntForm) then
      begin
        cmntCell := cmntForm.GetCellByID(cAMCValCmntsCellID);
        pcCell := cmntForm.GetCellByID(cSubjectZipCellID);
        inc(occur);
        result := True;
      end;
  end;

var
  ValidationCommentFormUID: Integer;
  warnNo, nWarns, nWarnsYesNo: Integer;
  occur: Integer;
  cmntText: String;
  cmntCell, pcCell: TBaseCell;
  cmntPkg, prevCmntPkg: String;
  warningHasComment: Boolean;
begin
  if not assigned(FDoc) then
    exit;
  nWarns := length(FValidationwarnings.messages);
  nWarnsYesNo := length(FValidationWarningsYesNo.Messages);
  if (nWarns = 0) and (nWarnsYesNo = 0) then
    exit;
  //set Comment Form ID
  ValidationCommentFormUID := AMCQualityChkFormUIDEn;
  if (ValidationCommentFormUID <> AMCQualityChkFormUIDAlt) and
     (FDoc.GetFormIndex(AMCQualityChkFormUIDAlt) >= 0) then
    ValidationCommentFormUID := AMCQualityChkFormUIDAlt;
  //delete the present comments
  occur := 0;
  while GetNextCommentCell(FDoc, cmntCell, pcCell, occur, ValidationCommentFormUID, False) do
    begin
      if not assigned(cmntcell) or not ((cmntCell is TMLnTextCell) or (cmntCell is TWordProcessorCell)) then
        begin
          ShowAlert(atWarnAlert,errMsgInvalidCmntForm);
          exit;
        end;
      cmntCell.SetText('');
    end;
  //write user comment Validation Comment Form
  occur := 0;
  if not GetNextCommentCell(FDoc, cmntCell, pcCell, occur, ValidationCommentFormUID, True) then
    exit;
  cmntPkg := '';
  for warnNo := 0 to nWarns + nWarnsYesNo - 1 do
    begin
      if WarnNo < nWarns then
        warningHasComment := FValidationWarnings.GetComment(warnNo,cmntText)
      else
        warningHasComment := FValidationWarningsYesNo.GetComment(warnNo - nWarns,cmntText);
      if not warningHasComment then
        continue;
      prevCmntPkg := cmntPkg;
      cmntPkg := cmntPkg + cmntText;
      // Use Pred(TMLnTextCell... so the text does not encompass the entire cell
      //  and turn red, indicating overflow.
      if length(TMLnTextCell(cmntCell).CheckWordWrap(cmntPkg)) <=  Pred(TMLnTextCell(cmntCell).FMaxLines) then
        continue
      else
        begin
          if assigned(cmntCell.Editor) then
            begin
              cmntCell.Disabled := False;
              cmntCell.DoSetText(cmntPkg);
              cmntCell.Disabled := True;
            end
          else
            begin
              pcCell.FocusOnWindow;  // change focus so the comment cell will update
              cmntCell.Disabled := False;
              cmntCell.LoadContent(prevCmntPkg, True);
              cmntCell.Disabled := True;
            end;
          cmntCell.FocusOnCell;
          pcCell.FocusOnCell;  // change focus so the comment cell will update
          cmntPkg := cmntText;
          if not GetNextCommentCell(FDoc, cmntCell, pcCell, occur, ValidationCommentFormUID, True) then
            exit; //something wrong
        end;
    end;
    if assigned(cmntCell.Editor) then
      begin
        cmntCell.Disabled := False;
        cmntCell.DoSetText(cmntPkg);
        cmntCell.Disabled := True;
      end
    else
      begin
        pcCell.FocusOnWindow;  // change focus so the comment cell will update
        cmntCell.Disabled := False;
        cmntCell.LoadContent(cmntPkg,True);     //load uncompleted comment package
        cmntCell.Disabled := True;
      end;
    cmntCell.FocusOnCell;
end;


procedure TAMC_SendPak.UpdValidationErrCount;
begin
  AMCErrorText.Caption := IntToStr(FErrors) + ' Error(s) remaining     ' +
                          IntToStr(FWarningComments) + ' Warning(s) without comment remaining     ' +
                          IntToStr(FAlerts) + ' Alert(s)';
  if (FErrors > 0) or (FWarningComments > 0)  or (FAlerts > 0) then
    AMCErrorText.Font.Color := clRed
  else
    AMCErrorText.Font.Color := clBlack;
end;

procedure TAMC_SendPak.ClearXMLValidationMsgsGrid;
begin
  XMLValidationMsgsGrid.BeginUpdate;
  XMLValidationMsgsGrid.rows := 0;
  XMLValidationMsgsGrid.EndUpdate;
end;

function TAMC_SendPak.CreateLocationStr(clID: TCellID): String;
begin
  result := '';
  if assigned(clID) then
    if (clID.Form > 0) and
       (clID.Pg > 0) and
       (clID.Num > 0) then
      begin
        result := IntToStr(clID.Form) + ', ' + FDoc.docForm[clID.Form].frmInfo.fFormName;
        result := result + ', ';
        result := result + IntToStr(clID.Pg);
        result := result + ', ';
        result := result + IntToStr(clID.Num);
      end;
end;

procedure TAMC_SendPak.InitLocationCombo(row: Integer; nLocations: Integer);
begin
  with XMLValidationMsgsGrid do
    begin
      CellButtonType[vldnColLocation,row] := btCombo;
      AssignCellCombo(vldnColLocation,row);
      CellDropDownStyle[vldnColLocation,row] := ddDropDownList;
      CellCombo[vldnColLocation,row].ComboGrid.StoreData := True;
      CellCombo[vldnColLocation,row].ComboGrid.Cols := 1;
      CellCombo[vldnColLocation,row].DropDownCols := 1;
      CellCombo[vldnColLocation,row].DropDownRows := nLocations;
      CellCombo[vldnColLocation,row].ComboGrid.Rows := nLocations;
      Cellcombo[vldnColLocation,row].ValueCol := 1;
      CellCombo[vldnColLocation,row].AutoSearch := asTop;
      CellCombo[vldnColLocation,row].ComboGrid.Col[1].Width := 200;
    end;
end;

procedure TAMC_SendPak.ShowValidationErrors;
var
  rw: Integer;
  nLocations: Integer;
  validation: TXMLValidation;
  warningRow: Integer;
  RuleNameHeight: Integer;
begin
 ClearXMLValidationMsgsGrid;
  //fill out error grid
 validation := FValidationErrors;
 FErrors := 0;
 XMLValidationMsgsGrid.Rows := length(FValidationErrors.Messages) +
                               length(FValidationWarnings.Messages) +
                               length(FValidationWarningsYesNo.Messages) +
                               length(FValidationAlerts.Messages);
 if length(validation.Messages) > 0 then
   with XMLValidationMsgsGrid, validation do
    begin
      FErrors := length(messages);
      for  rw := 0 to length(messages) - 1 do
        begin
          RowColor[rw + 1] := clYellow;
          cellReadOnly[vldnColResponse, rw+1] := roOn;   //user comment allowed only on Warning
          nLocations := length(messages[rw].Locations);
          case nLocations of
            0: ;  //do nothing
            1:
              Cell[vldnColLocation,rw + 1] := CreateLocationStr(messages[rw].locations[0]);
            else //2 or more locations per message ;    need combo box
              begin
                InitLocationCombo(rw + 1,nLocations);
                Cell[vldnColLocation,rw + 1] := CreateLocationStr(messages[rw].locations[0]);
              end;
          end;
          cell[vldnColRule,rw + 1] := GetRuleText('RuleID:', messages[rw].msgID);
          cell[vldnColSubRule,rw + 1] := GetRuleText('SubRuleID:', messages[rw].msgID);
          cell[vldnColMsgType,rw + 1] :=  'Error';
          cell[vldnColMsgID,rw + 1] :=  GetRuleText('RuleName:', messages[rw].msgID);
          cell[vldnColDescr,rw + 1] := messages[rw].msgText;
          if Canvas.TextWidth( cell[vldnColDescr,rw + 1])  > col[vldnColDescr].Width then
            begin
              // JWyatt Use the Round function instead of div to better capture
              //  overruns so that the height accomodates all the text.
              //  Was: RowHeight[rw + 1] := ((Canvas.TextWidth( cell[vldnColDescr,rw + 1]) div col[vldnColDescr].Width) + 1) * RowOptions.DefaultRowHeight;
              RowHeight[rw + 1] := (Round(Canvas.TextWidth(cell[vldnColDescr,rw + 1]) / col[vldnColDescr].Width)) * RowOptions.DefaultRowHeight;
              RowWordWrap[rw + 1] := wwOn;
            end;
          if Canvas.TextWidth( cell[vldnColMsgID,rw + 1])  > col[vldnColMsgID].Width then
            begin
              // 050910 JWyatt Chek the rule name column. If it overruns and its
              //  calculated height is creater than set for the description
              //  then use this height instead.
              RuleNameHeight := (Round(Canvas.TextWidth(cell[vldnColMsgID,rw + 1]) / col[vldnColMsgID].Width)) * RowOptions.DefaultRowHeight;
              if RuleNameHeight > RowHeight[rw + 1] then
                RowHeight[rw + 1] := RuleNameHeight;
              RowWordWrap[rw + 1] := wwOn;
            end;
        end;
    end;
 //fill out warning part of grid
 validation := FValidationWarnings;
 FWarnings := 0;
 FWarningComments := 0;
 if length(validation.Messages) > 0 then
   with XMLValidationMsgsGrid, validation do
    begin
      FWarnings := length(messages);
      for  rw := 0 to length(messages) - 1 do
        begin
          warningRow := FErrors + rw + 1;
          nLocations := length(messages[rw].Locations);
          case nLocations of
            0: ;  //do nothing
            1:
              Cell[vldnColLocation,warningRow] := CreateLocationStr(messages[rw].locations[0]);
            else //2 or more locations per message ;    need combo box
              begin
                InitLocationCombo(warningRow,nLocations);
                Cell[vldnColLocation,warningRow] := CreateLocationStr(messages[rw].locations[0]);
              end;
          end;
          cell[vldnColRule,warningRow] := GetRuleText('RuleID:', messages[rw].msgID);
          cell[vldnColSubRule,warningRow] := GetRuleText('SubRuleID:', messages[rw].msgID);
          cell[vldnColMsgType,warningRow] :=  'Warning';
          cell[vldnColMsgID,warningRow] :=  GetRuleText('RuleName:', messages[rw].msgID);
          cell[vldnColDescr,warningRow] := messages[rw].msgText;
          if Canvas.TextWidth( cell[vldnColDescr,warningRow])  > col[vldnColDescr].Width then
            begin
              RowHeight[warningRow] := (Round(Canvas.TextWidth(cell[vldnColDescr,warningRow]) / col[vldnColDescr].Width) + 1) * RowOptions.DefaultRowHeight;
              RowWordWrap[warningRow] := wwOn;
            end;
          if Canvas.TextWidth( cell[vldnColMsgID,warningRow])  > col[vldnColMsgID].Width then
            begin
              // Version 7.1.2 050910 JWyatt Check the rule name column. If it overruns
              //  and its calculated height is creater than set for the description
              //  then use this height instead.
              RuleNameHeight :=(Round(Canvas.TextWidth(cell[vldnColMsgID,warningRow]) / col[vldnColMsgID].Width) + 1) * RowOptions.DefaultRowHeight;
              if RuleNameHeight > RowHeight[warningRow] then
                RowHeight[warningRow] := RuleNameHeight;
              RowWordWrap[warningRow] := wwOn;
            end;
          if Trim(messages[rw].userComment) <> '' then
            XMLValidationMsgsGrid.RowColor[warningRow] := clMoneyGreen
          else
            FWarningComments := Succ(FWarningComments);
        end;
    end;
 //fill out warning Yes-No part of grid
 validation := FValidationWarningsYesNo;
 if length(validation.Messages) > 0 then
   with XMLValidationMsgsGrid, validation do
    begin
      for  rw := 0 to length(messages) - 1 do
        begin
          warningRow := FErrors + FWarnings + rw + 1;
          nLocations := length(messages[rw].Locations);
          case nLocations of
            0: ;  //do nothing
            1:
              Cell[vldnColLocation,warningRow] := CreateLocationStr(messages[rw].locations[0]);
            else //2 or more locations per message ;    need combo box
              begin
                InitLocationCombo(warningRow,nLocations);
                Cell[vldnColLocation,warningRow] := CreateLocationStr(messages[rw].locations[0]);
              end;
          end;
          cell[vldnColRule,warningRow] := GetRuleText('RuleID:', messages[rw].msgID);
          cell[vldnColSubRule,warningRow] := GetRuleText('SubRuleID:', messages[rw].msgID);
          cell[vldnColMsgType,warningRow] :=  'Warning';
          cell[vldnColMsgID,warningRow] :=  GetRuleText('RuleName:', messages[rw].msgID);
          cell[vldnColDescr,warningRow] := '[*]' + messages[rw].msgText;
          if Canvas.TextWidth( cell[vldnColDescr,warningRow])  > col[vldnColDescr].Width then
            begin
              RowHeight[warningRow] := (Round(Canvas.TextWidth( cell[vldnColDescr,warningRow]) div col[vldnColDescr].Width) + 1) * RowOptions.DefaultRowHeight;
              RowWordWrap[warningRow] := wwOn;
            end;
          if Canvas.TextWidth( cell[vldnColMsgID,warningRow])  > col[vldnColMsgID].Width then
            begin
              // Version 7.1.2 050910 JWyatt Check the rule name column. If it overruns
              //  and its calculated height is creater than set for the description
              //  then use this height instead.
              RuleNameHeight :=(Round(Canvas.TextWidth(cell[vldnColMsgID,warningRow]) / col[vldnColMsgID].Width) + 1) * RowOptions.DefaultRowHeight;
              if RuleNameHeight > RowHeight[warningRow] then
                RowHeight[warningRow] := RuleNameHeight;
              RowWordWrap[warningRow] := wwOn;
            end;
          if Trim(messages[rw].userComment) <> '' then
            XMLValidationMsgsGrid.RowColor[warningRow] := clMoneyGreen
          else
            FWarningComments := Succ(FWarningComments);
        end;
        FWarnings := FWarnings + length(messages);
    end;
 //fill out alert part of grid
 FAlerts := 0;
 validation := FValidationAlerts;
 if length(validation.Messages) > 0 then
   with XMLValidationMsgsGrid, validation do
    begin
      for  rw := 0 to length(messages) - 1 do
        begin
          warningRow := FErrors + FWarnings + rw + 1;
          nLocations := length(messages[rw].Locations);
          cellReadOnly[vldnColResponse, warningRow] := roOn;   //user comment allowed only on Warning
          case nLocations of
            0: ;  //do nothing
            1:
              Cell[vldnColLocation,warningRow] := CreateLocationStr(messages[rw].locations[0]);
            else //2 or more locations per message ;    need combo box
              begin
                InitLocationCombo(warningRow,nLocations);
                Cell[vldnColLocation,warningRow] := CreateLocationStr(messages[rw].locations[0]);
              end;
          end;
          cell[vldnColRule,warningRow] := GetRuleText('RuleID:', messages[rw].msgID);
          cell[vldnColSubRule,warningRow] := GetRuleText('SubRuleID:', messages[rw].msgID);
          cell[vldnColMsgType,warningRow] :=  'Alert';
          cell[vldnColMsgID,warningRow] :=  GetRuleText('RuleName:', messages[rw].msgID);
          cell[vldnColDescr,warningRow] := messages[rw].msgText;
          if Canvas.TextWidth( cell[vldnColDescr,warningRow])  > col[vldnColDescr].Width then
            begin
              RowHeight[warningRow] := (Round(Canvas.TextWidth( cell[vldnColDescr,warningRow]) div col[vldnColDescr].Width) + 1) * RowOptions.DefaultRowHeight;
              RowWordWrap[warningRow] := wwOn;
            end;
          if Canvas.TextWidth( cell[vldnColMsgID,warningRow])  > col[vldnColMsgID].Width then
            begin
              // Version 7.1.2 050910 JWyatt Check the rule name column. If it overruns
              //  and its calculated height is creater than set for the description
              //  then use this height instead.
              RuleNameHeight :=(Round(Canvas.TextWidth(cell[vldnColMsgID,warningRow]) / col[vldnColMsgID].Width) + 1) * RowOptions.DefaultRowHeight;
              if RuleNameHeight > RowHeight[warningRow] then
                RowHeight[warningRow] := RuleNameHeight;
              RowWordWrap[warningRow] := wwOn;
            end;
            XMLValidationMsgsGrid.RowColor[warningRow] := clMoneyGreen;
        end;
        FAlerts := FAlerts + length(messages);
    end;
    // Disable columns not used by a provider
    case ProviderID of
      901:
        begin
          XMLValidationMsgsGrid.Col[4].Visible := False;
          XMLValidationMsgsGrid.Col[7].Visible := False;
        end;
    end;
    UpdValidationErrCount;
end;

procedure TAMC_SendPak.StartProcess;
begin
  if btnAMCReview.Visible then
    ValidateXML;
end;

procedure TAMC_SendPak.DoProcessData;
begin
  inherited;
  PackageData.FGoToNextOk := not FProcessBusy;
  if PackageData.FGoToNextOk and (FErrors > 0) then
    begin
      PackageData.FGoToNextOk := False;
      PackageData.FAlertMsg := 'There are ' + IntToStr(FErrors) + ' errors that must be cleared before you can complete appraisal processing.';
      btnAMCReview.SetFocus;
    end;
end;

procedure TAMC_SendPak.LocateValidationErrOnForm(locString: String);
const
  delim = ',';
var
  curForm: TDocForm;
  frmSeqID,frm,pg,cl: Integer;
  frmName: String;
  clUID: CellUID;
  delimPos: Integer;
  tempStr: String;
  frmNo, Cntr: Integer;
begin
  //get form sequence #
  tempStr := locString;
  delimPos := Pos(delim, tempStr);
  if delimPos = 0 then
    exit;
  frmSeqID := Pred(StrToIntDef(Trim(Copy(tempStr,1, delimPos - 1)), -1));
  tempStr := Trim(Copy(tempStr,delimPos + 1,length(tempStr)));
  //getForm
  delimPos := Pos(delim,tempStr);
  if delimPos = 0 then
    exit;
  frmName := Trim(Copy(tempStr,1,delimPos - 1));
  tempStr := Trim(Copy(tempStr,delimPos + 1,length(tempStr)));
  frmNo := -1;
  for Cntr := 0 to Pred(FDoc.FormCount) do
    if frmSeqID = Cntr then
      begin
        frmNo := Cntr;
        break;
      end;
  if frmNo < 0 then
    exit;
  frm := frmNo;
  //getPage
  delimPos := Pos(delim,tempStr);
  if delimPos = 0 then
    exit;
  pg := StrToIntDef(Trim(Copy(tempStr,1, delimPos - 1)), -1);
  tempStr := Trim(Copy(tempStr,delimPos + 1, length(tempStr)));
  // get cell
  cl := StrToIntDef(tempStr,-1);
  if frm >= 0 then
    begin
      curForm := Fdoc.docForm[frm];
      clUID.Form    := frm;
      clUID.Pg      := pg - 1;
      clUID.Num     := cl - 1;
      clUID.FormID  := curForm.frmInfo.fFormUID;

      BringWindowToTop(FDoc.Handle);
      FDoc.SetFocus;
      FDoc.Switch2NewCell(FDoc.GetCell(clUID),cNotClicked);
    end;
end;

procedure TAMC_SendPak.EditValidationUserComment(Index: Integer);
var
  userCmnt: TUserValidationCmnt;
  warningIndex: Integer;
  bCurrComment: Boolean;
begin
  // comments allowed only for warnings, not errors or alerts
  // 051211 JWyatt Add alert detection to prevent exceptions
  if (Index <= length(FValidationErrors.Messages)) or
     (XMLValidationMsgsGrid.cell[vldnColMsgType,Index] = MsgAlert) then
    exit;
  if XMLValidationMsgsGrid.RowColor[index] = clMoneyGreen then
    bCurrComment := True
  else
    bCurrComment := False;
  userCmnt := TUserValidationCmnt.Create(self);
  userCmnt.ServiceName := AMCStdInfo[FAMCOrder.ProviderIdx].SvcInfoName + ' Validation';
  if Copy(XMLValidationMsgsGrid.Cell[vldnColDescr,Index], 1, 3) = '[*]' then
    begin
      warningIndex := index - length(FValidationErrors.Messages) - length(FValidationWarnings.Messages) - 1;
      with FValidationWarningsYesNo.Messages[warningIndex] do
        with userCmnt do
          begin
            edtDescr.Text := msgText;
            mmComment.Lines.Text := userComment;
            // Check for prior Yes/No response and if found, set the check box and
            //  strip the reponse characters from the message text.
            if Copy(mmComment.Lines.Text, 1, 3) = 'No|' then
              begin
                rbRespNo.Checked := True;
                mmComment.Lines.Text := Copy(mmComment.Lines.Text, 4, Length(mmComment.Lines.Text));
              end
            else if Copy(mmComment.Lines.Text, 1, 4) = 'Yes|' then
              begin
                rbRespYes.Checked := True;
                mmComment.Lines.Text := Copy(mmComment.Lines.Text, 5, Length(mmComment.Lines.Text));
              end
            else
              begin
                rbRespYes.Checked := False;
                rbRespNo.Checked := False;
              end;
            WarningRequiresYesNo := True;
            try
              if userCmnt.ShowModal = mrOK then
                begin
                  userComment := mmComment.Lines.Text;
                  if rbRespYes.Checked then
                    userComment := 'Yes|' + mmComment.Lines.Text
                  else
                    userComment := 'No|' + mmComment.Lines.Text;
                end;
            finally
              userCmnt.Free;
            end;
          end;
        if Trim(FValidationWarningsYesNo.messages[warningIndex].userComment) <> '' then
          begin
            if not bCurrComment then
              begin
                FWarningComments := Pred(FWarningComments);
                UpdValidationErrCount;
              end;
            XMLValidationMsgsGrid.RowColor[index] := clMoneyGreen;
          end
        else
          begin
            if bCurrComment then
              begin
                FWarningComments := Succ(FWarningComments);
                UpdValidationErrCount;
              end;
            XMLValidationMsgsGrid.RowColor[index] := clNone;  //default row color
          end;
    end
  else
    begin
      warningIndex := index - length(FValidationErrors.Messages) - 1;
      with FValidationWarnings.Messages[warningIndex] do
       with userCmnt do
         begin
           edtDescr.Text := msgText;
           mmComment.Lines.Text := userComment;
           try
             if ShowModal = mrOK then
               userComment := mmComment.Lines.Text;
           finally
             userCmnt.Free;
           end;
         end;
        if Trim(FValidationWarnings.messages[warningIndex].userComment) <> '' then
          begin
            if not bCurrComment then
              begin
                FWarningComments := Pred(FWarningComments);
                UpdValidationErrCount;
              end;
            XMLValidationMsgsGrid.RowColor[index] := clMoneyGreen;
          end
        else
          begin
            if bCurrComment then
              begin
                FWarningComments := Succ(FWarningComments);
                UpdValidationErrCount;
              end;
            XMLValidationMsgsGrid.RowColor[index] := clNone;  //default row color
          end;
    end;
  WriteUserCommentToReport;
  WriteCommentToCommentPage;
end;

procedure TAMC_SendPak.OnComboCellLoaded(Sender: TObject;
  Combo: TtsComboGrid; DataCol, DataRow: Integer; var Value: Variant);
var
  msgIndex, LocIndex: Integer;
  clID: TCellID;
  validation: TXMLValidation;
begin
  inherited;
  with XMLValidationMsgsGrid do
    begin
      if CurrentDataRow <= length(FValidationErrors.Messages) then
        begin
          validation := FValidationErrors;
          msgIndex := CurrentDataRow - 1;
        end
      else
        begin
          validation := FValidationWarnings;
          msgIndex := CurrentDataRow - length(FValidationErrors.Messages) - 1;
        end;
      with validation do
        if CurrentDataCol = vldnColLocation then
          begin
            locIndex := DataRow - 1;
            clID := messages[msgIndex].Locations[locIndex];
            if not assigned(clID) then
              exit;
            value := CreateLocationStr(clID);
          end;
    end;
end;

procedure TAMC_SendPak.XMLValidationMsgsGridButtonClick(Sender: TObject;
  DataCol, DataRow: Integer);
begin
  inherited;
  if DataCol = vldnColLocate then //location button
    LocateValidationErrOnForm(XMLValidationMsgsGrid.Cell[vldnColLocation, DataRow])
  else
    if DataCol = vldnColResponse then //response button
      EditValidationUserComment(DataRow);
end;

procedure TAMC_SendPak.XMLValidationMsgsGridDblClickCell(Sender: TObject;
  DataCol, DataRow: Integer; Pos: TtsClickPosition);
begin
  inherited;
  if DataCol = vldnColLocate then //location button
    LocateValidationErrOnForm(XMLValidationMsgsGrid.Cell[vldnColLocation, DataRow])
  else
    if DataCol = vldnColResponse then //response button
      EditValidationUserComment(DataRow);
end;

end.
