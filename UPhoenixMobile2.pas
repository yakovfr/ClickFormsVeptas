unit UPhoenixMobile2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,UPhoenixMobileUtils, StdCtrls, Grids_ts, TSGrid, UlkJSON, TSDBGrid, Menus,
  UContainer, UForms, UCell, UForm, PhoenixMobileServer, MSXML6_TLB;

const
  prefNew = 'new ';
  colAddr = 1;
  colCity = 2;
  colState = 3;
  colZip = 4;
  colDate = 5;
  colID = 6;

  PhoenixMobileServerURL = 'https://webservices.appraisalworld.com/ws/awsi/PhoenixMobileServer.php?wsdl';
  PhoenixMobileserverPsw = '5DR34QD6MX0XTUTU82BP5Y8VTA846MPK4VKEDBTX6JSBJCLTU4I0D3J387WX58BR';

  errCode_Success              = 0;
  errCode_NoDLL                = -1;
  errCode_InValidCredential    = -2;
  errCode_NoReport             = -3;
  errCode_Fail                 = -4;
  errCode_InvalidToken         = -5;
  errCode_MemoryProblem        = -6;

type
  TPhoenixMobileService = class(TAdvancedForm)
    lbFolders: TListBox;
    tsgridFiles: TtsDBGrid;
    btnCreatefolder: TButton;
    btnDeleteFolder: TButton;
    btnDownload: TButton;
    btnDeleteFile: TButton;
    btnUpload: TButton;
    btnClose: TButton;
    procedure OnFormShow(Sender: TObject);
    procedure OnFolderClick(Sender: TObject);
    procedure OnFormDestroy(Sender: TObject);
    procedure OnCreateNewFolderClick(Sender: TObject);
    procedure OnDeleteFolderClick(Sender: TObject);
    procedure OnUploadReportClick(Sender: TObject);
    procedure OnRemoveFileClick(Sender: TObject);
    procedure OnTsGridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure OntsGridDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure OnlbFolderDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure OnlbFoldersDragdrop(Sender, Source: TObject; X, Y: Integer);
    procedure OnImportReportClick(Sender: TObject);
    procedure OnClose(Sender: TObject);

  private
    { Private declarations }
    FToken: String;
    FAccountID: String;
    FDoc: TContainer;
//    availUnits: Integer;  //Ticket #1344: no longer need to call service
    serviceAcknowl: WideString;
    FOverwriteData: Boolean;  //github 209
    procedure GetPhoenixFolders;
    procedure GetFolderFiles;
    procedure MoveFile(fileIndex, folderIndex: Integer);
    procedure ImportPhotos(jsReport: TlkJSONobject; PhoenixXML: String);
    function DownloadPhoenixMismo(reportID: String): String;
    function ImportSketches(reportID: String): SketchAreas;
//    function  GetAvailableUsage: integer;  //Ticket #1344: no longer need to call service
//    procedure UpdateUsage;    //Ticket #1344: no longer need to call service
    procedure GetContainerImportTo(jsReport: TlkJSONobject; var isAbort:Boolean);
    procedure ImportSubjectImage(strm: TStream; imageTag: String; PhoenixXML: String; var errMsg: String);
    procedure ImportSubjectExtraImage(strm: TStream; imageTag: String; PhoenixXML: String; var errMsg: String);
    procedure ImportCompImage(strm: TStream; imageTag: String; PhoenixXML: String; var errMsg: String);
    procedure ImportOtherImage(strm: TStream; imageTag: String; PhoenixXML: String; var errMsg: String);
    function ImportSketch(imageStrm: TMemoryStream; sketchNo: Integer; dataFileStrm: TMemoryStream): Boolean;
    procedure TransferSketchAreas(areas: SketchAreas);
  public
    { Public declarations }
    constructor FormCreate(AOwner: TComponent);
    property doc: TContainer read FDoc write FDoc;
    property token: String read FToken write FToken;
    property accountID: String read FAccountID write FAccountID;
    property OverwriteData: Boolean read FOverwriteData write FOverwriteData;  //github 209
  end;

var
  PhoenixMobileService: TPhoenixMobileService;

implementation
  {$R *.dfm}
uses UMain, UGlobals, Ustatus, ULicUser, UBase, UEditor,UUADImportMismo,
UCellMetaData, UWinUtils, uServices, uCustomerServices, uUADUtils;

 constructor TPhoenixMobileService.FormCreate(AOwner: TComponent);
begin
  inherited Create(AOwner);
  doc := TContainer(AOwner);
end;

procedure TPhoenixMobileService.OnFormShow(Sender: TObject);
begin
//  availUnits := GetAvailableUsage;  //Ticket #1344: no longer need to call service
  accountID := GetAccountID(token);
  btnCreateFolder.Enabled := true;
  btnClose.Enabled := true;
  btnDeleteFolder.Enabled := False;
  btnDeleteFile.Enabled := False;
  btnDownload.Enabled := false;
  btnUpload.Enabled := false;
  GetPhoenixFolders;
  if lbFolders.Count > 0 then
    GetFolderFiles;
end;   

procedure TPhoenixMobileService.GetPhoenixFolders;
var
  strFolders: String;
  errMsg: String;
  ls: TlkJSONlist;
  js:TlkJSONobject;
  contID: String;
  folder: Integer;
  strObj: TStringObject;
