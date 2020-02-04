{
  ClickFORMS
  (C) Copyright 1998 - 2018, Bradford Technologies, Inc.
  All Rights Reserved.

  Purpose: Manages portals to geographical mapping applications.
}

unit UMapPortalManagerSL;

interface

uses
  Classes,
  UCell,
  UClasses,
  UStatus,UCustomerServices, uGlobals, iniFiles;

const
  CLocationMapCellID = 1158;

// *** Type Definitions and Classes *****************************************
type
  /// summary: An abstract portal to a mapping application.
  TMapPortalSL = class
    private
      FDocument: TAppraisalReport;
      //FCellInstanceID: TCellInstanceID;
      FMapCell: TMapLocCell;
      FClosedEvent: TNotifyEvent;
      FUseAWorCustDBService: Boolean;
    private
      //function GetMapCell: TMapLocCell;
    protected
      procedure DoClosed; virtual;
  //    procedure SetCellInstanceID(CellInstanceID: TCellInstanceID); virtual;
    public
      constructor Create(ACell: TBaseCell; ADocument: TAppraisalReport; UseAWOrCustDBService: Boolean=False); virtual;
      procedure Execute; virtual; abstract;
    public
      property Document: TAppraisalReport read FDocument;
      //property CellInstanceID: TCellInstanceID read FCellInstanceID write SetCellInstanceID;
      property Closed: TNotifyEvent read FClosedEvent write FClosedEvent;
      property MapCell: TMapLocCell read FMapCell;
      property UseAWorCustDBService: Boolean read FUseAWorCustDBService write FUseAWorCustDBService;
  end;

  /// summary: A map portal class.
  TMapPortalClassSL = class of TMapPortalSL;

  /// summary: Manages geographical mapping portals.
  TMapPortalManagerSL = class
    private
      //FCellInstanceID: TCellInstanceID;
      FCell: TBaseCell;
      FDocument: TAppraisalReport;
      FMapPortal: TMapPortalSL;
      FMapPortalOpen: Boolean;
    private
      procedure CreatePortal(MapPortalClass: TMapPortalClassSL; UseAWorCustDBService: Boolean=False);
    protected
      function GetMapPortalClass(ToolID: String): TMapPortalClassSL;
      procedure HandlePortalClosed(Sender: TObject);
    public
      constructor Create(AppraisalReport: TAppraisalReport); virtual;
      destructor Destroy; override;
      procedure LaunchMapTool(ToolID: String; CellInstanceID: TCellInstanceID; UseAWService: Boolean=False); virtual;
      procedure LaunchMapToolSL(ToolID: String; Cell: TBaseCell; UseAWorCustDBService: Boolean); virtual;
  end;

procedure RegisterMapPortalSL(ToolID: String; MapPortalClass: TMapPortalClassSL);
procedure UnRegisterMapPortalSL(MapPortalClass: TMapPortalClassSL);

implementation

uses
  Dialogs,
  SysUtils,
  UContainer,
  UForm,
  UStrings,
  UServices;

var
  GMapPortalClassList: TStringList;

// *** TMapPortal ***********************************************************

/// summary: creates a new instance of TMapPortal.
constructor TMapPortalSL.Create(ACell: TBaseCell; ADocument: TAppraisalReport; UseAWOrCustDBService: Boolean=False);
begin
  FDocument := ADocument;
  inherited Create;
  if assigned(ACell) and (ACell is TMapLocCell) then
    FMapCell := TMapLocCell(ACell)
  else
    FMapCell := nil;
  //CellInstanceID := ACellInstanceID;
end;

{function TMapPortalSL.GetMapCell: TMapLocCell;
var
  Cell: TBaseCell;
  form: TDocForm;
  doc: TContainer;
begin
  //Cell := (FDocument as TContainer).FindCellInstance(FCellInstanceID);
  doc := TContainer(FDocument);
  form := doc.GetFormByOccurance(cFormLegalMapUID, 0, false);
  if assigned(form) then
    cell := form.GetCellByID(CLocationMapCellID);
  if not assigned(cell) then
    begin
      form := doc.GetFormByOccurance(cFormLetterMapUID, 0, false);
      if assigned(form) then
        cell := form.GetCellByID(CLocationMapCellID);
    end;
  if Assigned(Cell) and (Cell is TMapLocCell) then
    Result := Cell as TMapLocCell
  else
    Result := nil;
end;       }

/// summary: raises the Closed event.
procedure TMapPortalSL.DoClosed;
begin
  if Assigned(FClosedEvent) then
    FClosedEvent(Self);
end;

/// summary: sets the id referenced for getting the map cell.
{procedure TMapPortalSL.SetCellInstanceID(CellInstanceID: TCellInstanceID);
begin
  FCellInstanceID := CellInstanceID;
end;                                   }

