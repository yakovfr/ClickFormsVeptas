unit USignatures;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{  This is the unit for managing the signature stamps that can }
{  be affixed to forms. It reads the User files which contain the}
{  signature images.                                            }


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  TMultiP, StdCtrls, ComCtrls, ExtCtrls, Contnrs,ILDibCls, Registry,
  ULicUser, UGraphics, WPPDFPRP, WPPDFR1, WPPDFR2, MMOpen, UFrameAnimation,
  RzButton, RzRadChk, UForms;

const
  saNone    = 0;            //Signature Actions
  saAffix   = 1;
  saRemove  = 2;


type

  TSignature = class(TObject)
    FKind: String;              //kind: appraiser, super, reviewer, etc
    FPerson: String;            //name of person
    FLockDoc: Boolean;          //is the doc locked with signature
    FAllowOtherSig: Boolean;    //once locked, do we allow other signatures
    FUsePSW: Boolean;           //use the PSW to remove and to set
    FPassword: LongInt;
    FOffset: TPoint;            //offset from hot point
    FDestRect: TRect;
    FSigImage: TCFImage;        //the image
    constructor Create;
    destructor Destroy; override;
    function CreateClone: TSignature;
    procedure ReadFromStream(stream: TStream);
    procedure ReadFromStream2(stream: TStream; bShowMessage:Boolean=True);
    procedure WriteToStream(stream: TStream);
    property SignatureImage: TCFImage read FSigImage write FSigImage;
	end;

  {Each object in the list is a TSignature}
  {There could be multiple siganatures in the }
  {report. TSignatureMgr manages all of them.}
  TSignatureMgr = Class(TObjectList)
    FDoc: TComponent;
    function GetLockedValue: Boolean;
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
    procedure Assign(Source: TSignatureMgr);
    procedure Clear; override;
    procedure AffixSignature(Signature: TSignature);
    procedure RemoveSignature(Signature: TSignature);
    procedure UpdateSignatureBounds;    //* See notes below
    procedure UpdateFormSignatures(AForm: TObject);
    function SignatureIndexOf(const SigKind: String): Integer;
    function GetSignatureKind(Const SigAction: String): String;
    function GetAvailableSignatureActions(User: TlicensedUser): TStringList;
    //read & write to report file
    procedure ReadFromStream(stream: TStream);
    procedure ReadFromStream2(stream: TStream; bShowMessage:Boolean=True);
    procedure WriteToStream(stream: TStream);
    property LockDocument: Boolean read GetLockedValue;
  end;


  TSignatureSetup = class(TAdvancedForm)
    cbxUserActions: TComboBox;
    chkLockIt: TCheckBox;
    chkAllowSignatures: TCheckBox;
    SignatureDisplay: TImage;
    btnClose: TButton;
    btnDoIt: TButton;
    btnSetup: TButton;
    lblNote: TLabel;
    cbxUserList: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    lblPswNotice: TLabel;
    chkPassword: TRzCheckBox;
    chkDateIt: TCheckBox;
    procedure cbxUserActionsChange(Sender: TObject);
    procedure btnDoItClick(Sender: TObject);
    procedure chkLockItClick(Sender: TObject);
    procedure btnSetupClick(Sender: TObject);
    procedure SwitchUsers(Sender: TObject);
    procedure chkPasswordClick(Sender: TObject);
    procedure chkDateItClick(Sender: TObject);
  private
    FActiveUser: TLicensedUser;
    FHasSignature: Boolean;
    FNeedsSetup: Boolean;
    FWorkingImage: TCFImage;            //internal copy, maybe don't need; use CurrentUser
    FDocSigMgr: TSignatureMgr;
    FRegistry: TRegistry;
    function GetSignDateContextID(const Kind: String): Integer;
    procedure UpdatePSWNotices(hasPSW: Boolean);
    procedure SetHasSignature(const Value: Boolean);
    procedure AdjustDPISettings;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadUsers;
    procedure LoadUserSignature;
    procedure UpdateSignatureOptions;
    procedure UpdateSignatureDisplay;
    property SignatureStamp: TCFImage read FWorkingImage write FWorkingImage;
    property HasSignature: Boolean read FHasSignature write SetHasSignature;
  end;



  procedure SignDocWithStamp(doc: TComponent);



var
  SignatureSetup: TSignatureSetup;

implementation

