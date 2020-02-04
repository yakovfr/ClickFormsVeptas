unit UGSEUADPref;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2013 by Bradford Technologies, Inc. }

{  This is the unit for setting the preferences for UAD Compliance }


{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, UStatus, UForms, UContainer, ExtCtrls;

const
  cUADFirstLook  = 1;
  cUADPowerUser  = 2;
  cUADSpecialist = 3;

type
  TGSEUADPref = class(TVistaAdvancedForm)
    Panel1: TPanel;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    rdoUADFirstLook: TRadioButton;
    rdoUADPowerUser: TRadioButton;
    rdoUADSpecialist: TRadioButton;
    stxUADActive: TStaticText;
    stxUADAskToEnable: TStaticText;
    stxAutoAddUADDefs: TStaticText;
    chkAutoAddUADDefs: TCheckBox;
    chkUADAskToEnable: TCheckBox;
    chkUADActive: TCheckBox;
    stNoUADForms: TStaticText;
    chkDesignAndCarActive: TCheckBox;
    btnOK: TButton;
    btnCancel: TButton;
    rdoUADoption: TRadioGroup;
    chkAutoAddUADSubjDet: TCheckBox;
    procedure SelectUADInterfaceClick(Sender: TObject);
    procedure chkUADActiveClick(Sender: TObject);
    procedure chkUADAskToEnableClick(Sender: TObject);
    procedure chkAutoAddUADDefsClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure ChkUserState(FirstLookChkd, PwrUserChkd: Boolean);
    procedure chkAutoAddUADSubjDetClick(Sender: TObject);
    procedure chkDesignAndCarActiveClick(Sender: TObject);
    procedure rdoUADoptionClick(Sender: TObject);
  private
    FDoc: TContainer;
    FUADIsOn: Boolean;
    FUADAsk: Boolean;
    FUADAppendDefs: Boolean;
    FUADAppendSubjDet: Boolean;
    FUADAutoDlgs: Boolean;
    FUADInterface: Integer;
    FUADDesignOn: Boolean;
    FUADAutoConvert: Boolean;  //github 237
    procedure AdjustDPISettings;
  public
    constructor Create(AOwner: TComponent);  override;
  end;

var
  GSEUADPref: TGSEUADPref;

  procedure SetUADCompliancePrefs(Doc: TContainer);


implementation

uses
  UMain, UGlobals, UStrings, ULicUser, UUADUtils;

{$R *.dfm}


procedure SetUADCompliancePrefs(Doc: TContainer);
var
  UADPref: TGSEUADPref;
begin
  UADPref := TGSEUADPref.Create(doc);
  try
    if (not Assigned(Doc)) or (Doc.FormCount = 0) or HasUADForm(doc) then
      begin
        UADPref.stNoUADForms.Visible := False;
      end
    else
      begin
        UADPref.GroupBox1.Enabled := False;
        UADPref.rdoUADFirstLook.Enabled := False;
        UADPref.rdoUADPowerUser.Enabled := False;
        UADPref.rdoUADSpecialist.Enabled := False;
        UADPref.chkUADActive.Enabled := False;
        UADPref.chkUADAskToEnable.Enabled := False;
        UADPref.chkAutoAddUADDefs.Enabled := False;
        UADPref.chkDesignAndCarActive.Enabled := False;
        UADPref.btnOK.Enabled := False;
      end;
    UADPref.ShowModal;
  finally
    UADPref.Free;
  end;
end;

{ TGSEUADPref }

constructor TGSEUADPref.Create(AOwner: TComponent);
begin
  inherited Create(nil);

  FDoc := AOwner as TContainer;

//remember original settings
  FUADIsOn          := appPref_UADIsActive;
  FUADAsk           := appPref_UADAskBeforeEnable;
  FUADAppendDefs    := appPref_UADAppendGlossary;
  FUADAppendSubjDet := appPref_UADAppendSubjDet;
  FUADAutoDlgs      := appPref_AutoDisplayUADDlgs;
  FUADInterface     := appPref_UADInterface;
  FUADDesignOn      := appPref_UADCarNDesignActive;
  FUADAutoConvert   := appPref_UADAutoConvert;

//set the check boxes - show the user
  chkUADActive.Checked          := appPref_UADIsActive;
  chkAutoAddUADDefs.Checked     := appPref_UADAppendGlossary;
  chkAutoAddUADSubjDet.Checked  := appPref_UADAppendSubjDet;
  chkUADAskToEnable.Checked     := appPref_UADAskBeforeEnable;
  chkDesignAndCarActive.Checked := appPref_UADCarNDesignActive or (date >= StrToDate(CUADCarAndDesignEffDate));
  if appPref_UADNoConvert then
    rdoUADOption.ItemIndex := 0
  else if appPref_AutoDisplayUADDlgs then
    rdoUADOption.ItemIndex := 1
  else if appPref_UADAutoConvert then
    rdoUADOption.ItemIndex := 2;

  if (date >= StrToDate(CUADCarAndDesignEffDate)) then  //don't let user change after this date
    chkDesignAndCarActive.enabled := False;

//set the UAD interface
(*
  case appPref_UADInterface of
    cUADFirstLook:   rdoUADFirstLook.Checked := True;
    cUADPowerUser:   rdoUADPowerUser.Checked := True;
    cUADSpecialist:  rdoUADSpecialist.Checked := True;
  else
    rdoUADFirstLook.Checked := True;
  end;

  ChkUserState(rdoUADFirstLook.Checked, rdoUADPowerUser.Checked);
*)
end;

//st the beginning - check if user is in licensed for UAD Compliance Service
procedure TGSEUADPref.SelectUADInterfaceClick(Sender: TObject);
begin
//  if not (TRadioButton(Sender).Tag = cUADSpecialist) then //REMOVE IF when UAD Specialis is Active
//    FUADInterface := TRadioButton(Sender).Tag;    //TAG is interface indicator
    FUADInterface := 3;    //github #445: always set as special List

  {if TRadioButton(Sender).Tag = cUADSpecialist then        //Specialist coming soon
    begin
      ShowNotice('The UAD Specialist interface will be released soon. Please use UAD First Look to become familiar with the UAD Requirements. Then use UAD Power User to increase your productivity.');
      //reset last checked interface option
      case FUADInterface of
        cUADFirstLook: rdoUADFirstLook.Checked := True;
        cUADPowerUser: rdoUADPowerUser.Checked := True;
      end;
    end;}
//  ChkUserState(rdoUADFirstLook.Checked, rdoUADPowerUser.Checked);
end;

procedure TGSEUADPref.chkUADActiveClick(Sender: TObject);
begin
  FUADIsOn := chkUADActive.Checked;

  //enable or disable depending if UAD is ON or OFF
  chkUADAskToEnable.Enabled := FUADIsOn;
  chkAutoAddUADDefs.Enabled := FUADIsOn;
  chkDesignAndCarActive.Enabled := FUADIsOn and (date < StrToDate(CUADCarAndDesignEffDate));
  chkAutoAddUADSubjDet.Enabled  := FUADIsOn;  //github 344
  rdoUADOption.ItemIndex := 1;          //github 344
  rdoUADOption.Enabled   := FUADIsOn;  //github 344
end;

procedure TGSEUADPref.chkUADAskToEnableClick(Sender: TObject);
begin
  FUADAsk := chkUADAskToEnable.Checked;
end;

procedure TGSEUADPref.chkAutoAddUADDefsClick(Sender: TObject);
begin
  FUADAppendDefs := chkAutoAddUADDefs.Checked;
end;

//save the UAD Settings
procedure TGSEUADPref.FormClose(Sender: TObject; var Action: TCloseAction);
//var
//  addedPowerUser: Boolean;
begin
  if ModalResult <> mrCancel then
    begin
      appPref_UADIsActive         := FUADIsOn;
      appPref_UADAskBeforeEnable  := FUADAsk;
      appPref_UADAppendGlossary   := FUADAppendDefs;
      appPref_UADAppendSubjDet    := FUADAppendSubjDet;
      appPref_AutoDisplayUADDlgs  := FUADAutoDlgs;
      appPref_UADInterface        := FUADInterface;
      appPref_UADCarNDesignActive  := FUADDesignOn;
      appPref_UADAutoConvert      := FUADAutoConvert;

      //do we need to apply this to current Containers?  (what about others - ie later)
      if assigned(FDoc) then
        begin
          if FUADIsOn and not FDoc.UADEnabled then      //UAD On, doc is off - turn doc on
            FDoc.UADEnabled := IsOKToEnableUAD
          else if Not FUADIsOn and FDoc.UADEnabled then //UAD off, doc is on, ask to trun doc off
            begin
              if (mrYes = WhichOption12('Continue', 'Cancel', 'The UAD Compliance Rules for this report will be terminated. Continue?')) then
                FDoc.UADEnabled := False
              else                      //canceled - do nothing
                begin
                  action := caNone;    //don't close the dialog.
                  exit;
                end;
            end;

          //are power user forms in the report?
          if FUADIsOn and (FUADInterface = cUADPowerUser) then
            begin
//              addedPowerUser := False;
              if FDoc.GetFormIndex(981) = -1 then            //if Subject details not in the report
                begin
                  FDoc.GetFormByOccurance(981, 0, True);     //add it
//                  addedPowerUser := True;
                end;
(*
              if FDoc.GetFormIndex(982) = -1 then            //if Comp details not in the report
                begin
                  FDoc.GetFormByOccurance(982, 0, True);       //add it
                end;
*)
//              if addedPowerUser then
//                ShowNotice('The UAD Power User addednums have been added to the end of the report.');
            end;
        end;

      //now set the menu item display
      SetUADServiceMenu(FUADIsOn);
    end;
end;

procedure TGSEUADPref.FormShow(Sender: TObject);
begin
  AdjustDPISettings;
end;

procedure TGSEUADPref.AdjustDPISettings;
begin
//  stNoUADForms.top := Panel1.Height - 30;
//  stxAutoAddUADSubjDet.Top := stNoUADForms.Top - stxAutoAddUADSubjDet.height - 10;
//  chkAutoAddUADSubjDet.Top := stxAutoAddUADSubjDet.Top;
  self.width := stNoUADForms.left + stNoUADForms.width + 100;
  Panel1.Width := self.Width;
  Panel1.Align := alClient;
end;

procedure TGSEUADPref.ChkUserState(FirstLookChkd, PwrUserChkd: Boolean);
begin
  if FirstLookChkd and chkUADActive.Checked then  //github 344
    begin
//      chkAutoUADDlgs.Checked := True;
      rdoUADOption.ItemIndex := 1;
      rdoUADOption.Enabled   := False;
//      chkAutoUADDlgs.Enabled := False;
//      stxAutoUADDlgs.Enabled := False;
      chkAutoAddUADSubjDet.Checked := False;
      chkAutoAddUADSubjDet.Enabled := True; //github 344
      //github 821 make UAD Def unchecked for default
      chkAutoAddUADDefs.Checked := False;
      chkAutoAddUADDefs.Enabled := True;
//      stxAutoAddUADSubjDet.Enabled := False;
      //github 237: only the specialist can use the auto convert
//      chkUADAutoConvert.Enabled := False;
//      chkUADAutoConvert.Checked := False;
//      stxAutoUADConvert.Enabled := False;
      appPref_UADAutoConvert    := False; //turn off auto convert
    end
  else if PwrUserChkd then
    begin
      rdoUADOption.ItemIndex := 1;
      rdoUADOption.Enabled := False;
      chkAutoAddUADSubjDet.Checked := True;
      chkAutoAddUADSubjDet.Enabled := True; //github 344
       //github 821 make UAD Def unchecked for default
      chkAutoAddUADDefs.Checked := True;
      chkAutoAddUADDefs.Enabled := True;
      appPref_UADAutoConvert    := False;  //github 237: turn off auto convert
    end
  else
    begin
      if appPref_UADNoConvert then
        rdoUADOption.ItemIndex := 0
      else if FUADAutoDlgs and not appPref_UADAutoConvert then
        begin
          rdoUADOption.ItemIndex := 1;
          rdoUADOption.Enabled := True;
          chkAutoAddUADSubjDet.Checked := False;
          chkAutoAddUADSubjDet.Enabled := True; //github 344
           //github 821 make UAD Def unchecked for default
          chkAutoAddUADDefs.Checked := False;
          chkAutoAddUADDefs.Enabled := True;
      end;
    if not chkUADActive.Checked then   //github 344
    begin
      rdoUADOption.ItemIndex := 1;
      rdoUADOption.Enabled := False;
      chkAutoAddUADSubjDet.Checked := False;
      chkAutoAddUADSubjDet.Enabled := False;
       //github 821 make UAD Def unchecked for default
      chkAutoAddUADDefs.Checked := False;
      chkAutoAddUADDefs.Enabled := False;
    end;
  end;
end;

procedure TGSEUADPref.chkAutoAddUADSubjDetClick(Sender: TObject);
begin
  FUADAppendSubjDet := chkAutoAddUADSubjDet.Checked;
end;

procedure TGSEUADPref.chkDesignAndCarActiveClick(Sender: TObject);
begin
  FUADDesignOn := chkDesignAndCarActive.checked;
end;

//github 237
procedure TGSEUADPref.rdoUADoptionClick(Sender: TObject);
begin
   case rdoUADOption.ItemIndex of
     0: begin //github #443
          FUADAutoDlgs                 := False;
          FUADAutoConvert              := False;
          appPref_UADNoConvert         := True;
          appPref_AutoDisplayUADDlgs   := False;
          appPref_UADAutoConvert       := False;
          chkDesignAndCarActive.Checked := False;  //github 454

        end;
     1: begin
          FUADAutoDlgs := True;
          FUADAutoConvert := False;
          appPref_AutoDisplayUADDlgs   := True;
          appPref_UADAutoConvert       := False;
          appPref_UADNoConvert         := False;
          chkDesignAndCarActive.Checked := appPref_UADCarNDesignActive or (date >= StrToDate(CUADCarAndDesignEffDate));
        end;
     2: begin
          FUADAutoConvert := True;
          FUADAutoDlgs    := False;
          appPref_UADAutoConvert       := True;
          appPref_AutoDisplayUADDlgs   := False;
          appPref_UADNoConvert         := False;
          chkDesignAndCarActive.Checked := False;
        end;
   end;
   FUADDesignOn := chkDesignAndCarActive.Checked;
end;

end.

