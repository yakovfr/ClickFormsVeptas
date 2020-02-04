
{********************************************************************************}
{                                                                                }
{                                XML Data Binding                                }
{                                                                                }
{         Generated on: 10/7/2010 4:01:03 PM                                     }
{       Generated from: C:\Users\jwyatt\Documents\Nasoft\UClickFormsOIFXML.xsd   }
{   Settings stored in: C:\Users\jwyatt\Documents\Nasoft\UClickFormsOIFXML.xdb   }
{                                                                                }
{********************************************************************************}

unit UClickFormsOIFXML;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLClientOrderInformation = interface;
  IXMLServicesType = interface;
  IXMLServiceType = interface;

{ IXMLClientOrderInformation }

  IXMLClientOrderInformation = interface(IXMLNode)
    ['{BFDDA267-3C28-4ECA-B6B6-19E4C6BD5328}']
    { Property Accessors }
    function Get_ProviderID: SmallInt;
    function Get_OrderID: WideString;
    function Get_UserName: WideString;
    function Get_Services: IXMLServicesType;
    function Get_TechSupport: WideString;
    function Get_VendorTechSupport: Boolean;
    procedure Set_ProviderID(Value: SmallInt);
    procedure Set_OrderID(Value: WideString);
    procedure Set_UserName(Value: WideString);
    procedure Set_TechSupport(Value: WideString);
    procedure Set_VendorTechSupport(Value: Boolean);
    { Methods & Properties }
    property ProviderID: SmallInt read Get_ProviderID write Set_ProviderID;
    property OrderID: WideString read Get_OrderID write Set_OrderID;
    property UserName: WideString read Get_UserName write Set_UserName;
    property Services: IXMLServicesType read Get_Services;
    property TechSupport: WideString read Get_TechSupport write Set_TechSupport;
    property VendorTechSupport: Boolean read Get_VendorTechSupport write Set_VendorTechSupport;
  end;

{ IXMLServicesType }

  IXMLServicesType = interface(IXMLNodeCollection)
    ['{E61BD062-A461-43B7-8718-1607C2EC7905}']
    { Property Accessors }
    function Get_Service(Index: Integer): IXMLServiceType;
    { Methods & Properties }
    function Add: IXMLServiceType;
    function Insert(const Index: Integer): IXMLServiceType;
    property Service[Index: Integer]: IXMLServiceType read Get_Service; default;
  end;

{ IXMLServiceType }

  IXMLServiceType = interface(IXMLNode)
    ['{0D031B7E-9361-46B1-B83A-A93A269503A6}']
    { Property Accessors }
    function Get_SvcName: WideString;
    function Get_Name: WideString;
    function Get_Url: WideString;
    function Get_EndPoint: WideString;
    procedure Set_SvcName(Value: WideString);
    procedure Set_Name(Value: WideString);
    procedure Set_Url(Value: WideString);
    procedure Set_EndPoint(Value: WideString);
    { Methods & Properties }
    property SvcName: WideString read Get_SvcName write Set_SvcName;
    property Name: WideString read Get_Name write Set_Name;
    property Url: WideString read Get_Url write Set_Url;
    property EndPoint: WideString read Get_EndPoint write Set_EndPoint;
  end;

{ Forward Decls }

  TXMLClientOrderInformation = class;
  TXMLServicesType = class;
  TXMLServiceType = class;

{ TXMLClientOrderInformation }

  TXMLClientOrderInformation = class(TXMLNode, IXMLClientOrderInformation)
  protected
    { IXMLClientOrderInformation }
    function Get_ProviderID: SmallInt;
    function Get_OrderID: WideString;
    function Get_UserName: WideString;
    function Get_Services: IXMLServicesType;
    function Get_TechSupport: WideString;
    function Get_VendorTechSupport: Boolean;
    procedure Set_ProviderID(Value: SmallInt);
    procedure Set_OrderID(Value: WideString);
    procedure Set_UserName(Value: WideString);
    procedure Set_TechSupport(Value: WideString);
    procedure Set_VendorTechSupport(Value: Boolean);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLServicesType }

  TXMLServicesType = class(TXMLNodeCollection, IXMLServicesType)
  protected
    { IXMLServicesType }
    function Get_Service(Index: Integer): IXMLServiceType;
    function Add: IXMLServiceType;
    function Insert(const Index: Integer): IXMLServiceType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLServiceType }

  TXMLServiceType = class(TXMLNode, IXMLServiceType)
  protected
    { IXMLServiceType }
    function Get_SvcName: WideString;
    function Get_Name: WideString;
    function Get_Url: WideString;
    function Get_EndPoint: WideString;
    procedure Set_SvcName(Value: WideString);
    procedure Set_Name(Value: WideString);
    procedure Set_Url(Value: WideString);
    procedure Set_EndPoint(Value: WideString);
  end;

