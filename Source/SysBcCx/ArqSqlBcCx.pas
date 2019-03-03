unit ArqSqlBcCx;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 03/01/2006 - DD/MM/YYYY                                      *}
{* Modified: 03/01/2006 - DD/MM/YYYY                                     *}
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

  SqlFinAccounts   = 'select * from STP_GET_FINANCEIRO_CONTAS';

  SqlAccounts1      = 'select Tct.PK_TIPO_CONTAS, Tct.DSC_TCTA, Tct.FLAG_TCTA, ' + NL +
                      '       Cta.PK_CONTAS, Cta.DSC_CTA, Bct.SLD_REAL as SLD_CTA, ' + NL +
                      '       Bct.COD_CTA, Age.PK_AGENCIAS, Age.DSC_AGE, ' + NL +
                      '       Bco.PK_BANCOS, Bco.DSC_BCO ' + NL +
                      '  from TIPO_CONTAS Tct ' + NL +
                      '  left outer join CONTAS Cta ' + NL +
                      '    on Cta.FK_EMPRESAS    = :FkEmpresas ' + NL +
                      '   and Cta.FK_TIPO_CONTAS = Tct.PK_TIPO_CONTAS ' + NL +
                      '  join BANCOS_CONTAS Bct ' + NL +
                      '    on Bct.FK_EMPRESAS    = Cta.FK_EMPRESAS ' + NL +
                      '   and Bct.FK_TIPO_CONTAS = Cta.FK_TIPO_CONTAS ' + NL +
                      '   and Bct.FK_CONTAS      = Cta.PK_CONTAS ' + NL +
                      '  join BANCOS_AGENCIAS Age ' + NL +
                      '    on Age.FK_BANCOS      = Bct.FK_BANCOS ' + NL +
                      '   and Age.PK_AGENCIAS    = Bct.FK_AGENCIAS ' + NL +
                      '  join BANCOS Bco ' + NL +
                      '    on Bco.PK_BANCOS      = Age.FK_BANCOS ' + NL +
                      ' where Tct.PK_TIPO_CONTAS > 0 ' + NL +
                      '   and Tct.FLAG_TCTA      = 1 ' + NL +
                      'union';
  SqlAccounts2      = 'select Tct.PK_TIPO_CONTAS, Tct.DSC_TCTA, Tct.FLAG_TCTA, ' + NL +
                      '       Cta.PK_CONTAS, Cta.DSC_CTA, Cta.SLD_CTA, ' + NL +
                      '       Bct.COD_CTA, Age.PK_AGENCIAS, Age.DSC_AGE, ' + NL +
                      '       Bco.PK_BANCOS, Bco.DSC_BCO ' + NL +
                      '  from TIPO_CONTAS Tct ' + NL +
                      '  left outer join CONTAS Cta ' + NL +
                      '    on Cta.FK_EMPRESAS    = :FkEmpresas ' + NL +
                      '   and Cta.FK_TIPO_CONTAS = Tct.PK_TIPO_CONTAS ' + NL +
                      '  left outer join BANCOS_CONTAS Bct ' + NL +
                      '    on Bct.FK_EMPRESAS    = Cta.FK_EMPRESAS ' + NL +
                      '   and Bct.FK_TIPO_CONTAS = Cta.FK_TIPO_CONTAS ' + NL +
                      '   and Bct.FK_CONTAS      = Cta.PK_CONTAS ' + NL +
                      '  left outer join BANCOS_AGENCIAS Age ' + NL +
                      '    on Age.FK_BANCOS = 0 ' + NL +
                      '   and Age.PK_AGENCIAS = 0 ' + NL +
                      '  left outer join BANCOS Bco ' + NL +
                      '    on Bco.PK_BANCOS      = Age.FK_BANCOS ' + NL +
                      ' where Tct.PK_TIPO_CONTAS > 0 ' + NL +
                      '   and Tct.FLAG_TCTA     <> 1 ' + NL +
                      ' order by 2, 5, 8, 10';

  SqlLancaAllCta    = 'select Cln.DTA_LAN, Cln.DSC_LAN, Cln.VLR_LAN, '    + NL +
                      '       Csl.SLD_CTA as SLD_LAN, Cad.RAZ_SOC, '      + NL +
                      '       Cln.FLAG_DBCR, Cta.DSC_CTA, Cta.SLD_CTA, '  + NL +
                      '       Cta.DTA_SLD '                               + NL +
                      '  from TIPO_CONTAS Tct '                           + NL +
                      '  join CONTAS Cta '                                + NL +
                      '    on Cta.FK_TIPO_CONTAS   = Tct.PK_TIPO_CONTAS ' + NL +
                      '  left outer join CONTAS_LANCAMENTOS Cln '         + NL +
                      '    on Cln.FK_EMPRESAS      = :FkEmpresas '        + NL +
                      '   and Cln.FK_EMPRESAS__CTA = Cta.FK_EMPRESAS '    + NL +
                      '   and Cln.FK_TIPO_CONTAS   = Tct.PK_TIPO_CONTAS ' + NL +
                      '   and Cln.DTA_LAN         >= :StartDate '         + NL +
                      '   and Cln.DTA_LAN         <= :EndDate '           + NL +
                      '  left outer join CONTAS_SALDOS Csl '              + NL +
                      '    on Csl.FK_EMPRESAS      = Cln.FK_EMPRESAS '    + NL +
                      '   and Csl.FK_EMPRESAS__CTA = Cln.FK_EMPRESAS__CTA ' + NL +
                      '   and Csl.FK_TIPO_CONTAS   = Cln.FK_TIPO_CONTAS ' + NL +
                      '   and Csl.PK_CONTAS_SALDOS = Cln.DTA_LAN '        + NL +
                      '  left outer join CADASTROS Cad '                  + NL +
                      '    on Cad.PK_CADASTROS     = Cln.FK_CADASTROS '   + NL +
                      ' where Tct.PK_TIPO_CONTAS   > 0 '                  + NL +
                      '   and ((Tct.FLAG_TCTA      = :FlagTCta) '         + NL +
                      '    or ( 0                  = :FlagTCta) '         + NL +
                      '   and ( Tct.FLAG_TCTA     <> 2)) '                + NL +
                      ' order by Cln.DTA_LAN desc';

  SqlLancamentosCta = 'select Cln.DTA_LAN, Cln.DSC_LAN, Cln.VLR_LAN, '    + NL +
                      '       Csl.SLD_CTA as SLD_LAN, Cad.RAZ_SOC, '      + NL +
                      '       Cln.FLAG_DBCR, Cta.DSC_CTA, Cta.SLD_CTA, '  + NL +
                      '       Cta.DTA_SLD, Cln.FK_TIPO_CONTAS '           + NL +
                      '  from TIPO_CONTAS Tct '                           + NL +
                      '  join CONTAS Cta '                                + NL +
                      '    on Cta.FK_TIPO_CONTAS   = Tct.PK_TIPO_CONTAS ' + NL +
                      '   and Cta.PK_CONTAS        = :PkContas '          + NL +
                      '  left outer join CONTAS_LANCAMENTOS Cln '         + NL +
                      '    on Cln.FK_EMPRESAS      = :FkEmpresas '        + NL +
                      '   and Cln.FK_EMPRESAS__CTA = Cta.FK_EMPRESAS '    + NL +
                      '   and Cln.FK_TIPO_CONTAS   = Tct.PK_TIPO_CONTAS ' + NL +
                      '   and Cln.DTA_LAN         >= :StartDate '         + NL +
                      '   and Cln.DTA_LAN         <= :EndDate '           + NL +
                      '  left outer join CONTAS_SALDOS Csl '              + NL +
                      '    on Csl.FK_EMPRESAS      = Cln.FK_EMPRESAS '    + NL +
                      '   and Csl.FK_EMPRESAS__CTA = Cln.FK_EMPRESAS__CTA ' + NL +
                      '   and Csl.FK_TIPO_CONTAS   = Cln.FK_TIPO_CONTAS ' + NL +
                      '   and Csl.PK_CONTAS_SALDOS = Cln.DTA_LAN '        + NL +
                      '  left outer join CADASTROS Cad '                  + NL +
                      '    on Cad.PK_CADASTROS     = Cln.FK_CADASTROS '   + NL +
                      ' where Tct.PK_TIPO_CONTAS   > :PkTipoContas '      + NL +
                      '   and Tct.FLAG_TCTA        = :FlagTCta '          + NL +
                      ' order by Cln.DTA_LAN desc';

  SqlLancamentos    = 'select Cln.DTA_LAN, Cln.DSC_LAN, Cln.VLR_LAN, '    + NL +
                      '       Csl.SLD_GER as SLD_LAN, Cad.RAZ_SOC, '      + NL +
                      '       Cln.FLAG_DBCR, Cln.FK_TIPO_CONTAS, '        + NL +
                      '       Cast(''Lancamentos'' as varchar(50)) as DSC_CTA, ' + NL +
                      '       Cast(0.0 as numeric(18, 4)) as SLD_CTA, '   + NL +
                      '       current_date as DTA_SLD '                   + NL +
                      '  from CONTAS_LANCAMENTOS Cln '                    + NL +
                      '  join CONTAS_SALDOS Csl '                         + NL +
                      '    on Csl.FK_EMPRESAS  = Cln.FK_EMPRESAS '        + NL +
                      '   and Csl.FK_CONTAS_LANCAMENTOS = Cln.PK_CONTAS_LANCAMENTOS ' + NL +
                      '  join CADASTROS Cad '                             + NL +
                      '    on Cad.PK_CADASTROS = Cln.FK_CADASTROS '       + NL +
                      ' where Cln.FK_EMPRESAS  = :FkEmpresas '            + NL +
                      '   and Cln.DTA_LAN     >= :StartDate '             + NL +
                      '   and Cln.DTA_LAN     <= :EndDate '               + NL +
                      ' order by Cln.DTA_LAN desc';

  SqlTypeAccount    = 'select * from TIPO_CONTAS ' + NL +
                      ' where PK_TIPO_CONTAS = :PkTipoContas';

  SqlGetPkTypeAcc   = 'select Gen_Id(TIPO_CONTAS, 1) as R_PK_TIPO_CONTAS ' + NL +
                      '  from PARAMETRO_GLOBAIS';

  SqlDelTypeAccount = 'delete from TIPO_CONTAS ' + NL +
                      ' where PK_TIPO_CONTAS = :PkTipoContas';

  SqlInsTypeAccount = 'insert into TIPO_CONTAS ' + NL +
                      '  (PK_TIPO_CONTAS, DSC_TCTA, FLAG_TCTA) ' + NL +
                      'values ' + NL +
                      '  (:PkTipoContas, :DscTCta, :FlagTCta)';

  SqlUpdTypeAccount = 'update TIPO_CONTAS set' + NL +
                      '       DSC_TCTA       = :DscTCta, ' + NL +
                      '       FLAG_TCTA      = :FLagTCta ' + NL +
                      ' where PK_TIPO_CONTAS = :PkTipoContas';

  SqlAgencies       = 'select * from BANCOS_AGENCIAS ' + NL +
                      ' where FK_BANCOS = :FkBancos '  + NL +
                      ' order by DSC_AGE';

  SqlDelAgency      = 'delete from AGENCIAS ' + NL +
                      ' where FK_BANCOS   = :FkBancos ' + NL +
                      '   and PK_AGENCIAS = :PkAgencias';

  SqlInsAgency      = 'insert into AGENCIAS ' + NL +
                      '  (FK_BANCOS, PK_AGENCIAS, DSC_AGE, FK_CADASTROS) ' + NL +
                      'values ' + NL +
                      '  (:FkBancos, :PkAgencias, :DscAge, :FkCadastros)';

  SqlUpdAgency      = 'update AGENCIAS set' + NL +
                      '       PK_AGENCIAS  = :PkAgencias, ' + NL +
                      '       DSC_AGE      = :DscAge, ' + NL +
                      '       FK_CADASTROS = :FkCadastros ' + NL +
                      ' where FK_BANCOS    = :FkBancos ' + NL +
                      '   and PK_AGENCIAS  = :OldPkAgencias';

  SqlBank           = 'select * from BANCOS ' + NL +
                      ' where PK_BANCOS = :PkBancos';

  SqlDelBank        = 'delete from BANCOS ' + NL +
                      ' where PK_BANCOS = :PkBancos';

  SqlInsBank        = 'insert into BANCOS ' + NL +
                      '  (PK_BANCOS, DSC_BCO) ' + NL +
                      'values ' + NL +
                      '  (:PkBancos, :DscBco)';

  SqlUpdBank        = 'update BANCOS set'              + NL +
                      '       PK_BANCOS = :PkBancos, ' + NL +
                      '       DSC_BCO   = :DscBco '   + NL +
                      ' where PK_BANCOS = :OldPkBancos';

  SqlAccount        = 'select * from CONTAS ' + NL +
                      ' where FK_EMPRESAS    = :FkEmpresas ' + NL +
                      '   and FK_TIPO_CONTAS = :FkTipoContas ' + NL +
                      '   and PK_CONTAS      = :PkContas';

  SqlDelAccount     = 'delete from CONTAS ' + NL +
                      ' where FK_EMPRESAS    = :FkEmpresas ' + NL +
                      '   and FK_TIPO_CONTAS = :FkTipoContas ' + NL +
                      '   and PK_CONTAS      = :PkContas';

  SqlInsAccount     = 'insert into CONTAS ' + NL +
                      '  (FK_EMPRESAS, FK_TIPO_CONTAS, PK_CONTAS, DSC_CTA, ' + NL +
                      '   DTA_ABR, DTA_FCH) ' + NL +
                      'values ' + NL +
                      '  (:FkEmpresas, :FkTipoContas, :PkContas, :DscCta, ' + NL +
                      '   :DtaAbr, :DtaFch)';

  SqlUpdAccount     = 'update CONTAS set'              + NL +
                      '       DSC_CTA   = :DscCta, '   + NL +
                      '       DTA_ABR   = :DtaAbr, '   + NL +
                      '       DTA_FCH   = :DtaFch '   + NL +
                      ' where FK_EMPRESAS    = :FkEmpresas ' + NL +
                      '   and FK_TIPO_CONTAS = :FkTipoContas ' + NL +
                      '   and PK_CONTAS      = :PkContas';

  SqlBankAccount    = 'select * from BANCOS_CONTAS '           + NL +
                      ' where FK_EMPRESAS    = :FkEmpresas '   + NL +
                      '   and FK_TIPO_CONTAS = :FkTipoContas ' + NL +
                      '   and FK_BANCOS      = :FkBancos '     + NL +
                      '   and FK_AGENCIAS    = :FkAgencias '   + NL +
                      '   and FK_CONTAS      = :FkContas';

  SqlDelBankAccount = 'delete from BANCOS_CONTAS '             + NL +
                      ' where FK_EMPRESAS    = :FkEmpresas '   + NL +
                      '   and FK_TIPO_CONTAS = :FkTipoContas ' + NL +
                      '   and FK_BANCOS      = :FkBancos '     + NL +
                      '   and FK_AGENCIAS    = :FkAgencias '   + NL +
                      '   and FK_CONTAS      = :FkContas';

  SqlInsBankAccount = 'insert into BANCOS_CONTAS '                               + NL +
                      '  (FK_EMPRESAS, FK_TIPO_CONTAS, FK_BANCOS, FK_AGENCIAS, ' + NL +
                      '   FK_CONTAS, COD_CTA, NUM_INITL, PAG_NUM, NUM_CHQ, '     + NL +
                      '   NUM_REM, NUM_CTR) '                                    + NL +
                      'values '                                                  + NL +
                      '  (:FkEmpreas, :FkTipoContas, :FkBancos, :FkAgencias, '   + NL +
                      '   :FkContas, :CodCta, :NumIniTl, :PagNum, :NumChq, '     + NL +
                      '   :NumRem, :NumCtr)';

  SqlUpdBankAccount = 'update BANCOS_CONTAS set'               + NL +
                      '       COD_CTA        = :CodCta, '      + NL +
                      '       NUM_INITL      = :NumIniTl, '    + NL +
                      '       PAG_NUM        = :PagNum, '      + NL +
                      '       NUM_CHQ        = :NumChq, '      + NL +
                      '       NUM_REM        = :NumRem, '      + NL +
                      '       NUM_CTR        = :NumCtr '       + NL +
                      ' where FK_EMPRESAS    = :FkEmpresas '   + NL +
                      '   and FK_TIPO_CONTAS = :FkTipoContas ' + NL +
                      '   and FK_BANCOS      = :FkBancos '     + NL +
                      '   and FK_AGENCIAS    = :FkAgencias '    + NL +
                      '   and FK_CONTAS      = :FkContas';

  SqlGetPkContas    = 'select R_PK_CONTAS from STP_GET_KC_CONTAS(:PkTipoContas)';

  SqlAllOperations  = 'select * from OPERACOES_FINANCEIRAS ' + NL +
                      ' order by DSC_OPE';

  SqlGetPkFinOpe    = 'select Gen_Id(OPERACOES_FINANCEIRAS, 1) as R_PK_OPERACOES_FINANCEIRAS ' + NL +
                      '  from PARAMETRO_GLOBAIS';

  SqlDelOperations  = 'delete from OPERACOES_FINANCEIRAS ' + NL +
                      ' where PK_OPERACOES_FINANCEIRAS = :PkOperacoesFinanceiras';

  SqlInsOperations  = 'insert into OPERACOES_FINANCEIRAS ' + NL +
                      '  (PK_OPERACOES_FINANCEIRAS, DSC_OPE, FLAG_EST, ' + NL +
                      '   FLAG_TRF, FLAG_GSLD, FLAG_BAIXA) ' + NL +
                      'values ' + NL +
                      '  (:PkOperacoesFinanceiras, :DscOpe, :FlagEst, ' + NL +
                      '   :FlagTrf, :FlagGSld, :FlagBaixa)';

  SqlUpdOperations  = 'update OPERACOES_FINANCEIRAS set ' + NL +
                      '       DSC_OPE    = :DscOpe, ' + NL +
                      '       FLAG_EST   = :FlagEst, ' + NL +
                      '       FLAG_TRF   = :FlagTrf, ' + NL +
                      '       FLAG_GSLD  = :FlagGSld, ' + NL +
                      '       FLAG_BAIXA = :FlagBaixa ' + NL +
                      ' where PK_OPERACOES_FINANCEIRAS = :PkOperacoesFinanceiras';

  SqlOperDocuments  = 'select Tdc.DSC_TDOC, Opt.FK_OPERACOES_FINANCEIRAS, ' + NL +
                      '       Tdc.PK_TIPO_DOCUMENTOS, Opt.FLAG_DEF ' + NL +
                      '  from TIPO_DOCUMENTOS Tdc ' + NL +
                      '  left outer join OPERACOES_FIN_X_TIPO_DOCUMENTOS Opt ' + NL +
                      '    on Opt.FK_OPERACOES_FINANCEIRAS = :FkOperacoesFinanceiras ' + NL +
                      '   and Opt.FK_TIPO_DOCUMENTOS       = Tdc.PK_TIPO_DOCUMENTOS ' + NL +
                      ' order by DSC_TDOC';

  SqlDelOperDoc     = 'delete from OPERACOES_FIN_X_TIPO_DOCUMENTOS ' + NL +
                      ' where FK_OPERACOES_FINANCEIRAS = :FkOperacoesFinanceiras ';

  SqlInsOperDoc     = 'insert into OPERACOES_FIN_X_TIPO_DOCUMENTOS ' + NL +
                      '  (FK_OPERACOES_FINANCEIRAS, FK_TIPO_DOCUMENTOS, FLAG_DEF) ' + NL +
                      'values ' + NL +
                      '  (:FkOperacoesFinanceiras, :FkTipoDocumentos, :FlagDef)';

  SqlGetPkTicket    = 'select * from STP_GEN_PK_TICKETS';

  SqlTickets        = 'select * from TICKETS ' + NL +
                      ' order by FLAG_TTICKET, DSC_TICKET';

  SqlTicket         = 'select * from TICKETS ' + NL +
                      ' where PK_TICKETS = :PkTickets';

  SqlDeleteTicket   = 'delete from TICKETS ' + NL +
                      ' where PK_TICKETS = :PkTickets';

  SqlInsertTicket   = 'insert into TICKETS ' + NL +
                      '  (PK_TICKETS, FK_CADASTROS, FK_PRODUTOS, FK_CLASSIFICACAO, ' + NL +
                      '   FK_FINALIZADORAS, DSC_TICKET, FLAG_TTICKET) ' + NL +
                      'values ' + NL +
                      '  (:PkTickets, :FkCadastros, :FkProdutos, :FkClassificacao, ' + NL +
                      '   :FkFinalizadoras, :DscTicket, :FlagTTicket)';

  SqlUpdateTicket   = 'update TICKETS set ' + NL +
                      '       FK_CADASTROS     = :FkCadastros, ' + NL +
                      '       FK_PRODUTOS      = :FkProdutos, ' + NL +
                      '       FK_CLASSIFICACAO = :FkClassificacao, ' + NL +
                      '       FK_FINALIZADORAS = :FkFinalizadoras, ' + NL +
                      '       DSC_TICKET       = :DscTicket, ' + NL +
                      '       FLAG_TTICKET     = :FlagTTicket ' + NL +
                      ' where PK_TICKETS       = :PkTickets';

  SqlFinalizations  = 'select * from FINALIZADORAS ' + NL +
                      ' where ((FLAG_TFIN = :FlagTFin) ' + NL +
                      '    or ( -1        = :FlagTFin)) ' + NL +
                      ' order by DSC_MPGT';

  SqlSelectAcc1     = 'select Tct.PK_TIPO_CONTAS, Tct.DSC_TCTA, Tct.FLAG_TCTA, Tcf.FK_FINANCEIRO_CONTAS, ' + NL +
                      '       Tcf.SLD_INI, Tcf.DTA_FCH, Tcf.DTA_ABR, Tcf.DTA_SLD, Bct.FK_EMPRESAS, ' + NL +
                      '       Bct.DSC_CTA, Bct.COD_CTA, Bct.NUM_INITL, Bct.PAG_NUM, Bct.NUM_CHQ, ' + NL +
                      '       Bct.NUM_REM, Bct.SLD_PRVST, Bct.SLD_REAL, Bct.NUM_CTR, ' + NL +
                      '       Bct.KC_NUMERO_BOLETO, Bag.PK_AGENCIAS, Bag.FK_CADASTROS, Bag.DSC_AGE, ' + NL +
                      '       Bco.PK_BANCOS, Bco.DSC_BCO, Cast(0 as integer) as TYPE_DATA ' + NL +
                      '  from TIPO_CONTAS Tct ' + NL +
                      '  left outer join TIPO_CONTAS_FINANCEIRO Tcf ' + NL +
                      '    on Tcf.FK_TIPO_CONTAS       = Tct.PK_TIPO_CONTAS ' + NL +
                      '  left outer join BANCOS_CONTAS Bct ' + NL +
                      '       left outer join BANCOS_AGENCIAS Bag ';
  SqlSelectAcc2     = '            left outer join BANCOS Bco ' + NL +
                      '              on Bco.PK_BANCOS  = Bag.FK_BANCOS ' + NL +
                      '         on Bag.FK_BANCOS       = Bct.FK_BANCOS ' + NL +
                      '        and Bag.PK_AGENCIAS     = Bct.FK_AGENCIAS ' + NL +
                      '    on Bct.FK_EMPRESAS          = :FkEmpresas ' + NL +
                      '   and Bct.FK_FINANCEIRO_CONTAS = Tcf.FK_FINANCEIRO_CONTAS ' + NL +
                      '   and Bct.FK_TIPO_CONTAS       = Tct.PK_TIPO_CONTAS ' + NL +
                      ' where Tct.PK_TIPO_CONTAS       > 0 ' + NL +
                      ' order by Tct.FLAG_TCTA, Bct.DSC_CTA, Bag.DSC_AGE, Bco.DSC_BCO';


  // strings of other modules

  SqlSuppliers      = 'select PK_CADASTROS, RAZ_SOC from VW_FORNECEDORES ' + NL +
                      ' order by RAZ_SOC';

  SqlCustomers      = 'select PK_CADASTROS, RAZ_SOC from VW_CLIENTES ' + NL +
                      ' order by RAZ_SOC';

  SqlTypeDocuments  = 'select * from TIPO_DOCUMENTOS ' + NL +
                      ' order by DSC_TDOC';

  SqlPaymentWay     = 'select * from FINALIZADORAS ' + NL +
                      ' order by DSC_MPGT';

  SqlClassificaCRDB = 'select * from STP_GET_STP_GET_FINANCEIRO_CONTAS ' + NL +
                      ' where R_FLAG_TCTA = :FlagTCta';

  SqlProducts       = 'select Prd.PK_PRODUTOS, Prd.DSC_PROD, Ppr.PRE_VDA ' + NL +
                      '  from PRODUTOS Prd, PRODUTOS_PRECOS Ppr ' + NL +
                      ' where Prd.PK_PRODUTOS > 0 ' + NL +
                      '   and Prd.FLAG_ATV    = :FlagAtv ' + NL +
                      '   and Ppr.FK_EMPRESAS = :FkEmpresas ' + NL +
                      '   and Ppr.FK_PRODUTOS = Prd.PK_PRODUTOS ' + NL +
                      ' order by DSC_PROD';

implementation

end.
