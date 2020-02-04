object LicenseForm: TLicenseForm
  Left = 679
  Top = 199
  ActiveControl = RichEditLicense
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'License Agreement'
  ClientHeight = 400
  ClientWidth = 550
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
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
      Caption = '%s License Agreement'
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
      Caption = 'You must accept the license agreement to proceed.'
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
    object ButtonPrint: TButton
      Left = 8
      Top = 0
      Width = 75
      Height = 25
      Action = ActionPrint
      TabOrder = 0
    end
    object ButtonOK: TButton
      Left = 387
      Top = 0
      Width = 75
      Height = 25
      Action = ActionOK
      TabOrder = 1
    end
    object ButtonCancel: TButton
      Left = 467
      Top = 0
      Width = 75
      Height = 25
      Action = ActionCancel
      TabOrder = 2
    end
  end
  object PanelLicense: TPanel
    Left = 0
    Top = 57
    Width = 550
    Height = 308
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 8
    TabOrder = 1
    object RichEditLicense: TRichEdit
      Left = 8
      Top = 8
      Width = 534
      Height = 240
      Align = alClient
      Ctl3D = True
      ParentCtl3D = False
      PopupMenu = PopupMenuLicense
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
    object PanelAcceptance: TPanel
      Left = 8
      Top = 248
      Width = 534
      Height = 52
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object RadioButtonAccept: TRadioButton
        Left = 15
        Top = 8
        Width = 320
        Height = 17
        Caption = 'I accept the terms and conditions as stated above.'
        TabOrder = 0
      end
      object RadioButtonDecline: TRadioButton
        Left = 15
        Top = 30
        Width = 320
        Height = 17
        Caption = 'I do not accept the terms and conditions as stated above.'
        TabOrder = 1
      end
    end
  end
  object ActionList: TActionList
    Left = 512
    Top = 8
    object ActionPrint: TAction
      Caption = '&Print'
      ShortCut = 16464
      OnExecute = ActionPrintExecute
      OnUpdate = ActionPrintUpdate
    end
    object ActionOK: TAction
      Caption = '&OK'
      OnExecute = ActionOKExecute
      OnUpdate = ActionOKUpdate
    end
    object ActionCancel: TAction
      Caption = '&Cancel'
      OnExecute = ActionCancelExecute
      OnUpdate = ActionCancelUpdate
    end
    object ActionSelectAll: TAction
      Caption = '&Select All'
      ShortCut = 16449
      OnExecute = ActionSelectAllExecute
      OnUpdate = ActionSelectAllUpdate
    end
    object ActionCopy: TAction
      Caption = 'Cop&y'
      ShortCut = 16451
      OnExecute = ActionCopyExecute
      OnUpdate = ActionCopyUpdate
    end
  end
  object PopupMenuLicense: TPopupMenu
    Left = 480
    Top = 8
    object MenuItemCopy: TMenuItem
      Action = ActionCopy
    end
    object MenuItemSeparatorBar2: TMenuItem
      Caption = '-'
    end
    object MenuItemSelectAll: TMenuItem
      Action = ActionSelectAll
    end
    object MenuItemSeparatorBar1: TMenuItem
      Caption = '-'
    end
    object MenuItemPrint: TMenuItem
      Action = ActionPrint
    end
  end
  object PrintDialog: TPrintDialog
    Left = 448
    Top = 8
  end
end
