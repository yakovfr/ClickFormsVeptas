object SigSetup: TSigSetup
  Left = 522
  Top = 194
  BorderStyle = bsDialog
  Caption = 'Signature Setup'
  ClientHeight = 188
  ClientWidth = 492
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  inline Animator: TAnimateFrame
    Left = 0
    Top = 0
    Width = 491
    Height = 190
    TabOrder = 0
    inherited Bevel: TBevel
      Hint = 'Drag image to re-position image. Use zoomer to resize.'
      ParentShowHint = False
      ShowHint = True
    end
    inherited MMOpenDialog: TMMOpenDialog
      Left = 352
      Top = 16
    end
  end
end
