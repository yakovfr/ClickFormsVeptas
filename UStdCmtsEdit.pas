unit UStdCmtsEdit;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2005 by Bradford Technologies, Inc. }


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, Buttons, UForms;

type
	//NOTE: Comment Editor creates comments that have RTLF chars so that it
	//displays properly in the Memo control. clickforms uses only
	//the Return char for starting a new line. So we need to adjust.
	//We use AdjustLineBreaks to insert RTLF in text saved from a text cell.


	TEditCmts = class(TAdvancedForm)
		cmtText: TMemo;
    CommentList: TListBox;
    StatusBar1: TStatusBar;
    Panel1: TPanel;
		btnSort: TButton;
		btnOk: TButton;
		btnCancel: TButton;
    Panel2: TPanel;
    Label1: TLabel;
		cmtName: TEdit;
    btnAdd: TButton;
		btnDelete: TButton;
    btnUpdate: TButton;
    btnMoveUp: TBitBtn;
    btnMoveDown: TBitBtn;
    procedure cmtNameKeyDown(Sender: TObject; var Key: Word;
			Shift: TShiftState);
    procedure btnAddClick(Sender: TObject);
		procedure btnSortClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
		procedure cmtNameKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
		procedure CommentListClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
		procedure cmtTextKeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelClick(Sender: TObject);
    procedure cmtTextKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnMoveUpClick(Sender: TObject);
    procedure btnMoveDownClick(Sender: TObject);
    procedure btnOnChange(Sender: TObject);
  private
		{ Private declarations }
		FModified: Boolean;          //group changed
		FCmtChged: Boolean;          //individual comment changed
    FUpdating: Boolean;          //updating comment mode
    FGroupID: Integer;
	public
    constructor Create(AOwner: TComponent); override;
		procedure SetButtonState;
    procedure LoadCommentGroup(GroupID: Integer);
    procedure SaveCommentGroup;
		procedure LoadCurComment(CmtStr: String);
		property Modified: Boolean read FModified write FModified;
	end;

var
	EditCmts: TEditCmts;

implementation

{$R *.DFM}

Uses
	UStatus, UStdRspUtil;

constructor TEditCmts.Create(AOwner: TComponent);
begin
  inherited;

  FModified := False;
  FCmtChged := False;
  FUpdating := False;
  FGroupID := 0;

  SetButtonState;
end;

procedure TEditCmts.btnCancelClick(Sender: TObject);
var
  i: Integer;
  Cmt: TComment;
begin
  //user canceled, so delete the tmp text objects
	for i := 0 to CommentList.items.count-1 do
		begin
			Cmt := TComment(CommentList.Items.Objects[i]);
			if cmt <> nil then Cmt.Free; 		//free the stored text
		end;
  CommentList.Clear;
end;

