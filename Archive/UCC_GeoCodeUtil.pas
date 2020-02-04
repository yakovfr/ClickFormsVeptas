unit UCC_GeoCodeUtil;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted 2006-2013 by Bradford Technologies, Inc. }      

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OleCtrls, SHDocVw, Grids_ts, TSGrid, osAdvDbGrid,
  uGAgisOnlineMap, cGAgisBingMap, uGAgisCommon, uGAgisBingCommon, cGAgisBingGeo,
  uGAgisBingOverlays, uGAgisOverlays, uGAgisOnlineOverlays, uGAgisCalculations,
  UContainer, UCC_Appraisal, UCC_Utils, UForms, UMapUtils, ExtCtrls, UCC_Progress,
  UCC_Globals, UGlobals, UCC_MPage_Market_Global;


//works on grid
procedure GeoCodePropertyList(forceGeoCode: Boolean; doc: TContainer; var AddressList:TosAdvDbGrid; var BingGeoCoder:TGAgisBingGeo);
procedure CalcPropertyProximity(doc: TContainer; var AddressList: TosAdvDbGrid);

//works on comp list
procedure GeoCodeCompList(forceGeoCode: Boolean; CompsList: TComparableList; var BingGeoCoder:TGAgisBingGeo);
procedure CalcCompProximity(Subject: TSubject; CompsList: TComparableList);

procedure DisplayPropertyIdentifier(propType: Integer; Lat, Lon: Double; var BingMaps:TGAgisBingMap);
procedure AddMarketAreasToMap(doc: TContainer; var BingMaps:TGAgisBingMap);

//function SubjectIsInComps(aComp: TProperty; aSubject: TSubject): Boolean;


implementation



procedure GeoCodePropertyList(forceGeoCode: Boolean; doc: TContainer; var AddressList: TosAdvDbGrid; var BingGeoCoder:TGAgisBingGeo);
var
  n, propCount: Integer;
  countStr: String;
  sQueryAddress: String;
  geoStatus : TGAgisGeoStatus;
  geoInfo : TGAgisGeoInfo;
  geoList : TList;
  NumStyle: TFloatFormat;
  InMktArea: Boolean;
  SubjGeoPt, CompGeoPt: TGeoPoint;
  CompAddrZip, SubjAddrZip: String;
  PosItem: Integer;
  proxCount: Integer;
  createdPBar: Boolean;
  compData: TComparableList;
  progressBar: TCCProgress;
  FStopProcess: Boolean;
  FNotCodedCount: Integer;
begin
  NumStyle  := ffFixed;
  FStopProcess := False;
  FNotCodedCount := 0;
  proxCount := 0;
  compData := doc.Appraisal.Comps;
  geoList := TList.Create;
  try
    propCount := AddressList.rows;
    countStr  := IntToStr(propCount);

//    SubjGeoPt.Latitude := StrToFloatDef(doc.Appraisal.Subject.Location.Latitude, OfficeLatitude);
//    SubjGeoPt.Longitude := StrToFloatDef(doc.Appraisal.Subject.Location.Longitude, OfficeLongitude);

//    with doc.Appraisal.Subject.Location do
//      SubjAddrZip := Uppercase(Trim(Address) + ' ' + Trim(Zip));

      //erase the previous geo coding if forcing new geocodes
      if forceGeoCode then
        for n := 1 to propCount do
          begin
            AddressList.Cell[_Lat, n] := '';
            AddressList.Cell[_Lon, n] := '';
            AddressList.Cell[_Accu, n] := '';
            AddressList.Cell[_Dist, n] := '';
          end;

      //we want a special Progress Bar just for geocoding
      createdPBar := False;
      if not assigned(ProgressBar) and forceGeoCode and (propCount> 20) then
        begin
          createdPBar := True;
          //Set the owner of the progress bar is the grid not the form.  So it won't push off bingmaps
          ProgressBar := TCCProgress.Create(AddressList, True, 0, propCount, 1, 'GeoCoding');
        end;

      //setup the progress bar if it exists
      if assigned(ProgressBar) then
        begin
          ProgressBar.lblValue.Visible := true;
          ProgressBar.lblMax.Visible := true;

          ProgressBar.StatusBar.min := 0;
          ProgressBar.lblMax.Caption := IntToStr(propCount);
          ProgressBar.StatusBar.max := propCount;
          ProgressBar.SetProgressNote('Geo-Coding Properties');
        end;

      //now do the geocoding
      for n := 1 to propCount do
        begin
          if FStopProcess then      //did user press ESC
            begin
              beep;
              FStopProcess := False; //reset
              break;                //break out of for loop
            end;

          if assigned(ProgressBar) then
            ProgressBar.IncrementBy(1);

          //does the property already been geocoded? if not then geo-code
          if ((AddressList.Cell[_Lat, n] = '') or (AddressList.Cell[_Lat, n] = ''))
          or ((AddressList.Cell[_Lat, n] > 90) or (AddressList.Cell[_Lat, n] < -90))   //check for invalid lat/lon
          or ((AddressList.Cell[_Lon, n] > 180) or (AddressList.Cell[_Lon, n] < -180)) then
            begin
