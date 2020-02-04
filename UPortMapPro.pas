unit UPortMapPro;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2005 by Bradford Technologies, Inc. }

interface

  uses
    Windows, SysUtils, xmlDoc, XMLIntf,
    UPortBase, UContainer;

  const
    MapProNotifyMsgID = 'Click_MapProDone';
    inputXmlMapProFName = 'ClickMap.xml';
    outputXmlMapProFName = 'ClickResult.xml';
    tempDir = 'Temp';
    strNoSplash = '/nosplash';
    mbxMapProFile = 'mapPro.mbx';
    msxmlDomVendor = 'MSXML';
    strCheck = 'X';
    strYes = 'Yes';
    strNo = 'No';
    
    //nodes
    nd_eFolder = 'eFolder';
    nd_eOrder = 'eOrder';
    nd_section = 'section';
    nd_tag = 'tag';
    nd_eData = 'eData';
    nd_eAttachments = 'eAttachments';
    nd_attachment = 'attachment';
    nd_imagedata = 'imagedata';
    nd_image = 'image';
    nd_path = 'path';
     //attributes' types
    attrType_name = 'name';
    attrType_type = 'type';
    attrType_number = 'number';
    attrType_provider = 'provider';
    attrType_key = 'key';
    attrType_label = 'label';
    attrType_id = 'id';
    attrType_format = 'format';
    //attributes
    attr_DosFileName = 'DOSFILENAME';
    attr_subjPropAddr = 'SUBJ_PROPERTY_ADDRESS.1';
    attr_City = 'CITY.1';
    attr_State = 'STATE.1';
    attr_Zip = 'ZIP_CODE.1';
    attr_County = 'COUNTY.1';
    attr_MapRef = 'MAP_REFERENCE.1';
    attr_FileNumber = 'FORM_FILE_NUMBER.1';
    attr_Borrower = 'BORROWER_NAME.1';
    attr_Lender = 'LENDER_CLIENT_NAME.1';
    attr_LocationMap = 'Location Map';
    attr_FloodMap = 'Flood Map';
    attr_HazardsMap = 'Hazards Map';
    attr_map = 'map';
    attr_Descriptiion = 'DESCRIPTION';

    attrNameCensusTract = 'CENSUS_TRACT.1';
    attrNameFemaZone = 'SITE_FEMA_ZONE.1';
    attrNameFemaMapDate = 'SITE_FEMA_MAP_DATE.1';
    attrNameFemaMapNum = 'SITE_FEMA_MAP_NUMBER.1';
    attrNameFloodHazardYes = 'SITE_FLOOD_HAZARD_YES_X.1';
    attrNameFloodHazardNo = 'SITE_FLOOD_HAZARD_NO_X.1';

    //cells ID
    cid_County = 50;
    cid_MapRef = 598;
    cid_FileNo = 2;
    cid_Borrower = 45;
    cid_Lender = 35;

    nCompsTypes = 5; //subject,sale,rental,listing,land
    //keep sync with  ct...Type constants in the UCompMgr
    //at the present ClickForms does not have land comp as the separate comp type,
    //so UCompMgr does not have a constant fo it

    //indexes in MapProTags table
    tagClfLabel = 0;
    tagSection = 1;
    tagAddress1 = 2;
    tagAddress2 = 3;
    tagProximity = 4;
    tagLatitude = 5;
    tagLongitude = 6;
    MapProCompsTags: Array[0..4,0..6] of String =
      (('SUBJECT','subject','','','','LATITUDE.1','LONGITUDE.1'),
        ('SALE','salescomp','GS_ADDRESS.1','GS_ADDRESS.2','GS_PROXIMITY.1','GS_LATITUDE.1','GS_LONGITUDE.1'),
        ('RENTAL','rentalcomp','GR_ADDRESS.1','GR_ADDRESS.2','GR_PROXIMITY.1','GR_LATITUDE.1','GR_LONGITUDE.1'),
        ('LISTING','listingcomp','GL_ADDRESS.1','GL_ADDRESS.2','GL_PROXIMITY.1','GL_LATITUDE.1','GL_LONGITUDE.1'),
        ('LAND','landcomp','GV_ADDRESS.1','GV_ADDRESS.2','GV_PROXIMITY.1','GV_LATITUDE.1','GV_LONGITUDE.1'));


  type
    CompID = record
      cmpType: Integer;
      compNo: Integer;
    end;

    TMapProPort = class(TPortMapper)
      private
        FWorkDir: String;
        FDoc: Tcontainer;
        FCompsList: Array of CompID;
        function GetWorkDir: String;
        function ExportSubject(orderNode: IXMLNode): Boolean;
        function ExportComps(orderNode: IXMLNode;recNo: Integer): Boolean;
        procedure SetMapProCompsIds;
        function GetClfRecNo(cmpID: CompID): Integer;
        procedure ImportData(dataNode: IXMLNode); //proximity,latude,longgitude
        procedure ImportImages(attchsNode: IXMLNODE); //location map, flood map
      public
        procedure Launch; override;
        function ImportResults: Boolean;
        procedure CleanAfterMapPro;
        property WorkDir: String read GetWorkDir write FWorkDir;
    end;

    function GetCompTypeByClfTag(clfLabel: String): Integer;
    function GetCompTypeByMapProTag(mapProLabel: String): Integer;
    function GetMapType(mapProLabel: String): Integer;
    //Delphi v6 does not include this Windows API function.
    // We already use it locally it UInit.pas.InstallerCleanUp.
    //May be it has sense to declare it public in some unit.
    function GetLongPathName(ShortPathName:PChar;LongPathName: PChar;bufSize: DWORD): Integer; stdcall;
              external 'kernel32.dll' name 'GetLongPathNameA';
