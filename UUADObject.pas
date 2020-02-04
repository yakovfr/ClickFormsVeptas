unit UUADObject;

interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
	ComCtrls, ExtCtrls, Printers,UGlobals, UBase, UCell, UPage, UForm,DateUtils,
  UMessages,UCC_Progress, uContainer, uUtil2, uStatus,UGridMgr, uUtil1, strUtils;


type
  TUADObject = Class(TObject)
  private
    FUAD: Boolean;
    FSiteArea: string;
    FDesign: String;
    FbsmtGLA: String;
    FbsmtRooms: String;
    FDataSource: String;
    FDoc: TContainer;
    FOverwriteData: Boolean;



  public

   constructor Create(doc: TContainer);
   function IsCondo(compCol: TCompColumn): Boolean;
   function isSubj(compCol: TCompColumn):Boolean;
   function TranslateUADCell2065(str: String; aYes: Boolean=True):String;
   function TranslateUADCell2056(str: String):String;
   function TranslateUADCell2057(str: String):String;
   function translateBasementGLA(compcol: TCompColumn; Str: String):String;
   function translateBasementRooms(compCol: TCompColumn; str: String):String;
   function TranslateSiteArea(CompCol: TCompColumn; cellID: Integer; str: String):String;
   function translateState(aState: String):String;
    function TranslateSettleDate(Str: String):String;
    function translateCityStZip(compCol: TCompColumn; Str: String): String;
    function translateDesign(compCol: TCompColumn; Str: String): String;
    function TranslateDesignSingle(compCol: TCompColumn; str: String):String;
    function TranslateDesignCondo(compCol: TCompColumn; str: String):String;
    function translateGargageCarport(compCol: TCompColumn; str: String): String;
    function translateGarageCarportCondo(CompCol: TCompColumn; Str: String): String;
    function translateFinanceConcession(compCol: TCompColumn; Str: String): String;
    function translateSalesConcession(str: String): String;
    function translateDataSourceDOM(aStr: String): String;
    function translateFireplace(compCol: TCompColumn; str: String): String;
    function translateCondition(compCol: TCompColumn; Str: String): String;
    function TranslateQuality(Str:String):String;
    function TranslateProximity(str: String): String;
    function TranslatePool(compCol: TCompColumn; str: String):String;
    function translatelowHighPrice(str:String):String;
//    function translateAPN(str: String): String;
    function translateHeatingCooling(CompCol: TCompColumn; str: String): String;
    function TranslateAge(compCol: TCompColumn; str: String):String;
    function TranslateFullHalfBath(compCol: TCompColumn; cellID: Integer; tmpStr: String):String;
    function TranslatePorchPatio(compCol: TCompColumn; str: String):String;

    //For Subject
    function TranslateSubjectCondition(str:String):String;
    function translateSubjectDataSource(str: String):String;
    function translateSubjectTax(str: String): String;
    function translateSubjectViewInfl(compCol: TCompColumn; str: String): String;
    function translateSubjectLocInfl(compCol: TCompColumn; str: String): String;
    function translateSubjectFeeSimple(compCol: TCompColumn; str: String): String;
    function translateSubjectTotalRooms(compCol: TCompColumn; cellID: Integer;str: String): String;
    function translateSubjectBedRooms(compCol: TCompColumn; cellID: Integer; str: String): String;
    function translateSubjectGLA(compCol: TCompColumn; str: String): String;
    function TranslateSubjectDesign(compCol: TCompColumn; str: String):String;
    function TranslateSubjectStories(str:String):String;
    function TranslateSubjectFoundation(str: String):String;
   function TranslateStateAbbreviation(CompCol: TCompColumn; cellID: Integer; str: String):String;


   function TranslateToUADFormat(compCol: TCompColumn; cellID: Integer; str:String; overwrite:Boolean=True):String;

   property UAD: Boolean read FUAD write FUAD;
   property doc: TContainer read FDoc write FDoc;
   property OverwriteData: Boolean read FOverwriteData write FOverwriteData;

end;



implementation
uses
  UUADUtils, uStrings;

const
  atDetached    = 1;
  atAttached    = 2;
  atEndUnit     = 3;

//  vSeparator    = '|';
  vSeparator    = ';';  //github : replace '|' with ';' to match with CF UAD
  EstFlag       = '~';

  cSqFt = 'sf';
  cAcres = 'ac';
  cAcre = 43560;


  //design (style) Types
  CondoAttachType: array[0..MaxCondoTypes] of String = ('DT','RT','GR','MR','HR','O','O');
  CondoAttachID: array[0..MaxCondoTypes] of Integer = (2109,380,381,382,383,384,385);
  ResidAttachType: array[0..MaxResidTypes] of String = ('DT','AT','SD');
  ResidAttachID: array[0..MaxResidTypes] of Integer = (157,2101,2102);



var
  UADObject: TUADObject;

function GetNumberDigitInStr(str:String; var iNum:Integer):Integer;
var
 i: Integer;
begin
  iNum := 0;
  result := 0;
  for i:= 1 to length(str) do
    begin
      if str[i] in ['1'..'9'] then
        begin
          inc(result);
          iNum := StrToInt(str[i]);
        end;
    end;
end;


constructor TUADObject.Create(doc: TContainer);
begin
  inherited Create;
  FUAD := doc.UADEnabled;
  FDoc := doc;

end;

function TUADObject.isSubj(compCol: TCompColumn):Boolean;
begin
  result := compCol.FCompID = 0;
end;

function TUADObject.IsCondo(compCol: TCompColumn): Boolean;
begin
  case CompCol.FCX.FormID of
    345, 347, 367: result := True;
    else
      result := False;
  end;
end;


function TUADObject.TranslateDesignSingle(compCol: TCompColumn; str: String):String;
var
  aTemp, aDesign, sType, aStory: String;
  aType, aLevel: Integer;
  iStories: Integer;
  aCompID: Integer;
  aStyle: String;
begin
  if pos('|', str) > 0 then
    result := StringReplace('|',';',str,[rfReplaceAll])
  else
    result := str;
(*
  FDesign := ''; aCompID := -999;
  //github 412
  if pos(';', Str) > 0 then
    begin
      aDesign := popStr(str, ';');
      aStyle := str;
    end
  else
    aDesign := str;
  iStories := GetValidInteger(aDesign);
  if pos('DT',UpperCase(aDesign)) > 0 then
    aType := atDetached
  else if pos('AT', UpperCase(aDesign)) > 0 then
    aType := atAttached
  else if pos('BI', UpperCase(aDesign)) > 0 then
    aType := atEndUnit
  else
    aType := -1;
  if assigned(compCol) then
    aCompID := compCol.FCompID;
  if (aCompID = 0) and FOverwriteData then
    begin
      aTemp := Format('%d',[iStories]);
      FDoc.SetCellTextByID(148,aTemp); //stories

      case aType of
       atDetached : FDoc.SetCellTextByID(157, 'X');
       atAttached : FDoc.SetCellTextByID(2101, 'X');
       atEndUnit  : FDoc.SetCellTextByID(2102, 'X');
      end;
      FDoc.SetCellTextByID(149, str);
    end;
*)
end;

function TUADObject.TranslateSubjectStories(str: String):String;
var
  aTemp, aDesign, sType, aStory: String;
  aType, aLevel: Integer;
  iStories: Integer;
  aCompID: Integer;
begin
  result := str;  //Ticket #1101
(*
  aStory := upperCase(str);
  iStories := Round(GetStrValue(aTemp));
  if iStories = 0 then iStories := 1;

  if pos('ONE', aStory) > 0 then
    aLevel := 1
  else if pos('TWO', aStory) > 0 then
    aLevel := 2
  else if pos('TRI', aStory) > 0 then
    aLevel := 3
  else if pos('4', aStory) > 0 then
    aLevel := 4
  else
    begin
      aLevel := iStories;
    end;
    result := Format('%d',[aLevel]);
*)
end;


function TUADObject.TranslateSubjectDesign(compCol: TCompColumn; str: String):String;
var
  aTemp, aDesign, sType, aStory: String;
  aType, aLevel: Integer;
  iStories: Integer;
  aCompID: Integer;
  aStr, aStyle: String;
begin
  if pos('|', str) > 0 then
    result := StringReplace('|',';',str,[rfReplaceAll])
  else
    result := str;
(*
  FDesign := ''; iStories :=0;
  astr := UpperCase(str);
  //github 412
  if pos(';', aStr) > 0 then
    begin
      aDesign := popStr(str, ';');
      aStyle := str;
    end
  else
    aDesign := astr;

  if ((pos('HR', aDesign) > 0) or
     (pos('DT', aDesign) > 0) or
     (pos('GR', aDesign) > 0) or
     (pos('MR', aDesign) > 0) or
     (pos('RT', aDesign) > 0) or
     (pos('O', aDesign) > 0)) and (length(aDesign) <= 4) then
  begin
     result := aDesign;
     if aStyle <> '' then
       result := aDesign + ';'+aStyle;
  end
  else
  begin
   //aCompID := -999;
    if pos(vSeparator, str) = 0 then    //no ;
      if pos(' ',str) > 0 then      //has space
        str := StringReplace(str, ' ', vSeparator, [rfReplaceAll]); //replace space with ;

  if pos(vSeparator, str) = 0 then exit;
  aTemp   := popStr(str, vSeparator);
  if pos('DET', upperCase(aTemp)) > 0 then
    begin
      sType := 'DT';
      aType := atDetached;
    end

  else if pos('AT', upperCase(aTemp)) > 0 then
    begin
      sType := 'AT';
      aType := atAttached;
    end
  else if (pos('BUILT', upperCase(aTemp)) > 0) or (pos('END', upperCase(aTemp)) >0) or
     (pos('SD', upperCase(aTemp)) > 0) then
    begin
      sType := 'SD';
      aType := atEndUnit;
    end
  else
    begin
      aType := GetValidInteger(aTemp);
      case aType of
        atDetached: sType := 'DT';
        atAttached: sType := 'AT';
        atEndUnit:  sType := 'SD';
        else
          sType := '';
      end;
    end;
  if assigned(compCol) then
    aCompID := compCol.FCompID;

  aTemp := popStr(str, vSeparator); //pop the stories
  if pos(vSeparator, str) > 0 then
    popStr(str, vSeparator); //this is the word 'story';
  iStories := Round(GetStrValue(aTemp));
  if iStories = 0 then iStories := 1;


  aStory := upperCase(aTemp);
  if pos('ONE', aStory) > 0 then
    aLevel := 1
  else if pos('TWO', aStory) > 0 then
    aLevel := 2
  else if pos('TRI', aStory) > 0 then
    aLevel := 3
  else if pos('4', aStory) > 0 then
    aLevel := 4
  else
    begin
      aLevel := iStories;
    end;

  aDesign := upperCase(str);
  result := str;

  FDesign := Format('%s%d;%s',[sType, aLevel, str]);
//  result := FDesign;
  //translate design in page one
//  if aCompID = 0 then
    if FOverwriteData then
    begin
      aTemp := Format('%d',[aLevel]);
      FDoc.SetCellTextByID(148,aTemp); //stories

      case aType of
       atDetached : FDoc.SetCellTextByID(157, 'X');
       atAttached : FDoc.SetCellTextByID(2101, 'X');
       atEndUnit  : FDoc.SetCellTextByID(2102, 'X');
      end;
      FDoc.SetCellTextByID(986, FDesign)
      end;
    end;
*)
end;


//DT2L;xxx  Detach 2 level xxx
//RT2L;xxx  One in a row 2 level xxx
//GR2L;xxx  1-3 stories  2 level xxx
//MR2L;xxx  4-7 stories 2 level xxx
//HR2L;xxx  8+ stories 2 level xxx
//O2L;xxx   other
function TUADObject.TranslateDesignCondo(CompCol: TCompColumn; str: String):String;
var
  aTemp, aDesign, sType: String;
  aType, aStories, aLevel: Integer;
  aCompID: Integer;
  aStr, aStyle: String;
  levelStr: String;
begin  //no conversion
   if pos('|', str) > 0 then
     result := StringReplace('|',';',str,[rfReplaceAll])
   else
     result := str;

