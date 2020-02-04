unit UPrefAppAutoUpdate;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

interface

uses
  Classes,
  Controls,
  ExtCtrls,
  Forms,
  StdCtrls,
  UContainer,
  UGlobals;

type
    TPrefAutoUpdateFrame = class(TFrame)
      chkEnableAutoUpdates: TCheckBox;
      pnlTitle: TPanel;
    private
      FApplied_EnableAutomaticUpdates: Boolean;
    public
      constructor CreateFrame(AOwner: TComponent; ADoc: TContainer);
      procedure LoadPrefs;
      procedure SavePrefs;
      procedure ApplyPreferences;
  end;

implementation

uses
  UAutoUpdateForm,
  UMain;

{$R *.dfm}

constructor TPrefAutoUpdateFrame.CreateFrame(AOwner: TComponent; ADoc: TContainer);
begin
  inherited Create(AOwner);
  LoadPrefs;
end;

procedure TPrefAutoUpdateFrame.LoadPrefs;
begin
  FApplied_EnableAutomaticUpdates := appPref_EnableAutomaticUpdates;
  chkEnableAutoUpdates.Checked := FApplied_EnableAutomaticUpdates;
end;

procedure TPrefAutoUpdateFrame.SavePrefs;
begin
  appPref_EnableAutomaticUpdates := chkEnableAutoUpdates.Checked;
  ApplyPreferences;
end;

procedure TPrefAutoUpdateFrame.ApplyPreferences;
begin
  if (FApplied_EnableAutomaticUpdates <> chkEnableAutoUpdates.Checked) then
    begin
      FApplied_EnableAutomaticUpdates := chkEnableAutoUpdates.Checked;

      if FApplied_EnableAutomaticUpdates then
        begin
          TAutoUpdateForm.Updater.OnUpdatesChecked := Main.ShowAvailableUpdates;
          TAutoUpdateForm.Updater.CheckForUpdates(True);
        end
      else
        TAutoUpdateForm.Updater.Reset;
    end;
end;

end.
