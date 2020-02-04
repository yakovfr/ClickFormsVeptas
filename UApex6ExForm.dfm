object Apex6ExForm: TApex6ExForm
  Left = 607
  Top = 224
  Width = 412
  Height = 316
  Caption = 'Apex6ExForm'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    404
    285)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 209
    Top = 251
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
  object SketchViewer: TScrollBox
    Left = 0
    Top = 0
    Width = 167
    Height = 266
    HorzScrollBar.Smooth = True
    HorzScrollBar.Tracking = True
    VertScrollBar.Visible = False
    Align = alLeft
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 266
    Width = 404
    Height = 19
    Panels = <>
  end
  object AreaGrid: TtsGrid
    Left = 178
    Top = 52
    Width = 205
    Height = 173
    Anchors = [akTop, akRight]
    BorderStyle = bsNone
    CheckBoxStyle = stCheck
    Cols = 2
    Constraints.MaxWidth = 205
    DefaultRowHeight = 18
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
    Rows = 8
    ScrollBars = ssNone
    ShowHint = True
    StoreData = True
    TabOrder = 2
    Version = '3.01.08'
    XMLExport.Version = '1.0'
    XMLExport.DataPacketVersion = '2.0'
    ColProperties = <
      item
        DataCol = 1
        FieldName = 'Area Name'
        Col.FieldName = 'Area Name'
        Col.Heading = 'Area Name'
        Col.ReadOnly = True
        Col.Width = 100
      end
      item
        DataCol = 2
        FieldName = 'Sq. Feet'
        Col.FieldName = 'Sq. Feet'
        Col.Heading = 'Sq. Feet'
        Col.Width = 105
      end>
    CellProperties = <
      item
        DataCol = 1
        DataRow = 4
        Cell.ReadOnly = roOn
      end>
    Data = {
      0100000002000000010B0000004669727374204C6576656C0100000000020000
      0001000000010C0000005365636F6E64204C6576656C0300000001000000010B
      0000005468697264204C6576656C0400000001000000010C000000466F757274
      68204C7276656C05000000020000000111000000546F74616C204C6976696E67
      2041726561010000000006000000020000000113000000546F74616C20427569
      6C64696E67204172656101000000000700000001000000010800000042617365
      6D656E74080000000100000001060000004761726167650000000000000000}
  end
  object trancalcs: TCheckBox
    Left = 175
    Top = 235
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
  object btnTransfer: TButton
    Left = 190
    Top = 6
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Transfer'
    TabOrder = 4
    OnClick = btnTransferClick
  end
  object btnCancel: TButton
    Left = 294
    Top = 7
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Cancel = True
    Caption = 'Cancel'
    TabOrder = 5
    OnClick = btnCancelClick
  end
end
