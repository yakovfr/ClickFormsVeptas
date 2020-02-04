unit UClasses;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }


interface

uses
  Classes,
  UForms,
  UInterfaces,
  UMessages;

type
  // TAppraisalComponent
  TAppraisalComponent = class(TObject)
    public
      procedure Dispatch(const Msg: TDocumentMessageID; const Scope: TDocumentMessageScope; const Data: Pointer); reintroduce; virtual;
      procedure Notify(const Msg: TDocumentMessageID; const Data: Pointer); virtual;
  end;
  TAppraisalComponentClass = class of TAppraisalComponent;

  // TAppraisalReport
  TAppraisalReport = class(TAdvancedForm)
    protected
      FLockCount: Integer;
    protected
      function GetLocked: Boolean; virtual;
    public
      procedure Dispatch(const Msg: TDocumentMessageID; const Scope: TDocumentMessageScope; const Data: Pointer); reintroduce; virtual; abstract;
      procedure Notify(const Msg: TDocumentMessageID; const Data: Pointer); virtual; abstract;
      procedure LockReport;
      procedure UnlockReport;
    public
      property LockCount: Integer read FLockCount;
      property Locked: Boolean read GetLocked;
  end;

  // TAppraisalForm
  TAppraisalForm = class(TAppraisalComponent)
    private
      FDisabled: Boolean;
    public
      FParentDoc: TAppraisalReport;
    protected
      procedure SetDisabled(const Value: Boolean); virtual;
    public
      constructor Create(docParent: TComponent); virtual; abstract;
    public
      property Disabled: Boolean read FDisabled write SetDisabled;
      property ParentDocument: TAppraisalReport read FParentDoc;
  end;
  TAppraisalFormClass = class of TAppraisalForm;

  // TAppraisalPage
  TAppraisalPage = class(TAppraisalComponent)
    private
      FDisabled: Boolean;
    public
      FParentForm: TAppraisalForm;
    protected
      procedure SetDisabled(const Value: Boolean); virtual;
    public
      property Disabled: Boolean read FDisabled write SetDisabled;
      property ParentForm: TAppraisalForm read FParentForm;
  end;
  TAppraisalPageClass = class of TAppraisalPage;

  // TCellEditor
	TCellEditor = class(TSimpleInterfacedObject)
    public
      constructor Create(AOwner: TAppraisalReport); virtual; abstract;
      procedure Reload; virtual; abstract;
  end;
  TCellEditorClass = class of TCellEditor;

implementation

uses
  SysUtils;

// --- TAppraisalComponent ----------------------------------------------------

/// summary: Dispatches an event message up the document hierarchy until the
///          specified scope has been reached, and then notifies the objects
///          within that scope of the message that was sent.
procedure TAppraisalComponent.Dispatch(const Msg: TDocumentMessageID; const Scope: TDocumentMessageScope; const Data: Pointer);
begin
  // do nothing
end;

/// summary: Notifies the object and child objects of event messages received.
procedure TAppraisalComponent.Notify(const Msg: TDocumentMessageID; const Data: Pointer);
begin
  // do nothing
end;

// --- TAppraisalReport -------------------------------------------------------

function TAppraisalReport.GetLocked: Boolean;
begin
  Result := (FLockCount <> 0);
end;

procedure TAppraisalReport.LockReport;
const
  CMessage = 'The maximum number of locks have already been aquired';
begin
  if (FLockCount = MaxInt) then
    raise Exception.Create(CMessage);

    FLockCount := FLockCount + 1;
    if (FLockCount = 1) then
      Invalidate;
end;

procedure TAppraisalReport.UnlockReport;
const
  CMessage = 'There are no locks to release';
begin
  if (FLockCount = 0) then
    raise Exception.Create(CMessage);

    FLockCount := FLockCount - 1;
    if (FLockCount = 0) then
      Invalidate;
end;

// --- TAppraisalForm ---------------------------------------------------------

procedure TAppraisalForm.SetDisabled(const Value: Boolean);
begin
  FDisabled := Value;
end;

// --- TAppraisalPage ---------------------------------------------------------

procedure TAppraisalPage.SetDisabled(const Value: Boolean);
begin
  FDisabled := Value;
end;

end.
