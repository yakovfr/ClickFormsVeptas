unit UCC_ImportRedstoneData;
interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
	ComCtrls, ExtCtrls, Printers,UGlobals, UBase, UCell, UPage, UForm,
  UMessages,UCC_Progress, uContainer, uUtil2, uStatus,UGridMgr, UUADObject,
  uStrings, UUtil1, UUADUtils;

  procedure ImportRedStoneData(doc: TContainer; Const TextFilename: String; OverrideData: Boolean=False);

implementation

const
  vSeparator = '|';

var
  FOverride: Boolean;

function okToTransfer(CompCol: TCompColumn; cellID: Integer): Boolean;
begin
  result := True;
  //skip these cells for subject
  case cellID of
    930, 931, 956, 958, 960: if CompCol.FCompID = 0 then result := False;
  end;
end;



function SetBasementValue(cellValue: String): String;
var
  aStr: String;
  aInt, aInt2: integer;
begin
  aStr := popStr(cellValue, vSeparator);
  aInt := round(GetValidNumber(aStr));
  if aInt > 0 then
    begin
      aInt2 := round(GetValidNumber(cellValue));
      if aInt2 > 0 then
        aStr := Format('%d & %d',[aInt, aInt2])
      else
        aStr := Format('%d',[aInt]);
    end
  else
    aStr := '0';
  result := aStr;
end;

function SetDesignValue(cellValue: String): String;
begin
  popStr(cellValue, vSeparator);   //get rid of the first att type
  result := cellValue;
end;

function EmptyCellValue(cellValue: String):Boolean;
begin
//  result := True;
  result := False;
  if cellValue = '' then
    result := True
  else
    begin
      cellValue := trim(cellValue);
      if (pos('0', cellValue) > 0) and (length(cellValue)=1) then
        result := True;
    end;
end;

procedure SetCellValue(doc: TContainer; cellID: Integer; cellValue: string);
var
  f,p,c: Integer;
  aCell: TBaseCell;
  aStr: String;
  aInt, aInt2: Integer;
  GeoCodedCell: TGeocodedGridCell;
begin
  if cellValue = '' then exit;
  for f := 0 to doc.docForm.count-1 do
    for p := 0 to doc.docForm[f].frmPage.count-1 do
      if assigned(doc.docForm[f].frmPage[p].PgData) then  //does page have cells?
      for c := 0 to doc.docForm[f].frmPage[p].PgData.count-1 do
        begin
          aCell := doc.docForm[f].frmPage[p].PgData[c];
          if aCell.FCellID = cellID then
            begin
               if (aCell.Text <> '') then
                 begin
                   if FOverride then
                     begin
                       if cellValue <> '' then
                         begin
                           aCell.SetText(cellValue);
                           if aCell.FMathID > 0 then
                             aCell.PostProcess;
                         end;
                     end
                   else if EmptyCellValue(aCell.Text) then
                     begin
                       aCell.SetText(cellValue);
                       if aCell.FMathID > 0 then
                         aCell.PostProcess;
                     end;
                 end
               else
                 begin
                   if cellValue <> '' then
                     begin
                       aCell.SetText(cellValue);
                       //we don't want to process math for cell #200 Bsmt GLA when push down
                       //The input value already taken care of
                       if (aCell.FMathID > 0) then
                         begin
                           case cellID of
                             333:  //Ticket 1129: If patio is not empty, check patio check box
                               begin
                                 doc.SetCellTextByID(332,'X');
                                 aCell.PostProcess; //Important, we need to go through the math process for patio abbreviation to happen
                               end;
                             200: //Ticket 1130: do the set value here for page 3 instead of call math process, mess up page 2 grid data
                               begin
                                 if GetValidInteger(CellValue) > 0 then
                                   begin
                                     doc.SetCellTextByID(880, 'Bsmt');
                                     doc.SetCellTextByID(881, cellValue);
                                   end;
                               end
                             else
                               aCell.PostProcess;
                           end;
                         end;
                     end;
                 end;
               break;
            end;
        end;
end;


procedure SetCompTableValue(doc: TContainer; UADObject: TUADObject; CompCol: TCompColumn; cellID: Integer; str: String);
var
  aStr, aCellText: String;
  aCell: TBaseCell;
  aInt: Integer;
