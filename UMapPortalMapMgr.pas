{
  ClickFORMS
  (C) Copyright 1998 - 2010, Bradford Technologies, Inc.
  All Rights Reserved.

  Purpose: A collection of map portals that interface with the old map manager.
}

unit UMapPortalMapMgr;

interface

uses
  UCell,
  UClasses,
  UMapPortalManager,
  UToolMapMgr;

// *** Constants ************************************************************
const
  CGeoLocatorMapPortal = 'GeoLocator';
  CDelormeMapPortal = 'Delorme';
  CStreetNMapsMapPortal = 'Street-N-Maps';
  CMapProMapPortal = 'MapPro';

// *** Type Definitions and Classes *****************************************
type
  /// summary: An abstract portal to a mapping application.
  TMapManagerMapPortal = class(TMapPortal)
  private
    FMapManager: TMapDataMgr;
  protected
    FMapToolID: Integer;
  public
    destructor Destroy; override;
    procedure Execute; override;
  end;

  TGeoLocatorMapPortal = class(TMapManagerMapPortal)
  public
    constructor Create(ACellInstanceID: TCellInstanceID; ADocument: TAppraisalReport; UseAWService: Boolean=False); override;
  end;

  TDelormeMapPortal = class(TMapManagerMapPortal)
  public
    constructor Create(ACellInstanceID: TCellInstanceID; ADocument: TAppraisalReport; UseAWService: Boolean=False); override;
  end;

  TStreetNMapsMapPortal = class(TMapManagerMapPortal)
  public
    constructor Create(ACellInstanceID: TCellInstanceID; ADocument: TAppraisalReport; UseAWService: Boolean=False); override;
  end;

  TMapProMapPortal = class(TMapManagerMapPortal)
  public
    constructor Create(ACellInstanceID: TCellInstanceID; ADocument: TAppraisalReport; UseAWService: Boolean=False); override;
  end;

implementation

uses
  SysUtils,
  UContainer,
  UGlobals;

// *** TMapManagerPortal ****************************************************

/// summary: frees memory and releases resources.
destructor TMapManagerMapPortal.Destroy;
begin
  FreeAndNil(FMapManager);
  inherited;
end;

/// summary: executes the map portal.
procedure TMapManagerMapPortal.Execute;
var
  AppName: String;
  AppPath: String;
  Index: Integer;
begin
  if not Assigned(FMapManager) then
    begin
      Index := FMapToolID - cPlugInCmdStartNo;
      if (Index >= 0) and (Index < Length(appPref_PlugTools)) then
        begin
          AppName := appPref_PlugTools[FMapToolID - cPlugInCmdStartNo].AppName;
          AppPath := appPref_PlugTools[FMapToolID - cPlugInCmdStartNo].appPath;
        end;

      FMapManager := TMapDataMgr.CreateMapDataMgr(FMapToolID, Document as TContainer, MapCell, AppName, AppPath);
    end;

  FMapManager.ShowModal;
  DoClosed;
end;

// *** TGeoLocatorMapPortal *************************************************

constructor TGeoLocatorMapPortal.Create(ACellInstanceID: TCellInstanceID; ADocument: TAppraisalReport; UseAWService: Boolean=False);
begin
  FMapToolID := cmdToolGeoLocator;
  inherited;
end;

// *** TDelormeMapPortal ****************************************************

constructor TDelormeMapPortal.Create(ACellInstanceID: TCellInstanceID; ADocument: TAppraisalReport; UseAWService: Boolean=False);
begin
  FMapToolID := cmdToolDelorme;
  inherited;
end;

// *** TStreetNMapsMapPortal ************************************************

constructor TStreetNMapsMapPortal.Create(ACellInstanceID: TCellInstanceID; ADocument: TAppraisalReport; UseAWService: Boolean=False);
begin
  FMapToolID := cmdToolStreetNMaps;
  inherited;
end;

// *** TMapProMapPortal *****************************************************

constructor TMapProMapPortal.Create(ACellInstanceID: TCellInstanceID; ADocument: TAppraisalReport; UseAWService: Boolean=False);
begin
  FMapToolID := cmdToolMapPro;
  inherited;
end;

// *** Unit *****************************************************************

initialization
  RegisterMapPortal(CGeoLocatorMapPortal, TGeoLocatorMapPortal);
  RegisterMapPortal(CDelormeMapPortal, TDelormeMapPortal);
  RegisterMapPortal(CStreetNMapsMapPortal, TStreetNMapsMapPortal);
  RegisterMapPortal(CMapProMapPortal, TMapProMapPortal);
end.
