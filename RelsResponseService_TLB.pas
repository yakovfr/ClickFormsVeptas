unit RelsResponseService_TLB;

{  ClickForms Application               }
{  Bradford Technologies, Inc.          }
{  All Rights Reserved                  }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{***********************************************************************************************}
{                                                                                               }
{                                       XML Data Binding                                        }
{                                                                                               }
{         Generated on: 5/20/2013 9:50:13 AM                                                    }
{       Generated from: C:\Users\jwyatt\Documents\My ClickFORMS\UAD XML Files\Rpt40000732.xml   }
{   Settings stored in: C:\Users\jwyatt\Documents\My ClickFORMS\UAD XML Files\Rpt40000732.xdb   }
{                                                                                               }
{***********************************************************************************************}

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLRESPONSE_GROUPType = interface;
  IXMLRESPONSEType = interface;
  IXMLRESPONSE_DATAType = interface;
  IXMLRELS_VALIDATION_RESPONSEType = interface;
  IXMLRULEType = interface;
  IXMLRULETypeList = interface;
  IXMLFIELDSType = interface;
  IXMLFIELDType = interface;
  IXMLRELS_COMMENTARY_ADDENDUMType = interface;
  IXMLSECTIONType = interface;
  IXMLMAIN_RULEType = interface;
  IXMLCOMMENTARY_RULEType = interface;
  IXMLSTATUSType = interface;

{ IXMLRESPONSE_GROUPType }

  IXMLRESPONSE_GROUPType = interface(IXMLNode)
    ['{C0804E8E-6405-4416-ABDE-B40CD1C6FF00}']
    { Property Accessors }
    function Get_MISMOVersionID: WideString;
    function Get_RESPONSE: IXMLRESPONSEType;
    procedure Set_MISMOVersionID(Value: WideString);
    { Methods & Properties }
    property MISMOVersionID: WideString read Get_MISMOVersionID write Set_MISMOVersionID;
    property RESPONSE: IXMLRESPONSEType read Get_RESPONSE;
  end;

{ IXMLRESPONSEType }

  IXMLRESPONSEType = interface(IXMLNode)
    ['{D19101F4-0620-4DBA-BF75-02A0B699DD1B}']
    { Property Accessors }
    function Get_RESPONSE_DATA: IXMLRESPONSE_DATAType;
    function Get_STATUS: IXMLSTATUSType;
    { Methods & Properties }
    property RESPONSE_DATA: IXMLRESPONSE_DATAType read Get_RESPONSE_DATA;
    property STATUS: IXMLSTATUSType read Get_STATUS;
  end;

{ IXMLRESPONSE_DATAType }

  IXMLRESPONSE_DATAType = interface(IXMLNode)
    ['{8DF47B03-E213-4477-9A45-9444BCD9AD3A}']
    { Property Accessors }
    function Get_RELS_VALIDATION_RESPONSE: IXMLRELS_VALIDATION_RESPONSEType;
    { Methods & Properties }
    property RELS_VALIDATION_RESPONSE: IXMLRELS_VALIDATION_RESPONSEType read Get_RELS_VALIDATION_RESPONSE;
  end;

{ IXMLRELS_VALIDATION_RESPONSEType }

  IXMLRELS_VALIDATION_RESPONSEType = interface(IXMLNode)
    ['{775A9C0E-3379-40DF-AECF-A459A8BDFBB8}']
    { Property Accessors }
    function Get_RULE: IXMLRULETypeList;
    function Get_RELS_COMMENTARY_ADDENDUM: IXMLRELS_COMMENTARY_ADDENDUMType;
    { Methods & Properties }
    property RULE: IXMLRULETypeList read Get_RULE;
    property RELS_COMMENTARY_ADDENDUM: IXMLRELS_COMMENTARY_ADDENDUMType read Get_RELS_COMMENTARY_ADDENDUM;
  end;

