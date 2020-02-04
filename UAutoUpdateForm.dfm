object AutoUpdateForm: TAutoUpdateForm
  Left = 579
  Top = 264
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'ClickFORMS Update'
  ClientHeight = 185
  ClientWidth = 420
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lblTitle: TLabel
    Left = 30
    Top = 10
    Width = 250
    Height = 21
    AutoSize = False
    Caption = 'ClickFORMS Update'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 12333824
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object grpStatus: TGroupBox
    Left = 30
    Top = 45
    Width = 360
    Height = 110
    TabOrder = 0
    object pcStatus: TPageControl
      Left = 2
      Top = 15
      Width = 356
      Height = 93
      ActivePage = tsUpdateAvailable
      Align = alClient
      Style = tsFlatButtons
      TabOrder = 0
      OnChanging = pcStatusChanging
      object tsHaveNotChecked: TTabSheet
        Caption = 'tsHaveNotChecked'
        ImageIndex = 3
        TabVisible = False
        object lblTitleHaveNotChecked: TLabel
          Left = 10
          Top = 0
          Width = 240
          Height = 21
          AutoSize = False
          Caption = 'Keep ClickFORMS up to date'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 12333824
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblDescriptionHaveNotChecked: TLabel
          Left = 10
          Top = 35
          Width = 330
          Height = 30
          AutoSize = False
          Caption = 'Check to see if you need updates for ClickFORMS.'
          WordWrap = True
        end
        object btnCheckNow: TButton
          Left = 260
          Top = 0
          Width = 75
          Height = 25
          Action = actCheckNow
          TabOrder = 0
        end
      end
      object tsChecking: TTabSheet
        Caption = 'tsChecking'
        ImageIndex = 4
        TabVisible = False
        object lblTitleChecking: TLabel
          Left = 10
          Top = 0
          Width = 250
          Height = 21
          AutoSize = False
          Caption = 'Checking for updates...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 12333824
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object prgChecking: TCFProgressBar
          Left = 10
          Top = 30
          Width = 250
          Height = 17
          Marquee = True
          TabOrder = 0
        end
      end
      object tsMaintenanceExpired: TTabSheet
        Caption = 'tsMaintenanceExpired'
        ImageIndex = 5
        TabVisible = False
        object lblDescriptionMaintenanceExpired: TLabel
          Left = 10
          Top = 35
          Width = 330
          Height = 45
          AutoSize = False
          Caption = 
            'Your ClickFORMS software maintenance plan has expired.  In order' +
            ' to continue receiving updates, you must renew by calling 800-62' +
            '2-8727.'
          WordWrap = True
        end
        object lblTitleMaintenanceExpired: TLabel
          Left = 10
          Top = 0
          Width = 240
          Height = 21
          AutoSize = False
          Caption = 'Software maintenance expired'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 12333824
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
      end
      object tsNoUpdateAvailable: TTabSheet
        Caption = 'tsNoUpdateAvailable'
        TabVisible = False
        object lblTitleNoUpdateAvailable: TLabel
          Left = 10
          Top = 0
          Width = 250
          Height = 21
          AutoSize = False
          Caption = 'ClickFORMS is up to date'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 12333824
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblDescriptionNoUpdateAvailable: TLabel
          Left = 10
          Top = 35
          Width = 330
          Height = 15
          AutoSize = False
          Caption = 'There are no updates available for ClickFORMS.'
        end
      end
      object tsUpdateAvailable: TTabSheet
        Caption = 'tsUpdateAvailable'
        ImageIndex = 6
        TabVisible = False
        object lblDescriptionUpdateAvailable: TLabel
          Left = 10
          Top = 51
          Width = 330
          Height = 30
          AutoSize = False
          Caption = 'Important updates are available for ClickFORMS.'
          WordWrap = True
        end
        object lblTitleUpdateAvailable: TLabel
          Left = 10
          Top = 0
          Width = 240
          Height = 21
          AutoSize = False
          Caption = 'Download and install updates'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 12333824
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object btnDownload: TButton
          Left = 12
          Top = 24
          Width = 75
          Height = 25
          Action = actDownload
          TabOrder = 0
        end
      end
      object tsDownloading: TTabSheet
        Caption = 'tsDownloading'
        ImageIndex = 2
        TabVisible = False
        object lblTitleDownloading: TLabel
          Left = 10
          Top = 0
          Width = 250
          Height = 21
          AutoSize = False
          Caption = 'Downloading updates...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 12333824
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblDescriptionDownloading: TLabel
          Left = 10
          Top = 60
          Width = 330
          Height = 15
          AutoSize = False
          Caption = 'Downloading update (0% complete)'
        end
        object prgDownloading: TCFProgressBar
          Left = 10
          Top = 35
          Width = 250
          Height = 17
          TabOrder = 0
        end
        object btnCancel: TButton
          Left = 260
          Top = 0
          Width = 75
          Height = 25
          Action = actCancel
          TabOrder = 1
        end
      end
      object tsUpdateDownloaded: TTabSheet
        Caption = 'tsUpdateDownloaded'
        ImageIndex = 3
        TabVisible = False
        object lblTitleUpdateDownloaded: TLabel
          Left = 10
          Top = 0
          Width = 240
          Height = 21
          AutoSize = False
          Caption = 'Install updates for ClickFORMS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 12333824
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblDescriptionUpdateDownloaded: TLabel
          Left = 10
          Top = 51
          Width = 330
          Height = 30
          AutoSize = False
          Caption = 
            'Always install the latest updates to enhance ClickFORMS'#39's perfor' +
            'mance and obtain the most current appraisal forms.'
          WordWrap = True
        end
        object btnInstall: TButton
          Left = 12
          Top = 24
          Width = 75
          Height = 25
          Action = actInstall
          TabOrder = 0
        end
      end
      object tsError: TTabSheet
        Caption = 'tsError'
        ImageIndex = 7
        TabVisible = False
        object lblDescriptionError: TLabel
          Left = 10
          Top = 35
          Width = 330
          Height = 15
          AutoSize = False
        end
        object lblTitleError: TLabel
          Left = 10
          Top = 0
          Width = 250
          Height = 21
          AutoSize = False
          Caption = 'The updates were not installed.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 12333824
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object btnTryAgain: TButton
          Left = 260
          Top = 0
          Width = 75
          Height = 25
          Action = actTryAgain
          TabOrder = 0
        end
      end
    end
  end
  object tiUpdateNotification: TRzTrayIcon
    Enabled = False
    HideOnMinimize = False
    PopupMenu = pmUpdate
    RestoreOn = ticNone
    OnBalloonHintClick = tiUpdateNotificationBalloonHintClick
    OnLButtonDblClick = tiUpdateNotificationLButtonDblClick
    Left = 360
  end
  object alUpdate: TActionList
    Left = 288
    object actCancel: TAction
      Caption = '&Cancel'
      OnExecute = actCancelExecute
      OnUpdate = actCancelUpdate
    end
    object actCheckNow: TAction
      Caption = '&Check Now'
      OnExecute = actCheckNowExecute
      OnUpdate = actCheckNowUpdate
    end
    object actDownload: TAction
      Caption = '&Install'
      OnExecute = actDownloadExecute
      OnUpdate = actDownloadUpdate
    end
    object actInstall: TAction
      Caption = '&Install'
      OnExecute = actInstallExecute
      OnUpdate = actInstallUpdate
    end
    object actOpen: TAction
      Caption = '&Open ClickFORMS Update'
      OnExecute = actOpenExecute
      OnUpdate = actOpenUpdate
    end
    object actTryAgain: TAction
      Caption = '&Try Again'
      OnExecute = actTryAgainExecute
      OnUpdate = actTryAgainUpdate
    end
  end
  object pmUpdate: TPopupMenu
    Left = 232
    object miOpen: TMenuItem
      Action = actOpen
      Default = True
    end
    object miInstall: TMenuItem
      Action = actDownload
    end
  end
end
