unit UTwoPrint;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2007 by Bradford Technologies, Inc. }


interface

uses
	Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
	ComCtrls, StdCtrls, Grids, ExtCtrls, {Printers,} Grids_ts, TSGrid, TSMask,
  Printers,   //modified Delphi Printer Unit
  UGlobals, UForms;

const //YF 12.23.00
  prPrefFileExt = '.dat';

  type
  TTwoPrint = class(TAdvancedForm)
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    PrinterSetupDialog1: TPrinterSetupDialog;
    btnClose: TButton;
		PrListGrid: TtsGrid;
    tsMaskDefs1: TtsMaskDefs;
    ChkBxAutoClose: TCheckBox;
    PrintDialog1: TPrintDialog;
    GroupBox1: TGroupBox;
    btnP1Setup: TButton;
    btnPrintTo1: TButton;
    Label1: TLabel;
    GroupBox2: TGroupBox;
    btnP2Setup: TButton;
    btnPrintTo2: TButton;
    Label2: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
	  procedure PrinterSetupClick(Sender: TObject);
    procedure DoPrintClick(Sender: TObject);
    procedure PrListGridClickCell(Sender: TObject; DataColDown,
      DataRowDown, DataColUp, DataRowUp: Integer; DownPos,
      UpPos: TtsClickPosition);
    procedure PrListGridComboInit(Sender: TObject; Combo: TtsComboGrid;
      DataCol, DataRow: Integer);
    procedure PrListGridStartCellEdit(Sender: TObject; DataCol,
      DataRow: Integer; var Cancel: Boolean);
    procedure PrListGridComboDropDown(Sender: TObject; Combo: TtsComboGrid;
      DataCol, DataRow: Integer);
    procedure PrListGridComboGetValue(Sender: TObject; Combo: TtsComboGrid;
      GridDataCol, GridDataRow, ComboDataRow: Integer; var Value: Variant);
  private
	  FDoc: TComponent;             //remember the doc Container we are printing
    FPrName: Array[1..cMaxPrinters] of String;       //holds the printer desc text
    FDevModes: Array[1..cMaxPrinters] of THandle;
    FPgSpec: Array of PagePrintSpecRec; //duplicate of doc.pages PagePrintSpecRec
    SetupButtons: Array[1..cMaxPrinters] of TButton;  //YF 12.24.02
    PrintButtons: Array[1..cMaxPrinters] of TButton;
    PrNamesLabels: Array[1..cMaxPrinters] of TLabel;
    FPgSpecChged: Boolean;
    procedure ReadPrinterSetting(prIndex: Integer);  //from external file YF 12.25.02
    procedure WritePrinterSetting(prIndex: Integer); //to external file YF 12.25.02
    procedure GetPrinterSetting(prIndex: Integer); // From Printer to internal buffer YF 12.25.02
    procedure ApplyPrinterSetting(prIndex: Integer);  //From internal buffer to Printer YF 12.25.02
    procedure SetPrNames(prIndex: Integer);  //YF 12.25.02
    procedure OnPrinterChanged(prIndex: Integer); //YF 12.25.02
    //N is zerobased, Row is one based, PrID = 1 or 2
    procedure SetPagePrinter(N, PrID: Integer);           //sets printer (1 or 2) in PgSpec
    procedure SetPagePrName(Row, PrID: Integer);          //sets printer desc in each cell
    procedure ResetPrName(PrID: Integer);                //when chged printers, reset above
    procedure SetPrintButtons;
    function TogglePrType(N: Integer):Integer;
    procedure ConfigurePagesToPrint;
 	public
		constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
	end;

  function GetSystPrinterIndex(prName: String): Integer;
  //Sometimes a printer name in the DevMode differs from  printer name in the Printer.Printers
  //YF 03.05.03 function GetShortPrNameBySystIndx(systPrIndx: Integer): String;
implementation

uses
	UContainer, UUtil1, UStatus,IniFiles, UWinUtils, UStrings;

{$R *.DFM}

// It is the declaration from the Printers unit. By some reasons it is not public there
type
  TPrinterDevice = class
    Driver, Device, Port: String;
  end;

//it is the function from Dialog unit. Again it is not public there
function CopyData(Handle: THandle): THandle;
var
  Src, Dest: PChar;
  Size: Integer;
