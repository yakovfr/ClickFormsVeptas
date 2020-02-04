unit UStdCmtsList;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
	StdCtrls, ExtCtrls,
	UEditor, ComCtrls, UForms;

type
  TShowCmts = class(TAdvancedForm)
    cmtText: TMemo;
    Panel1: TPanel;
    btnDone: TButton;
    btnInsert: TButton;
    btnReplace: TButton;
    btnAppend: TButton;
    CommentList: TListBox;
    procedure CommentListClick(Sender: TObject);
    procedure btnInsertClick(Sender: TObject);
    procedure btnReplaceClick(Sender: TObject);
    procedure CommentListKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CommentListDblClick(Sender: TObject);
    procedure btnAppendClick(Sender: TObject);
//    procedure CmtNameChange(Sender: TObject);
    procedure TextKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnDoneClick(Sender: TObject);
    procedure cmtTextChange(Sender: TObject);
  private
    { Private declarations }
		FEditor: TTextEditor;
		FKey: Word;
	public
		procedure LoadCommentGroup(Editor: TTextEditor);
	end;

var
  ShowCmts: TShowCmts;

implementation

{$R *.DFM}


uses
	UUtil1, UStdRspUtil;


{ TShowCmts }

procedure TShowCmts.LoadCommentGroup(Editor: TTextEditor);
var
  groupID: Integer;
  cmt: TComment;
  CmtGroup: TCommentGroup;
begin
  FEditor := Editor;                                  //this is where we will insert comment
  btnAppend.Enabled := (Length(FEditor.AnsiText) > 0);
  btnReplace.Enabled := (Length(FEditor.AnsiText) > 0);
  btnInsert.Enabled := False;

  GroupID := Editor.FCell.FResponseID;
  CmtGroup := AppComments[GroupID];
  if CmtGroup <> nil then
    CommentList.Items.Assign(CmtGroup.FCmtList);

  if CommentList.count > 0 then
    begin
		  CommentList.itemIndex := 0;													//select #1
		  Cmt := TComment(CommentList.Items.Objects[0]);
		  cmtText.Lines.Text := Cmt.FText;                    //show comment
      btnInsert.Enabled := True;
    end;
end;

procedure TShowCmts.CommentListClick(Sender: TObject);
var
	index: Integer;
	Cmt: TComment;
begin
	index := CommentList.itemIndex;
	if index > -1 then
		begin
			Cmt := TComment(CommentList.Items.Objects[index]);
			cmtText.Lines.Text := Cmt.FText;
			btnInsert.Enabled := True;
			btnAppend.Enabled := True;
			btnReplace.Enabled := True;
		end;
end;

procedure TShowCmts.btnInsertClick(Sender: TObject);
begin
  FEditor.InputString(CmtText.Lines.Text);
  CmtText.Lines.Text := '';
  if CommentList.itemIndex > -1 then
    CommentList.itemIndex := -1;
end;

procedure TShowCmts.btnAppendClick(Sender: TObject);
begin
  FEditor.CaretPosition := Length(FEditor.AnsiText);
  FEditor.InputString(CmtText.Lines.Text);
  CmtText.Lines.Text := '';
  if CommentList.itemIndex > -1 then
    CommentList.itemIndex := -1;
end;

procedure TShowCmts.btnReplaceClick(Sender: TObject);
begin
  FEditor.Text := CmtText.Lines.Text;
  CmtText.Lines.Text := '';
  if CommentList.itemIndex > -1 then
    CommentList.itemIndex := -1;
end;

procedure TShowCmts.CommentListKeyDown(Sender: TObject; var Key: Word;
	Shift: TShiftState);
begin
	if char(Key) in ['i','I', #13] then
		btnInsertClick(sender)

	else if char(Key) in ['r','R'] then
		btnReplaceClick(sender);

	if (ssCtrl	in shift) and (char(Key) in ['i','I', #13]) then    //close with Cntl
		ModalResult := mrOk;
end;

procedure TShowCmts.CommentListDblClick(Sender: TObject);
begin
	if ShiftKeyDown then
		btnReplaceClick(sender)
	else
		btnInsertClick(sender);

	if not ControlKeyDown then        //close
		ModalResult := mrOk;
end;

procedure TShowCmts.TextKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	FKey := Key;
  If (Key = VK_INSERT) or (Key = VK_RETURN) then
    begin
      Key := 0;
      btnInsertClick(sender);
      ModalResult := mrOK;
    end;
end;

procedure TShowCmts.btnDoneClick(Sender: TObject);
begin
  Close;
end;

procedure TShowCmts.cmtTextChange(Sender: TObject);
begin
  if Length(CmtText.Lines.Text) > 0 then
    begin
      btnInsert.enabled := true;
      btnReplace.Enabled := (Length(FEditor.AnsiText) > 0);
      btnAppend.Enabled := (Length(FEditor.AnsiText) > 0);
    end
  else
    begin
      btnInsert.enabled := False;
      btnReplace.enabled := False;
      btnAppend.enabled := False;
    end;
end;

end.
