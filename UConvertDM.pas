unit UConvertDM;

interface

uses
  SysUtils, Classes, DB, ADODB;

type
  TConvertDM = class(TDataModule)
    SrcConnection: TADOConnection;
    DestConnection: TADOConnection;
    SrcDataSet: TADODataSet;
    DestDataSet: TADODataSet;
    SrcPhotodataSet: TADODataSet;
    DestPhotoDataSet: TADODataSet;
  private
    { Private declarations }
  public
    procedure SourceConnect(fileName: String);
    procedure SourceOpen(TableName: String);
    procedure SourcePhotosOpen(cmpID: Integer);
    procedure SourceClose;

    procedure DestConnect(fileName: String);
    procedure DestOpen(TableName: String);
    procedure DestPhotosOpen(cmpID: Integer);
    procedure DestClose;
  end;

var
  ConvertDM: TConvertDM;

implementation

{$R *.dfm}

Uses
  UStatus;


Const
  cADOProvider = 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=';



{ TConvertDM }

procedure TConvertDM.DestConnect(fileName: String);
begin
  DestConnection.Connected := False;
  DestConnection.ConnectionString := cADOProvider + fileName;
end;

procedure TConvertDM.DestOpen(TableName: String);
begin
  try
  with DestDataSet do begin
    Close;
    CommandType := cmdTableDirect;
    CommandText := TableName;
    Open;
  end;
  except
    on e: Exception do
      shownotice(e.Message);
  end;
end;

procedure TConvertDM.DestPhotosOpen(cmpID: Integer);
begin
  try
  with DestPhotoDataSet do begin
    Close;
    CommandType := cmdText;
    CommandText := 'SELECT * FROM PHOTOS WHERE CompsID = ' + IntToStr(cmpID); //it is empty
    Open;
  end;
  except
    on e: Exception do
      shownotice(e.Message);
  end;
end;

procedure TConvertDM.DestClose;
begin
  DestDataSet.Close;
end;


procedure TConvertDM.SourceConnect(fileName: String);
begin
  SrcConnection.Connected := False;
  SrcConnection.ConnectionString := cADOProvider + fileName;
end;

//no exception handling here, catch it above
procedure TConvertDM.SourceOpen(TableName: String);
begin
  with SrcDataSet do begin
    Close;
    CommandType := cmdTableDirect;
    CommandText := TableName;
    Open;
  end;
end;

procedure TConvertDM.SourcePhotosOpen(cmpID: Integer);
begin
  with SrcPhotoDataSet do begin
    Close;
      CommandType := cmdText;
      CommandText := 'SELECT * FROM PHOTOS WHERE CompsId = ' + IntToStr(cmpID);
      Open;
  end;
end;

procedure TConvertDM.SourceClose;
begin
  SrcDataSet.Close;
end;


end.
