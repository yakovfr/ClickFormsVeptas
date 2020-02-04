unit UCellIDSearch;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted 1998 - 2011 by Bradford Technologies, Inc. }

{ This is procedure for finding a cell by its cellID and CellXID }
{ It can be extended to find cells by other properties           }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls,ComCtrls, Grids_ts, TSGrid, osAdvDbGrid,
  UContainer, UForms;

type
  TCellIDSearch = class(TAdvancedForm)
    btnSearch: TButton;
    inputCellID: TEdit;
    btnSave: TButton;
    StatusBar1: TStatusBar;
    CellList: TosAdvDbGrid;
    btnPrint: TButton;
    rbtnXMLID: TRadioButton;
    rbtnCellID: TRadioButton;
    procedure ProcessClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure CellListButtonClick(Sender: TObject; DataCol,
      DataRow: Integer);
    procedure btnPrintClick(Sender: TObject);
    procedure inputCellIDKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rbtnXMLIDClick(Sender: TObject);
    procedure rbtnCellIDClick(Sender: TObject);
  private
    FSearchCellID: Integer;
    FDoc: TContainer;
    FfilePath: String;
    InCellID: String;

    procedure DoCellIDSearch;
    procedure ValidateUserInput;
    procedure SearchForCellIdentifier(CellIDTyp: Integer);
//    procedure SearchForCellXID;
    procedure WriteSearchResults;
    procedure ClearCellList;
   public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  CellIDSearch: TCellIDSearch;



  procedure FindCellByAttribute(doc: Tcontainer);


implementation

uses
  UGlobals, UUtil1, UStatus, UCell;

const
  cCellID   = 1;
  cCellXID  = 2;

{$R *.dfm}


procedure FindCellByAttribute(Doc: TContainer);
begin
  if CellIDSearch = nil then
    CellIDSearch := TCellIDSearch.Create(Doc);

   CellIDSearch.Show;
end;



constructor TCellIDSearch.Create(AOwner: TComponent);
begin
  inherited Create(Nil);

  FDoc := TContainer(AOwner);

  FfilePath := 'C:\AppraisalWorld\CellID.txt';
end;

destructor TCellIDSearch.Destroy;
begin
  CellIDSearch := nil;    //set the  var to nil
  
  inherited;
end;

procedure TCellIDSearch.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TCellIDSearch.ValidateUserInput;
begin
  InCellID:=  inputCellID.Text;
  FSearchCellID := StrToIntDef(inputCellID.Text, 0);

   //check if the user entered ID
  if (FSearchCellID <= 0) then
    raise exception.create('You must enter a vaild Cell ID for searching.');
end;

procedure TCellIDSearch.SearchForCellIdentifier(CellIDTyp: Integer);
var
  numForms, f,p,c,n, CellXID, CellID: Integer;
  fID, pgNum, cellNum: Integer;
  found,foundMatch: Boolean;
begin
  FDoc := TContainer(GetTopMostContainer);     //get the doc
  if not assigned(FDoc) or (FDoc.docForm.count = 0) then
    raise exception.create('There are no forms to search.');

  n := 1;
  found := False;
  numForms := Fdoc.docForm.count;
  for f := 0 to numForms -1 do //for each form
   for p := 0 to FDoc.docForm[f].frmPage.Count -1 do //for each page
    if assigned(FDoc.docForm[f].frmPage[p].pgData) then
     for c := 0 to FDoc.docForm[f].frmPage[p].pgData.count-1 do  //for each cell
       begin
         CellID := FDoc.docForm[f].frmPage[p].pgData[c].FCellID;   //load the cell ids
         CellXID := FDoc.docForm[f].frmPage[p].pgData[c].FCellXID;

         foundMatch := False;
         if CellIDTyp = cCellID then
           foundMatch := (CellID = FSearchCellID)
         else if CellIDTyp = cCellXID then
           foundMatch := (CellXID = FSearchCellID);

         if foundMatch then
            begin
              fID := FDoc.docForm[f].frmSpecs.fFormUID;
              pgNum := p +1;
              cellNum := c +1;

              if n > 1 then CellList.Rows := n;         //create a new row, if more than 1
              CellList.Cell[1,n] := IntToStr(fID);
              CellList.Cell[2,n] := IntToStr(pgNum);
              CellList.Cell[3,n] := IntToStr(cellNum);
              CellList.Cell[4,n] := IntToStr(CellID);
              CellList.Cell[5,n] := IntToStr(CellXID);

              Inc(n);
              found := True;
            end;
       end;

  if not found then    //feedback if not found
    begin
      CellList.Cell[1,1] := '0';
      CellList.Cell[2,1] := '0';
      CellList.Cell[3,1] := '0';
      if CellIDTyp = cCellID then
        begin
          CellList.Cell[4,1] := IntToStr(FSearchCellID);
          CellList.Cell[5,1] := 0;
        end
      else
        begin
          CellList.Cell[4,1] := 0;
          CellList.Cell[5,1] := IntToStr(FSearchCellID);
        end;
    end;
