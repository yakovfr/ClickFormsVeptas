unit UMobile_Inspection;


{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted 2006-2018 by Bradford Technologies, Inc. }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UContainer, ComCtrls, StdCtrls, ExtCtrls,
  Grids_ts, TSGrid, osAdvDbGrid, Mask, RzEdit, IdHTTP, IdContext, IdMultipartFormData,
  IdSSLOpenSSL, UBase64, xmldom, XMLIntf, UForms, AWSI_Server_Access,UGlobals,
  msxmldom, XMLDoc,Jpeg, UForm, {UCC_Globals,}  uCell,
  UStatus,UWindowsInfo,UCC_Progress, cGAgisBingGeo, OleCtrls, SHDocVw, uGridMgr,
  uBase, uLicUser,
  uMain,
  uLKJSON, uUADObject,uEditor,
  UUtil1, UMobile_DataService,UMobile_Utils,
  CheckLst,Contnrs, RzTabs, Buttons, ImgList, Menus, uDrag, VrControls, uGraphics,
  VrLeds, DB, DBClient, TSImageList, Grids, DBGrids, uWebConfig,UCellMetaData,
  RzButton, RzPanel, UMobile_InspectionDetail;

type


  TPhoto = Class(TObject)    //checked
  private
    FImage: TJPEGImage;
    FType: Integer;         //PhotoTypes: front, rear, street, etc
    FCaption: String;
    FSource: String;
    FDate: String;
  public

    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPhoto);
    property Image: TJPEGImage read FImage write FImage;
    property PhotoType: Integer read FType write FType;
    property PhotoCaption: String read FCaption write FCaption;
    property PhotoSource: String read FSource write FSource;
    property PhotoDate: String read FDate write FDate;
  end;

  TCC_Mobile_Inspection = class(TAdvancedForm)
    PageControl: TRzPageControl;
    TabJson: TRzTabSheet;
    Panel2: TPanel;
    btnSaveToFile: TBitBtn;
    JsonTree: TTreeView;
    tabCompleted: TRzTabSheet;
    JsonMemo: TMemo;
    btnPrint: TButton;
    lblInsp_ID: TLabel;
    TabNewInspection: TRzTabSheet;
    Panel6: TPanel;
    lblSubject: TLabel;
    SubFullAddress: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    edtScheduleDate: TRzDateTimeEdit;
    Label16: TLabel;
    edtScheduleTime: TEdit;
    Label6: TLabel;
    cbPropertyType: TComboBox;
    Label1: TLabel;
    cbJobType: TComboBox;
    Label4: TLabel;
    edtAppraisalFileNo: TEdit;
    chkFHA: TCheckBox;
    CompGrid: TosAdvDbGrid;
    btnUploadInsp: TButton;
    Label8: TLabel;
    Label7: TLabel;
    Label17: TLabel;
    edtPRIName: TEdit;
    Label9: TLabel;
    edtPRIHome: TEdit;
    Label10: TLabel;
    edtPRIMobile: TEdit;
    Label12: TLabel;
    edtPRIWork: TEdit;
    rdoPBorrower: TRadioButton;
    rdoPOwner: TRadioButton;
    rdoPOccupant: TRadioButton;
    rdoPAgent: TRadioButton;
    rdoPOther: TRadioButton;
    edtPRIOther: TEdit;
    InstructionMemo: TMemo;
    btnClose: TButton;
    Panel1: TPanel;
    Label19: TLabel;
    rdoAOwner: TRadioButton;
    rdoAOccupant: TRadioButton;
    rdoABorrower: TRadioButton;
    rdoAAgent: TRadioButton;
    rdoAOther: TRadioButton;
    edtALTOther: TEdit;
    Label5: TLabel;
    Label14: TLabel;
    edtAltName: TEdit;
    Label11: TLabel;
    edtALTHome: TEdit;
    Label20: TLabel;
    edtALTMobile: TEdit;
    Label21: TLabel;
    edtALTWork: TEdit;
    SummaryGrid: TosAdvDbGrid;
    Statusbar: TStatusBar;
    lblAssignedTo: TLabel;
    cbAssignedTo: TComboBox;
    Panel4: TPanel;
    Label3: TLabel;
    chkReadyForImport: TCheckBox;
    btnOpen: TButton;
    btnDelete: TButton;
    btnRefresh: TBitBtn;
    chkImported: TCheckBox;
    btnClose2: TButton;
    chkShowPending: TCheckBox;
    lblFilterBy: TLabel;
    cbFilterBy: TComboBox;
    chkProgress: TCheckBox;
    chkPartialCompleted: TCheckBox;
    edtFilterDate: TRzDateTimeEdit;
    Label2: TLabel;
    Label18: TLabel;
    procedure btnOpenClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnUploadInspClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure CompGridClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SummaryGridDblClickCell(Sender: TObject; DataCol,
      DataRow: Integer; Pos: TtsClickPosition);
    procedure btnImageSummaryClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure SummaryGridClickCell(Sender: TObject; DataColDown,
      DataRowDown, DataColUp, DataRowUp: Integer; DownPos,
      UpPos: TtsClickPosition);
    procedure PrimatyContactClick(Sender: TObject);
    procedure AlternateContactClick(Sender: TObject);
    procedure ShowInspectionCheckBoxClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnReassignedClick(Sender: TObject);
    procedure cbAssignedToCloseUp(Sender: TObject);
    procedure SummaryGridComboRollUp(Sender: TObject; Combo: TtsComboGrid;
      DataCol, DataRow: Integer);
    procedure SummaryGridCellChanged(Sender: TObject; OldCol, NewCol,
      OldRow, NewRow: Integer);
    procedure SummaryGridCellEdit(Sender: TObject; DataCol,
      DataRow: Integer; ByUser: Boolean);
    procedure SummaryGridComboGetValue(Sender: TObject;
      Combo: TtsComboGrid; GridDataCol, GridDataRow, ComboDataRow: Integer;
      var Value: Variant);
    procedure cbAssignedToExit(Sender: TObject);
    procedure cbFilterByExit(Sender: TObject);
    procedure cbFilterByCloseUp(Sender: TObject);

  private
    FDoc: TContainer;
    FUserID: String;
    FUserPSW: String;
    FAppraiserID: String;
    FDocCompTable : TCompMgr2;
    FDocListTable : TCompMgr2;
    FSubjCol: TCompColumn;
    FUploadInfo: TUploadInfo;
    FUploadInfo2: TUploadInfo2;
    FSubjectData: TSubjectInspectData;
    FSubjectData2: TSubjectInspectData2;
    FUADObject: TUADObject;
    FInspectionData: String;
    FPhotoList: TObjectList;

    FjInspectionObject: TlkJSONObject;
    FjSubjectObj: TlkJSONObject;
    FjCompObj: TlkJSONObject;
    FjPostedData: TlkJSONObject;

    FInspectionDetail:TInspectionDetail;
    FOverwriteData: Boolean;  //github 583
    IALVersionID: String; //github 617

    FTeamMember: TeamMemberRec;
    FAssigned_ID: Integer;
    FAssigned_Name: String;
    FIsAdmin: Boolean;
    FDoSetPrefrences: Boolean;

    procedure SetupConfiguration;
    procedure LoadSubjectAddress;
    procedure LoadCompsAddress;

    function UploadInspectionData2(doc:TContainer):Boolean;
    function CollectSubjectData2:TSubjectInspectData2;
    procedure LoadInspectionData(InspectionData:String);
    procedure DoUploadSubjectDataJson(var jsSubject:TlkJSONObject);
    procedure DoUploadSummaryDataJson(var jsSummary:TlkJSONObject);
    procedure LoadDataToSummaryGrid(aUploadInfo:TUploadInfo2);
    function GetInspectionSummary:Boolean;
    function GetSummarySelectedRow: Integer;
    procedure AddImageTojPhoto(aImageType: Integer;ImageData: String; var jPhoto: TlkJsonObject);
    procedure LoadDataToCompGrid(row: Integer; CompColumn:TCompColumn; aCompType:String);
    function VerifyInfoOK:Integer;
    procedure DoUploadSubjectDataJson_V2(var jsSubject:TlkJSONObject);
    procedure DoUploadCompsDataJSon_V2(var jsComps: TlkJSONList);
    procedure ShowPhotoManager;
    procedure SetCellTextByCellID(cellID:Integer; aText: String; skipMath:Boolean=False);
//    procedure CheckAvailableLatestVersions;    //Not used any more
    function CheckLatestVersions(aURL:String):String;
//    function GetIALVersion:String;
    procedure WriteToIniFile;
    procedure LoadFromIniFile;
    procedure DoTeamAdminSetup;
    function LoadTeamMembers(ResponseData:String):Boolean;
    procedure InitGridCombo;
    function GetAssignedIDByName(AssignedName:String):Integer;
    procedure ReassignedOrder(DataRow:Integer);


  public
    FVersionNumber: Integer;
//    FDebugLog: TStringList;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property UserID: String read FUserID write FUserID;
    property UserPSW: String read FUserPSW write FUserPSW;
    property doc: TContainer read FDoc write FDoc;
    property OverwriteData: Boolean read FOverwriteData write FOverwriteData;  //github 583
  end;



  procedure CC_ShowInspectionManager(doc: TContainer);


implementation

{$R *.dfm}

uses
  Math, uUtil2, UAWSI_Utils, DateUtils,IniFiles, uPaths, uUtil3, ShellAPI,
  UImageView, Printers, osSortLib, uStrings, UUADUtils,UWebUtils, WinHttp_TLB,USysInfo;


  procedure ShowMobileInspectionManager(doc: TContainer; userID, userPSW, InspectOrderID: String);   forward;


procedure CC_ShowInspectionManager(doc: TContainer);
var
  userID, userPSW, InspectOrderID: String;
begin
    try  //now based on report type and inspection company, display the correct user interface
       ShowMobileInspectionManager(doc, userID, userPSW, InspectOrderID);
    except
      ShowAlert(atWarnAlert,'Problems were encountered retrieving the property inspections.');
    end
end;



function FindFormByName(const AName: string): TAdvancedForm;
var
  i: Integer;
begin
  for i := 0 to Screen.FormCount - 1 do
  begin
    Result := TAdvancedForm(Screen.Forms[i]);
    if (Result.Name = AName) then
      Exit;
  end;
  Result := nil;
end;



procedure ShowMobileInspectionManager(doc: TContainer; userID, userPSW, InspectOrderID: String);
var
  MobileInspector: TCC_Mobile_Inspection;
  aForm: TAdvancedForm;
begin
    aForm := FindFormByName('CC_Mobile_Inspection');
    if TCC_Mobile_Inspection(aForm) <> nil then
    begin
//      TCC_Mobile_Inspection(aForm) := nil;
      FreeAndNIl(aForm);
    end;
    MobileInspector := TCC_Mobile_Inspection.Create(doc);
    MobileInspector.UserID  := userID;
    MobileInspector.UserPSW := userPSW;
    if assigned(doc) then
      MobileInspector.FDoc    := doc;
    try
      MobileInspector.Show;
    finally //do not free here, will free in form close
    end;
end;

{TPhoto}
constructor TPhoto.Create;
begin
  inherited Create;

  FType     := phUnknown;  //initial state - a real photo should never be phUnknown
  FCaption  := '';
  FSource   := '';
  FDate     := '';
  FImage    := nil;
end;

destructor TPhoto.Destroy;
begin
  if assigned(FImage) then
    FImage.Free;
  inherited;
end;

procedure TPhoto.Assign(Source: TPhoto);
var
  imgStream: TMemoryStream;
begin
  if assigned(source) then
    begin
      FType     := Source.FType;
      FCaption  := Source.FCaption;
      FSource   := Source.FSource;
      FDate     := Source.FDate;

      if assigned(Source.FImage) then     //if source has jpeg object
        if not source.FImage.Empty then   //if jpeg has image
          begin
            if not assigned(FImage) then
              FImage := TJPEGImage.Create;    //make sure we can receive it

            imgStream := TMemoryStream.Create;
            try
              Source.FImage.SaveToStream(imgStream);  //save it to a stream
              imgStream.Position := 0;                //rewind imgStream position
              FImage.LoadFromStream(imgStream);       //read the image
            finally
              imgStream.free;
            end;
          end;
    end;
end;




{ TCC_Mobile_Inspection }

constructor TCC_Mobile_Inspection.Create(AOwner: TComponent);
begin
try
  SettingsName := CFormSettings_InspectionMain;
  FUserID      := CurrentUser.AWUserInfo.UserLoginEmail;
  FUserPsw     := CurrentUser.AWUserInfo.UserPassWord;
  FDoc := TContainer(AOwner);
  if not assigned(FDoc) then   //if no container, create a new container with 1004 form inserted
    begin
      FDoc := Main.NewEmptyContainer;
    end;

  FDocCompTable := TCompMgr2.Create(True);
  if assigned(FDocCompTable) and (FDoc.FormCount > 0) then
    FDocCompTable.BuildGrid(FDoc, gtSales);

  FDocListTable := TCompMgr2.Create(True);
  if assigned(FDocListTable) and (FDoc.FormCount > 0) then
    FDocListTable.BuildGrid(FDoc, gtListing);

  FUADObject := TUADObject.Create(FDoc);
  if Assigned(FDocCompTable) and (FDocCompTable.Count > 0) then
    FSubjCol := FDocCompTable.Comp[0]    //subject column
  else if Assigned(FDocListTable) and (FDocListTable.Count > 0) then
    FSubjCol := FDocListTable.Comp[0];

  FPhotoList := TObjectList.Create;

  FTeamMemberList := TStringList.Create;
  FTeamMemberList.Clear;

  FTeamNameList := TStringList.Create;
  FTeamNameList.Clear;

//  FDebugLog := TStringList.Create;
//  FDebugLog.Clear;

  

  inherited;

  if assigned(AOwner) then
    begin
      FDoc := TContainer(AOwner);
    end;

    PageControl.ActivePage := tabNewInspection;
    btnOpen.Enabled   := False;
    btnDelete.Enabled := False;
//    btnReassigned.Enabled := False;
except on E:Exception do
end;
end;

destructor TCC_Mobile_Inspection.Destroy;
var
  i: Integer;
  aObj: TObject;
begin

  if assigned(FDocCompTable) then
    FreeAndNil(FDocCompTable);

  if assigned(FDocListTable) then
    FreeAndNil(FDocListTable);

  if assigned(FUADObject) then
    FreeAndNil(FUADObject);

  if assigned(FPhotoList) then
    begin
      if FPhotoList.Count > 0 then
        for i:= 0 to FPhotoList.count - 1 do
          begin
            aObj := FPhotoList.Items[i];
            if assigned(aObj) then
              TObject(aObj) := nil;
          end;
      if assigned(FPhotoList) then
        TObjectList(FPhotoList) := nil;
    end;

  if assigned(FjInspectionObject) then
    FreeAndNil(FjInspectionObject);

  if assigned(FjSubjectObj) then
    FreeAndNil(FjSubjectObj);

  if assigned(FjCompObj) then
    FreeAndNil(FjCompObj);

  if assigned(FjPostedData) then
    FreeAndNil(FjPostedData);

  if assigned(myLog) then
    FreeAndNil(myLog);

  if assigned(FTeamMemberList) then
    FreeAndNil(FTeamMemberList);

  if assigned(FTeamNamelist) then
    FreeAndNil(FTeamNameList);

//  if assigned(FDebugLog) Then
//    FreeAndNil(FDebugLog);  

  inherited Destroy;
end;



procedure TCC_Mobile_Inspection.SetupConfiguration;
var
  aMsg: String;
begin
//  aMsg := Format('*** Inside SetupConfiguration: %s',[FormatdateTime('mm/dd/yyyy hh:mm:ss',now)]);
//  FDebugLog.Add(aMsg);
  FVersionNumber := JSON_VERSION_NO;
//  tabPhotoManager.TabVisible := False;
  tabJSon.TabVisible         := False;
  tabCompleted.tabVisible    := IsAWMemberActive;

  FInspectionDebugPath := IncludeTrailingPathDelimiter(appPref_DirInspection+'\Debug');
  ForceDirectories(FInspectionDebugPath);
//no default value
//  edtScheduleDate.Text := DateToStr(date);
//  edtScheduleTime.Text := FormatDateTime('hh:mm',now);
  edtAppraisalFileNo.Text := FDoc.GetCellTextByID(2);
  cbJobType.Text := GetJobTypeByFormID(FDoc);
  chkFHA.Checked := pos('FHA', UpperCase(FDoc.GetCellTextByID(3))) > 0;
  cbPropertyType.Text := GetPropertyTypeByFormID(FDoc);
  edtPRIOther.Visible := rdoPOther.checked;
  edtALTOther.Visible := rdoAOther.Checked;
//  aMsg := Format('BEFORE calling LoadFromIniFile: %s',[FormatdateTime('mm/dd/yyyy hh:mm:ss',now)]);
//  FDebugLog.Add(aMsg);
  LoadFromIniFile;
//  aMsg := Format('AFTER calling LoadFromIniFile: %s',[FormatdateTime('mm/dd/yyyy hh:mm:ss',now)]);
//  FDebugLog.Add(aMsg);

  //Set active tab
  if assigned(FDoc) and (FDoc.GetCellTextByID(46) = '') and (IsAWMemberActive) then
    begin
      PageControl.TabIndex := 1;
      btnUploadInsp.Enabled := False;
      //btnOpen.Enabled := True;
    end
  else  //data needs to be sent to mobile inspection app
    begin
      PageControl.TabIndex := 0;
      btnUploadInsp.Enabled := IsAWMemberActive;
      //btnOpen.Enabled := False;
    end;
  try
    PushMouseCursor(crHourglass);
    try
      LoadSubjectAddress;
      LoadCompsAddress;
//github #604:
      if chkReadyForImport.Checked then
        begin
        end;
      SummaryGrid.SelectionOptions.SelectionColor     := colorLiteBlue3;
      Compgrid.SelectionOptions.SelectionColor   := colorLiteBlue3;

      //Initialize to hide assignedto first
      DoTeamAdminSetup;
    except //on E:Exception do
           //if something goes wrong, keep continue
    end;
  finally
    PopMouseCursor;
  end;
end;

procedure TCC_Mobile_Inspection.DoTeamAdminSetup;
begin
  lblAssignedTo.Visible := FUploadInfo2.IsAdmin;
  cbAssignedTo.Visible  := FUploadInfo2.IsAdmin;
//  lblFilterBy.Visible   := FUploadInfo2.IsAdmin;
//  cbFilterBy.Visible    := FUploadInfo2.IsAdmin;
end;

function TCC_Mobile_Inspection.LoadTeamMembers(ResponseData:String):Boolean;
var
  jsdata: TlkJSONBase;
  jo : TlkJSONObject;
  i: Integer;
  tempFile: String;
begin
  result := False;
  jo := TlkJSON.ParseText(ResponseData) as TlkJSONObject;
  jsdata :=TlkJsonObject(jo).Field['data'];
  if jsdata = nil then exit;
  try
    FUploadInfo2.IsAdmin := False;
    FTeamNameList.Clear;
    result := jsdata.count > 0;  //if count = 0 means not a team
    for i:= 1 to jsdata.count do
    begin
        jo := jsdata.Child[i-1] as TlkJSONObject;
        if jo = nil then continue;
        FTeamMember.Team_Name  := vartostr(jo.Field['team_name'].Value);
        FTeamMemberList.add('team_name='+FTeamMember.Team_Name);

        FTeamMember.Team_ID   := jo.Field['team_id'].Value;
        FTeamMemberList.add('team_id='+Format('%d',[FTeamMember.Team_ID]));

        FTeamMember.Company_Name := varToStr(jo.Field['company_name'].Value);
        FTeamMemberList.add('company_name='+FTeamMember.Company_Name);

        FTeamMember.Admin_ID := jo.Field['admin_id'].Value;
        FTeamMemberList.add(Format('%d',[FTeamMember.Admin_ID]));

        FTeamMember.Team_Member_Row_ID := jo.Field['team_member_row_id'].Value;
        FTeamMemberList.add('team_member_row_id='+Format('%d',[FTeamMember.Team_Member_Row_ID]));

        FTeamMember.Admin_Name := varToStr(jo.Field['admin_name'].Value);
        FTeamMemberList.add('admin_name='+FTeamMember.Admin_Name);

        FTeamMember.Team_Member_Name := varToStr(jo.Field['team_member_name'].Value);
        FTeamMemberList.add('team_member_name='+FTeamMember.Team_Member_Name);
        FTeamNameList.add(FTeamMember.Team_Member_Name);

        FTeamMember.Appraiser_ID     := jo.Field['appraiser_id'].Value;
        FTeamMemberList.add('appraiser_id='+Format('%d',[FTeamMember.Appraiser_ID]));

        if jo.Field['is_admin'] <> nil then    //we don't need to do this until Binh is done with her api and fields are all done
          begin
            FTeamMember.Is_Admin := jo.Field['is_admin'].Value = 1;
            FTeamMemberList.add('is_admin='+varToStr(jo.Field['is_admin'].Value));
          end;

        if jo.Field['email'] <> nil then
          begin
            FTeamMember.Email := varToStr(jo.Field['email'].Value);
            FTeamMemberList.add('email='+FTeamMember.Admin_Name);
          end;
        TempFile := FInspectionDebugPath + '\'+ 'TeamMemberList.txt';
        FTeamMemberList.SaveToFile(TempFile);
        if FTeamMember.Is_Admin and (CompareText(CurrentUser.AWUserInfo.UserLoginEmail,FTeamMember.Email) =0) then
          begin
            FUploadInfo2.IsAdmin := True;
            FUploadInfo2.Assigned_ID_Name := FTeamMember.Team_Member_Name;  //This buffer get overriden by the get summary
            FUploadInfo2.Assigned_ID      := FTeamMember.Appraiser_ID;
            FIsAdmin := True;
            FAssigned_Name := FTeamMember.Team_Member_Name;   //save to global var
            FAssigned_ID := FTeamMember.Appraiser_ID;    //save to global var
          end
        else if CompareText(CurrentUser.AWUserInfo.UserLoginEmail, FTeamMember.Email)  = 0 then //if the person creates the order and also a team member then assign to that person
           begin
             FUploadInfo2.Assigned_ID_Name := FTeamMember.Team_Member_Name;
             FUploadInfo2.Assigned_ID      := FTeamMember.Appraiser_ID;  //This buffer get overriden by the get summary
             FAssigned_Name := FTeamMember.Team_Member_Name;  //save to global var
             FAssigned_ID := FTeamMember.Appraiser_ID;     //save to global var
           end;
     end;
  finally
  end;
