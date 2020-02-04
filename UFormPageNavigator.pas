
{
  ClickFORMS
  (C) Copyright 1998 - 2010, Bradford Technologies, Inc.
  All Rights Reserved.

  Purpose: A form to navigate pages of a document.
}

unit UFormPageNavigator;

interface

uses
  Classes,
  Controls,
  Forms,
  Messages,
  UContainer,
  UControlPageNavigatorPanel,
  UForms,
  UPage;

type
  /// summary: A form to navigate pages of a document.
  TPageNavigator = class(TAdvancedForm)
  private
    FCloseOnClick: Boolean;
    FFreeOnClose: Boolean;
    FPageNavigatorPanel: TPageNavigatorPanel;
    function GetDocument: TContainer;
    procedure SetDocument(const Value: TContainer);
    procedure OnPageClicked(const Page: TDocPage);
    procedure OnPagePanelClicked(Sender: TObject);
  protected
    procedure DoClose(var Action: TCloseAction); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Update; override;
  published
    property CloseOnClick: Boolean read FCloseOnClick write FCloseOnClick;
    property Document: TContainer read GetDocument write SetDocument;
    property FreeOnClose: Boolean read FFreeOnClose write FFreeOnClose;
  end;

implementation

{$R *.dfm}

uses
  Windows,
  Graphics,
  UPgView;

// --- TPageNavigator ---------------------------------------------------------

/// summary: Initializes a new instance of TPageNavigator.
constructor TPageNavigator.Create(AOwner: TComponent);
begin
  inherited;
  FPageNavigatorPanel := TPageNavigatorPanel.Create(Self);
  FPageNavigatorPanel.Align := alTop;
  FPageNavigatorPanel.AutoSize := True;
  FPageNavigatorPanel.BevelOuter := bvNone;
  FPageNavigatorPanel.DoubleBuffered := True;
  FPageNavigatorPanel.OnClick := OnPagePanelClicked;
  FPageNavigatorPanel.PageClicked := OnPageClicked;
  FPageNavigatorPanel.ParentBackground := True;
  FPageNavigatorPanel.Parent := Self;
end;

/// summary: Updates the page image display.
procedure TPageNavigator.Update;
begin
  inherited;
  FPageNavigatorPanel.Update;
end;

/// summary: Gets the document used for displaying pages.
function TPageNavigator.GetDocument: TContainer;
begin
  Result := FPageNavigatorPanel.Document;
end;

/// summary: Sets the document used for displaying pages.
procedure TPageNavigator.SetDocument(const Value: TContainer);
begin
  FPageNavigatorPanel.Document := Value;
end;

/// summary: Navigates the DocView to the specified page.
procedure TPageNavigator.OnPageClicked(const Page: TDocPage);
var
  Container: TContainer;
  ItemIndex: Integer;
  PageDisplay: TPageBase;
begin
  if Assigned(Page) then
    begin
      Container := Document;
      PageDisplay := Page.pgDisplay;
      ItemIndex := Container.docView.PageList.IndexOf(PageDisplay);
      Container.PageMgr.ItemIndex := ItemIndex;
      Container.PageMgrShowSelectedPage;
      if FCloseOnClick then
        Close;
    end;
end;

/// summary: Gets focus when the mouse clicks on the page navigator panel
procedure TPageNavigator.OnPagePanelClicked;
begin
  SetFocus;
end;

/// summary: Causes the form to free itself on closing when FreeOnClose is True.
procedure TPageNavigator.DoClose(var Action: TCloseAction);
begin
  if FFreeOnClose then
    Action := caFree;
  inherited;
end;

end.
