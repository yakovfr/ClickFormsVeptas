unit UMISMOInterface;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

interface

uses
  Contnrs, XmlDom, XmlDoc, IniFiles,
  UContainer, UForm, UAMC_XMLUtils, uCraftXML, uGlobals, UAMC_RELSExport, RelsResponseService_TLB;

const
  MAX_COMPARABLE_COUNT = 99;
  ORDER_FORM_ID = 610;
  RELLS_ORDER_FORM_ID = 626;

  ORDER_ACCEPT_BUTTON_ID = 100;
  ORDER_DECLINE_BUTTON_ID = 101;
  ORDER_SCHEDULED_BUTTON_ID = 102;
  ORDER_INSPECTED_BUTTON_ID = 103;
  ORDER_COMPLETED_BUTTON_ID = 106;
  ORDER_RESUMED_BUTTON_ID = 105;
  ORDER_DELIVERED_BUTTON_ID = 998;
  ORDER_DELAYED_BUTTON_ID = 104;
  ORDER_QUERY_BUTTON_ID = 996;
  ORDER_CANCELED_BUTTON_ID = 995;
  ORDER_SEND_FILE_BUTTON_ID = 994;

  ORDER_ACCEPTED_DATE_CELLID = 3105;
  ORDER_DECLINED_DATE_CELLID = 3106;
  ORDER_SCHEDULED_DATE_CELLID = 3107;
  ORDER_INSPECTED_DATE_CELLID = 3108;
  ORDER_DELAYED_DATE_CELLID = 3109;
  ORDER_RESUMED_DATE_CELLID = 3110;
  ORDER_COMPLETED_DATE_CELLID = 3111;

  errCanntFindPDFFile = 'Cannot find the PDF file %s!';
  errCanntFindEnvFile = 'Cannot find the ENV file %s!';
  errCanntFindXMLFile = 'Cannot find the XML file %s!';

//CREATING MISMO XML Document
function ComposeAppraisalXMLReport(AContainer: TContainer; ExportForm: BooleanArray; Info: TMiscInfo; ErrList: TObjectList; AMCVer: String=''): string;

//Saving MISMO XML Documents
procedure SaveAsAppraisalXMLReport(AContainer: TContainer; AFileName: string); overload;
procedure SaveAsAppraisalXMLReport(AContainer: TContainer; ExportForm: BooleanArray; AFileName: string); overload;
procedure SaveAsAppraisalXMLReport(AContainer: TContainer;  ExportForm: BooleanArray; AFileName: string; Info: TMiscInfo; AMCVer: String=''); overload;

//procedure VerifyXMLReport();  not used YF 01/19/2018


//CREATING CONTAINER FROM MISMO XML - NO LONGER WORKS WITH CURRENT MISMO VERSION
function CreateNewContainerFromOrder(const AnOrderText: string) : TContainer;
function CreateNewContainerFromOrderFile(const AFileName: string) : TContainer;
function CreateNewContainerFromReport(const AFileName: string) : TContainer;

procedure AddPagesFromXML(AnXML : TXMLCollection; AContainer : TContainer);
procedure AddXMLDataToDocument(AContainer: TContainer; AnXML : TXMLCollection ; AllForms :Boolean);

function IsMISMORequestDocument(AContainer: TContainer) : Boolean;
function FindMISMORequestXMLText(AContainer: TContainer) : string;
function GetMISMORequestXMLText(AContainer: TContainer) : string;
procedure SetMISMORequestXMLText(AContainer: TContainer; const AnXMLText : string);

//function FindOrderStatus(AContainer : TContainer; PriorIndex : Integer = 0) : TAppraisalOrderStatus;
//procedure UpdateOrderStatus(AContainer : TContainer; AStatus : TAppraisalOrderStatus;
//        const AComment : string = ''; AStatusDate : TDateTime = 0.0; AnInspectionDate : TDateTime = 0.0);

//procedure SetOrderFormButtons(AContainer : TContainer; AStatus : TAppraisalOrderStatus = etsUnknown);

function FindVendorOrderID(AContainer : TContainer) : Integer;
function GetVendorOrderID(AContainer : TContainer) : Integer;
procedure SetVendorOrderID(AContainer : TContainer; AnOrderID : Integer);



var
  XMLReportPath : String;
  XMLReportName : String;


implementation

uses
  Forms, SysUtils, Classes, Math, Dialogs,
  UMain, UStatus,USysInfo,ULicUser,UUtil2,UUtil1, MSXML6_TLB,
  UMISMOImportExport, UMISMOEnvelope,
  UCell, UBase, UPage, UMath, UEditor,
  uCraftClass, UGridMgr, UWindowsInfo, uInternetUtils, UBase64,
  UGraphics, UActiveForms, uDocCommands,
  UMathEvals{, uAppraisalWorldInterface};

const
  ttSales     = 1;    //types of grids
  ttRentals   = 2;
  ttListings  = 3;

  VSS_XMLVersion  = 'VSS1.0';   //XML version for RELS/VSS

  FORM_ELEMENT_NAME         = '//_FORM';
  ADDENDUM_ELEMENT_NAME     = '//_ADDENDUM';
  CHECK_CELL_TRUE_TEXT      = 'X';
  CHECK_CELL_FALSE_TEXT     = '';
  IMPORT_CELL_ID_OFFSET     = 50000;
  SOFTWARE_NAME_CELLID      = 2990;
  SOFTWARE_VERSION_CELLID   = 2991;

const
   FORM_ID              = 10000;

   PROPERTY_SKETCH      = 11001;
   LOCATION_MAP         = 11002;
   PLAT_MAP             = 11011;
   FLOOD_MAP            = 11012;
   SUBJECT_PHOTOS       = 11003;
   MISC_PHOTOS          = 11010;
   COMPARABLE_SALE_PHOTOS = 11004;
   COMPARABLE_LISTING_PHOTOS = 11005;
   COMPARABLE_RENTAL_PHOTOS = 11006;
   SIGNATURE            = 11007;
   INVOICE              = 11008;
   ADDITIONAL_COMMENTS  = 11009;

   COMPARABLE_IMAGE_CELLID = 11900;
   REPORT_TYPE_CELLID   = 2646;

   COVER_PHOTO_CELLID   = 2645;

   GRID_NET_POSITIVE_CELLID = 1050;
   GRID_NET_NEGATIVE_CELLID = 1051;

   OTHER_FORM       = 10499;
   OTHER_ADDENDUM   = 11000;

// REVIEW - CONSTANTS DUPLICATED IN UGESINTERFACE

   FMX_1004         = 340;
   FMX_1004_CERT    = 341;
   FMX_1004P        = 4218;
   FMX_1004PCERT    = 4219;
   FMAC_70H         = 4365;  //1004 2019
   FMAC_70HCERT     = 4366;
   FMX_1004_XCOMP   = 363;
   FMX_1004C        = 342;
   FMX_1004C_XCOMP  = 365;
   FMX_1004C_CERT   = 343;
   FMX_1004D        = 344;
   FMX_1025         = 349;
   FMX_1025_XCOMP   = 364;
   FMX_1025_XRENT   = 368;
   FMX_1025_CERT    = 350;
   FMX_1073         = 345;
   FMX_1073_XCOMP   = 367;
   FMX_1073_CERT    = 346;
   FMX_2090         = 351;
   FMX_2090_XCOMP   = 366;
   FMX_2090_CERT    = 352;
   FMX_2055         = 355;
   FMX_2055_XCOMP   = 363;
   FMX_2055_CERT    = 356;
   FMX_1075         = 347;
   FMX_1075_XCOMP   = 367;
   FMX_1075_CERT    = 348;
   FMX_2095         = 353;
   FMX_2095_XCOMP   = 366;
   FMX_2095_COMP    = 354;
   FMX_2000         = 357;
   FMX_2000_XCOMP   = 363;
   FMX_2000_INST    = 358;
   FMX_2000_CERT    = 359;
   FMX_2000A        = 360;
   FMX_2000A_XCOMP  = 364;
   FMX_2000A_INST   = 361;
   FMX_2000A_CERT   = 362;

   ERC_1994         = 84;
   ERC_2001         = 87;
   ERC_2003         = 95;
   ERC_BMA_1996     = 85;

   FMAE_1004_1993         = 1;
   FMAE_1004_1993_XCOMPS  = 2;
   FMAE_1073_1997         = 7;
   FMAE_1073_1997_XCOMPS  = 8;
   LAND_APPRAISAL         = 9;
   LAND_APPRAISAL_XCOMPS  = 10;
   FMAE_1025_1994         = 18;
   FMAE_1025_1994_XLISTS  = 19;
   FMAE_1025_1994_XRENTS  = 20;
   FMAE_1025_1994_XCOMPS  = 21;
   COMPLETION_CERTIFICATE_LEGAL = 30;

   FMAE_2055_1996         = 37;
   FMAE_2055_1996_XCOMPS  = 38;
   FMAE_2065_1996         = 39;
   FMAE_2065_1996_XCOMPS  = 40;
   FMAE_2075_1997         = 41;
   FMAE_2070              = 43;

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
   EXTRA_SALES_GRID_FORM_SUMMARY_COMMENT_CELLID = 2727;
   EXTRA_RENTAL_GRID_FORM_COMMENT_CELLID = 2754;
   EXTRA_LISTING_GRID_FORM_COMMENT_CELLID = 2755;
   EXTRA_SALES_GRID_FORM_PREVIOUS_SALES_CELLID = 2729;
   EXTRA_SALES_GRID_FORM_COMMENT_CELLID = 111; //dummy cellid

type
  TImageFormat = (if_Unknown, if_BMP, if_PNG, if_GIF, if_PCX, if_JPG, if_PCD, if_TGA,
       if_TIF, if_EPS, if_WMF, if_EMF, if_DIB, if_DFX, if_None);

  TArrayOfForms = array of TDocForm;

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


function ClickFormsName: string;
begin
  Result := 'ClickFORMS';
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

//### DUPLICATED IN UGSEINTERFCE
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
  // Err: TComplianceError;
begin
  result := '';
  if assigned(ACell) then
    begin
      AValue := ACell.GetText;
      if IsValidDateTimeWithDiffSeparator(AValue, ADate) then
        result := FormatDateTime('yyyy-mm-dd', ADate)
      else
        result := AValue;   //this is RELS Specific exception
(*
      //not formatted properly - pass back an error msg
      else if (CompareText(AValue, 'NA')<> 0) and (CompareText(AValue, 'Unknown')<> 0) then
        if assigned(ErrList) then
          begin
            Err := TComplianceError.Create;
            Err.FCX := ADoc.GetCellUID(ACell);
            Err.FCX.FormID := 0;            //don't search by FormID
            Err.FCX.Occur := 0;             //don't search by occurance
            Err.FMsg := '"' + AValue + '" needs to be a valid date (mm/dd/yy)or NA or Unknown.';
            ErrList.Add(Err);
          end;
*)
    end;
end;

//-----------------------------------
//  Start of the Export XML Routines
//-----------------------------------

procedure ExportReportAttributes(doc: TContainer; exportForm: BooleanArray; ATranslator: TMISMOTranslator; Info: TMiscInfo);
//var
//  fName, fVers: String;
begin
  ATranslator.ExportValue(SOFTWARE_NAME_CELLID, ClickFormsName);          //Producing Software Name
  ATranslator.ExportValue(SOFTWARE_VERSION_CELLID, SysInfo.AppVersion);   //producing Software Version
  ATranslator.ExportValue(10507, VSS_XMLVersion);                         //VSS version of XML
	ATranslator.ExportValue(2992, doc.GetCellTextByXID_MISMO(2992, exportForm));   //AppraisalScopeOfWorkDescription
	ATranslator.ExportValue(2993, doc.GetCellTextByXID_MISMO(2993, exportForm));   //AppraisalIntendedUserDescription
	ATranslator.ExportValue(2994, doc.GetCellTextByXID_MISMO(2994, exportForm));   //AppraisalIntendedUseDescription

  if assigned(Info) then
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
 
procedure ExportReportEmbededXML(doc: TContainer; ATranslator: TMISMOTranslator; XMLFilePath, AMCVer: String);
var
  AStream: TFileStream;
  xmlStr, EncodedStr : string;
  AnElement: TXMLElement;
begin
  if AMCVer <> '' then
    begin
      if not fileExists(XMLFilePath) then
        raise Exception.Create(Format(errCanntFindXMLFile,[XMLFilePath]));

      AStream := TFileStream.Create(XMLFilePath, fmOpenRead);
      try
        SetLength(xmlStr, AStream.Size);
        AStream.Read(PChar(xmlStr)^,length(xmlStr));
      finally
        AStream.Free;
      end;

      if length(xmlStr) > 0 then
        begin
           EncodedStr := UBase64.Base64Encode(xmlStr);
           AnElement := ATranslator.XML.FindElement('REPORT');
           with AnElement.AddElement('EMBEDDED_FILE') do
             begin
                AttributeValues['_EncodingType'] := 'Base64';
                AttributeValues['_Name'] := AMCVer;
                AttributeValues['MIMEType'] := 'text/xml';
                AddElement('DOCUMENT').AddElement(ecMarkedSection).RawText := EncodedStr;
             end;
        end;
    end;
end;


procedure ExportReportEmbededPDF(doc: TContainer; ATranslator: TMISMOTranslator; Info: TMiscInfo);  // PDFPath: string );
var
  AStream: TFileStream;
  pdfStr, EncodedStr : string;
  AnElement: TXMLElement;
begin
  if assigned(Info) and Info.FEmbedPDF then
    begin
      if not fileExists(Info.FPDFFileToEmbed) then
        raise Exception.Create(Format(errCanntFindPDFFile,[Info.FPDFFileToEmbed]));

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
           AnElement := ATranslator.XML.FindElement('REPORT');
           with AnElement.AddElement('EMBEDDED_FILE') do
             begin
                AttributeValues['_EncodingType'] := 'Base64';
                AttributeValues['_Name'] := 'AppraisalReport';
                AttributeValues['MIMEType'] := 'application/pdf';
                AddElement('DOCUMENT').AddElement(ecMarkedSection).RawText := EncodedStr;
             end;
        end;
    end;
end;

procedure ExportReportEmbededENV(doc: TContainer; ATranslator: TMISMOTranslator; Info: TMiscInfo);
var
  AStream: TFileStream;
  envStr, EncodedStr : string;
  AnElement: TXMLElement;
begin
  if assigned(Info) and Info.FEmbedENV then
    begin
      if not fileExists(Info.FENVFileToEmbed) then
        raise Exception.Create(Format(errCanntFindENVFile,[Info.FENVFileToEmbed]));

      AStream := TFileStream.Create(Info.FENVFileToEmbed, fmOpenRead);
      try
        SetLength(envStr, AStream.Size);
        AStream.Read(PChar(envStr)^,length(envStr));
      finally
        AStream.Free;
      end;

      if length(envStr) > 0 then
        begin
           EncodedStr := UBase64.Base64Encode(envStr);
           AnElement := ATranslator.XML.FindElement('REPORT');
           with AnElement.AddElement('EMBEDDED_FILE') do
             begin
                AttributeValues['_EncodingType'] := 'Base64';
                AttributeValues['_Name'] := 'EnvZip';
                AttributeValues['MIMEType'] := 'application/zip';
                AddElement('DOCUMENT').AddElement(ecMarkedSection).RawText := EncodedStr;
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
  StAddr, CityStZip, Phone, Fax, Email: String;
  hasSignature: Boolean;
  ExpireDateExists: Boolean;
  // These variables are declared to handle special processing for cell XID 2008
  ChkBoxUID: CellUID;
  InspDateCell: TBaseCell;
  InspDateSet: Boolean;
  PosItem: Integer;
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
      Person.AttributeValues['_CompanyName'] := AForm.GetCellTextByXID_MISMO(8);
      StAddr := AForm.GetCellTextByXID_MISMO(9);
      // if there's a comma in the street address field we have a single-line company address form
      PosItem := Pos(',', stAddr);
      if PosItem > 0 then
        Person.AttributeValues['_StreetAddress'] := Copy(StAddr, 1, Pred(PosItem))
      else
        Person.AttributeValues['_StreetAddress'] := StAddr;
      CityStZip := AForm.GetCellTextByXID_MISMO(10);                                      //Appraiser City, St, Zip
      // if we have a single-line company address form then get the city, st & zip from the 1st address
      if (CityStZip = '') and (PosItem > 0) then
        CityStZip := Copy(StAddr, Succ(PosItem), length(StAddr));
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
      StAddr := AForm.GetCellTextByXID_MISMO(24);
      // if there's a comma in the street address field we have a single-line company address form
      PosItem := Pos(',', stAddr);
      if PosItem > 0 then
        Person.AttributeValues['_StreetAddress'] := Copy(StAddr, 1, Pred(PosItem))
      else
        Person.AttributeValues['_StreetAddress'] := StAddr;
      CityStZip := AForm.GetCellTextByXID_MISMO(42);                                     //Supervisor City, St, Zip
      // if we have a single-line company address form then get the city, st & zip from the 1st address
      if (CityStZip = '') and (PosItem > 0) then
        CityStZip := Copy(StAddr, Succ(PosItem), length(StAddr));
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
              Inspection.AttributeValues['AppraisalInspectionType'] := 'ExteriorAndInterior';
              InspDateSet := True;
              if AForm.FormID <> 4003 then  // no date on USPAP Certification 2012
                begin
                  ChkBoxUID := AForm.GetCellByXID_MISMO(1154).UID;
                  InspDateCell := AForm.GetCell(Succ(ChkBoxUID.Pg), (ChkBoxUID.Num + 2));
                  if length(InspDateCell.Text) > 0 then
                    Inspection.AttributeValues['InspectionDate'] := MISMODate(ADoc, InspDateCell, ErrList);
                end;
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
      StAddr := AForm.GetCellTextByXID_MISMO(1666);
      // if there's a comma in the street address field we have a single-line company address form
      PosItem := Pos(',', stAddr);
      if PosItem > 0 then
        Person.AttributeValues['_StreetAddress'] := Copy(StAddr, 1, Pred(PosItem))
      else
        Person.AttributeValues['_StreetAddress'] := StAddr;
      CityStZip := AForm.GetCellTextByXID_MISMO(1499);                                     //Reviewer City, St, Zip
      // if we have a single-line company address form then get the city, st & zip from the 1st address
      if (CityStZip = '') and (PosItem > 0) then
        CityStZip := Copy(StAddr, Succ(PosItem), length(StAddr));
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
     result := Trim(C1) + ' ' + Trim(C2)
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

