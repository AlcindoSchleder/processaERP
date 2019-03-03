unit CtbArqSql;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder                                           *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created  : 03/06/2003 - DD/MM/YYYY                                    *}
{* Modified : 03/06/2003 - DD/MM/YYYY                                    *}
{* Version  : 1.0.0.0                                                    *}
{* License  : you can freely use and distribute the included code        *}
{*            for any purpouse, but you cannot remove this copyright     *}
{*            notice. Send me any comments and updates, they are really  *}
{*            appreciated. This software is licensed under MPL License,  *}
{*            see http://www.mozilla.org/MPL/ for details                *}
{* Contact  : alcindo@sistemaprocessa.com.br                             *}
{*            http://www.sistemaprocessa.com.br                          *}
{*                                                                       *}
{*************************************************************************}

interface

uses CmmConst;

resourcestring
  SqlPlanAccounts  = 'select * from STP_GET_PLANO_CONTAS';

  SqlPlanAccount   = 'select * from PLANO_CONTAS ' + NL +
                     ' where PK_PLANO_CONTAS = :PkPlanoContas';

  SqlUpdatePlanAcc = 'update PLANO_CONTAS set '                  + NL +
                     '       SEQ_PLCTA            = :SeqCta, '        + NL +
                     '       DSC_CTA              = :DscCta, '        + NL +
                     '       FLAG_TCTA            = :FlagTCta, '      + NL +
                     '       FLAG_ID              = :FlagID, '        + NL +
                     '       FLAG_ANL_SNT         = :FlagAnlSnt, '    + NL +
                     '       MASK_CTA             = :MaskCta, '       + NL +
                     '       GRAU_CTA             = :GrauCta '        + NL +
                     ' where PK_PLANO_CONTAS = :PkPlanoContas';

  SqlInsertPlanAcc = 'insert into PLANO_CONTAS '                    + NL +
                     '  (PK_PLANO_CONTAS, FK_PLANO_CONTAS, SEQ_PLCTA, ' + NL +
                     '   DSC_CTA, FLAG_TCTA, FLAG_ID, FLAG_ANL_SNT, ' + NL +
                     '   MASK_CTA, GRAU_CTA) '  + NL +
                     'values '                                           + NL +
                     '  (:PkPlanoContas, :FkPlanoContas, :SeqCta, ' + NL +
                     '   :DscCta, :FlagTCta, :FlagID, :FlagAnlSnt, ' + NL +
                     '   :MaskCta, :GrauCta)';

  SqlDeletePlanAcc = 'delete from PLANO_CONTAS ' + NL +
                     ' where PK_PLANO_CONTAS = :PkPlanoContas';

  SqlGetPkPlanAcc  = 'select R_PK_PLANO_CONTAS as PK_PLANO_CONTAS ' + NL +
                     '  from STP_GET_PK_PLANO_CONTAS(:FkPlanoContas, :SeqCta)';

  SqlGenPkTypeTax     = 'select R_PK_TIPO_IMPOSTOS as PK_TIPO_IMPOSTOS ' + NL +
                        '  from STP_GET_PK_TIPO_IMPOSTOS';

  SqlTiposCfop        = 'select * from TIPO_CFOP order by DSC_TMRC';

  SqlAllTaxes         = 'select * from VW_ALL_TAXES ' + NL +
                        ' where PK_EMPRESAS = :FkEmpresas ' + NL +
                        ' order by FLAG_ES, DSC_IMPS, DSC_PAIS, ' + NL +
                        '          DSC_UF, DSC_IMP';

  SqlSelectTypeTax    = 'select * from TIPO_IMPOSTOS ' + NL +
                        ' where PK_TIPO_IMPOSTOS = :PkTipoImpostos';

  SqlDeleteTypeTax    = 'delete from TIPO_IMPOSTOS ' + NL +
                        ' where PK_TIPO_IMPOSTOS = :PkTipoImpostos';

  SqlInsertTypeTax    = 'insert into TIPO_IMPOSTOS ' + NL +
                        '  (PK_TIPO_IMPOSTOS, DSC_IMPS, FLAG_CALC, ' + NL +
                        '   FLAG_IMPST, FLAG_RET, FLAG_DSTC, RED_BASC, ' + NL +
                        '   FLAG_ALQT_UNICA, FLAG_RANGE, MSG_IMP) ' + NL +
                        'values ' + NL +
                        '  (:PkTipoImpostos, :DscImps, :FlagCalc, ' + NL +
                        '   :FlagImpst, :FlagRet, :FlagDstc, :RedBasC, ' + NL +
                        '   :FlagAlqtUnica, :FlagRange, :MsgImp)';

  SqlUpdateTypeTax    = 'update TIPO_IMPOSTOS set ' + NL +
                        '       DSC_IMPS         = :DscImps, ' + NL +
                        '       FLAG_CALC        = :FlagCalc, ' + NL +
                        '       FLAG_IMPST       = :FlagImpst, ' + NL +
                        '       FLAG_RET         = :FlagRet, ' + NL +
                        '       FLAG_DSTC        = :FlagDstc, ' + NL +
                        '       FLAG_ALQT_UNICA  = :FlagAlqtUnica, ' + NL +
                        '       FLAG_RANGE       = :FlagRange, ' + NL +
                        '       RED_BASC         = :RedBasC, ' + NL +
                        '       MSG_IMP          = :MsgImp' + NL +
                        ' where PK_TIPO_IMPOSTOS = :PkTipoImpostos';

  SqlSelectTax        = 'select * from ALIQUOTAS ' + NL +
                        ' where FK_EMPRESAS      = :FkEmpresas ' + NL +
                        '   and FK_TIPO_IMPOSTOS = :FkTipoImpostos ' + NL +
                        '   and FK_PAISES        = :FkPaises ' + NL +
                        '   and FK_ESTADOS       = :FkEstados ' + NL +
                        '   and PK_ALIQUOTAS     = :PkAliquotas';

  SqlDeleteTax        = 'delete from ALIQUOTAS ' + NL +
                        ' where FK_EMPRESAS      = :FkEmpresas ' + NL +
                        '   and FK_TIPO_IMPOSTOS = :FkTipoImpostos ' + NL +
                        '   and FK_PAISES        = :FkPaises ' + NL +
                        '   and FK_ESTADOS       = :FkEstados ' + NL +
                        '   and PK_ALIQUOTAS     = :PkAliquotas';

  SqlInsertTax        = 'insert into ALIQUOTAS ' + NL +
                        '  (FK_EMPRESAS, FK_TIPO_IMPOSTOS, FK_PAISES, ' + NL +
                        '   FK_ESTADOS, PK_ALIQUOTAS, ALQT_IMPST, ' + NL +
                        '   ALQT_CNSF, ALQT_ARBT) ' + NL +
                        'values ' + NL +
                        '  (:FkEmpresas, :FkTipoImpostos, :FkPaises, ' + NL +
                        '   :FkEstados, :PkAliquotas, :AlqtImpst, ' + NL +
                        '   :AlqtCnsf, :AlqtArbt)';

  SqlUpdateTax        = 'update ALIQUOTAS set ' + NL +
                        '       ALQT_IMPST       = :AlqtImpst, ' + NL +
                        '       ALQT_CNSF        = :AlqtCnsf, ' + NL +
                        '       ALQT_ARBT        = :AlqtArbt ' + NL +
                        ' where FK_EMPRESAS      = :FkEmpresas ' + NL +
                        '   and FK_TIPO_IMPOSTOS = :FkTipoImpostos ' + NL +
                        '   and FK_PAISES        = :FkPaises ' + NL +
                        '   and FK_ESTADOS       = :FkEstados ' + NL +
                        '   and PK_ALIQUOTAS     = :PkAliquotas';

  SqlSelectTaxPrinter = 'select * from ALIQUOTAS_IMP_FISCAL ' + NL +
                        ' where FK_EMPRESAS             = :FkEmpresas ' + NL +
                        '   and FK_TIPO_IMPOSTOS        = :FkTipoImpostos ' + NL +
                        '   and FK_PAISES               = :FkPaises ' + NL +
                        '   and FK_ESTADOS              = :FkEstados ' + NL +
                        '   and FK_ALIQUOTAS            = :FkAliquotas ' + NL +
                        '   and PK_ALIQUOTAS_IMP_FISCAL = :PkAliquotasImpFiscal';

  SqlDeleteTaxPrinter = 'delete from ALIQUOTAS_IMP_FISCAL ' + NL +
                        ' where FK_EMPRESAS             = :FkEmpresas ' + NL +
                        '   and FK_TIPO_IMPOSTOS        = :FkTipoImpostos ' + NL +
                        '   and FK_PAISES               = :FkPaises ' + NL +
                        '   and FK_ESTADOS              = :FkEstados ' + NL +
                        '   and FK_ALIQUOTAS            = :FkAliquotas ' + NL +
                        '   and PK_ALIQUOTAS_IMP_FISCAL = :PkAliquotasImpFiscal';

  SqlInsertTaxPrinter = 'insert into ALIQUOTAS_IMP_FISCAL ' + NL +
                        '  (FK_EMPRESAS, FK_TIPO_IMPOSTOS, FK_PAISES, ' + NL +
                        '   FK_ESTADOS, FK_ALIQUOTAS, PK_ALIQUOTAS_IMP_FISCAL, ' + NL +
                        '   COD_ALQT, COD_ALQT_CNSF) ' + NL +
                        'values ' + NL +
                        '  (:FkEmpresas, :FkTipoImpostos, :FkPaises, ' + NL +
                        '   :FkEstados, :FkAliquotas, :PkAliquotasImpFiscal, ' + NL +
                        '   :CodAlqt, :CodAlqtCnsf)';

  SqlUpdateTaxPrinter = 'update ALIQUOTAS_IMP_FISCAL set ' + NL +
                        '       COD_ALQT                = :CodAlqt, ' + NL +
                        '       COD_ALQT_CNSF           = :CodAlqtCnsf ' + NL +
                        ' where FK_EMPRESAS             = :FkEmpresas ' + NL +
                        '   and FK_TIPO_IMPOSTOS        = :FkTipoImpostos ' + NL +
                        '   and FK_PAISES               = :FkPaises ' + NL +
                        '   and FK_ESTADOS              = :FkEstados ' + NL +
                        '   and FK_ALIQUOTAS            = :FkAliquotas ' + NL +
                        '   and PK_ALIQUOTAS_IMP_FISCAL = :PkAliquotasImpFiscal';

  SqlSelectTaxAccount = 'select * from TIPO_IMPOSTOS_FINANCEIRO ' + NL +
                        ' where FK_TIPO_IMPOSTOS            = :FkTipoImpostos ' + NL +
                        '   and PK_TIPO_IMPOSTOS_FINANCEIRO = :PkTipoImpostosFinanceiro';

  SqlDeleteTaxAccount = 'delete from TIPO_IMPOSTOS_FINANCEIRO ' + NL +
                        ' where FK_TIPO_IMPOSTOS            = :FkTipoImpostos ' + NL +
                        '   and PK_TIPO_IMPOSTOS_FINANCEIRO = :PkTipoImpostosFinanceiro';

  SqlInsertTaxAccount = 'insert into TIPO_IMPOSTOS_FINANCEIRO ' + NL +
                        '  (FK_TIPO_IMPOSTOS, PK_TIPO_IMPOSTOS_FINANCEIRO, ' + NL +
                        '   FK_FINANCEIRO_CONTAS__CR, FK_FINANCEIRO_CONTAS__DB) ' + NL +
                        'values ' + NL +
                        '  (:FkTipoImpostos, :PkTipoImpostosFinanceiro, ' + NL +
                        '   :FkFinanceiroContasCR, :FkFinanceiroContasDB)';

  SqlUpdateTaxAccount = 'update TIPO_IMPOSTOS_FINANCEIRO set ' + NL +
                        '       FK_FINANCEIRO_CONTAS__CR    = :FkFinanceiroContasCR, ' + NL +
                        '       FK_FINANCEIRO_CONTAS__DB    = :FkFinanceiroContasDB ' + NL +
                        ' where FK_TIPO_IMPOSTOS            = :FkTipoImpostos ' + NL +
                        '   and PK_TIPO_IMPOSTOS_FINANCEIRO = :PkTipoImpostosFinanceiro';

  SqlSelectTaxRange   = 'select * from TAX_RANGE ' + NL +
                        ' where FK_TIPO_IMPOSTOS = :FkTipoImpostos';

  SqlDeleteTaxRange   = 'delete from TAX_RANGE ' + NL +
                        ' where FK_TIPO_IMPOSTOS = :FkTipoImpostos';

  SqlInsertTaxRange   = 'insert into TAX_RANGE ' + NL +
                        '  (FK_TIPO_IMPOSTOS, PK_START_RANGE, PK_END_RANGE, ' + NL +
                        '   ALQT_IMPST) ' + NL +
                        'values ' + NL +
                        '  (:FkTipoImpostos, :PkStartRange, :PkEndRange, ' + NL +
                        '   :AlqtImpst)';

  SqlGetAllCfopNatOpe = 'select Tcf.PK_TIPO_CFOP, Tcf.DSC_TMRC, Nat.COD_CFOP, ' + NL +
                        '       Nat.DSC_NTOP, Nat.PK_NATUREZA_OPERACOES, ' + NL +
                        '       Cast(0 as smallint) as TYPE_DATA ' + NL +
                        '  from TIPO_CFOP Tcf, NATUREZA_OPERACOES Nat ' + NL +
                        ' where Nat.FK_TIPO_CFOP = Tcf.PK_TIPO_CFOP ' + NL +
                        ' order by Tcf.DSC_TMRC, Nat.COD_CFOP ';

  SqlGetTypeCfop      = 'select * from TIPO_CFOP ' + NL +
                        ' where PK_TIPO_CFOP = :PkTipoCfop ' + NL +
                        ' order by DSC_TMRC';

  SqlDeleteTypeCfop   = 'delete from TIPO_CFOP ' + NL +
                        ' where PK_TIPO_CFOP = :PkTipoCfop ';

  SqlInsertTypeCfop   = 'insert into TIPO_CFOP ' + NL +
                        '  (PK_TIPO_CFOP, DSC_TMRC) ' + NL +
                        'values ' + NL +
                        '  (:PkTipoCfop, :DscTMrc)';

  SqlUpdateTypeCfop   = 'update TIPO_CFOP set ' + NL +
                        '       PK_TIPO_CFOP = :PkTipoCfop ' + NL +
                        '       DSC_TMRC     = :DscTMrc ' + NL +
                        ' where PK_TIPO_CFOP = :OldPkTipoCfop ';

  SqlGetNatOper       = 'select * from NATUREZA_OPERACOES ' + NL +
                        ' where FK_TIPO_CFOP = :FkTipoCfop ' + NL +
                        '   and PK_NATUREZA_OPERACOES = :PkNaturezaOperacoes ' + NL +
                        ' order by DSC_NTOP';

  SqlDeleteNatOper    = 'delete from NATUREZA_OPERACOES ' + NL +
                        ' where FK_TIPO_CFOP = :FkTipoCfop ' + NL +
                        '   and PK_NATUREZA_OPERACOES = :PkNaturezaOperacoes';

  SqlInsertNatOper    = 'insert into NATUREZA_OPERACOES ' + NL +
                        '  (FK_TIPO_CFOP, PK_NATUREZA_OPERACOES, DSC_NTOP, ' + NL +
                        '   COD_CFOP, CMPL_CFOP, FK_FINANCEIRO_CONTAS) ' + NL +
                        'values ' + NL +
                        '  (:FkTipoCfop, :PkNaturezaOperacoes, :DscNtOp, ' + NL +
                        '   :CodCfop, :CmplCfop, :FkFinanceiroContas)';

  SqlUpdateNatOper    = 'update NATUREZA_OPERACOES set ' + NL +
                        '       DSC_NTOP  = :DscNtOp, ' + NL +
                        '       COD_CFOP  = :CodCfop, ' + NL +
                        '       CMPL_CFOP = :CmplCfop, ' + NL +
                        '       FK_FINANCEIRO_CONTAS = :FkFinanceiroContas ' + NL +
                        ' where FK_TIPO_CFOP = :FkTipoCfop ' + NL +
                        '   and PK_NATUREZA_OPERACOES = :PkNaturezaOperacoes';

  SqlGenPkNatOper     = 'select R_PK_NATUREZA_OPERACOES as PK_NATUREZA_OPERACOES ' + NL +
                        '  from STP_GET_PK_NATUREZA_OPERACOES(:FkTipoCfop)';

  SqlGetOrigins       = 'select Org.*, Cast(0 as smallint) as TYPE_DATA ' + NL +
                        '  from ORIGENS_TRIBUTARIAS Org ' + NL +
                        ' order by DSC_ORGM';

  SqlGetSituations    = 'select Sit.*, Cast(1 as smallint) as TYPE_DATA ' + NL +
                        '  from SITUACAO_TRIBUTARIAS Sit ' + NL +
                        ' order by DSC_IMPST';

  SqlSelectOrigin     = 'select * from ORIGENS_TRIBUTARIAS ' + NL +
                        ' where PK_ORIGENS_TRIBUTARIAS = :PkOrigensTributarias';

  SqlDeleteOrigin     = 'delete from ORIGENS_TRIBUTARIAS ' + NL +
                        ' where PK_ORIGENS_TRIBUTARIAS = :PkOrigensTributarias';

  SqlInsertOrigin     = 'insert from ORIGENS_TRIBUTARIAS ' + NL +
                        '  (PK_ORIGENS_TRIBUTARIAS, DSC_ORGM) ' + NL +
                        'values ' + NL +
                        '  (:PkOrigensTributarias, :DscOrgm)';

  SqlUpdateOrigin     = 'update ORIGENS_TRIBUTARIAS set ' + NL +
                        '       DSC_ORGM = :DscOrgm ' + NL +
                        ' where PK_ORIGENS_TRIBUTARIAS = :PkOrigensTributarias';

  SqlSelectSituation  = 'select * from SITUACAO_TRIBUTARIAS ' + NL +
                        ' where PK_SITUACAO_TRIBUTARIAS = :PkSituacaoTributaria';

  SqlDeleteSituation  = 'delete from SITUACAO_TRIBUTARIAS ' + NL +
                        ' where PK_SITUACAO_TRIBUTARIAS = :PkSituacaoTributaria';

  SqlInsertSituation  = 'insert into SITUACAO_TRIBUTARIAS ' + NL +
                        '  (PK_SITUACAO_TRIBUTARIAS, DSC_IMPST) ' + NL +
                        'values ' + NL +
                        '  (:PkSituacaoTributaria, :DscImpst)';

  SqlUpdateSituation  = 'update SITUACAO_TRIBUTARIAS set ' + NL +
                        '       DSC_IMPST = :DscImpst ' + NL +
                        ' where PK_SITUACAO_TRIBUTARIAS = :PkSituacaoTributaria';

  SqlGetFiscalClass   = 'select * from CLASSIFICACAO_FISCAL ' + NL +
                        ' order by DSC_CLSF';

  SqlSelectFsclClass  = 'select * from CLASSIFICACAO_FISCAL ' + NL +
                        ' where PK_CLASSIFICACAO_FISCAL = :PkClassificacaoFiscal';

  SqlDeleteFsclClass  = 'delete from CLASSIFICACAO_FISCAL ' + NL +
                        ' where PK_CLASSIFICACAO_FISCAL = :PkClassificacaoFiscal';

  SqlInsertFsclClass  = 'insert into CLASSIFICACAO_FISCAL ' + NL +
                        '  (PK_CLASSIFICACAO_FISCAL, DSC_CLSF) ' + NL +
                        'values ' + NL +
                        '  (:PkClassificacaoFiscal, :DscClsF)';

  SqlUpdateFsclClass  = 'update CLASSIFICACAO_FISCAL set ' + NL +
                        '       DSC_CLSF = :DscClsF ' + NL +
                        ' where PK_CLASSIFICACAO_FISCAL = :PkClassificacaoFiscal';

    // Sql's of others modules used to get data to this module
  SqlFinanceAccounts  = 'select * from STP_GET_FINANCEIRO_CONTAS ' + NL +
                        ' where ((R_FLAG_TCTA = :FlagTCta) ' + NL +
                        '   or  ( -1          = :FlagTCta))';

  SqlSuportedPrinters = 'select * from SUPORTED_PRINTERS order by DSC_IMP';

  SqlCountries        = 'select * from PAISES ' + NL +
                        ' where FLAG_ATU = 1 ' + NL +
                        ' order by DSC_PAIS';

  SqlStates           = 'select * from ESTADOS ' + NL +
                        ' where FK_PAISES = :FkPaises ' + NL +
                        ' order by DSC_UF';

var
  Variables: array of string;

implementation

end.
