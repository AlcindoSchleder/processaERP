unit ConfArqSql;

interface

uses CmmConst;

resourcestring
// Select SQL for the aux tables from this module
  SqlGetFinishReference = 'select Tac.PK_TIPO_ACABAMENTOS,  Tac.DSC_ACABM, ' + NL +
                          '       Trf.FK_TIPO_ACABAMENTOS, Trf.PK_TIPO_REFERENCIAS, ' + NL +
                          '       Trf.DSC_REF ' + NL +
                          '  from TIPO_ACABAMENTOS Tac ' + NL +
                          '  left outer join TIPO_REFERENCIAS Trf ' + NL +
                          '    on Trf.FK_TIPO_ACABAMENTOS = Tac.PK_TIPO_ACABAMENTOS ' + NL +
                          ' where Tac.PK_TIPO_ACABAMENTOS > 0 ' + NL +
                          ' order by Tac.DSC_ACABM, Trf.DSC_REF';

  SqlGenTypeFinish      = 'select Gen_Id(TIPO_ACABAMENTOS, 1) as PK_TIPO_ACABAMENTOS ' + NL +
                          '  from PARAMETRO_GLOBAIS';

  SqlTipoAcabamentos    = 'select * from TIPO_ACABAMENTOS order by DSC_ACABM';

  SqlTypeFinish         = 'select * from TIPO_ACABAMENTOS ' + NL +
                          ' where PK_TIPO_ACABAMENTOS = :PkTipoAcabamentos';

  SqlDeleteTypeFinish   = 'delete from TIPO_ACABAMENTOS ' + NL +
                          ' where PK_TIPO_ACABAMENTOS = :PkTipoAcabamentos';

  SqlInsertTypeFinish   = 'insert into TIPO_ACABAMENTOS ' + NL +
                          '  (PK_TIPO_ACABAMENTOS, DSC_ACABM, FLAG_TDSC) ' + NL +
                          'values ' + NL +
                          '  (:PkTipoAcabamentos, :DscAcabm, :FlagTDsc)';

  SqlUpdateTypeFinish   = 'update TIPO_ACABAMENTOS set ' + NL +
                          '       DSC_ACABM           = :DscAcabm, ' + NL +
                          '       FLAG_TDSC           = :FlagTDsc ' + NL +
                          ' where PK_TIPO_ACABAMENTOS = :PkTipoAcabamentos';

  SqlGenTypeReference   = 'select Cast((Max(PK_TIPO_REFERENCIAS) + 1) as Integer) ' + NL +
                          '       as PK_TIPO_REFERENCIAS ' + NL +
                          '  from TIPO_REFERENCIAS ' + NL +
                          ' where FK_TIPO_ACABAMENTOS = :FkTipoAcabamentos';

  SqlTypeReference      = 'select * from TIPO_REFERENCIAS ' + NL +
                          ' where FK_TIPO_ACABAMENTOS = :FkTipoAcabamentos ' + NL +
                          '   and PK_TIPO_REFERENCIAS = :PkTipoReferencias';

  SqlDelTypeReference   = 'delete from TIPO_REFERENCIAS ' + NL +
                          ' where FK_TIPO_ACABAMENTOS = :FkTipoAcabamentos ' + NL +
                          '   and PK_TIPO_REFERENCIAS = :PkTipoReferencias';

  SqlInsTypeReference   = 'insert into TIPO_REFERENCIAS ' + NL +
                          '  (FK_TIPO_ACABAMENTOS, PK_TIPO_REFERENCIAS, ' + NL +
                          '   DSC_REF, FAIXA_CUST_INI, FAIXA_CUST_FIN, ' + NL +
                          '   FLAG_TINS) ' + NL +
                          'values ' + NL +
                          '  (:FkTipoAcabamentos, :PkTipoReferencias, ' + NL +
                          '   :DscRef, :FaixaCustIni, :FaixaCustFin, :FlagTDsc)';

  SqlUpdTypeReference   = 'update TIPO_REFERENCIAS set ' + NL +
                          '       DSC_REF             = :DscRef, ' + NL +
                          '       FAIXA_CUST_INI      = :FaixaCustIni, ' + NL +
                          '       FAIXA_CUST_FIN      = :FaixaCustFin, ' + NL +
                          '       FLAG_TINS           = :FlagTDsc ' + NL +
                          ' where FK_TIPO_ACABAMENTOS = :FkTipoAcabamentos ' + NL +
                          '   and PK_TIPO_REFERENCIAS = :PkTipoReferencias';

  SqlGenTypeComponent   = 'select Gen_Id(TIPO_COMPONENTES, 1) as PK_TIPO_COMPONENTES ' + NL +
                          '  from PARAMETRO_GLOBAIS';

  SqlTypeComponents     = 'select * from TIPO_COMPONENTES ' + NL +
                          ' order by DSC_TCOMP';

  SqlTypeComponent      = 'select * from TIPO_COMPONENTES ' + NL +
                          ' where PK_TIPO_COMPONENTES = :PkTipoComponentes';

  SqlDeleteTComponent   = 'delete from TIPO_COMPONENTES ' + NL +
                          ' where PK_TIPO_COMPONENTES = :PkTipoComponentes';

  SqlInsertTComponent   = 'insert into TIPO_COMPONENTES ' + NL +
                          '  (PK_TIPO_COMPONENTES, DSC_TCOMP) ' + NL +
                          'values ' + NL +
                          '  (:PkTipoComponentes, :DscTComp)';

  SqlUpdateTComponent   = 'update TIPO_COMPONENTES set ' + NL +
                          '       DSC_TCOMP           = :DscTComp ' + NL +
                          ' where PK_TIPO_COMPONENTES = :PkTipoComponentes';

  SqlReferencias        = 'select FK_TIPO_REFERENCIAS, FLAG_ATIVO '          + NL +
                          '  from REFERENCIAS  '                             + NL +
                          ' where FK_EMPRESAS         = :FkEmpresas '        + NL +
                          '   and FK_PRODUTOS         = :FkProdutos '        + NL +
                          '   and FK_COMPONENTES      = :FkTipoComponentes ' + NL +
                          '   and FK_ACABAMENTOS      = :FkTipoAcabamentos ' + NL +
                          '   and FK_TIPO_REFERENCIAS = :FkTipoReferencias';

  SqlTipoReferencias    = 'select Trf.PK_TIPO_REFERENCIAS, Trf.DSC_REF '             + NL +
                          '  from TIPO_REFERENCIAS Trf '                             + NL +
                          ' where Trf.FK_TIPO_ACABAMENTOS   = :FkTipoAcabamentos '   + NL +
                          '   and ((Trf.PK_TIPO_REFERENCIAS = :FkTipoReferencias) '  + NL +
                          '    or ((not Trf.PK_TIPO_REFERENCIAS in ( '               + NL +
                          '       select FK_TIPO_REFERENCIAS '                       + NL +
                          '         from REFERENCIAS '                               + NL +
                          '        where FK_EMPRESAS    = :FkEmpresas '              + NL +
                          '          and FK_PRODUTOS    = :FkProdutos '              + NL +
                          '          and FK_COMPONENTES = :FkTipoComponentes '       + NL +
                          '          and FK_ACABAMENTOS = :FkTipoAcabamentos)) '     + NL +
                          '   and (Trf.FK_TIPO_ACABAMENTOS = :FkTipoAcabamentos))) ' + NL +
                          ' order by Trf.DSC_REF';

  SqlInsertReferencias  = 'insert into REFERENCIAS '                          + NL +
                          '  (FK_EMPRESAS, FK_PRODUTOS, FK_COMPONENTES, '     + NL +
                          '   FK_ACABAMENTOS,  FK_TIPO_REFERENCIAS,  '        + NL +
                          '   FLAG_ATIVO) '                                   + NL +
                          'values '                                           + NL +
                          '  (:FkEmpresas, :FkProdutos, :FkTipoComponentes, ' + NL +
                          '   :FkTipoAcabamentos, :FkTipoReferencias, '       + NL +
                          '   :FlagAtivo)';

  SqlUpdateReferencias  = 'update REFERENCIAS set '                          + NL +
                          '       FLAG_ATIVO          = :FlagAtivo '         + NL +
                          ' where FK_EMPRESAS         = :FkEmpresas '        + NL +
                          '   and FK_PRODUTOS         = :FkProdutos '        + NL +
                          '   and FK_COMPONENTES      = :FkTipoComponentes ' + NL +
                          '   and FK_ACABAMENTOS      = :FkTipoAcabamentos ' + NL +
                          '   and FK_TIPO_REFERENCIAS = :FkTipoReferencias';

  SqlTipoCompoProdutos  = 'select Tcp.PK_TIPO_COMPONENTES, Tcp.DSC_TCOMP ' + NL +
                          '  from TIPO_COMPONENTES Tcp ' + NL +
                          ' where ((Tcp.PK_TIPO_COMPONENTES = :FkTipoComponentes) ' + NL +
                          '    or (not Tcp.PK_TIPO_COMPONENTES in ( ' + NL +
                          '       select FK_TIPO_COMPONENTES ' + NL +
                          '         from COMPONENTES ' + NL +
                          '        where FK_PRODUTOS = :FkProdutos))) ' + NL +
                          ' order by Tcp.DSC_TCOMP';

  SqlComponentes1       = 'select Tcp.DSC_TCOMP, Tac.DSC_ACABM, Trf.DSC_REF, '         + NL +
                          '       Cmp.FK_TIPO_COMPONENTES, Cmp.QTD_COMP, '             + NL +
                          '       Acb.FK_TIPO_ACABAMENTOS, Ref.FK_TIPO_REFERENCIAS, '  + NL +
                          '       Acb.QTD_PDR, Acb.QTD_PERS, Ref.FLAG_ATIVO '          + NL +
                          '  from COMPONENTES Cmp '                                    + NL +
                          '  left outer join ACABAMENTOS Acb '                         + NL +
                          '  left outer join TIPO_ACABAMENTOS Tac '                    + NL +
                          '    on Tac.PK_TIPO_ACABAMENTOS = Acb.FK_TIPO_ACABAMENTOS '  + NL +
                          '    on Acb.FK_PRODUTOS         = Cmp.FK_PRODUTOS '          + NL +
                          '   and Acb.FK_COMPONENTES      = Cmp.FK_TIPO_COMPONENTES '  + NL +
                          '  left outer join REFERENCIAS Ref '                         + NL +
                          '  left outer join TIPO_REFERENCIAS Trf '                    + NL +
                          '    on Trf.FK_TIPO_ACABAMENTOS = Ref.FK_ACABAMENTOS '       + NL +
                          '   and Trf.PK_TIPO_REFERENCIAS = Ref.FK_TIPO_REFERENCIAS '  + NL +
                          '    on Ref.FK_ACABAMENTOS      = Acb.fk_tipo_acabamentos '  + NL +
                          '   and Ref.FK_COMPONENTES      = Acb.FK_COMPONENTES '       + NL +
                          '   and Ref.FK_PRODUTOS         = Acb.FK_PRODUTOS '          + NL +
                          '   and Ref.FK_EMPRESAS         = :FkEmpresas, '             + NL +
                          '       TIPO_COMPONENTES Tcp ';
  SqlComponentes2       = ' where Tcp.PK_TIPO_COMPONENTES   = Cmp.FK_TIPO_COMPONENTES ' + NL +
                          '   and Cmp.FK_PRODUTOS           = :FkProdutos '             + NL +
                          '   and ((Cmp.FK_TIPO_COMPONENTES = :FkTipoComponentes) '     + NL +
                          '    or (1                        > :FkTipoComponentes)) '    + NL +
                          ' order by Tcp.DSC_TCOMP, Tac.DSC_ACABM, Trf.DSC_REF';

  SqlInsertComponente   = 'insert into COMPONENTES '                        + NL +
                          '  (FK_PRODUTOS, FK_TIPO_COMPONENTES, QTD_COMP) ' + NL +
                          'values '                                         + NL +
                          '  (:FkProdutos, :FkTipoComponentes, :QtdComp)';

  SqlUpdateComponente   = 'update COMPONENTES set '                        + NL +
                          '       QTD_COMP = :QtdComp '                    + NL +
                          ' where FK_PRODUTOS         = :FkProdutos '      + NL +
                          '   and FK_TIPO_COMPONENTES = :FkTipoComponentes';

  SqlTipoAcabamentoComp = 'select Tac.PK_TIPO_ACABAMENTOS, Tac.DSC_ACABM '           + NL +
                          '  from TIPO_ACABAMENTOS Tac '                             + NL +
                          ' where ((Tac.PK_TIPO_ACABAMENTOS = :FkTipoAcabamentos)) ' + NL +
                          '    or (not Tac.PK_TIPO_ACABAMENTOS in ( '                + NL +
                          '       select FK_TIPO_ACABAMENTOS '                       + NL +
                          '         from ACABAMENTOS '                               + NL +
                          '        where FK_PRODUTOS = :FkProdutos '                 + NL +
                          '          and FK_COMPONENTES = :FkTipoComponentes)) '     + NL +
                          ' order by Tac.DSC_ACABM';

  SqlAcabamentos        = 'select FLAG_TACBM, QTD_PDR, QTD_PERS '            + NL +
                          '  from ACABAMENTOS '                              + NL +
                          ' where FK_PRODUTOS         = :FkProdutos '        + NL +
                          '   and FK_COMPONENTES      = :FkTipoComponentes ' + NL +
                          '   and FK_TIPO_ACABAMENTOS = :FkTipoAcabamentos';

  SqlInsertAcabamento   = 'insert into ACABAMENTOS '                              + NL +
                          '  (FK_PRODUTOS, FK_COMPONENTES, FK_TIPO_ACABAMENTOS, ' + NL +
                          '   FLAG_TACBM, QTD_PDR, QTD_PERS) '                    + NL +
                          'values '                                               + NL +
                          '  (:FkProdutos,  :FkTipoComponentes, :FkTipoAcabamentos, ' + NL +
                          '   :FlagTAcbm, :QtdPdr, :QtdPers)';

  SqlUpdateAcabamento   = 'update ACABAMENTOS set '                          + NL +
                          '       FLAG_TACBM = :FlagTAcbm, '                 + NL +
                          '       QTD_PDR    = :QtdPdr, '                    + NL +
                          '       QTD_PERS   = :QtdPers '                    + NL +
                          ' where FK_PRODUTOS         = :FkProdutos '        + NL +
                          '   and FK_COMPONENTES      = :FkTipoComponentes ' + NL +
                          '   and FK_TIPO_ACABAMENTOS = :FkTipoAcabamentos';

  SqlPrecosReferencia   = '  select Tac.PK_TIPO_ACABAMENTOS as FK_TIPO_ACABAMENTOS, ' + NL +
                          '         Tac.DSC_ACABM, Trf.DSC_REF, ' + NL +
                          '         Trf.PK_TIPO_REFERENCIAS as FK_TIPO_REFERENCIAS, ' + NL +
                          '         Tbp.PK_TABELA_PRECOS as FK_TABELA_PRECOS, ' + NL +
                          '         Tbp.DSC_TAB as DESCRICAO_PRECO, ' + NL +
                          '         cast(0.0 as float) as PRECO ' + NL +
                          '    from TIPO_ACABAMENTOS Tac, TIPO_REFERENCIAS Trf, ' + NL +
                          '         TABELA_PRECOS Tbp ' + NL +
                          '   where Trf.FK_TIPO_ACABAMENTOS = Tac.PK_TIPO_ACABAMENTOS ' + NL +
                          'union ' + NL +
                          '  select Tac.PK_TIPO_ACABAMENTOS as FK_TIPO_ACABAMENTOS, ' + NL +
                          '         Tac.DSC_ACABM, Trf.DSC_REF, ' + NL +
                          '         Trf.PK_TIPO_REFERENCIAS as FK_TIPO_REFERENCIAS, ' + NL +
                          '         cast(0 as smallint) as FK_TABELA_PRECOS, ' + NL +
                          '         cast(''Preço Sugerido'' as varchar(30)) as DESCRICAO_PRECO, ' + NL +
                          '         cast(0.0 as float) as PRECO ' + NL +
                          '    from TIPO_ACABAMENTOS Tac, TIPO_REFERENCIAS Trf ' + NL +
                          '   where Trf.FK_TIPO_ACABAMENTOS = Tac.PK_TIPO_ACABAMENTOS ' + NL +
                          'order by 2,3,5';

  SqlPrecoSugestao      = 'select PRE_SJST as PRECO '                        + NL +
                          '  from TP_REF_PRODUTOS '                          + NL +
                          ' where FK_EMPRESAS         = :FkEmpresas '        + NL +
                          '   and FK_PRODUTOS         = :FkProdutos '        + NL +
                          '   and FK_TIPO_ACABAMENTOS = :FkTipoAcabamentos ' + NL +
                          '   and FK_TIPO_REFERENCIAS = :FkTipoReferencias ';

  SqlPrecoAcabamento    = 'select PRE_VDA as PRECO '                         + NL +
                          '  from ACABAMENTO_PRECOS '                        + NL +
                          ' where FK_EMPRESAS         = :FkEmpresas '        + NL +
                          '   and FK_PRODUTOS         = :FkProdutos '        + NL +
                          '   and FK_TIPO_ACABAMENTOS = :FkTipoAcabamentos ' + NL +
                          '   and FK_TIPO_REFERENCIAS = :FkTipoReferencias ' + NL +
                          '   and FK_TABELA_PRECOS    = :FkTabelaPrecos ';

  SqlDeleteReferencia   = 'delete from REFERENCIAS '                    + NL +
                          ' where FK_EMPRESAS    = :FkEmpresas '        + NL +
                          '   and FK_PRODUTOS    = :FkProdutos '        + NL +
                          '   and FK_COMPONENTES = :FkTipoComponentes ' + NL +
                          '   and FK_ACABAMENTOS = :FkTipoAcabamentos';

  SqlDeleteAcabamentos  = 'delete from ACABAMENTOS '                       + NL +
                          ' where FK_PRODUTOS         = :FkProdutos '      + NL +
                          '   and FK_COMPONENTES      = :FkComponentes '   + NL +
                          '   and FK_TIPO_ACABAMENTOS = :FkTipoAcabamentos';

  SqlDeleteRefComp      = 'delete from REFERENCIAS '              + NL +
                          ' where FK_EMPRESAS    = :FkEmpresas '  + NL +
                          '   and FK_PRODUTOS    = :FkProdutos '  + NL +
                          '   and FK_COMPONENTES = :FkComponentes';

  SqlDeleteCompAcabam   = 'delete from ACABAMENTOS '                       + NL +
                          ' where FK_PRODUTOS         = :FkProdutos '      + NL +
                          '   and FK_COMPONENTES      = :FkComponentes ';

  SqlDeleteComponente   = 'delete from COMPONENTES '                       + NL +
                          ' where FK_PRODUTOS         = :FkProdutos '      + NL +
                          '   and FK_TIPO_COMPONENTES = :FkTipoComponentes';

  SqlDeleteRefCompleta  = 'delete from REFERENCIAS '                       + NL +
                          ' where FK_EMPRESAS         = :FkEmpresas '      + NL +
                          '   and FK_PRODUTOS         = :FkProdutos '      + NL +
                          '   and FK_COMPONENTES      = :FkComponentes '   + NL +
                          '   and FK_ACABAMENTOS      = :FkAcabamentos '   + NL +
                          '   and FK_TIPO_REFERENCIAS = :FkTipoReferencias';

  SqlDeleteAcabamPreco  = 'delete from ACABAMENTO_PRECOS '    + NL +
                          ' where FK_EMPRESAS = :FkEmpresas ' + NL +
                          '   and FK_PRODUTOS = :FkProdutos ';

  SqlInsertAcabamentos  = 'insert into ACABAMENTO_PRECOS '                      + NL +
                          '  (FK_EMPRESAS, FK_PRODUTOS, FK_TIPO_ACABAMENTOS, '  + NL +
                          '   FK_TIPO_REFERENCIAS, FK_TABELA_PRECOS, PRE_VDA) ' + NL +
                          'values '                                             + NL +
                          '  (:FkEmpresas, :FkProdutos, :FkTipoAcabamentos, '   + NL +
                          '   :FkTipoReferencias, :FkTabelaPrecos, :PreVda) ';

  SqlCopyStruct         = 'select * from  STP_COPY_ACABAMENTO_STRUCT( ' + NL +
                          '       :FkEmpresas, '                        + NL +
                          '       :FkProdutosFrom, '                    + NL +
                          '       :FkProdutosTo)';


