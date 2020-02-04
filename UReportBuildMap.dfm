object MapBuilder: TMapBuilder
  Left = 385
  Top = 121
  BorderStyle = bsDialog
  Caption = 'Report Map Builder'
  ClientHeight = 708
  ClientWidth = 1041
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object BingMaps: TGAgisBingMap
    Left = 0
    Top = 40
    Width = 1041
    Height = 668
    Cursor = gcHand
    Align = alClient
    DragCursor = gcMove
    TabOrder = 0
    StatusBar = False
    ShowScrollBars = False
    Show3DBorder = False
    UseFile = False
    MapWidth = 1041
    MapHeight = 668
    AutoSize = True
    CenterLatitude = 37.000000000000000000
    CenterLongitude = -121.000000000000000000
    ZoomLevel = 17
    ShowMarkers = True
    ShowLabels = False
    ShowPolylines = True
    ShowPolygons = True
    ShowCurves = False
    ShowCircles = True
    ShowArrows = True
    ShowDirections = False
    ShowLayers = False
    Version = '8.0.3'
    OnMapLoad = BingMapsMapLoad
    OnMapShow = BingMapsMapShow
    SecureLogin = False
    SecureTiles = False
    EnableDisplayThreshold = False
    InertiaIntensity = 0.850000000000000000
    BingAPIReqVer = '8.0'
    MapLanguage = 'English - United States'
    MapLanguageCode = 'en-US'
    ShowPlanetNavigationControl = True
    Grid = False
    Sun = False
    Atmosphere = False
    Animated = False
    ShowBorders = False
    ShowBuildings = True
    ShowBuildingsLowRes = False
    ShowRoads = True
    ShowTerrain = True
    MapType = mtRoad
    MapMode = mm2D
    MapControlType = mcDefault
    ShowMapLabels = False
    ShowBaseTileLayer = True
    ShowDashboard = False
    UseNewStyles = False
    ShowBreadcrump = False
    ShowMapModeSwitch = True
    ShowMapTypeSelector = True
    ShowScaleControl = True
    OverviewMap = False
    FixedMap = False
    FixedPosition = False
    EnableDrag = True
    EnableZoom = True
    ScrollWheelZoom = True
    ScrollWheelZoomCenterCursor = False
    DoubleClickZoom = True
    ContinuousZoom = False
    DragZoom = False
    EnableKeyboard = True
    EnableMouse = True
    EnableUserInput = True
    ControlData = {
      4C000000976B00000A4500000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E12620A000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object topPanel: TPanel
    Left = 0
    Top = 0
    Width = 1041
    Height = 40
    Align = alTop
    TabOrder = 1
    object lblUserMsg: TLabel
      Left = 16
      Top = 12
      Width = 5
      Height = 13
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btnCancel: TButton
      Left = 824
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Cancel'
      TabOrder = 0
      OnClick = btnCancelClick
    end
    object btnTransfer: TButton
      Left = 920
      Top = 8
      Width = 97
      Height = 25
      Caption = 'Capture Image'
      TabOrder = 1
      OnClick = btnTransferClick
    end
    object btnDashboard: TButton
      Left = 680
      Top = 8
      Width = 105
      Height = 25
      Caption = 'Show Map Controls'
      TabOrder = 2
      OnClick = btnDashboardClick
    end
  end
  object HiddenViewTimer: TTimer
    Enabled = False
    Interval = 2000
    OnTimer = HiddenViewTimerTimer
    Left = 60
    Top = 64
  end
end
