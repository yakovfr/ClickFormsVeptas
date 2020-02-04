unit UConvertWinTotal;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 2005 by Bradford Technologies, Inc. }

interface

uses
    xmlIntf,xmlDoc,Classes,
    UContainer;

  procedure ImportWinTotalXML;



implementation

uses
  Forms,Dialogs,sysUtils,xmlDom,Graphics,Windows,
  UMain,UGlobals,UStatus,UBase,UForm,UCell, UUtil1,UUtil2;


const
  WinTotalMapFolder = 'converters\WinTotal';
  WinTotalFormList = 'formlist.xml';
  WinTotalMainFormList = 'mainForms.csv';
  ExceptCellList = 'exceptcells.xml';

  wtPrefix = 'wt';
  csvExt = '.csv';
  emfExt = '.emf';

  msxmlDomVendor = 'MSXML';

  tagForms = 'FORMS';
  tagForm = 'FORM';
  attrFormCode = 'FORMCODE';
  attrSecCode = 'SECCODE';
  attrMajorForm = 'MAJORFORM';
  attrSecCodeSubjectPhotos = 'SR';
  attrSecCodeAdditComps = '(AC)';
  attrType = 'TYPE';
  tagFields = 'FIELDS';
  attrDesc = 'DESC';
  attrFirstComp = 'FIRSTCOMP';
  tagException = 'EXCEPTION';
  tagID = 'ID';
  attrFunction = 'FUNCTION';
  tagParam = 'PARAM';
  tagAddendatext = 'ADDENDATEXT';
  tagFormPhotos = 'FORMPHOTOS';
  tagPhotos = 'PHOTOS';
  tagPhoto = 'PHOTO';
  tagFileName = 'FILENAME';
  tagSubjectPhotos = 'SUBJECTPHOTOS';
  tagSubjectPhoto = 'SUBJECTPHOTO';
  wtCmntForm = 'TADD';

  sbjPhotoPageUnknown = 0;
  sbjPhotoPagePrimary = 1;
  sbjPhotoPageAdditional = 2;

  errInvalidFormat = '%s is not the valid WinTotal XML file';
  errCantFindMap = 'Can not find map File: %s';
  errInvalidMapFile = '%s is not the valid map File';
  errUnknownMainForm = 'Unknown main Form: %s';
  commonCell = 0;
  imageCell = 1;
  sketchCell = 2;
  commentPage = 3;

  cnstMark = '#';
  fnMerge = 'merge';

  frmIdOrDelimiter = '|';
  frmIDAndDelimiter = '$';
type
   clfFormIDs = Array of Integer;
   TWinTotalXML = class(TObject)
    public
      constructor Create(AOwner: TComponent);
    private
      FFormList: TXMLDocument;
      FExcList: TXMLDocument;
      FWorkDir: String;
      FMapDir: String;
      FSrcName: String;
      FXMLDoc: TXMLDocument;
      FDoc: TContainer;
      majorForm: String;
      procedure Import;
      procedure ImportForm(frmID: Integer; firstComp: Integer; fldsNode: IXMLNode);
      procedure ImportComment(frmID: Integer; frmNode: IXMLNode);
      function AddCmntPage(frmID: Integer; map: TStringList;fldsNode: IXMLNode; cmnt: String): String;
      function FindForm(frmNode: IXMLNode): clfFormIDs;
      function GetSubjectPhotoForm(frmNode: IXMLNode; frmIDs: String): Integer;
      function LoadMapFile(fmID: Integer; var map: TStringList): Boolean;
      function HandleExceptions(excID: Integer;fldsNode: IXMLNode): String;
      function GetAdditComps: Integer;
  end;

  TClickFormsCell = class(TObject)
    pageNo, cellNo: Integer;
    cellType: Integer; // text: 0, image: 1 ,sketch: 2, exceptions < 0
  end;

  procedure OpenXmlDocument(xmlFile: String; var xmlDoc: TXMLDocument); forward;
  function GetExceptionText(prmList: TStringList): String; forward;
  function Merge(prmList: TStringList): String; forward;
  function GetSubjPhotoType(TypeStr: String): Integer; forward;

