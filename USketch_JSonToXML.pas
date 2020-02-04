unit USketch_JSonToXML;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,msxmldom,Math,
  uLKJSON, XMLDoc, Dialogs,XMLIntf,xmldom;

  function ParseSketchLines(joSketch: TlkJSonBase): String;
  function ParseSketchAreas(joSketch: TlkJSonBase): String;
  function ParseSketchTexts(joSketch: TlkJSonBase): String;
  function ConvertJSONToXML(joSketch: TlkJSonBase; pageNo: Integer; AreaList:TStringList):String;

var
 FLog: TStringList;

implementation
uses
  UUtil1,uUtil2, uStatus, uGlobals;

const
  cSketchFileName     = 'TempSketch.xml';      //this is file AS looks for on startup, if from previous sketch


var
    FSketchDir:String;


function GetJsonString(aFieldName:String; js: TlkJsonObject):String;
begin
  result := '';
  if not (js.Field[aFieldName] is TLKJSONnull) then
    if js.Field[aFieldname] is TlkJSONString then
      result := js.GetString(aFieldName);
end;

function GetJsonInt0(aFieldName:String; js: TlkJsonObject):Integer;
begin
  result := 0;
  if not (js.Field[aFieldName] is TLKJSONnull) then
    if js.Field[aFieldname] is TlkJSONnumber then
      result := js.GetInt(aFieldName);
end;

function GetJsonBool(aFieldName:String; js:TlkJsonObject):Boolean;
var
  aBool: Boolean;
begin
  result := False;
  if not (js.Field[aFieldName] is TLKJSONnull) then
    if js.Field[aFieldname] is TlkJSONboolean then
      begin
        aBool := js.getBoolean(aFieldname);
        result := aBool;
      end;
end;

function GetJsonDouble(aFieldName:String; js: TlkJsonObject):Double;
begin
  result := 0;
  if not (js.Field[aFieldName] is TLKJSONnull) then
    if js.Field[aFieldname] is TlkJSONnumber then
      result := js.getDouble(aFieldName);
end;

function GetJsonCoordinate(aFieldName:String; js: TlkJsonObject; var X,Y:Double):Boolean;
var
  jCoord: TlkJSonBase;
begin
  result := True;
  jCoord := js.Field[aFieldName];
  if (not (jCoord.Field['X'] is TLKJSONnull)) and  (not (jCoord.Field['Y'] is TLKJSONnull)) then
    begin
      if jCoord.Field['X'] <> nil then
        X := jCoord.Field['X'].Value;
      if jCoord.Field['Y'] <> nil then
        Y := jCoord.Field['Y'].Value;
    end;
end;

function BoolToStr(aBool:Boolean):String;
begin
  if aBool then
    result := 'True'
  else
    result := 'False';
end;



function ParseSketchLines(joSketch: TlkJSonBase): String;
var
  jSketch, jLines, jLine: TlkJSonBase;
  joLine: TlkJSonObject;
  i,j: Integer;
  SketchData, LinesData:String;
  X,Y: Double;
  sl:TStringList;
  jCoord: TlkJSonBase;
  aInt: Integer;
  aBool: Boolean;
  aBoolStr, aStr: String;
  aDouble: Double;
