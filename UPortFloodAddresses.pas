unit UPortFloodAddresses;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, UForms;

type
  TAddressSelector = class(TAdvancedForm)
    AddressList: TListBox;
    Panel1: TPanel;
    btnSelect: TButton;
    btnCancel: TButton;
    LabelMsg: TLabel;
  private
    FListIndex: Integer;
    procedure SetAddresses(const Value: TStringList);
  public
    Property Addresses: TStringList write SetAddresses;
    property AddressIndex: Integer read FListIndex write FListIndex;
  end;

//utility functions for getting addresses
  function SelectFloodProperty(Addresses: TStringList): String;
  function SelectFloodPropertyIndex(Addresses: TStringList): Integer;

  
implementation

{$R *.dfm}



function SelectFloodProperty(Addresses: TStringList): String;
var
  Selector: TAddressSelector;
begin
  Selector := TAddressSelector.Create(nil);
  Selector.Addresses := Addresses;
  try
    result := '';
    Selector.ShowModal;
    if Selector.AddressList.ItemIndex > -1 then
      result := Selector.AddressList.Items[Selector.AddressList.ItemIndex];
  finally
    Selector.Free;
  end;
end;

function SelectFloodPropertyIndex(Addresses: TStringList): Integer;
var
  Selector: TAddressSelector;
begin
  Selector := TAddressSelector.Create(nil);
  Selector.Addresses := Addresses;
  try
    Selector.ShowModal;
    result := Selector.AddressList.ItemIndex;
  finally
    Selector.Free;
  end;
end;


{ TAddressSelector }

procedure TAddressSelector.SetAddresses(const Value: TStringList);
var
  i: Integer;
begin
  AddressList.Items.Clear;
  if assigned(Value) then
    for i := 0 to Value.Count - 1 do
      AddressList.Items.Add(value[i]);
end;

//handle double click
(*
procedure TFloodZonePort.ListBoxAddressesDblClick(Sender: TObject);
begin
  btnLocateClick(Sender);
end;
*)

end.
