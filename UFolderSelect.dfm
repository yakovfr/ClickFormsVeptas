object SelectFiles: TSelectFiles
  Left = 278
  Top = 178
  Width = 699
  Height = 250
  BorderIcons = [biSystemMenu]
  Caption = 'Select Image Files to Load'
  Color = clBtnFace
  Constraints.MinHeight = 250
  Constraints.MinWidth = 604
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    683
    214)
  PixelsPerInch = 96
  TextHeight = 16
  object StatusBar1: TStatusBar
    Left = 0
    Top = 195
    Width = 683
    Height = 19
    Panels = <>
  end
  object RzShellList: TRzShellList
    Left = 208
    Top = 48
    Width = 480
    Height = 153
    Anchors = [akLeft, akTop, akRight, akBottom]
    IconOptions.AutoArrange = True
    TabOrder = 1
  end
  object RzShellTree: TRzShellTree
    Left = 0
    Top = 0
    Width = 201
    Height = 195
    Align = alLeft
    Indent = 19
    ShellList = RzShellList
    TabOrder = 2
  end
  object Panel1: TPanel
    Left = 200
    Top = -1
    Width = 488
    Height = 49
    Anchors = [akLeft, akTop, akRight]
    BevelOuter = bvNone
    TabOrder = 3
    DesignSize = (
      488
      49)
    object btnOK: TButton
      Left = 315
      Top = 12
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Ok'
      ModalResult = 1
      TabOrder = 0
    end
    object btnCancel: TButton
      Left = 403
      Top = 12
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
    object cbxShowList: TCheckBox
      Left = 142
      Top = 16
      Width = 74
      Height = 17
      Caption = 'List View'
      TabOrder = 2
      OnClick = cbxShowListClick
    end
    object rdoLoadAll: TRadioButton
      Left = 17
      Top = 8
      Width = 117
      Height = 17
      Caption = 'Load All Images'
      TabOrder = 3
      OnClick = rdoLoadAllClick
    end
    object rdoManualSelect: TRadioButton
      Left = 17
      Top = 27
      Width = 117
      Height = 17
      Caption = 'Manually Select'
      TabOrder = 4
      OnClick = rdoManualSelectClick
    end
  end
end
