unit UListCellXPath;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

interface

uses
  UCell,
  UClasses, Dialogs;

type
  /// summary: A reference to an instance of TCelLXPathItem.
  PCellXPathItem = ^TCellXPathItem;

  /// summary: a linked list item containing a cell InstanceID and associated xpath.
  TCellXPathItem = record
    NextItem: PCellXPathItem;
    InstanceID: TCellInstanceID;
    XPath: AnsiString;
  end;

  /// summary: A list of linked cells and their associated xpaths.
  TCellXPathList = class
  private
    FDocument: TAppraisalReport;
    FFirstItem: PCellXPathItem;
  public
    constructor Create(const Document: TAppraisalReport);
    destructor Destroy; override;
    procedure AddItem(const InstanceID: TCellInstanceID; const XPath: String);
    procedure Clear;
    function GetCellByXPath(const XPath: String): TBaseCell;
    procedure SaveToFile(const FileName: String);
  end;

implementation

uses
  Classes,
  SysUtils,
  UContainer;

/// summary: Initializes a new instance of TCellXPathList.
constructor TCellXPathList.Create(const Document: TAppraisalReport);
begin
  inherited Create;
  FDocument := Document;
  FFirstItem := nil;
end;

/// summary: Frees resources consumed by the instance.
destructor TCellXPathList.Destroy;
begin
  inherited;
  Clear;
end;

/// summary: Adds a new cell instance and associated xpath to the list.
procedure TCellXPathList.AddItem(const InstanceID: TCellInstanceID; const XPath: String);
var
  NewItem: PCellXPathItem;
begin
  GetMem(NewItem, SizeOf(TCellXPathItem));
  Initialize(NewItem.XPath);
  NewItem.NextItem := FFirstItem;
  NewItem.InstanceID := InstanceID;
  NewItem.XPath := XPath;
  FFirstItem := NewItem;
end;

/// summary: Clears all the items in the list.
procedure TCellXPathList.Clear;
var
  Item: PCellXPathItem;
  Next: PCellXPathItem;
begin
  Item := FFirstItem;
  FFirstItem := nil;
  while (Item <> nil) do
    begin
      Next := Item.NextItem;
      Finalize(Item.XPath);
      FreeMem(Item);
      Item := Next;
    end;
end;

/// summary: Gets the cell instance associated with an xpath.
function TCellXPathList.GetCellByXPath(const XPath: String): TBaseCell;
var
  Item: PCellXPathItem;
begin
  Item := FFirstItem;
  while (Item <> nil) do
    begin
      if SameText(XPath, Item.XPath) then
      begin
        break;
      end  
      else
        Item := Item.NextItem;
    end;

  if (Item <> nil) then
    Result := (FDocument as TContainer).FindCellInstance(Item.InstanceID)
  else
    Result := nil;
end;

/// summary: Saves the contents of the list to a text file in csv format.
procedure TCellXPathList.SaveToFile(const FileName: String);
var
  InstanceID: String;
  Item: PCellXPathItem;
  Strings: TStringList;
  XPath: String;
begin
  Strings := TStringList.Create;
  try
    Item := FFirstItem;
    while (Item <> nil) do
      begin
        InstanceID := GuidToString(Item.InstanceID);
        XPath := StringReplace(Item.XPath, '"', '""', [rfReplaceAll]);
        Strings.Add('"' + InstanceID + '","' + XPath + '"');
        Item := Item.NextItem;
      end;
    Strings.SaveToFile(FileName);
  finally
    FreeAndNil(Strings);
  end;
end;

end.
