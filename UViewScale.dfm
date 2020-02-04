object DisplayZoom: TDisplayZoom
  Left = 344
  Top = 259
  BorderStyle = bsDialog
  Caption = 'Set Display Scale'
  ClientHeight = 145
  ClientWidth = 356
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lbScale: TLabel
    Left = 124
    Top = 16
    Width = 27
    Height = 13
    Caption = 'Scale'
  end
  object Label1: TLabel
    Left = 32
    Top = 16
    Width = 20
    Height = 13
    Caption = '50%'
  end
  object Label2: TLabel
    Left = 304
    Top = 16
    Width = 26
    Height = 13
    Caption = '200%'
  end
  object btnOK: TButton
    Left = 169
    Top = 108
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 0
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 264
    Top = 108
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object ImageScaleVal: TEdit
    Left = 160
    Top = 12
    Width = 33
    Height = 21
    MaxLength = 3
    TabOrder = 2
    Text = '100'
    OnExit = ImageScaleValExit
    OnKeyPress = ImageScaleValKeyPress
  end
  object ImageScaleBar: TTrackBar
    Left = 32
    Top = 40
    Width = 293
    Height = 33
    LineSize = 25
    Max = 200
    Min = 50
    PageSize = 25
    Frequency = 25
    Position = 100
    TabOrder = 3
    OnChange = ImageScaleBarChange
  end
  object ckbxSetDefault: TCheckBox
    Left = 12
    Top = 112
    Width = 125
    Height = 17
    Caption = 'Use as default scale'
    TabOrder = 4
  end
end
