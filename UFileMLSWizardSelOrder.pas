{
  ClickForms
  (C) Copyright 1998 - 2010, Bradford Technologies, Inc.
  All Rights Reserved.
}

unit UFileMLSWizardSelOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RzButton, Buttons,UFileMLSWizard,UForms, ExtCtrls;

type
  TFileMLSWizardSelOrder = class(TAdvancedForm)
    RzBitBtn1: TRzBitBtn;
    RzBitBtn2: TRzBitBtn;
    EditResult: TEdit;
    Label2: TLabel;
    GroupBox: TGroupBox;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    ListBox2: TListBox;
    ListBox1: TListBox;
    ListBox3: TListBox;
    procedure RzBitBtn1Click(Sender: TObject);
    procedure RzBitBtn2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    HasPreviewOp : Boolean;
    OkCancel : Boolean;
    SaveOriginalSeq : String;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure  UpdateResult;
  end;



var
  FileMLSWizardSelOrder: TFileMLSWizardSelOrder;

implementation

Uses
  UGlobals;

{$R *.dfm}

constructor TFileMLSWizardSelOrder.Create(AOwner: TComponent);
begin
   inherited Create(nil);
   OkCancel := True;
end;

destructor TFileMLSWizardSelOrder.Destroy;
begin
   SaveOriginalSeq:= '';
 inherited;
end;

procedure TFileMLSWizardSelOrder.UpdateResult;
var i : Integer;
    str : String;
begin
  Str :='';
  for i := 0 to ListBox3.Count -1 do
   begin
     str := str+' '+ListBox3.Items.Strings[i];
   end;
 EditResult.Text := Str;
end;

procedure TFileMLSWizardSelOrder.RzBitBtn1Click(Sender: TObject);
begin
 OkCancel := True;
 Close;
end;

procedure TFileMLSWizardSelOrder.RzBitBtn2Click(Sender: TObject);
begin
 if HasPreviewOp =  False then
  begin
   SaveOriginalSeq := '';
  end;
 OkCancel := False;
 Close;
end;

procedure TFileMLSWizardSelOrder.FormShow(Sender: TObject);
begin
 UpdateResult;
 SaveOriginalSeq := ListBox1.Items.DelimitedText;
end;

procedure TFileMLSWizardSelOrder.SpeedButton3Click(Sender: TObject);
var
 i : integer;
begin
if ListBox2.ItemIndex > 0 then
  begin
    i := ListBox2.ItemIndex;
    ListBox2.Items.Move(i, i-1);
    ListBox2.ItemIndex := i-1;
    ListBox1.Items.Move(i, i-1);
    ListBox1.ItemIndex := i-1;
    ListBox3.Items.Move(i, i-1);
    ListBox3.ItemIndex := i-1;
    UpdateResult;
  end;
end;

procedure TFileMLSWizardSelOrder.SpeedButton4Click(Sender: TObject);
var
 i : integer;
begin
if (ListBox2.ItemIndex < ListBox2.Items.Count-1) and
    (ListBox2.ItemIndex <> -1) then
  begin
    i := ListBox2.ItemIndex;
    ListBox2.Items.Move(i, i+1);
    ListBox2.ItemIndex := i+1;
    ListBox1.Items.Move(i, i+1);
    ListBox1.ItemIndex := i+1;
    ListBox3.Items.Move(i, i+1);
    ListBox3.ItemIndex := i+1;
    UpdateResult;
  end;
end;

end.