procedure ExportRELSCommentsToXML(doc: TContainer; AElement: TXMLElement);
const
  attrRebuild = 'Rebuild';
var
  UserCmntStr: String;
  Comment: TXMLElement;
  RELSUserComments: TXMLDocument; // 05202013 - User comments for RELS commentaries
  SecQty, SecIdx, MainQty, MainIdx, RuleQty, RuleIdx: Integer;
  ResponseGrp: IXMLRESPONSE_GROUPType;
  CommentaryAddendum: IXMLRELS_COMMENTARY_ADDENDUMType;
  SecNode: IXMLSECTIONType;
  MainNode: IXMLMAIN_RULEType;
  RuleNode: IXMLCOMMENTARY_RULEType;
begin
  try
   RELSUserComments := TXMLDocument.Create(Application.MainForm);
   RELSUserComments.DOMVendor := GetDomVendor('MSXML');
   UserCmntStr := RELSExporter.ReadRELSUserCommentsFromReport(doc);
   RELSUserComments.LoadFromXML(UserCmntStr);
   ResponseGrp := GetRESPONSE_GROUP(RELSUserComments);
   if Assigned(ResponseGrp) then
    try
     CommentaryAddendum := ResponseGrp.RESPONSE.RESPONSE_DATA.RELS_VALIDATION_RESPONSE.RELS_COMMENTARY_ADDENDUM;
     // Note: Removed ...and (CommentaryAddendum.Rebuild = 'Y')... per Shashi email 7/23/13 11:46 AM
     // if Assigned(CommentaryAddendum) and CommentaryAddendum.HasAttribute(attrRebuild) and (CommentaryAddendum.Rebuild = 'Y') and CommentaryAddendum.HasChildNodes then
     if Assigned(CommentaryAddendum) and CommentaryAddendum.HasAttribute(attrRebuild) and CommentaryAddendum.HasChildNodes then
      begin
       // SECTION node processing
       SecQty := CommentaryAddendum.Count;
       for SecIdx := 0 to Pred(SecQty) do
        begin
         SecNode := CommentaryAddendum.SECTION[SecIdx];
         if Assigned(SecNode) then
          with SecNode do
           begin
            // MAIN_RULE node processing
            MainQty := SecNode.Count;
            for MainIdx := 0 to Pred(MainQty) do
             begin
              MainNode := SecNode.MAIN_RULE[MainIdx];
              if Assigned(MainNode) then
               with MainNode do
                begin
                 // COMMENTARY_RULE node processing
                 RuleQty := MainNode.Count;
                 for RuleIdx := 0 to Pred(RuleQty) do
                  begin
                   RuleNode := MainNode.COMMENTARY_RULE[RuleIdx];
                   if Assigned(RuleNode) then
                    begin
                     Comment :=  AElement.AddElement('COMMENT', ['AppraisalAddendumTextIdentifier', RuleNode.Id]);
                     if Trim(RuleNode.AppraiserResponse) = '' then
                      Comment.AttributeValues['AppraisalAddendumText'] := ' '
                     else 
                      Comment.AttributeValues['AppraisalAddendumText'] := XMLCodesToStr(RuleNode.AppraiserResponse);
                    end;
                  end; // End COMMENTARY_RULE node processing
                end;
             end; // End MAIN_RULE node processing
           end;
        end; // End SECTION node processing
      end; // End CommentaryAddendum processing
    except
    end;
  finally
   RELSUserComments.Free;
  end;
end;

procedure ExportFormAddendumText(doc: TContainer; AForm: TDocForm; AElement: TXMLElement);
var
  Comment: TXMLElement;
begin
  if length(AForm.GetCellTextByXID_MISMO(1218))>0 then    //there are generic additional comments
    begin
      Comment :=  AElement.AddElement('COMMENT', ['AppraisalAddendumTextIdentifier', 'Additional']);
      Comment.AttributeValues['AppraisalAddendumText'] := AForm.GetCellTextByXID_MISMO(1218);
    end;

  if length(AForm.GetCellTextByXID_MISMO(cAMCValCmntsCellID)) > 0 then    //there are commentary or validation comments
    begin
     ExportRELSCommentsToXML(doc, AElement);
    end;

  if length(AForm.GetCellTextByXID_MISMO(2727))>0 then    //there are additional sales comments
    begin
      Comment :=  AElement.AddElement('COMMENT', ['AppraisalAddendumTextIdentifier', 'Sales']);
      Comment.AttributeValues['AppraisalAddendumText'] := AForm.GetCellTextByXID_MISMO(2727);
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

  if length(AForm.GetCellTextByXID_MISMO(4250))>0 then    //there are additional USPAP comments
    begin
      Comment :=  AElement.AddElement('COMMENT', ['AppraisalAddendumTextIdentifier', 'DisclosureComment']);
      Comment.AttributeValues['AppraisalAddendumText'] := AForm.GetCellTextByXID_MISMO(4250);
    end;

  if length(AForm.GetCellTextByXID_MISMO(4251))>0 then    //there ia a USPAP scope of work declaration
    begin
      Comment :=  AElement.AddElement('COMMENT', ['AppraisalAddendumTextIdentifier', 'ScopeOfWork']);
      Comment.AttributeValues['AppraisalAddendumText'] := 'SelfContained';
    end;

  if length(AForm.GetCellTextByXID_MISMO(4252))>0 then    //there ia a USPAP scope of work declaration
    begin
      Comment :=  AElement.AddElement('COMMENT', ['AppraisalAddendumTextIdentifier', 'ScopeOfWork']);
      Comment.AttributeValues['AppraisalAddendumText'] := 'Summary';
    end;

  if length(AForm.GetCellTextByXID_MISMO(4253))>0 then    //there ia a USPAP scope of work declaration
    begin
      Comment :=  AElement.AddElement('COMMENT', ['AppraisalAddendumTextIdentifier', 'ScopeOfWork']);
      Comment.AttributeValues['AppraisalAddendumText'] := 'RestrictedUse';
    end;

  if length(AForm.GetCellTextByXID_MISMO(4254))>0 then    //there ia a USPAP services performed declaration
    begin
      Comment :=  AElement.AddElement('COMMENT', ['AppraisalAddendumTextIdentifier', 'PriorServicesPerformed']);
      Comment.AttributeValues['AppraisalAddendumText'] := 'N';
    end;

  if length(AForm.GetCellTextByXID_MISMO(4255))>0 then    //there ia a USPAP services performed declaration
    begin
      Comment :=  AElement.AddElement('COMMENT', ['AppraisalAddendumTextIdentifier', 'PriorServicesPerformed']);
      Comment.AttributeValues['AppraisalAddendumText'] := 'Y';
    end;

  if length(AForm.GetCellTextByXID_MISMO(4257))>0 then    //there ia a USPAP resonable exposure time declaration
    begin
      Comment :=  AElement.AddElement('COMMENT', ['AppraisalAddendumTextIdentifier', 'ReasonableExposureTime']);
      Comment.AttributeValues['AppraisalAddendumText'] := AForm.GetCellTextByXID_MISMO(4257);
    end;

(*
  if length(AForm.GetCellTextByXID_MISMO(1676))>0 then    //there are additional rental comments
    begin
      Comment :=  AElement.AddElement('COMMENT', ['AppraisalAddendumTextIdentifier', 'ComparableTimeAdjustment']);
      Comment.AttributeValues['AppraisalAddendumText'] := AForm.GetCellTextByXID_MISMO(1676);
    end;
*)
end;

procedure ExportReportFormList(doc: TContainer; ATranslator: TMISMOTranslator; ExportList: BooleanArray; ErrList: TObjectList);
var
  f,SeqNo, formUID: Integer;
  ThisForm: TDocForm;
  FormType, OtherDesc, FormXPath: String;
  FormIdentifier: String;
  IsPrimary: Boolean;
  ThisElement: TXMLElement;
  FormTypeCounter: TStringList;
  CommentaryCell: TBaseCell;
  CommentaryExported: Boolean;

  //is this form on the list to be exported?
  function ExportThisForm(n: Integer; ExpFormList: BooleanArray): Boolean;
  begin
    if not assigned(ExpFormList) then
      result := True
    else
      result := ExpFormList[n];
  end;

  //Change the form identifier (FNMA 1004 --> FNM1004) if it's one of the four specified by MISMO
  function GetUADFormName(FormID: Integer; FormName: String): String;
  const
    Prefix = 'UAD';
  begin
    case FormID of
      340, 4218, 4365: Result := Prefix + 'FNM1004';
      344: Result := 'FNM1004D';
      345: Result := Prefix + 'FNM1073';
      347: Result := Prefix + 'FNM1075';
      355: Result := Prefix + 'FNM2055';
    else
      result := FormName;
    end;  
  end;

begin
  //setup the generic form counter
  FormTypeCounter := TStringList.create;
  FormTypeCounter.Duplicates := dupIgnore;
  
  try
    SeqNo := 1;
    IsPrimary := False;
    CommentaryExported := False;
    if assigned(doc) then
      if ATranslator.FindMapping(FORM_ID, FormXPath) then           //gets XPath for REPORT/FORM
      begin
        for f := 0 to doc.docForm.count-1 do
          if ExportThisForm(f, ExportList) then
            begin
              ThisForm := doc.docForm[f];
              formUID := ThisForm.frmInfo.fFormUID;
              CommentaryCell := ThisForm.GetCellByID(cAMCValCmntsCellID);
              if (not (Assigned(CommentaryCell) and CommentaryExported)) then
                begin

                  ThisElement := ATranslator.XML.AddElement(FormXPath); //REPORT/FORM
                  ThisElement.AttributeValues['AppraisalReportContentSequenceIdentifier'] := IntToStr(SeqNo);

                  //classify the form
                  FormType := GetReportFormType(ThisForm, OtherDesc);
                  ThisElement.AttributeValues['AppraisalReportContentType'] := FormType;
                  if FormType = 'Other' then
                    ThisElement.AttributeValues['AppraisalReportContentTypeOtherDescription'] := OtherDesc;
                  ThisElement.AttributeValues['AppraisalReportContentName'] := GetReportFormName(ThisForm);

                  //Set Industry Standard Identifier
                  FormIdentifier := GetIndustryFormIdentifier(FormType, formUID, FormTypeCounter, False);

                  //Set the IsPrimaryForm Indicator
                  if not IsPrimary then  //if primary has not been found...
                    begin
                      IsPrimary := IsPrimaryAppraisalForm(formUID);
                      if IsPrimary then
                        begin
                          if doc.UADEnabled then
                            FormIdentifier := GetUADFormName(formUID, thisForm.frmInfo.fFormName);
                          ThisElement.AttributeValues['AppraisalReportContentIsPrimaryFormIndicator'] := 'Y';
                        end
                      else
                        ThisElement.AttributeValues['AppraisalReportContentIsPrimaryFormIndicator'] := 'N';
                    end
                  else //primary has been located, all other forms are not primary
                    ThisElement.AttributeValues['AppraisalReportContentIsPrimaryFormIndicator'] := 'N';
                  ThisElement.AttributeValues['AppraisalReportContentIdentifier'] := FormIdentifier;

                  // This attribute is in case we have additional descriptive data - we do not
                  {ThisElement.AttributeValues['AppraisalReportContentDescription'] := ThisForm.frmInfo.fFormKindName;}

                  //Export "Additional" Comment Text on the Form
                  ExportFormAddendumText(doc, ThisForm, ThisElement);
                  //CommentaryExported := Assigned(CommentaryCell);  // non commentary cell set it to false
                  if assigned(CommentaryCell) then   //count only for commentary cell
                    CommentaryExported := true;

                  //does this form have a signature, dates, inspection, license cells for appraiser, super, reviewer
                  ExportFormSigners(doc, ThisForm, ThisElement, ErrList);    //"ThisElement" is the FORM element for ThisForm

                  ExportFormImages(doc, ThisForm, ThisElement, ErrList);    //Export IMAGE element if has image cell
                end;
              inc(SeqNo);
            end;
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
procedure ExportSalesContractConsessions(doc: TContainer; exportForm: BooleanArray; ATranslator: TMISMOTranslator);
var
  Counter: Integer;
  SalesComissionText: String;
  SalesComissionAmt: String;
begin
  SalesComissionAmt := '';
  SalesComissionText := doc.GetCellTextByXID_MISMO(2057, exportForm);               //get description
  SalesComissionAmt := GetFirstNumInStr(SalesComissionText, False, Counter);  //parse and get first value
  if Length(SalesComissionAmt) > 0 then
    ATranslator.ExportValue(2642, SalesComissionAmt);
end;


procedure ExportTableCells(AContainer: TContainer; ATableType: Integer; ErrList: TObjectList;
  ATranslator: TMISMOTranslator; var ListCompOffset: Integer);
// Version 7.2.8 083110 JWyatt The FormAssocFile and related variables and code are included
//  to address unique XML addresses assigned to form ID 794. This was discussed in a meeting
//  today and it was agreed that this code should be revised to use only XML IDs in the next
//  release.
const
  cFormAssocFolder = 'Converters\FormAssociations\';    //where form photo association maps are kept
  MaxAdjID = 7;
  StdAdjID: array[1..MaxAdjID] of Integer = (947,954,1052,1053,1054,1682,1683);  //standard form: 1027, 1004, 1075
  //XID 1259: MarketAdjustedMonthlyRentAmount, 1256:Net adjustment value, 1257: RentTotalAdjustmentPositiveIndicator, 1258: RentTotalAdjustmentNegativeIndicator
  RentalAdjID : array[1..MaxAdjID] of Integer = (0,1259,1256,1257,1258,0,0);  //keep the same array as the standard
  REOAdjID : array[1..MaxAdjID] of Integer = (0,4073,4072,4070,4071,0,0);  //keep the same array as the standard
var
  SubColumnCounter, RowCounter, ColCounter, ColIdx : Integer;
  ThisGridManager : TGridMgr;
  ThisCell: TBaseCell;
  ThisCellXID,ThisCellNo : Integer;
  ThisCellText : string;
  ThisColumn : TCompColumn;
  Err: TComplianceError;
  NetAdjValue: Double;
  NetPct, GrossPct: String;
  AdjIDs: array[1..7] of Integer;
  AdjIDCount, FormIDHldr: Integer;
  FormAssocFile: TMemIniFile;
  AssocFilePath, FormSection: String;
  ListAsSale, Continue: Boolean;