begin
  if Handle <> 0 then
  begin
    Size := GlobalSize(Handle);
    Result := GlobalAlloc(GHND, Size);
    if Result <> 0 then
      try
        Src := GlobalLock(Handle);
        Dest := GlobalLock(Result);
        if (Src <> nil) and (Dest <> nil) then Move(Src^, Dest^, Size);
      finally
        GlobalUnlock(Handle);
        GlobalUnlock(Result);
      end
  end
  else Result := 0;
end;


// The way this works:
// A Printer Pref (Setup) file will be saved in
// Prefereces for each printer that was configured. If none was configured
// the system default settings will be used.
constructor TTwoPrint.Create(AOwner: TComponent);
var
	f, p, n: integer;
begin
	inherited Create(nil);       //we will delete it
  SettingsName := CFormSettings_TwoPrint;

  BringToFront;                //added 04.04.07 by jenny - prevent the box from hiding (may be a dual monitor problem?)

  //YF 12.24.02
  SetupButtons[1] := btnP1Setup;
  SetupButtons[2] := btnP2Setup;
  PrintButtons[1] := btnPrintTo1;
  PrintButtons[2] := btnPrintTo2;
  PrNamesLabels[1] := Label1;
  PrNamesLabels[2] := Label2;

  //disable/init at start
  for n:= 1 to cMaxPrinters do
    begin
      fDevModes[n] := 0;
      SetupButtons[n].enabled := False;
      PrintButtons[n].enabled := False;
    end;

  if Printer.Printers.Count < 1 then
    begin
      ShowNotice('There are not any installed print drivers on your system.');
      ActiveControl := btnClose;
    end
  else
    begin
      for n := 1 to cMaxPrinters do
        begin
          SetupButtons[n].enabled := True;
          ReadPrinterSetting(n);    //look for pr Pref files
        end;
    end;

  //set up the page-to-print list
  with PrListGrid do
    begin
      if AOwner <> nil then
        if AOwner is TContainer then
        with AOwner as TContainer do
          if docForm.count > 0 then
          begin
            FDoc := AOwner;
            n := 0;
            Rows := docForm.TotalPages;                //set the number of rows
            SetLength(FPgSpec, docForm.TotalPages);    //array to store the printer spec for each pg

            for f := 0 to docForm.count-1 do
              for p := 0 to docForm[f].frmPage.count-1 do
                with docForm[f].frmPage[p] do
                  begin
                    if FPgPrSpec.PrIndex < 1 then
                      FPgPrSpec.PrIndex := 1;             //use printer #1 if none is defined

                    Cell[1,n+1] := PgTitleName;

                    Cell[2,n+1] := cbUnchecked;           //get set to draw the inital settings
                    if FPgPrSpec.OK2Print then
                      Cell[2,n+1] := cbChecked;

                    Cell[3,n+1] := IntToStr(FPgPrSpec.Copies);

                    AssignCellFont(4,n+1);                //give the cell a font

                    SetPagePrinter(n, FPgPrSpec.PrIndex);   //sets cell text/font color
                    inc(n);
                  end;
          end;
    end;//with PrGrid

  SetPrintButtons;    //finally can we print or not
  ChkBxAutoClose.Checked := appPref_AutoClosePrDlog;
  FPgSpecChged := False;
end;

destructor TTwoPrint.Destroy;
var
  prIndex: Integer;
begin
  FPgSpec := nil;    //delete the array of PrinterPgSpecs
  for prIndex := 1 to cMaxPrinters do
    if FDevModes[prIndex] <> 0 then
        GlobalFree(FDevModes[prIndex]);

  inherited Destroy;
end;

procedure TTwoPrint.FormClose(Sender: TObject; var Action: TCloseAction);
vaR
    prIndex: Integer;
begin
  appPref_AutoClosePrDlog := ChkBxAutoClose.Checked;        //remember if we autoclose

  for prIndex := 1 to cMaxPrinters do                        //save the prefs
    WritePrinterSetting(prIndex);
  TContainer(FDoc).docDataChged := FPgSpecChged;
end;

procedure TTwoPrint.ResetPrName(prID: Integer);
var
	p,n: Integer;
begin
  p := length(FPgSpec);
  for n := 0 to P-1 do
    if FPgSpec[n].PrIndex = prID then
       SetPagePrName(n+1, prID);            //put nmae in correct page
end;

procedure TTwoPrint.PrinterSetupClick(Sender: TObject);
var
  prIndex: Integer;
