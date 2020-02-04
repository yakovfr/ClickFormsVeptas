object dlgUADSubjDataSrc: TdlgUADSubjDataSrc
  Left = 464
  Top = 160
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'UAD: Subject Listing History'
  ClientHeight = 415
  ClientWidth = 584
  Color = clBtnFace
  Constraints.MinWidth = 592
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnShow = FormShow
  DesignSize = (
    584
    415)
  PixelsPerInch = 96
  TextHeight = 13
  object lblLastListPrice: TLabel
    Left = 24
    Top = 132
    Width = 34
    Height = 17
    Alignment = taRightJustify
    Caption = 'Latest'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object lblOrigListPrice: TLabel
    Left = 12
    Top = 99
    Width = 46
    Height = 17
    Alignment = taRightJustify
    Caption = 'Original'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lblAddPriListings: TLabel
    Left = 18
    Top = 210
    Width = 160
    Height = 17
    Caption = 'Other Listing Price Changes'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lblDataSrcUsed: TLabel
    Left = 348
    Top = 181
    Width = 119
    Height = 17
    Caption = 'Data Source(s) Used'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lblDOM: TLabel
    Left = 402
    Top = 98
    Width = 140
    Height = 17
    Caption = 'DOM - Days on Market '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lblListingDate: TLabel
    Left = 205
    Top = 75
    Width = 68
    Height = 17
    Caption = 'Listing Date'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lblListingPrice: TLabel
    Left = 81
    Top = 75
    Width = 69
    Height = 17
    Caption = 'Listing Price'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lblPrevious: TLabel
    Left = 8
    Top = 161
    Width = 50
    Height = 34
    Alignment = taRightJustify
    Caption = 'Other Changes'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object bbtnCancel: TBitBtn
    Left = 417
    Top = 373
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
    TabOrder = 15
  end
  object bbtnOK: TBitBtn
    Left = 332
    Top = 373
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
    TabOrder = 14
    OnClick = bbtnOKClick
  end
  object rbYes: TRadioButton
    Left = 19
    Top = 16
    Width = 558
    Height = 17
    Hint = '2063'
    Caption = 
      'Yes, the subject is currently offered for sale or has been offer' +
      'ed for sale in the last 12 months.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = rbYesClick
  end
  object rbNo: TRadioButton
    Tag = 1
    Left = 19
    Top = 40
    Width = 526
    Height = 17
    Hint = '2064'
    Caption = 
      'No, the subject is not currently listed, nor has it been offered' +
      ' in the last 12 months.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = rbNoClick
  end
  object edtLastListPrice: TEdit
    Left = 64
    Top = 129
    Width = 106
    Height = 25
    Hint = 'Latest Price '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    MaxLength = 9
    ParentFont = False
    TabOrder = 4
    OnExit = FormatPriceOnExit
    OnKeyPress = OnlyPositiveKeyPress
  end
  object dtpLastListDate: TDateTimePicker
    Tag = 1
    Left = 190
    Top = 129
    Width = 100
    Height = 25
    Hint = 'Latest Date '
    Date = 40542.457355509260000000
    Time = 40542.457355509260000000
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object edtOrigListPrice: TEdit
    Tag = 7
    Left = 65
    Top = 96
    Width = 104
    Height = 25
    Hint = 'Original Price '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    MaxLength = 9
    ParentFont = False
    TabOrder = 2
    OnExit = FormatPriceOnExit
    OnKeyPress = OnlyPositiveKeyPress
  end
  object dtpOrigListDate: TDateTimePicker
    Tag = 8
    Left = 190
    Top = 96
    Width = 100
    Height = 25
    Hint = 'Original Date '
    Date = 40542.457355509260000000
    Time = 40542.457355509260000000
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object bbtnAddPriListings: TBitBtn
    Left = 304
    Top = 160
    Width = 33
    Height = 25
    Caption = '&Add'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    OnClick = bbtnAddPriListingsClick
  end
  object edtAddPriListPrice: TEdit
    Left = 65
    Top = 163
    Width = 104
    Height = 25
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    MaxLength = 9
    ParentFont = False
    TabOrder = 6
    OnChange = edtAddPriListPriceChange
    OnExit = FormatPriceOnExit
    OnKeyPress = edtAddPriListPriceKeyPress
  end
  object dtpAddPriListDate: TDateTimePicker
    Left = 190
    Top = 163
    Width = 100
    Height = 25
    Date = 40542.457355509260000000
    Time = 40542.457355509260000000
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
  end
  object lbPriListings: TListBox
    Tag = 9
    Left = 16
    Top = 228
    Width = 289
    Height = 85
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ItemHeight = 17
    Items.Strings = (
      '99/99/9999 999,999,999 '
      '99/99/9999 999,999,999 '
      '99/99/9999 999,999,999 '
      '99/99/9999 999,999,999 '
      '99/99/9999 999,999,999 '
      '99/99/9999 999,999,999 '
      '99/99/9999 999,999,999 '
      '99/99/9999 999,999,999 '
      '99/99/9999 999,999,999 ')
    ParentFont = False
    TabOrder = 18
    OnClick = lbPriListingsClick
  end
  object bbtnDelPriListings: TBitBtn
    Left = 73
    Top = 328
    Width = 109
    Height = 25
    Caption = 'D&elete Listing'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 19
    OnClick = bbtnDelPriListingsClick
  end
  object edtDOM: TEdit
    Tag = 4408
    Left = 348
    Top = 95
    Width = 41
    Height = 25
    Hint = 'DOM '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    MaxLength = 4
    ParentFont = False
    TabOrder = 9
    OnKeyPress = edtDOMKeyPress
  end
  object cbDOMUnk: TCheckBox
    Tag = 4
    Left = 348
    Top = 123
    Width = 121
    Height = 17
    Caption = 'DOM Unknown'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
    OnClick = cbDOMUnkClick
  end
  object lbDataSrcUsed: TListBox
    Tag = 10
    Left = 348
    Top = 228
    Width = 193
    Height = 94
    Hint = '2065'
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
      '999,999,999 99/99/9999'
      '999,999,999 99/99/9999'
      '999,999,999 99/99/9999'
      '999,999,999 99/99/9999'
      '999,999,999 99/99/9999'
      '999,999,999 99/99/9999'
      '999,999,999 99/99/9999')
    ParentFont = False
    Sorted = True
    TabOrder = 20
    OnClick = lbDataSrcUsedClick
    OnDblClick = lbDataSrcUsedDblClick
  end
  object xedtAddDataSrc: TAddictRichEdit
    Left = 95
    Top = 370
    Width = 113
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    HideSelection = False
    Lines.Strings = (
      'MLS'
      'NND'
      'LPS')
    ParentFont = False
    PlainText = True
    PopupMenu = mnuRspCmnts
    TabOrder = 12
    Visible = False
    WantReturns = False
    WordWrap = False
    OnExit = xedtAddDataSrcExit
    OnKeyPress = xedtAddDataSrcKeyPress
    LiveSpelling = True
    LiveCorrect = True
    LiveSpellingColor = clRed
    DoubleBuffered = True
    LiveSpellingOptions = True
    LiveMenuOptions = [spDialog, spAutoCorrect, spChangeAll, spAdd, spIgnoreAll, spIgnore, spReplace]
    LiveSpellingReadOnly = False
  end
  object bbtnAddDataSrc: TBitBtn
    Left = 544
    Top = 200
    Width = 33
    Height = 25
    Caption = 'A&dd'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 13
    OnClick = bbtnAddDataSrcClick
  end
  object bbtnDelDataSrc: TBitBtn
    Left = 348
    Top = 328
    Width = 117
    Height = 25
    Caption = 'De&lete Source'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 21
    OnClick = bbtnDelDataSrcClick
  end
  object cbFSBO: TCheckBox
    Tag = 2
    Left = 348
    Top = 148
    Width = 197
    Height = 17
    Hint = '2065'
    Caption = 'Property is For Sale by Owner'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 11
  end
  object bbtnHelp: TBitBtn
    Left = 502
    Top = 373
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
    TabOrder = 16
    OnClick = bbtnHelpClick
  end
  object bbtnClear: TBitBtn
    Left = 8
    Top = 373
    Width = 70
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'C&lear'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 17
    OnClick = bbtnClearClick
  end
  object cbxDataSrc: TComboBox
    Left = 348
    Top = 204
    Width = 195
    Height = 21
    Hint = '2065'
    AutoDropDown = True
    Style = csSimple
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ItemHeight = 17
    ParentFont = False
    Sorted = True
    TabOrder = 22
    OnChange = cbxDataSrcChange
    OnCloseUp = cbxDataSrcCloseUp
    OnEnter = cbxDataSrcEnter
    OnExit = cbxDataSrcExit
    OnKeyPress = cbxDataSrcKeyPress
  end
  object mnuRspCmnts: TPopupMenu
    OnPopup = mnuRspCmntsPopup
    Left = 248
    Top = 337
    object pmnuCopy: TMenuItem
      Caption = '&Copy'
      ShortCut = 16451
      OnClick = pmnuCopyClick
    end
    object pmnuCut: TMenuItem
      Caption = 'Cu&t'
      ShortCut = 16472
      OnClick = pmnuCutClick
    end
    object pmnuPaste: TMenuItem
      Caption = '&Paste'
      ShortCut = 16470
      OnClick = pmnuPasteClick
    end
    object pmnuSelectAll: TMenuItem
      Caption = 'Select &All'
      ShortCut = 16449
      OnClick = pmnuSelectAllClick
    end
    object pmnuLine1: TMenuItem
      Caption = '-'
    end
    object pmnuSaveCmnt: TMenuItem
      Caption = '&Save as Comment'
      OnClick = OnSaveCommentExecute
    end
    object pmnuLine2: TMenuItem
      Caption = '-'
    end
  end
end
