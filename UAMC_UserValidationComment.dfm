object AMCUserValidationCmnt: TAMCUserValidationCmnt
  Left = 525
  Top = 329
  Width = 882
  Height = 454
  Caption = 'Question or Message Response'
  Color = clBtnFace
  Constraints.MinHeight = 284
  Constraints.MinWidth = 870
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 16
  object Panel1: TPanel
    Left = 0
    Top = 341
    Width = 864
    Height = 70
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      864
      70)
    object lblCharsRemaining: TLabel
      Left = 34
      Top = 25
      Width = 158
      Height = 16
      Alignment = taRightJustify
      Anchors = [akLeft, akBottom]
      Caption = 'Characters Remaining '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblMandatory: TLabel
      Left = 36
      Top = 48
      Width = 201
      Height = 16
      Anchors = [akLeft, akBottom]
      Caption = '* Fields in red are mandatory'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object meCharBal: TMaskEdit
      Left = 203
      Top = 20
      Width = 38
      Height = 24
      Anchors = [akLeft, akBottom]
      Color = clMoneyGreen
      ReadOnly = True
      TabOrder = 0
    end
    object bbtnOK: TBitBtn
      Left = 788
      Top = 22
      Width = 92
      Height = 31
      Anchors = [akLeft, akBottom]
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 1
      NumGlyphs = 2
    end
    object bbtnCancel: TBitBtn
      Left = 926
      Top = 22
      Width = 92
      Height = 31
      Anchors = [akLeft, akBottom]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 2
      NumGlyphs = 2
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 864
    Height = 341
    Align = alClient
    TabOrder = 1
    object lblCommentDesc: TLabel
      Left = 28
      Top = 15
      Width = 148
      Height = 16
      Caption = 'Question or Message'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblAppraiserComment: TLabel
      Left = 28
      Top = 111
      Width = 145
      Height = 16
      Caption = 'Appraiser Comments'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object mmDescr: TMemo
      Left = 9
      Top = 34
      Width = 1032
      Height = 71
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
    object rbRespYes: TRzRadioButton
      Left = 225
      Top = 108
      Width = 58
      Height = 21
      Caption = 'Yes'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = rbRespYesClick
    end
    object rbRespNo: TRzRadioButton
      Left = 292
      Top = 108
      Width = 53
      Height = 21
      Caption = 'No'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = rbRespNoClick
    end
    object mmComment: TMemo
      Left = 9
      Top = 133
      Width = 1035
      Height = 180
      MaxLength = 1200
      ScrollBars = ssVertical
      TabOrder = 3
      OnChange = mmCommentChange
    end
  end
end
