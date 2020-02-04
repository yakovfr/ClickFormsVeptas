unit UAMC_CheckUAD_Rules;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2012 by Bradford Technologies, Inc. }

//Replace TListView with TosAdvDbGrid  09/21/2012 PN

interface

uses
  MSXML6_TLB, Classes, ComCtrls, osAdvDbGrid, Graphics, TSGrid, UAMC_XMLUtils, UGridMgr, UCell;



  procedure InitCounters;
  procedure InitVariables;
  procedure LoadIniFile;
  procedure FreeIniFile;
  procedure LoadXPathSchema;
  procedure CheckXPathSchema(Log: TosAdvDbGrid);

  function ProcessElement(var strNamespaceURI, strLocalName,
    strQName: WideString; const oAttributes: IVBSAXAttributes; var Log: TosAdvDbGrid; XPath: TStringList): Word;

  function ProcessEndElement(XPath: TStringList; Log: TosAdvDbGrid): Byte;

  procedure CollectAttributes(var strNamespaceURI, strLocalName,
  strQName: WideString; const oAttributes: IVBSAXAttributes; Log: TosAdvDbGrid; XPath: TStringList; FormTypeStr: String);


var
  _FormType: String;
  FormTypeError: Boolean;
  ComparableSaleError: Boolean;
  _ShowPassed: Boolean;
  _ShowWarnings: Boolean;
  SalesGridManager,ListingGridManager: TGridMgr;

implementation

uses
  SysUtils, IniFiles, Windows, Dialogs,
  UGlobals, UAMC_CheckUAD_Globals, UUtil2, UUADUtils;

type
// To be used to check the similarity of the descriptions of adjustments betweeen Subject and Comparables
  TAdjustmentInfo = record
    Description: TStringList;
    Amount, Name: String;
  end;

  TAdjustmentArray = array of TAdjustmentInfo;

const

//Ini file identifiers
  DataPoint         = 'DataPoint';
  DataPointString   = 'DataPointString';
  FormField         = 'FormField';
  FormSection       = 'FormSection';
  ErrorCode         = 'ErrorCode';
  ErrorMessage      = 'ErrorMessage';
  LogicError1       = 'LogicError1';
  LogicError2       = 'LogicError2';
  LogicError3       = 'LogicError3';
  Suggestion        = 'Suggestion';
  ErrorUndetermined = 'ErrorUndetermined';

//US States
  States          = 'wa,or,ca,ak,nv,id,ut,az,hi,mt,wy,co,nm,nd,sd,ne,ks,ok,tx,mn,ia,mo,ar,la,wi,il,ms,mi,in,ky,tn,al,fl,ga,sc,nc,oh,wv,va,pa,ny,vt,me,nh,ma,ri,ct,nj,de,md,dc,as,fm,gu,mh,mp,pr,pw,vi';

  InvalidValue = '$$invalid';
  InvalidInt   = -9898989;

  UADRuleTypesfName   = 'UADRuleTypes.ini';
  UADXPathSchemafName = 'UADXpathSchema.nfo';


{  'Local Variables'}
var
  IniFile: TIniFile;
  XPathSchema: TStringList;

  CommonInt, CommonInt1: Integer;
  CommonBool, CommonBool1: Boolean;
  CommonStr, Param1, Param2, Param3, CurrentValue: String;
  CommonFloat, CommonFloat1: Real;

// Cycle 2 XML Data-----------------------------------------------------------------------

  //XPath trackers
  ComparableSale_PropertySequenceIdentifier: Byte;
  Subject_SalesPriceAdjustmentOther_Counter: Byte;
  ExtensionSectionOrganizationName: Boolean;

   //Adjustment Description Checking
  SubjectAdjustments, ComparableAdjustments, Adjustments: TAdjustmentArray;

  //Saved values
  _HOAType: String;
  _HOAAmount: String;
  _AppraisalPurposeType: String;
  _ListedWithinPreviousYearIndicator: String;

  _SalesContractAmount: Integer;

  _SalesConcessionIndicator: String;

  nGSEViewType: Byte;
  nGSELocationType: Byte;

  nGSEShortDateDescription: Byte;
  ShortDateFailed: Boolean;

  TotalSalePriceAdjustmentAmount: Integer;
  _TotalSalePriceAdjustmentAmount: Integer;

  ComparablePriorSaleIndicator: Char;
  SubjectPriorSaleIndicator: Char;

  nGSEPriorSaleAttribPresent: Byte;
  nPropertySaleAttribPresent: Byte;

  _CommercialSpaceIndicator: String;
  nSalesAdjustment: Byte;
  _ParkingSpaceCount: String;

  // variables shared by both Cycle1 and Cycle2   -------------------------------------------
  _GSEUndefinedConcessionAmountIndicator: String;

  GSEListingStatusType_Comparisons: array of String;
  GSEContractDateUnknownIndicator_Comparison: array of String;
  ComparisonCounter: Byte;

  isValidGSEUpdateLastFifteenYearIndicator: Boolean;
  _GSEUpdateLastFifteenYearIndicator: String;

  _GSE_PUDIndicator: String;

  _SupervisorName: String;




{  'Private Functions'}

function GetAttributeValue(oAttributes: IVBSAXAttributes; const DataPoint: String; var Found: Boolean; var _CurrentValue: String): String;
var
  i: byte;
begin
  Result := '';
  _CurrentValue := '';
  Found := False;

  if oAttributes.length <> 0 then
    for i := 0 to oAttributes.length - 1 do
      if oAttributes.getLocalName(i) = DataPoint then
      begin
        Result := oAttributes.getValue(i);
        _CurrentValue := oAttributes.getValue(i);
        Found := True;
        exit;
      end;
  _CurrentValue := '[Attribute Absent]';
end;


function GetUADFailureUID(ThisGridManager: TGridMgr; ColID, XID: Integer): CellUID;
var
  ColCounter, RowCounter, SubColCounter: Integer;
  ThisColumn : TCompColumn;
  ThisCell: TBaseCell;
  Found: Boolean;
  UseThisCell:Boolean;
begin
  Found := False;
  for ColCounter := 0 to ThisGridManager.Count - 1 do     //  ThisGridManager is a TObjectList of TCompColumns
    begin
      if ColCounter <> ColID then
         Continue
      else
      begin
        ThisColumn := ThisGridManager.Comp[ColID];
        if assigned(ThisColumn) then
          for RowCounter := 0 to ThisColumn.RowCount - 1 do
          begin
            if Found then Break;
            for SubColCounter := 0 to 1 do
            begin
                ThisCell := ThisColumn.GetCellByCoord(Point(SubColCounter,RowCounter));
                if Assigned(ThisCell) then
                begin
                   if (ThisCell.FCellXID = XID) then   //do the normal way
                   begin
                         Result := ThisCell.UID;
                         Found := True;
                   end;
                   // handle 1073 and 1075 page2 prior sale section, the xid are different than other standard forms
                   if (_FormType = 'FNM1073') or (_FormType = 'FNM1075') then
                   begin
                     UseThisCell := False;
                     if XID > 0 then //we have an XID
                     begin
                       //both FCellXID on the form and XID from the ini are using the same cell
                       if (ThisCell.FCellXID = 934) and (XID=9001) then UseThisCell:=True
                       else if (ThisCell.FCellXID = 935) and (XID=9002) then UseThisCell:=True
                       else if (ThisCell.FCellXID = 936) and (XID=9003) then UseThisCell:=True
                       else if (ThisCell.FCellXID = 2074) and (XID=9004) then UseThisCell := True;
                     end;
                     if UseThisCell then
                     begin
                         Result := ThisCell.UID;
                         Found := True;
                     end;
                   end;
                end;
            end;
          end;
      end;
    end;
end;

//look at the datapoint array to get the xid from the array
function GetXIDFromDataPointArray(DataPoint:String):Integer;
var
  i:Integer;
begin
// locate the matching data point in this array: AdjustmentLabels then use the index to pull out the XID from AdjustmentXIDArray
    for i:=low(AdjustmentLabels) to high(AdjustmentLabels) do
    begin
        if pos(Uppercase(AdjustmentLabels[i]),UpperCase(DataPoint))>0 then
        begin
           result := AdjustmentXIDArray[i];
           Break;
        end;
    end;
end;

//look at the utility array to get the xid from the array
function GetXIDFromUtilityArray(DataPoint:String): String;
var i:Integer;
begin
// locate the matching data point in this array: UtilityLabels then use the index to pull out the XID from AdjustmentXIDArray
   for i:=low(UtilityLabels) to high(UtilityLabels) do
     if pos(Uppercase(UtilityLabels[i]), UpperCase(DataPoint)) > 0 then
       begin
         result := UtilityXIDArray[i];
         Break;
       end;
end;

// aXID = aXID1,aXID2  -- for form 1004 and others use aXID1, for form 1073 and 1075 use aXID2
function GetXIDByForm(aXID:String):String;
var aXID1,aXID2:String;
begin
   aXID1 := popStr(aXID,',');
   aXID2 := aXID;
   if (_FormType = 'FNM1073') or (_FormType = 'FNM1075') then
       result := aXID2
   else
       result := aXID1;
end;

procedure AddLogEntry(Grid: TosAdvDbGrid; const IniId: String; Values: array of String; const ImageIndex: Byte; const _XPath: String = ' '; const CurrentValue: String = ' '; const UAD: String = ' ');
const
  ColFieldLabel   = 3;
  ColDataPoint    = 4;
  ColCurrentValue = 5;
  ColErrorMessage = 6;
  ColSuggestion   = 7;
  ColIniID        = 8;
  ColXID          = 9;
  colCompCell     = 10;
var
  i: byte;
  aRow, ColID, ImgTypeID, aTextWidth, aColWidth, aMaxCol: Integer;
  clUID: CellUID;
  aDataPoint, aItem, aXID, S: String;
begin
  if (not _ShowPassed) and (ImageIndex = 2) then
    Exit;

  ImgTypeID := IniFile.ReadInteger(IniID, 'ImageType', 1);
  if (not _ShowWarnings) and ((ImgTypeID = 0) or (ImgTypeID = 1)) then
    Exit;

  Grid.Rows := Grid.Rows + 1;

  aRow := Grid.Rows;
  Grid.RowWordWrap[aRow] := wwOn;
  for i := 0 to Length(Values) do
    if Values[i] = '' then
      Values[i] := ' ';

  if CurrentValue <> '' then
    Values[2] := '%' + CurrentValue;

  for i := 0 to length(Values) - 1 do
    if i = 0 then
      begin
        if Values[i] = '' then  // 2005 change
          Values[i] := ' ';
        Grid.Col[i+1].ControlType := ctPicture;   //column i+1 is the image type column
        Grid.Cell[i+1,aRow] := Grid.ImageList.Image[ImgTypeID].name; //image type
        Grid.Cell[i+3,aRow] := IniFile.ReadString(IniID, values[i],'');  //column i+3 is the field label column
      end
    else
      begin
        if Values[i] = '' then  // 2005 change
          Values[i] := ' ';
        if (StrToIntDef(IniID,0) = 158) or (StrToIntDef(IniID,0) = 159) then //Handle Multiple Data Point differently
        begin
           aDataPoint := Grid.Cell[colDataPoint,aRow];
           if aDataPoint<>'' then
              Grid.Cell[colXID,aRow] := GetXIDFromDataPointArray(aDataPoint)
           else
              Grid.Cell[colXID,aRow] := IniFile.ReadString(IniID,'ErrorCode','');
        end
        else if (StrToIntDef(IniID,0)=30) then //Handle Multiple Data Point differently
        begin
           aDataPoint := Grid.Cell[ColCurrentValue,aRow];
           if aDataPoint<>'' then
              Grid.Cell[colXID,aRow] := GetXIDFromDataPointArray(aDataPoint)
           else
              Grid.Cell[colXID,aRow] := IniFile.ReadString(IniID,'ErrorCode','');
        end
        /// Handle datapoint: SEPriorSaleDate for 1004 and 1073 with different XID
        /// Load the property XID for each form to the grid.

        else if (StrToIntDef(IniID,0)=129) or (StrToIntDef(IniID,0)=130) then
        begin
           aXID := IniFile.ReadString(IniID,'ErrorCode','');
           if (pos(',',aXID) > 0) then
              aXID:=GetXIDByForm(aXID);
           Grid.Cell[colXID,aRow] := aXID;
        end

        else
           Grid.Cell[colXID,aRow] := IniFile.ReadString(IniID,'ErrorCode','');
        //pass column #, XID, and grid manager to return cellUID
        clUID := GetUADFailureUID(SalesGridManager,ComparableSale_PropertySequenceIdentifier,StrToIntDef(Grid.Cell[colXID,aRow],0));
        if clUID.Num = 0 then
          begin
            ColID := ComparableSale_PropertySequenceIdentifier;
            if (SalesGridManager.Count > 0) and (ColID > 0) then
              ColID := ColID - Pred(SalesGridManager.Count);
           clUID := GetUADFailureUID(ListingGridManager,ColID,StrToIntDef(Grid.Cell[colXID,aRow],0));
          end;
        if clUID.Num<>0 then
        begin
           aItem := Format('%d,%d,%d,%d',[clUID.FormID,clUID.Form,clUID.Pg,clUID.Num]);
           Grid.Cell[colCompCell,aRow] := aItem;
        end
        else
           Grid.Cell[colCompCell,aRow] := '';
        if Pos('%', Values[i]) = 0 then
          Grid.Cell[i+3,aRow] := IniFile.ReadString(IniId, Values[i], '')
        else
          begin
           // ------------- 2005 ---------
            if Values[i][1] = '%' then
              S := Copy(Values[i], 2, 100)
            else
              S :=  Copy(Values[i], 1, Pos('%', Values[i]) - 1);

            S := IniFile.ReadString(IniId, S, '') + Copy(Values[i], Pos('%', Values[i]) + 1, 512);


            if S = '' then
              S := ' ';

            // --------------- 2005 -------------
            //need to expand the height if column width not fit the text width
            Grid.Cell[i+3,aRow] := S;
          end;
      end;
  if _XPath <> '' then
     Grid.Cell[i+3,aRow]:= _XPath;

  if CurrentValue <> '' then
     Grid.Cell[i+3,aRow]:= CurrentValue;

  if UAD <> '' then
     Grid.Cell[i+3,aRow]:= UAD;

  if IniID <> '' then
     Grid.Cell[colIniID,aRow]:= IniId;

  //go through grid column with the current row to find the max text width for that row
  aTextWidth := 0;
  aMaxCol := 0;
  for i:= colFieldLabel to ColSuggestion do //we only use these column to recalculate the row height
  begin
      if Grid.Canvas.TextWidth(Grid.Cell[i,aRow]) > aTextWidth then
      begin
         aMaxCol := i;  //found the max col
         aTextWidth := Grid.Canvas.TextWidth(Grid.Cell[aMaxCol,aRow]);
      end;
  end;
  if aMaxCol > 0 then
  begin
    aTextWidth := Grid.Canvas.TextWidth(Grid.Cell[aMaxCol,aRow]);
    acolWidth := Grid.Col[aMaxCol].Width;
    if aTextWidth  > acolWidth then
    begin
      Grid.RowHeight[aRow]   := (Pred(Round(aTextWidth / aColWidth)) * Trunc(Grid.RowOptions.DefaultRowHeight / 2)) + Grid.RowOptions.DefaultRowHeight;
      Grid.RowWordWrap[aRow] := wwOn;
    end;
  end;
end;



{$HINTS OFF}
function ValidateZipCode(const Z: String):Boolean;
var
  ErrorCode, Number: Integer;
begin
  Result := True;

  if (Length(Z) <> 5) and (Length(Z) <> 10)  then
    Result := False
  else
    if (Z[1] = '+') or (Z[1] = '-') then
     Result := False
    else
    if Length(Z) = 5 then
      begin
        Val(Z, Number, ErrorCode);

        if ErrorCode <> 0 then
          Result := False;
      end
    else
      if Z[6] <> '-' then
        Result := False
      else if (Z[7] = '+') or (Z[7] = '-') then
        Result := False
      else begin
        Val(Copy(Z, 7, 4), Number, ErrorCode);

        if ErrorCode <> 0 then
          Result := False;
      end;
end;
{$HINTS ON}

function ValidateCurrency(const Currency: String; var FormatedNumber: Integer):Boolean;
var
  j: Byte;
  S: String;
  ErrorCode: Integer;
begin
  S := Currency;
  Result := True;

  j := Pos('.', S);

  if (j <> 0) and (j <> Length(S) - 2) then
    Result := False
  else
  begin
    if j <> 0  then
      S := Copy(S, 1, Length(S) - 3);

    Val(S, FormatedNumber, ErrorCode);
    if ErrorCode <> 0 then
    begin
      Result := False;
      FormatedNumber := InvalidInt;
    end;
  end;
end;

function ValidateDate(const D: String): Boolean;
var
  Format: TFormatSettings;
begin
  Format.ShortDateFormat := 'yyyy-mm-dd';
  Format.DateSeparator := '-';

  try
    StrToDate(D, Format);
    Result := True;
  except
    Result := False;
  end;
end;

function ValidateArea(A: String): Boolean;
var
  AreaUnit, Value, S: String;
begin
  Result := True;

  A := Trim(A);
  S := A;
  A := S;

  if Length(A) < 3 then
    Result := False
  else
    begin
      AreaUnit := Copy(A, Length(A) - 1, 2);

      if (AreaUnit <> 'sf') and (AreaUnit <> 'ac') then
        Result := False
      else
        begin
          Value := Trim(Copy(A, 0, Length(A) - 2));
          //check sqfeet
          if AreaUnit = 'sf' then
            begin
              try
                if StrToInt(Value) >= 43560 then
                  Result := False;
              except
                Result := False;
              end;
            end;
          //check acres
          if AreaUnit = 'ac' then
            begin
              try
                if StrToFloat(Value) < 1 then
                  Result := False;

                if (Pos('.', Value) <> 0) and (Pos('.', Value) <> Length(Value) - 2) then
                  Result := False;
              except
                Result := False;
              end;
            end;

        end;
    end;
end;

function ValidateNumber(N: String; const Decimals: Byte; var Value: Real; const JustInt: Boolean = False): Boolean;
var
  S1: String;
  tmpInt: Integer;
  tmpFloat: double;
begin
  Value := InvalidInt;
  N := Trim(N);

  if JustInt then
    begin
      result := TryStrToInt(N,tmpInt);
      if result then
        value := tmpInt
      else
        value := InvalidInt
    end
  else
    begin
      result := TryStrToFloat(N,tmpFloat);
      if result then
        begin
          S1 := Copy(N, Pos('.', N) + 1, 100);
          if (Decimals <> 0) and ((Length(Copy(N, Pos('.', N) + 1, 100)) > Decimals) or (Pos('.', N) = 0)) then
            Result := False;
        end;
      if result then
        value := tmpfloat
      else
        value := invalidInt;
    end;
end;

function ValidateEstimation(E: String): Integer;
var
  Value: String;
  tmpInt: Integer;
begin
  if TryStrToInt(E, tmpInt) then   //is this an integer?
    result := tmpInt
  else begin
    Value := Copy(E, 2, 100);      //does it have leading '~' ?
    try
      if TryStrToInt(Value, tmpInt) then
        result := tmpInt
      else
        result := InvalidInt;
    except
      Result := InvalidInt;
    end;
  end;
end;

function ValidateShortDate(const SD: String): Boolean;
var
  Value: Byte;
begin
  Result := True;
  if (Length(SD) <> 5) or (SD[3] <> '/') then
    Result := False
  else
    begin
      try
        Value := StrtoInt(Copy(SD, 1, 2));

        if (Value > 12) or (Value = 0) then
          Result := False
        else
          begin
            try
              StrtoInt(Copy(SD, 4, 2));
            except
              Result := False;
            end;
          end;
      except
        Result := False;
      end;
   end;
end;

{function IsUADVerForm(ID: Integer): Boolean;
var
  Cntr: Integer;
begin
  Cntr := -1;
  Result := False;
  repeat
    Cntr := Succ(Cntr);
    if ID = UADForms[Cntr] then
      Result := True;
  until Result or (Cntr = MaxUADForms);
end;}

{  'Public Functions'}

procedure LoadIniFile;
begin
  IniFile := TIniFile.Create(IncludeTrailingPathDelimiter(appPref_DirMISMO) + UADRuleTypesfName);
end;

procedure FreeIniFile;
begin
  IniFile.Free;
end;

procedure InitCounters;
begin
 nGSEViewType := 0;
 nGSELocationType := 0;
 ComparisonCounter := 0;
end;

procedure InitVariables;
begin
  _ListedWithinPreviousYearIndicator := '';

  ComparableSale_PropertySequenceIdentifier := 0;
  Subject_SalesPriceAdjustmentOther_Counter := 0;
  ExtensionSectionOrganizationName := False;

  _AppraisalPurposeType := '';

  _SalesConcessionIndicator := '';
  _SalesContractAmount := 0;

  GSEListingStatusType_Comparisons := nil;
  GSEContractDateUnknownIndicator_Comparison := nil;

  nGSEPriorSaleAttribPresent := 0;
  nPropertySaleAttribPresent := 0;

  _GSE_PUDIndicator := InvalidValue;

  _HOAType := '';
  _HOAAmount := '';

  _SupervisorName := InvalidValue;
end;

procedure LoadXPathSchema;
begin
  XPathSchema := TStringList.Create;
  XPathSchema.Clear;
  XPathSchema.LoadFromFile(IncludeTrailingPathDelimiter(appPref_DirMISMO) +  UADXPathSchemafName);
end;

procedure CheckXPathSchema(Log: TosAdvDbGrid);
var
  S, Switch: String;
  i: Byte;
begin
  for i := 0 to XPathSchema.Count - 1 do
  begin
    S := XPathSchema[i];

    if (Trim(S) <> '') and (S[1] = 'F') then
      Switch := S;

    if (Trim(S) <> '') and (S[1] <> 'F') and (S[1] <> ';') and (Pos(_FormType, Switch) <> 0)then
    begin
      if Copy(S, 1, Pos('=', S) - 1) = CreateCommaText([Valuation_Response, _Property, Structure, Condition_Detail_Extension, Condition_Detail_Extension_Section, Condition_Detail_Extension_Section_Data, Condition_Detail]) then
        if _GSEUpdateLastFifteenYearIndicator <> 'Y' then
         Continue;

      if Copy(S, 1, Pos('=', S) - 1) = CreateCommaText([Valuation_Response, _Property, Sales_Contract, Sales_Concession_Extension, Sales_Concession_Extension_Section, Sales_Concession_Extension_Section_Data, Sales_Concession]) then
        if _SalesConcessionIndicator <> 'Y' then
          Continue;

      if Copy(S, 1, Pos('=', S) - 1) = CreateCommaText([Valuation_Response, _Property, Sales_Contract, Sales_Contract_Extension, Sales_Contract_Extension_Section, Sales_Contract_Extension_Section_Data, Sales_Transaction]) then
        if _AppraisalPurposeType <> 'Purchase' then
          Continue;

      if Copy(S, 1, Pos('=', S) - 1) = CreateCommaText([Valuation_Response, _Property, Sales_Contract]) then
        if _AppraisalPurposeType <> 'Purchase' then
          Continue;


      if Copy(S, 1, Pos('=', S) - 1) = CreateCommaText([Valuation_Response, _Property, Project]) then
        if _GSE_PUDIndicator <> 'Y' then
         Continue;


      if Copy(S, 1, Pos('=', S) - 1) =  CreateCommaText([Valuation_Response, _Property, Project, Project_Extension, Project_Extension_Section, Project_Extension_Section_Data, Project_Commercial]) then
        if _CommercialSpaceIndicator <> 'Y' then
          Continue;


      if Copy(S, 1, Pos('=', S) - 1) = CreateCommaText([Valuation_Response, _Property, Property_Extension, Property_Extension_Section, Property_Extension_Section_Data, Property_Type]) then
        if _GSE_PUDIndicator <> 'Y' then
          Continue;


      if Copy(S, 1, Pos('=', S) - 1) = CreateCommaText([Valuation_Response, Parties, Supervisor, Appraiser_License]) then
        if (_SupervisorName = '') or (_SupervisorName = InvalidValue)then
          Continue;

      AddLogEntry(Log,'0', [FormField, DataPointString + '%' + StringReplace(Copy(S, 1, Pos('=', S) - 1), ',', '/', [rfReplaceAll]), ErrorCode, ErrorMessage, Suggestion], 3, '', '', Copy(S, Pos('=', S) + 1, 512));
    end;
  end;

  XPathSchema.Free;
end;

{  'Collect attributes in Cycle 1'}

procedure CollectAttributes(var strNamespaceURI, strLocalName,
  strQName: WideString; const oAttributes: IVBSAXAttributes; Log: TosAdvDbGrid; XPath: TStringList; FormTypeStr: String);
begin
  if FormTypeError then
    Exit;

{  'Form Type Checking'}
  // if the FormType is invalid, it will be considered a fatal rule error and the rest of the process will be terminated
  if XPath.CommaText =  CreateCommaText([Valuation_Response, Report]) then
    begin
    _FormType := 'FNM' + FormTypeStr;

      if not CheckEnum(FormType, _FormType) then
      begin
        AddLogEntry(Log, '1', [FormField, DataPointString, ErrorCode+ CurrentValue, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Report]), CurrentValue, '3');
        FormTypeError := True;
      end;

      Exit;
    end;

{  'Comparable Sale Identifier Checking and Setting'}
  if XPath.CommaText =  CreateCommaText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale]) then
    begin
      CommonStr := GetAttributeValue(oAttributes, 'PropertySequenceIdentifier', CommonBool, CurrentValue);

      try
        ComparableSale_PropertySequenceIdentifier := StrtoInt(CommonStr);
      except
        AddLogEntry(Log, 'ComparableSale_Error', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale]), CurrentValue, '0');
        ComparableSaleError := True;
      end;
    end;

