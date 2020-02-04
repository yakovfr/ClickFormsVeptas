unit UUADPropLineAddr;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

//Used for entering the property address correctly on the comp address lines

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, Dialogs, StrUtils, UCell, UUADUtils, UContainer, UEditor, UGlobals,
  UStatus, UForms, uListComps3,UGridMgr, ComCtrls;

type
  TdlgUADPropLineAddr = class(TAdvancedForm)
    bbtnCancel: TBitBtn;
    lblState: TLabel;
    cbState: TComboBox;
    lblZipCode: TLabel;
    edtZipCode: TEdit;
    edtZipPlus4: TEdit;
    lblZipSep: TLabel;
    lblUnitNum: TLabel;
    edtUnitNum: TEdit;
    lblStreetAddr: TLabel;
    edtStreetAddr: TEdit;
    lblCity: TLabel;
    edtCity: TEdit;
    bbtnHelp: TBitBtn;
    bbtnClear: TBitBtn;
    cbSubjAddr2ToComp: TCheckBox;
    chkCheckComp: TCheckBox;
    bbtnOK: TBitBtn;
    ResultText: TLabel;
    procedure FormShow(Sender: TObject);
    procedure SetAddrFromText(Addr1Cell, Addr2Cell: TBaseCell; IsUnitReqd: Boolean=False);
    procedure bbtnHelpClick(Sender: TObject);
    procedure bbtnOKClick(Sender: TObject);
    procedure edtZipCodeKeyPress(Sender: TObject; var Key: Char);
    procedure edtZipPlus4KeyPress(Sender: TObject; var Key: Char);
    procedure bbtnClearClick(Sender: TObject);
    procedure cbStateKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure chkCheckCompClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure bbtnCancelClick(Sender: TObject);
    procedure editOnChange(Sender: TObject);
  private
    { Private declarations }
    FAddr1Cell, FAddr2Cell: TBaseCell;
    FClearData: Boolean;
    IsUnitAddr, IsSubj: Boolean;
    CompDB : TCompsDBList2;
    SalesGrid,ListingGrid: TCompMgr2;
    CompID, CompType: Integer;
    CompColumn: TCompColumn;
    FResetText: Boolean;
    tmpAddress, tmpCityStZip: String;
    appPref_AutoDetectComp: Boolean;  //Ticket #1231:  Preference to show on UAD Comp address pop
    function CellInSalesTable(CurCell:TBaseCell; SalesGrid:TCompMgr2; var CompID: Integer; var CompType:Integer):Boolean;
    function CellInListingTable(CurCell:TBaseCell; ListingGrid:TCompMgr2; var CompID: Integer; var CompType:Integer):Boolean;
    procedure DoSaveAddress;
    procedure DoCheckComp;
    procedure DoLoadComp;
    procedure SavePrefs;
    procedure LoadPrefs;
    function ValidateEntries: Boolean;
    function IsNonPropAddressXID:Boolean;  //Ticket #1272

  public
    { Public declarations }
    FDoc: TContainer;
    FCell: TBaseCell;
    AutoPopSubjCityStateZip: Boolean;
    procedure Clear;
    procedure SetSubjCityStZip;
    procedure SaveToCell;
  end;

const
  MaxAddrType = 12;
  MaxSubjAddr = 5;
  MaxNonPropAddr = 3;
  PropAddr1XID = 925;
  SubjAuxAddr1XID = 46;
  MaxNonComp = 15;
var
  dlgUADPropLineAddr: TdlgUADPropLineAddr;
  AddrTypeName: array[0..MaxAddrType] of String = ('Subject','Comparable','Subject','Appraiser',
    'Supervisor','Appraiser','Supervisor','Listing','Rental','Subject','Comparable','Comparable','Comparable');
  // XID 46, 41, 9, 10, 24 & 42 are on the FNMA certification forms
  // XID 1660 & 1737 are on the 1004MC form
  // XID 3981 & 3982 are on the Supplemental REO 2008 form
  // XID 932 & 933 are on the FNMA1025 XRentals form
  Addr1XID: array[0..MaxAddrType] of Integer = (925,925,46,9,24,1660,1737,3981,932,1801,1819,1838,1857);
  SubjAddr1XIDStr: array[0..MaxSubjAddr] of String = ('46','925','932','1801','2758','3981');
  NonPropAddr1XIDStr: array[0..MaxNonPropAddr] of String = ('9','24','1660','1737');
  Addr2XID: array[0..MaxAddrType] of Integer = (926,926,41,10,42,1660,1737,3982,933,1802,1820,1839,1858);
  //Ticket #1272: XML ID not on the grid:
  //46-49: Subject  41: property appriaser addr 37,31:company address
  //9,10: Appraiser company address
  //24,42: Supervisor company address
  //2758,2760, 2761:FNMA 1004MC
  //Set up this array for IsNonPropAddressXID function.  This will always set the caption save button as Save.
  NonCompAddrStr: array[0..MaxNonComp] of String = ('46','47','48','49','9','10','24','42','41','37','31',
                                                    '2758','2760','2761','1660', '1737');