(*
  aCompID := -999;
  result := str;  //keep the original str
  astr := UpperCase(str);
  //github 412
  if pos(';', aStr) > 0 then
    begin
      aDesign := popStr(str, ';');
      aStyle := str;
    end
  else
    aDesign := astr;
  if ((pos('HR', aDesign) > 0) or
     (pos('DT', aDesign) > 0) or
     (pos('GR', aDesign) > 0) or
     (pos('MR', aDesign) > 0) or
     (pos('RT', aDesign) > 0) or
     (pos('O', aDesign) > 0)) and (length(aDesign) <= 4) then
  begin
     result := aDesign;
     if aStyle <> '' then
       result := aDesign + ';'+aStyle;
  end
  else
  begin
  if assigned(CompCol) then
    aCompID := CompCol.FCompID;
  aTemp := popStr(str, vSeparator);
  aType := round(GetValidNumber(aTemp));

  aTemp := popStr(str, vSeparator); //pop the second entry
  aStories := GetValidInteger(aTemp);
//  if aStories = 0 then  //github #412: leave stories alone, if user not put in # of stories, leave it empty
//    aStories := 1;



  case aType of
    atDetached: sType := 'DT';
    atAttached: sType := 'AT';
    else
      begin
        case aStories of    ///???? Need to confirm with Jorge on this
//           0:    sType := 'O';
        1..3: begin
                sType := 'GR';
                aLevel := aStories;
              end;
        4..7: begin
                sType := 'MR';
                aLevel := aStories;
              end;
          else
              begin
                sType := 'HR';
                aLevel := aStories;
              end;
        end;
      end;
  end;

  aDesign := upperCase(str);
  if pos('TWO', aDesign) > 0 then
    aLevel := 2
  else if pos('TRI', aDesign) > 0 then
    aLevel := 3
  else if pos('4', aDesign) > 0 then
    aLevel := 4
  else if aLevel = 0 then
    aLevel := 1;

//  FDesign := Format('%s%dL;%s',[sType, aLevel, str]);
  if aLevel > 0 then  //github 412: only include level if we have level > 0
    begin
      LevelStr := format('%dL',[aLevel]);
      FDesign := Format('%s%s;%s',[sType, LevelStr, str]);
    end
  else if (sType <> '') and (str <> '') then
    FDesign := Format('%s;%s',[sType, str])
  else if sType <> '' then
    FDesign := sType
  else if str <> '' then
    FDesign := str;

  if FDesign <> '' then
    result := FDesign;
  end;
*)
end;


function TUADObject.TranslateSiteArea(compCol: TCompColumn; cellID: Integer; str: String):String;
const
  cAcres = 'ac';
  cAcre = 43560;
var
  aSqft,aInt: Integer;
  aAc: Double;
  aCompID: Integer;
begin
  result := str;
  aCompID := -999;
  if assigned(CompCol) then
    aCompID := compCol.FCompID;
  if pos(cAcres, str) > 0 then exit; //already in acres exit
  aSqft := round(GetValidNumber(str));
  if aSqft >= cAcre then
    begin
      aAc := aSqft/cAcre;
      FSiteArea := Format('%-.2n ac',[aAc]);
    end
  else if (aSqft < cAcre) and (pos('sf', str) = 0) then
    begin
      aInt := GetValidInteger(str);      //github #183: add ,
      str := FormatFloat('#,###', aInt);
      FSiteArea := Format('%s sf',[str]);
    end
  else
    FSiteArea := str;
  result := FSiteArea;

  case CellID of
   976: if (aCompID = 0) and FOverwriteData then
          FDoc.SetCellTextByID(67, result);
//    67: FDoc.SetCellTextByID(976, result);
  end;
end;

//use this function instead of the original one
//avoid to pick up local date time formating
function ConvertDateStr(aDateStr:String; var aDateTime:TDateTime; aBool:Boolean):String;
begin
  result := '';
  if pos('-',aDateStr) > 0 then
    aDateStr := StringReplace(aDateStr,'-','/',[rfReplaceAll]); //in case the date is in mm-dd-yyyy, replace with mm/dd/yyyy
   if isValidDate(aDateStr,aDateTime,True) then //always keep silient
    result := aDateStr;
end;


function TUADObject.translateSettleDate(Str: String):String;
var
  aDateTime: TDateTime;
  aStatus, aSaleDate, aContractDate, aExpiredDate, aWithdrawDate, aSettleDate: String;
  aStatus2, aTemp, str1: String;
begin
  result := str;
  aContractDate := ''; aSaleDate := '';
  if length(str) = 0 then exit;
//github 355 - check if there is a space in the string to recognize sale and contract date
  if (pos(' ', str) > 0) and (pos('/', str)>0) then
    begin
      str := StringReplace(str, ' ', vSeparator, [rfReplaceAll]);
      aStatus := popStr(Str, vSeparator);
      aStatus2 := lowercase(copy(aStatus,1,1));
    end
  else
    begin
      aStatus := popStr(Str, vSeparator);
      aStatus2 := lowercase(copy(aStatus,1,1));
    end;
  if pos('ACTIVE', upperCase(aStatus)) > 0 then
    result := 'Active'
  else if (pos('PEND', upperCase(aStatus)) > 0) or (aStatus2='c') then
    begin
      if (pos('/', aStatus) > 0) or (pos('-', aStatus)>0) then
        begin
          result := Format('%s',[lowercase(aStatus)]);
          exit;
        end;
      aContractDate := popStr(Str, vSeparator);
      aContractDate := ConvertDateStr(aContractDate, aDateTime, False);
      if aDateTime > 0 then
         begin
           aContractDate := FormatDateTime('mm/yy',aDateTime);
           result := Format('c%s',[aContractDate]);
         end
       else
         result := 'Active';
    end
  else if (pos('EXPIRE', upperCase(aStatus)) > 0) or (aStatus2='e') then
    begin
      if (pos('/', aStatus) > 0) or (pos('-', aStatus)>0) then
        begin
          result := Format('%s',[lowercase(aStatus)]);
          exit;
        end;
      aExpiredDate := popStr(Str, vSeparator);
      aExpiredDate := ConvertDateStr(aExpiredDate, aDateTime,False); //github #370: handle both / and - date format
      if aDateTime > 0 then
        aExpiredDate := FormatDateTime('mm/yy',aDateTime)
      else
        aExpiredDate := '00/00';
      result := Format('e%s',[aExpiredDate]);
    end
  else if (pos('WITHDRAW', upperCase(aStatus)) > 0) or (aStatus2='w') then
    begin
      if (pos('/', aStatus) > 0) or (pos('-', aStatus)>0) then
        begin
          result := Format('%s',[lowercase(aStatus)]);
          exit;
        end;
      aWithdrawDate := popStr(Str, vSeparator);
      aWithdrawDate := ConvertDateStr(aWithdrawDate, aDateTime,False);
      if aDateTime > 0 then
        aWithdrawDate := FormatDateTime('mm/yy',aDateTime)
      else
        aWithdrawDate := '00/00';
      result := Format('w%s',[aWithdrawDate]);
    end
  else if (pos('SOLD', upperCase(aStatus)) > 0) or (aStatus2='s') then
    begin
      if (pos('/', aStatus) > 0) or (pos('-', aStatus)>0) then
        begin
          aContractDate := str;
          if pos('unk', str) > 0 then
            result := Format('%s%sUnk',[aStatus,vSeparator])
          else
            result := Format('%s%s%s',[aStatus,vSeparator,str]);
          exit;
        end;
      aSaleDate     := popStr(str, vSeparator);
      aSaleDate := ConvertDateStr(aSaleDate, aDateTime,False);//github #370: handle both / and - date format
      if aDateTime > 0 then
        aSaleDate := FormatDateTime('mm/yy', aDateTime)
      else
        aSaleDate := '00/00';
      aContractDate := popStr(str, vSeparator);
      aContractDate := ConvertDateStr(aContractDate, aDateTime,False);
      if aDateTime > 0 then
        aContractDate := FormatDateTime('mm/yy', aDateTime)
      else
        aContractDate := 'Unk';

      if pos('unk', lowerCase(aContractDate)) > 0 then
       result := Format('s%s;%s',[aSaleDate, 'Unk'])
      else
       result := Format('s%s;c%s',[aSaleDate, aContractDate]);
    end
  else //if we have both date and no status, treat it as s and c
    begin
      if (pos('/', aStatus) > 0) or (pos('-', aStatus) > 0) then //github #370: check for both / and -
        begin
          aSaleDate := '00/00'; //github #370: initialize to 00/00 first
          aStatus := ConvertDateStr(aStatus, aDateTime,False);//github #370: use this funtion to handle both / and - for the date format
          if aDateTime > 0 then //tryStrToDate(aStatus, aDateTime) then
            aSaleDate := FormatDateTime('mm/yy',aDateTime);
        end;
      if (pos('/', str) > 0) or (pos('-', str) >0) then  //github #370: check for both / and -
        begin
          str := ConvertDateStr(str, aDateTime,False); //github #370: use this routine to handle both / and - date format
          if aDateTime > 0 then
            aContractDate := FormatDateTime('mm/yy',aDateTime)
        end;
      if (aSaleDate <> '') then
        begin
          if (aContractDate <> '') then
            result := Format('s%s;c%s',[aSaleDate,aContractDate])
          else //no contract date
            result := Format('s%s;Unk',[aSaleDate]);
        end;
    end;
end;

function TUADObject.translateBasementGLA(compCol: TCompColumn;Str: String):String;
  function ConvertAccess(aAccess:String): String;
    begin
      result := aAccess;
      if pos('walk out',lowercase(aAccess)) > 0 then
        result := 'wo'
      else if pos('walk up', lowercase(aAccess)) > 0 then
        result := 'wu'
      else if pos('inter', lowercase(aAccess)) > 0 then
        result :='in'
      else
        result := '';   //if none of the options, leave it empty
    end;

var
  sGLA, sFinish, sAccess: String;
  iGLA, iFinish, acompID: Integer;
begin
  result := trim(Str);
  aCompID := -999;
  if assigned(compCol) then
    aCompID := compCol.FCompID;

  if (pos('0', str) >0) and (length(str) = 1) then
    result := '0sf'
  else if pos('no', lowercase(str)) > 0 then
    result := '0sf';
  if result = '0sf' then
//  if (pos('0sf', result) > 0) and (length(result) =3) then
     begin
       if (aCompID = 0) and FOverwriteData then
         begin
//           FDoc.SetCellTextByID(1008, '');  //empty the below room
           FDoc.SetCellTextByID(200, '0');
           FDoc.SetCellTextByID(201, '0');
         end;
     end;
  if pos(vSeparator, str) = 0 then exit;
  sGLA   := popStr(str, vSeparator);
  sFinish := popStr(str, vSeparator);

  str := lowercase(str);
  if pos('wo', str) > 0 then
    sAccess := 'wo'
  else if pos('wu', str) > 0 then
    sAccess := 'wu'
  else if pos('in', str) > 0 then
    sAccess := 'in'
  else
    sAccess := ConvertAccess(str);

  iGLA     := round(GetValidNumber(sGLA));   //this is basement GLA
  iFinish  := round(GetValidNumber(sFinish));    //this is basement Finish GLA

  if (iGLA > 0) or (iFinish > 0) then
    FbsmtGLA := Format('%dsf%dsf%s',[iGLA, iFinish, sAccess])
  else
    FbsmtGLA := '0sf';

  if FbsmtGLA <> '' then
    result := FbsmtGLA;
end;



function TUADObject.translateBasementRooms(compCol: TCompColumn; str: String):String;
var
  aRec, aBed, aBath, aOther: String;
  iRec, iBed, iOther: Integer;
  fBath: Double;
  aCell: TBaseCell;
  absmt,aFin, absmtGLA: String;
  iGLA, iFGLA: Integer;
  aCompID: Integer;
begin
  FbsmtRooms := trim(str);
  result := FbsmtRooms;
  aCompID := -999;
  if assigned(compCol) then
    aCompID := compCol.FCompID;

  if (length(str) > 0) and (str = '0') or (pos('no', str)>0) then
    begin
      result := '';
      exit;
    end;
