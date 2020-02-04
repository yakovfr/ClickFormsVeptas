object dlgUADGridDataSrc: TdlgUADGridDataSrc
  Left = 383
  Top = 259
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'UAD: Property Listing Information'
  ClientHeight = 217
  ClientWidth = 534
  Color = clBtnFace
  Constraints.MinWidth = 542
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnShow = FormShow
  DesignSize = (
    534
    217)
  PixelsPerInch = 96
  TextHeight = 13
  object lblDOM: TLabel
    Left = 10
    Top = 16
    Width = 135
    Height = 17
    Caption = 'Days on Market (DOM)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lblDataSrc: TLabel
    Left = 202
    Top = 14
    Width = 85
    Height = 17
    Alignment = taRightJustify
    Caption = 'Data Source(s)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object bbtnCancel: TBitBtn
    Left = 366
    Top = 182
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
    TabOrder = 5
  end
  object bbtnOK: TBitBtn
    Left = 281
    Top = 182
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
    TabOrder = 4
    OnClick = bbtnOKClick
  end
  object edtDOM: TEdit
    Tag = 4531
    Left = 150
    Top = 12
    Width = 47
    Height = 25
    Hint = 'DOM '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    MaxLength = 4
    ParentFont = False
    TabOrder = 0
    OnExit = edtDOMExit
    OnKeyPress = edtDOMKeyPress
  end
  object cbDOMUnk: TCheckBox
    Tag = 4
    Left = 11
    Top = 48
    Width = 138
    Height = 14
    Caption = 'DOM Unknown'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = cbDOMUnkClick
  end
  object lbDataSrcUsed: TListBox
    Tag = 10
    Left = 289
    Top = 34
    Width = 158
    Height = 111
    Hint = '4431'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ItemHeight = 17
    Items.Strings = (
      '999,999,999 99/99/9999'
      '999,999,999 99/99/9999'
      '999,999,999 99/99/9999'
      '999,999,999 99/99/9999'
      '999,999,999 99/99/9999'
      '999,999,999 99/99/9999'
      '999,999,999 99/99/9999')
    ParentFont = False
    TabOrder = 8
    OnClick = lbDataSrcUsedClick
    OnDblClick = lbDataSrcUsedDblClick
  end
  object edtAddDataSrc: TEdit
    Left = 289
    Top = 10
    Width = 158
    Height = 25
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    Text = 'edtAddDataSrc'
    OnChange = edtAddDataSrcChange
    OnExit = edtAddDataSrcExit
    OnKeyPress = edtAddDataSrcKeyPress
  end
  object bbtnAddDataSrc: TBitBtn
    Left = 460
    Top = 9
    Width = 65
    Height = 21
    Anchors = [akRight, akBottom]
    Caption = 'A&dd'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = bbtnAddDataSrcClick
  end
  object bbtnDelDataSrc: TBitBtn
    Left = 460
    Top = 75
    Width = 65
    Height = 22
    Anchors = [akRight, akBottom]
    Caption = 'De&lete'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
    OnClick = bbtnDelDataSrcClick
  end
  object bbtnHelp: TBitBtn
    Left = 451
    Top = 182
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
    TabOrder = 6
    OnClick = bbtnHelpClick
  end
  object bbtnClear: TBitBtn
    Left = 8
    Top = 182
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
  object BitBtn1: TBitBtn
    Left = 460
    Top = 42
    Width = 65
    Height = 21
    Anchors = [akRight, akBottom]
    Caption = '&Edit'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
    OnClick = BitBtn1Click
  end
end