implementation

{$R *.dfm}

uses
  UPage,
  UAppraisalIDs,
  UStrings,uBase,
  UUtil2, UMain,IniFiles;

function TdlgUADPropLineAddr.IsNonPropAddressXID:Boolean;
var
  i:Integer;
begin
  result := False;
  for i:= low(NonCompAddrStr) to high(NonCompAddrStr) do
    begin
      if FCell.FCellXID = StrToIntDef(NonCompAddrStr[i], 0) then
        begin
          result := True;
          bbtnOK.Caption := 'Save';
          break;
        end;
    end;
end;

procedure TdlgUADPropLineAddr.FormShow(Sender: TObject);
var
  Page: TDocPage;
  AddrIdx, Cntr: Integer;
  IsAddr1, IsAddr2: Boolean;
begin
  if FDoc = nil then
    FDoc := Main.ActiveContainer;  //if nil, use active container
  FResetText := True;
  Clear;
  FClearData := False;
  Page := FCell.ParentPage as TDocPage;
  IsAddr1 := False;
  IsAddr2 := False;
  IsUnitAddr := False;
  AddrIdx := -1;
  Cntr := -1;
  repeat
    Cntr := Succ(Cntr);
    if FCell.FCellXID = Addr1XID[Cntr] then
      if (Cntr = 0) then
        begin
          if (FCell.FContextID > 0) then
            begin
              IsAddr1 := True;
              AddrIdx := Cntr;
            end;
        end
      else
        begin
          IsAddr1 := True;
          AddrIdx := Cntr;
        end;
  until IsAddr1 or (Cntr = MaxAddrType);

  if not IsAddr1 then
    begin
      Cntr := -1;
      repeat
        Cntr := Succ(Cntr);
        if FCell.FCellXID = Addr2XID[Cntr] then
          if (Cntr = 0) then
            begin
              if (FCell.FContextID > 0) then
                begin
                  IsAddr2 := True;
                  AddrIdx := Cntr;
                end;
            end
          else
            begin
              IsAddr2 := True;
              AddrIdx := Cntr;
            end;
      until IsAddr2 or (Cntr = MaxAddrType);
    end;

  if (not IsAddr1) and (not IsAddr2) then
    Close
  else
    begin
      if IsAddr1 then
        begin
          FAddr1Cell := FCell;
          if Addr1XID[AddrIdx] <> Addr2XID[AddrIdx] then
            FAddr2Cell := Page.pgData.DataCell[FCell.GetCellIndex + 1]
          else
            FAddr2Cell := nil;
        end
      else
        begin
          if Addr1XID[AddrIdx] = Addr2XID[AddrIdx] then
            begin
              FAddr1Cell := FCell;
              FAddr2Cell := nil;
            end
          else
            begin
              FAddr1Cell := Page.pgData.DataCell[FCell.GetCellIndex - 1];
              FAddr2Cell := FCell;
            end;
        end;
      Caption := 'UAD: ' + AddrTypeName[AddrIdx] + ' Address';

      cbSubjAddr2ToComp.Checked := appPref_UADSubjAddr2ToComp;
      IsSubj := ((FAddr1Cell.FContextID > 0) and ((AnsiIndexStr(IntToStr(FAddr1Cell.FCellXID), SubjAddr1XIDStr) >= 0)));
      cbSubjAddr2ToComp.Visible := (not IsSubj) and ((AnsiIndexStr(IntToStr(FAddr1Cell.FCellXID), NonPropAddr1XIDStr) < 0));

      // Appraiser and supervisor addresses do not include a separate unit number
      if (AddrIdx < 3) or (AddrIdx > 6) then
        IsUnitAddr := not IsResidReport(FCell.ParentPage.ParentForm.ParentDocument as TContainer);
      lblUnitNum.Visible := IsUnitAddr;
      edtUnitNum.Visible := IsUnitAddr;

      if (not IsSubj) and cbSubjAddr2ToComp.Checked and (Trim(FAddr1Cell.Text) = '') and ((FAddr2Cell <> nil) and (FAddr2Cell.Text = ''))then
        SetSubjCityStZip
      else
        SetAddrFromText(FAddr1Cell, FAddr2Cell, edtUnitNum.Visible);

      edtStreetAddr.SetFocus;
    end;
    //Ticket #1231: setup auto detect Comps
    if assigned(FAddr1Cell) then //Ticket #1272: check if not nil before set the text
      tmpAddress := FAddr1Cell.Text;
    if assigned(FAddr2Cell) then
      tmpCityStZip := FAddr2Cell.Text;
    SalesGrid := TCompMgr2.Create;
    ListingGrid := TCompMgr2.Create;
    SalesGrid.BuildGrid(FDoc, gtSales);   //create and build the grid for sales
    ListingGrid.BuildGrid(FDoc, gtListing);  //if no sales then create listings
    chkCheckComp.Visible := not isSubj and not IsNonPropAddressXID; //Ticket #1272 only visible for comp address cell id
    LoadPrefs;
    ResultText.Caption := '';
    ResultText.Visible := chkCheckComp.Checked;
