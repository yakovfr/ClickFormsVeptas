object PhoenixSketchForm: TPhoenixSketchForm
  Left = 813
  Top = 271
  Anchors = []
  BorderStyle = bsSingle
  Caption = 'PhoenixSketch'
  ClientHeight = 213
  ClientWidth = 360
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 137
    Height = 209
    Proportional = True
    Stretch = True
  end
  object Label1: TLabel
    Left = 162
    Top = 192
    Width = 141
    Height = 15
    Caption = '(Overwrites Existing Data)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Panel1: TPanel
    Left = 146
    Top = 0
    Width = 205
    Height = 41
    BevelOuter = bvNone
    Constraints.MinWidth = 205
    TabOrder = 0
    DesignSize = (
      205
      41)
    object btnTransfer: TButton
      Left = 13
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Transfer'
      ModalResult = 1
      TabOrder = 0
      OnClick = btnTransferClick
    end
    object btnCancel: TButton
      Left = 117
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object AreaGrid: TtsGrid
    Left = 147
    Top = 48
    Width = 205
    Height = 127
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
    Rows = 6
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
  object trancalcs: TCheckBox
    Left = 144
    Top = 176
    Width = 208
    Height = 17
    Caption = 'Transfer Calulations to Report'
    Checked = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    State = cbChecked
    TabOrder = 2
  end
end