begin
  lbfolders.Clear;
  errMsg := '';
  strFolders := RGet(phoenixservices + fnGetContainers + token, errMsg);
  if Length(errMsg) > 0 then
    begin
      ShowAlert(atStopAlert, errMsg);
      btnDeleteFolder.Enabled := False;
      btnUpload.Enabled := false;
      exit;
    end;
  ls := TlkJSON.ParseText(strFolders) as TlkJSONlist;
  if ls.Count = 0 then  //no user's containers
    begin
      ShowNotice2('There are no folders on PhoenixMobile site for your account'); //github 214: bring to front
      exit;
    end;
  for folder := 1 to ls.Count do
    begin
      js := ls.Child[folder-1] as TlkJSONObject;
      contID := vartostr(js.Field['PartitionKey'].Value);
      if length(contID) > 0 then
        begin
          strObj := TStringObject.Create;
          strObj.str := contID;
          lbFolders.Items.AddObject(vartostr(js.Field['name'].Value), strObj);
        end;
    end;
    lbFolders.ItemIndex := 0;
    GetFolderFiles;
    tsgridFiles.ClearAll;
    tsgridFiles.Rows := 0;
    btnUpload.Enabled := assigned(doc) and (doc.docForm.Count > 0);
    btnDeleteFolder.Enabled := true;
end;

procedure TPhoenixMobileService.OnFolderClick(Sender: TObject);
var
  rowIndex: Integer;
begin
  rowIndex := lbFolders.ItemIndex;
  if rowIndex < 0 then
    exit;
  GetFolderFiles;
end;

procedure TPhoenixMobileService.GetFolderFiles;
var
  strFiles: String;
  errMsg: string;
  ls: TlkJSONList;
  fIndex: Integer;
  js: TlkJSONObject;
  bPaid: Boolean;
  modifiedDate: String;
  folderID: String;
  folderName: String;
begin
  if lbFolders.ItemIndex < 0 then
    exit;
  folderName := lbFolders.Items[lbFolders.itemIndex];
  folderID := TStringObject(lbFolders.Items.Objects[lbFolders.itemIndex]).str;
  tsgridFiles.ClearAll;
  tsgridFiles.Rows := 0;
  errMsg := '';
  strFiles := RGet(phoenixServices + format(fnContainerFiles,[folderID]) + Token, errMsg);
  if length(errMsg) > 0 then
    begin
      ShowAlert(atStopAlert,errMsg);
      exit;
    end;
   ls := TlkJSON.ParseText(strFiles) as TlkJSONList;
   if ls.count = 0 then
    begin
      //ShowNotice('The folder ' + folderName + ' is empty!');
      btnDeleteFile.Enabled := false;
      btnDownload.Enabled := false;
      exit;
    end;
    tsGridFiles.Rows := ls.Count;
    with tsgridFiles do
      begin
        for fIndex := 1 to ls.Count do
        begin
          js := ls.Child[fIndex - 1] as TlkJSONObject;
          cell[colAddr,fIndex] := vartostr(js.Field['address1'].Value);
          cell[colCity,fIndex] := vartostr(js.Field['city'].Value);
          cell[colState,fIndex] := vartostr(js.Field['state'].Value);
          cell[colZip,fIndex] := vartostr(js.Field['postal'].Value);
          bPaid := js.getBoolean(js.IndexOfName('paid'));
          modifiedDate := convertPhoenixDate(vartostr(js.Field['modifiedByDate'].Value));
          if bPaid then
            cell[colDate, fIndex] := modifiedDate
          else
            cell[colDate,fIndex] := prefNew + modifiedDate;
            cell[colID,fIndex] := vartostr(js.Field['RowKey'].Value);
        end;
        CurrentDataRow := 1;
        SelectRows(CurrentDataRow,CurrentDataRow,true);
      end;
      btnDeleteFile.Enabled := true;
      btnDownload.Enabled := true;
end;

procedure TPhoenixMobileService.OnFormDestroy(Sender: TObject);
var
 index: Integer;
 url: String;
 strRequest: String;
 jsObj: TlkJSONObject;
 errMsg: String;
begin
 //clean string objects
 for index := 0 to lbFolders.Count - 1 do
    if assigned(lbFolders.Items.Objects[index]) then
      TStringObject(lbFolders.Items.Objects[index]).Free;
 //logout
 jsObj := TlkJSONObject.Create;
 jsObj.Add('token',token);
 strRequest := TlkJSON.GenerateText(jsObj);
 url := phoenixServices + fnLogout;
 errMsg := '';
 RPost(url,strRequest,errMsg);
end;

procedure TPhoenixMobileService.OnCreateNewFolderClick(Sender: TObject);
var
  jsObj, jsContainer: TlkJSONObject;
  jsRequest, jsResponse: String;
  folderName: String;
  errMsg: String;
  url: String;
begin
  if length(accountID) = 0 then
  begin
    ShowAlert(atStopAlert, 'The user doesnot have account with owner priveleges!');
    exit;
  end;
  folderName := InputBox('New Folder', 'Input folder name','');
  if length(folderName) = 0 then
    exit;
  PushMouseCursor(crHourglass);
  try
    jsContainer := TlkJSONObject.Create(true);
    jsContainer.Add('name',folderName);
    jsContainer.Add('numberOfFiles',0);
    jsObj := TlkJSONObject.Create(true);
    jsObj.Add('container',jsContainer);
    jsObj.Add('token',token);
    jsRequest := TlkJSON.GenerateText(jsObj);

    errMsg := '';
    url := phoenixServices + format(fnCreateContainer,[accountID]);
    jsResponse := RPost(url,jsRequest,errMsg);
    if length(errMsg) > 0 then
    begin
      ShowAlert(atStopAlert, errMsg);
      exit;
    end;
    GetPhoenixFolders;
  finally
    PopMousecursor;
  end;
end;

procedure TPhoenixMobileService.OnDeleteFolderClick(Sender: TObject);
var
  jsObj: TlkJSONObject;
  containerID: String;
  errMsg: String;
  jsStr: String;
  url: String;