var
  WM_MapProDoneMsgID: LongWord;
  
implementation

uses
  SHFolder,SHlObj,Dialogs,XMLDOM, shellAPI,classes,
  UStrings, UStatus, UcompMgr, UGlobals, UBase;

function TMapProPort.GetWorkDir: String;
var
  pBuff: PChar;
  neededBufSize: Integer;
begin
  try
    pBuff := nil;
    GetMem(pBuff,MAX_PATH);
    try
 (* try
    // It is a little complicated because MapPro wants to keep interface XML files
    // in 'Document and Settings\userName\Local Settings\Temp' directory which
    // does not have a Windows CSIDL constant
    if SHGetSpecialFolderPath(Owner.Handle,pBuff,CSIDL_LOCAL_APPDATA,True) then
      result := ExtractFilePath(ExcludeTrailingPathDelimiter(pBuff)) + tempDir;
    if not DirectoryExists(result) then
      ForceDirectories(result);     *)
      neededBufSize := GetTempPath(MAX_PATH,pBuff);
      if neededBufSize = 0 then
        begin
          ShowNotice('Can not find the Temporary directory on the system'); //I do not think it ever happens
          exit;
        end;
      if neededBufSize >= MAX_PATH then
        begin
          FreeMem(pBuff);
          GetMem(pBuff, neededBufSize + 1);
          GetTempPath(MAX_PATH,pBuff);
        end;
    except
      ShowNotice('The system does not have enough memory. Can not open Map Pro');
    end;
      result := pBuff;
  finally
    FreeMem(pBuff);
  end;
end;

procedure TMapProPort.Launch;
var
  FXMLDoc: TXMLDocument;
  domVendor: TDomVendor;
  rootNode,curNode, curChildNode: IXMLNode;
  xmlQuery,xmlResponse : String;
  comp,nComps: Integer;
  cmdLine: String;
