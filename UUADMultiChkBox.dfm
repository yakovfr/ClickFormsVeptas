object dlgUADMultiChkBox: TdlgUADMultiChkBox
  Left = 562
  Top = 155
  Width = 543
  Height = 475
  BorderIcons = []
  Caption = 'UAD: HOA Information'
  Color = clBtnFace
  Constraints.MinHeight = 475
  Constraints.MinWidth = 448
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object memText: TAddictRichEdit
    Left = 0
    Top = 133
    Width = 535
    Height = 258
    Hint = '830'
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Lines.Strings = (
      '')
    MaxLength = 200
    ParentFont = False
    PlainText = True
    PopupMenu = mnuRspCmnts
    ScrollBars = ssVertical
    TabOrder = 1
    OnChange = memTextChange
    LiveSpelling = True
    LiveCorrect = True
    LiveSpellingColor = clRed
    DoubleBuffered = True
    LiveSpellingOptions = True
    LiveMenuOptions = [spDialog, spAutoCorrect, spChangeAll, spAdd, spIgnoreAll, spIgnore, spReplace]
    LiveSpellingReadOnly = False
  end
  object topPanel: TPanel
    Left = 0
    Top = 0
    Width = 535
    Height = 133
    Align = alTop
    TabOrder = 0
    object lblComment: TLabel
      Left = 16
      Top = 113
      Width = 56
      Height = 17
      Caption = 'Comment'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lblCharsRemaining: TLabel
      Left = 246
      Top = 113
      Width = 131
      Height = 17
      Alignment = taRightJustify
      Caption = 'Characters Remaining '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object stHeading: TStaticText
      Left = 16
      Top = 12
      Width = 241
      Height = 21
      AutoSize = False
      BevelInner = bvNone
      BevelKind = bkSoft
      BevelOuter = bvNone
      Caption = 'Check all boxes that apply'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      TabOrder = 0
      Transparent = False
    end
    object cbOption1: TCheckBox
      Tag = 1
      Left = 32
      Top = 35
      Width = 185
      Height = 21
      Hint = '827'
      Caption = 'Homeowner'#39's Association'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = cbOption1Click
    end
    object cbOption2: TCheckBox
      Tag = 2
      Left = 32
      Top = 59
      Width = 185
      Height = 21
      Hint = '828'
      Caption = 'Developer'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = cbOption2Click
    end
    object cbOption3: TCheckBox
      Tag = 4
      Left = 32
      Top = 83
      Width = 185
      Height = 21
      Hint = '829'
      Caption = 'Management Agent'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = cbOption3Click
    end
    object stCharBal: TStaticText
      Left = 383
      Top = 110
      Width = 33
      Height = 21
      Alignment = taCenter
      AutoSize = False
      BevelKind = bkSoft
      Caption = '200'
      Color = clMoneyGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      TabOrder = 4
      Transparent = False
    end
  end
  object botPanel: TPanel
    Left = 0
    Top = 391
    Width = 535
    Height = 53
    Align = alBottom
    TabOrder = 2
    DesignSize = (
      535
      53)
    object bbtnClear: TBitBtn
      Left = 8
      Top = 16
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
      TabOrder = 0
      OnClick = bbtnClearClick
    end
    object bbtnOK: TBitBtn
      Left = 272
      Top = 16
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
    object bbtnCancel: TBitBtn
      Left = 357
      Top = 16
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
    object bbtnHelp: TBitBtn
      Left = 442
      Top = 16
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
  end
  object mnuRspCmnts: TPopupMenu
    OnPopup = mnuRspCmntsPopup
    Left = 400
    Top = 8
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