procedure ImportWinTotalXML;
var
  wtXmlDoc: TWinTotalXML;
begin
  wtXmlDoc := TWinTotalXML.Create(Application.MainForm);
  try
    try
      wtXMLDoc.Import;
    except
      on E:Exception do
        ShowNotice(E.Message);
    end;
  finally
    wtXMLDoc.Free;
  end;
end;

procedure OpenXmlDocument(xmlFile: String; var xmlDoc: TXMLDocument);
begin
  if not FileExists(xmlFile) then
    exit;
  with xmlDoc do
    begin
      Active := False;
      DOMVendor := GetDomVendor(msxmlDomVendor);
      Options := Options - [doAttrNull];
      ParseOptions := [poValidateOnParse];
      FileName := xmlFile;
      Active := True;
    end;
end;

function GetExceptionText(prmList: TStringList): String;
begin
  if CompareText(prmList[0],fnMerge) = 0 then
    begin
      result := Merge(prmList);
      exit;
    end;
end;

function Merge(prmList: TStringList): String;
var
  rec: Integer;
begin
  result := '';
  for rec := 1 to prmList.Count - 1 do  //the first record is the function name
    result := result + prmList[rec];
end;

function GetSubjPhotoType(TypeStr: String): Integer;
const
  strFront = 'FRONT';
  strRear = 'REAR';
  strStreet = 'STREET';
  strOther = 'OTHER';
begin
  result := sbjPhotoPageUnknown;
  if CompareText(typestr,strFront) = 0 then
    result := sbjPhotoPagePrimary;
  if CompareText(typestr,strRear) = 0 then
    result := sbjPhotoPagePrimary;
  if CompareText(typestr,strStreet) = 0 then
    result := sbjPhotoPagePrimary;
  if CompareText(typestr,strOther) = 0 then
    result := sbjPhotoPageAdditional;
end;

{ TWinTotalXML }

constructor TWinTotalXML.Create(AOwner: TComponent);
begin
  FXMLDoc := TXMLDocument.Create(AOWner);
  FFormList := TXMLDocument.Create(AOwner);
  FExcList := TXMLDocument.Create(AOwner);
  inherited Create;
end;

function TWinTotalXml.FindForm(frmNode: IXMLNode): clfFormIDs;
var
  frmsMapNode: IXMLNode;
  nd,nNodes: Integer;
  secCode: String;
  delimPos: Integer;
  frmID: Integer;
begin
  frmsMapNode := FFormList.DocumentElement.ChildNodes.FindNode(tagForms);
  if not assigned(frmsMapNode) then
    raise Exception.CreateFmt(errInvalidMapFile,[WinTotalFormList]);
  if not frmNode.HasAttribute(attrFormCode) then
    raise Exception.CreateFmt(errInvalidFormat,[FSrcName]);
  nNodes := frmsMapNode.ChildNodes.Count;
  for nd := 0 to nNodes - 1 do
    with frmsMapNode.ChildNodes[nd] do
      begin
        if (CompareText(NodeName,tagForm) <> 0) or not HasAttribute(attrFormCode) then
          raise Exception.CreateFmt(errInvalidMapFile,[WinTotalFormList]);
        if CompareText(Attributes[attrFormCode],frmNode.Attributes[attrFormCode]) <> 0 then
          continue;
        if HasAttribute(attrSecCode) then
          begin
            if CompareText(Attributes[attrSecCode],frmNode.Attributes[attrSecCode]) <> 0 then
              continue;
            secCode := Attributes[attrSecCode];
          end;
        if HasAttribute(attrDesc) then
          if CompareText(Attributes[attrDesc],frmNode.Attributes[attrDesc]) <> 0 then
            continue;
        if CompareText(secCode,attrSecCodeSubjectPhotos) = 0 then
          begin
            SetLength(result,1);
            result[0] := GetSubjectPhotoForm(frmNode,Text)  //primary or additional
          end
        else
          if CompareText(secCode,attrSecCodeAdditComps) = 0 then
            begin
              SetLength(result,1);
              result[0] := GetAdditComps
            end
          else
            begin
              secCode := text;
              delimPos := Pos(frmIdAndDelimiter,text);
              while delimPos > 0 do
                begin
                  frmID := strToIntDef(Copy(Text,1,delimPos - 1),0);
                  if frmID > 0 then
                    begin
                      SetLength(result,length(result) + 1);
                      result[length(result) - 1] := frmID;
                    end;
                  text := Copy(text,delimPos + 1,length(text));
                  delimPos := Pos(frmIdAndDelimiter,text);
                end;
              if length(text) > 0 then
                begin
                  frmID := strToIntDef(Text,0);
                  if frmID > 0 then
                    begin
                      SetLength(result,length(result) + 1);
                      result[length(result) - 1] := frmID;
                    end;
                end;
            end;
        break;
      end;
