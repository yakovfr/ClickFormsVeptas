object RapidSketchForm: TRapidSketchForm
  Left = 531
  Top = 177
  BorderIcons = []
  BorderStyle = bsToolWindow
  Caption = 'RapidSketchForm'
  ClientHeight = 261
  ClientWidth = 354
  Color = clBtnFace
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
    354
    261)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 178
    Top = 229
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
  object StatusBar1: TStatusBar
    Left = 0
    Top = 242
    Width = 354
    Height = 19
    Panels = <>
  end
  object AreaGrid: TtsGrid
    Left = 145
    Top = 45
    Width = 205
    Height = 156
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
    HeadingParentFont = False
    HeadingVertAlignment = vtaCenter
    ParentShowHint = False
    ProvideGridMenu = True
    RowBarOn = False
    Rows = 7
    ScrollBars = ssNone
    ShowHint = True
    StoreData = True
    TabOrder = 1
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
    Data = {
      0100000002000000010B0000004669727374204C6576656C0100000000020000
      0001000000010C0000005365636F6E64204C6576656C0300000001000000010B
      0000005468697264204C6576656C0400000001000000010C000000466F757274
      68204C6576656C05000000010000000111000000546F74616C204C6976696E67
      204172656106000000020000000108000000426173656D656E74010000000007
      0000000100000001060000004761726167650000000000000000}
  end
  object Panel1: TPanel
    Left = 146
    Top = 5
    Width = 205
    Height = 41
    Anchors = [akTop, akRight]
    BevelOuter = bvNone
    Constraints.MinWidth = 205
    TabOrder = 2
    DesignSize = (
      205
      41)
    object btnTransfer: TButton
      Left = 13
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Transfer'
      TabOrder = 0
      OnClick = btnTransferClick
    end
    object btnCancel: TButton
      Left = 117
      Top = 7
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      TabOrder = 1
      OnClick = btnCancelClick
    end
  end
  object SketchViewer: TScrollBox
    Left = 5
    Top = 3
    Width = 130
    Height = 201
    HorzScrollBar.Smooth = True
    HorzScrollBar.Tracking = True
    VertScrollBar.Visible = False
    TabOrder = 3
  end
  object trancalcs: TCheckBox
    Left = 144
    Top = 211
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
    TabOrder = 4
  end
end