begin
  if joSketch.Field['Sketcher_Definition_Data'] <> nil then
    jSketch := joSketch.Field['Sketcher_Definition_Data'];
  sl := TStringList.create;
  try
    for i:= 0 to jSketch.Count -1 do
      begin
        joSketch := jSketch.Child[i] as TlkJSONObject;  //get each comp
        if joSketch = nil then continue;
        jLines := joSketch.Field['Lines'];
        if jLines <> nil then
         for j:= 0 to jLines.Count -1 do
          begin
            jLine := jLines.Child[j];
            joLine := jLine as TlkJSONObject;  //get each comp

            aStr := GetJsonString('Id', joLine);
            sl.Add('ID = '+aStr);

            aStr := GetJsonString('DimensionTextId', joLine);
            sl.Add('DimensionTextID = '+ aStr);

            //For Start X, Y
            GetJsonCoordinate('Start', joLine, X, Y);
            sl.Add(Format('Start: X=%8.2f,Y=%8.2f',[X,Y]));

            //For End X, Y
            GetJsonCoordinate('End', joLine, X, Y);
            sl.Add(Format('End: X=%8.2f,Y=%8.2f',[X,Y]));

            //For InitialStart X, Y
            GetJsonCoordinate('InitialStart', joLine, X, Y);
            sl.Add(Format('InitialStart: X=%8.2f,Y=%8.2f',[X,Y]));

            //For InitialEnd X, Y
            GetJsonCoordinate('InitialEnd', joLine, X, Y);
            sl.Add(Format('InitialEnd: X=%8.2f,Y=%8.2f',[X,Y]));

            //For values
            aBoolStr := BoolToStr(GetJsonBool('IsUsed', joLine));
            sl.Add('IsUsed = '+aBoolStr);

            aBoolStr := BoolToStr(GetJsonBool('IsArc', joLine));
            sl.Add('IsArc = '+aBoolStr);

            aDouble := GetJsonDouble('LengthFt', joLine);
            sl.Add(Format('LengthFt = %8.2f',[aDouble]));

            aDouble := GetJsonDouble('HeightFt', joLine);
            sl.Add(Format('HeightFt = %8.2f',[aDouble]));

            aDouble := GetJsonDouble('RadiusFt', joLine);
            sl.Add(Format('RadiusFt = %8.2f',[aDouble]));

            aBoolStr := BoolToStr(GetJsonBool('IsArcRotated', joLine));
            sl.Add('IsArcRotated = '+aBoolStr);

            aInt := GetJsonint0('ArcAngle', joLine);
            sl.Add(Format('ArcAngle = %d',[aInt]));

            aInt := GetJsonint0('LineAngle', joLine);
            sl.Add(Format('LineAngle = %d',[aInt]));

            aBoolStr := BoolToStr(GetJsonBool('InverseRotation', joLine));
            sl.Add('InverseRotation = '+aBoolStr);

            aBoolStr := BoolToStr(GetJsonBool('IsHorizontal', joLine));
            sl.Add('IsHorizontal = '+aBoolStr);

            aBoolStr := BoolToStr(GetJsonBool('IsVertical', joLine));
            sl.Add('IsVertical = '+aBoolStr);

            sl.add(' ');

          end;
      end;
  finally
    result := sl.Text;
    sl.Free;
  end;
end;

function ParseSketchAreas(joSketch: TlkJSonBase): String;
var
  jSketch, jAreas, jEdgeIds, jEdges, js: TlkJSonBase;
  joEdgeIds,joEdges: TlkJSonObject;
  i,j,k,l: Integer;
  SketchData, LinesData:String;
  X,Y: Double;
  sl:TStringList;
  jCoord: TlkJSonBase;
  aInt: Integer;
  aBool: Boolean;
  aBoolStr, aStr: String;
  aDouble: Double;
  aCount: Integer;