end;

procedure TWinTotalXML.Import;
var
  opDialog: TOpenDialog;
  rtNode,frmsNode,fieldsNode: IXMLNode;
  indx: Integer;
  flPath: String;
  frm,frmID,firstComp : Integer;
  frmIDs:  clfFormIDs;
begin
  //get xml file
  opDialog := TOpenDialog.Create(Application.MainForm);
  opDialog.title := 'Select WinTotal XML file to Convert';
  try
    opDialog.Filter := 'WinTotal XML (*.xml)|*.xml';
    opDialog.Options := [ofReadOnly,ofFileMustExist];
    if opDialog.Execute then
      begin
        OpenXmlDocument(opDialog.FileName,FXMLDoc);
        FWorkDir := ExtractFileDir(opDialog.FileName);
        FSrcName := ExtractFileName(opDialog.FileName);
      end
    else
      exit;
  finally
    opDialog.Free;
  end;

  //get map directory
  FMapDir := IncludeTrailingPathDelimiter(appPref_DirTools) + WinTotalMapFolder;
  if not DirectoryExists(FMapDir) then
    raise Exception.Create('The conversion map file could not be located.');

  //create ClickForms document
  FDoc := TMain(Application.MainForm).NewEmptyDoc;
  //Get Forms List
  flPath := IncludeTrailingPathDelimiter(FMapDir) + WinTotalFormList;
  if not FileExists(flPath) then
    raise Exception.CreateFmt(errCantFindMap,[WinTotalFormList]);

  OpenXMLDocument(flPath,FFormList);
  rtNode := FXmlDoc.DocumentElement;
  //get Exception List
  flPath := IncludeTrailingPathDelimiter(FMapDir) +  exceptcellList;
  if not FileExists(flPath) then
    raise Exception.CreateFmt(errCantFindMap,[exceptCellList]);
  OpenXMLDocument(flPath,FExcList);
  //get major form
  majorForm := '';
  if rtNode.HasAttribute(attrMajorForm) then
    majorForm := rtNode.Attributes[attrMajorForm];
  //get Forms
  firstComp := 0;
  frmsNode := FXmlDoc.DocumentElement.ChildNodes.FindNode(tagForms);
  if not Assigned(frmsNode)  or not frmsNode.HasChildNodes then
    raise Exception.CreateFmt(errInvalidFormat,[FSrcName]);
  for indx := 0 to frmsNode.ChildNodes.Count - 1 do
    if CompareText(frmsNode.ChildNodes[indx].NodeName,tagForm) = 0 then
      try
        frmIDs := FindForm(frmsNode.ChildNodes[indx]);
        if length(frmIDs) > 0 then
        with frmsNode.ChildNodes[indx] do
          begin
            fieldsNode := ChildNodes.FindNode(tagFields);
            if not assigned(fieldsNode) then
              raise Exception.CreateFmt(errInvalidFormat,[FSrcName]);
            if HasAttribute(attrFirstComp) then
              firstComp := StrToIntDef(Attributes[attrFirstComp],0);
            for frm := 0 to length(frmIDs) - 1 do
              begin
                frmID := frmIDs[frm];
                if FrmID > 0 then
                  if CompareText(frmsNode.ChildNodes[indx].Attributes[attrFormCode],wtCmntForm) = 0 then
                    ImportComment(frmID,frmsNode.ChildNodes[indx])
                  else
                    ImportForm(frmId,FirstComp,fieldsNode);
              end;
          end;
      finally
        SetLength(frmIDs,0);
      end;
