unit EstqArqSql;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 10/04/2003 - DD/MM/YYYY                                      *}
{* Modified: 10/04/2003 - DD/MM/YYYY                                     *}
{* Version: 2.0.0.0                                                      *}
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
// Key Generators SQL

  SqlGenPkTipoMovim     = 'select R_PK_TIPO_MOVIM_ESTQ as PK_TIPO_MOVIM_ESTQ ' + NL +
                          '  from STP_GET_PK_TIPO_MOVIM_ESTQ';


  SqlGenPkTipoProd      = 'select R_PK_TIPO_PRODUTOS as PK_TIPO_PRODUTOS ' + NL +
                          '  from STP_GET_PK_TIPO_PRODUTOS';

  SqlGenPkUnit          = 'select R_PK_UNIDADES as PK_UNIDADES ' + NL +
                          '  from STP_GET_PK_UNIDADES';

  SqlGenPkAlmox         = 'select R_PK_ALMOXARIFADOS as PK_ALMOXARIFADOS ' + NL +
                          '  from STP_GET_PK_ALMOXARIFADOS';

  SqlGenPkLine          = 'select R_PK_LINHAS as PK_LINHAS ' + NL +
                          '  from STP_GET_PK_LINHAS';

  SqlGenPkTabPrice      = 'select R_PK_TABELA_PRECOS as PK_TABELA_PRECOS ' + NL +
                          '  from STP_GET_PK_TABELA_PRECOS';

  SqlGenPkSimilar       = 'select R_PK_SIMILARES as PK_SIMILARES ' + NL +
                          '  from STP_GET_PK_SIMILARES';

  SqlGenPkTypeSitSupply = 'select R_PK_TIPO_SITUACAO_ESTOQUES as PK_TIPO_SITUACAO_ESTOQUES ' + NL +
                          '  from STP_GET_PK_TIPO_SITUACAO_ESTOQUES';

  SqlGenPkLotacao       = 'select R_PK_LOTACOES as PK_LOTACOES ' + NL +
                          '  from STP_GET_PK_LOTACOES(:FkEmpresas, :FkAlmoxarifados)';

  SqlGetPkDocument      = 'select R_PK_DOCUMENT from STP_GET_PK_DOCUMENT(' + NL +
                          '       :FkEmpresas, :FkTipoDocumentos)';

  SqlGetPkLotacao       = 'select Max(PK_LOTACOES) as FK_LOTACOES '     + NL +
                          '  from LOTACOES '                            + NL +
                          ' where FK_EMPRESAS      = :FkEmpresas '      + NL +
                          '   and FK_ALMOXARIFADOS = :FkAlmoxarifados ' + NL +
                          '   and RUA_LOT          = :RuaLot '          + NL +
                          '   and NIVEL_LOT        = :NivelLot '        + NL +
                          '   and BOX_LOT          = :BoxLot';

  SqlGetNumberDocument  = 'select PK_REQUISICOES ' + NL +
                          '  from REQUISICOES ' + NL +
                          ' where FK_EMPRESAS        = :FkEmpresas ' + NL +
                          '   and FK_TIPO_DOCUMENTOS = :FkTipoDocumentos ' + NL +
                          '   and NUM_DOC            = :NumDoc';

  SqlSelectPkProduto    = 'select R_PK_PRODUTOS as PK_PRODUTOS ' + NL +
                          '  from STP_GET_PK_PRODUTOS';

  SqlAllEstqParams      = 'select Emp.PK_EMPRESAS, Emp.RAZ_SOC, Prm.FK_EMPRESAS ' + NL +
                          '  from EMPRESAS Emp ' + NL +
                          '  left outer join PARAMETROS_ESTQ Prm ' + NL +
                          '    on Prm.FK_EMPRESAS = Emp.PK_EMPRESAS ' + NL +
                          '  order by Emp.RAZ_SOC';

  SqlParamEstq          = 'select * from PARAMETROS_ESTQ ' + NL +
                          ' where FK_EMPRESAS = :FkEmpresas ';

  SqlDeleteParamEstq    = 'delete from PARAMETROS_ESTQ ' + NL +
                          ' where FK_EMPRESAS = :FkEmpresas ';

  SqlUpdateParamEstq    = 'update PARAMETROS_ESTQ set ' + NL +
                          '       FK_ALMOXARIFADOS         = :FkAlmoxarifados, ' + NL +
                          '       FK_TIPO_MOVIM_ESTQ__ENTR = :FkTipoMovmEstqEntr, ' + NL +
                          '       FK_TIPO_MOVIM_ESTQ__SAI  = :FkTipoMovmEstqSai, ' + NL +
                          '       FK_TABELA_PRECOS         = :FkTabelaPrecos, ' + NL +
                          '       FLAG_TMRGM               = :FlagTMrgm, ' + NL +
                          '       FLAG_TCUSTO              = :FlagTCusto, ' + NL +
                          '       FLAG_TACABM              = :FlagTAcabm, ' + NL +
                          '       MRG_DEF                  = :MrgDef ' + NL +
                          ' where FK_EMPRESAS = :FkEmpresas';

  SqlInsertParamEstq    = 'insert into PARAMETROS_ESTQ ' + NL +
                          '  (FK_EMPRESAS, FK_ALMOXARIFADOS, FK_TIPO_MOVIM_ESTQ__ENTR, ' + NL +
                          '   FK_TIPO_MOVIM_ESTQ__SAI, FK_TABELA_PRECOS, FLAG_TMRGM, ' + NL +
                          '   FLAG_TCUSTO, FLAG_TACABM, MRG_DEF) ' + NL +
                          'values ' + NL +
                          '  (:FkEmpresas, :FkAlmoxarifados, :FkTipoMovmEstqEntr, ' + NL +
                          '   :FkTipoMovmEstqSai, :FkTabelaPrecos, :FlagTMrgm, ' + NL +
                          '   :FlagTCusto, :FlagTAcabm, :MrgDef)';

  // General select

  SqlSelectGroups       = 'select * from STP_GET_PRODUCT_GROUPS';

  SqlSelectGroup        = 'select Pgr.PK_PRODUTOS_GRUPOS, Pgr.FK_PRODUTOS_GRUPOS, ' + NL +
                          '       Pgr.DSC_PGRU, Pgr.SEQ_CLASS, Pgr.LEV_CLASS, ' + NL +
                          '       Pgr.MASK_CLASS, Pgr.FLAG_LAST_LEVEL, Prf.DSCT_PROD, ' + NL +
                          '       Prf.MRGM_REF, Prf.COM_SGRU, Prf.COD_GREF, Prf.SEQ_REF ' + NL +
                          ' from  PRODUTOS_GRUPOS Pgr ' + NL +
                          '  left outer join PRODUTOS_REFERENCIAS Prf '+ NL +
                          '    on Prf.FK_PRODUTOS_GRUPOS = Pgr.PK_PRODUTOS_GRUPOS '+ NL +
                          ' where Pgr.PK_PRODUTOS_GRUPOS = :PkProdutosGrupos';

  SqlGenPkGroup         = 'select R_PK_PRODUTOS_GRUPOS as PK_PRODUTOS_GRUPOS ' + NL +
                          '  from STP_GET_PK_PRODUTOS_GRUPOS';

  SqlDeleteGroup        = 'delete from PRODUTOS_GRUPOS ' + NL +
                          ' where PK_PRODUTOS_GRUPOS = :PkProdutosGrupos';

  SqlInsertGroup        = 'insert into PRODUTOS_GRUPOS  ' + NL +
                          '  (PK_PRODUTOS_GRUPOS, FK_PRODUTOS_GRUPOS, DSC_PGRU, ' + NL +
                          '   SEQ_CLASS, LEV_CLASS, MASK_CLASS, FLAG_LAST_LEVEL) ' + NL +
                          'values ' + NL +
                          '  (:PkProdutosGrupos, :FkProdutosGrupos, :DscPGru, ' + NL +
                          '   :SeqClass, :LevClass, :MaskClass, :FlagLastLevel)';

  SqlUpdateGroup        = 'update PRODUTOS_GRUPOS set ' + NL +
                          '       DSC_PGRU           = :DscPGru, ' + NL +
                          '       SEQ_CLASS          = :SeqClass, ' + NL +
                          '       LEV_CLASS          = :LevClass, ' + NL +
                          '       MASK_CLASS         = :MaskClass, ' + NL +
                          '       FLAG_LAST_LEVEL    = :FlagLastLevel ' + NL +
                          ' where PK_PRODUTOS_GRUPOS = :PkProdutosGrupos';

  SqlAlmoxarifado       = 'select * from ALMOXARIFADOS ' + NL +
                          ' where PK_ALMOXARIFADOS = :PkAlmoxarifados ' + NL +
                          ' order by DSC_ALMX';

  SqlDeleteProdRef      = 'delete from PRODUTOS_REFERENCIAS ' + NL +
                          ' where FK_PRODUTOS_GRUPOS = :FkProdutosGrupos';

  SqlUpdateProdRef      = 'update PRODUTOS_REFERENCIAS set ' + NL +
                          '       DSCT_PROD = :DsctProd, ' + NL +
                          '       MRGM_REF  = :MrgmRef, ' + NL +
                          '       COM_SGRU  = :ComSGru, ' + NL +
                          '       COD_GREF  = :CodGRef, ' + NL +
                          '       SEQ_REF   = :SeqRef ' + NL +
                          ' where FK_PRODUTOS_GRUPOS = :FkProdutosGrupos';

  SqlInsertProdRef      = 'insert into PRODUTOS_REFERENCIAS ' + NL +
                          '  (FK_PRODUTOS_GRUPOS, DSCT_PROD, MRGM_REF, ' + NL +
                          '   COM_SGRU, COD_GREF, SEQ_REF) ' + NL +
                          'values ' + NL +
                          '  (:FkProdutosGrupos, :DsctProd, :MrgmRef, ' + NL +
                          '   :ComSGru, :CodGRef, :SeqRef)';

  SqlDeleteAlmox        = 'delete from ALMOXARIFADOS ' + NL +
                          ' where PK_ALMOXARIFADOS = :PkAlmoxarifados';

  SqlDeleteLotacao      = 'delete from LOTACOES ' + NL +
                          ' where FK_EMPRESAS      = :FkEmpresas ' + NL +
                          '   and FK_ALMOXARIFADOS = :FkAlmoxarifados ' + NL +
                          '   and PK_LOTACOES      = :PkLotacoes';

  SqlUpdateLotacao      = 'update LOTACOES set ' + NL +
                          '       RUA_LOT          = :RuaLot, ' + NL +
                          '       NIVEL_LOT        = :NivelLot, ' + NL +
                          '       BOX_LOT          = :BoxLot ' + NL +
                          ' where FK_EMPRESAS      = :FkEmpresas ' + NL +
                          '   and FK_ALMOXARIFADOS = :FkAlmoxarifados ' + NL +
                          '   and PK_LOTACOES      = :PkLotacoes';

  SqlInsertLotacao      = 'insert into LOTACOES  ' + NL +
                          '  (RUA_LOT, NIVEL_LOT, BOX_LOT, FK_EMPRESAS, ' + NL +
                          '   FK_ALMOXARIFADOS, PK_LOTACOES) ' + NL +
                          'values ' + NL +
                          '  (:RuaLot, :NivelLot, :BoxLot, :FkEmpresas, ' + NL +
                          '   :FkAlmoxarifados, :PkLotacoes)';

  SqlGroupAccounts      = 'select Pct.FK_PRODUTOS_GRUPOS, Nat.FK_TIPO_CFOP, ' + NL +
                          '       Nat.PK_NATUREZA_OPERACOES, Nat.DSC_NTOP, ' + NL +
                          '       Nat.COD_CFOP, Fin.PK_FINANCEIRO_CONTAS, ' + NL +
                          '       Fin.MASK_CTA, Fin.DSC_CTA, Fin.FLAG_TCTA, ' + NL +
                          '       Cast(3 as Integer) as ROW_STATE ' + NL +
                          '  from PRODUTOS_CONTAS Pct, NATUREZA_OPERACOES Nat, ' + NL +
                          '       FINANCEIRO_CONTAS Fin ' + NL +
                          ' where Pct.FK_PRODUTOS_GRUPOS    = :FkProdutosGrupos ' + NL +
                          '   and Nat.FK_TIPO_CFOP          = Pct.FK_TIPO_CFOP ' + NL +
                          '   and Nat.PK_NATUREZA_OPERACOES = Pct.FK_NATUREZA_OPERACOES ' + NL +
                          '   and Fin.PK_FINANCEIRO_CONTAS  = Pct.FK_FINANCEIRO_CONTAS ' + NL +
                          ' order by Fin.MASK_CTA, Nat.COD_CFOP';

  SqlDeleteAccounts     = 'delete from PRODUTOS_CONTAS ' + NL +
                          ' where FK_PRODUTOS_GRUPOS = :FkProdutosGrupos';

  SqlInsertAccounts     = 'insert into PRODUTOS_CONTAS ' + NL +
                          '  (FK_PRODUTOS_GRUPOS, FK_TIPO_CFOP, ' + NL +
                          '   FK_NATUREZA_OPERACOES, FK_FINANCEIRO_CONTAS) ' + NL +
                          'values ' + NL +
                          '  (:FkProdutosGrupos, :FkTipoCfop, ' + NL +
                          '   :FkNaturezaOperacoes, :FkFinanceiroContas)';

  SqlAlmoxarifados      = 'select * from ALMOXARIFADOS ' + NL +
                          ' order by DSC_ALMX';

  SqlUnidades           = 'select * from UNIDADES ' + NL +
                          ' order by DSC_UNI';

  SqlUnidade            = 'select * from UNIDADES ' + NL +
                          ' where PK_UNIDADES = :PkUnidades';

  SqlDeleteUnit         = 'delete from UNIDADES ' + NL +
                          ' where PK_UNIDADES = :PkUnidades';

  SqlInsertUnit         = 'insert into UNIDADES ' + NL +
                          '  (PK_UNIDADES, DSC_UNI, MNMO_UNI, FLAG_FRAC, ' + NL +
                          '   FLAG_ALT, FLAG_LARG, FLAG_COMP, FLAG_QTD, '+ NL +
                          '   FLAG_FUNI, FLAG_TUNI) ' + NL +
                          'values ' + NL +
                          '  (:PkUnidades, :DscUni, :MnmoUni, :FlagFrac,  ' + NL +
                          '   :FlagAlt, :FlagLarg, :FlagComp, :FlagQtd, ' + NL +
                          '   :FlagFUni, :FlagTUni)';

  SqlUpdateUnit         = 'update UNIDADES set ' + NL +
                          '       DSC_UNI   = :DscUni, ' + NL +
                          '       MNMO_UNI  = :MnmoUni, ' + NL +
                          '       FLAG_FRAC = :FlagFrac, ' + NL +
                          '       FLAG_ALT  = :FlagAlt, ' + NL +
                          '       FLAG_LARG = :FlagLarg, ' + NL +
                          '       FLAG_COMP = :FlagComp, ' + NL +
                          '       FLAG_QTD  = :FlagQtd, ' + NL +
                          '       FLAG_FUNI = :FlagFUni, ' + NL +
                          '       FLAG_TUNI = :FlagTUni ' + NL +
                          ' where PK_UNIDADES = :PkUnidades';

  SqlLinhas             = 'select * from LINHAS ' + NL +
                          ' order by DSC_LIN';

  SqlLinha              = 'select * from LINHAS ' + NL +
                          ' where PK_LINHAS = :PkLinhas';

  SqlDeleteLinha        = 'delete from LINHAS ' + NL +
                          ' where PK_LINHAS = :PkLinhas';

  SqlUpdateLinha        = 'update LINHAS set ' + NL +
                          '       DSC_LIN           = :DscLin, ' + NL +
                          '       FK_TIPO_COMISSOES = :FkTipoComissoes '  + NL +
                          ' where PK_LINHAS         = :PkLinhas';

  SqlInsertLinha        = 'insert into LINHAS ' + NL +
                          '  (PK_LINHAS, DSC_LIN, FK_TIPO_COMISSOES) ' + NL +
                          'values ' + NL +
                          '  (:PkLinhas, :DscLin, :FkTipoComissoes)';

  SqlTabPriceAndRegions = 'select Tab.PK_TABELA_PRECOS, Tab.DSC_TAB, Tab.DTA_INI, ' + NL +
                          '       Tab.DTA_FIN, Tab.FLAG_DEFTAB, Tab.PERC_DSCT, ' + NL +
                          '       Tfr.PK_TIPO_TABELA_FRACAO, Tfr.DSC_TAB as DSC_FRAC, ' + NL +
                          '       Tfr.FLAG_TIPO, Tod.PK_TABELA_ORIGEM_DESTINO, ' + NL +
                          '       Org.REF_REG as REF_ORG, Dst.REF_REG as REF_DST ' + NL +
                          '  from TABELA_PRECOS Tab ' + NL +
                          '  left outer join TABELA_TRANSPORTES Ttr ' + NL +
                          '    on Ttr.FK_TABELA_PRECOS = Tab.PK_TABELA_PRECOS ' + NL +
                          '  left outer join TIPO_TABELA_FRACAO Tfr ' + NL +
                          '    on Tfr.PK_TIPO_TABELA_FRACAO = Ttr.FK_TIPO_TABELA_FRACAO ' + NL +
                          '  left outer join TABELA_ORIGEM_DESTINO Tod ' + NL +
                          '    on Tod.PK_TABELA_ORIGEM_DESTINO = Ttr.FK_TABELA_ORIGEM_DESTINO ' + NL +
                          '  left outer join CARGAS_REGIOES Org ' + NL +
                          '    on Org.PK_CARGAS_REGIOES = Tod.FK_CARGAS_REGIOES__ORG ' + NL +
                          '  left outer join CARGAS_REGIOES Dst ' + NL +
                          '    on Dst.PK_CARGAS_REGIOES = Tod.FK_CARGAS_REGIOES__DST ' + NL +
                          ' order by Tab.DSC_TAB, Tfr.DSC_TAB, Org.REF_REG, Dst.REF_REG';

  SqlPriceTables        = 'select * from TABELA_PRECOS ' + NL +
                          ' order by DSC_TAB ';

  SqlPriceTable         = 'select * from TABELA_PRECOS ' + NL +
                          ' where PK_TABELA_PRECOS = :PkTabelaPrecos';

  SqlDeletePriceTable   = 'delete from TABELA_PRECOS ' + NL +
                          ' where PK_TABELA_PRECOS = :PkTabelaPrecos ';

  SqlInsertPriceTable   = 'insert into TABELA_PRECOS ' + NL +
                          '  (PK_TABELA_PRECOS, DSC_TAB, DTA_INI, DTA_FIN, ' + NL +
                          '   FLAG_DEFTAB, PERC_DSCT) ' + NL +
                          'values ' + NL +
                          '  (:PkTabelaPrecos, :DscTab, :DtaIni, :DtaFin, ' + NL +
                          '   :FlagDefTab, :PercDsct)';

  SqlUpdatePriceTable   = 'update TABELA_PRECOS set '              + NL +
                          '       DSC_TAB          = :DscTab, '    + NL +
                          '       DTA_INI          = :DtaIni, '    + NL +
                          '       DTA_FIN          = :DtaFin, '    + NL +
                          '       FLAG_DEFTAB      = :FlagDefTab,' + NL +
                          '       PERC_DSCT        = :PercDsct '   + NL +
                          ' where PK_TABELA_PRECOS = :PkTabelaPrecos';

  SqlGenTypeFraction    = 'select R_PK_TIPO_TABELA_FRACAO as PK_TIPO_TABELA_FRACAO ' + NL +
                          '  from STP_GET_PK_TIPO_TABELA_FRACAO';

  SqlTypeFractions      = 'select * from TIPO_TABELA_FRACAO ' + NL +
                          ' order by DSC_TAB';

  SqlTypeFraction       = 'select * from TIPO_TABELA_FRACAO ' + NL +
                          ' where PK_TIPO_TABELA_FRACAO = :PkTipoTabelaFracao';

  SqlDeleteTypeFraction = 'delete from TIPO_TABELA_FRACAO ' + NL +
                          ' where PK_TIPO_TABELA_FRACAO = :PkTipoTabelaFracao';

  SqlInsertTypeFraction = 'insert into TIPO_TABELA_FRACAO ' + NL +
                          '  (PK_TIPO_TABELA_FRACAO, DSC_TAB, FLAG_TIPO) ' + NL +
                          'values ' + NL +
                          '  (:PkTipoTabelaFracao, :DscTab, :FlagTipo)';

  SqlUpdateTypeFraction = 'update TIPO_TABELA_FRACAO set ' + NL +
                          '       DSC_TAB               = :DscTab, ' + NL +
                          '       FLAG_TIPO             = :FlagTipo ' + NL +
                          ' where PK_TIPO_TABELA_FRACAO = :PkTipoTabelaFracao';

  SqlTableFraction      = 'select * from TABELA_TRANSPORTES ' + NL +
                          ' where FK_TABELA_PRECOS         = :FkTabelaPrecos ' + NL +
                          '   and FK_TIPO_TABELA_FRACAO    = :FkTipoTabelaFracao ' + NL +
                          '   and FK_TABELA_ORIGEM_DESTINO = :FkTabelaOrigemDestino';

  SqlDelTableFraction   = 'delete from TABELA_TRANSPORTES ' + NL +
                          ' where FK_TABELA_PRECOS         = :FkTabelaPrecos ' + NL +
                          '   and FK_TIPO_TABELA_FRACAO    = :FkTipoTabelaFracao ' + NL +
                          '   and FK_TABELA_ORIGEM_DESTINO = :FkTabelaOrigemDestino';

  SqlInsTableFraction   = 'insert into TABELA_TRANSPORTES ' + NL +
                          '  (FK_TABELA_PRECOS, FK_TIPO_TABELA_FRACAO, ' + NL +
                          '   FK_TABELA_ORIGEM_DESTINO, FLAG_VEXD, VLR_EXD, ' + NL +
                          '   PERC_GRIS, VLR_MIN_GRIS, DIV_PED, VLR_PED, ' + NL +
                          '   FLAG_TPOPER) ' + NL +
                          'values ' + NL +
                          '  (:FkTabelaPrecos, :FkTipoTabelaFracao, ' + NL +
                          '   :FkTabelaOrigemDestino, :FlagVExd, :VlrExd, ' + NL +
                          '   :PercGris, :VlrMinGris, :DivPed, :Vlr_Ped, ' + NL +
                          '   :FlagTpOper)';

  SqlUpdTableFraction   = 'update TABELA_TRANSPORTES set ' + NL +
                          '       FLAG_VEXD                = :FlagVExd, ' + NL +
                          '       VLR_EXD                  = :VlrExd, ' + NL +
                          '       PERC_GRIS                = :PercGris, ' + NL +
                          '       VLR_MIN_GRIS             = :VlrMinGris, ' + NL +
                          '       DIV_PED                  = :DivPed, ' + NL +
                          '       VLR_PED                  = :Vlr_Ped, ' + NL +
                          '       FLAG_TPOPER              = :FlagTpOper ' + NL +
                          ' where FK_TABELA_PRECOS         = :FkTabelaPrecos ' + NL +
                          '   and FK_TIPO_TABELA_FRACAO    = :FkTipoTabelaFracao ' + NL +
                          '   and FK_TABELA_ORIGEM_DESTINO = :FkTabelaOrigemDestino';

  SqlGenTableRegion     = 'select R_PK_TABELA_ORIGEM_DESTINO as PK_TABELA_ORIGEM_DESTINO ' + NL +
                          '  from STP_GET_PK_ORIGEM_DESTINO';

  SqlTableRegions       = 'select Tod.*, Cast(Org.REF_REG || '' ==> '' || ' + NL +
                          '       Dst.REF_REG as varchar(100)) as DSC_ORDS ' + NL +
                          '  from TABELA_ORIGEM_DESTINO Tod, CARGAS_REGIOES Org, ' + NL +
                          '       CARGAS_REGIOES Dst ' + NL +
                          ' where Dst.PK_CARGAS_REGIOES = Tod.FK_CARGAS_REGIOES__DST ' + NL +
                          '   and Org.PK_CARGAS_REGIOES = Tod.FK_CARGAS_REGIOES__ORG ' + NL +
                          ' order by Org.REF_REG, Dst.REF_REG';

  SqlDscTableRegion     = 'select Tod.PK_TABELA_ORIGEM_DESTINO, Org.REF_REG as DSC_ORGM, ' + NL +
                          '       Dst.REF_REG as DSC_DSTN ' + NL +
                          '  from TABELA_ORIGEM_DESTINO Tod, CARGAS_REGIOES Org, ' + NL +
                          '       CARGAS_REGIOES Dst ' + NL +
                          ' where Tod.PK_TABELA_ORIGEM_DESTINO = :PkTabelaOrigemDestino ' + NL +
                          '   and Org.PK_CARGAS_REGIOES = Tod.FK_CARGAS_REGIOES__ORG ' + NL +
                          '   and Dst.PK_CARGAS_REGIOES = Tod.FK_CARGAS_REGIOES__DST ' + NL +
                          ' order by Org.REF_REG, Dst.REF_REG';

  SqlTableRegion        = 'select * from TABELA_ORIGEM_DESTINO ' + NL +
                          ' where PK_TABELA_ORIGEM_DESTINO = :PkTabelaOrigemDestino';

  SqlDeleteTableRegion  = 'delete from TABELA_ORIGEM_DESTINO ' + NL +
                          ' where PK_TABELA_ORIGEM_DESTINO = :PkTabelaOrigemDestino';

  SqlInsertTableRegion   = 'insert into TABELA_ORIGEM_DESTINO ' + NL +
                          '  (PK_TABELA_ORIGEM_DESTINO, FK_CARGAS_REGIOES__ORG, ' + NL +
                          '   FK_CARGAS_REGIOES__DST, FK_TIPO_PRAZO_ENTREGA, VLR_MIN) ' + NL +
                          'values ' + NL +
                          '  (:PkTabelaOrigemDestino, :FkCargasRegioesOrg, ' + NL +
                          '   :FkCargasRegioesDst, :FkTipoPrazoEntrega, :VlrMin)';

  SqlUpdateTableRegion   = 'update TABELA_ORIGEM_DESTINO set ' + NL +
                          '       FK_CARGAS_REGIOES__ORG    = :FkCargasRegioesOrg, ' + NL +
                          '       FK_CARGAS_REGIOES__DST    = :FkCargasRegioesDst, ' + NL +
                          '       FK_TIPO_PRAZO_ENTREGA     = :FkTipoPrazoEntrega, ' + NL +
                          '       VLR_MIN                   = :VlrMin ' + NL +
                          ' where PK_TABELA_ORIGEM_DESTINO = :PkCalculoOrigemDestino';

  SqlGetTableFraction   = 'select * from TABELA_FRACOES ' + NL +
                          ' where FK_TABELA_PRECOS         = :FkTabelaPrecos ' + NL +
                          '   and FK_TIPO_TABELA_FRACAO    = :FkTipoTabelaFracao ' + NL +
                          '   and FK_TABELA_ORIGEM_DESTINO = :FkTabelaOrigemDestino';

  SqlDeleteTableFract   = 'delete from TABELA_FRACOES ' + NL +
                          ' where FK_TABELA_PRECOS         = :FkTabelaPrecos ' + NL +
                          '   and FK_TIPO_TABELA_FRACAO    = :FkTipoTabelaFracao ' + NL +
                          '   and FK_TABELA_ORIGEM_DESTINO = :FkTabelaOrigemDestino';

  SqlInsertTableFract   = 'insert into TABELA_FRACOES '  + NL +
                          '  (FK_TABELA_PRECOS, FK_TIPO_TABELA_FRACAO, ' + NL +
                          '   FK_TABELA_ORIGEM_DESTINO, PK_TABELA_FRACOES, ' + NL +
                          '   VLR_INI, VLR_FIN, VLR_IDX, FLAG_MFINAL, ' + NL +
                          '   PERC_ADV, TAX_TAB) ' + NL +
                          'values ' + NL +
                          '  (:FkTabelaPrecos, :FkTipoTabelaFracao, ' + NL +
                          '   :FkTabelaOrigemDestino, :PkTabelaFracoes, ' + NL +
                          '   :VlrIni, :VlrFin, :VlrIdx, :FlagMFinal, ' + NL +
                          '   :PercAdv, :TaxTab)';

  SqlSimilares          = 'select * from SIMILARES ' + NL +
                          ' order by DSC_SIM';

  SqlSimilar            = 'select * from SIMILARES ' + NL +
                          ' where PK_SIMILARES = :PkSimilares';

  SqlDeleteSimilar      = 'delete from SIMILARES ' + NL +
                          ' where PK_SIMILARES = :PkSimilares';

  SqlInsertSimilar      = 'insert into SIMILARES ' + NL +
                          '  (PK_SIMILARES, DSC_SIM) ' + NL +
                          'values ' + NL +
                          '  (:PkSimilares, :DscSim)';

  SqlUpdateSimilar      = 'update SIMILARES set ' + NL +
                          '       DSC_SIM      = :DscSim ' + NL +
                          ' where PK_SIMILARES = :PkSimilares';

  SqlTipoSitEstqs       = 'select * from TIPO_SITUACAO_ESTOQUES ' + NL +
                          ' order by DSC_TSE';

  SqlTipoSitEstq        = 'select * from TIPO_SITUACAO_ESTOQUES ' + NL +
                          ' where PK_TIPO_SITUACAO_ESTOQUES = :PkTipoSituacaoEstoques';

  SqlDeleteTSitProd     = 'delete from TIPO_SITUACAO_ESTOQUES ' + NL +
                          ' where PK_TIPO_SITUACAO_ESTOQUES = :PkTipoSituacaoEstoques';

  SqlInsertTSitProd     = 'insert into TIPO_SITUACAO_ESTOQUES ' + NL +
                          '  (PK_TIPO_SITUACAO_ESTOQUES, DSC_TSE, FLAG_BLOQ) ' + NL +
                          'values ' + NL +
                          '  (:PkTipoSituacaoEstoques, :DscTse, :FlagBloq)';

  SqlUpdateTSitProd     = 'update TIPO_SITUACAO_ESTOQUES set ' + NL +
                          '       DSC_TSE   = :DscTse, ' + NL +
                          '       FLAG_BLOQ = :FlagBloq ' + NL +
                          ' where PK_TIPO_SITUACAO_ESTOQUES = :PkTipoSituacaoEstoques';

  SqlProduto            = 'select Prd.*, Pgr.DSC_PGRU, Prf.COD_GREF, Prf.SEQ_REF, ' + NL +
                          '       Prf.COM_SGRU, Prf.DSCT_PROD, Prf.MRGM_REF, ' + NL +
                          '       Uni.DSC_UNI, Uni.MNMO_UNI '                                   + NL +
                          '  from PRODUTOS Prd, PRODUTOS_GRUPOS Pgr, '          + NL +
                          '       PRODUTOS_REFERENCIAS Prf, UNIDADES Uni '                    + NL +
                          ' where Prd.PK_PRODUTOS  = :PkProdutos '                 + NL +
                          '   and Pgr.PK_PRODUTOS_GRUPOS = Prd.FK_PRODUTOS_GRUPOS ' + NL +
                          '   and Prf.FK_PRODUTOS_GRUPOS = Prd.FK_PRODUTOS_GRUPOS ' + NL +
                          '   and Uni.PK_UNIDADES  = Prd.FK_UNIDADES';

  SqlProdutos           = 'select * from PRODUTOS ' + NL +
                          ' order by DSC_PROD';

  SqlGetCfops           = 'select Tcf.PK_TIPO_CFOP, Tcf.DSC_TMRC, ' + NL +
                          '       Nat.PK_NATUREZA_OPERACOES, Nat.COD_CFOP, ' + NL +
                          '       Nat.DSC_NTOP, Cast(-1 as smallint) as STATE, ' + NL +
                          '       Tpn.FK_TIPO_PRODUTOS ' + NL +
                          '  from TIPO_CFOP Tcf ' + NL +
                          '  join NATUREZA_OPERACOES Nat ' + NL +
                          '    on Nat.FK_TIPO_CFOP = Tcf.PK_TIPO_CFOP ' + NL +
                          '   and Nat.FK_FINANCEIRO_CONTAS is not null ' + NL +
                          '  left outer join TIPO_PRODUTOS_NATURE_OPER Tpn ' + NL +
                          '    on Tpn.FK_TIPO_PRODUTOS      = :FkTipoProdutos ' + NL +
                          '   and Tpn.FK_TIPO_CFOP          = Tcf.PK_TIPO_CFOP ' + NL +
                          '   and Tpn.FK_NATUREZA_OPERACOES = Nat.PK_NATUREZA_OPERACOES ' + NL +
                          ' where Tcf.PK_TIPO_CFOP > 0 ' + NL +
                          ' order by Tcf.PK_TIPO_CFOP, Nat.COD_CFOP';

  SqlInsertCfops        = 'insert into TIPO_PRODUTOS_NATURE_OPER ' + NL +
                          '  (FK_TIPO_PRODUTOS, FK_TIPO_CFOP, FK_NATUREZA_OPERACOES) ' + NL +
                          'values ' + NL +
                          '  (:FkTipoProdutos, :FkTipoCfop, :FkNaturezaOperacoes)';

  SqlDeleteCfops        = 'delete from TIPO_PRODUTOS_NATURE_OPER ' + NL +
                          ' where FK_TIPO_PRODUTOS      = :FkTipoProdutos ' + NL +
                          '   and FK_TIPO_CFOP          = :FkTipoCfop ' + NL +
                          '   and FK_NATUREZA_OPERACOES = :FkNaturezaOperacoes';

  SqlTypeProducts       = 'select * from TIPO_PRODUTOS ' + NL +
                          ' order by DSC_TPRD';

  SqlTypeProduct        = 'select * from TIPO_PRODUTOS ' + NL +
                          ' where PK_TIPO_PRODUTOS = :PkTipoProdutos';

  SqlDeleteTypeProduct  = 'delete from TIPO_PRODUTOS ' + NL +
                          ' where PK_TIPO_PRODUTOS = :PkTipoProdutos';

  SqlInsertTypeProduct  = 'insert into TIPO_PRODUTOS ' + NL +
                          '   (PK_TIPO_PRODUTOS, DSC_TPRD, FLAG_TPROD, ' + NL +
                          '    FK_FINANCEIRO_CONTAS_SAIDAS, FK_FINANCEIRO_CONTAS_ENTRADAS) ' + NL +
                          'values ' + NL +
                          '   (:PkTipoProdutos, :DscTPrd, :FlagTProd, ' + NL +
                          '    :FkFinanceiroContasSaidas, :FkFinanceiroContasEntradas';

  SqlUpdateTypeProduct  = 'update TIPO_PRODUTOS set ' + NL +
                          '       DSC_TPRD   = :DscTPrd, ' + NL +
                          '       FLAG_TPROD = :FlagTProd, ' + NL +
                          '       FK_FINANCEIRO_CONTAS_SAIDAS = :FkFinanceiroContasSaidas, ' + NL +
                          '       FK_FINANCEIRO_CONTAS_ENTRADAS = :FkFinanceiroContasEntradas ' + NL +
                          ' where PK_TIPO_PRODUTOS = :PkTipoProdutos';

  SqlInsertProd_X_Type  = 'insert into PRODUTOS_TIPO_PRODUTOS ' + NL +
                          '  (FK_TIPO_PRODUTOS, FK_PRODUTOS) '    + NL +
                          'values '                               + NL +
                          '  (:FkTipoProdutos, :FkProdutos)';

  SqlDeleteProd_X_Type  = 'delete from PRODUTOS_TIPO_PRODUTOS '      + NL +
                          ' where FK_TIPO_PRODUTOS = :FkTipoProdutos ' + NL +
                          '   and FK_PRODUTOS      = :FkProdutos ';

  SqlVinculoTProd       = 'select Tpr.DSC_TPRD, Tpr.FLAG_TPROD, '               + NL +
                          '       Tpr.PK_TIPO_PRODUTOS, Pxt.FK_PRODUTOS, '      + NL +
                          '       Cast(3 as smallint) as STATUS '               + NL +
                          '  from TIPO_PRODUTOS Tpr '                           + NL +
                          '  left outer join PRODUTOS_TIPO_PRODUTOS Pxt '     + NL +
                          '    on Pxt.FK_TIPO_PRODUTOS = Tpr.PK_TIPO_PRODUTOS ' + NL +
                          '   and Pxt.FK_PRODUTOS      = :FkProdutos '          + NL +
                          ' where Tpr.PK_TIPO_PRODUTOS > 0 '                    + NL +
                          ' order by Tpr.DSC_TPRD';

  SqlSearchProdutos0    = 'select Prd.*, Pcd.COD_REF, Pcd.FLAG_TCODE, ' + NL +
                          '       Pim.IMG_PROD, Pim.FLAG_TIMG, '        + NL +
                          '       Pct.DTA_UCMP, Pct.DTA_UMOV, Ppr.PRE_VDA ' + NL +
                          '  from PRODUTOS Prd '                        + NL +
                          '  left outer join PRODUTOS_IMAGENS Pim '     + NL +
                          '    on Pim.FK_PRODUTOS  = Prd.PK_PRODUTOS '  + NL +
                          '  left outer join PRODUTOS_CUSTOS Pct ' + NL +
                          '    on Pct.FK_EMPRESAS  = :FkEmpresas ' + NL +
                          '   and Pct.FK_PRODUTOS  = Prd.PK_PRODUTOS ' + NL +
                          '  left outer join PRODUTOS_PRECOS Ppr ' + NL +
                          '    on Ppr.FK_EMPRESAS  = :FkEmpresas ' + NL +
                          '   and Ppr.FK_PRODUTOS  = Prd.PK_PRODUTOS ' + NL +
                          '   and Ppr.FK_TABELA_PRECOS = :FkTabelaPrecos ' + NL +
                          '  join PRODUTOS_CODIGOS Pcd '                + NL +
                          '    on Pcd.FK_PRODUTOS  = Prd.PK_PRODUTOS '  + NL +
                          '   and ((Pcd.FLAG_TCODE = :FlagTCode) '      + NL +
                          '    or ( -1             = :FlagTCode))';
  SqlSearchProdutos1    = ' where Prd.FLAG_ATV     = :FlagAtv ';
  SqlSearchProdutos2    = ' order by Prd.DSC_PROD';

  SqlProdutoCod         = 'select * from PRODUTOS_CODIGOS '   + NL +
                          ' where FK_PRODUTOS = :FkProdutos ' + NL +
                          ' order by FLAG_TCODE, COD_REF';

  SqlProdutoVnd         = 'select * from PRODUTOS_VENDAS '   + NL +
                          ' where FK_PRODUTOS = :FkProdutos ';

  SqlProdPurchase       = 'select * from PRODUTOS_COMPRAS '   + NL +
                          ' where FK_PRODUTOS = :FkProdutos ';

  SqlProdSuppliers      = 'select Pfr.*, Cad.RAZ_SOC, Uni.MNMO_UNI, '             + NL +
                          '       Tds.DSC_TDSCT '                                 + NL +
                          '  from PRODUTOS_FORNECEDORES Pfr '                     + NL +
                          '  join CADASTROS Cad '                                 + NL +
                          '    on Cad.PK_CADASTROS = Pfr.FK_VW_FORNECEDORES '     + NL +
                          '  join UNIDADES Uni '                                  + NL +
                          '    on PK_UNIDADES = Pfr.FK_UNIDADES '                 + NL +
                          '  left outer join TIPO_DESCONTOS Tds '                 + NL +
                          '    on Tds.PK_TIPO_DESCONTOS = Pfr.FK_TIPO_DESCONTOS ' + NL +
                          ' where Pfr.FK_EMPRESAS = :FkEmpresas '                 + NL +
                          '   and Pfr.FK_PRODUTOS = :FkProdutos '                 + NL +
                          ' order by Cad.RAZ_SOC';

  SqlProdutoImg         = 'select * from PRODUTOS_IMAGENS '   + NL +
                          ' where FK_PRODUTOS = :FkProdutos';

  SqlPrdInsertImg       = 'insert into PRODUTOS_IMAGENS '   + NL +
                          '  (FK_PRODUTOS, FLAG_TIMG, IMG_PROD) ' + NL +
                          'values ' + NL +
                          '  (:FkProdutos, :FlagTImg, :ImgProd)';

  SqlPrdUpdateImg       = 'update PRODUTOS_IMAGENS set '   + NL +
                          '       FLAG_TIMG   = :FlagTImg, ' + NL +
                          '       IMG_PROD    = :ImgProd ' + NL +
                          ' where FK_PRODUTOS = :FkProdutos';

  SqlProdutoObs         = 'select * from PRODUTOS_CARACTERISTICAS '   + NL +
                          ' where FK_PRODUTOS = :FkProdutos';

  SqlPrdInsertObs       = 'insert into PRODUTOS_CARACTERISTICAS '   + NL +
                          ' (FK_PRODUTOS, CRT_PROD) ' + NL +
                          'values ' + NL +
                          ' (:FkProdutos, :CrtProd)';

  SqlPrdUpdateObs       = 'update PRODUTOS_CARACTERISTICAS set ' + NL +
                          '       CRT_PROD    = :CrtProd ' + NL +
                          ' where FK_PRODUTOS = :FkProdutos';

  SqlTipoFases          = 'select * from TIPO_FASES_PRODUCAO '+ NL +
                          ' order by DSC_FASE                ';

  SqlTabelaPrecos       = 'select * from TABELA_PRECOS '       + NL +
                          '  where DTA_INI < current_date '    + NL +
                          '    and ((DTA_FIN > current_date) ' + NL +
                          '     or ( DTA_FIN is null)) '       + NL +
                          '  order by DSC_TAB';

  SqlPrecosProduto      = 'select Tab.DSC_TAB, Pre.PRE_VDA, Prm.MRG_LCR,      ' + NL +
                          '       Prm.SIT_TRIB, Prm.FK_CLASSIFICACAO_FISCAL,  ' + NL +
                          '       Pre.FLAG_FIX, Tab.PK_TABELA_PRECOS          ' + NL +
                          '  from TABELA_PRECOS Tab                           ' + NL +
                          '  left outer join PRODUTOS_PRECOS Pre              ' + NL +
                          '    on Pre.FK_EMPRESAS  = :Empresa                 ' + NL +
                          '   and Pre.FK_PRODUTOS  = :Produto                 ' + NL +
                          '   and Pre.FK_TABELA_PRECOS = Tab.PK_TABELA_PRECOS ' + NL +
                          '  left outer join PRODUTOS_MARGEM Prm              ' + NL +
                          '    on Prm.FK_EMPRESAS  = :Empresa                 ' + NL +
                          '   and Prm.FK_PRODUTOS  = Pre.FK_PRODUTOS          ' + NL +
                          ' order by Tab.DSC_TAB ';

  SqlSearchPrice        = 'select  * from PRODUTOS_PRECOS     ' + NL +
                          ' where FK_EMPRESAS      = :Empresa ' + NL +
                          '   and FK_PRODUTOS      = :Produto ' + NL +
                          '   and FK_TABELA_PRECOS = :TabPreco';

  SqlSearchAllPrice     = 'select  * from PRODUTOS_PRECOS     ' + NL +
                          ' where FK_EMPRESAS      = :Empresa ' + NL +
                          '   and FK_PRODUTOS      = :Produto ';

  SqlSearchMargem       = 'select  * from PRODUTOS_MARGEM     ' + NL +
                          ' where FK_EMPRESAS      = :Empresa ' + NL +
                          '   and FK_PRODUTOS      = :Produto ';

  SqlSearchTax          = 'select  * from PRODUTOS_IMPOSTOS    ' + NL +
                          ' where FK_EMPRESAS      = :Empresa ' + NL +
                          '   and FK_PRODUTOS      = :Produto ' + NL +
                          '   and FK_TIPO_IMPOSTOS = :Imposto ';

  SqlTiposMovimTransf   = 'select * from TIPO_MOVIM_ESTQ '       + NL +
                          ' where FLAG_ES = 0 '                  + NL +
                          '   and FLAG_TBAIXA = 2 '              + NL +
                          ' order by DSC_MOV';

  SqlTiposMovim         = 'select * from TIPO_MOVIM_ESTQ '        + NL +
                          ' where ((FLAG_TMOV = :FlagTMov) '  + NL +
                          '    or (-1         = :FlagTMov)) ' + NL +
                          ' order by DSC_TMOV';

  SqlTipoMovim          = 'select * from TIPO_MOVIM_ESTQ '        + NL +
                          ' where PK_TIPO_MOVIM_ESTQ = :PkTipoMovimEstq ';

  SqlDeleteTipoMovim    = 'delete from TIPO_MOVIM_ESTQ '        + NL +
                          ' where PK_TIPO_MOVIM_ESTQ = :PkTipoMovimEstq ';

  SqlInsertTipoMovim    = 'insert into TIPO_MOVIM_ESTQ ' + NL +
                          '  (PK_TIPO_MOVIM_ESTQ, FK_TIPO_MOVIM_ESTQ, DSC_TMOV, ' + NL +
                          '  FLAG_TBAIXA, FLAG_TMOV, FLAG_OPESTQ, FLAG_MVESTQ, ' + NL +
                          '  FLAG_OPRSRV, FLAG_MVRSRV, FLAG_OPGRNT, FLAG_MVGRNT, ' + NL +
                          '  FLAG_TCOD, FLAG_GENHST, FLAG_OPQRNT, FLAG_MVQRNT) ' + NL +
                          'values ' + NL +
                          '  (:PkTipoMovimEstq, :FkTipoMovimEstq, :DscTMov, ' + NL +
                          '   :FlagTBaixa, :FlagTMov, :FlagOpEstq, :FlagMvEstq, ' + NL +
                          '   :FlagOpRsrv, :FlagMvRsrv, :FlagOpGrnt, :FlagMvGrnt, ' + NL +
                          '   :FlagTCod, :FlagGenHst, :FlagOpQrnt, :FlagMvQrnt)';

  SqlUpdateTipoMovim    = 'update TIPO_MOVIM_ESTQ set ' + NL +
                          '       FK_TIPO_MOVIM_ESTQ = :FkTipoMovimEstq, ' + NL +
                          '       DSC_TMOV           = :DscTMov, '    + NL +
                          '       FLAG_TBAIXA        = :FlagTBaixa, ' + NL +
                          '       FLAG_TMOV          = :FlagTMov, '   + NL +
                          '       FLAG_OPESTQ        = :FlagOpEstq, ' + NL +
                          '       FLAG_MVESTQ        = :FlagMvEstq, ' + NL +
                          '       FLAG_OPRSRV        = :FlagOpRsrv, ' + NL +
                          '       FLAG_MVRSRV        = :FlagMvRsrv, ' + NL +
                          '       FLAG_OPGRNT        = :FlagOpGrnt, ' + NL +
                          '       FLAG_MVGRNT        = :FlagMvGrnt, ' + NL +
                          '       FLAG_TCOD          = :FlagTCod, '   + NL +
                          '       FLAG_GENHST        = :FlagGenHst, ' + NL +
                          '       FLAG_OPQRNT        = :FlagOpQrnt, ' + NL +
                          '       FLAG_MVQRNT        = :FlagMvQrnt '  + NL +
                          ' where PK_TIPO_MOVIM_ESTQ = :PkTipoMovimEstq';

  SqlProdMoviment       = 'select Psa.DTHR_SLD, Psa.NUM_DOC, Psa.QTD_ENTRADA, Psa.QTD_SAIDA, ' + NL +
                          '       Psa.FLAG_TSLD, Psa.SLD_INS as QTD_SLD, Psa.FK_TIPO_MOVIM_ESTQ, ' + NL +
                          '       Tme.DSC_TMOV ' + NL +
                          '  from PRODUTOS_SALDOS Psa, TIPO_MOVIM_ESTQ Tme ' + NL +
                          ' where Tme.PK_TIPO_MOVIM_ESTQ = Psa.FK_TIPO_MOVIM_ESTQ ' + NL +
                          '   and Psa.FK_EMPRESAS        = :FkEmpresas ' + NL +
                          '   and Psa.FK_PRODUTOS        = :FkProdutos ';

  SqlProdMovAlmox       = 'select Psa.DTHR_SLD, Psa.NUM_DOC, Psa.QTD_ENTRADA, Psa.QTD_SAIDA, ' + NL +
                          '       Psa.FLAG_TSLD, Psa.SLD_INS as QTD_SLD, Psa.FK_TIPO_MOVIM_ESTQ, ' + NL +
                          '       Tme.DSC_TMOV ' + NL +
                          '  from PRODUTOS_SALDO_ALMX Psa, TIPO_MOVIM_ESTQ Tme ' + NL +
                          ' where Tme.PK_TIPO_MOVIM_ESTQ = Psa.FK_TIPO_MOVIM_ESTQ ' + NL +
                          '   and Psa.FK_EMPRESAS        = :FkEmpresas ' + NL +
                          '   and ((Psa.FK_ALMOXARIFADOS = :FkAlmoxarifados) ' + NL +
                          '    or (0                     = :FkAlmoxarifados)) ' + NL +
                          '   and Psa.FK_PRODUTOS        = :FkProdutos ';

  SqlProdMovOrder       = ' order by Psa.DTHR_SLD';

  SqlProdMovimAlmox     = 'select Alm.DSC_ALMX, Alm.PK_ALMOXARIFADOS, Pet.FK_ALMOXARIFADOS, ' + NL +
                          '       Lot.RUA_LOT, Lot.NIVEL_LOT, Lot.BOX_LOT, ' + NL +
                          '       Pet.QTD_ESTQ, Pet.QTD_GRNT, Pet.QTD_RSRV, ' + NL +
                          '       Pet.QTD_ESTQ_QR, Plt.QTD_LOT, Pct.QTD_PEDF ' + NL +
                          '  from ALMOXARIFADOS Alm, PRODUTOS_CUSTOS Pct, ' + NL +
                          '       PRODUTOS_ESTOQUES Pet ' + NL +
                          '  left outer join PRODUTOS_LOTACOES Plt ' + NL +
                          '  left outer join LOTACOES Lot ' + NL +
                          '    on Lot.FK_EMPRESAS      = Plt.FK_EMPRESAS ' + NL +
                          '   and Lot.FK_ALMOXARIFADOS = Plt.FK_ALMOXARIFADOS ' + NL +
                          '   and Lot.PK_LOTACOES      = Plt.FK_LOTACOES ' + NL +
