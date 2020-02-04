unit UUADStdResponses;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{  Purpose: Append special responses for UAD Power User auto-response}
{  Instead of installing a new Global Std File and deleting the users}
{  Responses, we will hard code the UAD responses add them manually}

interface

uses
  UStdRspUtil, UStrings, UGlobals;

  procedure AddGlobalUADResponses;
  procedure AddGlobalUADCommentHeadings;


implementation

uses
  IniFiles, SysUtils, UCell, UPaths;

const
  //constants for std respones
  UADCountTypes   = 407;
  UADSalesTypes   = 409;
  UADInfluence    = 410;
  UADViewFactor   = 411;
  UADStoryTypes   = 413;
  UADLocFactor    = 414;
  UADImpTypes     = 416;
  UADWhenTyps     = 417;
  UADCondition    = 418;
  UADQuality      = 419;
  UADListDateTyps = 420;
  UADFinanceList  = 421;
  UADUnknown      = 422;

  UADDataSourceSubj = 1084;

  //constants for cell IDs & their CarryOver Heading



procedure AddGlobalUADResponses;
begin
  //check for UAD Counts: 0..9
  if not assigned(AppResponses.GetResponse(UADCountTypes)) then
    AppResponses.AddResponse(UADCountTypes, UADCountTypeList)
  else
    AppResponses.UpdateRspItems(UADCountTypes, UADCountTypeList);

  //check for UAD sales types
  if not assigned(AppResponses.GetResponse(UADSalesTypes)) then
    AppResponses.AddResponse(UADSalesTypes, UADSalesTypeList)
  else
    AppResponses.UpdateRspItems(UADSalesTypes, UADSalesTypeList);

  //check for UAD Influence types
  if not assigned(AppResponses.GetResponse(UADInfluence)) then
    AppResponses.AddResponse(UADInfluence, UADInfluenceList)
  else
    AppResponses.UpdateRspItems(UADInfluence, UADInfluenceList);

  //check for UAD View Fcators types
  if not assigned(AppResponses.GetResponse(UADViewFactor)) then
    AppResponses.AddResponse(UADViewFactor, UADViewFactorList)
  else //View list was modified, now need to update on every startup
    AppResponses.UpdateRspItems(UADViewFactor, UADViewFactorList);

  //check for UAD View Fcators types
  if not assigned(AppResponses.GetResponse(UADStoryTypes)) then
    AppResponses.AddResponse(UADStoryTypes, UADStoryTypList)
  else
    AppResponses.UpdateRspItems(UADStoryTypes, UADStoryTypList);

  //check for UAD Location Factors types
  if not assigned(AppResponses.GetResponse(UADLocFactor)) then
    AppResponses.AddResponse(UADLocFactor, UADLocFactorList)
  else
    AppResponses.UpdateRspItems(UADLocFactor, UADLocFactorList);

  //check for UAD Improvement types
  if not assigned(AppResponses.GetResponse(UADImpTypes)) then
    AppResponses.AddResponse(UADImpTypes, UADImproveTypList)
  else
    AppResponses.UpdateRspItems(UADImpTypes, UADImproveTypList);

  //check for UAD When types
  if not assigned(AppResponses.GetResponse(UADWhenTyps)) then
    AppResponses.AddResponse(UADWhenTyps, UADWhenTypList)
  else
    AppResponses.UpdateRspItems(UADWhenTyps, UADWhenTypList);

  //check for UAD Condition types
  if not assigned(AppResponses.GetResponse(UADCondition)) then
    AppResponses.AddResponse(UADCondition, UADConditionList)
  else
    AppResponses.UpdateRspItems(UADCondition, UADConditionList);

  //check for UAD Construction Quality types
  if not assigned(AppResponses.GetResponse(UADQuality)) then
    AppResponses.AddResponse(UADQuality, UADQualityList)
  else
    AppResponses.UpdateRspItems(UADQuality, UADQualityList);

  //check for UAD Listing Date types
  if not assigned(AppResponses.GetResponse(UADListDateTyps)) then
    AppResponses.AddResponse(UADListDateTyps, UADListDateTypList)
  else
    AppResponses.UpdateRspItems(UADListDateTyps, UADListDateTypList);
  if not assigned(AppResponses.GetResponse(UADFinanceList)) then
    AppResponses.AddResponse(UADFinanceList, UADFinanceTypList);

  //check for Unknown "Unk" response types
  if not assigned(AppResponses.GetResponse(UADUnknown)) then
    AppResponses.AddResponse(UADUnknown, UADUnknownAbbr);

  //Check for DataSource Subject response
  if not assigned(AppResponses.GetResponse(UADDataSourceSubj)) then
    AppResponses.AddResponse(UADDataSourceSubj, UADDataSourceSubjList)
  else
    AppResponses.UpdateRspItems2(UADDataSourceSubj, UADDataSourceSubjList);

end;

procedure AddGlobalUADCommentHeadings;
var
  INIFile: TINIFile;
begin
  INIFile := TINIFile.Create(TCFFilePaths.Preferences + cCellUserPreferencesFile);
  try
    INIFile.WriteString('2065', 'Caption', 'SUBJECT LISTING HISTORY');
    INIFile.WriteString('2056', 'Caption', 'SALES CONTRACT ANALYSIS');
    INIFile.WriteString('2057', 'Caption', 'FINANCIAL ASSISTANCE / CONCESSIONS');
    INIFile.WriteString('520',  'Caption', 'SUBJECT CONDITION');
//    INIFile.WriteString(ID, 'Caption', 'Project Description');
//    INIFile.WriteString(ID, 'Caption', 'Management Group');
//    INIFile.WriteString(ID, 'Caption', 'Management Group');
(*
multi-checkbox dialog
    MgmtGrpType: Heading := 'Management Group Description';
    UnitPUDType: Heading := 'Unit Type(s) Description';
    CoopGrpType: Heading := 'Cooperative Project Management Description';
*)
  finally
    FreeAndNil(INIFile);
  end;
end;

end.
