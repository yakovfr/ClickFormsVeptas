unit UMobile_InspectionDetail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, jpeg,uDrag, RzTabs,Contnrs, uContainer,uLKJSON,
  uMobile_Utils, ComCtrls, ImgList,uCell, uForm, uBase,UGridMgr, Buttons,
  Printers, uWindowsInfo,UMobile_DataService,IdHTTP, IdContext,
  IdMultipartFormData, uGraphics,IdSSLOpenSSL, xmldom, XMLIntf, UForms,
  AWSI_Server_Access,UGlobals,msxmldom, XMLDoc,//UCC_Globals,
  uUADObject,IniFiles,
  UCellMetaData, uMessages,RzLabel;
                           

type
  TPhoto = Class(TObject)    //checked
  private
    FType: Integer;         //PhotoTypes: front, rear, street, etc
    FCaption: String;
    FSource: String;
    FDate: String;
  public
    FImage: TJPEGImage;

    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPhoto);
    property Image: TJPEGImage read FImage write FImage;
    property PhotoType: Integer read FType write FType;
    property PhotoCaption: String read FCaption write FCaption;
    property PhotoSource: String read FSource write FSource;
    property PhotoDate: String read FDate write FDate;
  end;



  TInspectionDetail = class(TAdvancedForm)
    PageControl:TRzPageControl;
    Panel1: TPanel;
    Label1: TLabel;
    lblSubjectAddr: TLabel;
    btnTransfer: TButton;
    btnClose2: TButton;
    chkSaveWorkFile: TCheckBox;
    TabJson: TRzTabSheet;
    panel123: TPanel;
    lblInsp_ID: TLabel;
    btnPrint: TButton;
    JsonTree: TTreeView;
    JsonMemo: TMemo;
    tabCompPhotos: TRzTabSheet;
    Statusbar2: TStatusBar;
    tabSubjPhotos: TRzTabSheet;
    tabSketch: TRzTabSheet;
    BotPhotoSection: TScrollBox;
    StatusBar: TStatusBar;
    PageControl1: TRzPageControl;
    taPhotos: TRzTabSheet;
    taSketch: TRzTabSheet;
    taData: TRzTabSheet;
    PhotoFormOptionPanel: TPanel;
    rdoMainSubject: TRadioGroup;
    rdoExtraSubject: TRadioGroup;
    GLAGroup: TGroupBox;
    GLA: TMemo;
    NonGLAGroup: TGroupBox;
    NonGLA: TMemo;
    ScrollBox1: TScrollBox;
    BasePanel: TPanel;
    Printer: TPrintDialog;
    TopPhotoSection: TScrollBox;
    BotBasePanel: TPanel;
    RzLabel1: TRzLabel;
    ScrollBox2: TScrollBox;
    CompBasePanel: TPanel;
    PhotoDisplayComps: TScrollBox;
    rdoMainComp: TRadioGroup;
    rdoSketchData: TRadioGroup;
    chkSketchONLY: TCheckBox;
    procedure PhotoComboOnchange(Sender: TObject);
    procedure MouseDownOnImage(Sender: TObject;Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DragImageStart(Sender: TObject;var DragObject: TDragObject);
    procedure btnSelectAllPhotosClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnTransferClick(Sender: TObject);
    procedure SubjectTransferCheckBoxClick(Sender: TObject);
    procedure CompTransferCheckBoxClick(Sender: TObject);
    procedure JsonTreeClick(Sender: TObject);
    procedure btnSaveToFileClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnClose2Click(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure ImageMouseDown(Sender: TObject;Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ImageDragOver(Sender,Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ImageDragDrop(Sender,Source: TObject; X, Y: Integer);
    procedure ImageEndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
  private
    { Private declarations }
    FUploadInfo: TUploadInfo;
    FUploadInfo2: TUploadInfo2;
    FjoImage: TlkJSonBase;
    FjInspectionObject: TlkJSONObject;
    FjSubjectObj: TlkJSONObject;
    FjCompObj: TlkJSONObject;
    FjPostedData: TlkJSONObject;
    FImageData: widestring;
    FSubjectData: TSubjectInspectData;
    FSubjectData2: TSubjectInspectData2;

    FSubjectMainFormID: Integer;
    FSubjectExtraFormID: Integer;
    FCompMainFormID: Integer;
    FSketchImageBase64: String;
    FSketchJSON: String;
    FSketchData: TSketchData;     //Clickforms AreaSketch MetaData object
    FBasePanelHeight: Integer;  //original base panel's height
    FPhotoTopList: TStringList;
    FGLANames: TStringList;
    FNonGLANames: TStringList;
    FSketch_Data: String;
    FAreaList: TStringList;
    FAreaSqftList: TStringList;   //to hold GLA value list and sort in ascending order
    FGLASqft, FAreaSqft: Double;  //var to keep original sqft
    FSumOtherSqft: Double;        //sum of the other sqft for dimension list
    FSumGarage: Double;           //sum of multiple garage sqft for dimension list
    procedure ViewPicture(Sender : TObject);
    procedure LoadPhotoToCompDisplayList(N: Integer; iPropID: Integer; APhoto: TPhoto; image_title: String; var PropIDList, PropIDList2:TStringList);
    function TransferSubjectPhotos: Boolean;
    function TransferCompPhotos: Boolean;
    procedure ImportSubjectMainImage(photo:TImage; image_id: Integer; image_desc: String; var IsCreated:Boolean; var MainIdx:Integer);
    function GetSubjectMainFormID: Integer;
    procedure ImportSubjectExtraImages(photo:TImage; image_id:Integer; image_desc: String);
    function GetSubjectExtraFormID:Integer;
    function GetSubjectExtraCellIDTitleFor302(isNew:Boolean; aForm: TDocForm; var aCellID, aCellTitleID: Integer; var cell: TBaseCell): Boolean;
    function GetSubjectExtraCellIDTitle(isNew:Boolean; aForm: TDocForm; var aCellID, aCellTitleID: Integer; var cell: TBaseCell): Boolean;
    function GetCompMainFormID: Integer;
    function GetCompExtraFormID:Integer;
    function GetCompExtraCellIDTitleFor308(isNew:Boolean; aForm: TDocForm; var aCellID, aCellTitleID: Integer; var cell: TBaseCell): Boolean;
    function GetCompExtraCellIDTitle(isNew:Boolean; aForm: TDocForm; var aCellID, aCellTitleID: Integer; var cell: TBaseCell): Boolean;
    function GetListingMainFormID: Integer;
    procedure ImportCompMainImages(photo:TImage; imageTag:Integer; image_desc: String);
    function LoadCompDropDownItems: String;
    procedure SetAddressFor4181(i, aCellNo: Integer; aForm: TDocForm; cell: TBaseCell);
    procedure SetAddressFor4084(i, aCellNo: Integer; aForm: TDocForm; cell: TBaseCell);
    procedure SetAddressFor4082(i, aCellNo: Integer; aForm: TDocForm; cell: TBaseCell);
    procedure LoadJsonTree(InspectionData:String);
    procedure DisplayNode(var SubjectNode: TTreeNode; var js: TlkJSonObject; aName:String);
    procedure LoadJsonToMemo;
    procedure DownloadImagesJSon(joImage: TlkJSonBase);
    function DownLoadInspectionDataByID(InspectionData:String): Boolean;
    procedure DownloadSketchJSon(js, jsMeta: TlkJSonBase; toReport:Boolean);
    procedure DownloadImagePackagesByID(insp_id: Integer);
    procedure ImportSketchImagesToReport(photo:TJPEGImage; i: Integer; js, jsMeta:TlkJSonBase; var thisForm: TDocForm);
    procedure SetCellTextByCellID(cellID:Integer; aText: String; skipMath:Boolean=False);
    procedure ImportGridData(CompNo:Integer; doc: TContainer; cellStr, str: String; var FDocCompTable: TCompMgr2);
    procedure ImportListingGridData(CompNo: Integer; doc: TContainer;  cellStr, str: String; var FDocListingTable: TCompMgr2);
    procedure SetCompTableValue(doc: TContainer; CompCol: TCompColumn; cellID: Integer; str: String);
    procedure InsertXCompPage(doc: TContainer; compNo: Integer);
    procedure writeGridData(CompNo: Integer; doc:TContainer; cellStr, str: String; var FDocCompTable: TCompMgr2);
    procedure writeListingGridData(CompNo: Integer; doc:TContainer; cellStr, str: String; var FDocCompTable: TCompMgr2);
    procedure InsertXListingPage(doc: TContainer; compNo: Integer);
//    procedure LoadInspectionData_SubjectData(subject_data:String; var FSubjectData:TSubjectInspectData);
    procedure LoadInspectionData_SubjectData(subject_data:String);
    procedure LoadInspectionData_SubjectData_V1(subject_data:String; var FSubjectData:TSubjectInspectData);
    procedure LoadInspectionData_SubjectData_V2(subject_data:String; var FSubjectData2:TSubjectInspectData2);
    procedure ImportSubjectDataToReport;
    procedure ImportSubjectDataToReport2;
    procedure ImportCompDataToReport(Comps_data:String);
    procedure ImportCompDataToReport_V1(Comps_data:String);
    procedure ImportCompDataToReport_V2(Comps_data:String);
    procedure SaveToWorkFile;
    function GetWorkFilePath(doc: TContainer): String;
    procedure SaveDataWorkFile(aPath:String);
    procedure SaveSubjectImageWorkFile(aPath:String);
    procedure SaveCompImageWorkFile(aPath:String);
    procedure SaveSketchDataWorkFile(aPath:String);
    function CalcCompPanelTop(N, iPropID:Integer; aCompPanel:TPanel):Integer;
    procedure LoadSubjectImages(i, iPropID:Integer; jsPhoto: TlkJSonBase; var iTop, iBot:Integer);
    procedure LoadCompImages(i, iPropID:Integer; jsPhoto: TlkJSonBase;var PropIDList, PropIDList2:TStringList; isSubject:Boolean=True);
    function GetFrameIDByPropdID(CompPanel,ImageFrame:TPanel; iPropID:Integer):Integer;
    procedure WriteToIniFile;
    procedure LoadFromIniFile;
    procedure SetupConfig;
    procedure SaveImageFormOptions;
    procedure  LoadSketchImages(SketchImageStr:String; i, aCount: Integer; js_sketch_data,jsMeta:TlkJSonBase);

    procedure ImportCompImages(photo:TImage; imageTag: Integer; image_desc: String);
    function GetFormPageCount(imageTag:Integer):Integer;
    function CreateCompPanel(aPhotoDisplay:TScrollBox; N, iPropID:Integer):TPanel;
    procedure CreateCompDisplay(i, N,iPropID:Integer; APhoto:TPhoto; image_title:String; var PropIDList, PropIDList2:TStringList);

    procedure LoadPhotoToTopSubjectSection(N: Integer; var aPhoto:TPhoto);  //PAM: this routine load subject Front/Rear/View to the top section.
    procedure LoadPhotoToBottomSubjectSection(N: Integer; var aPhoto:TPhoto);
    function IsSubjectMain(aTitle:String):Boolean;
    Procedure ReOrderSubjectPanels;
    procedure AdjustDPISettings;
    function IsSubjectTopTransfer(aTitle:String; aTag: Integer):Boolean;
    procedure ImportSketchDefinitionToReport(joSketchData: TlkJSonBase);
    //Ticket #1360 for overwrite images & sketch: when overwrite is Yes, we clear the existing image in the image cell so we can use existing insert image logic to do the work
    procedure ClearSubjectMainPhotoImages;
    procedure ClearSubjectExtraPhotoImages;
    procedure ClearCompPhotoImages;
    procedure ClearSketchImages;
    procedure ClearSubjectMainPhoto(aFormID:Integer; aForm:TDocForm);
    procedure ClearSubjectExtraPhoto(aFormID:Integer; aForm:TDocForm);
    procedure ClearCompPhoto(aFormID:Integer; aForm:TDocForm);
    function PopulateGLAEntries(thisForm: TDocFOrm; AreaName, aArea:String; GLANameList,wList, hList:TStringList; var rowCount:Integer; var SumGLA:Double):Boolean;
    function PopulateNonGLAEntries(thisForm: TDocFOrm; AreaName, aArea:String; NonGLANameList,wList, hList:TStringList; var rowCount:Integer):Boolean;
    function IsMainFloor(aAreaName:String; aAreaSqft:Integer):Boolean;
    procedure DownloadSketchMdataJson2(joSketchData: TlkJSonBase; thisForm: TDocForm; {cell:TSketchCell;} pageNo:Integer);
    procedure ImportSubjectGarage;
    procedure ImportSubjectCarport;
    procedure ImportSubjectDriveway;
    procedure FillCommentAddendum(SummaryNote:String); //Ticket #1550

  public
    { Public declarations }
    FSubjectPhotoList: TObjectList;
    FCompPhotoList: TObjectList;
    FSaleCount: Integer;   //to hold total sales count
    FListCount: Integer;   //to hold total listing count
    FDocCompTable : TCompMgr2;
    FDocListTable : TCompMgr2;
    FDoc: TContainer;
    FInspectionData: String;
    FOverwriteData:Boolean;
    FUADObject: TUADObject;

    FInspectionManager: TComponent;
    FVersionNumber: Integer;
    FDataStructureVersionNumber: Integer;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property UploadInfo: TUploadInfo read FUploadInfo write FUploadInfo;
    property UploadInfo2: TUploadInfo2 read FUploadInfo2 write FUploadInfo2;
    property joImage: TlkJSonBase read FjoImage write FjoImage;
    Property SketchData: TSketchData read FSketchData write FSketchData;
  end;

const
  tagSubject        = 0;
  tagComp           = 1;
  MaxImagesPerRow   = 3;  //the # of images per row
  cAcre             = 43560;
  Dimension_Max_Row = 25;  //max row - 1 for array

var
  InspectionDetail: TInspectionDetail;
  AreaCellIDs: array[0..Dimension_Max_Row] of Integer  = (27,38,49,60,71,82,93,104,115,126,137,148,159,170,181,192,203,214,225,236,247,258,269,280,291,302);
  TypeCellIDs: array[0..Dimension_Max_Row] of Integer  = (31,42,53,64,75,86,97,108,119,130,141,152,163,174,185,196,207,218,229,240,251,262,273,284,295,306);
  LevelCellIDs: array[0..Dimension_Max_Row] of Integer = (35,46,57,68,79,90,101,112,123,134,145,156,167,178,189,200,211,222,233,244,255,266,277,288,299,310);



implementation


{$R *.dfm}

uses
  UBase64, uUtil2,UImageView, uStatus, uUtil1, uWebConfig, UMain,
  UMobile_Inspection, USketch_JSonToXML, UUADUtils, UOrderManager;

function MySort(List: TStringList; Index1, Index2: Integer): Integer;
var
  Value1, Value2: Double;
begin
  Value1 := GetValidInteger(List[Index1]);
  Value2 := GetValidInteger(List[Index2]);
  if Value1 < Value2 then
    Result := -1
  else if Value2 < Value1 then
    Result := 1
  else
    Result := 0;
end;

function IsSecondFloor(aAreaName:String):Boolean;
begin
  aAreaName := UpperCase(aAreaName);
  result    := (pos('SECOND', aAreaName) > 0) or (pos('2ND', aAreaName) >0) or
               ((pos('2', aAreaName) >0) and
                (pos('FL', aAreaName)>0) or (pos('LEVEL', aAreaName) >0) or (pos('LVL', aAreaName) > 0));
end;

function IsThirdFloor(aAreaName:String):Boolean;
begin
  aAreaName := UpperCase(aAreaName);
  result    := (pos('THIRD', aAreaName) > 0) or (pos('3RD', aAreaName) >0) or
               ((pos('3', aAreaName) >0) and
                (pos('FL', aAreaName)>0) or (pos('LEVEL', aAreaName) >0) or (pos('LVL', aAreaName) > 0));
end;

function IsBasement(aAreaName:String):Boolean;
begin
  aAreaName := UpperCase(aAreaName);
  result    := (pos('BASE', aAreaName) > 0) or (pos('BSM', aAreaName) >0);
end;

function IsGarage(aAreaName:String):Boolean;
begin
  aAreaName := UpperCase(aAreaName);
  result    := (pos('GARAGE', aAreaName) > 0) or (pos('CAR', aAreaName) > 0);
end;



function TInspectionDetail.IsMainFloor(aAreaName:String; aAreaSqft:Integer):Boolean;
var
  asqft: String;
  idx: Integer;
begin
  result := False;
  aAreaName := trim(aAreaName);
  result := (CompareText(aAreaName, 'Main Floor') = 0) or (pos('FIRST', UpperCase(aAreaName)) > 0) or
            (pos('1', aAreaName) > 0);
  if result then
    exit;

  if IsSecondFloor(aAreaName) or  IsThirdFloor(aAreaName) or IsBasement(aAreaName) or IsGarage(aAreaName) or
     (pos('FOUR', UpperCase(aAreaName)) > 0) or
     (pos('FI', UpperCase(aAreaName)) > 0) or
     (pos('SIX', UpperCase(aAreaName)) > 0) or
     (pos('SEV', UpperCase(aAreaName)) > 0) or
     (pos('PA', UpperCase(aAreaName)) > 0) or
     (pos('DE', UpperCase(aAreaName)) > 0) then  exit;  //we don't want to continue this is not main


  if not result then //else we try to get the large sqft in the GLA name list to match with the area sqft coming in
    begin
      if FAreaSqftList.Count > 0 then
        aSqft := FAreaSqftList[FAreaSqftList.Count - 1];
      idx := FAreaSqftList.IndexOf(aSqft);
      if idx = FAreaSqftList.Count -1 then //we have one with the same # sqft of main level and other level;
        if (aAreaSqft > 0) and (GetValidInteger(aSqft) > 0) then
          result := aAreaSqft = GetValidInteger(aSqft);
    end;

   if not result then
    result := aAreaName = '';  //none of the above but has empty title 

end;


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


constructor TInspectionDetail.Create(AOwner: TComponent);
begin
  SettingsName := CFormSettings_InspectionDetail;
  FSketchData := nil;
  FSubjectPhotoList := TObjectList.Create(False);
  FCompPhotoList := TObjectList.Create;
  inherited;
  if assigned(AOwner) then
    FDoc := TContainer(AOwner);
  FGLANames := TStringList.Create;
  FGLANames.Duplicates := dupIgnore;

  FNonGLANames := TStringList.Create;
  FNonGLANames.Duplicates := dupIgnore;

  FPhotoTopList := TStringList.Create;
  FPhotoTopList.Duplicates := dupIgnore;

  FAreaSqftList := TStringList.Create;
  FAreaSqftList.Duplicates := dupIgnore;

  FAreaList := TStringList.Create;
  FAreaList.Duplicates := dupIgnore;

end;




destructor TInspectionDetail.Destroy;
var
  i: Integer;
  aObj: TObject;
begin
  if assigned(FSubjectPhotoList) then
    begin
      if FSubjectPhotoList.Count > 0 then
        for i:= 0 to FSubjectPhotoList.count - 1 do
          begin
            aObj := FSubjectPhotoList.Items[i];
            if assigned(aObj) then
              TObject(aObj) := nil;
          end;
      if assigned(FSubjectPhotoList) then
        TObjectList(FSubjectPhotoList) := nil;
    end;

  if assigned(FCompPhotoList) then
    begin
      if FCompPhotoList.Count > 0 then
        for i:= 0 to FCompPhotoList.count - 1 do
          begin
            aObj := FCompPhotoList.Items[i];
            if assigned(aObj) then
              TObject(aObj) := nil;
          end;
      if assigned(FCompPhotoList) then
        TObjectList(FCompPhotoList) := nil;
    end;

  FGLANames.Free;
  FNonGLANames.Free;
  FPHotoTopList.Free;
  FAreaSqftList.Free;
  FAreaList.Free;
  inherited Destroy;
end;

function GetImageCaption(image_id: Integer; Image_Title:String):String;
begin
  result := Image_Title;
end;


procedure TInspectionDetail.LoadSubjectImages(i, iPropID:Integer; jsPhoto: TlkJSonBase; var iTop, iBot: Integer);
const
  Delta = 0;
var
  imageJPG:TJPEGImage;
  image_title, imageData,aImageStr: String;
  image_id: Integer;
  imgPhoto: TPhoto;
begin
   imgPhoto := TPhoto.Create;
   try
     if jsPhoto.Field['Image_Title'] <> nil then
       image_title := varToStr(jsPhoto.Field['Image_Title'].Value)
     else if jsPhoto.Field['image_title'] <> nil then
       image_title := varToStr(jsPhoto.Field['image_title'].Value);

     image_id := GetImageTypeByTitle(image_title);
     if jsPhoto.Field['Image_Type'] <> nil then
       image_id := jsPhoto.Field['Image_Type'].Value
     else if jsPhoto.Field['image_type'] <> nil then
       image_id := jsPhoto.Field['image_type'].Value;

     if jsPhoto.Field['Image_Data'] <> nil then
       ImageData := varToStr(jsPhoto.Field['Image_Data'].Value)
     else if jsPhoto.Field['image_data'] <> nil then
       ImageData := varToStr(jsPhoto.Field['image_data'].Value);

    imgPhoto.PhotoType    := image_id;
    imgPhoto.PhotoCaption := GetImageCaption(image_id, image_title);  //use caption to transfer to PhotoMgr
    imgPhoto.PhotoDate    := DateToStr(date);
    imgPhoto.Image := TJPEGImage.Create;
    //now get the image
    aImageStr   := Base64Decode(imageData);
    imageJPG    := TJPEGImage.Create;
    LoadJPEGFromByteArray(aImageStr,imageJPG);
    imgPhoto.FImage.Assign(imageJPG);
    if IsSubjectMain(imgPhoto.FCaption) then  //Filter out all the extra subject photos only include subject main: Front/Rear/Street
      begin
        LoadPhotoToTopSubjectSection(iTop, imgPhoto);
        inc(iTop);   //keep track of the # photos
      end
    else
      begin
        LoadPhotoToBottomSubjectSection(iBot, imgPhoto);  //Use the TObjectList items to display on scroll box
        inc(iBot);
      end;
///    if BotBasePanel.ComponentCount > 6 then
///      BotBasePanel.Height := (FBasePanelHeight) + Round((BotBasePanel.ComponentCount-MaxImagesPerRow)/MaxImagesPerRow) * FrameHeight;
   finally
     if assigned(imageJPG) then
       imageJPG.Free;
     if assigned(imgPhoto) then
       imgPhoto.Free;
   end;
end;


procedure TInspectionDetail.LoadCompImages(i, iPropID:Integer; jsPhoto: TlkJSonBase;var PropIDList, PropIDList2:TStringList; isSubject:Boolean=True);
var
  imageJPG:TJPEGImage;
  image_title, imageData,aImageStr, FileName, TempRawDataFile, aCaption: String;
  image_id: Integer;
  imgPhoto: TPhoto;
begin
   imgPhoto := TPhoto.Create;
   try
     if jsPhoto.Field['Image_Title'] <> nil then
       image_title := varToStr(jsPhoto.Field['Image_Title'].Value)
     else if jsPhoto.Field['image_title'] <> nil then
       image_title := varToStr(jsPhoto.Field['image_title'].Value);

     image_id := GetImageTypeByTitle(image_title);
     if jsPhoto.Field['Image_Type'] <> nil then
       image_id := jsPhoto.Field['Image_Type'].Value
     else if jsPhoto.Field['image_type'] <> nil then
       image_id := jsPhoto.Field['image_type'].Value;

     if jsPhoto.Field['Image_Data'] <> nil then
       ImageData := varToStr(jsPhoto.Field['Image_Data'].Value)
     else if jsPhoto.Field['image_data'] <> nil then
       ImageData := varToStr(jsPhoto.Field['image_data'].Value);

    imgPhoto.PhotoType    := iPropID;
    imgPhoto.PhotoCaption := image_title;
    imgPhoto.PhotoDate    := DateToStr(date);
    imgPhoto.Image        := TJPEGImage.Create;
    //now get the image
    aImageStr   := Base64Decode(imageData);
    imageJPG    := TJPEGImage.Create;
    LoadJPEGFromByteArray(aImageStr,imageJPG);
    imgPhoto.FImage.Assign(imageJPG);
    LoadPhotoToCompDisplayList(i, iPropID, imgPhoto, image_title, PropIDList, PropIDList2); //PAM - Ticket #1339: pass the 2 stringlists to this
    FCompPhotoList.Add(imgPhoto);     //save it for later
   finally
     if assigned(imageJPG) then
       imageJPG.Free;
     if assigned(imgPhoto) then
       imgPhoto.Free;
   end;
end;



function CalcImageFrameTop(N:Integer; var leftPos: Integer):Integer;
const
  Delta = 3;
var
  aTop, aNum: Integer;
begin
  aTop := (N-1) Div MaxImagesPerRow;  //PAM: max # images per row is driven by config setting

  //to calculate the left position use the mod operation
  aNum := N mod MaxImagesPerRow;
  case aNum of
    1: leftPos := 0;
    0: leftPos := (MaxImagesPerRow -1) * FrameWidth;
    else
      leftPos := (aNum-1) * FrameWidth;
  end;

  if aTop = 0 then
    result := aTop
  else
    result := (aTop * FrameHeight) + Delta;
end;

function GetNameByTitle(aTitle:String):String;
begin
  aTitle := trim(aTitle);
  if CompareText('Front View', aTitle) = 0 then
    result := 'FrontView'
  else if CompareText('Rear View', aTitle) = 0 then
    result := 'RearView'
  else if CompareText('Street View', aTitle) = 0 then
    result := 'StreetView'
  else
    result := 'Unknown';
end;


procedure TInspectionDetail.LoadPhotoToTopSubjectSection(N: Integer; var aPhoto:TPhoto);  //PAM: this routine load subject Front/Rear/View to the top section.
const
  Delta = 100;
var
  leftPos: Integer;
  ImageFrame: TPanel;
  ImageCheckBox: TCheckBox;
  ImageTag: TEdit;  //PAM: Replace TLabel with TEdit for user to overwrite the image title.
  ImagePhoto: TImage;
  idx: Integer;
  image_Title : String;
begin
  leftPos := 0;
  image_Title := aPhoto.FCaption;

  //create the base frame
  ImageFrame := TPanel.Create(TopPhotoSection);  //set individual image panel's parent to the top photo section
  ImageFrame.parent  := TopPhotoSection;
  ImageFrame.ParentBackground := False;
  ImageFrame.Tag              := N;                   //allows us to identify clicked Image
  ImageFrame.height           := FrameHeight - 10;
  ImageFrame.top              := CalcImageFrameTop(N+1, leftPos);
  ImageFrame.Left             := leftPos;
  ImageFrame.width            := FrameWidth;
  ImageFrame.BevelInner       := bvNone;
  ImageFrame.BevelOuter       := bvNone;
  //ImageFrame.BevelWidth       := 0;
  ImageFrame.Name             := Format('Panel%d',[ImageFrame.Tag]);

  //Create Transfer Check Box
  ImageCheckBox := TCheckBox.Create(ImageFrame);
  ImageCheckBox.Parent        := ImageFrame;
  ImageCheckBox.Left          := 10;
  ImageCheckBox.Top           := 5;
  ImageCheckBox.Caption       := ChkBoxCaption;
  if FPhotoTopList.IndexOf(image_Title) = -1 then    //PAM - Ticket #1339: if this is the first time, check it
    ImageCheckBox.Checked     := True
  else
    ImageCheckBox.Checked     := False;
  ImageCheckBox.Tag           := N;
  ImageCheckBox.Width         := ThumbWidth;

  ImageCheckBox.Name          := GetNameByTitle(image_Title) + IntToStr(ImageCheckBox.Tag);  //Ticket #1407
  ImageCheckBox.OnClick       := SubjectTransferCheckBoxClick;

  //create image display
  ImagePhoto                  := TImage.Create(ImageFrame);
  ImagePhoto.Parent           := ImageFrame;
  ImagePhoto.Tag              := ImageFrame.Tag;
  ImagePhoto.Name             := Format('Image%d',[ImagePhoto.Tag]);
  ImagePhoto.Width            := ThumbWidth;
  ImagePhoto.Height           := ThumbHeight;
  ImagePhoto.Top              := ImageCheckBox.Top + ImageCheckBox.Height + 5;
  ImagePhoto.Left             := 10;


  if assigned(APhoto.Image) then
    ImagePhoto.Picture.Graphic:= APhoto.Image;
  ImagePhoto.Stretch := True;
  //Create image desc from inspection
  ImageTag                    := TEdit.Create(ImageFrame);
  ImageTag.Parent             := ImageFrame;
  ImageTag.Left               := 10;
  ImageTag.Top                := ImagePhoto.Top + ImagePhoto.Height + 5;
  ImageTag.Tag                := N;
  ImageTag.Name               := Format('Edit%d',[ImageTag.Tag]);
  ImageTag.Width              := ImagePhoto.width;
  ImageTag.AutoSize           := False;
  ImageTag.Enabled            := False;  //don't let user to overwrite

  if assigned(APhoto) then
    ImageTag.Text := APhoto.PhotoCaption;
  if ImageTag.Text = '' then
    ImageTag.Text := 'Photo ' + IntToStr(N+1);

  FPhotoTopList.add(image_Title);
end;


procedure TInspectionDetail.LoadPhotoToBottomSubjectSection(N: Integer; var aPhoto:TPhoto);  //PAM: this routine load subject extra photos to the bottom section
const
  Delta = 100;
var
  leftPos: Integer;
  ImageFrame: TPanel;
  ImageCheckBox: TCheckBox;
  ImageTag: TEdit;
  ImagePhoto: TImage;
  idx: Integer;
  image_Title : String;
begin
  leftPos := 0;
  image_Title := aPhoto.FCaption;

  //create the base frame
  ImageFrame            := TPanel.Create(BotBasePanel);
  ImageFrame.parent     := BotBasePanel;
  ImageFrame.ParentBackground := False;
  ImageFrame.Tag        := N;                   //allows us to identify clicked Image
  ImageFrame.height     := FrameHeight - 10;
  ImageFrame.top        := CalcImageFrameTop(N+1, leftPos);
  ImageFrame.Left       := leftPos;
  ImageFrame.width      := FrameWidth;
  ImageFrame.BevelInner := bvNone;
  ImageFrame.BevelOuter := bvNone;
  ImageFrame.BorderStyle := bsNone;
  ImageFrame.BevelWidth := 1;
  ImageFrame.Name := Format('Panel%d',[ImageFrame.Tag]);

  //Create Transfer Check Box
  ImageCheckBox         := TCheckBox.Create(ImageFrame);
  ImageCheckBox.Parent  := ImageFrame;
  ImageCheckBox.Left    := 10;
  ImageCheckBox.Top     := 5;
  ImageCheckBox.Caption := ChkBoxCaption;
  ImageCheckBox.Checked := True;
  ImageCheckBox.Name    := TRANSFER_NAME + IntToStr(N);
  ImageCheckBox.Tag     := N;
  ImageCheckBox.Width   := ThumbWidth;
  ImageCheckBox.Name    := Format('CheckBox%d',[ImageCheckBox.Tag]);

  //create image display
  ImagePhoto            := TImage.Create(ImageFrame);
  ImagePhoto.Parent     := ImageFrame;
  ImagePhoto.Tag        := ImageFrame.Tag;
  ImagePhoto.Name       := Format('Image%d',[ImagePhoto.Tag]);
  ImagePhoto.Width      := ThumbWidth;
  ImagePhoto.Height     := ThumbHeight;
  ImagePhoto.Top        := ImageCheckBox.Top + ImageCheckBox.Height + 5;
  ImagePhoto.Left       := 10;

  if assigned(APhoto.Image) then
    ImagePhoto.Picture.Graphic := APhoto.Image;
  ImagePhoto.Stretch    := True;
  ImagePhoto.OnDragOver := ImageDragOver;   //enable drag/drop in the bottom panel
  ImagePhoto.OnMouseDown:= ImageMouseDown;
  ImagePhoto.OnDragDrop := ImageDragDrop;
  ImagePhoto.OnEndDrag  := ImageEndDrag;

  //Create image desc from inspection
  ImageTag              := TEdit.Create(ImageFrame);
  ImageTag.Parent       := ImageFrame;
  ImageTag.Left         := 10;
  ImageTag.Top          := ImagePhoto.Top + ImagePhoto.Height + 5;
  ImageTag.Tag          := N;
  ImageTag.Name         := Format('Edit%d',[ImageTag.Tag]);
  ImageTag.Width        := ImagePhoto.width;
  ImageTag.AutoSize     := False;

  if assigned(APhoto) then
    ImageTag.Text := APhoto.PhotoCaption;
  if ImageTag.Text = '' then
    ImageTag.Text := 'Photo ' + IntToStr(N+1);

  FSubjectPhotoList.Add(ImageFrame);
  //readjust bottom photo section panel to make sure we can fit enough image
  if ImageFrame.Left = 0 then
    begin
      if BotBasePanel.Height < (ImageFrame.Height + ImageFrame.Top) then
        BotBasePanel.Height := ImageFrame.Height + ImageFrame.Top + ImageFrame.Height;
    end;
end;

procedure TInspectionDetail.ViewPicture(Sender: TObject);
var
  viewForm: TImageViewer;
  aImage: TImage;
  tempPath, tempFile: String;
begin
  tempPath := appPref_dirInspection;
  tempFile := tempPath + '\'+'temp.jpg';
  if sender is TImage then
    begin
       aImage := TImage(Sender);
       if not assigned(aImage) then exit;
       aImage.Picture.Graphic.SaveToFile(tempFile);  //save it to a stream
       ViewForm := TImageViewer.Create(self);
       try
         viewForm.LoadImageFromFile(tempFile);
         viewForm.Panel1.Align := alright;
//         viewForm.Panel1.Width := 0;
         viewForm.Show;
       finally
         if fileExists(tempFile) then
           DeleteFile(tempFile);
      end;
    end
  else
    ShowAlert(atWarnAlert, 'Cannot display this image. The file has been moved form it''s original location.');
end;

(*
procedure TInspectionDetail.ViewPicture(Sender: TObject);
var
  viewForm: TImageViewer;
  aImage: TImage;
  tempPath, tempFile: String;
begin
  tempPath := appPref_dirInspection;
  tempFile := tempPath + '\'+'temp.jpg';
  if sender is TImage then
    begin
      viewForm := TImageViewer.Create(self);
      viewForm.LoadImageFromFile(tempFile);
      viewForm.ImageDesc := ExtractFileName(tempFile);
      viewForm.Show;
    end
  else
    ShowAlert(atWarnAlert, 'Cannot display this image. The file has been moved form it original location: "' + tempFile + '"');
end;
*)

procedure TInspectionDetail.PhotoComboOnchange(Sender: TObject);
var
  aCombo: TComboBox;
  aCheckBox: TComponent;
  aTag: Integer;
  photos: TScrollBox;
begin
///  case PageControl.ActivePageIndex of
///    0: photos := PhotoDisplay;
///  end;
  if Sender is TComboBox then
    begin
      aCombo := TComboBox(Sender);
      aTag := aCombo.Tag;
      aCheckBox := FindAnyControl(Photos, TRANSFER_NAME + IntToStr(aTag));

      //auto select the checkbox when user picks a photo description
      if assigned(aCheckBox) then
        if aCombo.Text <> '' then
          TCheckBox(aCheckBox).Checked := True
        else
          TCheckBox(aCheckBox).Checked := False;
    end;
end;

procedure TInspectionDetail.MouseDownOnImage(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Pt: TPoint;
  N: Integer;
  fPath: String;
begin
  if (sender is TImage) and (ssRight in Shift) then
    begin
      Pt := (Sender as TImage).ClientToScreen(Point(X,Y));
    end
  else if (sender is TImage) and not (ssDouble in Shift) then
    begin
      TImage(Sender).BeginDrag(False, 5);
    end;
end;

procedure TInspectionDetail.DragImageStart(Sender: TObject;var DragObject: TDragObject);
var
  Image2Drag: TDragImage;
  N: Integer;
  aImageFile: String;
  aImage: TImage;
begin
  if sender is TImage then   //if we are the image that wants to drag
    begin
      aImage := TImage(Sender);
      aImageFile := FPhotoPath + 'temp.jpg';
      aImage.Picture.SaveToFile(aImageFile);

      Image2Drag := TDragImage.create;
      Image2Drag.ImageCell := nil;
      Image2Drag.IsThumbImage := True;
      Image2Drag.ImageFilePath := aImageFile;
      DragObject := Image2Drag;       //send it off
    end;
end;






procedure TInspectionDetail.btnSelectAllPhotosClick(Sender: TObject);
var i,j:Integer;
  aFrame: TComponent;
begin
  //Mark all check boxes as checked in the photo sheet
(*
  for i:=0 to PhotoDisplay.ComponentCount - 1 do
    if PhotoDisplay.Components[i].ClassNameIs('TPanel') then
      begin
        aFrame := PhotoDisplay.Components[i];
        for j:=0 to aFrame.ComponentCount - 1 do
          if aFrame.Components[j] is TCheckBox then
            TCheckBox(aFrame.Components[j]).Checked := True;
      end;
*)
end;





function TInspectionDetail.LoadCompDropDownItems:String;
var
  i: Integer;
begin
  result := '';
  for i:= 1 to FSaleCount do
    begin
      if result = '' then
        result := Format('Comp#%d - Front View',[i])
      else
        result := result + #13#10 + Format('Comp#%d - Front View',[i]);
    end;
  for i:= 1 to FListCount do
    begin
      if result = '' then
        result := Format('Listing#%d - Front View',[i])
      else
        result := result + #13#10 + Format('Listing#%d - Front View',[i]);
    end;
end;

function CalcCompPanelLeft(N, iPropID:Integer):Integer;
begin
  if iPropID = 1 then
    result := 0
  else
    result := (iPropID -1) * FrameWidth;
end;

function TInspectionDetail.CalcCompPanelTop(N, iPropID:Integer; aCompPanel:TPanel):Integer;
var
  aPanel, aFrame:TComponent;
  i, aCount:Integer;
begin
  aCount := 0;
  result := 0;
  for i:= 0 to aCompPanel.ComponentCount -1 do
    begin
      if aCompPanel.Components[i] is TPanel then
        begin
          aFrame := TPanel(aCompPanel).Components[i];
          inc(aCount);
        end;
    end;
  if aCount = 0 then
    result := 0
  else if assigned(aFrame) then
    result := (aCount * TPanel(aFrame).Height) + 5;

end;

//walk through the compPanel to find how many frame do we have
function TInspectionDetail.GetFrameIDByPropdID(CompPanel,ImageFrame:TPanel; iPropID:Integer):Integer;
var
  i, aCount: Integer;
  aFrame: TPanel;
  aName: String;
begin
  aCount := 0;
  for i:= 0 to CompPanel.ComponentCount - 1 do
    begin
      if (CompPanel.Components[i] is TPanel) then
        begin
          aFrame := TPanel(CompPanel.Components[i]);
          aName := UpperCase(aFrame.Name);
          if pos('FRAME', aName) > 0 then
           inc(aCount);
        end;
    end;
  result := aCount;
end;

function TInspectionDetail.CreateCompPanel(aPhotoDisplay:TScrollBox; N, iPropID:Integer):TPanel;
begin
  result := TPanel.Create(aPhotoDisplay);
  result.Parent := aPhotoDisplay;
  result.align  := alNone;
  result.width  := FrameWidth;
  result.Left   := CalcCompPanelLeft(N, iPropID);
  result.Height := aPhotoDisplay.Height;
  result.Tag    := iPropID;
  result.Name   := Format('CompPanel%d',[N]);
  result.width  := 0;  //set to 0 first, until we have the prodid matches with the comppanelname
  result.Caption := '';
end;

procedure TInspectionDetail.CreateCompDisplay(i,N, iPropID:Integer; APhoto:TPhoto; image_title:String; var PropIDList, PropIDList2:TStringList);
var
  leftPos: Integer;
  ImageFrame: TPanel;
  ImageCheckBox: TCheckBox;
  ImageLabel: TLabel;
  ImagePhoto: TImage;
  idx: Integer;
  aPhotoDisplay: TScrollBox;
  CompPanel: TPanel;
  aComponent: TComponent;
  aFrameID:Integer;
  aCompPanelName: String;
  aChecked: Boolean;
  aCaption: String;
begin
  leftPos := 0;
  aPhotoDisplay := PhotoDisplayComps;
  aCompPanelName := Format('CompPanel%d',[i]);
  aComponent := FindAnyControl(PhotoDisplayComps, aCompPanelName);
  if not assigned(aComponent) then
    CompPanel := CreateCompPanel(aPhotoDisplay, i, iPropID)
  else
    CompPanel := TPanel(aComponent);
  if not assigned(CompPanel) then exit;

  if GetValidInteger(CompPanel.Name) =  iPropID then
    begin
      CompPanel.Width   := FrameWidth; //the first thing we need to do is to set the width back
      ImageFrame := TPanel.Create(CompPanel);
      ImageFrame.parent  := CompPanel;
      ImageFrame.height  := FrameHeight;
      ImageFrame.top     := CalcCompPanelTop(N, iPropID, CompPanel);
      ImageFrame.align   := alTop;
      ImageFrame.width   := FrameWidth;
      ImageFrame.BevelInner := bvNone;
      ImageFrame.BevelOuter := bvNone;
      ImageFrame.BevelWidth := 2;
      aFrameID := GetFrameIDByPropdID(CompPanel,ImageFrame, iPropID);
      ImageFrame.Tag     := aFrameID;                   //allows us to identify clicked Image
      ImageFrame.Name    := Format('Frame%d',[aFrameID]);
      ImageFrame.Caption := '';  //github #678

      //Create image desc from inspection
      ImageLabel := TLabel.Create(ImageFrame);
      ImageLabel.Parent := ImageFrame;
      ImageLabel.Left   := 10;
      ImageLabel.Top    := 2;
      ImageLabel.Name   := 'Label';;
      ImageLabel.Tag    := N;
      ImageLabel.Width  := ImageFrame.width - 2;
      ImageLabel.Alignment := taCenter;
      ImageLabel.AutoSize  := False;
      acaption := trim(image_title);
//github #915: only default to Front view if no labels
      if aCaption = '' then
        aCaption := 'Front View';
      //github #723
      if FListCount > 0 then
        begin
          if iPropID - FListCount > FSaleCount then
            ImageLabel.Caption := Format('Listing #%d - %s',[iPropID - FSaleCount, aCaption])
          else
            ImageLabel.Caption := Format('Sale #%d - %s',[iPropID, aCaption]);
        end
      else
            ImageLabel.Caption := Format('Sale #%d - %s',[iPropID, aCaption]);

    //Create Transfer Check Box
    ImageCheckBox := TCheckBox.Create(ImageFrame);
    ImageCheckBox.Parent  := ImageFrame;
    ImageCheckBox.Left    := 10;
    if assigned(ImageLabel) then
      ImageCheckBox.Top   := ImageLabel.Top + ImageLabel.Height + 8
    else
      ImageCheckBox.Top     := 5;
    ImageCheckBox.Caption := ChkBoxCaption;
    aChecked := False;  //PAM - Ticket #1339: uncheck the check box first
    if PropIDList2.IndexOf(Format('%d',[iPropID])) = -1 then    //PAM - Ticket #1339: if this is the first time, check it
      begin
        aChecked := True;  //default is alawys checked     //PAM - Ticket #1339: check the check box to use this image.
        PropIDList2.Add(Format('%d',[iPropID]));   //PAM - Ticket #1339: add to the list so next time we won't check the check box with same comp # different pictures
      end;
    ImageCheckBox.Checked := aChecked;
    ImageCheckBox.Name    := TRANSFER_NAME + IntToStr(aFrameID);
    ImageCheckBox.Tag     := N;
    ImageCheckBox.Width   := thumbWidth;

    //create image display
    ImagePhoto := TImage.Create(ImageFrame);  //image is owned by Border Panel
    ImagePhoto.parent := ImageFrame;
    ImagePhoto.Name   := IMAGE_NAME + IntToStr(aFrameID);
    ImagePhoto.left   := 10;
    ImagePhoto.top    := ImageCheckBox.top + ImageCheckBox.Height + 2;
    ImagePhoto.height := ThumbHeight;
    ImagePhoto.width  := ThumbWidth;
    ImagePhoto.stretch:= True;
    ImagePhoto.Proportional := True;
    ImagePhoto.Tag    := N;
    if assigned(APhoto.Image) then
      begin
        ImagePhoto.Picture.Graphic := APhoto.Image;
      end;
    ImagePhoto.OnDblClick  := ViewPicture;
    ImagePhoto.OnMouseDown := MouseDownOnImage;
    ImagePhoto.OnStartDrag := DragImageStart;
    ImageCheckBox.OnClick  := CompTransferCheckBoxClick;

  //Readjust the base panel width
  if CompBasePanel.Width <= (PhotoDisplayComps.left+PhotoDisplayComps.Width + 10) then
    CompBasePanel.Width := PhotoDisplayComps.Left + (PhotoDisplayComps.width + ThumbWidth);
  if CompBasePanel.Height <= (ImageFrame.top + ImageFrame.Height + 10) then
    CompBasePanel.Height := ImageFrame.Top + (ImageFrame.Height + ThumbWidth);
  end;
end;
procedure TInspectionDetail.LoadPhotoToCompDisplayList(N: Integer; iPropID: Integer; APhoto: TPhoto; image_title: String; var PropIDList, PropIDList2:TStringList);
var
  i:Integer;
begin
  try
    //github #744: we need to create comp panel for the missing comp photo
    //the loading comp to the panel logic, we need to create panels for all the missing photo
    //so the populating routine can walk through the whole loop to just pick up the one with the image
    if N >= iPropID then
     begin
       //create the base frame
        i := iPropID;
        CreateCompDisplay(i,N,iPropID, APhoto,image_title, PropIDList, PropIDList2);   //PAM - Ticket #1339: pass the 2 stringlists to this
     end
    else
//      for i:= N+1 to iPropID do  //Ticket #1341: if we have 6 comps, comp #5 has no image, we still need to create panel 5 for comp 5 for populate routine works correctly.
      for i:= N to iPropID do
      begin
       //create the base frame
        CreateCompDisplay(i,N,iPropID, APhoto,image_title, PropIDList, PropIDList2);   //PAM - Ticket #1339: pass the 2 stringlists to this
      end;
  except on E:Exception do
    showmessage('LoadPhotoToCompDisplayList: '+e.Message);
  end;
end;



procedure TInspectionDetail.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TInspectionDetail.SaveImageFormOptions;
begin
   case rdoMainSubject.ItemIndex of
     0: FSubjectMainFormID := 301;
     1: FSubjectMainFormID := 4103;
   end;

   case rdoExtraSubject.ItemIndex of
     0: FSubjectExtraFormID := 302;
     1: FSubjectExtraFormID := 324;
     2: FSubjectExtraFormID := 326;
     3: FSubjectExtraFormID := 325;
   end;

   case rdoMainComp.ItemIndex of
     0: FCompMainFormID := 304;
//     1: FCompMainFormID := 4084;
     1: FCompMainFormID := 4181;
   end;
end;

procedure TInspectionDetail.FillCommentAddendum(SummaryNote:String); //Ticket #1550
const
  CommentAddendumFormID = 98;
  SummaryHeader = 'INSPECT A LOT SUMMARY NOTES';
  CRLF=#13#10;
var
  thisForm: TDocFOrm;
begin
  thisForm := Fdoc.InsertBlankUID(TFormUID.Create(CommentAddendumFormID), true, -1); //always insert

  if thisForm <> nil then
    begin
      thisFOrm.SetCellText(1, 1, FDoc.GetCellTextByID(8)); //we need to fill up the header
      thisForm.SetCellText(1,2, FDoc.GetCellTextByID(2));
      thisForm.SetCellText(1,3, FDoc.GetCellTextByID(3));
      thisForm.SetCellText(1,4, FDoc.GetCellTextByID(4));
      thisForm.SetCellText(1,5, FDoc.GetCellTextByID(45));
      thisForm.SetCellText(1,6, FDoc.GetCellTextByID(46));
      thisForm.SetCellText(1,7, FDoc.GetCellTextByID(47));
      thisForm.SetCellText(1,8, FDoc.GetCellTextByID(50));
      thisForm.SetCellText(1,9, FDoc.GetCellTextByID(48));
      thisForm.SetCellText(1,10, FDoc.GetCellTextByID(49));
      thisForm.SetCellText(1,11, FDoc.GetCellTextByID(35));
      thisForm.SetCellText(1,12, FDoc.GetCellTextByID(36));
      SummaryNote := SummaryHeader + CRLF + CRLF +SummaryNote;
      thisForm.SetCellText(1,13, SummaryNote);
    end;
end;

procedure TInspectionDetail.btnTransferClick(Sender: TObject);
var
  aContinue, isAbort, isOverwriteData:Boolean;
  aOption, FormID, FormCertID,formIdx: Integer;
  jsdata, jSubject, jpostedData, jComps,jSummary,js_Sketcher_Page_Count: TlkJSONBase;
  inspection_data, subject_data, comps_data:String;
  jsPhotoList : TlkJSONBase;
  Sketch: TlkJSONBase;
  sketcher_page_count,sketcher_packet_version: String;
  sketcher_mdata_version,sketchMdata: String;
  js_image_array, js_Sketch_data, js_Sketch_array, js_Sketch_MData_Array, js: TlkJSonBase;
  f:Integer;
  aMsg: String;
  aOrder:TOrderManager;
  SummaryNote:String;
begin
 FAreaList.Clear;
 FLog := TStringList.Create;
 FGLANames.Clear;
 FNonGLANames.Clear;
 try
  try
    SaveImageFormOptions;
    if assigned(FDoc) and (Fdoc.FormCount > 0) then //if forms exist, give user a choice to override or create new container
      begin
        //if it's new form, we need to pop up dialog to ask user to save
        if FDoc.docDataChged and FDoc.docIsNew  and not FOverwriteData then
          begin
            if Ok2Continue('Do you want to save your changes before you continue?') then
              FDoc.SaveAs;
          end
        else if not FOverwriteData then
          begin
            if FDoc.docDataChged then //need to pop message if we detect a change in an existing report
              FDoc.Save;
          end;

          isAbort := False;
          if Fdoc.FormCount > 0 then //if forms exist, give user a choice to override or create new container
            begin
              //isOverwriteData := False;  //github 243
              isOverwriteData := FOverwriteData;
              aOption:=	WhichOption123Ex(isOverwriteData, 'Existing Report', 'New Report', 'Cancel',
              //github #198
              'Would you like to transfer data from Inspect-a-Lot to existing report or start a new report? ', 100, True);
              if aOption = mrYes then
                begin
                  //if this is an empty report, set overwritedata to true so it won't get mess up with the math process
//                  if FDoc.GetCellTextByID(925) = '' then
//                    isOverwriteData := True;
                  FOverwriteData := isOverwriteData;
                end
              else if aOption = mrNo then
              begin
                  FOverwriteData := True;   //this is a new container
                  TMain(Application.MainForm).FileNewDoc(nil);
                  Fdoc := TMain(Application.MainForm).ActiveContainer;
                  FOverwriteData := True;  //github 209: always overwrite when we create a new report
                  //rebuild the Comp table for sales and listing in case we pick a new container
                  if assigned(FDocCompTable) then
                    FDocCompTable.BuildGrid(FDoc, gtSales);

                  if assigned(FDocListTable) then
                    FDocListTable.BuildGrid(FDoc, gtListing);
              end
              else  //quit
                begin
                  isAbort := True;
                  Exit;
                end;
           end;
    end;
    //start logging...
    myLog := TStringList.Create;
    //github #647: use property type to return the correct form id
  jSubject := TlkJsonObject(FjPostedData).Field['Subject'];
  subject_data := TlkJSON.GenerateText(jSubject);
  Application.ProcessMessages;
  LoadInspectionData_SubjectData(subject_data);
     if Fdoc.docForm.Count > 0 then   //Ticket #1085
       MainFormExist(FDoc, FormID)
     else
    FormID := GetFormIDbyPropertyType(FSubjectData2.PropertyType, FUploadInfo2.insp_Type);
    //github #605
    FormCertID := GetFormCertID(FormID); //use the main form id to get the cert form for that form id
    if not ChkSketchONLY.Checked then
      begin
      if FormID > 0 then  //only do for > 0
        begin
          if not assigned(FDoc.GetFormByOccurance(formID,0,false)) then   //cannot locate the main form
            begin
              if FDoc.GetCellTextByID(925) = '' then
                FDoc.InsertBlankUID(TFormUID.Create(FormID), true, -1, False); //create it
              //rebuild the Comp table for sales and listing in case we pick a new container
              if assigned(FDocCompTable) then
                FDocCompTable.BuildGrid(FDoc, gtSales);

              if assigned(FDocListTable) then
                FDocListTable.BuildGrid(FDoc, gtListing);
            end;
        end;
          //github #605

        if formCertID > 0 then
          begin
            if not assigned(FDoc.GetFormByOccurance(formCertID,0,false)) then
            begin
              formIdx := GetFormIndex(FDoc, FormID);
              if formIdx <> -1 then
                formIdx := FormIdx + 1;  //make sure we add after the 1004
              FDoc.InsertBlankUID(TFormUID.Create(FormCertID), true, formIdx, False);
            end;

          end;
      end;
   aContinue := True;
   if not chkSketchONLY.Checked then
    begin
      ImportSubjectDataToReport2;

      //load comp data
      jComps := TlkJsonObject(FjPostedData).Field['Comps'];
      comps_data := TlkJSON.GenerateText(jComps);
      ImportCompDataToReport(comps_data);


      aContinue := TransferSubjectPhotos;
      if aContinue then
        aContinue := TransferCompPhotos;
    end;
  //handle sketches
  if FSketchJSon <> '' then
    begin
      js:= TlkJSON.ParseText(FSketchJSon);
      if js <> nil then
        begin
          //handle sketches
          js_Sketch_array := js.Field['Sketcher_Pages'];
          js_Sketcher_Page_Count := js.Field['Sketcher_Page_Count'];
          js_Sketch_MData_Array := js.Field['Sketcher_Meta_Data'];
          if (js_Sketcher_Page_Count <> nil) and (js_Sketcher_Page_Count.Value > 0) then
          //if (js_Sketch_array <> nil) and (js_Sketch_MData_Array <> nil) then
             begin
               DownloadSketchJSon(js_Sketch_array, js_Sketch_MData_Array, True);
             end;
        end;
    end;

    //Ticket #1404: Lastly, handle sketch definition data
   Sketch := TlkJsonObject(FjPostedData).Field['Sketch'];
   if Sketch = nil then
      Sketch:= TlkJSON.ParseText(FSketchJSon);

   if rdoSketchData.ItemIndex = 1 then
     ImportSketchDefinitionToReport(Sketch);

   if not chkSketchONLY.Checked then
     begin
        jSummary := TlkJsonObject(FjPostedData).Field['Summary']; //Ticket #1550
        if jSummary.Field['SummaryNote'] <> nil then
          begin
            SummaryNote := varToStr(jSummary.Field['SummaryNote'].Value);
            if length(SummaryNote) > 0 then //if we have summary note, fill in form #98: Comment addendum Cell seq #13
              FillCommentAddendum(SummaryNote);
          end;
     end;

   if aContinue then
     begin
       if chkSaveWorkFile.Checked then
         begin
           if not appPref_AutoCreateWorkFileFolder then
             begin
               ShowNotice('A work file folder will be created in the Inspection folder.');
             end;
         end;
       appPref_AutoCreateWorkFileFolder := chkSaveWorkFile.Checked;
       WriteToIniFile;
       if chkSaveWorkFile.Checked then
         SaveToWorkFile;
       SendAcknowledgementByID(FUploadInfo2);
       if assigned(FInspectionManager) then
         TCC_Mobile_Inspection(FInspectionManager).btnRefresh.click;
     end;
   except on E:Exception do
     ShowNotice('Error in converting Transfering Mobile App data: '+e.Message);
   end;
 finally
//    for f := 0 to FDoc.docForm.Count - 1 do  //Ticket #1359: per Jeff, no need to populate context id.
//      FDoc.PopulateFormContext(FDoc.docForm[f]);

   if assigned(FLog) then
     FLog.Free;
   if aContinue then
     begin
       if (FDoc.FAMCOrderInfo.TrackingID > 0) and (pos('inspection complete', lowerCase(FDoc.FAMCOrderInfo.OrderStatus)) = 0) then  //this is a Mercury order
         begin
           aMsg := 'Your inspection data has been transferred to your report, '+
                   'do you want to set the order status as Inspection Completed?';
           if OK2Continue(aMsg) then
             begin
                aOrder := TOrderManager.Create(Fdoc);
                aOrder.FRunInBackground := true;
                aOrder.ShowModal;
                aOrder.Free;
             end;
         end;

       btnClose2.Click;
     end;
 end;
end;


procedure TInspectionDetail.WriteToIniFile;
var
  PrefFile: TMemIniFile;
  IniFilePath : String;
begin
  IniFilePath := IncludeTrailingPathDelimiter(appPref_DirPref) + cClickFormsINI;
  PrefFile := TMemIniFile.Create(IniFilePath);                   //create the INI writer

  With PrefFile do
    begin
      WriteBool('Operation', 'AutoCreateWorkFileFolder',appPref_AutoCreateWorkFileFolder);
      WriteInteger('Inspection', 'SubjectMainFormID', FSubjectMainFormID);
      WriteInteger('Inspection', 'SubjectExtraFormID', FSubjectExtraFormID);
      WriteInteger('Inspection', 'CompMainFormID', FCompMainFormID);
      WriteInteger('Inspection', 'DataStructureVersionID', FDataStructureVersionNumber);
      WriteInteger('Inspection', 'UseSketchwCalc', rdoSketchData.ItemIndex);
      WriteBool('Inspection', 'DefaultOverwriteData', FOverwriteData);
      UpdateFile;      // do it now
    end;

  PrefFile.Free;
end;

procedure TInspectionDetail.LoadFromIniFile;
var
  PrefFile: TMemIniFile;
  IniFilePath : String;
begin
  IniFilePath := IncludeTrailingPathDelimiter(appPref_DirPref) + cClickFormsINI;
  PrefFile := TMemIniFile.Create(IniFilePath);                   //create the INI writer

  With PrefFile do
    begin
      FSubjectMainFormID := ReadInteger('Inspection', 'SubjectMainFormID', 301);
      FSubjectExtraFormID := ReadInteger('Inspection', 'SubjectExtraFormID', 302);
      FCompMainFormID := ReadInteger('Inspection', 'CompMainFormID', 304);
      appPref_AutoCreateWorkFileFolder := ReadBool('Operation', 'AutoCreateWorkFileFolder', True);
      rdoSketchData.ItemIndex := ReadInteger('Inspection', 'UseSketchwCalc', 0);
      FOverwriteData := ReadBool('Inspection', 'DefaultOverwriteData', False);
    end;

  PrefFile.Free;
end;

function TInspectionDetail.GetWorkFilePath(doc: TContainer): String;
var
  aFilePath: String;
  aFileName: String;
begin
   aFileName := lblSubjectAddr.Caption;
   aFileName := StripUnwantedCharForFileName(aFileName); //Ticket #1194

  case appPref_DefFileNameType of
    fnUtitled, fnAddress: begin
    aFilePath := aFileName

    end;
    fnFileNo: aFilePath := doc.GetCellTextByID(2);
    fnBorrower: aFilePath := doc.GetCellTextByID(45);
    fnInvoice: aFilePath := doc.GetCellTextByID(1255);     //added Oct 2006 for saving file as Invoice#
  else
    aFilePath := aFileName;
  end;

  result := trim(appPref_DirInspection) +'\'+trim(aFilePath);
end;

procedure TInspectionDetail.SaveDataWorkFile(aPath:String);
var
  aFilePath, aFileName, aFullFileName: String;
begin
  begin
   // aFilePath := extractFileDir(aPath);    //Ticket #1194
    aFileName := extractFileName(lblSubjectAddr.Caption+'.txt');
    aFileName := StripUnwantedCharForFileName(aFileName);  //Tickt #1194
    ForceDirectories(aPath); //Ticket #1253: aPath is the correct path for us to save. it's the ressult from GetWorkFIlePath function
    aFullFileName := trim(aPath) + '\'+trim(aFileName);
    jsonMemo.Lines.SaveToFile(aFullFileName);
  end;
end;

procedure TInspectionDetail.SaveSubjectImageWorkFile(aPath:String);
var
  i, image_id: Integer;
  aEdit: TComponent;
  aImagePhoto: TComponent;
  aLabel: TComponent;
  aFileName:String;
  aCnt: Integer;
  aFullFileName: String;
begin
  aCnt := 0;
    //Save subject top section to work file
    for i:= 0 to TopPhotoSection.ComponentCount - 1 do
      begin
        aEdit := FindAnyControl(TopPhotoSection, 'Edit' + IntToStr(i));
        if aEdit is TEdit then
          if (i < FSubjectPhotoList.count) and Assigned(FSubjectPhotoList.Items[i]) then  //make sure we have a photo
            begin
              image_id := GetImageId(TEdit(aEdit).Text);
              aImagePhoto := FindAnyControl(TopPhotoSection, 'Image' + IntToStr(i));
              if TEdit(aEdit).Text <> '' then
                aFileName :=  'Sub-'+trim(TEdit(aEdit).Text)
              else
                begin
                  inc(aCnt);
                  aFileName :=  Format('Sub-Untitle%d',[aCnt]);
                end;
              aFileName := StripUnwantedChar(aFileName);
              if aFileName <> '' then
                aFileName := trim(aFileName) + '.jpg'
              else
                aFileName :=  Format('Sub-Untitle%d',[aCnt]) +'.jpg';
              aFullFileName := trim(aPath) + '\'+trim(aFileName);
              TImage(aImagePhoto).Picture.Graphic.SaveToFile(aFullFileName);
            end;
      end;
    //save subject bottom section
    for i:= 0 to BotBasePanel.ComponentCount - 1 do
      begin
        aEdit := FindAnyControl(BotBasePanel, 'Edit' + IntToStr(i));
        if aEdit is TEdit then
          if (i < FSubjectPhotoList.count) and Assigned(FSubjectPhotoList.Items[i]) then  //make sure we have a photo
            begin
              image_id := GetImageId(TEdit(aEdit).Text);
              aImagePhoto := FindAnyControl(BotBasePanel, 'Image' + IntToStr(i));
              if TEdit(aEdit).Text <> '' then
                aFileName :=  'Sub-'+trim(TEdit(aEdit).Text)
              else
                begin
                  inc(aCnt);
                  aFileName :=  Format('Sub-Untitle%d',[aCnt]);
                end;
              aFileName := StripUnwantedChar(aFileName);
              if aFileName <> '' then
                aFileName := trim(aFileName) + '.jpg'
              else
                aFileName :=  Format('Sub-Untitle%d',[aCnt]) +'.jpg';
              aFullFileName := trim(aPath) + '\'+trim(aFileName);
              TImage(aImagePhoto).Picture.Graphic.SaveToFile(aFullFileName);
            end;
      end;

end;


procedure TInspectionDetail.SaveCompImageWorkFile(aPath:String);
var
  i, j: Integer;
  aImagePhoto: TComponent;
  aFileName, aFilePath:String;
  aCnt: Integer;
  aCompPanel: TComponent;
  aLabel: TComponent;
  aFrame: TPanel;
  aPropID: Integer;
  aTitle: String;
  aFullFileName: String;
begin
  aCnt := 0;

   for i:= 0 to (FSaleCount + FListCount) - 1 do
      begin
        aCompPanel := FindAnyControl(PhotoDisplayComps, 'CompPanel'+IntToStr(i+1));
        if assigned(aComppanel) and (aCompPanel is TPanel) then
          for j:= 0 to aCompPanel.ComponentCount -1 do
            begin
               if aCompPanel.Components[j] is TPanel then
                 begin
                   aFrame := TPanel(aCompPanel.Components[j]);
                   if not assigned(aFrame) then continue;
                   aLabel := FindAnyControl(aFrame, 'Label');
                   if assigned(aLabel) and (aLabel is TLabel) then
                     aTitle := TLabel(aLabel).Caption;
                   aPropID := getValidInteger(TPanel(aCompPanel).Name);
                   aImagePhoto := FindAnyControl(aFrame, IMAGE_NAME + IntToStr(j));
                   if assigned(aImagePhoto) then
                     begin
                       if aTitle <> '' then
                          aFileName := trim(aTitle)
                       else
                         begin
                           inc(aCnt);
                           aFileName := Format('Untitle%d',[aCnt]);
                         end;
                       aFileName := StripUnwantedChar(aFileName);
                       if aFileName <> '' then
                         aFileName := trim(aFilename) + '.jpg'
                       else
                         aFileName := trim(aPath) + Format('Untitle%d',[aCnt]) +'.jpg';

                       TImage(aImagePhoto).Picture.Graphic.SaveToFile(aPath + '\'+aFileName);
                     end;
               end;
             end;
      end;
end;

procedure TInspectionDetail.SaveSketchDataWorkFile(aPath:String);
var
  Photo: TJPEGImage;
  i: Integer;
  aFileName: String;
  js,joSketch: TlkJSonBase;
  itjs: TlkJSonObject;
  image, sketcher_image: String;
  addrLabel: String;
begin
  if FSketchJSon <> '' then
    begin
      js:= TlkJSON.ParseText(FSketchJSon);
      if js <> nil then
        begin
          joSketch := js.Field['Sketcher_Pages'];
        end;
    end;

  if FSketchJSon = '' then exit;
  if not assigned(joSketch) then exit;
  //we are good to continue
  for i:= 0 to pred(joSketch.Count) do
    begin
       itjs := (joSketch.Child[i] as TlkJSONobject);
       image := '';
       //version := itjs.getString('Version');
       if not (itjs.Field['Sketcher_Image'] is TlkJSONnull) then
         begin
           sketcher_image := itjs.getString('Sketcher_Image');
           image := Base64Decode(sketcher_image);
         end;
       if length(image) = 0 then continue;
       Photo := TJPEGImage.Create;
       try
         LoadJPEGFromByteArray(image,Photo);
         addrLabel := lblSubjectAddr.Caption;
         addrLabel := StripUnwantedCharForFileName(addrLabel); //Ticket #1194
         aFileName := Format('%s\%s-Sketch-%d.jpg',[aPath,trim(addrLabel),i+1]);
         Photo.SaveToFile(aFileName);
       finally
         if assigned(Photo) then
           Photo.Free;
       end;
    end;
end;


procedure TInspectionDetail.SaveToWorkFile;
var
  aFilePath, aMsg: String;
  SaveDialog: TSaveDialog;
  oktoSave: Boolean;
begin
  aFilePath := GetWorkFilePath(FDoc);
  //check to make sure folder exists
  if not DirectoryExists(aFilePath) then
    ForceDirectories(trim(aFilePath));
  if not DirectoryExists(aFilePath) then
    begin
      aMsg := 'Cannot create work file folder[%s] for this inspection.  Will save to Unknown folder.';
      aFilePath := appPref_dirInspection+'\Unknown';
    end;
    SaveDataWorkFile(aFilePath);
    SaveSubjectImageWorkFile(aFilePath);
    SaveCompImageWorkFile(aFilePath);
    SaveSketchDataWorkFile(aFilePath);
end;


procedure TInspectionDetail.ImportCompDataToReport(Comps_data:String);
begin
  case FVersionNumber of
      1: ImportCompDataToReport_V1(Comps_data);
      else ImportCompDataToReport_V2(Comps_data);
  end;
end;


procedure TInspectionDetail.ImportCompDataToReport_V1(Comps_data:String);
var
  jCompObj, jc:TlkJSONObject;
  FjCompObj: TlkJSONList;
  aCompType,aItem:String;
  i,j, CompNo: Integer;
  Address, CityStZip, aCity, aState, aZip, FHBath: String;
  aFull, aHalf:Integer;
  aGarageCellValue: String;
  dw, ga, gd, gbi, cpa, cpd: Integer;
  aQuality, aActualAge, aCondition, aHeatingCooling, aHeat, aCooling: String;
  aFactor1, aFactor2, aFactor1Other, aFactor2Other, aView, aLocation: String;
  aInfl, aInt{, aStories}: Integer;
  aStories: Double;  //github #: stories can be double 1.5
  aCool, aStructure, aDesign, aDesignStyle: String;
  aTotalArea, aFinishArea, aFinishPercent, aAccess, aCellvalue: String;
  rr, br, ba, fba, hba, o: Integer;
  aLatLon: String;
  aGarage, aCarport, aDriveWay: Integer;
  iCondition, iQuality: Integer;
  GLA, aViewFactor, aLocationFactor, aSiteArea: String;
  aUnitNumber:String;
  aStr:String;
begin
  FSaleCount := 0;
  FListCount := 0;
  FjCompObj := TlkJSON.ParseText(Comps_data) as TlkJSONList;
  if FjCompObj = nil then exit;
  if not assigned(FDoc) then
  FDoc := Main.ActiveContainer;
  j := 0;
  try
  for i:= 0 to FjCompObj.Count -1 do
    begin
      jCompObj := FjCompObj.Child[i] as TlkJSONObject;  //get each comp
      if jCompObj = nil then continue;
      aCompType := GetJsonString('CompType', jCompObj);
      if aCompType = '' then
        aCompType := 'Sale';
      if pos('SALE', UpperCase(aCompType)) > 0 then
        begin
          Address := GetJsonString('Address', jCompObj);
          if Address = '' then continue;  //we don't want to continue if address is empty
          aCity  := GetJsonString('City', jCompObj);
          aState := GetJsonString('State', jCompObj);
          aZip   := GetJSonString('ZipCode', jCompObj);
          CityStZip := Format('%s, %s %s',[aCity, aState, aZip]);
          aUnitNumber := GetJsonString('UnitNumber', jCompObj);
          if aUnitNumber <> '' then
            //CityStZip := Format('%s; %s',[aUnitNumber,CityStZip]);
            CityStZip := Format('%s, %s',[aUnitNumber,CityStZip]); //github #663

          aFull := GetValidInteger(GetJsonString('ABBath', jCompObj));
          aHalf := GetValidInteger(GetJsonString('ABHalf', jCompObj));
          FHBath := '';
          if (aFull > 0) or (aHalf > 0) then
            FHBath := Format('%d.%d',[aFull, aHalf]);
          CompNo := i+1;
          aLatLon := Format('%s;%s',[ GetJsonString('Latitude', jCompObj),GetJsonString('Longitude', jCompObj) ]);
          if aLatLon <> '' then  //github #816
            ImportGridData(CompNo, FDoc, '9250', aLatLon, FDocCompTable);
          ImportGridData(CompNo, FDoc, '925', GetJsonString('Address', jCompObj), FDocCompTable);
          ImportGridData(CompNo, FDoc, '926', CityStZip, FDocCompTable);
          aSiteArea := GetJsonString('SiteArea', jCompObj);
          if getValidInteger(aSiteArea) > 0 then
            begin
              if pos('ac', lowerCase(aSiteArea)) > 0 then
                begin
                  ImportGridData(CompNo, FDoc, '976', trim(aSiteArea), FDocCompTable);
                end
              else
                begin
                  if pos('sf', aSiteArea) > 0 then
                    aSiteArea := popStr(aSiteArea, 'sf');
                  aInt := GetValidInteger(aSiteArea);      //github #183: add ,
                  aSiteArea := FormatFloat('#,###', aInt);
                  ImportGridData(CompNo, FDoc, '976', trim(aSiteArea), FDocCompTable);
                end;
            end;
          GLA := GetJsonString('Gla', jCompObj);
          aInt := GetValidInteger(GLA);      //github #183: add ,
          GLA := FormatFloat('#,###', aInt);
          ImportGridData(CompNo, FDoc, '1004', GLA, FDocCompTable);

          //Condition Rating
          iCondition := TranslateMobileCondition(GetJsonInt('ConditionRating', jCompObj));
          if iCondition > 0 then
            aCondition := Format('C%d',[iCondition])
          else
            aCondition := '';
          ImportGridData(CompNo, FDoc, '998', aCondition, FDocCompTable);

          ImportGridData(CompNo, FDoc, '1020', GetJsonString('FirePlace', jCompObj), FDocCompTable);
          ImportGridData(CompNo, FDoc, '1022', GetJsonString('Pool', jCompObj), FDocCompTable);
          ImportGridData(CompNo, FDoc, '1041', GetJsonString('ABTotal', jCompObj), FDocCompTable);
          ImportGridData(CompNo, FDoc, '1042', GetJsonString('ABBed', jCompObj), FDocCompTable);
          ImportGridData(CompNo, FDoc, '1043', FHBath, FDocCompTable);
          aSiteArea := GetJsonString('SiteArea', jCompObj);
          if getValidinteger(aSiteArea) > 0 then
            begin
              if pos('sf', aSiteArea) > 0 then
                aSiteArea := popStr(aSiteArea, 'sf');
              aInt := GetValidInteger(aSiteArea);      //github #183: add ,
              aSiteArea := FormatFloat('#,###', aInt);
              ImportGridData(CompNo, FDoc, '976', trim(aSiteArea), FDocCompTable);
            end;
          iQuality := TranslateMobileQuality(GetJsonInt('ConstractionRating', jCompObj));
          if iQuality > 0 then
            aQuality := Format('Q%d',[iQuality])
          else
            aQuality := '';
          ImportGridData(CompNo, FDoc, '994', aQuality, FDocCompTable);
          aActualAge := YearBuiltToAge(GetJsonString('YearBuilt', jCompObj), False);
          ImportGridData(CompNo, FDoc, '996', aActualAge, FDocCompTable);
          //View
          aFactor1          := GetJsonString('ViewFactor1', jCompObj);
          aFactor1other     := GetJsonString('ViewFactor1Other', jCompObj);
          aFactor2          := GetJsonString('ViewFactor2', jCompObj);
          aFactor2Other     := GetJsonString('ViewFactor2Other', jCompObj);
          aInfl             := GetJsonInt('ViewInfluence', jCompObj);
          aView := GetViewInfluence(aInfl);
          aViewFactor := TranslateViewFactor(aView, aFactor1, aFactor2, aFactor1Other, aFactor2Other);
          ImportGridData(CompNo, FDoc, '984', aViewFactor, FDocCompTable);
          //Design style
          //aStories := GetValidInteger(GetJsonString('Stories', jCompObj));
          aStories := GetJsonDouble('Stories', jCompObj);
          aStr := FloatToStrDef(aStories);

          aDesign := GetJsonString('Design', jCompObj);
          aDesignStyle := '';
          if aDesign <> '' then //github #44 stories can be double
            aDesignStyle := Format('%s%s;%s',[aStructure, aStr, aDesign])
          else if aStories > 0 then
            aDesignStyle := Format('%s;',[aStr]);
          ImportGridData(CompNo, FDoc, '986', aDesignStyle, FDocCompTable);

          //Location
          aFactor1          := GetJsonString('LocationFactor1', jCompObj);
          aFactor1other     := GetJsonString('LocationFactor1Other', jCompObj);
          aFactor2          := GetJsonString('LocationFactor2', jCompObj);
          aFactor2Other     := GetJsonString('LocationFactor2Other', jCompObj);
          aInfl             := GetJSonInt('LocationInfluence', jCompObj);
          aLocation := GetViewInfluence(aInfl);
          aLocationFactor := TranslateViewFactor(aLocation, aFactor1, aFactor2, aFactor1Other, aFactor2Other);
          ImportGridData(CompNo, FDoc, '962', aLocationFactor, FDocCompTable);

          ImportGridData(CompNo, FDoc, '1041', GetJsonString('Fence', jCompObj), FDocCompTable);
          ImportGridData(CompNo, FDoc, '1018', GetJsonString('Porch', jCompObj), FDocCompTable);

          ImportGridData(CompNo, FDoc, '1010', GetJsonString('FunctionalUtility', jCompObj), FDocCompTable);
          ImportGridData(CompNo, FDoc, '1011', GetJsonString('FunctionalAdjAmt', jCompObj), FDocCompTable);
          ImportGridData(CompNo, FDoc, '1014', GetJsonString('EnergyEff', jCompObj), FDocCompTable);
          ImportGridData(CompNo, FDoc, '1015', GetJsonString('EnergyAdjAmt', jCompObj), FDocCompTable);
          aGarageCellValue := '';
          aGarage := GetValidInteger(GetJsonString('GarageCars', jCOmpObj));
          if aGarage > 0 then
            begin
              if GetJSonBool('GarageIsAttached', jCompObj) then
                SetGarageCellValue(aGarage, 'ga', aGarageCellValue)

              else if GetJsonBool('GarageIsDetached', jCompObj) then
                SetGarageCellValue(aGarage, 'gd', aGarageCellValue)

              else if GetJsonBool('GarageIsBuiltin', jCompObj) then
                SetGarageCellValue(aGarage, 'gbi', aGarageCellValue)
              else
                SetGarageCellValue(aGarage, 'ga', aGarageCellValue)
            end;
          aCarport := GetValidInteger(GetJSonString('CarportCars', jCompObj));
          if aCarport > 0 then
            begin
              if GetJSonBool('CarportIsAttached', jCompObj) and (aGarage = 0) then
                SetGarageCellValue(aCarport, 'cpa', aGarageCellValue)
              else if GetJSonBool('CarportIsDetached', jCompObj) and (aGarage = 0) then
                SetGarageCellValue(aCarport, 'cpd', aGarageCellValue)
              else
                SetGarageCellValue(aCarport, 'cp', aGarageCellValue);
            end;
          aDriveWay := GetValidInteger(GetJsonString('DrivewayCars', jCompObj));
          if aDriveWay > 0 then
            begin
              if GetJSonBool('Driveway', jCompObj) then
                SetGarageCellValue(aDriveWay, 'dw', aGarageCellValue);
            end;

          ImportGridData(CompNo, FDoc, '1016', aGarageCellValue, FDocCompTable);

          aTotalArea := GetJsonString('TotalArea', jCompObj);
          aFinishArea := GetJsonString('FinishedArea', jCompObj);
          aFinishPercent := GetJsonString('FinishedPercent', jCompObj);
          if GetValidInteger(aTotalArea) > 0 then
            begin
              if aFinishArea = '' then
                aFinishArea := CalcFinishedArea(aTotalArea, aFinishPercent);
            end;
          if getJSonBool('AccessMethodWalkUp', jCompObj) then
            aAccess := 'wu'
          else if getjSONBool('AccessMethodWalkOut', jCompObj) then
            aAccess := 'wo'
          else //if jCompObj.getBoolean('AccessMethodInteriorOnly', jCompObj) then
            aAccess := 'in';   //use as default

          if (GetValidInteger(aFinishArea) > 0) then
            begin
              aCellValue := Format('%ssf%ssf%s',[aTotalArea, aFinishArea, aAccess]);   //TotalAreasfFinishAreasfAccess
            end
          else if GetValidInteger(aTotalArea) > 0 then
            aCellValue := Format('%ssf0sf%s',[aTotalArea, aAccess])
          else
            begin
              if trim(FDoc.GetCellTextByID(1006)) <> '' then
                  aCellValue := '';
            end;

          ImportGridData(CompNo, FDoc, '1006', aCellValue, FDocCompTable);

         //cell #1008: basement rooms
         if GetValidInteger(aFinishArea) > 0 then
           begin
             rr  := GetValidInteger(GetJsonString('BasementRecRooms', jCompObj));
             br  := GetValidInteger(GetJsonString('BasementBedrooms', jCompObj));
             Fba := GetValidInteger(GetJsonString('BasementFullBaths', jCompObj));
             Hba := GetValidInteger(GetJsonString('BasementHalfBaths', jCompObj));
             o   := GetValidInteger(GetJsonString('BasementOtherRooms', jCompObj));
             aCellValue := Format('%drr%dbr%d.%dba%do',[rr, br, Fba, Hba, o]);
             ImportGridData(CompNo, FDoc, '1008', aCellValue, FDocCompTable);
           end;
         ImportGridData(CompNo, FDoc, '1020', GetJsonString('MiscDesc1', jCompObj), FDocCompTable);
         ImportGridData(CompNo, FDoc, '1021', GetJsonString('MiscAdjAmt1', jCompObj), FDocCompTable);
         ImportGridData(CompNo, FDoc, '1022', GetJsonString('MiscDesc2', jCompObj), FDocCompTable);
         ImportGridData(CompNo, FDoc, '1023', GetJsonString('MiscAdjAmt2', jCompObj), FDocCompTable);
         ImportGridData(CompNo, FDoc, '1032', GetJsonString('MiscDesc3', jCompObj), FDocCompTable);
         ImportGridData(CompNo, FDoc, '927', GetJsonString('MiscAdjAmt3', jCompObj), FDocCompTable);

         inc(FSaleCount);
        end
      else if pos('LIST', UpperCase(aCompType)) > 0 then
        begin
          inc(j);
          CompNo :=j;
          aCity  := GetJsonString('City', jCompObj);
          aState := GetJsonString('State', jCompObj);
          aZip   := GetJSonString('ZipCode', jCompObj);
          CityStZip := Format('%s, %s %s',[aCity, aState, aZip]);

          aUnitNumber := GetJsonString('UnitNumber', jCompObj);
          if aUnitNumber <> '' then
            //CityStZip := Format('%s; %s',[aUnitNumber,CityStZip]);
            CityStZip := Format('%s, %s',[aUnitNumber,CityStZip]);  //github #663

          aFull := GetValidInteger(GetJsonString('ABBath', jCompObj));
          aHalf := GetValidInteger(GetJsonString('ABHalf', jCompObj));
          FHBath := '';
          if (aFull > 0) or (aHalf > 0) then
            FHBath := Format('%d.%d',[aFull, aHalf]);
          aLatLon := Format('%s;%s',[ GetJsonString('Latitude', jCompObj),GetJsonString('Longitude', jCompObj) ]);
          if aLatLon <> '' then  //github #816
            ImportListingGridData(CompNo, FDoc, '9250', aLatLon, FDocListTable);
          ImportListingGridData(CompNo, FDoc, '925', GetJsonString('Address', jCompObj), FDocListTable);
          ImportListingGridData(CompNo, FDoc, '926', CityStZip, FDocListTable);
          aSiteArea :=  GetJsonString('SiteArea', jCompObj);
          aInt := GetValidInteger(aSiteArea);      //github #183: add ,
          aSiteArea := FormatFloat('#,###', aInt);
          ImportListingGridData(CompNo, FDoc, '976', aSiteArea, FDocListTable);

          GLA := GetJsonString('Gla', jCompObj);
          aInt := GetValidInteger(GLa);      //github #183: add ,
          GLA := FormatFloat('#,###', aInt);
          ImportListingGridData(CompNo, FDoc, '1004', GLA, FDocListTable);

          //Condition Rating
          iCondition := TranslateMobileCondition(GetJsonInt('ConditionRating', jCompObj));
          if iCondition > 0 then
            aCOndition := Format('C%d',[iCondition])
          else
            aCondition := '';
          ImportListingGridData(CompNo, FDoc, '998', aCondition, FDocListTable);

          ImportListingGridData(CompNo, FDoc, '1020', GetJsonString('FirePlace', jCompObj), FDocListTable);
          ImportListingGridData(CompNo, FDoc, '1022', GetJsonString('Pool', jCompObj), FDocListTable);
          ImportListingGridData(CompNo, FDoc, '1041', GetJsonString('ABTotal', jCompObj), FDocListTable);
          ImportListingGridData(CompNo, FDoc, '1042', GetJsonString('ABBed', jCompObj), FDocListTable);
          ImportListingGridData(CompNo, FDoc, '1043', FHBath, FDocListTable);
          aSiteArea := GetJsonString('SiteArea', jCompObj);
          aInt := GetValidInteger(aSiteArea);      //github #183: add ,
          aSiteArea := FormatFloat('#,###', aInt);

          ImportListingGridData(CompNo, FDoc, '976', aSiteArea, FDocListTable);
          //Quality
          iQuality := TranslateMobileQuality(GetJsonInt('ConstractionRating', jCompObj));
          if iQuality > 0 then
            aQuality := Format('Q%d',[iQuality])
          else
            aQuality := '';
          ImportListingGridData(CompNo, FDoc, '994', aQuality, FDocListTable);
          //Actual age from year built
          aActualAge := YearBuiltToAge(GetJsonString('YearBuilt', jCompObj), False);
          ImportListingGridData(CompNo, FDoc, '996', aActualAge, FDocListTable);

          //View
          aFactor1          := GetJsonString('ViewFactor1', jCompObj);
          aFactor1other     := GetJsonString('ViewFactor1Other', jCompObj);
          aFactor2          := GetJsonString('ViewFactor2', jCompObj);
          aFactor2Other     := GetJsonString('ViewFactor2Other', jCompObj);
          aInfl             := GetJSonInt('ViewInfluence', jCompObj);
          aView := GetViewInfluence(aInfl);
          aViewFactor := TranslateViewFactor(aView, aFactor1, aFactor2, aFactor1Other, aFactor2Other);
          ImportListingGridData(CompNo, FDoc, '984', aViewFactor, FDocListTable);

          //Location
          aFactor1          := GetJsonString('LocationFactor1', jCompObj);
          aFactor1other     := GetJsonString('LocationFactor1Other', jCompObj);
          aFactor2          := GetJsonString('LocationFactor2', jCompObj);
          aFactor2Other     := GetJsonString('LocationFactor2Other', jCompObj);
          aInfl             := GetJSonInt('LocationInfluence', jCompObj);
          aLocation := GetViewInfluence(aInfl);
          aLocationFactor := TranslateViewFactor(aLocation, aFactor1, aFactor2, aFactor1Other, aFactor2Other);
          ImportListingGridData(CompNo, FDoc, '962', aLocationFactor, FDocListTable);

          //Design style
          aInt := getjSonInt('StructureType', jCompObj);
          case aInt of
            stAttach:   aStructure := 'AT';
            stDetach:   aStructure := 'DT';
            stEndUnit:  aStructure := 'SD';
            else
              aStructure := 'DT';
          end;
          aStories := GetJsonDouble('Stories', jCompObj);
          if aStories = 0 then aStories := 1;
          aStr := FloatToStrDef(aStories);
          aDesign := GetJsonString('Design', jCompObj);
          if aDesign <> '' then  //github #44
            aDesignStyle := Format('%s%s;%s',[aStructure, aStr, aDesign])
          else
            aDesignStyle := Format('%s%s;',[aStructure, aStr]);
          ImportListingGridData(CompNo, FDoc, '986', aDesignStyle, FDocListTable);

          ImportListingGridData(CompNo, FDoc, '1041', GetJsonString('Fence', jCompObj), FDocListTable);
          ImportListingGridData(CompNo, FDoc, '1018', GetJsonString('Porch', jCompObj), FDocListTable);

          ImportListingGridData(CompNo, FDoc, '1010', GetJsonString('FunctionalUtility', jCompObj), FDocListTable);
          ImportListingGridData(CompNo, FDoc, '1011', GetJsonString('FunctionalAdjAmt', jCompObj), FDocListTable);
          ImportListingGridData(CompNo, FDoc, '1014', GetJsonString('EnergyEff', jCompObj), FDocListTable);
          ImportListingGridData(CompNo, FDoc, '1015', GetJsonString('EnergyAdjAmt', jCompObj), FDocListTable);
          aGarageCellValue := '';
          aGarage := GetJsonInt('GarageCars', jCOmpObj);
          if aGarage > 0 then
            begin
              if GetJSonBool('GarageIsAttached', jCompObj) then
                SetGarageCellValue(aGarage, 'ga', aGarageCellValue)

              else if GetJsonBool('GarageIsDetached', jCompObj) then
                SetGarageCellValue(aGarage, 'gd', aGarageCellValue)

              else if GetJsonBool('GarageIsBuiltin', jCompObj) then
                SetGarageCellValue(aGarage, 'gbi', aGarageCellValue)
              else
                SetGarageCellValue(aGarage, 'ga', aGarageCellValue)
            end;
          aCarport := GetJSonInt('CarportCars', jCOmpObj);
          if aCarport > 0 then
            begin
              if GetJSonBool('CarportIsAttached', jCompObj) and (aGarage = 0) then
                SetGarageCellValue(aCarport, 'cpa', aGarageCellValue)
              else if GetJSonBool('CarportIsDetached', jCompObj) and (aGarage = 0) then
                SetGarageCellValue(aCarport, 'cpd', aGarageCellValue)
              else
                SetGarageCellValue(aCarport, 'cp', aGarageCellValue);
            end;
          aDriveWay := GetJsonInt('DrivewayCars', jCompObj);
          if aDriveWay > 0 then
            begin
              if GetJSonBool('Driveway', jCompObj) then
                SetGarageCellValue(aDriveWay, 'dw', aGarageCellValue);
            end;

          ImportListingGridData(CompNo, FDoc, '1016', aGarageCellValue, FDocListTable);


          aTotalArea := GetJsonString('TotalArea', jCompObj);
          aFinishArea := GetJsonString('FinishedArea', jCompObj);
          aFinishPercent := GetJsonString('FinishedPercent', jCompObj);
          if GetValidInteger(aTotalArea) > 0 then
            begin
              if aFinishArea = '' then
                aFinishArea := CalcFinishedArea(aTotalArea, aFinishPercent);
            end;
          if getJSonBool('AccessMethodWalkUp', jCompObj) then
            aAccess := 'wu'
          else if getjSonBool('AccessMethodWalkOut', jCompObj) then
            aAccess := 'wo'
          else //if jCompObj.getBoolean('AccessMethodInteriorOnly', jCompObj) then
            aAccess := 'in';

          if (GetValidInteger(aFinishArea) > 0) then
            begin
              aCellValue := Format('%ssf%ssf%s',[aTotalArea, aFinishArea, aAccess]);   //TotalAreasfFinishAreasfAccess
            end
          else if GetValidInteger(aTotalArea) > 0 then
            aCellValue := Format('%ssf0sf%s',[aTotalArea, aAccess])
          else
            aCellValue := '';

          ImportListingGridData(CompNo, FDoc, '1006', aCellValue, FDocListTable);

         //cell #1008: basement rooms
         if GetValidInteger(aFinishArea) > 0 then
           begin
             rr  := GetValidInteger(GetJsonString('BasementRecRooms', jCompObj));
             br  := GetValidInteger(GetJsonString('BasementBedrooms', jCompObj));
             Fba := GetValidInteger(GetJsonString('BasementFullBaths', jCompObj));
             Hba := GetValidInteger(GetJsonString('BasementHalfBaths', jCompObj));
             o   := GetValidInteger(GetJsonString('BasementOtherRooms', jCompObj));
             aCellValue := Format('%drr%dbr%d.%dba%do',[rr, br, Fba, Hba, o]);
//             ImportListingGridData(CompNo, FDoc, '1008', aCellValue, FDocListTable);
           end;
         ImportListingGridData(CompNo, FDoc, '1020', GetJsonString('MiscDesc1', jCompObj), FDocListTable);
         ImportListingGridData(CompNo, FDoc, '1021', GetJsonString('MiscAdjAmt1', jCompObj), FDocListTable);
         ImportListingGridData(CompNo, FDoc, '1022', GetJsonString('MiscDesc2', jCompObj), FDocListTable);
         ImportListingGridData(CompNo, FDoc, '1023', GetJsonString('MiscAdjAmt2', jCompObj), FDocListTable);
         ImportListingGridData(CompNo, FDoc, '1032', GetJsonString('MiscDesc3', jCompObj), FDocListTable);
         ImportListingGridData(CompNo, FDoc, '927', GetJsonString('MiscAdjAmt3', jCompObj), FDocListTable);
         inc(FListCount);
      end;
   end;
  except on E:Exception do
     showmessage('Error loading json for Comps: '+ e.message);
  end;
end;


procedure TInspectionDetail.ImportCompDataToReport_V2(Comps_data:String);
var
  jCompObj, jc:TlkJSONObject;
  FjCompObj: TlkJSONList;
  aCompType,aItem:String;
  i,j, CompNo: Integer;
  Address, CityStZip, aCity, aState, aZip, FHBath: String;
  aFull, aHalf:Integer;
  aGarageCellValue: String;
  dw, ga, gd, gbi, cpa, cpd: Integer;
  aQuality,  aCondition, aHeatingCooling, aHeat, aCooling: String;
  aFactor1, aFactor2, aFactor1Other, aFactor2Other, aView, aLocation: String;
  aInfl, aInt{, aStories}: Integer;
  aStories: Double;  //github IAL #44
  aCool, aStructure, aDesign, aDesignStyle: String;
  aTotalArea, aFinishArea, aFinishPercent: Integer;
  aAccess, aCellvalue: String;
  rr, br, ba, fba, hba, o: Integer;
  aLatLon: String;
  aGarage, aCarport, aDriveWay: Integer;
  iCondition, iQuality: Integer;
  aViewFactor, aLocationFactor, aSiteArea: String;
  aUnitNumber:String;
  aActualAge:String;
//  GLA: Integer;
  GLA: String;    //github #
  aDouble1, aDouble2: Double;
  aStr:String;
begin
  FSaleCount := 0;
  FListCount := 0;
  FjCompObj := TlkJSON.ParseText(Comps_data) as TlkJSONList;
  if FjCompObj = nil then exit;
  if not assigned(FDoc) then
  FDoc := Main.ActiveContainer;
  j := 0;
  try
  for i:= 0 to FjCompObj.Count -1 do
    begin
      jCompObj := FjCompObj.Child[i] as TlkJSONObject;  //get each comp
      if jCompObj = nil then continue;
      aCompType := GetJsonString('CompType', jCompObj);
      if aCompType = '' then
        aCompType := 'Sale';
      if pos('SALE', UpperCase(aCompType)) > 0 then
        begin  //github #690
          Address := GetJsonString('Address', jCompObj);
//github #686: if user just add a comp image w/o address we still let the logic go through
//          if Address = '' then continue;  //we don't want to continue if address is empty
          aCity  := GetJsonString('City', jCompObj);
          aState := GetJsonString('State', jCompObj);
          aZip   := GetJsonString('ZipCode', jCompObj);
          if (aCity <> '') or (aState <> '') or (aZip <> '') then
            begin
              CityStZip := Format('%s, %s %s',[aCity, aState, aZip]);
              aUnitNumber := GetJsonString('UnitNumber', jCompObj);
              if aUnitNumber <> '' then
                CityStZip := Format('%s, %s',[aUnitNumber,CityStZip]);  //github #663
             end
          else
             begin
               CityStZip := '';
               if aUnitNumber <> '' then
                  CityStZip := Format('%s',[aUnitNumber]);  //github #663
             end;

          aFull := GetJsonInt('ABBath', jCompObj);
          aHalf := GetJsonInt('ABHalf', jCompObj);
          FHBath := '';
          if aHalf < 0 then aHalf := 0;
          if (aFull > 0) or (aHalf > 0) then
            FHBath := Format('%d.%d',[aFull, aHalf]);
          CompNo := i+1;
          aDouble1 := GetJsonDouble('Latitude', jCompObj);
          aDouble2 := GetJsonDouble('Longitude', jCompObj);
          if (aDouble1 <> 0) and (aDouble2 <> 0) then
            aLatLon := FloatToStrDef(aDouble1)+';'+ FloatToStrDef(aDouble2)
          else
            aLatLon := '';
          if aLatLon <> '' then
            ImportGridData(CompNo, FDoc, '9250', aLatLon, FDocCompTable);
          ImportGridData(CompNo, FDoc, '925', Address, FDocCompTable);
          ImportGridData(CompNo, FDoc, '926', CityStZip, FDocCompTable);
          aSiteArea := GetJsonString('SiteArea', jCompObj);
          if getValidInteger(aSiteArea) > 0 then
            begin
              aSiteArea := lowerCase(aSiteArea);
              if pos('ac', aSiteArea) > 0 then
                ImportGridData(CompNo, FDoc, '976', trim(aSiteArea), FDocCompTable)
              else
                begin
                  if pos('sf', aSiteArea) > 0 then
                    aSiteArea := popStr(aSiteArea, 'sf');
                  aInt := GetValidInteger(aSiteArea);      //github #183: add ,
                  aSiteArea := FormatFloat('#,###', aInt);
                  ImportGridData(CompNo, FDoc, '976', trim(aSiteArea), FDocCompTable);
                end;
            end;
          GLA := Format('%d',[GetJsonInt('Gla', jCompObj)]);
          if (GLA = '') or (GLA = '-1') then
            GLA := GetJsonString('Gla', jCompObj);  //github #632
          ImportGridData(CompNo, FDoc, '1004', GLA, FDocCompTable);

          //Condition Rating
          iCondition := TranslateMobileCondition(GetJsonInt('ConditionRating', jCompObj));
          if iCondition > 0 then
            aCondition := Format('C%d',[iCondition])
          else
            aCondition := '';
          ImportGridData(CompNo, FDoc, '998', aCondition, FDocCompTable);
          aInt := GetJsonInt('ABTotal', jCompObj);
          if aInt > 0 then
            ImportGridData(CompNo, FDoc, '1041', Format('%d',[aInt]), FDocCompTable);
          aInt := GetJsonInt('ABBed', jCompObj);
          if aInt > 0 then
            ImportGridData(CompNo, FDoc, '1042', Format('%d',[aInt]), FDocCompTable);
          ImportGridData(CompNo, FDoc, '1043', FHBath, FDocCompTable);
          aSiteArea := GetJsonString('SiteArea', jCompObj);
          if getValidinteger(aSiteArea) > 0 then
            begin
              if pos('ac', aSiteArea) > 0 then
                ImportGridData(CompNo, FDoc, '976', trim(aSiteArea), FDocCompTable)
              else
                begin
                  if pos('sf', aSiteArea) > 0 then
                    aSiteArea := popStr(aSiteArea, 'sf');
                  aInt := GetValidInteger(aSiteArea);      //github #183: add ,
                  aSiteArea := FormatFloat('#,###', aInt);
                  ImportGridData(CompNo, FDoc, '976', trim(aSiteArea), FDocCompTable);
                end;
            end;
          iQuality := TranslateMobileQuality(GetJsonInt('QualityRating', jCompObj));
          if iQuality > 0 then
            aQuality := Format('Q%d',[iQuality])
          else
            aQuality := '';
          ImportGridData(CompNo, FDoc, '994', aQuality, FDocCompTable);
          aActualAge := YearBuiltToAge(Format('%d',[GetJsonInt('YearBuilt', jCompObj)]), False);
          ImportGridData(CompNo, FDoc, '996', aActualAge, FDocCompTable);
          //View
          aFactor1          := GetJsonString('ViewFactor1', jCompObj);
          aFactor1other     := GetJsonString('ViewFactor1Other', jCompObj);
          aFactor2          := GetJsonString('ViewFactor2', jCompObj);
          aFactor2Other     := GetJsonString('ViewFactor2Other', jCompObj);
          aInfl             := GetJsonInt('ViewInfluence', jCompObj);
          aView := GetViewInfluence(aInfl);
          aViewFactor := TranslateViewFactor(aView, aFactor1, aFactor2, aFactor1Other, aFactor2Other);
          ImportGridData(CompNo, FDoc, '984', aViewFactor, FDocCompTable);
          //Design style
          aStructure := '';  //github #727: clear the variable before we put in value
          aInt := getJsonInt('StructureType', jCompObj);
          case aInt of
            stAttach:   aStructure := 'AT';
            stDetach:   aStructure := 'DT';
            stEndUnit:  aStructure := 'SD';
          end;
          aStories := GetJsonDouble('Stories', jCompObj); //github #44
          if aStories > 0 then
            aStr := FloatToStrDef(aStories);
          aDesign := GetJsonString('Design', jCompObj);
          aDesignStyle := '';
          if aDesign <> '' then
            aDesignStyle := Format('%s%s;%s',[aStructure, aStr, aDesign])  //github #44
          else if (length(aStructure) > 0) and (aStories > 0) then //github #727
            aDesignStyle := Format('%s%s;',[aStructure, aStr]);  //github #44
          ImportGridData(CompNo, FDoc, '986', aDesignStyle, FDocCompTable);

          //Location
          aFactor1          := GetJsonString('LocationFactor1', jCompObj);
          aFactor1other     := GetJsonString('LocationFactor1Other', jCompObj);
          aFactor2          := GetJsonString('LocationFactor2', jCompObj);
          aFactor2Other     := GetJsonString('LocationFactor2Other', jCompObj);
          aInfl             := GetJSonInt('LocationInfluence', jCompObj);
          aLocation := GetViewInfluence(aInfl);
          aLocationFactor := TranslateViewFactor(aLocation, aFactor1, aFactor2, aFactor1Other, aFactor2Other);
          ImportGridData(CompNo, FDoc, '962', aLocationFactor, FDocCompTable);

          ImportGridData(CompNo, FDoc, '1041', GetJsonString('Fence', jCompObj), FDocCompTable);
          ImportGridData(CompNo, FDoc, '1018', GetJsonString('Porch', jCompObj), FDocCompTable);

          ImportGridData(CompNo, FDoc, '1010', GetJsonString('FunctionalUtility', jCompObj), FDocCompTable);
          aInt := GetJsonInt('FunctionalAdjAmt', jCompObj);
          if aInt <> -1 then
            ImportGridData(CompNo, FDoc, '1011', Format('%d',[aInt]), FDocCompTable);
          ImportGridData(CompNo, FDoc, '1014', GetJsonString('EnergyEff', jCompObj), FDocCompTable);
          aInt := GetJsonInt('EnergyAdjAmt', jCompObj);
          if aInt <> -1 then
            ImportGridData(CompNo, FDoc, '1015', Format('%d',[aInt]), FDocCompTable);
          aGarageCellValue := '';
          aGarage := GetJsonInt('GarageCars', jCOmpObj);
          if aGarage > 0 then
            begin
              if GetJSonBool('GarageIsAttached', jCompObj) then
                SetGarageCellValue(aGarage, 'ga', aGarageCellValue)

              else if GetJsonBool('GarageIsDetached', jCompObj) then
                SetGarageCellValue(aGarage, 'gd', aGarageCellValue)

              else if GetJsonBool('GarageIsBuiltin', jCompObj) then
                SetGarageCellValue(aGarage, 'gbi', aGarageCellValue)
              else
                SetGarageCellValue(aGarage, 'ga', aGarageCellValue)
            end;
          aCarport := GetJSonInt('CarportCars', jCompObj);
          if aCarport > 0 then
            begin
              if GetJSonBool('CarportIsAttached', jCompObj) and (aGarage = 0) then
                SetGarageCellValue(aCarport, 'cpa', aGarageCellValue)
              else if GetJSonBool('CarportIsDetached', jCompObj) and (aGarage = 0) then
                SetGarageCellValue(aCarport, 'cpd', aGarageCellValue)
              else
                SetGarageCellValue(aCarport, 'cp', aGarageCellValue);
            end;
          aDriveWay := GetJsonInt('DrivewayCars', jCompObj);
          if aDriveWay > 0 then
            begin
              if GetJSonBool('Driveway', jCompObj) then
                SetGarageCellValue(aDriveWay, 'dw', aGarageCellValue);
            end;

          ImportGridData(CompNo, FDoc, '1016', aGarageCellValue, FDocCompTable);
         ImportGridData(CompNo, FDoc, '1020', GetJsonString('MiscDesc1', jCompObj), FDocCompTable);
         aInt := GetJsonInt('MiscAdjAmt1', jCompObj);
         if aInt <> -1 then
           ImportGridData(CompNo, FDoc, '1021', Format('%d',[aInt]), FDocCompTable);
         ImportGridData(CompNo, FDoc, '1022', GetJsonString('MiscDesc2', jCompObj), FDocCompTable);
         aInt := GetJsonInt('MiscAdjAmt2', jCompObj);
         if aInt <> -1 then
           ImportGridData(CompNo, FDoc, '1023', Format('%d',[aInt]), FDocCompTable);
         ImportGridData(CompNo, FDoc, '1032', GetJsonString('MiscDesc3', jCompObj), FDocCompTable);
         aInt := GetJsonInt('MiscAdjAmt3', jCompObj);
         if aInt <> -1 then
           ImportGridData(CompNo, FDoc, '927', Format('%d',[aInt]), FDocCompTable);

         inc(FSaleCount);
        end
      else if pos('LIST', UpperCase(aCompType)) > 0 then
        begin
          inc(j);
          CompNo :=j;
          Address := GetJSonString('Address', jCompObj);
          aCity  := GetJsonString('City', jCompObj);
          aState := GetJsonString('State', jCompObj);
          aZip   := GetJsonString('ZipCode', jCompObj);
          if (aCity <> '') or (aState <> '') or (aZip <> '') then //github #690
            begin
              CityStZip := Format('%s, %s %s',[aCity, aState, aZip]);
              aUnitNumber := GetJsonString('UnitNumber', jCompObj);
              if aUnitNumber <> '' then
                CityStZip := Format('%s, %s',[aUnitNumber,CityStZip]);  //github #663
             end
          else
             begin
               CityStZip := '';
               if aUnitNumber <> '' then
                  CityStZip := Format('%s',[aUnitNumber]);  //github #663
             end;

          aFull := GetJsonInt('ABBath', jCompObj);
          aHalf := GetJsonInt('ABHalf', jCompObj);
          FHBath := '';
          if aHalf < 0 then aHalf := 0;
          if (aFull > 0) or (aHalf > 0) then
            FHBath := Format('%d.%d',[aFull, aHalf]);

          aDouble1 := GetJsonDouble('Latitude', jCompObj);
          aDouble2 := GetJsonDouble('Longitude', jCompObj);
          if (aDouble1 <> 0) and (aDouble2 <> 0) then  //github #816
            aLatLon := FloatToStrDef(aDouble1)+';'+ FloatToStrDef(aDouble2)
          else
            aLatLon := '';
          if aLatLon <> '' then
            ImportListingGridData(CompNo, FDoc, '9250', aLatLon, FDocListTable);
          ImportListingGridData(CompNo, FDoc, '925', Address, FDocListTable);
          ImportListingGridData(CompNo, FDoc, '926', CityStZip, FDocListTable);
          aSiteArea := GetJsonString('SiteArea', jCompObj);
          aInt := GetValidInteger(aSiteArea);      //github #183: add ,
            if aInt > 0 then
              begin
              if pos('ac', aSiteArea) > 0 then
                ImportListingGridData(CompNo, FDoc, '976', trim(aSiteArea), FDocListTable)
              else
                begin
                  if pos('sf', aSiteArea) > 0 then
                    aSiteArea := popStr(aSiteArea, 'sf');
                  aInt := GetValidInteger(aSiteArea);      //github #183: add ,
                  aSiteArea := FormatFloat('#,###', aInt);
                  ImportListingGridData(CompNo, FDoc, '976', trim(aSiteArea), FDocListTable);
                end;

              end;
          GLA := Format('%d',[GetJsonInt('Gla', jCompObj)]);  //github #632: deal with old json int
          if (GLA = '') or (GLA='-1') then
            GLA := GetJsonString('Gla', jCompObj);
          ImportListingGridData(CompNo, FDoc, '1004', GLA, FDocListTable);

          //Condition Rating
          iCondition := TranslateMobileCondition(GetJsonInt('ConditionRating', jCompObj));
          if iCondition > 0 then
            aCOndition := Format('C%d',[iCondition])
          else
            aCondition := '';
          ImportListingGridData(CompNo, FDoc, '998', aCondition, FDocListTable);

         // ImportListingGridData(CompNo, FDoc, '1020', GetJsonString('FirePlace', jCompObj), FDocListTable);
         // ImportListingGridData(CompNo, FDoc, '1022', GetJsonString('Pool', jCompObj), FDocListTable);
          aInt := GetJsonInt('ABTotal', jCompObj);
          if aInt > 0 then
            ImportListingGridData(CompNo, FDoc, '1041', Format('%d',[aInt]), FDocListTable);
          aInt := GetJsonInt('ABBed', jCompObj);
          if aInt > 0 then
            ImportListingGridData(CompNo, FDoc, '1042', Format('%d',[aInt]), FDocListTable);
          ImportListingGridData(CompNo, FDoc, '1043', FHBath, FDocListTable);
          aSiteArea := GetJsonString('SiteArea', jCompObj);
          aInt := GetValidInteger(aSiteArea);      //github #183: add ,
          aSiteArea := FormatFloat('#,###', aInt);

          //Quality
          iQuality := TranslateMobileQuality(GetJsonInt('QualityRating', jCompObj));
          if iQuality > 0 then
            aQuality := Format('Q%d',[iQuality])
          else
            aQuality := '';
          ImportListingGridData(CompNo, FDoc, '994', aQuality, FDocListTable);
          //Actual age from year built
          aActualAge := YearBuiltToAge(Format('%d',[GetJsonInt('YearBuilt', jCompObj)]), False);
          ImportListingGridData(CompNo, FDoc, '996', aActualAge, FDocListTable);

          //View
          aFactor1          := GetJsonString('ViewFactor1', jCompObj);
          aFactor1other     := GetJsonString('ViewFactor1Other', jCompObj);
          aFactor2          := GetJsonString('ViewFactor2', jCompObj);
          aFactor2Other     := GetJsonString('ViewFactor2Other', jCompObj);
          aInfl             := GetJSonInt('ViewInfluence', jCompObj);
          aView := GetViewInfluence(aInfl);
          aViewFactor := TranslateViewFactor(aView, aFactor1, aFactor2, aFactor1Other, aFactor2Other);
          ImportListingGridData(CompNo, FDoc, '984', aViewFactor, FDocListTable);

          //Location
          aFactor1          := GetJsonString('LocationFactor1', jCompObj);
          aFactor1other     := GetJsonString('LocationFactor1Other', jCompObj);
          aFactor2          := GetJsonString('LocationFactor2', jCompObj);
          aFactor2Other     := GetJsonString('LocationFactor2Other', jCompObj);
          aInfl             := GetJSonInt('LocationInfluence', jCompObj);
          aLocation := GetViewInfluence(aInfl);
          aLocationFactor := TranslateViewFactor(aLocation, aFactor1, aFactor2, aFactor1Other, aFactor2Other);
          ImportListingGridData(CompNo, FDoc, '962', aLocationFactor, FDocListTable);
          aStructure := '';  //github #727
          //Design style
          aStructure := '';
          aInt := getjSonInt('StructureType', jCompObj);
          case aInt of
            stAttach:   aStructure := 'AT';
            stDetach:   aStructure := 'DT';
            stEndUnit:  aStructure := 'SD';
          end;
          aStories := GetJsonDouble('Stories', jCompObj); //github #44
          //if aStories = 0 then aStories := 1;
          if aStories > 0 then
            aStr := FloatToStrDef(aStories);
          aDesign := GetJsonString('Design', jCompObj);
          aDesignStyle := '';
          if aDesign <> '' then
            aDesignStyle := Format('%s%s;%s',[aStructure, aStr, aDesign])
          else if (length(aStructure) > 0) and (aStories >0) then //github #727
            aDesignStyle := Format('%s%s;',[aStructure, aStr]); //github #44
          ImportListingGridData(CompNo, FDoc, '986', aDesignStyle, FDocListTable);

          ImportListingGridData(CompNo, FDoc, '1041', GetJsonString('Fence', jCompObj), FDocListTable);
          ImportListingGridData(CompNo, FDoc, '1018', GetJsonString('Porch', jCompObj), FDocListTable);

          ImportListingGridData(CompNo, FDoc, '1010', GetJsonString('FunctionalUtility', jCompObj), FDocListTable);
          aInt := GetJsonInt('FunctionalAdjAmt', jCompObj);
          if aInt <> -1 then
            ImportListingGridData(CompNo, FDoc, '1011', Format('%d',[aInt]), FDocListTable);
          ImportListingGridData(CompNo, FDoc, '1014', GetJsonString('EnergyEff', jCompObj), FDocListTable);
          aInt :=  GetJsonInt('EnergyAdjAmt', jCompObj);
          if aInt <> -1 then
            ImportListingGridData(CompNo, FDoc, '1015', Format('%d',[aInt]), FDocListTable);
          aGarageCellValue := '';
          aGarage := GetJsonInt('GarageCars', jCOmpObj);
          if aGarage > 0 then
            begin
              if GetJSonBool('GarageIsAttached', jCompObj) then
                SetGarageCellValue(aGarage, 'ga', aGarageCellValue)

              else if GetJsonBool('GarageIsDetached', jCompObj) then
                SetGarageCellValue(aGarage, 'gd', aGarageCellValue)

              else if GetJsonBool('GarageIsBuiltin', jCompObj) then
                SetGarageCellValue(aGarage, 'gbi', aGarageCellValue)
              else
                SetGarageCellValue(aGarage, 'ga', aGarageCellValue)
            end;
          aCarport := GetJSonInt('CarportCars', jCOmpObj);
          if aCarport > 0 then
            begin
              if GetJSonBool('CarportIsAttached', jCompObj) and (aGarage = 0) then
                SetGarageCellValue(aCarport, 'cpa', aGarageCellValue)
              else if GetJSonBool('CarportIsDetached', jCompObj) and (aGarage = 0) then
                SetGarageCellValue(aCarport, 'cpd', aGarageCellValue)
              else
                SetGarageCellValue(aCarport, 'cp', aGarageCellValue);
            end;
          aDriveWay := GetJsonInt('DrivewayCars', jCompObj);
          if aDriveWay > 0 then
            begin
              if GetJSonBool('Driveway', jCompObj) then
                SetGarageCellValue(aDriveWay, 'dw', aGarageCellValue);
            end;

          ImportListingGridData(CompNo, FDoc, '1016', aGarageCellValue, FDocListTable);

         ImportListingGridData(CompNo, FDoc, '1020', GetJsonString('MiscDesc1', jCompObj), FDocListTable);
         aInt := GetJsonInt('MiscAdjAmt1', jCompObj);
         if aInt <> -1 then
           ImportListingGridData(CompNo, FDoc, '1021', Format('%d',[aInt]), FDocListTable);
         ImportListingGridData(CompNo, FDoc, '1022', GetJsonString('MiscDesc2', jCompObj), FDocListTable);
         aInt := GetJsonInt('MiscAdjAmt2', jCompObj);
         if aInt <> -1 then
           ImportListingGridData(CompNo, FDoc, '1023', Format('%d',[aInt]), FDocListTable);
         ImportListingGridData(CompNo, FDoc, '1032', GetJsonString('MiscDesc3', jCompObj), FDocListTable);
         aInt := GetJsonInt('MiscAdjAmt3', jCompObj);
         if aInt <> -1 then
           ImportListingGridData(CompNo, FDoc, '927', Format('%d',[aInt]), FDocListTable);
         inc(FListCount);
      end;
   end;
  except on E:Exception do
     showmessage('Error loading json for Comps: '+ e.message);
  end;
end;

function TInspectionDetail.IsSubjectTopTransfer(aTitle:String; aTag: Integer):Boolean;
var
  i: Integer;
  aName: String;
  aCheckBox, aPanel: TComponent;
begin
  result := False;
  for i:= 0 to TopPhotoSection.ComponentCount -1 do
    begin
      aName := GetNameByTitle(aTitle);
      aPanel := TPanel(TopPhotoSection.Components[i]);
      if not assigned(aPanel) then continue;
      aCheckBox := FindAnyControl(TPanel(aPanel), aName + IntToStr(i));
      if aCheckBox is TCheckBox then
        begin
          if aCheckBox.Tag = aTag then
            begin
              result := TCheckBox(aCheckBox).Checked;
              break;
            end;
        end;
    end;
end;

//Ticket #1360: call clear images for overwrite Yes
procedure TInspectionDetail.ClearSubjectExtraPhoto(aFormID:Integer; aForm:TDocForm);
var
  topCellID1,topCellID2,c, i, n: Integer;
  aCell: TBaseCell;
begin
  topCellID1 := 15; //the first cell sequence for the first image of form #302
  topCellID2 := 14; //the first cell sequence for the first image

  case aFormID of
    302: n:=3;
    324: n:=6;
    326: n:=12;
    325: n:=15;
  end;

  for i:=1 to n do
    begin
      if i = 1 then
        begin
          case aFormID of
            302: c := topCellID1
            else c := topCellID2;
          end;
        end
      else
        begin
          case aFormID of
            302: c:= c + 3;
            else c := c + 2;
          end;
        end;
      aCell := aForm.GetCell(1,c);
      if FOverwriteData then
      begin
        if assigned(aCell) and (aCell is TPhotoCell) then
          if (TPhotoCell(aCell).HasImage) then
          begin
            TPhotoCell(aCell).FImage.Clear;
            FDoc.MakeCurCell(aCell);        //make sure its active
          end;
      end;
    end;
end;

//Ticket #1360: call clear images for overwrite Yes
procedure TInspectionDetail.ClearSubjectMainPhoto(aFormID:Integer; aForm:TDocForm);
const
  topCellID_301  = 15;   //the first cell sequence for the first image of form #301
  topCellID_4103 = 16;   //the first cell sequence for the first image of form #4103
var
  c, i, n: Integer;
  aCell: TBaseCell;
begin
  for i:=1 to 3 do
    begin
      case aFormID of
        301: begin
               c:= topCellID_301;
               if i > 1 then
                 c:= c + 3;
             end;
        4103: begin
                c:= topCellID_4103;
                if i > 1 then
                  c:= c + 4;
              end;
        else
          break;  //donot continue
      end;
      aCell := aForm.GetCell(1,c);
      if FOverwriteData then
      begin
        if assigned(aCell) and (aCell is TPhotoCell) then
          if (TPhotoCell(aCell).HasImage) then
          begin
            TPhotoCell(aCell).FImage.Clear;
            FDoc.MakeCurCell(aCell);        //make sure its active
          end;
      end;
    end;
end;

//Ticket #1360: call clear images for overwrite Yes
procedure TInspectionDetail.ClearCompPhoto(aFormID:Integer; aForm:TDocForm);
const
  topCellID_304  = 17;   //the first cell sequence for the first image of form #301
  topCellID_4084 = 14;   //the first cell sequence for the first image of form #4103
  topCellID_4181 = 14;   //the first cell sequence for the first image of form #4103
var
  c, i, n: Integer;
  aCell: TBaseCell;
begin
  for i:=1 to 3 do
    begin
      case aFormID of
        304:  c:= topCellID_304;
        4084: c:= topCellID_4084;
        4181: c:= topCellID_4181;
        else
          break;  //donot continue
      end;
      if i > 1 then
        c:= c + 4;

      aCell := aForm.GetCell(1,c);
      if FOverwriteData then
      begin
        if assigned(aCell) and (aCell is TPhotoCell) then
          if (TPhotoCell(aCell).HasImage) then
          begin
            TPhotoCell(aCell).FImage.Clear;
            FDoc.MakeCurCell(aCell);        //make sure its active
          end;
      end;
    end;
end;

//Ticket #1360: clear photo images
procedure TInspectionDetail.ClearSubjectMainPhotoImages;
var
  aFormID, i,j,c: Integer;
  aForm: TDocForm;
  aCell: TBaseCell;
begin
   aFormID := GetSubjectMainFormID;
   //Clear current images
    for i := 0 to FDoc.docForm.Count - 1 do
      begin
        if FDoc.docForm[i].FormID = aFormID then
          begin
            aForm := FDoc.docForm[i];
            case aFormID of
              301, 4103: ClearSubjectMainPhoto(aFormID, aForm);
            end;
          end;
     end;
end;

//Ticket #1360: call clear images for overwrite Yes
procedure TInspectionDetail.ClearCompPhotoImages;
var
  aFormID, i,j,c: Integer;
  aForm: TDocForm;
  aCell: TBaseCell;
begin
   aFormID := GetSubjectMainFormID;
   //Clear current images
    for i := 0 to FDoc.docForm.Count - 1 do
      begin
        if FDoc.docForm[i].FormID = aFormID then
          begin
            aForm := FDoc.docForm[i];
            case aFormID of
              304, 4084,4181: ClearCompPhoto(aFormID, aForm);
            end;
          end;
        end;
end;


//Ticket #1360: call clear images for overwrite Yes
procedure TInspectionDetail.ClearSubjectExtraPhotoImages;
var
  aFormID, i,j,c: Integer;
  aForm: TDocForm;
  aCell: TBaseCell;
begin
   aFormID := GetSubjectExtraFormID;
   //Clear current images
    for i := 0 to FDoc.docForm.Count - 1 do
      begin
        if FDoc.docForm[i].FormID = aFormID then
          begin
            aForm := FDoc.docForm[i];
            case aFormID of
              302,324,325,326: ClearSubjectExtraPhoto(aFormID, aForm);
            end;
          end;
        end;
end;

//walk through the subject photo tab and pick the one with transfer checkbox is checked
//For Subject main photo, look for the caption with Front/Rear/Street
//The rest should be Subject Extra photo
function TInspectionDetail.TransferSubjectPhotos: Boolean;
  function GetImageCellID(aImageTag: Integer; aFormID:Integer):Integer;
  begin
    case aFormID of
      301:
        begin
            case aImageTag of
              phSubFront:  result := 1205;
              phSubRear:   result := 1206;
              phSubStreet: result := 1207;
            end;
        end;
      4103:
        begin
            case aImageTag of
              phSubFront:  result := 1222;
              phSubRear:   result := 1223;
              phSubStreet: result := 1224;
            end;
        end;
    end;
  end;


const
 imgfrontCellID  = 1205;
 imgrearCellID   = 1206;
 imgstreetCellID = 1207;

var
  i, j: Integer;
  aFrame: TPanel;
  aCheckBox: TComponent;
  aImageTag: TLabel;
  aImagePhoto: TComponent;
  aEdit: TComponent;
  image_id: Integer;
  isCreated: Boolean;
  MainIdx : Integer;
  aFormID, idx: Integer;
  aCell: TBaseCell;
  ImageCellID: Integer;
  aForm:TDocForm;
  aPanel: TPanel;
  iFront, iStreet, iRear: Integer;  //PAM - Ticket #1333: counter of front/street/rear
  aTag, Occur: Integer;
  aTitle: String;
  isTransfer:Boolean;
begin
  iFront := 0; iStreet := 0; iRear := 0; Occur := 0; //initialize to 0 first
  isCreated := False;
  result := True;
  MainIdx := -1;

  aFormID := GetSubjectMainFormID;
  idx := GetFormIndex(Fdoc, aFormID);
  ImageCellID := GetImageCellID(phSubFront, aFormID);

  if (idx >= 0) and not FOverwriteData then //we found subject photo sheet and not ovewrite
    begin
      aForm := FDoc.GetFormByOccuranceByIdx(aFormID, 0, idx, False);
      if assigned(aForm) then
        aCell := aForm.GetCellByID(imageCellID);  //check for empty image cell
      if assigned(acell) and (acell is TPhotoCell) then
        if (TPhotoCell(acell).HasImage) then  //pop up warning if cell is not empty
          exit;
    end;

  //Ticket #1360: call clear images for overwrite Yes
//  if FOverwriteData then
//    begin
//      ClearSubjectMainPhotoImages;
//      ClearSubjectExtraPhotoImages;  //clean up existing photo images in the container before we populate from IAL
//    end;

  try
    for i:= 0 to TopPhotoSection.ComponentCount - 1 do     //walk through top subject section: Front/Rear/Side
      begin
        aPanel := TPanel(TopPhotoSection.Components[i]);
        if not assigned(aPanel) then continue;
        aEdit := FindAnyControl(aPanel, Format('Edit%d',[i]));
        if aEdit is TEdit then
          begin
              //if (FSubjectPhotoList.Count > 0) and (i <= FSubjectPhotoList.count) then  //make sure we have a photo
              //  if Assigned(FSubjectPhotoList.Items[i]) then
                begin
                  isTransfer := IsSubjectTopTransfer(TEdit(aEdit).Text, TEdit(aEdit).Tag);
                  if isTransfer then
                    begin
                      image_id := GetImageId(TEdit(aEdit).Text);
                      aImagePhoto := aPanel.FindComponent(Format('Image%d',[i]));
                      case image_id of
                         phSubFront:
                            begin
                              if iFront = 0 then //PAM - Ticket #1333: this is for the first subject Front picture
                                begin
                                  ImportSubjectMainImage(TImage(aImagePhoto), image_id, TEdit(aEdit).Text, isCreated, MainIdx);
                                  inc(iFront); //increment the counter
                                end
                              else   //PAM - Ticket #1333: this is for the seond subject Front picture, dump it to extra subject photo page
                                ImportSubjectExtraImages(TImage(aImagePhoto),0, TEdit(aEdit).Text);
                            end;
                         phSubRear:
                            begin
                              if iRear = 0 then  //PAM - Ticket #1333: this is for the first subject Rear picture
                                begin
                                  ImportSubjectMainImage(TImage(aImagePhoto), image_id, TEdit(aEdit).Text, isCreated, MainIdx);
                                  inc(iRear); //increment the counter
                                end
                              else //PAM - Ticket #1333: this is for the seond subject Rear picture, dump it to extra subject photo page
                                ImportSubjectExtraImages(TImage(aImagePhoto),0, TEdit(aEdit).Text);
                            end;
                         phSubStreet:
                            begin
                              if iStreet = 0 then //PAM - Ticket #1333: this is for the first subject Street picture
                                begin
                                  ImportSubjectMainImage(TImage(aImagePhoto), image_id, TEdit(aEdit).Text, isCreated, MainIdx);
                                  inc(iStreet);  //increment the counter
                                end
                              else  //PAM - Ticket #1333: this is for the seond subject Street picture, dump it to extra subject photo page
                                ImportSubjectExtraImages(TImage(aImagePhoto),0, TEdit(aEdit).Text);
                            end;
                         else
                           ImportSubjectExtraImages(TImage(aImagePhoto),0, TEdit(aEdit).Text);
                      end;
                  end;
                end;
          end;
      end;

    for i:= 0 to FSubjectPhotoList.Count -1 do
      begin
        aPanel := TPanel(FindAnyControl(BotBasePanel, TPanel(FSubjectPhotoList[i]).Name));
        if not assigned(aPanel) then continue;
        aTag := aPanel.Tag;
        aCheckBox := aPanel.FindComponent(Format('CheckBox%d',[aTag]));
        if aCheckBox is TCheckBox and TCheckBox(aCheckBox).Checked then
          begin
            aEdit := aPanel.FindComponent(Format('Edit%d',[aTag]));
            if aEdit is TEdit then
              if (aTag <= FSubjectPhotoList.count) and Assigned(FSubjectPhotoList.Items[aTag]) then  //make sure we have a photo
                begin
                  aImagePhoto := aPanel.FindComponent(Format('Image%d',[aTag]));
                  ImportSubjectExtraImages(TImage(aImagePhoto),0, TEdit(aEdit).Text);
                end;
          end;
      end;
  except on E:Exception do
    begin
      ShowAlert(atWarnAlert, 'Error transfering Subject Photos to the report.  '+e.message);
      result := False;
    end;
  end;
end;


function TInspectionDetail.GetSubjectMainFormID: Integer;
begin
  case rdoMainSubject.ItemIndex of
    0: result := 301;
    1: result := 4103;
    else
      result := 301;
  end;
end;

function TInspectionDetail.GetCompMainFormID: Integer;
begin
  case rdoMainComp.ItemIndex of
    0: result := 304;
//    1: result := 4084;
    1: result := 4181
    else
      result := 304;
  end;
end;

function TInspectionDetail.GetListingMainFormID: Integer;
begin
  case rdoMainComp.ItemIndex of
    0: result := 306;
    1: result := 4082;
    else
      result := 306;
  end;
end;

procedure TInspectionDetail.ImportSubjectMainImage(photo:TImage; image_id: Integer; image_desc: String; var IsCreated:Boolean; var MainIdx: Integer);
  function GetImageCellID(aImageTag: Integer; aFormID:Integer):Integer;
  begin
    case aFormID of
      301:
        begin
            case aImageTag of
              phSubFront:  result := 1205;
              phSubRear:   result := 1206;
              phSubStreet: result := 1207;
            end;
        end;
      4103:
        begin
            case aImageTag of
              phSubFront:  result := 1222;
              phSubRear:   result := 1223;
              phSubStreet: result := 1224;
            end;
        end;
    end;
  end;

var
  cell: TBaseCell;
  aForm: TDocForm;
  aStream: TMemoryStream;
  idx: Integer;
  aFormID: Integer;
  ImageCellID: Integer;
begin
    aFormID := GetSubjectMainFormID;
    case image_id of
      phSubFront: ImageCellID := GetImageCellID(phSubFront, aFormID);
      phSubRear:  ImageCellID := GetImageCellID(phSubRear, aFormID);
      phSubStreet: ImageCellID := GetImageCellID(phSubStreet, aFormID);
    end;

    if mainIdx = -1 then
      idx := GetFormIndex(Fdoc, aFormID)
    else
      idx := mainIdx;
    if idx = -1 then   //photo sheet not found, create one
      begin
        aForm := FDoc.InsertFormUID(TFormUID.Create(aFormID),true,idx);
        isCreated := True;
      end
    else
      aForm := FDoc.GetFormByOccuranceByIdx(aFormID, 0, idx, False);   //found one, use it
    if assigned(aForm) and not FOverwriteData then  //we have photo sheet and not overwrite
      begin
        if not isCreated then
          begin
            cell := aForm.GetCellByID(imageCellID);
            if assigned(cell) and (cell is TPhotoCell) then
              if FOverwriteData or (TPhotoCell(cell).HasImage) then
                begin
                  aForm := FDoc.InsertFormUID(TFormUID.Create(aFormID),true,idx);
                  isCreated := True;
                  mainIdx := idx;
                end;
          end;
      end;

  if assigned(aForm) then
    begin
      if mainIdx > 0 then
        begin
          aForm := FDoc.GetFormByOccuranceByIdx(aFormID, 0, mainIdx, False);
        end;
      if assigned(aForm) then
        cell := aForm.GetCellByID(imageCellID);
      if assigned(cell) and (cell is TPhotoCell) then
        if FOverwriteData or not(TPhotoCell(cell).HasImage) then
        begin
           aStream := TMemoryStream.Create;
           try
             Photo.Picture.Graphic.SaveToStream(aStream);
             aStream.Position := 0;
             TGraphicCell(cell).LoadStreamData(aStream, aStream.Size, True);
             cell.Display;
           finally
             aStream.Free;
           end;
        end;
      //Fill in the captions
       case aFormID of
         4103:
           begin
             case image_id of
               phSubFront: aForm.SetCellText(1,14, image_desc);
               phSubRear: aForm.SetCellText(1,18, image_desc);
               phSubStreet: aForm.SetCellText(1, 22, image_desc);
             end;
           end;
       end;

    end;
end;



procedure TInspectionDetail.ImportCompMainImages(photo:TImage; imageTag:Integer; image_desc: String);

  function GetImageCellID(aImageTag: Integer; aFormID:Integer):Integer;
  begin
    case aFormID of
      304:
        begin
            case aImageTag of
              phSubFront:  result := 1205;
            end;
        end;
    end;
  end;

const

  topImageID = 1163;
  midImageID = 1164;
  botImageID = 1165;
var
  imageCellID: Integer;
  line1No, line2No: Integer;
  cell: TBaseCell;
  form: TDocForm;
  compNo, count: Integer;
  aStream: TMemoryStream;
  cntr,aListTag: Integer;
  isSale:Boolean;
  idx, idx2, ListIdx: Integer;
  CFormID, LFormID, aCellNo:Integer;
begin
  cell := nil;
  form := nil;
  aListTag := 0;
  CFormID := GetCompMainFormID;
  LFormID := GetListingMainFormID;
//  isSale := imageTag <= FSaleCount;
  idx := GetFormIndex(FDoc, CFormID);  //github #602
  ListIdx := GetFormIndex(FDoc, LFormID);
  isSale := (imageTag <= FSaleCount) or (FListCount = 0);
  if idx <> -1 then
    idx := idx + 1;

  //find the 1st available slot in the photo pages
  for cntr := 0 to FDoc.docForm.Count - 1 do
    begin
      if (((imageTag > FSaleCount) or (FListCount > 0))
      and (FDoc.docForm[cntr].FormID = LFormID)) or
         (((imageTag <= FSaleCount) or (FListCount = 0))
         and (FDoc.docForm[cntr].FormID = CFormID)) then
        begin
          form := FDoc.docForm[cntr];
          count := 0;
          if isSale then  //this is for sales
            begin
              if (imageTag > 3) then
                begin
                  count := imageTag div 3;
                  if imageTag Mod 3 = 0 then
                    count := count -1;
                end;

            end
          else   //this is for listing
            begin
              aListTag := imageTag - FSaleCount;
              count := 0;
              if (aListTag > 3) then
                begin
                  count := aListTag div 3;
                  if aListTag Mod 3 = 0 then
                    count := count -1;
                end;
            end;
          form := Fdoc.GetFormByOccurancebyIdx(FDoc.docForm[cntr].FormID, count, -1, True); //github #708

          if assigned(form) then
          begin
            cell := form.GetCellByID(topImageID);   //check the top image
            if assigned(cell) and (cell is TPhotoCell) and
              (not TPhotoCell(cell).HasImage or FOverWriteData ) then
              begin
                  break;
              end;
            cell := form.GetCellByID(midImageID);   //check the middle image
            if assigned(cell) and (cell is TPhotoCell) and
              (not TPhotoCell(cell).HasImage or FOverWriteData) then
              begin
                  break;
              end;
            cell := form.GetCellByID(botImageID);   //check the bottom image
            if (cell is TPhotoCell) and
              (not TPhotoCell(cell).HasImage or FOverwriteData) then
              begin
                  break;
              end;
            cell := nil;
          end;
        end;
      end;
    if not assigned(cell) then
      begin   //create new photo subject extra page
        //see how many photo pages we need to insert?
        //TODO: should make it more robust
        if isSale then
          idx := idx
        else
          begin
            if ListIdx = -1 then
              begin
                idx := GetFormIndex(FDoc, LFormID);
                if idx <> -1 then
                  Idx := Idx + 1;
              end
            else
              idx := ListIdx+1;
          end;
        case imageTag of
         1..3: form := FDoc.InsertFormUID(TFormUID.Create(CFormID),true,idx);
         4..6: begin
                 if not isSale then
                   begin
                     form := FDoc.GetFormByOccurance(LFormID, 0, False);
                     if not assigned(form) then
                       form := FDoc.InsertFormUID(TFormUID.Create(LFormID), true, idx);
                     aListTag := imageTag - FSaleCount;
                   end
                 else
                   form := FDoc.InsertFormUID(TFormUID.Create(CFormID), true, idx);
               end;
         7..9: begin
                 if not isSale then
                   begin
                     form := FDoc.GetFormByOccurance(LFormID, 0, False);
                     if not assigned(form) then
                       form := FDoc.InsertFormUID(TFormUID.Create(LFormID), true, idx) ;
                     aListTag := imageTag - FSaleCount;
                   end
                 else
                   form := FDoc.InsertFormUID(TFormUID.Create(CFormID), true, idx);
               end;
         10..12: begin
                   if not isSale then
                     begin
                       form := FDoc.GetFormByOccurance(LFormID, 0, False);
                       if not assigned(form) then
                         form := FDoc.InsertFormUID(TFormUID.Create(LFormID), true, idx);
                       aListTag := imageTag - FSaleCount;
                     end
                   else
                     form := FDoc.InsertFormUID(TFormUID.Create(CFormID), true, idx);
                 end;
         13..15: begin
                   if not isSale then
                     begin
                       form := FDoc.GetFormByOccurance(LFormID, 0, False);
                       if not assigned(form) then
                         form := FDoc.InsertFormUID(TFormUID.Create(LFormID), true, idx);
                       aListTag := imageTag - FSaleCount;
                     end
                   else
                     form := FDoc.InsertFormUID(TFormUID.Create(CFormID), true, idx);
                 end;
         16..18, 19..21, 22..24, 25..27, 28..30, 31..33, 34..36, 37..39, 40..42, 43..45, 46..48, 49..51: begin
                   if not isSale then
                     begin
                       form := FDoc.GetFormByOccurance(LFormID, 0, False);
                       if not assigned(form) then
                         form := FDoc.InsertFormUID(TFormUID.Create(LFormID), true, idx);
                       aListTag := imageTag - FSaleCount;
                     end
                   else
                     form := FDoc.InsertFormUID(TFormUID.Create(CFormID), true, idx);
                 end;
        end;
    end;

    if isSale then
      begin
        case imageTag of  //Ticket #1354: increate max comps to 51 it was 15 before
          1, 4, 7, 10, 13,16,19,22,25,28,31,34,37,40,43,46,49: cell := form.GetCellByID(topImageID);
          2, 5, 8, 11, 14,17,20,23,26,29,32,35,38,41,44,47,50: cell := form.GetCellByID(midImageID);
          3, 6, 9, 12, 15,18,21,24,27,30,33,36,39,42,45,48,51: cell := form.GetCellByID(botImageID);
        end;
      end
   else
     begin
        case aListTag of  //Ticket #1354: increate max comps to 51 it was 15 before
          1, 4, 7, 10, 13,16,19,22,25,28,31,34,37,40,43,46,49: cell := form.GetCellByID(topImageID);
          2, 5, 8, 11, 14,17,20,23,26,29,32,35,38,41,44,47,50: cell := form.GetCellByID(midImageID);
          3, 6, 9, 12, 15,18,21,24,27,30,33,36,39,42,45,48,51: cell := form.GetCellByID(botImageID);
        end;
     end;

  if photo = nil then exit;
  if assigned(cell) and (cell is TPhotoCell) then
    if FOverwriteData or not(TPhotoCell(cell).HasImage) then
    begin
       aStream := TMemoryStream.Create;
       try
         Photo.Picture.Graphic.SaveToStream(aStream);
         aStream.Position := 0;
         TGraphicCell(cell).LoadStreamData(aStream, aStream.Size, True);
         cell.Display;
       finally
         aStream.Free;
       end;
    end;

  if assigned(cell) then
    begin
      case form.FormID of
       4084: //Comp and Listing Non lender form
        begin
          aCellNo := cell.UID.num +1;
          if aCellNo > 0 then
            SetAddressFor4084(imageTag, aCellNo, form, cell);
        end;
       4181: //Comp and Listing Non lender form
        begin
          aCellNo := cell.UID.num +1;
          if aCellNo > 0 then
            SetAddressFor4181(imageTag, aCellNo, form, cell);
        end;
       4082: //Comp and Listing Non lender form
        begin
          aCellNo := cell.UID.num +1;
          if aCellNo > 0 then
            SetAddressFor4082(imageTag-FSaleCount, aCellNo, form, cell);
        end;
      end;
    end;
end;


function TInspectionDetail.GetFormPageCount(imageTag:Integer):Integer;
var
  cell: TBaseCell;
  form: TDocForm;
  CFormID, LFormID, aCellNo:Integer;
  idx, idx2, ListIdx: Integer;
  isSale:Boolean;
  cntr,aListTag: Integer;
  imageCellID: Integer;
  line1No, line2No: Integer;
  compNo, count: Integer;
  aStream: TMemoryStream;
begin
  cell := nil;

  form := nil;
  aListTag := 0;
  CFormID := GetCompMainFormID;
  LFormID := GetListingMainFormID;
  isSale := imageTag <= FSaleCount;
  idx := GetFormIndex(FDoc, CFormID);  //github #602
  ListIdx := GetFormIndex(FDoc, LFormID);
  isSale := imageTag <= FSaleCount;
  if idx <> -1 then
    idx := idx + 1;

  //find the 1st available slot in the photo pages
  for cntr := 0 to FDoc.docForm.Count - 1 do
    begin
      if ((imageTag > FSaleCount) and (FDoc.docForm[cntr].FormID = LFormID)) or
         ((imageTag <= FSaleCount) and (FDoc.docForm[cntr].FormID = CFormID)) then
        begin
          form := FDoc.docForm[cntr];
          count := 0;
          if isSale then  //this is for sales
            begin
              if (imageTag > 3) then
                begin
                  count := imageTag div 3;
                  if imageTag Mod 3 = 0 then
                    count := count -1;
                end;

            end
          else   //this is for listing
            begin
              aListTag := imageTag - FSaleCount;
              count := aListTag   div 3;
              if imageTag Mod 3 = 0 then
                count := count -1;
            end;
        end;
    end;
  result := count;
end;



procedure TInspectionDetail.ImportCompImages(photo:TImage; imageTag: Integer; image_desc: String);

const
  formID3x5 = 304;
  formID4x6 = 314;
  comp1PhotoCellID = 1163;
  comp1AddrLine1No = 15;
  comp1AddrLine2No = 16;
  comp2PhotoCellID = 1164;
  comp2AddrLine1No = 19;
  comp2AddrLine2No = 20;
  comp3PhotoCellID = 1165;
  comp3AddrLine1No = 23;
  comp3AddrLine2No = 24;
  pageNo = 1; //comp photo forms have just 1 page
var
  imageCellID: Integer;
  line1No, line2No: Integer;
  cell: TBaseCell;
  form: TDocForm;
  line1, line2: String;
  compNo, Occur, aFormID, idx: Integer;
  aStream: TMemoryStream;
begin
  case imageTag of
  1, 4, 7, 10, 13,16,19,22,25,28,31,34,37,40,43,46,49:  //Ticket #1354: increate max comps to 51 it was 15 before
    begin
      imageCellID := comp1PhotoCellID;
      line1No := comp1AddrLine1No;
      line2No := comp1AddrLine2No;
      compNo := imageTag;
    end;
  2, 5, 8, 11, 14,17,20,23,26,29,32,35,38,41,44,47,50: //Ticket #1354: increate max comps to 51 it was 15 before
    begin
      imageCellID := comp2PhotoCellID;
      line1No := comp2AddrLine1No;
      line2No := comp2AddrLine2No;
      compNo := imageTag;
    end;
  3, 6, 9, 12, 15,18,21,24,27,30,33,36,39,42,45,48,51: //Ticket #1354: increate max comps to 51 it was 15 before
    begin
      imageCellID := comp3PhotoCellID;
      line1No := comp3AddrLine1No;
      line2No := comp3AddrLine2No;
      compNo := ImageTag;
    end;
    else  exit;
  end;
  cell := Fdoc.GetCellByID(imageCellID);
  if assigned(cell) then
    begin
//    form := Fdoc.docForm.GetFormByOccurance(cell.UID.FormID,GetFormPageCount(imageTag))
      Occur := GetFormPageCount(imageTag);
//      form := Fdoc.GetFormByOccurance(cell.UID.FormID,Occur, True)
      aFormID := GetCompMainFormID;
      idx := GetFormIndex(Fdoc, aFormID);
      form := FDoc.GetFormByOccuranceByIdx(aFormID, Occur, idx, True);
    end
  else if FOverwriteData or not assigned(cell) then //github 209: only create form when we're in overwrite mode
    begin
      form := Fdoc.InsertFormUID(TFormUID.Create(formID3x5),true,-1);
      cell := form.GetCellByID(imageCellID);
    end;
  if assigned(cell) and (cell is TPhotoCell) and (FOverwriteData or TPhotoCell(cell).FEmptyCell) then
    begin
      if TPhotoCell(cell).HasImage then
        TPhotoCell(cell).FImage.Clear;
      Fdoc.MakeCurCell(cell);        //make sure its active

       aStream := TMemoryStream.Create;
       try
         Photo.Picture.Graphic.SaveToStream(aStream);
         aStream.Position := 0;
         TGraphicCell(cell).LoadStreamData(aStream, aStream.Size, True);
         cell.Display;
       finally
         aStream.Free;
       end;
    end
  else
    begin
//      if FOverwriteData then
//        errMsg := 'Cannot insert subject photo';
      exit;
    end;
end;



procedure TInspectionDetail.SetAddressFor4084(i, aCellNo: Integer; aForm: TDocForm; cell: TBaseCell);
var
  addr, CityStZip: String;
  CompCol: TCompColumn;
begin
  if assigned(FDocCompTable) and (FDocCompTable.Count > 0) then
  if assigned(FDocCompTable.Comp[i]) then
    begin
      CompCol := FDocCompTable.Comp[i];
      if assigned(CompCol) then
        begin
          addr := CompCol.GetCellTextByID(925);
          CityStZip := CompCol.GetCellTextByID(926);
          aForm.SetCellText(1, aCellNo-2, addr);  //image cellid - 2
          aForm.SetCellText(1, aCellNo-1, CityStZip);  //image cellid -1
        end;
     end;
end;

procedure TInspectionDetail.SetAddressFor4181(i, aCellNo: Integer; aForm: TDocForm; cell: TBaseCell);
var
  addr, CityStZip: String;
  CompCol: TCompColumn;
begin
  if assigned(FDocCompTable) and (FDocCompTable.Count > 0) then
  if assigned(FDocCompTable.Comp[i]) then
    begin
      CompCol := FDocCompTable.Comp[i];
      if assigned(CompCol) then
        begin
          addr := CompCol.GetCellTextByID(925);
          CityStZip := CompCol.GetCellTextByID(926);
          aForm.SetCellText(1, aCellNo-2, addr);  //image cellid - 2
          aForm.SetCellText(1, aCellNo-1, CityStZip);  //image cellid -1
        end;
     end;
end;

procedure TInspectionDetail.SetAddressFor4082(i, aCellNo: Integer; aForm: TDocForm; cell: TBaseCell);
var
  addr, CityStZip: String;
  CompCol: TCompColumn;
begin
  if assigned(FDocListTable) and (FDocListTable.Count > 0) then
  if assigned(FDocListTable.Comp[i]) then
    begin
      CompCol := FDocListTable.Comp[i];
      if assigned(CompCol) then
        begin
          addr := CompCol.GetCellTextByID(925);
          CityStZip := CompCol.GetCellTextByID(926);
          aForm.SetCellText(1, aCellNo-2, addr);  //image cellid - 2
          aForm.SetCellText(1, aCellNo-1, CityStZip);  //image cellid -1
        end;
     end;
end;



function TInspectionDetail.GetSubjectExtraFormID:Integer;
begin
  case rdoExtraSubject.ItemIndex of
    1: result := 324;
    2: result := 326;
    3: result := 325;
    else
      result := 302;
  end;
end;

function TInspectionDetail.GetCompExtraFormID:Integer;
begin
  result := 308;
end;


function TInspectionDetail.GetSubjectExtraCellIDTitleFor302(isNew:Boolean; aForm: TDocForm; var aCellID, aCellTitleID: Integer; var cell: TBaseCell): Boolean;
var
  found: Boolean;
  i, c, topCellID: Integer;

begin
  found := False;
  topCellID := 15;
  if isNew then
    begin
      aCellID := topCellID;
      cell := aForm.GetCell(1, topCellID);
      aCellTitleID := aCellID - 2;
      found := True;
    end
  else
    begin
      cell := aForm.GetCell(1, topCellID);
      if assigned(cell) and (cell is TPhotoCell) and not TPhotoCell(cell).HasImage then
        begin
          aCellID := topCellID;
          aCellTitleID := aCellID - 2;
          found := True;
        end;
      if not found then
        begin
          c := topCellID;
          for i:= 1 to 3 do  //from cell # 2 to cell #6
            begin
              if i = 1 then
                c := topCellID
              else
                c := c + 3;
              cell := aForm.GetCell(1,c);
              if assigned(cell) and (cell is TPhotoCell) and not TPhotoCell(cell).HasImage then
                begin
                  aCellID := c;
                  aCellTitleID := aCellID - 2;
                  found := True;
                  break;
                end
            end;
        end;
      end;
  result := found;
end;


function TInspectionDetail.GetCompExtraCellIDTitleFor308(isNew:Boolean; aForm: TDocForm; var aCellID, aCellTitleID: Integer; var cell: TBaseCell): Boolean;
var
  found: Boolean;
begin
  found := False;
  case aForm.FormID of
    308:
      begin
        if isNew then
          begin
            cell := aForm.GetCell(1, 16);
            aCellID := 16;
            aCellTitleID := aCellID - 2;
            found := True;
          end
        else
          begin
            cell := aForm.GetCell(1, 16);
            if assigned(cell) and (cell is TPhotoCell) and not TPhotoCell(cell).HasImage then
              begin
                aCellID := 16;
                aCellTitleID := aCellID - 2;
                found := True;
              end;
            if not found then
              begin
                cell := aForm.GetCell(1,19);
                if assigned(cell) and (cell is TPhotoCell) and not TPhotoCell(cell).HasImage then
                  begin
                    aCellID := 19;
                    aCellTitleID := aCellID - 2;
                    found := True;
                  end;
              end;
            if not found then
              begin
                cell := aForm.GetCell(1, 22);
                if assigned(cell) and (cell is TPhotoCell) and not TPhotoCell(cell).HasImage then
                  begin
                    aCellID := 22;
                    aCellTitleID := aCellID - 2;
                    found := True;
                  end;
              end;
          end;
      end;
  end;
  result := found;
end;



function TInspectionDetail.GetSubjectExtraCellIDTitle(isNew:Boolean; aForm: TDocForm; var aCellID, aCellTitleID: Integer; var cell: TBaseCell): Boolean;
var
  topCellID: Integer;
  found: Boolean;
  i, c, n: Integer;
begin
  found := False;
  case aForm.FormID of
    324, 326, 325:
      begin
        topCellID := 14;
        if isNew then
          begin
            cell := aForm.GetCell(1, topCellID);
            aCellID := topCellID;
            aCellTitleID := topCellID +1;
            found := True;
          end
        else
          begin
            cell := aForm.GetCell(1, topCellID);
            if assigned(cell) and (cell is TPhotoCell) and not TPhotoCell(cell).HasImage then
              begin
                aCellID := topCellID;
                aCellTitleID := aCellID +1;
                found := True;
              end;
            if not found then
              begin
                case aForm.FormID of
                  324: n := 6;
                  326: n := 12;
                  325: n := 15;
                end;
                c := topCellID;
                for i:= 1 to n do  //from cell # 2 to cell #6
                  begin
                    if i = 1 then
                      c := topCellID
                    else
                      c := c + 2;
                    cell := aForm.GetCell(1,c);
                    if assigned(cell) and (cell is TPhotoCell) and not TPhotoCell(cell).HasImage then
                      begin
                        aCellID := c;
                        aCellTitleID := aCellID +1;
                        found := True;
                        break;
                      end
                  end;
              end;
          end;
      end;
  end;
  result := found;
end;

function TInspectionDetail.GetCompExtraCellIDTitle(isNew:Boolean; aForm: TDocForm; var aCellID, aCellTitleID: Integer; var cell: TBaseCell): Boolean;
const
  topCellID = 14;
  secondCellID = 16;
var
  found: Boolean;
  i, c: Integer;
begin
  found := False;
  case aForm.FormID of
    324, 326, 325:
      begin
        if isNew then
          begin
            cell := aForm.GetCell(1, topCellID);
            aCellID := topCellID;
            aCellTitleID := topCellID +1;
            found := True;
          end
        else
          begin
            cell := aForm.GetCell(1, topCellID);
            if assigned(cell) and (cell is TPhotoCell) and not TPhotoCell(cell).HasImage then
              begin
                aCellID := topCellID;
                aCellTitleID := aCellID +1;
                found := True;
              end;
            if not found then
              begin
                case aForm.FormID of
                  324:
                    begin
                      c := 0;
                      for i:= 2 to 6 do  //from cell # 2 to cell #6
                        begin
                          if c = 0 then
                            c := topCellID + 2
                          else
                            c := c + 2;
                          cell := aForm.GetCell(1,c);
                          if assigned(cell) and (cell is TPhotoCell) and not TPhotoCell(cell).HasImage then
                            begin
                              aCellID := c;
                              aCellTitleID := aCellID +1;
                              found := True;
                              break;
                            end;
                        end;
                    end;
                  326:
                    begin
                      c := 0;
                      for i:= 2 to 12 do  //from cell #2 to cell #12
                        begin
                          if c = 0 then
                            c := topCellID + 2
                          else
                            c := c + 2;
                          cell := aForm.GetCell(1,c);
                          if assigned(cell) and (cell is TPhotoCell) and not TPhotoCell(cell).HasImage then
                            begin
                              aCellID := c;
                              aCellTitleID := aCellID +1;
                              found := True;
                              break;
                            end;
                        end;
                    end;
                  325:
                    begin
                      c := 0;
                      for i:= 2 to 15 do  //from cell #2 to cell #15
                        begin
                          if c = 0 then
                            c := topCellID + 2
                          else
                            c := c + 2;
                          cell := aForm.GetCell(1,c);
                          if assigned(cell) and (cell is TPhotoCell) and not TPhotoCell(cell).HasImage then
                            begin
                              aCellID := c;
                              aCellTitleID := aCellID +1;
                              found := True;
                              break;
                            end;
                        end;
                    end;
                end;
              end;
          end;
      end;
  end;
  result := found;
end;

function getTotImageCountByFormID(aFormID:Integer):Integer;
begin
  case aFormID of
     302: result := 3;
     324: result := 6;
     326: result := 12;
     325: result := 15;
     else
       result := 3;
  end;
end;

procedure TInspectionDetail.ImportSubjectExtraImages(photo:TImage; image_id:Integer; image_desc: String);
var
  cell: TBaseCell;
  form: TDocForm;
  cntr: Integer;
  descrCellID, descrTitleCellID: Integer;
  aStream: TMemoryStream;
  aTitle: String;
  idx, idxMain: Integer;
  aFormID, aSubjMainFormID: Integer;
  found, oktoAdd: Boolean;
begin
  cell := nil;
  form := nil;
  idx  := -1;
  idxMain := -1;
  descrCellId := 0;
  descrTitleCellID := 0;
  found := False;
  try
    aFormID := GetSubjectExtraFormID;
    aSubjMainFormID := GetSubjectMainFormID;
    //find the 1st available slot in Subject Extra phot pages
    for cntr := 0 to FDoc.docForm.Count - 1 do
      begin
        if FDoc.docForm[cntr].FormID = aFormID then
          begin
            form := FDoc.docForm[cntr];
            if aFormID = aSubjMainFormID then
               idxMain := cntr;

            if aFormID = 302 then
              found := GetSubjectExtraCellIDTitleFor302(False, form, descrCellID, descrTitleCellID, cell)
            else
              found := GetSubjectExtraCellIDTitle(False, form, descrCellID, descrTitleCellID, cell);
            //github #  691
            if found then
             if (cell is TPhotoCell) and  not(TPhotoCell(cell).HasImage) then
               break;    //we found an empty cell for the correct form
          end;
      end;
      if (cell = nil) or not found then
        begin
           if (idxMain <> -1) and (idx = -1) then
             idx := idxMain + 1;

           form := FDoc.InsertFormUID(TFormUID.Create(aFormID),true,idx);
           if aFormID = 302 then
             found := GetSubjectExtraCellIDTitleFor302(True, form, descrCellID, descrTitleCellID, Cell)
           else
             found := GetSubjectExtraCellIDTitle(True, form, descrCellID, descrTitleCellID, Cell)
        end;
    if assigned(cell) and (cell is TPhotoCell) then
      begin
        if found and not(TPhotoCell(cell).HasImage) then
          OKtoAdd := true
        else  //github #725: add this logic here to insert more pages if needed
          begin
             form := FDoc.InsertFormUID(TFormUID.Create(aFormID),true,idx);
             if aFormID = 302 then
               found := GetSubjectExtraCellIDTitleFor302(True, form, descrCellID, descrTitleCellID, Cell)
             else
               found := GetSubjectExtraCellIDTitle(True, form, descrCellID, descrTitleCellID, Cell);
             okToAdd := found;
          end;
        if oktoAdd then
        begin
           aStream := TMemoryStream.Create;
           try
             Photo.Picture.Graphic.SaveToStream(aStream);
             aStream.Position := 0;
             TGraphicCell(cell).LoadStreamData(aStream, aStream.Size, True);
             cell.Display;
           finally
             aStream.Free;
           end;
           Form.SetCellText(1, descrTitleCellID, image_desc);
        end;
      end;
  finally
  end;
end;



(*
function TInspectionDetail.TransferCompPhotos: Boolean;
var
  i,j: Integer;
  aFrame: TPanel;
  aCheckBox: TComponent;
  aImageTag: TLabel;
  aImagePhoto: TComponent;
  aPropID: Integer;
  isCreated: Boolean;
  aLabel: TComponent;
  aCompPanel: TComponent;
  aTitle: String;
  aFormID, idx: Integer;
  aCompPanelName: String;
begin
  isCreated := False;
  result := True;
  //### IMPORTANT: we need to delete the comp main photo page before we import so it won't add comp 1,2,3 to 4,5,6
  aFormID := GetCompMainFormID;
  idx := GetFormIndex(Fdoc, aFormID);
  if FOverwriteData then
    begin
      if idx > 0 then
        begin
//          if not OK2Continue('We''re about to overwrite your Comparable Images.  Continue?') then
//            exit;
        end;
//      if (FSaleCount > 0) and (PhotoDisplayComps.ComponentCount > 0) then  //github #744: donot remove the form
//        DeleteExistingForm(FDoc, GetCompMainFormID);
//      if (FListCount > 0) and (PhotoDisplayComps.ComponentCount > 0) then
//        DeleteExistingForm(FDoc, GetListingMainFormID);
    end
  else //if it's not in overwrite mode, exit
    begin
     if idx >= 0 then exit;
    end;
  try
//   for i:= 0 to (FSaleCount + FListCount) - 1 do    //github #722: cannot rely on the original sales/listing count
    for i:= 0 to PhotoDisplayComps.ComponentCount -1 do
      begin
        aCompPanelName := Format('CompPanel%d',[i+1]);
        aCompPanel := FindAnyControl(PhotoDisplayComps, aCompPanelName);
        if assigned(aComppanel) and (aCompPanel is TPanel) then
          for j:= 0 to aCompPanel.ComponentCount -1 do
            begin
               if aCompPanel.Components[j] is TPanel then
                 begin
                   aFrame := TPanel(aCompPanel.Components[j]);
                   aLabel := FindAnyControl(aFrame, 'Label');
                   if assigned(aLabel) and (aLabel is TLabel) then
                     aTitle := TLabel(aLabel).Caption;
                   //First check if the photo is selected for transfer
                   aCheckBox := FindAnyControl(aFrame, TRANSFER_NAME + IntToStr(j));
                   if aCheckBox is TCheckBox and TCheckBox(aCheckBox).Checked then
                     begin
                       //if ( j< FCompPhotoList.count) then//and Assigned(FCompPhotoList.Items[j]) then  //make sure we have a photo
                          begin
                            aPropID := getValidInteger(TPanel(aCompPanel).Name);
                            aImagePhoto := FindAnyControl(aFrame, IMAGE_NAME + IntToStr(j));
                            if assigned(aImagePhoto) then
                              ImportCompMainImages(TImage(aImagePhoto), aPropID, aTitle)
                              //ImportCompImages(TImage(aImagePhoto), aPropID, aTitle);
                           end;
                       end;
               end;
             end;
         if assigned(aCompPanel) and (aCompPanel.ComponentCount = 0) and (i >= 0) then //Ticket #1341: check if aCompPanel is not null first.
          ImportCompMainImages(nil, i+1, '');   //github #708: if no image, we still want to insert the form
      end;
  except on E:Exception do
    begin
      ShowAlert(atWarnAlert, 'Error transfering Comp/Listing Photos to the report.  '+e.message);
      result := False;
    end;
  end;
end;
*)
function TInspectionDetail.TransferCompPhotos: Boolean;
var
  i,j: Integer;
  aFrame: TPanel;
  aCheckBox: TComponent;
  aImageTag: TLabel;
  aImagePhoto: TComponent;
  aPropID: Integer;
  isCreated: Boolean;
  aLabel: TComponent;
  aCompPanel: TComponent;
  aTitle: String;
  aFormID, idx: Integer;
  aCompPanelName: String;
begin
  isCreated := False;
  result := True;
  //### IMPORTANT: we need to delete the comp main photo page before we import so it won't add comp 1,2,3 to 4,5,6
  aFormID := GetCompMainFormID;
  idx := GetFormIndex(Fdoc, aFormID);
  if FOverwriteData then
    begin
//      ClearCompPhotoImages;
    end
  else //if it's not in overwrite mode, exit
    begin
     if idx >= 0 then exit;
    end;
  try
    for i:= 0 to PhotoDisplayComps.ComponentCount -1 do
      begin
        aCompPanelName := Format('CompPanel%d',[i+1]);
        aCompPanel := FindAnyControl(PhotoDisplayComps, aCompPanelName);
        if assigned(aComppanel) and (aCompPanel is TPanel) then
          for j:= 0 to aCompPanel.ComponentCount -1 do
            begin
               if aCompPanel.Components[j] is TPanel then
                 begin
                   aFrame := TPanel(aCompPanel.Components[j]);
                   aLabel := FindAnyControl(aFrame, 'Label');
                   if assigned(aLabel) and (aLabel is TLabel) then
                     aTitle := TLabel(aLabel).Caption;
                   //First check if the photo is selected for transfer
                   aCheckBox := FindAnyControl(aFrame, TRANSFER_NAME + IntToStr(j));
                   if aCheckBox is TCheckBox and TCheckBox(aCheckBox).Checked then
                     begin
                       //if ( j< FCompPhotoList.count) then//and Assigned(FCompPhotoList.Items[j]) then  //make sure we have a photo
                          begin
                            aPropID := getValidInteger(TPanel(aCompPanel).Name);
                            aImagePhoto := FindAnyControl(aFrame, IMAGE_NAME + IntToStr(j));
                            if assigned(aImagePhoto) then
                              ImportCompMainImages(TImage(aImagePhoto), aPropID, aTitle)
                              //ImportCompImages(TImage(aImagePhoto), aPropID, aTitle);
                           end;
                       end;
               end;
             end;
         if assigned(aCompPanel) and (aCompPanel.ComponentCount = 0) and (i >= 0) then //Ticket #1341: check if aCompPanel is not null first.
          ImportCompMainImages(nil, i+1, '');   //github #708: if no image, we still want to insert the form
      end;
  except on E:Exception do
    begin
      ShowAlert(atWarnAlert, 'Error transfering Comp/Listing Photos to the report.  '+e.message);
      result := False;
    end;
  end;
end;




procedure TInspectionDetail.CompTransferCheckBoxClick(Sender: TObject);
var
  aCheckBox: TCheckBox;
  aComponent, aParent: TComponent;
  i,j: Integer;
  aChecked: Boolean;
  aFrame: TPanel;
begin
  if Sender is TCheckBox then
    begin
      aCheckBox := TCheckBox(sender);
      aChecked := aCheckBox.Checked;
      aComponent := aCheckBox.Parent;
      if assigned(aComponent) then
        if aComponent is TPanel then
          aParent := TPanel(aComponent).Parent;
        if assigned(aParent) then
          for i:= 0 to aParent.ComponentCount -1 do
          begin
            if aParent.Components[i] is TPanel then
              begin
                aFrame := TPanel(aParent.Components[i]);
                for j := 0 to aFrame.ComponentCount -1 do
                  if aFrame.Components[j] is TCheckBox then
                    begin
                    if (TCheckBox(aFrame.Components[j]) <> aCheckBox)  then
                      if aChecked then //if we check on a check box, we want to uncheck others
                         TCheckBox(aFrame.Components[j]).Checked := not achecked;
                    end;
              end;
          end;
    end;
end;

//PAM: Ticket #1407: if user uncheck a check box no need to continue
//If user check a check box, we need to loop through the top photo section to uncheck the one with
//the same photo caption.
procedure TInspectionDetail.SubjectTransferCheckBoxClick(Sender: TObject);
var
  CurCheckBox: TCheckBox;
  aPanel:TPanel;
  aEdit, aCheckBox, aComponent: TComponent;
  i,aTag: Integer;
  aChecked: Boolean;
  aFrame: TPanel;
  aTitle,aName: String;
begin
  if Sender is TCheckBox then
    begin
      CurCheckBox := TCheckBox(sender);
      aName := UpperCase(CurCheckBox.Name);
      if pos('FRONTVIEW', aName) > 0 then
        aName := 'FrontView'
      else if pos('STREETVIEW', aName) > 0 then
        aName := 'StreetView'
      else if pos('REARVIEW', aName) > 0 then
        aName := 'RearView';
      aChecked := CurCheckBox.Checked;
      if not aChecked then exit;  //Ticket #1407
      aTag := CurCheckBox.Tag;
       for i:= 0 to TopPhotoSection.ComponentCount -1 do
         begin
           aPanel := TPanel(TopPhotoSection.Components[i]);  //this is the panel that contains the check box
           if not assigned(aPanel) then continue;
           aCheckBox := FindAnyControl(TPanel(aPanel), aName + IntToStr(i));   //find the check box
           if aCheckBox = nil then continue
           else if aCheckBox is TCheckBox then   //found it
             begin
               if pos(aName, aCheckBox.Name) > 0 then  //are they the same caption of the one selected
                 begin
                   if CompareText(aCheckBox.Name,CurCheckBox.Name) = 0 then  //ignore the selected one
                     continue
                   else
                     TCheckBox(aCheckBox).Checked := not aChecked; //uncheck the same checkbox caption
                 end;
             end;
         end;
    end;
end;


procedure TInspectionDetail.JsonTreeClick(Sender: TObject);
var
  aNode: TTreeNode;
begin
  aNode := jsonTree.Selected;
  if pos('JSON', upperCase(aNode.Text)) > 0 then
    begin
      aNode.ImageIndex := iJson_Mark_Color;
      jsonTree.Refresh;
    end;
end;

procedure TInspectionDetail.btnSaveToFileClick(Sender: TObject);
var
  SaveDialog: TSaveDialog;
  aInspID: Integer;
begin
  SaveDialog := TSaveDialog.Create(self);
  aInspID := GetValidInteger(lblInsp_ID.Caption);
  try
    SaveDialog.InitialDir := IncludeTrailingPathDelimiter(FInspectionDebugPath);
  finally
    if SaveDialog.Execute then
      jsonMemo.Lines.SaveToFile(SaveDialog.FileName);
    SaveDialog.Free;
  end;
end;
procedure TInspectionDetail.btnPrintClick(Sender: TObject);
var
  MemoOutput: TextFile;
  i: Integer;
begin
  Printer := TPrintDialog.Create(nil);     //Ticket #: drop a printDialog component on the form and use it
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

//### Important: we need to call LoadJsonTree to get the FSaleCount and FListCount before call downloadinspeciton
procedure TInspectionDetail.LoadJsonTree(InspectionData:String);
var
  aFileName, aName, aValue, aItem, posted_data, Subject_data, Comps_data, Comp_data: String;
  i, j, k: Integer;
  jSummaryObj,jpObject,jsList, joPostedData, joSubject, joComps, joComp : TlkJSONobject;
  jSummary,jdata,jpostedData, jSubject, jComps: TlkJSonBase;
  jmetho: TlkJSONobjectmethod;
  SummaryNode, RoofNode,posted_dataNode,SubjectNode, CompsNode, CompNode: TTreeNode;
  aCount: Integer;
  Summary_data, aCompType: String;
begin
  jsList := TlkJSON.ParseText(InspectionData) as TlkJSONobject;
  if jsList = nil then exit;
  jsonTree.Items.Clear;
  try
    jdata :=TlkJsonObject(jsList).Field['data'];
    jsonTree.Items.Clear;
    RoofNode := jsonTree.Items.Add(nil, 'JSON'); { Add a root node. }
    RoofNode.ImageIndex := iJson_Mark_Color;
    if jdata = nil then exit;
    if jdata = nil then exit;
    for i:= 0 to jdata.count -1 do
      begin
        aName := TlkJSONobjectMethod(jdata.Field[i]).Name;
        aValue := varToStr(jdata.Field[aName].Value);
        aItem := Format('%s = %s',[aName, aValue]);
        if CompareText(aName, 'posted_data') <> 0 then
          jsonTree.Items.AddChild(RoofNode, aItem)
        else
          begin
            jpostedData := TlkJsonObject(jdata).Field['posted_data'];
            posted_data := TlkJSON.GenerateText(jpostedData);
            joPostedData := TlkJSON.ParseText(posted_data) as TlkJSONobject;
            posted_dataNode := jsonTree.Items.AddChild(RoofNode,'posted_data');

            //load subject data
            jSubject := TlkJsonObject(joPostedData).Field['Subject'];
            if jSubject.Count > 0 then
            { Add a child node to the node just added. }
            SubjectNode := jsonTree.Items.AddChild(posted_dataNode,'Subject');
            SubjectNode.ImageIndex := iJson_Mark_Color;
            for j:= 0 to jSubject.Count - 1 do
              begin
                aName := TlkJSonObjectMethod(jSubject.Field[j]).Name;
                subject_data := TlkjSon.GenerateText(jSubject);
                joSubject := TlkJSon.ParseText(Subject_data) as TlkJSonObject;
                DisplayNode(SubjectNode, joSubject, aName);
              end;

            //load Comp data
            jComps := TlkJsonObject(joPostedData).Field['Comps'];
            if jComps = nil then exit;
            CompsNode := jsonTree.Items.AddChild(posted_dataNode, 'Comps');
            CompsNode.ImageIndex := iJSon_Bracket_Color;
            aCount := 0;   FSaleCount := 0; FListCount := 0;
            for j:= 0 to jComps.Count -1 do
              begin
                 CompNode := jsonTree.Items.AddChild(CompsNode, Format('%d',[j]));
                 Comps_data := TlkJSON.GenerateText(jComps.Child[i]);
                 joComps := TLKJSON.ParseText(Comps_data) as TlkJsonObject;
                 CompNode.Text := Format('Comp[%d]',[j]);
                 for k:= 0 to jComps.child[j].Count - 1 do
                   begin
                     aName := TlkJSonObjectMethod(jComps.Child[j].Field[k]).Name;
                     comp_data := TlkjSon.GenerateText(jComps.Child[j]);
                     joComp := TlkJSon.ParseText(comp_data) as TlkJSonObject;
                     if compareText(aName, 'CompType') = 0 then
                       begin
                         aCompType := GetJsonString(aName, joComp);
                         if CompareText('Sale',aCompType) = 0 then
                           inc(FSaleCount)
                         else
                           inc(FListCount);
                       end;
                     DisplayNode(CompNode, joComp, aName);
                   end;
              end;

        jpObject := TlkJSON.ParseText(posted_data) as TlkJSONobject;

        jSummary := TlkJsonObject(jpObject).Field['Summary'];
        if jSummary = nil then exit;
        SummaryNode := jsonTree.Items.AddChild(posted_dataNode, 'Summary');
        SummaryNode.ImageIndex := iJson_Mark_Color;
        if not (jSummary.Field['Summary'] is TlkJSONnull) then
          begin
            Summary_data := TlkJSON.GenerateText(jSummary);
            if Summary_data <> '' then
              begin
                jSummaryObj := TLKJSON.ParseText(Summary_data) as TlkJsonObject;
                if jSummaryObj = nil then exit;
                try
                  for k:= 0 to jSummaryobj.Count - 1 do
                    begin
                      aName := TlkJSonObjectMethod(jSummary.Field[k]).Name;
                      Summary_data := TlkjSon.GenerateText(jSummary);
                      jSummaryObj := TlkJSon.ParseText(Summary_data) as TlkJSonObject;
                      DisplayNode(SummaryNode, jSummaryObj, aName);
                    end;
                except ; end;
              end;
          end;
        end;
      end;
  finally
    LoadJsonToMemo;
  end;
end;

procedure TInspectionDetail.DisplayNode(var SubjectNode: TTreeNode; var js: TlkJSonObject; aName:String);
var
  aNode: TTreeNode;
  aText: String;
  aInt: Integer;
  aBool: Boolean;
begin
    aNode := jsonTree.Items.AddChild(SubjectNode, aName);
    aNode.ImageIndex := iJson_Text_Color;
    if js.Field[aName] is TlkJSONnumber then
      begin
        aNode.ImageIndex := iJson_Numeric_Color;
        aInt := getJSonInt(aName, js);
        aNode.Text := Format('%s = %d',[aName, aInt]);
      end
    else if js.Field[aName] is TlkJSONboolean then
      begin
        aNode.ImageIndex := iJSon_Boolean_Color;
        aBool := getJSonBool(aName, js);
        aText := BoolToStr(aBool, True);
        aNode.Text := Format('%s = %s',[aName, aText]);
      end
    else if js.Field[aName] is TlkJSONnull then
      begin
        aNode.ImageIndex := iJSon_Null_Color;
        aNode.Text := Format('%s = Null',[aName]);
      end
    else
      begin
        aText := GetJSonString(aName, js);
        aNode.Text := Format('%s = %s',[aName, aText]);
      end;
end;


procedure TInspectionDetail.LoadJsonToMemo;
var
  i: Integer;
  sl: TStringList;
  aItem, aNodeText : String;
  aNode: TTreeNode;
  aCompNo: String;
  iCompNo: Integer;
begin
  sl := TStringList.Create;
  try
    for i := 1 to jsonTree.Items.Count - 1 do
      begin
         aNode := jsonTree.Items[i];
         aNodeText := UpperCase(aNode.Text);
         if pos('Null', aNode.Text) > 0 then
           aNode.Text := StringReplace(aNode.Text, 'Null', ' ',[rfReplaceAll]);
         if (POS('SUBJECT', aNodeText) > 0) and (length(aNodeText) = length('Subject')) then
           begin
             sl.Add('');
             sl.Add('********   SUBJECT   ********');
             sl.Add('');
           end
         else if (POS('COMPS', aNodeText) > 0) and (length(aNodeText) = length('COMPS')) then
           begin
             sl.Add('');
             sl.Add('********   COMPARABLES  ********');
             sl.Add('');
           end
         else if (POS('SUMMARY', aNodeText) > 0) and (length(aNodeText) = length('SUMMARY')) then
           begin
             sl.Add('');
             sl.Add('********   SUMMARY   ********');
             sl.Add('');
           end
         else if pos('COMP[', aNodeText) > 0 then
           begin
             sl.Add('');
             PopStr(aNodeText, 'COMP[');
             aCompNo := popStr(aNodeText, ']');
             iCompNo := GetValidInteger(aCompNo);
             iCompNo := iCompNo + 1;  //make comp[0] as comp #: 1
             sl.Add(Format('Comp #: %d',[iCompNo]));
             sl.Add('');
           end
         else if (POS('PHOTOS', aNodeText) > 0) then
           begin
             continue;  //skip
           end
         else if (POS('INSP_ID', aNodeText) > 0) then
           begin
             sl.Add(aNode.Text);
             popStr(aNodeText, '=');
             lblInsp_ID.Caption := trim(aNodeText);
           end
         else
           sl.Add(aNode.Text);
      end;
      JsonMemo.Lines.Text := sl.text;
  finally
    if assigned(sl) then
      sl.Free;
  end;
end;

procedure TInspectionDetail.DownloadImagesJSon(joImage: TlkJSonBase);
const
 formID3x5 = 301;
 formID3x5SubjExtra = 302;
 formID3x5CompExtra = 308;
 frontCellID = 15;
 rearCellID  = 18;
 streetCellID = 21;
 topCellID = 15;
 midCellID = 18;
 botCellID = 21;

 imgfrontCellID = 1205;
 imgrearCellID = 1206;
 imgstreetCellID = 1207;

 var
  id : Integer;
  jsImage: TlkJSONBase;
  itjs, obj: TlkJSONobject;
  i : integer;
  Image, imagedata : String;
  Photo : TJPEGImage;
  img : TImage;
  image_id: Integer;
  aUrl, image_title, image_type:String;
  thisForm: TDocForm;
  aCellTop, aCellMid, aCellBot: TBaseCell;
  formEmpty:Boolean;
  aCellID: Integer;
  aPropID: String;
  cCount, lCount, iPropID, idx: Integer;
  sl:TStringList;
  isCreated: Boolean;
  iTop, iBot: Integer;
  aComponent: TComponent;
  PropIDList,PropIDList2:TStringList;  //PAM - Ticket #1339: Set up to store propid into a stringlist and use it to drive the check box checked logic
begin
   //download images
  aCellID := topCellID;
  cCount := 0; lCount := 0;  isCreated := False; iTop := 0; iBot := 0;
  idx := -1;
  PushMouseCursor(crHourGlass);
//github #604:
  UploadInfo2 := FUploadInfo2;
  PropIDList := TStringList.Create;   //PAM - Ticket #1339: Create PropIDList to store all the incoming comp propid > 0
  PropIDList2 := TStringList.Create;  //PAM - Ticket #1339: Create PropIDList2 to store only the first encounter comp propid > 0 and ignore the extra
  try
    for i:=0 to pred(joImage.Count) do
    begin
      try
       if joImage.Child[i] = nil then continue;

       itjs := (joImage.Child[i] as TlkJSONobject);
      image_title := '';
      if (itjs.Field['Image_Data'] <> nil) and not (itjs.Field['Image_Data'] is TLKJSONnull) then
          imagedata   := itjs.Field['Image_Data'].Value;
       if (itjs.Field['Image_Title'] <> nil) and not (itjs.Field['Image_Title'] is TLKJSONnull) then
         image_title := itjs.getString('Image_Title');

       if (itjs.Field['Image_Type'] <> nil) and not (itjs.Field['Image_Type'] is TLKJSONnull) then
         image_type  := itjs.getString('Image_Type');

       image_id    := GetImageTypeByTitle(image_title);
       aPropID     := itjs.getString('PropID');  //0 for subject
//       if length(image) = 0 then continue;   //PAM: Ticket #1373: should check the raw imagedata string not image
       if length(imagedata) > 0 then           //PAM: Ticket #1373: if imagedata is empty skip
         begin
           image := Base64Decode(imagedata);
           Photo := TJPEGImage.Create;
           try
             LoadJPEGFromByteArray(image,Photo);
             iPropID := getValidInteger(aPropID);
             if iPropID = 0 then //aProdID = 0: Subject, 1 for comp1, 2 for comp2
               begin
    // github #604: load all the images to the photo manager
                  LoadSubjectImages(cCount, iPropID, itjs, iTop, iBot);
                  inc(cCount);
               end
               else //this is for comps
                 begin //need to know sales or listing
    //github #604:
                   PropIDList.Add(aPropID);
                   LoadCompImages(lCount, iPropID, itjs, PropIDList, PropIDList2, False);  //PAM - Ticket #1339: pass both stringlist to LoadCompImages
                   inc(lCount);
                 end;
           finally
             if assigned(Photo) then
               Photo.Free;
           end;
         end;
       except on E:Exception do
         showmessage('Error in downloading image Json: '+e.message);
       end;
    end;
  finally
    PopMouseCursor;
    StatusBar.Panels.Items[0].Text := Format('Total Subject Photos: %d',[cCount]);
    StatusBar2.Panels.Items[0].Text := Format('Total Comparable Photos: %d',[lCount]);

    //rearrange the comp panel in case comps has no image, we need to left justified to fill up gap
    for i:= 0 to PhotoDisplayComps.ComponentCount - 1 do
      begin
       if PhotoDisplayComps.Components[i] is TPanel then
         TPanel(PhotoDisplayComps.Components[i]).Align := alLeft;
      end;

    PropIDList.Free;    //PAM - Ticket #1339 - Free after used
    PropIDList2.Free;   //PAM - Ticket #1339 - Free after used
  end;
end;



function TInspectionDetail.DownLoadInspectionDataByID(InspectionData:String): Boolean;

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
  jsdata, jSubject, jpostedData, jComps: TlkJSONBase;
  inspection_data, subject_data, comps_data:String;
  jsPhotoList : TlkJSONBase;
  logMsg:String;
  i: Integer;
begin
  Application.ProcessMessages;
  result := False;
  FjInspectionObject := TlkJSON.ParseText(InspectionData) as TlkJSONobject;
  try
  jsdata :=TlkJsonObject(FjInspectionObject).Field['data']; //we are looking at the data section from the get detail
  if jsdata = nil then exit;
      FUploadInfo2.Status := vartostr(jsdata.Field['status'].Value);
      FUploadInfo2.insp_id := jsdata.Field['insp_id'].Value;
      FUploadInfo2.Address := varToStr(jsdata.Field['address'].Value);
      lblSubjectAddr.Caption := FUploadInfo2.Address;
      FUploadInfo2.City := varToStr(jsdata.Field['city'].Value);
      FUploadInfo2.State := varToStr(jsdata.Field['state'].Value);
      FUploadInfo2.Zipcode := varToStr(jsdata.Field['zipcode'].Value);
      FUploadInfo2.Insp_Type := varToStr(jsdata.Field['insp_type'].Value);
      if not (jsdata.Field['status_date'] is TlkJSONnull) then
        FUploadInfo2.StatusDateTime := SetISOtoDateTime(varToStr(jsdata.Field['status_date'].Value), True);
      if not (jsdata.Field['insp_date'] is TlkJSONnull) then
        FUploadInfo2.Insp_date := varToStr(jsdata.Field['insp_date'].Value);
      if not (jsdata.Field['insp_time'] is TlkJSONnull) then
        FUploadInfo2.Insp_time := varToStr(jsdata.Field['insp_time'].Value);
      FUploadInfo2.Revision  := jsData.Field['revision'].Value;
      jpostedData := TlkJsonObject(jsdata).Field['posted_data'];
      if jpostedData = nil then exit;
      if jpostedData.Count = 0 then
        begin
          logMsg := Format('The inspection data for inspection #: %d is EMPTY.',[FUploadInfo2.insp_id]);
          ShowNotice(logMsg);
          exit;
        end
      else
        begin
          Application.ProcessMessages;

          inspection_data := TlkJSON.GenerateText(jpostedData);
          FjPostedData := TlkJSON.ParseText(inspection_data) as TlkJSONobject;

          if pos('DataStructureVersionNumber',inspection_data) > 0 then
            FDataStructureVersionNumber := FjPostedData.Field['DataStructureVersionNumber'].Value
          else
            FDataStructureVersionNumber := JSON_Data_Structure_Version_No;

          Application.ProcessMessages;
          //load subject data
          jSubject := TlkJsonObject(FjPostedData).Field['Subject'];
          subject_data := TlkJSON.GenerateText(jSubject);
          Application.ProcessMessages;
        end;
        //load comp data
        jComps := TlkJsonObject(FjPostedData).Field['Comps'];
        comps_data := TlkJSON.GenerateText(jComps);
        DownloadImagePackagesByID(FUploadInfo2.Insp_id);  //needs to pass in insp_id
  finally
     result := True;
  end;
end;


//procedure TInspectionDetail.LoadInspectionData_SubjectData(subject_data:String; var FSubjectData:TSubjectInspectData);
procedure TInspectionDetail.LoadInspectionData_SubjectData(subject_data:String);
begin
  FjSubjectObj := TLKJSON.ParseText(subject_data) as TlkJsonObject;
  try
    if FjSubjectObj <> nil then
    begin
      if FDataStructureVersionNumber < 2 then
        begin
          if pos('VersionNumber', subject_data) > 0 then
            //  FVersionNumber := GetJsonInt('VersionNumber', FjSubjectObj);
            FDataStructureVersionNumber := GetJsonInt('VersionNumber', FjSubjectObj);
        end;
      case FDataStructureVersionNumber of
          1: LoadInspectiondata_SubjectData_V1(subject_data, FSubjectData);
        else LoadInspectiondata_SubjectData_V2(subject_data, FSubjectData2);
      end;
    end;
   except on E:Exception do
     showmessage('Error loading json for Subject: '+ e.message);
   end;
end;

procedure TInspectionDetail.LoadInspectionData_SubjectData_V1(subject_data:String; var FSubjectData:TSubjectInspectData);
var
  aDateTimeStr:String;
  aInt: Integer;
begin
    FSubjectData.AppraisalFileNumber := GetJsonString('AppraisalFileNumber', FjSubjectObj);
    FSubjectData.InspectionScheduleDate := GetJSonString('InspectionScheduleDate', FjSubjectObj);
    FSubjectData.InspectionScheduleTime := GetJSonString('InspectionScheduleTime', FjSubjectObj);

    FSubjectData.Address := GetJsonString('Address', FjSubjectObj);
    FSubjectData.City    := GetJsonString('City', FjSubjectObj);
    FSubjectData.State   := GetJsonString('State', FjSubjectObj);
    FSubjectData.ZipCode := GetJsonString('ZipCode', FjSubjectObj);
    FSubjectData.Latitude := GetJsonString('Latitude',FjSubjectObj);
    FSubjectData.Longitude := GetJsonString('Longitude',FjSubjectObj);
    FSubjectData.GLA       := GetJsonString('Gla',FjSubjectObj);

    FUploadInfo.Address := FSubjectData.Address;
    FUploadInfo.City    := FSubjectData.City;
    FUploadInfo.State   := FSubjectData.State;
    FUploadInfo.ZipCode := FSubjectData.ZipCode;

    //1004 Full/URAR, 2055 Drive By, 704 Drive By, 2065 Drive By, Field Review, Progress Inspect
    FSubjectData.insp_type           := GetJsonString('insp_Type',FjSubjectObj);
    FSubjectData.TotalRooms          := GetJsonString('TotalRooms',FjSubjectObj);
    FSubjectData.Bedrooms            := GetJsonString('Bedrooms',FjSubjectObj);
    FSubjectData.FullBaths           := GetJsonString('FullBaths', FjSubjectObj);
    FSubjectData.HalfBaths           := GetJsonString('HalfBaths', FjSubjectObj);
    FSubjectData.Design              := GetJsonString('Design', FjSubjectObj);
    FSubjectData.Stories             := GetJsonString('Stories', FjSubjectObj);
    FSubjectData.YearBuilt           := GetJsonString('YearBuilt', FjSubjectObj);
    FSubjectData.ActualAge           := GetJsonString('ActualAge', FjSubjectObj);
    FSubjectData.EffectiveAge        := GetJsonString('EffectiveAge', FjSubjectObj);
    FSubjectData.SiteArea            := getJsonString('Area', FjSubjectObj);
    FSubjectData.IsFHA               := getJSonBool('IsFha', FjSubjectObj);

    FSubjectData.SubjectType         := GetJsonInt('SubjectType', FjSubjectObj);
    FSubjectData.StructureType       := GetJsonInt('StructureType', FjSubjectObj);
    FSubjectData.ConstructionType    := GetJsonInt('ConstructionType', FjSubjectObj);
    FSubjectData.CarStorageNone      := GetJsonBool('CarStorageNone', FjSubjectObj);
    FSubjectData.Driveway            := GetJsonBool('Driveway', FjSubjectObj);
    FSubjectData.DrivewayCars        := GetJsonString('DrivewayCars', FjSubjectObj);
    FSubjectData.DrivewaySurface     := GetJsonString('DrivewaySurface', FjSubjectObj);
    FSubjectData.Garage              := GetJsonBool('Garage', FjSubjectObj);
    FSubjectData.GarageAttachedCars  := GetJsonBool('GarageAttachedCars', FjSubjectObj);
    FSubjectData.GarageDetachedCars  := GetJsonBool('GarageDetachedCars', FjSubjectObj);
    FSubjectData.GarageBuiltincars   := GetJsonBool('GarageBuiltincars', FjSubjectObj);
    FSubjectData.Carport             := GetJsonBool('Carport', FjSubjectObj);
    FSubjectData.CarportAttachedCars := GetJsonBool('CarportAttachedCars', FjSubjectObj);
    FSubjectData.CarportDetachedCars := GetJsonBool('CarportDetachedCars', FjSubjectObj);
    FSubjectData.CarportBuiltInCars  := GetJsonBool('CarportBuiltInCars', FjSubjectObj);
    FSubjectData.ConditionRating     := TranslateMobileCondition(GetJsonInt('ConditionRating', FjSubjectObj));
    aInt := GetJsonInt('ConstractionRating', FjSubjectObj);
    FSubjectData.ContractionRating   := TranslateMobileQuality(aInt);
    FSubjectData.ConditionCommentDescription  := GetJsonString('ConditionCommentDescription', FjSubjectObj);
    FSubjectData.ConditionCommentAdverse      := GetJsonString('ConditionCommentAdverse', FjSubjectObj);
    FSubjectData.ConditionCommentNeighborhood := GetJsonString('ConditionCommentNeighborhood', FjSubjectObj);
    FSubjectData.FunctionalUtility   := GetJsonString('FunctionalUtility', FjSubjectObj);
    FSubjectData.FunctionalAdjAmt    := GetJsonString('FunctionalAdjAmt', FjSubjectObj);
    FSubjectData.EnergyEff           := GetJsonString('EnergyEff', FjSubjectObj);
    FSubjectData.EnergyAdjAmt        := GetJsonString('EnergyAdjAmt', FjSubjectObj);
    FSubjectData.MiscDesc1           := GetJsonString('MiscDesc1', FjSubjectObj);
    FSubjectData.MiscAdjAmt1         := GetJsonString('MiscAdjAmt1', FjSubjectObj);
    FSubjectData.MiscDesc2           := GetJsonString('MiscDesc2', FjSubjectObj);
    FSubjectData.MiscAdjAmt2         := GetJsonString('MiscAdjAmt2', FjSubjectObj);
    FSubjectData.MiscDesc3           := GetJsonString('MiscDesc3', FjSubjectObj);
    FSubjectData.MiscAdjAmt3         := GetJsonString('MiscAdjAmt3', FjSubjectObj);
    FSubjectData.HasFireplaces       := GetJsonBool('HasFireplaces', FjSubjectObj);
    FSubjectData.Fireplaces          := GetJsonString('Fireplaces', FjSubjectObj);
    FSubjectData.HasWoodstove        := GetJsonBool('HasWoodstove', FjSubjectObj);
    FSubjectData.Woodstove           := GetJsonString('Woodstove', FjSubjectObj);
    FSubjectData.HasPatio            := GetJsonBool('HasPatio', FjSubjectObj);
    FSubjectData.Patio               := GetJsonString('Patio', FjSubjectObj);
    FSubjectData.HasPool             := GetJsonBool('HasPool', FjSubjectObj);
    FSubjectData.Pool                := GetJsonString('Pool', FjSubjectObj);
    FSubjectData.HasFence            := GetJsonBool('HasFence', FjSubjectObj);
    FSubjectData.Fence               := GetJsonString('Fence', FjSubjectObj);
    FSubjectData.HasPorch            := GetJsonBool('HasPorch', FjSubjectObj);
    FSubjectData.Porch               := GetJsonString('Porch', FjSubjectObj);
    FSubjectData.HasOtherAmenities   := GetJsonBool('HasOtherAmenities', FjSubjectObj);
    FSubjectData.OtherAmenities      := GetJsonString('OtherAmenities', FjSubjectObj);
    FSubjectData.AdditionalFeatures  := GetJsonString('AdditionalFeatures', FjSubjectObj);
    FSubjectData.HeatingType         := GetJsonInt('HeatingType', FjSubjectObj);
    FSubjectData.HeatingOther        := GetJsonString('HeatingOther', FjSubjectObj);
    FSubjectData.HeatingFuel         := GetJsonString('HeatingFuel', FjSubjectObj);
    FSubjectData.CoolingType         := GetJsonInt('CoolingType', FjSubjectObj);
    FSubjectData.CoolingOther        := GetJsonString('CoolingOther', FjSubjectObj);
    FSubjectData.OccupancyType       := GetJsonInt('OccupancyType', FjSubjectObj);
    FSubjectData.AssociationFeesAmount := GetJsonString('AssociationFeesAmount', FjSubjectObj);
    FSubjectData.AssociationFeesType   := GetJsonInt('AssociationFeesType', FjSubjectObj);
    FSubjectData.HasImprovementsWitihin15Years := GetJsonBool('HasImprovementsWitihin15Years', FjSubjectObj);
    FSubjectData.KitchenImprovementType        := GetJsonInt('KitchenImprovementType', FjSubjectObj);
    FSubjectData.BathroomImprovementType       := GetJsonInt('BathroomImprovementType', FjSubjectObj);
    FSubjectData.BathroomImprovementsYearsSinceCompletion  := TranslateKitchenYearsUpdate(GetJsonString('BathroomImprovementsYearsSinceCompletion', FjSubjectObj));
    FSubjectData.KitchenImprovementsYearsSinceCompletion   := TranslateKitchenYearsUpdate(GetJsonString('KitchenImprovementsYearsSinceCompletion', FjSubjectObj));
    FSubjectData.HomeownerInterviewNotes       := GetJsonString('HomeownerInterviewNotes', FjSubjectObj);
    FSubjectData.Dimensions                    := GetJsonString('Dimensions', FjSubjectObj);
    FSubjectData.Area                 := GetJsonString('Area', FjSubjectObj);
    FSubjectData.Shape                := GetJsonString('Shape', FjSubjectObj);
    FSubjectData.ViewFactor1          := GetJsonString('ViewFactor1', FjSubjectObj);
    FSubjectData.ViewFactor1Other     := GetJsonString('ViewFactor1Other', FjSubjectObj);
    FSubjectData.ViewFactor2          := GetJsonString('ViewFactor2', FjSubjectObj);
    FSubjectData.ViewFactor2Other     := GetJsonString('ViewFactor2Other', FjSubjectObj);
    FSubjectData.LocationFactor1      := GetJsonString('LocationFactor1', FjSubjectObj);
    FSubjectData.LocationFactor1Other := GetJsonString('LocationFactor1Other', FjSubjectObj);
    FSubjectData.LocationFactor2      := GetJsonString('LocationFactor2', FjSubjectObj);
    FSubjectData.LocationFactor2Other := GetJsonString('LocationFactor2Other', FjSubjectObj);
    FSubjectData.ViewInfluence        := GetJsonInt('ViewInfluence', FjSubjectObj);
    FSubjectData.LocationInfluence    := GetJsonInt('LocationInfluence', FjSubjectObj);
    FSubjectData.ElectricityType      := GetJsonInt('ElectricityType', FjSubjectObj);
    FSubjectData.ElectricityOther     := GetJsonString('ElectricityOther', FjSubjectObj);
    FSubjectData.GasType              := GetJsonInt('GasType', FjSubjectObj);
    FSubjectData.GasOther             := GetJsonString('GasOther', FjSubjectObj);
    FSubjectData.WaterType            := GetJsonInt('WaterType', FjSubjectObj);
    FSubjectData.WaterOther           := GetJsonString('WaterOther', FjSubjectObj);
    FSubjectData.SewerType            := GetJsonInt('SewerType', FjSubjectObj);
    FSubjectData.SewerOther           := GetJsonString('SewerOther', FjSubjectObj);
    FSubjectData.StreetType           := GetJsonInt('StreetType', FjSubjectObj);
    FSubjectData.StreetDesc           := GetJsonString('StreetDesc', FjSubjectObj);
    FSubjectData.AlleyType            := GetJsonInt('AlleyType', FjSubjectObj);
    FSubjectData.AlleyDesc            := GetJsonString('AlleyDesc', FjSubjectObj);

    FSubjectData.OffsiteImprovementsTypical       := GetJsonInt('OffsiteImprovementsTypical', FjSubjectObj);
    FSubjectData.OffsiteImprovementsDescription   := GetJsonString('OffsiteImprovementsDescription', FjSubjectObj);
    FSubjectData.HasAdverseConditions             := GetJsonInt('HasAdverseConditions', FjSubjectObj);
    FSubjectData.AdverseConditionsDescription     := GetJsonString('AdverseConditionsDescription', FjSubjectObj);
    FSubjectData.HasAttic             := GetJsonBool('HasAttic', FjSubjectObj);
    FSubjectData.DropStairs           := GetJsonBool('DropStairs', FjSubjectObj);
    FSubjectData.Stairs               := GetJsonBool('Stairs', FjSubjectObj);
    FSubjectData.Scuttle   		:= GetJsonBool('Scuttle', FjSubjectObj);
    FSubjectData.Floor   		:= GetJsonBool('Floor', FjSubjectObj);
    FSubjectData.Finished   		:= GetJsonBool('Finished', FjSubjectObj);
    FSubjectData.Heated   		:= GetJsonBool('Heated', FjSubjectObj);
    FSubjectData.NeighborhoodName     := GetJsonString('NeighborhoodName', FjSubjectObj);
    FSubjectData.LocationType   	:= GetJsonInt('LocationType', FjSubjectObj);
    FSubjectData.BuiltUpType  	:= GetJsonInt('BuiltUpType', FjSubjectObj);
    FSubjectData.GrowthType   	:= GetJsonInt('GrowthType', FjSubjectObj);
    FSubjectData.PluOneUnit   	:= GetJsonString('PluOneUnit', FjSubjectObj);
    FSubjectData.Plu24Units   	:= GetJsonString('Plu24Units', FjSubjectObj);
    FSubjectData.PluMultiFamily   	:= GetJsonString('PluMultiFamily', FjSubjectObj);
    FSubjectData.PluCommercial   	:= GetJsonString('PluCommercial', FjSubjectObj);
    FSubjectData.PluOther   		:= GetJsonString('PluOther', FjSubjectObj);
    FSubjectData.PluOtherCount   	:= GetJsonString('PluOtherCount', FjSubjectObj);
    FSubjectData.BoundaryDescription  := GetJsonString('BoundaryDescription', FjSubjectObj);
    FSubjectData.NeighborhoodDescription  := GetJsonString('NeighborhoodDescription', FjSubjectObj);
    FSubjectData.PrimaryName  	:= GetJsonString('Name', FjSubjectObj);
    FSubjectData.PrimaryHomeNo   	:= GetJsonString('HomeNumber', FjSubjectObj);
    FSubjectData.PrimaryMobileNo   	:= GetJsonString('MobileNumber', FjSubjectObj);
    FSubjectData.PrimaryWorkNo   	:= GetJsonString('WorkNumber', FjSubjectObj);
    FSubjectData.PrimaryOther   		:= GetJsonString('OtherText', FjSubjectObj);
    FSubjectData.AlternateName   		:= GetJsonString('AltName', FjSubjectObj);
    FSubjectData.AlternateHomeNo   	:= GetJsonString('AltHomeNumber', FjSubjectObj);
    FSubjectData.AlternateMobileNo   	:= GetJsonString('AltMobileNumber', FjSubjectObj);
    FSubjectData.AlternateWorkNo   	:= GetJsonString('AltWorkNumber', FjSubjectObj);
    FSubjectData.AlternateOther   	:= GetJsonString('AltOtherText', FjSubjectObj);
    FSubjectData.InspectionInstructions   	:= GetJsonString('InspectionInstructions', FjSubjectObj);
    FSubjectData.PrimaryContactType   := GetJsonInt('PrimaryContactType', FjSubjectObj);
    FSubjectData.AlternateContactType := GetJsonInt('AlternateContactType', FjSubjectObj);
    FSubjectData.ExteriorWallsMaterial:= GetJsonString('ExteriorWallsMaterial', FjSubjectObj);

    FSubjectData.ExteriorWallsCondition := GetJsonString('ExteriorWallsCondition', FjSubjectObj);
    FSubjectData.RoofSurfaceMaterial    := GetJsonString('RoofSurfaceMaterial', FjSubjectObj);
    FSubjectData.RoofSurfaceCondition   := GetJsonString('RoofSurfaceCondition', FjSubjectObj);
    FSubjectData.GuttersMaterial  	  := GetJsonString('GuttersMaterial', FjSubjectObj);
    FSubjectData.GuttersCondition  	  := GetJsonString('GuttersCondition', FjSubjectObj);
    FSubjectData.WindowTypeMaterial  	  := GetJsonString('WindowTypeMaterial', FjSubjectObj);
    FSubjectData.WindowTypeCondition 	  := GetJsonString('WindowTypeCondition', FjSubjectObj);
    FSubjectData.StormSashMaterial      := GetJsonString('StormSashMaterial', FjSubjectObj);
    FSubjectData.StormSashCondition  	  := GetJsonString('StormSashCondition', FjSubjectObj);
    FSubjectData.ScreensMaterial  	  := GetJsonString('ScreensMaterial', FjSubjectObj);
    FSubjectData.ScreensCondition  	  := GetJsonString('ScreensCondition', FjSubjectObj);

    FSubjectData.FloorsMaterial  	  := GetJsonString('FloorsMaterial', FjSubjectObj);
    FSubjectData.FloorsCondition  	  := GetJsonString('FloorsCondition', FjSubjectObj);
    FSubjectData.WallsMaterial  	  := GetJsonString('WallsMaterial', FjSubjectObj);
    FSubjectData.WallsCondition  	  := GetJsonString('WallsCondition', FjSubjectObj);
    FSubjectData.TrimMaterial  	  := GetJsonString('TrimMaterial', FjSubjectObj);
    FSubjectData.TrimCondition  	  := GetJsonString('TrimCondition', FjSubjectObj);
    FSubjectData.BathFloorsMaterial  	  := GetJsonString('BathFloorsMaterial', FjSubjectObj);
    FSubjectData.BathFloorsCondition    := GetJsonString('BathFloorsCondition', FjSubjectObj);
    FSubjectData.BathWainscotMaterial   := GetJsonString('BathWainscotMaterial', FjSubjectObj);
    FSubjectData.BathWainscotCondition  := GetJsonString('BathWainscotCondition', FjSubjectObj);

    // Foundation and basement properties
    FSubjectData.ConcreteSlab    	  := GetJsonBool('ConcreteSlab', FjSubjectObj);
    FSubjectData.CrawlSpace      	  := GetJsonBool('CrawlSpace', FjSubjectObj);
    FSubjectData.HasPumpSump     	  := GetJsonBool('HasPumpSump', FjSubjectObj);
    FSubjectData.EvidenceOfDampness     := GetJsonBool('EvidenceOfDampness', FjSubjectObj);
    FSubjectData.EvidenceOfSettlement   := GetJsonBool('EvidenceOfSettlement', FjSubjectObj);
    FSubjectData.EvidenceOfInfestation  := GetJsonBool('EvidenceOfInfestation', FjSubjectObj);

    FSubjectData.FoundationWallMaterial := GetJsonString('FoundationWallMaterial', FjSubjectObj);
    FSubjectData.FoundationWallCondition:= GetJsonString('FoundationWallCondition', FjSubjectObj);
    FSubjectData.TotalArea              := GetJsonString('TotalArea', FjSubjectObj);
    FSubjectData.FinishedArea           := GetJsonString('FinishedArea', FjSubjectObj);
    FSubjectData.FinishedPercent        := GetJsonString('FinishedPercent', FjSubjectObj);

    FSubjectData.BasementBedrooms       := GetJsonString('BasementBedrooms', FjSubjectObj);
    FSubjectData.BasementFullBaths      := GetJsonString('BasementFullBaths', FjSubjectObj);
    FSubjectData.BasementHalfBaths      := GetJsonString('BasementHalfBaths', FjSubjectObj);
    FSubjectData.BasementRecRooms       := GetJsonString('BasementRecRooms', FjSubjectObj);
    FSubjectData.BasementOtherRooms     := GetJsonString('BasementOtherRooms', FjSubjectObj);


    FSubjectData.AccessMethodWalkUp       := GetJsonBool('AccessMethodWalkUp', FjSubjectObj);
    FSubjectData.AccessMethodWalkOut      := GetJsonBool('AccessMethodWalkOut', FjSubjectObj);
    FSubjectData.AccessMethodInteriorOnly := GetJsonBool('AccessMethodInteriorOnly', FjSubjectObj);
    FSubjectData.BasementType             := GetJsonInt('BasementType', FjSubjectObj);


    //Condition/quality
    FSubjectData.ConditionRatingTypes     := GetJsonString('ConditionRatingTypes', FjSubjectObj);
    FSubjectData.ConstractionRatingTypes  := GetJsonString('ConstractionRatingTypes', FjSubjectObj);
    FSubjectData.ConditionCommentDescription  := GetJsonString('ConditionCommentDescription', FjSubjectObj);

    FSubjectData.ConditionCommentDescription  := GetJsonString('ConditionCommentDescription', FjSubjectObj);
    FSubjectData.ConditionCommentAdverse      := GetJsonString('ConditionCommentAdverse', FjSubjectObj);
    FSubjectData.ConditionCommentNeighborhood := GetJsonString('ConditionCommentNeighborhood', FjSubjectObj);
    FSubjectData.ConditionCommentDescription  := GetJsonString('ConditionCommentDescription', FjSubjectObj);

    //Garage/carport
    FSubjectData.GarageIsAttached  := GetJsonBool('GarageIsAttached', FjSubjectObj);
    FSubjectData.GarageIsDetached  := GetJsonBool('GarageIsDetached', FjSubjectObj);
    FSubjectData.GarageIsBuiltin   := GetJsonBool('GarageIsBuiltin', FjSubjectObj); { get; set; }
    FSubjectData.CarportCars       := GetJsonString('CarportCars', FjSubjectObj);
    FSubjectData.CarportIsAttached := GetJsonBool('CarportIsAttached', FjSubjectObj);
    FSubjectData.CarportIsDetached := GetJsonBool('CarportIsDetached', FjSubjectObj);
    FSubjectData.CarportIsBuiltin  := GetJsonBool('CarportIsBuiltin', FjSubjectObj);
    FSubjectData.GarageCars        := GetJsonString('GarageCars', FjSubjectObj);

    // Appliances
    FSubjectData.HasRefrigerator   := GetJsonBool('HasRefrigerator', FjSubjectObj); { get; set; }
    FSubjectData.HasRangeOwen      := GetJsonBool('HasRangeOwen', FjSubjectObj); { get; set; }
    FSubjectData.HasWasherDryer    := GetJsonBool('HasWasherDryer', FjSubjectObj); { get; set; }
    FSubjectData.HasMicrowave      := GetJsonBool('HasMicrowave', FjSubjectObj); { get; set; }
    FSubjectData.HasDishWasher     := GetJsonBool('HasDishWasher', FjSubjectObj); { get; set; }
    FSubjectData.HasDisposal       := GetJsonBool('HasDisposal', FjSubjectObj); { get; set; }
    FSubjectData.HasOtherAppliances:= GetJsonBool('HasOtherAppliances', FjSubjectObj); { get; set; }
    FSubjectData.OtherAppliances   := GetJsonString('OtherAppliances', FjSubjectObj); { get; set; }

    FSubjectData.MiscDesc1         := GetJsonString('MiscDesc1', FjSubjectObj);
    FSubjectdata.Pool              := GetJsonString('Pool', FjSubjectObj);

    ImportSubjectDataToReport;
end;

procedure TInspectionDetail.ImportSubjectDataToReport;
var
  str, aImprovement, aKitchen, aBath, aUpdate, aCondition, aUpdateNote: String;
  aView, aLocation, aDesignStyle, aStruct, aDesign, aStories, aQuality: String;
  aFinishArea, aAccess, aCellValue: String;
  rr,br,Fba,Hba,o, p:Integer;
  aLatLon: String;
  aGarageCellValue: String;
  aGarage, aCarport, aDriveway: Integer;
  aSiteArea: String;
  aDescription, aItem: String;
begin
try
  aLatLon := Format('%s;%s',[FSubjectData.Latitude, FSubjectData.Longitude]);
  if aLatLon <> '' then
    ImportGridData(0, FDoc, '9250', aLatLon, FDocCompTable);

  if not assigned(FDoc) then
    FDoc := Main.ActiveContainer;   //make sure we get the active container
  SetCellTextByCellID(2, FSubjectData.AppraisalFileNumber);

  if FSubjectData.IsFHA then
    SetCellTextByCellID(3, 'FHA #');

  case FSubjectData.SubjectType of
    tSingleUnitwAccyUnit: SetCellTextByCellID(2103, 'X');
    else if FSubjectData.SubjectType <> -1 then
      SetCellTextByCellID(2069, 'X');
  end;

  SetCellTextByCellID(46,FSubjectData.Address);
  SetCellTextByCellID(47,FSubjectData.City);
  SetCellTextByCellID(48,FSubjectData.State);
  SetCellTextByCellID(49,FSubjectData.ZipCode);
  SetCellTextByCellID(2141,FSubjectData.UnitNumber);

  aSiteArea := '';
  if getValidInteger(FSubjectData.SiteArea) > 0 then
    begin
      aSiteArea := FSubjectData.SiteArea;
      if pos('sf', aSiteArea) = 0 then
        aSiteArea := Format('%s sf',[aSiteArea])
      else
        aSiteArea := ConvertACtoSQF(aSiteArea);
    end;
  SetCellTextByCellID(67, aSiteArea);
  if assigned(FDocCompTable) then
    ImportGridData(0, FDoc, '976', aSiteArea, FDocCompTable);

  SetCellTextByCellID(1041,FSubjectData.TotalRooms);
  SetCellTextByCellID(1042,FSubjectData.Bedrooms);

  if (GetValidInteger(FSubjectData.FullBaths) > 0) or
     (GetValidInteger(FSubjectData.HalfBaths) > 0) then
    begin
      str := Format('%d.%d',[GetValidInteger(FSubjectData.FullBaths), GetValidInteger(FSubjectData.HalfBaths)]);
      SetCellTextByCellID(1043, str);
    end
  else
    SetCellTextByCellID(1043, '');

  SetCellTextByCellID(1004, FSubjectData.GLA);
  p := pos(';',FSubjectData.Design);
  if p = 1 then
    popStr(FSubjectData.Design, ';')
  else if p = length(FSubjectData.Design) then
    FSubjectData.Design := popStr(FSubjectData.Design, ';');
  SetCellTextByCellID(149, FSubjectData.Design);
  SetCellTextByCellID(148, FSubjectData.Stories);
  SetCellTextByCellID(151, FSubjectData.YearBuilt);

  SetCellTextByCellID(499,FSubjectData.EffectiveAge);
  if FSubjectData.ContractionRating > 0 then
    begin
      aQuality := Format('%d',[FSubjectData.ContractionRating]);
      if pos('Q', UpperCase(aQuality)) = 0 then
        aQuality := Format('Q%s',[aQuality]);
      SetCellTextByCellID(994, aQuality);
    end;
  //Structure Type
  case FSubjectData.StructureType of
    stAttach: begin
                SetCellTextByCellID(2101, 'X');
                aStruct := 'AT';
              end;
    stDetach: begin
                SetCellTextByCellID(157, 'X');
                aStruct := 'DT';
              end;
    stEndUnit: begin
                 SetCellTextByCellID(2102, 'X');
                 aStruct := 'SD';
               end;
  end;

  aDesign := FSubjectData.Design;

  aStories := FSubjectData.Stories;
  if (length(aStruct) > 0) or (length(aStories) > 0) then
    aDesignStyle := Format('%s%s;',[aStruct, aStories]);
  if aDesign <> '' then
    aDesignStyle := Format('%s%s',[aDesignStyle, aDesign]);
  SetCellTextByCellID(986, aDesignStyle);


  //Construction Type
  case FSubjectData.ConstructionType of
    ctExisting: SetCellTextByCellID(160, 'X');
    ctProposed: SetCellTextByCellID(159, 'X');
    ctUnderCon: SetCellTextByCellID(161, 'X');
  end;

  if FSubjectData.CarStorageNone then
    begin
      SetCellTextByCellID(346,'X');
     end 
  else
    SetCellTextByCellID(346,'');
  //Driveway
  if FSubjectData.Driveway then
    SetCellTextByCellID(359, 'X')
  else
    SetCellTextByCellID(359, '');

  SetCellTextByCellID(360, FSubjectData.DrivewayCars);
  SetCellTextByCellID(92, FSubjectData.DrivewaySurface);

  //Garage
  if GetValidInteger(FSubjectData.GarageCars) > 0 then
    SetCellTextByCellID(349, 'X');

   SetCellTextByCellID(2030, FSubjectData.GarageCars);
   if GetValidInteger(FSubjectData.GarageCars) > 0 then
     begin
       if FSubjectData.GarageIsAttached  or FSubjectData.GarageAttachedCars then
         SetCellTextByCellID(2070, 'X')

       else if FSubjectData.GarageIsDetached or FSubjectData.GarageDetachedCars then
         SetCellTextByCellID(2071, 'X')


      else if FSubjectData.GarageIsBuiltin or FSubjectData.GarageBuiltincars then
         SetCellTextByCellID(2072, 'X');
     end;

  SetCellTextByCellID(595, FSubjectData.NeighborhoodName);

  //Carport
  SetCellTextByCellID(355, FSubjectData.CarportCars);
  if GetValidInteger(FSubjectData.CarportCars) > 0 then
    begin
      SetCellTextByCellID(2657, 'X');
      if GetValidInteger(FSubjectData.GarageCars) = 0 then //only check attached/detach if no car garage
        begin
          if FSubjectData.CarportAttachedCars then
            SetCellTextByCellID(2070, 'X')
          else if FSubjectData.CarportDetachedCars then
            SetCellTextByCellID(2071, 'X');
        end;
    end
  else
    begin
      SetCellTextByCellID(2657, '');
    end;

    aGarageCellValue := '';
    aGarage := GetValidInteger(FSubjectData.GarageCars);
    if aGarage > 0 then
      begin
        if FSubjectData.GarageAttachedCars or FSubjectData.GarageIsAttached then
          SetGarageCellValue(aGarage, 'ga', aGarageCellValue)

        else if FSubjectData.GarageDetachedCars or FSubjectData.GarageIsDetached then
          SetGarageCellValue(aGarage, 'gd', aGarageCellValue)

        else if FSubjectData.GarageBuiltincars or FSubjectData.GarageIsBuiltin then
          SetGarageCellValue(aGarage, 'gbi', aGarageCellValue)
        else
          SetGarageCellValue(aGarage, 'ga', aGarageCellValue);   //default to ga if all 3 options are empty
      end;
    aCarport := GetValidInteger(FSubjectData.CarportCars);
    if aCarport > 0 then
      begin
        if (FSubjectData.CarportIsAttached or FSubjectData.CarportAttachedCars) and (aGarage = 0) then
          SetGarageCellValue(aCarport, 'cpa', aGarageCellValue)
        else if (FSubjectData.CarportIsDetached or FSubjectData.CarportDetachedCars)  and (aGarage = 0) then
          SetGarageCellValue(aCarport, 'cpd', aGarageCellValue)
        else
          SetGarageCellValue(aCarport, 'cp', aGarageCellValue);
      end;
    aDriveWay := GetValidInteger(FSubjectData.DrivewayCars);
    if aDriveWay > 0 then
      begin
        if FSubjectData.Driveway then
          SetGarageCellValue(aDriveWay, 'dw', aGarageCellValue);
      end;
    if assigned(FDocCompTable) then
      ImportGridData(0, FDoc, '1016', aGarageCellValue, FDocCompTable);


  case FSubjectData.BasementType of
   tNoBasement: begin
                  SetCellTextByCellID(2018, '');
                  SetCellTextByCellID(191, '');
                end;
   tPartialBasement: SetCellTextByCellID(2018, 'X');
   tFullBasement: SetCellTextByCellID(191, 'X');
  end;


  //Condition Rating
  if FSubjectData.ConditionRating > 0 then
    SetCellTextByCellID(998, Format('C%d',[FSubjectData.ConditionRating]))
  else
    SetCellTextByCellID(998, '');

  SetCellTextByCellID(520, FSubjectData.ConditionCommentDescription);

  SetCellTextByCellID(471, FSubjectData.AdverseConditionsDescription);
//github #891
//  SetCellTextByCellID(601, FSubjectData.ConditionCommentNeighborhood);
  SetCellTextByCellID(506, FSubjectData.ConditionCommentNeighborhood);
  SetCellTextByCellID(1010, FSubjectData.FunctionalUtility);
  SetCellTextByCellID(1014, FSubjectData.EnergyEff);
  SetCellTextByCellID(232, FSubjectData.GLA);
  SetCellTextByCellID(2036, FSubjectData.ConditionCommentAdverse);
  if FSubjectData.HasFireplaces then
    SetCellTextByCellID(321, 'X')
  else
    begin
      if trim(FDoc.GetCellTextByID(321)) <> '' then //Ticket #1416
        SetCellTextByCellID(321, ''); //skip math
    end;
  if trim(FDoc.GetCellTextByID(322)) <> '' then
   SetCellTextByCellID(322, FSubjectData.Fireplaces);

  if FSubjectData.HasWoodstove then
    SetCellTextByCellID(2027, 'X')
  else
    SetCellTextByCellID(2027, '');

  SetCellTextByCellID(2028, FSubjectData.Woodstove);

  if FSubjectData.HasPatio then
    SetCellTextByCellID(332, 'X')
  else
    SetCellTextByCellID(332, '');

  SetCellTextByCellID(333, FSubjectData.Patio);

  if FSubjectData.HasPool then
    SetCellTextByCellID(339, 'X')
  else
    begin
      if trim(FDoc.GetCellTextByID(339)) <> '' then
        SetCellTextByCellID(339, '');
    end;
    
  SetCellTextByCellID(340, FSubjectData.Pool);

  if FSubjectData.HasFence then
    SetCellTextByCellID(336, 'X')
  else
    SetCellTextByCellID(336, '');

  SetCellTextByCellID(337, FSubjectData.Fence);

  if FSubjectData.HasPorch then
    SetCellTextByCellID(334, 'X')
  else
    SetCellTextByCellID(334, '');
  SetCellTextByCellID(335, FSubjectData.Porch);

  if FSUbjectData.HasOtherAmenities then
    SetCellTextByCellID(342, 'X')
  else
    SetCellTextByCellID(342, '');
  SetCellTextByCellID(344, FSubjectData.OtherAmenities);

  SetCellTextByCellID(593, FSubjectData.AdditionalFeatures);

  case FSubjectData.HeatingType of
    tFWA: SetCellTextByCellID(2021, 'X');
    tHWBB: SetCellTextByCellID(2022, 'X');
    tRadiant: SetCellTextByCellID(2023, 'X');
  end;

  SetCellTextByCellID(288, FSubjectData.HeatingFuel);

  case FSUbjectData.CoolingType of
    tCAC: SetCellTextByCellID(2658, 'X');
    tIndividual: SetCellTextByCellID(2025, 'X');
    tCool_Other: SetCellTextByCellID(2644, 'X');
  end;
  SetCellTextByCellID(293, FSubjectData.CoolingOther);
  if (length(FSubjectData.CoolingOther) > 0) and (POS('NONE',UpperCase(FSubjectData.CoolingOther)) = 0)  then
    SetCellTextByCellID(2644, 'X');

  case FSubjectData.OccupancyType of
    tOwner: SetCellTextByCellID(51, 'X');
    tTenent: SetCellTextByCellID(52, 'X');
    tVacant: SetCellTextByCellID(53, 'X');
  end;

  SetCellTextByCellID(390, FSubjectData.AssociationFeesAmount);
  case FSubjectData.AssociationFeesType of
    tPerYear: SetCellTextByCellID(2042, 'X');
    else if FSubjectData.AssociationFeesType <> -1 then
      SetCellTextByCellID(2043, 'X'); //Default to per month
  end;

  //cell id 520 format: C1;Kitchen-update-less than one year;Bathrooms-not update;improvement note
  aCondition := '';
  if FSubjectData.ConditionRating > 0 then
    aCondition := Format('C%d',[FSubjectData.ConditionRating]);

  case FSubjectData.KitchenImprovementType of
   tNotUpdated: aUpdate := 'not updated';
   tUpdated: aUpdate    := 'updated';
   tRemodeled: aUpdate  := 'remodeled';
  end;

  if length(FSubjectData.KitchenImprovementsYearsSinceCompletion) > 0 then
    begin
      aKitchen := Format('Kitchen-%s',[aUpdate]);
      aKitchen := Format('%s-%s',[aKitchen, FSubjectData.KitchenImprovementsYearsSinceCompletion]);
    end;
  case FSubjectData.BathroomImprovementType of
   tNotUpdated: aUpdate := 'not updated';
   tUpdated: aUpdate    := 'updated';
   tRemodeled: aUpdate  := 'remodeled';
  end;
  if length(FSubjectData.BathroomImprovementsYearsSinceCompletion) > 0 then
    begin
      aBath := Format('Bathrooms-%s',[aUpdate]);
      aBath := Format('%s-%s',[aBath,FSubjectData.BathroomImprovementsYearsSinceCompletion]);
    end;
  aImprovement := '';
  if (length(aCondition) > 0) or (length(aKitchen) > 0) or (length(aBath) > 0) then
    aImprovement := Format('%s;%s;%s;%s',[aCondition,aKitchen,aBath,FSubjectData.HomeownerInterviewNotes]);
  SetCellTextByCellID(520, aImprovement);

  SetCellTextByCellID(66, FSubjectData.Dimensions);
  SetCellTextByCellID(67, FSubjectData.Area); //this is site area
  SetCellTextByCellID(88, FSubjectData.Shape);

  aView := GetViewInfluence(FSubjectData.ViewInfluence);
  aView := TranslateViewFactor(aView, FSubjectData.ViewFactor1, FSubjectData.ViewFactor2, FSubjectData.ViewFactor1Other, FSubjectData.ViewFactor2Other);
  SetCellTextByCellID(90, aView);

  aLocation := GetViewInfluence(FSubjectData.LocationInfluence);
  aLocation := TranslateViewFactor(aLocation, FSubjectData.LocationFactor1, FSubjectData.LocationFactor2, FSubjectData.LocationFactor1Other, FSubjectData.LocationFactor2Other);
  SetCellTextByCellID(962, aLocation);

  //#### START Site Section
  //Electricity
  case FSubjectData.ElectricityType of
    tPublic: SetCellTextByCellID(75, 'X');
    else if FSubjectData.ElectricityType <> -1 then
      begin
        SetCellTextByCellID(2104, 'X');
        SetCellTextByCellID(76,FSubjectData.ElectricityOther);
      end;
  end;

  //Gas...
  case FSubjectData.GasType of
    tPublic: SetCellTextByCellID(77, 'X');
    else if FSubjectData.GasType <> -1 then
      begin
        SetCellTextByCellID(2105, 'X');
        SetCellTextByCellID(78, FSubjectData.GasOther);
      end;
  end;

  //Water...
  case FSubjectData.WaterType of
    tPublic: SetCellTextByCellID(79, 'X');
    else if FSubjectData.WaterType <> -1 then
      begin
        SetCellTextByCellID(2106, 'X');
        SetCellTextByCellID(80, FSubjectData.WaterOther);
      end;
  end;

  //Sewer...
  case FSubjectData.SewerType of
    tPublic: SetCellTextByCellID(81, 'X');
    else if FSubjectData.SewerType <> -1 then
      begin
        SetCellTextByCellID(2107, 'X');
        SetCellTextByCellID(82, FSubjectData.SewerOther);
      end;
  end;

  //Street type ...
  case FSubjectData.StreetType of
    tPrivate: SetCellTextByCellID(113, 'X');
    else if FSubjectData.StreetType <> -1 then
      begin
        SetCellTextByCellID(112, 'X');
      end;
  end;
  SetCellTextByCellID(111, FSubjectData.StreetDesc);

  //Alley ...
  case FSubjectData.AlleyType of
    tPrivate: SetCellTextByCellID(135, 'X');
    else if FSubjectData.AlleyType <> -1 then
      begin
        SetCellTextByCellID(134, 'X');
      end;
  end;
  SetCellTextByCellID(133, FSubjectData.AlleyDesc);

   //offsite improvement...
  if FSubjectData.OffsiteImprovementsTypical = 1 then
    SetCellTextByCellID(472, 'X')
  else if FSubjectData.OffsiteImprovementsTypical <> -1 then
    begin
      SetCellTextByCellID(473, 'X');
      SetCellTextByCellID(474, FSubjectData.OffsiteImprovementsDescription);
    end;

   if FSubjectData.HasAdverseConditions = 1 then
     SetCellTextByCellID(469, 'X')
   else if FSubjectData.HasAdverseConditions <> -1 then
     begin
       SetCellTextByCellID(470, 'X');
       SetCellTextByCellID(471, FSubjectData.AdverseConditionsDescription);
     end;

  //#### END Site Section

  //#### START Improvement Section
  //Attic ...
  if not FSubjectData.HasAttic then
   SetCellTextByCellID(311, 'X');

  //DropStairs...
  if FSubjectData.DropStairs then
   SetCellTextByCellID(315, 'X')
  else
   SetCellTextByCellID(315, '');

  //Stairs
  if FSubjectData.Stairs then
   SetCellTextByCellID(314, 'X')
  else
   SetCellTextByCellID(314, '');

  //Scuttle
  if FSubjectData.Scuttle then
    SetCellTextByCellID(316, 'X')
  else
    SetCellTextByCellID(316, '');

   //Floor...
  if FSubjectData.Floor then
    SetCellTextByCellID(317, 'X')
  else
    SetCellTextByCellID(317, '');

   //Finished...
   if FSubjectData.Finished then
     SetCellTextByCellID(312, 'X')
   else
     SetCellTextByCellID(312, '');

   //Heated...
   if FSubjectData.Heated then
     SetCellTextByCellID(1203,'X')
   else
     SetCellTextByCellID(1203, '');

 //#### END Improvement Section

 //#### START Neighborhood Section
   //Location Type
   case FSubjectData.LocationType of
     tUrban: SetCellTextByCellID(696, 'X');
     tSuburban: SetCellTextByCellID(697, 'X');
     else if FSubjectData.LocationType <> -1 then  //default to tRutal
       SetCellTextByCellID(698, 'X');
   end;
   //BuildUP type
   case FSubjectData.BuiltUpType of
     tOver75: SetCellTextByCellID(699, 'X');
     tUnder25: SetCellTextByCellID(701, 'X');
     else if FSubjectData.BuiltUpType <> -1 then //default to 25/75
       SetCellTextByCellID(700, 'X');
   end;
   //Growth
   case FSubjectData.GrowthType of
     tStable: SetCellTextByCellID(705, 'X');
     tSlow: SetCellTextByCellID(706, 'X');
     else if FSubjectData.GrowthType <> -1 then
        SetCellTextByCellID(704, 'X');  //default to rapid
   end;
   //One unit housing;
   SetCellTextByCellID(777, FSubjectData.PluOneUnit);
   SetCellTextByCellID(778, FSubjectData.Plu24Units);
   SetCellTextByCellID(779, FSubjectData.PluMultiFamily);
   SetCellTextByCellID(781, FSubjectData.PluCommercial);
   SetCellTextByCellID(786, FSubjectData.PluOtherCount);
   SetCellTextByCellID(785, FSubjectData.PluOther);
   SetCellTextByCellID(600, FSubjectData.BoundaryDescription);
   SetCellTextByCellID(601, FSubjectData.NeighborhoodDescription);
 //#### END Neighborhood Section

 //  SetCellTextByCellID(7, FSubjectData.PrimaryName);     //github 674
 //  SetCellTextByCellID(14, FSubjectData.PrimaryHomeNo);

   //Exterior...

   //FoundationWall
   aDescription := FSubjectData.FoundationWallMaterial;
   aCondition   := FSubjectData.FoundationWallCondition;
   aItem := '';
   if (aDescription <> '') or (aCondition <> '') then
     aItem := Format('%s/%s',[aDescription,aCondition]);
   SetCellTextByCellID(173, aItem);

   //ExteriorWalls
   aDescription := FSubjectData.ExteriorWallsMaterial;
   aCondition   := FSubjectData.ExteriorWallsCondition;
   aItem := '';
   if (aDescription <> '') or (aCondition <> '') then
     aItem := Format('%s/%s',[aDescription,aCondition]);
   SetCellTextByCellID(174, aItem);

   //RoofSurface
   aDescription := FSubjectData.RoofSurfaceMaterial;
   aCondition   := FSubjectData.RoofSurfaceCondition;
   aItem := '';
   if (aDescription <> '') or (aCondition <> '') then
     aItem := Format('%s/%s',[aDescription,aCondition]);
   SetCellTextByCellID(175, aItem);

   //Gutters
   aDescription := FSubjectData.GuttersMaterial;
   aCondition   := FSubjectData.GuttersCondition;
   aItem := '';
   if (aDescription <> '') or (aCondition <> '') then
     aItem := Format('%s/%s',[aDescription,aCondition]);
   SetCellTextByCellID(176, aItem);

   //WindowType
   aDescription := FSubjectData.WindowTypeMaterial;
   aCondition   := FSubjectData.WindowTypeCondition;
   aItem := '';
   if (aDescription <> '') or (aCondition <> '') then
     aItem := Format('%s/%s',[aDescription,aCondition]);
   SetCellTextByCellID(181, aItem);

   //StormSash
   aDescription := FSubjectData.StormSashMaterial;
   aCondition   := FSubjectData.StormSashCondition;
   aItem := '';
   if (aDescription <> '') or (aCondition <> '') then
     aItem := Format('%s/%s',[aDescription,aCondition]);
   SetCellTextByCellID(184, aItem);

   //Screens
   aDescription := FSubjectData.ScreensMaterial;
   aCondition   := FSubjectData.ScreensCondition;
   aItem := '';
   if (aDescription <> '') or (aCondition <> '') then
     aItem := Format('%s/%s',[aDescription,aCondition]);
   SetCellTextByCellID(183, aItem);

   //Interior...
   //Floors
   aDescription := FSubjectData.FloorsMaterial;
   aCondition   := FSubjectData.FloorsCondition;
   aItem := '';
   if (aDescription <> '') or (aCondition <> '') then
     aItem := Format('%s/%s',[aDescription,aCondition]);
   SetCellTextByCellID(253, aItem);

   //Walls
   aDescription := FSubjectData.WallsMaterial;
   aCondition   := FSubjectData.WallsCondition;
   aItem := '';
   if (aDescription <> '') or (aCondition <> '') then
     aItem := Format('%s/%s',[aDescription,aCondition]);
   SetCellTextByCellID(260, aItem);

   //Trim
   aDescription := FSubjectData.TrimMaterial;
   aCondition   := FSubjectData.TrimCondition;
   aItem := '';
   if (aDescription <> '') or (aCondition <> '') then
     aItem := Format('%s/%s',[aDescription,aCondition]);
   SetCellTextByCellID(251, aItem);

   //BathFloors
   aDescription := FSubjectData.BathFloorsMaterial;
   aCondition   := FSubjectData.BathFloorsCondition;
   aItem := '';
   if (aDescription <> '') or (aCondition <> '') then
     aItem := Format('%s/%s',[aDescription,aCondition]);
   SetCellTextByCellID(267, aItem);

   //BathFloors
   aDescription := FSubjectData.BathWainscotMaterial;
   aCondition   := FSubjectData.BathWainscotCondition;
   aItem := '';
   if (aDescription <> '') or (aCondition <> '') then
     aItem := Format('%s/%s',[aDescription,aCondition]);
   SetCellTextByCellID(274, aItem);

   //Foundattion
   if FSubjectData.ConcreteSlab then
     SetCellTextByCellID(187, 'X')
   else
     SetCellTextByCellID(187, '');

   if FSubjectData.CrawlSpace then
     SetCellTextByCellID(189, 'X')
   else
     SetCellTextByCellID(189, '');

   if FSubjectData.HasPumpSump then
     SetCellTextByCellID(193, 'X')
   else
     SetCellTextByCellID(193, '');

  if FSubjectData.EvidenceOfDampness then SetCellTextByCellID(2019, 'X') else SetCellTextByCellID(2019, '');
  if FSubjectData.EvidenceOfSettlement then SetCellTextByCellID(2020, 'X') else SetCellTextByCellID(2020, '');
  if FSubjectData.EvidenceOfInfestation then SetCellTextByCellID(197, 'X') else SetCellTextByCellID(197, '');
//  SetCellTextByCellID(173, FSubjectData.FoundationWallMaterial);

   //Basement : set text without calling post process, don't let math process to interfere to put 'in' in the cell even there's no basement
   SetCellTextByCellID(200, FSubjectData.TotalArea, True);
   SetCellTextByCellID(201, FSubjectData.FinishedPercent, True);
   if (GetValidInteger(FSubjectData.TotalArea) > 0) then
     begin
       aFinishArea := FSubjectData.FinishedArea;
       if GetValidInteger(FSubjectData.FinishedPercent) > 0 then
         aFinishArea := CalcFinishedArea(FSubjectData.TotalArea, FSubjectData.FinishedPercent);
       if FSubjectData.AccessMethodWalkUp then
         FSubjectData.BasementAccess := 'wu'
       else if FSubjectData.AccessMethodWalkOut then
         FSubjectData.BasementAccess := 'wo'
       else if FSubjectData.AccessMethodInteriorOnly then
         FSubjectData.BasementAccess := 'in';

       if FSubjectData.AccessMethodWalkUp or FSubjectData.AccessMethodWalkOut then
         SetCellTextByCellID(208, 'X');

       if (GetValidInteger(FSubjectData.FinishedPercent) > 0) then
         begin
           aCellValue := Format('%ssf%ssf%s',[trim(FSubjectData.TotalArea), aFinishArea, FSubjectData.BasementAccess]);   //TotalAreasfFinishAreasfAccess
         end
       else if GetValidInteger(FSubjectData.FinishedArea) > 0 then
           aCellValue := Format('%ssf%ssf%s',[trim(FSubjectData.TotalArea), aFinishArea, FSubjectData.BasementAccess])   //TotalAreasfFinishAreasfAccess
       else
          aCellValue := Format('%ssf0sf%s',[trim(FSubjectData.TotalArea), FSubjectData.BasementAccess]);

       ImportGridData(0, FDoc, '1006', aCellValue, FDocCompTable);

       //cell #1008: basement rooms
       //if GetValidInteger(aFinishArea) > 0 then   //donot show basement rooms if there's no finish area
         begin
           rr  := GetValidInteger(FSubjectData.BasementRecRooms);
           br  := GetValidInteger(FSubjectData.BasementBedrooms);
           Fba := GetValidInteger(FSubjectData.BasementFullBaths);
           Hba := GetValidInteger(FSubjectData.BasementHalfBaths);
           o := GetValidInteger(FSubjectData.BasementOtherRooms);
           aCellValue := Format('%drr%dbr%d.%dba%do',[rr, br, Fba, Hba, o]);
           ImportGridData(0, FDoc, '1008', aCellValue, FDocCompTable);
         end;
     end;
      //Appliance
      if FSubjectData.HasRefrigerator then SetCellTextByCellID(299, 'X') else SetCellTextByCellID(299, '');
      if FSubjectData.HasRangeOwen then SetCellTextByCellID(300, 'X') else SetCellTextByCellID(300, '');
      if FSubjectData.HasDishWasher then SetCellTextByCellID(304, 'X') else SetCellTextByCellID(304, '');
      if FSubjectData.HasDisposal then SetCellTextByCellID(303, 'X') else SetCellTextByCellID(303, '');
      if FSubjectData.HasMicrowave then SetCellTextByCellID(307, 'X') else SetCellTextByCellID(307, '');
      if FSubjectData.HasWasherDryer then SetCellTextByCellID(308, 'X') else SetCellTextByCellID(308, '');
      if FSubjectData.HasOtherAppliances then SetCellTextByCellID(2084, 'X') else SetCellTextByCellID(2084, '');
      SetCellTextByCellID(309, FSubjectData.OtherAppliances);

      SetCellTextByCellID(1032, FSubjectData.MiscDesc3);
      SetCellTextByCellID(1022, FSubjectdata.Pool);
  except on E:Exception do
    showNotice('Error in populating Subject data to the form.' +e.message);
  end;
end;


procedure TInspectionDetail.LoadInspectionData_SubjectData_V2(subject_data:String; var FSubjectData2:TSubjectInspectData2);
var
  aDateTimeStr:String;
  aInt: Integer;
begin
    FSubjectData2.AppraisalFileNumber := GetJsonString('AppraisalFileNumber', FjSubjectObj);
    FSubjectData2.InspectionScheduleDate := GetJSonString('InspectionScheduleDate', FjSubjectObj);
    FSubjectData2.InspectionScheduleTime := GetJSonString('InspectionScheduleTime', FjSubjectObj);
    FSubjectData2.PropertyType           := GetJSonString('PropertyType', FjSubjectObj);  //github #646
    FSubjectData2.Address := GetJsonString('Address', FjSubjectObj);
    FSubjectData2.City    := GetJsonString('City', FjSubjectObj);
    FSubjectData2.State   := GetJsonString('State', FjSubjectObj);
    FSubjectData2.ZipCode := GetJsonString('ZipCode', FjSubjectObj);
    FSubjectData2.Latitude := GetJsonDouble('Latitude',FjSubjectObj);
    FSubjectData2.Longitude := GetJsonDouble('Longitude',FjSubjectObj);
    FSubjectData2.Unitnumber := GetJSonString('UnitNumber', FjSubjectObj);
    FSubjectData2.GLA       := Format('%d',[GetJsonInt('Gla',FjSubjectObj)]);  //deal with integer in the old json
    if (FSubjectData2.GLA = '') or (FSubjectData2.GLA='-1') then
      FSubjectData2.GLA := GetJsonString('Gla',FjSubjectObj); //github #632

//    FUploadInfo.Address := FSubjectData2.Address;
//    FUploadInfo.City    := FSubjectData2.City;
//    FUploadInfo.State   := FSubjectData2.State;
//    FUploadInfo.ZipCode := FSubjectData2.ZipCode;

    //1004 Full/URAR, 2055 Drive By, 704 Drive By, 2065 Drive By, Field Review, Progress Inspect
    FSubjectData2.insp_type           := GetJsonString('insp_Type',FjSubjectObj);
    FSubjectData2.TotalRooms          := GetJsonInt('TotalRooms',FjSubjectObj);
    FSubjectData2.Bedrooms            := GetJsonInt('Bedrooms',FjSubjectObj);
    FSubjectData2.FullBaths           := GetJsonInt('FullBaths', FjSubjectObj);
    FSubjectData2.HalfBaths           := GetJsonInt('HalfBaths', FjSubjectObj);
    FSubjectData2.Design              := GetJsonString('Design', FjSubjectObj);
    FSubjectData2.Stories             := GetJsonDouble('Stories', FjSubjectObj);

    FSubjectData2.YearBuilt           := GetJsonInt('YearBuilt', FjSubjectObj);
    FSubjectData2.ActualAge           := GetJsonString('ActualAge', FjSubjectObj);
    FSubjectData2.EffectiveAge        := GetJsonString('EffectiveAge', FjSubjectObj);
    FSubjectData2.SiteArea            := getJSonString('Area', FjSubjectObj);
    FSubjectData2.IsFHA               := getJSonBool('IsFha', FjSubjectObj);

    FSubjectData2.SubjectType         := GetJsonInt('SubjectType', FjSubjectObj);
    FSubjectData2.StructureType       := GetJsonInt('StructureType', FjSubjectObj);
    FSubjectData2.ConstructionType    := GetJsonInt('ConstructionType', FjSubjectObj);
    FSubjectData2.CarStorageNone      := GetJsonBool('CarStorageNone', FjSubjectObj);
    FSubjectData2.Driveway            := GetJsonBool('Driveway', FjSubjectObj);
    FSubjectData2.DrivewayCars        := GetJsonInt('DrivewayCars', FjSubjectObj);
    FSubjectData2.DrivewaySurface     := GetJsonString('DrivewaySurface', FjSubjectObj);
    FSubjectData2.Garage              := GetJsonBool('Garage', FjSubjectObj);
    FSubjectData2.GarageAttachedCars  := GetJsonBool('GarageAttachedCars', FjSubjectObj);
    FSubjectData2.GarageDetachedCars  := GetJsonBool('GarageDetachedCars', FjSubjectObj);
    FSubjectData2.GarageBuiltincars   := GetJsonBool('GarageBuiltinCars', FjSubjectObj);  //Ticket #1325: case sensitive
    FSubjectData2.Carport             := GetJsonBool('Carport', FjSubjectObj);
    FSubjectData2.CarportAttachedCars := GetJsonBool('CarportAttachedCars', FjSubjectObj);
    FSubjectData2.CarportDetachedCars := GetJsonBool('CarportDetachedCars', FjSubjectObj);
    FSubjectData2.CarportBuiltInCars  := GetJsonBool('CarportBuiltInCars', FjSubjectObj);
    FSubjectData2.ConditionRating     := TranslateMobileCondition(GetJsonInt('ConditionRating', FjSubjectObj));
    aInt := GetJsonInt('QualityRating', FjSubjectObj);
    FSubjectData2.QualityRating   := TranslateMobileQuality(aInt);
    FSubjectData2.ConditionCommentDescription  := GetJsonString('ConditionCommentDescription', FjSubjectObj);
    FSubjectData2.ConditionCommentAdverse      := GetJsonString('ConditionCommentAdverse', FjSubjectObj);
    FSubjectData2.ConditionCommentNeighborhood := GetJsonString('ConditionCommentNeighborhood', FjSubjectObj);
    FSubjectData2.FunctionalUtility   := GetJsonString('FunctionalUtility', FjSubjectObj);
    FSubjectData2.FunctionalAdjAmt    := GetJsonInt('FunctionalAdjAmt', FjSubjectObj);
    FSubjectData2.EnergyEff           := GetJsonString('EnergyEff', FjSubjectObj);
    FSubjectData2.EnergyAdjAmt        := GetJsonInt('EnergyAdjAmt', FjSubjectObj);
    FSubjectData2.MiscDesc1           := GetJsonString('MiscDesc1', FjSubjectObj);
    FSubjectData2.MiscAdjAmt1         := GetJsonInt('MiscAdjAmt1', FjSubjectObj);
    FSubjectData2.MiscDesc2           := GetJsonString('MiscDesc2', FjSubjectObj);
    FSubjectData2.MiscAdjAmt2         := GetJsonInt('MiscAdjAmt2', FjSubjectObj);
    FSubjectData2.MiscDesc3           := GetJsonString('MiscDesc3', FjSubjectObj);
    FSubjectData2.MiscAdjAmt3         := GetJsonInt('MiscAdjAmt3', FjSubjectObj);
    FSubjectData2.HasFireplaces       := GetJsonBool('HasFireplaces', FjSubjectObj);
    FSubjectData2.Fireplaces          := GetJsonInt('Fireplaces', FjSubjectObj);
    FSubjectData2.HasWoodstove        := GetJsonBool('HasWoodstove', FjSubjectObj);
    FSubjectData2.Woodstove           := GetJsonInt('Woodstove', FjSubjectObj);
    FSubjectData2.HasPatio            := GetJsonBool('HasPatio', FjSubjectObj);
    FSubjectData2.Patio               := GetJsonString('Patio', FjSubjectObj);
    FSubjectData2.HasPool             := GetJsonBool('HasPool', FjSubjectObj);
    FSubjectData2.Pool                := GetJsonString('Pool', FjSubjectObj);
    FSubjectData2.HasFence            := GetJsonBool('HasFence', FjSubjectObj);
    FSubjectData2.Fence               := GetJsonString('Fence', FjSubjectObj);
    FSubjectData2.HasPorch            := GetJsonBool('HasPorch', FjSubjectObj);
    FSubjectData2.Porch               := GetJsonString('Porch', FjSubjectObj);
    FSubjectData2.HasOtherAmenities   := GetJsonBool('HasOtherAmenities', FjSubjectObj);
    FSubjectData2.OtherAmenities      := GetJsonString('OtherAmenities', FjSubjectObj);
    FSubjectData2.AdditionalFeatures  := GetJsonString('AdditionalFeatures', FjSubjectObj);
    FSubjectData2.HeatingType         := GetJsonInt('HeatingType', FjSubjectObj);
    FSubjectData2.HeatingOther        := GetJsonString('HeatingOther', FjSubjectObj);
    FSubjectData2.HeatingFuel         := GetJsonString('HeatingFuel', FjSubjectObj);
    FSubjectData2.CoolingType         := GetJsonInt('CoolingType', FjSubjectObj);
    FSubjectData2.CoolingOther        := GetJsonString('CoolingOther', FjSubjectObj);
    FSubjectData2.OccupancyType       := GetJsonInt('OccupancyType', FjSubjectObj);
    FSubjectData2.AssociationFeesAmount := GetJsonInt('AssociationFeesAmount', FjSubjectObj);
    FSubjectData2.AssociationFeesType   := GetJsonInt('AssociationFeesType', FjSubjectObj);
    FSubjectData2.HasImprovementsWitihin15Years := GetJsonBool('HasImprovementsWitihin15Years', FjSubjectObj);
    FSubjectData2.KitchenImprovementType        := GetJsonInt('KitchenImprovementType', FjSubjectObj);
    FSubjectData2.BathroomImprovementType       := GetJsonInt('BathroomImprovementType', FjSubjectObj);
    FSubjectData2.BathroomImprovementsYearsSinceCompletion  := TranslateKitchenYearsUpdate(GetJsonString('BathroomImprovementsYearsSinceCompletion', FjSubjectObj));
    FSubjectData2.KitchenImprovementsYearsSinceCompletion   := TranslateKitchenYearsUpdate(GetJsonString('KitchenImprovementsYearsSinceCompletion', FjSubjectObj));
    FSubjectData2.HomeownerInterviewNotes       := GetJsonString('HomeownerInterviewNotes', FjSubjectObj);
    FSubjectData2.Dimensions                    := GetJsonString('Dimensions', FjSubjectObj);
    FSubjectData2.Area                 := GetJsonString('Area', FjSubjectObj);
    FSubjectData2.Shape                := GetJsonString('Shape', FjSubjectObj);
    FSubjectData2.ViewFactor1          := GetJsonString('ViewFactor1', FjSubjectObj);
    FSubjectData2.ViewFactor1Other     := GetJsonString('ViewFactor1Other', FjSubjectObj);
    FSubjectData2.ViewFactor2          := GetJsonString('ViewFactor2', FjSubjectObj);
    FSubjectData2.ViewFactor2Other     := GetJsonString('ViewFactor2Other', FjSubjectObj);
    FSubjectData2.LocationFactor1      := GetJsonString('LocationFactor1', FjSubjectObj);
    FSubjectData2.LocationFactor1Other := GetJsonString('LocationFactor1Other', FjSubjectObj);
    FSubjectData2.LocationFactor2      := GetJsonString('LocationFactor2', FjSubjectObj);
    FSubjectData2.LocationFactor2Other := GetJsonString('LocationFactor2Other', FjSubjectObj);
    FSubjectData2.ViewInfluence        := GetJsonInt('ViewInfluence', FjSubjectObj);
    FSubjectData2.LocationInfluence    := GetJsonInt('LocationInfluence', FjSubjectObj);
    FSubjectData2.ElectricityType      := GetJsonInt('ElectricityType', FjSubjectObj);
    FSubjectData2.ElectricityOther     := GetJsonString('ElectricityOther', FjSubjectObj);
    FSubjectData2.GasType              := GetJsonInt('GasType', FjSubjectObj);
    FSubjectData2.GasOther             := GetJsonString('GasOther', FjSubjectObj);
    FSubjectData2.WaterType            := GetJsonInt('WaterType', FjSubjectObj);
    FSubjectData2.WaterOther           := GetJsonString('WaterOther', FjSubjectObj);
    FSubjectData2.SewerType            := GetJsonInt('SewerType', FjSubjectObj);
    FSubjectData2.SewerOther           := GetJsonString('SewerOther', FjSubjectObj);
    FSubjectData2.StreetType           := GetJsonInt('StreetType', FjSubjectObj);
    FSubjectData2.StreetDesc           := GetJsonString('StreetDesc', FjSubjectObj);
    FSubjectData2.AlleyType            := GetJsonInt('AlleyType', FjSubjectObj);
    FSubjectData2.AlleyDesc            := GetJsonString('AlleyDesc', FjSubjectObj);

    FSubjectData2.OffsiteImprovementsTypical       := GetJsonInt('OffsiteImprovementsTypical', FjSubjectObj);
    FSubjectData2.OffsiteImprovementsDescription   := GetJsonString('OffsiteImprovementsDescription', FjSubjectObj);
    FSubjectData2.HasAdverseConditions             := GetJsonInt('HasAdverseConditions', FjSubjectObj);
    FSubjectData2.AdverseConditionsDescription     := GetJsonString('AdverseConditionsDescription', FjSubjectObj);
    FSubjectData2.HasAttic             := GetJsonBool('HasAttic', FjSubjectObj);
    FSubjectData2.DropStairs           := GetJsonBool('DropStairs', FjSubjectObj);
    FSubjectData2.Stairs               := GetJsonBool('Stairs', FjSubjectObj);
    FSubjectData2.Scuttle   		:= GetJsonBool('Scuttle', FjSubjectObj);
    FSubjectData2.Floor   		:= GetJsonBool('Floor', FjSubjectObj);
    FSubjectData2.Finished   		:= GetJsonBool('Finished', FjSubjectObj);
    FSubjectData2.Heated   		:= GetJsonBool('Heated', FjSubjectObj);
    FSubjectData2.NeighborhoodName     := GetJsonString('NeighborhoodName', FjSubjectObj);
    FSubjectData2.LocationType   	:= GetJsonInt('LocationType', FjSubjectObj);
    FSubjectData2.BuiltUpType  	:= GetJsonInt('BuiltUpType', FjSubjectObj);
    FSubjectData2.GrowthType   	:= GetJsonInt('GrowthType', FjSubjectObj);
    FSubjectData2.PluOneUnit   	:= GetJsonInt('PluOneUnit', FjSubjectObj);
    FSubjectData2.Plu24Units   	:= GetJsonInt('Plu24Units', FjSubjectObj);
    FSubjectData2.PluMultiFamily   	:= GetJsonInt('PluMultiFamily', FjSubjectObj);
    FSubjectData2.PluCommercial   	:= GetJsonInt('PluCommercial', FjSubjectObj);
    FSubjectData2.PluOther   		:= GetJsonString('PluOther', FjSubjectObj);
    FSubjectData2.PluOtherCount   	:= GetJsonInt('PluOtherCount', FjSubjectObj);
    FSubjectData2.BoundaryDescription  := GetJsonString('BoundaryDescription', FjSubjectObj);
    FSubjectData2.NeighborhoodDescription  := GetJsonString('NeighborhoodDescription', FjSubjectObj);
    FSubjectData2.PrimaryName  	:= GetJsonString('Name', FjSubjectObj);
    FSubjectData2.PrimaryHomeNo   	:= GetJsonString('HomeNumber', FjSubjectObj);
    FSubjectData2.PrimaryMobileNo   	:= GetJsonString('MobileNumber', FjSubjectObj);
    FSubjectData2.PrimaryWorkNo   	:= GetJsonString('WorkNumber', FjSubjectObj);
    FSubjectData2.PrimaryOther          := GetJsonString('OtherText', FjSubjectObj);
    FSubjectData2.AlternateName       	:= GetJsonString('AltName', FjSubjectObj);
    FSubjectData2.AlternateHomeNo   	:= GetJsonString('AltHomeNumber', FjSubjectObj);
    FSubjectData2.AlternateMobileNo   	:= GetJsonString('AltMobileNumber', FjSubjectObj);
    FSubjectData2.AlternateWorkNo   	:= GetJsonString('AltWorkNumber', FjSubjectObj);
    FSubjectData2.AlternateOther   	:= GetJsonString('AltOtherText', FjSubjectObj);
    FSubjectData2.InspectionInstructions   	:= GetJsonString('InspectionInstructions', FjSubjectObj);
    FSubjectData2.PrimaryContactType   := GetJsonInt('PrimaryContactType', FjSubjectObj);
    FSubjectData2.AlternateContactType := GetJsonInt('AlternateContactType', FjSubjectObj);
    FSubjectData2.ExteriorWallsMaterial:= GetJsonString('ExteriorWallsMaterial', FjSubjectObj);

    FSubjectData2.ExteriorWallsCondition := GetJsonString('ExteriorWallsCondition', FjSubjectObj);
    FSubjectData2.RoofSurfaceMaterial    := GetJsonString('RoofSurfaceMaterial', FjSubjectObj);
    FSubjectData2.RoofSurfaceCondition   := GetJsonString('RoofSurfaceCondition', FjSubjectObj);
    FSubjectData2.GuttersMaterial  	  := GetJsonString('GuttersMaterial', FjSubjectObj);
    FSubjectData2.GuttersCondition  	  := GetJsonString('GuttersCondition', FjSubjectObj);
    FSubjectData2.WindowTypeMaterial  	  := GetJsonString('WindowTypeMaterial', FjSubjectObj);
    FSubjectData2.WindowTypeCondition 	  := GetJsonString('WindowTypeCondition', FjSubjectObj);
    FSubjectData2.StormSashMaterial      := GetJsonString('StormSashMaterial', FjSubjectObj);
    FSubjectData2.StormSashCondition  	  := GetJsonString('StormSashCondition', FjSubjectObj);
    FSubjectData2.ScreensMaterial  	  := GetJsonString('ScreensMaterial', FjSubjectObj);
    FSubjectData2.ScreensCondition  	  := GetJsonString('ScreensCondition', FjSubjectObj);

    FSubjectData2.FloorsMaterial  	  := GetJsonString('FloorsMaterial', FjSubjectObj);
    FSubjectData2.FloorsCondition  	  := GetJsonString('FloorsCondition', FjSubjectObj);
    FSubjectData2.WallsMaterial  	  := GetJsonString('WallsMaterial', FjSubjectObj);
    FSubjectData2.WallsCondition  	  := GetJsonString('WallsCondition', FjSubjectObj);
    FSubjectData2.TrimMaterial  	  := GetJsonString('TrimMaterial', FjSubjectObj);
    FSubjectData2.TrimCondition  	  := GetJsonString('TrimCondition', FjSubjectObj);
    FSubjectData2.BathFloorsMaterial  	  := GetJsonString('BathFloorsMaterial', FjSubjectObj);
    FSubjectData2.BathFloorsCondition    := GetJsonString('BathFloorsCondition', FjSubjectObj);
    FSubjectData2.BathWainscotMaterial   := GetJsonString('BathWainscotMaterial', FjSubjectObj);
    FSubjectData2.BathWainscotCondition  := GetJsonString('BathWainscotCondition', FjSubjectObj);

    // Foundation and basement properties
    FSubjectData2.ConcreteSlab    	  := GetJsonBool('ConcreteSlab', FjSubjectObj);
    FSubjectData2.CrawlSpace      	  := GetJsonBool('CrawlSpace', FjSubjectObj);
    FSubjectData2.HasPumpSump     	  := GetJsonBool('HasPumpSump', FjSubjectObj);
    FSubjectData2.EvidenceOfDampness     := GetJsonBool('EvidenceOfDampness', FjSubjectObj);
    FSubjectData2.EvidenceOfSettlement   := GetJsonBool('EvidenceOfSettlement', FjSubjectObj);
    FSubjectData2.EvidenceOfInfestation  := GetJsonBool('EvidenceOfInfestation', FjSubjectObj);

    FSubjectData2.FoundationWallMaterial := GetJsonString('FoundationWallMaterial', FjSubjectObj);
    FSubjectData2.FoundationWallCondition:= GetJsonString('FoundationWallCondition', FjSubjectObj);
    aInt := GetJsonInt('TotalArea', FjSubjectObj);
    if aInt > 0 then
      FSubjectData2.TotalArea := Format('%d',[aInt]);
    FSubjectData2.TotalArea              := GetJsonString('TotalArea', FjSubjectObj);
    FSubjectData2.FinishedArea           := GetJsonInt('FinishedArea', FjSubjectObj);
    FSubjectData2.FinishedPercent        := GetJsonInt('FinishedPercent', FjSubjectObj);
    if (FSubjectData2.FinishedPercent = -1) and (FSubjectData2.FinishedArea > 0) and (aInt > 0) then //Ticket #1334: we have finished area but no % need to calculate
      FSubjectData2.FinishedPercent := Round((FSubjectData2.FinishedArea/aInt) *100);

    FSubjectData2.BasementBedrooms       := GetJsonInt('BasementBedrooms', FjSubjectObj);
    FSubjectData2.BasementFullBaths      := GetJsonInt('BasementFullBaths', FjSubjectObj);
    FSubjectData2.BasementHalfBaths      := GetJsonInt('BasementHalfBaths', FjSubjectObj);
    FSubjectData2.BasementRecRooms       := GetJsonInt('BasementRecRooms', FjSubjectObj);
    FSubjectData2.BasementOtherRooms     := GetJsonInt('BasementOtherRooms', FjSubjectObj);


    FSubjectData2.AccessMethodWalkUp       := GetJsonBool('AccessMethodWalkUp', FjSubjectObj);
    FSubjectData2.AccessMethodWalkOut      := GetJsonBool('AccessMethodWalkOut', FjSubjectObj);
    FSubjectData2.AccessMethodInteriorOnly := GetJsonBool('AccessMethodInteriorOnly', FjSubjectObj);
    FSubjectData2.BasementType             := GetJsonInt('BasementType', FjSubjectObj);


    //Condition/quality
    FSubjectData2.ConditionRatingTypes     := GetJsonString('ConditionRatingTypes', FjSubjectObj);
    FSubjectData2.ConstractionRatingTypes  := GetJsonString('ConstractionRatingTypes', FjSubjectObj);
    FSubjectData2.ConditionCommentAdverse      := GetJsonString('ConditionCommentAdverse', FjSubjectObj);
    FSubjectData2.ConditionCommentNeighborhood := GetJsonString('ConditionCommentNeighborhood', FjSubjectObj);
    FSubjectData2.ConditionCommentDescription  := GetJsonString('ConditionCommentDescription', FjSubjectObj);

    //Garage/carport
//    FSubjectData2.GarageIsAttached  := GetJsonBool('GarageIsAttached', FjSubjectObj);
//    FSubjectData2.GarageIsDetached  := GetJsonBool('GarageIsDetached', FjSubjectObj);
//    FSubjectData2.GarageIsBuiltin   := GetJsonBool('GarageIsBuiltin', FjSubjectObj); { get; set; }
    FSubjectData2.GarageAttachedCars  := GetJsonBool('GarageAttachedCars',FjSubjectObj); //Ticket #1325, use GarageAttachedCars instead
    FSubjectData2.GarageDetachedCars  := GetJsonBool('GarageDetachedCars', FjSubjectObj);
    FSubjectData2.GarageBuiltincars   := GetJsonBool('GarageBuiltinCars', FjSubjectObj); //Ticket #1325: case sensitive
    FSubjectData2.CarportCars       := GetJsonInt('CarportCars', FjSubjectObj);
//    FSubjectData2.CarportIsAttached := GetJsonBool('CarportIsAttached', FjSubjectObj);
//    FSubjectData2.CarportIsDetached := GetJsonBool('CarportIsDetached', FjSubjectObj);
//    FSubjectData2.CarportIsBuiltin  := GetJsonBool('CarportIsBuiltin', FjSubjectObj);
    FSubjectData2.CarportAttachedCars := GetJsonBool('CarportAttachedCars', FjSubjectObj);
    FSubjectData2.CarportDetachedCars := GetJsonBool('CarportDetachedCars', FjSubjectObj);
    FSubjectData2.CarportBuiltInCars  := GetJsonBool('CarportBuiltInCars', FjSubjectObj);
    FSubjectData2.GarageCars        := GetJsonInt('GarageCars', FjSubjectObj);

    // Appliances
    FSubjectData2.HasRefrigerator   := GetJsonBool('HasRefrigerator', FjSubjectObj); { get; set; }
    FSubjectData2.HasRangeOwen      := GetJsonBool('HasRangeOwen', FjSubjectObj); { get; set; }
    FSubjectData2.HasWasherDryer    := GetJsonBool('HasWasherDryer', FjSubjectObj); { get; set; }
    FSubjectData2.HasMicrowave      := GetJsonBool('HasMicrowave', FjSubjectObj); { get; set; }
    FSubjectData2.HasDishWasher     := GetJsonBool('HasDishWasher', FjSubjectObj); { get; set; }
    FSubjectData2.HasDisposal       := GetJsonBool('HasDisposal', FjSubjectObj); { get; set; }
    FSubjectData2.HasOtherAppliances:= GetJsonBool('HasOtherAppliances', FjSubjectObj); { get; set; }
    FSubjectData2.OtherAppliances   := GetJsonString('OtherAppliances', FjSubjectObj); { get; set; }

    FSubjectData2.MiscDesc1         := GetJsonString('MiscDesc1', FjSubjectObj);
    FSubjectData2.Pool              := GetJsonString('Pool', FjSubjectObj);

    FSubjectData2.AdverseSiteConditionPresent := GetJsonBoolInt('AdverseSiteConditionPresent', FjSubjectObj); //Ticket #1538 new tag

    FSubjectData2.PropertyConformsToNeighborhood := GetJsonBoolInt('PropertyConformsToNeighborhood', FjSubjectObj); //Ticket #1538 new tag
//  ImportSubjectDataToReport2;
end;


function GetDescrNCond(aDescription, aCondition:String):String;
begin
  result := '';
  if (aDescription <> '') then
    result := aDescription;
  if aCondition <> '' then
    begin
      if result <> '' then
        result := result +'/'+ aCondition
      else
        result := aCondition;
    end;
end;



procedure TInspectionDetail.ImportSubjectDataToReport2;
var
  str, aImprovement, aKitchen, aBath, aUpdate, aCondition, aUpdateNote: String;
  aView, aLocation, aDesignStyle, aStruct, aDesign,{ aStories,} aQuality: String;
  iFinishArea: Integer;
  aAccess, aCellValue: String;
  rr,br,Fba,Hba,o, p:Integer;
  aLatLon: String;
  aSiteArea: String;
  aDescription, aItem: String;
  aInt: Integer;
  aCellValue520:String;
  aStr: String;
  aStories, aDouble: Double;
  aTemp: String;
  aCell:TBaseCell;
begin
try
  //github #663: Load the cell value of these 3 fields to use at the end
  //github #816: check not 0 instead of >0
  if (FSubjectData2.Latitude <> 0) and (FSubjectData2.Longitude <> 0) then
    aLatLon := FloatToStrDef(FSubjectData2.Latitude)+';'+FloatToStrDef(FSubjectData2.Longitude)
  else
    aLatLon := '';
  if aLatLon <> '' then //github #816
    ImportGridData(0, FDoc, '9250', aLatLon, FDocCompTable);

  if not assigned(FDoc) then
    FDoc := Main.ActiveContainer;   //make sure we get the active container
  SetCellTextByCellID(2, FSubjectData2.AppraisalFileNumber);

  if FSubjectData2.IsFHA then
    SetCellTextByCellID(3, 'FHA #');

  case FSubjectData2.SubjectType of
    tSingleUnitwAccyUnit: SetCellTextByCellID(2103, 'X');
    else if FSubjectData2.SubjectType <> -1 then
      SetCellTextByCellID(2069, 'X');
  end;


  SetCellTextByCellID(46,FSubjectData2.Address);
  SetCellTextByCellID(47,FSubjectData2.City);
  SetCellTextByCellID(48,FSubjectData2.State);
  SetCellTextByCellID(49,FSubjectData2.ZipCode);
  SetCellTextByCellID(2141,FSubjectData2.UnitNumber);

  aSiteArea := '';
  if GetValidInteger(FSubjectData2.SiteArea) > 0 then
    begin
      aSiteArea := FSubjectData2.SiteArea;
      if pos('ac', aSiteArea) > 0 then
        SetCellTextByCellID(67, aSiteArea)
      else
        begin
          if pos('sf', aSiteArea) = 0 then
            aSiteArea := Format('%s sf',[aSiteArea]);
          aInt := GetValidInteger(aSiteArea);      //github #183: add ,
          aSiteArea := FormatFloat('#,###', aInt);
          SetCellTextByCellID(67, aSiteArea);
        end;
    end;
  if assigned(FDocCompTable) then
    ImportGridData(0, FDoc, '976', aSiteArea, FDocCompTable);
  if FSubjectData2.TotalRooms <> -1 then
    SetCellTextByCellID(1041,Format('%d',[FSubjectData2.TotalRooms]));
  if FSubjectData2.Bedrooms <> -1 then
    SetCellTextByCellID(1042,Format('%d',[FSubjectData2.Bedrooms]));

  if FSubjectData2.HalfBaths < 0 then
    FSubjectData2.HalfBaths := 0;
  if (FSubjectData2.FullBaths > 0) or (FSubjectData2.HalfBaths > 0) then
    begin
      str := Format('%d.%d',[FSubjectData2.FullBaths, FSubjectData2.HalfBaths]);
      SetCellTextByCellID(1043, str);
    end
  else
    SetCellTextByCellID(1043, '');

  SetCellTextByCellID(1004, FSubjectData2.GLA);  //github #632
  p := pos(';',FSubjectData2.Design);
  if p = 1 then
    popStr(FSubjectData2.Design, ';')
  else if p = length(FSubjectData2.Design) then
    FSubjectData2.Design := popStr(FSubjectData2.Design, ';');

  if FOverwriteData then
    begin
      aCell := FDoc.GetCellByID(149);
      if assigned(aCell) then
        begin
          aCell.Modified := True;
        end;
    end;


  SetCellTextByCellID(149, FSubjectData2.Design);
  if FSubjectData2.Stories > 0 then
    begin
      aStr := FloatToStrDef(FSubjectData2.Stories); //github #44
      SetCellTextByCellID(148, aStr);
    end;
  aInt := FSubjectData2.YearBuilt;
  if aInt > 0 then
    SetCellTextByCellID(151, Format('%d',[aInt]));

  SetCellTextByCellID(499, FSubjectData2.EffectiveAge);
  if FSubjectData2.QualityRating <> -1 then
    begin
      aQuality := Format('%d',[FSubjectData2.QualityRating]);
      if pos('Q', UpperCase(aQuality)) = 0 then
        aQuality := Format('Q%s',[aQuality]);
      SetCellTextByCellID(994, aQuality);
    end;
  //Structure Type
  case FSubjectData2.StructureType of
    stAttach: begin
                SetCellTextByCellID(2101, 'X');
                aStruct := 'AT';
              end;
    stDetach: begin
                SetCellTextByCellID(157, 'X');
                aStruct := 'DT';
              end;
    stEndUnit: begin
                 SetCellTextByCellID(2102, 'X');
                 aStruct := 'SD';
               end;
  end;

  aDesign := FSubjectData2.Design;

  if (length(aStruct) > 0) and (FSubjectData2.Stories >0) then
    begin
      aStr := FloatToStrDef(FSubjectData2.Stories);
      aDesignStyle := Format('%s%s;',[aStruct, aStr])
    end
  else if length(aStruct) > 0 then
    aDesignStyle := aStruct;

  if aDesign <> '' then
    aDesignStyle := Format('%s%s',[aDesignStyle, aDesign]);
  SetCellTextByCellID(986, aDesignStyle);


  //Construction Type
  case FSubjectData2.ConstructionType of
    ctExisting: SetCellTextByCellID(160, 'X');
    ctProposed: SetCellTextByCellID(159, 'X');
    ctUnderCon: SetCellTextByCellID(161, 'X');
  end;

  if FSubjectData2.CarStorageNone then
    SetCellTextByCellID(346,'X')
  else
    SetCellTextByCellID(346,'');

  SetCellTextByCellID(595, FSubjectData2.NeighborhoodName);

  //Condition Rating
  if FSubjectData2.ConditionRating > 0 then
    SetCellTextByCellID(998, Format('C%d',[FSubjectData2.ConditionRating]))
  else
    SetCellTextByCellID(998, '');
  SetCellTextByCellID(471, FSubjectData2.AdverseConditionsDescription);
  SetCellTextByCellID(506, FSubjectData2.ConditionCommentNeighborhood);
  SetCellTextByCellID(1010, FSubjectData2.FunctionalUtility);
  SetCellTextByCellID(1014, FSubjectData2.EnergyEff);
  SetCellTextByCellID(2036, FSubjectData2.ConditionCommentAdverse);
  if FSubjectData2.HasFireplaces then
    SetCellTextByCellID(321, 'X')
  else
    begin
      if FDoc.GetCellTextbyID(321) <> '' then
        SetCellTextByCellID(321, '');
    end;
  if FSubjectData2.Fireplaces > 0 then
    SetCellTextByCellID(322, Format('%d',[FSubjectData2.Fireplaces]));

  if FSubjectData2.HasWoodstove then
    SetCellTextByCellID(2027, 'X')
  else
    SetCellTextByCellID(2027, '');

  if FSubjectData2.WoodStove > 0 then
    SetCellTextByCellID(2028, Format('%d',[FSubjectData2.WoodStove]));

  if FSubjectData2.HasPatio then
    SetCellTextByCellID(332, 'X')
  else
    SetCellTextByCellID(332, '');

  SetCellTextByCellID(333, FSubjectData2.Patio);

  if FSubjectData2.HasPool then
    SetCellTextByCellID(339, 'X')
  else
    begin
      if trim(FDoc.GetCellTextByID(339)) <> ''  then
        SetCellTextByCellID(339, '');
    end;
  if trim(FSubjectData2.Pool) <> '' then
    SetCellTextByCellID(340, FSubjectData2.Pool);

  if FSubjectData2.HasFence then
    SetCellTextByCellID(336, 'X')
  else
    SetCellTextByCellID(336, '');

  SetCellTextByCellID(337, FSubjectData2.Fence);

  if FSubjectData2.HasPorch then
    SetCellTextByCellID(334, 'X')
  else
    SetCellTextByCellID(334, '');
  SetCellTextByCellID(335, FSubjectData2.Porch);

  if FSubjectData2.HasOtherAmenities then
    SetCellTextByCellID(342, 'X')
  else
    SetCellTextByCellID(342, '');
  SetCellTextByCellID(344, FSubjectData2.OtherAmenities);

  SetCellTextByCellID(593, FSubjectData2.AdditionalFeatures);

  case FSubjectData2.HeatingType of
    tFWA: SetCellTextByCellID(2021, 'X');
    tHWBB: SetCellTextByCellID(2022, 'X');
    tRadiant: SetCellTextByCellID(2023, 'X');
    tHeat_Other:SetCellTextByCellID(2024, 'X');   //we need to include heatingOther if heating type is 3 for other
  end;
  SetCellTextByCellID(2026, FSubjectData2.HeatingOther);


  SetCellTextByCellID(288, FSubjectData2.HeatingFuel);

  case FSubjectData2.CoolingType of
    tCAC: SetCellTextByCellID(2658, 'X');
    tIndividual: SetCellTextByCellID(2025, 'X');
    tCool_Other: SetCellTextByCellID(2644, 'X');
  end;
  SetCellTextByCellID(293, FSubjectData2.CoolingOther);
  if (length(FSubjectData2.CoolingOther) > 0) and (POS('NONE',UpperCase(FSubjectData2.CoolingOther)) = 0)  then
    SetCellTextByCellID(2644, 'X');

  case FSubjectData2.OccupancyType of
    tOwner: SetCellTextByCellID(51, 'X');
    tTenent: SetCellTextByCellID(52, 'X');
    tVacant: SetCellTextByCellID(53, 'X');
  end;
  if FSubjectData2.AssociationFeesAmount <> -1 then
    SetCellTextByCellID(390, Format('%d',[FSubjectData2.AssociationFeesAmount]));
  case FSubjectData2.AssociationFeesType of
    tPerYear: SetCellTextByCellID(2042, 'X');
    else if FSubjectData2.AssociationFeesType <> -1 then
      SetCellTextByCellID(2043, 'X'); //Default to per month
  end;
    if FSubjectData2.HasImprovementsWitihin15Years then
    begin
      aCondition := '';
      if FSubjectData2.ConditionRating > 0 then
        aCondition := Format('C%d',[FSubjectData2.ConditionRating]);

      case FSubjectData2.KitchenImprovementType of
       tNotUpdated: aUpdate := 'not updated';
       tUpdated: aUpdate    := 'updated';
       tRemodeled: aUpdate  := 'remodeled';
      end;

      if aUpdate <> '' then
        aKitchen := Format('Kitchen-%s',[aUpdate]);
      if length(FSubjectData2.KitchenImprovementsYearsSinceCompletion) > 0 then
        begin
          aKitchen := Format('Kitchen-%s',[aUpdate]);
          aKitchen := Format('%s-%s',[aKitchen, FSubjectData2.KitchenImprovementsYearsSinceCompletion]);
        end;
      case FSubjectData2.BathroomImprovementType of
       tNotUpdated: aUpdate := 'not updated';
       tUpdated: aUpdate    := 'updated';
       tRemodeled: aUpdate  := 'remodeled';
      end;
      if aUpdate <> '' then
        aBath := Format('Bathrooms-%s',[aUpdate]);

      if length(FSubjectData2.BathroomImprovementsYearsSinceCompletion) > 0 then
        begin
          aBath := Format('Bathrooms-%s',[aUpdate]);
          aBath := Format('%s-%s',[aBath,FSubjectData2.BathroomImprovementsYearsSinceCompletion]);
        end;
      aImprovement := '';
      if (length(aCondition) > 0) or (length(aKitchen) > 0) or (length(aBath) > 0) then
        begin
          aImprovement := Format('%s;%s;%s',[aCondition,aKitchen,aBath]);
        end;
      if FSubjectData2.ConditionCommentDescription <> '' then //Ticket #1251: need to include ConditionCommentDescription
        begin
          aStr := FSubjectData2.ConditionCommentDescription;  //this might have the combination of ther field values in it
          aInt := 0;  //set the counter
          while pos(';', aStr) > 0 do  //if we see ; the separator,
            begin
              inc(aInt);  //keep counting, we should only care for 2 ;
              //if aInt > 2 then //more than 2:
              //Here's the format: condition;kitchen-update;bathroom-update;this is comment
              if aInt > 3 then //we can only see 3 ; separators, if there's more means ; is belong to the comment
                break;
              popStr(aStr, ';'); //pop it out, until no more ;
            end;
          if aStr <> '' then //we have the comment
            aImprovement := Format('%s; %s',[aImprovement, aStr]);
        end;
      SetCellTextByCellID(520, aImprovement);
    end;

  aCellValue520 := '';  //github #747
  if not FSubjectData2.HasImprovementsWitihin15Years then
    begin
      aCondition := '';
      if FSubjectData2.ConditionRating > 0 then
        begin
          aCondition := Format('C%d',[FSubjectData2.ConditionRating]);
          aCellValue520 := Format('%s;%s',[aCondition,
                                 'No updates in the prior 15 years']);
        end;
      if FSubjectData2.ConditionCommentDescription <> '' then //Ticket #1251: need to include ConditionCommentDescription
        begin
          aStr := FSubjectData2.ConditionCommentDescription;  //this might have the combination of ther field values in it
          aInt := 0;  //set the counter
          while pos(';', aStr) > 0 do  //if we see ; the separator,
            begin
              inc(aInt);  //keep counting, we should only care about 2 ;
              //if aInt > 2 then break;
              if aInt > 3 then break;  //more than 3 not 2 ;
              popStr(aStr, ';'); //pop it out, until no more ;
            end;
          if aStr <> '' then //we have the comment
            aCellValue520 := Format('%s; %s',[aCellValue520, aStr]);
        end;

      SetCellTextByCellID(520,aCellValue520 );
    end;

  SetCellTextByCellID(66, FSubjectData2.Dimensions);
  SetCellTextByCellID(67, FSubjectData2.Area); //this is site area
  SetCellTextByCellID(88, FSubjectData2.Shape);

  aView := GetViewInfluence(FSubjectData2.ViewInfluence);
  aView := TranslateViewFactor(aView, FSubjectData2.ViewFactor1, FSubjectData2.ViewFactor2, FSubjectData2.ViewFactor1Other, FSubjectData2.ViewFactor2Other);
  SetCellTextByCellID(90, aView);

  aLocation := GetViewInfluence(FSubjectData2.LocationInfluence);
  aLocation := TranslateViewFactor(aLocation, FSubjectData2.LocationFactor1, FSubjectData2.LocationFactor2, FSubjectData2.LocationFactor1Other, FSubjectData2.LocationFactor2Other);
  SetCellTextByCellID(962, aLocation);

  //#### START Site Section
  //Electricity
  case FSubjectData2.ElectricityType of
    tPublic: SetCellTextByCellID(75, 'X');
    else if FSubjectData2.ElectricityType <> -1 then
      begin
        SetCellTextByCellID(2104, 'X');
      end;
  end;
  SetCellTextByCellID(76,FSubjectData2.ElectricityOther);   //Ticket #1156

  //Gas...
  case FSubjectData2.GasType of
    tPublic: SetCellTextByCellID(77, 'X');
    else if FSubjectData2.GasType <> -1 then
      SetCellTextByCellID(2105, 'X');
  end;
  SetCellTextByCellID(78, FSubjectData2.GasOther);  //Ticket #1156

  //Water...
  case FSubjectData2.WaterType of
    tPublic: SetCellTextByCellID(79, 'X');
    else if FSubjectData2.WaterType <> -1 then
      SetCellTextByCellID(2106, 'X');
  end;
  SetCellTextByCellID(80, FSubjectData2.WaterOther); //Ticket #1156

  //Sewer...
  case FSubjectData2.SewerType of
    tPublic: SetCellTextByCellID(81, 'X');
    else if FSubjectData2.SewerType <> -1 then
       SetCellTextByCellID(2107, 'X');
  end;
  SetCellTextByCellID(82, FSubjectData2.SewerOther);  //Ticket #1156

  //Street type ...
  case FSubjectData2.StreetType of
    tPrivate: SetCellTextByCellID(113, 'X');
    else if FSubjectData2.StreetType <> -1 then
      SetCellTextByCellID(112, 'X');
  end;
  SetCellTextByCellID(111, FSubjectData2.StreetDesc);  //Ticket #1156

  //Alley ...
  case FSubjectData2.AlleyType of
    tPrivate: SetCellTextByCellID(135, 'X');
    else if FSubjectData2.AlleyType <> -1 then
      begin
        SetCellTextByCellID(134, 'X');
      end;
  end;
  SetCellTextByCellID(133, FSubjectData2.AlleyDesc);

   //offsite improvement...
  if FSubjectData2.OffsiteImprovementsTypical = 1 then
    begin
      SetCellTextByCellID(472, 'X');
      SetCellTextByCellID(103, 'X');   //Ticket #1322: do the same for 1073 and other forms
    end
  else if FSubjectData2.OffsiteImprovementsTypical <> -1 then
    begin
      SetCellTextByCellID(473, 'X');
      SetCellTextByCellID(2038, 'X'); //Ticket #1322: do the same for 1073 and other forms
      SetCellTextByCellID(474, FSubjectData2.OffsiteImprovementsDescription);
      SetCellTextByCellID(2039, FSubjectData2.OffsiteImprovementsDescription); //Ticket #1322: do the same for 1073 and other forms
    end;

   if FSubjectData2.HasAdverseConditions = 1 then
     SetCellTextByCellID(469, 'X')
   else if FSubjectData2.HasAdverseConditions <> -1 then
     begin
       SetCellTextByCellID(470, 'X');
       SetCellTextByCellID(471, FSubjectData2.AdverseConditionsDescription);
     end;

  //#### END Site Section

  //#### START Improvement Section
  //Attic ...
  if not FSubjectData2.HasAttic then
   SetCellTextByCellID(311, 'X');

  //DropStairs...
  if FSubjectData2.DropStairs then
   SetCellTextByCellID(315, 'X')
  else
   SetCellTextByCellID(315, '');

  //Stairs
  if FSubjectData2.Stairs then
   SetCellTextByCellID(314, 'X')
  else
   SetCellTextByCellID(314, '');

  //Scuttle
  if FSubjectData2.Scuttle then
    SetCellTextByCellID(316, 'X')
  else
    SetCellTextByCellID(316, '');

   //Floor...
  if FSubjectData2.Floor then
    SetCellTextByCellID(317, 'X')
  else
    SetCellTextByCellID(317, '');

   //Finished...
   if FSubjectData2.Finished then
     SetCellTextByCellID(312, 'X')
   else
     SetCellTextByCellID(312, '');

   //Heated...
   if FSubjectData2.Heated then
     SetCellTextByCellID(1203,'X')
   else
     SetCellTextByCellID(1203, '');

 //#### END Improvement Section

 //#### START Neighborhood Section
   //Location Type
   case FSubjectData2.LocationType of
     tUrban: SetCellTextByCellID(696, 'X');
     tSuburban: SetCellTextByCellID(697, 'X');
     else if FSubjectData2.LocationType <> -1 then  //default to tRutal
       SetCellTextByCellID(698, 'X');
   end;
   //BuildUP type
   case FSubjectData2.BuiltUpType of
     tOver75: SetCellTextByCellID(699, 'X');
     tUnder25: SetCellTextByCellID(701, 'X');
     else if FSubjectData2.BuiltUpType <> -1 then //default to 25/75
       SetCellTextByCellID(700, 'X');
   end;
   //Growth
   case FSubjectData2.GrowthType of
     tStable: SetCellTextByCellID(705, 'X');
     tSlow: SetCellTextByCellID(706, 'X');
     else if FSubjectData2.GrowthType <> -1 then
        SetCellTextByCellID(704, 'X');  //default to rapid
   end;
   //One unit housing;
   if FSubjectData2.PluOneUnit >= 0 then
     SetCellTextByCellID(777, Format('%d',[FSubjectData2.PluOneUnit]));
   if FSubjectData2.Plu24Units >= 0 then
     SetCellTextByCellID(778, Format('%d',[FSubjectData2.Plu24Units]));
   if FSubjectData2.PluMultiFamily >= 0 then
     SetCellTextByCellID(779, Format('%d',[FSubjectData2.PluMultiFamily]));
   if FSubjectData2.PluCommercial >= 0 then
     SetCellTextByCellID(781, Format('%d',[FSubjectData2.PluCommercial]));
   if FSubjectData2.PluOtherCount >= 0 then
     SetCellTextByCellID(786, Format('%d',[FSubjectData2.PluOtherCount]));
   SetCellTextByCellID(785, FSubjectData2.PluOther);
   SetCellTextByCellID(600, FSubjectData2.BoundaryDescription);
   SetCellTextByCellID(601, FSubjectData2.NeighborhoodDescription);
 //#### END Neighborhood Section


   //FoundationWall
   aDescription := FSubjectData2.FoundationWallMaterial;
   aCondition   := FSubjectData2.FoundationWallCondition;
   aItem := GetDescrNCond(aDescription, aCondition);
   SetCellTextByCellID(173, aItem);

   //ExteriorWalls
   aDescription := FSubjectData2.ExteriorWallsMaterial;
   aCondition   := FSubjectData2.ExteriorWallsCondition;
   aItem := GetDescrNCond(aDescription, aCondition);
   SetCellTextByCellID(174, aItem);

   //RoofSurface
   aDescription := FSubjectData2.RoofSurfaceMaterial;
   aCondition   := FSubjectData2.RoofSurfaceCondition;
   aItem := GetDescrNCond(aDescription, aCondition);
   SetCellTextByCellID(175, aItem);

   //Gutters
   aDescription := FSubjectData2.GuttersMaterial;
   aCondition   := FSubjectData2.GuttersCondition;
   aItem := GetDescrNCond(aDescription, aCondition);
   SetCellTextByCellID(176, aItem);

   //WindowType
   aDescription := FSubjectData2.WindowTypeMaterial;
   aCondition   := FSubjectData2.WindowTypeCondition;
   aItem := GetDescrNCond(aDescription, aCondition);
   SetCellTextByCellID(181, aItem);

   //StormSash
   aDescription := FSubjectData2.StormSashMaterial;
   aCondition   := FSubjectData2.StormSashCondition;
   aItem := GetDescrNCond(aDescription, aCondition);
   SetCellTextByCellID(184, aItem);

   //Screens
   aDescription := FSubjectData2.ScreensMaterial;
   aCondition   := FSubjectData2.ScreensCondition;
   aItem := GetDescrNCond(aDescription, aCondition);
   SetCellTextByCellID(183, aItem);

   //Interior...
   //Floors
   aDescription := FSubjectData2.FloorsMaterial;
   aCondition   := FSubjectData2.FloorsCondition;
   aItem := GetDescrNCond(aDescription, aCondition);
   SetCellTextByCellID(253, aItem);

   //Walls
   aDescription := FSubjectData2.WallsMaterial;
   aCondition   := FSubjectData2.WallsCondition;
   aItem := GetDescrNCond(aDescription, aCondition);
   SetCellTextByCellID(260, aItem);

   //Trim
   aDescription := FSubjectData2.TrimMaterial;
   aCondition   := FSubjectData2.TrimCondition;
   aItem := GetDescrNCond(aDescription, aCondition);
   SetCellTextByCellID(251, aItem);

   //BathFloors
   aDescription := FSubjectData2.BathFloorsMaterial;
   aCondition   := FSubjectData2.BathFloorsCondition;
   aItem := GetDescrNCond(aDescription, aCondition);
   SetCellTextByCellID(267, aItem);

   //BathFloors
   aDescription := FSubjectData2.BathWainscotMaterial;
   aCondition   := FSubjectData2.BathWainscotCondition;
   aItem := GetDescrNCond(aDescription, aCondition);
   SetCellTextByCellID(274, aItem);

   //Foundattion
   if FSubjectData2.ConcreteSlab then
     SetCellTextByCellID(187, 'X')
   else
     SetCellTextByCellID(187, '');

   if FSubjectData2.CrawlSpace then
     SetCellTextByCellID(189, 'X')
   else
     SetCellTextByCellID(189, '');

   if FSubjectData2.HasPumpSump then
     SetCellTextByCellID(193, 'X')
   else
     SetCellTextByCellID(193, '');

  if FSubjectData2.EvidenceOfDampness then SetCellTextByCellID(2019, 'X') else SetCellTextByCellID(2019, '');
  if FSubjectData2.EvidenceOfSettlement then SetCellTextByCellID(2020, 'X') else SetCellTextByCellID(2020, '');
  if FSubjectData2.EvidenceOfInfestation then SetCellTextByCellID(197, 'X') else SetCellTextByCellID(197, '');

   //Basement : set text without calling post process, don't let math process to interfere to put 'in' in the cell even there's no basement
   if GetValidInteger(FSubjectData2.TotalArea) > 0 then
     begin
       iFinishArea := CalcFinishedArea2(GetValidInteger(FSubjectData2.TotalArea), FSubjectData2.FinishedPercent);
       if FSubjectData2.AccessMethodWalkUp then
         FSubjectData2.BasementAccess := 'wu'
       else if FSubjectData2.AccessMethodWalkOut then   //github #907
         FSubjectData2.BasementAccess := 'wo'
       else if FSubjectData2.AccessMethodInteriorOnly then
         FSubjectData2.BasementAccess := 'in';

       if FSubjectData2.AccessMethodWalkUp or FSubjectData2.AccessMethodWalkOut then
         SetCellTextByCellID(208, 'X');
     //Basement : set text without calling post process, don't let math process to interfere to put 'in' in the cell even there's no basement
     SetCellTextByCellID(200, FSubjectData2.TotalArea, True);
     if FSubjectData2.FinishedPercent > 0 then
     SetCellTextByCellID(201, Format('%d',[FSubjectData2.FinishedPercent]), True);
     if (GetValidInteger(FSubjectData2.TotalArea) > 0) then
       begin
         iFinishArea := FSubjectData2.FinishedArea;
         if FSubjectData2.FinishedPercent > 0 then
           begin
             aCellValue := Format('%ssf%dsf%s',[trim(FSubjectData2.TotalArea), iFinishArea, FSubjectData2.BasementAccess]);   //TotalAreasfFinishAreasfAccess
             ImportGridData(0, FDoc, '1006', aCellValue, FDocCompTable);
           end
         else if FSubjectData2.FinishedArea > 0 then
           begin
             aCellValue := Format('%ssf%dsf%s',[trim(FSubjectData2.TotalArea), iFinishArea, FSubjectData2.BasementAccess]);   //TotalAreasfFinishAreasfAccess
             ImportGridData(0, FDoc, '1006', aCellValue, FDocCompTable);
           end
         else
           begin
             if trim(FDoc.GetCellTextByID(1006)) <> '' then
                begin
                  aCellValue := Format('%ssf0sf%s',[trim(FSubjectData2.TotalArea), FSubjectData2.BasementAccess]);
                  ImportGridData(0, FDoc, '1006', aCellValue, FDocCompTable);
                end;
           end;
         //cell #1008: basement rooms
         //github #907: if GetValidInteger(iFinishArea) > 0 then   //donot show basement rooms if there's no finish area
           rr := 0; br := 0; Fba := 0; Hba := 0; o := 0;
           begin
             if FSubjectData2.BasementRecRooms > 0 then
               rr  := FSubjectData2.BasementRecRooms;
             if FSubjectData2.BasementBedrooms > 0 then
               br  := FSubjectData2.BasementBedrooms;
             if FSubjectData2.BasementFullBaths > 0 then
               Fba := FSubjectData2.BasementFullBaths;
             if  FSubjectData2.BasementHalfBaths > 0 then
               Hba := FSubjectData2.BasementHalfBaths;
             if FSubjectData2.BasementOtherRooms > 0 then
               o := FSubjectData2.BasementOtherRooms;
             aCellValue := Format('%drr%dbr%d.%dba%do',[rr, br, Fba, Hba, o]);
             if FSubjectData2.FinishedArea > 0 then  //Ticket 1130: only write cell id 1008 when FinishArea > 0
               ImportGridData(0, FDoc, '1008', aCellValue, FDocCompTable)
             else
               begin
                 if trim(FDoc.GetCellTextByID(1008)) <> '' then
                   ImportGridData(0, FDoc, '1008', '', FDocCompTable);
               end;
           end;
       end;
     end
     else
       begin
         if FDoc.GetCellTextByID(1006) <> '' then
           ImportGridData(0, FDoc, '1006', '0sf', FDocCompTable);
         if FDoc.GetCellTextByID(1008) <> '' then
           ImportGridData(0, FDoc, '1008', '', FDocCompTable);
         if FDoc.GetCellTextByID(200) <> '' then
           SetCellTextByCellID(200, FSubjectData2.TotalArea, True);
         if FSubjectData2.FinishedPercent > 0 then
           SetCellTextByCellID(201, Format('%d',[FSubjectData2.FinishedPercent]), True);
       end;
  //Ticket #1130
  case FSubjectData2.BasementType of
   tNoBasement,-1: begin
                  SetCellTextByCellID(2018, '');
                  SetCellTextByCellID(191, '');
                end;
   tPartialBasement: SetCellTextByCellID(2018, 'X');
   tFullBasement: begin
                    SetCellTextByCellID(191, 'X');
                  end;

  end;
  if GetValidInteger(FSubjectData2.TotalArea) > 0 then
    begin
      SetCellTextByCellID(880, 'Bsmt', True);
      SetCellTextByCellID(881, FSubjectData2.TotalArea, True);
    end;

      //Appliance
      if FSubjectData2.HasRefrigerator then SetCellTextByCellID(299, 'X') else SetCellTextByCellID(299, '');
      if FSubjectData2.HasRangeOwen then SetCellTextByCellID(300, 'X') else SetCellTextByCellID(300, '');
      if FSubjectData2.HasDishWasher then SetCellTextByCellID(304, 'X') else SetCellTextByCellID(304, '');
      if FSubjectData2.HasDisposal then SetCellTextByCellID(303, 'X') else SetCellTextByCellID(303, '');
      if FSubjectData2.HasMicrowave then SetCellTextByCellID(307, 'X') else SetCellTextByCellID(307, '');
      if FSubjectData2.HasWasherDryer then SetCellTextByCellID(308, 'X') else SetCellTextByCellID(308, '');
      if FSubjectData2.HasOtherAppliances then SetCellTextByCellID(2084, 'X') else SetCellTextByCellID(2084, '');
      SetCellTextByCellID(309, FSubjectData2.OtherAppliances);

      SetCellTextByCellID(1032, FSubjectData2.MiscDesc3);

      //Handle Subject Garage/carport/drive
      ImportSubjectGarage;
      ImportSubjectCarport;
      ImportSubjectDriveWay;

      //Ticket #1538
      if FSubjectData2.AdverseSiteConditionPresent = 1 then SetCellTextByCellID(2034, 'X')
      else if FSubjectData2.AdverseSiteConditionPresent = 0 then
        SetCellTextByCellID(2035, 'X');
      if FSubjectData2.PropertyConformsToNeighborhood = 1 then SetCellTextByCellID(504, 'X')
      else if FSubjectData2.PropertyConformsToNeighborhood = 0 then
        SetCellTextByCellID(505, 'X');

  except on E:Exception do
    showNotice('Error in populating Subject data to the form.' +e.message);
  end;
end;

procedure  TInspectionDetail.ImportSubjectGarage;
var
  ga_CellValue: Integer;
begin
   ga_CellValue := GetValidInteger(FDoc.GetCellTextByID(2030));
   if FSubjectData2.GarageCars > 0 then
    begin
      SetCellTextByCellID(349, 'X');
      FDoc.SetCellTextByIDNP(2030, Format('%d',[FSubjectData2.GarageCars]));

      if FSubjectData2.GarageAttachedCars then //Ticket #1325: use GarageAttachedCars instead
        begin
          SetCellTextByCellID(2070, 'X');
          SetCellTextByCellID(3000, Format('%d',[FSubjectData2.GarageCars]));
        end
      else if FSubjectData2.GarageDetachedCars then
         begin
           SetCellTextByCellID(2071, 'X');
           SetCellTextByCellID(3001, Format('%d',[FSubjectData2.GarageCars]));
         end
      else if FSubjectData2.GarageBuiltincars then
         begin
           SetCellTextByCellID(2072, 'X');
           SetCellTextByCellID(3002, Format('%d',[FSubjectData2.GarageCars]));
         end;
    end
    else //github #663
    begin
      if Fdoc.UADEnabled and (ga_CellValue = 0) then
        begin
          SetCellTextByCellID(2030, '0', True);  //if EMPTY or NULL set to 0 to avoid UAD review error
          SetCellTextByCellID(349, '');
        end
    end;
end;

procedure  TInspectionDetail.ImportSubjectCarport;
var
  cp_CellValue: Integer;
begin
  //Carport
  cp_CellValue := GetValidInteger(FDoc.GetCellTextByID(355));
  if FSubjectData2.CarportCars > 0 then
    begin
      FDoc.SetCellTextByIDNP(355, Format('%d',[FSubjectData2.CarportCars]));
      SetCellTextByCellID(2657, 'X');
      if FSubjectData2.GarageCars <= 0 then //only check attached/detach if no car garage
        begin
          if FSubjectData2.CarportAttachedCars then
            SetCellTextByCellID(2070, 'X')
          else if FSubjectData2.CarportDetachedCars then
            SetCellTextByCellID(2071, 'X');
        end;
    end
  else //github #663
    begin
      if Fdoc.UADEnabled and (cp_CellValue = 0) then
        begin
          SetCellTextByCellID(355, '0', True);  //if EMPTY or NULL set to 0 to avoid UAD review error
          SetCellTextByCellID(2657, '');
        end
    end;
end;

procedure  TInspectionDetail.ImportSubjectDriveWay;
var
  dw_CellValue: Integer;
begin
  dw_CellValue := GetValidInteger(FDoc.GetCellTextByID(360));
  //Driveway
  SetCellTextByCellID(92, FSubjectData2.DrivewaySurface);
  if FSubjectData2.Driveway then
    SetCellTextByCellID(359, 'X')
  else
    SetCellTextByCellID(359, '');
  if FSubjectData2.DrivewayCars <> -1 then
    begin
      FDoc.SetCellTextByIDNP(360, Format('%d',[FSubjectData2.DrivewayCars]));
      SetCellTextByCellID(359, 'X');
    end
  else //github #663
    begin
      if Fdoc.UADEnabled and (dw_CellValue = 0) then
          SetCellTextByCellID(360, '0')  //skip math github #663: if EMPTY set to 0 to avoid UAD review error
      else if dw_Cellvalue > 0 then
        begin
          SetCellTextByCellID(360, Format('%d',[dw_CellValue]));  //skip math github #663: if EMPTY set to 0 to avoid UAD review error
          SetCellTextByCellID(359, 'X');
        end;
    end;
end;


procedure TInspectionDetail.DownloadImagePackagesByID(insp_id: Integer);
const
 INSP_IMAGE_FILE_NAME = 'ImageSketchData.txt';
 formID3x5 = 301;
 frontCellID = 15;
 rearCellID  = 18;
 streetCellID = 21;
 var
  lHTTP: TIdHTTP;
  response : String;
  id : Integer;
  js, jsImage: TlkJSONBase;
  itjs, obj: TlkJSONobject;
  i : integer;
  Image, imagedata, sketchdata: String;
  Photo : TJPEGImage;
  img : TImage;
  StreamA,StreamB : TStream;
  Bmp: TBitmap;
  JPGImage: TGraphic;
  CFImages : TCFImage;
  image_id: Integer;
  aUrl, image_descr, image_type:String;
  joImage, joSketch, joSketchData: TlkJSONObject;
  sketcher_page_count,sketcher_packet_version: String;
  sketcher_mdata_version,sketchMdata: String;
  js_image_array, js_Sketch_data, js_Sketch_array, js_Sketch_MData_Array,js_Sketcher_Page_Count: TlkJSonBase;
  js_Sketcher_Count: TlkJSonBase;
  errorMsg,TempRawDataFile, aStr: String;
  sl:TStringList;
begin
  if insp_id = 0 then exit;
//Test only: insp_id := 95997;
  lHTTP := TIdHTTP.Create(nil);
  id := insp_id;
  PushMouseCursor(crHourGlass);
  try
    Application.ProcessMessages;
    aURL := Format('%sget?id=%d&bradford_key=%s',[live_mobile_images_URL,insp_id,mobile_images_key]);
    try
      response := lHTTP.Get(aURL);

      FImageData := response;
    except on E:Exception do
      begin
        errorMsg := lHTTP.ResponseText;
        case lHTTP.ResponseCode of
          404: errorMsg := Format('Inspection # %d: No images were found for this inspection.',[FUploadInfo2.insp_id]);
          407: errorMsg := Format('Inspection # %d: authentication required.',[FUploadInfo2.insp_id]);
        end;
        if (errorMsg <> '')  then
          ShowAlert(atWarnAlert, errorMsg)
        else
          showAlert(atWarnAlert, e.Message);
        exit;
      end;
    end;
    Application.ProcessMessages;
    js:= TlkJSON.ParseText(response);
    FSketchJSON := response;
    if js <> nil then
      begin
        //handle images
        js_image_array := js.Field['Image_Data'];
        if js_image_array <> nil then
          DownloadImagesJSon(js_image_array);

        //handle sketches
        js_Sketch_array := js.Field['Sketcher_Pages'];
        js_Sketch_MData_Array := js.Field['Sketcher_Meta_Data'];
        js_Sketcher_Count := js.Field['Sketcher_Count'];
        //if (js_Sketch_array <> nil) or (js_Sketch_MData_Array <> nil) then
        js_Sketcher_Page_Count := js.Field['Sketcher_Page_Count'];
        if (js_Sketcher_Count <> nil) or (js_Sketcher_Page_Count <> nil)  then
         if (js_Sketcher_Page_Count.Value > 0) then
          DownloadSketchJSon(js_Sketch_array, js_Sketch_MData_Array, False);
      end;
  finally
    lHTTP.Free;
    PopMouseCursor;
  end;
end;



procedure  TInspectionDetail.LoadSketchImages(SketchImageStr: String; i, acount: Integer; js_sketch_data,jsMeta:TlkJSonBase);
var
  imgPhoto : TPhoto;
  imageJPG: TJPEGImage;
  aItem: String;
  aName, strValue: String;
  aValue,aSum: Integer;
  GLANames, NonGLANames: TlkJSonBase;
  GLAItems, NonGLAItems: TlkJSonBase;
  SketchGroupBox:TGroupBox;
  sketchPanel: TPanel;
  SketchImage:TImage;
  aCnt: Integer;
  Lines_Id: String;
  LengthFt: Double;
begin
   if SketchImageStr = '' then exit;
   //creaet a TPanel and TImage to insert image into it
   SketchGroupBox := TGroupBox.Create(BasePanel);
   SketchGroupBox.Align := alBottom;
   SketchGroupBox.Height := 400;
   SketchGroupBox.parent  := BasePanel;
   SketchGroupBox.Caption := Format('Sketch Page %d of %d',[i, aCount]);
   BasePanel.Height := SketchGroupBox.Height * i;
   BasePanel.Width  := ScrollBox1.width - 5;

   sketchPanel := TPanel.Create(SketchGroupBox);  //this will hold the image
   sketchPanel.Align := alClient;
   sketchPanel.Parent := SketchGroupBox;

   SketchImage := TImage.Create(sketchPanel);
   SketchImage.Align   := alClient;
   SketchImage.Stretch := True;
   sketchImage.Parent  := sketchPanel;

   imgPhoto := TPhoto.Create;
   try
    imgPhoto.PhotoType    := 0;
    imgPhoto.PhotoCaption := 'Sketch Data';
    imgPhoto.PhotoDate    := DateToStr(date);
    imgPhoto.Image := TJPEGImage.Create;
    //now get the image
    imageJPG    := TJPEGImage.Create;
    LoadJPEGFromByteArray(SketchImageStr,imageJPG);
    imgPhoto.FImage.Assign(imageJPG);
    if assigned(imgPhoto.Image) then
      SketchImage.Picture.Graphic := imgPhoto.Image;
   finally
     if assigned(imageJPG) then
       imageJPG.Free;
     if assigned(imgPhoto) then
       imgPhoto.Free;
   end;
//##################### Sketch meta data
  if (jsMeta = nil) or (jsMeta.Count = 0) then exit;
  if i > 1 then exit;   //only move on for the first page to get the meta data
  //download sketch meta data

  //This is for GLA Names section
  if jsMeta.Field['GlaNames'] <> nil then
    GLANames := jsMeta.Field['GlaNames'];

    if GLANames <> nil then
      begin
        aSum := 0;
        try

          for aCnt  := 0 to GLANames.Count -1 do
            begin
              GLAItems := GLANames.Child[aCnt];
              if GLAItems <> nil then
                begin
                  if GLAItems.Field['Item1'] <> nil then
                    aName := VarToStr(GLAItems.Field['Item1'].Value);
                  if GLAItems.Field['Item2'] <> nil then
                    aValue := GLAItems.Field['Item2'].Value;
                end;
              if aValue = 0 then continue;
              aItem := Format('%s = %d sf', [aName, aValue]);
              GLA.Lines.Add(aItem);
            end;
        finally
          if assigned(GLANames) then
            FreeAndNil(GLANames);
        end;
    end;

    //This is for Non GLA Names section
  if jsMeta.Field['NonGlaNames'] <> nil then
    NonGLANames := jsMeta.Field['NonGlaNames'];
    if NonGLANames <> nil then
      begin
        try
          for aCnt  := 0 to NonGLANames.Count -1 do
            begin
              NonGLAItems := NonGLANames.Child[aCnt];
              if NonGLAItems <> nil then
                begin
                  if NonGLAItems.Field['Item1'] <> nil then
                    aName := VarToStr(NonGLAItems.Field['Item1'].Value);
                  if NonGLAItems.Field['Item2'] <> nil then
                    aValue := NonGLAItems.Field['Item2'].Value;
                  aItem := Format('%s = %d sf', [aName, aValue]);
                  NonGLA.Lines.Add(aItem);
                end;
            end;
        finally
          if assigned(NonGLANames) then
            FreeAndNil(NonGLANames);
        end;
     end;
end;

procedure TInspectionDetail.ClearSketchImages;
const
  skformID = 201;
  skWCalcFormID = 4177;
  skWDimensionFormID = 705;
var
  f,p,c: Integer;
  aForm: TDocForm;
  aCell: TBaseCell;
begin
   //Clear current images
    for f := 0 to FDoc.docForm.Count - 1 do   //only clear the one that matches with the sketch option form use
      begin
        case FDoc.docForm[f].FormID of
          skformID, skWCalcFormID, skWDimensionFormID:
            begin
              aForm := FDoc.docForm[f];
              for p := 0 to FDoc.docForm[f].frmPage.Count - 1 do
                if Assigned(FDoc.docForm[f].frmPage[p].pgData) then
                for c := 0 to FDoc.docForm[f].frmPage[p].pgData.Count - 1 do
                  begin
                    aCell := FDoc.docForm[f].frmPage[p].pgData[c];
                    //aCell := aForm.GetCell(1,cidSketchImage);
                    if FOverwriteData then
                      begin
                        if assigned(aCell) then
                          begin
                            if (aCell is TPhotoCell) and (TPhotoCell(aCell).HasImage) then
                              begin
                                if (rdoSketchData.ItemIndex = 0) and (FDoc.docForm[f].FormID=skWCalcFormID) then
                                  TPhotoCell(aCell).FImage.Clear
                                else if (rdoSketchData.ItemIndex = 1) and (FDoc.docForm[f].FormID=skWDimensionFormID) then
                                FDoc.MakeCurCell(aCell);        //make sure its active
                              end
                            else
                              begin
                                if (rdoSketchData.ItemIndex = 0) and (FDoc.docForm[f].FormID=skWCalcFormID) then
                                  aCell.Clear
                                else if (rdoSketchData.ItemIndex = 1) and (FDoc.docForm[f].FormID=skWDimensionFormID) then
                                  aCell.Clear;
                              end;
                          end;
                      end;
                  end;
              end;
        end;
     end;
end;

procedure TInspectionDetail.DownloadSketchJSon(js, jsMeta: TlkJSonBase; toReport:Boolean);
const
  SketchformID = 201;
 var
  id : Integer;
  itjs: TlkJSONobject;
  i : integer;
  sketcher_packet_version, sketchdata, sketcher_page_count : String;
  Photo : TJPEGImage;
  image_id: Integer;
  imagedata, image, image_descr, image_type, version, sketcher_image:String;
  joSketch, js_Sketch_data: TlkJSonBase;
  sketcher_mdata_version,sketchmetadata: String;
  thisForm:TDocForm;
begin
try
  try
    if FOverWriteData then
      begin
        ClearSketchImages;
      end;

   //download sketch
  thisForm := nil;
  PushMouseCursor(crHourGlass);
  sketcher_packet_version := varToStr(js.Field['Sketcher_Packet_Version'].Value);
  sketcher_page_count     := varToStr(js.Field['Sketcher_Page_Count'].value);

  joSketch := js.Field['Sketcher_Image'];

  //handle sketch meta data
  sketcher_mdata_version := varToStr(js.Field['Sketcher_Mdata_Version'].Value);
  js_Sketch_data         := js.Field['Sketcher_Meta_Data'];
  if (joSketch = nil) and (js_Sketch_data = nil) then  exit;  //no need to continue if no sketch and no sketch meta data

  for i:= 0 to pred(joSketch.Count) do
    begin
       itjs := (joSketch.Child[i] as TlkJSONobject);
       if itjs.Field['Version'] <> nil then   //github#645
         version := itjs.getString('Version');
       image := '';
       if not (itjs.Field['Sketcher_Image'] is TlkJSONnull) then  //github#645
         begin
           sketcher_image := itjs.getString('Sketcher_Image');
           image := Base64Decode(sketcher_image);
         end;
       if length(image) = 0 then continue;
       Photo := TJPEGImage.Create;
       try
         LoadJPEGFromByteArray(image,Photo);
         FSketchImageBase64 := image;
         if not ToReport then
           LoadSketchImages(image, i+1, joSketch.count, js_sketch_data,jsMeta)
         else
           begin
             ImportSketchimagestoReport(Photo,i+1,js_sketch_data,jsMeta, thisForm);
           end;
       finally
         if assigned(Photo) then
           Photo.Free;
       end;
    end;
    except on E:Exception do
      ShowAlert(atWarnAlert, 'Cannot download the Sketch image.  '+e.message);
    end;
  finally
    PopMouseCursor;
    if assigned(itjs) then
      FreeAndNil(itjs);
  end;
end;



procedure TInspectionDetail.ImportSketchImagesToReport(photo:TJPEGImage; i: Integer; js, jsMeta:TlkJSonBase; var thisForm:TDocForm);
//const
// SketchformID = 201;
// SketchformID2 = 4177;
var
  cell: TBaseCell;
  cntr: Integer;
  aStream: TMemoryStream;
  aTitle: String;
  skCells: cellUIDArray;
  sketchLabel: String;
  aFormID,count, occur: Integer;
  isNew,printHeader:Boolean;
begin
  sketchLabel := formatdatetime('mdyyhns',now);
  cell := nil;
  thisForm := nil;
  aTitle := '';
  IsNew := False;
  if (rdoSketchData.ItemIndex = 0)  then
    begin
      if i=1 then
        begin
          aFormID := 4177;
          occur   := i-1;
        end
      else
        begin
          aFormID := 201;   //Ticket #1401: use sketch form 201 for all the sketches
          case i of
            1,2: occur := 0
            else
              occur := i-2;
          end;
        end;
    end
  else
    begin
      aFormID := 201;
      occur := i-1;
    end;
  if FOverwriteData then //github 209: only insert blank form when we are in overwrite mode
    begin
      //thisForm := Fdoc.InsertBlankUID(TFormUID.Create(aFormID), true, -1);
      thisForm := FDoc.GetFormByOccurance(aFormID, occur, false);
      if not assigned(thisForm) then
        begin
          thisForm := FDoc.InsertFormUID(TFormUID.Create(aFormID),true,-1);
          isNew := True;
        end;
      cell := thisForm.GetCellByID(cidSketchImage);
    end
  else if i = 0 then//github 302: if no sketch form, create one
    begin
      thisForm := Fdoc.InsertBlankUID(TFormUID.Create(aFormID), true, -1);
      cell := thisForm.GetCellByID(cidSketchImage);
      IsNew := True;
    end;
    //no sketch form, insert a blank one
    if not assigned(cell) then
      begin
        thisForm := FDoc.InsertFormUID(TFormUID.Create(aFormID),true,-1);
        cell := thisForm.GetCellByID(cidSketchImage);
        IsNew := True;
      end;
  PrintHeader := True;
  if assigned(cell) and (cell is TSketchCell) then
    begin
      if IsNew or FOverWriteData then
      begin
        if chkSketchONLY.Checked then
          PrintHeader := FOverWriteData;
      end
      else if chkSketchOnly.Checked and not FOverWriteData then
        PrintHeader := False;
    end;
  if FDoc.docIsNew then
    PrintHeader := True;
   if PrintHeader then
    begin
       thisForm.SetCellText(1,6, FUploadInfo2.Address);
       thisForm.SetCellText(1,7, FUploadInfo2.City);
       thisForm.SetCellText(1,9, FUploadInfo2.State);
       thisForm.SetCellText(1,10, FUPloadInfo2.Zipcode);
       //FDoc.SetCellTextByID(46, FUploadInfo2.Address);
       //FDoc.SetCellTextByID(47, FUploadInfo2.City);
       //FDoc.SetCellTextByID(48, FUploadInfo2.State);
       //FDoc.SetCellTextByID(49, FUploadInfo2.Zipcode);

       SetCellTextByCellID(2, FSubjectData2.AppraisalFileNumber);
       if FSubjectData2.IsFHA then
         SetCellTextByCellID(3, 'FHA #');
    end;

        aStream := TMemoryStream.Create;
       try
         FDoc.MakeCurCell(cell);        //make sure its active
         Photo.SaveToStream(aStream);
         aStream.Position := 0;
         TGraphicCell(cell).LoadStreamData(aStream, aStream.Size, True);
         cell.Text := sketchLabel;  //put the text
         cell.Display;
         if (rdoSketchData.ItemIndex = 0) and (i = 1) then
           DownloadSketchMdataJson2(jsMeta, thisForm,i);
       finally
         aStream.Free;
       end;
end;


procedure TInspectionDetail.SetCellTextByCellID(cellID:Integer; aText: String; skipMath:Boolean=False);
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
        FDoc.SetCellTextByID(cellID, aText)
      else if (aText <> '') then
        begin
          case cellID of
            499: FDoc.SetCellTextByID(CellID, aText); //Ticket #1323: set text regardless of 0
          end;
        end;
    end
  else     //not override mode and cell is EMPTY
    begin
      if (aCell.Text = '') and (aText <> '') and (trim(aText) <> '0') then
        begin
          if SkipMath then
            FDoc.SetCellTextByIDNP(cellID, aText)
          else
            FDoc.SetCellTextByID(cellID, aText);
        end
      else if (aCell.Text = '') and (aText <> '') then     //Ticket #1323: still set text for Effective age and actual age
        begin
          case cellID of
            499: FDoc.SetCellTextByID(cellID, aText);
          end;
        end;
    end;
  if not skipMath then   //Ticket #1051:  need to process math for those cell with mathid <> ''
    begin
      TBaseCell(aCell).ReplicateLocal(True);
      TBaseCell(aCell).ReplicateGlobal;
      TBaseCell(aCell).ProcessMath;
    end;
end;


procedure TInspectionDetail.FormShow(Sender: TObject);
begin
  FBasePanelHeight := BotBasePanel.Height;
  SetupConfig;
  PageControl.ActivePage := tabJson;
  PageControl.ActivePage := tabSubjPhotos;
  if FInspectionData <> '' then
    begin
      LoadJsonTree(FInspectionData);
      DownLoadInspectionDataByID(FInspectionData);
    end;
end;

procedure TInspectionDetail.AdjustDPISettings;
begin
  btnClose2.Left := self.Width - btnclose2.Width - 15;
  btnTransfer.Left := btnClose2.Left - btnTransfer.Width - 10;
end;

procedure TInspectionDetail.SetupConfig;
begin
  AdjustDPISettings;
  LoadFromIniFile;
  chkSaveWorkFile.Checked := appPref_AutoCreateWorkFileFolder;
  case FSubjectMainFormID of
    301: rdoMainSubject.ItemIndex := 0;
    4103: rdoMainSubject.ItemIndex := 1;
    else
      rdoMainSubject.ItemIndex := 0;
  end;

  case FSubjectExtraFormID of
    302: rdoExtraSubject.ItemIndex := 0;
    324: rdoExtraSubject.ItemIndex := 1;
    326: rdoExtraSubject.ItemIndex := 2;
    325: rdoExtraSubject.ItemIndex := 3;
    else
      rdoExtraSubject.ItemIndex := 0;
  end;

  case FCompMainFormID of
    304: rdoMainComp.ItemIndex := 0;
//    4084: rdoMainComp.ItemIndex := 1;
    4181: rdoMainComp.ItemIndex := 1;
    else
      rdoMainComp.ItemIndex := 0;
  end;
end;

procedure TInspectionDetail.InsertXCompPage(doc: TContainer; compNo: Integer);
var
  i, count, formID: Integer;
  found: boolean;
begin
  found := False;
  for i := 0 to doc.docForm.Count - 1 do
    begin
      case doc.docForm.Forms[i].FormID of
        340, 355, 342, 889, 11, 4220, 4218, 4365: //both forms are using the same xcomp page 363
          begin
            formID := 363;
            found := true;
            break;
          end;
        349: //1025
          begin
            formID := 364;
            found := true;
            break;
          end;
        345, 347: //both forms are using the same xcomp page 367
          begin
            formID := 367;
            found := true;
            break;
          end;
        351:  //form 2090
          begin
            formID := 366;
            found := true;
            break;
          end;
        4131: //apple main form
          begin
            formID := 4132;
            found := true;
            break;
          end;
        4136: //apple main form
          begin
            formID := 4137;
            found := true;
            break;
          end;
      end;
    end;
  if found then
    begin
      count := compNo div 3;  //see how many xcomp page we need
      doc.GetFormByOccurancebyIdx(formID, count-1, -1, True);
    end;
end;

procedure TInspectionDetail.InsertXListingPage(doc: TContainer; compNo: Integer);
var
  i, count, formID: Integer;
  found: boolean;
begin
  found := False;
  for i := 0 to doc.docForm.Count - 1 do
    begin
      case doc.docForm.Forms[i].FormID of
        340, 355, 4220, 4218, 4365: //both forms are using the same xcomp page 363
          begin
            formID := 3545;
            found := true;
            break;
          end;
        349: //1025
          begin
            formID := 869;
            found := true;
            break;
          end;
        345, 347: //both forms are using the same xcomp page 367
          begin
            formID := 888;
            found := true;
            break;
          end;
        4131: //apple main form
          begin
            formID := 4133;  //extra listing page
            found := true;
            break;
          end;
        4136: //apple main form #2
          begin
            formID := 4138;  //extra listing page
            found := true;
            break;
          end;
      end;
    end;
  if found then
    begin
      count := trunc((compNo + 2)/3);
      doc.GetFormByOccuranceByIdx(formID, count,-1, True);
    end;
end;



procedure TInspectionDetail.ImportListingGridData(CompNo: Integer; doc: TContainer;  cellStr, str: String; var FDocListingTable: TCompMgr2);
var
  cellID: Integer;
  i, n : integer;
  CompCol: TCompColumn;
  aTemp, aLat, aLon: String;
  GeoCodedCell: TGeocodedGridCell;
begin
  if not assigned(FDocListingTable) then exit;
  if  FDocListingTable.Count = 0 then
    begin
      InsertXListingPage(doc, compNo);
      FDocListingTable.BuildGrid(doc, gtListing);
    end;
  cellID := round(GetValidNumber(cellStr));
  try
    if Assigned(FDocListingTable) and (FDocListingTable.Count > 0) then
      for i:= 0 to FDocListingTable.Count - 1 do
        begin
          CompCol := FDocListingTable.Comp[i];    //Grid comp column
          if compNo = i then
            begin
              if (cellID =CGeocodedGridCellID*10) and (CompCol.GetCellByID(CGeocodedGridCellID) is TGeocodedGridCell) then
                begin
                  if cellID = CGeocodedGridCellID * 10 then
                    begin
                      GeocodedCell := CompCol.GetCellByID(CGeocodedGridCellID) as TGeocodedGridCell;
                      //aLat := popStr(str, vSeparator);
                      aLon := str;
                      GeocodedCell.Latitude := StrToFloatDef(aLat, 0);
                      GeocodedCell.Longitude := StrToFloatDef(aLon, 0);
                      break;
                    end;
                end
                else if str<> '' then
                  begin
                    SetCompTableValue(doc, CompCol, cellID, str);
                  end;
                break;
            end;
        end;

     n:= FDocListingTable.Count;  //remember the original # comps in the report
     if n = 0 then exit;
     //check if we need to create xcomp page
     if compNo > (FDocListingTable.Count - 1) then  //exclude the subject
       begin
          InsertXListingPage(doc, compNo);
          FDocListingTable.BuildGrid(doc, gtListing);  //we only deal with sales comp from Redstone
          if Assigned(FDocListingTable) and (FDocListingTable.Count > 0) then
            for i:= n to FDocListingTable.Count - 1 do //skip all the existing comps, only deal with new xcomp
              begin
                CompCol := FDocListingTable.Comp[i];    //Grid comp column
                if compNo = i then
                  begin
                    if (cellID =CGeocodedGridCellID * 10) and (CompCol.GetCellByID(CGeocodedGridCellID) is TGeocodedGridCell) then
                      begin
                        if cellID = CGeocodedGridCellID * 10 then
                          begin
                            GeocodedCell := CompCol.GetCellByID(CGeocodedGridCellID) as TGeocodedGridCell;
                            //aLat := popStr(str, vSeparator);
                            aLon := str;
                            if (aLat<>'') and (aLon<>'') then
                            begin
                              GeocodedCell.Latitude := StrToFloatDef(aLat, 0);
                              GeocodedCell.Longitude := StrToFloatDef(aLon, 0);
                            end;
                            break;
                          end;
                      end
                      else if str <> '' then
                        SetCompTableValue(doc, CompCol, cellID, str);
                      break;
                  end;
              end;
       end;
    finally
    end;
end;

procedure TInspectionDetail.SetCompTableValue(doc: TContainer; CompCol: TCompColumn; cellID: Integer; str: String);
var
  aStr, aCellText: String;
begin
  if Str = '' then exit;  //if incoming value is empty, exit

  aStr := FUADObject.TranslateToUADFormat(compCol, cellID, str, FOverwriteData);

  if assigned(CompCol) then
    begin
      aCellText := CompCol.GetCellTextByID(CellID);  //check for current cell
      if not FOverwriteData then
        begin
          if length(aCellText) = 0 then
            CompCol.SetCellTextByID(CellID, aStr);  //put in when the cell is empty
        end
      else
       begin
         if (cellid = 1004) and (abs(CompCol.FCompID) = 3) then
           begin
             CompCol.SetCellTextByID(CellID, aStr);  //put in doesn't it's empty or not empty
           end
         else
           begin
             CompCol.SetCellTextByID(CellID, aStr);  //put in doesn't it's empty or not empty
           end;
       end;
    end;
end;



procedure TInspectionDetail.ImportGridData(CompNo: Integer; doc: TContainer; cellStr, str: String; var FDocCompTable: TCompMgr2);
var
  cellID: Integer;
  i, n : integer;
  CompCol: TCompColumn;
  aTemp, aLat, aLon: String;
  GeoCodedCell: TGeocodedGridCell;
begin
  if not assigned(FDocCompTable) then exit;
  if (FDocCompTable.Count = 0)  or (CompNo > FDocCompTable.Count) then //check if comp # > the total count, add xtra page and rebuild the table
    begin
      InsertXCompPage(doc, compNo);
      FDocCompTable.BuildGrid(FDoc, gtSales);
    end;
  cellID := round(GetValidNumber(cellStr));
  try
    if Assigned(FDocCompTable) and (FDocCompTable.Count > 0) then
      for i:= 0 to FDocCompTable.Count - 1 do
        begin
          CompCol := FDocCompTable.Comp[i];    //Grid comp column
          if compNo = i then
            begin
              if (cellID =CGeocodedGridCellID*10) and (CompCol.GetCellByID(CGeocodedGridCellID) is TGeocodedGridCell) then
                begin
                  if cellID = CGeocodedGridCellID * 10 then
                    begin
                      GeocodedCell := CompCol.GetCellByID(CGeocodedGridCellID) as TGeocodedGridCell;
                      aLat := popStr(str, ';');
                      aLon := str;
                      GeocodedCell.Latitude := StrToFloatDef(aLat, 0);
                      GeocodedCell.Longitude := StrToFloatDef(aLon, 0);
                      break;
                    end;
                end
                else if str<> '' then
                  begin
                    SetCompTableValue(doc, CompCol, cellID, str);
                  end;
                break;
            end;
        end;

     n:= FDocCompTable.Count;  //remember the original # comps in the report

     //check if we need to create xcomp page
     if compNo > (FDocCompTable.Count - 1) then  //exclude the subject
       begin
          InsertXCompPage(doc, compNo);
          FDocCompTable.BuildGrid(doc, gtSales);  //we only deal with sales comp from Redstone
          if Assigned(FDocCompTable) and (FDocCompTable.Count > 0) then
            for i:= n to FDocCompTable.Count - 1 do //skip all the existing comps, only deal with new xcomp
              begin
                CompCol := FDocCompTable.Comp[i];    //Grid comp column
                if compNo = i then
                  begin
                    if (cellID =CGeocodedGridCellID * 10) and (CompCol.GetCellByID(CGeocodedGridCellID) is TGeocodedGridCell) then
                      begin
                        if cellID = CGeocodedGridCellID * 10 then
                          begin
                            GeocodedCell := CompCol.GetCellByID(CGeocodedGridCellID) as TGeocodedGridCell;
                            aLat := popStr(str, ';');
                            aLon := str;
                            if (aLat<>'') and (aLon<>'') then
                            begin
                              GeocodedCell.Latitude := StrToFloatDef(aLat, 0);
                              GeocodedCell.Longitude := StrToFloatDef(aLon, 0);
                            end;
                            break;
                          end;
                      end
                      else if str <> '' then
                        SetCompTableValue(doc, CompCol, cellID, str);
                      break;
                  end;
              end;
       end;
    finally
    end;
end;

procedure TInspectionDetail.writeGridData(CompNo: Integer; doc:TContainer;  cellStr, str: String; var FDocCompTable: TCompMgr2);
begin
  ImportGridData(CompNo, doc, cellStr, str, FDocCompTable);
end;

procedure TInspectionDetail.writeListingGridData(CompNo: Integer; doc:TContainer;  cellStr, str: String; var FDocCompTable: TCompMgr2);
begin
  ImportListingGridData(CompNo, doc, cellStr, str, FDocListTable);
end;

procedure TInspectionDetail.btnClose2Click(Sender: TObject);
begin
  Close;
end;

procedure TInspectionDetail.PageControlChange(Sender: TObject);
begin
   case PageControl.ActivePageIndex of
     0, 1: begin
             PageControl1.ActivePage := taPhotos;
             taSketch.TabVisible := False;
             taData.TabVisible := False;
           end;
     2: begin
          PageControl1.ActivePage := taSketch;
          taPhotos.TabVisible := False;
          taData.TabVisible := False;
        end;
     3: begin
          PageControl1.ActivePage := taData;
          taSketch.TabVisible := False;
          taPhotos.TabVisible := False;
        end;
   end;
end;



procedure TInspectionDetail.ImageMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Pt: TPoint;
  aPanel: TPanel;
begin
  if (sender is TImage) and (ssRight in Shift) then
    begin
      Pt := (Sender as TImage).ClientToScreen(Point(X,Y));
    end
  else if (sender is TImage) and not (ssDouble in Shift) then
    begin
      TImage(Sender).BeginDrag(False, 5);
    end
  else if Sender is TImage then
     TImage(Sender).BeginDrag(True);

  aPanel := TPanel(TImage(Sender).Parent);
end;

procedure TInspectionDetail.ImageDragOver(Sender,
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  if (Source is TPanel) or (Source is TImage) then
      Accept := True;
end;

procedure TInspectionDetail.ImageDragDrop(Sender,Source: TObject; X, Y: Integer);
var
  i: Integer;
  sTag,tTag: Integer;
  sSeq, tSeq: Integer;
  aImage: TImage;
begin
  sTag := -1; tTag := -1; sSeq := 0; tSeq := 0;
  if Sender is TImage then
    tTag := TImage(Sender).Tag;

  if Source is TImage then
    sTag := TImage(Source).Tag ;

  if (sTag <> -1) and (tTag <> -1) and (sTag <> tTag) then
    begin
      for i:=0 to FSubjectPhotoList.Count - 1 do
        begin
          aImage := TImage(FSubjectPhotoList[i]);
          if aImage.Tag = sTag then
            sSeq := i
          else if aImage.Tag = tTag then
            tSeq := i;
        end;
      FSubjectPhotoList.Move(sSeq, tSeq);
    end;
  ReOrderSubjectPanels;
end;

Procedure TInspectionDetail.ReOrderSubjectPanels;
var
  i: Integer;
  oPanel, iPanel: TPanel;
  LeftPos: Integer;
begin
  LeftPos := 0;
  try
    for i:= 0 to FSubjectPhotoList.Count -1  do
      begin
        oPanel := TPanel(FSubjectPhotoList[i]);
        iPanel := TPanel(BotBasePanel.FindComponent(oPanel.Name));
        if assigned(iPanel) then
          begin
            if (iPanel.Top < 0) then
              begin
                iPanel.Align := alTop;
                iPanel.Align := alNone;
                iPanel.Top   := BotBasePanel.Top;
              end;
            iPanel.top     := CalcImageFrameTop(i+1, leftPos);  //use seqno to calculate
            iPanel.Left    := leftPos;
          end;
      end;
  except on E:Exception do
    // don't care showmessage('ReOrderSubjectPanels: '+e.Message);
  end;
end;

procedure TInspectionDetail.ImageEndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
   if (Sender is TImage) and (Target is TImage) then
     begin
       if TImage(Sender).Tag <> TImage(Target).Tag then
         TPanel(TImage(Sender).Parent).Color := clbtnFace;
     end;
end;


//PAM Ticket #1407: only load to the top subject photo section if the caption is Front View or Street View or Rear View
function TInspectionDetail.IsSubjectMain(aTitle:String):Boolean;
begin
  result := False;
  aTitle := trim(aTitle);
  if CompareText('Front View', aTitle) = 0 then
    result := True
  else if CompareText('Street View', aTitle) = 0 then
    result := True
  else if CompareText('Rear View', aTitle) = 0 then
    result := True;
end;

//Ticket #1389: This is for the bottom section of Subject extra photo scroll box, since TScrollBox the MouseWheel event is not working
//What I did was to do the MouseWheel in the form level and detect that the active page is Subject Photo page.
//We need to set the Vertical scroll bar range = to the base panel height and depends on the wheelDelta up/down to set the position.
procedure TInspectionDetail.FormMouseWheel(Sender: TObject;
  Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
  var Handled: Boolean);
begin
  inherited;
  if PageControl.ActivePage = tabSubjPhotos then
    begin
      BotPhotoSection.VertScrollBar.Range := BotBasePanel.Height;
      if WheelDelta > 0 then
        begin
          BotPhotoSection.VertScrollBar.Position := BotPhotoSection.VertScrollBar.Position - BotPhotoSection.VertScrollBar.Increment;
        end
      else
        begin
          BotPhotoSection.VertScrollBar.Position := BotPhotoSection.VertScrollBar.Position + BotPhotoSection.VertScrollBar.Increment;
        end;
      Handled := True;
    end
  else if PageControl.ActivePage = tabCompPhotos then
    begin
      PhotoDisplayComps.VertScrollBar.Range := CompBasePanel.Height;
      ScrollBox2.VertScrollBar.Range        := CompBasePanel.Height;
      if WheelDelta > 0 then
        begin
          PhotoDisplayComps.VertScrollBar.Position := PhotoDisplayComps.VertScrollBar.Position - PhotoDisplayComps.VertScrollBar.Increment;
          ScrollBox2.VertScrollBar.Position := ScrollBox2.VertScrollBar.Position - ScrollBox2.VertScrollBar.Increment;
        end
      else
        begin
          PhotoDisplayComps.VertScrollBar.Position := PhotoDisplayComps.VertScrollBar.Position + PhotoDisplayComps.VertScrollBar.Increment;
          ScrollBox2.VertScrollBar.Position        := ScrollBox2.VertScrollBar.Position + ScrollBox2.VertScrollBar.Increment;
        end;
      Handled := True;
    end;
end;

procedure LoadNameList(aFieldName:String; Sketcher_Meta_Data:TlkJSonBase; var aList:TStringList);
var
  GLANames: TlkJSonBase;
  Item1,Item2,Item: String;
  i: Integer;
begin
  if Sketcher_Meta_Data.Field[aFieldName] <> nil then
    GLANames := Sketcher_Meta_Data.Field[aFieldName];
  if GLANames <> nil then
    begin
      aList.Clear;
      for i:= 0 to GLANames.Count -1 do
        begin
          Item1 := trim(varToStr(GLANames.Child[i].Field['Item1'].Value));
          Item2 := trim(varToStr(GLANames.Child[i].Field['Item2'].Value));
          Item := Format('%s=%s',[Item1,Item2]);
         // aList.Add(Item1);
          aList.Add(Item);
        end;
    end;
end;

//Note: we need to use the content from the Texts node to match with the sketch area dimension label than using the LengthFt in Areas
function LocateContentFromTexts(Texts: TlkJSonBase; DimensionTextId:String):String;
var
  i: Integer;
  Id: String;
  IsDimension, IsAreaTitle:Boolean;
  aInt: Integer;
begin
  result := '';
  for i:= 0 to Texts.Count - 1 do
    begin
      Id := Trim(VarToStr(Texts.Child[i].Field['Id'].Value));
      if CompareText(Id, DimensionTextId) = 0 then //we found it
        begin
          IsDimension := Texts.Child[i].Field['IsDimension'].Value <> 0;
          IsAreaTitle := Texts.Child[i].Field['IsAreaTitle'].Value <> 0;
          if IsDimension {and not IsAreaTitle} then
            begin
              result := Trim(VarToStr(Texts.Child[i].Field['Content'].Value));
              break;
            end;
        end;
    end;

end;
procedure LoadDimensionList(Texts, Edges:TlkJSonBase; var WList,HList:TStringList);
var
  k: Integer;
  EdgesItem: TLkJSonBase;
  IsHorizontal, IsVertical, IsUsed: Boolean;
  LengthFt,DimensionTextId,Id, Content: String;
begin
  WList.Clear;  //clear the width dimension list before we add
  HList.Clear;  //clear the height dimension list before we add
  for k:= 0 to Edges.Count -1 do
    begin
      EdgesItem := Edges.Child[k];
      if EdgesItem <> nil then
        begin
          DimensionTextId := trim(varToStr(EdgesItem.Field['DimensionTextId'].Value));
          IsUsed := EdgesItem.Field['IsUsed'].Value <> 0;
          if not IsUsed then  //only fetch if isUsed is True
            Continue;
          IsHorizontal := EdgesItem.Field['IsHorizontal'].Value <> 0;
          IsVertical   := EdgesItem.Field['IsVertical'].Value <> 0;

          Content := LocateContentFromTexts(Texts, DimensionTextId);
          if GetStrValue(Content) > 0 then
            LengthFt := Content
          else
            LengthFt := varToStr(EdgesItem.Field['LengthFt'].Value);

          if isHorizontal then           //this is the width
            begin
              WList.Add(LengthFt);       //add to width list
              WList.CustomSort(MySort);  //sort in ascending numeric order
            end
          else if isVertical then        //this is the height
            begin
              HList.Add(LengthFt);       //add to height list
              HList.CustomSort(MySort);  //sort in ascending numeric order
            end;
        end;
      end; //for Edges
end;

function GetAreaSqftFromTexts(Texts: TlkJsonBase; TextId: String):String;
var
  k: Integer;
  isAreaTitle: Boolean;
  id: String;
begin
  result := '';
  for k:= 0 to Texts.Count -1 do
    begin
      IsAreaTitle := Texts.Child[k].Field['IsAreaTitle'].Value <> 0;
//      if IsAreaTitle then
        begin
          id := Trim(varToStr(Texts.Child[k].Field['Id'].Value));
          if CompareText(id, TextId) = 0 then
            begin
              result := Trim(varToStr(Texts.child[k].Field['ContentLine2'].Value));
              break;
            end;
        end;
    end;
end;

//Fill in GLA entries
function TInspectionDetail.PopulateGLAEntries(thisForm: TDocFOrm; AreaName, aArea:String; GLANameList,wList, hList:TStringList; var rowCount:Integer; var SumGLA:Double):Boolean;
const
  idGla             = 13;
  idBasement        = 15;
  idLevel1          = 17;
  idLevel2          = 19;
  idLevel3          = 21;
  idGarage          = 23;
  idOther           = 25;   //can be patio, deck, etc...
var
  aCnt: Integer;
  aAreaName,aItem: String;
  AreaCellID, TypeCellID, LevelCellID: Integer;
  GLA, aFactor: Double;
  aWidth, aHeight: String;
  sumGLA_Calc: Double;
  GBA:Double;
begin
  //Do we have living area?
  result := False;
  FAreaSqftList.Clear;
  for aCnt := 0 to GLANameList.Count -1 do   //walk through the GLA list
    begin
      aItem := GLANameList[aCnt];
      aAreaName := popStr(aItem,'=');
      aItem     := trim(aItem);
      FAreaSqftList.Add(aItem);
    end;
  FAreaSqftList.CustomSort(MySort);  //sort in ascending numeric order

  for aCnt := 0 to GLANameList.Count -1 do   //walk through the GLA list
    begin
      aItem := GLANameList[aCnt];
      aAreaName := popStr(aItem,'=');
      aItem     := trim(aItem);
      FAreaSqft := GetStrValue(aItem);
      aAreaName := trim(aAreaName);

      if CompareText(aAreaName, AreaName) <> 0 then continue;
      if (wList.Count > 0) and (HList.Count > 0) then
        begin
          result := True;
          aWidth := WList[WList.Count -1];   //get the last one in the list
          aHeight := HList[HList.Count -1];
          AreaCellID := AreaCellIDs[rowCount];
          TypeCellID := TypeCellIDs[rowCount];
          LevelCellID := LevelCellIDs[rowCount];
          inc(rowCount);

          thisForm.SetCellValue(1, AreaCellID, GetStrValue(aWidth));
          thisForm.SetCellValue(1, AreaCellID+1, GetStrValue(aHeight));
          GLA := GetStrValue(aArea);
          if GLA = 0 then
            GLA := FAreaSqft;
          if GLA > 0 then
            begin
              aFactor := GLA/(GetStrValue(aWidth) *GetStrValue(aHeight));
              thisForm.SetCellValue(1, AreaCellID+2, aFactor);
              thisForm.SetCellValue(1, AreaCellID+3, GLA);
              thisForm.SetCellData(1, TypeCellID, 'X');
              if IsMainFloor(aAreaName, round(GLA)) then
                begin
                 // SumGLA := SumGLA + GLA;
                  FGLAsqft := FGLAsqft + GLA;

                  SumGLA := SumGLA + GLA;
                  thisForm.SetCellData(1, LevelCellID, 'X');  //level 1
                  thisForm.SetCellValue(1, idLevel1, FGLASqft);
                end
              else if IsSecondFloor(aAreaName) then
                begin
                  SumGLA := SumGLA + GLA;
                  thisForm.SetCellData(1, LevelCellID+1, 'X');  //level 2
                  thisForm.SetCellValue(1, idLevel2, GLA);
                end
              else if IsThirdFloor(aAreaName) then
                begin
                  SumGLA := SumGLA + GLA;
                  thisForm.SetCellData(1, LevelCellID+2, 'X');  //level 3
                  thisForm.SetCellValue(1, idLevel3, GLA);
                end
              else if IsBasement(aAreaName) then
                begin
                  SumGLA := SumGLA + GLA;
                  thisForm.SetCellValue(1, idBasement, GLA);
                  thisForm.SetCellData(1, TypeCellID+1, 'X');   //basement
                end
              else if IsGarage(aAreaName) then
                begin
                  //use sqft to calculate
                  if (FAreaSqft < 0) and (abs(Round(FAreaSqft)) = GetValidInteger(aArea)) then //we only do the negative for non gla so we can subtract from main gla
                    begin
                      SumGLA := SumGLA + FAreaSqft;
                      FGLAsqft := FGLAsqft + FAreaSqft;
                    end;
                  FSumGarage := FSumGarage + GLA;
                  //thisForm.SetCellValue(1, idGarage, GLA);
                  thisForm.SetCellValue(1, idGarage, FSumGarage);
                  thisForm.SetCellData(1, TypeCellID+2, 'X');  //garage
                  thisForm.SetCellValue(1, idLevel1, FGLASqft);

                  //To calculate the sum of GLA, we sum up these 3 cell values: 17, 19,and 21
                  sumGLA_Calc := FGLASqft + thisForm.GetCellValue(1, idLevel2) + thisForm.GetCellValue(1, idLevel3);
                  //Put the result of GLA to cell #13 on form #705
                  if sumGLA_Calc > 0 then
                    thisForm.SetCellValue(1, idGLA, sumGLA_Calc)
                  else
                    thisForm.SetCellValue(1, idGLA, SumGLA);
                end
              else  //others
                begin
                  FSumOtherSqft := FSumOtherSqft + GLA;
                  //thisForm.SetCellValue(1, idOther, GLA);
                  thisForm.SetCellValue(1, idOther, FSumOtherSqft);
                  thisForm.SetCellData(1, TypeCellID+3, 'X');
                  if FAreaSqft < 0 then
                    begin
                      FGLASqft := FGLASqft + FAreaSqft;
                      thisForm.SetCellValue(1, idLevel1, FGLASqft);
                    end;
                end
            end; //end of GLA
            break;
       end;
  end;
end;

//Fill in Non GLA entries
function TInspectionDetail.PopulateNonGLAEntries(thisForm: TDocFOrm; AreaName, aArea:String; NonGLANameList,wList, hList:TStringList; var rowCount:Integer):Boolean;
const
  idBasement        = 15;
  idGarage          = 23;
  idOther           = 25;   //can be patio, deck, etc...
var
  aCnt: Integer;
  aAreaName,aItem: String;
  AreaCellID, TypeCellID, LevelCellID: Integer;
  NonGLA, aFactor: Double;
  aWidth, aHeight: String;
begin
  //Do we have Non GLA living area?
  result := False;
  for aCnt := 0 to NonGLANameList.Count -1 do   //walk through the GLA list
    begin
      aItem     := NonGLANameList[aCnt];
      aAreaName := popStr(aItem,'=');
      FAreaSqft := GetStrValue(aItem);
      aAreaName := trim(aAreaName);
//      aAreaName := NonGLANameList[aCnt];
//      aAreaName := trim(aAreaName);
      if CompareText(aAreaName, AreaName) <> 0 then continue;
      if (wList.Count > 0) and (HList.Count > 0) then
        begin
          result := True;
          aWidth := WList[WList.Count -1];   //get the last one in the list
          aHeight := HList[HList.Count -1];
          AreaCellID := AreaCellIDs[rowCount];
          TypeCellID := TypeCellIDs[rowCount];
          LevelCellID := LevelCellIDs[rowCount];
          inc(rowCount);

          thisForm.SetCellValue(1, AreaCellID, GetStrValue(aWidth));
          thisForm.SetCellValue(1, AreaCellID+1, GetStrValue(aHeight));
          NonGLA := GetStrValue(aArea);
          if NonGLA > 0 then
            begin
              aFactor := NonGLA/(GetStrValue(aWidth) *GetStrValue(aHeight));
              thisForm.SetCellValue(1, AreaCellID+2, aFactor);
              thisForm.SetCellValue(1, AreaCellID+3, NonGLA);
              thisForm.SetCellData(1, TypeCellID, 'X');
              if IsBasement(aAreaName) then
                begin
                  thisForm.SetCellValue(1, idBasement, NonGLA);
                  thisForm.SetCellData(1, TypeCellID+1, 'X');   //basement
                end
              else if IsGarage(aAreaName) then
                begin
                  FSumGarage := FSumGarage + NonGLA;
                  thisForm.SetCellValue(1, idGarage, FSumGarage);
                  //thisForm.SetCellValue(1, idGarage, NonGLA);
                  thisForm.SetCellData(1, TypeCellID+2, 'X');  //garage
                end
              else
                begin
                  FSumOtherSqft := FSumOtherSqft + NonGLA;
                  thisForm.SetCellValue(1, idOther, FSumOtherSqft);
                  thisForm.SetCellData(1, TypeCellID+3, 'X');  //Other
                end;
            end; //end of Non GLA
            break;
       end;
  end;
end;

//Ticket #1404: load sketch definition to Dimension list
procedure TInspectionDetail.ImportSketchDefinitionToReport(joSketchData: TlkJSonBase);
const
  cidGla             = 232;
  cidGlaCost         = 877;
  cidGarage          = 893;
  cidBasement2Label  = 880;
  cidBasement        = 200;
  cidBasement1       = 250;
  cidBasement2       = 881;


  SketchDimensionformID = 705;
  idGLA    = 13;
  idLevel1 = 17;
  idLevel2 = 19;
  idLevel3 = 21;
  idGarage = 23;
  idBsmt   = 15;
  idArea   = 27;  //start from cell #27
var
  f, i, j: Integer;
//  sl:TStringList;   //a temp list for debugging
  WList, HList: TStringList;  //List to hold the lengthFt for Horizontal and Vertical
  thisForm: TDocForm;
  Sketcher_Meta_Data,Sketcher_Definition_Data: TlkJSonBase;
  GLANames, NonGLANames: TlkJSonBase;
  GLAItems, NonGLAItems: TlkJSonBase;
  Areas, Edges, EdgesItem, Texts, TextsItem: TlkJSonBase;
  sketchDefinitionData, SketchData: String;  //github #761
  AreaData,TextId, AreaName, aArea, TextsId, aTempFile, aSumStr: String;
  aDouble,SumGLA,GLA : Double;
  RowCount, AreaCellID, TypeCellID, LevelCellID: Integer;
  aOK, IsNew:Boolean;
  GLASqft, BsmtSqft, GarSqft, aText: String;
  sumGLA_Calc: Double;
  GBA:Double;
begin
  if (joSketchdata = nil) or (joSketchdata.Count = 0)  then exit;
  if joSketchData.Field['Sketcher_Page_Count'] = nil then exit;       //PAM: Ticket #1415: do not create dimension list form if there's no sketch
  if joSketchData.Field['Sketcher_Page_Count'].Value = 0 then exit;

  //  sl := TStringList.Create;
  WList := TStringList.Create;   //list to hold width dimension
  HList := TStringList.Create;   //list to hold height dimension

  FSumGarage    := 0;
  FSumOtherSqft := 0;
  FGLASqft      := 0;
  RowCount := 0; //# of rows
  IsNew    := False;
  Try
    if not assigned(FDoc) then
      FDoc := main.ActiveContainer;
    if FOverwriteData then
      begin
        thisForm := FDoc.GetFormByOccurance(SketchDimensionformID, 0, false);
        if not assigned(thisForm) then
          thisForm := Fdoc.InsertBlankUID(TFormUID.Create(SketchDimensionformID), true, -1); //always insert
      end
    else
      begin
        isNew := True;
        thisForm := Fdoc.InsertBlankUID(TFormUID.Create(SketchDimensionformID), true, -1); //always insert
      end;
    if not assigned(thisForm) then exit;
    if FOverwriteData then
      thisForm.ClearFormText;   //Ticket #1360
    if IsNew or FOverwriteData then
      begin
    //Fill in the header section
    thisForm.SetCellData(1, 2, FDoc.GetCellTextByID(2));
    thisForm.SetCellData(1, 3, FDoc.GetCellTextByID(3));
    thisForm.SetCellData(1, 4, FDoc.GetCellTextByID(4));
    thisForm.SetCellData(1, 5, FDoc.GetCellTextByID(45));
    thisForm.SetCellData(1, 6, FDoc.GetCellTextByID(46));
    thisForm.SetCellData(1, 7, FDoc.GetCellTextByID(47));
    thisForm.SetCellData(1, 8, FDoc.GetCellTextByID(50));
    thisForm.SetCellData(1, 9, FDoc.GetCellTextByID(48));
    thisForm.SetCellData(1, 10, FDoc.GetCellTextByID(49));
    thisForm.SetCellData(1, 11, FDoc.GetCellTextByID(35));
    thisForm.SetCellData(1, 12, FDoc.GetCellTextByID(36));

    FSketch_Data := TlkJSON.GenerateText(joSketchData);
    if joSketchdata.Field['Sketcher_Meta_Data'] <> nil then
      Sketcher_Meta_Data := joSketchdata.Field['Sketcher_Meta_Data'];  //we have sketch meta data from DATA server, use it
    if Sketcher_Meta_Data = nil then exit;  //if no sketch meta data in DATA server, use the one in IMAGE server which is in

    //Load GLA/Non GLA area names to list
    LoadNameList('GlaNames',Sketcher_Meta_Data, FGLANames);
    LoadNameList('NonGlaNames',Sketcher_Meta_Data, FNonGLANames);

    //This is for Sketcher_Definition_Data section
    if Sketcher_Meta_Data.Field['Sketcher_Definition_Data'] <> nil then
      Sketcher_Definition_Data := Sketcher_Meta_Data.Field['Sketcher_Definition_Data'];
    if Sketcher_Definition_Data <> nil then
      begin
        SketchData := TlkJSON.GenerateText(Sketcher_Definition_Data);
        //For debug only
//        sl.text := SketchData;
//        sl.SaveToFile('c:\temp\Sketcher_Definition_Data.txt');
        //For Sketcher_Definition_Data

        SumGLA := 0;
        for i  := 0 to Sketcher_Definition_Data.Count -1 do  //Look up Sketcher_Definition_Data json
          begin
            Areas := Sketcher_Definition_Data.Child[i].Field['Areas'];
            Texts := Sketcher_Definition_Data.Child[i].Field['Texts'];

            if Areas <> nil then //we have areas
              begin
                AreaData := TlkJSON.GenerateText(Areas);
                AreaCellID := idArea;   //the first cell id of Area
                for j:= 0 to Areas.Count -1 do //loop through the areas list
                  begin
                    AreaName := trim(varToStr(Areas.Child[j].Field['Name'].Value)); //This is the area name
                    TextId   := trim(varToStr(Areas.Child[j].Field['TextId'].Value));  //This is the unique id of the individual area
                    Edges := Areas.Child[j].Field['Edges'];

                    if Edges <> nil then
                      begin
                        LoadDimensionList(Texts,Edges, WList, HList);
                        aArea := GetAreaSqftFromTexts(Texts, TextId);

                        aOK := False;  //init to False
                        if FGLANames.Count > 0 then
                          aOK := PopulateGLAEntries(thisForm, AreaName, aArea, FGLANames, wList, hList, rowCount, SumGLA);

                        if not aOK and (FNonGLANames.Count > 0) then
                          aOK := PopulateNonGLAEntries(thisForm, AreaName, aArea, FNonGLANames, wList, hList, rowCount);
                      end;  //nil
                  end; //for j
              end; //Areas not nil
          end; //for areas
          sumGLA_Calc := thisForm.GetCellValue(1, idLevel1) + thisForm.GetCellValue(1, idLevel2) + thisForm.GetCellValue(1, idLevel3);
          if sumGLA_Calc > 0 then
            thisForm.SetCellValue(1,idGLA,sumGLA_Calc)
          else
            thisForm.SetCellValue(1, idGLA, sumGLA);


          //Now bring the gla and bsmt to the form
          GLASqft := thisForm.GetCellText(1, idGLA); //get level 1 gla
          if GetValidInteger(GLASqft) > 0 then
            begin
              FDoc.SetCellTextByID(cidGLA, GLASqft);
              FDoc.SetCellTextByID(cidGlaCost, GLASqft);

              //SetCellTextByCellID(cidGla, GLASqft);
             // SetCellTextByCellID(cidGlaCost, GLASqft);
            end;

          GarSqft := thisForm.GetCellText(1, idGarage);
          if GetValidInteger(GarSqft) > 0 then
            SetCellTextByCellID(cidGarage, GarSqft, True);


          BsmtSqft := thisForm.GetCellText(1, idBsmt);
          if getValidInteger(BsmtSqft) > 0 then
            begin
              SetCellTextByCellID(cidBasement,BsmtSqft, True);
              SetCellTextByCellID(cidBasement1,BsmtSqft, True);
              SetCellTextByCellID(cidBasement2Label, 'Basement', True);
              SetCellTextByCellID(cidBasement2,BsmtSqft, True);
                end;
            end;

          //Ticket #1472: after we calculate LV1, LV2, LV3, GV, OV, BV values, we need to sum up to get GBA area
          if thisForm.FormID = SketchDimensionformID then
            begin
              GBA := thisForm.GetCellValue(1, 15)+ thisForm.GetCellValue(1, 17) + thisForm.GetCellValue(1, 19) +
                     thisForm.GetCellValue(1, 21) + thisForm.GetCellValue(1, 23) + thisForm.GetCellValue(1, 25);
              thisForm.SetCellValue(1,14, GBA);
            end;
      end; //Sketcher_Definition_Data not nil
    finally
//      sl.Free;
      WList.Free;
      HList.Free;

      if assigned(Sketcher_Definition_Data) then
        FreeAndNil(Sketcher_Definition_Data);
    end;
end;


procedure TInspectionDetail.DownloadSketchMdataJson2(joSketchData: TlkJSonBase; thisForm: TDocForm; {cell:TSketchCell; }pageNo:Integer);
const
  SketchformID = 4177;
  SketchFormID2 = 201;

  GLACellStartID    = 14;
  NonGLACellStartID = 33;

  idGla             = 232;
  idGlaCost         = 877;
  idGarage          = 893;
  idBasement        = 200;
  idBasement1       = 250;

  idBasement2       = 881;

  idBasement2Label  = 880;



  FONT_NAME = 'Helvetica';
  FONT_SIZE = 10;

  cSketchFileName     = 'TempSketch.xml';      //this is file AS looks for on startup, if from previous sketch

var
  areas: SketchAreas;
  i, aCellID: Integer;
  aName, strValue: String;
  aValue,aSum: Integer;
  GLANames, NonGLANames: TlkJSonBase;
  GLAItems, NonGLAItems: TlkJSonBase;
  BaseCell: TBaseCell;
  aCellValue: String;
  aFinishArea: Integer;
  js_Sketch_Definition: TlkJSonBase; //github #761
  sketchDefinitionData, xmlFile: String;  //github #761
  sl:TStringList;
  aItem,aTitle:String;
  n:integer;
begin
try
  if not assigned(thisForm) then exit;
  if (joSketchdata = nil) or (joSketchdata.Count = 0) then exit;
  //download sketch meta data
  if PageNo = 1 then
    begin
      //This is for GLA Names section
      if joSketchdata.Field['GlaNames'] <> nil then
        GLANames := joSketchdata.Field['GlaNames'];
        if GLANames <> nil then
          begin
            aSum := 0;
            try
              //For GLA Area
              aCellID := GLACellStartID;
              for i  := 0 to GLANames.Count -1 do
                begin
                  GLAItems := GLANames.Child[i];
                  if GLAItems <> nil then
                    begin
                      if GLAItems.Field['Item1'] <> nil then
                        aName := VarToStr(GLAItems.Field['Item1'].Value);
                      if GLAItems.Field['Item2'] <> nil then
                        begin
                          aValue := GLAItems.Field['Item2'].Value;
                          aItem := Format('%s=%d',[aName,aValue]);
                          FAreaList.Add(aItem);
                        end;
                    end;
                  if aValue = 0 then continue;
                  thisForm.SetCellText(1,aCellID, aName);
                  strValue := Format('%d',[aValue]);
                  Basecell := thisForm.frmPage[0].pgData[aCellID];
                 // BaseCell.TextJust := tjJustRight;
                  thisForm.SetCellText(1,aCellID+1, strValue);
                  //do the transfering to other cell for the main form
                  if pos('GARAGE',UpperCase(aName)) > 0 then
                    begin
                      SetCellTextByCellID(idGarage,strValue, True);
                    end
                  else if (pos('BASE', UpperCase(aName)) > 0) or (pos('BSM', UpperCase(aName)) >0) then
                    begin
                      if strValue <> '' then
                        begin
                          SetCellTextByCellID(idBasement,strValue, True);
                          SetCellTextByCellID(idBasement1,strValue, True);
                          SetCellTextByCellID(idBasement2Label, 'Basement', True);
                          SetCellTextByCellID(idBasement2,strValue, True);
                          //Basement  need to recalculate the basement cell 1006 on the grid
                          FSubjectData2.TotalArea := strValue;
                          SetCellTextByCellID(200, FSubjectData2.TotalArea);
                          if FSubjectData2.FinishedPercent > 0 then
                            SetCellTextByCellID(201, Format('%d',[FSubjectData2.FinishedPercent]));
                          if GetValidInteger(FSubjectData2.TotalArea) > 0 then
                            begin
                              aFinishArea := CalcFinishedArea2(GetValidInteger(FSubjectData2.TotalArea), FSubjectData2.FinishedPercent);
                              if FSubjectData2.AccessMethodWalkUp then
                                FSubjectData2.BasementAccess := 'wu'
                              else if FSubjectData2.AccessMethodWalkOut then
                                FSubjectData2.BasementAccess := 'wo'
                              else if FSubjectData2.AccessMethodInteriorOnly then
                                FSubjectData2.BasementAccess := 'in';

                              if FSubjectData2.AccessMethodWalkUp or FSubjectData2.AccessMethodWalkOut then
                                SetCellTextByCellID(208, 'X');

                              if FSubjectData2.FinishedPercent > 0 then
                                begin
                                  aCellValue := Format('%ssf%dsf%s',[FSubjectData2.TotalArea, aFinishArea, FSubjectData2.BasementAccess]);   //TotalAreasfFinishAreasfAccess
                                end
                              else
                                 aCellValue := Format('%ssf0sf%s',[FSubjectData2.TotalArea, FSubjectData2.BasementAccess]);

                             ImportGridData(0, FDoc, '1006', aCellValue, FDocCompTable);
                           end;
                        end;
                    end;
                  aSum := aSum + aValue;
                  aCellID := aCellID + 2;
                end;
                if aSum > 0  then
                begin
                  strValue := Format('%d',[aSum]);
                  Basecell := thisForm.frmPage[0].pgData[31];
                  if BaseCell <> nil then
                    begin
                      SetCellFont(baseCell, 1,FONT_NAME, FONT_SIZE);    //set to 1 = bold
                      BaseCell.Text := strValue;
                      //BaseCell.TextJust := tjJustRight;
                    end;
                  SetCellTextByCellID(idGla,strValue);
                  SetCellTextByCellID(idGlaCost,strValue);
                end;
            finally
              if assigned(GLANames) then
                FreeAndNil(GLANames);
            end;
        end;
        //This is for Non GLA Names section
      if joSketchdata.Field['NonGlaNames'] <> nil then
        NonGLANames := joSketchdata.Field['NonGlaNames'];
        if NonGLANames <> nil then
          begin
            try
              //For Non GLA Area
              aCellID := NonGLACellStartID;
              for i  := 0 to NonGLANames.Count -1 do
                begin
                  NonGLAItems := NonGLANames.Child[i];
                  if NonGLAItems <> nil then
                    begin
                      if NonGLAItems.Field['Item1'] <> nil then
                        aName := VarToStr(NonGLAItems.Field['Item1'].Value);
                      if NonGLAItems.Field['Item2'] <> nil then
                        begin
                          aValue := NonGLAItems.Field['Item2'].Value;
                          aItem := Format('%s=%d',[aName,aValue]);
                          for n:= 0 to FAreaList.count -1 do
                            begin
                              aItem := trim(FAreaList[n]);
                              aTitle := popStr(aItem,'=');
                              if compareText(trim(aTitle), trim(aName)) <> 0 then
                                FAreaList.Add(aItem);
                            end;
                        end;
                    end;
                  thisForm.SetCellText(1,aCellID, aName);
                  strValue := Format('%d',[aValue]);
                  Basecell := thisForm.frmPage[0].pgData[aCellID];
                  //BaseCell.TextJust := tjJustRight;
                  thisForm.SetCellText(1,aCellID+1, strValue);
                  //do the transfering to other cell for the main form
                  if pos('GARAGE',UpperCase(aName)) > 0 then
                    begin
                      SetCellTextByCellID(idGarage,strValue, True);
                    end
                  else if (pos('BASE', UpperCase(aName)) > 0) or (pos('BSM', UpperCase(aName)) >0) then
                    begin
                      if strValue <> '' then
                        begin
                          SetCellTextByCellID(idBasement,strValue, True);
                          SetCellTextByCellID(idBasement1,strValue, True);
                          SetCellTextByCellID(idBasement2Label, 'Basement', True);
                          SetCellTextByCellID(idBasement2,strValue, True);
                          FSubjectData2.TotalArea := strValue;
                          if GetValidInteger(FSubjectData2.TotalArea) > 0 then
                            begin
                              aFinishArea := CalcFinishedArea2(GetValidInteger(FSubjectData2.TotalArea), FSubjectData2.FinishedPercent);
                              if FSubjectData2.AccessMethodWalkUp then
                                FSubjectData2.BasementAccess := 'wu'
                              else if FSubjectData2.AccessMethodWalkOut then
                                FSubjectData2.BasementAccess := 'wo'
                              else if FSubjectData2.AccessMethodInteriorOnly then
                                FSubjectData2.BasementAccess := 'in';

                              if FSubjectData2.AccessMethodWalkUp or FSubjectData2.AccessMethodWalkOut then
                                SetCellTextByCellID(208, 'X');

                              if FSubjectData2.FinishedPercent > 0 then
                                begin
                                  aCellValue := Format('%ssf%dsf%s',[FSubjectData2.TotalArea, aFinishArea, FSubjectData2.BasementAccess]);   //TotalAreasfFinishAreasfAccess
                                end
                              else
                                 aCellValue := Format('%ssf0sf%s',[FSubjectData2.TotalArea, FSubjectData2.BasementAccess]);

                             ImportGridData(0, FDoc, '1006', aCellValue, FDocCompTable);
                            end;
                        end;
                    end;
                  aCellID := aCellID + 2;
                end;
            finally
              if assigned(NonGLANames) then
                FreeAndNil(NonGLANames);
            end;
          end;
    end;
except on E:Exception do
;//let it moves on to the next
end;
end;





end.