//  if pos(vSeparator, str) = 0 then exit;
  if pos(vSeparator, str) > 0 then //ticket #1131
    begin
     aRec    := popStr(str, vSeparator);
     aBed    := popStr(str, vSeparator);
     aBath   := popStr(str, vSeparator);
     aOther  := popStr(str, vSeparator);
    end
  else if (pos('rr', str) > 0) or (pos('br', str) > 0) or (pos('ba', str) > 0) then
    begin
      aRec := popStr(str, 'rr');
      aBed := popStr(str, 'br');
      aBath := popStr(str, 'ba');
      aOther := popStr(str, 'o');
    end;
  iRec   := GetValidInteger(aRec);
  iBed   := GetValidInteger(aBed);
  iOther := GetValidInteger(aOther);

  fBath  := GetStrValue(aBath);

  FbsmtRooms := Format('%drr%dbr%.1fba%do',[iRec, iBed, fBath, iOther]);

  if assigned(compCol) then
    begin
      aCell := compCol.GetCellByID(1006);
      if assigned(aCell) then   //if bstm finish is 0 sf and no bsmt rm set bsmt rooms to '';
       begin
         absmt := aCell.Text;
         absmtGLA := popStr(absmt,'sf');
         aFin     := popStr(absmt,'sf');
         iGLA     := GetValidInteger(absmtGLA);
         iFGLA    := GetValidInteger(aFin);
         if (iGLA > 0) and (iFGLA > 0) then
           FbsmtRooms := Format('%drr%dbr%.1fba%do',[iRec, iBed, fBath, iother])
         else if iGLA = 0 then  //no GLA, set room count to EMPTY
           begin
             if FOverwriteData then
               compCol.SetCellTextByID(1006, '0sf');
              if (iRec = 0) and (iBed=0) and (fbath = 0) and (iOther=0) then
                FbsmtRooms := '';
           end
         else if iGLA > 0 then
           begin
             if iFGLA = 0 then  //ticket 1131 if Finish area = 0 no room count
               FbsmtRooms := ''
             else if iFGLA > 0 then
               FbsmtRooms := Format('%drr%dbr%.1fba%do',[iRec, iBed, fbath, iOther]);
            end;
       end;
    end;
  result := FbsmtRooms;
end;

function TUADObject.translateSubjectDataSource(str: String):String;
var
  aStr: String;
  aDOM, aMsg, aPrice, aDate, aMLS, aByOwner: String;
begin
  if pos(vSeparator,str) > 0 then  //property for sales in the past 12 months
    begin
       //composed by DOM;Subject property was offered for Sale;Listing Price Origin; Listing Date Origin; Data Source
       aDOM := popStr(str, vSeparator);
       if round(GetValidNumber(aDOM)) > 0 then
         aDOM := Format('DOM %s',[aDOM])
       else
         aDOM := 'DOM Unk';

       aMsg := 'Subject property was offered for Sale ';

       aPrice := popStr(str, vSeparator);
       if round(GetValidNumber(aPrice)) > 0 then
         aPrice := Format('Original Price $%s',[trim(aPrice)]);

       aDate := popStr(str, vSeparator);
       if StrToDateDef(aDate, 0) > 0 then
         aDate := Format('Original Date %s',[aDate]);

       aMLS := popStr(str, vSeparator);

       aByOwner := popStr(str, vSeparator);
       if compareText(aByOwner, 'X') = 0 then
         begin
           aByOwner := ' by owner';
           aMsg := aMsg + aByOwner;
         end;

       if aMLS <> '' then
         FDataSource := Format('%s;%s;%s;%s;%s',[aDOM, aMsg, aPrice, aDate, aMLS])
       else
         FDataSource := Format('%s;%s;%s;%s',[aDOM, aMsg, aPrice, aDate]);
    end
  else
    FDataSource := str;

  result := FDataSource;

end;


function TUADObject.TranslateUADCell2065(str: String; aYes:Boolean=True):String;
var
  aStr: String;
  aDOM, aMsg, LPrice, LDate, aMLS, aByOwner, OPrice, ODate: String;
  aDateTime: TDateTime;
begin
  result := str;
  if (pos('DOM', str) > 0) or (pos('Latest', str) > 0) then exit;
  if pos(vSeparator,str) > 0 then  //property for sales in the past 12 months
    begin
       //composed by DOM;Subject property was offered for Sale;Listing Price Origin; Listing Date Origin; Data Source
       aDOM := popStr(str, vSeparator);
       if round(GetValidNumber(aDOM)) > 0 then
         aDOM := Format('DOM %s',[aDOM])
       else
         aDOM := 'DOM Unk';

       if aYes then
         aMsg := 'Subject property was offered for Sale '
       else
         aMsg := '';

       LPrice := popStr(str, vSeparator);
       if round(GetValidNumber(LPrice)) > 0 then
         LPrice := Format('Latest Price $%s',[trim(LPrice)]);

       LDate := popStr(str, vSeparator);
       aDateTime := StrToDateDef(LDate, 0);
       if aDateTime > 0 then
         LDate := 'Latest Date '+FormatDateTime('mm/dd/yyyy',aDateTime);

       OPrice := popStr(str, vSeparator);
       if round(GetValidNumber(OPrice)) > 0 then
         OPrice := Format('Original Price $%s',[OPrice]);

       ODate := popStr(str, vSeparator);
       aDateTime := StrToDateDef(ODate, 0);
       if aDateTime > 0 then
         ODate := 'Original Date '+FormatDateTime('mm/dd/yyyy',aDateTime);

       aMLS := popStr(str, vSeparator);

       FDataSource := aDom;
       if aMsg <> '' then
         FDataSource := FDataSource + VSeparator + aMsg;
       if (LPrice <> '') or (LDate <> '') then
         FDataSource := FDataSource + vSeparator+LPrice + vSeparator+ LDate;
       if (OPrice <> '') or (ODate <> '') then
         FDataSource := FDataSource + vSeparator + OPrice + vSeparator + ODate;
       if aMLS <> '' then
         FDataSource := FDataSource + vSeparator + aMLS;
    end
  else
    FDataSource := str;

  result := FDataSource;

end;


function TUADObject.translateState(aState: String):String;
var
  aTemp: String;
begin
  aState := trim(aState);
  result := aState;
  if length(aState) <= 2 then exit;   //no need to go on

  aTemp := UpperCase(aState);
  if pos('ALAB', aTemp) > 0 then
    result := 'AL'
  else if pos('ALAS', aTemp) > 0 then
    result := 'AK'
  else if pos('ARI', aTemp) > 0 then
    result := 'AZ'
  else if pos('ARK', aTemp) > 0 then
    result := 'AR'
  else if pos('CA', aTemp) > 0 then
    result := 'CA'
  else if pos('COL', aTemp) > 0 then   //github 439
    result := 'CO'
  else if pos('CONN', aTemp) > 0 then
    result := 'CT'
  else if pos('DE', aTemp) > 0 then
    result := 'DE'
  else if pos('FL', aTemp) > 0 then
    result := 'FL'
  else if pos('GEO', aTemp) > 0 then
    result := 'GA'
  else if pos('HAW', aTemp) > 0 then
    result := 'HI'
  else if pos('ID', aTemp) > 0 then
    result := 'ID'
  else if pos('IL', aTemp) > 0 then
    result := 'IL'
  else if pos('INDI', aTemp) > 0 then
    result := 'IN'
  else if pos('IOWA', aTemp) > 0 then
    result := 'IA'
  else if pos('KANS', aTemp) > 0 then
    result := 'KS'
  else if pos('KENT', aTemp) > 0 then
    result := 'KY'
  else if pos('LOUI', aTemp) > 0 then
    result := 'LA'
  else if pos('MAIN', aTemp) > 0 then
    result := 'ME'
  else if pos('MARY', aTemp) > 0 then
    result := 'MD'
  else if pos('MASS', aTemp) > 0 then   //github #944
    result := 'MA'
  else if pos('MI', aTemp) > 0 then
    result := 'MI'
  else if pos('MIN', aTemp) > 0 then
    result := 'MN'
  else if pos('MISSI', aTemp) > 0 then
    result := 'MS'
  else if pos('MISSO', aTemp) > 0 then
    result := 'MO'
  else if pos('MONT', aTemp) > 0 then
    result := 'MT'
  else if pos('NEBRA', aTemp) > 0 then
    result := 'NE'
  else if pos('NEVA', aTemp) > 0 then
    result := 'NV'
  else if pos('NEW HAM', aTemp) > 0 then
    result := 'NH'
  else if pos('NEW JER', aTemp) > 0 then
    result := 'NJ'
  else if pos('NEW MEX', aTemp) > 0 then
    result := 'NM'
  else if pos('NEW YORK', aTemp) > 0 then
    result := 'NY'
  else if pos('NORTH CAR', aTemp) > 0 then
    result := 'NC'
  else if pos('NORTH DAK', aTemp) > 0 then
    result := 'ND'
  else if pos('OHIO', aTemp) > 0 then
    result := 'OH'
  else if pos('OK', aTemp) > 0 then   //github #944: oklahoma was converting to
    result := 'OKLA'
  else if pos('OREG', aTemp) > 0 then
    result := 'OR'
  else if pos('PEN', aTemp) > 0 then
    result := 'PA'
  else if pos('RHODE', aTemp) > 0 then
    result := 'RI'
  else if pos('SOUTH DAK', aTemp) > 0 then
    result := 'SD'
  else if pos('TEN', aTemp) > 0 then
    result := 'TN'
  else if pos('TEX', aTemp) > 0 then
    result := 'TX'
  else if pos('UT', aTemp) > 0 then
    result := 'UT'
  else if pos('VERM', aTemp) > 0 then
    result := 'VA'
  else if pos('VIR', aTemp) > 0 then
    result := 'VA'
  else if pos('WAS', aTemp) > 0 then
    result := 'WA'
  else if pos('WEST VIR', aTemp) > 0 then
    result := 'WV'
  else if pos('WIS', aTemp) > 0 then
    result := 'WI'
  else if pos('WY', aTemp) > 0 then
    result := 'WY';
end;


function  TUADObject.translateCityStZip(compCol: TCompColumn; Str: String): String;
var
  p: Integer;
  unitNo, city, state, zip: String;
  cityStZip, aTemp: String;
  sUnit, sCity, sState, sZip: String;
  UADCell: TBaseCell;
  PosGSE: Integer;
  valid: Boolean;
  p1, p2: Integer;
begin
//github #663: this is wrong.
//  p := POS(str,','); //see how many coma do we have here
//  if p >= 2 then
//   unitNo := popStr(str, ',');
  aTemp := str;
  p1 := 0; p2 := 0;
  p1 := pos(',', aTemp);
  if p1 > 0 then
    begin
      popStr(aTemp, ',');
      p2 := pos(',', aTemp);
    end;
  if (p1 > 0)  and (p2 > 0) then   //github #663: we found 2 comma, so this one has unit #
    unitNo := popStr(str, ',');


  city  := popStr(str, ',');
  aTemp := trim(str);
  aTemp := StringReplace(aTemp, ' ', '%', [rfReplaceAll]);
  if pos('%', aTemp) > 0 then
    state := popStr(aTemp, '%');
  zip   := aTemp;
  state := translateState(state);
  cityStZip := Format('%s, %s %s',[city, state, zip]);
  result := cityStZip;

  if assigned(compCol) and isCondo(compCol) then
   begin
//     p := POS(str,',');
//     if p < 2 then // don't have unit #
//       result := Format('-, %s',[cityStZip])
//     else
    if UnitNo <> '' then
       result := Format('%s, %s',[UnitNo, cityStZip])
    else  //no unit number
      begin
        if isCondo(compCol) and assigned(compCol) then
          result := Format('-, %s',[cityStZip])
        else
          result := cityStZip;
      end;
   end;

end;

function TUADObject.TranslateSubjectCondition(str:String):String;
var
  aTmp: String;
  aCond, aUpdate, aUpdate2, aComment: String;
  idx: Integer;
  aKitchenUpdate, aBathRoomUpdate: String;
  aTitle: String;

  function GetTitle(aUpdate:String):String;
  begin
    result := lowercase(aUpdate);
    if pos('update', lowercase(aUpdate)) > 0 then
      result := 'updated'
    else if pos('remodel', lowercase(aUpdate)) > 0 then
      result := 'remodeled';
  end;

