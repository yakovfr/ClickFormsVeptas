unit UDeleteForm;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2006 by Bradford Technologies, Inc. }


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, Grids_ts, TSGrid, UForms;

type
  TDeleteForms = class(TAdvancedForm)
		StatusBar1: TStatusBar;
    Panel2: TPanel;
    btnCancel: TButton;
    btnDelete: TButton;
    GridDeleteList: TtsGrid;
    procedure GridDeleteListClickCell(Sender: TObject; DataColDown,
      DataRowDown, DataColUp, DataRowUp: Integer; DownPos,
      UpPos: TtsClickPosition);
    procedure btnDeleteClick(Sender: TObject);
	private
		{ Private declarations }
		FormDoc: TObject;
    procedure AdjustDPISettings;
  public
		{ Public declarations }
		constructor Create(AOwner: TComponent); override;
		procedure DeleteForms;
  end;

var
	DeleteForms: TDeleteForms;

implementation

Uses
  UBase,
  UCell,
  UContainer,
  UForm,
  UGlobals,
  UStatus,
  UUtil1,
  UWordProcessor;

{$R *.DFM}


procedure TDeleteForms.AdjustDPISettings;
begin
    btnCancel.Top := btnDelete.top + btnDelete.Height + 15;
    StatusBar1.Top := btnCancel.Top + btnCancel.Height + 20;
    Width := btnCancel.Left + btnCancel.Width + 50;
    Height := btnCancel.Top + btnCancel.Height + StatusBar1.Height+ 80;
    Constraints.MinWidth := Width;
    Constraints.MinHeight := Height;
end;


constructor TDeleteForms.Create(AOwner: TComponent);
var
	n, z: integer;
	doc: TContainer;
begin
	inherited Create(AOwner);

	FormDoc := GetTopMostContainer;                    //remember it

	doc := TContainer(FormDoc);                        //use as TContainer;
	if doc <> nil then
	begin
		z := doc.docForm.count;

		GridDeleteList.Rows := z;
		GridDeleteList.Col[1].width := 30;
		GridDeleteList.Col[1].ControlType := ctCheck;
//		GridDeleteList.Col[1].Color := clRed;

		GridDeleteList.Col[2].width :=  GridDeleteList.width - 30 - 16;
		GridDeleteList.Col[2].ControlType := ctText;
		GridDeleteList.Col[2].ReadOnly := true;
		for n := 1 to z do
		begin
			GridDeleteList.Cell[1,n] := cbUnchecked;
//			GridDeleteList.Cell[2,n] := doc.docForm[n-1].frmInfo.fFormName;
      GridDeleteList.Cell[2,n] := doc.docForm[n-1].frmPage[0].PgTitleName;
		end;
	end;
  AdjustDPISettings;  
end;

procedure AllowDelete;
begin
end;

procedure TDeleteForms.DeleteForms;
var
  Cell: TBaseCell;
  DeleteList: TList;
  Document: TContainer;
  Index: Integer;
  Message: TMsg;
begin
  if Assigned(FormDoc) and (FormDoc is TContainer) then
    begin
      Document := (FormDoc as TContainer);
      DeleteList := TList.Create;
      try
        // create list of forms to delete
        for Index := 0 to Document.docForm.Count - 1 do
          if (GridDeleteList.Cell[1, Index + 1] = cbChecked) then
            DeleteList.Add(Document.docForm[Index]);

        // check if we are removing the form of the current cell
        if Assigned(Document.docActiveCell) then
          if (DeleteList.IndexOf(Document.docForm[Document.docActiveCell.UID.Form]) >= 0) then
            Document.RemoveCurCell;

        for Index := 0 to DeleteList.Count - 1 do
          begin
            Cell := TDocForm(DeleteList[Index]).GetCellByID(CWordProcessorCellID);
            if (Cell is TWordProcessorCell) then
              (Cell as TWordProcessorCell).DeletePage
            else
              TDocForm(Document.docForm.Extract(DeleteList[Index])).Free;
          end;
      finally
        FreeAndNil(DeleteList);
      end;

      Document.docView.ResequencePages;
      Document.docForm.RenumberPages;
      Document.BuildContentsTable;
      Document.docForm.ReConfigMultiInstances;
      Document.BuildPageMgrList;
      Document.DisplayPageCount;
      Document.ResetCurCellID;

      // cell move messages with goDirect may now contain an invalid cell pointer
      while PeekMessage(Message, Document.Handle, CLK_CELLMOVE, CLK_CELLMOVE, PM_REMOVE) do;
    end;
end;

procedure TDeleteForms.GridDeleteListClickCell(Sender: TObject; DataColDown,
	DataRowDown, DataColUp, DataRowUp: Integer; DownPos,
	UpPos: TtsClickPosition);
var
	n: Integer;
	enabledDelete: Boolean;
  i: Integer;
	checked: Boolean;
begin
	enabledDelete := False;
  //Clicking in column 2 is same as clicking in checkbox
  with GridDeleteList do
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

	for n := 1 to GridDeleteList.Rows do
		if GridDeleteList.Cell[1,n] = cbChecked then
			enabledDelete := true;

	btnDelete.Enabled := enabledDelete;                    //set the delete button state
end;

procedure TDeleteForms.btnDeleteClick(Sender: TObject);
var
  AskQuestion: String;
begin
  AskQuestion := 'Are you sure you want to remove the form(s) and all their pages from the report? Any data in the forms will be lost.';
  if WarnOK2Continue(AskQuestion) then
    ModalResult := mrOK;
end;

end.
