unit UStatus;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2005 by Bradford Technologies, Inc. }

{  Status and Message Unit   }

interface

uses
	Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, UForms;

Const
  atInfoAlert = 1;
  atWarnAlert = 2;
  atStopAlert = 3;
  // Version 7.2.7 081610 JWyatt Add the FilterTheStr parameter to the ShowNotice,
  //  and ShowAlert procedures to permit formatted text to display if the user
  //  chooses to not remove carriage returns and line feeds. The default is True to
  //  filter and, thus, remove carriage returns and line feeds.
	Procedure ShowNotice(const Msg: String; FilterTheStr: Boolean=True);
  Procedure ShowNotice2(const msg: String; FilterTheStr: Boolean=True);
  Procedure ShowAlert(AlertTyp: Integer; const Msg: String; FilterTheStr: Boolean=True);
  Procedure ShowAlertWithHelp(AlertTyp: Integer; const Msg, HelpMsg: String; HelpCmd: Integer);
  Procedure ShowOneTime(const Msg: String; var Ok2Show: Boolean);
	Function OK2Continue(const Msg: String; FilterTheStr: Boolean=True): Boolean;
  function OK2ContinueCustom(const MSg: String; const btnYesCaption, btnNoCaption: String): Boolean;
  function WarnOK2Continue(const Msg: String): Boolean;
	Function YesNoCancel(const Msg: String): Integer;
  function OKAll2Continue(var Yes2All, No2All: Boolean; Const Msg: String): Boolean;
  Function WantToSave(const Msg: String): Integer;
  Function WhichOption12(const Opt1, Opt2, Msg: String; default: Integer = 1): Integer;
  function WarnWithOption12(const Opt1, Opt2, Msg: String; default: Integer = 1; FilterTheStr: Boolean=True;Title: String=''): Integer;
	Function WhichOption123(const Opt1, Opt2, Opt3, Msg: String): Integer;
  procedure DebugShowLastError(Const Str: String);
  function FriendlyErrorMsg(const errMsg: String): String;
  Function OK2Continue2(const msg: String; FilterTheStr: Boolean=True;width:Integer=0): Boolean;
  //github 209: add more options to whichoption123Ex dialog
//  Function WhichOption123Ex(const Opt1, Opt2, Opt3, Msg: String; btnwidth: Integer=85; showCheckBox:Boolean=False): Integer;
  Function WhichOption123Ex(var doOverride:Boolean; const Opt1, Opt2, Opt3, Msg: String; btnwidth: Integer=85; showCheckBox:Boolean=False): Integer;
  function WarnWithOption12Ex(const Opt1, Opt2, Msg, Caption: String; default: Integer = 1;
                            FilterTheStr: Boolean=True; btnOpt1Left: Integer = 112;
                            btnOpt1Width: Integer = 120; btnOpt2Left: Integer = 217;
                            btnOpt2Width: Integer = 80): Integer;
  Function WhichOption123Ex2(aCaption: String; var doOverride:Boolean; const Opt1, Opt2, Opt3, Msg: String; btnwidth: Integer=85; showCheckBox:Boolean=False): Integer;


type
	TAlertOptions = (alPlain,alWarn,alStop,alOk,alOKCancel,alYesNoCancel,alYesNo,alYesNoAll,alWarnOKCancel,alWarnYesNo,alOneTime,alWithHelp);

	TAlertForm = class(TVistaAdvancedForm)
    btnOK: TButton;
    btnYes: TButton;
    btnNo: TButton;
		btnCancel: TButton;
    noteMemo: TLabel;     //hack to display multiline message
    InfoIcon: TImage;
    StopIcon: TImage;
    WarningIcon: TImage;
    QuestionIcon: TImage;
    chkOneTime: TCheckBox;
    btnNoAll: TButton;
    chkOverwrite: TCheckBox;    //github 209: add new check box to show Overwrite Data default to invisible
	public
    { Public declarations }
    constructor CreateAlert(AOwner: TComponent; FormType: TAlertOptions);
  end;