{  'Collect GSEUndefinedConcessionAmountIndicator'}
  if XPath.CommaText =  CreateCommaText([Valuation_Response, _Property, Sales_Contract, Sales_Concession_Extension, Sales_Concession_Extension_Section, Sales_Concession_Extension_Section_Data, Sales_Concession]) then
    if ExtensionSectionOrganizationName then
    begin
      _GSEUndefinedConcessionAmountIndicator := InvalidValue;

      if CheckEnum(YesNo, GetAttributeValue(oAttributes, 'GSEUndefinedConcessionAmountIndicator', CommonBool, CurrentValue)) then
        _GSEUndefinedConcessionAmountIndicator := CurrentValue;
    end;

{  'Collect GSEUpdateLastFifteenYearIndicator'}
  if XPath.CommaText =  CreateCommaText([Valuation_Response, _Property, Structure, Overall_Condition_Rating_Extension, Overall_Condition_Rating_Extension_Section , Overall_Condition_Rating_Extension_Section_Data, Overall_Condition_Rating]) then
    if ExtensionSectionOrganizationName then
    begin
      _GSEUpdateLastFifteenYearIndicator := InvalidValue;

      if CheckEnum(YesNo, GetAttributeValue(oAttributes, 'GSEUpdateLastFifteenYearIndicator', CommonBool, CurrentValue)) then
        _GSEUpdateLastFifteenYearIndicator := CurrentValue;
    end;

{  'Array initialization and data collection for GSEListingStatusType and GSEContractDateUnknownIndicator'}

  //GSEListingStatusType, GSEContractDateUnknownIndicator  Arrays initialization
  if XPath.CommaText =  CreateCommaText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale]) then
    if  ComparableSale_PropertySequenceIdentifier <> 0 then
    begin
      ComparisonCounter := ComparisonCounter + 1;
      SetLength(GSEListingStatusType_Comparisons, ComparisonCounter);
      SetLength(GSEContractDateUnknownIndicator_Comparison, ComparisonCounter);
    end;

  //GSEListingStatusType, GSEContractDateUnknownIndicator  Array values
  if XPath.CommaText =  CreateCommaText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]) then
    if (ComparableSale_PropertySequenceIdentifier <> 0) and (ExtensionSectionOrganizationName) then
    begin
      GSEListingStatusType_Comparisons[ComparisonCounter - 1] := GetAttributeValue(oAttributes, 'GSEListingStatusType', CommonBool, CurrentValue);
      GSEContractDateUnknownIndicator_Comparison[ComparisonCounter - 1] := GetAttributeValue(oAttributes, 'GSEContractDateUnknownIndicator', CommonBool, CurrentValue);
    end;

{  'Collect GSE_PUDIndicator'}
  if XPath.CommaText =  CreateCommaText([Valuation_Response, _Property, Property_Extension, Property_Extension_Section, Property_Extension_Section_Data, Property_Type]) then
    if ExtensionSectionOrganizationName then
    begin
      if XPathSchema.IndexOfName(XPath.CommaText) <> - 1 then
        XPathSchema.Delete(XPathSchema.IndexOfName(XPath.CommaText));

      _GSE_PUDIndicator := GetAttributeValue(oAttributes, 'GSE_PUDIndicator', CommonBool, CurrentValue)
    end;

{  'Collect SupervisorName'}
  if XPath.CommaText =  CreateCommaText([Valuation_Response, Parties, Supervisor]) then
    begin
      _SupervisorName := GetAttributeValue(oAttributes, '_Name', CommonBool, CurrentValue);
    end;

//XPath Tracking --------------

{  'Check the XPath Condition for GSEUndefinedConcessionAmountIndicator'}
  if XPath.CommaText =  CreateCommaText([Valuation_Response, _Property, Sales_Contract, Sales_Concession_Extension, Sales_Concession_Extension_Section]) then
    ExtensionSectionOrganizationName := GetAttributeValue(oAttributes, 'ExtensionSectionOrganizationName', CommonBool, CurrentValue) = 'UNIFORM APPRAISAL DATASET';

{  'Check the XPath Condition for GSEUpdateLastFifteenYearIndicator'}
  if XPath.CommaText =  CreateCommaText([Valuation_Response, _Property, Structure, Overall_Condition_Rating_Extension, Overall_Condition_Rating_Extension_Section]) then
    ExtensionSectionOrganizationName := GetAttributeValue(oAttributes, 'ExtensionSectionOrganizationName', CommonBool, CurrentValue) = 'UNIFORM APPRAISAL DATASET';

{  'Check the XPath Condition for GSEListingStatusType'}
  if XPath.CommaText =  CreateCommaText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section]) then
    ExtensionSectionOrganizationName :=  GetAttributeValue(oAttributes, 'ExtensionSectionOrganizationName', CommonBool, CurrentValue) =  'UNIFORM APPRAISAL DATASET';

{  'Check the XPath Condition for GSE_PUDIndicator '}
  if XPath.CommaText =  CreateCommaText([Valuation_Response, _Property, Property_Extension, Property_Extension_Section]) then
    ExtensionSectionOrganizationName  :=  GetAttributeValue(oAttributes, 'ExtensionSectionOrganizationName', CommonBool, CurrentValue) =  'UNIFORM APPRAISAL DATASET';

end;  // end of CollectAttributes - Cycle 1



//----------------------- MAIN PROCESSOR (Cycle2)----------------------//

function ProcessElement(var strNamespaceURI, strLocalName,
  strQName: WideString; const oAttributes: IVBSAXAttributes; var Log: TosAdvDbGrid; XPath: TStringList): Word;
var
  i: Byte;
begin
  Result := 0;
{  'Check the XPath Condition for Comparable Sale'}

  if XPath.CommaText =  CreateCommaText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale]) then
    begin

      nGSEViewType := 0;
      nGSELocationType := 0;
      ComparableSale_PropertySequenceIdentifier := StrtoInt(GetAttributeValue(oAttributes, 'PropertySequenceIdentifier', CommonBool, CurrentValue));

      if ComparableSale_PropertySequenceIdentifier <> 0 then
        ComparisonCounter := ComparisonCounter + 1;

      ShortDateFailed := False;
      nSalesAdjustment := 1;
    end;


//---------------------------- DataPoint Checking ----------------------//

// SUBJECT

{  '[PROPERTY] -> _StreetAddress, _City, _State, _PostalCode, _CurrentOccupancyType'}

  if XPath.CommaText = CreateCommaText([Valuation_Response, _Property]) then
    begin

      if XPathSchema.IndexOfName(XPath.CommaText) <> - 1 then XPathSchema.Delete(XPathSchema.IndexOfName(XPath.CommaText));

      //UAD 4
      if GetAttributeValue(oAttributes, '_StreetAddress', CommonBool, CurrentValue) = '' then
        begin
          AddLogEntry(Log, '2', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, _Property]), CurrentValue, '4');
          Result := Result +  1;
        end
      else
        AddLogEntry(Log, '2', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, _Property]), CurrentValue, '4');

      //UAD 5
      if GetAttributeValue(oAttributes, '_City', CommonBool, CurrentValue) = '' then
        begin
          AddLogEntry(Log, '3', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, _Property]), CurrentValue, '5');
          Result := Result + 1;
        end
      else
        AddLogEntry(Log, '3', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, _Property]), CurrentValue, '5');

      //UAD 6
      if Pos(LowerCase(GetAttributeValue(oAttributes, '_State', CommonBool, CurrentValue)), States) = 0 then
        begin
          AddLogEntry(Log, '4', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, _Property]), CurrentValue, '6');
          Result := Result + 1;
        end
      else
        AddLogEntry(Log, '4', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, _Property]), CurrentValue, '6');

      //UAD 8
      if not ValidateZipCode(GetAttributeValue(oAttributes, '_PostalCode', CommonBool, CurrentValue)) then
        begin
          AddLogEntry(Log, '5', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, _Property]), CurrentValue, '8');
          Result := Result + 1;
        end
      else
        AddLogEntry(Log, '5', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, _Property]), CurrentValue, '8');

      //UAD 10
      if not CheckEnum(CurrentOccupencyType, GetAttributeValue(oAttributes, '_CurrentOccupancyType', CommonBool, CurrentValue)) then
        begin
          AddLogEntry(Log, '6', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, _Property]), CurrentValue, '10');
          Result := Result + 1;
        end
      else
        AddLogEntry(Log, '6', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, _Property]), CurrentValue, '10');

      Exit;
    end;   //end of XPath.CommaText = CreateCommaText([Valuation_Response, _Property])then



{  '[PROPERTY/PROJECT/_PER_UINIT_FEE] -> _Amount, _PeriodType'}

  if XPath.CommaText =  CreateCommaText([Valuation_Response, _Property, Project, _Per_Unit_Fee]) then
    begin
      CommonInt := XPathSchema.IndexOfName(XPath.CommaText);
      if XPathSchema.IndexOfName(XPath.CommaText) <> - 1 then
        XPathSchema.Delete(XPathSchema.IndexOfName(XPath.CommaText));

      _HOAAmount := InvalidValue;
      _HOAType := InvalidValue;

      if CheckEnum(PerUnitFeePeriodType, GetAttributeValue(oAttributes, '_PeriodType', CommonBool, CurrentValue)) then
        _HOAType := CurrentValue;

      // UAD 13
      if not ValidateNumber(GetAttributeValue(oAttributes, '_Amount', CommonBool, CurrentValue), 0, CommonFloat, True) then
        begin
          AddLogEntry(Log, '7', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, _Property, Project, _Per_Unit_Fee]), CurrentValue, '13');
          AddLogEntry(Log, '8', [FormField, DataPointString, '', ErrorUndetermined, ''], 1);
          Result := Result +  1;
        end
      else
        begin
          AddLogEntry(Log, '7', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, _Property, Project, _Per_Unit_Fee]), CurrentValue, '13');
          _HOAAmount := FloattoStr(CommonFloat);

          // UAD 15
          if CommonFloat > 0 then
            begin
              if not CheckEnum(PerUnitFeePeriodType, _HOAType) then
                begin
                  AddLogEntry(Log, '8', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, _Property, Project, _Per_Unit_Fee]), CurrentValue, '15');
                  Result :=  Result +  1;
                end
              else
                AddLogEntry(Log, '8', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, _Property, Project, _Per_Unit_Fee]), CurrentValue, '15');
            end;
        end;
      Exit;
    end; //end if XPath.CommaText =  CreateCommaText([Valuation_Response, _Property, Project, _Per_Unit_Fee])


{  '[REPORT] -> Form Type, AppraisalPurposeType, AppraisalPurposeTypeOtherDescription'}

  if XPath.CommaText = CreateCommaText([Valuation_Response, Report])then
    begin
      CommonInt := XPathSchema.IndexOfName(XPath.CommaText);
      if XPathSchema.IndexOfName(XPath.CommaText) <> - 1 then
        XPathSchema.Delete(XPathSchema.IndexOfName(XPath.CommaText));

      //UAD 17
      _AppraisalPurposeType := GetAttributeValue(oAttributes, 'AppraisalPurposeType', CommonBool, CurrentValue);
      if not CheckEnum(AppraisalPurposeType, _AppraisalPurposeType) then
        begin
          AddLogEntry(Log, '9', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Report]), CurrentValue, '17');
          AddLogEntry(Log, '10', [FormField, DataPointString, '', ErrorUndetermined, ''], 1);
          _AppraisalPurposeType := InvalidValue;
          Result := Result +  1;
        end
      else
        begin
          AddLogEntry(Log, '9', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Report]), CurrentValue, '17');

          //UAD 20
          if _AppraisalPurposeType = 'Other' then
            if GetAttributeValue(oAttributes, 'AppraisalPurposeTypeOtherDescription', CommonBool, CurrentValue) = '' then
              begin
                AddLogEntry(Log, '10', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Report]), CurrentValue, '20');
                Result := Result +  1;
              end
            else
              AddLogEntry(Log, '10', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Report]), CurrentValue, '20');
        end;
      Exit;
    end;  //end of XPath.CommaText =  CreateCommaText([Valuation_Response, Report]


{  '[PARTIES/LENDER] -> _UnparsedName'}

  // UAD 21
  if XPath.CommaText =  CreateCommaText([Valuation_Response, Parties, Lender]) then
    begin
      if XPathSchema.IndexOfName(XPath.CommaText) <> - 1 then
        XPathSchema.Delete(XPathSchema.IndexOfName(XPath.CommaText));

      if GetAttributeValue(oAttributes, '_UnparsedName', CommonBool, CurrentValue) = '' then
        begin
          AddLogEntry(Log, '11', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Parties, Lender]), CurrentValue, '21');
          Result := Result +  1;
        end
      else
        AddLogEntry(Log, '11', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Parties, Lender]), CurrentValue, '21');

      Exit;
    end;


{  '[PROPERTY/LISTING_HISTORY] -> ListedWithinPreviousYearIndicator'}

  if XPath.CommaText =  CreateCommaText([Valuation_Response, _Property, Listing_History]) then
    begin
      if XPathSchema.IndexOfName(XPath.CommaText) <> - 1 then
        XPathSchema.Delete(XPathSchema.IndexOfName(XPath.CommaText));

      // UAD 22
      _ListedWithinPreviousYearIndicator := InvalidValue;

      if not CheckEnum(YesNo, GetAttributeValue(oAttributes, 'ListedWithinPreviousYearIndicator', CommonBool, CurrentValue)) then
        begin
          AddLogEntry(Log, '12', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, _Property, Listing_History]), CurrentValue, '22');
          Result :=Result +  1;
        end
      else
        begin
          AddLogEntry(Log, '12', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, _Property, Listing_History]), CurrentValue, '22');
          _ListedWithinPreviousYearIndicator := CurrentValue; // to check GSEDaysOnMarketDescription
        end;

      // UAD 27
      if GetAttributeValue(oAttributes, 'ListedWithinPreviousYearDescription', CommonBool, CurrentValue) = '' then
        begin
          AddLogEntry(Log, '155', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, _Property, Listing_History]), CurrentValue, '27');
          Result := Result + 1;
        end
      else
        AddLogEntry(Log, '155', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, _Property, Listing_History]), CurrentValue, '27');

      if XPathSchema.IndexOfName(XPath.CommaText) <> - 1 then
        XPathSchema.Delete(XPathSchema.IndexOfName(XPath.CommaText));

      Exit;
    end;   //end of XPath.CommaText =  CreateCommaText([Valuation_Response, _Property, Listing_History]


{  '***REPETITIVE SOURCE*** [VALUATION_METHODS/SALES_COMPARISON..COMPARION_DETAIL] -> GSEDaysOnMarketDescription'}

  if XPath.CommaText = CreateCommaText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]) then
    begin
      if XPathSchema.IndexOfName(XPath.CommaText) <> - 1 then
        XPathSchema.Delete(XPathSchema.IndexOfName(XPath.CommaText));

    // UAD 25
    if (ComparableSale_PropertySequenceIdentifier = 0) and (ExtensionSectionOrganizationName) then   // check if correct XPath
     if _ListedWithinPreviousYearIndicator = InvalidValue then
      AddLogEntry(Log, '13', [FormField, DataPointString, '', ErrorUndetermined, ''], 1)
     else
     if _ListedWithinPreviousYearIndicator = 'Y' then
     begin

      CommonStr := GetAttributeValue(oAttributes, 'GSEDaysOnMarketDescription', CommonBool, CurrentValue);

      if CommonStr <> 'Unk' then
        if not ValidateNumber(CommonStr, 0, CommonFloat, True) then
        begin
          AddLogEntry(Log, '13', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]), CurrentValue, '25');
          Result := Result + 1;
        end
        else
          AddLogEntry(Log, '13', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]), CurrentValue, '25')
      else
        AddLogEntry(Log, '13', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]), CurrentValue, '25')

     end;

     if XPathSchema.IndexOfName(XPath.CommaText) <> - 1 then XPathSchema.Delete(XPathSchema.IndexOfName(XPath.CommaText));
    //Exit;   -------- Cant Exit since this Xpath checking is repeated;
  end;

{ }


{  '&&&REPETITIVE SOURCE&&& [VALUATION_RESPONSE/PROPERTY/PROJECT] ->ProjectName'}       // late decleration in the UAD rules documentation

  if (_FormType = 'FNM1073') or (_FormType = 'FNM1075') then
  begin
    if XPath.CommaText = CreateCommaText([Valuation_Response, _Property, Project]) then
    begin

      if XPathSchema.IndexOfName(XPath.CommaText) <> - 1 then XPathSchema.Delete(XPathSchema.IndexOfName(XPath.CommaText));

      if GetAttributeValue(oAttributes, '_Name', CommonBool, CurrentValue) = '' then
      begin
        AddLogEntry(Log, '147', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, _Property, Project]), CurrentValue);
        Result := Result + 1;
      end
      else
        AddLogEntry(Log, '147', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, _Property, Project]), CurrentValue);

      if XPathSchema.IndexOfName(XPath.CommaText) <> - 1 then XPathSchema.Delete(XPathSchema.IndexOfName(XPath.CommaText));
    end;

  end;

{ }



//CONTRACT

{  '[PROPERTY/SALES_CONTRACT] -> _ReviewedIndicator, _ReviewComment, _Amount', _Date, SellerIsOwnerIndicator, SalesConcessionIndicator }

  if XPath.CommaText =  CreateCommaText([Valuation_Response, _Property, Sales_Contract]) then
  begin


    if XPathSchema.IndexOfName(XPath.CommaText) <> - 1 then XPathSchema.Delete(XPathSchema.IndexOfName(XPath.CommaText));

    // to check _ReviewIndicator,  _ReviewComment, _Amount, _Date, SellerIsOwnerIndicator, SalesConcessionIndicator
    if _AppraisalPurposeType <> InvalidValue then
      if _AppraisalPurposeType = 'Purchase' then
      begin

        // UAD 28
        if not CheckEnum(YesNo, GetAttributeValue(oAttributes, '_ReviewedIndicator', CommonBool, CurrentValue)) then
        begin
          AddLogEntry(Log, '14', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, _Property, Sales_Contract]), CurrentValue, '28');
          Result := Result + 1;
        end
        else
          AddLogEntry(Log, '14', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, _Property, Sales_Contract]), CurrentValue, '28');


        // UAD 33
        if GetAttributeValue(oAttributes, '_ReviewComment', CommonBool, CurrentValue) = '' then
        begin
         AddLogEntry(Log, '16', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, _Property, Sales_Contract]), CurrentValue, '33');
         Result := Result + 1;
        end
        else
          AddLogEntry(Log, '16', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, _Property, Sales_Contract]), CurrentValue, '33');



        // UAD 34
        _SalesContractAmount := InvalidInt;

        if not ValidateCurrency(GetAttributeValue(oAttributes, '_Amount', CommonBool, CurrentValue), CommonInt) then
        begin
         AddLogEntry(Log, '17', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, _Property, Sales_Contract]), CurrentValue, '34');
         Result := Result + 1;
        end
        else
        begin
          _SalesContractAmount := CommonInt;
          AddLogEntry(Log, '17', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, _Property, Sales_Contract]), CurrentValue, '34');
        end;


        //UAD 36
        if not ValidateDate(GetAttributeValue(oAttributes, '_Date', CommonBool, CurrentValue)) then
        begin
         AddLogEntry(Log, '18', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, _Property, Sales_Contract]), CurrentValue, '36');
         Result := Result + 1;
        end
        else
          AddLogEntry(Log, '18', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, _Property, Sales_Contract]), CurrentValue, '36');


        // UAD 38
        if not CheckEnum(YesNo, GetAttributeValue(oAttributes, 'SellerIsOwnerIndicator', CommonBool, CurrentValue)) then
        begin
          AddLogEntry(Log, '19', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, _Property, Sales_Contract]), CurrentValue, '38');
          Result := Result + 1;
        end
        else
          AddLogEntry(Log, '19', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, _Property, Sales_Contract]), CurrentValue, '38');


        // UAD 41
        _SalesConcessionIndicator := InvalidValue;

        if not CheckEnum(YesNo, GetAttributeValue(oAttributes, 'SalesConcessionIndicator', CommonBool, CurrentValue)) then
        begin
          AddLogEntry(Log, '20', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, _Property, Sales_Contract]), CurrentValue, '41');
          Result := Result + 1;
        end
        else
        begin
          _SalesConcessionIndicator := CurrentValue;
          AddLogEntry(Log, '20', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, _Property, Sales_Contract]), CurrentValue, '41');
        end;

      end
      else
    else     //if _AppraisalPurposeType is invalid
    begin
      AddLogEntry(Log, '14', [FormField, DataPointString, '', ErrorUndetermined, ''], 1);
      AddLogEntry(Log, '16', [FormField, DataPointString, '', ErrorUndetermined, ''], 1);
      AddLogEntry(Log, '17', [FormField, DataPointString, '', ErrorUndetermined, ''], 1);
      AddLogEntry(Log, '18', [FormField, DataPointString, '', ErrorUndetermined, ''], 1);
      AddLogEntry(Log, '19', [FormField, DataPointString, '', ErrorUndetermined, ''], 1);
      AddLogEntry(Log, '20', [FormField, DataPointString, '', ErrorUndetermined, ''], 1);
    end;



     // UAD 44

    // SalesConcessionAmount  [This item depends on multiple other variables. Checking them first to issue a common error message]
    if (_AppraisalPurposeType = InvalidValue) or (_GSEUndefinedConcessionAmountIndicator = InvalidValue) or (_SalesConcessionIndicator = InvalidValue) then
      AddLogEntry(Log, '21', [FormField, DataPointString, '', ErrorUndetermined, ''], 1)
    else
      if _AppraisalPurposeType = 'Purchase' then

        if (_GSEUndefinedConcessionAmountIndicator = 'Y') and (_SalesConcessionIndicator = 'Y') then

          if GetAttributeValue(oAttributes, 'SalesConcessionAmount', CommonBool, CurrentValue) <> '' then
          begin
            ValidateCurrency(GetAttributeValue(oAttributes, 'SalesConcessionAmount', CommonBool, CurrentValue), CommonInt);
            if CommonInt < 0 then
            begin
              AddLogEntry(Log, '21', [FormField, DataPointString, ErrorCode, LogicError1, Suggestion], 0, CreatePathText([Valuation_Response, _Property, Sales_Contract]), CurrentValue, '44');
              Result := Result + 1;
            end
            else
              AddLogEntry(Log, '21', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, _Property, Sales_Contract]), CurrentValue, '44');
          end
          else
            AddLogEntry(Log, '21', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, _Property, Sales_Contract]), CurrentValue, '44')

        else
        begin

           ValidateCurrency(GetAttributeValue(oAttributes, 'SalesConcessionAmount', CommonBool, CurrentValue), CommonInt);

           if (_GSEUndefinedConcessionAmountIndicator = 'N') and (_SalesConcessionIndicator = 'Y') then

            if (CommonInt <= 0) or (not CommonBool) then
            begin
              AddLogEntry(Log, '21', [FormField, DataPointString, ErrorCode, LogicError2, Suggestion], 0, CreatePathText([Valuation_Response, _Property, Sales_Contract]), CurrentValue, '44');
              Result := Result + 1;
            end
            else
              AddLogEntry(Log, '21', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, _Property, Sales_Contract]), CurrentValue, '44')

          else
            if (_GSEUndefinedConcessionAmountIndicator = 'N') and (_SalesConcessionIndicator = 'N') then

              if (CommonInt <> 0) or (not CommonBool) then
              begin
                AddLogEntry(Log, '21', [FormField, DataPointString, ErrorCode, LogicError3, Suggestion], 0, CreatePathText([Valuation_Response, _Property, Sales_Contract]), CurrentValue, '44');
                Result := Result + 1;
              end
              else
                AddLogEntry(Log, '21', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, _Property, Sales_Contract]), CurrentValue, '44');

        end;


    // UAD 47
    if _SalesConcessionIndicator <> InvalidValue then
      if _SalesConcessionIndicator = 'Y' then
        if GetAttributeValue(oAttributes, 'SalesConcessionDescription', CommonBool, CurrentValue) = '' then
        begin
          AddLogEntry(Log, '22', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, _Property, Sales_Contract]), CurrentValue, '47');
          Result := Result + 1;
        end
        else
          AddLogEntry(Log, '22', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, _Property, Sales_Contract]), CurrentValue, '47')

      else
    else
      AddLogEntry(Log, '22', [FormField, DataPointString, '', ErrorUndetermined, ''], 1);

    Exit;

  end;

{ }


{  '[PROPERTY/SALES_CONTRACT/SALES_CONTRACT_EXTENSION...SALES_TRANSACTION] -> GSESaleType'}

  if XPath.CommaText =  CreateCommaText([Valuation_Response, _Property, Sales_Contract, Sales_Contract_Extension, Sales_Contract_Extension_Section, Sales_Contract_Extension_Section_Data, Sales_Transaction]) then
  begin

    if XPathSchema.IndexOfName(XPath.CommaText) <> - 1 then XPathSchema.Delete(XPathSchema.IndexOfName(XPath.CommaText));

   // UAD 31
   if ExtensionSectionOrganizationName then   // check if correct XPath
     if _AppraisalPurposeType <> InvalidValue then
       if _AppraisalPurposeType = 'Purchase' then
         if not CheckEnum(GSESaleType, GetAttributeValue(oAttributes, 'GSESaleType', CommonBool, CurrentValue)) then
         begin

           AddLogEntry(Log, '15', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, _Property, Sales_Contract, Sales_Contract_Extension, Sales_Contract_Extension_Section, Sales_Contract_Extension_Section_Data, Sales_Transaction]), CurrentValue, '31');
           Result := Result + 1;

         end
         else
          AddLogEntry(Log, '15', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, _Property, Sales_Contract, Sales_Contract_Extension, Sales_Contract_Extension_Section, Sales_Contract_Extension_Section_Data, Sales_Transaction]), CurrentValue, '31')

       else
     else
      AddLogEntry(Log, '15', [FormField, DataPointString, '', ErrorUndetermined, ''], 1);

    Exit;
  end;

