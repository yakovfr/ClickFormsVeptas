object PhotoSheet: TPhotoSheet
  Left = 450
  Top = 162
  Width = 831
  Height = 280
  ActiveControl = btnLoad
  Caption = 'PhotoSheet'
  Color = clBtnFace
  Constraints.MaxHeight = 280
  Constraints.MinHeight = 280
  Constraints.MinWidth = 382
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Visible = True
  OnCloseQuery = FormCloseQuery
  OnKeyDown = ThumbListKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 223
    Width = 815
    Height = 19
    Panels = <
      item
        Width = 150
      end
      item
        Width = 50
      end>
  end
  object BtnSpacer: TPanel
    Left = 715
    Top = 0
    Width = 100
    Height = 223
    Align = alRight
    BevelOuter = bvNone
    Constraints.MaxWidth = 100
    Constraints.MinWidth = 100
    TabOrder = 1
    object btnSave: TButton
      Left = 16
      Top = 60
      Width = 75
      Height = 25
      Hint = 'Saves all images into a file called a Photo Roll (*.rol)'
      Caption = 'Save'
      Enabled = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnSaveClick
    end
    object btnHide: TButton
      Left = 16
      Top = 89
      Width = 75
      Height = 25
      Cancel = True
      Caption = 'Hide'
      ModalResult = 2
      TabOrder = 2
      OnClick = btnHideClick
    end
    object btnLoad: TButton
      Left = 16
      Top = 3
      Width = 75
      Height = 25
      Hint = 'Loads all the images found in a directory'
      Caption = 'Load'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = btnLoadClick
    end
    object btnOpen: TButton
      Left = 16
      Top = 31
      Width = 75
      Height = 25
      Hint = 'Opens a file '#39'Roll'#39' of images (*.rol)'
      Caption = 'Open'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = btnOpenClick
    end
  end
  object OpenDialog: TOpenDialog
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 472
    Top = 8
  end
  object SaveDialog: TSaveDialog
    Left = 472
    Top = 48
  end
end