begin
  if joSketch.Field['Sketcher_Definition_Data'] <> nil then
    jSketch := joSketch.Field['Sketcher_Definition_Data'];
  sl := TStringList.create;
  try
    for i:= 0 to jSketch.Count -1 do
      begin
        joSketch := jSketch.Child[i] as TlkJSONObject;  //get each comp
        if joSketch = nil then continue;
        jAreas := joSketch.Field['Areas'];
        if jAreas <> nil then
         for j:= 0 to jAreas.Count -1 do
          begin
            jEdges := jAreas.Child[j].Field['Edges'];
            if jEdges <> nil then
              for k:= 0 to jEdges.Count - 1 do
                begin //handle EdgeIds
                  joEdges := jEdges.Child[k] as TlkJSonObject;
                  aStr := GetJsonString('Id', joEdges);
                  sl.Add('ID = '+aStr);
                  aStr := GetJsonString('DimensionTextId', joEdges);
                  sl.Add('DimensionTextID = '+ aStr);
                  //For Start X, Y
                  GetJsonCoordinate('Start', joEdges, X, Y);
                  sl.Add(Format('Start: X=%8.2f,Y=%8.2f',[X,Y]));

                  //For End X, Y
                  GetJsonCoordinate('End', joEdges, X, Y);
                  sl.Add(Format('End: X=%8.2f,Y=%8.2f',[X,Y]));

                  //For InitialStart X, Y
                  GetJsonCoordinate('InitialStart', joEdges, X, Y);
                  sl.Add(Format('InitialStart: X=%8.2f,Y=%8.2f',[X,Y]));

                  //For InitialEnd X, Y
                  GetJsonCoordinate('InitialEnd', joEdges, X, Y);
                  sl.Add(Format('InitialEnd: X=%8.2f,Y=%8.2f',[X,Y]));

                  //For values
                  aBoolStr := BoolToStr(GetJsonBool('IsUsed', joEdges));
                  sl.Add('IsUsed = '+aBoolStr);

                  aBoolStr := BoolToStr(GetJsonBool('IsArc', joEdges));
                  sl.Add('IsArc = '+aBoolStr);

                  aDouble := GetJsonDouble('LengthFt', joEdges);
                  sl.Add(Format('LengthFt = %8.2f',[aDouble]));

                  aDouble := GetJsonDouble('HeightFt', joEdges);
                  sl.Add(Format('HeightFt = %8.2f',[aDouble]));

                  aDouble := GetJsonDouble('RadiusFt', joEdges);
                  sl.Add(Format('RadiusFt = %8.2f',[aDouble]));

                  aBoolStr := BoolToStr(GetJsonBool('IsArcRotated', joEdges));
                  sl.Add('IsArcRotated = '+aBoolStr);

                  aInt := GetJsonint0('ArcAngle', joEdges);
                  sl.Add(Format('ArcAngle = %d',[aInt]));

                  aInt := GetJsonint0('LineAngle', joEdges);
                  sl.Add(Format('LineAngle = %d',[aInt]));

                  aBoolStr := BoolToStr(GetJsonBool('InverseRotation', joEdges));
                  sl.Add('InverseRotation = '+aBoolStr);

                  aBoolStr := BoolToStr(GetJsonBool('IsHorizontal', joEdges));
                  sl.Add('IsHorizontal = '+aBoolStr);

                  aBoolStr := BoolToStr(GetJsonBool('IsVertical', joEdges));
                  sl.Add('IsVertical = '+aBoolStr);

                  sl.add(' ');

                end;

            jEdges := jAreas.Field['Edges'];
            if jEdges <> nil then
              begin//handle Edges
              end;

            sl.add(' ');

          end;
      end;
  finally
    result := sl.Text;
    sl.Free;
  end;
end;

function ParseSketchTexts(joSketch: TlkJSonBase): String;
var
  jSketch, jTexts : TlkJSonBase;
  joText: TlkJSonObject;
  i,j,k,l: Integer;
  SketchData, LinesData:String;
  X,Y: Double;
  sl:TStringList;
  jCoord: TlkJSonBase;
  aInt: Integer;
  aBool: Boolean;
  aBoolStr, aStr: String;
  aDouble: Double;
  aCount: Integer;
  isDimension: Boolean;
  Content: String;
begin
  if joSketch.Field['Sketcher_Definition_Data'] <> nil then
    jSketch := joSketch.Field['Sketcher_Definition_Data'];
  sl := TStringList.create;
  try
    for i:= 0 to jSketch.Count -1 do
      begin
        joSketch := jSketch.Child[i] as TlkJSONObject;  //get each comp
        if joSketch = nil then continue;
        jTexts := joSketch.Field['Texts'];
        if jTexts <> nil then
         for j:= 0 to jTexts.Count -1 do
          begin
            joText := jTexts.Child[j] as TlkJSonObject;
            aStr := GetJsonString('Id', joText);
            sl.Add('ID = '+aStr);
            isDimension := GetJsonBool('IsDimension', joText);
            Content := GetJSonString('Content', joText);
            sl.Add('Content = '+Content);

            sl.add(' ');

         end;
      end;
  finally
    result := sl.Text;
    sl.Free;
  end;
