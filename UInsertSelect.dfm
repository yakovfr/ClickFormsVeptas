object SelectImageSource: TSelectImageSource
  Left = 407
  Top = 176
  Width = 333
  Height = 164
  Caption = 'Select Image Source'
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
  object btnSelectFile: TButton
    Left = 24
    Top = 16
    Width = 153
    Height = 25
    Caption = 'Insert Image from File'
    ModalResult = 1
    TabOrder = 0
    OnClick = btnSelectFileClick
  end
  object btnSelectDevice: TButton
    Left = 24
    Top = 56
    Width = 153
    Height = 25
    Caption = 'Insert Image from Device'
    ModalResult = 1
    TabOrder = 1
    OnClick = btnSelectDeviceClick
  end
  object btnCancel: TButton
    Left = 240
    Top = 16
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object btnSetup: TButton
    Left = 24
    Top = 96
    Width = 153
    Height = 25
    Caption = 'Setup Device Source'
    ModalResult = 1
    TabOrder = 3
    OnClick = btnSetupClick
  end
end
