object dlgUADCondoDesignStyle: TdlgUADCondoDesignStyle
  Left = 527
  Top = 156
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'UAD: Property Design/Style'
  ClientHeight = 349
  ClientWidth = 649
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
    649
    349)
  PixelsPerInch = 96
  TextHeight = 13
  object lblDesignStyleDesc: TLabel
    Left = 303
    Top = 247
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
  object lblLevels: TLabel
    Left = 94
    Top = 247
    Width = 103
    Height = 17
    Alignment = taRightJustify
    Anchors = [akRight, akBottom]
    Caption = 'Number of Levels'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object bbtnCancel: TBitBtn
    Left = 469
    Top = 313
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
    TabOrder = 5
  end
  object bbtnOK: TBitBtn
    Left = 379
    Top = 313
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
    TabOrder = 4
    OnClick = bbtnOKClick
  end
  object bbtnHelp: TBitBtn
    Left = 559
    Top = 313
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
    TabOrder = 6
    OnClick = bbtnHelpClick
  end
  object bbtnClear: TButton
    Left = 8
    Top = 313
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
    TabOrder = 7
    OnClick = bbtnClearClick
  end
  object edtDesignStyleDesc: TEdit
    Tag = 5
    Left = 466
    Top = 246
    Width = 88
    Height = 21
    Hint = '4433'
    Anchors = [akRight, akBottom]
    TabOrder = 2
  end
  object edtLevels: TEdit
    Tag = 5
    Left = 202
    Top = 246
    Width = 73
    Height = 21
    Hint = '4533'
    Anchors = [akRight, akBottom]
    MaxLength = 2
    TabOrder = 1
    Text = '0'
    OnKeyPress = edtLevelsKeyPress
  end
  object rgCondoAttachmentTypes: TRadioGroup
    Left = 0
    Top = 0
    Width = 649
    Height = 233
    Hint = '4518'
    Align = alTop
    Caption = 'Select the Structure Attachment Type'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ItemIndex = 1
    Items.Strings = (
      
        'Detached Structure, does not share any communal walls, floor, or' +
        ' ceiling with another property'
      
        'One in a row of identical houses or having a common wall; attach' +
        'ed to another unit via common wall'
      
        'Structure is 1-3 stories tall, contains units with communal wall' +
        's, floors, and /or ceilings'
      
        'Structure is 4-7 stories tall, contains units with communal wall' +
        's, floors, and /or ceilings'
      
        'Structure is 8+ stories tall, contains units with communal walls' +
        ', floors, and /or ceilings'
      'Other')
    ParentFont = False
    TabOrder = 0
    TabStop = True
  end
  object cbNoAutoDlg: TCheckBox
    Left = 35
    Top = 277
    Width = 433
    Height = 21
    Anchors = [akRight, akBottom]
    Caption = 'Only show this dialog when the F8 key is pressed'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
end
