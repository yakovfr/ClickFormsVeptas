unit UAMC_DeliverPak;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls,
  UContainer, UAMC_Base;

type
  TAMC_DeliverPak = class(TFrame)
    label1: TLabel;
  private
    FDoc: TContainer;
    FData: TDataPackage;
  public
    constructor CreateFrame(AOwner: TComponent; ADoc: TContainer; AData: TDataPackage);
    property PackageData: TDataPackage read FData write FData;
  end;

implementation

{$R *.dfm}

{ TAMC_DeliverPak }

constructor TAMC_DeliverPak.CreateFrame(AOwner: TComponent; ADoc: TContainer; AData: TDataPackage);
begin
  inherited Create(AOwner);

  FDoc := ADoc;
  FData := AData;
end;

end.
