object FormLinkComments: TFormLinkComments
  Left = 539
  Top = 178
  ActiveControl = btnOK
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Carry Over Comments'
  ClientHeight = 130
  ClientWidth = 270
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object pnlHeading: TPanel
    Left = 0
    Top = 0
    Width = 270
    Height = 130
    BevelOuter = bvNone
    TabOrder = 0
    object lblHeading: TLabel
      Left = 10
      Top = 15
      Width = 250
      Height = 15
      AutoSize = False
      Caption = '&Enter a section heading for your comments:'
      FocusControl = fldHeading
    end
    object btnOK: TButton
      Left = 102
      Top = 100
      Width = 75
      Height = 25
      Action = actOK
      Default = True
      ModalResult = 1
      TabOrder = 2
      OnClick = btnOKClick
      OnKeyDown = btnOKKeyDown
    end
    object btnCancel: TButton
      Left = 185
      Top = 100
      Width = 75
      Height = 25
      Action = actCancel
      Cancel = True
      ModalResult = 2
      TabOrder = 3
    end
    object fldHeading: TEdit
      Left = 10
      Top = 37
      Width = 250
      Height = 21
      TabOrder = 0
    end
    object fldAsk: TCheckBox
      Left = 20
      Top = 67
      Width = 240
      Height = 19
      Caption = '&Always use this heading for this cell.'
      TabOrder = 1
    end
  end
  object slHeading: TActionList
    Left = 9
    Top = 96
    object actCancel: TAction
      Caption = '&Cancel'
      OnExecute = actCancelExecute
    end
    object actOK: TAction
      Caption = '&OK'
      OnUpdate = actOKUpdate
    end
  end
end
