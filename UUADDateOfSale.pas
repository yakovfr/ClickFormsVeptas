unit UUADDateOfSale;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, Dialogs, UCell, UUADUtils, UContainer, UEditor, UGlobals,
  UStatus, Mask, RzEdit, RzSpnEdt, DateUtils, ExtCtrls, StrUtils,
  UForms;

type
  TdlgUADDateOfSale = class(TAdvancedForm)
    bbtnCancel: TBitBtn;
    bbtnOK: TBitBtn;
    lblStatusDate: TLabel;
    lblStatusSep: TLabel;
    lblContractDate: TLabel;
    lblContractSep: TLabel;
    cbContractDateUnk: TCheckBox;
    bbtnHelp: TBitBtn;
    rzseStatusYr: TRzSpinEdit;
    rzseStatusMo: TRzSpinEdit;
    rzseContractYr: TRzSpinEdit;
    rzseContractMo: TRzSpinEdit;
    bbtnClear: TButton;
    rgStatusType: TRadioGroup;
    procedure bbtnHelpClick(Sender: TObject);
    procedure bbtnOKClick(Sender: TObject);
    procedure EnDisOtherDesc(IsEnabled, UnkEnabled: Boolean; DateLbl: String);
    procedure cbStatusTypeChange(Sender: TObject);
    procedure cbContractDateUnkClick(Sender: TObject);
    procedure bbtnClearClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SetContractDateUnk;
    procedure MonthButtonClick(Sender: TObject;Button: TSpinButtonType);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
    FClearData: Boolean;
    function GetDescriptionText: String;
  public
    { Public declarations }
    FCell: TBaseCell;
    procedure LoadForm;
    procedure SaveToCell;
    procedure Clear;
  end;

const
  StatusLabel = ' Date mm/yy';
var
  dlgUADDateOfSale: TdlgUADDateOfSale;
  StatusLbl: array[0..MaxDOSTypes] of String = ('Settled','','','Expired','Withdrawn');
  DateChar: array[0..MaxDOSTypes] of String = ('s','A','c','e','w');
  StatDate: array[0..MaxDOSTypes] of Boolean = (True,False,False,True,True);
  ContDate: array[0..MaxDOSTypes] of Boolean = (True,False,True,False,False);
  ContUnk: array[0..MaxDOSTypes] of Boolean = (True,False,False,False,False);


implementation

{$R *.dfm}

uses
  UPage,UStrings;


procedure TdlgUADDateOfSale.bbtnHelpClick(Sender: TObject);
begin
  ShowUADHelp('FILE_HELP_UAD_GRID_DATE_OF_SALE', Caption);
end;

procedure TdlgUADDateOfSale.bbtnOKClick(Sender: TObject);
begin
  if rgStatusType.ItemIndex < 0 then
    begin
      ShowAlert(atWarnAlert, 'A listing status type must be selected.');
      rgStatusType.SetFocus;
      Exit;
    end;

  SaveToCell;
  ModalResult := mrOK;
end;

procedure TdlgUADDateOfSale.EnDisOtherDesc(IsEnabled, UnkEnabled: Boolean; DateLbl: String);
var
  StatEnabled: Boolean;
  Dy, Mo, Yr, Yr2: Word;
begin
  DecodeDate(Now, Yr, Mo, Dy);
  Yr2 := StrToInt(Copy(IntToStr(Yr), 3, 2));
  lblContractDate.Enabled := IsEnabled;
  rzseContractMo.Enabled := IsEnabled;
  if rzseContractMo.Text = '' then
    rzseContractMo.Value := Mo;
  lblContractSep.Enabled := IsEnabled;
  rzseContractYr.Enabled := IsEnabled;
  if rzseContractYr.Text = '' then
    rzseContractYr.Value := Yr2;
  cbContractDateUnk.Enabled := UnkEnabled;
  if not cbContractDateUnk.Enabled then
    cbContractDateUnk.Checked := False;
  lblStatusDate.Caption := DateLbl + StatusLabel;
  StatEnabled := (DateLbl <> '');
  lblStatusDate.Enabled := StatEnabled;
  rzseStatusMo.Enabled := StatEnabled;
  if rzseStatusMo.Text = '' then
    rzseStatusMo.Value := Mo;
  lblStatusSep.Enabled := StatEnabled;
  rzseStatusYr.Enabled := StatEnabled;
  if rzseStatusYr.Text = '' then
    rzseStatusYr.Value := Yr2;
end;

procedure TdlgUADDateOfSale.cbStatusTypeChange(Sender: TObject);
begin
  if rgStatusType.ItemIndex > -1 then
    EnDisOtherDesc(ContDate[rgStatusType.ItemIndex], ContUnk[rgStatusType.ItemIndex], StatusLbl[rgStatusType.ItemIndex])
  else
    EnDisOtherDesc(False, False, '');
end;

procedure TdlgUADDateOfSale.cbContractDateUnkClick(Sender: TObject);
begin
  SetContractDateUnk;
end;

procedure TdlgUADDateOfSale.SetContractDateUnk;
const
  theCaption = ' Contract Date is Unknown';
begin
  if cbContractDateUnk.Checked then
    begin
      lblContractDate.Enabled := False;
      rzseContractMo.Enabled := False;
      lblContractSep.Enabled := False;
      rzseContractYr.Enabled := False;
      cbContractDateUnk.Caption := theCaption;
    end
  else
    begin
      cbContractDateUnk.Caption := 'or' + theCaption;
      if ContDate[rgStatusType.ItemIndex] then
        begin
          lblContractDate.Enabled := True;
          rzseContractMo.Enabled := True;
          lblContractSep.Enabled := True;
          rzseContractYr.Enabled := True;
        end;
    end;
