object ProcessingForm: TProcessingForm
  Left = 198
  Top = 218
  Cursor = crAppStart
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Processing'
  ClientHeight = 100
  ClientWidth = 310
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lblProcessing: TLabel
    Left = 80
    Top = 30
    Width = 150
    Height = 15
    AutoSize = False
    Caption = 'Processing your request...'
  end
  object wiProcessing: TWorkingIndicator
    Left = 40
    Top = 24
    Width = 30
    Height = 30
    InactiveTickColor = clSilver
    TicksPerRevolution = 12
    TicksPerSecond = 12.000000000000000000
  end
  object btnCancel: TButton
    Left = 230
    Top = 70
    Width = 75
    Height = 25
    Action = actCancel
    TabOrder = 1
  end
  object alProcessing: TActionList
    Left = 8
    Top = 64
    object actCancel: TAction
      Caption = '&Cancel'
      OnExecute = actCancelExecute
      OnUpdate = actCancelUpdate
    end
  end
end
