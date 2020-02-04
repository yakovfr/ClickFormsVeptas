unit UPrefFDocColor;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{ This is the Frame that contains the Document Color Preferences}


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, UGlobals, UContainer, RzBorder, RzLabel;

type
  TPrefDocColor = class(TFrame)
    clrHiliteCell: TShape;
    clrFormLines: TShape;
    clrFormText: TShape;
    clrEmptyCell: TShape;
    clrFreeText: TShape;
    clrInfoText: TShape;
    btnSetColorDefault: TButton;
    btnPreview: TButton;
    btnRevert: TButton;
    ColorDialog: TColorDialog;
    StaticText1: TStaticText;
    Bevel1: TBevel;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    StaticText4: TStaticText;
    StaticText5: TStaticText;
    StaticText6: TStaticText;
    StaticText7: TStaticText;
    StaticText8: TStaticText;
    RzLabel1: TRzLabel;
    StaticText9: TStaticText;
    clrFilledCell: TShape;
    clrUADCell: TShape;
    StaticText10: TStaticText;
    clrInvalidCell: TShape;
    StaticText11: TStaticText;
    CheckBoxUseUADCellColor: TCheckBox;
    procedure ChangeColorMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnSetColorDefaultClick(Sender: TObject);
    procedure btnPreviewClick(Sender: TObject);
    procedure btnRevertClick(Sender: TObject);
  private
		FDoc: TContainer;
		FDocChged: Boolean;
		FChgedEmptyCellColor: Boolean;
		FChgedFilledCellColor: Boolean;
		FOrgDocColors: TColorRec;       //original colors
		FOrgUseUADCellColorForFilledCells: Boolean;  // original options
  public
    constructor CreateFrame(AOwner: TComponent; ADoc: TContainer);
    procedure LoadPrefs;      //loads in the prefs from the app
    procedure SavePrefs;      //saves the changes
    procedure ApplyPreferences;
    procedure DisplayCancel;
  end;

implementation

uses
  UInit, UUtil1;

{$R *.dfm}

constructor TPrefDocColor.CreateFrame(AOwner: TComponent; ADoc: TContainer);
begin
  inherited Create(AOwner);
  FDoc := ADoc;
  LoadPrefs;
end;

procedure TPrefDocColor.LoadPrefs;
begin
  //Color preferences
  clrFormText.Brush.Color := appPref_FormTextColor;
  clrFormLines.Brush.Color := appPref_FormFrameColor;
  clrInfoText.Brush.Color := appPref_InfoCellColor;
  clrFreeText.Brush.Color := appPref_FreeTextColor;
  clrEmptyCell.Brush.Color := appPref_EmptyCellColor;
  clrHiliteCell.Brush.Color := appPref_CellHiliteColor;
  clrFilledCell.Brush.Color := appPref_CellFilledColor;
  clrUADCell.Brush.Color := appPref_CellUADColor;
  clrInvalidCell.Brush.Color := appPref_CellInvalidColor;

  //Color Options
  CheckBoxUseUADCellColor.Checked := appPref_UseUADCellColorForFilledCells;

  // Set Document Prefs; if have Active use those, else use defaults
	if FDoc = nil then
    begin
		end
	else begin //if doc <> nil then
    //Save for undoing
		FOrgDocColors := FDoc.docColors;			//save incase they apply & cancel
		FOrgUseUADCellColorForFilledCells := appPref_UseUADCellColorForFilledCells;
   //init some vars
	  FDocChged := False;
	  FChgedEmptyCellColor := False;
    FChgedFilledCellColor := False;
  end;
end;


procedure TPrefDocColor.SavePrefs;
begin
  //colors
  appPref_FormTextColor := clrFormText.Brush.Color;
  appPref_FormFrameColor := clrFormLines.Brush.Color;
  appPref_InfoCellColor := clrInfoText.Brush.Color;
  appPref_FreeTextColor := clrFreeText.Brush.Color;
  appPref_EmptyCellColor := clrEmptyCell.Brush.Color;
  appPref_CellHiliteColor := clrHiliteCell.Brush.Color;
  appPref_CellFilledColor := clrFilledCell.Brush.Color;
  appPref_CellUADColor := clrUADCell.Brush.Color;
  appPref_CellInvalidColor := clrInvalidCell.Brush.Color;

  //Color Options
  appPref_UseUADCellColorForFilledCells := CheckBoxUseUADCellColor.Checked;
end;

procedure TPrefDocColor.ChangeColorMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
	clrType: Integer;
