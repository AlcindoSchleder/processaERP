unit ArqSql;

interface

uses CmmConst;

resourcestring
// Select SQL for the aux tables from this module
  SqlAlmoxarifados      = 'select * from ALMOXARIFADOS ' + NL +
                          ' order by DSC_ALMX';

  SqlUnidades           = 'select * from UNIDADES ' + NL +
                          ' order by DSC_UNI';

  SqlSecoes             = 'select * from SECOES ' + NL +
                          ' order by DSC_SEC';

  SqlSecoesIns          = 'select * from SECOES     ' + NL +
                          ' where ((FLAG_TMAT = 0)  ' + NL +
                          '    or  (FLAG_TMAT = 2)) ' + NL +
                          ' order by DSC_SEC';

  SqlSecoesMaquinas     = 'select * from SECOES ' + NL +
                          ' where FLAG_TMAT = 5 ' + NL +
                          ' order by DSC_SEC';

  SqlSecoesPecas        = 'select * from SECOES ' + NL +
                          ' where FLAG_TMAT = 1 ' + NL +
                          ' order by DSC_SEC';

  SqlSecoesProd         = 'select * from SECOES ' + NL +
                          ' where FLAG_TMAT = 3 ' + NL +
                          ' order by DSC_SEC';

  SqlSecoesServ         = 'select * from SECOES ' + NL +
                          ' where FLAG_TMAT = 4 ' + NL +
                          ' order by DSC_SEC';

  SqlGrupos             = 'select * from GRUPOS ' + NL +
                          ' where FK_SECOES = :FkSecoes ' + NL +
                          ' order by DSC_GRU';

  SqlSubGrupos          = 'select * from SUBGRUPOS ' + NL +
                          ' where FK_SECOES = :FkSecoes ' + NL +
                          ' and FK_GRUPOS = :FkGrupos ' + NL +
                          ' order by DSC_SGRU';

  SqlLinhas             = 'select * from LINHAS ' + NL +
                          ' order by DSC_LIN';

  SqlSimilares          = 'select * from SIMILARES ' + NL +
                          ' order by DSC_SIM';

  SqlTiposProd          = 'select * from TIPO_PRODUTOS ' + NL +
                          ' order by DSC_TPRD';

  SqlTipoSitEstqs       = 'select * from TIPO_SITUACAO_ESTOQUES ' + NL +
                          ' order by DSC_TSE';

  SqlProdutoBarras      = 'select * from PRODUTOS_BARRAS ' + NL +
                          ' where FK_PRODUTOS = :FK_PRODUTOS ' + NL +
                          ' order by PK_PRODUTOS_BARRAS';

  SqlProduto            = 'select * from PRODUTOS         ' + NL +
                          '  where PK_PRODUTOS = :Produto ';

  SqlProdutos           = 'select * from PRODUTOS         ' + NL +
                          ' order by DSC_PROD             ';

  SqlFornecedores       = 'select * from VW_FORNECEDORES ' + NL +
                          ' order by RAZ_SOC';

  SqlInsumosAll         = 'select * from INSUMOS ' + NL +
                          ' order by DSC_INS     ';

  SqlInsumos            = 'select Ins.PK_INSUMOS, Ins.DSC_INS   ' + NL +
                          '  from INSUMOS Ins, SECOES Sec       ' + NL +
                          ' where Ins.FLAG_COMP <> 1            ' + NL +
                          '   and Ins.PK_INSUMOS not in (select FK_INSUMOS from PRODUTOS) ' + NL +
                          '   and Sec.PK_SECOES = Ins.FK_SECOES ' + NL +
                          '   and Sec.FLAG_TMAT = 0             ' + NL +
                          '  order by Ins.DSC_INS ';

  SqlComposicoes        = 'select PK_INSUMOS_COMPOSICOES, QTD_INS, ' + NL +
                          '       SEQ_MIST, FK_INSUMOS             ' + NL +
                          '  from INSUMOS_COMPOSICOES              ' + NL +
                          ' where FK_INSUMOS = :Insumo             ' + NL +
                          ' order by SEQ_MIST                      ';

  SqlInsumosCompos      = 'select PK_INSUMOS, DSC_INS ' + NL +
                          '  from INSUMOS             ' + NL +
                          ' where (FLAG_TINS = 7)     ' + NL +
                          '    or (FLAG_COMP = 1)     ' + NL +
                          ' order by DSC_INS          ';

  SqlInsertInsCompos    = 'insert into INSUMOS_COMPOSICOES ' + NL +
                          '  (FK_INSUMOS, PK_INSUMOS_COMPOSICOES, QTD_INS, SEQ_MIST) ' + NL +
                          'values ' + NL +
                          '  (:Insumo, :Composicao, :Quantidade, :Sequencia)';

  SqlDeleteInsCompos    = 'delete from INSUMOS_COMPOSICOES ' + NL +
                          ' where FK_INSUMOS = :Insumo     ';

  SqlInsumosBarras      = 'select PK_INSUMOS_BARRAS, FLAG_TBARRA, FK_INSUMOS ' + NL +
                          '  from INSUMOS_BARRAS        ' + NL +
                          ' where FK_INSUMOS = :Insumo  ' + NL +
                          ' order by FLAG_TBARRA,       ' + NL +
                          '          PK_INSUMOS_BARRAS  ';

  SqlInsertInsBarra     = 'insert into INSUMOS_BARRAS                     ' + NL +
                          '  (FK_INSUMOS, PK_INSUMOS_BARRAS, FLAG_TBARRA) ' + NL +
                          'values                                         ' + NL +
                          '  (:Insumo, :BarCode, :FlagTBarra)             ';

  SqlDeleteInsBarras    = 'delete from INSUMOS_BARRAS  ' + NL +
                          ' where FK_INSUMOS = :Insumo ';

  SqlInsumoCusto        = 'select * from INSUMOS_CUSTOS  ' + NL +
                          ' where FK_EMPRESAS = :Empresa ' + NL +
                          '   and FK_INSUMOS  = :Insumo  ';

  SqlInsumosCustosHist  = 'select CUST_FORN, CUST_UFRN, CUST_REAL, CUST_MED,   ' + NL +
                          '       CUST_FINAL, CUST_FORN_ANT, CUST_UFRN_ANT,    ' + NL +
                          '       CUST_REAL_ANT, CUST_MED_ANT, CUST_FINAL_ANT, ' + NL +
                          '       DTHR_INC, PK_INSUMOS_HISTORICOS              ' + NL +
                          '  from INSUMOS_HISTORICOS                           ' + NL +
                          ' where FK_EMPRESAS  = :Empresa                      ' + NL +
                          '   and FK_INSUMOS   = :Insumo                       ' + NL +
                          '   and (((Cast(DTHR_INC as Date) >= :DtaIni)        ' + NL +
                          '    or (1 > :DummyIni))                             ' + NL +
                          '   and ((Cast(DTHR_INC as Date) <= :DtaFin)         ' + NL +
                          '    or (1 > :DummyFin)))                            ' + NL +
                          ' order by DTHR_INC                                  ';

  SqlInsumoEstoque      = 'select * from INSUMOS_ESTOQUES  ' + NL +
                          ' where FK_EMPRESAS = :Empresa   ' + NL +
                          '   and FK_INSUMOS  = :Insumo    ';

  SqlInsumosLotacoes    = 'select QTD_LOT, RUA_INS, NIVEL_INS,      ' + NL +
                          '       BOX_INS, PK_INSUMOS_LOTACOES      ' + NL +
                          '  from INSUMOS_LOTACOES                  ' + NL +
                          ' where FK_EMPRESAS       = :Empresa      ' + NL +
                          '   and FK_INSUMOS        = :Insumo       ' + NL +
                          '   and FK_ALMOXARIFADOS  = :Almoxarifado ' + NL +
                          ' order by RUA_INS, NIVEL_INS, BOX_INS    ';

  SqlInsertInsLotacoes  = 'insert into INSUMOS_LOTACOES                  ' + NL +
                          '  (FK_EMPRESAS, FK_INSUMOS, FK_ALMOXARIFADOS, ' + NL +
                          '   PK_INSUMOS_LOTACOES, QTD_LOT, RUA_INS,     ' + NL +
                          '   NIVEL_INS, BOX_INS)                        ' + NL +
                          'values                                        ' + NL +
                          '  (:Empresa, :Insumo, :Almoxarifado, null,    ' + NL +
                          '   :QtdLot, :RuaIns, :NivelIns, :BoxIns)' ;

  SqlDeleteInsLotacoes  = 'delete from INSUMOS_LOTACOES           ' + NL +
                          ' where FK_EMPRESAS      = :Empresa     ' + NL +
                          '   and FK_INSUMOS       = :Insumo      ' + NL +
                          '   and FK_ALMOXARIFADOS = :Almoxarifado';

  SqlInsumosEstqHist    = 'select DTHR_SLD, ''** documento **'' as DOC_SLD, ' + NL +
                          '       QTD_ENTRADA, QTD_SAIDA, SLD_INS           ' + NL +
                          '  from INSUMOS_SALDO                             ' + NL +
                          ' where FK_EMPRESAS      = :Empresa               ' + NL +
                          '   and FK_ALMOXARIFADOS = :Almoxarifado          ' + NL +
                          '   and FK_INSUMOS       = :Insumo                ' + NL +
                          '   and (((Cast(DTHR_SLD as Date) >= :DtaIni)     ' + NL +
                          '    or (1 > :DummyIni))                          ' + NL +
                          '   and ((Cast(DTHR_SLD as Date) <= :DtaFin)      ' + NL +
                          '    or (1 > :DummyFin)))                         ' + NL +
                          ' order by DTHR_SLD                               ';

  SqlInsumoFornecedor   = 'select * from INSUMOS_FORNECEDORES ' + NL +
                          ' where FK_EMPRESAS = :Empresa      ' + NL +
                          '   and FK_INSUMOS  = :Insumo       ';

  SqlInsumosFornHist    = 'select DTHR_SLD, ''** documento **'' as DOC_SLD, ' + NL +
                          '       QTD_ENTRADA, QTD_SAIDA, SLD_INS           ' + NL +
                          '  from INSUMOS_SALDO                             ' + NL +
                          ' where FK_EMPRESAS      = :Empresa               ' + NL +
                          '   and FK_ALMOXARIFADOS = :Almoxarifado          ' + NL +
                          '   and FK_INSUMOS       = :Insumo                ' + NL +
                          '   and (((Cast(DTHR_SLD as Date) >= :DtaIni)     ' + NL +
                          '    or (1 > :DummyIni))                          ' + NL +
                          '   and ((Cast(DTHR_SLD as Date) <= :DtaFin)      ' + NL +
                          '    or (1 > :DummyFin)))                         ' + NL +
                          ' order by DTHR_SLD                               ';

  SqlInsertInsForns     = 'insert into INSUMOS_FORNECEDORES_IMPST          ' + NL +
                          '  (FK_EMPRESAS, FK_INSUMOS, FK_VW_FORNECEDORES, ' + NL +
                          '   FK_TIPO_IMPOSTOS)                            ' + NL +
                          'values                                          ' + NL +
                          '  (:Empresa, :Insumo, :Fornecedor, :TipoImposto)' ;

  SqlDeleteInsForns     = 'delete from INSUMOS_FORNECEDORES_IMPST   ' + NL +
                          ' where FK_EMPRESAS        = :Empresa     ' + NL +
                          '   and FK_INSUMOS         = :Insumo      ' + NL +
                          '   and FK_VW_FORNECEDORES = :Fornecedor';

  SqlLocateInsForns     = 'select FK_TIPO_IMPOSTOS                 ' + NL +
                          '  from INSUMOS_FORNECEDORES_IMPST       ' + NL +
                          ' where FK_EMPRESAS        = :Empresa    ' + NL +
                          '   and FK_INSUMOS         = :Insumo     ' + NL +
                          '   and FK_VW_FORNECEDORES = :Fornecedor ' + NL +
                          '   and FK_TIPO_IMPOSTOS   = :TipoImposto';

  SqlServicos_Ind       = 'select * from SERVICOS_IND ' + NL +
                          ' order by DSC_SRV          ';

  SqlPecasProd          = 'select * from PECAS   ' + NL +
                          ' where FLAG_TCOMP = 3 ' + NL +
                          ' order by DSC_PEC  ';

  SqlTipoFases          = 'select * from TIPO_FASES_PRODUCAO '+ NL +
                          ' order by DSC_FASE                ';

  SqlTabelaPrecos       = 'select * from TABELA_PRECOS '+ NL +
                          ' order by DSC_TAB           ';

  SqlPrecosProduto      = 'select Tab.DSC_TAB, Pre.PRE_VDA, Prm.MRG_LCR,      ' + NL +
                          '       Prm.SIT_TRIB, Prm.CLASS_FISCAL,             ' + NL +
                          '       Tab.PK_TABELA_PRECOS                        ' + NL +
                          '  from TABELA_PRECOS Tab                           ' + NL +
                          '  left outer join PRODUTOS_PRECOS Pre              ' + NL +
                          '    on Pre.FK_EMPRESAS  = :Empresa                 ' + NL +
                          '   and Pre.FK_PRODUTOS  = :Produto                 ' + NL +
                          '   and Pre.FK_TABELA_PRECOS = Tab.PK_TABELA_PRECOS ' + NL +
                          '  left outer join PRODUTOS_MARGEM Prm              ' + NL +
                          '    on Prm.FK_EMPRESAS  = :Empresa                 ' + NL +
                          '   and Prm.FK_PRODUTOS  = Pre.FK_PRODUTOS          ' + NL +
                          ' order by Tab.DSC_TAB                              ';

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

  SqlInsertTabPrecos    = 'insert into PRODUTOS_PRECOS                    ' + NL +
                          '  (FK_EMPRESAS, FK_PRODUTOS, FK_TABELA_PRECOS, ' + NL +
                          '   PRE_VDA)                                    ' + NL +
                          'values                                         ' + NL +
                          '  (:Empresa, :Produto, :TabPreco, :PreVda)     ' ;

  SqlDeleteTabPrecos     = 'delete from PRODUTOS_PRECOS         ' + NL +
                          ' where FK_EMPRESAS        = :Empresa ' + NL +
                          '   and FK_PRODUTOS        = :Produto ';

  SqlInsertMargens      = 'insert into PRODUTOS_MARGEM                 ' + NL +
                          '  (FK_EMPRESAS, FK_PRODUTOS, MRG_LCR,       ' + NL +
                          '   FK_SITUACAO_TRIBUTARIAS,  CLASS_FISCAL,  ' + NL +
                          '   FK_ORIGENS_TRIBUTARIAS, SIT_TRIB)        ' + NL +
                          'values                                      ' + NL +
                          '  (:Empresa, :Produto, :MrgLcr, :FkSitTrib, ' + NL +
                          '   :ClassFiscal, :FkOrgTrib, :SitTrib)      ';

  SqlDeleteMargens      = 'delete from PRODUTOS_MARGEM          ' + NL +
                          ' where FK_EMPRESAS        = :Empresa ' + NL +
                          '   and FK_PRODUTOS        = :Produto ';

  SqlInsertImpostos     = 'insert into PRODUTOS_IMPOSTOS                  ' + NL +
                          '  (FK_EMPRESAS, FK_PRODUTOS, FK_TIPO_IMPOSTOS) ' + NL +
                          'values                                         ' + NL +
                          '  (:Empresa, :Produto, :TipoImposto)           ' ;

  SqlDeleteImpostos     = 'delete from PRODUTOS_IMPOSTOS        ' + NL +
                          ' where FK_EMPRESAS        = :Empresa ' + NL +
                          '   and FK_PRODUTOS        = :Produto ';

