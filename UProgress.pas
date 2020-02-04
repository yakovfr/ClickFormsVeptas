unit UProgress;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, ControlProgressBar, UForms;

type
  TProgress = class(TAdvancedForm)
    StatusBar: TCFProgressBar;
    StatusNote: TLabel;
    lblMax: TLabel;
    lblValue: TLabel;
    StepTimer: TTimer;
    procedure StepTimerEvent(Sender: TObject);
  private
    FDisabledTaskWindows: Pointer;
    FUseTimer: Boolean;
    FMaxTimerValue: Integer;
  protected
    procedure DoHide; override;
    procedure DoShow; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; MinValue, MaxValue, Steps: Integer; const title: string); reintroduce;
    procedure BeforeDestruction; override;
    procedure SetProgressNote(const Note: String);
    procedure IncrementProgress;
    procedure AnimateProgress(MSec: Integer; Value: Integer);
    procedure IncrementBy(Amt: Integer);
    property Note: String write SetProgressNote;
  end;

var
  Progress: TProgress;

implementation

{$R *.DFM}

{ TProgress }

constructor TProgress.Create(AOwner: TComponent; MinValue, MaxValue, Steps: Integer;
  const title: string);
begin
  inherited create(AOwner);

  FUseTimer := False;
  StepTimer.Enabled := False;

  if Assigned(AOwner) and (AOwner is TWinControl) then
    begin
      Parent := TWinControl(AOwner);
      Left := Trunc((Parent.Width / 2) - (Width / 2));
      Top := Trunc((Parent.Height / 2) - (Height / 2));
    end;

  Caption := Title;
  lblValue.Caption := IntToStr(MinValue);
  lblMax.Caption := IntToStr(MaxValue);
  StatusBar.Min := MinValue;
  StatusBar.Max := MaxValue;
  StatusBar.Step := 1;
  FMaxTimerValue := 0;
  Visible := True;
  Application.ProcessMessages;
end;

/// summary: Enables task windows when the progress bar is destroyed.
procedure TProgress.BeforeDestruction;
begin
  if Assigned(FDisabledTaskWindows) then
    begin
      EnableTaskWindows(FDisabledTaskWindows);
      FDisabledTaskWindows := nil;
    end;
  inherited;
end;

/// summary: Enables task windows when the progress bar hidden.
procedure TProgress.DoHide;
begin
  inherited;
  if Assigned(FDisabledTaskWindows) then
    begin
      EnableTaskWindows(FDisabledTaskWindows);
      FDisabledTaskWindows := nil;
    end;
end;

/// summary: Disables task windows when the progress bar is shown.
procedure TProgress.DoShow;
begin
  if not Assigned(FDisabledTaskWindows) then
    FDisabledTaskWindows := DisableTaskWindows(0);
  inherited;
end;

procedure TProgress.IncrementProgress;
begin
  StatusBar.StepIt;
  lblValue.Caption := IntToStr(StatusBar.Position);
  Update;
  Application.ProcessMessages;
end;

procedure TProgress.IncrementBy(Amt: Integer);
begin
  StatusBar.Position := StatusBar.Position + Amt;
  lblValue.Caption := IntToStr(StatusBar.Position);
  Update;
  Application.ProcessMessages;
end;

procedure TProgress.SetProgressNote(const Note: String);
begin
  StatusNote.Caption := Note;
  Update;
  Application.ProcessMessages;
end;

procedure TProgress.AnimateProgress(MSec: Integer; Value: Integer);
begin
//This needs to be in a different thread to really work
  FUseTimer := True;
  StepTimer.Enabled := True;
  StepTimer.Interval := MSec;
  FMaxTimerValue := Value;
  Application.ProcessMessages;
end;

procedure TProgress.StepTimerEvent(Sender: TObject);
var
  barPos: Integer;
begin
  StatusBar.StepIt;
  barPos := StatusBar.Position;
  StepTimer.Enabled := FUseTimer and ((barPos < FMaxTimerValue) or (barPos < StatusBar.Max));
  Application.ProcessMessages;
end;

end.
