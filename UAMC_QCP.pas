
{********************************************************************************************}
{                                                                                            }
{                              XML Data Binding                                              }
{                                                                                            }
{         Generated on: 10/22/2010 2:24:29 PM                                                }
{       Generated from: C:\Users\jwyatt\Documents\Client Integration Suite\ODP\CIS_QCP.xsd   }
{   Settings stored in: C:\Users\jwyatt\Documents\Client Integration Suite\ODP\CIS_QCP.xdb   }
{                                                                                            }
{********************************************************************************************}

unit UAMC_QCP;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLQualityControlPackage = interface;
  IXMLValidationMessagesType = interface;
  IXMLValidationMessageType = interface;
  IXMLText = interface;
  IXMLLocationsType = interface;
  IXMLLocationType = interface;

{ IXMLQualityControlPackage }

  IXMLQualityControlPackage = interface(IXMLNode)
    ['{182739EE-0CDD-4AC5-8C40-2C54F0788071}']
    { Property Accessors }
    function Get_Xsd: WideString;
    function Get_ValidationMessages: IXMLValidationMessagesType;
    procedure Set_Xsd(Value: WideString);
    { Methods & Properties }
    property Xsd: WideString read Get_Xsd write Set_Xsd;
    property ValidationMessages: IXMLValidationMessagesType read Get_ValidationMessages;
  end;

{ IXMLValidationMessagesType }

  IXMLValidationMessagesType = interface(IXMLNodeCollection)
    ['{4566B0F0-2B5A-4610-9E77-E828AD710FFE}']
    { Property Accessors }
    function Get_ValidationMessage(Index: Integer): IXMLValidationMessageType;
    { Methods & Properties }
    function Add: IXMLValidationMessageType;
    function Insert(const Index: Integer): IXMLValidationMessageType;
    property ValidationMessage[Index: Integer]: IXMLValidationMessageType read Get_ValidationMessage; default;
  end;

{ IXMLValidationMessageType }

  IXMLValidationMessageType = interface(IXMLNode)
    ['{2C5B9B87-F0C9-4D18-A4DE-28490AC6B7B6}']
    { Property Accessors }
    function Get_Type_: WideString;
    function Get_RuleID: WideString;
    function Get_Text: IXMLText;
    function Get_Locations: IXMLLocationsType;
    procedure Set_Type_(Value: WideString);
    procedure Set_RuleID(Value: WideString);
    { Methods & Properties }
    property Type_: WideString read Get_Type_ write Set_Type_;
    property RuleID: WideString read Get_RuleID write Set_RuleID;
    property Text: IXMLText read Get_Text;
    property Locations: IXMLLocationsType read Get_Locations;
  end;

{ IXMLText }

  IXMLText = interface(IXMLNode)
    ['{7235201D-1DDD-42D5-BA38-0E070C9CFB24}']
  end;

{ IXMLLocationsType }

  IXMLLocationsType = interface(IXMLNodeCollection)
    ['{8E5D8F1C-FD48-4B5B-B731-A548BBE9F696}']
    { Property Accessors }
    function Get_Location(Index: Integer): IXMLLocationType;
    { Methods & Properties }
    function Add: IXMLLocationType;
    function Insert(const Index: Integer): IXMLLocationType;
    property Location[Index: Integer]: IXMLLocationType read Get_Location; default;
  end;

{ IXMLLocationType }

  IXMLLocationType = interface(IXMLNode)
    ['{0509AAE8-9F13-4068-B5C5-E3B5CA26E794}']
    { Property Accessors }
    function Get_Locator: WideString;
    procedure Set_Locator(Value: WideString);
    { Methods & Properties }
    property Locator: WideString read Get_Locator write Set_Locator;
  end;

{ Forward Decls }

  TXMLQualityControlPackage = class;
  TXMLValidationMessagesType = class;
  TXMLValidationMessageType = class;
  TXMLText = class;
  TXMLLocationsType = class;
  TXMLLocationType = class;

{ TXMLQualityControlPackage }

  TXMLQualityControlPackage = class(TXMLNode, IXMLQualityControlPackage)
  protected
    { IXMLQualityControlPackage }
    function Get_Xsd: WideString;
    function Get_ValidationMessages: IXMLValidationMessagesType;
    procedure Set_Xsd(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLValidationMessagesType }

  TXMLValidationMessagesType = class(TXMLNodeCollection, IXMLValidationMessagesType)
  protected
    { IXMLValidationMessagesType }
    function Get_ValidationMessage(Index: Integer): IXMLValidationMessageType;
    function Add: IXMLValidationMessageType;
    function Insert(const Index: Integer): IXMLValidationMessageType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLValidationMessageType }

  TXMLValidationMessageType = class(TXMLNode, IXMLValidationMessageType)
  protected
    { IXMLValidationMessageType }
    function Get_Type_: WideString;
    function Get_RuleID: WideString;
    function Get_Text: IXMLText;
    function Get_Locations: IXMLLocationsType;
    procedure Set_Type_(Value: WideString);
    procedure Set_RuleID(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLText }

  TXMLText = class(TXMLNode, IXMLText)
  protected
    { IXMLText }
  end;

