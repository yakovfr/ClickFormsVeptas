unit UPhoenixMobileUtils;

interface
uses
  SysUtils, Dialogs, Controls, DateUtils, Variants, ActiveX, Classes, ADODB, MSXML6_TLB, tsGrid, AxCtrls,
  UContainer, ULkJson;


type

SketchAreas = record
  areaGLA, area1Floor, area2Floor, area3Floor, areaGarage, areaBasement: Double;  //PhoenixSketch doesn't  have predefined area type Baasement
end;

const
  httpRespOK  = 200;

  phoenixServices = 'https://www.phoenixsuite.com/services/';
  fnLogin = 'users/login';
  fnGetContainers  = 'users/containers/';
  fnContainerFiles = 'containers/%s/files/';
  fnDeleteContainer = 'containers/%s/delete';
  fnGetAccount = 'users/accounts/%s';
  fnCreateContainer = 'accounts/%s/Containers/';
  fnMismo = 'mismo/%s/%s';
  fnDeleteFile = 'files/%s/delete';
  fnMoveFile = 'files/%s/move';
  fnGetFileInfo = 'files/%s/%s';
  fnGetResource = 'files/%s/resources/%s/%s';
  fnLogout = 'users/logout';
  fnGetSketchPages = 'sketch/sync/%s/pages/%s';
  fnGetSketchDataFile = 'sketch/sync/%s/%s';
  fnGetSketchImage = 'sketch/sync/%s/%d/%dx%d/%s';

  sketchImgHeight = 1200;
  sketchImgWidth =  900;

  subjPhotoTags: Array[1..3] of String = ('Front', 'Rear', 'Street');
  subjExtraPhotoTags: Array[1..6] of String = ('Kitchen', 'Main Living area', 'Master Bath', 'Bath 2', 'Bath 3', 'Bath 4');
  compPhotoTags: array[1..3] of String = ('Comp 1 Front', 'Comp 2 Front', 'Comp 3 Front');

  sketchDataFile = 'sketch.pxsf';
  sketchImage = 'sketch%d.jpg';

function GetPhoenixToken(id, psw: String): String;
function RGet(const url:string; var errMsg: String): string;
function RPost(const url:string; const request: String; var errMsg: String): string;
function RPostStream(const url:string; const request: TStream; var errMsg: String): string;
function RGetStream(const url: String; errMsg: String): TMemoryStream;
function ConvertPhoenixDate(phoenixDate: String): String;
function GetAccountID(strToken: String): String;
function ConvertDelphiDate(dt: TDateTime): String;
function GetReportFormType(jsReport: TlkJSONobject): String;
function GetImageTag(jsReport: TlkJSONobject; imageID: String): String;
function CalcSketchAreas(dataFile: String): SketchAreas;
function isReportUploadable(doc: TContainer; var errMsg: String): Boolean;
function ConvertFormTypeToFormID(FormType:String):Integer;
function CreatePhoenixMismo(doc: TContainer): String;
function CheckReportXML( xmlStr: String; var errMSG: String): Boolean;

implementation

uses
  Forms, UGlobals, UForm, UMathResid5, WinHTTP_TLB, UStatus, UAMC_XMLUtils,
  UGSEInterface, UUADUtils;



function GetPhoenixToken(id, psw: String): String;
var
  js: TlkJSONObject;
  jsStr: String;
  url: String;
  strToken: String;
  pStr: PChar;
  errMsg: String;
begin
  result := '';
  js := TlkJSONObject.Create(true);
  js.Add('email', id);
  js.Add('password', psw);
  jsStr := TlkJSON.GenerateText(js);
  url :=  phoenixServices + fnLogin;
  strToken := RPost(url, jsStr, errMsg);
  if length(errMsg) > 0 then
    begin
      ShowAlert(atStopAlert, errMsg);
      exit;
    end;
  pStr := PChar(strToken);
  result := AnsiExtractQuotedStr(pStr,'"');
end;

function RGet(const url:string; var errMsg: String): string;
var
  httpRequest: IWinHTTPRequest;
begin
  errMsg := '';
  httpRequest := CoWinHTTPRequest.Create;
  with httpRequest do
    begin
      Open('GET',url,False);
       try
          send('');
        except
          on e:Exception do
              errMsg := e.Message;
        end;
        if Status <> httpRespOK then
          errMsg := 'The server returned error code '+ IntToStr(status)
        else
          result := ResponseText;
      end;
end;

//it is calling function responsibility to free returning stream
function RGetStream(const url: String; errMsg: String): TMemoryStream;
var
  httpRequest: IWinHTTPRequest;
  HttpStream :IStream;
  OleStream: TOleStream;