{ IXMLRULEType }

  IXMLRULEType = interface(IXMLNode)
    ['{8B61F7D6-946B-49DF-B548-9D3E4122BD13}']
    { Property Accessors }
    function Get_Id: WideString;
    function Get_Category: WideString;
    function Get_Section: WideString;
    function Get_MESSAGE: WideString;
    function Get_ADDITIONAL_INFO: WideString;
    function Get_FIELDS: IXMLFIELDSType;
    procedure Set_Id(Value: WideString);
    procedure Set_Category(Value: WideString);
    procedure Set_Section(Value: WideString);
    procedure Set_MESSAGE(Value: WideString);
    procedure Set_ADDITIONAL_INFO(Value: WideString);
    { Methods & Properties }
    property Id: WideString read Get_Id write Set_Id;
    property Category: WideString read Get_Category write Set_Category;
    property Section: WideString read Get_Section write Set_Section;
    property MESSAGE: WideString read Get_MESSAGE write Set_MESSAGE;
    property ADDITIONAL_INFO: WideString read Get_ADDITIONAL_INFO write Set_ADDITIONAL_INFO;
    property FIELDS: IXMLFIELDSType read Get_FIELDS;
  end;

{ IXMLRULETypeList }

  IXMLRULETypeList = interface(IXMLNodeCollection)
    ['{4C44E6A0-21F0-4A57-A6E7-BDD21F3F28DD}']
    { Methods & Properties }
    function Add: IXMLRULEType;
    function Insert(const Index: Integer): IXMLRULEType;
    function Get_Item(Index: Integer): IXMLRULEType;
    property Items[Index: Integer]: IXMLRULEType read Get_Item; default;
  end;

{ IXMLFIELDSType }

  IXMLFIELDSType = interface(IXMLNodeCollection)
    ['{C2068A18-0023-49ED-B90A-3846FF8F1620}']
    { Property Accessors }
    function Get_FIELD(Index: Integer): IXMLFIELDType;
    { Methods & Properties }
    function Add: IXMLFIELDType;
    function Insert(const Index: Integer): IXMLFIELDType;
    property FIELD[Index: Integer]: IXMLFIELDType read Get_FIELD; default;
  end;

{ IXMLFIELDType }

  IXMLFIELDType = interface(IXMLNode)
    ['{C8DAAA80-0696-43D0-B598-9746B4CEE84B}']
    { Property Accessors }
    function Get_Location: WideString;
    function Get_HelpLocation: WideString;
    procedure Set_Location(Value: WideString);
    procedure Set_HelpLocation(Value: WideString);
    { Methods & Properties }
    property Location: WideString read Get_Location write Set_Location;
    property HelpLocation: WideString read Get_HelpLocation write Set_HelpLocation;
  end;

{ IXMLRELS_COMMENTARY_ADDENDUMType }

  IXMLRELS_COMMENTARY_ADDENDUMType = interface(IXMLNodeCollection)
    ['{ADA57DE0-6804-4419-B591-9DC23A696FEB}']
    { Property Accessors }
    function Get_Rebuild: WideString;
    function Get_SECTION(Index: Integer): IXMLSECTIONType;
    procedure Set_Rebuild(Value: WideString);
    { Methods & Properties }
    function Add: IXMLSECTIONType;
    function Insert(const Index: Integer): IXMLSECTIONType;
    property Rebuild: WideString read Get_Rebuild write Set_Rebuild;
    property SECTION[Index: Integer]: IXMLSECTIONType read Get_SECTION; default;
  end;

{ IXMLSECTIONType }

  IXMLSECTIONType = interface(IXMLNodeCollection)
    ['{63E00808-18C6-4A73-9276-9B554FE57163}']
    { Property Accessors }
    function Get_Section: WideString;
    function Get_Id: Integer;
    function Get_MAIN_RULE(Index: Integer): IXMLMAIN_RULEType;
    procedure Set_Section(Value: WideString);
    procedure Set_Id(Value: Integer);
    { Methods & Properties }
    function Add: IXMLMAIN_RULEType;
    function Insert(const Index: Integer): IXMLMAIN_RULEType;
    property Section: WideString read Get_Section write Set_Section;
    property Id: Integer read Get_Id write Set_Id;
    property MAIN_RULE[Index: Integer]: IXMLMAIN_RULEType read Get_MAIN_RULE; default;
  end;

