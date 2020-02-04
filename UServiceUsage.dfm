object ServiceUsage: TServiceUsage
  Left = 640
  Top = 195
  Width = 473
  Height = 446
  HorzScrollBar.Visible = False
  BorderIcons = [biSystemMenu]
  Caption = 'Service Summary'
  Color = clBtnFace
  Constraints.MinHeight = 200
  Constraints.MinWidth = 396
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object tsUsageSummary: TtsGrid
    Left = 0
    Top = 57
    Width = 457
    Height = 350
    Align = alClient
    AlwaysShowEditor = False
    CheckBoxStyle = stCheck
    ColMoving = False
    Cols = 3
    ColSelectMode = csNone
    DefaultRowHeight = 18
    ExportDelimiter = ','
    GridMode = gmBrowse
    HeadingFont.Charset = DEFAULT_CHARSET
    HeadingFont.Color = clWindowText
    HeadingFont.Height = -11
    HeadingFont.Name = 'MS Sans Serif'
    HeadingFont.Style = []
    HeadingHeight = 20
    HeadingVertAlignment = vtaCenter
    ParentShowHint = False
    PrintTotals = False
    RowBarOn = False
    Rows = 5
    RowSelectMode = rsNone
    ScrollBars = ssVertical
    ShowHint = False
    StoreData = True
    TabOrder = 0
    Version = '3.01.08'
    XMLExport.Version = '1.0'
    XMLExport.DataPacketVersion = '2.0'
    ColProperties = <
      item
        DataCol = 1
        Col.Heading = 'Service'
        Col.HeadingHorzAlignment = htaCenter
        Col.HorzAlignment = htaLeft
        Col.Width = 200
      end
      item
        DataCol = 2
        Col.Heading = 'Units Remaining'
        Col.HeadingHorzAlignment = htaCenter
        Col.HorzAlignment = htaCenter
        Col.Width = 100
      end
      item
        DataCol = 3
        Col.Heading = 'Expiration Date'
        Col.HeadingHorzAlignment = htaCenter
        Col.Width = 95
      end>
    Data = {010000000100000001000000000000000000000000}
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 457
    Height = 57
    Align = alTop
    TabOrder = 1
    object lblMaintenance: TLabel
      Left = 6
      Top = 13
      Width = 129
      Height = 13
      Alignment = taRightJustify
      Caption = 'ClickFORMS Maintenance:'
    end
    object lblMaintExp: TLabel
      Left = 138
      Top = 13
      Width = 191
      Height = 13
      AutoSize = False
    end
    object lblLevel: TLabel
      Left = 43
      Top = 32
      Width = 92
      Height = 13
      Alignment = taRightJustify
      Caption = 'Membership Level :'
    end
    object lblLevelValue: TLabel
      Left = 140
      Top = 31
      Width = 183
      Height = 13
      AutoSize = False
    end
    object btnClose: TButton
      Left = 338
      Top = 12
      Width = 60
      Height = 25
      Cancel = True
      Caption = 'Close'
      ModalResult = 1
      TabOrder = 0
    end
  end
end