uses
  Dll96v1,
  UGlobals, UStatus, UFileGlobals, UFileUtils,
  UContainer, UForm, UUtil1, USigSetup, UPassword;

const
  /// summary: Settings name for the "Sign with today's date" preference.
  CSettings_DateIt = 'DateIt';

  SigDisplayWidth = 320;
  SigDisplayHeight= 95;


{$R *.DFM}


//routine called in Main to affix/remove signatures
procedure SignDocWithStamp(doc: TComponent);
var
  SigSetup: TSignatureSetup;
begin
  SigSetup := TSignatureSetup.Create(doc);
  try
    if SigSetup.ShowModal = mrOK then
      begin
        if CurrentUser.Modified then
          CurrentUser.SaveUserLicFile;
      end;
  finally
    SigSetup.Free;
  end;
end;



{ TSignatureSetup }

procedure TSignatureSetup.AdjustDPISettings;
begin
    self.Width := btnClose.Left + btnClose.Width + 50;
    self.height := btnClose.Top + btnClose.Height + 120;
    self.Constraints.MinWidth := self.Width;
    self.Constraints.MinHeight := self.Height;
end;


//must pass TContainer as AOwner
constructor TSignatureSetup.Create(AOwner: TComponent);
begin
  FRegistry := TRegistry.Create(KEY_ALL_ACCESS);
  inherited Create(nil);    //no one owns it

  // initialize
  SettingsName := Name;
  FRegistry.RootKey := HKEY_CURRENT_USER;
  FRegistry.OpenKey(FormSettingsRegistryKey, True);

  // Load form data
  if FRegistry.ValueExists(CSettings_DateIt) and (FRegistry.GetDataType(CSettings_DateIt) = rdInteger) then
    chkDateIt.Checked := FRegistry.ReadBool(CSettings_DateIt);

  FDocSigMgr := nil;
  if AOwner <> nil then
    FDocSigMgr := TContainer(AOwner).docSignatures;
  FWorkingImage := TCFImage.Create;
  FHasSignature := False;
  FNeedsSetup := False;

  FActiveUser := CurrentUser;     //start with currentUser

  LoadUsers;
  LoadUserSignature;
  UpdateSignatureDisplay;
  UpdateSignatureOptions;
  AdjustDPISettings;
end;

destructor TSignatureSetup.Destroy;
begin
  FreeAndNil(FRegistry);
  if assigned(FWorkingImage) then
    FWorkingImage.Free;
  if assigned(FActiveUser) then
    begin
      if FActiveUser.modified then
        FActiveUser.SaveUserLicFile;
      if not SameObject(FActiveUser, CurrentUser) then
        FActiveUser.Free;
    end;
    
  inherited;
end;

//when switching cannot delete CurrentUser, but have to
//create additional TLicensedUser when other than Current
//need to free the additional one if it exists at close
//Problem: Only one user loaded at a time
procedure TSignatureSetup.SwitchUsers(Sender: TObject);
var
  n: Integer;
  NewUser: TUser;
begin
  n := cbxUserList.ItemIndex;
  if n > -1 then
    begin
      NewUser := TUser(LicensedUsers.Items[n]);
      if (CompareText(NewUser.FLicName, FActiveUser.SWLicenseName) <> 0) then   //its new
        begin
          //if the active user was the Current User, just nil FActive
          if CompareText(FActiveUser.SWLicenseName, CurrentUser.SWLicenseName) = 0 then
            FActiveUser := nil
          else
            begin
              if FActiveUser.Modified then        //save any changes
                FActiveUser.SaveUserLicFile;
              FreeAndNil(FActiveUser);            //setup for new user
            end;

          //if New Active User is the same as Current User, just assign to FActiveUser else create
          if (CompareText(NewUser.FLicName, CurrentUser.SWLicenseName) = 0) then
            FActiveUser := CurrentUser
          else
            begin
              FActiveUser := TLicensedUser.Create;
              FActiveUser.LoadUserLicFile(NewUser.FFileName);
            end;

          LoadUserSignature;
          UpdateSignatureDisplay;
          UpdateSignatureOptions;
        end;
    end;
end;

procedure TSignatureSetup.LoadUsers;
var
  i: Integer;
  userName: String;
begin
  cbxUserList.text := FActiveUser.SWLicenseName;

  for i := 0 to LicensedUsers.count-1 do
    begin
      userName :=  TUser(LicensedUsers.Items[i]).FLicName;
      cbxUserList.Items.add(userName);
    end;
end;