{ IXMLMAIN_RULEType }

  IXMLMAIN_RULEType = interface(IXMLNodeCollection)
    ['{B7F91D18-5975-4B6B-8B4A-4949DBC09C7A}']
    { Property Accessors }
    function Get_Message: WideString;
    function Get_Id: WideString;
    function Get_COMMENTARY_RULE(Index: Integer): IXMLCOMMENTARY_RULEType;
    procedure Set_Message(Value: WideString);
    procedure Set_Id(Value: WideString);
    { Methods & Properties }
    function Add: IXMLCOMMENTARY_RULEType;
    function Insert(const Index: Integer): IXMLCOMMENTARY_RULEType;
    property Message: WideString read Get_Message write Set_Message;
    property Id: WideString read Get_Id write Set_Id;
    property COMMENTARY_RULE[Index: Integer]: IXMLCOMMENTARY_RULEType read Get_COMMENTARY_RULE; default;
  end;

{ IXMLCOMMENTARY_RULEType }

  IXMLCOMMENTARY_RULEType = interface(IXMLNode)
    ['{F743F5B0-D5EA-445F-B547-AD09321C73BD}']
    { Property Accessors }
    function Get_Message: WideString;
    function Get_Id: WideString;
    function Get_RequiresYesNoResponse: WideString;
    function Get_CommentRequiredCondition: WideString;
    function Get_AppraiserResponse: WideString;
    procedure Set_Message(Value: WideString);
    procedure Set_Id(Value: WideString);
    procedure Set_RequiresYesNoResponse(Value: WideString);
    procedure Set_CommentRequiredCondition(Value: WideString);
    procedure Set_AppraiserResponse(Value: WideString);
    { Methods & Properties }
    property Message: WideString read Get_Message write Set_Message;
    property Id: WideString read Get_Id write Set_Id;
    property RequiresYesNoResponse: WideString read Get_RequiresYesNoResponse write Set_RequiresYesNoResponse;
    property CommentRequiredCondition: WideString read Get_CommentRequiredCondition write Set_CommentRequiredCondition;
    property AppraiserResponse: WideString read Get_AppraiserResponse write Set_AppraiserResponse;
  end;

{ IXMLSTATUSType }

  IXMLSTATUSType = interface(IXMLNode)
    ['{4EE76276-8620-4636-A402-3630C27C6850}']
    { Property Accessors }
    function Get__Condition: WideString;
    function Get__Code: WideString;
    function Get__Name: WideString;
    function Get__Description: WideString;
    procedure Set__Condition(Value: WideString);
    procedure Set__Code(Value: WideString);
    procedure Set__Name(Value: WideString);
    procedure Set__Description(Value: WideString);
    { Methods & Properties }
    property _Condition: WideString read Get__Condition write Set__Condition;
    property _Code: WideString read Get__Code write Set__Code;
    property _Name: WideString read Get__Name write Set__Name;
    property _Description: WideString read Get__Description write Set__Description;
  end;

{ Forward Decls }

  TXMLRESPONSE_GROUPType = class;
  TXMLRESPONSEType = class;
  TXMLRESPONSE_DATAType = class;
  TXMLRELS_VALIDATION_RESPONSEType = class;
  TXMLRULEType = class;
  TXMLRULETypeList = class;
  TXMLFIELDSType = class;
  TXMLFIELDType = class;
  TXMLRELS_COMMENTARY_ADDENDUMType = class;
  TXMLSECTIONType = class;
  TXMLMAIN_RULEType = class;
  TXMLCOMMENTARY_RULEType = class;
  TXMLSTATUSType = class;

