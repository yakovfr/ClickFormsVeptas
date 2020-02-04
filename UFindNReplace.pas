unit UFindNReplace;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2005 by Bradford Technologies, Inc. }


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,
  UGlobals, UForms;

type
  TFindNReplace = class(TAdvancedForm)
    Label1: TLabel;
    Label2: TLabel;
		edtFind: TEdit;
    edtReplace: TEdit;
    btnFind: TButton;
		btnReplace: TButton;
    btnReplaceAll: TButton;
    btnCancel: TButton;
    chkMatchWord: TCheckBox;
    procedure btnFindClick(Sender: TObject);
    procedure btnReplaceClick(Sender: TObject);
    procedure btnReplaceAllClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure edtFindChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
		{ Private declarations }
		FFind: String;
		FReplace: String;
    FCellUID: cellUID;
    FStrIndex: Integer;
    FCurSearchFound: Integer;
    FSetActive: Boolean;
		function Direction: Integer;
    procedure AdjustDPISettings;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetSearchStart;
  end;

var
  FindNReplace: TFindNReplace;

implementation

{$R *.DFM}

uses
	UContainer, UEditor, UStatus, UStrings;
	
const
	cFirst 	= True;
	cAll		= False;

constructor TFindNReplace.Create(AOwner: TComponent);
var
  doc: TContainer;
begin
  inherited Create(AOwner);
  doc := TContainer(Owner);
  doc.SetActiveCell;   //github #537  Reset the Active Cell to the very top

  edtFind.Text := appPref_LastFindText;
  edtReplace.Text := appPref_LastReplaceText;
//  FCurSearchFound := 0;  //initialize the count
  FSetActive := False;
end;

destructor TFindNReplace.Destroy;
begin
  FindNReplace := nil;    //set the  var to nil
  
  inherited;
end;

procedure TFindNReplace.SetSearchStart;
var
  doc: TContainer;
begin
  doc := TContainer(Owner);
  FCellUID := doc.docActiveCell.UID;
  FStrIndex := 0;   //start with 1st char
  if (doc.docEditor <> nil)
    and (doc.docEditor is TTextEditor) then
      FStrIndex := (doc.docEditor as TTextEditor).CaretPosition;
end;

procedure TFindNReplace.btnFindClick(Sender: TObject);
var
  nFinds: Integer;
  doc: TContainer;
begin
  if not FSetActive then
    begin
      doc := TContainer(Owner);
      doc.SetActiveCell;
      FSetActive := True;
    end;
  SetSearchStart;
  if CompareText(FFind,edtFind.Text) <> 0 then     //start the new search
    begin
	    FFind := edtFind.Text;
      FCurSearchFound := 0;
    end;

  nFinds := TContainer(Owner).DoFindNReplace(FCellUID, FStrIndex, FFind, '', chkMatchWord.Checked, Direction, cFirst);
  if nFinds = 0 then
    if FCurSearchFound = 0 then
      begin
        FSetActive := False;
        ShowNotice(Format(msgFindNotFound,[AnsiQuotedStr(FFind,#39)]));
      end
    else
      ShowNotice(msgFindReplFinishied)
  else
    begin
      inc(FCurSearchFound);
      btnReplace.Enabled := True;
    end;
end;

procedure TFindNReplace.btnReplaceClick(Sender: TObject);
var
  nFinds: Integer;
  doc: TContainer;
begin
  if not FSetActive then    //github #537
    begin
      doc := TContainer(Owner);
      doc.SetActiveCell;
      FSetActive := True;
    end;

  FFind := edtFind.Text;
  FReplace := edtReplace.text;
  nFinds := TContainer(Owner).DoFindNReplace(FCellUID, FStrIndex, FFind, FReplace, chkMatchWord.Checked, Direction, cFirst);
  if (nFinds <> 0) then
    btnFind.Click
  else
    begin
      FSetActive := False;
      ShowNotice(Format(msgReplNotFound,[AnsiQuotedStr(FFind,#39)]));
    end;
end;

procedure TFindNReplace.btnReplaceAllClick(Sender: TObject);
var
  nFinds: Integer; //YF 06.24.02
  doc: TContainer;
begin
  doc := TContainer(OWner);
  doc.SetActiveCell;
  SetSearchStart;
	FFind := edtFind.Text;
	FReplace := edtReplace.text;
  nFinds := TContainer(Owner).DoFindNReplace(FCellUID, FStrIndex, FFind,FReplace, chkMatchWord.Checked, Direction, cAll);
  if nFinds = 0 then
    ShowNotice(Format(msgReplNotFound,[AnsiQuotedStr(FFind,#39)]))
  else
    ShowNotice(Format(msgReplAllOccur,[nFinds]));
  FSetActive := False;
end;

function TFindNReplace.Direction: Integer;
begin
  result := 0;
(*
	if rdBtnUp.checked then
		result := 1
	else if RdBtnDown.checked then
		result := 2
	else if RdBtnWrap.checked then
		result := 3;
    *)
end;

procedure TFindNReplace.btnCancelClick(Sender: TObject);
begin
  appPref_LastFindText := edtFind.Text;
  appPref_LastReplaceText := edtReplace.Text;

  Close;
end;

procedure TFindNReplace.edtFindChange(Sender: TObject);
begin
  btnReplace.Enabled := False;
end;

//Fix DPI issues
procedure TFindNReplace.AdjustDPISettings;
begin
   self.Width := btnFind.Left + btnFind.Width + 30;
   self.Height := btnCancel.Top + btnCancel.Height + 50;
   self.Constraints.minWidth := self.Width;
   self.Constraints.MinHeight := self.Height;
end;

procedure TFindNReplace.FormShow(Sender: TObject);
begin
   AdjustDPISettings;
end;

end.