end;

procedure TdlgUADPropLineAddr.SetAddrFromText(Addr1Cell, Addr2Cell: TBaseCell; IsUnitReqd: Boolean=False);
var
  PosItem: Integer;
  CityStZip, sStreet, sCity, sState, sUnit, sZip, FullAddr: String;
begin
  sStreet := '';
  if Addr2Cell = nil then
    begin
      FullAddr := Addr1Cell.Text;
      PosItem := Pos(',',FullAddr);
      if PosItem > 0 then
        begin
          sStreet := Copy(FullAddr, 1, Pred(PosItem));
          CityStZip := Copy(FullAddr, Succ(PosItem), Length(FullAddr));
        end;
    end
  else
    begin
      sStreet := Addr1Cell.Text;
      CityStZip := Addr2Cell.Text;
    end;

  if IsUnitReqd then
    begin
      PosItem :=  Pos(',',CityStZip);
      if PosItem > 0 then
        // If there is a unit number (2 commas in the address) then
        //  retrieve the unit and capture only the city, state and zip
        //  for further processing
        if Pos(',', Copy(CityStZip, Succ(PosItem), Length(CityStZip))) > 0 then
          begin
            sUnit := Copy(cityStZip, 1, Pred(PosItem));
            CityStZip := Copy(CityStZip, Succ(PosItem), Length(CityStZip));
          end;
    end;
   sCity  := ParseCityStateZip2(CityStZip, cmdGetCity);
   sState := ParseCityStateZip2(CityStZip, cmdGetState);
   sZip   := ParseCityStateZip2(CityStZip, cmdGetZip);

   edtStreetAddr.Text := sStreet;
   edtUnitNum.Text := sUnit;
   edtCity.Text := sCity;
   cbState.ItemIndex := cbState.Items.IndexOf(sState);
   edtZipCode.Text := Copy(sZip, 1, 5);
   edtZipPlus4.Text := Copy(sZip, 7, 4);
end;

procedure TdlgUADPropLineAddr.bbtnHelpClick(Sender: TObject);
begin
  ShowUADHelp('FILE_HELP_UAD_PROPERTY_ADDRESS', Caption);
end;

procedure TdlgUADPropLineAddr.bbtnOKClick(Sender: TObject);
begin
  if CompareText(bbtnOK.Caption, 'Check') = 0 then  //Ticket #1231: do check comps logic if is check else do normal stuff
    DoCheckComp
  else if CompareText(bbtnOK.Caption, 'Load Comp') = 0 then
    DoLoadComp
  else
    DoSaveAddress;
end;

procedure TdlgUADPropLineAddr.DoLoadComp;
var
  aOK: Boolean;
