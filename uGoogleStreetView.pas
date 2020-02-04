unit uGoogleStreetView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, xmldom, XMLIntf, ActiveX,
  OleCtrls, SHDocVw,
  //uGAgisOnlineMap, cGAgisBingMap, uGAgisCommon,
 // uGAgisBingCommon, cGAgisBingGeo,
 //uGAgisBingOverlays, uGAgisOverlays, uGAgisOnlineOverlays, uGAgisCalculations,
  ExtCtrls, msxmldom, XMLDoc, IdBaseComponent, IdComponent, uStatus,
  IdTCPConnection, IdTCPClient, IdHTTP, cGAgisBingGeo;
  // cGAgisBingGeo, OleCtrls, SHDocVw;

type
  TGoogleStreetView = class(TForm)
    BingGeoCoder: TGAgisBingGeo;
    Panel5: TPanel;
    StaticText1: TLabel;
    StaticText2: TLabel;
    edtStreet: TEdit;
    btnGetStreetView: TButton;
    XMLDocument1: TXMLDocument;
    Image1: TImage;
    WebBrowser1: TWebBrowser;
    IdHTTP1: TIdHTTP;
    procedure btnGetStreetViewClick(Sender: TObject);
    procedure wbNavigateComplete2(Sender: TObject; const pDisp: IDispatch;
      var URL: OleVariant);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure WebBrowser1NavigateComplete2(Sender: TObject;
      const pDisp: IDispatch; var URL: OleVariant);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FGoogleBitMap: TBitMap;
    FFullAddr: String;
    FModalResult: TModalResult;
    procedure SaveGoogleStreetView(const wb: TWebBrowser);
    procedure GetGoogleStreetView(FullAddr:String);
  end;

var
  GoogleStreetView: TGoogleStreetView;

implementation

{$R *.dfm}

procedure TGoogleStreetView.GetGoogleStreetView(FullAddr:String);
var
  XResult,XGeometry,XLocation: IXMLNode;
  s,resp,lat,lng : string;
  address : String;
begin
  try
    if FullAddr <> ',' then
      begin           // bradford google street view API Id
        FullAddr   := StringReplace(StringReplace(Trim(FullAddr), #13, ' ', [rfReplaceAll]), #10, ' ', [rfReplaceAll]);
        FullAddr   := StringReplace(FullAddr,' ','%20',[rfReplaceAll]);
        s := 'http://maps.google.com/maps/api/geocode/xml?address='+FullAddr+'%s&sensor=false&key{AIzaSyBJ935fgjrSj1RYlj0I_vAcykWsXzey_HE}'; // geo_code address
        resp := IdHTTP1.Get(s);
        if Length(resp) > 0 then
          begin
           XMLDocument1.LoadFromXML(resp);
           XResult := XMLDocument1.DocumentElement.ChildNodes.FindNode('result');
           if XResult <> nil then
             XGeometry    := XResult.ChildNodes.FindNode('geometry');
           if XGeometry <> nil then
             XLocation    := XGeometry.ChildNodes.FindNode('location');
           if XLocation <> nil then
              begin
                lat := XLocation.ChildNodes[0].Text;
                lng := XLocation.ChildNodes[1].Text;
              end;
          end;                                                                                                                        // bradford google street view API Id
        WebBrowser1.Navigate('http://maps.googleapis.com/maps/api/streetview?size=405x210&location='+lat+',%20'+lng+'&sensor=false&key{AIzaSyBJ935fgjrSj1RYlj0I_vAcykWsXzey_HE}');
      end
    else
      WebBrowser1.Navigate('about:blank');
  except
    ShowAlert(atWarnAlert, 'There was a problem getting the Google Street View image.');
  end;
end;


procedure TGoogleStreetView.SaveGoogleStreetView(const wb: TWebBrowser);
var
  viewObject : IViewObject;
  r, destR, srcR : TRect;
  bitmap1: TBitmap;
begin
  if assigned(wb.Document) then
    begin
      wb.Document.QueryInterface(IViewObject, viewObject);
      if Assigned(viewObject) then
        try
          bitmap1 := TBitmap.Create;
          try
            //copy the screen
            r := Rect(0, 0, wb.Width, wb.Height);
            bitmap1.Height := wb.Height;
            bitmap1.Width := wb.Width;
            viewObject.Draw(DVASPECT_CONTENT, 1, nil, nil, Application.Handle, bitmap1.Canvas.Handle, @r, nil, nil, 0);

            //crop the screen to remove white border and scroll bar
            //NOTE: this cropping is associated with "streetview?size=320x215&"
            FGoogleBitMap.Height := wb.Height;
            FGoogleBitMap.Width := wb.Width;
            destR := Rect(0, 0, wb.Width, wb.Height);
            srcR := Rect(0, 0, wb.Width, wb.Height);
            FGoogleBitMap.Canvas.CopyRect(destR, bitmap1.Canvas, srcR);
            Image1.Picture.Bitmap.assign(FGoogleBitMap);

          finally
            bitmap1.Free;
          end;
        finally
          viewObject._Release;
        end;
    end;
end;


procedure TGoogleStreetView.btnGetStreetViewClick(Sender: TObject);
begin
  GetGoogleStreetView(edtStreet.text);
end;

procedure TGoogleStreetView.wbNavigateComplete2(Sender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
begin
  SaveGoogleStreetView(WebBrowser1);
end;

procedure TGoogleStreetView.FormCreate(Sender: TObject);
begin
  FGoogleBitMap := TBitMap.Create;
end;

procedure TGoogleStreetView.FormDestroy(Sender: TObject);
begin
  FGoogleBitmap.Free;
end;

procedure TGoogleStreetView.WebBrowser1NavigateComplete2(Sender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
begin
  SaveGoogleStreetView(WebBrowser1);
  FModalResult := mrOK;
  Close;
end;

procedure TGoogleStreetView.FormShow(Sender: TObject);
begin
  edtStreet.text := FFullAddr;
  btnGetStreetView.Click;
end;

end.