end;

function GetDirection(jEdges:TlkJSonBase; i: Integer; isArc:Boolean):String;
var
  joEdges:TlkJSonObject;
  Xs, Ys:Double;
  Xe, Ye: Double;
  X0, y0: Double;
begin
  try
    result := '';
    if jEdges = nil then exit;
    if i = -1 then  exit;

    joEdges := jEdges.Child[i] as TlkJSonObject;

    if joEdges.Field['Start'] <> nil then
      GetJsonCoordinate('Start', joEdges, Xs, Ys);
    if joEdges.Field['End'] <> nil then
      GetJsonCoordinate('End', joEdges, Xe, Ye);

    if Xe - Xs = 0 then //this is horizontal
      begin
        if Ye > Ys then  //this is South
          begin
            result := 'S';
          end
        else
          begin
            result := 'N'; //not south so must be N
          end;
      end
    else if Ye - Ys = 0 then //this is Vertical   either E/W
      begin
        if Xe > Xs then
          begin
            result := 'E';  //this is E
          end
        else if i = jEdges.Count -1 then //this is the last point
          begin
            //look for the first start point
            joEdges := jEdges.Child[0] as TlkJSonObject;
            if joEdges.Field['Start'] <> nil then
              GetJsonCoordinate('Start', joEdges, X0, Y0);
            if x0 = xs then //this is E for the last point
              result := 'E';
          end
        else
          result := 'W';
      end
    else //not horizontal and not vertical, has to be in diagonal
      begin
        if Xe > Xs then  //this is E
          begin
            if Ye > Ys then  //this is S
              result := 'SE'
            else
              result := 'NE';
          end
        else if Xe < Xs then  //this is W
          begin
            if Ye > Ys then
              result := 'SW'
            else
              result := 'NW';
          end;
      end;
  except on E:Exception do
     ShowNotice('Error in calculating direction. '+e.message);
  end;
end;


function calcDegree(x1,y1,x2,y2: Double):Double;
var
  aLog: String;
begin
  result := 0;
  if x2 <> x1 then
    result := 90 - RadToDeg(arcTan(abs((y2-y1)/(x2-x1))));
  aLog := Format('(%f,%f),  (%f,%f),  degree:%f ',
                [X1, Y1, X2, Y2,  result]);
  FLog.Add(aLog);
end;


function GetPerimeter(jEdges:TlkJSonBase): Double;
var
  i,k: Integer;
  joEdges: TlkJSonObject;
  LengthFt: Double;
begin
  result   := 0;
  LengthFt := 0;
  for k:= 0 to jEdges.Count - 1 do
    begin //handle EdgeIds
      joEdges := jEdges.Child[k] as TlkJSonObject;
      if joEdges <> nil then
        LengthFt := GetJsonDouble('LengthFt', joEdges);
      result := result + LengthFt;
    end;
end;


function getCurve(dir: String; Height:Double):String;
begin
  if (Height > 0) then
    begin
        result := 'R';  //this is top (N)
    end
  else
    begin
        result := 'L';
    end;
  FLog.Add('curve ='+result);
end;

procedure translateLines(joEdges:TlkJsonObject; dir: String; var xml:TStringList);
var
  dim: string;
  aLog: String;
  LengthFt: Double;
  X1, Y1, X2, Y2: Double;
  degree: Double;
  deg: String;