{ Global Functions }

function GetClientOrderInformation(Doc: IXMLDocument): IXMLClientOrderInformation;
function LoadClientOrderInformation(const FileName: WideString): IXMLClientOrderInformation;
function NewClientOrderInformation: IXMLClientOrderInformation;

const
  TargetNamespace = '';

implementation

{ Global Functions }

function GetClientOrderInformation(Doc: IXMLDocument): IXMLClientOrderInformation;
begin
  Result := Doc.GetDocBinding('ClientOrderInformation', TXMLClientOrderInformation, TargetNamespace) as IXMLClientOrderInformation;
end;

function LoadClientOrderInformation(const FileName: WideString): IXMLClientOrderInformation;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('ClientOrderInformation', TXMLClientOrderInformation, TargetNamespace) as IXMLClientOrderInformation;
end;

function NewClientOrderInformation: IXMLClientOrderInformation;
begin
  Result := NewXMLDocument.GetDocBinding('ClientOrderInformation', TXMLClientOrderInformation, TargetNamespace) as IXMLClientOrderInformation;
end;

{ TXMLClientOrderInformation }

procedure TXMLClientOrderInformation.AfterConstruction;
begin
  RegisterChildNode('Services', TXMLServicesType);
  inherited;
end;

function TXMLClientOrderInformation.Get_ProviderID: SmallInt;
begin
  Result := ChildNodes['ProviderID'].NodeValue;
end;

procedure TXMLClientOrderInformation.Set_ProviderID(Value: SmallInt);
begin
  ChildNodes['ProviderID'].NodeValue := Value;
end;

function TXMLClientOrderInformation.Get_OrderID: WideString;
begin
  Result := ChildNodes['OrderID'].Text;
end;

procedure TXMLClientOrderInformation.Set_OrderID(Value: WideString);
begin
  ChildNodes['OrderID'].NodeValue := Value;
end;

function TXMLClientOrderInformation.Get_UserName: WideString;
begin
  Result := ChildNodes['UserName'].Text;
end;

procedure TXMLClientOrderInformation.Set_UserName(Value: WideString);
begin
  ChildNodes['UserName'].NodeValue := Value;
end;

function TXMLClientOrderInformation.Get_Services: IXMLServicesType;
begin
  Result := ChildNodes['Services'] as IXMLServicesType;
end;

function TXMLClientOrderInformation.Get_TechSupport: WideString;
begin
  Result := ChildNodes['TechSupport'].Text;
end;

procedure TXMLClientOrderInformation.Set_TechSupport(Value: WideString);
begin
  ChildNodes['TechSupport'].NodeValue := Value;
end;

function TXMLClientOrderInformation.Get_VendorTechSupport: Boolean;
begin
  Result := ChildNodes['VendorTechSupport'].NodeValue;
end;

procedure TXMLClientOrderInformation.Set_VendorTechSupport(Value: Boolean);
begin
  ChildNodes['VendorTechSupport'].NodeValue := Value;
end;

{ TXMLServicesType }

procedure TXMLServicesType.AfterConstruction;
begin
  RegisterChildNode('Service', TXMLServiceType);
  ItemTag := 'Service';
  ItemInterface := IXMLServiceType;
  inherited;
end;

function TXMLServicesType.Get_Service(Index: Integer): IXMLServiceType;
begin
  Result := List[Index] as IXMLServiceType;
end;

function TXMLServicesType.Add: IXMLServiceType;
begin
  Result := AddItem(-1) as IXMLServiceType;
end;

function TXMLServicesType.Insert(const Index: Integer): IXMLServiceType;
begin
  Result := AddItem(Index) as IXMLServiceType;
end;

{ TXMLServiceType }

function TXMLServiceType.Get_SvcName: WideString;
begin
  Result := AttributeNodes['name'].Text;
end;

procedure TXMLServiceType.Set_SvcName(Value: WideString);
begin
  SetAttribute('name', Value);
end;

function TXMLServiceType.Get_Name: WideString;
begin
  Result := ChildNodes['Name'].Text;
end;

procedure TXMLServiceType.Set_Name(Value: WideString);
begin
  ChildNodes['Name'].NodeValue := Value;
end;

function TXMLServiceType.Get_Url: WideString;
begin
  Result := ChildNodes['Url'].Text;
end;

procedure TXMLServiceType.Set_Url(Value: WideString);
begin
  ChildNodes['Url'].NodeValue := Value;
end;

function TXMLServiceType.Get_EndPoint: WideString;
begin
  Result := ChildNodes['EndPoint'].Text;
end;

procedure TXMLServiceType.Set_EndPoint(Value: WideString);
begin
  ChildNodes['EndPoint'].NodeValue := Value;
end;

end. 