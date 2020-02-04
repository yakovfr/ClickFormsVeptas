object RichHelpForm: TRichHelpForm
  Left = 518
  Top = 266
  Width = 566
  Height = 436
  ActiveControl = ButtonOK
  BorderIcons = [biSystemMenu]
  Caption = 'Help'
  Color = clBtnFace
  Constraints.MinHeight = 400
  Constraints.MinWidth = 300
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  PixelsPerInch = 96
  TextHeight = 13
  object PanelCaption: TPanel
    Left = 0
    Top = 0
    Width = 550
    Height = 57
    Align = alTop
    BevelOuter = bvNone
    BorderWidth = 8
    Color = clWhite
    Ctl3D = True
    ParentBackground = False
    ParentCtl3D = False
    TabOrder = 0
    object LabelCaption: TLabel
      Left = 15
      Top = 8
      Width = 322
      Height = 15
      AutoSize = False
      Caption = '%s Help'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object LabelDescription: TLabel
      Left = 30
      Top = 30
      Width = 291
      Height = 15
      AutoSize = False
      Caption = '%s'
      Transparent = True
    end
  end
  object PanelButtons: TPanel
    Left = 0
    Top = 365
    Width = 550
    Height = 35
    Align = alBottom
    BevelOuter = bvNone
    BorderWidth = 8
    TabOrder = 2
    DesignSize = (
      550
      35)
    object ButtonOK: TButton
      Left = 467
      Top = 3
      Width = 75
      Height = 25
      Action = ActionOK
      Anchors = [akRight, akBottom]
      Cancel = True
      TabOrder = 0
    end
  end
  object PanelHelp: TPanel
    Left = 0
    Top = 57
    Width = 550
    Height = 308
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 8
    TabOrder = 1
    object RichEditHelp: TRichEdit
      Left = 8
      Top = 8
      Width = 534
      Height = 292
      TabStop = False
      Align = alClient
      Ctl3D = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object ActionList: TActionList
    Left = 512
    Top = 8
    object ActionOK: TAction
      Caption = '&OK'
      OnExecute = ActionOKExecute
      OnUpdate = ActionOKUpdate
    end
  end
end
