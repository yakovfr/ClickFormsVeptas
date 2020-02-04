unit UMathXtras;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2005 by Bradford Technologies, Inc. }

interface

uses
  UGlobals, UContainer;

// This file handles the generic pages where the user defines what they are.
// Such as Comps 1-2-3.
// Each page has 3 rountines.
// SetPageTitleName - Name in the Yellow Bar, also goes in the table of contents
// SetFormTitle - title on the form, the form heading.
// ConfigureInstance - autos assigns the values 1,2,3,..4,5,6..7,8,9, etc. 

const
  PhotoXCmps  = 304;    //Generic Comps Photo page
  PhotoXLsts  = 306;    //Generic Listings Photo Page
  PhotoXRnts  = 307;    //Generic Rentals Photo Page
  PhotoXCmpL  = 314;    //Generic Comps large Photo page
  PhotoXCmDL  = 315;    //Generic Comps large Photo page with description
  PhotoXLstL  = 316;    //Generic Listings large Photo Page
  PhotoXLstAP = 4382;   //AI Ready Photo Listing Page
  PhotoXRntL  = 317;    //Generic Rentals large Photo Page

  PhotoList4082 = 4082;  //Listing 3 Photo Page
  PhotoComp4084 = 4084;  //Comps 3 Photo Page

  PhotoComp4181 = 4181;  //Ticket #1088: Comps 3 photo non lender page
  PhotoList4192 = 4192;  //Ticket #1089: Listing 3 photo non lender page

  function ProcessForm0304Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0306Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0307Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm4082Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm4084Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm4382Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;

implementation

uses
	Dialogs, SysUtils, Math,
	UUtil1, UStatus, UBase, UForm, UPage, UCell, UMath, UStrings;


//Generic math for the extra photo pages
function ProcessForm0304Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetXXXPageTitle(doc, cx, 'COMPARABLES', 'PHOTO ADDENDUM',14,18,22, 2);
        2:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Photo Comparables', 14,18,22);
        3:
          cmd := ConfigPhotoXXXInstance(doc, cx, 14, 18, 22);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0306Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetXXXPageTitle(doc, cx, 'LISTINGS', 'PHOTO ADDENDUM',14,18,22, 2);
        2:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Photo Listings', 14,18,22);
        3:
          cmd := ConfigPhotoXXXInstance(doc, cx, 14, 18, 22);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0307Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetXXXPageTitle(doc, cx, 'RENTALS', 'PHOTO ADDENDUM',14,18,22, 2);
        2:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Photo Rentals', 14,18,22);
        3:
          cmd := ConfigPhotoXXXInstance(doc, cx, 14, 18, 22);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;


//Generic math for the extra photo pages
function ProcessForm4082Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetXXXPageTitle(doc, cx, 'COMPARABLE LISTING', 'PHOTO ADDENDUM',11,15,19, 2);
        2:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Comparable Listing', 11,15,19);
        3:
          cmd := ConfigPhotoXXXInstance(doc, cx, 11, 15, 19);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;


function ProcessForm4084Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetXXXPageTitle(doc, cx, 'COMPARABLES', 'PHOTO ADDENDUM',11,15,19, 2);
        2:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Comparables', 11,15,19);
        3:
          cmd := ConfigPhotoXXXInstance(doc, cx, 11, 15, 19);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm4382Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetXXXPageTitle(doc, cx, 'LISTINGS', 'PHOTO ADDENDUM',7,11,15, 2);
        2:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Photo Listings', 7,11,15);
        3:
          cmd := ConfigPhotoXXXInstance(doc, cx, 7, 11, 15);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

end.