begin
  prIndex := TButton(Sender).tag;             //which printer are we setting up

  try
    ApplyPrinterSetting(prIndex);
    if PrinterSetupDialog1.Execute then         //If they made changes
    begin
      OnPrinterChanged(prIndex);
    end;
  except
    ShowAlert(atWarnAlert, errPrinterProblem);
  end;
end;

//determines if buttons should be enabled or not
procedure TTwoPrint.SetPrintButtons;
var
  usePr1, usePr2: Boolean;
  i: Integer;
begin
  usePr1 := False;
  usePr2 := False;

  with PrListGrid do
    for i := 1 to Rows do
      begin
        if (Cell[2,i] = cbChecked) and (FPgSpec[i-1].PrIndex = 1) then
          usePr1 := true;
        if (Cell[2,i] = cbChecked) and (FPgSpec[i-1].PrIndex = 2) then
          usePr2 := true;
      end;

  PrintButtons[1].Enabled := usePr1;
  PrintButtons[2].Enabled := usePr2;
end;


//displays printer name in specific page/row
procedure TTwoPrint.SetPagePrName(Row, prID: Integer);
begin
  with PrListGrid do
    if prID > 0 then begin
      Cell[4, Row] := FPrName[prID];
    end;
end;

//Set prId printer in PgSpec, displays name and resets Print buttons
procedure TTwoPrint.SetPagePrinter(N, PrID: Integer);
begin
  FPgSpec[N].PrIndex := PrID;     //select this printer
  SetPagePrName(N+1, PrID);
end;

function TTwoPrint.TogglePrType(N: Integer):Integer;
begin
  result := FPgSpec[N].PrIndex;  //current printer selection
  inc(result);
  if result > cMaxPrinters then
    result := 1;
end;

procedure TTwoPrint.ConfigurePagesToPrint;
var
	n,f,p: Integer;
begin
	with FDoc as TContainer do
		begin
			n := 0;
			for f := 0 to docForm.Count-1 do
				for p := 0 to docForm[f].frmPage.Count-1 do
					with docForm[f].frmPage[p] do
						begin
              //Set the printers page array of spec record, PrIndex already set
              FPgSpec[n].OK2Print := (PrListGrid.Cell[2,n+1] = cbChecked);
							FPgSpec[n].Copies := StrToInt(PrListGrid.Cell[3,n+1]);

              //now transfer to each doc.page
							FPgPrSpec.OK2Print := FPgSpec[n].OK2Print;
							FPgPrSpec.Copies := FPgSpec[n].Copies;
							FPgPrSpec.PrIndex := FPgSpec[n].PrIndex;

							inc(n);
						end;
		end;
end;

//sets the Containers PgPrSpec so the doc can print itself using PrintReport.
procedure TTwoPrint.DoPrintClick(Sender: TObject);
var
  prIndex: Integer;
begin
  PrIndex := TButton(Sender).Tag;           //printer to print to: 1,2..
  PushMouseCursor(crHourglass);             //show wait cursor
  try
    ConfigurePagesToPrint;
    try
      ApplyPrinterSetting(prIndex);
      if PrintDialog1.Execute then
        begin
          TContainer(FDoc).DoPrintReport(prIndex, FPgSpec);
          OnPrinterChanged(prIndex);
          if ChkBxAutoClose.Checked then Close;
        end;
    except
      ShowAlert(atWarnAlert, errPrinterProblem);
    end;
  finally
    PopMouseCursor;             { Always restore to normal }
  end;
end;

//use this procedure to toggle the printers once we have two of them
procedure TTwoPrint.PrListGridClickCell(Sender: TObject; DataColDown,
	DataRowDown, DataColUp, DataRowUp: Integer; DownPos,
	UpPos: TtsClickPosition);
var
	i, row, PrID: Integer;
	checked: Boolean;
