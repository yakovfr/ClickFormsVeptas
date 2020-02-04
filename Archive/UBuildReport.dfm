object BuildReport: TBuildReport
  Left = 280
  Top = 114
  Width = 803
  Height = 743
  Caption = 'Report Selection'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 795
    Height = 78
    Align = alTop
    TabOrder = 0
    object Image1: TImage
      Left = 1
      Top = 1
      Width = 248
      Height = 76
      Align = alLeft
    end
    object chkOverwrite: TCheckBox
      Left = 277
      Top = 21
      Width = 137
      Height = 17
      Caption = 'Overwrite Existing Data.'
      Checked = True
      State = cbChecked
      TabOrder = 0
      OnClick = chkOverwriteClick
    end
    object chkUADConvert: TCheckBox
      Left = 477
      Top = 21
      Width = 205
      Height = 17
      Caption = 'Automatically Convert to UAD Format'
      Checked = True
      State = cbChecked
      TabOrder = 1
      OnClick = chkUADConvertClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 78
    Width = 795
    Height = 637
    Align = alClient
    TabOrder = 1
    object Label1: TLabel
      Left = 278
      Top = 75
      Width = 398
      Height = 16
      Caption = 'Please select the following items to include to your report:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object RptList: TCheckListBox
      Left = 278
      Top = 103
      Width = 407
      Height = 375
      ItemHeight = 13
      Items.Strings = (
        'Include FNMA 1004 MC'
        'Include Certification Pages'
        'Include Analytic Addendums')
      TabOrder = 0
    end
    object Panel4: TPanel
      Left = 278
      Top = 478
      Width = 407
      Height = 80
      TabOrder = 1
      object btnTransfer: TButton
        Left = 204
        Top = 28
        Width = 121
        Height = 25
        Caption = 'Transfer To Report'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = btnTransferClick
      end
      object btnClose: TButton
        Left = 344
        Top = 28
        Width = 35
        Height = 25
        Caption = 'Close'
        ModalResult = 2
        TabOrder = 1
        Visible = False
        OnClick = btnCloseClick
      end
    end
    object chkClose: TCheckBox
      Left = 286
      Top = 509
      Width = 172
      Height = 17
      Caption = 'Close After Transfer To Report'
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
  end
end
