unit EstqCnst;

interface

uses CmmConst;

type

  TAllowedEvent = procedure (Sender: TObject; const Checked: Boolean;
                    var Allowed: Boolean) of object;

const
// Definitions
  HELP_LIBRARY           = SDOTH + SPATHSEP + 'Doc'  + SPATHSEP + 'Products.hlp';
  FLAG_CAT_CLIENTE       = 0;
  FLAG_CAT_FORNECEDOR    = 1;
  FLAG_CAT_FUNCIONARIO   = 2;
  FLAG_ATV_INATIVO       = 0;
  FLAG_ATV_ATIVO         = 1;
  FLAG_CRG_VENDEDOR      = 0;
  FLAG_CRG_REPRESENTANTE = 1;
  FLAG_CRG_GERENTE       = 2;
  ENDERECO_HTTP          = 'http://www.';

implementation

end.
