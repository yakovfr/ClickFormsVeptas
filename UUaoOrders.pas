unit UUaoOrders;
//Import Rally orders; *.uao

interface
uses
  SysUtils, MSXML6_TLB, Classes, Forms, UMain, UContainer, UBase, UForm;
const
  xPathFormatID = '/APPRAISAL_ORDER/@FormatID';
  xPathPort = '/APPRAISAL_ORDER/PORT';

  rallyOrderFormatID = 'rally001';
  rallyPort = 'Rally';

 universalOrderFormID = 857;

type
  TUniversalOrder = class(TObject)
  private
    orderXMLDoc: IXMLDomDocument2;
    FDoc: TContainer;
    orderForm: TDocForm;
    mapStringList: TStringList;
    procedure DoImportOrder;
    function SpecialHandling(fnID: Integer; param: String; clText: String): String;
  end;

  mapRecord = Record
    cellNum: Integer;
    specFlag: Integer;
    Param: String;
    XPath: String;
  end;

procedure ImportUAOOrder(filePath: string);
function CreateOrderXML(filePath: string):IXMLDomDocument2;
function GetMapList: TStringList;
function ParseMapRecord(recText: string): mapRecord;

implementation
uses
  StrUtils, XSBuiltIns, DateUtils, UStatus, UGlobals, UUtil1;

procedure ImportUAOOrder(filePath: string);
var
  order: TUniversalOrder;
  //activeDoc: TComponent;
  fUID: TFormUID;
  begin
  If not FileExists(filePath) then
    exit;
  order := TUniversalOrder.Create;
  try
    try
      with order do
        begin
          FDoc := TMain(Application.MainForm).NewEmptyContainer;     //always import order in the new container
          //insert Order Form
          fUID := TFormUID.Create(universalOrderFormID);
          try
            orderForm := FDoc.InsertFormUID(fUID, true, -1);
            FDoc.SetupUserProfile(true);
            if not assigned(orderForm) then
              raise Exception.Create('Cannot find order form!');
          finally
            fUID.Free;
          end;
          //create XML document from order
          orderXMLDoc := CreateOrderXML(filePath);
          //get map file for order
          mapStringList := GetMapList;
          //mapstringList.SaveToFile('C:\temp\orderTextFile.txt');
         DoImportOrder;
        end;
    except
      on E: Exception do
      begin
        ShowAlert(atWarnAlert, E.Message);
        exit;
      end;
    end;
  finally
    if assigned(order) then
      order.Free;
  end;
end;

//create xml document  and validate it
function CreateOrderXML(filePath: string):IXMLDomDocument2;
var
  xmlDoc: IXMLDomDocument2;
  curNode: IXMLDomNode;
begin
  xmlDoc := CoDomdocument.Create;
  with xmlDoc do
    begin
      async := false;
      setProperty('SelectionLanguage', 'XPath');
      load(filePath);
      if parseError.errorCode <> 0 then
        raise Exception.Create('Invalid Order XML File');
      curNode := SelectSingleNode(xPathFormatID);
      if not (assigned(curNode) and  (compareText(curNode.text, rallyOrderFormatID) = 0)) then
        raise Exception.Create('Invalid Order XML File');
      curNode := SelectSingleNode(xPathPort);
      if not (assigned(curNode) and  (compareText(curNode.text, rallyPort) = 0)) then
        raise Exception.Create('Invalid Order XML File');
      result := xmlDoc;
    end;
end;

function GetMapList: TStringList;
const
  mapFileMask = 'OrderFormmap_F00000';
  ordersSubDir = 'Orders';
  mapFileExt = '.csv';
var
  ordersDir: String;
  fName: String;
  mapFilePath: string;
begin
  fName := IntToStr(universalOrderFormID);
  fName := Copy(mapFileMask,1,Length(mapFileMask) - length(fName)) + fName ;
  ordersDir := (IncludeTrailingPathDelimiter(appPref_DirTools) + ordersSubDir);
  mapFilePath := IncludeTrailingPathDelimiter(ordersDir) + fName + mapFileExt;
  if not FileExists(mapFilePath) then
    raise Exception.Create('Cannot find orders map file');
  result := TStringList.Create;
  result.Delimiter := ',';
  try
    result.LoadFromFile(mapFilePath);
  except
    raise Exception.Create('Invalid map file!');
  end;;
end;

function ParseMapRecord(recText: string): mapRecord;
const
  delim = ',';
var
  startPos, nextDelimPos: Integer;
  fldText: String;
  cellNum: Integer;
  specFlag: Integer;