begin
  if assigned(CompDB) then
    begin
      CompDB.OnRecChanged;  //load comps photo query
      aOK := CompDB.ExportComparable(CompID, CompType); //export both data and images
      if aOK then
        begin
          FResetText := False;
          bbtnCancel.Click;
        end;
    end;
end;

function TdlgUADPropLineAddr.ValidateEntries: Boolean;
begin
  result := False;
  if length(edtStreetAddr.Text) = 0 then
    begin
      ShowAlert(atWarnAlert, msgUADValidStreet);
      edtStreetAddr.SetFocus;
    end
  else if length(edtCity.Text) = 0 then
    begin
      ShowAlert(atWarnAlert, msgUADValidCity);
      edtCity.SetFocus;
    end
  else if length(cbState.Text) = 0 then
    begin
      ShowAlert(atWarnAlert, msgValidState);
      cbState.SetFocus;
    end
  else if length(edtZipCode.Text) = 0 then
    begin
      ShowAlert(atWarnAlert, msgValidZipCode);
      edtZipCode.SetFocus;
    end
  else
    result := True;
end;

procedure TdlgUADPropLineAddr.DoCheckComp;  //Ticket #1231
var
  i: Integer;
  CurCell, aCell: TBaseCell;
  aCityStateZip: String;
  aOK: Boolean;
  gridCell: TGridCell;
  lo, hi: Integer;
  aZipCode: String;
begin
  CompType := -1;
  if not ValidateEntries then exit;
  ResultText.Caption := '';
  aOK := False;
  try
    if (SalesGrid.Count = 0) and (ListingGrid.Count = 0) then  //No sales nor listings
      exit;
    CurCell := FDoc.docActiveCell;  //get the current active cell
    if not assigned(CurCell) then exit;
    if CellInListingTable(CurCell, ListingGrid, CompID, CompType) then
       CompColumn := ListingGrid.Comp[CompID];
    if CompType = -1 then
      begin
        if CellInSalesTable(CurCell, SalesGrid,CompID, CompType) then
          CompColumn := SalesGrid.Comp[CompID];
      end;
          if CompType = -1 then
       Exit;
    aCell := curcell;

    if CompID > 0 then  //we have comp #
      begin
        CompDB := TCompsDBList2.Create(nil);
        //Ticket #1379: since the form now is set to poOwnderFormCenter, it always pop up to the top of the active window
        //In this case, we just want to borrow the form to set the search value to hit find button in the background only
        CompDB.position := poDefault;
        TContainer(CompDB.FDoc) := FDoc;
        CompDB.FAutoDetectComp := True;  //Tell Comps DB to run in background not to show dialog
        CompDB.LoadFieldToCellIDMap;

        CompDB.edtSubjectAddr.Text  := trim(edtStreetAddr.Text); //load address to the search tab
        CompDB.cmbSubjectCity.Text  := trim(edtCity.Text);
        CompDB.cmbSubjectState.Text := trim(cbState.Text);
        CompDB.edtUnitNum.Text      := trim(edtUnitNum.Text);
        //Ticket #1231: handle original zip code +4 digit code
        if length(edtZipPlus4.Text) > 0 then
          aZipCode := Format('%s-%s',[trim(edtZipCode.Text), trim(edtZipPlus4.text)])
        else
          aZipCode := trim(edtZipCode.Text);
        CompDB.cmbSubjectZip.Text   := aZipCode;
        aCityStateZip := Format('%s, %s %s',[trim(edtCity.Text), trim(cbState.Text), trim(aZipCode)]);
        if edtUnitNum.Text <> '' then  //Ticket #1315: Include Unit #
          aCityStateZip := Format('%s, %s',[trim(edtUnitNum.text), aCityStateZip]);
        if assigned(CompColumn) then
          begin
            //Save current one to a temp
            CompColumn.SetCellTextByID(925, edtStreetAddr.Text);    //write the both address cells for comps db to pick up
            CompColumn.SetCellTextByID(926, aCityStateZip);
            CompColumn.SetCellTextByID(2141, edtUnitNum.Text);
          end;
        CompDB.btnFind.Click;   //search for the address
        try
          if not CompDB.FNoMatch then  //we found it
            begin
              CompDB.Show;
              CompDB.LoadReportCompTables;
              if CompDB.CompsInDB(CompID, CompType) then  //found sales
                begin
                  ResultText.Font.Color := clBlue;
                  ResultText.Caption := 'Search Result: Address is in Comps Database,do you want to load it?';
                  bbtnOK.Caption := 'Load Comp';
                  bbtnOK.Refresh;
                  aOK := True;
                end
              else
                aOK := False;

            end
          else //not found in Comps db
            begin
              aOK := False;
            end;
          if not aOK then
            begin
              ResultText.Font.Color := clRed;
              ResultText.Caption := 'Search Result: Address is not in Comps Database.';
              bbtnOK.Caption := 'Save';
              bbtnOK.Refresh;
              FDoc.MakeCurCell(aCell);
              CompColumn.SetCellTextByID(925, tmpAddress);    //write the both address cells for comps db to pick up
              CompColumn.SetCellTextByID(926, tmpCityStZip);
            end;
        finally
        end;
     end;
  finally
      ResultText.Visible := True;
  end;