procedure TSignatureSetup.LoadUserSignature;
begin
  with FActiveUser.Signature do
    if Image <> nil then
      try
        Image.Seek(0,soFromBeginning);
        FWorkingImage.LoadSignatureFromStream(Image, FImageLen);   //load to storage & create DIB
         //converted lic image has zero destrect
        FNeedsSetup := RectEmpty(FDestRect);
        HasSignature := FWorkingImage.HasGraphic;

        UpdatePSWNotices(FUsePSW);
      except
      end;
end;

/// summary: Gets the "signature date" context id for the specified signature type.
function TSignatureSetup.GetSignDateContextID(const Kind: String): Integer;
begin
  if SameText(Kind, 'Appraiser') then
    Result := 37
  else if SameText(Kind, 'Supervisor') then
    Result := 44
  else
    Result := Low(Integer);
end;

procedure TSignatureSetup.UpdatePSWNotices(hasPSW: Boolean);
begin
  if hasPSW then
    begin
      chkPassword.InitState(cbChecked);
      lblPSWNotice.visible := True;
    end
  else
    begin
      chkPassword.InitState(cbUnChecked);
      lblPSWNotice.visible := False;
    end;
end;

procedure TSignatureSetup.UpdateSignatureDisplay;
var
  BitM: TBitMap;
begin
  lblNote.Caption := '';
  SignatureDisplay.Picture := nil;                    //start new
  SignatureDisplay.Width := SigDisplayWidth;          //reset the size
  SignatureDisplay.Height := SigDisplayHeight;
  // Version 7.0.0 111909 JWyatt: Make sure the selected user has a signature image
  //  to display. If not then the SignatureDisplay.Picture is nil and nothing
  //  shows on the screen.
  if FActiveUser.HasSignature then
    if FWorkingImage.HasGraphic then
      begin
        BitM := TBitMap.Create;
        try
          //### There may be a crash here due to ImageLib bug with 16/32 bit images
          FWorkingImage.FDIB.DibToBitmap(BitM);
          with FActiveUser.Signature do
            begin
              //adjust display to fit signature image
              if not RectEmpty(FDestRect) and
                (FDestRect.Right < SignatureDisplay.width) and
                (FDestRect.Bottom < SignatureDisplay.Height) then
                begin
                  SignatureDisplay.Top := 129 {SignatureDisplay.Top} + (SignatureDisplay.Height - FDestRect.Bottom);
                  SignatureDisplay.Height := FDestRect.Bottom;
                  SignatureDisplay.Width := FDestRect.Right;
                end;
            end;
          SignatureDisplay.Picture.Assign(BitM);       //display for affixing
        finally
          BitM.Free;
          if FNeedsSetup then begin
            lblNote.caption := 'Your signature needs to be re-positioned. Use Setup to adjust it.';
            ActiveControl := btnSetup;
          end;
        end;
      end;
end;

procedure TSignatureSetup.UpdateSignatureOptions;
var
  AvailActions: TStringList;
begin
  if FDocSigMgr <> nil then begin
    AvailActions := FDocSigMgr.GetAvailableSignatureActions(FActiveUser);   //get available actions
    cbxUserActions.Items.Assign(AvailActions);
    AvailActions.Free;

  end;
  cbxUserActions.ItemIndex := 0;                        //select the first one
  cbxUserActionsChange(nil);                            //set the buttons
end;

procedure TSignatureSetup.btnDoItClick(Sender: TObject);
const
  cNotEditable = 1;
var
  n, action: Integer;
  actStr: String;
  DateText: String;
  UserSig: TSignature;
