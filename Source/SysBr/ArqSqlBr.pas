unit ArqSqlBr;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2006 by Alcindo Schleder. All rights reserved.           *}
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

resourcestring
  SqlSquares        = 'select * ' + NL +
                      '  from PRACAS '                        + NL +
                      ' where FK_EMPRESAS = :FkEmpresas '     + NL +
                      '   and PK_PRACAS   > 0 '               + NL +
                      ' order by DSC_PRC';

  SqlSquaresTracks  = 'select Prc.*, Ppt.PK_PRACAS_PISTAS, '      + NL +
                      '       Ppt.DSC_PISTA, Ppt.FLAG_DRT '       + NL +
                      '  from PRACAS Prc '                        + NL +
                      '  left outer join PRACAS_PISTAS Ppt '      + NL +
                      '    on Ppt.FK_EMPRESAS = Prc.FK_EMPRESAS ' + NL +
                      '   and Ppt.FK_PRACAS   = Prc.PK_PRACAS '   + NL +
                      ' where Prc.FK_EMPRESAS = :FkEmpresas '     + NL +
                      '   and Prc.PK_PRACAS   > 0 '               + NL +
                      ' order by Prc.DSC_PRC, Ppt.DSC_PISTA';

  SqlCategoryProd   = 'select Cpr.*, Prd.DSC_PROD, Ppr.PRE_VDA       ' + NL +
                      '  from CATEGORIAS_PRODUTOS Cpr, PRODUTOS Prd, ' + NL +
                      '       PRODUTOS_PRECOS Ppr '                    + NL +
                      ' where Cpr.FK_EMPRESAS = :FkEmpresas '          + NL +
                      '   and Cpr.FK_PRACAS   = :FkPracas '            + NL +
                      '   and Ppr.FK_EMPRESAS = Cpr.FK_EMPRESAS '      + NL +
                      '   and Ppr.FK_PRODUTOS = Cpr.FK_PRODUTOS '      + NL +
                      '   and Prd.PK_PRODUTOS = Cpr.FK_PRODUTOS '      + NL +
                      ' order by Prd.DSC_PROD';

  SqlOperators      = 'select Pop.*, Cad.RAZ_SOC '                   + NL +
                      '  from PRACAS_OPERADORES Pop, CADASTROS Cad ' + NL +
                      ' where Pop.FK_EMPRESAS  = :FkEmpresas '       + NL +
                      '   and Pop.FK_PRACAS    = :FkPracas '         + NL +
                      '   and Cad.PK_CADASTROS = Pop.FK_CADASTROS '  + NL +
                      ' order by Cad.RAZ_SOC ';

  SqlTypeOccurs     = 'select Toc.*, Vtp.FK_EMPRESAS, Vtp.FK_PRACAS, ' + NL +
                      '       Vtp.FK_TIPO_OCORRENCIA '                 + NL +
                      '  from TIPO_OCORRENCIAS Toc '                   + NL +
                      '  left outer join VINCULO_TOCORR_PRACAS Vtp '   + NL +
                      '    on Vtp.FK_EMPRESAS  = :FkEmpresas '         + NL +
                      '   and Vtp.FK_PRACAS    = :FkPracas '           + NL +
                      '   and Vtp.FK_TIPO_OCORRENCIA = Toc.PK_TIPO_OCORRENCIAS ' + NL +
                      ' where Toc.PK_TIPO_OCORRENCIAS > 0 '            + NL +
                      ' order by Toc.DSC_TOCR';

  SqlTypeOccurrence = 'select * from TIPO_OCORRENCIAS Toc ' + NL +
                      ' where PREFIX_FILE <> '''' '         + NL +
                      ' order by DSC_TOCR';

  SqlHighWay        = 'select * from RODOVIAS '           + NL +
                      ' where FK_EMPRESAS = :FkEmpresas ' + NL +
                      ' order by DSC_ROD';

  SqlDeleteTOccurs  = 'delete from VINCULO_TOCORR_PRACAS '         + NL +
                      ' where FK_EMPRESAS        = :FkEmpresas '  + NL +
                      '   and FK_PRACAS          = :FkPracas '    + NL +
                      '   and FK_TIPO_OCORRENCIA = :FkTipoOcorrencias';

  SqlInsertTOccurs  = 'insert into VINCULO_TOCORR_PRACAS '               + NL +
                      '  (FK_EMPRESAS, FK_PRACAS, FK_TIPO_OCORRENCIA) ' + NL +
                      'values '                                          + NL +
                      '  (:FkEmpresas, :FkPracas, :FkTipoOcorrencias)';

  SqlDeleteCategory = 'delete from CATEGORIAS_PRODUTOS '             + NL +
                      ' where FK_EMPRESAS            = :FkEmpresas ' + NL +
                      '   and FK_PRACAS              = :FkPracas '   + NL +
                      '   and PK_CATEGORIAS_PRODUTOS = :PkCategoriasProdutos';

  SqlUpdateCategory = 'update CATEGORIAS_PRODUTOS set '              + NL +
                      '       FK_PRODUTOS            = :FkProdutos ' + NL +
                      ' where FK_EMPRESAS            = :FkEmpresas ' + NL +
                      '   and FK_PRACAS              = :FkPracas '   + NL +
                      '   and PK_CATEGORIAS_PRODUTOS = :PkCategoriasProdutos';

  SqlInsertCategory = 'insert into CATEGORIAS_PRODUTOS '                   + NL +
                      '  (FK_EMPRESAS, FK_PRACAS,PK_CATEGORIAS_PRODUTOS, ' + NL +
                      '   FK_PRODUTOS) '                                   + NL +
                      'values '                                            + NL +
                      '  (:FkEmpresas, :FkPracas, :PkCategoriasProdutos, ' + NL +
                      '   :FkProdutos)';

  SqlDeleteOperator = 'delete from PRACAS_OPERADORES '             + NL +
                      ' where FK_EMPRESAS          = :FkEmpresas ' + NL +
                      '   and FK_PRACAS            = :FkPracas '   + NL +
                      '   and PK_PRACAS_OPERADORES = :PkPracasOperadores';

  SqlUpdateOperator = 'update PRACAS_OPERADORES set '               + NL +
                      '       FK_CADASTROS         = :FkCadastros ' + NL +
                      ' where FK_EMPRESAS          = :FkEmpresas '  + NL +
                      '   and FK_PRACAS            = :FkPracas '    + NL +
                      '   and PK_PRACAS_OPERADORES = :PkPracasOperadores';

  SqlInsertOperator = 'insert into PRACAS_OPERADORES '                   + NL +
                      '  (FK_EMPRESAS, FK_PRACAS,PK_PRACAS_OPERADORES, ' + NL +
                      '   FK_CADASTROS) '                                + NL +
                      'values '                                          + NL +
                      '  (:FkEmpresas, :FkPracas, :PkPracasOperadores, ' + NL +
                      '   :FkCadastros)';

  SqlDeleteSquare   = 'delete from PRACAS '               + NL +
                      ' where FK_EMPRESAS = :FkEmpresas ' + NL +
                      '   and PK_PRACAS   = :PkPracas ';

  SqlUpdateSquare   = 'update PRACAS set '                 + NL +
                      '       DSC_PRC     = :DscPrc, '     + NL +
                      '       POS_TRC     = :PosTrc, '     + NL +
                      '       FK_RODOVIAS = :FkRodovias '  + NL +
                      ' where FK_EMPRESAS = :FkEmpresas '  + NL +
                      '   and PK_PRACAS   = :PkPracas';

  SqlInsertSquare   = 'insert into PRACAS '                               + NL +
                      '  (FK_EMPRESAS, PK_PRACAS, FK_RODOVIAS, DSC_PRC, ' + NL +
                      '   POS_TRC) '                                      + NL +
                      'values '                                           + NL +
                      '  (:FkEmpresas, :PkPracas, :FkRodovias, :DscPrc, ' + NL +
                      '   :PosTrc, )';

  SqlDeleteSqrTrack = 'delete from PRACAS_PISTAS '             + NL +
                      ' where FK_EMPRESAS      = :FkEmpresas ' + NL +
                      '   and FK_PRACAS        = :FkPracas  '  + NL +
                      '   and PK_PRACAS_PISTAS = :PkPracasPistas';

  SqlUpdateSqrTrack = 'update PRACAS_PISTAS set '              + NL +
                      '       DSC_PISTA        = :DscPista, '  + NL +
                      '       FLAG_DRT         = :FlagDrt '    + NL +
                      ' where FK_EMPRESAS      = :FkEmpresas ' + NL +
                      '   and FK_PRACAS        = :FkPracas  '  + NL +
                      '   and PK_PRACAS_PISTAS = :PkPracasPistas';

  SqlInsertSqrTrack = 'insert into PRACAS_PISTAS '                    + NL +
                      '  (FK_EMPRESAS, FK_PRACAS, PK_PRACAS_PISTAS, ' + NL +
                      '   DSC_PISTA, FLAG_DRT) '                      + NL +
                      'values '                                       + NL +
                      '  (:FkEmpresas, :FkPracas, :PkPracasPistas, '  + NL +
                      '   :DscPista, :FlagDrt)';

  SqlDeleteTypeOcc  = 'delete from TIPO_OCORRENCIAS ' + NL +
                      ' where PK_TIPO_OCORRENCIAS = :PkTipoOcorrencias';

  SqlUpdateTypeOcc  = 'update TIPO_OCORRENCIAS set '               + NL +
                      '       DSC_TOCR            = :DscTOcr, '    + NL +
                      '       PREFIX_FILE         = :PrefixFile, ' + NL +
                      '       FLAG_TOCR           = :FlagTOcr, '   + NL +
                      '       FLAG_GFIN           = :FlagGFin '    + NL +
                      ' where PK_TIPO_OCORRENCIAS = :PkTipoOcorrencias';

  SqlInsertTypeOcc  = 'insert into TIPO_OCORRENCIAS '                 + NL +
                      '  (PK_TIPO_OCORRENCIAS, DSC_TOCR, FLAG_TOCR, ' + NL +
                      '   FLAG_GFIN, PREFIX_FILE) '                   + NL +
                      'values '                                       + NL +
                      '  (:PkTipoOcorrencias, :DscTOcr, :FlagTOcr, '  + NL +
                      '   :FlagGFin, :PrefixFile)';

  SqlInsOccurence   = 'select * from STP_GENERATE_OCCURRENCE( ' + NL +
                      '        :FkTipoOcorrencias, '            + NL +
                      '        :PkPracasOcorrencias, '          + NL +
                      '        :FkEmpresas, '                   + NL +
                      '        :FkPracas, '                     + NL +
                      '        :FkPracasPistas, '               + NL +
                      '        :FkTipoTurnos, '                 + NL +
                      '        :FkPracasOperadores, '           + NL +
                      '        :FkCategoriasProdutos, '         + NL +
                      '        :FkFinalizadoras, '              + NL +
                      '        :DthrOcr, '                      + NL +
                      '        :FlagTOcr, '                     + NL +
                      '        :SttPas, '                       + NL +
                      '        :VlrOcc, '                       + NL +
                      '        :DsctPass)';

  SqlShowFinance    = 'select Poc.FK_EMPRESAS, Poc.FK_PRACAS, Poc.FK_FINALIZADORAS, ' + NL +
                      '       Prc.DSC_PRC, Fin.DSC_MPGT, ' + NL +
                      '       Sum(Poc.VLR_OCC) as VLR_OCC, ' + NL +
                      '       Min(Poc.DTHR_OCR) as DTHR_INI, ' + NL +
                      '       Max(Poc.DTHR_OCR) as DTHR_FIN ' + NL +
                      '  from PRACAS_OCORRENCIAS Poc, PRACAS Prc, ' + NL +
                      '       CATEGORIAS_PRODUTOS Cpr, PRODUTOS Prd, ' + NL +
                      '       FINALIZADORAS Fin ' + NL +
                      ' where Poc.FK_EMPRESAS            = :FkEmpresas ' + NL +
                      '   and Poc.FK_PRACAS              = :FkPracas ' + NL +
                      '   and Poc.DTHR_OCR              >= :DtaIni ' + NL +
                      '   and Poc.DTHR_OCR              <= :DtaFin ' + NL +
                      '   and Poc.FLAG_GEN               = 0 ' + NL +
                      '   and Prc.FK_EMPRESAS            = Poc.FK_EMPRESAS ' + NL +
                      '   and Prc.PK_PRACAS              = Poc.FK_PRACAS ' + NL +
                      '   and Cpr.FK_EMPRESAS            = Poc.FK_EMPRESAS ' + NL +
                      '   and Cpr.FK_PRACAS              = Poc.FK_PRACAS ' + NL +
                      '   and Cpr.PK_CATEGORIAS_PRODUTOS = Poc.FK_CATEGORIAS_PRODUTOS ' + NL +
                      '   and Prd.PK_PRODUTOS            = Cpr.FK_PRODUTOS ' + NL +
                      '   and Fin.PK_FINALIZADORAS       = Poc.FK_FINALIZADORAS ' + NL +
                      ' group by Poc.FK_EMPRESAS, Poc.FK_PRACAS, Poc.FK_FINALIZADORAS, ' + NL +
                      '       Prc.DSC_PRC, Fin.DSC_MPGT';

  SqlGenFinance     = 'select * from STP_GEN_OCCURRENCE_FINANCE ( ' + NL +
                      ':FkEmpresas, :FkPracas, :FkFinalizadoras, ' + NL +
                      ':FkTipoContas, :FkContas, :DtaIni, :DtaFin, :VlrOcc)';

  SqlParamsBr       = 'select * from PARAMETROS_BR ' + NL +
                      ' where FK_EMPRESAS = :FkEmpresas';

  SqlDeleteParamsBr = 'delete from PARAMETROS_BR ' + NL +
                      ' where FK_EMPRESAS = :FkEmpresas';

  SqlUpdateParamsBr = 'update PARAMETROS_BR set ' + NL +
                      '       FK_TIPO_DOCUMENTOS   = :FkTipoDocumentos, ' + NL +
                      '       FK_CADASTROS         = :FkCadastros, ' + NL +
                      '       FK_GRUPOS_MOVIMENTOS = :FkGruposMovimentos, ' + NL +
                      '       FK_TIPO_MOVIMENTOS   = :FkTipoMovimentos, ' + NL +
                      '       FK_FINALIZADORAS     = :FkFinalizadoras ' + NL +
                      ' where FK_EMPRESAS = :FkEmpresas';

  SqlInsertParamsBr = 'insert into PARAMETROS_BR ' + NL +
                      '  (FK_TIPO_DOCUMENTOS, FK_CADASTROS, FK_FINALIZADORAS, ' + NL +
                      '   FK_GRUPOS_MOVIMENTOS, FK_TIPO_MOVIMENTOS) ' + NL +
                      'values ' + NL +
                      '  (:FkTipoDocumentos, :FkCadastros, :FkFinalizadoras, ' + NL +
                      '   :FkGruposMovimentos, :FkTipoMovimentos)';

  SqlAllParams      = 'select Emp.PK_EMPRESAS, Emp.RAZ_SOC, Prm.FK_EMPRESAS ' + NL +
                      '  from EMPRESAS Emp ' + NL +
                      '  left outer join PARAMETROS_BR Prm ' + NL +
                      '    on Prm.FK_EMPRESAS = Emp.PK_EMPRESAS ' + NL +
                      '  order by Emp.RAZ_SOC';

  SqlUpdateOcc      = 'update PRACAS_OCORRENCIAS set ' + NL +
                      '       FLAG_GEN = 1 ' + NL +
                      ' where FK_EMPRESAS      = :FkEmpresas ' + NL +
                      '   and FK_PRACAS        = :FkPracas ' + NL +
                      '   and FK_FINALIZADORAS = :FkFinalizadoras ' + NL +
                      '   and DTHR_OCR        >= :DtHrIni ' + NL +
                      '   and DTHR_OCR        <= :DtHrFin';

// Sql's to get data from table of other modules

  SqlProducts       = 'select Prd.PK_PRODUTOS, Prd.DSC_PROD, Ppr.PRE_VDA ' + NL +
                      '  from PRODUTOS_PRECOS Ppr '                        + NL +
                      '  join PRODUTOS Prd '                               + NL +
                      '    on Prd.PK_PRODUTOS = Ppr.FK_PRODUTOS '          + NL +
                      '   and Prd.FLAG_ATV    = 1 '                        + NL +
                      ' where Ppr.FK_EMPRESAS = :FkEmpresas '              + NL +
                      '   and Ppr.FK_PRODUTOS > 0 '                        + NL +
                      ' order by DSC_PROD';

  SqlEmployee       = 'select distinct * from VW_FUNCIONARIOS ' + NL +
                      ' order by RAZ_SOC';

  SqlFinalizers     = 'select * from FINALIZADORAS ' + NL +
                      ' where FLAG_TFIN < 8 ' + NL +
                      ' order by DSC_MPGT';

  SqlGroupMovement  = 'select * from GRUPOS_MOVIMENTOS ' + NL +
                      ' where FLAG_ES = 1 ' + NL +
                      ' order by DSC_GMOV';

  SqlOwners         = 'select * from VW_CLIENTES ' + NL +
                      ' where FLAG_CNSM = 1 ' + NL +
                      ' order by RAZ_SOC';

  SqlTypeDocument   = 'select * from TIPO_DOCUMENTOS ' + NL +
                      ' order by DSC_TDOC';

  SqlTypeMovement   = 'select * from TIPO_MOVIMENTOS ' + NL +
                      ' where FK_GRUPOS_MOVIMENTOS = :FkGruposMovimentos ' + NL +
                      ' order by DSC_TMOV';

  SqlAccounts       = 'select * from VW_CONTAS_TICKETS ' + NL +
                      ' where FK_EMPRESAS = :FkEmpresas ' + NL +
                      ' order by FLAG_TTICKET, ROW_TYPE, DSC_TCTA, DSC_BCO, DSC_AGE';

  SqlTypeAccounts   = 'select Tct.PK_TIPO_CONTAS, Tct.DSC_TCTA, ' + NL +
                      '       Tct.FLAG_TCTA, Cta.* ' + NL +
                      '  from TIPO_CONTAS Tct, CONTAS Cta ' + NL +
                      ' where Tct.PK_TIPO_CONTAS > 0 ' + NL +
                      '   and Tct.FLAG_TCTA      = :FlagTCta ' + NL +
                      '   and Cta.FK_EMPRESAS    = :FkEmpresas ' + NL +
                      '   and Cta.FK_TIPO_CONTAS = Tct.PK_TIPO_CONTAS ' + NL +
                      ' order by Tct.DSC_TCTA, Cta.DSC_CTA';

var
  Variables: array of string;

implementation

end.