begin
  if lbFolders.ItemIndex < 0 then //no selected folder
    exit;
  errMsg := '';
  if not OK2Continue('Are you sure you want to delete the folder and all files in it?') then
    exit;
  PushMouseCursor(crHourglass);
  try
    containerID := TStringObject(lbFolders.Items.Objects[lbFolders.itemIndex]).str;
    jsObj := TlkJSONObject.Create(true);
    jsObj.Add('token',token);
    jsStr := TlkJSON.GenerateText(jsObj);
    url := phoenixServices + format(fnDeleteContainer,[containerID]);
    RPost(url,jsStr, errMsg);
    if length(errMsg) > 0 then
    begin
      ShowAlert(atStopAlert, 'Cannot delete the folder!');
      exit;
    end;
    GetPhoenixFolders;
  finally
    PopMouseCursor;
  end;
end;

procedure TPhoenixMobileService.OnUploadReportClick(Sender: TObject);
var
  containerID: String;
  url: String;
  strm: TMemoryStream;
  errMsg: String;
  response: String;
  strMismo: String;
begin
  if lbFolders.itemIndex < 0 then
    begin
      ShowNotice2('You have to select the folder to upload into!');  //github 214: bring to front
      exit;
    end;
  PushMouseCursor(crHourglass);
  try
    strMismo := CreatePhoenixMismo(doc);
    if length(strMismo) = 0 then
    begin
      ShowAlert(atStopAlert, 'Cannot create MISMO XML for the current report!');
      exit;
    end;
    containerID := TStringObject(lbFolders.Items.Objects[lbFolders.itemIndex]).str;
    url := phoenixServices + format(fnMismo,[containerID,token]);
    strm := TMemoryStream.Create;
    try
      strm.Write(PChar(strMismo)^,length(strMismo));
      errMsg := '';
      response := RPostStream(url,strm,errMsg);
      if length(errMsg) > 0 then
        Showalert(atStopAlert, errMsg)
      else
      GetFolderFiles;
    finally
      strm.Free;
    end;
  finally
    PopMouseCursor;
  end;
end;

procedure TPhoenixMobileService.OnRemoveFileClick(Sender: TObject);
var
  url: String;
  fileID: String;
  errMsg: String;
  jsObj: TlkJSONObject;
  jsRequest,jsResponse: String;
begin
   if tsgridFiles.CurrentDataRow <= 0 then
    exit;
   PushMouseCursor(crHourglass);
   try
    fileID := tsGridfiles.Cell[colID,tsGridFiles.CurrentDataRow];
    url := phoenixServices + format(fnDeleteFile,[fileID]);
    jsObj := TlkJSONObject.Create(true);
    jsObj.Add('token',token);
    jsRequest := TlkJSON.GenerateText(jsObj);
    errMsg := '';
    jsResponse := RPost(url,jsRequest,errMsg);
    if length(errMsg) > 0 then
      begin
        ShowAlert(atStopAlert, errMsg);
        exit;
      end;
    GetFolderFiles;
   finally
    PopMouseCursor;
   end;
end;

procedure TPhoenixMobileService.OnTsGridMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  displayCol,displayRow: Integer;
begin
  if Button = mbLeft then
    with tsGridFiles do
      begin
        CellFromXY(X,Y,DisplayCol,displayRow);
        if displayRow < 1 then
          exit;
        ResetRowProperties([prSelected]);
        SelectRows(displayRow,displayRow,true);
        btnDeleteFile.Enabled := true;
        btnDownload.Enabled := true;
        BeginDrag(false);
      end;
end;

procedure TPhoenixMobileService.OntsGridDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  If (source is TtsDBGrid) then
    Accept := true
  else
    accept := false;
end;

procedure TPhoenixMobileService.OnlbFolderDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  if source is TtsDBGrid then
    accept := true
  else
    accept := false;
end;

procedure TPhoenixMobileService.OnlbFoldersDragdrop(Sender, Source: TObject; X,
  Y: Integer);
var
  dropRowIndex: Integer;
  sourceRowIndex: Integer;
  position: TPoint;
begin
  if not (source is TtsDBGrid) then
    exit;
  sourceRowIndex := tsgridFiles.CurrentDataRow;
  if sourceRowIndex < 1 then
    exit;
  position.X := X;
  position.Y := Y;
  dropRowIndex := lbFolders.ItemAtPos(position,true);
  if dropRowIndex < 0 then
    exit;
  if dropRowIndex = lbFolders.ItemIndex then  //trying to move at the same folder
    exit;
  MoveFile(sourceRowIndex,dropRowIndex);
  lbFolders.ItemIndex := dropRowIndex;
  GetFolderFiles;
end;

procedure TPhoenixMobileService.MoveFile(fileIndex, folderIndex: Integer);
var
  containerID: String;
  fileID: String;
  url: String;
  errMsg: String;
  jsObj: TlkJSONObject;
  jsRequest,jsResponse: String;
begin
  containerID := TStringObject(lbFolders.Items.Objects[folderIndex]).str;
  fileID := tsgridFiles.Cell[colID,fileIndex];
  url := phoenixServices + format(fnMovefile,[fileID]);
  jsObj := TlkJSONObject.Create(true);
  jsObj.Add('targetContainerId',containerID);
  jsObj.Add('token',token);
  jsRequest := TlkJSON.GenerateText(jsObj);
  jsResponse := RPost(url,jsRequest, errMsg);
  if length(errMsg) > 0 then
  begin
    ShowAlert(atStopAlert, errMsg);
    exit;
  end;
end;

procedure TPhoenixMobileService.OnImportReportClick(Sender: TObject);
var
  reportID: String;
  url: String;
  errMsg: String;
  jsFile: String;
  jsoReport: TlkJSONobject;
  FirstDownload: Boolean;    //used by clickForms
  mismoXML: String;
  areas: SketchAreas;
  isAbort: Boolean;
