unit ManArqSql;

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

resourcestring
// Generator SQL for the aux tables from this module
  SqlGenMessage  = 'select (Max(PK_MENSAGENS) + 1) as PK_MENSAGENS ' + NL +
                   '  from MENSAGENS ' + NL +
                   ' where FK_LINGUAGENS = :FkLinguagens';

  SqlGenTypeDoc  = 'select Gen_ID(TIPO_DOCUMENTOS, 1) as PK_TIPO_DOCUMENTOS ' + NL +
                   '  from PARAMETROS_GLOBAIS';

  SqlGenMasks    = 'select Gen_ID(MASCARAS, 1) as PK_MASCARAS ' + NL +
                   '  from PARAMETROS_GLOBAIS';

  SqlGenModule   = 'select (Max(PK_MODULOS) + 1) as PK_MODULOS ' + NL +
                   '  from MODULOS ' + NL +
                   ' where FK_LINGUAGENS = :FkLinguagens';

  SqlGenRotine   = 'select (Max(PK_ROTINAS) + 1) as PK_ROTINAS ' + NL +
                   '  from ROTINAS ' + NL +
                   ' where FK_LINGUAGENS = :FkLinguagens';

  SqlGenProgram  = 'select (Max(PK_PROGRAMAS) + 1) as PK_PROGRAMAS ' + NL +
                   '  from PROGRAMAS ' + NL +
                   ' where FK_LINGUAGENS = :FkLinguagens ' + NL +
                   '   and FK_MODULOS    = :FkModulos ' + NL +
                   '   and FK_ROTINAS    = :FkRotinas';

