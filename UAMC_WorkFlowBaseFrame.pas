unit UAMC_WorkFlowBaseFrame;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{ This is the base frame for all the Workflow TFrames that show up in }
{ workflow sequence. The common things are the calls to InitpackageData }
{ DoProcessData. Also the common vars are FDoc and FData which are refs }
{ to TContainer and TDatapackage which gets passed from station to station}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs,
  UContainer, UAMC_Globals, UAMC_Base;

type
  TWorkflowBaseFrame = class(TFrame)
  protected
    FDoc: TContainer;                     //REF: direct link to appraisal
    FData: TDataPackage;                  //REF: the data package that goes between workflow steps
  public
    constructor CreateFrame(AOwner: TComponent; ADoc: TContainer; AData: TDataPackage);  virtual;
    procedure InitPackageData;                 virtual;
    procedure ResetPackageData;                virtual;
    procedure DoProcessData;                   virtual;
    procedure StartProcess;                    virtual;
    procedure AdvanceToNextProcess;            virtual;
    function ProcessCompleted: Boolean;        virtual;
    function ProcessedOK: Boolean;             virtual;
    property PackageData: TDataPackage read FData write FData;
  end;

implementation

uses
  ComCtrls,
  UAMC_Delivery;


{$R *.dfm}

{ TBaseWorkflowFrame }

constructor TWorkflowBaseFrame.CreateFrame(AOwner: TComponent; ADoc: TContainer; AData: TDataPackage);
begin
  inherited Create(AOwner);

  FDoc  := ADoc;
  FData := AData;
end;

procedure TWorkflowBaseFrame.InitPackageData;
begin
  PackageData.FGoToNextOk := True;
  PackageData.FHardStop := False;
  PackageData.FAlertMsg := '';
end;

procedure TWorkflowBaseFrame.ResetPackageData;
begin
//decendents need to override
end;

procedure TWorkflowBaseFrame.StartProcess;
begin
//decendents use this to initiate the process
end;

procedure TWorkflowBaseFrame.DoProcessData;
begin
//decendents need to override
end;

function TWorkflowBaseFrame.ProcessCompleted: Boolean;
begin
  Result := True;
end;

function TWorkflowBaseFrame.ProcessedOK: Boolean;
begin
  result := PackageData.FGoToNextOk;      //The data in package thinks its ok (or not)
//decendents need to override
end;

procedure TWorkflowBaseFrame.AdvanceToNextProcess;
begin
  if PackageData.AutoAdvance then
    TAMCDeliveryProcess(TPageControl(TTabSheet(Self.Owner).PageControl).Owner).ProcessMgr.MoveToNextProcess;
end;

end.
