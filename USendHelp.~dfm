object HelpEMail: THelpEMail
  Left = 604
  Top = 186
  Width = 520
  Height = 369
  Caption = 'Request Assistance'
  Color = clBtnFace
  Constraints.MaxWidth = 520
  Constraints.MinWidth = 520
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 487
    Height = 313
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 115
      Width = 39
      Height = 13
      Caption = 'Subject:'
    end
    object btnSend: TButton
      Left = 423
      Top = 15
      Width = 75
      Height = 25
      Caption = 'Send'
      TabOrder = 4
      OnClick = btnSendClick
    end
    object btnCancel: TButton
      Left = 424
      Top = 59
      Width = 75
      Height = 25
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 5
    end
    object edtSubject: TEdit
      Left = 56
      Top = 114
      Width = 441
      Height = 21
      TabOrder = 2
    end
    object GroupBox1: TGroupBox
      Left = 8
      Top = 8
      Width = 193
      Height = 97
      Caption = 'Contact'
      TabOrder = 0
      object Label2: TLabel
        Left = 10
        Top = 23
        Width = 31
        Height = 13
        Caption = 'Name:'
      end
      object Label3: TLabel
        Left = 10
        Top = 48
        Width = 82
        Height = 13
        Caption = 'Best Time to Call:'
      end
      object Label4: TLabel
        Left = 9
        Top = 73
        Width = 51
        Height = 13
        Caption = 'Phone No.'
      end
      object edtName: TEdit
        Left = 48
        Top = 20
        Width = 129
        Height = 21
        TabOrder = 0
      end
      object cmbxCallTime: TComboBox
        Left = 96
        Top = 44
        Width = 81
        Height = 21
        ItemHeight = 13
        TabOrder = 1
        Items.Strings = (
          'Anytime'
          'AM'
          'PM')
      end
      object etdPhone: TEdit
        Left = 64
        Top = 69
        Width = 113
        Height = 21
        TabOrder = 2
      end
    end
    object GroupBox2: TGroupBox
      Left = 208
      Top = 9
      Width = 201
      Height = 96
      Caption = 'Issue'
      TabOrder = 1
      object Label6: TLabel
        Left = 10
        Top = 22
        Width = 37
        Height = 13
        Caption = 'Product'
      end
      object Label5: TLabel
        Left = 10
        Top = 69
        Width = 44
        Height = 13
        Caption = 'Severity: '
      end
      object Label7: TLabel
        Left = 10
        Top = 45
        Width = 22
        Height = 13
        Caption = 'Area'
      end
      object cmbxProbProduct: TComboBox
        Left = 56
        Top = 18
        Width = 137
        Height = 21
        ItemHeight = 13
        TabOrder = 0
        OnChange = cmbxProbProductChange
      end
      object cmbxProbSeverity: TComboBox
        Left = 56
        Top = 67
        Width = 137
        Height = 21
        ItemHeight = 13
        TabOrder = 2
        Items.Strings = (
          'Low - Cosmetic'
          'Med - Does not function'
          'High - Program crashes')
      end
      object cmbxProbArea: TComboBox
        Left = 56
        Top = 42
        Width = 137
        Height = 21
        ItemHeight = 13
        TabOrder = 1
      end
    end
    object ProbDescription: TMemo
      Left = 0
      Top = 144
      Width = 487
      Height = 169
      Align = alBottom
      TabOrder = 3
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 313
    Width = 487
    Height = 19
    Panels = <>
  end
end
