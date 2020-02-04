unit UApprWorldMsgs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, UForms;

type
  TApprWorldMsgs = class(TAdvancedForm)
    btnAccept: TButton;
    brnDeclined: TButton;
    btnAssigned: TButton;
    btnScheduled: TButton;
    brnDeclineOnCondition: TButton;
    DateTimePicker1: TDateTimePicker;
    btnInspected: TButton;
    btnOnHold: TButton;
    btnResume: TButton;
    btnInReview: TButton;
    btnCanceled: TButton;
    Button1: TButton;
    Label1: TLabel;
    btnCompleted: TButton;
    Label2: TLabel;
    Label3: TLabel;
    brnClose: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  procedure SetAppraisalOrderMessages(AOwner: TComponent);

implementation

{$R *.dfm}


procedure SetAppraisalOrderMessages(AOwner: TComponent);
var
  AWMsg: TApprWorldMsgs;
begin
	AWMsg := TApprWorldMsgs.Create(AOwner);
	try
		AWMsg.ShowModal;
	finally
		AWMsg.Free;
  end;
end;


end.
