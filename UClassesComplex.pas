unit UClassesComplex;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

interface

uses
  UClasses,
  UMessages,
  UPgView;

type
  // TAppraisalCell
  TAppraisalCell = class(TPageCell)
    public
      FCellStatus: Integer;
      FParentPage: TAppraisalPage;
    protected
      function GetDisabled: Boolean; virtual;
      procedure SetDisabled(const Value: Boolean); virtual;
    public
      procedure Dispatch(const Msg: TDocumentMessageID; const Scope: TDocumentMessageScope; const Data: Pointer); override;
      procedure Notify(const Msg: TDocumentMessageID; const Data: Pointer); override;
      property Disabled: Boolean read GetDisabled write SetDisabled;
      property ParentPage: TAppraisalPage read FParentPage;
  end;

implementation

uses
  UGlobals,
  UUtil1;

// --- TAppraisalCell ---------------------------------------------------------

/// summary: Indicates whether the cell is disabled.
function TAppraisalCell.GetDisabled: Boolean;
begin
  Result := IsBitSet(FCellStatus, bDisabled)
end;

/// summary: Sets whether the cell is disabled.
procedure TAppraisalCell.SetDisabled(const Value: Boolean);
begin
  if (Value <> IsBitSet(FCellStatus, bDisabled)) then
    if Value then
      FCellStatus := SetBit(FCellStatus, bDisabled)
    else
      FCellStatus := ClrBit(FCellStatus, bDisabled);
end;

/// summary: Dispatches an event message up the document hierarchy until the
///          specified scope has been reached, and then queues the message for
//           delivery to the objects within the scope.
procedure TAppraisalCell.Dispatch(const Msg: TDocumentMessageID; const Scope: TDocumentMessageScope; const Data: Pointer);
begin
  // do nothing
end;

/// summary: Notifies the object and child objects of event messages received.
procedure TAppraisalCell.Notify(const Msg: TDocumentMessageID; const Data: Pointer);
begin
  // do nothing
end;

end.