end;
(*
procedure TCellIDSearch.SearchForCellXID;
var
  numForms, f,p,c,n, CellID,CellXID: Integer;
  fID, pgNum, cellNum: Integer;
  found: Boolean;
begin
  FDoc := TContainer(GetTopMostContainer);     //get the doc
  if not assigned(FDoc) or (FDoc.docForm.count = 0) then
    raise exception.create('There are no forms to search.');

  n := 1;
  found := False;
  numForms := Fdoc.docForm.count;
  for f := 0 to numForms -1 do //for each form
   for p := 0 to FDoc.docForm[f].frmPage.Count -1 do //for each page
    if assigned(FDoc.docForm[f].frmPage[p].pgData) then
     for c := 0 to FDoc.docForm[f].frmPage[p].pgData.count-1 do  //for each cell
       begin
         CellID := FDoc.docForm[f].frmPage[p].pgData[c].FCellID;      //load the cell id
         CellXID := FDoc.docForm[f].frmPage[p].pgData[c].FCellXID;   //load the cell ids
         if (CellXID = FSearchCellID) then
            begin
              fID := FDoc.docForm[f].frmSpecs.fFormUID;
              pgNum := p +1;
              cellNum := c +1;

              if n > 1 then CellList.Rows := n;         //create a new row, if more than 1
              CellList.Cell[1,n] := IntToStr(fID);
              CellList.Cell[2,n] := IntToStr(pgNum);
              CellList.Cell[3,n] := IntToStr(cellNum);
              CellList.Cell[4,n] := IntToStr(FSearchCellID);
              CellList.Cell[5,n] := IntToStr(FSearchCellID);

              Inc(n);
              found := True;
            end;
       end;

  if not found then    //feedback if not found
    begin
      CellList.Cell[1,1] := '0';
      CellList.Cell[2,1] := '0';
      CellList.Cell[3,1] := '0';
      CellList.Cell[4,1] := IntToStr(FSearchCellID);
    end;
end;
*)
procedure TCellIDSearch.ClearCellList;
begin
 CellList.Rows := 0;    //lazy delete
 CellList.Rows := 1;    //reset to 1
end;

procedure TCellIDSearch.DoCellIDSearch;
begin
  ClearCellList;
  try
    ValidateUserInput;
    if rbtnCellID.Checked then
      SearchForCellIdentifier(cCellID)
    else
      SearchForCellIdentifier(cCellXID);
  except
    on E: Exception do ShowNotice(E.message);
  end;
end;

procedure TCellIDSearch.ProcessClick(Sender: TObject);
begin
  DoCellIDSearch
end;

procedure TCellIDSearch.btnSaveClick(Sender: TObject);
begin
  WriteSearchResults;
end;

procedure TCellIDSearch.CellListButtonClick(Sender: TObject; DataCol,DataRow: Integer);
var
  strFmID, strPgNo, strCellNo: String;
  cell: TBaseCell;
  theCell: CellUID;
