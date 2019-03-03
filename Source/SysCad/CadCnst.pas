unit CadCnst;      

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 10/04/2003 - DD/MM/YYYY                                      *}
{* Modified: 10/04/2003 - DD/MM/YYYY                                     *}
{* Version: 1.0.0.0                                                      *}
{* License: you can freely use and distribute the included code          *}
{*         for any purpouse, but you cannot remove this copyright        *}
{*         notice. Send me any comments and updates, they are really     *}
{*         appreciated. This software is licensed under MPL License,     *}
{*         see http://www.mozilla.org/MPL/ for datails                   *}
{* Contact: (alcindo@sistemaprocessa.com.br)                             *}
{*         http://www.sistemaprocessa.com.br                             *}
{*                                                                       *}
{*************************************************************************}

interface

uses CmmConst;

const
// Definitions
  HELP_LIBRARY           = SDOTH + SPATHSEP + 'Doc'  + SPATHSEP + 'Entity.hlp';
  FLAG_LADO_ESQUERDO     = 0;
  FLAG_LADO_DIREITO      = 1;
  FLAG_TCAD_JURIDICA     = 0;
  FLAG_TCAD_FISICA       = 1;
  FLAG_CAT_CLIENTE       = 0;
  FLAG_CAT_FORNECEDOR    = 1;
  FLAG_CAT_FUNCIONARIO   = 2;
  FLAG_CAT_OUTROS        = 2;
  FLAG_ATV_INATIVO       = 0;
  FLAG_ATV_ATIVO         = 1;
  FLAG_CRG_VENDEDOR      = 0;
  FLAG_CRG_REPRESENTANTE = 1;
  FLAG_CRG_GERENTE       = 2;
  ENDERECO_HTTP          = 'http://www.';
  MASK_NO_CNPJ_CPF       = '00000000000999;0; ';
  MASK_CPF               = '000\.000\.000\-00;0; ';
  MASK_CNPJ              = '00\.000\.000\/0000\-00;0; ';

implementation

end.