end;

procedure TWinTotalXML.ImportForm(frmID: Integer; firstComp: Integer; fldsNode: IXMLNode);
var
  indx: Integer;
  frmUID: TFormUID;
  formMap: TStringList;
  rec,nRecs: Integer;
  nd,nNodes: Integer;
  frm: TDocForm;
  pgNo, clNo, clType: Integer;
  cell: TBaseCell;
  clText: String;
  flPath,renFlPath: String;
begin
    //load map file
    formMap := TStringList.Create;
    try
      if not LoadMapFile(frmID,formMap) then
        exit;
      //insert empty form
      frmUID := TFormUID.Create(frmID);
      try
        frm := FDoc.InsertFormUID(frmUID,True,-1);
      finally
        frmUID.Free;
      end;
      //transfer data to ClickForms
      nNodes := fldsNode.ChildNodes.Count;
      for nd := 0 to nNodes - 1 do
        with fldsNode.ChildNodes[nd] do
          begin
            if  not formMap.Find(NodeName,indx) then
              continue;
            with TClickFormsCell(formMap.Objects[indx]) do
              begin
                pgNo := pageNo;
                clNo := cellNo;
                clType := cellType;
              end;
            if (length(Text) > 0) and (pgNo > 0) and (clNo > 0) then
              case clType of
                commonCell:
                  frm.SetCellDataNP(pgNo,clNo,Text); //we transfer each cell, so we do not need post processing
                imageCell:
                  begin
                    cell := frm.GetCell(pgNo,clNo);
                    flPath := IncludeTrailingPathDelimiter(FWorkDir) + Text;
                    if FileExists(flPath) then
                      TGraphicCell(Cell).SetText(flPath);
                  end;
                sketchCell:
                  begin
                    cell := TGraphicCell(frm.GetCell(pgNo,clNo));
                    flPath := IncludeTrailingPathDelimiter(FWorkDir) + Text;
                    renFlPath := ChangeFileExt(flPath,emfExt);
                    if not FileExists(renFlPath) then
                      RenameFile(flPath,RenFlPath);
                    if FileExists(RenFlPath) then
                      TGraphicCell(cell).SetText(RenFlPath);
                  end;
                else
                  if clType < 0  then //exceptions
                    begin
                      clText := HandleExceptions(abs(clType),fldsNode);
                      if length(clText) > 0 then
                        frm.SetCellDataNP(pgNo,clNo,clText);
                    end;
              end;
          end;
    finally
      nRecs := formMap.Count;
      for rec := 0 to nRecs - 1 do
        formMap.Objects[rec].Free;
      formMap.Free;
    end;
end;

function TWinTotalXML.LoadMapFile(fmID: Integer; var map: TStringList): Boolean;
var
  mapFName,mapFPath: String;
  recs: TStringList;
  rec, nRecs: Integer;
  delimPos: Integer;
  pgNo, clNo, clType: Integer;
  curRec, tmpStr, curFld: String;
  cellObj: TClickFormsCell;
