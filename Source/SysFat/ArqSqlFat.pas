unit ArqSqlFat;

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

var
  Variables: array of string;

resourcestring
  SqlCompanies     = 'select * from EMPRESAS ' + NL +
                     ' order by RAZ_SOC';

  SqlGenPkCenary   = 'select R_PK_CENARIOS_FINANCEIROS as PK_CENARIOS_FINANCEIROS ' + NL +
                     '  from STP_GET_PK_CENARIOS_FINANCEIROS ';

  SqlCenaries      = 'select * from CENARIOS_FINANCEIROS ' + NL +
                     ' where FK_EMPRESAS = :FkEmpresas ' + NL +
                     ' order by DSC_CEN';

  SqlCenary        = 'select * from CENARIOS_FINANCEIROS ' + NL +
                     ' where PK_CENARIOS_FINANCEIROS = :PkCenariosFinanceiros';

  SqlDeleteCenary  = 'delete from CENARIOS_FINANCEIROS ' + NL +
                     ' where PK_CENARIOS_FINANCEIROS = :PkCenariosFinanceiros';

  SqlInsertCenary  = 'insert into CENARIOS_FINANCEIROS ' + NL +
                     ' (PK_CENARIOS_FINANCEIROS, FK_EMPRESAS, DSC_CEN, FLAG_TPCEN) ' + NL +
                     'values ' + NL +
                     ' (:PkCenariosFinanceiros, :FkEmpresas, :DscCen, :FlagTpCen)';

  SqlUpdateCenary  = 'update CENARIOS_FINANCEIROS set ' + NL +
                     '       FK_EMPRESAS = :FkEmpresas, ' + NL +
                     '       DSC_CEN     = :DscCen, ' + NL +
                     '       FLAG_TPCEN  = :FlagTpCen ' + NL +
                     'where PK_CENARIOS_FINANCEIROS = :PkCenariosFinanceiros ';

  SqlFinAccounts   = 'select * from STP_GET_FINANCEIRO_CONTAS';

  SqlCtbAccounts   = 'select * from STP_GET_PLANO_CONTAS ' + NL +
                     ' where ((R_FLAG_TCTA = :FlagTCta) ' + NL +
                     '    or (-1           = :FlagTCta)) ' + NL +
                     '   and ((R_FLAG_ID   = :FlagID) ' + NL +
                     '    or (-1           = :FlagID))';

  SqlFinAccount    = 'select * from FINANCEIRO_CONTAS ' + NL +
                     ' where PK_FINANCEIRO_CONTAS = :PkFinanceiroContas';

  SqlUpdateClass   = 'update FINANCEIRO_CONTAS set '                  + NL +
                     '       SEQ_CTA              = :SeqCta, '        + NL +
                     '       FK_PLANO_CONTAS      = :FkPlanoContas, ' + NL +
                     '       DSC_CTA              = :DscCta, '        + NL +
                     '       FLAG_TCTA            = :FlagTCta, '      + NL +
                     '       FLAG_ID              = :FlagID, '        + NL +
                     '       FLAG_ANL_SNT         = :FlagAnlSnt, '    + NL +
                     '       MASK_CTA             = :MaskCta, '       + NL +
                     '       GRAU_CTA             = :GrauCta '        + NL +
                     ' where PK_FINANCEIRO_CONTAS = :PkFinanceiroContas';

  SqlInsertClass   = 'insert into FINANCEIRO_CONTAS '                    + NL +
                     '  (PK_FINANCEIRO_CONTAS, FK_FINANCEIRO_CONTAS, '   + NL +
                     '   FK_PLANO_CONTAS, SEQ_CTA, DSC_CTA, FLAG_TCTA, ' + NL +
                     '   FLAG_ID, FLAG_ANL_SNT, MASK_CTA, GRAU_CTA) '  + NL +
                     'values '                                           + NL +
                     '  (:PkFinanceiroContas, :FkFinanceiroContas, '     + NL +
                     '   :FkPlanoContas, :SeqCta, :DscCta, :FlagTCta, '  + NL +
                     '   :FlagID, :FlagAnlSnt, :MaskCta, :GrauCta)';

  SqlDeleteClass   = 'delete from FINANCEIRO_CONTAS ' + NL +
                     ' where PK_FINANCEIRO_CONTAS = :PkFinanceiroContas';

  SqlGetPkFinAcc   = 'select R_PK_FINANCEIRO_CONTAS ' + NL +
                     '  from STP_GET_PK_FINANCEIRO_CONTAS(:FkFinanceiroContas, :SeqCta)';

  SqlFinishKeyCode = 'select COD_TECLA from FINALIZADORAS ' + NL +
                     ' where PK_FINALIZADORAS <> :PkFinalizadoras ' + NL +
                     '   and COD_TECLA         = :CodTecla';

  SqlFinalizers    = 'select * from FINALIZADORAS ' + NL +
                     ' where ((FLAG_TFIN = :FlagTFin)  ' + NL +
                     '    or ( -1        = :FlagTFin)) ' + NL +
                     ' order by FLAG_TFIN, DSC_MPGT';

  SqlGenPkFinish   = 'select R_PK_FINALIZADORAS as PK_FINALIZADORAS ' + NL +
                     '  from STP_GET_PK_FINALIZADORAS';

  SqlFinalization  = 'select * from FINALIZADORAS ' + NL +
                     ' where PK_FINALIZADORAS = :PkFinalizadoras';

  SqlDeleteFinish  = 'delete from FINALIZADORAS ' + NL +
                     ' where PK_FINALIZADORAS = :PkFinalizadoras';

  SqlUpdateFinish  = 'update FINALIZADORAS set ' + NL +
                     '       DSC_MPGT             = :DscMpgt, ' + NL +
                     '       FK_FINALIZADORAS__DB = :FkFinalizadorasDB, ' + NL +
                     '       FK_FINALIZADORAS__CR = :FkFinalizadorasCR, ' + NL +
                     '       COD_TECLA            = :CodTecla, ' + NL +
                     '       FLAG_TRC             = :FlagTrc, ' + NL +
                     '       FLAG_CLI             = :FlagCli, ' + NL +
                     '       FLAG_BNC             = :FlagBnc, ' + NL +
                     '       FLAG_TEF             = :FlagTef, ' + NL +
                     '       FLAG_TFIN            = :FlagTFin, ' + NL +
                     '       FLAG_BAIXA           = :FlagBaixa, ' + NL +
                     '       FLAG_TRF             = :FlagTrf, ' + NL +
                     '       FLAG_EST             = :FlagEst, ' + NL +
                     '       FLAG_GSLD_CTA        = :FlagGSldCta, ' + NL +
                     '       FLAG_GSLD_FIN        = :FlagGSldFin ' + NL +
                     ' where PK_FINALIZADORAS     = :PkFinalizadoras';

  SqlInsertFinish  = 'insert into FINALIZADORAS ' + NL +
                     '  (PK_FINALIZADORAS, FK_FINALIZADORAS__DB, ' + NL +
                     '   FK_FINALIZADORAS__CR, DSC_MPGT, COD_TECLA, FLAG_TRC, ' + NL +
                     '   FLAG_CLI, FLAG_BNC, FLAG_TEF, FLAG_TFIN, FLAG_BAIXA, ' + NL +
                     '   FLAG_TRF, FLAG_EST, FLAG_GSLD_CTA, FLAG_GSLD_FIN) ' + NL +
                     'values ' + NL +
                     '  (:PkFinalizadoras, :FkFinalizadorasDB, ' + NL +
                     '   :FkFinalizadorasCR, :DscMpgt, :CodTecla, :FlagTrc, ' + NL +
                     '   :FlagCli, :FlagBnc, :FlagTef, :FlagTFin, :FlagBaixa, ' + NL +
                     '   :FlagTrf, :FlagEst, :FlagGSldCta, :FlagGSldFin)';

  SqlDocument      = 'select Doc.*, Cad.RAZ_SOC '                   + NL +
                     '  from DOCUMENTOS Doc, CADASTROS Cad '        + NL +
                     ' where Cad.PK_CADASTROS  = Doc.FK_CADASTROS ' + NL +
                     '   and Doc.FK_EMPRESAS   = :FkEmpresas '      + NL +
                     '   and Doc.FK_CADASTROS  = :FkCadastros '     + NL +
                     '   and Doc.PK_DOCUMENTOS = :PkDocumentos';

  SqlDocuments     = 'select Doc.*, Cad.RAZ_SOC '                   + NL +
                     '  from DOCUMENTOS Doc, CADASTROS Cad '        + NL +
                     ' where Cad.PK_CADASTROS = Doc.FK_CADASTROS '  + NL +
                     ' order by Doc.DATA_EMISSAO';

  SqlCancelDoc     = 'update DOCUMENTOS set '               + NL +
                     '       FLAG_CANC = 1 '                + NL +
                     ' where FK_EMPRESAS   = :FkEmpresas '  + NL +
                     '   and FK_CADASTROS  = :FkCadastros ' + NL +
                     '   and PK_DOCUMENTOS = :PkDocumentos';

  SqlDuplicata     = 'select * from DUPLICATAS '             + NL +
                     ' where FK_EMPRESAS   = :FkEmpresas '   + NL +
                     '   and FK_CADASTROS  = :FkCadastros '  + NL +
                     '   and FK_DOCUMENTOS = :FkDocumentos ' + NL +
                     '   and PK_DUPLICATAS = :PkDuplicatas';

  SqlDuplicatas    = 'select * from duplicatas '              + NL +
                     ' where fk_empresas   = :fk_empresas '   + NL +
                     '   and fk_cadastros  = :fk_cadastros '  + NL +
                     '   and fk_documentos = :fk_documentos ' + NL +
                     ' order by DTA_VENC';

  SqlInsDocumento  = 'insert into DOCUMENTOS '                                   + NL +
                     '  (FK_EMPRESAS, FK_CADASTROS, PK_DOCUMENTOS, '             + NL +
                     '   FK_TIPO_DOCUMENTOS, FK_TABELA_PRECOS, '                 + NL +
                     '   FK_GRUPOS_MOVIMENTOS, FK_TIPO_DESCONTOS, '              + NL +
                     '   FK_CLASSIFICACAO, DATA_EMISSAO, DTA_EMB, DTA_EMB_INT, ' + NL +
                     '   PRZ_USU, OBS_DOC, FLAG_BXAC, FLAG_CANC, FLAG_CTB, '     + NL +
                     '   FLAG_TENTR, VLR_STOT, VLR_ENTR, VLR_ACR_DSCT, '         + NL +
                     '   VLR_DSP_ACES, VLR_FRE, VLR_SEG, VLR_BICMS, VLR_ICMS, '  + NL +
                     '   VLR_BICMSS, VLR_ICMSS, VLR_BISNT, VLR_BIPI, VAL_IPI, '  + NL +
                     '   VAL_TOT, QTD_ITEM, QTD_DUPL, QTD_VOL, PES_LIQ, '        + NL +
                     '   PES_BRU, NUM_VOL, TIPO_VOL, NUM_DOC) '                  + NL +
                     'values '                                                   + NL +
                     '  (:FkEmpresas, :FkCadastros, :PkDocumentos, '             + NL +
                     '   :FkTipoDocumentos, :FkTabelaPrecos, '                   + NL +
                     '   :FkGruposMovimentos, :FkTipoDescontos, '                + NL +
                     '   :FkClassificacao, :DataEmissao, :DtaEmb, :DtaEmbInt, '  + NL +
                     '   :PrzUsu, :ObsDoc, :FlagBxac, :FlagCanc, :FlagCtb, '     + NL +
                     '   :FlagTEntr, :VlrSTot, :VlrEntr, :VlrAcrDsct, '          + NL +
                     '   :VlrDspAces, :VlrFre, :VlrSeg, :VlrBIcms, VlrIcms, '    + NL +
                     '   :VlrBIcmss, :VlrIcmss, :VlrBIsnt, :VlrBipi, ValIpi, '   + NL +
                     '   :ValTot, :QtdItem, :QtdDupl, :QtdVol, :PesLiq, '        + NL +
                     '   :PesBru, :NumVol, :TipoVol, :NumDoc)';

  SqlUpdDocumento  = 'update DOCUMENTOS set '                              + NL +
                     '       FK_TIPO_DOCUMENTOS   = :FkTipoDocumentos, '   + NL +
                     '       FK_TABELA_PRECOS     = :FkTabelaPrecos, '     + NL +
                     '       FK_GRUPOS_MOVIMENTOS = :FkGruposMovimentos, ' + NL +
                     '       FK_TIPO_DESCONTOS    = :FkTipoDescontos, '    + NL +
                     '       FK_CLASSIFICACAO     = :FkClassificacao, '    + NL +
                     '       DATA_EMISSAO         = :DataEmissao, '        + NL +
                     '       DTA_EMB              = :DtaEmb, '             + NL +
                     '       DTA_EMB_INT          = :DtaEmbInt, '          + NL +
                     '       PRZ_USU              = :PrzUsu, '             + NL +
                     '       OBS_DOC              = :ObsDoc, '             + NL +
                     '       FLAG_BXAC            = :FlagBxac, '           + NL +
                     '       FLAG_CANC            = :FlagCanc, '           + NL +
                     '       FLAG_CTB             = :FlagCtb, '            + NL +
                     '       FLAG_TENTR           = :FlagTEntr, '          + NL +
                     '       VLR_STOT             = :VlrSTot, '            + NL +
                     '       VLR_ENTR             = :VlrEntr, '            + NL +
                     '       VLR_ACR_DSCT         = :VlrAcrDsct, '         + NL +
                     '       VLR_DSP_ACES         = :VlrDspAces, '         + NL +
                     '       VLR_FRE              = :VlrFre, '             + NL +
                     '       VLR_SEG              = :VlrSeg, '             + NL +
                     '       VLR_BICMS            = :VlrBIcms, '           + NL +
                     '       VLR_ICMS             = :VlrIcms, '            + NL +
                     '       VLR_BICMSS           = :VlrBIcmss, '          + NL +
                     '       VLR_ICMSS            = :VlrIcmss, '           + NL +
                     '       VLR_BISNT            = :VlrBIsnt, '           + NL +
                     '       VLR_BIPI             = :VlrBipi, '            + NL +
                     '       VAL_IPI              = :ValIpi, '             + NL +
                     '       VAL_TOT              = :ValTot, '             + NL +
                     '       QTD_ITEM             = :QtdItem, '            + NL +
                     '       QTD_DUPL             = :QtdDupl, '            + NL +
                     '       QTD_VOL              = :QtdVol, '             + NL +
                     '       PES_LIQ              = :PesLiq, '             + NL +
                     '       PES_BRU              = :PesBru, '             + NL +
                     '       NUM_VOL              = :NumVol, '             + NL +
                     '       TIPO_VOL             = :TipoVol, '            + NL +
                     '       NUM_DOC              = :NumDoc '              + NL +
                     ' where FK_EMPRESAS          = :FkEmpresas '          + NL +
                     '   and FK_CADASTROS         = :FkCadastros '         + NL +
                     '   and PK_DOCUMENTOS        = :PkDocumentos ';

  SqlDelDocumento  = 'delete from DOCUMENTOS '                      + NL +
                     ' where FK_EMPRESAS          = :FkEmpresas '   + NL +
                     '   and FK_CADASTROS         = :FkCadastros '  + NL +
                     '   and PK_DOCUMENTOS        = :PkDocumentos ';

  SqlMaxDocumento  = 'select Max(PK_DOCUMENTOS) as PK_DOCUMENTOS ' + NL +
                     '  from DOCUMENTOS '                          + NL +
                     ' where FK_EMPRESAS          = :FkEmpresas '  + NL +
                     '   and FK_CADASTROS         = :FkCadastros ';

  SqlUpdDuplicata  = 'update ';

  SqlInsDuplicata  = 'insert ';

  SqlDelDuplicata  = 'delete ';

  SqlMaxDuplicata  = 'select Max() ';

  // Sql Instructions for other modules

  SqlLancamentosCta = 'select Cln.DTA_LAN, Cln.DSC_LAN, Cln.VLR_LAN, '    + NL +
                      '       Csl.SLD_CTA as SLD_LAN, Cad.RAZ_SOC, '      + NL +
                      '       Cln.FLAG_DBCR, Cta.DSC_CTA, Cta.SLD_CTA '   + NL +
                      '  from TIPO_CONTAS Tct '                           + NL +
                      '  join CONTAS Cta '                                + NL +
                      '    on Cta.FK_TIPO_CONTAS   = Tct.PK_TIPO_CONTAS ' + NL +
                      '  left outer join CONTAS_LANCAMENTOS Cln '         + NL +
                      '    on Cln.FK_EMPRESAS      = :FkEmpresas '        + NL +
                      '   and Cln.FK_TIPO_CONTAS   = Tct.PK_TIPO_CONTAS ' + NL +
                      '   and Cln.DTA_LAN         >= :StartDate '         + NL +
                      '   and Cln.DTA_LAN         <= :EndDate '           + NL +
                      '  left outer join CONTAS_SALDOS Csl '              + NL +
                      '    on Csl.FK_EMPRESAS      = Cln.FK_EMPRESAS '    + NL +
                      '   and Csl.FK_TIPO_CONTAS   = Cln.FK_TIPO_CONTAS ' + NL +
                      '   and Csl.PK_CONTAS_SALDOS = Cln.DTA_LAN '        + NL +
                      '  left outer join CADASTROS Cad '                  + NL +
                      '    on Cad.PK_CADASTROS     = Cln.FK_CADASTROS '   + NL +
                      ' where Tct.PK_TIPO_CONTAS   > 0 '                  + NL +
                      '   and Tct.FLAG_TCTA        = :FlagTCta '          + NL +
                      ' order by Cln.DTA_LAN desc';

  SqlGroupMov      = 'select distinct Gmv.PK_GRUPOS_MOVIMENTOS, Gmv.DSC_GMOV, '    + NL +
                     '       Gmv.FLAG_ES, Tpd.FK_TIPO_DOCUMENTOS, Tdc.DSC_TDOC '   + NL +
                     '  from TIPO_PEDIDOS Tpd, GRUPOS_MOVIMENTOS Gmv, '            + NL +
                     '       TIPO_DOCUMENTOS Tdc '                                 + NL +
                     ' where Gmv.PK_GRUPOS_MOVIMENTOS = Tpd.FK_GRUPOS_MOVIMENTOS ' + NL +
                     '   and Tdc.PK_TIPO_DOCUMENTOS   = Tpd.FK_TIPO_DOCUMENTOS '   + NL +
                     ' order by Gmv.DSC_GMOV, Tdc.DSC_TDOC';


implementation

end.