begin
  errMsg := '';
  httpRequest := CoWinHTTPRequest.Create;
  result := TMemoryStream.Create;

  with httpRequest do
    begin
      Open('GET',url,False);
      try
        send('');
      except
          on e:Exception do
              errMsg := e.Message;
      end;
      if Status <> httpRespOK then
        begin
          errMsg := 'The server returned error code '+ IntToStr(status);
          result.Free;
          result := nil;
          exit;
        end;
      HttpStream := IUnknown(ResponseStream) as IStream;
      OleStream := TOleStream.Create(HttpStream);
      OleStream.position := 0;
      try
        result.CopyFrom(OleStream, Olestream.Size);
      finally
        OleStream.Free;
      end;
  end;
end;  

function RPost(const url:string; const request: String; var errMsg: String): string;
var
  httpRequest: IWinHTTPRequest;
begin
  errMsg := '';
  httpRequest := CoWinHTTPRequest.Create;
  with httpRequest do
    begin
       Open('POST',url,False);
       SetRequestHeader('Content-type','text/json');
       SetRequestHeader('Content-length', IntToStr(length(request)));
       try
          send(request);
        except
          on e:Exception do
              errMsg := e.Message;
        end;
        if Status <> httpRespOK then
          errMsg := 'The server returned error code '+ IntToStr(status)
        else
          result := ResponseText;
      end;
end;

function ConvertPhoenixDate(phoenixDate: String): String;
const
  phoenixDateIdentifier = 'Date';
  startDateDelim = '(';
  endDateDelim = ')';
  minDate = '01/01/2000';
var
  delphiDate: TDateTime;
  startPos, endPos : Integer;
  curStr: String;
  unixDate: Integer;  //seconds after 1/1/1970
begin
  result := '';
  if (length(phoenixDate) > 0) and  (Pos(phoenixDateIdentifier,phoenixDate) > 0) then
    begin
      startPos := Pos(startDateDelim,phoenixDate);
      if startPos = 0 then
        exit;
      endPos := Pos(endDateDelim,PhoenixDate);
      if (endPos <= startPos) then
        exit;
      curStr := Copy(phoenixDate,startPos + 1, endPos - startPos - 1);
      unixDate := StrToInt64Def(curStr,0) div 1000; //convet milisecnds to second
      if unixDate <= 0 then
        exit;
      delphiDate := UnixToDateTime(unixDate);
      if delphiDate < StrToDate(minDate) then
        exit;
      result := FormatDateTime('mm/dd/yyyy',delphiDate);
    end;
end;

function GetAccountID(strToken: String): String;
var
  jsStr: String;
  ls: TlkJSONList;
  js:TlkJSONobject;
  errMsg: String;
  account: Integer;
  permissions: String;
begin
  errMsg := '';
  result := '';
  jsStr := RGet(phoenixServices + format(fnGetAccount,[strToken]), errMsg);
  if length(errMsg) > 0 then
    begin
      ShowAlert(atStopAlert, errMsg);
      exit;
    end;
  ls := TlkJSON.ParseText(jsStr) as TlkJSONList;
  if ls.Count = 0 then //cannot be
    exit;
  for account := 1 to ls.Count do
    begin
      js := ls.Child[account - 1] as TlkJSONObject;
      permissions := vartostr(js.Field['permissions'].Value);
      if comparetext(permissions,'owner') = 0 then
        begin
          result := vartostr(js.Field['PartitionKey'].Value);
          break;
        end;
    end;
end;

function ConvertDelphiDate(dt: TDateTime): String;
var
  unixDateMlsec: Int64;
begin
  unixDateMlsec := DateTimeToUnix(dt) * 1000;  //in milliseconds
  result := '/Date(' + intTostr(unixDateMlsec) + ')/';
end;

function RPostStream(const url:string; const request: TStream; var errMsg: String): string;
var
  httpRequest: IWinHTTPRequest;
  HttpStream :IStream;
begin
  errMsg := '';
  httpRequest := CoWinHTTPRequest.Create;
  with httpRequest do
    begin
       Open('POST',url,False);
       //SetRequestHeader('Content-type','appication/octet-stream');
       //SetRequestHeader('Content-length', IntToStr(length(request)));
       //OleStream:= TOleStream.Create(HttpStream);
       //OleStream.CopyFrom(request, request.Size);
       request.Seek(0,soFromBeginning);
       HTTPStream := TStreamAdapter.Create(request,soReference);
       try
        send(HTTpStream);
       except
        on e:Exception do
          errMsg := e.Message;
        end;
       if Status <> httpRespOK then
        errMsg := 'The server returned error code '+ IntToStr(status)
       else
        result := ResponseText;
    end;