{ TXMLRESPONSE_GROUPType }

  TXMLRESPONSE_GROUPType = class(TXMLNode, IXMLRESPONSE_GROUPType)
  protected
    { IXMLRESPONSE_GROUPType }
    function Get_MISMOVersionID: WideString;
    function Get_RESPONSE: IXMLRESPONSEType;
    procedure Set_MISMOVersionID(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLRESPONSEType }

  TXMLRESPONSEType = class(TXMLNode, IXMLRESPONSEType)
  protected
    { IXMLRESPONSEType }
    function Get_RESPONSE_DATA: IXMLRESPONSE_DATAType;
    function Get_STATUS: IXMLSTATUSType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLRESPONSE_DATAType }

  TXMLRESPONSE_DATAType = class(TXMLNode, IXMLRESPONSE_DATAType)
  protected
    { IXMLRESPONSE_DATAType }
    function Get_RELS_VALIDATION_RESPONSE: IXMLRELS_VALIDATION_RESPONSEType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLRELS_VALIDATION_RESPONSEType }

  TXMLRELS_VALIDATION_RESPONSEType = class(TXMLNode, IXMLRELS_VALIDATION_RESPONSEType)
  private
    FRULE: IXMLRULETypeList;
  protected
    { IXMLRELS_VALIDATION_RESPONSEType }
    function Get_RULE: IXMLRULETypeList;
    function Get_RELS_COMMENTARY_ADDENDUM: IXMLRELS_COMMENTARY_ADDENDUMType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLRULEType }

  TXMLRULEType = class(TXMLNode, IXMLRULEType)
  protected
    { IXMLRULEType }
    function Get_Id: WideString;
    function Get_Category: WideString;
    function Get_Section: WideString;
    function Get_MESSAGE: WideString;
    function Get_ADDITIONAL_INFO: WideString;
    function Get_FIELDS: IXMLFIELDSType;
    procedure Set_Id(Value: WideString);
    procedure Set_Category(Value: WideString);
    procedure Set_Section(Value: WideString);
    procedure Set_MESSAGE(Value: WideString);
    procedure Set_ADDITIONAL_INFO(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLRULETypeList }

  TXMLRULETypeList = class(TXMLNodeCollection, IXMLRULETypeList)
  protected
    { IXMLRULETypeList }
    function Add: IXMLRULEType;
    function Insert(const Index: Integer): IXMLRULEType;
    function Get_Item(Index: Integer): IXMLRULEType;
  end;

{ TXMLFIELDSType }

  TXMLFIELDSType = class(TXMLNodeCollection, IXMLFIELDSType)
  protected
    { IXMLFIELDSType }
    function Get_FIELD(Index: Integer): IXMLFIELDType;
    function Add: IXMLFIELDType;
    function Insert(const Index: Integer): IXMLFIELDType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLFIELDType }

  TXMLFIELDType = class(TXMLNode, IXMLFIELDType)
  protected
    { IXMLFIELDType }
    function Get_Location: WideString;
    function Get_HelpLocation: WideString;
    procedure Set_Location(Value: WideString);
    procedure Set_HelpLocation(Value: WideString);
  end;

{ TXMLRELS_COMMENTARY_ADDENDUMType }

  TXMLRELS_COMMENTARY_ADDENDUMType = class(TXMLNodeCollection, IXMLRELS_COMMENTARY_ADDENDUMType)
  protected
    { IXMLRELS_COMMENTARY_ADDENDUMType }
    function Get_Rebuild: WideString;
    function Get_SECTION(Index: Integer): IXMLSECTIONType;
    procedure Set_Rebuild(Value: WideString);
    function Add: IXMLSECTIONType;
    function Insert(const Index: Integer): IXMLSECTIONType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLSECTIONType }

  TXMLSECTIONType = class(TXMLNodeCollection, IXMLSECTIONType)
  protected
    { IXMLSECTIONType }
    function Get_Section: WideString;
    function Get_Id: Integer;
    function Get_MAIN_RULE(Index: Integer): IXMLMAIN_RULEType;
    procedure Set_Section(Value: WideString);
    procedure Set_Id(Value: Integer);
    function Add: IXMLMAIN_RULEType;
    function Insert(const Index: Integer): IXMLMAIN_RULEType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLMAIN_RULEType }

  TXMLMAIN_RULEType = class(TXMLNodeCollection, IXMLMAIN_RULEType)
  protected
    { IXMLMAIN_RULEType }
    function Get_Message: WideString;
    function Get_Id: WideString;
    function Get_COMMENTARY_RULE(Index: Integer): IXMLCOMMENTARY_RULEType;
    procedure Set_Message(Value: WideString);
    procedure Set_Id(Value: WideString);
    function Add: IXMLCOMMENTARY_RULEType;
    function Insert(const Index: Integer): IXMLCOMMENTARY_RULEType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLCOMMENTARY_RULEType }

  TXMLCOMMENTARY_RULEType = class(TXMLNode, IXMLCOMMENTARY_RULEType)
  protected
    { IXMLCOMMENTARY_RULEType }
    function Get_Message: WideString;
    function Get_Id: WideString;
    function Get_RequiresYesNoResponse: WideString;
    function Get_CommentRequiredCondition: WideString;
    function Get_AppraiserResponse: WideString;
    procedure Set_Message(Value: WideString);
    procedure Set_Id(Value: WideString);
    procedure Set_RequiresYesNoResponse(Value: WideString);
    procedure Set_CommentRequiredCondition(Value: WideString);
    procedure Set_AppraiserResponse(Value: WideString);
  end;

