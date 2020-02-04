object FormRspID: TFormRspID
  Left = 764
  Top = 103
  Width = 243
  Height = 542
  BorderIcons = [biSystemMenu]
  Caption = 'List of Response IDs'
  Color = clBtnFace
  Constraints.MinWidth = 120
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDefaultSizeOnly
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 495
    Width = 235
    Height = 19
    Panels = <>
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 235
    Height = 73
    Align = alTop
    TabOrder = 1
    object cmbxRspType: TComboBox
      Left = 8
      Top = 8
      Width = 105
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      Text = 'cmbxRspType'
      Items.Strings = (
        'Residential Rsp IDs'
        'AgWare Rsp IDs'
        'Test IDs')
    end
    object btnTest1: TButton
      Left = 16
      Top = 40
      Width = 49
      Height = 25
      Caption = 'test1'
      TabOrder = 1
    end
    object btnTest2: TButton
      Left = 80
      Top = 40
      Width = 49
      Height = 25
      Caption = 'Test2'
      TabOrder = 2
    end
    object btnTest3: TButton
      Left = 144
      Top = 40
      Width = 49
      Height = 25
      Caption = 'Test3'
      TabOrder = 3
    end
  end
  object StrGrid: TStringGrid
    Left = 0
    Top = 73
    Width = 235
    Height = 422
    Align = alClient
    ColCount = 3
    DefaultRowHeight = 18
    FixedCols = 0
    Options = [goFixedVertLine, goFixedHorzLine, goHorzLine, goThumbTracking]
    ScrollBars = ssVertical
    TabOrder = 2
    OnMouseDown = StrGridMouseDown
    OnStartDrag = StrGridStartDrag
  end
end
