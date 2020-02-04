unit UAMC_Util_ISGN;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2012 by Bradford Technologies, Inc. }

{  Utility module for ISGN}

interface

uses
  Classes,  IniFiles, Contnrs, UGlobals, UWinUtils, Forms, UMain,
  MSXML6_TLB, ISGN_GetOrderDataResponse, UAMC_ODP;
  function ISGNConvertRespToOrd(responseStr: String): IXMLREQUEST_GROUP;

implementation

uses
  SysUtils, StrUtils, Dialogs, UBase64,
  UAMC_Globals;

//Setup any MISMO related filesPaths, etc here
function ISGNConvertRespToOrd(responseStr: String): IXMLREQUEST_GROUP;
var
  GatorsAPI: IXMLGatorsAPIType;
  ODPInfo: IXMLREQUEST_GROUP;
  Cntr, BCntr: Integer;

  function GetStructureType(TypeID: Integer): String;
  begin
    case TypeID of
      1: Result := '1 Story - Single Family';
      2: Result := '2 Story - Single Family';
      3: Result := '2 Story Bi-Level - Single Family';
      4: Result := '1 1/2 Story - Single Family';
      5: Result := '2 1/2 Story - Single Family';
      6: Result := 'Split Level - Single Family';
      7: Result := 'Condo';
      8: Result := '3 Story';
      20: Result := 'Mobile/Manufactured Housing';
      30: Result := 'Multiple';
      40: Result := 'Town House';
      41: Result := 'Duplex';
      50: Result := 'Urban Row House';
    else
      Result := 'Unknown';
    end;
  end;
  
begin
  //##  GatorsAPI := LoadGatorsAPI(appPref_DirReports + '\ISGN\getOrderDataResponse.xml');
  GatorsAPI := LoadGatorsAPIData(responseStr);
  ODPInfo := NewREQUEST_GROUP;
  ODPInfo.SUBMITTING_PARTY._TransactionIdentifier := ' ';
  AMCENV_Req := GatorsAPI.Order_Data.Appraisal.ENV_Req;

  with ODPInfo.REQUEST.REQUEST_DATA.VALUATION_REQUEST.LOAN._APPLICATION.PROPERTY_ do
    begin
      _StreetAddress := GatorsAPI.Order_Data.Appraisal.PropertyAddress.StreetAddress;
      _City := GatorsAPI.Order_Data.Appraisal.PropertyAddress.City;
      _State := GatorsAPI.Order_Data.Appraisal.PropertyAddress.State;
      _PostalCode := GatorsAPI.Order_Data.Appraisal.PropertyAddress.ZipCode;
      _County := GatorsAPI.Order_Data.Appraisal.PropertyAddress.County;
      STRUCTURE.PropertyCategoryType := GetStructureType(StrToIntDef(GatorsAPI.Order_Data.Appraisal.StructureType, 0));
    end;
  with ODPInfo.REQUEST.REQUEST_DATA.VALUATION_REQUEST do
    begin
      _Product.ServiceRequestedCompletionDueDate := GatorsAPI.Order_Data.Appraisal.Dates.ProjHardcopyDate;
      _RushIndicator := 'N';
      _PRODUCT._NAME._Description  := IntToStr(GatorsAPI.Order_Data.Appraisal.Appraisal_Code);
      _PRODUCT.ServiceRequestedPriceAmount := GatorsAPI.Order_Data.Appraisal.ActualCost;
      _CommentText := GatorsAPI.Order_Data.Appraisal.AppraisalInfo;
    end;
  with ODPInfo.REQUEST.REQUEST_DATA.VALUATION_REQUEST.LOAN._APPLICATION do
    begin
      MORTGAGE_TERMS.LenderCaseIdentifier := GatorsAPI.Order_Data.Appraisal.LoanNo;
      LOAN_PURPOSE._Type := GatorsAPI.Order_Data.Appraisal.Loan_Desc;
    end;
  with ODPInfo.REQUEST.REQUEST_DATA.VALUATION_REQUEST.PARTIES do
    begin
      if GatorsAPI.Order_Data.Appraisal.Contacts.Count > 0 then
        for Cntr := 0 to Pred(GatorsAPI.Order_Data.Appraisal.Contacts.Count) do
          begin
            if (Uppercase(GatorsAPI.Order_Data.Appraisal.Contacts[Cntr].Type_) = 'BORROWER') or
               (Uppercase(GatorsAPI.Order_Data.Appraisal.Contacts[Cntr].Type_) = 'COBORROWER') then
              begin
                BORROWER.Add;
                BCntr := Pred(BORROWER.Count);
                BORROWER[BCntr]._PrintPositionType := GatorsAPI.Order_Data.Appraisal.Contacts[Cntr].Type_;
                BORROWER[BCntr]._FirstName := GatorsAPI.Order_Data.Appraisal.Contacts[Cntr].Name;
                BORROWER[BCntr]._LastName := GatorsAPI.Order_Data.Appraisal.Contacts[Cntr].LastName;
                if GatorsAPI.Order_Data.Appraisal.Contacts[Cntr].PhoneNo <> '' then
                  begin
                    BORROWER[BCntr].CONTACT_DETAIL.Add;
                    BORROWER[BCntr].CONTACT_DETAIL[0]._Type := 'PHONE';
                    BORROWER[BCntr].CONTACT_DETAIL[0]._RoleType := 'HOME';
                    BORROWER[BCntr].CONTACT_DETAIL[0]._Value := GatorsAPI.Order_Data.Appraisal.Contacts[Cntr].PhoneNo;
                  end;
              end
            else if (Uppercase(GatorsAPI.Order_Data.Appraisal.Contacts[Cntr].Type_) = 'LENDER') then
              begin
                AMCLenderID := GatorsAPI.Order_Data.Appraisal.Contacts[Cntr].ID;
                LENDER._UnparsedName := GatorsAPI.Order_Data.Appraisal.Contacts[Cntr].Contact + ', ' +
                     GatorsAPI.Order_Data.Appraisal.Contacts[Cntr].Name + '/' + AMCLenderID;
                LENDER._StreetAddress := GatorsAPI.Order_Data.Appraisal.Contacts[Cntr].StreetAddress;
                LENDER._City := GatorsAPI.Order_Data.Appraisal.Contacts[Cntr].City;
                LENDER._State := GatorsAPI.Order_Data.Appraisal.Contacts[Cntr].State;
                LENDER._PostalCode := GatorsAPI.Order_Data.Appraisal.Contacts[Cntr].ZipCode;
                LENDER._Email := GatorsAPI.Order_Data.Appraisal.Contacts[Cntr].Email_Report_To;
                LENDER._Phone := GatorsAPI.Order_Data.Appraisal.Contacts[Cntr].PhoneNo;
                LENDER._Fax := GatorsAPI.Order_Data.Appraisal.Contacts[Cntr].FaxNo;
              end;
          end;
    end;
  Result := ODPInfo;
end;

end.