begin
  if not okToTransfer(CompCol, cellID) then exit;
  if not FOverride and (str = '') then exit;
   case CellID of
    {1012,} 1010, 1016, {1018,} 1022: aStr := str;
    else
     aStr := UADObject.TranslateToUADFormat(compCol, cellID, str, FOverride);
   end;

  if (aStr = '') and (cellID <> 1006) then exit;  //if incoming value is empty, exit

  if assigned(CompCol) then
    begin
      aCellText := CompCol.GetCellTextByID(CellID);  //check for current cell
      if not FOverride then
        begin
          if length(aCellText) = 0 then
            CompCol.SetCellTextByID(CellID, aStr);  //put in when the cell is empty
        end
      else
       begin
         if (cellid = 1004) and (abs(CompCol.FCompID) = 3) then
           begin
             CompCol.SetCellTextByID(CellID, aStr);  //put in doesn't it's empty or not empty
           end
         else
           begin
             aCell := CompCol.GetCellByID(cellID);
             if assigned(aCell) then
               begin
                 case cellid of
                   947, 976, 1004:
                     begin
                       aInt := GetValidInteger(aStr);      //github #183: add ,
                       aStr := FormatFloat('#,###', aInt);
                     end;
                 end;
                 if (trim(aStr) = '') and (cellID=1006) then
                   aStr := '0sf';
                 aCell.Text := aStr;
                 aCell.PostProcess;
               end;
           end;
       end;
    end;
end;


procedure ImportGridData(doc: TContainer; UADObject: TUADObject; cellStr, str: String; var FDocCompTable: TCompMgr2);
var
  cellID: Integer;
  i, compNo, n : integer;
  CompCol: TCompColumn;
  aTemp, aLat, aLon: String;
  GeoCodedCell: TGeocodedGridCell;
begin
  atemp := popStr(cellStr, '-');
  compNo := round(GetValidNumber(aTemp));
  cellID := round(GetValidNumber(cellStr));
  try
    if Assigned(FDocCompTable) and (FDocCompTable.Count > 0) then
      for i:= 0 to FDocCompTable.Count - 1 do
        begin
          CompCol := FDocCompTable.Comp[i];    //Grid comp column
          if compNo = i then
            begin
              if (cellID =CGeocodedGridCellID*10) and (CompCol.GetCellByID(CGeocodedGridCellID) is TGeocodedGridCell) then
                begin
                  if cellID = CGeocodedGridCellID * 10 then
                    begin
                      GeocodedCell := CompCol.GetCellByID(CGeocodedGridCellID) as TGeocodedGridCell;
                      aLat := popStr(str, vSeparator);
                      aLon := str;
                      GeocodedCell.Latitude := StrToFloatDef(aLat, 0);
                      GeocodedCell.Longitude := StrToFloatDef(aLon, 0);
                      break;
                    end;
                end
                else if cellID = 1006 then
                    SetCompTableValue(doc, UADObject, CompCol, cellID, str)  //ticket 1131: show 0sf if empty
                else if str<> '' then
                  begin
                    SetCompTableValue(doc, UADObject, CompCol, cellID, str);
                  end;
                break;
            end;
        end;

     n:= FDocCompTable.Count;  //remember the original # comps in the report

     //check if we need to create xcomp page
     if compNo > (FDocCompTable.Count - 1) then  //exclude the subject
       begin
          InsertXCompPage(doc, compNo);
          FDocCompTable.BuildGrid(doc, gtSales);  //we only deal with sales comp from Redstone
          if Assigned(FDocCompTable) and (FDocCompTable.Count > 0) then
            for i:= n to FDocCompTable.Count - 1 do //skip all the existing comps, only deal with new xcomp
              begin
                CompCol := FDocCompTable.Comp[i];    //Grid comp column
                if compNo = i then
                  begin
                    if (cellID =CGeocodedGridCellID * 10) and (CompCol.GetCellByID(CGeocodedGridCellID) is TGeocodedGridCell) then
                      begin
                        if cellID = CGeocodedGridCellID * 10 then
                          begin
                            GeocodedCell := CompCol.GetCellByID(CGeocodedGridCellID) as TGeocodedGridCell;
                            aLat := popStr(str, vSeparator);
                            aLon := str;
                            if (aLat<>'') and (aLon<>'') then
                            begin
                              GeocodedCell.Latitude := StrToFloatDef(aLat, 0);
                              GeocodedCell.Longitude := StrToFloatDef(aLon, 0);
                            end;
                            break;
                          end;
                      end
                      else if str <> '' then
                        SetCompTableValue(doc, UADObject, CompCol, cellID, str);
                      break;
                  end;
              end;
       end;
    finally
    end;