begin
  result := False;
  mapFName := wtPrefix + IntToStr(fmID) + csvExt;
  mapFPath := IncludeTrailingPathDelimiter(FMapDir) +  mapFName;
  if not FileExists(mapFPath) then
    exit;
  map.Clear;
  map.Sorted := True;
  recs := TStringList.Create;
  try
    recs.LoadFromFile(mapFPath);
    nRecs := recs.Count;
    for rec := 0 to nRecs -1 do
      begin
        curRec := recs[rec];
        delimPos := Pos(',',curRec);  //Field name
        if delimPos = 0 then
          continue; //just field name: no transfer
        curFld := Copy(curRec,1,delimPos - 1);
        tmpStr := Copy(curRec,delimPos + 1,length(curRec));
        delimPos := Pos(',',tmpStr);    //cell #
        if delimPos = 0 then   //if cell#  is presented the page# has to be present
          raise Exception.CreateFmt(errInvalidMapFile,[mapFName]);
        clNo := StrToIntDef(Copy(tmpStr,1,delimPos - 1),0);
        if clNo = 0 then
          continue;
        tmpStr := Copy(tmpStr,delimPos + 1,length(tmpStr));
        delimPos := Pos(',',tmpStr);    //page #
        if delimPos = 0 then   //it is the last field because the default cell type skipped
          begin
            pgNo := StrToIntDef(tmpStr,0);
            clType := commonCell;
          end
        else  //continue parsing
          begin
            pgNo := StrToIntDef(Copy(tmpStr,1,delimPos - 1),0);
            tmpStr := Copy(tmpStr,delimPos + 1,length(tmpStr));
            delimPos := Pos(',',tmpStr);   //cell Type
            if delimPos = 0 then  // it is the last field
              clType := StrToIntDef(tmpStr,0)
            else  //there are some description fields
              cltype := StrToIntDef(Copy(tmpStr,1,delimPos - 1),0);
          end;
        cellObj := TClickFormsCell.Create;
        cellObj.cellNo := clNo;
        cellObj.pageNo := pgNo;
        cellObj.cellType := clType;
        map.AddObject(curFld,cellObj);
      end;
    result := True;
  finally
    recs.Free;
  end;
end;

function TWinTotalXML.HandleExceptions(excID: Integer;fldsNode: IXMLNode): String;
var
  excNode: IXMLNode;
  nd, nNodes: Integer;
  fldNode, nFldNodes : Integer;
  paramList: TStringList;
  curParam: String;
begin
  result := '';
  nFldNodes := fldsNode.ChildNodes.Count;
  //find the exception
  if not FExcList.DocumentElement.HasChildNodes then
    exit;
  nNodes := FExcList.DocumentElement.ChildNodes.Count;
  for nd := 0 to nNodes - 1 do
    begin
      excNode := FExcList.DocumentElement.ChildNodes[nd];
      if CompareText(excNode.NodeName,tagException) <> 0 then
        continue;
      if not excNode.HasAttribute(tagID) then
        raise Exception.CreateFmt(errInvalidMapFile,[ExtractFileName(fExcList.FileName)]);
      if StrToIntDef(excNode.Attributes[tagID],0) = excID then
        break;
   end;
   if nd = nNodes then  //did not find
    exit;
   //load function name and parameters
   if not excNode.HasChildNodes then
    exit;
   nNodes := excNode.ChildNodes.Count;
   paramList := TStringList.Create;
   try
    if not excNode.HasAttribute(attrFunction) then
      raise Exception.CreateFmt(errInvalidMapFile,[ExtractFileName(fExcList.FileName)]);
    paramList.Add(excNode.Attributes[attrFunction]);  // the first record is the function name
    for nd := 0 to nNodes - 1 do
      with  excNode.ChildNodes[nd] do
        begin
          if CompareText(NodeName,tagParam) <> 0 then
            raise Exception.CreateFmt(errInvalidMapFile,[ExtractFileName(fExcList.FileName)]);
          curParam := Text;
          if length(curParam) = 0 then
            raise Exception.CreateFmt(errInvalidMapFile,[ExtractFileName(fExcList.FileName)]);
          if curParam[1] = cnstMark then //constant
            paramList.Add(Copy(curParam,2,Length(curParam) - 2)) //take const marks away
          else  //node name
            begin
              for fldNode := 0 to nFldNodes - 1 do
                if CompareText(fldsNode.ChildNodes[fldNode].NodeName,curParam) = 0 then
                  begin
                    paramList.Add(fldsNode.ChildNodes[fldNode].Text);
                    break;
                  end;
              if fldNode = nFldNodes then //did not find the node Exception table references to
                raise Exception.CreateFmt(errInvalidMapFile,[ExtractFileName(fExcList.FileName)]);
            end;
        end;
    result := GetExceptionText(paramList);
   finally
    paramList.Free;
   end;
end;