begin
  try
    xml.add('<line>');
    xml.add('<segment>');
    LengthFt := GetJsonDouble('LengthFt', joEdges);
    dim := trim(Format('%f',[LengthFt]));
    xml.add(Format('<dim>%s</dim>',[dim]));
    xml.add(Format('<dir>%s</dir>',[dir]));

    GetJsonCoordinate('Start', joEdges, X1, Y1);
    aLog := Format('Start(X1=%f, Y1=%f)',[X1,Y1]);
    FLog.Add(aLog);

    GetJsonCoordinate('End', joEdges, X2, Y2);
    aLog := Format('End(X2=%f, Y2=%f)',[X2,Y2]);
    FLog.Add(aLog);

    aLog := Format('dim/dir = %s/%s ',[dim, dir]);
    FLog.Add(aLog);
    FLog.Add('');

    if length(dir) > 1 then
      begin
        GetJsonCoordinate('Start', joEdges, X1, Y1);
        GetJsonCoordinate('End', joEdges, X2, Y2);
        aLog := Format('Start(X1=%f, Y1=%f)',[X1,Y1]);
        FLog.Add(aLog);
        aLog := Format('End(X2=%f, Y2=%f)',[X2,Y2]);
        FLog.Add(aLog);
        degree := calcDegree(x1,y1,x2,y2);
        deg := Format('%f',[degree]);
        if deg <> '' then
          xml.add(Format('<degree>%s</degree>',[deg]));
      end;
      xml.Add('</segment>');
      xml.Add('</line>');
  except on E:Exception do
     ShowNotice('Error in calculating Line dimension. '+e.message);
  end;
end;

procedure translateArc(joEdges:TlkJsonObject; dir: String; var xml:TStringList);
var
  dim: string;
  aLog: String;
  LengthFt, Height: Double;
  X1, Y1, X2, Y2: Double;
  degree, arcAngle: Double;
  deg, curve: String;
begin
  try
    FLog.Add('IsArc = TRUE');
    xml.add('<arc>');
    Height := GetJsonDouble('HeightFt', joEdges);
    FLog.Add(Format('HeightFt = %f',[Height]));
    LengthFt := GetJsonDouble('LengthFt', joEdges);
    Flog.Add(Format('LengthFt = %f',[LengthFt]));
    curve := getCurve(dir,Height);
    xml.add(Format('<curve>%s</curve>',[curve]));
    xml.add('<cord>');
      xml.add('<segment>');
        dim := trim(Format('%8.2f',[LengthFt]));
        xml.add(Format('<dim>%s</dim>',[dim]));
        xml.add(Format('<dir>%s</dir>',[dir]));
    Flog.Add(Format('dim = %s',[dim]));
    Flog.Add(Format('dir = %s',[dir]));
      xml.add('</segment>');
    xml.add('</cord>');
    arcAngle := getJsonDouble('ArcAngle', joEdges);
    if arcAngle > 90 then
      arcAngle := (180 - arcAngle) + arcAngle;

    deg := Format('%f',[arcAngle]);
    if deg <> '' then
      xml.add(Format('<degree>%s</degree>',[deg]));
    Flog.Add(Format('degree = %s',[deg]));
    xml.add('</arc>');
  except on E:Exception do
     ShowNotice('Error in calculating arc dimension. '+e.message);
  end;
end;

procedure GetOriginalPoint(jEdges: TlkJSonBase; var X1, Y1, X2, Y2, LengthFT: Double);
var
  joEdges: TlkJSonObject;
begin
  if jEdges = nil then exit;
  joEdges := jEdges.Child[0] as TlkJSonObject;    //always get the first point
  if jEdges.Field['Start'] <> nil then
    GetJsonCoordinate('Start', joEdges, X1, Y1);  //get the first coordinate of the next area
  if jEdges.Field['End'] <> nil then
    GetJsonCoordinate('End', joEdges, X2, Y2);  //get the first coordinate of the next area
  LengthFt := GetJsonDouble('LengthFt', joEdges);
end;