end;

{procedure DeleteAllFolderFiles(folderPath: String);
var
  sr: TSearchRec;
begin
  if FindFirst(IncludeTrailingPathDelimiter(folderPath) + '*.*' , faAnyFile, sr) = 0 then
    begin
      repeat
        if (sr.Attr and faDirectory) = 0 then    //it is not a directory
          DeleteFile(IncludeTrailingPathDelimiter(folderPath) + sr.Name);
      until FindNext(sr) <> 0;
      FindClose(sr);
    end;
end;         }

function GetReportFormType(jsReport: TlkJSONobject): String;
var
  jslFormMetadata: TlkJSONlist;
begin
  result := '';
  if not (jsReport.Field['metadata'] is TlkJSONnull) then  //check for metadata is not null before we move on
    if not (jsReport.Field['metadata'].Field['formMetadata'] is TlkJSONnull)  then  //test for null
      begin
       //Only get forms' type if not null
        jslFormMetadata := jsReport.Field['metadata'].Field['formMetadata'] as TlkJSONlist;
        if jslFormMetadata.Count > 0 then  //cannot be more than 1 form in Phoenix file. So tate the 1st
          result := vartostr(jslFormMetadata.Child[0].Field['name'].Value);
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

function CalcSketchAreas(dataFile: String): SketchAreas;
const
  str1Floor = 'First Floor';
  str2Floor = 'Second Floor';
  str3Floor = 'Third floor';
  strGarage = 'Garage';
  strBasement = 'Basement';
  fldFloors = 'floors';
  fldAreas = 'areas';
  fldInfo = 'info';
  fldName = 'name';
  fldLivingArea = 'livingArea';
  fldDimensionLabel = 'dimensionLabel';
  fldText = 'text';
var
  jsReport, floors, areas, area, info, dimension: TlkJSONbase;
  floorCntr, areaCntr: Integer;
  strSF: String;
  delim: Integer;
  areaName: String;
  isLivingarea: Boolean;
  curArea: Double;
begin
    result.areaGLA := 0;
    result.area1Floor := 0;
    result.area2Floor := 0;
    result.area3Floor := 0;
    result.areaGarage := 0;
    jsReport := TLKJSON.ParseText(datafile);
  if jsReport is TlkJSONnull then
    exit;
  floors := TlkJSONobject(jsReport).Field[fldFloors];
  if (floors is TlkJSONnull) or (TlkJSONlist(floors).Count = 0) then
    exit;
  for floorCntr := 0 to  TlkJSONlist(floors).Count - 1 do
    begin
      areas := TlkJSONlist(floors).Child[floorCntr].Field[fldAreas];
      if (areas is TlkJSONnull) or (TlkJSONlist(areas).Count = 0) then
        continue;
      for areaCntr := 0 to TlkJSONlist(areas).Count - 1 do
        begin
          area := TlkJSONlist(areas).Child[areaCntr];
          if area is TlkJSONnull then
            continue;
          info := TlkJSONobject(area).Field[fldInfo];
          if info is TlkJSONnull then
            continue;
          areaName := vartostr(TlkJSONobject(info).Field[fldName].Value);
          isLivingArea := TlkJSONobject(info).getBoolean(TlkJSONobject(info).IndexOfName(fldLivingArea));
          dimension := TlkJSONobject(area).Field[fldDimensionLabel];
            if dimension is TlkJSONnull then
              continue;
            curArea := 0;
            strSF := vartostr(TlkJSONobject(dimension).Field[fldText].Value);
            delim := pos(' ',strSF);
            if  delim > 0 then
              curArea := StrToFloatDef(copy(strSF,1,delim - 1),0);
            if abs(curArea) > 0 then
              begin
                if compareText(areaName,str1Floor) = 0 then
                  result.area1Floor := result.area1Floor + curArea
                else if comparetext(areaName,str2Floor) = 0 then
                        result.area2Floor := result.area2Floor + curArea
                      else if compareText(areaName,str2Floor) = 0 then
                              result.area3Floor := result.area3Floor + curArea
                            else if CompareText(areaName,strGarage) = 0 then
                                    result.areaGarage := result.areaGarage + curArea
                                  else if CompareText(areaName,strBasement) = 0 then
                                    result.areaBasement := result.areaBasement + curArea;
               if isLivingArea then
                result.areaGLA := result.areaGLA + curArea;
              end;
        end;
    end;
end;