procedure TWinTotalXML.ImportComment(frmID: Integer; frmNode: IXMLNode);
var
  cmnt: String;
  bOK: Boolean;
  fldsNode, cmntNode: IXMLNode;
  formMap: TStringList;
  remainCmnt: String;
  rec,nRecs: Integer;
begin
  fldsNode := frmNode.ChildNodes.FindNode(tagFields);
  bOK := assigned(fldsNode);
  if bOK then
    begin
      cmntNode := fldsNode.ChildNodes.FindNode(tagAddendaText);
      bOK := assigned(cmntNode);
    end;
    if bOK then
      begin
        cmnt := cmntNode.Text;
        bOK := True;
      end;

  if not bOK then
    exit;
  formMap := TStringList.Create;
  remainCmnt := SetCRLF(cmnt);
  try
    LoadMapFile(frmID,formMap);
     fldsNode := frmNode.ChildNodes.FindNode(tagFields);
     bOK := assigned(fldsNode);
     if bOK then
      while length(remainCmnt) > 0 do
        remainCmnt := AddCmntPage(frmID,formMap,fldsNode,remainCmnt);
  finally
    nRecs := formMap.Count;
    for rec := 0 to nRecs - 1 do
      formMap.Objects[rec].Free;
    formMap.Free;
  end;
end;

function TWinTotalXML.AddCmntPage(frmID: Integer; map: TStringList;fldsNode: IXMLNode; cmnt: String): String;
var
  frmUID: TFormUID;
  frm: TDocForm;
  nd, nNodes: Integer;
  indx: Integer;
  pgNo,clNo,clType: Integer;
  canv: TCanvas;
  tmpFontSize: Integer;
  cmntCell: TBaseCell;
  maxLines, maxPixWidth, scaledMaxWidth: Integer;
  LnLengths: IntegerArray;
  curLine, pgLen: Integer;
  curPageText: String;
begin
  result := '';
  frmUID := TFormUID.Create(frmID);
  try
    frm := FDoc.InsertFormUID(frmUID,True,-1);
  finally
    frmUID.Free;
  end;
  nNodes := fldsNode.ChildNodes.Count;
  for nd := 0 to nNodes - 1 do
    with fldsNode.ChildNodes[nd] do
      begin
        if not map.Find(NodeName,indx) then
          continue;
        with TClickFormsCell(map.Objects[indx]) do
          begin
            pgNo := pageNo;
            clNo := cellNo;
            clType := cellType;
          end;
        if (pgNo > 0) and (clNo > 0) then
          case clType of
            commonCell:
              if length(Text) > 0 then
                frm.SetCellDataNP(pgNo,clNo,Text);
            commentPage:
              begin
                canv := FDoc.docView.Canvas;
                tmpFontSize := canv.Font.Height;
                cmntCell := frm.GetCell(pgNo,clNo);
                try
                  maxLines := TMlnTextCell(cmntCell).FMaxLines;
                  maxPixWidth := cmntCell.FTxRect.Right - cmntCell.FTxRect.Left + 1;
                  scaledMaxWidth := MulDiv(MaxPixWidth,FDoc.docView.PixScale,72);
                  canv.Font.Height := -MulDiv(cmntCell.FTxSize,FDoc.docView.PixScale,72);
                  WrapTextAdv(cmnt,canv,scaledMaxWidth,LnLengths);
                  if length(LnLengths) <= maxLines then
                    curPageText := cmnt
                  else
                    begin
                      pgLen := 0;
                      //calc page length in chars
                      for curLine := 0 to MaxLines -1 do
                        inc(pgLen,LnLengths[curLine]);
                      curPageText := Copy(cmnt,1,pgLen);
                      result := Copy(cmnt,pgLen + 1,length(cmnt));
                    end;
                  cmntCell.LoadContent(curPageText,False);
                finally
                  setLength(LnLengths,0);
                  canv.Font.Height := tmpFontSize;
                end;
              end;
          end;
      end;
end;