// Select SQL for the aux tables from this module
  SqlGlobalParams   = 'select * from PARAMETROS_GLOBAIS ' + NL +
                      ' where PK_PARAMETROS_GLOBAIS = :PkParametroGlobais';

  SqlInsertGlbPrms  = 'insert into PARAMETROS_GLOBAIS ' + NL +
                      '  (PK_PARAMETROS_GLOBAIS, FK_CLIENTES, DIAS_ATR, ' + NL +
                      '   PER_CVMED, QTD_DVMED, QTD_DCMED, QTD_DTOL, ' + NL +
                      '   NUM_CAS_DEC, NUM_CAS_DEC_QTD, FLAG_LAN_PARC, FLAG_MULTI) ' + NL +
                      'values ' + NL +
                      '  (:PkParametroGlobais, :FkClientes, :DiasAtr, ' + NL +
                      '   :PerCvMed, :QtdDvMed, :QtdDcMed, :QtdDTol, ' + NL +
                      '   :NumCasDec, :NumCasDecQtd, :FlagLanParc, :FlagMulti) ';

  SqlUpdateGlbPrms  = 'update PARAMETROS_GLOBAIS set ' + NL +
                      '       FK_CLIENTES     = :FkClientes, ' + NL +
                      '       NUM_CAS_DEC     = :NumCasDec, ' + NL +
                      '       NUM_CAS_DEC_QTD = :NumCasDecQtd, ' + NL +
                      '       DIAS_ATR        = :DiasAtr, ' + NL +
                      '       PER_CVMED       = :PerCvMed, ' + NL +
                      '       QTD_DVMED       = :QtdDvMed, ' + NL +
                      '       QTD_DCMED       = :QtdDcMed, ' + NL +
                      '       QTD_DTOL        = :QtdDTol, ' + NL +
                      '       FLAG_LAN_PARC   = :FlagLanParc, ' + NL +
                      '       FLAG_MULTI      = :FlagMulti ' + NL +
                      ' where PK_PARAMETROS_GLOBAIS = :PkParametroGlobais';

  SqlMensagens      = 'select Lng.PK_LINGUAGENS, Lng.DSC_LANG, Mod.PK_MODULOS, ' + NL +
                      '       Mod.DSC_MOD, Rot.PK_ROTINAS, Rot.DSC_ROT, ' + NL +
                      '       Prg.PK_PROGRAMAS, Prg.DSC_PRG, Prg.FLAG_REL, Msg.* ' + NL +
                      '  from MENSAGENS Msg ' + NL +
                      '  join LINGUAGENS Lng ' + NL +
                      '    on Lng.PK_LINGUAGENS = Msg.FK_LINGUAGENS ' + NL +
                      '       left outer join MODULOS Mod ' + NL +
                      '         on Mod.FK_LINGUAGENS = Lng.PK_LINGUAGENS ' + NL +
                      '        and Mod.PK_MODULOS    = Msg.FK_MODULOS ' + NL +
                      '       left outer join ROTINAS Rot ' + NL +
                      '         on Rot.FK_LINGUAGENS = Lng.PK_LINGUAGENS ' + NL +
                      '        and Rot.PK_ROTINAS    = Msg.FK_ROTINAS ' + NL +
                      '       left outer join PROGRAMAS Prg ' + NL +
                      '         on Prg.FK_LINGUAGENS = Lng.PK_LINGUAGENS ' + NL +
                      '        and Prg.FK_MODULOS    = Mod.PK_MODULOS ' + NL +
                      '        and Prg.FK_ROTINAS    = Rot.PK_ROTINAS ' + NL +
                      '        and Prg.PK_PROGRAMAS  = Msg.FK_PROGRAMAS ' + NL +
                      ' where Msg.PK_MENSAGENS > 0 ' + NL +
                      ' order by Mod.PK_MODULOS, Rot.PK_ROTINAS, Prg.PK_PROGRAMAS, ' + NL +
                      '          Msg.NOM_CNST';

  SqlMessage        = 'select * from MENSAGENS ' + NL +
                      ' where FK_LINGUAGENS = :FkLinguagens ' + NL +
                      '   and PK_MENSAGENS  = :PkMensagens';

  SqlDeleteMsg      = 'delete from MENSAGENS ' + NL +
                      ' where FK_LINGUAGENS = :FkLinguagens ' + NL +
                      '   and PK_MENSAGENS  = :PkMensagens';

  SqlInsertMsg      = 'delete from MENSAGENS ' + NL +
                      ' where FK_LINGUAGENS = :FkLinguagens ' + NL +
                      '   and PK_MENSAGENS  = :PkMensagens';

  SqlUpdateMsg      = 'delete from MENSAGENS ' + NL +
                      ' where FK_LINGUAGENS = :FkLinguagens ' + NL +
                      '   and PK_MENSAGENS  = :PkMensagens';

  SqlModulos        = 'select * from MODULOS '                + NL +
                      ' where FK_LINGUAGENS = :FkLinguagens ' + NL +
                      ' order by DSC_MOD';

  SqlModulo         = 'select * from MODULOS '                + NL +
                      ' where FK_LINGUAGENS = :FkLinguagens ' + NL +
                      '   and PK_MODULOS    = :PkModulos';

  SqlRotinas        = 'select * from ROTINAS '                + NL +
                      ' where FK_LINGUAGENS = :FkLinguagens ' + NL +
                      'order by DSC_ROT';

  SqlPrograma       = 'select * from PROGRAMAS '              + NL +
                      ' where FK_LINGUAGENS = :FkLinguagens ' + NL +
                      '   and FK_MODULOS    = :FkModulos '    + NL +
                      '   and FK_ROTINAS    = :FkRotinas '    + NL +
                      '   and PK_PROGRAMAS  = :FkProgramas '  + NL +
                      ' order by DSC_PRG';

  SqlProgramas      = 'select * from PROGRAMAS '              + NL +
                      ' where FK_LINGUAGENS = :FkLinguagens ' + NL +
                      '   and FK_MODULOS    = :FkModulos '    + NL +
                      '   and FK_ROTINAS    = :FkRotinas '    + NL +
                      ' order by DSC_PRG';

  SqlRelatorio      = 'select * from RELATORIOS '             + NL +
                      ' where FK_LINGUAGENS = :FkLinguagens ' + NL +
                      '   and FK_MODULOS    = :FkModulos '    + NL +
                      ' order by DSC_REL';

  SqlTipoPedidos    = 'select * from TIPO_STATUS_PEDIDOS order by DSC_STT';

  SqlDivisoes       = 'select PK_DIVISOES, DSC_DIV, SQL_DIV from DIVISOES ' + NL +
                      ' where FK_TIPO_DOCUMENTOS = :Tipo  ' + NL +
                      ' order by NIV_DIV, DSC_DIV';

  SqlSelTables      = 'select RDB$RELATION_NAME as TABLES from RDB$RELATIONS ' + NL +
                      ' where RDB$SYSTEM_FLAG = 0 order by RDB$RELATION_NAME';

  SelectFields      = 'select RDB$FIELD_NAME as FIELDS       ' + NL +
                      '  from RDB$RELATION_FIELDS            ' + NL +
                      ' where RDB$RELATION_NAME = :NameFile  ' + NL +
                      '   and RDB$SYSTEM_FLAG   = 0          ' + NL +
                      '   and RDB$FIELD_NAME not in          ' + NL +
                      '       (select PK_DICIONARIOS__NC     ' + NL +
                      '          from DICIONARIOS            ' + NL +
                      '         where PK_DICIONARIOS__NA = :NameTab) ' + NL +
                      ' order by RDB$FIELD_NAME';

  SqlLinguagens     = 'select PK_LINGUAGENS, DSC_LANG from LINGUAGENS order by DSC_LANG';

  SqlLinguagem      = 'select DSC_LANG from LINGUAGENS ' + NL +
                      ' where PK_LINGUAGENS = :PkLinguagens';

  SqlMascaras       = 'select DSC_MSK, MSK_MSK from MASCARAS order by DSC_MSK';

  SqlMascara        = 'select * from MASCARAS ' + NL +
                      ' where FK_LINGUAGENS = :FkLinguagens ' + NL +
                      '   and PK_MASCARAS   = :PkMascaras';

  SqlDeleteMask     = 'delete from MASCARAS ' + NL +
                      ' where FK_LINGUAGENS = :FkLinguagens ' + NL +
                      '   and PK_MASCARAS   = :PkMascaras';

  SqlUpdateMask     = 'update MASCARAS set ' + NL +
                      '       DSC_MSK       = :DscMsk, ' + NL +
                      '       MSK_MSK       = :MskMsk ' + NL +
                      ' where FK_LINGUAGENS = :FkLinguagens ' + NL +
                      '   and PK_MASCARAS   = :PkMascaras';

  SqlInsertMask     = 'insert into MASCARAS ' + NL +
                      '  (FK_LINGUAGENS, PK_MASCARAS, DSC_MSK, MSK_MSK) ' + NL +
                      'values ' + NL +
                      '  (:FkLinguagens, :PkMascaras, :DscMsk, :MskMsk)';

  SqlAllMaskData    = 'select Lng.PK_LINGUAGENS, Lng.DSC_LANG, Msk.* ' + NL +
                      '  from LINGUAGENS Lng ' + NL +
                      '  left outer join MASCARAS Msk ' + NL +
                      '    on Msk.FK_LINGUAGENS = Lng.PK_LINGUAGENS ' + NL +
                      ' where Lng.PK_LINGUAGENS > '''' ' + NL +
                      ' order by DSC_LANG, DSC_MSK';

  SqlCampoFields    = 'select Div.DSC_DIV, Cmp.LIN_IMP, Cmp.COL_IMP, '          + NL +
                      '       Cmp.DSC_CMP, Cmp.FK_EMPRESAS, Cmp.FK_DIVISOES, '  + NL +
                      '       Cmp.FK_TIPO_DOCUMENTOS, Cmp.PK_CAMPOS '           + NL +
                      '  from DIVISOES Div, CAMPOS Cmp '                        + NL +
                      ' where Div.FK_EMPRESAS        = :FkEmpresas '            + NL +
                      '   and Div.FK_TIPO_DOCUMENTOS = :FkTipoDocumentos '      + NL +
                      '   and Cmp.FK_EMPRESAS        = Div.FK_EMPRESAS '        + NL +
                      '   and Cmp.FK_TIPO_DOCUMENTOS = Div.FK_TIPO_DOCUMENTOS ' + NL +
                      '   and Cmp.FK_DIVISOES        = Div.PK_DIVISOES '        + NL +
                      ' order by Div.NIV_DIV, Cmp.LIN_IMP, Cmp.COL_IMP';

  SqlDeleteCampos   = 'delete from CAMPOS '                            + NL +
                      ' where FK_EMPRESAS        = :FkEmpresas '       + NL +
                      '   and FK_TIPO_DOCUMENTOS = :FkTipoDocumentos ' + NL +
                      '   and FK_DIVISOES        = :FkDivisoes ';

  SqlInsertCampos   = 'insert into CAMPOS '                              + NL +
                      ' (FK_EMPRESAS, FK_TIPO_DOCUMENTOS, FK_DIVISOES, ' + NL +
                      '  PK_CAMPOS, DSC_CMP, CMP_CMP) '                  + NL +
                      'values '                                          + NL +
                      ' (:FkEmpresas, :FkTipoDocumentos, :FkDivisoes, '  + NL +
                      '  :PkCampos, :DscCmp, :CmpCmp) ';

  SqlTipoDocumentos = 'select * from TIPO_DOCUMENTOS order by DSC_TDOC';

  SqlAllTypeDocs    = 'select PK_TIPO_DOCUMENTOS, DSC_TDOC ' + NL +
                      ' from TIPO_DOCUMENTOS ' + NL +
                      ' order by DSC_TDOC';

  SqlTipoDocumento  = 'select * from TIPO_DOCUMENTOS ' + NL +
                      ' where PK_TIPO_DOCUMENTOS = :PkTipoDocumentos';

  SqlDeleteTypeDoc  = 'delete from TIPO_DOCUMENTOS ' + NL +
                      ' where PK_TIPO_DOCUMENTOS = :PkTipoDocumentos';

  SqlTDocNumbers    = 'select Emp.RAZ_SOC, Cast(3 as integer) as STATUS, Tdn.* ' + NL +
                      '  from EMPRESAS Emp ' + NL +
                      '  left outer join TIPO_DOCUMENTOS_NUMERACAO Tdn ' + NL +
                      '    on Tdn.FK_EMPRESAS        = Emp.PK_EMPRESAS ' + NL +
                      '   and Tdn.FK_TIPO_DOCUMENTOS = :FkTipoDocumentos ' + NL +
                      ' where PK_EMPRESAS > 0 ' + NL +
                      ' order by Emp.RAZ_SOC';

  SqlCampos         = 'select FK_TIPO_DOCUMENTOS, FK_DIVISOES, PK_CAMPOS ' + NL +
                      '  from CAMPOS where PK_CAMPOS = :Campo';

  SqlCamposDiv      = 'select Cmp.PK_CAMPOS, Cmp.DSC_CMP, Cmp.CMP_CMP,' + NL +
                      '       Cmp.FK_DIVISOES, Div.DSC_DIV, Div.NIV_DIV ' + NL +
                      '  from CAMPOS Cmp, DIVISOES Div              ' + NL +
                      ' where Div.PK_DIVISOES = Cmp.FK_DIVISOES     ' + NL +
                      ' order by Div.NIV_DIV, Cmp.DSC_CMP';

  SqlCamposSel      = 'select Cmp.PK_CAMPOS, Cmp.DSC_CMP, Cmp.CMP_CMP, ' + NL +
                      '       Cmp.FK_DIVISOES, Div.DSC_DIV, Div.NIV_DIV  ' + NL +
                      '  from CAMPOS Cmp, DIVISOES Div               ' + NL +
                      ' where Div.PK_DIVISOES = Cmp.FK_DIVISOES  and       ' + NL +
                      '       Cmp.PK_CAMPOS in                       ' + NL +
                      ' (select PK_CAMPOS from LAYOUTS               ' + NL +
                      '   where FK_DIVISOES   = Cmp.FK_DIVISOES)     ' + NL +
                      ' order by Div.NIV_DIV, Cmp.DSC_CMP';

  SqlParamPrg       = 'select * from PARAMETROS_PRG  '      + NL +
                      ' where FK_MODULOS   = :FkModulos '   + NL +
                      '   and FK_ROTINAS   = :FkRotinas '   + NL +
                      '   and FK_PROGRAMAS = :FkProgramas ' + NL +
                      ' order by DSC_PARAM';

  SqlVersoes        = 'select * from DATABASE_VERSION order by NAME_DB';

  SqlOperators      = 'select * from OPERADORES order by PK_OPERADORES';

  SqlLinkModVer     = 'select Cast(Mod.PK_MODULOS as VARCHAR(03)) || ''-'' || ' + NL +
                      '       Cast(Mod.DSC_MOD as VARCHAR(50)) as MODULO,     ' + NL +
                      '       Mod.VERSAO as OLD_VERSION, Vsm.VER_1, Vsm.VER_2,' + NL +
                      '       Vsm.VER_3, Vsm.VER_4, Vsm.VERSAO as NEW_VERSION,' + NL +
                      '       Mod.PK_MODULOS                                  ' + NL +
                      '  from MODULOS Mod                                     ' + NL +
                      '  left outer join VINCULO_SCR_MOD Vsm                  ' + NL +
                      '    on Vsm.FK_DATABASE_VERSION = :System               ' + NL +
                      '   and Vsm.FK_MODULOS          = Mod.PK_MODULOS        ' + NL +
                      ' where Mod.FK_LINGUAGENS = :Linguagem                  ' + NL +
                      ' order by Mod.PK_MODULOS                               ';

  SqlModulosVer     = 'select Cast(PK_MODULOS as VARCHAR(03)) || ''-'' || ' + NL +
                      '       Cast(DSC_MOD as VARCHAR(50)) as MODULO,     ' + NL +
                      '       VERSAO, VER_1, VER_2, VER_3,                ' + NL +
                      '       VER_4, PK_MODULOS                           ' + NL +
                      '  from MODULOS                                     ' + NL +
                      ' where FK_LINGUAGENS = :Linguagem                  ' + NL +
                      ' order by PK_MODULOS                               ';

  SqlLocModVer      = 'select FK_DATABASE_VERSION, FK_SCRIPTS_DB ' + NL +
                      '  from VINCULO_SCR_MOD                    ' + NL +
                      ' where FK_DATABASE_VERSION = :System      ' + NL +
                      '   and FK_SCRIPTS_DB       = :Script      ' + NL +
                      '   and FK_MODULOS          = :Module      ';

  SqlAcessos        = 'select Mod.DSC_MOD, Ace.FLAG_VIS, Ace.FLAG_BRW, '   + NL +
                      '       Ace.FLAG_FND, Ace.FLAG_INS, Ace.FLAG_DEL, '  + NL +
                      '       Ace.FLAG_UPD, Rot.DSC_ROT, Prg.DSC_PRG, '    + NL +
                      '       Mod.PK_MODULOS, Rot.PK_ROTINAS, Prg.FLAG_REL, ' + NL +
                      '       Prg.FLAG_VIS as PRG_VIS, Prg.PK_PROGRAMAS, ' + NL +
                      '       Ace.FK_OPERADORES, Ace.PK_ACESSOS '          + NL +
                      '  from PROGRAMAS Prg '                              + NL +
                      '  join MODULOS Mod '                                + NL +
                      '    on Mod.PK_MODULOS     = Prg.FK_MODULOS '        + NL +
                      '   and Mod.FK_LINGUAGENS  = Prg.FK_LINGUAGENS '     + NL +
                      '  join ROTINAS Rot '                                + NL +
                      '    on Rot.PK_ROTINAS     = Prg.FK_ROTINAS '        + NL +
                      '   and Rot.FK_LINGUAGENS  = Prg.FK_LINGUAGENS '     + NL +
                      '  left outer join ACESSOS Ace '                     + NL +
                      '    on Ace.FK_MODULOS     = Prg.FK_MODULOS '        + NL +
                      '   and Ace.FK_ROTINAS     = Prg.FK_ROTINAS '        + NL +
                      '   and Ace.FK_PROGRAMAS   = Prg.PK_PROGRAMAS '      + NL +
                      '   and Ace.FK_OPERADORES  = :FkOperadores ';
  SqlAcessosWhr     = ' where Prg.FK_LINGUAGENS  = :FkLinguagens '         + NL +
                      ' order by Mod.DSC_MOD, Rot.DSC_ROT, Prg.DSC_PRG ';

  SqlInsertAcessos  = 'insert into ACESSOS '                        + NL +
                      '  (FK_MODULOS, FK_ROTINAS, FK_PROGRAMAS, '   + NL +
                      '   FK_OPERADORES, PK_ACESSOS, FLAG_BRW, '    + NL +
                      '   FLAG_FND, FLAG_INS, FLAG_DEL, FLAG_UPD, ' + NL +
                      '   FLAG_VIS) '                               + NL +
                      'values '                                     + NL +
                      '  (:FkModulos, :FkRotinas, :FkProgramas, '   + NL +
                      '   :FkOperadores, :PkAcessos, :FlagBrw, '    + NL +
                      '   :FlagFnd, :FlagIns, :FlagDel, :FlagUpd, ' + NL +
                      '   :FlagVis)';

  SqlUpdateAcessos  = 'update ACESSOS set '                   + NL +
                      '       FK_MODULOS    = :FkModulos, '   + NL +
                      '       FK_ROTINAS    = :FkRotinas, '   + NL +
                      '       FK_PROGRAMAS  = :FkProgramas, ' + NL +
                      '       FLAG_BRW      = :FlagBrw, '     + NL +
                      '       FLAG_FND      = :FlagFnd, '     + NL +
                      '       FLAG_INS      = :FlagIns, '     + NL +
                      '       FLAG_UPD      = :FlagUpd, '     + NL +
                      '       FLAG_DEL      = :FlagDel, '     + NL +
                      '       FLAG_VIS      = :FlagVis '      + NL +
                      ' where FK_OPERADORES = :FkOperadores ' + NL +
                      '   and PK_ACESSOS    = :PkAcessos';

  SqlDeleteAcessos  = 'delete from ACESSOS '                  + NL +
                      ' where FK_OPERADORES = :FkOperadores ' + NL +
                      '   and PK_ACESSOS    = :PkAcessos';

  SqlDelOperator    = 'delete from OPERADORES ' + NL +
                      ' where PK_OPERADORES = :PkOperadores';

  SqlValorCampos    = 'select CMP_VAL, DSC_VAL from VALOR_CAMPOS '    + NL +
                      ' where FK_LINGUAGENS      = :fklinguagens '    + NL +
                      '   and FK_DICIONARIOS__NA = :fkdicionariosna ' + NL +
                      '   and FK_DICIONARIOS__NC = :fkdicionariosnc ' + NL +
                      ' order by CMP_VAL ';

  SqlDeleteValorCampos = 'delete from VALOR_CAMPOS '                     + NL +
                         ' where FK_LINGUAGENS      = :fklinguagens '    + NL +
                         '   and FK_DICIONARIOS__NA = :fkdicionariosna ' + NL +
                         '   and FK_DICIONARIOS__NC = :fkdicionariosnc ';

  SqlInsertValorCampos = 'insert into VALOR_CAMPOS '                + NL +
                         '  (FK_LINGUAGENS, FK_DICIONARIOS__NA, '   + NL +
                         '   FK_DICIONARIOS__NC, PK_VALOR_CAMPOS, ' + NL +
                         '   CMP_VAL, DSC_VAL) '                    + NL +
                         'values '                                  + NL +
                         '  (:fklinguagens, :fkdicionariosna, '     + NL +
                         '   :fkdicionariosnc, :pkvalorcampos, '    + NL +
                         '   :cmpval, :dscval)';

  SqlAllPrograms    = 'select Lng.PK_LINGUAGENS, Lng.DSC_LANG, Mod.PK_MODULOS, ' + NL +
                      '       Mod.DSC_MOD, Mod.VERSAO, Mod.VER_1, VER_2, VER_3, ' + NL +
                      '       VER_4, Rot.PK_ROTINAS, Rot.DSC_ROT, Prg.DSC_PRG, ' + NL +
                      '       Prg.PK_PROGRAMAS, Prg.FK_RELATORIOS, Prg.NOM_LIB, ' + NL +
                      '       Prg.FLAG_VIS, Prg.FLAG_REL, Prg.NOM_FRM, ' + NL +
                      '       Prg.QTD_PARAM ' + NL +
                      '  from LINGUAGENS Lng ' + NL +
                      '  left outer join MODULOS Mod ' + NL +
                      '    on Mod.FK_LINGUAGENS = Lng.PK_LINGUAGENS ' + NL +
                      '   and Mod.PK_MODULOS    > 0 ' + NL +
                      '  left outer join ROTINAS Rot ' + NL +
                      '    on Rot.FK_LINGUAGENS = Lng.PK_LINGUAGENS ' + NL +
                      '  left outer join PROGRAMAS Prg ' + NL +
                      '    on Prg.FK_LINGUAGENS = Lng.PK_LINGUAGENS ' + NL +
                      '   and Prg.FK_MODULOS = Mod.PK_MODULOS ' + NL +
                      '   and Prg.FK_ROTINAS = Rot.PK_ROTINAS ' + NL +
                      ' where Lng.PK_LINGUAGENS is not null ' + NL +
                      ' order by Lng.PK_LINGUAGENS, Mod.DSC_MOD, ' + NL +
                      '       Rot.DSC_ROT, Prg.DSC_PRG';

  SqlDelProgram     = 'delete from PROGRAMAS  '           + NL +
                      ' where FK_LINGUAGENS = :FkLinguagens ' + NL +
                      '   and FK_MODULOS   = :FkModulos ' + NL +
                      '   and FK_ROTINAS   = :FkRotinas ' + NL +
                      '   and PK_PROGRAMAS = :PkProgramas ';

  SqlInsProgram     = 'insert into PROGRAMAS '                     + NL +
                      '  (FK_MODULOS, FK_ROTINAS, PK_PROGRAMAS, '  + NL +
                      '   FK_LINGUAGENS, DSC_PRG, NOM_LIB, '       + NL +
                      '   FLAG_VIS, FLAG_REL, NOM_FRM, QTD_PARAM, '+ NL +
                      '   FK_RELATORIOS) '                         + NL +
                      'values '                                    + NL +
                      '  (:FkModulos, :FkRotinas, :PkProgramas, '  + NL +
                      '   :FkLinguagens, :DscPrg, :NomLib, '       + NL +
                      '   :FlagVis, :FlagRel, :NomFrm, :QtdParam, '+ NL +
                      '   :FkRelatorios) ';

  SqlUpdProgram     = 'update PROGRAMAS set '                 + NL +
                      '       DSC_PRG       = :DscPrg, '      + NL +
                      '       NOM_LIB       = :NomLib, '      + NL +
                      '       FLAG_VIS      = :FlagVis, '     + NL +
                      '       FLAG_REL      = :FlagRel, '     + NL +
                      '       NOM_FRM       = :NomFrm, '      + NL +
                      '       QTD_PARAM     = :QtdParam, '    + NL +
                      '       FK_RELATORIOS = :FkRelatorios ' + NL +
                      ' where FK_LINGUAGENS = :FkLinguagens ' + NL +
                      '   and FK_MODULOS    = :FkModulos '    + NL +
                      '   and FK_ROTINAS    = :FkRotinas '    + NL +
                      '   and PK_PROGRAMAS  = :PkProgramas ';

  SqlInsProgramParam = 'insert into PARAMETROS_PRG '                 + NL +
                       '  (FK_MODULOS, FK_ROTINAS, FK_PROGRAMAS, '   + NL +
                       '   PK_PARAMETROS_PRG, DSC_PARAM, NOM_PROP, ' + NL +
                       '   VAL_PROP) '                               + NL +
                       'values '                                     + NL +
                       '  (:FkModulos, :FkRotinas, :FkProgramas, '   + NL +
                       '   :PkParametrosPrg, :DscParam, :NomProp, '  + NL +
                       '   :ValProp)';

  SqlDelProgramParam = 'delete from PARAMETROS_PRG  '        + NL +
                       ' where FK_MODULOS   = :FkModulos '   + NL +
                       '   and FK_ROTINAS   = :FkRotinas '   + NL +
                       '   and FK_PROGRAMAS = :FkProgramas ';

  SqlInsLanguage    = 'insert into LINGUAGENS ' + NL +
                      '  (PK_LINGUAGENS, DSC_LANG) ' + NL +
                      'values ' + NL +
                      '  (:PkLinguagens, :DscLang)';

  SqlUpdLanguage    = 'update LINGUAGENS set ' + NL +
                      '       PK_LINGUAGENS = :PkLinguagens, ' + NL +
                      '       DSC_LANG      = :DscLang ' + NL +
                      ' where PK_LINGUAGENS = :OldPkLinguagens ';

  SqlDelLanguage    = 'delete from LINGUAGENS ' + NL +
                      ' where PK_LINGUAGENS = :PkLinguagens';

  SqlInsModule      = 'insert into MODULOS ' + NL +
                      '  (FK_LINGUAGENS, PK_MODULOS, DSC_MOD, VER_1, VER_2, ' + NL +
                      '   VER_3, VER_4, VERSAO) ' + NL +
                      'values ' + NL +
                      '  (:FkLinguagens, :PkModulos, :DscMod, :Ver1, :Ver2, ' + NL +
                      '   :Ver3, :Ver4, :Versao)';

  SqlUpdModule      = 'update MODULOS set ' + NL +
                      '       PK_MODULOS    = :PkModulos, ' + NL +
                      '       FK_LINGUAGENS = :FkLinguagens, ' + NL +
                      '       DSC_MOD       = :DscMod, ' + NL +
                      '       VER_1         = :Ver1, ' + NL +
                      '       VER_2         = :Ver2, ' + NL +
                      '       VER_3         = :Ver3, ' + NL +
                      '       VER_4         = :Ver4, ' + NL +
                      '       VERSAO        = :Versao ' + NL +
                      ' where PK_MODULOS    = :OldPkModulos ' + NL +
                      '   and FK_LINGUAGENS = :OldFkLinguagens';

  SqlDelModule      = 'delete from MODULOS ' + NL +
                      ' where PK_MODULOS    = :PkModulos ' + NL +
                      '   and FK_LINGUAGENS = :FkLinguagens';

  SqlInsRotine      = 'insert into ROTINAS ' + NL +
                      '  (PK_ROTINAS, DSC_ROT) ' + NL +
                      'values ' + NL +
                      '  (:PkRotinas, :DscRot)';

  SqlUpdRotine      = 'update ROTINAS set ' + NL +
                      '       DSC_ROT       = :DscRot ' + NL +
                      ' where PK_ROTINAS    = :PkRotinas ' + NL +
                      '   and FK_LINGUAGENS = :FkLinguagens';

  SqlDelRotine      = 'delete from ROTINAS ' + NL +
                      ' where PK_ROTINAS    = :PkRotinas ' + NL +
                      '   and FK_LINGUAGENS = :FkLinguagens';

  SqlParametros     = 'select * from PARAMETROS ' + NL +
                      ' where FK_EMPRESAS = :FkEmpresas';

 // Select SQL for the aux tables from other modules
  SqlRealClients    = 'select * from VW_CLIENTES ' + NL +
                      ' where FK_CADASTROS is not null ' + NL +
                      ' order by RAZ_SOC';

  SqlCenaries     = 'select * from CENARIOS_FINANCEIROS ' + NL +
                    ' where ((FLAG_TPCEN = :FlagTpCen) ' + NL +
                    '    or (-1          = :FlagTpCen)) ' + NL +
                    ' order by DSC_CEN';

  SqlMoedas       = 'select * from TIPO_MOEDAS order by DSC_MD';

  SqlPaises       = 'select * from PAISES  order by DSC_PAIS';

  SqlEstados      = 'select *  from ESTADOS   ' + NL +
                    ' where FK_PAISES = :FkPaises ' + NL +
                    ' order by DSC_UF';

  SqlMunicipio    = 'select * from MUNICIPIOS '       + NL +
                    ' where FK_PAISES  = :FkPaises '  + NL +
                    '   and FK_ESTADOS = :FkEstados ' + NL +
                    ' order by DSC_MUN';

  SqlTipoEnd      = 'select * from TIPO_ENDERECOS order by DSC_TPE';

  SqlParcela      = 'select * from TIPO_PAGAMENTOS order by DSC_TPG';

  SqlBancos       = 'select * from BANCOS  order by DSC_BCO';

  SqlCategoria    = 'select * from CATEGORIAS order by DSC_CAT';

  SqlTipoMovto    = 'select * from GRUPOS_MOVIMENTOS  ' + NL +
                    ' where FLAG_ES = :Tipo order by DSC_GMOV';

var
  Variables: array of string;

implementation

end.
