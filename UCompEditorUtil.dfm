object CompSelector: TCompSelector
  Left = 419
  Top = 167
  BorderStyle = bsDialog
  Caption = 'Select comparable to copy from'
  ClientHeight = 91
  ClientWidth = 305
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
  object lblDescrip: TLabel
    Left = 15
    Top = 18
    Width = 194
    Height = 13
    AutoSize = False
    Caption = 'Copy in Entire Contents'
  end
  object Label2: TLabel
    Left = 16
    Top = 39
    Width = 97
    Height = 13
    AutoSize = False
    Caption = 'from Comparable #'
  end
  object cmbxCmpID: TComboBox
    Left = 120
    Top = 36
    Width = 57
    Height = 21
    AutoDropDown = True
    DropDownCount = 12
    ItemHeight = 13
    TabOrder = 0
  end
  object btnOK: TButton
    Left = 216
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Ok'
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 216
    Top = 56
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object ckbxPhoto: TCheckBox
    Left = 16
    Top = 64
    Width = 97
    Height = 17
    Caption = 'Include Photo'
    TabOrder = 3
    Visible = False
  end
end
