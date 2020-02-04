unit UGSEComments;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

interface

uses
  UEditorDialog;

type
  /// summary: A UAD dialog for editing carry-over comments.
  /// remarks: Developed to meet the Uniform Appraisal Dataset (UAD) requirements of the GSEs.
  TdlgGSEComments = class(TDialogEditorForm)
  protected
    procedure LoadForm; override;
    procedure SaveForm; override;
  public
    procedure Clear; override;
    function GetOverflowText: String; override;
    function ShowModal: Integer; override;
  end;

implementation

{$R *.dfm}

uses
  Classes,
  Controls,
  UStatus,
  UStrings;

procedure TdlgGSEComments.LoadForm;
begin
  // do nothing
end;

procedure TdlgGSEComments.SaveForm;
begin
  // do nothing
end;

procedure TdlgGSEComments.Clear;
begin
  // do nothing
end;

function TdlgGSEComments.GetOverflowText: String;
begin
  Result := '';
end;

/// summary: Shows a message to the user explaining how to edit the comments.
function TdlgGSEComments.ShowModal: Integer;
begin
  ShowNotice(msgUADEditComments);
  Result := mrCancel;
end;

initialization
  RegisterClass(TdlgGSEComments);

end.