// Select SQL for the aux tables from other modules

  SqlTipoAcabamentos    = 'select * from TIPO_ACABAMENTOS ' + NL +
                          ' order by DSC_ACABM';

  SqlTipoReferencias    = 'select * from TIPO_REFERENCIAS               ' + NL +
                          ' where FK_TIPO_ACABAMENTOS = :TipoAcabamento ' + NL +
                          ' order by DSC_REF';

  SqlLinguagens         = 'select * from LINGUAGENS '+ NL +
                          ' order by DSC_LANG       ';

  SqlTipoDescontos      = 'select * from TIPO_DESCONTOS ' + NL +
                          ' order by DSC_TDSCT';

  SqlDescontos          = 'select * from DESCONTOS                      '+ NL +
                          ' where FK_TIPO_DESCONTOS =:Fk_Tipo_Descontos ' + NL +
                          ' order by IDX_DSCT                           ';

  SqlImpostos           = 'select DSC_IMPS, PK_TIPO_IMPOSTOS, FLAG_CALC, ' + NL +
                          '       FLAG_IMPST, RED_BASC                   ' + NL +
                          '    from TIPO_IMPOSTOS order by DSC_IMPS      ';

  SqlOrigemTrb          = 'select * from ORIGENS_TRIBUTARIAS order by DSC_ORGM';

  SqlSituacaoTrb        = 'select * from SITUACAO_TRIBUTARIAS order by DSC_IMPST';

