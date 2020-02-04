object FindNReplace: TFindNReplace
  Left = 430
  Top = 252
  Width = 389
  Height = 148
  Caption = 'Find and Replace'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 13
    Top = 16
    Width = 23
    Height = 13
    Caption = 'Find:'
  end
  object Label2: TLabel
    Left = 13
    Top = 52
    Width = 40
    Height = 13
    Caption = 'Replace'
  end
  object edtFind: TEdit
    Left = 61
    Top = 12
    Width = 204
    Height = 21
    TabOrder = 0
    OnChange = edtFindChange
  end
  object edtReplace: TEdit
    Left = 61
    Top = 48
    Width = 205
    Height = 21
    TabOrder = 1
  end
  object btnFind: TButton
    Left = 293
    Top = 12
    Width = 75
    Height = 25
    Caption = 'Find Next'
    TabOrder = 3
    OnClick = btnFindClick
  end
  object btnReplace: TButton
    Left = 293
    Top = 44
    Width = 75
    Height = 25
    Caption = 'Replace'
    Enabled = False
    TabOrder = 4
    OnClick = btnReplaceClick
  end
  object btnReplaceAll: TButton
    Left = 189
    Top = 84
    Width = 75
    Height = 25
    Caption = 'Replace All'
    TabOrder = 5
    OnClick = btnReplaceAllClick
  end
  object btnCancel: TButton
    Left = 293
    Top = 84
    Width = 77
    Height = 25
    Cancel = True
    Caption = 'Done'
    ModalResult = 1
    TabOrder = 6
    OnClick = btnCancelClick
  end
  object chkMatchWord: TCheckBox
    Left = 60
    Top = 87
    Width = 93
    Height = 17
    Caption = 'Match Exactly.'
    TabOrder = 2
  end
end
