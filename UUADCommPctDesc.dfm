object dlgUADCommPctDesc: TdlgUADCommPctDesc
  Left = 616
  Top = 172
  Width = 548
  Height = 400
  BorderIcons = []
  Caption = 'UAD: Project Description'
  Color = clBtnFace
  Constraints.MinHeight = 400
  Constraints.MinWidth = 434
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object memDesc: TAddictRichEdit
    Left = 0
    Top = 97
    Width = 540
    Height = 222
    Hint = '2116'
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
    OnChange = memDescChange
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
    Width = 540
    Height = 97
    Align = alTop
    TabOrder = 0
    object lblCommYN: TLabel
      Left = 15
      Top = 15
      Width = 266
      Height = 21
      AutoSize = False
      Caption = 'Is there any commercial space in the project?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lblPercent: TLabel
      Left = 15
      Top = 44
      Width = 65
      Height = 17
      Caption = 'Percentage'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lblDesc: TLabel
      Left = 15
      Top = 77
      Width = 121
      Height = 17
      Caption = 'Description of Space'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lblCharsRemaining: TLabel
      Left = 228
      Top = 76
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
    object rbYes: TRadioButton
      Left = 290
      Top = 15
      Width = 48
      Height = 21
      Hint = '2119'
      Caption = 'Yes'
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
      Left = 348
      Top = 15
      Width = 46
      Height = 21
      Hint = '2120'
      Caption = 'No'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = rbNoClick
    end
    object rzsePercent: TRzSpinEdit
      Left = 87
      Top = 41
      Width = 66
      Height = 25
      Hint = '4416'
      AllowKeyEdit = True
      Max = 99.000000000000000000
      Value = 99.000000000000000000
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object stCharBal: TStaticText
      Left = 371
      Top = 74
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
      TabOrder = 3
      Transparent = False
    end
  end
  object botPanel: TPanel
    Left = 0
    Top = 319
    Width = 540
    Height = 50
    Align = alBottom
    TabOrder = 2
    DesignSize = (
      540
      50)
    object bbtnClear: TBitBtn
      Left = 8
      Top = 13
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
    object bbtnOK: TBitBtn
      Left = 277
      Top = 13
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
      Left = 362
      Top = 13
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
      Left = 447
      Top = 13
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
    Left = 472
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
