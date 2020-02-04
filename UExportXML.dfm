object ExportXML: TExportXML
  Left = 827
  Top = 210
  Width = 423
  Height = 389
  Caption = 'Export XML Report'
  Color = clBtnFace
  Constraints.MaxWidth = 423
  Constraints.MinWidth = 423
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 407
    Height = 81
    Align = alTop
    BevelOuter = bvNone
    Constraints.MaxWidth = 423
    TabOrder = 0
    object btnCancel: TButton
      Left = 240
      Top = 24
      Width = 137
      Height = 25
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
      OnClick = btnCancelClick
    end
    object btnExport: TButton
      Left = 42
      Top = 24
      Width = 127
      Height = 25
      Caption = 'Export XML'
      Default = True
      ModalResult = 1
      TabOrder = 0
      OnClick = btnExportClick
    end
  end
  object PrListGrid: TtsGrid
    Left = 0
    Top = 81
    Width = 407
    Height = 250
    Align = alClient
    AlwaysShowFocus = True
    AlwaysShowScrollBar = ssVertical
    CheckBoxStyle = stCheck
    Cols = 2
    DefaultRowHeight = 18
    ExportDelimiter = ','
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    HeadingHorzAlignment = htaCenter
    HeadingFont.Charset = DEFAULT_CHARSET
    HeadingFont.Color = clWindowText
    HeadingFont.Height = -11
    HeadingFont.Name = 'MS Sans Serif'
    HeadingFont.Style = []
    HeadingHeight = 18
    HeadingVertAlignment = vtaCenter
    ParentFont = False
    ParentShowHint = False
    RowBarIndicator = False
    RowBarOn = False
    Rows = 1
    ScrollBars = ssVertical
    ShowHint = True
    StoreData = True
    TabOrder = 1
    ThumbTracking = True
    Version = '3.01.08'
    WordWrap = wwOff
    XMLExport.Version = '1.0'
    XMLExport.DataPacketVersion = '2.0'
    OnClickCell = PrListGridClickCell
    ColProperties = <
      item
        DataCol = 1
        Col.ControlType = ctCheck
        Col.Heading = 'Include'
        Col.HeadingHorzAlignment = htaCenter
        Col.HeadingVertAlignment = vtaCenter
        Col.Width = 50
      end
      item
        DataCol = 2
        Col.Heading = 'Page Title'
        Col.ReadOnly = True
        Col.Width = 345
      end>
    Data = {0100000002000000010000000001000000000000000000000000}
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 331
    Width = 407
    Height = 22
    Panels = <>
  end
end
