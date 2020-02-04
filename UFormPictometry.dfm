object PictometryForm: TPictometryForm
  Left = 296
  Top = 205
  ActiveControl = EditStreet
  BorderStyle = bsDialog
  BorderWidth = 8
  Caption = 'Pictometry Aerial Imagery'
  ClientHeight = 344
  ClientWidth = 610
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object PanelImages: TPanel
    Left = 0
    Top = 145
    Width = 610
    Height = 199
    Align = alClient
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 1
    object ShapeImageWest: TShape
      Left = 465
      Top = 53
      Width = 145
      Height = 145
    end
    object ShapeImageSouth: TShape
      Left = 310
      Top = 53
      Width = 145
      Height = 145
    end
    object ShapeImageEast: TShape
      Left = 155
      Top = 53
      Width = 145
      Height = 145
    end
    object ShapeImageNorth: TShape
      Left = 0
      Top = 53
      Width = 145
      Height = 145
    end
    object ImageNorth: TImage
      Left = 0
      Top = 53
      Width = 145
      Height = 145
      Center = True
      Stretch = True
    end
    object ImageEast: TImage
      Left = 155
      Top = 53
      Width = 145
      Height = 145
      Center = True
      Stretch = True
    end
    object ImageSouth: TImage
      Left = 310
      Top = 53
      Width = 145
      Height = 145
      Center = True
      Stretch = True
    end
    object ImageWest: TImage
      Left = 465
      Top = 53
      Width = 145
      Height = 145
      Center = True
      Stretch = True
    end
    object LabelSouth: TLabel
      Left = 310
      Top = 33
      Width = 125
      Height = 15
      AutoSize = False
      Caption = '&South'
      FocusControl = RadioButtonFrontSouth
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabelNorth: TLabel
      Left = 0
      Top = 33
      Width = 125
      Height = 15
      AutoSize = False
      Caption = '&North'
      FocusControl = RadioButtonFrontNorth
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabelEast: TLabel
      Left = 155
      Top = 33
      Width = 125
      Height = 15
      AutoSize = False
      Caption = '&East'
      FocusControl = RadioButtonFrontEast
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabelWest: TLabel
      Left = 465
      Top = 33
      Width = 125
      Height = 15
      AutoSize = False
      Caption = '&West'
      FocusControl = RadioButtonFrontWest
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabelSelectFrontImage: TLabel
      Left = 0
      Top = 8
      Width = 530
      Height = 15
      AutoSize = False
      Caption = 
        'Indicate which image shows the front of the property from an aer' +
        'ial view:'
    end
    object RadioButtonFrontEast: TRadioButton
      Left = 252
      Top = 33
      Width = 48
      Height = 17
      Caption = 'Front'
      TabOrder = 1
      TabStop = True
    end
    object RadioButtonFrontNorth: TRadioButton
      Left = 97
      Top = 33
      Width = 48
      Height = 17
      Caption = 'Front'
      TabOrder = 0
      TabStop = True
    end
    object RadioButtonFrontSouth: TRadioButton
      Left = 407
      Top = 33
      Width = 48
      Height = 17
      Caption = 'Front'
      TabOrder = 2
      TabStop = True
    end
    object RadioButtonFrontWest: TRadioButton
      Left = 562
      Top = 33
      Width = 48
      Height = 17
      Caption = 'Front'
      TabOrder = 3
      TabStop = True
    end
  end
  object PanelAddress: TPanel
    Left = 0
    Top = 0
    Width = 610
    Height = 145
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object ShapeImageOrthogonal: TShape
      Left = 325
      Top = 0
      Width = 145
      Height = 145
    end
    object LabelZip: TLabel
      Left = 109
      Top = 62
      Width = 25
      Height = 15
      Alignment = taRightJustify
      AutoSize = False
      Caption = '&Zip:'
      FocusControl = EditZip
    end
    object LabelStreet: TLabel
      Left = 10
      Top = 8
      Width = 35
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = '&Street:'
      FocusControl = EditStreet
    end
    object LabelState: TLabel
      Left = 10
      Top = 62
      Width = 35
      Height = 15
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'S&tate:'
      FocusControl = EditState
    end
    object LabelCity: TLabel
      Left = 10
      Top = 35
      Width = 35
      Height = 15
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'C&ity:'
      FocusControl = EditCity
    end
    object ImageOrthogonal: TImage
      Left = 325
      Top = 0
      Width = 145
      Height = 145
      Center = True
      Stretch = True
    end
    object LabelOverhead: TLabel
      Left = 470
      Top = 55
      Width = 70
      Height = 30
      Alignment = taCenter
      AutoSize = False
      Caption = 'Overhead'#13'View'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object ButtonCancel: TButton
      Left = 50
      Top = 88
      Width = 75
      Height = 25
      Action = ActionSearchByAddress
      TabOrder = 4
    end
    object EditZip: TEdit
      Left = 140
      Top = 59
      Width = 70
      Height = 21
      TabOrder = 3
      OnChange = EditAddressChange
    end
    object EditStreet: TEdit
      Left = 50
      Top = 5
      Width = 160
      Height = 21
      TabOrder = 0
      OnChange = EditAddressChange
    end
    object EditState: TEdit
      Left = 50
      Top = 59
      Width = 55
      Height = 21
      TabOrder = 2
      OnChange = EditAddressChange
    end
    object EditCity: TEdit
      Left = 50
      Top = 32
      Width = 160
      Height = 21
      TabOrder = 1
      OnChange = EditAddressChange
    end
    object ButtonTransfer: TButton
      Left = 50
      Top = 118
      Width = 160
      Height = 25
      Action = ActionTransfer
      TabOrder = 6
    end
    object ButtonSearchByAddress: TButton
      Left = 135
      Top = 88
      Width = 75
      Height = 25
      Action = ActionCancel
      TabOrder = 5
    end
  end
  object ActionList: TActionList
    Left = 10
    Top = 105
    object ActionCancel: TAction
      Caption = '&Cancel'
      OnExecute = ActionCancelExecute
      OnUpdate = ActionCancelUpdate
    end
    object ActionSearchByAddress: TAction
      Caption = '&Get Images'
      OnUpdate = ActionSearchByAddressUpdate
    end
    object ActionTransfer: TAction
      Caption = '&Transfer to Report'
      OnUpdate = ActionTransferUpdate
    end
  end
end
