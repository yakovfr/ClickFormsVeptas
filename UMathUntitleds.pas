unit UMathUntitleds;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2006 by Bradford Technologies, Inc. }

interface

uses
  UGlobals, UContainer;

// This file handles the generic pages where the user defines the title.
// Such as Untitled Exhibits, Untitled Comments, etc.
// Each page has only one 1 rountine. It takes the text from the title and
// makes it the page title, the form manager title and the title in Table
// of Contents.

const
  fmNTComtLtr     = 96;     //Comment Untitled Letter Size
  fmNTComtLgl     = 97;     //Comment Untitled Legal Size
  fmNTComtWSign   = 124;    //Comment Untitled With Signature
  fmNTMapLgl      = 114;    //Map Untitled Legal Size
  fmNTMapLtr      = 115;    //Map Untitled Letter Size
  fmNTPhoto3X5    = 308;    //Photo Untitled 3 x 5
  fmNTPhoto4X6    = 318;    //Photo Untitled 4 x 6
  fmNTPhoto6      = 324;    //Photo Untitled 6 photos
  fmNTPhoto15     = 325;    //Photo Untitled 15 photos
  fmNTPhoto12Lgl  = 326;    //Photo Untitled 12 on legal size
  fmNTPhoto12Ltr  = 327;    //Photo Untitled 12 on letter size
  fmNTPhotoVert   = 328;    //Photo Untitled vertical images
  fmNTExhibit595  = 595;    //Exhibit
  fmNTExhibit596  = 596;    //Exhibit
  fmNTExhibit597  = 597;    //Exhibit
  fmNTExhibit598  = 598;    //Exhibit
  fmNTExhibit725  = 725;    //Exhibit w/comments
  fmNTExhibit726  = 726;    //Exhibit w/comments
  fmNTExhibit727  = 727;    //Exhibit w/comments
  fmNTExhibit728  = 728;    //Exhibit w/comments
  fmNTPhotoVertical3  = 303;    //Photo Untitled (3) Vertical
  fmNTPhotoVertical6  = 339;    //Photo Untitled (6) Vertical
  fmNTPhotoMixed1  = 305;    //Photo Untitled Mixed #1
  fmNTPhotoMixed2  = 313;    //Photo Untitled Mixed #2
  fmNTPhotoMixed3  = 315;    //Photo Untitled Mixed #3
  fmNTPhotoMixed4  = 329;    //Photo Untitled Mixed #4

  function ProcessForm0096Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0097Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0124Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0114Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0115Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0308Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0318Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0324Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0325Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0326Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0327Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0328Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0595Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0596Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0597Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0598Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0725Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0726Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0727Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0728Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;

  function ProcessForm0303Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0339Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0305Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0313Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0315Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0329Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;

implementation

uses
	Dialogs, SysUtils, Math,
	UUtil1, UStatus, UBase, UForm, UPage, UCell, UMath, UStrings;

function ProcessForm0096Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetPageTitleBarName(doc, CX);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0097Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetPageTitleBarName(doc, CX);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0124Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetPageTitleBarName(doc, CX);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0114Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetPageTitleBarName(doc, CX);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0115Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetPageTitleBarName(doc, CX);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0308Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetPageTitleBarName(doc, CX);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0318Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetPageTitleBarName(doc, CX);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0324Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetPageTitleBarName(doc, CX);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0325Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetPageTitleBarName(doc, CX);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0326Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetPageTitleBarName(doc, CX);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0327Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetPageTitleBarName(doc, CX);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0328Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetPageTitleBarName(doc, CX);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0595Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetPageTitleBarName(doc, CX);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0596Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetPageTitleBarName(doc, CX);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0597Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetPageTitleBarName(doc, CX);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0598Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetPageTitleBarName(doc, CX);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0725Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetPageTitleBarName(doc, CX);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0726Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetPageTitleBarName(doc, CX);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0727Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetPageTitleBarName(doc, CX);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0728Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetPageTitleBarName(doc, CX);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0303Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetPageTitleBarName(doc, CX);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0339Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetPageTitleBarName(doc, CX);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0305Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetPageTitleBarName(doc, CX);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0313Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetPageTitleBarName(doc, CX);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0315Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetPageTitleBarName(doc, CX);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0329Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetPageTitleBarName(doc, CX);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;
end.
