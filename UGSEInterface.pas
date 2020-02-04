unit UGSEInterface;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

interface

uses
  Contnrs, UCell, UContainer, UForm, UAMC_XMLUtils, uCraftXML, uGlobals,
  IniFiles, DateUtils, StrUtils;

//CREATING MISMO XML Document
function ComposeGSEAppraisalXMLReport(AContainer: TContainer; var XMLVer: String; ExportForm: BooleanArray;
  Info: TMiscInfo; ErrList: TObjectList; LocType: Integer=0; NonUADXMLData: Boolean=False): string;

//Saving MISMO XML Documents
procedure SaveAsGSEAppraisalXMLReport(AContainer: TContainer; AFileName: string;
  LocType: Integer=0; NonUADXMLData: Boolean=False); overload;
procedure SaveAsGSEAppraisalXMLReport(AContainer: TContainer; ExportForm: BooleanArray;
  AFileName: string; LocType: Integer=0; NonUADXMLData: Boolean=False); overload;
procedure SaveAsGSEAppraisalXMLReport(AContainer: TContainer;  ExportForm: BooleanArray;
  AFileName: string; Info: TMiscInfo; LocType: Integer=0; NonUADXMLData: Boolean=False); overload;
procedure CreateGSEAppraisalXMLReport(AContainer: TContainer;  ExportForm: BooleanArray;
  AFileName: string; Info: TMiscInfo; LocType: Integer=0; NonUADXMLData: Boolean=False);

//function GetMismoReportType(AContainer: TContainer): String;
//procedure VerifyXMLReport();      not used 01/19/2018



function ValidateXML(doc: TContainer; xmlReport: String): Boolean;
var
  XMLReportPath : String;
  XMLReportName : String;

implementation

uses
  Forms, SysUtils, Classes, Math, Dialogs, Types, UMain, UStatus, USysInfo,
  ULicUser, UUtil2, UUtil1, MSXML6_TLB, UGSEImportExport, UGSEEnvelope,
  UBase, UPage, UMath, UEditor, uCraftClass, UGridMgr, UWindowsInfo,
  uInternetUtils, UBase64, UGraphics, UActiveForms, uDocCommands,
  UUADConfiguration, UAMC_RELSOrder, UUADUtils, UStrings;

const
  ttSales     = 1;    //types of grids
  ttRentals   = 2;
  ttListings  = 3;

  GSE_XMLVersion  = 'GSE2.6';   //XML version for GSE reports
  ClickFormsName = 'ClickFORMS';

  FORM_ELEMENT_NAME         = '//_FORM';
  ADDENDUM_ELEMENT_NAME     = '//_ADDENDUM';
  CHECK_CELL_TRUE_TEXT      = 'X';
  CHECK_CELL_FALSE_TEXT     = '';
  IMPORT_CELL_ID_OFFSET     = 50000;
  SOFTWARE_NAME_CELLID      = 2990;
  SOFTWARE_VERSION_CELLID   = 2991;
  GSE_VERSION_CELLID        = 10507;
const
   FORM_ID = 10000;

   PROPERTY_SKETCH = 11001;
   LOCATION_MAP = 11002;
   PLAT_MAP = 11011;
   FLOOD_MAP = 11012;
   SUBJECT_PHOTOS = 11003;
   MISC_PHOTOS = 11010;
   COMPARABLE_SALE_PHOTOS = 11004;
   COMPARABLE_LISTING_PHOTOS = 11005;
   COMPARABLE_RENTAL_PHOTOS = 11006;
   SIGNATURE = 11007;
   INVOICE = 11008;
   ADDITIONAL_COMMENTS = 11009;

   COMPARABLE_IMAGE_CELLID = 11900;
   REPORT_TYPE_CELLID = 2646;

   COVER_PHOTO_CELLID = 2645;

   GRID_NET_POSITIVE_CELLID = 1050;
   GRID_NET_NEGATIVE_CELLID = 1051;

   OTHER_FORM = 10499;
   OTHER_ADDENDUM = 11000;

//REVIEW - CONSTANTS DUPLICATED IN UMISMOINTERFACE
   FMX_1004         = 340;
   FMX_1004_CERT    = 341;
   FMX_1004_XCOMP   = 363;
   FMX_1004P        = 4218;
   FMX_1004PCERT    = 4219;
   FMAC_70H         = 4365;  //1004 2019
   FMAC_70HCERT     = 4366;
   FMX_1004C = 342;
   FMX_1004C_XCOMP = 365;
   FMX_1004C_CERT = 343;
   FMX_1004D = 344;
   FMX_1025 = 349;
   FMX_1025_XCOMP = 364;
   FMX_1025_XRENT = 368;
   FMX_1025_CERT = 350;
   FMX_1073 = 345;
   FMX_1073_XCOMP = 367;
   FMX_1073_CERT = 346;
   FMX_2090 = 351;
   FMX_2090_XCOMP = 366;
   FMX_2090_CERT = 352;
   FMX_2055 = 355;
   FMX_2055_XCOMP = 363;
   FMX_2055_CERT = 356;
   FMX_1075 = 347;
   FMX_1075_XCOMP = 367;
   FMX_1075_CERT = 348;
   FMX_2095 = 353;
   FMX_2095_XCOMP = 366;
   FMX_2095_COMP = 354;
   FMX_2000 = 357;
   FMX_2000_XCOMP = 363;
   FMX_2000_INST = 358;
   FMX_2000_CERT = 359;
   FMX_2000A = 360;
   FMX_2000A_XCOMP = 364;
   FMX_2000A_INST = 361;
   FMX_2000A_CERT = 362;

   ERC_1994 = 84;
   ERC_2001 = 87;
   ERC_2003 = 95;
   ERC_BMA_1996 = 85;

   FMAE_1004_1993 = 1;
   FMAE_1004_1993_XCOMPS = 2;
   FMAE_1073_1997 = 7;
   FMAE_1073_1997_XCOMPS = 8;
   LAND_APPRAISAL = 9;
   LAND_APPRAISAL_XCOMPS = 10;
   FMAE_1025_1994 = 18;
   FMAE_1025_1994_XLISTS = 19;
   FMAE_1025_1994_XRENTS = 20;
   FMAE_1025_1994_XCOMPS = 21;
   COMPLETION_CERTIFICATE_LEGAL = 30;

   FMAE_2055_1996 = 37;
   FMAE_2055_1996_XCOMPS = 38;
   FMAE_2065_1996 = 39;
   FMAE_2065_1996_XCOMPS = 40;
   FMAE_2075_1997 = 41;
   FMAE_2070 = 43;

   MOBILE_HOME = 11;
   COMPLETION_CERTIFICATE_1 = 775;
   COMPLETION_CERTIFICATE_2 = 777;

   // V6.9.9 modified 102709 JWyatt to change use of the DEFAULT_PROPERTY_SKETCH_FORMID
   //  constant to the global variable cSkFormLegalUID.
   // DEFAULT_PROPERTY_SKETCH_FORMID = 201;
   DEFAULT_LOCATION_MAP_FORMID = 101;
   DEFAULT_PLAT_MAP_FORMID = 103;
   DEFAULT_FLOOD_MAP_FORMID = 102;
   DEFAULT_SUBJECT_PHOTOS_FORMID = 301;
   DEFAULT_PHOTOS_FORMID = 0;
   DEFAULT_MAP_FORMID = 0;
   DEFAULT_COMMENTS_FORMID = 98;
   DEFAULT_INVOICE_FORMID = 220;
   DEFAULT_SIGNATURE_FORMID = 0;
   COMPARABLE_SALE_PHOTOS_FORMID = 0;
   COMPARABLE_LISTING_PHOTOS_FORMID = 0;
   COMPARABLE_RENTAL_PHOTOS_FORMID = 0;

   //Some constants for Addendum comment exporting - when we have multi comments
   ADDENDUM_TEXT              = 'AppraisalAddendumText';
   ADDENDUM_TEXT_IDENTIFIER   = 'AppraisalAddendumTextIdentiier';
   ADDENDUM_TEXT_DESCRIPTION  = 'AppraisalAddendumTextDescription';

   //NOTE - these cellIDs to do not XPaths or they are wrong
   MAIN_FORM_SUMMARY_COMMENT_CELLXID = 917;
   EXTRA_SALES_GRID_FORM_SUMMARY_COMMENT_CELLID = 2727;
   EXTRA_RENTAL_GRID_FORM_COMMENT_CELLID = 2754;
   EXTRA_LISTING_GRID_FORM_COMMENT_CELLID = 2755;
   EXTRA_SALES_GRID_FORM_PREVIOUS_SALES_CELLID = 2729;
   EXTRA_SALES_GRID_FORM_COMMENT_CELLID = 111; //dummy cellid

type
  TImageFormat = (if_Unknown, if_BMP, if_PNG, if_GIF, if_PCX, if_JPG, if_PCD, if_TGA,
       if_TIF, if_EPS, if_WMF, if_EMF, if_DIB, if_DFX, if_None);

  TArrayOfForms = array of TDocForm;

  /// summary: An event for mapping cell locator information for use with an export document.
  TMapCellLocaterEvent = procedure(const XID: Integer; const Cell: TBaseCell; const Translator: TMISMOTranslator);

const
   TABLE_PHOTO_NAMES : array[TComparableType] of string = ('ComparableSalesPhotos', 'ComparableRentalPhotos', 'ComparableListingPhotos');
   COMPARABLE_TYPES : array[0..10] of TComparable = (cSubject, cComp1, cComp2, cComp3, cComp4, cComp5, cComp6, cComp7, cComp8, cComp9, cCompOther);

   IMAGE_CAPTION_ATTRIBUTE_NAMES : array[0..3] of string = ('_FirstCaptionText', '_SecondCaptionText',
       '_ThirdCaptionText', '_FourthCaptionText');

   IMAGE_FORMAT_TAGS : array[TImageFormat] of string = ('Unknown', 'cfi_BMP', 'cfi_PNG', 'cfi_GIF', 'cfi_PCX',
       'cfi_JPG', 'cfi_PCD', 'cfi_TGA', 'cfi_TIF', 'cfi_EPS', 'cfi_WMF', 'cfi_EMF', 'cfi_DIB', 'cfi_DFX', 'None');

   IMAGE_FORMAT_MIME : array[TImageFormat] of string = ('image', 'image/bmp', 'image/png', 'image/gif', 'image',
       'image/jpeg', 'image/x-photo-cd', 'image/targa', 'image/tiff', 'image', 'image/windows/metafile',
       'image/windows/metafile', 'image', 'image', '');

/// summary: Exports the specified cell.
procedure ExportCell(const ISUAD: Boolean; const Cell: TBaseCell; const Translator: TMISMOTranslator; const MapLocator: TMapCellLocaterEvent = nil; const ColumnNumber: Integer = -1);
var
  Configuration: IXMLDOMElement;
  DataPoint: IXMLDOMNode;
  Value: String;
  XIDInteger: Integer;
  XIDString: String;
begin
  // re-map xid datapoint for MISMO 2.6 GSE
  if IsUAD then
    begin
      Configuration := TUADConfiguration.Cell(Cell.FCellXID, Cell.UID);
      Configuration := TUADConfiguration.Mismo(Configuration, True);
      if Assigned(Configuration) then
        DataPoint := Configuration.selectSingleNode('DataPoints/DataPoint')
      else
        DataPoint := nil;
    end
  else
    DataPoint := nil;

  // get export value
  if Assigned(DataPoint) then
    begin
      XIDString := DataPoint.attributes.getNamedItem('XID').text;
      XIDInteger := StrToInt(XIDString);

      if Cell.FEmptyCell then
        Value := DataPoint.text  // default
      else
        begin
          // Handle check box cells with default data point values to make sure
          //  that checked boxes are the reverse of their default. That is,
          //  if unchecked is 'Y', the default, then checked is 'N'.
          if (Cell.ClassName = 'TChkBoxCell') and (Trim(DataPoint.text) <> '') then
            begin
              if Cell.Text = '' then
                Value := DataPoint.text
              else if DataPoint.text = 'Y' then
                Value := 'N'
              else
                Value := 'Y';
            end
          else
            Value := Cell.Text;
        end;
    end
  else
    begin
      XIDString := IntToStr(Cell.FCellXID);
      XIDInteger := Cell.FCellXID;
      Value := Cell.Text;

      //special handling for checkboxes in non UAD forms (1004D specifically) where datapoinr is nil
      //if corresponding attribute has to be included in XML even checkbox is not checked.
      if Cell.ClassNameIs('TChkBoxCell') then
       case XIDInteger of
        2606,2607:     //1004D alternative checkboxes update and completition
        if TChkBoxCell(cell).FChecked then
          value := 'Y'
        else
          value := 'N'
       end;
    end;

  // 090711 JWyatt Special cases where 'Description' is actually a whole number format
  // 091412 JWyatt Special cases where 'Age' or "Year Built" is approximate (ex. "~76")
  case Cell.FCellXID of
    67, 976, 1004: Value := StringReplace(Value, ',', '', [rfReplaceAll]);
    151, 996, 1809, 2247: Value := StringReplace(Value, '~', '', [rfReplaceAll]);
  end;

  // export through the mismo translator
  if (XIDInteger > 0) then
    begin
      if not (Value = '') then
        begin
          if (ColumnNumber > -1) then
            Translator.ExportValue(XIDInteger, EMPTY_STRING, IntToStr(ColumnNumber), Value)
          else
            Translator.ExportValue(XIDInteger, Value);
        end;
      // cell locator
      if Assigned(MapLocator) then
        MapLocator(XIDInteger, Cell, Translator);
    end;
end;

/// summary: Exports GSEData for the specified cell.
function GetTextAsGSEData(const DataPtXID: Integer; const Cell: TBaseCell; const Translator: TMISMOTranslator; const ExportedList: TExportedList = nil; const MapLocator: TMapCellLocaterEvent = nil; const ColumnNumber: Integer = -1): String;
var
  CellText, CityStZip, sUnit, SrcDesc, itemStr, tmpStr: String;
  PosGSE, PosIdx, Amt: Integer;
  Mo, Yr: Integer;
  Page: TDocPage;
  TmpCell: TBaseCell;