function TWinTotalXml.GetSubjectPhotoForm(frmNode: IXMLNode; frmIDs: String): Integer;
var
  delimPos: Integer;
  ndFormPhotos, ndFileName, ndPhotos,ndSubjectPhotos: IXMLNode;
  nd, nNodes: Integer;
  fileList: TStringList;
  pgType, curPhotoType: Integer;
  indx: Integer;
begin
  result := 0;
  delimPos := Pos(frmIDOrDelimiter,frmIDs);
  if delimPos = 0 then
    exit;
  //find photo files
  ndFormPhotos := frmNode.ChildNodes.FindNode(tagFormPhotos);
  if not assigned(ndFormPhotos) or not ndFormPhotos.HasChildNodes then
    exit;
  nNodes := ndFormPhotos.ChildNodes.Count;
  fileList := TStringList.Create;
  fileList.Sorted := True;
  fileList.Duplicates := dupIgnore;
  try
    for nd := 0 to nNodes - 1 do
    with ndFormPhotos.ChildNodes[nd] do
      begin
        if CompareText(NodeName,tagPhoto) <> 0 then
          continue;
        ndFileName := ChildNodes.FindNode(tagFileName);
        if not assigned(ndFileName) then
          continue;
        fileList.Add(ndFileName.Text);
      end;
  //is the files primary subject photos or additional ones
    ndPhotos := FXMLDoc.DocumentElement.ChildNodes.FindNode(tagPhotos);
    if not assigned(ndPhotos) then
      exit;
    ndSubjectPhotos := ndPhotos.ChildNodes.FindNode(tagSubjectPhotos);
    if not assigned(ndSubjectPhotos) then
      exit;
    nNodes := ndSubjectPhotos.ChildNodes.Count;
    pgType := sbjPhotoPageUnknown;
    for nd := 0 to nNodes - 1 do
      with ndSubjectPhotos.ChildNodes[nd] do
        begin
          if CompareText(tagSubjectPhoto,NodeName) <> 0 then
            continue;
          if not HasAttribute(attrType) then
            raise Exception.CreateFmt(errInvalidFormat,[FSrcName]);
          ndFileName := ChildNodes.FindNode(tagFileName);
          if not assigned(ndFileName) then
            continue;
         if not fileList.Find(ndFileName.Text,indx) then
          continue;
          curPhotoType :=  GetSubjPhotoType(Attributes[attrType]);
          if curPhotoType = sbjPhotoPageUnknown then
            exit;
         pgType := pgType or curPhotoType;
        end;
    case pgType of
      sbjPhotoPagePrimary:
        result := StrToIntDef(Copy(frmIDs,1,delimPos - 1),0);
      sbjPhotoPageadditional:
        result := StrToIntDef(Copy(frmIDs,delimPos + 1,length(frmIDs)),0);
    end;
  finally
    fileList.Free;
  end;
end;

function TWinTotalXML.GetAdditComps: Integer;
var
  mainFormsPath: String;
  mainFormList: TStringList;
  rec, nRecs: Integer;
  delimPos: Integer;
  curRec,strID: String;
begin
  result := 0;
  mainFormsPath := IncludeTrailingPathDelimiter(FMapDir) + WinTotalMainFormList;
  if not FileExists(mainFormsPath) then
    raise Exception.CreateFmt(errCantFindMap,[WinTotalMainFormList]);
  mainFormList := TStringList.Create;
  try
    mainFormList.LoadFromFile(mainFormsPath);
    nRecs := mainFormList.Count;
    for Rec := 0 to nRecs - 1 do
      begin
        curRec := mainFormList[rec];
        delimPos := Pos(',',curRec);
        if delimPos = 0 then
          raise Exception.CreateFmt(errInvalidMapFile,[WinTotalMainFormList]);
        if CompareText(majorForm,Copy(curRec,1,delimPos - 1)) <> 0 then
          continue
        else
          begin
            strID := Copy(curRec,delimPos + 1,length(curRec));
            break;
          end;
      end;
    if rec = nRecs then //did not find
      raise Exception.CreateFmt(errUnknownMainForm,[majorForm]);
    result := StrToIntDef(strID,0);
  finally
    mainFormList.Free;
  end;
end;


end.