begin
  if FNeedsSetup then
    ShowNotice('The signature needs to be setup before affixing to the report.')

  else begin
    //now do the selected action
    actStr := cbxUserActions.Items[cbxUserActions.ItemIndex];
    action := saNone;
    if POS('Affix', actStr) > 0 then
      action := saAffix
    else if POS('Remove', actStr) > 0 then
      action := saRemove
    else
      ShowNotice('This is an unrecognized action. Please re-select it.');

    case action of
      saAffix:
        begin
          UserSig := TSignature.Create;
          try
            //check for password protection
            if FActiveUser.Signature.FUsePSW then
              if not MatchPasswords(FActiveUser.Signature.FPassword) then
                Exit;
            UserSig.FKind := FDocSigMgr.GetSignatureKind(actStr);            //parse, get second token
            UserSig.FPerson := FActiveUser.SWLicenseName;
            UserSig.FLockDoc := chkLockIt.Checked;
            UserSig.FUsePSW := FActiveUser.Signature.FUsePSW;
            UserSig.FPassword := FActiveUser.Signature.FPassword;
            UserSig.FOffset.X := FActiveUser.Signature.FOffsetX;
            UserSig.FOffset.Y := FActiveUser.Signature.FOffsetY;
            UserSig.FDestRect := FActiveUser.Signature.FDestRect;
            UserSig.FSigImage.Assign(FWorkingImage);
            UserSig.FSigImage.Transparent := True;

            if (chkDateIt.Checked) then
              begin
                DateText := FormatDateTime(CUADDateFormat, Date);
                (FDocSigMgr.FDoc as TContainer).BroadcastCellContext(GetSignDateContextID(UserSig.FKind), DateText);
              end;
          finally
            FDocSigMgr.AffixSignature(UserSig);
            ModalResult := mrOK;
          end;
        end;

      saRemove:
        begin
          n := cbxUserActions.ItemIndex;
          UserSig := TSignature(cbxUserActions.Items.Objects[n]);
          if UserSig.FUsePSW then
            if not MatchPasswords(UserSig.FPassword) then
              exit;
          FDocSigMgr.RemoveSignature(UserSig);    //remove this one
          ModalResult := mrOK;                    //need option not to close
        end;
    end;
  end;
end;

procedure TSignatureSetup.chkLockItClick(Sender: TObject);
begin
  if chkLockIt.Checked then
    chkAllowSignatures.Enabled := True
  else
    chkAllowSignatures.Enabled := False;
end;

procedure TSignatureSetup.btnSetupClick(Sender: TObject);
var
  SigSetup: TSigSetup;
begin
  //check for password protection
  if FActiveUser.Signature.FUsePSW then
    if not MatchPasswords(FActiveUser.Signature.FPassword) then
      Exit;

  SigSetup := TSigSetup.Create(self);
  with FActiveUser.Signature do
    try
      // Version 7.0.0 111909 JWyatt: Make sure the selected user has a signature
      //  image to display. If not then then clear the working image so that the
      //  prior user's signature does not display in the SigSetup dialog.
      if not FActiveUser.HasSignature then
        FWorkingImage.Clear;
      //load the signature for adjusting
      SigSetup.SetUserSignature(FWorkingImage, FOffsetX, FOffsetY, FDestRect);

      if SigSetup.ShowModal = mrOK then   //let the user adjust it, if ok...
        begin
          FActiveUser.Modified := True;
          if SigSetup.HasSignature then
            begin
              HasSignature := True;
              //get whatever the user setup
              SigSetup.GetUserSignature(FWorkingImage, FOffsetX, FOffsetY, FDestRect);

              //if user never had a signature, make room for one
              if (FActiveUser.Signature.Image = nil) then
                FActiveUser.Signature.Image := TMemoryStream.Create;

              //get the image
              FWorkingImage.FStorage.Seek(0, soFromBeginning);                  //rewind
              FActiveUser.Signature.Image.Clear;
              FActiveUser.Signature.Image.LoadFromStream(FWorkingImage.FStorage);  //copy it all
              FImageLen := FWorkingImage.FStorage.Size;
            end
          else  //no signature returning
            begin
              HasSignature := False;
              FWorkingImage.Clear;
              FOffsetX := 0;
              FOffsetY := 0;
              FDestRect := Rect(0,0,0,0);
              if (FActiveUser.Signature.Image <> nil) then
                FActiveUser.Signature.Image.Free;
              FActiveUser.Signature.Image := nil;
              FImageLen := 0;
              FNeedsSetup := False;
              //did we previously have a password?
              if FActiveUser.Signature.FUsePSW then
                begin
                  FUsePSW := False;
                  FPassword := 0;
                  ShowNotice('You have cleared your signature so your Signature Password Protection has been removed.');
                  UpdatePSWNotices(False);
                end;
            end;

          FNeedsSetup := RectEmpty(FDestRect);
          UpdateSignatureDisplay;
          UpdateSignatureOptions;
        end; //if ok
    finally
      SigSetup.Free;
    end;
end;

procedure TSignatureSetup.chkPasswordClick(Sender: TObject);
var
  newPSW: Longint;
