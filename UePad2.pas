unit UePad2;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2005 by Bradford Technologies, Inc. }


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,
  UWinTab, UForms;

const
  MaxPts = 2500;
  epadHotSpotX = 100;       //hard coded for now
  epadHotSpotY = 486-140;

type
  SgnPt = record
    X: Integer;
    Y: Integer;
    Down: Boolean;
  end;
  SgnPtArray = Array of SgnPt;

  TEPadSignature = class(TObject)
    FName: String[63];
    FReason: String[63];
    FUsePSW: Boolean;
    FCodedPSW: LongInt;     //encoded PSW
    FHotSpot: TPoint;
    FBounds: TRect;
    FScale: TPoint;
    FColor: TColor;
    FWidth: Integer;
    FPts: SgnPtArray;   //Array of SgnPt;
    procedure ReadSignatureData(stream: TStream);
    procedure WriteSignatureData(stream: TStream);
  end;

  TEPadInterface = class(TAdvancedForm)
    SignerName: TEdit;
    Label1: TLabel;
    SignerReason: TComboBox;
    Label2: TLabel;
    btnClear: TButton;
    btnCancel: TButton;
    btnSignIt: TButton;
    SignatureArea: TPaintBox;
    procedure SignerNameChange(Sender: TObject);
    procedure SignatureAreaPaint(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FWinTabDLL: THandle;
    FWTContext: HCTX;
    FWTOpened: Boolean;
    FPenContactChanged: Boolean;
    FPenInContact: Boolean;
    FPrevPt: TPoint;
    FCtxOrg: TPoint;        //tablet origin
    FCtxExt: TPoint;        //tablet lengths
    FSgnArea: TPoint;       //signature area on dialog (for scaling)
    FNumPts: Integer;       //num pts in signature
    FPts: SgnPtArray;     //Array of SgnPt;   //actual signature pts
    function SignPtsBounds: TRect;
    function GetEPadSiganture: TEPadSignature;
    procedure ProcessPacketInfo(wSerial, hContext: LongInt);
    procedure MsgWTPacket(var Message: TMessage); message WT_PACKET;
    procedure MsgWTProximity(var Message: TMessage); message WT_PROXIMITY;
    function GetPrintedName: string;
    procedure SetPrintedName(const Value: string);
    procedure AdjustDPISettings;

  public
    constructor Create(AOwner: TComponent);  override;
    destructor Destroy; override;
    property Signature: TEPadSignature read GetEPadSiganture;
    property PrintedName: string read GetPrintedName write SetPrintedName;
  end;


implementation

uses
  Math,
  UGlobals, UStatus;

{$R *.DFM}

constructor TEPadInterface.Create(AOwner: TComponent);
var
  ePadInfo: array[0..255] of char;
  LCntx: LOGCONTEXT;
begin
  inherited Create(AOwner);

  btnSignIt.enabled := False;
  btnClear.enabled := False;

  FPenContactChanged := False;
  FPenInContact := False;

  //Setup the WinTab DLL
  FWinTabDLL := LoadLibrary('Wintab32.dll');                     //find the DLL
  if FWinTabDLL >= 32 then
    begin
      if LoadWinTabFunctions(FWinTabDLL) then                    //load the function
        begin
          if (WTInfo(WTI_INTERFACE, IFC_WINTABID, Pointer(@epadInfo)) >0) and
             (WTInfo(WTI_DEFCONTEXT, 0, PLOGCONTEXT(@LCntx)) >0) then
            begin
              LCntx.lcOptions := CXO_MESSAGES {or CXO_MARGIN};   //want messages and margin
	            LCntx.lcPktData := PK_X or PK_Y;                 //want x and y
	            LCntx.lcPktMode := 0;                             //want them in absolute coords = 0
//PK_GETALL = PK_CONTEXT or PK_STATUS or PK_TIME or PK_SERIAL_NUMBER or PK_BUTTONS or PK_X or PK_Y or PK_Z;
              FWTContext := WTOpen(Handle, LCntx, True);
              FWTOpened := FWTContext <> 0;
              FCtxOrg.x := LCntx.lcInOrgX;
              FCtxOrg.y := LCntx.lcInOrgY;
              FCtxExt.x := LCntx.lcInExtX;
              FCtxExt.y := LCntx.lcInExtY;
              FSgnArea.x := SignatureArea.width;
              FSgnArea.y := SignatureArea.height;
              FPenInContact := False;
              FPenContactChanged := False;
              FPrevPt := Point(0,0);
              FNumPts := 0;
              SetLength(FPts,MaxPts);
            end;
        end;
    end
  else
    ShowNotice('Could not load the WinTab32 DLL. Make sure it is in the system folder.');
end;

destructor TEPadInterface.Destroy;
begin
  if FWTOpened then                  //close the tablet
    WTClose(FWTContext);

  if FWinTabDLL >= 32 then           //release the DLL
    FreeLibrary(FWinTabDLL);

  inherited Destroy;                //goodbye
end;

function TEPadInterface.GetEPadSiganture: TEPadSignature;
begin
  result := TEPadSignature.Create;
  try
    result.FName := copy(SignerName.text, 1, Min(length(SignerName.text), 63));
    result.FReason := copy(SignerReason.text, 1, Min(length(SignerReason.text), 63));
    result.FUsePSW := False;
    result.FCodedPSW := 0;
    result.FBounds := SignPtsBounds;
    result.FScale := Point(FCtxExt.x, FCtxExt.y);
    result.FHotSpot := Point(epadHotSpotX, epadHotSpotY);
    result.FColor := clBlack;
    result.FWidth := 2;
    //chop our array to just real points
    SetLength(FPts, FNumPts);
    result.FPts := Copy(FPts, 0, length(FPts));
  except
    FreeAndNil(result);
  end;
end;

function TEPadInterface.SignPtsBounds: TRect;
var
  n: Integer;
begin
  result := Rect(10000,10000, -10000,-10000);
  for n := 0 to FNumPts-1 do
    begin
      if FPts[n].X > result.right then result.right := FPts[n].X;
      if FPts[n].X < result.left then result.left := FPts[n].X;
      if FPts[n].Y > result.bottom then result.bottom := FPts[n].Y;
      if FPts[n].Y < result.top then result.top := FPts[n].Y;
    end;
end;

procedure TEPadInterface.MsgWTProximity(var Message: TMessage);
begin
//toggle pen up and pen down conditions
  FPenContactChanged := True;
  FPenInContact := not FPenInContact;
  if FPenInContact then
    FPts[FNumPts].Down := FPenInContact
  else
    FPts[FNumPts-1].Down := FPenInContact;    //went up on prev pt

  SignerNameChange(nil);                      //can we enable sign it??
end;

procedure TEPadInterface.MsgWTPacket(var Message: TMessage);
begin
  if Message.Msg = WT_Packet then
    begin
      ProcessPacketInfo(Message.WParam, message.LParam);
    end;
end;


procedure TEPadInterface.ProcessPacketInfo(wSerial, hContext: LongInt);
var
  PenPkt: PacketRec;
  newPt: TPoint;
begin
  WTPacket(HCTX(hContext), wSerial, PenPkt);

  with SignatureArea.Canvas do
  begin
    Pen.Color := clBlack;
    Pen.width := 2;
    FPts[FNumPts].Down :=  FPenInContact;
    if FPenContactChanged then
      if FPenInContact then
        begin
          FPrevPt.x := penPkt.pkX-FCtxOrg.x;
          FPrevPt.y := FCtxExt.y - (penPkt.pkY-FCtxOrg.y);

          FPts[FNumPts].X := penPkt.pkX-FCtxOrg.x;
          FPts[FNumPts].Y := FCtxExt.y - (penPkt.pkY-FCtxOrg.y);
          Inc(FNumPts);
          FPenContactChanged := False;
        end
      else
    else
      if FPenInContact then
        begin
          newPt.x := penPkt.PkX-FCtxOrg.x;
          newPt.y := FCtxExt.y - (penPkt.pkY-FCtxOrg.y);
          MoveTo(MulDiv(FPrevPt.x,FSgnArea.x,FCtxExt.x), MulDiv(FPrevPt.y,FSgnArea.y,FCtxExt.y));
          LineTo(MulDiv(newPt.x,FSgnArea.x,FCtxExt.x), MulDiv(newPt.y,FSgnArea.y,FCtxExt.y));
          FPrevPt.x := newPt.x;
          FPrevPt.y := newPt.y;

          FPts[FNumPts].X := penPkt.pkX-FCtxOrg.x;
          FPts[FNumPts].Y := FCtxExt.y - (penPkt.pkY-FCtxOrg.y);
          Inc(FNumPts);
          btnClear.enabled := True;     //have pts to clear
        end;

    if FnumPts > MaxPts then FNumPts := MaxPts;
(*
    textout(10,5, 'nPts='+IntToStr(FNumPts));
    textout(10,20, 'X='+IntToStr(FPrevPt.x)); textout(100, 20, 'Y='+IntToStr(FPrevPt.y));
    textout(10,35, 'X='+IntToStr(MulDiv(FPrevPt.x,FSgnArea.x,FCtxExt.x))); textout(100,35,'Y='+IntToStr(MulDiv(FPrevPt.y,FSgnArea.y,FCtxExt.y)));

    textout(10,10, 'CTX='+IntToStr(penPkt.pkContext)); textout(100, 10, 'ST='+IntToStr(penPkt.pkStatus));
    textout(10,40, 'TIM='+IntToStr(penPkt.pkTime)); textout(100, 40, 'Chg='+IntToStr(penPkt.pkChanged));
    textout(10,60, 'SerNm='+IntToStr(penPkt.pkSerialNumber)); textout(100, 60, 'CUR='+IntToStr(penPkt.pkCursor));
    textout(10,80,'BTN='+IntToStr(penPkt.pkButtons));
    textout(10,100, 'X='+IntToStr(penPkt.pkX)); textout(100, 100, 'Y='+IntToStr(penPkt.PkY));  textout(190, 100, 'Z='+IntToStr(penPkt.PkZ));
    textout(10,120, 'NPRS='+IntToStr(penPkt.pkNormalPressure));
*)
  end;
end;


procedure TEPadInterface.SignatureAreaPaint(Sender: TObject);
var
  area: TRect;
begin
  Area := Rect(0,0,signatureArea.width, signatureArea.height);
  With SignatureArea.Canvas do
    begin
      FillRect(area);
      Brush.color := clBlack;
      FrameRect(area);
      Brush.color := clWhite;
      Pen.color := clLtGray;
      Pen.width := 2;
      MoveTo(MulDiv(30,345,981), MulDiv(486-140,155,486));
      LineTo(MulDiv(950,345,981), MulDiv(486-140,155,486));

      MoveTo(MulDiv(68,345,981), MulDiv(486-230,155,486));
      LineTo(MulDiv(109,345,981), MulDiv(486-116,155,486));
      MoveTo(MulDiv(26,345,981), MulDiv(486-97,155,486));
      LineTo(MulDiv(138,345,981), MulDiv(486-230,155,486));
    end;
end;

procedure TEPadInterface.SignerNameChange(Sender: TObject);
begin
  if (length(SignerName.Text) > 0) and (FNumPts > 20) then
    begin
      btnSignIt.enabled := True;
      if FNumPts = 0 then
        FocusControl(btnSignIt);
    end
  else
    btnSignIt.enabled := False;
end;

procedure TEPadInterface.btnClearClick(Sender: TObject);
begin
  FPts := nil;                   //delete previous pts
  FNumPts := 0;
  SetLength(FPts, maxPts);       //setup for new signature
  SignatureAreaPaint(Sender);
  SignerNameChange(Sender);
end;

procedure TEPadInterface.Button1Click(Sender: TObject);
var
  n: Integer;
begin
  SignatureAreaPaint(Sender);
  With SignatureArea.Canvas do
    begin
      Pen.Color := clBlack;
      Pen.width := 2;
      MoveTo(MulDiv(FPts[1].X,FSgnArea.x,FCtxExt.x), MulDiv(FPts[1].Y,FSgnArea.y,FCtxExt.y));
      for n := 1 to FNumPts-1 do
        begin
          if FPts[n-1].Down then
            LineTo(MulDiv(FPts[n].X,FSgnArea.x,FCtxExt.x), MulDiv(FPts[n].Y,FSgnArea.y,FCtxExt.y))
          else
            MoveTo(MulDiv(FPts[n].X,FSgnArea.x,FCtxExt.x), MulDiv(FPts[n].Y,FSgnArea.y,FCtxExt.y));
        end;
    end;
end;

function TEPadInterface.GetPrintedName: string;
begin
  result := SignerName.Text;
end;

procedure TEPadInterface.SetPrintedName(const Value: string);
begin
  SignerName.Text := Value;
end;



{ TEPadSignature }

procedure TEPadSignature.WriteSignatureData(stream: TStream);
var
  strBuff: Str63;
  amt,arrayLen: LongInt;
begin
  strBuff := FName;
  Stream.WriteBuffer(strBuff, Length(strBuff) + 1);  //write the signature name

  strBuff := FReason;
  Stream.WriteBuffer(strBuff, Length(strBuff) + 1);  //write the signature reason

  amt := SizeOf(Boolean);
	stream.WriteBuffer(FUsePSW, amt);

  amt := SizeOf(LongInt);
  stream.WriteBuffer(FCodedPSW, amt);

  amt := SizeOf(TPoint);
  stream.WriteBuffer(FHotSpot, amt);

  amt := SizeOf(TRect);
  stream.WriteBuffer(FBounds, amt);

  amt := SizeOf(TPoint);
  stream.WriteBuffer(FScale, amt);

   amt := SizeOf(TColor);
  stream.WriteBuffer(FColor, amt);

  amt := SizeOf(Integer);
  stream.WriteBuffer(FWidth, amt);

  ArrayLen := length(FPts);
  amt := SizeOf(Integer);
  stream.WriteBuffer(ArrayLen, amt);

  amt := ArrayLen * SizeOf(SgnPt);
  stream.WriteBuffer(Pointer(FPts)^, Amt);
end;

procedure TEPadSignature.ReadSignatureData(stream: TStream);
var
  strBuff: Str63;
  amt,arrayLen: LongInt;
begin
  Stream.Read(strBuff[0], 1);                     //read the length of name
	Stream.Read(strBuff[1], Integer(strBuff[0]));   //read the chacters of name
  FName := strBuff;

  Stream.Read(strBuff[0], 1);                     //read the length of reason
	Stream.Read(strBuff[1], Integer(strBuff[0]));   //read the chacters of reason
  FReason := strBuff;

  amt := SizeOf(Boolean);
	stream.Read(FUsePSW, amt);

  amt := SizeOf(LongInt);
  stream.Read(FCodedPSW, amt);

  amt := SizeOf(TPoint);
  stream.Read(FHotSpot, amt);

  amt := SizeOf(TRect);
  stream.Read(FBounds, amt);

  amt := SizeOf(TPoint);
  stream.Read(FScale, amt);

   amt := SizeOf(TColor);
  stream.Read(FColor, amt);

  amt := SizeOf(Integer);
  stream.Read(FWidth, amt);

  amt := SizeOf(Integer);
  stream.Read(ArrayLen, amt);

  SetLength(FPts, ArrayLen);
  amt := ArrayLen * SizeOf(SgnPt);
//  stream.ReadBuffer(FPts, Amt);
  stream.ReadBuffer(Pointer(FPts)^, Amt);
end;

procedure TEPadInterface.AdjustDPISettings;
begin
    self.Width := btnSignIt.Left + btnSignIt.Width + 50;
    self.height := btnSignIt.Top + btnSignIt.Height + 100;
    self.Constraints.MinWidth := self.Width;
    self.Constraints.MinHeight := self.Height;
end;

procedure TEPadInterface.FormShow(Sender: TObject);
begin
    AdjustDPISettings;
end;

end.