begin
  if tsGridFiles.CurrentDataRow < 1 then
    exit;
  reportID := tsGridFiles.Cell[colID,tsgridFiles.CurrentDataRow];
 //get file info
  url := phoenixServices + format(fnGetFileInfo,[reportID,token]);
  errMsg := '';
  jsFile := RGet(url,errMsg);
  if length(errMsg) > 0 then
    begin
      ShowAlert(atStopAlert, errMsg);
      exit;
    end;
  jsoReport := TLKJSON.ParseText(jsFile) as TlkJsonObject;
  FirstDownload := not jsoReport.getBoolean(jsoReport.IndexOfName('paid'));
(*  //Ticket #1344: no longer need to call service
  if firstDownload and (availUnits <= 0) then
    begin
//      ShowNotice('Please call Bradford Technologies at 1-800-622-8727 to renew your PhoenixMobile subscription.');
      if not CurrentUser.OK2UseAWProduct(pidPhoenixMobile) then
        exit;
    end;
*)
    if not assigned(doc) or (assigned(doc) and (doc.docForm.Count = 0)) then  //GitHub #301 if there is no active container, create one and import + overwrite data
    begin
//      TMain(Application.MainForm).FileNewBlankSMItem.Click;
//      doc := TMain(Application.MainForm).ActiveContainer;
      TMain(Application.MainForm).FileNewDoc(nil);  //github 302: if no container, use the same logic like what we do for new report
      doc := TMain(Application.MainForm).ActiveContainer;
      FOverwriteData := True;  //github 209: always overwrite when we create a new report
    end;

    //github #198: Save existing report before import Redstone data
    if doc.docForm.Count > 0 then
      begin
        //if it's new form, we need to pop up dialog to ask user to save
        if doc.docDataChged and doc.docIsNew then
          begin
            if Ok2Continue('Do you want to save your changes before you continue?') then
              doc.SaveAs;
          end
        else
          begin
            if doc.docDataChged then //need to pop message if we detect a change in an existing report
              doc.Save;
          end;
      end;
   mismoXML := DownloadPhoenixMismo(reportID);
   if length(mismoXML) = 0 then
    exit;
//   if FirstDownload then //Ticket #1344: no longer need to call service
//    UpdateUsage;
   GetContainerImportTo(jsoReport, isAbort);
   if not assigned(doc) or isAbort then
    exit;

  ImportPhotos(jsoReport, mismoXML);
  areas := ImportSketches(reportID);
  errMsg := '';
  ImportPhoenixMismo(mismoXML,errMsg, FOverwriteData); //github 209
  TransferSketchAreas(areas);

  ShowNotice2('PhoenixMobile data has been successfully downloaded.'); //github 214: bring to front
  CheckServiceAvailable(stPhoenixMobile);
 end;

function TPhoenixMobileService.DownloadPhoenixMismo(reportID: String): String;
var
  url: String;
  errMsg: String;
  response: TMemoryStream;
begin
  errMsg := '';
  result := '';
  url := phoenixServices + format(fnMismo,[reportID,token]);
  response := RGetStream(url,errMsg);
  try
    if not assigned(response) then
      exit;
    if length(errMsg) > 0 then
      begin
        ShowAlert(atStopAlert, errMsg);
        exit;
      end;
    setLength(result,response.size);
    response.Seek(0,soFromBeginning);
    response.Read(Pchar(result)^, length(result));
    if not CheckReportXML(result,errMsg)  then
      begin
        ShowAlert(atStopAlert, errMsg);
        result := '';
      end;
  finally
    if assigned(response) then
      response.Free;
  end;
end;
    

procedure TPhoenixMobileService.ImportPhotos(jsReport: TlkJSONobject;PhoenixXML: String);
var
  jslPhotos: TlkJSONlist;
  cntr, nPhotos: Integer;
  photoID: String;
  reportID: String;
  imageTag: String;
  url: String;
  errMsg: String;
  mStrm: TMemoryStream;
begin
  if jsReport.Field['photos'] is TLKJSONnull then
    exit;
    reportID := vartostr(jsReport.Field['RowKey'].Value);
  jslPhotos := jsReport.Field['photos'] as TlkJSONlist;
  nPhotos := jslPhotos.Count;
  if nPhotos = 0 then    exit;
  for cntr := 1 to nPhotos do
    begin
      photoID := vartostr(jslPhotos.Child[cntr - 1].Field['id'].Value);
      imageTag := GetImageTag(jsReport,photoID);
      url := phoenixServices + format(fnGetResource,[reportID,photoID,token]);
      errMsg := '';
      mStrm := RGetStream(url,errMsg);
      try
        if length(errMsg) > 0 then
          begin
            ShowAlert(atStopAlert, errMsg);
            continue;
          end;
        if not assigned(mStrm) then
          continue;
        errMsg := '';
        mStrm.Seek(0,soFromBeginning);
        if (CompareText(imageTag,subjPhotoTags[1]) = 0) or (CompareText(imageTag,subjPhotoTags[2]) = 0) or (CompareText(imageTag,subjPhotoTags[3]) = 0) then
          ImportSubjectImage(mStrm,imageTag, PhoenixXML,errMsg)
        else if (CompareText(imageTag,subjExtraPhotoTags[1]) = 0) or (CompareText(imageTag,subjExtraPhotoTags[2]) = 0) or
                  (CompareText(imageTag,subjExtraPhotoTags[3]) = 0) or (CompareText(imageTag,subjExtraPhotoTags[4]) = 0) or
                  (CompareText(imageTag,subjExtraPhotoTags[5]) = 0) or (CompareText(imageTag,subjExtraPhotoTags[6]) = 0) then
                ImportSubjectExtraImage(mStrm,imageTag, PhoenixXML, errMsg)
              else if (CompareText(imageTag,CompPhotoTags[1]) = 0) or (CompareText(imageTag,compPhotoTags[2]) = 0) or
                        (CompareText(imageTag,compPhotoTags[3]) = 0) then
                      ImportCompImage(mStrm,imageTag, PhoenixXML, errMsg)
                    else
                      ImportOtherImage(mStrm,imageTag, PhoenixXML, errMsg);
      finally
        if assigned(mstrm) then
          mStrm.Free;
      end;
    end;
 end;

