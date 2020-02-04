unit UCC_MLS_DataModule;

{  MLS Mapping Module     }
{  Bradford Technologies, Inc. }
{  All Rights Reserved         }
{  Source Code Copyrighted © 1998-2012 by Bradford Technologies, Inc. }

interface

uses
  SysUtils, Classes, xmldom, XMLIntf, msxmldom, XMLDoc, DB, DBClient;

type
  TMLSDataModule = class(TDataModule)
    DS_MLS_Board: TDataSource;
    CDS_MLS_Board: TClientDataSet;
    CDS_MLS_BoardId: TIntegerField;
    CDS_MLS_BoardMLS_Board: TStringField;
    CDS_MLS_BoardState: TStringField;
    DataSource1: TDataSource;
    XMLDocument1: TXMLDocument;
    CDS_Generic_StatusCode: TClientDataSet;
    CDS_Generic_StatusCodeStatusType: TStringField;
    CDS_GenericStatusCode: TStringField;
    CDS_UniqueStatusCode: TClientDataSet;
    CDS_UniqueStatusCodeStatusType: TStringField;
    CDS_UniqueStatusCodeStatusAbbrv: TStringField;
    ClientDataSet1: TClientDataSet;
    ClientDataSet1WordDescr: TStringField;
    ClientDataSet1WordValue: TStringField;
    ClientDataSet1WordTypeId: TIntegerField;
    ClientDataSet1WordListId: TIntegerField;
    CL_PropList: TClientDataSet;
    XMLPropList: TXMLDocument;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MLSDataModule: TMLSDataModule;

implementation

{$R *.dfm}

end.