{ TXMLSTATUSType }

  TXMLSTATUSType = class(TXMLNode, IXMLSTATUSType)
  protected
    { IXMLSTATUSType }
    function Get__Condition: WideString;
    function Get__Code: WideString;
    function Get__Name: WideString;
    function Get__Description: WideString;
    procedure Set__Condition(Value: WideString);
    procedure Set__Code(Value: WideString);
    procedure Set__Name(Value: WideString);
    procedure Set__Description(Value: WideString);
  end;

{ Global Functions }

function GetRESPONSE_GROUP(Doc: IXMLDocument): IXMLRESPONSE_GROUPType;
function LoadRESPONSE_GROUP(const FileName: WideString): IXMLRESPONSE_GROUPType;
function NewRESPONSE_GROUP: IXMLRESPONSE_GROUPType;

const
  TargetNamespace = '';

implementation

{ Global Functions }

function GetRESPONSE_GROUP(Doc: IXMLDocument): IXMLRESPONSE_GROUPType;
begin
  Result := Doc.GetDocBinding('RESPONSE_GROUP', TXMLRESPONSE_GROUPType, TargetNamespace) as IXMLRESPONSE_GROUPType;
end;

function LoadRESPONSE_GROUP(const FileName: WideString): IXMLRESPONSE_GROUPType;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('RESPONSE_GROUP', TXMLRESPONSE_GROUPType, TargetNamespace) as IXMLRESPONSE_GROUPType;
end;

function NewRESPONSE_GROUP: IXMLRESPONSE_GROUPType;
begin
  Result := NewXMLDocument.GetDocBinding('RESPONSE_GROUP', TXMLRESPONSE_GROUPType, TargetNamespace) as IXMLRESPONSE_GROUPType;
end;

{ TXMLRESPONSE_GROUPType }

procedure TXMLRESPONSE_GROUPType.AfterConstruction;
begin
  RegisterChildNode('RESPONSE', TXMLRESPONSEType);
  inherited;
end;

function TXMLRESPONSE_GROUPType.Get_MISMOVersionID: WideString;
begin
  Result := AttributeNodes['MISMOVersionID'].Text;
end;

procedure TXMLRESPONSE_GROUPType.Set_MISMOVersionID(Value: WideString);
begin
  SetAttribute('MISMOVersionID', Value);
end;

function TXMLRESPONSE_GROUPType.Get_RESPONSE: IXMLRESPONSEType;
begin
  Result := ChildNodes['RESPONSE'] as IXMLRESPONSEType;
end;

{ TXMLRESPONSEType }

procedure TXMLRESPONSEType.AfterConstruction;
begin
  RegisterChildNode('RESPONSE_DATA', TXMLRESPONSE_DATAType);
  RegisterChildNode('STATUS', TXMLSTATUSType);
  inherited;
end;

function TXMLRESPONSEType.Get_RESPONSE_DATA: IXMLRESPONSE_DATAType;
begin
  Result := ChildNodes['RESPONSE_DATA'] as IXMLRESPONSE_DATAType;
