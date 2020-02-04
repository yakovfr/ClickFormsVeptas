unit UStdRspsEdit;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2005 by Bradford Technologies, Inc. }


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, Buttons, UForms;

type
  TEditRsps = class(TAdvancedForm)
    StatusBar1: TStatusBar;
    RspList: TListBox;
    GroupBox1: TGroupBox;
    edtRsp: TEdit;
    btnAdd: TButton;
    GroupBox2: TGroupBox;
    btnOK: TButton;
    btnCancel: TButton;
    btnMoveUp: TBitBtn;
    btnMoveDown: TBitBtn;
    btnSort: TButton;
    btnDelete: TButton;
    btnReplace: TButton;
    btnInsert: TButton;
    procedure btnAddClick(Sender: TObject);
    procedure edtRspKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtRspKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnSortClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure RspListClick(Sender: TObject);
    procedure btnReplaceClick(Sender: TObject);
    procedure btnInsertClick(Sender: TObject);
    procedure btnPasteClick(Sender: TObject);
    procedure btnMoveUpClick(Sender: TObject);
    procedure btnMoveDownClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
		{ Private declarations }
		FModified: Boolean;
		procedure SetRsps(Rsps:String);
		function GetRsps: String;
    procedure AdjustDPISettings;

	public
    constructor Create(AOwner: TComponent); override;
		procedure SetButtonState;
		property Modified: Boolean read FModified write FModified;
		property RspItems: string read GetRsps write SetRsps;
	end;

var
	EditRsps: TEditRsps;

implementation

{$R *.DFM}


uses
  ClipBrd,
  UContainer,
  UEditor,
  UStdRspUtil;

constructor TEditRsps.Create(AOwner: TComponent);
begin
  inherited;

  if assigned(AOwner)then
    if AOwner is TContainer then
      if assigned(TContainer(AOwner).docEditor) and (TContainer(AOwner).docEditor is TTextEditor) then
        begin
          edtRsp.AutoSelect := False;
          edtRsp.text := (TContainer(AOwner).docEditor as TTextEditor).AnsiText;
          edtRsp.SelStart := length(edtRsp.text)+1;   //place cursor at end
        end;
end;


//Load the responses into the list
procedure TEditRsps.SetRsps(Rsps:String);
var
	i, j, m,n: Integer;
	s: String;
begin
	m:= 1;
	j := CountRspItems(Rsps);
	for i := 1 to j do
		begin
			n := Pos('|', Rsps);
			S := Copy(Rsps, 1, n-m);
			RspList.Items.Add(S);
			Delete(Rsps, 1, n);
		end;
  SetButtonState;
end;

function TEditRsps.GetRsps: String;
var
	i: Integer;
begin
	result := '';
	for i := 0 to RspList.Items.count-1 do
		result := result + RspList.items[i] + '|';
end;

procedure TEditRsps.SetButtonState;
var
	hasText: Boolean;
	hasSelection: Boolean;
  hasMultiple: Boolean;
begin
	hasText := (Length(edtRsp.text) > 0);
	hasSelection := (RspList.ItemIndex > -1);
  hasMultiple := RspList.Count > 1;

  btnSort.Enabled := hasMultiple;
  btnMoveUp.Enabled := hasSelection and hasMultiple;
  btnMoveDown.Enabled := hasSelection and hasMultiple;
	btnAdd.Enabled := hasText;
	btnReplace.Enabled := hasText and hasSelection;
	btnDelete.Enabled := hasSelection;
	btnInsert.Enabled := hasText and hasSelection;
end;

procedure TEditRsps.edtRspKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	if Key = VK_RETURN then
		begin
      btnAddClick(sender);
      Key := 0;   //no beeps
    end;
end;

procedure TEditRsps.edtRspKeyUp(Sender: TObject; var Key: Word;
	Shift: TShiftState);
begin
	SetButtonState;
end;

procedure TEditRsps.RspListClick(Sender: TObject);
begin
	if RspList.itemIndex > -1 then
    begin
      edtRsp.AutoSelect := True;
		  edtRsp.text := RspList.Items.Strings[RspList.itemIndex];
    end;
  SetButtonState;
end;

procedure TEditRsps.btnSortClick(Sender: TObject);
begin
	RspList.itemIndex := -1;
	RspList.Sorted := True;      //do it, get
  RspList.Sorted := False;     //ready for next
	FModified := True;
end;

procedure TEditRsps.btnAddClick(Sender: TObject);
begin
	if Length(edtRsp.text) > 0 then
		begin
			RspList.Items.add(edtRsp.text);
			edtRsp.text := '';
			SetButtonState;		//set the button state
			FModified := True;
		end;
end;

procedure TEditRsps.btnDeleteClick(Sender: TObject);
begin
	RspList.Items.Delete(RspList.itemIndex);
	SetButtonState;
	FModified := True;
end;

procedure TEditRsps.btnReplaceClick(Sender: TObject);
begin
	RspList.Items.Strings[RspList.itemIndex] := edtRsp.text;
	edtRsp.text := '';
	RspList.itemIndex := -1;
	SetButtonState;
	FModified := True;
end;

procedure TEditRsps.btnInsertClick(Sender: TObject);
begin
	RspList.Items.Insert(RspList.itemIndex, edtRsp.text);
	edtRsp.text := '';
	RspList.itemIndex := -1;
	SetButtonState;
	FModified := True;
end;

procedure TEditRsps.btnPasteClick(Sender: TObject);
begin
 RspList.Items.Text := ClipBoard.AsText;
 FModified := True;
end;

procedure TEditRsps.btnMoveUpClick(Sender: TObject);
var
	n, n2: integer;
begin
	n := RspList.ItemIndex;
	if n > 0 then
		begin
			n2 := n-1;
			RspList.Items.Exchange(n, n2);       // for display
      FModified := True;
    end
  else
    beep;
end;

procedure TEditRsps.btnMoveDownClick(Sender: TObject);
var
	n, n2: integer;
begin
	n := RspList.ItemIndex;
	If n < RspList.Items.Count-1 then
		begin
			n2 := n+1;
			RspList.Items.Exchange(n, n2);       // for display
      FModified := True;
    end
  else
    beep;
end;

procedure TEditRsps.AdjustDPISettings;
begin
   self.ClientHeight := GroupBox2.Height + GroupBox1.Height + StatusBar1.Height;
   self.ClientWidth := Groupbox1.Width;
   self.Constraints.minHeight := self.Height;
   self.Constraints.MinWidth := self.width;
end;

procedure TEditRsps.FormShow(Sender: TObject);
begin
    AdjustDPISettings;
end;

end.
