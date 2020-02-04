object Main: TMain
  Left = 228
  Top = 51
  Width = 1288
  Height = 773
  Caption = 'ClickFORMS'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu
  OldCreateOrder = False
  Position = poDefault
  ShowHint = True
  WindowState = wsMaximized
  WindowMenu = WindowMenu
  OnClose = MainClose
  OnCreate = MainCreate
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TStatusBar
    Left = 0
    Top = 695
    Width = 1272
    Height = 19
    AutoHint = True
    Panels = <>
  end
  object ToolBarDock: TAdvDockPanel
    Left = 0
    Top = 0
    Width = 1272
    Height = 59
    MinimumSize = 3
    LockHeight = False
    Persistence.Location = plRegistry
    Persistence.Key = '\Software\Bradford\Clickforms2\Toolbars'
    Persistence.Section = 'TopToolbar'
    Persistence.Enabled = True
    ToolBarStyler = ToolBarStyle
    UseRunTimeHeight = True
    Version = '2.6.0.0'
    object FileMenuToolBar: TAdvToolBar
      Left = 3
      Top = 1
      Width = 203
      Height = 26
      AllowFloating = False
      AutoDockOnClose = True
      Caption = 'File Menu'
      CaptionFont.Charset = DEFAULT_CHARSET
      CaptionFont.Color = clWindowText
      CaptionFont.Height = -11
      CaptionFont.Name = 'MS Sans Serif'
      CaptionFont.Style = []
      CompactImageIndex = -1
      ShowOptionIndicator = False
      TextAutoOptionMenu = 'Add or Remove Buttons'
      TextOptionMenu = 'Options'
      ToolBarStyler = ToolBarStyle
      Images = MainImages
      ParentOptionPicture = True
      ToolBarIndex = -1
      object FileMenuToolBarSeparator1: TAdvToolBarSeparator
        Left = 110
        Top = 2
        Width = 10
        Height = 22
        LineColor = clBtnShadow
      end
      object tbtnStartTemps: TAdvGlowButton
        Left = 32
        Top = 2
        Width = 32
        Height = 22
        Hint = 'Template List (Cntl-N)'
        Caption = 'Template List'
        ImageIndex = 32
        Images = MainImages
        ShowCaption = False
        Transparent = True
        TabOrder = 0
        OnClick = NewTemplateClick
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
        DropDownButton = True
        DropDownMenu = PopupStartTemps
      end
      object tbtnFileOpen: TAdvGlowButton
        Left = 64
        Top = 2
        Width = 23
        Height = 22
        Action = FileOpenCmd
        ImageIndex = 2
        Images = MainImages
        ShowCaption = False
        Transparent = True
        TabOrder = 1
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
      end
      object tbtnFileClose: TAdvGlowButton
        Left = 87
        Top = 2
        Width = 23
        Height = 22
        Action = FileCloseCmd
        ImageIndex = 15
        Images = MainImages
        ShowCaption = False
        Transparent = True
        TabOrder = 2
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
      end
      object tbtnFileSave: TAdvGlowButton
        Left = 120
        Top = 2
        Width = 23
        Height = 22
        Hint = 'Save File'
        Action = FileSaveCmd
        ImageIndex = 3
        Images = MainImages
        ShowCaption = False
        Transparent = True
        TabOrder = 3
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
      end
      object tbtnFilePrint: TAdvGlowButton
        Left = 143
        Top = 2
        Width = 23
        Height = 22
        Action = FilePrintCmd
        ImageIndex = 4
        Images = MainImages
        ShowCaption = False
        Transparent = True
        TabOrder = 4
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
      end
      object tbtnFileNew: TAdvGlowButton
        Left = 9
        Top = 2
        Width = 23
        Height = 22
        Action = FileNewCmd
        ImageIndex = 1
        Images = MainImages
        ShowCaption = False
        Transparent = True
        TabOrder = 5
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
      end
      object tbtnCreatePDF: TAdvGlowButton
        Left = 166
        Top = 2
        Width = 23
        Height = 22
        Action = FileCreatePDFCmd
        ImageIndex = 122
        Images = MainImages
        ShowCaption = False
        Transparent = True
        TabOrder = 6
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
      end
    end
    object EditMenuToolBar: TAdvToolBar
      Left = 208
      Top = 1
      Width = 92
      Height = 26
      AllowFloating = False
      AutoDockOnClose = True
      Caption = 'Edit Menu'
      CaptionFont.Charset = DEFAULT_CHARSET
      CaptionFont.Color = clWindowText
      CaptionFont.Height = -11
      CaptionFont.Name = 'MS Sans Serif'
      CaptionFont.Style = []
      CompactImageIndex = -1
      ShowOptionIndicator = False
      TextAutoOptionMenu = 'Add or Remove Buttons'
      TextOptionMenu = 'Options'
      ToolBarStyler = ToolBarStyle
      Images = MainImages
      ParentOptionPicture = True
      ToolBarIndex = -1
      object tbtnEditCut: TAdvGlowButton
        Left = 9
        Top = 2
        Width = 23
        Height = 22
        Action = EditCutCmd
        ImageIndex = 6
        Images = MainImages
        FocusType = ftHot
        ShowCaption = False
        Transparent = True
        TabOrder = 0
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
      end
      object tbtnEditCopy: TAdvGlowButton
        Left = 32
        Top = 2
        Width = 23
        Height = 22
        Action = EditCopyCmd
        ImageIndex = 7
        Images = MainImages
        ShowCaption = False
        Transparent = True
        TabOrder = 1
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
      end
      object tbtnEditPaste: TAdvGlowButton
        Left = 55
        Top = 2
        Width = 23
        Height = 22
        Action = EditPasteCmd
        ImageIndex = 8
        Images = MainImages
        ShowCaption = False
        Transparent = True
        TabOrder = 2
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
      end
    end
    object FormattingToolBar: TAdvToolBar
      Left = 302
      Top = 1
      Width = 228
      Height = 26
      AllowFloating = False
      AutoDockOnClose = True
      Caption = 'Formatting'
      CaptionFont.Charset = DEFAULT_CHARSET
      CaptionFont.Color = clWindowText
      CaptionFont.Height = -11
      CaptionFont.Name = 'MS Sans Serif'
      CaptionFont.Style = []
      CompactImageIndex = -1
      ShowOptionIndicator = False
      TextAutoOptionMenu = 'Add or Remove Buttons'
      TextOptionMenu = 'Options'
      ToolBarStyler = ToolBarStyle
      Images = MainImages
      ParentOptionPicture = True
      ToolBarIndex = -1
      object FormattingToolBarSeparator1: TAdvToolBarSeparator
        Left = 78
        Top = 2
        Width = 10
        Height = 22
        LineColor = clBtnShadow
      end
      object FormattingToolBarSeparator2: TAdvToolBarSeparator
        Left = 134
        Top = 2
        Width = 10
        Height = 22
        LineColor = clBtnShadow
      end
      object tbtnAlignLeft: TAdvGlowButton
        Left = 9
        Top = 2
        Width = 23
        Height = 22
        Action = EditTxLeftCmd
        ImageIndex = 12
        Images = MainImages
        FocusType = ftHot
        ShowCaption = False
        Transparent = True
        TabOrder = 0
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
        Style = bsCheck
      end
      object tbtnAlignCntr: TAdvGlowButton
        Left = 32
        Top = 2
        Width = 23
        Height = 22
        Action = EditTxCntrCmd
        ImageIndex = 13
        Images = MainImages
        ShowCaption = False
        Transparent = True
        TabOrder = 1
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
        Style = bsCheck
      end
      object tbtnAlignRight: TAdvGlowButton
        Left = 55
        Top = 2
        Width = 23
        Height = 22
        Action = EditTxRightCmd
        ImageIndex = 14
        Images = MainImages
        ShowCaption = False
        Transparent = True
        TabOrder = 2
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
        Style = bsCheck
      end
      object tbtnFontBigger: TAdvGlowButton
        Left = 88
        Top = 2
        Width = 23
        Height = 22
        Action = EditTxIncreaseCmd
        ImageIndex = 21
        Images = MainImages
        ShowCaption = False
        Transparent = True
        TabOrder = 3
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
      end
      object tbtnFontSmaller: TAdvGlowButton
        Left = 111
        Top = 2
        Width = 23
        Height = 22
        Action = EditTxDecreaseCmd
        ImageIndex = 22
        Images = MainImages
        ShowCaption = False
        Transparent = True
        TabOrder = 4
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
      end
      object tbtnStyleBold: TAdvGlowButton
        Left = 144
        Top = 2
        Width = 23
        Height = 22
        Action = EditTxBoldCmd
        ImageIndex = 9
        Images = MainImages
        ShowCaption = False
        Transparent = True
        TabOrder = 5
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
        Style = bsCheck
      end
      object tbtnStyleItalic: TAdvGlowButton
        Left = 167
        Top = 2
        Width = 26
        Height = 22
        Action = EditTxItalicCmd
        ImageIndex = 10
        Images = MainImages
        ShowCaption = False
        Transparent = True
        TabOrder = 6
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
        Style = bsCheck
      end
      object tbtnStyleUnderLine: TAdvGlowButton
        Left = 193
        Top = 2
        Width = 21
        Height = 22
        Action = EditTxUnderLnCmd
        ImageIndex = 208
        Images = MainImages
        ShowCaption = False
        Transparent = True
        TabOrder = 7
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
        Style = bsCheck
      end
    end
    object DisplayToolBar: TAdvToolBar
      Left = 532
      Top = 1
      Width = 141
      Height = 26
      AllowFloating = False
      AutoDockOnClose = True
      Caption = 'Display'
      CaptionFont.Charset = DEFAULT_CHARSET
      CaptionFont.Color = clWindowText
      CaptionFont.Height = -11
      CaptionFont.Name = 'MS Sans Serif'
      CaptionFont.Style = []
      CompactImageIndex = -1
      ShowOptionIndicator = False
      TextAutoOptionMenu = 'Add or Remove Buttons'
      TextOptionMenu = 'Options'
      ToolBarStyler = ToolBarStyle
      Images = MainImages
      ParentOptionPicture = True
      ToolBarIndex = -1
      object DisplayToolbarSeparator1: TAdvToolBarSeparator
        Left = 78
        Top = 2
        Width = 10
        Height = 22
        LineColor = clBtnShadow
      end
      object tbtnZoomText: TLabel
        Left = 88
        Top = 2
        Width = 23
        Height = 22
        Hint = 'Display Scale'
        Alignment = taCenter
        AutoSize = False
        Caption = '100'
        Transparent = True
        Layout = tlCenter
      end
      object tbtnGoToListToggle: TAdvGlowButton
        Left = 9
        Top = 2
        Width = 23
        Height = 22
        Action = ViewToglGoToListCmd
        ImageIndex = 30
        Images = MainImages
        FocusType = ftHot
        Rounded = False
        ShowCaption = False
        Transparent = True
        TabOrder = 0
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
      end
      object tbtnListForms: TAdvGlowButton
        Left = 55
        Top = 2
        Width = 23
        Height = 22
        Action = FormsLibraryCmd
        ImageIndex = 0
        Images = MainImages
        ShowCaption = False
        Transparent = True
        TabOrder = 2
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
      end
      object tbtnZoomUpDn2: TRzSpinButtons
        Left = 111
        Top = 2
        Width = 16
        Height = 22
        Hint = 'Set Display Scale (Up and Down)'
        Color = 15195349
        Flat = True
        OnDownLeftClick = tbtnZoomUpDn2DownLeftClick
        OnUpRightClick = tbtnZoomUpDn2UpRightClick
        ParentColor = False
        TabOrder = 3
      end
      object tbtnPageNavigator: TAdvGlowButton
        Left = 32
        Top = 2
        Width = 23
        Height = 22
        Action = GoToPageNavigatorCmd
        ImageIndex = 209
        Images = MainImages
        ShowCaption = False
        Transparent = True
        TabOrder = 1
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
        Style = bsCheck
      end
    end
    object WorkFlowToolBar: TAdvToolBar
      Left = 3
      Top = 30
      Width = 587
      Height = 26
      AllowFloating = False
      AutoDockOnClose = True
      AutoOptionMenu = True
      Caption = 'Workflow'
      CaptionFont.Charset = DEFAULT_CHARSET
      CaptionFont.Color = clWindowText
      CaptionFont.Height = -11
      CaptionFont.Name = 'MS Sans Serif'
      CaptionFont.Style = []
      CompactImageIndex = -1
      TextAutoOptionMenu = 'Add or Remove Buttons'
      TextOptionMenu = 'Options'
      ToolBarStyler = ToolBarStyle
      Images = MainImages
      ParentOptionPicture = True
      ToolBarIndex = -1
      object WorkFlowToolBarSeparator2: TAdvToolBarSeparator
        Left = 327
        Top = 2
        Width = 10
        Height = 22
        LineColor = clBtnShadow
      end
      object WorkFlowToolBarSeparator4: TAdvToolBarSeparator
        Left = 439
        Top = 2
        Width = 10
        Height = 22
        LineColor = clBtnShadow
      end
      object WorkFlowToolBarSeparator3: TAdvToolBarSeparator
        Left = 360
        Top = 2
        Width = 10
        Height = 22
        LineColor = clBtnShadow
      end
      object WorkFlowToolBarSeparator1: TAdvToolBarSeparator
        Left = 179
        Top = 2
        Width = 10
        Height = 22
        LineColor = clBtnShadow
      end
      object tbtnSpell: TAdvGlowButton
        Left = 472
        Top = 2
        Width = 23
        Height = 22
        Action = ToolSpellCmd
        ImageIndex = 153
        Images = MainImages
        FocusType = ftHot
        ShowCaption = False
        Transparent = True
        TabOrder = 0
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
      end
      object tbtnSignatures: TAdvGlowButton
        Left = 518
        Top = 2
        Width = 23
        Height = 22
        Action = ToolSignatureCmd
        ImageIndex = 152
        Images = MainImages
        ShowCaption = False
        Transparent = True
        TabOrder = 1
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
      end
      object tbtnInsertFromPDF: TAdvGlowButton
        Left = 393
        Top = 2
        Width = 23
        Height = 22
        Action = InsertPDFCmd
        ImageIndex = 162
        Images = MainImages
        ShowCaption = False
        Transparent = True
        TabOrder = 2
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
      end
      object tbtnImageEditor: TAdvGlowButton
        Left = 449
        Top = 2
        Width = 23
        Height = 22
        Action = ToolImageEditorCmd
        ImageIndex = 164
        Images = MainImages
        ShowCaption = False
        Transparent = True
        TabOrder = 3
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
      end
      object tbtnPhotoSheet: TAdvGlowButton
        Left = 370
        Top = 2
        Width = 23
        Height = 22
        Action = ToolPhotoSheetCmd
        ImageIndex = 125
        Images = MainImages
        ShowCaption = False
        Transparent = True
        TabOrder = 4
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
      end
      object tbtnAutoAdjust: TAdvGlowButton
        Left = 189
        Top = 2
        Width = 23
        Height = 22
        Action = ToolAutoAdjustCmd
        ImageIndex = 142
        Images = MainImages
        ShowCaption = False
        Transparent = True
        TabOrder = 5
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
      end
      object tbtnCompEditor: TAdvGlowButton
        Left = 212
        Top = 2
        Width = 23
        Height = 22
        Action = ToolCompEditorCmd
        ImageIndex = 145
        Images = MainImages
        ShowCaption = False
        Transparent = True
        TabOrder = 6
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
      end
      object tbtnReviewer: TAdvGlowButton
        Left = 495
        Top = 2
        Width = 23
        Height = 22
        Action = ToolReviewerCmd
        ImageIndex = 151
        Images = MainImages
        ShowCaption = False
        Transparent = True
        TabOrder = 7
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
      end
      object tbtnStartDataBase: TAdvGlowButton
        Tag = 4
        Left = 9
        Top = 2
        Width = 32
        Height = 22
        Hint = 'Shows Comparables List'
        Caption = 'Databases'
        ImageIndex = 49
        Images = MainImages
        ShowCaption = False
        Transparent = True
        TabOrder = 8
        OnClick = ListCmdPreExecute
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
        DropDownButton = True
        DropDownMenu = PopupDatabases
      end
      object tbtnImportPropData: TAdvGlowButton
        Tag = 34
        Left = 156
        Top = 2
        Width = 23
        Height = 22
        Hint = 'Import Property Data'
        Caption = 'Import Property Data'
        ImageIndex = 161
        Images = MainImages
        ShowCaption = False
        Transparent = True
        TabOrder = 9
        OnClick = FileImportExecute
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
      end
      object tbtnSendOrders: TAdvGlowButton
        Left = 541
        Top = 2
        Width = 32
        Height = 22
        Hint = 'Send Completed Report...'
        Caption = 'Send Report...'
        ImageIndex = 156
        Images = MainImages
        PopupMenu = PopUpSendOrders
        ShowCaption = False
        Transparent = True
        TabOrder = 10
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
        DropDownButton = True
        DropDownMenu = PopUpSendOrders
      end
      object tbtnStartDatalog: TAdvGlowButton
        Left = 87
        Top = 28
        Width = 23
        Height = 22
        Hint = 'Launch UAAR DataLog'
        Caption = 'Launch UAAR DataLog'
        ImageIndex = 64
        Images = MainImages
        ShowCaption = False
        Transparent = True
        TabOrder = 11
        Visible = False
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
      end
      object tbtnImportMLS: TAdvGlowButton
        Tag = 42
        Left = 110
        Top = 2
        Width = 23
        Height = 22
        Hint = 'Data Import Wizard'
        Caption = 'Data Import Wizard'
        ImageIndex = 229
        Images = MainImages
        FocusType = ftHot
        ShowCaption = False
        Transparent = True
        TabOrder = 12
        OnClick = FileImportExecute
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
        Style = bsCheck
      end
      object tbtnInsertImage: TAdvGlowButton
        Left = 416
        Top = 2
        Width = 23
        Height = 22
        Hint = 'Insert Image from File'
        Action = InsertFileImageCmd
        ImageIndex = 163
        Images = MainImages
        ShowCaption = False
        Transparent = True
        TabOrder = 13
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
      end
      object tbtnCensusTract: TAdvGlowButton
        Left = 87
        Top = 2
        Width = 23
        Height = 22
        Action = ServiceGetCensusTractCmd
        ImageIndex = 143
        Images = MainImages
        FocusType = ftHot
        ShowCaption = False
        Transparent = True
        TabOrder = 14
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
      end
      object tbtnLocationMap: TAdvGlowButton
        Left = 235
        Top = 2
        Width = 23
        Height = 22
        Action = ServiceLocMapCmd
        ImageIndex = 148
        Images = MainImages
        FocusType = ftHot
        ShowCaption = False
        Transparent = True
        TabOrder = 15
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
      end
      object tbtnFloodMap: TAdvGlowButton
        Left = 64
        Top = 2
        Width = 23
        Height = 22
        Action = ServiceFloodInsightCmd
        ImageIndex = 146
        Images = MainImages
        FocusType = ftHot
        ShowCaption = False
        Transparent = True
        TabOrder = 17
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
      end
      object tbtnSwiftEstimator: TAdvGlowButton
        Left = 337
        Top = 2
        Width = 23
        Height = 22
        Action = ServiceMarshallandSwiftCmd
        ImageIndex = 144
        Images = MainImages
        FocusType = ftHot
        ShowCaption = False
        Transparent = True
        TabOrder = 18
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
      end
      object tbtnPlugIn7: TAdvGlowButton
        Left = 281
        Top = 2
        Width = 23
        Height = 22
        Action = ToolAreaSketchCmd
        ImageIndex = 133
        Images = MainImages
        ShowCaption = False
        Transparent = True
        TabOrder = 19
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
      end
      object tbtnAppraisalWorld: TAdvGlowButton
        Left = 41
        Top = 2
        Width = 23
        Height = 22
        Hint = 'Go to AppraisalWorld'
        Caption = 'Go to  AppraisalWorld'
        ImageIndex = 167
        Images = MainImages
        FocusType = ftHot
        ShowCaption = False
        Transparent = True
        TabOrder = 20
        OnClick = tbtnAppraisalWorldClick
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
      end
      object tbtnMarketAnalysis: TAdvGlowButton
        Left = 133
        Top = 2
        Width = 23
        Height = 22
        Action = ServiceMarketAnalysis
        ImageIndex = 205
        Images = MainImages
        FocusType = ftHot
        ShowCaption = False
        Transparent = True
        TabOrder = 21
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
      end
      object tbtnPictometry: TAdvGlowButton
        Left = 258
        Top = 2
        Width = 23
        Height = 22
        Action = ServicePictometryCmd
        ImageIndex = 210
        Images = MainImages
        FocusType = ftHot
        ShowCaption = False
        Transparent = True
        TabOrder = 16
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
      end
      object tbtnInspectionApp: TAdvGlowButton
        Left = 304
        Top = 2
        Width = 23
        Height = 22
        Hint = 'Inspect-A-Lot'
        Caption = 'Inspect-A-Lot'
        ImageIndex = 226
        Images = MainImages
        FocusType = ftHot
        ShowCaption = False
        Transparent = True
        TabOrder = 22
        OnClick = ServiceCmdExecute
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
      end
    end
    object OtherToolsToolbar: TAdvToolBar
      Left = 763
      Top = 30
      Width = 140
      Height = 28
      AllowFloating = False
      AutoDockOnClose = True
      Caption = 'Additional Tools'
      CaptionFont.Charset = DEFAULT_CHARSET
      CaptionFont.Color = clWindowText
      CaptionFont.Height = -11
      CaptionFont.Name = 'MS Sans Serif'
      CaptionFont.Style = []
      CompactImageIndex = -1
      ShowOptionIndicator = False
      TextAutoOptionMenu = 'Add or Remove Buttons'
      TextOptionMenu = 'Options'
      ToolBarStyler = ToolBarStyle
      Images = MainImages
      ParentOptionPicture = True
      ToolBarIndex = -1
      OnResize = OtherToolsToolbarResize
      object tbtnPlugIn8: TAdvToolBarButton
        Left = 78
        Top = 2
        Width = 24
        Height = 24
        Hint = 'RapidSketch'
        Action = ToolRapidSketchCmd
        Appearance.CaptionFont.Charset = DEFAULT_CHARSET
        Appearance.CaptionFont.Color = clWindowText
        Appearance.CaptionFont.Height = -11
        Appearance.CaptionFont.Name = 'MS Sans Serif'
        Appearance.CaptionFont.Style = []
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ImageIndex = 170
        ParentFont = False
        Position = daTop
        Version = '2.6.0.0'
      end
      object tbtnPlugIn9: TAdvToolBarButton
        Tag = 210
        Left = 102
        Top = 2
        Width = 24
        Height = 24
        Action = ToolPhoenixSketchCmd
        Appearance.CaptionFont.Charset = DEFAULT_CHARSET
        Appearance.CaptionFont.Color = clWindowText
        Appearance.CaptionFont.Height = -11
        Appearance.CaptionFont.Name = 'MS Sans Serif'
        Appearance.CaptionFont.Style = []
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ImageIndex = 214
        ParentFont = False
        Position = daTop
        Version = '2.6.0.0'
      end
      object tbtnPlugIn1: TAdvGlowButton
        Left = 9
        Top = 2
        Width = 23
        Height = 22
        Action = ToolWinSketchCmd
        ImageIndex = 136
        Images = MainImages
        ShowCaption = False
        Transparent = True
        TabOrder = 0
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
      end
      object tbtnPlugIn2: TAdvGlowButton
        Left = 55
        Top = 2
        Width = 23
        Height = 22
        Action = ToolGeoLocatorCmd
        ImageIndex = 135
        Images = MainImages
        ShowCaption = False
        Transparent = True
        TabOrder = 1
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
      end
      object tbtnPlugIn3: TAdvGlowButton
        Left = 101
        Top = 30
        Width = 23
        Height = 22
        Action = ToolDelormeCmd
        ImageIndex = 138
        Images = MainImages
        ShowCaption = False
        Transparent = True
        TabOrder = 2
        Visible = False
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
      end
      object tbtnPlugIn4: TAdvGlowButton
        Left = 124
        Top = 30
        Width = 23
        Height = 22
        Action = ToolStreetNTripCmd
        ImageIndex = 139
        Images = MainImages
        ShowCaption = False
        Transparent = True
        TabOrder = 3
        Visible = False
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
      end
      object tbtnPlugIn5: TAdvGlowButton
        Left = 32
        Top = 2
        Width = 23
        Height = 22
        Action = ToolApexCmd
        ImageIndex = 137
        Images = MainImages
        ShowCaption = False
        Transparent = True
        TabOrder = 4
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
      end
      object tbtnPlugIn6: TAdvGlowButton
        Left = 147
        Top = 30
        Width = 23
        Height = 22
        Action = ToolMapProCmd
        ImageIndex = 141
        Images = MainImages
        ShowCaption = False
        Transparent = True
        TabOrder = 5
        Visible = False
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
      end
      object tbtnUserSpecified1: TAdvGlowButton
        Left = 170
        Top = 30
        Width = 23
        Height = 22
        Action = ToolUser1Cmd
        ImageIndex = 127
        Images = MainImages
        ShowCaption = False
        Transparent = True
        TabOrder = 6
        Visible = False
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
      end
      object tbtnUserSpecified2: TAdvGlowButton
        Left = 170
        Top = 30
        Width = 23
        Height = 22
        Action = ToolUser2Cmd
        ImageIndex = 127
        Images = MainImages
        ShowCaption = False
        Transparent = True
        TabOrder = 7
        Visible = False
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
      end
      object tbtnUserSpecified3: TAdvGlowButton
        Left = 170
        Top = 30
        Width = 23
        Height = 22
        Action = ToolUser3Cmd
        ImageIndex = 127
        Images = MainImages
        ShowCaption = False
        Transparent = True
        TabOrder = 8
        Visible = False
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
      end
      object tbtnUserSpecified4: TAdvGlowButton
        Left = 170
        Top = 30
        Width = 23
        Height = 22
        Action = ToolUser4Cmd
        ImageIndex = 127
        Images = MainImages
        ShowCaption = False
        Transparent = True
        TabOrder = 9
        Visible = False
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
      end
      object tbtnUserSpecified5: TAdvGlowButton
        Left = 170
        Top = 30
        Width = 23
        Height = 22
        Action = ToolUser5Cmd
        ImageIndex = 127
        Images = MainImages
        ShowCaption = False
        Transparent = True
        TabOrder = 10
        Visible = False
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
      end
      object tbtnUserSpecified6: TAdvGlowButton
        Left = 170
        Top = 30
        Width = 23
        Height = 22
        Action = ToolUser6Cmd
        ImageIndex = 127
        Images = MainImages
        ShowCaption = False
        Transparent = True
        TabOrder = 11
        Visible = False
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
      end
      object tbtnUserSpecified7: TAdvGlowButton
        Left = 170
        Top = 30
        Width = 23
        Height = 22
        Action = ToolUser7Cmd
        ImageIndex = 127
        Images = MainImages
        ShowCaption = False
        Transparent = True
        TabOrder = 12
        Visible = False
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
      end
      object tbtnUserSpecified8: TAdvGlowButton
        Left = 170
        Top = 30
        Width = 23
        Height = 22
        Action = ToolUser8Cmd
        ImageIndex = 127
        Images = MainImages
        ShowCaption = False
        Transparent = True
        TabOrder = 13
        Visible = False
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
      end
      object tbtnUserSpecified9: TAdvGlowButton
        Left = 170
        Top = 30
        Width = 23
        Height = 22
        Action = ToolUser9Cmd
        ImageIndex = 127
        Images = MainImages
        ShowCaption = False
        Transparent = True
        TabOrder = 14
        Visible = False
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
      end
      object tbtnUserSpecified10: TAdvGlowButton
        Left = 170
        Top = 30
        Width = 23
        Height = 22
        Action = ToolUser10Cmd
        ImageIndex = 127
        Images = MainImages
        ShowCaption = False
        Transparent = True
        TabOrder = 15
        Visible = False
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
      end
    end
    object PrefToolBar: TAdvToolBar
      Left = 669
      Top = 30
      Width = 92
      Height = 26
      AllowFloating = False
      AutoDockOnClose = True
      Caption = 'Preferences'
      CaptionFont.Charset = DEFAULT_CHARSET
      CaptionFont.Color = clWindowText
      CaptionFont.Height = -11
      CaptionFont.Name = 'MS Sans Serif'
      CaptionFont.Style = []
      CompactImageIndex = -1
      ShowOptionIndicator = False
      TextAutoOptionMenu = 'Add or Remove Buttons'
      TextOptionMenu = 'Options'
      ToolBarStyler = ToolBarStyle
      Images = MainImages
      ParentOptionPicture = True
      ToolBarIndex = -1
      object tbtnPreferences: TAdvGlowButton
        Left = 9
        Top = 2
        Width = 23
        Height = 22
        Action = EditPreferencesCmd
        ImageIndex = 149
        Images = MainImages
        FocusType = ftHot
        ShortCutHint = 'Ctrl+K'
        ShowCaption = False
        Transparent = True
        TabOrder = 0
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
      end
      object tbtnUsage: TAdvGlowButton
        Left = 32
        Top = 2
        Width = 23
        Height = 22
        Action = ServiceUsageSummaryCmd
        ImageIndex = 157
        Images = MainImages
        FocusType = ftHot
        ShowCaption = False
        Transparent = True
        TabOrder = 1
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
      end
      object tbtnCheckForUpdates: TAdvGlowButton
        Left = 55
        Top = 2
        Width = 23
        Height = 22
        Action = HelpCheckForUpdatesCmd
        ImageIndex = 128
        Images = MainImages
        ShowCaption = False
        Transparent = True
        TabOrder = 2
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
      end
    end
    object LabelingToolbar: TAdvToolBar
      Left = 675
      Top = 1
      Width = 149
      Height = 28
      AllowFloating = False
      AutoDockOnClose = True
      Caption = 'Labeling'
      CaptionFont.Charset = DEFAULT_CHARSET
      CaptionFont.Color = clWindowText
      CaptionFont.Height = -11
      CaptionFont.Name = 'MS Sans Serif'
      CaptionFont.Style = []
      CompactImageIndex = -1
      ShowOptionIndicator = False
      TextAutoOptionMenu = 'Add or Remove Buttons'
      TextOptionMenu = 'Options'
      ToolBarStyler = ToolBarStyle
      Images = MainImages
      ParentOptionPicture = True
      ToolBarIndex = -1
      object tbtnHand: TAdvToolBarButton
        Left = 56
        Top = 2
        Width = 24
        Height = 24
        Action = ToolSelectCmd
        Appearance.CaptionFont.Charset = DEFAULT_CHARSET
        Appearance.CaptionFont.Color = clWindowText
        Appearance.CaptionFont.Height = -11
        Appearance.CaptionFont.Name = 'MS Sans Serif'
        Appearance.CaptionFont.Style = []
        GroupIndex = 1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ImageIndex = 45
        ParentFont = False
        Position = daTop
        Style = tasCheck
        Version = '2.6.0.0'
      end
      object tbtnFreeText: TAdvToolBarButton
        Left = 32
        Top = 2
        Width = 24
        Height = 24
        Action = ToolFreeTextCmd
        Appearance.CaptionFont.Charset = DEFAULT_CHARSET
        Appearance.CaptionFont.Color = clWindowText
        Appearance.CaptionFont.Height = -11
        Appearance.CaptionFont.Name = 'MS Sans Serif'
        Appearance.CaptionFont.Style = []
        GroupIndex = 1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ImageIndex = 35
        ParentFont = False
        Position = daTop
        Style = tasCheck
        Version = '2.6.0.0'
      end
      object tbtnMapLabel: TAdvGlowButton
        Left = 80
        Top = 2
        Width = 32
        Height = 22
        Hint = 'Subject Map Label (drag to map)'
        Caption = 'Subject Map Labels'
        ImageIndex = 39
        Images = MainImages
        ShowCaption = False
        Transparent = True
        TabOrder = 0
        OnStartDrag = MapLabelStartDrag
        OnMouseDown = MapLabelMouseDown
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
        DropDownButton = True
        DropDownMenu = PopupMapLabels
      end
      object tbtnMarker: TAdvGlowButton
        Left = 9
        Top = 2
        Width = 23
        Height = 22
        Hint = 'Bookmark (drag to blue margin)'
        Caption = 'BookMark'
        ImageIndex = 24
        Images = MainImages
        ShowCaption = False
        Transparent = True
        TabOrder = 1
        OnStartDrag = BookMarkStartDrag
        OnMouseDown = BookMarkMouseDown
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
      end
      object tbtnLabelLib: TAdvGlowButton
        Left = 112
        Top = 2
        Width = 23
        Height = 22
        Hint = 'Map Label Library'
        Caption = 'Map Label Library'
        ImageIndex = 42
        Images = MainImages
        ShowCaption = False
        Transparent = True
        TabOrder = 2
        OnClick = tbtnMapLibraryClick
        Appearance.BorderColor = 14727579
        Appearance.BorderColorHot = 10079963
        Appearance.BorderColorDown = 4548219
        Appearance.BorderColorChecked = 4548219
        Appearance.Color = 15653832
        Appearance.ColorTo = 16178633
        Appearance.ColorChecked = 11918331
        Appearance.ColorCheckedTo = 7915518
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 7778289
        Appearance.ColorDownTo = 4296947
        Appearance.ColorHot = 15465983
        Appearance.ColorHotTo = 11332863
        Appearance.ColorMirror = 15586496
        Appearance.ColorMirrorTo = 16245200
        Appearance.ColorMirrorHot = 5888767
        Appearance.ColorMirrorHotTo = 10807807
        Appearance.ColorMirrorDown = 946929
        Appearance.ColorMirrorDownTo = 5021693
        Appearance.ColorMirrorChecked = 10480637
        Appearance.ColorMirrorCheckedTo = 5682430
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
      end
    end
    object NewsBar: TAdvToolBar
      Left = 826
      Top = 1
      Width = 80
      Height = 28
      AllowFloating = True
      CaptionFont.Charset = DEFAULT_CHARSET
      CaptionFont.Color = clWindowText
      CaptionFont.Height = -11
      CaptionFont.Name = 'MS Sans Serif'
      CaptionFont.Style = []
      CompactImageIndex = -1
      ShowOptionIndicator = False
      TextAutoOptionMenu = 'Add or Remove Buttons'
      TextOptionMenu = 'Options'
      ToolBarStyler = styler2
      ParentStyler = False
      Images = MainImages
      ParentOptionPicture = True
      ToolBarIndex = -1
      object NewsBtn: TAdvToolBarButton
        Left = 9
        Top = 2
        Width = 57
        Height = 24
        Action = HelpNewsDeskCmd
        Appearance.CaptionFont.Charset = DEFAULT_CHARSET
        Appearance.CaptionFont.Color = clWindowText
        Appearance.CaptionFont.Height = -11
        Appearance.CaptionFont.Name = 'Times New Roman'
        Appearance.CaptionFont.Style = []
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ImageIndex = 108
        ParentFont = False
        Position = daTop
        ShowCaption = True
        Version = '2.6.0.0'
      end
    end
  end
  object MainImages: TImageList
    ShareImages = True
    Left = 290
    Top = 131
    Bitmap = {
      494C0101E900EA00040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      000000000000360000002800000040000000B0030000010020000000000000B0
      0300000000000000000000000000000000000000000000000000000000000000
      000000000000C0C0C000F0FBFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000040404000A4A0A000C0C0C00040606000F0FB
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000040404000A4A0A00040202000404040000080C00000C0E0008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000004060
      6000C0DCC0008060600040404000808080000020400000A0E00080C0C0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C0DC
      C0008080800000000000002040004080A0008060400000C0E000808080000000
      0000A4A0A0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000406060000000
      0000404040000040400000C0E00000C0E0000080A00000000000000000000000
      0000406060000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080008080
      80000000000000A0E00000A0E00000A0E00000A0E00080606000000000000000
      0000404040000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C0DC
      C000808080008080800080808000F0FBFF000000000000000000C0DCC0000000
      0000404040000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000A4A0
      A00000000000A4A0A00040606000F0FBFF000000000000000000808080000000
      0000406060000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000A4A0A000806060004040400040606000000000000000000000000000C0DC
      C000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F0FB
      FF00808080004020200000000000404040000000000080606000F0FBFF00A4A0
      A00080808000F0FBFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F0FBFF00C0C0C000404040000000000000000000000000000000
      0000C0C0C00080808000A4A0A000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C0DCC00040404000406060004020200000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000040404000406060000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000040A0A00000204000404040008060600000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000080E0E000F0FBFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E4D6CA00AC835E009C6C400098663800986638009C6C4000AC835E00E4D6
      CA00000000000000000000000000000000000000000000000000000000000000
      000000000000D2BCA8009A683A008B521E008E572400B08A6600F6F2EE000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FE00012DC60852697D13BE7F6219E7786B17DA4F9D0E8F0DED02190000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F9F6F300AB81
      5C00925C2B008B521E008B521E008B521E008B521E008B521E008B521E00925C
      2B00AB815C00F9F6F3000000000000000000000000000000000000000000B894
      74008C5320008B521E008B521E008B521E008B521E008B521E008B521E008C54
      2100F9F6F40000000000000000000000000000000000000000000000000042AD
      0B78905826FF946136FF946237FF946237FF946237FF946237FF925E30FF7C68
      19DF09F201120000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F9F6F3009F7146008B52
      1E008B521E008D552200966334009A683A009A683A00935E2E008B521E008B52
      1E008B521E009F714600F9F6F3000000000000000000000000008F5725008B52
      1E008B521E008B521E008B521E008B521E008B521E008B521E008B521E008B52
      1E008B531F00E6D9CE0000000000000000000000000000000000747017D29361
      35FF925F34FF925F34FF925F34FF925F34FF925F34FF925F34FF925F34FF9260
      34FF905928FF1FD8053900000000000000000000000000000000000000000000
      0000000000000000000000000000C0A02000C0A0200000000000000000000000
      00000000000000000000000000000000000000000000AB815C008D552200BC9B
      7D00E6D9CE00FCFAF90000000000000000000000000000000000FAF7F400E2D4
      C700BF9F830090592800AB815C000000000000000000976436008B521E00925D
      2C00D6C2B000FEFEFD0000000000000000000000000000000000E8DCD200B591
      70008B521E008B531F00F9F6F4000000000000000000697D14BE946237FFB795
      78FFFEFEFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE
      FEFF9A6B42FF915A29FF0DEE0218000000000000000000000000000000000000
      00000000000000000000F0CAA600F0FBFF00F0FBFF00F0CAA600C0A000000000
      000000000000000000000000000000000000E4D6CA00925C2B00B99778000000
      0000EEE5DD00C0A18500C0A18400C1A38600BFA08300BE9E8200C1A38800EBE2
      D90000000000C8AC9300925C2B00E4D6CA00EAE0D6008B521E00E3D6C9000000
      000000000000D4BFAC00B8967600AE866200AF886500BFA08300F0E9E3000000
      000000000000905928008C542100000000001ED80538935F32FF946237FFBFA1
      88FFD2BDABFF956339FF956339FF956339FF956339FF956339FF946237FFF6F2
      EEFF9D6F48FF946237FF81621BE8000000000000000000000000000000000000
      0000C0A04000F0CAA600FFFFFF00FFFFFF00F0FBFF00FFFFFF00F0FBFF00C0A0
      400000000000000000000000000000000000AC835E008B521E008F582600C4A7
      8D00B7937300FCFBFA0000000000FEFDFC00FEFEFD0000000000FFFEFE00B793
      7300C9AF9700945F2F008B521E00AC835E008C5421008B521E00976435000000
      00009B6A3D000000000000000000000000000000000000000000FAF8F500C5A9
      8F00EDE5DD008B521E008B521E00F6F2EE007C6719E0946237FF946237FFBFA1
      88FFD2BDAAFF946136FF936136FF936136FF936135FF936135FF925F33FFF6F2
      EEFF9D6F48FF946237FF935F32FF17E1042B0000000000000000000000000000
      0000C0C06000F0CAA600F0CAA600FFFFFF00F0FBFF00F0CAA600F0CAA600C0C0
      6000000000000000000000000000000000009C6C40008B521E008B521E008B52
      1E008B521E00EFE7E00000000000B6927100B28C6A0000000000FAF7F4008E57
      24008B521E008B521E008B521E009C6C40008B521E008B521E008B521E008B52
      1E008B521E000000000000000000F2ECE600AD85600000000000FEFEFD008B52
      1E008B521E008B521E008B521E00B08A6600915A2AFF946237FF946237FFBFA1
      88FFD1BCAAFFAA8260FFAA8361FFAB8462FFAC8564FFAD8665FFAA8361FFF6F1
      EEFF9D6F48FF946237FF946237FF608811AE0000000000000000C0A02000F0CA
      A600FFFFFF00FFFFFF00FFFFFF00F0CAA600F0CAA600FFFFFF00FFFFFF00FFFF
      FF00F0CAA600C0A020000000000000000000986638008B521E008B521E008B52
      1E008B521E00CBB19A00BF9F8300BE9F8200C7AB9200B7947400D6C2B0008B52
      1E008B521E008B521E008B521E00986638008B521E008B521E008B521E008B52
      1E008B521E00FCFBFA00C9AE9600BF9F8300915B2900D5C0AD00BF9F83008B52
      1E008B521E008B521E008B521E008E572400935F32FF946236FF96643AFFC3A7
      8FFFD8C5B6FFCCB4A0FFCEB6A3FFCEB6A3FFCDB5A2FFCDB4A1FFC8AD98FFF7F4
      F1FFAB8361FF9B6C44FF956338FF855A1AF20000000000000000C0C06000FFFF
      FF00FFFFFF00FFFFFF00F0CAA600C0A00000C0A00000F0CAA600FFFFFF00FFFF
      FF00FFFFFF00C0C060000000000000000000986638008B521E008B521E008B52
      1E008B521E00A87D5600DDCDBE00A87D5600B38D6B00CDB49E00B48F6D008B52
      1E008B521E008B521E008B521E00986638008B521E008B521E008B521E008B52
      1E008B521E00D1BAA600DCCBBC00F3EDE700B38E6C00000000008B521E008B52
      1E008B521E008B521E008B521E008B521E00A2754FFFAA8160FFAA8160FFCCB4
      A0FFDBCABCFFA77D5BFFA77D5BFFA77D5BFFA87D5BFFA87D5BFFA77C5AFFF8F5
      F2FFB18C6DFFAA8160FFAA8261FFA07546FB000000000000000000000000C0A0
      4000F0CAA600C0A0200000000000000000000000000000000000C0A02000F0CA
      A600C0A040000000000000000000000000009C6C40008B521E008B521E008B52
      1E008B521E008C542100E9DFD500E7DBD000D7C4B200EFE7DF00925C2B008B52
      1E008B521E008B521E008B521E009C6C40008B521E008B521E008B521E008B52
      1E008B521E008E572400D9C7B600BE9E8100FFFEFE00E8DCD2008B521E008B52
      1E008B521E008B521E008B521E009A683A00A87D59FFAA8160FFAA8160FFCCB4
      A0FFDAC9BAFFD1BAA8FFD1BBA9FFD1BBAAFFD2BCABFFD2BDABFFCEB7A4FFF7F4
      F1FFB18C6DFFAA8160FFAA8160FF878C3CD2000000000000000000000000C0A0
      2000F0CAA600C0A0200000000000000000000000000000000000C0A02000F0CA
      A600C0A02000000000000000000000000000AC835E008B521E008B521E008B52
      1E008B521E008B521E00D4BFAB0000000000FEFEFD00E0D0C2008B521E008B52
      1E008B521E008B521E008B521E00AC835E008F5725008B521E008B521E008B52
      1E008B521E008B521E00000000000000000000000000CDB49E008B521E008B52
      1E008B521E008B521E008B521E00D2BCA800A17B4CF8AA8160FFAA8160FFCCB4
      A0FFDBCABCFFAA8160FFAA8160FFAA8160FFAA8160FFAA8160FFA9805EFFF8F4
      F2FFB18C6DFFAA8160FFAA805FFF39CA175C0000000000000000C0A04000FFFF
      FF00FFFFFF00FFFFFF00C0C060000000000000000000C0C06000FFFFFF00FFFF
      FF00FFFFFF00C0C060000000000000000000E4D6CA00925C2B008B521E008B52
      1E008B521E008B521E00B08965000000000000000000BB9A7C008B521E008B52
      1E008B521E008B521E00925C2B00E4D6CA00AF8864008B521E008B521E008B52
      1E008B521E008B521E00E2D4C70000000000000000008C5421008B521E008B52
      1E008B521E008B521E008C5320000000000054B82683AA8160FFAA8160FFCCB4
      A0FFDAC9BBFFA9805FFFC7AD97FFC7AD97FFC7AD97FFBFA188FFA87E5CFFF8F4
      F1FFB18C6DFFAA8160FFA67851FF000000000000000000000000C0C06000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00F0CAA600F0CAA600FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C0C08000000000000000000000000000AB815C008B521E008B52
      1E008B521E008B521E008F572500F1EBE50000000000F6F2EE00FCFAF900C8AC
      93008B521E008B521E00AB815C0000000000000000008D5522008B521E008B52
      1E008B521E008B521E00986537000000000000000000EDE4DC00F8F4F100BF9F
      83008B521E008B521E00B89474000000000000000000A27A4DF9AA8160FFCBB3
      9FFFFEFEFEFFD3BDACFFFFFFFFFFFFFFFFFFFFFFFFFFF6F2EEFFF6F1EEFFFFFF
      FFFFB18B6DFFA9805EFF3FC4196600000000000000000000000000000000C0A0
      2000F0CAA600FFFFFF00F0CAA6000000000000000000F0CAA600FFFFFF00F0CA
      A600C0A0200000000000000000000000000000000000F9F6F3009F7146008B52
      1E008B521E008B521E008B521E00AC845E00FEFDFC00EEE6DE00BD9D7F008B52
      1E008B521E009F714600F9F6F3000000000000000000EBE2D9008B521E008B52
      1E008B521E008B521E008B521E00EBE0D7000000000000000000C2A388008B52
      1E008B521E008F57250000000000000000000000000011F1081AA67952FFAA81
      60FFAC8464FFAB8262FFDFD0C4FFD2BCABFFF3EDE8FFD3BDACFFAB8363FFAC84
      63FFA9805EFF719D31B100000000000000000000000000000000000000000000
      000000000000C0A0200000000000000000000000000000000000C0A020000000
      0000000000000000000000000000000000000000000000000000F9F6F300AB81
      5C00925C2B008B521E008B521E008B521E00966233008B521E008B521E00925C
      2B00AB815C00F9F6F30000000000000000000000000000000000EBE2D9008D55
      22008B521E008B521E008B521E008B521E00A3764D008B521E008B521E008B52
      1E009764360000000000000000000000000000000000000000000CF405139B7E
      48F0AA805EFFAA8160FFA9805FFFE0D1C5FFCCB39FFFAA8160FFAA8160FFA87C
      56FF56B526870000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E4D6CA00AC835E009C6C400098663800986638009C6C4000AC835E00E4D6
      CA00000000000000000000000000000000000000000000000000000000000000
      0000AF8864008F5725008B521E008B521E008B521E008B521E008C542100EAE0
      D600000000000000000000000000000000000000000000000000000000000000
      000032D3154F8D8740DCA57951FEA77B56FFA77B55FF9F7B4BF668A62EA209F7
      040E000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F0FBFF00800060008000
      000080000000C0A04000000000000000000000000000C0A0E000800000008000
      0000C0000000F0CAA60000000000000000000000000005DE1E25157388A0202F
      CCED2320DDFF2320DDFF2320DDFF2320DDFF2320DDFF2320DDFF2320DDFF2320
      DDFF202FCCED157388A005DE1E25000000000000000000000000000000000000
      0000F3EEE600C1A87F00A07A3D008F621900D7C6AD0000000000E8DFD100EFE8
      DE00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F0FBFF00C0006000F0CA
      A60000000000000000000000000000000000000000000000000000000000F0FB
      FF00C0006000F0CAA600000000000000000005DE1C251A5795BF2320CAFF2320
      CAFF2320CAFF2320CAFF2320CAFF2320CAFF2320CAFF2320CAFF2320CAFF2320
      CAFF2320CAFF201DC9FF175494BF04DD1C25000000000000000000000000F1EC
      E300936823008F621A008F621900A582490000000000CDBA9A008F6219008F62
      1A00C4AC86000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F0FBFF00C0006000F0CA
      A60000000000000000000000000000000000000000000000000000000000F0FB
      FF00C0006000F0CAA6000000000000000000157174A0221EBAFF221EBAFF221E
      BAFF1F1BB9FF211EBAFF2622BBFF2420BAFF1F1CB9FF201CB9FF221EBAFF211D
      B9FF2421BBFF6865D1FF807ED9FF237F78A000000000F6F3ED0000000000E1D4
      C1008F6219008F621A008F621900D8C8AF0000000000956B27008F621A008F62
      1A008F621900A17B3E00FBF9F600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F0FBFF00C0006000F0CA
      A60000000000000000000000000000000000000000000000000000000000F0FB
      FF00C0006000F0CAA60000000000000000001E2EA2EC211EB0FF1F1CAFFF2B27
      B3FF6664C9FFA5A3DFFFBFBEE8FFB6B5E5FF8987D6FF4441BDFF1F1BAFFF2D2A
      B4FF918FD9FFF4F4FBFFEDECF8FF4E5FB3EC00000000B1925F00C6AE8A000000
      00009C7434008F6219008F621A00F6F2EC00EEE7DB008F621A008F621A008F62
      1A00A7844B00BEA37900F1ECE300000000000000000000000000000000000000
      00000000000040A0400040A0400040A0400040A0400040A0400040A040000000
      00000000000000000000000000000000000000000000F0FBFF00C0006000F0CA
      A60000000000000000000000000000000000000000000000000000000000F0FB
      FF00C0006000F0CAA6000000000000000000201EA8FE1F1CA8FF3C39B3FFB5B4
      E2FFF5F5FCFFDEDDFDFFC4C1FBFFCDCCFCFFEFEFFEFFE3E2F4FF8482D0FFB3B2
      E2FFFDFCFEFFF2F2FAFF8B89D1FF2826ABFEEDE6DA008F621A00966C29000000
      0000EAE1D4008F6219008F621A0000000000DACCB4008F611800A5814800F5F2
      EC000000000000000000FDFDFB00000000000000000000000000000000000000
      00000000000040A0400040A0400040A0400040A0400040A0400040A040000000
      00000000000000000000000000000000000000000000F0FBFF00C0006000F0CA
      A60000000000000000000000000000000000000000000000000000000000F0FB
      FF00C0006000F0CAA60000000000000000001F1BA3FF2F2BAAFFBCBBE4FFECEB
      FEFF827DF4FF3D35EEFF2C24ECFF3129EDFF5650F0FFBCBAF9FFFCFCFEFFFFFF
      FFFFDFDFF2FF6A67C1FF211DA4FF1F1BA3FFC2A982008F621A008F621900B698
      6A0000000000DCCDB7008D5F170000000000C8B18D00B496640000000000FCFB
      FA00BA9F74008F621A008F621A00DED1BC000000000000000000000000000000
      00000000000040A0400040A0400040A0400040A0400040A0400040A040000000
      00000000000000000000000000000000000000000000F0FBFF00C0006000F0CA
      A60000000000000000000000000000000000000000000000000000000000F0FB
      FF00C0006000F0CAA60000000000000000001D199FFF7C79C7FFF4F3FDFF7873
      F3FF7671F3FF928EF5FF6560F1FF807BF4FF918DF5FF625CF1FFC4C2FAFFF3F2
      F9FF5B58B9FF1D199EFF201CA0FF201CA0FFB0905D008F621A008F621A008F62
      1900B6996B0000000000EFE9DF00F9F7F3000000000000000000C0A67E008F61
      18008F6219008F621A008F621A00A8864E000000000000000000000000000000
      000080C0800040A0200040A0400040A0400040A0400040A0400040A040000000
      00000000000000000000000000000000000000000000F0FBFF00C0006000F0CA
      A60000000000000000000000000000000000000000000000000000000000F0FB
      FF00C0006000F0CAA60000000000000000002824A1FFC2C1E4FFC6C4FBFF372F
      EDFF8E8AF5FF6C67F2FF9895F6FF928EF5FF7873F3FF645EF1FF6862F2FFF3F3
      FCFF6260BAFF1C189CFF201C9DFF201C9DFFD5C4A9008F6219008F621A008F62
      1A008F611900B1925F00000000000000000000000000FEFEFE00BC9F71009F79
      3B0090631C008F621A008F621A00966C28000000000000000000000000000000
      000080C0800040A0200040A0400040A0400040A0400040A0400040A040000000
      00000000000000000000000000000000000000000000F0FBFF00C0006000F0CA
      A60000000000000000000000000000000000000000000000000000000000F0FB
      FF00C0006000F0CAA60000000000000000003734A6FFDEDEEFFF9B97F7FF3129
      EDFF8F8BF5FF4841EFFF8984F5FF6C66F2FF6C66F2FF6761F2FF433CEEFFEAE9
      FEFF8584C9FF1C189AFF201C9CFF201C9CFFFDFDFB00FFFEFE00EDE5D900EBE3
      D600F9F7F30000000000FEFEFD00FFFFFE0000000000F7F6F300F7F4EF000000
      000000000000C8B28F008F621A0092661F000000000000000000000000000000
      000080C0800040A0400040A0400040A0400040A0400040A0400040A040000000
      00000000000000000000000000000000000000000000F0FBFF00C0006000F0CA
      A60000000000000000000000000000000000000000000000000000000000F0FB
      FF00C0006000F0CAA60000000000000000003734A6FFDEDEEFFF9A96F7FF5C56
      F1FFB9B6F9FF827DF4FF2E26EDFF4C46EFFFA6A3F7FF9490F6FF554EF0FFEAE9
      FEFF8483C8FF1B1899FF1F1C9BFF1F1C9BFFBDA37900D8C8AF00FAF8F400F8F6
      F200EEE7DC00B99D6F00D4C4AB000000000000000000E6DDCC008F621A00AD8C
      5900EBE3D60000000000DDD0BB00AD8C58000000000000000000000000000000
      00000000000040A0200040A0400040A0400040A0400040A0400040A040000000
      00000000000000000000000000000000000000000000F0FBFF00C0006000F0CA
      A60000000000000000000000000000000000000000000000000000000000F0FB
      FF00C0006000F0CAA600000000000000000027249EFFC1C0E2FFC8C6FBFF3932
      EEFF7F7BF4FFBFBDF9FF9F9BF7FFB1AEF8FFB4B1F8FF5650F0FF6E69F2FFF4F3
      FCFF6260B8FF1C1999FF1F1C9BFF1F1C9BFFBEA47A008F621A008F621A008F62
      1A008F621A0091651D00F1EBE100E2D5C200AF8E5B0000000000B39564008F62
      18008F621A00AE8E5A0000000000000000000000000000000000000000000000
      000080E0A00080C0800080C0800080C0800080C0800080C0800080C080000000
      00000000000000000000000000000000000000000000F0FBFF00C0006000F0CA
      A60000000000000000000000000000000000000000000000000000000000F0FB
      FF00C0006000F0CAA60000000000000000001B1998FE7876C2FFF4F4FDFF7974
      F3FF2820ECFF6F69F2FFB9B7F9FFB6B4F9FF8783F4FF3932EEFFCAC8FBFFD1D1
      EAFF312FA2FF1E1B99FF1F1C9AFF1E1C99FEEEE8DD008F621A008F621A008F62
      1A008F621900CBB6950000000000AA8750008F62190000000000E6DCCD008F62
      19008F621A008F621900CAB49300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F0FBFF00C0006000F0CA
      A60000000000000000000000000000000000000000000000000000000000F0FB
      FF00C0006000F0CAA60000000000000000001B2B8DEC2C2AA0FFB8B7DFFFEEED
      FEFF8682F5FF3F37EEFF5650F0FF4B45EFFF6761F2FFC2BFFAFFEFEEF8FF6664
      BAFF1D1A99FF1F1C9AFF1F1C9AFF1C2C8EEC00000000C7B08C008F621A008F62
      1A00B99D700000000000D4C3A8008F6219008F621900D9CAB200000000009266
      1F008F621A008F621A00D3C1A400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F0FBFF00800060008000
      000080000000C0A04000000000000000000000000000C0A0E000800000008000
      0000C0000000F0CAA6000000000000000000137060A01D1A99FF3835A5FFAFAE
      DAFFF5F4FBFFE2E1FEFFC7C5FBFFD1CFFCFFF0F0FEFFE0E0F0FF6D6BBDFF201D
      9AFF1F1C9AFF1F1C9AFF1F1C9AFF137060A00000000000000000DACBB400DACB
      B30000000000E1D5C3008F621A008F621A008F621900BFA67C00000000009F79
      3C008F621A00B698690000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000004DE1625175473BF1D1A99FF2724
      9DFF5F5DB7FF9C9BD2FFB7B6DDFFAEADDAFF817FC6FF3E3BA8FF1D1A99FF1F1C
      9AFF1F1C9AFF1F1C9AFF175473BF04DE16250000000000000000000000000000
      0000C6AF8B008F621A008F621A008F621A008F611900C6AF8B0000000000976E
      2B00BDA277000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000004DE1625137060A01B2B
      8FED1B1898FF1D1A99FF221F9BFF201D9AFF1B1898FF1D1A99FF1F1C9AFF1F1C
      9AFF1C2C8FED137060A004DE1625000000000000000000000000000000000000
      0000E1D5C100BEA47B00A6834A008F621A00A8854E00F8F6F20000000000EEE8
      DD00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F0CAA600FF000000FF000000FF000000FF000000FF000000FF000000C060
      6000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F0CA
      A600FF000000C040600000000000000000000000000000000000F0CAA600FF00
      0000C08080000000000000000000000000000000000000000000000000000000
      000000000000C0404000C0404000C0404000C0404000C0404000C04040000000
      00000000000000000000000000000000000000000000000000000000000040F5
      FF0040F5FF0040F5FF0040F5FF0040F5FF0040F5FF0040F5FF0040F5FF0040F5
      FF0040F5FF000000000000000000000000000000000000000000000000000000
      00000000000000E0C00000E0C00000E0C00000E0C00000E0C00000E0C0000000
      000000000000000000000000000000000000000000000000000000000000C080
      A000FF000000F0CAA6000000000000000000000000000000000000000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      000000000000C0404000C0404000C0404000C0404000C0404000C04040000000
      00000000000000000000000000000000000000000000000000009C9C9C0040F5
      FF0040F5FF0040F5FF0040F5FF0040F5FF0040F5FF0040F5FF0040F5FF0040F5
      FF0040F5FF0040F5FF0000000000000000000000000000000000000000000000
      00000000000000E0C00000E0C00000E0C00000E0C00000E0C00000E0C0000000
      000000000000000000000000000000000000000000000000000000000000C080
      A000FF000000F0CAA6000000000000000000000000000000000000000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      000000000000C0404000C0404000C0404000C0404000C0404000C04040000000
      00000000000000000000000000000000000000000000000000009C9C9C0040F5
      FF0040F5FF0040F5FF0040F5FF0040F5FF0040F5FF0040F5FF0040F5FF0040F5
      FF0040F5FF0040F5FF0000000000000000000000000000000000000000000000
      00000000000000E0C00000E0C00000E0C00000E0C00000E0C00000E0C0000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000FF000000000000000000000000000000000000000000000000000000C080
      8000FF000000F0CAA60000000000000000000000000000000000000000000000
      000080C08000C0404000C0404000C0404000C0404000C0404000C04040000000
      00000000000000000000000000000000000000000000000000009C9C9C0040F5
      FF0040F5FF0040F5FF0040F5FF0040F5FF0040F5FF0040F5FF0040F5FF0040F5
      FF0040F5FF0040F5FF0000000000000000000000000000000000000000000000
      000080C0800000E0C00000E0C00000E0C00000E0C00000E0C00000E0C0000000
      000000000000000000000000000000000000F0CAA600F0CAA600FF000000C020
      4000000000000000000000000000000000000000000000000000000000000000
      0000C0608000FF000000C080A000F0CAA6000000000000000000000000000000
      000080C08000C0404000C0404000C0404000C0404000C0404000C04040000000
      00000000000000000000000000000000000000000000000000009C9C9C0040F5
      FF0040F5FF0040F5FF0040F5FF0040F5FF0040F5FF0040F5FF0040F5FF0040F5
      FF0040F5FF0040F5FF0000000000000000000000000000000000000000000000
      000080C0800000E0C00000E0C00000E0C00000E0C00000E0C00000E0C0000000
      000000000000000000000000000000000000F0CAA600F0CAA600FF000000C020
      4000000000000000000000000000000000000000000000000000000000000000
      0000C0808000FF000000C0808000F0CAA6000000000000000000000000000000
      000080C08000C0404000C0404000C0404000C0404000C0404000C04040000000
      00000000000000000000000000000000000000000000000000009C9C9C0040F5
      FF0040F5FF0040F5FF0040F5FF0040F5FF0040F5FF0040F5FF0040F5FF0040F5
      FF0040F5FF0040F5FF0000000000000000000000000000000000000000000000
      000080C0800000E0C00000E0C00000E0C00000E0C00000E0C00000E0C0000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000C0204000000000000000000000000000000000000000000000000000C080
      A000FF000000F0CAA60000000000000000000000000000000000000000000000
      000000000000C0404000C0404000C0404000C0404000C0404000C04040000000
      00000000000000000000000000000000000000000000000000009C9C9C0040F5
      FF0040F5FF0040F5FF0040F5FF0040F5FF0040F5FF0040F5FF0040F5FF0040F5
      FF0040F5FF0040F5FF0000000000000000000000000000000000000000000000
      00000000000000E0C00000E0C00000E0C00000E0C00000E0C00000E0C0000000
      000000000000000000000000000000000000000000000000000000000000C080
      A000FF000000F0CAA6000000000000000000000000000000000000000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      000080E0A00080C0800080C0800080C0800080C0800080C0800080C080000000
      00000000000000000000000000000000000000000000000000009C9C9C0040F5
      FF0040F5FF0040F5FF0040F5FF0040F5FF0040F5FF0040F5FF0040F5FF0040F5
      FF0040F5FF0040F5FF0000000000000000000000000000000000000000000000
      000080E0A00080C0800080C0800080C0800080C0800080C0800080C080000000
      000000000000000000000000000000000000000000000000000000000000C080
      A000FF000000F0CAA6000000000000000000000000000000000000000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F0CA
      A600FF000000C060600000000000000000000000000000000000F0CAA600FF00
      0000C06080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C080A000FF000000FF000000C0404000C0204000FF000000FF000000C040
      6000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B4D88200B5D78200B5D78100B5D7
      82006C824D006C824D006D824E006C824D006C814D006D824D006C824D006C82
      4D006D824E006C824D006D814E006C814D00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFF7F2E4FFE6CFA2FFD6AE68FFCF9F4BFFD0A04BFFD8B06AFFE8D1A8FFF8F3
      E9FFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFE00F9FAF900F5F7F600F0F1
      F000EAECEC00E5E6E600E2E2E200E0E2E100DFE0E000E3E3E300E7E9E900EBEC
      EB00F0F1F100BEBEBE00FDFDFD00FEFEFE00FCFCFFFFE9E9FDFF3938F6FF0505
      F6FF0202F7FF0202F7FF0202F7FF0202F7FF0202F7FF0202F7FF0202F7FF0202
      F7FF1717F6FF8989F8FFFFFFFFFFFFFFFFFFB5D88200B5D88200B5D882006D82
      4E006D824E006D824E006D824E006D824E006D824E006D824E006D824E006D82
      4E006D824E006D824E006D824E006D824E00FFFFFFFFFFFFFFFFFDFDFBFFE8D6
      AFFFCE9F47FFC4891BFFC48514FFC48514FFC48514FFC48613FFC5891CFFD0A1
      4CFFECDAB7FFFEFEFDFFFFFFFFFFFFFFFFFFFEFEFE00009E580000A2600000A3
      5D0000A45E0000A86500A0882E00A68A3000A68A2D00AB88270000A35D00009F
      5B000C2B2100989997009C9D9B0000000000B3B2F3FF0403DCFF0C0BDCFF0A09
      DCFF0A09DDFF0A09DDFF0A09DDFF0A09DDFF0A09DDFF0A09DDFF0A09DDFF0A09
      DDFF0A09DCFF0F0EDDFF0505DCFFFFFFFFFFB5D88200B5D88100B5D78200FFFF
      FF00FFFFFF00FFFFFF003AAAFC003AAAFC003AABFC00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF006D814E006D824E006D814E00FFFFFFFFFDFDFAFFE2C896FFC68C
      21FFC48513FFC58616FFC58514FFC58514FFC48514FFC58514FFC58616FFC484
      12FFC78E26FFE4CDA0FFFEFEFDFFFFFFFFFF0000000000A65E0000AE5B009DC4
      DA009EC4D900A0C6DA000D4A8A0015529400155190008DB8D2009EC4D9004E50
      50009E9E9E003E2B3100FEFFFF00000000000101C6FF0E0EC9FF0F0EC9FF0F0E
      C9FF0F0FC9FF1212CAFF1312CAFF1212CAFF0F0FC9FF0F0EC9FF0F0EC9FF0F0E
      C9FF1212CAFF1B1BCCFF0E0EC8FF9393E6FFB5D88200B4D88200B5D88200FFFF
      FF00FFFFFF00FFFFFF003AABFC003AAAFC003AABFC00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF006D824E006D824E006D814E00FEFFFFFFE8D6B0FFC68C22FFC486
      14FFC58616FFC58615FFCE9839FFD9AE64FFD7AD63FFCC9635FFC58516FFC586
      16FFC48514FFC78E27FFECDDBBFFFFFFFFFF0000000000000000000000009AC3
      D60098C2D50099C4D60024578C002A5F9100264C6F009BC7DB009DC3D4001B1D
      1A0059595900000000000000000000000000120FBAFF1412BBFF1411BAFF1411
      BAFF0F0CB9FF6766D3FF8E8DDFFF6361D2FF0C09B8FF1513BBFF1311BAFF100E
      B9FF8988DDFFFFFFFFFFFFFFFFFF201DBDFFB5D78100B5D78100B5D78100FEFE
      FE00FEFEFE00FFFFFF0039ABFC0039ABFC0039ABFC00FEFEFE00FEFEFE00FFFF
      FF00FFFFFF006C814D006D814E00B4D78100F7F1E5FFCF9F47FFC48513FFC586
      16FFC48515FFD1A24DFFDEBC7FFFD7AE65FFD4AA5EFFDDBA7AFFCF9F46FFC485
      14FFC58616FFC48413FFD1A551FFF9F6EDFF000000000000000000000000ADD2
      E200A9CFE000B8E1F300302B260025262400151614002A2A28000C0D0B00FEFC
      FC00BBE1F3000000000000000000000000001714B0FF1714AFFF0805AAFFD6D5
      F1FFFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFFFFCACAEDFF0000A7FFDEDE
      F4FFFBFBFEFFFEFEFFFF7F7ED3FF1C1AB1FFB4D88200B4D88200B5D88200FEFE
      FE00FFFFFF00FFFFFF003AAAFC003AAAFB003AAAFB00FEFEFE00FFFFFF00FFFF
      FF00FFFFFF006C824E0090AC6700B4D88200E5CEA1FFC5891BFFC58615FFC487
      17FFCC9737FFE6CC9EFFD9B371FFE3C894FFD7B169FFC78F28FFDDBB79FFCA94
      32FFC58617FFC58615FFC68B1FFFEAD6B1FF000000000000000000000000BADC
      E800B7DAE90036332F0020232100EAEAEA00E5E5E500F3F3F5002C2B2C00424D
      4800B2D2E1000000000000000000000000001916A8FF0C08A3FFFEFEFFFFFFFF
      FEFF7874F4FF1610ECFF130CECFF1711ECFF8480F5FFFFFFFFFFFFFFFFFFFCFC
      FEFFFFFFFFFF302DB1FF1D1AA9FF1A18A8FFB5D7820000000000B5D78200FEFE
      FE00FEFEFE00FFFFFF0039ABFB0039ABFB0039ABFB00FEFEFE00FEFEFE00FFFF
      FF00FEFEFE006D824E00B5D78100B4D78100D6AE65FFC58514FFC58616FFD7B1
      6AFFEBDAB5FFD5AA5CFFC68B21FFC78E24FFC78C22FFC48718FFD4A757FFECD9
      B7FFD6AB60FFC58514FFC58614FFDBB675FF000000000000000000000000BADC
      E800B7DBE6003A3B3800ECECEC00EAE9E900EEEDEC00EDEDEB00EFEFEF004949
      4600B8D8E7000000000000000000000000001E1BA4FFA3A2DAFFFFFFFEFF231D
      EDFF726EF3FF7470F4FF1A14ECFF7B77F4FF7F7BF5FF2F29EEFFFFFFFFFFFAFA
      FDFF0B089DFF1D1BA4FF1B18A3FF1D1AA4FFB4D8820000000000000DA300FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF001C2D9D00B4D88200B4D88200CF9E47FFC58514FFC58717FFE6CA
      9BFFF4E7D3FFCE9B3FFFD7AC61FFCA9532FFCB9837FFD5A958FFCD9A3FFFF5E9
      D7FFE1C28BFFC48515FFC48514FFD3A656FF000000000000000000000000BADB
      E800A4C2CC0041424000EAEAEA00EEEEED00F6F6F600F4F4F400000000004F51
      4E00BCDFEF00F6F6F60000000000000000000C0998FFFFFFFFFFAFACF8FF130C
      ECFFAEACF8FF5B57F2FF0D07EBFF7673F4FFAFADF9FF110BECFFC4C2FAFFFFFF
      FFFF0D0A99FF1B199FFF1C199FFF1E1BA0FFB4D88100B4D78100000CA300000C
      A300FEFEFE00FFFFFF00FEFEFE00E7BC7B00E7BC7B00FFFFFF00FEFEFE00FFFF
      FF00000CA200B4D78100B4D78100B4D78100D09E45FFC58514FFC48514FFD9B2
      6CFFF1E0C8FFEAD5ADFFD0A14AFFC89028FFD3A758FFD6AC61FFDFC186FFEFDF
      C3FFD5AC60FFC48513FFC58514FFD3A554FF000000009B9B9B000B070500B2D7
      E400B3D7E0004D4E4C00EFEFEF00EEEEEF00FAFAFA00F5F5F500000000005C5B
      5C00C2E3F2000001000000000000000000001D1B9EFFFFFFFFFF3833EFFF130C
      ECFFAFADF8FF524DF1FFE9E8FDFF6A66F3FFB4B2F9FF140EECFF4843F0FFFFFF
      FFFF15129AFF1C199DFF1C199DFF1E1B9EFFB4D88200B5D78200B5D78100000C
      A300000CA200FFFFFF00FFFFFF00D9942D00D9942D00FEFEFE00FEFEFE00000C
      A20092B18800B5D78200B5D88100B5D78100D5AA5DFFC48514FFC48514FFCD9A
      3EFFE0C28CFFF4E9D5FFE4C99AFFE7CEA0FFF6E8D4FFF6E8D5FFF4E5CFFFDEC0
      8AFFCB9637FFC58514FFC58515FFD8B26EFF000000004E4E4E00262725000D08
      0400B4DEF300818080004A4B4900F0F1EE00F2F2F200000000005B5C5A005455
      520032333000444644006A696900000000002824A0FFFFFFFFFF2822EDFFB0AE
      F8FFF2F2FEFF0D07EBFF1E18EDFF0D07EBFFF3F2FEFF9895F6FF3530EFFFFFFF
      FFFF1D199BFF1E1A9CFF1E1A9BFF201C9CFFB5D88200B5D88200B5D88100B5D8
      8100000DA300000DA300FEFEFE00FFFFFF00FEFEFE00FEFEFE00000DA3000E1D
      A000B5D88200B5D88200B5D88200B4D88100E3C897FFC58719FFC48515FFC88F
      28FFDBB775FFE6CDA1FFF5EBD9FFF7EEDFFFF7EDDEFFF7EBDAFFE5CA9BFFD9B5
      74FFC78D23FFC58515FFC6881CFFE7D1A7FF0000000000000000040503003030
      2F0037332E00B8F3FF00858480006E6F6D0013141200737472009F9E9F003938
      39007D7C7C00F8F8F8000000000000000000110D95FFFFFFFFFF6C68F3FF110A
      ECFFF7F7FEFFE1E0FCFF241EEDFFDAD9FCFFF1F0FEFF1610ECFF837FF5FFFFFF
      FFFF0E0A94FF1E1A9BFF1E1A9BFF201C9CFFB5D88200B4D78100B5D78100B5D7
      8100B5D78100000CA200000DA300FEFEFE00FEFEFE00000CA3000E1DA000B4D7
      8100B5D78100B4D78100B5D78100B5D78100F4EDDCFFCC993CFFC48513FFC586
      15FFD1A14CFFDCB879FFE2C592FFEBD3ACFFEAD3ABFFE1C48EFFDAB876FFCF9E
      45FFC48615FFC48413FFCF9E45FFF8F2E5FF0000000000000000000000001414
      1500383937004B4C4900A9DCF40093A2A30055595B001B1A180045464400A9AA
      A900E1E4FA000000000000000000000000001A1699FFEDECF7FFFFFFFFFF120B
      ECFF1009ECFFF5F5FEFF716DF3FFFFFFFFFF2D28EEFF110BECFFFFFFFFFFDEDE
      F0FF1C189AFF1E1A9BFF1E1A9BFF201C9CFFB5D88200B5D88100B5D88100B5D7
      8100B5D88100B5D78100000DA300868DD300000CA300000CA300B5D88100B5D7
      8100B5D88100B5D88100B5D88100B5D88100FDFFFEFFE3CC9EFFC5871BFFC485
      15FFC48717FFCD993CFFD6AD60FFD9B36EFFD9B36CFFD6AB5EFFCD9736FFC486
      16FFC48615FFC58A1EFFE7D3A9FFFEFFFFFF0000000000000000000000000000
      000041434100696B6900575856007FA1B100322B28004B4C49008A898700306C
      E900DCE3F7000000000000000000000000001F1B9BFF211E9CFFFFFFFFFFE6E5
      FDFF0F09EBFF1812ECFF9C99F7FF1A13ECFF110AECFFF0EFFEFFFFFFFFFF1915
      99FF1E1A9BFF1E1A9BFF1E1A9BFF28249FFFB4D8820000000000000000000000
      0000B5D882000000000000000000000DA200000DA20000000000B5D882000000
      00000000000000000000B4D78100B4D78100FFFFFFFFFCFAF5FFDDBA7CFFC587
      19FFC48514FFC48514FFC48616FFC5881AFFC68819FFC48515FFC48514FFC386
      13FFC5881CFFDDC088FFFDFCF9FFFFFFFFFF0000000000000000000000000000
      000000000000060506004E4E4E005B5B5B0058585800B6B6B7003167C900306C
      D400DCE4F600000000000000000000000000171398FF221E9DFF4542ACFFFFFF
      FFFFFFFFFFFFD1CFFBFFA5A2F8FFD5D4FBFFFFFFFFFFFFFFFFFF3733A6FF211D
      9CFF1E1A9BFF1E1A9BFF201C9CFF5855B4FFB5D88200B5D88200B5D88200B5D8
      8200B5D88200B5D88200B5D88200B5D88200B5D88200B5D88200B5D88200B5D8
      8200B5D88200B5D88200B5D88200B5D88200FFFFFFFFFFFFFFFFFBF9F4FFE1C8
      95FFCA9432FFC58616FFC58514FFC48615FFC48615FFC48514FFC58617FFCC97
      37FFE4CC9EFFFCFBF7FFFFFFFFFFFFFFFFFF0000000000000000000000000000
      000000000000000000000B0C0A006B6C6900B0B1AF0000000000156AD100005C
      CE0000000000000000000000000000000000312DA3FF221E9DFF211D9CFF110D
      95FFACABDAFFFEFEFFFFFFFFFFFFFDFDFFFFA4A2D6FF0F0B94FF211D9CFF1E1A
      9BFF1E1A9BFF1E1A9BFF141097FFF4F4FAFFB5D7820000000000B5D78200B5D7
      8100B5D7820000000000B5D7810000000000B5D78200B5D78100B5D782000000
      0000B5D7810000000000B5D78100B4D78100FFFFFFFFFFFFFFFFFFFFFFFFFCFE
      FDFFF0E6CFFFDCBC80FFCE9D43FFC8912CFFC9912DFFCF9F46FFDEBF85FFF3EA
      D5FFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      00000000000000000000000000004E4F4C000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFF3330A4FF161297FF1D19
      9BFF211D9CFF151197FF100C95FF151197FF211D9DFF1E1A9BFF1E1A9BFF1E1A
      9BFF1A1699FF110D95FFC7C6E6FFFCFCFEFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009936
      2F00000000000000000099362F0000000000000000000000000099362F000000
      000099362F0099362F0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000F2FF0000F2FF0000F2FF0000F2
      FF0000F2FF0000F2FF0000F2FF00000000000000000000000000000000000000
      00000000000035F7454646E86C7039F04C500000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CC483F00CC483F00CC483F00CC483F00CC483F00CC483F00CC483F00CC48
      3F0000000000000000000000000000000000000000000000000099362F000000
      000099362F000000000099362F0000000000000000000000000099362F000000
      000099362F000000000099362F00000000000000000000000000000000000000
      0000F36D4D00F36D4D00F36D4D000000000000F2FF0084848400848484008484
      8400848484008484840000F2FF00000000000000000000000000000000003CB1
      E1E82477E3FF267AE4FF2897EFFF2780E7FF2F51B7FF495795F80BFE0B0C0000
      0000000000000000000000000000000000000000000000000000CC483F00CC48
      3F00EAD999007373FF00000000000000000000000000000000007373FF00EAD9
      9900CC483F00CC483F000000000000000000000000000000000099362F000000
      000099362F00000000000000000099362F0099362F0099362F00000000000000
      000099362F000000000099362F00000000000000000000000000000000000000
      0000F36D4D00F36D4D00F36D4D000000000000F2FF0000F2FF0000F2FF0000F2
      FF0000F2FF0000F2FF0000F2FF0000000000000000000EFE0E0F2573E2FF2685
      E8FF2687E9FF2787E9FF277FE6FF2AA2F2FF2675E3FFBA7725FFB27D59FF2AF6
      32350000000005FE050600000000000000000000000000000000CC483F00E7BF
      C800EAD999007373FF00000000000000000000000000000000007373FF00EAD9
      9900E7BFC800CC483F000000000000000000000000000000000099362F000000
      000099362F00000000000000000099362F000000000099362F00000000000000
      000099362F000000000099362F00000000000000000000000000000000000000
      0000F36D4D00F36D4D00F36D4D000000000000F2FF0084848400848484008484
      8400848484008484840000F2FF0000000000000000002268DDFF2F6AD3FF606A
      A2FF2665D8FF28B4F8FF2997EEFF277AE5FF3A58B4FFB17238FF5792A5FF236C
      D5FF3585C7E748D7697508FE08095CFA93940000000000000000CC483F00E7BF
      C800CC483F00CC483F00CC483F00CC483F00CC483F00CC483F00CC483F00CC48
      3F00E7BFC800CC483F000000000000000000000000000000000099362F000000
      000099362F0000000000000000000000000099362F0000000000000000000000
      000099362F000000000099362F00000000000000000000000000000000000000
      0000F36D4D00F36D4D00F36D4D000000000000F2FF0000F2FF0000F2FF0000F2
      FF0000F2FF0000F2FF0000F2FF00000000004AD1919A2D59C7FFE6B452FFE7B7
      54FFECC277FFEDC88BFFCF9745FFAE7024FF40ACCEFF26AEF2FF1350ADFF155D
      B6FF44C8AEBD51E9C4C556ECFFFF5EF89FA00000000000000000CC483F00CC48
      3F00EAD999007373FF00000000000000000000000000000000007373FF00EAD9
      9900CC483F00CC483F000000000000000000000000000000000099362F000000
      000099362F0000000000000000000000000099362F0000000000000000000000
      000099362F0099362F0000000000000000000000000000000000000000000000
      0000F36D4D00F36D4D00F36D4D000000000000F2FF0084848400848484008484
      8400848484008484840000F2FF00000000002F98F3FF414994FFF0C45CFFF1C7
      61FFF1CD80FFB37931FF2C4AB9FF1D46D0FF1D45D0FF1D45D0FF2280E4FF2ACB
      FFFF34D2FFFF39D6FFFF53E9C8C9000000000000000000000000CC483F00E7BF
      C800EAD999007373FF00000000000000000000000000000000007373FF00EAD9
      9900E7BFC800CC483F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F36D4D00F36D4D00F36D4D000000000000F2FF0000F2FF0000F2FF0000F2
      FF0000F2FF0000F2FF0000F2FF000000000033A2F8FF030F85FF856C67FFB38C
      62FF4653A6FF1A3DC2FF1C41CCFF1A37C2FF1524B2FF1E4DD2FF32A0ECFF2BCC
      FFFF29CBFFFF38F94C4D00000000000000000000000000000000CC483F00E7BF
      C800CC483F00CC483F00CC483F00CC483F00CC483F00CC483F00CC483F00CC48
      3F00E7BFC800CC483F0000000000000000000000000000000000000000000000
      00004CB122004CB122004CB12200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F36D4D00F36D4D00F36D4D000000000000000000000000000000000000F2
      FF0000F2FF0000F2FF0000F2FF0000000000236ADEFF07168EFF04128BFF0A1C
      98FF0B199AFF0D189EFF0C109BFF2C67DBFF1D4BD2FF42A7EAFF33D0FEFF32CB
      FAFFA45B1CFF09FE090A00000000000000000000000000000000CC483F00CC48
      3F00EAD999007373FF00000000000000000000000000000000007373FF00EAD9
      9900CC483F00CC483F0000000000000000000000000000000000000000000000
      00004CB122004CB122004CB12200000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F36D4D00F36D4D00F36D
      4D00F36D4D00F36D4D00F36D4D00F36D4D00F36D4D00F36D4D000000000000F2
      FF00848484008484840000F2FF00000000002A80E9FF1E4BD2FF1737BEFF0B1D
      9BFF0D1FA1FF1530B8FF1C41CCFF1D45D0FF2160D9FF2360DAFF45BCF3FF7053
      60FFAA6121FF0000000000000000000000000000000000000000CC483F00E7BF
      C800EAD999007373FF00000000000000000000000000000000007373FF00EAD9
      9900CC483F00CC483F0000000000000000000000000000000000000000000000
      00004CB122004CB122004CB12200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F36D4D00F36D
      4D00F36D4D00F36D4D00F36D4D00F36D4D00F36D4D000000000000F2FF0000F2
      FF0000F2FF0000F2FF0000F2FF00000000002E7ED5F0225BDAFF256ADFFF1F4D
      CFFF1A35C0FF1B3CC7FF1D45D0FF1D49D1FF236ADEFF2982E9FF805C53FFB068
      1AFF645677FF0000000000000000000000000000000000000000CC483F00E7BF
      C800CC483F00CC483F00CC483F00CC483F00CC483F00CC483F00CC483F00CC48
      3F00CC483F00CC483F000000000000000000000000004CB122004CB122004CB1
      22004CB122004CB122004CB122004CB122004CB122004CB12200000000000000
      000000000000000000000000000000000000000000000000000000000000F36D
      4D00F36D4D00F36D4D00F36D4D00F36D4D000000000000F2FF0000F2FF008484
      8400848484008484840000F2FF000000000019FC1B1C1D43CEFF1C3EC9FF1B3C
      C4FF1933BEFF1C43CEFF1D45D0FF1D4AD1FF4253A4FFB56F18FFB66F18FFB66F
      18FF3EE6555C0000000000000000000000000000000000000000CC483F00CC48
      3F00000000000000000000000000000000000000000000000000000000000000
      0000CC483F00CC483F00000000000000000000000000000000004CB122004CB1
      22004CB122004CB122004CB122004CB122004CB1220000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F36D4D00F36D4D00F36D4D000000000000F2FF0000F2FF0000F2FF0000F2
      FF0000F2FF0000F2FF0000F2FF000000000000000000368666AF7F7AA5FF1B3C
      C7FF203FC7FF7C8CD3FFD8BF90FFE7BF7BFFBC7619FFBC7619FFBC7619FF3E6E
      A9E3000000000000000000000000000000000000000000000000CC483F000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CC483F0000000000000000000000000000000000000000004CB1
      22004CB122004CB122004CB122004CB122000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F36D4D000000000000F2FF0000F2FF0084848400848484008484
      8400848484008484840000F2FF0000000000000000003EE5565D3D9D7AA8EEE0
      D1FFF9E7C8FFF5D79AFFF6D9A1FFF3D59EFFC6842DFFC5842EFF4187A6CE0000
      000000000000000000000000000000000000000000000000000000000000CC48
      3F00000000000000000000000000000000000000000000000000000000000000
      0000CC483F000000000000000000000000000000000000000000000000000000
      00004CB122004CB122004CB12200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000F2FF0000F2FF0000F2FF0000F2FF0000F2FF0000F2
      FF0000F2FF0000F2FF0000F2FF000000000000000000000000000000000004FE
      0405368072B8736D94FFA197A4FF8685AEFF3E7D9ACF12FD1314000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CC483F00CC483F00CC483F00CC483F00CC483F00CC483F00CC483F00CC48
      3F00000000000000000000000000000000000000000000000000000000000000
      0000000000004CB1220000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008DA6B70097ADBC002E38
      3A00445256008296A0005C696C005F696D005A676B004D636C0051676F00728A
      9800687A84006F858E005463680061717600000000008C6B52008C6B52008C6B
      52008C6B52008C6B52008C6B52008C6B52008C6B52008C6B52008C6B52008C6B
      52008C6B52008C6B52008C6B52008C6B52000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000363636003636
      3600363636003636360036363600000000000000000036363600363636003636
      360036363600363636000000000000000000A1B5C10097AEBD00879BA700181F
      1E00697B8400B2CEDF009DB7C60098B1BF0095ACBA0040555E0048656B007796
      A900839CAE00728795005D7287005B7D9900DEDED600D6CEC600EFEFEF00EFEF
      EF00D6C6BD00DEDED600EFEFEF00EFEFEF00DEDED600D6C6BD00D6C6BD00E7E7
      DE00EFEFEF00EFEFEF00D6C6BD00D6CEC6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000036363600FFB4
      1600FFB41600FFB4160036363600000000000000000036363600FFB41600FFB4
      1600FFB4160036363600000000000000000096A5AB006C797F00444F52001419
      1700C2CCD000FFFFFF00FFFFFF00D7E3EA0093ABB80039494F004F6A70005D73
      7D00768C9C007A8F9A006D92AF00638FB500B5A594009C846300EFEFEF00EFEF
      EF00A58C6B00A58C6B00EFEFEF00EFEFEF00A58C6B00A58C6B009C846300A58C
      6B00EFEFEF00BDAD9C00845A3100D6CEC6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000363636006336
      0000FFB41600FFB416003636360000000000000000003636360063360000FFB4
      1600FFB41600363636000000000000000000909FA500707F8300333E43004053
      5D00FFFFFF00241CED00241CED00FFFFFF0090A6B200505E6100647B83005367
      6D00788B930072868E00698DA5007D9CB300B5A594009C846300EFEFEF00EFEF
      EF00D6C6BD00845A3100845A3100845A3100845A3100D6C6BD00DEDED6008C6B
      4200BDAD9C008C6B4200BDAD9C00EFEFEF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000363636006336
      0000A46E0000FFB416003636360000000000000000003636360063360000A46E
      0000FFB4160036363600000000000000000098AFBA005D717C006B899C007B9D
      B100FFFFFF00241CED00241CED00FFFFFF00879DA8004B585B00768F99004867
      6B008DA4B100ABC2CD009FB4BD0056757600B5A59400845A3100845A3100845A
      3100EFEFEF0094734A00BDAD9C00B59C840094734A00EFEFEF00EFEFEF00BDAD
      9C00845A31009C846300EFEFEF00EFEFEF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000363636006336
      0000633600006336000036363600000000000000000036363600633600006336
      000063360000363636000000000000000000ABC1CC0063767E007492A4007C9C
      B000FFFFFF00241CED00241CED00FFFFFF008297A100505F610093B1BD00778E
      9C007189940099AEB600AFC4CB008CAAB500B5A594009C7B5200D6C6BD00D6C6
      BD00EFEFEF00BDAD9C009C7B520094734A00BDAD9C00EFEFEF00EFEFEF009C84
      63008C6B42008C6B4200E7E7DE00EFEFEF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000363636003636
      3600363636003636360036363600000000000000000036363600363636003636
      360036363600363636000000000000000000A2BAC800667882007897A60082A4
      B700FFFFFF00241CED00241CED00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CCD7
      DC006E8893006A80890092AAB300829CAA00B5A5940094734A00B5A59400B5A5
      9400DEDED600E7E7DE00845A31008C6B4200E7E7DE00EFEFEF00CEBDB500845A
      3100DEDED6009C846300A58C6B00EFEFEF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000094ADBC005C6C73007793A4007594
      AA00FFFFFF00241CED00241CED00241CED00241CED00241CED00241CED00FFFF
      FF00CDD8DE007189950069818A006A7F8900C6B5A5009C8463009C8463009C84
      6300D6CEC600EFEFEF00B5A59400B5A59400EFEFEF00E7E7DE00A58C6B00B5A5
      9400EFEFEF00D6C6BD009C846300D6CEC6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008298A30048504F00687F90006E8A
      9900FFFFFF00241CED00241CED00241CED00241CED00241CED00241CED00241C
      ED00FFFFFF00839EAC00708B99006A838B00DEDED600DED6CE00DED6CE00EFEF
      EF00EFEFEF00E7DEDE00E7DEDE00DED6CE00E7E7E700DEDED600DEDED600E7E7
      E700EFEFEF00DEDED600E7DEDE00E7DEDE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000363636003636
      3600363636003636360036363600000000000000000036363600363636003636
      360036363600363636000000000000000000697A7F0043443D00677E90007B97
      A600FFFFFF00241CED00241CED00FFFFFF00FFFFFF00FFFFFF00241CED00241C
      ED00FFFFFF007F96A20092AAB500758A9500C6AD8C00C6A58400C6AD8C00BD9C
      7300DEDED600B5946B00C6A58400B5946B00DED6CE00C6AD8C00C6AD8C00DECE
      C600C6A58400C6AD8C00BD9C7B00D6BDAD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000036363600FFB4
      1600FFB41600FFB4160036363600000000000000000036363600FFB41600FFB4
      1600FFB41600363636000000000000000000606F72006C74720090A3AC005763
      6800FFFFFF00241CED00241CED00FFFFFF00FFFFFF00FFFFFF00241CED00241C
      ED00FFFFFF00ADC8D300ADC7D20077909700C6AD8C00D6C6B500DED6CE00BD9C
      7B00D6C6B500C6AD8C00EFEFEF00B5946B00DED6CE00C6AD8C00C6AD8C00D6BD
      AD00C6AD8C00EFEFEF00D6BDAD00D6BDAD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000363636006336
      0000FFB41600FFB416003636360000000000000000003636360063360000FFB4
      1600FFB4160036363600000000000000000074969D0061858F006E888F00697E
      8500FFFFFF00241CED00241CED00241CED00241CED00241CED00241CED00241C
      ED00FFFFFF00B1CCD700BEDCE7007B999B00C6AD8C00C6A58400C6A58400CEB5
      9C00DED6CE00C6AD8C00EFEFEF00B5946B00DED6CE00C6AD8C00C6AD8C00DED6
      CE00C6A58400C6AD8C00BD9C7B00D6BDAD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000363636006336
      0000A46E0000FFB416003636360000000000000000003636360063360000A46E
      0000FFB41600363636000000000000000000577B81004F767F0051777C005E80
      8800FFFFFF00241CED00241CED00241CED00241CED00241CED00241CED00FFFF
      FF00C3CDD30099B4C000ADCBD700758F9600C6AD8C00D6C6B500DECEC600B594
      6B00E7E7E700DEDED600EFEFEF00DED6CE00DEDED600D6C6B500C6AD8C00DED6
      CE00EFEFEF00DEDED600D6BDAD00D6BDAD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000363636006336
      0000633600006336000036363600000000000000000036363600633600006336
      0000633600003636360000000000000000004F6C71005F778600627E89005C78
      8400C1CDD500FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00D3DD
      E1007E97AB0089A4B5008AA5AE00758E9C00CEBDA500C6AD8C00C6AD8C00DECE
      C600EFEFEF00EFEFEF00EFEFEF00EFEFEF00DECEC600D6BDAD00C6AD8C00DED6
      CE00EFEFEF00EFEFEF00D6BDAD00D6BDAD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000363636003636
      3600363636003636360036363600000000000000000036363600363636003636
      3600363636003636360000000000000000006A878D006280860064818A005C7C
      84004E6C7E007F98A10072848B0096A6AA008FA9B3004F606200687A84007C93
      A2008097A700687C8C007C929F0095AAB300EFEFEF00EFEFEF00EFEFEF00EFEF
      EF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00DEDED600E7E7
      E700EFEFEF00EFEFEF00E7DEDE00E7DEDE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006A8890006D8893005E7D86005780
      870045707300486C7200617884009BB3BE00A6C0CD0065777F0063757D008DA5
      B300869CA9006C818C0089A2AD008AA5AE008C6B52008C6B52008C6B52008C6B
      52008C6B52008C6B52008C6B52008C6B52008C6B52008C6B52008C6B52008C6B
      52008C6B52008C6B52008C6B52008C6B52000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A5630000A56300000000
      0000A5630000A563000000000000A5630000A563000000000000A5630000A563
      000000000000A5630000A5630000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      00000000000000000000000000000000000000000000A5630000A56300000000
      0000A5630000A563000000000000A5630000A563000000000000A5630000A563
      000000000000A5630000A5630000000000000000000000000000000000000000
      0000000000000000000000000000404040000000000000000000000000000000
      000000000000000000000000000000000000000000007F7F7F007F7F7F000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000404040004040400000000000000000008000000080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008000
      00000000000000000000000000000000000000000000A5630000A56300000000
      0000A5630000A563000000000000A5630000A563000000000000A5630000A563
      000000000000A5630000A5630000000000000000000000000000000000000000
      000000000000000000007F7F7F00606060004040400000000000000000000000
      00000000000000000000000000000000000000000000000000007F7F7F007F7F
      7F00000000000000000000000000000000000000000000000000000000004040
      4000404040000000000000000000000000008000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      00000000000000000000000000000000000000000000A5630000A56300000000
      0000A5630000A563000000000000A5630000A563000000000000A5630000A563
      000000000000A5630000A5630000000000000000000000000000000000000000
      0000000000007F7F7F007F7F7F00606060004040400040404000000000000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      7F007F7F7F000000000000000000000000000000000000000000404040004040
      4000000000000000000000000000000000008000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      00000000000000000000000000000000000000000000A5630000A56300000000
      0000A5630000A563000000000000A5630000A563000000000000A5630000A563
      000000000000A5630000A5630000000000000000000000000000000000000000
      00007F7F7F007F7F7F0000000000000000000000000040404000404040000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007F7F7F007F7F7F0000000000000000000000000040404000404040000000
      0000000000000000000000000000000000008000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A5630000A56300000000
      0000A5630000A563000000000000A5630000A563000000000000A5630000A563
      000000000000A5630000A5630000000000000000000000000000000000007F7F
      7F007F7F7F000000000000000000000000000000000000000000404040004040
      4000000000000000000000000000000000000000000000000000000000000000
      0000000000007F7F7F007F7F7F00606060004040400040404000000000000000
      0000000000000000000000000000000000008000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF008080
      80000000000000000000000000000000000000000000A5630000A56300000000
      0000A5630000A563000000000000A5630000A563000000000000A5630000A563
      000000000000A5630000A56300000000000000000000000000007F7F7F007F7F
      7F00000000000000000000000000000000000000000000000000000000007F7F
      7F00404040000000000000000000000000000000000000000000000000000000
      000000000000000000007F7F7F007F7F7F004040400000000000000000000000
      0000000000000000000000000000000000008000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A5630000A563000000000000A5630000A563000000000000A5630000A563
      000000000000A5630000A563000000000000000000007F7F7F007F7F7F000000
      00000000000000000000000000007F7F7F000000000000000000000000000000
      00007F7F7F00404040000000000000000000000000007F7F7F007F7F7F000000
      00000000000000000000000000007F7F7F000000000000000000000000000000
      0000404040004040400000000000000000008000000080000000800000008000
      00008000000080000000800000008000000080000000800000000000000000FF
      FF00808080000000000000000000000000004221940000000000000000000000
      0000A5630000A563000000000000A5630000A563000000000000A5630000A563
      000000000000A5630000A5630000000000000000000000000000000000000000
      000000000000000000007F7F7F00606060004040400000000000000000000000
      00000000000000000000000000000000000000000000000000007F7F7F007F7F
      7F00000000000000000000000000000000000000000000000000000000004040
      40004040400000000000000000000000000080000000FFFFFF00800000008000
      0000FFFFFF008000000080000000FFFFFF0080000000800000000000000000FF
      FF00000000000000000000000000000000004221940042219400000000004221
      9400A5630000A563000000000000A5630000A563000000000000A5630000A563
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007F7F7F007F7F7F00606060004040400040404000000000000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      7F007F7F7F000000000000000000000000000000000000000000404040004040
      4000000000000000000000000000000000008000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000000000
      000000FFFF008080800000000000000000000000000042219400422194004221
      9400422194000000000000000000A5630000A563000000000000A5630000A563
      0000422194000000000000000000000000000000000000000000000000000000
      00007F7F7F007F7F7F0000000000000000000000000040404000404040000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007F7F7F007F7F7F0000000000000000000000000040404000404040000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF008080800000000000000000000000000000000000422194000000
      0000422194004221940000000000A5630000A563000000000000A56300004221
      9400422194004221940000000000000000000000000000000000000000007F7F
      7F007F7F7F000000000000000000000000000000000000000000404040004040
      4000000000000000000000000000000000000000000000000000000000000000
      0000000000007F7F7F007F7F7F00606060004040400040404000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080008000000000000000000000000000000000000000
      0000000000004221940042219400000000000000000000000000422194004221
      94000000000042219400422194000000000000000000000000007F7F7F007F7F
      7F00000000000000000000000000000000000000000000000000000000007F7F
      7F00404040000000000000000000000000000000000000000000000000000000
      000000000000000000007F7F7F007F7F7F004040400000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008000800080008000000000000000000000000000000000000000
      000000000000000000004221940042219400000000004221940042219400A563
      000000000000000000004221940042219400000000007F7F7F007F7F7F000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007F7F7F004040400000000000000000000000000000000000000000000000
      00000000000000000000000000007F7F7F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000422194004221940042219400A5630000A563
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF0000FF
      FF008080800000FFFF0000FFFF008080800000FFFF0000FFFF008080800000FF
      FF0000FFFF0000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000008080800000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF008080
      8000808080008080800080808000808080008080800080808000FFFFFF000000
      000000000000000000000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000000000000000000000000000000000FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      0000FFFFFF0000FFFF00000000008080800000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000008000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000805A94008000
      0000800000008000000080000000800000008000000000806000008080000080
      800000FFFF00808080000000000000000000000000000000000000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF00000000000000
      000000000000FFFFFF00000000008080800000000000FFFFFF00808080008080
      800080808000808080008080800080808000FFFFFF0000000000800000008000
      0000800000008000000000000000000000000000000000000000FFFFFF008080
      8000808080008080800080808000808080008080800080808000FFFFFF000000
      0000000000000000000000000000000000000000000000000000800000008000
      0000800000008000000080000000800000008000000080000000AF5A00000080
      800000FFFF0000FFFF0000000000000000000000000000000000FFFFFF000000
      0000FFFFFF0000000000FFFFFF0000000000FFFFFF0000FFFF000000000000FF
      FF000000000000000000000000008080800000000000FFFFFF0080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0080808000FFFFFF0000000000000000008000
      0000000000000000000080000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      00000000000000000000000000000000000000000000BAC5C500800000008000
      00008000000000DF9C0000FFFF0023FFFF008000000080000000800000000080
      600000FFFF0000FFFF000000000000000000000000000000000000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF000000000000000000FFFFFF00000000000000
      00000000000000000000000000008080800000000000FFFFFF0080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0080808000FFFFFF0000000000000000000000
      0000000000000000000080000000000000000000000000000000FFFFFF008080
      8000808080008080800080808000808080008080800080808000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF0060BFFF008000000080000000800000003A3A
      000000FFFF008080800000000000000000000000000000000000FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF000000000000FFFF0000000000FFFFFF0000FF
      FF00FFFFFF0000FFFF00000000008080800000000000FFFFFF00808080008080
      800080808000808080008080800080808000FFFFFF0000000000000000000000
      0000000000000000000080000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009894C500800000008000000080000000800000008000000080000000234E
      230000FFFF0000FFFF000000000000000000000000000000000000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF000000000000FFFF000000000000FFFF00FFFF
      FF0000FFFF00FFFFFF00000000008080800000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF008080
      8000808080008080800080808000808080008080800080808000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000009894
      C5008000000080000000800000008000000080000000800000003A7400000080
      800000FFFF0000FFFF0000000000000000000000000000000000FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF000000000000FFFF0000FFFF000000000000FF
      FF00FFFFFF0000FFFF00000000008080800000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000008D78
      AD00800000008000000080000000C5AD78000000000000FFFF0000FFFF0000FF
      FF0000FFFF00808080000000000000000000000000000000000000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF000000000000FFFF0000FFFF0000000000FFFF
      FF0000FFFF00FFFFFF00000000008080800000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000800000008000000080000000C5AD78000000000080000000800000008000
      00003A74000000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFF
      FF000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF00000000000000000000000000000000000000
      0000AFC5C5008000000080000000800000008000000080000000800000008000
      000000BF740000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0080808000808080008080800080808000808080008080
      8000808080008080800000FFFF00000000000000000000000000000000000000
      00000000000000000000A4ADC50080000000800000008000000080000000C5C5
      940000FFFF008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000080000000
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CADAEB00BFD5E900C5D5
      E900C5DAEE00BCD4E900BAD0EB00C2D5EA00C8DAEE00CDDFF100A6A7B9005A5D
      720057586A004A414A004B414500514648000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D1E2F100CDD9E900CFDDEE00CEDA
      EC00D2E1F300C0D5EB00CCDCEF00D1DCED00D9E5F400D1DDEE0084899C006E73
      84006A6B79006A6A7A005E5D6A006C6D7A0000000000000000000000F8000000
      8000000080000000800000008000000080000000800000008000000080000000
      8000000080000000800000F8F800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000057708F00F2FBFF00EDF6FF00EDF6
      FF00F1FAFF00E0ECFD00DDEBFB00EEF7FF00DEE7F4004C587300424C4D005057
      6B00434D6D00282B3D003D4765003A41580000000000000000000000F8000000
      000000000000000000000000000000000000F8F8000000000000000000000000
      0000000000000000000000F8F800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003E596200B5B8C600BDC1CB00B9BF
      CC00BCC3D100C3C6D000BEC4D000CAD0DA00B7BDC90066718B004B5861003843
      5F002E384E0038425C002F454D002B3D4D0000000000000000000000F8000000
      000000000000000000000000000000000000F8F8000000000000000000000000
      0000000000000000000000F8F800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000003D414A00686D8800797C91006F78
      94006D759200767A910071768D006B7189005B617A00505D7A00243036003C4B
      65002F394D003F4D6F0034585A004C63790000000000000000000000F8000000
      000000000000000000000000000000000000F8F8000000000000000000000000
      0000000000000000000000F8F800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000001352530060719700697FA6006C82
      A8006B81A9006E87AF006A82AA0061779B005A6F94002C405A00252E3F00263E
      49002B4657002D5259002B4749002D51520000000000000000000000F8000000
      000000000000000000000000000000000000F8F8000000000000000000000000
      0000000000000000000000F8F800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00800000008000000080000000800000008000000080000000FFFF
      FF0000000000000000000000000000000000768DA1009FA8C4009CA9C5008B93
      AC00828AA2008695B400808CAA00889BBA008A95B1004F7485003A5B64003056
      5B002D5156003561630034585800305A5C0000000000000000000000F8000000
      000000000000000000000000000000000000F8F8000000000000000000000000
      0000000000000000000000F8F800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0080000000FFFFFF0000FFFF00FFFFFF0000FFFF0080000000FFFF
      FF00000000000000000000000000000000004E686F0072838600C2C8D4005B4C
      5C00747287006E6B7F0076778E006D728B0076799700608A9B0036616500375E
      63003A686C0037656700335F61003060590000000000000000000000F8000080
      0000008000000080000000800000008000000080000000800000008000000080
      0000008000000080000000F8F800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF008000000000FFFF00FFFFFF0000FFFF00FFFFFF0080000000FFFF
      FF0000000000000000000000000000000000DCCDB60035706700618175008D8F
      A0005B699100585B7000757B95005F6378006C748E00959AAC008E9E98003E76
      790044787B004A72740041706E004973700000000000000000000000F8000000
      000000000000000000000000000000000000F8F8000000000000000000000000
      0000000000000000000000F8F800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00800000008000000080000000800000008000000080000000FFFF
      FF0000000000000000000000000000000000FFE2C600C9B8A300E6CBB300B1AC
      B300697B9E006A7598007B7B9100606E910052638600F8E0CC00F5D9C6009BA9
      A200969F96003E7073005C7C7B005876710000000000000000000000F8000000
      000000000000000000000000000000000000F8F8000000000000000000000000
      0000000000000000000000F8F800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000F1CFB000FBD4B400FBD1B300FED6
      B700F6D5BA008F94A700556488009E9DAC00E4CDBE00FBDABB00FADBBF00FFE4
      C400D1BDAC006A838000697973006D7B750000000000000000000000F8000000
      000000000000000000000000000000000000F8F8000000000000000000000000
      0000000000000000000000F8F800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000000000000F1C4A200EFC0A300F0C2A400F4C4
      A500F6C5A500F5C6A600FFD0AE00F6C9AA00F7CAAB00F5CCAE00F7CCAD00F6CC
      AD00FCD1B100E0BBA200EFC9AB00FFDDB90000000000000000000000F8000000
      000000000000000000000000000000000000F8F8000000000000000000000000
      0000000000000000000000F8F800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF000000
      000000000000000000000000000000000000EFBE9A00EDBC9D00EEBDA300EFBF
      A300F0C2A400F4C3A400F5C3A600F6C7A800F6C6A800F6C9AA00F6CAAA00F7CA
      AB00F6CBAB00FBCEAD00FACDAB00F7CDA90000000000000000000000F8000000
      000000000000000000000000000000000000F8F8000000000000000000000000
      0000000000000000000000F8F800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000000000000EFB99500EFB89900EEB99A00EEBA
      9E00EDBB9F00F0BCA000F3BCA000F2C0A200F5C0A300F7C3A500F6C6A600F7C4
      A600F8C4A600F6C3A500F6C3A400F6C8A30000000000000000000000F800A000
      0000A0000000A0000000A0000000A0000000A0000000A0000000A0000000A000
      0000A0000000A0000000A0000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000EFAF8A00EEAD8E00EFB19300EEB3
      9200EEB39400EEB59A00EFB89B00F2B89A00F5B79A00F1B89900F7B99A00F5BD
      9A00F5BD9900F3BE9C00F6C1A200F7C4A3000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000EFB18800F0AF8C00EEB28F00F2B1
      9200F2B29100F0B69400F1BA9700F4B99A00F7B89A00F2B99700F5BE9B00F6BF
      9E00F5C09B00F7C19D00F6C39A00F8C39B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF00FFFFFF0000FFFF00FFFF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000800000008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000000000008000000080000000800000008000000080000000800000008000
      0000800000008000000080000000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000FFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000800000008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0080808000FFFFFF0000FFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0080808000FFFFFF00000000008080800000FFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000800000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000800000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000800000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF0080808000FFFFFF00000000008080800000FFFF00FFFFFF0000FFFF008080
      8000000000000000000000000000000000000000000000000000000000008000
      0000000000008000000080000000800000008000000080000000800000008000
      0000800000008000000080000000800000000000000000000000800000008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000800000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF008080
      8000FFFFFF00000000008080800000FFFF00FFFFFF0000FFFF00808080000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000000080000000800000008000
      0000800000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000000080000000800000008000
      0000800000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00000000008080800000FFFF00FFFFFF0000FFFF0080808000000000000000
      0000000000000000000000000000000000000000000000000000800000008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000800000008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000800000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000800000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000800000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00808080000000000000000000000000008080
      8000800000000000000000000000000000000000000000000000800000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000800000008000000000000000000000000000000000000000800000000000
      0000000000008000000080000000800000008000000080000000800000008000
      0000800000008000000080000000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000800000008000000080000000000000000000000000000000800000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008000000080000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080000000000080808000000000008080800000000000808080000000
      0000808080000000000080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000000000008000000000000000800000008000000000000000000000000000
      0000800000008000000000000000000000000000000080000000800000008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000000000008080800000000000000000000000
      0000000000000000000080808000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800000000000000000000000
      0000000000000000000080808000000000000000000000000000000000008000
      0000000000008000000000000000800000000000000080000000000000008000
      0000000000000000000000000000000000000000000080000000800000008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000800000008000000000000000800000008000000000000000000000008000
      0000000000000000000000000000000000000000000080000000800000008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000000000008080800000000000000000000000
      0000000000000000000080808000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800000000000000000000000
      0000000000000000000080808000000000000000000000000000000000008000
      0000000000008000000000000000800000000000000080000000000000008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000800000000000000000000000800000008000000000000000000000000000
      0000800000008000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000808080000000000080808000000000008080800000000000808080000000
      0000808080000000000080808000000000000000000000000000000000000000
      0000808080000000000080808000000000008080800000000000808080000000
      0000808080000000000080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000800000008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000800000008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000000000008080800000000000000000000000
      0000000000000000000080808000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800000000000000000000000
      0000000000000000000080808000000000000000000000000000000080000000
      0000000000000000800000000000000000000000000000000000000080000000
      0000000000000000800000000000000000000000000080000000800000008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008000000000000000
      0000000080000000000000000000000000000000000000000000000000000000
      8000000000000000000000008000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000000000008080800000000000000000000000
      0000000000000000000080808000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800000000000000000000000
      0000000000000000000080808000000000000000800000000000000000000000
      8000000000000000000000000000000000000000000000000000000000000000
      0000000080000000000000000000000080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000800000000000000000000000
      8000000000000000000000000000000000000000000000000000000000000000
      0000000080000000000000000000000080000000000080000000800000008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000808080000000000080808000000000008080800000000000808080000000
      0000808080000000000080808000000000000000000000000000000000000000
      0000808080000000000080808000000000008080800000000000808080000000
      0000808080000000000080808000000000000000000000008000000000000000
      0000000080000000000000000000000000000000000000000000000000000000
      8000000000000000000000008000000000000000000080000000800000008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000080000000
      0000000000000000800000000000000000000000000000000000000080000000
      0000000000000000800000000000000000000000000080000000800000008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000808080000000000080808000000000000000000000000000808080000000
      0000808080000000000080808000000000000000000000000000808080000000
      0000808080000000000080808000000000008080800000000000808080000000
      0000808080000000000080808000000000000000000000000000808080000000
      0000808080000000000080808000000000008080800000000000808080000000
      0000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000000000000000000000000000808080000000
      0000000000000000000000000000000000008080800000000000000000000000
      0000000000000000000080808000000000000000000000000000808080000000
      0000000000000000000000000000000000008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000000000000000000000000000808080000000
      0000000000000000000000000000000000008080800000000000000000000000
      0000000000000000000080808000000000000000000000000000808080000000
      0000000000000000000000000000000000008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080000000000080808000000000008080800000000000808080000000
      0000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000808080000000000080808000000000008080800000000000808080000000
      0000808080000000000080808000000000000000000000000000808080000000
      0000808080000000000080808000000000008080800000000000808080000000
      0000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000000000000000000000000000808080000000
      0000000000000000000000000000000000008080800000000000000000000000
      0000000000000000000080808000000000000000000000000000808080000000
      0000000000000000000000000000000000008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000000000000000000000000000808080000000
      0000000000000000000000000000000000008080800000000000000000000000
      0000000000000000000080808000000000000000000000000000808080000000
      0000000000000000000000000000000000008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000808080000000000080808000000000000000000000000000808080000000
      0000808080000000000080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000808080000000000080808000000000008080800000000000808080000000
      0000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000808080000000000080808000000000008080800000000000808080000000
      00008080800000000000808080000000000000000000FFFFFF00FFFFFF000000
      0000FFFFFF00FFFF0000FFFFFF00FFFF0000FFFFFF00FFFF0000FFFFFF00FFFF
      0000FFFFFF00FFFF0000FFFFFF000000000000000000FFFFFF00FFFFFF000000
      0000FFFFFF00FFFF0000FFFFFF0080000000FFFFFF00FFFF0000FFFFFF008000
      0000FFFFFF00FFFF0000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
      0000FFFF0000FFFFFF00FFFF0000FFFFFF00FFFF0000FFFFFF00FFFF0000FFFF
      FF00FFFF0000FFFFFF00FFFF00000000000000000000FFFFFF00FFFFFF000000
      0000FFFF0000FFFFFF00FFFF000080000000FFFF0000FFFFFF00FFFF00008000
      0000FFFF0000FFFFFF00FFFF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000000000008080800000000000000000000000
      00000000000000000000808080000000000000000000FFFFFF00FFFFFF000000
      0000FFFFFF00FFFF0000FFFFFF00FFFF0000FFFFFF00FFFF0000FFFFFF00FFFF
      0000FFFFFF00FFFF0000FFFFFF000000000000000000FFFFFF00FFFFFF000000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000008000000080000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFF0000FFFFFF00FFFF0000FFFFFF00FFFF0000FFFFFF00FFFF0000FFFF
      FF00FFFF0000FFFFFF00FFFF00000000000000000000FFFFFF00FFFFFF000000
      0000FFFF0000FFFFFF00FFFF000080000000FFFF0000FFFFFF00FFFF00008000
      0000FFFF0000FFFFFF00FFFF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000000000008080800000000000000000000000
      00000000000000000000808080000000000000000000FFFFFF00FFFFFF000000
      0000FFFFFF00FFFF0000FFFFFF00FFFF0000FFFFFF00FFFF0000FFFFFF00FFFF
      0000FFFFFF00FFFF0000FFFFFF00000000000000000000000000000000000000
      0000FFFFFF00FFFF0000FFFFFF0080000000FFFFFF00FFFF0000FFFFFF008000
      0000FFFFFF00FFFF0000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
      0000FFFF0000FFFFFF00FFFF0000FFFFFF00FFFF0000FFFFFF00FFFF0000FFFF
      FF00FFFF0000FFFFFF00FFFF00000000000000000000FFFFFF00FFFFFF000000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000008000000080000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000808080000000000080808000000000008080800000000000808080000000
      00008080800000000000808080000000000000000000FFFFFF00FFFFFF000000
      0000FFFFFF00FFFF0000FFFFFF00FFFF0000FFFFFF00FFFF0000FFFFFF00FFFF
      0000FFFFFF00FFFF0000FFFFFF000000000000000000FFFFFF00FFFFFF000000
      0000FFFFFF00FFFF0000FFFFFF0080000000FFFFFF00FFFF0000FFFFFF008000
      0000FFFFFF00FFFF0000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
      0000FFFF0000FFFFFF00FFFF0000FFFFFF00FFFF0000FFFFFF00FFFF0000FFFF
      FF00FFFF0000FFFFFF00FFFF00000000000000000000FFFFFF00FFFFFF000000
      0000FFFF0000FFFFFF00FFFF000080000000FFFF0000FFFFFF00FFFF00008000
      0000FFFF0000FFFFFF00FFFF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000000000008080800000000000000000000000
      0000000000000000000080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000000000008080800000000000000000000000
      00000000000000000000808080000000000000000000FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000808080000000000080808000000000008080800000000000808080000000
      0000808080000000000080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFF0000FFFFFF00FFFF000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFF0000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080000000800000008000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFF0000FFFFFF00FFFF000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008000000080000000800000008000000080000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFF0000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFF0000FFFFFF00FFFF000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000800000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFF0000FFFFFF00FFFF000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000800000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000080000000800000000000000000000000FFFF
      0000FFFFFF00FFFF0000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFF0000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFF0000FFFFFF00FFFF000000000000000000000000
      0000800000008000000000000000000000000000000000000000000000000000
      000000000000000000008000000080000000800000008000000000000000FFFF
      FF00FFFF0000FFFFFF00FFFF0000000000000000000000000000000000000000
      0000000000008000000080000000800000008000000080000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFF0000FFFFFF00FFFF000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFFFF00FFFF0000FFFFFF0000000000800000008000
      0000800000008000000080000000000000000000000000000000000000000000
      0000000000000000000000000000800000008000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080000000800000008000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFF0000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000800000008000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFF0000FFFFFF00FFFF000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      00008000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFF0000FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF0000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF0000000000FFFF0000FFFFFF00FFFF000000000000FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFF0000FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8000808080000000000080800000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8000FFFF00000000000000808000808000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8000FFFF00000000000000808000808000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF008080
      8000FFFFFF00FFFFFF00FFFFFF0080808000FFFFFF00FFFFFF00FFFFFF008080
      8000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8000FFFF00000000000000808000808000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF008080
      8000FFFFFF00FFFFFF00FFFFFF0080808000FFFFFF00FFFFFF00FFFFFF008080
      8000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000080808000000000008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8000808080000000000080800000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8000FFFF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF008080
      8000FFFFFF00FFFFFF00FFFFFF0080808000FFFFFF00FFFFFF00FFFFFF008080
      8000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8000FFFF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF008080
      8000FFFFFF00FFFFFF00FFFFFF0080808000FFFFFF00FFFFFF00FFFFFF008080
      8000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF008080
      8000FFFFFF00FFFFFF00FFFFFF0080808000FFFFFF00FFFFFF00FFFFFF008080
      8000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8000000000000000000000008000FFFF000000000000FFFFFF00FFFFFF008080
      8000FFFFFF00FFFFFF00FFFFFF0080808000FFFFFF00FFFFFF00FFFFFF008080
      8000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C0C0C0000000000000008000C0C0C0000000000080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C0C0
      C000000000000000000000000000C0C0C0000000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000008000000080000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000008000C0C0C0000000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000008000000080000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF00000000000000000080800000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000ADBDDE005A5A
      5A0042424200636B6B009C9C9400ADB5B500D6E7E700D6E7E700F7F7F700F7F7
      F700000000000000000000000000000000000000000084000000840000008400
      0000840000008400000084000000840000008400000084000000840000008400
      0000840000008400000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000398CAD002194
      C6000863940018526B0029525A004A524A005A5A5A00636B6B009C9C9400ADB5
      B500BDD6D600D6E7E70000000000000000008400000084636300846363008463
      6300846363008463630084636300846363008463630084636300846363008463
      630084636300846363008463630084000000000000000000000031251B004431
      2300000000001A130D007A573B00825B3F003E2D200000000000211811002A1F
      1600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDD6D600398CAD009CEF
      F7005ACEF70052BDE70042A5D600187BBD000863940018526B0029525A004A52
      4A005A5A5A0084848400D6E7E700000000008400000084636300846363008463
      63008463630084000000C6DEC600C6DEC6008463630084000000C6DEC600C6DE
      C6008463630084000000C6DEC600C6DEC60000000000775940007C5D44007C5C
      41004A3628004B382A007C5F480086674F00654E3A0034281D00533E2D005842
      2F001C140F000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDD6D600187BBD00D6E7
      E7007BE7F7007BE7F7007BE7F7007BE7F7007BE7F7005ACEF70042A5D6002194
      C600086394004A524A00ADB5B500F7F7F7008400000084636300846363008463
      63008463630084000000C6DEC600C6DEC6008463630084000000C6DEC600C6DE
      C6008463630084000000C6DEC600C6DEC600000000000E0B08007D5E47009473
      5700856B55005C4B3A00534233006B5543006E574500534335004E3D2F00533F
      2F001D1610000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDD6D60052BDE70084BD
      C6009CEFF7007BE7F7007BE7F7007BE7F7007BE7F7007BE7F7007BE7F7007BE7
      F70052BDE70029525A00737B7B00D6E7E7008400000084636300846363008463
      63008463630084000000C6DEC600C6DEC6008463630084000000C6DEC600C6DE
      C6008463630084000000C6DEC600C6DEC6000000000019141000735B4800A184
      6C0046A46D00489E6C002E5032004054380049A7710043A16A00317A4B00416A
      4600231C16000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDD6D6005ACEF7005AA5
      D600D6E7E7007BE7F7007BE7F7007BE7F7007BE7F7007BE7F7007BE7F7007BE7
      F7009CEFF700187BA5004A524A00ADB5B5008400000084636300846363008463
      63008463630084000000C6DEC600C6DEC6008463630084000000C6DEC600C6DE
      C6008463630084000000C6DEC600C6DEC6008C725E00846B58009B7F6900A184
      6C0076C59A0068B9910027603A00346A450067B98C0049AA75003F6E47006C7A
      5B007E6754006A56460000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009CCED6005ACEF7002194
      C600D6E7E7009CEFF7009CEFF7009CEFF7009CEFF7009CEFF7009CEFF7009CEF
      F7009CEFF7007BCEE70029525A00636B6B008400000084636300846363008463
      63008463630084000000C6DEC600C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC600C6DEC600C6DEC60084000000A6897200A68A7500A88D76009D7F
      660071C2970068B99100297D4E004DA2730068B99100346845005B4E3C008D74
      5F00A4877200A688720000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000528CA5007BE7F70052BD
      E70084BDC600F7FFFF00D6E7E700D6E7E700D6E7E7009CEFF7009CEFF7009CEF
      F7009CEFF700D6E7E700216B9400424242008400000084636300846363008463
      6300846363008463630084000000C6DEC600C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC600C6DEC6008400000084000000A2887400AA917D00A98D7600A487
      70006DBF940074C19B0068B9910068B991004CA2770032553B00514338007B67
      560099816F008571620000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BDCEA500187B2100188442001884
      4200187B2100187B210018844200528C4200D6E7E700D6E7E700D6E7E700D6E7
      E700D6E7E700F7FFFF0084BDC600294A4A008400000084000000846363008463
      630084636300846363008463630084000000C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC6008400000084636300840000001C181500A48B7800AC907A00AC91
      7D0063B88D0075C09C0037835D004A8A660068B991003D8965003F5846006465
      57008A796B0051473E0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6DEC6001884420031C6630031C6
      630031C6520029AD4A0018A521000084000042A5D60084BDC60084BDC600BDD6
      D600F7FFFF0000000000F7FFFF00317B8C000000000084000000846363008400
      00008400000084000000840000008463630084000000C6DEC600C6DEC600C6DE
      C60084000000846363008463630084000000A7968900BBA69400B0978300B69E
      8C0072BF960096D8B900375F45004351420076C7A20067B994005B8B73007084
      71009C8D800095887E0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007BA5A50018A5210031C6
      630031C6630031C6520029AD4A00088C08009CEFF7009CEFF7007BE7F7007BCE
      E7000863940039849C0084ADC6009CCED6000000000084000000846363008400
      0000000000000000000084000000846363008463630084000000C6DEC6008400
      000084636300846363008463630084000000D2C2B500DDD1C600BFAB9900C6AE
      9B0076C59A0096D8B90096D8B90096D8B90076C7A2006ABA9600659278008999
      8400C0B2A600DACFC50000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F7F7F7002984520031C663004AD6
      730031C6630031C6630031C65200088C080084ADC6009CCED6009CDEE7009CEF
      F700398CAD00BDD6D60000000000000000000000000084000000840000008400
      0000000000000000000084000000846363008463630084636300840000008463
      630084636300846363008463630084000000C4B2A400C6B7AB00C8B6A800C1AA
      97004BAB7D0076C59A0076C59A0076C59A0076C59A00639E7C00A6A29000B8AA
      9A00B1A49900A2958A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000073B57B004AD6730063EF8C004AE7
      73004AD6730031C6630031C6630018A521005A5A5A00BDD6D600BDD6D60084BD
      C600BDD6D6000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000846363008463630084636300846363008463
      630084636300846363008463630084000000C7B4A500B9A79B00C1B1A600CDBC
      AD00C1AA9700C5AF9D00C7B2A100CAB7A600CAB5A500CBB6A500C7B4A400B5A9
      9E0046403C00221F1C0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6DEC60029AD4A0063EF8C0063EF
      8C004AE7730029AD4A0031C6630018A521005A5A5A00D6E7E700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000846363008463630084636300840000008400
      00008400000084000000840000008400000000000000BBAFA700D3C6BD00E9E1
      DA00D5C6BB00C4B1A000C5B09E00C7B3A200C6B3A200CFBFB200E4DBD400D2CA
      C3005F5A55000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6DEC60029AD4A0063EF
      8C0031C65200528C42001884420018A5210084848400D6E7E700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000846363008463630084636300840000000000
      00000000000000000000000000000000000000000000DACDC300D5C8BF00E0D6
      CE00BCB3AB00C2B7AE00DED5CD00E4DBD400BAAFA800928A8400D5CCC300D2C8
      BF00706963000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6DEC600187B
      21009C9C9400F7F7F700C6DEC600187B2100D6E7E70000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000840000008400000084000000840000000000
      0000000000000000000000000000000000000000000000000000DACDC300D0C6
      BD00857E7900CBC0B600E2DBD300E8E1DC00ABA29C0016151400A39B9400CCC0
      B7006D6661000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000F7F7F700CEADAD00BD8C8400C6948C00D6ADA500EFCE
      CE00FFF7F700FFEFEF00BD8C8C00000000000000000000000000000000000000
      00000000000000000000F7F7F700DED6D600A594940084635A0084635A000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000301040000000000000000000000000000000000030104000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000EFDEDE00DEADA500F7CEC600EFC6BD00E7C6BD00E7CE
      C600E7C6BD00CEADA500DEC6BD00F7F7F700000000000000000000000000F7F7
      F700DED6D600ADA5A50084635A0084635A008C7B7300DECEC60084736B000000
      0000000000000000000000000000000000000000000000000000000000000301
      050000000000EDDDD800E9D5CD00D2AB9A00D6B2A500E1C7BE00C99A8A000000
      0000010002000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000000000000000000000000000
      00000000000000000000000000000000000094ADD600427BCE00427BCE008CAD
      DE00E7EFF70000000000F7F7F700E7D6D600C69C9400BD848400CE9C9400CEA5
      A500BD8C8400BD8C8400C69C9C00CEB5AD00C6BDBD00A5949400B5ADA5008463
      5A0084635A008C7B7300CEB5AD00D6BDB500E7D6D600E7D6CE008C7B7B00948C
      8C00BDB5B500000000000000000000000000000000000000000001000100B06C
      5600B16C4E00ECDBD000B0683E00B0693E00B9784F00F6EDE700DCBDAB00D7B3
      A600CEA497000301040000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF0000000000000000000000
      000000000000000000000000000000000000316BBD0031B5F7002194EF002184
      DE001873D6005284C600BD8C8C00CEA59C00CEADAD00D6BDB500E7C6C600EFCE
      C600EFD6CE00F7D6CE00F7E7E700C69C940094736B008C7B73008C7B7300CEB5
      AD00CEBDB500CEBDB500DECEC600DECEC600EFE7DE00E7D6CE0094847B00A594
      8C0084635A00ADA5A50000000000000000000000000003010500E0C4B500AB60
      3A00E3C9B800CB9A7700C2855000C4895200DBB89B00E6CEBC00B8754700B878
      4E00DBBAA900DFC4BD0003010500000000000000000000000000000000000000
      FF000000FF000000FF00000000000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000003173BD0039CEFF0008C6FF0010BD
      FF0010B5FF0031A5E700DEB5B500F7C6A500F7BDA500EFAD8C00EF9C7300E784
      5200DE6B2900D6632900FFF7F700C69C9C0094736B00B59C9400DECEC600CEB5
      B5008C7B7300846B6300B5A59C00DED6CE00F7EFEF00E7D6D6009C847B00B5A5
      9C00D6BDBD0084635A00ADADAD00000000000000000000000000E5CEC200DBBA
      A300F8F1EA00F4E8D700F5E9D800F0E0CC00F9F2EA00DCB78D00C4895200BB7A
      4A00C6917000E4CDC100000000000000000000000000000000000000FF000000
      FF000000FF000000000000000000000000000000FF000000FF000000FF000000
      000000000000000000000000000000000000397BBD008CDEFF0008CEFF0008C6
      FF0008C6FF0018BDF700DEB5AD00E77B4200DE6B3100DE6B2900DE6B3100DE73
      3900E7733900D6632900FFF7F700C69C940094736B00B59C9400DECECE00A594
      8C00BDADAD00CEBDB500B5A59C00D6CEC600FFF7F700EFDEDE008C736B00AD9C
      9400CEB5AD00B594840084635A00EFEFEF0006020900E0C4B500B8754700D0A2
      7B00EBD5B900DBAE6600E2B86B00E6C38600FCF6ED00F8EDDA00EFDECB00D7AD
      8000E2C4A800CEA18600B06B4E000602090000000000000000000000FF000000
      FF0000000000000000000000000000000000000000000000FF000000FF000000
      FF0000000000000000000000000000000000427BC600DEF7FF0021CEFF0008C6
      FF0008C6FF0021BDEF00DEB5AD00E77B4200DE6B3100DE844A00EF9C7300EFA5
      7300EF946300CE6B3900FFF7EF00C69C940094736B00B59C9C00DECEC600CEBD
      B500F7EFDE00FFFFFF00DECECE00DECEC600FFFFFF00EFE7E70094736B00AD94
      8C00C6C6CE0042A5FF00848C8C00F7F7EF0007020B00D9B6A000BF814D00E2C3
      A100EED5A400E8C37100EDCC7600F5E2B300F6E7C200E8C27100E3BE7C00F3E4
      CE00FCF8F500C38B6700AB603A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000000000000000000000004A84C6007BBDEF0042DEFF0010CE
      FF0010CEFF0029C6EF00D6B5B500E77B4200E7844A00EFB58C00F7C69C00F7C6
      9C00F7B58400CE734200FFF7EF00C69C940094736B00B5A59C00E7D6CE00F7E7
      D6000842FF00C6CEEF00E7DECE00E7DED600FFFFFF00F7EFE700947B73009494
      9C002984EF000894FF00009CFF00D6D6D60001000000DCBBA300C68C5400EED7
      B300F1D89800F0D27E00F1D78D00FCF8EA00F4DD9E00EFD17C00E7C27000E6C6
      8E00F6ECE000F2E6DD00BC7F60000C0908000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000000000000000528CCE007BBDEF0073E7FF0018CE
      FF0018D6FF0029CEF700D6B5B500E7845200EFA57300F7D6AD00FFE7CE00FFE7
      CE00FFD6AD00C6734A00FFF7EF00C69C940094736B00BDA59C00E7DED600EFDE
      D600D6CED600D6D6D600EFE7DE00F7EFEF00FFFFFF00FFF7EF0084848C00639C
      CE0008529C00216BB500009CFF0042A5FF0001000000FAF6F300F3E5D600FCF7
      ED00FDF8EA00FCF6E600FCF4E200FEFDFA00F4DEA300F2D78C00EFD07B00F9EF
      DB00DBB48500C7916400F1E3DC000C0908000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF00000000005A94D60084C6EF009CF7FF0018D6
      FF0018DEFF0029D6F700CEBDB500E78C5A00E79C7300EFC6A500EFD6B500D6A5
      8400D6947300C6734200FFF7EF00C69C940094736B00BDA59C00EFE7DE00EFE7
      E700F7EFEF00FFFFF700FFFFFF00FFFFFF00F7F7F700C6DEEF004284BD00087B
      FF0042B5FF005A9CD6003173B50084A5C60000000000E3C9B800D3A15F00F3E1
      B800F7E5B800F7E4B600FBF1DB00FDF8EE00FEFAF200FAF1D800F5E3AD00F8EF
      DB00D8AA6400C1855000E4CABA000000000000000000FFFF0000000084000000
      840000008400FFFF0000FFFF0000FFFF00000000000000000000000000000000
      00000000000000000000000000000000FF00639CD6005AADE700DEF7FF00ADEF
      FF0094EFFF0063E7FF00BDBDBD00F7DED600F7DED600F7E7DE00FFEFEF00FFF7
      EF00FFF7EF00FFFFF700FFFFFF00BD948C0094736B00C6ADA500F7EFEF00F7EF
      EF00F7EFE700DED6D600BDB5AD00BDAD9C0094BDEF000084FF00087BFF000084
      FF0052C6FF0000A5FF0029A5FF00B5BDC60001000200CDA18E00DCB27600F3DD
      A800F8E9C400F9EBCA00FDF9EF00FBF2DF00F9EAC700F9EBC800FFFFFF00F2DF
      B700D8A86300CB996F00DDC0B3000100020000000000FFFF000000008400FFFF
      FF0000008400FFFF0000FFFF0000FFFF00000000000000000000000000000000
      0000000000000000000000000000000000006BA5DE004ABDEF00429CDE004A9C
      DE004AA5DE00A5D6F700B5CED600BD948C00BD948C00BD948C00BD948C00BD94
      8C00BD948C00BD948C00BD948C00C6A59C0094736B00C6B5AD00E7DED600C6B5
      AD0094847B007B635A006B524A0073635A00CEDEEF0073BDFF00189CFF0052AD
      FF007BC6FF0010A5FF0063BDFF00D6D6D6000000000000000000EBD5B800ECCF
      8C00FBF1D800FBF0D900FEFDFA00FCF4E200F9ECCC00FCF5E400F6E6B700F6E9
      CA00E8CEAE00EEDED20000000000000000000000000000FFFF00000084000000
      84000000840000FFFF0000FFFF0000FFFF000000000000000000000000000000
      00000000000000000000000000000000000073A5DE005AE7FF0052DEF70052D6
      F7004ABDEF005ABDEF007BCEF7007BDEFF0084DEFF007BDEFF0084E7FF0094EF
      FF006B9CCE0000000000000000000000000094736B00E7DEDE00E7DED600E7DE
      D600EFDEDE00EFE7DE00EFE7DE00EFE7DE00EFE7DE00FFF7E700BDD6F700189C
      FF00189CFF006BBDFF0094736B00F7F7F7000000000003010500EAD8CE00F7ED
      DA00FBF4E200FEFAF300FFFFFE00FDF8ED00FCF4E300F9EECF00ECCC7900DDB4
      7700FCF8F400C38E750006020A00000000000000000000FFFF0000FFFF000000
      840000FFFF0000FFFF000000FF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000007BADE700A5FFFF0073F7FF006BF7
      FF007BEFFF0063A5DE005AA5DE006BBDE7006BC6EF006BCEF70063C6EF00528C
      C600ADC6DE00000000000000000000000000AD8C8400FFFFF700FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00ADCEF700189CFF0094736B00EFEFEF00000000000000000007020B00E0C3
      AE00F2E3CE00F6E3B400F9EBC900FEFCF700FDF8ED00EED08500F0D9AD00E8D2
      BE00C8977A0004040400000000000000000000000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF0000000000000000000000000000000000
      0000000000000000000000000000000000009CBDE700739CDE00739CDE00739C
      DE00639CD600000000000000000000000000A5BDE7006B94D6007BADDE000000
      000000000000000000000000000000000000F7F7F700AD8C8400F7EFEF00EFDE
      DE00EFDEDE00EFE7DE00E7D6CE00E7D6CE00E7D6CE00E7D6CE00E7D6CE00E7D6
      CE00EFD6CE00FFFFFF0094736B00EFEFEF000000000000000000000000000602
      0A0000000000FFFFFF00F7EBD200F1DEB600F3E4CE00F7EFE900D0A482000000
      0000030105000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F7F7EF00AD8C8400AD8C
      8400AD8C8400AD8C8400AD8C8400AD8C8400AD8C8400AD8C8400AD8C8400AD8C
      8400AD8C8400AD8C840000000000000000000000000000000000000000000000
      0000000000000301040003030300000000000000000000000000030104000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FAF9F900CAAE9900B7886500AF764C00AF774D00B88A6700CCB19E00FDFE
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000BD99
      7E009F561E00BB733B00BD784200BE7A4400BE7A4400BD784100BA723B00A15A
      2400C6A892000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A8744D00CE9F
      7A00D09D7600BA753E00BD7A4600BD7A4600BD7A4600BD7A4600BD7A4600BF7B
      4600B36A3300B083630000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000BC987D00B2662B00E3C6
      B00000000000B2642800BC784400BD7A4600BD7A4600BD7A4600BD7A4600BD7A
      4600BE7A4600B36B3200C5A79100000000000000000000000000000000000000
      000000000000FFFFFF000000000000000000FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000F5F2F000A35B2500BE7B4600B66D
      3400CF9F7A00FDFCFB00B56B3100BC794500BD7A4600BD7A4600BD7A4600BD7A
      4600BD7A4600BF7B4600A15A2400FCFDFD000000000000000000000000000000
      0000000000000000000000FF000000000000FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000C5A58D00BC753D00BD7A4600BC79
      4500B66D3400FBF7F500EFDFD200B4682D00BC794500BC794500BD794500BD7A
      4600BD7A4600BD7A4600BA723B00CBB09D000000000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000000000FFFFFF0000000000FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000010101000FFFFFF000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
      00000000000000000000FFFFFF0000000000B37F5900BD784200BC784400BB77
      4300BA754000B56A300000000000D8B29300B76E3600BB764100BB764100BB77
      4100BB774200BC784300BC764000B78967000000000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF00000000000000000000FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000006B6B
      E7004A4AE700DEDEDE00DEDEDE00DEDEDE00DEDEDE0010101000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000840000008400000084
      0000008400000084000000840000008400000084000010101000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000A96B3C00BF7C4700C2845400C58B
      5E00C8916600C9936800C994690000000000D1A37F00CE9D7600C8926700C790
      6400C68C5F00C4895B00C2825000B0784F000000000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000000000FFFFFF0000000000FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000DEDE
      DE005A5AE700DEDEDE00DEDEDE006363E7004A4AE70010101000FFFFFF000000
      00000000000000000000FFFFFF00000000000000000000840000008400000084
      0000008400000084000000840000008400000084000010101000FFFFFF000000
      00000000000000000000FFFFFF0000000000BA896400CD996F00CA966D00CA96
      6C00CA956B00CA956B00C7906400CE9D770000000000EAD5C500D7AF9000D7B0
      9000DAB59700C9936800CC966C00C29878000000000000000000000000000000
      0000000000000000000000FF000000000000FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000DEDE
      DE00DEDEDE004242E7008C8CE7005A52E700B5B5E70010101000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000084FF000000008400FFFF
      FF000000840084FF000084FF000084FF000084FF000010101000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000C49E8100CA936800CA956B00CA95
      6B00CA956B00CA956B00C8916600D7AF9000F0E1D600FCF9F700F4EAE2000000
      0000C68D6000C7906400CA936700C8A58B000000000000000000000000000000
      000000000000FFFFFF000000000000000000FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000DEDE
      DE00DEDEDE005A5AE7004242E700DEDEDE00DEDEDE0010101000FFFFFF000000
      00000000000000000000FFFFFF00000000000000000000FFFF0000008400FFFF
      FF000000840000FFFF0000FFFF0000FFFF0000FFFF0010101000FFFFFF000000
      00000000000000000000FFFFFF0000000000D5BEAF00C88F6200CA956B00CA95
      6B00CA956B00CA956B00C9946A00C4895A00F1E4D900D8B29400BE7E4A00E3C8
      B200FCFBF900D7AF9000C48A5C00DBC8BB000000000000000000000000000000
      000000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000DEDE
      DE00DEDEDE009C9CE700DEDEDE00DEDEDE00DEDEDE0010101000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000FFFF00000084000000
      84000000840000FFFF0000FFFF0000FFFF0000FFFF0010101000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FDFEFF00B37B5000CB966B00CA95
      6B00CA956B00CA956B00C9936900C9946A0000000000ECDACC00C7906300F6EE
      E800D9B39600C9916400B27B5200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000DEDEDE00DEDEDE00DEDEDE0000000000000000000000
      00000000000000000000000000000000000000000000FFFF84004284FF000000
      84004284FF00FFFF8400FFFF84000000FF00FFFF840000000000000000000000
      00000000000000000000000000000000000000000000D6C0B100BF865800CB95
      6B00CA956B00CA956B00C9936800D3A78500CE9F7800F0E1D500FCF9F7000000
      0000DAB29300BA7E4F00DDCCC100000000000000000000000000000000000000
      00000000000000FFFF0000FFFF000000000000FFFF0000FFFF000000000000FF
      FF0000FFFF00000000000000000000000000000000000000FF000000FF000000
      FF000000FF0000000000DEDEDE00DEDEDE00D6D6DE0010101000000000000000
      00000000000000000000000000000000000000000000FFFF8400FFFF84000000
      8400FFFF8400FFFF84000000FF0000FFFF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000C8AA9400BD83
      5600CB956A00CA956B00CA956B00C9936800C68D6000E2C5AE00CD9A7200C589
      5900C3916A00CEB4A10000000000000000000000000000000000000000000000
      00000000000000FFFF0000FFFF000000000000FFFF0000FFFF000000000000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000DEDEDE00DEDEDE000000000010101000000000000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF000000FF0000000000FF00FF00000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000DECD
      C200B37E5600C2895D00C9916500CA926700C9926600C78D5E00C0865900B37F
      5900E2D4CA000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000DEDE
      DE00DEDEDE00DEDEDE00DEDEDE00000000000000FF0010101000000000000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF00000010101000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E2D4CB00CFB39F00C8A58B00C9A68C00CFB4A000E4D8CF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001010100000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000009C9C0000636300009C
      9C0000636300009C9C0000636300009C9C00000000000000000000000000009C
      9C0000636300009C9C0000636300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000063630031CECE009CCE9C00639C
      9C009CCE9C0000FFFF0000FFFF0000FFFF0000000000CE63310000636300639C
      9C009CCE9C00639C9C0031CECE00009C9C000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      000000FF000000FF000000FF000000000000FFFFFF0084848400848484008484
      84008484840084848400FFFFFF00000000000000000000000000C6A5E700C6A5
      E70000000000C6634200C66342000000000084C6E70084C6E7000000000084E7
      630084E76300000000000000000000000000009C9C0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF000000000000CECE00633100004200000000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF00006363000000000000000000000000000000
      00000000000000FF000000000000FFFFFF00FFFFFF0084848400848484008484
      84008484840084848400FFFFFF00000000000000000000000000000000000000
      000000FF000000FF000000FF000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000C6A5E700C6A5
      E70000000000C6634200C66342000000000084C6E70084C6E7000000000084E7
      630084E763000000000000000000000000000063630031CECE009CCE9C00639C
      9C009C9C9C0000FFFF00633100009C313100FF633100009C9C0031CECE009C9C
      9C0063CE9C009C9C9C0031CECE00009C9C000000000000000000000000000000
      000000FF000000FF000000FF000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      000000FF000000FF000000FF000000000000FFFFFF0084848400848484008484
      84008484840084848400FFFFFF00000000000000000000000000C6A5E700C6A5
      E70000000000C6634200C66342000000000084C6E70084C6E7000000000084E7
      630084E76300000000000000000000000000009C9C0031CECE009C9C9C0063CE
      9C009CCE9C0000FFFF009C310000FF633100FF6331009C3100000000000031CE
      CE009CCE9C00639C9C0031FFCE000063630000000000000000000000000000FF
      000000FF000000FF000000FF000000FF000000000000FFFFFF00FFFFFF008484
      84008484840084848400FFFFFF00000000000000000000000000000000000000
      000000FF000000FF000000FF000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000C6A5E700C6A5
      E70000000000C6634200C66342000000000084C6E70084C6E7000000000084E7
      630084E763000000000000000000000000000063630000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0063313100FF633100FF6331003163630000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF00009C9C00000000000000000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      000000FF000000FF000000FF000000000000FFFFFF0084848400848484008484
      84008484840084848400FFFFFF00000000000000000000000000C6A5E700C6A5
      E70000000000C6634200C66342000000000000000000000000000000000084E7
      630084E76300000000000000000000000000009C9C0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF009C310000FF6331004242420000FFFF0000FFFF0031CE
      CE009C9C9C0063CE9C0031CECE00006363000000000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      000000FF000000FF000000FF000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000C6A5E700C6A5
      E70000000000C6634200C66342000000000000000000000000000000000084E7
      630084E763000000000000000000000000000063630000FFFF0000CECE000031
      9C0000FFFF0000FFFF006331310042424200009CCE0000FFFF0000FFFF0031CE
      CE009CCE9C00639C9C0063CECE00009C9C000000000000000000000000000000
      000000FF000000FF000000FF000000000000000000000000000000000000FFFF
      FF008484840084848400FFFFFF00000000000000000000000000000000000000
      000000FF000000FF000000FF000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000C6A5E700C6A5
      E70000000000C6634200C66342000000000000000000000000000000000084E7
      630084E76300000000000000000000000000009C9C0000FFFF0000FFFF0000CE
      FF0000319C0000FFFF000000000000319C0000CECE0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF00006363000000000000000000000000000000
      000000FF000000FF000000FF000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000000000FFFF
      FF008484840084848400FFFFFF00000000000000000000000000C6A5E700C6A5
      E70000000000C6634200C66342000000000000000000000000000000000084E7
      630084E763000000000000000000000000000063630000FFFF000063CE00009C
      9C00009CFF0031CECE0000FFFF00009CCE000063CE0000CECE0000FFFF0031CE
      CE009C9C9C0063CE9C0031CECE00009C9C000000000000000000000000000000
      000000FF000000FF000000FF000000000000FFFFFF00FFFFFF00848484008484
      84008484840084848400FFFFFF0000000000000000000000000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000C6A5E700C6A5
      E7000000000000000000000000000000000000000000000000000000000084E7
      630084E76300000000000000000000000000009C9C0000FFFF000063CE00009C
      CE0000CECE0031CECE0000FFFF000063CE00009CCE00009CCE0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF00006363000000000000000000000000000000
      000000FF000000FF000000FF000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000000000FF
      000000FF000000FF000000FF000000FF000000000000FFFFFF00FFFFFF008484
      84008484840084848400FFFFFF00000000000000000000000000C6A5E700C6A5
      E7000000000000000000000000000000000000000000000000000000000084E7
      630084E763000000000000000000000000000063630000FFFF0000FFFF0000CE
      CE0000319C00009CCE0000CECE0000319C0000FFFF0000FFFF0000FFFF003100
      00009C3100006331310042000000CE00CE000000000000000000000000000000
      000000FF000000FF000000FF000000000000FFFFFF00FFFFFF00848484008484
      84008484840084848400FFFFFF00000000000000000000000000000000000000
      000000FF000000FF000000FF000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000C6A5E700C6A5
      E700000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000009C9C0000FFFF0000FFFF000031
      9C0000FFFF000063CE0000FFFF0000CECE000063CE0000FFFF0000FFFF009C31
      3100FF633100CE633100CE00CE00000000000000000000000000000000000000
      000000FF000000FF000000FF000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000FF000000000000FFFFFF00FFFFFF0084848400848484008484
      84008484840084848400FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000063630000FFFF0000FFFF0000FF
      FF0000FFFF0000CECE0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF006331
      0000CE3131009C009C0000000000000000000000000000000000000000000000
      000000FF000000FF000000FF000000000000FFFFFF00FFFFFF00848484008484
      84008484840084848400FFFFFF00000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000009C9C0031CECE009C9C9C0063CE
      9C009C9C9C00639C9C009CCE9C0000FFFF0000FFFF0000FFFF0000FFFF004200
      0000CE00CE000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000009C630000639C00009C
      6300009C9C0000636300009C9C0000636300009C9C0000636300009C9C00CE00
      CE00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009C31
      0000000000000000000000000000000000000000000000000000000000009C9C
      9C00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000000000009C310000CE63
      00006300000000000000000000000000000000000000000000009C9C9C00CECE
      CE009C9C9C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008400000084000000840000008400
      0000FFFFFF00FFFFFF000000000000000000000000009C3100009C310000E7E7
      E7009C310000000000000000000000000000000000009C9C9C009C9C9C00E7E7
      E7009C9C9C000000000000000000000000000000000000000000000000000000
      0000FFFFFF00C663840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF008442E7008442E7008442E7008442E7008400000084000000840000008400
      00008442E700FFFFFF0000000000000000009C3100009C310000E7E7E700E7E7
      E700CECECE006300000000000000000000009C9C9C009C9C9C00E7E7E700E7E7
      E700CECECE009C9C9C000000000000000000000000000000000000000000FFFF
      FF004200A5004200A500C6638400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF00000000000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008400000084000000FFFF
      FF00FFFFFF00FFFFFF0000000000000000009C310000E7E7E700E7E7E7009C31
      00009C9C9C009C31000000000000000000009C9C9C00E7E7E700E7E7E7009C9C
      9C009C9C9C009C9C9C0000000000000000000000000000000000000000000000
      00004200A5004200A5004200A500C66384000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000000000000000000000000000FF000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF008442E7008442E7008442E7008442E7008442E70084000000840000008442
      E7008442E700FFFFFF000000000000000000E7E7E700E7E7E7009C3100009C31
      0000848484009C9C9C006300000000000000E7E7E700E7E7E7009C9C9C00CECE
      CE00848484009C9C9C009C9C9C00000000000000000000000000000000000000
      0000000000004200A5004200A5004200A500C663840000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF0000000000000000000000000000000000000000000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008400000084000000FFFF
      FF00FFFFFF00FFFFFF000000000000000000E7E7E7009C310000CE630000CE63
      0000630000009C9C9C009C31000000000000E7E7E7009C9C9C00CECECE00CECE
      CE009C9C9C009C9C9C009C9C9C00000000000000000000000000000000000000
      000000000000000000004200A5008484840084848400C6638400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF008442E7008442E7008442E7008442E7008442E70084000000840000008442
      E7008442E700FFFFFF0000000000000000009C310000CE63000000FFFF00CE63
      00009C3100006363630084848400630000009C9C9C00CECECE00E7E7E700CECE
      CE00CECECE0063636300848484009C9C9C000000000000000000000000000000
      000000000000000000000000000084848400848484004200A500C66384000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF0000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084000000FFFFFF00FFFFFF008400000084000000FFFF
      FF00FFFFFF00840000000000000000000000FF9C0000CE630000CE63000000FF
      FF00CE630000630000009C9C9C0063000000E7E7E700CECECE00CECECE00E7E7
      E700CECECE009C9C9C009C9C9C009C9C9C000000000000000000000000000000
      0000000000000000000000000000000000004200A5004200A5004200A500C663
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF00000000000000000000000000FFFFFF00FFFF
      FF008442E7008442E70084000000840000008400000084000000840000008400
      0000840000008400000000000000000000009C310000CE630000CE63000000FF
      FF00CE63000000FFFF0063636300000000009C9C9C00CECECE00CECECE00E7E7
      E700CECECE00E7E7E70063636300000000000000000000000000000000000000
      000000000000000000000000000000000000000000004200A5004200A5004200
      A500C66384000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084000000840000008400000084000000840000008400
      00008400000084000000000000000000000000000000FF9C0000CE630000CE63
      000000FFFF0000FFFF00630000000000000000000000E7E7E700CECECE00CECE
      CE00E7E7E700CECECE009C9C9C00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000004200A5004200
      A5004200A500C663840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF008442E7008442E7008442E7008442E7008442E7008442E7008442E7008442
      E7008442E700FFFFFF000000000000000000000000009C310000CE630000CE63
      000000FFFF0031639C009C31000063000000000000009C9C9C00CECECE00E7E7
      E700CECECE00CECECE00CECECE009C9C9C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000004200
      A5004200A5004200A500C6638400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000FF9C000000FF
      FF00CE6300009C3100009C310000000000000000000000000000E7E7E700E7E7
      E700CECECE00CECECE009C9C9C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00004200A5004200A50042424200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF008442E7008442E7008442E7008442E7008442E7008442E7008442E7008442
      E7008442E700FFFFFF00000000000000000000000000000000009C310000CE63
      0000CE6300009C310000000000000000000000000000000000009C9C9C00CECE
      CE00CECECE009C9C9C0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000042424200FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000000000000000000000000000000000000FF9C
      00009C310000000000000000000000000000000000000000000000000000E7E7
      E7009C9C9C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009C31
      0000000000000000000000000000000000000000000000000000000000009C9C
      9C00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000000000000000008484840084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF000000000000FFFF000000000084848400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840000000000000000000000000000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      00000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF000000000000FFFF0000FFFF000000000084848400FFFFFF00FFFFFF00FF00
      0000FF000000FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840000000000000000000000000000FF
      FF0000FFFF0000FFFF0000FFFF000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF0000FF
      FF0000FFFF0000000000000000000000000000FFFF0000FFFF0000FFFF000000
      000000FFFF0000FFFF0000FFFF000000000084848400FFFFFF00FFFFFF00FF00
      0000FFFFFF00FF000000FFFFFF00FF000000FF000000FF000000FF000000FF00
      0000FF000000FFFFFF00FFFFFF008484840000000000000000000000000000FF
      FF0000FFFF00000000000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF00000000000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF000000000000FFFF000000000000FF
      FF0000FFFF0000FFFF0000FFFF000000000084848400FFFFFF00FFFFFF00FF00
      0000FF000000FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840000000000000000000000000000FF
      FF0000FFFF0000FFFF0000FFFF000000000000FFFF0000FFFF000000000000FF
      FF0000FFFF0000000000000000000000000000000000000000000000FF000000
      FF000000FF000000000000000000000000000000FF000000FF000000FF000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000000000FFFF000000
      00000000000000FFFF0000FFFF000000000084848400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840000000000000000000000000000FF
      FF0000FFFF0000FFFF0000FFFF000000000000FFFF0000FFFF000000000000FF
      FF0000FFFF0000000000000000000000000000000000000000000000FF000000
      FF0000000000000000000000000000000000000000000000FF000000FF000000
      FF00000000000000000000000000000000000000000000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF000000FF000000FF000000FF0000FFFF0000FFFF0000FF
      FF0000FFFF0000000000000000000000000084848400FFFFFF00FFFFFF00FF00
      0000FF000000FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840000000000000000000000000000FF
      FF0000FFFF00000000000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000000000000000000000000000000000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF000000FF000000FF000000FF00000000000000000000FF
      FF0000FFFF0000FFFF0000FFFF000000000084848400FFFFFF00FFFFFF00FF00
      0000FFFFFF00FF000000FFFFFF00FF000000FF000000FF000000FF000000FF00
      0000FF000000FFFFFF00FFFFFF008484840000000000000000000000000000FF
      FF000000000000FFFF0000FFFF000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF0000000000000000000000000000FFFF0000FFFF0000FF
      FF0000FFFF00000000000000FF000000FF000000FF0000FFFF0000FFFF000000
      00000000000000FFFF0000FFFF000000000084848400FFFFFF00FFFFFF00FF00
      0000FF000000FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840000000000000000000000000000FF
      FF000000000000FFFF0000FFFF000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF00000000000000000000FFFF0000FFFF0000FF
      FF000000000000FFFF0000FFFF000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF000000000000FFFF000000000084848400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840000000000000000000000000000FF
      FF0000FFFF00000000000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000FFFF0000FFFF000000
      000000FFFF0000FFFF0000FFFF000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF000000000000FFFF000000000084848400FFFFFF00FFFFFF00FF00
      0000FF000000FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840000000000000000000000000000FF
      FF0000FFFF0000FFFF0000FFFF000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF000000000000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF000000000000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF00000000000000000084848400FFFFFF00FFFFFF00FF00
      0000FFFFFF00FF000000FFFFFF00FF000000FF000000FF000000FF000000FF00
      0000FF000000FFFFFF00FFFFFF008484840000000000000000000000000000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF000000000000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF000000000084848400FFFFFF00FFFFFF00FF00
      0000FF000000FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00848484000000000000000000000000000000
      000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF000000000000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF00000000008484840084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400848484000000000000000000000000000000
      0000000000000000000000FFFF0000FFFF0000FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF00000000000000000000000000000000000000000000000000
      00000000000000000000FF000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF0042424200FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      00004242420000FFFF0000FFFF00000000000000000000000000000000000000
      00000000000000000000FF000000C6C6A500FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00C6C6A500FF00000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFF
      FF00FFFFFF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF000000000000000000000000000000000000FFFF0000FFFF004242
      420042424200FF000000FF000000FF000000FF000000FF000000FF0000004242
      42004242420000FFFF0000FFFF00000000000000000000000000000000000000
      000000000000FF000000FF000000C6C6A500FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00C6C6A500FF000000FF000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF0000000000000000000000000000000000FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF000000000000000000000000000000000000FFFF0000FFFF0000FF
      FF0000FFFF00424242004242420042424200FF000000FF0000004242420000FF
      FF0000FFFF0000FFFF0000FFFF00000000000000000000000000000000000000
      000000000000FF00000000000000000000000000000000000000000000000000
      00000000000000000000FF00000000000000FF0000000000FF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF000000000000000000000000000000000000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0042424200424242004242420000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF00000000000000000000000000000000000000
      00000000000000000000FF000000C6C6A500FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00C6C6A500FF000000000000000000000000000000FF0000000000FF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF000000000000000000000000000000000000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000
      FF000000FF000000FF0000FFFF00000000000000000000000000000000000000
      000000000000FF000000FF000000C6C6A500FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00C6C6A500FF000000FF0000000000000000000000FFFFFF00FF0000000000
      FF000000FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF0000000000000000000000000000000000FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF000000000000000000000000000000000000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000
      FF000000FF000000FF0000FFFF00000000000000000000000000000000000000
      000000000000FF00000000000000000000000000000000000000000000000000
      00000000000000000000FF0000000000000000000000FFFFFF00FF000000FF00
      00000000FF000000FF00FFFFFF00FFFFFF00000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00000000000000FF000000000000000000FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF000000000000000000000000000000000000FFFF0000FFFF0000FF
      FF0000FFFF00424242004242420042424200424242004242420000FFFF000000
      FF000000FF000000FF0000FFFF00000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C600
      0000FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FF00
      0000FF0000000000FF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000FF00FF0000000000000000000000FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF000000000000000000000000000000000000FFFF0000FFFF004242
      4200424242004284E7004284E7004284E7004284E7004284E7004242420000FF
      FF0000FFFF0000FFFF0000FFFF00000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6000000C600
      0000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFF
      FF00FF000000FF0000000000FF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000FF00FF000000FF0000000000000000000000FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF000000000000000000000000000000000000FFFF0000FFFF004242
      42004284E7004284E7004284E7004284E7004284E7004284E7004284E7004242
      420000FFFF0000FFFF0000FFFF00000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00C6000000C6000000C6000000C600
      0000FFFFFF00FFFFFF000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FF000000FF0000000000FF000000FF000000FF00FFFFFF000000
      00000000FF000000FF00FF000000000000000000000000000000FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF000000000000000000000000000000000000FFFF00424242004284
      E7004284E7004284E7004284E7004284E7004284E7004284E7004284E7004242
      420000FFFF0000FFFF0000FFFF00000000000000000000000000000000000000
      000000000000C6630000C6000000C6000000C6000000C6000000C6000000C600
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FF000000FF0000000000FF000000FF000000FF000000
      FF000000FF00FF000000FF000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00424242004284
      E7004284E7004284E7004284E7004284E7004284E7004284E7004284E7004242
      420000FFFF0000FFFF0000FFFF00000000000000000000000000000000000000
      00000000000000000000C6630000C6000000C6000000C6000000C6000000C600
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FF000000FF0000000000FF000000
      FF00FF000000FF0000000000000000000000000000000000000000FFFF0000FF
      FF000000000000FFFF0000FFFF000000000000FFFF0000FFFF000000000000FF
      FF0000FFFF000000000000000000000000000000000000FFFF00424242004284
      E7004284E7004284E7004284E7004284E7004284E7004284E700424242004242
      420000FFFF0000FFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000C6000000C6000000C6000000C6000000C600
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF000000FF000000FF000000FF00
      0000FF000000FF0000000000000000000000000000000000000000FFFF0000FF
      FF000000000000FFFF0000FFFF000000000000FFFF0000FFFF000000000000FF
      FF0000FFFF0000000000000000000000000000000000424242004284E7004284
      E7004284E7004284E7004284E7004284E7004284E7004242420000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF00000000000000000000000000000000000000
      00000000000000000000C6000000C6000000C6000000C6630000C6000000C600
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000004284E7004284E7004284
      E7004284E7004284E7004284E7004284E7004242420000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000000000000000000000000000000000C663
      0000C6630000C6000000C6000000C6000000C60000000000000000000000C600
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C600
      0000C6000000C6000000C6000000C66300000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B5633900CE6B2900C66B
      3100BD6B2900BD632100A5633900A55A2900AD5A2900AD5A3100B55A2100BD6B
      0800B5631000B5632900C66B3900CE6B29000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000315A0000316B0000316B
      0000316B0000316B0000316B0000316B0000316B0000316B0000316B0000316B
      0000316B0000316B0000315A000000000000944A2900B5633100BD6B3100BD6B
      2900BD632100C66B2100BD6B2100B5632900B5632900B56B2100B56B1800C663
      1800BD632100AD632100B5632100D66B29000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000316B000084AD5200ADCE
      9400ADCE9400ADCE9400ADCE94006B9C39006B9C3900ADCE9400ADCE9400ADCE
      9400ADCE940084AD5200316B0000000000008C523100B5633100B5846300AD63
      2900BD6B2100BD6B2100CE6B1000BD6B2100C66B2100B56B1800AD6B2900AD5A
      3900B55A3100B5631800B5631800AD5A210000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF0000000000000000000000000000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000000000000000000000000000000000316B0000ADCE94000000
      00000000000000000000000000007BAD520084AD5A0000000000000000000000
      000000000000ADCE9400316B00000000000084523100AD735200BDA5A500946B
      4A00AD6B3100B56B2900D6731000BD6B2100CE731800AD632100A57B73009C84
      9C009C6B5A00BD5A1800AD5A1800845A390000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF0000000000000000000000000000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000000000000000000000000000000000316B0000ADCE94000000
      000000000000FFFFFF00BDD6A500528C18005A942100ADC68C00EFF7E7000000
      000000000000ADCE9400316B0000000000006B4A3100AD948400C6C6DE00B5AD
      A500A57B4A00AD6B3100C66B1800B5632100C6731000A56B4A00948CC6007394
      E700948CA500B55A3100A55229003118100000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF0000000000000000000000000000FF
      FF0000FFFF0000FFFF0000FFFF000000000000FFFF000000000000FFFF0000FF
      FF0000FFFF0000000000000000000000000000000000316B0000ADCE94000000
      0000DEEFD60063942900428400005A942100528C1800528C10004A840800B5CE
      9C0000000000ADCE9400316B000000000000734A3900C6B5BD00BDCEEF00CEDE
      E700D6B59C00AD6B2900BD6B2900BD6B2900C66B21008C6363007394E7004A94
      F7007B9CD60094737B00844A39007B52390000000000FFFFFF00FFFFFF000000
      000000000000000000000000000000000000FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF0000000000000000000000000000FF
      FF0000FFFF0000FFFF0000FFFF000000000000FFFF000000000000FFFF0000FF
      FF0000FFFF0000000000000000000000000000000000316B0000ADCE9400FFFF
      FF004A840800528C1800ADCE9400CEDEB500CEDEB500EFEFE700ADC68C004284
      0000EFF7E700ADCE9400316B0000000000007B4A3100CECED600CEDEF700CEE7
      F700D6C6AD00BD7B2900B56B2900C66B2900C66B310084737B006394DE00528C
      EF006394EF006B84BD007B5A5A00A54A100000000000FFFFFF0000000000FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF0000000000FFFFFF0000000000FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF0000000000000000000000000000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      000000FFFF0000000000000000000000000000000000316B0000ADCE9400FFFF
      FF004A840800528C180042840800428408004A840800528C180094B56B005A94
      2100FFFFFF00ADCE9400316B000000000000734A2900D6C6C600EFE7F700D6BD
      C600A5734200B57B1800A5733100B5845A00BD9CA500949CB5006394D600428C
      EF003984EF006B94CE007B6B73008439290000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF0000000000FFFFFF0000000000FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF0000000000000000000000000000FF
      FF0000FFFF0000FFFF0000FFFF000000000000FFFF000000000000FFFF0000FF
      FF0000FFFF0000000000000000000000000000000000316B0000ADCE94000000
      0000D6E7C6004A8C10004284000094B56B00F7F7EF005A942100528C1800E7EF
      D60000000000ADCE9400316B00000000000073523100D6A58C00B5736300AD6B
      4200B56B2900B5732900A57B4A00D6D6CE00A5C6F7008CADE700639CEF00428C
      F7004284EF005273C600737BB50018184A0000000000FFFFFF00FFFFFF000000
      000000000000000000000000000000000000FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF0000000000000000000000000000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      000000FFFF0000000000000000000000000000000000316B0000ADCE94000000
      00000000000094B56B004284000084AD5A00DEEFD6007BA54A008CB563000000
      000000000000ADCE9400316B00000000000084523100C68C5A00B5733100B56B
      2100C66B2100C6633100AD735200CEC6BD00ADD6EF0084B5EF006B9CEF00638C
      EF00527BE700316BE7003173E700396BC60000000000FFFFFF0000000000FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF0000000000000000000000000000FF
      FF0000FFFF0000FFFF0000FFFF000000000000FFFF000000000000FFFF0000FF
      FF0000FFFF0000000000000000000000000000000000316B0000ADCE94000000
      0000000000007BAD5200428400004284000042840000428400008CB563000000
      000000000000ADCE9400316B000000000000944A31009C7B5200A59463009C63
      2900CE6B2100CE6B2100AD6331009C6B5200A5A5B5008CA5C600738CBD005A7B
      BD005A84DE004273E700396BEF004A6BDE0000000000FFFFFF0000000000FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF0000000000FFFFFF0000000000FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF0000000000000000000000000000FF
      FF0000FFFF0000FFFF0000FFFF000000000000FFFF000000000000FFFF0000FF
      FF0000FFFF0000000000000000000000000000000000316B0000ADCE94000000
      0000BDD6A5004284000042840000428400004A840800528C100042840800BDCE
      A50000000000ADCE9400316B0000000000009C52310094634A00AD9C9400D6C6
      B500B58C5200AD6B2100BD732900AD6B3900A56B5200ADA5C600739CD6006394
      D6004A7BD600396BDE005A73DE008C6BA50000000000FFFFFF00FFFFFF000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000000000000000000000000000000000316B0000ADCE9400FFFF
      FF00528C1800428400004A8408009CBD7B00EFF7EF00FFFFFF0073A54200528C
      1800FFFFFF00ADCE9400316B00000000000094521800C66B4200A5634A00DEC6
      BD00DEE7DE00B5B59C008C6B4200945A2100B5733900948CA5006394F700427B
      F7003973EF004273E7007B6BA500B563420000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000FF
      FF0000FFFF000000000000FFFF0000FFFF0000000000000000000000000000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000000000000000000000000000000000316B000084AD5200ADCE
      9400528C1800428400005A942100ADCE9400A5C6840094B56B004A8408006B9C
      3900B5CE9C0084AD5200316B000000000000A5522100CE6B2100C66B3100AD63
      4200C6B5B500ADC6C6007B736300844A2900946339005A3939007B84C600527B
      F7004A6BEF007B6BA5009C635200BD6B290000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000FF
      FF0000FFFF000000000000FFFF0000FFFF000000000000000000000000000000
      000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000
      00000000000000000000000000000000000000000000315A0000316B0000316B
      0000316B0000316B0000316B0000316B0000316B0000316B0000316B0000316B
      0000316B0000316B0000315A000000000000944A2900BD6B3100BD6B2900C66B
      3100BD6342009C5A4A009C736300B58C7B0094635A009C5A4200945A4A009473
      8400946B7300AD634200C6632900C66B31000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF0000FFFF0000FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008C422100B56B3100C66B3100C66B
      2900CE6B2900D6633100C6633100B5633900BD634200C6633100C66B3100BD63
      2900C66B2900CE6B2900CE6B2900CE6331000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084840000848400008484
      0000848400008484000084840000848400008484000084840000848400008484
      0000848400008484000084840000000000000000000000000000000000000000
      0000F7F7F700B5B5B50084847B007B736B00736B6B007B737300ADADAD00F7F7
      F700000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6424200C6424200C642
      4200C6424200C6424200A5636300E7DEE700FFFFFF0063A56300428442004284
      4200428442004284420042844200A5A5A500A5A5A500FFFFBD00FFFFBD003939
      3900393939007B7B7B00393939007B7B7B007B7B7B00393939007B7B7B007B7B
      7B007B7B7B007B7B7B0039393900A5A5A500000000000000000000000000C6BD
      BD00A58C7B00CEA59400DEBDAD00E7C6BD00DEC6BD00D6BDAD00AD8C84006B63
      5A00B5B5B5000000000000000000000000000000000063E79C00290800002908
      0000000000000000000000000000000000000084840000000000000000000000
      0000000000000000000063E79C0000000000FF000000FF7B7B00FF7B7B00FF7B
      7B00FF7B7B00FF7B7B00FF000000C6C6C6007BC67B00008400007BC67B000084
      0000008400007BC67B000084000042844200A5A5A500FFFFBD00FFFFBD00FFFF
      BD0031313100BDBD7B007B7B7B00FFFFBD00FFFFBD007B7B3900FFFFBD00FFFF
      BD00FFFFBD00FFFFBD007B7B3900A5A5A50000000000FFFFFF00C6B5B500C694
      7B00CE9C8C00D6AD9C00DEB5A500DEBDAD00DEBDAD00D6B5A500CEAD9C00BD94
      7B00846B5A009C9C9C0000000000000000000000000000840000008484002908
      0000000000000000000000000000000000000084840000000000000000000000
      00000000000063E79C000084000000000000FF000000FF7B7B00FF393900FF7B
      7B00FF393900FF7B7B00FF000000C6C6C6007BC67B00008400007BC67B000084
      0000008400007BC67B000084000042844200A5A5A500FFFFBD00FFFFBD00FFFF
      BD00EFEFAD003131310039395A00FFFFBD00FFFFBD007B7B3900FFFFBD00FFFF
      BD00FFFFBD00FFFFBD007B7B3900A5A5A50000000000D6CEC600D6947B00D694
      7300DEA58C00DEAD9400DEAD9C00D6AD9400CEA59400BD9C8400AD8C7B00946B
      5A007B5242007B635A00BDBDBD000000000000000000008400000084000063E7
      9C00290800000000000000000000008484000000000000000000000000002908
      000063E79C00290800000084000000000000FF000000FF7B7B00FF393900FF7B
      7B00FF393900FF7B7B00FF000000C6C6C6007BC67B00008400007BC67B000084
      000000840000BDDEBD000084000042844200A5A5A500FFFFBD00FFFFBD00FFFF
      BD00FFFFBD007B9C7B004263840021426300DEDE9C007B7B3900FFFFBD00FFFF
      BD00FFFFBD00FFFFBD007B7B3900A5A5A500EFEFEF00D6A58C00CE9473004A31
      2900312121003129310031294A0029294A002129520021215A0010185A000000
      52000000520073526300736B6300F7F7F7000000000000840000008400000000
      000063E79C0029080000000000000000000000000000000000002908000063E7
      9C0029080000008400000084000000000000FF00000000000000FFFFFF00FFFF
      FF00FFFFFF0000000000FF000000C6C6C6007BC67B0039A53900BDDEBD007BC6
      7B0000840000FFFFFF000084000042844200A5A5A500FFFFBD00393939003939
      39007B7B7B007B7B7B00214242002142630021214200002163007B7B39007B7B
      7B0039393900393939007B7B3900A5A5A500DECEC600DE947B00DE947B005239
      290000009C000000BD000000B5000000A5000000940000007B0000006B000000
      6B0021186B00BD846300A57B6B00BDBDBD000000000000840000008400000084
      0000008484002908000029080000000000000084840029080000290800000084
      840000840000008400000084000000000000FF000000FF00000000000000FFFF
      FF0000000000FF000000FF000000C6C6C6007BC67B007BC67B007BC67B007BC6
      7B0000840000FFFFFF000084000042844200A5A5A500FFFFBD007B7B7B007B7B
      7B00FFFFFF007B7B7B00395A5A0042638400002163002142630021426300FFFF
      BD007B7B7B007B7B39007B7B3900A5A5A500D6B5A500D6947B00D6947300A573
      5A0000005A000000CE000000AD00000094000000840000007B00000073000000
      73009C6B7300C68C6B00BD8C73009C9C9C000000000000840000008400000084
      0000008400002908000029080000290800000000000029080000008484000084
      000000840000008400000084000000000000FF000000FF000000FF000000FF7B
      7B00FF000000FF000000FF000000E7DEE7007BC67B0039A5390039A5390039A5
      390000840000BDDEBD000084000063A56300A5A5A500FFFFBD00393939003939
      39007B7B7B007B7B7B003939390039395A002163840021638400004242005A9C
      7B0039393900393900007B7B3900A5A5A500DEB59C00D69C7B00D6947B00D694
      7300211829000000E7000000C6000000A5001010840000005A0039215A009C6B
      7300D6947300CE8C6B00C68C6B009C8C84000000000000840000008400000084
      0000008400000084000063E79C00290800002908000063E79C00008400000084
      00000084000000840000008400000000000000000000FF7B7B00FF7B7B00FF7B
      7B00FF7B7B00FF7B7B0000000000FFFFFF00FFFFFF007BC67B007BC67B007BC6
      7B007BC67B007BC67B007BC67B00FFFFFF00A5A5A500FFFFBD00FFFFBD00FFFF
      BD00FFFFBD00FFFFBD00FFFFBD00FFFFBD0039397B0042426300219CBD0031EF
      EF0031ADEF00397B7B007B7B3900A5A5A500DEB59C00D69C7B00D6947B00D694
      7300AD7B5A00392163001008420008081800291829000000100008085200C68C
      7300D6947300CE8C7300C68C6B00A5948C000000000000840000008400000084
      00000084000000840000008400000084840063E79C0029080000008400000084
      000000840000008400000084000000000000FFFFFF00C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600FFFFFF00FFFFFF00E7DEE700C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600E7DEE700A5A5A5007B7B39007B7B39007B7B
      39007B7B39007B7B39007B7B39007B7B39007B7B3900005A7B0000FFFF0000FF
      FF0031EFEF0031ADEF0000393900A5A5A500E7BDAD00DE9C8400D69C7B00D694
      7300AD735A00000031000000AD000000AD000000A50010084A00734A7300DE94
      7300D6947300CE8C7300CE947300BDB5AD0000000000000000000084840000FF
      FF0000FFFF0000FFFF00FFFFFF0063E79C00FFFFFF0063E79C0000FFFF0000FF
      FF00008484000084840000848400000000003939390000000000000000000000
      0000000000000000000021212100C6C6C600BDBDFF000000FF000000FF000000
      FF000000FF000000FF000000FF006363A500A5A5A50039393900FFFFBD00FFFF
      BD00FFFFBD00FFFFBD00FFFFBD00FFFFBD00FFFFBD006B6B6B0031EFEF0000FF
      FF0000FFFF0031EFEF0031ADEF00A5A5A500EFD6CE00DEA58C00D69C7B00D69C
      7B00DE9C84004A4252003939E7003939CE003131B50042399400DE9C7300D694
      7300D6947300D6947300CE947B00D6D6CE000000000000000000000000000000
      0000000000000084840063E79C00FFFFFF0000FFFF00FFFFFF00008484000000
      000000000000000000000000000000000000000000007B7B7B00000000000000
      0000000000007B7B7B0000000000C6C6C6007B7BFF000000FF000000FF007B7B
      FF007B7BFF000000FF000000FF004242C600A5A5A5007B7B7B007B7B7B00FFFF
      BD00FFFFBD00FFFFBD00FFFFBD00FFFFBD00FFFFBD00FFFFBD0031ADAD0031EF
      EF0000FFFF0000FFFF0031EFEF00A5A5A500FFF7F700EFCEBD00E7C6B500E7C6
      B500EFC6B500A59484006363C6006363CE006363BD00B59CB500E7BDAD00DEAD
      9400D6947B00D6947300C6A59400FFFFFF000000000000000000000000000000
      00000084840000FFFF0000FFFF0000FFFF0063E79C0000FFFF0000FFFF000084
      84000000000000000000000000000000000039393900FFFFFF007B7B7B007B7B
      7B007B7B7B00FFFFFF0039393900C6C6C6007B7BFF000000FF000000FF007B7B
      FF007B7BFF000000FF000000FF004242C600A5A5A5007B7B7B00FFFFBD003939
      3900FFFFBD00FFFFBD00FFFFBD00FFFFBD00FFFFBD00FFFFBD00BDBD7B00316B
      AD0031EFEF0000FFFF0000FFFF00A5A5A500FFFFFF00F7E7DE00EFD6CE00EFD6
      C600EFCEC600DEC6BD008484AD008C8CD6009494C600EFCEC600EFCEC600EFCE
      C600EFCEBD00EFC6B500E7DEDE00000000000000000000000000000000000000
      000000848400000000000000000000FFFF0000FFFF0000000000000000000084
      84000000000000000000000000000000000039393900BDBDBD00BDBDBD00FFFF
      FF00BDBDBD00BDBDBD0039393900C6C6C6007B7BFF007B7BFF007B7BFF007B7B
      FF007B7BFF007B7BFF003939FF004242C600A5A5A5007B7B7B00FFFFBD007B7B
      7B00393939003939000039390000000000003939000039390000393939007B7B
      390031ADEF0031EFEF0000FFFF00A5A5A50000000000FFFFFF00F7E7DE00F7E7
      DE00F7DED600F7DED600B5B5BD00ADADDE00DECED600F7DED600F7DED600F7DE
      D600F7DED600E7DEDE0000000000000000000000000000000000000000000084
      8400000000000000000000000000008484000084840000000000000000000000
      000000848400000000000000000000000000000000007B7B7B00393939000000
      0000393939007B7B7B0000000000C6C6C6007B7BFF007B7BFF007B7BFF007B7B
      FF007B7BFF007B7BFF003939FF004242C600A5A5A50000000000000000007B7B
      7B00FFFFBD00FFFFBD00FFFFBD00FFFFBD00FFFFBD00FFFFBD00FFFFBD00FFFF
      BD00397B7B0031ADEF0031EFEF00A5A5A5000000000000000000FFFFFF00F7EF
      E700F7EFE700FFEFE700EFE7DE00D6D6E700FFEFE700F7EFE700F7EFE700F7E7
      DE00EFE7E7000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000008484000084840000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B7B007B7B
      7B007B7B7B000000000000000000C6C6C6007B7BFF000000FF000000FF00BDBD
      FF00BDBDFF000000FF000000FF004242C6000000000084840000848400008484
      0000848400008484000084840000848400008484000084840000848400008484
      000084840000848400008484000000000000000000000000000000000000FFFF
      FF00FFF7F700F7EFE700F7EFEF00FFF7EF00F7EFE700F7EFE700F7F7EF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003939390000000000000000000000
      0000000000000000000039393900FFFFFF00BDBDFF000000FF000000FF000000
      FF000000FF000000FF000000FF00BDBDFF000000000000000000100000001000
      0000424A0000DEAD3100F7D65A00EFCE4200EFCE4A00EFCE5A00EFD66B00EFDE
      7B00EFD67300EFD65A00EFD65A00CE9439000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000001010
      1000101010001010100010101000101010001010100010101000101010001010
      10001010100010101000101010001010100000000000A5A5A500A5A5A500A5A5
      A500A5A5A500A5A5A500A5A5A500A5A5A500A5A5A500A5A5A500A5A5A500A5A5
      A500A5A5A500A5A5A500A5A5A500B5B5B500FFD6AD00F7D6AD00FFDEAD007384
      630008000000000000006B315200D6B54200FFDE3100F7A50000FF9C0000F7A5
      0000F7940000F7940000F7940000EF8C000000000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000000000000000000000000000000000000000
      00005A52E700DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00D6D6DE00DEDE
      DE00DEDEDE00DEDEDE00DEDEDE0010101000393939007B7B7B007B7B7B003939
      39007B7B7B007B7B7B007B7B7B007B7B7B007B397B0000007B0039395A007B7B
      7B007B7B7B007B7B7B0039393900A5A5A500E7B5AD00E7B5AD00E7BDAD00E7BD
      AD00EFC684000000FF000000F7000010FF000008FF00E7B50000E7AD0000EFAD
      0000EFAD0000E79C0000E78C0000B573180000000000FF000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FF000000000000000000000000000000000000000000
      00006B6BE7004A4AE700CECEDE00DEDEDE00DEDEDE00D6D6DE00DEDEDE00DEDE
      DE00DEDEDE00DEDEDE00DEDEDE00101010007B7B7B00FFFFFF00FFFFFF007B7B
      7B00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF7BFF000000FF007B7BBD00FFFF
      FF00FFFFFF00FFFFFF007B7B7B00A5A5A500BD520000CE5A0000CE5A0000D65A
      0000BD5A0000BDADAD005252DE000808F700E78C0000CE730000CE6B0000BD63
      0000C6520000C65A0000C65A0000C663000000000000FF000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FF000000000000000000000000000000000000000000
      0000DEDEDE005A5AE7004242E700DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDE
      DE00DEDEDE00CECEDE00BDBDE70010101000393939007B7B7B007B7B7B003939
      39007B7B7B007B7B7B007B7B7B007B7B7B00BD39BD000000FF0039397B007B7B
      7B007B7B7B007B7B7B0039393900A5A5A500C6520000BD520000C65A0000D65A
      0000BD630000ADADAD00FFFFFF00FFFFFF00AD6B1000D6840000C6730000C65A
      0000C65A0000BD5A0000C6630000CE63000000000000FF000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FF000000000000000000000000000000000000000000
      0000DEDEDE00DEDEDE008484E7004242E7008C8CE7007B7BE700B5B5E700ADAD
      E7008C8CE7006363E7004A4AE700101010007B7B7B00FFFFFF00FFFFFF007B7B
      7B00FFFFFF00FFFFFF00FFFFFF00FFFFFF007B397B0000007B0039395A00FFFF
      FF00FFFFFF00FFFFFF007B7B7B00A5A5A500BD630000BD630000BD5A0000CE63
      0000C66B00003129AD00E7E7FF00FFFFFF00CE7B0800D6840000CE730000C663
      0000BD5A0000BD5A0000BD5A0000CE63000000000000FF000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FF000000000000000000000000000000000000000000
      0000DEDEDE00DEDEDE00CECEDE005A5AE700ADADE700B5B5E7003131E7004239
      E7004242E7005A52E700B5B5E700101010007B7B7B00FFFFFF00FFFFFF007B7B
      7B00FFFFFF00FFFFFF00BDBDBD00FF00FF00FF000000FF000000FF000000FF00
      FF00BDBDBD00FFFFFF007B7B7B00A5A5A500BD630000BD630000BD630000CE63
      0000CE6B00005229AD001829FF000808FF00E78C0000D67B0000CE6B0000CE6B
      0000BD630000BD5A0000C6630000CE63000000000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FFFF
      FF00FFFFFF00FFFFFF00FF000000000000000000000000000000000000000000
      0000DEDEDE00DEDEDE00DEDEDE009C9CE700CECEDE008C8CE7006B6BE700DEDE
      DE00DEDEDE00DEDEDE00DEDEDE0010101000395A3900FFFFFF00FFFFFF007B7B
      7B00FFFFFF00FFFFFF00FF00FF00FF000000FF000000FF000000FF000000FF00
      0000FF00FF00FFFFFF007B7B7B00A5A5A500C65A0000C6630000C66B0000D66B
      0000D67B0000524252002121F7000810FF00E78C0000CE7B0000CE730000C66B
      0000CE6B0000C65A0000CE5A0000C65A000000000000FF000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FF000000FFFFFF00FFFFFF00FFFFFF00FF000000FFFF
      FF00FFFFFF00FFFFFF00FF000000000000000000000000000000000000000000
      0000DEDEDE00DEDEDE00DEDEDE00DEDEDE002929E7007373E700DEDEDE00DEDE
      DE00DEDEDE00DEDEDE00DEDEDE0010101000005A0000399C3900FFFFFF007B7B
      7B00FFFFFF007B7B7B00FF000000FF000000FF000000FF000000FF000000FF00
      0000FF0000007B7B7B007B7B7B00A5A5A500C66B0000CE630000D66B0000CE7B
      0000D6840000A59484005252F7001810F700E7940800D67B0000CE730000C663
      0000BD6B0000C6630000C65A0000CE63000000000000FF000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FF000000FFFFFF00FFFFFF00FFFFFF00FF000000FFFF
      FF00FFFFFF00FFFFFF00FF000000000000000000000000000000000000000000
      0000DEDEDE00DEDEDE00DEDEDE00DEDEDE004239E7009C9CE700DEDEDE00DEDE
      DE00DEDEDE00DEDEDE00D6D6DE0010101000007B000000DE0000399C39007B7B
      7B00FFFFFF007B7B7B007B007B007B007B007B007B007B007B007B007B007B00
      7B007B007B007B7B7B007B7B7B00A5A5A500C66B0000C66B0000CE7B0000DE7B
      0000DE8C18009C848400FFFFFF00FFFFFF00EF9C2900DE8C1000DE7B0000CE7B
      0000C6630000C66B0000BD630000C663000000000000FF000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000000000000000000000000000000000000000
      0000DEDEDE00DEDEDE00DEDEDE00D6D6DE004A4AE700ADADE700DEDEDE00DEDE
      DE00DEDEDE00D6D6DE00DEDEDE00101010007B7B7B0039FF390000DE0000399C
      3900FFFFFF00FFFFFF000000390039397B0039397B000000FF0039397B003939
      7B0000003900FFFFFF007B7B7B00A5A5A500C6630000CE730000DE7B0000D68C
      0800E7943900A594A500FFFFFF00FFFFFF00EFAD5A00DE942900D6840800DE73
      0000D6730000C66B0000C65A0000C65A000000000000FF000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000DEDE
      DE00DEDEDE00DEDEDE00DEDEDE00101010007B7B7B00FFFFFF0039FF390000DE
      0000399C3900FFFFFF00BDBDBD00FFFFFF00FF7BFF0000007B007B7BBD00FFFF
      FF00BDBDBD00FFFFFF007B7B7B00A5A5A500C66B0000C66B0000D6840800E794
      1800EFA55A007373C600EFE7FF00A594FF003142A500E79C3900DE841000D67B
      0000D66B0000CE6B0000C66B0000CE63000000000000FF000000FF000000FF00
      0000FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF0000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF0000000000DEDE
      DE00DEDEDE00DEDEDE00D6D6DE0010101000393939007B7B7B007B7B7B0000BD
      000000DE0000006300007B7B7B007B7B7B007B00BD000000DE007B7B9C007B7B
      7B007B7B7B007B7B7B0039393900A5A5A500CE630000CE7B0000D6840800D68C
      1800F7A552008C8CD600EFE7FF00CEC6EF002931A500E7943900DE841000CE73
      0000D66B0000C66B0000CE630000CE6300000000000000000000000000000000
      0000FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF0000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF0000000000DEDE
      DE00000000000000000000000000101010007B7B7B00FFFFFF00FFFFFF007B7B
      7B0039FF390000DE0000399C3900BD39FF000000DE00BDBDDE00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF007B7B7B00A5A5A500CE6B0000CE730000CE7B0000DE84
      1000EF9C3100636BB5007373FF005A63FF00FFBD4A00DE942900D68C0800D67B
      0000CE730000C6730000BD630000CE6300000000000000000000000000000000
      0000FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000DEDE
      DE00101010000000FF000000FF00101010007B7B7B00FFFFFF00FFFFFF007B7B
      7B00FFFFFF0039FF39007B39BD000000DE00BDBDDE00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF007B7B7B00A5A5A500CE630000CE730000C67B0000D684
      0800DE8C18007B6373004A52FF004A42C600EF942900DE8C1000DE7B0000CE73
      0000C66B0000C65A0000BD5A0000C65A00000000000000000000000000000000
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000DEDEDE00DEDEDE00DEDEDE00D6D6DE00DEDEDE00DEDEDE00DEDEDE00DEDE
      DE00101010000000FF0010101000000000007B7B7B00FFFFFF00FFFFFF007B7B
      7B00FFFFFF00BD39FF000000DE00009C2100399C3900FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF007B7B7B00A5A5A500C65A0000CE630000CE730000D66B
      0000CE840800D6841000EF9C0800E78C1800D6840800D6840000CE730000CE6B
      0000C66B0000BD630000C65A0000CE6300000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000010101000101010000000000000000000393939007B7B7B007B7B7B003939
      39007B397B0000007B0039395A00007B0000005A0000395A39007B7B7B007B7B
      7B007B7B7B007B7B7B0039393900DEDEDE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004263630042636300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AD736B00AD736B00AD73
      6B00AD736B00AD736B0000000000000000000000000000000000000000000000
      000000000000000000000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000426363004263630042636300C6C6C60042636300000000000000
      0000000000000000000000000000000000000000000039000000390000003900
      0000390000003900000039000000390000003900000039000000390000003900
      0000390000003900000039000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AD736B00AD736B00AD73
      6B00AD736B00AD736B0000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000426363004263
      630042636300C6C6C600C6C6C600F7FFFF00C6C6C60042636300000000000000
      000000000000000000000000000000000000000000009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C0063423900390000009494
      94009C9C9C009C9C9C0039000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AD736B00AD736B00AD73
      6B00AD736B00AD736B00AD736B00AD736B000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000004263630042636300C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600F7FFFF00C6C6C60042636300426363004263
      630042636300426363000000000000000000000000009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C0084737300F7E7E700BD9C9C003900
      00008C7B7B009C9C9C0039000000000000000000000000000000000000002163
      C600105ABD00215AB500AD736B00E7733900DE733900DE733900DE6B3100DE6B
      3100E76B3100CE5A2100FFF7F700AD736B000000000000000000000000000000
      FF000000FF000000FF00000000000000FF000000FF000000FF00000000000000
      00000000000000000000000000000000000042636300C6C6C600C6C6C6004263
      630042636300C6C6C600C6C6C600F7FFFF00C6C6C60042636300C6C6C600C6C6
      C600C6C6C600426363004263630000000000000000009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C0094949400F7E7E700F7E7E700F7E7E700EFD6
      D600390000006B5252003900000000000000000000002163C60010BDFF0018CE
      FF0018CEFF0018CEFF00AD736B00E7733100DE733900DE734200EF9C6B00EF9C
      6B00EF8C5200D66B3100FFF7EF00AD736B0000000000000000000000FF000000
      FF000000FF000000000000000000000000000000FF000000FF000000FF000000
      00000000000000000000000000000000000042636300C6C6C60084848400A5A5
      A5008484840042636300C6C6C60000000000C6C6C6004263630000000000C6C6
      C600C6C6C60042636300C6C6C60042636300000000009C9C9C008C8484008473
      7300847373008473730094949400DEC6C600F7E7E700F7E7E700F7E7E700F7E7
      E700F7E7E700522929003900000000000000000000002163C60008C6FF0008C6
      FF0008C6FF0018CEFF00AD736B00DE6B3100DE844A00F7B58C00F7BD9400F7B5
      8C00EFA57300DE7B4A00FFEFEF00AD7B730000000000000000000000FF000000
      FF0000000000000000000000000000000000000000000000FF000000FF000000
      FF000000000000000000000000000000000042636300C6C6C600A5A5A500C6C6
      C6000000000042636300C6C6C60000000000C6C6C6004263630000000000C6C6
      C600C6C6C60042636300C6C6C60084848400000000009C9C9C009C8C8C00734A
      4200734A4200734A42006B4A4A00DED6D600F7E7E700F7E7E700F7E7E700F7E7
      E700D6BDBD00DED6D6003900000000000000000000002163C60008C6FF0008C6
      FF0018CEFF0018CEFF00AD736B00DE6B3100F7B58400F7CEAD00F7DEBD00F7D6
      B500F7BD9400E7945A00FFF7F700B5847B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF0000000000000000000000000042636300C6C6C600C6C6C6008484
      E70000000000C6C6C600C6C6C60000000000C6C6C6004263630000000000C6C6
      C600C6C6C60042636300C6C6C60084848400000000009C9C9C00000000000000
      00000000000000000000390000009C9C9C00C6BDBD00F7E7E700F7E7E700F7E7
      E700946B6B009C9C9C0039000000000000000000000052E7FF000000000010CE
      FF0018CEFF0018CEFF00AD736B00E78C5200F7BD9C00FFE7CE00FFFFEF00FFFF
      DE00FFDEB500EFA57300FFE7E700B58484000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      00000000FF000000FF00000000000000000042636300C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C60000000000C6C6C6004263630000000000C6C6
      C600C6C6C60042636300C6C6C60084848400000000009C9C9C00000000000000
      00000000000000000000390000009C9C9C00B5ADAD00F7E7E700F7E7E700F7E7
      E700D6BDBD008C7B7B0039000000000000000000000052E7FF000000000018CE
      FF0018CEFF0018CEFF00AD736B00C67B5A00CE947300D69C8400DEAD9400E7BD
      AD00E7BDB500EFCEC600FFFFF700BD8C8400000000000000000000000000FFFF
      FF00FFFFFF00000000000000000000000000FFFFFF0000000000000000000000
      000000000000000000000000FF000000000042636300C6C6C600C6C6C600C6C6
      C60000000000000000000000000042636300426363000000000000000000C6C6
      C600C6C6C60042636300C6C6C60084848400000000005A313100BDADAD000000
      000000000000000000007B5A52003900000042100800F7E7E700F7E7E700F7E7
      E700F7E7E7009C9C9C0039000000000000000000000052E7FF000000000021DE
      FF0018CEFF0018CEFF00AD736B00AD736B00AD736B00AD736B00AD736B00AD73
      6B00AD736B00AD736B00AD736B00AD736B000000000000000000FFFFFF000000
      000000000000FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00000000000000
      00000000000000000000000000000000FF0042636300C6C6C600C6C6C600C6C6
      C60000000000426363004263630000000000000000000000000000000000C6C6
      C600C6C6C60042636300C6C6C600848484000000000000000000000000000000
      000000000000000000000000000000000000A5A5A5009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C0039000000000000000000000052E7FF007BEFFF000000
      000018CEFF0018CEFF0018CEFF0018CEFF0018CEFF0018CEFF0018CEFF0018CE
      FF002163C6000000000000000000000000000000000000000000FFFFFF000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      00000000000000000000000000000000000042636300C6C6C600C6C6C6004263
      630042636300000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C60042636300C6C6C60084848400000000009C9C9C00000000000000
      0000000000000000000000000000CECECE009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C0039000000000000000000000052E7FF0052E7FF000000
      0000000000002163C6002163C6002163C6002163C6002163C6002163C6002163
      C6002163C6000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000004263630042636300426363000000
      000000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C60042636300C6C6C60084848400000000009C9C9C009C9C9C00F7F7
      F7000000000000000000EFE7E7009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C0039000000000000000000000052E7FF0052E7FF0052E7
      FF0052E7FF0052E7FF0052E7FF0052E7FF0052E7FF0052E7FF002163C6000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000004263630042636300A5A5A500A5A5
      A500A5A5A500A5A5A50042636300426363004263630042636300426363004263
      63004263630042636300C6C6C60084848400000000009C9C9C009C9C9C009C9C
      9C00D6D6D600000000009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C0039000000000000000000000052E7FF0052E7FF0052E7
      FF0052E7FF0052E7FF0052E7FF0052E7FF0052E7FF0052E7FF002163C6000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000426363004263
      630042636300C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C6004263630084848400000000009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C0039000000000000000000000052E7FF0052E7FF0052E7
      FF0052E7FF002163C6002163C6002163C6002163C6002163C6002163C6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000004263630042636300848484008484840084848400848484008484
      8400848484008484840084848400426363000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00002163C6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF000000EF000000F70000009C0000008C000000E70000000000000000
      0000000000000000000000000000000000000000000000FF000000F7000008D6
      000008C6000008D6000000EF000000FF000000FF000000000000000000000000
      00000000000000000000000000000000000000000000000000008C736B00846B
      5A007B634A00735A42006B5242006B4A39006B4A3900634A3900634A3100634A
      31006B523900735A4A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000F7
      00005A844200D6B5AD00A5947B00FFC6C600FFCECE000094000000AD000000C6
      00000000000000000000000000000000000000FF000008DE0000189408002942
      210029311800294A08001873080010AD000008D6000000EF000000FF000000FF
      0000000000000000000000000000000000000000000000000000846B6300CEBD
      B500CEB5AD00CEB5A500C6ADA500C6AD9C00BDA59C00BDA59400BD9C9400B59C
      8C00B59C8C00735A420000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000F700008CA5
      6300EFBDB500FFC6C600E7B5AD00FFC6C600FFC6C60094846B00FFC6C6005A73
      4A0000D6000000000000000000000000000008B5000029392100C6C6C600CECE
      CE00ADADAD00D6D6D6009C9C9C0031312100294A08001873080010AD000008D6
      000000EF000000FF000000FF00000000000000000000000000008C736300F7DE
      D600CEBDB500CEB5AD00CEB5AD00C6ADA500C6AD9C00BDAD9C00BDA59400BD9C
      9400B59C8C007352420000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF00009C9C73009C84
      7300D6AD9C00FFBDBD00FFBDBD00FFBDBD00FFBDBD00FFBDBD00FFBDBD00DEAD
      A50000EF000000FF000000000000000000008C8C8C00D6D6D600CECECE00D6D6
      D600ADADAD00DEDEDE00ADADAD00F7F7F700F7F7F700A5A5A50031312100294A
      08001873080010AD000008D6000000F7000000000000000000008C7B6B00F7E7
      D600BD8C7300B56B4A00CEBDAD00BD8C7300B5735200C6AD9C00BD8C7300AD6B
      4A00BDA59400735A420000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084AD6300FFB5AD00FFB5
      B500FFB5B500FFB5B500FFB5B500F7B5AD00FFB5B500FFB5B500FFB5B5008C7B
      6300317B21000063000000FF000000000000D6D6D6009C9C9C00C6C6C600DEDE
      DE00ADADAD00E7E7E70094949400EFEFEF00C6C6C6009C9C9C009C9C9C00B5B5
      B500A5A5A500313121002152080010B500000000000000000000947B7300F7E7
      DE00FFC6AD00BD846B00D6BDB500F7C6AD00BD846B00C6B5A500F7C6AD00BD84
      6B00BDA59400735A420000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000029DE1800CEAD9400FFAD
      AD00FFADAD00E7A59C0000F700000000000039D62900CEA59400FFADB500FFAD
      AD00FFADAD00BD947B0000D6000000000000DEDEDE00C6C6C600CECECE00DEDE
      DE00ADADAD00CECECE00BDBDBD00C6C6C600ADADAD0042424200424242005A5A
      5A00ADADAD00E7E7E700CECECE0021730800000000000000000094847B00F7E7
      DE00DECEC600D6CEC600D6C6BD00D6BDB500CEBDAD00CEB5AD00C6B5A500C6AD
      A500C6AD9C00735A4A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000021941000AD947B00FFA5
      A500FFADAD0000A5000000000000000000000000000042D63100D6A59400FFAD
      AD00FFADAD009C9C630000FF000000000000E7E7E700BDBDBD00CECECE00E7E7
      E700ADADAD00CECECE00BDBDBD00B5B5B500424242004A4A4A00313131004A4A
      4A0052525200CECECE00DEDEDE00216B080000000000000000009C8C7B00FFEF
      E700BD8C7300B56B4A00DECEC600BD8C7B00B5735200CEBDB500BD8C7300B573
      5200C6ADA5007B634A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D6A59400FFA5A500FFA5
      A500FFA5A50000CE000000000000000000000000000000000000CEAD9C00FFA5
      A500FFA5A5000063000000BD000000000000E7E7E700BDBDBD00D6D6D600E7E7
      E700ADADAD00DEDEDE008C8C8C00C6C6C60052525200424242008C4221006363
      63006B6B6B00C6C6C600D6D6D600216B08000000000000000000A5948400FFEF
      EF00FFC6AD00BD846B00DECEC600F7C6AD00BD846B00D6C6B500F7C6AD00BD84
      6B00CEB5A5007B63520000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D6A59400FF9C9C00FF9C
      9C00FF9C9C0000AD00000000000000000000000000000000000094AD6B00F79C
      9400FF9C9C00FF9C9C00005A000000000000EFEFEF00C6C6C600D6D6D600EFEF
      EF00ADADAD00E7E7E7008C8C8C00D6D6D6005A5A5A0042424200EF8400006B6B
      63006B6B6B00D6D6D600CECECE00216308000000000000000000A5948C00FFF7
      EF00E7DEDE00E7DED600DED6CE00DECECE00DECEC600D6C6BD00D6C6B500CEBD
      B500CEB5AD00846B520000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A5A58400F794
      9400FF9494000063000000FF00000000000000000000000000008CA56300F794
      9400FF949400FF9494000084000000000000EFEFEF00C6C6C600DEDEDE00EFEF
      EF00ADADAD00CECECE008C8C8C00DEDEDE004A4A4A00525252004A4A4A003131
      31006B6B6B00DEDEDE00C6C6C600216308000000000000000000AD9C9400FFF7
      F7008C84CE004229A500E7DED6008C7BCE004229A500DECEC6008C7BCE004229
      A500CEBDB500846B5A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000042C63100EF948C00F78C
      8C00F78C8C00946B520000AD0000000000000000000000000000C6AD9C00F78C
      8C00F78C8C00089408000000000000000000F7F7F700C6C6C600DEDEDE00F7F7
      F700ADADAD00E7E7E7009C9C9C00BDBDBD00EFEFEF0039393900848484006B6B
      6B00A5A5A500BDBDBD00BDBDBD00216308000000000000000000ADA59C00FFFF
      F700C6BDE7009484CE00E7DEDE00C6BDE7008C84CE00DED6CE00C6BDE7008C84
      CE00D6C6BD008C73630000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000094AD6B00E78C8400EF84
      8400EF848400EF848400635A39000084000000DE0000529C4200E78C8400EF84
      8400EF84840084634A0000C6000000000000F7F7F700B5B5B500BDBDBD00F7F7
      F7006B6B6B00B5B5B500B5B5B500B5B5B500BDBDBD00FFFFFF00FFFFFF00FFFF
      FF00D6D6D600B5B5B500B5B5B500216308000000000000000000B5A59C00FFFF
      FF00FFE7CE00FFCEAD00FFCEAD00FFBD9400F7B58C00CE9C7B00CE9C7B00CEB5
      9C00D6C6BD008C7B6B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF00007BC65A0039D6
      2100CE9C8C00E77B7B00E77B7B00E77B7B00D67B7B00E77B7B00E77B7B00E77B
      7B00E77B7B00D67B730000EF000000000000FFFFFF00FFFFFF00FFFFFF009494
      9400636363006B6B6B00A5A5A500A5A5A5009494940063636300A5A5A5007373
      730052525200636363009C9C9C00216308000000000000000000B5ADA500FFFF
      FF00FF946300FFA56300FF9C6300FF9C6300FFA56300FFA56300FF9C6300AD6B
      4A00C6A59400947B730000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005AB5
      4200D6847B00DE7B7B00DE737300DE7B7B00DE7B7B00DE737300DE7B7B00A573
      6300ADA57B0010E708000000000000000000298C2900A5A5A500DEDEDE00BDBD
      BD00CECECE00CECECE00F7F7F700EFEFEF00E7E7E700ADADAD009C9C9C006B6B
      6B00393939004A4A4A0084848400187B08000000000000000000B5ADA500FFFF
      FF00E7734200F7D6CE00F7DECE00EFC6B500E7B59C00DE9C7B00E78452009C52
      3100CEA58C00947B730000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006BBD
      5200CE8C8400DE6B7300C6AD9400D6737300D66B6B00CEA58C00DE6B7300DE73
      730000CE00000000000000000000000000000000000000000000000000000000
      000010A51000216321007B7B7B00C6C6C600EFEFEF008C8C8C00636363006363
      63008C8C8C00D6D6D6003942390008D600000000000000000000BDB5AD00ADA5
      9C00F7BDA500D68C6B00D6846300D67B5200CE6B4200CE633100BD5A3100D684
      5A009C8C7B008C7B730000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000029EF180008F70000ADAD8400CE6B6B00D66363006BAD5200BD846B0021DE
      1000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000189C100010AD
      100000E7000000F7000000F7000000FF00000000000000000000CEC6BD00B5AD
      A500B5ADA500B5A59C00B5A59400AD9C8C00AD9C8C00A5948C009C8C84009C84
      7B0073635A00ADA59C0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CECECE00C6C6C600E7E7
      E700000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000001010
      1000101010001010100010101000101010001010100010101000101010001010
      1000101010001010100010101000101010000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CECECE00B5B5B5009C9C9C009C9C
      9C00E7E7E7000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000004284000042
      8400004284000042840000428400004284000042840000428400004284000042
      8400004284000042840000000000000000000000000000000000000000000000
      00005A52E700DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00D6D6DE00DEDE
      DE00DEDEDE00DEDEDE00DEDEDE00101010000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CECECE00B5B5B5009C9C
      9C009C9C9C00E7E7E70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000428400004284000042
      8400004284000042840000428400004284000042840000428400004284000042
      8400004284000042840000428400000000000000000000000000000000000000
      00006B6BE7004A4AE700CECEDE00DEDEDE00DEDEDE00D6D6DE00DEDEDE00DEDE
      DE00DEDEDE00DEDEDE00DEDEDE00101010000000000000000000000000003173
      C6005A5A5A00528C9C003173C6005A5A5A00528C9C003173C6003173C6005A5A
      5A00528C9C0000000000000000000000000000000000E7E7E700CECECE00B5B5
      B5009C9C9C009C9C9C00E7E7E700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF000000FF000000FF
      00008400FF008400FF00FFFFFF00FFFFFF008400FF008400FF008400FF0000FF
      000000FF000000FF000000FF0000000000000000000000000000000000000000
      0000DEDEDE005A5AE7004242E700DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDE
      DE00DEDEDE00CECEDE00BDBDE700101010000000000000000000000000003163
      A500000000004A8CB5003163A5004284B500000000003163A500000000004284
      B5004A8CB5000000000000000000000000000000000000000000E7E7E700CECE
      CE00B5B5B5009C9C9C009C9C9C00E7E7E7000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF000000FF000000FF
      00008400FF008400FF00FFFFFF00FFFFFF008400FF008400FF008400FF0000FF
      000000FF000000FF000000FF0000000000000000000000000000000000000000
      0000DEDEDE00DEDEDE008484E7004242E7008C8CE7007B7BE700B5B5E700ADAD
      E7008C8CE7006363E7004A4AE700101010000000000000000000000000003173
      C6005A5A5A00528C9C00000000005A5A5A00528C9C003173C6003173C6005A5A
      5A00528C9C00000000000000000000000000000000000000000000000000E7E7
      E700CECECE00B5B5B5009C9C9C00CECECE00E7E7E7009C9C9C009C9C9C009C9C
      9C00B5B5B500E7E7E70000000000000000000000000000FFFF0000FFFF0000FF
      FF008400FF008400FF00FFFFFF00FFFFFF008400FF00FFFFFF008400FF0000FF
      FF0000FFFF0000FFFF0000FFFF00000000000000000000000000000000000000
      0000DEDEDE00DEDEDE00CECEDE005A5AE700ADADE700B5B5E7003131E7004239
      E7004242E7005A52E700B5B5E700101010000000000000000000000000000042
      8400004284000042840000428400004284000042840000428400004284000042
      8400004284000000000000000000000000000000000000000000000000000000
      0000E7E7E700CECECE00B5B5B5009C9C9C00B5B5B500CECECE00CECECE00CECE
      CE00CECECE009C9C9C00E7E7E700000000000000000000FFFF0000FFFF0000FF
      FF008400FF008400FF008400FF008400FF008400FF008400FF008400FF0000FF
      FF0000FFFF0000FFFF0000FFFF00000000000000000000000000000000000000
      0000DEDEDE00DEDEDE00DEDEDE009C9CE700CECEDE008C8CE7006B6BE700DEDE
      DE00DEDEDE00DEDEDE00DEDEDE00101010000000000000000000000000000042
      840084FFFF0084FFFF0084FFFF0084FFFF0084FFFF0084FFFF0084FFFF0084FF
      FF00004284000000000000000000000000000000000000000000000000000000
      000000000000E7E7E7009C9C9C00E7E7E700CECECE00CECECE00CECECE00E7E7
      E700E7E7E700E7E7E7009C9C9C00E7E7E7000000000000FFFF0000FFFF0000FF
      FF000042840000428400004284000042840000428400004284000042840000FF
      FF0000FFFF0000FFFF0000FFFF00000000000000000000000000000000000000
      0000DEDEDE00DEDEDE00DEDEDE00DEDEDE002929E7007373E700DEDEDE00DEDE
      DE00DEDEDE00DEDEDE00DEDEDE00101010000000000000000000000000000042
      840084FFFF0084FFFF0084FFFF0084FFFF0084FFFF0084FFFF0084FFFF0084FF
      FF00004284000000000000000000000000000000000000000000000000000000
      000000000000E7E7E700B5B5B500CECECE00CECECE00CECECE009C9C9C00E7E7
      E700E7E7E700E7E7E700CECECE00B5B5B5000000000000FFFF0000FFFF0000FF
      FF0000FFFF00004284000042840000428400004284000042840000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF00000000000000000000000000000000000000
      0000DEDEDE00DEDEDE00DEDEDE00DEDEDE004239E7009C9CE700DEDEDE00DEDE
      DE00DEDEDE00DEDEDE00D6D6DE00101010000000000000000000000000000042
      840084FFFF0084FFFF000000000000000000000000000000000084FFFF0084FF
      FF00004284000000000000000000000000000000000000000000000000000000
      000000000000B5B5B500E7E7E700CECECE00CECECE00CECECE009C9C9C00CECE
      CE00E7E7E700E7E7E700CECECE009C9C9C0000000000FFFF8400FFFF8400FFFF
      8400FFFF8400FFFF8400004284000042840000428400FFFF8400FFFF8400FFFF
      84000000FF00FFFF8400FFFF8400000000000000000000000000000000000000
      0000DEDEDE00DEDEDE00DEDEDE00D6D6DE004A4AE700ADADE700DEDEDE00DEDE
      DE00DEDEDE00D6D6DE00DEDEDE00101010000000000000000000000000000042
      840084FFFF0084FFFF0084FFFF0084FFFF0084FFFF0084FFFF0084FFFF0084FF
      FF00004284000000000000000000000000000000000000000000000000000000
      0000000000009C9C9C00CECECE00CECECE009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C00CECECE00CECECE009C9C9C0000000000FFFF8400FFFF8400FFFF
      8400FFFF8400FFFF8400FFFF840000428400FFFF8400FFFF8400FFFF84000000
      FF0000FFFF000000FF00FFFF8400000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000DEDE
      DE00DEDEDE00DEDEDE00DEDEDE00101010000000000000000000000000000042
      840084FFFF0084FFFF000000000000000000000000000000000084FFFF0084FF
      FF00004284000000000000000000000000000000000000000000000000000000
      000000000000B5B5B500CECECE00CECECE00CECECE00CECECE009C9C9C00CECE
      CE00CECECE00CECECE00CECECE009C9C9C0000000000FFFF8400FFFF8400FFFF
      8400FFFF8400FFFF8400FFFF8400FFFF8400FFFF8400FFFF8400FFFF8400FFFF
      84000000FF00FFFF8400FFFF840000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF0000000000DEDE
      DE00DEDEDE00DEDEDE00D6D6DE00101010000000000000000000000000000042
      840084FFFF0084FFFF0084FFFF0084FFFF0084FFFF0084FFFF0084FFFF0084FF
      FF00004284000000000000000000000000000000000000000000000000000000
      000000000000E7E7E700B5B5B500E7E7E700E7E7E700CECECE009C9C9C00CECE
      CE00CECECE00CECECE00B5B5B500B5B5B50000000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF00000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF0000000000DEDE
      DE00000000000000000000000000101010000000000000000000000000000042
      840084FFFF0084FFFF000000000000000000000000000000000084FFFF0084FF
      FF00004284000000000000000000000000000000000000000000000000000000
      000000000000E7E7E7009C9C9C00E7E7E700E7E7E700CECECE00CECECE00CECE
      CE00CECECE00E7E7E7009C9C9C00E7E7E70000000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000DEDE
      DE00101010000000FF000000FF00101010000000000000000000000000000042
      840084FFFF0084FFFF0084FFFF0084FFFF0084FFFF0084FFFF0084FFFF0084FF
      FF00004284000000000000000000000000000000000000000000000000000000
      00000000000000000000E7E7E7009C9C9C00E7E7E700CECECE00CECECE00CECE
      CE00B5B5B5009C9C9C00E7E7E700000000000000000000000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF00000000000000000000000000000000000000000000000000
      0000DEDEDE00DEDEDE00DEDEDE00D6D6DE00DEDEDE00DEDEDE00DEDEDE00DEDE
      DE00101010000000FF0010101000000000000000000000000000000000000042
      8400004284000042840000428400004284000042840000428400004284000042
      8400004284000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000E7E7E700B5B5B5009C9C9C009C9C9C009C9C
      9C009C9C9C00E7E7E70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000101010001010100000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CECECE00C6C6C600E7E7
      E700000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CECECE00C6C6C600E7E7
      E700000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CECECE00C6C6C600E7E7
      E700000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00004A524A004A524A004A524A0000000000CECECE00639C9C0063639C009C9C
      9C00E7E7E7000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CECECE00B5B5B5009C9C9C009C9C
      9C00E7E7E7000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CECECE00639C9C0063639C009C9C
      9C00E7E7E7000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000294A5200000000004A52
      4A004A524A00318CB50042637300000000000000000063CEFF00319CCE006363
      9C009C9C9C00E7E7E70000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CECECE00B5B5B5009C9C
      9C009C9C9C00E7E7E70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000063CEFF00319CCE006363
      9C009C9C9C00E7E7E70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000004A524A004A52
      4A002994C60084DEEF006394A5000000000000000000CECEFF0063CEFF00319C
      CE0063639C009C9C9C00E7E7E700000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E7E7E700CECECE00B5B5
      B5009C9C9C009C9C9C00E7E7E700000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CECEFF0063CEFF00319C
      CE0063639C009C9C9C00E7E7E700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000294A5200000000004A524A004A524A002994
      C60084DEEF006394A50000000000000000000000000000000000CECEFF0063CE
      FF00319CCE0063639C009C9C9C00E7E7E7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E7E7E700CECE
      CE00B5B5B5009C9C9C009C9C9C00E7E7E7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CECEFF0063CE
      FF00319CCE0063639C009C9C9C00E7E7E7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000846B5200AD8C
      7B00735A420073523900735A42008C6B52004A4A4A00293142002994C60084DE
      EF006394A500000000000000000000000000000000000000000000000000CECE
      FF0063CEFF00319CCE0063639C00CECECE00FFCECE00CE9C9C00CE9C9C00CE9C
      9C00CECE9C00E7E7E7000000000000000000000000000000000000000000E7E7
      E700CECECE00B5B5B5009C9C9C00CECECE00E7E7E7009C9C9C009C9C9C009C9C
      9C00B5B5B500E7E7E7000000000000000000000000000000000000000000CECE
      FF0063CEFF00319CCE0063639C00CECECE00FFCECE00CE9C9C00CE9C9C00CE9C
      9C00CECE9C00E7E7E700000000000000000000000000846B520084634A009C84
      6300BDA57B00D6AD8400B594730094735A006B5242004A84940084DEEF006394
      A500000000000000000000000000000000000000000000000000000000000000
      0000CECEFF0063CEFF00B5B5B500CE9C9C00CECE9C00F7EFBD00FFFFCE00F7EF
      BD00F7EFBD00CE9C9C00EFC6DE00000000000000000000000000000000000000
      0000E7E7E700CECECE00B5B5B5009C9C9C00B5B5B500CECECE00CECECE00CECE
      CE00CECECE009C9C9C00E7E7E700000000000000000000000000000000000000
      0000CECEFF0063CEFF00B5B5B500CE9C9C00CECE9C00F7EFBD00FFFFCE00F7EF
      BD00F7EFBD00CE9C9C00EFC6DE0000000000947B6B0084635200C6AD8C00EFD6
      AD00EFD6AD00EFCEA500E7C69C00DEB58C00A5846300735242006394A5000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E7E7E700CE9C9C00FFCE9C00FFFFCE00FFFFCE00FFFFCE00FFFF
      FF00FFFFFF00FFFFFF00CE9C9C00E7E7E7000000000000000000000000000000
      000000000000E7E7E7009C9C9C00E7E7E700CECECE00CECECE00CECECE00E7E7
      E700E7E7E700E7E7E7009C9C9C00E7E7E7000000000000000000000000000000
      000000000000E7E7E700CE9C9C00FFCE9C00FFFFCE00FFFFCE00FFFFCE00FFFF
      FF00FFFFFF00FFFFFF00CE9C9C00E7E7E700A58C7B00AD947B00F7DEBD00F7E7
      C600F7E7C600F7DEBD00EFDEB500E7CEA500D6AD840094735200635A52000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFCECE00CECE9C00FFFFCE00F7EFBD00FFFFCE00FFFFCE00FFFF
      FF00FFFFFF00FFFFFF00F7EFBD00CECE9C000000000000000000000000000000
      000000000000E7E7E700B5B5B500CECECE00CECECE00CECECE00CECECE00E7E7
      E700E7E7E700E7E7E700CECECE00B5B5B5000000000000000000000000000000
      000000000000FFCECE00CECE9C00FFFFCE00F7EFBD00F7EFBD00CE633100FFFF
      FF00FFFFFF00FFFFFF00F7EFBD00CECE9C00A58C8400CEBDA500F7EFCE00F7EF
      D600F7EFDE00F7EFD600F7E7C600EFD6B500E7C69C00B59473006B4A39000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CECE9C00FFCE9C00F7EFBD00CECECE00CECECE00CECECE00CECE
      CE00CECECE00FFFFFF00F7EFBD00CE9C9C000000000000000000000000000000
      000000000000B5B5B500E7E7E700CECECE00CECECE00CECECE00CECECE00CECE
      CE00E7E7E700E7E7E700CECECE009C9C9C000000000000000000000000000000
      000000000000CECE9C00F7EFBD00F7EFBD00FFCE9C00FFCE9C00CE633100F7EF
      BD00F7EFBD00FFFFFF00F7EFBD00CE9C9C0094847300E7DEC600F7F7DE00FFF7
      EF00FFFFEF00FFF7E700F7EFD600EFDEBD00E7CEA500CEA58400735239000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CE9C9C00F7EFBD00F7EFBD00E7CE6300CE630000CE630000CE63
      0000CE630000FFFFCE00FFFFCE00CE9C9C000000000000000000000000000000
      0000000000009C9C9C00CECECE00CECECE009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C00CECECE00CECECE009C9C9C000000000000000000000000000000
      000000000000CE9C9C00F7EFBD00F7EFBD00CE630000CE633100CE633100CE63
      3100CE633100FFFFCE00FFFFCE00CE9C9C00B5A59400CEC6B500FFF7EF00FFFF
      F700FFFFF700FFF7EF00F7EFDE00F7DEC600EFCEAD00C6A57B00735239000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CECE9C00F7EFBD00FFFFCE00F7EFBD00FFFFCE00FFFFCE00FFFF
      CE00FFFFCE00FFFFCE00F7EFBD00CE9C9C000000000000000000000000000000
      000000000000B5B5B500CECECE00CECECE00CECECE00CECECE00CECECE00CECE
      CE00CECECE00CECECE00CECECE009C9C9C000000000000000000000000000000
      000000000000CECE9C00F7EFBD00F7EFBD00FFCE9C00FFCE9C00CE633100F7EF
      BD00F7EFBD00FFFFCE00F7EFBD00CE9C9C00CEC6BD00BDB5A500F7EFE700FFFF
      F700FFFFF700FFF7EF00F7EFD600F7DEBD00E7CEA5009C846B006B5239000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFCECE00CECE9C00FFFFFF00FFFFFF00F7EFBD00F7EFBD00F7EF
      BD00F7EFBD00FFFFCE00CECE9C00CECE9C000000000000000000000000000000
      000000000000E7E7E700B5B5B500E7E7E700E7E7E700CECECE00CECECE00CECE
      CE00CECECE00CECECE00B5B5B500B5B5B5000000000000000000000000000000
      000000000000FFCECE00CECE9C00FFFFCE00FFFFCE00FFCE9C00CE633100FFFF
      CE00F7EFBD00FFFFCE00CECE9C00CECE9C00846B5200B59C9400D6C6BD00F7F7
      EF00FFF7E700F7F7DE00F7EFCE00E7D6B500B59C8400735A4200735A42000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E7E7E700CE9C9C00EFC6DE00FFFFFF00FFFFCE00F7EFBD00F7EF
      BD00F7EFBD00FFCE9C00CE9C9C00E7E7E7000000000000000000000000000000
      000000000000E7E7E7009C9C9C00E7E7E700E7E7E700CECECE00CECECE00CECE
      CE00CECECE00E7E7E7009C9C9C00E7E7E7000000000000000000000000000000
      000000000000E7E7E700CE9C9C00E7E7E700FFFFFF00F7EFBD00F7EFBD00F7EF
      BD00F7EFBD00FFCE9C00CE9C9C00E7E7E70000000000CEC6BD00B5A59400CEBD
      B500D6CEBD00DED6BD00C6B59C00A5947300846B5200846B5200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFCECE00CE9C9C00FFCECE00F7EFBD00F7EFBD00F7EF
      BD00CECE9C00CE9C9C00FFCECE00000000000000000000000000000000000000
      00000000000000000000E7E7E7009C9C9C00E7E7E700CECECE00CECECE00CECE
      CE00B5B5B5009C9C9C00E7E7E700000000000000000000000000000000000000
      00000000000000000000FFCECE00CE9C9C00FFCECE00F7EFBD00F7EFBD00F7EF
      BD00FFCE9C00CE9C9C00FFCECE000000000000000000B59C9400E7DEDE00CEC6
      B500B5A59400AD948C009C847300A58C7B00D6B5A50000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000E7E7E700CECE9C00CE9C9C00CE9C9C00CE9C
      9C00CE9C9C00E7E7E70000000000000000000000000000000000000000000000
      0000000000000000000000000000E7E7E700B5B5B5009C9C9C009C9C9C009C9C
      9C009C9C9C00E7E7E70000000000000000000000000000000000000000000000
      0000000000000000000000000000E7E7E700CECE9C00CE9C9C00CE9C9C00CE9C
      9C00CE9C9C00E7E7E70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000F7000000DE000000FF0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009C7363009C6B63009C6B63009C6B
      63009C6B63009463630000000000000000000000000000000000000000000000
      00000000000000000000AD5A3100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B5A59400634A
      3100634A3100634A3100634A3100634A3100634A3100634A3100634A3100634A
      3100634A310000000000000000000000000000000000000000000000000000F7
      000000D6000000D6000000F70000AD8C73004A5A2900007B000000C6000000F7
      000000000000000000000000000000000000AD7B6B00FFDEBD00DEDED600DEDE
      D600DED6CE00DECEC600DECEC600DECEBD00DEC6B500DEC6B500DEBDB500DEBD
      AD00DEBDAD009C6B630000000000000000000000000000000000000000000000
      000000000000B5633900944A2900AD5A31000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B5A59400FFFF
      FF00B5A59400B59C9400737B9C00B59C9400B5A59400B5A59400B5A59400B5A5
      9400634A31000000000000000000000000000000000000940000007300000073
      AD000073A500006BA50000630000CE949400FFBD5A00DEB5B5007B5A4200006B
      000000B5000000EF000000FF000000000000AD7B6B00FFDEBD00FFDEBD00FFDE
      BD00FFDEBD00FFDEBD00FFDEBD00FFDEB500FFDEB500FFDEB500FFD6AD00FFD6
      AD00DEBDAD009C6B630000000000000000000000000000000000000000000000
      0000B5633900944A2900B5633900AD5A3100AD5A390000000000000000000000
      0000000000000000000000000000000000000000000000000000B5A59400FFFF
      FF00EFAD8C003152C6001039B5006B7BCE00CE845200CE845200E7CEBD00B5A5
      9400634A310000000000000000000000000000000000FFF7DE00FFF7E70031AD
      D600D6F7F7001094BD00FFF7DE00D6947B00FFAD2100FFAD2900FFB52900E7B5
      9400B56B6300085A0000009C000000F70000B5847300FFE7C600FFE7C600D6A5
      8400D6A58400D6A58400D6A58400D6A58400D6A58400D6A58400D6A58400FFD6
      B500DEBDAD009C6B630000000000000000000000000000000000B55A3100B563
      39009C522900C6734A00D67B4A00C66B4200AD5A31009C5A2900000000000000
      0000000000000000000000000000000000000000000000000000B5A59400DEE7
      F700294AC6002952EF00214AE7001039B5009C9CCE00EFDED600E7CEC600B5A5
      9400634A3100000000000000000000000000000000000000000000E7000021A5
      D6004AB5DE0042ADD60010D61000DE9C5A00FFBD3900FFBD4200FFBD4A00FFBD
      4A00FFBD4200EFAD5A00BD6B630000D60000B5847300FFE7CE00FFE7CE00FFE7
      CE00FFE7CE00FFE7C600FFE7C600FFE7C600FFDEBD00FFDEBD00FFDEBD00FFDE
      B500DEBDB500A5736300000000000000000000000000DE8C6300AD5A3100B563
      3900D6845A00EFA57B00E7946B00E7946B00BD6B3900AD5A31008C4221000000
      0000000000000000000000000000000000000000000000000000B5A594001842
      BD002952F7006384FF005273FF003963EF002142B500B57B5A00E7D6CE00B5A5
      9400634A31000000000000000000000000000000000000FF00009C735A00005A
      0000FFF7E700006B00006BBD5A00F7B55200FFC65200FFC65A00FFC65A00FFC6
      5A00FFC65200FFBD4A00CE6B6B0000D60000BD8C7300FFEFD600FFEFD600D6A5
      8400D6A58400D6A58400D6A58400D6A58400D6A58400D6A58400D6A58400FFDE
      BD00DEC6B50000000000000000000000000000000000EFA57B00EFAD8C00EFA5
      7B00EFA57B00E7946B00D67B4A00E7946B00EFA57B00B56339009C5231000000
      0000000000000000000000000000000000000000000000000000BDA5940084A5
      FF007B94FF007B94FF00E7E7FF00849CFF004263E7003952B500E7DED600B5A5
      9400634A31000000000000000000000000000000000039C62100F79C2100F7D6
      B500CE7B7B00184A0800CEB5B500FFC65A00FFD66B00FFD67300FFD67B00FFD6
      7300FFD66B00FFCE5A009463520000E70000C6947B00FFEFDE00FFEFDE00D6A5
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00D6A58400FFDE
      BD00DEC6B500A57B6B00000000000000000000000000FFAD8C00F7B59C00F7BD
      9C00EFA58400EF9C630000000000D67B4A00EFA57B00E7946B00AD5A31008C42
      2100000000000000000000000000000000000000000000000000BDAD9C00EFEF
      FF00C6CEFF00F7BDA500EFAD8C00D69484007B94F7002952DE00526BB500B5A5
      9400634A31000000000000000000000000000000000094A57300FFAD2100FFAD
      2100FFAD2900F7BD6B00E7D6D600FFD66B00FFDE8400FFDE8C00FFE79400FFDE
      8C00FFDE8400FFD673006363390000EF0000CE9C7B00FFEFDE00FFEFDE00D6A5
      8400FFFFFF009C9C9C000031CE009C9CFF0039528C00FFFFFF00D6A58400FFE7
      C600DECEBD00AD7B6B0000000000000000000000000000000000FFCE9C00F7B5
      840000000000000000000000000000000000D67B4A00E79C7300DE845A00AD5A
      31008C4221000000000000000000000000000000000000000000C6AD9C00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7F7FF00738CF700214AD6006B6B
      9400634A310000000000000000000000000000000000D6ADAD00FFB53900FFBD
      4200FFBD4A00FFBD4A00D6C6C600FFDE8400FFE79400FFEFA500FFEFA500FFEF
      A500FFE79400FFDE8400316B180000F70000CE9C8400FFF7E700FFF7E700D6A5
      8400FFFFFF00FFFFFF00CEEFFF00CEEFFF009C9CFF0039528C00D6A58400FFE7
      C600DECEC600AD7B6B0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D67B4A00E79C7B00D67B
      5200A55A31008C42210000000000000000000000000000000000CEB5A500FFFF
      FF00F7D6BD00F7CEB500EFBD9C00E7AD8C00DEA57B00DE9C73007B94F700214A
      D60042395A0000000000000000000000000000000000D6B5B500FFBD4A00FFC6
      5A00FFC65A00E7BD6B00BDB5AD00FFDE8C00FFEFA500FFF7B500FFFFBD00FFF7
      BD00FFEFA500FFE794000073000000000000D6A58400FFF7EF00FFF7EF00D6A5
      8400FF313100FF313100CEEFFF007B7BFF004A5AFF002152FF0039528C00FFE7
      CE00DECEC600B584730000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D67B4A00E794
      7300D67B4A00A55A31008C422100000000000000000000000000CEB5A500FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B5A594007B8C
      DE00214AD60000000000000000000000000000F70000CEA59400FFCE6300FFD6
      6B00FFD67300D6BD8400E7E7E700DED6D600B5A5A500A58C8C00BD9C9400E7D6
      AD00FFEFAD00EFCE8C00008C000000000000D6A58400FFFFF700FFFFF700D6A5
      8400D6A58400D6A58400D6A584009C9CFF007B7BFF004A5AFF002152FF003952
      8C00DED6CE00B584730000000000000000003131290000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000010080800B5634200AD5A31008C4221000000000000000000D6BDAD00FFFF
      FF00F7D6BD00F7CEB500EFBD9C00E7AD8C00DEA57B00DE9C7300634A3100634A
      3100634A310000000000000000000000000042BD3900D6AD7B00FFD67300FFDE
      8400FFE78C00FFE79400FFDE8400FFDE8400DEA57300529C4A009CB58C00D6BD
      BD00D6BDBD00C694940000C6000000000000DEAD8C00FFFFF700FFFFF700FFFF
      F700FFFFF700FFFFF700FFF7EF00FFF7EF009C9CFF007B7BFF004A5AFF002152
      FF0039528C00B584730000000000000000000000000000000000000000000000
      0000000000000000000000000000101010000000000000000000000000000000
      00001818180073524200D67B52009C5229000000000000000000D6BDAD00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00BDA59400D6C6BD00634A
      3100CEB5A5000000000000000000000000009CBD9400EFC67300FFDE8400FFE7
      9400FFEFA500FFEFA500FFE79C00FFE78C00CE8C7B0000BD0000000000000000
      000000000000000000000000000000000000E7AD8C00FFFFFF00FFFFFF00D6A5
      8400D6A58400D6A58400D6A58400D6A58400D6A584009C9CFF007B7BFF004A5A
      FF002152FF0039528C000000000000000000000000005A525200000000002921
      210000000000000000001010100073736B002929290000000000000000000000
      00000000000000000000F7AD8C00DE845A000000000000000000DEC6B500FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6AD9C00634A3100CEB5
      A50000000000000000000000000000000000E7E7E700E7C68400FFE79400FFEF
      AD00FFF7BD00FFF7BD00FFF7AD00FFE79400BD7B7B0000D60000000000000000
      000000000000000000000000000000000000E7B58C00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFF700FFFFF700FFF7EF00FFF7E700FFEFDE009C9CFF007B7B
      FF004A5AFF002152FF0039528C000000000052525200525252005A5A5A005252
      52001818180000000000000000005A5A5A005A5A5A0021212100000000000000
      0000000000000000000000000000000000000000000000000000DEC6B500DEC6
      B500DEC6B500DEC6B500DEC6B500D6BDAD00CEBDAD00CEB5A500CEB5A5000000
      000000000000000000000000000000000000CECECE00EFEFEF00CEC6C600AD94
      9400A58C8C00CEB5A500F7E7AD00FFEFA5009473630000DE0000000000000000
      000000000000000000000000000000000000E7B58C00E7B58C00E7B58C00E7B5
      8C00E7B58C00DEAD8C00DEAD8400D6A58400CE9C8400CE9C7B00C6947B009C9C
      FF007B7BFF000031CE000031CE0000000000E7E7C600DED6CE006B6B6B00E7DE
      D600424242004A4A4A004A4A4A00636363005252520042424200393939002929
      2900292929000808080000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000029E7
      21006BBD6300CEB5B500DEC6C600CEA5A5006B8C4A0000F70000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000004AFF00004AFF000031CE00000000000000000000000000000000000000
      0000000000008484840084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084848400B5B5B5009C9C9C00B5B5B5008484840084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084848400B5B5B5009C9C9C00B5B5B5008484840084848400000000000000
      00000000000000000000000000000000000000000000CE9C6300CE9C6300CE9C
      6300CE9C6300CE9C6300CE9C6300CE9C6300CE9C6300CE9C6300CE9C6300CE9C
      6300CE9C6300CE9C6300CE9C6300CE9C6300000000009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C000000000000000000000000008484
      8400B5B5B5009C9C9C00FFFFFF00FFFFFF00B5B5B500B5B5B500848484008484
      8400000000000000000000000000000000000000000000000000000000008484
      8400B5B5B5009C9C9C000000000000000000B5B5B500B5B5B500848484008484
      84000000000000000000000000000000000000000000CE9C6300FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00CE9C6300000000009C9C9C00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF009C9C9C000000000000000000000000008484
      84009C9C9C00FFFFFF009C9C9C009C9C9C00FFFFFF00FFFFFF00B5B5B500B5B5
      B500848484008484840000000000000000000000000000000000000000008484
      84009C9C9C00000000009C9C9C009C9C9C000000000000000000B5B5B500B5B5
      B5008484840084848400000000000000000000000000CE9C6300FFFFFF009C31
      00009C3100009C3100009C3100009C3100009C3100009C3100009C3100009C31
      00009C3100009C310000FFFFFF00CE9C6300000000009C9C9C00FFFFFF009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C00FFFFFF009C9C9C00000000000000000084848400B5B5
      B5009C9C9C00FFFFFF0084848400B5B5B5009C9C9C00FFFFFF00FFFFFF00FFFF
      FF00B5B5B500B5B5B5008484840000000000000000000000000084848400B5B5
      B5009C9C9C000000000084848400B5B5B5009C9C9C0000000000000000000000
      0000B5B5B500B5B5B500848484000000000000000000CE9C6300FFFFFF009C31
      0000CE9C6300CE9C6300CE9C6300CE9C6300CE9C6300CE9C6300CE9C6300CE9C
      6300CE9C63009C310000FFFFFF00CE9C6300000000009C9C9C00FFFFFF009C9C
      9C00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECE
      CE00CECECE009C9C9C00FFFFFF009C9C9C000000000000000000848484009C9C
      9C00FFFFFF00B5B5B50084848400B5B5B5009C9C9C00FFFFFF00848484008484
      8400FFFFFF00FFFFFF0084848400000000000000000000000000848484009C9C
      9C0000000000B5B5B50084848400B5B5B5009C9C9C0000000000848484008484
      84000000000000000000848484000000000000000000CE9C6300FFFFFF009C31
      00009C3100009C3100009C3100009C3100009C3100009C3100009C3100009C31
      00009C3100009C310000FFFFFF00CE9C6300000000009C9C9C00FFFFFF009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C00FFFFFF009C9C9C000000000084848400B5B5B5009C9C
      9C00FFFFFF00B5B5B500E7E7E700B5B5B500FFFFFF00FFFFFF00FFFFFF00B5B5
      B50084848400FFFFFF0084848400000000000000000084848400B5B5B5009C9C
      9C0000000000B5B5B500E7E7E700B5B5B500000000000000000000000000B5B5
      B5008484840000000000848484000000000000000000CE9C6300FFFFFF009C31
      0000CE9C6300CE9C6300CE9C6300CE9C6300CE9C6300CE9C6300CE9C6300CE9C
      6300CE9C63009C310000FFFFFF00CE9C6300000000009C9C9C00FFFFFF009C9C
      9C00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECE
      CE00CECECE009C9C9C00FFFFFF009C9C9C0000000000848484009C9C9C00FFFF
      FF00B5B5B500E7E7E700E7E7E700B5B5B500FFFFFF008484840084848400FFFF
      FF00FFFFFF00FFFFFF00848484000000000000000000848484009C9C9C000000
      0000B5B5B500E7E7E700E7E7E700B5B5B5000000000084848400848484000000
      00000000000000000000848484000000000000000000CE9C6300FFFFFF009C31
      00009C3100009C3100009C3100009C3100009C3100009C3100009C3100009C31
      00009C3100009C310000FFFFFF00CE9C6300000000009C9C9C00FFFFFF009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C00FFFFFF009C9C9C0084848400B5B5B5009C9C9C00FFFF
      FF00FFFFFF00FFFFFF00B5B5B500FFFFFF00FFFFFF00FFFFFF00B5B5B5008484
      8400FFFFFF0084848400000000000000000084848400B5B5B5009C9C9C000000
      00000000000000000000B5B5B500000000000000000000000000B5B5B5008484
      84000000000084848400000000000000000000000000CE9C6300FFFFFF009C31
      0000CE9C6300CE9C6300CE9C6300CE9C6300CE9C6300CE9C6300CE9C6300CE9C
      6300CE9C63009C310000FFFFFF00CE9C6300000000009C9C9C00FFFFFF009C9C
      9C00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECE
      CE00CECECE009C9C9C00FFFFFF009C9C9C00848484009C9C9C00FFFFFF00FFFF
      FF009C3100009C310000FFFFFF00FFFFFF008484840084848400FFFFFF00FFFF
      FF00FFFFFF00848484000000000000000000848484009C9C9C00000000000000
      0000848484008484840000000000000000008484840084848400000000000000
      00000000000084848400000000000000000000000000CE9C6300FFFFFF009C31
      00009C3100009C3100009C3100009C3100009C3100009C3100009C3100009C31
      00009C3100009C310000FFFFFF00CE9C6300000000009C9C9C00FFFFFF009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C00FFFFFF009C9C9C00000000009C9C9C009C9C9C00FFFF
      FF00FFFFFF00B5B5B5009C3100009C310000FFFFFF00FFFFFF0084848400FFFF
      FF0084848400000000000000000000000000000000009C9C9C009C9C9C000000
      000000000000B5B5B50084848400848484000000000000000000848484000000
      00008484840000000000000000000000000000000000CE9C6300FFFFFF009C31
      0000CE9C6300CE9C6300CE9C6300CE9C6300CE9C6300CE9C6300CE9C6300CE9C
      6300CE9C63009C310000FFFFFF00CE9C6300000000009C9C9C00FFFFFF009C9C
      9C00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECE
      CE00CECECE009C9C9C00FFFFFF009C9C9C000000000000000000000000009C9C
      9C009C9C9C00FFFFFF00FFFFFF00B5B5B5009C3100009C310000FFFFFF00FFFF
      FF00848484000000000000000000000000000000000000000000000000009C9C
      9C009C9C9C000000000000000000B5B5B5008484840084848400000000000000
      00008484840000000000000000000000000000000000CE9C6300FFFFFF009C31
      00009C3100009C3100009C3100009C3100009C3100009C3100009C3100009C31
      00009C3100009C310000FFFFFF00CE9C6300000000009C9C9C00FFFFFF009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C00FFFFFF009C9C9C000000000000000000000000000000
      0000000000009C9C9C009C9C9C00FFFFFF00FFFFFF00B5B5B500FFFFFF008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000009C9C9C009C9C9C000000000000000000B5B5B500000000008484
      84000000000000000000000000000000000000000000CE9C6300FFFFFF009C31
      0000CE9C6300CE9C6300CE9C6300CE9C6300CE9C6300CE9C6300CE9C6300CE9C
      6300CE9C63009C310000FFFFFF00CE9C6300000000009C9C9C00FFFFFF009C9C
      9C00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECE
      CE00CECECE009C9C9C00FFFFFF009C9C9C000000000000000000000000000000
      00000000000000000000000000009C9C9C009C9C9C00FFFFFF00FFFFFF008484
      8400000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000009C9C9C009C9C9C0000000000000000008484
      84000000000000000000000000000000000000000000CE9C6300FFFFFF009C31
      00009C3100009C3100009C3100009C3100009C3100009C3100009C3100009C31
      00009C3100009C310000FFFFFF00CE9C6300000000009C9C9C00FFFFFF009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C00FFFFFF009C9C9C000000000000000000000000000000
      000000000000000000000000000000000000000000009C9C9C009C9C9C000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009C9C9C009C9C9C000000
      00000000000000000000000000000000000000000000CE9C6300FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00CE9C6300000000009C9C9C00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF009C9C9C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CE9C6300CE9C6300CE9C
      6300CE9C6300CE9C6300CE9C6300CE9C6300CE9C6300CE9C6300CE9C6300CE9C
      6300CE9C6300CE9C6300CE9C6300CE9C6300000000009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840000000000000000008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840084848400848484008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084848400FFFFFF0000000000000000008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084848400FFFFFF0084848400848484008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF0084848400FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      9C0000009C0000009C0000009C0000009C0000009C0000009C0000009C000000
      9C0000009C000000000000000000000000000000000000000000000000009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000FFFFFF008484840084848400000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400FFFFFF008484840084848400FFFFFF008484840084848400000000000000
      000000000000000000000000000000000000000000000000000000009C000000
      CE000000CE000000CE000000CE000000CE0000009C000000CE0000009C000000
      9C0000009C0000009C00000000000000000000000000000000009C9C9C00B5B5
      B500B5B5B500B5B5B500B5B5B500B5B5B5009C9C9C00B5B5B5009C9C9C009C9C
      9C009C9C9C009C9C9C0000000000000000000000000084848400000000000000
      0000000000000000000000000000848484000000000000000000000000000000
      000000000000000000000000000063639C000000000084848400848484008484
      8400848484008484840084848400848484008484840084848400000000000000
      00000000000000000000000000009C9C9C00000000000000000000009C000000
      FF000000CE000000CE000000CE000000CE000000CE0000009C000000CE000000
      9C0000009C0000009C00000000000000000000000000000000009C9C9C00CECE
      CE00B5B5B500B5B5B500B5B5B500B5B5B500B5B5B5009C9C9C00B5B5B5009C9C
      9C009C9C9C009C9C9C00000000000000000084848400FFFFFF00FFFFFF000000
      0000FFFFFF000000000000000000C6C6C6000000000000000000000000000000
      0000000000000000000063639C00319CCE0084848400FFFFFF00FFFFFF008484
      8400FFFFFF008484840084848400C6C6C6008484840084848400848484000000
      000000000000000000009C9C9C00CECECE00000000000000000000009C000000
      CE000000FF000000CE000000CE000000CE000000CE000000CE0000009C000000
      CE0000009C0000009C00000000000000000000000000000000009C9C9C00B5B5
      B500CECECE00B5B5B500B5B5B500B5B5B500B5B5B500B5B5B5009C9C9C00B5B5
      B5009C9C9C009C9C9C00000000000000000084848400FFFFFF00000000000000
      0000FFFFFF0084848400C6C6C600FFFFFF008484840000000000FFFFFF008484
      84000000000063639C00319CCE0063CEFF0084848400FFFFFF00848484008484
      8400FFFFFF0084848400C6C6C600FFFFFF008484840084848400FFFFFF008484
      8400000000009C9C9C00CECECE00FFFFFF00000000000000000000009C000000
      FF000000CE000000FF000000CE000000CE000000CE000000CE000000CE000000
      9C000000CE0000009C00000000000000000000000000000000009C9C9C00CECE
      CE00B5B5B500CECECE00B5B5B500B5B5B500B5B5B500B5B5B500B5B5B5009C9C
      9C00B5B5B5009C9C9C0000000000000000008484840000000000000000000000
      0000848484000000000000000000FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF0063639C00319CCE0063CEFF00000000008484840084848400848484008484
      8400848484008484840084848400FFFFFF0084848400FFFFFF00FFFFFF00FFFF
      FF009C9C9C00CECECE00FFFFFF0000000000000000000000000000009C000000
      FF000000FF000000CE000000FF000000CE000000CE000000CE000000CE000000
      CE0000009C0000009C00000000000000000000000000000000009C9C9C00CECE
      CE00CECECE00B5B5B500CECECE00B5B5B500B5B5B500B5B5B500B5B5B500B5B5
      B5009C9C9C009C9C9C0000000000000000000000000000000000000000008484
      8400000000000000000000000000000000000000000000000000FFFFFF006363
      9C00319CCE0063CEFF0000000000000000000000000084848400848484008484
      8400848484008484840084848400848484008484840084848400FFFFFF009C9C
      9C00CECECE00FFFFFF000000000000000000000000000000000000009C009C9C
      FF000000FF000000FF000000CE000000FF000000CE000000CE000000CE000000
      CE000000CE0000009C00000000000000000000000000000000009C9C9C00E7E7
      E700CECECE00CECECE00B5B5B500CECECE00B5B5B500B5B5B500B5B5B500B5B5
      B500B5B5B5009C9C9C0000000000000000000000000000000000C6C6C600C6C6
      C6000000000000000000FFFFFF0000000000000000000000000063639C00319C
      CE0063CEFF000000000000000000000000000000000084848400C6C6C600C6C6
      C6008484840084848400FFFFFF008484840084848400848484009C9C9C00CECE
      CE00FFFFFF00000000000000000000000000000000000000000000009C009C9C
      FF009C9CFF000000FF000000FF000000CE000000FF000000CE000000CE000000
      CE000000CE0000009C00000000000000000000000000000000009C9C9C00E7E7
      E700E7E7E700CECECE00CECECE00B5B5B500CECECE00B5B5B500B5B5B500B5B5
      B500B5B5B5009C9C9C0000000000000000000000000084848400C6C6C600FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF000000000063639C00319CCE0063CE
      FF00000000000000000000000000000000000000000084848400C6C6C600FFFF
      FF0084848400FFFFFF00FFFFFF00FFFFFF00848484009C9C9C00CECECE00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      9C0000009C0000009C0000009C0000009C0000009C0000009C0000009C000000
      9C0000009C000000000000000000000000000000000000000000000000009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C000000000000000000000000000000000000000000848484008484
      84000000000000000000FFFFFF00FFFFFF0063639C00319CCE0063CEFF000000
      0000000000000000000000000000000000000000000000000000848484008484
      84008484840084848400FFFFFF00FFFFFF009C9C9C00CECECE00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000063639C00319CCE0063CEFF00000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      84008484840084848400848484009C9C9C00CECECE00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000063639C00319CCE0063CEFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084848400848484009C9C9C00CECECE00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000063639C00319CCE0063CEFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009C9C9C00CECECE00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000009C
      9C00009C9C00009C9C00009C9C00009C9C00009C9C00009C9C00009C9C00009C
      9C00009C9C000000000000000000000000000000000000000000000000009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C000000000000000000000000000000000000000000000000000063
      CE000063CE000063CE000063CE000063CE000063CE000063CE000063CE000063
      CE000063CE000000000000000000000000000000000000000000000000009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C000000000000000000000000000000000000000000009C9C0000CE
      CE0000CECE0000CECE0000CECE0000CECE00009C9C0000CECE00009C9C00009C
      9C00009C9C00009C9C00000000000000000000000000000000009C9C9C00B5B5
      B500B5B5B500B5B5B500B5B5B500B5B5B5009C9C9C00B5B5B5009C9C9C009C9C
      9C009C9C9C009C9C9C00000000000000000000000000000000000063CE00009C
      FF00009CFF00009CFF00009CFF00009CFF000063CE00009CFF000063CE000063
      CE000063CE000063CE00000000000000000000000000000000009C9C9C00B5B5
      B500B5B5B500B5B5B500B5B5B500B5B5B5009C9C9C00B5B5B5009C9C9C009C9C
      9C009C9C9C009C9C9C0000000000000000000000000000000000009C9C0000FF
      FF0000CECE0000CECE0000CECE0000CECE0000CECE00009C9C0000CECE00009C
      9C00009C9C00009C9C00000000000000000000000000000000009C9C9C00CECE
      CE00B5B5B500B5B5B500B5B5B500B5B5B500B5B5B5009C9C9C00B5B5B5009C9C
      9C009C9C9C009C9C9C00000000000000000000000000000000000063CE0000CE
      FF00009CFF00009CFF00009CFF00009CFF00009CFF000063CE00009CFF000063
      CE000063CE000063CE00000000000000000000000000000000009C9C9C00CECE
      CE00B5B5B500B5B5B500B5B5B500B5B5B500B5B5B5009C9C9C00B5B5B5009C9C
      9C009C9C9C009C9C9C0000000000000000000000000000000000009C9C0000CE
      CE0000FFFF0000CECE0000CECE0000CECE0000CECE0000CECE00009C9C0000CE
      CE00009C9C00009C9C00000000000000000000000000000000009C9C9C00B5B5
      B500CECECE00B5B5B500B5B5B500B5B5B500B5B5B500B5B5B5009C9C9C00B5B5
      B5009C9C9C009C9C9C00000000000000000000000000000000000063CE00009C
      FF0000CEFF00009CFF00009CFF00009CFF00009CFF00009CFF000063CE00009C
      FF000063CE000063CE00000000000000000000000000000000009C9C9C00B5B5
      B500CECECE00B5B5B500B5B5B500B5B5B500B5B5B500B5B5B5009C9C9C00B5B5
      B5009C9C9C009C9C9C0000000000000000000000000000000000009C9C0000FF
      FF0000CECE0000FFFF0000CECE0000CECE0000CECE0000CECE0000CECE00009C
      9C0000CECE00009C9C00000000000000000000000000000000009C9C9C00CECE
      CE00B5B5B500CECECE00B5B5B500B5B5B500B5B5B500B5B5B500B5B5B5009C9C
      9C00B5B5B5009C9C9C00000000000000000000000000000000000063CE0000CE
      FF00009CFF0000CEFF00009CFF00009CFF00009CFF00009CFF00009CFF000063
      CE00009CFF000063CE00000000000000000000000000000000009C9C9C00CECE
      CE00B5B5B500CECECE00B5B5B500B5B5B500B5B5B500B5B5B500B5B5B5009C9C
      9C00B5B5B5009C9C9C0000000000000000000000000000000000009C9C0000FF
      FF0000FFFF0000CECE0000FFFF0000CECE0000CECE0000CECE0000CECE0000CE
      CE00009C9C00009C9C00000000000000000000000000000000009C9C9C00CECE
      CE00CECECE00B5B5B500CECECE00B5B5B500B5B5B500B5B5B500B5B5B500B5B5
      B5009C9C9C009C9C9C00000000000000000000000000000000000063CE0000CE
      FF0000CEFF00009CFF0000CEFF00009CFF00009CFF00009CFF00009CFF00009C
      FF000063CE000063CE00000000000000000000000000000000009C9C9C00CECE
      CE00CECECE00B5B5B500CECECE00B5B5B500B5B5B500B5B5B500B5B5B500B5B5
      B5009C9C9C009C9C9C0000000000000000000000000000000000009C9C00FFFF
      FF0000FFFF0000FFFF0000CECE0000FFFF0000CECE0000CECE0000CECE0000CE
      CE0000CECE00009C9C00000000000000000000000000000000009C9C9C00E7E7
      E700CECECE00CECECE00B5B5B500CECECE00B5B5B500B5B5B500B5B5B500B5B5
      B500B5B5B5009C9C9C00000000000000000000000000000000000063CE009CCE
      FF0000CEFF0000CEFF00009CFF0000CEFF00009CFF00009CFF00009CFF00009C
      FF00009CFF000063CE00000000000000000000000000000000009C9C9C00E7E7
      E700CECECE00CECECE00B5B5B500CECECE00B5B5B500B5B5B500B5B5B500B5B5
      B500B5B5B5009C9C9C0000000000000000000000000000000000009C9C009CFF
      FF00FFFFFF0000FFFF0000FFFF0000CECE0000FFFF0000CECE0000CECE0000CE
      CE0000CECE00009C9C00000000000000000000000000000000009C9C9C00E7E7
      E700E7E7E700CECECE00CECECE00B5B5B500CECECE00B5B5B500B5B5B500B5B5
      B500B5B5B5009C9C9C00000000000000000000000000000000000063CE009CCE
      FF009CCEFF0000CEFF0000CEFF00009CFF0000CEFF00009CFF00009CFF00009C
      FF00009CFF000063CE00000000000000000000000000000000009C9C9C00E7E7
      E700E7E7E700CECECE00CECECE00B5B5B500CECECE00B5B5B500B5B5B500B5B5
      B500B5B5B5009C9C9C000000000000000000000000000000000000000000009C
      9C00009C9C00009C9C00009C9C00009C9C00009C9C00009C9C00009C9C00009C
      9C00009C9C000000000000000000000000000000000000000000000000009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C000000000000000000000000000000000000000000000000000063
      CE000063CE000063CE000063CE000063CE000063CE000063CE000063CE000063
      CE000063CE000000000000000000000000000000000000000000000000009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000CE63
      3100CE633100CE633100CE633100CE633100CE633100CE633100CE633100CE63
      3100CE6331000000000000000000000000000000000000000000000000009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C00000000000000000000000000000000000000000000000000009C
      0000009C0000009C0000009C0000009C0000009C0000009C0000009C0000009C
      0000009C00000000000000000000000000000000000000000000000000009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C000000000000000000000000000000000000000000CE633100FF9C
      6300FF9C6300FF9C6300FF9C6300FF9C6300CE633100FF9C6300CE633100CE63
      3100CE633100CE633100000000000000000000000000000000009C9C9C00B5B5
      B500B5B5B500B5B5B500B5B5B500B5B5B5009C9C9C00B5B5B5009C9C9C009C9C
      9C009C9C9C009C9C9C0000000000000000000000000000000000009C000000CE
      000000CE000000CE000000CE000000CE0000009C000000CE0000009C0000009C
      0000009C0000009C0000000000000000000000000000000000009C9C9C00B5B5
      B500B5B5B500B5B5B500B5B5B500B5B5B5009C9C9C00B5B5B5009C9C9C009C9C
      9C009C9C9C009C9C9C0000000000000000000000000000000000CE633100FFCE
      9C00FF9C6300FF9C6300FF9C6300FF9C6300FF9C6300CE633100FF9C6300CE63
      3100CE633100CE633100000000000000000000000000000000009C9C9C00CECE
      CE00B5B5B500B5B5B500B5B5B500B5B5B500B5B5B5009C9C9C00B5B5B5009C9C
      9C009C9C9C009C9C9C0000000000000000000000000000000000009C000000FF
      000000CE000000CE000000CE000000CE000000CE0000009C000000CE0000009C
      0000009C0000009C0000000000000000000000000000000000009C9C9C00CECE
      CE00B5B5B500B5B5B500B5B5B500B5B5B500B5B5B5009C9C9C00B5B5B5009C9C
      9C009C9C9C009C9C9C0000000000000000000000000000000000CE633100FF9C
      6300FFCE9C00FF9C6300FF9C6300FF9C6300FF9C6300FF9C6300CE633100FF9C
      6300CE633100CE633100000000000000000000000000000000009C9C9C00B5B5
      B500CECECE00B5B5B500B5B5B500B5B5B500B5B5B500B5B5B5009C9C9C00B5B5
      B5009C9C9C009C9C9C0000000000000000000000000000000000009C000000CE
      000000FF000000CE000000CE000000CE000000CE000000CE0000009C000000CE
      0000009C0000009C0000000000000000000000000000000000009C9C9C00B5B5
      B500CECECE00B5B5B500B5B5B500B5B5B500B5B5B500B5B5B5009C9C9C00B5B5
      B5009C9C9C009C9C9C0000000000000000000000000000000000CE633100FFCE
      9C00FF9C6300FFCE9C00FF9C6300FF9C6300FF9C6300FF9C6300FF9C6300CE63
      3100FF9C6300CE633100000000000000000000000000000000009C9C9C00CECE
      CE00B5B5B500CECECE00B5B5B500B5B5B500B5B5B500B5B5B500B5B5B5009C9C
      9C00B5B5B5009C9C9C0000000000000000000000000000000000009C000000FF
      000000CE000000FF000000CE000000CE000000CE000000CE000000CE0000009C
      000000CE0000009C0000000000000000000000000000000000009C9C9C00CECE
      CE00B5B5B500CECECE00B5B5B500B5B5B500B5B5B500B5B5B500B5B5B5009C9C
      9C00B5B5B5009C9C9C0000000000000000000000000000000000CE633100FFCE
      9C00FFCE9C00FF9C6300FFCE9C00FF9C6300FF9C6300FF9C6300FF9C6300FF9C
      6300CE633100CE633100000000000000000000000000000000009C9C9C00CECE
      CE00CECECE00B5B5B500CECECE00B5B5B500B5B5B500B5B5B500B5B5B500B5B5
      B5009C9C9C009C9C9C0000000000000000000000000000000000009C000000FF
      000000FF000000CE000000FF000000CE000000CE000000CE000000CE000000CE
      0000009C0000009C0000000000000000000000000000000000009C9C9C00CECE
      CE00CECECE00B5B5B500CECECE00B5B5B500B5B5B500B5B5B500B5B5B500B5B5
      B5009C9C9C009C9C9C0000000000000000000000000000000000CE633100FFFF
      CE00FFCE9C00FFCE9C00FF9C6300FFCE9C00FF9C6300FF9C6300FF9C6300FF9C
      6300FF9C6300CE633100000000000000000000000000000000009C9C9C00E7E7
      E700CECECE00CECECE00B5B5B500CECECE00B5B5B500B5B5B500B5B5B500B5B5
      B500B5B5B5009C9C9C0000000000000000000000000000000000009C00009CFF
      9C0000FF000000FF000000CE000000FF000000CE000000CE000000CE000000CE
      000000CE0000009C0000000000000000000000000000000000009C9C9C00E7E7
      E700CECECE00CECECE00B5B5B500CECECE00B5B5B500B5B5B500B5B5B500B5B5
      B500B5B5B5009C9C9C0000000000000000000000000000000000CE633100FFFF
      CE00FFFFCE00FFCE9C00FFCE9C00FF9C6300FFCE9C00FF9C6300FF9C6300FF9C
      6300FF9C6300CE633100000000000000000000000000000000009C9C9C00E7E7
      E700E7E7E700CECECE00CECECE00B5B5B500CECECE00B5B5B500B5B5B500B5B5
      B500B5B5B5009C9C9C0000000000000000000000000000000000009C00009CFF
      9C009CFF9C0000FF000000FF000000CE000000FF000000CE000000CE000000CE
      000000CE0000009C0000000000000000000000000000000000009C9C9C00E7E7
      E700E7E7E700CECECE00CECECE00B5B5B500CECECE00B5B5B500B5B5B500B5B5
      B500B5B5B5009C9C9C000000000000000000000000000000000000000000CE63
      3100CE633100CE633100CE633100CE633100CE633100CE633100CE633100CE63
      3100CE6331000000000000000000000000000000000000000000000000009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C00000000000000000000000000000000000000000000000000009C
      0000009C0000009C0000009C0000009C0000009C0000009C0000009C0000009C
      0000009C00000000000000000000000000000000000000000000000000009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C000000000000000000000000000000000000000000000000009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C000000000000000000000000000000000000000000000000009C00
      00009C0000009C0000009C0000009C0000009C0000009C0000009C0000009C00
      00009C0000000000000000000000000000000000000000000000000000009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C0000000000000000000000000000000000000000009C9C9C00B5B5
      B500B5B5B500B5B5B500B5B5B500B5B5B5009C9C9C00B5B5B5009C9C9C009C9C
      9C009C9C9C009C9C9C00000000000000000000000000000000009C9C9C00B5B5
      B500B5B5B500B5B5B500B5B5B500B5B5B5009C9C9C00B5B5B5009C9C9C009C9C
      9C009C9C9C009C9C9C00000000000000000000000000000000009C000000CE00
      0000CE000000CE000000CE000000CE0000009C000000CE0000009C0000009C00
      00009C0000009C000000000000000000000000000000000000009C9C9C00B5B5
      B500B5B5B500B5B5B500B5B5B500B5B5B5009C9C9C00B5B5B5009C9C9C009C9C
      9C009C9C9C009C9C9C00000000000000000000000000000000009C9C9C00CECE
      CE00B5B5B500B5B5B500B5B5B500B5B5B500B5B5B5009C9C9C00B5B5B5009C9C
      9C009C9C9C009C9C9C00000000000000000000000000000000009C9C9C00CECE
      CE00B5B5B500B5B5B500B5B5B500B5B5B500B5B5B5009C9C9C00B5B5B5009C9C
      9C009C9C9C009C9C9C00000000000000000000000000000000009C000000FF00
      0000CE000000CE000000CE000000CE000000CE0000009C000000CE0000009C00
      00009C0000009C000000000000000000000000000000000000009C9C9C00CECE
      CE00B5B5B500B5B5B500B5B5B500B5B5B500B5B5B5009C9C9C00B5B5B5009C9C
      9C009C9C9C009C9C9C00000000000000000000000000000000009C9C9C00B5B5
      B500CECECE00B5B5B500B5B5B500B5B5B500B5B5B500B5B5B5009C9C9C00B5B5
      B5009C9C9C009C9C9C00000000000000000000000000000000009C9C9C00B5B5
      B500CECECE00B5B5B500B5B5B500B5B5B500B5B5B500B5B5B5009C9C9C00B5B5
      B5009C9C9C009C9C9C00000000000000000000000000000000009C000000CE00
      0000FF000000CE000000CE000000CE000000CE000000CE0000009C000000CE00
      00009C0000009C000000000000000000000000000000000000009C9C9C00B5B5
      B500CECECE00B5B5B500B5B5B500B5B5B500B5B5B500B5B5B5009C9C9C00B5B5
      B5009C9C9C009C9C9C00000000000000000000000000000000009C9C9C00CECE
      CE00B5B5B500CECECE00B5B5B500B5B5B500B5B5B500B5B5B500B5B5B5009C9C
      9C00B5B5B5009C9C9C00000000000000000000000000000000009C9C9C00CECE
      CE00B5B5B500CECECE00B5B5B500B5B5B500B5B5B500B5B5B500B5B5B5009C9C
      9C00B5B5B5009C9C9C00000000000000000000000000000000009C000000FF00
      0000CE000000FF000000CE000000CE000000CE000000CE000000CE0000009C00
      0000CE0000009C000000000000000000000000000000000000009C9C9C00CECE
      CE00B5B5B500CECECE00B5B5B500B5B5B500B5B5B500B5B5B500B5B5B5009C9C
      9C00B5B5B5009C9C9C00000000000000000000000000000000009C9C9C00CECE
      CE00CECECE00B5B5B500CECECE00B5B5B500B5B5B500B5B5B500B5B5B500B5B5
      B5009C9C9C009C9C9C00000000000000000000000000000000009C9C9C00CECE
      CE00CECECE00B5B5B500CECECE00B5B5B500B5B5B500B5B5B500B5B5B500B5B5
      B5009C9C9C009C9C9C00000000000000000000000000000000009C000000FF00
      0000FF000000CE000000FF000000CE000000CE000000CE000000CE000000CE00
      00009C0000009C000000000000000000000000000000000000009C9C9C00CECE
      CE00CECECE00B5B5B500CECECE00B5B5B500B5B5B500B5B5B500B5B5B500B5B5
      B5009C9C9C009C9C9C00000000000000000000000000000000009C9C9C00E7E7
      E700CECECE00CECECE00B5B5B500CECECE00B5B5B500B5B5B500B5B5B500B5B5
      B500B5B5B5009C9C9C00000000000000000000000000000000009C9C9C00E7E7
      E700CECECE00CECECE00B5B5B500CECECE00B5B5B500B5B5B500B5B5B500B5B5
      B500B5B5B5009C9C9C00000000000000000000000000000000009C000000FF9C
      6300FF000000FF000000CE000000FF000000CE000000CE000000CE000000CE00
      0000CE0000009C000000000000000000000000000000000000009C9C9C00E7E7
      E700CECECE00CECECE00B5B5B500CECECE00B5B5B500B5B5B500B5B5B500B5B5
      B500B5B5B5009C9C9C00000000000000000000000000000000009C9C9C00E7E7
      E700E7E7E700CECECE00CECECE00B5B5B500CECECE00B5B5B500B5B5B500B5B5
      B500B5B5B5009C9C9C00000000000000000000000000000000009C9C9C00E7E7
      E700E7E7E700CECECE00CECECE00B5B5B500CECECE00B5B5B500B5B5B500B5B5
      B500B5B5B5009C9C9C00000000000000000000000000000000009C000000FF9C
      6300FF9C6300FF000000FF000000CE000000FF000000CE000000CE000000CE00
      0000CE0000009C000000000000000000000000000000000000009C9C9C00E7E7
      E700E7E7E700CECECE00CECECE00B5B5B500CECECE00B5B5B500B5B5B500B5B5
      B500B5B5B5009C9C9C0000000000000000000000000000000000000000009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C000000000000000000000000000000000000000000000000009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C000000000000000000000000000000000000000000000000009C00
      00009C0000009C0000009C0000009C0000009C0000009C0000009C0000009C00
      00009C0000000000000000000000000000000000000000000000000000009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CE9C63009C3100009C3100009C310000CE9C6300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CECECE009C9C9C009C9C9C009C9C9C00CECECE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CE9C63009C3100000000000000000000000000009C310000CE9C63000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CECECE009C9C9C000000000000000000000000009C9C9C00CECECE000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009C31000000000000000000000000000000000000000000009C3100000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009C9C9C0000000000000000000000000000000000000000009C9C9C000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009C31000000000000CE9C63009C310000CE9C6300000000009C3100000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009C9C9C0000000000CECECE009C9C9C00CECECE00000000009C9C9C000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009C310000000000009C310000000000009C310000000000009C3100000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009C9C9C00000000009C9C9C00000000009C9C9C00000000009C9C9C000000
      0000000000000000000000000000000000000000000000000000000000009C00
      63009C0063009C0063009C0063009C0063009C0063009C0063009C0063009C00
      63009C0063000000000000000000000000000000000000000000000000009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C000000000000000000000000000000000000000000000000000000
      00009C310000000000009C310000000000009C310000000000009C3100000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009C9C9C00000000009C9C9C00000000009C9C9C00000000009C9C9C000000
      00000000000000000000000000000000000000000000000000009C0063009C31
      63009C3163009C3163009C3163009C3163009C0063009C3163009C0063009C00
      63009C0063009C006300000000000000000000000000000000009C9C9C00B5B5
      B500B5B5B500B5B5B500B5B5B500B5B5B5009C9C9C00B5B5B5009C9C9C009C9C
      9C009C9C9C009C9C9C0000000000000000000000000000000000000000000000
      00009C310000000000009C310000000000009C310000000000009C3100000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009C9C9C00000000009C9C9C00000000009C9C9C00000000009C9C9C000000
      00000000000000000000000000000000000000000000000000009C006300CE63
      9C009C3163009C3163009C3163009C3163009C3163009C0063009C3163009C00
      63009C0063009C006300000000000000000000000000000000009C9C9C00CECE
      CE00B5B5B500B5B5B500B5B5B500B5B5B500B5B5B5009C9C9C00B5B5B5009C9C
      9C009C9C9C009C9C9C0000000000000000000000000000000000000000000000
      00009C310000000000009C310000000000009C310000000000009C3100000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009C9C9C00000000009C9C9C00000000009C9C9C00000000009C9C9C000000
      00000000000000000000000000000000000000000000000000009C0063009C31
      6300CE639C009C3163009C3163009C3163009C3163009C3163009C0063009C31
      63009C0063009C006300000000000000000000000000000000009C9C9C00B5B5
      B500CECECE00B5B5B500B5B5B500B5B5B500B5B5B500B5B5B5009C9C9C00B5B5
      B5009C9C9C009C9C9C0000000000000000000000000000000000000000000000
      00009C310000000000009C310000000000009C310000000000009C3100000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009C9C9C00000000009C9C9C00000000009C9C9C00000000009C9C9C000000
      00000000000000000000000000000000000000000000000000009C006300CE63
      9C009C316300CE639C009C3163009C3163009C3163009C3163009C3163009C00
      63009C3163009C006300000000000000000000000000000000009C9C9C00CECE
      CE00B5B5B500CECECE00B5B5B500B5B5B500B5B5B500B5B5B500B5B5B5009C9C
      9C00B5B5B5009C9C9C0000000000000000000000000000000000000000000000
      00009C310000000000009C310000000000009C310000000000009C3100000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009C9C9C00000000009C9C9C00000000009C9C9C00000000009C9C9C000000
      00000000000000000000000000000000000000000000000000009C006300CE63
      9C00CE639C009C316300CE639C009C3163009C3163009C3163009C3163009C31
      63009C0063009C006300000000000000000000000000000000009C9C9C00CECE
      CE00CECECE00B5B5B500CECECE00B5B5B500B5B5B500B5B5B500B5B5B500B5B5
      B5009C9C9C009C9C9C0000000000000000000000000000000000000000000000
      00009C310000000000009C310000000000009C310000000000009C3100000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009C9C9C00000000009C9C9C00000000009C9C9C00000000009C9C9C000000
      00000000000000000000000000000000000000000000000000009C006300FF9C
      CE00CE639C00CE639C009C316300CE639C009C3163009C3163009C3163009C31
      63009C3163009C006300000000000000000000000000000000009C9C9C00E7E7
      E700CECECE00CECECE00B5B5B500CECECE00B5B5B500B5B5B500B5B5B500B5B5
      B500B5B5B5009C9C9C0000000000000000000000000000000000000000000000
      00009C310000000000009C310000000000009C310000000000009C3100000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009C9C9C00000000009C9C9C00000000009C9C9C00000000009C9C9C000000
      00000000000000000000000000000000000000000000000000009C006300FF9C
      CE00FF9CCE00CE639C00CE639C009C316300CE639C009C3163009C3163009C31
      63009C3163009C006300000000000000000000000000000000009C9C9C00E7E7
      E700E7E7E700CECECE00CECECE00B5B5B500CECECE00B5B5B500B5B5B500B5B5
      B500B5B5B5009C9C9C0000000000000000000000000000000000000000000000
      000000000000000000009C3100000000000000000000000000009C3100000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009C9C9C000000000000000000000000009C9C9C000000
      0000000000000000000000000000000000000000000000000000000000009C00
      63009C0063009C0063009C0063009C0063009C0063009C0063009C0063009C00
      63009C0063000000000000000000000000000000000000000000000000009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C000000000000000000000000000000000000000000000000000000
      000000000000000000009C3100000000000000000000000000009C3100000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009C9C9C000000000000000000000000009C9C9C000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009C3100000000000000000000000000009C3100000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009C9C9C000000000000000000000000009C9C9C000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000009C3100009C3100009C310000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000009C9C9C009C9C9C009C9C9C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF9C0000CE630000CE63
      0000CE630000CE630000CE630000CE630000CE630000CE630000CE6300000000
      00000000000000000000000000000000000000000000CECECE009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C000000
      000000000000000000000000000000000000FFCE9C00CE9C6300CE9C6300CE9C
      6300CE9C6300CECECE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C00CECECE0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF9C0000CE630000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CE63
      000000000000000000000000000000000000CECECE009C9C9C00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009C9C
      9C0000000000000000000000000000000000FFCE9C00F7EFBD00F7EFBD00CECE
      FF00E7E7E700CE9C6300CE9C6300CECECE000000000000000000000000000000
      0000000000000000000000000000000000009C9C9C00CECECE00CECECE00CECE
      CE00E7E7E7009C9C9C009C9C9C00CECECE000000000000000000000000000000
      000000000000000000000000000000000000FF9C0000CE630000E7E7E700E7E7
      E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700CE63
      000000000000000000000000000000000000CECECE009C9C9C00E7E7E700E7E7
      E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E7009C9C
      9C0000000000000000000000000000000000FFCE9C00FFFFFF00FFFFFF00CECE
      FF00FFFFFF00FFFFFF00E7E7E700CE9C63000000000000000000000000000000
      0000000000000000000000000000000000009C9C9C00FFFFFF00FFFFFF00CECE
      CE00FFFFFF00FFFFFF00E7E7E7009C9C9C000000000000000000000000000000
      000000000000000000000000000000000000FF9C0000CE630000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CE63
      000000000000000000000000000000000000CECECE009C9C9C00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009C9C
      9C0000000000000000000000000000000000FFCE9C00F7EFBD00F7EFBD00CECE
      FF00F7EFBD00F7EFBD00F7EFBD00CE9C6300CECECE0000000000000000000000
      0000000000000000000000000000000000009C9C9C00CECECE00CECECE00CECE
      CE00CECECE00CECECE00CECECE009C9C9C00CECECE0000000000000000000000
      000000000000000000000000000000000000FF9C0000CE630000E7E7E700E7E7
      E700E7E7E700E7E7E700CECECE00CECECE00CECECE00CECECE00CECECE00CE63
      000000000000000000000000000000000000CECECE009C9C9C00E7E7E700E7E7
      E700E7E7E700E7E7E700CECECE00CECECE00CECECE00CECECE00CECECE009C9C
      9C0000000000000000000000000000000000FFCE9C00FFFFFF00CECECE00CECE
      FF00FFFFFF00FFFFFF00FFFFFF00E7E7E700CE9C6300CECECE00000000000000
      0000000000000000000000000000000000009C9C9C00FFFFFF00CECECE00CECE
      CE00FFFFFF00FFFFFF00FFFFFF00E7E7E7009C9C9C00CECECE00000000000000
      000000000000000000000000000000000000FF9C0000CE630000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700CE63
      000000000000000000000000000000000000CECECE009C9C9C00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00E7E7E700E7E7E700E7E7E700E7E7E700E7E7E7009C9C
      9C0000000000000000000000000000000000FFCE9C00F7EFBD00F7EFBD00CECE
      FF00F7EFBD00F7EFBD00F7EFBD00F7EFBD00E7E7E700CE9C6300CE9C6300CE9C
      6300CECECE000000000000000000000000009C9C9C00CECECE00CECECE00CECE
      CE00CECECE00CECECE00CECECE00CECECE00E7E7E7009C9C9C009C9C9C009C9C
      9C00CECECE00000000000000000000000000FF9C0000CE630000E7E7E700E7E7
      E700E7E7E700CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CE63
      000000000000000000000000000000000000CECECE009C9C9C00E7E7E700E7E7
      E700E7E7E700CECECE00CECECE00CECECE00CECECE00CECECE00CECECE009C9C
      9C0000000000000000000000000000000000FFCE9C00FFFFFF00FFFFFF00CECE
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E7E7
      E700CE9C6300CE9C6300CE9C6300CECECE009C9C9C00FFFFFF00FFFFFF00CECE
      CE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E7E7
      E7009C9C9C009C9C9C009C9C9C00CECECE00FF9C0000CE630000FFFFFF00FFFF
      FF00FFFFFF00E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700CE63
      000000000000000000000000000000000000CECECE009C9C9C00FFFFFF00FFFF
      FF00FFFFFF00E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E7009C9C
      9C0000000000000000000000000000000000FFCE9C00F7EFBD00F7EFBD00CECE
      FF00F7EFBD00F7EFBD00F7EFBD00F7EFBD00F7EFBD00F7EFBD00F7EFBD00F7EF
      BD00F7EFBD00F7EFBD00E7E7E700CE9C63009C9C9C00CECECE00CECECE00CECE
      CE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECE
      CE00CECECE00CECECE00E7E7E7009C9C9C00FF9C0000CE630000E7E7E700E7E7
      E700CECECE00CECECE00CE630000CE630000CE630000CE630000CE630000CE63
      0000CE630000CE630000CE630000CE630000CECECE009C9C9C00E7E7E700E7E7
      E700CECECE00CECECE009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C00FFCE9C00FFFFFF00FFFFFF00CECE
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00CE9C63009C9C9C00FFFFFF00FFFFFF00CECE
      CE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF009C9C9C00FF9C0000CE630000FFFFFF00FFFF
      FF00E7E7E700CE630000FF9C0000CE630000CE630000CE630000CE630000CE63
      0000CE630000CE630000CE630000CE630000CECECE009C9C9C00FFFFFF00FFFF
      FF00E7E7E7009C9C9C00CECECE009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C00FFCE9C00F7EFBD00F7EFBD00CECE
      FF00F7EFBD00F7EFBD00F7EFBD00F7EFBD00F7EFBD00F7EFBD00F7EFBD00F7EF
      BD00F7EFBD00F7EFBD00F7EFBD00CE9C63009C9C9C00CECECE00CECECE00CECE
      CE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECE
      CE00CECECE00CECECE00CECECE009C9C9C00FF9C0000CE630000E7E7E700CECE
      CE00FF9C0000FF9C0000FF9C0000FF9C0000FF9C0000CE630000CE630000CE63
      0000CE630000CE630000CE63000000000000CECECE009C9C9C00E7E7E700CECE
      CE00CECECE00CECECE00CECECE00CECECE00CECECE009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C0000000000FFCE9C00FFFFFF00CECECE00CECE
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00CE9C63009C9C9C00FFFFFF00CECECE00CECE
      CE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF009C9C9C00FF9C0000CE630000FFFFFF00FF9C
      0000FF9C6300FF9C6300FF9C0000FF9C0000FF9C0000FF9C0000FF9C0000CE63
      0000CE630000CE6300000000000000000000CECECE009C9C9C00FFFFFF00CECE
      CE00E7E7E700E7E7E700CECECE00CECECE00CECECE00CECECE00CECECE009C9C
      9C009C9C9C009C9C9C000000000000000000FFCE9C00FFFFFF00FFFFFF00CECE
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00CE9C63009C9C9C00FFFFFF00FFFFFF00CECE
      CE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF009C9C9C00FF9C0000CE630000FF9C0000FF9C
      6300FF9C6300FF9C6300FF9C6300FF9C6300FF9C0000FF9C0000FF9C0000FF9C
      0000CE630000000000000000000000000000CECECE009C9C9C00CECECE00E7E7
      E700E7E7E700E7E7E700E7E7E700E7E7E700CECECE00CECECE00CECECE00CECE
      CE009C9C9C00000000000000000000000000FFCE9C00FFFFFF00FFFFFF00CECE
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00CE9C63009C9C9C00FFFFFF00FFFFFF00CECE
      CE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF009C9C9C00FF9C0000FF9C0000FF9C6300FF9C
      6300FF9C6300FF9C6300FF9C6300FF9C6300FF9C6300FF9C6300FF9C0000CE63
      000000000000000000000000000000000000CECECE00CECECE00E7E7E700E7E7
      E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700CECECE009C9C
      9C0000000000000000000000000000000000FFCE9C00FFCE9C00FFCE9C00FFCE
      9C00FFCE9C00FFCE9C00FFCE9C00FFCE9C00FFCE9C00FFCE9C00FFCE9C00FFCE
      9C00FFCE9C00FFCE9C00FFCE9C00FFCE9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C0000000000FF9C00009C9C9C00FFFF
      FF009C9C9C00FFFFFF009C9C9C00FFFFFF009C9C9C00FFFFFF009C9C9C00FFFF
      FF000000000000000000000000000000000000000000CECECE009C9C9C00FFFF
      FF009C9C9C00FFFFFF009C9C9C00FFFFFF009C9C9C00FFFFFF009C9C9C00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009C9C9C00CECE
      CE009C9C9C00CECECE009C9C9C00CECECE009C9C9C00CECECE009C9C9C000000
      00000000000000000000000000000000000000000000000000009C9C9C00CECE
      CE009C9C9C00CECECE009C9C9C00CECECE009C9C9C00CECECE009C9C9C000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000063636300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000063636300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CECECE00636363000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CECECE00636363000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CECECE006363
      63000000000000000000FF9C00009C3100009C3100009C310000000000000000
      0000000000000000000000000000000000000000000000000000CECECE006363
      63000000000000000000CECECE00636363006363630063636300000000000000
      0000000000000000000000000000000000000000000000000000319CCE000063
      9C0000639C0000639C0000639C0000639C0000639C0000639C0000639C000063
      9C0000639C0000639C00000000000000000000000000000000009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C000000000000000000000000000000000000000000CECE
      CE0063636300FF9C0000CE630000CE630000CE630000CE6300009C3100000000
      000000000000000000000000000000000000000000000000000000000000CECE
      CE0063636300CECECE009C9C9C009C9C9C009C9C9C009C9C9C00636363000000
      0000000000000000000000000000000000000000000000000000319CCE009CFF
      FF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFF
      FF009CFFFF0000639C00000000000000000000000000000000009C9C9C00CECE
      CE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECE
      CE00CECECE009C9C9C0000000000000000000000000000000000000000000000
      0000FF9C0000CE630000FF9C0000CE630000CE630000CE6300009C3100000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CECECE009C9C9C00CECECE009C9C9C009C9C9C009C9C9C00636363000000
      0000000000000000000000000000000000000000000000000000319CCE009CFF
      FF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFF
      FF009CFFFF0000639C00000000000000000000000000000000009C9C9C00CECE
      CE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECE
      CE00CECECE009C9C9C000000000000000000000000000000000000000000FF9C
      0000CE630000FF9C0000FF9C0000FF9C0000CE630000CE6300009C3100000000
      000000000000000000000000000000000000000000000000000000000000CECE
      CE009C9C9C00CECECE00CECECE00CECECE009C9C9C009C9C9C00636363000000
      0000000000000000000000000000000000000000000000000000319CCE009CFF
      FF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFF
      FF009CFFFF0000639C00000000000000000000000000000000009C9C9C00CECE
      CE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECE
      CE00CECECE009C9C9C000000000000000000000000000000000000000000CE63
      0000FF9C6300FF9C6300FF9C0000FF9C0000CE630000CE6300009C3100000000
      0000000000000000000000000000000000000000000000000000000000009C9C
      9C00CECECE00CECECE00CECECE00CECECE009C9C9C009C9C9C00636363000000
      0000000000000000000000000000000000000000000000000000319CCE009CFF
      FF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFF
      FF009CFFFF0000639C00000000000000000000000000000000009C9C9C00CECE
      CE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECE
      CE00CECECE009C9C9C000000000000000000000000000000000000000000CE63
      0000FFFFFF00FFFFFF00FF9C6300CE630000FF9C0000CE630000CE6300009C31
      0000000000000000000000000000000000000000000000000000000000009C9C
      9C00FFFFFF00FFFFFF00CECECE009C9C9C00CECECE009C9C9C009C9C9C006363
      6300000000000000000000000000000000000000000000000000319CCE009CFF
      FF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFF
      FF009CFFFF0000639C00000000000000000000000000000000009C9C9C00CECE
      CE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECE
      CE00CECECE009C9C9C000000000000000000000000000000000000000000CE63
      0000FF9C6300FF9C6300CE630000FFFFFF00FF9C6300FF9C0000CE6300009C31
      00009C3100009C3100009C310000000000000000000000000000000000009C9C
      9C00CECECE00CECECE009C9C9C00FFFFFF00CECECE00CECECE009C9C9C006363
      6300636363006363630063636300000000000000000000000000319CCE009CFF
      FF009CFFFF009CFFFF009CFFFF009CCECE009CFFFF009CFFFF009CFFFF009CFF
      FF009CFFFF0000639C00000000000000000000000000000000009C9C9C00CECE
      CE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECE
      CE00CECECE009C9C9C0000000000000000000000000000000000000000000000
      0000CE630000CE630000CE630000CE630000FFFFFF00FF9C63009C310000CE63
      0000CE630000CE630000CE6300009C3100000000000000000000000000000000
      00009C9C9C009C9C9C009C9C9C009C9C9C00FFFFFF00CECECE00636363009C9C
      9C009C9C9C009C9C9C009C9C9C00636363000000000000000000319CCE009CFF
      FF009CFFFF009CFFFF009CFFFF00636363009CCECE009CCECE009CFFFF009CFF
      FF009CFFFF0000639C00000000000000000000000000000000009C9C9C00CECE
      CE00CECECE00CECECE00CECECE0063636300CECECE00CECECE00CECECE00CECE
      CE00CECECE009C9C9C0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CE630000CE630000CE630000FF9C
      0000CE630000CE630000CE6300009C3100000000000000000000000000000000
      0000000000000000000000000000000000009C9C9C009C9C9C009C9C9C00CECE
      CE009C9C9C009C9C9C009C9C9C00636363000000000000000000319CCE009CFF
      FF009CFFFF009CFFFF009CFFFF009CCECE00FF000000FF0000009CCECE009CFF
      FF009CFFFF0000639C00000000000000000000000000000000009C9C9C00CECE
      CE00CECECE00CECECE00CECECE00CECECE006363630063636300CECECE00CECE
      CE00CECECE009C9C9C0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CE630000FF9C6300FF9C
      0000FF9C0000CE630000CE6300009C3100000000000000000000000000000000
      000000000000000000000000000000000000000000009C9C9C00CECECE00CECE
      CE00CECECE009C9C9C009C9C9C00636363000000000000000000319CCE00319C
      CE00319CCE00319CCE00319CCE00FF000000FF000000FFFFFF00FF000000319C
      CE00319CCE00319CCE00000000000000000000000000000000009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C006363630063636300FFFFFF00636363009C9C
      9C009C9C9C009C9C9C0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CE630000FF9C6300FF9C
      6300FF9C0000CE630000CE630000FF9C00000000000000000000000000000000
      000000000000000000000000000000000000000000009C9C9C00CECECE00CECE
      CE00CECECE009C9C9C009C9C9C00CECECE000000000000000000000000000000
      000000000000000000000000000000000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006363630063636300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CE630000FFFFFF00FF9C
      6300CE630000CE630000FF9C0000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009C9C9C00FFFFFF00CECE
      CE009C9C9C009C9C9C00CECECE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CE630000CE63
      0000CE630000FF9C000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009C9C9C009C9C
      9C009C9C9C00CECECE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CE9C6300CE9C
      6300000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009C9C9C009C9C
      9C00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CE9C6300FFFFFF00FFFF
      FF00CE9C63000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009C9C9C00000000000000
      00009C9C9C00000000000000000000000000009CCE0000639C0000639C000063
      9C0000639C0000639C0000639C0000639C0000639C0000639C0000639C000063
      9C0000639C0000639C0000639C0000639C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C000000000000000000000000000000
      00000000000000000000000000000000000000000000CE9C6300FFFFFF00FFFF
      FF00CE9C63000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009C9C9C00000000000000
      00009C9C9C00000000000000000000000000009CCE009CFFFF00009CCE009CFF
      FF00009CCE009CFFFF00009CCE009CFFFF00009CCE009CFFFF00009CCE009CFF
      FF00009CCE009CFFFF00009CCE009CFFFF009C9C9C00CECECE009C9C9C00CECE
      CE009C9C9C00CECECE009C9C9C00CECECE009C9C9C00CECECE009C9C9C00CECE
      CE009C9C9C00CECECE009C9C9C00CECECE000000000000000000000000000000
      0000CE9C6300000000000000000000000000CE9C6300FFFFFF00FFFFFF00CE9C
      6300000000000000000000000000000000000000000000000000000000000000
      00009C9C9C000000000000000000000000009C9C9C0000000000000000009C9C
      9C0000000000000000000000000000000000009CCE009CFFFF00009CCE009CFF
      FF00009CCE009CFFFF00009CCE009CFFFF00009CCE009CFFFF00009CCE009CFF
      FF00009CCE009CFFFF00009CCE009CFFFF009C9C9C00CECECE009C9C9C00CECE
      CE009C9C9C00CECECE009C9C9C00CECECE009C9C9C00CECECE009C9C9C00CECE
      CE009C9C9C00CECECE009C9C9C00CECECE000000000000000000000000000000
      0000CE9C6300CE9C63000000000000000000CE9C6300FFFFFF00FFFFFF00CE9C
      6300000000000000000000000000000000000000000000000000000000000000
      00009C9C9C009C9C9C0000000000000000009C9C9C0000000000000000009C9C
      9C0000000000000000000000000000000000009CCE009CFFFF009CFFFF009CFF
      FF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFF
      FF009CFFFF009CFFFF00009CCE009CFFFF009C9C9C00CECECE00CECECE00CECE
      CE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECE
      CE00CECECE00CECECE009C9C9C00CECECE000000000000000000000000000000
      0000CE9C6300FFFFFF00CE9C6300CE9C6300FFFFFF00FFFFFF00CE9C63000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009C9C9C00000000009C9C9C009C9C9C0000000000000000009C9C9C000000
      000000000000000000000000000000000000009CCE009CFFFF009CFFFF009CFF
      FF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFF
      FF009CFFFF009CFFFF009CFFFF009CFFFF009C9C9C00CECECE00CECECE00CECE
      CE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECE
      CE00CECECE00CECECE00CECECE00CECECE000000000000000000000000000000
      0000CE9C6300FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CE9C63000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009C9C9C0000000000000000000000000000000000000000009C9C9C000000
      000000000000000000000000000000000000009CCE009CFFFF009CFFFF009CFF
      FF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF00009C
      CE00009CCE00009CCE009CFFFF009CFFFF009C9C9C00CECECE00CECECE00CECE
      CE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE009C9C
      9C009C9C9C009C9C9C00CECECE00CECECE000000000000000000000000000000
      0000CE9C6300FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CE9C6300CE9C
      6300CE9C6300CE9C630000000000000000000000000000000000000000000000
      00009C9C9C0000000000000000000000000000000000000000009C9C9C009C9C
      9C009C9C9C009C9C9C000000000000000000009CCE009CFFFF009CFFFF00009C
      CE00009CCE009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFF
      FF00009CCE009CFFFF009CFFFF009CFFFF009C9C9C00CECECE00CECECE009C9C
      9C009C9C9C00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECE
      CE009C9C9C00CECECE00CECECE00CECECE000000000000000000000000000000
      0000CE9C6300FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00CE9C63000000000000000000000000000000000000000000000000000000
      00009C9C9C000000000000000000000000000000000000000000000000000000
      00009C9C9C00000000000000000000000000009CCE009CFFFF009CFFFF00009C
      CE00009CCE009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFF
      FF00009CCE009CFFFF009CFFFF009CFFFF009C9C9C00CECECE00CECECE009C9C
      9C009C9C9C00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECE
      CE009C9C9C00CECECE00CECECE00CECECE000000000000000000000000000000
      0000CE9C6300FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CE9C
      6300000000000000000000000000000000000000000000000000000000000000
      00009C9C9C000000000000000000000000000000000000000000000000009C9C
      9C0000000000000000000000000000000000009CCE009CFFFF009CFFFF009CFF
      FF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF00009C
      CE00009CCE009CFFFF009CFFFF009CFFFF009C9C9C00CECECE00CECECE00CECE
      CE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE009C9C
      9C009C9C9C00CECECE00CECECE00CECECE000000000000000000000000000000
      0000CE9C6300FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CE9C63000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009C9C9C0000000000000000000000000000000000000000009C9C9C000000
      000000000000000000000000000000000000009CCE009CFFFF009CFFFF009CFF
      FF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFF
      FF00009CCE009CFFFF009CFFFF009CFFFF009C9C9C00CECECE00CECECE00CECE
      CE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECE
      CE009C9C9C00CECECE00CECECE00CECECE000000000000000000000000000000
      0000CE9C6300FFFFFF00FFFFFF00FFFFFF00FFFFFF00CE9C6300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009C9C9C00000000000000000000000000000000009C9C9C00000000000000
      000000000000000000000000000000000000009CCE009CFFFF009CFFFF009CFF
      FF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFF
      FF009CFFFF009CFFFF009CFFFF009CFFFF009C9C9C00CECECE00CECECE00CECE
      CE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECE
      CE00CECECE00CECECE00CECECE00CECECE000000000000000000000000000000
      0000CE9C6300FFFFFF00FFFFFF00FFFFFF00CE9C630000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009C9C9C000000000000000000000000009C9C9C0000000000000000000000
      000000000000000000000000000000000000009CCE009CFFFF009CFFFF009CFF
      FF00009CCE009CFFFF009CFFFF009CFFFF00009CCE009CFFFF009CFFFF009CFF
      FF00009CCE009CFFFF009CFFFF009CFFFF009C9C9C00CECECE00CECECE00CECE
      CE009C9C9C00CECECE00CECECE00CECECE009C9C9C00CECECE00CECECE00CECE
      CE009C9C9C00CECECE00CECECE00CECECE000000000000000000000000000000
      0000CE9C6300FFFFFF00FFFFFF00CE9C63000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009C9C9C0000000000000000009C9C9C000000000000000000000000000000
      000000000000000000000000000000000000009CCE009CFFFF00009CCE009CFF
      FF00009CCE009CFFFF00009CCE009CFFFF00009CCE009CFFFF00009CCE009CFF
      FF00009CCE009CFFFF00009CCE009CFFFF009C9C9C00CECECE009C9C9C00CECE
      CE009C9C9C00CECECE009C9C9C00CECECE009C9C9C00CECECE009C9C9C00CECE
      CE009C9C9C00CECECE009C9C9C00CECECE000000000000000000000000000000
      0000CE9C6300FFFFFF00CE9C6300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009C9C9C00000000009C9C9C00000000000000000000000000000000000000
      000000000000000000000000000000000000009CCE00009CCE00009CCE00009C
      CE00009CCE00009CCE00009CCE00009CCE00009CCE00009CCE00009CCE00009C
      CE00009CCE00009CCE00009CCE00009CCE009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C000000000000000000000000000000
      0000CE9C6300CE9C630000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009C9C9C009C9C9C0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009C3100009C310000CE6300009C310000CE6300009C3100000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009C9C9C009C9C9C00CECECE009C9C9C00CECECE009C9C9C000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000063
      9C0000639C0000639C0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009C9C
      9C009C9C9C009C9C9C0000000000000000000000000000000000000000000000
      0000000000009C310000CE6300009C310000CE6300009C3100009C3100000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009C9C9C00CECECE009C9C9C00CECECE009C9C9C009C9C9C000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000639C00319C
      CE00319CCE0063CEFF0000639C00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009C9C9C00CECE
      CE00CECECE00000000009C9C9C00000000000000000000000000000000000000
      0000000000009C3100009C310000CE6300009C310000CE6300009C3100000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009C9C9C009C9C9C00CECECE009C9C9C00CECECE009C9C9C000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000639C00319CCE000063
      9C0000CEFF0063CEFF0000639C00000000000000000000000000000000000000
      000000000000000000000000000000000000000000009C9C9C00CECECE009C9C
      9C0000000000000000009C9C9C00000000000000000000000000000000000000
      0000000000009C9C9C009C3100009C3100009C3100009C3100009C9C9C000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000639C00319CCE0000639C0000CE
      FF00319CCE0063CEFF0000639C00000000000000000000000000000000000000
      0000000000000000000000000000000000009C9C9C00CECECE009C9C9C000000
      0000CECECE00000000009C9C9C00000000000000000000000000000000000000
      000000000000000000009C9C9C00FFFFFF00FFCECE0063636300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009C9C9C00FFFFFF00CECECE009C9C9C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000639C0000639C00319CCE0000639C0000CEFF00319C
      CE0063CEFF0000639C0000000000000000000000000000000000000000000000
      000000000000000000009C9C9C009C9C9C00CECECE009C9C9C0000000000CECE
      CE00000000009C9C9C0000000000000000000000000000000000000000000000
      000000000000000000009C9C9C00FFFFFF00FFCECE0063636300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009C9C9C00FFFFFF00CECECE009C9C9C00000000000000
      000000000000000000000000000000000000000000000000000000639C000063
      9C0000639C0000639C00319CCE00319CCE0000639C0000CEFF00319CCE0063CE
      FF0000639C0000000000000000000000000000000000000000009C9C9C009C9C
      9C009C9C9C009C9C9C00CECECE00CECECE009C9C9C0000000000CECECE000000
      00009C9C9C000000000000000000000000000000000000000000000000000000
      000000000000000000009C9C9C00FFFFFF00FFCECE0063636300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009C9C9C00FFFFFF00CECECE009C9C9C00000000000000
      0000000000000000000000000000000000000000000000639C0000CEFF0000CE
      FF0000CEFF0000CEFF0000639C0000639C0000CEFF00319CCE0063CEFF000063
      9C0000000000000000000000000000000000000000009C9C9C00000000000000
      000000000000000000009C9C9C009C9C9C0000000000CECECE00000000009C9C
      9C00000000000000000000000000000000000000000000000000000000000000
      000000000000000000009C9C9C00FFFFFF00FFCECE0063636300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009C9C9C00FFFFFF00CECECE009C9C9C00000000000000
      00000000000000000000000000000000000000639C0000CEFF0000CEFF00319C
      CE0000CEFF0000CEFF0000CEFF0000CEFF00319CCE0063CEFF0000639C000000
      0000000000000000000000000000000000009C9C9C000000000000000000CECE
      CE0000000000000000000000000000000000CECECE00000000009C9C9C000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009C9C9C00FFFFFF00FFCECE0063636300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009C9C9C00FFFFFF00CECECE009C9C9C00000000000000
      00000000000000000000000000000000000000639C0000CEFF00319CCE0000CE
      FF00319CCE0000CEFF0000CEFF0000CEFF0063CEFF0000639C00000000000000
      0000000000000000000000000000000000009C9C9C0000000000CECECE000000
      0000CECECE00000000000000000000000000000000009C9C9C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000063636300636363006363630063636300000000000000
      0000000000000000000000000000636363000000000000000000000000000000
      000000000000000000009C9C9C009C9C9C009C9C9C009C9C9C00000000000000
      00000000000000000000000000009C9C9C0000639C0000CEFF0000CEFF00319C
      CE0000CEFF00319CCE0000CEFF0000CEFF0063CEFF0000639C00000000000000
      0000000000000000000000000000000000009C9C9C000000000000000000CECE
      CE0000000000CECECE000000000000000000000000009C9C9C00000000000000
      0000000000000000000000000000000000000000000063636300636363000000
      000000000000636363009C9C9C009C9C9C009C9C9C009C9C9C00636363000000
      000000000000000000006363630063636300000000009C9C9C009C9C9C000000
      0000000000009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C000000
      000000000000000000009C9C9C009C9C9C0000639C0000CEFF0000CEFF0000CE
      FF00319CCE0000CEFF00319CCE0000CEFF0063CEFF0000639C00000000000000
      0000000000000000000000000000000000009C9C9C0000000000000000000000
      0000CECECE0000000000CECECE0000000000000000009C9C9C00000000000000
      0000000000000000000000000000000000009C9C9C009C9C9C009C9C9C006363
      6300636363009C9C9C00CECECE00CECECE00CECECE009C9C9C00636363006363
      63006363630063636300CECECE00636363009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C00CECECE00CECECE00CECECE009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C00CECECE009C9C9C0000639C0000CEFF0000639C000063
      9C0000CEFF00319CCE0000CEFF00319CCE0063CEFF0000639C00000000000000
      0000000000000000000000000000000000009C9C9C00000000009C9C9C009C9C
      9C0000000000CECECE0000000000CECECE00000000009C9C9C00000000000000
      0000000000000000000000000000000000009C9C9C00FFFFFF00CECECE00CECE
      CE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE009C9C9C009C9C
      9C009C9C9C00CECECE0063636300000000009C9C9C00FFFFFF00CECECE00CECE
      CE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE009C9C9C009C9C
      9C009C9C9C00CECECE009C9C9C000000000000639C009CFFFF00319CCE000063
      9C0000CEFF0000CEFF00319CCE0000CEFF009CFFFF0000639C00000000000000
      0000000000000000000000000000000000009C9C9C0000000000CECECE009C9C
      9C000000000000000000CECECE0000000000000000009C9C9C00000000000000
      0000000000000000000000000000000000009C9C9C00FFFFFF00CECECE00CECE
      CE00FFFFFF00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECE
      CE00CECECE009C9C9C0000000000000000009C9C9C00FFFFFF00CECECE00CECE
      CE00FFFFFF00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECE
      CE00CECECE009C9C9C0000000000000000000000000000639C009CFFFF0063CE
      FF0063CEFF0063CEFF0063CEFF009CFFFF0000639C0000000000000000000000
      000000000000000000000000000000000000000000009C9C9C00000000000000
      0000000000000000000000000000000000009C9C9C0000000000000000000000
      0000000000000000000000000000000000009C9C9C00FFFFFF00FFFFFF009C9C
      9C009C9C9C00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009C9C
      9C009C9C9C000000000000000000000000009C9C9C00FFFFFF00FFFFFF009C9C
      9C009C9C9C00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009C9C
      9C009C9C9C00000000000000000000000000000000000000000000639C000063
      9C0000639C0000639C0000639C0000639C000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C000000000000000000000000000000
      000000000000000000000000000000000000000000009C9C9C009C9C9C000000
      0000000000009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C000000
      000000000000000000000000000000000000000000009C9C9C009C9C9C000000
      0000000000009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CE9C63009C3100009C3100009C3100009C310000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009C9C9C0063636300636363006363630063636300000000000000
      00000000000000000000000000000000000000000000319CCE00319CCE00319C
      CE0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CE
      FF0063CEFF0063CEFF0063CEFF0063CEFF00000000009C9C9C009C9C9C009C9C
      9C00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECE
      CE00CECECE00CECECE00CECECE00CECECE000000000000000000000000000000
      0000CE9C6300FFFFFF00FFCE9C00FFCE9C00CE9C6300CE9C63009C3100000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009C9C9C00FFFFFF00CECECE00CECECE009C9C9C009C9C9C00636363000000
      00000000000000000000000000000000000063CEFF0063CEFF00319CCE00319C
      CE00319CCE0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CEFF0063CE
      FF0063CEFF0063CEFF0063CEFF0063CEFF00CECECE00CECECE009C9C9C009C9C
      9C009C9C9C00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECE
      CE00CECECE00CECECE00CECECE00CECECE000000000000000000000000000000
      0000CE9C63009C3100009C3100009C3100009C3100009C3100009C3100000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009C9C9C006363630063636300636363006363630063636300636363000000
      00000000000000000000000000000000000063CEFF0063CEFF0063CEFF00009C
      0000008400000084000063CEFF0031639C0031639C0031639C0031639C00319C
      CE0063CEFF0063CEFF0063CEFF0031639C00CECECE00CECECE00CECECE009C9C
      9C009C9C9C009C9C9C00CECECE009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C00CECECE00CECECE00CECECE009C9C9C00000000000000000000000000CE9C
      6300FFFFFF00FFCE9C00FFCE9C00FFCE9C00FFCE9C00FFCE9C00CE9C63009C31
      0000000000000000000000000000000000000000000000000000000000009C9C
      9C00FFFFFF00CECECE00CECECE00CECECE00CECECE00CECECE009C9C9C006363
      63000000000000000000000000000000000063CEFF0063CEFF0063CEFF00009C
      000000FF00000084000063CEFF00319CCE00639CCE00639CCE00319CCE0063CE
      FF0063CEFF0063CEFF0063CEFF0063CEFF00CECECE00CECECE00CECECE009C9C
      9C00CECECE009C9C9C00CECECE009C9C9C00CECECE00CECECE009C9C9C00CECE
      CE00CECECE00CECECE00CECECE00CECECE000000000000000000CE9C6300FFFF
      FF00CE9C6300CE9C6300CE9C6300CE9C6300CE9C6300FFCE9C00CE9C6300CE9C
      63009C31000000000000000000000000000000000000000000009C9C9C00FFFF
      FF009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C00CECECE009C9C9C009C9C
      9C006363630000000000000000000000000063CEFF0063CEFF0063CEFF00009C
      000000FF00000084000063CEFF0063CEFF00319CCE00319CCE0063CEFF0063CE
      FF0031639C0031639C0063CEFF0063CEFF00CECECE00CECECE00CECECE009C9C
      9C00CECECE009C9C9C00CECECE00CECECE009C9C9C009C9C9C00CECECE00CECE
      CE009C9C9C009C9C9C00CECECE00CECECE0000000000CE9C6300FFFFFF00FFCE
      9C00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFCE9C00FFCE9C00CE9C
      63009C310000000000000000000000000000000000009C9C9C00FFFFFF00CECE
      CE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CECECE00CECECE009C9C
      9C006363630000000000000000000000000063CEFF0063CEFF0063CEFF00009C
      000000FF000000FF00000084000063CEFF0063CEFF0063CEFF0063CEFF0063CE
      FF0063CEFF0063CEFF0063CEFF0063CEFF00CECECE00CECECE00CECECE009C9C
      9C00CECECE00CECECE009C9C9C00CECECE00CECECE00CECECE00CECECE00CECE
      CE00CECECE00CECECE00CECECE00CECECE0000000000CE9C6300FFFFFF00FFCE
      9C00CE9C6300CE9C6300CE9C6300CE9C6300CE9C6300FFCE9C00FFCE9C00CE9C
      6300CE9C63009C3100000000000000000000000000009C9C9C00FFFFFF00CECE
      CE009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C00CECECE00CECECE009C9C
      9C009C9C9C0063636300000000000000000063CEFF0063CEFF0063CEFF00009C
      000000FF000031CE310000FF00000084000063CEFF0063CEFF0063CEFF0063CE
      FF0063CEFF0063CEFF0063CEFF0063CEFF00CECECE00CECECE00CECECE009C9C
      9C00CECECE00CECECE00CECECE009C9C9C00CECECE00CECECE00CECECE00CECE
      CE00CECECE00CECECE00CECECE00CECECE0000000000CE9C6300FFFFFF00FFCE
      9C00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFCE9C00FFCE9C00CE9C
      6300CE9C63009C3100000000000000000000000000009C9C9C00FFFFFF00CECE
      CE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CECECE00CECECE009C9C
      9C009C9C9C00636363000000000000000000FFCE9C0063CE63000084000000FF
      000000FF0000009C000000FF000000FF0000009C0000FFCE9C00FFCE9C00FFCE
      9C00FFCE9C00FFCE9C00FFCE9C00FFCE9C0000000000CECECE009C9C9C00CECE
      CE00CECECE009C9C9C00CECECE00CECECE009C9C9C0000000000000000000000
      00000000000000000000000000000000000000000000CE9C6300CE9C6300CE9C
      6300CE9C6300CE9C6300CE9C6300CE9C6300CE9C6300CE9C6300CE9C6300CE9C
      63009C3100009C3100000000000000000000000000009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C0063636300636363000000000000000000FFCE9C00009C000000FF0000009C
      000000FF000000840000009C000000FF0000009C0000FFCE9C00FFCE9C00FFCE
      9C00FFCE9C00FFCE9C00FFCE9C00FFCE9C00000000009C9C9C00CECECE009C9C
      9C00CECECE009C9C9C009C9C9C00CECECE009C9C9C0000000000000000000000
      000000000000000000000000000000000000CE9C6300FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CE9C
      6300CE9C63009C31000000000000000000009C9C9C00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009C9C
      9C009C9C9C00636363000000000000000000FFCE9C00009C000000FF0000009C
      000000FF00000084000063CE6300009C000063CE6300FFCE9C00FFCE9C00FFCE
      9C00FFCE9C00FFCE9C00FFCE9C00FFCE9C00000000009C9C9C00CECECE009C9C
      9C00CECECE009C9C9C00CECECE009C9C9C00CECECE0000000000000000000000
      000000000000000000000000000000000000CE9C6300FFCE9C00FFCE9C009CCE
      CE00009CCE00FFCE9C00FFCE9C00FFCE9C009CCECE00009CCE00FFCE9C00FFFF
      FF00CE9C6300CE9C63009C310000000000009C9C9C00CECECE00CECECE00E7E7
      E7009C9C9C00CECECE00CECECE00CECECE00E7E7E7009C9C9C00CECECE00FFFF
      FF009C9C9C009C9C9C006363630000000000FFCE9C00009C000000FF0000009C
      000000FF000000840000FFCE9C00FFCE9C00FFCE9C00FFCE9C00FFCE9C0000CE
      FF0000CEFF0000CEFF00FFCE9C00FFCE9C00000000009C9C9C00CECECE009C9C
      9C00CECECE009C9C9C0000000000000000000000000000000000000000009C9C
      9C009C9C9C009C9C9C00000000000000000000000000CE9C6300FFCE9C009CCE
      CE0000FFFF00009CCE00CE9C6300FFCE9C009CCECE0000FFFF00009CCE00FFCE
      9C00FFFFFF00CE9C63009C31000000000000000000009C9C9C00CECECE00E7E7
      E700CECECE009C9C9C009C9C9C00CECECE00E7E7E700CECECE009C9C9C00CECE
      CE00FFFFFF009C9C9C006363630000000000FFCE9C0063CE6300009C0000009C
      000000FF000000840000FFCE9C00FFCE9C00FFCE9C00FFCE9C0000CEFF0063FF
      FF0063FFFF0063FFFF0000CEFF00FFCE9C0000000000CECECE009C9C9C009C9C
      9C00CECECE009C9C9C00000000000000000000000000000000009C9C9C00CECE
      CE00CECECE00CECECE009C9C9C00000000000000000000000000CE9C63009CCE
      CE0000FFFF00009CCE00CE9C6300CE9C63009CCECE0000FFFF00009CCE00CE9C
      6300CE9C6300CE9C6300000000000000000000000000000000009C9C9C00E7E7
      E700CECECE009C9C9C009C9C9C009C9C9C00E7E7E700CECECE009C9C9C009C9C
      9C009C9C9C009C9C9C000000000000000000FFCE9C00FFCE9C00FFCE9C00009C
      000000FF000000840000FFCE9C00FFCE9C00FFCE9C00FFCE9C0000CEFF0063FF
      FF0063FFFF0063FFFF0000CEFF00FFCE9C000000000000000000000000009C9C
      9C00CECECE009C9C9C00000000000000000000000000000000009C9C9C00CECE
      CE00CECECE00CECECE009C9C9C00000000000000000000000000000000009CCE
      CE0000FFFF00009CCE0000000000000000009CCECE0000FFFF00009CCE000000
      000000000000000000000000000000000000000000000000000000000000E7E7
      E700CECECE009C9C9C000000000000000000E7E7E700CECECE009C9C9C000000
      000000000000000000000000000000000000FFCE9C00FFCE9C00FFCE9C0063CE
      6300009C000063CE6300FFCE9C00FFCE9C00FFCE9C00FFCE9C0000CEFF0063FF
      FF0063FFFF0063FFFF0000CEFF00FFCE9C00000000000000000000000000CECE
      CE009C9C9C00CECECE00000000000000000000000000000000009C9C9C00CECE
      CE00CECECE00CECECE009C9C9C00000000000000000000000000000000009CCE
      CE0000FFFF00009CCE0000000000000000009CCECE0000FFFF00009CCE000000
      000000000000000000000000000000000000000000000000000000000000E7E7
      E700CECECE009C9C9C000000000000000000E7E7E700CECECE009C9C9C000000
      000000000000000000000000000000000000FFCE9C00FFCE9C00FFCE9C00FFCE
      9C00FFCE9C00FFCE9C00FFCE9C00FFCE9C00FFCE9C00FFCE9C00FFCE9C0000CE
      FF0000CEFF0000CEFF00FFCE9C00FFCE9C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009C9C
      9C009C9C9C009C9C9C0000000000000000000000000000000000000000000000
      00009CCECE00009CCE000000000000000000000000009CCECE00009CCE000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E7E7E7009C9C9C00000000000000000000000000E7E7E7009C9C9C000000
      000000000000000000000000000000000000FFCE9C00FFCE9C00FFCE9C00FFCE
      9C00FFCE9C00FFCE9C00FFCE9C00FFCE9C00FFCE9C00FFCE9C00FFCE9C00FFCE
      9C00FFCE9C00FFCE9C00FFCE9C00FFCE9C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF00FF00FF00FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000063CECE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009C9C9C0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF0000730000000000000000
      00000000000000000000FF00FF00FF00FF00FF00FF0000000000000000000000
      0000000000000000000000000000000800000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000063CECE00009CCE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009C9C9C009C9C9C00000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF0000080000108C
      18000084080000730000FF00FF00FF00FF00FF00FF00FF00FF00005200000021
      000000000000107B180000100000FF00FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000063CECE00009CCE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009C9C9C009C9C9C000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF004263
      6B00A5EFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF0042636B008CCEDE00FF00FF00FF00FF000000000000000000000000000000
      000000FFFF0000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000063CECE009CFFFF00009CCE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009C9C9C00E7E7E7009C9C9C0000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF004263
      6B00A5EFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF0042636B008CCEDE00FF00FF00FF00FF0000000000000000000000000000FF
      FF0000FFFF0000FFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000063CECE00009CCE00009CCE00009CCE0063FFFF00009CCE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009C9C9C009C9C9C009C9C9C009C9C9C00CECECE009C9C9C00000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF004263
      6B00A5EFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF0042636B008CCEDE00FF00FF00FF00FF0000000000000000000000000000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000063CECE009CFFFF0063FFFF0063FFFF0063FFFF0063FFFF00009CCE000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009C9C9C00E7E7E700CECECE00CECECE00CECECE00CECECE009C9C9C000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF004263
      6B00A5EFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF0042636B008CCEDE00FF00FF00FF00FF0000000000000000000000000000FF
      FF0000FFFF00000000000000000000FFFF0000FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000063CECE009CFFFF0063FFFF00009CCE0063CECE0063CECE0063CE
      CE00000000000000000000000000000000000000000000000000000000000000
      0000000000009C9C9C00E7E7E700CECECE009C9C9C009C9C9C009C9C9C009C9C
      9C0000000000000000000000000000000000FF00FF00FF00FF00FF00FF004263
      6B00425A63000018390000183900001021000000000000000000000000000000
      000042636B004A6B7300FF00FF00FF00FF0000000000000000000000000000FF
      FF0000FFFF0000000000000000000000000000FFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000063CECE009CFFFF0063FFFF0063FFFF00009CCE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009C9C9C00E7E7E700CECECE00CECECE009C9C9C00000000000000
      000000000000000000000000000000000000FF00FF0052737B0000000800FFFF
      FF00FFFFFF000042840000428400FFFFFF00FFFFFF0000183900FFFFFF000018
      390000397300FFFFFF0000183900FF00FF0000000000000000000000000000FF
      FF00000000000000000000000000000000000000000000FFFF0000FFFF000000
      000000000000000000000000000000000000000000000000000063CECE00009C
      CE00009CCE00009CCE00009CCE009CFFFF0063FFFF0063FFFF00009CCE000000
      00000000000000000000000000000000000000000000000000009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C00E7E7E700CECECE00CECECE009C9C9C000000
      000000000000000000000000000000000000FF00FF00A5E7FF00001839000029
      5A00FFFFFF0000428400FFFFFF0000428400FFFFFF0000428400FFFFFF000042
      8400FFFFFF00FFFFFF0000183100FF00FF000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF0000FF
      FF0000000000000000000000000000000000000000000000000063CECE009CFF
      FF009CFFFF0063FFFF0063FFFF0063FFFF0063FFFF0063FFFF0063FFFF00009C
      CE000000000000000000000000000000000000000000000000009C9C9C00E7E7
      E700E7E7E700CECECE00CECECE00CECECE00CECECE00CECECE00CECECE009C9C
      9C0000000000000000000000000000000000FF00FF000810100000000000FFFF
      FF0000397B0000295A0000428400FFFFFF00FFFFFF0000428400FFFFFF000042
      840000183900FFFFFF0000102900FF00FF000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF0000FFFF0000000000000000000000000000000000000000000000000063CE
      CE009CFFFF009CFFFF0063FFFF0063FFFF00009CCE0063CECE0063CECE0063CE
      CE00000000000000000000000000000000000000000000000000000000009C9C
      9C00E7E7E700E7E7E700CECECE00CECECE009C9C9C009C9C9C009C9C9C009C9C
      9C0000000000000000000000000000000000FF00FF0073A5AD0000316300FFFF
      FF00FFFFFF000042840000428400004284000042840000428400FFFFFF000042
      8400004284000042840000428400FF00FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF00000000000000000000000000000000000000000063CE
      CE009CFFFF009CFFFF009CFFFF0063FFFF0063FFFF00009CCE00000000000000
      0000000000000000000000000000000000000000000000000000000000009C9C
      9C00E7E7E700E7E7E700E7E7E700CECECE00CECECE009C9C9C00000000000000
      000000000000000000000000000000000000FF00FF001829310000316B000029
      5200000818000008180000214200004284000042840000428400004284000008
      1800000818000008180000428400FF00FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000FFFF00000000000000000000000000000000000000
      000063CECE009CFFFF009CFFFF009CFFFF0063FFFF0063FFFF00009CCE000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009C9C9C00E7E7E700E7E7E700E7E7E700CECECE00CECECE009C9C9C000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF000000
      0000000810000008100000081000000810000008100000081000000810000008
      10000008100000000000FF00FF00FF00FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000063CECE009CFFFF009CFFFF009CFFFF0063FFFF0063FFFF0063FFFF00009C
      CE00000000000000000000000000000000000000000000000000000000000000
      00009C9C9C00E7E7E700E7E7E700E7E7E700CECECE00CECECE00CECECE009C9C
      9C0000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000063CECE009CFFFF009CFFFF009CFFFF0063FFFF0063FFFF0063FF
      FF00009CCE000000000000000000000000000000000000000000000000000000
      0000000000009C9C9C00E7E7E700E7E7E700E7E7E700CECECE00CECECE00CECE
      CE009C9C9C00000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000063CECE0063CECE0063CECE0063CECE0063CECE0063CECE0063CE
      CE0063CECE0063CECE0000000000000000000000000000000000000000000000
      0000000000009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000063636300636363006363630063636300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009C310000CE630000CE630000CE630000CE6300009C3100000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000063636300636363009C9C9C009C9C9C009C9C9C009C9C9C00636363006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000CE630000CE630000CE6300000000000000000000CE630000CE630000CE63
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000009C310000000000FF000000FF633100FF000000FF000000FF000000FF00
      0000000000000000000000000000000000000000000000000000000000006363
      63009C9C9C00636363009C9C9C00CECECE009C9C9C009C9C9C009C9C9C009C9C
      9C006363630000000000000000000000000000000000000000009C310000CE63
      0000CE630000CE630000CE6300000000000000000000CE630000CE630000CE63
      0000CE6300009C31000000000000000000000000000084000000840000008400
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000008400000084000000840000000000000000000000009C3100009C
      3100009C3100009C310000000000FF633100FF633100FF633100FF000000FF00
      00000031000000000000000000000000000000000000000000009C9C9C009C9C
      9C009C9C9C009C9C9C0063636300CECECE00CECECE00CECECE009C9C9C009C9C
      9C00003100006363630000000000000000000000000000000000CE630000CE63
      0000CE630000CE630000CE630000CE630000CE630000CE630000CE630000CE63
      0000CE630000CE63000000000000000000008400000042E7E70042E7E70042E7
      E70042E7E7008400000000000000000000000000000084000000840000008400
      0000000000008400000042E7E7008400000000000000009C3100009C310063FF
      310063FF310031CE3100009C310000000000FF633100FF633100006300000063
      000000630000006300000000000000000000000000009C9C9C009C9C9C00E7E7
      E700E7E7E700CECECE009C9C9C0063636300CECECE00CECECE009C9C9C009C9C
      9C009C9C9C009C9C9C00636363000000000000000000CE630000CE6300000000
      000000000000CE630000CE630000CE630000CE630000CE630000000000000000
      0000CE630000CE630000CE630000000000008400000042E7E70042E7E70042E7
      E70042E7E700840000000000000000000000000000008400000042E7E7008400
      0000000000008400000042E7E7008400000000000000009C310063FF310063FF
      310063FF310031CE3100009C310000000000FF9C000000630000009C3100009C
      310000630000006300000000000000000000000000009C9C9C00E7E7E700E7E7
      E700E7E7E700CECECE009C9C9C0063636300CECECE009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C0063636300000000009C310000CE630000CE6300000000
      000000000000CE630000CE630000CE630000CE630000CE630000000000000000
      0000CE630000CE630000CE6300009C3100008400000042E7E700840000008400
      000042E7E700840000000000000000000000000000008400000042E7E7008400
      0000000000008400000042E7E70084000000009C3100CEFFCE00CEFFCE00CEFF
      CE0031CE31000063000000630000FF9C00000063000031CE3100009C3100009C
      3100006300000063000000630000000000009C9C9C00E7E7E700E7E7E700E7E7
      E700CECECE009C9C9C009C9C9C00CECECE009C9C9C00CECECE009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C0063636300CE630000CE630000CE630000CE63
      0000CE630000CE630000CE6300000000000000000000CE630000CE630000CE63
      0000CE630000CE630000CE630000CE6300008400000042E7E700840000008400
      000042E7E700840000008400000084000000840000008400000042E7E7008400
      0000840000008400000042E7E70084000000009C3100009C3100FFFFFF0031CE
      310000630000FF9C0000FFCE3100FFCE310000630000CEFFCE0031CE3100009C
      3100006300000063000000630000000000009C9C9C009C9C9C00FFFFFF00CECE
      CE009C9C9C00CECECE00E7E7E700E7E7E7009C9C9C00E7E7E700CECECE009C9C
      9C009C9C9C009C9C9C009C9C9C0063636300CE6300000000000000000000CE63
      0000CE630000CE63000000000000000000000000000000000000CE630000CE63
      0000CE6300000000000000000000CE6300008400000042E7E700840000008400
      000042E7E70042E7E70042E7E70042E7E70042E7E70042E7E70042E7E70042E7
      E70042E7E70042E7E70042E7E70084000000FF633100FFFFCE00009C3100009C
      3100FF9C0000FFCE3100FFCE3100FFCE3100FF9C000000630000CEFFCE0031CE
      3100009C3100006300000063000000000000CECECE00FFFFFF009C9C9C009C9C
      9C00CECECE00E7E7E700E7E7E700E7E7E700CECECE009C9C9C00E7E7E700CECE
      CE009C9C9C009C9C9C009C9C9C0063636300CE6300000000000000000000CE63
      0000CE630000CE63000000000000000000000000000000000000CE630000CE63
      0000CE6300000000000000000000CE6300008400000042E7E700840000008400
      000042E7E7008400000084000000840000008400000084000000840000008400
      000084000000840000008400000084000000FF633100FFFFCE00FFFF3100FF9C
      000000633100FF633100FF9C0000FFCE3100FF9C0000FF633100FF6331000063
      000031CE3100009C31000063000000000000CECECE00FFFFFF00E7E7E700CECE
      CE009C9C9C00CECECE00CECECE00E7E7E700CECECE00CECECE00CECECE009C9C
      9C00CECECE009C9C9C009C9C9C0063636300CE630000CE630000CE630000CE63
      0000CE630000CE630000CE6300000000000000000000CE630000CE630000CE63
      0000CE630000CE630000CE630000CE6300008400000042E7E700840000008400
      000042E7E7008400000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF633100006331000063
      310031CE310000633100FF633100FFCE3100FFCE3100FF9C0000FF633100FF63
      31000063000000630000000000000000000000000000CECECE009C9C9C009C9C
      9C00CECECE009C9C9C00CECECE00E7E7E700E7E7E700CECECE00CECECE00CECE
      CE009C9C9C009C9C9C0063636300000000009C310000CE630000CE6300000000
      000000000000CE630000CE630000CE630000CE630000CE630000CE6300000000
      000000000000CE630000CE6300009C3100008400000042E7E70042E7E70042E7
      E70042E7E7008400000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000009C3100FFFFFF00CEFF
      CE0031CE310031CE310000633100FF9C0000FF9C0000FFCE3100FF633100FF63
      3100FF633100FF6331000000000000000000000000009C9C9C00FFFFFF00E7E7
      E700CECECE00CECECE009C9C9C00CECECE00CECECE00E7E7E700CECECE00CECE
      CE00CECECE00CECECE00636363000000000000000000CE630000CE6300000000
      000000000000CE630000CE630000CE630000CE630000CE630000CE6300000000
      000000000000CE630000CE630000000000008400000042E7E70042E7E70042E7
      E70042E7E7008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000009C3100FFFF
      FF00CEFFCE0031CE310031CE31000063310000633100FF9C0000FF633100FF63
      3100FF63310084000000000000000000000000000000000000009C9C9C00FFFF
      FF00E7E7E700CECECE00CECECE009C9C9C009C9C9C00CECECE00CECECE00CECE
      CE00CECECE006363630000000000000000000000000000000000CE630000CE63
      0000CE630000CE630000CE630000CE630000CE630000CE630000CE630000CE63
      0000CE630000CE63000000000000000000000000000084000000840000008400
      0000840000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000009C
      3100FFFFFF00CEFFCE00CEFFCE0031CE3100009C310000633100FF633100FF63
      3100FF6331000000000000000000000000000000000000000000000000009C9C
      9C00FFFFFF00E7E7E700E7E7E700CECECE009C9C9C009C9C9C00CECECE00CECE
      CE00CECECE0000000000000000000000000000000000000000009C310000CE63
      0000CE630000CE630000CE6300000000000000000000CE630000CE630000CE63
      0000CE6300009C31000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000009C3100009C3100FFFFFF0031CE310031CE3100009C3100FF633100FF63
      3100000000000000000000000000000000000000000000000000000000000000
      00009C9C9C009C9C9C00FFFFFF00CECECE00CECECE009C9C9C00CECECE00CECE
      CE00000000000000000000000000000000000000000000000000000000000000
      0000CE630000CE630000CE6300000000000000000000CE630000CE630000CE63
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000009C3100009C3100009C3100009C3100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009C9C9C009C9C9C009C9C9C009C9C9C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009C310000CE630000CE630000CE630000CE6300009C3100000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000009C3100006300000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000009C9C9C009C9C9C0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000E7E7
      E700C6C6C600636363004A4A4A004A4A4A004A4A4A004A4A4A004A4A4A008484
      8400CECECE00E7EFF7000000000000000000000000000000000000000000CECE
      CE009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C00CECECE00E7EFF70000000000000000000000000000000000000000000000
      0000000000009C3100009C310000CE6300009C31000063000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009C9C9C009C9C9C00CECECE009C9C9C009C9C9C00000000000000
      0000000000000000000000000000000000000000000000000000E7E7E700B5B5
      B500EFC6DE00E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700C6C6C6004A4A
      4A00636B7300B5B5B500E7E7E700000000000000000000000000CECECE009C9C
      9C00EFC6DE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE009C9C
      9C009C9C9C00B5B5B500CECECE00000000000000000000000000000000009C31
      00009C3100009C310000E7E7E700E7E7E700CECECE009C310000630000000000
      0000000000000000000000000000000000000000000000000000000000009C9C
      9C009C9C9C009C9C9C00E7E7E700E7E7E700CECECE009C9C9C009C9C9C000000
      00000000000000000000000000000000000000000000E7E7E700C6C6C600E7E7
      E700FFFFFF00E7E7E700CE9C9C00CE9C9C00CECECE00E7EFF700FFFFFF00E7E7
      E7008484840063636300B5B5B500E7EFF70000000000CECECE009C9C9C00CECE
      CE00FFFFFF00CECECE00CECECE00CECECE00CECECE00E7EFF700FFFFFF00CECE
      CE009C9C9C009C9C9C00B5B5B500E7EFF700000000009C3100009C3100009C31
      0000E7E7E700E7E7E700E7E7E700E7E7E700CECECE00CECECE009C3100006300
      000000000000000000000000000000000000000000009C9C9C009C9C9C009C9C
      9C00E7E7E700E7E7E700E7E7E700E7E7E700CECECE00CECECE009C9C9C009C9C
      9C000000000000000000000000000000000000000000CECECE00E7E7E700FFFF
      FF00CE9C9C00CE630000CE633100CE9C9C00CE633100CE633100CE9C9C00FFFF
      FF00E7E7E700636B7300636B7300CECECE00000000009C9C9C00CECECE00FFFF
      FF00CECECE009C9C9C009C9C9C00CECECE009C9C9C009C9C9C00CECECE00FFFF
      FF00CECECE009C9C9C009C9C9C00CECECE009C3100009C310000E7E7E700E7E7
      E700E7E7E700E7E7E7009C3100009C3100009C9C9C009C9C9C00CECECE009C31
      0000630000000000000000000000000000009C9C9C009C9C9C00E7E7E700E7E7
      E700E7E7E700E7E7E7009C9C9C009C9C9C009C9C9C009C9C9C00CECECE009C9C
      9C009C9C9C00000000000000000000000000E7E7E700E7E7E700FFFFFF00CE63
      6300CE310000CE630000CE9C9C00FFFFFF00CE9C6300CE310000CE310000CE9C
      9C00FFFFFF00E7E7E7004A4A4A009C9C9C00CECECE009C9C9C00FFFFFF00CECE
      CE009C9C9C009C9C9C00CECECE00FFFFFF009C9C9C009C9C9C009C9C9C00CECE
      CE00FFFFFF00CECECE009C9C9C009C9C9C009C310000E7E7E700E7E7E700E7E7
      E7009C3100009C3100009C3100009C31000063000000848484009C9C9C009C9C
      9C009C3100006300000000000000000000009C9C9C00E7E7E700E7E7E700E7E7
      E7009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C00848484009C9C9C009C9C
      9C009C9C9C009C9C9C000000000000000000E7E7E700FFFFFF00CE9C9C00CE31
      0000CE633100CE633100CE633100CE9C6300CE633100CE633100CE633100CE31
      0000CECECE00E7E7E7009C9C9C00636363009C9C9C00FFFFFF00CECECE009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C00CECECE00CECECE009C9C9C009C9C9C009C310000E7E7E7009C3100009C31
      00009C310000CE630000CE630000CE6300009C31000063000000636363009C9C
      9C009C9C9C009C31000063000000000000009C9C9C00E7E7E7009C9C9C009C9C
      9C009C9C9C00CECECE00CECECE00CECECE009C9C9C009C9C9C00636363009C9C
      9C009C9C9C009C9C9C009C9C9C0000000000E7E7E700FFFFFF00CE633100CE63
      3100CE633100CE633100CE9C6300E7E7E700CE633100CE633100CE633100CE63
      3100CE636300FFFFFF00CECECE004A4A4A009C9C9C00FFFFFF009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C00CECECE009C9C9C009C9C9C009C9C9C009C9C
      9C00CECECE00FFFFFF00CECECE009C9C9C009C3100009C3100009C310000CE63
      0000CE6300009C3100009C310000CE630000CE6300009C310000630000006363
      63009C9C9C00848484009C310000630000009C9C9C009C9C9C009C9C9C00CECE
      CE00CECECE009C9C9C009C9C9C00CECECE00CECECE009C9C9C009C9C9C006363
      63009C9C9C00848484009C9C9C009C9C9C00E7E7E700E7E7E700CE633100CE63
      3100CE633100CE633100CE9C6300FFFFFF00FF9C9C00CE310000CE633100CE63
      3100CE633100E7EFF700E7E7E7004A4A4A009C9C9C00CECECE009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C00FFFFFF00CECECE009C9C9C009C9C9C009C9C
      9C009C9C9C00E7EFF700CECECE009C9C9C009C310000FF9C0000CE630000CE63
      0000CE63000000FFFF0031CEFF009C3100009C3100009C3100009C3100006300
      0000636363009C9C9C009C310000630000009C9C9C00E7E7E700CECECE00CECE
      CE00CECECE00E7E7E700E7E7E7009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C00636363009C9C9C009C9C9C009C9C9C00E7E7E700FFCECE00CE633100CE63
      3100CE633100CE633100CE633100CECE9C00FFFFFF00CE9C6300CE633100CE63
      3100CE633100E7EFF700E7E7E7004A4A4A009C9C9C00FFCECE009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C00CECECE00FFFFFF009C9C9C009C9C9C009C9C
      9C009C9C9C00E7EFF700CECECE009C9C9C00000000009C310000FF9C0000CE63
      0000CE630000CE630000CE63000000FFFF0000FFFF0031CEFF0031639C009C31
      000063000000636363009C31000000000000000000009C9C9C00E7E7E700CECE
      CE00CECECE00CECECE00CECECE00E7E7E700E7E7E700E7E7E7009C9C9C009C9C
      9C009C9C9C00636363009C9C9C0000000000E7E7E700E7E7E700CE633100CE63
      3100CE633100CE633100CE633100CE310000CECECE00FFFFFF00CE633100CE63
      3100CE633100FFFFFF00E7E7E700636363009C9C9C00CECECE009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C00CECECE00FFFFFF009C9C9C009C9C
      9C009C9C9C00FFFFFF00CECECE009C9C9C0000000000000000009C310000FF9C
      0000CE630000CE630000CE630000CE630000CE63000031CEFF0000FFFF003163
      9C009C310000630000009C3100000000000000000000000000009C9C9C00E7E7
      E700CECECE00CECECE00CECECE00CECECE00CECECE00E7E7E700E7E7E7009C9C
      9C009C9C9C009C9C9C009C9C9C0000000000E7E7E700FFFFFF00FF9C6300CE63
      3100CE9C6300E7E7E700CE636300CE310000CE9C6300FFFFFF00CE9C6300CE63
      0000CE9C6300FFFFFF00CECECE009CADAD009C9C9C00FFFFFF009C9C9C009C9C
      9C009C9C9C00CECECE00CECECE009C9C9C009C9C9C00FFFFFF009C9C9C009C9C
      9C009C9C9C00FFFFFF00CECECE009CADAD000000000000000000000000009C31
      0000FF9C0000CE630000CE63000000FFFF0000FFFF0000FFFF00319CCE003163
      9C009C3100009C31000063000000630000000000000000000000000000009C9C
      9C00E7E7E700CECECE00CECECE00E7E7E700E7E7E700E7E7E7009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C00E7E7E700E7EFF700FFFFCE00FF9C
      3100CE9C6300FFFFFF00FFFFFF00FFCE9C00FFFFFF00FFFFFF00CE633100FF63
      3100FFFFFF00E7E7E7009C9C9C00E7E7E7009C9C9C00E7EFF700CECECE009C9C
      9C009C9C9C00FFFFFF00FFFFFF00CECECE00FFFFFF00FFFFFF009C9C9C009C9C
      9C00FFFFFF00CECECE009C9C9C00CECECE000000000000000000000000000000
      00009C310000FF9C0000CE630000CE63000031639C0031639C00630063009C31
      00009C3100009C31000063000000000000000000000000000000000000000000
      00009C9C9C00E7E7E700CECECE00CECECE009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C000000000000000000E7E7E700FFFFFF00F7EF
      BD00FF9C6300FF9C9C00E7E7E700E7EFF700E7E7E700FF9C6300FF9C6300FFCE
      CE00FFFFFF00F7EFBD00C6C6C60000000000000000009C9C9C00FFFFFF00CECE
      CE009C9C9C00CECECE00CECECE00E7EFF700CECECE009C9C9C009C9C9C00FFCE
      CE00FFFFFF00CECECE009C9C9C00000000000000000000000000000000000000
      0000000000009C310000FF9C0000CE630000CE630000CE6300009C3100009C31
      0000630000000000000000000000000000000000000000000000000000000000
      0000000000009C9C9C00E7E7E700CECECE00CECECE00CECECE009C9C9C009C9C
      9C009C9C9C0000000000000000000000000000000000E7E7E700E7E7E700FFFF
      FF00FFFFFF00FFFFCE00FFCE9C00FFCE9C00FFCE9C00FFCE9C00FFFFFF00FFFF
      FF00E7E7E700C6C6C600E7EFF7000000000000000000000000009C9C9C00FFFF
      FF00FFFFFF00CECECE00CECECE00CECECE00CECECE00CECECE00FFFFFF00FFFF
      FF00CECECE009C9C9C00E7EFF700000000000000000000000000000000000000
      000000000000000000009C310000FF9C0000CE6300009C310000630000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009C9C9C00E7E7E700CECECE009C9C9C009C9C9C000000
      0000000000000000000000000000000000000000000000000000E7E7E700FFCE
      CE00E7E7E700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E7E7E700FFCE
      CE00CECECE00E7EFF70000000000000000000000000000000000000000009C9C
      9C009C9C9C00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009C9C9C009C9C
      9C009C9C9C00E7EFF70000000000000000000000000000000000000000000000
      00000000000000000000000000009C3100006300000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000009C9C9C009C9C9C0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E7E7E700FFCECE00FFCECE00FFCECE00F7EFBD00FFCECE00E7E7E700E7E7
      E700000000000000000000000000000000000000000000000000000000000000
      0000CECECE009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C00CECECE00CECE
      CE00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C0000000000000000000000000000000000000000009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C00000000009C9C9C0063636300636363006363
      6300636363006363630063636300636363006363630063636300636363006363
      6300636363006363630063636300636363009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C000000000084848400313131003131
      3100000000000000000000000000000000000000000000000000000000008484
      8400313131003131310000000000000000009C9C9C00CECECE00B5B5B500B5B5
      B5009C9C9C0000000000000000000000000000000000000000009C9C9C00CECE
      CE00B5B5B500B5B5B5009C9C9C00000000009C9C9C00CEFFFF00CEFFFF00CEFF
      FF00CEFFFF00CEFFFF00CEFFFF00CEFFFF00CEFFFF00CEFFFF00CEFFFF00CEFF
      FF00CEFFFF00CEFFFF00CEFFFF00636363009C9C9C0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000009C9C9C000000000084848400313131003131
      3100000000000000000000000000000000000000000000000000000000008484
      8400313131003131310000000000000000009C9C9C00CECECE00B5B5B500B5B5
      B5009C9C9C0000000000000000000000000000000000000000009C9C9C00CECE
      CE00B5B5B500B5B5B5009C9C9C00000000009C9C9C00CEFFFF00CEFFFF00CEFF
      FF00CEFFFF00CEFFFF00CEFFFF00CEFFFF00CEFFFF00CEFFFF00CEFFFF00CEFF
      FF00CEFFFF00CEFFFF00CEFFFF00636363009C9C9C0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000009C9C9C000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C00FFFFFF009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C00000000009C9C9C00FFFFFF00CEFFFF00CEFF
      FF009C3100009C3100009C3100009C3100009C3100009C310000CEFFFF00CEFF
      FF00CEFFFF00CEFFFF00CEFFFF00636363009C9C9C00FFFFFF00000000000000
      00009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C00000000000000
      00000000000000000000000000009C9C9C000000000084848400313131003131
      3100000000003131310000000000313131000000000084848400000000003131
      3100313131003131310000000000000000009C9C9C00CECECE00B5B5B500B5B5
      B5009C9C9C00B5B5B5009C9C9C00B5B5B5009C9C9C00CECECE009C9C9C00B5B5
      B500B5B5B500B5B5B5009C9C9C00000000009C9C9C00CEFFFF00FFFFFF00CEFF
      FF00CEFFFF00CEFFFF00CEFFFF00CEFFFF00CEFFFF00CEFFFF00CEFFFF00CEFF
      FF00CEFFFF00CEFFFF00CEFFFF00636363009C9C9C0000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000009C9C9C000000000084848400313131003131
      3100000000003131310000000000000000000000000084848400000000003131
      3100313131003131310000000000000000009C9C9C00CECECE00B5B5B500B5B5
      B5009C9C9C00B5B5B5009C9C9C00000000009C9C9C00CECECE009C9C9C00B5B5
      B500B5B5B500B5B5B5009C9C9C00000000009C9C9C00FFFFFF00FFFFFF00CEFF
      FF009C3100009C3100009C3100009C3100009C3100009C310000CEFFFF00CEFF
      FF00CEFFFF00CEFFFF00CEFFFF00636363009C9C9C00FFFFFF00FFFFFF000000
      00009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C00000000000000
      00000000000000000000000000009C9C9C000000000084848400313131003131
      3100000000003131310000000000000000000000000084848400000000003131
      3100313131003131310000000000000000009C9C9C00CECECE00B5B5B500B5B5
      B5009C9C9C00B5B5B5009C9C9C00000000009C9C9C00CECECE009C9C9C00B5B5
      B500B5B5B500B5B5B5009C9C9C00000000009C9C9C00FFFFFF00CEFFFF00FFFF
      FF00CEFFFF00CEFFFF00CEFFFF00CEFFFF00CEFFFF00CEFFFF00CEFFFF00CEFF
      FF00CEFFFF00CEFFFF00CEFFFF00636363009C9C9C00FFFFFF0000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000009C9C9C000000000000000000000000000000
      0000000000000000000000000000313131000000000000000000000000000000
      000000000000000000000000000000000000000000009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C00B5B5B5009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C0000000000000000009C9C9C00FFFFFF00FFFFFF00CEFF
      FF00FFFFFF00CEFFFF00CEFFFF00CEFFFF00CEFFFF00CEFFFF00CEFFFF00CEFF
      FF000000CE0000009C00CEFFFF00636363009C9C9C00FFFFFF00FFFFFF000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      00009C9C9C009C9C9C00000000009C9C9C000000000000000000000000008484
      8400313131003131310000000000FFFFFF000000000084848400000000003131
      31000000000000000000000000000000000000000000000000009C9C9C00CECE
      CE00B5B5B500B5B5B5009C9C9C00FFFFFF009C9C9C00CECECE009C9C9C00B5B5
      B5009C9C9C000000000000000000000000009C9C9C00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CEFFFF00CEFFFF00CEFFFF00CEFFFF00CEFFFF00CEFFFF00CEFF
      FF006300FF000000CE00CEFFFF00636363009C9C9C00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      00009C9C9C009C9C9C00000000009C9C9C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C00000000009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C000000000000000000000000009C9C9C00FFFFFF00FFFFFF00FFFF
      FF00CEFFFF00FFFFFF00CEFFFF00CEFFFF00CEFFFF00CEFFFF00CEFFFF00CEFF
      FF00CEFFFF00CEFFFF00CEFFFF00636363009C9C9C00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF0000000000000000000000000000000000000000000000
      00000000000000000000000000009C9C9C000000000000000000000000000000
      0000313131000000000000000000000000000000000000000000313131000000
      0000000000000000000000000000000000000000000000000000000000009C9C
      9C00B5B5B5009C9C9C000000000000000000000000009C9C9C00B5B5B5009C9C
      9C00000000000000000000000000000000009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C000000000000000000000000008484
      8400FFFFFF000000000000000000000000000000000084848400FFFFFF000000
      000000000000000000000000000000000000000000000000000000000000CECE
      CE00FFFFFF009C9C9C00000000000000000000000000CECECE00FFFFFF009C9C
      9C00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000003131
      3100313131003131310000000000000000000000000031313100313131003131
      310000000000000000000000000000000000000000000000000000000000B5B5
      B500B5B5B500B5B5B500000000000000000000000000B5B5B500B5B5B500B5B5
      B500000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008400000084000000840000008400000084000000840000008400000084
      0000000000000000000000000000000000000000000000000000000000000000
      0000840084008400840084008400840084008400840084008400840084008400
      8400000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000084000000840000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000004284000042840000428400004284000042840000428400004284000042
      8400000000000000000000000000000000000000000000000000008400000084
      0000219C3100C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C600219C
      3100008400000084000000000000000000000000000000000000840084008400
      8400FF21FF00FF9CFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF9CFF00FF21
      FF00840084008400840000000000000000000000000000000000000084000000
      84000000FF007373FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007373FF000000
      FF00000084000000840000000000000000000000000000000000004284000042
      8400007BF70084BDFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0084BDFF00007B
      F70000428400004284000000000000000000000000000000000000840000219C
      3100219C3100C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C600219C
      3100219C3100008400000000000000000000000000000000000084008400C600
      C600FF21FF00FF9CFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF9CFF00FF21
      FF00C600C6008400840000000000000000000000000000000000000084000000
      CE000000FF007373FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007373FF000000
      FF000000CE00000084000000000000000000000000000000000000428400006B
      D600007BF70084BDFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0084BDFF00007B
      F700006BD600004284000000000000000000000000000000000000840000219C
      3100008400000084000000840000008400000084000000840000008400000084
      0000219C3100008400000000000000000000000000000000000084008400C600
      C600840084008400840084008400840084008400840084008400840084008400
      8400C600C6008400840000000000000000000000000000000000000084000000
      CE00000084000000840000008400000084000000840000008400000084000000
      84000000CE00000084000000000000000000000000000000000000428400006B
      D600004284000042840000428400004284000042840000428400004284000042
      8400006BD6000042840000000000000000000000000000000000008400000084
      0000219C3100C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C600219C
      3100008400000084000000000000000000000000000000000000840084008400
      8400FF21FF00FF9CFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF9CFF00FF21
      FF00840084008400840000000000000000000000000000000000000084000000
      84000000FF007373FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007373FF000000
      FF00000084000000840000000000000000000000000000000000004284000042
      8400007BF70084BDFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0084BDFF00007B
      F70000428400004284000000000000000000000000000000000000840000219C
      3100219C3100C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C600219C
      3100219C3100008400000000000000000000000000000000000084008400C600
      C600FF21FF00FF9CFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF9CFF00FF21
      FF00C600C6008400840000000000000000000000000000000000000084000000
      CE000000FF007373FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007373FF000000
      FF000000CE00000084000000000000000000000000000000000000428400006B
      D600007BF70084BDFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0084BDFF00007B
      F700006BD600004284000000000000000000000000000000000000840000219C
      3100008400000084000000840000008400000084000000840000008400000084
      0000219C3100008400000000000000000000000000000000000084008400C600
      C600840084008400840084008400840084008400840084008400840084008400
      8400C600C6008400840000000000000000000000000000000000000084000000
      CE00000084000000840000008400000084000000840000008400000084000000
      84000000CE00000084000000000000000000000000000000000000428400006B
      D600004284000042840000428400004284000042840000428400004284000042
      8400006BD6000042840000000000000000000000000000000000008400000084
      0000219C3100C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C600219C
      3100008400000084000000000000000000000000000000000000840084008400
      8400FF21FF00FF9CFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF9CFF00FF21
      FF00840084008400840000000000000000000000000000000000000084000000
      84000000FF007373FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007373FF000000
      FF00000084000000840000000000000000000000000000000000004284000042
      8400007BF70084BDFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0084BDFF00007B
      F70000428400004284000000000000000000000000000000000000840000219C
      3100219C3100C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C600219C
      3100219C3100008400000000000000000000000000000000000084008400C600
      C600FF21FF00FF9CFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF9CFF00FF21
      FF00C600C6008400840000000000000000000000000000000000000084000000
      CE000000FF007373FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007373FF000000
      FF000000CE00000084000000000000000000000000000000000000428400006B
      D600007BF70084BDFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0084BDFF00007B
      F700006BD600004284000000000000000000000000000000000000840000219C
      3100008400000084000000840000008400000084000000840000008400000084
      0000219C3100008400000000000000000000000000000000000084008400C600
      C600840084008400840084008400840084008400840084008400840084008400
      8400C600C6008400840000000000000000000000000000000000000084000000
      CE00000084000000840000008400000084000000840000008400000084000000
      84000000CE00000084000000000000000000000000000000000000428400006B
      D600004284000042840000428400004284000042840000428400004284000042
      8400006BD6000042840000000000000000000000000000000000008400000084
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00008400000084000000000000000000000000000000000000840084008400
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00840084008400840000000000000000000000000000000000000084000000
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000084000000840000000000000000000000000000000000004284000042
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000428400004284000000000000000000000000000000000000840000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00008400000000000000000000000000000000000084008400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00840084000000000000000000000000000000000000008400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000084000000000000000000000000000000000000428400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000042840000000000000000000000000000000000000000000084
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00008400000000000000000000000000000000000000000000000000008400
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00840084000000000000000000000000000000000000000000000000000000
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000084000000000000000000000000000000000000000000000000000042
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00004284000000000000000000000000000000000000000000000000000000
      0000008400000084000000840000008400000084000000840000008400000084
      0000000000000000000000000000000000000000000000000000000000000000
      0000840084008400840084008400840084008400840084008400840084008400
      8400000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000084000000840000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000004284000042840000428400004284000042840000428400004284000042
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000063636300636363009C9C9C000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF000000FF000000FF000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000C6000000C6000000C6000000C6000000C6000000C6
      0000000000000000000000000000000000000000000000000000000000000000
      0000844200008442000084420000844200008442000084420000844200008442
      0000000000000000000000000000000000009C9C9C0084848400636363006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF000000FF000000FF000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000C6000000C6000000C6000000C6000000C6000000C6
      0000000000000000000000000000000000000000000000000000844200008442
      0000FF8C1000FFBD7300FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFBD7300FF8C
      1000844200008442000000000000000000000000000084848400848484008484
      8400636363009C9C9C0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000C6000000C6000000C6000000C6000000C6000000C6000000C6
      000000000000000000000000000000000000000000000000000084420000BD5A
      0000FF8C1000FFBD7300FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFBD7300FF8C
      1000BD5A0000844200000000000000000000000000009C9C9C00848484008484
      840084848400636363009C9C9C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      000000C6000000C6000000C6000000C6000000C6000000C6000000C6000000C6
      000000C60000000000000000000000000000000000000000000084420000BD5A
      0000844200008442000084420000844200008442000084420000844200008442
      0000BD5A00008442000000000000000000000000000000000000848484008484
      8400E7E7E700CECECE00CECECE009C9C9C000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF00000000000000000000000000000000000000000000000000000000C6
      000000C6000000C6000000C6000000C6000000C6000000C6000000C6000000C6
      000000C600000000000000000000000000000000000000000000844200008442
      0000FF8C1000FFBD7300FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFBD7300FF8C
      10008442000084420000000000000000000000000000000000009C9C9C008484
      8400E7E7E700E7E7E700CECECE00CECECE009C9C9C00CECECE00000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000000000000000000000000000000000000000000000C6
      000000C6000000C6000000C6000000C6000000C6000000C6000000C6000000C6
      000000C6000000C600000000000000000000000000000000000084420000BD5A
      0000FF8C1000FFBD7300FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFBD7300FF8C
      1000BD5A0000844200000000000000000000000000000000000000000000CECE
      CE00FFFFFF00E7E7E700E7E7E700E7E7E700CECECE00CECECE009C9C9C000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF0000000000000000000000000000000000000000C6000000C6
      000000C6000000C6000000C6000000C6000000C6000000C6000000C6000000C6
      000000C6000000C600000000000000000000000000000000000084420000BD5A
      0000844200008442000084420000844200008442000084420000844200008442
      0000BD5A0000844200000000000000000000000000000000000000000000CECE
      CE00FFFFFF00E7E7E700E7E7E700E7E7E700E7E7E700CECECE00CECECE009C9C
      9C00CECECE0000000000000000000000000000000000FF000000FF000000FF00
      000000000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF00000000000000000000000000000000C6000000C6000000C6
      00000000000000C6000000C6000000C6000000C6000000C6000000C6000000C6
      000000C6000000C6000000000000000000000000000000000000844200008442
      0000FF8C1000FFBD7300FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFBD7300FF8C
      1000844200008442000000000000000000000000000000000000000000000000
      0000CECECE00FFFFFF00E7E7E700E7E7E700E7E7E700E7E7E700CECECE00CECE
      CE006363630063636300000000000000000000000000FF000000FF0000000000
      000000000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000000000000000000000C6000000C600000000
      00000000000000C6000000C6000000C6000000C6000000C6000000C6000000C6
      000000C6000000C6000000C6000000000000000000000000000084420000BD5A
      0000FF8C1000FFBD7300FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFBD7300FF8C
      1000BD5A00008442000000000000000000000000000000000000000000000000
      0000CECECE00FFFFFF00E7E7E700E7E7E700CECECE0084848400848484006363
      6300636363006363630063636300000000000000000000000000000000000000
      000000000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      000000000000FF000000FF000000000000000000000000000000000000000000
      00000000000000C6000000C6000000C6000000C6000000C6000000C6000000C6
      00000000000000C6000000C6000000000000000000000000000084420000BD5A
      0000844200008442000084420000844200008442000084420000844200008442
      0000BD5A00008442000000000000000000000000000000000000000000000000
      000000000000CECECE00FFFFFF00E7E7E7008484840084848400848484008484
      8400636363006363630063636300636363000000000000000000000000000000
      0000FF000000FF00000000000000FF000000FF00000000000000FF000000FF00
      000000000000FF000000FF000000000000000000000000000000000000000000
      000000C6000000C600000000000000C6000000C600000000000000C6000000C6
      00000000000000C6000000C60000000000000000000000000000844200008442
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00844200008442000000000000000000000000000000000000000000000000
      000000000000CECECE00FFFFFF00CECECE008484840084848400848484008484
      8400848484006363630063636300636363000000000000000000000000000000
      0000FF000000FF00000000000000FF000000FF00000000000000FF000000FF00
      000000000000FF000000FF000000000000000000000000000000000000000000
      000000C6000000C600000000000000C6000000C600000000000000C6000000C6
      00000000000000C6000000C6000000000000000000000000000084420000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF008442000000000000000000000000000000000000000000000000
      000000000000000000009C9C9C009C9C9C008484840084848400848484008484
      840084848400848484006363630063636300000000000000000000000000FF00
      0000FF0000000000000000000000FF000000FF00000000000000FF000000FF00
      00000000000000000000000000000000000000000000000000000000000000C6
      000000C60000000000000000000000C6000000C600000000000000C6000000C6
      0000000000000000000000000000000000000000000000000000000000008442
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00844200000000000000000000000000000000000000000000000000000000
      00000000000000000000636363009C9C9C009C9C9C0084848400848484008484
      840084848400848484008484840063636300000000000000000000000000FF00
      0000FF0000000000000000000000FF000000FF00000000000000FF000000FF00
      00000000000000000000000000000000000000000000000000000000000000C6
      000000C60000000000000000000000C6000000C600000000000000C6000000C6
      0000000000000000000000000000000000000000000000000000000000000000
      0000844200008442000084420000844200008442000084420000844200008442
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000636363009C9C9C009C9C9C00848484008484
      8400848484008484840084848400848484000000000000000000000000000000
      0000000000000000000000000000FF000000FF00000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000C6000000C6000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF00000031313100313131009C9C9C000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000CECECE0063636300313131003131
      3100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF0000000000
      0000000000000000000000000000000000000000000063636300636363006363
      6300313131009C9C9C0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CECECE00636363006363
      63006363630031313100009C9C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000636363006363
      63009CFFFF009CCECE009CCECE00009C9C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF0000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000CECECE008484
      8400CEFFFF009CFFFF009CCECE009CCECE00009C9C009CCECE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF000000000000000000000000000000000000000000000000000000000063CE
      CE00FFFFFF00CEFFFF009CFFFF009CFFFF009CCECE0063CECE00009C9C000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000063CE
      CE00FFFFFF00CEFFFF00CEFFFF009CFFFF009CFFFF009CCECE009CCECE00009C
      9C0063CECE0000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009CCECE00FFFFFF00CEFFFF00CEFFFF009CFFFF009CFFFF009CCECE00FFCE
      CE009C3100009C31000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF0000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000063CECE00FFFFFF00CEFFFF00CEFFFF00FFCECE00CE630000CE6300009C31
      00009C3100009C3100009C310000000000000000000000000000000000000000
      00000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009CCECE00FFFFFF00CEFFFF00CE630000CE630000CE630000CE63
      00009C3100009C3100009C3100009C3100000000000000000000000000000000
      0000000000000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000063CECE00FFFFFF00FFCECE00CE630000CE630000CE630000CE63
      0000CE6300009C3100009C3100009C3100000000000000000000000000000000
      000000000000000000000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF9C0000FF9C0000CE630000CE630000CE630000CE63
      0000CE630000CE6300009C3100009C3100000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000CE630000FF9C0000FF9C0000CE630000CE630000CE63
      0000CE630000CE630000CE6300009C3100000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000CE630000FF9C0000FF9C0000CE630000CE63
      0000CE630000CE630000CE630000CE6300000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CE9C6300CE9C
      6300000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009C9C9C009C9C
      9C00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084C6000084C6000084C6000084C6000084C60000426300000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CE9C6300FF000000FF00
      0000CE9C63000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009C9C9C00DEEFEF00DEEF
      EF009C9C9C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084C6000084C6000084C6000042630000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CE9C6300FF000000FF00
      0000CE9C63000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009C9C9C00DEEFEF00DEEF
      EF009C9C9C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084C6000084C6000084C6000042630000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CE9C6300000000000000000000000000CE9C6300FF000000FF000000CE9C
      6300000000000000000000000000000000000000000000000000000000000000
      00009C9C9C000000000000000000000000009C9C9C00DEEFEF00DEEFEF009C9C
      9C00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084C6000084C6000084C6000042630000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CE9C6300CE9C63000000000000000000CE9C6300FF000000FF000000CE9C
      6300000000000000000000000000000000000000000000000000000000000000
      00009C9C9C009C9C9C0000000000000000009C9C9C00DEEFEF00DEEFEF009C9C
      9C00000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084C6000084C6000084C6000042630000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CE9C6300FF000000CE9C6300CE9C6300FF000000FF000000CE9C63000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009C9C9C00DEEFEF009C9C9C009C9C9C00DEEFEF00DEEFEF009C9C9C000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084C6000084C6000084C6000042630000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CE9C6300FF000000FF000000FF000000FF000000FF000000CE9C63000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009C9C9C00DEEFEF00DEEFEF00DEEFEF00DEEFEF00DEEFEF009C9C9C000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000084C6000084C6000084C6000042630000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CE9C6300FF000000FF000000FF000000FF000000FF000000CE9C6300CE9C
      6300CE9C6300CE9C630000000000000000000000000000000000000000000000
      00009C9C9C00DEEFEF00DEEFEF00DEEFEF00DEEFEF00DEEFEF009C9C9C009C9C
      9C009C9C9C009C9C9C00000000000000000000000000000000000000000000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000084C6000084C6000084C6000042630000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CE9C6300FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000CE9C63000000000000000000000000000000000000000000000000000000
      00009C9C9C00DEEFEF00DEEFEF00DEEFEF00DEEFEF00DEEFEF00DEEFEF00DEEF
      EF009C9C9C00000000000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000084C6000084C6000084C6000042630000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CE9C6300FF000000FF000000FF000000FF000000FF000000FF000000CE9C
      6300000000000000000000000000000000000000000000000000000000000000
      00009C9C9C00DEEFEF00DEEFEF00DEEFEF00DEEFEF00DEEFEF00DEEFEF009C9C
      9C0000000000000000000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000084C6000084C6000084C6000042630000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CE9C6300FF000000FF000000FF000000FF000000FF000000CE9C63000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009C9C9C00DEEFEF00DEEFEF00DEEFEF00DEEFEF00DEEFEF009C9C9C000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF00000000000000000084C60000426300000000
      0000000000000000000084C6000084C6000084C6000042630000000000000000
      00000000000084C6000042630000000000000000000000000000000000000000
      0000CE9C6300FF000000FF000000FF000000FF000000CE9C6300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009C9C9C00DEEFEF00DEEFEF00DEEFEF00DEEFEF009C9C9C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084C60000426300000000
      0000000000000000000084C6000084C6000084C6000042630000000000000000
      00000000000084C6000042630000000000000000000000000000000000000000
      0000CE9C6300FF000000FF000000FF000000CE9C630000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009C9C9C00DEEFEF00DEEFEF00DEEFEF009C9C9C0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084C6000084C6000084C6
      000084C6000084C6000084C6000084C6000084C6000084C6000084C6000084C6
      000084C6000084C6000042630000000000000000000000000000000000000000
      0000CE9C6300FF000000FF000000CE9C63000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009C9C9C00DEEFEF00DEEFEF009C9C9C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000042630000426300004263
      0000426300004263000042630000426300004263000042630000426300004263
      0000426300004263000042630000000000000000000000000000000000000000
      0000CE9C6300FF000000CE9C6300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009C9C9C00DEEFEF009C9C9C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CE9C6300CE9C630000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009C9C9C009C9C9C0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF000000FF000000FF000000FF000000FF000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000000000000000000000840000000000000000000000840000008400
      0000000000000000000000000000000000000000000000000000FF000000FF00
      000084848400C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C6008484
      8400FF000000FF00000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF00000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000000000000000000000840000000000000084000000000000000000
      0000840000000000000000000000000000000000000000000000FF0000008484
      840084848400C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C6008484
      840084848400FF00000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF00000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000000000000000000000840000000000000084000000000000000000
      0000840000000000000000000000000000000000000000000000FF0000008484
      8400FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      000084848400FF00000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF00000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000084000000840000000000000084000000000000000000
      0000840000000000000000000000000000000000000000000000FF000000FF00
      000084848400C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C6008484
      8400FF000000FF00000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF00000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000840000000000000084000000840000008400
      0000000000000000000000000000000000000000000000000000FF0000008484
      840084848400C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C6008484
      840084848400FF00000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF00000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000840000000000000084000000000000000000
      0000000000000000000000000000000000000000000000000000FF0000008484
      8400FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      000084848400FF00000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF00000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      000084848400C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C6008484
      8400FF000000FF00000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF00000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF0000008484
      840084848400C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C6008484
      840084848400FF00000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF00000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF0000008484
      8400FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      000084848400FF00000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF00000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FF000000FF000000000000000000000000000000FF000000000000000000
      00000000000000000000FF000000FF000000FF00000000000000000000000000
      000000000000FF000000000000000000000000000000FFFFFF00000000000000
      000000000000FFFFFF0000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FF000000000000000000000000000000FF000000000000000000
      00000000000000000000FF000000FF000000FF00000000000000000000000000
      000000000000FF000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FF00000000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000000000000000
      0000FF000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084FFFF0084FF
      FF0084FFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      000084848400C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C6008484
      84000000000000000000000000000000000000000000FF00000000000000FF00
      00000000000000000000FF000000FF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000000000000
      000000000000000000000000000000000000000000000000000084FFFF0084FF
      FF0084FFFF0000000000FFFFFF00000000000000000000000000000000000000
      0000FFFFFF00FFFFFF0000000000000000000000000000000000000000008484
      840084848400C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C6008484
      84008484840000000000000000000000000000000000FF000000000000000000
      0000FF000000FF0000000000000000000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      000000000000000000000000000000000000000000000000000084FFFF000000
      000084FFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      00008484840000000000000000000000000000000000FF000000000000000000
      0000FF000000FF000000FF000000FF0000000000000000000000FF000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF0000000000000000000000000000000000000000000000000084FFFF0084FF
      FF0084FFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      000084848400C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C6008484
      84000000000000000000000000000000000000000000FF000000000000000000
      0000FF000000FF000000FF000000FF000000FF000000FF000000000000000000
      0000FF000000FF0000000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF00000000000000000000000000000000000000000084FFFF000000
      000084FFFF0000000000FFFFFF00000000000000000000000000000000000000
      0000FFFFFF00FFFFFF0000000000000000000000000000000000000000008484
      840084848400C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C6008484
      84008484840000000000000000000000000000000000FF000000000000000000
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      00000000000000000000FF00000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000000000000000000000000000000084FFFF0084FF
      FF0084FFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      00008484840000000000000000000000000000000000FF000000000000000000
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF0000000000
      000000000000FF000000FF00000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF0000000000000000000000000084FFFF000000
      000084FFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      000084848400C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C6008484
      84000000000000000000000000000000000000000000FF000000000000000000
      0000FF000000FF000000FF000000FF000000FF0000000000000000000000FF00
      0000FF000000FF0000000000000000000000000000000000FF00FFBDFF00FFBD
      FF00FFBDFF00FFBDFF00FFBDFF00FFBDFF00FFBDFF00FFBDFF000000FF000000
      FF000000FF000000FF000000000000000000000000000000000084FFFF0084FF
      FF0084FFFF0000000000FFFFFF00000000000000000000000000000000000000
      0000FFFFFF00FFFFFF0000000000000000000000000000000000000000008484
      840084848400C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C6008484
      84008484840000000000000000000000000000000000FF000000000000000000
      0000FF000000FF000000FF0000000000000000000000FF000000FF000000FF00
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF00000000000000000000000000000000000000000084FFFF000000
      000084FFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      00008484840000000000000000000000000000000000FF000000000000000000
      0000FF0000000000000000000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF0000000000000000000000000000000000000000000000000084FFFF0084FF
      FF0084FFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000000000000000000000000000FF000000000000000000
      000000000000FF000000FF000000FF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      000000000000000000000000000000000000000000000000000084FFFF000000
      000084FFFF0000000000FFFFFF00000000000000000000000000000000000000
      0000FFFFFF00FFFFFF000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000000000000000000000000000FF00000000000000FF00
      0000FF000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000000000000
      000000000000000000000000000000000000000000000000000084FFFF0084FF
      FF0084FFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000000000000000000000000000FF000000FF000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF1818000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FF00000000000000000000000000
      00000000000000000000000000000000000000000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF1818000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000000000000000
      00000000000000000000000000000000000000000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000007B1800007B1800005A0000005A0000000018000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF181800FFBDBD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF0000000000000000000000FF000000000000000000
      00000000000000000000000000000000000000000000FF000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000039FF1800009C0000009C0000007B1800007B1800005A0000000018000000
      1800000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF181800FFBDBD00FF7B180000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000000000000000000000000000FF0000000000
      00000000000000000000000000000000000000000000FF00000000000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000009C0000009C0000009C0000009C0000007B1800005A0000005A0000005A
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF181800FFBDBD00FF7B1800FF18180000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF0000000000000000000000FF00000000000000FF0000000000
      00000000000000000000000000000000000000000000FF000000FF9C5A000000
      0000FF000000FF00000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000009C
      0000009C0000009C0000009C0000009C0000007B1800007B1800005A0000005A
      0000005A00000000000000000000000000000000000000000000000000000000
      000000000000FF181800FFBDBD00FF7B1800FF18180000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF00000000000000FF000000FF0000000000000000000000FF00
      00000000000000000000000000000000000000000000FF00000000000000FFFF
      9C00FF000000FF000000FF000000FF0000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000009C
      0000009C0000009C0000009C0000009C0000009C0000009C0000007B1800007B
      1800005A00000000180000000000000000000000000000000000000000000000
      0000FF181800FFBDBD00FF7B1800FF181800FF181800FF181800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF0000000000000000000000FF000000FF000000FF00000000000000FF00
      00000000000000000000000000000000000000000000FF000000FF9C5A000000
      0000FF000000FF000000FF000000FF000000FF000000FF000000000000000000
      000000000000000000000000000000000000000000000000000000000000009C
      0000009C000039FF9C0039FF9C00009C0000009C0000009C0000009C0000007B
      1800005A00000000180000000000000000000000000000000000000000000000
      0000FF181800FFBDBD00FF7B1800FF181800FF181800FF181800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF00000000000000FF000000FF000000FF000000FF000000000000000000
      0000FF00000000000000000000000000000000000000FF00000000000000FFFF
      9C00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      000000000000000000000000000000000000000000000000000000000000009C
      0000009C000039FF9C0039FF9C0039FF9C00009C0000009C0000009C0000007B
      1800007B1800005A00000000000000000000000000000000000000000000FF18
      1800FFBDBD00FF7B1800FF181800FF181800FF181800FF181800FF1818000000
      000000000000000000000000000000000000000000000000000000000000FF00
      00000000000000000000FF000000FF000000FF000000FF000000FF0000000000
      0000FF00000000000000000000000000000000000000FF000000FF9C5A000000
      0000FF000000FF000000FF000000FF000000FF000000FF9C9C00FF9C9C00FF00
      0000FF000000FF0000000000000000000000000000000000000000000000009C
      0000009C0000009C000039FF9C0039FF9C0039FF9C00009C0000009C0000009C
      0000007B1800005A00000000000000000000000000000000000000000000FF18
      1800FFBDBD00FF7B1800FF181800FF181800FF181800FF181800FF1818000000
      000000000000000000000000000000000000000000000000000000000000FF00
      000000000000FF000000FF000000FF000000FF000000FF000000FF0000000000
      000000000000FF000000000000000000000000000000FF00000000000000FFFF
      9C00FF000000FF000000FF000000FF9C9C00FF9C9C00FF000000FF000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000009C0000009C0000009C000039FF9C0039FF9C00009C0000009C0000009C
      0000007B18000000000000000000000000000000000000000000FF181800FFBD
      BD00FF7B1800FF7B1800FF7B1800FF7B1800FF7B1800FF7B1800FF7B1800FF7B
      1800000000000000000000000000000000000000000000000000FF0000000000
      000000000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      000000000000FF000000000000000000000000000000FF000000FF9C5A000000
      0000FF000000FF9C9C00FF9C9C00FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000039FF1800009C0000009C0000009C0000009C0000009C0000009C0000009C
      000039FF18000000000000000000000000000000000000000000FF181800FFBD
      BD00FFBD7B00FFBD7B00FFBD7B00FFBD7B00FFBD7B00FFBD7B00FFBD7B00FFBD
      7B00000000000000000000000000000000000000000000000000FF0000000000
      000000000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      00000000000000000000FF0000000000000000000000FF00000000000000FF9C
      9C00FF9C9C00FF000000FF000000FF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000009C0000009C0000009C0000009C0000009C00000000
      00000000000000000000000000000000000000000000FF181800FFBDBD00FF18
      1800FFBDBD00FFBDBD00FFBDBD00FFBDBD00FFBDBD00FFBDBD00FFBDBD00FFBD
      BD00FF18180000000000000000000000000000000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF181800FF0000000000000000000000FF000000FF9C5A00FF00
      0000FF000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF181800FF18
      1800FF181800FF181800FF181800FF181800FF181800FF181800FF181800FF18
      1800FF181800FF181800000000000000000000000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF0000000000000000000000FF000000FF000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000003900000039000000180000001800000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000397B0000005A0000005A0000005A000000180000001800000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000005A0000005A0000005A0000005A000000390000001800000018000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      5A0000005A0000005A0000005A0000005A0000005A0000003900000018000000
      180000001800000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      5A0000005A0000005A0000005A0000005A0000005A0000005A00000039000000
      390000001800000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      5A0000005A00397BFF00397BFF0000005A0000005A0000005A0000005A000000
      390000001800000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      5A0000005A00397BFF00397BFF00397BFF0000005A0000005A0000005A000000
      390000001800000018000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      5A0000005A0000005A00397BFF00397BFF00397BFF0000005A0000005A000000
      5A0000003900000018000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000005A0000005A0000005A00397BFF00397BFF0000005A0000005A000000
      5A0000003900000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000397B0000005A0000005A0000005A0000005A0000005A0000005A000000
      5A0000397B00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000005A0000005A0000005A0000005A0000005A000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF0000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF0000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF0000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF0000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF0000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008484000084
      8400008484000084840000848400008484000084840000848400008484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000084
      8400008484000084840000848400008484000084840000848400008484000084
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF0000FFFF000000
      0000008484000084840000848400008484000084840000848400008484000084
      8400008484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00FFFFFF0000FF
      FF00000000000084840000848400008484000084840000848400008484000084
      8400008484000084840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF0000FFFF00FFFF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF0000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000CE9C6300CE9C6300CE9C6300CE9C6300CE9C
      6300CE9C6300CE9C6300CE9C6300CE9C63000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000CE9C6300FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00CE9C63000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000639C000063
      9C0000639C0000639C0000639C00CE9C6300FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00CE9C63000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000319CCE009CFFFF009CFF
      FF009CFFFF009CFFFF009CFFFF00CE9C6300FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00CE9C63000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000319CCE00CEFFFF009CFF
      FF009CFFFF009CFFFF009CFFFF00CE9C6300FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00CE9C63000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000319CCE009CFFFF00CEFF
      FF009CFFFF009CFFFF009CFFFF00CE9C6300FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00CE9C63000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000319CCE00CEFFFF009CFF
      FF00CEFFFF009CFFFF009CFFFF00CE9C6300FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00CE9C63000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000319CCE009CFFFF00CEFF
      FF009CFFFF00CEFFFF009CFFFF00CE9C6300FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00CE9C6300CE9C6300CE9C6300CE9C63000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000319CCE00CEFFFF009CFF
      FF00CEFFFF009CFFFF00CEFFFF00CE9C6300FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00CE9C6300E7E7E700CE9C6300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000319CCE009CFFFF00CEFF
      FF009CFFFF00CEFFFF009CFFFF00CE9C6300FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00CE9C6300CE9C630000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000319CCE00CEFFFF009CFF
      FF00CEFFFF009CFFFF00CEFFFF00CE9C6300CE9C6300CE9C6300CE9C6300CE9C
      6300CE9C63000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000319CCE00CEFFFF00CEFF
      FF009CFFFF00CEFFFF009CFFFF00CEFFFF009CFFFF00CEFFFF009CFFFF009CFF
      FF0000639C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000319CCE00CEFFFF00CEFF
      FF00CE6300009C3100009C3100009C3100009C3100009C310000CEFFFF009CFF
      FF0000639C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000319CCE00CEFFFF00CEFF
      FF00CE630000FFFFFF00FF9C0000FF9C0000FF9C00009C3100009CFFFF00CEFF
      FF0000639C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000319CCE00319C
      CE00319CCE00CE630000FFFFFF00FF9C00009C310000319CCE00319CCE00319C
      CE00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000CE630000CE6300000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CE6300009C3100009C31
      0000CE630000000000000000000000000000000000000000000000000000CE63
      00009C3100009C310000CE630000000000000000000000000000000000000000
      00000000000000000000319CCE0000639C0000639C0000639C0000639C000063
      9C0000639C0000639C0000639C000000000000000000000000009C3100009C31
      00009C3100009C3100009C3100009C3100009C3100009C3100009C3100009C31
      00009C3100000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CE6300009C310000000000000000
      00009C310000CE63000000000000000000000000000000000000CE6300009C31
      000000000000000000009C310000CE6300000000000000000000000000000000
      00000000000000000000319CCE009CFFFF009CFFFF009CFFFF009CFFFF009CFF
      FF009CFFFF009CFFFF0000639C000000000000000000CE9C6300FFCE9C00FFCE
      9C00FFCE9C00FFCE9C00FFCE9C00FFCE9C00FFCE9C00FFCE9C00FFCE9C00CE9C
      6300CE9C63009C31000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CE6300009C310000000000000000
      0000000000009C310000000000000000000000000000000000009C3100000000
      000000000000000000009C310000CE6300000000000000000000000000000000
      00000000000000000000319CCE009CFFFF009CFFFF009CFFFF009CFFFF009CFF
      FF009CFFFF009CFFFF0000639C0000000000CE9C6300CE9C6300CE9C6300CE9C
      6300CE9C6300CE9C6300CE9C6300CE9C6300CE9C6300CE9C6300CE9C6300CE9C
      63009C310000CE9C63009C310000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CE6300009C3100000000
      0000000000009C310000CE6300000000000000000000CE6300009C3100000000
      0000000000009C310000CE630000000000000000000000000000000000000000
      00000000000000000000319CCE009CFFFF009CFFFF009CFFFF009CFFFF009CFF
      FF009CFFFF009CFFFF0000639C0000000000CE9C6300FFFFFF00FFCE9C00FFCE
      9C00FFCE9C00FFCE9C00FFCE9C00FFCE9C00FFCE9C00FFCE9C00FFCE9C00FFCE
      9C00CE9C63009C3100009C310000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CE6300009C31
      00009C3100009C3100009C310000CE630000CE6300009C3100009C3100009C31
      00009C310000CE63000000000000000000000000000000000000000000000000
      00000000000000000000319CCE009CFFFF009CFFFF009CFFFF009CFFFF009CFF
      FF009CFFFF009CFFFF0000639C0000000000CE9C6300FFFFFF00FFCE9C00FFCE
      9C00FFCE9C00FFCE9C0000CE0000009C0000FFCE9C000000FF000000CE00FFCE
      9C00CE9C6300CE9C63009C310000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000000000000000000000000000000000000000000000000000000000
      00009C3100009C3100009C3100009C3100009C3100009C3100009C3100009C31
      00000000000000000000000000000000000000000000CE9C6300CE9C6300CE9C
      6300CE9C6300CE9C6300319CCE009CFFFF009CFFFF009CFFFF009CFFFF009CFF
      FF009CFFFF009CFFFF0000639C0000000000CE9C6300FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00CE9C6300CE9C6300CE9C63009C3100000000000000000000840000008400
      0000840000008400000084000000000000000000000000000000000000000000
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000009C3100009C9C9C00FFFFFF00FFFFFF009C9C9C009C3100000000
      00000000000000000000000000000000000000000000CE9C6300FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00319CCE009CFFFF009CFFFF009CFFFF009CFFFF009CFF
      FF009CFFFF009CFFFF0000639C0000000000CE9C6300FFFFFF00FFCE9C00FFCE
      9C00FFCE9C00FFCE9C00FFCE9C00FFCE9C00FFCE9C00FFCE9C00FFCE9C00FFCE
      9C00CE9C6300CE9C6300CE9C63009C3100000000000000000000840000008400
      0000840000008400000000000000000000000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000000000000000
      0000000000009C9C9C00FFFFFF006363630063636300FFFFFF00636363000000
      00000000000000000000000000000000000000000000CE9C6300FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00319CCE009CFFFF009CFFFF009CFFFF009CFFFF00319C
      CE00319CCE00319CCE00319CCE000000000000000000CE9C6300CE9C6300CE9C
      6300CE9C6300CE9C6300CE9C6300CE9C6300CE9C6300CE9C6300CE9C6300FFCE
      9C00FFCE9C00CE9C6300CE9C63009C3100000000000000000000840000008400
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000000000000000
      00009C9C9C00FFFFFF00CECECE00CECECE00FFFFFF0063636300CECECE006363
      63000000000000000000000000000000000000000000CE9C6300FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00319CCE009CFFFF009CFFFF009CFFFF009CFFFF00319C
      CE00CEFFFF0000639C0000000000000000000000000000000000CE9C6300FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CE9C
      6300FFCE9C00FFCE9C00CE9C63009C3100000000000000000000840000008400
      0000000000008400000000000000000000000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000000000009C9C
      9C00FFFFFF00CECECE00CECECE00636363009C9C9C00FFFFFF00CECECE00CECE
      CE006363630000000000000000000000000000000000CE9C6300FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00319CCE009CFFFF009CFFFF009CFFFF009CFFFF00319C
      CE0000639C00000000000000000000000000000000000000000000000000CE9C
      6300FFFFFF00E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700FFFFFF00CE9C
      6300CE9C6300CE9C63009C310000000000000000000000000000840000000000
      0000000000000000000084000000840000000000000000000000000000000000
      00008400000000000000000000000000000000000000000000009C9C9C00FFFF
      FF00CECECE00CECECE006363630000000000000000009C9C9C00FFFFFF00CECE
      CE00CECECE0063636300000000000000000000000000CE9C6300FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00319CCE00319CCE00319CCE00319CCE00319CCE00319C
      CE0000000000000000000000000000000000000000000000000000000000CE9C
      6300FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00CE9C63000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008400000084000000840000008400
      000000000000000000000000000000000000000000009C9C9C00FFFFFF00CECE
      CE00CECECE0063636300000000000000000000000000000000009C9C9C00FFFF
      FF00CECECE00CECECE00636363000000000000000000CE9C6300FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CE9C6300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CE9C6300FFFFFF00E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700FFFF
      FF00CE9C63000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009C9C9C00FFFFFF00CECECE00CECE
      CE00636363000000000000000000000000000000000000000000000000009C9C
      9C00FFFFFF00CECECE00CECECE006363630000000000CE9C6300FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00CE9C6300CE9C6300CE9C6300CE9C6300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CE9C6300FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CE9C630000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009C9C9C00FFFFFF00CECECE006363
      6300000000000000000000000000000000000000000000000000000000000000
      00009C9C9C00FFFFFF00CECECE006363630000000000CE9C6300FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00CE9C6300E7E7E700CE9C630000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CE9C6300CE9C6300CE9C6300CE9C6300CE9C6300CE9C6300CE9C
      6300CE9C6300CE9C630000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009C9C9C00FFFFFF00636363000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009C9C9C00FFFFFF006363630000000000CE9C6300FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00CE9C6300CE9C63000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009C9C9C009C9C9C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009C9C9C009C9C9C0000000000CE9C6300CE9C6300CE9C
      6300CE9C6300CE9C6300CE9C6300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009C3100009C31
      00009C3100009C3100009C3100009C3100009C3100009C3100009C3100009C31
      00009C3100009C3100009C310000000000000000000000000000000000000000
      00000000000000FFFF000000000000FFFF000000000000000000000000000000
      000000FFFF0000FFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009C310000CE630000CE63
      00009C310000E7E7E700CE6300009C310000E7E7E700E7E7E700E7E7E7009C31
      0000CE630000CE6300009C3100000000000000000000000000000000000000FF
      FF000000000000FFFF000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000008484000084
      8400008484000084840000848400008484000084840000848400008484000000
      000000000000000000000000000000000000000000009C310000CE630000CE63
      00009C310000E7E7E700CE6300009C310000E7E7E700E7E7E700E7E7E7009C31
      0000CE630000CE6300009C310000000000000000000000FFFF000000000000FF
      FF000000000000FFFF000000000000FFFF000000000000000000000000000000
      0000000000000000000000FFFF0000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000FFFF00000000000084
      8400008484000084840000848400008484000084840000848400008484000084
      840000000000000000000000000000000000000000009C310000CE630000CE63
      00009C310000E7E7E700CE6300009C310000E7E7E700E7E7E700E7E7E7009C31
      0000CE630000CE6300009C310000000000000000000000FFFF000000000000FF
      FF000000000000FFFF000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000000000000000000000000000FFFFFF0000FFFF000000
      0000008484000084840000848400008484000084840000848400008484000084
      840000848400000000000000000000000000000000009C310000CE630000CE63
      00009C310000E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E7009C31
      0000CE630000CE6300009C310000000000000000000000FFFF000000000000FF
      FF000000000000FFFF000000000000FFFF000000000000000000000000000000
      0000000000000000000000FFFF0000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000FFFF00FFFFFF0000FF
      FF00000000000084840000848400008484000084840000848400008484000084
      840000848400008484000000000000000000000000009C310000CE630000CE63
      0000CE6300009C3100009C3100009C3100009C3100009C3100009C310000CE63
      0000CE630000CE6300009C310000000000000000000000FFFF000000000000FF
      FF000000000000FFFF000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000000000000000000000000000FFFFFF0000FFFF00FFFF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009C310000CE630000CE63
      0000CE630000CE630000CE630000CE630000CE630000CE630000CE630000CE63
      0000CE630000CE6300009C310000000000000000000000FFFF000000000000FF
      FF000000000000FFFF000000000000FFFF0000000000000000000000000000FF
      FF0000FFFF0000FFFF0000FFFF0000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000FFFF00FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      000000000000000000000000000000000000000000009C310000CE630000CE63
      00009C3100009C3100009C3100009C3100009C3100009C3100009C3100009C31
      0000CE630000CE6300009C310000000000000000000000FFFF000000000000FF
      FF000000000000FFFF000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000000000000000000000000000FFFFFF0000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF00000000000000
      000000000000000000000000000000000000000000009C310000CE6300009C31
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF009C310000CE6300009C310000000000000000000000FFFF000000000000FF
      FF000000000000FFFF000000000000FFFF00000000000000000000FFFF0000FF
      FF0000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009C310000CE6300009C31
      0000FFFFFF009C3100009C3100009C3100009C3100009C3100009C310000FFFF
      FF009C310000CE6300009C310000000000000000000000FFFF000000000000FF
      FF000000000000FFFF000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009C310000CE6300009C31
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF009C310000CE6300009C310000000000000000000000FFFF000000000000FF
      FF000000000000FFFF0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009C310000E7E7E7009C31
      0000FFFFFF009C3100009C3100009C3100009C3100009C3100009C310000FFFF
      FF009C3100009C3100009C310000000000000000000000FFFF000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009C310000CE6300009C31
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF009C310000CE6300009C310000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009C3100009C3100009C31
      00009C3100009C3100009C3100009C3100009C3100009C3100009C3100009C31
      00009C3100009C3100009C310000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000B00300000100010000000000801D00000000000000000000
      000000000000000000000000FFFFFF00F9FF000000000000FC0F000000000000
      F80F000000000000E00F000000000000E007000000000000C007000000000000
      C007000000000000E087000000000000E087000000000000E007000000000000
      E003000000000000F871000000000000F87F000000000000F87F000000000000
      F87F000000000000FE7F000000000000F00FF81FF01FFFFFC003E007E007FFFF
      8001C003C003FE7F83C183C18001FC1F100818190001F00F024017C00000F00F
      024006400000C003000000000000C003000000400000E3C7000000000000E3C7
      010003800000C183018001810001C003808181818001E187800180C38003FBDF
      C003C007C007FFFFF00FF00FF00FFFFFFFFF83838001F04FFFFF8FE30000E087
      FFFF8FE30000A081FFFF8FE300009001F81F8FE30000110DF81F8FE300000920
      F81F8FE3000004C0F01F8FE300000380F01F8FE300000498F01F8FE300000184
      F81F8FE300000043F01F8FE300000241FFFF8FE300008421FFFF83830000C823
      FFFFFFFF0000F027FFFFFFFF8001F02FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFE3C7F81FE007F81FE3E7F81FC003F81F
      E3E7F81FC003F81FE7E3F01FC003F01F0FF0F01FC003F01F0FF0F01FC003F01F
      E7E3F81FC003F81FE3E7F01FC003F01FE3E7FFFFE007FFFFE3C7FFFFFFFFFFFF
      F00FFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000010000
      000000008001000000000000E007000000000000E007000000000000E0070000
      40000000E007000040000000E023000000000000802300000000000080410000
      00000000C003000000000000E007000000000000F0070000765C0000F8070000
      00000000FC4F000045140000FEFF0000FFFFF800FFFFFFFFEDD3E000F8FFF00F
      D5D5E000E01FC3C3D635E000800BC3C3D6B5E0008000C003D775E0000000C3C3
      D773E0000001C3C3FFFFE0000003C003F1FF00000003C3C3F1FF00000007C3C3
      F1FF80000007C003803FC0000007CFF3C07FE000800FDFFBE0FFF000801FEFF7
      F1FFF800E03FF00FFBFFF800FFFFFFFF8001FFFF80008000FFFFC18300000000
      FFFFC18300000000F81FC18300000000F3CFC18300000000F3CFC18300000000
      F3CFC18300000000F3CFFFFF00000000F3CFFFFF00000000F3CFC18300000000
      F3CFC18300000000F3CFC18300000000E3C7C18300000000C183C18300000000
      FFFFC18300000000FFFFFFFF00000000FFFFFFFFFFFFFFFFFFFF9249FFFFFFFF
      000F9249FEFF9FF3000F9249FC7FCFE77FAF9249F83FE7CF490F9249F39FF39F
      7F8F9249E7CFF83F49079249CFE7FC7F7F97F2499EF39EF300037249FC7FCFE7
      000B224FF83FE7CF00018647F39FF39FFFE1D243E7CFF83FFFF0F9C9CFE7FC7F
      FFF0FC8C9FF3FEFFFFF9FE0FFFFFFFFFFFFFFFFFFFFFFFFFFFFF800FFFFFC000
      003F800F80038000003F800FC0038000002F800FC00380100003800FC0038008
      002D800F80038000003D800FFC038000003D800FF0038000003F800FE0038000
      0020800FE083800000608000F083800100E08000F003FF0F01E08000FC03FF87
      FFE1F000FFFBFF87FFE3F000FFFFFFCF8000FFFFFFFFFFFF0000C0010000FFFF
      0000DF7D3FFCE0070000DF7D4002E0070000DF7D5FFAE0070000DF7D5FFAE007
      0000DF7D5FFAE0070000C0015FFAE0070000DF7D5FFAE0070000DF7D5FFAE007
      0000DF7D5FFAE0070000DF7D5FFAE00F0000DF7D4002E01F0000C0013FFCE03F
      0000FFFF0000FFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFEFF07FF
      CFFFFFFFFFFFF9FFEFFFC27FC27FFC7FE800FFFFFFFFF83FCFFFC200C200F01F
      FFFFFFFFFFFFE10FDFFFDE07DE07C207E800CE079E07841BEFFF07FF07FF083B
      CFFFCE009E00E077FFFFDE00DE00F8E3DFFFFFFFFFFFFDC1D800C200C200FE20
      DFFFFFFFFFFFFFF0FFFFFEFFFEFFFFF9FFFFFFFFFFFFFFFFC001D555FFFFFFFF
      FFFFDFFFEA738FFFDF7DDF7DEAAF8C01FFFFDFFFE26F8FFFDF7DDF7DEAAFFFFF
      FFFFDFFFF673FFFFD555D555FFFF8FFFFFFFDFFFFFFF8C01DF7DDF7DDBDB8FFF
      FFFFDFFFB7EDFFFFDF7DDF7D6FF6FFFFFFFFDFFF6FF68FFFD555D555B7ED8C01
      FFFFFFFFDBDB8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC001D555D555D555
      DFFDFF7FFFFFFFFDDF7DDF7DDF7DDF7DDFFDFF7FFFFFFFFDDF7DDF7DDF7DDF7D
      DFFDFF7FFFFFFFFDD555C001D555D555DFFDFF7FFFFFFFFDDF7DDF7DDF7DDF7D
      DFFDFF7FFFFFFFFDDF7DDF7DDF7DDF7DDFFDFF7FFFFFFFFDC001D555C001D555
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000C001D555
      00000000DF7DFFFF00000000DF7DDF7D00000000DF7DFFFF00000000DF7DDF7D
      00000000DF7DFFFF00000000C001D55500000000DF7DFFFF00000000DF7DDF7D
      00000000DF7DFFFF00000000DF7DDF7D00000000DF7DFFFF00000000C001D555
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF03FFF83FFEFF
      03FF03FFF83FFC7F03FF03FFF83FF83F03FF03FFF83FFEFF03FF03FFF83FFEFF
      03FF03FFF83FF83F03FF0340FEFFF83F0037FE40FEFFF83FF033FC00F83FF83F
      F001FE40FC7FF83F0033037FFEFF800303F703FF8383800303FF03FF83838003
      03FF03FF83838003FFFFFFFF8383FFFFFFFFFFFFFFFFFFFFFFFFFFE1FFFFFFFF
      E00FFFE4FFFF0000FFFFDF84DF9F0000F83FCF04CF1F0000F11FE661E67F0000
      F39FF0E7F0FF0000F39FF8E7F8FF0000F39FF0FFF0FF0000F39FE67FE67F0000
      F39FC73FC7200000F39FDF9FDF840000E10FFFFFFFE00000FFFFFFFFFFFC0000
      FFFFFFFFFFE10000FFFFFFFFFFFFFFFFC00F8000FFFFFFFFC0030000C84FFFFF
      800100008007FFFF8000000080070003800000008007FFFF8000000000030003
      800000000003FFFF8000000000030003000000000003FFFF0004800000030003
      80008C000003FFFF00038C00000300030007FC000003FFFF003FFC0080070003
      803FFC1F8007FFFFC07FFC1FC007FFFFFDFFFC01FC1FF81FF8FFFC00E01FE007
      F07F04000007C003E03F000000038001C21F000000018001870F000000000000
      CF87000000000000FFE3000000000000FFF100000000000080FC000000000000
      007E000000000000007F000000008001007F000700008001007F00070000C003
      007F071F0000E00780FFFFFF8003F81FF00FFFFFFFFFFFFFE007F003F000F000
      C003F003F000F0008801F003F000F00000000003F000F00000000003C0008000
      02000003C000000001000003C000000000800003C00000000010F003C0000000
      0000F003C00000000081F003000000008011F003003F003FC003F003003F003F
      E007F003C03F003FF81FFFFFC07F807FF800FFFF80A1F800E00000000080F800
      E00080030200F000E00080030000E000E00080030020C000E000800300008000
      E000800300000000E00080C300000000000080C30200E000000080C30000E000
      800080C30000E000C00087C30000E000E00087C30001E000F00087FF0003E000
      F800FFFF0007E000F800FFFF800FF8008001FDFF8001EFEF0001F8FF8001C7C7
      DFFFF07F80018787E3FFE03F80010303E1FFC21F80010303F0FF870F80010101
      F85FCF8780010101FC2FFFE380010000FE17FFF180010000FF0BFFFC80010101
      FF85A88E80018181FFC2AABF80018080FFE089BF8001C1C1FFF0AABF8001C3C3
      FFF8898F8001E7E7FFFCFFFF8001EFEF80008001FFFFFDFF00000000C003F8FF
      00000000C003F07F00000000C003E03F00000000C003C21F00000000C003870F
      00000000C003CF8700000000C003FFE300000000C003FFF100000000C003FFFC
      00000000C003EBAE00000000C003C107000000000000EBAF00000000C003C107
      00000000F01FEBAF00008001FC7FFFFFF80FFFFF8000F000F00780030000F000
      C00380030000F000800180030000F000000180030000F000000180030000F000
      000180030000F000000080030000F000000080030000F000800080030000F801
      C00180030000F803E00180030000FC0FF00380030000FE0FFF0380030000FC0F
      FF8780030000E06FFFCFFFFF0000E0FFFFFF8000FFFFFFFF800100000000C003
      800100000000C0039E7900000000C003981900000000C003900900000000C003
      800100000000C003800100000000C003900900000000C003981900000000C003
      981900000000C003900900000000C0038001000000000000800100000000C003
      800100000000F01FFFFF0000FFFFFC7F8001F00FFFFF80000000E00780010000
      0000800380010000000080018001000000000000800144000000000080012800
      0000000080010000000000008001820000000000800100000000000080010000
      0000000080010000000000008001000000000001800100000000800380010000
      0000C007800100008001E00FFFFF00008000FFFFE000800000008001E0000000
      00008001E000000000008001E000000000008001E000000000008001E0000000
      00008001E000000000008001E000000000008001E000000000008001E0000000
      0000801F000000000000801F000000000000F01F000000000000F01F00000000
      0000F01FE00100000000FFFFE0030000FDFFFF3FFFFFFF03F8FFF83F8001FF03
      F07FC03F8001FC00E03F000380010000C21F000180010000870F012080010000
      CF87092080010000FFE30920BC010000F8F10120BC010000E07C0E609C010000
      C03E09E0FF010007C07F0700BE010007C03F18008C01001FC03F00008401001F
      E07FC0008001001FF1FFF800FFFF07FFF03F807FC003FFFFE00F000FC003FFFF
      C0070001C003FFFF80030000C003FFFF80010000C003FFFF81010000C003FFFF
      83810000C003FFFF83C10000C003FFFF83C10000C003FFFFC1C10000C003FFFF
      81C30000C003FFFF80010000C003FFFF80010000C003FFFFE0030000C003FFFF
      E007F000C003FFFFF00FFFC0C003FFFF8FFFC003E000FFFF07FF8001E000C007
      83FF0000E000C00781FF0000E000C8A7C0FF0000E000C207E0030000E000C007
      F0010000E000C007F8000000E000C007F8000000E000C007F8000000E000C007
      F80000000000C007F80000000000C007F80000000000C007F80000000000C007
      FC018001E001C007FE03C003E003FFFFFFFF8FFF8FFF8FFFFFF107FF07FF07FF
      FFA183FF83FF83FFFFC181FF81FF81FFFE83C0FFC0FFC0FFC007E003E003E003
      800FF001F001F001001FF800F800F800001FF800F800F800001FF800F800F800
      001FF800F800F800001FF800F800F800001FF800F800F800001FF800F800F800
      803FFC01FC01FC01807FFE03FE03FE03FFFFFFFFFE3FFF00FDFFC007E00F0000
      F8FFC00780010000F07FC00780000000C03FC007C0000000801FC00780000004
      801FC00780000000820FC00780000000CF07C00780000000FF83C00780010000
      FFC1C007000100002000C007000100000210C007003F0000801CC00F003F0000
      0213C01F003F00000003FFFFE03F0000F8FFF8FFFFFFFFFFF03FF03F80008000
      E00FE30F80008000E003E4C380008000C001C47180008000C001C84D80008000
      800188E5800080008001909D8000800000031DCB800080000003333B80008000
      800798D780008000E007E63780008000F80FF9AF80008000FE0FFE6F80008000
      FF9FFF9F80008000FFFFFFFF80008000FFFFFFFFFCFFFCFFFFFFFFFFF87FF87F
      FFFFFFFFF07FF07FFFFFFFFFE07FE07FE007E007C03FC03FC003C003803E803E
      C003C003001C001CC003C00300080008C003C00300010001C003C00380038003
      C003C00380078007C003C003800F800FE007E007C01FC01FFFFFFFFFE03FE03F
      FFFFFFFFF07FF07FFFFFFFFFF8FFF8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE007E007E007E007C003C003C003C003
      C003C003C003C003C003C003C003C003C003C003C003C003C003C003C003C003
      C003C003C003C003C003C003C003C003E007E007E007E007FFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE007E007E007E007C003C003C003C003
      C003C003C003C003C003C003C003C003C003C003C003C003C003C003C003C003
      C003C003C003C003C003C003C003C003E007E007E007E007FFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE007E007E007E007C003C003C003C003
      C003C003C003C003C003C003C003C003C003C003C003C003C003C003C003C003
      C003C003C003C003C003C003C003C003E007E007E007E007FFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF83FF83FFFFFFFFFF39FF39FFFFFFFFF
      F7DFF7DFFFFFFFFFF45FF45FFFFFFFFFF55FF55FE007E007F55FF55FC003C003
      F55FF55FC003C003F55FF55FC003C003F55FF55FC003C003F55FF55FC003C003
      F55FF55FC003C003F55FF55FC003C003FDDFFDDFE007E007FDDFFDDFFFFFFFFF
      FDDFFDDFFFFFFFFFFE3FFE3FFFFFFFFFFFFFFFFF801F801F03FF03FF000F000F
      00FF00FF000F000F00FF00FF000F000F007F007F000F000F003F003F000F000F
      00070007000F000F00000000000F000F00000000000000000000000000000000
      00000000000100010000000000030003000000000007000700000000000F000F
      00000000800F800FFFFFFFFFC01FC01FFFFFFFFFFFFFFFFFBFFFBFFFFFFFFFFF
      9FFF9FFFFFFFFFFFCC3FCC3FC003C003E01FE01FC003C003F01FF01FC003C003
      E01FE01FC003C003E01FE01FC003C003E00FE00FC003C003E001E001C003C003
      F000F000C003C003FF00FF00C003C003FF80FF80C003C003FF80FF80FF3FFF3F
      FF81FF81FFFFFFFFFFC3FFC3FFFFFFFFFFCFFFCFFFFFFFFFFF87FFB700000000
      FF87FFB700000000F70FF76F00000000F30FF36F00000000F01FF4DF00000000
      F01FF7DF00000000F003F7C300000000F007F7F700000000F00FF7EF00000000
      F01FF7DF00000000F03FF7BF00000000F07FF77F00000000F0FFF6FF00000000
      F1FFF5FF00000000F3FFF3FFFFFFFFFFFFFFFFFFF81FF81FFFE3FFE3F81FF81F
      FFC1FFC5F81FF81FFF81FF8DF81FF81FFF01FF15FC3FFC3FFC03FC2BFC3FFC3F
      C007C057FC3FFC3F800FBCAFFC3FFC3F001F6F5FFC3FFC3F003F57BFFC3EFC3E
      003F6BBF981C981C003F75BF00000000003F4ABF00010001003F4DBF00030003
      807FBF7F00070007C0FFC0FF981F981FF83FF83F80008000F01FF01F00000000
      F01FF01F00000000E00FE00F00000000C007C007000000008007800700000000
      8003800300000000800380030000807F800380030000807F000300030000807F
      00010001000083E380018001000083C1C003C0030000E3C1E31FE31F0000E3C1
      E31FE31F0000FFE3F39FF39F0000FFFFFE7FFFFFFBFFFBFF3C3EFFFFF9FFF9FF
      0008F3FFFCFFFCFF0000E1FFFC7FFC7F0000C0FFF03FF03F0000C07FF01FF01F
      0000C03FF80FF80F0000C61FF83FF83F0000C70FC01FC01F0000CF87C00FC00F
      0000DFC3E00FE00F0000FFE1E03FE03F0000FFF0F01FF01F0000FFF9F00FF00F
      0000FFFFF807F8070000FFFFF803F803FFFFFC3FFC3FF81FFFFFF00FF00FF18F
      FFFFE007E007C18387F8C003C003C00303888001800198310388800180011830
      0388000000000000000000000000600600000000000060060000000000000000
      03FF80018001181803FF80018001981903FFC003C003C00387FFE007E007C183
      FFFFF00FF00FF18FFFFFFC3FFC3FF81FFE7FFE7FE003E003F83FF83FC001C001
      E01FE01F80008000800F800F8000800000070007000000000003000300000000
      0001000100000000000000000000000000000000000000008001800100000000
      C001C00100000000E000E00000000000F001F00180018001F807F8078001C001
      FC1FFC1FC003E003FE7FFE7FF00FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      07C107C10000000007C107C100007FFE07C107C100007FFE000100010000303E
      0001000100005FFE010101010000103E0101010100002FFE80038003000017F2
      C007C007000007F2C107C10700000BFEE38FE38F00000000E38FE38FFFFFFFFF
      E38FE38FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FF00FF00FF00F
      C003C003C003C003C003C003C003C003C003C003C003C003C003C003C003C003
      C003C003C003C003C003C003C003C003C003C003C003C003C003C003C003C003
      C003C003C003C003C003C003C003C003C003C003C003C003E007E007E007E007
      F00FF00FF00FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1FFFFC0FFC0FF00F
      0FFFFC0FFC0FC00383FFF80FF80FC00381FFF007F007C003C0FFE007E007C003
      C03FE003E003C003E01FC003C003C003E00788038803C003F00398019801C003
      F001F809F809C003F800F249F249C003F800F249F249C003FC00E64FE64FE007
      FC00E64FE64FF00FFE00FE7FFE7FFFFFFFFFFFFFFF80FFFFFEFFFEFFFF001FFF
      FCFFFCFFFF000FFFF8FFF8FFFE8083FFF0FFF0FFFCCF81FFE000E000F807C0FF
      C000C000F007C03F80008000F007E01F00000000E807E00780008000CCFFF003
      C000C000807FF001E000E000007FF800F0FFF0FF007FF800F8FFF8FF807FFC00
      FCFFFCFFCFFFFC00FEFFFEFFEFFFFE00FFFFFFCFFFCFFFFFF81FFF87FF87FEFF
      FC3FFF87FF87FCFFFC3FF70FF70FF8FFFC3FF30FF30FF0FFFC3FF01FF01FE000
      FC3FF01FF01FC000FC3FF003F0038000FC3FF007F0070000FC3FF00FF00F8000
      FC3FF01FF01FC0009C39F03FF03FE0009C39F07FF07FF0FF8001F0FFF0FFF8FF
      8001F1FFF1FFFCFFFFFFF3FFF3FFFEFFFFFFFFFFFFFFFFFF003FF9FFF00FF81F
      003FF6CFC003FC3F003FF6B7C003FC3F003FF6B7C003FC3F003FF8B7C003FC3F
      003FFE8FC003FC3F003FFE3FC003FC3F003FFF7FC003FC3F003FFE3FC003FC3F
      003FFEBFC003FC3F0037FC9FC0039C390063FDDFC0039C3900C1FDDFE0078001
      0180FDDFF00F8001FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8FFFFFFF8001F00F
      B3FFFFFF8001C0038CFFFF9F8001C003833FFF8F8001C00380CFC0078001C003
      803380038001C003800D80018001C003800180018001C003800380038001C003
      800F80078001C003803FFF8F8001C00380FFFF9F8001C00383FFFFBF8001E007
      8FFFFFFF8001F00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE7FFE7F8FFF
      FFFFFE3FFEBF83FFFC1FFC3FFCBF80FFF007FC1FFCDFA03FF007F81FF85F900F
      E003F80FF86FA003E003F00FF02F9001E003F007F037A001E003E007E0179003
      E003E003E01BA00FF007C003C00B903FF007C001C00DA0FFFC1F8001800183FF
      FFFFC00380018FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC003FFFFFFFFFFFF
      C003CFFFFFFFFFFFC003CFFFE7FFFC1FC003CFFFE7FFF007C003CFFFE7FFF007
      C003CFFFE1FFE003C003C3FFE1FFE003C003C3FFE7FFE003C003CFFFE7FFE003
      C003CFFFE0FFE003C003CFC1E0F7F007C007C0E3FFE3F007C00FC0F7FFC1FC1F
      C01FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC003C003C003C003
      C003C003C003C003C003C003C003C003C003C003C003C003C003C003C003C003
      C003C003C003C003C003C003C003C003C003C003C003C003C003C003C003C003
      C003C003C003C003C003C003C003C003C007C007C007C007C00FC00FC00FC00F
      C01FC01FC01FC01FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF001FC007C007C007000FFFFFFFFFFFFF0007C03FF83FF8070003
      FFFFFFFFFFFF0001C007C007C0070000FFFFFFFFFFFF001FC03FF01FF807001F
      FFFFFFFFFFFF001FC007C007C0078FFBFFFFFFFFFFFFFE3BC03FF83FF807FE77
      FFFFFFFFFFFFFE8FFFFFFFFFFFFFFFFFFE00FFFFFFFFFFFFFE00FFFFFFFFFFFF
      C000FFFFFFFFFFFF8000FFFFFFFFF0FF8000F00F81FFF9FF8000F8C7E3FFF9FF
      8000F8C7F1FFF9FF8000F8C7F8FFF91F8001F80FFC7FF9CF8003F8C7FE3FF9CF
      8007F8C7FF1FF9CF8007F8C7FF8FF98F8007F00FFF03F01F8007FFFFFFFFFFFF
      C00FFFFFFFFFFFFFFCFFFFFFFFFFFFFFFFFFFFFF87E1FC01C007FFFF33CCFC01
      8003FFFF3BDCFC010001FFFF9999FC010001FFFFC003FC010001FFF7F00F8001
      0000C1F7F81F80010000C3FBF81F80018000C7FBF00F8003C000CBFBE0078007
      E001DCF7C183800FE007FF0F83C1803FF007FFFF07E0803FF003FFFF0FF0807F
      F803FFFF1FF880FFFFFFFFFF3FFC81FFFC00FFFFFFFFFFFFF000FFFFFFFFC001
      C000C007001F80010000C007000F80010000C007000780010000C00700038001
      0000C007000180010000C007000080010000C007001F80010000C007001F8001
      0001C007001F80010003C0078FF180010007C00FFFF98001001FC01FFF758001
      007FC03FFF8F800101FFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object ActListMain: TActionList
    OnUpdate = ActListMainUpdate
    Left = 393
    Top = 140
    object EditCopyCmd: TEditCopy
      Tag = 3
      Category = 'Edit'
      Caption = '&Copy'
      Enabled = False
      Hint = 'Copy'
      ImageIndex = 7
      ShortCut = 16451
      OnExecute = EditCmdExecute
    end
    object EditCutCmd: TEditCut
      Tag = 2
      Category = 'Edit'
      Caption = 'Cu&t'
      Enabled = False
      Hint = 'Cut'
      ImageIndex = 6
      ShortCut = 16472
      OnExecute = EditCmdExecute
    end
    object EditPasteCmd: TEditPaste
      Tag = 4
      Category = 'Edit'
      Caption = '&Paste'
      Hint = 'Paste'
      ImageIndex = 8
      ShortCut = 16470
      OnExecute = EditCmdExecute
    end
    object FileNewCmd: TAction
      Category = 'File'
      Caption = '&Empty Form Container'
      Hint = 'New'
      ImageIndex = 1
      ShortCut = 49230
      OnExecute = FileNewDoc
    end
    object FileCloseCmd: TAction
      Tag = 13
      Category = 'File'
      Caption = '&Close'
      Hint = 'Close'
      ImageIndex = 15
      ShortCut = 16471
      OnExecute = FileCmdExecute
    end
    object FilePrintCmd: TAction
      Tag = 42
      Category = 'File'
      Caption = 'Print'
      Hint = 'Print'
      ImageIndex = 4
      ShortCut = 16464
      OnExecute = FileCmdExecute
    end
    object FormsLibraryCmd: TAction
      Category = 'Forms'
      Caption = '&Forms Library'
      Hint = 'Forms Library'
      ImageIndex = 0
      ShortCut = 16460
      OnExecute = FormsLibraryExecute
    end
    object FileOpenCmd: TAction
      Category = 'File'
      Caption = '&Open...'
      Hint = 'Open'
      ImageIndex = 2
      ShortCut = 16463
      OnExecute = FileOpenDoc
    end
    object FileSaveCmd: TAction
      Tag = 14
      Category = 'File'
      Caption = 'Save...'
      ImageIndex = 3
      ShortCut = 16467
      OnExecute = FileCmdExecute
    end
    object FilePrSetupCmd: TAction
      Category = 'File'
      Caption = 'Printer Setup...'
    end
    object FileExitCmd: TAction
      Category = 'File'
      Caption = '&Exit'
      ShortCut = 16465
      OnExecute = FileExitApp
    end
    object EditTxUnderLnCmd: TAction
      Tag = 13
      Category = 'Edit'
      Caption = 'Under Line'
      Hint = 'UnderLine'
      ImageIndex = 208
      ShortCut = 16469
      OnExecute = EditCmdExecute
    end
    object FormsArrangeCmd: TAction
      Tag = 20
      Category = 'Forms'
      Caption = 'Arrange Pages'
      OnExecute = FormsCmdExecute
    end
    object EditClearCmd: TAction
      Tag = 5
      Category = 'Edit'
      Caption = 'C&lear'
      ShortCut = 16430
      OnExecute = EditCmdExecute
    end
    object EditSelectAllCmd: TAction
      Tag = 6
      Category = 'Edit'
      Caption = 'Select All'
      ShortCut = 16449
      OnExecute = EditCmdExecute
    end
    object EditUndoCmd: TAction
      Tag = 1
      Category = 'Edit'
      Caption = 'Undo'
      Hint = 'Undo'
      ShortCut = 16474
      OnExecute = EditCmdExecute
    end
    object EditTxLeftCmd: TAction
      Tag = 7
      Category = 'Edit'
      Caption = 'Left'
      Hint = 'Align Left'
      ImageIndex = 12
      ShortCut = 49228
      OnExecute = EditCmdExecute
    end
    object EditTxCntrCmd: TAction
      Tag = 8
      Category = 'Edit'
      Caption = 'Center'
      Hint = 'Align Center'
      ImageIndex = 13
      ShortCut = 49219
      OnExecute = EditCmdExecute
    end
    object EditTxRightCmd: TAction
      Tag = 9
      Category = 'Edit'
      Caption = 'Right'
      Hint = 'Align Right'
      ImageIndex = 14
      ShortCut = 49234
      OnExecute = EditCmdExecute
    end
    object EditTxBoldCmd: TAction
      Tag = 11
      Category = 'Edit'
      Caption = 'Bold'
      Hint = 'Bold'
      ImageIndex = 9
      ShortCut = 16450
      OnExecute = EditCmdExecute
    end
    object EditTxItalicCmd: TAction
      Tag = 12
      Category = 'Edit'
      Caption = 'Italic'
      Hint = 'Italic'
      ImageIndex = 10
      ShortCut = 16457
      OnExecute = EditCmdExecute
    end
    object FileSaveAsCmd: TAction
      Tag = 15
      Category = 'File'
      Caption = 'Save &As...'
      OnExecute = FileCmdExecute
    end
    object FileExportCmd: TAction
      Tag = 16
      Category = 'File'
      Caption = 'Export'
      OnExecute = FileCmdExecute
    end
    object ViewExpandAllCmd: TAction
      Tag = 18
      Category = 'View'
      Caption = 'Expand All Pages'
      ShortCut = 114
      OnExecute = ViewCmdExecute
    end
    object ViewToglGoToListCmd: TAction
      Tag = 25
      Category = 'View'
      Caption = 'Show Forms Manager'
      Hint = 'Show/Hide Forms Manager'
      ImageIndex = 30
      ShortCut = 115
      OnExecute = ViewCmdExecute
    end
    object ViewCollapseAllCmd: TAction
      Tag = 19
      Category = 'View'
      Caption = 'Collapse All Pages'
      ShortCut = 8306
      OnExecute = ViewCmdExecute
    end
    object EditTxIncreaseCmd: TAction
      Tag = 1
      Category = 'Edit'
      Caption = 'Increase Font Size'
      Hint = 'Increase Font Size'
      ImageIndex = 21
      OnExecute = FontCmdExecute
    end
    object EditTxDecreaseCmd: TAction
      Tag = -1
      Category = 'Edit'
      Caption = 'Decrease Font Size'
      Hint = 'Decrease Font Size'
      ImageIndex = 22
      OnExecute = FontCmdExecute
    end
    object ToolStartDBCmd: TAction
      Tag = 5
      Category = 'Tools'
      Hint = 'Show Reports List'
      ImageIndex = 31
    end
    object FileCreatePDFCmd: TAction
      Tag = 43
      Category = 'File'
      Caption = 'Create Adobe PDF...'
      Hint = 'Create Adobe PDF'
      ImageIndex = 122
      OnExecute = FileCmdExecute
    end
    object FileSendMailCmd: TAction
      Tag = 31
      Category = 'File'
      Caption = 'Mail Recipient'
      OnExecute = FileSendCmdExecute
    end
    object FileSendMailAttachCLKCmd: TAction
      Tag = 28
      Category = 'File'
      Caption = 'Mail Recipient (as '#39'.clk'#39' Attachment)...'
      OnExecute = FileSendCmdExecute
    end
    object FileSendMailAttachPDFCmd: TAction
      Tag = 29
      Category = 'File'
      Caption = 'Mail Recipient (as PDF Attachment)...'
      Hint = 'Mail Recipient (as PDF Attachment)...'
      ImageIndex = 54
      OnExecute = FileSendCmdExecute
    end
    object FileSendFAXCmd: TAction
      Tag = 30
      Category = 'File'
      Caption = 'Fax Recipient'
      OnExecute = FileSendCmdExecute
    end
    object ServiceLocMapCmd: TAction
      Tag = 314
      Category = 'Services'
      Caption = 'Location Maps'
      Hint = 'Location Map Service'
      ImageIndex = 148
      OnExecute = ServiceCmdExecute
    end
    object ServiceFloodInsightCmd: TAction
      Tag = 302
      Category = 'Services'
      Caption = 'Flood Insights'
      Hint = 'Flood Maps'
      ImageIndex = 146
      OnExecute = ServiceCmdExecute
    end
    object InsertFileImageCmd: TAction
      Tag = 1
      Category = 'Insert'
      Caption = 'Insert Image from File'
      ImageIndex = 163
      ShortCut = 16455
      OnExecute = InsertCmdExecute
    end
    object InsertDeviceImageCmd: TAction
      Tag = 2
      Category = 'Insert'
      Caption = 'Insert Image from Device'
      OnExecute = InsertCmdExecute
    end
    object ListSaveCompsCmd: TAction
      Tag = 6
      Category = 'Lists'
      Caption = 'Save Subject and Comps...'
      Hint = 'Save Subejct and Comps to database'
      OnExecute = ListCmdExecute
    end
    object ToolSelectCmd: TAction
      Tag = 1
      Category = 'Tools'
      Caption = 'ToolSelectCmd'
      GroupIndex = 1
      Hint = 'Reposition Free Form Text'
      ImageIndex = 45
      OnExecute = AnnotateCmdExecute
    end
    object ToolFreeTextCmd: TAction
      Tag = 2
      Category = 'Tools'
      Caption = 'Free Form Text'
      GroupIndex = 1
      Hint = 'Free Form Text'
      ImageIndex = 35
      OnExecute = AnnotateCmdExecute
    end
    object CellPrefCmd: TAction
      Tag = 5
      Category = 'Cells'
      Caption = 'Cell &Preferences...'
      ShortCut = 24649
      OnExecute = CellCmdExecute
    end
    object FormsFindCmd: TAction
      Tag = 47
      Category = 'Forms'
      Caption = 'Find Forms...'
      OnExecute = FormsLibraryExecute
    end
    object ServiceUsageSummaryCmd: TAction
      Tag = 320
      Category = 'Services'
      Caption = 'Services &Usage Summary'
      Hint = 'Services Usage Summary'
      ImageIndex = 157
      OnExecute = ServiceCmdExecute
    end
    object CellSaveImageAsCmd: TAction
      Tag = 7
      Category = 'Cells'
      Caption = 'Save Image To File...'
      OnExecute = CellCmdExecute
    end
    object InsertPDFCmd: TAction
      Tag = 4
      Category = 'Insert'
      Caption = 'Insert from PDF File'
      Hint = 'Insert from PDF File'
      ImageIndex = 162
      OnExecute = InsertCmdExecute
    end
    object HelpCheckForUpdatesCmd: TAction
      Tag = 19
      Category = 'Help'
      Caption = 'Check For Updates'
      Hint = 'Check For Updates'
      ImageIndex = 128
      OnExecute = HelpCmdExecute
    end
    object ToolApps7Cmd: TAction
      Tag = 108
      Category = 'Tools'
      Caption = '&Image Editor...'
      OnExecute = ToolCmdExecute
    end
    object ListShowClientCmd: TAction
      Tag = 1
      Category = 'Lists'
      Caption = 'Show &Clients List...'
      ImageIndex = 51
      OnExecute = ListCmdPreExecute
    end
    object ListShowReportsCmd: TAction
      Tag = 2
      Category = 'Lists'
      Caption = 'Show &Reports List...'
      ImageIndex = 50
      OnExecute = ListCmdPreExecute
    end
    object ListShowNeighCmd: TAction
      Tag = 7
      Category = 'Lists'
      Caption = 'Show &Neighborhoods List...'
      ImageIndex = 48
      OnExecute = ListCmdPreExecute
    end
    object ListShowCompsCmd: TAction
      Tag = 4
      Category = 'Lists'
      Caption = 'Show &Comparables List...'
      ImageIndex = 49
      OnExecute = ListCmdPreExecute
    end
    object InsertTodaysDateCmd: TAction
      Tag = 5
      Category = 'Insert'
      Caption = 'Insert Todays Date'
      ShortCut = 16452
      SecondaryShortCuts.Strings = (
        '')
      OnExecute = InsertCmdExecute
    end
    object ServiceMarketAnalysis: TAction
      Tag = 312
      Category = 'Services'
      Caption = '1004MC Service'
      Hint = '1004MC Service|Connect with the 1004MC Market Analysis Service.'
      ImageIndex = 205
      OnExecute = ServiceCmdExecute
    end
    object ServiceMarshallandSwiftCmd: TAction
      Tag = 304
      Category = 'Services'
      Caption = 'Cost Analysis'
      Hint = 'Swift Estimator Cost Estimates'
      ImageIndex = 144
      OnExecute = ServiceCmdExecute
    end
    object ServiceGetCensusTractCmd: TAction
      Tag = 305
      Category = 'Services'
      Caption = 'Get Census Tract'
      Hint = 'Census Tract'
      ImageIndex = 143
      OnExecute = ServiceCmdExecute
    end
    object ServiceFileCenterCmd: TAction
      Tag = 309
      Category = 'Services'
      Caption = 'Online File Center'
      Hint = 'File Center'
      ImageIndex = 165
      Visible = False
      OnExecute = ServiceCmdExecute
    end
    object ServiceBackupCmd: TAction
      Tag = 307
      Category = 'Services'
      Caption = 'Online Backup'
      Hint = 'Online Backup'
      ImageIndex = 166
      Visible = False
      OnExecute = ServiceCmdExecute
    end
    object ToolSpellCmd: TAction
      Tag = 153
      Category = 'Tools'
      Caption = 'Spell Check Report'
      Hint = 'Spell Checker'
      ImageIndex = 153
      OnExecute = ToolCmdExecute
    end
    object ToolThesaurusCmd: TAction
      Tag = 102
      Category = 'Tools'
      Caption = 'Thesaurus'
      Hint = 'Thesaurus'
      ImageIndex = 154
      OnExecute = ToolCmdExecute
    end
    object ToolSignatureCmd: TAction
      Tag = 105
      Category = 'Tools'
      Caption = 'Signatures'
      Hint = 'Sign Report'
      ImageIndex = 152
      OnExecute = ToolCmdExecute
    end
    object ViewDisplayScaleCmd: TAction
      Tag = 24
      Category = 'View'
      Caption = 'ViewDisplayScaleCmd'
      ImageIndex = 114
      OnExecute = ViewCmdExecute
    end
    object ToolPhotoSheetCmd: TAction
      Tag = 103
      Category = 'Tools'
      Caption = 'PhotoSheet'
      Hint = 'PhotoSheet'
      ImageIndex = 125
      OnExecute = ToolCmdExecute
    end
    object ToolImageEditorCmd: TAction
      Tag = 108
      Category = 'Tools'
      Caption = 'Image Editor'
      Hint = 'Optimize Images'
      ImageIndex = 164
      OnExecute = ToolCmdExecute
    end
    object EditPreferencesCmd: TAction
      Tag = 48
      Category = 'Edit'
      Caption = 'Preferences'
      Hint = 'Preferences'
      ImageIndex = 149
      ShortCut = 16459
      OnExecute = EditCmdExecute
    end
    object ToolReviewerCmd: TAction
      Tag = 106
      Category = 'Tools'
      Caption = 'Reviewer'
      Hint = 'Reviewer'
      ImageIndex = 151
      OnExecute = ToolCmdExecute
    end
    object ToolCompEditorCmd: TAction
      Tag = 121
      Category = 'Tools'
      Caption = 'Comparables Editor'
      Hint = 'Comparables Editor'
      ImageIndex = 145
      OnExecute = ToolCmdExecute
    end
    object ToolAutoAdjustCmd: TAction
      Tag = 122
      Category = 'Tools'
      Caption = 'Auto Adjustments'
      Hint = 'Auto Adjustments'
      ImageIndex = 142
      OnExecute = ToolCmdExecute
    end
    object ToolClickNotesCmd: TAction
      Tag = 107
      Category = 'Tools'
      Caption = 'ClickNotes'
      Hint = 'ClickNotes'
      ImageIndex = 123
      OnExecute = ToolCmdExecute
    end
    object ToolMercuryCmd: TAction
      Tag = 325
      Category = 'Tools'
      Caption = 'Send to Mercury Network'
      ImageIndex = 156
      OnExecute = FileExportExecute
    end
    object ToolWinSketchCmd: TAction
      Tag = 201
      Category = 'Tools'
      Caption = 'WinSketch'
      Hint = 'WinSketch'
      ImageIndex = 136
      OnExecute = ToolCmdExecute
    end
    object ToolGeoLocatorCmd: TAction
      Tag = 202
      Category = 'Tools'
      Caption = 'GeoLocator'
      Hint = 'GeoLocator'
      ImageIndex = 135
      OnExecute = ToolCmdExecute
    end
    object ToolApexCmd: TAction
      Tag = 205
      Category = 'Tools'
      Caption = 'Apex'
      Hint = 'Apex'
      ImageIndex = 137
      OnExecute = ToolCmdExecute
    end
    object ToolRapidSketchCmd: TAction
      Tag = 208
      Category = 'Tools'
      Caption = 'RapidSketch'
      ImageIndex = 170
      OnExecute = ToolCmdExecute
    end
    object ToolAreaSketchSECmd: TAction
      Tag = 209
      Category = 'Tools'
      Caption = 'AreaSketch Special Edition'
      ImageIndex = 202
      OnExecute = ToolCmdExecute
    end
    object ToolAreaSketchCmd: TAction
      Tag = 207
      Category = 'Tools'
      Caption = 'AreaSketch'
      Hint = 'AreaSketch'
      ImageIndex = 133
      OnExecute = ToolCmdExecute
    end
    object ToolDelormeCmd: TAction
      Tag = 203
      Category = 'Tools'
      Caption = 'Delorme'
      Hint = 'Delorme'
      ImageIndex = 138
      OnExecute = ToolCmdExecute
    end
    object ToolStreetNTripCmd: TAction
      Tag = 204
      Category = 'Tools'
      Caption = 'Microsoft Streets N Trips'
      Hint = 'Microsoft Streets & Trips'
      ImageIndex = 139
      OnExecute = ToolCmdExecute
    end
    object ToolMapProCmd: TAction
      Tag = 206
      Category = 'Tools'
      Caption = 'MapPro'
      Hint = 'MapPro'
      ImageIndex = 141
      OnExecute = ToolCmdExecute
    end
    object ToolUser1Cmd: TAction
      Tag = 1
      Category = 'Tools'
      Caption = 'User Specified #1'
      Hint = 'User Specified #1'
      ImageIndex = 127
      OnExecute = ToolCmdExecute
    end
    object ToolUser2Cmd: TAction
      Tag = 2
      Category = 'Tools'
      Caption = 'User Specified #2'
      Hint = 'User Specified #2'
      ImageIndex = 127
      OnExecute = ToolCmdExecute
    end
    object ToolUser3Cmd: TAction
      Tag = 3
      Category = 'Tools'
      Caption = 'User Specified #3'
      Hint = 'User Specified #2'
      ImageIndex = 127
      OnExecute = ToolCmdExecute
    end
    object ToolUser4Cmd: TAction
      Tag = 4
      Category = 'Tools'
      Caption = 'User Specified #4'
      Hint = 'User Specified #4'
      ImageIndex = 127
      OnExecute = ToolCmdExecute
    end
    object ToolUser5Cmd: TAction
      Tag = 5
      Category = 'Tools'
      Caption = 'User Specified #5'
      Hint = 'User Specified #5'
      ImageIndex = 127
      OnExecute = ToolCmdExecute
    end
    object ToolUser6Cmd: TAction
      Tag = 6
      Category = 'Tools'
      Caption = 'User Specified #6'
      Hint = 'User Specified #6'
      ImageIndex = 127
      OnExecute = ToolCmdExecute
    end
    object ToolUser7Cmd: TAction
      Tag = 7
      Category = 'Tools'
      Caption = 'User Specified #7'
      Hint = 'User Specified #7'
      ImageIndex = 127
      OnExecute = ToolCmdExecute
    end
    object ToolUser8Cmd: TAction
      Tag = 8
      Category = 'Tools'
      Caption = 'User Specified #8'
      Hint = 'User Specified #8'
      ImageIndex = 127
      OnExecute = ToolCmdExecute
    end
    object ToolUser9Cmd: TAction
      Tag = 9
      Category = 'Tools'
      Caption = 'User Specified #9'
      Hint = 'User Specified #9'
      ImageIndex = 127
      OnExecute = ToolCmdExecute
    end
    object ToolUser10Cmd: TAction
      Tag = 10
      Category = 'Tools'
      Caption = 'User Specified #10'
      Hint = 'User Specified #10'
      ImageIndex = 127
      OnExecute = ToolCmdExecute
    end
    object ToolAIReadyCmd: TAction
      Tag = 2
      Category = 'Tools'
      Caption = 'Send to AppraisalPort'
      ImageIndex = 156
      OnExecute = FileExportExecute
    end
    object ToolSendCLK: TAction
      Tag = 28
      Category = 'Tools'
      Caption = 'Mail Recipient (as '#39'.clk'#39' Attachment)...'
      ImageIndex = 158
      OnExecute = FileSendCmdExecute
    end
    object ToolSendPDF: TAction
      Tag = 29
      Category = 'Tools'
      Caption = 'Mail Recipient (as PDF Attachment)...'
      ImageIndex = 122
      OnExecute = FileSendCmdExecute
    end
    object ServiceSentryCmd: TAction
      Tag = 311
      Category = 'Services'
      Caption = 'Appraisal Sentry'
      OnExecute = ServiceCmdExecute
    end
    object ServiceChatCmd: TAction
      Tag = 312
      Category = 'Services'
      Caption = 'Instant Customer Service...'
      OnExecute = ServiceCmdExecute
    end
    object HelpInstantServiceCmd: TAction
      Tag = 8
      Category = 'Help'
      Caption = 'Contact Technical Support.'
      ImageIndex = 58
      OnExecute = HelpCmdExecute
    end
    object OrderSendRELSCmd: TAction
      Tag = 5
      Category = 'Orders'
      Caption = 'Send Order to CLVS'
      ImageIndex = 156
      OnExecute = FileExportExecute
    end
    object OrderSendAIReadyCmd: TAction
      Tag = 2
      Category = 'Orders'
      Caption = 'OrderSendAIReadyCmd'
      ImageIndex = 156
      OnExecute = FileExportExecute
    end
    object OrderSendLighthouseCmd: TAction
      Tag = 1
      Category = 'Orders'
      Caption = 'OrderSendLighthouseCmd'
      ImageIndex = 156
      OnExecute = FileExportExecute
    end
    object HelpNewsDeskCmd: TAction
      Tag = 20
      Category = 'Help'
      Caption = 'News'
      Hint = 'Displays the latest news and services'
      ImageIndex = 108
      OnExecute = HelpCmdExecute
    end
    object HelpDBugExportCID: TAction
      Category = 'Help'
      Caption = 'Export Cell IDs to CSV'
      Hint = 'Export Cell IDs to CSV|Export cell IDs to  a CSV file.'
      OnExecute = HelpDBugExportCIDExecute
    end
    object HelpDBugExportCellData: TAction
      Category = 'Help'
      Caption = 'Export Cell Data to CSV'
      Hint = 'Export Cell Data to CSV|Export cell data to  a CSV file.'
      OnExecute = HelpDBugExportCellDataExecute
    end
    object HelpDBugFillContainer: TAction
      Category = 'Help'
      Caption = 'Fill Container'
      Hint = 
        'Fill Container|Fills the container with every form in the Forms ' +
        'Library.'
      OnExecute = HelpDBugFillContainerExecute
    end
    object CellCarryOverComments: TAction
      Category = 'Cells'
      Caption = '&Carry Over Comments'
      Hint = 'Carry Over Comments|Carry comments over to a comment addendum.'
      ImageIndex = 200
      ShortCut = 16473
      OnExecute = CellCarryOverCommentsExecute
      OnUpdate = CellCarryOverCommentsUpdate
    end
    object FileExportXSitesCmd: TAction
      Tag = 50
      Category = 'File'
      Caption = 'XSites'
      OnExecute = FileCmdExecute
      OnUpdate = FileExportXSitesCmdUpdate
    end
    object ServiceRELSMLSDataCmd: TAction
      Tag = 313
      Category = 'Services'
      Caption = 'DAA Data Set'
      ImageIndex = 169
      OnExecute = ServiceCmdExecute
    end
    object CellWPFonts: TAction
      Category = 'Cells'
      Caption = 'Font...'
      OnExecute = CellWPFontsExecute
      OnUpdate = CellWPFontsUpdate
    end
    object GoToPageNavigatorCmd: TAction
      Tag = -4
      Category = 'GoTo'
      Caption = 'Page Na&vigator'
      Hint = 'Page Navigator|Quickly navigate to  any page in the report.'
      ImageIndex = 209
      ShortCut = 16458
      OnExecute = GoToCmdExecute
    end
    object ServicePictometryCmd: TAction
      Tag = 315
      Category = 'Services'
      Caption = 'Pictometry Aerial Imagery'
      Hint = 'Pictometry Aerial Imagery'
      ImageIndex = 210
      OnExecute = ServiceCmdExecute
    end
    object ServiceUADPrefCmd: TAction
      Tag = 316
      Category = 'Services'
      Caption = 'UAD Preferences'
      OnExecute = ServiceCmdExecute
    end
    object FileCreateUADCmd: TAction
      Tag = 34
      Category = 'File'
      Caption = 'Create &UAD XML...'
      OnExecute = FileCmdExecute
    end
    object ServiceBuildfaxCmd: TAction
      Tag = 321
      Category = 'Services'
      Caption = 'BuildFax Permit History'
      ImageIndex = 211
      OnExecute = ServiceCmdExecute
    end
    object OrderSendValulinkXMLcmd: TAction
      Tag = 322
      Category = 'Orders'
      Caption = 'Send XML to Valulink'
      OnExecute = FileExportExecute
    end
    object OrderSendKyliptixXMLcmd: TAction
      Tag = 323
      Category = 'Orders'
      Caption = 'Send XML to Kyliptix'
      OnExecute = FileExportExecute
    end
    object OrderSendPCVCmd: TAction
      Tag = 324
      Category = 'Orders'
      Caption = 'Send Report to PCV'
      ImageIndex = 156
      Visible = False
      OnExecute = FileExportExecute
    end
    object CellUADDlg: TAction
      Tag = 8
      Category = 'Cells'
      Caption = 'CellUADDlg'
      ShortCut = 119
      OnExecute = CellCmdExecute
    end
    object ToolPhoenixSketchCmd: TAction
      Tag = 209
      Category = 'Tools'
      Caption = 'PhoenixSketch'
      ImageIndex = 214
      OnExecute = ToolCmdExecute
    end
    object ListCheckUADCmd: TAction
      Tag = 8
      Category = 'Lists'
      Caption = 'Check Comp Consistency...'
      OnExecute = ListCmdExecute
    end
    object ListShowAMCCmd: TAction
      Tag = 10
      Category = 'Lists'
      Caption = 'Show AMC List...'
      ImageIndex = 50
    end
    object ServicePhoenixMobileCmd: TAction
      Category = 'Services'
      Caption = 'PhoenixMobile Sync'
    end
    object ServiceAddressVerification: TAction
      Tag = 323
      Category = 'Services'
      Caption = 'Address Verification'
      ImageIndex = 216
      OnExecute = ServiceCmdExecute
    end
    object ServiceMLSImport: TAction
      Tag = 327
      Category = 'Services'
      Caption = 'MLS Import Wizard'
      ImageIndex = 160
      OnExecute = ServiceCmdExecute
    end
    object NewOrdersCmd: TAction
      Tag = 1
      Category = 'Orders'
      Caption = 'New Orders'
      ImageIndex = 230
      OnExecute = OrdersCmdExecute
    end
    object OrderSendMercuryCmd: TAction
      Tag = 325
      Category = 'Orders'
      Caption = 'Send Report to MercuryNetwork'
      ImageIndex = 156
      OnExecute = FileExportExecute
    end
    object OrderManagerAll: TAction
      Tag = 27
      Category = 'Orders'
      Caption = 'Manage All Orders'
      ImageIndex = 34
      OnExecute = OrdersCmdExecute
    end
    object FileSaveToDropboxCmd: TAction
      Tag = 52
      Category = 'File'
      Caption = 'Save to Dopbox'
      ImageIndex = 231
      OnExecute = FileCmdExecute
    end
    object FileOpenDropboxCmd: TAction
      Category = 'File'
      Caption = 'Open from Dropbox'
      OnExecute = FileOpenDropboxDoc
    end
    object HelpAppraisalWorld: TAction
      Tag = 24
      Category = 'Help'
      Caption = 'AppraisalWorld'
      ImageIndex = 167
      OnExecute = HelpCmdExecute
    end
    object OrdersSendEADcmd: TAction
      Tag = 326
      Category = 'Orders'
      Caption = 'OrdersSendEADcmd'
      ImageIndex = 156
      OnExecute = FileExportExecute
    end
    object ServiceLPSBlackKnightsCmd: TAction
      Tag = 328
      Category = 'Services'
      Caption = 'Black Knights LPS Public Data'
      ImageIndex = 232
      OnExecute = ServiceCmdExecute
    end
    object OrderSendVeptasCmd: TAction
      Tag = 327
      Category = 'Orders'
      Caption = 'OrderSendVeptasCmd'
      ImageIndex = 156
      OnExecute = FileExportExecute
    end
  end
  object OpenDialog: TOpenDialog
    Left = 104
    Top = 152
  end
  object SaveDialog: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofExtensionDifferent, ofEnableSizing]
    Title = 'Save Report As'
    Left = 168
    Top = 128
  end
  object PrintDialog: TPrintDialog
    Left = 200
    Top = 128
  end
  object BlinkTimer: TTimer
    Interval = 60
    OnTimer = BlinkEvent
    Left = 44
    Top = 264
  end
  object WelcomeTimer: TTimer
    Enabled = False
    Interval = 4000
    OnTimer = WelcomeTimerTimer
    Left = 116
    Top = 265
  end
  object SaveImageDialog: TMMSaveDialog
    Filter = 
      'All Supported Media Formats|*.BMP;*.CMS;*.GIF;*.JPG;*.PCX;*.PNG;' +
      '*.SCM;*.TIF;*.PCD;*.EMF;*.WMF;*.TGA;*.WAV;*.MID;*.RMI;*.AVI;*.MO' +
      'V;|Windows Bitmap    (BMP) |*.BMP|Credit Message    (CMS) |*.CMS' +
      '|Compuserve Gif    (GIF) |*.GIF|Jpeg    (JPG) |*.JPG|PaintShop P' +
      'ro    (PCX) |*.PCX|Portable Graphics    (PNG) |*.PNG|Scrolling M' +
      'essage    (SCM) |*.SCM|Tagged Image    (TIF) |*.TIF|Kodak Photo ' +
      'CD    (PCD) |*.PCD|Windows Metafile    (WMF) |*.WMF|Enhanced Met' +
      'afile    (EMF) |*.EMF|Targe Image    (TGA) |*.TGA|Wave Sound    ' +
      '(WAV) |*.WAV|Midi Sound    (MID) |*.MID|RMI Sound    (RMI) |*.RM' +
      'I|Video for Windows    (AVI) |*.AVI|Apple Quicktime Video    (MO' +
      'V) |*.MOV'
    Options = [ofOverwritePrompt, ofEnableSizing]
    PreviewBtnHint = 'Enable/Disable preview of selected file'
    TiffFirstHint = 'First Tif Page'
    TiffNextHint = 'Next Tif Page'
    TiffPrior = 'Prior Tif Page'
    TiffLast = 'Last Tif Page'
    TiffSelectedPage = 0
    Left = 40
    Top = 152
  end
  object OpenImageDialog: TMMOpenDialog
    Filter = 
      'All Supported Media Formats|*.BMP;*.CMS;*.GIF;*.JPG;*.JEPG;*.PCX' +
      ';*.PNG;*.SCM;*.TIF;*.TIFF;*.PCD;*.EMF;*.WMF;*.TGA;*.WAV;*.MID;*.' +
      'RMI;*.AVI;*.MOV;|Windows Bitmap    (BMP) |*.BMP|Credit Message  ' +
      '  (CMS) |*.CMS|Compuserve Gif    (GIF) |*.GIF|Jpeg    (JPG;JEPG)' +
      ' |*.JPG;*.JEPG|PaintShop Pro    (PCX) |*.PCX|Portable Graphics  ' +
      '  (PNG) |*.PNG|Scrolling Message    (SCM) |*.SCM|Tagged Image   ' +
      ' (TIF;TIFF) |*.TIF;*TIFF|Kodak Photo CD    (PCD) |*.PCD|Windows ' +
      'Metafile    (WMF) |*.WMF|Enhanced Metafile    (EMF) |*.EMF|Targe' +
      ' Image    (TGA) |*.TGA|Wave Sound    (WAV) |*.WAV|Midi Sound    ' +
      '(MID) |*.MID|RMI Sound    (RMI) |*.RMI|Video for Windows    (AVI' +
      ') |*.AVI|Apple Quicktime Video    (MOV) |*.MOV'
    PreviewBtnHint = 'Enable/Disable preview of selected file'
    TiffFirstHint = 'First Tif Page'
    TiffNextHint = 'Next Tif Page'
    TiffPrior = 'Prior Tif Page'
    TiffLast = 'Last Tif Page'
    TiffSelectedPage = 0
    Left = 72
    Top = 152
  end
  object Thesaurus: TThesaurus3
    Filename = '%AppDir%\Roget.adt'
    SortedLists = False
    DoubleClickAction = dcaLookup
    UILanguage = ltEnglish
    CommandsEnabled = [tdcLookedUp, tdcPrevious, tdcLookup, tdcReplace, tdcClose]
    CommandsVisible = [tdcLookedUp, tdcPrevious, tdcLookup, tdcReplace, tdcClose]
    HelpCtxThesaurusDialog = 0
    Left = 80
    Top = 112
  end
  object IdAntiFreeze1: TIdAntiFreeze
    Left = 168
    Top = 88
  end
  object ToolBarStyle: TAdvToolBarOfficeStyler
    AdvMenuStyler = MainMenuStyle
    AutoThemeAdapt = True
    BorderColor = 9671313
    BorderColorHot = 14731181
    ButtonAppearance.Color = 16640730
    ButtonAppearance.ColorTo = 14986888
    ButtonAppearance.ColorChecked = 9229823
    ButtonAppearance.ColorCheckedTo = 5812223
    ButtonAppearance.ColorDown = 5149182
    ButtonAppearance.ColorDownTo = 9556991
    ButtonAppearance.ColorHot = 13432063
    ButtonAppearance.ColorHotTo = 9556223
    ButtonAppearance.BorderDownColor = clNavy
    ButtonAppearance.BorderHotColor = clNavy
    ButtonAppearance.BorderCheckedColor = clNavy
    ButtonAppearance.CaptionFont.Charset = DEFAULT_CHARSET
    ButtonAppearance.CaptionFont.Color = clWindowText
    ButtonAppearance.CaptionFont.Height = -11
    ButtonAppearance.CaptionFont.Name = 'MS Sans Serif'
    ButtonAppearance.CaptionFont.Style = []
    CaptionAppearance.CaptionColor = clHighlight
    CaptionAppearance.CaptionColorTo = clHighlight
    CaptionAppearance.CaptionBorderColor = clHighlight
    CaptionAppearance.CaptionColorHot = 13432063
    CaptionAppearance.CaptionColorHotTo = 9556223
    CaptionAppearance.CaptionTextColorHot = clBlack
    CaptionFont.Charset = DEFAULT_CHARSET
    CaptionFont.Color = clWindowText
    CaptionFont.Height = -11
    CaptionFont.Name = 'MS Sans Serif'
    CaptionFont.Style = []
    ContainerAppearance.LineColor = clBtnShadow
    ContainerAppearance.Line3D = True
    Color.Color = 16640730
    Color.ColorTo = 14986888
    Color.Direction = gdVertical
    Color.Steps = 16
    ColorHot.Color = 16773606
    ColorHot.ColorTo = 16444126
    ColorHot.Direction = gdVertical
    CompactGlowButtonAppearance.BorderColor = 14727579
    CompactGlowButtonAppearance.BorderColorHot = 10079963
    CompactGlowButtonAppearance.BorderColorDown = 4548219
    CompactGlowButtonAppearance.BorderColorChecked = 4548219
    CompactGlowButtonAppearance.Color = 15653832
    CompactGlowButtonAppearance.ColorTo = 16178633
    CompactGlowButtonAppearance.ColorChecked = 11918331
    CompactGlowButtonAppearance.ColorCheckedTo = 7915518
    CompactGlowButtonAppearance.ColorDisabled = 15921906
    CompactGlowButtonAppearance.ColorDisabledTo = 15921906
    CompactGlowButtonAppearance.ColorDown = 7778289
    CompactGlowButtonAppearance.ColorDownTo = 4296947
    CompactGlowButtonAppearance.ColorHot = 15465983
    CompactGlowButtonAppearance.ColorHotTo = 11332863
    CompactGlowButtonAppearance.ColorMirror = 15586496
    CompactGlowButtonAppearance.ColorMirrorTo = 16245200
    CompactGlowButtonAppearance.ColorMirrorHot = 5888767
    CompactGlowButtonAppearance.ColorMirrorHotTo = 10807807
    CompactGlowButtonAppearance.ColorMirrorDown = 946929
    CompactGlowButtonAppearance.ColorMirrorDownTo = 5021693
    CompactGlowButtonAppearance.ColorMirrorChecked = 10480637
    CompactGlowButtonAppearance.ColorMirrorCheckedTo = 5682430
    CompactGlowButtonAppearance.ColorMirrorDisabled = 11974326
    CompactGlowButtonAppearance.ColorMirrorDisabledTo = 15921906
    CompactGlowButtonAppearance.GradientHot = ggVertical
    CompactGlowButtonAppearance.GradientMirrorHot = ggVertical
    CompactGlowButtonAppearance.GradientDown = ggVertical
    CompactGlowButtonAppearance.GradientMirrorDown = ggVertical
    CompactGlowButtonAppearance.GradientChecked = ggVertical
    DockColor.Color = 16105376
    DockColor.ColorTo = 16440004
    DockColor.Direction = gdHorizontal
    DockColor.Steps = 128
    FloatingWindowBorderColor = 9516288
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    GlowButtonAppearance.BorderColor = 14727579
    GlowButtonAppearance.BorderColorHot = 10079963
    GlowButtonAppearance.BorderColorDown = 4548219
    GlowButtonAppearance.BorderColorChecked = 4548219
    GlowButtonAppearance.Color = 15653832
    GlowButtonAppearance.ColorTo = 16178633
    GlowButtonAppearance.ColorChecked = 11918331
    GlowButtonAppearance.ColorCheckedTo = 7915518
    GlowButtonAppearance.ColorDisabled = 15921906
    GlowButtonAppearance.ColorDisabledTo = 15921906
    GlowButtonAppearance.ColorDown = 7778289
    GlowButtonAppearance.ColorDownTo = 4296947
    GlowButtonAppearance.ColorHot = 15465983
    GlowButtonAppearance.ColorHotTo = 11332863
    GlowButtonAppearance.ColorMirror = 15586496
    GlowButtonAppearance.ColorMirrorTo = 16245200
    GlowButtonAppearance.ColorMirrorHot = 5888767
    GlowButtonAppearance.ColorMirrorHotTo = 10807807
    GlowButtonAppearance.ColorMirrorDown = 946929
    GlowButtonAppearance.ColorMirrorDownTo = 5021693
    GlowButtonAppearance.ColorMirrorChecked = 10480637
    GlowButtonAppearance.ColorMirrorCheckedTo = 5682430
    GlowButtonAppearance.ColorMirrorDisabled = 11974326
    GlowButtonAppearance.ColorMirrorDisabledTo = 15921906
    GlowButtonAppearance.GradientHot = ggVertical
    GlowButtonAppearance.GradientMirrorHot = ggVertical
    GlowButtonAppearance.GradientDown = ggVertical
    GlowButtonAppearance.GradientMirrorDown = ggVertical
    GlowButtonAppearance.GradientChecked = ggVertical
    GroupAppearance.BorderColor = 12763842
    GroupAppearance.Color = 16640730
    GroupAppearance.ColorTo = 15851212
    GroupAppearance.ColorMirror = 15851212
    GroupAppearance.ColorMirrorTo = 16640730
    GroupAppearance.Font.Charset = DEFAULT_CHARSET
    GroupAppearance.Font.Color = clWindowText
    GroupAppearance.Font.Height = -11
    GroupAppearance.Font.Name = 'Tahoma'
    GroupAppearance.Font.Style = []
    GroupAppearance.Gradient = ggVertical
    GroupAppearance.GradientMirror = ggVertical
    GroupAppearance.TextColor = clBlack
    GroupAppearance.CaptionAppearance.CaptionColor = 15915714
    GroupAppearance.CaptionAppearance.CaptionColorTo = 15784385
    GroupAppearance.CaptionAppearance.CaptionTextColor = clBlack
    GroupAppearance.CaptionAppearance.CaptionColorHot = 16769224
    GroupAppearance.CaptionAppearance.CaptionColorHotTo = 16772566
    GroupAppearance.CaptionAppearance.CaptionTextColorHot = clBlack
    GroupAppearance.PageAppearance.BorderColor = 12763842
    GroupAppearance.PageAppearance.Color = 14086910
    GroupAppearance.PageAppearance.ColorTo = 16382457
    GroupAppearance.PageAppearance.ColorMirror = 16382457
    GroupAppearance.PageAppearance.ColorMirrorTo = 16382457
    GroupAppearance.PageAppearance.Gradient = ggVertical
    GroupAppearance.PageAppearance.GradientMirror = ggVertical
    GroupAppearance.TabAppearance.BorderColor = clHighlight
    GroupAppearance.TabAppearance.BorderColorHot = clHighlight
    GroupAppearance.TabAppearance.BorderColorSelected = 10534860
    GroupAppearance.TabAppearance.BorderColorSelectedHot = 10534860
    GroupAppearance.TabAppearance.BorderColorDisabled = clNone
    GroupAppearance.TabAppearance.BorderColorDown = clNone
    GroupAppearance.TabAppearance.Color = clBtnFace
    GroupAppearance.TabAppearance.ColorTo = clWhite
    GroupAppearance.TabAppearance.ColorSelected = 10412027
    GroupAppearance.TabAppearance.ColorSelectedTo = 12249340
    GroupAppearance.TabAppearance.ColorDisabled = clNone
    GroupAppearance.TabAppearance.ColorDisabledTo = clNone
    GroupAppearance.TabAppearance.ColorHot = 13432063
    GroupAppearance.TabAppearance.ColorHotTo = 13432063
    GroupAppearance.TabAppearance.ColorMirror = clWhite
    GroupAppearance.TabAppearance.ColorMirrorTo = clWhite
    GroupAppearance.TabAppearance.ColorMirrorHot = 13432063
    GroupAppearance.TabAppearance.ColorMirrorHotTo = 9556223
    GroupAppearance.TabAppearance.ColorMirrorSelected = 12249340
    GroupAppearance.TabAppearance.ColorMirrorSelectedTo = 13955581
    GroupAppearance.TabAppearance.ColorMirrorDisabled = clNone
    GroupAppearance.TabAppearance.ColorMirrorDisabledTo = clNone
    GroupAppearance.TabAppearance.Font.Charset = DEFAULT_CHARSET
    GroupAppearance.TabAppearance.Font.Color = clWindowText
    GroupAppearance.TabAppearance.Font.Height = -11
    GroupAppearance.TabAppearance.Font.Name = 'Tahoma'
    GroupAppearance.TabAppearance.Font.Style = []
    GroupAppearance.TabAppearance.Gradient = ggVertical
    GroupAppearance.TabAppearance.GradientMirror = ggVertical
    GroupAppearance.TabAppearance.GradientHot = ggVertical
    GroupAppearance.TabAppearance.GradientMirrorHot = ggVertical
    GroupAppearance.TabAppearance.GradientSelected = ggVertical
    GroupAppearance.TabAppearance.GradientMirrorSelected = ggVertical
    GroupAppearance.TabAppearance.GradientDisabled = ggVertical
    GroupAppearance.TabAppearance.GradientMirrorDisabled = ggVertical
    GroupAppearance.TabAppearance.TextColor = clBlack
    GroupAppearance.TabAppearance.TextColorHot = clBlack
    GroupAppearance.TabAppearance.TextColorSelected = clBlack
    GroupAppearance.TabAppearance.TextColorDisabled = clWhite
    GroupAppearance.ToolBarAppearance.BorderColor = 13423059
    GroupAppearance.ToolBarAppearance.BorderColorHot = 13092807
    GroupAppearance.ToolBarAppearance.Color.Color = 15530237
    GroupAppearance.ToolBarAppearance.Color.ColorTo = 16382457
    GroupAppearance.ToolBarAppearance.Color.Direction = gdHorizontal
    GroupAppearance.ToolBarAppearance.ColorHot.Color = 15660277
    GroupAppearance.ToolBarAppearance.ColorHot.ColorTo = 16645114
    GroupAppearance.ToolBarAppearance.ColorHot.Direction = gdHorizontal
    PageAppearance.BorderColor = 14922381
    PageAppearance.Color = 16640730
    PageAppearance.ColorTo = 16440004
    PageAppearance.ColorMirror = 16440004
    PageAppearance.ColorMirrorTo = 16440004
    PageAppearance.Gradient = ggVertical
    PageAppearance.GradientMirror = ggVertical
    PagerCaption.BorderColor = 15780526
    PagerCaption.Color = 14986888
    PagerCaption.ColorTo = 14986888
    PagerCaption.ColorMirror = 14986888
    PagerCaption.ColorMirrorTo = 14986888
    PagerCaption.Gradient = ggVertical
    PagerCaption.GradientMirror = ggVertical
    PagerCaption.TextColor = clBlue
    PagerCaption.Font.Charset = DEFAULT_CHARSET
    PagerCaption.Font.Color = clWindowText
    PagerCaption.Font.Height = -11
    PagerCaption.Font.Name = 'Tahoma'
    PagerCaption.Font.Style = []
    RightHandleColor = 15836789
    RightHandleColorTo = 9516288
    RightHandleColorHot = 13891839
    RightHandleColorHotTo = 7782911
    RightHandleColorDown = 557032
    RightHandleColorDownTo = 8182519
    TabAppearance.BorderColor = clNone
    TabAppearance.BorderColorHot = clHighlight
    TabAppearance.BorderColorSelected = 14922381
    TabAppearance.BorderColorSelectedHot = 6343929
    TabAppearance.BorderColorDisabled = clNone
    TabAppearance.BorderColorDown = clNone
    TabAppearance.Color = clBtnFace
    TabAppearance.ColorTo = clWhite
    TabAppearance.ColorSelected = 16709360
    TabAppearance.ColorSelectedTo = 16445929
    TabAppearance.ColorDisabled = clWhite
    TabAppearance.ColorDisabledTo = clSilver
    TabAppearance.ColorHot = 13432063
    TabAppearance.ColorHotTo = 13432063
    TabAppearance.ColorMirror = clWhite
    TabAppearance.ColorMirrorTo = clWhite
    TabAppearance.ColorMirrorHot = 13432063
    TabAppearance.ColorMirrorHotTo = 9556223
    TabAppearance.ColorMirrorSelected = 16445929
    TabAppearance.ColorMirrorSelectedTo = 16181984
    TabAppearance.ColorMirrorDisabled = clWhite
    TabAppearance.ColorMirrorDisabledTo = clSilver
    TabAppearance.Font.Charset = DEFAULT_CHARSET
    TabAppearance.Font.Color = clWindowText
    TabAppearance.Font.Height = -11
    TabAppearance.Font.Name = 'Tahoma'
    TabAppearance.Font.Style = []
    TabAppearance.Gradient = ggVertical
    TabAppearance.GradientMirror = ggVertical
    TabAppearance.GradientHot = ggVertical
    TabAppearance.GradientMirrorHot = ggVertical
    TabAppearance.GradientSelected = ggVertical
    TabAppearance.GradientMirrorSelected = ggVertical
    TabAppearance.GradientDisabled = ggVertical
    TabAppearance.GradientMirrorDisabled = ggVertical
    TabAppearance.TextColor = clBlack
    TabAppearance.TextColorHot = clBlack
    TabAppearance.TextColorSelected = clBlack
    TabAppearance.TextColorDisabled = clGray
    TabAppearance.BackGround.Color = 14986888
    TabAppearance.BackGround.ColorTo = 16440004
    TabAppearance.BackGround.Direction = gdVertical
    Left = 288
    Top = 256
  end
  object PopupStartTemps: TAdvPopupMenu
    MenuStyler = MainMenuStylePopUp
    Version = '2.5.0.0'
    Left = 488
    Top = 88
    object N3: TMenuItem
      Caption = '-'
      Enabled = False
    end
    object popTmpFilesChgList: TMenuItem
      Tag = -1
      Caption = 'Modify List...'
      OnClick = TmpFilesListClick
    end
  end
  object PopupMapLabels: TAdvPopupMenu
    Images = MainImages
    MenuStyler = MainMenuStylePopUp
    Version = '2.5.0.0'
    Left = 488
    Top = 143
    object RedMapLabel1: TMenuItem
      Tag = 1
      Caption = 'Red Map Label'
      GroupIndex = 2
      Hint = 'Make Map Label Red'
      ImageIndex = 40
      OnClick = popMapLabelColorClick
    end
    object popMapLYellow: TMenuItem
      Tag = 2
      Caption = 'Yellow Map Label'
      GroupIndex = 2
      Hint = 'Make Map Label Yellow'
      ImageIndex = 39
      OnClick = popMapLabelColorClick
    end
    object popMapLWhite: TMenuItem
      Tag = 3
      Caption = 'White Map Label'
      GroupIndex = 2
      Hint = 'Make Map Label White'
      ImageIndex = 41
      OnClick = popMapLabelColorClick
    end
  end
  object PopupDatabases: TAdvPopupMenu
    Images = MainImages
    MenuStyler = MainMenuStylePopUp
    Version = '2.5.0.0'
    Left = 584
    Top = 88
    object popShowComparables: TMenuItem
      Tag = 4
      Action = ListShowCompsCmd
    end
    object popShowClients: TMenuItem
      Tag = 3
      Action = ListShowClientCmd
    end
    object popShowReports: TMenuItem
      Tag = 2
      Action = ListShowReportsCmd
    end
    object popShowNeighborhoods: TMenuItem
      Tag = 7
      Action = ListShowNeighCmd
    end
    object popCheckUAD: TMenuItem
      Action = ListCheckUADCmd
    end
  end
  object MainMenu: TAdvMainMenu
    Images = MainImages
    MenuStyler = MainMenuStyle
    Version = '2.5.0.0'
    Left = 392
    Top = 88
    object FileMenu: TMenuItem
      Caption = '&File'
      Hint = 'File related commands'
      OnClick = FileMenuClick
      object FileNewMItem: TMenuItem
        Caption = '&New'
        Hint = 'New'
        ImageIndex = 1
        object AddressVerification2: TMenuItem
          Caption = 'Report From Address Verification'
          ImageIndex = 216
          OnClick = AddressVerification2Click
        end
        object FileConfigRptSMItem: TMenuItem
          Caption = '&Report from Template...'
          ShortCut = 16462
          OnClick = NewTemplateClick
        end
        object FileNewBlankSMItem: TMenuItem
          Action = FileNewCmd
        end
      end
      object FileNewPropValMItem: TMenuItem
        Caption = 'New Appraisal...'
        Visible = False
        OnClick = FileNewPropValMItemClick
      end
      object NewAppraisalOrder1: TMenuItem
        Caption = 'New Appraisal Order...'
        ImageIndex = 156
        Visible = False
      end
      object FileOpenMItem: TMenuItem
        Action = FileOpenCmd
      end
      object FileOpenDropboxMItem: TMenuItem
        Caption = 'Open from Dropbox'
        ImageIndex = 231
        OnClick = FileOpenDropboxDoc
      end
      object FileOpenAsClone: TMenuItem
        Caption = 'Ope&n As Clone'
        OnClick = FileOpenAsCloneClick
      end
      object FileOpenTBxFilesMItem: TMenuItem
        Caption = 'Open ToolBo&x Files'
        object FileOpenTBxReportSMitem: TMenuItem
          Tag = 1
          Caption = 'ToolBox &Report...'
          ShortCut = 24655
          OnClick = FileCmdToolBoxExecute
        end
        object FileOpenTBxTemplateSMItem: TMenuItem
          Tag = 2
          Caption = 'ToolBox &Template...'
          OnClick = FileCmdToolBoxExecute
        end
        object FileTBxDividerMItem: TMenuItem
          Caption = '-'
        end
        object FileTBxConverterMItem: TMenuItem
          Tag = 14
          Caption = 'ToolBox &Converter'
          OnClick = FileCmdToolBoxExecute
        end
      end
      object FileOpenRecentMItem: TMenuItem
        Caption = 'Open &Recent Files'
        object FileMRU1: TMenuItem
          OnClick = OpenMRUClick
        end
        object FileMRU2: TMenuItem
          OnClick = OpenMRUClick
        end
        object FileMRU3: TMenuItem
          OnClick = OpenMRUClick
        end
        object FileMRU4: TMenuItem
          OnClick = OpenMRUClick
        end
        object FileMRU5: TMenuItem
          OnClick = OpenMRUClick
        end
        object FileMRU6: TMenuItem
          OnClick = OpenMRUClick
        end
        object FileMRU7: TMenuItem
          OnClick = OpenMRUClick
        end
        object FileMRU8: TMenuItem
          OnClick = OpenMRUClick
        end
        object FileMRU9: TMenuItem
          OnClick = OpenMRUClick
        end
        object FileMRU10: TMenuItem
          OnClick = OpenMRUClick
        end
      end
      object FileCloseMItem: TMenuItem
        Action = FileCloseCmd
      end
      object FileDivider1: TMenuItem
        Caption = '-'
        Enabled = False
      end
      object FileSaveMItem: TMenuItem
        Action = FileSaveCmd
      end
      object FileSaveAsMItem: TMenuItem
        Action = FileSaveAsCmd
      end
      object FileSaveToDropboxMItem: TMenuItem
        Tag = 52
        Action = FileSaveToDropboxCmd
        Caption = 'Save to Dropbox'
      end
      object FileSaveAsTmpMItem: TMenuItem
        Tag = 27
        Caption = 'Save As &Template...'
        OnClick = FileCmdExecute
      end
      object FileDivider2: TMenuItem
        Caption = '-'
        Enabled = False
      end
      object FileCreatePDFMItem: TMenuItem
        Action = FileCreatePDFCmd
      end
      object FileDeliverAppraisalMItem: TMenuItem
        Tag = 34
        Action = FileCreateUADCmd
        Caption = '&Deliver Appraisal'
      end
      object FileCreateReportMItem: TMenuItem
        Tag = 8
        Caption = 'Send Appraisal Report...'
        ImageIndex = 213
        OnClick = FileExportExecute
      end
      object FileDivider7: TMenuItem
        Caption = '-'
        Enabled = False
      end
      object FilePrintMItem: TMenuItem
        Action = FilePrintCmd
      end
      object FIleDivider6: TMenuItem
        Caption = '-'
        Enabled = False
      end
      object FileSendMItem: TMenuItem
        Caption = 'Sen&d To'
        ImageIndex = 54
        object FileSendMailMItem: TMenuItem
          Action = FileSendMailCmd
          ImageIndex = 54
        end
        object FileSendMailAttchPDFMItem: TMenuItem
          Action = FileSendMailAttachPDFCmd
          ImageIndex = 122
        end
        object FileSendMailAttachCLKMItem: TMenuItem
          Action = FileSendMailAttachCLKCmd
          ImageIndex = 158
        end
        object FileSendFaxMItem: TMenuItem
          Tag = 30
          Action = FileSendFAXCmd
        end
        object FileSendDivider: TMenuItem
          Caption = '-'
          Visible = False
        end
        object FileSendCustomEMail: TMenuItem
          Tag = 32
          Caption = 'CustomEmail'
          Visible = False
          OnClick = FileSendCmdExecute
        end
      end
      object FileExportMItem: TMenuItem
        Tag = 16
        Action = FileExportCmd
        Caption = 'Export To'
        object FileExportLighthouseSMItem: TMenuItem
          Tag = 1
          Caption = 'LH Format'
          ImageIndex = 156
          Visible = False
          OnClick = FileExportExecute
        end
        object FileExportAIReadySMItem: TMenuItem
          Tag = 2
          Caption = 'Appraisal Port'
          ImageIndex = 156
          OnClick = FileExportExecute
        end
        object XSites: TMenuItem
          Action = FileExportXSitesCmd
        end
        object ExportTextFileSMItem: TMenuItem
          Tag = 3
          Caption = 'ClickFORMS Text File...'
          OnClick = FileExportExecute
        end
      end
      object FileImportMItem: TMenuItem
        Caption = '&Import From'
        object FileImportVendorDataSMItem: TMenuItem
          Tag = 34
          Caption = 'Vendor Property Data'
          OnClick = FileImportExecute
        end
        object FileImportMLSDataSMItem: TMenuItem
          Tag = 36
          Caption = 'MLS Property Data'
          Visible = False
          OnClick = FileImportExecute
        end
        object FileImportCFTextMItem: TMenuItem
          Tag = 35
          Caption = 'ClickFORMS Text File'
          OnClick = FileImportExecute
        end
        object UnitedSystemTextFile1: TMenuItem
          Tag = 38
          Caption = 'United System Text File'
          OnClick = FileImportExecute
        end
        object FileImportWizard: TMenuItem
          Tag = 42
          Caption = 'Data Import Wizard'
          OnClick = FileImportExecute
        end
        object FileImportMLS: TMenuItem
          Tag = 44
          Caption = 'Data Import Wizard'
          OnClick = FileImportExecute
        end
        object FileImportMismoXML: TMenuItem
          Tag = 43
          Caption = 'MISMO XML File'
          OnClick = FileImportExecute
        end
      end
      object FileMergeMItem: TMenuItem
        Caption = '&Merge Files...'
        OnClick = FileMergeCmdExecute
      end
      object FileConvertMItem: TMenuItem
        Caption = 'Convert MISMO XMLs to CLK'
        OnClick = FileConvertMismoXmlClick
      end
      object FileDivider5: TMenuItem
        Caption = '-'
      end
      object FilePropertiesMItem: TMenuItem
        Tag = 41
        Caption = 'P&roperties...'
        OnClick = FileCmdExecute
      end
      object FileDivider4: TMenuItem
        Caption = '-'
        Enabled = False
      end
      object FileExitMItem: TMenuItem
        Tag = 44
        Action = FileExitCmd
      end
    end
    object EditMenu: TMenuItem
      Caption = '&Edit'
      Hint = 'Edit commands'
      OnClick = EditMenuClick
      object EditUndoItem: TMenuItem
        Action = EditUndoCmd
      end
      object EditCutMItem: TMenuItem
        Action = EditCutCmd
      end
      object EditCopyItem: TMenuItem
        Action = EditCopyCmd
      end
      object EditPasteItem: TMenuItem
        Action = EditPasteCmd
      end
      object PasteRedstoneData1: TMenuItem
        Caption = 'Paste &Redstone Analysis'
        ImageIndex = 85
        OnClick = PasteRedstoneData1Click
      end
      object EditClearItem: TMenuItem
        Action = EditClearCmd
      end
      object EditDivider3: TMenuItem
        Caption = '-'
        Enabled = False
        Visible = False
      end
      object EditCompsMItem: TMenuItem
        Tag = 45
        Caption = 'Edit C&omparables...'
        ImageIndex = 145
        ShortCut = 16453
        Visible = False
        OnClick = EditCmdExecute
      end
      object EditAdjustmentMItem: TMenuItem
        Tag = 46
        Caption = 'Edit &Adjustments...'
        ImageIndex = 142
        ShortCut = 24641
        OnClick = EditCmdExecute
      end
      object EditDivider1: TMenuItem
        Caption = '-'
        Enabled = False
      end
      object EditSelectAllItem: TMenuItem
        Action = EditSelectAllCmd
      end
      object EditFindMItem: TMenuItem
        Tag = 26
        Caption = '&Find and Replace'
        ImageIndex = 52
        ShortCut = 16454
        OnClick = EditCmdExecute
      end
      object EditDivider2: TMenuItem
        Caption = '-'
      end
      object EditPrefMItem: TMenuItem
        Tag = 48
        Caption = 'P&references'
        ImageIndex = 149
        ShortCut = 16459
        OnClick = EditCmdExecute
      end
    end
    object ViewMenu: TMenuItem
      Caption = '&View'
      OnClick = ViewMenuClick
      object PageNavigator1: TMenuItem
        Action = GoToPageNavigatorCmd
      end
      object ViewExpandAllItem: TMenuItem
        Tag = 18
        Action = ViewExpandAllCmd
      end
      object ViewCollapseAllItem: TMenuItem
        Action = ViewCollapseAllCmd
      end
      object ViewTogglePageListMItem: TMenuItem
        Action = ViewToglGoToListCmd
      end
      object ViewDivider1: TMenuItem
        Caption = '-'
        Enabled = False
      end
      object ViewShowHideToolBars: TMenuItem
        Caption = 'ToolBars'
        object chkShowHideToolBars: TMenuItem
          Caption = 'Show/Hide Toolbars'
          object chkFileMenuToolbar: TMenuItem
            Tag = 1
            AutoCheck = True
            Caption = 'File Menu Toolbar'
            Checked = True
            OnClick = ToolBarShowHideOnClick
          end
          object chkEditMenuToolbar: TMenuItem
            Tag = 2
            AutoCheck = True
            Caption = 'Edit Menu Toolbar'
            Checked = True
            OnClick = ToolBarShowHideOnClick
          end
          object chkFormattingToolbar: TMenuItem
            Tag = 3
            AutoCheck = True
            Caption = 'Formatting Toolbar'
            Checked = True
            OnClick = ToolBarShowHideOnClick
          end
          object chkDisplayToolbar: TMenuItem
            Tag = 4
            AutoCheck = True
            Caption = 'Display Toolbar'
            Checked = True
            OnClick = ToolBarShowHideOnClick
          end
          object chkLabelingToolbar: TMenuItem
            Tag = 5
            AutoCheck = True
            Caption = 'Labeling Toolbar'
            Checked = True
            OnClick = ToolBarShowHideOnClick
          end
          object chkWorkFlowToolbar: TMenuItem
            Tag = 6
            AutoCheck = True
            Caption = 'Workflow Toolbar'
            Checked = True
            OnClick = ToolBarShowHideOnClick
          end
          object chkPrefToolbar: TMenuItem
            Tag = 7
            AutoCheck = True
            Caption = 'Preferences Toolbar'
            Checked = True
            OnClick = ToolBarShowHideOnClick
          end
          object chkOtherToolsToolbar: TMenuItem
            Tag = 8
            AutoCheck = True
            Caption = 'Additional Tools Toolbar'
            Checked = True
            OnClick = ToolBarShowHideOnClick
          end
          object chkNewsDeskToolBar: TMenuItem
            Tag = 9
            AutoCheck = True
            Caption = 'NewsDesk'
            Checked = True
            OnClick = ToolBarShowHideOnClick
          end
        end
        object chkSetToolBarTheme: TMenuItem
          Caption = 'Set Toolbar Theme'
          object chkAutoThemeAdapt: TMenuItem
            Tag = 1
            AutoCheck = True
            Caption = 'Auto Select Theme'
            Checked = True
            RadioItem = True
            OnClick = ToolBarStyleChangeOnClick
          end
          object chkOffice2003Blue: TMenuItem
            Tag = 2
            AutoCheck = True
            Caption = 'Office 2003 Blue'
            RadioItem = True
            OnClick = ToolBarStyleChangeOnClick
          end
          object chkOffice2003Olive: TMenuItem
            Tag = 3
            AutoCheck = True
            Caption = 'Office 2003 Olive'
            RadioItem = True
            OnClick = ToolBarStyleChangeOnClick
          end
          object chkOffice2003Silver: TMenuItem
            Tag = 4
            AutoCheck = True
            Caption = 'Office 2003 Silver'
            RadioItem = True
            OnClick = ToolBarStyleChangeOnClick
          end
          object chkOffice2007Silver: TMenuItem
            Tag = 5
            AutoCheck = True
            Caption = 'Office 2007 Silver'
            RadioItem = True
            OnClick = ToolBarStyleChangeOnClick
          end
          object chkOffice2007Luna: TMenuItem
            Tag = 6
            AutoCheck = True
            Caption = 'Office 2007 Luna'
            RadioItem = True
            OnClick = ToolBarStyleChangeOnClick
          end
          object chkOffice2007Obsidian: TMenuItem
            Tag = 7
            AutoCheck = True
            Caption = 'Office 2007 Obsidian'
            RadioItem = True
            OnClick = ToolBarStyleChangeOnClick
          end
          object chkOfficeXP: TMenuItem
            Tag = 8
            AutoCheck = True
            Caption = 'Office XP'
            RadioItem = True
            OnClick = ToolBarStyleChangeOnClick
          end
        end
        object SetToolbarLocking: TMenuItem
          Caption = 'Set Toolbar Locking'
          object chkUnLockToolBars: TMenuItem
            AutoCheck = True
            Caption = 'Unlock All Toolbars'
            Checked = True
            RadioItem = True
            OnClick = LockAllToolBars
          end
          object chkLockToolBars: TMenuItem
            AutoCheck = True
            Caption = 'Lock All Toolbars'
            RadioItem = True
            OnClick = LockAllToolBars
          end
        end
        object chkResetToolbars: TMenuItem
          AutoCheck = True
          Caption = 'Reset Toolbars'
          OnClick = ResetToolbars
        end
      end
      object ViewDivider2: TMenuItem
        Caption = '-'
        Enabled = False
      end
      object ViewNormalSizeMItem: TMenuItem
        Tag = 22
        Caption = '&Normal'
        Checked = True
        OnClick = ViewCmdExecute
      end
      object ViewFittoScreenMItem: TMenuItem
        Tag = 23
        Caption = 'Full &Screen'
        OnClick = ViewCmdExecute
      end
      object ViewDisplayScalingMItem: TMenuItem
        Tag = 24
        Caption = '&Zoom...'
        OnClick = ViewCmdExecute
      end
    end
    object FormsMenu: TMenuItem
      Caption = 'F&orms'
      OnClick = FormsMenuClick
      object FormsFindMItem: TMenuItem
        Tag = 47
        Action = FormsFindCmd
      end
      object FormsArrangeMItem: TMenuItem
        Tag = 20
        Action = FormsArrangeCmd
      end
      object FormsDeleteMItem: TMenuItem
        Tag = 21
        Caption = '&Delete Forms'
        OnClick = FormsCmdExecute
      end
      object SketchersDeleteMItem: TMenuItem
        Tag = 49
        Caption = 'Delete Sketches'
        Visible = False
        OnClick = FormsCmdExecute
      end
      object FormsMenuDivider1: TMenuItem
        Caption = '-'
      end
      object FormsLibraryMItem: TMenuItem
        Action = FormsLibraryCmd
      end
    end
    object CellMenu: TMenuItem
      Caption = '&Cells'
      OnClick = CellMenuClick
      object CellCarryOverCommentsMItem: TMenuItem
        Action = CellCarryOverComments
      end
      object CellAutoRspMItem: TMenuItem
        Tag = 1
        Caption = 'Auto &Display Responses'
        ShortCut = 16466
        OnClick = CellCmdExecute
      end
      object CellShowRspMItem: TMenuItem
        Tag = 3
        Caption = '&Show Responses'
        ShortCut = 113
        OnClick = CellCmdExecute
      end
      object CellSaveRspMItem: TMenuItem
        Tag = 4
        Caption = 'S&ave as Response'
        ShortCut = 16497
        OnClick = CellCmdExecute
      end
      object CellEditRspMItem: TMenuItem
        Tag = 2
        Caption = '&Edit Responses'
        ShortCut = 8305
        OnClick = CellCmdExecute
      end
      object CellPropogateCompField: TMenuItem
        Caption = 'Copy Description To All'
        ShortCut = 16571
        OnClick = OnPropogateCompFieldClick
      end
      object CellDivider2: TMenuItem
        Caption = '-'
      end
      object CellStyleMItem: TMenuItem
        Caption = 'S&tyle'
        object CellStyleBoldSMItem: TMenuItem
          Tag = 1
          Action = EditTxBoldCmd
        end
        object CellStyleItalicSMItem: TMenuItem
          Action = EditTxItalicCmd
        end
        object CellStyleUnderlineSMItem: TMenuItem
          Action = EditTxUnderLnCmd
        end
      end
      object CellJustMItem: TMenuItem
        Caption = '&Justification'
        object CellJustLeftSMItem: TMenuItem
          Action = EditTxLeftCmd
        end
        object CellJustCenterSMItem: TMenuItem
          Action = EditTxCntrCmd
        end
        object CellJustRightSMItem: TMenuItem
          Action = EditTxRightCmd
        end
      end
      object CellFontSizeMItem: TMenuItem
        Caption = '&Font Size'
        object CellFSizSmlMItem: TMenuItem
          Tag = -1
          Action = EditTxDecreaseCmd
        end
        object CellFSizCurM1MItem: TMenuItem
          Tag = 9
          Caption = '9'
          OnClick = FontCmdExecute
        end
        object CellFSizCurMItem: TMenuItem
          Tag = 10
          Caption = '10'
          Checked = True
          OnClick = FontCmdExecute
        end
        object CellFSizCurP1MItem: TMenuItem
          Tag = 11
          Caption = '11'
          OnClick = FontCmdExecute
        end
        object CellFSizBigMItem: TMenuItem
          Tag = 1
          Action = EditTxIncreaseCmd
        end
      end
      object CellDivider3: TMenuItem
        Caption = '-'
      end
      object CellWPFontMItem: TMenuItem
        Action = CellWPFonts
      end
      object CellDivider4: TMenuItem
        Caption = '-'
      end
      object CellSaveImageAsMItem: TMenuItem
        Action = CellSaveImageAsCmd
      end
      object CellAutoAdjustMItem: TMenuItem
        Tag = 6
        Caption = 'Auto &Adjustments...'
        ImageIndex = 142
        OnClick = CellCmdExecute
      end
      object CellPrefMItem: TMenuItem
        Tag = 5
        Action = CellPrefCmd
      end
    end
    object ListMenu: TMenuItem
      Caption = '&Lists'
      OnClick = ListMenuClick
      object ListClientMItem: TMenuItem
        Tag = 1
        Action = ListShowClientCmd
      end
      object ListReportsMItem: TMenuItem
        Tag = 2
        Action = ListShowReportsCmd
      end
      object ListNghbrhdsMItem: TMenuItem
        Tag = 7
        Action = ListShowNeighCmd
      end
      object ListAMCMItem: TMenuItem
        Tag = 10
        Action = ListShowAMCCmd
        Visible = False
      end
      object ListDivider1: TMenuItem
        Caption = '-'
        Visible = False
      end
      object ListCompsMItem: TMenuItem
        Tag = 4
        Action = ListShowCompsCmd
      end
      object ListSaveCompsMItem: TMenuItem
        Tag = 6
        Action = ListSaveCompsCmd
      end
      object ListDivider2: TMenuItem
        Caption = '-'
      end
      object ListAgWCostMItem: TMenuItem
        Tag = 1
        Caption = '&Cost Information'
      end
      object ListAgWCropMItem: TMenuItem
        Tag = 3
        Caption = 'C&ropland Index'
      end
      object ListAgWLandMItem: TMenuItem
        Tag = 2
        Caption = '&Land Table'
      end
    end
    object InsertMenu: TMenuItem
      Caption = '&Insert'
      OnClick = InsertMenuClick
      object InsertTodaysDateMItem: TMenuItem
        Action = InsertTodaysDateCmd
        Caption = 'Insert Today'#39's Date'
      end
      object InsertPDFMItem: TMenuItem
        Action = InsertPDFCmd
      end
      object InsertFileImageMItem: TMenuItem
        Action = InsertFileImageCmd
      end
      object InsertDeviceImageMItem: TMenuItem
        Action = InsertDeviceImageCmd
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object InsertSetupDeviceMItem: TMenuItem
        Tag = 3
        Caption = '&Setup Device Source'
        OnClick = InsertCmdExecute
      end
    end
    object GoToMenu: TMenuItem
      Caption = '&GoTo'
      OnClick = GoToMenuClick
      object GoToPageNavigatorMItem: TMenuItem
        Action = GoToPageNavigatorCmd
      end
      object GoToDivider2: TMenuItem
        Caption = '-'
        Enabled = False
      end
      object GoToPrevCellMItem: TMenuItem
        Tag = -3
        Caption = 'Previous &Cell'
        ShortCut = 16468
        OnClick = GoToCmdExecute
      end
      object GoToPrevPgMItem: TMenuItem
        Tag = -1
        Caption = '&Previous Page'
        OnClick = GoToCmdExecute
      end
      object GoToNextPgMItem: TMenuItem
        Tag = -2
        Caption = '&Next Page'
        OnClick = GoToCmdExecute
      end
      object GoToDivider1: TMenuItem
        Caption = '-'
        Enabled = False
      end
    end
    object ToolMenu: TMenuItem
      Caption = '&Tools'
      OnClick = ToolMenuClick
      object ToolAppsMItem0: TMenuItem
        Tag = 101
        Caption = '&Spelling'
        ImageIndex = 153
        object ToolSpellWordSMItem: TMenuItem
          Tag = 151
          Caption = '&Cell'
          ShortCut = 16502
          OnClick = ToolCmdExecute
        end
        object ToolSpellPageSMItem: TMenuItem
          Tag = 152
          Caption = '&Page'
          ShortCut = 8310
          OnClick = ToolCmdExecute
        end
        object ToolSpellReportSMItem: TMenuItem
          Tag = 153
          Caption = '&Report'
          ShortCut = 118
          OnClick = ToolCmdExecute
        end
      end
      object ToolAppsMItem1: TMenuItem
        Tag = 102
        Caption = '&Thesaurus...'
        ImageIndex = 154
        OnClick = ToolCmdExecute
      end
      object ToolAppsMItem3: TMenuItem
        Caption = 'S&ignatures...'
        ImageIndex = 152
        Visible = False
      end
      object ToolAppsMItem4: TMenuItem
        Tag = 105
        Caption = 'S&ignatures...'
        ImageIndex = 152
        OnClick = ToolCmdExecute
      end
      object ToolAppsMItem2: TMenuItem
        Tag = 103
        Caption = '&PhotoSheet...'
        ImageIndex = 125
        OnClick = ToolCmdExecute
      end
      object ToolAppsMItem5: TMenuItem
        Tag = 106
        Caption = '&Reviewer...'
        ImageIndex = 151
        Visible = False
        OnClick = ToolCmdExecute
      end
      object ToolAppsMItem7: TMenuItem
        Tag = 108
        Action = ToolApps7Cmd
        ImageIndex = 121
      end
      object ToolAppsMItem6: TMenuItem
        Tag = 107
        Caption = '&ClickNOTES...'
        ImageIndex = 123
        Visible = False
        OnClick = ToolCmdExecute
      end
      object ToolAppsMItem9: TMenuItem
        Tag = 110
        Caption = '&GPS Connection...'
        Hint = 'Capture GPS Coordinates with this tool '
        Visible = False
        OnClick = ToolCmdExecute
      end
      object ToolAppsMItem8: TMenuItem
        Tag = 109
        Caption = '&AppraisalWorld Connection...'
        OnClick = ToolCmdExecute
      end
      object ToolDesignerMItem: TMenuItem
        Tag = 110
        Caption = '&Form Designer'
        Visible = False
        OnClick = ToolCmdExecute
      end
      object ToolWordMItem: TMenuItem
        Tag = 11
        Caption = 'Comments'
        Enabled = False
        Visible = False
        OnClick = ToolCmdExecute
      end
      object ToolLockFormMItem: TMenuItem
        Caption = 'Lock Form'
        Visible = False
        OnClick = ToolCmdExecute
      end
      object CheckCompConsistency: TMenuItem
        Action = ListCheckUADCmd
        ImageIndex = 65
        ShortCut = 16456
      end
      object ToolPlugMDivider: TMenuItem
        Caption = '-'
        Enabled = False
      end
      object ToolCompEditor: TMenuItem
        Tag = 121
        Caption = 'Comparables Editor...'
        ImageIndex = 145
        OnClick = ToolCmdExecute
      end
      object ToolCompAdjuster: TMenuItem
        Tag = 122
        Caption = 'Automatic Adjustments...'
        ImageIndex = 142
        OnClick = ToolCmdExecute
      end
      object ToolCompMDivider: TMenuItem
        Caption = '-'
      end
      object ToolPlugMItem7: TMenuItem
        Tag = 207
        Caption = 'Plug7'
        ImageIndex = 133
      end
      object ToolPlugMItem1: TMenuItem
        Tag = 201
        Caption = 'Plug1'
        ImageIndex = 136
      end
      object ToolPlugMItem2: TMenuItem
        Tag = 202
        Caption = 'Plug2'
        ImageIndex = 135
      end
      object ToolPlugMItem3: TMenuItem
        Tag = 203
        Caption = 'Plug3'
        ImageIndex = 138
        Visible = False
      end
      object ToolPlugMItem4: TMenuItem
        Tag = 204
        Caption = 'Plug4'
        ImageIndex = 139
        Visible = False
      end
      object ToolPlugMItem5: TMenuItem
        Tag = 205
        Caption = 'Plug5'
        ImageIndex = 137
      end
      object ToolPlugMItem6: TMenuItem
        Tag = 206
        Caption = 'Plug6'
        ImageIndex = 141
      end
      object ToolPlugMItem8: TMenuItem
        Tag = 208
        Caption = 'Plug8'
        ImageIndex = 170
        Visible = False
      end
      object ToolPlugMItem9: TMenuItem
        Tag = 209
        Caption = 'Plug9'
        ImageIndex = 214
      end
      object ToolUserMDivider: TMenuItem
        Caption = '-'
        Enabled = False
      end
      object ToolUserMItem1: TMenuItem
        Tag = 1
        Caption = 'User1'
        OnClick = ToolCmdExecute
      end
      object ToolUserMItem2: TMenuItem
        Tag = 2
        Caption = 'User2'
        OnClick = ToolCmdExecute
      end
      object ToolUserMItem3: TMenuItem
        Tag = 3
        Caption = 'User3'
        OnClick = ToolCmdExecute
      end
      object ToolUserMItem4: TMenuItem
        Tag = 4
        Caption = 'User4'
        OnClick = ToolCmdExecute
      end
      object ToolUserMItem5: TMenuItem
        Tag = 5
        Caption = 'User5'
        OnClick = ToolCmdExecute
      end
      object ToolUserMItem6: TMenuItem
        Tag = 6
        Caption = 'User6'
        OnClick = ToolCmdExecute
      end
      object ToolUserMItem7: TMenuItem
        Tag = 7
        Caption = 'User7'
        OnClick = ToolCmdExecute
      end
      object ToolUserMItem8: TMenuItem
        Tag = 8
        Caption = 'User8'
        OnClick = ToolCmdExecute
      end
      object ToolUserMItem9: TMenuItem
        Tag = 9
        Caption = 'User9'
        OnClick = ToolCmdExecute
      end
      object ToolUserMItem10: TMenuItem
        Tag = 10
        Caption = 'User10'
        OnClick = ToolCmdExecute
      end
    end
    object ServicesMenu: TMenuItem
      Caption = '&Services'
      OnClick = ServicesMenuClick
      object ServiceUADPrefMItem: TMenuItem
        Action = ServiceUADPrefCmd
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object MLSImportWizard1: TMenuItem
        Action = ServiceMLSImport
        ImageIndex = 229
      end
      object ServiceLPSBlackKnights: TMenuItem
        Tag = 328
        Action = ServiceLPSBlackKnightsCmd
        Caption = 'LPS Public Data'
        Visible = False
      end
      object ServiceMDivider3: TMenuItem
        Caption = '-'
        Enabled = False
      end
      object ServicesMapPtMItem: TMenuItem
        Action = ServiceLocMapCmd
      end
      object AddressVerification1: TMenuItem
        Tag = 323
        Action = ServiceAddressVerification
      end
      object ServiceBuildfaxMItem: TMenuItem
        Tag = 321
        Action = ServiceBuildfaxCmd
      end
      object ServicePictometryMItem: TMenuItem
        Action = ServicePictometryCmd
      end
      object ServiceFloodInsightsMItem: TMenuItem
        Tag = 302
        Action = ServiceFloodInsightCmd
        Caption = 'Flood Maps'
      end
      object ServiceCostInfoMItem: TMenuItem
        Tag = 304
        Caption = '&Cost Analysis'
        ImageIndex = 144
        OnClick = ServiceCmdExecute
      end
      object ServiceCensusMItem: TMenuItem
        Tag = 305
        Caption = '&Get Census Tract'
        ImageIndex = 143
        OnClick = ServiceCmdExecute
      end
      object ServiceSentryMItem: TMenuItem
        Action = ServiceSentryCmd
        Visible = False
      end
      object Service1004MCMItem: TMenuItem
        Action = ServiceMarketAnalysis
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object ServicePhoenixMobileItem: TMenuItem
        Tag = 322
        Caption = 'PhoenixMobile Sync'
        ImageIndex = 214
        OnClick = ServiceCmdExecute
      end
      object ServiceMobileInspectionItem: TMenuItem
        Tag = 325
        Caption = 'Inspect-A-Lot'
        Enabled = False
        ImageIndex = 219
        OnClick = ServiceCmdExecute
      end
      object ServiceMDivider1: TMenuItem
        Caption = '-'
        Enabled = False
      end
      object ServiceStartFileCenterMItem: TMenuItem
        Tag = 309
        Caption = 'Online File Manager...'
        ImageIndex = 165
        Visible = False
        OnClick = ServiceCmdExecute
      end
      object ServiceStartOnlineBackupMItem: TMenuItem
        Tag = 307
        Caption = 'Online Backup Manager...'
        ImageIndex = 166
        Visible = False
        OnClick = ServiceCmdExecute
      end
      object ServiceOnlineBackupTaskMItem: TMenuItem
        Tag = 308
        Caption = 'Set Default Backup Tasks'
        Visible = False
        OnClick = ServiceCmdExecute
      end
      object ServiceMDivider2: TMenuItem
        Caption = '-'
        Enabled = False
      end
      object ServiceUsageMItem: TMenuItem
        Action = ServiceUsageSummaryCmd
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object ServiceAnalysisItem: TMenuItem
        Tag = 326
        Caption = 'Analysis'
        ImageIndex = 227
        OnClick = ServiceCmdExecute
      end
    end
    object OrdersMItem: TMenuItem
      Caption = 'Orders'
      OnClick = OrdersMenuClick
      object NewOrders: TMenuItem
        Tag = 1
        Action = NewOrdersCmd
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object OrderDeliverAppraisalMItem: TMenuItem
        Tag = 8
        Caption = '&Deliver Appraisal'
        ImageIndex = 213
        OnClick = FileExportExecute
      end
      object OrdersDivider2: TMenuItem
        Caption = '-'
        Enabled = False
      end
      object OrderSendToRELSMItem: TMenuItem
        Tag = 5
        Action = OrderSendRELSCmd
        Caption = 'Send Report to CLVS'
      end
      object OrderSendValulinkXMLMItem: TMenuItem
        Tag = 322
        Action = OrderSendValulinkXMLcmd
      end
      object OrderSendXMLKyliptixMItem: TMenuItem
        Tag = 323
        Action = OrderSendKyliptixXMLcmd
      end
      object OrderSendToPCVMItem: TMenuItem
        Tag = 324
        Action = OrderSendPCVCmd
      end
      object OrderSendAIReadySMItem: TMenuItem
        Tag = 2
        Action = OrderSendAIReadyCmd
        Caption = 'Send Report to AppraisalPort'
      end
      object OrderSendLighthouseSMItem: TMenuItem
        Tag = 1
        Action = OrderSendLighthouseCmd
        Caption = 'Send Report to LH'
        Visible = False
      end
      object SendReporttoMercuryNetwork1: TMenuItem
        Action = OrderSendMercuryCmd
      end
      object OrderSendEADMItem: TMenuItem
        Tag = 326
        Action = OrdersSendEADcmd
        Caption = 'Prepare Report for FHA/EAD'
      end
      object OrderSendVeptasCmdMenuItem: TMenuItem
        Tag = 327
        Action = OrderSendVeptasCmd
        Caption = 'Prepare Report for Veptas'
      end
      object OrdersDivider1: TMenuItem
        Caption = '-'
        Enabled = False
      end
      object ManageAllOrders1: TMenuItem
        Action = OrderManagerAll
      end
      object N8: TMenuItem
        Caption = '-'
      end
      object OrdersSetRELSLoginSMItem: TMenuItem
        Tag = 4
        Caption = 'Update CLVS Login...'
        ImageIndex = 72
        Visible = False
        OnClick = OrdersCmdExecute
      end
    end
    object WindowMenu: TMenuItem
      Caption = '&Windows'
      OnClick = WindowMenuClick
      object WinCascadeMItem: TMenuItem
        Tag = 1
        Caption = '&Cascade'
        OnClick = WinCmdExecute
      end
      object WinTileVertMItem: TMenuItem
        Tag = 2
        Caption = 'Tile &Vertically'
        OnClick = WinCmdExecute
      end
      object WinTileHorzMItem: TMenuItem
        Tag = 3
        Caption = 'Tile &Horizontally'
        OnClick = WinCmdExecute
      end
      object WinArrangeIconMItem: TMenuItem
        Tag = 4
        Caption = '&Arrange Icons'
        OnClick = WinCmdExecute
      end
    end
    object HelpMenu: TMenuItem
      Caption = '&Help'
      Hint = 'Help topics'
      OnClick = HelpMenuClick
      object HelpRELSServerMItem: TMenuItem
        Caption = 'CLVS Testing'
        Visible = False
        OnClick = HelpRELSServerMItemClick
        object HelpXMLRELSWriteXML: TMenuItem
          Tag = 4
          Caption = 'Write XML File'
          OnClick = RELSTestingClick
        end
        object HelpXMLRELSWriteXPaths: TMenuItem
          Tag = 5
          Caption = 'Write XPaths'
          OnClick = RELSTestingClick
        end
        object HelpXMLRELSWriteXFilePDF: TMenuItem
          Tag = 6
          Caption = 'Write XML File with PDF Embeded'
          OnClick = RELSTestingClick
        end
        object HelpDivider6: TMenuItem
          Caption = '-'
        end
        object RELSDevelopMItem: TMenuItem
          Tag = 1
          Caption = 'Development'
          OnClick = RELSTestingClick
        end
        object RELSBetaMItem: TMenuItem
          Tag = 2
          Caption = 'Beta'
          Checked = True
          OnClick = RELSTestingClick
        end
        object RELSProductionMItem: TMenuItem
          Tag = 3
          Caption = 'Production'
          OnClick = RELSTestingClick
        end
      end
      object HelpGSEServerMItem: TMenuItem
        Caption = 'GSE Testing'
        object HelpXMLGSEWriteXML: TMenuItem
          Tag = 4
          Caption = 'Write XML File'
          OnClick = GSETestingClick
        end
        object HelpXMLGSEWriteXPaths: TMenuItem
          Tag = 5
          Caption = 'Write XPaths'
          OnClick = GSETestingClick
        end
        object HelpXMLGSEWriteXFilePDF: TMenuItem
          Tag = 6
          Caption = 'Write XML File with Embedded PDF'
          OnClick = GSETestingClick
        end
      end
      object TestStuffMItem1: TMenuItem
        Caption = 'Set Xome Server'
        OnClick = TestStuffMItem1Click
        object StreetLinksStagingSMItem: TMenuItem
          Tag = 1
          Caption = 'Staging'
          Checked = True
          OnClick = SetStreetlinksURLClick
        end
        object StreetLinksProductionSMItem: TMenuItem
          Tag = 2
          Caption = 'Production'
          OnClick = SetStreetlinksURLClick
        end
      end
      object TestStuffMItem2: TMenuItem
        Caption = 'Unused Test Function2'
        Visible = False
        OnClick = TestStuffMItem2Click
      end
      object TestStuffMItem3: TMenuItem
        Caption = 'Test Zoom Map'
        Visible = False
        OnClick = TestStuffMItem3Click
      end
      object TestStuffMItem4: TMenuItem
        Caption = 'Test AW Messaging'
        Visible = False
        OnClick = TestStuffMItem4Click
      end
      object TestStuffMItem5: TMenuItem
        Caption = 'Test Appraisal Sentry'
        Visible = False
        OnClick = TestStuffMItem5Click
      end
      object HelpDebugMItem: TMenuItem
        Caption = 'Debug Help'
        Visible = False
        object HelpDebugLog: TMenuItem
          Tag = 14
          Caption = 'Service Log Off'
          OnClick = DebugCmdExecute
        end
        object HelpDbugDivider: TMenuItem
          Caption = '-'
        end
        object mnuHelpDBugExportCellData: TMenuItem
          Action = HelpDBugExportCellData
        end
        object mnuHelpDBugExportCID: TMenuItem
          Action = HelpDBugExportCID
        end
        object HelpDBugFindCell: TMenuItem
          Tag = 15
          Caption = 'Find Cell ID'
          OnClick = DebugCmdExecute
        end
        object HelpDBugShowCellSeq: TMenuItem
          Tag = 1
          Caption = 'Show Cell Sequence No.'
          OnClick = DebugCmdExecute
        end
        object HelpDBugShowMathIDs: TMenuItem
          Tag = 2
          Caption = 'Show Math IDs'
          OnClick = DebugCmdExecute
        end
        object HelpDBugShowXMLID: TMenuItem
          Tag = 16
          Caption = 'Show XML IDs'
          OnClick = DebugCmdExecute
        end
        object HelpDBugShowCellID: TMenuItem
          Tag = 3
          Caption = 'Show Cell IDs'
          OnClick = DebugCmdExecute
        end
        object HelpDBugShowCellName: TMenuItem
          Tag = 11
          Caption = 'Show Cell Name'
          OnClick = DebugCmdExecute
        end
        object HelpDBugShowRspID: TMenuItem
          Tag = 4
          Caption = 'Show Rsp IDs'
          OnClick = DebugCmdExecute
        end
        object HelpDBugShowRspName: TMenuItem
          Tag = 12
          Caption = 'Show Rsp Name'
          OnClick = DebugCmdExecute
        end
        object HelpDBugShowContext: TMenuItem
          Tag = 9
          Caption = 'Show Context ID'
          OnClick = DebugCmdExecute
        end
        object HelpDBugShowLocalContext: TMenuItem
          Tag = 10
          Caption = 'Show Local Context'
          OnClick = DebugCmdExecute
        end
        object HelpDBugShowSample: TMenuItem
          Tag = 5
          Caption = 'Show Sample Text'
          OnClick = DebugCmdExecute
        end
        object HelpDBugClearPg: TMenuItem
          Tag = 6
          Caption = 'Clear Page'
          OnClick = DebugCmdExecute
        end
        object HelpDBugWriteFormSpecs: TMenuItem
          Caption = 'Write FormLib Specs'
          OnClick = HelpDBugWriteFormSpecsClick
        end
        object HelpDBugPrintStatMItem: TMenuItem
          Tag = 7
          Caption = 'Print Form Specs'
          OnClick = PrintFormDBugSpecsClick
        end
        object HelpDBugSpecialMItem: TMenuItem
          Tag = 13
          Caption = 'Local and Global IDs'
          OnClick = DebugCmdExecute
        end
        object N1: TMenuItem
          Caption = '-'
          Enabled = False
        end
        object HelpDBugListRspIDs: TMenuItem
          Tag = 7
          Caption = 'Set Response IDs'
          OnClick = DebugCmdExecute
        end
        object HelpDBugListCellIDs: TMenuItem
          Tag = 8
          Caption = 'Set Cell IDs'
          OnClick = DebugCmdExecute
        end
        object mnuHelpDBugFillContainer: TMenuItem
          Action = HelpDBugFillContainer
        end
      end
      object HelpQuickstartMItem: TMenuItem
        Tag = 12
        Caption = '&User Guides'
        ImageIndex = 56
        OnClick = HelpCmdExecute
      end
      object HelpOnLineMItem: TMenuItem
        Tag = 5
        Caption = 'Support Website'
        ImageIndex = 61
        OnClick = HelpCmdExecute
      end
      object HelpDivider5: TMenuItem
        Caption = '-'
      end
      object HelpCheckForUpdateMItem: TMenuItem
        Tag = 19
        Action = HelpCheckForUpdatesCmd
      end
      object HelpShowNewsDeskMItem: TMenuItem
        Action = HelpNewsDeskCmd
      end
      object HelpReadMeMItem: TMenuItem
        Tag = 2
        Caption = 'Check What'#39's New'
        ImageIndex = 65
        OnClick = HelpCmdExecute
      end
      object HelpDivider4: TMenuItem
        Caption = '-'
      end
      object HelpRequestEmailMItem: TMenuItem
        Tag = 8
        Caption = 'Email Technical Support'
        ImageIndex = 58
        OnClick = HelpCmdExecute
      end
      object InstantMSG: TMenuItem
        Tag = 22
        Caption = 'Live Technical Support'
        ImageIndex = 58
        OnClick = HelpCmdExecute
      end
      object SendSuggestion1: TMenuItem
        Tag = 7
        Caption = 'Send Suggestion'
        ImageIndex = 58
        OnClick = HelpCmdExecute
      end
      object DownloadTeamView1: TMenuItem
        Tag = 52
        Caption = 'Remote Support'
        ImageIndex = 217
        OnClick = HelpCmdExecute
      end
      object HelpDivider2: TMenuItem
        Caption = '-'
        Enabled = False
      end
      object HelpRegisterMItem: TMenuItem
        Tag = 6
        Caption = '&Registration'
        ImageIndex = 60
        OnClick = HelpCmdExecute
      end
      object N9: TMenuItem
        Caption = '-'
      end
      object AppraisalWorld1: TMenuItem
        Action = HelpAppraisalWorld
      end
      object HelpDivider1: TMenuItem
        Caption = '-'
        Enabled = False
      end
      object HelpAboutMItem: TMenuItem
        Tag = 1
        Caption = '&About ClickFORMS'
        OnClick = HelpCmdExecute
      end
    end
  end
  object MainMenuStyle: TAdvMenuOfficeStyler
    AutoThemeAdapt = True
    Style = osOffice2003Blue
    Background.Position = bpCenter
    Background.Color = 16185078
    Background.ColorTo = 16185078
    IconBar.Color = 16773091
    IconBar.ColorTo = 14986631
    IconBar.CheckBorder = clNavy
    IconBar.RadioBorder = clNavy
    IconBar.SeparatorColor = 12961221
    SelectedItem.BorderColor = clNavy
    SelectedItem.Font.Charset = DEFAULT_CHARSET
    SelectedItem.Font.Color = clWindowText
    SelectedItem.Font.Height = -11
    SelectedItem.Font.Name = 'Tahoma'
    SelectedItem.Font.Style = []
    SelectedItem.CheckBorder = clNavy
    SelectedItem.RadioBorder = clNavy
    RootItem.Color = 16105118
    RootItem.ColorTo = 16240050
    RootItem.Font.Charset = DEFAULT_CHARSET
    RootItem.Font.Color = clMenuText
    RootItem.Font.Height = -11
    RootItem.Font.Name = 'Tahoma'
    RootItem.Font.Style = []
    RootItem.SelectedColor = 16773091
    RootItem.SelectedColorTo = 15185299
    RootItem.SelectedBorderColor = 9841920
    RootItem.HoverColor = 13432063
    RootItem.HoverColorTo = 10147583
    Glyphs.SubMenu.Data = {
      5A000000424D5A000000000000003E0000002800000004000000070000000100
      0100000000001C0000000000000000000000020000000200000000000000FFFF
      FF0070000000300000001000000000000000100000003000000070000000}
    Glyphs.Check.Data = {
      7E000000424D7E000000000000003E0000002800000010000000100000000100
      010000000000400000000000000000000000020000000200000000000000FFFF
      FF00FFFF0000FFFF0000FFFF0000FFFF0000FDFF0000F8FF0000F07F0000F23F
      0000F71F0000FF8F0000FFCF0000FFEF0000FFFF0000FFFF0000FFFF0000FFFF
      0000}
    Glyphs.Radio.Data = {
      7E000000424D7E000000000000003E0000002800000010000000100000000100
      010000000000400000000000000000000000020000000200000000000000FFFF
      FF00FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FC3F0000F81F0000F81F
      0000F81F0000F81F0000FC3F0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000}
    SideBar.Font.Charset = DEFAULT_CHARSET
    SideBar.Font.Color = clWhite
    SideBar.Font.Height = -19
    SideBar.Font.Name = 'Tahoma'
    SideBar.Font.Style = [fsBold, fsItalic]
    SideBar.Image.Position = bpCenter
    SideBar.Background.Position = bpCenter
    SideBar.SplitterColorTo = clBlack
    Separator.Color = 13339754
    Separator.GradientType = gtBoth
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    MenuBorderColor = 9841920
    Left = 400
    Top = 200
  end
  object PopUpSendOrders: TAdvPopupMenu
    Images = MainImages
    MenuStyler = MainMenuStylePopUp
    Version = '2.5.0.0'
    Left = 584
    Top = 144
    object tbtnSendRELSMItem: TMenuItem
      Tag = 5
      Action = OrderSendRELSCmd
      Caption = 'Send to CLVS'
    end
    object tbtnSendtoAIReady: TMenuItem
      Action = ToolAIReadyCmd
    end
    object tbtnSendtoVeptas: TMenuItem
      Action = OrderSendVeptasCmd
      Caption = 'Send Report to Veptas'
    end
    object tbtnSendEAD: TMenuItem
      Tag = 326
      Action = OrdersSendEADcmd
      Caption = 'Send Report to FHA/EAD portal'
    end
    object tbtnSendToMercury: TMenuItem
      Tag = 325
      Action = ToolMercuryCmd
    end
    object tbtnSendPDF: TMenuItem
      Action = ToolSendPDF
      Caption = 'eMail Recipient (as PDF Attachment)...'
      Hint = 'eMail Recipient (as PDF Attachment)...'
    end
    object tbtnSendCLK: TMenuItem
      Action = ToolSendCLK
      Caption = 'eMail Recipient (as '#39'.clk'#39' Attachment)...'
      Hint = 'Send as Clk Attachment'
    end
  end
  object MainMenuStylePopUp: TAdvMenuOfficeStyler
    AutoThemeAdapt = True
    Style = osOffice2003Blue
    Background.Position = bpCenter
    Background.Color = 16185078
    Background.ColorTo = 16185078
    IconBar.Color = 16773091
    IconBar.ColorTo = 14986631
    IconBar.CheckBorder = clNavy
    IconBar.RadioBorder = clNavy
    SelectedItem.BorderColor = clNavy
    SelectedItem.Font.Charset = DEFAULT_CHARSET
    SelectedItem.Font.Color = clWindowText
    SelectedItem.Font.Height = -11
    SelectedItem.Font.Name = 'Tahoma'
    SelectedItem.Font.Style = []
    SelectedItem.CheckBorder = clNavy
    SelectedItem.RadioBorder = clNavy
    RootItem.Color = 16105118
    RootItem.ColorTo = 16240050
    RootItem.Font.Charset = DEFAULT_CHARSET
    RootItem.Font.Color = clMenuText
    RootItem.Font.Height = -11
    RootItem.Font.Name = 'Tahoma'
    RootItem.Font.Style = []
    RootItem.SelectedColor = 16773091
    RootItem.SelectedColorTo = 15185299
    RootItem.SelectedBorderColor = 9841920
    RootItem.HoverColor = 13432063
    RootItem.HoverColorTo = 10147583
    Glyphs.SubMenu.Data = {
      5A000000424D5A000000000000003E0000002800000004000000070000000100
      0100000000001C0000000000000000000000020000000200000000000000FFFF
      FF0070000000300000001000000000000000100000003000000070000000}
    Glyphs.Check.Data = {
      7E000000424D7E000000000000003E0000002800000010000000100000000100
      010000000000400000000000000000000000020000000200000000000000FFFF
      FF00FFFF0000FFFF0000FFFF0000FFFF0000FDFF0000F8FF0000F07F0000F23F
      0000F71F0000FF8F0000FFCF0000FFEF0000FFFF0000FFFF0000FFFF0000FFFF
      0000}
    Glyphs.Radio.Data = {
      7E000000424D7E000000000000003E0000002800000010000000100000000100
      010000000000400000000000000000000000020000000200000000000000FFFF
      FF00FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FC3F0000F81F0000F81F
      0000F81F0000F81F0000FC3F0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000}
    SideBar.Font.Charset = DEFAULT_CHARSET
    SideBar.Font.Color = clWhite
    SideBar.Font.Height = -19
    SideBar.Font.Name = 'Tahoma'
    SideBar.Font.Style = [fsBold, fsItalic]
    SideBar.Image.Position = bpCenter
    SideBar.Background.Position = bpCenter
    SideBar.SplitterColorTo = clBlack
    Separator.Color = 13339754
    Separator.GradientType = gtBoth
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    MenuBorderColor = 9841920
    Left = 400
    Top = 256
  end
  object styler2: TAdvToolBarOfficeStyler
    AdvMenuStyler = MainMenuStyle
    BackGroundTransparent = False
    BorderColor = 9671313
    BorderColorHot = 14731181
    ButtonAppearance.Color = 16640730
    ButtonAppearance.ColorTo = 14986888
    ButtonAppearance.ColorChecked = 9229823
    ButtonAppearance.ColorCheckedTo = 5812223
    ButtonAppearance.ColorDown = 5149182
    ButtonAppearance.ColorDownTo = 9556991
    ButtonAppearance.ColorHot = 13432063
    ButtonAppearance.ColorHotTo = 9556223
    ButtonAppearance.BorderColor = clInfoBk
    ButtonAppearance.BorderDownColor = clNavy
    ButtonAppearance.BorderHotColor = clNavy
    ButtonAppearance.BorderCheckedColor = clNavy
    ButtonAppearance.CaptionFont.Charset = DEFAULT_CHARSET
    ButtonAppearance.CaptionFont.Color = clWindowText
    ButtonAppearance.CaptionFont.Height = -13
    ButtonAppearance.CaptionFont.Name = 'Times New Roman'
    ButtonAppearance.CaptionFont.Style = [fsBold]
    CaptionAppearance.CaptionColor = clHighlight
    CaptionAppearance.CaptionColorTo = clHighlight
    CaptionAppearance.CaptionBorderColor = clHighlight
    CaptionAppearance.CaptionColorHot = 13432063
    CaptionAppearance.CaptionColorHotTo = 9556223
    CaptionAppearance.CaptionTextColorHot = clBlack
    CaptionFont.Charset = DEFAULT_CHARSET
    CaptionFont.Color = clWindowText
    CaptionFont.Height = -11
    CaptionFont.Name = 'MS Sans Serif'
    CaptionFont.Style = []
    ContainerAppearance.LineColor = clBtnShadow
    ContainerAppearance.Line3D = True
    Color.Color = 16640730
    Color.ColorTo = 14986888
    Color.Direction = gdVertical
    ColorHot.Color = 16773606
    ColorHot.ColorTo = 16444126
    ColorHot.Direction = gdVertical
    CompactGlowButtonAppearance.BorderColor = 14727579
    CompactGlowButtonAppearance.BorderColorHot = 10079963
    CompactGlowButtonAppearance.BorderColorDown = 4548219
    CompactGlowButtonAppearance.BorderColorChecked = 4548219
    CompactGlowButtonAppearance.Color = 15653832
    CompactGlowButtonAppearance.ColorTo = 16178633
    CompactGlowButtonAppearance.ColorChecked = 11918331
    CompactGlowButtonAppearance.ColorCheckedTo = 7915518
    CompactGlowButtonAppearance.ColorDisabled = 15921906
    CompactGlowButtonAppearance.ColorDisabledTo = 15921906
    CompactGlowButtonAppearance.ColorDown = 7778289
    CompactGlowButtonAppearance.ColorDownTo = 4296947
    CompactGlowButtonAppearance.ColorHot = 15465983
    CompactGlowButtonAppearance.ColorHotTo = 11332863
    CompactGlowButtonAppearance.ColorMirror = 15586496
    CompactGlowButtonAppearance.ColorMirrorTo = 16245200
    CompactGlowButtonAppearance.ColorMirrorHot = 5888767
    CompactGlowButtonAppearance.ColorMirrorHotTo = 10807807
    CompactGlowButtonAppearance.ColorMirrorDown = 946929
    CompactGlowButtonAppearance.ColorMirrorDownTo = 5021693
    CompactGlowButtonAppearance.ColorMirrorChecked = 10480637
    CompactGlowButtonAppearance.ColorMirrorCheckedTo = 5682430
    CompactGlowButtonAppearance.ColorMirrorDisabled = 11974326
    CompactGlowButtonAppearance.ColorMirrorDisabledTo = 15921906
    CompactGlowButtonAppearance.GradientHot = ggVertical
    CompactGlowButtonAppearance.GradientMirrorHot = ggVertical
    CompactGlowButtonAppearance.GradientDown = ggVertical
    CompactGlowButtonAppearance.GradientMirrorDown = ggVertical
    CompactGlowButtonAppearance.GradientChecked = ggVertical
    DockColor.Color = 16105376
    DockColor.ColorTo = 16440004
    DockColor.Direction = gdHorizontal
    DockColor.Steps = 128
    FloatingWindowBorderColor = 9516288
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    GlowButtonAppearance.BorderColor = 14727579
    GlowButtonAppearance.BorderColorHot = 10079963
    GlowButtonAppearance.BorderColorDown = 4548219
    GlowButtonAppearance.BorderColorChecked = 4548219
    GlowButtonAppearance.Color = 15653832
    GlowButtonAppearance.ColorTo = 16178633
    GlowButtonAppearance.ColorChecked = 11918331
    GlowButtonAppearance.ColorCheckedTo = 7915518
    GlowButtonAppearance.ColorDisabled = 15921906
    GlowButtonAppearance.ColorDisabledTo = 15921906
    GlowButtonAppearance.ColorDown = 7778289
    GlowButtonAppearance.ColorDownTo = 4296947
    GlowButtonAppearance.ColorHot = 15465983
    GlowButtonAppearance.ColorHotTo = 11332863
    GlowButtonAppearance.ColorMirror = 15586496
    GlowButtonAppearance.ColorMirrorTo = 16245200
    GlowButtonAppearance.ColorMirrorHot = 5888767
    GlowButtonAppearance.ColorMirrorHotTo = 10807807
    GlowButtonAppearance.ColorMirrorDown = 946929
    GlowButtonAppearance.ColorMirrorDownTo = 5021693
    GlowButtonAppearance.ColorMirrorChecked = 10480637
    GlowButtonAppearance.ColorMirrorCheckedTo = 5682430
    GlowButtonAppearance.ColorMirrorDisabled = 11974326
    GlowButtonAppearance.ColorMirrorDisabledTo = 15921906
    GlowButtonAppearance.GradientHot = ggVertical
    GlowButtonAppearance.GradientMirrorHot = ggVertical
    GlowButtonAppearance.GradientDown = ggVertical
    GlowButtonAppearance.GradientMirrorDown = ggVertical
    GlowButtonAppearance.GradientChecked = ggVertical
    GroupAppearance.BorderColor = 12763842
    GroupAppearance.Color = 16640730
    GroupAppearance.ColorTo = 15851212
    GroupAppearance.ColorMirror = 15851212
    GroupAppearance.ColorMirrorTo = 16640730
    GroupAppearance.Font.Charset = DEFAULT_CHARSET
    GroupAppearance.Font.Color = clWindowText
    GroupAppearance.Font.Height = -11
    GroupAppearance.Font.Name = 'Tahoma'
    GroupAppearance.Font.Style = []
    GroupAppearance.Gradient = ggVertical
    GroupAppearance.GradientMirror = ggVertical
    GroupAppearance.TextColor = clBlack
    GroupAppearance.CaptionAppearance.CaptionColor = 15915714
    GroupAppearance.CaptionAppearance.CaptionColorTo = 15784385
    GroupAppearance.CaptionAppearance.CaptionTextColor = clBlack
    GroupAppearance.CaptionAppearance.CaptionColorHot = 16769224
    GroupAppearance.CaptionAppearance.CaptionColorHotTo = 16772566
    GroupAppearance.CaptionAppearance.CaptionTextColorHot = clBlack
    GroupAppearance.PageAppearance.BorderColor = 12763842
    GroupAppearance.PageAppearance.Color = 14086910
    GroupAppearance.PageAppearance.ColorTo = 16382457
    GroupAppearance.PageAppearance.ColorMirror = 16382457
    GroupAppearance.PageAppearance.ColorMirrorTo = 16382457
    GroupAppearance.PageAppearance.Gradient = ggVertical
    GroupAppearance.PageAppearance.GradientMirror = ggVertical
    GroupAppearance.TabAppearance.BorderColor = clHighlight
    GroupAppearance.TabAppearance.BorderColorHot = clHighlight
    GroupAppearance.TabAppearance.BorderColorSelected = 10534860
    GroupAppearance.TabAppearance.BorderColorSelectedHot = 10534860
    GroupAppearance.TabAppearance.BorderColorDisabled = clNone
    GroupAppearance.TabAppearance.BorderColorDown = clNone
    GroupAppearance.TabAppearance.Color = clBtnFace
    GroupAppearance.TabAppearance.ColorTo = clWhite
    GroupAppearance.TabAppearance.ColorSelected = 10412027
    GroupAppearance.TabAppearance.ColorSelectedTo = 12249340
    GroupAppearance.TabAppearance.ColorDisabled = clNone
    GroupAppearance.TabAppearance.ColorDisabledTo = clNone
    GroupAppearance.TabAppearance.ColorHot = 13432063
    GroupAppearance.TabAppearance.ColorHotTo = 13432063
    GroupAppearance.TabAppearance.ColorMirror = clWhite
    GroupAppearance.TabAppearance.ColorMirrorTo = clWhite
    GroupAppearance.TabAppearance.ColorMirrorHot = 13432063
    GroupAppearance.TabAppearance.ColorMirrorHotTo = 9556223
    GroupAppearance.TabAppearance.ColorMirrorSelected = 12249340
    GroupAppearance.TabAppearance.ColorMirrorSelectedTo = 13955581
    GroupAppearance.TabAppearance.ColorMirrorDisabled = clNone
    GroupAppearance.TabAppearance.ColorMirrorDisabledTo = clNone
    GroupAppearance.TabAppearance.Font.Charset = DEFAULT_CHARSET
    GroupAppearance.TabAppearance.Font.Color = clWindowText
    GroupAppearance.TabAppearance.Font.Height = -11
    GroupAppearance.TabAppearance.Font.Name = 'Tahoma'
    GroupAppearance.TabAppearance.Font.Style = []
    GroupAppearance.TabAppearance.Gradient = ggVertical
    GroupAppearance.TabAppearance.GradientMirror = ggVertical
    GroupAppearance.TabAppearance.GradientHot = ggVertical
    GroupAppearance.TabAppearance.GradientMirrorHot = ggVertical
    GroupAppearance.TabAppearance.GradientSelected = ggVertical
    GroupAppearance.TabAppearance.GradientMirrorSelected = ggVertical
    GroupAppearance.TabAppearance.GradientDisabled = ggVertical
    GroupAppearance.TabAppearance.GradientMirrorDisabled = ggVertical
    GroupAppearance.TabAppearance.TextColor = clBlack
    GroupAppearance.TabAppearance.TextColorHot = clBlack
    GroupAppearance.TabAppearance.TextColorSelected = clBlack
    GroupAppearance.TabAppearance.TextColorDisabled = clWhite
    GroupAppearance.ToolBarAppearance.BorderColor = 13423059
    GroupAppearance.ToolBarAppearance.BorderColorHot = 13092807
    GroupAppearance.ToolBarAppearance.Color.Color = 15530237
    GroupAppearance.ToolBarAppearance.Color.ColorTo = 16382457
    GroupAppearance.ToolBarAppearance.Color.Direction = gdHorizontal
    GroupAppearance.ToolBarAppearance.ColorHot.Color = 15660277
    GroupAppearance.ToolBarAppearance.ColorHot.ColorTo = 16645114
    GroupAppearance.ToolBarAppearance.ColorHot.Direction = gdHorizontal
    PageAppearance.BorderColor = 14922381
    PageAppearance.Color = 16640730
    PageAppearance.ColorTo = 16440004
    PageAppearance.ColorMirror = 16440004
    PageAppearance.ColorMirrorTo = 16440004
    PageAppearance.Gradient = ggVertical
    PageAppearance.GradientMirror = ggVertical
    PagerCaption.BorderColor = 15780526
    PagerCaption.Color = 14986888
    PagerCaption.ColorTo = 14986888
    PagerCaption.ColorMirror = 14986888
    PagerCaption.ColorMirrorTo = 14986888
    PagerCaption.Gradient = ggVertical
    PagerCaption.GradientMirror = ggVertical
    PagerCaption.TextColor = clBlue
    PagerCaption.Font.Charset = DEFAULT_CHARSET
    PagerCaption.Font.Color = clWindowText
    PagerCaption.Font.Height = -11
    PagerCaption.Font.Name = 'Tahoma'
    PagerCaption.Font.Style = []
    RightHandleColor = clGreen
    RightHandleColorTo = clLime
    RightHandleColorHot = 13891839
    RightHandleColorHotTo = 7782911
    RightHandleColorDown = 557032
    RightHandleColorDownTo = 8182519
    TabAppearance.BorderColor = clNone
    TabAppearance.BorderColorHot = clHighlight
    TabAppearance.BorderColorSelected = 14922381
    TabAppearance.BorderColorSelectedHot = 6343929
    TabAppearance.BorderColorDisabled = clNone
    TabAppearance.BorderColorDown = clNone
    TabAppearance.Color = clBtnFace
    TabAppearance.ColorTo = clWhite
    TabAppearance.ColorSelected = 16709360
    TabAppearance.ColorSelectedTo = 16445929
    TabAppearance.ColorDisabled = clWhite
    TabAppearance.ColorDisabledTo = clSilver
    TabAppearance.ColorHot = 13432063
    TabAppearance.ColorHotTo = 13432063
    TabAppearance.ColorMirror = clWhite
    TabAppearance.ColorMirrorTo = clWhite
    TabAppearance.ColorMirrorHot = 13432063
    TabAppearance.ColorMirrorHotTo = 9556223
    TabAppearance.ColorMirrorSelected = 16445929
    TabAppearance.ColorMirrorSelectedTo = 16181984
    TabAppearance.ColorMirrorDisabled = clWhite
    TabAppearance.ColorMirrorDisabledTo = clSilver
    TabAppearance.Font.Charset = DEFAULT_CHARSET
    TabAppearance.Font.Color = clWindowText
    TabAppearance.Font.Height = -11
    TabAppearance.Font.Name = 'Tahoma'
    TabAppearance.Font.Style = []
    TabAppearance.Gradient = ggVertical
    TabAppearance.GradientMirror = ggVertical
    TabAppearance.GradientHot = ggVertical
    TabAppearance.GradientMirrorHot = ggVertical
    TabAppearance.GradientSelected = ggVertical
    TabAppearance.GradientMirrorSelected = ggVertical
    TabAppearance.GradientDisabled = ggVertical
    TabAppearance.GradientMirrorDisabled = ggVertical
    TabAppearance.TextColor = clBlack
    TabAppearance.TextColorHot = clBlack
    TabAppearance.TextColorSelected = clBlack
    TabAppearance.TextColorDisabled = clGray
    TabAppearance.BackGround.Color = 14986888
    TabAppearance.BackGround.ColorTo = 16440004
    TabAppearance.BackGround.Direction = gdVertical
    Left = 289
    Top = 201
  end
  object ApplicationEvents: TApplicationEvents
    OnException = ApplicationEventsException
    Left = 56
    Top = 64
  end
  object AddictSpell: TAddictSpell3
    ConfigStorage = csFile
    ConfigID = '%UserName%'
    ConfigFilename = '%AppDir%\Spell.cfg'
    ConfigRegistryKey = 'Software\Addictive Software\%AppName%'
    ConfigDictionaryDir.Strings = (
      '%AppDir%')
    ConfigAvailableOptions = [soPrimaryOnly, soRepeated]
    ConfigUseMSWordCustom = True
    ConfigDefaultMain.Strings = (
      'American.adm')
    ConfigDefaultActiveCustom = '%ConfigID%.adu'
    ConfigDefaultOptions = [soLiveSpelling, soLiveCorrect, soRepeated]
    ConfigDefaultUseMSWordCustom = False
    SuggestionsAutoReplace = False
    SuggestionsLearning = True
    SuggestionsLearningDict = '%AppDir%\%UserName%_sp.adl'
    QuoteChars = '>'
    DialogInitialPos = ipLastUserPos
    DialogSelectionAvoid = saAvoid
    DialogShowImmediate = False
    DialogShowModal = False
    EndMessage = emExceptCancel
    EndCursorPosition = epOriginal
    EndMessageWordCount = False
    MaxUndo = -1
    MaxSuggestions = -1
    KeepDictionariesActive = False
    SynchronousCheck = True
    UseHourglassCursor = True
    CommandsVisible = [sdcIgnore, sdcIgnoreAll, sdcChange, sdcChangeAll, sdcAdd, sdcAutoCorrect, sdcUndo, sdcHelp, sdcCancel, sdcOptions, sdcCustomDictionary, sdcCustomDictionaries, sdcConfigOK, sdcAddedEdit, sdcAutoCorrectEdit, sdcExcludedEdit, sdcInternalEdit, sdcMainDictFolderBrowse, sdcResetDefaults]
    CommandsEnabled = [sdcIgnore, sdcIgnoreAll, sdcChange, sdcChangeAll, sdcAdd, sdcAutoCorrect, sdcUndo, sdcHelp, sdcCancel, sdcOptions, sdcCustomDictionary, sdcCustomDictionaries, sdcConfigOK, sdcAddedEdit, sdcAutoCorrectEdit, sdcExcludedEdit, sdcInternalEdit, sdcMainDictFolderBrowse, sdcResetDefaults]
    PhoneticSuggestions = True
    PhoneticMaxDistance = 4
    PhoneticDivisor = 2
    PhoneticDepth = 2
    MappingAutoReplace = True
    UseExcludeWords = True
    UseAutoCorrectFirst = False
    RecheckReplacedWords = True
    ResumeFromLastPosition = True
    AllowedCases = cmInitialCapsOrUpcase
    UILanguage = ltEnglish
    UIType = suiDialog
    UILanguageFontControls.Charset = DEFAULT_CHARSET
    UILanguageFontControls.Color = clWindowText
    UILanguageFontControls.Height = -11
    UILanguageFontControls.Name = 'MS Sans Serif'
    UILanguageFontControls.Style = []
    UILanguageFontText.Charset = DEFAULT_CHARSET
    UILanguageFontText.Color = clWindowText
    UILanguageFontText.Height = -11
    UILanguageFontText.Name = 'MS Sans Serif'
    UILanguageFontText.Style = []
    UILanguageUseFonts = False
    Left = 24
    Top = 112
  end
end
