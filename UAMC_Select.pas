unit UAMC_Select;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{ This unit is used to select the delivery method: Save File; Email or Upload. }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst,RzLstBox, RzChkLst, RzButton, RzRadChk, Contnrs,
  UContainer, UAMC_Base, UAMC_WorkflowBaseFrame;

type
  TAMC_Selection = class(TWorkflowBaseFrame)
    AMCClientList: TRzCheckList;
    rdoSaveToDesktop: TRzRadioButton;
    rdoEmail: TRzRadioButton;
    rdoUploadToAMC: TRzRadioButton;
    lblPriFormAnswer: TLabel;
    lblAppraisalForm: TLabel;
    lblUADFormatted: TLabel;
    lblXMLVers: TLabel;
    lblUADAnswer: TLabel;
    lblXMLAnswer: TLabel;
    cbxAutoAdvance: TCheckBox;
    cbxDisplayPDF: TCheckBox;
    cbxProtectPDF: TCheckBox;
    lblAutoAdvance: TLabel;
    lblDisplayPDF: TLabel;
    lblProtectPDF: TLabel;
    lblSkipImageOpt: TLabel;
    cbxRunImageOpt: TCheckBox;
    lblShowEOWarnings: TLabel;
    cbxShowEOWarnings: TCheckBox;
    lblSkipPDSReview: TLabel;
    cbxRunPDSReview: TCheckBox;
    Label1: TLabel;
    cbxUADConsistency: TCheckBox;
    procedure AMCClientListClick(Sender: TObject);
    procedure rdoSaveToDesktopClick(Sender: TObject);
    procedure rdoEmailClick(Sender: TObject);
    procedure rdoUploadToAMCClick(Sender: TObject);
 private
    FLastChecked: Integer;
    FAMCList: TObjectList;
    function GetAMC(Index: Integer): TAMC_UID;
    procedure SetReportInfo;
    procedure LoadAMCDisplayList;
    function IsMercuryOrder:Boolean;
    function uadFormSelected: Boolean;
  public
    constructor CreateFrame(AOwner: TComponent; ADoc: TContainer; AData: TDataPackage);  override;
    destructor Destroy;             override;
    procedure InitPackageData;      override;
    procedure DoProcessData;        override;
    function ProcessedOK: Boolean;  override;
    function IsDocSaved: Boolean;
    function IsDocSigned: Boolean;
    function CanUseService(var skipErrorPopup:Boolean): Boolean;
    property AMC[Index: Integer]: TAMC_UID read GetAMC;
  end;

implementation

uses
  UGlobals, UStatus, UStatusService, USignatures, UAMC_Globals, UAMC_XMLUtils,
  UAMC_Workflow, ULicUser, uUtil1,uSendHelp, UUADUtils,UCRMServices,UStrings;

var
  FAMCOrder: AMCOrderInfo;      //holds key order info

{$R *.dfm}

{ TAMC_Select }

