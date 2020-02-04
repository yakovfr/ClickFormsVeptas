unit UExportXMLPackage;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{  This unit creates the yakov XML package used to convert to AIReady & Lighthouse}

interface

uses
  XMLDoc,XMLDom,XMLIntf,Classes,
  UContainer, UForm, UGraphics, UDocDataMgr, USignatures,
  UXMLConst,UCell, UPage, UCellMetaData, UGlobals, UAMC_Base;
const
  jpgExt = '.jpg';
  imgDescrCellsFName = 'PhotoDescrCells.txt';
  regPageImageTypeFName = 'RegPagesImageTypes.txt';
type
  imgCellRec = record
    formID,imgCellNo,line1CellNo,line2CellNo: Integer;
  end;
  
  TExportPack = class(TObject)
  private
    function FilterString(const Text: String): String;
  public
    FReport: TContainer;               //the doc being converted
    FRepName: String;                  //doc name used for export folder name
    FPackPath: String;                 //path to this xml export package
    FCurSign: Integer;                 //count of the signatures
    FCurReportImage, FCurFormImage: Integer; //count of the images
    FCurSketch: Integer;               //count of the sketch
    FCurPage: Integer;                 //count of the pages
    FCurComment: Integer;              //count of the comments
    FXMLDoc: TXMLDocument;             //the XML doc created form the report
    FFormsToImage: IntegerArray;       //Array of Form Indexes needed converted to images
    function Init: Boolean;
    function CreatePackage: Boolean;
    function CreatePackage2(PackageData:TDataPackage): Boolean;
    procedure AddSummary;
    function WriteSignature(sign: TSignature): String;
    procedure AddForm(form: TDocForm);
    function WritePage(page: TDocPage; pgNum: Integer; formNode: IXMLNode): String;
    function WriteSketch(theCell: TPhotoCell): String;
    function WriteSketchData(skType: String): String;
    function WriteImage(theCell: TPhotoCell;curImage: Integer): String;
    function WriteImageWLabels(theCell: TPhotoCell;curImage: Integer): String;
    function WriteComment(theCell: TBaseCell): String;
    procedure AddSketchToList(skFileName: String);
    procedure AddImageToList(imgFileName, pgType, imgType: String; compsSet: Integer;textLine1,textLine2: String;
                  imagesParentNode: IXMLNode; curImage:Integer);
    procedure AddCommentToList(cmntFileName: String);
   public
    constructor Create(doc: TContainer);
    destructor Destroy; override;
   private
    FImgTextCellsMap: TStringList;
    FRegPageImgTypes: TStringList;
    procedure GetImageText(imgPage: TDocPage; cellInd: Integer; var line1: String; var line2: String);
    function GetRegPageImageTypes(page: TDocPage; pgIndx, cellIndx: Integer; var pgType: String; var imType: String): Boolean;
    procedure AddFormsImage;
    procedure AddGeocodes;
    function isFormToImage(frmIndex: Integer): Boolean; //is form will be conver to image? index is Form # in report
  end;

  function CreateExportPackage(doc: TContainer; formsToImage: IntegerArray): String;
  function CreateExportPackage2(doc: TContainer; formsToImage: IntegerArray; PackageData: TDataPackage): String;
  function GetReportType(doc: TContainer): String;
  function GetPageTypeString(page: TDocPage; var isPhotoPage: Boolean): String;
  function GetCompsSet(page: TDocPage): Integer; // 1 for comps 1,2,3; 2 for comps 4,5,6 and so on.
  function GetPhotoPageImageType(cell: TBaseCell; pgType: Integer): string;
  function ReadImgCellRecord(rec: String; var imgRec: imgCellRec): Boolean;
  procedure CleanXMLPackDir;




implementation

uses
  SysUtils,UStatus, UUtil1, UUtil2, UAppraisalIDs,
  Dialogs, Graphics,Types,JPEG,StrUtils, UWordProcessor;



function CreateExportPackage(doc: TContainer; formsToImage: IntegerArray): String;
var
  expPack: TExportPAck;
begin
  result := '';
  doc.SaveCurCell;
  expPack := TExportPack.Create(doc);
  expPack.FFormsToImage := formsToImage;
  if expPack.Init then
    if ExpPack.CreatePackage then
      result := IncludeTrailingPathDelimiter(expPack.FPackPath) + expPack.FRepName + xmlExt;
end;

function CreateExportPackage2(doc: TContainer; formsToImage: IntegerArray; PackageData:TDataPackage): String;
var
  expPack: TExportPAck;
begin
  result := '';
  doc.SaveCurCell;
  expPack := TExportPack.Create(doc);
  expPack.FFormsToImage := formsToImage;
  if expPack.Init then
    if ExpPack.CreatePackage2(PackageData) then
      result := IncludeTrailingPathDelimiter(expPack.FPackPath) + expPack.FRepName + xmlExt;
end;


constructor TExportPack.Create(doc: Tcontainer);
var
  fPath: String;
begin
  inherited Create;

  FReport := doc;

  //initialize - load in the image names
  fPath := IncludeTrailingPathDelimiter(appPref_DirAppraisalWorld) + imgDescrCellsFName;
  FImgTextCellsMap := TStringList.Create;
  if FileExists(fPath) then
    begin
      FImgTextCellsMap.Sorted := True;
      FImgTextCellsMap.LoadFromFile(fPath);
    end;
  fPath := IncludeTrailingPathDelimiter(appPref_DirAppraisalWorld) + regPageImageTypeFName;
  FRegPageImgTypes := TStringList.Create;
  if FileExists(fPath) then
    begin
      FRegPageImgTypes.Sorted := True;
      FRegPageImgTypes.LoadFromFile(fPath);
    end;
end;

destructor TExportPack.Destroy;
begin
  FImgTextCellsMap.Free;
  FRegPageImgTypes.Free;
  inherited;
end;

/// summary: Filters a string for exportable characters.
function TExportPack.FilterString(const Text: String): String;
var
  FilteredText: String;
  Index: Integer;