begin
  try
    SetMapProCompsIds;
    FDoc := TContainer(Owner.Owner);
    domVendor := GetDomVendor(msxmlDomVendor);
    FXmlDoc := TXMLDocument.Create(Owner);

    FXmlDoc.DOMVendor := domVendor;
    FXMLDoc.Options := [doNodeAutoCreate,doNodeAutoindent,doAttrNull];
    FXMLDoc.ParseOptions := [poValidateOnParse];
    FXMLDoc.Active := True;

    rootNode := FXMLDoc.CreateNode(nd_eFolder);
    FXMLDoc.DocumentElement := rootNode;
    curNode := rootNode.AddChild(nd_eOrder);
    curChildNode := curNode.AddChild(nd_tag);
    curChildNode.Attributes[attrType_name] := attr_DosFileName;
    curChildNode.NodeValue := 'New Report';
    if assigned(FDoc) then
      curChildNode.NodeValue := FDoc.docFileName;

    ExportSubject(curNode);
    nComps := Addresses.Count;
    for comp := 1 to nComps - 1 do
      ExportComps(curNode,comp);
    //clean after the previous session
    xmlQuery := IncludeTrailingPathDelimiter(WorkDir) + inputXmlMapProFName;
    xmlResponse := IncludeTrailingPathDelimiter(WorkDir) +  outputXmlMapProFName;
    if FileExists(xmlQuery) then    //usually MapPro deletes it
      DeleteFile(xmlQuery);
    if FileExists(xmlResponse) then
      DeleteFile(xmlResponse);
    FXmlDoc.SaveToFile(xmlQuery);

    cmdLine := strNoSplash + ' ' + ExtractFilePath(ApplicationPath) + mbxMapProFile;
    if ShellExecute(Owner.Handle,'open',PChar(ApplicationPath),PChar(CmdLine),nil,SW_SHOWNORMAL) <= 32 then
      raise EFCreateError.CreateFmt(errCannotRunTool,[ExtractFileName(ApplicationPath)]);
  except
    ShowNotice('There was a problem launching MapPro. Please ensure MapPro is properly installed.');
  end;
end;

function TMapProPort.ExportSubject(orderNode: IXMLNode): Boolean;
var
  curNode, curChildNode: IXMLNode;
begin
  curNode := orderNode.AddChild(nd_Section);
  curNode.Attributes[attrType_Type] := MapProCompsTags[ctSubjectType][tagSection];
  curNode.Attributes[attrType_number] := IntToStr(0);

  with TAddressData(Addresses[0]) do
    begin
      curChildNode := curNode.AddChild(nd_tag);
      curChildNode.Attributes[attrType_name] := attr_subjPropAddr;
      curChildNode.NodeValue := FStreetNo + ' ' + FStreetName;

      curChildNode := curNode.AddChild(nd_tag);
      curChildNode.Attributes[attrType_Name] := attr_city;
      curChildNode.NodeValue := FCity;

      curChildNode := curNode.AddChild(nd_tag);
      curChildNode.Attributes[attrType_Name] := attr_State;
      curChildNode.NodeValue := FState;

      curChildNode := curNode.AddChild(nd_tag);
      curChildNode.Attributes[attrType_name] := attr_Zip;
      curChildNode.NodeValue := FZip;
    end;

  if assigned(FDoc) then
    begin
      curChildNode := curNode.AddChild(nd_tag);
      curChildNode.Attributes[attrType_name] := attr_County;
      curChildNode.NodeValue := FDoc.GetCellTextByID(cid_County);

      curChildNode := curNode.AddChild(nd_tag);
      curChildNode.Attributes[attrType_name] := attr_MapRef;
      curChildNode.NodeValue := FDoc.GetCellTextByID(cid_MapRef);

      curChildNode := curNode.AddChild(nd_tag);
      curChildNode.Attributes[attrType_name] := attr_FileNumber;
      curChildNode.NodeValue := FDoc.GetCellTextByID(cid_FileNo);

      curChildNode := curNode.AddChild(nd_tag);
      curChildNode.Attributes[attrType_name] := attr_Borrower;
      curChildNode.NodeValue := FDoc.GetCellTextByID(cid_Borrower);

      curChildNode := curNode.AddChild(nd_tag);
      curChildNode.Attributes[attrType_name] := attr_Lender;
      curChildNode.NodeValue := FDoc.GetCellTextByID(cid_Lender);
    end;

  result := True;
