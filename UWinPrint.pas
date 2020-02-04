unit UWinPrint;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2005 by Bradford Technologies, Inc. }

interface

uses
  Windows, Messages, SysUtils, Classes, Dialogs,
  Uglobals, UContainer;

type
  TWinPrint = class(TObject)
    FDoc: TContainer;
    FPgSpec: Array of PagePrintSpecRec;     //duplicate of doc.pages PagePrintSpecRec
    FPrintDialog: TPrintDialog;
  public
    Constructor Create(doc: TContainer);
    Destructor Destroy; override;
    function Execute: Boolean;
    procedure ConfigurePagesToPrint;
  end;

implementation

uses
  UUtil2, UStatus;
  
{ TWinPrint }

constructor TWinPrint.Create(doc: TContainer);
begin
  inherited Create;

  FDoc := doc;
  if NotNil(FDoc) then
  try
    //Set up the print dialog
    FPrintDialog := TPrintDialog.Create(doc);
    FPrintDialog.MinPage := 1;
    FPrintDialog.MaxPage := FDoc.docForm.TotalPages;
    FPrintDialog.Options := [poPageNums,poWarning];
//    FPrintDialog.Copies := 1;  //causes crash if printer not installed
    FPrintDialog.FromPage := 1;
    FPrintDialog.ToPage := FDoc.docForm.TotalPages;
    FPrintDialog.Collate := False;
  except
    ShowNotice('There was a problem creating the printer dialog. Please check your printer drivers and printer connection.');

    Self.Free;      //lets say bye
  end;
end;

destructor TWinPrint.Destroy;
begin
  Finalize(FPgSpec);
  FPrintDialog.Free;
  
  inherited Destroy;
end;

function TWinPrint.Execute: Boolean;
begin
  result := FPrintDialog.execute;
  if result then
    begin
      ConfigurePagesToPrint;
      if FPrintDialog.Collate then
        FDoc.DoWinPrint(FPrintDialog.Copies, FPgSpec)
      else
        FDoc.DoWinPrint(1, FPgSpec);
    end;
end;

procedure TWinPrint.ConfigurePagesToPrint;
var
	n,z: Integer;
  MinPg,MaxPg: Integer;
begin
  MinPg := FPrintDialog.FromPage-1;
  MaxPg := FPrintDialog.ToPage-1;
  z := FDoc.docForm.TotalPages;

  //Setup the array of page specs
  SetLength(FPgSpec, FDoc.docForm.TotalPages);
	for n := 0 to z-1 do      //Set the printers page array of spec record,
    begin
      FPgSpec[n].PrIndex := 1;                      //always use one

      FPgSpec[n].Copies := FPrintDialog.Copies;     //normal print
      if FPrintDialog.Collate then                  //if collate, set to 1
        FPgSpec[n].Copies := 1;

      FPgSpec[n].OK2Print := True;                  //selected only certain pages
      if FPrintDialog.PrintRange = prPageNums then
        FPgSpec[n].OK2Print := ((n >= MinPg) and (n <= MaxPg));
    end;
end;

end.
