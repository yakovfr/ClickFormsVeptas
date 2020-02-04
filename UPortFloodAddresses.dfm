object AddressSelector: TAddressSelector
  Left = 545
  Top = 175
  Width = 666
  Height = 370
  Caption = 'Correct Address Selector'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object AddressList: TListBox
    Left = 0
    Top = 73
    Width = 658
    Height = 263
    Align = alClient
    ItemHeight = 13
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 658
    Height = 73
    Align = alTop
    TabOrder = 1
    DesignSize = (
      658
      73)
    object LabelMsg: TLabel
      Left = 8
      Top = 16
      Width = 521
      Height = 41
      AutoSize = False
      Caption = 
        'Your search for "street, city, state, zip, plus 4" has returned ' +
        'the following adresses. Please select the correct address from t' +
        'he list below and click "Locate" button to get the map. To cance' +
        'l and start over again, click "Cancel" button.'
      WordWrap = True
    end
    object btnSelect: TButton
      Left = 547
      Top = 8
      Width = 89
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Select'
      ModalResult = 1
      TabOrder = 0
    end
    object btnCancel: TButton
      Left = 547
      Top = 40
      Width = 89
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
end
