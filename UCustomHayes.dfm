object CustomHayes: TCustomHayes
  Left = 567
  Top = 217
  Width = 445
  Height = 138
  Caption = 'Rally Accounting'
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
  object ProgressLabel: TLabel
    Left = 16
    Top = 80
    Width = 57
    Height = 13
    AutoSize = False
    Caption = 'Data'
  end
  object rdoSendOption1: TRadioButton
    Left = 16
    Top = 20
    Width = 177
    Height = 17
    Caption = 'Send Initial Appraisal Order'
    TabOrder = 0
  end
  object btnSend: TButton
    Left = 344
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Send'
    TabOrder = 1
    OnClick = btnSendClick
  end
  object btnCancel: TButton
    Left = 344
    Top = 72
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object rdoSendOption2: TRadioButton
    Left = 16
    Top = 49
    Width = 257
    Height = 17
    Caption = 'Send Completed Appraisal Report and Fee Splits'
    TabOrder = 3
  end
  object ProgressBar: TProgressBar
    Left = 80
    Top = 80
    Width = 185
    Height = 16
    TabOrder = 4
  end
  object FTPClient: TIdFTP
    AutoLogin = True
    TransferType = ftASCII
    ProxySettings.ProxyType = fpcmNone
    ProxySettings.Port = 0
    Left = 296
    Top = 8
  end
end
