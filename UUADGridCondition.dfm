object dlgUADGridCondition: TdlgUADGridCondition
  Left = 687
  Top = 183
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'UAD Property Condition'
  ClientHeight = 284
  ClientWidth = 552
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnShow = FormShow
  DesignSize = (
    552
    284)
  PixelsPerInch = 96
  TextHeight = 13
  object bbtnCancel: TBitBtn
    Left = 374
    Top = 245
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = '&Cancel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #39'segoe ui'
    Font.Style = []
    ModalResult = 2
    ParentFont = False
    TabOrder = 2
  end
  object bbtnOK: TBitBtn
    Left = 278
    Top = 245
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Save'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #39'segoe ui'
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
    Hint = '4518'
    Align = alTop
    Caption = 'Select the Condition Rating for this Property'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      'C1 - New, Recently Constructed; Not previously occupied'
      'C2 - Almost New, Renovated; No repairs or updating required'
      'C3 - Well Maintained; Limited depreciation, recently updated'
      'C4 - Adequately Maintained; Requires minimal repairs/updating'
      'C5 - Poorly Maintained; Some obvious and significant repairs'
      'C6 - Severe Damage; Substantial repairs to most')
    ParentFont = False
    TabOrder = 0
    TabStop = True
  end
  object bbtnHelp: TBitBtn
    Left = 470
    Top = 245
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Help'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #39'segoe ui'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = bbtnHelpClick
  end
  object bbtnClear: TButton
    Left = 8
    Top = 245
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'C&lear'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #39'segoe ui'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = bbtnClearClick
  end
end