end;

function TMapProPort.ExportComps(orderNode: IXMLNode;recNo: Integer): Boolean;
var
  curNode,curChildNode: IXMLNode;
  cmpType: Integer;
begin
  result := False;
  if FCompsList[recNo].compNo < 1 then //never happens
    exit;
  cmpType := FCompsList[recNo].cmpType;
  with TAddressData(Addresses[recNo]) do
    begin
      curNode := orderNode.AddChild(nd_section);
      curNode.Attributes[attrType_Type] := MapProCompsTags[cmpType][tagSection];
      curNode.Attributes[attrType_Number] := IntToStr(FCompsList[recNo].compNo);

      curChildNode := curNode.AddChild(nd_tag);
      curChildNode.Attributes[attrType_Name] := MapProCompsTags[cmpType][tagAddress1];
      curChildNode.NodeValue := FStreetNo + ' ' + FStreetName;

      curChildNode := curNode.AddChild(nd_tag);
      curChildNode.Attributes[attrType_Name] := MapProCompsTags[cmpType][tagAddress2];
        curChildNode.NodeValue := FCity + ', ' + FState + ' ' + FZip;
    end;
  result := True;
end;

function TMapProPort.ImportResults: Boolean;
var
  FXMLDoc: TXMLDocument;
  domVendor: TDomVendor;
  rootNode,curNode: IXMLNode;
  xmlPath: String;
  nd,nNodes: Integer;
begin
  result := False;
  xmlPath := IncludeTrailingPathDelimiter(WorkDir) + outputXmlMapProFName;
  if not FileExists(xmlPath) then
    begin
      ShowNotice('Can not find ' + outputXmlMapProFName);
      exit;
    end;
  try
    domVendor := GetDomVendor(msxmlDomVendor);
    FXmlDoc := TXMLDocument.Create(Owner);

    FXmlDoc.DOMVendor := domVendor;
    FXMLDoc.Options := FXMLDoc.Options - [doAttrNull];
    FXMLDoc.ParseOptions := [poValidateOnParse];
    FXMLDoc.FileName := xmlPath;
    FXMLDoc.Active := True;

    rootNode := FXMLDoc.DocumentElement;
    nNodes := rootNode.ChildNodes.Count;
    for nd :=0 to nNodes - 1 do
      begin
        curNode := rootNode.ChildNodes[nd];
        if CompareText(curNode.NodeName,nd_eData) = 0 then
          ImportData(curNode)
        else
          if CompareText(curNode.NodeName,nd_eAttachments) = 0 then
            ImportImages(curNode);
      end;

  except
    on E:exception do
      begin
        ShowNotice(E.Message);
        exit;
      end;
  end;
  result := True;
end;

procedure TMapProPort.SetMapProCompsIds;
var
  recNo,nComps: Integer;
  searchLabel,clfLabel: String;
  lbl: Integer;
begin
  nComps := Addresses.Count; //including subject
  SetLength(FCompsList,nComps);
  for recNo := 0 to  nComps - 1 do
    with TAddressData(Addresses[recNo]) do
      begin
        clfLabel := FLabel;
        FCompsList[recNo].cmpType := -1;
        for lbl := 0 to nCompsTypes - 1 do
          begin
            searchLabel := MapProCompsTags[lbl][tagClfLabel];
            if Pos(searchLabel,clfLabel) > 0 then
              begin
                FCompsList[recNo].cmpType := GetCompTypeByClfTag(searchLabel);
                FCompsList[recNo].compNo := StrToIntDef(Copy(clfLabel,length(searchLabel) + 2,length(clfLabel)),0);
                break;
              end;
          end;
      end;
