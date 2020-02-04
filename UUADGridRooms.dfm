object dlgUADGridRooms: TdlgUADGridRooms
  Left = 580
  Top = 235
  ActiveControl = rzseHalfBathCnt
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'UAD: Room Count Information'
  ClientHeight = 144
  ClientWidth = 386
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnShow = FormShow
  DesignSize = (
    386
    144)
  PixelsPerInch = 96
  TextHeight = 13
  object lblTotalRoomCnt: TLabel
    Left = 19
    Top = 15
    Width = 73
    Height = 21
    Caption = 'Total Rooms'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lblBedroomCnt: TLabel
    Left = 113
    Top = 15
    Width = 60
    Height = 21
    Caption = 'Bedrooms'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lblFullBathCnt: TLabel
    Left = 205
    Top = 16
    Width = 48
    Height = 21
    Caption = 'Full Bath'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lblHalfBathCnt: TLabel
    Left = 290
    Top = 16
    Width = 52
    Height = 21
    Caption = 'Half Bath'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object bbtnCancel: TBitBtn
    Left = 227
    Top = 104
    Width = 70
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
    TabOrder = 5
  end
  object bbtnOK: TBitBtn
    Left = 146
    Top = 104
    Width = 70
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Save'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = bbtnOKClick
  end
  object rzseTotalRoomCnt: TRzSpinEdit
    Left = 32
    Top = 35
    Width = 40
    Height = 21
    Hint = '1041'
    AllowKeyEdit = True
    Max = 99.000000000000000000
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnExit = rzseTotalRoomCntExit
  end
  object rzseFullBathCnt: TRzSpinEdit
    Left = 206
    Top = 35
    Width = 40
    Height = 21
    Hint = '1043'
    AllowKeyEdit = True
    Max = 99.000000000000000000
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object rzseBedroomCnt: TRzSpinEdit
    Left = 119
    Top = 35
    Width = 40
    Height = 21
    Hint = '1042'
    AllowKeyEdit = True
    Max = 99.000000000000000000
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object rzseHalfBathCnt: TRzSpinEdit
    Left = 294
    Top = 35
    Width = 40
    Height = 21
    Hint = '1043'
    AllowKeyEdit = True
    Max = 99.000000000000000000
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object bbtnHelp: TBitBtn
    Left = 308
    Top = 104
    Width = 70
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Help'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    OnClick = bbtnHelpClick
  end
  object bbtnClear: TBitBtn
    Left = 8
    Top = 104
    Width = 70
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'C&lear'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    OnClick = bbtnClearClick
  end
end