constructor TAMC_Selection.CreateFrame(AOwner: TComponent; ADoc: TContainer; AData: TDataPackage);
begin
  inherited;

  AMCClientList.MultiSelect := False;
  LoadAMCDisplayList;   //load the AMC client list

  // Read the order info, if it exists, and default to the order provider
  FAMCOrder := ADoc.ReadAMCOrderInfoFromReport;   //has all info about order/user
  if Length(FAMCOrder.ProviderID) > 0 then
    PackageData.AMCIdentifier := StrToInt(FAMCOrder.ProviderID);

  cbxAutoAdvance.Checked  := appPref_AMCDelivery_AutoAdvance;
  cbxDisplayPDF.Checked   := appPref_AMCDelivery_DisplayPDF;
  cbxProtectPDF.checked   := appPref_AMCDelivery_ProtectPDF;
  cbxRunImageOpt.checked := not appPref_AMCDelivery_SkipImageOpt;
  cbxShowEOWarnings.checked := appPref_AMCDelivery_EOWarnings;
 // cbxRunPDSReview.checked := not appPref_AMCDelivery_SkipPDSReview;  //GH#: 1136
  cbxUADConsistency.checked := appPref_AMCDelivery_UADCOnsistency;
  if isMercuryOrder then
    PackageData.AMCIdentifier := AMC_MercuryNetWOrk;
  FLastChecked := -1;   //so we can uncheck the last upload client
  case PackageData.AMCIdentifier of
    AMC_FNC:
      begin
        rdoUploadToAMC.Checked := true;
        with AMCClientList do
          begin
            ItemIndex := Items.IndexOf('AppraisalPort'); //see function GetAMCList in UAMCWorkflow where the name is hard coded
            if ItemIndex >= 0 then
              begin
                UnselectAll;
                FLastChecked := ItemIndex;
                ItemChecked[FLastChecked] := true;
              end;
          end;
      end;
    AMC_EadPortal:
      begin
        rdoUploadToAMC.Checked := true;
        with AMCClientList do
          begin
            ItemIndex := Items.IndexOf('FHA/EAD Portal'); //see function GetAMCList in UAMCWorkflow where the name is hard coded
            if ItemIndex >= 0 then
              begin
                UnselectAll;
                FLastChecked := ItemIndex;
                ItemChecked[FLastChecked] := true;
              end;
          end;
      end;
    AMC_Veptas:
      begin
        rdoUploadToAMC.Checked := true;
        with AMCClientList do
          begin
            ItemIndex := Items.IndexOf('Veptas'); //see function GetAMCList in UAMCWorkflow where the name is hard coded
            if ItemIndex >= 0 then
              begin
                UnselectAll;
                FLastChecked := ItemIndex;
                ItemChecked[FLastChecked] := true;
               end;
          end;
      end;
    AMC_ISGN:
      begin
        rdoUploadToAMC.Checked := true;
        with AMCClientList do
          begin
            ItemIndex := Items.IndexOf('ISGN'); //see function GetAMCList in UAMCWorkflow where the name is hard coded
            if ItemIndex >= 0 then
              begin
                UnselectAll;
                FLastChecked := ItemIndex;
                ItemChecked[FLastChecked] := true;
              end;
          end;
      end;
    AMC_MercuryNetWork:
      begin
        rdoUploadToAMC.Checked := true;
        with AMCClientList do
          begin
            ItemIndex := Items.IndexOf('MercuryNetWork'); //see function GetAMCList in UAMCWorkflow where the name is hard coded
            if ItemIndex >= 0 then
              begin
                UnselectAll;
                FLastChecked := ItemIndex;
                ItemChecked[FLastChecked] := true;
              end;
          end;

      end;

  end;

  //SetReportInfo;        //diaplay report type

  //InitPackageData;      //this the only frame that calls InitPackageData during create.
end;

destructor TAMC_Selection.Destroy;
begin
  if assigned(FAMCList) then
    FAMCList.Free;

  inherited;
end;

function TAMC_Selection.IsMercuryOrder:Boolean;
var
  aTrackingID:String;
begin
 result := (pos('Mercury', FDoc.FAMCOrderInfo.ProviderID) > 0) or (FDoc.FAMCOrderInfo.TrackingID>0);
 if not result then //try to see we have the Mercury orderid on the form
   begin
     aTrackingID := FDoc.GetCellTextByID(8019);
     FDoc.FAMCOrderInfo.TrackingID := GetValidInteger(aTrackingID);
     result :=  FDoc.FAMCOrderInfo.TrackingID > 0;
   end;
end;

//Package Data is the data object
procedure TAMC_Selection.InitPackageData;
var
  UADOn, MayNeedXML: Boolean;
  XMLVers, ChkBoxTopAdj: Integer;