end;

function TXMLRESPONSEType.Get_STATUS: IXMLSTATUSType;
begin
  Result := ChildNodes['STATUS'] as IXMLSTATUSType;
end;

{ TXMLRESPONSE_DATAType }

procedure TXMLRESPONSE_DATAType.AfterConstruction;
begin
  RegisterChildNode('RELS_VALIDATION_RESPONSE', TXMLRELS_VALIDATION_RESPONSEType);
  inherited;
end;

function TXMLRESPONSE_DATAType.Get_RELS_VALIDATION_RESPONSE: IXMLRELS_VALIDATION_RESPONSEType;
begin
  Result := ChildNodes['RELS_VALIDATION_RESPONSE'] as IXMLRELS_VALIDATION_RESPONSEType;
end;

{ TXMLRELS_VALIDATION_RESPONSEType }

procedure TXMLRELS_VALIDATION_RESPONSEType.AfterConstruction;
begin
  RegisterChildNode('RULE', TXMLRULEType);
  RegisterChildNode('RELS_COMMENTARY_ADDENDUM', TXMLRELS_COMMENTARY_ADDENDUMType);
  FRULE := CreateCollection(TXMLRULETypeList, IXMLRULEType, 'RULE') as IXMLRULETypeList;
  inherited;
end;

function TXMLRELS_VALIDATION_RESPONSEType.Get_RULE: IXMLRULETypeList;
begin
  Result := FRULE;
end;

function TXMLRELS_VALIDATION_RESPONSEType.Get_RELS_COMMENTARY_ADDENDUM: IXMLRELS_COMMENTARY_ADDENDUMType;
begin
  Result := ChildNodes['RELS_COMMENTARY_ADDENDUM'] as IXMLRELS_COMMENTARY_ADDENDUMType;
end;

{ TXMLRULEType }

procedure TXMLRULEType.AfterConstruction;
begin
  RegisterChildNode('FIELDS', TXMLFIELDSType);
  inherited;
end;

function TXMLRULEType.Get_Id: WideString;
begin
  Result := AttributeNodes['Id'].Text;
end;

procedure TXMLRULEType.Set_Id(Value: WideString);
begin
  SetAttribute('Id', Value);
end;

function TXMLRULEType.Get_Category: WideString;
begin
  Result := AttributeNodes['Category'].Text;
end;

procedure TXMLRULEType.Set_Category(Value: WideString);
begin
  SetAttribute('Category', Value);
end;

function TXMLRULEType.Get_Section: WideString;
begin
  Result := AttributeNodes['Section'].Text;
end;

procedure TXMLRULEType.Set_Section(Value: WideString);
begin
  SetAttribute('Section', Value);
end;

function TXMLRULEType.Get_MESSAGE: WideString;
begin
  Result := ChildNodes['MESSAGE'].Text;
end;

procedure TXMLRULEType.Set_MESSAGE(Value: WideString);
begin
  ChildNodes['MESSAGE'].NodeValue := Value;
end;

function TXMLRULEType.Get_ADDITIONAL_INFO: WideString;
begin
  Result := ChildNodes['ADDITIONAL_INFO'].Text;
end;

procedure TXMLRULEType.Set_ADDITIONAL_INFO(Value: WideString);
begin
  ChildNodes['ADDITIONAL_INFO'].NodeValue := Value;
end;

function TXMLRULEType.Get_FIELDS: IXMLFIELDSType;
begin
  Result := ChildNodes['FIELDS'] as IXMLFIELDSType;
end;

{ TXMLRULETypeList }

function TXMLRULETypeList.Add: IXMLRULEType;
begin
  Result := AddItem(-1) as IXMLRULEType;
end;

function TXMLRULETypeList.Insert(const Index: Integer): IXMLRULEType;
begin
  Result := AddItem(Index) as IXMLRULEType;
end;
function TXMLRULETypeList.Get_Item(Index: Integer): IXMLRULEType;
begin
  Result := List[Index] as IXMLRULEType;
end;

{ TXMLFIELDSType }

