unit ArqSql;

interface

resourcestring
// Select SQL for the aux tables from this module
  SqlCodPecas           = 'select Fch.* '                        + #13 +
                          '  from PECAS Pec, FICHA_TECNICA Fch ' + #13 +
                          ' where Pec.PK_PECAS = :Peca '         + #13 +
                          '   and Fch.FK_PECAS = Pec.PK_PECAS '  + #13 +
                          '   and Fch.MAJ_VER  = Pec.MAJ_VER '   + #13 +
                          '   and Fch.MIN_VER  = Pec.MIN_VER ';

  SqlRefPecas           = 'select first 1 * '               + #13 +
                          '  from FICHA_TECNICA '           + #13 +
                          ' where COD_REF  = :CodRef '      + #13 +
                          ' order by MAJ_VER, Min_Ver desc';

  SqlNewVersionPart     = 'select * from FICHA_TECNICA ' + #13 +
                          ' where COD_REF  = :CodRef '   + #13 +
                          '   and MAJ_VER  = :MajVer '   + #13 +
                          '   and MIN_VER  = :MinVer ';

  SqlPecaEstoque        = 'select * from PECAS_ESTOQUES '            + #13 +
                          ' where FK_EMPRESAS      = :Empresa '      + #13 +
                          '   and FK_PECAS         = :Peca '         + #13 +
                          '   and FK_FICHA_TECNICA = :FichaTecnica ' + #13 +
                          ' order by FK_ALMOXARIFADOS ';

  SqlPecaCusto          = 'select * from PECAS_CUSTOS '            + #13 +
                          ' where FK_EMPRESAS      = :Empresa '      + #13 +
                          '   and FK_PECAS         = :Peca '         + #13 +
                          '   and FK_FICHA_TECNICA = :FichaTecnica ';

  SqlSaldosGen          = 'select Psg.DTHR_SLD, Psg.NUM_DOC, Psg.QTD_ENTRADA, ' + #13 +
                          '       Psg.QTD_SAIDA, Psg.SLD_INS, Cad.RAZ_SOC, '    + #13 +
                          '       Tmv.DSC_MOV '                                 + #13 +
                          '  from PECAS_SALDO_GEN Psg '                         + #13 +
                          '  left outer join CADASTROS Cad '                    + #13 +
                          '    on Cad.PK_CADASTROS = Psg.FK_CADASTROS '         + #13 +
                          '  left outer join TIPO_MOVIM_ESTQ Tmv'               + #13 +
                          '    on Tmv.PK_TIPO_MOVIM_ESTQ = Psg.FK_TIPO_MOVIM_ESTQ ' + #13 +
                          ' where FK_EMPRESAS      = :FkEmpresas '              + #13 +
                          '   and FK_PECAS         = :FkPecas '                 + #13 +
                          '   and FK_FICHA_TECNICA = :FkFichaTecnica '          + #13 +
                          ' order by DTHR_SLD';

  SqlPecasLotacoes      = 'select QTD_LOT, RUA_INS, NIVEL_INS,      ' + #13 +
                          '       BOX_INS, PK_PECAS_LOTACOES        ' + #13 +
                          '  from PECAS_LOTACOES                    ' + #13 +
                          ' where FK_EMPRESAS       = :Empresa      ' + #13 +
                          '   and FK_PECAS          = :Peca         ' + #13 +
                          '   and FK_FICHA_TECNICA  = :FichaTecnica ' + #13 +
                          '   and FK_ALMOXARIFADOS  = :Almoxarifado ' + #13 +
                          ' order by RUA_INS, NIVEL_INS, BOX_INS    ';

  SqlInsertPecLotacoes  = 'insert into PECAS_LOTACOES                  ' + #13 +
                          '  (FK_EMPRESAS, FK_PECAS, FK_ALMOXARIFADOS, ' + #13 +
                          '   PK_PECAS_LOTACOES, QTD_LOT, RUA_INS,     ' + #13 +
                          '   NIVEL_INS, BOX_INS, COD_REF, FK_FICHA_TECNICA) ' + #13 +
                          'values                                      ' + #13 +
                          '  (:Empresa, :Peca, :Almoxarifado, null,    ' + #13 +
                          '   :QtdLot, :RuaIns, :NivelIns, :BoxIns,    ' + #13 +
                          '   :CodRef, :FichaTecnica) ' ;

  SqlDeletePecLotacoes  = 'delete from PECAS_LOTACOES '              + #13 +
                          ' where FK_EMPRESAS      = :Empresa '      + #13 +
                          '   and FK_PECAS         = :Peca '         + #13 +
                          '   and FK_FICHA_TECNICA = :FichaTecnica ' + #13 +
                          '   and FK_ALMOXARIFADOS = :Almoxarifado';

// Select SQL for the aux tables from other modules

  SqlSecoesPec          = 'select * from SECOES ' + #13 +
                          ' where FLAG_TMAT = 1 ' + #13 +
                          ' order by DSC_SEC    ';

  SqlGrupos             = 'select * from GRUPOS      ' + #13 +
                          ' where FK_SECOES = :Secao ' + #13 +
                          ' order by DSC_GRU         ';

  SqlSubGrupos          = 'select * from SUBGRUPOS   ' + #13 +
                          ' where FK_SECOES = :Secao ' + #13 +
                          '   and FK_GRUPOS = :Grupo ' + #13 +
                          ' order by DSC_SGRU         ';

  SqlAlmoxarifados      = 'select * from ALMOXARIFADOS ' + #13 +
                          ' order by DSC_ALMX          ';
var
  Variables: array of string;

implementation

end.
