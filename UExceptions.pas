
{
  ClickForms
  (C) Copyright 1998 - 2009, Bradford Technologies, Inc.
  All Rights Reserved.
}

unit UExceptions;

interface

uses
  SysUtils;

type
  /// summary: Exception class for invalid parameters.
  EArgumentException = class(Exception);

  /// summary: Exception class for a non-critical informational error.
  EInformationalError = class(Exception);

implementation

end.