end;



procedure TCC_Mobile_Inspection.FormShow(Sender: TObject);
var
  ResponseData:String;
  aMsg:String;
begin
  try
    FUploadInfo2.IsAdmin := False; //reset it first;
    SetupConfiguration;
    if IsConnectedToWeb  then
      begin
        if GetTeamMembers(FUploadInfo2, ResponseData) then
          begin
            if LoadTeamMembers(ResponseData) then
              begin
                DoTeamAdminSetup;
                if FUploadInfo2.IsAdmin then
                  begin
                    cbAssignedTo.Items.Clear;
                    cbAssignedTo.Items.Text := FTeamNameList.Text;
                    cbAssignedTo.Text := FUploadInfo2.Assigned_ID_Name;
                    cbFilterBy.Items.Text   := FTeamNameList.Text;
                    cbFilterBy.Items.Add('All');
                    cbFilterBy.Text         := 'All';   //default to all
                  end
                else
                  cbFilterBy.Text := FUploadInfo2.Assigned_ID_Name;   //the assigned name combo box already had the team name in it
                self.width := width_TEAM;   //extend the form big enough to show the full grid
              end
            else
              begin //this is for independent NOT TEAM: we hide all the team settings.
                lblAssignedTo.Visible := False;
                cbAssignedTo.Visible := False;
                SummaryGrid.Col[sAssignedName].Width := 0;
                SummaryGrid.Col[sAssignedID].Width   := 0;
//                btnReassigned.Visible := False;
                self.width := width_NOTEAM; //keep as is
              end;
          end;
//          chkShowPending.Checked := FTeamNameList.Count > 0;  //use preference now
//          chkProgress.Checked    := FTeamNameList.Count > 0;
      end;
    if FDoc = nil then
      close;
  except on E:Exception do
  end;
  FInspectionDebugPath := IncludeTrailingPathDelimiter(appPref_DirInspection+'\Debug');
  ForceDirectories(FInspectionDebugPath);
  if PageControl.ActivePageIndex = 1 then
    btnRefresh.Click;
end;

(*
function TCC_Mobile_Inspection.GetIALVersion:String;
begin
  //For the time being, use the DataStructureVersionNumber (2 means app version = 1.2, 1 means app version = 1.1)
  //until we have a new key: App_Version_Number in the IAL json header.
  case FVersionNumber of
    0,1: result := '1.1';
    2, 3: result := IALVersionID; //github 617 use global variable value
    else result := '';
  end;
end;
*)

(* Not used any more --- Pam 12/27/2018
procedure TCC_Mobile_Inspection.CheckAvailableLatestVersions;
const
  CF_ProductVersion_URL = 'https://webservices.appraisalworld.com/ws/GetProductInfo/index.php/ClickFORMS';
  IAL_ProductVersion_URL = 'https://webservices.appraisalworld.com/ws/GetProductInfo/index.php/Inspect-a-lot';
var
  CFVersionInfo, IALVersionInfo: String;
  js, jsData: TlkJSONBase;
  CFVersionID: String; //github 617 change from local to global variable
  nVersionID: String;
  cVersionID: String;
  cMajor, cMinor: Integer;
  nMajor, nMinor: Integer;
  showWarning:Boolean;
  aMsg, aTemp: String;
begin
  try
    showWarning := False;
    CFVersionInfo := CheckLatestVersions(CF_ProductVersion_URL);
    IALVersionInfo := CheckLatestVersions(IAL_ProductVersion_URL);
    //Handle ClickFORMS version info
    js := TlkJSON.ParseText(CFVersionInfo) as TlkJSONobject;
    try
      if TlkJsonObject(js) = nil then exit;
        jsdata :=TlkJsonObject(js).Field['data']; //we are looking at the data section from the get detail
        if jsdata = nil then exit;
        nVersionID := vartostr(jsdata.Field['client_current_version'].Value);
        CFVersionID := nVersionID;
        cVersionID := SysInfo.UserAppVersion;
        //Get major/minor/build
        aTemp := nVersionID;
        nMajor := GetValidInteger(popStr(aTemp,'.'));
        nMinor := GetValidInteger(popStr(aTemp,'.'));

        aTemp := cVersionID;
        cMajor := GetValidInteger(popStr(aTemp,'.'));
        cMinor := GetValidInteger(popStr(aTemp,'.'));

        if cMajor < nMajor then
          showWarning := True
        else  //same major version, check for minor
          begin
             if cMinor < nMinor then
               showWarning := True
          end;

    if not showWarning then
      begin
        //Handle Inspect-a-Lot version info
        js := TlkJSON.ParseText(IALVersionInfo) as TlkJSONobject;
        jsdata :=TlkJsonObject(js).Field['data']; //we are looking at the data section from the get detail
        if jsdata = nil then exit;
        nVersionID := vartostr(jsdata.Field['client_current_version'].Value);
        //cVersionID := SysInfo.UserAppVersion;
        IALVersionID := nVersionID;
        cVersionID := GetIALVersion;
        //Get major/minor/build
        aTemp := nVersionID;
        nMajor := GetValidInteger(popStr(aTemp,'.'));
        nMinor := GetValidInteger(popStr(aTemp,'.'));
        if cVersionID <> '' then
          begin
            aTemp  := cVersionID;
            cMajor := GetValidInteger(popStr(aTemp,'.'));
            cMinor := GetValidInteger(popStr(aTemp,'.'));

            if cMajor < nMajor then
              showWarning := True
            else  //same major version, check for minor
              begin
                 if cMinor < nMinor then
                   showWarning := True
              end;
          end;
      end;

      //In the end, base on the showWarning boolean to show or not show
      if showWarning then
        begin
          aMsg := Format('Looks like you are not on the latest version of ClickFORMS (v%s) and/or Inspect-a-Lot mobile app ( v%s). Please update in order to fully enjoy new features and recent fixes.',
                  [CFVersionID, IALVersionID]);
          ShowNotice(aMsg);
        end;
    finally
     if assigned(js) then
       js.Free;
    end;
  except ; end;
end;
*)


function TCC_Mobile_Inspection.CheckLatestVersions(aURL:String):String;
const
  CTimeout = 60000;  // 60 seconds
  httpRespOK = 200;          //Status code from HTTP
var
  HTTPRequest: IWinHTTPRequest;
  responseTxt: String;
  codeValue: Integer;
  js, jsResultCode: TlkJSONBase;
begin
  result := '';
    try
    //getResponse
      httpRequest := CoWinHTTPRequest.Create;
      httpRequest.Open('GET',aURL,False);
      httpRequest.SetTimeouts(60000,60000,60000,60000);   //1 minute for everything
      httpRequest.Send('');
      if httpRequest.Status = httpRespOK then
        begin
         //parse response
         responseTxt := httpRequest.ResponseText;

          js := TlkJson.ParseText(responseTxt);
          if js = nil then
            exit;
          jsResultCode := TlkJsonObject(js).Field['code'];
          if jsResultCode is TlkJsonNull then
            exit;
          codeValue := round(int(TlkJsonObject(jsResultCode).Value));
          case codeValue of
            0: begin
                  result := responseTxt;
               end;
            150: begin //no orders, do nothing
                   exit;
                 end;
            else
              showAlert(atWarnAlert, varToStr(TlkJsonObject(js).Field['message'].Value));
              exit;
            end;
        end;
    finally
      FreeAndNil(httpRequest);
    end;
end;

procedure TCC_Mobile_Inspection.LoadSubjectAddress;
begin
  if assigned(FSubjCol) then
  subFullAddress.Caption := FSubjCol.GetCellTextByID(925);
end;



procedure TCC_Mobile_Inspection.LoadDataToCompGrid(row: Integer; CompColumn:TCompColumn; aCompType:String);
var
 UnitNumber, CityStZip, city, state, zip: String;
 str : String;
 fBath, hBath: String;
 aGeocodeCell: TGeocodedGridCell;
 garage, carport, driveway: String;
begin
      //auto select the first 3 comps
      Compgrid.Cell[_CmpNo,row]      := row;
      Compgrid.Cell[_Address,row]    := CompColumn.GetCellTextByID(925);
      CityStZip := CompColumn.GetCellTextByID(926);
      GetUnitCityStZip(CityStZip, UnitNumber, city, state, zip);  //github #662

      Compgrid.Cell[_UnitNo, row]    := UnitNumber;
      Compgrid.Cell[_City,row]       := City;
      Compgrid.Cell[_State,row]      := state;
      Compgrid.Cell[_Zip,row]        := zip;
      Compgrid.Cell[_TypeID,row]     := aCompType;
      Compgrid.Cell[_Location, row]  := CompColumn.GetCellTextByID(962);
      Compgrid.Cell[_SiteArea,row]   := CompColumn.GetCellTextByID(976);
      Compgrid.Cell[_View, row]      := CompColumn.GetCellTextByID(984);
      Compgrid.Cell[_Design, row]    := CompColumn.GetCellTextByID(986);
      CompGrid.Cell[_ActualAge, row] := CompColumn.GetCellTextByID(996);
      Compgrid.Cell[_Quality, row]   := CompColumn.GetCellTextByID(994);
      Compgrid.Cell[_Condition, row] := CompColumn.GetCellTextByID(998);
      Compgrid.Cell[_YearBuilt, row] := calcYearBuilt(CompColumn.GetCellTextByID(996));
      Compgrid.Cell[_GLA,row]        := CompColumn.GetCellTextByID(1004);
      Compgrid.Cell[_BsmtArea, row]  := CompColumn.GetCellTextByID(1006);
      Compgrid.Cell[_BsmtRooms, row] := CompColumn.GetCellTextByID(1008);

      str := CompColumn.GetCellTextByID(1016);
      if lowerCase(str) = 'none' then
        Compgrid.Cell[_none, row] := 1
      else
        begin
          GetGarageCarportDriveway(str, garage, carport, driveway);
          Compgrid.Cell[_Garage, row] := (garage <> '') and (lowercase(garage) <> 'none');
          Compgrid.Cell[_GarCar,row]  := garage;
          Compgrid.Cell[_Carport, row] := (carport <> '') and (lowercase(carport) <> 'none');
          Compgrid.Cell[_CarportCount,row]   := carport;
          Compgrid.Cell[_DrivewayCars, row]  := driveway;
        end;
      Compgrid.Cell[_Design, row]        := CompColumn.GetCellTextByID(986);
      Compgrid.Cell[_FirePlace,row]      := CompColumn.GetCellTextByID(1020);
      Compgrid.Cell[_Pool,row]           := CompColumn.GetCellTextByID(1022);
      Compgrid.Cell[_ABTotal,row]        := CompColumn.GetCellTextByID(1041);
      Compgrid.Cell[_ABBed,row]          := CompColumn.GetCellTextByID(1042);
      str := CompColumn.GetCellTextByID(1043);
      if pos('.', str) > 0 then
        begin
          fBath := popStr(str, '.');
          hBath := str;
          Compgrid.Cell[_ABBath,row] := fBath;
          Compgrid.Cell[_ABHalf,row] := hBath;
        end
      else
        begin
          Compgrid.Cell[_ABBath,row] := str;
        end;

     Compgrid.Cell[_Porch, row]      := CompColumn.GetCellTextByID(1018);
     Compgrid.Cell[_FunctionalUtil, row] := CompColumn.GetCellTextByID(1010);
     Compgrid.Cell[_Energy, row]     := CompColumn.GetCellTextByID(1014);
     Compgrid.Cell[_HeatCooling, row]:= CompColumn.GetCellTextByID(1012);

     Compgrid.Cell[_FunctionalAdjAmt, row] := CompColumn.GetCellTextByID(1011);
     Compgrid.Cell[_EnergyAdjAmt, row]   := CompColumn.GetCellTextByID(1015);
     Compgrid.Cell[_MiscAdjAmt1, row] := CompColumn.GetCellTextByID(1021);
     Compgrid.Cell[_MiscAdjAmt2, row] := CompColumn.GetCellTextByID(1023);
     Compgrid.Cell[_MiscItem3, row]   := CompColumn.GetCellTextByID(1032);
     Compgrid.Cell[_MiscAdjAmt3, row] := CompColumn.GetCellTextByID(927);
     Compgrid.Cell[_Comments, row]    := CompColumn.GetCellTextByID(2082);

     if (CompColumn.GetCellByID(CGeocodedGridCellID) is TGeocodedGridCell) then
       begin
         aGeocodeCell := CompColumn.GetCellByID(CGeocodedGridCellID) as TGeocodedGridCell;
         if assigned(aGeocodeCell) then
           begin
             if aGeocodeCell.Latitude <> 0 then   //github #1112 donot load in 0
             Compgrid.Cell[_Latitude,row]  := aGeocodeCell.Latitude;
             if aGeoCodeCell.Longitude <> 0 then
             Compgrid.Cell[_Longitude,row]  := aGeocodeCell.Longitude;
           end;
       end;
end;


procedure TCC_Mobile_Inspection.LoadCompsAddress;
var
 i, row, iCount: integer;
 CompColumn:TCompColumn;
begin
//  iCount := min(10, FDocCompTable.Count);
  iCount := FDocCompTable.Count;  //Ticket #1146: donot limit 10 comps
  row := 0;
  try
    for i := 1 to iCount -1  do  //exclude subject, go from 1 for comp 1
      begin
        CompColumn := FDocCOmpTable.Comp[i];
//ticket#1027:do not skip EMPTY for Sales
//if CompColumn.GetCellTextByID(925) <> '' then
          begin
            row := row + 1;
            Compgrid.Rows := row;          //allocate a new row
            Compgrid.Cell[_Select,row] := 1;
          end;
// //ticket#1027:do not skip EMPTY
//       else
//          Continue;

        LoadDataToCompGrid(row, CompColumn, t_Sale);
      end;
//  iCount := min(10, FDocListTable.Count);
  iCount := FDocListTable.Count; //Ticket #1146: Donot limit 10 listings
    for i := 1 to iCount -1  do  //exclude subject, go from 1 for comp 1
      begin
        CompColumn := FDocListTable.Comp[i];
////ticket#1027:do not skip EMPTY for Listings
//        if CompColumn.GetCellTextByID(925) <> '' then
          begin
            row := row + 1;
            Compgrid.Rows := row;          //allocate a new row
            Compgrid.Cell[_Select,row] := 1;
          end;
///ticket#1027:do not skip EMPTY
//        else
//          Continue;

        LoadDataToCompGrid(row, CompColumn, t_Listing);
      end;
  finally
  end;
end;




function TCC_Mobile_Inspection.GetSummarySelectedRow: Integer;
var
  row: Integer;
begin
  result := 0;
  for row := 1 to SummaryGrid.Rows do
    if SummaryGrid.cell[sSelect, row] = 1 then
      result := row;
end;

procedure TCC_Mobile_Inspection.btnOpenClick(Sender: TObject);
var
  row: Integer;
  aContinue:Boolean;
  aStatus: String;
  i, j:Integer;
  aOK: Boolean;
begin
  if assigned(FInspectionDetail) then
    FreeAndNil(FInspectionDetail);

  FOverwriteData := False;
  FDoc := TContainer(Main.ActiveContainer);
  //rebuild the Comp table for sales and listing in case we pick a new container
  if assigned(FDocCompTable) then
    FDocCompTable.BuildGrid(FDoc, gtSales);

  if assigned(FDocListTable) then
    FDocListTable.BuildGrid(FDoc, gtListing);

    j := 0;
    for i := 1 to SummaryGrid.Rows do
      begin
        if SummaryGrid.Cell[sSelect, i] = cbChecked then
          j := j + 1;
      end;
    if j = 0 then
      begin
        ShowAlert(atWarnAlert,'Please select the inspection to import into the report.');
        exit;
      end;
    if j > 1 then
      begin
        ShowAlert(atWarnAlert,'Only one inspection can be imported at a time');
        exit;
      end;
    try
      for i := 1 to SummaryGrid.Rows do
        begin
          if SummaryGrid.Cell[sSelect,i] = cbChecked then
            begin
              FUploadInfo2.insp_id  := SummaryGrid.Cell[sInsp_id,i];
              aStatus := UpperCase(SummaryGrid.Cell[sStatus,i]);
              if (pos('READY', aStatus) > 0) or (pos('IMPORT', aStatus) > 0) then  //this is a completed one
                begin
                  aContinue := True;
                  break;
                end
              else if (pos('PARTIAL', aStatus) > 0) then
                begin
                  aContinue := False;
                  if OK2Continue('The selected inspection has only been partially completed. Are you sure you want to import this data?') then  //Ticket #1456: give user a warning if partial
                    begin
                      aContinue := True;
                      break;
                    end;
                end
              else
                begin
                  aContinue := False;
                  ShowNotice('The selected inspection has not been completed yet!');
                  exit;
                end;
            end;
        end;
    finally
    end;
  if not aContinue then exit;

///    if not assigned(FDoc) or (assigned(FDoc) and (FDoc.docForm.Count = 0)) then  //GitHub #301 if there is no active container, create one and import + overwrite data
    if not assigned(FDoc) then  //GitHub #301 if there is no active container, create one and import + overwrite data
    begin
      TMain(Application.MainForm).FileNewDoc(nil);  //github 302: if no container, use the same logic like what we do for new report
      FDoc := TMain(Application.MainForm).ActiveContainer;
      FOverwriteData := True;  //github 209: always overwrite when we create a new report
    end
    else if (FDoc.GetCellTextByID(925) = '') and (FDoc.docForm.Count = 1) then
      FOverwriteData := True;  //github 209: always overwrite when we create a new report

  //Continue to import
  PushMouseCursor(crHourGlass);
  try
  if PageControl.ActivePage = tabCompleted then
    begin
      row := GetSummarySelectedRow;
      FUploadInfo2.insp_id := SummaryGrid.Cell[sInsp_id, row];

      FUploadInfo2.Status      := AbbreviateStatus(SummaryGrid.Cell[sStatus, row]);
      FUploadInfo2.StatusDateTime := SummaryGrid.Cell[sStatusDate, row];
      FUploadInfo2.Insp_Date   := SummaryGrid.Cell[sInspDate, row];
      FUploadInfo2.Insp_time   := SummaryGrid.Cell[sInspTime, row];
      FUploadInfo2.Insp_Type   := SummaryGrid.Cell[sInspType, row];
      FUploadInfo2.AppraiserID := SummaryGrid.Cell[sUserAWID, row];
      FUploadInfo2.Address     := SummaryGrid.Cell[sAddress, row];
      FUploadInfo2.City        := SummaryGrid.Cell[sCity, row];
      FUploadInfo2.State       := SummaryGrid.Cell[sState, row];
      FUploadInfo2.Zipcode     := SummaryGrid.Cell[sZip, row];
      FUploadInfo2.Version     := SummaryGrid.Cell[sVersion, row];
      FUploadInfo2.Assigned_ID_Name := SummaryGrid.Cell[sAssignedName, row];
      FUploadInfo2.Assigned_ID := SummaryGrid.Cell[sAssignedID, row];

      FSubjectData.Address    := FUploadInfo2.Address;
      FSubjectData.City       := FUploadInfo2.City;
      FSubjectData.State      := FUploadInfo2.State;
      FSubjectData.ZipCode    := FUploadInfo2.Zipcode;

      if GetInspectionDataByID(FUploadInfo2, FInspectionData) then
       begin
         aOK := FInspectionData <> '';
         ShowPhotoManager;
       end;
    end
  finally
    PopMouseCursor;
  end;
end;


procedure TCC_Mobile_Inspection.btnCloseClick(Sender: TObject);
begin
  Close;
end;


function TCC_Mobile_Inspection.VerifyInfoOK:Integer;
var
  aMsg: String;
begin
  result := 0;
  if (length(SubFullAddress.Caption) = 0) then
    begin
      aMsg := 'Your Subject property is EMPTY.  You cannot upload without a Subject property.';
      ShowAlert(atWarnAlert, aMsg);
      result := -1; //hard stop
      exit;
    end;
  if cbAssignedTo.Visible then //check to make sure assigned to is not empty
    begin
      if (length(cbAssignedTo.Text) = 0) then
        begin
          aMsg := 'Please select a Team Member from the Assign To List before uploading the inspection.';
          ShowAlert(atWarnAlert, aMsg);
          result := -1; //hard stop
          cbAssignedTo.SetFocus;
          exit;
        end;
    end;
  if (length(edtScheduleDate.text) = 0) or (length(edtScheduleTime.text) = 0) then
    begin
      aMsg := 'Your Inspection Date/Time is EMPTY.  Would you like to continue?';
      if OK2Continue(aMsg) then
        result := 1  //warning
      else
        result := -1;
      exit;
    end
end;

procedure TCC_Mobile_Inspection.btnUploadInspClick(Sender: TObject);
var
  ok2Go: Boolean;
  aMsg: String;
  aOKResult: Integer;
