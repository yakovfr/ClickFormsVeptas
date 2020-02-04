
{
  ClickForms
  (C) Copyright 1998 - 2010, Bradford Technologies, Inc.
  All Rights Reserved.
}

unit UTaskThread;

interface

uses
  Classes;

type
  { forward declarations }
  TTaskThread = class;

  { a callback procedure for performing a threaded task }
  TTaskProcedure = procedure(const Thread: TTaskThread; const Data: Pointer) of object;

  { a thread for performing a generic tasks through callback procedures }
  { thread is always created suspended; call Resume to initiate }
  TTaskThread = class(TThread)
    private
      FExceptionMessage: String;
      FTaskData: Pointer;
      FTaskProcedure: TTaskProcedure;
    protected
      procedure Execute; override;
    public
      constructor Create(const TaskProcedure: TTaskProcedure; const TaskData: Pointer);
      property ExceptionMessage: String read FExceptionMessage;
      property ReturnValue;
      property Terminated;
  end;

implementation

uses
  ActiveX,
  SysUtils;

{ --- TTaskThread ------------------------------------------------------------}

procedure TTaskThread.Execute;
begin
  FExceptionMessage := '';
  ReturnValue := S_OK;
  CoInitialize(nil);
  try
    if Assigned(FTaskProcedure) then
      FTaskProcedure(Self, FTaskData);
  except
    on E: Exception do
      begin
        // cannot return E_UNEXPECTED because EurekaLog has a heart attack and
        // kills the whole program.  Since there is no exception object,
        // EurekaLog finds itself in a recursive never-ending chain of
        // self-inflicted exceptions.  All I can say is that EurekaLog gets what
        // it deserves.  All my sympathy is directed towards our suffering users.
        ReturnValue := S_FALSE;
        FExceptionMessage := E.Message;
      end;
  end;
  CoUninitialize;
  Terminate;
end;

constructor TTaskThread.Create(const TaskProcedure: TTaskProcedure; const TaskData: Pointer);
begin
  FTaskProcedure := TaskProcedure;
  FTaskData := TaskData;
  inherited Create(True);
end;

end.
