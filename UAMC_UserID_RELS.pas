unit UAMC_UserID_RELS;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, RzLine,
  UContainer, UAMC_Base, UAMC_WorkflowBaseFrame;

type
  TAMC_UserRELS = class(TWorkflowBaseFrame)
    Label3: TLabel;
    labelOrder: TLabel;
    Label4: TLabel;
    LabelAddress: TLabel;
    LabelCityStZip: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    LabelRecDate: TLabel;
    LabelDueDate: TLabel;
    Label2: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    edtOrderID: TEdit;
    edtVendorID: TEdit;
    edtUserID: TEdit;
    edtUserPSW: TEdit;
    RzLine3: TRzLine;
    Label1: TLabel;
    radBtnYes: TRadioButton;
    radbtnNo: TRadioButton;
    lblInfluence: TLabel;
    menoInfluence: TMemo;
  private
//    FDoc: TContainer;
//    FData: TDataPackage;
  public
//    constructor CreateFrame(AOwner: TComponent; ADoc: TContainer; AData: TDataPackage);
//    property PackageData: TDataPackage read FData write FData;
  end;

implementation

{$R *.dfm}

{ TAMC_UserID }
(*
constructor TAMC_UserRELS.CreateFrame(AOwner: TComponent; ADoc: TContainer; AData: TDataPackage);
begin
  inherited Create(AOwner);

  FDoc := ADoc;
  FData := AData;
end;
*)
end.