end;



procedure TdlgUADPropLineAddr.DoSaveAddress;
begin
  if Trim(edtStreetAddr.Text) = '' then
    begin
      ShowAlert(atWarnAlert, msgUADValidStreet);
      edtStreetAddr.SetFocus;
      Exit;
    end;
  if IsUnitAddr and
    (Trim(edtUnitNum.Text) = '') then
    begin
      ShowAlert(atWarnAlert, msgUADValidUnitNo);
      edtUnitNum.SetFocus;
      Exit;
    end;
  if Trim(edtCity.Text) = '' then
    begin
      ShowAlert(atWarnAlert, msgUADValidCity);
      edtCity.SetFocus;
      Exit;
    end;
  //user needs to be able to type in state. easier than clicking list
  if (cbState.text = '') or (length(cbState.text) = 1) or (POS(cbState.text, cbState.Items.Text)= 0) then
    begin
      ShowAlert(atWarnAlert, msgValidState);
      cbState.SetFocus;
      Exit;
    end;
  if (Trim(edtZipCode.Text) = '') or (Length(edtZipCode.Text) < 5) or
      (StrToInt(edtZipCode.Text) <= 0) then
    begin
      ShowAlert(atWarnAlert, msgValidZipCode);
      edtZipCode.SetFocus;
      Exit;
    end;
  if Length(Trim(edtZipPlus4.Text)) > 0 then
    if (Length(edtZipPlus4.Text) < 4) or (StrToInt(edtZipPlus4.Text) = 0) then
      begin
        ShowAlert(atWarnAlert, msgValidZipPlus);
        edtZipPlus4.SetFocus;
        Exit;
      end;

  SaveToCell;
  ModalResult := mrOK;
end;

procedure TdlgUADPropLineAddr.edtZipCodeKeyPress(Sender: TObject;
  var Key: Char);
begin
  Key := PositiveNumKey(Key);
end;

procedure TdlgUADPropLineAddr.edtZipPlus4KeyPress(Sender: TObject;
  var Key: Char);
begin
  Key := PositiveNumKey(Key);
end;

procedure TdlgUADPropLineAddr.cbStateKeyPress(Sender: TObject;
  var Key: Char);
begin
  Key := GetAlphaKey(Key);
end;

procedure TdlgUADPropLineAddr.Clear;
begin
  IsUnitAddr := False;
  edtStreetAddr.Text := '';
  edtUnitNum.Text := '';
  edtCity.Text := '';
  cbState.ItemIndex := -1;
  edtZipCode.Text := '';
  edtZipPlus4.Text := '';
end;

procedure TdlgUADPropLineAddr.SetSubjCityStZip;
var
  Document: TContainer;
  FAddrCell: TBaseCell;
begin
  if cbSubjAddr2ToComp.Checked then
    begin
      Document := FCell.ParentPage.ParentForm.ParentDocument as TContainer;

      FAddrCell := Document.GetCellByXID(47);     // General city XID
      if FAddrCell = nil then
        FAddrCell := Document.GetCellByXID(3971); // REO2008 Addendum city XID
      if FAddrCell <> nil then
        edtCity.Text := FAddrCell.Text;

      FAddrCell := Document.GetCellByXID(48);     // General state XID
      if FAddrCell = nil then
        FAddrCell := Document.GetCellByXID(3972); // REO2008 Addendum city XID
      if FAddrCell <> nil then
        cbState.ItemIndex := cbState.Items.IndexOf(FAddrCell.Text);

      FAddrCell := Document.GetCellByXID(49);     // General zip XID
      if FAddrCell = nil then
        FAddrCell := Document.GetCellByXID(3973); // REO2008 Addendum zip XID
      if FAddrCell <> nil then
        begin
          edtZipCode.Text := Copy(FAddrCell.Text, 1, 5);
          edtZipPlus4.Text := Copy(FAddrCell.Text, 7, 4);
        end;
    end;