procedure TranslateMoveLines(jAreas,jEdges: TlkJSonBase; j: Integer; var xml: TStringList);
var
  L, LengthFT:Double;
  jo, joEdges: TlkJSonObject;
  X1,Y1: Double;  //This is the starting point   X1 = 466, Y1 = 499.5
  X2,Y2: Double;  //This is the end point of the first line   X2 = 751.84, Y2 = 499.5
  X,Y: Double;    //this is the point that we need to move to  X = 751.84, Y = 352.61
  D1,D2,D3: Double;     //This is the distance between X1 to X2
  Dir, aMsg: String;
  i: Integer;
begin
    L := 0;

    for  i := 0 to jAreas.Count -1 do  //look for the next area
      begin
        if i = 0 then
          begin
            jEdges := jAreas.Child[i].Field['Edges'];
            GetOriginalPoint(jEdges, X1, Y1, X2, Y2, LengthFT);
(*
            jEdges := jAreas.Child[i].Field['Edges'];
            joEdges := jEdges.Child[0] as TlkJSonObject;    //always get the first point
            if jEdges.Field['Start'] <> nil then
              GetJsonCoordinate('Start', joEdges, X1, Y1);  //get the first coordinate of the next area
            if jEdges.Field['End'] <> nil then
              GetJsonCoordinate('End', joEdges, X2, Y2);  //get the first coordinate of the next area
            LengthFt := GetJsonDouble('LengthFt', joEdges);
*)
          end;

        if i < j then continue;
        jEdges := jAreas.Child[i].Field['Edges'];
        joEdges := jEdges.Child[0] as TlkJSonObject;    //always get the first point
        if jEdges.Field['Start'] <> nil then
          begin
            GetJsonCoordinate('Start', joEdges, X, Y);  //get the first coordinate of the next area
            break;
          end;
      end;

    //use the coordinate to calculate the length
    if X2 <> X1 then
      begin //calculate length of Y
        D1 := abs(X2 - X1);   //  751.84 - 466 = 285.84  and D1 = LengthFT(36)
        //LengthFT * L = D1 * Y;
        if D1 <> 0 then
          begin
            //get the move for Y first
            D2 := abs(Y - Y1);
            L := (LengthFT * D2)/D1;
            xml.Add('<move>  <segment>');
            xml.add(Format('<dim>%f</dim>',[L]));
            if Y > Y1 then //this is S
              Dir := 'S'
            else
              Dir := 'N';
            xml.Add(Format('<dir>%s</dir>',[Dir]));
            xml.Add('</segment> </move>');

            //Now, get the move for X
            D3 := abs(X - X1);
            //now, get the move for X
            L := (LengthFT * D3)/D1;
            xml.Add('<move>  <segment>');
            xml.add(Format('<dim>%f</dim>',[L]));
            if X > X1 then //this is S
              Dir := 'E'
            else
              Dir := 'W';
            xml.Add(Format('<dir>%s</dir>',[Dir]));
            xml.Add('</segment> </move>');

          end;
      end;
end;


function GetSurface(joSketch:TlkJsonBase; sList:TStringList; cur:Integer):String;

var

  i,j,k:Integer;

  jAreas, jTexts: TlkJSonbase;

  aTitle,aItem, aValue:String;

begin

  result := '0';

  jAreas := joSketch.Field['Areas'];

  if jAreas <> nil then

    begin

      for i:= 0 to jAreas.Count -1 do

        begin

          if i <> cur then continue;

          if jAreas.child[i].Field['TextId'] <> nil then

            begin

               jTexts :=  joSketch.Field['Texts'];

               if jTexts <> nil then

                 begin

                   for j:= 0 to jTexts.Count -1 do

                     begin

                       if jTexts.Child[j].Field['Id'] <> nil then

                         if varToStr(jTexts.Child[j].Field['Id'].Value) = varToStr(jAreas.child[i].Field['TextId'].Value) then

                            begin

                               for k:=0 to slist.count -1 do

                                 begin

                                   aItem := slist[k];

                                   aTitle := popStr(aItem,'=');

                                   if jTexts.child[j].Field['Content'] <> nil then

                                     if compareText(aTitle, varToStr(jTexts.child[j].Field['Content'].Value)) = 0 then

                                       begin

                                         result := aItem;

                                         break;

                                       end;

                                   end;

                                 end;

                            end;

                     end;

                 end;

            end;

        end;