//              with compData.Comp[n].Location do
//                sQueryAddress := Address + ' ' + City + ', ' + State + ' ' + Zip;
                sQueryAddress :=  AddressList.Cell[_Street, n] + ' ' +
                                  AddressList.Cell[_City, n] + ', ' +
                                  AddressList.Cell[_State, n] + ' ' +
                                  AddressList.Cell[_zip, n];
              //geo-code
              geoStatus := BingGeoCoder.GetGeoInfoFromAddress(sQueryAddress, geoInfo, geoList);
              if geoStatus = gsSuccess then
                begin
                  AddressList.Cell[_Accu, n] := GetAccuracyDescription(geoInfo.eAccuracy);
                  PosItem := Pos('ACCURACY', Uppercase(AddressList.Cell[_Accu, n]));
                  if PosItem > 0 then
                    AddressList.Cell[_Accu, n] := Trim(Copy(AddressList.Cell[_Accu, n], 1, Pred(PosItem)));

                  AddressList.Cell[_Lat, n] := FloatToStrF(geoInfo.dLatitude, NumStyle, 15, 10);
                  AddressList.Cell[_Lon, n] := FloatToStrF(geoInfo.dLongitude, NumStyle, 15, 10);
                end
              else
                begin
                  AddressList.RowColor[n] := colorLiteSalmon;
                  AddressList.Cell[_Accu, n] := 'NA';
                  AddressList.Cell[_Lat, n] := '';
                  AddressList.Cell[_Lon, n] := '';
                  AddressList.Cell[_Dist, n] := '';
                  AddressList.Cell[_Outlier, n] := True;        //assume it is an outlier
                  inc(proxCount);
                end;
            end;

          AddressList.Update;      //show the latest
        end;
  finally
    if assigned(geoList) then
      geoList.Free;

    if createdPBar and assigned(ProgressBar) then
      FreeAndNil(ProgressBar);

    FNotCodedCount := proxCount;

  end;
end;


procedure CalcPropertyProximity(doc: TContainer; var AddressList:TosAdvDbGrid) ;
var
  r, rCount: Integer;
  SubjGeoPt, CompGeoPt: TGeoPoint;
  proxStr: String;
  Appraisal: TAppraisal;
  cProximity: Integer;
begin
  Appraisal := doc.Appraisal;
  SubjGeoPt.Latitude := StrToFloatDef(Appraisal.Subject.Location.Latitude, OfficeLatitude);
  SubjGeoPt.Longitude := StrToFloatDef(Appraisal.Subject.Location.Longitude, OfficeLongitude);

  rCount := AddressList.Rows;
  for r := 1 to rCount do
    begin
      CompGeoPt.Latitude  := StrToFloatDef(AddressList.Cell[_Lat, r], 0);
      CompGeoPt.Longitude := StrToFloatDef(AddressList.Cell[_Lon, r], 0);
      if (CompGeoPt.Latitude <> 0) and (CompGeoPt.Longitude <> 0) then
        begin
          proxStr := FloatToStrF(GetGreatCircleDistance(SubjGeoPt, CompGeoPt), ffFixed, 9, 2);

          AddressList.Cell[_Dist, r] := proxStr;             //set the grid cell
        end;
    end;
end;

//just geocode to make it as fast as possible
procedure GeoCodeCompList(forceGeoCode: Boolean; CompsList: TComparableList; var BingGeoCoder:TGAgisBingGeo);
var
  n, propCount: Integer;
  sQueryAddress: String;
  geoStatus : TGAgisGeoStatus;
  geoInfo : TGAgisGeoInfo;
  geoList : TList;
  NumStyle: TFloatFormat;
  CompGeoPt: TGeoPoint;
  PosItem: Integer;
  proxCount: Integer;
  progressBar: TCCProgress;