begin
  Result := '';
  CellText := GetUADLinkedComments((Cell.ParentPage.ParentForm.ParentDocument as TContainer), Cell);
  if CellText <> '' then
    case DataPtXID of
      // subject address
      46, 2141, 47, 48, 49:
          if Cell.FCellXID = DataPtXID then
            Result := CellText;
      // site area
      151, 996, 1809, 2247:
          begin
            tmpStr := GetOnlyDigits(CellText);
            if Length(tmpStr) > 0 then
              Result := tmpStr;
          end;

      // attic exists (none) & car storage (none)
      311, 346:
          begin
            tmpStr := CellText;
            if tmpStr = 'X' then
              Result := 'N'
            else
              Result := 'Y'
          end;

      // Subject Condition comments
      520:
          begin
            tmpStr := CellText;
            PosIdx := Pos('Bathrooms-', tmpStr);
            if PosIdx = 0 then
              PosIdx := Pos('No updates in the prior 15 years', tmpStr);
            if PosIdx > 0 then
              begin
                tmpStr := Copy(tmpStr, PosIdx, Length(tmpStr));
                PosIdx := Pos(';', tmpStr);
                if PosIdx > 0 then
                  Result := Copy(tmpStr, Succ(PosIdx), Length(tmpStr))
                else
                  Result := tmpStr;
              end
            else
              Result := tmpStr;
          end;

      // Management type - homeowner's association only
      827:
        if CellText = 'X' then
          begin
            Page := Cell.ParentPage as TDocPage;
            TmpCell := Page.GetCellByID(828);
            if (TmpCell = nil) or (TmpCell.Text <> 'X') then
              begin
                TmpCell := Page.GetCellByID(829);
                if (TmpCell = nil) or (TmpCell.Text <> 'X') then
                  Result := 'X';
              end;
          end;
      // Management type - developer only
      828:
        if CellText = 'X' then
          begin
            Page := Cell.ParentPage as TDocPage;
            TmpCell := Page.GetCellByID(827);
            if (TmpCell <> nil) then
              begin
                if (TmpCell.Text <> 'X') then
                  begin
                    TmpCell := Page.GetCellByID(829);
                    if (TmpCell = nil) or (TmpCell.Text <> 'X') then
                      Result := 'X';
                  end;
              end
            else
              begin
                TmpCell := Page.GetCellByID(2462);
                if (TmpCell <> nil) then
                  begin
                    if (TmpCell.Text <> 'X') then
                      begin
                        TmpCell := Page.GetCellByID(829);
                        if (TmpCell = nil) or (TmpCell.Text <> 'X') then
                          Result := 'X';
                      end;
                  end;
              end;
          end;
      // Management type - agent only
      829:
        if CellText = 'X' then
          begin
            Page := Cell.ParentPage as TDocPage;
            TmpCell := Page.GetCellByID(827);
            if (TmpCell <> nil) then
              begin
                if (TmpCell.Text <> 'X') then
                  begin
                    TmpCell := Page.GetCellByID(828);
                    if (TmpCell = nil) or (TmpCell.Text <> 'X') then
                      Result := 'X';
                  end;
              end
            else
              begin
                TmpCell := Page.GetCellByID(2462);
                if (TmpCell <> nil) then
                  begin
                    if (TmpCell.Text <> 'X') then
                      begin
                        TmpCell := Page.GetCellByID(828);
                        if (TmpCell = nil) or (TmpCell.Text <> 'X') then
                          Result := 'X';
                      end;
                  end;
              end;
          end;
      // Management type - other/multiple managers
      4459:
        begin
          PosIdx := 0;
          Page := Cell.ParentPage as TDocPage;
          TmpCell := Page.GetCellByID(827);
          if (TmpCell <> nil) then
            begin
              if TmpCell.Text = 'X' then
                PosIdx := 1;
              TmpCell := Page.GetCellByID(828);
              if (TmpCell <> nil) and (TmpCell.Text = 'X') then
                PosIdx := PosIdx + 2;
              TmpCell := Page.GetCellByID(829);
              if (TmpCell <> nil) and (TmpCell.Text = 'X') then
                PosIdx := PosIdx + 4;
              if (PosIdx > 2) and (DataPtXID = 4459) then
                case PosIdx of
                  3, 5, 6, 7: Result := MgmtGrp[PosIdx];
                end;
            end
          else
            begin
              TmpCell := Page.GetCellByID(2462);
              if (TmpCell <> nil) then
                begin
                  if TmpCell.Text = 'X' then
                    PosIdx := 2;
                  TmpCell := Page.GetCellByID(828);
                  if (TmpCell <> nil) and (TmpCell.Text = 'X') then
                    PosIdx := PosIdx + 1;
                  TmpCell := Page.GetCellByID(829);
                  if (TmpCell <> nil) and (TmpCell.Text = 'X') then
                    PosIdx := PosIdx + 4;
                  if (PosIdx > 2) and (DataPtXID = 4459) then
                    case PosIdx of
                      3, 5, 6, 7: Result := CoopGrp[PosIdx];
                    end;
                end;
            end;
        end;

      // PUD detached unit type
      2109:
        if CellText = 'X' then
          begin
            Page := Cell.ParentPage as TDocPage;
            TmpCell := Page.GetCellByID(2147);
            if (TmpCell = nil) or (TmpCell.Text <> 'X') then
              Result := 'X';
          end;
      // PUD attached unit type
      2147:
        if CellText = 'X' then
          begin
            Page := Cell.ParentPage as TDocPage;
            TmpCell := Page.GetCellByID(2109);
            if (TmpCell = nil) or (TmpCell.Text <> 'X') then
              Result := 'X';
          end;

      // PUD attached & detached unit type
      4438:
        begin
          Page := Cell.ParentPage as TDocPage;
          if Cell.FCellXID = 2109 then
            TmpCell := Page.GetCellByID(2147)
          else
            TmpCell := Page.GetCellByID(2109);
          if (TmpCell <> nil) and (CellText = 'X') and (TmpCell.Text = 'X') then
            Result := 'X';
        end;

      // Commercial space description
      2116:
        begin
          tmpStr := CellText;
          PosGSE := Pos(';', tmpStr);
          if (PosGSE > 0) then
            Result := Copy(tmpStr, Succ(PosGSE), Length(tmpStr));
        end;

      // Commercial space percentage
      4416:
        begin
          tmpStr := CellText;
          PosGSE := Pos('%', tmpStr);
          if (tmpStr <> '') and (PosGSE > 0) then
            begin
              Amt := StrToIntDef(Copy(tmpStr, 1, Pred(PosGSE)), -1);
              if (Amt > -1) then
                Result := IntToStr(Amt);
            end;
        end;

      4415:
          begin
            if Trim(CellText) <> '' then
              if Copy(CellText, 1, 1) = '~' then
                Result := 'Y'
              else
                Result := 'N';
          end;
      4425:
          begin
            if Trim(CellText) <> '' then
              if Copy(CellText, 1, 1) = '~' then
                Result := 'Y'
              else
                Result := 'N';
          end;

      // subject condition
      4400:
          begin
            tmpStr := Copy(CellText, 1, 2);
            if (Trim(tmpStr) <> '') then
              begin
                PosGSE := AnsiIndexStr(tmpStr, ConditionListTypCode);
                if PosGSE > -1 then
                  Result := ConditionListTypCode[PosGSE];
              end;
          end;
      // subject condition updates in last 15 years
      4401:
          begin
            tmpStr := CellText;
            if (Trim(tmpStr) <> '') and (tmpStr[3] = ';') then
              begin
                if Copy(tmpStr, 4, Length(Kitchen)) = Kitchen then
                  Result := 'Y'
                else if Copy(tmpStr, 4, Length(NoUpd15Yrs)) = NoUpd15Yrs then
                  Result := 'N';
              end;
          end;
      // subject condition kitchen updates
      4402:
          begin
            tmpStr := CellText;
            if (Trim(tmpStr) <> '') and (tmpStr[3] = ';') then
              if Copy(tmpStr, 4,  Length(Kitchen)) = Kitchen then
                Result := Copy(Kitchen, 1, Pred(Length(Kitchen)));
          end;
      // subject condition bathroom updates
      4403:
          begin
            tmpStr := CellText;
            if (Trim(tmpStr) <> '') and (tmpStr[3] = ';') then
              if Copy(tmpStr, 4, 8) = Kitchen then
                begin
                  tmpStr := Copy(tmpStr, 4, Length(tmpStr));
                  PosGSE := Pos(';', tmpStr);
                  if (PosGSE > 0) then
                    begin
                      tmpStr := Copy(tmpStr, Succ(PosGSE), Length(tmpStr));
                      if Copy(tmpStr, 1, Length(Bathroom)) = Bathroom then
                        Result := Copy(Bathroom, 1, Pred(Length(Bathroom)));
                    end;
                end;
          end;
      // subject condition kitchen updated or remodeled
      4404:
          begin
            tmpStr := CellText;
            if (Trim(tmpStr) <> '') and (tmpStr[3] = ';') then
              begin
                tmpStr := Copy(tmpStr, (4 + Length(Kitchen)), Length(tmpStr));
                if (tmpStr <> '') then
                  begin
                    PosGSE := Pos(';', tmpStr);
                    if (PosGSE > 0) then
                      tmpStr := Copy(tmpStr, 1, Pred(PosGSE));
                    PosGSE := Pos('-', tmpStr);
                    if (PosGSE > 0) then
                      tmpStr := Copy(tmpStr, 1, Pred(PosGSE));
                    PosGSE := AnsiIndexStr(tmpStr, ImprovementListTypTxt);
                    if PosGSE > -1 then
                      Result := ImprovementListTypXML[PosGSE];
                  end;
              end;
          end;
      // subject condition bathroom updated or remodeled
      4405:
          begin
            tmpStr := CellText;
            if (Trim(tmpStr) <> '') and (tmpStr[3] = ';') then
              begin
                tmpStr := Copy(tmpStr, 4, Length(tmpStr));
                PosGSE := Pos(';', tmpStr);
                if (PosGSE > 0) then
                  begin
                    tmpStr := Copy(tmpStr, Succ(PosGSE), Length(tmpStr));
                    if Copy(tmpStr, 1, Length(Bathroom)) = Bathroom then
                      begin
                        tmpStr := Copy(tmpStr, Succ(Length(Bathroom)), Length(tmpStr));
                        if (tmpStr <> '') then
                          begin
                            PosGSE := Pos(';', tmpStr);
                            if (PosGSE > 0) then
                              tmpStr := Copy(tmpStr, 1, Pred(PosGSE));
                            PosGSE := Pos('-', tmpStr);
                            if (PosGSE > 0) then
                              tmpStr := Copy(tmpStr, 1, Pred(PosGSE));
                            PosGSE := AnsiIndexStr(tmpStr, ImprovementListTypTxt);
                            if PosGSE > -1 then
                              Result := ImprovementListTypXML[PosGSE];
                          end;
                      end;
                  end;
              end;
          end;
      // subject condition kitchen updated or remodeled timeframe
      4406:
          begin
            tmpStr := CellText;
            if (Trim(tmpStr) <> '') then
              begin
                //get text beyond C#;Kitchen-
                tmpStr := Copy(tmpStr, (4 + Length(Kitchen)), Length(tmpStr));
                if (tmpStr <> '') then
                  begin
                    PosGSE := Pos(';', tmpStr);
                    if (PosGSE > 0) then
                      begin
                        tmpStr := Copy(tmpStr, 1, Pred(PosGSE));
                        PosGSE := Pos('-', tmpStr);
                        //get the timeframe text
                        if (PosGSE > 0) then
                          tmpStr := Copy(tmpStr, Succ(PosGSE), Length(tmpStr));
                        PosGSE := AnsiIndexStr(tmpStr, ImprovementListYrsTxt);
                        if PosGSE > -1 then
                          Result := ImprovementListYrsXML[PosGSE];
                      end;
                  end;
              end;
          end;
      // subject condition bathroom updated or remodeled timeframe
      4407:
          begin
            tmpStr := CellText;
            if (Trim(tmpStr) <> '') then
              begin
                //get text beyond C#;Kitchen-
                tmpStr := Copy(tmpStr, (4 + Length(Kitchen)), Length(tmpStr));
                if (tmpStr <> '') then
                  begin
                    PosGSE := Pos(';', tmpStr);
                    if (PosGSE > 0) then
                      begin
                        //get text beyond C#;Kitchen-updated-one to five years ago
                        tmpStr := Copy(tmpStr, Succ(PosGSE) + Length(Bathroom), Length(tmpStr));
                        PosGSE := Pos(';', tmpStr);
                        if (PosGSE > 0) then
                          begin
                            //get text beyond Kitchen declarations
                            tmpStr := Copy(tmpStr, 1, Pred(PosGSE));
                            PosGSE := Pos('-', tmpStr);
                            //get the timeframe text
                            if (PosGSE > 0) then
                              tmpStr := Copy(tmpStr, Succ(PosGSE), Length(tmpStr));
                            PosGSE := AnsiIndexStr(tmpStr, ImprovementListYrsTxt);
                            if PosGSE > -1 then
                              Result := ImprovementListYrsXML[PosGSE];
                          end;
                      end;
                  end;
              end;
          end;

      4409:  // contract sale analysis type
        begin
          tmpStr := CellText;
          PosIdx := Pos(';', tmpStr);
          if (PosIdx > 0) then
            begin
              tmpStr := Copy(tmpStr, 1, Pred(PosIdx));
              PosGSE := AnsiIndexStr(tmpStr, SalesTypesTxt);
              if PosGSE > -1 then
                Result := SalesTypesXML[PosGSE];
            end;
        end;

      4410:  // financial concession amount
        begin
          tmpStr := CellText;
          PosIdx := Pos(';', tmpStr);
          if (PosIdx > 0) then
            begin
              tmpStr := Copy(tmpStr, 1, Pred(PosIdx));
              if (Trim(tmpStr) <> '') and (tmpStr[1] = '$') then
                tmpStr := Copy(tmpStr, 2, Length(TmpStr));
              Result := IntToStr(StrToIntDef(TmpStr, 0));
            end;
        end;
      4411:  // undefined financial concession indicator
        begin
          tmpStr := CellText;
          PosIdx := Pos(';', tmpStr);
          if (PosIdx > 0) then
            begin
              tmpStr := Copy(tmpStr, Succ(PosIdx), Length(TmpStr));
              PosIdx := Pos(';', tmpStr);
              if (PosIdx > 0) and (Copy(tmpStr, 1, Pred(PosIdx)) = UADUnkFinAssistance) then
                Result := 'Y'
              else
                Result := 'N';
            end;
        end;

      4408:  // subject source days on market (number or "Unk")
        begin
          tmpStr := CellText;
          PosIdx := Pos(';', tmpStr);
          if (PosIdx > 0) then
            begin
              TmpStr := Copy(tmpStr, 1, Pred(PosIdx));
              if Copy(tmpStr, 1, 4) = DOMHint then
                Result := Copy(tmpStr, 5, Length(TmpStr));
            end;    
        end;

      // influence type - Beneficial, Adverse, Neutral
      4412, 4419:
          begin
            tmpStr := CellText;
            if (Trim(tmpStr) <> '') and (tmpStr[2] = ';') then
              begin
                PosGSE := AnsiIndexStr(tmpStr[1], InfluenceDisplay);
                if PosGSE > -1 then
                  Result := InfluenceList[PosGSE];
              end;
          end;

      // first view rating factor
      4413:
          begin
            tmpStr := CellText;
            if (Trim(tmpStr) <> '') and (tmpStr[2] = ';') then
              begin
                tmpStr := Copy(tmpStr, 3, Length(tmpStr));
                PosGSE := Pos(';', tmpStr);
                if (tmpStr <> '') and (PosGSE > 0) then
                  begin
                    PosIdx := AnsiIndexStr(Copy(tmpStr, 1, Pred(PosGSE)), ViewListDisplay);
                    if PosIdx > -1 then
                      Result := ViewListXML[PosIdx];
                  end;
              end;
          end;

      // second view rating factor
      4414:
          begin
            tmpStr := CellText;
            if (Trim(tmpStr) <> '') and (tmpStr[2] = ';') then
              begin
                tmpStr := Copy(tmpStr, 3, Length(tmpStr));
                PosGSE := Pos(';', tmpStr);
                if (tmpStr <> '') and (PosGSE > 0) then
                  begin
                    PosIdx := AnsiIndexStr(Copy(tmpStr, Succ(PosGSE), Length(tmpStr)), ViewListDisplay);
                    if PosIdx > -1 then
                      Result := ViewListXML[PosIdx];
                  end;
              end;
          end;

      // first location rating factor
      4420:
          begin
            tmpStr := CellText;
            if (Trim(tmpStr) <> '') and (tmpStr[2] = ';') then
              begin
                tmpStr := Copy(tmpStr, 3, Length(tmpStr));
                PosGSE := Pos(';', tmpStr);
                if (tmpStr <> '') and (PosGSE > 0) then
                  begin
                    PosIdx := AnsiIndexStr(Copy(tmpStr, 1, Pred(PosGSE)), LocListDisplay);
                    if PosIdx > -1 then
                      Result := LocListXML[PosIdx];
                  end;
              end;
          end;

      // second location rating factor
      4421:
          begin
            tmpStr := CellText;
            if (Trim(tmpStr) <> '') and (tmpStr[2] = ';') then
              begin
                tmpStr := Copy(tmpStr, 3, Length(tmpStr));
                PosGSE := Pos(';', tmpStr);
                if (tmpStr <> '') and (PosGSE > 0) then
                  begin
                    PosIdx := AnsiIndexStr(Copy(tmpStr, Succ(PosGSE), Length(tmpStr)), LocListDisplay);
                    if PosIdx > -1 then
                      Result := LocListXML[PosIdx];
                  end;
              end;
          end;

      // construction quality
      4517:
          begin
          tmpStr := CellText;
            if (Trim(tmpStr) <> '') then
              begin
                PosGSE := AnsiIndexStr(tmpStr, QualityListTypCode);
                if PosGSE > -1 then
                  Result := QualityListTypCode[PosGSE];
              end;
          end;

      // basement total square footage
      4426:
        begin
          tmpStr := CellText;
          PosIdx := Pos('sf', tmpStr);
          if PosIdx > 0 then
            begin
              Amt := StrToIntDef(Copy(tmpStr, 1, Pred(PosIdx)), -1);
              if (Amt > -1) then
                Result := IntToStr(Amt);
            end;
        end;
      // basement finished square footage
      4427:
        begin
          tmpStr := CellText;
          PosIdx := Pos('sf', tmpStr);
          if PosIdx > 0 then
            begin
              tmpStr := Copy(tmpStr, (PosIdx + 2), Length(tmpStr));
              PosIdx := Pos('sf', tmpStr);
              Amt := StrToIntDef(Copy(tmpStr, 1, Pred(PosIdx)), -1);
              if (Amt > -1) then
                Result := IntToStr(Amt);
            end;
        end;
      // basement access
      4519:
        begin
          tmpStr := Copy(CellText, (Length(CellText) - 1), 2);
          if Length(tmpStr) = 2 then
            PosIdx := AnsiIndexStr(tmpStr, BsmtAccessDisplay)
          else
            PosIdx := -1;
          if PosIdx > -1 then
            Result := BsmtAccessListXML[PosIdx];
        end;

      // basement rec room count
      4428:
        begin
          tmpStr := CellText;
          PosIdx := Pos('rr', tmpStr);
          if PosIdx > 0 then
            begin
              Amt := StrToIntDef(Copy(tmpStr, 1, Pred(PosIdx)), -1);
              if (Amt > -1) then
                Result := IntToStr(Amt);
            end;
        end;
      // basement bedroom count
      4429:
        begin
          tmpStr := CellText;
          PosIdx := Pos('rr', tmpStr);
          if PosIdx > 0 then
            begin
              tmpStr := Copy(tmpStr, (PosIdx + 2), Length(tmpStr));
              PosIdx := Pos('br', tmpStr);
              if PosIdx > 0 then
                begin
                  Amt := StrToIntDef(Copy(tmpStr, 1, Pred(PosIdx)), -1);
                  if (Amt > -1) then
                    Result := IntToStr(Amt);
                end;
            end;
        end;
      // basement bathroom count
      4430:
        begin
          tmpStr := CellText;
          PosIdx := Pos('br', tmpStr);
          if PosIdx > 0 then
            begin
              tmpStr := Copy(tmpStr, (PosIdx + 2), Length(tmpStr));
              PosIdx := Pos('ba', tmpStr);
              if PosIdx > 0 then
                begin
                  if StrToFloatDef(Copy(tmpStr, 1, Pred(PosIdx)), -1) > -1 then
                    Result := Copy(tmpStr, 1, Pred(PosIdx));
                end;
            end;
        end;
      // basement other room count
      4520:
        begin
          tmpStr := CellText;
          PosIdx := Pos('ba', tmpStr);
          if PosIdx > 0 then
            begin
              tmpStr := Copy(tmpStr, (PosIdx + 2), Length(tmpStr));
              if tmpStr[Length(tmpStr)] = 'o' then
                begin
                  Amt := StrToIntDef(Copy(tmpStr, 1, Pred(Length(tmpStr))), -1);
                  if (Amt > -1) then
                    Result := IntToStr(Amt);
                end;
            end;
        end;

      4431:
        begin
          SrcDesc := '';
          tmpStr := CellText;
          PosGSE := Pos(';', tmpStr);
          if PosGSE > 0 then
            repeat
              SrcDesc := SrcDesc + Copy(tmpStr, 1, PosGSE);
              tmpStr := Copy(tmpStr, Succ(PosGSE), Length(tmpStr));
              PosGSE := Pos(';', tmpStr);
            until PosGSE = 0;
          if (Length(SrcDesc) > 0) and (SrcDesc[Length(SrcDesc)] = ';') then
            SrcDesc := Copy(SrcDesc, 1, Pred(Length(SrcDesc)));
          Result := SrcDesc;
        end;
      // sale or financing concessions financing type
      4432:
        begin
          tmpStr := CellText;
          PosIdx := Pos(';', tmpStr);
          if (PosIdx >= 0) then
            begin
              tmpStr := Copy(tmpStr, 1, Pred(PosIdx));
              if tmpStr <> '' then
                begin
                  PosIdx := AnsiIndexStr(tmpStr, FinDesc);
                  if PosIdx >= 0 then
                    Result := FinType[PosIdx]
                  else
                    Result := FinType[MaxFinTypes];
                end;
            end;
        end;
      // sale or financing concessions financing type "Other" description
      4433:
        begin
          tmpStr := CellText;
          PosIdx := Pos(';', tmpStr);
          if (PosIdx >= 0) then
            begin
              tmpStr := Copy(tmpStr, 1, Pred(PosIdx));
              if tmpStr <> '' then
                begin
                  PosIdx := AnsiIndexStr(tmpStr, FinDesc);
                  if PosIdx < 0 then
                    Result := tmpStr;
                end;
            end;
        end;

      // grid date of sale - comparables only status type
      4434:
        begin
          tmpStr := CellText;
          PosIdx := AnsiIndexStr(tmpStr[1], DOSTypes);
          if PosIdx < 0 then
            PosIdx := AnsiIndexStr(tmpStr, DOSTypes);
          if PosIdx >= 0 then
            Result := DOSTypesXML[PosIdx];
        end;

      // grid date of sale - comparables only short date description #1
      4435:
        begin
          tmpStr := CellText;
          if (Copy(tmpStr, 4, 1) = '/') then
            begin
              Mo := StrToIntDef(Copy(tmpStr, 2, 2), 0);
              Yr := StrToIntDef(Copy(tmpStr, 5, 2), -1);
              if ((Yr >= 0) and ((Mo > 0) and (Mo < 13))) then
                Result := Copy(tmpStr, 2, 5);
            end
          else
            if (Length(tmpStr) = 4) and (tmpStr[1] = 'c') and (Copy(tmpStr, 2, 3) = 'Unk') then
              Result := 'Unk';   
        end;

      // grid date of sale - comparables only short date description #2
      4418:
        begin
          tmpStr := CellText;
          if (Copy(tmpStr, 11, 1) = '/') then
            begin
              Mo := StrToIntDef(Copy(tmpStr, 9, 2), 0);
              Yr := StrToIntDef(Copy(tmpStr, 12, 2), -1);
              if ((Yr >= 0) and ((Mo > 0) and (Mo < 13))) then
                Result := Copy(tmpStr, 9, 5);
            end;
        end;

      4510, 4595, 4597, 4599:
        Result := Format('%-16.12f', [(Cell as TGeocodedGridCell).Latitude]);
      4511, 4596, 4598, 4600:
        Result := Format('%-16.12f', [(Cell as TGeocodedGridCell).Longitude]);

      // first "Other" view rating factor
      4512:
          begin
            tmpStr := CellText;
            if (Trim(tmpStr) <> '') and (tmpStr[2] = ';') then
              begin
                tmpStr := Copy(tmpStr, 3, Length(tmpStr));
                if tmpStr <> '' then
                  begin
                    PosGSE := Pos(';', tmpStr);
                    if PosGSE > 0 then
                      itemStr := Copy(tmpStr, 1, Pred(PosGSE))
                    else
                      itemStr := tmpStr;
                    PosIdx := AnsiIndexStr(itemStr, ViewListDisplay);
                    if (PosIdx < 0) and (itemStr <> '') then
                      Result := itemStr;
                  end;
              end;
          end;

      // second "Other" view rating factor
      4513:
          begin
            tmpStr := CellText;
            if (Trim(tmpStr) <> '') and (tmpStr[2] = ';') then
              begin
                tmpStr := Copy(tmpStr, 3, Length(tmpStr));
                if tmpStr <> '' then
                  begin
                    PosGSE := Pos(';', tmpStr);
                    if PosGSE > 0 then
                      itemStr := Copy(tmpStr, 1, Pred(PosGSE))
                    else
                      itemStr := tmpStr;
                    if (PosGSE > 0) and (itemStr <> '') then
                      begin
                        itemStr := Copy(tmpStr, Succ(PosGSE), Length(tmpStr));
                        if itemStr <> '' then
                          begin
                            PosIdx := AnsiIndexStr(itemStr, ViewListDisplay);
                            if PosIdx < 0 then
                              Result := itemStr;
                          end
                      end;
                  end;
              end;
          end;

      // first "Other" location rating factor
      4514:
          begin
            tmpStr := CellText;
            if (Trim(tmpStr) <> '') and (tmpStr[2] = ';') then
              begin
                tmpStr := Copy(tmpStr, 3, Length(tmpStr));
                if tmpStr <> '' then
                  begin
                    PosGSE := Pos(';', tmpStr);
                    if PosGSE > 0 then
                      itemStr := Copy(tmpStr, 1, Pred(PosGSE))
                    else
                      itemStr := tmpStr;
                    PosIdx := AnsiIndexStr(itemStr, LocListDisplay);
                    if (PosIdx < 0) and (itemStr <> '') then
                      Result := itemStr;
                  end;
              end;
          end;

      // second "Other" location rating factor
      4515:
          begin
            tmpStr := CellText;
            if (Trim(tmpStr) <> '') and (tmpStr[2] = ';') then
              begin
                tmpStr := Copy(tmpStr, 3, Length(tmpStr));
                if tmpStr <> '' then
                  begin
                    PosGSE := Pos(';', tmpStr);
                    if PosGSE > 0 then
                      itemStr := Copy(tmpStr, 1, Pred(PosGSE))
                    else
                      itemStr := tmpStr;
                    if (PosGSE > 0) and (itemStr <> '') then
                      begin
                        itemStr := Copy(tmpStr, Succ(PosGSE), Length(tmpStr));
                        if itemStr <> '' then
                          begin
                            PosIdx := AnsiIndexStr(itemStr, LocListDisplay);
                            if PosIdx < 0 then
                              Result := itemStr;
                          end
                      end;
                  end;
              end;
          end;

      4527:
        if (Cell.FCellXID = 41) or (Cell.FCellXID = 926) then
          begin
            CityStZip := CellText;
            PosGSE := Pos(',',CityStZip);
            if PosGSE > 0 then
              // If there are 2 commas in the address then retrieve the unit
              if Pos(',', Copy(CityStZip, Succ(PosGSE), Length(CityStZip))) > 0 then
                Result := Copy(cityStZip, 1, Pred(PosGSE));
          end;
      4528:
        if (Cell.FCellXID = 41) or (Cell.FCellXID = 926) then
          begin
            sUnit := '';
            CityStZip := CellText;
            PosGSE := Pos(',',CityStZip);
            if PosGSE > 0 then
              begin
                // If there is a unit number (2 commas in the address) then
                //  retrieve the unit and capture only the city, state and zip
                //  for further processing
                if Pos(',', Copy(CityStZip, Succ(PosGSE), Length(CityStZip))) > 0 then
                  begin
                    sUnit := Copy(cityStZip, 1, Pred(PosGSE));
                    CityStZip := Copy(CityStZip, Succ(PosGSE), Length(CityStZip));
                  end;
              end;
            Result  := ParseCityStateZip3(CityStZip, cmdGetCity);
          end;
      4529:
        if (Cell.FCellXID = 41) or (Cell.FCellXID = 926) then
          begin
            sUnit := '';
            CityStZip := CellText;
            PosGSE := Pos(',',CityStZip);
            if PosGSE > 0 then
              begin
                // If there is a unit number (2 commas in the address) then
                //  retrieve the unit and capture only the city, state and zip
                //  for further processing
                if Pos(',', Copy(CityStZip, Succ(PosGSE), Length(CityStZip))) > 0 then
                  begin
                    sUnit := Copy(cityStZip, 1, Pred(PosGSE));
                    CityStZip := Copy(CityStZip, Succ(PosGSE), Length(CityStZip));
                  end;
              end;
            Result := ParseCityStateZip3(CityStZip, cmdGetState);
          end;
      4530:
        if (Cell.FCellXID = 41) or (Cell.FCellXID = 926) then
          begin
            sUnit := '';
            CityStZip := CellText;
            PosGSE := Pos(',',CityStZip);
            if PosGSE > 0 then
              begin
                // If there is a unit number (2 commas in the address) then
                //  retrieve the unit and capture only the city, state and zip
                //  for further processing
                if Pos(',', Copy(CityStZip, Succ(PosGSE), Length(CityStZip))) > 0 then
                  begin
                    sUnit := Copy(cityStZip, 1, Pred(PosGSE));
                    CityStZip := Copy(CityStZip, Succ(PosGSE), Length(CityStZip));
                  end;
              end;
            Result := ParseCityStateZip3(CityStZip, cmdGetZip);
          end;
      4531:
        begin
          tmpStr := CellText;
          PosGSE := Pos(';', tmpStr);
          if PosGSE > 0 then
            repeat
              tmpStr := Copy(tmpStr, Succ(PosGSE), Length(tmpStr));
              PosGSE := Pos(';', tmpStr);
            until PosGSE = 0;
          if tmpStr <> '' then
            begin
              PosGSE := Pos('DOM', tmpStr);
              if PosGSE > 0 then
                Result := Trim(Copy(tmpStr, (PosGSE + 3), Length(tmpStr)));
            end;
        end;
      // sales or financing concessions type
      4532:
        begin
          tmpStr := CellText;
          PosIdx := AnsiIndexStr(tmpStr, SalesTypesDisplay);
          if (PosIdx >= 0) then
            Result := SalesTypesXML[PosIdx];
        end;
      // sales or financing concessions amount
      4533:
        begin
          tmpStr := CellText;
          PosIdx := Pos(';', tmpStr);
          if (PosIdx >= 0) then
            Result := Copy(tmpStr, Succ(PosIdx), Length(tmpStr));
        end;
      // grid date of sale - comparables only short date description #2
      4534:
        begin
          tmpStr := CellText;
          if ((tmpStr[1] = 's') and (Copy(tmpStr, 8, Length(tmpStr)) = 'Unk')) or
             ((tmpStr[1] = 'c') and (Copy(tmpStr, 2, Length(tmpStr)) = 'Unk')) then
            Result := 'Y'
          else
            Result := 'N';
        end;

      // appraiser or supervisor single line address (XID 1660, 1737)-name
      4545, 4563:
        begin
          tmpStr := CellText;
          PosIdx := Pos(',', tmpStr);
          if (PosIdx >= 0) then
            Result := Copy(tmpStr, 1, Pred(PosIdx));
        end;
      // appraiser or supervisor address2-city
      4547, 4585: Result := ParseCityStateZip3(CellText, cmdGetCity);
      // appraiser or supervisor address2-state
      4548, 4586: Result := ParseCityStateZip3(CellText, cmdGetState);
      // appraiser or supervisor address2-zip
      4549, 4587: Result := ParseCityStateZip3(CellText, cmdGetZip);

    else
      Result := CellText;
    end;
