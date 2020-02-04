unit UDocSpeller;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2006 by Bradford Technologies, Inc. }

{ This is the object used in Addict for parsing each cell's text }
{ It is a subclass of Addicts ControlParser which is the interface}
{ to each control, in our case, its each of our cells.            }

interface

uses
  AD3Parserbase,
  Types,
  UCell,
  UEditor;

type
  TCellSpeller = class(TControlParser)
    FCell: TBaseCell;
    FEditor: TTextEditor;
    FLineStr: String;
    FEndX: LongInt;
    FUsingEnd: Boolean;
    FX: LongInt;
    FY: LongInt;      //always zero;
    FLength: LongInt;

    procedure Initialize(EditControl:Pointer); override;
    procedure ResetEditor;
    function GetChar : char; override;
    function GetLine : String; override;
    function MoveNext : Boolean; override;
    function MovePrevious : Boolean; override;
    procedure SetPosition( XPos:LongInt; YPos:LongInt; PosType:TPositionType ); override;
    procedure GetPosition( var XPos:LongInt; var YPos:LongInt ); override;
    procedure SelectWord( Length:LongInt ); override;
    procedure ReplaceWord( Replacement:String; State:LongInt ); override;
    procedure IgnoreWord( State:LongInt ); override;
    procedure CenterSelection; override;
    procedure GetCursorPosition( var XPos:LongInt; var YPos:LongInt ); override;
    procedure GetSelectionPosition( var XPosStart:LongInt; var YPosStart:LongInt; var XPosEnd:LongInt; var YPosEnd:LongInt ); override;
    procedure GetControlScreenPosition( var ControlPosition:TRect ); override;
    procedure GetSelectionScreenPosition( var SelectionPosition:TRect ); override;
    procedure UndoLast( State:LongInt; UndoAction:LongInt; var UndoData:LongInt ); override;
  end;


implementation

Uses
  Math, Controls, Forms,
  UGlobals, UContainer, UUtil1, UMain;


{ TCellSpeller }

procedure TCellSpeller.Initialize(EditControl: Pointer);
var
  Cell: TBaseCell;
begin
  if (EditControl <> nil) then
    begin
      Cell := TObject(EditControl) as TBaseCell;
      if Assigned(Cell.EditorClass) and Cell.EditorClass.InheritsFrom(TTextEditor) then
        begin
          FCell := Cell;
          if Assigned(FCell.Editor) then
            FEditor := FCell.Editor as TTextEditor
          else
            FEditor := nil;

          if FCell.FIsActive then
            FLineStr := FEditor.AnsiText
          else
            FLineStr := FCell.GetText;

          FUsingEnd := False;
          FEndX := 0;
          FX := 1;
          FY := 0;
        end;
    end;
end;

function TCellSpeller.GetChar: char;
begin
    if (Length(FLineStr) >= FX) then
      Result := FLineStr[FX]
    else
      Result := #0;
end;

function TCellSpeller.GetLine: String;
begin
  result := FLineStr;
end;

procedure TCellSpeller.GetCursorPosition(var XPos, YPos: Integer);
begin
  XPos := FX;
  YPos := 0;
end;

procedure TCellSpeller.SetPosition(XPos, YPos: Integer; PosType: TPositionType);
begin
  if (PosType = ptCurrent) then
    begin
      FX := Max( 1, XPos );
    end
  else if (PosType = ptEnd) then
    begin
      FUsingEnd   := True;
      FEndX       := XPos;
    end;
end;

procedure TCellSpeller.GetPosition(var XPos, YPos: Integer);
begin
  XPos    := FX;
  YPos    := 0;
end;

procedure TCellSpeller.GetSelectionPosition(var XPosStart, YPosStart, XPosEnd,
  YPosEnd: Integer);
begin
  XPosStart   := FX;
  YPosStart   := 0;
  XPosEnd     := FX;
  YPosEnd     := 0;
end;

function TCellSpeller.MoveNext: Boolean;
begin
  Result := (FX <= Length(FLineStr));
  inc( FX );
  if (Result) then
    begin
      if FUsingEnd and (FX > FEndX) then
        Result := False;
    end;
end;

function TCellSpeller.MovePrevious: Boolean;
begin
  Result := (FX > 1);
  if (Result) then
    begin
      dec( FX );
    end;
end;

procedure TCellSpeller.ReplaceWord(Replacement: String; State: Integer);
begin
  FEditor.InputString(replacement);      //display it
  Delete( FLineStr, FX, FLength );                //do it to internal string
  Insert( Replacement, FLineStr, FX );
  FX := FX + Length(Replacement);
end;

procedure TCellSpeller.SelectWord(Length: Integer);
var
  Doc: TContainer;
  FocusedControl: TWinControl;
  SaveSelectFlag: Boolean;
begin
  FLength := Length;
  FX      := FX - Length;
  if length > 0 then  //we get a select 0 at end for unselect
    begin
      if FEditor = nil then     //this cell is not active (ie no editor)
        begin
          Doc := TContainer(CellContainerObj(FCell));
          if Assigned(Main.AddictSpell.DialogForm) then  // remember focused control; word processor takes focus away
            FocusedControl := main.AddictSpell.DialogForm.ActiveControl
          else
            FocusedControl := nil;

          SaveSelectFlag := IsAppPrefSet(bAutoSelect);   //turn off Autotext selection
          SetAppPref(bAutoSelect, False);
          Doc.Switch2NewCell(FCell, False); //switch to cell
          SetAppPref(bAutoSelect, saveSelectFlag);
          Doc.ShowCurCell;                       //make sure act cell is not off screen

          if Assigned(FocusedControl) and FocusedControl.CanFocus then  // restore focus
            begin
              Main.AddictSpell.DialogForm.SetFocus;
              FocusedControl.SetFocus;
            end;

          FEditor := Doc.docEditor as TTextEditor;   //set this so we can inherit replaceWord
        end;
      //Fix privilege instruction error when you are in spell checking dialog box then move
      // away to click on one of the UAD cell, like check box then move back
      {if assigned(Doc.docEditor) then
      begin
        FEditor := Doc.docEditor as TTextEditor;   //set this so we can inherit replaceWord
        FEditor.SelectText(FX,Length);
      end;}
      try
        FEditor.SelectText(FX,Length);
      except
      ;
      end;
    end;
end;

procedure TCellSpeller.IgnoreWord(State: Integer);
begin
  FX := FX + FLength;
end;

procedure TCellSpeller.UndoLast(State, UndoAction: Integer;
  var UndoData: Integer);
begin
  inherited;

end;

//requests that Editor center the text within the control.
//Ignore this for now.
procedure TCellSpeller.CenterSelection;
begin
  inherited;

end;

procedure TCellSpeller.GetSelectionScreenPosition(
  var SelectionPosition: TRect);
begin
  inherited;

end;

procedure TCellSpeller.GetControlScreenPosition(var ControlPosition: TRect);
begin
  ControlPosition := Rect(-1,-1,-1,-1);
  (*
    Editor.FFrame;
    P := Point( 0, 0 );
    P := FEdit.ClientToScreen( P );
    ControlPosition := Rect( P.X, P.Y, P.X + FEdit.Width, P.Y + FEdit.Height );
*)
end;

//if we switch the focus to the container we killed FEditor and created the new one
// in the clicked cell. So FEditor now refers to the dead guy.
procedure TCellSpeller.ResetEditor;
var
  doc: TContainer;
  saveSelectFlag: Boolean;
  FocusedForm: TForm;
  FocusedControl: TWinControl;
begin
  FEditor := nil;
  if Assigned(FCell) and FCell.EditorClass.InheritsFrom(TTextEditor) then
    begin
      if FCell.FIsActive then
        FEditor := FCell.Editor as TTextEditor
      else
        begin
          doc := TContainer(CellContainerObj(FCell));
          saveSelectFlag := IsAppPrefSet(bAutoSelect);   //turn off Autotext selection
          SetAppPref(bAutoSelect, False);

          FocusedForm := Screen.ActiveForm;  // word processor cell grabs focus away from spell checker
          FocusedControl := Screen.ActiveControl;
          doc.Switch2NewCell(FCell, False); //switch to cell
          FocusedForm.SetFocus;
          FocusedControl.SetFocus;

          SetAppPref(bAutoSelect, saveSelectFlag);
          doc.ShowCurCell;                       //make sure act cell is not off screen
          FEditor := doc.docEditor as TTextEditor;   //set this so we can inherit replaceWord
        end;
    end;
end;

end.