end;

procedure TdlgUADDateOfSale.LoadForm;
var
  PosItem: Integer;
  DOSText, ItemText: String;

  procedure LoadDateFlds(DateText: String; IsStatDate: Boolean);
  var
    Mo, Yr: Integer;
  begin
    Mo := StrToIntDef(Copy(DateText, 1, 2), 0);
    if (Mo > 0) and (Mo < 13) then
      if IsStatDate then
        rzseStatusMo.Value := Mo
      else
        rzseContractMo.Value := Mo;
    Yr := StrToIntDef(Copy(DateText, 4, 2), 0);
    if Yr > 0 then
      if IsStatDate then
        rzseStatusYr.Value := Yr
      else
        rzseContractYr.Value := Yr;
  end;

begin
  Clear;
  FClearData := False;
  DOSText := Trim(FCell.Text);
  if DOSText <> '' then
    begin
      rgStatusType.ItemIndex := AnsiIndexStr(DOSText[1], DateChar);
      DOSText := Copy(DOSText, 2, Length(DOSText));
      case rgStatusType.ItemIndex of
        0:
          begin
            PosItem := Pos(';', DOSText);
            if PosItem > 0 then
              begin
                ItemText := Copy(DOSText, 1, Pred(PosItem));
                if (Length(ItemText) = 5) and (Pos('/', ItemText) = 3) then
                  LoadDateFlds(ItemText, True);
                ItemText := Copy(DOSText, Succ(PosItem), Length(DOSText));
                if (Length(ItemText) = 6) and (ItemText[1] = 'c') and (Pos('/', ItemText) = 4) then
                  LoadDateFlds(Copy(ItemText, 2, 5), False)
                else if ItemText = 'Unk' then
                  cbContractDateUnk.Checked := True;
              end;
          end;
        1: if DOSText <> 'ctive' then
             rgStatusType.ItemIndex := -1;
        2:
          begin
            if (Length(DOSText) = 5) and (Pos('/', DOSText) = 3) then
              LoadDateFlds(DOSText, False)
            else if DOSText = 'Unk' then
              cbContractDateUnk.Checked := True;
          end;
        3, 4:
          begin
            if (Length(DOSText) = 5) and (Pos('/', DOSText) = 3) then
              LoadDateFlds(DOSText, True);
          end;
      end;
    end;
  if rgStatusType.ItemIndex > -1 then
    EnDisOtherDesc(ContDate[rgStatusType.ItemIndex], ContUnk[rgStatusType.ItemIndex], StatusLbl[rgStatusType.ItemIndex])
  else
    EnDisOtherDesc(False, False, '');
end;

procedure TdlgUADDateOfSale.SaveToCell;
begin
  // Remove any legacy data - no longer used
  FCell.GSEData := '';
  // Save the cleared or formatted text
  if FClearData then  // clear ALL GSE data and blank the cell
    FCell.SetText('')
  else
    FCell.SetText(GetDescriptionText);
end;

function TdlgUADDateOfSale.GetDescriptionText: String;
var
  SelDesc: String;
begin
  if rgStatusType.ItemIndex < 0 then
    Result := ''
  else
    begin
      SelDesc := DOSTypes[rgStatusType.ItemIndex];
      if StatDate[rgStatusType.ItemIndex] then
        SelDesc := SelDesc + FormMoYr(rzseStatusMo.Text) +
            '/' + FormMoYr(rzseStatusYr.Text);
      if cbContractDateUnk.Checked then
        SelDesc := SelDesc + ';Unk'
      else if ContDate[rgStatusType.ItemIndex] then
        begin
         if (Pos('c', SelDesc) = 0) then
           SelDesc := SelDesc + ';c';
         SelDesc := SelDesc + FormMoYr(rzseContractMo.Text) +
            '/' + FormMoYr(rzseContractYr.Text);
        end;
      Result := Trim(SelDesc);
    end;
end;

procedure TdlgUADDateOfSale.Clear;
begin
  if FClearData then  // clear ALL GSE data and blank the cell
    rgStatusType.ItemIndex := -1;
  rzseStatusMo.Text := '';
  rzseStatusYr.Text := '';
  rzseContractMo.Text := '';
  rzseContractYr.Text := '';
  cbContractDateUnk.Checked := False;
end;

procedure TdlgUADDateOfSale.bbtnClearClick(Sender: TObject);
begin
  if WarnOK2Continue(msgUAGClearDialog) then
    begin
      Clear;
      FClearData := True;
      SaveToCell;
      ModalResult := mrOK;
    end;
end;

procedure TdlgUADDateOfSale.FormShow(Sender: TObject);
begin
  LoadForm;
  if (rgStatusType.ItemIndex >= 0) and (rgStatusType.ItemIndex <= MaxDOSTypes) then
    rgStatusType.Buttons[rgStatusType.ItemIndex].SetFocus
  else
    rgStatusType.Buttons[0].SetFocus;
  SetContractDateUnk;
end;

procedure TdlgUADDateOfSale.MonthButtonClick(Sender: TObject;
  Button: TSpinButtonType);
begin
  case Button of
    sbUp:   if TRzSpinEdit(Sender).Value = 13 then TRzSpinEdit(Sender).Value := 1;
    sbDown: if TRzSpinEdit(Sender).Value = 0 then TRzSpinEdit(Sender).Value := 12;
  end;
end;

procedure TdlgUADDateOfSale.FormCreate(Sender: TObject);
begin
  //Set up min/max to 0 and 13 for the up/down to roll in a cycle of 1-12 for months
  rzseStatusMo.Min   := 0;
  rzseStatusMo.Max   := 13;
  rzseContractMo.Min := 0;
  rzseContractMo.Max := 13;
end;

end.