begin
  with PrListGrid do
    if DataRowDown > 0 then      //ignore the titles
    if ((DataColDown = 1) or (DataColDown=2)) and ShiftKeyDown then			//clicked in checkbox
      begin
        checked := (Cell[2,DataRowDown] = cbChecked);
        for i := DataRowDown+1 to Rows do
          begin
            if ControlKeyDown then              //if cntlKeyDown toggle current state
              begin
                if Cell[2,i] = cbChecked then
                  Cell[2,i] := cbUnChecked
                else
                  Cell[2,i] := cbChecked;
              end
            else   //just run same state down list
              if checked then
                Cell[2,i] := cbChecked
              else
                Cell[2,i] := cbUnChecked;
          end;
      end
    else if (DataColDown=1) and (DataRowDown >0)then
      begin
        if Cell[2,DataRowDown] = cbChecked then
          Cell[2,DataRowDown] := cbUnChecked
        else
          Cell[2,DataRowDown] := cbChecked;
      end
    else if (DataColDown = 3) then
      begin
        CurrentCell.SelectAll;         //select text for changing
      end
    else if DataColDown = 4 then       //toggle the printer types
      if FPrName[2] <> '' then
        begin
          SetPagePrinter(DataRowDown-1, TogglePrType(DataRowDown-1));
          PrID := FPgSpec[DataRowDown-1].PrIndex;  //-1 because its zero based index
          if ShiftKeyDown then                    //extend if Shift key down
            for row := DataRowDown+1 to Rows do
            begin
              SetPagePrinter(row-1, PrID);
            end;
        end;

    SetPrintButtons;
    FPgSpecChged := True;
end;

procedure TTwoPrint.PrListGridComboInit(Sender: TObject;
  Combo: TtsComboGrid; DataCol, DataRow: Integer);
begin
  if DataCol = 4 then
    begin
        //Set the number of rows displayed
        Combo.DropDownRows := 1;
        if (FPrName[2] <> '') then Combo.DropDownRows := 2;
        Combo.ValueCol := 1;

//        Combo.AutoSearch := asTop;
        Combo.StoreData := True;

        Combo.DropDownCols := 1;        //Set the number of columns displayed to 1
        Combo.Grid.HeadingOn := False;
        Combo.Grid.RowBarOn := False;
        Combo.Grid.Cols := 1;
        combo.Grid.Rows := 1;
        if (FPrName[2] <> '') then Combo.Grid.Rows := 2;

(*
        Combo.Grid.cell[1,1] := FPrName[1];
        if (FPrName[2] <> '') then
          Combo.Grid.cell[1,2] := FPrName[2];
*)
    end;
end;

//allow to click but not edit of printer type column
procedure TTwoPrint.PrListGridStartCellEdit(Sender: TObject; DataCol,
  DataRow: Integer; var Cancel: Boolean);
begin
  if DataCol = 4 then Cancel := true;
end;

procedure TTwoPrint.PrListGridComboDropDown(Sender: TObject;
  Combo: TtsComboGrid; DataCol, DataRow: Integer);
begin
  if DataCol = 4 then
    begin
      //Set the number of rows displayed
      Combo.DropDownRows := 1;
      if (FPrName[2] <> '') then Combo.DropDownRows := 2;
      Combo.ValueCol := 1;

      //Set AutoSearch on so user input or drop down causes automatic positioning
//        Combo.AutoSearch := asTop;
      Combo.StoreData := True;

      Combo.DropDownCols := 1;        //Set the number of columns displayed to 1
       Combo.Grid.HeadingOn := False;
      Combo.Grid.RowBarOn := False;
      Combo.Grid.Cols := 1;
      combo.Grid.Rows := 1;
      if (FPrName[2] <> '') then Combo.Grid.Rows := 2;
      Combo.Grid.cell[1,1] := FPrName[1];
      if (FPrName[2] <> '') then
        Combo.Grid.cell[1,2] := FPrName[2];
    end;
end;

procedure TTwoPrint.PrListGridComboGetValue(Sender: TObject;
  Combo: TtsComboGrid; GridDataCol, GridDataRow, ComboDataRow: Integer;
  var Value: Variant);
begin
  if combo.ValueCol > 0 then
    begin
      SetPagePrinter(GridDataRow-1, ComboDataRow);   //1 or 2
      Value := FPrName[ComboDataRow];
    end;
    SetPrintButtons;  //YF 01.02.2003
end;

procedure TTwoPrint.ReadPrinterSetting(prIndex: Integer);  //YF 02.23.03 //YF 01.02.2003
var
  PrPrefFilePath: String;
  PrPrefFile: TFileStream;
  hdvMode: THandle;
  pdvMode: PChar;
  bDone: Boolean;
  fSize: Integer;
  prName: String;
  prShortName: Array[0..CCHDEVICENAME + 1] of char;
  systPrIndx: Integer;
