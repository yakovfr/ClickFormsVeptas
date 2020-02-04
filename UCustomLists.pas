unit UCustomLists;

interface

uses
  Classes;

type
  TCustomList = class(TStringList)
    public
      procedure AfterConstruction; override;
      procedure PopulateList; overload; virtual; abstract;
      class procedure PopulateList(const AList: TStrings); overload;
  end;

  TPostalCodeNameList = class(TCustomList)
    private
      procedure PopulateENC;
      procedure PopulateENU;

    public
      procedure PopulateList; override;
  end;

  TPostalCodeList = class(TCustomList)
    public
      procedure PopulateList; override;
  end;

  TPostalNameList = class(TCustomList)
    public
      procedure PopulateList; override;
  end;

  TTerritoryNameList = class(TPostalNameList)
    public
      procedure PopulateList; override;
  end;

implementation

uses
  Windows,
  SysUtils;

// --- TCustomList ------------------------------------------------------------

procedure TCustomList.AfterConstruction;
begin
  inherited;
  Duplicates := dupIgnore;
  CaseSensitive := false;
  PopulateList;
end;

class procedure TCustomList.PopulateList(const AList: TStrings);
var
  list: TCustomList;
begin
  if not Assigned(AList) then
    EInvalidPointer.Create('The parameter is invalid');

  list := Create;
  try
    list.Sort;
    AList.Text := list.Text;
  finally
    FreeAndNil(list);
  end;
end;

// --- TPostalCodeNameList --------------------------------------------

procedure TPostalCodeNameList.PopulateList;
var
  sLanguage: array [0..254] of Char;
begin
  GetLocaleInfo(LOCALE_SYSTEM_DEFAULT, LOCALE_SABBREVLANGNAME, sLanguage, sizeof(sLanguage));

  if (sLanguage = 'ENU') then
    PopulateENU
  else if (sLanguage = 'ENC') then
    PopulateENC
  else
    PopulateENU;
end;

procedure TPostalCodeNameList.PopulateENC;
begin
  Values['AB'] := 'Alberta';
  Values['BC'] := 'British Columbia';
  Values['MB'] := 'Manatoba';
  Values['NB'] := 'New Brunswick';
  Values['NL'] := 'Newfoundland';
  Values['NT'] := 'Northwest Territories';
  Values['NS'] := 'Nova Scotia';
  Values['NU'] := 'Nanavut';
  Values['ON'] := 'Ontario';
  Values['PE'] := 'Prince Edward Island';
  Values['QC'] := 'Quebec';
  Values['SK'] := 'Saskatchewan';
  Values['YT'] := 'Yukon Territory';
end;

procedure TPostalCodeNameList.PopulateENU;
begin
  Values['AA'] := 'Armed Forces Americas';
  Values['AE'] := 'Armed Forces Europe';
  Values['AK'] := 'Alaska';
  Values['AL'] := 'Alabama';
  Values['AP'] := 'Armed Forces Pacific';
  Values['AR'] := 'Arkansas';
  Values['AS'] := 'American Samoa';
  Values['AZ'] := 'Arizona';
  Values['CA'] := 'California';
  Values['CO'] := 'Colorado';
  Values['CT'] := 'Connecticut';
  Values['DC'] := 'District of Columbia';
  Values['DE'] := 'Delaware';
  Values['FL'] := 'Florida';
  Values['FM'] := 'Federated States of Micronesia';
  Values['GA'] := 'Georgia';
  Values['GU'] := 'Guam';
  Values['HI'] := 'Hawaii';
  Values['IA'] := 'Iowa';
  Values['ID'] := 'Idaho';
  Values['IL'] := 'Illinois';
  Values['IN'] := 'Indiana';
  Values['KS'] := 'Kansas';
  Values['KY'] := 'Kentucky';
  Values['LA'] := 'Louisiana';
  Values['MA'] := 'Massachusetts';
  Values['MD'] := 'Maryland';
  Values['ME'] := 'Maine';
  Values['MH'] := 'Marshall Islands';
  Values['MI'] := 'Michigan';
  Values['MN'] := 'Minnesota';
  Values['MO'] := 'Missouri';
  Values['MS'] := 'Mississippi';
  Values['MT'] := 'Montana';
  Values['NC'] := 'North Carolina';
  Values['ND'] := 'North Dakota';
  Values['NE'] := 'Nebraska';
  Values['NH'] := 'New Hampshire';
  Values['NJ'] := 'New Jersey';
  Values['NM'] := 'New Mexico';
  Values['NP'] := 'Northern Mariana Islands';
  Values['NV'] := 'Nevada';
  Values['NY'] := 'New York';
  Values['OH'] := 'Ohio';
  Values['OK'] := 'Oklahoma';
  Values['OR'] := 'Oregon';
  Values['PA'] := 'Pennsylvania';
  Values['PR'] := 'Puerto Rico';
  Values['PW'] := 'Palau';
  Values['RI'] := 'Rhode Island';
  Values['SC'] := 'South Carolina';
  Values['SD'] := 'South Dakota';
  Values['TN'] := 'Tennessee';
  Values['TX'] := 'Texas';
  Values['UT'] := 'Utah';
  Values['VA'] := 'Virginia';
  Values['VI'] := 'Virgin Islands';
  Values['VT'] := 'Vermont';
  Values['WA'] := 'Washington';
  Values['WI'] := 'Wisconsin';
  Values['WV'] := 'West Virginia';
  Values['WY'] := 'Wyoming';
end;

// --- TPostalCodeList ------------------------------------------------

procedure TPostalCodeList.PopulateList;
var
  index: integer;
  list: TPostalCodeNameList;
begin
  list := TPostalCodeNameList.Create;
  try
    for index := 0 to list.Count - 1 do
      Add(list.Names[index]);
  finally
    FreeAndNil(list);
  end;
end;

// --- TPostalNameList --------------------------------------------------------

procedure TPostalNameList.PopulateList;
var
  index: integer;
  list: TPostalCodeNameList;
begin
  list := TPostalCodeNameList.Create;
  try
    for index := 0 to list.Count - 1 do
      Add(list.ValueFromIndex[index]);
  finally
    FreeAndNil(list);
  end;
end;

// --- TTerritoryNameList -----------------------------------------------------

procedure TTerritoryNameList.PopulateList;
begin
  inherited;
  if (IndexOf('Armed Forces Americas') <> -1) then
    Delete(IndexOf('Armed Forces Americas'));
    
  if (IndexOf('Armed Forces Europe') <> -1) then
    Delete(IndexOf('Armed Forces Europe'));

  if (IndexOf('Armed Forces Pacific') <> -1) then
    Delete(IndexOf('Armed Forces Pacific'));
end;

end.