begin
  ok2Go := False;
  aOKResult := 0;
//  isAWMemberActive := GetAWIsMemberActive;
  if not IsAWMemberActive then
    begin
      aMsg := msgMobileInspectionMemberShipWarning;
      ShowAlert(atWarnAlert,aMsg);
      exit;
    end
  else
    begin
      aOKResult := VerifyInfoOK;
      case aOKResult of   //0 = no error, 1 = warn user and allow to continue, -1 = stop user to continue
        -1: ok2GO := False;
         0: ok2GO := True;  //need to pop up confirm message to continue
         1: ok2GO := True;  //ok to continue but no need to pop up confirm to continue
      end;
    end;
  if not OK2Go then exit;

  if aOKResult = 0 then
    begin
      aMsg := Format('Begin uploading inspection data for (%s) to Inspect-a-Lot mobile app?',[SubFullAddress.Caption]);
      ok2Go := OK2Continue(aMsg);
    end;

  if ok2go then
    begin
      FUploadInfo2.IsAdmin := FIsAdmin;      //Load it back to FUploadInfo2
      FUploadInfo2.Assigned_ID_Name := FAssigned_Name; //Load it back to FUploadInfo2
      FUploadInfo2.Assigned_ID  := FAssigned_ID; //Load it back to FUploadInfo2
      if UploadInspectionData2(Fdoc) then
        begin
          aMsg := Format('Your inspection data for (%s) has been uploaded successfully.',[SubFullAddress.Caption]);
          ShowNotice(aMsg);
          GetInspectionSummary;
        end;
    end;
end;


function TCC_Mobile_Inspection.CollectSubjectData2:TSubjectInspectData2;
var
  str, fBath, hBath, ViewFact1, ViewFact2, ViewOther, locFact1, locFact2, locOther: String;
  aGeocodeCell: TGeocodedGridCell;
  ba: String;
  ViewInfl, locInfl: Integer;
  garCount, aInt: Integer;
  ImprovementStr, KitchenRemodelNote, BathRemodelNote: String;
  aBsmtRooms: String;
  insp_date, insp_time: String;
  ImprovementOrg, aStructure, aDesign: String;
begin
  if not assigned(FSubjCol) then exit;

  //Load Assignment
  FSubjectData2.VersionNumber := JSON_VERSION_NO;
  FSubjectData2.AppraisalFileNumber  := edtAppraisalFileNo.Text;     //Default = '0'

  FSubjectData2.PropertyTYpe := cbPropertyType.Text;
  FSubjectData2.InspectionInstructions := InstructionMemo.Lines.Text;
  if edtScheduleDate.Text <> '' then
    try
      insp_date := FormatDateTime('mm/dd/yyyy',StrToDateTime(edtScheduleDate.Text));
    except on E:Exception do
      insp_date := '';
    end;
  if edtScheduleTime.Text <> '' then
    try
      insp_time := FormatDateTime('hh:mm ampm', StrToDateTime(edtScheduleTime.Text));
    except on E:Exception do
      insp_time := '';
    end;

  FSubjectData2.InspectionScheduleDate := insp_date;
  FSubjectData2.InspectionScheduleTime := insp_time;
  FUploadInfo2.Insp_date := insp_date;
  FUploadInfo2.Insp_time := insp_time;

  FSubjectData2.insp_type := cbJobType.Text;
  FSubjectData2.IsFHA   := chkFHA.Checked;

  FSubjectData2.Address := FDoc.GetCellTextByID(46);
  FSubjectData2.City    := FDoc.GetCellTextByID(47);
  FSubjectData2.State   := FDoc.GetCellTextByID(48);
  FSubjectData2.ZipCode := FDoc.GetCellTextByID(49);
  FSubjectData2.UnitNumber := FDoc.GetCellTextByID(2141);  //### for now
  FSubjectData2.Bedrooms := GetStrInt(FSubjCol.GetCellTextByID(1042));    //Ticket #1382, if empty set to -1

  FSubjectData2.SiteArea := FDoc.GetCellTextByID(67);
  str := FSubjCol.GetCellTextByID(1043);
  if pos('.', str) > 0 then
    begin
      fBath := popStr(str, '.');
      hBath := str;
      FSubjectData2.FullBaths := GetStrInt(fBath);  //Ticket #1382
      FSubjectData2.HalfBaths := GetStrInt(hBath);  //Ticket #1382
    end
  else
    begin
      FSubjectData2.FullBaths := GetStrInt(str);   //Ticket #1382
      FSubjectData2.HalfBaths := 0;
    end;
  FSubjectData2.GLA := FSubjCol.GetCellTextByID(1004);  //github #
  FSubjectData2.YearBuilt := GetStrInt(FDoc.GetCellTextByID(151));   //Ticket #1382

  //not for new order
  if (FSubjCol.GetCellByID(CGeocodedGridCellID) is TGeocodedGridCell) then
    begin
      aGeocodeCell := FSubjCol.GetCellByID(CGeocodedGridCellID) as TGeocodedGridCell;
      if assigned(aGeocodeCell) then
        begin
         FSubjectData2.Latitude   := aGeocodeCell.Latitude;
         FSubjectData2.Longitude  := aGeocodeCell.Longitude;
        end;
    end;

    //Add more fields to push to the mobile
    FSubjectData2.TotalRooms := GetStrInt(FSubjCol.GetCellTextByID(1041));   //Ticket #1382
    FSubjectData2.Design := FDoc.GetCellTextByID(149);
    if trim(FSubjectData2.Design) = '' then //Ticket # 1351: if no cell id 149, we should look up another grid cell 986 for design
      FSubjectData2.Design := FDoc.GetCellTextByID(986);
    //If we have ; we need to parse before load it
    if pos(';', FSubjectData2.Design) > 0 then  //Ticket #1351, we should not include structure tyle, # of stories in the design field
      popStr(FSubjectData2.Design, ';');
    FSubjectData2.Stories := GetStrDouble(FDoc.GetCellTextByID(148));
    FSubjectData2.ActualAge := FSubjCol.GetCellTextByID(996);
    FSubjectData2.EffectiveAge := FDoc.GetCellTextByID(499);

    FSubjectData2.Gps     := '';

    if FDoc.GetCellTextByID(2103) = 'X' then
      FSubjectData2.SubjectType := tSingleUnitwAccyUnit
    else if FDoc.GetCellTextByID(2069) = 'X' then
      FSubjectData2.SubjectType := tSingleUnit
    else
      FSubjectData2.SubjectType := -1;

    if FDoc.GetCellTextByID(157) = 'X' then
      FSubjectData2.StructureType := stDetach
    else if FDoc.GetCellTextByID(2102) = 'X' then
      FSubjectData2.StructureType := stEndUnit  //End unit
    else if FDoc.GetCellTextByID(2101) = 'X' then
      FSubjectData2.StructureType := stAttach
    else
      begin //Ticket #1351: Handle form 1073
        aDesign := trim(FDoc.GetCellTextByID(986));
        if pos(';', aDesign) > 0 then
          aStructure := popStr(aDesign, ';');
        if aStructure <> '' then
          begin
            if pos('DT', aStructure) > 0 then
              FSubjectData2.StructureType := stDetach
            else if pos('AT', aStructure) > 0 then
              FSubjectData2.StructureType := stAttach
            else if pos('SD', aStructure) > 0 then
              FSubjectData2.StructureType := stEndUnit
            else FSubjectData2.StructureType := -1;
          end
        else FSubjectData2.StructureType := -1;
      end;
    if FDoc.GetCellTextByID(160) = 'X' then
      FSubjectData2.ConstructionType := ctExisting
    else if FDoc.GetCellTextByID(159) = 'X' then
      FSubjectData2.ConstructionType := ctProposed
    else if FDoc.GetCellTextByID(161) = 'X' then
      FSubjectData2.ConstructionType := ctUnderCon
    else
      FSubjectData2.ConstructionType := -1;

    FSubjectData2.CarStorageNone := FDoc.GetCellTextByID(346) = 'X';

    FSubjectData2.Driveway := FDoc.GetCellTextByID(359) = 'X';
    FSubjectData2.DrivewayCars := GetStrInt(FDoc.GetCellTextByID(360));    //Ticket #1382
    FSubjectData2.DrivewaySurface := FDoc.GetCellTextByID(92);

    FSubjectData2.Garage := FDoc.GetCellTextByID(349) = 'X';
    if FSubjectData2.Garage then
      begin
        garCount := GetStrInt(FDoc.GetCellTextByID(2030));      //Ticket #1382
        if POS('X', upperCase(FDoc.GetCellTextByID(2070))) > 0 then
          begin
            FSubjectData2.GarageAttachedCars := True;
            FSubjectData2.GarageCars := garCount;
          end
        else if POS('X', upperCase(FDoc.GetCellTextByID(2071))) > 0 then
          begin
            FSubjectData2.GarageDetachedCars := True;
            FSubjectData2.GarageCars := garCount;
          end
        else if POS('X', UpperCase(FDoc.GetCellTextByID(2072))) > 0 then
          begin
            FSubjectData2.GarageBuiltincars :=  True;
            FSubjectData2.GarageCars := garCount;
          end;
      end;

    FSubjectData2.ConditionCommentAdverse := FDoc.GetCellTextByID(2036);
    FSubjectData2.AdverseConditionsDescription := FDoc.GetCellTextByID(471);

    FSubjectData2.Carport := FDoc.GetCellTextByID(2657) = 'X';
    if FSubjectData2.Carport then
      begin
        garCount := GetStrInt(FDoc.GetCellTextByID(355));    //Ticket #1382
        FSubjectData2.CarportCars := garCount;
        if not FSubjectData2.Garage then
          begin
            if POS('X', upperCase(FDoc.GetCellTextByID(2070))) > 0 then
              FSubjectData2.CarportAttachedCars := True
            else if POS('X', upperCase(FDoc.GetCellTextByID(2071))) > 0 then
              FSubjectData2.CarportDetachedCars := True
            else if POS('X', UpperCase(FDoc.GetCellTextByID(2072))) > 0 then
              FSubjectData2.CarportBuiltInCars := True;
          end;
      end;

    FSubjectData2.ConditionRating := GetConditionRating(FSubjCol.GetCellTextByID(998));    //C1..C6    Default = C1
    FSubjectData2.QualityRating := GetQualityRating(FSubjCol.GetCellTextByID(994));    //Q1..Q6    Default = Q1
    FSubjectData2.ConditionCommentDescription := FDoc.GetCellTextByID(520);

    if FDoc.GetCellTextByID(469) = 'X' then
      FSubjectData2.AdverseConditionsDescription := FDoc.GetCellTextByID(471);
    FSubjectData2.ConditionCommentNeighborhood := FDoc.GetCellTextByID(506);

    FSubjectData2.FunctionalUtility := FSubjCol.GetCellTextByID(1010);
    FSubjectData2.FunctionalAdjAmt  := 0;  //we don't have adjustment for the subject
    FSubjectData2.EnergyEff         := FSubjCol.GetCellTextByID(1014);
    FSubjectData2.EnergyAdjAmt      := 0;  //we don't have adjustment for the subject

    FSubjectData2.HasFireplaces:= FDoc.GetCellTextByID(321) = 'X';
    FSubjectData2.Fireplaces   := GetStrInt(FDoc.GetCellTextByID(322));   //Ticket #1382

    FSubjectData2.HasWoodstove := FDoc.GetCellTextByID(2027) = 'X';
    FSubjectData2.Woodstove    := GetStrInt(FDoc.GetCellTextByID(2028));   //Ticket #1382

    FSubjectData2.HasPatio := FDoc.GetCellTextByID(332) = 'X';
    FSubjectData2.Patio    := FDoc.GetCellTextByID(333);

    FSubjectData2.HasPool := FDoc.GetCellTextByID(339) = 'X';
    FSubjectData2.Pool    := FDocCompTable.Comp[0].GetCellTextByID(1022);

    FSubjectData2.HasFence := FDoc.GetCellTextByID(336) = 'X';
    FSubjectData2.Fence    := FDoc.GetCellTextByID(337);

    FSubjectData2.HasPorch := FDoc.GetCellTextByID(334) = 'X';
    FSubjectData2.Porch    := FDoc.GetCellTextByID(335);

    FSubjectData2.HasOtherAmenities := FDoc.GetCellTextByID(342) = 'X';
    FSubjectData2.OtherAmenities := FDoc.GetCellTextByID(344);

    FSubjectData2.AdditionalFeatures := FDoc.GetCellTextByID(593);

    //Heating...
    if FDoc.GetCellTextByID(2021) = 'X' then
      FSubjectData2.HeatingType := tFWA
    else if FDoc.GetCellTextByID(2022) = 'X' then
      FSubjectData2.HeatingType := tHWBB
    else if FDoc.GetCellTextByID(2023) = 'X' then
      FSubjectData2.HeatingType := tRadiant
    else if FDoc.GetCellTextByID(2024) = 'X' then
      FSubjectData2.HeatingType := tHeat_Other
    else
      FSubjectData2.HeatingType := tUnkHeat;

    FSubjectData2.HeatingOther := FDoc.GetCellTextByID(2026);

    FSubjectData2.HeatingFuel := FDoc.GetCellTextByID(288);

    //Cooling...
    if FDoc.GetCellTextByID(2658) = 'X' then
      FSubjectData2.CoolingType := tCAC
    else if FDoc.GetCellTextByID(2025) = 'X' then
      FSubjectData2.CoolingType := tIndividual
    else if FDoc.GetCellTextByID(2644) = 'X' then
      begin
        FSubjectData2.CoolingType := tCool_Other;
        FSubjectData2.CoolingOther := FDoc.GetCellTextByID(293);
      end
    else
      FSubjectData2.CoolingType := tUnkCool;

    //Occupancy...
    if FDoc.GetCellTextByID(51) = 'X' then
      FSubjectData2.OccupancyType := tOwner
    else if FDoc.GetCellTextByID(52) = 'X' then
      FSubjectData2.OccupancyType := tTenent
    else if FDoc.GetCellTextByID(53) = 'X' then
      FSubjectData2.OccupancyType := tVacant
    else
      FSubjectData2.OccupancyType := tUnkOcc;

    //HOA...
    FSubjectData2.AssociationFeesAmount := GetInt(FDoc.GetCellTextByID(390));
    if FDoc.GetCellTextByID(2042) = 'X' then
      FSubjectData2.AssociationFeesType := tPerYear
    else if FDoc.GetCellTextByID(2043) = 'X' then
      FSubjectData2.AssociationFeesType := tPerMonth
    else
      FSubjectData2.AssociationFeesType := tUnkHOA;

    ImprovementStr := FDoc.GetCellTextByID(520);
    ImprovementOrg := FDoc.GetCellTextByID(520);

    FSubjectData2.KitchenImprovementType := GetKitchenImprovementType(ImprovementStr, KitchenRemodelNote);
    FSubjectData2.KitchenImprovementsYearsSinceCompletion := KitchenRemodelNote;
    FSubjectData2.BathroomImprovementType := GetBathroomsImprovementType(ImprovementStr, BathRemodelNote);
    FSubjectData2.BathroomImprovementsYearsSinceCompletion := BathRemodelNote;

    FSubjectData2.HasImprovementsWitihin15Years := GetPropertyImprovementWithin15Years(ImprovementOrg);

    FSubjectData2.HomeOwnerInterviewNotes := '';  //not used should be EMPTY

    FSubjectData2.Dimensions := FDoc.GetCellTextByID(66);
    FSubjectData2.Area := FDoc.GetCellTextByID(67);
    FSubjectData2.Shape := FDoc.GetCellTextByID(88);

    str := FSubjCol.GetCellTextByID(984);
    GetViewInflNDesc(str, ViewInfl, ViewFact1, ViewFact2, VIewOther);
    FSubjectData2.ViewInfluence     := ViewInfl;
    FSubjectData2.ViewFactor1       := MakeFullViewLocFactor(ViewFact1);
    FSubjectData2.ViewFactor2       := MakeFullViewLocFactor(ViewFact2);
    FSubjectData2.ViewFactor1Other  := ViewOther;

    str := FSubjCol.GetCellTextByID(962);
    GetViewInflNDesc(str, locInfl, locFact1, locFact2, locOther);
    FSubjectData2.LocationInfluence     := locInfl;
    FSubjectData2.LocationFactor1       := MakeFullViewLocFactor(locFact1);
    FSubjectData2.LocationFactor2       := MakeFullViewLocFactor(locFact2);
    FSubjectData2.LocationFactor1Other  := locOther;

    //Electricity...
    if FDoc.GetCellTextByID(75) = 'X' then
      FSubjectData2.ElectricityType := tPublic
    else if FDoc.GetCellTextByID(2104) = 'X' then
      begin
        FSubjectData2.ElectricityType := tOther;
        FSubjectData2.ElectricityOther := FDoc.GetCellTextByID(76);
      end
    else
      FSubjectData2.ElectricityType := tUnkOffSite;

    //Gas...
    if FDoc.GetCellTextByID(77) = 'X' then
      FSubjectData2.GasType := tPublic
    else if FDoc.GetCellTextByID(2105) = 'X' then
      begin
        FSubjectData2.GasType := tOther;
        FSubjectData2.GasOther := FDoc.GetCellTextByID(78);
      end
    else
      FSubjectData2.GasType := tUnkOffSite;

     //Water...
     if FDoc.GetCellTextByID(79) = 'X' then
       FSubjectData2.WaterType := tPublic
     else if FDoc.GetCellTextByID(2106) = 'X' then
       begin
         FSubjectData2.WaterType := tOther;
         FSubjectData2.WaterOther := FDoc.GetCellTextByID(80);
       end
     else
       FSubjectData2.WaterType := tUnkOffSite;


     //Sewer...
     if FDoc.GetCellTextByID(81) = 'X' then
       FSubjectData2.SewerType := tPublic
     else if FDoc.GetCellTextByID(2107) = 'X' then
       begin
         FSubjectData2.SewerType := tOther;
         FSubjectData2.SewerOther := FDoc.GetCellTextByID(82);
       end
     else
       FSubjectData2.SewerType := tUnkOffSite;


     //Street Type...
     if FDoc.GetCellTextByID(112) = 'X' then
       FSubjectData2.StreetType := tPublic
     else if FDoc.GetcellTextByID(113) = 'X' then
       FSubjectData2.StreetType := tPrivate  //default to Private;
     else
       FSubjectData2.StreetType := tUnkOffSite;  //default to Private;

     FSubjectData2.StreetDesc := FDoc.GetCellTextByID(111);

     //Alley Type...
     FSubjectData2.AlleyType := tUnkOffSite;
     if FDoc.GetCellTextByID(134) = 'X' then FSubjectData2.AlleyType := tPublic;
     if FDoc.GetCellTextByID(135) = 'X' then FSubjectData2.AlleyType := tPrivate;
     FSubjectData2.AlleyDesc := FDoc.GetCellTextByID(133);

     //offsite improvement...
     FSubjectData2.OffsiteImprovementsTypical := -1;

     //Ticket #1322 copy from Charlie's email to handle 1004 and 1073 forms with different cellids
     if (FDoc.GetCellTextByID(472) = 'X') or (FDoc.GetCellTextByID(103) = 'X') then
       FSubjectData2.OffsiteImprovementsTypical := 1
     else
       if (FDoc.GetcellTextByID(473) = 'X') or (FDoc.GetcellTextByID(2038) = 'X') then
          FSubjectData2.OffsiteImprovementsTypical := 0;

     //we can only have one on the form: check if cell 474 value exist use it else check for cell 2039
     if  FDoc.GetCellTextByID(474) <> '' then
       FSubjectData2.OffsiteImprovementsDescription := FDoc.GetCellTextByID(474)
     else if FDoc.GetCellTextByID(2039) <> '' then
       FSubjectData2.OffsiteImprovementsDescription := FDoc.GetCellTextByID(2039);   //Only one cell can be in the report - so, either function will return ""

     FSubjectData2.HasAdverseConditions := -1;
     if FDoc.GetCellTextByID(469) = 'X' then
       FSubjectData2.HasAdverseConditions := 1
     else if FDoc.GetCellTextByID(470) = 'X' then
       FSubjectData2.HasAdverseConditions := 0;   //default to No

     FSubjectData2.AdverseConditionsDescription := FDoc.GetCellTextByID(471);

     if FDoc.GetCellTextByID(311) = 'X' then
       FSubjectData2.HasAttic := False
     else
       FSubjectData2.HasAttic := True;

     //DropStairs...
     if FDoc.GetCellTextByID(315) = 'X' then
       FSubjectData2.DropStairs := True
     else
       FSubjectData2.DropStairs := False;

     //Stairs
     if FDoc.GetCellTextByID(314) = 'X' then
       FSubjectData2.Stairs := True
     else
       FSubjectData2.Stairs := False;

     //Scuttle
     if FDoc.GetCellTextByID(316) = 'X' then
       FSubjectData2.Scuttle := True
     else
       FSubjectData2.Scuttle := False;

     //Floor...
     if FDoc.GetCellTextByID(317) = 'X' then
       FSubjectData2.Floor := True
     else
       FSubjectData2.Floor := False;

     //Finished...
     if FDoc.GetCellTextByID(312) = 'X' then
       FSubjectData2.Finished := True
     else
       FSubjectData2.Finished := False;

     //Heated...
     if FDoc.GetCellTextByID(1203) = 'X' then
       FSubjectData2.Heated := True
     else
       FSubjectData2.Heated := False;

     FSubjectData2.Neighborhoodname := FDoc.GetCellTextByID(595);

     //Location Type
     if FDoc.GetCellTextByID(696) = 'X' then
       FSubjectData2.LocationType := tUrban
     else if FDoc.GetCellTextByID(697) = 'X' then
       FSubjectData2.LocationType := tSuburban
     else if FDoc.GetCellTextByID(698) = 'X' then
       FSubjectData2.LocationType := tRural
     else
       FSubjectData2.LocationType := tUnkLocType;


     //BuildUP type
     if FDoc.GetCellTextByID(699) = 'X' then
       FSubjectData2.BuiltUpType := tOver75
     else if FDoc.GetCellTextByID(700) = 'X' then
       FSubjectData2.BuiltUpType := tBetween2575
     else if FDoc.GetCellTextByID(701) = 'X' then
       FSubjectData2.BuiltUpType := tUnder25
     else
       FSubjectData2.BuiltUpType := -1;

     //Growth
     if FDoc.GetCellTextByID(704) = 'X' then
       FSubjectData2.GrowthType := tRapid
     else if FDoc.GetCellTextByID(705) = 'X' then
       FSubjectData2.GrowthType := tStable
     else if FDoc.GetCellTextByID(706) = 'X' then
       FSubjectData2.GrowthType := tSlow
     else
       FSubjectData2.GrowthType := tUnkGrowth;

     //Ticket #1382
     FSubjectData2.PluOneUnit := GetStrInt(FDoc.GetCellTextByID(777));
     FSubjectData2.Plu24Units := GetStrInt(FDoc.GetCellTextByID(778));     
     FSubjectData2.PluMultiFamily := GetStrInt(FDoc.GetCellTextByID(779));
     FSubjectData2.PluCommercial := GetStrInt(FDoc.GetCellTextByID(781));
     FSubjectData2.PluOtherCount := GetStrInt(FDoc.GetCellTextByID(786));

     FSubjectData2.BoundaryDescription := FDoc.GetCellTextByID(600);
     FSubjectData2.NeighborhoodDescription := FDoc.GetCellTextByID(601);
     FSubjectData2.PluOther := FDoc.GetCellTextByID(785);

     //Exterior...
     GetDescriptionAndCondition(FDoc.GetCellTextByID(173), FSubjectData2.FoundationWallMaterial, FSubjectData2.FoundationWallCondition);
     GetDescriptionAndCondition(FDoc.GetCellTextByID(174), FSubjectData2.ExteriorWallsMaterial, FSubjectData2.ExteriorWallsCondition);
     GetDescriptionAndCondition(FDoc.GetCellTextByID(175), FSubjectData2.RoofSurfaceMaterial, FSubjectData2.RoofSurfaceCondition);
     GetDescriptionAndCondition(FDoc.GetCellTextByID(176), FSubjectData2.GuttersMaterial, FSubjectData2.GuttersCondition);
     GetDescriptionAndCondition(FDoc.GetCellTextByID(181), FSubjectData2.WindowTypeMaterial, FSubjectData2.WindowTypeCondition);
     GetDescriptionAndCondition(FDoc.GetCellTextByID(184), FSubjectData2.StormSashMaterial, FSubjectData2.StormSashCondition);
     GetDescriptionAndCondition(FDoc.GetCellTextByID(183), FSubjectData2.ScreensMaterial, FSubjectData2.ScreensCondition);

     //Interior...
     GetDescriptionAndCondition(FDoc.GetCellTextByID(253), FSubjectData2.FloorsMaterial, FSubjectData2.FloorsCondition);
     GetDescriptionAndCondition(FDoc.GetCellTextByID(260), FSubjectData2.WallsMaterial, FSubjectData2.WallsCondition);
     GetDescriptionAndCondition(FDoc.GetCellTextByID(251), FSubjectData2.TrimMaterial, FSubjectData2.TrimCondition);
     GetDescriptionAndCondition(FDoc.GetCellTextByID(267), FSubjectData2.BathFloorsMaterial, FSubjectData2.BathFloorsCondition);
     GetDescriptionAndCondition(FDoc.GetCellTextByID(274), FSubjectData2.BathWainscotMaterial, FSubjectData2.BathWainscotCondition);


     //Foundation
     FSubjectData2.ConcreteSlab := FDoc.GetCellTextByID(187) = 'X';
     FSubjectData2.CrawlSpace   := FDoc.GetCellTextByID(189) = 'X';
     FSubjectData2.HasPumpSump  := FDoc.GetCellTextByID(193) = 'X';
     FSubjectData2.EvidenceOfDampness := FDoc.GetCellTextByID(2019) = 'X';
     FSubjectData2.EvidenceOfSettlement := FDoc.GetCellTextByID(2020) = 'X';
     FSubjectData2.EvidenceOfInfestation := FDoc.GetCellTextByID(197) = 'X';
     FSubjectData2.TotalArea := FDoc.GetCellTextByID(200);
     FSubjectData2.FinishedPercent := GetStrInt(FDoc.GetCellTextByID(201));   //Ticket #1382
     FSubjectData2.FinishedArea       := -1;  //Ticket #1382: initialize to -1 first
     FSubjectData2.BasementRecRooms   := -1;
     FSubjectData2.BasementBedrooms   := -1;
     FSubjectData2.BasementFullBaths  := -1;
     FSubjectData2.BasementHalfBaths  := -1;
     FSubjectData2.BasementOtherRooms := -1;

     if GetValidInteger(FSubjectData2.TotalArea) > 0 then
       FSubjectData2.FinishedArea := CalcBsmentFinishArea(GetValidInteger(FSubjectData2.TotalArea), FSubjectData2.FinishedPercent);
     if assigned(FDocCompTable) then
       aBsmtRooms := FDocCompTable.Comp[0].GetCellTextByID(1008);  //get from page 2 subject grid
     //Ticket #1382
     if pos('rr', aBsmtRooms) > 0 then
       FSubjectData2.BasementRecRooms := GetStrInt(popStr(aBsmtRooms, 'rr'));
     if pos('br', aBsmtRooms) > 0 then
       FSubjectData2.BasementBedrooms := GetStrInt(popStr(aBsmtRooms, 'br'));
     if pos('ba', aBsmtRooms) > 0 then
      begin
        ba := popStr(aBsmtRooms, 'ba');
        FSubjectData2.BasementFullBaths := GetStrInt(popStr(ba, '.'));
        FSubjectData2.BasementHalfBaths := GetStrInt(ba);
      end;
     if pos('o', aBsmtRooms) > 0 then
       FSubjectData2.BasementOtherRooms := GetStrInt(popStr(aBsmtRooms, 'o'));

     if assigned(FDocCompTable) then
       str := FDocCompTable.Comp[0].GetCellTextByID(1006);  //get from page 2 subject grid
     if length(str) > 0 then
       begin
         if pos('sf', str) > 0 then
           popStr(str, 'sf');   //this is bsmt area
         if pos('sf', str) > 0 then
           popStr(str, 'sf');  //this is finished area

         FSubjectData2.AccessMethodWalkUp := False; FSubjectData2.AccessMethodWalkOut := False; FSubjectData2.AccessMethodInteriorOnly := False;
         if pos('wo', str) > 0 then
           FSubjectData2.AccessMethodWalkOut  := True
         else if pos('wu', str) > 0 then
           FSubjectData2.AccessMethodWalkUp := True
         else if pos('in', str) > 0 then
           FSubjectData2.AccessMethodInteriorOnly := True;
       end;
  //basement type
  if FDoc.GetCellTextByID(191) = 'X' then
    FSubjectData2.BasementType := tFullBasement
  else if FDoc.GetCellTextByID(2018) = 'X' then
    FSubjectData2.BasementType := tPartialBasement
  else
    begin
      if getValidInteger(FSubjectData2.TotalArea) = 0 then   //need to check if basement area is 0 set basement type to No basement
        FSubjectData2.BasementType := tNoBasement
      else
        FSubjectData2.BasementType := -1;
    end;
    //Appliances
  FSubjectData2.HasRefrigerator  := FDoc.GetCellTextByID(299) = 'X';
  FSubjectData2.HasRangeOwen     := FDoc.GetCellTextByID(300) = 'X';
  FSubjectData2.HasDishWasher    := FDoc.GetCellTextByID(304) = 'X';
  FSubjectData2.HasDisposal      := FDoc.GetCellTextByID(303) = 'X';
  FSubjectData2.HasMicrowave     := FDoc.GetCellTextByID(307) = 'X';
  FSubjectData2.HasWasherDryer   := FDoc.GetCellTextByID(308) = 'X';
  FSubjectData2.HasOtherAppliances := FDoc.GetCellTextByID(2084) = 'X';
  FSubjectData2.OtherAppliances  := FDoc.GetCellTextByID(309);

  //Load in Primary contact
  FSubjectData2.PrimaryName     := edtPriName.Text;
  FSubjectData2.PrimaryHomeNo   := edtPRIHome.Text;
  FSubjectData2.PrimaryMobileNo := edtPRIMobile.Text;
  FSubjectData2.PrimaryWorkNo   := edtPRIWork.Text;
  if rdoPBorrower.Checked then
    FSubjectData2.PrimaryContactType := acIsBorrower
  else if rdoPOwner.Checked then
    FSubjectData2.PrimaryContactType := acIsOwner
  else if rdoPOccupant.Checked then
    FSubjectData2.PrimaryContactType := acIsOccupant
  else if rdoPAgent.Checked then
    FSubjectData2.PrimaryContactType := acIsAgent
  else if rdoPOther.Checked then
    FSubjectData2.PrimaryContactType    := acIsOther
  else
    FSubjectData2.PrimaryContactType    := acIsUnknown;

  FSubjectData2.PrimaryOther := edtPriOther.Text;

  //
  //Load in Alternate contact
  FSubjectData2.AlternateName     := edtAltName.Text;
  FSubjectData2.AlternateHomeNo   := edtAltHome.Text;
  FSubjectData2.AlternateMobileNo := edtAltMobile.Text;
  FSubjectData2.AlternateWorkNo   := edtAltWork.Text;

  if rdoABorrower.Checked then
    FSubjectData2.AlternateContactType := acIsBorrower
  else if rdoAOwner.Checked then
    FSubjectData2.AlternateContactType := acIsOwner
  else if rdoAOccupant.Checked then
    FSubjectData2.AlternateContactType := acIsOccupant
  else if rdoAAgent.Checked then
    FSubjectData2.AlternateContactType := acIsAgent
  else if rdoAOther.Checked then
    FSubjectData2.AlternateContactType := acIsOther
  else
    FSubjectData2.AlternateContactType := acIsUnknown