end;

/// summary: Exports GSEData for the specified cell.
procedure ExportGSEData(const Cell: TBaseCell; const Translator: TMISMOTranslator; const ExportedList: TExportedList = nil; const MapLocator: TMapCellLocaterEvent = nil; const ColumnNumber: Integer = -1);
var
  Configuration: IXMLDOMElement;
  DataPoint: IXMLDOMNode;
  DataPointList: IXMLDOMNodeList;
  GSEData: TStringList;
  Index: Integer;
  Value: String;
  XIDInteger: Integer;
  XIDString: String;
begin
  GSEData := TStringList.Create;
  try
    GSEData.CommaText := Cell.GSEData;
    //need to load in UAD Database becuase it has the defaults for the fields
    Configuration := TUADConfiguration.Cell(Cell.FCellXID, Cell.UID);
    Configuration := TUADConfiguration.Mismo(Configuration, True);
    if Assigned(Configuration) then
      begin
        DataPointList := Configuration.selectNodes('DataPoints/DataPoint');
        for Index := 0 to DataPointList.length - 1 do
          begin
            DataPoint := DataPointList.item[Index];
            XIDString := DataPoint.attributes.getNamedItem('XID').text;
            XIDInteger := StrToInt(XIDString);

            // get export value
            // 050912 New method retrieves data from cell text, even if data points exist
            Value := GetTextAsGSEData(XIDInteger, Cell, Translator, nil, MapLocator, ColumnNumber);
            if Value = '' then
              Value := DataPoint.text;  // get the default
            // 050912 Was:
            {if (GSEData.Values[XIDString] = '') then
              begin
                Value := GetTextAsGSEData(XIDInteger, Cell, Translator, nil, MapLocator, ColumnNumber);
                if Value = '' then
                  Value := DataPoint.text;  // get the default
              end
            else
              Value := GSEData.Values[XIDString];}

            // 090711 JWyatt Special cases where 'Description' is actually a whole number format
            case Cell.FCellXID of
              67, 976, 1004: Value := StringReplace(Value, ',', '', [rfReplaceAll]);
            end;

            // export through the mismo translator
            if (XIDInteger > 0) then
              begin
                if not (Value = '') then
                  begin
                    if (ColumnNumber > -1) then
                      Translator.ExportValue(XIDInteger, EMPTY_STRING, IntToStr(ColumnNumber), Value)
                    else if not Assigned(ExportedList) then
                      Translator.ExportValue(XIDInteger, Value)
                    else if not ExportedList.HasBeenExported(XIDInteger) then
                      Translator.ExportValue(XIDInteger, Value);
                  end;
                // map cell locator
                if Assigned(MapLocator) then
                  MapLocator(XIDInteger, Cell, Translator);
              end;
          end;
      end;
  finally
    GSEData.Destroy;
  end;
end;

/// summary: Embeds cell locator information within the export document.
/// remarks: Replaces the previously exported value since this export document
//           is exclusively for use with cell locating.
procedure MapEmbeddedLocater(const XID: Integer; const Cell: TBaseCell; const Translator: TMISMOTranslator);
const
  CIdentificationType = 'Loc';
var
  Coordinates: TPoint;
  UID: CellUID;
  Value: String;
begin
  UID := Cell.UID;
  Value := Format('P%d.%d', [UID.Pg + 1, UID.Num + 1]);

  if (Cell is TGridCell) then
    begin
      (Cell as TGridCell).GetCoordinates(Coordinates);
      Translator.ExportValue(XID, CIdentificationType, IntToStr(Coordinates.Y), Value);
    end
  else
    Translator.ExportValue(XID, CIdentificationType, EMPTY_STRING, Value);
end;

/// summary: Stores XPath cell locator information within the document container.
procedure MapXPathLocater(const XID: Integer; const Cell: TBaseCell; const Translator: TMISMOTranslator);
var
  Document: TContainer;
begin
  Document := Cell.ParentPage.ParentForm.ParentDocument as TContainer;
  Document.CellXPathList.AddItem(Cell.InstanceID, Translator.Mappings.Find(XID).XPath);
end;

function ExtensionToImageType(AnExtension : string) : TImageFormat;
begin
   if Copy(AnExtension, 1, 1) = '.' then
       System.Delete(AnExtension, 1, 1);

   if SameText(AnExtension, 'bmp') then
       Result := if_BMP

   else if SameText(AnExtension, 'jpg') or SameText(AnExtension, 'jpeg') then
       Result := if_JPG

   else if SameText(AnExtension, 'tif') or SameText(AnExtension, 'tiff') then
       Result := if_TIF

   else if SameText(AnExtension, 'tga') or SameText(AnExtension, 'targa') then
       Result := if_TGA

   else if SameText(AnExtension, 'gif') then
       Result := if_GIF

   else if SameText(AnExtension, 'png') then
       Result := if_PNG

   else if SameText(AnExtension, 'pcd') then
       Result := if_PCD

   else if SameText(AnExtension, 'emf') then
       Result := if_EMF

   else if SameText(AnExtension, 'wmf') then
       Result := if_WMF

   else
       Result := if_Unknown;
end;

function ExtensionToMime(const AnExtension : string) : string;
begin
  Result := IMAGE_FORMAT_MIME[ExtensionToImageType(AnExtension)];
end;

function MimeToExtension(AMime : string) : string;
begin
   if SameText(AMime, 'image/bmp') then
       Result := 'bmp'

   else if SameText(AMime, 'image/jpeg') then
       Result := 'jpeg'

   else if SameText(AMime, 'image/tiff') then
       Result := 'tiff'

   else if SameText(AMime, 'image/targa') then
       Result := 'targa'

   else if SameText(AMime, 'image/gif') then
       Result := 'gif'

   else if SameText(AMime, 'image/png') then
       Result := 'png'

   else if SameText(AMime, 'image/x-photo-cd') then
       Result := 'pcd'

   else if SameText(AMime, 'image/windows/metafile') then
       Result := 'emf'

   else if SameText(AMime, 'image/windows/metafile') then
       Result := 'wmf'

   else
       raise Exception.Create('Unrecognized mime type ' + AMime);
end;

function ImageLibTypeToImageFormat(const AString : string) : TImageFormat;
begin
  if AString = uGraphics.cfi_DIB then
    Result := if_DIB
  else if AString = uGraphics.cfi_BMP then
    Result := if_BMP
  else if AString = uGraphics.cfi_PNG then
    Result := if_PNG
  else if AString = uGraphics.cfi_GIF then
    Result := if_GIF
  else if AString = uGraphics.cfi_PCX then
    Result := if_PCX
  else if AString = uGraphics.cfi_JPG then
    Result := if_JPG
  else if AString = uGraphics.cfi_PCD then
    Result := if_PCD
  else if AString = uGraphics.cfi_TGA then
    Result := if_TGA
  else if AString = uGraphics.cfi_TIF then
    Result := if_TIF
  else if AString = uGraphics.cfi_WMF then
    Result := if_WMF
  else if AString = uGraphics.cfi_EMF then
    Result := if_EMF
  else
     Result := if_Unknown;
end;

(*
//###REMOVE  - DUPLICATE  - NOT USED IN THIS UNIT

function IsFalseGridCell(ACellID : Integer) : Boolean;
begin
   Result := True;
   case ACellID of
       4 : ;                                               //     Case Number Identifier
       35 : ;                                              //     Client (Company) Name
       36 : ;                                              //     Client Street Address
       45 : ;                                              //     Borrower Unparsed Name
       46 : ;                                              //     Property Address
       47 : ;                                              //      Property City
       48 : ;                                              //     Property State
       49 : ;                                              //     Property Postal Code
       50 : ;                                              //     Property Country
       92 : ;                                              //     Driveway Surface Comment
       114 : ;
       146 : ;                                             //     Living Unit Count
       151 : ;                                             //    Subject structure built year
       229 : ;                                             //     Total Room Count
       230 : ;                                             //     Total Bedroom Count
       231 : ;                                             //     Total Bathroom Count
       232 : ;                                             //     Gross Living Area Square Feet Count
       309 : ;                                             //     Kitchen Equipment Type Other Description
       333 : ;                                             //     Structure Deck Detailed Description
       335 : ;                                             //     Structure Porch Detailed Description
       337 : ;                                             //      Structure Fence Detailed Description
       340 : ;                                             //     Structure Pool Detailed Description
       344 : ;                                             //     Structure Exterior Features Other Description
       349 : ;                                             //     Structure Car Storage (Garage)
       355 : ;                                             //     Structure Car Storage (Carport)
       360 : ;                                             //     Structure Car Storage (Driveway) Parking Spaces Count
       920 : ;                                             //     Sales Comparison Researched Count
       921 : ;                                             //     Sales Comparison Low Price Range
       922 : ;                                             //     Sales Comparison High Price Range
       924 : ;                                             //     Extra Item One Name
       2009 : ;                                            //     Extra Item One Name
       2073 : ;                                            //     Extra Item One Name
       1091 : ;                                            //     Listing Comparison Researched Count
       1092 : ;                                            //     Listing Comparison Low Price Range
       1093 : ;                                            //     Listing Comparison High Price Range
       2010 : ;                                            //     Page number placeholder
       2028 : ;                                            //     Structure Woodstove count
       2090 : ;                                            //      Data Source Description
       2742..2746 : ;                                      //     Rental grid summary cells
       2275..2306 : ;                                      //     Rental grid unit cells
   else
       Result := False;
   end;
end;
*)

//### DUPLICATED IN UMISMOINTERFCE
function IsPublicAppraisalFormType(AFormID : Integer) : Boolean;
begin
  case AFormID of
    FMX_1004,
    FMX_1004P,
    FMX_1004C,
    FMX_1004D,
    ERC_1994,
    ERC_2001,
    ERC_2003,
    FMX_1073,
    FMX_1075,
    FMX_1025,
    FMX_2000,
    FMX_2000A,
    FMX_2055,
    MOBILE_HOME,
    LAND_APPRAISAL,
    COMPLETION_CERTIFICATE_LEGAL,  //  442
    FMAE_1004_1993,
    FMAE_1073_1997,
    FMAE_1025_1994,
    FMAE_2055_1996,
    FMAE_2065_1996,
    FMAE_2075_1997,
    FMAE_2070:
      Result := True;
  else
      Result := False;
  end;
end;

//used to check for data before creating elements
function FormCellsHaveText(AForm: TDocForm; const CellIDs: Array of Integer): Boolean;
var
  len,i: Integer;
begin
  result := False;
  len := length(CellIDs);
  for i := 0 to len -1 do
    if length(Trim(AForm.GetCellTextByXID_MISMO(CellIDs[i]))) > 0 then
      begin
        result := True;
        break;
      end;
end;

function MISMOBoolean(value: Boolean): String;
begin
  result := 'N';
  if value then
    result := 'Y';
end;

function MISMODate(ADoc: TContainer; ACell: TBaseCell; ErrList: TObjectList): String;
var
  AValue: String;
  ADate: TDateTime;
begin
  result := '';
  if assigned(ACell) then
    begin
      AValue := ACell.GetText;
      if IsValidDateTimeWithDiffSeparator(AValue, ADate) then
        result := FormatDateTime('yyyy-mm-dd', ADate)
      else
        result := AValue;   //this is RELS Specific exception
    end;
end;

//-----------------------------------
//  Start of the Export XML Routines
//-----------------------------------

procedure ExportReportAttributes(doc: TContainer; exportForm: BooleanArray;
  ATranslator: TMISMOTranslator; Info: TMiscInfo; IsVer2_6: Boolean; XMLVer: String);
//var
//  fName, fVers: String;
begin
  ATranslator.ExportValue(SOFTWARE_NAME_CELLID, ClickFormsName);                     //Producing Software Name
  ATranslator.ExportValue(SOFTWARE_VERSION_CELLID, SysInfo.AppVersion);              //Producing Software Version
  ATranslator.ExportValue(2995, StringReplace(XMLVer, '_', '.', [rfReplaceAll]));    //MISMOVersionID - GSE
  // 030411 JWyatt The VendorVersionIdentifier is not supported for version
  //  2.6 reports
  if not IsVer2_6 then
    ATranslator.ExportValue(GSE_VERSION_CELLID, GSE_XMLVersion);                 //GSE version of XML
	ATranslator.ExportValue(2992, doc.GetCellTextByXID_MISMO(2992, exportForm));   //AppraisalScopeOfWorkDescription
	ATranslator.ExportValue(2993, doc.GetCellTextByXID_MISMO(2993, exportForm));   //AppraisalIntendedUserDescription
	ATranslator.ExportValue(2994, doc.GetCellTextByXID_MISMO(2994, exportForm));   //AppraisalIntendedUseDescription

  // If we're not processing a UAD compliant report & there is report info
  //  declared then we can export the following attributes. If this is a UAD
  //  compliant report, exporting these attributes will cause the XML to
  //  be invalid when validated using the MISMO schema.
  {********** THESE ARE FOR ELS *******************}
  if (not IsVer2_6) and assigned(Info) then
    begin
      //set undue influence on appraiser
      ATranslator.ExportValue(10503, Info.FHasUndueInfluence);
      if (length(Info.FUndueInfluenceDesc) > 0) then
        ATranslator.ExportValue(10504, Info.FUndueInfluenceDesc);

      //pass on the order ID in Vendor Transaction Identifier
      ATranslator.ExportValue(10505, Info.FOrderID);

      //pass on the appraiser ID in Appraiser Identifier
      ATranslator.ExportValue(10506, Info.FAppraiserID);

      //pass on only if it is true that ClickForms review was overridden
      if Info.FRevOverride then
        ATranslator.ExportValue(10508, Info.FRevOverride);
   end;
  // The following code fragment along with the variables above have been
  //  commented for a long time and their use is unknown.
(*
--- AppraisalFormType is handled by AppraisalReportContentType

  //Set Major form type
  if AppraisalMajorFormName(doc, fName, fVers) then  //have a major form
    begin
      ATranslator.ExportValue(10500, fName);
      ATranslator.ExportValue(10501, fVers);
    end
  else  //unknown major form
    begin
      ATranslator.ExportValue(10500, 'Other');
      ATranslator.ExportValue(10501, 'Unknown');
      ATranslator.ExportValue(10502, fName);
    end;
*)
end;

procedure ExportReportEmbededPDF(doc: TContainer; ATranslator: TMISMOTranslator; Info: TMiscInfo; V2_6Element:TXMLElement=nil);  // PDFPath: string );
const
  errCannotFindPDFFile = 'Cannot find the PDF file %s!';
var
  AStream: TFileStream;
  pdfStr, EncodedStr : string;
  AnElement: TXMLElement;
