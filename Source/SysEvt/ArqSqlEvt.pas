unit ArqSql;

interface

resourcestring
// sql aux strings
  GlobalSelectCountF    = 'select Count(*) from ';
  GlobalSelectCount     = 'select Count(*)';
  GlobalSelect          = 'select * from ';
  GlobalWhere           = ' where ';
  GlobalLike            = ' like ''';
  GlobalNull            = ' is Null ';
  GlobalOrder           = ' order by ';
  GlobalOccurs          = 'Ocorrenc.txt';
// Select SQL for the aux tables from this module
  SqlEventos    = 'select * from EVENTOS            order by DSC_EVT';
  SqlInscricoes = 'select COD_INS, RAZ_SOC from INSCRICOES order by RAZ_SOC';
  SqlTAreasAct  = 'select * from TIPO_AREAS_ATUACAO order by DSC_TARA';
  SqlTipoEventos= 'select * from TIPO_EVENTOS       order by DSC_TEVT';
  SqlSegmentos  = 'select * from SEGMENTOS          order by DSC_SEG';
  SqlPrcSegs    = 'select * from PRECO_SEGMENTOS        ' + #13 +
                  ' where FK_EMPRESAS     = :Empresa    ' + #13 +
                  '   and FK_TIPO_EVENTOS = :TipoEvento ' + #13 +
                  '   and FK_EVENTOS      = :Evento     ' + #13 +
                  '   and FK_SEGMENTOS    = :Segmento   ';
  SqlVincEvtArea= 'select * from TIPO_EVENTOS_AREA_VINC            ' + #13 +
                  ' where FK_TIPO_EVENTOS       = :TipoEvento and  ' + #13 +
                  '       FK_TIPO_AREAS_ATUACAO = :TipoAreaAtuacao ';
  SqlVincInsSegs= 'select * from VINCULOS_SEG_INS       ' + #13 +
                  ' where FK_INSCRICOES   = :Inscricao  ' + #13 +
                  '   and FK_SEGMENTOS    = :Segmento   ';
  SqlAllEvents  = 'select Tev.DSC_TEVT, Evt.PK_EVENTOS, Tev.PK_TIPO_EVENTOS, ' + #13 +
                  '       Evt.VLR_MT2, Tev.MTRG_PROM, Tev.QTD_BONUS          ' + #13 +
                  '  from EVENTOS Evt, TIPO_EVENTOS Tev  ' + #13 +
                  ' where Tev.PK_TIPO_EVENTOS = Evt.FK_TIPO_EVENTOS ';
  SqlTiposStatus= 'select * from TIPO_STATUS ' + #13 +
                  ' order by DSC_STT         ';
  SqlUnidades   = 'select * from UNIDADES   order by DSC_UNI';
  SqlTipoServicos = 'select * from TIPO_SERVICOS order by DSC_TSRV';
  SqlServicos   = 'select * from SERVICOS                 ' + #13 +
                  ' where FK_EMPRESAS      = :Empresa     ' + #13 +
                  '   and FK_CONTRATOS     = :Contrato    ' + #13 +
                  '   and FK_CADASTROS     = :Cadastro    ' + #13 +
                  '   and FK_TIPO_SERVICOS = :TipoServico ';
// Empty Sql for the tables that receive maintenance
  SqlEmptyInscr = 'select * from INSCRICOES where COD_INS is null';
  SqlEmptyEvent = 'select * from EVENTOS    where COD_EVT is null';
  SqlEmptyCateg = 'select * from CATEGORIAS where COD_CAT is null';
  SqlEmptyCtIns = 'select * from CATEGORIAS_INS where COD_EMP is null';
  SqlEvento     = 'select * from EVENTOS         ' + #13 +
                  ' where COD_EMP = :Empresa and ' + #13 +
                  '       COD_EVT = :Evento      ' + #13 +
                  ' order by DSC_EVT';
// Select SQL for the aux tables from other modules
  SqlPaises     = 'select * from PAISES     order by DSC_PAIS';
  SqlEstados    = 'select * from ESTADOS    ' + #13 +
                  ' where FK_PAISES = :Pais ' + #13 +
                  ' order by DSC_UF';
  SqlMunicipio  = 'select * from MUNICIPIOS    ' + #13 +
                  ' where FK_PAISES  = :Pais   ' + #13 +
                  '   and FK_ESTADOS = :Estado ' + #13 +
                  ' order by DSC_MUN';
  SqlBairro     = 'select * from BAIRROS          ' + #13 +
                  ' where FK_PAISES     = :Pais   ' + #13 +
                  '       FK_ESTADOS    = :Estado ' + #13 +
                  '       FK_MUNICIPIOS = :City   ' + #13 +
                  ' order by DSC_BAI';
  SqlTipoEnd    = 'select * from TIPO_ENDERECO order by DSC_TPE';
  SqlCadastros  = 'select * from VW_CLIENTES order by RAZ_SOC';
// Select SQL for the tables that be used for others functions
  SqlCepMuni    = 'select * from MUNICIPIOS where CEP_MUN = :CepMun';
  SqlCepBair    = 'select * from BAIRROS    where CEP_BAI = :CepBai';
  SqlCepLoca    = 'select * from LOCAL      where CEP_LOC = :CepLoc';
  SqlCategorias = 'select * from CATEGORIAS where FLAG_CAT = 0 order by DSC_CAT';
//  SqlCategorias = 'select * from CATEGORIAS order by DSC_CAT';

implementation

end.
