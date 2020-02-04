object GetCaption: TGetCaption
  Left = 677
  Top = 471
  ActiveControl = edtName
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Save List As...'
  ClientHeight = 93
  ClientWidth = 240
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object btnOK: TButton
    Left = 13
    Top = 56
    Width = 75
    Height = 25
    Caption = 'Save'
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 148
    Top = 56
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object edtName: TEdit
    Left = 10
    Top = 16
    Width = 215
    Height = 21
    TabOrder = 0
    OnKeyDown = edtNameKeyDown
  end
end
