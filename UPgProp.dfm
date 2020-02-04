object PgProperty: TPgProperty
  Left = 318
  Top = 217
  Width = 399
  Height = 146
  Caption = 'Page Properties'
  Color = clBtnFace
  DefaultMonitor = dmPrimary
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
  object pnlProperties: TPanel
    Left = 0
    Top = 0
    Width = 383
    Height = 105
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 11
      Top = 16
      Width = 23
      Height = 13
      Caption = 'Title:'
    end
    object edtTitle: TEdit
      Left = 40
      Top = 13
      Width = 222
      Height = 21
      MaxLength = 63
      TabOrder = 0
      Text = 'Untitled'
    end
    object chkBxIncludeTC: TCheckBox
      Left = 16
      Top = 72
      Width = 177
      Height = 17
      Caption = 'Include in Table of Contents'
      TabOrder = 1
    end
    object chkBxIncludePgNum: TCheckBox
      Left = 16
      Top = 48
      Width = 185
      Height = 17
      Caption = 'Include in report page numbering'
      TabOrder = 2
    end
    object btnOK: TButton
      Left = 297
      Top = 13
      Width = 75
      Height = 25
      Caption = 'Ok'
      ModalResult = 1
      TabOrder = 3
    end
    object btnCancel: TButton
      Left = 297
      Top = 60
      Width = 75
      Height = 25
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 4
    end
  end
end
