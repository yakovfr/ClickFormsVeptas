unit UWord;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2005 by Bradford Technologies, Inc. }


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, WPRich, WPRuler, WPDefs, WPTbar, WPPrint, WpWinCtr,
  WPBltDlg, WPTblDlg, UForms;

type
  TCFWord = class(TAdvancedForm)
    WPRichText1: TWPRichText;
    WPToolBar1: TWPToolBar;
    WPRuler1: TWPRuler;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CFWord: TCFWord;

implementation

{$R *.DFM}

end.
