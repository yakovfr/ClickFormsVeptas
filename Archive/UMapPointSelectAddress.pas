
{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2005 by Bradford Technologies, Inc. }

unit UMapPointSelectAddress;

interface

uses
   Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
   Dialogs, StdCtrls, ExtCtrls,
   locationservice, UForms;

type
   TMapPointSelectAddress = class(TAdvancedForm)
       NotebookAddresses : TNotebook;
       ListBoxAddresses : TListBox;
       ButtonUseSelected : TButton;
       LabelSelectListTitle : TLabel;
       ButtonFind : TButton;
       EditStreet : TEdit;
       EditCity : TEdit;
       EditState : TEdit;
       EditZip : TEdit;
       LabelStreet : TLabel;
       Label2 : TLabel;
       LabelSelectMsg : TLabel;
       Label1 : TLabel;
       Label3 : TLabel;
       Label4 : TLabel;
       ListBoxFindAddresses : TListBox;
       ButtonFindSelected : TButton;
       ButtonFindAnother : TButton;
       UnkownAddress: TLabel;
       procedure ListBoxAddressesDblClick(Sender : TObject);
       procedure FormShow(Sender : TObject);
       procedure ButtonFindAnotherClick(Sender : TObject);
       procedure ButtonUseSelectedClick(Sender : TObject);
       procedure ButtonFindClick(Sender : TObject);
       procedure ButtonFindSelectedClick(Sender : TObject);
   private
       FMultipleFindResults : FindResults;
       FLatitude : Double;
       FLongitude : Double;
       FCustID : Integer;
       FFindResults : FindResults;
   public
       property MultipleFindResults : FindResults read FMultipleFindResults write FMultipleFindResults;
       property Latitude : Double read FLatitude write FLatitude;
       property Longitude : Double read FLongitude write FLongitude;
       property CustID : Integer read FCustID write FCustID;
       procedure SetSelectedAddress;
   end;

var
   MapPointSelectAddress : TMapPointSelectAddress;

implementation

uses
   UStatus, UMapPointClientUtil;

{$R *.dfm}

procedure TMapPointSelectAddress.SetSelectedAddress;
begin
   if ListBoxAddresses.Items.Count > 1 then
   begin
       Latitude := MultipleFindResults.Results[ListBoxAddresses.ItemIndex].FoundLocation.LatLong.Latitude;
       Longitude := MultipleFindResults.Results[ListBoxAddresses.ItemIndex].FoundLocation.LatLong.Longitude;
   end;
end;

procedure TMapPointSelectAddress.ListBoxAddressesDblClick(Sender : TObject);
begin
   SetSelectedAddress;
   ModalResult := mrOk;
end;

procedure TMapPointSelectAddress.FormShow(Sender : TObject);
begin
   NotebookAddresses.ActivePage := 'SelectPage';
   ListBoxAddresses.ItemIndex := 0;
end;

procedure TMapPointSelectAddress.ButtonFindAnotherClick(Sender : TObject);
begin
   NotebookAddresses.ActivePage := 'FindPage';
end;

procedure TMapPointSelectAddress.ButtonUseSelectedClick(Sender : TObject);
begin
   SetSelectedAddress;
   ModalResult := mrOk;
end;

procedure TMapPointSelectAddress.ButtonFindClick(Sender : TObject);
var
   sMsgs, sAddress : WideString;
   i : integer;
begin
   ListBoxFindAddresses.Items.Clear;
   if (Length(EditStreet.Text) > 0) and (Length(EditCity.Text) > 0) and (Length(EditState.Text) > 0) then
   begin
       sAddress := TRIM(EditStreet.Text + ',' + EditCity.Text + ',' + EditState.Text + ' ' + EditZip.Text);

       GetGeoCodeEx(sAddress, FCustId, FFindResults, sMsgs);
       if sMsgs = 'Success' then
       begin
           for i := 0 to Length(FFindResults.Results) - 1 do
           begin
               ListBoxFindAddresses.Items.Add(FFindResults.Results[i].FoundLocation.Entity.DisplayName);
           end;
           ListBoxFindAddresses.ItemIndex := 0;
       end
       else
       begin
           ShowNotice('There was an error connecting to the Location Map Server.');
       end;
   end;
end;

procedure TMapPointSelectAddress.ButtonFindSelectedClick(Sender : TObject);
begin
   if ListBoxFindAddresses.Items.Count > 1 then
   begin
       Latitude := FFindResults.Results[ListBoxFindAddresses.ItemIndex].FoundLocation.LatLong.Latitude;
       Longitude := FFindResults.Results[ListBoxFindAddresses.ItemIndex].FoundLocation.LatLong.Longitude;
       ModalResult := mrOk;
   end
   else
       ModalResult := mrCancel;
end;

end.

