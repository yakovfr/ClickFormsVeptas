object Analysis: TAnalysis
  Left = 276
  Top = 257
  Width = 1156
  Height = 883
  Caption = 'Analysis'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClick = FormClick
  OnShow = FormShow
  DesignSize = (
    1148
    855)
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 836
    Width = 1148
    Height = 19
    Panels = <>
  end
  object ScrollBox: TScrollBox
    Left = 0
    Top = 0
    Width = 2100
    Height = 1080
    HorzScrollBar.Smooth = True
    HorzScrollBar.ThumbSize = 10
    HorzScrollBar.Tracking = True
    Anchors = [akLeft, akTop, akRight, akBottom]
    AutoScroll = False
    BevelInner = bvLowered
    BevelOuter = bvRaised
    TabOrder = 0
    object SubjectPanel: TPanel
      Left = 0
      Top = 0
      Width = 137
      Height = 1076
      Align = alLeft
      AutoSize = True
      Caption = 'Subject'
      TabOrder = 0
    end
    object MktDataPanel: TPanel
      Left = 137
      Top = 0
      Width = 77
      Height = 1076
      Align = alLeft
      AutoSize = True
      Caption = 'Market Data'
      TabOrder = 1
    end
    object MktFeaturePanel: TPanel
      Left = 214
      Top = 0
      Width = 127
      Height = 1076
      Align = alLeft
      AutoSize = True
      Caption = 'Market Feature'
      TabOrder = 2
    end
    object RegressionPanel: TPanel
      Left = 341
      Top = 0
      Width = 188
      Height = 1076
      Align = alLeft
      AutoSize = True
      Caption = 'Regression'
      TabOrder = 3
    end
    object SubjectMktPanel: TPanel
      Left = 529
      Top = 0
      Width = 183
      Height = 1076
      Align = alLeft
      AutoSize = True
      Caption = 'Subject Market'
      TabOrder = 4
    end
    object AdjustmentPanel: TPanel
      Left = 712
      Top = 0
      Width = 188
      Height = 1076
      Align = alLeft
      AutoSize = True
      Caption = 'Adjustment'
      TabOrder = 5
    end
    object CompSelectionPanel: TPanel
      Left = 900
      Top = 0
      Width = 188
      Height = 1076
      Align = alLeft
      AutoSize = True
      Caption = 'Comp Selection'
      TabOrder = 6
    end
    object BuildReportPanel: TPanel
      Left = 1088
      Top = 0
      Width = 188
      Height = 1076
      Align = alLeft
      AutoSize = True
      Caption = 'Build Report'
      TabOrder = 7
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 795
    Width = 1148
    Height = 41
    Align = alBottom
    TabOrder = 2
    Visible = False
    object btnCancel: TButton
      Left = 120
      Top = 8
      Width = 75
      Height = 25
      Caption = 'exit'
      ModalResult = 2
      TabOrder = 0
      OnClick = btnCancelClick
    end
  end
end
