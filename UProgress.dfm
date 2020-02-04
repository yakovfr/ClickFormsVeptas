object Progress: TProgress
  Left = 771
  Top = 309
  BorderIcons = []
  BorderStyle = bsToolWindow
  Caption = 'Progress'
  ClientHeight = 66
  ClientWidth = 283
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
  object StatusNote: TLabel
    Left = 16
    Top = 8
    Width = 52
    Height = 13
    Caption = 'Processing'
  end
  object lblMax: TLabel
    Left = 216
    Top = 24
    Width = 49
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
  end
  object lblValue: TLabel
    Left = 16
    Top = 24
    Width = 49
    Height = 13
    AutoSize = False
  end
  object StatusBar: TCFProgressBar
    Left = 16
    Top = 40
    Width = 249
    Height = 16
    TabOrder = 0
  end
  object StepTimer: TTimer
    OnTimer = StepTimerEvent
    Left = 256
  end
end