{ }



//NEIGHBORHOOD
{  '[VALUATION_RESPONSE/PROPERTY/NEIGHBORHOOD] -> _PropertyValueTrendType, _DemandSupplyType, _TypicalMarketingTimeDurationType'}
  if XPath.CommaText =  CreateCommaText([Valuation_Response, _Property, Neighborhood])then
  begin

    if XPathSchema.IndexOfName(XPath.CommaText) <> - 1 then XPathSchema.Delete(XPathSchema.IndexOfName(XPath.CommaText));

    // UAD 48
    if not CheckEnum(PropertyValueTrendType, GetAttributeValue(oAttributes, '_PropertyValueTrendType', CommonBool, CurrentValue)) then
    begin
      AddLogEntry(Log, '23', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, _Property, Neighborhood]), CurrentValue, '48');
      Result := Result + 1;
    end
    else
      AddLogEntry(Log, '23', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, _Property, Neighborhood]), CurrentValue, '48');


    // UAD 51
    if not CheckEnum(DemandSupplyType, GetAttributeValue(oAttributes, '_DemandSupplyType', CommonBool, CurrentValue)) then
    begin
      AddLogEntry(Log, '24', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, _Property, Neighborhood]), CurrentValue, '51');
      Result := Result + 1;
    end
    else
      AddLogEntry(Log, '24', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, _Property, Neighborhood]), CurrentValue, '51');


    // UAD 54
    if not CheckEnum(TypicalMarketingTimeDurationType, GetAttributeValue(oAttributes, '_TypicalMarketingTimeDurationType', CommonBool, CurrentValue)) then
    begin
      AddLogEntry(Log, '25', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, _Property, Neighborhood]), CurrentValue, '54');
      Result := Result + 1;
    end
    else
      AddLogEntry(Log, '25', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, _Property, Neighborhood]), CurrentValue, '54');


    Exit;

  end;
{ }




//SITE
{  '[VALUATION_RESPONSE/PROPERTY/SITE] -> _AreaDescription'}
  if (_FormType = 'FNM1004') or (_FormType = 'FNM2055') then
    if XPath.CommaText =  CreateCommaText([Valuation_Response, _Property, Site])then
    begin

      if XPathSchema.IndexOfName(XPath.CommaText) <> - 1 then XPathSchema.Delete(XPathSchema.IndexOfName(XPath.CommaText));

      // UAD 57
      if not ValidateArea(GetAttributeValue(oAttributes, '_AreaDescription', CommonBool, CurrentValue)) then
      begin
        AddLogEntry(Log, '26', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, _Property, Site]), CurrentValue, '57');
        Result := Result + 1;
      end
      else
        AddLogEntry(Log, '26', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, _Property, Site]), CurrentValue, '57');

      Exit;

    end;
{ }


{  '%%%REPETIVE SOURCE%%%[VALUATION_METHODS/SALES_COMPARISON..COMPARISON_VIEW_OVERALL_RATING] -> GSEViewOverallRatingType'}
  if XPath.CommaText =  CreateCommaText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_View_Overall_Rating_Extension, Comparison_View_Overall_Rating_Extension_Section, Comparison_View_Overall_Rating_Extension_Section_Data, Comparison_View_Overall_Rating]) then
  begin

    if XPathSchema.IndexOfName(XPath.CommaText) <> - 1 then XPathSchema.Delete(XPathSchema.IndexOfName(XPath.CommaText));

    // UAD 61
    if (ComparableSale_PropertySequenceIdentifier = 0) and (ExtensionSectionOrganizationName) then   // check if correct XPath
      if not CheckEnum(GSEViewOverallRatingType, GetAttributeValue(oAttributes, 'GSEViewOverallRatingType', CommonBool, CurrentValue)) then
      begin
        AddLogEntry(Log, '27', [FormField, DataPointString + '% - Comparable Sale [' + InttoStr(ComparableSale_PropertySequenceIdentifier) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_View_Overall_Rating_Extension, Comparison_View_Overall_Rating_Extension_Section, Comparison_View_Overall_Rating_Extension_Section_Data, Comparison_View_Overall_Rating]), CurrentValue, '61');
        Result := Result + 1;
      end
      else
        AddLogEntry(Log, '27', [FormField, DataPointString + '% - Comparable Sale [' + InttoStr(ComparableSale_PropertySequenceIdentifier) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_View_Overall_Rating_Extension, Comparison_View_Overall_Rating_Extension_Section, Comparison_View_Overall_Rating_Extension_Section_Data, Comparison_View_Overall_Rating]), CurrentValue, '61');


    //Exit;    - not permited
  end;

{ }


{  '$$$REPETITIVE SOURCE$$$ [VALUATION_METHODS/SALES_COMPARISON..COMPARISON_VIEW_DETAIL] -> GSEViewType, GSEViewTypeOtherDescription'}
  if XPath.CommaText =  CreateCommaText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_View_Detail_Extension, Comparison_View_Detail_Extension_Section, Comparison_View_Detail_Extension_Section_Data, Comparison_View_Detail]) then
  begin

    if XPathSchema.IndexOfName(XPath.CommaText) <> - 1 then XPathSchema.Delete(XPathSchema.IndexOfName(XPath.CommaText));

    if (ComparableSale_PropertySequenceIdentifier = 0) and (ExtensionSectionOrganizationName) then   // check if correct XPath
    begin


       // UAD 64
      CommonStr := GetAttributeValue(oAttributes, 'GSEViewType', CommonBool, CurrentValue);

      if not CheckEnum(GSEViewType, CommonStr) then
      begin
       AddLogEntry(Log, '28', [FormField, DataPointString + '% - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier) + '] Comparison View Detail [n=' + InttoStr(nGSEViewType) + ']', ErrorCode, LogicError1, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_View_Detail_Extension, Comparison_View_Detail_Extension_Section, Comparison_View_Detail_Extension_Section_Data, Comparison_View_Detail]), CurrentValue, '64');
       AddLogEntry(Log, '29', [FormField, DataPointString, ErrorCode, ErrorUndetermined, Suggestion], 1);
       Result := Result + 1;
      end
      else
      begin
        nGSEViewType := nGSEViewType + 1;

        if nGSEViewType >= 3  then
        begin
          AddLogEntry(Log, '28', [FormField, DataPointString + '% -  Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier) + '] Comparison View Detail [n=' + InttoStr(nGSEViewType) + ']', ErrorCode, LogicError2, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_View_Detail_Extension, Comparison_View_Detail_Extension_Section, Comparison_View_Detail_Extension_Section_Data, Comparison_View_Detail]), CurrentValue, '64');
          Result := Result + 1;
        end
        else
          AddLogEntry(Log, '28', [FormField, DataPointString + '% - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier) + '] Comparison View Detail [n=' + InttoStr(nGSEViewType) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_View_Detail_Extension, Comparison_View_Detail_Extension_Section, Comparison_View_Detail_Extension_Section_Data, Comparison_View_Detail]), CurrentValue, '64');


        // UAD 67

        Param1 := GetAttributeValue(oAttributes, 'GSEViewTypeOtherDescription', CommonBool, CurrentValue);

        if (CommonStr = 'Other') then
        begin

          if  Param1 = '' then
          begin
            AddLogEntry(Log, '29', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier) + '] Comparison View Detail [n=' + InttoStr(nGSEViewType) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_View_Detail_Extension, Comparison_View_Detail_Extension_Section, Comparison_View_Detail_Extension_Section_Data, Comparison_View_Detail]), CurrentValue, '67');
            Result := Result + 1;
          end
          else
            AddLogEntry(Log, '29', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier) + '] Comparison View Detail [n=' + InttoStr(nGSEViewType) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_View_Detail_Extension, Comparison_View_Detail_Extension_Section, Comparison_View_Detail_Extension_Section_Data, Comparison_View_Detail]), CurrentValue, '67');

        end
        else
          if CommonBool then
            AddLogEntry(Log, '29', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier) + '] Comparison View Detail [n=' + InttoStr(nGSEViewType) + ']', ErrorCode, LogicError1, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_View_Detail_Extension, Comparison_View_Detail_Extension_Section, Comparison_View_Detail_Extension_Section_Data, Comparison_View_Detail]), CurrentValue, '67');




      end;


    end;


   // Exit; - not permitted
  end;

{ }


{  '[VALUATION_RESPONSE/PROPERTY/SITE/SITE_UTILITY] -> _Type, _PublicIndicator, _NonPublicIndicator, _NonPublicDescription'}
  if XPath.CommaText =  CreateCommaText([Valuation_Response, _Property, Site, Site_Utility])then
  begin

    if XPathSchema.IndexOfName(XPath.CommaText) <> - 1 then XPathSchema.Delete(XPathSchema.IndexOfName(XPath.CommaText));

     // UAD 68, 71, 74, 77

    Param1 := GetAttributeValue(oAttributes, '_PublicIndicator', CommonBool, CurrentValue);
    Param2 := GetAttributeValue(oAttributes, '_NonPublicIndicator', CommonBool, CurrentValue);
    Param3 := GetAttributeValue(oAttributes, '_NonPublicDescription', CommonBool, CurrentValue);

    // to get the Type as the current value to display next to the data point
    if not CheckEnum(UtilityType, GetAttributeValue(oAttributes, '_Type', CommonBool, CurrentValue)) then
      AddLogEntry(Log, '30', [FormField, DataPointString, ErrorCode, ErrorUndetermined, Suggestion], 1, '', CurrentValue)

    else

      if (((Param1 = '') or (Param1 = 'N')) and ((Param2 = '') or (Param2 = 'N')) and (Param3 <> 'None')) or
        (not CheckEnum(YEsNo, Param1)) or (not CheckEnum(YesNo, Param2)) or
        ((Param2 = 'Y') and (Param3 = '')) then
      begin
        AddLogEntry(Log, '30', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, _Property, Site, Site_Utility]), CurrentValue, GetXIDFromUtilityArray(CurrentValue));
        Result := Result + 1;
      end
      else
        AddLogEntry(Log, '30', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, _Property, Site, Site_Utility]), CurrentValue, GetXIDFromUtilityArray(CurrentValue));

    Exit;


  end;
{ }



//IMPROVEMENTS
{  '[VALUATION_RESPONSE/PROPERTY/STRUCTURE..STRUCTURE_INFORMATION] -> GSEStoriesCount'}

  if XPath.CommaText =  CreateCommaText([Valuation_Response, _Property, Structure, Structure_Extension, Structure_Extension_Section, Structure_Extension_Section_Data, Structure_Information]) then
  begin

    if XPathSchema.IndexOfName(XPath.CommaText) <> - 1 then XPathSchema.Delete(XPathSchema.IndexOfName(XPath.CommaText));

  // UAD 80
   if ExtensionSectionOrganizationName then   // check if correct XPath
   begin

    CommonBool := ValidateNumber(GetAttributeValue(oAttributes, 'GSEStoriesCount', CommonBool, CurrentValue), 2, CommonFloat);
    if (not CommonBool) then
      CommonBool := ValidateNumber(GetAttributeValue(oAttributes, 'GSEStoriesCount', CommonBool, CurrentValue), 0, CommonFloat, True);
    if (not CommonBool) or (CommonFloat + 0.01 > 100) then
    begin
      AddLogEntry(Log, '31', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, _Property, Structure, Structure_Extension, Structure_Extension_Section, Structure_Extension_Section_Data, Structure_Information]), CurrentValue, '80');
      Result := Result + 1;
    end
    else
      AddLogEntry(Log, '31', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, _Property, Structure, Structure_Extension, Structure_Extension_Section, Structure_Extension_Section_Data, Structure_Information]), CurrentValue, '80');

   end;

    Exit;
  end;

{ }


{  '[VALUATION_RESPONSE/PROPERTY/STRUCTURE] -> PropertyStructureBuiltYear, TotalRoomCount, TotalBedroomCount, TotalBathroomCount, GrossLivingAreaSquareFeetCount'}

  if XPath.CommaText =  CreateCommaText([Valuation_Response, _Property, Structure]) then
  begin

    if XPathSchema.IndexOfName(XPath.CommaText) <> - 1 then XPathSchema.Delete(XPathSchema.IndexOfName(XPath.CommaText));

    // UAD 82
    CommonInt := ValidateEstimation(GetAttributeValue(oAttributes, 'PropertyStructureBuiltYear', CommonBool, CurrentValue));
    if (CommonInt = InvalidInt) or ((CommonInt < 1000) or (CommonInt > 9999)) then
    begin
      AddLogEntry(Log, '32', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, _Property, Structure]), CurrentValue, '82');
      Result := Result + 1;
    end
    else
      AddLogEntry(Log, '32', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, _Property, Structure]), CurrentValue, '82');


   // UAD 94
///Skip review of totalroomcount - appraisers do not use the adjustment cell above & to the right of the room count row

    CommonBool := ValidateNumber(GetAttributeValue(oAttributes, 'TotalRoomCount', CommonBool, CurrentValue), 0, CommonFloat, True);

    if (not CommonBool) or (CommonFloat > 99) then
    begin
      AddLogEntry(Log, '36', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, _Property, Structure]), CurrentValue, '94');
      Result := Result + 1;
    end
    else
      AddLogEntry(Log, '36', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, _Property, Structure]), CurrentValue, '94');

 

   // UAD 96

    CommonBool := ValidateNumber(GetAttributeValue(oAttributes, 'TotalBedroomCount', CommonBool, CurrentValue), 0, CommonFloat, True);

    if (not CommonBool) or (CommonFloat > 99) then
    begin
      AddLogEntry(Log, '37', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, _Property, Structure]), CurrentValue, '96');
      Result := Result + 1;
    end
    else
      AddLogEntry(Log, '37', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, _Property, Structure]), CurrentValue, '96');


   // UAD 98
    CommonBool := ValidateNumber(GetAttributeValue(oAttributes, 'TotalBathroomCount', CommonBool, CurrentValue), 2, CommonFloat, False);

    if (not CommonBool) or (CommonFloat > 99.99) then
    begin
      AddLogEntry(Log, '38', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, _Property, Structure]), CurrentValue, '98');
      Result := Result + 1;
    end
    else
      AddLogEntry(Log, '38', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, _Property, Structure]), CurrentValue, '98');


   // UAD 100
   CommonBool := ValidateNumber(GetAttributeValue(oAttributes, 'GrossLivingAreaSquareFeetCount', CommonBool, CurrentValue), 0, CommonFloat, True);

    if (not CommonBool) or (CommonFloat > 99999) then
    begin
      AddLogEntry(Log, '39', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, _Property, Structure]), CurrentValue, '100');
      Result := Result + 1;
    end
    else
      AddLogEntry(Log, '39', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, _Property, Structure]), CurrentValue, '100');




   Exit;

  end;

{ }


{  '[VALUATION_RESPONSE/PROPERTY/STRUCTURE/BASEMENT] -> SquareFeetCount, _FinishedPercent'}

  if (_FormType = 'FNM1004') then
    if XPath.CommaText =  CreateCommaText([Valuation_Response, _Property, Structure, Basement]) then
    begin

      if XPathSchema.IndexOfName(XPath.CommaText) <> - 1 then XPathSchema.Delete(XPathSchema.IndexOfName(XPath.CommaText));

      // UAD 84
      if not ValidateNumber(GetAttributeValue(oAttributes, 'SquareFeetCount', CommonBool, CurrentValue), 0, CommonFloat, True) then
      begin
        AddLogEntry(Log, '33', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, _Property, Structure, Basement]), CurrentValue, '84');
        Result := Result + 1;
      end
      else
        if CommonFloat > 99999 then
        begin
          AddLogEntry(Log, '33', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, _Property, Structure, Basement]), CurrentValue, '84');
          Result := Result + 1;
        end
        else
          AddLogEntry(Log, '33', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, _Property, Structure, Basement]), CurrentValue, '84');


      // UAD 86
      if not ValidateNumber(GetAttributeValue(oAttributes, '_FinishedPercent', CommonBool, CurrentValue), 0, CommonFloat, True) then
      begin
        AddLogEntry(Log, '34', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, _Property, Structure, Basement]), CurrentValue, '86');
        Result := Result + 1;
      end
      else
        if CommonFloat > 100 then
        begin
          AddLogEntry(Log, '34', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, _Property, Structure, Basement]), CurrentValue, '86');
          Result := Result + 1;
        end
        else
          AddLogEntry(Log, '34', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, _Property, Structure, Basement]), CurrentValue, '86');


      Exit;
    end;

{ }


{  '[VALUATION_RESPONSE/PROPERTY/STRUCTURE/CAR_STORAGE] -> ParkingSpacesCount'}

// for UAD 90, forms 1073 1075 and
  if XPath.CommaText =  CreateCommaText([Valuation_Response, _Property, Structure, Car_Storage]) then
  begin

     if XPathSchema.IndexOfName(XPath.CommaText) <> - 1 then XPathSchema.Delete(XPathSchema.IndexOfName(XPath.CommaText));

    _ParkingSpaceCount := GetAttributeValue(oAttributes, 'ParkingSpacesCount', CommonBool, CommonStr);

    if not CommonBool then
      _ParkingSpaceCount := CommonStr;

  end;


{ }


{  '[VALUATION_RESPONSE/PROPERTY/STRUCTURE/CAR_STORAGE/CAR_STORAGE_LOCATION] -> ParkingSpacesCount'}

  if XPath.CommaText =  CreateCommaText([Valuation_Response, _Property, Structure, Car_Storage, Car_Storage_Location]) then
  begin

    if XPathSchema.IndexOfName(XPath.CommaText) <> - 1 then XPathSchema.Delete(XPathSchema.IndexOfName(XPath.CommaText));
      
   if not CheckEnum(CarStorageLocation, GetAttributeValue(oAttributes, '_Type', CommonBool, CurrentValue)) then
    AddLogEntry(Log, '35', [FormField, DataPointString, ErrorCode, ErrorUndetermined, Suggestion], 1)
   else

    // UAD 88, 92
    if (CurrentValue = 'Driveway') or (CurrentValue = 'Carport') then
      if (_FormType = 'FNM1004') or (_FormType = 'FNM2055') then
      begin

        // GetAttributeValue above call has given variable CommonStr for the parameter CurrentValue to preserve the variable CurrentValue which the _Type was saved from the very top call
        CommonBool := ValidateNumber(GetAttributeValue(oAttributes, 'ParkingSpacesCount', CommonBool, CommonStr), 0, CommonFloat, True);

        if (not CommonBool) or (CommonFloat > 99) then
        begin
          AddLogEntry(Log, '35', [FormField, DataPointString + '%  - CarStorageLocation['+ CurrentValue + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, _Property, Structure, Car_Storage, Car_Storage_Location]), CommonStr);
          Result := Result + 1;
        end
        else
          AddLogEntry(Log, '35', [FormField, DataPointString + '%  - CarStorageLocation['+ CurrentValue + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, _Property, Structure, Car_Storage, Car_Storage_Location]), CommonStr);

      end
      else
    else
    begin

      // UAD 90
      // GetAttributeValue above call has given variable CommonStr for the parameter CurrentValue to preserve the variable CurrentValue which the _Type was saved from the very top call
      if (_FormType = 'FNM1004') or (_FormType = 'FNM2055') then
        CommonBool := ValidateNumber(GetAttributeValue(oAttributes, 'ParkingSpacesCount', CommonBool, CommonStr), 0, CommonFloat, True)
      else
      begin
        CommonBool := ValidateNumber(_ParkingSpaceCount, 0, CommonFloat, True);
        CommonStr := _ParkingSpaceCount;
      end;


      if (not CommonBool) or (CommonFloat > 99) then
      begin
        AddLogEntry(Log, '35', [FormField, DataPointString + '%  - CarStorageLocation['+ CurrentValue + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, _Property, Structure, Car_Storage, Car_Storage_Location]), CommonStr, '90');
        Result := Result + 1;
      end
      else
        AddLogEntry(Log, '35', [FormField, DataPointString + '%  - CarStorageLocation['+ CurrentValue + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, _Property, Structure, Car_Storage, Car_Storage_Location]), CommonStr, '90');

    end;

    Exit;
  end;

{ }


{  '**REPETITION** [VALUATION_METHODS/SALES_COMPARISON/COMPARABLE_SALE/COMPARISON_DETAIL_EXTENSION..COMPARION_DETAIL] -> GSEOverallConditionType'}
  if XPath.CommaText =  CreateCommaText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]) then
  begin


    // UAD 102
    if (ComparableSale_PropertySequenceIdentifier = 0) and (ExtensionSectionOrganizationName) then   // check if correct XPath
      if not CheckEnum(GSEOverallConditionType, GetAttributeValue(oAttributes, 'GSEOverallConditionType', CommonBool, CurrentValue)) then
      begin

        AddLogEntry(Log, '40', [FormField, DataPointString + '% - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]), CurrentValue, '102');
        Result :=Result + 1;

      end
      else
        AddLogEntry(Log, '40', [FormField, DataPointString + '% - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]), CurrentValue, '102');


    //Exit;  - is not permited here
  end;

{ }


{  '[VALUATION_METHODS/PROPERTY/STRUCTURE/CONDITION_DETAIL_EXTENSION..CONDITION_DETAIL] -> GSEImprovementDescriptionType'}
  if XPath.CommaText =  CreateCommaText([Valuation_Response, _Property, Structure, Condition_Detail_Extension, Condition_Detail_Extension_Section, Condition_Detail_Extension_Section_Data, Condition_Detail]) then
  begin



    if XPathSchema.IndexOfName(XPath.CommaText) <> - 1 then XPathSchema.Delete(XPathSchema.IndexOfName(XPath.CommaText));

    if (_FormType = 'FNM1004') or (_FormType = 'FNM1073') then
    begin


      GetAttributeValue(oAttributes, '_SequenceIdentifier', CommonBool, CurrentValue);

      if (ExtensionSectionOrganizationName) and ((CurrentValue = '1') or (CurrentValue = '2')) then   // check if correct XPath
      begin

        Param1 := CurrentValue;     // Saved n=_SequenceIdentifier

        // UAD 104
        if _GSEUpdateLastFifteenYearIndicator <> InvalidValue then
          if _GSEUpdateLastFifteenYearIndicator = 'Y' then
            if not CheckEnum(GSEImprovementDescriptionType, GetAttributeValue(oAttributes, 'GSEImprovementDescriptionType', CommonBool, CurrentValue)) then
            begin

              AddLogEntry(Log, '41', [FormField, DataPointString + '% - Condition Detail[' + Param1 + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, _Property, Structure, Condition_Detail_Extension, Condition_Detail_Extension_Section, Condition_Detail_Extension_Section_Data, Condition_Detail]), CurrentValue, '104');
              Result :=Result + 1;

            end
            else
              AddLogEntry(Log, '41', [FormField, DataPointString + '% - Condition Detail[' + Param1 + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, _Property, Structure, Condition_Detail_Extension, Condition_Detail_Extension_Section, Condition_Detail_Extension_Section_Data, Condition_Detail]), CurrentValue, '104')

          else
        else
          AddLogEntry(Log, '41', [FormField, DataPointString, '', ErrorUndetermined, ''], 1);




        // UAD 106
        CommonStr :=  GetAttributeValue(oAttributes, 'GSEImprovementDescriptionType', CommonBool, CurrentValue);

        if CheckEnum(GSEImprovementDescriptionType, CommonStr) then
          if (CommonStr = 'Updated') or (CommonStr = 'Remodeled') then
            if not CheckEnum(GSEEstimateYearOfImprovementType, GetAttributeValue(oAttributes, 'GSEEstimateYearOfImprovementType', CommonBool, CurrentValue)) then
            begin

              AddLogEntry(Log, '42', [FormField, DataPointString + '% - Condition Detail[' + Param1 + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, _Property, Structure, Condition_Detail_Extension, Condition_Detail_Extension_Section, Condition_Detail_Extension_Section_Data, Condition_Detail]), CurrentValue, '106');
              Result := Result + 1;

            end
            else
              AddLogEntry(Log, '42', [FormField, DataPointString + '% - Condition Detail[' + Param1 + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, _Property, Structure, Condition_Detail_Extension, Condition_Detail_Extension_Section, Condition_Detail_Extension_Section_Data, Condition_Detail]), CurrentValue, '106')

          else
        else
          AddLogEntry(Log, '42', [FormField, DataPointString, '', ErrorUndetermined, ''], 1);

      end;

    end;

    Exit;
  end;

{ }


{  '[VALUATION_RESPONSE/PROPERTY/PROPERTY_ANALYSIS] -> __Comment'}
  if XPath.CommaText =  CreateCommaText([Valuation_Response, _Property, Property_Analysis])then
  begin

    if XPathSchema.IndexOfName(XPath.CommaText) <> - 1 then XPathSchema.Delete(XPathSchema.IndexOfName(XPath.CommaText));

    // UAD 109
    if GetAttributeValue(oAttributes, '_Type', CommonBool, CurrentValue) = 'PropertyCondition'  then
      if GetAttributeValue(oAttributes, '_Comment', CommonBool, CurrentValue) = '' then
      begin

        AddLogEntry(Log, '43', [FormField, DataPointString + '% - Property Analysis[PropertyCondition]', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, _Property, Property_Analysis]), CurrentValue, '109');
        Result := Result + 1;

      end
      else
        AddLogEntry(Log, '43', [FormField, DataPointString + '% - Property Analysis[PropertyCondition]', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, _Property, Property_Analysis]), CurrentValue, '109');

    Exit;

  end;
{ }







