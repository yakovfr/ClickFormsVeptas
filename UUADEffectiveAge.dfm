object dlgUADEffectiveAge: TdlgUADEffectiveAge
  Left = 566
  Top = 183
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Effective Age & Estimated Remaining Economic Life'
  ClientHeight = 124
  ClientWidth = 333
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnShow = FormShow
  DesignSize = (
    333
    124)
  PixelsPerInch = 96
  TextHeight = 17
  object lblYrBuilt: TLabel
    Left = 148
    Top = 9
    Width = 82
    Height = 17
    Caption = 'Effective Age :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 16
    Top = 41
    Width = 217
    Height = 17
    Caption = 'Estimated Remaining Economic Life : '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object bbtnCancel: TBitBtn
    Left = 222
    Top = 85
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = '&Cancel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ModalResult = 2
    ParentFont = False
    TabOrder = 3
  end
  object bbtnOK: TBitBtn
    Left = 113
    Top = 85
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Save'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = bbtnOKClick
  end
  object bbtnClear: TBitBtn
    Left = 22
    Top = 85
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'C&lear'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = bbtnClearClick
  end
  object edtEffAge: TEdit
    Left = 240
    Top = 8
    Width = 73
    Height = 25
    TabOrder = 0
  end
  object edtEconLife: TEdit
    Left = 240
    Top = 40
    Width = 73
    Height = 25
    TabOrder = 1
  end
end
