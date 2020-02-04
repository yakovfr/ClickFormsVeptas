unit UCC_Progress;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, ControlProgressBar, UForms,
  ControlWorkingIndicator;

type
  TCCProgress = class(TAdvancedForm)
    StatusBar: TCFProgressBar;
    StatusNote: TLabel;
    lblMax: TLabel;
    lblValue: TLabel;
    wiProcessing: TWorkingIndicator;
  private
    FDisabledTaskWindows: Pointer;
  protected
    procedure DoHide; override;
    procedure DoShow; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; ShowVals: Boolean; MinValue, MaxValue, Steps: Integer; const title: string); reintroduce;
    procedure BeforeDestruction; override;
    procedure SetProgressNote(const Note: String);
    procedure IncrementProgress;
    procedure IncrementBy(Amt: Integer);
    property Note: String write SetProgressNote;
  end;


implementation


{$R *.DFM}

{ TProgress }

constructor TCCProgress.Create(AOwner: TComponent; ShowVals: Boolean; MinValue, MaxValue, Steps: Integer;
  const title: string);
begin
  inherited create(AOwner);

  if Assigned(AOwner) and (AOwner is TWinControl) then
    begin
      Parent := TWinControl(AOwner);
      Left := Trunc((Parent.Width / 2) - (Width / 2));
      Top := Trunc((Parent.Height / 4) - (Height / 2));
    end;

  Caption := Title;

  lblValue.Visible := ShowVals;
  lblValue.Caption := IntToStr(MinValue);

  lblMax.Visible := ShowVals;
  lblMax.Caption := IntToStr(MaxValue);

  StatusBar.Min := MinValue;
  StatusBar.Max := MaxValue;
  StatusBar.Step := 1;
  Visible := True;
  Application.ProcessMessages;
end;

/// summary: Enables task windows when the progress bar is destroyed.
procedure TCCProgress.BeforeDestruction;
begin
  if Assigned(FDisabledTaskWindows) then
    begin
      EnableTaskWindows(FDisabledTaskWindows);
      FDisabledTaskWindows := nil;
    end;
  inherited;
end;

/// summary: Enables task windows when the progress bar hidden.
procedure TCCProgress.DoHide;
begin
  inherited;
  if Assigned(FDisabledTaskWindows) then
    begin
      EnableTaskWindows(FDisabledTaskWindows);
      FDisabledTaskWindows := nil;
    end;
end;

/// summary: Disables task windows when the progress bar is shown.
procedure TCCProgress.DoShow;
begin
  if not Assigned(FDisabledTaskWindows) then
    FDisabledTaskWindows := DisableTaskWindows(0);
  inherited;
end;

procedure TCCProgress.IncrementProgress;
begin
  StatusBar.StepIt;
  lblValue.Caption := IntToStr(StatusBar.Position);
  Update;
  Application.ProcessMessages;
end;

procedure TCCProgress.IncrementBy(Amt: Integer);
begin
  StatusBar.Position := StatusBar.Position + Amt;
  lblValue.Caption := IntToStr(StatusBar.Position);
  Update;
  Application.ProcessMessages;
end;

procedure TCCProgress.SetProgressNote(const Note: String);
begin
  StatusNote.Caption := Note;
  Update;
  Application.ProcessMessages;
end;

end.
