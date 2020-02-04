object dlgUADContractAnalyze: TdlgUADContractAnalyze
  Left = 487
  Top = 124
  Width = 535
  Height = 450
  BorderIcons = []
  Caption = 'UAD: Sales Contract Analysis'
  Color = clBtnFace
  Constraints.MinHeight = 450
  Constraints.MinWidth = 500
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object topPanel: TPanel
    Left = 0
    Top = 0
    Width = 527
    Height = 145
    Align = alTop
    TabOrder = 0
    object lblSaleType: TLabel
      Left = 10
      Top = 94
      Width = 122
      Height = 17
      Alignment = taRightJustify
      Caption = 'Specify the Sale Type'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lblAnalysisCmt: TLabel
      Left = 16
      Top = 125
      Width = 134
      Height = 17
      Caption = 'Sale Analysis Comment'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lblCharsRemaining: TLabel
      Left = 255
      Top = 125
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
    object rbOption1: TRadioButton
      Left = 12
      Top = 16
      Width = 493
      Height = 16
      Hint = '2054'
      Caption = 
        'I did analyze the contract for sale for the subject purchase tra' +
        'nsaction'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = OptionClick
    end
    object rbOption2: TRadioButton
      Left = 12
      Top = 39
      Width = 493
      Height = 17
      Hint = '2055'
      Caption = 
        'I did NOT analyze the contract for sale for the subject purchase' +
        ' transaction'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = OptionClick
    end
    object rbOption3: TRadioButton
      Left = 12
      Top = 63
      Width = 203
      Height = 16
      Caption = 'Not a Purchase Transaction'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = OptionClick
    end
    object cbSaleType: TComboBox
      Left = 140
      Top = 93
      Width = 165
      Height = 25
      Hint = '4409'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ItemHeight = 17
      ParentFont = False
      TabOrder = 3
      Items.Strings = (
        'REO sale'
        'Short sale'
        'Court ordered sale'
        'Estate sale'
        'Relocation sale'
        'Non-arms length sale'
        'Arms length sale')
    end
    object stCharBal: TStaticText
      Left = 399
      Top = 123
      Width = 30
      Height = 21
      Alignment = taCenter
      AutoSize = False
      BevelKind = bkSoft
      Caption = '4000'
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
    Top = 371
    Width = 527
    Height = 48
    Align = alBottom
    TabOrder = 2
    DesignSize = (
      527
      48)
    object bbtnClear: TButton
      Left = 7
      Top = 14
      Width = 70
      Height = 23
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
      Left = 237
      Top = 12
      Width = 74
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
      Left = 320
      Top = 12
      Width = 74
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
      Left = 398
      Top = 12
      Width = 73
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
  object memAnalysis: TAddictRichEdit
    Left = 0
    Top = 145
    Width = 527
    Height = 226
    Hint = '2056'
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    Lines.Strings = (
      '')
    MaxLength = 4000
    ParentFont = False
    PlainText = True
    PopupMenu = mnuRspCmnts
    ScrollBars = ssVertical
    TabOrder = 1
    OnChange = memAnalysisChange
    LiveSpelling = True
    LiveCorrect = True
    LiveSpellingColor = clRed
    DoubleBuffered = True
    LiveSpellingOptions = True
    LiveMenuOptions = [spDialog, spAutoCorrect, spChangeAll, spAdd, spIgnoreAll, spIgnore, spReplace]
    LiveSpellingReadOnly = False
  end
  object mnuRspCmnts: TPopupMenu
    OnPopup = mnuRspCmntsPopup
    Left = 416
    Top = 64
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
