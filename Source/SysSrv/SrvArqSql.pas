unit SrvArqSql;

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
  // Sql Instructions for this module

  SqlGetKeyForRodov  = 'select R_PK_RODOVIAS ' + NL +
                       '  from STP_GET_KEY_FOR_RODOVIAS(:FkEmpresas)';

  SqlGetKeyForPraca  = 'select R_PK_PRACAS ' + #13 +
                       '  from STP_GET_KEY_FOR_PRACAS(:FkEmpresas)';

  SqlGetKcLimites    = 'select R_PK_LIMITES_MUNICIPIOS ' + NL +
                       '  from STP_GET_KC_LIMITES_MUNICIPIOS(:FkEmpresas, :FkRodovias)';

  SqlGetKcTipoStatus = 'select R_PK_LIMITES_MUNICIPIOS ' + NL +
                       '  from STP_GET_KC_LIMITES_MUNICIPIOS(:FkEmpresas, :FkRodovias)';

  SqlRodovias        = 'select * from RODOVIAS '           + NL +
                       ' where FK_EMPRESAS = :FkEmpresas ' + NL +
                       ' order by DSC_ROD';

  SqlPracas          = 'select * from PRACAS ' + NL +
                       ' where FK_EMPRESAS = :FkEmpresas ' + NL +
                       ' order by DSC_PRC';

  SqlTiposOS         = 'select Tos.PK_TIPO_ORDENS_SERVICOS, Tos.FLAG_TOS, Gmv.FLAG_ES, ' + NL +
                       '       Gmv.FLAG_COD, Gmv.FLAG_GFIN, Tmv.PK_TIPO_MOVIMENTOS, '    + NL +
                       '       Tmv.FLAG_CNS, Tos.FK_TIPO_DOCUMENTOS, Tmv.FLAG_LDV, '     + NL +
                       '       Tos.DSC_TOS || '' ==> '' ||Tmv.DSC_TMOV as DSC_TOS, '     + NL +
                       '       Gmv.PK_GRUPOS_MOVIMENTOS '                                + NL +
                       '  from grupos_movimentos Gmv, tipo_movimentos Tmv, '             + NL +
                       '       tipo_ordens_servicos Tos '                                + NL +
                       ' where Tmv.FK_GRUPOS_MOVIMENTOS = Gmv.PK_GRUPOS_MOVIMENTOS '     + NL +
                       '   and Tos.FK_GRUPOS_MOVIMENTOS = Gmv.PK_GRUPOS_MOVIMENTOS '     + NL +
                       ' order by Tos.DSC_TOS, Tmv.DSC_TMOV';

  SqlStatusOS        = 'select * from TIPO_STATUS_OS ' + NL +
                       ' order by DSC_STT';

  SqlGetKcOS         = 'select R_PK_ORDENS_SERVICOS ' + NL +
                       '  from STP_GET_PK_ORDENS_SERVICOS(:FkEmpresas, :FkTipoDocumentos)';

  SqlUpdateStatusOS  = 'update ORDENS_SERVICOS set '                  + NL +
                       '       FK_TIPO_STATUS_OS  = :FkTipoStatusOS ' + NL +
                       ' where FK_EMPRESAS        = :FkEmpresas '     + NL +
                       '   and PK_ORDENS_SERVICOS = :PkOrdensServicos';

  SqlServiceOrder    = 'select Ors.*, Tpg.DSC_TPG, Tos.FLAG_TOS '                + NL +
                       '  from ORDENS_SERVICOS Ors '                             + NL +
                       '  left outer join TIPO_PAGAMENTOS Tpg '                  + NL +
                       '    on Tpg.PK_TIPO_PAGAMENTOS = Ors.FK_TIPO_PAGAMENTOS ' + NL +
                       '  left outer join TIPO_ORDENS_SERVICOS Tos '             + NL +
                       '    on Tos.PK_TIPO_ORDENS_SERVICOS = Ors.FK_TIPO_ORDENS_SERVICOS ' + NL +
                       ' where Ors.FK_EMPRESAS        = :FkEmpresas '            + NL +
                       '   and Ors.PK_ORDENS_SERVICOS = :PkOrdensServicos';

  SqlServiceOrderItm = 'select Osi.PK_ORDENS_SERVICOS_ITENS, Prd.DSC_PROD, '     + NL +
                       '       Osi.VLR_UNIT, Osi.TOT_SRV, Osi.QTD_SRV, '         + NL +
                       '       Osl.LOC_INI, Osl.LOC_FIN, Osi.DTA_FAT, '          + NL +
                       '       Osi.FK_PRODUTOS_SERVICOS, Osi.FK_CLASSIFICACAO, ' + NL +
                       '       Osi.FLAG_PERS, Osl.FLAG_SIDE, Osi.FLAG_TQTD, '    + NL +
                       '       Osi.LARG_SRV, Osi.ALT_SRV, Osi.COMP_SRV '         + NL +
                       '  from ORDENS_SERVICOS_ITENS Osi '                                   + NL +
                       '  left outer join PRODUTOS Prd '                                     + NL +
                       '    on Prd.PK_PRODUTOS              = Osi.FK_PRODUTOS_SERVICOS '     + NL +
                       '  left outer join ORDENS_SERVICOS_ITENS_LOCAL Osl '                  + NL +
                       '    on Osl.FK_EMPRESAS              = Osi.FK_EMPRESAS '              + NL +
                       '   and Osl.FK_ORDENS_SERVICOS       = Osi.FK_ORDENS_SERVICOS '       + NL +
                       '   and Osl.FK_ORDENS_SERVICOS_ITENS = Osi.PK_ORDENS_SERVICOS_ITENS ' + NL +
                       ' where Osi.FK_EMPRESAS              = :FkEmpresas '                  + NL +
                       '   and Osi.FK_ORDENS_SERVICOS       = :FkOrdensServicos '            + NL +
                       ' order by Osi.FK_EMPRESAS, Osi.FK_ORDENS_SERVICOS, '                 + NL +
                       '          Osi.PK_ORDENS_SERVICOS_ITENS';

  SqlOSItemsInsumos1 = 'select distinct Oin.SEQ_ITEM, Prd.DSC_PROD, '              + NL +
                       '       Oin.ALT_INS, Oin.LARG_INS, Oin.COMP_INS, '          + NL +
                       '       Oin.FK_INSUMO,  Oin.FLAG_TINS, Oin.QTD_INS, '       + NL +
                       '       Oin.FLAG_FRN, Oin.FLAG_TQTD, Oin.VLR_UNIT '          + NL +
                       '  from ORDENS_SERVICOS_ITENS_INSUMO Oin '                  + NL +
                       '  left outer join ORDENS_SERVICOS_ITENS Oit '              + NL +
                       '    on Oit.FK_EMPRESAS         = Oin.FK_EMPRESAS '         + NL +
                       '   and Oit.FK_ORDENS_SERVICOS  = Oin.FK_ORDENS_SERVICOS '  + NL +
                       '   and Oit.PK_ORDENS_SERVICOS_ITENS = Oin.FK_OS_ITENS '    + NL +
                       '  left outer join PRODUTOS Prd '                           + NL +
                       '    on Prd.PK_PRODUTOS         = Oin.FK_INSUMO '           + NL +
                       ' where Oin.FK_EMPRESAS         = :FkEmpresas '             + NL +
                       '   and Oin.FK_ORDENS_SERVICOS  = :FkOrdensServicos '       + NL +
                       '   and Oin.FK_OS_ITENS         = :FkOSItens '              + NL +
                       ' order by Oin.FK_EMPRESAS, Oin.FK_ORDENS_SERVICOS, '       + NL +
                       '          Oin.FK_OS_ITENS, Oin.SEQ_ITEM ';


  SqlOS              = 'select Ors.PK_ORDENS_SERVICOS, Cad.RAZ_SOC, Ors.DSC_ORD, ' + NL +
                       '       Tst.DSC_STT, Ors.TOT_ORD, Ors.FK_TIPO_STATUS_OS, '  + NL +
                       '       Ors.FK_TIPO_PAGAMENTOS, Tpg.DSC_TPG, Ors.DTA_OS, '  + NL +
                       '       Ors.LST_PRZ '                                       + NL +
                       '  from ORDENS_SERVICOS Ors  '                              + NL +
                       '  join CADASTROS Cad '                                     + NL +
                       '    on Cad.PK_CADASTROS       = Ors.FK_CADASTROS '         + NL +
                       '  join TIPO_STATUS_OS Tst '                                + NL +
                       '    on Tst.PK_TIPO_STATUS_OS  = Ors.FK_TIPO_STATUS_OS '    + NL +
                       '  left outer join TIPO_PAGAMENTOS Tpg '                    + NL +
                       '    on Tpg.PK_TIPO_PAGAMENTOS = Ors.FK_TIPO_PAGAMENTOS '   + NL +
                       ' where Ors.FK_EMPRESAS        = :FkEmpresas '              + NL;
  SqlAnd             = '   and ';
  SqlOrderOS         = ' order by Ors.DTA_OS, Ors.PK_ORDENS_SERVICOS';

  SqlOSItens         = 'select Osi.PK_ORDENS_SERVICOS_ITENS, Prd.DSC_PROD, '             + NL +
                       '       ''Quant.: '' || Cast(Osi.QTD_SRV as Varchar(20)) as DSC_QTD, ' + NL +
                       '       ''Fatur.: '' || Cast(Osi.DTA_FAT as Varchar(10)) as DSC_FAT, ' + NL +
                       '       Osi.TOT_SRV '                                              + NL +
                       '  from ORDENS_SERVICOS_ITENS Osi, PRODUTOS Prd '          + NL +
                       ' where Osi.FK_EMPRESAS          = :FkEmpresas '                   + NL +
                       '   and Osi.FK_ORDENS_SERVICOS   = :FkOrdensServicos '             + NL +
                       '   and Prd.PK_PRODUTOS          = Osi.FK_PRODUTOS_SERVICOS '      + NL +
                       ' order by PK_ORDENS_SERVICOS_ITENS';

  SqlUpdateOS        = 'update ORDENS_SERVICOS set '                              + NL +
                       '       FK_CADASTROS            = :FkCadastros, '          + NL +
                       '       FK_RODOVIAS             = :FkRodovias, '           + NL +
                       '       FK_TIPO_ORDENS_SERVICOS = :FkTipoOrdensServicos, ' + NL +
                       '       FK_TIPO_STATUS_OS       = :FkTipoStatusOS, '       + NL +
                       '       FK_GRUPOS_MOVIMENTOS    = :FkGruposMovimentos, '   + NL +
                       '       FK_TIPO_MOVIMENTOS      = :FkTipoMovimentos, '     + NL +
                       '       DSC_ORD      = :DscOrd, '               + NL +
                       '       DTA_INI      = :DtaIni, '               + NL +
                       '       DTA_FIN      = :DtaFin, '               + NL +
                       '       SUB_TOT      = :SubTot, '               + NL +
                       '       VLR_ACR_DSCT = :VlrAcrDsct, '           + NL +
                       '       TOT_ORD      = :TotOrd, '               + NL +
                       '       QTD_ITEMS    = :QtdItems, '             + NL +
                       '       KEY_ITEMS    = :KeyItems, '             + NL +
                       '       DTA_APR      = :DtaApr, '               + NL +
                       '       DTA_OS       = :DtaOS, '                + NL +
                       '       DTA_CANC     = :DtaCanc, '              + NL +
                       '       DTA_LIQ      = :DtaLiq, '               + NL +
                       '       DTA_BLQ      = :DtaBlq, '               + NL +
                       '       COD_AUT      = :CodAut, '               + NL +
                       '       FK_TIPO_PAGAMENTOS = :FkTipoPagamentos, '     + NL +
                       '       LST_PRZ      = :LstPrz,  '              + NL +
                       '       DTA_LIB_FIN  = :DtaLibFin '             + NL +
                       ' where FK_EMPRESAS        = :FkEmpresas '      + NL +
                       '   and PK_ORDENS_SERVICOS = :PkOrdensServicos';

  SqlInsertOS        = 'insert into ORDENS_SERVICOS '                         + NL +
                       '  (FK_EMPRESAS, PK_ORDENS_SERVICOS, FK_CADASTROS, '   + NL +
                       '   FK_TIPO_ORDENS_SERVICOS, FK_TIPO_STATUS_OS, '      + NL +
                       '   FK_GRUPOS_MOVIMENTOS, FK_TIPO_MOVIMENTOS, DTA_OS, '+ NL +
                       '   SUB_TOT, VLR_ACR_DSCT, TOT_ORD, QTD_ITEMS, '       + NL +
                       '   KEY_ITEMS, FK_RODOVIAS, DTA_INI, DTA_FIN, '        + NL +
                       '   DSC_ORD, COD_AUT, FK_TIPO_PAGAMENTOS, DTA_LIB_FIN, ' + NL +
                       '   LST_PRZ, DTA_APR, DTA_LIQ, DTA_CANC, DTA_BLQ) '    + NL +
                       'values '                                              + NL +
                       '  (:FkEmpresas, :PkOrdensServicos, :FkCadastros, '    + NL +
                       '   :FkTipoOrdensServicos, :FkTipoStatusOS, '          + NL +
                       '   :FkGruposMovimentos, :FkTipoMovimentos, :DtaOS, '  + NL +
                       '   :SubTot, :VlrAcrDsct, :TotOrd, :QtdItems, '        + NL +
                       '   :KeyItems, :FkRodovias, :DtaIni, :DtaFin, '        + NL +
                       '   :DscOrd, :CodAut, :FkTipoPagamentos, :DtaLibFin, ' + NL +
                       '   :LstPrz, :DtaApr, :DtaLiq, :DtaCanc, :DtaBlq) ';

  SqlDeleteSOItems   = 'delete from ORDENS_SERVICOS_ITENS '            + NL +
                       ' where FK_EMPRESAS        = :FkEmpresas '      + NL +
                       '   and FK_ORDENS_SERVICOS = :FkOrdensServicos ';

  SqlInsertSOItems   = 'insert into ORDENS_SERVICOS_ITENS '                  + NL +
                       '  (FK_EMPRESAS, FK_ORDENS_SERVICOS, '                + NL +
                       '   PK_ORDENS_SERVICOS_ITENS, FK_PRODUTOS_SERVICOS, ' + NL +
                       '   FK_CLASSIFICACAO, FLAG_PERS, QTD_SRV, VLR_UNIT, ' + NL +
                       '   TOT_SRV, FLAG_TQTD, ALT_SRV, LARG_SRV, '          + NL +
                       '   COMP_SRV, DTA_FAT) '                              + NL +
                       'values '                                             + NL +
                       '  (:FkEmpresas, :FkOrdensServicos, '                 + NL +
                       '   :PkOrdensServicosItens, :FkProdutosServicos, '    + NL +
                       '   :FkClassificacao, :FlagPers, :QtdSrv, :VlrUnit, ' + NL +
                       '   :TotSrv, :FlagTQtd, :AltSrv, :LargSrv, '          + NL +
                       '   :CompSrv, :DtaFat)';

  SqlInsertSOItemsLo = 'insert into ORDENS_SERVICOS_ITENS_LOCAL ' + NL +
                       '  (FK_EMPRESAS, FK_ORDENS_SERVICOS, '     + NL +
                       '   FK_ORDENS_SERVICOS_ITENS, LOC_INI, '   + NL +
                       '   LOC_FIN, FLAG_SIDE) '                  + NL +
                       'values '                                  + NL +
                       '  (:FkEmpresas, :FkOrdensServicos, '      + NL +
                       '   :FkOrdensServicosItens, :LocIni, '     + NL +
                       '   :LocFin, :FlagSide)';

  SqlInsertSOItmIns  = 'insert into ORDENS_SERVICOS_ITENS_INSUMO '           + NL +
                       '  (FK_EMPRESAS, FK_ORDENS_SERVICOS, '                + NL +
                       '   FK_OS_ITENS, SEQ_ITEM, FK_INSUMO, FLAG_TINS, '    + NL +
                       '   QTD_INS, ALT_INS, LARG_INS, COMP_INS, FLAG_FRN, ' + NL +
                       '   FLAG_TQTD, VLR_UNIT) '                            + NL +
                       'values '                                             + NL +
                       '  (:FkEmpresas, :FkOrdensServicos, :FkOsItens, '     + NL +
                       '   :SeqItem, :FkInsumo, :FlagTIns, :QtdIns, '        + NL +
                       '   :AltIns, :LargIns, :CompIns, :FlagFrn, '          + NL +
                       '   :FlagTQtd, :VlrUnit)';

  SqlServices        = 'select * from STP_GET_SERVICES_WITH_INSUMOS ';

  SqlServiceOrderHst = 'select Oht.*, Tso.DSC_STT, Tso.FLAG_STT, Tso.FLAG_AUT,  ' + NL +
                       '       Cad.RAZ_SOC  '                                     + NL +
                       '  from OS_HISTORICOS Oht  '                               + NL +
                       '  left outer join TIPO_STATUS_OS Tso  '                   + NL +
                       '    on Tso.PK_TIPO_STATUS_OS  = Oht.FK_TIPO_STATUS_OS  '  + NL +
                       '  left outer join CADASTROS Cad  '                        + NL +
                       '    on Cad.PK_CADASTROS       = Oht.COD_AUT  '            + NL +
                       ' where Oht.FK_EMPRESAS        = :FkEmpresas  '            + NL +
                       '   and Oht.FK_ORDENS_SERVICOS = :FkOrdensServicos';

  SqlDeleteHistorics = 'delete from OS_HISTORICOS '                    + NL +
                       ' where FK_EMPRESAS        = :FkEmpresas '      + NL +
                       '   and FK_ORDENS_SERVICOS = :FkOrdensServicos';

  SqlInsertHistorics = 'insert into OS_HISTORICOS ' + NL +
                       ' (FK_EMPRESAS, FK_ORDENS_SERVICOS, PK_OS_HISTORICOS, ' + NL +
                       '  FK_TIPO_STATUS_OS, DTA_HIST, COD_AUT, DSC_HIST, '    + NL +
                       '  FK_ORDENS_SERVICOS_ITENS, SEQ_INS) '                 + NL +
                       'values '                                               + NL +
                       ' (:FkEmpresas, :FkOrdensServicos, :PkOSHistoricos, '   + NL +
                       '  :FkTipoStatusOS, :DtaHist, :CodAut, :DscHist, '      + NL +
                       '  :FkOrdensServicosItens, :SeqIns)';

  SqlParametrosSrv   = 'select * from PARAMETROS_SRV '    + NL +
                       ' where FK_EMPRESAS = :FkEmpresas';

  SqlInsPrevFinance  = 'select R_STATUS from STP_INSERT_PREVISION_FROM_OS ' + NL +
                       '       (:FkEmpresas, :FkTipoOrdensServicos, '       + NL +
                       '        :PkOrdensServicos, :DtaVenc, :VlrLan, '     + NL +
                       '        :NumParc, :TotParc, :QtdParc)';


  // Sql Instructions for other modules

  SqlLancamentosCta  = 'select Cln.DTA_LAN, Cln.DSC_LAN, Cln.VLR_LAN, '    + NL +
                       '       Csl.SLD_CTA as SLD_LAN, Cad.RAZ_SOC, '      + NL +
                       '       Cln.FLAG_DBCR, Cta.DSC_CTA, Cta.SLD_CTA, '  + NL +
                       '       Cta.FK_EMPRESAS, Cta.FK_TIPO_CONTAS, '      + NL +
                       '       Cta.PK_CONTAS '                             + NL +
                       '  from TIPO_CONTAS Tct '                           + NL +
                       '  join CONTAS Cta '                                + NL +
                       '    on Cta.FK_EMPRESAS      = :FkEmpresas '        + NL +
                       '   and Cta.FK_TIPO_CONTAS   = Tct.PK_TIPO_CONTAS ' + NL +
                       '  left outer join CONTAS_LANCAMENTOS Cln '         + NL +
                       '    on Cln.FK_EMPRESAS      = Cta.FK_EMPRESAS '    + NL +
                       '   and Cln.FK_TIPO_CONTAS   = Cta.FK_TIPO_CONTAS ' + NL +
                       '   and Cln.FK_CONTAS        = Cta.PK_CONTAS '      + NL +
                       '   and Cln.DTA_LAN         >= :StartDate '         + NL +
                       '   and Cln.DTA_LAN         <= :EndDate '           + NL +
                       '  left outer join CONTAS_SALDOS Csl '              + NL +
                       '    on Csl.FK_EMPRESAS      = Cln.FK_EMPRESAS '    + NL +
                       '   and Csl.FK_TIPO_CONTAS   = Cln.FK_TIPO_CONTAS ' + NL +
                       '   and Csl.FK_CONTAS        = Cln.FK_CONTAS '      + NL +
                       '   and Csl.PK_CONTAS_SALDOS = Cln.DTA_LAN '        + NL +
                       '  left outer join CADASTROS Cad '                  + NL +
                       '    on Cad.PK_CADASTROS     = Cln.FK_CADASTROS '   + NL +
                       ' where Tct.PK_TIPO_CONTAS   > 0 '                  + NL +
                       '   and Tct.FLAG_TCTA        = :FlagTCta '          + NL +
                       ' order by Cta.DSC_CTA, Cln.DTA_LAN desc';

  SqlClassificaCRDB  = 'select * from STP_GET_CLASSIFICACAO ' + NL +
                       ' where R_FLAG_TCTA = :FlagTCta';

  SqlClassification  = 'select * from STP_GET_CLASSIFICACAO';

  SqlGetMaterial     = 'select Prd.PK_PRODUTOS, Cast(Prd.DSC_PROD || '' ==> '' ' + NL +
                       '       || Uni.MNMO_UNI as varchar(60)) as DSC_PROD, '    + NL +
                       '       Pcp.VLR_UNIT, 0.0 as QTD_PROD, Pcd.COD_REF, '     + NL +
                       '       Uni.FLAG_QTD, Uni.FLAG_ALT, Uni.FLAG_LARG, '      + NL +
                       '       Uni.FLAG_COMP, 0 as SEQ_INS, Prd.QTD_UNI ' + NL +
                       '  from PRODUTOS_COMPRAS Pcp '                            + NL +
                       '  join PRODUTOS Prd '                                    + NL +
                       '    on Prd.PK_PRODUTOS = Pcp.FK_PRODUTOS '               + NL +
                       '   and Prd.FLAG_ATV    = :FlagAtivo '                    + NL +
                       '  join UNIDADES Uni '                                    + NL +
                       '    on Uni.PK_UNIDADES = Prd.FK_UNIDADES '               + NL +
                       '  left outer join PRODUTOS_CODIGOS Pcd '                 + NL +
                       '    on Pcd.FK_PRODUTOS = Prd.PK_PRODUTOS '               + NL +
                       '   and Pcd.FLAG_TCODE  = :FlagTCode '                    + NL +
                       ' order by Prd.DSC_PROD';

  SqlGetServices     = 'select Prd.PK_PRODUTOS, Cast(Prd.DSC_PROD || '' ==> '' ' + NL +
                       '       || Uni.MNMO_UNI as varchar(60)) as DSC_PROD, '    + NL +
                       '       Psv.VLR_UNIT, 0.0 as QTD_PROD, Pcd.COD_REF, '     + NL +
                       '       Uni.FLAG_QTD, Uni.FLAG_ALT, Uni.FLAG_LARG, '      + NL +
                       '       Uni.FLAG_COMP, 0 as SEQ_COMP, Prd.QTD_UNI '       + NL +
                       '  from PRODUTOS_SERVICOS Psv '                           + NL +
                       '  join PRODUTOS Prd '                                    + NL +
                       '    on Prd.PK_PRODUTOS = Psv.FK_PRODUTOS '               + NL +
                       '   and Prd.FLAG_ATV    = :FlagAtivo '                    + NL +
                       '  join UNIDADES Uni '                                    + NL +
                       '    on PK_UNIDADES     = Prd.FK_UNIDADES '               + NL +
                       '  left outer join PRODUTOS_CODIGOS Pcd '                 + NL +
                       '    on Pcd.FK_PRODUTOS = Prd.PK_PRODUTOS '               + NL +
                       '   and Pcd.FLAG_TCODE  = :FlagTCode '                    + NL +
                       ' where Psv.FLAG_ATV    = :FlagAtv '                      + NL +
                       ' order by Prd.DSC_PROD';

  SqlDocumentos      = 'select * from TIPO_DOCUMENTOS ' + NL +
                       ' where FLAG_TDOC = 2 '          + NL +
                       ' order by DSC_TDOC';

  SqlUnidades        = 'select * from UNIDADES order by DSC_UNI';

  SqlPaises          = 'select * from PAISES order by DSC_PAIS';

  SqlEstados         = 'select * from ESTADOS '        + NL +
                       ' where FK_PAISES = :FkPaises ' + NL +
                       ' order by DSC_UF';

  SqlMunicipios      = 'select * from MUNICIPIOS '       + NL +
                       ' where FK_PAISES  = :FkPaises '  + NL +
                       '   and FK_ESTADOS = :FkEstados ' + NL +
                       ' order by DSC_MUN';

  SqlFornecedores    = 'select * from VW_FORNECEDORES '  + NL +
                       ' order by RAZ_SOC';

  SqlClientes        = 'select * from VW_CLIENTES '      + NL +
                       ' order by RAZ_SOC';

  SqlService         = 'select Cmp.PK_COMPOSICOES, Srv.DSC_SRV, Cmp.QTD_COMP, ' + NL +
                       '       0 as VLR_UNIT, 0 as VLR_TOT, 0 as KM_INI, '      + NL +
                       '       0 as KM_FIN '                                    + NL +
                       '  from COMPOSICOES Cmp, SERVICOS_IND Srv '              + NL +
                       ' where Cmp.FK_TIPO_COMPOSICOES = :FkTipoComposicoes '   + NL +
                       '   and Cmp.FK_SERVICOS_IND     = :Insumo '              + NL +
                       '   and Srv.PK_SERVICOS_IND     = Cmp.FK_SERVICOS_IND';

  SqlMaterial        = 'select Cmp.PK_COMPOSICOES, Ins.DSC_INS, Cmp.QTD_COMP, ' + NL +
                       '       0 as VLR_UNIT, 0 as VLR_TOT, 0 as KM_INI, '      + NL +
                       '       0 as KM_FIN '                                    + NL +
                       '  from COMPOSICOES Cmp, INSUMOS Ins '                   + NL +
                       ' where Cmp.FK_TIPO_COMPOSICOES = :FkTipoComposicoes '   + NL +
                       '   and Cmp.FK_INSUMOS          = :Insumo '              + NL +
                       '   and Ins.PK_INSUMOS          = Cmp.FK_INSUMOS';

  SqlTipoPgtos       = 'select * from TIPO_PAGAMENTOS '                        + NL +
                       ' where ((FK_GRUPOS_MOVIMENTOS = :FkGruposMovimentos) ' + NL +
                       '    or  (0                    = :FkGruposMovimentos)) ';

var
  Variables: array of string;

implementation

end.