begin
  //has a password, is removing it
  if FActiveUser.Signature.FUsePSW then
    begin
      if MatchPasswords(FActiveUser.Signature.FPassword) then
        begin
          FActiveUser.Signature.FUsePSW := False;
          FActiveUser.Signature.FPassword := 0;
          FActiveUser.Modified := True;
          ShowAlert(atWarnAlert, 'Your Signature Password Protection has been removed.');
          UpdatePSWNotices(False);
        end
      else //did not remove, so re-check the box
        chkPassword.InitState(cbChecked);
    end
  //no password, need to set it
  else
    begin
      if SetUserPassword(newPSW) then
        begin
          FActiveUser.Signature.FUsePSW := True;
          FActiveUser.Signature.FPassword := newPSW;
          FActiveUser.Modified := True;
          ShowNotice('Your signature is now password protected.');
          UpdatePSWNotices(True);
        end
      else //password not set, remove check in box
        chkPassword.InitState(cbUnchecked);
    end;
end;

procedure TSignatureSetup.SetHasSignature(const Value: Boolean);
begin
  FHasSignature := Value;
  chkPassword.Enabled := Value;
end;



{ TSignatureMgr }

constructor TSignatureMgr.Create(AOwner: TComponent);
begin
  inherited Create;
  OwnsObjects := True;       //we own the objects, we will free them

  FDoc := AOwner;
end;

destructor TSignatureMgr.Destroy;
begin
  FDoc := nil;
  inherited;
end;

procedure TSignatureMgr.Assign(Source: TSignatureMgr);
var
  Sig: TSignature;
  i: Integer;
begin
  if assigned(Source) then
    begin
      Clear;   //get rig of previous signatures

      for i := 0 to Source.count-1 do
        begin
          Sig := TSignature(Source.Items[i]).CreateClone;
          if assigned(Sig) then
            AffixSignature(Sig);
        end;
    end;
end;

procedure TSignatureMgr.Clear;
begin
  while (Count > 0) do
    RemoveSignature(First as TSignature);
end;

//after we load a container, call this to set the signature bounds
procedure TSignatureMgr.UpdateSignatureBounds;
var
  i: Integer;
  stampKind: String;
begin
  if Count > 0 then
    for i := 0 to Count-1 do
      begin
        stampKind := TSignature(Items[i]).FKind;

        // this is absolutely horrible (spaghetti) code
        if Assigned(FDoc) then
          TContainer(FDoc).UpdateSignature(stampKind, False, True); //don't display, setup bounds
      end;
end;

//when adding a new form, call this to set the info cell bounds to the signature
procedure TSignatureMgr.UpdateFormSignatures(AForm: TObject);
var
  i: Integer;
  stampKind: String;
begin
  if Count > 0 then
    for i := 0 to Count-1 do
      begin
        stampKind := TSignature(Items[i]).FKind;
        TDocForm(AForm).UpdateSignature(stampKind, True, True); //display, setup bounds
      end;
end;

procedure TSignatureMgr.AffixSignature(Signature: TSignature);
var
  lockIt: Boolean;
  stampKind: String;
begin
  lockIt := Signature.FLockDoc;              //new signature
  stampKind := Signature.FKind;

  Add(Signature);                                 //add it to list to manage

  // this is absolutely horrible (spaghetti) code
  if Assigned(FDoc) then
    begin
      TContainer(FDoc).UpdateSignature(stampKind, True, True);    //signIt, setup Bounds
      if lockIt then
        TContainer(FDoc).SetSignatureLock(True);      //inc the SigLockCount
    end;
end;

procedure TSignatureMgr.RemoveSignature(Signature: TSignature);
var
  wasLocked: Boolean;
  stampKind: String;
begin
  stampKind := Signature.FKind;                     //signature to be removed
  wasLocked := Signature.FLockDoc;                //it caused doc to be locked
  if Signature <> nil then
    Remove(Signature);                            //remove from Signature Mgr

  // this is absolutely horrible (spaghetti) code
  if Assigned(FDoc) then
    begin
      TContainer(FDoc).UpdateSignature(stampKind, True, False);    //redisplay, restore bounds
      if wasLocked then
        TContainer(FDoc).SetSignatureLock(False);     //dec the SigLockCount
      TContainer(FDoc).docView.Invalidate;
    end;
end;

function TSignatureMgr.SignatureIndexOf(const SigKind: String): Integer;
var
  i: Integer;
begin
  result := -1;
  i := 0;
  if count > 0 then
    while (i < count) and (comparetext(UpperCase(SigKind), Uppercase(TSignature(Items[i]).FKind))<>0) do
      inc(i);
  if i < count then
    result := i;
