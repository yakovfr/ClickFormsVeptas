unit USigSetup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,
  UFrameAnimation, UGraphics, UForms;

type
  TSigSetup = class(TAdvancedForm)
    Animator: TAnimateFrame;
  private
    FHasSignature: Boolean;
    function GetHasSignature: Boolean;
  public
    procedure SetUserSignature(WrkImage: TCFimage; X,Y: Integer; destRect: TRect);
    procedure GetUserSignature(WrkImage: TCFimage; var X,Y: Integer; var destRect: TRect);
    property HasSignature: Boolean read GetHasSignature write FHasSignature;
  end;

var
  SigSetup: TSigSetup;

implementation

uses
  UGlobals, UStatus, UUtil1;



{$R *.dfm}

{ TSigSetup }

function TSigSetup.GetHasSignature: Boolean;
begin
  result := Animator.Actor <> nil;
end;

procedure TSigSetup.SetUserSignature(WrkImage: TCFimage; X,Y: Integer; destRect: TRect);
begin
  Animator.LoadImage(WrkImage, X,Y, destRect);
end;

procedure TSIgSetup.GetUserSignature(WrkImage: TCFimage; var X,Y: Integer; var destRect: TRect);
begin
  if WrkImage <> nil then
    WrkImage.Assign(Animator.Image);

  X := Animator.Stage.Offset.x;
  Y := Animator.Stage.Offset.y;
  destRect := Animator.Stage.DestRect;       //destrect is normalized when read
end;

end.