begin
  result := str;
  aTmp := trim(str);
  idx := pos(vSeparator, aTmp);
  if idx = 0 then exit; //no multiple value
  if (UpperCase(aTmp[1]) = 'C') and (idx = 3) then //we have a condition
    begin
      aCond := popStr(aTmp, vSeparator);
      aCond := upperCase(aCond);
    end;

  if pos(vSeparator, aTmp) = 0 then
    begin
      aUpdate := aTmp;  aTmp := '';
      if pos('NO UPDATE', UpperCase(aUpdate))>0 then
        aUpdate := 'No updatees in the prior 15 years';
    end
  else if pos(vSeparator, aTmp) > 0 then //we have a update
    begin
      aUpdate := popStr(aTmp, vSeparator);
      if pos('NO UPDATE', upperCase(aUpdate)) > 0 then
        aUpdate := 'No updates in the prior 15 years'
      else
        begin
          //kitch update?
          if pos('KITCHEN', upperCase(aUpdate)) > 0 then
            begin
              aKitchenUpdate := popStr(aUpdate, vSeparator);//format Kitchen-not Update  or Kitchen-
              if pos('-', trim(aKitchenUpdate)) > 0 then
                begin
                  popStr(aKitchenUpdate, '-');
                  aKitchenUpdate := UpperCase(aKitchenUpdate);
                  if pos('NOT UPDATE', aKitchenUpdate) > 0 then
                    aUpdate := 'Kitchen-not updated'
                  else if (pos('UPDATE', aKitchenUpdate) > 0) or
                    (pos('REMODEL', aKitchenUpdate)>0) then
                    begin  //kitchen-updated-less than one year
                      aTitle := GetTitle(aKitchenUpdate);
                      if (pos('LESS', aKitchenUpdate) > 0) or (pos('<', aKitchenUpdate) > 0) then
                        aUpdate := Format('Kitchen-%s-less than one year ago',[aTitle])
                      else if (pos('1-5', aKitchenUpdate) > 0) or (pos('ONE', aKitchenUpdate) > 0) then
                        aUpdate := Format('Kitchen-%s-one to five years ago',[aTitle])
                      else if (pos('6-10', aKitchenUpdate) >0) or (pos('SIX', aKitchenUpdate) > 0) then
                        aUpdate := Format('Kitchen-%s-six to ten years ago',[aTitle])
                      else if (pos('11-15', aKitchenUpdate) > 0) or (pos('ELEVEN', aKitchenUpdate) > 0) then
                        aUpdate := Format('Kitchen-%s-eleven to fifteen years ago',[aTitle])
                      else if pos('UNK', aKitchenUpdate) > 0 then
                        aUpdate := Format('Kitchen-%s-timeframe unknown',[aTitle]);
                    end;
                end;
            end;
        end;
    end;
  //bathroom update
    if pos(vSeparator, aTmp) > 0 then
      begin
      aUpdate2 := popStr(aTmp, vSeparator);
      if pos('NO UPDATE', upperCase(aUpdate2)) > 0 then
        aUpdate2 := 'No updates in the prior 15 years'
      else
        begin
          //bathroom update?
          if pos('BATH', upperCase(aUpdate2)) > 0 then
            begin
              aBathroomUpdate := popStr(aUpdate2, vSeparator);//format Kitchen-not Update  or Kitchen-
              if pos('-', trim(aBathroomUpdate)) > 0 then
                begin
                  popStr(aBathroomUpdate, '-');
                  aBathroomUpdate := UpperCase(aBathroomUpdate);
                  if pos('NOT UPDATE', aBathroomUpdate) > 0 then
                    aUpdate2 := 'Bathrooms-not updated'
                  else if (pos('UPDATE', aBathroomUpdate) > 0) or
                          (pos('REMODEL', aBathroomUpdate) > 0) then
                    begin  //Bathrooms-updated-less than one year
                      aTitle := GetTitle(aBathRoomUpdate);
                      if (pos('LESS', aBathroomUpdate) > 0) or (pos('<', aBathroomUpdate) > 0) then
                        aUpdate2 := Format('Bathrooms-%s-less than one year ago',[aTitle])
                      else if (pos('1-5', aBathroomUpdate) > 0) or (pos('ONE', aBathroomUpdate) > 0) then
                        aUpdate2 := Format('Bathrooms-%s-one to five years ago',[aTitle])
                      else if (pos('6-10', aBathroomUpdate) >0) or (pos('SIX', aBathroomUpdate) > 0) then
                        aUpdate2 := Format('Bathrooms-%s-six to ten years ago',[aTitle])
                      else if (pos('11-15', aBathroomUpdate) > 0) or (pos('ELEVEN', aBathroomUpdate) > 0) then
                        aUpdate2 := Format('Bathrooms-%s-eleven to fifteen years ago',[aTitle])
                      else if pos('UNK', aBathroomUpdate) > 0 then
                        aUpdate2 := Format('Bathrooms-%s-timeframe unknown',[atitle]);
                    end;
                end;
            end;
        end;
      end;

  if pos(vSeparator, aTmp) = 0 then //this is a comment
    begin
      if pos(aUpdate, aTmp) = 0 then
        aComment := aTmp;
    end;


  result := '';
  if aCond <> '' then
    result := aCond;
  if aUpdate <> '' then
    begin
      if result = '' then
        result := aUpdate
      else
        result := result + vSeparator + aUpdate;
    end;
  if aUpdate2 <> '' then
    begin
      if result = '' then
        result := aUpdate2
      else
        result := result + vSeparator + aUpdate2;
    end;
  if aComment <> '' then
    begin
      if result = '' then
        result := aComment
      else
        result := result + vSeparator + aComment;
    end;
end;

function TUADObject.translateDesign(compCol: TCompColumn; Str: String): String;
begin
  if assigned(CompCol)  and isCondo(compCol) then
    result := translateDesignCondo(CompCol, str)
  else
    result := translateDesignSingle(CompCol, str);
end;

//None: if no garage no carport
//for 1 garage= 1g, 1 coverage = 1cv
function TUADObject.translateGarageCarportCondo(compCol: TCompColumn; Str: String): String;
var
  aGarage, aDriveway, aCarport: String;
  iGarage, iDriveway, iCarport: Integer;
  UADCell, UADAltCell: TBaseCell;
  valid: Boolean;
  iGA, iGD, iGBI, iCP, iDW: Integer; // car storage attached, detached, built-in, carport & driveway quantities
  iG, iCV, iOP: Integer; // condo car storage garage, covered, open quantities
begin
  result := '';
  iGarage := 0; iDriveway := 0; iCarport := 0;

  if pos('g', str) > 0 then
    begin
      aGarage := popStr(str, 'g');
      iGarage := round(GetValidNumber(aGarage));
    end;
  if pos('dw', str) > 0 then
    begin
      aDriveWay := popStr(str, 'dw');
      iDriveWay := round(GetValidNumber(aDriveWay));
    end;
  if pos('cp', str) > 0 then
    begin
      aCarport := popStr(str, 'cp');
      iCarport := round(GetValidNumber(aCarport));
    end;

  if iGarage > 0 then
    result := Format('%dg',[iGarage]);

  if iDriveWay > 0 then
    if result <> '' then
      result := Format('%s;%dop',[result, iDriveWay])
    else
      result := Format('%dop',[iDriveWay]);

  if iCarport > 0 then
    if result <> '' then
      result := Format('%s;%dcv',[result, iCarport])
    else
      result := Format('%dcv',[iCarport]);
end;

function HandleSingleCell1016(str:String):String;
 var
  aTemp, aTemp2, aQty, dw, at, dt, bi, cp:String;
  idw, iat, idt, ibi, icp, iqty: Integer;
  str1, str2, str3: String;
begin
  //if space, -, , convert to ; separator
   if pos('-',str) > 0 then
     str := StringReplace(str, '-', vSeparator, [rfReplaceAll]);
   if pos(',',str) > 0 then
     str := StringReplace(str, ',', vSeparator, [rfReplaceAll]);
   if pos(' ', str) > 0 then
     str := StringReplace(str, ' ', vSeparator, [rfReplaceAll]);

   if pos(vSeparator, str) = 0 then
     begin
       if pos('ATT',upperCase(str)) > 0 then
         begin
          // result := 'AT';
           iat := GetValidInteger(str);
           if iat > 0 then
             result := Format('AT%d',[iat]);
         end
       else if pos('DET', upperCase(str)) > 0 then
         begin
         //  result := 'DT';
           idt := GetValidInteger(str);
           if idt > 0 then
             result := Format('DT%d',[idt]);
         end
       else if pos('BUIL', upperCase(str)) > 0 then
         begin
         //  result := 'SD';
           ibi := GetValidInteger(str);
           if ibi > 0 then
             result := Format('SD%d',[ibi]);
         end
       else
         result := str;
       exit;
     end;

   result :='';
   while str <> '' do
     begin
       if pos(vSeparator, str) > 0 then //we have something
         begin
           aTemp := popStr(str, vSeparator);
           aTemp := Uppercase(aTemp);
           iQty := GetValidInteger(aTemp);
           if iQty > 0 then //we have # before the text
             begin
               aTemp2 := str;
               str := aTemp;
               aTemp := aTemp2;
             end;

           //look for garage attach
           if pos('ATT', UpperCase(aTemp)) > 0 then
             begin
                aQty := popStr(str,vSeparator);
                while (str <> '') and (aQty = '') do
                  begin
                    aQty := popStr(str, vSeparator);
                    if aQty <> '' then
                      break;
                  end;
                iat := GetValidInteger(aQty);
                if iat = 0 then iat := 1;
                at := Format('%dga',[iat]);
             end;
           //look for garage detach
           if pos('DET', upperCase(aTemp)) > 0 then
             begin
               aQty := popStr(str,vSeparator);
                while (str <> '') and (aQty = '') do
                  begin
                    aQty := popStr(str, vSeparator);
                    if aQty <> '' then
                      break;
                  end;
               idt := GetValidInteger(aQty);
               if idt = 0 then idt := 1;
               dt := Format('%dgd',[idt]);
             end;
           //look for garage built-in
           if pos('BUIL', upperCase(aTemp)) > 0 then
             begin
               aQty := popStr(str,vSeparator);
                while (str <> '') and (aQty = '') do
                  begin
                    aQty := popStr(str, vSeparator);
                    if aQty <> '' then
                      break;
                  end;
               ibi := GetValidInteger(aQty);
               if ibi = 0 then ibi := 1;
               bi := Format('%dgbi',[ibi]);
             end;
           //look for carport
           if pos('CAR', uppercase(aTemp)) > 0 then
             begin
                aQty := popStr(str,vSeparator);
                while (str <> '') and (aQty = '') do
                  begin
                    aQty := popStr(str, vSeparator);
                    if aQty <> '' then
                      break;
                  end;
                icp := GetValidInteger(aQty);
                if icp = 0 then icp := 1;
                cp := Format('%dcp',[icp]);
             end;
            //look for drive way
            if pos('DRI', uppercase(aTemp)) > 0 then
              begin
                aQty := popStr(str,vSeparator);
                while (str <> '') and (aQty = '') do
                  begin
                    aQty := popStr(str, vSeparator);
                    if aQty <> '' then
                      break;
                  end;
                idw := GetValidInteger(aQty);
                if idw = 0 then idw := 1;
                dw := Format('%ddw',[idw]);
              end
            else
              begin
                popStr(str, vSeparator);
                break;
              end;
         end;
    end;
    if at <> '' then
      result := at;
    if dt <> '' then
      result := result+dt ;
    if bi <> '' then
      result := result+bi;
    if cp <> '' then
      result := result+cp;
    if dw <> '' then
      result := result+dw;
 end;

function ValidGarageType(str: String) : Boolean;
begin
  result := False;
  str := upperCase(str);
  if (pos('ATT', str) > 0) or
     (pos('DET', str) > 0) or
     (pos('BUIL', str) > 0) or
     (pos('CAR', str) > 0) or
     (pos('DRIV', str) > 0) then
   result := true;
end;


function HandleGarageStr(var str1, str: String):Boolean;
var
 i,j,iQty: Integer;
 aTemp: String;
