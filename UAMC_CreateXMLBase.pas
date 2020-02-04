unit UAMC_CreateXMLBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls,
  UContainer;

type
  TAMC_CreateXMLBase = class(TFrame)
    Label1: TLabel;
  private
    FDoc: TContainer;
  public
    constructor CreateFrame(AOwner: TComponent; ADoc: TContainer);
  end;

implementation

{$R *.dfm}

{ TAMC_CreateXMLBase }

constructor TAMC_CreateXMLBase.CreateFrame(AOwner: TComponent; ADoc: TContainer);
begin
  inherited Create(AOwner);

  FDoc := ADoc;
end;

end.
