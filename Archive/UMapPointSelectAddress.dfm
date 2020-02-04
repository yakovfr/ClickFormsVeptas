object MapPointSelectAddress: TMapPointSelectAddress
  Left = 604
  Top = 254
  Width = 442
  Height = 288
  Caption = 'Select Correct Address'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object NotebookAddresses: TNotebook
    Left = 0
    Top = 0
    Width = 434
    Height = 254
    Align = alClient
    TabOrder = 0
    object TPage
      Left = 0
      Top = 0
      Caption = 'SelectPage'
      object LabelSelectListTitle: TLabel
        Left = 8
        Top = 49
        Width = 93
        Height = 13
        Caption = 'Search Results For:'
      end
      object LabelSelectMsg: TLabel
        Left = 9
        Top = 8
        Width = 384
        Height = 26
        Caption = 
          'The MapPoint server returned the following close matches for the' +
          ' address below. Please select the correct address and click the ' +
          'Locate button.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object UnkownAddress: TLabel
        Left = 106
        Top = 49
        Width = 46
        Height = 13
        Caption = 'Address'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object ListBoxAddresses: TListBox
        Left = 8
        Top = 72
        Width = 417
        Height = 128
        ItemHeight = 13
        TabOrder = 0
        OnDblClick = ListBoxAddressesDblClick
      end
      object ButtonUseSelected: TButton
        Left = 344
        Top = 215
        Width = 78
        Height = 25
        Caption = 'Locate'
        TabOrder = 1
        OnClick = ButtonUseSelectedClick
      end
      object ButtonFindAnother: TButton
        Left = 212
        Top = 215
        Width = 75
        Height = 25
        Caption = '&Find Another'
        TabOrder = 2
        Visible = False
        OnClick = ButtonFindAnotherClick
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'FindPage'
      object LabelStreet: TLabel
        Left = 9
        Top = 10
        Width = 31
        Height = 13
        Caption = 'Street:'
      end
      object Label2: TLabel
        Left = 9
        Top = 53
        Width = 20
        Height = 13
        Caption = 'City:'
      end
      object Label1: TLabel
        Left = 176
        Top = 53
        Width = 28
        Height = 13
        Caption = 'State:'
      end
      object Label3: TLabel
        Left = 224
        Top = 53
        Width = 18
        Height = 13
        Caption = 'Zip:'
      end
      object Label4: TLabel
        Left = 8
        Top = 112
        Width = 38
        Height = 13
        Caption = 'Results:'
      end
      object ButtonFind: TButton
        Left = 341
        Top = 68
        Width = 75
        Height = 22
        Caption = '&Find'
        TabOrder = 0
        OnClick = ButtonFindClick
      end
      object EditStreet: TEdit
        Left = 8
        Top = 25
        Width = 313
        Height = 21
        TabOrder = 1
      end
      object EditCity: TEdit
        Left = 8
        Top = 68
        Width = 161
        Height = 21
        TabOrder = 2
      end
      object EditState: TEdit
        Left = 176
        Top = 68
        Width = 41
        Height = 21
        MaxLength = 2
        TabOrder = 3
      end
      object EditZip: TEdit
        Left = 224
        Top = 68
        Width = 96
        Height = 21
        MaxLength = 10
        TabOrder = 4
      end
      object ListBoxFindAddresses: TListBox
        Left = 8
        Top = 128
        Width = 409
        Height = 121
        ItemHeight = 13
        TabOrder = 5
      end
      object ButtonFindSelected: TButton
        Left = 293
        Top = 255
        Width = 129
        Height = 25
        Caption = '&Use Selected Address'
        TabOrder = 6
        OnClick = ButtonFindSelectedClick
      end
    end
  end
end
