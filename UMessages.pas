unit UMessages;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface

uses
  Messages;

// -- Messaging Infrastructure ------------------------------------------------

const
  /// summary: A Windows message for queueing document message notifications.
  WM_DOCUMENT_NOTIFICATION = WM_APP + 402;

type
  /// summary: An enumeration of document messages.
  TDocumentMessageID = (
    DM_CONFIGURATION_CHANGED,
    DM_LOAD_COMPLETE,
    DM_RELOAD_EDITOR,
    DM_BROADCAST_CONTEXT_PROPERTY,
    DM_BROADCAST_LOCAL_CONTEXT_PROPERTY
  );

  /// summary: Document message delivery scopes.
  TDocumentMessageScope = (
    DMS_DOCUMENT,
    DMS_FORM,
    DMS_PAGE,
    DMS_CELL
  );

  /// summary: A document message notification procedure.
  TNotifyProcedure = procedure(Instance: TObject; const Msg: TDocumentMessageID; const Data: Pointer);

  /// summary: Document notification message data.
  TNotificationMessageData = record
    Msg: TDocumentMessageID;
    Scope: TDocumentMessageScope;
    Data: Pointer;
    NotifyProc: TNotifyProcedure;
    NotifyInstance: TObject;
  end;

  /// summary: A pointer to document message notification data.
  PNotificationMessageData = ^TNotificationMessageData;

  /// summary: Message parameters for WM_DOCUMENT_NOTIFICATION.
  TWMDocumentNotification = packed record
    Msg: Cardinal;
    Reserved: LongInt;
    NotificationData: PNotificationMessageData;
    Result: LongInt;
  end;

// -- Message Data Types ------------------------------------------------------

  /// summary: Data for the DM_BROADCAST_CONTEXT_PROPERTY message.
  TBroadcastContextPropertyData = record
    ContextIDs: array of Integer;
    Name: String;
    Value: String;
  end;

  /// summary: A reference to broadcast context property data.
  PBroadcastContextPropertyData = ^TBroadcastContextPropertyData;

implementation

end.