end;



function ConvertJSONToXML(joSketch: TlkJSonBase; pageNo: Integer; AreaList:TStringList):String;
var
  jSketch, jTexts, jText, jEdges, jAreas, jAreaName: TlkJSonBase;
  joEdges, joText,jo: TlkJSonObject;
  xml: TStringList;
  aXMLData:String;
  i,j,k,n: Integer;
  aLine: String;
  ID,dir: String;
  LengthFt: Double;
  aStr: String;
  isVertical, IsHorizontal, isArc :Boolean;
  perimeter:Double;
  isDimension: Boolean;
  Content: String;
  X,Y:Double;
  degree:Double;
  dim, deg: String;
  aMsg: String;
  x1,x2,y1,y2: Double;
  arcAngle, Height:Double;
  curve: String;
  aLog: String;
  areaName: String;
  xmlFileName: String;
  MoveDim:Double;
  MoveDir: String;
  sCount, TotCount,aCount: Integer;
  surface: String;
  aDebugPath, aDebugFileName: String;
  IsAreaTitle: Boolean;
  D1, D2, D3, L: Double;
begin
  try
    FSketchDir := IncludeTrailingPathDelimiter(GetTempFolderPath);  //ClickForms Temp folder stores the files
    xml := TStringList.Create;
    try
      xml.Clear;
      if joSketch.Field['Sketcher_Definition_Data'] <> nil then
        jSketch := joSketch.Field['Sketcher_Definition_Data'];

      //set up XML header
      xml.Add('<?xml version="1.0" encoding="UTF-8"?>');
      xml.add('<sketch xmlns="http://www.areasketch.com/namespace" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.areasketch.com/namespace areasketch.xsd">');

      case PageNo of
        1: begin
             sCount   := 0;
             totCount := 1;
           end;
        else
          begin
            //sCount   := 1;

            sCount := PageNo - 1;
            totCount := PageNo;
          end;
      end;
      for i:= sCount to totCount -1 do
        begin
          joSketch := jSketch.Child[i] as TlkJSONObject;  //get each comp
          if joSketch = nil then continue;
          jAreas := joSketch.Field['Areas'];

          if jAreas <> nil then
           for j:= 0 to jAreas.Count -1 do
            begin
              xml.add('<id/>');   //needs to have this
              xml.add('<status>new</status>');  //needs to have this

              jEdges := jAreas.Child[j].Field['Edges'];
              jAreaName := jAreas.Child[j].Field['Name'];

              xml.add('<area style="solid" width="2" color="0x000000" showDimensionText="1" flipDimensionTextPos="0" showAreaCalc="1" showPerimeterCalc="1" autoLabel="full" fillPattern="none" fillColor="0xff0000" >');
              if jEdges.Field['Id'] <> nil then
                Id := varToStr(jEdges.Field['Id'].Value);
              xml.add(Format('<id>%s</id>',[Id]));
              areaName := VarToStr(jAreaName.Value);
              xml.add(Format('<name>%s</name>',[areaName]));
              xml.add('<status>new</status>');

              surface := getSurface(joSketch, AreaList,j);
              xml.add(Format('<surface>%s</surface>',[surface]));

              perimeter := GetPerimeter(jEdges);
              aStr := Format('%8.2f',[perimeter]);
              xml.add(Format('<perimeter>%s</perimeter>',[aStr]));


              if jEdges = nil then continue;
              xml.add('<vectors>');
              for k:= 0 to jEdges.Count - 1 do
                  begin //handle EdgeIds
                    joEdges := jEdges.Child[k] as TlkJSonObject;
                    ID := GetJsonString('Id', joEdges);
                    if ID <> '' then
                      begin
                        LengthFt := GetJsonDouble('LengthFt', joEdges);
                        if LengthFt > 0 then
                          begin
                            if (k = 0) and (j>0) then
                              TranslateMoveLines(jAreas, jEdges, j, xml);
                            isArc := GetJsonBool('IsArc', joEdges);
                            dir := GetDirection(jEdges,k, isArc);
                            if not isArc then
                              begin
                                translateLines(joEdges, dir, xml);
                              end
                            else  //isArc
                              begin
                                translateArc(joEdges, dir, xml);
                              end;
                          end;
                        end;
                    end;
                xml.add('</vectors>');
                if jAreaName <> nil then
                begin
                  areaName := VarToStr(jAreaName.Value);
                  xml.add('<areaDefs>');
                  xml.add('<areaDef>');
                  xml.add(Format('<name>%s</name>',[areaName]));
                  xml.add(Format('<type>%s</type>',[areaName]));
                  xml.add('<sign>1</sign>');
                  xml.add('<modifier>1</modifier>');
                  xml.add('<partof/>');
                  xml.add('<partofSign>1</partofSign>');
                  xml.add('</areaDef>');
                  xml.add('</areaDefs>');
                end;
                xml.add('</area>');
             end;
         end;

        //Handle labels
        jTexts := joSketch.Field['Texts'];
        if jTexts <> nil then
          begin
            for j:= 0 to jTexts.Count -1 do
              begin
                joText := jTexts.Child[j] as TlkJSonObject;
                Content := GetJSonString('Content', joText);
                IsDimension := GetJsonBool('IsDimension', joText);
                isAreaTitle := GetJsonBool('IsAreaTitle', joText);
                if (Content <> '') and not IsDimension and not IsAreaTitle then
                  begin
                    if joText.Field['TapPoint'] <> nil then
                      begin
                        GetJsonCoordinate('TapPoint', joText, X, Y);
                        jEdges := jAreas.Child[0].Field['Edges'];
                        if jEdges <> nil then
                          GetOriginalPoint(jEdges, X1, Y1, X2, Y2, LengthFT);

                          //use the coordinate to calculate the length
                          if X2 <> X1 then
                            begin //calculate length of Y
                              D1 := abs(X2 - X1);   //  751.84 - 466 = 285.84  and D1 = LengthFT(36)
                              //LengthFT * L = D1 * Y;
                              if D1 <> 0 then
                                begin
                                  xml.add('<label>');
                                  xml.add('<position>');
                                  D3 := X - X1;
                                  L := (LengthFT * D3)/D1;
                                  if L <> 0 then
                                    aStr := FloatToStr(L);
                                  aStr := Format('<X>%s</X>',[aStr]);
                                  xml.add(aStr);
                                  //get the move for Y first
                                  D2 := Y - Y1;
                                  L := (LengthFT * D2)/D1;
                                  if L <> 0 then
                                    aStr := FloatToStr(L);
                                  aStr := Format('<Y>%s</Y>',[aStr]);
                                  xml.add(aStr);
                                  xml.add('</position>');
                                  aStr := Format('<text>%s</text>',[Content]);
                                  xml.add(aStr);
                                  xml.add('<alignHorz>center</alignHorz>');
                                  xml.add('</label>');
                              end;
                          end;
                      end;
                    end;
               end;
          end;

        xml.add('</sketch>');
        finally
          XMLFileName := FSketchDir + cSketchFileName;
          xml.SaveToFile(xmlFileName);
          aDebugPath := IncludeTrailingPathDelimiter(appPref_DirInspection+'\Debug');
          aDebugFileName := aDebugPath + '\ASSketch.xml';
          xml.SaveToFile(aDebugFileName);
          result := xmlFileName;
          FLog.SaveToFile(aDebugPath+ '\ASSketch_Log.txt');
          xml.Free;
        end;
  except on E:Exception do
  end;
end;


end.