function TPhoenixMobileService.ImportSketches(reportID: String): SketchAreas;
var
  sketchPage, nSketchPages: Integer;
  url: String;
  errMsg: String;
  dataFile, img: TMemoryStream;
  strDataFile: String;
begin
  url := phoenixServices + format(fnGetSketchPages,[reportId,token]);
  errMsg := '';
  nSketchPages := StrToIntDef(RGet(url, errMSG),0);
  if length(errMsg) > 0 then
    begin
      ShowAlert(atStopAlert, errMsg);
      exit;
    end;
  if nSketchPages = 0 then
    exit;
  //get Phoenix Sketch Data File
  errMsg := '';
  url := phoenixServices + format(fnGetSketchDataFile,[reportId,token]);
  dataFile := RGetStream(url,errMsg);
  try
    if length(errMsg) > 0 then
      begin
        ShowAlert(atStopAlert, errMsg);
        exit;
      end;
    if not assigned(datafile) then
      exit;
    dataFile.Seek(0,sofromBeginning);
    setLength(strDataFile,dataFile.size);
    dataFile.Read(PChar(strDataFile)^,dataFile.Size);
    result := CalcSketchAreas(strDataFile);
    DataFile.Seek(0,soFromBeginning);
    for  sketchPage := 0 to nSketchPages - 1 do
    begin
      errMsg := '';
      url := phoenixServices + format(fnGetSketchImage,[reportID,sketchPage,sketchImgWidth,sketchImgHeight,token]);
      img := RGetStream(url, errMsg);
      try
        if length(errMsg) > 0 then
          begin
            Showalert(atStopAlert, errMsg);
            exit;
          end;
        if not assigned(img) then
          exit;
         img.Seek(0,soFromBeginning);
        ImportSketch(img,sketchPage,dataFile);
      finally
        if assigned(img) then
          img.Free;
      end;
    end;
  finally
    if assigned(dataFile) then
      dataFile.Free;
  end;
end;
(*  //Ticket #1344: no longer need to call service

function TPhoenixMobileService.GetAvailableUsage: integer;
var
  credent: clsPhoenixMobileUserCredentials;
  servResp: clsAuthorizeUsageResponse;
begin
  credent := clsPhoenixMobileUserCredentials.Create;
  credent.CustomerId := StrToIntDef(CurrentUser.LicInfo.UserCustID,0);
  if credent.CustomerId <= 0 then
  begin
     result := errCode_InValidCredential;
     exit;
  end;
  credent.Password := PhoenixMobileServerPsw;

  with GetPhoenixMobileServerPortType(true,PhoenixMobileServerURL, nil) do
    try
      servResp := PhoenixMobileService_AuthorizeUsage(credent);
    except
      on e: Exception do
        begin
          result := errCode_InValidCredential;
          exit;
        end;
    end;
  if servResp.Results.Code <> 0 then
    begin
      ShowNotice2(servResp.Results.Description);  //github 214: bring to front
      result := errCode_InValidCredential;
      exit;
    end;
  result := servResp.ResponseData.QuantityAvailable;
  serviceAcknowl := servResp.ResponseData.ServiceAcknowledgement;
end;
*)

(*   //Ticket #1344: no longer need to call service
procedure TPhoenixMobileService.UpdateUsage;
var
  credent: clsPhoenixMobileUserCredentials;
  acnow: clsPhoenixMobileAcknowledgement;
  fileIndex: Integer;
  dateStr: string;
begin
  dec(availUnits);
  credent := clsPhoenixMobileUserCredentials.Create;
  credent.CustomerId := StrToIntDef(CurrentUser.LicInfo.UserCustID,0);
  if credent.CustomerId <= 0 then
    exit;
  credent.Password := PhoenixMobileServerPsw;
  acnow := clsPhoenixMobileAcknowledgement.Create;
  acnow.Quantity := 1;
  acnow.Received := 1;
  acnow.ServiceAcknowledgement := serviceAcknowl;
  with GetPhoenixMobileServerPortType(true,PhoenixMobileServerURL, nil) do
    try
      PhoenixMobileService_Acknowledgement(credent,acnow);
    except
      on e: Exception do
        begin
          ShowNotice2('Error in updating usage. '+e.Message); //github 214: bring to front
          exit;
        end;
    end;
  with tsGridFiles do   //remove prefix new from record
    begin
      fileIndex := CurrentDataRow;
      dateStr := cell[colDate,fileIndex];
      if Pos(prefNew, dateStr) = 1 then
        begin
          dateStr := Copy(dateStr, length(prefNew) + 1 ,length(dateStr) - length(prefNew));
          cell[colDate,fileIndex] := dateStr;
        end;
    end;
//  availUnits := GetAvailableUsage;
end;
*)
procedure TPhoenixMobileService.GetContainerImportTo(jsReport: TlkJSONobject; var isAbort: Boolean);
var
  reportFormType:String;
  formID, formCertID: Integer;
  aOption: Integer;
  isOverwriteData:Boolean;

begin
  isAbort := False;
  reportFormType := GetReportFormType(jsReport);
  if not assigned(doc) then
    begin   //create empty container if does not exxist
      TMain(Application.MainForm).FileNewBlankSMItem.Click;
      doc := TMain(Application.MainForm).ActiveContainer;
    end;
  if doc.FormCount > 0 then //if forms exist, give user a choice to override or create new container
    begin
      isOverwriteData := False;  //github 243
      aOption:=	WhichOption123Ex(isOverwriteData, 'Import', 'New Report', 'Cancel',
      //github #198
      'Would you like to import data from PhoenixMobile to existing report or start a new report? ', 100, True);
      if aOption = mrYes then
        begin
          FOverwriteData := isOverwriteData;
        end
      else if aOption = mrNo then
      begin
          TMain(Application.MainForm).FileNewDoc(nil);
          doc := TMain(Application.MainForm).ActiveContainer;
          FOverwriteData := True;  //github 209: always overwrite when we create a new report
      end
      else  //quit
        begin
          isAbort := True;
          Exit;
        end;

