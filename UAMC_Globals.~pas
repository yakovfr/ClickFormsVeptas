unit UAMC_Globals;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2012 by Bradford Technologies, Inc. }

interface

uses
  Classes;

  
const
  //AMC_UIDs UniqueID for AMCs
  AMC_GENERAL       = 0;
  AMC_RELS          = 1;
  AMC_FNC           = 2;
  AMC_StreetLinks   = 3;
  AMC_ClearCapital  = 4;
  AMC_ValuLink      = 5;
  AMC_Axis          = 6;
  AMC_PCVMurcor     = 7;
  AMC_InHouse       = 8;
  AMC_CoreLogic     = 9;
  AMC_LSI           = 10;
  AMC_Landmark      = 11;
  AMC_Solidifi      = 12;
  AMC_NationsVS     = 13;
  AMC_JVI           = 14;
  AMC_Valocity      = 15;
  AMC_TSI           = 16;
  AMC_SoutwestFin   = 17;
  AMC_ISGN          = 18;
  AMC_TitleSource   = 19;
  AMC_EadPortal     = 20;
  AMC_MercuryNetWork = 21;  //Ticket 1202
  AMC_Woodfinn      = 901;

 {  //AMC Portal IDs  and names     moved back to UGSEUploadXML
  amcPortalValuLinkID = 1;   amcPortalValulinkName = 'Valulink';
  amcPortalKyliptixID = 2;   amcPortalKyliptixName = 'Kyliptix';
  amcPortalPCVID      = 3;   amcPortalPCVName = 'PCV';        }

  AMC_SYS_ETrac     = 1;
  AMC_SYS_Woodfinn  = 2;
  AMC_SYS_LenderX   = 3;
  AMC_SYS_RealEC    = 4;
  AMC_SYS_Centract  = 5;

  //Appraisal Delivery Types
  adSavePack        = 1;
  adEmailPack       = 2;
  adUploadPack      = 3;

  //versions of MISMO XML
  cNoXML            = 0;
  cMISMO241         = 1;
  cMISMO26          = 2;
  cMISMO26GSE       = 3;

  ISGN_GetData      = 0;
  ISGN_SubmitData   = 1;
  
  //user descriptions of the data files
  PDFFileDesc   = 'PDF of Appraisal Report';
  ENVFileDesc   = 'ENV of Appraisal Report';
  XML26Desc     = 'UAD - MISMO 26 XML';
  XML26GSEDesc  = 'UAD - MISMO 26 GSE XML';
  XML241Desc    = 'MISMO 241 XML';
  XML2_41Desc   = 'MISMO 2.41 XML';

  XML2_6Desc     = 'UAD - MISMO 2.6 XML';
  XML2_6GSEDesc  = 'UAD - MISMO 2.6 GSE XML';

//messages
  errProblem      = 'A problem was encountered: ';
  msgValSuccess   = 'Congratulations. Your report has been successfully validated.';
  VProgressMsg    = 'Validation in Progress ...';
  SProgressMsg    = 'Submit Report in Progress...';
  PDFFileName     = 'PDFFile.pdf';
  XMLFileName     = 'XMLFile.xml';


{-----------------------------------------------------------}
{ AMC Specific Globals}
{-----------------------------------------------------------}

const
  httpRespOK  = 200;          //Status code from HTTP REST


type
  //TAMC_DataObject for StreetLinks
  TAMCData_StreetLinks = class(TObject)
    FAppraiserHash: String;
    FOrderID: String;
  end;

  //TAMC_DataObject for ISGN
  TAMCData_ISGN = class(TObject)
    FAppraiserHash: String;  // Base64 encoded username + ':' + password
    FOrderID: String;
  end;

  //TAMC_DataObject for TitleSource
  TAMCData_TitleSource = class(TObject)
    FAppraiserHash: String;  // Token used in Authorization Header: "Bearer " + Token
    FOrderID: String;
  end;

  TAMCData_Landmark = class(TObject)
    FOrderID: String;
    FUserID: String;
    FPassword: String;
  end;
  //Ticket #1202
  TAMCData_MercuryNetwork = class(TObject)
    FOrderID: String;
    FUserID: String;
    FPassword: String;
  end;
implementation

end.