// *** TMapPortalManager ****************************************************

constructor TMapPortalManagerSL.Create(AppraisalReport: TAppraisalReport);
begin
  FDocument := AppraisalReport;
  inherited Create;
end;

/// summary: frees memory and releases resources.
destructor TMapPortalManagerSL.Destroy;
begin
  FreeAndNil(FMapPortal);
  inherited;
end;

/// summary: creates a new instance of the specified portal class.
/// exception: A new portal cannot be created while one is already open.
procedure TMapPortalManagerSL.CreatePortal(MapPortalClass: TMapPortalClassSL; UseAWOrCustDBService: Boolean=False);
begin
  if not FMapPortalOpen then
    begin
      if assigned(FMapPortal) then
        FreeAndNil(FMapPortal);  // free last portal instance
      FMapPortalOpen := True;
      try
        FMapPortal := MapPortalClass.Create(FCell, FDocument as TContainer, UseAWOrCustDBService);
        FMapPortal.FUseAWorCustDBService := UseAWOrCustDBService;
      except
        FMapPortalOpen := False;
        raise;
      end;
    end
  else
    ;//raise Exception.Create('Portal is open');
end;

/// summary: Gets the map portal class for the specified tool id.
function TMapPortalManagerSL.GetMapPortalClass(ToolID: String): TMapPortalClassSL;
var
  Index: Integer;
begin
  Index := GMapPortalClassList.IndexOf(ToolID);
  if (Index >= 0) then
    Result := TMapPortalClassSL(GMapPortalClassList.Objects[Index])
  else
    begin
       Result := nil;
    end;
end;

/// summary: Handles the Closed event of the portal.
procedure TMapPortalManagerSL.HandlePortalClosed(Sender: TObject);
begin
  FMapPortalOpen := False;
  CheckServiceAvailable(stLocationMaps);
end;

/// summary: launches the specified map tool.
/// exception: The specified tool id has no registered map portal class.
procedure TMapPortalManagerSL.LaunchMapTool(ToolID: String; CellInstanceID: TCellInstanceID; UseAWService: Boolean);
var
  MapPortalClass: TMapPortalClassSL;
begin
  MapPortalClass := GetMapPortalClass(ToolID);
  if not Assigned(MapPortalClass) then
    raise Exception.Create('Class not registered');

  //if not FMapPortalOpen then          //let's recreate it any way
    try
     // FCellInstanceID := CellInstanceID;
      CreatePortal(MapPortalClass, UseAWService);
      FMapPortal.Closed := HandlePortalClosed;
      FMapPortal.Execute;
    except
      on EAbort do
        begin
          FreeAndNil(FMapPortal);
          FMapPortalOpen := False;
        end;

      on E: Exception do
        begin
          FreeAndNil(FMapPortal);
          FMapPortalOpen := False;
          ShowNotice(Format(msgMapPortalError, [E.Message]));
        end;
    end;
end;


procedure TMapPortalManagerSL.LaunchMapToolSL(ToolID: String; Cell: TBaseCell; UseAWOrCustDBService: Boolean);
var
  MapPortalClass: TMapPortalClassSL;
begin
  MapPortalClass := GetMapPortalClass(ToolID);
  if not Assigned(MapPortalClass) then
    raise Exception.Create('Class not registered');

  //if not FMapPortalOpen then          //let's recreate it any way
    try
      FCell := Cell;
      CreatePortal(MapPortalClass, UseAWOrCustDBService);
      FMapPortal.Closed := HandlePortalClosed;
      FMapPortal.Execute;
    except
      on EAbort do
        begin
          FreeAndNil(FMapPortal);
          FMapPortalOpen := False;
        end;

      on E: Exception do
        begin
          FreeAndNil(FMapPortal);
          FMapPortalOpen := False;
          ShowNotice(Format(msgMapPortalError, [E.Message]));
        end;
    end;
end;

// *** Unit *****************************************************************

/// summary: Initializes the unit.
procedure InitializeUnit;
begin
  if not Assigned(GMapPortalClassList) then
    GMapPortalClassList := TStringList.Create;
end;

procedure RegisterMapPortalSL(ToolID: String; MapPortalClass: TMapPortalClassSL);
begin
  InitializeUnit;
  GMapPortalClassList.AddObject(ToolID, Pointer(MapPortalClass));
end;

/// summary: unregisters a portal with the map manager.
procedure UnRegisterMapPortalSL(MapPortalClass: TMapPortalClassSL);
begin
  InitializeUnit;
  GMapPortalClassList.Delete(GMapPortalClassList.IndexOfObject(Pointer(MapPortalClass)));
end;



initialization
  InitializeUnit;

finalization
  FreeAndNil(GMapPortalClassList);

end.