procedure TEditCmts.SetButtonState;
var
	hasName{//JJ, hasCmt}: Boolean;
	hasSelection: Boolean;
begin
	hasName := (Length(CmtName.text) > 0);
//JJ	hasCmt := (Length(cmtText.Lines.text)> 0);
	hasSelection := (CommentList.ItemIndex > -1);

	btnAdd.Enabled := hasName and not FUpdating;
	btnUpdate.Enabled := hasName and hasSelection;
	btnDelete.Enabled := hasSelection;
end;

procedure TEditCmts.cmtNameKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	if Key = VK_RETURN then
		btnAddClick(sender);

  FUpdating := False;
  btnAdd.Enabled := length(CmtName.text) > 0;
end;

procedure TEditCmts.cmtTextKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//	if Key = VK_RETURN then
//		btnUpdateClick(sender);
end;

procedure TEditCmts.cmtNameKeyUp(Sender: TObject; var Key: Word;
	Shift: TShiftState);
begin
	SetButtonState;
end;

procedure TEditCmts.cmtTextKeyPress(Sender: TObject; var Key: Char);
begin
	SetButtonState;
	FCmtChged := True;
end;

procedure TEditCmts.btnAddClick(Sender: TObject);
var
	Cmt: TComment;
begin
	if btnAdd.Enabled and (Length(cmtName.text) > 0) then
		begin
			Cmt := TComment.create;
			Cmt.FText := cmtText.Lines.text;
			CommentList.Items.addObject(CmtName.text, Cmt);
			cmtName.text := '';
			cmtText.Lines.text := '';
			CommentList.itemIndex := -1;
			FCmtChged := False;
			SetButtonState;

			cmtText.SetFocus;    //get set to start over
			FModified := True;
		end;
end;

procedure TEditCmts.btnDeleteClick(Sender: TObject);
var
	index: Integer;
	Cmt: TComment;
begin
	index := CommentList.itemIndex;
	if index > -1 then begin
		Cmt := TComment(CommentList.Items.Objects[index]);
		Cmt.Free; 		//free the memo text
		CommentList.Items.Delete(index);
		cmtName.text := '';
		CmtText.Lines.Text := '';
		FCmtChged := False;
		SetButtonState;

		CmtText.SetFocus;
		FModified := True;
	end;
end;

procedure TEditCmts.btnUpdateClick(Sender: TObject);
var
	index: Integer;
	Cmt: TComment;
begin
	index := CommentList.itemIndex;
  if index > -1 then
    begin
      Cmt := TComment(CommentList.Items.Objects[index]);   //get the memo
      Cmt.FText := cmtText.Lines.text;                     //chg the comment
      CommentList.Items.Strings[index] := cmtName.text;    //update the comment name

      CommentList.itemIndex := -1;                        //remove selection
      cmtName.text := '';                 //reset
      cmtText.Lines.text := '';
      FCmtChged := False;
      FUpdating := False;
      SetButtonState;

      cmtText.SetFocus;    //get set to start over
      FModified := True;

      SetButtonState;
    end;
end;

procedure TEditCmts.CommentListClick(Sender: TObject);
var
	index: Integer;
	Cmt: TComment;
begin
	index := CommentList.itemIndex;
	if index > -1 then
		begin
			cmtName.Text := CommentList.Items.Strings[index];
			Cmt := TComment(CommentList.Items.Objects[index]);
			cmtText.Lines.Text := Cmt.FText;
			FCmtChged := False;
      FUpdating := True;
			btnDelete.Enabled := True;
		end;
end;

procedure TEditCmts.LoadCommentGroup(GroupID: Integer);
var
  Cmt: TComment;
  CmtGroup: TCommentGroup;
  n: Integer;
begin
	FCmtChged := False;
	FModified := False;
  FGroupID := GroupID;

  CmtGroup := AppComments[GroupID];
  if CmtGroup <> nil then
    with CmtGroup do         //make a copy, since user may cancel changes
      for n := 0 to FCmtList.count-1 do
        begin
          Cmt := TComment.Create;          											//new comment object
          Cmt.FText := TComment(FCmtList.Objects[n]).FText;     //copy the comment
          CommentList.Items.addObject(FCmtList[n], Cmt);        //insert into editor
        end;
end;

//when finished edited, save the comment group back to the file
procedure TEditCmts.SaveCommentGroup;
var
  CmtGroup: TCommentGroup;
  n: Integer;
begin
  CmtGroup := AppComments[FGroupID];
  if CmtGroup <> nil then
    with CmtGroup do
      begin
        for n := 0 to FCmtList.count-1 do       //clear what was there
          FCmtList.Objects[n].Free;
        FCmtList.Clear;

        FCmtList.Assign(CommentList.Items);     //should copy name & object
        AppComments.Modified := True;
      end;
end;

//used to save current selected or cell text
procedure TEditCmts.LoadCurComment(CmtStr: String);
begin
	if length(CmtStr) > 0 then
		begin
			FCmtChged := True;
			CmtText.Text := AdjustLineBreaks(CmtStr);    //need true CR/LF sequences
		end;
end;

procedure TEditCmts.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
	if FCmtChged and not (ModalResult = mrCancel) then
		if OK2Continue('The changes to the current comment have not been saved. Want to close anyway?' +#13#10#13#10 + 'To save, click "No" then click the "Add To List" button to save the changes.') then
      begin
        btnUpdateClick(nil);
        CanClose := True;
      end
    else
      CanClose := False;
end;

procedure TEditCmts.btnSortClick(Sender: TObject);
begin
	CommentList.itemIndex := -1;
	CommentList.Sorted := True;
  CommentList.Sorted := False;     //ready for next
	FModified := True;
end;

procedure TEditCmts.btnMoveUpClick(Sender: TObject);
var
	n, n2: integer;
begin
	n := CommentList.ItemIndex;
	if n > 0 then
		begin
			n2 := n-1;
			CommentList.Items.Exchange(n, n2);       // for display
      FModified := True;
    end
  else
    beep;
end;

procedure TEditCmts.btnMoveDownClick(Sender: TObject);
var
	n, n2: integer;
begin
	n := CommentList.ItemIndex;
	If n < CommentList.Items.Count-1 then
		begin
			n2 := n+1;
			CommentList.Items.Exchange(n, n2);       // for display
      FModified := True;
    end
  else
    beep;
end;

procedure TEditCmts.btnOnChange(Sender: TObject);
begin
  if not FUpdating then
    btnAdd.Enabled := true;  //do this once
  FModified := true;
end;


end.
