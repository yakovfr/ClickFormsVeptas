object EPadInterface: TEPadInterface
  Left = 570
  Top = 157
  BorderStyle = bsDialog
  Caption = 'Apply ePad Signature'
  ClientHeight = 305
  ClientWidth = 384
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 19
    Width = 68
    Height = 13
    Caption = 'Signer'#39's Name'
  end
  object Label2: TLabel
    Left = 20
    Top = 51
    Width = 100
    Height = 13
    Caption = 'Reason for Signature'
  end
  object SignatureArea: TPaintBox
    Left = 20
    Top = 88
    Width = 345
    Height = 155
    Color = clWhite
    ParentColor = False
    OnPaint = SignatureAreaPaint
  end
  object SignerName: TEdit
    Left = 88
    Top = 16
    Width = 273
    Height = 21
    TabOrder = 0
    OnChange = SignerNameChange
  end
  object SignerReason: TComboBox
    Left = 136
    Top = 48
    Width = 225
    Height = 21
    ItemHeight = 13
    TabOrder = 1
    Text = 'Approval'
    Items.Strings = (
      'Approval'
      'Agreement'
      'Rejection'
      'Read at Document'
      'Witnessed Document Signing')
  end
  object btnClear: TButton
    Left = 16
    Top = 264
    Width = 75
    Height = 25
    Caption = 'Clear'
    TabOrder = 2
    OnClick = btnClearClick
  end
  object btnCancel: TButton
    Left = 160
    Top = 264
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object btnSignIt: TButton
    Left = 296
    Top = 264
    Width = 75
    Height = 25
    Caption = 'Sign It'
    Enabled = False
    ModalResult = 1
    TabOrder = 4
  end
end
