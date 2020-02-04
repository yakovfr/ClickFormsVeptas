unit UPrefFAppPDF;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{ This is the Frame that contains the Application PDF Preferences}


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, UContainer;

type
  TPrefAppPDF = class(TFrame)
    rbtnUseBuiltIn: TRadioButton;
    chkShowAdvancedOptions: TCheckBox;
    rbtnUseAdobe: TRadioButton;
    cmbxPDFDriverList: TComboBox;
    Panel1: TPanel;
    stUseAdobe: TStaticText;
    procedure ChgPDFOptionClick(Sender: TObject);
  private
    FDoc: TContainer;
  public
    constructor CreateFrame(AOwner: TComponent; ADoc: TContainer);
    procedure LoadPrefs;      //loads in the prefs from the app
    procedure SavePrefs;      //saves the changes
  end;

implementation

uses
  Printers, UGlobals, UInit, UStatus;

{$R *.dfm}

constructor TPrefAppPDF.CreateFrame(AOwner: TComponent; ADoc: TContainer);
begin
  inherited Create(AOwner);
  FDoc := ADoc;
  cmbxPDFDriverList.Left := stUseAdobe.Left + stUseAdobe.Width + 1;
  LoadPrefs;
end;

procedure TPrefAppPDF.LoadPrefs;
begin
  //PDF TAB
  //Set the PDF default method
  case appPref_DefaultPDFOption of
    pdfBuiltInWriter:   rbtnUseBuiltIn.checked  := True;
    pdfAdobeDriver:     rbtnUseAdobe.Checked    := True;
  else
    rbtnUseBuiltIn.checked  := True;
  end;
  try
    cmbxPDFDriverList.Items.Assign(Printer.Printers);
    cmbxPDFDriverList.ItemIndex := Printer.Printers.IndexOf(appPref_PrinterPDFName);
  except on E: EPrinter do
    begin
      ShowNotice('There are not any installed print drivers on your system.');
      cmbxPDFDriverList.Visible := False;
      rbtnUseAdobe.Caption := rbtnUseAdobe.Caption + ' (No drivers found.)';
    end;
  end;
  chkShowAdvancedOptions.checked := appPref_WPDFShowAdvanced;
  chkShowAdvancedOptions.enabled := rbtnUseBuiltIn.checked;
  cmbxPDFDriverList.enabled := rbtnUseAdobe.Checked;
end;

procedure TPrefAppPDF.SavePrefs;
begin
  //Save the PDF preference
  if rbtnUseBuiltIn.checked then                  //which PDF option did they choose
    appPref_DefaultPDFOption := pdfBuiltInWriter
  else if rbtnUseAdobe.Checked then
    begin
      appPref_DefaultPDFOption := pdfAdobeDriver;
      appPref_PrinterPDFName := '';
      if cmbxPDFDriverList.ItemIndex > -1 then     //if selected a printer
        appPref_PrinterPDFName := cmbxPDFDriverList.Text;  //remember it
    end;
  appPref_WPDFShowAdvanced := chkShowAdvancedOptions.checked;  //show advanced?
end;

procedure TPrefAppPDF.ChgPDFOptionClick(Sender: TObject);
begin
  chkShowAdvancedOptions.enabled := rbtnUseBuiltIn.checked;
  cmbxPDFDriverList.enabled := rbtnUseAdobe.Checked;
end;

end.
