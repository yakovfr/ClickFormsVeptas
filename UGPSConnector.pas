unit UGPSConnector;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ZylGPSReceiver,
  UContainer, UForms;

type
  TGPSConnection = class(TAdvancedForm)
    Panel1: TPanel;
    edtLatDeg: TEdit;
    edtLatMin: TEdit;
    edtLatSec: TEdit;
    edtLonDeg: TEdit;
    edtLonMin: TEdit;
    edtLonSec: TEdit;
    edtLatRad: TEdit;
    edtLonRad: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    btnTrack: TButton;
    GPSReceiver: TZylGPSReceiver;
    Label3: TLabel;
    lblSatellites: TLabel;
    procedure GPSReceiverReceive(Sender: TObject);
    procedure btnTrackClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
  end;


var
  GPSConnection: TGPSConnection;

implementation

{$R *.dfm}

Uses
  UGlobals, UUtil1;



procedure TGPSConnection.GPSReceiverReceive(Sender: TObject);
var
  LatFactor, LonFactor: Integer;
begin
  LatFactor := 1;
  LonFactor := 1;
  if GPSReceiver.GetLatitudeDirection = cpSouth then
    LatFactor := - LatFactor;
  if GPSReceiver.GetLongitudeDirection = cpWest then
    LonFactor := - LonFactor;

  edtLatDeg.text := IntToStr(LatFactor * GPSReceiver.GetLatitudeDegree);
  edtLatMin.text := IntToStr(GPSReceiver.GetLatitudeMinute);
  edtLatSec.text := FloatToStr(GPSReceiver.GetLatitudeSecond);
//  edtLatRad.Text := FLoatToStr(LatFactor * GPSReceiver.GetLatitudeAsDecimalDegrees);
  edtLatRad.text := FloatToStr(LatFactor * GPSReceiver.GetlatitudeAsRadians);

  edtLonDeg.text := IntToStr(LonFactor * GPSReceiver.GetLongitudeDegree);
  edtLonMin.text := IntToStr(GPSReceiver.GetLongitudeMinute);
  edtLonSec.text := FloatToStr(GPSReceiver.GetLongitudeSecond);
//  edtLonRad.text := FloatToStr(LonFactor * GPSReceiver.GetLongitudeAsDecimalDegrees);
  edtLonRad.text := FloatToStr(LonFactor * GPSReceiver.GetLongitudeAsRadians);

  lblSatellites.Caption := IntToStr(GPSReceiver.GetSatelliteCount);
end;

procedure TGPSConnection.btnTrackClick(Sender: TObject);
(*
var
  CPort: TCommPort;
  SatCount, rate: INteger;
  str: String;
  BRate: TBaudRate;
*)
begin
(*
   GPSReceiver.Open;
   GPSReceiver.Port := spCOM2;
   BRate := GPSReceiver.BaudRate;
   CPort := GPSReceiver.IsConnected;
   SatCount := GPSReceiver.GetSatelliteCount;
*)
end;

procedure TGPSConnection.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  GPSReceiver.Close;

  GPSConnection := nil;
  
  Self.Free;
end;

procedure TGPSConnection.FormShow(Sender: TObject);
begin
  GPSReceiver.Open;
  GPSReceiver.Port := spCOM2;
end;

constructor TGPSConnection.Create(AOwner: TComponent);
begin
  inherited;
  SettingsName := CFormSettings_GPSConnection
end;

end.