begin
  strFmID := CellList.Cell[1, DataRow];  //no variants
  strPgNo := CellList.Cell[2, DataRow];
  strCellNo := CellList.Cell[3, DataRow];

  theCell.formID := StrToInt(strFmID);
  theCell.pg := StrToInt(strPgNo) - 1;
  theCell.num := StrToInt(strCellNo) - 1;
  theCell.Occur := 0;
  theCell.form := -1;

  cell := FDoc.GetCell(theCell);    //do this for save ones
  if assigned(cell) then
    FDoc.Switch2NewCell(Cell, cNotClicked);
end;

procedure TCellIDSearch.btnPrintClick(Sender: TObject);
begin
  inputCellID.text := '';   //clear the input field
  ClearCellList;
end;

procedure TCellIDSearch.inputCellIDKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if(Key = VK_RETURN) then
    DoCellIDSearch;
end;

//procedure not used - expand to write out results
procedure TCellIDSearch.WriteSearchResults;
var
  err: Integer;
  output: string;
  hFile : Integer;
begin
//  output:= output+ 'The form '+ doc.docForm[f].frmSpecs.fFormName +#13#10+ '   Page '+ doc.docForm[f].frmPage[p].pgDesc.PgName;
//  found:= true;
//  output:= output+ '        Cell ' + IntToStr(c+1) +#13#10;

  if (FileExists(FfilePath)) then
    DeleteFile(FfilePath);

  hFile :=  FileCreate(FfilePath, fmOpenWrite);
  try
    err:= FileWrite(hFile, PChar(output)^, Length(output));
    if (err>0) then
      ShowNotice('The data was saved to file "'+ FfilePath + '".' + #13#10)        //+output)
    else
      ShowNotice ('Error: The data was not saved');
  finally
    FileClose (hFile);
  end;
end;



procedure TCellIDSearch.rbtnXMLIDClick(Sender: TObject);
begin
  CellList.Col[4].Heading := 'XML ID';
end;

procedure TCellIDSearch.rbtnCellIDClick(Sender: TObject);
begin
  CellList.Col[4].Heading := 'Cell ID';
end;

(*
procedure TCellIDSeach.ProcessClick(Sender: TObject);
var
  doc: TContainer;
  tmpForm: TDocForm;
  numForms, f,p,c, CellID, result: Integer;
  ID: TFormUID;
  output: string;
  found: WordBool;
begin

  if (FileExists(filePath)) then
  DeleteFile(filePath);

  ValidateUserInput;                  //check user input
  doc := TContainer(GetTopMostContainer);

  if (doc=nil) then
    begin
      ShowNotice('Document is not opened.');
      Close;
    end
  else
    begin
      numForms := doc.docForm.count;
      output:= 'Cell Id ' + InCellID + ' found:'+#13#10;
      found:= false;
      if (doc <> nil) and (numForms > 0) then
         for f := 0 to numForms -1 do //for each form
           for p := 0 to doc.docForm[f].frmPage.Count -1 do //for each page
             for c := 0 to doc.docForm[f].frmPage[p].pgDesc.PgCellSeqCount -1 do  //for each cell
               begin
                 CellID := doc.docForm[f].frmPage[p].pgData[c].FCellID;   //load the cell ids
                 if (CellID = StrToInt(InCellID)) then
                    begin
                      output:= output+ 'The form '+ doc.docForm[f].frmSpecs.fFormName +#13#10+ '   Page '+ doc.docForm[f].frmPage[p].pgDesc.PgName;
                      found:= true;
                      output:= output+ '        Cell ' + IntToStr(c+1) +#13#10;
                    end;
               end;

      if found then
        begin
          hFile :=  FileCreate(filePath, fmOpenWrite);
          result:= FileWrite(hFile, PChar(output)^, Length(output));
          if (result>0) then
            ShowNotice('The data saved to file: '+ filePath + #13#10)        //+output)
          else
            ShowNotice ('Error: Data was not saved');
          FileClose (hFile);
          Close;
        end
      else
        ShowNotice('Cell Id not Found');
      output:='';
    end;
end;
*)

end.

