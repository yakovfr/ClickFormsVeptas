unit USendFax;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2005 by Bradford Technologies, Inc. }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids_ts, TSGrid, StdCtrls, ExtCtrls, Printers, ComCtrls,
  UGlobals, UForms;

type
  TSendFax = class(TAdvancedForm)
    Panel1: TPanel;
    btnSetup: TButton;
    btnCancel: TButton;
    btnFax: TButton;
    PrListGrid: TtsGrid;
    PrinterSetupDialog1: TPrinterSetupDialog;
    StatusBar1: TStatusBar;
    cmbxDrivers: TComboBox;
    PrintDialog1: TPrintDialog;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSetupClick(Sender: TObject);
    procedure btnFaxClick(Sender: TObject);
    procedure PrListGridClickCell(Sender: TObject; DataColDown,
      DataRowDown, DataColUp, DataRowUp: Integer; DownPos,
      UpPos: TtsClickPosition);
    procedure cmbxDriversChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
		FDoc: TComponent;          //remember the doc Container we are printing
    FOrigPrIndex: Integer;
     FDevMode:THandle;   //YF 01.02.2003
    procedure ReadPrinterSetting; //YF 01.02.2003
    procedure WritePrinterSetting; //YF 01.03.2003
    procedure GetPrinterSetting; //YF 01.03.2003
    procedure ApplyPrinterSetting;  //YF 01.03.2003
    procedure AdjustDPISettings;
  public
    PgSpec: Array of PagePrintSpecRec;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;


implementation

uses
  UUtil1, UContainer;


{$R *.DFM}
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

{ TCreatePDF }

constructor TSendFax.Create(AOwner: TComponent);
var
  n,f,p: Integer;
  prIndex: Integer;  //YF 01.03.2003
begin
  inherited Create(nil);       //we will delete it
  SettingsName := CFormSettings_SendFax;

  FOrigPrIndex := Printer.PrinterIndex;   //current printer (probably sys default)
  //set the default driver
  try
    cmbxDrivers.Items.Assign(Printer.Printers);
    prIndex := Printer.Printers.IndexOf(appPref_PrinterFaxName); //YF 01.03.2003
    if prIndex > 0 then
      begin
        cmbxdrivers.ItemIndex := prIndex;
        Printer.PrinterIndex := prIndex;
      end
    else
      cmbxDrivers.ItemIndex := Printer.PrinterIndex;       //set current

    appPref_PrinterFAXName := cmbxDrivers.Items[cmbxDrivers.ItemIndex];
    ReadPrinterSetting;
  except //if there are no drivers
    btnFax.Enabled := False;
    btnSetup.Enabled := False;
  end;

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
					SetLength(PgSpec, docForm.TotalPages);    //array to store the printer spec for each pg

					for f := 0 to docForm.count-1 do
						for p := 0 to docForm[f].frmPage.count-1 do
							with docForm[f].frmPage[p] do
								begin
									Cell[1,n+1] := cbUnchecked;                     //get set to draw the inital settings
                  if IsBitSet(FPgFlags, bPgInFAXList) then
										Cell[1,n+1] := cbChecked;

									Cell[2,n+1] := PgTitleName;

									inc(n);
								end;
				end;
  end;
end;

destructor TSendFax.Destroy;
begin
  Printer.PrinterIndex := FOrigPrIndex;   //reset the printer
  PgSpec := nil;                          //delete the array
  if FDevMode <> 0 then          //YF 01.03.2003
    GlobalFree(FDevMode);
  inherited destroy;
end;

procedure TSendFax.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  WritePrintersetting;  //YF 01.03.2003
end;

procedure TSendFax.btnSetupClick(Sender: TObject);     //YF 01.03.2003
begin
  ApplyPrinterSetting;
	if PrinterSetupDialog1.Execute then
		begin
      cmbxDrivers.ItemIndex := Printer.PrinterIndex;       //reset in case user changed
      appPref_PrinterFAXName := cmbxDrivers.Items[cmbxDrivers.ItemIndex];  //YF 01.03.2003
      GetPrinterSetting;
    end;
end;

procedure TSendFax.btnFaxClick(Sender: TObject);
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
              //set the doc
              FPgFlags := SetBit2Flag(FPgFlags, bPgInFAXList, (PrListGrid.Cell[1,n+1] = cbChecked));  //remember
              //set the printer spec array
              PgSpec[n].PrIndex := 1;   //always use pr #1 (we only have one PDF)
              PgSpec[n].Copies := 1;    //only one copy per page
              PgSpec[n].Ok2Print := IsBitSet(FPgFlags, bPgInFAXList); //is it checked??

							inc(n);
						end;

      ApplyPrinterSetting;          //YF 01.03.2003
      if PrintDialog1.Execute then
        begin
          //print the preport
          TContainer(FDoc).DoPrintReport(1, PgSpec);

          //the user can change printer from PrintDlg
          appPref_PrinterPDFName := Printer.Printers[Printer.PrinterIndex];  //YF 01.03.2003
          GetPrinterSetting;
        end;
		end;
end;

procedure TSendFax.PrListGridClickCell(Sender: TObject; DataColDown,
  DataRowDown, DataColUp, DataRowUp: Integer; DownPos,
  UpPos: TtsClickPosition);
var
	i: Integer;
	checked: Boolean;
