unit UAMC_SelectForms;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids_ts, TSGrid, osAdvDbGrid,
  UContainer, UGlobals, UAMC_Base, UAMC_WorkflowBaseFrame, ComCtrls;

type
  TAMC_SelectForms = class(TWorkflowBaseFrame)
    ExportFormGrid: TosAdvDbGrid;
    StatusBar1: TStatusBar;
    procedure ExportFormGridClickCell(Sender: TObject; DataColDown,
      DataRowDown, DataColUp, DataRowUp: Integer; DownPos,
      UpPos: TtsClickPosition);
  public
    constructor CreateFrame(AOwner: TComponent; ADoc: TContainer; AData: TDataPackage);  override;
    procedure InitPackageData; override;
    procedure DoProcessData;   override;
    function ProcessedOK: Boolean; override;
  end;

implementation

{$R *.dfm}

uses
  UAMC_XMLUtils, UForm, UUtil1;

const
  fkUADWorksheet = 981;

{ TAMC_SelectForms }
(*
constructor TAMC_SelectForms.CreateFrame(AOwner: TComponent; ADoc: TContainer; AData: TDataPackage);
begin
  inherited;

//  FPgList   := nil;
//  FFormList := nil;
end;
*)
(*
destructor TAMC_SelectForms.Destroy;
begin
  if assigned(FPgList) then
    FPgList := nil;          //frees the list

  if assigned(FFormList) then
    FFormList := nil;

  inherited;
end;
*)
Constructor TAMC_SelectForms.CreateFrame(AOwner: TComponent; ADoc: TContainer; AData: TDataPackage);
begin
  inherited;
  InitPackageData;
end;

procedure TAMC_SelectForms.InitPackageData;
var
  f,n,formKind: Integer;
  hasPrevSettings: Boolean;
begin
  PackageData.FGoToNextOk := True;
  PackageData.FHardStop := False;
  PackageData.FAlertMsg := '';
  PackageData.FState := FDoc.GetCellTextByID(cSubjectStateCellID);

  hasPrevSettings := Length(PackageData.FFormList) > 0;
  if assigned(FDoc) then
    begin
      if FDoc.docForm.count > 0 then
        with ExportFormGrid do
          begin
            Rows := CountReportForms(FDoc);    //set the number of rows
            n := 0;
            for f := 0 to FDoc.docForm.count-1 do
              begin
                formKind := FDoc.docForm[f].frmInfo.fFormKindID;
                if hasPrevSettings then
                  begin
                    if PackageData.FFormList[f] then
                      Cell[1,n+1] := cbChecked
                    else
                      Cell[1,n+1] := cbUnchecked;
                  end
                else
                  begin
                    {if Not specified by the AMC then---- such as no Invoice for RELS}
                    //state New York now requires include invoice to the report
                    if (formKind = fkOrder) or (formKind = fkWorksheetUAD) or (formKind = fkWorksheetCVR) or
                        ((formKind = fkInvoice) and not (CompareText(PackageData.FState, 'NY') = 0)) then
                      Cell[1,n+1] := cbUnchecked
                    else
                      Cell[1,n+1] := cbChecked;
                  end;

                Cell[2,n+1] := GetReportFormName(FDoc.docForm[f]);
                inc(n);
              end;
          end;
    end;
end;

//this routnie gets the form and page list that the
//user wants to export - forms is for MISMO, pages for pdf
//there is one row in grid for every form - not every page
//procedure TAMC_SelectForms.GetExportFormList;
procedure TAMC_SelectForms.DoProcessData;
var
  f,p,n: Integer;
//  formKind: integer;
  AFormList: BooleanArray;
  APgList: BooleanArray;
begin
  with ExportFormGrid, FDoc do
    begin
      AFormList := nil;
      APgList := nil;
      SetLength(AFormList, docForm.count);      //array of forms to export to XML
      //in case total page is 0 check if we have the form, set page count to at least 1 for aPgList arrage not to fail.
      if docForm.TotalPages = 0 then
      begin
        if docForm.Count > 0 then
          docForm.TotalPages := 1;
      end;

      SetLength(APgList, docForm.TotalPages);   //array of pages to PDF

      n := 0;
      for f := 0 to docForm.Count-1 do
        begin
          //force Order & Invoices to be unchecked
//          formKind := docForm[f].frmInfo.fFormKindID;
//          if (formKind = fkInvoice) or (formKind = fkOrder) {formKind = fkUADWorksheet}then
//            Cell[1,f+1] := cbUnchecked;
          AFormList[f] := (Cell[1,f+1] = cbChecked);   //is form exported

          //now on a page basis, set their flag also for PDF
          for p := 0 to docForm[f].frmPage.Count-1 do
            with docForm[f].frmPage[p] do
              begin
                FPgFlags := SetBit2Flag(FPgFlags, bPgInPDFList, AFormList[f]);  //remember in doc
                APgList[n] := AFormList[f];
                inc(n);
              end;
        end;

      PackageData.PgList := APgList;
      PackageData.FormList := AFormList;

      APgList := nil;
      AFormList := nil;
    end;
end;

function TAMC_SelectForms.ProcessedOK: Boolean;
var
  hasForms: Boolean;
  f: Integer;
begin
  hasForms := False;

  with ExportFormGrid do
    for f := 1 to Rows do
      if (Cell[1,f] = cbChecked) then
        hasForms := True;               //must have at least one form checked

  PackageData.FGoToNextOk := hasForms;
  PackageData.FHardStop := not hasForms;
  PackageData.FAlertMsg := '';
  if not hasForms then
    PackageData.FAlertMsg := 'You must have at least one form in the appraisal report.';

  result := PackageData.FGoToNextOk;
end;

procedure TAMC_SelectForms.ExportFormGridClickCell(Sender: TObject;
  DataColDown, DataRowDown, DataColUp, DataRowUp: Integer; DownPos,
  UpPos: TtsClickPosition);
var
	i: Integer;
	checked: Boolean;
begin
//Clicking in column form name is same as clicking in checkbox
   with ExportFormGrid do
    begin
      //handle toggle if clicked in  column form name, else let chkbox do it
      if (DataColDown = 2) and (DataRowDown > 0) then
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
              else   //just run same check state down list
                if checked then
                  Cell[1,i] := cbChecked
                else
                  Cell[1,i] := cbUnChecked;
            end;
        end
   end;
end;

end.