begin
  hdvMode := 0;
  pdvMode := nil;
  bdone := False;
  prName := appPref_PrinterNames[prIndex];
  systPrIndx := GetSystPrinterIndex(prName);
  if systPrIndx < 0 then
    begin
      Printer.PrinterIndex := -1; //select default printer
      systPrIndx := Printer.PrinterIndex;
      prName := Printer.Printers[systPrIndx];
      appPref_PrinterNames[prIndex] := prName;
    end;
   SetPrNames(prIndex);
   //get printer preferences
  prPrefFilePath := IncludeTrailingPathDelimiter(appPref_DirPref) +
                                CreateValidFileName(prName) + prPrefFileExt; //YF 01.04.2003
  if FileExists(prPrefFilePath) then
    begin
      prPrefFile := TFileStream.Create(prPrefFilePath, fmOpenRead);
      try
        //check the printer name
        FillChar(prShortName,sizeof(prShortName),0);
        prPrefFile.Read(prShortName,CCHDEVICENAME);
   //      if CompareText(prShortName,GetShortPrNameBySystIndx(systPrIndx)) = 0 then  //get only Valid setting
        if Pos(prShortName,Printer.Printers[systPrIndx]) > 0 then
           //YF 03.05.03 exit;    // the wrong preference file
        begin
         prPrefFile.Seek(0,soFromBeginning);
         fSize := prPrefFile.Size;
          hdvMode := GlobalAlloc(GHND,fSize);
          if(hdvMode <> 0) then
            pdvMode := GlobalLock(hdvMode);
          if(pdvMode <> nil) then
            begin
              if prPrefFile.Read(pdvMode^,fSize) = fSize  then  //if read everything
                begin
                  if(FDevModes[prIndex]) <> 0 then
                    GlobalFree(FDevModes[prIndex]);
                  FDevModes[prIndex] := hdvMode;
                  bDone := True;
                end;
            end;
        end;
      finally
        if pdvMode <> nil then          //unlock twice??
          GlobalUnlock(hdvMode);
        if not bDone then               //had problems...
          if hdvMode <> 0 then
            GlobalFree(hdvMode);
        if assigned(prPrefFile) then
          prPrefFile.Free;
        // SetPrNames(prIndex);
      end;
    end;
end;

procedure TTwoPrint.WritePrinterSetting(prIndex: Integer); //YF 02.23.03 //YF 01.02.2003
var
  PrPrefFilePath: String;
  PrPrefFile: TFileStream;
   pdvMode: PChar;
  bOK: Boolean;
  fSize: Integer;
  prName: String;
  prShortName: Array[0..CCHDEVICENAME + 1] of char;
  systPrIndx: Integer;
begin
  // lets check what we are going to write
  //check printer name
  prPrefFile := nil;
  bOK := False;
  prName := appPref_PrinterNames[prIndex];
  systPrIndx := GetSystPrinterIndex(prName);
  if systPrIndx < 0 then   //invalid name, set the default printer
    begin
      Printer.PrinterIndex := -1; //select default printer
      systPrIndx := Printer.PrinterIndex;
      prName := Printer.Printers[systPrIndx];
      appPref_PrinterNames[prIndex] := prName;
    end;
  //check DevMode
  if FDevModes[prIndex] = 0 then
    exit;
  pdvMode := GlobalLock(FDevModes[prIndex]);
  try
    if pdvMode = nil then
      exit;
    strLCopy(prShortName,pdvMode,CCHDEVICENAME);
    GlobalUnlock(FDevModes[prIndex]);
    //pDvMode := nil;
 //   if CompareText(prShortName,GetShortPrNameBySystIndx(systPrIndx)) = 0 then
     if Pos(prShortName,Printer.Printers[systPrIndx]) > 0 then
          //YF 03.05.03 exit;    // the wrong preference file
    begin
    fSize := GlobalSize(FDevModes[prIndex]);
    prPrefFilePath := IncludeTrailingPathDelimiter(appPref_DirPref) +
                                  CreateValidFileName(prName) + prPrefFileExt; //YF 01.04.2003
    prPrefFile := TFileStream.Create(prPrefFilePath, fmCreate);
//    bOK := (prPrefFile.Write(pdvMode^,fSize) = fSize);
    prPrefFile.Write(pdvMode^, fSize);
    bOk := True;
    end;
  finally
    if pdvMode <> nil then
        GlobalUnlock(FDevModes[prIndex]);
    if assigned(prPrefFile) then
        prPrefFile.Free;
    if not bOK and FileExists(prPrefFilePath) then
        DeleteFile(prPrefFilePath);
  end;
end;

