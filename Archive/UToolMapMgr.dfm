object MapDataMgr: TMapDataMgr
  Left = 523
  Top = 187
  Width = 953
  Height = 663
  Anchors = [akLeft, akTop, akRight, akBottom]
  Caption = 'Address Locator'
  Color = clBtnFace
  Constraints.MinHeight = 510
  Constraints.MinWidth = 534
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TStatusBar
    Left = 0
    Top = 613
    Width = 945
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 945
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object cmbxLocTypes: TComboBox
      Left = 8
      Top = 8
      Width = 193
      Height = 21
      AutoComplete = False
      ItemHeight = 13
      TabOrder = 2
      OnChange = cmbxLocTypesChange
      Items.Strings = (
        'Locate Subject & Comparables'
        'Locate Subject & Rentals'
        'Locate Subject & Listings'
        'Locate Subject Only'
        'Locate All Addresses')
    end
    object AnimateProgress: TAnimate
      Left = 239
      Top = 0
      Width = 44
      Height = 40
      StopFrame = 8
    end
    object pnlButtons: TPanel
      Left = 684
      Top = 0
      Width = 261
      Height = 41
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object btnCancel: TButton
        Left = 159
        Top = 12
        Width = 75
        Height = 25
        Cancel = True
        Caption = 'Cancel'
        ModalResult = 2
        TabOrder = 0
      end
      object btnOk: TButton
        Left = 15
        Top = 12
        Width = 75
        Height = 25
        Caption = 'Locate'
        TabOrder = 1
        OnClick = btnOkClick
      end
    end
  end
  object PageControl: TPageControl
    Left = 0
    Top = 41
    Width = 945
    Height = 572
    ActivePage = AddressSheet
    Align = alClient
    TabOrder = 2
    TabWidth = 75
    object AddressSheet: TTabSheet
      Caption = 'Addresses'
      object AddressGrid: TtsGrid
        Left = 0
        Top = 0
        Width = 937
        Height = 544
        Align = alClient
        CheckBoxStyle = stCheck
        ColMoving = False
        Cols = 11
        ColSelectMode = csNone
        DefaultRowHeight = 16
        ExportDelimiter = ','
        HeadingHorzAlignment = htaCenter
        HeadingFont.Charset = DEFAULT_CHARSET
        HeadingFont.Color = clWindowText
        HeadingFont.Height = -11
        HeadingFont.Name = 'MS Sans Serif'
        HeadingFont.Style = []
        HeadingParentFont = False
        HeadingVertAlignment = vtaCenter
        ParentShowHint = False
        RowBarOn = False
        Rows = 1
        ShowHint = True
        StoreData = True
        TabOrder = 0
        ThumbTracking = True
        Version = '3.01.08'
        XMLExport.Version = '1.0'
        XMLExport.DataPacketVersion = '2.0'
        ColProperties = <
          item
            DataCol = 1
            Col.DropDownStyle = ddDropDownList
            Col.Heading = 'Label'
            Col.HeadingHorzAlignment = htaCenter
            Col.Width = 80
          end
          item
            DataCol = 2
            Col.Heading = 'Street No'
          end
          item
            DataCol = 3
            Col.Heading = 'Street Name'
            Col.Width = 141
          end
          item
            DataCol = 4
            Col.Heading = 'City'
            Col.Width = 109
          end
          item
            DataCol = 5
            Col.Heading = 'State'
            Col.Width = 40
          end
          item
            DataCol = 6
            Col.Heading = 'Zip Code'
          end
          item
            DataCol = 7
            Col.Heading = 'Prox. To Subject'
            Col.HeadingHorzAlignment = htaCenter
            Col.HeadingVertAlignment = vtaCenter
            Col.Width = 110
          end
          item
            DataCol = 8
            Col.Heading = 'Longitude'
            Col.Width = 75
          end
          item
            DataCol = 9
            Col.Heading = 'Latitude'
          end
          item
            DataCol = 10
            Col.Heading = 'ColType'
          end
          item
            DataCol = 11
            Col.Heading = 'ColNum'
          end>
        Data = {
          010000000B000000010000000000000001000000000001000000000100000000
          000001000000000000000000000000}
      end
    end
    object SetupSheet: TTabSheet
      Caption = 'Setup'
      ImageIndex = 1
      object Label1: TLabel
        Left = 16
        Top = 8
        Width = 90
        Height = 15
        AutoSize = False
        Caption = 'Display Columns'
      end
      object ckbxColSetup: TCheckListBox
        Left = 16
        Top = 32
        Width = 113
        Height = 140
        Hint = 'Check to display column'
        OnClickCheck = ckbxColSetupClickCheck
        ItemHeight = 13
        Items.Strings = (
          'Label'
          'Street No'
          'Street Name'
          'City'
          'State'
          'Zip Code'
          'Prox. To Subject'
          'Longitude'
          'Latitude')
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object MapSize: TRadioGroup
        Left = 160
        Top = 10
        Width = 113
        Height = 105
        Caption = 'Map Size'
        ItemIndex = 0
        Items.Strings = (
          'Legal Size'
          'Letter Size')
        TabOrder = 1
      end
      object MapColor: TRadioGroup
        Left = 160
        Top = 122
        Width = 281
        Height = 48
        Caption = 'Map Color'
        Columns = 2
        ItemIndex = 1
        Items.Strings = (
          'Color'
          'Black and White')
        TabOrder = 2
        Visible = False
      end
      object mapRes: TRadioGroup
        Left = 304
        Top = 10
        Width = 137
        Height = 105
        Caption = 'Resolution'
        ItemIndex = 1
        Items.Strings = (
          'High'
          'Med (Recommended)'
          'Low')
        TabOrder = 3
      end
    end
    object ResultsSheet: TTabSheet
      Caption = 'Results'
      ImageIndex = 2
      DesignSize = (
        937
        544)
      object PBox: TPaintBox
        Left = 16
        Top = 128
        Width = 33
        Height = 153
        OnPaint = ZoomIndicatorPaint
      end
      object sbSW: TSpeedButton
        Left = 8
        Top = 64
        Width = 23
        Height = 22
        Hint = 'Southwest'
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          33333333333333333333333333333333333333FF333333333333300333333333
          33333773FF33333333333090033333333333373773FF33333333330990033333
          3333337F3773FF33333333099990033333333373F33773FFF333333099999007
          33333337F33337773333333099999903333333373F3333733333333309999033
          333333337F3337F333333333099990733333333373F3F77F3333333330900907
          3333333337F77F77F33333333003709073333333377377F77F33333337333709
          073333333733377F77F33333333333709033333333333377F7F3333333333337
          0733333333333337773333333333333333333333333333333333}
        NumGlyphs = 2
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        OnClick = sbSWClick
      end
      object sbS: TSpeedButton
        Left = 32
        Top = 64
        Width = 23
        Height = 22
        Hint = 'South'
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333303333
          333333333337F33333333333333033333333333333373F333333333333090333
          33333333337F7F33333333333309033333333333337373F33333333330999033
          3333333337F337F33333333330999033333333333733373F3333333309999903
          333333337F33337F33333333099999033333333373333373F333333099999990
          33333337FFFF3FF7F33333300009000033333337777F77773333333333090333
          33333333337F7F33333333333309033333333333337F7F333333333333090333
          33333333337F7F33333333333309033333333333337F7F333333333333090333
          33333333337F7F33333333333300033333333333337773333333}
        NumGlyphs = 2
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        OnClick = sbSClick
      end
      object sbSE: TSpeedButton
        Left = 56
        Top = 64
        Width = 23
        Height = 22
        Hint = 'Southeast'
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          333333333333333333333333333333333333333333333333FFF3333333333333
          00333333333333FF77F3333333333300903333333333FF773733333333330099
          0333333333FF77337F3333333300999903333333FF7733337333333700999990
          3333333777333337F3333333099999903333333373F333373333333330999903
          33333333F7F3337F33333333709999033333333F773FF3733333333709009033
          333333F7737737F3333333709073003333333F77377377F33333370907333733
          33333773773337333333309073333333333337F7733333333333370733333333
          3333377733333333333333333333333333333333333333333333}
        NumGlyphs = 2
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        OnClick = sbSEClick
      end
      object sbE: TSpeedButton
        Left = 56
        Top = 40
        Width = 23
        Height = 22
        Hint = 'East'
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333333333333333333333333333333333333333333333
          3333333333333333333333333333333333333333333FF3333333333333003333
          3333333333773FF3333333333309003333333333337F773FF333333333099900
          33333FFFFF7F33773FF30000000999990033777777733333773F099999999999
          99007FFFFFFF33333F7700000009999900337777777F333F7733333333099900
          33333333337F3F77333333333309003333333333337F77333333333333003333
          3333333333773333333333333333333333333333333333333333333333333333
          3333333333333333333333333333333333333333333333333333}
        NumGlyphs = 2
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        OnClick = sbEClick
      end
      object sbNE: TSpeedButton
        Left = 56
        Top = 16
        Width = 23
        Height = 22
        Hint = 'Northeast'
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          33333333333333333333333333333333333333FF333333333333370733333333
          33333777F33333333333309073333333333337F77F3333F33333370907333733
          3333377F77F337F3333333709073003333333377F77F77F33333333709009033
          333333377F77373F33333333709999033333333377F3337F3333333330999903
          3333333337333373F333333309999990333333337FF33337F333333700999990
          33333337773FF3373F333333330099990333333333773FF37F33333333330099
          033333333333773F73F3333333333300903333333333337737F3333333333333
          0033333333333333773333333333333333333333333333333333}
        NumGlyphs = 2
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        OnClick = sbNEClick
      end
      object sbN: TSpeedButton
        Left = 32
        Top = 16
        Width = 23
        Height = 22
        Hint = 'North'
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000333
          3333333333777F33333333333309033333333333337F7F333333333333090333
          33333333337F7F33333333333309033333333333337F7F333333333333090333
          33333333337F7F33333333333309033333333333FF7F7FFFF333333000090000
          3333333777737777F333333099999990333333373F3333373333333309999903
          333333337F33337F33333333099999033333333373F333733333333330999033
          3333333337F337F3333333333099903333333333373F37333333333333090333
          33333333337F7F33333333333309033333333333337373333333333333303333
          333333333337F333333333333330333333333333333733333333}
        NumGlyphs = 2
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        OnClick = sbNClick
      end
      object sbHand: TSpeedButton
        Left = 32
        Top = 40
        Width = 23
        Height = 22
        GroupIndex = 1
        Enabled = False
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00666666000000
          6666666660FFFFFF0666666660FFFFFF066666660FFFFFFF06666660FFFFFFFF
          F066660FFFFFFFFFF066660FFFFFFFFFFF0660FFFFFFFFFFFF060FFF0FFFFFFF
          FF060FF06F0FF0FF0FF060060F0FF0FF0FF06660FF0FF0FF0FF06660FF0FF0FF
          00F06660FF0FF0FF06066666000FF0FF06666666660006006666}
        OnClick = sbHandClick
      end
      object sbW: TSpeedButton
        Left = 8
        Top = 40
        Width = 23
        Height = 22
        Hint = 'West'
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333333333333333333333333333333333333333333333
          3333333333333FF3333333333333003333333333333F77F33333333333009033
          333333333F7737F333333333009990333333333F773337FFFFFF330099999000
          00003F773333377777770099999999999990773FF33333FFFFF7330099999000
          000033773FF33777777733330099903333333333773FF7F33333333333009033
          33333333337737F3333333333333003333333333333377333333333333333333
          3333333333333333333333333333333333333333333333333333333333333333
          3333333333333333333333333333333333333333333333333333}
        NumGlyphs = 2
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        OnClick = sbWClick
      end
      object sbNW: TSpeedButton
        Left = 8
        Top = 16
        Width = 23
        Height = 22
        Hint = 'Northwest'
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          333333333333333FFF3333333333333707333333333333F777F3333333333370
          9033333333F33F7737F33333373337090733333337F3F7737733333330037090
          73333333377F7737733333333090090733333333373773773333333309999073
          333333337F333773333333330999903333333333733337F33333333099999903
          33333337F3333F7FF33333309999900733333337333FF7773333330999900333
          3333337F3FF7733333333309900333333333337FF77333333333309003333333
          333337F773333333333330033333333333333773333333333333333333333333
          3333333333333333333333333333333333333333333333333333}
        NumGlyphs = 2
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        OnClick = sbNWClick
      end
      object AddressButton: TSpeedButton
        Left = 664
        Top = 256
        Width = 49
        Height = 41
        Visible = False
      end
      object PointerButton: TSpeedButton
        Left = 720
        Top = 256
        Width = 49
        Height = 41
        Visible = False
      end
      object chkbxPutInClipBrd: TCheckBox
        Left = 659
        Top = 16
        Width = 240
        Height = 19
        Caption = 'Only Transfer Map to  Windows Clipboard'
        TabOrder = 0
      end
      object ResultsGrid: TtsGrid
        Left = 642
        Top = 48
        Width = 287
        Height = 153
        CheckBoxStyle = stCheck
        Cols = 3
        Constraints.MinHeight = 120
        Constraints.MinWidth = 270
        DefaultRowHeight = 16
        ExportDelimiter = ','
        HeadingHorzAlignment = htaCenter
        HeadingFont.Charset = DEFAULT_CHARSET
        HeadingFont.Color = clWindowText
        HeadingFont.Height = -11
        HeadingFont.Name = 'MS Sans Serif'
        HeadingFont.Style = []
        HeadingParentFont = False
        HeadingVertAlignment = vtaCenter
        ParentShowHint = False
        ProvideGridMenu = True
        RowBarOn = False
        Rows = 1
        ShowHint = True
        StoreData = True
        TabOrder = 1
        Version = '3.01.08'
        XMLExport.Version = '1.0'
        XMLExport.DataPacketVersion = '2.0'
        ColProperties = <
          item
            DataCol = 1
            Col.Heading = 'Label'
            Col.HeadingVertAlignment = vtaTop
            Col.Width = 93
          end
          item
            DataCol = 2
            Col.Heading = 'Prox. To Subject'
            Col.Width = 110
          end
          item
            DataCol = 3
            Col.Heading = 'Accuracy'
            Col.HorzAlignment = htaCenter
            Col.Width = 78
          end>
        Data = {01000000030000000100000000010000000001000000000000000000000000}
      end
      object btnZoomIn: TButton
        Left = 4
        Top = 300
        Width = 80
        Height = 25
        BiDiMode = bdLeftToRight
        Caption = 'Zoom In'
        Constraints.MaxHeight = 25
        Constraints.MaxWidth = 80
        Constraints.MinHeight = 25
        Constraints.MinWidth = 80
        Enabled = False
        ParentBiDiMode = False
        TabOrder = 2
        OnClick = btnZoomInOnClick
      end
      object btnZoomOut: TButton
        Left = 4
        Top = 342
        Width = 80
        Height = 25
        Caption = 'Zoom Out'
        Constraints.MaxHeight = 25
        Constraints.MaxWidth = 80
        Constraints.MinHeight = 25
        Constraints.MinWidth = 80
        Enabled = False
        TabOrder = 3
        OnClick = btnZoomOutOnClick
      end
      object ZoomBar: TRzTrackBar
        Left = 54
        Top = 96
        Width = 25
        Height = 185
        HighlightColor = clRed
        Max = 150
        Min = 50
        Orientation = orVertical
        PageSize = 10
        Position = 100
        TickColor = clBlue
        TickStep = 10
        TrackColor = clYellow
        TrackOffset = 15
        OnChanging = ZoomBarChange
        Color = clBtnFace
        Enabled = False
        ParentColor = False
        TabOrder = 4
        OnMouseUp = ZoomBarMouseUp
      end
      object edtZoomValue: TEdit
        Left = 16
        Top = 100
        Width = 33
        Height = 21
        Hint = 'Enter ZOOM value'
        AutoSelect = False
        Enabled = False
        MaxLength = 3
        TabOrder = 5
        Text = '100'
        OnKeyUp = edtMouseUp
      end
      object ScrollBox: TScrollBox
        Left = 104
        Top = 16
        Width = 537
        Height = 800
        HorzScrollBar.Range = 600
        HorzScrollBar.Tracking = True
        VertScrollBar.Range = 818
        VertScrollBar.Tracking = True
        VertScrollBar.Visible = False
        Anchors = [akLeft, akTop, akBottom]
        AutoScroll = False
        Enabled = False
        Color = clCaptionText
        ParentColor = False
        TabOrder = 6
        object MapImage: TPMultiImage
          Left = 0
          Top = -5
          Width = 532
          Height = 816
          GrabHandCursor = 5
          Scrolling = True
          ShowScrollbars = False
          B_W_CopyFlags = [C_DEL]
          Color = clBtnFace
          Picture.Data = {07544269746D617000000000}
          ImageReadRes = lAutoMatic
          BlitMode = sLight
          ImageWriteRes = sAutoMatic
          TifSaveCompress = sNONE
          TiffPage = 0
          TiffAppend = False
          JPegSaveQuality = 25
          JPegSaveSmooth = 5
          OnMouseDown = MapMouseDown
          OnMouseMove = MapMouseMove
          OnMouseUp = MapMouseUp
          RubberBandBtn = mbLeft
          ScrollbarWidth = 12
          ParentColor = True
          TextLeft = 0
          TextTop = 0
          TextRotate = 0
          TabOrder = 0
          ZoomBy = 10
          RawInterpolateRGBAsFourColors = False
          RawBrightness = 1.000000000000000000
          RawCamera_white_balance = False
          RawRedScaling = 1.000000000000000000
          RawBlueScaling = 1.000000000000000000
          RawUpsideDown = False
          RawGammaValue = 0.500000000000000000
        end
      end
      object btnRevert: TButton
        Left = 4
        Top = 384
        Width = 80
        Height = 25
        Caption = 'Revert'
        Enabled = False
        TabOrder = 7
        OnClick = btnRevertClick
      end
    end
  end
end
