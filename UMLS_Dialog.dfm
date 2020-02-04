object MLSDialog: TMLSDialog
  Left = 581
  Top = 115
  Width = 736
  Height = 659
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'MLS Data Compliance Review'
  Color = clBtnFace
  Constraints.MinHeight = 500
  Constraints.MinWidth = 736
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 351
    Width = 728
    Height = 277
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object Label3: TLabel
      Left = 24
      Top = 40
      Width = 625
      Height = 13
      Caption = 
        'If the MLS provider has changed, field names will no longer matc' +
        'h.  Enter your contact information below and '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbSend: TLabel
      Left = 192
      Top = 120
      Width = 3
      Height = 13
      Caption = '.'
    end
    object Label8: TLabel
      Left = 24
      Top = 56
      Width = 644
      Height = 13
      Caption = 
        'the best time to reach you.  Click "Send Comments to MLS Mapping' +
        ' Team" in the lower left corner of this display.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btnSendEmail: TBitBtn
      Left = 16
      Top = 232
      Width = 217
      Height = 25
      Caption = 'Send Comments to MLS Mapping Team'
      TabOrder = 0
      OnClick = SendToMLSTeamClick
    end
    object btnContinue: TBitBtn
      Left = 480
      Top = 232
      Width = 113
      Height = 25
      Caption = 'Continue to Import'
      ModalResult = 2
      TabOrder = 1
    end
    object btnCancel: TBitBtn
      Left = 625
      Top = 232
      Width = 80
      Height = 25
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 2
    end
    object Memo1: TMemo
      Left = 16
      Top = 80
      Width = 689
      Height = 145
      Lines.Strings = (
        'Fields I would like to see included in my report: '
        ''
        ''
        'The best time to reach me is: ')
      TabOrder = 3
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 728
    Height = 57
    Align = alTop
    BevelOuter = bvSpace
    TabOrder = 1
    object Label4: TLabel
      Left = 8
      Top = 12
      Width = 70
      Height = 13
      Caption = 'MLS Name :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbMLSName: TLabel
      Left = 88
      Top = 12
      Width = 623
      Height = 13
      AutoSize = False
      Caption = 'lbMLSName'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 8
      Top = 36
      Width = 58
      Height = 13
      Caption = 'MLS File :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbMLSFile: TLabel
      Left = 88
      Top = 36
      Width = 623
      Height = 13
      AutoSize = False
      Caption = 'lbMLSFile'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 57
    Width = 728
    Height = 294
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object Panel4: TPanel
      Left = 0
      Top = 0
      Width = 728
      Height = 73
      Align = alTop
      TabOrder = 0
      object Label2: TLabel
        Left = 112
        Top = 12
        Width = 508
        Height = 13
        Caption = 
          'If there are fields shown below, you need to add them to your cu' +
          'stom MLS Export Report.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblVisitAppraisalWorld: TLabel
        Left = 143
        Top = 44
        Width = 342
        Height = 13
        Caption = 'http://www.appraisalworld.com/i2/mls-data-compliance.html'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        OnClick = VisitAppraisalWorldClick
      end
      object Label5: TLabel
        Left = 104
        Top = 44
        Width = 39
        Height = 13
        Caption = 'Visit: "'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label7: TLabel
        Left = 488
        Top = 44
        Width = 99
        Height = 13
        Caption = '" for instructions.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object Panel5: TPanel
      Left = 0
      Top = 73
      Width = 1
      Height = 221
      Align = alLeft
      TabOrder = 1
    end
    object Panel6: TPanel
      Left = 1
      Top = 73
      Width = 727
      Height = 221
      Align = alClient
      TabOrder = 2
      object lbxFieldList: TListBox
        Left = 1
        Top = 1
        Width = 725
        Height = 219
        Align = alClient
        ItemHeight = 13
        TabOrder = 0
      end
    end
  end
end