end;

procedure ImportListingGridData(doc: TContainer; UADObject: TUADObject; cellStr, str: String; var FDocListingTable: TCompMgr2);
var
  cellID: Integer;
  i, compNo, n : integer;
  CompCol: TCompColumn;
  aTemp, aLat, aLon: String;
  GeoCodedCell: TGeocodedGridCell;
begin
  atemp := popStr(cellStr, 'L-');
  atemp := popStr(cellStr, '-');
  compNo := round(GetValidNumber(aTemp));
  cellID := round(GetValidNumber(cellStr));
  try
    if Assigned(FDocListingTable) and (FDocListingTable.Count > 0) then
      for i:= 0 to FDocListingTable.Count - 1 do
        begin
          CompCol := FDocListingTable.Comp[i];    //Grid comp column
          if compNo = i then
            begin
              if (cellID =CGeocodedGridCellID*10) and (CompCol.GetCellByID(CGeocodedGridCellID) is TGeocodedGridCell) then
                begin
                  if cellID = CGeocodedGridCellID * 10 then
                    begin
                      GeocodedCell := CompCol.GetCellByID(CGeocodedGridCellID) as TGeocodedGridCell;
                      aLat := popStr(str, vSeparator);
                      aLon := str;
                      GeocodedCell.Latitude := StrToFloatDef(aLat, 0);
                      GeocodedCell.Longitude := StrToFloatDef(aLon, 0);
                      break;
                    end;
                end
                else if str<> '' then
                  begin
                    SetCompTableValue(doc, UADObject, CompCol, cellID, str);
                  end;
                break;
            end;
        end;

     n:= FDocListingTable.Count;  //remember the original # comps in the report

     //check if we need to create xcomp page
     if compNo > (FDocListingTable.Count - 1) then  //exclude the subject
       begin
          InsertXListingPage(doc, compNo);
          FDocListingTable.BuildGrid(doc, gtListing);  //we only deal with sales comp from Redstone
          if Assigned(FDocListingTable) and (FDocListingTable.Count > 0) then
            for i:= n to FDocListingTable.Count - 1 do //skip all the existing comps, only deal with new xcomp
              begin
                CompCol := FDocListingTable.Comp[i];    //Grid comp column
                if compNo = i then
                  begin
                    if (cellID =CGeocodedGridCellID * 10) and (CompCol.GetCellByID(CGeocodedGridCellID) is TGeocodedGridCell) then
                      begin
                        if cellID = CGeocodedGridCellID * 10 then
                          begin
                            GeocodedCell := CompCol.GetCellByID(CGeocodedGridCellID) as TGeocodedGridCell;
                            aLat := popStr(str, vSeparator);
                            aLon := str;
                            if (aLat<>'') and (aLon<>'') then
                            begin
                              GeocodedCell.Latitude := StrToFloatDef(aLat, 0);
                              GeocodedCell.Longitude := StrToFloatDef(aLon, 0);
                            end;
                            break;
                          end;
                      end
                      else if str <> '' then
                        SetCompTableValue(doc, UADObject, CompCol, cellID, str);
                      break;
                  end;
              end;
       end;
    finally
    end;
end;


//Return True if we found at least one of the main form exists in the container and the main address is not EMPTY
function MainFormExist(doc: TContainer):Boolean;
var
  f, p, c, frmID: Integer;
  aCellID: Integer;
  aCellValue: String;
begin
  result := false;
  for f := 0 to doc.docForm.Count - 1 do
    begin
      frmID := doc.docForm[f].FormID;
      case frmID of
        340, 349, 345, 347, 355:
          begin  //make sure we have address not empty
            result := True;
    				for p := 0 to doc.docForm[f].frmPage.Count -1 do
              for c:= 0 to doc.docForm[f].frmPage[p].pgData.Count - 1 do
                begin
                   aCellID := doc.docForm[f].frmPage[p].pgData[c].FCellID;
                   if aCellID = 46 then  //if no address set to False
                     if doc.docForm[f].frmPage[p].pgData[c].FEmptyCell then
                       begin
                         result := False;
                         break;
                       end;
                end;
          end;
      end;
    end;