end;

procedure TdlgUADPropLineAddr.SaveToCell;
const
  cCom = ', ';
var
  FirstLn, SecondLn: String;
  Document: TContainer;
begin
  FirstLn := edtStreetAddr.Text;
  SecondLn := '';
  if not FClearData then
    begin
      if IsUnitAddr then
        SecondLn := edtUnitNum.Text + cCom;
      SecondLn := SecondLn + edtCity.Text + cCom + cbState.Text + ' ' + edtZipCode.Text;
      if Trim(edtZipPlus4.Text) <> '' then
        SecondLn := SecondLn + '-' + edtZipPlus4.Text;
    end;

  // Remove any legacy data - no longer used
  FAddr1Cell.GSEData := '';
  // Save the cleared or valid address
  if FAddr2Cell = nil then
    begin
      if not FClearData then
        SetDisplayUADText(FAddr1Cell, (FirstLn + cCom + SecondLn))
      else
        SetDisplayUADText(FAddr1Cell, '');
    end
  else
    begin
      SetDisplayUADText(FAddr1Cell, FirstLn);
      SetDisplayUADText(FAddr2Cell, SecondLn);
    end;

  // If entering the subject address munge so the page 1 fields are populated
  if IsSubj then
    begin
      Document := FAddr1Cell.ParentPage.ParentForm.ParentDocument as TContainer;
      Document.BroadcastCellContext(kAddress, edtStreetAddr.Text);
      Document.BroadcastCellContext(kUnitNo, edtUnitNum.Text);
      Document.BroadcastCellContext(kCity, edtCity.Text);
      Document.BroadcastCellContext(kState, cbState.Text);
      Document.BroadcastCellContext(kZip, edtZipCode.Text);
    end;
end;

procedure TdlgUADPropLineAddr.bbtnClearClick(Sender: TObject);
begin
  if WarnOK2Continue(msgUAGClearDialog) then
    begin
      Clear;
      FClearData := True;
      // save subject address to the munger
      SaveToCell;
      appPref_UADSubjAddr2ToComp := cbSubjAddr2ToComp.Checked;
      ModalResult := mrOK;
    end;
end;

procedure TdlgUADPropLineAddr.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  appPref_UADSubjAddr2ToComp := cbSubjAddr2ToComp.Checked;
end;

function TdlgUADPropLineAddr.CellInSalesTable(CurCell:TBaseCell; SalesGrid:TCompMgr2; var CompID: Integer; var CompType: Integer):Boolean;
var
  i: Integer;
  aCell: TBaseCell;
  aCompCol: TCompColumn;
  aCoord: TPoint;
begin
   //Ticket # 1265: Use grid manager to pass the current cell uid to get the compid out.
   CompID := TGridMgr(SalesGrid).GetCellCompID(CurCell.UID, aCoord);
   if CompID <> -1 then
     CompType := TGridMgr(SalesGrid).Kind;
   result := (CompID >= 0) and (CompType <> -1);
(*
    CompType := gtSales;
    for i:= 0 to SalesGrid.Count - 1 do  //walk through the grid
      begin
        aCell := SalesGrid.Comp[i].GetCellByID(CurCell.FCellID);   //get the active cell from the grid
        if not assigned(aCell) then continue;
          if (CurCell.UID.Num = aCell.UID.Num) and   //if active cell matches with the cell on the grid
             (CurCell.UID.Pg = aCell.UID.Pg) and
             (CurCell.UID.FormID = aCell.UID.FormID) and
             (CurCell.FCellID = aCell.FCellID) and
             ((CurCell.FCellID=925) or (CurCell.FCellID=926)) then
              begin
                //CompID := i;
                compType := gtSales;
                Break;
              end;
        end;
    result := (CompType <> -1);
*)
end;