begin
  result.cellNum := 0;
  result.specFlag := 0;
  result.Param := '';
  result.XPath := '';
  //field cell #
  startPos := 1;
  nextDelimPos := Pos(delim, recText);
  if nextDelimPos = 0 then
    raise Exception.Create('Invalid map file!');
  fldText := Copy(recText, startPos, nextDelimPos - startPos);
  cellNum := StrToIntDef(fldText,0);
  if cellNum = 0 then
    raise Exception.Create('Invalid map file!');
  result.cellNum := cellNum;
  //field special flag
  startPos := nextDelimPos + 1;
  nextDelimPos := PosEx(delim, recText, startPos);
  if nextDelimPos = 0 then
    raise Exception.Create('Invalid map file!');
  if nextDelimPos > startPos then //field not empty
    begin
      fldText := Copy(recText, startPos, nextDelimPos - startPos);
      specFlag := StrToIntDef(fldText,0);
      result.specFlag := specFlag;
    end;
  //field parameter
  startPos := nextDelimPos + 1;
  nextDelimPos := PosEx(delim, recText, startPos);
  if nextDelimPos = 0 then
    raise Exception.Create('Invalid map file!');
  if nextDelimPos > startPos then //field not empty
    begin
      fldText := Copy(recText, startPos, nextDelimPos - startPos);
      result.Param := fldText;
    end;
  //field XPath
  startPos := nextDelimPos + 1;
  if startPos > length(recText) then
    raise Exception.Create('Invalid map file!');
  fldText := Copy(recText, startPos, length(recText) - startPos + 1);
  result.XPath := fldText;
end;

procedure TUniversalOrder.DoImportOrder;
var
  RecNum: Integer;
  mapRec: MapRecord;
  node: IXMLDOMNode;
  cellText: string;
begin
  for recNum := 0 to mapStringList.Count - 1 do
    begin
      mapRec := ParseMapRecord(mapStringList[recNum]);
      node := orderXMLDoc.selectSingleNode(mapRec.XPath);
      if assigned(node) then
        begin
          CellText := node.text;
          if mapRec.specFlag > 0 then
            cellText := SpecialHandling(mapRec.specFlag, mapRec.Param, cellText);
          if length(cellText) > 0 then
            if orderForm.frmPage[0].pgData[mapRec.cellNum -1].FEmptyCell then  //do not overun existing text: license cell text
              orderForm.frmPage[0].pgData[mapRec.cellNum -1].LoadContent(cellText,true);
        end;

    end;
end;

function TUniversalOrder.SpecialHandling(fnID: Integer; param: String; clText: String): String;
const
  flagCheckCheckBox = 1;
  flagCheckIfMoreThan0 = 2;
  flagExtractDateOfDateTime = 3;
  flagExtractDayOfDateTime = 4;
  flagExtractTimeOfDateTime = 5;
  flagCheckAM_PMofDateTime = 6;
  flagConvertXMLDateToDateTime = 7;
  flagReplaceEOLwithSpace = 8;

  strAM = 'AM';
  strPM = 'PM';

  checkMark = 'X';

  cr  = #$D;
  newLine = #$0A;
  spaces = '  ';
var
  dt: TDateTime;
  hr, min: Integer;
  tmpStr: String;
begin
  result := '';
  case fnID of
    flagCheckCheckBox: result := checkMark;
    flagCheckIfMoreThan0:
      if (length(clText) > 0) and (StrToIntDef(clText,0) > 0) then
        result := checkMark;
    flagExtractDateOfDateTime:
       begin
        dt := XMLTimeToDateTime(clText);
        result := DateToStr(DateOf(dt));
      end;
    flagExtractDayOfDateTime:
      begin
        dt := XMLTimeToDateTime(clText);
        result := FormatDateTime('dddd',dt);
      end;
    flagExtractTimeOfDateTime:
      begin
        dt := XMLTimeToDateTime(clText);
        hr := HourOf(dt);
        min := MinuteOF(dt);
        if (hr > 0) or (min > 0) then
          result := FormatDateTime('hh:nn',dt);
      end;
    flagCheckAM_PMofDateTime:
      begin
        dt := XMLTimeToDateTime(clText);
        if isPM(dt) then
          if CompareText(strPM, param) = 0 then
            result := checkMark
        else
          if CompareText(strAM, param) = 0 then
            result := checkMark;
      end;
    flagConvertXMLDateToDateTime:
      begin
        dt := XMLTimeToDateTime(clText,True);
        result := DateToStr(DateOf(dt));
      end;
    flagReplaceEOLwithSpace:
      begin
      tmpStr := StringReplace(clText,cr + newLine,spaces,[rfReplaceAll]);
      tmpStr := StringReplace(tmpStr,cr,spaces,[rfReplaceAll]);
      tmpStr := StringReplace(tmpStr,newLine,spaces,[rfReplaceAll]);
      result := tmpStr;
    end;
  end;
end;

end.