begin
  ListAsSale := False;
  FormIDHldr := 0;
  ThisGridManager := TGridMgr.Create;
  try
    // Set the std adjustment cell IDs in case the SalesAdjMap.txt file does not exist
    for AdjIDCount := 1 to MaxAdjID do
      AdjIDs[AdjIDCount] := StdAdjID[AdjIDCount];

    ThisGridManager.BuildGrid(AContainer, ATableType);

    for ColCounter := 0 to ThisGridManager.Count - 1 do     //  ThisGridManager is a TObjectList of TCompColumns
      begin
        ThisColumn := ThisGridManager.Comp[ColCounter];
        if assigned(ThisColumn) then
          begin
            // Check the current form ID and reset the adjustment IDs if necessary
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
                        AdjIDs[AdjIDCount] :=
                          FormAssocFile.ReadInteger(FormSection, 'ID' + IntToStr(AdjIDCount), StdAdjID[AdjIDCount]);
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

            for RowCounter := 0 to ThisColumn.RowCount - 1 do
              begin
                for SubColumnCounter := 0 to 1 do
                  begin
                    ThisCellText := '';
                    ThisCellXID := 0;
                    ThisCellNo := ThisColumn.GetCellNumber(Point(SubColumnCounter,RowCounter));
                    ThisCell := ThisColumn.GetCellByCoord(Point(SubColumnCounter,RowCounter));
                    if assigned(ThisCell) then
                      begin
                        ThisCellXID := ThisCell.FCellXID;      //ThisColumn.GetCellIDByCoord(Point(SubColumnCounter,RowCounter));
                        ThisCellText := ThisCell.GetText;     //ThisColumn.GetCellTextByCoord(Point(SubColumnCounter,RowCounter));
                      end;
                    case FormIDHldr of  //need special handling
                      4140: //Clear Capital Appraisal Desktop
                        //take in account halfBathRoomCount Be sure half halfBathRoomCount did not include in XML Map file
                        if ThisCellXID = cCompBathRooms then
                          ThisCellText := GetBathRoomCount(thisColumn,thisCellXID);
                    end;
                    if (ThisCellText <> '') and (ThisCellXID > 0) then
                      try
                        ATranslator.ExportValue(ThisCellXID,'',IntToStr(ColIdx),ThisCellText);
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
                          end;
                      end;
                  end;
              end;

           //For Sales Tables get the last items in the column
            Continue := False; 
            if ((ATableType = ttSales) and (ColCounter > 0)) then Continue := true
            else if ((ATableType = ttRentals) and (ColCounter > 0)) then Continue := true
            else if (ATableType = ttListings) and (ColCounter > 0) then
            begin
                if ListAsSale then Continue := true
                else
                  case FormIDHldr of
                    fmREO2008,fmREO2008XLists: Continue := true;
                  end;
            end;
            if Continue then
              begin
                if ThisColumn.HasAdjSalesPriceCell and ThisColumn.HasNetAdjustmentCell (*or (ATableType=ttRentals)*) then
                  begin
                      if aTableType = ttRentals then
                        //set up rental adjustment array
                        for AdjIDCount := 1 to MaxAdjID do
                            AdjIDs[AdjIDCount] := RentalAdjID[AdjIDCount];
                      if FormIDHldr = fmREO2008 then
                        //set up REO adjustment array
                        for AdjIDCount := 1 to MaxAdjID do
                             AdjIDs[AdjIDCount] := REOAdjID[AdjIDCount];

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
                    if Adjids[6]<>0 then //only fill in if array #6 has # in it, this is for sales/listing but not for rental
                       ATranslator.ExportValue(AdjIDs[6],'',IntToStr(ColIdx), NetPct);      //net percent for comp
                    if Adjids[7]<>0 then //only fill in if array #7 has # in it, this is for sales/listing but not for rental
                       ATranslator.ExportValue(AdjIDs[7],'',IntToStr(ColIdx), GrossPct);    //gross percent for comp
                  end;
              end;
          end;
      end;
  finally
    ListCompOffset := ListCompOffset + Pred(ThisGridManager.Count);
    ThisGridManager.Free;
  end;
end;
(*
   if ThisColumn.Photo <> nil then
   begin
       if ThisColumn.Photo.Cell <> nil then
       begin
           ThisElement :=
               ATranslator.ExportTag(COMPARABLE_IMAGE_CELLID, COMPARABLE_NAMES[ThisComparableType]);

           ThisElement.AttributeValues['_Type'] := TABLE_PHOTO_NAMES[ATableType];

           ThisElement.AttributeValues['_FirstCaptionText'] :=
               COMPARABLE_TITLES[ATableType, ThisComparableType];

           if ThisColumn.Photo.Address[0] <> '' then
           begin
               ThisElement.AttributeValues['_SecondCaptionText'] := ThisColumn.Photo.Address[0];
               if ThisColumn.Photo.Address[1] <> '' then
                   ThisElement.AttributeValues['_ThirdCaptionText'] := ThisColumn.Photo.Address[1];
           end;

           //             imtUnknown because COMPARABLE_IMAGE_CELLID does not have a _Type attribute
           ExportGraphicCell(ThisColumn.Photo.Cell, ThisElement, imtUnknown, ThisComparableType);
           ThisElement.AttributeValues['_Identifier'] :=
               IntToStr(TDocForm(TDocPage(ThisColumn.Photo.Cell.FParentPage).FParentForm).frmInfo.fFormUID);
       end;
   end;
end;
{$IFDEF DEBUG}
           Delete(CellIDList, 1, 2);
           ATranslator.ExportDebugMessage(COMPARABLE_TYPE_NAMES[ATableType] + ' table CellID '' s found : ' + CellIDList);
{$ENDIF}
       finally
           ThisGridManager.Free;
       end;
   end;
*)


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
end;    }

                     
function CheckForFileName(var AFileName: String): Boolean;
var
  SaveFile: TSaveDialog;
begin
  if (length(AFileName) > 0) then
    begin
      if FileExists(AFileName) then
        DeleteFile(AFileName);
      result := true;
    end
  else begin
    result := False;
    SaveFile := TSaveDialog.Create(nil);
    try
      SaveFile.Title := 'Specify a file name for the XML Report';
      saveFile.InitialDir := appPref_DirLastMISMOSave;
      SaveFile.DefaultExt := 'xml';
      SaveFile.Filter := 'XML File(.xml)|*.xml';
      SaveFile.FilterIndex := 1;
      SaveFile.Options := SaveFile.Options + [ofOverwritePrompt];
      if SaveFile.Execute then
        begin
          AFileName := SaveFile.FileName;
          appPref_DirLastMISMOSave := ExtractFilePath(AFileName);
          result := True;
        end;
    finally
      SaveFile.Free;
    end;
  end;
end;

procedure SaveAsAppraisalXMLReport(AContainer: TContainer; AFileName: string);
begin
  SaveAsAppraisalXMLReport(AContainer, nil, AFileName);
end;

procedure SaveAsAppraisalXMLReport(AContainer: TContainer; ExportForm: BooleanArray; AFileName: string);
begin
  SaveAsAppraisalXMLReport(AContainer, ExportForm, AFileName, nil);
end;

procedure SaveAsAppraisalXMLReport(AContainer: TContainer;  ExportForm: BooleanArray; AFileName: string; Info: TMiscInfo; AMCVer: String='');
begin
  if CheckForFileName(AFileName) then
    if IsXMLSetup then
      uWindowsInfo.WriteFile(AFileName, ComposeAppraisalXMLReport(AContainer, ExportForm, Info, nil, AMCVer))
    else
      ShowAlert(atStopAlert, 'There was a problem creating the XML file, ' + ExtractFileName(AFileName) + '.');
end;

function ComposeAppraisalXMLReport(AContainer: TContainer; ExportForm: BooleanArray; Info: TMiscInfo; ErrList: TObjectList; AMCVer: String=''): string;
var
  FormCounter, PageCounter, CellCounter, ThisIndex, ListCompOffset : Integer;
  ThisPage: TDocPage;
  ThisCell: TBaseCell;
  ThisTranslator: TMISMOTranslator;
  ExportedCell: TExportedList;
  Err: TComplianceError;
//  ThisElement: TXMLElement;
  ThisForm: TdocForm;
  Counter: Integer;
  DividedCellContent: TStringList;
  exportThisForm: Boolean;

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

begin
  Result := '';
  if Assigned(AContainer.docEditor) and (AContainer.docEditor is TEditor) then
    (AContainer.docEditor as TEditor).SaveChanges;
  AContainer.ProcessCurCell(True);                    //get the latest text

  SetupMISMO;                                         //set the file paths
  ThisTranslator := TMISMOTranslator.Create;          //create the export translator
  DividedCellContent := TStringList.Create;
  ExportedCell := TExportedList.Create(AContainer, CountReportCells(AContainer));   //set the list for exported cell IDs

  //make sure we have a container
  if assigned(AContainer) then
  try
    try
      ThisTranslator.RaiseComplianceError := assigned(ErrList);   //do we save the complliance errors
      ThisTranslator.OnExport := ExportedCell.StoreID;            //save cell id on export into ExportList

      //first checkpoint - do we have a translator with a map
      if not assigned(ThisTranslator.Mappings) then
        raise Exception.Create('Problems were encountered with the MISMO Data. The XML file could not be created.');

//    ThisTranslator.BeginExport(stAppraisalResponse);
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
      ExportReportAttributes(AContainer, ExportForm, ThisTranslator, Info);
      ExportReportFormList(AContainer, ThisTranslator, ExportForm, ErrList);
      ExportReportEmbededPDF(AContainer, ThisTranslator, Info);
      ExportReportEmbededXML(AContainer, ThisTranslator, IncludeTrailingPathDelimiter(appPref_DirUADXMLFiles) + RELSMismoXml, AMCVer);
      ExportReportEmbededENV(AContainer,ThisTranslator,Info);
      ExportReportPartiesParsedAddess(AContainer, ExportForm, ThisTranslator);
      ExportSalesContractConsessions(AContainer, ExportForm, ThisTranslator); //special so we don't have to add cells to all forms


      ListCompOffset := 0;
      ExportTableCells(AContainer, ttSales, ErrList, ThisTranslator, ListCompOffset);             //export the Sales Comp Grid
      ExportTableCells(AContainer, ttListings , ErrList, ThisTranslator, ListCompOffset);         //export the Listing Comp Grid
      ListCompOffset := 0;
      ExportTableCells(AContainer, ttRentals , ErrList, ThisTranslator, ListCompOffset);          //export the Rental Comp Grid

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
                          if (not ThisCell.FEmptyCell)                                    //nothing to export
                              and (ThisCell.FCellXID <> 0) and                             //has an XPath
                              not (ThisCell is TGraphicCell) and                          //not a graphical cell
                              not ExportedCell.HasBeenExported(ThisCell.FCellXID) then    //not already exported
                            try
                              //exclude these cells - handled in special way
                              case ThisCell.FCellXID of
                                2731:
                                  HandleDividedCells;   //  Instructions to the appraiser on Land form

                                //  already exported above in Photo, Map, or Sketch addemdums
                                // Version 7.2.7 JWyatt Add declarations for IDs 2870-2881 used
                                //  on the Subject Interior Photos form (ID 919).
                                // Version 7.2.8 JWyatt Add declarations for IDs 2882-2887 used
                                //  on the Untitled Subject Interior Photos form (ID 936).
                                1157, 1158, 5076, 1205..1213, 1163..1168, 2617..2642, 2870..2887 :
                                  Continue;

                                //Signer - Appraiser - already exported
                                5,7,1684,9,10,11,12,13,14,15,16,17,18,19,20,21,5008,2098,
                                2096,2097,1149,1150,1151,2009,1660,1678:
                                  Continue;

                                //Signer - Reviewer - already exported
                                1402,1403,1666,1499,1504,1505,1506,1728,1507,1508,1509,
                                1510,1511,1512,1513,1514,1517,1518,1520,1521,
                                1522,1523,1524,1658,1729,1730:
                                  Continue;

                                //Signer - Supervisor - already exported
                                6,22,23,24,42,25,26,27,276,277,5018,2099,28,29,30,32,33,
                                1152,1153,1154,2008,1155,1156,2100,1679:
                                  Continue;

                                //general comments & special XComp comments
                                1218,2729,2727,1676:
                                  Continue;

                                CELL_PGNUM_XID:  // do not export these cells
                                  Continue;

                              else //case
                                begin
                                  try
                                   ThisTranslator.ExportValue(ThisCell.FCellXID, ThisCell.Text);

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
                                    //while debugging show the errors that are raised
                                    on E: Exception do
                                      begin
                                        if False then ShowNotice(E.Message);
  //                                    SaveMISMODataFormatLog(Format('  Format exception %s , cell # %d on page %d of form %s (%d):  "%s" does not comply with format. ',
  //                                     [ E.Message,CellCounter, PageCounter + 1,
  //                                     ThisForm.frmInfo.fFormName, ThisForm.FormID, ThisCell.Text]));
                                      end;
                                  end;
                                end;
                              end; //case

                            except
                              on E : Exception do
                                begin
          {$IFDEF DEBUG}
                                  ThisTranslator.XML.SaveToFile(
                                      uWindowsInfo.GetUnusedFileName('MISMO Translator Error Dump.xml'));

                                  ThisTranslator.ExportDebugMessage(
                                         Format('Error exporting Cell ID %d with a value of "%s" from cell # %d on page %d of form %s (%d): %s ',
                                         [ThisCell.FCellXID, ThisCell.Text, CellCounter, PageCounter + 1,
                                         ThisForm.frmInfo.FFormName, ThisForm.FormID, E.Message]));
          {$ELSE}
                                  raise;
          {$ENDIF}
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
      Result := ThisTranslator.EndExport;
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



///////////////////////////////////////        IMPORT      ////////////////////////////////////////////

function CreateNewContainerFromReport(const AFileName : string) : TContainer;
var
   ThisXML : TXMLCollection;
begin
   uWindowsInfo.PushMouseCursor;
   ThisXML := TXMLCollection.Create;
   try
       ThisXML.LoadFromFile(AFileName);

       Result := Main.NewEmptyContainer;
       AddPagesFromXML(ThisXML, Result);
       Application.ProcessMessages;                        //  let it show

       AddXMLDataToDocument(Result, ThisXML, True);
   finally
       ThisXML.Free;
       uWindowsInfo.PopMouseCursor;
   end;
end;

const
   ORDER_ID_RESOURCE_NUMBER = 53500;

function CreateNewContainerFromOrderFile(const AFileName : string) : TContainer;
begin
  uWindowsInfo.PushMouseCursor;
  try
    Result := CreateNewContainerFromOrder(uWindowsInfo.FileText(AFileName));
  finally
    uWindowsInfo.PopMouseCursor;
  end;
end;

function CreateNewContainerFromOrder(const AnOrderText : string) : TContainer;
var
   ThisXML : TXMLCollection;
   ThisFormUID : TFormUID;
begin
   uWindowsInfo.PushMouseCursor;
   ThisXML := TXMLCollection.Create;
   try
       ThisXML.AsString := AnOrderText;

       Result := Main.NewEmptyContainer;
       SetMISMORequestXMLText(Result, AnOrderText);        //  store the original XML inside the document file

       ThisFormUID := TFormUID.Create(ORDER_FORM_ID);
       try
           if uActiveForms.ActiveFormsMgr.GetFormDefinition(ThisFormUID) = nil then
               raise Exception.Create('Appraisal Order Form missing');

           Result.InsertFormUID(ThisFormUID, True, -1);    //     insert the forms, show expanded
       finally
           ThisFormUID.Free;
       end;

       with Result.docForm[0].frmPage[0] do
       begin
//           FindButton(ORDER_SCHEDULED_BUTTON_ID).Enabled := False;
//           FindButton(ORDER_INSPECTED_BUTTON_ID).Enabled := False;
//           FindButton(ORDER_COMPLETED_BUTTON_ID).Enabled := False;
       end;

       AddXMLDataToDocument(Result, ThisXML, True);

//       if ThisXML.FindXPath(UMISMOImportExport.GetTagXPath(ORDER_ID_RESOURCE_NUMBER), ThisElement) then
//           SetAppraisalWorldOrderID(Result, StrToIntDef(ThisElement.AttributeValues['_Value'], 0));

       Result.Invalidate;
   finally
       ThisXML.Free;
       uWindowsInfo.PopMouseCursor;
   end;
end;

function CreateNewContainerFromXML(AnXML : TXMLCollection) : TContainer;
begin
  Result := Main.NewEmptyContainer;
  AddPagesFromXML(AnXML, Result);
end;