//  SqlAllFornec          = 'select Prd.PK_PRODUTOS, Prd.DSC_PROD,    ' + NL +
//                          '       Frn.PK_CADASTROS, Frn.RAZ_SOC     ' + NL +
//                          '  from PRODUTOS Prd                      ' + NL +
//                  'left outer join PRODUTO_FORNECEDORES Pfr  on Pfr.FK_EMPRESAS  = :Empresa               ' + NL +
//                  '                                         and Pfr.FK_PRODUTOS  = Prd.PK_PRODUTOS        ' + NL +
//                  'left outer join VW_FORNECEDORES      Frn  on Frn.PK_CADASTROS = Pfr.FK_VW_FORNECEDORES ' + NL +
//                          ' where PK_PRODUTOS = :Produto            ';
//                          'union                                    ' + NL +
//                          'select 0 as PK_PRODUTOS, Cast(''Fornecedores não Inclusos'' as VARCHAR(50)) as DSC_PROD,  ' + NL +
//                          '       PK_CADASTROS, RAZ_SOC             ' + NL +
//                          '  from VW_FORNECEDORES                   ' + NL +
//                          ' where PK_CADASTROS not in               ' + NL +
//                          '       (select FK_VW_FORNECEDORES        ' + NL +
//                          '          from PRODUTO_FORNECEDORES      ' + NL +
//                          '          where FK_EMPRESAS  = :Empresa  ' + NL +
//                          '            and FK_PRODUTOS  = :Produto) ';
var
  Variables: array of string;

implementation

end.
