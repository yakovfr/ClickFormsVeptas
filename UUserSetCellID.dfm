object FormCellID: TFormCellID
  Left = 871
  Top = 194
  Width = 230
  Height = 540
  BorderIcons = [biSystemMenu]
  Caption = 'List of Cell IDs'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 485
    Width = 214
    Height = 19
    Panels = <>
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 214
    Height = 33
    Align = alTop
    TabOrder = 1
    object cmbxCellType: TComboBox
      Left = 8
      Top = 5
      Width = 153
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      Items.Strings = (
        'Residential'
        'AgWare'
        'Test Cell Types')
    end
  end
  object StrGrid: TStringGrid
    Left = 0
    Top = 33
    Width = 214
    Height = 452
    Align = alClient
    ColCount = 3
    DefaultRowHeight = 18
    FixedCols = 0
    Options = [goFixedVertLine, goFixedHorzLine, goHorzLine, goRangeSelect, goRowSelect, goThumbTracking]
    ScrollBars = ssVertical
    TabOrder = 2
    OnMouseDown = StrGridMouseDown
    OnStartDrag = StrGridStartDrag
  end
end
