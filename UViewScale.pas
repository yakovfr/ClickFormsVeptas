unit UViewScale;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2005 by Bradford Technologies, Inc. }


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
	StdCtrls, ComCtrls, UForms,
	UDocView;

type
	TDisplayZoom = class(TAdvancedForm)
    btnOK: TButton;
    btnCancel: TButton;
    ImageScaleVal: TEdit;
    lbScale: TLabel;
    ImageScaleBar: TTrackBar;
    ckbxSetDefault: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    procedure ImageScaleBarChange(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure ImageScaleValKeyPress(Sender: TObject; var Key: Char);
    procedure ImageScaleValExit(Sender: TObject);
  private
		FSaveScale: Integer;
		FDocViewer: TDocView;
	public
		constructor Create(AOwner: TComponent; docViewer: TDocView); reintroduce;
//		procedure SaveChanges;
	end;

var
  DisplayZoom: TDisplayZoom;

implementation

uses
	UGlobals, UUtil1, UMain;

	
{$R *.DFM}

{ TDisplayScale }

constructor TDisplayZoom.Create(AOwner: TComponent; docViewer: TDocView);
begin
	inherited Create(AOwner);
	FSaveScale := docViewer.ViewScale;           //save for future ref
	FDocViewer := docViewer;                     //save for live zooming

	ImageScaleVal.text := IntToStr(FSaveScale);      //setup the display
	ImageScaleBar.Position := FSaveScale;
end;

procedure TDisplayZoom.ImageScaleBarChange(Sender: TObject);
begin
	ImageScaleVal.text := IntToStr(ImageScaleBar.Position);
  Main.tbtnZoomText.caption := ImageScaleVal.text;
	FDocViewer.ViewScale := ImageScaleBar.Position;
end;

procedure TDisplayZoom.btnOKClick(Sender: TObject);
begin
	if FSaveScale <> ImageScaleBar.Position then          //only redaw if its been changed
		FDocViewer.ViewScale := ImageScaleBar.Position;     //set the new scale
	if ckbxSetDefault.checked then
		appPref_DisplayZoom := ImageScaleBar.Position;
end;

procedure TDisplayZoom.btnCancelClick(Sender: TObject);
begin
	if FSaveScale <> ImageScaleBar.Position then           //if view changed,
		FDocViewer.ViewScale := FSaveScale;                  //reset to the original scale
end;

procedure TDisplayZoom.ImageScaleValKeyPress(Sender: TObject; var Key: Char);
begin
	if not (Key in [#08, '0'..'9']) then
		key := char(#0);
end;

procedure TDisplayZoom.ImageScaleValExit(Sender: TObject);
var
	scale: Integer;
begin
	scale := StrToInt(ImageScaleVal.text);
	if scale < 50 then
		scale := 50
	else if scale > 200 then
		scale := 200;

	ImageScaleVal.Text := IntToStr(scale);         //reset edit box if necessary
  Main.tbtnZoomText.Caption := ImageScaleVal.text;
	ImageScaleBar.Position := scale;               //set the track bar
  FDocViewer.ViewScale := scale;                 //set the view
end;

end.