(*
      if not OK2ContinueCustom('You about to import data from PhoenixMobile. would you like to overwrite ' +
                                  'the existing data with the data from PhoenixMobile, or start a new report?',
                  'Import', 'New Report') then
      begin //create a new container
        TMain(Application.MainForm).FileNewDoc(nil);
        doc := TMain(Application.MainForm).ActiveContainer;
      end;
*)
    end;

  doc := TMain(Application.MainForm).ActiveContainer;
  Repaint;  //remove notice dialog
  FormID := ConvertFormTypeToFormID(reportFormType);
  if formID = 0 then
    begin
       ShowAlert(atStopAlert, 'Unknown Form!');
      exit;
    end;
    FormCertID := GetFormCertID(FormID);
      begin
        if not assigned(doc.GetFormByOccurance(formID,0,false)) then
          doc.InsertBlankUID(TFormUID.Create(FormID), true, -1, False);
        if not assigned(doc.GetFormByOccurance(formCertID,0,false)) then
          doc.InsertBlankUID(TFormUID.Create(FormCertID), true, -1, False);
      end;
end;

procedure TPhoenixMobileService.ImportSubjectImage(strm: TStream; imageTag: String; PhoenixXML: String; var errMsg: String);
const
  formID3x5 = 301;
  formID4x6 = 311;
  frontCellID = 1205;
  rearCellID = 1206;
  streetCellID = 1207;
  addrLine1ID = 1673;   //at the front image
  addrLine2ID = 1674;
  xpathAddress = '/VALUATION_RESPONSE/PROPERTY/@_StreetAddress';
  xpathCityStateZip = '/VALUATION_RESPONSE/PROPERTY/@_StreetAddress2';
var
  imageCellID: Integer;
  cell: TBaseCell;
  form: TDocForm;
  xmlDoc: IXMLDOMDocument3;
  node: IXMLDOMNode;
  line1, line2: String;
begin
  errMsg := '';
  if CompareText(imageTag, subjPhotoTags[1]) = 0 then imageCellID := frontCellID
    else if CompareText(imageTag,subjPhotoTags[2]) = 0 then imageCellID := rearCellID
          else if CompareText(imageTag,subjPhotoTags[3]) = 0 then imageCellID := streetCellID
                else  exit;
  cell := doc.GetCellByID(imageCellID);
  //github 209
  if assigned(cell) then
    form := doc.docForm[cell.uid.occur]
  else
    begin
      if FOverwriteData then
        begin
          form := doc.InsertFormUID(TFormUID.Create(formID3x5),true,-1);
          cell := form.GetCellByID(imageCellID);
        end
      else if not assigned(cell) then //no cell, insert image form
        begin
          form := doc.InsertFormUID(TFormUID.Create(formID3x5),true,-1);
          cell := form.GetCellByID(imageCellID);
        end;
    end;
  if assigned(cell) and (cell is TPhotoCell) then
    begin
      if FOverwriteData or not(TPhotoCell(cell).HasImage) then
        begin
          if TPhotoCell(cell).HasImage then
            TPhotoCell(cell).FImage.Clear;
          doc.MakeCurCell(cell);        //make sure its active
          TGraphicEditor(doc.docEditor).LoadImageStream(strm);
        end;
    end
  else
    begin
      if FOverwriteData then
        errMsg := 'Cannot insert subject photo';
      exit;
    end;
  //import address
  xmlDoc := CoDomDocument60.Create;
  xmlDoc.setProperty('SelectionLanguage','XPath');
  xmlDoc.loadXML(PhoenixXML);
  line1 := '';
  node := xmlDoc.selectSingleNode(xpathAddress);
  if assigned(node) then
    line1 := node.text;
  cell := form.GetCellByID(addrLine1ID);
  if assigned(cell) and (length(line1) > 0) then
    if FOverwriteData or (length(cell.text)=0) then
      cell.Text := line1;
  line2 := '';
  node := xmlDoc.selectSingleNode(xpathCityStateZip);
  if assigned(node) then
    line2 := node.text;
  cell := form.GetCellByID(addrLine2ID);
  if assigned(cell) and (length(line2) > 0) then
    if FOverwriteData or (length(cell.text)=0) then
      cell.Text := line2;
end;

procedure TPhoenixMobileService.ImportSubjectExtraImage(strm: TStream; imageTag: String; PhoenixXML: String; var errMsg: String);
const
  formID3x5 = 302;
  formID4x6 = 312;
  topImageID = 1208;
  topImageDescrID = 1211; //upper line
  midImageID = 1209;
  midImageDescrID = 1212;
  botImageID = 1210;
  botImageDescrID = 1213;
var
  cell: TBaseCell;
  form: TDocForm;
  cntr: Integer;
  descrCellID: Integer;
