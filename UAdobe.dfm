object CreatePDF: TCreatePDF
  Left = 388
  Top = 214
  Width = 423
  Height = 287
  Caption = 'Create Adobe PDF File'
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
    Width = 415
    Height = 81
    Align = alTop
    BevelOuter = bvNone
    Constraints.MaxWidth = 423
    TabOrder = 0
    object btnSetup: TButton
      Left = 9
      Top = 12
      Width = 74
      Height = 25
      Caption = 'Setup'
      TabOrder = 2
      OnClick = btnSetupClick
    end
    object btnCancel: TButton
      Left = 330
      Top = 48
      Width = 73
      Height = 25
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
    object btnPrint: TButton
      Left = 330
      Top = 12
      Width = 73
      Height = 25
      Caption = 'Create PDF'
      Default = True
      ModalResult = 1
      TabOrder = 0
      OnClick = btnPrintClick
    end
    object cmbxDrivers: TComboBox
      Left = 96
      Top = 14
      Width = 220
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
    Width = 415
    Height = 150
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
    Version = '2.20.26'
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
    Top = 231
    Width = 415
    Height = 22
    Panels = <>
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 16
    Top = 48
  end
  object PrintDialog1: TPrintDialog
    Left = 48
    Top = 48
  end
end
