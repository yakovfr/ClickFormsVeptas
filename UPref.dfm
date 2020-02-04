object Prefs: TPrefs
  Left = 859
  Top = 185
  Width = 773
  Height = 570
  Caption = 'Preferences'
  Color = clBtnFace
  Constraints.MaxHeight = 725
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 498
    Width = 765
    Height = 41
    Align = alBottom
    Anchors = []
    TabOrder = 0
    DesignSize = (
      765
      41)
    object btnCancel: TButton
      Left = 675
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 2
    end
    object btnOK: TButton
      Left = 587
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 1
    end
    object btnApply: TButton
      Left = 499
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Apply'
      TabOrder = 0
      OnClick = btnApplyClick
    end
  end
  object PgCntl: TPageControl
    Left = 160
    Top = 0
    Width = 605
    Height = 498
    ActivePage = AppStartup
    Align = alClient
    TabOrder = 1
    object AppStartup: TTabSheet
      Tag = 1
      Caption = 'AppStartup'
      TabVisible = False
      OnShow = PrefCategoryShow
    end
    object AppFolders: TTabSheet
      Tag = 2
      Caption = 'AppFolders'
      ImageIndex = 1
      TabVisible = False
      OnShow = PrefCategoryShow
    end
    object AppDatabases: TTabSheet
      Tag = 3
      Caption = 'AppDatabases'
      ImageIndex = 2
      TabVisible = False
      OnShow = PrefCategoryShow
    end
    object AppSaving: TTabSheet
      Tag = 4
      Caption = 'AppSaving'
      ImageIndex = 3
      TabVisible = False
      OnShow = PrefCategoryShow
    end
    object AppUpdate: TTabSheet
      Tag = 6
      Caption = 'AppUpdate'
      ImageIndex = 4
      TabVisible = False
      OnShow = PrefCategoryShow
    end
    object AppPDF: TTabSheet
      Tag = 5
      Caption = 'AppPDF'
      ImageIndex = 5
      TabVisible = False
      OnShow = PrefCategoryShow
    end
    object AppPhotoInBox: TTabSheet
      Tag = 7
      Caption = 'AppPhotoInBox'
      ImageIndex = 6
      TabVisible = False
      OnShow = PrefCategoryShow
    end
    object docOperation: TTabSheet
      Tag = 21
      Caption = 'docOperation'
      ImageIndex = 7
      TabVisible = False
      OnShow = PrefCategoryShow
    end
    object docDisplay: TTabSheet
      Tag = 22
      Caption = 'docDisplay'
      ImageIndex = 8
      TabVisible = False
      OnShow = PrefCategoryShow
    end
    object docPrinting: TTabSheet
      Tag = 23
      Caption = 'docPrinting'
      ImageIndex = 9
      TabVisible = False
      OnShow = PrefCategoryShow
    end
    object docColor: TTabSheet
      Tag = 24
      Caption = 'docColor'
      ImageIndex = 10
      TabVisible = False
      OnShow = PrefCategoryShow
    end
    object docFonts: TTabSheet
      Tag = 25
      Caption = 'docFonts'
      ImageIndex = 11
      TabVisible = False
      OnShow = PrefCategoryShow
    end
    object docFormatting: TTabSheet
      Tag = 26
      Caption = 'docFormatting'
      ImageIndex = 12
      TabVisible = False
      OnShow = PrefCategoryShow
    end
    object appUsers: TTabSheet
      Tag = 41
      Caption = 'appUsers'
      ImageIndex = 13
      TabVisible = False
      OnShow = PrefCategoryShow
    end
    object toolBuiltIn: TTabSheet
      Tag = 51
      Caption = 'toolBuiltIn'
      ImageIndex = 14
      TabVisible = False
      OnShow = PrefCategoryShow
    end
    object toolPlugIn: TTabSheet
      Tag = 52
      Caption = 'toolPlugIn'
      ImageIndex = 15
      TabVisible = False
      OnShow = PrefCategoryShow
    end
    object toolUserDefined: TTabSheet
      Tag = 53
      Caption = 'toolUserDefined'
      ImageIndex = 16
      TabVisible = False
      OnShow = PrefCategoryShow
    end
    object toolSketcher: TTabSheet
      Tag = 54
      Caption = 'toolSketcher'
      ImageIndex = 17
      TabVisible = False
      OnShow = PrefCategoryShow
    end
    object apprsalXFers: TTabSheet
      Tag = 71
      Caption = 'apprsalXFers'
      ImageIndex = 19
      ParentShowHint = False
      ShowHint = True
      TabVisible = False
      OnShow = PrefCategoryShow
    end
    object apprsalCalcs: TTabSheet
      Tag = 72
      Caption = 'apprsalCalcs'
      ImageIndex = 20
      TabVisible = False
      OnShow = PrefCategoryShow
    end
    object appUserLicInfo: TTabSheet
      Tag = 42
      Caption = 'userLicInfo'
      ImageIndex = 21
      TabVisible = False
      OnShow = PrefCategoryShow
    end
    object AppFiletypes: TTabSheet
      Tag = 74
      Caption = 'AppFiletypes'
      ImageIndex = 23
      TabVisible = False
      OnShow = PrefCategoryShow
    end
    object appUserFHACertificates: TTabSheet
      Tag = 43
      Caption = 'Manage FHA Digital  Signatures and Certificates'
      ImageIndex = 22
      TabVisible = False
      OnShow = PrefCategoryShow
    end
  end
  object RzGroupBar: TRzGroupBar
    Left = 0
    Top = 0
    Height = 498
    GroupBorderSize = 8
    UseGradients = True
    Color = clBtnShadow
    ParentColor = False
    TabOrder = 2
    object AppPrefs: TRzGroup
      Items = <
        item
          Caption = 'Startup'
          Tag = 1
          OnClick = PreferenceClick
        end
        item
          Caption = 'Folders'
          Tag = 2
          OnClick = PreferenceClick
        end
        item
          Caption = 'Databases'
          Tag = 3
          OnClick = PreferenceClick
        end
        item
          Caption = 'Saving'
          Tag = 4
          OnClick = PreferenceClick
        end
        item
          Caption = 'Auto Updatnig'
          Tag = 5
          Visible = False
          OnClick = PreferenceClick
        end
        item
          Caption = 'PDF Creator'
          Tag = 6
          OnClick = PreferenceClick
        end
        item
          Caption = 'Photo Inbox'
          Tag = 7
          OnClick = PreferenceClick
        end
        item
          Caption = 'Set Orders File Associations'
          Tag = 74
          OnClick = PreferenceClick
        end>
      Opened = True
      OpenedHeight = 180
      SelectionColor = clBtnHighlight
      UseGradients = True
      OnClose = AppPrefsClose
      Caption = 'Application'
      ParentColor = False
    end
    object Document: TRzGroup
      Items = <
        item
          Caption = 'Operation'
          Tag = 21
          OnClick = PreferenceClick
        end
        item
          Caption = 'Display'
          Tag = 22
          OnClick = PreferenceClick
        end
        item
          Caption = 'Printing'
          Tag = 23
          OnClick = PreferenceClick
        end
        item
          Caption = 'Colors'
          Tag = 24
          OnClick = PreferenceClick
        end
        item
          Caption = 'Fonts'
          Tag = 25
          OnClick = PreferenceClick
        end
        item
          Caption = 'Formatting'
          Tag = 26
          OnClick = PreferenceClick
        end>
      Opened = True
      OpenedHeight = 147
      SelectionColor = clBtnHighlight
      UseGradients = True
      Caption = 'Document'
      ParentColor = False
    end
    object Users: TRzGroup
      Items = <
        item
          Caption = 'Licenses'
          Tag = 41
          OnClick = PreferenceClick
        end
        item
          Caption = 'License Info'
          Tag = 42
          OnClick = PreferenceClick
        end
        item
          Caption = 'FHA Digital Sig Cert.'
          Tag = 43
          OnClick = PreferenceClick
        end>
      Opened = True
      OpenedHeight = 87
      SelectionColor = clBtnHighlight
      UseGradients = True
      Caption = 'Users'
      ParentColor = False
    end
    object Tools: TRzGroup
      Items = <
        item
          Caption = 'Built-In'
          Tag = 51
          OnClick = PreferenceClick
        end
        item
          Caption = 'Plug-Ins'
          Tag = 52
          OnClick = PreferenceClick
        end
        item
          Caption = 'User Specified'
          Tag = 53
          OnClick = PreferenceClick
        end
        item
          Caption = 'Sketcher Preference'
          Tag = 54
          OnClick = PreferenceClick
        end>
      Opened = True
      OpenedHeight = 107
      SelectionColor = clBtnHighlight
      UseGradients = True
      Caption = 'Tools'
      ParentColor = False
    end
    object Appraisal: TRzGroup
      Items = <
        item
          Caption = 'Transfers'
          Tag = 71
          OnClick = PreferenceClick
        end
        item
          Caption = 'Calculations'
          Tag = 72
          OnClick = PreferenceClick
        end>
      Opened = True
      OpenedHeight = 67
      SelectionColor = clBtnHighlight
      UseGradients = True
      Caption = 'Appraisal'
      ParentColor = False
    end
  end
end