//                          '/*  left outer join PRODUTOS_LOTACOES Plt */ ' + NL +
                          '    on Plt.FK_EMPRESAS      = Pet.FK_EMPRESAS ' + NL +
                          '   and Plt.FK_PRODUTOS      = Pet.FK_PRODUTOS ' + NL +
                          '   and Plt.FK_ALMOXARIFADOS = Pet.FK_ALMOXARIFADOS ' + NL +
                          ' where Alm.PK_ALMOXARIFADOS = Pet.FK_ALMOXARIFADOS ' + NL +
                          '   and Pet.FK_EMPRESAS      = :FkEmpresas ' + NL +
                          '   and Pet.FK_PRODUTOS      = :FkProdutos ' + NL +
                          '   and Pct.FK_EMPRESAS      = Pet.FK_EMPRESAS ' + NL +
                          '   and Pct.FK_PRODUTOS      = Pet.FK_PRODUTOS ' + NL +
                          ' order by Alm.DSC_ALMX, Alm.PK_ALMOXARIFADOS, Lot.RUA_LOT, ' + NL +
                          '          Lot.NIVEL_LOT, Lot.BOX_LOT';


  SqlProdutosReq        = 'select Prd.PK_PRODUTOS, Prd.DSC_PROD, Pcd.COD_REF, ' + NL +
                          '       Uni.FLAG_FRAC, Uni.DSC_UNI, Prd.FLAG_ATV, '   + NL +
                          '       Ppc.MAJ_VER, Ppc.MIN_VER, Prd.FK_UNIDADES '   + NL +
                          '  from PRODUTOS Prd '                                + NL +
                          '  join UNIDADES Uni '                                + NL +
                          '    on Uni.PK_UNIDADES = Prd.FK_UNIDADES '           + NL +
                          '  join PRODUTOS_CODIGOS Pcd '                        + NL +
                          '    on Pcd.FK_PRODUTOS = Prd.PK_PRODUTOS '           + NL +
                          '   and Pcd.FLAG_TCODE  = :TypeCode '                 + NL +
                          '   and ((Pcd.COD_REF   = :CodRef) '                  + NL +
                          '    or (cast('''' as varchar(30)) = :CodRef)) '      + NL +
                          '  left outer join PRODUTOS_PECAS Ppc '               + NL +
                          '    on Ppc.FK_PRODUTOS = Prd.PK_PRODUTOS '           + NL +
                          ' where Prd.FLAG_ATV    = 1';

  SqlProdutosLotacoes   = 'select Lot.*, Plt.FK_LOTACOES '                      + NL +
                          '  from LOTACOES Lot '                                + NL +
                          '  left outer join PRODUTOS_LOTACOES Plt '            + NL +
                          '    on Plt.FK_LOTACOES      = Lot.PK_LOTACOES '      + NL +
                          '   and Plt.FK_PRODUTOS      = :FkProdutos '          + NL +
                          '   and Plt.FK_EMPRESAS      = Lot.FK_EMPRESAS '      + NL +
                          '   and Plt.FK_ALMOXARIFADOS = Lot.FK_ALMOXARIFADOS ' + NL +
                          ' where Lot.RUA_LOT          = :RuaLot '              + NL +
                          '   and Lot.NIVEL_LOT        = :NivelLot '            + NL +
                          '   and Lot.BOX_LOT          = :BoxLot '              + NL +
                          '   and Lot.FK_EMPRESAS      = :FkEmpresas '          + NL +
                          '   and Lot.FK_ALMOXARIFADOS = :FkAlmoxarifados';

  SqlInsertProdLot      = 'insert into PRODUTOS_LOTACOES '                  + NL +
                          '  (FK_EMPRESAS, FK_PRODUTOS, FK_ALMOXARIFADOS, ' + NL +
                          '   FK_LOTACOES, QTD_LOT) '                       + NL +
                          'values '                                         + NL +
                          '  (:FkEmpresas, :FkProdutos, :FkAlmoxarifados, ' + NL +
                          '   :FkLotacoes, :QtdLot)';

  SqlInsertReqItems     = 'insert into REQUISICOES_ITEMS '                  + NL +
                          '  (FK_EMPRESAS, FK_REQUISICOES, '                + NL +
                          '   PK_REQUISICOES_ITEMS, FK_MATERIAL, COD_PROD, ' + NL +
                          '   QTD_ITM) '                                    + NL +
                          'values '                                         + NL +
                          '  (:FkEmpresas, :FkRequisicoes, '                + NL +
                          '   :PkRequisicoesItems, :FkMaterial, '             + NL +
                          '   :CodProd, :QtdItm)';

  SqlVincTab            = 'select PK_TABELA_PRECOS__VAL, FLAG_TOPE, ' + NL +
                          '       PK_TABELA_PRECOS__PRC '             + NL +
                          '  from VINC_TIPO_TABELA_PRECOS '           + NL +
                          ' where PK_TABELA_PRECO_PRC = :TabPercent ';

  SqlDeleteVincTab      = 'delete from VINC_TIPO_TABELA_PRECOS ' + NL +
                          ' where PK_TABELA_PRECO_PRC = :TabPercent ';

  SqlInsertVincTab      = 'insert into VINC_TIPO_TABELA_PRECOS '              + NL +
                          '  (PK_TABELA_PRECOS__PRC, PK_TABELA_PRECOS__VAL, ' + NL +
                          '   FLAG_TOPE ) '                                   + NL +
                          'values '                                           + NL +
                          '  (:PkTabelaPrecoPrc, :PkTabelaPrecosVal, :FlagTOpe)';

  SqlSelectTabValues    = 'select * from TABELA_PRECOS '      + NL +
                          ' where FLAG_TPRE = 1 '             + NL +
                          '   and DTA_INI   <= current_date ' + NL +
                          '   and DTA_FIN   >= current_date ' + NL +
                          ' order by DSC_TAB ';

  SqlDeleteProduto      = 'delete from PRODUTOS '             + NL +
                          ' where PK_PRODUTOS = :PkProdutos ';

  SqlUpdateProduto      = 'update PRODUTOS set '                 + NL +
                          '       FK_PRODUTOS_GRUPOS = :FkProdutosGrupos, ' + NL +
                          '       FK_UNIDADES  = :FkUnidades, '  + NL +
                          '       DSC_PROD     = :DscProd, '     + NL +
                          '       FLAG_ATV     = :FlagAtv '      + NL +
                          ' where PK_PRODUTOS  = :PkProdutos';

  SqlInsertProduto      = 'insert into PRODUTOS '                                + NL +
                          '  (FK_PRODUTOS_GRUPOS, FK_UNIDADES, ' + NL +
                          '   DSC_PROD, FLAG_ATV, PK_PRODUTOS) '                 + NL +
                          'values '                                              + NL +
                          '  (:FkProdutosGrupos, :FkUnidades, ' + NL +
                          '   :DscProd, :FlagAtv, :PkProdutos)';

  SqlSelectDescrLang    = 'select Dcl.*, Lng.DSC_LANG '                     + NL +
                          '  from DESCRICOES_PRD_LANG Dcl, LINGUAGENS Lng ' + NL +
                          ' where Dcl.FK_PRODUTOS = :FkProdutos '           + NL +
                          '   and Lng.PK_LINGUAGENS = Dcl.FK_LINGUAGENS ';

  SqlInsertDescrLang    = 'insert into DESCRICOES_PRD_LANG '                       + NL +
                          '  (FK_LINGUAGENS, FK_PRODUTOS, DSC_PROD, DSC_PROD_RED ' + NL +
                          'values '                                                + NL +
                          '  (:FkLinguagens, :FkProdutos, :DscProd, :DscProdRed) ';

  SqlUpdateDescrLang    = 'update DESCRICOES_PRD_LANG set '        + NL +
                          '       DSC_PROD      = :DscProd, '      + NL +
                          '       DSC_PROD_RED  = :DscProdRed '    + NL +
                          ' where FK_LINGUAGENS = :FkLinguagens '                                + NL +
                          '   and FK_PRODUTOS   = :FkProdutos ';

  SqlSelectPkPrdCode    = 'select (MAX(PK_PRODUTOS_CODIGOS) + 1) ' + NL +
                          '    as PK_PRODUTOS_CODIGOS '            + NL +
                          '  from PRODUTOS_CODIGOS '               + NL +
                          ' where FK_PRODUTOS = :FkProdutos';

  SqlDeletePrdCode      = 'delete from PRODUTOS_CODIGOS '             + NL +
                          ' where FK_PRODUTOS         = :FkProdutos ' + NL +
                          '   and PK_PRODUTOS_CODIGOS = :PkProdutosCodigos';

  SqlUpdatePrdCode      = 'update PRODUTOS_CODIGOS set '                + NL +
                          '       COD_REF             = :CodRef, '      + NL +
                          '       FLAG_TCODE          = :FlagTCode, '   + NL +
                          '       FLAG_TBARCODE       = :FlagTBarCode, ' + NL +
                          '       DSC_CODE            = :DscCode '      + NL +
                          ' where FK_PRODUTOS         = :FkProdutos '   + NL +
                          '   and PK_PRODUTOS_CODIGOS = :PkProdutosCodigos';

  SqlInsertPrdCode      = 'insert into PRODUTOS_CODIGOS '                  + NL +
                          '  (FK_PRODUTOS, PK_PRODUTOS_CODIGOS, COD_REF, ' + NL +
                          '   FLAG_TCODE, FLAG_TBARCODE, DSC_CODE) '       + NL +
                          'values '                                        + NL +
                          '  (:FkProdutos, :PkProdutosCodigos, :CodRef, '   + NL +
                          '   :FlagTCode, :FlagTBarCode, :DscCode)';

  SqlUpdatePrdSale      = 'update PRODUTOS_VENDAS set '                 + NL +
                          '       DSC_PROD_RED        = :DscProdRed, '  + NL +
                          '       FLAG_IMP            = :FlagImp, '     + NL +
                          '       PES_BRU             = :PesBru, '      + NL +
                          '       PES_LIQ             = :PesLiq, '      + NL +
                          '       ALT_PROD            = :AltProd, '     + NL +
                          '       PROF_PROD           = :ProfProd, '    + NL +
                          '       LARG_PROD           = :LargProd, '    + NL +
                          '       ALT_EPROD           = :AltEProd, '    + NL +
                          '       PROF_EPROD          = :ProfEProd, '   + NL +
                          '       LARG_EPROD          = :LargEProd, '   + NL +
                          '       ALT_IPROD           = :AltIProd, '    + NL +
                          '       PROF_IPROD          = :ProfIProd, '   + NL +
                          '       LARG_IPROD          = :LargIProd, '   + NL +
                          '       FAT_CONV_CUB        = :FatConvCub, '  + NL +
                          '       FK_LINHAS           = :FkLinhas, '    + NL +
                          '       FK_SIMILARES        = :FkSimilares '  + NL +
                          ' where FK_PRODUTOS         = :FkProdutos ';

  SqlInsertPrdSale      = 'insert into PRODUTOS_VENDAS '                         + NL +
                          '  (FK_PRODUTOS, DSC_PROD_RED, FLAG_IMP, PES_BRU, '    + NL +
                          '   PES_LIQ, ALT_PROD, PROF_PROD, LARG_PROD, '         + NL +
                          '   ALT_EPROD, PROF_EPROD, LARG_EPROD, ALT_IPROD, '    + NL +
                          '   PROF_IPROD, LARG_IPROD, FAT_CONV_CUB, FK_LINHAS, ' + NL +
                          '   FK_SIMILARES) '                                    + NL +
                          'values '                                              + NL +
                          '  (:FkProdutos, :DscProdRed, :FlagImp, :PesBru, '     + NL +
                          '   :PesLiq, :AltProd, :ProfProd, :LargProd,  '        + NL +
                          '   :AltEProd, :ProfEProd, :LargEProd, :AltIProd, '    + NL +
                          '   :ProfIProd, :LargIProd, :FatConvCub, :FkLinhas, '  + NL +
                          '   :FkSimilares)';

  SelectProductMargim   = 'select * from PRODUTOS_MARGEM '       + NL +
                          ' where FK_PRODUTOS   = :FkProdutos '  + NL +
                          '   and ((FK_EMPRESAS = :FkEmpresas) ' + NL +
                          '    or ( 0           = :FkEmpresas))';

  SqlProductCustos      = 'select Pct.*, Cad.RAZ_SOC '            + NL +
                          '  from PRODUTOS_CUSTOS Pct '           + NL +
                          '  left outer join CADASTROS Cad '      + NL +
                          '    on Cad.PK_CADASTROS = Pct.FK_VW_FORNECEDORES ' + NL +
                          ' where Pct.FK_EMPRESAS = :FkEmpresas ' + NL +
                          '   and Pct.FK_PRODUTOS = :FkProdutos';

  SelectProductPrices   = 'select Tab.DSC_TAB, Emp.RAZ_SOC, Prp.PRE_VDA, ' + NL +
                          '       Prp.FLAG_FIX, Pmr.SIT_TRIB, Pmr.MRG_LCR, ' + NL +
                          '       Pmr.FK_CLASSIFICACAO_FISCAL, Emp.PK_EMPRESAS, ' + NL +
                          '       Pmr.FK_ORIGENS_TRIBUTARIAS, Prp.FK_PRODUTOS, ' + NL +
                          '       Pmr.FK_SITUACAO_TRIBUTARIAS, Tab.PK_TABELA_PRECOS, ' + NL +
                          '       Cast(3 as smallint) as STATUS ' + NL +
                          '  from TABELA_PRECOS Tab ' + NL +
                          '  left outer join  EMPRESAS Emp ' + NL +
                          '    on Emp.PK_EMPRESAS > 0 ' + NL +
                          '  left outer join PRODUTOS_MARGEM Pmr ' + NL +
                          '  left outer join PRODUTOS_PRECOS Prp ' + NL +
                          '    on Prp.FK_EMPRESAS      = Pmr.FK_EMPRESAS ' + NL +
                          '   and Prp.FK_PRODUTOS      = Pmr.FK_PRODUTOS ' + NL +
                          '   and Prp.FK_TABELA_PRECOS = Tab.PK_TABELA_PRECOS ' + NL +
                          '    on Pmr.FK_EMPRESAS      = Emp.PK_EMPRESAS ' + NL +
                          '   and Pmr.FK_PRODUTOS      = :FkProdutos ' + NL +
                          ' where PK_TABELA_PRECOS     > 0 ' + NL +
                          '   and Tab.DTA_INI          <= current_date ' + NL +
                          '   and ((Tab.DTA_FIN        >= current_date) ' + NL +
                          '    or ( Tab.DTA_FIN        is null)) ' + NL +
                          ' order by Tab.DSC_TAB, Emp.RAZ_SOC';

  SqlInsertPrdPrices    = 'insert into PRODUTOS_PRECOS                    ' + NL +
                          '  (FK_EMPRESAS, FK_PRODUTOS, FK_TABELA_PRECOS, ' + NL +
                          '   PRE_VDA, FLAG_FIX)                          ' + NL +
                          'values                                         ' + NL +
                          '  (:FkEmpresas, :FkProdutos, :FkTabelaPrecos, :PreVda, :FlagFix)';

  SqlUpdatePrdPrices    = 'update PRODUTOS_PRECOS set ' + NL +
                          '       PRE_VDA          = :PreVda, ' + NL +
                          '       FLAG_FIX         = :FlagFix ' + NL +
                          ' where FK_EMPRESAS      = :FKEmpresas ' + NL +
                          '   and FK_PRODUTOS      = :FkProdutos ' + NL +
                          '   and FK_TABELA_PRECOS = :FkTabelaPrecos';

  SqlDeletePrdPrices    = 'delete from PRODUTOS_PRECOS '        + NL +
                          ' where FK_EMPRESAS      = :FkEmpresas ' + NL +
                          '   and FK_PRODUTOS      = :FkProdutos ' + NL +
                          '   and FK_TABELA_PRECOS = :FkTabelaPrecos';

  SqlInsertPrdCost      = 'insert into PRODUTOS_CUSTOS '                + NL +
                          '  (FK_EMPRESAS, FK_PRODUTOS, CUST_FINAL, '   + NL +
                          '   CUST_RJST, QTD_DIAS_REP, QTD_DIAS_ENTR, ' + NL +
                          '   FLAG_RJST, QTD_EMAX, QTD_EMIN, '          + NL +
                          '   DTA_PRV_ENTR_COMPRA, DTA_UCMP, DTA_UMOV) ' + NL +
                          'values '                                     + NL +
                          '  (:FkEmpresas, :FkProdutos, :CustFinal, '   + NL +
                          '   :CustRjst, :QtdDiasRep, :QtdDiasEntr, '   + NL +
                          '   :FlagRjst, :QtdEMax, :QtdEMin, '          + NL +
                          '   :DtaPrvEntrCompra, :DtaUCmp, :DtaUMov)';

  SqlUpdatePrdCost      = 'update PRODUTOS_CUSTOS set '                    + NL +
                          '       CUST_FINAL          = :CustFinal, '      + NL +
                          '       CUST_RJST           = :CustRjst, '       + NL +
                          '       QTD_DIAS_REP        = :QtdDiasRep, '     + NL +
                          '       QTD_DIAS_ENTR       = :QtdDiasEntr, '    + NL +
                          '       FLAG_RJST           = :FlagRjst, '       + NL +
                          '       QTD_EMAX            = :QtdEMax, '        + NL +
                          '       QTD_EMIN            = :QtdEMin, '        + NL +
                          '       DTA_UCMP            = :DtaUCmp, '        + NL +
                          '       DTA_UMOV            = :DtaUMov, '        + NL +
                          '       DTA_PRV_ENTR_COMPRA = :DtaPrvEntrCompra '+ NL +
                          ' where FK_EMPRESAS         = :FkEmpresas '      + NL +
                          '   and FK_PRODUTOS         = :FkProdutos ';

  SqlInsProdPurchase    = 'insert into PRODUTOS_COMPRAS '           + NL +
                          '  (FK_PRODUTOS, VLR_UNIT, FLAG_EMP, '    + NL +
                          '   FLAG_CMPR, FLAG_TMAT, '               + NL +
                          '   FK_TIPO_ACABAMENTOS, '                + NL +
                          '   FK_TIPO_REFERENCIAS) '                + NL +
                          'values '                                 + NL +
                          '  (:FkProdutos, :VlrUnit, '              + NL +
                          '   :FlagEmp, :FlagCmpr, :FLagTMat, '     + NL +
                          '   :FkTipoAcabamentos, :FkTipoReferencias)';

  SqlUpdProdPurchase    = 'update PRODUTOS_COMPRAS set '                      + NL +
                          '       VLR_UNIT            = :VlrUnit, '           + NL +
                          '       FLAG_EMP            = :FlagEmp, '           + NL +
                          '       FLAG_CMPR           = :FlagCmpr, '          + NL +
                          '       FLAG_TMAT           = :FLagTMat, '          + NL +
                          '       FK_TIPO_ACABAMENTOS = :FkTipoAcabamentos, ' + NL +
                          '       FK_TIPO_REFERENCIAS = :FkTipoReferencias '  + NL +
                          ' where FK_PRODUTOS         = :FkProdutos ';

  SqlDeletePrdSupplier  = 'delete from PRODUTOS_FORNECEDORES '         + NL +
                          ' where FK_EMPRESAS        = :FkEmpresas '   + NL +
                          '   and FK_PRODUTOS        = :FkProdutos '   + NL +
                          '   and FK_VW_FORNECEDORES = :FkVwFornecedores';

  SqlDeletePrdMargim    = 'delete from PRODUTOS_MARGEM '      + NL +
                          ' where FK_EMPRESAS = :FkEmpresas ' + NL +
                          '   and FK_PRODUTOS = :FkProdutos ';

  SqlSelectPrdImpostos  = 'select R_FK_EMPRESAS, R_DSC_IMPS, R_RAZ_SOC, ' + NL +
                          '       R_FK_TIPO_IMPOSTOS, R_FK_PRODUTOS, ' + NL +
                          '       Cast(3 as smallint) as STATUS ' + NL +
                          '  from STP_GET_ALL_TAXES_FROM_INSUMO(:FkProdutos)';

  SqlInsertPrdImpostos  = 'insert into PRODUTOS_IMPOSTOS '                  + NL +
                          '  (FK_EMPRESAS, FK_PRODUTOS, FK_TIPO_IMPOSTOS) ' + NL +
                          'values '                                         + NL +
                          '  (:FkEmpresas, :FkProdutos, :FkTipoImpostos)' ;

  SqlDeletePrdImpostos  = 'delete from PRODUTOS_IMPOSTOS '         + NL +
                          ' where FK_EMPRESAS      = :FkEmpresas ' + NL +
                          '   and FK_PRODUTOS      = :FkProdutos ' + NL +
                          '   and FK_TIPO_IMPOSTOS = :FkTipoImpostos';

  SqlProdutosSaldos     = 'select Psl.*, Cad.RAZ_SOC, Tme.DSC_TMOV, '   + NL +
                          '       Tdc.DSC_TDOC '                        + NL +
                          '  from PRODUTOS_SALDOS Psl '                 + NL +
                          '  left outer join CADASTROS Cad '            + NL +
                          '    on Cad.PK_CADASTROS = Psl.FK_CADASTROS ' + NL +
                          '  left outer join TIPO_MOVIM_ESTQ Tme '      + NL +
                          '    on Tme.PK_TIPO_MOVIM_ESTQ = Psl.FK_TIPO_MOVIM_ESTQ ' + NL +
                          '  left outer join TIPO_DOCUMENTOS Tdc '      + NL +
                          '    on Tdc.PK_TIPO_DOCUMENTOS = Psl.FK_TIPO_DOCUMENTOS ' + NL +
                          ' where Psl.FK_EMPRESAS = :FkEmpresas '       + NL +
                          '   and Psl.FK_PRODUTOS = :FkProdutos '       + NL +
                          '   and Psl.DTHR_SLD    > :DthrSldIni '       + NL +
                          '   and Psl.DTHR_SLD    < :DthrSldFin '       + NL +
                          ' order by DTHR_SLD';

  SqlProdCostHist       = 'select Pht.*, Cad.RAZ_SOC, '                     + NL +
                          '       Ant.RAZ_SOC as RAZ_SOC_ANT '              + NL +
                          '  from PRODUTOS_HISTORICOS Pht '                 + NL +
                          '  left outer join CADASTROS Cad '                + NL +
                          '    on Cad.PK_CADASTROS = Pht.FK_CADASTROS '     + NL +
                          '  left outer join CADASTROS Ant '                + NL +
                          '    on Ant.PK_CADASTROS = Pht.FK_CADASTROS_ANT ' + NL +
                          ' where Pht.FK_EMPRESAS = :FkEmpresas '           + NL +
                          '   and Pht.FK_PRODUTOS = :FkProdutos '           + NL +
                          '   and Pht.DTHR_INC    > :DthrIncIni - 1 '       + NL +
                          '   and Pht.DTHR_INC    < :DthrIncFin + 1 '       + NL +
                          ' order by Pht.DTHR_INC';

  SqlCompositions       = 'select Tcp.DSC_COMP, Tcp.PK_TIPO_COMPOSICOES, '   + NL +
                          '       Tcp.FLAG_ATV '                             + NL +
                          '  from PRODUTOS Prd, TIPO_COMPOSICOES Tcp '       + NL +
                          ' where Prd.PK_PRODUTOS = :FkProdutos '            + NL +
                          '   and Tcp.FK_PRODUTOS = Prd.PK_PRODUTOS '        + NL +
                          ' order by Tcp.DSC_COMP ';

  SqlInsumosComposicao  = 'select Prd.DSC_PROD, Cmp.* '                          + NL +
                          '  from COMPOSICOES Cmp, PRODUTOS Prd '                + NL +
                          ' where Cmp.FK_PRODUTOS         = :FkProdutos '        + NL +
                          '   and Cmp.FK_TIPO_COMPOSICOES = :FkTipoComposicoes ' + NL +
                          '   and Prd.PK_PRODUTOS         = Cmp.FK_INSUMOS '     + NL +
                          ' order by SEQ_COMP ';

  SqlDelPrdInsumosComp  = 'delete from PRODUTOS_COMPOSICOES ' + NL +
                          ' where FK_PRODUTOS = :FkProdutos ';

  SqlInsPrdInsumosComp  = 'insert into PRODUTOS_COMPOSICOES '                     + NL +
                          '  (FK_PRODUTOS, PK_PRODUTOS_COMPOSICOES, FK_INSUMOS, ' + NL +
                          '   QTD_PROD, FLAG_TCOMP, SEQ_COMP, FLAG_DEF, MED_DEF) '+ NL +
                          '   select FK_PRODUTOS, 0, FK_INSUMOS, QTD_PROD, '      + NL +
                          '          FLAG_TCOMP, SEQ_COMP, FLAG_DEF, MED_DEF '    + NL +
                          '     from COMPOSICOES '                                + NL +
                          '    where FK_PRODUTOS = :FkProdutos '                  + NL +
                          '      and FK_TIPO_COMPOSICOES = :FkTipoComposicoes '   + NL +
                          '    order by SEQ_COMP ';

  SqlDelInsumosComp     = 'delete from COMPOSICOES '                  + NL +
                          ' where FK_PRODUTOS         = :FkProdutos ' + NL +
                          '   and FK_TIPO_COMPOSICOES = :FkTipoComposicoes';

  SqlDelInsumoComp      = 'delete from COMPOSICOES '                  + NL +
                          ' where FK_PRODUTOS         = :FkProdutos ' + NL +
                          '   and FK_TIPO_COMPOSICOES = :FkTipoComposicoes' + NL +
                          '   and PK_COMPOSICOES      = :PkComposicoes';

  SqlInsInsumosComp     = 'insert into COMPOSICOES '                              + NL +
                          '  (FK_PRODUTOS, FK_TIPO_COMPOSICOES, PK_COMPOSICOES, ' + NL +
                          '   FK_INSUMOS, QTD_PROD, FLAG_TCOMP, SEQ_COMP, '       + NL +
                          '   FLAG_DEF, MED_DEF) '                                + NL +
                          'values '                                               + NL +
                          '  (:FkProdutos, :FkTipoComposicoes, :PkComposicoes, '  + NL +
                          '   :FkInsumos, :QtdProd, :FlagTComp, :SeqComp, '       + NL +
                          '   :FlagDef, :MedDef)';

  SqlUpdInsumosComp     = 'update COMPOSICOES set '                           + NL +
                          '       FK_PRODUTOS         = :FkProdutos, '        + NL +
                          '       FK_TIPO_COMPOSICOES = :FkTipoComposicoes, ' + NL +
                          '       FK_COMPOSICOES      = :PkComposicoes, '     + NL +
                          '       FK_INSUMOS          = :FkInsumos, '         + NL +
                          '       QTD_PROD            = :QtdProd, '           + NL +
                          '       FLAG_TCOMP          = :FlagTComp, '         + NL +
                          '       SEQ_COMP            = :SeqComp, '           + NL +
                          '       FLAG_DEF            = :FlagDef, '           + NL +
                          '       MED_DEF             = :MedDef '             + NL +
                          ' where FK_PRODUTOS         = :FkProdutos '         + NL +
                          '   and FK_TIPO_COMPOSICOES = :FkTipoComposicoes '  + NL +
                          '   and PK_COMPOSICOES      = :PkComposicoes';

  SqlInsertTipoCompo    = 'insert into TIPO_COMPOSICOES '                             + NL +
                          '  (FK_PRODUTOS, PK_TIPO_COMPOSICOES, DSC_COMP, FLAG_ATV) ' + NL +
                          'values '                                                   + NL +
                          '  (:FkProdutos, :PkTipoComposicoes, :DscComp, :FlagAtv)';

  SqlUpdateTipoCompo    = 'update TIPO_COMPOSICOES set '              + NL +
                          '       DSC_COMP = :DscComp, '              + NL +
                          '       FLAG_ATV = :FlagAtv '               + NL +
                          ' where FK_PRODUTOS         = :FkProdutos ' + NL +
                          '   and PK_TIPO_COMPOSICOES = :PkTipoComposicoes';

  SqlUpdateActiveTCompo = 'update TIPO_COMPOSICOES set '              + NL +
                          '       FLAG_ATV = :FlagAtv '               + NL +
                          ' where FK_PRODUTOS         = :FkProdutos ' + NL +
                          '   and PK_TIPO_COMPOSICOES = :PkTipoComposicoes';

  SqlMaterials          = 'select * from VW_MATERIAL ' + NL +
                          ' order by DSC_PROD';

  SqlActivity           = 'select * from VW_ATIVIDADES ' + NL +
                          ' order by DSC_PROD';

  SqlProductService     = 'select * from PRODUTOS_SERVICOS ' + NL +
                          ' where FK_PRODUTOS = :FkProdutos ';

  SqlDeleteProductSrv   = 'delete from PRODUTOS_SERVICOS ' + NL +
                          ' where FK_PRODUTOS = :FkProdutos ';

  SqlInsertProductSrv   = 'insert into PRODUTOS_SERVICOS ' + NL +
                          ' (FK_PRODUTOS, FLAG_ATV, VLR_UNIT) ' + NL +
                          'values ' + NL +
                          ' (:FkProdutos, :FlagAtv, :VlrUnit)';

  SqlUpdateProductSrv   = 'update PRODUTOS_SERVICOS set' + NL +
                          '       FLAG_ATV    = :FlagAtv, ' + NL +
                          '       VLR_UNIT    = :VlrUnit ' + NL +
                          ' where FK_PRODUTOS = :FkProdutos ';

  SqlProductCarrier     = 'select * from PRODUTOS_FRETES ' + NL +
                          ' where FK_PRODUTOS = :FkProdutos ';

  SqlDeleteProdCarrier  = 'delete from PRODUTOS_FRETES ' + NL +
                          ' where FK_PRODUTOS = :FkProdutos ';

  SqlInsertProdCarrier  = 'insert into PRODUTOS_FRETES ' + NL +
                          ' (FK_PRODUTOS, FLAG_TP_FRE, FLAG_RDSP) ' + NL +
                          'values ' + NL +
                          ' (:FkProdutos, :FlagTpFre, :FlagRdsp)';

  SqlUpdateProdCarrier  = 'update PRODUTOS_FRETES set' + NL +
                          '       FLAG_TP_FRE = :FlagTpFre, ' + NL +
                          '       FLAG_RDSP   = :FlagRdsp ' + NL +
                          ' where FK_PRODUTOS = :FkProdutos ';

  SqlGroupMovPurch       = 'select PK_GRUPOS_MOVIMENTOS ' + NL +
                           '  from GRUPOS_MOVIMENTOS '    + NL +
                           ' where FLAG_ES   = 0 '        + NL +
                           '   and FLAG_DEV  = 0 '        + NL +
                           '   and FLAG_ORGM = 1 '        + NL +
                           '   and FLAG_DSTI = 0 ';

  SqlGenereteReference   = 'select * from STP_GENERATE_REFERENCE(:FkProdutosGrupos)';

  SqlCountCodes          = 'select Count(*) as QTD_ROWS from PRODUTOS_CODIGOS ' + NL +
                           '   where COD_REF = :CodRef ' + NL +
                           '     and FLAG_TCODE = 0';

  SqlRequisicoesItems    = 'select Rqi.*, Cast('''' as varchar(30)) as DSC_PROD, ' + NL +
                           '       Cast('''' as varchar(30)) as DSC_UNI, ' + NL +
                           '       Lor.RUA_LOT as RUA_LOT_ORGM, Lor.NIVEL_LOT as NIVEL_LOT_ORGM, ' + NL +
                           '       Lor.BOX_LOT as BOX_LOT_ORGM, ' + NL +
                           '       Cast('''' as varchar(30)) as DSC_LOT_ORGM, ' + NL +
                           '       Cast(0 as integer) as IcLotORGM, ' + NL +
                           '       Lds.RUA_LOT as RUA_LOT_DSTN, Lds.NIVEL_LOT as NIVEL_LOT_DSTN, ' + NL +
                           '       Lds.BOX_LOT as BOX_LOT_DSTN, ' + NL +
                           '       Cast('''' as varchar(30)) as DSC_LOT_DSTN, ' + NL +
                           '       Cast(0 as integer) as IcLotDSTN ' + NL +
                           '  from REQUISICOES Req, REQUISICOES_ITEMS Rqi ' + NL +
                           '  left outer join LOTACOES Lor ' + NL +
                           '    on Lor.FK_EMPRESAS         = Rqi.FK_EMPRESAS ' + NL +
                           '   and Lor.PK_LOTACOES         = Rqi.FK_LOTACAO_ORGM ' + NL +
                           '   and Lor.FK_ALMOXARIFADOS    = Req.FK_ALMOXARIFADOS ' + NL +
                           '  left outer join LOTACOES Lds ' + NL +
                           '    on Lds.FK_EMPRESAS         = Rqi.FK_EMPRESAS ' + NL +
                           '   and Lds.PK_LOTACOES         = Rqi.FK_LOTACAO_DSTN ' + NL +
                           '   and Lds.FK_ALMOXARIFADOS    = Req.FK_ALMOXARIFADOS__DST ' + NL +
                           'where Req.FK_EMPRESAS          = :FkEmpresas ' + NL +
                           '  and Req.PK_REQUISICOES       = :FkRequisicoes ' + NL +
                           '  and Rqi.FK_EMPRESAS          = Req.FK_EMPRESAS ' + NL +
                           '  and Rqi.FK_REQUISICOES       = Req.PK_REQUISICOES ' + NL +
                           '  and Rqi.PK_REQUISICOES_ITEMS = :PkRequisicoesItems';

  SqlInsReqItems         = 'insert into REQUISICOES_ITEMS ' + NL +
                           '  (FK_EMPRESAS, FK_REQUISICOES, PK_REQUISICOES_ITEMS, FK_PRODUTOS, ' + NL +
                           '   FK_LOTACAO_ORGM, FK_LOTACAO_DSTN, COD_PROD, QTD_ITM, STT_BXA) ' + NL +
                           'values ' + NL +
                           '  (:FkEmpresas, :FkRequisicoes, :PkRequisicoesItems, :FkProdutos, ' + NL +
                           '   :FkLotacaoOrgm, :FkLotacaoDstn, :CodProd, :QtdItm, :SttBxa)';

  SqlLotacoes           =  'select * from LOTACOES ' + NL +
                           ' where FK_EMPRESAS      = :FkEmpresas ' + NL +
                           '   and FK_ALMOXARIFADOS = :FkAlmoxarifados ' + NL +
                           '   and RUA_LOT          = :RuaLot ' + NL +
                           '   and NIVEL_LOT        = :NivelLot ' + NL +
                           '   and BOX_LOT          = :BoxLot';

  SqlInsLotacoes         = 'insert into LOTACOES ' + NL +
                           '  (FK_EMPRESAS, FK_ALMOXARIFADOS, RUA_LOT, ' + NL +
                           '   NIVEL_LOT, BOX_LOT) ' + NL +
                           'values ' + NL +
                           '  (:FkEmpresas, :FkAlmoxarifados, :RuaLot,  ' + NL +
                           '   :NivelLot, :BoxLot)';


  SqlLotacao            =  'select * from LOTACOES ' + NL +
                           ' where FK_EMPRESAS      = :FkEmpresas ' + NL +
                           '   and FK_ALMOXARIFADOS = :FkAlmoxarifados ' + NL +
                           '   and PK_LOTACOES      = :PkLotacoes';

  // Select SQL for the aux tables from other modules

  SqlAlmoxLotacao       = 'select Alm.*, Lot.PK_LOTACOES, Lot.RUA_LOT, Lot.NIVEL_LOT, ' + NL +
                          '       Lot.BOX_LOT ' + NL +
                          '  from ALMOXARIFADOS Alm ' + NL +
                          '  left outer join LOTACOES Lot ' + NL +
                          '    on Lot.FK_EMPRESAS      = :FkEmpresas ' + NL +
                          '   and Lot.FK_ALMOXARIFADOS = Alm.PK_ALMOXARIFADOS ' + NL +
                          ' where Alm.PK_ALMOXARIFADOS > 0 ' + NL +
                          ' order by DSC_ALMX, Lot.RUA_LOT, Lot.NIVEL_LOT, Lot.BOX_LOT';

  SqlFinanceAccounts    = 'select * from STP_GET_FINANCEIRO_CONTAS ' + NL +
                          ' where ((R_FLAG_TCTA = :FlagTCta) ' + NL +
                          '   or  ( -1          = :FlagTCta))';

//  SqlClassification     = 'select * from STP_GET_FINANCEIRO_CONTAS';

  SqlDeliveryPeriod     = 'select * from TIPO_PRAZO_ENTREGA ' + NL +
                          ' order by DSC_PRZE';

  SqlTipoAcabamentos    = 'select * from TIPO_ACABAMENTOS ' + NL +
                          ' order by DSC_ACABM';

  SqlTipoReferencias    = 'select * from TIPO_REFERENCIAS               '    + NL +
                          ' where FK_TIPO_ACABAMENTOS = :FkTipoAcabamentos ' + NL +
                          ' order by DSC_REF';

  SqlLinguagens         = 'select * from LINGUAGENS '+ NL +
                          ' order by DSC_LANG       ';

  SqlLangToInsert       = 'select Lng.PK_LINGUAGENS, Lng.DSC_LANG '                                + NL +
                          '  from LINGUAGENS Lng '                                                 + NL +
                          ' where Lng.PK_LINGUAGENS not in (select FK_LINGUAGENS '                 + NL +
                          '                                   from DESCRICOES_PRD_LANG Dcl '       + NL +
                          '                                  where Dcl.FK_PRODUTOS = :FkProduto) ' + NL +
                          '   and Lng.PK_LINGUAGENS <> (select FK_LINGUAGENS '                 + NL +
                          '                               from PAISES '                        + NL +
                          '                              where PK_PAISES = :FkPaises) '            + NL +
                          ' order by DSC_LANG';

  SqlTipoDescontos      = 'select * from TIPO_DESCONTOS ' + NL +
                          ' where FK_GRUPOS_MOVIMENTOS = :FkGruposMovimentos ' + NL +
                          ' order by DSC_TDSCT';

  SqlDescontos          = 'select * from DESCONTOS                      '+ NL +
                          ' where FK_TIPO_DESCONTOS = :Fk_Tipo_Descontos ' + NL +
                          ' order by IDX_DSCT                           ';

  SqlImpostos           = 'select DSC_IMPS, PK_TIPO_IMPOSTOS, FLAG_CALC, ' + NL +
                          '       FLAG_IMPST, RED_BASC                   ' + NL +
                          '    from TIPO_IMPOSTOS order by DSC_IMPS      ';

  SqlClassFiscal        = 'select * from CLASSIFICACAO_FISCAL order by DSC_CLSF';

  SqlNatureOperation    = 'select * from NATUREZA_OPERACOES order by COD_CFOP';

  SqlOrigemTrb          = 'select * from ORIGENS_TRIBUTARIAS order by DSC_ORGM';

  SqlSituacaoTrb        = 'select * from SITUACAO_TRIBUTARIAS order by DSC_IMPST';

  SqlTipoDocumentos     = 'select * from TIPO_DOCUMENTOS ' + NL +
                          ' where FLAG_TDOC in (0, 2, 4, 6, 7, 8) ' + NL +
                          ' order by DSC_TDOC';

  SqlRegions            = 'select * from CARGAS_REGIOES ' + NL +
                          ' order by DSC_REG';

var
  Variables: array of string;

implementation

end.
