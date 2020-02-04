object TwoPrint: TTwoPrint
  Left = 533
  Top = 172
  Width = 530
  Height = 478
  Caption = 'Print'
  Color = clBtnFace
  Constraints.MinHeight = 200
  Constraints.MinWidth = 503
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 421
    Width = 514
    Height = 19
    Panels = <>
    SimplePanel = True
    SimpleText = '   Press SHIFT to select or deselect multiple pages'
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 514
    Height = 145
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object btnClose: TButton
      Left = 400
      Top = 112
      Width = 73
      Height = 25
      Cancel = True
      Caption = 'Close'
      ModalResult = 2
      TabOrder = 0
    end
    object ChkBxAutoClose: TCheckBox
      Left = 16
      Top = 116
      Width = 193
      Height = 17
      BiDiMode = bdLeftToRight
      Caption = 'Auto close this dialog after printing'
      ParentBiDiMode = False
      TabOrder = 1
    end
    object GroupBox1: TGroupBox
      Left = 16
      Top = 16
      Width = 465
      Height = 41
      Caption = 'Printer 1'
      TabOrder = 2
      object Label1: TLabel
        Tag = 1
        Left = 16
        Top = 16
        Width = 259
        Height = 13
        Alignment = taCenter
        Caption = 'Printer 1 has not been specified. Use Setup to select it.'
      end
      object btnP1Setup: TButton
        Tag = 1
        Left = 296
        Top = 10
        Width = 73
        Height = 25
        Caption = 'Setup'
        TabOrder = 0
        OnClick = PrinterSetupClick
      end
      object btnPrintTo1: TButton
        Tag = 1
        Left = 384
        Top = 10
        Width = 73
        Height = 25
        Caption = 'Print '
        Default = True
        TabOrder = 1
        OnClick = DoPrintClick
      end
    end
    object GroupBox2: TGroupBox
      Left = 16
      Top = 60
      Width = 465
      Height = 41
      Caption = 'Printer2'
      TabOrder = 3
      object Label2: TLabel
        Tag = 2
        Left = 16
        Top = 16
        Width = 259
        Height = 13
        Alignment = taCenter
        Caption = 'Printer 2 has not been specified. Use Setup to select it.'
      end
      object btnP2Setup: TButton
        Tag = 2
        Left = 296
        Top = 10
        Width = 73
        Height = 25
        Caption = 'Setup'
        TabOrder = 0
        OnClick = PrinterSetupClick
      end
      object btnPrintTo2: TButton
        Tag = 2
        Left = 384
        Top = 10
        Width = 73
        Height = 25
        Caption = 'Print'
        TabOrder = 1
        OnClick = DoPrintClick
      end
    end
  end
  object PrListGrid: TtsGrid
    Tag = 4
    Left = 0
    Top = 145
    Width = 514
    Height = 276
    Cursor = crArrow
    Hint = 'Press SHIFT to select all pages'
    Align = alClient
    AlwaysShowFocus = True
    AlwaysShowScrollBar = ssVertical
    CellSelectMode = cmNone
    CheckBoxStyle = stCheck
    ColMoving = False
    Cols = 4
    ColSelectMode = csNone
    DefaultRowHeight = 18
    ExportDelimiter = ','
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    HeadingFont.Charset = DEFAULT_CHARSET
    HeadingFont.Color = clWindowText
    HeadingFont.Height = -11
    HeadingFont.Name = 'MS Sans Serif'
    HeadingFont.Style = []
    HeadingHeight = 18
    MaskDefs = tsMaskDefs1
    ParentFont = False
    ParentShowHint = False
    ResizeCols = rcNone
    ResizeRows = rrNone
    RowBarIndicator = False
    RowBarOn = False
    Rows = 1
    RowSelectMode = rsNone
    ScrollBars = ssVertical
    ShowHint = True
    StoreData = True
    TabOrder = 2
    ThumbTracking = True
    Version = '3.01.08'
    WordWrap = wwOff
    XMLExport.Version = '1.0'
    XMLExport.DataPacketVersion = '2.0'
    OnClickCell = PrListGridClickCell
    OnComboDropDown = PrListGridComboDropDown
    OnComboGetValue = PrListGridComboGetValue
    OnComboInit = PrListGridComboInit
    OnStartCellEdit = PrListGridStartCellEdit
    ColProperties = <
      item
        DataCol = 1
        Col.Heading = 'Page Name'
        Col.HeadingHorzAlignment = htaCenter
        Col.HeadingVertAlignment = vtaCenter
        Col.ReadOnly = True
        Col.Width = 230
      end
      item
        DataCol = 2
        Col.ControlType = ctCheck
        Col.Heading = 'Print'
        Col.HeadingHorzAlignment = htaCenter
        Col.HeadingVertAlignment = vtaCenter
        Col.Width = 50
      end
      item
        DataCol = 3
        Col.ControlType = ctText
        Col.Heading = 'Copies'
        Col.HeadingHorzAlignment = htaCenter
        Col.HeadingVertAlignment = vtaCenter
        Col.MaskName = 'NumMask'
        Col.HorzAlignment = htaCenter
        Col.Width = 50
      end
      item
        DataCol = 4
        Col.ButtonType = btCombo
        Col.ControlType = ctText
        Col.Heading = 'Printer'
        Col.HeadingHorzAlignment = htaCenter
        Col.HeadingVertAlignment = vtaCenter
        Col.Width = 144
      end>
    Data = {
      0100000004000000010000000002020000000100000000010000000000000000
      00000000}
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 100
    Top = 240
  end
  object tsMaskDefs1: TtsMaskDefs
    Masks = <
      item
        Name = 'NumMask'
        Picture = '#[#]'
      end>
    Left = 200
    Top = 240
  end
  object PrintDialog1: TPrintDialog
    Left = 152
    Top = 240
  end
end