//SALES COMPARISON APPROACH

{  '@@@REPETITIVE SOURCE@@@[VALUATION_RESPONSE/VALUATION_METHODS/SALES_COMPARISON/COMPARABLE_SALE] -> PropertySalesAmount, ProximityToSubjectDescription, SalePriceTotalAdjustmentAmount'}
  if XPath.CommaText =  CreateCommaText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale])then
  begin

    if XPathSchema.IndexOfName(XPath.CommaText) <> -1 then XPathSchema.Delete(XPathSchema.IndexOfName(XPath.CommaText));

    if GetAttributeValue(oAttributes, 'PropertySequenceIdentifier', CommonBool, CurrentValue) = '0' then
    begin

      // UAD 113
      if (_AppraisalPurposeType <> InvalidValue) and (_SalesContractAmount <> InvalidInt) then
        if _AppraisalPurposeType = 'Purchase' then
        begin

          if not ValidateCurrency(GetAttributeValue(oAttributes, 'PropertySalesAmount', CommonBool, CurrentValue), CommonInt) then
          begin

            AddLogEntry(Log, '44', [FormField, DataPointString + '% - Comparable Sale[0]', ErrorCode, LogicError1, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale]), CurrentValue, '113');
            Result := Result + 1;

          end
          else
            if CommonInt <> _SalesContractAmount then
            begin
              //Pam: Only show error if it's primary form so we can skip the secondary forms like: extra comp, extra listing
              //This will solve the issue when we have sale price X in main form can be different than sales/listing price Y in extra comps
              if GetAttributeValue(oAttributes, 'AppraisalReportContentIsPrimaryFormIndicator', CommonBool, CurrentValue) = 'Y' then
              begin
                AddLogEntry(Log, '44', [FormField, DataPointString + '% - Comparable Sale[0]', ErrorCode, LogicError2, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale]), CurrentValue, '113');
                Result := Result + 1;
              end;
            end
            else
              AddLogEntry(Log, '44', [FormField, DataPointString + '% - Comparable Sale[0]', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale]), CurrentValue, '113');
        end
        else
      else
        AddLogEntry(Log, '44', [FormField, DataPointString, '', ErrorUndetermined, ''], 1);

    end
    else // propertysequenceidentifire
    begin

      // UAD 174
      if not ValidateNumber(GetAttributeValue(oAttributes, 'PropertySalesAmount', CommonBool, CurrentValue), 0, CommonFloat, True) then
        begin
          AddLogEntry(Log, '69', [FormField, DataPointString + '% Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale]), CurrentValue, '174');
          Result := Result + 1;
        end
        else
          AddLogEntry(Log, '69', [FormField, DataPointString + '% Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale]), CurrentValue, '174');



      nGSEShortDateDescription := 0;
      TotalSalePriceAdjustmentAmount := 0;



      if (_FormType = 'FNM1004') or (_FormType = 'FNM2055') then   // the rest of the rule continues to the end of Comparable_Sale element
        if not ValidateNumber(GetAttributeValue(oAttributes, 'SalePriceTotalAdjustmentAmount', CommonBool, CurrentValue), 0, CommonFloat, True) then
        begin
          AddLogEntry(Log, '122', [FormField, DataPointString + '% Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, LogicError1, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale]), CurrentValue);
          Result := Result + 1;

          _TotalSalePriceAdjustmentAmount := InvalidInt;
        end
        else
          _TotalSalePriceAdjustmentAmount := Round(CommonFloat);


      end;


   //Exit;  not permited since the attribute value collection is below

  end;
{ }


{  '[VALUATION_METHODS/SALES_COMPARISON..COMPARISON_LOCATION_OVERALL_RATING] -> GSEOverallLocationRatingType'}
  if XPath.CommaText =  CreateCommaText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Location_Overall_Rating_Extension, Comparison_Location_Overall_Rating_Extension_Section, Comparison_Location_Overall_Rating_Extension_Section_Data, Comparison_Location_Overall_Rating]) then
  begin

    if XPathSchema.IndexOfName(XPath.CommaText) <> - 1 then XPathSchema.Delete(XPathSchema.IndexOfName(XPath.CommaText));

    if (ComparableSale_PropertySequenceIdentifier = 0) and (ExtensionSectionOrganizationName) then   // check if correct XPath
      // UAD 116
      if not CheckEnum(GSEViewOverallRatingType, GetAttributeValue(oAttributes, 'GSEOverallLocationRatingType', CommonBool, CurrentValue)) then    // Const reuse exempted
      begin
        AddLogEntry(Log, '45', [FormField, DataPointString + '% - Comparable Sale[0]', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Location_Overall_Rating_Extension, Comparison_Location_Overall_Rating_Extension_Section, Comparison_Location_Overall_Rating_Extension_Section_Data, Comparison_Location_Overall_Rating]), CurrentValue, '116');
        Result := Result + 1;
      end
      else
        AddLogEntry(Log, '45', [FormField, DataPointString + '% - Comparable Sale[0]', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Location_Overall_Rating_Extension, Comparison_Location_Overall_Rating_Extension_Section, Comparison_Location_Overall_Rating_Extension_Section_Data, Comparison_Location_Overall_Rating]), CurrentValue, '116')

    else
      if ComparableSale_PropertySequenceIdentifier <> 0 then
        // UAD 196
        if not CheckEnum(GSEViewOverallRatingType, GetAttributeValue(oAttributes, 'GSEOverallLocationRatingType', CommonBool, CurrentValue)) then    // Const reuse exempted
        begin
          AddLogEntry(Log, '80', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Location_Overall_Rating_Extension, Comparison_Location_Overall_Rating_Extension_Section, Comparison_Location_Overall_Rating_Extension_Section_Data, Comparison_Location_Overall_Rating]), CurrentValue, '194');
          Result := Result + 1;
        end
        else
          AddLogEntry(Log, '80', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Location_Overall_Rating_Extension, Comparison_Location_Overall_Rating_Extension_Section, Comparison_Location_Overall_Rating_Extension_Section_Data, Comparison_Location_Overall_Rating]), CurrentValue, '194');

    
  end;

{ }


{  '[VALUATION_METHODS/SALES_COMPARISON..COMPARISON_LOCATION_DETAIL] -> GSELocationType'}
  if XPath.CommaText =  CreateCommaText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Location_Detail_Extension, Comparison_Location_Detail_Extension_Section, Comparison_Location_Detail_Extension_Section_Data, Comparison_Location_Detail]) then
  begin

    if XPathSchema.IndexOfName(XPath.CommaText) <> - 1 then XPathSchema.Delete(XPathSchema.IndexOfName(XPath.CommaText));

    if ExtensionSectionOrganizationName then   // check if correct XPath
    begin

      CommonStr := GetAttributeValue(oAttributes, 'GSELocationType', CommonBool, CurrentValue);

      if not CheckEnum(GSELocationType, CommonStr) then
      begin


       if ComparableSale_PropertySequenceIdentifier = 0 then
       begin
        // UAD 118
        AddLogEntry(Log, '46', [FormField, DataPointString + '% - Comparable Sale[0] Comparison Location Detail[n=' + InttoStr(nGSELocationType) + ']', ErrorCode, LogicError1, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Location_Detail_Extension, Comparison_Location_Detail_Extension_Section, Comparison_Location_Detail_Extension_Section_Data, Comparison_Location_Detail]), CurrentValue, '118');
        AddLogEntry(Log, '47', [FormField, DataPointString, '', ErrorUndetermined, Suggestion], 1);
       end
       else
       begin
       // UAD 198
        AddLogEntry(Log, '81', [FormField, DataPointString + '% - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier) + '] Comparison Location Detail[n=' + InttoStr(nGSELocationType) + ']', ErrorCode, LogicError1, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Location_Detail_Extension, Comparison_Location_Detail_Extension_Section, Comparison_Location_Detail_Extension_Section_Data, Comparison_Location_Detail]), CurrentValue, '198');
        AddLogEntry(Log, '82', [FormField, DataPointString, '', ErrorUndetermined, Suggestion], 1);
       end;

       Result := Result + 1;

      end
      else
      begin

        nGSELocationType := nGSELocationType + 1;

        if nGSELocationType >= 3  then
        begin

          if ComparableSale_PropertySequenceIdentifier = 0 then
            // UAD 118
            AddLogEntry(Log, '46', [FormField, DataPointString + '% - Comparable Sale[0] Comparison Location Detail[n=' + InttoStr(nGSELocationType) + ']', ErrorCode, LogicError2, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Location_Detail_Extension, Comparison_Location_Detail_Extension_Section, Comparison_Location_Detail_Extension_Section_Data, Comparison_Location_Detail]), CurrentValue, '118')
          else
            // UAD 198
            AddLogEntry(Log, '81', [FormField, DataPointString + '% - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier) + '] Comparison Location Detail[n=' + InttoStr(nGSELocationType) + ']', ErrorCode, LogicError2, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Location_Detail_Extension, Comparison_Location_Detail_Extension_Section, Comparison_Location_Detail_Extension_Section_Data, Comparison_Location_Detail]), CurrentValue, '198');

          Result := Result + 1;
        end
        else
        begin

          if ComparableSale_PropertySequenceIdentifier = 0 then
            AddLogEntry(Log, '46', [FormField, DataPointString + '% - Comparable Sale[0] Comparison Location Detail[n=' + InttoStr(nGSELocationType) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Location_Detail_Extension, Comparison_Location_Detail_Extension_Section, Comparison_Location_Detail_Extension_Section_Data, Comparison_Location_Detail]), CurrentValue, '118')
          else
            AddLogEntry(Log, '81', [FormField, DataPointString + '% - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier) + '] Comparison Location Detail[n=' + InttoStr(nGSELocationType) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Location_Detail_Extension, Comparison_Location_Detail_Extension_Section, Comparison_Location_Detail_Extension_Section_Data, Comparison_Location_Detail]), CurrentValue, '198');
        end;



        if (CommonStr = 'Other') then
        begin

          if GetAttributeValue(oAttributes, 'GSELocationTypeOtherDescription', CommonBool, CurrentValue) = '' then
          begin
            if ComparableSale_PropertySequenceIdentifier = 0 then
              // UAD 121
              AddLogEntry(Log, '47', [FormField, DataPointString + '% - Comparable Sale[0] Comparison Location Detail[n=' + InttoStr(nGSELocationType) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Location_Detail_Extension, Comparison_Location_Detail_Extension_Section, Comparison_Location_Detail_Extension_Section_Data, Comparison_Location_Detail]), CurrentValue, '121')
            else
              // UAD 198
              AddLogEntry(Log, '82', [FormField, DataPointString + '% - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier) + '] Comparison Location Detail[n=' + InttoStr(nGSELocationType) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Location_Detail_Extension, Comparison_Location_Detail_Extension_Section, Comparison_Location_Detail_Extension_Section_Data, Comparison_Location_Detail]), CurrentValue, '198');

            Result := Result + 1;
          end
          else
          begin

            if ComparableSale_PropertySequenceIdentifier = 0 then
              AddLogEntry(Log, '47', [FormField, DataPointString + '% - Comparable Sale[0] Comparison Location Detail[n=' + InttoStr(nGSELocationType) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Location_Detail_Extension, Comparison_Location_Detail_Extension_Section, Comparison_Location_Detail_Extension_Section_Data, Comparison_Location_Detail]), CurrentValue, '121')
            else
              AddLogEntry(Log, '82', [FormField, DataPointString + '% - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier) + '] Comparison Location Detail[n=' + InttoStr(nGSELocationType) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Location_Detail_Extension, Comparison_Location_Detail_Extension_Section, Comparison_Location_Detail_Extension_Section_Data, Comparison_Location_Detail]), CurrentValue, '198');

          end;
        end;



      end;



    end;


  end;

{ }


{  '---REPETITIVE SOURCE---[VALUATION_RESPONSE/VALUATION_METHODS/SALES_COMPARISON/COMPARABLE_SALE/SALE_PRICE_ADJUSTMENT] -> _Description (PropertyRights, SiteArea, Age, GrossLivingArea, CarStorage, SalesConcessions, FinancingConcessions)'}
  if XPath.CommaText =  CreateCommaText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment])then
  begin

      if XPathSchema.IndexOfName(XPath.CommaText) <> - 1 then XPathSchema.Delete(XPathSchema.IndexOfName(XPath.CommaText));

      if ComparableSale_PropertySequenceIdentifier = 0 then
      begin

        // UAD 122
        if (_FormType = 'FNM1004') or (_FormType = 'FNM2055') then
          if GetAttributeValue(oAttributes, '_Type', CommonBool, CurrentValue) = 'SiteArea'then
            if not ValidateArea(GetAttributeValue(oAttributes, '_Description', CommonBool, CurrentValue)) then
            begin
              AddLogEntry(Log, '48', [FormField, DataPointString + '% - Comparable Sale[0] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '122');
              Result := Result + 1;
            end
            else
              AddLogEntry(Log, '48', [FormField, DataPointString + '% - Comparable Sale[0] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '122');


        // UAD 137
        if GetAttributeValue(oAttributes, '_Type', CommonBool, CurrentValue) = 'Age' then
        begin
          CommonInt := ValidateEstimation(GetAttributeValue(oAttributes, '_Description', CommonBool, CurrentValue));

          if (CommonInt < 0) or (CommonInt > 999) then
          begin
            AddLogEntry(Log, '50', [FormField, DataPointString + '% - Comparable Sale[0] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '137');
            Result := Result + 1;
          end
          else
            AddLogEntry(Log, '50', [FormField, DataPointString + '% - Comparable Sale[0] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '137')
        end;


        // UAD 148
        if GetAttributeValue(oAttributes, '_Type', CommonBool, CurrentValue) = 'GrossLivingArea' then
        begin

          CommonBool := ValidateNumber(GetAttributeValue(oAttributes, '_Description', CommonBool, CurrentValue), 0, CommonFloat, True);

          if (not CommonBool) or (CommonFloat > 99999) then
          begin
            AddLogEntry(Log, '54', [FormField, DataPointString + '% - Comparable Sale[0] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '148');
            Result := Result + 1;
          end
          else
            AddLogEntry(Log, '54', [FormField, DataPointString + '% - Comparable Sale[0] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '148')
        end;


        // UAD 165
        if GetAttributeValue(oAttributes, '_Type', CommonBool, CurrentValue) = 'EnergyEfficient' then
          if GetAttributeValue(oAttributes, '_Description', CommonBool, CurrentValue) = '' then
          begin
            AddLogEntry(Log, '62', [FormField, DataPointString + '% - Comparable Sale[0] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '165');
            Result := Result + 1;
          end
          else
            AddLogEntry(Log, '62', [FormField, DataPointString + '% - Comparable Sale[0] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '165');


        // UAD 166
        if GetAttributeValue(oAttributes, '_Type', CommonBool, CurrentValue) = 'CarStorage' then
          if GetAttributeValue(oAttributes, '_Description', CommonBool, CurrentValue) = '' then
          begin
            AddLogEntry(Log, '63', [FormField, DataPointString + '% - Comparable Sale[0] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreateCommaText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '166');
            Result := Result + 1;
          end
          else
            AddLogEntry(Log, '63', [FormField, DataPointString + '% - Comparable Sale[0] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, '', Suggestion], 2, CreateCommaText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '166')



      end
      else
      begin

        // UAD 179
        if GetAttributeValue(oAttributes, '_Type', CommonBool, CurrentValue) = 'SalesConcessions' then
          if (not ValidateNumber(GetAttributeValue(oAttributes, '_Amount', CommonBool, CurrentValue), 0, CommonFloat, True)) and (CommonBool) then
            AddLogEntry(Log, '72', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '179')
          else
            AddLogEntry(Log, '72', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '179');


        // UAD 185
        if GetAttributeValue(oAttributes, '_Type', CommonBool, CurrentValue) = 'FinancingConcessions' then
        begin

          CommonStr := GetAttributeValue(oAttributes, '_Amount', CommonBool, CurrentValue);

          if CommonStr <> '' then
            if not ValidateNumber(CommonStr, 0, CommonFloat, True) then
            begin
              AddLogEntry(Log, '76', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Sale Price Adjustmentn=[' + InttoStr(nSalesAdjustment) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '185');
              Result := Result + 1;
            end
            else
              AddLogEntry(Log, '76', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '185')
          else
            AddLogEntry(Log, '76', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '185');

        end;


        // UAD 195
        if GetAttributeValue(oAttributes, '_Type', CommonBool, CurrentValue) = 'DateOfSale' then
          if (not ValidateNumber(GetAttributeValue(oAttributes, '_Amount', CommonBool, CurrentValue), 0, CommonFloat, True)) and (CommonBool) then
          begin
            AddLogEntry(Log, '79', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '195');
            Result := Result + 1;
          end
          else
            AddLogEntry(Log, '79', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '195');


        // UAD 202
        if GetAttributeValue(oAttributes, '_Type', CommonBool, CurrentValue) = 'Location' then
          if (not ValidateNumber(GetAttributeValue(oAttributes, '_Amount', CommonBool, CurrentValue), 0, CommonFloat, True)) and (CommonBool) then
          begin
            AddLogEntry(Log, '83', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '202');
            Result := Result + 1;
          end
          else
            AddLogEntry(Log, '83', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '202');


        // UAD 203
        if GetAttributeValue(oAttributes, '_Type', CommonBool, CurrentValue) = 'PropertyRights' then
          if (not ValidateNumber(GetAttributeValue(oAttributes, '_Amount', CommonBool, CurrentValue), 0, CommonFloat, True)) and (CommonBool) then
          begin
            AddLogEntry(Log, '84', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '203');
            Result := Result + 1;
          end
          else
            AddLogEntry(Log, '84', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '203');


        if (_FormType = 'FNM1004') or (_FormType = 'FNM2055') then
        begin

          // UAD 204
          if GetAttributeValue(oAttributes, '_Type', CommonBool, CurrentValue) = 'SiteArea' then
            if not ValidateArea(GetAttributeValue(oAttributes, '_Description', CommonBool, CurrentValue)) then
            begin
              AddLogEntry(Log, '85', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '204');
              Result := Result + 1;
            end
            else
              AddLogEntry(Log, '85', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '204');


          // UAD 208
          if GetAttributeValue(oAttributes, '_Type', CommonBool, CurrentValue) = 'SiteArea' then
            if (not ValidateNumber(GetAttributeValue(oAttributes, '_Amount', CommonBool, CurrentValue), 0, CommonFloat, True)) and (CommonBool) then
            begin
              AddLogEntry(Log, '86', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '208');
              Result := Result + 1;
            end
            else
              AddLogEntry(Log, '86', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '208');
        end;


        // UAD 215
        if GetAttributeValue(oAttributes, '_Type', CommonBool, CurrentValue) = 'View' then
          if (not ValidateNumber(GetAttributeValue(oAttributes, '_Amount', CommonBool, CurrentValue), 0, CommonFloat, True)) and (CommonBool) then
          begin
            AddLogEntry(Log, '90', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '215');
            Result := Result + 1;
          end
          else
            AddLogEntry(Log, '90', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '215');


        // UAD 216
        if GetAttributeValue(oAttributes, '_Type', CommonBool, CurrentValue) = 'DesignStyle' then
          if (not ValidateNumber(GetAttributeValue(oAttributes, '_Amount', CommonBool, CurrentValue), 0, CommonFloat, True)) and (CommonBool) then
          begin
            AddLogEntry(Log, '91', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '216');
            Result := Result + 1;
          end
          else
            AddLogEntry(Log, '91', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '216');


        // UAD 219
        if GetAttributeValue(oAttributes, '_Type', CommonBool, CurrentValue) = 'Quality' then
          if (not ValidateNumber(GetAttributeValue(oAttributes, '_Amount', CommonBool, CurrentValue), 0, CommonFloat, True)) and (CommonBool) then
          begin
            AddLogEntry(Log, '93', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '219');
            Result := Result + 1;
          end
          else
            AddLogEntry(Log, '93', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '219');


        // UAD 220
        if GetAttributeValue(oAttributes, '_Type', CommonBool, CurrentValue) = 'Age' then
        begin
          CommonInt := ValidateEstimation(GetAttributeValue(oAttributes, '_Description', CommonBool, CurrentValue));

          if (CommonInt < 0) or (CommonInt > 999) then
          begin
            AddLogEntry(Log, '94', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '220');
            Result := Result + 1;
          end
          else
            AddLogEntry(Log, '94', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '220');
        end;


        // UAD 222
        if GetAttributeValue(oAttributes, '_Type', CommonBool, CurrentValue) = 'Age' then
          if (not ValidateNumber(GetAttributeValue(oAttributes, '_Amount', CommonBool, CurrentValue), 0, CommonFloat, True)) and (CommonBool) then
          begin
            AddLogEntry(Log, '95', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '222');
            Result := Result + 1;
          end
          else
            AddLogEntry(Log, '95', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '222');


       // UAD 225
        if GetAttributeValue(oAttributes, '_Type', CommonBool, CurrentValue) = 'Condition' then
          if (not ValidateNumber(GetAttributeValue(oAttributes, '_Amount', CommonBool, CurrentValue), 0, CommonFloat, True)) and (CommonBool) then
          begin
            AddLogEntry(Log, '97', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '225');
            Result := Result + 1;
          end
          else
            AddLogEntry(Log, '97', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '225');


        // UAD 226
        if (GetAttributeValue(oAttributes, '_Type', CommonBool, CurrentValue) = 'Other') and (GetAttributeValue(oAttributes, '_TypeOtherDescription', CommonBool, CurrentValue) = 'RoomAboveGradeLine1') then
          if (not ValidateNumber(GetAttributeValue(oAttributes, '_Amount', CommonBool, CurrentValue), 0, CommonFloat, True)) and (CommonBool) then
          begin
            AddLogEntry(Log, '98', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '226');
            Result := Result + 1;
          end
          else
            AddLogEntry(Log, '98', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '226');


        // UAD 233
        if (GetAttributeValue(oAttributes, '_Type', CommonBool, CurrentValue) = 'Other') and (GetAttributeValue(oAttributes, '_TypeOtherDescription', CommonBool, CurrentValue) = 'RoomAboveGradeLine2') then
          if (not ValidateNumber(GetAttributeValue(oAttributes, '_Amount', CommonBool, CurrentValue), 0, CommonFloat, True)) and (CommonBool) then
          begin
            AddLogEntry(Log, '102', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '233');
            Result := Result + 1;
          end
          else
            AddLogEntry(Log, '102', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '233');


        // UAD 234
        if GetAttributeValue(oAttributes, '_Type', CommonBool, CurrentValue) = 'GrossLivingArea' then
        begin

          CommonBool := ValidateNumber(GetAttributeValue(oAttributes, '_Description', CommonBool, CurrentValue), 0, CommonFloat, True);

          if (not CommonBool) or (CommonFloat > 99999) then
          begin
            AddLogEntry(Log, '103', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '234');
            Result := Result + 1;
          end
          else
            AddLogEntry(Log, '103', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '234');
        end;


        // UAD 236
        if GetAttributeValue(oAttributes, '_Type', CommonBool, CurrentValue) = 'GrossLivingArea' then
          if (not ValidateNumber(GetAttributeValue(oAttributes, '_Amount', CommonBool, CurrentValue), 0, CommonFloat, True)) and (CommonBool) then
          begin
            AddLogEntry(Log, '104', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '236');
            Result := Result + 1;
          end
          else
            AddLogEntry(Log, '104', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '236');


        // UAD 237
        if GetAttributeValue(oAttributes, '_Type', CommonBool, CurrentValue) = 'BasementArea' then
          if (not ValidateNumber(GetAttributeValue(oAttributes, '_Amount', CommonBool, CurrentValue), 0, CommonFloat, True)) and (CommonBool) then
          begin
            AddLogEntry(Log, '112', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '237');
            Result := Result + 1;
          end
          else
            AddLogEntry(Log, '112', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '237');


        // UAD 253
        if GetAttributeValue(oAttributes, '_Type', CommonBool, CurrentValue) = 'BasementFinish' then
          if (not ValidateNumber(GetAttributeValue(oAttributes, '_Amount', CommonBool, CurrentValue), 0, CommonFloat, True)) and (CommonBool) then
          begin
            AddLogEntry(Log, '113', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '253');
            Result := Result + 1;
          end
          else
            AddLogEntry(Log, '113', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '253');


        // UAD 254
        if GetAttributeValue(oAttributes, '_Type', CommonBool, CurrentValue) = 'FunctionalUtility' then
          if (not ValidateNumber(GetAttributeValue(oAttributes, '_Amount', CommonBool, CurrentValue), 0, CommonFloat, True)) and (CommonBool) then
          begin
            AddLogEntry(Log, '114', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '254');
            Result := Result + 1;
          end
          else
            AddLogEntry(Log, '114', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '254');


        // UAD 255
        if GetAttributeValue(oAttributes, '_Type', CommonBool, CurrentValue) = 'HeatingCooling' then
          if (not ValidateNumber(GetAttributeValue(oAttributes, '_Amount', CommonBool, CurrentValue), 0, CommonFloat, True)) and (CommonBool) then
          begin
            AddLogEntry(Log, '115', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '255');
            Result := Result + 1;
          end
          else
            AddLogEntry(Log, '115', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '255');


        if GetAttributeValue(oAttributes, '_Type', CommonBool, CurrentValue) = 'EnergyEfficient' then
        begin
          // UAD 256
          if GetAttributeValue(oAttributes, '_Description', CommonBool, CurrentValue) = ''then
          begin
            AddLogEntry(Log, '116', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '256');
            Result := Result + 1;
          end
          else
            AddLogEntry(Log, '116', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier )  + '] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '256');

          // UAD 257
          if (not ValidateNumber(GetAttributeValue(oAttributes, '_Amount', CommonBool, CurrentValue), 0, CommonFloat, True)) and (CommonBool) then
          begin
            AddLogEntry(Log, '117', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '257');
            Result := Result + 1;
          end
          else
            AddLogEntry(Log, '117', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '257');
        end;


        if GetAttributeValue(oAttributes, '_Type', CommonBool, CurrentValue) = 'CarStorage' then
        begin
          // UAD 258
          if GetAttributeValue(oAttributes, '_Description', CommonBool, CurrentValue) = '' then
          begin
            AddLogEntry(Log, '118', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '258');
            Result := Result + 1;
          end
          else
            AddLogEntry(Log, '118', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '258');

          // UAD 259
          if (not ValidateNumber(GetAttributeValue(oAttributes, '_Amount', CommonBool, CurrentValue), 0, CommonFloat, True)) and (Commonbool) then
          begin
            AddLogEntry(Log, '119', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '259');
            Result := Result + 1;
          end
          else
            AddLogEntry(Log, '119', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '259');
        end;


        // UAD 260
        if GetAttributeValue(oAttributes, '_Type', CommonBool, CurrentValue) = 'PorchDeck' then
          if (not ValidateNumber(GetAttributeValue(oAttributes, '_Amount', CommonBool, CurrentValue), 0, CommonFloat, True)) and (CommonBool) then
          begin
            AddLogEntry(Log, '120', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '260');
            Result := Result + 1;
          end
          else
            AddLogEntry(Log, '120', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Sale Price Adjustment[n=' + InttoStr(nSalesAdjustment) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '260');


            
        if (_FormType = 'FNM1004') or (_FormType = 'FNM2055') then
          if ValidateNumber(GetAttributeValue(oAttributes, '_Amount', CommonBool, CurrentValue), 0, CommonFloat, True) then
            TotalSalePriceAdjustmentAmount := TotalSalePriceAdjustmentAmount + Round(CommonFloat);

      end;


    //Exit; --- exity is not permitted here because of the repetition
  end;
{ }


{  '**REPETITION** [VALUATION_METHODS/SALES_COMPARISON..COMPARISON_DETAIL] -> GSEQualityOfConstructionRatingType, GSEBelowGradeTotalSquareFeetNumber, GSEBasementExitType, GSEBelowGradeRecreationRoomCount, GSEBelowGradeBedroomRoomCount, GSEBelowGradeBathroomRoomCount, GSEBelowGradeOtherRoomCount, GSEDataSourceDescription, GSESaleType, GSEFinancingType, GSEFinancingTypeOtherDescription, GSEConcessionAmount, GSEListingStatusType'}
  if XPath.CommaText =  CreateCommaText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]) then
  begin

    if (ComparableSale_PropertySequenceIdentifier = 0) and (ExtensionSectionOrganizationName) then   // check if correct XPath
    begin

      // UAD 135
      if not CheckEnum(GSEQualityOfConstructionRatingType, GetAttributeValue(oAttributes, 'GSEQualityOfConstructionRatingType', CommonBool, CurrentValue)) then
      begin
        AddLogEntry(Log, '49', [FormField, DataPointString + '% - Comparable Sale[0]', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]), CurrentValue, '135');
        Result :=Result + 1;
      end
      else
        AddLogEntry(Log, '49', [FormField, DataPointString + '% - Comparable Sale[0]', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]), CurrentValue, '135');


      //------------------

      // UAD 151
      CommonBool := ValidateNumber(GetAttributeValue(oAttributes, 'GSEBelowGradeTotalSquareFeetNumber', CommonBool, CurrentValue), 0, CommonFloat, True);
      if (not CommonBool) or (CommonFloat > 99999) then
      begin
        AddLogEntry(Log, '55', [FormField, DataPointString + '% - Comparable Sale[0]', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]), CurrentValue, '151');


        // warning messages
        AddLogEntry(Log, '56', [FormField, DataPointString, '', ErrorUndetermined, ''], 1);

        AddLogEntry(Log, '57', [FormField, DataPointString, '', ErrorMessage, ''],1);
        AddLogEntry(Log, '58', [FormField, DataPointString, '', ErrorUndetermined, ''], 1);
        AddLogEntry(Log, '59', [FormField, DataPointString, '', ErrorUndetermined, ''], 1);
        AddLogEntry(Log, '60', [FormField, DataPointString, '', ErrorUndetermined, ''], 1);
        AddLogEntry(Log, '61', [FormField, DataPointString, '', ErrorUndetermined, ''], 1);

        Result :=Result + 1;
      end
      else
      begin

        AddLogEntry(Log, '55', [FormField, DataPointString + '% - Comparable Sale[0]', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]), CurrentValue, '151');


        // UAD 153
        CommonBool1 := ValidateNumber(GetAttributeValue(oAttributes, 'GSEBelowGradeFinishSquareFeetNumber', CommonBool, CurrentValue), 0, CommonFloat1, True);

        if ((CommonBool) and (not CommonBool1)) or ((CommonBool) and  (CommonFloat1 > 12345)) or ((CommonBool) and ((CommonFloat = 0) and (CommonFloat1 > 0))) then
        //if (not CommonBool) or (CommonFloat1 > 12345) or ((CommonFloat = 0) and (CommonFloat1 > 0)) then          // UAD rule changed
        begin

         if ((CommonFloat = 0) and (CommonFloat1 > 0)) then
            AddLogEntry(Log, '56', [FormField, DataPointString + '% - Comparable Sale[0]', ErrorCode, LogicError1, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]), CurrentValue, '153')
          else
            AddLogEntry(Log, '56', [FormField, DataPointString + '% - Comparable Sale[0]', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]), CurrentValue, '153');

          // warning messages go here
          AddLogEntry(Log, '57', [FormField, DataPointString, '', ErrorUndetermined, ''], 1);
          AddLogEntry(Log, '58', [FormField, DataPointString, '', ErrorUndetermined, ''], 1);
          AddLogEntry(Log, '59', [FormField, DataPointString, '', ErrorUndetermined, ''], 1);
          AddLogEntry(Log, '60', [FormField, DataPointString, '', ErrorUndetermined, ''], 1);
          AddLogEntry(Log, '61', [FormField, DataPointString, '', ErrorUndetermined, ''], 1);

          Result := Result + 1;

        end
        else
        begin

          AddLogEntry(Log, '56', [FormField, DataPointString + '% - Comparable Sale[0]', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]), CurrentValue, '153');

          // UAD 155
          if (not CheckEnum(GSEBasementExitType, GetAttributeValue(oAttributes, 'GSEBasementExitType', CommonBool, CurrentValue))) and (CommonBool) then
          begin
            AddLogEntry(Log, '57', [FormField, DataPointString + '% - Comparable Sale[0]', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]), CurrentValue, '155');
            Result :=Result + 1;
          end
          else
            AddLogEntry(Log, '57', [FormField, DataPointString + '% - Comparable Sale[0]', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]), CurrentValue, '155');



          // UAD 157
          if CommonFloat1 <> InvalidInt then
          begin

            CommonBool := ValidateNumber(GetAttributeValue(oAttributes, 'GSEBelowGradeRecreationRoomCount', CommonBool, CurrentValue), 0, CommonFloat, True);

            if CommonFloat1 > 0 then //GSEBelowGradeFinishSquareFeetNumber
              if (CommonFloat > 9) or (CommonFloat < 0)then
              begin
                AddLogEntry(Log, '58', [FormField, DataPointString + '% - Comparable Sale[0]', ErrorCode, ErrorMessage, Suggestion], 0,CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]), CurrentValue, '157');
                Result :=Result + 1;
              end
              else
                AddLogEntry(Log, '58', [FormField, DataPointString + '% - Comparable Sale[0]', ErrorCode, '', Suggestion], 2,CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]), CurrentValue, '157');

          end;



          // UAD 159
          if CommonFloat1 <> InvalidInt then
          begin

            CommonBool := ValidateNumber(GetAttributeValue(oAttributes, 'GSEBelowGradeBedroomRoomCount', CommonBool, CurrentValue), 0, CommonFloat, True);

            if CommonFloat1 > 0 then   //GSEBelowGradeFinishSquareFeetNumber
              if (CommonFloat > 9) or (CommonFloat < 0)then
              begin
                AddLogEntry(Log, '59', [FormField, DataPointString + '% - Comparable Sale[0]', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]), CurrentValue, '159');
                Result :=Result + 1;
              end
              else
                AddLogEntry(Log, '59', [FormField, DataPointString + '% - Comparable Sale[0]', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]), CurrentValue, '159');

          end;



          // UAD 161
          if CommonFloat1 <> InvalidInt then
          begin

            CommonBool := ValidateNumber(GetAttributeValue(oAttributes, 'GSEBelowGradeBathroomRoomCount', CommonBool, CurrentValue), 1, CommonFloat, False);

            if CommonFloat1 > 0 then   //GSEBelowGradeFinishSquareFeetNumber
              if (not CommonBool) or (CommonFloat > 9.9)then
              begin
                AddLogEntry(Log, '60', [FormField, DataPointString + '% - Comparable Sale[0]', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]), CurrentValue, '161');
                Result :=Result + 1;
              end
              else
                AddLogEntry(Log, '60', [FormField, DataPointString + '% - Comparable Sale[0]', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]), CurrentValue, '161');
          end;


          // UAD 163
          if CommonFloat1 <> InvalidInt then
          begin

            CommonBool := ValidateNumber(GetAttributeValue(oAttributes, 'GSEBelowGradeOtherRoomCount', CommonBool, CurrentValue), 0, CommonFloat, True);

            if CommonFloat1 > 0 then   //GSEBelowGradeFinishSquareFeetNumber
              if (CommonFloat > 9) or (CommonFloat < 0)then
              begin
                AddLogEntry(Log, '61', [FormField, DataPointString + '% - Comparable Sale[0]', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]), CurrentValue, '163');
                Result :=Result + 1;
              end
              else
                AddLogEntry(Log, '61', [FormField, DataPointString + '% - Comparable Sale[0]', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]), CurrentValue, '163');

          end;

        end;
      end;
    end;


    // other sales
    if ComparableSale_PropertySequenceIdentifier <> 0 then
    begin

      // UAD 176
      if GetAttributeValue(oAttributes, 'GSEDataSourceDescription', CommonBool, CurrentValue) = '' then
      begin
        AddLogEntry(Log, '70', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]), CurrentValue, '176');
        Result :=Result + 1;
      end
      else
        AddLogEntry(Log, '70', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]), CurrentValue, '176');


      // UAD 177
      if not CheckEnum(GSESaleType_Comparable, GetAttributeValue(oAttributes, 'GSESaleType', CommonBool, CurrentValue)) then
      begin
        AddLogEntry(Log, '71', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]), CurrentValue, '177');
        Result :=Result + 1;
      end
      else
        AddLogEntry(Log, '71', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]), CurrentValue, '177');


       // UAD 180
      CommonStr := GetAttributeValue(oAttributes, 'GSEFinancingType', CommonBool, CurrentValue);
      if (not CheckEnum(GSEFinancingType, CommonStr)) and  (GSEListingStatusType_Comparisons[ComparisonCounter - 1] = 'SettledSale') then
      begin
        AddLogEntry(Log, '73', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]), CurrentValue, '180');
        AddLogEntry(Log, '74', [FormField, DataPointString, '', ErrorUndetermined, ''], 1);
        Result :=Result + 1;
      end
      else
        AddLogEntry(Log, '73', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]), CurrentValue, '180');





     // UAD 182
      if (CommonStr = 'Other') then
        if GetAttributeValue(oAttributes, 'GSEFinancingTypeOtherDescription', CommonBool, CurrentValue) = ''then
        begin
          AddLogEntry(Log, '74', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]), CurrentValue, '182');
          Result := Result + 1;
        end
        else
          AddLogEntry(Log, '74', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]), CurrentValue, '182');


     // UAD 183
      if (not ValidateNumber(GetAttributeValue(oAttributes, 'GSEConcessionAmount', CommonBool, CurrentValue), 0, CommonFloat, True)) and (GSEListingStatusType_Comparisons[ComparisonCounter - 1] = 'SettledSale') then
      begin
       AddLogEntry(Log, '75', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]), CurrentValue, '183');
       Result := Result + 1;
      end
      else
       AddLogEntry(Log, '75', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]), CurrentValue, '183');



      // UAD 186
      // The GSEListingStatusType is collected in Cycle 1 and will be checked from that array.
      if not CheckEnum(GSEListingStatusType, GSEListingStatusType_Comparisons[ComparisonCounter - 1]) then
       AddLogEntry(Log, '77', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]), GSEListingStatusType_Comparisons[ComparisonCounter - 1], '186')
      else
       AddLogEntry(Log, '77', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]), GSEListingStatusType_Comparisons[ComparisonCounter - 1], '186');


      // UAD 217
      if not CheckEnum(GSEQualityOfConstructionRatingType, GetAttributeValue(oAttributes, 'GSEQualityOfConstructionRatingType', CommonBool, CurrentValue)) then
      begin
        AddLogEntry(Log, '92', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]), CurrentValue, '217');
        Result :=Result + 1;
      end
      else
        AddLogEntry(Log, '92', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]), CurrentValue, '217');


      // UAD 223
      if not CheckEnum(GSEOverallConditionType, GetAttributeValue(oAttributes, 'GSEOverallConditionType', CommonBool, CurrentValue)) then
      begin
        AddLogEntry(Log, '96', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]), CurrentValue, '223');
        Result :=Result + 1;
      end
      else
        AddLogEntry(Log, '96', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]), CurrentValue, '223');





      //------------------

      // UAD 238
      CommonBool := ValidateNumber(GetAttributeValue(oAttributes, 'GSEBelowGradeTotalSquareFeetNumber', CommonBool, CurrentValue), 0, CommonFloat, True);
      if (not CommonBool) or (CommonFloat > 12345) then
      begin
        AddLogEntry(Log, '105', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]), CurrentValue, '238');

        // warning messages
        AddLogEntry(Log, '106', [FormField, DataPointString, '', ErrorUndetermined, ''], 1);

        AddLogEntry(Log, '107', [FormField, DataPointString, '', ErrorMessage, ''],1);
        AddLogEntry(Log, '108', [FormField, DataPointString, '', ErrorUndetermined, ''], 1);
        AddLogEntry(Log, '109', [FormField, DataPointString, '', ErrorUndetermined, ''], 1);
        AddLogEntry(Log, '110', [FormField, DataPointString, '', ErrorUndetermined, ''], 1);
        AddLogEntry(Log, '111', [FormField, DataPointString, '', ErrorUndetermined, ''], 1);
        Result :=Result + 1;
      end
      else
      begin

        AddLogEntry(Log, '105', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]), CurrentValue, '238');

        // UAD 240


        CommonBool1 := ValidateNumber(GetAttributeValue(oAttributes, 'GSEBelowGradeFinishSquareFeetNumber', CommonBool, CurrentValue), 0, CommonFloat1, True);

       // if (not CommonBool) or (CommonFloat1 > 12345) or ((CommonFloat = 0) and (CommonFloat1 > 0)) then   UAD rule changed


        if ((CommonBool) and (not CommonBool1)) or ((CommonBool) and  (CommonFloat1 > 12345)) or ((CommonBool) and ((CommonFloat = 0) and (CommonFloat1 > 0))) then
        begin

          if ((CommonFloat = 0) and (CommonFloat1 > 0)) then
            AddLogEntry(Log, '106', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, LogicError1, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]), CurrentValue, '240')
          else
            AddLogEntry(Log, '106', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]), CurrentValue, '240');



          // warning messages go here
          AddLogEntry(Log, '107', [FormField, DataPointString, '', ErrorUndetermined, ''], 1);
          AddLogEntry(Log, '108', [FormField, DataPointString, '', ErrorUndetermined, ''], 1);
          AddLogEntry(Log, '109', [FormField, DataPointString, '', ErrorUndetermined, ''], 1);
          AddLogEntry(Log, '110', [FormField, DataPointString, '', ErrorUndetermined, ''], 1);
          AddLogEntry(Log, '111', [FormField, DataPointString, '', ErrorUndetermined, ''], 1);

          Result := Result + 1;
        end
        else
        begin

          AddLogEntry(Log, '106', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]), CurrentValue, '240');


          // UAD 243
          if (not CheckEnum(GSEBasementExitType, GetAttributeValue(oAttributes, 'GSEBasementExitType', CommonBool, CurrentValue))) and (CommonBool) then
          begin
            AddLogEntry(Log, '107', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]), CurrentValue, '243');
            Result :=Result + 1;
          end
          else
            AddLogEntry(Log, '107', [FormField, DataPointString + '% [' + InttoStr(ComparisonCounter) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]), CurrentValue, '243');


          // UAD 245
          if CommonFloat1 <> InvalidInt then
          begin

            CommonBool := ValidateNumber(GetAttributeValue(oAttributes, 'GSEBelowGradeRecreationRoomCount', CommonBool, CurrentValue), 0, CommonFloat, True);

            if CommonFloat1 > 0 then   //GSEBelowGradeFinishSquareFeetNumber
              if (CommonFloat > 9) or (CommonFloat < 0)then
              begin
                AddLogEntry(Log, '108', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]), CurrentValue, '245');
                Result :=Result + 1;
              end
              else
                AddLogEntry(Log, '108', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]), CurrentValue, '245');
          end;



          // UAD 247
          if CommonFloat1 <> InvalidInt then
          begin

            CommonBool := ValidateNumber(GetAttributeValue(oAttributes, 'GSEBelowGradeBedroomRoomCount', CommonBool, CurrentValue), 0, CommonFloat, True);

            if CommonFloat1 > 0 then   //GSEBelowGradeFinishSquareFeetNumber
              if (CommonFloat > 9) or (CommonFloat < 0)then
              begin
                AddLogEntry(Log, '109', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]), CurrentValue, '247');
                Result :=Result + 1;
              end
              else
                AddLogEntry(Log, '109', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]), CurrentValue, '247');
          end;



          // UAD 249
          if CommonFloat1 <> InvalidInt then
          begin

            CommonBool := ValidateNumber(GetAttributeValue(oAttributes, 'GSEBelowGradeBathroomRoomCount', CommonBool, CurrentValue), 1, CommonFloat, False);

            if CommonFloat1 > 0 then   //GSEBelowGradeFinishSquareFeetNumber
              if (not CommonBool) or (CommonFloat > 9.9)then
              begin
                AddLogEntry(Log, '110', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]), CurrentValue, '249');
                Result :=Result + 1;
              end
              else
                AddLogEntry(Log, '110', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]), CurrentValue, '249');
          end;



          // UAD 251
          if CommonFloat1 <> InvalidInt then
          begin

            CommonBool := ValidateNumber(GetAttributeValue(oAttributes, 'GSEBelowGradeOtherRoomCount', CommonBool, CurrentValue), 0, CommonFloat, True);

            if CommonFloat1 > 0 then   //GSEBelowGradeFinishSquareFeetNumber
              if (CommonFloat > 9) or (CommonFloat < 0)then
              begin
                AddLogEntry(Log, '111', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]), CurrentValue, '251');
                Result :=Result + 1;
              end
              else
                AddLogEntry(Log, '111', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]), CurrentValue, '251');
          end;

        end;

      end;   


    end;

   
  end;