begin
  FilteredText := '';

  // remove non-printable characters (except carriage-return and linefeed)
  for Index := 1 to Length(Text) do
    begin
      if (Text[Index] = #10) or
         (Text[Index] = #13) or
         ((Text[Index] > #31) and (Text[Index] < #127))
      then
        FilteredText := FilteredText + Text[Index];
    end;

  // AIReady sometimes errors or fails to import because of a double dollar symbol (control code?)
  while (Pos('$$', FilteredText) > 0) do
    FilteredText := StringReplace(FilteredText, '$$', '$', [rfReplaceAll]);

  Result := FilteredText;
end;

function TExportPack.Init: Boolean;
begin
  result := True;
  try
    //remove previous packages
    CleanXmlPackDir;

    //setup for new xml package
    FRepName := Trim(ChangeFileExt(ExtractFileName(FReport.docFileName), ''));
    FPackPath := IncludeTrailingPathDelimiter(appPref_DirExports) +
                          IncludeTrailingPathDelimiter(subDirExpPack) + FRepName;
    if not DirectoryExists(FPackPath) then
      ForceDirectories(FPackPath);

    // init the counters
    FCurReportImage := 0;
    FCurSketch  := 0;
    FCurSign := 0;
    FCurPage := 0;
    FCurComment := 0;
  except
    result := False;
  end;
end;

function TExportPack.CreatePackage: Boolean;
var
  domVndr: TDomVendor;
  rootNode,curNode, curChildNode: IXMLNode;
  nSignatures,sign: Integer;
  nForms, form: Integer;
  skType: String;
  //DForm: TDocForm;
  xSkCell: TSketchCell;

begin
  result := False;
  try //check XMLDOM Vendor
    domVndr := GetDomVendor(msxmlDomVendor);
  except
    begin
      ShowNotice('The Microsoft XML module is not on your computer. Please install the latest version of Internet Explorer to get it. We cannot preceed until it is installed.');
      exit;
    end;
  end;

  FXMLDoc := TXMLDocument.Create(FReport);
  try
    //initialize
    FXMLDoc.DOMVendor := domVndr;
    FXMLDoc.Options := [doNodeAutoCreate,doNodeAutoindent,doAttrNull];
    FXMLDoc.ParseOptions := [poValidateOnParse];
    FXMLDoc.Active := True;
    rootNode := FXMLDoc.CreateNode(tagReport);
    FXMLDoc.DocumentElement := rootNode;

    rootNode.Attributes[tagName] := FRepName;
    rootNode.Attributes[tagReportType] := GetReportType(FReport);
    rootNode.Attributes[tagSoftwareVendor] := strBT;

    addSummary;

    //signatures
    nSignatures := FReport.docSignatures.Count;
    if nSignatures > 0 then
      begin
        curNode := rootNode.AddChild(tagSignatures);
        curNode.Attributes[tagCount] := IntToStr(0);
        for sign := 0 to nSignatures - 1 do
          begin
            inc(FCurSign);
            curChildNode := curNode.AddChild(tagSignature);
            curChildNode.Attributes[tagSignatureType] :=
                                  TSignature(FReport.docSignatures[sign]).FKind;
            curChildNode.NodeValue :=
                    WriteSignature(TSignature(FReport.docSignatures[sign]));
            curNode.Attributes[tagCount] := IntToStr(FCurSign);
          end;
      end;
    //sketch data file - OLD files using the DocData
    skType := '';
    if FReport.docData.FindData(sktTypeAreaSketch) <> nil then
      skType := sktTypeAreaSketch
    else
      if FReport.docData.FindData(sktTypeWinsketch) <> nil then
        skType := sktTypeWinsketch
    else
      if FReport.docData.FindData(sktTypeApexsketch) <> nil then
        skType := sktTypeApexsketch
    else
      if FReport.docData.FindData(sktTypeRapidSketch) <> nil then
        skType := sktTypeRapidSketch;
    //If old file not found, check for NEW sketch stored in TMetaData
    if skType='' then
      begin
        //DForm := FReport.GetFormByOccurance(cSkFormLegalUID, 0, false);
        xSkCell := TSketchCell(FReport.GetCellByID(cidSketchImage));
        //if DForm<>nil then
        if assigned(xSkCell) then
          begin
             //xSkCell := TSketchCell(dForm.GetCellByID(cidSketchImage));
             if (xSkCell.GetMetaData <>-1) then
               case xSkCell.GetMetaData of
                 mdAreaSketchData:
                    skType := sktTypeAreaSketch;
                 mdApexSketchdata:
                    skType := sktTypeApexsketch;
                 mdWinSketchData:
                    skType := sktTypeWinSketch;
                 mdRapidSketchData:
                    skType := sktTypeRapidSketch;
//                 mdAreaSketchSEData:
//                    skType := sktTypeAreaSketchSE;
               end;
          end;
      end;

    if length(skType) > 0 then
      begin
        curNode := rootNode.AddChild(tagFloorplans);
        //curNode := curNode.AddChild(tagSketchData);              data not used
        //curNode.Attributes[tagSketchType] := skType;
        //curNode.NodeValue := WriteSketchData(skType);
      end;
    //Forms
    nForms := FReport.docForm.Count;
    curNode := rootNode.AddChild(tagForms);
    for form := 0 to nForms - 1 do
      if not isFormToImage(form) then
      begin
        AddForm(FReport.docForm[form]);
        curNode.Attributes[tagCount] := IntToStr(form + 1);
      end;

    AddFormsImage;
    AddGeocodes;

    FXMLDoc.SaveToFile(IncludeTrailingPathDelimiter(FPackPath) + FRepName + xmlExt);
    result := True;
  except
    on E:EDomParseError do
      showNotice(E.Message)
    else
      ShowNotice('Can not create the report package for ' + FReport.docFileName);
    end;
    //TXMLDocument components that are created at runtime are freed
    //automatically when all references to their IXMLDocument interface are released.
end;

function TExportPack.CreatePackage2(PackageData: TDataPackage): Boolean;
var
  domVndr: TDomVendor;
  rootNode,curNode, curChildNode: IXMLNode;
  nSignatures,sign: Integer;
  nForms, form: Integer;
  skType: String;
  //DForm: TDocForm;
  xSkCell: TSketchCell;

begin
  result := False;
  try //check XMLDOM Vendor
    domVndr := GetDomVendor(msxmlDomVendor);
  except
    begin
      ShowNotice('The Microsoft XML module is not on your computer. Please install the latest version of Internet Explorer to get it. We cannot preceed until it is installed.');
      exit;
    end;
  end;

  FXMLDoc := TXMLDocument.Create(FReport);
  try
    //initialize
    FXMLDoc.DOMVendor := domVndr;
    FXMLDoc.Options := [doNodeAutoCreate,doNodeAutoindent,doAttrNull];
    FXMLDoc.ParseOptions := [poValidateOnParse];
    FXMLDoc.Active := True;
    rootNode := FXMLDoc.CreateNode(tagReport);
    FXMLDoc.DocumentElement := rootNode;

    rootNode.Attributes[tagName] := FRepName;
    rootNode.Attributes[tagReportType] := GetReportType(FReport);
    rootNode.Attributes[tagSoftwareVendor] := strBT;

    addSummary;

    //signatures
    nSignatures := FReport.docSignatures.Count;
    if nSignatures > 0 then
      begin
        curNode := rootNode.AddChild(tagSignatures);
        curNode.Attributes[tagCount] := IntToStr(0);
        for sign := 0 to nSignatures - 1 do
          begin
            inc(FCurSign);
            curChildNode := curNode.AddChild(tagSignature);
            curChildNode.Attributes[tagSignatureType] :=
                                  TSignature(FReport.docSignatures[sign]).FKind;
            curChildNode.NodeValue :=
                    WriteSignature(TSignature(FReport.docSignatures[sign]));
            curNode.Attributes[tagCount] := IntToStr(FCurSign);
          end;
      end;
    //sketch data file - OLD files using the DocData
    skType := '';
    if FReport.docData.FindData(sktTypeAreaSketch) <> nil then
      skType := sktTypeAreaSketch
    else
      if FReport.docData.FindData(sktTypeWinsketch) <> nil then
        skType := sktTypeWinsketch
    else
      if FReport.docData.FindData(sktTypeApexsketch) <> nil then
        skType := sktTypeApexsketch
    else
      if FReport.docData.FindData(sktTypeRapidSketch) <> nil then
        skType := sktTypeRapidSketch;
    //If old file not found, check for NEW sketch stored in TMetaData
    if skType='' then
      begin
        //DForm := FReport.GetFormByOccurance(cSkFormLegalUID, 0, false);
        xSkCell := TSketchCell(FReport.GetCellByID(cidsketchImage));
        //if DForm<>nil then
        if assigned(xSkCell) then
          begin
             //xSkCell := TSketchCell(dForm.GetCellByID(cidSketchImage));
             if (xSkCell.GetMetaData <>-1) then
               case xSkCell.GetMetaData of
                 mdAreaSketchData:
                    skType := sktTypeAreaSketch;
                 mdApexSketchdata:
                    skType := sktTypeApexsketch;
                 mdWinSketchData:
                    skType := sktTypeWinSketch;
                 mdRapidSketchData:
                    skType := sktTypeRapidSketch;
//                 mdAreaSketchSEData:
//                    skType := sktTypeAreaSketchSE;
               end;
          end;
      end;

    if length(skType) > 0 then
      begin
        curNode := rootNode.AddChild(tagFloorplans);
        //curNode := curNode.AddChild(tagSketchData);         data not used
        //curNode.Attributes[tagSketchType] := skType;
        //curNode.NodeValue := WriteSketchData(skType);
      end;
    //Forms
    nForms := FReport.docForm.Count;
    curNode := rootNode.AddChild(tagForms);

    for form := 0 to nForms - 1 do
      if not isFormToImage(form) then
      begin
        if assigned(PackageData.FormList) then
          if PackageData.FormList[form] then //include in export
          begin
            AddForm(FReport.docForm[form]);
            curNode.Attributes[tagCount] := IntToStr(form + 1);
          end;
      end;

    AddFormsImage;
    AddGeocodes;

    FXMLDoc.SaveToFile(IncludeTrailingPathDelimiter(FPackPath) + FRepName + xmlExt);
    result := True;
  except
    on E:EDomParseError do
      showNotice(E.Message)
    else
      ShowNotice('Can not create the report package for ' + FReport.docFileName);
    end;
    //TXMLDocument components that are created at runtime are freed
    //automatically when all references to their IXMLDocument interface are released.
end;



procedure TExportPack.addSummary;
var
  curNode, curChildNode: IXMLNode;
  curStr: String;
begin
  curNode := FXMLDoc.DocumentElement.AddChild(tagSummary);
  with FReport do
    begin
      curStr := GetCellTextByID(2);
      if length(curStr) > 0 then
        begin
          curChildNode := curNode.AddChild(tagFileNo);
          curChildNode.NodeValue  := curStr;
        end;
      curStr := GetCellTextByID(4);
      if length(curStr) > 0 then
        begin
          curChildNode := curNode.AddChild(tagCaseNo);
          curChildNode.NodeValue  := curStr;
        end;
      curStr := GetCellTextByID(7);
      if length(curStr) > 0 then
        begin
          curChildNode := curNode.AddChild(tagAppraiser);
          curChildNode.NodeValue  := curStr;
        end;
      curStr := GetCellTextByID(45);
      if length(curStr) > 0 then
        begin
          curChildNode := curNode.AddChild(tagBorrower);
          curChildNode.NodeValue  := curStr;
        end;
      curStr := GetCellTextByID(35);
      if length(curStr) > 0 then
        begin
          curChildNode := curNode.AddChild(tagClient);
          curChildNode.NodeValue  := curStr;
        end;
      curStr := GetCellTextByID(1132);
      if length(curStr) > 0 then
        begin
          curChildNode := curNode.AddChild(tagAppraisalDate);
          curChildNode.NodeValue  := curStr;
        end;
      curStr := GetCellTextByID(1131);
      if length(curStr) > 0 then
        begin
          curChildNode := curNode.AddChild(tagAppraisalValue);
          curChildNode.NodeValue  := curStr;
        end;

      //address
      curNode := curNode.AddChild(tagPropertyAddress);
      curStr := GetCellTextByID(46);
      if length(curStr) > 0 then
        begin
          curChildNode := curNode.AddChild(tagStreetAddress);
          curChildNode.NodeValue  := curStr;
        end;
      curStr := GetCellTextByID(47);
      if length(curStr) > 0 then
        begin
          curChildNode := curNode.AddChild(tagCity);
          curChildNode.NodeValue  := curStr;
        end;
      curStr := GetCellTextByID(48);
      if length(curStr) > 0 then
        begin
          curChildNode := curNode.AddChild(tagState);
          curChildNode.NodeValue  := curStr;
        end;
      curStr := GetCellTextByID(49);
      if length(curStr) > 0 then
        begin
          curChildNode := curNode.AddChild(tagZip);
          curChildNode.NodeValue  := curStr;
        end;
    end;
end;

function TExportPack.WriteSignature(sign: TSignature): String;
var
   curFileName: String;
begin
  with sign do
    begin
      curFileName := signFilename + IntToStr(FCurSign) +  '.' + SignatureImage.ILImageType;
      SignatureImage.SaveToFile(IncludeTrailingPathDelimiter(FPackPath) + curFileName);
   end;
  result := curFileName;
end;

procedure TExportPack.AddForm(form: TDocForm);
var
  formNode,curNode,curChildNode: IXMLNode;
  nPages,page: Integer;
  compsSet: Integer;
  pgType: String;
  isPhotoPage: Boolean;
begin
  curNode := FXMLDoc.DocumentElement.ChildNodes.FindNode(tagForms);
  curNode := curNode.AddChild(tagForm);
  with form do
    begin
      curNode.Attributes[tagName] := frmInfo.fFormName;
      curNode.Attributes[tagFormID] := IntToStr(frmInfo.fFormUID);
      curNode.Attributes[tagVersion] := IntToStr(frmInfo.fFormVers);
      if (form.ParentDocument as TContainer).UADEnabled then
        curNode.Attributes[tagUADVersion] := UADVersion;
      formNode := curNode;
      curNode := curNode.AddChild(tagPages);
      curNode.Attributes[tagCount] := IntToStr(0);
      nPages := GetNumPages;
      curNode.Attributes[tagCount] := IntToStr(nPages);
      FCurFormImage := 0;
      for page := 0 to nPages -1 do
        begin
          inc(FCurPage);
          curChildNode := curNode.AddChild(tagPage);
          curChildNode.Attributes[tagNumber] := IntToStr(page +1);
          pgType := GetPageTypeString(frmPage[page],isPhotoPage);
          curChildNode.Attributes[tagPageType] := pgType;
          compsSet := GetCompsSet(frmPage[page]);
          if compsSet > 0 then
            curChildNode.Attributes[tagCompsSet] := IntToStr(compsSet);
          curChildNode.NodeValue := WritePage(frmPage[page],page + 1,formNode);
        end;
    end;
end;

function TExportPack.WritePage(page: TDocPage;pgNum: Integer; formNode: IXMLNode): String;
var
  curFileName, imgFileName, cmntFileName: String;
  txtFile: TextFile;
  nCells, cl: Integer;
  curCell: TBaseCell;
  cellStr: String;
  strImgType: String;
  compsSet: Integer;
  imgTextLine1,imgTextLine2: String;
  strPageType: String;
  intPageType: Integer;
  isPhotoPage: Boolean;
  imagesParentNode: IXMLNode;
  curImage: Integer;
  nDecimals: integer;
begin
  curFileName := pageFileName + IntToStr(FCurPage) + textFileExt;
  Rewrite(txtFile,IncludeTrailingPathDelimiter(FPackPath) + curFileName);
  intPageType := page.pgDesc.PgType;
  compsSet := GetCompsSet(page);
  try
    WriteLn(txtFile,DateTimeToStr(Now));
    WriteLn(txtFile,strReport + equal + FRepName);
    WriteLn(txtFile,strForm + equal + TDocForm(page.FParentForm).frmInfo.fFormName);
    WriteLn(txtFile,strPage + intToStr(pgNum) + equal + page.FPgTitleName);
    nCells := page.pgData.Count;
    for cl := 0 to nCells -1 do
      begin
        curCell := page.pgData[cl];
        if curCell.FEmptyCell then
          continue;
        if ((curCell is TTextCell)or (curCell is TChkBoxCell))    and not (curCell is TMlnTextCell) then
          begin
            cellStr := FilterString(curCell.GetText);
            WriteLn(txtFile, IntToStr(cl + 1)+ tab + IntToStr(curCell.FCellID)
                                            + tab + dataTypeText + tab + cellStr);
          end;
        if (curCell is TMlnTextCell) or (curCell is TWordProcessorCell) then
          if intPageType = ptComments then
            begin
              inc(FCurComment);
              cmntFileName := WriteComment(curCell);
              if FileExists(IncludeTrailingPathDelimiter(FPackPath) + cmntFileName) then
                begin
                  AddCommentToList(cmntFileName);
                  WriteLn(txtFile, IntToStr(cl + 1)+ tab + IntToStr(curCell.FCellID)
                                            + tab + dataTypeFile + tab + cmntFileName);
                end;
             end
            else
              begin
                 cellStr := FilterString(curCell.GetText);
                 //ReplaceCRwithSpace(cellStr);
                 cellStr := StringReplace(cellStr,CR,CRReplacement,[rfReplaceAll]);
                 WriteLn(txtFile, IntToStr(cl + 1)+ tab + IntToStr(curCell.FCellID)
                                            + tab + dataTypeText + tab + cellStr);
               end;
        if curCell is TPhotoCell then
          begin
            if curCell is TSketchCell then
              begin
                inc(FCurSketch);
                imgFileName := WriteSketch(TPhotoCell(curCell));
                AddSketchToList(imgFileName);
              end
            else
              begin
                //inc(FCurImage);
                //imgType := GetPhotoPageImageType(curCell,pgType);
                strPageType := GetPageTypeString(page,isPhotoPage);
                if not isPhotoPage then  //regular page with Image
                  begin
                    GetRegPageImageTypes(page,pgNum,cl,strPagetype,strImgType);
                    imagesParentNode := formNode;
                    inc(FCurFormImage);
                    curImage := FCurFormImage;
                  end
                else
                  begin
                    //strPageType := GetPageTypeString(page,isPhotoPage);
                    strImgType := GetPhotoPageImageType(curCell,intPageType);
                    imagesParentNode := FXMLDoc.DocumentElement;
                    inc(FCurReportImage);
                    curImage := FCurReportImage;
                  end;
                if assigned(TPhotoCell(curCell).FLabels) then
                  imgFileName := WriteImageWLabels(TPhotoCell(curCell),curImage)
                else
                  imgFileName := WriteImage(TPhotoCell(curCell),curImage);
                if length(strImgType) > 0 then
                begin
                  GetImageText(page,cl,imgTextLine1,imgTextLine2);
                  AddImageToList(imgFileName,strPageType,strImgType,compsSet,imgTextLine1,imgTextLine2,imagesParentNode,curImage);
                end;
              end;
            if FileExists(IncludeTrailingPathDelimiter(FPackPath) + imgFileName) then
              WriteLn(txtFile,IntToStr(cl + 1) + tab + IntToStr(curCell.FCellID)
                                          + tab + dataTypeFile  + tab + imgFileName);
          end;
      end;
      //Info cells
      if assigned(page.pgInfo) then
        begin
          nCells := page.pgInfo.Count;                             ;
            for cl := 0 to nCells - 1 do
          with page.pgInfo[cl] do
            begin
              nDecimals := 0;
              if ClassNameIs('TGrsNetInfo') then
                begin
                  nDecimals := appPref_AppraiserNetGrossDecimalPoint;
                  if (nDecimals < 0) or (ndecimals > 2) then
                    ndecimals := 0;
                  end;
              cellStr := FloatToStrF(Value, ffNumber, 14, nDecimals);
              if length(text) > 0 then
                WriteLn(txtFile, IntToStr(cl + 1 + InfoCellOffset)+ tab + tab + dataTypeText + tab + cellStr);
            end;
        end;
    result := curFileName;
  finally
      CloseFile(txtFile);
  end;
end;

function TExportPack.WriteSketch(theCell: TPhotoCell): String;
var
  curFileName: String;
  x,y, x2: integer;

  scale: real;
  mf, smf: TMetafile;
  mstr: TMemoryStream;
  mfc: TMetafileCanvas;
  mRect: TRect;

begin
   with theCell.FImage do
    begin
      x2 := FImgRect.Right-FImgRect.Left;

      x := FSrcR.Right-FSrcR.Left;
      y := FSrcR.Bottom-FSrcR.Top;
      if (x = 0) and (x2<>0) then
        begin
          x := x2;
          y :=  FImgRect.Bottom- FImgRect.Top;
        end;
      if (CompareText(FImgTyp, cfi_EMF) = 0) or (CompareText(FImgTyp, cfi_EMFplus) = 0) or (CompareText(FImgTyp, cfi_WMF) = 0) then
        begin
          curFileName := sketchFilename + IntToStr(FCurSketch) +  '.' + 'emf';
          theCell.FImage.FPic.SaveToFile(IncludeTrailingPathDelimiter(FPackPath) + curFileName);
          result := curFileName;
          exit;
        end;

      curFileName := sketchFilename + IntToStr(FCurSketch) +  '.' + ILImageType;
      if (x>1200) and(pos('MF',uppercase(ILImageType))>0) then
        begin
            scale := 1200/x;
            x := round(x * scale);
            y := round(y * scale);
            mRect.Left := 0;
            mRect.Top := 0;
            mRect.Bottom := y;
            mRect.Right := x;
            mf := TMetafile.Create;
            smf := TMetafile.Create;
            mstr:= TMemoryStream.Create;
            theCell.FImage.FPic.SaveToStream(mstr);
            mstr.Position := 0;
            smf.LoadFromStream(mstr);
            mf.Width := x;
            mf.Height := y;
            mfc := TMetafilecanvas.Create(mf,0);
            mfc.StretchDraw(mRect,smf);
            mfc.Free;
            mf.SaveToFile(IncludeTrailingPathDelimiter(FPackPath) + curFileName);
            mf.Free;
            smf.Free;
            mstr.Free;
        end
        else
           SaveToFile(IncludeTrailingPathDelimiter(FPackPath) + curFileName);
   end;
  result := curFileName;
end;

function TExportPack.WriteSketchData(skType: String): String;
var
  curFileName: String;
  skData: TMemoryStream;     //temp so we can use data object
 // DForm: TDocForm;
  xSkCell: TSketchCell;

begin
  with FReport.docData do
    begin
      skData := FindData(skType);
      if skData = nil then
      begin
        //DForm := FReport.GetFormByOccurance(cSkFormLegalUID, 0, false);
        xSkCell := TSketchCell(FReport.GetCellByID(cidsketchImage));
        //if DForm<>nil then
        if assigned(xSkCell) then
          begin
             //xSkCell := TSketchCell(dForm.GetCellByID(cidSketchImage));
             if (xSkCell.GetMetaData <>-1) then
              if Assigned(TSketchCell(xSkCell).FMetaData) and Assigned(TSketchCell(xSkCell).FMetaData.FData) then
                begin
                  TSketchCell(xSkCell).FMetaData.FData.Position := 0;
                  skData := TSketchCell(xSkCell).FMetaData.FData;
                end
          end;
      end;
      if skData = nil then
        exit;
      curFileName := sketchDataFileName + sketchDataFileExt;
      skData.SaveToFile(IncludeTrailingPathDelimiter(FPackPath) + curFileName);
    end;
  result := curFileName;
end;

function TExportPack.WriteImage(theCell: TPhotoCell; curImage: Integer): String;
var
  curFileName: String;
begin
  // 092711 YFrenkel Following call to SaveDIBToStorage is unnecessary
  //  theCell.FImage.SaveDIBToStorage;
  curFileName := Format(imageFilename,[FCurPage,curImage]) +  '.' + theCell.FImage.ILImageType;
  theCell.FImage.SaveToFile(IncludeTrailingPathDelimiter(FPackPath) + curFileName);
  result := curFileName;
end;

//I have to create a image with labels in 2 step:
//1. Keeping the existing coordinate system draw labels on the top of a map.
//2. Get rid of offset (top,left > 0) the existing coordinate system
function TExportPack.WriteImageWLabels(theCell: TPhotoCell; curImage: Integer): String;
var
  curFileName: String;
  btm1,btm2: TBitmap;
  jpg: TJpegImage;
  dest1,dest2: TRect;
begin
  with theCell.FImage do
    begin
      btm1 := TBitmap.Create;
      btm2 := TBitmap.Create;
      jpg := TJpegImage.Create;
      Dest1 := ScaleRect(FDestR, CNormScale,FReport.docView.PixScale);
      dest2.Left := 0;
      dest2.Right := dest1.Right - dest1.Left;
      dest2.Top := 0;
      dest2.Bottom := dest1.Bottom - dest1.Top;
      btm1.Height := dest1.Bottom;
      btm2.Height := dest2.Bottom;
      btm1.Width := dest1.Right;
      btm2.Width := dest2.Right;
      try
         DrawZoom(btm1.Canvas,CNormScale,FReport.docView.PixScale,False);
        if assigned(theCell.FLabels) then
          theCell.FLabels.DrawZoom(btm1.Canvas,CNormScale,FReport.docView.PixScale,False);
        btm2.Canvas.CopyRect(dest2,btm1.Canvas,dest1);
        jpg.Assign(btm2);
        //always save image as JPEG
        curFileName :=  Format(imageFilename,[FCurPage,curImage]) +  jpgExt;
        jpg.SaveToFile(IncludeTrailingPathDelimiter(FPackPath) + curFileName);
      finally
        btm1.Free;
        btm2.Free;
        jpg.Free;
      end;
    end;
  result := curFileName;
end;

procedure TExportPack.AddSketchToList(skFileName: String);
var
  curNode,tempNode: IXMLNode;
begin
  curNode := FXMLDoc.DocumentElement.ChildNodes.FindNode(tagFloorplans);
  if curNode = nil then
    curNode := FXMLDoc.DocumentElement.AddChild(tagFloorplans);
  tempNode := curNode;
  curNode := curNode.ChildNodes.FindNode(tagSketches);
  if curNode = nil then
    curNode := tempNode.AddChild(tagSketches);
  curNode.Attributes[tagCount] := IntToStr(FCurSketch);
  curNode := curNode.AddChild(tagSketch);
  curNode.Attributes[tagnumber] := IntToStr(FCurSketch);
  curNode.NodeValue := skFileName;
end;

procedure TExportPack.AddImageToList(imgFileName,pgType,imgType: String; compsSet: Integer;textLine1,textLine2: String;
                imagesParentNode: IXMLNode;curImage: Integer);
var
  curNode: IXMLNode;
begin
  curNode := imagesParentNode.ChildNodes.FindNode(tagImages);
  if curNode = nil then
    curNode := imagesParentNode.AddChild(tagImages);
  curNode.Attributes[tagCount] := IntToStr(curImage);
  curNode := curNode.AddChild(tagImage);
  curNode.NodeValue := imgFileName;
  curNode.Attributes[tagPageType] := pgType;
  curNode.Attributes[tagImagetype] := imgType;
  curNode.Attributes[tagPageNumber] := IntToStr(FCurPage);
  if length(textLine1) > 0 then
    curNode.Attributes[tagImgTextLine1] := textLine1;
  if length(textLine2) > 0 then
    curNode.Attributes[tagImgTextLine2] := textLine2;
  if compsSet > 0 then
    curNode.Attributes[tagCompsSet] := IntToStr(compsSet);
end;

function TExportPack.WriteComment(theCell: TBaseCell): String;
var
  cmntFile: TextFile;
  curFileName: String;
  curStr: String;
begin
  result := '';
  curFileName := cmntFilename + IntToStr(FCurComment) +  textFileExt;
  try
    Rewrite(cmntFile,IncludeTrailingPathDelimiter(FPackPath) + curFileName);
    curStr := FilterString(stringReplace(theCell.GetText,CR,CR+LF,[rfReplaceAll]));
    Write(cmntFile,curStr);
    result := curFileName;
  finally
    CloseFile(cmntFile);
  end;
end;

procedure TExportPack.AddCommentToList(cmntFileName: String);
var
  curNode: IXMLNode;
begin
  curNode := FXMLDoc.DocumentElement.ChildNodes.FindNode(tagComments);
  if curNode = nil then
    curNode := FXMLDoc.DocumentElement.AddChild(tagComments);
  curNode.Attributes[tagCount] := IntToStr(FCurComment);
  curNode := curNode.AddChild(tagComment);
  curNode.NodeValue := cmntFileName;
end;

procedure TExportPack.GetImageText(imgPage: TDocPage; cellInd: Integer; var line1: String; var line2: String);
var
  imgCell: TBaseCell;
  frmID: Integer;
  indx, frstIndx: Integer;
  imgRec: ImgCellRec;
  line1CellInd, line2CellInd: Integer;
begin
  line1 := '';
  line2 := '';
  imgCell := imgPage.pgData[cellInd];
  if not assigned(imgCell) or not (imgCell is TPhotoCell) then
    exit;
  frmID := TDocForm(imgPage.FParentForm).FormID;
  FImgTextCellsMap.Find(IntToStr(frmID),frstIndx);
  if frstIndx >= FImgTextCellsMap.Count then     //did not find record starting with formID
    exit;
  for indx := frstIndx to FImgTextCellsMap.Count - 1 do
  begin
    if not  ReadImgCellRecord(FImgTextCellsMap[indx],imgRec) then //corrupted map file
      break;
    if imgRec.formID <> frmID then  //no more record for the form in map file
      break;
    if imgRec.imgCellNo = cellInd + 1 then
      begin
        line1CellInd := imgRec.line1CellNo - 1;
        line2CellInd := imgRec.line2CellNo - 1;
        if (line1CellInd >= 0) and (line1CellInd < imgPage.pgData.Count) then
          line1 := imgPage.pgData[line1CellInd].Text;
        if (line2CellInd >= 0) and (line2CellInd < imgPage.pgData.Count) then
          line2 := imgPage.pgData[line2CellInd].Text;
        break;
      end;
  end;
end;

function TExportPack.GetRegPageImageTypes(page: TDocPage; pgIndx, cellIndx: Integer; var pgType: String; var imType: String): Boolean;
const
  fieldDelim = ',';
var
  searchStr: String;
  formID: Integer;
  recIndx: Integer;
  curRec: String;
  startPos, endPos: Integer;
begin
  pgType := '';
  imType := 'GenericPhoto';
  result := false;
  formID := TDocForm(page.FParentForm).FormID;
  searchStr := InttoStr(formID) + fieldDelim + InttoStr(pgIndx) + fieldDelim + IntToStr(cellIndx + 1) + fieldDelim;
  FRegPageImgTypes.Find(searchStr,recIndx);
  if recIndx >= FRegPageImgTypes.Count then
    exit;
  curRec := FRegPageImgTypes[recIndx];
  if Pos(searchStr,curRec) <> 1 then
    exit;
  startPos := length(searchStr) + 1;
  endPos := PosEx(fieldDelim,curRec,startPos);
  if endPos = 0 then
    exit;
  pgType := Copy(curRec,startPos,endPos - startPos);
  startPos := endPos + 1;
  endPos := PosEx(fieldDelim,curRec,startPos);
  if endPos = 0 then
    imType := Copy(curRec,startPos,length(curRec) - startPos + 1)
  else
    imType := Copy(curRec,startPos,endPos - startPos);
  result := true;
end;

procedure TExportPack.AddFormsImage;
var
  frmRec: Integer;
  frmIndx, pgIndx: Integer;
  imgfName: String;
  imgQuality: double;
  imgType,pgType: String;
begin
  imgQuality := 1.5;  //let's take a compomise: a little better quality but not too big image size
  pgType := 'PageImage';  //it is not page type from the form
  if length(FFormstoImage) = 0 then
    exit;
  for frmRec := 0 to length(FFormstoImage) -1 do
    begin
      frmIndx := FFormstoImage[frmrec];
      if (frmIndx < 0) or (frmIndx >= FReport.docForm.Count) then
        continue;
      imgType := FReport.docForm[frmIndx].frmSpecs.fFormName;
      for pgIndx := 0 to FReport.docForm[frmIndx].frmPage.Count -1 do
        begin
          imgfName := format('form%dpage%d',[frmIndx,pgIndx]) + jpgExt;
          FReport.docForm[frmIndx].frmPage[pgIndx].SavePageAsImage(imgQuality,IncludeTrailingPathDelimiter(FPackPath) + imgFName);
          inc(FCurReportImage);
          inc(FCurPage);
          if pgIndx > 0 then
            imgType := imgType + format(' pg%d',[pgIndx + 1]);
          AddImagetoList(imgFName,pgtype,imgType,0,'','',FXMLDoc.DocumentElement,FcurReportImage);
        end;
    end;
end;

function GetPageTypeString(page: TDocPage; var isPhotoPage: Boolean): String;
begin
  result := pgTypeRegular;
  case page.pgDesc.PgType of
    ptTofC_Continued: begin result := pgTypeExtraTableOfContent; end;
    ptPhotoComps:     begin result := pgTypePhotosComps; isPhotoPage := true; end;
    ptPhotoListings:  begin result := pgTypePhotosListing; isPhotoPage := true; end;
    ptPhotoRentals:   begin result := pgTypePhotosRental; isPhotoPage := true; end;
    ptMapLocation:    begin result := pgTypeLocationMap; isPhotoPage := true; end;
    ptMapListings:    begin result := pgTypeMapListing; isPhotoPage := true; end;
    ptMapRental:      begin result := pgTypeMapRental; isPhotoPage := true; end;
    ptPhotoSubject:   begin result := pgTypePhotosSubject; isPhotoPage := true; end;
    ptPhotoSubExtra:  begin result := pgTypePhotosSubjectExtra; isPhotoPage := true; end;
    ptMapPlat:        begin result := pgTypePlatMap; isPhotoPage := true; end;
    ptMapFlood:       begin result := pgTypeFloodMap; isPhotoPage := true; end;
    ptSketch:         begin result := pgTypeSketch; isPhotoPage := false; end;
    ptExhibit:        begin result := pgTypeExhibit; isPhotoPage := true; end;
    ptExtraComps:     begin result := pgTypeExtraComps; isPhotoPage := false; end;
    ptExtraListing:   begin result := pgTypeExtraListing; isPhotoPage := false; end;
    ptExtraRental:    begin result := pgTypeExtraRental; isPhotoPage := false; end;
    ptPhotoUntitled:  begin result := pgTypePhotosUntitled; isPhotoPage := true; end;
    ptPhotosUntitled6Photos: begin result := pgtypePhotosUntitled6Photos; isPhotoPage := true; end;
    ptComments:       begin result := pgTypeComments; isPhotoPage := false; end;
    ptExhibitWoHeader: begin result := pgTypeExhibitWoHeader; isPhotoPage := true; end;
    ptExhibitFullPg:  begin result := pgTypeExhibitFullPg; isPhotoPage := true; end;
    ptMapOther:       begin result := pgTypeMapOther; isPhotoPage := true; end;
  end;
end;

function GetCompsSet(page: TDocPage): Integer; // 1 for comps 1,2,3; 2 for comps 4,5,6 and so on.
var
  firstCompNoCell: TBaseCell;
  FirstCompNo: Integer;
  firstCompNoCellID: Integer;
begin
  result := 0;
  firstCompNoCellId := -1;
  case page.pgDesc.PgType of
    ptExtraComps,ptExtraListing,ptExtraRental,ptPhotoComps, ptPhotoListings, ptPhotoRentals:
      begin
        case page.pgDesc.PgType of
          ptExtraComps,ptExtraListing,ptExtraRental:
            firstCompNoCellID := 1219; //extra comps pages
          ptPhotoComps, ptPhotoListings, ptPhotoRentals:
            firstCompNoCellID := 1166; //photo comps pages
        end;
        firstCompNoCell := page.GetCellByID(firstCompNoCellId);
        if assigned(firstCompNoCell) then
          begin
            FirstCompNo := StrToIntDef(firstCompNoCell.GetText,0);
            if FirstCompNo > 0 then
              result:= (FirstCompNo div nCompsOnPage) + 1;
          end;
      end;
  end;
end;

function GetPhotoPageImageType(cell: TBaseCell;pgType: Integer): string;
begin
  result := '';
  if not (cell  is TPhotoCell) then
    exit;
  result := imgTypeGeneral;
  case pgType of
    ptPhotoComps,ptPhotoListings,ptPhotoRentals:
      case cell.FCellID of
        1163: result := imgTypePhotoTop;
        1164: result := imgTypePhotoMiddle;
        1165: result := imgTypePhotoBottom;
      end;
    ptMapLocation,ptMapPlat,ptMapFlood:
      result := imgTypeMap;
    ptPhotoSubject:
      case cell.FCellID of
        1205: result := imgTypeSubjectFront;
        1206: result := imgTypeSubjectRear;
        1207: result := imgTypeSubjectStreet;
      end;
    ptPhotoSubExtra:
      case cell.FCellID of
        1208: result := imgTypePhotoTop;
        1209: result := imgTypePhotoMiddle;
        1210: result := imgTypePhotoBottom;
      end;
    ptPhotoUntitled:
      case cell.FCellID of
        1222: result := imgTypePhotoTop;
        1223: result := imgTypePhotoMiddle;
        1224: result := imgTypePhotoBottom;
      end;
    ptSketch:
      result := imgTypeMetafile;
  end;
end;

function GetReportType(doc: TContainer): String;

  function GetMainFormRecord(formStr: String): recMainForm;
  var
    delimPos: Integer;
  begin
    result.name := '';
    delimPos := Pos(tab,formStr);
    if delimPos = 0 then
      exit;
    result.id := StrToIntDef(Copy(formStr,1,delimPos - 1),0);
    result.name := Copy(formStr,delimPos + 1,length(formStr));
  end;

var
  docFrm,mainFrm: Integer;
  nRepForms,nMainForms: Integer;
  mainFrmList: TStringList;
  mainFrmListPath: String;
  frmRec: recMainForm;
begin
  result := '';
  mainFrmListPath := IncludeTrailingPathDelimiter(appPref_DirAppraisalWorld) + ClFMainFormList;
  if not FileExists(mainFrmListPath) then
    exit;
  mainFrmList := TStringList.Create;
  mainFrmList.Sorted := False;  //keep the original order
  mainFrmList.LoadFromFile(mainFrmListPath);
  nRepForms := doc.docForm.Count;
  nMainForms := mainFrmList.Count;
  for docFrm := 0 to nRepForms -1 do
    begin
      for mainFrm := 0 to nMainForms - 1 do
        begin
          frmRec := GetMainFormRecord(mainFrmList.Strings[mainFrm]);
          if doc.docForm[docFrm].frmInfo.fFormUID = frmRec.id then
            begin
              result := frmRec.name;
              break;
            end;
        end;
      if length(result) > 0 then
        break;
    end;
     (* case doc.docForm[frm].frmInfo.fFormUID of
        1:  result := 'URAR';
        7:  result := 'Condo';
        18: result := '2-4Income';
        9: result := 'Land';
        11: result := 'MobileHm';
        37: result := 'FNMA2055';
        93: result := 'FMAC2055';
        39: result := '2065';
        41: result := '2075';
        43: result := '2070';
        132: result := 'ReviewShort';
        138: result := 'Review2000_02';
        125: result := 'Review2000_90';
        87,95:  result := 'ERC';
        14: result := '704WQ';
        34: result := '1075';
        415: result := 'HUD92564_vc';
        464: result := 'HUD92564_hs';
      end; *)
end;


//deletes all the files and folders in the ExportPackage directory
procedure CleanXmlPackDir;
var
  sr: TSearchRec;
  workDir,curDir: String;
begin
  workDir := IncludeTrailingPathDelimiter(appPref_DirExports) + subDirExpPack;
  if not DirectoryExists(workDir) then
    exit;

  if FindFirst(IncludeTrailingPathDelimiter(workDir) + '*.*', faDirectory,sr) = 0 then
    begin
      repeat
        curDir := IncludeTrailingPathDelimiter(workDir) + sr.Name;
        if sr.Name[1] = '.' then    // dont delete . and ..
          continue;
        DeleteDirFiles(curDir);
        RemoveDir(curDir);
      until FindNext(sr) <> 0;
      FindClose(sr);
    end;
  SetCurrentDir(workDir);
end;

function ReadImgCellRecord(rec: String; var imgRec: imgCellRec): Boolean;
const
  comma = ',';
var
  curStr: String;
  startPos,DelimPos: Integer;
begin
  imgRec.formID := 0;
  imgRec.imgCellNo := 0;
  imgRec.line1CellNo := 0;
  imgRec.line2CellNo := 0;
  result := False;
  curStr := rec;

  startPos := 1;
  delimPos := PosEx(comma,curStr,startPos );
  if delimPos = 0 then exit;
    imgRec.formID := StrToIntDef(Trim(Copy(curStr,startPos ,delimPos - startPos)),0);

  startPos := delimPos + 1;
  delimPos := PosEx(comma,curStr,startPos);     //skip form title
  if delimPos = 0 then exit;
  startPos := delimPos + 1;
  delimPos := PosEx(comma,curStr,startPos);  //skip image position
  if delimPos = 0 then exit;

  startPos := delimPos + 1;
  delimPos := PosEx(comma,curStr,startPos);
  if delimPos = 0 then exit;
  imgRec.imgCellNo := StrToIntDef(Trim(Copy(curStr,startPos ,delimPos - startPos)),0);

  startPos := delimPos + 1;
  delimPos := PosEx(comma,curStr,startPos);
  if delimPos = 0 then exit;
  imgRec.line1CellNo := StrToIntDef(Trim(Copy(curStr,startPos ,delimPos - startPos)),0);

  startPos := delimPos + 1;
  delimPos := length(curStr) + 1;
  imgRec.line2CellNo := StrToIntDef(Trim(Copy(curStr,startPos ,delimPos - startPos)),0);

  result := True;
end;

procedure TExportPack.AddGeocodes;
var
  geocodesNode: IXMLNode;
  tempXMLDoc: TXMLDocument;
  xmlstr: String;
begin
  xmlStr := FReport.GetReportGeoCodes;
  if length(xmlStr) = 0 then
    exit;
  tempXMLDoc := TXMLDocument.Create(FReport);
  tempXMLDoc.LoadFromXML(xmlStr);
  geocodesNode := tempXMLDoc.DocumentElement.CloneNode(true);
  FXMLDoc.DocumentElement.ChildNodes.Add(geocodesNode);
end;

function TExportPack.isFormToImage(frmIndex: Integer): Boolean; //is form will be conver to image? index is Form # in report
var
  arrayIndex: Integer;
begin
  result := false;
  for arrayIndex := low(FFormsToImage) to high(FFormsToImage) do
    if frmIndex = FFormsToImage[arrayIndex] then
      begin
        result := true;
        break;
      end;
end;

end.