procedure TXMLFIELDSType.AfterConstruction;
begin
  RegisterChildNode('FIELD', TXMLFIELDType);
  ItemTag := 'FIELD';
  ItemInterface := IXMLFIELDType;
  inherited;
end;

function TXMLFIELDSType.Get_FIELD(Index: Integer): IXMLFIELDType;
begin
  Result := List[Index] as IXMLFIELDType;
end;

function TXMLFIELDSType.Add: IXMLFIELDType;
begin
  Result := AddItem(-1) as IXMLFIELDType;
end;

function TXMLFIELDSType.Insert(const Index: Integer): IXMLFIELDType;
begin
  Result := AddItem(Index) as IXMLFIELDType;
end;

{ TXMLFIELDType }

function TXMLFIELDType.Get_Location: WideString;
begin
  Result := AttributeNodes['Location'].Text;
end;

procedure TXMLFIELDType.Set_Location(Value: WideString);
begin
  SetAttribute('Location', Value);
end;

function TXMLFIELDType.Get_HelpLocation: WideString;
begin
  Result := AttributeNodes['HelpLocation'].Text;
end;

procedure TXMLFIELDType.Set_HelpLocation(Value: WideString);
begin
  SetAttribute('HelpLocation', Value);
end;

{ TXMLRELS_COMMENTARY_ADDENDUMType }

procedure TXMLRELS_COMMENTARY_ADDENDUMType.AfterConstruction;
begin
  RegisterChildNode('SECTION', TXMLSECTIONType);
  ItemTag := 'SECTION';
  ItemInterface := IXMLSECTIONType;
  inherited;
end;

function TXMLRELS_COMMENTARY_ADDENDUMType.Get_Rebuild: WideString;
begin
  Result := AttributeNodes['Rebuild'].Text;
end;

procedure TXMLRELS_COMMENTARY_ADDENDUMType.Set_Rebuild(Value: WideString);
begin
  SetAttribute('Rebuild', Value);
end;

function TXMLRELS_COMMENTARY_ADDENDUMType.Get_SECTION(Index: Integer): IXMLSECTIONType;
begin
  Result := List[Index] as IXMLSECTIONType;
end;

function TXMLRELS_COMMENTARY_ADDENDUMType.Add: IXMLSECTIONType;
begin
  Result := AddItem(-1) as IXMLSECTIONType;
end;

function TXMLRELS_COMMENTARY_ADDENDUMType.Insert(const Index: Integer): IXMLSECTIONType;
begin
  Result := AddItem(Index) as IXMLSECTIONType;
end;

{ TXMLSECTIONType }

procedure TXMLSECTIONType.AfterConstruction;
begin
  RegisterChildNode('MAIN_RULE', TXMLMAIN_RULEType);
  ItemTag := 'MAIN_RULE';
  ItemInterface := IXMLMAIN_RULEType;
  inherited;
end;

function TXMLSECTIONType.Get_Section: WideString;
begin
  Result := AttributeNodes['Section'].Text;
end;

procedure TXMLSECTIONType.Set_Section(Value: WideString);
begin
  SetAttribute('Section', Value);
end;

function TXMLSECTIONType.Get_Id: Integer;
begin
  Result := AttributeNodes['Id'].NodeValue;
end;

procedure TXMLSECTIONType.Set_Id(Value: Integer);
begin
  SetAttribute('Id', Value);
end;

function TXMLSECTIONType.Get_MAIN_RULE(Index: Integer): IXMLMAIN_RULEType;
begin
  Result := List[Index] as IXMLMAIN_RULEType;
end;

function TXMLSECTIONType.Add: IXMLMAIN_RULEType;
begin
  Result := AddItem(-1) as IXMLMAIN_RULEType;
end;

function TXMLSECTIONType.Insert(const Index: Integer): IXMLMAIN_RULEType;
begin
  Result := AddItem(Index) as IXMLMAIN_RULEType;
end;

{ TXMLMAIN_RULEType }