{ }


{  '[VALUATION_RESPONSE/VALUATION_METHODS/SALES_COMPARISON/COMPARABLE_SALE/ROOM_ADJUSTMENT] -> TotalRoomCount, TotalBedroomCount, TotalBathroomCount'}
  if XPath.CommaText =  CreateCommaText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Room_Adjustment])then
  begin

    if XPathSchema.IndexOfName(XPath.CommaText) <> - 1 then XPathSchema.Delete(XPathSchema.IndexOfName(XPath.CommaText));
///Skip review of totalroomcount - appraisers do not use the adjustment cell above & to the right of the room count row

    CommonBool := ValidateNumber(GetAttributeValue(oAttributes, 'TotalRoomCount', CommonBool, CurrentValue), 0, CommonFloat, True);
    if (not CommonBool) or (CommonFloat > 99) then
    begin

     if ComparableSale_PropertySequenceIdentifier  = 0 then
     // UAD 142
      AddLogEntry(Log, '51', [FormField, DataPointString + '% - Comparable Sale[0]', ErrorCode, ErrorMessage, Suggestion], 0, CreateCommaText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Room_Adjustment]), CurrentValue, '142')
     else
     // UAD 227
      AddLogEntry(Log, '99', [FormField, DataPointString + '% [' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Room_Adjustment]), CurrentValue, '227');

      Result := Result + 1;

    end
    else
    begin
      if ComparableSale_PropertySequenceIdentifier  = 0 then
        AddLogEntry(Log, '51', [FormField, DataPointString + '% - Comparable Sale[0]', ErrorCode, '', Suggestion], 2, CreateCommaText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Room_Adjustment]), CurrentValue, '142')
      else
        AddLogEntry(Log, '99', [FormField, DataPointString + '% [' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Room_Adjustment]), CurrentValue, '227');
    end;




    CommonBool := ValidateNumber(GetAttributeValue(oAttributes, 'TotalBedroomCount', CommonBool, CurrentValue), 0, CommonFloat, True);
    if (not CommonBool) or (CommonFloat > 99) then
    begin

      if ComparableSale_PropertySequenceIdentifier = 0 then
       // UAD 144
        AddLogEntry(Log, '52', [FormField, DataPointString + '% - Comparable Sale[0]', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Room_Adjustment]), CurrentValue, '144')
      else
      // UAD 229
        AddLogEntry(Log, '100', [FormField, DataPointString + '% [' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Room_Adjustment]), CurrentValue, '229');

      Result := Result + 1;

    end
    else
    begin
      if ComparableSale_PropertySequenceIdentifier  = 0 then
        AddLogEntry(Log, '52', [FormField, DataPointString + '% - Comparable Sale[0]', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Room_Adjustment]), CurrentValue, '144')
      else
        AddLogEntry(Log, '100', [FormField, DataPointString + '% [' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Room_Adjustment]), CurrentValue, '229');
    end;




    CommonBool := ValidateNumber(GetAttributeValue(oAttributes, 'TotalBathroomCount', CommonBool, CurrentValue), 2, CommonFloat, False);
    if (not CommonBool) or (CommonFloat > 99.99) then
    begin
      if ComparableSale_PropertySequenceIdentifier = 0 then
      // UAD 146
        AddLogEntry(Log, '53', [FormField, DataPointString + '% - Comparable Sale[0]', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Room_Adjustment]), CurrentValue, '146')
      else
      // UAD 231
        AddLogEntry(Log, '101', [FormField, DataPointString + '% [' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Room_Adjustment]), CurrentValue, '231');

      Result := Result + 1;

    end
    else
    begin
      if ComparableSale_PropertySequenceIdentifier  = 0 then
        AddLogEntry(Log, '53', [FormField, DataPointString + '% - Comparable Sale[0]', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Room_Adjustment]), CurrentValue, '146')
      else
        AddLogEntry(Log, '101', [FormField, DataPointString + '% [' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Room_Adjustment]), CurrentValue, '231');
    end;


  end;
{ }


{  '!!!REPETITIVE SOURCE!!! [VALUATION_RESPONSE/VALUATION_METHODS/SALES_COMPARISON/COMPARABLE_SALE/LOCATION] -> PropertyStreetAddress, PropertyCity, PropertyState, PropertyPostalCode, ProximityToSubjectDescription)'}
  if XPath.CommaText =  CreateCommaText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Location])then
  begin

    if XPathSchema.IndexOfName(XPath.CommaText) <> - 1 then XPathSchema.Delete(XPathSchema.IndexOfName(XPath.CommaText));

    if ComparableSale_PropertySequenceIdentifier <> 0 then
    begin

      // UAD  167
      if GetAttributeValue(oAttributes, 'PropertyStreetAddress', CommonBool, CurrentValue) = '' then
      begin
        AddLogEntry(Log, '64', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Location]), CurrentValue, '167');
        Result := Result + 1;
      end
      else
        AddLogEntry(Log, '64', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Location]), CurrentValue, '167');


      // UAD  168
      if GetAttributeValue(oAttributes, 'PropertyCity', CommonBool, CurrentValue) = '' then
      begin
        AddLogEntry(Log, '65', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Location]), CurrentValue, '168');
        Result := Result + 1;
      end
      else
        AddLogEntry(Log, '65', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Location]), CurrentValue, '168');


      // UAD  169
      if Pos(LowerCase(GetAttributeValue(oAttributes, 'PropertyState', CommonBool, CurrentValue)), States) = 0 then
      begin
        AddLogEntry(Log, '66', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Location]), CurrentValue, '169');
        Result := Result + 1;
      end
      else
        AddLogEntry(Log, '66', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Location]), CurrentValue, '169');



      // UAD  171
      if not ValidateZipCode(GetAttributeValue(oAttributes, 'PropertyPostalCode', CommonBool, CurrentValue)) then
      begin
        AddLogEntry(Log, '67', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Location]), CurrentValue, '171');
        Result := Result + 1;
      end
      else
        AddLogEntry(Log, '67', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Location]), CurrentValue, '171');

      // UAD 173
      if GetAttributeValue(oAttributes, 'ProximityToSubjectDescription', CommonBool, CurrentValue) = '' then
      begin
        AddLogEntry(Log, '68', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Location]), CurrentValue, '173');
        Result := Result + 1;
      end
      else
        AddLogEntry(Log, '68', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Location]), CurrentValue, '173');


      if (GetAttributeValue(oAttributes, 'LatitudeNumber', CommonBool, CurrentValue) = '') or (GetAttributeValue(oAttributes, 'LatitudeNumber', CommonBool, CurrentValue) = '0.000000000000') then
      begin
        AddLogEntry(Log, '160', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Location]), CurrentValue, '167');
        Result := Result + 1;
      end
      else
        AddLogEntry(Log, '160', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Location]), CurrentValue, '167');

      if (GetAttributeValue(oAttributes, 'LongitudeNumber', CommonBool, CurrentValue) = '') or (GetAttributeValue(oAttributes, 'LongitudeNumber', CommonBool, CurrentValue) = '0.000000000000') then
      begin
        AddLogEntry(Log, '161', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Location]), CurrentValue, '167');
        Result := Result + 1;
      end
      else
        AddLogEntry(Log, '161', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Location]), CurrentValue, '167');

    end
    else
      begin

        if (GetAttributeValue(oAttributes, 'LatitudeNumber', CommonBool, CurrentValue) = '') or (GetAttributeValue(oAttributes, 'LatitudeNumber', CommonBool, CurrentValue) = '0.000000000000') then
        begin
          AddLogEntry(Log, '162', [FormField, DataPointString + '%  - Subject', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Location]), CurrentValue, '167');
          Result := Result + 1;
        end
        else
          AddLogEntry(Log, '162', [FormField, DataPointString + '%  - Subject', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Location]), CurrentValue, '167');

        if (GetAttributeValue(oAttributes, 'LongitudeNumber', CommonBool, CurrentValue) = '') or (GetAttributeValue(oAttributes, 'LongitudeNumber', CommonBool, CurrentValue) = '0.000000000000') then
        begin
          AddLogEntry(Log, '163', [FormField, DataPointString + '%  - Subject', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Location]), CurrentValue, '167');
          Result := Result + 1;
        end
        else
          AddLogEntry(Log, '163', [FormField, DataPointString + '%  - Subject', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Location]), CurrentValue, '167');

    end;
  end;
{ }