implementation

Uses
  UUtil1;

{$R *.DFM}

function FilterString(const text: String): String;
begin
  Result := text;
  Result := StringReplace(Result, #13, '', [rfReplaceAll]);
  Result := StringReplace(Result, #10, '', [rfReplaceAll]);
end;

(* PAM: Ticket #1379 per Jeff, get rid of this routine, use GetTopMostContainer instead
function GetTopMostReport: TComponent;
begin
  result := GetTopMostContainer;

  if not assigned(result) then
    result := Application.MainForm;
end;
*)


constructor TAlertForm.CreateAlert(AOwner: TComponent; FormType: TAlertOptions);
begin
   inherited Create(AOwner);

	 btnOK.Visible := (FormType in [alStop, alWarn, alOk, alOkCancel, alWarnOKCancel, alOneTime, alWithHelp, alYesNoAll]);
	 btnOK.Enabled := (FormType in [alStop, alWarn, alOk, alOkCancel, alWarnOKCancel, alOneTime, alWithHelp, alYesNoAll]);
	 btnOK.TabStop := (FormType in [alStop, alWarn, alOk, alOkCancel, alWarnOKCancel, alOneTime, alWithHelp, alYesNoAll]);
   btnYes.Visible := (FormType in [alYesNoCancel, alYesNo, alWarnYesNo, alYesNoAll]);
   btnYes.Enabled := (FormType in [alYesNoCancel, alYesNo, alWarnYesNo, alYesNoAll]);
   btnYes.TabStop := (FormType in [alYesNoCancel, alYesNo, alWarnYesNo, alYesNoAll]);
   btnNo.Visible := (FormType in [alYesNoCancel, alYesNo, alWarnYesNo, alYesNoAll]);
   btnNo.Enabled := (FormType in [alYesNoCancel, alYesNo, alWarnYesNo, alYesNoAll]);
   btnNo.TabStop := (FormType in [alYesNoCancel, alYesNo, alWarnYesNo, alYesNoAll]);
   btnNoAll.Visible := (FormType in [alYesNoAll]);
   btnNoAll.Enabled := (FormType in [alYesNoAll]);
   btnNoAll.TabStop := (FormType in [alYesNoAll]);
   btnCancel.Visible := (FormType in [alOkCancel, alYesNoCancel, alWarnOKCancel, alWithHelp]);
   btnCancel.Enabled := (FormType in [alOkCancel, alYesNoCancel, alWarnOKCancel, alWithHelp]);
   btnCancel.TabStop := (FormType in [alOkCancel, alYesNoCancel, alWarnOKCancel, alWithHelp]);
   chkOneTime.Visible := (FormType in [alOneTime]);
   chkOverwrite.Visible := False;   //github 209: set to false, only set to true when we need it
   position := poOwnerFormCenter;    //PAM Ticket #1379: use OwnerFormCenter & dmActiveForm for multi monitor to work
   DefaultMonitor := dmActiveForm;
   case ( FormType ) of
     alPlain, alWithHelp,alYesNoAll:
        begin
          Caption := 'Notice';
          InfoIcon.Visible := True;
          InfoIcon.Left := 16;
          InfoIcon.Top := 16;
          WarningIcon.Visible := False;
          QuestionIcon.Visible := False;
        end;
		 alWarn:
				begin
					Caption := 'Warning';
          WarningIcon.Visible := True;
          WarningIcon.Left := 16;
          WarningIcon.Top := 16;
          InfoIcon.Visible := False;
          QuestionIcon.Visible := False;
				end;
		 alStop:
				begin
					Caption := 'Stop';
          StopIcon.Visible := True;
          StopIcon.Left := 16;
          StopIcon.Top := 16;
          InfoIcon.Visible := False;
          QuestionIcon.Visible := False;
				end;
		 alOk:
				begin
					Caption := 'Notice';
          InfoIcon.Visible := True;
          InfoIcon.Left := 16;
          InfoIcon.Top := 16;
          WarningIcon.Visible := False;
          QuestionIcon.Visible := False;
				end;
		 alOkCancel:
        begin
					Caption := 'Continue?';
          QuestionIcon.Visible := True;
          QuestionIcon.Left := 16;
          QuestionIcon.Top := 16;
          WarningIcon.Visible := False;
          InfoIcon.Visible := False;
					btnOK.Left := 217;
        end;
     alYesNoCancel:
        begin
					Caption := 'Question?';
          QuestionIcon.Visible := True;
          QuestionIcon.Left := 16;
          QuestionIcon.Top := 16;
          WarningIcon.Visible := False;
          InfoIcon.Visible := False;
        end;
     alYesNo:
        begin
					Caption := 'Question?';
          QuestionIcon.Visible := True;
          QuestionIcon.Left := 16;
          QuestionIcon.Top := 16;
          WarningIcon.Visible := False;
          InfoIcon.Visible := False;
          btnYes.Left := 217;
					btnNo.Left := 320;
        end;
     alWarnOKCancel:
        begin
					Caption := 'Continue?';
          WarningIcon.Visible := True;
          WarningIcon.Left := 16;
          WarningIcon.Top := 16;
          QuestionIcon.Visible := False;
          InfoIcon.Visible := False;
					btnOK.Left := 217;
          ActiveControl := btnCancel;
        end;
     alWarnYesNo:
        begin
					Caption := 'Continue?';
          WarningIcon.Visible := True;
          WarningIcon.Left := 16;
          WarningIcon.Top := 16;
          QuestionIcon.Visible := False;
          InfoIcon.Visible := False;
          btnYes.Left := 217;
					btnNo.Left := 320;
          ActiveControl := btnNo;
        end;
     alOneTime:
        begin
					Caption := 'Notice';
          InfoIcon.Visible := True;
          InfoIcon.Left := 16;
          InfoIcon.Top := 16;
          WarningIcon.Visible := False;
          QuestionIcon.Visible := False;
        end;
  end;
end;

Procedure ShowNotice(const msg: String; FilterTheStr: Boolean=True);
var
	alert : TAlertForm;
begin
	alert := TAlertForm.CreateAlert(GetTopMostContainer, alOk);
	try
    if FilterTheStr then
  		alert.noteMemo.Caption := FilterString(msg)
    else
	  	alert.noteMemo.Caption := msg;
    //application.NormalizeTopMosts;
    //alert.BringToFront;
    alert.Position := poMainFormCenter;
		alert.showmodal;
    //application.RestoreTopMosts;
	finally
		alert.free;
	end;
end;

Procedure ShowNotice2(const msg: String; FilterTheStr: Boolean=True);
var
	alert : TAlertForm;
begin
	alert := TAlertForm.CreateAlert(GetTopMostContainer, alOk);
	try
    if FilterTheStr then
  		alert.noteMemo.Caption := FilterString(msg)
    else
	  	alert.noteMemo.Caption := msg;
    application.NormalizeTopMosts;  //github 214: Use NormalizeTopMosts to allow the message that is displayed using the Windows API functions
    try
//      alert.BringToFront;
		  alert.showmodal;
    finally
      application.RestoreTopMosts; //github 214: put it back
    end;
	finally
		alert.free;
	end;
end;


Procedure ShowOneTime(const Msg: String; var Ok2Show: Boolean);
var
	alert : TAlertForm;
begin
  if Ok2Show then
    begin
	    alert := TAlertForm.CreateAlert(GetTopMostContainer, alOneTime);
      try
        alert.noteMemo.Caption := FilterString(msg);
        //alert.BringToFront;
        alert.showmodal;
        Ok2Show := not alert.chkOneTime.Checked;
      finally
        alert.free;
      end;
    end;
end;

Procedure ShowAlert(AlertTyp: Integer; const Msg: String; FilterTheStr: Boolean=True);
var
	alert : TAlertForm;
begin
  case alertTyp of
    atInfoAlert: alert := TAlertForm.CreateAlert(GetTopMostContainer, alOk);
    atWarnAlert: alert := TAlertForm.CreateAlert(GetTopMostContainer, alWarn);
    atStopAlert: alert := TAlertForm.CreateAlert(GetTopMostContainer, alStop);
  else
    alert := TAlertForm.CreateAlert(GetTopMostContainer, alOk);
  end;

	try
    if FilterTheStr then
  		alert.noteMemo.Caption := FilterString(msg)
    else
	  	alert.noteMemo.Caption := msg;
    //alert.BringToFront;
    alert.Position := poMainFormCenter;
		alert.showmodal;
    //application.BringToFront;

	finally
		alert.free;
	end;
end;

Procedure ShowAlertWithHelp(AlertTyp: Integer; const Msg, HelpMsg: String; HelpCmd: Integer);
begin
end;

Function OK2Continue(const msg: String; FilterTheStr: Boolean=True): Boolean;
var
	alert : TAlertForm;
begin
	alert := TAlertForm.CreateAlert(GetTopMostContainer, alYesNo);
	try
    if FilterTheStr then
		  alert.noteMemo.Caption := FilterString(msg)
    else
      alert.noteMemo.Caption := msg;
    //alert.BringToFront;
		result := alert.showmodal = mrYes;
	finally
		alert.free;
	end;
end;

Function OK2Continue2(const msg: String; FilterTheStr: Boolean=True;width:Integer=0): Boolean;
var
	alert : TAlertForm;
begin
	alert := TAlertForm.CreateAlert(GetTopMostContainer, alYesNo);
	try
    if width > 0 then   //change the width if we pass in
      alert.Width  := width;
    if FilterTheStr then
		  alert.noteMemo.Caption := FilterString(msg)
    else
      alert.noteMemo.Caption := msg;
		result := alert.showmodal = mrYes;
	finally
		alert.free;
	end;
end;


//has customized captions instead of Yes and No
function OK2ContinueCustom(const msg: String; const btnYesCaption, btnNoCaption: String): Boolean;
var
	alert : TAlertForm;
begin
	alert := TAlertForm.CreateAlert(GetTopMostContainer, alYesNo);
	try
		alert.noteMemo.Caption := FilterString(msg);
    //alert.BringToFront;
    alert.btnYes.Caption := btnYesCaption;
    alert.btnNo.Caption := btnNoCaption;
		result := alert.showmodal = mrYes;
	finally
		alert.free;
	end;
end;


function WarnOK2Continue(const Msg: String): Boolean;
var
	alert : TAlertForm;
begin
	alert := TAlertForm.CreateAlert(GetTopMostContainer, alWarnYesNo);
	try
		alert.noteMemo.Caption := FilterString(msg);
    //alert.BringToFront;
		result := alert.showmodal = mrYes;
	finally
		alert.free;
	end;
end;

Function YesNoCancel(const Msg: String): Integer;
var
	alert : TAlertForm;
begin
	alert := TAlertForm.CreateAlert(GetTopMostContainer, alYesNoCancel);
	try
		alert.noteMemo.Caption := FilterString(msg);
    //alert.BringToFront;
		result := alert.showmodal;
	finally
		alert.free;
	end;
end;

function OKAll2Continue(var Yes2All, No2All: Boolean; Const Msg: String): Boolean;
var
	alert : TAlertForm;
begin
  result := true;
	alert := TAlertForm.CreateAlert(GetTopMostContainer, alYesNoAll);
	alert.btnOK.caption := 'Yes';
  alert.btnOK.ModalResult := mrYes;
	alert.btnYes.caption := 'Yes to All';
  alert.btnYes.ModalResult := mrYesToAll;
	try
		alert.noteMemo.Caption := FilterString(msg);
    //alert.BringToFront;
		case alert.showmodal of
      mrYes:
        result := True;
      mrNo:
        result := False;
      mrYesToAll:
        begin
          result := True;
          Yes2All := True;
        end;
      mrNoToAll:
        begin
          result := False;
          No2All := True;
        end;
    end;

	finally
		alert.free;
	end;
end;

Function WantToSave(const Msg: String): Integer;
var
	alert : TAlertForm;
begin
	alert := TAlertForm.CreateAlert(GetTopMostContainer, alYesNoCancel);
  alert.btnYes.Caption := 'Save';
  alert.btnNo.Caption := 'Don''t Save';
	try
		alert.noteMemo.Caption := FilterString(msg);
    //alert.BringToFront;
		result := alert.showmodal;
	finally
		alert.free;
	end;
end;

Function WhichOption12(const Opt1, Opt2, Msg: String; default: Integer): Integer;
var
	alert : TAlertForm;
begin
	alert := TAlertForm.CreateAlert(GetTopMostContainer, alYesNo);
	alert.btnYes.caption := Opt1;
	alert.BtnNo.caption := Opt2;

  // change the default button
  if (default = 1) then
    begin
      alert.btnYes.Default := true;
      alert.ActiveControl := alert.btnYes;
    end
  else if (default = 2) then
    begin
      alert.btnNo.Default := true;
      alert.ActiveControl := alert.btnNo;
    end;

	try
		alert.noteMemo.Caption := FilterString(msg);
    //alert.BringToFront;
		result := alert.showmodal;
	finally
		alert.free;
	end;
end;

function WarnWithOption12(const Opt1, Opt2, Msg: String; default: Integer = 1; FilterTheStr: Boolean=True; Title: String=''): Integer;
var
	alert : TAlertForm;
begin
	alert := TAlertForm.CreateAlert(GetTopMostContainer, alWarnYesNo);
	alert.btnYes.caption := Opt1;
	alert.BtnNo.caption := Opt2;
  if length(Title) > 0 then   //if we include title
    alert.Caption := Title;

  // change the default button
  if (default = 1) then
    begin
      alert.btnYes.Default := true;
      alert.ActiveControl := alert.btnYes;
    end
  else if (default = 2) then
    begin
      alert.btnNo.Default := true;
      alert.ActiveControl := alert.btnNo;
    end;

	try
    if FilterTheStr then
  		alert.noteMemo.Caption := FilterString(msg)
    else
  		alert.noteMemo.Caption := msg;
    //alert.BringToFront;
		result := alert.showmodal;
	finally
		alert.free;
	end;
end;

Function WhichOption123(const Opt1, Opt2, Opt3, Msg: String): Integer;
var
	alert : TAlertForm;
begin
	alert := TAlertForm.CreateAlert(GetTopMostContainer, alYesNoCancel);
	alert.btnYes.caption := Opt1;
	alert.BtnNo.caption := Opt2;
	alert.btnCancel.caption := Opt3;
	try
		alert.noteMemo.Caption := FilterString(msg);
    //alert.BringToFront;
		result := alert.showmodal;
	finally
		alert.free;
	end;
end;

//github 209: add more options to show check box: Overwrite Data
Function WhichOption123Ex(var doOverride:Boolean; const Opt1, Opt2, Opt3, Msg: String; btnwidth: Integer=85; showCheckBox:Boolean=False): Integer;
var
	alert : TAlertForm;
begin
	alert := TAlertForm.CreateAlert(GetTopMostContainer, alYesNoCancel);
  alert.btnYes.Width       := btnWidth;
  alert.btnNo.Width        := btnWidth;
	alert.btnYes.caption     := Opt1;
	alert.BtnNo.caption      := Opt2;
	alert.btnCancel.caption  := Opt3;
  alert.chkOverwrite.Checked := doOverride;  //github 243
  if length(Opt2) = 0 then
    alert.btnNo.Width := 0;
  if length(Opt3) = 0 then
    alert.btnCancel.Width := 0;
	try
		alert.noteMemo.Caption := FilterString(msg);
    alert.chkOverwrite.visible := showCheckBox;  //github 209
		result := alert.showmodal;
    doOverride := alert.chkOverwrite.Checked;    //github 209: return the boolean back to the caller
	finally
		alert.free;
	end;
end;
//github 209: add more options to show check box: Overwrite Data
Function WhichOption123Ex2(aCaption: String; var doOverride:Boolean; const Opt1, Opt2, Opt3, Msg: String; btnwidth: Integer=85; showCheckBox:Boolean=False): Integer;
var
  alert : TAlertForm;
begin
  alert := TAlertForm.CreateAlert(GetTopMostContainer, alYesNoCancel);
  alert.Caption := aCaption;
  alert.btnYes.Width       := btnWidth;
  alert.btnNo.Width        := btnWidth;
  alert.btnYes.caption     := Opt1;
  alert.BtnNo.caption      := Opt2;
  alert.btnCancel.caption  := Opt3;
  alert.chkOverwrite.Visible := showCheckBox;
  alert.chkOverwrite.Checked := doOverride;  //github 243
  if length(Opt1) = 0 then
    alert.btnYes.width := 0;
  if length(Opt2) = 0 then
    begin
      alert.btnNo.Width := 0;
      alert.btnCancel.width := btnWidth;
      alert.btnCancel.left := alert.btnNo.left;
    end;

  if length(Opt3) = 0 then
    alert.btnCancel.Width := 0;
  try
    alert.noteMemo.Caption := FilterString(msg);
    alert.chkOverwrite.visible := showCheckBox;  //github 209
    result := alert.showmodal;
    doOverride := alert.chkOverwrite.Checked;    //github 209: return the boolean back to the caller
  finally
    alert.free;
  end;
end;


procedure DebugShowLastError(Const Str: String);
var
  err: Integer;
begin
  err := GetLastError;
  if err <> 0 then showNotice(str + ': '+IntToStr(err));
end;

function FriendlyErrorMsg(const errMsg: String): String;
begin
  result := errMsg;   //if we cannot identify, pass it back

  //Socket Error #10060, #11004 - not connected
  if (POS('10060', errMsg) > 0) or  (POS('11004', errMsg) > 0) then
    result := 'Please make sure you are connected to the Internet. If you have a firewall or anti-virus software, please temporarily disable them.';
end;

function WarnWithOption12Ex(const Opt1, Opt2, Msg, Caption: String; default: Integer = 1;
                            FilterTheStr: Boolean=True; btnOpt1Left: Integer = 112;
                            btnOpt1Width: Integer = 120; btnOpt2Left: Integer = 217;
                            btnOpt2Width: Integer = 80): Integer;
var
  alert : TAlertForm;
begin
  alert := TAlertForm.CreateAlert(GetTopMostContainer, alWarnYesNo);
  alert.btnYes.caption := Opt1;
  alert.BtnNo.caption := Opt2;
  alert.btnYes.Left  := btnOpt1Left;
  alert.btnNo.Left   := btnOpt2Left;
  alert.btnYes.Width := btnOpt1Width;
  alert.btnNo.Width  := btnOpt2Width;
  alert.Caption := Caption;

  // change the default button
  if (default = 1) then
    begin
      alert.btnYes.Default := true;
      alert.ActiveControl := alert.btnYes;
    end
  else if (default = 2) then
    begin
      alert.btnNo.Default := true;
      alert.ActiveControl := alert.btnNo;
    end;

	try
    if FilterTheStr then
  		alert.noteMemo.Caption := FilterString(msg)
    else
  		alert.noteMemo.Caption := msg;
    //alert.BringToFront;
		result := alert.showmodal;
	finally
		alert.free;
	end;
end;
end.