begin
  result := False; j:=0;
  aTemp := str;
  if str = '' then
    str := str1;
  i := GetNumberDigitInStr(str, j); //if i = 1 means we have only one number

  if validGarageType(str1) then
    begin
      if (i=1) then
        begin
          iQty := getValidInteger(str);
          if iQty = 0 then
            iQty := j;
          if str1= '' then
            begin
              str1 := str;
              str := '';
          end;
          str1 := HandleSingleCell1016(Format('%s;%d',[str1,iqty]));
          result := true;
        end;
    end;
  if GetValidInteger(str1) > 0 then
    str1 := HandleSingleCell1016(str1)
  else if pos(';',str) = 0 then
    begin
      if pos(' ', str) >0 then
        ClearSpaces(str);
      iQty := GetValidInteger(str);
      if str1 = '' then
        begin
          str1 := str;
          str  := '';
        end;
      if iQty > 0 then
        str1 := HandleSingleCell1016(Format('%s;%d',[str1,iqty]))
      else
        str1 := HandleSingleCell1016(str1);
//      else
//        str1 := '';
    end;
  str := aTemp;
end;

function TranslateCell_1016(str:String):String;
var
  aTemp, aQty, dw, at, dt, bi, cp:String;
  idw, iat, idt, ibi, icp, iqty, i: Integer;
  str1, str2, str3, str4: String;
begin
  result := str;
//  i := GetNumberDigitInStr(str); //if i = 1 means we have only one number
  aTemp := ''; aQty := ''; dw:=''; at:=''; dt:=''; bi:=''; cp:='';
  str1 := ''; str2 :=''; str3 := ''; str4 :='';
  //for multiple value, separated by , or ;
  while str <> '' do
    begin
      str := trim(str);
      if (pos(',',str) > 0) then
        begin
         str := StringReplace(str, ',', ';', [rfReplaceAll]);
        end;
      if pos(';', str) > 0 then
        begin
          if str1 = '' then
            begin
              str1 := popStr(str, ';');
              if HandleGarageStr(str1, str) then
                break;
            end
          else if str2 = '' then
            begin
              str2 := popStr(str, ';');
              if HandleGarageStr(str2, str) then
                break;
            end
          else if str3 = '' then
            begin
              str3 := popStr(str, ';');
              if HandleGarageStr(str, str) then
                break;
            end;
        end
      else
        begin
          str4 := popStr(str, ';');
          if HandleGarageStr(str4, str) then
            break;
        end;
    end;
    result := '';
    if str1 <> '' then
      result := result + str1;
    if str2 <> '' then
      result := result + str2;
    if str3 <> '' then
      result := result + str3;
    if str4 <> '' then
      result := result + str4;
    result := trim(result);
end;



//For condo, we handle differently
function TUADObject.translateGargageCarport(compCol: TCompColumn; str: String): String;

  procedure ResetCarStorageCell;
  begin
    if not FOverwriteData then exit;
      FDoc.SetCellTextByID(2030, ''); //clear before fill in
      FDoc.SetCellTextByID(349, '');  //garage checked
      FDoc.SetCellTextByID(2070, ''); //attach
      FDoc.SetCellTextByID(2071, ''); //detach
      FDoc.SetCellTextByID(2072, ''); //built in
      FDoc.SetCellTextByID(2657, ''); //carport checked
      FDoc.SetCellTextByID(355, '');  //carport #cars
      FDoc.SetCellTextByID(360, '');  //drive way #cars
      FDoc.SetCellTextByID(359, '');  //driveway checked
  end;

var
  gd, ga, gbi, cp, dw, aTemp: String;
  idx, iCar: Integer;
  isSubject: Boolean;
begin
  if assigned(CompCol) then
    isSubject := CompCol.FCompID = 0;

  str := TranslateCell_1016(str);


  if pos(vSeparator, Str) > 0 then   //github 237
    begin
      str := StringReplace(str, vSeparator, '', [rfReplaceAll]);
      str := trim(str);
    end;

  if isSubject and FOverwriteData then
    FDoc.SetCellTextByID(346, '');
  if (getValidNumber(str) = 0) and (length(str) = 1) then  //user enter '0'
    begin
      result := 'None';
      if isSubject and FOverwriteData then
        begin
          FDoc.SetCellTextByID(346, 'X'); //update p1
          ResetCarStorageCell;
        end;
      exit;  //done
    end
  else if (pos('no', lowercase(str)) > 0) or (length(str)=0) then //user enter 'no' or 'none'
    begin
      result := 'None';
      if isSubject and FOverwriteData then
        begin
          FDoc.SetCellTextByID(346, 'X');
          ResetCarStorageCell;
        end;
      exit;
    end
  else
    begin
      if assigned(compCol) and isCondo(compCol) then
        result := translateGarageCarportCondo(compCol, str)
      else
        result := str;
    end;
  //transfer to p1
  iCar := 0;
  str := lowercase(str);
  aTemp := str;
  if isSubject and FOverwriteData then
    begin
      FDoc.SetCellTextByID(346, '');  //none checked
      ResetCarStorageCell;
      //Handle garage
      if pos('g',str) > 0 then
        begin
          aTemp := str;
          gd := popStr(aTemp, 'g');
          iCar := GetValidInteger(gd);
          if iCar > 0 then
            begin
              FDoc.SetCellTextByID(2030, IntToStr(iCar)); //#car
              FDoc.SetCellTextByID(349, 'X');  //garage
            end;
        end;
      if pos('gd',str) > 0 then
        begin
          aTemp := str;
          gd := popStr(aTemp, 'gd');
          iCar := GetValidInteger(gd);
          if iCar > 0 then
            FDoc.SetCellTextByID(2030, IntToStr(iCar)); //#car
          FDoc.SetCellTextByID(349, 'X');  //garage
          FDoc.SetCellTextByID(2071, 'X'); //garage detach
        end;
      if pos('ga', str) > 0 then
        begin
          aTemp := str;
          ga := popStr(aTemp, 'ga');
          iCar := GetValidInteger(ga);
          if iCar > 0 then
            FDoc.SetCellTextByID(2030, IntToStr(iCar));  //# car
          FDoc.SetCellTextByID(349, 'X');  //garage
          FDoc.SetCellTextByID(2070, 'X'); //garage attach
        end;
      if pos('gb', str) > 0 then
        begin
          aTemp := str;
          gbi := popStr(aTemp, 'gb');
          iCar := GetValidInteger(gbi);
          if iCar > 0 then
            FDoc.SetCellTextByID(2030, IntToStr(icar)); //# car
          FDoc.SetCellTextByID(349, 'X');   //garage
          FDoc.SetCellTextByID(2072, 'X');  //garage built in
        end;

      //Handle carport
    //  aTemp := str;
      if pos('cp', aTemp) > 0 then
        begin
          cp := popStr(aTemp, 'cp');
          iCar := GetValidInteger(cp);
          if iCar > 0 then
            FDoc.SetCellTextByID(355, IntToStr(iCar));
          FDoc.SetCellTextByID(346, '');
          FDoc.SetCellTextByID(2657, 'X');
          if pos('cpa', str) > 0 then
            begin
              FDoc.SetCellTextByID(2070, 'X');
            end

          else if pos('cpd', str) > 0 then
            begin
              FDoc.SetCellTextByID(2071, 'X');
            end;
        end;

      //Handle Drive way
    //  aTemp := str;
      if pos('dw', aTemp) > 0 then
        begin
          dw := popStr(aTemp, 'dw');
          iCar := GetValidInteger(dw);
          if iCar > 0 then
            FDoc.SetCellTextByID(360, IntToStr(iCar));
          FDoc.SetCellTextByID(359, 'X');
        end;
    end;
    if pos(vSeparator, result) >0 then
      result := StringReplace(result, vSeparator, '', [rfReplaceAll]);
    if pos('cpa', result) > 0 then
      result := StringReplace(result, 'cpa', 'cp', [rfReplaceAll]);
    if pos('cpd', result) > 0 then
      result := StringReplace(result, 'cpd', 'cp', [rfReplaceAll]);
end;

function TUADObject.translateFinanceConcession(compCol: TCompColumn; Str: String): String;
var
  UADCell: TBaseCell;
  fCon, aCon, fAmt, aStr, sItem, sTemp: String;
  iAmt: Integer;
  valid: Boolean;
  posItem, posIdx:  Integer;
begin
  //handle UAD
  aCon := popStr(str, vSeparator);
  fAmt := popStr(str, vSeparator);
  iAmt := round(GetStrValue(fAmt));

  result := Format('%s, %s',[aCon, fAmt]);

///  if not FUAD then exit;
  if length(aCon) > 0 then
    begin
      fCon := UpperCase(aCon);
      if pos('CONV',fCon) > 0 then
        result := Format('Conv;%d',[iAmt])
      else if pos('FHA', fCon) > 0 then
        result := Format('FHA;%d',[iAmt])
      else if pos('VA', fCon) > 0 then
        result := Format('VA;%d',[iAmt])
      else if CompareText('CASH', fCon) = 0 then  //Ticket #1393: look for exact word
        result := Format('Cash;%d',[iAmt])
      else if pos('SELL', fCon) > 0 then
        result := Format('Seller;%d',[iAmt])
      else if (pos('RURAL', fCon) > 0) or (pos('RH', fCon) > 0) then
        result := Format('RH;%d',[iAmt])
      else
        result := Format('%s;%d',[aCon, iAmt]);
    end
  else if iAmt > 0 then
    result := Format(' ;%d',[iAmt])
  else
    result := 'None;0';
end;

function TUADObject.translateSalesConcession(str: String): String;
var
  sConcession: String;
begin
  result := str;
//  if not FUAD then exit;    //donot check for UAD or NON UAD, always go through the conversion
  sConcession := UpperCase(str);

  if pos('REO', sConcession) > 0 then
    result := 'REO'
  else if pos('SHORT', sConcession) > 0 then
    result := 'Short'
  else if pos('COURT', sConcession) > 0 then
    result := 'CrtOrd'
  else if pos('ESTATE', sConcession) > 0 then
    result := 'Estate'
  else if pos('RELOCATION', sConcession) > 0 then
    result := 'Relo'
  else if pos('NON-ARM', sConcession) > 0 then
    result := 'NonArm'
  else if pos('ARMS', sConcession) > 0 then
    result := 'ArmLth'
  else if pos('LIST', sConcession) > 0 then
    result := 'Listing'
  else if pos('FALSE', sConcession) > 0 then
    result := 'ArmLth'
  else if pos('NONE', sConcession) > 0 then
    result := ''
  else if pos('CONV', sConcession) > 0 then
    result := 'Conv';
end;

function TUADObject.translateDataSourceDOM(aStr: String): String;
var
  aDataSrc, aDOM: String;
  iDOM: Integer;
begin
  if (pos(vSeparator, aStr) = 0) then
    if pos(' ', aStr) > 0 then
      astr := StringReplace(astr, ' ', vSeparator, [rfReplaceAll]);   //change space with %

  aDataSrc := popStr(aStr, vSeparator);
  aDOM := aStr;
  if pos('unk', lowercase(aDOM)) > 0 then
    aDOM := 'Unk'
  else
    iDOM := round(GetValidNumber(aDOM));

  if iDOM > 0 then
    begin
      result := Format('%s;DOM %d',[aDataSrc, iDOM]) //same format for UAD and non UAD
    end
  else if aDOM = '' then
      result := aDataSrc
  else if pos('DOM', upperCase(aDOM)) > 0 then
    result := Format('%s;%s',[aDataSrc, aDOM])
  else
    result := Format('%s;DOM %s',[aDataSrc, aDOM]);
end;

function TUADObject.translateFireplace(compCol: TCompColumn; str: String): String;
var
  iFirePl: Integer;
  UADAltCell: TBaseCell;
  aCompID: Integer;
begin
  result := ''; aCompID := -999;
  if assigned(compCol) then
  aCompID := compCol.FCompID;
  iFirepl := GetValidInteger(str);
  if iFirePl > 0 then
    begin
      result := Format('%d Fireplace(s)',[iFirePl]);
      if FDoc.GetCellTextByID(1500) = '' then
        FDoc.SetCellTextByID(1500, 'Fireplaces');
     (* if (aCompID = 0) and FOverwriteData then
        begin
          FDoc.SetCellTextByID(322, Format('%d',[iFirePl]));
          FDoc.SetCellTextByID(321, 'X');
          FDoc.SetCellTextByID(1020, Format('%d Fireplace(s)', [iFirePl]));
        end;   *)
    end
  else
    result := str;

 if aCompID = 0 then  //github 411 - apply same as pool to fireplace
    begin
      if (pos('No', str) > 0) and FOverwriteData then
        begin
          FDoc.SetCellTextByID(321, '');
          FDoc.SetCellTextByID(322, result);
        end
      else if not FOverwriteData and (pos('No', str) > 0) then
        begin
          FDoc.SetCellTextByID(321, '');
          FDoc.SetCellTextByID(322, result);
        end
      else
        begin
          FDoc.SetCellTextByID(321, 'X');
          FDoc.SetCellTextByID(322, Format('%d', [iFirePl]));
          end
    end
