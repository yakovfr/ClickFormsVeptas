object dlgUADGridLocRating: TdlgUADGridLocRating
  Left = 419
  Top = 179
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'UAD: Location Influence on Value'
  ClientHeight = 342
  ClientWidth = 560
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnShow = FormShow
  DesignSize = (
    560
    342)
  PixelsPerInch = 96
  TextHeight = 13
  object lblViewAppeal: TLabel
    Left = 20
    Top = 68
    Width = 105
    Height = 17
    Caption = 'Influence on Value'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lblOtherDesc: TLabel
    Left = 17
    Top = 231
    Width = 123
    Height = 51
    Caption = 'Enter a brief "Other" description (ex. RRTracks)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object stInstruction2: TLabel
    Left = 16
    Top = 35
    Width = 367
    Height = 17
    Caption = 'Enter a description when "Other" is one of the selected factors.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object bbtnCancel: TBitBtn
    Left = 390
    Top = 305
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = '&Cancel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ModalResult = 2
    ParentFont = False
    TabOrder = 4
  end
  object bbtnOK: TBitBtn
    Left = 305
    Top = 305
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Save'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = bbtnOKClick
  end
  object edtOtherDesc: TEdit
    Left = 144
    Top = 233
    Width = 105
    Height = 25
    Hint = '4515'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    MaxLength = 20
    ParentFont = False
    TabOrder = 2
    Text = 'edtOtherDesc'
  end
  object lbRating: TListBox
    Left = 16
    Top = 85
    Width = 121
    Height = 60
    Hint = '4419'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ItemHeight = 17
    Items.Strings = (
      'Neutral'
      'Beneficial'
      'Adverse')
    ParentFont = False
    TabOrder = 0
  end
  object clbFactors: TCheckListBox
    Left = 144
    Top = 85
    Width = 393
    Height = 140
    Hint = '4420'#13'4421'
    Columns = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ItemHeight = 17
    Items.Strings = (
      'Residential'
      'Industrial'
      'Commercial'
      'BusyRoad'
      'WaterFront'
      'GolfCourse'
      'AdjacentToPark'
      'AdjacentToPowerLines'
      'Landfill'
      'PublicTransportation'
      'Other')
    ParentFont = False
    TabOrder = 1
    OnKeyUp = clbFactorsKeyUp
    OnMouseUp = clbFactorsMouseUp
  end
  object stInstructions: TStaticText
    Left = 14
    Top = 13
    Width = 531
    Height = 21
    AutoSize = False
    BevelInner = bvNone
    BevelKind = bkSoft
    BevelOuter = bvNone
    Caption = 'Specify the influence Location has on the value of the property.'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 7
    Transparent = False
  end
  object bbtnHelp: TBitBtn
    Left = 475
    Top = 305
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Help'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = bbtnHelpClick
  end
  object bbtnClear: TBitBtn
    Left = 9
    Top = 305
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'C&lear'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    OnClick = bbtnClearClick
  end
  object stFactors: TStaticText
    Left = 155
    Top = 64
    Width = 326
    Height = 21
    Caption = 'Warning - More than two Location Factors are selected'
    Color = clYellow
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 8
    Transparent = False
  end
end