end;

function TMapProPort.GetClfRecNo(cmpID: CompID): Integer;
var
  recNo,nRecs: Integer;
begin
  nRecs := length(FCompsList);
  result := -1;
  for recNo := 0 to nRecs - 1 do
    if (cmpID.cmpType = FCompsList[recNo].cmpType) and
        (cmpId.compNo = FCompsList[recNo].compNo) then
      begin
        result := recNo;
        exit;
      end;
end;

//proximity,latude,longgitude. At the present ClickForms uses only proximities
procedure TMapProPort.ImportData(dataNode: IXMLNode);
var
  nd1,nNodes1: Integer;
  curNode, curChildNode: IXMLNODE;
  sect: String;
  cmpType: Integer;
  cmpID : CompID;
  recNo: Integer;
  strTagName : String;
  bLastNode: Boolean;
begin
  nNodes1 := dataNode.ChildNodes.Count;
  for nd1 := 0 to nNodes1 - 1 do
    begin
      curNode := DataNode.ChildNodes[nd1];
      if CompareText(curNode.NodeName,nd_section) <> 0 then
        continue;
      sect := CurNode.Attributes[attrType_Type];
      cmpType := GetCompTypeByMapProTag(sect);
      if cmpType >= 0 then
        begin
          cmpId.cmpType := cmpType;
          cmpID.compNo := StrToIntDef(CurNode.Attributes[attrType_Number],0);
          recNo := GetClfRecNo(cmpID);
          if recNo >= 0 then
          begin
            curChildNode := curNode.ChildNodes.First;
             repeat
              bLastNode := (curChildNode = curNode.ChildNodes.Last);
              strTagName := curChildNode.Attributes[attrType_Name];
              if length(strTagName) = 0 then
                continue;
              if CompareText(strTagName,MapProCompsTags[cmpType][tagProximity]) = 0 then
                TAddressData(Addresses[recNo]).FProximity := curChildNode.Text;
              if CompareText(strTagName,MapProCompsTags[cmpType][tagLatitude]) = 0 then
                TAddressData(Addresses[recNo]).FLatitude := curChildNode.Text;
              if CompareText(strTagName,MapProCompsTags[cmpType][tagLongitude]) = 0 then
                TAddressData(Addresses[recNo]).FLongitude := curChildNode.Text;
              if CompareText(strTagName,attrNameCensusTract) = 0 then
                TAddressData(Addresses[recNo]).FCensusTract := curChildNode.Text;
              if CompareText(strTagName,attrNameFemaZone) = 0 then
                TAddressData(Addresses[recNo]).FFemaZone := curChildNode.Text;
              if CompareText(strTagName,attrNameFemaMapDate) = 0 then
                TAddressData(Addresses[recNo]).FFemaMapDate := curChildNode.Text;
              if CompareText(strTagName,attrNameFemaMapNum) = 0 then
                TAddressData(Addresses[recNo]).FFemaMapNum := curChildNode.Text;
              if CompareText(strTagName,attrNameFloodHazardYes) = 0 then
                if CompareText(strCheck,curChildNode.Text) = 0 then
                  TAddressData(Addresses[recNo]).FFloodHazard := strYes;
              if CompareText(strTagName,attrNameFloodHazardNo) = 0 then
                if CompareText(strCheck,curChildNode.Text) = 0 then
                  TAddressData(Addresses[recNo]).FFloodHazard := strNo;
              curChildNode := curChildNode.NextSibling;
            until bLastNode;
          end;
        end;
    end;
end;

procedure TMapProPort.ImportImages(attchsNode: IXMLNode);
var
  curNode,curChildNode,curGrandChildNode: IXMLNode;
  nd, nNodes,nd2,nNodes2: Integer;
  imgPath: PChar;
  mapProPath: String;
  neededBufSize: DWORD;
  imgType: Integer;
  lstImg: Integer;
  imgFrmt: String;
