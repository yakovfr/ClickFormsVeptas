unit UPrefFToolSketcher;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{ This is the Frame that contains the Tools > Sketcher Preferences}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, RzPanel, RzRadGrp, RzLabel, UContainer, UToolUtils;

type
  TPrefToolSketcher = class(TFrame)
    SketchToolDefault: TRzRadioGroup;
    Panel1: TPanel;
    StaticText1: TStaticText;
  private
    FDoc: TContainer;
  public
    constructor CreateFrame(AOwner: TComponent; ADoc: TContainer);
    procedure LoadPrefs;      //loads in the prefs from the app
    procedure SavePrefs;      //saves the changes
  end;

implementation

uses
  UGlobals, UInit;

{$R *.dfm}

constructor TPrefToolSketcher.CreateFrame(AOwner: TComponent; ADoc: TContainer);
begin
  inherited Create(AOwner);
  FDoc := ADoc;
  SketchToolDefault.Items.Clear;
  SketchToolDefault.Items.add('AreaSketch');
  SketchToolDefault.Items.add('WinSketch');
  SketchToolDefault.Items.add('Apex');
  SketchToolDefault.Items.add('RapidSketch');
  if HasAreaSketchSE then
     SketchToolDefault.Items.add('AreaSketch Special Edition');
  {if fileExists(GetPhoenixSketchPath) then
    SketchToolDefault.Items.add('PhoenixSketch');      }
  LoadPrefs;
end;

procedure TPrefToolSketcher.LoadPrefs;
begin
  SketchToolDefault.ItemIndex := appPref_DefaultSketcher;
end;

procedure TPrefToolSketcher.SavePrefs;
begin
  appPref_DefaultSketcher := SketchToolDefault.ItemIndex;
end;


end.