end;

//all signature action strings will have the signature kind as the last word
function TSignatureMgr.GetSignatureKind(Const SigAction: String): String;
var
  i,L: Integer;
begin
  L := length(SigAction);
  i := L;
  while (i > 0) and (SigAction[i] <> ' ') do dec(i);   //count down to first space
  result := Copy(SigAction, i+1, L-i);
end;

//scans doc for all signature types
function TSignatureMgr.GetAvailableSignatureActions(User: TlicensedUser): TStringList;
var
  SigPlaces, AvailActions: TStringList;
  userNote: String;
  i,j: Integer;
begin
  // this is absolutely horrible (spaghetti) code
  if Assigned(FDoc) then
    SigPlaces := TContainer(FDoc).GetSignatureTypes   //this is where they can sign
  else
    SigPlaces := nil;

  AvailActions := TStringList.Create;
  AvailActions.Sorted := True;
  AvailActions.Duplicates := dupIgnore;
  try
    //remove any already affixed signature options
    if (SigPlaces <> nil) and (Count > 0) then
      for i := 0 to Count-1 do
        for j := SigPlaces.Count-1 downto 0 do
          if CompareText(SigPlaces[j], TSignature(Items[i]).FKind)=0 then
            SigPlaces.Delete(j);

    //set the remove actions
    if Count > 0 then
      for i := 0 to Count-1 do
        AvailActions.AddObject('Remove ' +TSignature(Items[i]).FKind+ ' Signature', Items[i]);

    //set the affix actions
    userNote := '';
    if User.HasSignature then
      begin
        if (SigPlaces <> nil) and (SigPlaces.Count > 0) then
          for i := 0 to SigPlaces.count-1 do
            AvailActions.AddObject('Affix Signature as '+ SigPlaces[i], nil);
      end
    else
      userNote := ' Please setup your signature';

  finally
    if SigPlaces <> nil then
      SigPlaces.Free;

    if AvailActions.Count = 0 then   //there were no actions
      AvailActions.Add('There are no signature options.'+ userNote);

    result := AvailActions;
  end;
end;

//As the action changes, change the doit button
procedure TSignatureSetup.cbxUserActionsChange(Sender: TObject);
var
  Kind: String;
begin
  Kind := FDocSigMgr.GetSignatureKind(cbxUserActions.Text);
  if (POS('Affix', cbxUserActions.Text) >0) and FHasSignature then
    begin
      btnDoIt.Caption := 'Affix';
      btnDoIt.Enabled := True;
      chkDateIt.Enabled := SameText(Kind, 'Appraiser') or SameText(Kind, 'Supervisor');
      chkLockIt.Enabled := True;
      if not FNeedsSetup then
        ActiveControl := btnDoIt;
    end
  else if POS('Remove', cbxUserActions.Text) >0 then
    begin
      btnDoIt.Caption := 'Remove';
      btnDoIt.Enabled := True;
      chkDateIt.Enabled := False;
      chkLockIt.Checked := False;
      chkLockIt.Enabled := False;
      chkAllowSignatures.Checked := False;
      chkAllowSignatures.enabled := False;
      ActiveControl := btnDoIt;
    end
  else begin
    btnDoIt.Caption := 'Affix';
    btnDoIt.Enabled := False;
    chkDateIt.Enabled := False;
    chkLockIt.Enabled := False;
    ActiveControl := btnSetup;
  end;

  if not chkDateIt.Enabled then
    chkDateIt.Checked := False;
end;

procedure TSignatureMgr.ReadFromStream(stream: TStream);
var
  i, numSigs: LongInt;
  UserSig: TSignature;
begin
  numSigs := ReadLongFromStream(Stream);
  if numSigs > 0 then
    for i := 1 to numSigs do
      begin
        UserSig := TSignature.Create;
        try
          UserSig.ReadFromStream(Stream);      //read
        finally
          Add(UserSig);                       //add it
        end;
      end;
end;

procedure TSignatureMgr.ReadFromStream2(stream: TStream; bShowMessage:Boolean=True);
var
  i, numSigs: LongInt;
  UserSig: TSignature;
begin
  numSigs := ReadLongFromStream(Stream);
  if numSigs > 0 then
    for i := 1 to numSigs do
      begin
        UserSig := TSignature.Create;
        try
          UserSig.ReadFromStream2(Stream, bShowMessage);      //read
        finally
          Add(UserSig);                       //add it
        end;
      end;
