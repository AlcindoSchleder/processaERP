unit mArqSql;

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

type
  TConstantNames = (tcErrArquivo, tcErrConection, tcWithOutOper,
    tcLNome, tcLSenha, tcBEntra, tcBSai);

const
// Sql's do programa Dado.pas
  SqlModRot  = 'select * from VW_ACESSOS_MOD_ROT ' + NL +
               ' where FK_OPERADORES = :Operador ' + NL +
               '   and FLAG_VIS      = :FlagVis  ' + NL +
               ' order by DSC_MOD, DSC_ROT ';
  SqlProgram = 'select * from VW_ACESSOS_PRG ' + NL +
               ' where FK_OPERADORES = :Operador and ' + NL +
               '       FK_MODULOS    = :Modulo   and ' + NL +
               '       FK_ROTINAS    = :Rotina       ' + NL +
               ' order by DSC_PRG';

  SqlOperador = 'select * from OPERADORES ' + NL +
                ' where PK_OPERADORES = :Operador';

  SqlOperatorActive = 'select Ope.PK_OPERADORES, Eat.FK_EMPRESAS, ' + NL +
                      '       Ope.EMAIL_OPE '                       + NL +
                      '  from OPERADORES Ope, EMPRESA_ATIVA Eat '   + NL +
                      ' where Ope.PK_OPERADORES = :Operador '       + NL +
                      '   and Eat.FK_OPERADORES = Ope.PK_OPERADORES';

  SqlResourceOpe    = 'select PK_RESOURCES from RESOURCES ' + NL +
                      ' where FK_OPERADORES = :FkOperadores';

implementation

end.
