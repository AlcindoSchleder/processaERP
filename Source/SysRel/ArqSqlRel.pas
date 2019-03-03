unit ArqSqlRel;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 01/01/2004 - DD/MM/YYYY                                      *}
{* Modified: 01/01/2004 - DD/MM/YYYY                                     *}
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

resourcestring
// Generators SQL from thi module
  SQlGenReport  = 'select R_PK_RELATORIOS as PK_RELATORIOS ' + NL +
                  '  from STP_GET_PK_RELATORIOS(:fklinguagens, :fkmodulos)';

// sql aux strings
  SqlAllReports = 'select Mod.PK_MODULOS, Mod.DSC_MOD, Rel.* '    + NL +
                  '  from MODULOS Mod '                           + NL +
                  '  left outer join RELATORIOS Rel '             + NL +
                  '    on Rel.FK_LINGUAGENS = Mod.FK_LINGUAGENS ' + NL +
                  '   and Rel.FK_MODULOS    = Mod.PK_MODULOS '    + NL +
                  ' where Mod.FK_LINGUAGENS = :FkLinguagens '     + NL +
                  ' order by Mod.DSC_MOD, Rel.PK_RELATORIOS';
                  
  SqlOrderRep   = ' order by Lng.DSC_LANG, Mod.DSC_MOD, Rel.PK_RELATORIOS';

  SqlInsReport  = 'insert into RELATORIOS '                       + NL +
                  '  (DSC_REL, DSC_GRAPH, FLAG_GRAPH, REL_SYS, '  + NL +
                  '   FK_LINGUAGENS, FK_MODULOS, PK_RELATORIOS, ' + NL +
                  '   FLAG_MATRIX) ' + NL +
                  ' values '                                      + NL +
                  '  (:DscRel, :DscGraph, :FlagGraph, :RelSys, '  + NL +
                  '   :FkLinguagens, :FkModulos, :PkRelatorios, ' + NL +
                  '   :FlagMatrix)';

  SqlUpdReport  = 'update RELATORIOS set '                + NL +
                  '       DSC_REL       = :DscRel, '      + NL +
                  '       DSC_GRAPH     = :DscGraph, '    + NL +
                  '       FLAG_GRAPH    = :FlagGraph, '   + NL +
                  '       REL_SYS       = :RelSys, '      + NL +
                  '       FLAG_MATRIX   = :FlagMatrix '   + NL +
                  ' where FK_LINGUAGENS = :FkLinguagens ' + NL +
                  '   and FK_MODULOS    = :FkModulos '    + NL +
                  '   and PK_RELATORIOS = :PkRelatorios';

  SqlDelReport  = 'delete from RELATORIOS '               + NL +
                  ' where FK_LINGUAGENS = :FkLinguagens ' + NL +
                  '   and FK_MODULOS    = :FkModulos '    + NL +
                  '   and PK_RELATORIOS = :PkRelatorios';

  SqlPrgReports = 'select Prg.DSC_PRG, Rel.DSC_REL, Rel.REL_SYS '    + NL +
                  '  from PROGRAMAS Prg, PROGRAMAS_RELATORIOS Prr, ' + NL +
                  '       RELATORIOS Rel '                           + NL +
                  ' where Prg.FK_MODULOS    = :FkModulos '           + NL +
                  '   and Prg.FK_ROTINAS    = :FkRotinas '           + NL +
                  '   and Prg.PK_PROGRAMAS  = :PkProgramas '         + NL +
                  '   and Prr.FK_MODULOS    = Prg.FK_MODULOS '       + NL +
                  '   and Prr.FK_ROTINAS    = Prg.FK_ROTINAS '       + NL +
                  '   and Prr.FK_PROGRAMAS  = Prg.PK_PROGRAMAS '     + NL +
                  '   and Rel.FK_LINGUAGENS = :FkLinguagens '        + NL +
                  '   and Rel.FK_MODULOS    = Prg.FK_MODULOS '       + NL +
                  '   and Rel.PK_RELATORIOS = Prr.FK_RELATORIOS '    + NL +
                  ' order by Rel.DSC_REL';

  SqlReport     = 'select * from RELATORIOS          ' + NL +
                  ' where FK_LINGUAGENS = :FkLinguagens ' + NL +
                  '   and FK_MODULOS    = :FkModulos ' + NL +
                  '   and PK_RELATORIOS = :PkRelatorios';

// Select SQL for the aux tables from other modules
  SqlModulos    = 'select * from MODULOS    order by DSC_MOD';

  SqlLinguagens = 'select * from LINGUAGENS order by DSC_LANG';

// Select SQL for the tables that be used for others functions
  SqlOpeAces    = 'Select * from Acessos where NOM_OPE = ''';

  SqlTitAces    = 'Select * from Titulo where NOM_FORM = ''';

  SqlGetReport  = 'select REL_SYS from RELATORIOS   ' + #13 +
                  ' where FK_LINGUAGENS = :Language ' + #13 +
                  '   and FK_MODULOS    = :Module   ' + #13 +
                  '   and PK_RELATORIOS = :Report   ';


implementation

end.