{  '[VALUATION_METHODS/SALES_COMPARISON..OFFERING_DISPOSITION] -> GSEShortDateDescription'}
  if XPath.CommaText =  CreateCommaText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Date_Extension, Comparison_Date_Extension_Section, Comparison_Date_Extension_Section_Data, Offering_Disposition]) then
  begin

    if XPathSchema.IndexOfName(XPath.CommaText) <> - 1 then XPathSchema.Delete(XPathSchema.IndexOfName(XPath.CommaText));

    if (ComparableSale_PropertySequenceIdentifier <> 0) and (ExtensionSectionOrganizationName) then   // check if correct XPath
    begin


      // UAD 188     -  Part 1
      nGSEShortDateDescription := nGSEShortDateDescription + 1;

      CommonStr := GetAttributeValue(oAttributes, 'GSEShortDateDescription', CommonBool, CurrentValue);

      if (GSEListingStatusType_Comparisons[ComparisonCounter - 1] = 'Active') and (CommonStr <> '') then
      begin
        AddLogEntry(Log, '78', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Offering Dispossition[n=' + InttoStr(nGSEShortDateDescription) + ']', ErrorCode, LogicError2, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Date_Extension, Comparison_Date_Extension_Section, Comparison_Date_Extension_Section_Data, Offering_Disposition]), CurrentValue, '188');
        Result := Result + 1;
        ShortDateFailed := True;
      end
      else
      begin
        CommonBool := (GSEListingStatusType_Comparisons[ComparisonCounter - 1] = 'Expired') or (GSEListingStatusType_Comparisons[ComparisonCounter - 1] = 'Withdrawn') or (GSEListingStatusType_Comparisons[ComparisonCounter - 1] = 'Contract') or (GSEListingStatusType_Comparisons[ComparisonCounter - 1] = 'SettledSale');

        if (CommonBool) and (not ValidateShortDate(CommonStr)) then
        begin
          AddLogEntry(Log, '78', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Offering Dispossition[n=' + InttoStr(nGSEShortDateDescription) + ']', ErrorCode, LogicError2, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Date_Extension, Comparison_Date_Extension_Section, Comparison_Date_Extension_Section_Data, Offering_Disposition]), CommonStr, '188');
          Result := Result + 1;
          ShortDateFailed := True;
        end;

      end;


    end;


  end;
{ }


{  '%%%REPETITION%%%[VALUATION_METHODS/SALES_COMPARISON..COMPARISON_VIEW_OVERALL_RATING] -> GSEViewOverallRatingType (comparable)'}
  if XPath.CommaText =  CreateCommaText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_View_Overall_Rating_Extension, Comparison_View_Overall_Rating_Extension_Section, Comparison_View_Overall_Rating_Extension_Section_Data, Comparison_View_Overall_Rating]) then
  begin

    // UAD 209
    if (ExtensionSectionOrganizationName) and (ComparableSale_PropertySequenceIdentifier <> 0) then   // check if correct XPath
      if not CheckEnum(GSEViewOverallRatingType, GetAttributeValue(oAttributes, 'GSEViewOverallRatingType', CommonBool, CurrentValue)) then
      begin
        AddLogEntry(Log, '87', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_View_Overall_Rating_Extension, Comparison_View_Overall_Rating_Extension_Section, Comparison_View_Overall_Rating_Extension_Section_Data, Comparison_View_Overall_Rating]), CurrentValue, '209');
        Result := Result + 1;
      end
      else
        AddLogEntry(Log, '87', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_View_Overall_Rating_Extension, Comparison_View_Overall_Rating_Extension_Section, Comparison_View_Overall_Rating_Extension_Section_Data, Comparison_View_Overall_Rating]), CurrentValue, '209');


  end;

{ }


{  '$$$REPETITION$$$ [VALUATION_METHODS/SALES_COMPARISON..COMPARISON_VIEW_DETAIL] -> GSEViewType, GSEViewTypeOtherDescription (sales comparison)'}
  if XPath.CommaText =  CreateCommaText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_View_Detail_Extension, Comparison_View_Detail_Extension_Section, Comparison_View_Detail_Extension_Section_Data, Comparison_View_Detail]) then
  begin

    if (ExtensionSectionOrganizationName) and (ComparableSale_PropertySequenceIdentifier <> 0) then   // check if correct XPath
    begin

      // UAD 211
      CommonStr := GetAttributeValue(oAttributes, 'GSEViewType', CommonBool, CurrentValue);

      if not CheckEnum(GSEViewType, CommonStr) then
      begin
        AddLogEntry(Log, '88', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, LogicError1, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_View_Detail_Extension, Comparison_View_Detail_Extension_Section, Comparison_View_Detail_Extension_Section_Data, Comparison_View_Detail]), CurrentValue, '221');

        AddLogEntry(Log, '89', [FormField, DataPointString, '', ErrorMessage, ''], 1);
        Result := Result + 1;

      end
      else
      begin

        nGSEViewType := nGSEViewType + 1;

        if nGSEViewType >= 3  then
        begin
          AddLogEntry(Log, '88', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, LogicError2, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_View_Detail_Extension, Comparison_View_Detail_Extension_Section, Comparison_View_Detail_Extension_Section_Data, Comparison_View_Detail]), CurrentValue, '221');
          Result := Result + 1;
        end
          else
            AddLogEntry(Log, '88', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_View_Detail_Extension, Comparison_View_Detail_Extension_Section, Comparison_View_Detail_Extension_Section_Data, Comparison_View_Detail]), CurrentValue, '221');




        // UAD 214
        if (CommonStr = 'Other') then
        begin


          if GetAttributeValue(oAttributes, 'GSEViewTypeOtherDescription', CommonBool, CurrentValue) = '' then
          begin
            AddLogEntry(Log, '89', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_View_Detail_Extension, Comparison_View_Detail_Extension_Section, Comparison_View_Detail_Extension_Section_Data, Comparison_View_Detail]), CurrentValue, '214');
            Result := Result + 1;
          end
          else
            AddLogEntry(Log, '89', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_View_Detail_Extension, Comparison_View_Detail_Extension_Section, Comparison_View_Detail_Extension_Section_Data, Comparison_View_Detail]), CurrentValue, '214');

        end;

   
      end;


    end;


  end;

{  '[VALUATION_RESPONSE/VALUATION_METHODS/SALES_COMPARISON/COMPARABLE_SALE/OTHER_FEATURE_ADJUSTMENT] -> PropertyFeatureAdjustmentAmount'}
  if XPath.CommaText =  CreateCommaText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Other_Feature_Adjustment])then
  begin
    if XPathSchema.IndexOfName(XPath.CommaText) <> - 1 then XPathSchema.Delete(XPathSchema.IndexOfName(XPath.CommaText));

    // UAD 261
    if GetAttributeValue(oAttributes, 'PropertyFeatureSequenceIdentifier', CommonBool, CommonStr) <> '' then
    begin

      CommonStr := GetAttributeValue(oAttributes, 'PropertyFeatureSequenceIdentifier', CommonBool, CurrentValue);

      if (not ValidateNumber(GetAttributeValue(oAttributes, 'PropertyFeatureAdjustmentAmount', CommonBool, CurrentValue), 0, CommonFloat, True)) and (CommonBool)  then
      begin
        AddLogEntry(Log, '121', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Other Feature Adjustment[' + CommonStr + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, OTher_Feature_Adjustment]), CurrentValue, '261');
        Result := Result + 1;
      end
      else
      begin
        AddLogEntry(Log, '121', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + '] Other Feature Adjustment[' + CommonStr + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, OTher_Feature_Adjustment]), CurrentValue, '261');

        if ((_FormType = 'FNM1004') or (_FormType = 'FNM2055')) and (CommonFloat <> InvalidInt) then
          TotalSalePriceAdjustmentAmount := TotalSalePriceAdjustmentAmount + Round(CommonFloat);


      end;

    end;



  end;

{ }


{  '[VALUATION_METHODS/SALES_COMPARISON/RESEARCH/SUBJECT] -> _HasPriorSalesIndicator (Subject)'}
  if XPath.CommaText =  CreateCommaText([Valuation_Response, Valuation_Methods, Sales_Comparison, Research, Subject]) then
  begin

    if XPathSchema.IndexOfName(XPath.CommaText) <> - 1 then XPathSchema.Delete(XPathSchema.IndexOfName(XPath.CommaText));
    if (_FormType = 'FNM1004') or (_FormType = 'FNM2055') then
    begin

      // UAD 265
      CommonStr := GetAttributeValue(oAttributes, '_HasPriorSalesIndicator', CommonBool, CurrentValue);

      if not CheckEnum(YesNo, CommonStr) then      // constant reused
      begin
        AddLogEntry(Log, '123', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Research, Subject]), CurrentValue, '265');
        AddLogEntry(Log, '125', [FormField, DataPointString, '', ErrorUndetermined, ''], 1);
        AddLogEntry(Log, '126', [FormField, DataPointString, '', ErrorUndetermined, ''], 1);

        Result := Result + 1;
      end
      else
      begin
        AddLogEntry(Log, '123', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Research, Subject]), CurrentValue, '265');
        SubjectPriorSaleIndicator := CommonStr[1];
      end;

      Exit;
    end;

  end;

{ }


{  '[VALUATION_METHODS/SALES_COMPARISON/RESEARCH/COMPARABLE] -> _HasPriorSalesIndicator (Comparable)'}
  if XPath.CommaText =  CreateCommaText([Valuation_Response, Valuation_Methods, Sales_Comparison, Research, Comparable]) then
  begin

    if XPathSchema.IndexOfName(XPath.CommaText) <> - 1 then XPathSchema.Delete(XPathSchema.IndexOfName(XPath.CommaText));

//    if (_FormType = 'FNM1004') or (_FormType = 'FNM2055') then
    if (_FormType = 'FNM1004') or (_FormType = 'FNM2055') or (_FormType = 'FNM1073') or (_FormType = 'FNM1075') then
    begin

      // UAD 268
      CommonStr := GetAttributeValue(oAttributes, '_HasPriorSalesIndicator', CommonBool, CurrentValue);

      if not CheckEnum(YesNo, CommonStr) then      // constant reused
      begin
        AddLogEntry(Log, '124', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Research, Comparable]), CurrentValue, '268');

        Result := Result + 1;
      end
      else
      begin
        AddLogEntry(Log, '124', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Research, Comparable]), CurrentValue, '268');
        ComparablePriorSaleIndicator := CommonStr[1];
      end;


      Exit;
    end;
  end;

{ }


{  '[VALUATION_METHODS/SALES_COMPARISON/COMPARABLE_SALE/PRIOR_SALES ... PRIOR_SALE] -> GSEPriorSaleDate'}

  if XPath.CommaText =  CreateCommaText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Prior_Sales, Prior_Sales_Extension, Prior_Sales_Extension_Section, Prior_Sales_Extension_Section_Data, Prior_Sale]) then
  begin
    if XPathSchema.IndexOfName(XPath.CommaText) <> - 1 then XPathSchema.Delete(XPathSchema.IndexOfName(XPath.CommaText));

    if (ComparableSale_PropertySequenceIdentifier = 0) and (ExtensionSectionOrganizationName) then
    begin

      // UAD 271
      if (_FormType = 'FNM1004') or (_FormType = 'FNM2055') then
        if SubjectPriorSaleIndicator = 'Y' then
          if not ValidateDate(GetAttributeValue(oAttributes, 'GSEPriorSaleDate', CommonBool, CurrentValue)) then
          begin
            AddLogEntry(Log, '125', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Prior_Sales, Prior_Sales_Extension, Prior_Sales_Extension_Section, Prior_Sales_Extension_Section_Data, Prior_Sale]), CurrentValue, '271');
            Result := Result + 1;
          end
          else
            AddLogEntry(Log, '125', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Prior_Sales, Prior_Sales_Extension, Prior_Sales_Extension_Section, Prior_Sales_Extension_Section_Data, Prior_Sale]), CurrentValue, '271');

     end;


     if ComparableSale_PropertySequenceIdentifier <> 0 then      // other sales
     begin

       if (_FormType = 'FNM1004') or (_FormType = 'FNM2055') then
       begin

        // UAD 278
        CommonStr := GetAttributeValue(oAttributes, 'GSEPriorSaleDate', CommonBool, CurrentValue);

        if CommonBool then
        begin
         if not ValidateDate(CommonStr) then
          begin
            AddLogEntry(Log, '129', [FormField, DataPointString + '% - ComparableSale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, LogicError2, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Prior_Sales, Prior_Sales_Extension, Prior_Sales_Extension_Section, Prior_Sales_Extension_Section_Data, Prior_Sale]), CurrentValue, '278');
            Result := Result + 1;
          end
          else
            AddLogEntry(Log, '129', [FormField, DataPointString + '% - ComparableSale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Prior_Sales, Prior_Sales_Extension, Prior_Sales_Extension_Section, Prior_Sales_Extension_Section_Data, Prior_Sale]), CurrentValue, '278');

          nGSEPriorSaleAttribPresent := nGSEPriorSaleAttribPresent + 1;

        end;

       end;

  // UAD 278

      //Handle prior sale date and sales price for form 1073 and 1075
      if ComparablePriorSaleIndicator = 'Y' then
      begin
         if (_FormType = 'FNM1073') or (_FormType = 'FNM1075') then
         begin
          CommonStr := GetAttributeValue(oAttributes, 'GSEPriorSaleDate', CommonBool, CurrentValue);
          if CommonBool then
             if not ValidateDate(CommonStr) then
                if nGSEPriorSaleAttribPresent = 0 then
                begin
                  AddLogEntry(Log, '129', [FormField, DataPointString + '% - ComparableSale[Multiple]', ErrorCode, LogicError1, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Prior_Sales, Prior_Sales_Extension, Prior_Sales_Extension_Section, Prior_Sales_Extension_Section_Data, Prior_Sale]), '[Multiple Attributes]');
                  Result := Result + 1;
                end
                else
                  AddLogEntry(Log, '129', [FormField, DataPointString + '% - ComparableSale[Multiple]', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Prior_Sales, Prior_Sales_Extension, Prior_Sales_Extension_Section, Prior_Sales_Extension_Section_Data, Prior_Sale]), '[Multiple Attributes]');
                nGSEPriorSaleAttribPresent := nGSEPriorSaleAttribPresent + 1;
          end;
          CommonStr := GetAttributeValue(oAttributes, 'PropertySalesAmount', CommonBool, CurrentValue);
          if CommonBool then
            begin
              if not ValidateNumber(CommonStr, 0, CommonFloat, True) then
              begin
                if nPropertySaleAttribPresent = 0 then
                begin
                  AddLogEntry(Log, '130', [FormField, DataPointString  + '% - ComparableSale[Multiple]', ErrorCode, LogicError1, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Prior_Sales]), '[Multiple Attributes]');
                  Result := Result + 1;
                end
                else
                  AddLogEntry(Log, '130', [FormField, DataPointString  + '% - ComparableSale[Multiple]', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Prior_Sales]), '[Multiple Attributes]');
              end;
              nGSEPriorSaleAttribPresent := nGSEPriorSaleAttribPresent + 1;
            end;
       end;


     end;

    Exit;
  end;


{ }


{  '[VALUATION_METHODS/SALES_COMPARISON/COMPARABLE_SALE/PRIOR_SALES] -> PropertySalesAmount'}

  if XPath.CommaText =  CreateCommaText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Prior_Sales]) then
  begin
    if XPathSchema.IndexOfName(XPath.CommaText) <> - 1 then XPathSchema.Delete(XPathSchema.IndexOfName(XPath.CommaText));

    if not ((_FormType = 'FNM1004') or (_FormType = 'FNM2055')) then
      Exit;


    if ComparableSale_PropertySequenceIdentifier = 0 then
    begin

      // UAD 273
      if SubjectPriorSaleIndicator = 'Y' then
        if not ValidateNumber(GetAttributeValue(oAttributes, 'PropertySalesAmount', CommonBool, CurrentValue), 0, CommonFloat, True) then
         begin
           AddLogEntry(Log, '126', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Prior_Sales]), CurrentValue, '273');
           Result := Result + 1;
         end
         else
           AddLogEntry(Log, '126', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Prior_Sales]), CurrentValue, '273');


      // UAD 275
      if GetAttributeValue(oAttributes, 'DataSourceDescription', CommonBool, CurrentValue) = '' then
       begin
         AddLogEntry(Log, '127', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0,CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Prior_Sales]), CurrentValue, '275');
         Result := Result + 1;
       end
       else
         AddLogEntry(Log, '127', [FormField, DataPointString, ErrorCode, '', Suggestion], 2,CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Prior_Sales]), CurrentValue, '275');



      // UAD 276
      if not ValidateDate(GetAttributeValue(oAttributes, 'DataSourceEffectiveDate', CommonBool, CurrentValue)) then
      begin
        AddLogEntry(Log, '128', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Prior_Sales]), CurrentValue, '276');
        Result := Result + 1;
      end
      else
        AddLogEntry(Log, '128', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Prior_Sales]), CurrentValue, '276');



    end
    else
    begin                   // other sale


      // UAD 280
      CommonStr := GetAttributeValue(oAttributes, 'PropertySalesAmount', CommonBool, CurrentValue);
      if CommonBool then
      begin

        if not ValidateNumber(CommonStr, 0, CommonFloat, True) then
        begin
          AddLogEntry(Log, '130', [FormField, DataPointString  + '% - ComparableSale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, LogicError2, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Prior_Sales]), CurrentValue, '280');
          Result := Result + 1;
        end
        else
          AddLogEntry(Log, '130', [FormField, DataPointString  + '% - ComparableSale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Prior_Sales]), CurrentValue, '280');

        nPropertySaleAttribPresent := nPropertySaleAttribPresent + 1;

      end;


      // UAD 282
      if GetAttributeValue(oAttributes, 'DataSourceDescription', CommonBool, CurrentValue) = '' then
      begin
        AddLogEntry(Log, '131', [FormField, DataPointString  + '% - ComparableSale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Prior_Sales]), CurrentValue, '282');
        Result := Result + 1;
      end
      else
        AddLogEntry(Log, '131', [FormField, DataPointString  + '% - ComparableSale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Prior_Sales]), CurrentValue, '282');



      // UAD 283
      if not ValidateDate(GetAttributeValue(oAttributes, 'DataSourceEffectiveDate', CommonBool, CurrentValue)) then
      begin
        AddLogEntry(Log, '132', [FormField, DataPointString  + '% - ComparableSale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Prior_Sales]), CurrentValue, '283');
        Result := Result + 1;
      end
      else
        AddLogEntry(Log, '132', [FormField, DataPointString  + '% - ComparableSale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Prior_Sales]), CurrentValue, '283');

    end;




    Exit;
  end;


{ }


{  '[VALUATION_METHODS/SALES_COMPARISON] -> ValueIndicatedBySalesComparisonApproachAmount'}

  if XPath.CommaText =  CreateCommaText([Valuation_Response, Valuation_Methods, Sales_Comparison]) then
  begin
    if XPathSchema.IndexOfName(XPath.CommaText) <> - 1 then XPathSchema.Delete(XPathSchema.IndexOfName(XPath.CommaText));
    // UAD 285
    if not ValidateNumber(GetAttributeValue(oAttributes, 'ValueIndicatedBySalesComparisonApproachAmount', CommonBool, CurrentValue), 0, CommonFloat, True) then
    begin
      AddLogEntry(Log, '133', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison]), CurrentValue, '285');
      Result := Result + 1;
    end
    else
      AddLogEntry(Log, '133', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison]), CurrentValue, '285');

  end;

{ }




// RECONCILLIATION

{  '[VALUATION_METHODS/VALUATION/_RECONCILIATION/_CONDITION_OF_APPRAISAL] -> _Type'}

  if XPath.CommaText =   CreateCommaText([Valuation_Response, Valuation, _Reconciliation, _Condition_Of_Appraisal]) then
  begin
     if XPathSchema.IndexOfName(XPath.CommaText) <> - 1 then XPathSchema.Delete(XPathSchema.IndexOfName(XPath.CommaText));
    // UAD 290
    if not CheckEnum(_Type, GetAttributeValue(oAttributes, '_Type', CommonBool, CurrentValue)) then
    begin
      AddLogEntry(Log, '134', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation, _Reconciliation, _Condition_Of_Appraisal]), CurrentValue, '290');
      Result := Result + 1;
    end
    else
      AddLogEntry(Log, '134', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation, _Reconciliation, _Condition_Of_Appraisal]), CurrentValue, '290');

  end;

{ }


{  '[VALUATION_RESPONSE/VALUATION] -> PropertyAppraisedValueAmount, AppraisalEffectiveDate'}

  if XPath.CommaText =   CreateCommaText([Valuation_Response, Valuation]) then
  begin
    if XPathSchema.IndexOfName(XPath.CommaText) <> - 1 then XPathSchema.Delete(XPathSchema.IndexOfName(XPath.CommaText));
    // UAD 293
    if not ValidateNumber(GetAttributeValue(oAttributes, 'PropertyAppraisedValueAmount', CommonBool, CurrentValue), 0, CommonFloat, True) then
    begin
      AddLogEntry(Log, '135', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation]), CurrentValue, '293');
      Result := Result + 1;
    end
    else
      AddLogEntry(Log, '135', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation]), CurrentValue, '293');


    // UAD 295
    if not ValidateDate(GetAttributeValue(oAttributes, 'AppraisalEffectiveDate', CommonBool, CurrentValue)) then
    begin
      AddLogEntry(Log, '136', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation]), CurrentValue, '295');
      Result := Result + 1;
    end
    else
      AddLogEntry(Log, '136', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation]), CurrentValue, '295');

    Exit;
  end;

{ }




//PUD INFORMATION    (Explores XML ProjectInformation section)

{  '&&&REPETITION&&&[VALUATION_RESPONSE/PROPERTY/PROJECT] -> _Type'}

  if XPath.CommaText =   CreateCommaText([Valuation_Response, _Property, Project]) then
  begin

    if (_FormType = 'FNM1004') or (_FormType = 'FNM2055') then
    begin

      // UAD 297
      if not CheckEnum(YesNo, _GSE_PUDIndicator) then
        AddLogEntry(Log, '137', [FormField, DataPointString, '', ErrorUndetermined, ''], 1)
      else
        if (_GSE_PUDIndicator = 'Y') and (not CheckEnum(YesNo, GetAttributeValue(oAttributes, '_DeveloperControlsProjectManagementIndicator', CommonBool, CurrentValue))) then
        begin
          AddLogEntry(Log, '137', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, _Property, Project]), CurrentValue, '297');
          Result := Result + 1;
        end
        else
          AddLogEntry(Log, '137', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, _Property, Project]), CurrentValue, '297');
    end;

  end;

{ }




//CERTIFICATION

{  '[VALUATION_RESPONSE/PARTIES/APPRAISER/APPRAISER_LICENSE] -> _TypeOtherDescription'}

  if XPath.CommaText =   CreateCommaText([Valuation_Response, Parties, Appraiser, Appraiser_License]) then
  begin

    if XPathSchema.IndexOfName(XPath.CommaText) <> - 1 then XPathSchema.Delete(XPathSchema.IndexOfName(XPath.CommaText));


    // UAD 303

    Param1 := GetAttributeValue(oAttributes, '_Type', CommonBool1, CurrentValue);
    CommonStr := GetAttributeValue(oAttributes, '_TypeOtherDescription', CommonBool, CurrentValue);
    GetAttributeValue(oAttributes, '_Identifier', CommonBool, CurrentValue);


    if (not CommonBool) and (CommonStr <> 'trainee') then
    begin
      AddLogEntry(Log, '138', [FormField, DataPointString, ErrorCode, LogicError1, Suggestion], 0, CreatePathText([Valuation_Response, Parties, Appraiser, Appraiser_License]), CurrentValue, '303');
      Result := Result + 1;
    end
    else
      if (Param1 = 'Other') and (CommonStr = '') then
      begin
        AddLogEntry(Log, '138', [FormField, DataPointString, ErrorCode, LogicError2, Suggestion], 0, CreatePathText([Valuation_Response, Parties, Appraiser, Appraiser_License]), CurrentValue, '303');
        Result := Result + 1;
      end
      else
        AddLogEntry(Log, '138', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Parties, Appraiser, Appraiser_License]), CurrentValue, '303');



    // UAD 305
    if (CommonBool) and (not ValidateDate(GetAttributeValue(oAttributes, '_ExpirationDate', CommonBool1, CurrentValue))) then
    begin
      AddLogEntry(Log, '139', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Parties, Appraiser, Appraiser_License]), CurrentValue, '305');
      Result := Result + 1;
    end
    else
      AddLogEntry(Log, '139', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Parties, Appraiser, Appraiser_License]), CurrentValue, '305');


  end;

