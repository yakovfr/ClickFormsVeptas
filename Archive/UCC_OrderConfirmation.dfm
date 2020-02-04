object CC_OrderConfirm: TCC_OrderConfirm
  Left = 531
  Top = 214
  Width = 699
  Height = 315
  Caption = 'Appraisal Order Confirmation'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 416
    Top = 8
    Width = 235
    Height = 13
    Caption = 'Is this the correct address of the subject property?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 416
    Top = 136
    Width = 233
    Height = 13
    Caption = 'Is this the correct Effective Date of the appraisal?'
  end
  object Label3: TLabel
    Left = 416
    Top = 32
    Width = 41
    Height = 13
    Caption = 'Address:'
  end
  object Label4: TLabel
    Left = 416
    Top = 56
    Width = 20
    Height = 13
    Caption = 'City:'
  end
  object Label5: TLabel
    Left = 416
    Top = 80
    Width = 28
    Height = 13
    Caption = 'State:'
  end
  object Label6: TLabel
    Left = 416
    Top = 104
    Width = 46
    Height = 13
    Caption = 'Zip Code;'
  end
  object lblPropertyAddress: TLabel
    Left = 496
    Top = 32
    Width = 92
    Height = 13
    Caption = 'propertyAddress'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblPropertyCity: TLabel
    Left = 496
    Top = 56
    Width = 68
    Height = 13
    Caption = 'propertyCity'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblPropertyState: TLabel
    Left = 496
    Top = 80
    Width = 77
    Height = 13
    Caption = 'propertyState'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblPropertyZip: TLabel
    Left = 496
    Top = 104
    Width = 65
    Height = 13
    Caption = 'propertyZip'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label7: TLabel
    Left = 416
    Top = 160
    Width = 71
    Height = 13
    Caption = 'Effective Date:'
  end
  object lblEffDate: TLabel
    Left = 496
    Top = 160
    Width = 57
    Height = 13
    Caption = 'lblEffDate'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object imgSubject: TImage
    Left = 0
    Top = 0
    Width = 385
    Height = 275
    Proportional = True
    Stretch = True
  end
  object Label8: TLabel
    Left = 416
    Top = 184
    Width = 58
    Height = 13
    Caption = 'Report type:'
  end
  object lblReportType: TLabel
    Left = 496
    Top = 184
    Width = 80
    Height = 13
    Caption = 'lblReportType'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object btnOk: TButton
    Left = 576
    Top = 232
    Width = 75
    Height = 25
    Caption = 'Yes'
    TabOrder = 0
    OnClick = btnOkClick
  end
  object btnCancel: TButton
    Left = 456
    Top = 232
    Width = 75
    Height = 25
    Caption = 'No'
    ModalResult = 2
    TabOrder = 1
  end
end