begin
  NumStyle        := ffFixed;
  proxCount       := 0;
  geoList         := TList.Create;
  progressBar     := nil;

  try
    propCount := CompsList.Count;

    //erase the previous geo coding if forcing new geocodes
    if forceGeoCode then
      for n := 0 to propCount-1 do
        begin
          CompsList.Comp[n].Location.Latitude  := '';
          CompsList.Comp[n].Location.Longitude := '';
          CompsList.Comp[n].FProximity         := '';       //this is distance relative to the subject
          CompsList.Comp[n].FProximityDir      := '';       //this is the direction relative to subject(needed for UAD)
          CompsList.Comp[n].FGeoCodeAccuracy   := '';
        end;

    //do we show a Progress Bar for geocoding
    if (propCount > 50) then
      ProgressBar := TCCProgress.Create(nil, True, 0, propCount, 1, 'GeoCoding');   //note: no owner

    //setup the progress bar if it exists
    if assigned(ProgressBar) then
      begin
        ProgressBar.lblValue.Visible  := true;
        ProgressBar.lblMax.Visible    := true;

        ProgressBar.StatusBar.min   := 0;
        ProgressBar.lblMax.Caption  := IntToStr(propCount);
        ProgressBar.StatusBar.max   := propCount;
        ProgressBar.SetProgressNote('Geo-Coding Properties');
      end;

    //now do the geocoding
    for n := 0 to propCount-1 do
      begin
        //does the property already been geocoded? if not then geo-code
        if ((CompsList.Comp[n].Location.Latitude = '') or (CompsList.Comp[n].Location.Longitude = ''))
        or ((StrToFloatDef(CompsList.Comp[n].Location.Latitude,0) > 90) or (StrToFloatDef(CompsList.Comp[n].Location.Latitude,0) < -90))   //check for invalid lat/lon
        or ((StrToFloatDef(CompsList.Comp[n].Location.Longitude,0) > 180) or (StrToFloatDef(CompsList.Comp[n].Location.Longitude,0) < -180)) then
          begin
            with CompsList.Comp[n].Location do
              sQueryAddress := Address + ' ' + City + ', ' + State + ' ' + Zip;

            //geo-code
            geoStatus := BingGeoCoder.GetGeoInfoFromAddress(sQueryAddress, geoInfo, geoList);
            if geoStatus = gsSuccess then
              begin
                CompsList.Comp[n].FGeoCodeAccuracy := GetAccuracyDescription(geoInfo.eAccuracy);
                PosItem := Pos('ACCURACY', Uppercase(CompsList.Comp[n].FGeoCodeAccuracy));
                if PosItem > 0 then
                  CompsList.Comp[n].FGeoCodeAccuracy := Trim(Copy(CompsList.Comp[n].FGeoCodeAccuracy, 1, Pred(PosItem)));

                CompsList.Comp[n].Location.Latitude := FloatToStrF(geoInfo.dLatitude, NumStyle, 15, 10);
                CompsList.Comp[n].Location.Longitude := FloatToStrF(geoInfo.dLongitude, NumStyle, 15, 10);
              end
            else
              begin
                CompsList.Comp[n].FGeoCodeAccuracy := 'NA';
                CompsList.Comp[n].Location.Latitude := '';
                CompsList.Comp[n].Location.Longitude := '';
                CompsList.Comp[n].FProximity := '';
                inc(proxCount);
              end;
          end;

        //show that we completed a geo-code
        if assigned(ProgressBar) then
          ProgressBar.IncrementBy(1);
      end;
  finally
    if assigned(geoList) then
      geoList.Free;

    if assigned(ProgressBar) then
      FreeAndNil(ProgressBar);
  end;
end;

procedure CalcCompProximity(Subject: TSubject; CompsList: TComparableList);
var
  n, propCount: Integer;
  SubjGeoPt, CompGeoPt: TGeoPoint;
begin
  if assigned(Subject) and assigned(CompsList) then
    if CompsList.count > 0 then
      begin
        SubjGeoPt.Latitude := StrToFloatDef(Subject.Location.Latitude, OfficeLatitude);
        SubjGeoPt.Longitude := StrToFloatDef(Subject.Location.Longitude, OfficeLongitude);

        propCount := CompsList.Count-1;

        for n := 0 to propCount do
          begin
            if length(CompsList.Comp[n].FProximity) > 0 then
              continue;  //skip if already had proximity
            CompGeoPt.Latitude  := StrToFloatDef(CompsList.Comp[n].Location.Latitude, 0);
            CompGeoPt.Longitude := StrToFloatDef(CompsList.Comp[n].Location.Longitude, 0);
            if (CompGeoPt.Latitude <> 0) and (CompGeoPt.Longitude <> 0) then
              CompsList.Comp[n].FProximity := FloatToStrF(GetGreatCircleDistance(SubjGeoPt, CompGeoPt), ffFixed, 9, 2);
          end;
      end;
