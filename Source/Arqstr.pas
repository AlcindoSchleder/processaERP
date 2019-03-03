unit ArqStr;

{
*************************************************************************
*                                                                       *
* Author: Alcindo Schleder                                              *
* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *
* Created: 10/04/2003 - DD/MM/YYYY                                      *
* Modified: 10/04/2003 - DD/MM/YYYY                                     *
* Version: 1.0.0.0                                                      *
* License: you can freely use and distribute the included code          *
*         for any purpouse, but you cannot remove this copyright        *
*         notice. Send me any comments and updates, they are really     *
*         appreciated. This software is licensed under MPL License,     *
*         see http://www.mozilla.org/MPL/ for datails                   *
* Contact: (alcindo@sistemaprocessa.com.br)                             *
*         http://www.sistemaprocessa.com.br                             *
*************************************************************************
}

interface

type
  TConstantNames = (tcPirateProgram, tcExpireProgram,
    tcProcessaIni, tcErrArquivo, tcErrConection, tcWithOutOper, tcLNome,
    tcLSenha, tcBEntra, tcBSai, tcProcCaption, tcPrgNImpl, tcExecPrg,
    tcErrParametro, tcErrEmpresa);

const
  NameVars: array [0..Integer(High(TConstantNames))] of string = ('sPirateProgram',
    'sExpireProgram', 'sProcessaIni', 'sErrArquivo', 'sErrConnection',
    'sWithOutOper', 'LNome', 'LSenha', 'BEntra', 'BSai', 'sProcCaption',
    'sPrgNImpl', 'sExecPrg', 'sErrParametro', 'sErrEmpresa');
var
  Variables: array of string;

implementation

end.
