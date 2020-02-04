object dlgUADConstQuality: TdlgUADConstQuality
  Left = 459
  Top = 176
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'UAD Construction Quality'
  ClientHeight = 285
  ClientWidth = 552
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnShow = FormShow
  DesignSize = (
    552
    285)
  PixelsPerInch = 96
  TextHeight = 13
  object bbtnCancel: TBitBtn
    Left = 374
    Top = 246
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
    TabOrder = 2
  end
  object bbtnOK: TBitBtn
    Left = 278
    Top = 246
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
    TabOrder = 1
    OnClick = bbtnOKClick
  end
  object rgRating: TRadioGroup
    Left = 0
    Top = 0
    Width = 552
    Height = 233
    Hint = '4517'
    Align = alTop
    Caption = 'Select the Construction Quality Rating for this Property'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      
        'Q1 - Exceptionally High; Architecturally designed home; high gra' +
        'de mat'#39'l'
      'Q2 - Very High; Custom home; High quality tract developments'
      'Q3 - Above Standard; Above standard residential developments'
      'Q4 - Standard; Materials are stock or builder grade'
      'Q5 - Below Standard; Meets minimum building codes'
      
        'Q6 - Very Poor; Lowest quality mat'#39'l, Non-conforming constructio' +
        'n')
    ParentFont = False
    TabOrder = 0
    TabStop = True
  end
  object bbtnHelp: TBitBtn
    Left = 470
    Top = 246
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Help'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = bbtnHelpClick
  end
  object bbtnClear: TButton
    Left = 8
    Top = 246
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
end
