unit UFormFinder;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2005 by Bradford Technologies, Inc. }

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UBase, Grids, StdCtrls, ComCtrls, UForms;

type
  TFormFinder = class(TAdvancedForm)
    SearchWordsL: TLabel;
    SearchWordsE: TEdit;
    FindB: TButton;
    btnAdd: TButton;
    chkMatchAll: TCheckBox;
    StatusBar: TStatusBar;
    procedure FindBClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SearchWordsEKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FoundSGClick(Sender: TObject);
    procedure FoundSGDblClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    FFormList : TStringList;
    FFoundSG: TStringGrid;
    FClientBaseHeight : Integer;
    procedure AdjustDPISettings;

  public
    constructor create(AOwner: TComponent); override;
  end;

var
  FormFinder: TFormFinder;

const
  DefaultRowHeight = 21;
  StatusBarHeight  = 20;


implementation

uses
  StrUtils, Math,
  UGlobals, UMain, UFormsLib, UFileGlobals;


{$R *.dfm}


procedure TFormFinder.FindBClick(Sender: TObject);
var
  N, maxRows: Integer;
  nStr: String;
begin
  if assigned(FFoundSG) then
    begin
      FFoundSG.Cols[0].Clear;     //are we clearing the objects
      FreeAndNil(FFoundSG);
    end;
  if FormsLib.FindForms(SearchWordsE.Text, chkMatchAll.Checked, FFormList) then
    begin
      N := FFormList.Count;
      StatusBar.Height := StatusBarHeight;
      maxRows := Min(N, 10);
      Height := FClientBaseHeight + (maxRows * StatusBarHeight)+5;

      FFoundSG := TStringGrid.Create(self);
      FFoundSG.Parent := Self;
      FFoundSG.Top := FClientBaseHeight;
      FFoundSG.height := (maxRows * StatusBarHeight) + 3;
      FFoundSG.align := alBottom;
      FFoundSG.Anchors := [akTop, akLeft, akRight, akBottom];
      FFoundSG.ColCount := 1;
      FFoundSG.DefaultColWidth := Width - 30;
      FFoundSG.DefaultRowHeight := DefaultRowHeight;
      FFoundSG.FixedCols := 0;
      FFoundSG.RowCount := N;
      FFoundSG.FixedRows := 0;
      FFoundSG.Options := [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect, goThumbTracking];
      FFoundSG.ScrollBars := ssVertical;
      FFoundSG.OnClick := FoundSGClick;
      FFoundSG.OnDblClick := FoundSGDblClick;

      FFoundSG.Cols[0].AddStrings(FFormList);
      FFoundSG.Row := 0;                        //hilight the first
      ActiveControl := FFoundSG;                //make it active control
      FoundSGClick(nil);                        //now show it in FormsLib

      nstr := '  ' + IntToStr(FFormList.Count) + ' Form';
      if FFormList.Count <> 1 then
        nstr := nstr + 's';
      nstr := nstr + ' Found';
      StatusBar.SimpleText :=  nstr;
      btnAdd.enabled := True;
    end // then
  else
    begin
      Height := FClientBaseHeight;
      StatusBar.SimpleText := 'No Forms Found';
      btnAdd.enabled := False;
    end;
end;

procedure TFormFinder.SearchWordsEKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    begin
      Key := 0;
      FindBClick(Sender);
    end; // if
end;

procedure TFormFinder.FoundSGClick(Sender: TObject);
begin
  FormsLib.Show;               //yes show it
  FormsLib.SetFocus;           //refocus it
  Main.FormsLibraryCmd.Caption := 'Hide Forms Library';
  FormsLib.FormLibTree.Select(TFindFormInfo(FFoundSG.Objects[0, FFoundSG.Row]).fNode);
end;

procedure TFormFinder.FoundSGDblClick(Sender: TObject);
begin
  FormsLib.FormLibTreeDblClick(FormsLib.FormLibTree);
end;

procedure TFormFinder.btnAddClick(Sender: TObject);
begin
  FoundSGDblClick(sender);
end;

procedure TFormFinder.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if assigned(FFoundSG) then
    begin
      FFoundSG.Cols[0].Clear;     //are we clearing the objects
      FreeAndNil(FFoundSG);
    end;
  Height := FClientBaseHeight + 5;
  StatusBar.SimpleText := '';
  btnAdd.enabled := False;
end;

procedure TFormFinder.AdjustDPISettings;
begin
    SearchWordsE.left := SearchWordsL.Left + SearchWordsL.Width + 2;
    FindB.Left := SearchWordsE.Left + SearchWordsE.Width + 5;
    btnAdd.Left := FindB.left + FindB.Width + 10;
    chkMatchAll.Top := SearchWordsE.Top + SearchWordsE.Height + 5;
    StatusBar.Top := chkMatchAll.Top + chkMatchAll.Height + 5;
    Width := btnAdd.Left + btnAdd.Width + 50;
    Height := FClientBaseHeight + 5;
    Constraints.MinWidth := Width;
    Constraints.MinHeight := Height;
end;


constructor TFormFinder.Create(AOwner: TComponent);
begin
  inherited;
  SettingsName := CFormSettings_FormFinder;
  FFormList := TStringList.Create;
end;

procedure TFormFinder.FormDestroy(Sender: TObject);
begin
  while FFormList.Count > 0 do begin // Loop to free all objects
    FFormList.Objects[0].Free;
    FFormList.Delete(0);
  end;
  FFormList.Free;

  FormFinder := Nil;    //nil the global var
end;


procedure TFormFinder.FormShow(Sender: TObject);
begin
  AdjustDPISettings;
end;

end.