end;

function TUADObject.TranslateFullHalfBath(compCol: TCompColumn; cellID: Integer; tmpStr: String):String;
var
  PosIdx: Integer;
  HBaths: Integer;
  theCell: TBaseCell;
  fBathCell, hBathCell: TBaseCell;
  temp: String;
  aFull, aHalf: String;
  aCompID: Integer;
begin
  result  := '';
  aCompID := -999;
  if (cellID = 1043) and (CompCol <> nil) then
    aCompID := CompCol.FCompID;
  if tmpStr = '' then exit;
  temp := tmpStr;
  if pos('.', temp) = 0 then
    begin
      if pos(' ', temp) > 0 then
        temp := StringReplace(temp, ' ', '.', [rfReplaceAll]);   //change space with %
    end;
  aFull := popStr(temp, '.');
  aHalf := temp;
  //handle cell 1868 and 1869
  if (cellID = 1043) and assigned(compCol) then
    begin
      fBathCell := compCol.GetCellByID(1868);
      hBathCell := compCol.GetCellByID(1869);
      if assigned(fBathCell) then
        fBathCell.SetText(Format('%d',[StrToIntDef(aFull, 0)]));
      if assigned(hBathCell) then
        hBathcell.SetText(Format('%d',[StrToIntDef(aHalf, 0)]));
    end;
  if HasOnlyDecDigits(tmpStr) and (Length(tmpStr) < 5) then
    begin
      PosIdx := Pos('.', tmpStr);
      if (PosIdx = 0) then
        tmpStr := tmpStr + '.0'
      else
        begin
          // If more than 9 half baths flag it as an error. Most likely
          //  the incoming data is '25', '50' or '75' signaling 1/4, 1/2
          //  or 3/4 and not UAD format.
          HBaths := Round(GetValidNumber(Copy(tmpStr, Succ(PosIdx), Length(tmpStr))));
          if HBaths > 9 then
            exit;
          tmpStr := Copy(tmpStr, 1, Pred(PosIdx)) + '.' + IntToStr(HBaths);
        end;

      if (cellID = 1043) and assigned(compCol) then
        theCell := compCol.GetCellByID(1043);
      if not assigned(theCell) then exit;
      // Set formatting to ensure that '1.1' does not show as '1.10'
      if (PosIdx = 0) or (round(GetValidNumber(Copy(tmpStr, Succ(PosIdx), Length(tmpStr)))) < 9) then
        begin
          theCell.FCellFormat := ClrBit(theCell.FCellFormat, bRnd1P2);    //clear round to 0.01
          theCell.FCellFormat := SetBit(theCell.FCellFormat, bRnd1P1);    //round to 0.1
        end
      else
        begin
          theCell.FCellFormat := ClrBit(theCell.FCellFormat, bRnd1P1);   //clear round to 0.1
          theCell.FCellFormat := SetBit(theCell.FCellFormat, bRnd1P2);   //round to 0.01
        end;
    end
   else
     begin
       theCell.FCellFormat := SetBit(theCell.FCellFormat, bRnd1P1);    //round to 0.1
       if tmpStr <> '' then
         result := tmpStr;
       exit; // validation error detected
     end;
   if tmpStr <> '' then
     result := tmpStr;

   if (aCompID = 0) and FOverwriteData then //this is the subject
     begin
       FDoc.SetCellTextByID(231, result);
     end;
end;

//github 999
function TUADObject.TranslateCondition(compCol: TCompColumn; Str: String):String;
var
  UADAltCell: TBaseCell;
  aTmpStr, aStr: String;
  aCompID, idx: Integer;
  aChar: String;
begin
  result := Str;
  aCompID := -999;
  str := trim(str);
  if assigned(compCol) then
    aCompID := compCol.FCompID;
  aTmpStr := upperCase(str);

  if (length(str) = 2) and (pos('C', aTmpStr) > 0)  and (aCompID > 0) then exit;

  if (pos('ALMOST NEW', aTmpStr) > 0) or
     (pos('RENOVATED', aTmpStr) > 0) or
     (pos('NO REPAIR', aTmpStr) > 0) or
     (pos('VERY GOOD', aTmpStr) > 0) then
    result := 'C2'
  else if (pos('NEW', aTmpStr) > 0) or
     (pos('RECENTLY CONST', aTmpStr)>0) or
     (pos('OCCUPIED', aTmpStr)>0) or
     (pos('EXCELLENT', aTmpStr)>0) or
     (pos('SUPER', aTmpStr) >0) then
    result := 'C1'
  else if (pos('WELL MAINT', aTmpStr) > 0) or
     (pos('DEPRECIATION', aTmpStr) > 0) or
     (pos('UPDATE',aTmpStr) > 0) or
     (pos('GOOD', aTmpStr) > 0) then
    result := 'C3'
  else if (pos('ADEQUATELY MAINT', aTmpStr) > 0) or
     (pos('MINIMAL REPAIR', aTmpStr)>0) or
     (pos('MINIMAL UPDATE', aTmpStr)>0) or
     (pos('AVERAGE', aTmpStr) >0) or
     (pos('AVG', aTmpStr) >0) then
    result := 'C4'
  else if (pos('POORLY MAINT', aTmpStr) > 0) or
     (pos('SIGNIFICANT REPAIR', aTmpStr) >0) or
     (pos('POOR', aTmpStr) >0) then
    result := 'C5'
  else if (pos('SERV', aTmpStr) > 0) or
    (pos('DAMAGE', aTmpStr)>0) or
    (pos('SUBSTANTIAL REPAIR', aTmpStr)>0) then
    result := 'C6'
  else if (pos('C', aTmpStr) > 0) and (length(aTmpStr) <=2) then
    begin
      if AnsiIndexText(aTmpStr, ConditionListTypCode) < 0 then
        exit;
      result := aTmpStr;
    end;
  if acompID = 0 then //this is subject cell, update condition 520 on page 1
    begin
      aTmpStr := FDoc.GetCellTextByID(520);
      if aTmpStr <> '' then
        begin
          if pos(result, aTmpStr) = 0 then //if no condition in the cell, add it
            begin
              aChar := aTmpStr[1];
              if pos('C', upperCase(aChar)) > 0 then
                begin
                  idx := pos(vSeparator, aTmpStr);
                  if idx = 3 then
                    begin  //found Cx in the cell 520, replace with the new one
                      aChar := popStr(aTmpSTr, vSeparator);
                      aStr := Format('%s%s%s',[result,vSeparator,aTmpStr]);
                      if FOverwriteData then
                        FDoc.SetCellTextByID(520, aStr);
                    end;
                end
              else  //Cx not found in the cell 520, add it in
                begin
                  aTmpStr := Format('%s%s%s',[result,vSeparator,aTmpStr]);
                  if FOverwriteData then
                    FDoc.SetCellTextByID(520, aTmpStr);
                end;
            end;
        end
      else if FOverwriteData then
        FDoc.SetcellTextByID(520, result);  //set condition to the comment field
    end;

end;

function TUADObject.TranslateQuality(Str:String):String;
var
  atmpStr: String;
begin
  result := Str;
  atmpStr := UpperCase(Str);
  if (pos('EXCEPTIONAL', atmpStr) > 0) or
      (pos('SUPERIOR', atmpStr) > 0) then
    result := 'Q1'
  else if (pos('HIGH', atmpStr) > 0) or
    (pos('VERY GOOD', atmpStr) > 0) then
    result := 'Q2'
  else if (pos('ABOVE', atmpStr) > 0) or
      (pos('GOOD', atmpStr) > 0) then
    result := 'Q3'
  else if (pos('BELOW', atmpStr) > 0) or
    (pos('BELOW AVG', aTmpStr) > 0) or
    (pos('BELOW AVERAGE', aTmpStr) >0) then
    result := 'Q5'
  else if (pos('STANDARD', atmpStr) > 0) or
    (pos('STD', aTmpStr) > 0) or
    (pos('AVERAGE', aTmpStr) > 0) or
    (pos('AVG', aTmpStr) > 0) then
    result := 'Q4'
  else if (pos('LOW', atmpStr) > 0) or
    (pos('POOR', atmpStr) > 0) then
    result := 'Q6'
else if (pos('Q', atmpStr) > 0) and (length(atmpStr) <= 2) then
    begin
      AnsiIndexText(atmpStr, QualityListTypCode);
      result := atmpStr;
    end;
end;


//For Fannimie Rule: we need to have ##.## miles NW or SE to make it more specific
//only show in miles for now
function TUADObject.TranslateProximity(str: String):String;
begin
  if str <> '' then
    result := Format('%s miles',[str]);
end;

function TUADObject.TranslatePool(CompCol: TCompColumn; str: String):String;
var
  aCompID: Integer;
begin
  aCompID := -999;
  if assigned(CompCol) then
    aCompID := CompCol.FCompID;

  if str = '' then
    result := ''
  //else if GetValidInteger(str) = 0 then
   // result := 'None'                        //github 283
  else
    result := str;

  if aCompID = 0 then //this is the subject; write the value back to page 1:339: check box 340 pool count
    begin
      if (pos('No', str) > 0) and FOverwriteData then
        begin
          FDoc.SetCellTextByID(339, '');
          FDoc.SetCellTextByID(340, result);
        end
      else if FOverwriteData then
        begin
          FDoc.SetCellTextByID(339, 'X');
          FDoc.SetCellTextByID(340, result);
        end
       else if not FOverwriteData and (pos('No', str) > 0) then    //github 411
        begin
          FDoc.SetCellTextByID(339, '');
          FDoc.SetCellTextByID(340, result);
        end
        else
          begin
            FDoc.SetCellTextByID(339, 'X');
            FDoc.SetCellTextByID(340, result);
          end
      end;
end;

function MakeHeatingCoolingShort(str: String):String;
var
  aStr, aStr1, aResult: String;
begin
  result := str;
  if compareText('None', str) = 0 then
    begin
      result := '';
      exit;  //donot set to None if empty
    end;
  if CompareText('Gas', str) = 0 then exit;
  if CompareText('Other', str) = 0 then exit;
  if pos(',', str) > 0 then
    str := popStr(str, ',');
  str := StringReplace(str, ' ', '%', [rfReplaceAll]);   //change space with %
  if pos('%',str) = 0 then exit;
  result := '';
  while length(str) > 0 do
    begin
      aStr := popStr(str, '%'); //pop out one word
      if length(aStr) > 0 then  //if we have it
        begin
          aStr1 := copy(aStr, 1, 1);    //get the first character
          if length(aStr1) > 0 then     //and put it in the result string
            result := result + aStr1;
        end;
    end;
end;


function TUADObject.translateLowHighPrice(str: String):String;
var
  aValue: Integer;
begin
  result := '';
  aValue := round(GetValidNumber(str));
  if aValue > 0 then
    result := Format('%d',[round(aValue/1000)]);
end;

//Appendix D: if empty put None
(*
function TUADObject.translateAPN(str: String): String;
begin
  result := str;
end;
*)

//str = heating/cooling combine, can be separated by , or by / or by -
//Appendix D: if no heating source, enter: None. if no cooling source, enter: Other
//heating = FWA, HWBB, Radiant, Fuel, other
//Cooling = Central AC, Individual, other
function TUADObject.translateHeatingCooling(CompCol: TCompColumn; str: String): String;
var
  idx: Integer;
  aHeating, aCooling, aTmp: string;
  aCell: TBaseCell;
  sCooling, sHeating, aMsg: String;
  isSubject:Boolean;
  aFuel: String;
