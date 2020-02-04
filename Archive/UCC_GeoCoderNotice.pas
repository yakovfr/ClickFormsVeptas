unit UCC_GeoCoderNotice;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2014 by Bradford Technologies, Inc.}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, UForms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TOutlierNotice = class(TAdvancedForm)
    lblSalesCount: TLabel;
    WarningIcon: TImage;
    lblListingsCount: TLabel;
    cbxRemoveSales: TCheckBox;
    cbxRemoveListings: TCheckBox;
    btnRemove: TButton;
    btnNoRemoval: TButton;
    procedure cbxRemoveOutliersClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FSaleOL: Integer;
    FListingOL: Integer;
    FRemoveSales: Boolean;
    FRemoveListings: Boolean;
    procedure SetSaleOutliers(const Value: Integer);
    procedure SetListingOutlier(const Value: Integer);
    function GetRemoveListings: Boolean;
    function GetRemoveSales: Boolean;
    procedure SetRemoveButtonState;
    procedure AdjustDPISettings;
  public
    property SaleOutliers: Integer read FSaleOL write SetSaleOutliers;
    property ListingOutlier: Integer read FListingOL write SetListingOutlier;
    property RemoveListings: Boolean read GetRemoveListings write FRemoveListings;
    property RemoveSales: Boolean read GetRemoveSales write FRemoveSales;
  end;

  function OK2RemoveOutliers(SaleOL, listingOL: Integer; var removeSales, removeListings: Boolean): Boolean;
  function Ok2RemoveOutliersForSales(SaleOL: Integer): Boolean;       //github 500
  function Ok2RemoveOutliersForListings(ListingOL: Integer): Boolean; //github 500

implementation

{$R *.dfm}


function OK2RemoveOutliers(SaleOL, ListingOL: Integer; var removeSales, removeListings: Boolean): Boolean;
var
  outlier: TOutlierNotice;
begin
  outlier := TOutlierNotice.Create(nil);
  try
    result := False;
    outlier.SaleOutliers := SaleOL;
    outlier.ListingOutlier := ListingOL;
    outlier.btnRemove.Enabled := False;
    if outlier.ShowModal = mrOK then
      begin
        removeSales := outlier.RemoveSales;
        removeListings := outlier.RemoveListings;
        result := True;
      end;
  finally
    outlier.Free;
  end;
end;


function Ok2RemoveOutliersForSales(SaleOL: Integer): Boolean;
var
  outlier: TOutlierNotice;
begin
  outlier := TOutlierNotice.Create(nil);
  try
    result := False;
    outlier.lblListingsCount.Visible := False;
    outlier.cbxRemoveListings.Visible := False;
    outlier.SaleOutliers := SaleOL;
    outlier.btnRemove.Enabled := False;
    if outlier.ShowModal = mrOK then
      begin
        result := outlier.RemoveSales;
      end;
  finally
    outlier.Free;
  end;
end;

function Ok2RemoveOutliersForSale(SaleOL: Integer): Boolean;
var
  outlier: TOutlierNotice;
begin
  outlier := TOutlierNotice.Create(nil);
  try
    result := False;
    outlier.lblListingsCount.Visible := False;
    outlier.cbxRemoveListings.Visible := False;
    outlier.SaleOutliers := SaleOL;
    outlier.btnRemove.Enabled := False;
    if outlier.ShowModal = mrOK then
      begin
        result := outlier.RemoveSales;
      end;
  finally
    outlier.Free;
  end;
end;

function Ok2RemoveOutliersForListings(ListingOL: Integer): Boolean;
var
  outlier: TOutlierNotice;
begin
  outlier := TOutlierNotice.Create(nil);
  try
    result := False;
    outlier.lblSalesCount.Visible := False;
    outlier.cbxRemoveSales.Visible := False;
    outlier.lblListingsCount.top := outlier.lblSalesCount.top;
    outlier.cbxRemoveListings.top := outlier.cbxRemoveSales.top;
    outlier.ListingOutlier := ListingOL;
    outlier.btnRemove.Enabled := False;
    if outlier.ShowModal = mrOK then
      begin
        result := outlier.RemoveListings;
      end;
  finally
    outlier.Free;
  end;
end;

{ TOutlierNotice }

function TOutlierNotice.GetRemoveListings: Boolean;
begin
  Result := cbxRemoveListings.checked;
end;

function TOutlierNotice.GetRemoveSales: Boolean;
begin
  Result := cbxRemoveSales.checked;
end;

procedure TOutlierNotice.SetListingOutlier(const Value: Integer);
var
  strListOL: String;
begin
  FListingOL := Value;
  strListOL := IntToStr(Value);
  if FListingOL > 0 then
    begin
      lblListingsCount.caption := strListOL + ' Listings are located outside the defined market area.';
      cbxRemoveListings.caption := 'Remove the ' + strListOL + ' Listing(s) outside the market from further consideration.';
    end
  else
    begin
      lblListingsCount.caption := 'There are no listings that are outside the market area.';
      cbxRemoveListings.caption := 'Remove listings outside market.';
      cbxRemoveListings.enabled := False;
    end;
end;

procedure TOutlierNotice.SetSaleOutliers(const Value: Integer);
var
  strSaleOL: String;
begin
  FSaleOL := Value;
  strSaleOL := IntToStr(Value);
  if FSaleOL > 0 then
    begin
      lblSalesCount.caption := strSaleOL + ' Sales are located outside the defined market area.';
      cbxRemoveSales.caption := 'Remove the ' + strSaleOL + ' Sale(s) outside the market from further consideration.';
    end
  else
    begin
      lblSalesCount.caption := 'There are no sales that are outside the market area.';
      cbxRemoveSales.caption := 'Remove sales outside market.';
      cbxRemoveSales.enabled := False;
    end;
end;

procedure TOutlierNotice.SetRemoveButtonState;
begin
  btnRemove.Enabled := (FSaleOL > 0) or (FListingOL > 0);
end;

procedure TOutlierNotice.cbxRemoveOutliersClick(Sender: TObject);
begin
  btnRemove.Enabled := cbxRemoveSales.Checked or cbxRemoveListings.checked;
end;
procedure TOutlierNotice.AdjustDPISettings;
begin
   btnRemove.Left := lblSalesCount.left;
   btnNoRemoval.left := btnRemove.left + btnRemove.Width + 40;

   cbxRemoveListings.left := cbxRemoveSales.left;

   self.Width := cbxRemoveSales.Left + cbxRemoveSales.width + 20;
   self.height :=  btnRemove.Top + btnRemove.Height + 80;
   self.Constraints.MinWidth := self.Width;
   self.Constraints.MinHeight := self.height;
end;

procedure TOutlierNotice.FormShow(Sender: TObject);
begin
  AdjustDPISettings;
end;

end.