end;


procedure TSignatureMgr.WriteToStream(stream: TStream);
var
  i: Integer;
begin
  WriteLongToStream(Count, Stream);
  for i := 0 to Count-1 do
    TSignature(Items[i]).WriteToStream(Stream);
end;

function TSignatureMgr.GetLockedValue: Boolean;
var
  i: integer;
begin
  result := False;
  if count > 0 then
    for i := 0 to count-1 do
      if TSignature(Items[i]).FLockDoc then  //only set if true
        result := True;
end;



{ TSignature }

constructor TSignature.Create;
begin
  inherited;

  FKind := '';                        //kind: appraiser, super, reviewer, etc
  FPerson := '';                      //name of person
  FLockDoc := False;                  //is the doc locked with signature
  FUsePSW := False;                   //use the PSW to remove and to set
  FPassword := 0;                     //password encoded numnber
  FOffset := Point(0,0);              //offset from hot point
  FDestRect := Rect(0,0,0,0);         //display image here - implicit scaling
  FSigImage := TCFImage.Create;       //the signature image
  FSigImage.Transparent := True;      //they are always transparent
end;

destructor TSignature.Destroy;
begin
  If Assigned(FSigImage) then
    FSigImage.Free;

  inherited;
end;

function TSignature.CreateClone: TSignature;
begin
  result := TSignature.Create;

  result.FKind          := FKind;
  result.FPerson        := FPerson;
  result.FLockDoc       := FLockDoc;
  result.FAllowOtherSig := FAllowOtherSig;
  result.FUsePSW        := FUsePSW;
  result.FPassword      := FPassword;
  result.FOffset        := FOffset;
  result.FDestRect      := FDestRect;

  result.FSigImage.assign(FSigImage);
  result.FSigImage.Transparent := True;      //they are always transparent
end;

procedure TSignature.ReadFromStream(stream: TStream);
begin
  FKind := ReadStringFromStream(Stream);
  FPerson := ReadStringFromStream(Stream);
  FLockDoc := ReadBoolFromStream(Stream);
  FAllowOtherSig := ReadBoolFromStream(Stream);
  FUsePSW := ReadBoolFromStream(Stream);
  FPassword := ReadLongFromStream(Stream);
  FOffset.x := ReadLongFromStream(Stream);
  FOffset.y := ReadLongFromStream(Stream);
  FDestRect := ReadRectFromStream(Stream);

  FSigImage.LoadFromStream(Stream);
  FSigImage.Transparent := True;      //they are always transparent
end;

procedure TSignature.ReadFromStream2(stream: TStream; bShowMessage:Boolean=True);
begin
  FKind := ReadStringFromStream(Stream);
  FPerson := ReadStringFromStream(Stream);
  FLockDoc := ReadBoolFromStream(Stream);
  FAllowOtherSig := ReadBoolFromStream(Stream);
  FUsePSW := ReadBoolFromStream(Stream);
  FPassword := ReadLongFromStream(Stream);
  FOffset.x := ReadLongFromStream(Stream);
  FOffset.y := ReadLongFromStream(Stream);
  FDestRect := ReadRectFromStream(Stream);

  FSigImage.LoadFromStream2(Stream, bShowMessage);
  FSigImage.Transparent := True;      //they are always transparent
end;


procedure TSignature.WriteToStream(stream: TStream);
begin
  WriteStringToStream(FKind, Stream);
  WriteStringToStream(FPerson, Stream);
  WriteBoolToStream(FLockDoc, Stream);
  WriteBoolToStream(FAllowOtherSig, Stream);
  WriteBoolToStream(FUsePSW, Stream);
  WriteLongToStream(FPassword, Stream);
  WriteLongToStream(FOffset.x, Stream);
  WriteLongToStream(FOffset.y, Stream);
  WriteRectToStream(FDestRect, Stream);

  FSigImage.SaveToStream(Stream);
end;

/// summary: Saves the state of the DateIt checkbox to the registry.
procedure TSignatureSetup.chkDateItClick(Sender: TObject);
begin
  if not FRegistry.ValueExists(CSettings_DateIt) or (FRegistry.GetDataType(CSettings_DateIt) = rdInteger) then
    FRegistry.WriteInteger(CSettings_DateIt, Integer(chkDateIt.Checked));
end;

end.