;
  FSubjectData2.AlternateOther := edtAltOther.Text;

  if assigned(FDocCompTable) then
   begin
     aInt := GetValidInteger(FDocCompTable.Comp[0].GetCellTextByID(1020)); //to get rid of the Fireplace word.
//     if aInt > 0 then
//       FSubjectData2.MiscDesc1 := Format('%d',[aInt]);
     FSubjectData2.MiscDesc1  := FDocCompTable.Comp[0].GetCellTextByID(1020);  //Ticket #745: Get the fireplace cell value from subject grid
     FSubjectData2.MiscDesc2  := FDocCompTable.Comp[0].GetCellTextByID(1022);
     FSubjectData2.MiscDesc3  := FDocCompTable.Comp[0].GetCellTextByID(1032);
   end;

  if FDoc.GetCellTextByID(2034) = 'X' then   //Ticket #1538
    FSubjectData2.AdverseSiteConditionPresent := 1   //if not checked, we assume this flag is NULL instead of False
  else if FDoc.GetCellTextByID(2035) = 'X' then
    FSubjectData2.AdverseSiteConditionPresent := 0;


  if FDoc.GetCellTextByID(504) = 'X' then  //Ticket #1538
    FSubjectData2.PropertyConformsToNeighborhood := 1  //if not checked, we assume this flag is NULL instead of False
  else if FDoc.GetCellTextByID(505) = 'X' then
    FSubjectData2.PropertyConformsToNeighborhood := 0;
   result := FSubjectData2;
end;

function TCC_Mobile_Inspection.UploadInspectionData2(doc:TContainer):Boolean;
var
  jsSubject,  jsSummary: TlkJSONObject;
  jsComps, jsListings: TlkJSONList;
begin
  result := False;
  FUploadInfo2.Duration := 0;  //reset the duration time
  FSubjectData2 := CollectSubjectData2;  //always send the latest data structure

  FUserID := CurrentUser.AWUserInfo.UserLoginEmail;
  FUserPsw := CurrentUser.AWUserInfo.UserPassWord;
  FUploadInfo2.UserName  := FUserID;
  FUploadInfo2.Password  := FUserPsw;
  FUploadInfo2.AppraiserID := FAppraiserID;
  FUploadInfo2.Address   := FSubjectData2.Address;
  FUploadInfo2.State     := FSubjectData2.State;
  FUploadInfo2.City      := FSubjectData2.City;
  FUploadInfo2.Zipcode   := FSubjectData2.ZipCode;
  FUploadInfo2.Insp_Type := cbJobType.text;
  FUploadInfo2.insp_id   := 0;
  FUploadInfo2.Status    := 'N';
  //github #648: add version #
  FUploadInfo2.Version := Format('%d',[JSON_VERSION_NO]);

  FUploadInfo2.Revision  := 0;
  FUploadInfo2.Caller    := caller_CF;

  //Load in Primary contact
  FUploadInfo2.PrimaryName     := edtPriName.Text;
  FUploadInfo2.PrimaryHomeNo   := edtPRIHome.Text;
  FUploadInfo2.PrimaryMobileNo := edtPRIMobile.Text;
  FUploadInfo2.PrimaryWorkNo   := edtPRIWork.Text;
  if rdoPBorrower.Checked then
    FUploadInfo2.PrimaryContactType := acIsBorrower
  else if rdoPOwner.Checked then
    FUploadInfo2.PrimaryContactType := acIsOwner
  else if rdoPOccupant.Checked then
    FUploadInfo2.PrimaryContactType := acIsOccupant
  else if rdoPAgent.Checked then
    FUploadInfo2.PrimaryContactType := acIsAgent
  else if rdoPOther.Checked then
    FUploadInfo2.PrimaryContactType    := acIsOther
  else
    FUploadInfo2.PrimaryContactType    := acIsUnknown;

  FUploadInfo2.PrimaryOther := edtPriOther.Text;

  //
  //Load in Alternate contact
  FUploadInfo2.AlternateName     := edtAltName.Text;
  FUploadInfo2.AlternateHomeNo   := edtAltHome.Text;
  FUploadInfo2.AlternateMobileNo := edtAltMobile.Text;
  FUploadInfo2.AlternateWorkNo   := edtAltWork.Text;

  if rdoABorrower.Checked then
    FUploadInfo2.AlternateContactType := acIsBorrower
  else if rdoAOwner.Checked then
    FUploadInfo2.AlternateContactType := acIsOwner
  else if rdoAOccupant.Checked then
    FUploadInfo2.AlternateContactType := acIsOccupant
  else if rdoAAgent.Checked then
    FUploadInfo2.AlternateContactType := acIsAgent
  else if rdoAOther.Checked then
    FUploadInfo2.AlternateContactType := acIsOther
  else
    FUploadInfo2.AlternateContactType := acIsUnknown
;
  FUploadInfo2.AlternateOther := edtAltOther.Text;

  if FUploadInfo2.IsAdmin then
    FUploadInfo2.Assigned_ID_Name := cbAssignedTo.Text;
  //Get Subject Data to Json object
  try
    jsSubject := TlkJSONObject.Create(true);
    DoUploadSubjectDataJson_V2(jsSubject); //github #596

    //Get Comps Data to Json Object
    jsComps := TlkJSONList.Create;
    DoUploadCompsDataJson_V2(jsComps);
    //Get Summary Data to Json object: for now we only include id as 0
    jsSummary := TlkJSONObject.Create(true);
    DoUploadSummaryDataJson(jsSummary);

    result := PostInspectionData2(jsSubject, jsComps, jsListings, jsSummary, FUploadInfo2);
  finally
  end;
end;

procedure TCC_Mobile_Inspection.DoUploadSummaryDataJson(var jsSummary:TlkJSonObject);
begin
  if jsSummary = nil then
    jsSummary := TlkJSOnObject.Create(true);
  if FUploadInfo2.StartTime = '' then
    FUploadInfo2.StartTime := FormatDateTime('hh:mm', now);
  postJsonStr('StartTime', FUploadInfo2.StartTime, jsSummary);
  if FUploadInfo2.EndTime = '' then
    FUploadInfo2.EndTime := FormatDateTime('hh:mm', now);
  postJsonStr('EndTime', FUploadInfo2.EndTime, jsSummary);
  postJsonInt('Duration', 0, jsSummary, False);
  postJsonStr('SummaryNote', FUploadInfo2.SummaryNote, jsSummary);
end;


procedure TCC_Mobile_Inspection.btnRefreshClick(Sender: TObject);
begin
  PushMouseCursor(crHourglass);
  try
//  ShowInspectionCheckBoxClick(Sender);
    GetInspectionSummary;
  finally
    PopMouseCursor;
  end;
end;


procedure TCC_Mobile_Inspection.PageControlChange(Sender: TObject);
begin
  if PageControl.ActivePage = tabNewInspection then
    begin
      btnUploadInsp.Enabled := True;
      btnOpen.Enabled := False;
      LoadCompsAddress;
    end
  else if PageControl.ActivePage = tabCompleted then
    begin
      btnUploadInsp.Enabled := False;
      //btnOpen.Enabled := True;
//      btnRefresh.click;   //do not refresh each time we swap the page.  The upload button after posting also do get summary to refresh the data already.
    end;
end;



procedure TCC_Mobile_Inspection.btnDeleteClick(Sender: TObject);
var
  status, msg: String;
  i,j, insp_id: integer;
  deleteCount: Integer;
  aOption: TModalResult;
begin
   j := 0;  deleteCount := 0;
  for i := 1 to SummaryGrid.Rows do
    begin
      insp_id := GetValidInteger(SummaryGrid.Cell[sInsp_id, i]);
      if SummaryGrid.Cell[sSelect, i] = cbChecked then
        begin
          j := j + 1;
        end;
    end;
  if j > 0 then
    begin
      if msg = '' then //github #797
       // msg := 'This will remove the selected inspection from the mobile app.  Are you sure you want to continue?';
        msg := 'This will remove the selected inspection from the inspection manager. Are you sure you want to continue?';
      if msg <> '' then
        begin
          aOption:= WhichOption12('Delete', 'Cancel',msg);
          if aOption <> mrYes then exit;
        end;
    end
  else
    begin
      ShowAlert(atWarnAlert,'Please select the inspection to delete.');
      exit;
    end;
  try
    PushMouseCursor(crHourglass);
    try
    for i := 1 to SummaryGrid.Rows do
      begin
        insp_id := SummaryGrid.Cell[sInsp_id, i];
        if SummaryGrid.Cell[sSelect,i] = cbChecked then
          begin
            FUploadInfo2.insp_id := SummaryGrid.Cell[sInsp_id,i];;
            status := AbbreviateStatus(SummaryGrid.Cell[sStatus,i]);
            if not DeleteInspectionDataById(FUploadInfo2) then
              begin
                msg := Format('Problems were encountered when trying to delete inspections #: %d.',[insp_id]);
                ShowAlert(atWarnAlert,msg);
              end
            else
              inc(deleteCount);
            end;
        end;
      if deleteCount > 0 then
      begin
        msg := Format('%d inspection(s) have been deleted successfully!',[deleteCount]);
        ShowNotice(msg);
      end
  except
    ShowAlert(atWarnAlert,'Problems were encountered when trying to delete the property inspections.');
  end;
  btnRefresh.click; //github 677
  GetInspectionSummary;
  finally
    PopMouseCursor;
  end;
end;



function TCC_Mobile_Inspection.GetInspectionSummary:Boolean;
var
  aMsg,InspectionData: String;
begin
  FUploadInfo2.UserName := CurrentUser.AWUserInfo.UserLoginEmail;
  FUploadInfo2.Password := CurrentUser.AWUserInfo.UserPassWord;
  if edtFilterDate.Text <> '' then
  begin
    FUploadInfo2.FilterDate := edtFilterDate.Text;
    FUploadInfo2.FilterDate := StringReplace(FUploadInfo2.FilterDate, '/', '-',[rfReplaceAll]);
  end;

  SummaryGrid.Rows := 0;
  try
    if chkReadyForImport.Checked then
      begin
        FUploadInfo2.Status := status_c;
        if GetInspectionDataSummary(FUploadInfo2, InspectionData) then
          LoadInspectionData(InspectionData);
      end
    else
      SummaryGrid.Rows := 0;

    if chkImported.Checked then
      begin
        if not chkReadyForImport.Checked then
          SummaryGrid.Rows := 0;
        FUploadInfo2.Status := status_D;
        if GetInspectionDataSummary(FUploadInfo2, InspectionData) then
          LoadInspectionData(InspectionData);
      end;

    if chkShowPending.Checked then
      begin
        FUploadInfo2.Status := status_N;
        if GetInspectionDataSummary(FUploadInfo2, InspectionData) then
          LoadInspectionData(InspectionData);
      end;

    if chkProgress.Checked then
      begin
        FUploadInfo2.Status := status_I;
        if GetInspectionDataSummary(FUploadInfo2, InspectionData) then
          LoadInspectionData(InspectionData);
      end;

    if chkPartialCompleted.Checked then  //Ticket #1386: include new status: P for partial completed
      begin
        FUploadInfo2.Status := status_P;
        if GetInspectionDataSummary(FUploadInfo2, InspectionData) then
          LoadInspectionData(InspectionData);
      end;
  finally
    btnOpen.Enabled := False;
    btnDelete.Enabled := False;
  end;
end;



procedure TCC_Mobile_Inspection.LoadDataToSummaryGrid(aUploadInfo:TUploadInfo2);
var
  row: Integer;
  insp_time: String;