begin
  clrType := 0;
	if sender <> nil then
		clrType := TShape(Sender).Tag;
	if colorDialog.execute then
		case clrType of
			1:	clrFormText.Brush.Color := ColorDialog.color;
			2:  clrFormLines.Brush.Color := ColorDialog.color;
			3:  clrInfoText.Brush.Color := ColorDialog.color;
			4:  clrFreeText.Brush.Color := ColorDialog.color;
			5:  begin
						clrEmptyCell.Brush.Color := ColorDialog.color;
						FChgedEmptyCellColor := True;
					end;
			6:  clrHiliteCell.Brush.Color := ColorDialog.color;
			7:  begin
            clrFilledCell.Brush.Color := ColorDialog.color;
         		FChgedFilledCellColor := True;
          end;
      8:  clrUADCell.Brush.Color := ColorDialog.color;
      9:  clrInvalidCell.Brush.Color := ColorDialog.color;
		end;
	FDocChged := True;
end;

procedure TPrefDocColor.btnSetColorDefaultClick(Sender: TObject);
begin
	clrFormText.Brush.Color := colorFormText;
	clrFormLines.Brush.Color := colorFormFrame1;
	clrInfoText.Brush.Color := colorInfoCell;
	clrFreeText.Brush.Color := colorFreetext;
	clrEmptyCell.Brush.Color := colorEmptyCell;
	clrHiliteCell.Brush.Color := colorCellHilite;
	clrFilledCell.Brush.Color := colorCellFilled;
	clrUADCell.Brush.Color := colorUADCell;
	clrInvalidCell.Brush.Color := colorCellInvalid;
	CheckBoxUseUADCellColor.Checked := False;

	FDocChged := True;
	FChgedEmptyCellColor := True;
  FChgedFilledCellColor := True;
end;

procedure TPrefDocColor.btnPreviewClick(Sender: TObject);
begin
  ApplyPreferences;   //preview only
end;

procedure TPrefDocColor.ApplyPreferences;
begin
	if FDoc <> nil then
    begin    //show the new look
      //Colors
      FDoc.docColors[cFormTxColor]    := clrFormText.Brush.Color;
      FDoc.docColors[cFormLnColor]    := clrFormLines.Brush.Color;
      FDoc.docColors[cInfoCelColor]   := clrInfoText.Brush.Color;
      FDoc.docColors[cFreeTxColor]    := clrFreeText.Brush.Color;
      FDoc.docColors[cEmptyCellColor] := clrEmptyCell.Brush.Color;
      FDoc.docColors[cHiliteColor]    := clrHiliteCell.Brush.Color;
      FDoc.docColors[cFilledColor]    := clrFilledCell.Brush.Color;
      FDoc.docColors[cUADCellColor]   := clrUADCell.Brush.Color;
      FDoc.docColors[cInvalidCellColor] := clrInvalidCell.Brush.Color;

      //Color Options
      appPref_UseUADCellColorForFilledCells := CheckBoxUseUADCellColor.Checked;

      FDoc.docView.Invalidate;
      FDocChged := True;
    end;
end;

procedure TPrefDocColor.DisplayCancel;
begin
  if (FDoc <> nil) and FDocChged then
    begin    //reset the old look
      //Colors
      FDoc.docColors[cFormTxColor]    := FOrgDocColors[cFormTxColor];
      FDoc.docColors[cFormLnColor]    := FOrgDocColors[cFormLnColor];
      FDoc.docColors[cInfoCelColor]   := FOrgDocColors[cInfoCelColor];
      FDoc.docColors[cFreeTxColor]    := FOrgDocColors[cFreeTxColor];
      FDoc.docColors[cEmptyCellColor] := FOrgDocColors[cEmptyCellColor];
      FDoc.docColors[cHiliteColor]    := FOrgDocColors[cHiliteColor];
      FDoc.docColors[cFilledColor]    := FOrgDocColors[cFilledColor];
      FDoc.docColors[cUADCellColor]   := FOrgDocColors[cUADCellColor];
      FDoc.docColors[cInvalidCellColor] := FOrgDocColors[cInvalidCellColor];

      //Color Options
      appPref_UseUADCellColorForFilledCells := FOrgUseUADCellColorForFilledCells;

      FDoc.docView.Invalidate;
      LoadPrefs;  //show last saved changes
    end;
end;

procedure TPrefDocColor.btnRevertClick(Sender: TObject);
begin
  DisplayCancel;
end;

end.