{ }


{  '[VALUATION_RESPONSE/PARTIES/SUPERVISOR/APPRAISER_LICENSE] -> Supervisor'}

  if XPath.CommaText =   CreateCommaText([Valuation_Response, Parties, Supervisor, Appraiser_License]) then
  begin

    if XPathSchema.IndexOfName(XPath.CommaText) <> - 1 then XPathSchema.Delete(XPathSchema.IndexOfName(XPath.CommaText));


    // UAD 322
    if (_SupervisorName <> InvalidValue) or (_SupervisorName = '') then
    begin
      GetAttributeValue(oAttributes, '_Identifier', CommonBool, CurrentValue);

      if not CommonBool then
      begin
        AddLogEntry(Log, '156', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Parties, Supervisor, Appraiser_License]), CurrentValue, '322');
        Result := Result + 1;
      end
      else
        AddLogEntry(Log, '156', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Parties, Supervisor, Appraiser_License]), CurrentValue, '322');

    end;



    // UAD 324
    CommonStr := GetAttributeValue(oAttributes, '_ExpirationDate', CommonBool, CurrentValue);
    GetAttributeValue(oAttributes, '_Identifier', CommonBool,CurrentValue);

    if CommonStr = '' then
      if CommonBool then
        AddLogEntry(Log, '157', [FormField, DataPointString, ErrorCode, LogicError1, Suggestion], 0, CreatePathText([Valuation_Response, Parties, Supervisor, Appraiser_License]), CurrentValue, '324')
      else
        AddLogEntry(Log, '157', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Parties, Supervisor, Appraiser_License]), CurrentValue, '324')

    else
      if not CommonBool then
        AddLogEntry(Log, '157', [FormField, DataPointString, ErrorCode, LogicError1, Suggestion], 0, CreatePathText([Valuation_Response, Parties, Supervisor, Appraiser_License]), CurrentValue, '324')
      else
        if not ValidateDate(CommonStr) then
          AddLogEntry(Log, '157', [FormField, DataPointString, ErrorCode, LogicError2, Suggestion], 0, CreatePathText([Valuation_Response, Parties, Supervisor, Appraiser_License]), CurrentValue, '324')
        else
          AddLogEntry(Log, '157', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Parties, Supervisor, Appraiser_License]), CurrentValue, '324');

  end;

{ }


{  '[VALUATION_RESPONSE/PARTIES/MANAGEMENT_COMPANY_EXTENSION... MANAGEMENT_COMPANY] ->GSEManagementCompanyName'}

  if XPath.CommaText = CreateCommaText([Valuation_Response, Parties, Management_Company_Extension, Management_Company_Extension_Section, Management_Company_Extension_Section_Data, Management_Company]) then
  begin
     if XPathSchema.IndexOfName(XPath.CommaText) <> - 1 then XPathSchema.Delete(XPathSchema.IndexOfName(XPath.CommaText));
    // UAD 321
    if GetAttributeValue(oAttributes, 'GSEManagementCompanyName', CommonBool, CurrentValue) = '' then
    begin
      AddLogEntry(Log, '140', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Parties, Management_Company_Extension, Management_Company_Extension_Section, Management_Company_Extension_Section_Data, Management_Company]), CurrentValue, '321');
      Result := Result + 1;
    end
    else
      AddLogEntry(Log, '140', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Parties, Management_Company_Extension, Management_Company_Extension_Section, Management_Company_Extension_Section_Data, Management_Company]), CurrentValue, '321');

  end;

{ }



//SALES COMPARISON APPROACH [PART 2]  / PRIOR SALE HISTORY     (indicated in yello in UAD Rules documentation)

if (_FormType = 'FNM1073') or (_FormType = 'FNM1075') then
begin



{  '[VALUATION_RESPONSE/PROPERTY/STRUCTURE/_UNIT] ->UnitIdentifier, LevelCount'}

  if XPath.CommaText =   CreateCommaText([Valuation_Response, _Property, Structure, _Unit]) then
  begin
     if XPathSchema.IndexOfName(XPath.CommaText) <> - 1 then XPathSchema.Delete(XPathSchema.IndexOfName(XPath.CommaText));
    // UAD 308
    if GetAttributeValue(oAttributes, 'UnitIdentifier', CommonBool, CurrentValue) = '' then
    begin
      AddLogEntry(Log, '142', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, _Property, Structure, _Unit]), CurrentValue, '308');
      Result := Result + 1;
    end
    else
      AddLogEntry(Log, '142', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, _Property, Structure, _Unit]), CurrentValue, '308');


    // UAD 329
    if (not ValidateNumber(GetAttributeValue(oAttributes, 'LevelCount', CommonBool, CurrentValue), 0, CommonFloat, True)) or (CommonFloat > 99) then     // constant reuse allowed
    begin
      AddLogEntry(Log, '143', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, _Property, Structure, _Unit]), CurrentValue, '329');
      Result := Result + 1;
    end
    else
      AddLogEntry(Log, '143', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, _Property, Structure, _Unit]), CurrentValue, '329');

  end;

{ }


{  '!!REPETITION!! [VALUATION_RESPONSE/VALUATION_METHODS/SALES_COMPARION/COMPARABLE_SALE/LOCATION] ->UnitIdentifier'}
{
  if XPath.CommaText =  CreateCommaText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Location]) then
  begin

    // UAD  327
    if ComparableSale_PropertySequenceIdentifier <> 0 then
      if GetAttributeValue(oAttributes, 'UnitIdentifier', CommonBool, CurrentValue) = '' then
      begin
        AddLogEntry(Log, '142', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Location]), CurrentValue, '327');
        Result := Result + 1;
      end
      else
        AddLogEntry(Log, '142', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Location]), CurrentValue, '327');

  end;
 }
{ }


{  '&&&REPETITION&&&[VALUATION_RESPONSE/PROPERTY/PROJECT] ->_CommercialSpaceIndicator'}

  if XPath.CommaText =   CreateCommaText([Valuation_Response, _Property, Project]) then
  begin

    // UAD 331
    _CommercialSpaceIndicator := InvalidValue;
    CommonStr := GetAttributeValue(oAttributes, '_CommercialSpaceIndicator', CommonBool, CurrentValue);

    if not CheckEnum(YesNo, CommonStr) then
    begin
      AddLogEntry(Log, '144', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, _Property, Project]), CurrentValue, '331');
      Result := Result + 1;
    end
    else
    begin
      AddLogEntry(Log, '144', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, _Property, Project]), CurrentValue, '331');
      _CommercialSpaceIndicator := CommonStr;
    end;


    // UAD 336
    if not CheckEnum(YesNo, GetAttributeValue(oAttributes, '_DeveloperControlsProjectManagementIndicator', CommonBool, CurrentValue)) then
    begin
      AddLogEntry(Log, '146', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, _Property, Project]), CurrentValue, '336');
      Result := Result + 1;
    end
    else
      AddLogEntry(Log, '146', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, _Property, Project]), CurrentValue, '336');



    Exit;
  end;

{ }


{  '[VALUATION_RESPONSE/PROPERTY/PROJECT/PROJECT_EXTENSION/PROJECT_EXTENSION_SECTION/PROJECT_EXTENSION_SECTION_DATA/PROJECT_COMMERCIAL] ->GSEProjectCommercialSpacePercent'}

  if XPath.CommaText = CreateCommaText([Valuation_Response, _Property, Project, Project_Extension, Project_Extension_Section, Project_Extension_Section_Data, Project_Commercial]) then
  begin
     if XPathSchema.IndexOfName(XPath.CommaText) <> - 1 then XPathSchema.Delete(XPathSchema.IndexOfName(XPath.CommaText));

     // UAD 334
     if ExtensionSectionOrganizationName then
      if _CommercialSpaceIndicator <> InvalidValue then
      begin
        if _CommercialSpaceIndicator = 'Y' then
        begin

          if (not ValidateNumber(GetAttributeValue(oAttributes, 'GSEProjectCommercialSpacePercent', CommonBool, CurrentValue), 0, CommonFloat, True)) or (CommonFloat > 100) then
          begin
            AddLogEntry(Log, '145', [FormField, DataPointString, ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, _Property, Project, Project_Extension, Project_Extension_Section, Project_Extension_Section_Data, Project_Commercial]), CurrentValue, '344');
            Result := Result + 1;
          end
          else
            AddLogEntry(Log, '145', [FormField, DataPointString, ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, _Property, Project, Project_Extension, Project_Extension_Section, Project_Extension_Section_Data, Project_Commercial]), CurrentValue, '334');

        end;
      end
      else
        AddLogEntry(Log, '145', [FormField, DataPointString, '', ErrorUndetermined, ''], 1);



    Exit;
  end;

{ }


{  '@@@REPETITION@@@[VALUATION_RESPONSE/VALUATION_METHODS/SALES_COMPARISON/COMPARABLE_SALE] -> ProjectName'}
  if XPath.CommaText =  CreateCommaText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale])then
  begin

    // UAD 341
    if GetAttributeValue(oAttributes, 'PropertySequenceIdentifier', CommonBool, CommonStr) <> '0' then
      if GetAttributeValue(oAttributes, 'ProjectName', CommonBool, CurrentValue) = '' then
      begin
        AddLogEntry(Log, '148', [FormField, DataPointString + '%  - Comparable Sale[' + CommonStr + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale]), CurrentValue, '341');
        Result := Result + 1;
      end
      else
        AddLogEntry(Log, '148', [FormField, DataPointString + '%  - Comparable Sale[' + CommonStr + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale]), CurrentValue, '341');

  end;
{ }


{  '---REPETITION---[VALUATION_RESPONSE/VALUATION_METHODS/SALES_COMPARISON/COMPARABLE_SALE/SALE_PRICE_ADJUSTMENT] -> _Description, _Amount (MonthlyFacilityFee, CommonElements, RecreatioFacilities, FloorLocation)'}
  if XPath.CommaText =  CreateCommaText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment])then
  begin



    if ComparableSale_PropertySequenceIdentifier <> 0 then
    begin

       // UAD 344
      if GetAttributeValue(oAttributes, '_Type', CommonBool, CurrentValue) = 'MonthlyFacilityFee' then
        if (not (ValidateNumber(GetAttributeValue(oAttributes, '_Amount', CommonBool, CurrentValue), 0, CommonFloat, True))) and (CommonBool) then
        begin
          AddLogEntry(Log, '150', [FormField, DataPointString + '%  - ComparableSale[' + InttoStr(ComparableSale_PropertySequenceIdentifier) + '] Sale Price Adjustment[' + InttoStr(nSalesAdjustment) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '344');
          Result := Result + 1;
        end
        else
          AddLogEntry(Log, '150', [FormField, DataPointString + '%  - ComparableSale[' + InttoStr(ComparableSale_PropertySequenceIdentifier) + '] Sale Price Adjustment[' + InttoStr(nSalesAdjustment) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '344');




      // UAD 345
      if GetAttributeValue(oAttributes, '_Type', CommonBool, CurrentValue) = 'CommonElements' then
        if (not ValidateNumber(GetAttributeValue(oAttributes, '_Amount', CommonBool, CurrentValue), 0, CommonFloat, True)) and (CommonBool) then
        begin
          AddLogEntry(Log, '151', [FormField, DataPointString + '%  - ComparableSale[' + InttoStr(ComparableSale_PropertySequenceIdentifier) + '] Sale Price Adjustment[' + InttoStr(nSalesAdjustment) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '345');
          Result := Result + 1;
        end
        else
          AddLogEntry(Log, '151', [FormField, DataPointString + '%  - ComparableSale[' + InttoStr(ComparableSale_PropertySequenceIdentifier) + '] Sale Price Adjustment[' + InttoStr(nSalesAdjustment) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '345');


      //  UAD 346
      if GetAttributeValue(oAttributes, '_Type', CommonBool, CurrentValue) = 'RecreationFacilities' then
        if (not ValidateNumber(GetAttributeValue(oAttributes, '_Amount', CommonBool, CurrentValue), 0, CommonFloat, True)) and (CommonBool) then
        begin
          AddLogEntry(Log, '152', [FormField, DataPointString + '%  - ComparableSale[' + InttoStr(ComparableSale_PropertySequenceIdentifier) + '] Sale Price Adjustment[' + InttoStr(nSalesAdjustment) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '346');
          Result := Result + 1;
        end
        else
          AddLogEntry(Log, '152', [FormField, DataPointString + '%  - ComparableSale[' + InttoStr(ComparableSale_PropertySequenceIdentifier) + '] Sale Price Adjustment[' + InttoStr(nSalesAdjustment) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '346');


       //  UAD 347
      if GetAttributeValue(oAttributes, '_Type', CommonBool, CurrentValue) = 'FloorLocation' then
        if (not ValidateNumber(GetAttributeValue(oAttributes, '_Amount', CommonBool, CurrentValue), 0, CommonFloat, True)) and (CommonBool) then
        begin
          AddLogEntry(Log, '153', [FormField, DataPointString + '%  - ComparableSale[' + InttoStr(ComparableSale_PropertySequenceIdentifier) + '] Sale Price Adjustment[' + InttoStr(nSalesAdjustment) + ']', ErrorCode, ErrorMessage, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '347');
          Result := Result + 1;
        end
        else
          AddLogEntry(Log, '153', [FormField, DataPointString + '%  - ComparableSale[' + InttoStr(ComparableSale_PropertySequenceIdentifier) + '] Sale Price Adjustment[' + InttoStr(nSalesAdjustment) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '347')


    end
    else
    begin
      if GetAttributeValue(oAttributes, '_Type', CommonBool, CurrentValue) = 'MonthlyFacilityFee' then
      begin


        // UAD 342
        if (_HOAType = InvalidValue) or (_HOAAmount = InvalidValue) then
          AddLogEntry(Log, '149', [FormField, DataPointString, '', ErrorUndetermined, ''], 1)
        else
        begin

          CommonStr := GetAttributeValue(oAttributes, '_Description', CommonBool, CurrentValue);

          if (not (ValidateNumber(CommonStr, 0, CommonFloat, True))) and (CommonBool) then
          begin
            AddLogEntry(Log, '149', [FormField, DataPointString + '% Comparable Sale[0] Sale Price Adjustment[' + InttoStr(nSalesAdjustment) + ']', ErrorCode, LogicError1, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '342');
            Result := Result + 1;
          end
          else
          begin

            if _HOAType = 'Annually' then
            begin
              try
                 CommonInt1 := StrtoInt(_HOAAmount) div 12;
              except
                on E:EConvertError do  CommonInt1 := InvalidInt;
              end;
            end
            else
            begin
              try
                CommonInt1 := StrtoInt(_HOAAmount);
              except
                on E:EConvertError do CommonInt1 := InvalidInt;
              end;
            end;
            try
              CommonInt := StrtoInt(CommonStr);
            except
              on E:EConvertError do CommonInt1 := InvalidInt;
            end;

            if (CommonInt1=InvalidInt) or (CommonInt1 <> CommonInt) and ((CommonInt1 <> CommonInt + 1) and (CommonInt1 <> CommonInt - 1)) then
            begin
              AddLogEntry(Log, '149', [FormField, DataPointString + '% Comparable Sale[0] Sale Price Adjustment[' + InttoStr(nSalesAdjustment) + ']', ErrorCode, LogicError2, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '342');
              Result := Result + 1;
            end
            else
              AddLogEntry(Log, '149', [FormField, DataPointString + '% Comparable Sale[0] Sale Price Adjustment[' + InttoStr(nSalesAdjustment) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment]), CurrentValue, '342');

          end;

        end;

      end;
    end;





   nSalesAdjustment := nSalesAdjustment + 1;



  end;

{ }


end;



//FOOTER
{  '[VALUATION_RESPONSE/VALUATION_METHODS/REPORT/FORM] -> AppraisalReportContentIdentifier'}
if XPath.CommaText = CreateCommaText([Valuation_Response, Report, _Form]) then
begin

  if XPathSchema.IndexOfName(XPath.CommaText) <> - 1 then XPathSchema.Delete(XPathSchema.IndexOfName(XPath.CommaText));
  // UAD 373
  CommonStr := GetAttributeValue(oAttributes, 'AppraisalReportContentSequenceIdentifier', CommonBool, CurrentValue);

  if IsGSEUADFormName(GetAttributeValue(oAttributes, 'AppraisalReportContentName', CommonBool, CurrentValue)) and
     (GetAttributeValue(oAttributes, 'AppraisalReportContentIdentifier', CommonBool, CurrentValue) <> UADVersion) then
    AddLogEntry(Log, '154', [FormField, DataPointString + '% [' + CommonStr + ']', ErrorCode, ErrorMessage, Suggestion], 1, CreatePathText([Valuation_Response, Report, _Form]), CurrentValue, '373')
  else
    AddLogEntry(Log, '154', [FormField, DataPointString + '% [' + CommonStr + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Report, _Form]), CurrentValue, '373')

end;


// ADJUSTMENT CHECKING BETWEEN SUBJECT AND COMPARABLES

{ '###REPETITION###[VALUATION_METHODS/SALES_COMPARISON] -> Create SubjectAdjustments Array'}

  if XPath.CommaText =  CreateCommaText([Valuation_Response, Valuation_Methods, Sales_Comparison]) then
  begin
    SetLength(SubjectAdjustments, 29);    //there are 29 adjustment names - see AdjustmentLabels

    for i := 0 to Length(SubjectAdjustments) - 1  do
    begin
      SubjectAdjustments[i].Description := TStringList.Create;
      SubjectAdjustments[i].Name := AdjustmentLabels[i];
    end;
  end;

{'@@@REPETITION@@@[VALUATION_RESPONSE/VALUATION_METHODS/SAES_COMPARISON/COMPARABLE_SALE] -> Create ComparableAdjustment Array'}
  if XPath.CommaText =  CreateCommaText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale]) then
  begin
    SetLength(ComparableAdjustments, 29);   //there are 29 adjustment names - see AdjustmentLabels

    for i := 0 to Length(ComparableAdjustments) - 1  do
    begin
      ComparableAdjustments[i].Description := TStringList.Create;
      ComparableAdjustments[i].Name := AdjustmentLabels[i];
    end;
  end;


{'^^^REPETITION^^^[VALUATION_METHODS/SALES_COMPARISON..COMPARISON_LOCATION_DETAIL] -> Location'}
  if XPath.CommaText =  CreateCommaText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Location_Detail_Extension, Comparison_Location_Detail_Extension_Section, Comparison_Location_Detail_Extension_Section_Data, Comparison_Location_Detail]) then
  begin

    if ComparableSale_PropertySequenceIdentifier = 0 then
      Adjustments := SubjectAdjustments
    else
      Adjustments := ComparableAdjustments;


    CommonStr := GetAttributeValue(oAttributes, 'GSELocationType', CommonBool, CurrentValue);

    if CommonStr <> '' then
      Adjustments[0].Description.Add(UpperCase(CommonStr));

    if CommonStr = 'Other' then
    begin
      Param1 := GetAttributeValue(oAttributes, 'GSELocationTypeOtherDescription', CommonBool, CurrentValue);

      if Param1 <> '' then
        Adjustments[0].Description.Add(UpperCase(Param1));
    end;

    Exit;
  end;

{'<<<REPETITION>>>[VALUATION_METHODS/SALES_COMPARISON..COMPARISON_LOCATION_OVERALL_RATING] -> Location'}
  if XPath.CommaText =  CreateCommaText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Location_Overall_Rating_Extension, Comparison_Location_Overall_Rating_Extension_Section, Comparison_Location_Overall_Rating_Extension_Section_Data, Comparison_Location_Overall_Rating]) then
  begin
    if ComparableSale_PropertySequenceIdentifier = 0 then
      Adjustments := SubjectAdjustments
    else
      Adjustments := ComparableAdjustments;

    Param1 := GetAttributeValue(oAttributes, 'GSEOverallLocationRatingType', CommonBool, CurrentValue);
    if Param1 <> '' then
      Adjustments[0].Description.Add(UpperCase(Param1));
  end;

{'$$$REPETITION$$$ [VALUATION_METHODS/SALES_COMPARISON..COMPARISON_VIEW_DETAIL] -> View'}
  if XPath.CommaText =  CreateCommaText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_View_Detail_Extension, Comparison_View_Detail_Extension_Section, Comparison_View_Detail_Extension_Section_Data, Comparison_View_Detail]) then
  begin
    if ComparableSale_PropertySequenceIdentifier = 0 then
      Adjustments := SubjectAdjustments
    else
      Adjustments := ComparableAdjustments;


    CommonStr := GetAttributeValue(oAttributes, 'GSEViewType', CommonBool, CurrentValue);

    if CommonStr <> '' then
      Adjustments[3].Description.Add(UpperCase(CommonStr));

    if CommonStr = 'Other' then
    begin
      Param1 := GetAttributeValue(oAttributes, 'GSEViewTypeOtherDescription', CommonBool, CurrentValue);

      if Param1 <> '' then
        Adjustments[3].Description.Add(UpperCase(Param1));
    end;

    Exit;
  end;

{'%%%REPETITION%%%[VALUATION_METHODS/SALES_COMPARISON..COMPARISON_VIEW_OVERALL_RATING] -> View'}
  if XPath.CommaText =  CreateCommaText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_View_Overall_Rating_Extension, Comparison_View_Overall_Rating_Extension_Section, Comparison_View_Overall_Rating_Extension_Section_Data, Comparison_View_Overall_Rating]) then
  begin
    if ComparableSale_PropertySequenceIdentifier = 0 then
      Adjustments := SubjectAdjustments
    else
      Adjustments := ComparableAdjustments;

    Param1 := GetAttributeValue(oAttributes, 'GSEViewOverallRatingType', CommonBool, CurrentValue);
    if Param1 <> '' then
      Adjustments[3].Description.Add(UpperCase(Param1));
  end;

{'**REPETITION** [VALUATION_METHODS/SALES_COMPARISON..COMPARISON_DETAIL] -> Quality of Construction, Actual Age, Condition}
  if XPath.CommaText =  CreateCommaText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section, Comparison_Detail_Extension_Section_Data, Comparison_Detail]) then
  begin
    if ComparableSale_PropertySequenceIdentifier = 0 then
      Adjustments := SubjectAdjustments
    else
      Adjustments := ComparableAdjustments;

    Param1 := GetAttributeValue(oAttributes, 'GSEQualityOfConstructionRatingType', CommonBool, CurrentValue);
    if Param1 <> '' then
      Adjustments[5].Description.Add(UpperCase(Param1));

    Param1 := GetAttributeValue(oAttributes, 'GSEAgeEstimationIndicator', CommonBool, CurrentValue);
    if Param1 <> '' then
      Adjustments[6].Description.Add(UpperCase(Param1));

    Param1 := GetAttributeValue(oAttributes, 'GSEOverallConditionType', CommonBool, CurrentValue);
    if Param1 <> '' then
      Adjustments[7].Description.Add(UpperCase(Param1));


    // Basement and Finished Rooms Below Grade

    Param1 := GetAttributeValue(oAttributes, 'GSEBelowGradeTotalSquareFeetNumber', CommonBool, CurrentValue);
    if Param1 <> '' then
      Adjustments[10].Description.Add(UpperCase(Param1) + ' SF');

    Param1 := GetAttributeValue(oAttributes, 'GSEBelowGradeFinishSquareFeetNumber', CommonBool, CurrentValue);
    if Param1 <> '' then
      Adjustments[10].Description.Add(UpperCase(Param1) + ' SF');

    Param1 := GetAttributeValue(oAttributes, 'GSEBelowGradeRecreationRoomCount', CommonBool, CurrentValue);
    if Param1 <> '' then
      Adjustments[11].Description.Add(UpperCase(Param1) + 'RR');

    Param1 := GetAttributeValue(oAttributes, 'GSEBelowGradeBedroomRoomCount', CommonBool, CurrentValue);
    if Param1 <> '' then
      Adjustments[11].Description.Add(UpperCase(Param1) + 'BR');

    Param1 := GetAttributeValue(oAttributes, 'GSEBelowGradeBathroomRoomCount', CommonBool, CurrentValue);
    if Param1 <> '' then
      Adjustments[11].Description.Add(UpperCase(Param1) + 'BA');

    Param1 := GetAttributeValue(oAttributes, 'GSEBasementExitType', CommonBool, CurrentValue);
    if Param1 <> '' then
      Adjustments[10].Description.Add(UpperCase(Param1));

    Param1 := GetAttributeValue(oAttributes, 'GSEBelowGradeOtherRoomCount', CommonBool, CurrentValue);
    if Param1 <> '' then
      Adjustments[11].Description.Add(UpperCase(Param1) + 'O');

  end;

{'```REPETITION```[VALUATION_RESPONSE/VALUATION_METHODS/SALES_COMPARISON/COMPARABLE_SALE/ROOM_ADJUSTMENT] -> Room Count'}
  if XPath.CommaText =  CreateCommaText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Room_Adjustment])then
  begin
    if ComparableSale_PropertySequenceIdentifier = 0 then
      Adjustments := SubjectAdjustments
    else
      Adjustments := ComparableAdjustments;
