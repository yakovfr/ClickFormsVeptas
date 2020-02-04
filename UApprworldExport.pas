unit UApprWorldExport;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2006 by Bradford Technologies, Inc. }

{  Appraisal World Export Unit}



interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UApprWorldOrders, StdCtrls, ExtCtrls, ComCtrls, UForms;

type
  TApprWorldExport = class(TAdvancedForm)
    rbgFileType: TRadioGroup;
    btnSend: TButton;
    btnCancel: TButton;
    Label3: TLabel;
    edtOrderID: TEdit;
    StatusBar: TStatusBar;
    OpenDialog: TOpenDialog;
    procedure OnOrderIDChanged(Sender: TObject);
    procedure OnbtnOKEnter(Sender: TObject);
    procedure btnSendClick(Sender: TObject);
    procedure OnFormCreate(Sender: TObject);
    procedure OnCancel(Sender: TObject);
   private
    { Private declarations }
  public
    { Public declarations }
    bSent: Boolean
  end;

var
  ApprWorldExport: TApprWorldExport;


implementation

uses
  UContainer, UStatus;
{$R *.dfm}



procedure TApprWorldExport.OnOrderIDChanged(Sender: TObject);
begin
  btnSend.Enabled := length(TEdit(Sender).Text) > 0;
  StatusBar.SimpleText := '';
end;

procedure TApprWorldExport.OnbtnOKEnter(Sender: TObject);
begin
  if not ValidateOrderID(edtOrderID.Text) then
    begin
      StatusBar.SimpleText := 'Invalid Order ID';
      btnSend.Enabled := False;
    end;
end;

procedure TApprWorldExport.btnSendClick(Sender: TObject);
var
  doc: TContainer;
begin
   bSent := False;
   doc := TContainer(Owner);
   if not ValidateOrderID(edtOrderID.Text) then
    begin
      StatusBar.SimpleText := 'Invalid Order ID';
      btnSend.Enabled := False;
      Exit;
    end;
   case rbgFileType.ItemIndex of
    0: //ClickForms file
      if doc.docDataChged then
        begin
          ShowNotice('You have unsaved data in the report.'#13#10+
                    'Please save the report before uploading.');
          Close;
          Exit;
        end
      else
        bSent := SendReportToAW(doc,'repclk',doc.docFullPath);
    1: //Report: Adobe PDF
      begin
        OpenDialog.Title := 'Find PDF Report';
        OpenDialog.Filter := 'PDF files (*.pdf)|*.pdf';
        if OpenDialog.Execute then
          bSent :=  SendReportToAW(doc,'reppdf',Opendialog.FileName);
      end;
    2: //Invoice Adobe PDF
      begin
        OpenDialog.Title := 'Find PDF Invoice';
        OpenDialog.Filter := 'PDF files (*.pdf)|*.pdf';
        if OpenDialog.Execute then
          bSent :=  SendReportToAW(doc,'invpdf',Opendialog.FileName);
      end;
    end;
    if not bSent then
      ShowNotice('The file cannot be uploaded.');
  Close;
end;

procedure TApprWorldExport.OnFormCreate(Sender: TObject);
begin
  rbgFileType.ItemIndex := 0; //ClickForms report is the default
  edtOrderId.Text := GetAWOrderID(TContainer(owner));
  btnSend.Enabled := length(edtOrderID.Text) > 0;
end;

procedure TApprWorldExport.OnCancel(Sender: TObject);
begin
  Close;
end;

end.
