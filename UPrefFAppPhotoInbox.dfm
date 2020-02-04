object PrefAppPhotoInbox: TPrefAppPhotoInbox
  Left = 0
  Top = 0
  Width = 564
  Height = 212
  TabOrder = 0
  object cbxWatchPhotos: TRzCheckBox
    Left = 16
    Top = 94
    Width = 433
    Height = 17
    Caption = 
      'Watch this folder for new photos (i.e. consider this is your pho' +
      'tos inbox)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    State = cbUnchecked
    TabOrder = 0
    Transparent = True
    OnClick = cbxWatchPhotosClick
  end
  object edtPathNewPhotosInbox: TEdit
    Left = 16
    Top = 119
    Width = 433
    Height = 21
    TabOrder = 1
  end
  object cbxWPhotoInsert: TCheckBox
    Left = 32
    Top = 149
    Width = 441
    Height = 28
    Caption = 
      'If a photo cell is the active cell in the report, automatically ' +
      'insert the new photo there.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    WordWrap = True
  end
  object cbxWPhoto2Catalog: TCheckBox
    Left = 32
    Top = 181
    Width = 310
    Height = 17
    Caption = 'Add the new photos to the Inspection Photos form'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    Visible = False
  end
  object btnBrowsePhotoWatchFolder: TButton
    Left = 458
    Top = 117
    Width = 75
    Height = 25
    Caption = 'Browse'
    TabOrder = 4
    OnClick = btnBrowsePhotoWatchFolderClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 564
    Height = 33
    Align = alTop
    Alignment = taLeftJustify
    BevelOuter = bvSpace
    Caption = '   Photo Inbox'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
  end
  object StaticText1: TStaticText
    Left = 16
    Top = 40
    Width = 537
    Height = 49
    AutoSize = False
    Caption = 
      'When photos are placed in the Photo Inbox folder, they are autom' +
      'atically inserted into the active photo cell. Use the Photo Inbo' +
      'x as your destination folder when transferring photos from a cam' +
      'era with wireless transfer capabilities.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object SelectFolderDialog: TRzSelectFolderDialog
    Options = [sfdoContextMenus, sfdoReadOnly, sfdoCreateFolderIcon, sfdoShowHidden]
    Left = 512
    Top = 160
  end
end