begin
  if assigned(Info) and Info.FEmbedPDF then
    begin
      if not fileExists(Info.FPDFFileToEmbed) then
        raise Exception.Create(Format(errCannotFindPDFFile,[Info.FPDFFileToEmbed]));

      AStream := TFileStream.Create(Info.FPDFFileToEmbed, fmOpenRead);
      try
        SetLength(pdfStr, AStream.Size);
        AStream.Read(PChar(pdfStr)^,length(pdfStr));
      finally
        AStream.Free;
      end;

      if length(pdfStr) > 0 then
        begin
           EncodedStr := UBase64.Base64Encode(pdfStr);
           if Assigned(V2_6Element) then
             begin
               AnElement := V2_6Element;
               AnElement := AnElement.AddElement('IMAGE');
               AnElement.AttributeValues['_SequenceIdentifier'] := '1';
               AnElement.AttributeValues['_Name'] := 'AppraisalForm';
             end
           else
             AnElement := ATranslator.XML.FindElement('REPORT');
           with AnElement.AddElement('EMBEDDED_FILE') do
             begin
                AttributeValues['_Type'] := 'PDF';
                AttributeValues['_EncodingType'] := 'Base64';
                AttributeValues['_Name'] := 'AppraisalReport';
                AttributeValues['MIMEType'] := 'application/pdf';
                AddElement('DOCUMENT').RawText := EncodedStr;
             end;
        end;
    end;
end;


//This is ugly because we went from Data Centric to Form Centric so now each form has to be checked
//and certain elements created based on what is in the signature block. This could be rethought and
//probably made simplier to code and understand.
// Version 7.2.8 090110 JWyatt The ExpireDateExists variable and the checks for form ID 794
//  are included to address unique XML addresses assigned to this form. This was discussed
//  in a meeting today and it was agreed that this code should be revised to use only
//  XML IDs in the next release.
procedure ExportFormSigners(ADoc: TContainer; AForm: TDocForm; AElement: TXMLElement; ErrList: TObjectList);
var
  Signer, Person, Signature, Contact,
  Inspection, License: TXMLElement;
  CityStZip, Phone, Fax, Email: String;
  hasSignature: Boolean;
  ExpireDateExists: Boolean;
  // These variables are declared to handle special processing for cell XID 2008
  ChkBoxUID: CellUID;
  InspDateCell: TBaseCell;
  InspDateSet: Boolean;
begin
//IMPORTANT- make sure we skip these cells in main export loop
//Exported Appraiser CellIDs
//7,1684,9,10,11,12,13,5,14,15,16
//17,18,19,20,21,5008,2098,2096,2097
//1149,1150,1151,2009,1660,1678

  if FormCellsHaveText(AForm, [7,22,1402]) or      //appraiser names
     FormCellsHaveText(AForm, [1150,1151])then     //inspection checkboxes
    Signer := AElement.AddElement('SIGNERS')       //create single SIGNER element for form
  else
    exit;

  //Is the appraiser's name on this form?
//  if Length(AForm.GetCellTextByXID_MISMO(7))>0 then
  if FormCellsHaveText(AForm, [7,1150,1151]) then  //signature or inspection checkboxes
    begin
      Person :=  Signer.AddElement('APPRAISER');
      Person.AttributeValues['_Name'] := AForm.GetCellTextByXID_MISMO(7);
      Person.AttributeValues['_CompanyName'] := AForm.GetCellTextByXID_MISMO(1684);
      Person.AttributeValues['_StreetAddress'] := AForm.GetCellTextByXID_MISMO(9);
      CityStZip := AForm.GetCellTextByXID_MISMO(10);                                      //Appraiser City, St, Zip
      Person.AttributeValues['_StreetAddress2'] := CityStZip;
      Person.AttributeValues['_City'] := ParseCityStateZip3(CityStZip, 1);        //Appraiser City
      Person.AttributeValues['_State'] := ParseCityStateZip3(CityStZip, 2);       //Appraiser State
      Person.AttributeValues['_PostalCode'] := ParseCityStateZip3(CityStZip, 3);  //Appraiser Zip
      Person.AttributeValues['AppraisalFormsUnparsedAddress'] := AForm.GetCellTextByXID_MISMO(1660);

      if FormCellsHaveText(AForm, [14,15,16]) then
        begin
          Contact := Person.AddElement('CONTACT_DETAIL');

          Phone := AForm.GetCellTextByXID_MISMO(14);
          if length(phone)> 0 then
            Contact.AddElement('CONTACT_POINT', ['_Type', 'Phone', '_Value', Phone]);

          fax := AForm.GetCellTextByXID_MISMO(15);
          if length(fax)>0 then
            Contact.AddElement('CONTACT_POINT', ['_Type', 'Fax', '_Value', Fax]);

          email := AForm.GetCellTextByXID_MISMO(16);
          if length(email)>0 then
            Contact.AddElement('CONTACT_POINT', ['_Type', 'Email', '_Value', email]);
        end;

(*
<FIELD ID="17" XPath="//VALUATION_RESPONSE/PARTIES/APPRAISER/APPRAISER_LICENSE/@_ExpirationDate"/>
  <FIELD ID="18" XPath="//VALUATION_RESPONSE/PARTIES/APPRAISER/APPRAISER_LICENSE[@_Type=&dq;Certificate&dq;]/@_Identifier"/>
  <FIELD ID="19" XPath="//VALUATION_RESPONSE/PARTIES/APPRAISER/APPRAISER_LICENSE/.[@_Type=&dq;Certificate&dq;]/@_State"/>
  <FIELD ID="20" XPath="//VALUATION_RESPONSE/PARTIES/APPRAISER/APPRAISER_LICENSE[@_Type=&dq;License&dq;]/@_Identifier"/>
  <FIELD ID="21" XPath="//VALUATION_RESPONSE/PARTIES/APPRAISER/APPRAISER_LICENSE/.[@_Type=&dq;License&dq;]/@_State"/>
<FIELD ID="5008" XPath="//VALUATION_RESPONSE/PARTIES/APPRAISER/APPRAISER_LICENSE/@_Identifier"/>
<FIELD ID="2098" XPath="//VALUATION_RESPONSE/PARTIES/APPRAISER/APPRAISER_LICENSE/@_State"/>
<FIELD ID="2096" XPath="//VALUATION_RESPONSE/PARTIES/APPRAISER/APPRAISER_LICENSE[@_Type=&dq;Other&dq;]/@_Identifier"/>
<FIELD ID="2097" XPath="//VALUATION_RESPONSE/PARTIES/APPRAISER/APPRAISER_LICENSE[@_Type=&dq;Other&dq;]/@_TypeOtherDescription"/>
*)
      //Appraiser License Configurations
      License := nil;
      if FormCellsHaveText(AForm, [20,21]) then //has License Identifier
        begin
          ExpireDateExists := (Trim(AForm.GetCellText(1,263)) <> '');
          if (AForm.FormID = 794) and ExpireDateExists then
            Person.AddElement('APPRAISER_LICENSE');
          License := Person.AddElement('APPRAISER_LICENSE', ['_Type', 'License']);
          License.AttributeValues['_Identifier'] := AForm.GetCellTextByXID_MISMO(20);
          License.AttributeValues['_State'] := AForm.GetCellTextByXID_MISMO(21);
          if not (length(AForm.GetCellTextByXID_MISMO(21))>0) then
            License.AttributeValues['_State'] := AForm.GetCellTextByXID_MISMO(2098);
          if (AForm.FormID = 794) and ExpireDateExists then
            License := License.ParentElement;
          License.AttributeValues['_ExpirationDate'] := MISMODate(ADoc, AForm.GetCellByXID_MISMO(17), ErrList);
        end;
      if FormCellsHaveText(AForm, [18,19]) then  //has Certificate Identifier
        begin
          ExpireDateExists := (Trim(AForm.GetCellText(1,263)) <> '');
          if (AForm.FormID = 794) and (not FormCellsHaveText(AForm, [20,21])) and ExpireDateExists then
            Person.AddElement('APPRAISER_LICENSE');
          License := Person.AddElement('APPRAISER_LICENSE', ['_Type', 'Certificate']);
          License.AttributeValues['_Identifier'] := AForm.GetCellTextByXID_MISMO(18);
          License.AttributeValues['_State'] := AForm.GetCellTextByXID_MISMO(19);
          if not (length(AForm.GetCellTextByXID_MISMO(19))>0) then
            License.AttributeValues['_State'] := AForm.GetCellTextByXID_MISMO(2098);
          if (AForm.FormID = 794) and ExpireDateExists then
            License := License.ParentElement;
          License.AttributeValues['_ExpirationDate'] := MISMODate(ADoc, AForm.GetCellByXID_MISMO(17), ErrList);
        end;
      if FormCellsHaveText(AForm, [2096,2097]) then //has Other Identifier
        begin
          License := Person.AddElement('APPRAISER_LICENSE', ['_Type', 'Other']);
          License.AttributeValues['_Identifier'] := AForm.GetCellTextByXID_MISMO(2096);
          License.AttributeValues['_TypeOtherDescription'] := AForm.GetCellTextByXID_MISMO(2097);
          License.AttributeValues['_State'] := AForm.GetCellTextByXID_MISMO(2098);
          License.AttributeValues['_ExpirationDate'] := MISMODate(ADoc, AForm.GetCellByXID_MISMO(17), ErrList);
        end;
      if FormCellsHaveText(AForm, [1517]) then  //has unknown Identifier
        begin
          License := Person.AddElement('APPRAISER_LICENSE');
          License.AttributeValues['_Identifier'] := AForm.GetCellTextByXID_MISMO(1517);
          License.AttributeValues['_State'] := AForm.GetCellTextByXID_MISMO(2098);
          License.AttributeValues['_ExpirationDate'] := MISMODate(ADoc, AForm.GetCellByXID_MISMO(17), ErrList);
        end;
      if FormCellsHaveText(AForm, [5008]) then //has Other (License or Certificate) Identifier
        begin
          License := Person.AddElement('APPRAISER_LICENSE', ['_Type', 'Other']);
          License.AttributeValues['_TypeOtherDescription'] := AForm.GetCellTextByXID_MISMO(5008);
          License.AttributeValues['_State'] := AForm.GetCellTextByXID_MISMO(2098);
          License.AttributeValues['_ExpirationDate'] := MISMODate(ADoc, AForm.GetCellByXID_MISMO(17), ErrList);
        end;
      if not assigned(License) and FormCellsHaveText(AForm, [2098,17]) then  //only entered exp or date
        begin
          License := Person.AddElement('APPRAISER_LICENSE');
          License.AttributeValues['_State'] := AForm.GetCellTextByXID_MISMO(2098);
          License.AttributeValues['_ExpirationDate'] := MISMODate(ADoc, AForm.GetCellByXID_MISMO(17), ErrList);
        end;
(*
<FIELD ID="1149" XPath="//VALUATION_RESPONSE/PARTIES/APPRAISER/INSPECTION[@AppraisalInspectionPropertyType=&dq;Subject&dq;]/.[@AppraisalInspectionType=&dq;None&dq;]"/>
<FIELD ID="1150" XPath="//VALUATION_RESPONSE/PARTIES/APPRAISER/INSPECTION[@AppraisalInspectionPropertyType=&dq;Subject&dq;]/.[@AppraisalInspectionType=&dq;ExteriorOnly&dq;]"/>
<FIELD ID="1151" XPath="//VALUATION_RESPONSE/PARTIES/APPRAISER/INSPECTION[@AppraisalInspectionPropertyType=&dq;Subject&dq;]/.[@AppraisalInspectionType=&dq;ExteriorAndInterior&dq;]"/>
<FIELD ID="2009" XPath="//VALUATION_RESPONSE/PARTIES/APPRAISER/INSPECTION[@AppraisalInspectionPropertyType=&dq;Subject&dq;]/@InspectionDate"/>
*)
      //Appraiser's Date and Type of Inspection
      if FormCellsHaveText(AForm, [1149,1150,1151,2009]) then
        begin
          Inspection := Person.AddElement('INSPECTION', ['AppraisalInspectionPropertyType', 'Subject']);
          if CompareText(AForm.GetCellTextByXID_MISMO(1149), 'X')=0 then
            Inspection.AttributeValues['AppraisalInspectionType'] := 'None';
          if CompareText(AForm.GetCellTextByXID_MISMO(1150), 'X')=0 then
            Inspection.AttributeValues['AppraisalInspectionType'] := 'ExteriorOnly';
          if CompareText(AForm.GetCellTextByXID_MISMO(1151), 'X')=0 then
            Inspection.AttributeValues['AppraisalInspectionType'] := 'ExteriorAndInterior';
          if length(AForm.GetCellTextByXID_MISMO(2009))> 0 then
            Inspection.AttributeValues['InspectionDate'] := MISMODate(ADoc, AForm.GetCellByXID_MISMO(2009), ErrList);
        end;


      //Appraiser's Signature and Date
      // Version 7.2.7 082710 JWyatt Add special case check for the FNMA 2000 & 2000A
      //  certification forms. They have a "Reviewer" signature panel but the associated
      //  IDs (name, company name, company address, etc.) are the APPRAISER element IDs
      //  in the XML, not the REVIEW_APPRAISER IDs. This was a RELS requirement so, in
      //  these case, we must check for "Reviewer" to determine whether or not there
      //  is a signature affixed.
      if (AForm.FormID = FMX_2000_INST) or (AForm.FormID = FMX_2000A_INST) then
        hasSignature := ADoc.docSignatures.SignatureIndexOf('Reviewer') > -1
      else
        hasSignature := ADoc.docSignatures.SignatureIndexOf('Appraiser') > -1;
      if hasSignature or (Length(AForm.GetCellTextByXID_MISMO(5))>0) then //is there a signature date
        begin
          Signature := Person.AddElement('SIGNATURE');
          Signature.AttributeValues['_Date'] := MISMODate(ADoc, AForm.GetCellByXID_MISMO(5), ErrList);
          Signature.AttributeValues['_AffixedIndicator'] := MISMOBoolean(hasSignature);
        end;
    end;

{--SUPERVIOR-------------------------------------------------------------}
//Exported Supervisor CellIDs
//6,22,23,24,42,25,26,27,276,277
//5018,2099,28,29,30,32,33
//1152,1153,1154,2008,1155,1156,2100,1679

  //Is the supervisor's name on this form?
  if length(AForm.GetCellTextByXID_MISMO(22))>0 then
    begin
      Person :=  Signer.AddElement('SUPERVISOR');
      Person.AttributeValues['_Name'] := AForm.GetCellTextByXID_MISMO(22);

      Person.AttributeValues['_CompanyName'] := AForm.GetCellTextByXID_MISMO(23);
      Person.AttributeValues['_StreetAddress'] := AForm.GetCellTextByXID_MISMO(24);
      CityStZip := AForm.GetCellTextByXID_MISMO(42);                                     //Supervisor City, St, Zip
      Person.AttributeValues['_StreetAddress2'] := CityStZip;
      Person.AttributeValues['_City'] := ParseCityStateZip3(CityStZip, 1);        //Supervisor City
      Person.AttributeValues['_State'] := ParseCityStateZip3(CityStZip, 2);       //Supervisor State
      Person.AttributeValues['_PostalCode'] := ParseCityStateZip3(CityStZip, 3);  //Supervisor Zip

      if FormCellsHaveText(AForm, [276,277]) then
        begin
          Contact := Person.AddElement('CONTACT_DETAIL');

          Phone := AForm.GetCellTextByXID_MISMO(276);
          if length(phone)> 0 then
            Contact.AddElement('CONTACT_POINT', ['_Type', 'Phone', '_Value', Phone]);

          email := AForm.GetCellTextByXID_MISMO(277);
          if length(email)>0 then
            Contact.AddElement('CONTACT_POINT', ['_Type', 'Email', '_Value', email]);
        end;
(*
<FIELD ID="5018" XPath="//VALUATION_RESPONSE/PARTIES/SUPERVISOR/APPRAISER_LICENSE/@_Identifier"/>
<FIELD ID="2099" XPath="//VALUATION_RESPONSE/PARTIES/SUPERVISOR/APPRAISER_LICENSE/@_State"/>
<FIELD ID="28" XPath="//VALUATION_RESPONSE/PARTIES/SUPERVISOR/APPRAISER_LICENSE/@_ExpirationDate"/>
<FIELD ID="29" XPath="//VALUATION_RESPONSE/PARTIES/SUPERVISOR/APPRAISER_LICENSE[@_Type=&dq;Certificate&dq;]/@_Identifier"/>
<FIELD ID="30" XPath="//VALUATION_RESPONSE/PARTIES/SUPERVISOR/APPRAISER_LICENSE/.[@_Type=&dq;Certificate&dq;]/@_State"/>
<FIELD ID="32" XPath="//VALUATION_RESPONSE/PARTIES/SUPERVISOR/APPRAISER_LICENSE[@_Type=&dq;License&dq;]/@_Identifier"/>
<FIELD ID="33" XPath="//VALUATION_RESPONSE/PARTIES/SUPERVISOR/APPRAISER_LICENSE/.[@_Type=&dq;License&dq;]/@_State"/>
*)
      //Supervisor License Configurations
      License := nil;
      if FormCellsHaveText(AForm, [32,33]) then //has License Identifier
        begin
          ExpireDateExists := (Trim(AForm.GetCellText(1,270)) <> '');
          if (AForm.FormID = 794) and ExpireDateExists then
            Person.AddElement('APPRAISER_LICENSE');
          License := Person.AddElement('APPRAISER_LICENSE', ['_Type', 'License']);
          License.AttributeValues['_Identifier'] := AForm.GetCellTextByXID_MISMO(32);
          License.AttributeValues['_State'] := AForm.GetCellTextByXID_MISMO(33);
          if not (length(AForm.GetCellTextByXID_MISMO(33))>0) then
            License.AttributeValues['_State'] := AForm.GetCellTextByXID_MISMO(2099);
          if (AForm.FormID = 794) and ExpireDateExists then
            License := License.ParentElement;
          License.AttributeValues['_ExpirationDate'] := MISMODate(ADoc, AForm.GetCellByXID_MISMO(28), ErrList);
        end;
      if FormCellsHaveText(AForm, [29,30]) then  //has Certificate Identifier
        begin
          ExpireDateExists := (Trim(AForm.GetCellText(1,270)) <> '');
          if (AForm.FormID = 794) and (not FormCellsHaveText(AForm, [32,33])) and ExpireDateExists then
            Person.AddElement('APPRAISER_LICENSE');
          License := Person.AddElement('APPRAISER_LICENSE', ['_Type', 'Certificate']);
          License.AttributeValues['_Identifier'] := AForm.GetCellTextByXID_MISMO(29);
          License.AttributeValues['_State'] := AForm.GetCellTextByXID_MISMO(30);
          if not (length(AForm.GetCellTextByXID_MISMO(30))>0) then
            License.AttributeValues['_State'] := AForm.GetCellTextByXID_MISMO(2099);
          if (AForm.FormID = 794) and ExpireDateExists then
            License := License.ParentElement;
          License.AttributeValues['_ExpirationDate'] := MISMODate(ADoc, AForm.GetCellByXID_MISMO(28), ErrList);
        end;
      if FormCellsHaveText(AForm, [5018]) then  //has unknown Identifier
        begin
          License := Person.AddElement('APPRAISER_LICENSE', ['_Type', 'Other']);
          License.AttributeValues['_TypeOtherDescription'] := AForm.GetCellTextByXID_MISMO(5018);
          License.AttributeValues['_State'] := AForm.GetCellTextByXID_MISMO(2099);
          License.AttributeValues['_ExpirationDate'] := MISMODate(ADoc, AForm.GetCellByXID_MISMO(28), ErrList);
        end;
      if not assigned(License) and FormCellsHaveText(AForm, [2099,28]) then  //only entered exp or date
        begin
          License := Person.AddElement('APPRAISER_LICENSE');
          License.AttributeValues['_State'] := AForm.GetCellTextByXID_MISMO(2099);
          License.AttributeValues['_ExpirationDate'] := MISMODate(ADoc, AForm.GetCellByXID_MISMO(28), ErrList);
        end;