begin
  result := '';  //initialize
  str := trim(str);
  aHeating := '';
  aCooling := '';
  aFuel := '';
  isSubject := False;
  if assigned(CompCol) then
    isSubject := CompCol.FCompID = 0;
  result := str;
  if pos('-', str) > 0 then
    str := StringReplace(str, '-', '/', [rfReplaceAll]);
  if pos(vSeparator, str) > 0 then
    str := StringReplace(str, vSeparator, '/', [rfReplaceAll]);

  if pos('/', str) > 0 then //we have both heating and cooling
    begin
      aTmp := popStr(str, '/');
      if pos(',', aTmp) > 0 then //we have heating and fuel
        begin
          if isSubject then
            begin
              aHeating := popStr(aTmp, ',');
              aFuel := aTmp;
            end;
        end
      else
        aHeating := atmp;

      aCooling := str;
      if pos('RAD', upperCase(aHeating)) > 0 then
        begin
          aHeating := 'Rad';
          if isSubject and FOverwriteData then
            begin
              if pos('Rad', aHeating) > 0 then
                Fdoc.SetCellTextByID(2023, 'X')
              else
                Fdoc.SetCellTextByID(2023, '');
            end;
        end
      else if pos('HWBB', upperCase(aHeating)) > 0 then
        begin
          aHeating := 'HWBB';
          if isSubject and FOverwriteData then
            begin
              if pos('HWBB', aHeating) > 0 then
                FDoc.SetCellTextByID(2022, 'X')
              else
                FDoc.SetCellTextByID(2022, '');
            end;
        end
      else if pos('FORCED AIR', upperCase(aHeating)) > 0 then
        begin
          aHeating := 'FAH';
        end
      else if (pos('GAS FORCED WARMED AIR', upperCase(aHeating)) > 0) or
                (pos('GFWA', aHeating) > 0) then    //github 375
      begin
        aHeating := 'GFWA';
        if isSubject and FOverwriteData then
          begin
            if pos('GFWA', aHeating) > 0 then
            begin
              Fdoc.SetCellTextByID(2024, 'X');
              Fdoc.SetCellTextByID(2026, 'GFWA');
            end
            else
              Fdoc.SetCellTextByID(2024, '');
          end;
      end
      else if pos('FWA', uppercase(aHeating)) > 0 then
        begin
          aHeating := 'FWA';
          if isSubject and FOverwriteData then
            begin
              if pos('FWA', aHeating) > 0 then
                FDoc.SetCellTextByID(2021, 'X')
              else
                FDoc.SetCellTextByID(2021, '');
            end;
        end;

      if (aHeating <> '') then
        aHeating := MakeHeatingCoolingShort(aHeating)
      else
        aHeating := '';

      result := aHeating;

      if (pos('CENTRAL AIR CONDITIONING', UpperCase(aCooling)) > 0) or
            (pos('CAC', UpperCase(aCooling)) > 0) then     //github 375
      begin
        aCooling := 'CAC';
        if isSubject and FOverwriteData then
          begin
            if pos('CAC', aCooling) > 0 then
            begin
              FDoc.SetCellTextByID(2644, 'X');
              FDoc.SetCellTextByID(293, 'CAC');
            end
            else
              FDoc.SetCellTextByID(2644, '');
          end;
      end
      else if (pos('CENTRAL', upperCase(aCooling)) > 0) or
            (pos('AC', upperCase(aCooling)) > 0) then
        begin
          aCooling := 'AC';
          if isSubject and FOverwriteData then
            begin
              if pos('AC', aCooling) > 0 then
                FDoc.SetCellTextByID(2658, 'X')
              else
                FDoc.SetCellTextByID(2658, '');
            end;
        end
      else if (pos('IND', UpperCase(aCooling)) > 0) or
                (pos('INDIVIDUAL', UpperCase(aCooling)) > 0) then
        begin
          aCooling := 'Ind';
          if isSubject and FOverwriteData then
            begin
              if pos('Ind', aCooling) > 0 then
                FDoc.SetCellTextByID(2025, 'X')
              else
                FDoc.SetCellTextByID(2025, '');
            end;
        end
      else if pos('AIR', UpperCase(aCooling)) > 0 then
        begin
          aCooling := 'Air';
          if isSubject and FOverwriteData then
            begin
              if pos('Air', aCooling) > 0 then
                FDoc.SetCellTextByID(2658, 'X')
              else
                FDoc.SetCellTextByID(2658, '');
            end;
        end;

       if (aCooling <> '') then
           aCooling := MakeHeatingCoolingShort(aCooling)
          else
           aCooling := '';
      if (aHeating <> '') then
        result := aHeating;
      if aCooling <> '' then
        begin
          if result = '' then
            result := aCooling
          else
            result := result + '/'+aCooling;  //only show / if have both
        end
      else if aHeating <> '' then
        result := aHeating;
    end
  else //only one item
    begin
      aTmp := upperCase(str);
      if pos(',', aTmp) > 0 then
        begin
          if isSubject then
            begin
              aTmp := popStr(str, ',');
              aFuel := str;
            end;
        end
      else
        aHeating := aTmp;

      if (pos('RADIANT', aTmp) > 0) or
            (pos('RAD', aTmp) > 0) then
        begin
          result := 'Rad';
          if isSubject and FOverwriteData then
            begin
              if pos('Rad', result) > 0 then
                Fdoc.SetCellTextByID(2023, 'X')
              else
                FDoc.SetCellTextByID(2023, '');
            end;
        end
      else if pos('HWBB', aTmp) > 0 then
        begin
          result := 'HWBB';
          if isSubject and FOverwriteData then
            begin
              if pos('HWBB', result) > 0 then
                FDoc.SetCellTextByID(2022, 'X')
              else
                FDoc.SetCellTextByID(2022, '');
            end;
        end
      else if (pos('FWA', aTmp) > 0) or
                (pos('FORCED', aTmp) > 0) or
                (pos('FORCED AIR', aTmp) > 0) then
        begin
          result := 'FWA';
          if isSubject and FOverwriteData then
            begin
              if pos('FWA', result) > 0 then
                FDoc.SetCellTextByID(2021, 'X')
              else
                FDoc.SetCellTextByID(2021, '');
            end;
        end
      else if pos('CENTRAL', aTmp) > 0 then
        begin
          result := 'AC';
          if isSubject and FOverwriteData then
            begin
              if pos('Central', result) > 0 then
                FDoc.SetCellTextByID(2658, 'X')
              else
                FDoc.SetCellTextByID(2658, '');
            end;
        end
      else if pos('IND', aTmp) > 0 then
        begin
          result := 'Ind';
          if isSubject and FOverwriteData then
            begin
              if pos('Ind', result) > 0 then
                FDoc.SetCellTextByID(2025, 'X')
              else
                FDoc.SetCellTextByID(2025, '');
            end;
        end
      else if pos('AIR', aTmp) > 0 then
        begin
          result := 'Air';
          if isSubject and FOverwriteData then
            begin
              if pos('Air', result) > 0 then
                FDoc.SetCellTextByID(2658, 'X')
              else
                FDoc.SetCellTextByID(2658, '');
            end;
        end
      else if pos('GAS', aTmp) > 0 then
        result := 'Gas'
      else
        result := str;
    end;
    if isSubject and (aFuel <> '') and FOverwriteData then
      FDoc.SetCellTextByID(288, aFuel);
end;


function AbbreviateInfl(str: String):String;
begin
  result := str;
  str := lowercase(str);
  if pos('neu', str) > 0 then
    result := 'N'
  else if pos('ben', str) > 0 then
    result := 'B'
  else if pos('adv', str) > 0 then
    result := 'A'
  else if length(str) = 1 then
    result := upperCase(str);
end;


function TUADObject.translateSubjectViewInfl(compCol: TCompColumn; str: String): String;
var
  aViewInfl, aViewFactor1, aViewFactor2: String;
  compID: Integer;
begin
  result := str;
  if str = '' then exit;
  if assigned(compCol) then
    CompID := compCol.FCompID;
  if pos(';', str) > 0 then  //only pop when we have ;
    begin
      aViewInfl := popStr(str, ';');
      aViewInfl := abbreviateInfl(aViewInfl);
    end;
  if pos(';', str) > 0 then
    begin
      aViewFactor1 := popStr(str, ';');
      aViewFactor2 := popStr(str, ';');
    end;
  if pos('other', lowercase(aViewFactor1)) = 0 then
      aViewFactor1 := abbreviateViewFactor(aViewFactor1)
  else
    aViewFactor1 := str;

  if pos('other', lowercase(aViewFactor2)) = 0 then
      aViewFactor2 := abbreviateViewFactor(aViewFactor2)
  else
    aViewFactor2 := str;
  if aViewInfl <> '' then
    begin
      result := Format('%s;%s;%s',[aViewInfl, aViewFactor1, aViewFactor2]);
    end
  else
    result := Format(';%s;',[abbreviateViewFactor(str)]);

  if (CompID = 0) and FOverwriteData then
    begin //this is subject
      FDoc.SetCellTextByID(90, result);
      FDoc.SetCellTextByID(984, result);
    end;
end;


function AbbreviateLocFactor(str: String):String;
begin
  result := str;  // if nothing match, use the original string coming in
  str := lowercase(str);
  if pos('resi', str) > 0 then
    result := 'Res'
  else if pos('ind', str) > 0 then
    result := 'Ind'
  else if pos('comm', str) > 0 then
    result := 'Comm'
  else if pos('busy', str) > 0 then
    result := 'BsyRd'
  else if pos('water', str) > 0 then
    result := 'WtrFr'
  else if pos('golf', str) > 0 then
    result := 'GlfCse'
  else if pos('adjacent to park', str) > 0 then
    result := 'AdjPark'
  else if pos('adjacent to power', str) > 0 then
    result := 'AdjPwr'
  else if pos('land', str) > 0 then
    result := 'Lndfl'
  else if pos('public', str) > 0 then
    result := 'PubTrn'
  else if pos('other', str) > 0 then
    result := 'Other';
end;


function TUADObject.translateSubjectLocInfl(compCol: TCompColumn; str: String): String;
var
  aLocInfl, aLocFactor1, aLocFactor2: String;
  aChar: String;
begin
  result := str;
  if str = '' then exit;

  aLocInfl := popStr(str, ';');
  aLocInfl := abbreviateInfl(aLocInfl);

  aLocFactor1 := popStr(str, ';');
  aLocFactor2 := popStr(str, ';');

  if pos('other', lowercase(aLocFactor1)) = 0 then
    aLocFactor1 := abbreviateLocFactor(aLocFactor1)
  else
    aLocFactor1 := str;

  if pos('other', lowercase(aLocFactor2)) = 0 then
    aLocFactor2 := abbreviateLocFactor(aLocFactor2)
  else
    aLocFactor2 := str;

  result := Format('%s;%s;%s',[aLocInfl, aLocFactor1, aLocFactor2]);
end;

function TUADObject.translateSubjectTax(str: String): String;
var
  aFloat: Double;
begin
  result := str;
  if str <> '' then
    begin
      aFloat := StrToFloatDef(str, 0);
      result := FormatFloat('#,###', aFloat);
    end;

end;

//github 237: cell #2056: format: saletype;salesanalysis comment
function TUADObject.TranslateUADCell2056(str: String):String;
var
  aSaleType, aComment: String;
begin
  result := str;
  if pos(vSeparator, str) > 0 then //we have
    begin
      aSaleType := popStr(str, vSeparator);
      if pos('REO', upperCase(aSaleType)) > 0 then
        result := 'REO sale'
      else if pos('SHORT', upperCase(aSaleType)) > 0 then
        result := 'Short sale'
      else if pos('COURT', upperCase(aSaleType)) > 0 then
        result := 'Court ordered sale'
      else if pos('ESTATE', upperCase(aSaleType)) > 0 then
        result := 'Estate sale'
      else if pos('RELOCATION', upperCase(aSaleType)) > 0 then
        result := 'Relocation sale'
      else if pos('NON-ARM', uppercase(aSaleType)) > 0 then
        result := 'Non-arms length sale'
      else if pos('ARMS', upperCase(aSaleType)) > 0 then
        result := 'Arms length sale'
    end;
  aComment := str;
  if result <> '' then
    result := result + vSeparator + aComment
  else //not a purchase transaction
    result := aComment;
end;