// Select SQL for the aux tables from other modules

  SqlLinhas             = 'select PK_LINHAS, DSC_LIN ' + NL +
                          '  from LINHAS '             + NL +
                          ' order by DSC_LIN';

  SqlSecoes             = 'select PK_SECOES, DSC_SEC ' + NL +
                          '  from SECOES '             + NL +
                          ' order by DSC_SEC';

  SqlGrupos             = 'select PK_GRUPOS, DSC_GRU '    + NL +
                          '  from GRUPOS '                + NL +
                          ' where FK_SECOES = :FkSecoes ' + NL +
                          '  order by DSC_GRU';

  SqlProdutos           = 'select Pcd.COD_REF, Prd.PK_PRODUTOS, '       + NL +
                          '       Prd.DSC_PROD '                        + NL +
                          '  from PRODUTOS Prd, PRODUTOS_CODIGOS Pcd, ' + NL +
                          '       PRODUTOS_VENDAS Prv '                 + NL +
                          ' where Pcd.FK_PRODUTOS = Prd.PK_PRODUTOS '   + NL +
                          '   and Prv.FK_PRODUTOS = Prd.PK_PRODUTOS '   + NL +
                          '   and ((Prv.FK_LINHAS = :FkLinhas) '        + NL +
                          '    or  (1             > :FkLinhas)) '       + NL +
                          '   and ((Prd.FK_SECOES = :FkSecoes) '        + NL +
                          '    or  (1             > :FkSecoes)) '       + NL +
                          '   and ((Prd.FK_GRUPOS = :FkGrupos) '        + NL +
                          '    or  (1             > :FkGrupos)) '       + NL +
                          ' order by Prd.DSC_PROD';

  SqlPkProdutos         = 'select Pcd.COD_REF, Prd.PK_PRODUTOS, '     + NL +
                          '       Prd.FK_SECOES, Prd.FK_GRUPOS, '     + NL +
                          '       Prd.DSC_PROD, Prv.FK_LINHAS, '      + NL +
                          '       Pim.IMG_PROD '                      + NL +
                          '  from PRODUTOS Prd '                      + NL +
                          '  join PRODUTOS_VENDAS Prv '               + NL +
                          '    on Prv.FK_PRODUTOS = Prd.PK_PRODUTOS ' + NL +
                          '  join PRODUTOS_CODIGOS Pcd '              + NL +
                          '    on Pcd.FK_PRODUTOS = Prd.PK_PRODUTOS ' + NL +
                          '   and Pcd.FLAG_TCODE  = 0 '               + NL +
                          '  left outer join PRODUTOS_IMAGENS Pim '   + NL +
                          '    on Pim.FK_PRODUTOS = Prd.PK_PRODUTOS ' + NL +
                          ' where Prd.PK_PRODUTOS = :FkProdutos';

  SqlReferenciaProduto  = 'select Pcd.COD_REF, Prd.PK_PRODUTOS, Prd.FK_SECOES, ' + NL +
                          '       Prd.FK_GRUPOS, Prd.DSC_PROD, Prv.FK_LINHAS, '  + NL +
                          '       (select count(*) from COMPONENTES '            + NL +
                          '       where FK_PRODUTOS = Prd.PK_PRODUTOS) '         + NL +
                          '        as TOTAL_COMPONENTES '                        + NL +
                          '  from PRODUTOS_CODIGOS Pcd, PRODUTOS Prd, '          + NL +
                          '       PRODUTOS_VENDAS Prv '                          + NL +
                          ' where Pcd.COD_REF     = :CodRef '                    + NL +
                          '   and Pcd.FLAG_TCODE  = :FlagTCode '                 + NL +
                          '   and Prd.PK_PRODUTOS = Pcd.FK_PRODUTOS '            + NL +
                          '   and Prv.FK_PRODUTOS = Pcd.FK_PRODUTOS';

var
  Variables: array of string;

implementation

end.