(*
<FIELD ID="1152" XPath="//VALUATION_RESPONSE/PARTIES/SUPERVISOR/INSPECTION[@AppraisalInspectionPropertyType=&dq;Subject&dq;]/.[@AppraisalInspectionType=&dq;None&dq;]"/>
<FIELD ID="1153" XPath="//VALUATION_RESPONSE/PARTIES/SUPERVISOR/INSPECTION[@AppraisalInspectionPropertyType=&dq;Subject&dq;]/.[@AppraisalInspectionType=&dq;ExteriorOnly&dq;]"/>
<FIELD ID="1154" XPath="//VALUATION_RESPONSE/PARTIES/SUPERVISOR/INSPECTION[@AppraisalInspectionPropertyType=&dq;Subject&dq;]/.[@AppraisalInspectionType=&dq;ExteriorAndInterior&dq;]"/>
<FIELD ID="2008" XPath="//VALUATION_RESPONSE/PARTIES/SUPERVISOR/INSPECTION[@AppraisalInspectionPropertyType=&dq;Subject&dq;]/@InspectionDate"/>

<FIELD ID="1155" XPath="//VALUATION_RESPONSE/PARTIES/SUPERVISOR/INSPECTION[@AppraisalInspectionPropertyType=&dq;Comparable&dq;]/.[@AppraisalInspectionType=&dq;None&dq;]"/>
<FIELD ID="1156" XPath="//VALUATION_RESPONSE/PARTIES/SUPERVISOR/INSPECTION[@AppraisalInspectionPropertyType=&dq;Comparable&dq;]/.[@AppraisalInspectionType=&dq;ExteriorOnly&dq;]"/>
<FIELD ID="2100" XPath="//VALUATION_RESPONSE/PARTIES/SUPERVISOR/INSPECTION[@AppraisalInspectionPropertyType=&dq;Comparable&dq;]/@InspectionDate"/>
NOT USED <FIELD ID="1665" XPath="//VALUATION_RESPONSE/PARTIES/SUPERVISOR/INSPECTION/@InspectionDate"/>
*)
       //Supervisor's Date and Type of Subject Inspection
      if FormCellsHaveText(AForm, [1152,1153,1154,2008]) then
        begin
          Inspection := Person.AddElement('INSPECTION', ['AppraisalInspectionPropertyType', 'Subject']);
          if CompareText(AForm.GetCellTextByXID_MISMO(1152), 'X')=0 then
            Inspection.AttributeValues['AppraisalInspectionType'] := 'None';
          InspDateSet := False;
          if CompareText(AForm.GetCellTextByXID_MISMO(1153), 'X')=0 then
            begin
              InspDateSet := True;
            Inspection.AttributeValues['AppraisalInspectionType'] := 'ExteriorOnly';
              // Retrieve the first date with cell XID = 2008
              if length(AForm.GetCellTextByXID_MISMO(2008))> 0 then
                Inspection.AttributeValues['InspectionDate'] := MISMODate(ADoc, AForm.GetCellByXID_MISMO(2008), ErrList);
            end;
          // If the exterior/interior box is checked we need to retrieve the date from the
          //  following cell so it overrides the prior XID 2008 value (ex. Form ID 341).
          if CompareText(AForm.GetCellTextByXID_MISMO(1154), 'X')=0 then
            begin
              InspDateSet := True;
            Inspection.AttributeValues['AppraisalInspectionType'] := 'ExteriorAndInterior';
              ChkBoxUID := AForm.GetCellByXID_MISMO(1154).UID;
              InspDateCell := AForm.GetCell(Succ(ChkBoxUID.Pg), (ChkBoxUID.Num + 2));
              if length(InspDateCell.Text) > 0 then
                Inspection.AttributeValues['InspectionDate'] := MISMODate(ADoc, InspDateCell, ErrList);
            end;
          // If neither the exterior-only or the exterior/interior boxes is checked
          //  we need to retrieve the date from the XID 2008 cell (ex. Form ID 29).
          if (not InspDateSet) and (length(AForm.GetCellTextByXID_MISMO(2008))> 0) then
            Inspection.AttributeValues['InspectionDate'] := MISMODate(ADoc, AForm.GetCellByXID_MISMO(2008), ErrList);
        end;
      //Supervisor's Date and Type of Comparable Inspection
      if FormCellsHaveText(AForm, [1155,1156,2100]) then
        begin
          Inspection := Person.AddElement('INSPECTION', ['AppraisalInspectionPropertyType', 'Comparable']);
          if CompareText(AForm.GetCellTextByXID_MISMO(1155), 'X')=0 then
            Inspection.AttributeValues['AppraisalInspectionType'] := 'None';
          if CompareText(AForm.GetCellTextByXID_MISMO(1156), 'X')=0 then
            Inspection.AttributeValues['AppraisalInspectionType'] := 'ExteriorOnly';
          if length(AForm.GetCellTextByXID_MISMO(2100))> 0 then
            Inspection.AttributeValues['InspectionDate'] := MISMODate(ADoc, AForm.GetCellByXID_MISMO(2100), ErrList);
        end;

      //Supervisor's Signature and Date
      hasSignature := (ADoc.docSignatures.SignatureIndexOf('Supervisor') > -1);
      if hasSignature or (length(AForm.GetCellTextByXID_MISMO(6))>0) then //is there a signature date
        begin
          Signature := Person.AddElement('SIGNATURE');
          Signature.AttributeValues['_Date'] := MISMODate(ADoc, AForm.GetCellByXID_MISMO(6), ErrList);
          Signature.AttributeValues['_AffixedIndicator'] := MISMOBoolean(hasSignature);
        end;
    end;

{--REVIEWER ---------------------------------------------}
//Exported Review Appraiser CellIDs
//1402, 1403,1666,1499,1504,1505,1506,1728,1507,1508,1509
//1510,1511,1512,1513,1514,1517,1518,1520,1521
//1522,1523,1524,1658,1730

  //Is the reviewer's name on this form
  if Length(AForm.GetCellTextByXID_MISMO(1402))>0 then
    begin
      Person :=  Signer.AddElement('REVIEW_APPRAISER');
      Person.AttributeValues['_Name'] := AForm.GetCellTextByXID_MISMO(1402);
      Person.AttributeValues['_CompanyName'] := AForm.GetCellTextByXID_MISMO(1403);
      Person.AttributeValues['_StreetAddress'] := AForm.GetCellTextByXID_MISMO(1666);
      CityStZip := AForm.GetCellTextByXID_MISMO(1499);                                    //Reviewer City, St, Zip
      Person.AttributeValues['_StreetAddress2'] := CityStZip;
      Person.AttributeValues['_City'] := ParseCityStateZip3(CityStZip, 1);        //Reviewer City
      Person.AttributeValues['_State'] := ParseCityStateZip3(CityStZip, 2);       //Reviewer State
      Person.AttributeValues['_PostalCode'] := ParseCityStateZip3(CityStZip, 3);  //Reviewer Zip
      Person.AttributeValues['AppraisalFormsUnparsedAddress'] := AForm.GetCellTextByXID_MISMO(1730);

      if FormCellsHaveText(AForm, [1507,1508,1509]) then
        begin
          Contact := Person.AddElement('CONTACT_DETAIL');

          Phone := AForm.GetCellTextByXID_MISMO(1507);
          if length(phone)> 0 then
            Contact.AddElement('CONTACT_POINT', ['_Type', 'Phone', '_Value', Phone]);

          fax := AForm.GetCellTextByXID_MISMO(1508);
          if length(fax)>0 then
            Contact.AddElement('CONTACT_POINT', ['_Type', 'Fax', '_Value', Fax]);

          email := AForm.GetCellTextByXID_MISMO(1509);
          if length(email)>0 then
            Contact.AddElement('CONTACT_POINT', ['_Type', 'Email', '_Value', email]);
        end;
(*
<FIELD ID="1510" XPath="//VALUATION_RESPONSE/PARTIES/REVIEW_APPRAISER/APPRAISER_LICENSE/@_ExpirationDate"/>
<FIELD ID="1511" XPath="//VALUATION_RESPONSE/PARTIES/REVIEW_APPRAISER/APPRAISER_LICENSE[@_Type=&dq;License&dq;]/@_Identifier"/>
<FIELD ID="1512" XPath="//VALUATION_RESPONSE/PARTIES/REVIEW_APPRAISER/APPRAISER_LICENSE/.[@_Type=&dq;License&dq;]/@_State"/>
<FIELD ID="1513" XPath="//VALUATION_RESPONSE/PARTIES/REVIEW_APPRAISER/APPRAISER_LICENSE[@_Type=&dq;Certificate&dq;]/@_Identifier"/>
<FIELD ID="1514" XPath="//VALUATION_RESPONSE/PARTIES/REVIEW_APPRAISER/APPRAISER_LICENSE/.[@_Type=&dq;Certificate&dq;]/@_State"/>
<FIELD ID="1517" XPath="//VALUATION_RESPONSE/PARTIES/REVIEW_APPRAISER/APPRAISER_LICENSE/@_Identifier"/>
<FIELD ID="1518" XPath="//VALUATION_RESPONSE/PARTIES/REVIEW_APPRAISER/APPRAISER_LICENSE/@_State"/>
<FIELD ID="1520" XPath="//VALUATION_RESPONSE/PARTIES/REVIEW_APPRAISER/APPRAISER_LICENSE[@_Type=&dq;Other&dq;]/@_Identifier"/>
<FIELD ID="1521" XPath="//VALUATION_RESPONSE/PARTIES/REVIEW_APPRAISER/APPRAISER_LICENSE[@_Type=&dq;Other&dq;]/@_TypeOtherDescription"/>
*)
      //Reviewer's License Configurations
      License := nil;
      if FormCellsHaveText(AForm, [1511,1512]) then //has License Identifier
        begin
          License := Person.AddElement('APPRAISER_LICENSE', ['_Type', 'License']);
          License.AttributeValues['_Identifier'] := AForm.GetCellTextByXID_MISMO(1511);
          License.AttributeValues['_State'] := AForm.GetCellTextByXID_MISMO(1512);
          License.AttributeValues['_ExpirationDate'] := MISMODate(ADoc, AForm.GetCellByXID_MISMO(1510), ErrList);
        end;
      if FormCellsHaveText(AForm, [1513,1514]) then  //has Certificate Identifier
        begin
          License := Person.AddElement('APPRAISER_LICENSE', ['_Type', 'Certificate']);
          License.AttributeValues['_Identifier'] := AForm.GetCellTextByXID_MISMO(1513);
          License.AttributeValues['_State'] := AForm.GetCellTextByXID_MISMO(1514);
          License.AttributeValues['_ExpirationDate'] := MISMODate(ADoc, AForm.GetCellByXID_MISMO(1510), ErrList);
        end;
      if FormCellsHaveText(AForm, [1520,1521]) then  //has Other Identifier
        begin
          License := Person.AddElement('APPRAISER_LICENSE', ['_Type', 'Other']);
          License.AttributeValues['_Identifier'] := AForm.GetCellTextByXID_MISMO(1520);
          License.AttributeValues['_TypeOtherDescription'] := AForm.GetCellTextByXID_MISMO(1521);
          License.AttributeValues['_State'] := AForm.GetCellTextByXID_MISMO(1518);
          License.AttributeValues['_ExpirationDate'] := MISMODate(ADoc, AForm.GetCellByXID_MISMO(1510), ErrList);
        end;
      if FormCellsHaveText(AForm, [1517]) then  //has unknown Identifier
        begin
          License := Person.AddElement('APPRAISER_LICENSE');
          License.AttributeValues['_Identifier'] := AForm.GetCellTextByXID_MISMO(1517);
          License.AttributeValues['_State'] := AForm.GetCellTextByXID_MISMO(1518);
          License.AttributeValues['_ExpirationDate'] := MISMODate(ADoc, AForm.GetCellByXID_MISMO(1510), ErrList);
        end;
      if not assigned(License) and FormCellsHaveText(AForm, [1518,1510]) then  //only entered exp and state
        begin
          License := Person.AddElement('APPRAISER_LICENSE');
          License.AttributeValues['_State'] := AForm.GetCellTextByXID_MISMO(1518);
          License.AttributeValues['_ExpirationDate'] := MISMODate(ADoc, AForm.GetCellByXID_MISMO(1510), ErrList);
        end;

(*
<FIELD ID="1522" XPath="//VALUATION_RESPONSE/PARTIES/REVIEW_APPRAISER/INSPECTION[@AppraisalInspectionPropertyType=&dq;Subject&dq;]/.[@AppraisalInspectionType=&dq;None&dq;]"/>
<FIELD ID="1523" XPath="//VALUATION_RESPONSE/PARTIES/REVIEW_APPRAISER/INSPECTION[@AppraisalInspectionPropertyType=&dq;Subject&dq;]/.[@AppraisalInspectionType=&dq;ExteriorOnly&dq;]"/>
<FIELD ID="1524" XPath="//VALUATION_RESPONSE/PARTIES/REVIEW_APPRAISER/INSPECTION[@AppraisalInspectionPropertyType=&dq;Subject&dq;]/.[@AppraisalInspectionType=&dq;ExteriorAndInterior&dq;]"/>
<FIELD ID="1658" XPath="//VALUATION_RESPONSE/PARTIES/REVIEW_APPRAISER/INSPECTION/@InspectionDate"/>
*)
      //Reviewer's Date and Type of Inspection
      if FormCellsHaveText(AForm, [1522,1523,1524,1658]) then
        begin
          Inspection := Person.AddElement('INSPECTION', ['AppraisalInspectionPropertyType', 'Subject']);
          if CompareText(AForm.GetCellTextByXID_MISMO(1522), 'X')=0 then
            Inspection.AttributeValues['AppraisalInspectionType'] := 'None';
          if CompareText(AForm.GetCellTextByXID_MISMO(1523), 'X')=0 then
            Inspection.AttributeValues['AppraisalInspectionType'] := 'ExteriorOnly';
          if CompareText(AForm.GetCellTextByXID_MISMO(1524), 'X')=0 then
            Inspection.AttributeValues['AppraisalInspectionType'] := 'ExteriorAndInterior';
          if length(AForm.GetCellTextByXID_MISMO(1658))> 0 then
            Inspection.AttributeValues['InspectionDate'] := MISMODate(ADoc, AForm.GetCellByXID_MISMO(1658), ErrList);
        end;

      //Reviewer's Signature and Date
      hasSignature := (ADoc.docSignatures.SignatureIndexOf('Reviewer') > -1);
      if hasSignature or (length(AForm.GetCellTextByXID_MISMO(1728))>0) then  //is there a signature date
        begin
          Signature := Person.AddElement('SIGNATURE');
          Signature.AttributeValues['_Date'] := MISMODate(ADoc, AForm.GetCellByXID_MISMO(1728), ErrList);
          Signature.AttributeValues['_AffixedIndicator'] := MISMOBoolean(hasSignature);
        end;
    end;
end;

procedure ExportFormImages(ADoc: TContainer; AForm: TDocForm; AElement: TXMLElement; ErrList: TObjectList);
// Version 7.2.7 JWyatt Revise to output the 1st and/or 2nd text lines associated with
//  a given photo cell. The routine uses association files (ex. A000301.txt) to determine
//  the text cell locations, by sequence number, and then concatenate the lines into the
//  _CaptionComment XML element.
const
  cFormAssocFolder= 'Converters\FormAssociations\';    //where form photo association maps are kept
var
  PageCounter, CellCounter, PhotoCounter : Integer;
  ThisPage: TDocPage;
  ThisCell: TBaseCell;
  formName, otherDesc: String;
  imgID, imgName, imgCaption: String;

  FormAssocFile: TMemIniFile;
  AssocFilePath, FormSection, FormIdent: String;
  AssocFileExists: Boolean;
  Cmnt1Text, Cmnt2Text: String;
  Cmnt1AdjStr, Cmnt2AdjStr: String;
  Cmnt1AdjVal, Cmnt2AdjVal, ErrCode: Integer;

  function ConcatCmnts(C1, C2: String): String;
  begin
   if Trim(C1) <> '' then
     result := Trim(C1) + '/' + Trim(C2)
   else
     result := Trim(C2);
  end;

begin
  FormAssocFile := nil;
  try
    AssocFilePath := IncludeTrailingPathDelimiter(appPref_DirTools) +
        cFormAssocFolder + 'A' + Format('%6.6d', [AForm.FormID]) + '.txt';
    AssocFileExists := FileExists(AssocFilePath);
    if AssocFileExists then
      FormAssocFile := TMemIniFile.Create(AssocFilePath);
    for PageCounter := 0 to AForm.frmPage.Count - 1 do            //for each page
      begin
        PhotoCounter := 1;
        ThisPage := AForm.frmPage[PageCounter];
        if (ThisPage.pgData <> nil) then                             //make sure page has data cells
          begin
            FormSection :=  'Pg' + IntToStr(Succ(PageCounter));
            for CellCounter := 0 to ThisPage.pgData.Count - 1 do
              begin
                ThisCell := ThisPage.pgData[CellCounter];
                if (ThisCell is TGraphicCell) then
                  begin
                    Cmnt1Text := '';
                    Cmnt2Text := '';
                    if Assigned(FormAssocFile) then
                      begin
                        FormIdent := 'Assoc' + IntToStr(PhotoCounter);
                        Cmnt1AdjStr := FormAssocFile.ReadString(FormSection, FormIdent + 'ID1', '');
                        Val(Cmnt1AdjStr, Cmnt1AdjVal, ErrCode);
                        if ErrCode <> 0 then
                          Cmnt1Text := Cmnt1AdjStr
                        else
                          if Cmnt1AdjVal <> 0 then
                            Cmnt1Text := ThisPage.pgData[CellCounter+Cmnt1AdjVal].GetText;
                        Cmnt2AdjStr := FormAssocFile.ReadString(FormSection, FormIdent + 'ID2', '');
                        Val(Cmnt2AdjStr, Cmnt2AdjVal, ErrCode);
                        if ErrCode <> 0 then
                          Cmnt2Text := Cmnt2AdjStr
                        else
                          if Cmnt2AdjVal <> 0 then
                            Cmnt2Text := ThisPage.pgData[CellCounter+Cmnt2AdjVal].GetText;
                      end;
                    formName := GetReportFormType(AForm, otherDesc);
                    imgID := GetImageIdentifier(ThisCell.FCellXID, PhotoCounter, formName);
                    if TGraphicCell(ThisCell).HasImage then
                      imgName := 'HasImage'
                    else
                      imgName := 'NoImage';
                    imgCaption := ConcatCmnts(Cmnt1Text, Cmnt2Text);
                     with AElement.AddElement('IMAGE') do
                       begin
                          AttributeValues['_Identifier'] := imgID;
                          AttributeValues['_Name'] := imgName;
                          AttributeValues['_CaptionComment'] := imgCaption;
                       end;

                     Inc(PhotoCounter);
                  end;
              end;
          end;
      end;
  finally
    FormAssocFile.Free;
  end;
end;

procedure ExportFormAddendumText(AForm: TDocForm; AElement: TXMLElement);
var
  Comment: TXMLElement;
begin
  if length(AForm.GetCellTextByXID_MISMO(1218))>0 then    //there are generic additional comments
    begin
      Comment :=  AElement.AddElement('COMMENT', ['AppraisalAddendumTextIdentifier', 'Additional']);
      Comment.AttributeValues['AppraisalAddendumText'] := AForm.GetCellTextByXID_MISMO(1218);
    end;

  if length(AForm.GetCellTextByXID_MISMO(1293))>0 then    //there are report validation comments
    begin
      Comment :=  AElement.AddElement('COMMENT', ['AppraisalAddendumTextIdentifier', 'Additional']);
      Comment.AttributeValues['AppraisalAddendumText'] := AForm.GetCellTextByXID_MISMO(1293);
    end;

  if length(AForm.GetCellTextByXID_MISMO(2729))>0 then    //there are additional sales history comments
    begin
      Comment :=  AElement.AddElement('COMMENT', ['AppraisalAddendumTextIdentifier', 'History']);
      Comment.AttributeValues['AppraisalAddendumText'] := AForm.GetCellTextByXID_MISMO(2729);
    end;

  if length(AForm.GetCellTextByXID_MISMO(1676))>0 then    //there are additional rental comments
    begin
      Comment :=  AElement.AddElement('COMMENT', ['AppraisalAddendumTextIdentifier', 'Rental']);
      Comment.AttributeValues['AppraisalAddendumText'] := AForm.GetCellTextByXID_MISMO(1676);
    end;
(*
  if length(AForm.GetCellTextByXID_MISMO(1676))>0 then    //there are additional rental comments
    begin
      Comment :=  AElement.AddElement('COMMENT', ['AppraisalAddendumTextIdentifier', 'ComparableTimeAdjustment']);
      Comment.AttributeValues['AppraisalAddendumText'] := AForm.GetCellTextByXID_MISMO(1676);
    end;
*)
end;

// 052611 JWyatt Add the following procedure to export comments from addendums
//  when the version is 2.6 or 2.6GSE. This is similar to the procedure above
//  except the AppraisalAddendumText is not part of element COMMENT
procedure ExportFormAddendumText_2_6(AForm: TDocForm; AElement: TXMLElement);
begin
  if length(AForm.GetCellTextByXID_MISMO(1218))>0 then    //there are generic additional comments
    AElement.AttributeValues['AppraisalAddendumText'] := AForm.GetCellTextByXID_MISMO(1218);

  if length(AForm.GetCellTextByXID_MISMO(1293))>0 then    //there are report validation comments
    AElement.AttributeValues['AppraisalAddendumText'] := AForm.GetCellTextByXID_MISMO(1293);

  if length(AForm.GetCellTextByXID_MISMO(2729))>0 then    //there are additional sales history comments
    AElement.AttributeValues['AppraisalAddendumText'] := AForm.GetCellTextByXID_MISMO(2729);

  if length(AForm.GetCellTextByXID_MISMO(1676))>0 then    //there are additional rental comments
    AElement.AttributeValues['AppraisalAddendumText'] := AForm.GetCellTextByXID_MISMO(1676);
