object UserValidationCmnt: TUserValidationCmnt
  Left = 328
  Top = 173
  Width = 870
  Height = 340
  Caption = 'Centract Quailty Review Comment'
  Color = clBtnFace
  Constraints.MinHeight = 284
  Constraints.MinWidth = 870
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblCommentDesc: TLabel
    Left = 23
    Top = 12
    Width = 53
    Height = 13
    Caption = 'Description'
  end
  object lblAppraiserResp: TLabel
    Left = 23
    Top = 65
    Width = 102
    Height = 13
    Caption = '* Appraiser Response'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblCharsRemaining: TLabel
    Left = 19
    Top = 267
    Width = 107
    Height = 13
    Caption = 'Characters Remaining '
  end
  object lblMandatory: TLabel
    Left = 20
    Top = 285
    Width = 104
    Height = 13
    Caption = '* Fields are mandatory'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object lblAppraiserComment: TLabel
    Left = 31
    Top = 91
    Width = 96
    Height = 13
    Caption = 'Appraiser Comments'
  end
  object edtDescr: TEdit
    Left = 7
    Top = 28
    Width = 841
    Height = 21
    TabStop = False
    ReadOnly = True
    TabOrder = 0
  end
  object mmComment: TMemo
    Left = 7
    Top = 108
    Width = 841
    Height = 146
    MaxLength = 5000
    ScrollBars = ssVertical
    TabOrder = 3
    OnChange = mmCommentChange
  end
  object bbtnCancel: TBitBtn
    Left = 752
    Top = 261
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 6
    NumGlyphs = 2
  end
  object bbtnOK: TBitBtn
    Left = 640
    Top = 261
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 5
    OnClick = bbtnOKClick
    NumGlyphs = 2
  end
  object bbtnStdCmnt: TBitBtn
    Left = 440
    Top = 261
    Width = 161
    Height = 25
    Caption = 'Information Provided in Report'
    TabOrder = 4
    OnClick = bbtnStdCmntClick
    NumGlyphs = 2
  end
  object meCharBal: TMaskEdit
    Left = 128
    Top = 263
    Width = 31
    Height = 21
    Color = clMoneyGreen
    ReadOnly = True
    TabOrder = 7
    Text = '5000'
  end
  object rbRespYes: TRadioButton
    Left = 135
    Top = 63
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 1
    OnClick = rbRespYesClick
  end
  object rbRespNo: TRadioButton
    Left = 185
    Top = 63
    Width = 43
    Height = 17
    Caption = 'No'
    TabOrder = 2
    OnClick = rbRespNoClick
  end
end
