object dlgUADResidDesignStyle: TdlgUADResidDesignStyle
  Left = 427
  Top = 223
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'UAD: Property Design/Style'
  ClientHeight = 286
  ClientWidth = 630
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnShow = FormShow
  DesignSize = (
    630
    286)
  PixelsPerInch = 96
  TextHeight = 13
  object lblDesignStyleDesc: TLabel
    Left = 284
    Top = 155
    Width = 158
    Height = 17
    Alignment = taRightJustify
    Anchors = [akRight, akBottom]
    Caption = 'Design or Style Description'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lblStories: TLabel
    Left = 70
    Top = 155
    Width = 108
    Height = 17
    Alignment = taRightJustify
    Anchors = [akRight, akBottom]
    Caption = 'Number of Stories'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object bbtnCancel: TBitBtn
    Left = 450
    Top = 250
    Width = 80
    Height = 27
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
    TabOrder = 6
  end
  object bbtnOK: TBitBtn
    Left = 360
    Top = 250
    Width = 80
    Height = 27
    Anchors = [akRight, akBottom]
    Caption = '&Save'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = bbtnOKClick
  end
  object bbtnHelp: TBitBtn
    Left = 540
    Top = 250
    Width = 79
    Height = 27
    Anchors = [akRight, akBottom]
    Caption = '&Help'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    OnClick = bbtnHelpClick
  end
  object bbtnClear: TButton
    Left = 8
    Top = 250
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
    TabOrder = 8
    OnClick = bbtnClearClick
  end
  object edtDesignStyleDesc: TEdit
    Tag = 5
    Left = 451
    Top = 151
    Width = 88
    Height = 25
    Hint = '4433'
    Anchors = [akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object edtStories: TEdit
    Tag = 5
    Left = 183
    Top = 151
    Width = 73
    Height = 25
    Hint = '4533'
    Anchors = [akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    MaxLength = 5
    ParentFont = False
    TabOrder = 1
    Text = '0'
    OnKeyPress = edtStoriesKeyPress
  end
  object rgResidAttachmentTypes: TRadioGroup
    Left = 0
    Top = 0
    Width = 630
    Height = 133
    Hint = '4518'
    Align = alTop
    Caption = 'Select the Structure Attachment Type'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      
        'Detached Structure, does not share any communal walls, floor, or' +
        ' ceiling with another property'
      
        'Attached Structure, use for row and townhomes that share multipl' +
        'e communal walls'
      
        'Semi-detached structure, use for end-unit row and townhomes as w' +
        'ell as duplexes')
    ParentFont = False
    TabOrder = 0
    TabStop = True
  end
  object cbNoAutoDlg: TCheckBox
    Left = 16
    Top = 223
    Width = 433
    Height = 17
    Anchors = [akRight, akBottom]
    Caption = 'Only show this dialog when the F8 key is pressed'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object rgExistingPropConst: TRadioGroup
    Left = 287
    Top = 179
    Width = 314
    Height = 40
    Columns = 3
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    Items.Strings = (
      'Existing'
      'Proposed'
      'Under Const.')
    ParentFont = False
    TabOrder = 3
  end
end