begin
  errMsg := '';
  cell := nil;
  form := nil;
  descrCellId := 0;
  //find the 1st available slot in Subject Extra phot pages
  for cntr := 0 to doc.docForm.Count - 1 do
    if (doc.docForm[cntr].FormID = formID3x5) or (doc.docForm[cntr].FormID = formID4x6) then
      begin
        form := doc.docForm[cntr];

        cell := form.GetCellByID(topImageID);   //check the top image
        if assigned(cell) and (cell is TPhotoCell) and not TPhotoCell(cell).HasImage then
          begin
            descrCellID := topImageDescrID;
            break;
          end;
        cell := form.GetCellByID(midImageID);   //check the middle image
        if assigned(cell) and (cell is TPhotoCell) and not TPhotoCell(cell).HasImage then
          begin
            descrCellID := midImageDescrID;
            break;
          end;
        cell := form.GetCellByID(botImageID);   //check the bottom image
        if (cell is TPhotoCell) and not TPhotoCell(cell).HasImage then
          begin
            descrCellID := botImageDescrID;
            break;
          end;
        cell := nil;
      end;
    if not assigned(cell) and FOverwriteData then
      begin   //create new photo subject extra page
        form := doc.InsertFormUID(TFormUID.Create(formID3x5),true,-1);
        cell := form.GetCellByID(topImageID);
        descrCellID := topImageDescrID
      end;
  if assigned(cell) and (cell is TPhotoCell) then
    begin
      if FOverwriteData or not(TPhotoCell(cell).HasImage) then  //github 209
        begin
          if TPhotoCell(cell).HasImage then
            TPhotoCell(cell).FImage.Clear;
          doc.MakeCurCell(cell);        //make sure its active
          TGraphicEditor(doc.docEditor).LoadImageStream(strm);
          cell := form.GetCellByID(descrCellID); //insert tag
          if assigned(cell) then
            cell.Text := imageTag;
        end;
    end
  else
    begin
      if FOverwriteData then  //github 209
        errMsg := 'Cannot insert subject photo';
      exit;
    end;      
end;

procedure TPhoenixMobileService.ImportCompImage(strm: TStream; imageTag: String; PhoenixXML: String; var errMsg: String);
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
  xpathAddress = '/VALUATION_RESPONSE/VALUATION_METHODS/SALES_COMPARISON/COMPARABLE_SALE[%d]/LOCATION/@PropertyStreetAddress';
  xpathCity = '/VALUATION_RESPONSE/VALUATION_METHODS/SALES_COMPARISON/COMPARABLE_SALE[%d]/LOCATION/@PropertyCity';
  xPathState = '/VALUATION_RESPONSE/VALUATION_METHODS/SALES_COMPARISON/COMPARABLE_SALE[%d]/LOCATION/@PropertyState';
  xPathZip = '/VALUATION_RESPONSE/VALUATION_METHODS/SALES_COMPARISON/COMPARABLE_SALE[%d]/LOCATION/@PropertyPostalCode';
  pageNo = 1; //comp photo forms have just 1 page
var
  imageCellID: Integer;
  line1No, line2No: Integer;
  cell: TBaseCell;
  form: TDocForm;
  xmlDoc: IXMLDOMDocument3;
  line1, line2: String;
  node: IXMLDOMNode;
  compNo: Integer;
begin
  errMsg := '';
  if CompareText(imageTag, compPhotoTags[1]) = 0 then
    begin
      imageCellID := comp1PhotoCellID;
      line1No := comp1AddrLine1No;
      line2No := comp1AddrLine2No;
      compNo := 1;
    end
  else if CompareText(imageTag,compPhotoTags[2]) = 0 then
          begin
            imageCellID := comp2PhotoCellID;
            line1No := comp2AddrLine1No;
            line2No := comp2AddrLine2No;
            compNo := 2;
          end
        else if CompareText(imageTag,compPhotoTags[3]) = 0 then
                begin
                  imageCellID := comp3PhotoCellID;
                  line1No := comp3AddrLine1No;
                  line2No := comp3AddrLine2No;
                  compNo := 3;
                end
            else  exit;
  cell := doc.GetCellByID(imageCellID);
  if assigned(cell) then
    form := doc.docForm.GetFormByOccurance(cell.UID.FormID,cell.UID.Occur)
  else if FOverwriteData then //github 209: only create form when we're in overwrite mode
    begin
      form := doc.InsertFormUID(TFormUID.Create(formID3x5),true,-1);
      cell := form.GetCellByID(imageCellID);
    end;
  if assigned(cell) and (cell is TPhotoCell) and (FOverwriteData or TPhotoCell(cell).FEmptyCell) then
    begin
      if TPhotoCell(cell).HasImage then
        TPhotoCell(cell).FImage.Clear;
      doc.MakeCurCell(cell);        //make sure its active
      TGraphicEditor(doc.docEditor).LoadImageStream(strm);
    end
  else
    begin
      if FOverwriteData then
        errMsg := 'Cannot insert subject photo';
      exit;
    end;
  //import address
  xmlDoc := CoDomDocument60.Create;
  xmlDoc.setProperty('SelectionLanguage','XPath');
  xmlDoc.loadXML(PhoenixXML);
  line1 := '';
  node := xmlDoc.selectSingleNode(format(xpathAddress,[compNo + 1]));
  if assigned(node) then
    line1 := node.text;
  cell := form.GetCell(pageNo,line1No);
  if assigned(cell) and (length(line1) > 0) and (FOverwriteData or (cell.Text='')) then  //github 209
    cell.Text := line1;
  line2 := '';
  node := xmlDoc.selectSingleNode(format(xpathCity,[compNo + 1]));
  if assigned(node) then
    line2 := node.text;
  node := xmlDoc.selectSingleNode(format(xpathState,[compNo + 1]));
  if assigned(node) then
    line2 := line2 + ', ' + node.text;
  node := xmlDoc.selectSingleNode(format(xpathZip,[compNo + 1]));
  if assigned(node) then
    line2 := line2 + ' ' + node.text;
  cell := form.GetCell(pageNo,line2No);
  if assigned(cell) and (length(line2) > 0) and (FOverwriteData or (cell.Text='')) then //github 209
    cell.Text := line2;         
  end;