//github 237: cell #2057: format: amount;unk;comment
function TUADObject.TranslateUADCell2057(str: String):String;
var
  aAmount, aUnk, aComment: String;
  iAmount: Integer;
begin
  result := str;
  if pos(UADUnkFinAssistance, str) > 0 then exit;
  if pos(vSeparator, str) = 0 then exit;
  if pos(vSeparator, str) > 0 then //we have
    begin
      aAmount := popStr(str, vSeparator);
      iAmount := GetValidInteger(aAmount);
      if (iAmount >= 0) and (aAmount <> '') then
        result := Format('$%d',[iAmount]);
    end;
   //look for the second separator
  if pos(vSeparator, str) > 0 then
    begin
      aUnk := popStr(str, vSeparator);
      if pos('UNK', upperCase(aUnk))>0 then
        aUnk := UADUnkFinAssistance;
      if (aUnk <> '') and (result <> '') then
        result := result + vSeparator + aUnk +vSeparator
      else if aUnk <> '' then
        result := aUnk + vSeparator
    end
  else
    begin
      if result <> '' then
        result := result + vSeparator
    end;


  if (str <> '') and (aUnk='') then //this is comment
    result := result + vSeparator + str
  else if str <> '' then
    result := result + str;
end;

function TUADObject.TranslateAge(compCol: TCompColumn; str: String):String;
var
  CompNo: Integer;
  age, yrBuilt: Integer;
  effDate, aYrBuilt: String;
begin
  result := str;
  if assigned(compCol) then
    CompNo := compCol.FCompID;
  case CompNo of
    0: //this is subject
      begin
        age := GetValidInteger(str);
        yrBuilt := 0;
        if age > 0 then
           begin
             //for subject, use effective year
             effDate := FDoc.GetCellTextByID(1132);  //1132=eff date
             if length(effDate) > 0 then
               yrBuilt := YearOf(StrToDate(effDate)) - age
             else
               yrBuilt := YearOf(Date) - age;  //current year - actual age
             aYrBuilt := Format('%d',[yrBuilt]);
             if FOverwriteData then
               doc.SetCellTextByID(151, aYrBuilt);
           end;
      end;
  end;
end;

function TUADObject.TranslateSubjectFeeSimple(compCol: TCompColumn; str: String):String;
var
  aTemp: String;
  aCompID: Integer;
begin
  aCompID := -999;
  aTemp := upperCase(str);
  if assigned(compCol) then
    aCompID := CompCol.FCompID;
  if pos('FEE', aTemp) > 0 then
    begin
      result := 'Fee Simple';
      if (aCompID = 0) and FOverwriteData then //this is subject, update cell 54 in page 1
        FDoc.SetCellTextByID(54, 'X');
    end
  else if pos('LEASE', aTemp) > 0 then
    begin
      result := 'Leasehold';
      if (aCompID = 0) and FOverwriteData then //this is the subject, update cell 55 in page 1
        FDoc.SetCellTextByID(55, 'X');
    end
  else
    result := str;
end;

function TUADObject.TranslateSubjectGLA(compCol: TCompColumn; str: String):String;
var
  aTemp: String;
  aCompID: Integer;
  iGLA: Integer;
begin
  result := str; iGLA := 0;
  if str = '' then exit;
  aCompID := -999;
  if assigned(compCol) then
    aCompID := CompCol.FCompID;
  iGLA := GetValidInteger(str);
  if aCompID = 0 then
    begin
      aTemp := Format('%d',[iGLA]); //total room goes to cell 229 on page 1
      if FOverwriteData then
        begin
          FDoc.SetCellTextByID(232, aTemp);
          FDoc.SetCellTextByID(1004, aTemp);
        end;
    end;
end;

//if it's subject on cell 1018, populate to 332,333 for porch and 334, 335 for patio
{
function TUADObject.TranslatePorchPatio(compCol: TCompColumn; str: String):String;
var
 // aPorch, aPatio: String;
  aCompID: Integer;
  iPorch, iPatio: Integer;
  setPorch, setPatio: Boolean;
begin
  result := str; setPorch := False; setPatio := False;
  aCompID  := -999; iPorch :=0; iPatio:=0;
  if assigned(compCol) then
    aCompID := compCol.FCompID;
  (*
  //input format: porch/patio
  if pos('/', str) > 0 then //we have both porch and patio
    begin
      aPorch := popStr(str, '/');
      aPatio := str;
    end
  else //this is porch
    aPorch := str;
  //input format: porch, patio  GitHub 371
  if pos(',', str) > 0 then //we have both porch and patio
    begin
      aPorch := popStr(str, ',');
      aPatio := str;
    end
  else //this is porch
    aPorch := str;
  *)
  if (pos('Porch', str) > 0) then    //GitHub 371
    begin
      iPorch := GetValidInteger(str);
      if iPorch = 0 then
        iPorch := 1;
    end
  else if (pos('Patio', str) > 0) or (pos('Deck', str) > 0) then
    begin
      iPatio := GetValidInteger(str);
      if iPatio = 0 then
        iPatio := 1;
    end;
  //look for any integers in the string  GitHub 371
  if (pos('Porch', str) > 0) then
    begin
      iPorch := GetValidInteger(str);
      if iPorch = 0 then
        iPorch := 1;
    end
  else if (pos('Patio', str) > 0) or (pos('Deck', str) > 0) then
    begin
      iPatio := GetValidInteger(str);
      if iPatio = 0 then
        iPatio := 1;
    end;

  if (iPorch > 0) and (iPatio >0) then
    begin
      //result := Format('Porch/%d,Patio,Deck/%d',[iPorch, iPatio]);
      result := str; //github 371
      if aCompID = 0 then
        begin
          setPorch := True;
          setPatio := True;
        end;
    end
  else if iPorch > 0 then //we have porch
    begin
      //result := Format('Porch/%d',[iPorch]);
      result := str; //github 371
      if aCompID = 0 then
        setPorch := True;
    end
  else if iPatio > 0 then //we have patio
    begin
     // result := Format('Patio,Deck/%d',[iPatio]);
      result := str; //github 371
      if aCompID = 0 then
        setPatio := True;
    end
  else //no porch and no patio
    result := str; //github 371

  //do we need to update cell 332, 333 for porch and 334, 335 for patio for the subject page 1
  if setPatio and FOverwriteData then
    begin
      FDoc.SetCellTextByID(332, 'X');
      str := Format('%d',[iPatio]);
      FDoc.SetCellTextByID(333, str);
    end;
  if setPorch and FOverwriteData then
    begin
      FDoc.SetCellTextByID(334, 'X');
      str := Format('%d',[iPorch]);
      FDoc.SetCellTextByID(335, str);
    end;
//Github #371: Empty Porch Should not say None
//  if length(str) = 0 then
//    result := 'None';    //github 371
end;
}


function TUADObject.TranslatePorchPatio(compCol: TCompColumn; str: String):String;
var
 // aPorch, aPatio: String;
  aCompID: Integer;
  iPorch, iPatio: Integer;
  setPorch, setPatio: Boolean;
  aCell: TBaseCell;
begin
  result := str;
(*  result := str; setPorch := False; setPatio := False;
  aCompID  := -999; iPorch :=0; iPatio:=0;
  if assigned(compCol) then
    aCompID := compCol.FCompID;
  //github #471:
  //if not check on patio 332, and EMPTY on patio description 333 then empty
  //if not check on patio 332, and None on patio description 333 then say Patio,Deck/None
  //if check on patio 332, and not EMPTY on patio description 333 then Patio,Deck/description
 if aCompID <= 0 then  //this is the subject
  begin
    if FDoc.GetCellTextByID(332) = 'X' then
      result := str
    else
      begin
        if pos('NONE', upperCase(str)) > 0 then
          result := str
        else
          result := '';  //leave it EMPTY
      end;
  end;

*)


end;


function TUADObject.TranslateSubjectTotalRooms(compCol: TCompColumn; cellID: Integer; str: String):String;
var
  aTemp: String;
  aCompID: Integer;
  iRoom: Integer;
begin
  result := str;
  if str = '' then exit;
  aCompID := -999;
  if (cellID = 1041) and (compCol <> nil) then
    aCompID := CompCol.FCompID;
  iRoom := GetValidInteger(str);
  if (aCompID = 0) and FOverwriteData then
    begin
      aTemp := Format('%d',[iRoom]); //total room goes to cell 229 on page 1
      FDoc.SetCellTextByID(229, aTemp);
      FDoc.SetCellTextByID(1041, aTemp);
    end;
end;

function TUADObject.TranslateSubjectBedRooms(compCol: TCompColumn; cellID: Integer; str: String):String;
var
  aTemp: String;
  aCompID: Integer;
  iRoom: Integer;
begin
  result := str;
  if str = '' then exit;
  aCompID := -999;
  if (cellID = 1042) and (compCol <> nil) then
    aCompID := CompCol.FCompID;
  iRoom := GetValidInteger(str);
  if (aCompID = 0) and FOverwriteData then
    begin
      aTemp := Format('%d',[iRoom]); //total room goes to cell 230 on page 1
      FDoc.SetCellTextByID(230, aTemp);
      FDoc.SetCellTextByID(1042, aTemp);
    end;
end;

function TUADObject.TranslateSubjectFoundation(str: String):String;
begin
  result := str;
end;

function TUADObject.translateStateAbbreviation(compCol: TCompColumn; cellID:Integer; str:String):String;
begin
  result := str;
  if str = '' then exit;
  result := translateState(str);
end;

//
//**********************   MAIN CALLS   **************************//
//
function TUADObject.TranslateToUADFormat(compCol: TCompColumn; cellID: Integer; str:String; Overwrite:Boolean=True):String;
var
  aMsg: String;
begin
  try
    FOverwriteData := Overwrite;
    str := StringReplace(str, '|', ';', [rfReplaceAll]);  //make sure we replace '|' with ';'

    case cellID of
           48: result := translateStateAbbreviation(nil, cellID, str);
           67: result := translateSiteArea(nil, cellID, str);
           90: result := translateSubjectViewInfl(nil, str);
          148: result := translateSubjectStories(str);
          173: result := translateSubjectFoundation(str);
          368: result := translateSubjectTax(str);  //github 169
          520: result := translateSubjectCondition(str);
          964: result := translateSubjectFeeSimple(compCol, str);
          996: result := translateAge(compCol, str);
          //723, 724, 742, 743, 754, 755: result := translateLowHighPrice(str); //convert price in thousands
          926: result := translateCityStZip(compCol, str); //for condo unit# required
          929: result := translateProximity(str);
          930: result := translateDataSourceDOM(str);
          956: result := translateSalesConcession(str);
          958: result := translateFinanceConcession(compCol, str);
          960: result := translateSettleDate(str);       //settle/contract date
          962: result  := translateSubjectLocInfl(CompCol, str);
          976: result := translateSiteArea(compCol, cellID, str);                  //site area
          984: result := translateSubjectViewInfl(CompCol, str);
          986: result := translateDesign(compCol, str);
          149: result := translateSubjectDesign(compCol, str);
          994: result := translateQuality(str);
          998: result := translateCondition(compCol, str);        //condition
     {232,}1004: result := translateSubjectGLA(compCol, str);      //basement GLA and finish area
         1006: result := translateBasementGLA(compCol, str);      //basement GLA and finish area
         1008: result := translateBasementRooms(compCol,str);     //basement rec room, bed, bath, and others
 //        1012: result := translateHeatingCooling(compCol, str);
         1016: result := translateGargageCarport(compCol, str);
//         1018: result := translatePorchPatio(compCol, str);
         1020: result := translateFireplace(compCol, str);
         1022: result := translatePool(compCol, str);
     {229,}1041: result := translateSubjectTotalRooms(compCol, cellID, str);
     {230,}1042: result := translateSubjectBedRooms(compCol, cellID, str);
     {231,}1043: result := TranslateFullHalfBath(CompCol, CellID, str);  //Full/half bath
         //2065: result := translateSubjectDataSource2(str);                //Data Source
      else
         result := str;
  end;
  except on E:Exception do
    begin
      aMsg := Format('There''s a problem in converting to UAD format: cell: %d, text: %s',
              [CellID, str]);
      shownotice('TranslateToUADFormat: '+ aMsg + ' ==> '+e.Message);
    end;
  end;
end;

end.
