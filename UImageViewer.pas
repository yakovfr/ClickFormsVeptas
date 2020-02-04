unit UImageViewer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TMultiP, ComCtrls, UForms;

type
  TImgViewForm = class(TAdvancedForm)
    StatusBar1: TStatusBar;
    PMultiImage1: TPMultiImage;
    constructor Create(AOwner: TComponent; prAddress,imgPath,imgDescr: String);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ImgViewForm: TImgViewForm;

implementation

{$R *.dfm}

constructor  TImgViewForm.Create(AOwner: TComponent; prAddress,imgPath,imgDescr: String);
begin
   inherited Create(AOwner);
   Caption := imgDescr;
   StatusBar1.SimpleText := prAddress;
   PMultiImage1.ImageName := imgPath;
   Hint := imgPath;
end;

end.
