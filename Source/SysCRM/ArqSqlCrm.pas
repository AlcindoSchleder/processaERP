unit ArqSqlCrm;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 03/06/2003 - DD/MM/YYYY                                      *}
{* Modified: 03/06/2003 - DD/MM/YYYY                                     *}
{* Version: 1.0.0.0                                                      *}
{* License: you can freely use and distribute the included code          *}
{*         for any purpouse, but you cannot remove this copyright        *}
{*         notice. Send me any comments and updates, they are really     *}
{*         appreciated. This software is licensed under MPL License,     *}
{*         see http://www.mozilla.org/MPL/ for details                   *}
{* Contact: (alcindo@sistemaprocessa.com.br)                             *}
{*         http://www.sistemaprocessa.com.br                             *}
{*                                                                       *}
{*************************************************************************}

interface

uses CmmConst;

resourcestring
// Sql's of this module
  SqlContactsUsr   = 'select Cad.*, Tal.DSC_ALIAS, Pais.DSC_PAIS, Est.DSC_UF, '        + NL +
                     '       Mun.DSC_MUN, Emp.PK_CADASTROS as FK_CONTACTS, '           + NL +
                     '       Emp.RAZ_SOC as NOM_EMP '                                  + NL +
                     '  from CADASTROS Cad '                                           + NL +
                     '  left outer join TIPO_ALIAS Tal '                               + NL +
                     '    on Tal.PK_TIPO_ALIAS = Cad.FK_TIPO_ALIAS '                   + NL +
                     '  join PAISES Pais '                                             + NL +
                     '    on Pais.PK_PAISES    = Cad.FK_PAISES '                       + NL +
                     '  join ESTADOS Est '                                             + NL +
                     '    on Est.FK_PAISES     = Cad.FK_PAISES '                       + NL +
                     '   and Est.PK_ESTADOS    = Cad.FK_ESTADOS '                      + NL +
                     '  join MUNICIPIOS Mun '                                          + NL +
                     '    on Mun.FK_PAISES     = Cad.FK_PAISES '                       + NL +
                     '   and Mun.FK_ESTADOS    = Cad.FK_ESTADOS '                      + NL +
                     '   and Mun.PK_MUNICIPIOS = Cad.FK_MUNICIPIOS '                   + NL +
                     '  join RECOURCES_X_CONTACTS Rxc '                                + NL +
                     '    on Rxc.FK_CADASTROS  = Cad.PK_CADASTROS '                    + NL +
                     '   and Rxc.FK_RESOURCES  = :FkResources '                        + NL +
                     '  left outer join CADASTROS Emp '                                + NL +
                     '    on Emp.PK_CADASTROS = Cad.FK_CONTATOS '                      + NL +
                     ' where Cad.PK_CADASTROS > 0 '                                    + NL +
                     ' order by Cad.RAZ_SOC';

  SqlContactsAll   = 'select Cad.*, Tal.DSC_ALIAS, Pais.DSC_PAIS, Est.DSC_UF, '        + NL +
                     '       Mun.DSC_MUN, Emp.PK_CADASTROS as FK_CONTACTS, '           + NL +
                     '       Emp.RAZ_SOC as NOM_EMP '                                  + NL +
                     '  from CADASTROS Cad '                                           + NL +
                     '  left outer join TIPO_ALIAS Tal '                               + NL +
                     '    on Tal.PK_TIPO_ALIAS = Cad.FK_TIPO_ALIAS '                   + NL +
                     '  join PAISES Pais '                                             + NL +
                     '    on Pais.PK_PAISES    = Cad.FK_PAISES '                       + NL +
                     '  join ESTADOS Est '                                             + NL +
                     '    on Est.FK_PAISES     = Cad.FK_PAISES '                       + NL +
                     '   and Est.PK_ESTADOS    = Cad.FK_ESTADOS '                      + NL +
                     '  join MUNICIPIOS Mun '                                          + NL +
                     '    on Mun.FK_PAISES     = Cad.FK_PAISES '                       + NL +
                     '   and Mun.FK_ESTADOS    = Cad.FK_ESTADOS '                      + NL +
                     '   and Mun.PK_MUNICIPIOS = Cad.FK_MUNICIPIOS '                   + NL +
                     '  left outer join CADASTROS Emp '                                + NL +
                     '    on Emp.PK_CADASTROS = Cad.FK_CONTATOS '                      + NL +
                     ' where Cad.PK_CADASTROS > 0 '                                    + NL +
                     ' order by Cad.RAZ_SOC';

  SqlCadEvents     = 'select * from CADASTROS_EVENTOS ' + NL +
                     ' where FK_CADASTROS = :FkCadastros';

  SqlDelEvents     = 'delete from CADASTROS_EVENTOS ' + NL +
                     ' where FK_CADASTROS = :FkCadastros';

  SqlInsEvents     = 'insert into CADASTROS_EVENTOS '                   + NL +
                     '  (FK_CADASTROS, PK_CADASTROS_EVENTOS, DSC_EVT, ' + NL +
                     '   FLAG_INC_EVT) '                                + NL +
                     'values '                                          + NL +
                     '  (:FkCadastros, :PkCadastrosEventos, :DscEvt, :FlagIncEvt)';

  SqlCadInternet   = 'select * from CADASTROS_INTERNET '     + NL +
                     ' where FK_CADASTROS  = :FkCadastros';

  SqlDelInternet   = 'delete from CADASTROS_INTERNET '     + NL +
                     ' where FK_CADASTROS  = :FkCadastros';

  SqlInsInternet   = 'insert into CADASTROS_INTERNET '                   + NL +
                     '  (FK_CADASTROS, PK_CADASTROS_INTERNET, END_CNT, ' + NL +
                     '   DSC_END, FLAG_TCNT_INT, FLAG_DEF) '             + NL +
                     'values '                                           + NL +
                     '  (:FkCadastros, :PkCadastrosInternet, :EndCnt, '  + NL +
                     '   :DscEnd, :FlagTCntInt, :FlagDef)';

  SqlCadContacts   = 'select * from CADASTROS_CONTATOS ' + NL +
                     ' where FK_CADASTROS = :FkCadastros';

  SqlDelCadCnt     = 'delete from CADASTROS_CONTATOS ' + NL +
                     ' where FK_CADASTROS = :FkCadastros';

  SqlInsCadCnt     = 'insert into CADASTROS_CONTATOS '                              + NL +
                     '  (FK_CADASTROS, PK_CADASTROS_CONTATOS, DSC_CNT, FLAG_MCNT) ' + NL +
                     'values '                                                      + NL +
                     '  (:FkCadastros, :PkCadastrosContatos, :DscCnt, :FlagMcnt)';

  SqlEvents        = 'select * from EVENTS '                      + NL +
                     ' where FK_RESOURCES  = :FkResources '       + NL +
                     '   and Cast(DTHR_INI as Date) >= :DthrIni ' + NL +
                     '   and Cast(DTHR_FIN as Date) <= :DthrFin ' + NL +
                     ' order by DTHR_INI ';

  SqlDeleteEvents  = 'delete from EVENTS '                 + NL +
                     ' where FK_RESOURCES = :FkResources ' + NL +
                     '   and PK_EVENTS    = :PkEvents ';

  SqlInsertEvents  = 'insert into EVENTS '                                         + NL +
                     '  (PK_EVENTS, FK_RESOURCES, DTHR_INI, DTHR_FIN, DSC_EVENT, ' + NL +
                     '   OBS_EVT, CTA_EVT, FLAG_ALLDAY, DING_PATH, FLAG_ALARM, '   + NL +
                     '   INTRV_ALARM, FLAG_TALARM, DTHR_RPT_EVT, FLAG_TREPEAT, '   + NL +
                     '   DTHR_RPD_FIM, INTRV_RPT) '                                + NL +
                     'values '                                                     + NL +
                     '  (:PkEvents, :FkResources, :DthrIni, :DthrFin, :DscEvent, ' + NL +
                     '   :ObsEvt, :CtaEvt, :FlagAllDay, :DingPath, :FlagAlarm, '   + NL +
                     '   :IntrvAlarm, :FlagTAlarm, :DthrRptEvt, :FlagTRepeat, '    + NL +
                     '   :DthrRpdFim, :IntrvRpt)';

  SqlUpdateEvents  = 'update EVENTS set '                    + NL +
                     '       DTHR_INI      = :DthrIni, '     + NL +
                     '       DTHR_FIN      = :DthrFin, '     + NL +
                     '       DSC_EVENT     = :DscEvent, '    + NL +
                     '       OBS_EVT       = :ObsEvt, '      + NL +
                     '       CTA_EVT       = :CtaEvt, '      + NL +
                     '       FLAG_ALLDAY   = :FlagAllDay, '  + NL +
                     '       DING_PATH     = :DingPath, '    + NL +
                     '       FLAG_ALARM    = :FlagAlarm, '   + NL +
                     '       INTRV_ALARM   = :IntrvAlarm, '  + NL +
                     '       FLAG_TALARM   = :FlagTAlarm, '  + NL +
                     '       DTHR_RPT_EVT  = :DthrRptEvt, '  + NL +
                     '       FLAG_TREPEAT  = :FlagTRepeat, ' + NL +
                     '       DTHR_RPD_FIM  = :DthrRpdFim, '  + NL +
                     '       INTRV_RPT     = :IntrvRpt'      + NL +
                     ' where PK_EVENTS     = :PkEvents '     + NL +
                     '   and FK_RESOURCES  = :FkResources';

  SqlTasks         = 'select * from TASKS '                 + NL +
                     ' where FK_RESOURCES = :FkResources '  + NL +
                     '   and DTA_CRTK    >= :DtaCrtkI '     + NL +
                     '   and DTA_CRTK    <= :DtaCrtkF '     + NL +
                     '   and ((FLAG_CMPL  = :FlagCmpl) '    + NL +
                     '    or ( -1         = :FlagCmpl)) '   + NL +
                     ' order by DTA_CRTK, FLAG_PRTY ';

  SqlDeleteTask    = 'delete from TASKS '                   + NL +
                     ' where FK_RESOURCES = :FkResources '  + NL +
                     '   and PK_TASKS     = :PkTasks';

  SqlInsertTask    = 'insert into TASKS '                              + NL +
                     '  (PK_TASKS, FK_RESOURCES, DSC_TASK, DET_TASK, ' + NL +
                     '   FLAG_CMPL, DTA_CRTK, FLAG_PRTY, CAT_TASK, '   + NL +
                     '   DTA_CMPL_TASK, DTHR_TASK) '                   + NL +
                     'values '                                         + NL +
                     '  (:PkTasks, :FkResources, :DscTask, :DetTask, ' + NL +
                     '   :FlagCmpl, :DtaCrtk, :FlagPrty, :CatTask, '   + NL +
                     '   :DtaCmplTask, :DthrTask)';

  SqlUpdateTask    = 'update TASKS set '                     + NL +
                     '       DSC_TASK      = :DscTask, '     + NL +
                     '       DET_TASK      = :DetTask, '     + NL +
                     '       FLAG_CMPL     = :FlagCmpl, '    + NL +
                     '       DTA_CRTK      = :DtaCrtk, '     + NL +
                     '       FLAG_PRTY     = :FlagPrty, '    + NL +
                     '       CAT_TASK      = :CatTask, '     + NL +
                     '       DTA_CMPL_TASK = :DtaCmplTask, ' + NL +
                     '       DTHR_TASK     = :DthrTask '     + NL +
                     ' where FK_RESOURCES  = :FkResources '  + NL +
                     '   and PK_TASKS      = :PkTasks';

  SqlResources     = 'select Res.PK_RESOURCES, Res.FK_OPERADORES, '       + NL +
                     '       Res.DSC_RES, Res.OBS_RES, Res.FLAG_ATV, '    + NL +
                     '       Res.OBS_USER, Res.FLAG_SUPER, Ope.SEN_NET, ' + NL +
                     '       Ope.FK_CADASTROS, Ope.EMAIL_OPE '            + NL +
                     '  from RESOURCES Res, OPERADORES Ope '              + NL +
                     ' where Ope.PK_OPERADORES = Res.FK_OPERADORES '      + NL +
                     ' order by Res.FK_OPERADORES';


  SqlResContact    = 'select Res.PK_RESOURCES, Res.FK_OPERADORES, '       + NL +
                     '       Res.DSC_RES, Res.FLAG_ATV, Res.FLAG_SUPER, ' + NL +
                     '       Rxc.FK_CADASTROS '                           + NL +
                     '  from RESOURCES Res '                              + NL +
                     '  left outer join RECOURCES_X_CONTACTS Rxc '        + NL +
                     '    on Rxc.FK_RESOURCES  = Res.PK_RESOURCES '       + NL +
                     '   and Rxc.FK_CADASTROS  = :FkCadastros '           + NL +
                     ' where Res.PK_RESOURCES > 0 '                       + NL +
                     ' order by Res.FK_OPERADORES';

  SqlDifResour     = 'select * from RESOURCES           ' + NL +
                     ' where FK_OPERADORES <> :Operador ' + NL +
                     ' order by FK_OPERADORES           ';

  SqlLoadKeys      = 'select Gen_Id(%s, 1) as %s from PARAMETRO_GLOBAIS';

  SqlAllResour     = 'select * from RESOURCES ' + NL +
                     ' order by FK_OPERADORES ';

  SqlGetCadastro   = 'select FK_CONTACTS from CONTACTS_VINC_CAD_CNT ' + NL +
                     ' where FK_CADASTROS = :Cadastro';

  SqlGetContato    = 'select FK_CONTACTS from CONTACTS_VINC_CAD_CNT ' + NL +
                     ' where FK_CADASTROS__CNT = :Cadastro          ' + NL +
                     '   and FK_CONTATOS       = :Contato';

  SqlPhoneList     = 'select Cad.RAZ_SOC, Ccn.FLAG_MCNT, Ccn.FLAG_DEF, Ccn.DSC_CNT ' + NL +
                     '  from CADASTROS Cad, CADASTROS_CONTATOS Ccn ' + NL +
                     ' where Cad.FK_CONTATOS  = :PkCadastros ' + NL +
                     '   and Ccn.FK_CADASTROS = Cad.PK_CADASTROS ' + NL +
                     ' order by Cad.RAZ_SOC, Ccn.DSC_CNT';

  SqlGenContact    = 'select R_STATUS from STP_GEN_CONTACT_FROM_CADASTRO' +
                     '(:PTipo, :PCad, :PCnt, :PUser)';

  SqlDelContacts   = 'delete from CADASTROS ' + NL +
                     ' where PK_CADASTROS  = :PkCadastros';

  SqlDelCategories = 'delete from VINCULOS_CAD_CAT '        + NL +
                     ' where FK_CADASTROS  = :FkCadastros';

  SqlDelCategory   = 'delete from VINCULOS_CAD_CAT '        + NL +
                     ' where FK_CADASTROS  = :FkCadastros ' + NL +
                     '   and FK_CATEGORIAS = :FkCategorias ';

  SqlInsCategory   = 'insert into VINCULOS_CAD_CAT '        + NL +
                     '  (FK_CADASTROS, FK_CATEGORIAS, FK_EMPRESAS, FLAG_ATV) ' + NL +
                     'values ' + NL +
                     '  (:FkCadastros, :FkCategorias, :FkEmpresas, :FlagAtv)';

  SqlUpdCategory   = 'update VINCULOS_CAD_CAT set '         + NL +
                     '       FLAG_ATV      = :FlagAtv) '    + NL +
                     ' where FK_CADASTROS  = :FkCadastros ' + NL +
                     '   and FK_CATEGORIAS = :FkCategorias ';

  SqlDelResLinks   = 'delete from RECOURCES_X_CONTACTS '        + NL +
                     ' where FK_CADASTROS  = :FkCadastros';

  SqlDelResLink    = 'delete from RECOURCES_X_CONTACTS '   + NL +
                     ' where FK_RESOURCES  = :FkResources' + NL +
                     '   and FK_CADASTROS  = :FkCadastros ';

  SqlInsResLink    = 'insert into RECOURCES_X_CONTACTS ' + NL +
                     '  (FK_CADASTROS, FK_RESOURCES) '   + NL +
                     'values '                           + NL +
                     '  (:FkCadastros, :FkResources)';

// Sql for tables of the other modules
  SqlPaises        = 'select * from PAISES ' + NL +
                     ' order by DSC_PAIS';

  SqlEstados       = 'select * from ESTADOS '        + NL +
                     ' where FK_PAISES = :FkPaises ' + NL +
                     ' order by DSC_UF';

  SqlMunicipios    = 'select * from MUNICIPIOS '       + NL +
                     ' where FK_PAISES  = :FkPaises  ' + NL +
                     '   and FK_ESTADOS = :FkEstados ' + NL +
                     ' order by DSC_MUN';

  SqlCadastros     = 'select Cad.RAZ_SOC, Cad.PK_CADASTROS ' + NL +
                     '  from CADASTROS Cad '                 + NL +
                     ' order by Cad.RAZ_SOC';

  SqlCompany       = 'select RAZ_SOC, PK_CADASTROS, FLAG_TCAD ' + NL +
                     '  from CADASTROS '                        + NL +
                     ' where FLAG_TCAD = 0 '                    + NL +
                     '   and FK_CONTATOS is null '              + NL +
                     ' order by RAZ_SOC';


  SqlCategorias    = 'select Cat.PK_CATEGORIAS, Cat.DSC_CAT, '       + NL +
                     '       Cat.FLAG_CAT, Vin.FK_CADASTROS, '       + NL +
                     '       Vin.FLAG_ATV '                          + NL +
                     '  from CATEGORIAS Cat '                        + NL +
                     '  left outer join VINCULOS_CAD_CAT Vin '       + NL +
                     '    on Vin.FK_CADASTROS  = :FkCadastros '      + NL +
                     '   and Vin.FK_CATEGORIAS = Cat.PK_CATEGORIAS ' + NL +
                     '  left outer join CADASTROS Cad '              + NL +
                     '    on Cad.PK_CADASTROS = Vin.FK_CADASTROS '   + NL +
                     ' where Cat.PK_CATEGORIAS > 0 '                 + NL +
                     ' order by DSC_CAT';

  SqlCadCategory   = 'select Cat.PK_CATEGORIAS, Cat.DSC_CAT, FLAG_CAT, ' + NL +
                     '       Vin.FK_CADASTROS, Vin.FLAG_ATV '            + NL +
                     '  from CADASTROS Cad, VINCULOS_CAD_CAT Vin, '      + NL +
                     '       CATEGORIAS Cat '                            + NL +
                     ' where Cad.PK_CADASTROS  = :PkCadastros '          + NL +
                     '   and Vin.FK_CADASTROS  = Cad.PK_CADASTROS '      + NL +
                     '   and Cat.PK_CATEGORIAS = Vin.FK_CATEGORIAS '     + NL +
                     ' order by DSC_CAT';

  SqlSelectAlias   = 'select PK_TIPO_ALIAS, DSC_ALIAS from TIPO_ALIAS order by DSC_ALIAS';

  SqlManagerAlias  = 'select R_STATUS, R_PK_TIPO_ALIAS ' + NL +
                     '  from STP_TYPE_ALIAS_MANAGER('   +
                            ':PkTipoAlias, :DscAlias, :FlagDel)';

var
  Variables: array of string;

implementation

end.
