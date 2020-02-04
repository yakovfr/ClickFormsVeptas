object CCProgress: TCCProgress
  Left = 942
  Top = 203
  BorderIcons = []
  BorderStyle = bsToolWindow
  Caption = 'Processing'
  ClientHeight = 82
  ClientWidth = 308
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
    Left = 88
    Top = 8
    Width = 52
    Height = 13
    Caption = 'Processing'
  end
  object lblMax: TLabel
    Left = 232
    Top = 64
    Width = 49
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
  end
  object lblValue: TLabel
    Left = 88
    Top = 64
    Width = 49
    Height = 13
    AutoSize = False
  end
  object StatusBar: TCFProgressBar
    Left = 88
    Top = 32
    Width = 193
    Height = 17
    TabOrder = 0
  end
  object wiProcessing: TWorkingIndicator
    Left = 8
    Top = 16
    Width = 49
    Height = 49
    ActiveTickColor = clRed
    InactiveTickColor = clActiveCaption
    TicksPerRevolution = 12
    TicksPerSecond = 12.000000000000000000
  end
end