procedure TXMLMAIN_RULEType.AfterConstruction;
begin
  RegisterChildNode('COMMENTARY_RULE', TXMLCOMMENTARY_RULEType);
  ItemTag := 'COMMENTARY_RULE';
  ItemInterface := IXMLCOMMENTARY_RULEType;
  inherited;
end;

function TXMLMAIN_RULEType.Get_Message: WideString;
begin
  Result := AttributeNodes['Message'].Text;
end;

procedure TXMLMAIN_RULEType.Set_Message(Value: WideString);
begin
  SetAttribute('Message', Value);
end;

function TXMLMAIN_RULEType.Get_Id: WideString;
begin
  Result := AttributeNodes['Id'].Text;
end;

procedure TXMLMAIN_RULEType.Set_Id(Value: WideString);
begin
  SetAttribute('Id', Value);
end;

function TXMLMAIN_RULEType.Get_COMMENTARY_RULE(Index: Integer): IXMLCOMMENTARY_RULEType;
begin
  Result := List[Index] as IXMLCOMMENTARY_RULEType;
end;

function TXMLMAIN_RULEType.Add: IXMLCOMMENTARY_RULEType;
begin
  Result := AddItem(-1) as IXMLCOMMENTARY_RULEType;
end;

function TXMLMAIN_RULEType.Insert(const Index: Integer): IXMLCOMMENTARY_RULEType;
begin
  Result := AddItem(Index) as IXMLCOMMENTARY_RULEType;
end;

{ TXMLCOMMENTARY_RULEType }

function TXMLCOMMENTARY_RULEType.Get_Message: WideString;
begin
  Result := AttributeNodes['Message'].Text;
end;

procedure TXMLCOMMENTARY_RULEType.Set_Message(Value: WideString);
begin
  SetAttribute('Message', Value);
end;

function TXMLCOMMENTARY_RULEType.Get_Id: WideString;
begin
  Result := AttributeNodes['Id'].Text;
end;

procedure TXMLCOMMENTARY_RULEType.Set_Id(Value: WideString);
begin
  SetAttribute('Id', Value);
end;

function TXMLCOMMENTARY_RULEType.Get_RequiresYesNoResponse: WideString;
begin
  Result := AttributeNodes['RequiresYesNoResponse'].Text;
end;

procedure TXMLCOMMENTARY_RULEType.Set_RequiresYesNoResponse(Value: WideString);
begin
  SetAttribute('RequiresYesNoResponse', Value);
end;

function TXMLCOMMENTARY_RULEType.Get_CommentRequiredCondition: WideString;
begin
  Result := AttributeNodes['CommentRequiredCondition'].Text;
end;

procedure TXMLCOMMENTARY_RULEType.Set_CommentRequiredCondition(Value: WideString);
begin
  SetAttribute('CommentRequiredCondition', Value);
end;

function TXMLCOMMENTARY_RULEType.Get_AppraiserResponse: WideString;
begin
  Result := AttributeNodes['AppraiserResponse'].Text;
end;

procedure TXMLCOMMENTARY_RULEType.Set_AppraiserResponse(Value: WideString);
begin
  SetAttribute('AppraiserResponse', Value);
end;

{ TXMLSTATUSType }

function TXMLSTATUSType.Get__Condition: WideString;
begin
  Result := AttributeNodes['_Condition'].Text;
end;

procedure TXMLSTATUSType.Set__Condition(Value: WideString);
begin
  SetAttribute('_Condition', Value);
end;

function TXMLSTATUSType.Get__Code: WideString;
begin
  Result := AttributeNodes['_Code'].Text;
end;

procedure TXMLSTATUSType.Set__Code(Value: WideString);
begin
  SetAttribute('_Code', Value);
end;

function TXMLSTATUSType.Get__Name: WideString;
begin
  Result := AttributeNodes['_Name'].Text;
end;

procedure TXMLSTATUSType.Set__Name(Value: WideString);
begin
  SetAttribute('_Name', Value);
end;

function TXMLSTATUSType.Get__Description: WideString;
begin
  Result := AttributeNodes['_Description'].Text;
end;

procedure TXMLSTATUSType.Set__Description(Value: WideString);
begin
  SetAttribute('_Description', Value);
end;

end.