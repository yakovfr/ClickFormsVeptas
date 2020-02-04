object AMCRequestOverride: TAMCRequestOverride
  Left = 470
  Top = 171
  Width = 976
  Height = 392
  Caption = 'Request Override'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = onFormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 48
    Top = 32
    Width = 28
    Height = 13
    Caption = 'Name'
  end
  object Label2: TLabel
    Left = 48
    Top = 64
    Width = 31
    Height = 13
    Caption = 'Phone'
  end
  object Label3: TLabel
    Left = 56
    Top = 96
    Width = 25
    Height = 13
    Caption = 'Email'
  end
  object Label4: TLabel
    Left = 96
    Top = 120
    Width = 308
    Height = 13
    Caption = 'This email will be used by PCV Murcor to send you Override Code'
  end
  object Label5: TLabel
    Left = 48
    Top = 152
    Width = 36
    Height = 13
    Caption = 'Order #'
  end
  object Co: TLabel
    Left = 432
    Top = 104
    Width = 44
    Height = 13
    Caption = 'Comment'
  end
  object edtApprName: TEdit
    Left = 96
    Top = 24
    Width = 273
    Height = 21
    TabOrder = 0
    OnExit = onExitEditControl
  end
  object edtApprPhone: TEdit
    Left = 96
    Top = 56
    Width = 273
    Height = 21
    TabOrder = 1
    OnExit = onExitEditControl
  end
  object edtApprEmail: TEdit
    Left = 96
    Top = 88
    Width = 273
    Height = 21
    TabOrder = 2
    OnExit = onExitEditControl
  end
  object edtOrder: TEdit
    Left = 96
    Top = 144
    Width = 273
    Height = 21
    TabOrder = 3
    OnExit = onExitEditControl
  end
  object GroupBox1: TGroupBox
    Left = 48
    Top = 192
    Width = 321
    Height = 137
    Caption = 'Property'
    TabOrder = 4
    object Label6: TLabel
      Left = 8
      Top = 32
      Width = 38
      Height = 13
      Caption = 'Address'
    end
    object Label7: TLabel
      Left = 32
      Top = 64
      Width = 17
      Height = 13
      Caption = 'City'
    end
    object Label8: TLabel
      Left = 24
      Top = 104
      Width = 25
      Height = 13
      Caption = 'State'
    end
    object Label9: TLabel
      Left = 152
      Top = 104
      Width = 15
      Height = 13
      Caption = 'Zip'
    end
    object edtPropAddress: TEdit
      Left = 56
      Top = 24
      Width = 249
      Height = 21
      TabOrder = 0
      OnExit = onExitEditControl
    end
    object edtPropCity: TEdit
      Left = 56
      Top = 56
      Width = 249
      Height = 21
      TabOrder = 1
      OnExit = onExitEditControl
    end
    object edtPropState: TEdit
      Left = 56
      Top = 96
      Width = 73
      Height = 21
      TabOrder = 2
      OnExit = onExitEditControl
    end
    object edtPropZip: TEdit
      Left = 184
      Top = 96
      Width = 121
      Height = 21
      TabOrder = 3
      OnExit = onExitEditControl
    end
  end
  object btnsubmit: TButton
    Left = 512
    Top = 56
    Width = 75
    Height = 25
    Caption = 'Submit'
    ModalResult = 1
    TabOrder = 5
    OnClick = btnsubmitClick
  end
  object btnCancel: TButton
    Left = 752
    Top = 56
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 6
  end
  object memComment: TMemo
    Left = 432
    Top = 120
    Width = 513
    Height = 209
    Lines.Strings = (
      '')
    MaxLength = 5000
    ScrollBars = ssVertical
    TabOrder = 7
  end
end