begin
  SummaryGrid.Rows := SummaryGrid.Rows + 1;
  InitGridCombo; //set up combo
  row := SummaryGrid.Rows;
  SummaryGrid.Cell[sSelect, row]   := 0;
  SummaryGrid.Cell[sInsp_id, row]  := aUploadInfo.insp_id;
  SummaryGrid.Cell[sInspType, row] := aUploadInfo.Insp_Type;
  SummaryGrid.Cell[sStatus, row]   := TranslateStatus(aUploadInfo.Status);
  SummaryGrid.Cell[sStatusDate, row] :=aUploadInfo.StatusDateTime;
  SummaryGrid.Cell[sInspDate, row] := aUploadInfo.Insp_date;
  if aUploadInfo.insp_time <> '' then
    insp_time := aUploadInfo.Insp_time;
  SummaryGrid.Cell[sInspTime, row]     := insp_time;
  SummaryGrid.Cell[sRevision, row]     := aUploadInfo.Revision;
  SummaryGrid.Cell[sUserAWID, row]     := aUploadInfo.AppraiserID;
  SummaryGrid.Cell[sAddress, row]      := aUploadInfo.Address;
  SummaryGrid.Cell[sCity, row]         := aUploadInfo.City;
  SummaryGrid.Cell[sState, row]        := aUploadInfo.State;
  SummaryGrid.Cell[sZip, row]          := aUploadInfo.Zipcode;
  SummaryGrid.Cell[sCaller, row]       := TranslateCaller(aUploadInfo.Caller);
  SummaryGrid.Cell[sDurationMin, row]  := aUploadInfo.Duration;
  SummaryGrid.Cell[sVersion, row]      := aUploadInfo.Version;
  SummaryGrid.Cell[sAssignedName, row] := aUploadInfo.Assigned_ID_Name;
  SummaryGrid.Cell[sAssignedID, row]   := aUploadInfo.Assigned_ID;
end;

procedure TCC_Mobile_Inspection.LoadInspectionData(InspectionData:String);

 function LoadImage(const Stream: TStream; var Image: TImage): Boolean;
  var
    TempImage: TJpegImage;
  begin
    result := false;
    if Assigned(Stream) and (stream.Size > 0) and Assigned(Image) then
      begin
        TempImage := TJpegImage.Create;
        try
          TempImage.LoadFromStream(Stream);
          Image.Picture.Graphic := TempImage; // copy
        finally
          FreeAndNIl(TempImage);
        end;
        result := true;
      end
    else
      Image.Picture.Graphic := nil;
  end;

var
  jsdata: TlkJSONBase;
  jo : TlkJSONObject;
  i: Integer;
  aStatusDate: String;
  aMatch, doAll, Ok2Show:Boolean;
begin
  FjInspectionObject := TlkJSON.ParseText(Inspectiondata) as TlkJSONObject;
  jsdata :=TlkJsonObject(FjInspectionObject).Field['data'];
  if jsdata = nil then exit;
  SummaryGrid.beginUpdate;
  SummaryGrid.Rows := 0;
  try
    for i:= 1 to jsdata.count do
    begin
        jo := jsdata.Child[i-1] as TlkJSONObject;
        if jo = nil then continue;
        FUploadInfo2.Status := vartostr(jo.Field['status'].Value);
        FUploadInfo2.insp_id := jo.Field['insp_id'].Value;
        FUploadInfo2.Address := varToStr(jo.Field['address'].Value);
        FUploadInfo2.City := varToStr(jo.Field['city'].Value);
        FUploadInfo2.State := varToStr(jo.Field['state'].Value);
        FUploadInfo2.Zipcode := varToStr(jo.Field['zipcode'].Value);
        FUploadInfo2.Insp_Type := varToStr(jo.Field['insp_type'].Value);
        if not (jo.Field['status_date'] is TlkJSONnull) then
          begin
            aStatusDate := varToStr(jo.Field['status_date'].Value);
            FUploadInfo2.StatusDateTime := SetISOtoDateTime(aStatusDate,True);
          end;
        if not (jo.Field['insp_date'] is TlkJSONnull) then
          FUploadInfo2.Insp_date := varToStr(jo.Field['insp_date'].Value);
        if not (jo.Field['insp_time'] is TlkJSONnull) then
          FUploadInfo2.Insp_time := varToStr(jo.Field['insp_time'].Value);
        FUploadInfo2.Revision := jo.Field['revision'].Value;
        FUploadInfo2.Duration := jo.Field['duration'].Value;
        if FUploadInfo2.Duration < 0 then
          FUploadInfo2.Duration := 0;
        if jo.Field['version'] <> nil then  //github #648
          FUploadInfo2.Version := varToStr(jo.Field['version'].Value);

        //more new fields
        if jo.Field['team_id'] <> nil then
          FUploadInfo2.Team_ID := jo.Field['team_id'].Value;
        if jo.Field['assigned_id'] <> nil then
          FUploadInfo2.Assigned_ID := jo.Field['assigned_id'].Value;
        if jo.Field['assigned_id_name'] <> nil then
          FUploadInfo2.Assigned_ID_Name := jo.Field['assigned_id_name'].Value;

//add filter by option
//Ticket #1387: open for the team members to see not just restricted to admin
(*
        doAll := (length(cbFilterBy.Text) = 0)  or (CompareText('All', cbFilterBy.Text) = 0);
        if not doAll and (length(cbFilterBy.Text) > 0) then
          begin
            aMatch := CompareText(FUploadInfo2.Assigned_ID_Name, cbFilterBy.Text) = 0;
          end;
        if FUploadInfo2.Team_ID > 0 then //if user is in in TA
          if not doAll and not aMatch  then //not match, go to the next one and do not put into the grid
             Continue;
        ok2Show := doAll or aMatch or (FUploadInfo2.Team_ID = 0);  //Ticket #1318: need to include team id 0
*)
        ok2Show := True;   //Do not do the filtering, every member can see the shared inspections
        if chkShowPending.Checked then
          begin
            if (pos('N', UpperCase(FUploadInfo2.Status)) > 0) then
              begin
                if ok2Show then
                  LoadDataToSummaryGrid(FUploadInfo2);
              end;
          end;
        if chkProgress.Checked then
          begin
            if (pos('I', UpperCase(FUploadInfo2.Status)) > 0) then
              begin
                if ok2Show then
                  LoadDataToSummaryGrid(FUploadInfo2);
              end;
          end;
        if chkImported.Checked then
          begin
            if (pos('D', UpperCase(FUploadInfo2.Status)) > 0) then
              begin
                if ok2Show then
                  LoadDataToSummaryGrid(FUploadInfo2);
              end;
          end;
        if chkReadyForImport.Checked then
          begin
          if  (pos('C', UpperCase(FUploadInfo2.Status)) > 0) then
            begin
              if ok2Show then
                LoadDataToSummaryGrid(FUploadInfo2);
            end;
          end;
        if chkPartialCompleted.Checked then  //Ticket #1386
          begin
          if  (pos('P', UpperCase(FUploadInfo2.Status)) > 0) then
            begin
              if ok2Show then
                LoadDataToSummaryGrid(FUploadInfo2);
            end;
          end;
     end;
    SummaryGrid.SortOnCol(sStatusDate, stDescending, True);
  finally
    SummaryGrid.EndUpdate;
  end;
  Statusbar.Panels[0].Text := Format('Total: %d',[SummaryGrid.Rows]);
end;

procedure TCC_Mobile_Inspection.SetCellTextByCellID(cellID:Integer; aText: String; skipMath:Boolean=False);
var
  aCell: TBaseCell;
begin
  aCell := Fdoc.GetCellByID(cellID);
  if not assigned(aCell) then exit;

  if FOverwriteData then  //always override existing cell value
    begin
      if SkipMath then
        FDoc.SetCellTextByIDNP(cellID, aText)
      else if (aText <> '') and (trim(aText) <> '0') then
        FDoc.SetCellTextByID(cellID, aText);
    end
  else     //not override mode and cell is EMPTY
    begin
      if (aCell.Text = '') and (aText <> '') and (trim(aText) <> '0') then
        begin
          if SkipMath then
            FDoc.SetCellTextByIDNP(cellID, aText)
          else
            FDoc.SetCellTextByID(cellID, aText);
        end;
    end;
end;



procedure TCC_Mobile_Inspection.DoUploadSubjectDataJson(var jsSubject:TlkJSONObject);
var
  aInt: Integer;
  jsPhotos: TlkJSONList;
  isNew: Boolean;
begin
  if jsSubject = nil then
    jsSubject := TlkJsonObject.create(true);
  aInt := 0;
  isNew := CompareText(FUploadInfo2.Status, 'N') = 0;
  jsSubject.Add('VersionNumber', FSubjectData.VersionNumber);
  //Load assignment
  jsSubject.Add('AppraisalFileNumber', FSubjectData.AppraisalFileNumber);
  jsSubject.Add('PropertyType', FSubjectData.PropertyType);
  jsSubject.Add('InspectionScheduleDate', FSubjectData.InspectionScheduleDate);
  jsSubject.Add('InspectionScheduleTime', FSubjectData.InspectionScheduleTime);
  jsSubject.Add('InspectionInstructions', FSubjectData.InspectionInstructions);

  jsSubject.Add('IsFha', FSubjectData.IsFHA);

  //Load Subject main info
  jsSubject.Add('Address', FSubjectData.Address);
  jsSubject.Add('UnitNumber',FSubjectData.UnitNumber);
  jsSubject.Add('City', FSubjectData.City);
  jsSubject.Add('State', FSubjectData.State);
  jsSubject.Add('ZipCode', FSubjectData.ZipCode);
  jsSubject.Add('Latitude', FSubjectData.Latitude);
  jsSubject.Add('Longitude', FSubjectData.Longitude);
  jsSubject.Add('Bedrooms', FSubjectData.Bedrooms);
  jsSubject.Add('FullBaths', FSubjectData.FullBaths);
  jsSubject.Add('HalfBaths', FSubjectData.HalfBaths);
  jsSubject.Add('Gla', FSubjectData.GLA);
  jsSubject.Add('YearBuilt', FSubjectData.YearBuilt);
//  FSubjectData.SiteArea := ConvertACtoSQF(FSubjectData.SiteArea);
  jsSubject.Add('Area', FSubjectData.SiteArea);

  //Primary/Alternate Contact
  jsSubject.Add('Name', FUploadInfo2.PrimaryName);
  jsSubject.Add('HomeNumber', FUploadInfo2.PrimaryHomeNo);
  jsSubject.Add('MobileNumber', FuploadInfo2.PrimaryMobileNo);
  jsSubject.Add('WorkNumber', FuploadInfo2.PrimaryWorkNo);
  jsSubject.Add('PrimaryContactType', FUploadInfo2.PrimaryContactType);
  jsSubject.Add('OtherText', FUploadInfo2.PrimaryOther);

  jsSubject.Add('AltName', FUploadInfo2.AlternateName);
  jsSubject.Add('AltHomeNumber', FUploadInfo2.AlternateHomeNo);
  jsSubject.Add('AltMobileNumber', FUploadInfo2.AlternateMobileNo);
  jsSubject.Add('AltWorkNumber', FUploadInfo2.AlternateWorkNo);
  jsSubject.Add('AltOtherText', FUploadInfo2.AlternateOther);
  jsSubject.Add('AlternateContactType', FUploadInfo2.AlternateContactType);
//  jsSubject.Add('AltOtherText', FUploadInfo.AlternateOther);

  //add more fields here to push down
  jsSubject.Add('TotalRooms', FSubjectData.TotalRooms);
  jsSubject.Add('Design', FSubjectData.Design);
  jsSubject.Add('Stories', FSubjectData.Stories);
  jsSubject.Add('ActualAge', FSubjectData.ActualAge);
  jsSubject.Add('EffectiveAge', FSubjectData.EffectiveAge);
  jsSubject.Add('StructureType', FSubjectData.StructureType);

  if not isNew then  //push all up when this is not a new order
    begin
//      jsSubject.Add('Design', FSubjectData.Design);
//      jsSubject.Add('Stories', FSubjectData.Stories);
//      jsSubject.Add('EffectiveAge', FSubjectData.EffectiveAge);
      jsSubject.Add('SubjectType', FSubjectData.SubjectType);
      jsSubject.Add('Gps', FSubjectData.Gps);

//      jsSubject.Add('TotalRooms', FSubjectData.TotalRooms);
      jsSubject.Add('StructureType', FSubjectData.StructureType);
      jsSubject.Add('ConstructionType', FSubjectData.ConstructionType);
      jsSubject.Add('CarStorageNone', FSubjectData.CarStorageNone);
      jsSubject.Add('Driveway', FSubjectData.Driveway);
      jsSubject.Add('DrivewayCars', FSubjectData.DrivewayCars);
      jsSubject.Add('DrivewaySurface', FSubjectData.DrivewaySurface);
      jsSubject.Add('Garage', FSubjectData.Garage);
      jsSubject.Add('GarageAttachedCars', FSubjectData.GarageAttachedCars);
      jsSubject.Add('GarageDetachedCars', FSubjectData.GarageDetachedCars);
      jsSubject.Add('GarageBuiltincars', FSubjectData.GarageBuiltincars);
      jsSubject.Add('Carport', FSubjectData.Carport);
      jsSubject.Add('CarportAttachedCars', FSubjectData.CarportAttachedCars);
      jsSubject.Add('CarportDetachedCars', FSubjectData.CarportDetachedCars);
      jsSubject.Add('CarportBuiltInCars', FSubjectData.CarportBuiltInCars);
      jsSubject.Add('ConditionRating', FSubjectData.ConditionRating);
      jsSubject.Add('ContractionRating', FSubjectData.ContractionRating);
      jsSubject.Add('ConditionCommentDescription', FSubjectData.ConditionCommentDescription);
      jsSubject.Add('ConditionCommentAdverse', FSubjectData.ConditionCommentAdverse);
      jsSubject.Add('ConditionCommentNeighborhood', FSubjectData.ConditionCommentNeighborhood);
      jsSubject.Add('FunctionalUtility', FSubjectData.FunctionalUtility);
      jsSubject.Add('FunctionalAdjAmt', FSubjectData.FunctionalAdjAmt);
      jsSubject.Add('EnergyEff', FSubjectData.EnergyEff);
      jsSubject.Add('EnergyAdjAmt', FSubjectData.EnergyAdjAmt);
      jsSubject.Add('MiscDesc1', FSubjectData.MiscDesc1);
      jsSubject.Add('MiscAdjAmt1', FSubjectData.MiscAdjAmt1);
      jsSubject.Add('MiscDesc2', FSubjectData.MiscDesc2);
      jsSubject.Add('MiscAdjAmt2', FSubjectData.MiscAdjAmt2);
      jsSubject.Add('MiscDesc3', FSubjectData.MiscDesc3);
      jsSubject.Add('MiscAdjAmt3', FSubjectData.MiscAdjAmt3);
      jsSubject.Add('HasFireplaces', FSubjectData.HasFireplaces);
      jsSubject.Add('Fireplaces', FSubjectData.Fireplaces);
      jsSubject.Add('HasWoodstove', FSubjectData.HasWoodstove);
      jsSubject.Add('Woodstove', FSubjectData.Woodstove);
      jsSubject.Add('HasPatio', FSubjectData.HasPatio);
      jsSubject.Add('Patio', FSubjectData.Patio);
      jsSubject.Add('HasPool',FSubjectData.HasPool);
      jsSubject.Add('Pool', FSubjectData.Pool);
      jsSubject.Add('HasFence', FSubjectData.HasFence);
      jsSubject.Add('Fence', FSubjectData.Fence);
      jsSubject.Add('HasPorch', FSubjectData.HasPorch);
      jsSubject.Add('Porch', FSubjectData.Porch);
      jsSubject.Add('HasOtherAmenities', FSubjectData.HasOtherAmenities);
      jsSubject.Add('OtherAmenities', FSubjectData.OtherAmenities);
      jsSubject.Add('AdditionalFeatures', FSubjectData.AdditionalFeatures);
      jsSubject.Add('HeatingType', FSubjectData.HeatingType);
      jsSubject.Add('HeatingOther', FSubjectData.HeatingOther);
      jsSubject.Add('HeatingFuel', FSubjectData.HeatingFuel);
      jsSubject.Add('CoolingType', FSubjectData.CoolingType);
      jsSubject.Add('CoolingOther', FSubjectData.CoolingOther);
      jsSubject.Add('OccupancyType', FSubjectData.OccupancyType);
      jsSubject.Add('AssociationFeesAmount', FSubjectData.AssociationFeesAmount);
      jsSubject.Add('AssociationFeesType', FSubjectData.AssociationFeesType);
      jsSubject.Add('HasImprovementsWitihin15Years', FSubjectData.HasImprovementsWitihin15Years);
      jsSubject.Add('KitchenImprovementType', FSubjectData.KitchenImprovementType);
      jsSubject.Add('BathroomImprovementType', FSubjectData.BathroomImprovementType);
      jsSubject.Add('BathroomImprovementsYearsSinceCompletion', FSubjectData.BathroomImprovementsYearsSinceCompletion);
      jsSubject.Add('KitchenImprovementsYearsSinceCompletion', FSubjectData.KitchenImprovementsYearsSinceCompletion);
      jsSubject.Add('HomeownerInterviewNotes', FSubjectData.HomeownerInterviewNotes);
      jsSubject.Add('Dimensions', FSubjectData.Dimensions);
      jsSubject.Add('Area', FSubjectData.Area);
      jsSubject.Add('Shape', FSubjectData.Shape);
      jsSubject.Add('ViewFactor1', FSubjectData.ViewFactor1);
      jsSubject.Add('ViewFactor1Other', FSubjectData.ViewFactor1Other);
      jsSubject.Add('ViewFactor2', FSubjectData.ViewFactor2);
      jsSubject.Add('ViewFactor2Other', FSubjectData.ViewFactor2Other);
      jsSubject.Add('LocationFactor1', FSubjectData.LocationFactor1);
      jsSubject.Add('LocationFactor1Other', FSubjectData.LocationFactor1Other);
      jsSubject.Add('LocationFactor2', FSubjectData.LocationFactor2);
      jsSubject.Add('LocationFactor2Other', FSubjectData.LocationFactor2Other);
      jsSubject.Add('ViewInfluence', FSubjectData.ViewInfluence);
      jsSubject.Add('LocationInfluence', FSubjectData.LocationInfluence);
      jsSubject.Add('ElectricityType', FSubjectData.ElectricityType);
      jsSubject.Add('ElectricityOther', FSubjectData.ElectricityOther);
      jsSubject.Add('GasType', FSubjectData.GasType);
      jsSubject.Add('GasOther', FSubjectData.GasOther);
      jsSubject.Add('WaterType', FSubjectData.WaterType);
      jsSubject.Add('WaterOther', FSubjectData.WaterOther);
      jsSubject.Add('SewerOther', FSubjectData.SewerOther);
      jsSubject.Add('StreetType', FSubjectData.StreetType);
      jsSubject.Add('StreetDesc', FSubjectData.StreetDesc);
      jsSubject.Add('AlleyType', FSubjectData.AlleyType);
      jsSubject.Add('AlleyDesc', FSubjectData.AlleyDesc);
      jsSubject.Add('OffsiteImprovementsTypical', FSubjectData.OffsiteImprovementsTypical);
      jsSubject.Add('OffsiteImprovementsDescription', FSubjectData.OffsiteImprovementsDescription);
      jsSubject.Add('HasAdverseConditions', FSubjectData.HasAdverseConditions);
      jsSubject.Add('AdverseConditionsDescription', FSubjectData.AdverseConditionsDescription);
      jsSubject.Add('HasAttic', FSubjectData.HasAttic);
      jsSubject.Add('DropStairs', FSubjectData.DropStairs);
      jsSubject.Add('Stairs', FSubjectData.Stairs);
      jsSubject.Add('Scuttle', FSubjectData.Scuttle);
      jsSubject.Add('Floor',FSubjectData.Floor);
      jsSubject.Add('Finished', FSubjectData.Finished);
      jsSubject.Add('Heated', FSubjectData.Heated);
      jsSubject.Add('NeighborhoodName', FSubjectData.NeighborhoodName);
      jsSubject.Add('LocationType', FSubjectData.LocationType);
      jsSubject.Add('BuiltUpType', FSubjectData.BuiltUpType);
      jsSubject.Add('GrowthType', FSubjectData.GrowthType);
      jsSubject.Add('PluOneUnit', FSubjectData.PluOneUnit);
      jsSubject.Add('Plu24Units', FSubjectData.Plu24Units);
      jsSubject.Add('PluMultiFamily', FSubjectData.PluMultiFamily);
      jsSubject.Add('PluCommercial', FSubjectData.PluCommercial);
      jsSubject.Add('PluOther', FSubjectData.PluOther);
      jsSubject.Add('PluOtherCount', FSubjectData.PluOtherCount);
      jsSubject.Add('BoundaryDescription', FSubjectData.BoundaryDescription);
      jsSubject.Add('NeighborhoodDescription', FSubjectData.NeighborhoodDescription);
      jsSubject.Add('InspectionInstructions', FSubjectData.InspectionInstructions);
      jsSubject.Add('ExteriorWallsMaterial', FSubjectData.ExteriorWallsMaterial);
      jsSubject.Add('ExteriorWallsCondition', FSubjectData.ExteriorWallsCondition);
      jsSubject.Add('RoofSurfaceMaterial', FSubjectData.RoofSurfaceMaterial);
      jsSubject.Add('RoofSurfaceCondition', FSubjectData.RoofSurfaceCondition);
      jsSubject.Add('GuttersMaterial', FSubjectData.GuttersMaterial);
      jsSubject.Add('GuttersCondition', FSubjectData.GuttersCondition);
      jsSubject.Add('WindowTypeMaterial', FSubjectData.WindowTypeMaterial);
      jsSubject.Add('WindowTypeCondition', FSubjectData.WindowTypeCondition);
      jsSubject.Add('StormSashMaterial', FSubjectData.StormSashMaterial);
      jsSubject.Add('StormSashCondition', FSubjectData.StormSashCondition);
      jsSubject.Add('ScreensMaterial', FSubjectData.ScreensMaterial);

      jsSubject.Add('ScreensCondition', FSubjectData.ScreensCondition);
      jsSubject.Add('FloorsMaterial', FSubjectData.FloorsMaterial);
      jsSubject.Add('FloorsCondition', FSubjectData.FloorsCondition);
      jsSubject.Add('WallsMaterial', FSubjectData.WallsMaterial);
      jsSubject.Add('WallsCondition', FSubjectData.WallsCondition);
      jsSubject.Add('TrimMaterial', FSubjectData.TrimMaterial);
      jsSubject.Add('TrimCondition', FSubjectData.TrimCondition);
      jsSubject.Add('BathFloorsMaterial', FSubjectData.BathFloorsMaterial);
      jsSubject.Add('BathFloorsCondition', FSubjectData.BathFloorsCondition);
      jsSubject.Add('BathWainscotMaterial', FSubjectData.BathWainscotMaterial);
      jsSubject.Add('BathWainscotCondition', FSubjectData.BathWainscotCondition);

      //more fields...
      jsSubject.Add('ConcreteSlab', FSubjectData.ConcreteSlab);
      jsSubject.Add('CrawlSpace', FSubjectData.CrawlSpace);
      jsSubject.Add('HasPumpSump', FSubjectData.HasPumpSump);
      jsSubject.Add('EvidenceOfDampness', FSubjectData.EvidenceOfDampness);
      jsSubject.Add('EvidenceOfSettlement', FSubjectData.EvidenceOfSettlement);
      jsSubject.Add('EvidenceOfInfestation', FSubjectData.EvidenceOfInfestation);
      jsSubject.Add('FoundationWallMaterial', FSubjectData.FoundationWallMaterial);
      jsSubject.Add('FoundationWallCondition', FSubjectData.FoundationWallCondition);

      jsSubject.Add('TotalArea', FSubjectData.TotalArea);
      jsSubject.Add('FinishedArea', FSubjectData.FinishedArea);
      jsSubject.Add('FinishedPercent', FSubjectData.FinishedPercent);
      jsSubject.Add('BasementBedrooms', FSubjectData.BasementBedrooms);
      jsSubject.Add('BasementFullBaths', FSubjectData.BasementFullBaths);
      jsSubject.Add('BasementHalfBaths', FSubjectData.BasementHalfBaths);
      jsSubject.Add('BasementRecRooms', FSubjectData.BasementRecRooms);
      jsSubject.Add('BasementOtherRooms', FSubjectData.BasementOtherRooms);
      jsSubject.Add('AccessMethodWalkUp', FSubjectData.AccessMethodWalkUp);
      jsSubject.Add('AccessMethodWalkOut', FSubjectData.AccessMethodWalkOut);
      jsSubject.Add('AccessMethodInteriorOnly', FSubjectData.AccessMethodInteriorOnly);
      jsSubject.Add('BasementType', FSubjectData.BasementType);

      jsSubject.Add('ConditionRatingTypes', FSubjectData.ConditionRatingTypes);
      jsSubject.Add('ConstractionRatingTypes', FSubjectData.ConstractionRatingTypes);
      jsSubject.Add('ConditionCommentDescription', FSubjectData.ConditionCommentDescription);
      jsSubject.Add('ConditionCommentAdverse', FSubjectData.ConditionCommentAdverse);
      jsSubject.Add('ConditionCommentNeighborhood ', FSubjectData.ConditionCommentNeighborhood );

      jsSubject.Add('GarageIsAttached', FSubjectData.GarageIsAttached );
      jsSubject.Add('GarageIsDetached', FSubjectData.GarageIsDetached);
      jsSubject.Add('GarageIsBuiltin', FSubjectData.GarageIsBuiltin);
      jsSubject.Add('CarportCars', FSubjectData.CarportCars);
      jsSubject.Add('CarportIsAttached', FSubjectData.CarportIsAttached);
      jsSubject.Add('CarportIsDetached', FSubjectData.CarportIsDetached);
      jsSubject.Add('CarportIsBuiltin', FSubjectData.CarportIsBuiltin);
      jsSubject.Add('GarageCars', FSubjectData.GarageCars);

      //Appliances
      jsSubject.Add('HasRefrigerator', FSubjectData.HasRefrigerator);
      jsSubject.Add('HasRangeOwen', FSubjectData.HasRangeOwen);
      jsSubject.Add('HasWasherDryer', FSubjectData.HasWasherDryer);
      jsSubject.Add('HasMicrowave', FSubjectData.HasMicrowave);
      jsSubject.Add('HasDishWasher', FSubjectData.HasDishWasher);
      jsSubject.Add('HasDisposal', FSubjectData.HasDisposal);
      jsSubject.Add('HasOtherAppliances', FSubjectData.HasOtherAppliances);
      jsSubject.Add('OtherAppliances', FSubjectData.OtherAppliances);
      jsSubject.Add('CarportIsAttached', FSubjectData.CarportIsAttached);
      jsSubject.Add('CarportIsAttached', FSubjectData.CarportIsAttached);
      jsSubject.Add('CarportIsAttached', FSubjectData.CarportIsAttached);
  end;
  //TODO: not used any more... need to make sure mobile app also not to look for Photos... before we remove
  jsPhotos := TlkJSONList.Create;
  try
    jsSubject.Add('Photos', jsPhotos);
  finally
  end;
