unit UMathRedstone;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

interface

uses
  UGlobals, UContainer;

const
  fmRStone8022   = 8022;


  function ProcessForm8022Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;


implementation

uses
	Dialogs, SysUtils, DateUtils, Math,
	UUtil1, UStatus, UBase, UForm, UPage, UCell, UMath, UStrings;


function ProcessForm8022Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin

  if Cmd > 0 then
    repeat
      case Cmd of
        1:  cmd := MultPercentAB(doc, mcx(cx,89), mcx(cx,91), mcx(cx,92));
        2:  cmd := MultPercentAB(doc, mcx(cx,93), mcx(cx,95), mcx(cx,96));
        3:  cmd := MultPercentAB(doc, mcx(cx,97), mcx(cx,99), mcx(cx,100));
        4:  cmd := MultPercentAB(doc, mcx(cx,101), mcx(cx,103), mcx(cx,104));
        5:  cmd := MultPercentAB(doc, mcx(cx,105), mcx(cx,107), mcx(cx,108));
        6:  cmd := MultPercentAB(doc, mcx(cx,109), mcx(cx,111), mcx(cx,112));
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

end.
