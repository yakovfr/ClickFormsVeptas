unit UPrefFDocDisplay;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{ This is the Frame that contains the Document Display Preferences}


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, UGlobals, UContainer, ExtCtrls, RzCmboBx, RzLabel,
  RzButton, RzRadChk;
 
type
  TPrefDocDisplay = class(TFrame)
    ckbShowPageMgr: TCheckBox;
    ckbLastCurCell: TCheckBox;
    rbtnFitToScreen: TRadioButton;
    rbtnDoScale: TRadioButton;
    edtScale: TEdit;
    btnPreview: TButton;
    btnRevert: TButton;
    Panel1: TPanel;
    stResetNote: TStaticText;
    stScalePercent: TStaticText;
    stDefWindowSize: TStaticText;
    stDoScale: TStaticText;
    ckbUADAutoZeroOrNone: TRzCheckBox;
    procedure rbtnFitToScreenClick(Sender: TObject);
    procedure rbtnDoScaleClick(Sender: TObject);
    procedure edtScaleExit(Sender: TObject);
    procedure NumberFilter(Sender: TObject; var Key: Char);
    procedure btnPreviewClick(Sender: TObject);
    procedure btnRevertClick(Sender: TObject);
  private
    FDoc: TContainer;
		FDocChged: Boolean;
    FOrgDocScale: Integer;          //this is original scaling factor
    FOrgDocMaxed: Boolean;          //original window is maximized
    FOrgDocPref: LongInt;           //original doc Show PgList setting
  public
    constructor CreateFrame(AOwner: TComponent; ADoc: TContainer);
    procedure LoadPrefs;      //loads in the prefs from the app
    procedure SavePrefs;      //saves the changes
    procedure ApplyPreferences;
    procedure DisplayCancel;
  end;

var
  FPrefDocDisplay: TPrefDocDisplay;

implementation

uses
  UInit, UUtil1, UStatus, UMain, UPref;

{$R *.dfm}

constructor TPrefDocDisplay.CreateFrame(AOwner: TComponent; ADoc: TContainer);
begin
  inherited Create(AOwner);
  FDoc := ADoc;
  edtScale.Left := stDoScale.Left + stDoScale.Width + 3;
  stScalePercent.Left := edtScale.Left + edtScale.Width + 3;
  LoadPrefs;
end;

procedure TPrefDocDisplay.LoadPrefs;
begin
  //Display
  rbtnFitToScreen.checked := IsAppPrefSet(bFit2Screen);  //app pref, not doc
  rbtnDoScale.checked := not rbtnFitToScreen.checked;    //just toggle
  if not rbtnDoScale.checked then
    edtScale.enabled := false;
  ckbShowPageMgr.checked := IsAppPrefSet(bShowPageMgr);
  ckbLastCurCell.checked := not appPref_StartFirstCell;
  ckbUADAutoZeroOrNone.checked := appPref_UADAutoZeroOrNone;
  edtScale.Text := IntToStr(appPref_DisplayZoom);

  // Set Document Prefs; if have Active use those, else use defaults
	if FDoc = nil then
    begin
		end
	else
    begin //if doc <> nil then
      FOrgDocPref := FDoc.docPref;
    //Save for undoing
      FOrgDocScale := FDoc.docView.ViewScale;
      FOrgDocMaxed := (FDoc.WindowState = wsMaximized);
    end;
//init some vars
	FDocChged := False;
end;

procedure TPrefDocDisplay.SavePrefs;
begin
  //Display
  appPref_StartFirstCell := not ckbLastCurCell.checked;
  SetAppPref(bShowPageMgr, ckbShowPageMgr.Checked);      //apply immediately
  SetAppPref(bFit2Screen, rbtnFitToScreen.Checked);          //fit2screen or normal
  appPref_UADAutoZeroOrNone := ckbUADAutoZeroOrNone.checked;
  if rbtnDoScale.checked then                                //if normal, whats scale
    appPref_DisplayZoom := InRange(25, 200, StrToIntDef(edtScale.text, 100));

end;

procedure TPrefDocDisplay.edtScaleExit(Sender: TObject);
var
	scale: Integer;
begin
	scale := StrToIntDef(edtScale.text, 100);
	if scale < 50 then
		scale := 50
	else if scale > 200 then
		scale := 200;
  edtScale.Text := IntToStr(scale);
end;

procedure TPrefDocDisplay.rbtnFitToScreenClick(Sender: TObject);
begin
  edtScale.enabled := False;
end;

procedure TPrefDocDisplay.rbtnDoScaleClick(Sender: TObject);
begin
  edtScale.enabled := True;
end;

procedure TPrefDocDisplay.NumberFilter(Sender: TObject; var Key: Char);
begin
	if not (Key in [#08, '0'..'9']) then
		key := char(#0);
end;


procedure TPrefDocDisplay.btnPreviewClick(Sender: TObject);
begin
  ApplyPreferences;  //Preview Only
end;


procedure TPrefDocDisplay.ApplyPreferences;
var
  scale: Integer;
begin
	if FDoc <> nil then
    begin    //show the new look
      //toggle Page List
      if ckbShowPageMgr.checked <> IsBitSet(FDoc.docPref, bShowPageMgr) then
        FDoc.TogglePageMgrDisplay;

      if rbtnFitToScreen.checked (*and not FOrgDocMaxed*) then
        FDoc.SetDisplayFit2Screen;

      if rbtnDoScale.checked (*and FOrgDocMaxed*) then
        FDoc.SetDisplayNormal;

      if rbtnDoScale.checked then   //only scale in normal mode
        begin
          scale := InRange(25, 200, StrToIntDef(edtScale.text, 100));
          edtScale.text := IntToStr(scale);          //reset incase they enter bigger #
          if scale <> FDoc.docView.viewScale then
            FDoc.ZoomFactor := Scale;
        end;
      FDoc.docView.Invalidate;
      FDocChged := True;
    end;
end;

procedure TPrefDocDisplay.DisplayCancel;
begin
  if (FDoc <> nil) and FDocChged then
    begin    //reset the old look
      //reset the Page List settings
      if IsBitSet(FDoc.docPref, bShowPageMgr) <> IsBitSet(FOrgDocPref, bShowPageMgr) then
        FDoc.TogglePageMgrDisplay;

      if (FDoc.WindowState = wsMaximized) and not FOrgDocMaxed then
        FDoc.SetDisplayNormal;

      if (FDoc.WindowState = wsNormal) and FOrgDocMaxed then
        FDoc.SetDisplayFit2Screen;

      if FOrgDocScale <> FDoc.docView.viewScale then
        FDoc.ZoomFactor := FOrgDocScale;

      FDoc.docView.Invalidate;

      LoadPrefs;  //show last saved changes
    end;
end;

procedure TPrefDocDisplay.btnRevertClick(Sender: TObject);
begin
  DisplayCancel;
end;


end.