function isReportUploadable(doc: TContainer; var errMsg: String): Boolean;
var
  cntr: Integer;
  isMainFormPresented: boolean;
begin
  result := false;
  errMsg := '';
  isMainFormPresented := false;
  if (length(doc.GetCellTextByID(cSubjectAddressCellID)) = 0) or
      (length(doc.GetCellTextByID(cSubjectCityCellID)) = 0)   then
    begin
      errMsg := 'You must specify the subject property''s street address and city before'  +
                ' uploading the report to PhoenixMobile';
      exit;
    end;
  for cntr := 0 to doc.docForm.Count - 1 do
    with  doc.docForm[cntr].frmInfo do
      begin
        if fFormKindID = integer(fkMain) then        //check main form
          begin
            if isMainFormPresented then //the second main form
              begin
                errMsg := 'The report contains more than 1 main forms.'#13#10 +
                          ' It cannot be uploaded to PhoenixMobile.';
                exit;
              end;
            isMainFormPresented := true;
            if ConvertFormTypeToFormID(fFormName) = 0 then
              begin
                errMsg := 'You cannot Upload ' + fFormName + ' to PhoenixMobile!';
                exit;
              end;
          end;
      end;
      if not isMainFormPresented then
        begin
          errMsg := 'The report must contain a main form.'#13#10 +
                      'It cannot be uploaded!';
          exit;
        end
      else
        result := true;
end;

function ConvertFormTypeToFormID(FormType:String):Integer;
begin
   FormType:=UpperCase(FormType);
   result := 0;
   if pos('1004',FormType) > 0 then
      result := fm2005_1004     //Form id 340
   else if pos('1073',FormType) > 0 then
      result := fm2005_1073     //Form id 345
   else if pos('1075',FormType) > 0 then
      result := fm2005_1075     //Form id 347
   else if pos('2055',FormType) > 0 then
      result := fm2005_2055;     //Form id 355
end;

function CreatePhoenixMismo(doc: TContainer): String;
var
  formList: BooleanArray;
  errMsg: String;
  cntr: Integer;
  frmKind: Integer;
  xmlVer: String;
  miscInfo: TMiscInfo;
  existCursor: TCursor;
begin
  result := '';
  //set formList copied from UAMC_SelectForm
  if doc.docForm.Count = 0 then
    exit;   //empty report
  setlength(formList,doc.docForm.Count);
  errMsg := '';
  if not isReportUploadable(doc,errMsg) then
    begin
      ShowNotice(errMsg,false);
      exit;
    end;
  for cntr := 0 to doc.docForm.Count - 1 do
    begin
      frmKind := doc.docForm[cntr].frmInfo.fFormKindID;
      if (frmKind = fkOrder) or (frmKind = fkWorksheetUAD) or (frmKind = fkWorksheetCVR) or (frmKind = fkInvoice) then
        formList[cntr] := false
      else
        formList[cntr] := true;
    end;
  xmlVer := '';
  miscInfo := TMiscInfo.Create;
  existCursor := Screen.Cursor;
  try
    miscInfo.FEmbedPDF := False;
    miscInfo.FPDFFileToEmbed := '';
    Screen.Cursor := crHourGlass;
    try
      result := ComposeGSEAppraisalXMLReport(doc, xmlVer, formList, miscInfo, nil);
    except
      result := '';
    end;
  finally
    miscInfo.Free;
    Screen.Cursor := existcursor;
  end;
end;

function CheckReportXML( xmlStr: String; var errMSG: String): Boolean;
const
  strCode = '"code":';
  strMessage = '"message":';
  err403 = '403';
  unknownError = 'Unknown error while downloading Mismo report!';
var
  xmlDoc: IXMLDOMDocument3;
  strPhoenixError: String;
  index: Integer;
begin
  xmlDoc := CoDomDocument60.Create;
  xmlDoc.validateOnParse := true;
  if xmlDoc.loadXML(xmlStr) then
    begin
      result := true;
      errMsg := '';
      exit; //well formed XML
    end;
  // there is the error in XML Phoenix returns
  result := false;
  //Phoenix put error information instead of XML ?
    index := Pos(strCode,xmlStr);
    if index = 0 then
      begin
        errMsg := unknownError;
        exit;
      end;
    strPhoenixError := trim(copy(xmlStr, index + length(strCode), length(strPhoenixError)));
    if Pos(err403,strPhoenixError) = 1 then  //the only error code we know
      errMsg := 'You do not have any PhoenixMobile Credits. ' +
                'Please contact the Bradford Technologies Sales Team at 1-800-622-8727 to purchase more credits.'
    else
      errMsg := unknownError;
end;

end.
