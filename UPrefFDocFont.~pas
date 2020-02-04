unit UPrefFDocFont;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{ This is the Frame that contains the Document Font Preferences}


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, UGlobals, UContainer, ExtCtrls, RzLabel, RzBorder;

type
  TPrefDocFonts = class(TFrame)
    btnChgFonts: TButton;
    btnSetFontDefaults: TButton;
    FontDialog: TFontDialog;
    btnPreview: TButton;
    btnRevert: TButton;
    cbxSetFontDefaults: TCheckBox;
    Panel1: TPanel;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    stSampleText: TStaticText;
    lblFontName: TStaticText;
    lblFontSize: TStaticText;
    lblSampleText: TPanel;
    Panel2: TPanel;
    StaticText4: TStaticText;
    StaticText5: TStaticText;
    procedure btnChgFontsClick(Sender: TObject);
    procedure btnSetFontDefaultsClick(Sender: TObject);
    procedure btnPreviewClick(Sender: TObject);
    procedure btnRevertClick(Sender: TObject);
  private
		FDoc: TContainer;
		FDocChged: Boolean;
		FOrgDocFont: TFont;             //original doc font
  public
    constructor CreateFrame(AOwner: TComponent; ADoc: TContainer);
		destructor Destroy; override;
    procedure LoadPrefs;      //loads in the prefs from the app
    procedure SavePrefs;      //saves the changes
    procedure DisplayCancel;
    procedure ApplyPreferences;
  end;

implementation

uses
  UEditor,
  UInit,
  UStatus,
  UUtil1;

{$R *.dfm}

constructor TPrefDocFonts.CreateFrame(AOwner: TComponent; ADoc: TContainer);
begin
  inherited Create(AOwner);
  FDoc := ADoc;
  lblSampleText.Height := stSampleText.Height;
  LoadPrefs;
end;

procedure TPrefDocFonts.LoadPrefs;
begin
  // Set Document Prefs; if have Active use those, else use defaults
  cbxSetFontDefaults.checked := appPref_FontIsDefault;
	if FDoc = nil then begin
		//Font preferences
		lblFontName.Caption := appPref_InputFontName;
		lblFontSize.Caption := IntToStr(appPref_InputFontSize);
		lblSampletext.Font.Assign(appPref_InputFont);
		end
	else begin //if doc <> nil then
    //Save for undoing
		FOrgDocFont := TFont.Create;
		FOrgDocFont.Assign(FDoc.docFont);     //save the cur doc font

		//show cur doc font
		lblFontName.Caption := FDoc.docFont.Name;
		lblFontSize.Caption := IntToStr(FDoc.docFont.Size);
		lblSampletext.Font.Assign(FDoc.docFont);
  end;

//init some vars
	FDocChged := False;
end;

destructor TPrefDocFonts.Destroy;
begin
	if Assigned(FOrgDocFont) then
		FOrgDocFont.Free;

  inherited;
end;

procedure TPrefDocFonts.SavePrefs;
begin
	//Document Preferences  (Default for Future documents)
  appPref_FontIsDefault := cbxSetFontDefaults.checked;
	if cbxSetFontDefaults.checked then
	begin
	 //Fonts
		appPref_InputFontName := lblSampleText.Font.Name;
		appPref_InputFontSize := lblSampleText.Font.Size;
		appPref_InputFontColor := lblSampleText.Font.Color;
		appPref_InputFont.Assign(lblSampleText.Font);
  end;
	//Active Document Preferences
	if (FDoc <> nil) then
	begin
		//Font
    FDoc.docFont.assign(lblSampletext.Font);
	end;
end;

procedure TPrefDocFonts.btnChgFontsClick(Sender: TObject);
begin
	FontDialog.Options := [fdTrueTypeOnly, fdLimitSize];
	FontDialog.Font.Name := lblSampleText.Font.Name;			//appPref_InputFontName;
	FontDialog.Font.Size := lblSampleText.Font.Size;			//appPref_InputFontSize;
  FontDialog.Font.Style := lblSampleText.Font.Style;
	FontDialog.MaxFontSize := defaultMaxFontSize;
	if FontDialog.execute then
	begin
		lblFontName.Caption := FontDialog.Font.Name;
		lblFontSize.Caption := IntToStr(FontDialog.Font.Size);

		lblSampleText.Font.Assign(FontDialog.Font);

		FDocChged := True;
	end;
end;

procedure TPrefDocFonts.btnSetFontDefaultsClick(Sender: TObject);
begin
		lblFontName.Caption := defaultFontName;
		lblFontSize.Caption := IntToStr(defaultFontSize);

		lblSampleText.Font.Name := defaultFontName;
		lblSampleText.Font.Size := defaultFontSize;
    lblSampleText.Font.Style := [];
		lblSampleText.Font.Color := clBlack;
		FDocChged := True;
end;

procedure TPrefDocFonts.btnPreviewClick(Sender: TObject);
begin
  ApplyPreferences; //Preview Only
end;

//Just like APPLY, but undo it when they cancel
procedure TPrefDocFonts.DisplayCancel;
begin
  if (FDoc <> nil) and FDocChged then
    begin    //reset the old look
      //Font
      if FDoc.docFont.Size <> FOrgDocFont.Size then
        FDoc.SetAllCellsTextSize(FOrgDocFont.Size);
      if FDoc.docFont.Style <> FOrgdocFont.Style then
        FDoc.SetAllCellsFontStyle(FOrgDocFont.Style);
      FDoc.docFont.assign(FOrgDocFont);
      FDoc.docView.Invalidate;
      LoadPrefs;  //show last saved changes
    end;
end;

procedure TPrefDocFonts.ApplyPreferences;
var
  format: ITextFormat;
begin
	if FDoc <> nil then
    begin    //show the new look
      //Font
      FDoc.docFont.assign(lblSampletext.Font);
      if Supports(FDoc.docEditor, ITextFormat, format) then
        format.Font.Assign(FDoc.docFont);
      FDoc.docView.Font.Assign(FDoc.docFont);
      FDoc.SetAllCellsTextSize(lblSampletext.Font.Size);
      FDoc.SetAllCellsFontStyle(lblSampleText.Font.Style);
      FDoc.docView.Invalidate;
      FDocChged := True;
    end;
end;

procedure TPrefDocFonts.btnRevertClick(Sender: TObject);
begin
  DisplayCancel;
end;

end.
