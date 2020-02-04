{
  ClickFORMS
  (C) Copyright 1998 - 2010, Bradford Technologies, Inc.
  All Rights Reserved.

  Purpose: Manages portals to geographical mapping applications.
}

unit UMapPortalManager;

interface

uses
  Classes,
  UCell,
  UClasses,
  UStatus,UCustomerServices;

// *** Type Definitions and Classes *****************************************
type
  /// summary: An abstract portal to a mapping application.
  TMapPortal = class
    private
      FDocument: TAppraisalReport;
      FCellInstanceID: TCellInstanceID;
      FClosedEvent: TNotifyEvent;
      FUseAWService: Boolean;
    private
      function GetMapCell: TMapLocCell;
    protected
      procedure DoClosed; virtual;
      procedure SetCellInstanceID(CellInstanceID: TCellInstanceID); virtual;
    public
      constructor Create(ACellInstanceID: TCellInstanceID; ADocument: TAppraisalReport; UseAWService: Boolean=False); virtual;
      procedure Execute; virtual; abstract;
    public
      property Document: TAppraisalReport read FDocument;
      property CellInstanceID: TCellInstanceID read FCellInstanceID write SetCellInstanceID;
      property Closed: TNotifyEvent read FClosedEvent write FClosedEvent;
      property MapCell: TMapLocCell read GetMapCell;
      property UseAWService: Boolean read FUseAWService write FUseAWService;
  end;

  /// summary: A map portal class.
  TMapPortalClass = class of TMapPortal;

  /// summary: Manages geographical mapping portals.
  TMapPortalManager = class
    private
      FCellInstanceID: TCellInstanceID;
      FDocument: TAppraisalReport;
      FMapPortal: TMapPortal;
      FMapPortalOpen: Boolean;
    private
      procedure CreatePortal(MapPortalClass: TMapPortalClass; UseAWService: Boolean=False);
    protected
      function GetMapPortalClass(ToolID: String): TMapPortalClass;
      procedure HandlePortalClosed(Sender: TObject);
    public
      constructor Create(AppraisalReport: TAppraisalReport); virtual;
      destructor Destroy; override;
      procedure LaunchMapTool(ToolID: String; CellInstanceID: TCellInstanceID; UseAWService: Boolean=False); virtual;
  end;

procedure RegisterMapPortal(ToolID: String; MapPortalClass: TMapPortalClass);
procedure UnRegisterMapPortal(MapPortalClass: TMapPortalClass);

implementation

uses
  Dialogs,
  SysUtils,
  UContainer,
  UStrings,
  UServices;

var
  GMapPortalClassList: TStringList;

// *** TMapPortal ***********************************************************

/// summary: creates a new instance of TMapPortal.
constructor TMapPortal.Create(ACellInstanceID: TCellInstanceID; ADocument: TAppraisalReport; UseAWService: Boolean=False);
begin
  FDocument := ADocument;
  inherited Create;
  CellInstanceID := ACellInstanceID;
end;

function TMapPortal.GetMapCell: TMapLocCell;
var
  Cell: TBaseCell;
begin
  Cell := (FDocument as TContainer).FindCellInstance(FCellInstanceID);
  if Assigned(Cell) and (Cell is TMapLocCell) then
    Result := Cell as TMapLocCell
  else
    Result := nil;
end;

/// summary: raises the Closed event.
procedure TMapPortal.DoClosed;
begin
  if Assigned(FClosedEvent) then
    FClosedEvent(Self);
end;

/// summary: sets the id referenced for getting the map cell.
procedure TMapPortal.SetCellInstanceID(CellInstanceID: TCellInstanceID);
begin
  FCellInstanceID := CellInstanceID;
end;

// *** TMapPortalManager ****************************************************

constructor TMapPortalManager.Create(AppraisalReport: TAppraisalReport);
begin
  FDocument := AppraisalReport;
  inherited Create;
end;

/// summary: frees memory and releases resources.
destructor TMapPortalManager.Destroy;
begin
  FreeAndNil(FMapPortal);
  inherited;
end;

/// summary: creates a new instance of the specified portal class.
/// exception: A new portal cannot be created while one is already open.
procedure TMapPortalManager.CreatePortal(MapPortalClass: TMapPortalClass; UseAWService: Boolean=False);
begin
  if not FMapPortalOpen then
    begin
      if assigned(FMapPortal) then
        FreeAndNil(FMapPortal);  // free last portal instance
      FMapPortalOpen := True;
      try
        FMapPortal := MapPortalClass.Create(FCellInstanceID, FDocument as TContainer, UseAWService);
        FMapPortal.FUseAWService := UseAWService;
      except
        FMapPortalOpen := False;
        raise;
      end;
    end
  else
    ;//raise Exception.Create('Portal is open');
end;

/// summary: Gets the map portal class for the specified tool id.
function TMapPortalManager.GetMapPortalClass(ToolID: String): TMapPortalClass;
var
  Index: Integer;
begin
  Index := GMapPortalClassList.IndexOf(ToolID);
  if (Index >= 0) then
    Result := TMapPortalClass(GMapPortalClassList.Objects[Index])
  else
    Result := nil;
end;

/// summary: Handles the Closed event of the portal.
procedure TMapPortalManager.HandlePortalClosed(Sender: TObject);
begin
  FMapPortalOpen := False;
  CheckServiceAvailable(stLocationMaps);
end;

/// summary: launches the specified map tool.
/// exception: The specified tool id has no registered map portal class.
procedure TMapPortalManager.LaunchMapTool(ToolID: String; CellInstanceID: TCellInstanceID; UseAWService: Boolean);
var
  MapPortalClass: TMapPortalClass;
begin
  MapPortalClass := GetMapPortalClass(ToolID);
  if not Assigned(MapPortalClass) then
    raise Exception.Create('Class not registered');

  //if not FMapPortalOpen then          //let's recreate it any way
    try
      FCellInstanceID := CellInstanceID;
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

// *** Unit *****************************************************************

/// summary: Initializes the unit.
procedure InitializeUnit;
begin
  if not Assigned(GMapPortalClassList) then
    GMapPortalClassList := TStringList.Create;
end;

/// summary: registers a portal with the map manager.
procedure RegisterMapPortal(ToolID: String; MapPortalClass: TMapPortalClass);
begin
  InitializeUnit;
  GMapPortalClassList.AddObject(ToolID, Pointer(MapPortalClass));
end;

/// summary: unregisters a portal with the map manager.
procedure UnRegisterMapPortal(MapPortalClass: TMapPortalClass);
begin
  InitializeUnit;
  GMapPortalClassList.Delete(GMapPortalClassList.IndexOfObject(Pointer(MapPortalClass)));
end;

initialization
  InitializeUnit;

finalization
  FreeAndNil(GMapPortalClassList);

end.