begin
  inherited;
  SetReportInfo;
  ChkBoxTopAdj := Round((lblAutoAdvance.Height - cbxAutoAdvance.Height) / 2);
  cbxAutoAdvance.Top := lblAutoAdvance.Top + ChkBoxTopAdj;
  cbxDisplayPDF.Top := lblDisplayPDF.Top + ChkBoxTopAdj;
  cbxProtectPDF.Top := lblProtectPDF.Top + ChkBoxTopAdj;
  cbxRunImageOpt.Top := lblSkipImageOpt.Top + ChkBoxTopAdj;

  lblPriFormAnswer.Font.Size := Font.Size;
  lblUADAnswer.Font.Size := Font.Size;
  lblXMLAnswer.Font.Size := Font.Size;

  //PackageData.SetSubjectAddress(FDoc);     //get the address
  //PackageData.CheckForImages(FDoc);        //have images? skip if none

  lblPriFormAnswer.Caption := GetPrimaryFormName(FDoc, PackageData.FFormList);
  if PackageData.FIsUAD then
    lblUADAnswer.Caption := 'Yes'
  else
    lblUADAnswer.Caption := 'No';
  case PackageData.XMLVersion of
    cMISMO241: lblXMLAnswer.Caption := 'MISMO 2.41';
    cMISMO26:  lblXMLAnswer.Caption := 'MISMO 2.6';
    cMISMO26GSE: lblXMLAnswer.Caption := 'MISMO 2.6 GSE';
  else
    lblXMLAnswer.Caption := 'N/A';
  end;
  //GetAppraisalUADInfo(FDoc, UADOn, MayNeedXML, XMLVers);

  //PackageData.IsUAD := UADOn;              //UAD On & require XML26_GSE

  //Is this one of the other 4 forms that need MISMO26
  //the user will select the option to create XML
  {if (not UADOn) and MayNeedXML then
    PackageData.FXMLVersion := XMLVers;    //this is the XML type we will create    }

end;

procedure TAMC_Selection.LoadAMCDisplayList;
var
  i: integer;
  AnAMC: TAMC_UID;
begin
  FAMCList := GetAMCList;   //call Workflow Mgr to get list of AMCs

  if assigned(FAMCList) then
    for i := 0 to FAMCList.count-1 do
      begin
        AnAMC := AMC[i];
        AMCClientList.Items.Add(AnAMC.FName);
        AMCClientList.ItemEnabled[i] := AnAMC.FActive;
      end;
end;

function TAMC_Selection.GetAMC(Index: Integer): TAMC_UID;
begin
  result := TAMC_UID(FAMCList.Items[Index]);
end;

procedure TAMC_Selection.AMCClientListClick(Sender: TObject);
var
  Index: Integer;
begin
  index := AMCClientList.ItemIndex;

  if (FLastChecked > -1) and (index <> FLastChecked) then
    AMCClientList.ItemChecked[FLastChecked] := False;   //uncheck last one
  FLastChecked := Index;     //remember so we can uncheck last one

  rdoUploadToAMC.checked := True;
end;

procedure TAMC_Selection.rdoUploadToAMCClick(Sender: TObject);
begin
//  PackageData.DeliveryType := adUploadPack;
end;

procedure TAMC_Selection.rdoSaveToDesktopClick(Sender: TObject);
begin
  AMCClientList.UncheckAll;
  if (FLastChecked > -1) then
    begin
      AMCClientList.Selected[FLastChecked] := False;
      FLastChecked := -1;
    end;
end;

procedure TAMC_Selection.rdoEmailClick(Sender: TObject);
begin
  AMCClientList.UncheckAll;
  if (FLastChecked > -1) then
    begin
      AMCClientList.Selected[FLastChecked] := False;
      FLastChecked := -1;
    end;
end;

procedure TAMC_Selection.SetReportInfo;
var
  fName: String;
 // IsUAD: Boolean;
  frm, nForms: Integer;
  xmlVers: Integer;
  frmID: Integer;
//  AMCIdx: Integer;
begin

  if assigned(FDoc) then
    begin
      if FDoc.UADEnabled and uadFormSelected then
        PackageData.IsUAD := True
      else
        PackageData.IsUAD := false;
     // if GetAppraisalUADInfo2(FDoc, fName, fXML, IsUAD, AMCIdx) then
    //  begin
    //github 313: Delivery Method noted information for Apprasial Primary Form, UAD Formatted, MISMO XML Version
      //GetAppraisalUADInfo2(FDoc, fName, fXML, IsUAD, AMCIdx);

     //set AppraisalFormType for GSE reports
     fName := '';
     if PackageData.IsUAD then
      for frm := 0 to FDoc.docForm.Count - 1 do
        case FDoc.docForm[frm].FormID of
          340,4218,4365: fName := 'FNM 1004';
          345: fName := 'FNM 1073';
          347: fName := 'FNM 1075';
          355: fName := 'FNM 2055';
         end;
      PackageData.FMainFormName := fName;
      
     //Set XML Version  It may be changed on user choise in UAMC_PackageDef
     xmlVers := cNoXML;
     if PackageData.IsUAD then
      xmlVers := cMISMO26GSE
     else
      begin
        nForms := FDoc.docForm.Count;
        for frm := 0 to nForms - 1 do
          if PackageData.FFormList[frm] then
            begin
              frmID := FDoc.docForm[frm].FormID;
              case frmID of
                4140: xmlVers := cMISMO241;   //Clear Capital
                340, 342, 344, 345, 347, 349,  // the other form may be need MISMO XML
                351, 353, 355, 357,360, 4218, 4365: xmlVers := cMISMO26;
              end;
              if xmlVers > cNoXML then
                break;
            end;
        end;
      PackageData.XMLVersion := xmlVers;
      PackageData.SetSubjectAddress(FDoc);     //get the address
      PackageData.CheckForImages(FDoc);        //have images? skip if none
      {lblPriFormAnswer.caption := fName;
      lblXMLAnswer.Caption := fXML;
        if IsUAD then
          lblUADAnswer.Caption := 'Yes'
        else
          lblUADAnswer.Caption := 'No';
      if (AMCIdx > -1) and (AMCIdx < AMCClientList.Count) then
        begin
          rdoUploadToAMC.Checked := True;
          AMCClientList.ItemChecked[AMCIdx] := True;
          FLastChecked := AMCIdx;
        end;    }
 end;
end;

procedure TAMC_Selection.DoProcessData;
const
  rspPurchase = 6;
  Warning_Purchase = 'The service that you request is not available.  '+
                     'Please call your sales representative or visit the AppraisalWorld store to purchase';
var
  rsp: Integer;
  skipErrorPopup:Boolean;
begin
  skipErrorPopup := False;  //this is default behavior
  inherited;

  PackageData.AutoAdvance := cbxAutoAdvance.checked;     //do we auto advance?
  PackageData.FDisplayPDF := cbxDisplayPDF.Checked;      //do we display PDF
  PackageData.FProtectPDF := cbxProtectPDF.Checked;      //do we protect PDF

  //remember for next time
  appPref_AMCDelivery_AutoAdvance := cbxAutoAdvance.checked;     //do we auto advance?
  appPref_AMCDelivery_DisplayPDF  := cbxDisplayPDF.Checked;      //do we display PDF
  appPref_AMCDelivery_ProtectPDF  := cbxProtectPDF.Checked;      //do we protect PDF
  appPref_AMCDelivery_SkipImageOpt := not cbxRunImageOpt.Checked;   //do we skip image optimization
  appPref_AMCDelivery_EOWarnings := cbxShowEOWarnings.Checked;   //do we display E&O warnings
//GH#: 1136  appPref_AMCDelivery_SkipPDSReview := not cbxRunPDSReview.Checked;   //do we skip Platinum reviews
  appPref_AMCDelivery_UADConsistency := cbxUADConsistency.Checked;   //do we prompt UAD Consistency

  //set delivery type
  if rdoSaveToDesktop.checked then
    PackageData.DeliveryType := adSavePack
  else if rdoEmail.checked then
    PackageData.DeliveryType := adEmailPack
  else if rdoUploadToAMC.checked then
    PackageData.DeliveryType := adUploadPack;

  //ok to proceed is the default
  PackageData.FGoToNextOk := True;

  //set AMC identifier
  PackageData.AMCIdentifier := -1;
  if PackageData.DeliveryType = adUploadPack then
    begin
      if FLastChecked > -1 then
        begin
          PackageData.AMCIdentifier := AMC[FLastChecked].FUID;
          if PackageData.AMCIdentifier = AMC_FNC then
            begin
              if not CanUseService(skipErrorPopup) then
                begin
                  if not skipErrorPopup then
                    begin
                      rsp := WhichOption12('Purchase', 'Cancel',Warning_Purchase);
                      if rsp = rspPurchase then
                        HelpCmdHandler(cmdHelpAWShop4Service, CurrentUser.AWUserInfo.AWIdentifier, CurrentUser.AWUserInfo.UserLoginEmail);
                    end;
                end;
            end;
        end;
    end;
end;

function TAMC_Selection.ProcessedOK: Boolean;
begin
  //set packageData for AMC with fixed Package Data
  //for them workflow skipped Package Definition frame
  //so we have to set PackageData here
  case PackageData.AMCIdentifier of
    AMC_EadPortal:
      begin
        //if PackageData.FNeedsXML then       EAD need XML uad or not uad
          if PackageData.IsUAD then
            PackageData.DataFiles.InitDataFile(FTypXML26GSE)
          else
            PackageData.DataFiles.InitDataFile(FTypXML26);
        PackageData.DataFiles.InitDataFile(fTypPDF);
        PackageData.FGoToNextOk := PackageData.FGoToNextOk and isDocSigned;
      end;
  end;
  result := IsDocSaved and IsDocSigned and PackageData.FGoToNextOk;
  //result := IsDocSaved and PackageData.FGoToNextOk;
end;

function TAMC_Selection.IsDocSaved: Boolean;
begin
  result := False;
  if assigned(FDoc) then
    begin
      FDoc.CommitEdits;             //save the edits
      if FDoc.docIsNew then
        begin
          if WarnOK2Continue('You need to save the report before proceeding. Would you like to do it now?') then
            FDoc.Save;
        end
      else
        FDoc.Save;

      result := not FDoc.docIsNew;
    end;
end;


function TAMC_Selection.IsDocSigned: Boolean;
const
  CID_APPRAISER_NAME = 7;      //cell id for appraiser
  CID_SUPV_NAME      = 22;     //cell ID for supervisory appraiser name
var
  signList: TStringList;
  userName: String;
begin
  result := False;
  if assigned(FDoc) then
    if (PackageData.AMCIdentifier = AMC_EADPortal) and       //for FHA/EAD the report has to be signed
      not ((FDoc.docSignatures.SignatureIndexOf('Appraiser') > -1) or
                  (FDoc.docSignatures.SignatureIndexOf('Reviewer') > -1)) and
      not ((FDoc.docSignatures.SignatureIndexOf('Supervisor') > -1) or
                    (FDoc.docSignatures.SignatureIndexOf('Reviewer2') > -1)) then
    begin
      userName := Trim(FDoc.GetCellTextByID(CID_APPRAISER_NAME));
      ShowAlert(atStopAlert, userName + ' needs to graphically sign the report before proceeding.');
      exit;
    end
    else
    begin
      signList := Fdoc.GetSignatureTypes;
      if assigned(signList) then        //the report needs signatures
        begin
          //check for appraiser signature
          if not ((FDoc.docSignatures.SignatureIndexOf('Appraiser') > -1) or
                  (FDoc.docSignatures.SignatureIndexOf('Reviewer') > -1)) then
            begin
              userName := Trim(FDoc.GetCellTextByID(CID_APPRAISER_NAME));
              if WarnOK2Continue(userName + ' needs to graphically sign the report before proceeding. Would you like to do it now?') then
                begin
                  SignDocWithStamp(FDoc);
                  exit;
                end;
            end;

          //check for supervisor name & signature
          if length(Trim(FDoc.GetCellTextByID(CID_SUPV_NAME))) > 0 then    //there is a supervisor name
            if not ((FDoc.docSignatures.SignatureIndexOf('Supervisor') > -1) or
                    (FDoc.docSignatures.SignatureIndexOf('Reviewer2') > -1)) then
              begin
                userName := Trim(FDoc.GetCellTextByID(CID_SUPV_NAME));
                if WarnOK2Continue(userName + ' needs to graphically sign the report before proceeding.  Would you like to do it now?') then
                  begin
                    SignDocWithStamp(FDoc);
                    exit;
                  end;
              end;

          result := True;  //signatures are affixed
        end
      else
        result := True;   //no forms to sign
    end;
end;


function TAMC_Selection.CanUseService(var skipErrorPopup:Boolean): Boolean;
var
  VendorTokenKey:String;
begin
  PackageData.FGoToNextOk := False;
  PackageData.FHardStop := True;
  result := CurrentUser.OK2UseCustDBOrAWProduct(pidAppraisalPort, TestVersion);// or CurrentUser.OK2UseCustDBOrAWProduct(pidAppWorldConnection, TestVersion);
  if not result then
    begin
      skipErrorPopup := True;  //CRM call already handle the error popup
      try
        result := GetCRM_PersmissionOnly(CRM_AppraisalPortProdUID,CRM_AppraisalPort_ServiceMethod,CurrentUser.AWUserInfo,False,VendorTokenKey);
      except on E:Exception do
        begin
         // ShowAlert(atWarnAlert,msgServiceNotAvaible);
          skipErrorPopup := True;
          result := False;
          exit;
        end;
      end;
    end;
  if result then
    begin
      PackageData.FGoToNextOk := True;
      PackageData.FHardStop := False;
      PackageData.FAlertMsg := '';
    end;

  PackageData.FNeedENV := result;
end;

function TAMC_Selection.uadFormSelected: Boolean;
var
  frm, nForms: Integer;
  frmID: Integer;
begin
  result := false;
  nForms := FDoc.docForm.Count;
  for frm := 0 to nForms -1 do
    begin
      frmID := FDoc.docForm[frm].FormID;
      if PackageData.FFormList[frm] and IsUADMasterForm(frmID) then
      begin
        result := true;
        break;
      end;
    end;
end;

end.