{ TXMLLocationsType }

  TXMLLocationsType = class(TXMLNodeCollection, IXMLLocationsType)
  protected
    { IXMLLocationsType }
    function Get_Location(Index: Integer): IXMLLocationType;
    function Add: IXMLLocationType;
    function Insert(const Index: Integer): IXMLLocationType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLLocationType }

  TXMLLocationType = class(TXMLNode, IXMLLocationType)
  protected
    { IXMLLocationType }
    function Get_Locator: WideString;
    procedure Set_Locator(Value: WideString);
  end;

{ Global Functions }

function GetQualityControlPackage(Doc: IXMLDocument): IXMLQualityControlPackage;
function LoadQualityControlPackage(const FileName: WideString): IXMLQualityControlPackage;
function NewQualityControlPackage: IXMLQualityControlPackage;

const
  TargetNamespace = '';

implementation

{ Global Functions }

function GetQualityControlPackage(Doc: IXMLDocument): IXMLQualityControlPackage;
begin
  Result := Doc.GetDocBinding('QualityControlPackage', TXMLQualityControlPackage, TargetNamespace) as IXMLQualityControlPackage;
end;

function LoadQualityControlPackage(const FileName: WideString): IXMLQualityControlPackage;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('QualityControlPackage', TXMLQualityControlPackage, TargetNamespace) as IXMLQualityControlPackage;
end;

function NewQualityControlPackage: IXMLQualityControlPackage;
begin
  Result := NewXMLDocument.GetDocBinding('QualityControlPackage', TXMLQualityControlPackage, TargetNamespace) as IXMLQualityControlPackage;
end;

{ TXMLQualityControlPackage }

procedure TXMLQualityControlPackage.AfterConstruction;
begin
  RegisterChildNode('ValidationMessages', TXMLValidationMessagesType);
  inherited;
end;

function TXMLQualityControlPackage.Get_Xsd: WideString;
begin
  Result := AttributeNodes['xmlns:xsd'].Text;
end;

procedure TXMLQualityControlPackage.Set_Xsd(Value: WideString);
begin
  SetAttribute('xmlns:xsd', Value);
end;

function TXMLQualityControlPackage.Get_ValidationMessages: IXMLValidationMessagesType;
begin
  Result := ChildNodes['ValidationMessages'] as IXMLValidationMessagesType;
end;

{ TXMLValidationMessagesType }

procedure TXMLValidationMessagesType.AfterConstruction;
begin
  RegisterChildNode('ValidationMessage', TXMLValidationMessageType);
  ItemTag := 'ValidationMessage';
  ItemInterface := IXMLValidationMessageType;
  inherited;
end;

function TXMLValidationMessagesType.Get_ValidationMessage(Index: Integer): IXMLValidationMessageType;
begin
  Result := List[Index] as IXMLValidationMessageType;
end;

function TXMLValidationMessagesType.Add: IXMLValidationMessageType;
begin
  Result := AddItem(-1) as IXMLValidationMessageType;
end;

function TXMLValidationMessagesType.Insert(const Index: Integer): IXMLValidationMessageType;
begin
  Result := AddItem(Index) as IXMLValidationMessageType;
end;

{ TXMLValidationMessageType }

procedure TXMLValidationMessageType.AfterConstruction;
begin
  RegisterChildNode('Text', TXMLText);
  RegisterChildNode('Locations', TXMLLocationsType);
  inherited;
end;

function TXMLValidationMessageType.Get_Type_: WideString;
begin
  Result := ChildNodes['Type'].Text;
end;

procedure TXMLValidationMessageType.Set_Type_(Value: WideString);
begin
  ChildNodes['Type'].NodeValue := Value;
end;

function TXMLValidationMessageType.Get_RuleID: WideString;
begin
  Result := ChildNodes['RuleID'].Text;
end;

procedure TXMLValidationMessageType.Set_RuleID(Value: WideString);
begin
  ChildNodes['RuleID'].NodeValue := Value;
end;

function TXMLValidationMessageType.Get_Text: IXMLText;
begin
  Result := ChildNodes['Text'] as IXMLText;
end;

function TXMLValidationMessageType.Get_Locations: IXMLLocationsType;
begin
  Result := ChildNodes['Locations'] as IXMLLocationsType;
end;

{ TXMLText }

{ TXMLLocationsType }

procedure TXMLLocationsType.AfterConstruction;
begin
  RegisterChildNode('Location', TXMLLocationType);
  ItemTag := 'Location';
  ItemInterface := IXMLLocationType;
  inherited;
end;

function TXMLLocationsType.Get_Location(Index: Integer): IXMLLocationType;
begin
  Result := List[Index] as IXMLLocationType;
end;

function TXMLLocationsType.Add: IXMLLocationType;
begin
  Result := AddItem(-1) as IXMLLocationType;
end;

function TXMLLocationsType.Insert(const Index: Integer): IXMLLocationType;
begin
  Result := AddItem(Index) as IXMLLocationType;
end;

{ TXMLLocationType }

function TXMLLocationType.Get_Locator: WideString;
begin
  Result := ChildNodes['Locator'].Text;
end;

procedure TXMLLocationType.Set_Locator(Value: WideString);
begin
  ChildNodes['Locator'].NodeValue := Value;
end;

end.