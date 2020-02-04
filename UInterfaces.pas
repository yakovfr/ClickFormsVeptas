
{
  ClickForms
  (C) Copyright 1998 - 2009, Bradford Technologies, Inc.
  All Rights Reserved.
}

unit UInterfaces;

interface

type
  IAbortable = interface
  ['{52103267-8ad2-48ea-a55e-50c34444de4e}']
    procedure Abort;
    function GetAborted: Boolean;
    property Aborted: Boolean read GetAborted;
  end;

  TSimpleInterfacedObject = class(TObject, IInterface)
  protected
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
  end;

implementation

function TSimpleInterfacedObject.QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
end;

function TSimpleInterfacedObject._AddRef: Integer; stdcall;
begin
  Result := -1;
end;

function TSimpleInterfacedObject._Release: Integer; stdcall;
begin
  Result := -1;
end;

end.
