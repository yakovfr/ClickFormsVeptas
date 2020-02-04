unit UPrefFAppraiserCalcs;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{ This is the Frame that contains the Appraiser Calculation Preferences}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, ExtCtrls, UContainer;

type
  TPrefAppraiserCalcs = class(TFrame)
    chkDoYear2AgeCalc: TCheckBox;
    chkCalcCellEquation: TCheckBox;
    chkUseLandPriceUnits: TCheckBox;
    chkUseOperatingIncomeMarketRent: TCheckBox;
    Panel1: TPanel;
    rdoNetGrossDecimal: TRadioGroup;
    chkIncludeOpinionValue: TCheckBox;
  private
    FDoc: TContainer;
  public
    constructor CreateFrame(AOwner: TComponent; ADoc: TContainer);
    procedure LoadPrefs;      //loads in the prefs from the app
    procedure SavePrefs;
  end;

implementation

{$R *.dfm}

uses
  UGlobals, UInit, UUtil1;

constructor TPrefAppraiserCalcs.CreateFrame(AOwner: TComponent; ADoc: TContainer);
begin
  inherited Create(AOwner);
  FDoc := ADoc;
  LoadPrefs;
end;

procedure TPrefAppraiserCalcs.LoadPrefs;
begin
  //load appraiser Calcs
  chkCalcCellEquation.Checked := IsAppPrefSet(bCalcCellEquation);
  chkUseLandPriceUnits.checked := appPref_AppraiserUseLandPriceUnits;
  chkIncludeOpinionValue.Checked := appPref_AppraiserCostApproachIncludeOpinionValue;
  chkDoYear2AgeCalc.checked := appPref_AppraiserDoYear2AgeCalc;
  chkUseOperatingIncomeMarketRent.checked := appPref_AppraiserUseMarketRentInOIS;

//  chkNetGrossDecimal.checked := appPref_AppraiserNetGrossDecimal;
  rdoNetGrossDecimal.ItemIndex := appPref_AppraiserNetGrossDecimalPoint;
end;

procedure TPrefAppraiserCalcs.SavePrefs;
begin
  //save appraiser calcs
  SetAppPref(bCalcCellEquation, chkCalcCellEquation.Checked);
  appPref_AppraiserUseLandPriceUnits := chkUseLandPriceUnits.checked;
  appPref_AppraiserCostApproachIncludeOpinionValue := chkIncludeOpinionValue.Checked;
  appPref_AppraiserDoYear2AgeCalc := chkDoYear2AgeCalc.checked;
  appPref_AppraiserUseMarketRentInOIS := chkUseOperatingIncomeMarketRent.checked;
//  appPref_AppraiserNetGrossDecimal := chkNetGrossDecimal.checked;
  appPref_AppraiserNetGrossDecimalPoint := rdoNetGrossDecimal.ItemIndex;
end;


end.
