unit UPrefFDocPrinting;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2006 by Bradford Technologies, Inc. }

{ This is the Frame that contains the Document Printing Preferences}


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, ExtCtrls, UContainer;

type
  TPrefDocPrinting = class(TFrame)
    ckbPrGrayTitle: TCheckBox;
    ckbPrInfoCells: TCheckBox;
    Panel1: TPanel;
  private
    FDoc: TContainer;
  public
    constructor CreateFrame(AOwner: TComponent; ADoc: TContainer);
    procedure LoadPrefs;      //loads in the prefs from the app
    procedure SavePrefs;      //saves the changes
  end;

implementation

uses
  UUtil1, UGlobals, UInit;

{$R *.dfm}

constructor TPrefDocPrinting.CreateFrame(AOwner: TComponent; ADoc: TContainer);
begin
  inherited Create(AOwner);
  FDoc := ADoc;
  LoadPrefs;
end;

procedure TPrefDocPrinting.LoadPrefs;
begin
  //Printing
  ckbPrGrayTitle.checked := IsAppPrefSet(bPrintGray);
  ckbPrInfoCells.checked := IsAppPrefSet(bPrintInfo);
end;

procedure TPrefDocPrinting.SavePrefs;
begin
  //Printing
  SetAppPref(bPrintGray, ckbPrGrayTitle.Checked);
  SetAppPref(bPrintInfo, ckbPrInfoCells.Checked);
end;


end.
