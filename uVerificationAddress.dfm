object AddrVerification: TAddrVerification
  Left = 425
  Top = 80
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = 'Address Verification'
  ClientHeight = 582
  ClientWidth = 805
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LenderGroup: TGroupBox
    Left = 24
    Top = 552
    Width = 457
    Height = 10
    Caption = 'Lender'
    TabOrder = 0
    Visible = False
    object Label7: TLabel
      Left = 19
      Top = 72
      Width = 43
      Height = 13
      Caption = 'Client ID:'
    end
    object Label4: TLabel
      Left = 19
      Top = 108
      Width = 47
      Height = 13
      Caption = 'Company:'
    end
    object Label5: TLabel
      Left = 19
      Top = 132
      Width = 40
      Height = 13
      Caption = 'Contact:'
    end
    object Label6: TLabel
      Left = 19
      Top = 168
      Width = 28
      Height = 13
      Caption = 'Email:'
    end
    object StaticText6: TLabel
      Left = 226
      Top = 68
      Width = 41
      Height = 13
      Caption = 'Address:'
    end
    object StaticText7: TLabel
      Left = 250
      Top = 92
      Width = 20
      Height = 13
      Caption = 'City:'
    end
    object StaticText8: TLabel
      Left = 214
      Top = 128
      Width = 28
      Height = 13
      Caption = 'State:'
    end
    object StaticText9: TLabel
      Left = 324
      Top = 128
      Width = 18
      Height = 13
      Caption = 'Zip:'
    end
    object StaticText25: TLabel
      Left = 22
      Top = 200
      Width = 34
      Height = 13
      Caption = 'Phone:'
    end
    object btnLenderList: TButton
      Left = 10
      Top = 24
      Width = 80
      Height = 25
      Caption = 'Client List'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = btnLenderListClick
    end
    object cbLenderID: TComboBox
      Left = 67
      Top = 64
      Width = 92
      Height = 21
      DropDownCount = 5
      ItemHeight = 13
      TabOrder = 1
      OnChange = edtLenderContactChange
      OnCloseUp = cbLenderIDCloseUp
      OnDropDown = cbLenderIDDropDown
      OnExit = cbLenderIDExit
    end
    object edtLenderID: TEdit
      Left = 166
      Top = 64
      Width = 5
      Height = 21
      ReadOnly = True
      TabOrder = 2
      Visible = False
    end
    object edtLenderName: TEdit
      Left = 68
      Top = 100
      Width = 180
      Height = 21
      TabOrder = 3
      OnChange = edtLenderContactChange
    end
    object edtLenderContact: TEdit
      Left = 68
      Top = 124
      Width = 180
      Height = 21
      TabOrder = 4
      OnChange = edtLenderContactChange
    end
    object edtLenderEmail: TEdit
      Left = 68
      Top = 160
      Width = 180
      Height = 21
      TabOrder = 5
      OnChange = edtLenderContactChange
    end
    object edtLenderAddress: TEdit
      Left = 253
      Top = 64
      Width = 180
      Height = 21
      TabOrder = 6
      OnChange = edtLenderContactChange
    end
    object edtLenderCity: TEdit
      Left = 277
      Top = 88
      Width = 180
      Height = 21
      TabOrder = 9
      OnChange = edtLenderContactChange
    end
    object edtLenderState: TEdit
      Left = 261
      Top = 124
      Width = 57
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 2
      TabOrder = 7
      OnChange = edtLenderContactChange
    end
    object edtLenderZip: TEdit
      Left = 359
      Top = 124
      Width = 98
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 10
      TabOrder = 8
      OnChange = edtLenderContactChange
    end
    object edtLenderPhone: TEdit
      Left = 49
      Top = 196
      Width = 180
      Height = 21
      TabOrder = 10
      OnChange = edtLenderContactChange
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 289
    Width = 805
    Height = 293
    Align = alClient
    TabOrder = 1
    object Splitter5: TSplitter
      Left = 393
      Top = 1
      Width = 5
      Height = 272
    end
    object BingMaps2: TGAgisBingMap
      Left = 1
      Top = 1
      Width = 392
      Height = 272
      Cursor = gcHand
      Align = alLeft
      DragCursor = gcHand
      TabOrder = 0
      StatusBar = False
      ShowScrollBars = False
      Show3DBorder = False
      UseFile = False
      MapWidth = 370
      MapHeight = 270
      AutoSize = False
      CenterLatitude = 37.256278991700000000
      CenterLongitude = -121.782684326200000000
      ZoomLevel = 10
      ShowMarkers = True
      ShowLabels = False
      ShowPolylines = False
      ShowPolygons = False
      ShowCurves = False
      ShowCircles = False
      ShowArrows = True
      ShowDirections = False
      ShowLayers = False
      Version = '8.0.3'
      OnMapLoad = BingMaps2MapLoad
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
      ShowDashboard = True
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
      OnMarkerMove = BingMaps2MarkerMove
      OnMarkerMoved = BingMaps2MarkerMoved
      ControlData = {
        4C000000842800001D1C00000000000000000000000000000000000000000000
        000000004C000000000000000000000001000000E0D057007335CF11AE690800
        2B2E12620A000000000000004C0000000114020000000000C000000000000046
        8000000000000000000000000000000000000000000000000000000000000000
        00000000000000000100000000000000000000000000000000000000}
    end
    object sbStatus: TStatusBar
      Left = 1
      Top = 273
      Width = 803
      Height = 19
      Panels = <
        item
          Width = 150
        end
        item
          Width = 200
        end
        item
          Width = 200
        end
        item
          Width = 250
        end
        item
          Width = 50
        end>
    end
    object BingMaps: TGAgisBingMap
      Left = 398
      Top = 1
      Width = 406
      Height = 272
      Cursor = gcHand
      Align = alClient
      DragCursor = gcMove
      TabOrder = 2
      StatusBar = False
      ShowScrollBars = False
      Show3DBorder = False
      UseFile = False
      MapWidth = 370
      MapHeight = 270
      AutoSize = False
      CenterLatitude = 37.256278991700000000
      CenterLongitude = -121.782684326200000000
      ZoomLevel = 9
      ShowMarkers = True
      ShowLabels = False
      ShowPolylines = False
      ShowPolygons = False
      ShowCurves = False
      ShowCircles = False
      ShowArrows = True
      ShowDirections = False
      ShowLayers = False
      Version = '8.0.3'
      OnMapLoad = BingMapsMapLoad
      SecureLogin = False
      SecureTiles = False
      EnableDisplayThreshold = False
      UseInertia = False
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
      MapType = mtAerial
      MapMode = mm2D
      MapControlType = mcDefault
      ShowMapLabels = False
      ShowBaseTileLayer = True
      ShowDashboard = True
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
      OnMarkerMove = BingMapsMarkerMove
      OnMarkerMoved = BingMapsMarkerMoved
      ControlData = {
        4C000000F62900001D1C00000000000000000000000000000000000000000000
        000000004C000000000000000000000001000000E0D057007335CF11AE690800
        2B2E12620A000000000000004C0000000114020000000000C000000000000046
        8000000000000000000000000000000000000000000000000000000000000000
        00000000000000000100000000000000000000000000000000000000}
    end
  end
  object topPanel: TPanel
    Left = 0
    Top = 0
    Width = 805
    Height = 289
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object ScrollBox1: TScrollBox
      Left = 385
      Top = 0
      Width = 420
      Height = 289
      Align = alClient
      TabOrder = 0
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 201
        Height = 285
        Align = alLeft
        TabOrder = 0
        object StaticText26: TLabel
          Left = 1
          Top = 1
          Width = 199
          Height = 13
          Align = alTop
          Caption = 'Select A Template Report'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object StatusBar: TStatusBar
          Left = 1
          Top = 265
          Width = 199
          Height = 19
          Panels = <>
        end
        object FileTree: TTreeView
          Left = 1
          Top = 14
          Width = 199
          Height = 251
          Align = alClient
          Images = SelectTemplate.FileImages
          Indent = 19
          ShowLines = False
          SortType = stText
          TabOrder = 1
          OnClick = SelectThisFile
          OnDblClick = SelectThisFile
        end
      end
      object Panel2: TPanel
        Left = 201
        Top = 0
        Width = 215
        Height = 285
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object Label10: TLabel
          Left = 19
          Top = 28
          Width = 56
          Height = 13
          Caption = 'Eff. Date:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object StaticText24: TLabel
          Left = 32
          Top = 54
          Width = 39
          Height = 13
          Caption = 'File No.:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object StaticText17: TLabel
          Left = 24
          Top = 81
          Width = 47
          Height = 13
          Caption = 'Case No.:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object edtEffDate: TRzDateTimeEdit
          Left = 82
          Top = 22
          Width = 120
          Height = 21
          EditType = etDate
          Format = 'mm/dd/yyyy'
          TabOrder = 0
        end
        object edtFileNo: TRzEdit
          Left = 82
          Top = 49
          Width = 120
          Height = 21
          TabOrder = 1
        end
        object ckIncludeFloodMap: TCheckBox
          Left = 25
          Top = 115
          Width = 115
          Height = 17
          Caption = 'Include Flood Map'
          Checked = True
          State = cbChecked
          TabOrder = 3
          OnClick = ckIncludeFloodMapClick
        end
        object ckIncludeBuildFax: TCheckBox
          Left = 25
          Top = 139
          Width = 161
          Height = 17
          Caption = 'Include BuildFax'
          Checked = True
          State = cbChecked
          TabOrder = 4
          OnClick = ckIncludeBuildFaxClick
        end
        object btnCancel: TButton
          Left = 10
          Top = 230
          Width = 55
          Height = 25
          Caption = '&Cancel'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ModalResult = 2
          ParentFont = False
          TabOrder = 5
        end
        object btnStart: TButton
          Left = 80
          Top = 230
          Width = 105
          Height = 25
          Caption = '&Start Appraisal'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 6
          OnClick = btnStartClick
        end
        object edtCaseNo: TRzEdit
          Left = 82
          Top = 76
          Width = 120
          Height = 21
          TabOrder = 2
        end
        object ckIncludeAerialView: TCheckBox
          Left = 25
          Top = 163
          Width = 168
          Height = 17
          Caption = 'Transfer Aerial View to Report'
          Checked = True
          State = cbChecked
          TabOrder = 7
          Visible = False
          OnClick = ckIncludeAerialViewClick
        end
      end
    end
    object AddrPanel: TPanel
      Left = 0
      Top = 0
      Width = 385
      Height = 289
      Align = alLeft
      TabOrder = 1
      object Label1: TLabel
        Left = 277
        Top = 33
        Width = 32
        Height = 13
        Caption = 'Unit #:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label12: TLabel
        Left = 276
        Top = 162
        Width = 32
        Height = 13
        Caption = 'Unit #:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object StaticText1: TLabel
        Left = 7
        Top = 7
        Width = 97
        Height = 13
        Caption = 'Property Address'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object StaticText2: TLabel
        Left = 7
        Top = 31
        Width = 41
        Height = 13
        Caption = 'Address:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object StaticText3: TLabel
        Left = 28
        Top = 55
        Width = 20
        Height = 13
        Caption = 'City:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object StaticText4: TLabel
        Left = 20
        Top = 79
        Width = 28
        Height = 13
        Caption = 'State:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object StaticText5: TLabel
        Left = 30
        Top = 103
        Width = 18
        Height = 13
        Caption = 'Zip:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object StaticText10: TLabel
        Left = 7
        Top = 161
        Width = 41
        Height = 13
        Caption = 'Address:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object StaticText11: TLabel
        Left = 28
        Top = 185
        Width = 20
        Height = 13
        Caption = 'City:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object StaticText12: TLabel
        Left = 20
        Top = 209
        Width = 28
        Height = 13
        Caption = 'State:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object StaticText13: TLabel
        Left = 30
        Top = 233
        Width = 18
        Height = 13
        Caption = 'Zip:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object StaticText14: TLabel
        Left = 226
        Top = 107
        Width = 48
        Height = 13
        Caption = 'Accuracy:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object StaticText15: TLabel
        Left = 178
        Top = 233
        Width = 50
        Height = 13
        Caption = 'Longitude:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object StaticText16: TLabel
        Left = 187
        Top = 209
        Width = 41
        Height = 13
        Caption = 'Latitude:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object edtOrigAddress: TEdit
        Left = 55
        Top = 28
        Width = 180
        Height = 21
        TabOrder = 0
        OnExit = CheckForFullAddress
      end
      object edtOrigUnitNo: TEdit
        Left = 320
        Top = 29
        Width = 49
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 1
        OnExit = CheckForFullAddress
      end
      object edtOrigCity: TEdit
        Left = 55
        Top = 52
        Width = 180
        Height = 21
        TabOrder = 2
        OnExit = CheckForFullAddress
      end
      object edtOrigState: TEdit
        Left = 55
        Top = 76
        Width = 55
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 2
        TabOrder = 3
        OnExit = CheckForFullAddress
      end
      object edtOrigZip: TEdit
        Left = 55
        Top = 100
        Width = 105
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 10
        TabOrder = 4
        OnExit = CheckForFullAddress
      end
      object edtVerfAddress: TEdit
        Left = 55
        Top = 158
        Width = 180
        Height = 21
        TabOrder = 8
      end
      object edtVerfCity: TEdit
        Left = 55
        Top = 182
        Width = 180
        Height = 21
        TabOrder = 10
      end
      object edtVerfState: TEdit
        Left = 55
        Top = 206
        Width = 55
        Height = 21
        TabOrder = 11
      end
      object edtVerfZip: TEdit
        Left = 55
        Top = 230
        Width = 106
        Height = 21
        TabOrder = 12
      end
      object btnVerifyAddress: TButton
        Left = 209
        Top = 76
        Width = 157
        Height = 25
        Caption = 'Locate and Verify Address'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 6
        OnClick = btnVerifyAddressClick
      end
      object edtAccuracy: TEdit
        Left = 287
        Top = 104
        Width = 81
        Height = 21
        TabOrder = 7
      end
      object edtLon: TEdit
        Left = 234
        Top = 230
        Width = 137
        Height = 21
        ReadOnly = True
        TabOrder = 15
      end
      object edtLat: TEdit
        Left = 234
        Top = 206
        Width = 137
        Height = 21
        ReadOnly = True
        TabOrder = 14
      end
      object edtVerfUnitNo: TEdit
        Left = 321
        Top = 158
        Width = 49
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 9
      end
      object btnBirdsEyeView: TButton
        Left = 55
        Top = 254
        Width = 157
        Height = 25
        Caption = 'Show Birds Eye View'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 13
        OnClick = btnBirdsEyeViewClick
      end
      object btnCheckPostal: TButton
        Left = 200
        Top = 129
        Width = 31
        Height = 25
        Caption = 'Check USPS'
        TabOrder = 16
        Visible = False
        OnClick = btnCheckPostalClick
      end
      object Button1: TButton
        Left = 160
        Top = 129
        Width = 33
        Height = 25
        Caption = 'Test'
        TabOrder = 17
        Visible = False
        OnClick = Button1Click
      end
      object cbxVerified: TCheckBox
        Left = 9
        Top = 135
        Width = 115
        Height = 17
        Caption = 'Address Verified'
        Checked = True
        State = cbChecked
        TabOrder = 5
        OnClick = cbxVerifiedClick
      end
    end
  end
  object BingGeoCoder: TGAgisBingGeo
    UseCache = False
    UseClientGeocoder = False
    Left = 85
    Top = 376
  end
  object GeoCodeAddressTimer: TTimer
    Enabled = False
    Interval = 2000
    OnTimer = GeoCodeAddressTimerTimer
    Left = 64
    Top = 312
  end
  object XMLDocument1: TXMLDocument
    Left = 308
    Top = 252
    DOMVendorDesc = 'MSXML'
  end
end
