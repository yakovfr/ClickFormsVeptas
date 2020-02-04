unit UExportXML;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2005 by Bradford Technologies, Inc. }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids_ts, TSGrid, StdCtrls, ExtCtrls,  UGlobals, ComCtrls, UForms;

type
  TExportXML = class(TAdvancedForm)
    Panel1: TPanel;
    btnCancel: TButton;
    btnExport: TButton;
    PrListGrid: TtsGrid;
    StatusBar1: TStatusBar; //YF 01.02.2003
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnExportClick(Sender: TObject);
    procedure PrListGridClickCell(Sender: TObject; DataColDown,
      DataRowDown, DataColUp, DataRowUp: Integer; DownPos,
      UpPos: TtsClickPosition);
    procedure btnCancelClick(Sender: TObject);
   private
		FDoc: TComponent;          //remember the doc Container we are printing
    FOrigPrIndex: Integer;
    FDevMode:THandle;   //YF 01.02.2003

  public
    PgEx: BooleanArray;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  ExportXML: TExportXML;

implementation

uses
  UUtil1, UContainer, UMISMOInterface, UStatus,IniFiles;


{$R *.DFM}

{ TExportXML }


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

constructor TExportXML.Create(AOwner: TComponent);
var
  n,f,p: Integer;
  prIndex: Integer;
begin
  inherited Create(nil);       //we will delete it
  FDevMode := 0;
  
	if (appPref_PrintDialogLoc.y <> 0) and (appPref_PrintDialogLoc.x <> 0) then
	begin
		self.top := appPref_PrintDialogLoc.y;               //place it were it was last used
		self.Left := appPref_PrintDialogLoc.x;
		self.ClientHeight := appPref_PrintDialogHeight;     // remember the height
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
					SetLength(PgEx, docForm.TotalPages);    //array to store the printer spec for each pg

					for f := 0 to docForm.count-1 do
						for p := 0 to docForm[f].frmPage.count-1 do
							with docForm[f].frmPage[p] do
								begin
									Cell[1,n+1] := cbChecked;
  								Cell[2,n+1] := PgTitleName;
  								inc(n);
								end;
				end;
  end;
end;

destructor TExportXML.Destroy;
begin
  ExportXML:= nil;
 // Printer.PrinterIndex := FOrigPrIndex;   //reset the printer
  PgEx := nil;                          //delete the array
  if FDevMode <> 0 then      //YF 01.03.2003
    GlobalFree(FDevMode);
  inherited destroy;
end;

procedure TExportXML.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	appPref_PrintDialogLoc := Point(self.left, self.top);          //remember were we were
	appPref_PrintDialogHeight := self.ClientHeight;
      ExportXML:= nil;
end;


procedure TExportXML.btnExportClick(Sender: TObject);
var
	n,f,p: Integer;
  saveCursor: TCursor;
  fName : String;
begin
  fName := 'C:\AppraisalWorld\Sample_Appraisal_File.xml';

	with FDoc as TContainer do
		begin
     	n := 0;
			for f := 0 to docForm.Count-1 do
				for p := 0 to docForm[f].frmPage.Count-1 do
					with docForm[f].frmPage[p] do
						begin
              //set the printer spec array
              PgEx[n] := (PrListGrid.Cell[1,n+1] = cbChecked);
							inc(n);
						end;
		end;
    SaveAsAppraisalXMLReport(TContainer(FDoc), pgEx, FName);
    Close;
end;

procedure TExportXML.PrListGridClickCell(Sender: TObject; DataColDown,
  DataRowDown, DataColUp, DataRowUp: Integer; DownPos,
  UpPos: TtsClickPosition);
var
	i: Integer;
	checked: Boolean;
begin
//Clicking in column 2 is same as clicking in checkbox
   with PrListGrid do
    begin
      //handle toggle if clicked in col#2, else let chkbox do it
      if (DataColDown=2) and (DataRowDown > 0) then
        begin
          if Cell[1,DataRowDown] = cbChecked then
            Cell[1,DataRowDown] := cbUnChecked
          else
            Cell[1,DataRowDown] := cbChecked;
        end;

      //now do the extensions
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
   end;
end;



procedure TExportXML.btnCancelClick(Sender: TObject);
begin
close;
end;

end.