end;


//github #596: This will get data from the buffer FSubjectData to add to the jsSubject json object
procedure TCC_Mobile_Inspection.DoUploadSubjectDataJson_V2(var jsSubject:TlkJSONObject);
var
  inspDateStr, dueDateStr, isFHAStr: String;
  DateTimeStr: String;
  aInt: Integer;
  jsPhoto: TlkJSONObject;
  jsPhotos: TlkJSONList;
  imagebase64, imagebase64AFTER: String;
  isNew: Boolean;
  aDateTime: TDateTime;
  skipNone: Boolean;
  aCell: TBaseCell;
begin
  if jsSubject = nil then
    jsSubject := TlkJsonObject.create(true);
  aInt := 0;
  isNew := CompareText(FUploadInfo2.Status, 'N') = 0;
//  jsSubject.Add('VersionNumber', FSubjectData2.VersionNumber);
  //Load assignment

  postJsonStr('AppraisalFileNumber', FSubjectData2.AppraisalFileNumber, jsSubject);
  postJsonStr('PropertyType', FSubjectData2.PropertyType, jsSubject);
  postJsonBool('IsFha', FSubjectData2.IsFHA, jsSubject);
  postJsonStr('InspectionScheduleDate', FSubjectData2.InspectionScheduleDate, jsSubject);
  postJsonStr('InspectionScheduleTime', FSubjectData2.InspectionScheduleTime, jsSubject);

  //Load Subject main info
  postJsonStr('Address', FSubjectData2.Address, jsSubject);
  postJsonStr('UnitNumber', FSubjectData2.UnitNumber, jsSubject);
  postJsonStr('City', FSubjectData2.City, jsSubject);
  postJsonStr('State', FSubjectData2.State, jsSubject);
  postJsonStr('ZipCode', FSubjectData2.ZipCode, jsSubject);

  postJsonFloat('Latitude', FSubjectData2.Latitude, jsSubject);
  postJsonFloat('Longitude', FSubjectData2.Longitude, jsSubject);

  postJsonInt('TotalRooms', FSubjectData2.TotalRooms, jsSubject, False);  //Ticket #1382 need to show 0 on push down
  postJsonInt('Bedrooms', FSubjectData2.Bedrooms, jsSubject);
  postJsonInt('FullBaths', FSubjectData2.FullBaths, jsSubject);
  postJsonInt('HalfBaths', FSubjectData2.HalfBaths, jsSubject);
  postJsonStr('Gla', FSubjectData2.GLA, jsSubject);
  postJsonStr('Design', FSubjectData2.Design, jsSubject);
  postJsonFloat('Stories', FSubjectData2.Stories, jsSubject);
  postJsonInt('YearBuilt', FSubjectData2.YearBuilt, jsSubject);

  postJsonStr('ActualAge', FSubjectData2.ActualAge, jsSubject);
  postJsonStr('EffectiveAge', FSubjectData2.EffectiveAge, jsSubject);
  if FSubjectData2.SubjectType <> -1 then
    postJsonInt('SubjectType', FSubjectData2.SubjectType, jsSubject, False);   //can be zero
  if FSubjectData2.StructureType <> -1 then
    postJsonInt('StructureType', FSubjectData2.StructureType, jsSubject, False);  //can be zero
  if FSubjectData2.ConstructionType <> -1 then
    postJsonInt('ConstructionType', FSubjectData2.ConstructionType, jsSubject, False); //can be zero

  skipNone := False;
  if FSubjectData2.CarStorageNone then
    begin //even it's set to false, need to look at dw, gar, carport to reset
      skipNone := not (FSubjectData2.Driveway and FSubjectData2.Garage and FSubjectData2.Carport);
      skipNone := skipNone and
                 ((FSubjectData2.DrivewayCars = 0) and (FSubjectData2.GarageCars = 0) and (FSubjectData2.CarportCars = 0));

    end;
  if not skipNone then
    postJsonBool('CarStorageNone', FSubjectData2.CarStorageNone, jsSubject);

  postJsonBool('Driveway', FSubjectData2.Driveway, jsSubject);
  postJsonInt('DrivewayCars', FSubjectData2.DrivewayCars, jsSubject, False);
  postJsonStr('DrivewaySurface', FSubjectData2.DrivewaySurface, jsSubject);

  postJsonBool('Garage', FSubjectData2.Garage, jsSubject);

  postJsonBool('GarageAttachedCars', FSubjectData2.GarageAttachedCars, jsSubject);
  postJsonBool('GarageDetachedCars', FSubjectData2.GarageDetachedCars, jsSubject);
  postJsonBool('GarageBuiltincars', FSubjectData2.GarageBuiltincars, jsSubject);
  postJsonBool('Carport', FSubjectData2.Carport, jsSubject);

  postJsonBool('CarportAttachedCars', FSubjectData2.CarportAttachedCars, jsSubject);
  postJsonBool('CarportDetachedCars', FSubjectData2.CarportDetachedCars, jsSubject);
  postJsonBool('CarportBuiltInCars', FSubjectData2.CarportBuiltInCars, jsSubject);
  postJsonInt('GarageCars', FSubjectData2.GarageCars, jsSubject, False);
  postJsonInt('CarportCars', FSubjectData2.CarportCars, jsSubject, False);
  aInt := FSubjectData2.ConditionRating;
  if aInt > 0 then
    begin
      aInt := aInt - 1;
      postJsonInt('ConditionRating', aInt, jsSubject, False);   //can be zero
    end;
  aInt := FSubjectData2.QualityRating;
  if aInt > 0 then
    begin
      aInt := aInt - 1;
      postJsonInt('QualityRating', aInt, jsSubject, False);   //can be zero
    end;
  postJsonStr('ConditionCommentDescription', FSubjectData2.ConditionCommentDescription, jsSubject);
  postJsonStr('ConditionCommentAdverse', FSubjectData2.ConditionCommentAdverse, jsSubject);
  postJsonStr('ConditionCommentNeighborhood', FSubjectData2.ConditionCommentNeighborhood, jsSubject);

  postJsonStr('FunctionalUtility', FSubjectData2.FunctionalUtility, jsSubject);
  //Ticket #1382: when amt is 0 check if the name is not EMPTY then push down
  if trim(FSubjectData2.FunctionalUtility) <> '' then
    postJsonInt('FunctionalAdjAmt', FSubjectData2.FunctionalAdjAmt, jsSubject, False);

  postJsonStr('EnergyEff', FSubjectData2.EnergyEff, jsSubject);
  //Ticket #1382: when amt is 0 check if the name is not EMPTY then push down
  if trim(FSubjectData2.EnergyEff) <> '' then
    postJsonInt('EnergyAdjAmt', FSubjectData2.EnergyAdjAmt, jsSubject, False);

  postJsonStr('MiscDesc1', FSubjectData2.MiscDesc1, jsSubject);
  //Ticket #1382: when amt is 0 check if the name is not EMPTY then push down
  if trim(FSubjectData2.MiscDesc1) <> '' then
    postJsonInt('MiscAdjAmt1', FSubjectData2.MiscAdjAmt1, jsSubject, False);

  postJsonStr('MiscDesc2', FSubjectData2.MiscDesc2, jsSubject);
  //Ticket #1382: when amt is 0 check if the name is not EMPTY then push down
  if trim(FSubjectData2.MiscDesc2) <> '' then
    postJsonInt('MiscAdjAmt2', FSubjectData2.MiscAdjAmt2, jsSubject, False);

  postJsonStr('MiscDesc3', FSubjectData2.MiscDesc3, jsSubject);
  //Ticket #1382: when amt is 0 check if the name is not EMPTY then push down
  if trim(FSubjectData2.MiscDesc3) <> '' then
    postJsonInt('MiscAdjAmt3', FSubjectData2.MiscAdjAmt3, jsSubject, False);

  postJsonBool('HasFireplaces', FSubjectData2.HasFireplaces, jsSubject);
  postJsonInt('Fireplaces', FSubjectData2.Fireplaces, jsSubject, False);  //Ticket #1382: push down 0 if edit cell has 0
  postJsonBool('HasWoodstove', FSubjectData2.HasWoodstove, jsSubject);
  postJsonInt('Woodstove', FSubjectData2.Woodstove, jsSubject, False);   //Ticket #1382: push down 0 if edit cell has 0
  postJsonBool('HasPatio', FSubjectData2.HasPatio, jsSubject);
  postJsonStr('Patio', FSubjectData2.Patio, jsSubject);
  postJsonBool('HasPool', FSubjectData2.HasPool, jsSubject);
  postJsonStr('Pool', FSubjectData2.Pool, jsSubject);
  postJsonBool('HasFence', FSubjectData2.HasFence, jsSubject);
  postJsonStr('Fence', FSubjectData2.Fence, jsSubject);
  postJsonBool('HasPorch', FSubjectData2.HasPorch, jsSubject);
  postJsonStr('Porch', FSubjectData2.Porch, jsSubject);
  postJsonBool('HasOtherAmenities', FSubjectData2.HasOtherAmenities, jsSubject);
  postJsonStr('OtherAmenities', FSubjectData2.OtherAmenities, jsSubject);
  postJsonStr('AdditionalFeatures', FSubjectData2.AdditionalFeatures, jsSubject);
  postJsonBool('HasRefrigerator', FSubjectData2.HasRefrigerator, jsSubject);
  postJsonBool('HasRangeOwen', FSubjectData2.HasRangeOwen, jsSubject);
  postJsonBool('HasWasherDryer', FSubjectData2.HasWasherDryer, jsSubject);
  postJsonBool('HasMicrowave', FSubjectData2.HasMicrowave, jsSubject);
  postJsonBool('HasDishWasher', FSubjectData2.HasDishWasher, jsSubject);
  postJsonBool('HasDisposal', FSubjectData2.HasDisposal, jsSubject);
  postJsonBool('HasOtherAppliances', FSubjectData2.HasOtherAppliances, jsSubject);
  postJsonStr('OtherAppliances', FSubjectData2.OtherAppliances, jsSubject);

  if FSubjectData2.HeatingType <> -1 then
    postJsonInt('HeatingType', FSubjectData2.HeatingType, jsSubject, False);
  postJsonStr('HeatingOther', FSubjectData2.HeatingOther, jsSubject);
  postJsonStr('HeatingFuel', FSubjectData2.HeatingFuel, jsSubject);

  if FSubjectData2.CoolingType <> -1 then
    postJsonInt('CoolingType', FSubjectData2.CoolingType, jsSubject, False);
  postJsonStr('CoolingOther', FSubjectData2.CoolingOther, jsSubject);

  if FSubjectData2.OccupancyType <> -1 then
    postJsonInt('OccupancyType', FSubjectData2.OccupancyType, jsSubject, False);
  if FSubjectData2.AssociationFeesAmount > 0 then
    postJsonInt('AssociationFeesAmount', FSubjectData2.AssociationFeesAmount, jsSubject);
  if FSubjectData2.AssociationFeesType <> -1 then
    postJsonInt('AssociationFeesType', FSubjectData2.AssociationFeesType, jsSubject, False);
  postJsonBool('HasImprovementsWitihin15Years', FSubjectData2.HasImprovementsWitihin15Years, jsSubject);
  if FSubjectData2.KitchenImprovementType <> -1 then
    postJsonInt('KitchenImprovementType', FSubjectData2.KitchenImprovementType, jsSubject, False);
  if FSubjectData2.BathroomImprovementType <> -1 then
    postJsonInt('BathroomImprovementType', FSubjectData2.BathroomImprovementType, jsSubject, False);
  postJsonStr('BathroomImprovementsYearsSinceCompletion', FSubjectData2.BathroomImprovementsYearsSinceCompletion, jsSubject);
  postJsonStr('KitchenImprovementsYearsSinceCompletion', FSubjectData2.KitchenImprovementsYearsSinceCompletion, jsSubject);
  postJsonStr('HomeownerInterviewNotes', FSubjectData2.HomeownerInterviewNotes, jsSubject);
  postJsonStr('Dimensions', FSubjectData2.Dimensions, jsSubject);
  postJsonStr('Area', FSubjectData2.SiteArea, jsSubject);
  postJsonStr('Shape', FSubjectData2.Shape, jsSubject);
  postJsonStr('ViewFactor1', FSubjectData2.ViewFactor1, jsSubject);
  postJsonStr('ViewFactor1Other', FSubjectData2.ViewFactor1Other, jsSubject);
  postJsonStr('ViewFactor2', FSubjectData2.ViewFactor2, jsSubject);
  postJsonStr('ViewFactor2Other', FSubjectData2.ViewFactor2Other, jsSubject);
  postJsonStr('LocationFactor1', FSubjectData2.LocationFactor1, jsSubject);
  postJsonStr('LocationFactor1Other', FSubjectData2.LocationFactor1Other, jsSubject);
  postJsonStr('LocationFactor2', FSubjectData2.LocationFactor2, jsSubject);
  postJsonStr('LocationFactor2Other', FSubjectData2.LocationFactor2Other, jsSubject);

  if FSubjectData2.ViewInfluence <> -1 then
    postJsonInt('ViewInfluence', FSubjectData2.ViewInfluence, jsSubject, False);
  if FSubjectData2.LocationInfluence <> -1 then
    postJsonInt('LocationInfluence', FSubjectData2.LocationInfluence, jsSubject, False);
  if FSubjectData2.ElectricityType <> -1 then
    postJsonInt('ElectricityType', FSubjectData2.ElectricityType, jsSubject, False);
  postJsonStr('ElectricityOther', FSubjectData2.ElectricityOther, jsSubject);
  if FSubjectData2.GasType <> -1 then
    postJsonInt('GasType', FSubjectData2.GasType, jsSubject, False);
  postJsonStr('GasOther', FSubjectData2.GasOther, jsSubject);
  if FSubjectData2.WaterType <> -1 then
    postJsonInt('WaterType', FSubjectData2.WaterType, jsSubject, False);
  postJsonStr('WaterOther', FSubjectData2.WaterOther, jsSubject);
  if FSubjectData2.SewerType <> -1 then
    postJsonInt('SewerType', FSubjectData2.SewerType, jsSubject, False);
  postJsonStr('SewerOther', FSubjectData2.SewerOther, jsSubject);
  if FSubjectData2.StreetType <> -1 then
    postJsonInt('StreetType', FSubjectData2.StreetType, jsSubject, False);
  postJsonStr('StreetDesc', FSubjectData2.StreetDesc, jsSubject);
  if FSubjectData2.AlleyType <> -1 then
    postJsonInt('AlleyType', FSubjectData2.AlleyType, jsSubject, False);
  postJsonStr('AlleyDesc', FSubjectData2.AlleyDesc, jsSubject);

  if FSubjectData2.OffsiteImprovementsTypical <> -1 then
    postJsonInt('OffsiteImprovementsTypical', FSubjectData2.OffsiteImprovementsTypical, jsSubject, False);
  postJsonStr('OffsiteImprovementsDescription', FSubjectData2.OffsiteImprovementsDescription, jsSubject);

  if FSubjectData2.HasAdverseConditions <> -1 then
    postJsonInt('HasAdverseConditions', FSubjectData2.HasAdverseConditions, jsSubject, False);
  postJsonStr('AdverseConditionsDescription', FSubjectData2.AdverseConditionsDescription, jsSubject);

  if FSubjectData2.HasAttic then  //even this is true but the other items are false then set to false
    begin
      FSubjectData2.HasAttic := FSubjectData2.DropStairs or FSubjectData2.Stairs or
                                FSubjectData2.Scuttle or FSubjectData2.Floor or
                                FSubjectData2.Finished or FSubjectData2.Heated;
    end;
  postJsonBool('HasAttic', FSubjectData2.HasAttic, jsSubject);
  postJsonBool('DropStairs', FSubjectData2.DropStairs, jsSubject);
  postJsonBool('Stairs', FSubjectData2.Stairs, jsSubject);
  postJsonBool('Scuttle', FSubjectData2.Scuttle, jsSubject);
  postJsonBool('Floor', FSubjectData2.Floor, jsSubject);
  postJsonBool('Finished', FSubjectData2.Finished, jsSubject);
  postJsonBool('Heated', FSubjectData2.Heated, jsSubject);
  postJsonStr('NeighborhoodName', FSubjectData2.NeighborhoodName, jsSubject);

  if FSubjectData2.LocationType <> -1 then
    postJsonInt('LocationType', FSubjectData2.LocationType, jsSubject, False);
  if FSubjectData2.BuiltUpType <> -1 then
    postJsonInt('BuiltUpType', FSubjectData2.BuiltUpType, jsSubject, False);
  if FSubjectData2.GrowthType <> -1 then
    postJsonInt('GrowthType', FSubjectData2.GrowthType, jsSubject, False);
  postJsonInt('PluOneUnit', FSubjectData2.PluOneUnit, jsSubject);
  postJsonInt('Plu24Units', FSubjectData2.Plu24Units, jsSubject);
  postJsonInt('PluMultiFamily', FSubjectData2.PluMultiFamily, jsSubject);
  postJsonInt('PluCommercial', FSubjectData2.PluCommercial, jsSubject);
  postJsonStr('PluOther', FSubjectData2.PluOther, jsSubject);
  if FSubjectData2.PluOtherCount <> 0 then
    postJsonInt('PluOtherCount', FSubjectData2.PluOtherCount, jsSubject);
  postJsonStr('BoundaryDescription', FSubjectData2.BoundaryDescription, jsSubject);
  postJsonStr('NeighborhoodDescription', FSubjectData2.NeighborhoodDescription, jsSubject);

  //Primary/Alternate Contact
  postJsonStr('Name', FSubjectData2.PrimaryName, jsSubject);
  postJsonStr('HomeNumber', FSubjectData2.PrimaryHomeNo, jsSubject);
  postJsonStr('MobileNumber', FSubjectData2.PrimaryMobileNo, jsSubject);
  postJsonStr('WorkNumber', FSubjectData2.PrimaryWorkNo, jsSubject);
  postJsonStr('OtherText', FSubjectData2.PrimaryOther, jsSubject);

  postJsonStr('AltName', FSubjectData2.AlternateName, jsSubject);
  postJsonStr('AltHomeNumber', FSubjectData2.AlternateHomeNo, jsSubject);
  postJsonStr('AltMobileNumber', FSubjectData2.AlternateMobileNo, jsSubject);
  postJsonStr('AltWorkNumber', FSubjectData2.AlternateWorkNo, jsSubject);
  postJsonStr('AltOtherText', FSubjectData2.AlternateOther, jsSubject);
  postJsonStr('InspectionInstructions', FSubjectData2.InspectionInstructions, jsSubject);

  if FSubjectData2.PrimaryContactType <> -1 then
    postJsonInt('PrimaryContactType', FSubjectData2.PrimaryContactType, jsSubject, False);
  if FSubjectData2.AlternateContactType <> -1 then
    postJsonInt('AlternateContactType', FSubjectData2.AlternateContactType, jsSubject, False);

  postJsonStr('ExteriorWallsMaterial', FSubjectData2.ExteriorWallsMaterial, jsSubject);
  postJsonStr('ExteriorWallsCondition', FSubjectData2.ExteriorWallsCondition, jsSubject);
  postJsonStr('RoofSurfaceMaterial', FSubjectData2.RoofSurfaceMaterial, jsSubject);
  postJsonStr('RoofSurfaceCondition', FSubjectData2.RoofSurfaceCondition, jsSubject);
  postJsonStr('GuttersMaterial', FSubjectData2.GuttersMaterial, jsSubject);
  postJsonStr('GuttersCondition', FSubjectData2.GuttersCondition, jsSubject);
  postJsonStr('WindowTypeMaterial', FSubjectData2.WindowTypeMaterial, jsSubject);
  postJsonStr('WindowTypeCondition', FSubjectData2.WindowTypeCondition, jsSubject);
  postJsonStr('StormSashMaterial', FSubjectData2.StormSashMaterial, jsSubject);
  postJsonStr('StormSashCondition', FSubjectData2.StormSashCondition, jsSubject);
  postJsonStr('ScreensMaterial', FSubjectData2.ScreensMaterial, jsSubject);
  postJsonStr('ScreensCondition', FSubjectData2.ScreensCondition, jsSubject);
  postJsonStr('FloorsMaterial', FSubjectData2.FloorsMaterial, jsSubject);
  postJsonStr('FloorsCondition', FSubjectData2.FloorsCondition, jsSubject);
  postJsonStr('WallsMaterial', FSubjectData2.WallsMaterial, jsSubject);
  postJsonStr('WallsCondition', FSubjectData2.WallsCondition, jsSubject);
  postJsonStr('TrimMaterial', FSubjectData2.TrimMaterial, jsSubject);
  postJsonStr('TrimCondition', FSubjectData2.TrimCondition, jsSubject);
  postJsonStr('BathFloorsMaterial', FSubjectData2.BathFloorsMaterial, jsSubject);
  postJsonStr('BathFloorsCondition', FSubjectData2.BathFloorsCondition, jsSubject);
  postJsonStr('BathWainscotMaterial', FSubjectData2.BathWainscotMaterial, jsSubject);
  postJsonStr('BathWainscotCondition', FSubjectData2.BathWainscotCondition, jsSubject);

      //more fields...
  postJsonBool('ConcreteSlab', FSubjectData2.ConcreteSlab, jsSubject);
  postJsonBool('CrawlSpace', FSubjectData2.CrawlSpace, jsSubject);
  postJsonBool('HasPumpSump', FSubjectData2.HasPumpSump, jsSubject);
  postJsonBool('EvidenceOfDampness', FSubjectData2.EvidenceOfDampness, jsSubject);
  postJsonBool('EvidenceOfSettlement', FSubjectData2.EvidenceOfSettlement, jsSubject);
  postJsonBool('EvidenceOfInfestation', FSubjectData2.EvidenceOfInfestation, jsSubject);
  postJsonStr('FoundationWallMaterial', FSubjectData2.FoundationWallMaterial, jsSubject);
  postJsonStr('FoundationWallCondition', FSubjectData2.FoundationWallCondition, jsSubject);

  postJsonStr('TotalArea', FSubjectData2.TotalArea, jsSubject);
  postJsonInt('FinishedArea', FSubjectData2.FinishedArea, jsSubject, False);  //Ticket #1382: push down 0 if edit cell has 0
  postJsonInt('FinishedPercent', FSubjectData2.FinishedPercent, jsSubject, False); //Ticket #1382: push down 0 if edit cell has 0
  postJsonInt('BasementBedrooms', FSubjectData2.BasementBedrooms, jsSubject, False);  //Ticket #1382: push down 0 if edit cell has 0
  postJsonInt('BasementFullBaths', FSubjectData2.BasementFullBaths, jsSubject, False);  //Ticket #1382: push down 0 if edit cell has 0
  postJsonInt('BasementHalfBaths', FSubjectData2.BasementHalfBaths, jsSubject, False);  //Ticket #1382: push down 0 if edit cell has 0
  postJsonInt('BasementRecRooms', FSubjectData2.BasementRecRooms, jsSubject, False);  //Ticket #1382: push down 0 if edit cell has 0
  postJsonInt('BasementOtherRooms', FSubjectData2.BasementOtherRooms, jsSubject, False);  //Ticket #1382: push down 0 if edit cell has 0

  postJsonBool('AccessMethodWalkUp', FSubjectData2.AccessMethodWalkUp, jsSubject);
  postJsonBool('AccessMethodWalkOut', FSubjectData2.AccessMethodWalkOut, jsSubject);
  postJsonBool('AccessMethodInteriorOnly', FSubjectData2.AccessMethodInteriorOnly, jsSubject);

  if FSubjectData2.BasementType <> -1 then
    postJsonInt('BasementType', FSubjectData2.BasementType, jsSubject, False);
  if FSubjectData2.StartTime = '' then
    FSubjectData2.StartTime := FormatDateTime('hh:mm', now);
  if FSubjectData2.EndTime = '' then
    FSubjectData2.EndTime := FormatDateTime('hh:mm', now);
  postJsonStr('StartTime', FSubjectData2.StartTime, jsSubject);
  postJsonStr('EndTime', FSubjectData2.EndTime, jsSubject);
  postJsonStr('SummaryNote', FSubjectData2.SummaryNote, jsSubject);

  if FSubjectData2.AdverseSiteConditionPresent = 1 then
    postJsonBool('AdverseSiteConditionPresent', true, jsSubject) //Ticket #1538: new tag
  else if FSubjectData2.AdverseSiteConditionPresent = 0 then   //skip null
    begin
      if FDoc.GetCellTextByID(2035) = 'X' then
        postJsonBool('AdverseSiteConditionPresent', false, jsSubject); //Ticket #1538: new tag
    end;

  if FSubjectData2.PropertyConformsToNeighborhood = 1 then
    postJsonBool('PropertyConformsToNeighborhood', true, jsSubject)  //Ticket #1538: new tag
  else if FSubjectData2.PropertyConformsToNeighborhood = 0 then  //can be null
    begin
      if FDoc.GetCellTextByID(505) = 'X' then
        postJsonBool('PropertyConformsToNeighborhood', false, jsSubject);  //Ticket #1538: new tag
    end;