procedure TPhoenixMobileService.ImportOtherImage(strm:TStream; imageTag: String; PhoenixXML: String; var errMsg: String);
const
  formID3x5 = 308;
  formID4x6 = 312;
  topImageID = 1222;
  topImageDescrID = 2624; //upper line
  midImageID = 1223;
  midImageDescrID = 2626;
  botImageID = 1224;
  botImageDescrID = 2628;
var
  cell: TBaseCell;
  form: TDocForm;
  cntr: Integer;
  descrCellID: Integer;
begin
  errMsg := '';
  cell := nil;
  form := nil;
  descrCellId := 0;
  //find the 1st available slot in Untitled photo pages
  for cntr := 0 to doc.docForm.Count - 1 do
    if (doc.docForm[cntr].FormID = formID3x5) or (doc.docForm[cntr].FormID = formID4x6) then
      begin
        form := doc.docForm[cntr];

        cell := form.GetCellByID(topImageID);   //check the top image
        if assigned(cell) and (cell is TPhotoCell) and not TPhotoCell(cell).HasImage then
          begin
            descrCellID := topImageDescrID;
            break;
          end;
        cell := form.GetCellByID(midImageID);   //check the middle image
        if assigned(cell) and (cell is TPhotoCell) and not TPhotoCell(cell).HasImage then
          begin
            descrCellID := midImageDescrID;
            break;
          end;
        cell := form.GetCellByID(botImageID);   //check the bottom image
        if (cell is TPhotoCell) and not TPhotoCell(cell).HasImage then
          begin
            descrCellID := botImageDescrID;
            break;
          end;
        cell := nil;
      end;
    if not assigned(cell) and FOverwriteData then    //github 209
      begin   //create new photo subject extra page
        form := doc.InsertFormUID(TFormUID.Create(formID3x5),true,-1);
        cell := form.GetCellByID(topImageID);
        descrCellID := topImageDescrID
      end;
  if assigned(cell) and (cell is TPhotoCell) and (FOverwritedata or TPhotoCell(cell).FEmptyCell) then
    begin
      if TPhotoCell(cell).HasImage then
        TPhotoCell(cell).FImage.Clear;
      doc.MakeCurCell(cell);        //make sure its active
      TGraphicEditor(doc.docEditor).LoadImageStream(strm);
      cell := form.GetCellByID(descrCellID); //insert tag
      if assigned(cell) then
        cell.Text := imageTag;
    end
  else
    begin
      if FOverwriteData then //github 209
        errMsg := 'Cannot insert untitled photo';
      exit;
    end;
end;

function TPhoenixMobileService.ImportSketch(imageStrm: TMemoryStream; sketchNo: Integer; dataFileStrm: TMemoryStream): Boolean;
var
  form: TDocForm;
  cell: TBaseCell;
  skCells: cellUIDArray;
  sketchLabel: String;
begin
  result := false;
  sketchLabel := formatdatetime('mdyyhns',now);
  setlength(skCells,0);
  skCells := doc.GetCellsByID(cidSketchImage);
  if sketchNo < length(skCells) then  //we already have available sketch form in the report
    cell := doc.GetCell(skCells[sketchNo])
  else
    begin  //insert the new sketch form
      if FOverwriteData then //github 209: only insert blank form when we are in overwrite mode
        begin
          form := doc.InsertBlankUID(TFormUID.Create(cSkFormLegalUID), true, -1);
          cell := form.GetCellByID(cidSketchImage);
        end
      else if SketchNo = 0 then//github 302: if no sketch form, create one
        begin
          form := doc.InsertBlankUID(TFormUID.Create(cSkFormLegalUID), true, -1);
          cell := form.GetCellByID(cidSketchImage);
        end;
  end;
  if assigned(cell) and (cell is TSketchCell) then
    try
      if FOverwriteData or (cell.FEmptyCell) then  //github 209: only push the sketch data in to the cell when it's empty or in override mode
        begin
          doc.MakeCurCell(cell);        //make sure its active
          TGraphicEditor(doc.docEditor).LoadImageStream(imageStrm);
          cell.Text := sketchLabel;  //put the text
          result := true;
        end;
    except
      exit;
    end;
  //github 302: need to check for assigned before we access the cell to avoid access violation
  //github 209  only push sketch data in when it's empty cell or in overwrite mode
  if (sketchNo = 0) and (FOverwriteData or (assigned(TSketchCell(cell)) and  TSketchCell(cell).FEmptyCell)) then  //1st sketch, put metadata there
    with TSketchCell(cell) do
      begin
        FMetaData := TSketchData.Create(mdPhoenixSketchData,1,sketchLabel); //create meta storage
        FMetaData.FUID := mdPhoenixSketchData;
        FMetaData.FVersion := 1;
        FMetaData.FData := TMemoryStream.Create;      //create new data storage
        FMetaData.FData.CopyFrom(dataFileStrm, 0);  //save to cells metaData
      end;
end;

procedure TPhoenixMobileService.TransferSketchAreas(areas: SketchAreas);
const
  idGla = 232;
  idGlaCost = 877;
  idGarage = 893;
  idBasement = 200;
  idBasement1 = 250;
begin
  if FOverwriteData or (doc.GetCellTextByID(idGla)='') then  //github 209
  with areas do
    begin
      if areaGLA > 0 then
        begin
          doc.SetCellTextByID(idGla,FloatToStr(areaGla));
          doc.SetCellTextByID(idGlaCost,FloatToStr(areaGla));
        end;
      if areaGarage > 0 then
        doc.SetCellTextByID(idGarage,FloatToStr(areaGarage));
      if areaBasement > 0 then
        begin
          doc.SetCellTextByID(idBasement,FloatToStr(areaBasement));
          doc.SetCellTextByID(idBasement1,FloatToStr(areaBasement));
        end;
    end;
end;

procedure TPhoenixMobileService.OnClose(Sender: TObject);
begin
  Close;
end;


end.
