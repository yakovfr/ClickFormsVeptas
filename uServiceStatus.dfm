object SrvStatusDialog: TSrvStatusDialog
  Left = 803
  Top = 305
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = 'Loading Service Status'
  ClientHeight = 447
  ClientWidth = 545
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Memo: TMemo
    Left = 0
    Top = 0
    Width = 545
    Height = 428
    Align = alClient
    TabOrder = 0
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 428
    Width = 545
    Height = 19
    Panels = <>
  end
end