end;




procedure TCC_Mobile_Inspection.DoUploadCompsDataJson_V2(var jsComps:TlkJSONList);
var
  i:Integer;
  str: String;
  jsc:TlkJSONObject;
  ga, gd, gbi, cp: String;
  aBoolean: Boolean;
  aFactor1, aFactor1Other, aFactor2, aFactor2Other:String;
  sStories: String;
  aViewInfl, aLocInfl, aInt{, aStories}: Integer;
  aDesign, aStructure: String;
  aDouble, aStories: Double;

begin
    if jsComps = nil then
      jsComps := TlkJSonList.Create;
    try
      //walk through sales grid
      for i := 1 to Compgrid.Rows do
        begin
          if Compgrid.CellCheckBoxState[1,i] = cbChecked then
            begin
             jsc := TlkJSONObject.Create(true);
             try
               str := Compgrid.Cell[_Address,i];
               //ticket #1027:  donot skip empty address: if str = '' then continue; //skip to the next row if EMPTY address
               postJsonStr('Address', str, jsc);
               str := Compgrid.Cell[_UnitNo, i];
               postJsonStr('UnitNumber', str, jsc);
               str := Compgrid.Cell[_City,i];
               postJsonStr('City', str, jsc);
               str := Compgrid.Cell[_State,i];
               postJsonStr('State', str, jsc);
               str := Compgrid.Cell[_Zip,i];
               postJsonStr('ZipCode', str, jsc);

               str := CompGrid.Cell[_TypeID, i];
               postJsonStr('CompType', str, jsc);
               str := Compgrid.Cell[_SiteArea,i];
               postJsonStr('SiteArea', str, jsc);
               aDouble := GetStrDouble(Compgrid.Cell[_Latitude, i]);
               postJsonFloat('Latitude', aDouble,jsc,False);
               aDouble := GetStrDouble(Compgrid.Cell[_Longitude, i]);
               postJsonFloat('Longitude', aDouble, jsc, False);
               aInt := GetStrInt(CompGrid.Cell[_ABTotal, i]);   //Ticket #1382
               postJsonInt('ABTotal', aInt, jsc, False);
               aInt := GetStrInt(Compgrid.Cell[_ABBed,i]);
               postJsonInt('ABBed', aInt, jsc, False);
               aInt := GetStrInt(Compgrid.Cell[_ABBath,i]);
               postJsonInt('ABBath', aInt, jsc, False);
               aInt := GetStrInt(Compgrid.Cell[_ABHalf,i]);
               postJsonInt('ABHalf', aInt, jsc, False);
               aInt := GetStrInt(Compgrid.Cell[_GLA,i]);
               postJsonInt('Gla', aInt, jsc, False);

               str := Compgrid.Cell[_Design, i];
               aDesign  := ''; //github 1112: clear before set
               sStories := ''; aStructure := '';
               if pos(';', str) > 0 then //we have style
                 begin
                   aStructure := popStr(str, ';');
                   if aStructure <> '' then  //github #44
                     begin
                       if (pos('DT', Uppercase(aStructure)) >  0) or
                         (pos('AT', UpperCase(aStructure)) > 0) or
                         (pos('SD', UpperCase(aStructure)) > 0) then
                        begin
                          sStories := copy(aStructure, 3, length(aStructure));
                        end
                       else
                         sStories := aStructure;

                       aStories := GetStrDouble(sStories);
                     end;
                   aDesign  := str;
                 end
               else
                 begin
                   aStructure := popStr(str, ';');
                   aStories := GetStrValue(aDesign);
                 end;
                 aStructure := UpperCase(aStructure);
                 if pos('DT', aStructure) > 0 then
                   aInt := stDetach
                 else if pos('AT', aStructure) > 0 then
                   aInt := stAttach
                 else if pos('SD', aStructure) > 0 then
                   aInt := stEndUnit
                 else
                   aInt := -1;
                //if aStories = 0 then aStories := 1; //github 1112: donot default to 1
                if aInt <> -1 then
                  postJsonInt('StructureType', aInt, jsc, False);
                postJsonStr('Design', aDesign, jsc);
                postJsonFloat('Stories', aStories, jsc, False);

               aInt := GetStrInt(Compgrid.Cell[_YearBuilt,i]);
               postJsonInt('YearBuilt', aInt, jsc, False);

               str := Compgrid.Cell[_ActualAge,i];
               postJsonStr('ActualAge', str, jsc);

               aBoolean := Compgrid.Cell[_None,i];
               postJsonBool('None', aBoolean, jsc);
               str := Compgrid.Cell[_DrivewayCars,i];
               if pos('dw', str) > 0 then
                 begin
                   jsc.Add('Driveway', True);
                   aInt := GetStrInt(popStr(str, 'dw'));
                   postJsonInt('DrivewayCars', aInt, jsc, False);
                 end
               else
                 begin
                   postJsonBool('Driveway', False, jsc);
                 end;
              str := Compgrid.Cell[_DrivewaySurface,i];
              postJsonStr('DrivewaySurface', str, jsc);

              str := Compgrid.Cell[_GarCar,i];
              if (lowerCase(str) <> 'none') and (length(str) > 0) then
                postJsonBool('Garage', True, jsc)
              else
                postJsonBool('Garage', False, jsc);

              str := Compgrid.Cell[_CarportCount,i];
              if pos('cp', str) > 0 then
                postJsonBool('Carport', True, jsc)
              else
                postJsonBool('Carport', False, jsc);

              str := Compgrid.Cell[_GarCar,i];
              if str <> '' then  begin
              if pos('ga', str) > 0 then
                begin
                  ga := popStr(str, 'ga');
                  while str <> '' do
                    begin
                      if pos(';', str) > 0 then
                        begin
                          if pos('gd', str) > 0 then
                            gd := popStr(str, 'gd'); //might have ga;gd;gbi
                          if pos('gbi', str) > 0 then
                            gbi := popStr(str, 'gbi');
                        end;
                    end;
                end;
              if pos('gd', str) > 0 then
                begin
                  gd := popStr(str, 'gd');
                  while str <> '' do
                    begin
                      if pos(';', str) > 0 then
                        begin
                          if pos('ga', str) > 0 then
                            ga := popStr(str, 'ga');
                          if pos('gbi', str) > 0 then
                            gbi := popStr(str, 'gbi');
                        end;
                    end;
                end;
              if pos('gbi', str) > 0 then
                begin
                  gbi := popStr(str, 'gbi');
                end;

              aInt := 0;
              aInt := GetStrInt(ga);
              if aInt < 0 then
                aInt := GetStrInt(gd);
              if aInt < 0 then
                aInt := GetStrInt(gbi);

              postJsonInt('GarageCars', aInt, jsc, False);

              if GetValidInteger(ga) > 0 then
                begin
                  postJsonBool('GarageIsAttached', True, jsc);
                end
              else
                postJsonBool('GarageIsAttached', False, jsc);

              if GetValidInteger(gd) > 0 then
                begin
                  postJsonBool('GarageIsDetached', True, jsc);
                end
              else
                 postJsonBool('GarageIsDetached', False, jsc);

              if GetValidInteger(gbi) > 0 then
                begin
                  postJsonBool('GarageIsBuiltIn', True, jsc);
                end
              else
                postJsonBool('GarageIsBuiltIn', False, jsc);
              end;
              str := Compgrid.Cell[_CarportCount,i];
              if str <> '' then
                begin
              if pos('cp', str) > 0 then
                begin
                  cp := popStr(str, 'cp');
                  aInt := GetStrInt(cp);
                  postJsonInt('CarportCars', aInt, jsc, False);
                  postJsonBool('CarportIsAttached', True, jsc);
                end
              else
                begin
                  postJsonBool('CarportIsAttached', False, jsc);
                end;
              postJsonBool('CarportIsDetached', False, jsc);
              postJsonBool('CarportIsBuiltIn', False, jsc);
                end;
              aViewInfl := -1; aLocInfl := -1;   //github #1112
              str := Compgrid.Cell[_View, i];
              if str <> '' then  //github #1112
                begin
                  GetViewInflNDesc(str, aViewInfl, aFactor1, aFactor2, aFactor1Other);
                  postJsonStr('ViewFactor1', MakeFullViewLocFactor(aFactor1), jsc);
                  postJsonStr('ViewFactor1Other', aFactor1Other, jsc);
                  postJsonStr('ViewFactor2', MakeFullViewLocFactor(aFactor2), jsc);
                  postJsonStr('ViewFactor2Other', aFactor2Other, jsc);
                end;

              str := Compgrid.Cell[_Location, i];
              if str <> '' then //github #1112
                begin
              GetViewInflNDesc(str, aLocInfl, aFactor1, aFactor2, aFactor1Other);
              postJsonStr('LocationFactor1', MakeFullViewLocFactor(aFactor1), jsc);
              postJsonStr('LocationFactor1Other', aFactor1Other, jsc);
              postJsonStr('LocationFactor2', MakeFullViewLocFactor(aFactor2), jsc);
              postJsonStr('LocationFactor2Other', aFactor2Other, jsc);
                end;
              if aViewInfl <> -1 then
                postJsonInt('ViewInfluence', aViewInfl, jsc, False);
              if aLocInfl <> -1 then
                postJsonInt('LocationInfluence', aLocInfl, jsc, False);

              str := Compgrid.Cell[_Condition,i];
              aInt := GetValidInteger(str);
              if aInt > 0 then
                begin
                  aInt := aInt - 1;  //send one less to mobile
                  if aInt >=0 then
                    postJsonInt('ConditionRating', aInt, jsc, False);
                end;
              str := Compgrid.Cell[_Quality,i];
              aInt := GetValidInteger(str);
              if aInt > 0 then
                begin
                  aInt := aInt - 1;  //send one less to the mobile
                  if aInt >=0 then
                  postJsonInt('QualityRating', aInt, jsc, False);
                end;
              str := CompGrid.Cell[_FunctionalUtil, i];
              if str <> '' then
                postJsonStr('FunctionalUtility', str, jsc);
              if str <> '' then
                str := CompGrid.Cell[_FunctionalAdjAmt, i];
              aInt := GetStrInt(str);
              postJsonInt('FunctionalAdjAmt', aInt, jsc, False);
              str := CompGrid.Cell[_Energy, i];
              if str <> '' then
                postJsonStr('EnergyEff', str, jsc);
              if str <> '' then
                str := CompGrid.Cell[_EnergyAdjAmt, i];
              aInt := GetStrInt(str);
              postJsonInt('EnergyAdjAmt', aInt, jsc, False);

              aInt := GetStrInt(Compgrid.Cell[_FirePlace,i]);
              postJsonInt('MiscDesc1', aInt, jsc, False);  //this is for fireplace

              str := Compgrid.Cell[_MiscAdjAmt1,i];
              aInt := GetStrInt(str);
              postJsonInt('MiscAdjAmt1', aInt, jsc, False);

               str := Compgrid.Cell[_Pool,i];
               if (pos('no', lowercase(str)) > 0) or (str = '') then
                 begin
                   postJsonStr('MiscDesc2', '', jsc); //this is for pool
                 end
               else
                 postJsonStr('MiscDesc2', str, jsc); //this is for pool

              str := Compgrid.Cell[_MiscAdjAmt2,i];
              aInt := GetStrInt(str);
              postJsonInt('MiscAdjAmt2', aInt, jsc, False);

              str := CompGrid.Cell[_MiscItem3, i];
              if str <> '' then
                postJsonStr('MiscDesc3', str, jsc);
              str := Compgrid.Cell[_MiscAdjAmt3,i];
              aInt := GetStrInt(str);
              postJsonInt('MiscAdjAmt3', aInt, jsc, False);

             str := Compgrid.Cell[_Comments,i];; //comment
             if str <> '' then
               postJsonStr('Comments', str, jsc);

             str := TlkJSON.GenerateText(jsc);
             jsComps.Add(jsc);
             finally
               //if assigned(jsc) then
               //  jsc.Free;
             end;
            end;
          end;
    except on E:Exception do
    end;
end;



