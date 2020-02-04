unit UPrefFDocFormatting;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{ This is the Frame that contains the Document Formatting Preferences}


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RzLine, ExtCtrls, RzPanel, RzRadGrp, UContainer,
  RzLabel, RzCmboBx, RzDBChk, RzButton, RzRadChk;

type
  TPrefDocFormatting = class(TFrame)
    ckbAutoAlignNewForms: TRzCheckBox;
    AutoAlignCoCells: TRzRadioGroup;
    AutoAlignLicUserCells: TRzRadioGroup;
    AutoAlignShortCells: TRzRadioGroup;
    AutoAlignLongCells: TRzRadioGroup;
    AutoAlignHeaderCells: TRzRadioGroup;
    AutoAignGDCells: TRzRadioGroup;
    AutoAlignGACells: TRzRadioGroup;
    GACellRounding: TRzComboBox;
    ckbGACellsDisplayZero: TRzCheckBox;
    ckbAutoAlignApplyOnOpening: TRzCheckBox;
    Panel1: TPanel;
    Panel2: TPanel;
    ckbGACellsAddPlus: TRzCheckBox;
    Panel3: TPanel;
    procedure AutoAignGDCellsClick(Sender: TObject);
  private
		FDoc: TContainer;
		FDocChged: Boolean;
    FApplyFormats: Boolean;         //only apply formats on Apply, not OK
  public
    constructor CreateFrame(AOwner: TComponent; ADoc: TContainer);
    procedure LoadPrefs;      //loads in the prefs from the app
    procedure SavePrefs;      //saves the changes
    procedure ApplyPreferences;
    procedure ApplyPrefClick;
  end;

implementation

uses
  UGlobals, UInit, UUtil1;

{$R *.dfm}

constructor TPrefDocFormatting.CreateFrame(AOwner: TComponent; ADoc: TContainer);
begin
  inherited Create(AOwner);
  FDoc := ADoc;
  LoadPrefs;
end;

procedure TPrefDocFormatting.LoadPrefs;
begin
  //Global Text Justification
  ckbAutoAlignNewForms.checked := appPref_AutoTextAlignNewForms;
  ckbAutoAlignApplyOnOpening.checked := appPref_AutoTextAlignOnFileOpen;

  ckbGACellsDisplayZero.checked := appPref_AutoTxFormatShowZeros;
  ckbGACellsAddPlus.checked := appPref_AutoTxFormatAddPlus;
  GACellRounding.ItemIndex := appPref_AutoTxFormatRounding;

  AutoAlignCoCells.ItemIndex := appPref_AutoTxAlignCoCell;
  AutoAlignLicUserCells.ItemIndex := appPref_AutoTxAlignLicCell;
  AutoAlignShortCells.ItemIndex := appPref_AutoTxAlignShortCell;
  AutoAlignLongCells.ItemIndex := appPref_AutoTxAlignLongCell;
  AutoAlignHeaderCells.ItemIndex := appPref_AutoTxAlignHeaders;
  AutoAignGDCells.ItemIndex := appPref_AutoTxAlignGridDesc;
  AutoAlignGACells.ItemIndex := appPref_AutoTxAlignGridAdj;

//init some vars
	FDocChged := False;
end;

procedure TPrefDocFormatting.SavePrefs;
begin
  FApplyFormats := False;
  //Global Text Justification - rest saved in Apply
  appPref_AutoTextAlignNewForms := ckbAutoAlignNewForms.checked;
  appPref_AutoTextAlignOnFileOpen := ckbAutoAlignApplyOnOpening.checked;
  appPref_AutoTxFormatShowZeros := ckbGACellsDisplayZero.checked;
  appPref_AutoTxFormatAddPlus := ckbGACellsAddPlus.checked;
  appPref_AutoTxFormatRounding := GACellRounding.ItemIndex;

  appPref_AutoTxAlignCoCell := AutoAlignCoCells.ItemIndex;
  appPref_AutoTxAlignLicCell := AutoAlignLicUserCells.ItemIndex;
  appPref_AutoTxAlignShortCell := AutoAlignShortCells.ItemIndex;
  appPref_AutoTxAlignLongCell := AutoAlignLongCells.ItemIndex;
  appPref_AutoTxAlignHeaders := AutoAlignHeaderCells.ItemIndex;
  appPref_AutoTxAlignGridDesc := AutoAignGDCells.ItemIndex;
  appPref_AutoTxAlignGridAdj := AutoAlignGACells.ItemIndex;
end;

procedure TPrefDocFormatting.AutoAignGDCellsClick(Sender: TObject);
var
  enableAdjChg: Boolean;
begin
  enableAdjChg := AutoAignGDCells.ItemIndex <> atjJustNone;
  //enable or disable the adjustment cells changes
  AutoAlignGACells.enabled := enableAdjChg;
  ckbGACellsDisplayZero.enabled := enableAdjChg;
  ckbGACellsAddPlus.enabled := enableAdjChg;
  GACellRounding.enabled := enableAdjChg;
end;

procedure TPrefDocFormatting.ApplyPreferences;
begin
	if FDoc <> nil then
    begin    //show the new look
      appPref_AutoTxFormatShowZeros := ckbGACellsDisplayZero.checked;
      appPref_AutoTxFormatAddPlus := ckbGACellsAddPlus.checked;
      appPref_AutoTxFormatRounding := GACellRounding.ItemIndex;
      appPref_AutoTxAlignCoCell := AutoAlignCoCells.ItemIndex;
      appPref_AutoTxAlignLicCell := AutoAlignLicUserCells.ItemIndex;
      appPref_AutoTxAlignShortCell := AutoAlignShortCells.ItemIndex;
      appPref_AutoTxAlignLongCell := AutoAlignLongCells.ItemIndex;
      appPref_AutoTxAlignHeaders := AutoAlignHeaderCells.ItemIndex;
      appPref_AutoTxAlignGridDesc := AutoAignGDCells.ItemIndex;
      appPref_AutoTxAlignGridAdj := AutoAlignGACells.ItemIndex;
      //now do it
      FDoc.SetGlobalCellFormating(FApplyFormats);
      FDoc.docView.Invalidate;
      FDocChged := True;
    end;
end;

procedure TPrefDocFormatting.ApplyPrefClick;
begin
  FApplyFormats := True;
  ApplyPreferences;
end;

end.
