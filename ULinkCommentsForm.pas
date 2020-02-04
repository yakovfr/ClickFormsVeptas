
{
  ClickForms
  (C) Copyright 1998 - 2009, Bradford Technologies, Inc.
  All Rights Reserved.
}

unit ULinkCommentsForm;

interface

uses
  ActnList,
  Classes,
  Controls,
  ExtCtrls,
  StdCtrls,
  UForms;

type
  TFormLinkComments = class(TAdvancedForm)
    actCancel: TAction;
    actOK: TAction;
    btnCancel: TButton;
    btnOK: TButton;
    fldAsk: TCheckBox;
    fldHeading: TEdit;
    lblHeading: TLabel;
    pnlHeading: TPanel;
    slHeading: TActionList;
    procedure actCancelExecute(Sender: TObject);
    procedure actOKUpdate(Sender: TObject);
    procedure btnOKKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnOKClick(Sender: TObject);
  private
    FKeyDown : word;
    function GetAsk: String;
    procedure SetAsk(const Value: String);
    function GetHeading: String;
    procedure SetHeading(const Value: String);
  published
    property Ask: String read GetAsk write SetAsk;
    property Heading: String read GetHeading write SetHeading;
  end;

implementation

uses
  SysUtils;

const
 	kSpaceKey 	= $20;

  
{$R *.dfm}

procedure TFormLinkComments.actCancelExecute(Sender: TObject);
begin
  actCancel.Enabled := True;
end;

procedure TFormLinkComments.actOKUpdate(Sender: TObject);
begin
  actOK.Enabled := (fldHeading.Text <> '');
end;

function TFormLinkComments.GetAsk: String;
begin
  if fldAsk.Checked then
    Result := 'No'
  else
    Result := 'Yes';
end;

procedure TFormLinkComments.SetAsk(const Value: String);
begin
  fldAsk.Checked := SameText(Value, 'No');
end;

function TFormLinkComments.GetHeading: String;
begin
  Result := fldHeading.Text;
end;

procedure TFormLinkComments.SetHeading(const Value: String);
begin
  if (Value <> fldHeading.Text) then
    fldHeading.Text := Value;
end;

procedure TFormLinkComments.btnOKKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //Trap key down
  case Key of
    kSpaceKey: FKeyDown := kSpaceKey;
    else FKeyDown := Key;
  end;
end;

procedure TFormLinkComments.btnOKClick(Sender: TObject);
begin
  if FKeyDown = kSpaceKey then
  begin
     ModalResult := mrNone;
     FKeyDown := 0;  //reset the key
  end
  else
     ModalResult := mrOK;
end;

end.