///Skip review of totalroomcount - appraisers do not use the adjustment cell above & to the right of the room count row
    Param1 := GetAttributeValue(oAttributes, 'TotalRoomCount', CommonBool, CurrentValue);
    if Param1 <> '' then
      Adjustments[8].Description.Add(UpperCase(Param1));

    (* suppose user do adjustment for total room: top adjustmnet field and bathrooms: bottom adjustment line
    Param1 := GetAttributeValue(oAttributes, 'TotalBedroomCount', CommonBool, CurrentValue);
    if Param1 <> '' then
      Adjustments[8].Description.Add(UpperCase(Param1));     *)

    Param1 := GetAttributeValue(oAttributes, 'TotalBathroomCount', CommonBool, CurrentValue);
    if Param1 <> '' then
      Adjustments[24].Description.Add(UpperCase(Param1));
  end;

{'[VALUATION_RESPONSE/VALUATION_METHODS/SALES_COMPARISON/COMPARABLE_SALE/SALE_PRICE_ADJUSTMENT] -> Subject Other Adjustments'}
{  if XPath.CommaText =  CreateCommaText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment])then
    begin
      if ComparableSale_PropertySequenceIdentifier = 0 then
        begin
          Adjustments := SubjectAdjustments;

          // detect the sequence identifier and decide the array element to strore the values
          GetAttributeValue(oAttributes, '_Type', CommonBool, CurrentValue);

          if CommonBool and (CurrentValue = 'Other') then
            begin
              Param1 := GetAttributeValue(oAttributes, '_Description', CommonBool, CurrentValue);
              if CommonBool then
                begin
                  Adjustments[17 + Subject_SalesPriceAdjustmentOther_Counter].Description.Add(UpperCase(Param1));
                  Subject_SalesPriceAdjustmentOther_Counter := Succ(Subject_SalesPriceAdjustmentOther_Counter);
                end;
            end;
        end;
    end;}


{'[VALUATION_RESPONSE/VALUATION_METHODS/SALES_COMPARISON/COMPARABLE_SALE/OTHER_FEATURE_ADJUSTMENT] -> Other Adjustments'}
  if XPath.CommaText =  CreateCommaText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Other_Feature_Adjustment])then
    begin
      if ComparableSale_PropertySequenceIdentifier > 0 then
        begin
          Adjustments := ComparableAdjustments;

          // detect the sequence identifier and decide the array element to strore the values
          GetAttributeValue(oAttributes, 'PropertyFeatureSequenceIdentifier', CommonBool, CurrentValue);

          if CommonBool then
            try
              CommonInt := StrtoInt(CurrentValue);
            except
              on E:Exception do CommonInt := InvalidInt;
            end;

          Param1 := GetAttributeValue(oAttributes, 'PropertyFeatureDescription', CommonBool, CurrentValue);
          Adjustments[16 + CommonInt].Description.Add(UpperCase(Param1));

          Adjustments[16 + CommonInt].Amount := GetAttributeValue(oAttributes, 'PropertyFeatureAdjustmentAmount', CommonBool, CurrentValue);
        end
      else
        begin
          Adjustments := SubjectAdjustments;

          // detect the sequence identifier and decide the array element to store the values
          GetAttributeValue(oAttributes, 'PropertyFeatureSequenceIdentifier', CommonBool, CurrentValue);

          if CommonBool then
            try
              CommonInt := StrtoInt(CurrentValue);
            except
              on E:Exception do CommonInt := InvalidInt;
            end;

          Param1 := GetAttributeValue(oAttributes, 'PropertyFeatureDescription', CommonBool, CurrentValue);
          Adjustments[16 + CommonInt].Description.Add(UpperCase(Param1));
        end;
    end;


{'---REPETITION---[VALUATION_RESPONSE/VALUATION_METHODS/SALES_COMPARISON/COMPARABLE_SALE/SALE_PRICE_ADJUSTMENT]'}
  if XPath.CommaText = CreateCommaText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Sale_Price_Adjustment])then
  begin
    if ComparableSale_PropertySequenceIdentifier = 0 then
      Adjustments := SubjectAdjustments
    else
      Adjustments := ComparableAdjustments;

   CommonStr := GetAttributeValue(oAttributes, '_Type', CommonBool, CurrentValue);

    if CommonStr = 'Location' then
      Adjustments[0].Amount := GetAttributeValue(oAttributes, '_Amount', CommonBool, CurrentValue);

   if CommonStr = 'PropertyRights' then
    begin

      Adjustments[1].Amount := GetAttributeValue(oAttributes, '_Amount', CommonBool, CurrentValue);

      Param1 := GetAttributeValue(oAttributes, '_Description', CommonBool, CurrentValue);
      if Param1 <> '' then
        Adjustments[1].Description.Add(UpperCase(Param1));
    end;

    if CommonStr = 'SiteArea' then
    begin
      Adjustments[2].Amount := GetAttributeValue(oAttributes, '_Amount', CommonBool, CurrentValue);

      Param1 := GetAttributeValue(oAttributes, '_Description', CommonBool, CurrentValue);
      if Param1 <> '' then
        Adjustments[2].Description.Add(UpperCase(Param1));
    end;

    if CommonStr = 'View' then
      Adjustments[3].Amount := GetAttributeValue(oAttributes, '_Amount', CommonBool, CurrentValue);

    if CommonStr = 'DesignStyle' then
    begin
      Adjustments[4].Amount := GetAttributeValue(oAttributes, '_Amount', CommonBool, CurrentValue);

      Param1 := GetAttributeValue(oAttributes, '_Description', CommonBool, CurrentValue);
      if Param1 <> '' then
        Adjustments[4].Description.Add(UpperCase(Param1));
    end;

    if CommonStr = 'Quality' then
      Adjustments[5].Amount := GetAttributeValue(oAttributes, '_Amount', CommonBool, CurrentValue);

    if CommonStr = 'Age' then
    begin
      Adjustments[6].Amount := GetAttributeValue(oAttributes, '_Amount', CommonBool, CurrentValue);

      Param1 := GetAttributeValue(oAttributes, '_Description', CommonBool, CurrentValue);
      if Param1 <> '' then
        Adjustments[6].Description.Add(UpperCase(Param1));
    end;

    if CommonStr = 'Condition' then
      Adjustments[7].Amount := GetAttributeValue(oAttributes, '_Amount', CommonBool, CurrentValue);

    if CommonStr = 'Other' then
      if GetAttributeValue(oAttributes, '_TypeOtherDescription', CommonBool, CurrentValue) = 'RoomAboveGradeLine1' then
        Adjustments[8].Amount := GetAttributeValue(oAttributes, '_Amount', CommonBool, CurrentValue)
      else
        if GetAttributeValue(oAttributes, '_TypeOtherDescription', CommonBool, CurrentValue) = 'RoomAboveGradeLine2' then
        Adjustments[24].Amount := GetAttributeValue(oAttributes, '_Amount', CommonBool, CurrentValue);

    if CommonStr = 'GrossLivingArea' then
    begin
      Adjustments[9].Amount := GetAttributeValue(oAttributes, '_Amount', CommonBool, CurrentValue);

      Param1 := GetAttributeValue(oAttributes, '_Description', CommonBool, CurrentValue);
      if Param1 <> '' then
        Adjustments[9].Description.Add(UpperCase(Param1));
    end;

    if CommonStr = 'BasementArea' then
      Adjustments[10].Amount := GetAttributeValue(oAttributes, '_Amount', CommonBool, CurrentValue);

    if CommonStr = 'BasementFinish' then
      Adjustments[11].Amount := GetAttributeValue(oAttributes, '_Amount', CommonBool, CurrentValue);

     if CommonStr = 'FunctionalUtility' then
    begin
      Adjustments[12].Amount := GetAttributeValue(oAttributes, '_Amount', CommonBool, CurrentValue);

      Param1 := GetAttributeValue(oAttributes, '_Description', CommonBool, CurrentValue);
      if Param1 <> '' then
        Adjustments[12].Description.Add(UpperCase(Param1));
    end;

    if CommonStr = 'HeatingCooling' then
    begin
      Adjustments[13].Amount := GetAttributeValue(oAttributes, '_Amount', CommonBool, CurrentValue);

      Param1 := GetAttributeValue(oAttributes, '_Description', CommonBool, CurrentValue);
      if Param1 <> '' then
        Adjustments[13].Description.Add(UpperCase(Param1));
    end;

    if CommonStr = 'EnergyEfficient' then
    begin
      Adjustments[14].Amount := GetAttributeValue(oAttributes, '_Amount', CommonBool, CurrentValue);

      Param1 := GetAttributeValue(oAttributes, '_Description', CommonBool, CurrentValue);
      if Param1 <> '' then
        Adjustments[14].Description.Add(UpperCase(Param1));
    end;

    if CommonStr = 'CarStorage' then
    begin
      Adjustments[15].Amount := GetAttributeValue(oAttributes, '_Amount', CommonBool, CurrentValue);

      Param1 := GetAttributeValue(oAttributes, '_Description', CommonBool, CurrentValue);
      if Param1 <> '' then
        Adjustments[15].Description.Add(UpperCase(Param1));
    end;
    
    if CommonStr = 'PorchDeck' then
    begin
      Adjustments[16].Amount := GetAttributeValue(oAttributes, '_Amount', CommonBool, CurrentValue);

      Param1 := GetAttributeValue(oAttributes, '_Description', CommonBool, CurrentValue);
      if Param1 <> '' then
        Adjustments[16].Description.Add(UpperCase(Param1));
    end;

    if CommonStr = 'MonthlyFacilityFee' then
    begin
      Adjustments[20].Amount := GetAttributeValue(oAttributes, '_Amount', CommonBool, CurrentValue);

      Param1 := GetAttributeValue(oAttributes, '_Description', CommonBool, CurrentValue);
      if Param1 <> '' then
        Adjustments[20].Description.Add(UpperCase(Param1));
    end;

    if CommonStr = 'CommonElements' then
    begin
      Adjustments[21].Amount := GetAttributeValue(oAttributes, '_Amount', CommonBool, CurrentValue);

      Param1 := GetAttributeValue(oAttributes, '_Description', CommonBool, CurrentValue);
      if Param1 <> '' then
        Adjustments[21].Description.Add(UpperCase(Param1));
    end;

    if CommonStr = 'RecreationFacilities' then
    begin
      Adjustments[22].Amount := GetAttributeValue(oAttributes, '_Amount', CommonBool, CurrentValue);

      Param1 := GetAttributeValue(oAttributes, '_Description', CommonBool, CurrentValue);
      if Param1 <> '' then
        Adjustments[22].Description.Add(UpperCase(Param1));
    end;

    if CommonStr = 'FloorLocation' then
    begin
      Adjustments[23].Amount := GetAttributeValue(oAttributes, '_Amount', CommonBool, CurrentValue);

      Param1 := GetAttributeValue(oAttributes, '_Description', CommonBool, CurrentValue);
      if Param1 <> '' then
        Adjustments[23].Description.Add(UpperCase(Param1));
    end;
  end;


// ------------------------- XPath Attribute Accounts -------------------//

{  'Check the XPath Condition for ExtensionSectionOrganizationName -> GSEDaysOnMarketDescription'}
if XPath.CommaText =  CreateCommaText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Detail_Extension, Comparison_Detail_Extension_Section]) then
  ExtensionSectionOrganizationName := GetAttributeValue(oAttributes, 'ExtensionSectionOrganizationName', CommonBool, CurrentValue) = 'UNIFORM APPRAISAL DATASET';

{  'Check the XPath Condition for GSESaleType'}
if XPath.CommaText =  CreateCommaText([Valuation_Response, _Property, Sales_Contract, Sales_Contract_Extension, Sales_Contract_Extension_Section]) then
  ExtensionSectionOrganizationName := GetAttributeValue(oAttributes, 'ExtensionSectionOrganizationName', CommonBool, CurrentValue) = 'UNIFORM APPRAISAL DATASET';

{  'Check the XPath Condition for GSEViewOverallRatingType'}
if XPath.CommaText =  CreateCommaText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_View_Overall_Rating_Extension, Comparison_View_Overall_Rating_Extension_Section]) then
  ExtensionSectionOrganizationName := GetAttributeValue(oAttributes, 'ExtensionSectionOrganizationName', CommonBool, CurrentValue) = 'UNIFORM APPRAISAL DATASET';

{  'Check the XPath Condition for GSEViewType'}
if XPath.CommaText =  CreateCommaText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_View_Detail_Extension, Comparison_View_Detail_Extension_Section]) then
  ExtensionSectionOrganizationName := GetAttributeValue(oAttributes, 'ExtensionSectionOrganizationName', CommonBool, CurrentValue) = 'UNIFORM APPRAISAL DATASET';

{  'Check the XPath Condition for GSEStoriesCount'}
if XPath.CommaText =  CreateCommaText([Valuation_Response, _Property, Structure, Structure_Extension, Structure_Extension_Section]) then
  ExtensionSectionOrganizationName := GetAttributeValue(oAttributes, 'ExtensionSectionOrganizationName', CommonBool, CurrentValue) = 'UNIFORM APPRAISAL DATASET';

{  'Check the XPath Condition for GSEImprovementDescriptionType'}
if XPath.CommaText =  CreateCommaText([Valuation_Response, _Property, Structure, Condition_Detail_Extension, Condition_Detail_Extension_Section]) then
  ExtensionSectionOrganizationName := GetAttributeValue(oAttributes, 'ExtensionSectionOrganizationName', CommonBool, CurrentValue) = 'UNIFORM APPRAISAL DATASET';

{  'Check the XPath Condition for GSEOverallLocationRatingType'}

if XPath.CommaText =  CreateCommaText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Location_Overall_Rating_Extension, Comparison_Location_Overall_Rating_Extension_Section]) then
  ExtensionSectionOrganizationName := GetAttributeValue(oAttributes, 'ExtensionSectionOrganizationName', CommonBool, CurrentValue) = 'UNIFORM APPRAISAL DATASET';
  // variable reuse exempted

{  'Check the XPath Condition for GSELocationType'}

if XPath.CommaText =  CreateCommaText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Location_Detail_Extension, Comparison_Location_Detail_Extension_Section]) then
  ExtensionSectionOrganizationName := GetAttributeValue(oAttributes, 'ExtensionSectionOrganizationName', CommonBool, CurrentValue) = 'UNIFORM APPRAISAL DATASET';

{  'Check XPath Condition for GSEShortDateDescription'}
  if XPath.CommaText =  CreateCommaText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Date_Extension, Comparison_Date_Extension_Section]) then
    ExtensionSectionOrganizationName := GetAttributeValue(oAttributes, 'ExtensionSectionOrganizationName', CommonBool, CurrentValue) = 'UNIFORM APPRAISAL DATASET';

{  'Check XPath Condition for GSEPriorSaleDate'}
  if XPath.CommaText =  CreateCommaText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Prior_Sales, Prior_Sales_Extension, Prior_Sales_Extension_Section]) then
    ExtensionSectionOrganizationName := GetAttributeValue(oAttributes, 'ExtensionSectionOrganizationName', CommonBool, CurrentValue) = 'UNIFORM APPRAISAL DATASET';

{  'Create XPath condition for GSEManagementCompanyName'}

  if XPath.CommaText =   CreateCommaText([Valuation_Response, Parties, Management_Company_Extension, Management_Company_Extension_Section]) then
    ExtensionSectionOrganizationName := GetAttributeValue(oAttributes, 'ExtensionSectionOrganizationName', CommonBool, CurrentValue) = 'UNIFORM APPRAISAL DATASET';

{  'Check XPath condition for GSEProjectCommercialSpacePercent'}

  if XPath.CommaText =   CreateCommaText([Valuation_Response, _Property, Project, Project_Extension, Project_Extension_Section]) then
    ExtensionSectionOrganizationName := GetAttributeValue(oAttributes, 'ExtensionSectionOrganizationName', CommonBool, CurrentValue) = 'UNIFORM APPRAISAL DATASET';


{  'Check XPath condition for GSEProjectCommercialSpacePercent'}
  if XPath.CommaText =  CreateCommaText([Valuation_Response, _Property, Sales_Contract, Sales_Concession_Extension, Sales_Concession_Extension_Section, Sales_Concession_Extension_Section_Data, Sales_Concession]) then
    if XPathSchema.IndexOfName(XPath.CommaText) <> - 1 then XPathSchema.Delete(XPathSchema.IndexOfName(XPath.CommaText));
end;

function ProcessEndElement(XPath: TStringList; Log: TosAdvDbGrid): Byte;
var
  i: Byte;
  bedAdjustment: String; 
  c8Count,s8Count,c8AdjName: String;
  c24Count,s24Count,c24AdjName: String;
begin
  Result := 0;

{  'Check XPath Condition for GSEShortDateDescription and SalePriceTotalAdjustmentAmount and eveluation at the closure of the element'}

// This validation is done at every end of [ComparableSale] since the validation included number if occurence of GSEShortDateDescription.
// Two diamentional arrays would have been needed if it was done by two XML navigation counts.

  if XPath.CommaText =  CreateCommaText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale]) then
  begin
    if ComparableSale_PropertySequenceIdentifier <> 0 then
    begin

       // UAD 188    - Part 2
      if not ShortDateFailed then
        if (not CheckEnum(GSEListingStatusType, GSEListingStatusType_Comparisons[ComparisonCounter - 1])) or (not CheckEnum(YesNo, GSEContractDateUnknownIndicator_Comparison[ComparisonCounter - 1])) then
          AddLogEntry(Log, '78', [FormField, DataPointString, '', ErrorUndetermined, ''], 1)
        else
        begin
          CommonBool := (GSEListingStatusType_Comparisons[ComparisonCounter - 1] = 'Expired') or (GSEListingStatusType_Comparisons[ComparisonCounter - 1] = 'Withdrawn') or (GSEListingStatusType_Comparisons[ComparisonCounter - 1] = 'Contract');

          if ((CommonBool) and (nGSEShortDateDescription <> 1)) or
             ((GSEListingStatusType_Comparisons[ComparisonCounter - 1] = 'SettledSale') and (GSEContractDateUnknownIndicator_Comparison[ComparisonCounter - 1] = 'Y') and (nGSEShortDateDescription <> 1)) or
             ((GSEListingStatusType_Comparisons[ComparisonCounter - 1] = 'SettledSale') and (GSEContractDateUnknownIndicator_Comparison[ComparisonCounter - 1] = 'N') and (nGSEShortDateDescription <> 2)) then
          begin
            AddLogEntry(Log, '78', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, LogicError1, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Date_Extension, Comparison_Date_Extension_Section, Comparison_Date_Extension_Section_Data, Offering_Disposition]), '[En=' + InttoStr(nGSEShortDateDescription) + ']');
            Result := Result + 1;
          end
          else
            AddLogEntry(Log, '78', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Comparison_Date_Extension, Comparison_Date_Extension_Section, Comparison_Date_Extension_Section_Data, Offering_Disposition]), '[Multiple Attributes]');
        end;


      //SalePriceTotalAdjustmentAmount

      if (_FormType = 'FNM1004') or (_FormType = 'FNM2055') then
        if _TotalSalePriceAdjustmentAmount <> InvalidInt then
          if _TotalSalePriceAdjustmentAmount <> TotalSalePriceAdjustmentAmount then
          begin
            AddLogEntry(Log, '122', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, LogicError2, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale]), InttoStr(_TotalSalePriceAdjustmentAmount));
            Result := Result + 1;
          end
          else
            AddLogEntry(Log, '122', [FormField, DataPointString + '%  - Comparable Sale[' + InttoStr(ComparableSale_PropertySequenceIdentifier ) + ']', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale]), '[Multiple Attributes]');

    end; 
  end;

{  'Evaluation at the end of element for GSEPriorSaleDate, PropertySalesAmount (Comparable)'}

  if XPath.CommaText =  CreateCommaText([Valuation_Response, Valuation_Methods, Sales_Comparison]) then
  begin
    if ComparablePriorSaleIndicator = 'Y' then
    begin
      if not ((_FormType = 'FNM1073') or (_FormType = 'FNM1075')) then
      begin
        // UAD 278
        if nGSEPriorSaleAttribPresent = 0 then
          begin
            AddLogEntry(Log, '129', [FormField, DataPointString + '% - ComparableSale[Multiple]', ErrorCode, LogicError1, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Prior_Sales, Prior_Sales_Extension, Prior_Sales_Extension_Section, Prior_Sales_Extension_Section_Data, Prior_Sale]), '[Multiple Attributes]');
            Result := Result + 1;
          end
        else
          AddLogEntry(Log, '129', [FormField, DataPointString + '% - ComparableSale[Multiple]', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Prior_Sales, Prior_Sales_Extension, Prior_Sales_Extension_Section, Prior_Sales_Extension_Section_Data, Prior_Sale]), '[Multiple Attributes]');

        if nPropertySaleAttribPresent = 0 then
          begin
            AddLogEntry(Log, '130', [FormField, DataPointString  + '% - ComparableSale[Multiple]', ErrorCode, LogicError1, Suggestion], 0, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Prior_Sales]), '[Multiple Attributes]');
            Result := Result + 1;
          end
        else
          AddLogEntry(Log, '130', [FormField, DataPointString  + '% - ComparableSale[Multiple]', ErrorCode, '', Suggestion], 2, CreatePathText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale, Prior_Sales]), '[Multiple Attributes]');
      end;
    end;
 end;


// ADJUSTMENT CHECKING BETWEEN SUBJECT AND COMPARABLES

{'Free the SubjectAdjustments Array at the end of Sales Comparison'}
  if XPath.CommaText = CreateCommaText([Valuation_Response, Valuation_Methods, Sales_Comparison]) then
    begin
      for i := 0 to Length(SubjectAdjustments) - 1 do
        SubjectAdjustments[i].Description.Free;

      SubjectAdjustments := nil;
    end;

{'Compare the Adjustment arrays at the end of every Comparable Sale'}
  if XPath.CommaText = CreateCommaText([Valuation_Response, Valuation_Methods, Sales_Comparison, Comparable_Sale]) then
    begin
      if ComparableSale_PropertySequenceIdentifier = 0 then
        Exit;
//We need to go from last item first, since this loop will pick up the bedroom adjustment 0 but the totalroom can't
//by going through last to first, we can use the bedroom adjustment to use for totalroom in the logic.
//      for i := 0 to Length(SubjectAdjustments) - 1 do
      for i:=Length(SubjectAdjustments) - 1 downto 0 do
        begin
          ComparableAdjustments[i].Description.Sort;
          SubjectAdjustments[i].Description.Sort;
          if i=24 then
             bedAdjustment := ComparableAdjustments[i].Amount;
          if (Trim(ComparableAdjustments[i].Description.Text) <> '') then
            begin
              if (CompareText(Trim(ComparableAdjustments[i].Description.Text), Trim(SubjectAdjustments[i].Description.Text))<>0) and (Trim(ComparableAdjustments[i].Amount) = '') then
              begin
                //Hack, since totalroom adjustment and bedroom adjustment cell are the same but totalroom gives BLANK while bedroom gives 0 and the cell is 0,
                //we can use bedroom adjustment cell for totalroom adjustment cell
                if i=8 then
                begin
                   if bedAdjustment = '' then
                      AddLogEntry(Log, '158', [FormField, '%' + ComparableAdjustments[i].Name + ' (Comp ' + InttoStr(ComparableSale_PropertySequenceIdentifier) + ')', ErrorCode, ErrorMessage, Suggestion], 0, ' ', ' ', ' ');

                end
                else
                  AddLogEntry(Log, '158', [FormField, '%' + ComparableAdjustments[i].Name + ' (Comp ' + InttoStr(ComparableSale_PropertySequenceIdentifier) + ')', ErrorCode, ErrorMessage, Suggestion], 0, ' ', ' ', ' ');
              end
              else if (CompareText(Trim(ComparableAdjustments[i].Description.Text), Trim(SubjectAdjustments[i].Description.Text))=0)  then
              begin
                case i of
                   8: begin
                       if bedAdjustment='0' then
                       begin
                         c8Count:=ComparableAdjustments[i].Description.Text;
                         s8Count:=SubjectAdjustments[i].Description.Text;
                         c8AdjName:=ComparableAdjustments[i].Name;
                       end;
                      end;
                 24:  begin
                       if bedAdjustment='0' then
                       begin
                         c24Count:=ComparableAdjustments[i].Description.Text;
                         s24Count:=SubjectAdjustments[i].Description.Text;
                         c24AdjName:=ComparableAdjustments[i].Name;
                       end;
                     end;
                 else if (Trim(ComparableAdjustments[i].Amount) = '0')  then
                   AddLogEntry(Log, '159', [FormField, '%' + ComparableAdjustments[i].Name + ' (Comp ' + InttoStr(ComparableSale_PropertySequenceIdentifier) + ')', ErrorCode, ErrorMessage, Suggestion], 0, ' ', ' ', ' ');
                end;
              end;
            end;
        end;
        if bedAdjustment = '0' then //we need to handle the 0 adjustment
        begin
           if ((c8Count<>'') and (c8Count=s8Count)) and ((c24Count<>'') and (c24Count=s24Count)) then
              AddLogEntry(Log, '159', [FormField, '%' + c8AdjName + '/'+c24AdjName+ ' (Comp ' + InttoStr(ComparableSale_PropertySequenceIdentifier) + ')', ErrorCode, ErrorMessage, Suggestion], 0, ' ', ' ', ' ');
        end;
        // Free the comparable array
      for i := 0 to Length(ComparableAdjustments) - 1  do
        ComparableAdjustments[i].Description.Free;

      ComparableAdjustments := nil;
    end;
end;  //end of ???




initialization
 InitVariables;
end.
