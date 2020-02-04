object AreaSketchSEForm: TAreaSketchSEForm
  Left = 50
  Top = 134
  AlphaBlendValue = 0
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'AreaSketch Special Edition Integrator'
  ClientHeight = 224
  ClientWidth = 364
  Color = 16770269
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    364
    224)
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 179
    Top = 196
    Width = 141
    Height = 15
    Anchors = [akTop, akRight]
    Caption = '(Overwrites Existing Data)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object AreaGrid: TtsGrid
    Left = 147
    Top = 56
    Width = 205
    Height = 122
    Anchors = [akTop, akRight]
    BorderStyle = bsNone
    CheckBoxStyle = stCheck
    Cols = 2
    Constraints.MaxWidth = 205
    DefaultRowHeight = 17
    ExportDelimiter = ','
    HeadingHorzAlignment = htaCenter
    HeadingFont.Charset = DEFAULT_CHARSET
    HeadingFont.Color = clWindowText
    HeadingFont.Height = -11
    HeadingFont.Name = 'MS Sans Serif'
    HeadingFont.Style = []
    HeadingHeight = 18
    HeadingVertAlignment = vtaCenter
    ParentShowHint = False
    ProvideGridMenu = True
    RowBarOn = False
    Rows = 6
    ScrollBars = ssNone
    ShowHint = True
    StoreData = True
    TabOrder = 0
    Version = '3.01.08'
    VertAlignment = vtaCenter
    XMLExport.Version = '1.0'
    XMLExport.DataPacketVersion = '2.0'
    ColProperties = <
      item
        DataCol = 1
        FieldName = 'Area Name'
        Col.FieldName = 'Area Name'
        Col.ReadOnly = True
        Col.Width = 100
      end
      item
        DataCol = 2
        FieldName = 'Sq. Feet'
        Col.FieldName = 'Sq. Feet'
        Col.Width = 105
      end>
    Data = {
      0100000001000000010B0000004669727374204C6576656C0200000001000000
      010C0000005365636F6E64204C6576656C0300000001000000010B0000005468
      697264204C6576656C04000000010000000111000000546F74616C204C697669
      6E67204172656105000000010000000108000000426173656D656E7406000000
      02000000010600000047617261676501000000000000000000000000}
  end
  object Panel1: TPanel
    Left = 147
    Top = 16
    Width = 205
    Height = 41
    Anchors = [akTop, akRight]
    BevelOuter = bvNone
    BiDiMode = bdLeftToRight
    Constraints.MinWidth = 205
    UseDockManager = False
    ParentBiDiMode = False
    TabOrder = 1
    DesignSize = (
      205
      41)
    object btnTransfer: TButton
      Left = 13
      Top = 2
      Width = 75
      Height = 29
      Anchors = [akTop, akRight]
      Caption = 'Transfer'
      TabOrder = 0
      OnClick = btnTransferClick
    end
    object btnCancel: TButton
      Left = 117
      Top = 2
      Width = 75
      Height = 30
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      TabOrder = 1
      OnClick = btnCancelClick
    end
  end
  object Panel2: TPanel
    Left = 9
    Top = 18
    Width = 129
    Height = 188
    BiDiMode = bdLeftToRight
    Color = 4194304
    UseDockManager = False
    ParentBiDiMode = False
    ParentBackground = False
    TabOrder = 2
    object nextBtn: TSpeedButton
      Tag = 1
      Left = 104
      Top = 167
      Width = 18
      Height = 17
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000120B0000120B00001000000010000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF00C0C0C00000FFFF00FF000000C0C0C000FFFF0000FFFFFF00DADADADADADA
        DADAADADADADADADADADDADADADADADADADAADADADADADADADADDADADA1ADADA
        DADAADADAD11ADADADADDADADA111ADADADAADADAD1111ADADADDADADA11111A
        DADAADADAD1111ADADADDADADA111ADADADAADADAD11ADADADADDADADA1ADADA
        DADAADADADADADADADADDADADADADADADADAADADADADADADADAD}
      Layout = blGlyphRight
      Margin = 0
      Spacing = 0
      OnClick = nextBtnClick
    end
    object Image1: TImage
      Left = 4
      Top = 4
      Width = 120
      Height = 160
      Center = True
      Stretch = True
    end
    object prevBtn: TSpeedButton
      Tag = -1
      Left = 4
      Top = 167
      Width = 18
      Height = 17
      Enabled = False
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000120B0000120B00001000000010000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF00C0C0C00000FFFF00FF000000C0C0C000FFFF0000FFFFFF00DADADADADADA
        DADAADADADADADADADADDADADADADADADADAADADADADADADADADDADADADAD1DA
        DADAADADADAD11ADADADDADADAD111DADADAADADAD1111ADADADDADAD11111DA
        DADAADADAD1111ADADADDADADAD111DADADAADADADAD11ADADADDADADADAD1DA
        DADAADADADADADADADADDADADADADADADADAADADADADADADADAD}
      OnClick = nextBtnClick
    end
    object Label1: TLabel
      Left = 29
      Top = 166
      Width = 68
      Height = 18
      Alignment = taCenter
      AutoSize = False
      Caption = 'Image 1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
    end
  end
  object trancalcs: TCheckBox
    Left = 145
    Top = 180
    Width = 208
    Height = 17
    Anchors = [akTop, akRight]
    Caption = 'Transfer Calculations to Report'
    Checked = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    State = cbChecked
    TabOrder = 3
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 10000
    OnTimer = Timer1Timer
    Left = 78
    Top = 10
  end
end