procedure AddPagesFromXML(AnXML : TXMLCollection; AContainer : TContainer);
// routines in this procedure
//    procedure AddMissingForms
//    function AddAddendumFromXML
//    function AddFormFromXML

   procedure AddMissingForms(ThisElementList : IXMLElementList);
   begin
       { TODO : Find any forms that have a Cert section (i.e. Part 2) and make sure it is present. }
         { TODO : If SequenceIdentifier is missing, put the XComps just after the forms }
   end;

   function AddAddendumFromXML(AnXMLElement : TXMLElement; AContainer : TContainer) : TDocForm;
   var
       ThisFormUID : TFormUID;
       ThisFormID : Integer;
       ThisFormTag : string;
   begin
       Result := nil;

       if ('//' + AnXMLElement.Name <> ADDENDUM_ELEMENT_NAME) then
           raise Exception.Create('XML element name is ' + AnXMLElement.Name + ' instead of ' + ADDENDUM_ELEMENT_NAME);

       if AnXMLElement.XMLCollection.XPathAttribute('//REPORT/@AppraisalSoftwareProductName') = ClickFormsName then
       begin
           ThisFormID := StrToIntDef(AnXMLElement.AttributeValues['_Identifier'], -1);
           try
               ThisFormUID := TFormUID.Create(ThisFormID);
               try
                   Result := AContainer.InsertBlankUID(ThisFormUID, True, -1); //     insert the forms, show expanded
                   Exit;
               finally
                   ThisFormUID.Free;
               end;
           except
               //      didn't work: try looking up the name
           end;
       end;

       ThisFormTag := AnXMLElement.AttributeValues['_Type'];
       if ThisFormTag = OTHER_TAG then
           ThisFormTag := AnXMLElement.AttributeValues['_TypeOtherDescription'];

       if ThisFormTag = 'PropertySketch' then
           // V6.9.9 modified 102709 JWyatt to change use of the DEFAULT_PROPERTY_SKETCH_FORMID
           //  constant to the global variable cSkFormLegalUID.
           // ThisFormID := DEFAULT_PROPERTY_SKETCH_FORMID
           ThisFormID := cSkFormLegalUID
       else if ThisFormTag = 'LocationMap' then
           ThisFormID := DEFAULT_LOCATION_MAP_FORMID
       else if ThisFormTag = 'PlatMap' then
           ThisFormID := DEFAULT_PLAT_MAP_FORMID
       else if ThisFormTag = 'FloodMap' then
           ThisFormID := DEFAULT_FLOOD_MAP_FORMID
       else if ThisFormTag = 'SubjectPhotos' then
           ThisFormID := DEFAULT_SUBJECT_PHOTOS_FORMID
       else if ThisFormTag = 'Map' then
           ThisFormID := DEFAULT_MAP_FORMID
       else if ThisFormTag = 'Photos' then
           ThisFormID := DEFAULT_PHOTOS_FORMID
       else if ThisFormTag = 'AdditionalComments' then
           ThisFormID := DEFAULT_COMMENTS_FORMID
       else if ThisFormTag = 'Signature' then
           ThisFormID := DEFAULT_SIGNATURE_FORMID          {TODO: what do I do with this?  }
       else if ThisFormTag = 'Invoice' then
           ThisFormID := DEFAULT_INVOICE_FORMID
       else if ThisFormTag = 'ComparableSalePhotos' then
           ThisFormID := COMPARABLE_SALE_PHOTOS_FORMID
       else if ThisFormTag = 'ComparableListingPhotos' then
           ThisFormID := COMPARABLE_LISTING_PHOTOS_FORMID
       else if ThisFormTag = 'ComparableRentalPhotos' then
           ThisFormID := COMPARABLE_RENTAL_PHOTOS_FORMID
       else
           Exit;                                           //      do nothing      raise Exception.Create('Unrecognized form tag "' + ThisFormTag + '"');

       ThisFormUID := TFormUID.Create(ThisFormID);
       try
           Result := AContainer.InsertBlankUID(ThisFormUID, True, -1); //     insert the forms, show expanded
       finally
           ThisFormUID.Free;
       end;
   end;

   function AddFormFromXML(AnXMLElement : TXMLElement; AContainer : TContainer) : TDocForm;
   var
       ThisFormUID : TFormUID;
       ThisFormID, ThisIndex : Integer;
       ThisFormTag : string;
   begin
       Result := nil;

       if ('//' + AnXMLElement.Name <> FORM_ELEMENT_NAME) then
           raise Exception.Create('XML element name is ' + AnXMLElement.Name + ' instead of ' + FORM_ELEMENT_NAME);

       if AnXMLElement.XMLCollection.XPathAttribute('//REPORT/@AppraisalSoftwareProductName') = ClickFormsName then
       begin
           ThisFormID := StrToIntDef(AnXMLElement.AttributeValues['_Identifier'], -1);
           try
               ThisFormUID := TFormUID.Create(ThisFormID);
               try
                   Result := AContainer.InsertBlankUID(ThisFormUID, True, -1); //     insert the forms, show expanded
                   Exit;
               finally
                   ThisFormUID.Free;
               end;
           except
               //      didn't work: try looking up the name
           end;
       end;

       ThisFormTag := AnXMLElement.AttributeValues['AppraisalFormType'];
       if ThisFormTag = OTHER_TAG then
           ThisFormTag := AnXMLElement.AttributeValues['AppraisalFormTypeOtherDescription'];

       if AnXMLElement.AttributeValues['AppraisalFormVersionIdentifier'] <> EMPTY_STRING then
           ThisFormTag := ThisFormTag + '=' + AnXMLElement.AttributeValues['AppraisalFormVersionIdentifier']
       else
           ThisFormTag := ThisFormTag + '=';

       ThisIndex := FormTagIDList.IndexOf(ThisFormTag);
       if ThisIndex <> -1 then
       begin
           ThisFormID := Integer(FormTagIDList.Objects[ThisIndex]);

           ThisFormUID := TFormUID.Create(ThisFormID);
           try
               Result := AContainer.InsertBlankUID(ThisFormUID, True, -1); //     insert the forms, show expanded
           finally
               ThisFormUID.Free;
           end;
       end;
   end;

var
   FormElementList, AddendumElementList : IXMLElementList;
   ThisSequenceNumber, Counter : Integer;
   FormWasFound : Boolean;
begin
   FormElementList := AnXML.FindXPath(FORM_ELEMENT_NAME);  //  get all the matching elements
   AddendumElementList := AnXML.FindXPath(ADDENDUM_ELEMENT_NAME); //  get all the matching elements

   AddMissingForms(FormElementList);                       //  add the Certification compliments (e.g. page 4, 5 and 6)

   ThisSequenceNumber := 1;
   while (ThisSequenceNumber < 100) and (FormElementList.Count > 0) and (AddendumElementList.Count > 0) do
   begin
       FormWasFound := False;
       for Counter := 0 to FormElementList.Count - 1 do
       begin
           if FormElementList[Counter].AttributeValues['_SequenceIdentifier'] = IntToStr(ThisSequenceNumber) then
           begin
               AddFormFromXML(FormElementList[Counter], AContainer);
               FormElementList.Delete(Counter);
               FormWasFound := True;
               Break;
           end;
       end;

       if not FormWasFound then
       begin
           for Counter := 0 to AddendumElementList.Count - 1 do
           begin
               if AddendumElementList[Counter].AttributeValues['_SequenceIdentifier'] = IntToStr(ThisSequenceNumber) then
               begin
                   AddAddendumFromXML(AddendumElementList[Counter], AContainer);
                   AddendumElementList.Delete(Counter);
                   Break;
               end;
           end;
       end;

       Inc(ThisSequenceNumber);
   end;

   //         add any forms or addendums that did not have a _SequenceIdentifier
   for Counter := 0 to FormElementList.Count - 1 do
       AddFormFromXML(FormElementList[Counter], AContainer);

   for Counter := 0 to AddendumElementList.Count - 1 do
       AddAddendumFromXML(AddendumElementList[Counter], AContainer);
end;

