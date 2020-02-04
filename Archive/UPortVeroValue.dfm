object PortVeroValue: TPortVeroValue
  Left = 523
  Top = 191
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'VeroValue Automated Property Analysis'
  ClientHeight = 236
  ClientWidth = 428
  Color = clBtnFace
  Constraints.MaxWidth = 545
  Constraints.MinWidth = 444
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 428
    Height = 236
    Align = alClient
    TabOrder = 0
    object MiddelBox: TGroupBox
      Left = 1
      Top = 73
      Width = 426
      Height = 103
      Align = alClient
      Caption = 'Property Address'
      TabOrder = 1
      object LabelStreet: TLabel
        Left = 6
        Top = 24
        Width = 31
        Height = 13
        Caption = 'Street:'
      end
      object LabelCity: TLabel
        Left = 16
        Top = 60
        Width = 20
        Height = 13
        Caption = 'City:'
      end
      object LabelSt: TLabel
        Left = 239
        Top = 60
        Width = 28
        Height = 13
        Caption = 'State:'
      end
      object LabelZip: TLabel
        Left = 308
        Top = 60
        Width = 18
        Height = 13
        Caption = 'Zip:'
      end
      object edtStreet: TEdit
        Left = 40
        Top = 24
        Width = 337
        Height = 21
        TabOrder = 0
      end
      object edtCity: TEdit
        Left = 40
        Top = 56
        Width = 193
        Height = 21
        TabOrder = 1
      end
      object edtState: TEdit
        Left = 272
        Top = 56
        Width = 30
        Height = 21
        MaxLength = 2
        TabOrder = 2
        OnKeyPress = edtStateKeyPress
      end
      object edtZip: TEdit
        Left = 338
        Top = 56
        Width = 55
        Height = 21
        MaxLength = 5
        TabOrder = 3
        OnKeyPress = edtZipKeyPress
      end
    end
    object BottomBox: TGroupBox
      Left = 1
      Top = 176
      Width = 426
      Height = 59
      Align = alBottom
      Caption = 'Are you in the coverage area?'
      TabOrder = 2
      object URLVeroCoverage: TRzURLLabel
        Left = 11
        Top = 22
        Width = 322
        Height = 13
        Caption = 
          'Click here to check if the property is in the VeroValue coverage' +
          ' area'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clHighlight
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsUnderline]
        ParentFont = False
        URL = 'http://www.verovalue.com/main.php?Page=vv_geo&Aff=&Ref='
      end
    end
    object Topbox: TGroupBox
      Left = 1
      Top = 1
      Width = 426
      Height = 72
      Align = alTop
      TabOrder = 0
      object lblAccessCode: TLabel
        Left = 81
        Top = 14
        Width = 116
        Height = 13
        Caption = 'Enter Your Access Code'
      end
      object AnimateProgress: TAnimate
        Left = 20
        Top = 17
        Width = 48
        Height = 45
        StopFrame = 8
      end
      object edtAccessCode: TEdit
        Left = 79
        Top = 29
        Width = 136
        Height = 21
        TabOrder = 1
      end
      object Valuate: TButton
        Left = 221
        Top = 26
        Width = 73
        Height = 25
        Caption = 'Get Analysis'
        TabOrder = 2
        OnClick = ValuateClick
      end
      object btnCancel: TButton
        Left = 306
        Top = 26
        Width = 65
        Height = 25
        Cancel = True
        Caption = 'Cancel'
        ModalResult = 2
        TabOrder = 3
      end
    end
  end
end