begin
  with PrListGrid do
	if ((DataColDown = 1) or (DataColDown=2)) and ShiftKeyDown then			//clicked in checkbox
    begin
      checked := (Cell[1,DataRowDown] = cbChecked);
      for i := DataRowDown+1 to Rows do
        begin
          if ControlKeyDown then              //if cntlKeyDown toggle current state
            begin
              if Cell[1,i] = cbChecked then
                Cell[1,i] := cbUnChecked
              else
                Cell[1,i] := cbChecked;
            end
          else   //just run same state down list
            if checked then
              Cell[1,i] := cbChecked
            else
              Cell[1,i] := cbUnChecked;
        end;
    end
  else if (DataColDown=2) and (DataRowDown > -1) then
    begin
      if Cell[1,DataRowDown] = cbChecked then
        Cell[1,DataRowDown] := cbUnChecked
      else
        Cell[1,DataRowDown] := cbChecked;
    end;
end;

procedure TSendFax.cmbxDriversChange(Sender: TObject);
begin
  //set this so printer Setup will setup correct printer
  appPref_PrinterFAXName := Printer.Printers[cmbxDrivers.ItemIndex];
  ReadPrinterSetting;
end;

procedure TSendFax.ReadPrinterSetting;   //YF 01.02.2003
var
  PrPrefFilePath: String;
  PrPrefFile: TFileStream;
  hdvMode: THandle;
  pdvMode: PChar;
  bDone: Boolean;
  fSize: Integer;
  prName: PChar;
begin
  pdvMode := nil;
  hdvMode := 0;
  bdone := False;
  GetMem(prName,CCHDEVICENAME + 1);
  strLCopy(prName,PChar(cmbxDrivers.Items[cmbxDrivers.ItemIndex]),CCHDEVICENAME + 1);

  prPrefFilePath := IncludeTrailingPathDelimiter(appPref_DirPref) +
                            CreateValidFileName(prName) + prPrefFileExt; //YF 01.04.2003
  if FileExists(prPrefFilePath) then
    begin
      prPrefFile := TFileStream.Create(prPrefFilePath, fmOpenRead);
      try
        //check the printer name
        //SetLength(prName,CCHDEVICENAME);
        prPrefFile.Read(prName^,CCHDEVICENAME);
        if Printer.Printers.IndexOf(prName) = -1 then
            exit;
        prPrefFile.Seek(0,soFromBeginning);
        fSize := prPrefFile.Size;
        hdvMode := GlobalAlloc(GHND,fSize);
        if(hdvMode <> 0) then
          pdvMode := GlobalLock(hdvMode);
        if(pdvMode <> nil) then
          begin
            if prPrefFile.Read(pdvMode^,fSize) = fSize  then  //if read everything
              begin
                if FDevMode <> 0 then
                  GlobalFree(FDevMode);
                FDevMode := hdvMode;
                bDone := True;
              end;
          end;
      finally
        if pdvMode <> nil then
          GlobalUnlock(hdvMode);
        if not bDone then               //had problems...
          if hdvMode <> 0 then
            GlobalFree(hdvMode);
        if assigned(prPrefFile) then
          prPrefFile.Free;
        FreeMem(prName);
      end;
    end;
end;


procedure TSendFax.WritePrinterSetting; //YF 01.03.2003
var
  PrPrefFilePath: String;
  PrPrefFile: TFileStream;
   pdvMode: PChar;
  bOK: Boolean;
  fSize: Integer;
  prName: PChar;
begin
  pdvMode := nil;
  bOK := False;
  prPrefFile := nil;
  if FDevMode = 0 then
    exit;
  GetMem(prName,CCHDEVICENAME + 1);
   try
    fSize := GlobalSize(FDevMode);
    pdvMode := GlobalLock(FDevMode);
    if pdvMode <> nil  then
      begin
        strLCopy(prName,pdvMode,CCHDEVICENAME);
        if Printer.Printers.IndexOf(prName) < 0 then
          exit;
        prPrefFilePath := IncludeTrailingPathDelimiter(appPref_DirPref) +
                            CreateValidFileName(prName) + prPrefFileExt; //YF 01.04.2003
        prPrefFile := TFileStream.Create(prPrefFilePath, fmCreate);
        appPref_PrinterFAXName := prName;
        prPrefFile.WriteBuffer(pdvMode^,fSize);
        bOk := True;
      end;
  finally
    if pdvMode <> nil then
        GlobalUnlock(FDevMode);
    if assigned(prPrefFile) then
        prPrefFile.Free;
    if not bOK and FileExists(prPrefFilePath) then
        DeleteFile(prPrefFilePath);
    if prName <> nil then
      FreeMem(prName);
  end;
end;

procedure TSendFax.GetPrinterSetting; //YF 01.03.2003
var
  Device, Driver, Port: array[0..MAX_PATH] of char;
  hdvMode: THandle;
begin
  Printer.GetPrinter(Device,Driver,Port,hdvMode);
  if FDevMode <> 0 then
  begin
    GlobalFree(FDevMode);
    FDevMode := 0;
  end;

  if hdvMode <> 0 then
    FdevMode := CopyData(hdvMode);
end;

procedure TSendFax.ApplyPrinterSetting;  //YF 01.03.2003
var
  prDevice: TPrinterDevice;
begin
  //check: is it valid Setting
  Printer.PrinterIndex := cmbxDrivers.ItemIndex;;
  if FDevMode <> 0 then
    begin
      prDevice := TPrinterDevice(Printer.Printers.Objects[Printer.PrinterIndex]);
      Printer.SetPrinter(PChar(prDevice.Device),PChar(prDevice.Driver),PChar(prDevice.Port),FDevMode);
    end
  else //get default printer setting
    GetPrinterSetting;
end;

//Fix DPI issue
procedure TSendFax.AdjustDPISettings;
begin
    self.width := btnFax.left + btnFax.width + 125;
    self.height := prListGrid.Top + prListGrid.Height + 80;
    self.Constraints.minwidth := self.width;
    self.Constraints.minHeight := self.height;
end;

procedure TSendFax.FormShow(Sender: TObject);
begin
   AdjustDPISettings;
end;

end.