procedure TTwoPrint.GetPrinterSetting(prIndex: Integer); //from the current printer YF 02.23.03
var
    Device, Driver, Port: array[0..MAX_PATH] of char;
    hdvMode: THandle;
   
begin
    appPref_PrinterNames[prIndex] := Printer.Printers[Printer.PrinterIndex];
    Printer.GetPrinter(Device,Driver,Port,hdvMode);
    if FDevModes[prIndex] <> 0 then
    begin
        GlobalFree(FDevModes[prIndex]);
        FDevModes[prIndex] := 0;
    end;
    if hdvMode <> 0 then
        FdevModes[prIndex] := CopyData(hdvMode);
end;

procedure TTwoPrint.ApplyPrinterSetting(prIndex: Integer);  //YF 02.23.03
var
  pdvMode: PChar;
  prSystIndx: Integer;
  prName: String;
  prShortName: Array[0..CCHDEVICENAME + 1] of char;
  prDevice: TPrinterDevice;
begin
  prName := appPref_PrinterNames[prIndex];
  prSystIndx := GetSystPrinterIndex(prName);
  if prSystIndx < 0 then   //invalid name, set the default printer
    begin
      Printer.PrinterIndex := -1; //select default printer
      prSystIndx := Printer.PrinterIndex;
      prName := Printer.Printers[prSystIndx];
      appPref_PrinterNames[prIndex] := prName;
      exit;   //can not use the FDevMode
    end;
  Printer.PrinterIndex := prSystIndx;
  if FDevModes[prIndex] = 0 then
    exit;
  pdvMode := GlobalLock(FDevModes[prIndex]);
  try
    if pdvMode = nil then
      exit;
    strLCopy(prShortName,pdvMode,CCHDEVICENAME);
    GlobalUnlock(FDevModes[prIndex]);
    pdvMode := nil;
    prDevice := TPrinterDevice(Printer.Printers.Objects[Printer.PrinterIndex]);
  //  if CompareText(prShortName,GetShortPrNameBySystIndx(prSystIndx)) = 0 then
     if Pos(prShortName,Printer.Printers[prSystIndx]) > 0 then
          //exit;
      Printer.SetPrinter(PChar(prDevice.Device),PChar(prDevice.Driver),PChar(prDevice.Port),FDevModes[prIndex]);
  finally
    if pdvMode <> nil then
      GlobalUnlock(FDevModes[prIndex]);
  end;
end;

procedure TTwoPrint.OnPrinterChanged(prIndex: Integer); //YF 12.25.02
begin
  GetPrinterSetting(prIndex);
  SetPrNames(prIndex);
end;

procedure TTwoPrint.SetPrNames(prIndex: Integer);  //YF 02.23.03
var
  prName: String;
begin
    prName := appPref_PrinterNames[prIndex];
    FPrName[prIndex] := 'P' + IntToStr(PrIndex) + '- ' + Copy(prName, 1, 15);
    PrNamesLabels[prIndex].Caption :=  prName;
    ResetPrName(prIndex);
end;

function GetSystPrinterIndex(prName: String): Integer;  //YF 02.23.2003
var
  indx,nPrinters: Integer;
begin
  result := -1; //default Printer
  nPrinters := Printer.Printers.Count;
  for indx := 0 to nPrinters - 1 do
    begin
      if CompareText(prName,Printer.Printers[indx]) = 0 then
        begin
          result := indx;
          break;
        end;
    end;
end;
(* YF 03.05.03
function GetShortPrNameBySystIndx(systPrIndx: Integer): String;
var
  oldPrIndx: Integer;
  prName: Array[0..CCHDEVICENAME + 1] of char;
  device,driver,port: Array[0..MAX_PATH] of char;
  hdvMode: THandle;
  pdvMode: PChar;
begin
  pdvMode := nil;
  hdvMode := 0;
  FillChar(prName,sizeof(prName),0);
  oldPrIndx := Printer.PrinterIndex;
  Printer.PrinterIndex := systPrIndx;
  Printer.GetPrinter(device,driver,port,hdvMode);
  try
    pdvMode := GlobalLock(hdvMode);
    if pdvMode <> nil then
      strLCopy(prName,pdvMode,CCHDEVICENAME);
  finally
    if pdvMode <> nil then
      GlobalUnlock(hdvMode);
    Printer.PrinterIndex := oldPrIndx;
    result := prName;
  end;
end;  *)

end.
