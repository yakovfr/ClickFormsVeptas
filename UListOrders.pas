unit UListOrders;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2005 by Bradford Technologies, Inc. }


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, UForms;

type
  TOrdersList = class(TAdvancedForm)
    StatusBar1: TStatusBar;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  OrdersList: TOrdersList;

implementation

{$R *.DFM}

end.