end;


//delete xcomp form in override mode before we push data in
procedure DeleteXCompPage(doc: TContainer);
var
  i: Integer;
begin
 try
  if FOverride then
    begin
      for i:= doc.docForm.Count - 1 downto 0 do
        begin
          case doc.docForm.Forms[i].FormID of
            363, 364, 366, 367, 4132, 4137: //Xcomp pages only
              begin
                doc.DeleteForm(i);
              end;
          end;
        end;
    end;
  except on E:Exception do
  end;
end;

//delete xcomp form in override mode before we push data in
procedure DeleteXListingPage(doc: TContainer);
var
  i: Integer;
begin
 try
  if FOverride then
    begin
      for i:= doc.docForm.Count - 1 downto 0 do
        begin
          case doc.docForm.Forms[i].FormID of
            3545, 869, 888, 4133, 4138: //Xcomp pages only
              begin
                doc.DeleteForm(i);
              end;
          end;
        end;
    end;
  except on E:Exception do
  end;
end;


procedure ImportRedStoneData(doc: TContainer; Const TextFilename: String; OverrideData: Boolean=False);
var
	ImportF: TextFile;
  str, aStr, CellStr, UADStr, aTemp: String;
  cellID: Integer;
  i, compNo : integer;
  CompCol: TCompColumn;
  FDocCompTable, FDocListingTable : TCompMgr2;
  doOption: Integer;
  continue: Boolean;
  UADObject: TUADObject;
begin
  if not FileExists(TextFilename) then
    ShowNotice('The import file, "'+ TextFilename + '", cannot be found.')
  else
    begin
      FOverride := overrideData;
//      DeleteXCompPage(doc);       //donot delete the forms
//      DeleteXListingPage(doc);
      try
        AssignFile(ImportF, TextFilename);
        Reset(importF);
        UADObject := TUADObject.Create(doc);
        try
          FDocCompTable := TCompMgr2.Create(True);
          FDocCompTable.BuildGrid(doc, gtSales);  //we only deal with sales comp from Redstone
          FDocListingtable := TCompMgr2.Create(True);
          FDocListingTable.BuildGrid(doc, gtListing);


          while not EOF(importF) do
            if not EOLN(importF) then          //hack because readLn does not read skips empty lines
              begin
                Read(importF, str);            //read the next string (this should be a Parser)
                Readln(importF);               //go to next line
                CellStr := popStr(str, ',');
                if pos('L-', cellStr) > 0 then //this is listing
                  begin
                    ImportListingGridData(doc, UADObject, cellStr, str, FDocListingTable);
                  end
                else if pos('-',cellStr) > 0 then  //this is grid data
                  begin
                    ImportGridData(doc, UADObject, cellStr, str, FDocCompTable);
                  end
                else
                  begin
                    cellID := round(GetValidNumber(cellStr));
                      case cellID of  //github #858: donot convert to UAD format for these cells
                        148, 149, 986: begin
                                 if pos('|', str) > 0 then
                                   str := StringReplace('|',';',str,[rfReplaceAll])
                                 else
                                   str := str;
                              end;
                        1010, 1012, 1016, 1018, 1022: Str := str;
                        else
                          Str := UADObject.TranslateToUADFormat(compCol, cellID, str, FOverride);      //translate into UAD format
                      end;
                    SetCellValue(doc, CellID, Str);
                  end;
              end
            else
              begin
                Readln(importF);
                str := '';
              end;

        except on E:Exception do
          shownotice(Format('error reading import file: %s - %s [cellID:%d str=%s] => ',
                     [TextFileName,e.message, cellid, str]));
          //ShowNotice('There is a problem reading import file, "'+ TextFilename + '".');
        end;
       finally
          FreeAndNil(UADObject);
          FreeAndNil(FDocCompTable);
          FreeAndNil(FDocListingTable);
          CloseFile(importF);
          doc.docView.Invalidate;   //redraw the screen.
       end;
    end;
end;

end.
