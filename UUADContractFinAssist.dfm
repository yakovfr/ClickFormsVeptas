object dlgUADContractFinAssist: TdlgUADContractFinAssist
  Left = 625
  Top = 157
  Width = 533
  Height = 500
  BorderIcons = []
  Caption = 'UAD: Financial Assistance'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object memItemsToBePaid: TAddictRichEdit
    Left = 0
    Top = 157
    Width = 525
    Height = 258
    Hint = '2057'
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
    OnChange = memItemsToBePaidChange
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
    Width = 525
    Height = 157
    Align = alTop
    TabOrder = 0
    object lblAssistanceAmount: TLabel
      Left = 104
      Top = 65
      Width = 233
      Height = 21
      AutoSize = False
      Caption = 'Financial Assistance Amount'
      FocusControl = AssistanceAmountControl
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lblItemsToBePaid: TLabel
      Left = 16
      Top = 132
      Width = 119
      Height = 17
      Caption = 'List items to be paid'
      FocusControl = memItemsToBePaid
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lblCharsRemaining: TLabel
      Left = 244
      Top = 132
      Width = 131
      Height = 17
      Caption = 'Characters Remaining '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object YesAssistanceControl: TRadioButton
      Left = 13
      Top = 8
      Width = 468
      Height = 21
      Hint = '2048'
      Caption = 
        '&Yes, there is financial assistance to be paid on behalf of the ' +
        'borrower.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = AssistanceExistsControlClick
    end
    object NoAssistanceControl: TRadioButton
      Left = 13
      Top = 33
      Width = 408
      Height = 21
      Hint = '2049'
      Caption = '&No, there is no financial assistance on behalf of the borrower.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = AssistanceExistsControlClick
    end
    object AssistanceAmountControl: TRzNumericEdit
      Left = 15
      Top = 64
      Width = 83
      Height = 25
      Hint = '4410'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      AllowBlank = True
      BlankValue = -1.000000000000000000
      CheckRange = True
      Max = 999999999.000000000000000000
      DisplayFormat = #39'$'#39',0;('#39'$'#39',0)'
    end
    object UnknownAssistanceControl: TCheckBox
      Left = 14
      Top = 96
      Width = 408
      Height = 21
      Hint = '4411'
      Caption = 
        'There is additional financial assistance but its amount is unkno' +
        'wn.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object stCharBal: TStaticText
      Left = 383
      Top = 130
      Width = 33
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
    Top = 415
    Width = 525
    Height = 54
    Align = alBottom
    TabOrder = 2
    DesignSize = (
      525
      54)
    object bbtnClear: TButton
      Left = 8
      Top = 17
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
      TabOrder = 0
      OnClick = bbtnClearClick
    end
    object bbtnSave: TButton
      Left = 265
      Top = 17
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
      OnClick = bbtnSaveClick
    end
    object bbtnCancel: TButton
      Left = 350
      Top = 17
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
    object bbtnHelp: TButton
      Left = 435
      Top = 17
      Width = 74
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
    Left = 456
    Top = 96
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