function GetImageTag(jsReport: TlkJSONobject; imageID: String): String;
const
  pathInvalidChars = ['/', '\','?','<','>',':','*','|','"','^'];
var
  jslPhotoMetadata: TlkJSONlist;
  image: Integer;
  imageName: String;
  len: Integer;
  ch: Integer;
begin
  result := '';
  imageName := '';
  if (jsReport.Field['metadata'].Field['photoMetadata'] is TlkJSONnull) then
    exit;
  jslPhotoMetadata := jsReport.Field['metadata'].Field['photoMetadata'] as TlkJSONlist;
  if jslPhotoMetadata.Count > 0 then
    for image := 1 to jslPhotoMetadata.Count do
      if CompareText(imageID, vartostr(jslPhotoMetadata.Child[image - 1].Field['id'].Value)) = 0 then
        begin
          imageName := vartostr(jslPhotoMetadata.Child[image - 1].Field['tag'].Value);
          //we use image name as file name so let's remove invalid characters
           len := length(imageName);
          if len > 0 then
            for ch := 1 to len do
              if imageName[ch] in pathInvalidChars then
                result := result + ' '
              else
                result := result + imageName[ch];
       end;
end;




procedure TCC_Mobile_Inspection.AddImageTojPhoto(aImageType: Integer; ImageData: String; var jPhoto: TlkJsonObject);
var
  aTitle: String;
begin
  if not assigned(jPhoto) then
    jPhoto := TLKJSONObject.Create(true);
  aTitle := GetTitleByImageType(aImageType);
  jPhoto.Add('image_type',aImageType);
  jPhoto.Add('image_title', aTitle);
  jPhoto.Add('image_data',ImageData);
end;


procedure TCC_Mobile_Inspection.CompGridClick(Sender: TObject);
begin
  if CompGrid.Rows = 0 then exit;
  if Compgrid.CurrentDataRow <= 0 then exit;
  Compgrid.RowSelected[CompGrid.CurrentDataRow] := True;
end;

procedure TCC_Mobile_Inspection.ShowInspectionCheckBoxClick(Sender: TObject);
begin
//  SummaryGrid.BeginUpdate;
//  try
//    if not FDoSetPrefrences then
//      GetInspectionSummary;
//  finally
//    SummaryGrid.EndUpdate;
//  end;
end;



/// #################  Download Inspection data

procedure TCC_Mobile_Inspection.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TCC_Mobile_Inspection.SummaryGridDblClickCell(Sender: TObject;
  DataCol, DataRow: Integer; Pos: TtsClickPosition);
var
  aRow: Integer;
begin
  for aRow := 1 to SummaryGrid.Rows do  //reset checked to unchecked
    begin
      SummaryGrid.cell[sSelect, aRow] := 0;
    end;
  SummaryGrid.Cell[sSelect, DataRow] := 1;

//  SummaryGrid.Cell[sSelect, DataRow] := cbChecked;
  btnOpenClick(Sender);
end;

procedure AddImageTojPhoto(aImageType: Integer; ImageData: String; var jPhoto: TlkJsonObject);
var
  aTitle: string;
  aPropID: Integer;
begin
  jPhoto := TLKJSONObject.Create(true);
  jPhoto.Add('Image_Type', Format('%d',[aImageType]));
  aPropID := 0;  //for subject
  case aImageType of
    1: aTitle := 'Front';
    2: aTitle := 'Rear';
    3: aTitle := 'Street';
  end;
  jPhoto.Add('Image_Title', aTitle);
  jPhoto.Add('PropID', Format('%d',[aPropID]));
  jPhoto.Add('Image_Data', ImageData);
end;



procedure TCC_Mobile_Inspection.btnImageSummaryClick(Sender: TObject);
var
  lHTTP: TIdHTTP;
  response : String;
  js: TlkJSONBase;
  itjs: TlkJSONobject;
  i : integer;
  aURL: String;
begin
   lHTTP := TIdHTTP.Create(self);
  try
    aURL := Format('%s/summary?bradford_key=%s',[live_mobile_images_URL,mobile_images_key]);
    response := lHTTP.Get(aURL);

    js:= TlkJSON.ParseText( response );
    InstructionMemo.Lines.Clear;
    for i:=0 to pred(js.Count) do
     begin
       itjs := (js.Child[i] as TlkJSONobject);
       InstructionMemo.Lines.Add(itjs.Field['insp_id'].Value);
     end;
  finally
    lHTTP.Free;
  end;
end;

//github #604:
procedure TCC_Mobile_Inspection.ShowPhotoManager;
var
  aForm: TAdvancedForm;
begin
  aForm := FindFormByName('InspectionDetail');
  if TInspectionDetail(aForm) <> nil then
    begin
//      ShowNotice('Can not open a new window since your Inspection Manager has already been opened.');
//      exit;
      TInspectionDetail(aForm) := nil;
    end;
  FInspectionDetail := TInspectionDetail.Create(self);
  FInspectionDetail.FDoc := FDoc;
  FInspectionDetail.FDocCompTable := FDocCompTable;
  FInspectionDetail.FDocListTable := FDocListTable;
  FInspectionDetail.FInspectionData := FInspectionData;
  FInspectionDetail.UploadInfo := FUploadInfo;
  FInspectionDetail.FOverwriteData := FOverwriteData;
  FInspectionDetail.FUADObject := FUADObject;
  FInspectionDetail.FVersionNumber := FVersionNumber;
  TCC_Mobile_Inspection(FInspectionDetail.FInspectionManager) := self;

//  FInspectionDetail.BringToFront;
  FInspectionDetail.Show;
//  if FInspectionDetail.ModalResult = mrCancel then
//    FInspectionDetail.Free;

end;


procedure TCC_Mobile_Inspection.btnPrintClick(Sender: TObject);
var
  Printer: TPrintDialog;
  MemoOutput: TextFile;
  i: Integer;
begin
  Printer := TPrintDialog.Create(nil);
  try
    If Printer.Execute then
      begin
        AssignPrn(MemoOutput); //assigns a text-file variable to the printer.
        try
          Rewrite(MemoOutput); //creates a new file and opens it
          try
            For i := 0 to jsonMemo.Lines.Count - 1 do
              WriteLn(MemoOutput, jsonMemo.Lines[i]); //puts it to the Printer Canvas
          finally
            CloseFile(MemoOutput); //terminates the association between file variable and an external disk file
          end;
        except
          on EInOutError do
            MessageDlg('Error in Printing memo text.', mtError, [mbOk], 0);
        end;
      end;
  finally
    if assigned(Printer) then
      Printer.Free;
  end;
end;


procedure TCC_Mobile_Inspection.SummaryGridClickCell(Sender: TObject;
  DataColDown, DataRowDown, DataColUp, DataRowUp: Integer; DownPos,
  UpPos: TtsClickPosition);
var
  checked: Boolean;
  aRow: Integer;
begin
  if SummaryGrid.Rows = 0 then exit;  //do nothing if it's empty grid
  if DataRowDown = 0 then exit;  //ignore if we are sorting the column
  if (DataColUp = sSelect) or (DataColDown = sSelect) then
    begin
      for aRow := 1 to SummaryGrid.Rows do
        SummaryGrid.CellCheckBoxState[sSelect,aRow] := cbUnchecked;
      SummaryGrid.CellCheckBoxState[sSelect,DataRowDown] := cbChecked;
    end;

  if SummaryGrid.CellCheckBoxState[sSelect,DataRowDown] = cbChecked then
    begin
      for aRow := 1 to SummaryGrid.Rows do
        SummaryGrid.CellCheckBoxState[sSelect,aRow] := cbUnchecked;
      SummaryGrid.CellCheckBoxState[sSelect,DataRowDown] := cbChecked;
    end;

  if DataColUp = sAssignedName then
    SummaryGrid.SelectionOptions.RowSelectMode := rsNone
  else
    SummaryGrid.SelectionOptions.RowSelectMode := rsSingle;


   //remember the cbx state
   checked := (SummaryGrid.CellCheckBoxState[sSelect, DataRowDown] = cbChecked);

    if ShiftKeyDown then
      for aRow := DataRowDown + 1 to SummaryGrid.Rows do
        begin
          if checked then
            begin
              SummaryGrid.CellCheckBoxState[sSelect,aRow] := cbChecked;
            end
          else
            begin
              SummaryGrid.CellCheckBoxState[sSelect, aRow] := cbUnChecked;
            end;
        end;
  btnDelete.Enabled := checked;
  btnOpen.Enabled   := checked;
end;

procedure TCC_Mobile_Inspection.PrimatyContactClick(Sender: TObject);
var
  rdoButton: TRadioButton;
begin
  if Sender is TRadioButton then
    rdoButton := TRadioButton(Sender);
  case rdoButton.Tag of
    1: FUploadInfo2.PrimaryContactType := acIsBorrower;
    2: FUploadInfo2.PrimaryContactType := acIsOwner;
    3: FUploadInfo2.PrimaryContactType := acIsOccupant;
    4: FUploadInfo2.PrimaryContactType := acIsAgent;
    5: begin
         FUploadInfo2.PrimaryContactType := acIsOther;
         edtPRIOther.Visible := True;
	 FUploadInfo2.PrimaryOther := edtPriOther.Text;
       end;
  end;
end;

procedure TCC_Mobile_Inspection.AlternateContactClick(Sender: TObject);
var
  rdoButton: TRadioButton;
begin
  if Sender is TRadioButton then
    rdoButton := TRadioButton(Sender);
  case rdoButton.Tag of
    1: FUploadInfo2.AlternateContactType := acIsBorrower;
    2: FUploadInfo2.AlternateContactType := acIsOwner;
    3: FUploadInfo2.AlternateContactType := acIsOccupant;
    4: FUploadInfo2.AlternateContactType := acIsAgent;
    5: begin
         FUploadInfo2.AlternateContactType := acIsOther;
         edtAltOther.Visible := True;
	 FUploadInfo2.AlternateOther := edtAltOther.Text;
       end;
  end;
end;

procedure TCC_Mobile_Inspection.WriteToIniFile;
var
  PrefFile: TMemIniFile;
  IniFilePath : String;
begin
  IniFilePath := IncludeTrailingPathDelimiter(appPref_DirPref) + cClickFormsINI;
  PrefFile := TMemIniFile.Create(IniFilePath);                   //create the INI writer

  With PrefFile do
    begin
      WriteBool('Inspection', 'ShowReadyToImport', chkReadyForImport.Checked);
      WriteBool('Inspection', 'ShowImported', chkImported.Checked);
      WriteBool('Inspection', 'ShowInProgress', chkProgress.Checked);
      WriteBool('Inspection', 'ShowPending', chkShowPending.Checked);
      WriteBool('Inspection', 'ShowPartialCompleted', chkPartialCompleted.Checked);
      WriteString('Inspection', 'ShowAfterDate', edtFilterDate.Text);
      WriteBool('Inspection', 'DefaultOverwriteData', FOverwriteData);
      UpdateFile;      // do it now
    end;

  PrefFile.Free;
end;

procedure TCC_Mobile_Inspection.LoadFromIniFile;
var
  PrefFile: TMemIniFile;
  IniFilePath, aDateStr : String;
  aInt: Integer;
  year, month, day, dow: word;
begin
  IniFilePath := IncludeTrailingPathDelimiter(appPref_DirPref) + cClickFormsINI;
  try
    PrefFile := TMemIniFile.Create(IniFilePath);                   //create the INI writer
    FDoSetPrefrences := True;

    With PrefFile do
      begin
        chkReadyForImport.Checked := ReadBool('Inspection', 'ShowReadyToImport', True);
        chkImported.Checked := ReadBool('Inspection', 'ShowImported', True);
        chkProgress.Checked := ReadBool('Inspection', 'ShowInProgress', True);
        chkShowPending.Checked := ReadBool('Inspection', 'ShowPending', True);
        chkPartialCompleted.Checked := ReadBool('Inspection', 'ShowPartialCompleted', True);
        DecodeDateFully((now - 180), year, month, day, dow);
        aDateStr := Format('%d/01/%d',[month, year]);
        edtFilterDate.Text := ReadString('Inspection', 'ShowAfterDate', aDateStr);
//        aInt := ReadInteger('Inspection', 'DataStructureVersionID', 0);
//        if aInt > 0 then //skip to set the value if not in the ini the first time
//          FVersionNumber := aInt;
      end;
  finally
    PrefFile.Free;
    FDoSetPrefrences := False;
  end;
end;




procedure TCC_Mobile_Inspection.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  WriteToIniFile;
  CanClose := True;
end;

procedure TCC_Mobile_Inspection.btnReassignedClick(Sender: TObject);
var
  status, msg: String;
  i,j, insp_id: integer;
  assignCount: Integer;
  aOption: TModalResult;
begin
(*  Get rid of reassign button, call reassign order through the assign name drop down
   j := 0;  assignCount := 0;
  for i := 1 to SummaryGrid.Rows do
    begin
      insp_id := GetValidInteger(SummaryGrid.Cell[sInsp_id, i]);
      if SummaryGrid.Cell[sSelect, i] = cbChecked then
        begin
          j := j + 1;
        end;
    end;
  if j > 0 then
    begin
      if msg = '' then //github #797
       // msg := 'This will remove the selected inspection from the mobile app.  Are you sure you want to continue?';
        msg := 'This will reassign the selected inspection from the inspection manager. Are you sure you want to continue?';
      if msg <> '' then
        begin
          aOption:= WhichOption12('Reassign', 'Cancel',msg);
          if aOption <> mrYes then exit;
        end;
    end
  else
    begin
      ShowAlert(atWarnAlert,'Please select the inspection to reassign.');
      exit;
    end;
  try
    PushMouseCursor(crHourglass);
    try
    for i := 1 to SummaryGrid.Rows do
      begin
        insp_id := SummaryGrid.Cell[sInsp_id, i];
        if SummaryGrid.Cell[sSelect,i] = cbChecked then
          begin
            FUploadInfo2.insp_id := SummaryGrid.Cell[sInsp_id,i];
            FUploadInfo2.Assigned_ID := SummaryGrid.Cell[sAssignedId, i];
            status := AbbreviateStatus(SummaryGrid.Cell[sStatus,i]);
            if not AssignOrder(FUploadInfo2) then
              begin
                msg := Format('Problems were encountered when trying to reassign inspections #: %d.',[insp_id]);
                ShowAlert(atWarnAlert,msg);
              end
            else
              inc(assignCount);
            end;
        end;
      if assignCount > 0 then
      begin
        msg := Format('%d inspection(s) have been reassigned successfully!',[assignCount]);
        ShowNotice(msg);
      end
  except
    ShowAlert(atWarnAlert,'Problems were encountered when trying to reassign the property inspections.');
  end;
  btnRefresh.click; //github 677
  GetInspectionSummary;
  finally
    PopMouseCursor;
  end;
*)
end;


procedure TCC_Mobile_Inspection.InitGridCombo;
var i, rows:integer;
begin
  if SummaryGrid.Rows = 0 then exit;
  try
    with SummaryGrid.Col[sAssignedName].Combo.ComboGrid do
    begin
      StoreData := True;
      if FTeamNameList = nil then exit;
      rows := FTeamNameList.Count;
      SummaryGrid.Col[sAssignedName].Combo.DropDownRows := Rows;
      SummaryGrid.Col[sAssignedName].Combo.DropDownCols := 1;
      SummaryGrid.Col[sAssignedName].Combo.ComboGrid.StoreData := True;
      SummaryGrid.Col[sAssignedname].ReadOnly := not FUploadInfo2.IsAdmin;  //readonly if not admin
      if FUploadInfo2.IsAdmin then
        for i:=0 to rows-1 do
          Cell[1,i+1] := FTeamNameList[i];
    end;
  except on E:Exception do
    showMessage('Error: '+e.message);
  end;
end;

//This routine walk through the full team member list and compare the assigned name if match with the current user email, return assigned id.
function TCC_Mobile_Inspection.GetAssignedIDByName(AssignedName:String):Integer;
var
  i: Integer;
  aItem, aName, aValue:String;
begin
  result := 0;
  for i:= 0 to FTeamMemberList.count - 1 do
    begin
      aItem  := FTeamMemberList[i];
      aName  := popStr(aItem, '=');
      aValue := aItem;
      if compareText(aName,'team_member_name') =0 then
        if CompareText(aValue, AssignedName) = 0 then  //match assigned name
          begin
            aItem := FTeamMemberList[i+1];  //the next item is the assigned id
            aName := popStr(aItem, '=');
            aValue := aItem;
            if CompareText(aname, 'appraiser_id') = 0 then
              result := getValidInteger(aValue);
            break;
          end;
    end;
end;


procedure TCC_Mobile_Inspection.cbAssignedToCloseUp(Sender: TObject);
begin
  if cbAssignedTo.ItemIndex <> -1 then
   cbAssignedTo.Text := cbAssignedTo.Items[cbAssignedTo.ItemIndex];

  if cbAssignedTo.Text <> '' then
    begin
      FAssigned_ID := GetAssignedIDByName(cbAssignedTo.Text);
      FAssigned_Name := cbAssignedTo.Text;
    end
end;

procedure TCC_Mobile_Inspection.SummaryGridComboRollUp(Sender: TObject;
  Combo: TtsComboGrid; DataCol, DataRow: Integer);
begin
  if SummaryGrid.Cell[sAssignedName,DataRow] <> '' then
    begin
//      SummaryGrid.Cell[sSelect, DataRow] := 1;  //check selected check box if we pick assigned name from the drop down
//      btnReassigned.Enabled := FUploadInfo2.IsAdmin;
      ReassignedOrder(DataRow);
    end;
end;

procedure TCC_Mobile_Inspection.ReassignedOrder(DataRow:Integer);
var
  msg: String;
begin
  SummaryGrid.Cell[sAssignedID, DataRow] := GetAssignedIDByName(SummaryGrid.Cell[sAssignedName,DataRow]);
  FUploadInfo2.insp_id := SummaryGrid.Cell[sInsp_id, DataRow];
  FUploadInfo2.Assigned_ID_Name := SummaryGrid.Cell[sAssignedName,DataRow];
  FUploadInfo2.Assigned_ID := SummaryGrid.Cell[sAssignedID, DataRow];

    PushMouseCursor(crHourglass);
    try
      FUploadInfo2.insp_id := SummaryGrid.Cell[sInsp_id,DataRow];
      FUploadInfo2.Assigned_ID := SummaryGrid.Cell[sAssignedId, DataRow];
      FUploadInfo2.Assigned_ID_Name := SummaryGrid.Cell[sAssignedName, DataRow];
      try
//        status := AbbreviateStatus(SummaryGrid.Cell[sStatus,DataRow]);
        if not AssignOrder(FUploadInfo2) then
          begin
//            msg := Format('Problems were encountered when trying to reassign inspections #: %d.',[FUploadInfo2.insp_id]);
//            ShowAlert(atWarnAlert,msg);
            exit;
          end
        else
          begin
            if SummaryGrid.Cell[sPriorAssign, DataRow] <> '' then
              msg := Format('Inspections #: %d has been reassigned from %s to %s.',[FUploadInfo2.insp_id,
                             SummaryGrid.Cell[sPriorAssign, DataRow],FUploadInfo2.Assigned_ID_Name])
            else
              msg := Format('Inspection #: %d has been assigned to %s.',[FUploadInfo2.insp_id, FUploadInfo2.Assigned_ID_Name]);
            ShowNotice(msg);
          end;
      except
        ShowAlert(atWarnAlert,'Problems were encountered when trying to reassign the property inspections.');
      end;
  btnRefresh.click; //github 677
//  GetInspectionSummary;
  finally
    PopMouseCursor;
  end;
end;



procedure TCC_Mobile_Inspection.SummaryGridCellChanged(Sender: TObject;
  OldCol, NewCol, OldRow, NewRow: Integer);
begin
  if SummaryGrid.Cell[sAssignedName, NewRow] = '' then
    SummaryGrid.Cell[sSelect, NewRow] := 0
  else
    SummaryGrid.Cell[sSelect, NewRow] := 1;
end;

procedure TCC_Mobile_Inspection.SummaryGridCellEdit(Sender: TObject;
  DataCol, DataRow: Integer; ByUser: Boolean);
begin
  case DataCol of
    sAssignedName:
      begin
        if SummaryGrid.Cell[DataCol, DataRow] <> '' then
          if FTeamNameList.Indexof(SummaryGrid.Cell[DataCol, DataRow]) = -1 then
            ShowAlert(atWarnAlert, 'Please pick name from drop down list.');
      end;
  end;
end;

procedure TCC_Mobile_Inspection.SummaryGridComboGetValue(Sender: TObject;
  Combo: TtsComboGrid; GridDataCol, GridDataRow, ComboDataRow: Integer;
  var Value: Variant);
begin
  case GriddataCol of
    sAssignedName:  SummaryGrid.Cell[sPriorAssign, GridDataRow] := SummaryGrid.Cell[sAssignedName, GridDataRow];  //save previous assign name
  end;
end;

procedure TCC_Mobile_Inspection.cbAssignedToExit(Sender: TObject);
begin
  if cbAssignedTo.ItemIndex <> -1 then
   cbAssignedTo.Text := cbAssignedTo.Items[cbAssignedTo.ItemIndex];

  if cbAssignedTo.Text <> '' then
    begin
      if cbAssignedTo.Items.IndexOf(cbAssignedTo.Text) = -1 then
        begin
          ShowNotice('Please pick from drop down list.');
          cbAssignedTo.Text := '';
        end;
    end;
end;

procedure TCC_Mobile_Inspection.cbFilterByExit(Sender: TObject);
begin
  if cbFilterBy.Text <> '' then
    begin
      if cbFilterBy.Items.IndexOf(cbFilterBy.Text) = -1 then
        begin
          ShowNotice('Please pick from drop down list.');
          cbFilterBy.Text := '';
        end;
    end
  else
    btnRefresh.Click;
end;

procedure TCC_Mobile_Inspection.cbFilterByCloseUp(Sender: TObject);
begin
  if cbFilterBy.ItemIndex <> -1 then
   cbFilterBy.Text := cbFilterBy.Items[cbFilterBy.ItemIndex];
//  if cbFilterBy.Text <> '' then
//    btnRefresh.Click;
end;

end.
