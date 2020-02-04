object SendFax: TSendFax
  Left = 344
  Top = 179
  Width = 550
  Height = 364
  Caption = 'Send Fax'
  Color = clBtnFace
  Constraints.MinHeight = 364
  Constraints.MinWidth = 550
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 538
    Height = 81
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object btnSetup: TButton
      Left = 9
      Top = 12
      Width = 72
      Height = 25
      Caption = 'Setup'
      TabOrder = 2
      OnClick = btnSetupClick
    end
    object btnCancel: TButton
      Left = 349
      Top = 48
      Width = 73
      Height = 25
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
    object btnFax: TButton
      Left = 349
      Top = 12
      Width = 73
      Height = 25
      Caption = 'FAX'
      Default = True
      ModalResult = 1
      TabOrder = 0
      OnClick = btnFaxClick
    end
    object cmbxDrivers: TComboBox
      Left = 96
      Top = 14
      Width = 217
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 3
      OnChange = cmbxDriversChange
    end
  end
  object PrListGrid: TtsGrid
    Left = 0
    Top = 81
    Width = 538
    Height = 225
    Align = alClient
    AlwaysShowFocus = True
    AlwaysShowScrollBar = ssVertical
    CheckBoxStyle = stCheck
    Cols = 2
    DefaultRowHeight = 21
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
    HeadingHeight = 20
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
    Top = 306
    Width = 538
    Height = 22
    Panels = <>
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 16
    Top = 48
  end
  object PrintDialog1: TPrintDialog
    Left = 56
    Top = 48
  end
end
