object MLSFindError: TMLSFindError
  Left = 525
  Top = 221
  Width = 540
  Height = 260
  BorderIcons = []
  Caption = 'MLS Data Verification'
  Color = clBtnFace
  Constraints.MinHeight = 260
  Constraints.MinWidth = 540
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 26
    Top = 24
    Width = 56
    Height = 13
    Caption = 'Property :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LbComp: TLabel
    Left = 88
    Top = 24
    Width = 95
    Height = 13
    Caption = 'property address'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 26
    Top = 64
    Width = 39
    Height = 13
    Caption = 'Error in :'
  end
  object lbField: TLabel
    Left = 88
    Top = 64
    Width = 64
    Height = 13
    Caption = 'Field Name'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 26
    Top = 116
    Width = 80
    Height = 13
    Caption = 'Current Value is :'
  end
  object Label4: TLabel
    Left = 285
    Top = 116
    Width = 71
    Height = 13
    Caption = 'Replace With :'
  end
  object btnOk: TBitBtn
    Left = 11
    Top = 180
    Width = 75
    Height = 25
    Caption = 'Replace'
    ModalResult = 1
    TabOrder = 0
    OnClick = btnOkClick
  end
  object btnReplaAll: TBitBtn
    Left = 93
    Top = 180
    Width = 75
    Height = 25
    Caption = 'Replace All'
    ModalResult = 8
    TabOrder = 1
    OnClick = btnReplaAllClick
  end
  object btnSkip: TButton
    Left = 178
    Top = 180
    Width = 75
    Height = 25
    Caption = 'Skip'
    ModalResult = 5
    TabOrder = 2
    OnClick = btnSkipClick
  end
  object btnSkipColum: TButton
    Left = 265
    Top = 180
    Width = 75
    Height = 25
    Caption = 'Skip Column'
    ModalResult = 9
    TabOrder = 3
    OnClick = btnSkipColumClick
  end
  object btnCancel: TButton
    Left = 440
    Top = 180
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
    OnClick = btnCancelClick
  end
  object btnExclude: TButton
    Left = 353
    Top = 180
    Width = 75
    Height = 25
    Caption = 'Exclude Prop.'
    ModalResult = 3
    TabOrder = 5
    OnClick = btnExcludeClick
  end
  object edtCurrentValue: TEdit
    Left = 112
    Top = 112
    Width = 110
    Height = 21
    TabOrder = 6
  end
  object chkSaveMLSResponses: TCheckBox
    Left = 26
    Top = 152
    Width = 449
    Height = 17
    Caption = 
      'Save edits to your preference file for use on all future reports' +
      '.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
  end
  object edtReplaceValue: TComboBox
    Left = 360
    Top = 112
    Width = 105
    Height = 21
    ItemHeight = 13
    TabOrder = 8
  end
end