procedure AddXMLDataToDocument(AContainer : TContainer; AnXML : TXMLCollection; AllForms :Boolean );
//these are the routines in this procedure
//   procedure ImportGraphicCell
//   function ImportSpecialForm
//   procedure ImportTableCells
//   procedure ImportPhotoCell

   procedure ImportGraphicCell(ACell : TGraphicCell; AnElement : TXMLElement; AnImageType : TImageType = imtPhoto);
   var
       TextStream : TStringStream;
       ThisStream : TMemoryStream;
       DecodedData : string;
       DocumentElement, DataElement : TXMLElement;
       StreamTypeHeader : string;
       StreamTypeHeaderLength : Byte;
       StreamLength : Longint;
       ImageFormat : TImageFormat;
   begin
    Try
       if AnElement.Name <> 'EMBEDDED_FILE' then
        begin
          with AnElement.FindXPath('//EMBEDDED_FILE') do
            begin
               if Count = 0 then
                 begin
                   raise Exception.Create('Cannot import into graphics cell ' +
                       IntToStr(ACell.FCellXID) + ' from the ' + AnElement.XPath +
                       ' element: no EMBEDDED_FILE child element');
                 end
               else
                 if Count > 1 then
                   begin
                     raise Exception.Create('Cannot import into graphics cell ' +
                       IntToStr(ACell.FCellXID) + ' from the ' + AnElement.XPath +
                       ' element: more than one EMBEDDED_FILE child element');
                   end
                 else
                   AnElement := Elements[0];
            end;
        end;

       if AnElement.AttributeValues['_EncodingType'] <> BASE64_ENCODING_TAG then
         begin
           raise Exception.Create('Cannot import into graphics cell ' +
               IntToStr(ACell.FCellXID) + ' from the ' + AnElement.XPath +
               ' element because it is not marked as Base64 encoded');
         end;

       ImageFormat := ExtensionToImageType(AnElement.AttributeValues['_Extension']);

       {TODO:    ACell.fImage.fILImageType := MimeToExtension(AttributeValues['MIMEType']);    }

       if not AnElement.FindElement('DOCUMENT', DocumentElement) then
         begin
           raise Exception.Create('Cannot import into graphics cell ' +
               IntToStr(ACell.FCellXID) + ' from the ' + AnElement.XPath +
               ' element: no DOCUMENT element');
         end;

       if DocumentElement.ElementCount = 0 then
         begin
           raise Exception.Create('Cannot import into graphics cell ' +
               IntToStr(ACell.FCellXID) + ' from the ' + AnElement.XPath +
               ' element: no child elements in the ./DOCUMENT element');
         end;

       if not DocumentElement.FirstElement([ecMarkedSection], DataElement) then
         begin
           raise Exception.Create('Cannot import into graphics cell ' +
               IntToStr(ACell.FCellXID) + ' from the ' + AnElement.XPath +
               ' element: no child Marked data element in the ./DOCUMENT element');
         end
       else
         begin
           DecodedData := UBase64.Base64Decode(DataElement.RawText);

           ThisStream := TMemoryStream.Create;
           TextStream := TStringStream.Create(DecodedData); //    maybe we could just use ThisStream.Memory and the Copy procedure, but this is clearer
           try
               Assert(ACell <> nil);
               //        re-create the header
               StreamTypeHeader := IMAGE_FORMAT_TAGS[ImageFormat];
               StreamTypeHeaderLength := Length(StreamTypeHeader);
               ThisStream.Write(StreamTypeHeaderLength, SizeOf(StreamTypeHeaderLength));
               ThisStream.Write(PChar(StreamTypeHeader)^, Length(StreamTypeHeader));

               StreamLength := Length(DecodedData);
               ThisStream.Write(StreamLength, SizeOf(StreamLength));

               ThisStream.CopyFrom(TextStream, 0);         //  0 = the whole thing

               ThisStream.Position := 0;
               ACell.fImage.LoadFromStream(ThisStream);
           finally
               TextStream.Free;
               ThisStream.Free;
           end;
         end;
    except
    end;
   end;

   procedure ImportPhotoCell(AForm : TdocForm; AnElement : TXMLElement;
       PhotoCellID : Integer; const CaptionCellID : array of Integer);
   var
       ThisCell : TBaseCell;
       CaptionCounter, CellCounter : Integer;
   begin
    Try
       ThisCell := AForm.GetCellByXID_MISMO(PhotoCellID);

       if ThisCell is TGraphicCell then                    //  this is False if ThisCell = nil
         begin
           TGraphicCell(ThisCell).Clear;

           ImportGraphicCell(TGraphicCell(ThisCell), AnElement);

           CaptionCounter := 0;
           CellCounter := Low(CaptionCellID);
           while (CellCounter <= High(CaptionCellID)) and (CaptionCounter < Length(IMAGE_CAPTION_ATTRIBUTE_NAMES)) do
             begin
               ThisCell := AForm.GetCellByXID_MISMO(CaptionCellID[CellCounter]);
               if ThisCell <> nil then
                 begin
                   ThisCell.Text := AnElement.AttributeValues[IMAGE_CAPTION_ATTRIBUTE_NAMES[CaptionCounter]];
                   Inc(CaptionCounter);
                 end;
               Inc(CellCounter);
             end;
         end;
    except
    end;     
   end;

   {Used by Rels to Import DAA Data Comparable into the Form no one els been use this procedure so far.}
   procedure ImportTableCells(ATableType : TComparableType; ACellList : TList; ThisTranslator : TMISMOTranslator);
   var
       ColCounter, Counter, ThisCompNumber : Integer;
       ThisGridManager : TGridMgr;
       ThisCellID : Integer;
       ThisCellText : string;
       ThisOtherDescription : string;
       ThisColumn : TCompColumn;
       ThisComparableType : TComparable;
       startValue : Integer;
       HasData : String;
   begin
{$IFDEF DEBUG}
       ThisCellText := '';
       for Counter := 0 to ACellList.Count - 1 do
           ThisCellText := ThisCellText + ', ' + IntToStr(Integer(ACellList.Items[Counter]));
       Delete(ThisCellText, 1, 2);                         //  remove leading comma
       uWindowsInfo.WriteFile(uWindowsInfo.GetUnusedFileName('ImportingGridCellIDs.txt'), ThisCellText);
{$ENDIF}
       ThisGridManager := TGridMgr.Create;
       try
          ThisGridManager.BuildGrid(AContainer, COMPARABLE_TYPE_INDEX[ATableType]);


          // Here we look into the Grid by Column
          // if False no subject, so we start in 1 , if is True yes Subject, so we start in 0.


           if AllForms then startValue := 0
           else startvalue := 1;

           for ColCounter := startvalue to ThisGridManager.Count - 1 do //  ThisGridManager is a TObjectList of TCompColumns
             begin
               Application.ProcessMessages;
               HasData :=''; // Clear Column before.
               ThisColumn := ThisGridManager.Comp[ColCounter];  // changes No Sbjetc
               ThisCompNumber := ThisColumn.CompNumber;
               Assert(ThisCompNumber <= MAX_COMPARABLE_COUNT, 'Column ' + IntToStr(ColCounter) +
               ' has an identifier of ' + IntToStr(ThisCompNumber));

               if ThisCompNumber = -1 then
                  ThisCompNumber := startvalue;

               if (ThisCompNumber >= Low(COMPARABLE_TYPES)) and (ThisCompNumber <= High(COMPARABLE_TYPES)) then
                   ThisComparableType := COMPARABLE_TYPES[ThisCompNumber]
               else
                   ThisComparableType := COMPARABLE_TYPES[10]; //  'Other'

               // Here we look into the cell inside of Column
               for Counter := 0 to ACellList.Count - 1 do  // AcellList Contemn XLM_Ids List.
                  begin
                    ThisCellID := Integer(ACellList.Items[Counter]);

                  if IsFalseGridCell(ThisCellID) then
                     ThisCellText := ThisTranslator.ImportValue(ThisCellID)
                  else
                     if ThisComparableType = cCompOther then  //925 is my Key who going to tell me if the Comp has Data or not.
                       begin
                          ThisOtherDescription := 'Comparable' + StringReplace(uCraftClass.FormatCamelCap(uCraftClass.DescribeCount(
                          ThisColumn.CompNumber)), ' ', '', [rfReplaceAll]);
                          //ThisCellText := ThisTranslator.ImportValue(ThisCellID, COMPARABLE_NAMES[ThisComparableType], ThisOtherDescription);
                          ThisCellText := ThisTranslator.ImportValue(ThisCellID, COMPARABLE_NAMES[ThisComparableType],IntToStr(ColCounter));
                          HasData := ThisTranslator.ImportValue(925, COMPARABLE_NAMES[ThisComparableType],inttostr(ColCounter));
                       end
                     else                                          //XMl_IDS
                       begin
                        ThisCellText := ThisTranslator.ImportValue(ThisCellID, COMPARABLE_NAMES[ThisComparableType],inttostr(ColCounter));
                        HasData := ThisTranslator.ImportValue(925, COMPARABLE_NAMES[ThisComparableType],inttostr(ColCounter));
                       end;
                     if appPref_RelsOverwriteImport then
                       begin
                           if HasData <> '' then
                            ThisColumn.SetCellTextByID(ThisCellID, ThisCellText); //    each column can have a different text}
                          { //if ThisCellText <> then
                            ThisColumn.SetCellTextByID(ThisCellID, ThisCellText); //    each column can have a different text}
                       end
                     else
                       begin
                         if ThisColumn.GetCellTextByID(ThisCellID) = '' then
                          begin
                           if ThisCellText <> '' then
                            ThisColumn.SetCellTextByID(ThisCellID, ThisCellText); //    each column can have a different text
                          end;
                       end;
                       if assigned(ThisColumn.Photo.Cell) then  //transfer address to photo pages
                             ThisColumn.FPhoto.AssignAddress;
                  end;
             end;
       finally
         ThisGridManager.Free;
       end;
   end;

   function ImportSpecialForm(AForm : TdocForm; ATranslator : TMISMOTranslator; var AnElement : TXMLElement; Special : Boolean) : Boolean;
   var
       ThisCell : TBaseCell;
   begin
       Result := True;                                     // set to False in case...else
       special := false;                                   // I set false manually to avoid possible errs
                                                           // just because i know Rels is not send any picture on XML File
     if Special = True then                                // No reason to looking For.
      begin

       case AForm.FormID of
           98 : ;

           //     Import map addendums
           101 :
               begin
                   AnElement := ATranslator.FindElement(LOCATION_MAP);
                   ImportGraphicCell(AForm.GetCellByXID_MISMO(1158) as TGraphicCell, AnElement.FindElement('_IMAGE'));
               end;

           102 :
               begin
                   AnElement := ATranslator.FindElement(FLOOD_MAP);
                   ImportGraphicCell(AForm.GetCellByXID_MISMO(1158) as TGraphicCell, AnElement.FindElement('_IMAGE')); { TODO : use the new cellid 2631 instead of 1158 }
               end;

           103 :
               begin
                   AnElement := ATranslator.FindElement(PLAT_MAP);
                   ImportGraphicCell(AForm.GetCellByXID_MISMO(1158) as TGraphicCell, AnElement.FindElement('_IMAGE')); { TODO : use the new cellid 2635 instead of 1158 }
               end;

           104, 108 :
               begin
                   AnElement := ATranslator.FindElement(OTHER_ADDENDUM, 'NeighborhoodMap');
                   ImportGraphicCell(AForm.GetCellByXID_MISMO(2630) as TGraphicCell, AnElement.FindElement('_IMAGE'));
               end;

           105 :
               begin
                   AnElement := ATranslator.FindElement(OTHER_ADDENDUM, 'LandSalesMap');
                   ImportGraphicCell(AForm.GetCellByXID_MISMO(2632) as TGraphicCell, AnElement.FindElement('_IMAGE'));
               end;

           106 :
               begin
                   AnElement := ATranslator.FindElement(OTHER_ADDENDUM, 'LandUseMap');
                   ImportGraphicCell(AForm.GetCellByXID_MISMO(2633) as TGraphicCell, AnElement.FindElement('_IMAGE'));
               end;

           107 :
               begin
                   AnElement := ATranslator.FindElement(OTHER_ADDENDUM, 'ListingsMap');
                   ImportGraphicCell(AForm.GetCellByXID_MISMO(2634) as TGraphicCell, AnElement.FindElement('_IMAGE'));
               end;

           109 :
               begin
                   AnElement := ATranslator.FindElement(OTHER_ADDENDUM, 'RegionalMap');
                   ImportGraphicCell(AForm.GetCellByXID_MISMO(2636) as TGraphicCell, AnElement.FindElement('_IMAGE'));
               end;

           110 :
               begin
                   AnElement := ATranslator.FindElement(OTHER_ADDENDUM, 'RentalMap');
                   ImportGraphicCell(AForm.GetCellByXID_MISMO(2637) as TGraphicCell, AnElement.FindElement('_IMAGE'));
               end;

           111 :
               begin
                   AnElement := ATranslator.FindElement(OTHER_ADDENDUM, 'SalesLocationsMap');
                   ImportGraphicCell(AForm.GetCellByXID_MISMO(2638) as TGraphicCell, AnElement.FindElement('_IMAGE'));
               end;

           112 :
               begin
                   AnElement := ATranslator.FindElement(OTHER_ADDENDUM, 'SiteLocationMap');
                   ImportGraphicCell(AForm.GetCellByXID_MISMO(2639) as TGraphicCell, AnElement.FindElement('_IMAGE'));
               end;

           113 :
               begin
                   AnElement := ATranslator.FindElement(OTHER_ADDENDUM, 'ZoningMap');
                   ImportGraphicCell(AForm.GetCellByXID_MISMO(2641) as TGraphicCell, AnElement.FindElement('_IMAGE'));
               end;

           117 :
               begin
                   AnElement := ATranslator.FindElement(OTHER_ADDENDUM, 'SurveyMap');
                   ImportGraphicCell(AForm.GetCellByXID_MISMO(2640) as TGraphicCell, AnElement.FindElement('_IMAGE'));
               end;

           118 :
               begin
                   AnElement := ATranslator.FindElement(PLAT_MAP);
                   ImportGraphicCell(AForm.GetCellByXID_MISMO(2635) as TGraphicCell, AnElement.FindElement('_IMAGE'));

                   ThisCell := AForm.GetCellByXID_MISMO(2642);
                   if ThisCell <> nil then
                       AnElement.AttributeValues['_Comment'] := ThisCell.Text;
               end;

           211 : AnElement := ATranslator.FindElement(OTHER_ADDENDUM, 'Appraisal cover sheet');

           212 :
               begin
                   AnElement := ATranslator.FindElement(OTHER_ADDENDUM, 'Appraisal cover sheet');
                   ThisCell := AForm.GetCellByXID_MISMO(COVER_PHOTO_CELLID);
                   if ThisCell = nil then
                       ThisCell := AForm.GetCell(1, 1);    //  page 1, cell 1
                   ImportGraphicCell(ThisCell as TGraphicCell, AnElement.FindElement('_IMAGE'), imtPhoto);
               end;

           220 : AnElement := ATranslator.FindElement(INVOICE);

           231 : AnElement := ATranslator.FindElement(OTHER_ADDENDUM, 'Table of Contents');

           198 : AnElement := ATranslator.FindElement(OTHER_ADDENDUM, 'Limited Certification');

           758 : AnElement := ATranslator.FindElement(OTHER_ADDENDUM, 'Limiting Conditions');

           //     Export sketch addendums

           201 :                                           //  Property Sketch
               begin
                   AnElement := ATranslator.FindElement(PROPERTY_SKETCH); //  //APPRAISAL/_REPORT/_ADDENDUM[@_Type="PropertySketch"]
                   Assert(AnElement <> nil);
                   ImportGraphicCell(AForm.GetCellByXID_MISMO(1157) as TGraphicCell,
                       AnElement, imtSketch);
               end;

           202 :                                           //  combined Sketch and Location Map
               begin
                   AnElement := ATranslator.FindElement(PROPERTY_SKETCH);
                   Assert(AnElement <> nil);
                   ImportGraphicCell(AForm.GetCellByXID_MISMO(1157) as TGraphicCell, AnElement, imtSketch);
                   ImportGraphicCell(AForm.GetCellByXID_MISMO(1158) as TGraphicCell, AnElement, imtMap);
               end;

           203, 204, 205 :                                 //  Property Sketch
               begin
                   AnElement := ATranslator.FindElement(PROPERTY_SKETCH);
                   Assert(AnElement <> nil);
                   ImportGraphicCell(AForm.GetCellByXID_MISMO(1157) as TGraphicCell, AnElement, imtSketch);
               end;

           //     Import photo addendums

           301, 311 :
               begin
                   AnElement := ATranslator.FindElement(SUBJECT_PHOTOS);
                   Assert(AnElement <> nil);
                   ImportPhotoCell(AForm, AnElement.FindElement('_IMAGE'), 1205, [925, 926]);
                   ImportPhotoCell(AForm, AnElement.FindElement('_IMAGE'), 1206, [2617, 2618]);
                   ImportPhotoCell(AForm, AnElement.FindElement('_IMAGE'), 1207, [2619, 2620]);
               end;

           302, 312 :
               begin
                   AnElement := ATranslator.FindElement(SUBJECT_PHOTOS);
                   Assert(AnElement <> nil);
                   ImportPhotoCell(AForm, AnElement.FindElement('_IMAGE'), 1208, [1211, 2621]);
                   ImportPhotoCell(AForm, AnElement.FindElement('_IMAGE'), 1209, [1212, 2622]);
                   ImportPhotoCell(AForm, AnElement.FindElement('_IMAGE'), 1210, [1213, 2623]);
               end;

           308, 318 :
               begin
                   AnElement := ATranslator.FindElement(MISC_PHOTOS);
                   Assert(AnElement <> nil);
                   ImportPhotoCell(AForm, AnElement.FindElement('_IMAGE'), 1222, [2624, 2625]);
                   ImportPhotoCell(AForm, AnElement.FindElement('_IMAGE'), 1223, [2626, 2627]);
                   ImportPhotoCell(AForm, AnElement.FindElement('_IMAGE'), 1224, [2628, 2629]);
               end;
           309 :
               begin
                   AnElement := ATranslator.FindElement(SUBJECT_PHOTOS);
                   Assert(AnElement <> nil);
                   ImportPhotoCell(AForm, AnElement.FindElement('_IMAGE'), 1205, [925, 926]);
               end;
           310, 320 :
               begin
                   AnElement := ATranslator.FindElement(SUBJECT_PHOTOS);
                   Assert(AnElement <> nil);
                   ImportPhotoCell(AForm, AnElement.FindElement('_IMAGE'), 1208, [1211, 2621]);
                   ImportPhotoCell(AForm, AnElement.FindElement('_IMAGE'), 1209, [1212, 2622]);
               end;
           319 :
               begin
                   AnElement := ATranslator.FindElement(SUBJECT_PHOTOS);
                   Assert(AnElement <> nil);
                   ImportPhotoCell(AForm, AnElement.FindElement('_IMAGE'), 1205, [925, 926]);
               end;

           321 :
               begin
                   AnElement := ATranslator.FindElement(SUBJECT_PHOTOS);
                   Assert(AnElement <> nil);
                   ImportPhotoCell(AForm, AnElement.FindElement('_IMAGE'), 1208, []);
                   ImportGraphicCell(AForm.GetCellByXID_MISMO(1158) as TGraphicCell, AnElement, imtMap);
               end;

           322, 323 :
               begin
                   AnElement := ATranslator.FindElement(SUBJECT_PHOTOS);
                   Assert(AnElement <> nil);
                   ImportPhotoCell(AForm, AnElement.FindElement('_IMAGE'), 1222, [2624]);
                   ImportPhotoCell(AForm, AnElement.FindElement('_IMAGE'), 1223, [2626]);
               end;

           304, 314 : AnElement := ATranslator.FindElement(COMPARABLE_SALE_PHOTOS);

           306, 316 : AnElement := ATranslator.FindElement(COMPARABLE_LISTING_PHOTOS);

           307, 317 : AnElement := ATranslator.FindElement(COMPARABLE_RENTAL_PHOTOS);
       else
           Result := False;
       end;

     end
    else
     begin
      result := False;
     end;
   end;

var
   FormCounter, PageCounter, CellCounter : Integer;
   ThisForm : TdocForm;
   ThisPage : TDocPage;
   ThisCell : TBaseCell;
   ThisTranslator : TMISMOTranslator;
   GridCellList : TList;
   ThisTableType : TComparableType;
   ThisElement : TXMLElement;
   ImportCellID : Integer;
   ImportCellIDOffset : Integer;
   ThisValue : string;
begin

   if AnXML.FindXPath('/REQUEST_GROUP', ThisElement) then
       ImportCellIDOffset := IMPORT_CELL_ID_OFFSET         //  when importing from REQUEST_GROUP packages, the mapping is different. We have a whole set of mapping above 50000 to handle this
   else
       ImportCellIDOffset := 0;

   GridCellList := TList.Create;
   ThisTranslator := TMISMOTranslator.Create;
   Try
      ThisTranslator.BeginImport(AnXML);
       Try
          For FormCounter := 0 to AContainer.docForm.Count - 1 do
           begin
             ThisForm := AContainer.docForm[FormCounter];

               if not ImportSpecialForm(ThisForm, ThisTranslator, ThisElement, AllForms ) then
                begin

                   for PageCounter := 0 to ThisForm.frmPage.Count - 1 do
                    begin
                       ThisPage := ThisForm.frmPage[PageCounter];
                       if ThisPage.pgData <> nil then
                        begin

                          for CellCounter := 0 to ThisPage.pgData.Count - 1 do
                           begin
                             ThisCell := ThisPage.pgData[CellCounter];
                             Application.ProcessMessages;
                             if ThisCell.FCellXID <> 0 then
                               begin
                                   // if cell belongs to Grid , save CllXML_ID into the List.
                                   if ((ThisCell is TGridCell) and (not IsFalseGridCell(ThisCell.FCellXID))) or
                                      ((ThisCell.FCellXID = GRID_NET_POSITIVE_CELLID) or
                                      (ThisCell.FCellXID = GRID_NET_NEGATIVE_CELLID)) then
                                      begin
                                        if GridCellList.IndexOf(Pointer(ThisCell.FCellXID)) = -1 then
                                           GridCellList.Add(Pointer(ThisCell.FCellXID));
                                       end
                                   else                                                   // if Yes = All Forms
                                   if AllForms then // Looking into all cell of Doc ?     // else = Only Comps
                                     begin
                                      if not (ThisCell is TGraphicCell) then
                                       begin
                                            case ThisCell.FCellXID of
                                               1797,1163, 1164, 1165, 1166, 1167, 1168, 2613, 2614, 2615, 2616, 2617, 2618 :
                                               begin
                                                  Continue; //  imported below in ImportTableCells
                                               end;

                                               1157, 1158, 1205, 1206, 1207, 1208, 1209, 1210, 2619..2642 :
                                               begin
                                                  Continue; //  already exported above in Photo, Map, or Sketch addemdums
                                                end;

                                               3386 :          //  //APPRAISAL_REQUEST/PROPERTY_ACCESS[@_RoleType="Other"]/@_RoleTypeOtherDescription
                                                begin
                                                  ThisCell.Text := ThisTranslator.ImportValue(ThisCell.FCellXID + ImportCellIDOffset);
                                                   if ThisCell.Text = '' then
                                                      ThisCell.Text := 'Other';
                                                end;

                                               CELL_PGNUM_XID, REPORT_TYPE_CELLID :
                                               Continue;   //  never imported

                                            else
                                              ImportCellID := ThisCell.FCellXID + ImportCellIDOffset;
                                              if ThisCell.CanEdit then
                                                begin
                                                 if ThisCell is TChkBoxCell then
                                                   begin
                                                     if ThisTranslator.ImportBooleanValue(ImportCellID) then
                                                        ThisCell.Text := CHECK_CELL_TRUE_TEXT
                                                     else
                                                        if ThisCell.Text <> CHECK_CELL_FALSE_TEXT then
                                                           ThisCell.Text := CHECK_CELL_FALSE_TEXT;
                                                           //don't set false check boxes to '' because it will clear the entire radio group
                                                   end
                                                 else
                                                   ThisValue:=  ThisTranslator.ImportValue(ImportCellID);
                                                   if appPref_RelsOverwriteImport then
                                                     begin
                                                       if ThisValue <> '' then
                                                        begin
                                                         ThisCell.Text := ThisTranslator.ImportValue(ImportCellID);
                                                         ThisCell.PostProcess;
                                                        end;
                                                     end
                                                   else
                                                    begin
                                                     if (ThisCell.Text = '') and (ThisValue <> '') then
                                                      begin
                                                       ThisCell.Text := ThisTranslator.ImportValue(ImportCellID);
                                                       ThisCell.PostProcess;
                                                      end;
                                                     end;
                                                end
                                              else
                                               begin
                                                 ThisValue := ThisTranslator.ImportValue(ImportCellID);
                                                 if appPref_RelsOverwriteImport then
                                                  begin
                                                    if ThisValue <> '' then
                                                     begin
                                                      ThisCell.Text := ThisValue;
                                                      ThisCell.PostProcess;
                                                     end;
                                                  end
                                                 else
                                                  begin
                                                   if (ThisCell.Text = '') and (ThisValue <> '') then
                                                     begin
                                                       ThisCell.Text := ThisTranslator.ImportValue(ImportCellID);
                                                       ThisCell.PostProcess;
                                                     end;
                                                  end;
                                               end;
                                            end;
                                       end;
                                     end;
                               end;
                           end;
                        end;
                    end;

                end;

               {Import Table}
               for ThisTableType := Low(TComparableType) to High(TComparableType) do
                   ImportTableCells(ThisTableType, GridCellList, ThisTranslator);

           end;

       Finally
         ThisTranslator.EndImport;
       end;
   Finally
    ThisTranslator.Free;
    GridCellList.Free;
   end;
end;

///////////////////////////////////////////////////////////////////////////////////////////

const
   VENDOR_ORDER_ID_TAG = 'Vender Order ID';
   EMPTY_VENDOR_ORDER_ID = 0;

function FindVendorOrderID(AContainer : TContainer) : Integer;
var
   ThisStream : TStream;
begin
   Result := EMPTY_VENDOR_ORDER_ID;

   ThisStream := AContainer.docData.FindData(VENDOR_ORDER_ID_TAG);
   if ThisStream <> nil then
   begin
       ThisStream.Position := 0;
       ThisStream.Read(Result, SizeOf(Result));
   end;
   //             do not free the stream! We did not create it and it does not belong to us

end;

function GetVendorOrderID(AContainer : TContainer) : Integer;
begin
  result := 0;
//   Result := FindAppraisalWorldOrderID(AContainer);
//   if Result = EMPTY_VENDOR_ORDER_ID then
//       raise Exception.Create('This document is not an Order');
end;

procedure SetVendorOrderID(AContainer : TContainer; AnOrderID : Integer);
var
   ThisStream : TMemoryStream;
begin
   ThisStream := TMemoryStream.Create;
   try
       ThisStream.Write(AnOrderID, SizeOf(AnOrderID));
       AContainer.docData.UpdateData(VENDOR_ORDER_ID_TAG, ThisStream);
   finally
       ThisStream.Free;
   end;
end;
(*
function FindOrderStatus(AContainer : TContainer; PriorIndex : Integer) : TAppraisalOrderStatus;
var
   ThisOrderXML : TXMLCollection;
   ThisElement : TXMLElement;
begin
   Result := etsUnknown;

   ThisOrderXML := TXMLCollection.Create;
   try
{$ifdef DEBUG}
       uWindowsInfo.WriteFile(uWindowsInfo.GetUnusedFileName('FindOrderStatus.xml'), GetMISMORequestXMLText(AContainer));
{$endif}
       ThisOrderXML.AsString := GetMISMORequestXMLText(AContainer);

       ThisElement := nil;
       if PriorIndex = 0 then
           ThisElement := ThisOrderXML.FindElement('//APPRAISAL_REQUEST/APPRAISAL_STATUS')

       else if ThisOrderXML.FindElement('//APPRAISAL_REQUEST/STATUS_HISTORY', ThisElement) then
       begin
           if ThisElement.ElementCount >= PriorIndex then
               ThisElement := ThisElement.Elements[ThisElement.ElementCount - PriorIndex];
       end;

       if ThisElement <> nil then
       begin
           Result := uAppraisalOrderObjects.CodeToStatus(StrToIntDef(ThisElement.AttributeValues['_Code'], 0));
           if Result = etsUnknown then
               Result := uAppraisalOrderObjects.StrToStatus(ThisElement.AttributeValues['_Name']);
       end;
   finally
       ThisOrderXML.Free;
   end;
end;

procedure UpdateOrderStatus(AContainer : TContainer; AStatus : TAppraisalOrderStatus;
   const AComment : string; AStatusDate : TDateTime; AnInspectionDate : TDateTime);
var
   ThisOrderXML : TXMLCollection;
   FormCounter : Integer;
   OldStatusElement : TXMLElement;
begin
   if AStatusDate = 0.0 then
       AStatusDate := SysUtils.Now;

   //    update the XML document
   ThisOrderXML := TXMLCollection.Create;
   try
       ThisOrderXML.AsString := GetMISMORequestXMLText(AContainer);
{$ifdef DEBUG}
       uWindowsInfo.WriteFile(uWindowsInfo.GetUnusedFileName('Read for UpdateOrderStatus.xml'), GetMISMORequestXMLText(AContainer));
{$endif}

       OldStatusElement := ThisOrderXML.FindElement('//APPRAISAL_REQUEST/APPRAISAL_STATUS');

       if OldStatusElement <> nil then                     //  add the old element to the history
       begin
           ThisOrderXML.OpenElement('//APPRAISAL_REQUEST/STATUS_HISTORY').
               AddElement('APPRAISAL_STATUS').Assign(OldStatusElement);
       end;

       with ThisOrderXML.OpenElement('//APPRAISAL_REQUEST/APPRAISAL_STATUS') do
       begin
           AttributeValues['_Code'] := IntToStr(StatusToCode(AStatus));
           AttributeValues['_Name'] := StatusToStr(AStatus);
           AttributeValues['_Date'] := uInternetUtils.DateTimeToISO8601(AStatusDate);
           AttributeValues['_Message'] := AComment;
           AttributeValues['InspectionDate'] := uInternetUtils.DateTimeToISO8601(AnInspectionDate);
           AttributeValues['VendorOrderIdentifier'] := IntToStr(GetVendorOrderID(AContainer)); //  this will except if no order ID found
       end;

{$ifdef DEBUG}
       uWindowsInfo.WriteFile(uWindowsInfo.GetUnusedFileName('Written for UpdateOrderStatus.xml'), ThisOrderXML.AsString);
{$endif}
       SetMISMORequestXMLText(AContainer, ThisOrderXML.AsString);
   finally
       ThisOrderXML.Free;
   end;                                                                    

   for FormCounter := 0 to AContainer.docForm.Count - 1 do
   begin
       if AContainer.docForm[FormCounter].FormID = ORDER_FORM_ID then
       begin
           with AContainer.docForm[FormCounter].frmPage[0] do
           begin
               case AStatus of
                   etsAcceptedByAppraiser : AContainer.SetCellTextByID(ORDER_ACCEPTED_DATE_CELLID, DateTimeToStr(AStatusDate));
                   etsDeclinedByAppraiser : AContainer.SetCellTextByID(ORDER_DECLINED_DATE_CELLID, DateTimeToStr(AStatusDate));
                   etsScheduled : AContainer.SetCellTextByID(ORDER_SCHEDULED_DATE_CELLID, DateTimeToStr(AStatusDate));
                   etsInspected : AContainer.SetCellTextByID(ORDER_INSPECTED_DATE_CELLID, DateTimeToStr(AStatusDate));
                   etsCompleted : AContainer.SetCellTextByID(ORDER_COMPLETED_DATE_CELLID, DateTimeToStr(AStatusDate));
                   etsDelayed : AContainer.SetCellTextByID(ORDER_DELAYED_DATE_CELLID, DateTimeToStr(AStatusDate));
                   etsResumed : AContainer.SetCellTextByID(ORDER_RESUMED_DATE_CELLID, DateTimeToStr(AStatusDate));
               end;
           end;
       end;
   end;

   if AStatus = etsResumed then
       AStatus := uMISMOInterface.FindOrderStatus(AContainer, 2);    //  reset to the status in place before the etsDelayed

   SetOrderFormButtons(AContainer, AStatus);
end;

procedure SetOrderFormButtons(AContainer : TContainer; AStatus : TAppraisalOrderStatus);
var
   FormCounter : Integer;
begin
   if AStatus = etsUnknown then
       AStatus := FindOrderStatus(AContainer);

   for FormCounter := 0 to AContainer.docForm.Count - 1 do
   begin
       if AContainer.docForm[FormCounter].FormID = ORDER_FORM_ID then
       begin
           with AContainer.docForm[FormCounter].frmPage[0] do
           begin
               case AStatus of
                   etsUnknown, etsReceivedByAppraiser :
                       begin
                           FindButton(ORDER_ACCEPT_BUTTON_ID).Enabled := True;
                           FindButton(ORDER_DECLINE_BUTTON_ID).Enabled := True;
                           FindButton(ORDER_SCHEDULED_BUTTON_ID).Enabled := False;
                           FindButton(ORDER_INSPECTED_BUTTON_ID).Enabled := False;
                           FindButton(ORDER_DELAYED_BUTTON_ID).Enabled := False;
                           FindButton(ORDER_RESUMED_BUTTON_ID).Enabled := False;
                           FindButton(ORDER_COMPLETED_BUTTON_ID).Enabled := False;
                       end;
                   etsAcceptedByAppraiser, etsDeclinedByAppraiser, etsResumed :
                       begin
                           FindButton(ORDER_ACCEPT_BUTTON_ID).Enabled := False;
                           FindButton(ORDER_DECLINE_BUTTON_ID).Enabled := False;
                           FindButton(ORDER_SCHEDULED_BUTTON_ID).Enabled := True;
                           FindButton(ORDER_INSPECTED_BUTTON_ID).Enabled := True;
                           FindButton(ORDER_DELAYED_BUTTON_ID).Enabled := True;
                           FindButton(ORDER_RESUMED_BUTTON_ID).Enabled := False;
                           FindButton(ORDER_COMPLETED_BUTTON_ID).Enabled := True;
                       end;
                   etsInspected :
                       begin
                           FindButton(ORDER_ACCEPT_BUTTON_ID).Enabled := False;
                           FindButton(ORDER_DECLINE_BUTTON_ID).Enabled := False;
                           FindButton(ORDER_SCHEDULED_BUTTON_ID).Enabled := False;
                           FindButton(ORDER_INSPECTED_BUTTON_ID).Enabled := True;
                           FindButton(ORDER_DELAYED_BUTTON_ID).Enabled := True;
                           FindButton(ORDER_RESUMED_BUTTON_ID).Enabled := False;
                           FindButton(ORDER_COMPLETED_BUTTON_ID).Enabled := True;
                       end;
                   etsCanceled, etsCompleted :
                       begin
                           FindButton(ORDER_ACCEPT_BUTTON_ID).Enabled := False;
                           FindButton(ORDER_DECLINE_BUTTON_ID).Enabled := False;
                           FindButton(ORDER_SCHEDULED_BUTTON_ID).Enabled := False;
                           FindButton(ORDER_INSPECTED_BUTTON_ID).Enabled := False;
                           FindButton(ORDER_DELAYED_BUTTON_ID).Enabled := False;
                           FindButton(ORDER_RESUMED_BUTTON_ID).Enabled := False;
                           FindButton(ORDER_COMPLETED_BUTTON_ID).Enabled := False;
                       end;
                   etsDelayed :
                       begin
                           FindButton(ORDER_ACCEPT_BUTTON_ID).Enabled := False;
                           FindButton(ORDER_DECLINE_BUTTON_ID).Enabled := False;
                           FindButton(ORDER_SCHEDULED_BUTTON_ID).Enabled := False;
                           FindButton(ORDER_INSPECTED_BUTTON_ID).Enabled := False;
                           FindButton(ORDER_DELAYED_BUTTON_ID).Enabled := False;
                           FindButton(ORDER_RESUMED_BUTTON_ID).Enabled := True;
                           FindButton(ORDER_COMPLETED_BUTTON_ID).Enabled := False;
                       end;
               end;
           end;
       end;
   end;
end;
*)
////////////////////////////////////////////////////////////////////////////////////

const
   MISMO_XML_TEXT_TAG = 'MISMO Appraisal Order Text';

function IsMISMORequestDocument(AContainer : TContainer) : Boolean;
begin
   Result := FindMISMORequestXMLText(AContainer) <> '';
end;

function FindMISMORequestXMLText(AContainer : TContainer) : string;
var
   ThisStream : TStream;
begin
   Result := '';

   ThisStream := AContainer.docData.FindData(MISMO_XML_TEXT_TAG);
   if ThisStream <> nil then
   begin
       SetLength(Result, ThisStream.Size);
       ThisStream.Position := 0;
       ThisStream.Read(PChar(Result)^, ThisStream.Size);
   end;
   //             do not free the stream! We did not create it and it does not belong to us
end;

function GetMISMORequestXMLText(AContainer : TContainer) : string;
begin
   Result := FindMISMORequestXMLText(AContainer);
   if Result = '' then
       raise Exception.Create('This document is not a MISMO Appraisal Request');
end;

procedure SetMISMORequestXMLText(AContainer : TContainer; const AnXMLText : string);
var
   ThisStream : TMemoryStream;
begin
   ThisStream := TMemoryStream.Create;
   try
       ThisStream.Write(PChar(AnXMLText)^, Length(AnXMLText));
       AContainer.docData.UpdateData(MISMO_XML_TEXT_TAG, ThisStream);
   finally
       ThisStream.Free;
   end;
end;





(*

 if not ATranslator.FindMapping(FORM_ID, FormXPath) then

               if IsPublicAppraisalFormType(AForm.FormID) then
               begin
                   Result := ATranslator.XML.AddElement(FormXPath);
                   Result.AttributeValues['AppraisalFormType'] := FormTag;
                   SetFormIdentification(Result, AForm);
               end
               else
                   Result := ExportOtherForm(ATranslator, AForm, FormTag);

               Result.AttributeValues['AppraisalFormVersionIdentifier'] := FormTagIDList.Values[FormTag];



//      Result.AttributeValues['AppraisalFormVersionIdentifier'] := ;
       Result := ATranslator.XML.AddElement(FormXPath);
       Result.AttributeValues['AppraisalFormType'] := FormTag;
*)

(*
   procedure ExportGraphicCell(ACell: TGraphicCell; AnElement: TXMLElement;
       AnImageType: TImageType = imtPhoto; AnIdentifier: TComparable = cUnknown); overload;
   var
       RawStream : TMemoryStream;
       ThisStream : TStringStream;
       EncodedData : string;
       TypeEnumerationNameLengthByte : Byte;
       DataLength : LongInt;
   begin
       Assert(ACell <> nil);
       RawStream := TMemoryStream.Create;
       ThisStream := TStringStream.Create('');
       try
           ACell.fImage.SaveToStream(RawStream);

           RawStream.Position := 0;
           RawStream.Read(TypeEnumerationNameLengthByte, SizeOf(TypeEnumerationNameLengthByte));

           RawStream.Position := SizeOf(TypeEnumerationNameLengthByte) + Integer(TypeEnumerationNameLengthByte); //  skip the header
           RawStream.Read(DataLength, SizeOf(DataLength));
           Assert(DataLength = RawStream.Size - RawStream.Position);

           ThisStream.CopyFrom(RawStream, DataLength);

           if ThisStream.Size > 0 then
           begin
               EncodedData := UBase64.Base64Encode(ThisStream.DataString);

               if AnIdentifier <> cUnknown then
                   AnElement.AttributeValues['ComparableIdentificationType'] := COMPARABLE_NAMES[AnIdentifier];

               if AnImageType <> imtUnknown then
                   AnElement.AttributeValues['_Type'] := IMAGE_TYPE_NAMES[AnImageType];

               with AnElement.AddElement('EMBEDDED_FILE') do
               begin
                   AttributeValues['_EncodingType'] := BASE64_ENCODING_TAG;
                   AttributeValues['_Extension'] := ACell.fImage.ILImageType;
                   AttributeValues['MIMEType'] := ExtensionToMime(ACell.fImage.ILImageType);

                   AddElement('DOCUMENT').AddElement(ecMarkedSection).RawText := EncodedData;
               end;
           end;
       finally
           ThisStream.Free;
           RawStream.Free;
       end;
   end;

   procedure ExportPhotoCell(AForm : TdocForm; AnElement : TXMLElement;
       PhotoCellID : Integer; const CaptionCellID : array of Integer; FirstCaption : string = '');
   var
       ThisCell : TBaseCell;
       CaptionCounter, CellCounter : Integer;
   begin
       ThisCell := AForm.GetCellByXID_MISMO(PhotoCellID);

       if ThisCell is TGraphicCell then                    //  this is False if ThisCell = nil
       begin
           if TGraphicCell(ThisCell).HasImage then
           begin
               ExportGraphicCell(TGraphicCell(ThisCell), AnElement, imtPhoto);

               CaptionCounter := 0;
               if FirstCaption <> '' then
               begin
                   AnElement.AttributeValues[IMAGE_CAPTION_ATTRIBUTE_NAMES[CaptionCounter]] := FirstCaption;
                   Inc(CaptionCounter);
               end;

               CellCounter := Low(CaptionCellID);
               while (CellCounter <= High(CaptionCellID)) and (CaptionCounter < Length(IMAGE_CAPTION_ATTRIBUTE_NAMES)) do
               begin
                   ThisCell := AForm.GetCellByXID_MISMO(CaptionCellID[CellCounter]);
                   if ThisCell <> nil then
                   begin
                       if ThisCell.Text <> '' then
                       begin
                           AnElement.AttributeValues[IMAGE_CAPTION_ATTRIBUTE_NAMES[CaptionCounter]] := ThisCell.Text;
                           Inc(CaptionCounter);
                       end;
                   end;
                   Inc(CellCounter);
               end;
           end;
       end;
   end;

*)

(*

//Another Table Exported - I think it is Richards

   function ExportAllTableCells(ATableType : TComparableType; ATranslator : TMISMOTranslator): Boolean; overload;
   var
       SubColumnCounter, RowCounter, ColCounter : Integer;
       ThisGridManager : TGridMgr;
       ThisCellID : Integer;
       ThisCellText : string;
       ThisElement : TXMLElement;
       ThisColumn : TCompColumn;
       ThisComparableType : TComparable;
   {$IFDEF DEBUG}
       CellIDList : string;
   {$ENDIF}
   begin
       Result := False;

       ThisGridManager := TGridMgr.Create;
       try
           ThisGridManager.BuildGrid(AContainer, COMPARABLE_TYPE_INDEX[ATableType]);

{$IFDEF DEBUG}
           CellIDList := '';
{$ENDIF}
           for ColCounter := 0 to ThisGridManager.Count - 1 do //  ThisGridManager is a TObjectList of TCompColumns
           begin
               ThisColumn := ThisGridManager.Comp[ColCounter];
               if (ThisColumn.CompNumber >= Low(COMPARABLE_TYPES)) and (ThisColumn.CompNumber <= High(COMPARABLE_TYPES)) then
                   ThisComparableType := COMPARABLE_TYPES[ThisColumn.CompNumber]
               else
                   ThisComparableType := COMPARABLE_TYPES[10]; //  'Other'

               //     export all the cells in the grid

               for RowCounter := 0 to ThisColumn.RowCount - 1 do
               begin
                   for SubColumnCounter := 0 to 1 do
                   begin
                       ThisCellID := ThisColumn.GetCellIDByCoord(Point(RowCounter, SubColumnCounter)); //  yes: (Row, Col)
{$IFDEF DEBUG}
                       CellIDList := CellIDList + ', ' + IntToStr(ThisCellID);
{$ENDIF}
                       ThisCellText := ThisColumn.GetCellTextByCoord(Point(RowCounter, SubColumnCounter)); //  yes: (Row, Col)

                       if (ThisCellText <> '') and (ThisCellID > 0) then
                       try
                           if AContainer.GetCellByXID_MISMO(ThisCellID) is TGridCell then //     workaround to bad behavior: the cells from the first row seem to be other that TGridCells, and their mapping does not have an _IdentificationType
                           begin
                               Result := True;             //      we actually exported something

                               ThisElement := ATranslator.ExportValue(ThisCellID,
                                   COMPARABLE_NAMES[ThisComparableType], ThisCellText);

                               if ThisComparableType = cCompOther then
                               begin
                                   ThisElement.AttributeValues['ComparableIdentificationTypeOtherDescription'] :=
                                       'Comparable' + StringReplace(uCraftClass.FormatCamelCap(uCraftClass.DescribeCount(
                                       ThisColumn.CompNumber)), ' ', '', [rfReplaceAll]);
                               end;
                           end;
                       except
                           on E : EMISMOTranslationError do
                           begin
                               ATranslator.ExportDebugMessage(
                                   Format('Error exporting grid Cell ID %d [text ="%s"] in row %d and col %d (%s)',
                                   [ThisCellID, ThisCellText, RowCounter, ColCounter,
                                   COMPARABLE_NAMES[ThisComparableType]]) + #13#10#13#10 + E.Message);
{$IFNDEF DEBUG}
                               raise;
{$ENDIF}
                           end;
                       end;
                   end;
               end;

               //         export the associated image

               if ThisColumn.Photo <> nil then
               begin
                   if ThisColumn.Photo.Cell <> nil then
                   begin
                       ThisElement :=
                           ATranslator.ExportTag(COMPARABLE_IMAGE_CELLID, COMPARABLE_NAMES[ThisComparableType]);

                       ThisElement.AttributeValues['_Type'] := TABLE_PHOTO_NAMES[ATableType];

                       ThisElement.AttributeValues['_FirstCaptionText'] :=
                           COMPARABLE_TITLES[ATableType, ThisComparableType];

                       if ThisColumn.Photo.Address[0] <> '' then
                       begin
                           ThisElement.AttributeValues['_SecondCaptionText'] := ThisColumn.Photo.Address[0];
                           if ThisColumn.Photo.Address[1] <> '' then
                               ThisElement.AttributeValues['_ThirdCaptionText'] := ThisColumn.Photo.Address[1];
                       end;

                       //             imtUnknown because COMPARABLE_IMAGE_CELLID does not have a _Type attribute
                       ExportGraphicCell(ThisColumn.Photo.Cell, ThisElement, imtUnknown, ThisComparableType);
                       ThisElement.AttributeValues['_Identifier'] :=
                           IntToStr(TDocForm(TDocPage(ThisColumn.Photo.Cell.FParentPage).FParentForm).frmInfo.fFormUID);
                   end;
               end;
           end;
{$IFDEF DEBUG}
           Delete(CellIDList, 1, 2);
           ATranslator.ExportDebugMessage(COMPARABLE_TYPE_NAMES[ATableType] + ' table CellID '' s found : ' + CellIDList);
{$ENDIF}
       finally
           ThisGridManager.Free;
       end;
   end;
*)
(*

   function ExportTablePhotoCells(ATableType : TComparableType; ATranslator : TMISMOTranslator) : Boolean;
   var
       CaptionCounter, ColCounter : Integer;
       ThisGridManager : TGridMgr;
       ThisElement : TXMLElement;
       ThisColumn : TCompColumn;
       ThisComparableType : TComparable;
       ThisXPath : string;
   begin
       Result := False;

       ThisGridManager := TGridMgr.Create;
       try
           ThisGridManager.BuildGrid(AContainer, COMPARABLE_TYPE_INDEX[ATableType]);
           ThisGridManager.BuildPhotoLinks;

           for ColCounter := 0 to ThisGridManager.Count - 1 do //  ThisGridManager is a TObjectList of TCompColumns
           begin
               ThisColumn := ThisGridManager.Comp[ColCounter];
               if (ThisColumn.CompNumber >= Low(COMPARABLE_TYPES)) and (ThisColumn.CompNumber <= High(COMPARABLE_TYPES)) then
                   ThisComparableType := COMPARABLE_TYPES[ThisColumn.CompNumber]
               else
                   ThisComparableType := COMPARABLE_TYPES[10]; //  'Other'

               //         export the associated image

               if ThisColumn.Photo <> nil then
               begin
                   if ThisColumn.Photo.Cell <> nil then
                   begin
                       if not ATranslator.FindMapping(COMPARABLE_IMAGE_CELLID, ThisXPath) then
                       begin
{$IFDEF DEBUG}
                           ATranslator.ExportDebugMessage('No mapping for CellID ' +
                               IntToStr(COMPARABLE_IMAGE_CELLID) + ' (the Comparable Image mapping)');
{$ELSE}
                           raise EMISMOTranslationMissingMappingError.Create('No mapping present for CellID ' +
                               IntToStr(COMPARABLE_IMAGE_CELLID));
{$ENDIF}
                       end
                       else
                       begin
                           ThisElement := ATranslator.XML.AddElement(ThisXPath);
                           ThisElement.AttributeValues['ComparableIdentificationType'] := COMPARABLE_NAMES[ThisComparableType];
                           ThisElement.AttributeValues['_Type'] := TABLE_PHOTO_NAMES[ATableType];

                           ThisElement.AttributeValues[IMAGE_CAPTION_ATTRIBUTE_NAMES[0]] :=
                               COMPARABLE_TITLES[ATableType, ThisComparableType];

                           CaptionCounter := 1;

                           if ThisColumn.Photo.Address[0] <> '' then
                           begin
                               ThisElement.AttributeValues[IMAGE_CAPTION_ATTRIBUTE_NAMES[CaptionCounter]] :=
                                   ThisColumn.Photo.Address[0];
                               Inc(CaptionCounter);
                           end;

                           if ThisColumn.Photo.Address[1] <> '' then
                           begin
                               ThisElement.AttributeValues[IMAGE_CAPTION_ATTRIBUTE_NAMES[CaptionCounter]] :=
                                   ThisColumn.Photo.Address[1];
                           end;

                           //             imtUnknown because COMPARABLE_IMAGE_CELLID does not have a _Type attribute
                           ExportGraphicCell(ThisColumn.Photo.Cell, ThisElement, imtUnknown, ThisComparableType);
                           ThisElement.AttributeValues['_Identifier'] :=
                               IntToStr(TDocForm(TDocPage(ThisColumn.Photo.Cell.FParentPage).FParentForm).frmInfo.fFormUID);
                       end;
                   end;
               end;
           end;
       finally
           ThisGridManager.Free;
       end;
   end;

*)

(*
   function ExportTableCells(ATableType : TComparableType; ACellList : TStrings; ThisTranslator : TMISMOTranslator) : Boolean;
   var
       ColCounter, Counter, ThisCompNumber : Integer;
       ThisGridManager : TGridMgr;
       ThisCellID : Integer;
       ThisCellText : string;
       ThisElement : TXMLElement;
       ThisColumn : TCompColumn;
       ThisComparableType : TComparable;
   begin
       Result := False;

       ThisGridManager := TGridMgr.Create;
       try
           ThisGridManager.BuildGrid(AContainer, COMPARABLE_TYPE_INDEX[ATableType]);
           ThisGridManager.BuildPhotoLinks;

           for ColCounter := 0 to ThisGridManager.Count - 1 do //  ThisGridManager is a TObjectList of TCompColumns
           begin
               ThisColumn := ThisGridManager.Comp[ColCounter];
               ThisCompNumber := ThisColumn.CompNumber;

               if ThisCompNumber = -1 then
                   ThisCompNumber := 0;

               if (ThisCompNumber >= Low(COMPARABLE_TYPES)) and (ThisCompNumber <= High(COMPARABLE_TYPES)) then
                   ThisComparableType := COMPARABLE_TYPES[ThisCompNumber]
               else
                   ThisComparableType := COMPARABLE_TYPES[10]; //  'Other'

               //     export all the cells in the grid

               for Counter := 0 to ACellList.Count - 1 do
               begin
                   Result := True;                         //      we actually exported something

                   ThisCellID := Integer(ACellList.Objects[Counter]);
                   ThisCellText := ThisColumn.GetCellTextByXID_MISMO(ThisCellID); //    each column can have a different text

                   if ThisCellText <> '' then
                   try
                       if IsFalseGridCell(ThisCellID) then
                           ThisTranslator.ExportValue(ThisCellID, ThisCellText)
                       else
                       begin
                           ThisElement := ThisTranslator.ExportValue(ThisCellID,
                               COMPARABLE_NAMES[ThisComparableType], ThisCellText);

                           Assert(ThisElement <> nil, 'ExportValue did not work for CellID ' + IntToStr(ThisCellID) +
                               ' for comparable ' + COMPARABLE_NAMES[ThisComparableType] + ': ' + ThisCellText);
                           if ThisComparableType = cCompOther then
                           begin
                               ThisElement.AttributeValues['ComparableIdentificationTypeOtherDescription'] :=
                                   'Comparable' + StringReplace(uCraftClass.FormatCamelCap(uCraftClass.DescribeCount(ThisColumn.CompNumber)), ' ', '', [rfReplaceAll])
                           end;
                       end;
                   except
                       on E : EMISMOTranslationError do
                       begin
                           ThisTranslator.ExportDebugMessage(
                               Format('Error exporting grid Cell ID %d [text ="%s"] col %d (%s) %s',
                               [ThisCellID, ThisCellText, ColCounter,
                               COMPARABLE_NAMES[ThisComparableType], ACellList[Counter]]) +
                                   #13#10 + E.Message);
{$IFNDEF DEBUG}
                           raise
{$ENDIF}
                       end;
                   end;
               end;
           end;
       finally
           ThisGridManager.Free;
       end;
   end;

   procedure InsertBefore(AFormID : Integer; var AFormList : TArrayOfForms; AForm : TdocForm);
   var
       Counter, SuffleDownCounter : Integer;
   begin
       Counter := 0;
       while (Counter < Length(AFormList)) and (AFormList[Counter] <> nil) do //      if not found, append the new form to the end of the list
       begin
           if AFormList[Counter].FormID = AFormID then
           begin
               for SuffleDownCounter := Length(AFormList) - 2 downto Counter do //  make room
                   AFormList[Counter + 1] := AFormList[Counter];
               Break;
           end;
           Inc(Counter);
       end;

       AFormList[Counter] := AForm;
   end;

   procedure InsertAfter(const AFormIDs : array of Integer; var AFormList : TArrayOfForms; AForm : TdocForm); overload;
   var
       IDCounter, Counter, SuffleDownCounter : Integer;
   begin
       Counter := 0;
       while (Counter < Length(AFormList)) and (AFormList[Counter] <> nil) do //      if not found, append the new form to the end of the list
       begin
           for IDCounter := Low(AFormIDs) to High(AFormIDs) do
           begin
               if AFormList[Counter].FormID = AFormIDs[IDCounter] then
               begin
                   Inc(Counter);
                   for SuffleDownCounter := Length(AFormList) - 2 downto Counter do //  make room
                       AFormList[Counter + 1] := AFormList[Counter];
                   Break;
               end;
           end;
           Inc(Counter);
       end;

       AFormList[Counter] := AForm;
   end;

   procedure InsertAfter(AFormID : Integer; AFormList : TArrayOfForms; AForm : TdocForm); overload;
   begin
       InsertAfter([AFormID], AFormList, AForm);
   end;

   procedure SetFormIdentification(AnElement : TXMLElement; AForm : TDocForm);
   begin
     AnElement.AttributeValues['AppraisalReportContentIdentifier'] := IntToStr(AForm.FormID);
     AnElement.AttributeValues['AppraisalReportContentName'] := AForm.frmSpecs.fFormName;
     AnElement.AttributeValues['AppraisalReportContentSequenceIdentifier'] := IntToStr(FormSequenceCounter);
   end;

   function ExportOtherAddendum(ATranslator : TMISMOTranslator; AForm : TDocForm; const ADescription : string = '') : TXMLElement;
   var
       ThisXPath : string;
   begin
       if ATranslator.FindMapping(OTHER_ADDENDUM, ThisXPath) then
       begin
           Result := ATranslator.XML.AddElement(ThisXPath);
           if ADescription <> '' then
               Result.AttributeValues['_TypeOtherDescription'] := ADescription
           else
               Result.AttributeValues['_TypeOtherDescription'] := AForm.frmInfo.fFormName;

           SetFormIdentification(Result, AForm);
       end
       else
           raise Exception.Create('The XPath for OTHER_ADDENDUM is missing');
   end;

   function ExportOtherForm(ATranslator : TMISMOTranslator; AForm : TDocForm; const ADescription : string = '') : TXMLElement;
   var
       ThisXPath : string;
   begin
       if ATranslator.FindMapping(OTHER_FORM, ThisXPath) then
       begin
           Result := ATranslator.XML.AddElement(ThisXPath);
           if ADescription <> '' then
               Result.AttributeValues['AppraisalFormTypeOtherDescription'] := ADescription
           else
               Result.AttributeValues['AppraisalFormTypeOtherDescription'] := AForm.frmInfo.fFormName;

           SetFormIdentification(Result, AForm);
       end
       else
           raise Exception.Create('The XPath for OTHER_FORM is missing');
   end;

   function ExportForm(AForm: TdocForm; ATranslator: TMISMOTranslator): TXMLElement;
   var
      ThisIndex : Integer;
      FormXPath, FormTag : string;
   begin
       ThisIndex := FormTagIDList.IndexOfObject(TObject(AForm.FormID)); //  StringList.Find does not find Objects
       if ThisIndex <> -1 then
       begin
           if not ATranslator.FindMapping(FORM_ID, FormXPath) then
           begin
{$IFDEF DEBUG}
               ATranslator.ExportDebugMessage('No mapping for CellID ' +
                   IntToStr(FORM_ID) + ' (the template FORM mapping)');
{$ELSE}
               raise EMISMOTranslationMissingMappingError.Create('No mapping for CellID ' +
                   IntToStr(FORM_ID) + ' (the template FORM mapping)');
{$ENDIF}
           end
           else
           begin
               FormTag := FormTagIDList.Names[ThisIndex];

               if IsPublicAppraisalFormType(AForm.FormID) then
               begin
                   Result := ATranslator.XML.AddElement(FormXPath);
                   Result.AttributeValues['AppraisalFormType'] := FormTag;
                   SetFormIdentification(Result, AForm);
               end
               else
                   Result := ExportOtherForm(ATranslator, AForm, FormTag);

               Result.AttributeValues['AppraisalFormVersionIdentifier'] := FormTagIDList.Values[FormTag];
           end;
       end
       else                                                //           not on the list of public forms
       begin
       (*
           if AForm.frmInfo.fFormKindID = fkAddendum then
               Result := ExportOtherAddendum(ATranslator, AForm)
           else
               Result := ExportOtherForm(ATranslator, AForm);

       end;

       Assert(Result <> nil);
   end;
*)
(*
   function ExportSpecialForm(AForm : TdocForm; ATranslator : TMISMOTranslator; var AnElement : TXMLElement) : Boolean;

       procedure ExportExtraGroupCell(ACellID : Integer; const AComparableIdentifier : string);
       var
           ThisCell : TBaseCell;
       begin
           ThisCell := AForm.GetCellByXID_MISMO(ACellID);
           if ThisCell <> nil then
           begin
               if not ThisCell.FEmptyCell then
               begin
                   with ATranslator.ExportValue(ThisCell.FCellXID, ThisCell.Text) do
                       AttributeValues['_Identifier'] := AComparableIdentifier;
               end;
           end;
       end;

   var
       ThisCell : TBaseCell;
       ColumnOneSequenceNumber : Integer;
       ColumnOneIdentifier : Integer;
       ThisComparableIdentifier : string;
   begin
       Result := True;                                     //  set to False in case...else

       case AForm.FormID of
           98 :
               begin
                   AnElement := ATranslator.ExportTag(ADDITIONAL_COMMENTS);
                   AnElement.AttributeValues['_Comment'] := AForm.frmPage[0].pgData[12].Text; //  comment text: sequence number 13
               end;

           //     Export map addendums
           101 :
               begin
                   AnElement := ATranslator.ExportTag(LOCATION_MAP);
                   ExportGraphicCell(AForm.GetCellByXID_MISMO(1158) as TGraphicCell,
                       AnElement.AddElement('_IMAGE'), imtMap);
               end;

           102 :
               begin
                   AnElement := ATranslator.ExportTag(FLOOD_MAP);
                   ExportGraphicCell(AForm.GetCellByXID_MISMO(1158) as TGraphicCell,
                       AnElement.AddElement('_IMAGE'), imtMap); { TODO : use the new cellid 2631 instead of 1158 }
               end;

           103 :
               begin
                   AnElement := ATranslator.ExportTag(PLAT_MAP);
                   ExportGraphicCell(AForm.GetCellByXID_MISMO(1158) as TGraphicCell,
                       AnElement.AddElement('_IMAGE'), imtMap); { TODO : use the new cellid 2635 instead of 1158 }
               end;

           104, 108 :
               begin
                   AnElement := ExportOtherAddendum(ATranslator, AForm, 'NeighborhoodMap');
                   ExportGraphicCell(AForm.GetCellByXID_MISMO(2630) as TGraphicCell,
                       AnElement.AddElement('_IMAGE'), imtMap);
               end;

           105 :
               begin
                   AnElement := ExportOtherAddendum(ATranslator, AForm, 'LandSalesMap');
                   ExportGraphicCell(AForm.GetCellByXID_MISMO(2632) as TGraphicCell,
                       AnElement.AddElement('_IMAGE'), imtMap);
               end;

           106 :
               begin
                   AnElement := ExportOtherAddendum(ATranslator, AForm, 'LandUseMap');
                   ExportGraphicCell(AForm.GetCellByXID_MISMO(2633) as TGraphicCell,
                       AnElement.AddElement('_IMAGE'), imtMap);
               end;

           107 :
               begin
                   AnElement := ExportOtherAddendum(ATranslator, AForm, 'ListingsMap');
                   ExportGraphicCell(AForm.GetCellByXID_MISMO(2634) as TGraphicCell,
                       AnElement.AddElement('_IMAGE'), imtMap);
               end;

           109 :
               begin
                   AnElement := ExportOtherAddendum(ATranslator, AForm, 'RegionalMap');
                   ExportGraphicCell(AForm.GetCellByXID_MISMO(2636) as TGraphicCell,
                       AnElement.AddElement('_IMAGE'), imtMap);
               end;

           110 :
               begin
                   AnElement := ExportOtherAddendum(ATranslator, AForm, 'RentalMap');
                   ExportGraphicCell(AForm.GetCellByXID_MISMO(2637) as TGraphicCell,
                       AnElement.AddElement('_IMAGE'), imtMap);
               end;

           111 :
               begin
                   AnElement := ExportOtherAddendum(ATranslator, AForm, 'SalesLocationsMap');
                   ExportGraphicCell(AForm.GetCellByXID_MISMO(2638) as TGraphicCell,
                       AnElement.AddElement('_IMAGE'), imtMap);
               end;

           112 :
               begin
                   AnElement := ExportOtherAddendum(ATranslator, AForm, 'SiteLocationMap');
                   ExportGraphicCell(AForm.GetCellByXID_MISMO(2639) as TGraphicCell,
                       AnElement.AddElement('_IMAGE'), imtMap);
               end;

           113 :
               begin
                   AnElement := ExportOtherAddendum(ATranslator, AForm, 'ZoningMap');
                   ExportGraphicCell(AForm.GetCellByXID_MISMO(2641) as TGraphicCell,
                       AnElement.AddElement('_IMAGE'), imtMap);
               end;

           117 :
               begin
                   AnElement := ExportOtherAddendum(ATranslator, AForm, 'SurveyMap');
                   ExportGraphicCell(AForm.GetCellByXID_MISMO(2640) as TGraphicCell,
                       AnElement.AddElement('_IMAGE'), imtMap);
               end;

           118 :
               begin
                   AnElement := ATranslator.ExportTag(PLAT_MAP);
                   ExportGraphicCell(AForm.GetCellByXID_MISMO(2635) as TGraphicCell,
                       AnElement.AddElement('_IMAGE'), imtMap);

                   ThisCell := AForm.GetCellByXID_MISMO(2642);
                   if ThisCell <> nil then
                       AnElement.AttributeValues['_Comment'] := ThisCell.Text;
               end;

           211 : AnElement := ExportOtherAddendum(ATranslator, AForm, 'Appraisal cover sheet');

           212 :
               begin
                   AnElement := ExportOtherAddendum(ATranslator, AForm, 'Appraisal cover sheet');
                   ThisCell := AForm.GetCellByXID_MISMO(COVER_PHOTO_CELLID);
                   if ThisCell = nil then
                       ThisCell := AForm.GetCell(1, 1);    //  page 1, cell 1
                   ExportGraphicCell(ThisCell as TGraphicCell, AnElement.AddElement('_IMAGE'), imtPhoto);
                   AnElement.AttributeValues['_Identifier'] :=
                       IntToStr(TDocForm(TDocPage(ThisCell.FParentPage).FParentForm).frmInfo.fFormUID);
               end;

           220 : AnElement := ATranslator.ExportTag(INVOICE);

           231 : AnElement := ExportOtherAddendum(ATranslator, AForm, 'Table of Contents');

           198 : AnElement := ExportOtherAddendum(ATranslator, AForm, 'Limited Certification');

           758 : AnElement := ExportOtherAddendum(ATranslator, AForm, 'Limiting Conditions');

           //     Export sketch addendums

           201 :                                           //  Property Sketch
               begin
                   AnElement := ATranslator.ExportTag(PROPERTY_SKETCH);
                   ExportGraphicCell(AForm.GetCellByXID_MISMO(1157) as TGraphicCell, AnElement.AddElement('_IMAGE'), imtSketch);
                   AnElement.AttributeValues['_Identifier'] := IntToStr(AForm.frmInfo.fFormUID);
               end;

           202 :                                           //  combined Sketch and Location Map
               begin
                   AnElement := ATranslator.ExportTag(PROPERTY_SKETCH);
                   ExportGraphicCell(AForm.GetCellByXID_MISMO(1157) as TGraphicCell, AnElement.AddElement('_IMAGE'), imtSketch);
                   ExportGraphicCell(AForm.GetCellByXID_MISMO(1158) as TGraphicCell, AnElement.AddElement('_IMAGE'), imtMap);
                   AnElement.AttributeValues['_Identifier'] := IntToStr(AForm.frmInfo.fFormUID);
               end;

           203, 204, 205 :                                 //  Property Sketch
               begin
                   AnElement := ATranslator.ExportTag(PROPERTY_SKETCH);
                   ExportGraphicCell(AForm.GetCellByXID_MISMO(1157) as TGraphicCell, AnElement.AddElement('_IMAGE'), imtSketch);
                   AnElement.AttributeValues['_Identifier'] := IntToStr(AForm.frmInfo.fFormUID);
               end;

           //     Export photo addendums

           301, 311 :
               begin
                   AnElement := ATranslator.ExportTag(SUBJECT_PHOTOS);
                   ExportPhotoCell(AForm, AnElement.AddElement('_IMAGE'),
                       1205, [925, 926], 'Front of Subject Property');
                   ExportPhotoCell(AForm, AnElement.AddElement('_IMAGE'),
                       1206, [2617, 2618], 'Rear of Subject Property');
                   ExportPhotoCell(AForm, AnElement.AddElement('_IMAGE'),
                       1207, [2619, 2620], 'Street Scene');
               end;

           302, 312 :
               begin
                   AnElement := ATranslator.ExportTag(SUBJECT_PHOTOS);
                   ExportPhotoCell(AForm, AnElement.AddElement('_IMAGE'), 1208, [1211, 2621]);
                   ExportPhotoCell(AForm, AnElement.AddElement('_IMAGE'), 1209, [1212, 2622]);
                   ExportPhotoCell(AForm, AnElement.AddElement('_IMAGE'), 1210, [1213, 2623]);
               end;

           308, 318 :
               begin
                   AnElement := ATranslator.ExportTag(MISC_PHOTOS);
                   ExportPhotoCell(AForm, AnElement.AddElement('_IMAGE'), 1222, [2624, 2625]);
                   ExportPhotoCell(AForm, AnElement.AddElement('_IMAGE'), 1223, [2626, 2627]);
                   ExportPhotoCell(AForm, AnElement.AddElement('_IMAGE'), 1224, [2628, 2629]);
               end;
           309 :
               begin
                   AnElement := ATranslator.ExportTag(SUBJECT_PHOTOS);
                   ExportPhotoCell(AForm, AnElement.AddElement('_IMAGE'), 1205, [925, 926]);
               end;
           310, 320 :
               begin
                   AnElement := ATranslator.ExportTag(SUBJECT_PHOTOS);
                   ExportPhotoCell(AForm, AnElement.AddElement('_IMAGE'), 1208, [1211, 2621]);
                   ExportPhotoCell(AForm, AnElement.AddElement('_IMAGE'), 1209, [1212, 2622]);
               end;
           319 :
               begin
                   AnElement := ATranslator.ExportTag(SUBJECT_PHOTOS);
                   ExportPhotoCell(AForm, AnElement.AddElement('_IMAGE'), 1205, [925, 926]);
               end;

           321 :
               begin
                   AnElement := ATranslator.ExportTag(SUBJECT_PHOTOS);
                   ExportPhotoCell(AForm, AnElement.AddElement('_IMAGE'), 1208, []);
                   ExportGraphicCell(AForm.GetCellByXID_MISMO(1158) as TGraphicCell, AnElement, imtMap);
                   AnElement.AttributeValues['_Identifier'] := IntToStr(AForm.frmInfo.fFormUID);
               end;

           322, 323 :
               begin
                   AnElement := ATranslator.ExportTag(SUBJECT_PHOTOS);
                   ExportPhotoCell(AForm, AnElement.AddElement('_IMAGE'), 1222, [2624]);
                   ExportPhotoCell(AForm, AnElement.AddElement('_IMAGE'), 1223, [2626]);
               end;

           304, 314 : AnElement := ATranslator.ExportTag(COMPARABLE_SALE_PHOTOS);

           306, 316 : AnElement := ATranslator.ExportTag(COMPARABLE_LISTING_PHOTOS);

           307, 317 : AnElement := ATranslator.ExportTag(COMPARABLE_RENTAL_PHOTOS);

           //                 extra grid
           2, 8, 10, 12, 19, 20, 21, 35, FMAE_2055_1996_XCOMPS, 40, 78, 79, 83, 122, 135, 139, 171, 172, 173, 362, 363, 364, 365, 366, 367 :
               begin
                   AnElement := ExportForm(AForm, ATranslator);

                   case AForm.FormID of
                       FMAE_1004_1993_XCOMPS : ColumnOneSequenceNumber := 44;
                       FMAE_1073_1997_XCOMPS : ColumnOneSequenceNumber := 46;
                       LAND_APPRAISAL_XCOMPS : ColumnOneSequenceNumber := 33;
                       //                                  12:
                       FMAE_1025_1994_XLISTS : ColumnOneSequenceNumber := 25;
                       FMAE_1025_1994_XRENTS : ColumnOneSequenceNumber := 57;
                       FMAE_1025_1994_XCOMPS : ColumnOneSequenceNumber := 61;
                       //                                  35:
                       FMAE_2055_1996_XCOMPS, FMAE_2065_1996_XCOMPS : ColumnOneSequenceNumber := 37;
                       (*
                                                         78:
                                                         79:
                                                         83:
                                                         122:
                                                         135:
                                                         139:
                                                         171:
                                                         172:
                                                         173:
                                   *)
 (*
                       362 : ColumnOneSequenceNumber := 47;
                       FMX_1004_XCOMP, FMX_1004C_XCOMP : ColumnOneSequenceNumber := 43;
                       FMX_2000A_XCOMP : ColumnOneSequenceNumber := 59;
                       FMX_2090_XCOMP : ColumnOneSequenceNumber := 52;
                       FMX_1073_XCOMP : ColumnOneSequenceNumber := 48;
                   else
                       raise Exception.Create('This form''s column identifier cell is not set');
                   end;

                   Assert(AForm.frmPage.Count = 1, 'Extra Grid form ' + AForm.frmSpecs.fFormName + ' does not have only one page');
                   with AForm.frmPage[0] do
                   begin
                       Assert(ColumnOneSequenceNumber <= pgData.Count);
                       ColumnOneIdentifier := StrToInt(pgData[ColumnOneSequenceNumber - 1].Text); //    SequenceNumbers are one-based and the pgData is zero-based
                       if ColumnOneIdentifier <= 9 then
                       begin
                           ThisComparableIdentifier := COMPARABLE_INDEX_NAMES[ColumnOneIdentifier] + ' ' +
                               COMPARABLE_INDEX_NAMES[ColumnOneIdentifier + 1] + ' ' +
                               COMPARABLE_INDEX_NAMES[ColumnOneIdentifier + 2];
                       end
                       else
                       begin
                           ThisComparableIdentifier :=
                               'Comparable' + StringReplace(uCraftClass.FormatCamelCap(uCraftClass.DescribeCount(ColumnOneIdentifier)), ' ', '', [rfReplaceAll]) + ' ' +
                               'Comparable' + StringReplace(uCraftClass.FormatCamelCap(uCraftClass.DescribeCount(ColumnOneIdentifier + 1)), ' ', '', [rfReplaceAll]) + ' ' +
                               'Comparable' + StringReplace(uCraftClass.FormatCamelCap(uCraftClass.DescribeCount(ColumnOneIdentifier + 2)), ' ', '', [rfReplaceAll]);
                       end;
                   end;

                   AnElement.AttributeValues['_ComparableIdentifier'] := ThisComparableIdentifier;

                   ExportExtraGroupCell(EXTRA_SALES_GRID_FORM_SUMMARY_COMMENT_CELLID, ThisComparableIdentifier);
                   ExportExtraGroupCell(EXTRA_RENTAL_GRID_FORM_COMMENT_CELLID, ThisComparableIdentifier);
                   ExportExtraGroupCell(EXTRA_LISTING_GRID_FORM_COMMENT_CELLID, ThisComparableIdentifier);
                   ExportExtraGroupCell(EXTRA_SALES_GRID_FORM_PREVIOUS_SALES_CELLID, ThisComparableIdentifier);
                   ExportExtraGroupCell(EXTRA_SALES_GRID_FORM_COMMENT_CELLID, ThisComparableIdentifier);
               end;
       else
           Result := False;
       end;

       if Result then
           SetFormIdentification(AnElement, AForm);
   end;

*)

end.
