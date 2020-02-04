unit UEditForms;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2005 by Bradford Technologies, Inc. }


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, Commctrl, Buttons, UForms;

type
	IntList = Array[0..50] of integer;
	pIntList = ^IntList;

	TArrangeForms = class(TAdvancedForm)
    StatusBar1: TStatusBar;
    FormList: TListBox;
    Panel2: TPanel;
		btnCancel: TButton;
		btnOK: TButton;
    sBtnDown: TSpeedButton;
		sBtnUp: TSpeedButton;
		procedure sBtnUpClick(Sender: TObject);
    procedure sBtnDownClick(Sender: TObject);
		procedure FormListKeyDown(Sender: TObject; var Key: Word;
			Shift: TShiftState);
  private
		{ Private declarations }
		FDoc: TObject;
    procedure AdjustDPISettings;

	public
		{ Public declarations }
		NewOrder: Array of Integer;  			//new order of the forms
		bReorderForms: Boolean;      			//short cut to know if we need to do something

		constructor Create(AOwner: TComponent); override;
		procedure ArrangeForms;
	end;

var
  ArrangeForms: TArrangeForms;

implementation

Uses
	UUtil1, UContainer, UForm, UDocView;

	
{$R *.DFM}

{ TArrangeForms }

procedure TArrangeForms.AdjustDPISettings;
begin
    btnCancel.Top := btnOK.top + btnOK.Height + 15;
    StatusBar1.Top := btnCancel.Top + btnCancel.Height + 20;
    Width := btnCancel.Left + btnCancel.Width + 50;
    Height := btnCancel.Top + btnCancel.Height + StatusBar1.Height+ 80;
    Constraints.MinWidth := Width;
    Constraints.MinHeight := Height;
end;



constructor TArrangeForms.Create(AOwner: TComponent);
var
	n, z: integer;
begin
	inherited Create(AOwner);            //creates listbox etc.
	bReorderForms := False;
	FDoc := GetTopMostContainer;        //get the doc
	if FDoc <> nil then
		with FDoc as TContainer do
		begin
			z := docForm.count;
			Setlength(NewOrder,z);					//set a list of size z

			FormList.MultiSelect := False;
			FormList.Clear;

			for n := 0 to z -1 do
			begin
//				FormList.Items.add(docform[n].frmInfo.fFormName);
        FormList.Items.Add(docForm[n].frmPage[0].PgTitleName);     //get name of first pg in form
				NewOrder[n] := n;                //copy the cur order list
			end;

			FormList.ItemIndex := 0            //select the first one for display
		end;
    AdjustDPISettings;
end;

procedure TArrangeForms.sBtnUpClick(Sender: TObject);
var
	n, n2, x: integer;
begin
	n := FormList.ItemIndex;
	if n > 0 then
		begin
			n2 := n-1;
			FormList.Items.Exchange(n, n2);       // for display
			x := NewOrder[n2];
			NewOrder[n2] := NewOrder[n];
			NewOrder[n] := x;

			FormList.ItemIndex := n2;
			bReorderForms := True;
		end
	else
		beep;
end;

procedure TArrangeForms.sBtnDownClick(Sender: TObject);
var
	n, n2, x: integer;
begin
	n := FormList.ItemIndex;
	If n < FormList.Items.Count-1 then
		begin
			n2 := n+1;
			FormList.Items.Exchange(n, n2);       // for display
			x := NewOrder[n2];
			NewOrder[n2] := NewOrder[n];
			NewOrder[n] := x;

			FormList.ItemIndex := n2;
			bReorderForms := True;
		end
	else
		beep;
end;

procedure TArrangeForms.FormListKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	if (Key = VK_UP) and (ssCtrl in Shift) then
		begin
			Self.sBtnUpClick(sender);
			Key := 0;
		end
	 else if (Key = VK_DOWN) and (ssCtrl in Shift) then
		begin
			self.sBtnDownClick(sender);
			Key := 0;
		end;
end;

// this routine rearranges the forms
procedure TArrangeForms.ArrangeForms;
var
	i, n, j,k, len: Integer;
	newDocForms: TDocFormList;
	doc: TContainer;
begin
	doc := TContainer(FDoc);

	if bReorderForms then                     //have any forms been reordered
	begin
		newDocForms := TDocFormList.Create(doc);     //create a new list of newly ordered forms

		Len := Length(NewOrder);
		k := 0;
		for i := 0 to Len-1 do                  //for each form
		begin
			n := NewOrder[i];                   	// the form at #i used to #n

			NewDocForms.Add(doc.docForm[n]);     	// copy TDocForm to the new list

			with doc.docForm[n] do
				for j := 0 to frmPage.count-1 do    //for each page in form
					begin
						doc.docView.PageList.Items[k] := frmPage[j].PgDisplay;
            doc.PageMgr.Items[k] := frmPage[j].PgTitleName;   //update docPageList
						inc(k);
					end;
		end;

		doc.docForm.Free;                      	// get rid of the old list, but not forms
		doc.docForm := NewDocForms;							// install the new one
    doc.docForm.OnChanged := doc.OnDocFormChanged;
		doc.docView.ResequencePages;

		doc.ResetCurCellID;                     // reset the cur cell UID
		doc.docForm.RenumberPages;              //renumber the pages
		doc.BuildContentsTable;                 //rebuild the table of contents
    doc.docForm.ReConfigMultiInstances;

		doc.docView.SetFocus;
		doc.docView.Invalidate;
    doc.docForm.OnChanged(doc.docForm);
	end;
end;



end.
