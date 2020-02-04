object AMCDeliveryProcess: TAMCDeliveryProcess
  Left = 314
  Top = 128
  Width = 1067
  Height = 527
  Caption = 'Prepare Appraisal Order for Delivery '
  Color = clBtnFace
  Constraints.MinHeight = 120
  Constraints.MinWidth = 835
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1059
    Height = 41
    Align = alTop
    TabOrder = 0
    DesignSize = (
      1059
      41)
    object lblProcessName: TLabel
      Left = 16
      Top = 11
      Width = 91
      Height = 13
      Caption = 'lblProcessName'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btnNext: TButton
      Tag = 1
      Left = 862
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Next'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = MoveToNextProcess
    end
    object btnCancel: TButton
      Left = 958
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Cancel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnCancelClick
    end
    object btnPrev: TButton
      Tag = 2
      Left = 765
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Previous'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = MoveToPrevProcess
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 477
    Width = 1059
    Height = 19
    Panels = <>
  end
  object PgCntl: TPageControl
    Left = 0
    Top = 41
    Width = 1059
    Height = 436
    ActivePage = Step_SelectAMC
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object Step_SelectAMC: TTabSheet
      Caption = 'Step_SelectAMC'
    end
    object Step_UserID: TTabSheet
      Caption = 'Step_UserID'
    end
    object Step_PakSpec: TTabSheet
      Caption = 'Step_PakSpec'
    end
    object Step_SelectForms: TTabSheet
      Caption = 'Step_SelectForms'
    end
    object Step_OptImages: TTabSheet
      Caption = 'Step_OptImages'
    end
    object Step_EOReview: TTabSheet
      Caption = 'Step_EOReview'
    end
    object Step_BuildX241: TTabSheet
      Caption = 'Step_BuildX241'
    end
    object Step_BuildX26GSE: TTabSheet
      Caption = 'Step_BuildX26GSE'
    end
    object Step_BuildX26: TTabSheet
      Caption = 'Step_BuildX26'
    end
    object Step_PDSReview: TTabSheet
      Caption = 'Step_PDSReview'
    end
    object Step_BuildENV: TTabSheet
      Caption = 'Step_BuildENV'
    end
    object Step_BuildPDF: TTabSheet
      Caption = 'Step_BuildPDF'
    end
    object Step_DigitallySign: TTabSheet
      Caption = 'Step_DigitallySign'
    end
    object Step_SendPak: TTabSheet
      Caption = 'Step_SendPak'
    end
    object Step_SavePak: TTabSheet
      Caption = 'Step_SavePak'
    end
    object Step_AckSend: TTabSheet
      Caption = 'Step_AckSend'
    end
  end
  object ResizeAnimationTimer: TTimer
    Enabled = False
    Interval = 10
    OnTimer = ResizeAnimationTimerTimer
    Left = 52
    Top = 417
  end
end
