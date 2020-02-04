object RegStudentActCode: TRegStudentActCode
  Left = 656
  Top = 230
  BorderStyle = bsDialog
  Caption = 'Enter Activation Code'
  ClientHeight = 242
  ClientWidth = 389
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = OnFormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 10
    Width = 126
    Height = 13
    Caption = 'Enter your Activation Code'
  end
  object Label2: TLabel
    Left = 16
    Top = 95
    Width = 349
    Height = 39
    Caption = 
      'If you do not have an Activation Code, one can be emailed to you' +
      '. Simply click the Get Activation Code button below. The activat' +
      'ion code will be sent to the email address you entered on the Re' +
      'gistration dialog.'
    WordWrap = True
  end
  object Label3: TLabel
    Left = 24
    Top = 143
    Width = 148
    Height = 13
    Caption = 'Activation Code will be sent to: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblEmail: TLabel
    Left = 24
    Top = 167
    Width = 44
    Height = 13
    Caption = 'lblEmail'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object RzSeparator1: TRzSeparator
    Left = 16
    Top = 80
    Width = 353
    Height = 5
    ShowGradient = True
    Color = clBtnFace
    ParentColor = False
  end
  object edtActCode1: TEdit
    Left = 16
    Top = 35
    Width = 57
    Height = 21
    TabOrder = 0
    OnKeyPress = edtKeyPress
    OnKeyUp = edtKeyUpFld1
  end
  object edtActCode2: TEdit
    Left = 80
    Top = 35
    Width = 57
    Height = 21
    TabOrder = 1
    OnKeyPress = edtKeyPress
    OnKeyUp = edtKeyUpFld2
  end
  object edtActCode3: TEdit
    Left = 144
    Top = 35
    Width = 57
    Height = 21
    TabOrder = 2
    OnKeyPress = edtKeyPress
    OnKeyUp = edtKeyUpFld3
  end
  object edtActCode4: TEdit
    Left = 208
    Top = 35
    Width = 57
    Height = 21
    TabOrder = 3
    OnKeyPress = edtKeyPress
    OnKeyUp = edtKeyUpFld4
  end
  object btnGetActCode: TButton
    Left = 24
    Top = 200
    Width = 129
    Height = 25
    Caption = 'Get Activation Code'
    TabOrder = 4
    OnClick = btnGetActCodeClk
  end
  object btnRegister: TButton
    Left = 288
    Top = 33
    Width = 81
    Height = 25
    Caption = 'Activate'
    TabOrder = 5
    OnClick = btnRegisterClick
  end
  object btnCancel: TButton
    Left = 288
    Top = 200
    Width = 81
    Height = 25
    Caption = 'Cancel'
    TabOrder = 6
    OnClick = btnCancelClk
  end
end