begin
  nNodes := attchsNode.ChildNodes.Count;
  for nd := 0 to nNodes - 1 do
    begin
      curNode := attchsNode.ChildNodes[nd];
      if CompareText(curNode.Attributes[attrType_Type],attr_Map) <> 0 then
        continue;
      curChildNode := curNode.ChildNodes.FindNode(nd_ImageData);
      if curChildNode = nil then
        continue;
      imgType := -1;
      nNodes2 := curchildNode.ChildNodes.Count;
      for nd2 := 0 to nNodes2 - 1 do
        begin
          curGrandChildNode := curChildNode.ChildNodes[nd2];
          if CompareText(curGrandChildNode.Attributes[attrType_name],attr_Descriptiion) = 0  then
            begin
              imgType := GetMapType(curGrandChildNode.Text);
              break;
            end;
        end;
      if imgType > 0 then
        begin
          curNode := curNode.ChildNodes.FindNode(nd_image);
          if curNode = nil then
            continue;
          curChildNode := curNode.ChildNodes.FindNode(nd_path);
          if curChildNode = nil then
            continue;
          imgFrmt := curNode.Attributes[attrType_Format];
          GetMem(imgPath,MAX_PATH);
          try
           mapProPath := curChildNode.Text;
           neededBufSize := GetLongPathName(PChar(mapProPath),imgPath,MAX_PATH);
           if neededBufSize = 0 then
            begin
              ShowNotice('Can not transfer the image to the ClickForms');
              continue;
            end
           else
            if neededBufSize > MAX_PATH then
              GetLongPathName(PChar(mapProPath),imgPath,neededBufSize + 1);
           if FileExists(imgPath) then
            begin
             SetLength(Images, length(Images) + 1);
              lstImg := length(Images) - 1;
              Images[lstImg].path := imgPath;
              Images[lstImg].imgType := imgType;
              Images[lstImg].format := imgFrmt;
              if imgType = imtLocationMap then
                FileDataPath := imgPath;
            end;
          finally
            FreeMem(imgPath);
          end;
        end;
    end;
end;

procedure TMapProPort.CleanAfterMapPro;
var
  xmlPath: String;
  img, nImgs: Integer;
begin
  xmlPath := IncludeTrailingPathDelimiter(WorkDir) + outputXmlMapProFName;
  if FileExists(xmlPath) then
    DeleteFile(xmlPath);
  nImgs := Length(Images);
  for img := 0 to nImgs - 1 do
    if FileExists(Images[img].path) then
      DeleteFile( Images[img].path);
end;

function GetCompTypeByClfTag(clfLabel: String): Integer;
var
  lbl: Integer;
begin
  result := -1;
  for lbl := 0 to nCompsTypes - 1do
    if CompareText(clfLabel,MapProCompsTags[lbl][tagClfLabel]) = 0 then
      begin
        result := lbl;
        break;
      end;
end;

function GetCompTypeByMapProTag(mapProLabel: String): Integer;
var
  lbl: Integer;
begin
  result := -1;
  for lbl := 0 to length(MapProCompsTags) - 1 do
    if CompareText(mapProLabel,MapProCompsTags[lbl][tagSection]) = 0 then
      begin
        result := lbl;
        break;
      end;
end;

function GetMapType(mapProLabel: String): Integer;
begin
  result := -1;
  if CompareText(mapProLabel,attr_LocationMap) = 0 then
    result := imtLocationMap;
  if CompareText(mapProLabel,attr_FloodMap) = 0 then
    result := imtFloodMap;
  if CompareText(mapProLabel,attr_HazardsMap) = 0 then
    result := imtHazardsMap;
end;

initialization
  WM_MapProDoneMsgID := RegisterWindowMessage(MapProNotifyMsgID);
end.