end;

procedure ExportReportFormList(doc: TContainer; ATranslator: TMISMOTranslator;
  ExportList: BooleanArray; ErrList: TObjectList; var Frm1004MCSeqID: Integer;
  IsVer2_6: Boolean; Info: TMiscInfo);
var
  f,SeqNo, formUID, PriFormCntr, PriFormUID: Integer;
  ThisForm: TDocForm;
  FormType, OtherDesc, FormXPath: String;
  FormIdentifier: String;
  IsPrimary, IsPriUCDPForm, PDFIsEmbedded, SetMISMOType: Boolean;
  SetAppraisalFormType: Boolean;
  ThisElement: TXMLElement;
  FormTypeCounter: TStringList;
  // The following variable is added to capture the type in case it needs
  //  to be adjusted for UAD compliant reports.
  MISMOType, MISMOTypeVersionID: String;
  FormName: String;

  //is this form on the list to be exported?
  function ExportThisForm(n: Integer; ExpFormList: BooleanArray): Boolean;
  begin
    if not assigned(ExpFormList) then
      result := True
    else
      result := ExpFormList[n];
  end;

begin
  //setup the generic form counter
  FormTypeCounter := TStringList.create;
  FormTypeCounter.Duplicates := dupIgnore;
  Frm1004MCSeqID := -1;
  SetAppraisalFormType := False;

  try
    // The following sequence looks for a generic primary form ID and checks
    //  to see if we have a UCDP primary form. If the latter then this is the
    //  form we will use as the primary instead of the generic.
    IsPriUCDPForm := False;
    PriFormUID := 0;
    PriFormCntr := -1;
    repeat
      PriFormCntr := Succ(PriFormCntr);
      if ExportThisForm(PriFormCntr, ExportList) then     //form can be unselected
      begin
        ThisForm := doc.docForm[PriFormCntr];
        formUID := ThisForm.frmInfo.fFormUID;
        if IsPrimaryAppraisalForm(formUID) then
          PriFormUID := formUID;
        if IsVer2_6 then
          if Is2_6PrimaryAppraisalForm(formUID) then
            begin
              PriFormUID := formUID;
              IsPriUCDPForm := True;
            end;
      end;
    until IsPriUCDPForm or (PriFormCntr = (doc.docForm.count - 1));

    SeqNo := 1;
    IsPrimary := False;
    PDFIsEmbedded := False;
    if assigned(doc) then
      if ATranslator.FindMapping(FORM_ID, FormXPath) then           //gets XPath for REPORT/FORM
        for f := 0 to doc.docForm.count-1 do
          if ExportThisForm(f, ExportList) then
            begin
              ThisForm := doc.docForm[f];
              formUID := ThisForm.frmInfo.fFormUID;

              ThisElement := ATranslator.XML.AddElement(FormXPath); //REPORT/FORM
              ThisElement.AttributeValues['AppraisalReportContentSequenceIdentifier'] := IntToStr(SeqNo);

              //classify the form
              if IsVer2_6 then
                FormType := Get2_6ReportFormType(ThisForm, OtherDesc)
              else
                FormType := GetReportFormType(ThisForm, OtherDesc);
              ThisElement.AttributeValues['AppraisalReportContentType'] := FormType;
              if FormType = 'Other' then
                ThisElement.AttributeValues['AppraisalReportContentTypeOtherDescription'] := OtherDesc;

              FormName := GetReportFormName(ThisForm);   //playing with fire here. The formID should set the MISMO name - not Sheri!
              //FreddieMac requested specific AppraisalReportContentName what is not suit for form name displaying in UI
              if ThisForm.frmInfo.fFormUID = 4365 then  //FMAC H70 form
                formName := 'PropertyDataCollectionPlusDesktopReview';
              ThisElement.AttributeValues['AppraisalReportContentName'] := FormName;
              if FormName = 'FNMA 1004MC' then
                Frm1004MCSeqID := SeqNo;
 {  move it to main forms handling
//change this to a call to pull back the right enumerated name
              if pos('1004P', trim(FormName)) > 0 then //PAM: force 1004P to use 1004 mismo type
                FormName:= StringReplace(FormName, '1004P', '1004', [rfReplaceAll]);            //to handle main form and cert form   }
              MISMOType := FormName;
              if IsVer2_6 and not SetAppraisalFormType then
                begin
                  SetMISMOType := False;
                  case FormUID of
                    3:
                      begin
                        MISMOType:= 'FNM1004B';
                        SetMISMOType := True;
                      end;
                    9:
                      begin
                        MISMOType:= 'VacantLand';
                        SetMISMOType := True;
                      end;
                    11,279:
                      begin
                        MISMOType:= 'MobileHome';
                        SetMISMOType := True;
                      end;
                    39,41,340,342,344,345,347,349,351,353,355,357,360, 4218, 4365:   //4218 added 1004P, 4365 added 1004 2019
                      begin
                        if (FormUID = 4218) or (FormUID = 4365) then // The forms 1004P and FMAC H70 still 1004 as MISMO report type
                          MISMOType := 'FNM 1004';
                        MISMOType:= StringReplace(MISMOType, ' ', '', [rfReplaceAll]);            //remove spaces
                        MISMOType:= StringReplace(MISMOType, 'FNMA', 'FNM', [rfReplaceAll]);      //abbreviate
                        MISMOType:= StringReplace(MISMOType, 'Certification', '', [rfReplaceAll]);//remove Cert
                        SetMISMOType := True;
                        case FormUID of  //need mismo type version to distinguish from regular 1004
                          4218:
                            MISMOTypeVersionID := '2017';
                          4365:
                            MISMOTypeVersionID := '2019';
                        end;
                      end;
                    43:
                      begin
                        MISMOType:= StringReplace(MISMOType, ' ', '', [rfReplaceAll]);
                        MISMOType:= StringReplace(MISMOType, 'FMAC', 'FRE', [rfReplaceAll]);
                        MISMOType:= StringReplace(MISMOType, 'Certification', '', [rfReplaceAll]);
                        SetMISMOType := True;
                      end;
                    87:
                      begin
                        MISMOType:= 'ERC2001';
                        SetMISMOType := True;
                      end;
                    95:
                      begin
                        MISMOType:= 'ERC2003';
                        SetMISMOType := True;
                      end;
                  end;
                  if SetMISMOType then
                    begin
                      ATranslator.ExportValue(10500, MISMOType);   //attribute AppraisalFormType, see AppraisalMap2.6.xml
                      SetAppraisalFormType := True;
                      if length(MISMOTypeVersionID) > 0 then
                        ATranslator.ExportValue(10501,MISMOTypeVersionID);  //attribute  AppraisalFormVersionIdentifier, see AppraisalMap2.6.xml
                    end;
                end;

              //Set Industry Standard Identifier
              FormIdentifier := GetIndustryFormIdentifier(FormType, formUID, FormTypeCounter, doc.UADEnabled);
              ThisElement.AttributeValues['AppraisalReportContentIdentifier'] := FormIdentifier;

              //Set the IsPrimaryForm Indicator
              if not IsPrimary then  //if primary has not been found...
                begin
                  IsPrimary := (formUID = PriFormUID);
                  if IsPrimary then
                    ThisElement.AttributeValues['AppraisalReportContentIsPrimaryFormIndicator'] := 'Y'
                  else
                    ThisElement.AttributeValues['AppraisalReportContentIsPrimaryFormIndicator'] := 'N';
                end
              else //primary has been located, all other forms are not primary
                ThisElement.AttributeValues['AppraisalReportContentIsPrimaryFormIndicator'] := 'N';

              // This attribute is in case we have additional descriptive data - we do not
              {ThisElement.AttributeValues['AppraisalReportContentDescription'] := ThisForm.frmInfo.fFormKindName;}

              // 052611 JWyatt Add the call to export comments from addendums
              //  when the version is 2.6 or 2.6GSE.
              if IsVer2_6 then
                begin
                  // 060611 JWyatt If this is not the UAD comment form then
                  //  export text on the form. If it is the UAD comment form
                  //  then we don't export here, the comments are saved in the
                  //  DataPoints and exported along with other DataPoint values.
                  if (not doc.UADEnabled) or (ThisForm.FormID <> CUADCommentAddendum) then
                    ExportFormAddendumText_2_6(ThisForm, ThisElement);
                end    
              else
                begin
                  //Export "Additional" Comment Text on the Form
                  ExportFormAddendumText(ThisForm, ThisElement);
                  // If we're not processing a 2.6-compatible report then export
                  //  any signature, date, inspection, license cells for appraiser,
                  //  supervisor and/or reviewer
                  ExportFormSigners(doc, ThisForm, ThisElement, ErrList);    //"ThisElement" is the FORM element for ThisForm
                end;

              ExportFormImages(doc, ThisForm, ThisElement, ErrList);    //Export IMAGE element if has image cell

              //Whis this called here?
              //Was it becuase at onetime the PDF was put into the form?
              //Its now in the Report - right, so this code can go away.
              if IsVer2_6 and (not doc.UADEnabled) and IsPrimary and (not PDFIsEmbedded) then
                begin
                  ExportReportEmbededPDF(doc, ATranslator, Info, ThisElement);
                  PDFIsEmbedded := True;
                end;

              inc(SeqNo);
            end;
  finally
    FormTypeCounter.Free;
  end;
end;

procedure ExportReportPartiesParsedAddess(doc: TContainer; exportForm: BooleanArray; ATranslator: TMISMOTranslator);
begin
  //Lender
  ATranslator.ExportValue(37, doc.GetCellTextByXID_MISMO(37, exportForm));       //Lender Address
  ATranslator.ExportValue(38, doc.GetCellTextByXID_MISMO(38, exportForm));       //Lender City
  ATranslator.ExportValue(39, doc.GetCellTextByXID_MISMO(39, exportForm));       //Lender State
  ATranslator.ExportValue(40, doc.GetCellTextByXID_MISMO(40, exportForm));       //Lender Zip
end;

//this is special routine for extracting the Sales Concession Amt form the Sales Concession Comment text
//Clickforms does not have a specific cell for the Amt, others do, so we have special extraction code to get it
procedure ExportSalesContractConsessions(doc: TContainer; exportForm: BooleanArray;
  ATranslator: TMISMOTranslator; IsVer2_6: Boolean);
var
  Counter: Integer;
  SalesComissionText: String;
  SalesComissionAmt: String;
begin
  SalesComissionAmt := '';
  SalesComissionText := doc.GetCellTextByXID_MISMO(2057, exportForm);               //get description
  SalesComissionAmt := GetFirstNumInStr(SalesComissionText, False, Counter);  //parse and get first value
  if (not IsVer2_6) and (Length(SalesComissionAmt) > 0) then  //###JB - is this correct??
    ATranslator.ExportValue(2642, SalesComissionAmt);
end;

procedure ExportMergedCells(doc: TContainer; CellMainXID: Integer;
  ExportList: BooleanArray; ATranslator: TMISMOTranslator; const ListXIDs: array of Integer);
var
  FormNum, XIDCount, XIDNum: Integer;
  ConcatText: String;
  ThisForm: TDocForm;
  CellTxt: TBaseCell;

  //is this form on the list to be exported?
  function ExportThisForm(n: Integer; ExpFormList: BooleanArray): Boolean;
  begin
    if not assigned(ExpFormList) then
      result := True
    else
      result := ExpFormList[n];
  end;

begin
  ConcatText := '';
  XIDCount := Length(ListXIDs);
  if assigned(doc) and (XIDCount > 0) then
    for FormNum := 0 to doc.docForm.count-1 do
      if ExportThisForm(FormNum, ExportList) then
        begin
          ThisForm := doc.docForm[FormNum];
          for XIDNum := 0 to Pred(XIDCount) do
            begin
              CellTxt := ThisForm.GetCellByXID_MISMO(ListXIDs[XIDNum]);
              if CellTxt <> nil then
                begin
                  if Trim(CellTxt.Text) <> '' then
                    if CellTxt.FCellXID = CellMainXID then
                      ConcatText := Trim(CellTxt.Text) + ConcatText
                    else
                      ConcatText := ConcatText  + ' ' + Trim(CellTxt.Text);
                end
            end;
        end;
  if Trim(ConcatText) <> '' then
    ATranslator.ExportValue(CellMainXID, ConcatText);                //Lender Address
end;

procedure ExportTableCells(AContainer: TContainer; ATableType: Integer; ErrList: TObjectList;
  ATranslator: TMISMOTranslator; IsUAD: Boolean; IsVer2_6: Boolean; var ListCompOffset: Integer;
  NonUADXMLData: Boolean; LocType: Integer=0);
// Version 7.2.8 083110 JWyatt The FormAssocFile and related variables and code are included
//  to address unique XML addresses assigned to form ID 794. This was discussed in a meeting
//  today and it was agreed that this code should be revised to use only XML IDs in a future
//  release.
const
  cFormAssocFolder = 'Converters\FormAssociations\';    //where form photo association maps are kept
  MaxAdjID = 7;
  MaxRentID = 4;
  StdAdjID: array[1..MaxAdjID] of Integer = (947,954,1052,1053,1054,1682,1683);
  RentalAdjID: array[1..MaxAdjID] of Integer = (1299,1259,1256,1257,1258,1264,1265);
  RentalBathID: array[1..MaxRentID] of Integer = (2258,2259,2260,2261);
  RentalGLAID: array[1..MaxRentID] of Integer = (2262,2263,2264,2265);
var
  SubColumnCounter, RowCounter, ColCounter, ColIdx, Cntr : Integer;
  ThisGridManager : TGridMgr;
  ThisCell: TBaseCell;
  ThisCellNo, OrigCellXID : Integer;
  ThisCellText : string;
  ThisColumn : TCompColumn;
  Err: TComplianceError;
  NetAdjValue: Double;
  NetPct, GrossPct: String;
  AdjIDs: array[1..7] of Integer;
  AdjIDCount, FormIDHldr, TmpAdjID: Integer;
  FormAssocFile: TMemIniFile;
  AssocFilePath, FormSection: String;
  ListAsSale: Boolean;
  MapCellLocaterEvent: TMapCellLocaterEvent;
  CompIsExported: Boolean;
  RentBathQty, RentGLA: Double;
  ThisForm: TdocForm;
  AltCell: TBaseCell;
  AltUID: CellUID;
  AltPg, AltCellXID: Integer;

  function ConcatNextCell(CurCell, NextCell: TBaseCell): String;
  begin
    if NextCell = nil then
      Result := CurCell.Text
    else
      if Trim(CurCell.Text) = '' then
        Result := NextCell.Text
      else
        Result := Trim(CurCell.Text) + ' ' + Trim(NextCell.Text);
  end;

begin
  ListAsSale := False;
  FormIDHldr := 0;
  ThisGridManager := TGridMgr.Create;
  try
    // Set the std adjustment cell IDs in case the SalesAdjMap.txt file does not exist
    for AdjIDCount := 1 to MaxAdjID do
      if ATableType = ttRentals then
        AdjIDs[AdjIDCount] := RentalAdjID[AdjIDCount]
      else
        AdjIDs[AdjIDCount] := StdAdjID[AdjIDCount];

    ThisGridManager.BuildGrid(AContainer, ATableType);

    for ColCounter := 0 to ThisGridManager.Count - 1 do     //  ThisGridManager is a TObjectList of TCompColumns
      begin
        ThisColumn := ThisGridManager.Comp[ColCounter];
        if assigned(ThisColumn) then
          begin
            // The following code checks the current form ID, checks for the
            //  sales adjustment map file and resets the adjustment IDs if
            //  necessary. Currently, only the 794 and 834 forms require
            //  special adjustments (see 8/31/10 note above).
            if (FormIDHldr = 0) or (FormIDHldr <> ThisColumn.FCX.FormID) then
              begin
                FormIDHldr := ThisColumn.FCX.FormID;
                FormAssocFile := nil;
                ListAsSale := False;
                try
                  AssocFilePath := IncludeTrailingPathDelimiter(appPref_DirTools) +
                      cFormAssocFolder + 'SalesAdjMap.txt';
                  if FileExists(AssocFilePath) then
                    begin
                      FormAssocFile := TMemIniFile.Create(AssocFilePath);
                      FormSection := 'Form' + Format('%6.6d', [ThisColumn.FCX.FormID]);
                      for AdjIDCount := 1 to MaxAdjID do
                        begin
                          TmpAdjID := FormAssocFile.ReadInteger(FormSection, 'ID' + IntToStr(AdjIDCount), 0);
                          if TmpAdjID > 0 then
                            AdjIDs[AdjIDCount] := TmpAdjID;
                        end;
                      ListAsSale := FormAssocFile.ReadBool(FormSection, 'ListAsSale', False);
                    end;
                finally
                  FormAssocFile.Free;
                end;
              end;

            if ListAsSale and (ColCounter <> 0) then
              ColIdx := ColCounter + ListCompOffset
            else
              ColIdx := ColCounter;

            CompIsExported := False;
            for RowCounter := 0 to ThisColumn.RowCount - 1 do
              begin
                for SubColumnCounter := 0 to 1 do
                  begin
                    ThisCellText := '';
                    ThisCellNo := ThisColumn.GetCellNumber(Point(SubColumnCounter,RowCounter));
                    ThisCell := ThisColumn.GetCellByCoord(Point(SubColumnCounter,RowCounter));

                    if Assigned(ThisCell) then
                      try
                        OrigCellXID := ThisCell.FCellXID;
                        if IsVer2_6 then
                          case ThisCell.FCellXID of
                            // Following cell XID have no corresponding path in the
                            //  2.6 schema so are skipped for now.
                            937..939, 1302, 1400, 1401, 1670, 1671:
                              Continue;
                            // Special mapping for non-UAD 'Other' subject adjustment descriptions
                            //  to match schema and Appendix B specification
                            1020:
                              if (not IsUAD) and (ColCounter = 0) and (ATableType = ttSales) then
                                ThisCell.FCellXID := 4077;
                            1022:
                              if (not IsUAD) and (ColCounter = 0) and (ATableType = ttSales) then
                                ThisCell.FCellXID := 4079;
                            1032:
                              if (not IsUAD) and (ColCounter = 0) and (ATableType = ttSales) then
                                ThisCell.FCellXID := 4081;
                            // concatenate with next cell (XID 1302 - Form 29)
                            1303:
                              begin
                                ThisCellText := ThisCell.Text;
                                ThisCell.Text := ConcatNextCell(ThisCell, ThisColumn.GetCellByCoord(Point(SubColumnCounter,Succ(RowCounter))));
                              end;
                            //Handle hidden cells with prior sales grid on a different page (1025, 1073, etc.).
                            // It is possible for the visible data to be different than the hidden data. We need
                            // to make sure we export the visible data - otherwise the XML & PDF will not match.
                            934, 935, 936, 2074:
                              begin
                                if (ColCounter < 4) and (ThisCell.FLocalCTxID > 0) then
                                  begin
                                    case ThisCell.FCellXID of
                                      934: AltCellXID := 9001;
                                      935: AltCellXID := 9002;
                                      936: AltCellXID := 9003;
                                      2074: AltCellXID := 9004;
                                    end;
                                    ThisForm := AContainer.docForm[ThisCell.UID.Form];
                                    for AltPg := 0 to Pred(ThisForm.frmPage.Count) do
                                      begin
                                        AltCell := ThisForm.frmPage[AltPg].GetCellByXID(AltCellXID);
                                        if AltCell <> nil then
                                          begin
                                            AltUID := AltCell.UID;
                                            AltUID.Num := AltUID.Num + (ColCounter * 4);
                                            AltCell := ThisForm.GetCell(Succ(AltUID.Pg), Succ(AltUID.Num));
                                            if AltCell = nil then
                                              Continue
                                            else
                                              ThisCell.Text := AltCell.Text;
                                          end;
                                      end;
                                  end;
                              end;
                          end;

                        case LocType of
                          1: MapCellLocaterEvent := MapXPathLocater;
                          2: MapCellLocaterEvent := MapEmbeddedLocater;
                        else
                          MapCellLocaterEvent := nil;
                        end;

                        if IsUAD then
                          begin
                            if not CompIsExported then
                              CompIsExported := (Trim(ThisCell.Text) <> '');
                            ExportGSEData(ThisCell, ATranslator, nil, MapCellLocaterEvent, ColIdx);
                            ExportCell(False, ThisCell, ATranslator, MapCellLocaterEvent, ColIdx);
                          end
                        else if (ThisCell.FCellXID > 0) then
                          begin
                            if not CompIsExported then
                              CompIsExported := (Trim(ThisCell.Text) <> '');
                            ExportCell(IsUAD, ThisCell, ATranslator, MapCellLocaterEvent, ColIdx);
                          end;
                        // restore any original text contents due to concatenating
                        if ThisCellText <> '' then
                          ThisCell.Text := ThisCellText;
                        ThisCell.FCellXID := OrigCellXID;
                      except
                        on E: Exception do
                          begin
                            if assigned(ErrList) then
                              begin
                                Err := TComplianceError.Create;
                                Err.FCX.FormID := 0;                        //don't search by FormID
                                Err.FCX.Form := ThisColumn.CellCX.Form;     //search by form index
                                Err.FCX.Occur := 0;                         //don't search by occurance
                                Err.FCX.Pg := ThisColumn.CellCX.Pg;         //search by page
                                Err.FCX.Num := ThisCellNo - 1;              //search by cell sequence (zero based)
                                Err.FMsg := E.Message;

                                ErrList.Add(Err);
                              end;
                            ThisCell.FCellXID := OrigCellXID;
                          end;
                      end;
                  end;
              end;

            //For tables get the last items in the column; only do the comps, not subject column.
            if ((ATableType = ttSales) or (ATableType = ttRentals) or ((ATableType = ttListings) and ListAsSale) or ((ATableType = ttListings) and (ThisColumn.FCX.FormID = 794))) and
               (ColCounter > 0) and CompIsExported then
              begin
                if ThisColumn.HasAdjSalesPriceCell and ThisColumn.HasNetAdjustmentCell then
                  begin
                    //set the comp adjusted price
                    ATranslator.ExportValue(AdjIDs[2],'',IntToStr(ColIdx),ThisColumn.AdjSalePrice);

                    //get the net adjustment for the comp
                    NetAdjValue := GetValidNumber(ThisColumn.NetAdjustment);
                    ATranslator.ExportValue(AdjIDs[3],'',IntToStr(ColIdx), NetAdjValue);
                    //set if its a postive or negative adjustent
                    if NetAdjValue >= 0 then
                      ATranslator.ExportValue(AdjIDs[4],'',IntToStr(ColIdx), 'Y')
                    else
                      ATranslator.ExportValue(AdjIDs[5],'',IntToStr(ColIdx), 'N');

                    // add in the net and gross values
                    ThisColumn.GetNetAndGrossAdjPercent(NetPct, GrossPct, AdjIDs[1]);
                    ATranslator.ExportValue(AdjIDs[6],'',IntToStr(ColIdx), NetPct);      //net percent for comp
                    ATranslator.ExportValue(AdjIDs[7],'',IntToStr(ColIdx), GrossPct);    //gross percent for comp
                  end;
              end;
            //For rental tables get/set the subject's GLA and Bathroom counts from the column;
            if (ColCounter = 0) and (ATableType = ttRentals) and CompIsExported then
              begin
                ThisCell := ThisColumn.GetCellByID(RentalBathID[1]);
                if ThisCell <> nil then
                  begin
                    RentBathQty := GetValidNumber(ThisCell.Text);
                    for Cntr := 2 to MaxRentID do
                      begin
                        ThisCell := ThisColumn.GetCellByID(RentalBathID[Cntr]);
                        if ThisCell <> nil then
                          RentBathQty := RentBathQty + GetValidNumber(ThisCell.Text);
                      end;
                    ATranslator.ExportValue(231,'',IntToStr(ColIdx), RentBathQty);
                  end;
                ThisCell := ThisColumn.GetCellByID(RentalGLAID[1]);
                if ThisCell <> nil then
                  begin
                    RentGLA := GetValidNumber(ThisCell.Text);
                    for Cntr := 2 to MaxRentID do
                      begin
                        ThisCell := ThisColumn.GetCellByID(RentalGLAID[Cntr]);
                        if ThisCell <> nil then
                          RentGLA := RentGLA + GetValidNumber(ThisCell.Text);
                      end;
                    ATranslator.ExportValue(232,'',IntToStr(ColIdx), RentGLA);
                  end;
              end;
          end;
      end;
  finally
    ListCompOffset := ListCompOffset + Pred(ThisGridManager.Count);
    ThisGridManager.Free;
  end;
end;


procedure ExportTableCells2(ExpFormList: BooleanArray; AContainer: TContainer; ATableType: Integer; ErrList: TObjectList;
  ATranslator: TMISMOTranslator; IsUAD: Boolean; IsVer2_6: Boolean; var ListCompOffset: Integer;
  NonUADXMLData: Boolean; LocType: Integer=0);
// Version 7.2.8 083110 JWyatt The FormAssocFile and related variables and code are included
//  to address unique XML addresses assigned to form ID 794. This was discussed in a meeting
//  today and it was agreed that this code should be revised to use only XML IDs in a future
//  release.
const
  cFormAssocFolder = 'Converters\FormAssociations\';    //where form photo association maps are kept
  MaxAdjID = 7;
  MaxRentID = 4;
  StdAdjID: array[1..MaxAdjID] of Integer = (947,954,1052,1053,1054,1682,1683);
  RentalAdjID: array[1..MaxAdjID] of Integer = (1299,1259,1256,1257,1258,1264,1265);
  RentalBathID: array[1..MaxRentID] of Integer = (2258,2259,2260,2261);
  RentalGLAID: array[1..MaxRentID] of Integer = (2262,2263,2264,2265);
var
  SubColumnCounter, RowCounter, ColCounter, ColIdx, Cntr : Integer;
  ThisGridManager : TGridMgr;
  ThisCell: TBaseCell;
  ThisCellNo, OrigCellXID : Integer;
  ThisCellText : string;
  ThisColumn : TCompColumn;
  Err: TComplianceError;
  NetAdjValue: Double;
  NetPct, GrossPct: String;
  AdjIDs: array[1..7] of Integer;
  AdjIDCount, FormIDHldr, TmpAdjID: Integer;
  FormAssocFile: TMemIniFile;
  AssocFilePath, FormSection: String;
  ListAsSale: Boolean;
  MapCellLocaterEvent: TMapCellLocaterEvent;
  CompIsExported: Boolean;
  RentBathQty, RentGLA: Double;
  ThisForm: TdocForm;
  AltCell: TBaseCell;
  AltUID: CellUID;
  AltPg, AltCellXID: Integer;
  formIDList:TStringList;
  aFormID: String;

  function ConcatNextCell(CurCell, NextCell: TBaseCell): String;
  begin
    if NextCell = nil then
      Result := CurCell.Text
    else
      if Trim(CurCell.Text) = '' then
        Result := NextCell.Text
      else
        Result := Trim(CurCell.Text) + ' ' + Trim(NextCell.Text);
  end;

  function GetFormIDList(ExpFormList: BooleanArray):String;
  var
    f: Integer;
    include:Boolean;
    aString: String;
  begin
    result := '';
    for f := 0 to AContainer.docForm.count-1 do
    begin
      if not assigned(ExpFormList) then
        include := True
      else
        include := ExpFormList[f];

      if include then
        begin
          aString := Format('%d',[AContainer.docForm[f].frmInfo.fFormUID]);
          result := result + ',' + aString;
        end;
    end;
  end;


begin
  ListAsSale := False;
  FormIDHldr := 0;
  ThisGridManager := TGridMgr.Create;
  FormIDList := TStringList.Create;
  try
    // Set the std adjustment cell IDs in case the SalesAdjMap.txt file does not exist
    for AdjIDCount := 1 to MaxAdjID do
      if ATableType = ttRentals then
        AdjIDs[AdjIDCount] := RentalAdjID[AdjIDCount]
      else
        AdjIDs[AdjIDCount] := StdAdjID[AdjIDCount];

//    ThisGridManager.BuildGrid(AContainer, ATableType);
    ThisGridManager.BuildGrid2(AContainer, ATableType,ExpFormList);
    FormIDList.CommaText := GetFormIDList(ExpFormList);
    for ColCounter := 0 to ThisGridManager.Count - 1 do     //  ThisGridManager is a TObjectList of TCompColumns
      begin
        ThisColumn := ThisGridManager.Comp[ColCounter];
        if assigned(ThisColumn) then
          begin
            // The following code checks the current form ID, checks for the
            //  sales adjustment map file and resets the adjustment IDs if
            //  necessary. Currently, only the 794 and 834 forms require
            //  special adjustments (see 8/31/10 note above).
            aFormID := Format('%d',[ThisColumn.FCX.FormID]);
            if (FormIDHldr = 0) or (FormIDHldr <> ThisColumn.FCX.FormID) and (FormIDList.IndexOf(aFormID) <> -1) then
              begin
                FormIDHldr := ThisColumn.FCX.FormID;
                FormAssocFile := nil;
                ListAsSale := False;
                try
                  AssocFilePath := IncludeTrailingPathDelimiter(appPref_DirTools) +
                      cFormAssocFolder + 'SalesAdjMap.txt';
                  if FileExists(AssocFilePath) then
                    begin
                      FormAssocFile := TMemIniFile.Create(AssocFilePath);
                      FormSection := 'Form' + Format('%6.6d', [ThisColumn.FCX.FormID]);
                      for AdjIDCount := 1 to MaxAdjID do
                        begin
                          TmpAdjID := FormAssocFile.ReadInteger(FormSection, 'ID' + IntToStr(AdjIDCount), 0);
                          if TmpAdjID > 0 then
                            AdjIDs[AdjIDCount] := TmpAdjID;
                        end;
                      ListAsSale := FormAssocFile.ReadBool(FormSection, 'ListAsSale', False);
                    end;
                finally
                  FormAssocFile.Free;
                end;
              end;

            if ListAsSale and (ColCounter <> 0) then
              ColIdx := ColCounter + ListCompOffset
            else
              ColIdx := ColCounter;

            CompIsExported := False;
            for RowCounter := 0 to ThisColumn.RowCount - 1 do
              begin
                for SubColumnCounter := 0 to 1 do
                  begin
                    ThisCellText := '';
                    ThisCellNo := ThisColumn.GetCellNumber(Point(SubColumnCounter,RowCounter));
                    ThisCell := ThisColumn.GetCellByCoord(Point(SubColumnCounter,RowCounter));

                    if Assigned(ThisCell) then
                      try
                        OrigCellXID := ThisCell.FCellXID;
                        if IsVer2_6 then
                          case ThisCell.FCellXID of
                            //do not allow sublect listing price and price per GLA from Extra listing for
                            //1004, 1073, 1075, 2055 (form IDS: 3545, 888, 888, 3545)
                            //overwrite subject price from comparable grid
                            947, 953:
                              if (ATableType = ttListings) and (colCounter = 0) and
                                  ((ThisColumn.FCX.FormID = 3545) or (ThisColumn.FCX.FormID = 888)) then
                                continue;
                            // Following cell XID have no corresponding path in the
                            //  2.6 schema so are skipped for now.
                            937..939, 1302, 1400, 1401, 1670, 1671:
                              Continue;
                            // Special mapping for non-UAD 'Other' subject adjustment descriptions
                            //  to match schema and Appendix B specification
                            1020:
                              if (not IsUAD) and (ColCounter = 0) and (ATableType = ttSales) then
                                ThisCell.FCellXID := 4077;
                            1022:
                              if (not IsUAD) and (ColCounter = 0) and (ATableType = ttSales) then
                                ThisCell.FCellXID := 4079;
                            1032:
                              if (not IsUAD) and (ColCounter = 0) and (ATableType = ttSales) then
                                ThisCell.FCellXID := 4081;
                            // concatenate with next cell (XID 1302 - Form 29)
                            1303:
                              begin
                                ThisCellText := ThisCell.Text;
                                ThisCell.Text := ConcatNextCell(ThisCell, ThisColumn.GetCellByCoord(Point(SubColumnCounter,Succ(RowCounter))));
                              end;
                            //Handle hidden cells with prior sales grid on a different page (1025, 1073, etc.).
                            // It is possible for the visible data to be different than the hidden data. We need
                            // to make sure we export the visible data - otherwise the XML & PDF will not match.
                            934, 935, 936, 2074:
                              begin
                                if (ColCounter < 4) and (ThisCell.FLocalCTxID > 0) then
                                  begin
                                    case ThisCell.FCellXID of
                                      934: AltCellXID := 9001;
                                      935: AltCellXID := 9002;
                                      936: AltCellXID := 9003;
                                      2074: AltCellXID := 9004;
                                    end;
                                    ThisForm := AContainer.docForm[ThisCell.UID.Form];
                                    for AltPg := 0 to Pred(ThisForm.frmPage.Count) do
                                      begin
                                        AltCell := ThisForm.frmPage[AltPg].GetCellByXID(AltCellXID);
                                        if AltCell <> nil then
                                          begin
                                            AltUID := AltCell.UID;
                                            AltUID.Num := AltUID.Num + (ColCounter * 4);
                                            AltCell := ThisForm.GetCell(Succ(AltUID.Pg), Succ(AltUID.Num));
                                            if AltCell = nil then
                                              Continue
                                            else
                                              ThisCell.Text := AltCell.Text;
                                          end;
                                      end;
                                  end;
                              end;
                          end;

                        case LocType of
                          1: MapCellLocaterEvent := MapXPathLocater;
                          2: MapCellLocaterEvent := MapEmbeddedLocater;
                        else
                          MapCellLocaterEvent := nil;
                        end;

                        if IsUAD then
                          begin
                            if not CompIsExported then
                              CompIsExported := (Trim(ThisCell.Text) <> '');
                            ExportGSEData(ThisCell, ATranslator, nil, MapCellLocaterEvent, ColIdx);
                            ExportCell(False, ThisCell, ATranslator, MapCellLocaterEvent, ColIdx);
                          end
                        else if (ThisCell.FCellXID > 0) then
                          begin
                            if not CompIsExported then
                              CompIsExported := (Trim(ThisCell.Text) <> '');
                            ExportCell(IsUAD, ThisCell, ATranslator, MapCellLocaterEvent, ColIdx);
                          end;
                        // restore any original text contents due to concatenating
                        if ThisCellText <> '' then
                          ThisCell.Text := ThisCellText;
                        ThisCell.FCellXID := OrigCellXID;
                      except
                        on E: Exception do
                          begin
                            if assigned(ErrList) then
                              begin
                                Err := TComplianceError.Create;
                                Err.FCX.FormID := 0;                        //don't search by FormID
                                Err.FCX.Form := ThisColumn.CellCX.Form;     //search by form index
                                Err.FCX.Occur := 0;                         //don't search by occurance
                                Err.FCX.Pg := ThisColumn.CellCX.Pg;         //search by page
                                Err.FCX.Num := ThisCellNo - 1;              //search by cell sequence (zero based)
                                Err.FMsg := E.Message;

                                ErrList.Add(Err);
                              end;
                            ThisCell.FCellXID := OrigCellXID;
                          end;
                      end;
                  end;
              end;

            //For tables get the last items in the column; only do the comps, not subject column.
            if ((ATableType = ttSales) or (ATableType = ttRentals) or ((ATableType = ttListings) and ListAsSale) or ((ATableType = ttListings) and (ThisColumn.FCX.FormID = 794))) and
               (ColCounter > 0) and CompIsExported then
              begin
                if ThisColumn.HasAdjSalesPriceCell and ThisColumn.HasNetAdjustmentCell then
                  begin
                    //set the comp adjusted price
                    ATranslator.ExportValue(AdjIDs[2],'',IntToStr(ColIdx),ThisColumn.AdjSalePrice);

                    //get the net adjustment for the comp
                    NetAdjValue := GetValidNumber(ThisColumn.NetAdjustment);
                    ATranslator.ExportValue(AdjIDs[3],'',IntToStr(ColIdx), NetAdjValue);
                    //set if its a postive or negative adjustent
                    if NetAdjValue >= 0 then
                      ATranslator.ExportValue(AdjIDs[4],'',IntToStr(ColIdx), 'Y')
                    else
                      ATranslator.ExportValue(AdjIDs[5],'',IntToStr(ColIdx), 'N');

                    // add in the net and gross values
                    ThisColumn.GetNetAndGrossAdjPercent(NetPct, GrossPct, AdjIDs[1]);
                    ATranslator.ExportValue(AdjIDs[6],'',IntToStr(ColIdx), NetPct);      //net percent for comp
                    ATranslator.ExportValue(AdjIDs[7],'',IntToStr(ColIdx), GrossPct);    //gross percent for comp
                  end;
              end;
            //For rental tables get/set the subject's GLA and Bathroom counts from the column;
            if (ColCounter = 0) and (ATableType = ttRentals) and CompIsExported then
              begin
                ThisCell := ThisColumn.GetCellByID(RentalBathID[1]);
                if ThisCell <> nil then
                  begin
                    RentBathQty := GetValidNumber(ThisCell.Text);
                    for Cntr := 2 to MaxRentID do
                      begin
                        ThisCell := ThisColumn.GetCellByID(RentalBathID[Cntr]);
                        if ThisCell <> nil then
                          RentBathQty := RentBathQty + GetValidNumber(ThisCell.Text);
                      end;
                    ATranslator.ExportValue(231,'',IntToStr(ColIdx), RentBathQty);
                  end;
                ThisCell := ThisColumn.GetCellByID(RentalGLAID[1]);
                if ThisCell <> nil then
                  begin
                    RentGLA := GetValidNumber(ThisCell.Text);
                    for Cntr := 2 to MaxRentID do
                      begin
                        ThisCell := ThisColumn.GetCellByID(RentalGLAID[Cntr]);
                        if ThisCell <> nil then
                          RentGLA := RentGLA + GetValidNumber(ThisCell.Text);
                      end;
                    ATranslator.ExportValue(232,'',IntToStr(ColIdx), RentGLA);
                  end;
              end;
          end;
      end;
  finally
    ListCompOffset := ListCompOffset + Pred(ThisGridManager.Count);
    ThisGridManager.Free;
    FormIDList.Free;
  end;
end;


//Verify XML

function GetXMLReportName (FullPath: String): String;
var
	selectEXE: TOpenDialog;
  path: String;
begin
	selectEXE := TOpenDialog.Create(nil);
  try
    if FileExists(FullPath) then
      begin
        selectEXE.InitialDir := ExtractFilePath(FullPath);
        selectEXE.Filename := ExtractFileName(FullPath);
      end
    else
      selectEXE.InitialDir := VerifyInitialDir('AppraisalWorld', ApplicationFolder);

    selectEXE.DefaultExt := 'xml';
    selectEXE.Filter := 'Report XML (*.xml)|*.xml';    //'*.xml|All Files (*.*)|*.*';
    selectEXE.FilterIndex := 1;
    selectEXE.Title := 'Select a XML Report file to verify:';

    if (selectEXE.Execute) then
      begin
        path := selectEXE.Filename;
        XMLReportPath:=SysUtils.ExtractFilePath(path);
        XMLReportName := ExtractFileName(path);
        result := path;
      end;
  finally
	  selectEXE.Free;
  end;
end;

{procedure VerifyXMLReport ();
var
  Doc: DOMDocument40;
  fileName, output, parseString: String;
 begin
  parseString := '<!DOCTYPE VALUATION_RESPONSE SYSTEM "AppraisalXML.dtd">';
  Doc := CoDOMDocument40.Create();
  Doc.resolveExternals := true;
  Doc.validateOnParse := true;

  if (XMLReportName <> '') then
    fileName :=  GetXMLReportName (XMLReportName)
  else
    fileName:=  GetXMLReportName('C:\AppraisalWorld\Report\Sample_Appraisal_File.xml');

  if FileExists(XML_DTD) then
    CopyFile(XML_DTD, XMLReportPath+'\AppraisalXML.dtd', true)
  else
    raise Exception.Create('The MISMO DTD verification file could not be found. Please ensure it has been installed properly.');

  if  Not FileExists(fileName) then
    ShowNotice ('Report not found')
  else
      Doc.load(fileName);
      if Doc.parseError.errorCode <> 0 then
        begin
          output := Doc.parseError.reason + #13#10 +   ' In:  ' + Doc.parseError.srcText ;
            ShowNotice (output);
        end
       else
         ShowNotice ('No errors found');

  if FileExists(XMLReportPath+'\AppraisalXML.dtd') then
    DeleteFile(XMLReportPath+'\AppraisalXML.dtd');
end;        }


function CheckForFileName(var AFileName: String): Boolean;
var
  SaveFile: TSaveDialog;
begin
  // 040611 JWyatt Revised to use default file name, if supplied
  result := False;
  SaveFile := TSaveDialog.Create(nil);
  try
    if (length(AFileName) > 0) and FileExists(AFileName) then
      DeleteFile(AFileName);

    saveFile.FileName := AFileName;
    SaveFile.Title := 'Specify a file name for the XML Report';
    saveFile.InitialDir := appPref_DirUADXMLFiles;
    SaveFile.DefaultExt := 'xml';
    SaveFile.Filter := 'XML File(.xml)|*.xml';
    SaveFile.FilterIndex := 1;
    SaveFile.Options := SaveFile.Options + [ofOverwritePrompt];
    if SaveFile.Execute then
      begin
        AFileName := SaveFile.FileName;
        appPref_DirUADXMLFiles := ExtractFilePath(AFileName);
        result := True;
      end;
  finally
    SaveFile.Free;
  end;
end;

procedure SaveAsGSEAppraisalXMLReport(AContainer: TContainer; AFileName: string; LocType: Integer=0; NonUADXMLData: Boolean=False);
begin
  SaveAsGSEAppraisalXMLReport(AContainer, nil, AFileName, LocType, NonUADXMLData);
end;

procedure SaveAsGSEAppraisalXMLReport(AContainer: TContainer; ExportForm: BooleanArray;
  AFileName: string; LocType: Integer=0; NonUADXMLData: Boolean=False);
begin
  SaveAsGSEAppraisalXMLReport(AContainer, ExportForm, AFileName, nil, LocType, NonUADXMLData);
end;

procedure SaveAsGSEAppraisalXMLReport(AContainer: TContainer;  ExportForm: BooleanArray;
  AFileName: string; Info: TMiscInfo; LocType: Integer=0; NonUADXMLData: Boolean=False);
begin
  if CheckForFileName(AFileName) then
    CreateGSEAppraisalXMLReport(AContainer, ExportForm, AFileName, Info, LocType, NonUADXMLData);
end;

//This call is used for RELS
procedure CreateGSEAppraisalXMLReport(AContainer: TContainer;  ExportForm: BooleanArray;
  AFileName: string; Info: TMiscInfo; LocType: Integer=0; NonUADXMLData: Boolean=False);
var
  xmlReport, XSD_FileName, XMLVer: String;
  srcXMLDoc: IXMLDOMDocument2;
  cache: IXMLDOMSchemaCollection;
begin
  if IsXMLSetup(AContainer) then
    begin
      if LocType = 2 then
        begin
          xmlReport := ComposeGSEAppraisalXMLReport(AContainer, XMLVer, ExportForm, Info, nil, 0, NonUADXMLData);
          xmlReport := xmlReport + ComposeGSEAppraisalXMLReport(AContainer, XMLVer, ExportForm, Info, nil, LocType);
        end
      else
        xmlReport := ComposeGSEAppraisalXMLReport(AContainer, XMLVer, ExportForm, Info, nil, LocType, NonUADXMLData);

      uWindowsInfo.WriteFile(AFileName, xmlReport);
      if FileExists(AFileName) then
        begin
          XSD_FileName := IncludeTrailingPathDelimiter(appPref_DirMISMO) + MISMO_XPathFilename + XMLVer + '.xsd';
          if FileExists(XSD_FileName) then
            begin
              cache := CoXMLSchemaCache60.Create;
              srcXMLDoc := CoDomDocument60.Create;
              srcXMLDoc.async := false;
              srcXMLDoc.setProperty('SelectionLanguage', 'XPath');
              cache.add('',XSD_FileName);
              srcXMLDoc.schemas := cache;
              srcXMLDoc.loadXML(xmlReport);
              if srcXMLDoc.parseError.errorCode <> 0 then
                ShowAlert(atWarnAlert, 'ClickFORMS has detected issues validating your XML file, ' +
                  ExtractFileName(AFileName) + '. For assistance please e-mail your ClickFORMS report (the "clk" file) to uad@bradfordsoftware.com.');
            end
          else
            ShowAlert(atStopAlert, 'The XML validation schema file, ' + ExtractFileName(XSD_FileName) +
               ', cannot be found. The XML file was not properly validated.');
        end;
    end
  else
    ShowAlert(atStopAlert, 'There was a problem creating the XML file.');
end;

//This is the main code for creating UAD XML file (either MISMO26 or MISMO26_GSE)
function ComposeGSEAppraisalXMLReport(AContainer: TContainer; var XMLVer: String; ExportForm: BooleanArray; Info: TMiscInfo;
  ErrList: TObjectList; LocType: Integer=0; NonUADXMLData: Boolean=False): string;
var
  FormCounter, PageCounter, CellCounter, ThisIndex, ListCompOffset : Integer;
  ThisPage: TDocPage;
  ThisCell: TBaseCell;
  ThisTranslator: TMISMOTranslator;
  ExportedCell: TExportedList;
  Err: TComplianceError;
  ThisForm: TdocForm;
  Counter: Integer;
  DividedCellContent: TStringList;
  exportThisForm: Boolean;
  // The following five variables are added for control and processing of UAD
  //  compliant reports.
  IsUAD, IsVer2_6: Boolean;
  MapCellLocaterEvent: TMapCellLocaterEvent;
  RELSOrder: RELSOrderInfo;
  Frm1004MCSeqID: Integer;

  //on some forms, the cell text is continued on another cell. These cells have the same ID
  //and are handled here as divided cells. At the end, these cells are exported as one export
  procedure HandleDividedCells;
  begin
    ThisIndex := DividedCellContent.IndexOfObject(TObject(ThisCell.FCellXID));
    if ThisIndex <> -1 then
      begin
        DividedCellContent.Strings[ThisIndex] :=
          TrimLeft(DividedCellContent.Strings[ThisIndex] + ' ') +
          Trim(ThisCell.Text);
      end
    else
      DividedCellContent.AddObject(ThisCell.Text, TObject(ThisCell.FCellXID));
  end;

  //In some cases we have to skip XML node for checkbox if the general None
  //checkbox checked. For example skip Garage types (Garage,Covered, or Open)
  //if Garage storage None checked. It is forms 1073, 1075.
  //There are the other such cases.
  function SkipDependOn(page: TDocPage; masterCellXID: integer; Translator: TMISMOTranslator): Boolean;
  var
    masterCell: TBaseCell;
    cellText: String;
  begin
    result := false;
    masterCell := page.GetCellByXID(masterCellXID);
    if masterCell is TchkBoxCell then
    begin
     cellText := GetTextAsGSEData(masterCell.FCellXID, masterCell, Translator);
      result := CompareText(cellText,'N') = 0;
    end;
  end;


begin
  Result := '';
  ThisTranslator := nil;
  ExportedCell := nil;
  //make sure we have a container
  if assigned(AContainer) then
  try
    if Assigned(AContainer.docEditor) and (AContainer.docEditor is TEditor) then
      (AContainer.docEditor as TEditor).SaveChanges;
    AContainer.ProcessCurCell(True);                    //get the latest text

    // 081811 JWyatt We need a better method than the following so
    //  we can remove RELS-specific code from here and make this module
    //  more generic. We don't yet know what other AMCs & AMC suppliers
    //  want and the impact.

    RELSOrder := ReadRELSOrderInfoFromReport(AContainer);
    if RELSOrder.OrderID > 0 then
      begin
        if RELSOrder.Version = RELSUADVer then
          XMLVer := UADVer
        else
          XMLVer := NonUADVer;
      end
    else if (XMLVer = '') then
      if AContainer.UADEnabled then
        XMLVer := UADVer
      else
        XMLVer := NonUADVer;

    IsUAD := AContainer.UADEnabled and (XMLVer = UADVer);

    // 050411 JWyatt Move SetupMISMO call after XMLVer setup in case we're
    //  exporting a non-UAD report
    SetupMISMO(AContainer, XMLVer);                     //set the file paths

    ThisTranslator := TMISMOTranslator.Create;          //create the export translator
    DividedCellContent := TStringList.Create;
//    ExportedCell := TExportedList.Create(AContainer, CountReportCells(AContainer));   //set the list for exported cell IDs
    ExportedCell := TExportedList.Create(AContainer, CountReportCells2(AContainer, ExportForm));   //set the list for exported cell IDs

    try
      IsVer2_6 := ((XMLVer = UADVer) or (XMLVer = NonUADVer));
      AContainer.CellXPathList.Clear;
      ThisTranslator.RaiseComplianceError := assigned(ErrList);   //do we save the complliance errors
      ThisTranslator.OnExport := ExportedCell.StoreID;            //save cell id on export into ExportList

      //first checkpoint - do we have a translator with a map
      if not assigned(ThisTranslator.Mappings) then
        raise Exception.Create('Problems were encountered with the MISMO Data. The XML file could not be created.');

      //ThisTranslator.BeginExport(stAppraisalResponse);
      ThisTranslator.BeginExport(stAppraisal);

      //second checkpoint - do we have the appraisal DTD file
      if FileExists(XML_DTD) then
        begin
          ThisTranslator.XML.DocType.LoadFromFile(XML_DTD);
          ThisTranslator.XML.IncludeDTD := False;
        end
      else
        raise Exception.Create('The MISMO DTD file was not found. The XML file could not be created.');

      //Start exporting XML
      //export all data that is not on form
      ExportReportAttributes(AContainer, ExportForm, ThisTranslator, Info, IsVer2_6, XMLVer);
      ExportReportFormList(AContainer, ThisTranslator, ExportForm, ErrList, Frm1004MCSeqID, IsVer2_6, Info);
      if XMLVer = UADVer then
        ExportReportEmbededPDF(AContainer, ThisTranslator, Info);
      ExportReportPartiesParsedAddess(AContainer, ExportForm, ThisTranslator);
      ExportSalesContractConsessions(AContainer, ExportForm, ThisTranslator, IsVer2_6); //special so we don't have to add cells to all forms
      ExportMergedCells(AContainer, MAIN_FORM_SUMMARY_COMMENT_CELLXID, ExportForm, ThisTranslator, [917,2727]);

      ListCompOffset := 0;
      ExportTableCells2(ExportForm, AContainer, ttSales, ErrList, ThisTranslator, IsUAD, IsVer2_6, ListCompOffset, NonUADXMLData, LocType);      //export the Sales Comp Grid
      if (ListCompOffset < 0) then
        ListCompOffset := 0;
      ExportTableCells2(ExportForm, AContainer, ttListings , ErrList, ThisTranslator, IsUAD, IsVer2_6, ListCompOffset, NonUADXMLData, LocType);  //export the Listing Comp Grid
      ListCompOffset := 0;
      ExportTableCells2(ExportForm, AContainer, ttRentals , ErrList, ThisTranslator, IsUAD, IsVer2_6, ListCompOffset, NonUADXMLData, LocType);   //export the Rental Comp Grid

//--- these might be handled in the ExportFormList - if photos are wanted
//     ExportTablePhotoCells(ctSales, ThisTranslator);
//     ExportTablePhotoCells(ctRentals, ThisTranslator);
//     ExportTablePhotoCells(ctListings, ThisTranslator);

      for FormCounter := 0 to AContainer.docForm.count - 1 do     //for each form
        begin
          exportThisForm := True;                                 //assume we will export this form
          if assigned(ExportForm) then                            //if we have non-nil export list
            exportThisForm := ExportForm[formCounter];            //check if its on list to export

          if exportThisForm then                                    //do we export it?
            begin
              ThisForm := AContainer.docForm[FormCounter];
              for PageCounter := 0 to ThisForm.frmPage.Count - 1 do            //for each page
                begin
                  ThisPage := ThisForm.frmPage[PageCounter];
                  if (ThisPage.pgData <> nil) then                             //make sure page has data cells
                    begin
                      for CellCounter := 0 to ThisPage.pgData.Count - 1 do
                        begin
                          ThisCell := ThisPage.pgData[CellCounter];

                          // exclude page number cells
                          if (ThisCell.FCellXID = CELL_PGNUM_XID) then
                            Continue;
                          if (ThisCell.FCellXID <> 0) and          //has an XPath
                              not (ThisCell is TGraphicCell) and   //not a graphical cell
                              not (ThisCell is TGridCell) and      //not a grid cell
                              not (ThisCell is TInvisibleCell) and   //not a invisible cell
                              not ExportedCell.HasBeenExported(ThisCell.FCellXID) then    //not already exported
                            begin
                              //exclude these cells - handled in special way
                              if not IsVer2_6 then
                                case ThisCell.FCellXID of
                                  2731:
                                    begin
                                      HandleDividedCells;   //  Instructions to the appraiser on Land form
                                      Continue;
                                    end;

                                  // If we're NOT processing a UAD-compatible report then
                                  //  we need to skip the 'already exported' items. For UAD
                                  //  compliant reports these items have not previously
                                  //  been exported.
                                  //Signer - Appraiser - already exported
                                  5,7,1684,9,10,11,12,13,14,15,16,17,18,19,20,21,5008,2098,
                                  2096,2097,1149,1150,1151,2009,1660,1678:
                                    Continue;

                                  //Signer - Reviewer - already exported
                                  1402, 1403,1666,1499,1504,1505,1506,1728,1507,1508,1509,
                                  1510,1511,1512,1513,1514,1517,1518,1520,1521,
                                  1522,1523,1524,1658,1729,1730:
                                    Continue;

                                  //Signer - Supervisor - already exported
                                  6,22,23,24,42,25,26,27,276,277,5018,2099,28,29,30,32,33,
                                  1152,1153,1154,2008,1155,1156,2100,1679:
                                    Continue;

                                  //general comments & special XComp comments
                                  917,1218,2727,2729,1676:
                                    Continue;

                            end;

                              if IsVer2_6 then
                                case ThisCell.FCellXID of
                                  // Special handling for the 1004MC & Comparable Rent license/certification cells
                                  17, 28, 2098, 2099:
                                    if (ThisForm.FormID = 850) or (ThisForm.FormID = 29) then
                                      Continue;
                                  5008, 5018:
                                    Continue;
                                  // Following cell XID are exported elsewhere, are not used
                                  //  or have no corresponding path in the 2.6 schema so are
                                  //  skipped.
                                  1, 405..407, 451, 526, 677..680, 682..685, 690, 906..909,
                                  928, 937..939, 951, 1035, 1036, 1046, 1050, 1099..1101,
                                  1202, 1225..1227, 1264..1278, 1282, 1313, 1314, 1331..1362,
                                  1370, 1371, 1376, 1377, 1379..1386, 1390, 1400, 1401, 1670,
                                  1671, 1406..1434, 1525..1636, 1639..1659, 1669, 1677, 1689..1694, 1728,
                                  1730, 1740..1783, 1913..1945, 1954..1991, 2031, 2073, 917,
                                  2165..2172, 2175..2214, 2324, 2331..2334, 2364, 2727, 2728,
                                  2729, 2731, 3159, 3163, 3253, 3255, 3258, 3259, 3915, 3916,
                                  3930..3932, 3934..3936, 3956..3961, 4070..4074, 4228, 4236:
                                    Continue;
                                  //forms 1073,1075 Car storage None checked
                                  349,2000,3591:
                                    if SkipDependOn(thisPage, 346, ThisTranslator) then
                                      continue;
                                  //MISMO XML schema allowes the only one appraiser license per XML
                                  20: //state license #
                                    if Acontainer.GetCellByXID_MISMO(18, ExportForm).HasData then //check state certificate #
                                      continue;
                                  2096, 2097 :  //other state license #, description
                                    if AContainer.GetCellByXID_MISMO(18, ExportForm).HasData or
                                      Acontainer.GetCellByXID_MISMO(20, ExportForm).HasData then  // check state license and state certificate
                                        continue;
                                end;

                              case ThisCell.FCellXID of
                                //  already exported above in Photo, Map, or Sketch addemdums
                                // Version 7.2.7 JWyatt Add declarations for IDs 2870-2881 used
                                //  on the Subject Interior Photos form (ID 919).
                                // Version 7.2.8 JWyatt Add declarations for IDs 2882-2887 used
                                //  on the Untitled Subject Interior Photos form (ID 936).
                                1157, 1158, 1163..1168, 1205..1213, 1219..1221, 2617..2642,
                                2870..2887, 5076, 9001..9004:
                                  Continue;
                              end;

                              // select cell locater mapping proc
                              case LocType of
                                1: MapCellLocaterEvent := MapXPathLocater;
                                2: MapCellLocaterEvent := MapEmbeddedLocater;
                              else
                                MapCellLocaterEvent := nil;
                              end;

                              // export
                              try
                                case ThisCell.FCellXID of
                                  // Handle 1004MC specially to use the found sequence ID
                                  2763..2857:
                                    if IsUAD and (Trim(ThisCell.Text) <> '') then
                                      begin
                                        ExportGSEData(ThisCell, ThisTranslator, ExportedCell, MapCellLocaterEvent, Frm1004MCSeqID);
                                        if (not ExportedCell.HasBeenExported(ThisCell.FCellXID)) then
                                          ExportCell(False, ThisCell, ThisTranslator, MapCellLocaterEvent, Frm1004MCSeqID);
                                      end
                                    else
                                      ExportCell(False, ThisCell, ThisTranslator, MapCellLocaterEvent, Frm1004MCSeqID);
                                else
                                  if IsUAD then
                                    begin
                                      ExportGSEData(ThisCell, ThisTranslator, ExportedCell, MapCellLocaterEvent);
                                      if (not ExportedCell.HasBeenExported(ThisCell.FCellXID)) then
                                        ExportCell(False, ThisCell, ThisTranslator, MapCellLocaterEvent);
                                    end
                                  else
                                    begin
                                      ExportCell(False, ThisCell, ThisTranslator, MapCellLocaterEvent);
                                    end;
                                end;

                              except
                                on E: EMISMOFormatError do
                                  begin
                                    if assigned(ErrList) then
                                      begin
                                        Err := TComplianceError.Create;
                                        Err.FCX.FormID := 0;            //don't search by FormID
                                        Err.FCX.Form := FormCounter;    //search by form index
                                        Err.FCX.Occur := 0;             //don't search by occurance
                                        Err.FCX.Pg := PageCounter;      //search by page
                                        Err.FCX.Num := CellCounter;     //search by cell sequence
                                        Err.FMsg := E.Message;

                                        ErrList.Add(Err);
                                      end;
                                  end;
                                on E: Exception do;
                              end;
                            end;
                         end;
                     end;
                  end;

                for Counter := 0 to DividedCellContent.Count - 1 do
                  begin
                    ThisTranslator.ExportValue(Integer(DividedCellContent.Objects[Counter]),
                    DividedCellContent.Strings[Counter]);
                  end;
                DividedCellContent.Clear;
             end;
        end;

      //DONE - this is the resulting XML text
      Result := SetUADSpecialXML(ThisTranslator.EndExport);
    except
      on E : Exception do
      begin
        ThisTranslator.CancelExport;
        ShowAlert(atWarnAlert, E.Message);
      end;
    end;
  finally
    if assigned(ThisTranslator) then
      ThisTranslator.Free;

    If assigned(ExportedCell) then
      ExportedCell.Free;

    if assigned(DividedCellContent) then
      DividedCellContent.Free;
  end;
end;

function ValidateXML(doc: TContainer; xmlReport: String): Boolean;
var
  XSD_FileName: String;
  cache: IXMLDOMSchemaCollection;
  srcXMLDoc: IXMLDomDocument2;
  XMLVer: String;
begin
  result := false;
  if doc.UADEnabled then
    XMLVer := UADVer
  else
    XMLVer := NonUADVer;
  XSD_FileName := IncludeTrailingPathDelimiter(appPref_DirMISMO) +
              MISMO_XPathFilename + XMLVer + '.xsd';
  if FileExists(XSD_FileName) then
    begin
      cache := CoXMLSchemaCache60.Create;
      srcXMLDoc := CoDomDocument60.Create;
      srcXMLDoc.async := false;
      srcXMLDoc.setProperty('SelectionLanguage', 'XPath');
      cache.add('',XSD_FileName);
      srcXMLDoc.schemas := cache;
      srcXMLDoc.loadXML(xmlReport);
      if srcXMLDoc.parseError.errorCode <> 0 then
        ShowAlert(atWarnAlert, 'ClickFORMS has detected issues validating your XML file.' +
          '. For assistance please e-mail your ClickFORMS report (the "clk" file) to uad@bradfordsoftware.com.')
      else
        result := true;
    end
  else
    ShowAlert(atStopAlert, 'The XML validation schema file, ' + ExtractFileName(XSD_FileName) +
               ', cannot be found. The XML file was not properly validated.');
end;

end.
