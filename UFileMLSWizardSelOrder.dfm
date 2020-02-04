object FileMLSWizardSelOrder: TFileMLSWizardSelOrder
  Left = 546
  Top = 366
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Selected MLS Field Name'
  ClientHeight = 325
  ClientWidth = 294
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 8
    Top = 8
    Width = 108
    Height = 13
    Caption = 'Sequence Data Result'
  end
  object RzBitBtn1: TRzBitBtn
    Left = 40
    Top = 296
    Caption = 'Ok'
    TabOrder = 0
    OnClick = RzBitBtn1Click
  end
  object RzBitBtn2: TRzBitBtn
    Left = 152
    Top = 296
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = RzBitBtn2Click
  end
  object EditResult: TEdit
    Left = 8
    Top = 26
    Width = 281
    Height = 21
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    Color = clSilver
    ReadOnly = True
    TabOrder = 2
  end
  object GroupBox: TGroupBox
    Left = 8
    Top = 56
    Width = 281
    Height = 233
    Caption = 'MLS Field Name'
    TabOrder = 3
    object SpeedButton3: TSpeedButton
      Left = 234
      Top = 72
      Width = 41
      Height = 33
      Caption = 'Up'
      NumGlyphs = 2
      OnClick = SpeedButton3Click
    end
    object SpeedButton4: TSpeedButton
      Left = 234
      Top = 136
      Width = 41
      Height = 33
      Caption = 'Down'
      OnClick = SpeedButton4Click
    end
    object ListBox2: TListBox
      Left = 8
      Top = 24
      Width = 225
      Height = 201
      ItemHeight = 13
      TabOrder = 0
    end
    object ListBox1: TListBox
      Left = 240
      Top = 8
      Width = 33
      Height = 57
      BevelOuter = bvNone
      BorderStyle = bsNone
      ItemHeight = 13
      TabOrder = 1
      Visible = False
    end
    object ListBox3: TListBox
      Left = 240
      Top = 176
      Width = 33
      Height = 41
      BorderStyle = bsNone
      ItemHeight = 13
      TabOrder = 2
      Visible = False
    end
  end
end
