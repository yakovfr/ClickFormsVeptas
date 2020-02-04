unit UAMC_URLS;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2012 by Bradford Technologies, Inc. }

interface

  function GetURLForStreetLinksServer: String;

implementation

uses
  UGlobals, UAMC_Globals;


const
  StreetLinks_Live_URL      = 'https://rest.streetlinks.com/';
  StreetLinks_Staging_URL   = 'https://rest.test.streetlinks.com/';





end.