function TdlgUADPropLineAddr.CellInListingTable(CurCell:TBaseCell; ListingGrid:TCompMgr2; var CompID: Integer; var CompType:Integer):Boolean;
var
  i: Integer;
  aCell: TBaseCell;
  aCoord: TPoint;
begin
   //Ticket # 1265: Use grid manager to pass the current cell uid to get the compid out.
   CompID := TGridMgr(ListingGrid).GetCellCompID(CurCell.UID, aCoord);
   if CompID <> -1 then
     CompType := TGridMgr(ListingGrid).Kind;
   result := (CompID >= 0) and (CompType <> -1);

(*
  CompType := -1;
  for i:= 0 to ListingGrid.Count - 1 do  //walk through the grid
    begin
      aCell := ListingGrid.Comp[i].GetCellByID(CurCell.FCellID);   //get the active cell from the grid
      if not assigned(aCell) then continue;
      if (CurCell.UID.Num = aCell.UID.Num) and   //if active cell matches with the cell on the grid
         (CurCell.UID.Pg = aCell.UID.Pg) and
         (CurCell.UID.FormID = aCell.UID.FormID) and
         (CurCell.FCellID = aCell.FCellID) and
         ((CurCell.FCellID=925) or (CurCell.FCellID=926)) then
         begin
            compType := gtListing;
            CompID := i;
            break; //we are done.
         end;
    end;
    result := (CompType <> -1);
*)
end;

procedure TdlgUADPropLineAddr.chkCheckCompClick(Sender: TObject);
begin
  ResultText.Visible := False;
  if isSubj or IsNonPropAddressXID then  //if it's subject we need the button say "Save"
    begin
      bbtnOK.Caption := 'Save';
      exit;
    end;

  if chkCheckComp.Checked then  //Ticket #1231: if checked show check else show save
    begin
      bbtnOK.Caption := 'Check';
//      Height := 190; //#1519: use the original height that set in design
    end
  else
    begin
      bbtnOK.Caption := 'Save';
//      Height := 165; //#1519: use the original height that set in design
    end;
end;



procedure TdlgUADPropLineAddr.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if CanClose then
    begin
      SavePrefs;
      if assigned(CompDB) then
        CompDB.Free;
      if assigned(SalesGrid) then
        SalesGrid.Free;
      if assigned(ListingGrid) then
        ListingGrid.Free;
    end;
end;

procedure TdlgUADPropLineAddr.bbtnCancelClick(Sender: TObject);
begin
  if FResetText then
    begin
      if not assigned(CompColumn) then exit;
      CompColumn.SetCellTextByID(925, tmpAddress);    //write the both address cells for comps db to pick up
      CompColumn.SetCellTextByID(926, tmpCityStZip);
    end;
end;

procedure TdlgUADPropLineAddr.LoadPrefs;
var
  IniFilePath: String;
  PrefFile : TMemIniFile;
begin
  IniFilePath := IncludeTrailingPathDelimiter(appPref_DirPref) + cClickFormsINI;
  PrefFile := TMemIniFile.Create(IniFilePath);           //create the INI reader
    try
      With PrefFile do
      begin
        appPref_AutoDetectComp := ReadBool('CompsDB', 'AutoDetectComp',True);
        chkCheckComp.Checked := appPref_AutoDetectComp;
      end;
    finally
      PrefFile.Free;
    end;
end;

procedure TdlgUADPropLineAddr.SavePrefs;
var
  IniFilePath: String;
  PrefFile: TMemIniFile;
begin
  IniFilePath := IncludeTrailingPathDelimiter(appPref_DirPref) + cClickFormsINI;
  PrefFile := TMemIniFile.Create(IniFilePath);                   //create the INI writer
  try
    appPref_AutoDetectComp := chkCheckComp.Checked;
    with PrefFile do
      begin
        //Saving Comps DB
        WriteBool('CompsDB', 'AutoDetectComp', appPref_AutoDetectComp);
        UpdateFile;      // do it now
    end;
  finally
    PrefFile.Free;
  end;
end;



procedure TdlgUADPropLineAddr.editOnChange(Sender: TObject);
begin
  if isSubj or IsNonPropAddressXID then exit;
  if chkCheckComp.Checked then
    bbtnOK.Caption := 'Check'
  else
    bbtnOK.Caption := 'Save';
end;

end.

