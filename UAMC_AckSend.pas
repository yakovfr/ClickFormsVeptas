unit UAMC_AckSend;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls,
  UContainer, UAMC_Base, UAMC_WorkflowBaseFrame;

type
  TAMC_AckSend = class(TWorkflowBaseFrame)
    lblAckFinish: TLabel;
    btnSendSuggestion: TButton;
    Label1: TLabel;
    procedure btnSendSuggestionClick(Sender: TObject);
  private
  public
    procedure InitPackageData; override;
    procedure DoProcessData; override;
  end;

implementation

uses
  UGlobals, UCRMSendSuggestion,USendSuggestion;

{$R *.dfm}

{ TAMC_AckSend }
(*
constructor TAMC_AckSend.CreateFrame(AOwner: TComponent; ADoc: TContainer; AData: TDataPackage);
begin
  inherited Create(AOwner);

  FDoc := ADoc;
  FData := AData;
end;
*)

procedure TAMC_AckSend.InitPackageData;
begin
  lblAckFinish.Caption := PackageData.FEndMsg;
end;

procedure TAMC_AckSend.DoProcessData;
var
  tmpPDF: String;
begin
  tmpPDF := PackageData.TempPDFFile;

  if FileExists(tmpPDF) then
    DeleteFile(tmpPDF);
end;

procedure TAMC_AckSend.btnSendSuggestionClick(Sender: TObject);
begin
  if FUseCRMRegistration then
    UCRMSendSuggestion.SendSuggestionEx(cmdHelpSuggestion, 'ClickFORMS', 'UAD Delivery')
  else
    USendSuggestion.SendSuggestionEx(cmdHelpSuggestion, 'ClickFORMS', 'UAD Delivery');
end;

end.
