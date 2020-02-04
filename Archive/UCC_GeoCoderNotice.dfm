object OutlierNotice: TOutlierNotice
  Left = 706
  Top = 251
  Width = 542
  Height = 177
  Caption = 'Remove Properties Outside of Market Area'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblSalesCount: TLabel
    Left = 88
    Top = 16
    Width = 213
    Height = 13
    Caption = 'XX Sales are located outside the market area'
  end
  object WarningIcon: TImage
    Left = 24
    Top = 16
    Width = 41
    Height = 41
    Picture.Data = {
      07544269746D617076020000424D760200000000000076000000280000002000
      0000200000000100040000000000000200000000000000000000100000000000
      0000000000000000800000800000008080008000000080008000808000008080
      8000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
      FF00888887777777777777777777777777888888777777777777777777777777
      77788830000000000000000000000007777783BBBBBBBBBBBBBBBBBBBBBBBB80
      77773BBBBBBBBBBBBBBBBBBBBBBBBBB807773BBBBBBBBBBBBBBBBBBBBBBBBBBB
      07773BBBBBBBBBBBB8008BBBBBBBBBBB07783BBBBBBBBBBBB0000BBBBBBBBBB8
      077883BBBBBBBBBBB0000BBBBBBBBBB0778883BBBBBBBBBBB8008BBBBBBBBB80
      7788883BBBBBBBBBBBBBBBBBBBBBBB077888883BBBBBBBBBBB0BBBBBBBBBB807
      78888883BBBBBBBBB808BBBBBBBBB07788888883BBBBBBBBB303BBBBBBBB8077
      888888883BBBBBBBB000BBBBBBBB0778888888883BBBBBBB80008BBBBBB80778
      8888888883BBBBBB30003BBBBBB077888888888883BBBBBB00000BBBBB807788
      88888888883BBBBB00000BBBBB07788888888888883BBBBB00000BBBB8077888
      888888888883BBBB00000BBBB0778888888888888883BBBB00000BBB80778888
      8888888888883BBB80008BBB077888888888888888883BBBBBBBBBB807788888
      88888888888883BBBBBBBBB07788888888888888888883BBBBBBBB8077888888
      888888888888883BBBBBBB0778888888888888888888883BBBBBB80778888888
      8888888888888883BBBBB077888888888888888888888883BBBB807888888888
      88888888888888883BB808888888888888888888888888888333888888888888
      8888}
    Transparent = True
  end
  object lblListingsCount: TLabel
    Left = 88
    Top = 62
    Width = 222
    Height = 13
    Caption = 'YY Listings are located outside the market area'
  end
  object cbxRemoveSales: TCheckBox
    Left = 107
    Top = 38
    Width = 417
    Height = 17
    Caption = 
      'Exclude the XX Sales that are outside of the market area from fu' +
      'rther consideration'
    TabOrder = 0
    OnClick = cbxRemoveOutliersClick
  end
  object cbxRemoveListings: TCheckBox
    Left = 107
    Top = 81
    Width = 401
    Height = 17
    Caption = 
      'Exclude the XX Listings that are outside of the market area from' +
      ' further consideration'
    TabOrder = 1
    OnClick = cbxRemoveOutliersClick
  end
  object btnRemove: TButton
    Left = 88
    Top = 113
    Width = 97
    Height = 25
    Caption = 'Exclude'
    Enabled = False
    ModalResult = 1
    TabOrder = 2
  end
  object btnNoRemoval: TButton
    Left = 224
    Top = 113
    Width = 99
    Height = 25
    Caption = 'Do Not Exclude'
    ModalResult = 2
    TabOrder = 3
  end
end
