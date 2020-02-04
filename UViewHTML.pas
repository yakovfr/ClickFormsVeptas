unit UViewHTML;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw,
  UForms;

type
  TViewHTML = class(TVistaAdvancedForm)
    WebBrowser: TWebBrowser;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
  end;

var
  ViewHTML: TViewHTML;



procedure DisplayPDFFromURL(AOwner: TComponent; const Name, URL: String);



implementation

{$R *.dfm}

Uses
  UGlobals, UStatus;

procedure DisplayPDFFromURL(AOwner: TComponent; const Name, URL: String);
begin
  if assigned(ViewHTML) then        //only have one at a time.
    ViewHTML.Free;

  ViewHTML := TViewHTML.Create(AOwner);
  try
//    ViewPDF.Parent := AOwner as TWinControl;
    ViewHTML.caption := Name;
    ViewHTML.WebBrowser.Navigate(URL);
//    ViewHTML.Show;
      ViewHTML.ShowModal;           //forces only one at a time
  except
    ShowAlert(atWarnAlert, 'Problems were encountered in tryiong to display the PDF.');
  end;
end;


{ TViewPDF }

constructor TViewHTML.Create(AOwner: TComponent);
begin
  inherited;

  SettingsName := CFormSettings_HTMLViewer;
end;

procedure TViewHTML.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   ViewHTML := nil;
end;

end.