end;

procedure DisplayPropertyIdentifier(propType: Integer; Lat, Lon: Double; var BingMaps:TGAgisBingMap);
var
  cCircle : TGAgisCircle;
begin
  cCircle := BingMaps.AddCircle;

  cCircle.BeginUpdate;
  cCircle.Name := 'Circle1';
  cCircle.Latitude := Lat;
  cCircle.Longitude := Lon;
  cCircle.Radius := 0.025;
  cCircle.Vertices := CircleVerticies;
  cCircle.StrokeWeight := 1;

  case PropType of
    ckSale:
      begin
        cCircle.StrokeColor := clBlack;
        cCircle.FillColor := clYellow;
      end;
    ckListing:
      begin
        cCircle.StrokeColor := clBlack;    //colorSalmon;
        cCircle.FillColor := clLime;
      end;
    ckSubject:
      begin
        cCircle.StrokeColor := clBlack;
        cCircle.FillColor := clRed;
      end;
  end;

  cCircle.StrokeOpacity := 1;
  cCircle.FillOpacity := 1;
  cCircle.Visible := TRUE;
  cCircle.EndUpdate;
end;

procedure AddMarketAreasToMap(doc: TContainer; var BingMaps:TGAgisBingMap);
var
  PCount: Integer;
  MaxGeoPts, PCntr, GCntr: Integer;
  FPolygon: TGAgisPolygon;      //Reference ONLY: ref to the current map polygon (there could be more then 1, use list in Bing to get to others
begin
  PCntr := -1;
  if doc.Appraisal.MarketArea.PolygonCount > 0 then
    repeat
      PCntr := PCntr + 1;
      MaxGeoPts := doc.Appraisal.MarketArea.Polygon[PCntr].GeoPtCount;
      if MaxGeoPts > 0 then
        begin
          FPolygon := BingMaps.AddPolygon;             //create a new polygon in the map
          PCount := BingMaps.Polygons.count;           //give it a name

          FPolygon.Name := 'Polygon' + IntToStr(PCount);
          FPolygon.StrokeWeight := 2;
          FPolygon.StrokeColor := clBlack;
          FPolygon.StrokeOpacity := 0.8;
          FPolygon.FillColor := clRed;
          FPolygon.FillOpacity := 0.2;
          FPolygon.Geodesic := False;
          FPolygon.Vertices := TGAgisOnlineVertices.Create;   //create list to hold the points
          FPolygon.CloseLoop := True;
          FPolygon.Visible := True;

          //add the verticies of the polygon
          for GCntr := 0 to MaxGeoPts - 1 do
            FPolygon.Vertices.AddVertex(doc.Appraisal.MarketArea.Polygon[PCntr].GeoPt[GCntr].Latitude, doc.Appraisal.MarketArea.Polygon[PCntr].GeoPt[GCntr].Longitude);
        end;
    until PCntr = Pred(doc.Appraisal.MarketArea.PolygonCount);
end;
(*
//NOTE
//check for full subject first, if fails use geocode to do the comparison
function SubjectIsInComps(aComp: TProperty; aSubject: TSubject): Boolean;
var
  cFullAddr, sFullAddr: String;
  cStreet, sStreet: String;
  cLat, sLat: Double;
  cLon, sLon: Double;
  isMatch: Boolean;
begin
  result := False;
  isMatch := False;
  cFullAddr := trim(aComp.Location.FullAddress);
  sFullAddr := trim(aSubject.Location.FullAddress);
  cStreet   := trim(aComp.Location.StreetName);
  sStreet   := trim(aSubject.Location.StreetName);
  isMatch := CompareText(cFullAddr, sFullAddr) = 0;
  if not isMatch then //use geocode to do the comparison
    begin
      cLat := StrToFloatDef(aComp.Location.Latitude,0);
      cLon := StrToFloatDef(aComp.Location.Longitude, 0);
      sLat := StrToFloatDef(aSubject.Location.Latitude,0);
      sLon := StrToFloatDef(aSubject.Location.Longitude, 0);
      if (abs(sLat - cLat) <= 0.000005) and (abs(sLon - cLon) <= 0.000005) then
        begin
          if (POS(sStreet, cStreet) > 0)  or (POS(cStreet, sStreet) > 0) then
           result := True;
        end;
    end;
end;
*)

end.
