/*==============================================================*/
/* Database name:  PROCESSA                                     */
/* DBMS name:      InterBase 6.x                                */
/* Created on:     20/04/2006 11:03:58                          */
/*==============================================================*/



set term ^;

create procedure STP_DELETE_ORDER_PREVISION (
  P_FK_EMPRESAS        integer,
  P_FK_TIPO_PEDIDOS    smallint,
  P_PK_PEDIDOS         integer,
  P_FK_TIPO_PAGAMENTOS smallint,
  P_LST_PRZ            varchar(50),
  P_DTA_LIQ            date,
  P_DTA_CANC           date
)
returns (
  R_STATUS smallint
)
as
  declare variable FkTipoPagamentos    integer;
  declare variable PkContasLancamentos integer;
  declare variable FkCadastros         integer;
  declare variable FkTipoContas        smallint;
  declare variable FkContas            smallint;
  declare variable FlagTDoc            smallint;
  declare variable LstPrz              varchar(50);
begin
  R_STATUS = -1;
  if ((P_FK_EMPRESAS     is null) or (P_FK_EMPRESAS     <= 0)  or
     ( P_FK_TIPO_PEDIDOS is null) or (P_FK_TIPO_PEDIDOS <= 0)  or
     ( P_PK_PEDIDOS      is null) or (P_PK_PEDIDOS      <= 0)) then
    exit;
  R_STATUS = 0;
  select FK_TIPO_PAGAMENTOS, LST_PRZ, FK_CADASTROS
    from PEDIDOS
   where FK_EMPRESAS     = :P_FK_EMPRESAS
     and FK_TIPO_PEDIDOS = :P_FK_TIPO_PEDIDOS
     and PK_PEDIDOS      = :P_PK_PEDIDOS
    into :FkTipoPagamentos, :LstPrz, :FkCadastros;
  if (((FkTipoPagamentos is not null)                            and
     (  P_FK_TIPO_PAGAMENTOS <> FkTipoPagamentos))               or
     (( LstPrz is not null)       and (P_LST_PRZ <> LstPrz))     or
     (( P_FK_TIPO_PAGAMENTOS > 0) and (P_DTA_LIQ is not null))   or
     (( P_FK_TIPO_PAGAMENTOS > 0) and (P_DTA_CANC is not null))) then
  begin
    /* select from table PARAMETROS default type account and account */
    select FK_TIPO_CONTAS, FK_CONTAS
      from PARAMETROS
     where FK_EMPRESAS = :P_FK_EMPRESAS
      into :FkTipoContas, :FkContas;
    /* find type of documento */
    select Tdc.FLAG_TDOC
      from TIPO_PEDIDOS Tpd, TIPO_DOCUMENTOS Tdc
     where Tpd.PK_TIPO_PEDIDOS    = :P_FK_TIPO_PEDIDOS
       and Tdc.PK_TIPO_DOCUMENTOS = Tpd.FK_TIPO_DOCUMENTOS
      into :FlagTDoc;
    if (FlagTDoc = 9) then exit;
    /* delete all records from CONTAS_LANCAMENTOS of old installments */
    for select FK_CONTAS_LANCAMENTOS from CONTAS_DOCUMENTOS
         where FK_EMPRESAS        = :P_FK_EMPRESAS
           and FK_DOCUMENTOS      = :P_PK_PEDIDOS
           and FK_TIPO_DOCUMENTOS = :P_FK_TIPO_PEDIDOS
           and FK_CADASTROS       = :FkCadastros
           and FLAG_TDOC          = :FlagTDoc
          into :PkContasLancamentos do
    begin
      delete from CONTAS_DOCUMENTOS
       where FK_EMPRESAS           = :P_FK_EMPRESAS
         and FK_DOCUMENTOS         = :P_PK_PEDIDOS
         and FK_TIPO_DOCUMENTOS    = :P_FK_TIPO_PEDIDOS
         and FK_CADASTROS          = :FkCadastros
         and FK_CONTAS_LANCAMENTOS = :PkContasLancamentos;
      delete from CONTAS_LANCAMENTOS
       where FK_EMPRESAS           = :P_FK_EMPRESAS
         and FK_EMPRESAS__CTA      = :P_FK_EMPRESAS
         and FK_TIPO_CONTAS        = :FkTipoContas
         and FK_CONTAS             = :FkContas
         and PK_CONTAS_LANCAMENTOS = :PkContasLancamentos;
    end
    /* delete all records from VINCULOS_DOCUMENTOS that delete automaticaly
       all records of the tables CONTAS_DOCUMENTOS and CLASSIFICACAO_LANCAMENTOS */
    delete from VINCULO_DOCUMENTOS
     where FK_EMPRESAS        = :P_FK_EMPRESAS
       and FK_DOCUMENTOS      = :P_PK_PEDIDOS
       and FK_CADASTROS       = :FkCadastros
       and FK_TIPO_DOCUMENTOS = :P_FK_TIPO_PEDIDOS;
  end
end ^

set term  ;^;

grant EXECUTE on procedure STP_DELETE_ORDER_PREVISION to PUBLIC;


set term ^;

create procedure STP_GET_KC_CLASSIFICACAO_DOC (
  P_FK_CLASSIFICACAO integer
)
returns (
  R_PK_CLASSIFICACAO_DOCUMENTOS integer
)
as
begin
  R_PK_CLASSIFICACAO_DOCUMENTOS = -1;
  if ((P_FK_CLASSIFICACAO is not null) and (P_FK_CLASSIFICACAO > 0)) then 
  begin
    select KC_CLASSIFICACAO_DOCUMENTOS 
      from CLASSIFICACAO
     where PK_CLASSIFICACAO = :P_FK_CLASSIFICACAO
      into :R_PK_CLASSIFICACAO_DOCUMENTOS;
    if ((R_PK_CLASSIFICACAO_DOCUMENTOS is not null) and 
       ( R_PK_CLASSIFICACAO_DOCUMENTOS >= 0)) then
    begin
      R_PK_CLASSIFICACAO_DOCUMENTOS = R_PK_CLASSIFICACAO_DOCUMENTOS + 1;
      update CLASSIFICACAO set
             KC_CLASSIFICACAO_DOCUMENTOS = :R_PK_CLASSIFICACAO_DOCUMENTOS
       where PK_CLASSIFICACAO = :P_FK_CLASSIFICACAO;
    end
  end
  suspend;
end ^

set term ;^;

grant EXECUTE on procedure STP_GET_KC_CLASSIFICACAO_DOC to PUBLIC;


set term ^;

create procedure STP_GET_KC_CONTAS (
  P_FK_TIPO_CONTAS    integer
)
returns (
  R_PK_CONTAS smallint
)
as
begin
    R_PK_CONTAS = 0;
  if ((P_FK_TIPO_CONTAS is not null) and (P_FK_TIPO_CONTAS > 0)) then
  begin
    select KC_CONTAS 
      from TIPO_CONTAS
     where PK_TIPO_CONTAS = :P_FK_TIPO_CONTAS
      into :R_PK_CONTAS;
     if (R_PK_CONTAS is null) then exit;
    R_PK_CONTAS = R_PK_CONTAS + 1;
    update TIPO_CONTAS set
           KC_CONTAS      = :R_PK_CONTAS
     where PK_TIPO_CONTAS = :P_FK_TIPO_CONTAS;
  end
  suspend;
end ^

set term ;^;


set term ^;

create procedure STP_GET_KC_CONTAS_LANCAMENTOS (
  P_FK_EMPRESAS    integer
)
returns (
  R_PK_CONTAS_LANCAMENTOS smallint
)
as
begin
  if ((P_FK_EMPRESAS is not null) and (P_FK_EMPRESAS > 0)) then
  begin
    select KC_CONTAS_LANCAMENTOS 
      from MOD_BCCX_KEYS
     where FK_EMPRESAS    = :P_FK_EMPRESAS
      into :R_PK_CONTAS_LANCAMENTOS;
    if (R_PK_CONTAS_LANCAMENTOS is null) then
    begin
      R_PK_CONTAS_LANCAMENTOS = 0;
      insert into MOD_BCCX_KEYS 
        (FK_EMPRESAS, KC_CONTAS_LANCAMENTOS, KC_CONTAS_LANCAMENTOS_TRF)
      values
        (:P_FK_EMPRESAS, 0, 0);
    end
    R_PK_CONTAS_LANCAMENTOS = R_PK_CONTAS_LANCAMENTOS + 1;
    update MOD_BCCX_KEYS set
           KC_CONTAS_LANCAMENTOS = :R_PK_CONTAS_LANCAMENTOS
     where FK_EMPRESAS    = :P_FK_EMPRESAS;
  end
  suspend;
end ^

set term ;^;

grant EXECUTE on procedure STP_GET_KC_CONTAS_LANCAMENTOS to PUBLIC;


set term ^;

create procedure STP_GET_KC_CONTAS_LANC_TRF (
  P_FK_EMPRESAS    integer
)
returns (
  R_PK_CONTAS_LANCAMENTOS_TRF smallint
)
as
begin
  if ((P_FK_EMPRESAS is not null) and (P_FK_EMPRESAS > 0)) then
  begin
    select KC_CONTAS_LANCAMENTOS_TRF
      from MOD_BCCX_KEYS
     where FK_EMPRESAS    = :P_FK_EMPRESAS
      into :R_PK_CONTAS_LANCAMENTOS_TRF;
    if (R_PK_CONTAS_LANCAMENTOS_TRF is null) then
    begin
      R_PK_CONTAS_LANCAMENTOS_TRF = 0;
      insert into MOD_BCCX_KEYS 
        (FK_EMPRESAS, KC_CONTAS_LANCAMENTOS, KC_CONTAS_LANCAMENTOS_TRF)
      values
        (:P_FK_EMPRESAS, 0, 0);
    end
    R_PK_CONTAS_LANCAMENTOS_TRF = R_PK_CONTAS_LANCAMENTOS_TRF + 1;
    update MOD_BCCX_KEYS set
           KC_CONTAS_LANCAMENTOS_TRF = :R_PK_CONTAS_LANCAMENTOS_TRF
     where FK_EMPRESAS    = :P_FK_EMPRESAS;
  end
  suspend;
end ^

set term ;^;


set term ^;

create procedure STP_GET_OWNER_DATA (
    P_PK_CADASTROS           integer,
    P_FLAG_CAT               smallint,
    P_FLAG_ATIVO             smallint
)
returns (
    PK_CADASTROS             integer,
    FLAG_TCAD                smallint,
    DOC_PRI                  varchar(14),
    DOC_SEQ                  varchar(30),
    RAZ_SOC                  varchar(50),
    NOM_FAN                  varchar(50),
    FK_PAISES                integer,
    FK_ESTADOS               char(02),
    FK_MUNICIPIOS            integer,
    DSC_PAIS                 varchar(50),
    FK_LINGUAGENS            varchar(05),
    DSC_UF                   varchar(30),
    DSC_MUN                  varchar(50),
    END_CAD                  varchar(50),
    NUM_END                  integer,
    CMP_END                  varchar(50),
    CEP_CAD                  integer,
    CXP_CAD                  varchar(10),
    FON_CAD                  varchar(20),
    OBS_CAD                  blob sub_type 1 segment size 80,
    IMG_CAD                  blob sub_type 0 segment size 80,
    FLAG_TIMG                smallint,
    FLAG_ETQ                 smallint,
    FLAG_ZUMBI               smallint,
    AREA_ATU                 varchar(50),
    FK_TIPO_PAGAMENTOS       smallint,
    FK_TIPO_DESCONTOS        smallint,
    FK_BANCOS                smallint,
    FK_VW_VENDEDORES         integer,
    FK_VW_REPRESENTANTES     integer,
    FK_VW_TRANSPORTADORAS    integer,
    FK_VW_AGENT              integer,
    FK_TIPO_ESTABELECIMENTOS smallint,
    FK_PORTOS__EMB           integer,
    FK_PORTOS__DST           integer,
    FK_TIPO_BLOQUEIOS        smallint,
    FK_FINALIZADORAS         smallint,
    FK_TIPO_PRAZO_ENTREGA    smallint,
    FK_TABELA_PRECOS         smallint,
    SIT_BLOCK_ANT            smallint,
    DSCT_AUT                 numeric(09, 02),
    DSCT_ATC                 numeric(09, 02),
    FLAG_CNSM                smallint,
    FLAG_PENP                smallint,
    FLAG_PABR                smallint,
    FLAG_DTABAS              smallint,
    LST_PRZ                  varchar(50),
    OPE_AUT                  varchar(10),
    OPE_LIB                  varchar(10),
    DIA_EMS                  smallint,
    LIM_CRD                  numeric(18, 02),
    COD_CTB                  integer,
    PK_CATEGORIAS            smallint,
    DSC_CAT                  varchar(30),
    CNPJ_ENTR                varchar(14),
    IE_ENTR                  varchar(30),
    FK_PAISES_ENT            integer,
    FK_ESTADOS_ENT           char(02),
    FK_MUNICIPIOS_ENT        integer,
    DSC_PAIS_ENT             varchar(50),
    DSC_UF_ENT               varchar(30),
    DSC_MUN_ENT              varchar(50),
    END_ENT                  varchar(50),
    NUM_ENT                  integer,
    CMP_ENT                  varchar(50),
    CEP_ENT                  integer,
    CXP_ENT                  varchar(10),
    FON_ENT                  varchar(20),
    FAX_ENT                  varchar(20),
    FK_PAISES_CBR            integer,
    FK_ESTADOS_CBR           char(02),
    FK_MUNICIPIOS_CBR        integer,
    DSC_PAIS_CBR             varchar(50),
    DSC_UF_CBR               varchar(30),
    DSC_MUN_CBR              varchar(50),
    END_CBR                  varchar(50),
    NUM_CBR                  integer,
    CMP_CBR                  varchar(50),
    CEP_CBR                  integer,
    CXP_CBR                  varchar(10),
    FON_CBR                  varchar(20),
    FAX_CBR                  varchar(20),
    NOM_VND                  varchar(50),
    FLAG_TRN                 smallint,
    DSC_BNC                  varchar(30),
    NOM_REP                  varchar(50),
    NOM_AGENT                varchar(50),
    NOM_TRNSP                varchar(50),
    NOM_TEST                 varchar(50),
    DSC_PORTO_DST            varchar(50),
    DSC_PORTO_EMB            varchar(50),
    DSC_TBL                  varchar(30),
    FLAG_BLQ                 smallint, 
    FLAG_VAVS                smallint, 
    FLAG_MPGT                smallint, 
    FLAG_DTABAS_BLOCK        smallint,
    FLAG_CONDP               smallint, 
    FLAG_LIMCR               smallint,
    DSC_MPGT                 varchar(30),
    COD_TECLA                smallint,
    FLAG_TRC                 smallint,
    FLAG_CLI                 smallint,
    FLAG_BNC                 smallint,
    FLAG_TEF                 smallint,
    FLAG_TFIN                smallint,
    DSC_PRZE                 varchar(30),
    DSC_TAB                  varchar(30)
)
as
begin
  /* Procedure Text */
  if (P_PK_CADASTROS is null) then P_PK_CADASTROS = 0;
  if (P_FLAG_CAT     is null) then P_FLAG_CAT     = -1;
  if (P_FLAG_ATIVO   is null) then P_FLAG_ATIVO   = -1;
  for select Cad.PK_CADASTROS, Cad.FLAG_TCAD, Cad.DOC_PRI, Cad.DOC_SEQ, 
             Cad.RAZ_SOC, Cad.FK_PAISES, Cad.FK_ESTADOS, Cad.FK_MUNICIPIOS, 
             Cad.END_CAD, Cad.NUM_END, Cad.CMP_END, Cad.CEP_CAD, 
             Cad.CXP_CAD, Cad.FLAG_ETQ, Cad.FLAG_ZUMBI, Cad.AREA_ATU, 
             Cli.FK_TIPO_PAGAMENTOS, Cli.FK_TIPO_DESCONTOS,  Cli.FK_BANCOS, 
             Cli.FK_VW_VENDEDORES, Cli.FK_VW_REPRESENTANTES, 
             Cli.FK_VW_CADASTROS, Cli.FK_VW_TRANSPORTADORAS, Cli.DSCT_AUT,
             Cli.FK_TIPO_ESTABELECIMENTOS, Cli.FK_PORTOS__EMB, Cat.DSC_CAT,  
             Cli.FK_PORTOS__DST, Cli.FK_TIPO_BLOQUEIOS, Cli.FK_FINALIZADORAS, 
             Cli.FK_TIPO_PRAZO_ENTREGA, Cli.FK_TABELA_PRECOS, Cli.DSCT_ATC, 
             Cli.FLAG_CNSM, Cli.FLAG_PENP, Cli.FLAG_PABR, Cli.FLAG_DTABAS, 
             Cli.LST_PRZ, Cli.OPE_AUT, Cli.OPE_LIB, Cli.DIA_EMS, 
             Cli.LIM_CRD, Cli.COD_CTB, Cat.PK_CATEGORIAS, Cli.SIT_BLOCK_ANT,
             Tal.DSC_ALIAS
        from VINCULOS_CAD_CAT Vcc
        join CADASTROS Cad
          on Cad.PK_CADASTROS    = Vcc.FK_CADASTROS
        join CATEGORIAS Cat
          on Cat.PK_CATEGORIAS   = Vcc.FK_CATEGORIAS
         and ((Cat.FLAG_CAT      = :P_FLAG_CAT) 
          or ( -1                = :P_FLAG_CAT))
        left outer join CLIENTES Cli
          on Cli.FK_CADASTROS    = Cad.PK_CADASTROS
        left outer join TIPO_ALIAS Tal
          on Tal.PK_TIPO_ALIAS   = Cad.FK_TIPO_ALIAS
       where ((Vcc.FK_CADASTROS  = :P_PK_CADASTROS)
          or (0                  = :P_PK_CADASTROS))
         and ((Vcc.FLAG_ATV      = :P_FLAG_ATIVO)
          or ( -1                = :P_FLAG_ATIVO))
         and Vcc.FK_CATEGORIAS   = Cat.PK_CATEGORIAS
       order by Cat.PK_CATEGORIAS, Cad.RAZ_SOC
        into :PK_CADASTROS, :FLAG_TCAD, :DOC_PRI, :DOC_SEQ, :RAZ_SOC, 
             :FK_PAISES, :FK_ESTADOS, :FK_MUNICIPIOS, :END_CAD, :NUM_END,
             :CMP_END, :CEP_CAD, :CXP_CAD, :FLAG_ETQ,
             :FLAG_ZUMBI, :AREA_ATU, :FK_TIPO_PAGAMENTOS,
             :FK_TIPO_DESCONTOS, :FK_BANCOS, :FK_VW_VENDEDORES,
             :FK_VW_REPRESENTANTES, :FK_VW_AGENT, :FK_VW_TRANSPORTADORAS,
             :DSCT_AUT, :FK_TIPO_ESTABELECIMENTOS, :FK_PORTOS__EMB,
             :FK_PORTOS__DST, :FK_TIPO_BLOQUEIOS, :FK_FINALIZADORAS, 
             :FK_TIPO_PRAZO_ENTREGA, :FK_TABELA_PRECOS, :DSCT_ATC, 
             :FLAG_CNSM, :FLAG_PENP, :FLAG_PABR, :FLAG_DTABAS,
             :LST_PRZ, :OPE_AUT, :OPE_LIB, :DIA_EMS, :LIM_CRD,
             :COD_CTB, :PK_CATEGORIAS, :SIT_BLOCK_ANT, :DSC_CAT, :NOM_FAN do
  begin
  /* search for Observation */
    select OBS_CAD from CADASTROS_OBSERVACOES 
     where FK_CADASTROS = :PK_CADASTROS
      into :OBS_CAD;
  /* search for Image */
    select IMG_CAD, FLAG_TIMG from CADASTROS_IMAGENS 
     where FK_CADASTROS = :PK_CADASTROS
      into :IMG_CAD, :FLAG_TIMG;
  /* search for default contact */
    select DSC_CNT from CADASTROS_CONTATOS
     where FK_CADASTROS = :PK_CADASTROS
       and FLAG_DEF     = 1
      into :FON_CAD;
  /* search for local descritpion */
    select Pais.DSC_PAIS, Pais.FK_LINGUAGENS, Est.DSC_UF, Mun.DSC_MUN
      from PAISES Pais, ESTADOS Est, MUNICIPIOS Mun
     where Pais.PK_PAISES    = :FK_PAISES
       and Est.FK_PAISES     = :FK_PAISES
       and Est.PK_ESTADOS    = :FK_ESTADOS
       and Mun.FK_PAISES     = :FK_PAISES
       and Mun.FK_ESTADOS    = :FK_ESTADOS
       and Mun.PK_MUNICIPIOS = :FK_MUNICIPIOS
      into :DSC_PAIS, :FK_LINGUAGENS, :DSC_UF, :DSC_MUN;
  /* search for local descritpion of delivery address */
    select Ent.FK_PAISES, Ent.FK_ESTADOS, Ent.FK_MUNICIPIOS, Ent.CNPJ_ENTR,
           Ent.IE_ENTR, Ent.END_ENT, Ent.NUM_ENT, Ent.CMP_ENT, Ent.CEP_ENT,
           Ent.CXP_ENT, Ent.FON_ENT, Ent.FAX_ENT, Pais.DSC_PAIS, Est.DSC_UF,
           Mun.DSC_MUN
      from ENTREGAS Ent, PAISES Pais, ESTADOS Est, MUNICIPIOS Mun
     where Ent.FK_CLIENTES   = :PK_CADASTROS
       and Pais.PK_PAISES    = Ent.FK_PAISES
       and Est.FK_PAISES     = Ent.FK_PAISES
       and Est.PK_ESTADOS    = Ent.FK_ESTADOS
       and Mun.FK_PAISES     = Ent.FK_PAISES
       and Mun.FK_ESTADOS    = Ent.FK_ESTADOS
       and Mun.PK_MUNICIPIOS = Ent.FK_MUNICIPIOS
      into :FK_PAISES_ENT, :FK_ESTADOS_ENT, :FK_MUNICIPIOS_ENT, :CNPJ_ENTR,
           :IE_ENTR, :END_ENT, :NUM_ENT, :CMP_ENT, :CEP_ENT, :CXP_ENT,
           :FON_ENT, FAX_ENT, :DSC_PAIS_ENT, :DSC_UF_ENT, :DSC_MUN_ENT;
  /* search for local descritpion of collection address */
    select Cbr.FK_PAISES, Cbr.FK_ESTADOS, Cbr.FK_MUNICIPIOS, Cbr.END_CBR,
           Cbr.NUM_CBR, Cbr.CMP_CBR, Cbr.CEP_CBR, Cbr.CXP_CBR, Cbr.FON_CBR,
           Cbr.FAX_CBR, Pais.DSC_PAIS, Est.DSC_UF,
           Mun.DSC_MUN
      from COBRANCAS Cbr, PAISES Pais, ESTADOS Est, MUNICIPIOS Mun
     where Cbr.FK_CLIENTES   = :PK_CADASTROS
       and Pais.PK_PAISES    = Cbr.FK_PAISES
       and Est.FK_PAISES     = Cbr.FK_PAISES
       and Est.PK_ESTADOS    = Cbr.FK_ESTADOS
       and Mun.FK_PAISES     = Cbr.FK_PAISES
       and Mun.FK_ESTADOS    = Cbr.FK_ESTADOS
       and Mun.PK_MUNICIPIOS = Cbr.FK_MUNICIPIOS
      into :FK_PAISES_CBR, :FK_ESTADOS_CBR, :FK_MUNICIPIOS_CBR, :END_CBR,
           :NUM_CBR, :CMP_CBR, :CEP_CBR, :CXP_CBR, :FON_CBR, :FAX_CBR,
           :DSC_PAIS_CBR, :DSC_UF_CBR, :DSC_MUN_CBR;
  /* search for id descritpion of supplier */
    select FLAG_TRN from FORNECEDORES
       where FK_CADASTROS = :PK_CADASTROS
        into :FLAG_TRN;
  /* search for name of vendor */
    if ((FK_VW_VENDEDORES is not null) or
       ( FK_VW_VENDEDORES > 0))        then
      select RAZ_SOC from CADASTROS
       where PK_CADASTROS = :FK_VW_VENDEDORES
        into :NOM_VND;
  /* search for name of representant */
    if ((FK_VW_REPRESENTANTES is not null) or
       ( FK_VW_REPRESENTANTES > 0))        then
      select RAZ_SOC from CADASTROS
       where PK_CADASTROS = :FK_VW_VENDEDORES
        into :NOM_REP;
  /* search for name of Bank */
    if ((FK_BANCOS is not null) or
       ( FK_BANCOS > 0))        then
      select DSC_BCO from BANCOS
       where PK_BANCOS = :FK_BANCOS
        into :DSC_BNC; 
  /* search for name of agent */
    if ((FK_VW_AGENT is not null) or
       ( FK_VW_AGENT > 0))        then
      select RAZ_SOC from CADASTROS
       where PK_CADASTROS = :FK_VW_AGENT
        into :NOM_AGENT;
  /* search for name of transporter */
    if ((FK_VW_TRANSPORTADORAS is not null) or
       ( FK_VW_TRANSPORTADORAS > 0))        then
      select RAZ_SOC from CADASTROS
       where PK_CADASTROS = :FK_VW_TRANSPORTADORAS
        into :NOM_TRNSP;
  /* search for name of store type */
    if ((FK_TIPO_ESTABELECIMENTOS is not null) or
       ( FK_TIPO_ESTABELECIMENTOS > 0))        then
      select DSC_TEST from TIPO_ESTABELECIMENTOS
       where PK_TIPO_ESTABELECIMENTOS = :FK_TIPO_ESTABELECIMENTOS
        into :NOM_TEST;
  /* search for name of port */
    if ((FK_PORTOS__DST is not null) or
       ( FK_PORTOS__DST > 0))        then
      select DSC_PORTO from PORTOS
       where PK_PORTOS = :FK_PORTOS__DST
        into :DSC_PORTO_DST;
  /* search for name of port */
    if ((FK_PORTOS__EMB is not null) or
       ( FK_PORTOS__EMB > 0))        then
      select DSC_PORTO from PORTOS
       where PK_PORTOS = :FK_PORTOS__EMB
        into :DSC_PORTO_EMB;
  /* search for data of block type */
    if ((FK_TIPO_BLOQUEIOS is not null) or
       ( FK_TIPO_BLOQUEIOS > 0))        then
      select DSC_TBL, FLAG_BLQ, FLAG_VAVS, FLAG_MPGT, FLAG_DTABAS,
             FLAG_CONDP, FLAG_LIMCR
        from TIPO_BLOQUEIOS
       where PK_TIPO_BLOQUEIOS = :FK_TIPO_BLOQUEIOS
        into :DSC_TBL, :FLAG_BLQ, :FLAG_VAVS, :FLAG_MPGT,
             :FLAG_DTABAS_BLOCK, :FLAG_CONDP, :FLAG_LIMCR;
  /* search for name of payment method */
    if ((FK_FINALIZADORAS is not null) or
       ( FK_FINALIZADORAS > 0))        then
      select DSC_MPGT, COD_TECLA, FLAG_TRC, FLAG_CLI,
             FLAG_BNC, FLAG_TEF, FLAG_TFIN
        from FINALIZADORAS
       where PK_FINALIZADORAS = :FK_FINALIZADORAS
        into :DSC_MPGT, :COD_TECLA, :FLAG_TRC, :FLAG_CLI,
             :FLAG_BNC, :FLAG_TEF, :FLAG_TFIN;
  /* search for name of delivery period */
    if ((FK_TIPO_PRAZO_ENTREGA is not null) or
       ( FK_TIPO_PRAZO_ENTREGA > 0))        then
      select DSC_PRZE from TIPO_PRAZO_ENTREGA
       where PK_TIPO_PRAZO_ENTREGA = :FK_TIPO_PRAZO_ENTREGA
        into :DSC_PRZE;
  /* search for name of price table */
    if ((FK_TABELA_PRECOS is not null) or
       ( FK_TABELA_PRECOS > 0))        then
      select DSC_TAB from TABELA_PRECOS
       where PK_TABELA_PRECOS = :FK_TABELA_PRECOS
        into :DSC_TAB;
    suspend;
  end
end ^

set term ;^;

grant EXECUTE on procedure STP_GET_OWNER_DATA to PUBLIC;


set term ^;

create procedure STP_INSERT_PREVISION_FROM_ORDER (
  P_FK_EMPRESAS     integer,
  P_FK_TIPO_PEDIDOS smallint,
  P_PK_PEDIDOS      integer,
  P_DTA_LAN         date,
  P_VLR_LAN         numeric (11, 4),
  P_NUM_PARC        smallint,
  P_TOT_PARC        smallint,
  P_QTD_PARC        smallint
)
returns (
  R_STATUS smallint
)
as
  declare variable FkTipoContas        smallint;
  declare variable FkContas            smallint;
  declare variable FkCadastros         integer;
  declare variable FkClassificacao     integer;
  declare variable FlagTDoc            smallint;
  declare variable DscOrdm             varchar(50);
  declare variable DtaLan              date;
  declare variable DtaLib              date;
  declare variable PkContasLancamentos integer;
  declare variable PkTipoDocumentos    smallint;
  declare variable TypeLan             smallint;
  declare variable FlagES              smallint;
  declare variable DscLan              varchar(50);
begin
  R_STATUS = -1;
  TypeLan  = 0;
  if ((P_FK_EMPRESAS     is not null) and (P_FK_EMPRESAS     > 0)  and
     ( P_FK_TIPO_PEDIDOS is not null) and (P_FK_TIPO_PEDIDOS > 0)  and
     ( P_DTA_LAN         is not null) and
     ( P_VLR_LAN         is not null) and (P_VLR_LAN         > 0)  and
     ( P_PK_PEDIDOS      is not null) and (P_PK_PEDIDOS      > 0)) then
  begin
    select Tdc.PK_TIPO_DOCUMENTOS, Tdc.FLAG_TDOC, Grm.FLAG_ES
      from TIPO_PEDIDOS Tpd, TIPO_DOCUMENTOS Tdc,
           GRUPOS_MOVIMENTOS Grm, TIPO_MOVIMENTOS Tmv
     where Tpd.PK_TIPO_PEDIDOS      = :P_FK_TIPO_PEDIDOS
       and Tdc.PK_TIPO_DOCUMENTOS   = Tpd.FK_TIPO_DOCUMENTOS
       and Grm.PK_GRUPOS_MOVIMENTOS = Tpd.FK_GRUPOS_MOVIMENTOS
      into :PkTipoDocumentos, :FlagTDoc, :FlagES;
    select FK_TIPO_CONTAS, FK_CONTAS
      from PARAMETROS
     where FK_EMPRESAS = :P_FK_EMPRESAS
      into :FkTipoContas, :FkContas;
    if ((FkTipoContas is null) or (FkTipoContas = 0)  or
       ( FkContas     is null) or (FkContas     = 0)) then
    begin
      R_STATUS = -10; /* prevision acount not found */
      exit;
    end
    select Cast(Grm.DSC_GMOV || ' - ' || Tpd.DSC_TPED as VARCHAR(50)),
           Ped.FK_CADASTROS
      from PEDIDOS Ped, TIPO_PEDIDOS Tpd, GRUPOS_MOVIMENTOS Grm
     where Ped.FK_EMPRESAS          = :P_FK_EMPRESAS
       and Ped.FK_TIPO_PEDIDOS      = :P_FK_TIPO_PEDIDOS
       and Ped.PK_PEDIDOS           = :P_PK_PEDIDOS
       and Tpd.PK_TIPO_PEDIDOS      = Ped.FK_TIPO_PEDIDOS
       and Grm.PK_GRUPOS_MOVIMENTOS = Ped.FK_GRUPOS_MOVIMENTOS
      into :DscLan, :FkCadastros;
    if ((FkCadastros is null) or (FkCadastros = 0)  or
       ( DscLan      is null)) then
    begin
      R_STATUS = -15; /* Owner of document not found or description can't to be build */
      exit;
    end
    DscOrdm = Cast(DscLan as varchar(33));
    select R_PK_CONTAS_LANCAMENTOS from STP_GET_KC_CONTAS_LANCAMENTOS (:P_FK_EMPRESAS)
      into PkContasLancamentos;
    if ((PkContasLancamentos is null) or (PkContasLancamentos = 0)) then
    begin
      R_STATUS = -20; /* Don't get the primary key of table CONTAS_LANCAMENTOS */
      exit;
    end
    DscOrdm = DscOrdm || ' Parcela: ' || Cast(P_NUM_PARC as varchar(3)) || '/' ||
            Cast(P_TOT_PARC as varchar(3));
    insert into CONTAS_LANCAMENTOS
      (FK_EMPRESAS, PK_CONTAS_LANCAMENTOS, FK_EMPRESAS__CTA, FK_TIPO_CONTAS, 
       FK_CONTAS, FK_FINALIZADORAS, FK_OPERACOES_FINANCEIRAS, FK_CADASTROS,
       FK_HITORICOS_PADRAO, DSC_LAN, DTA_LAN, VLR_LAN, FLAG_DBCR)
    values
      (:P_FK_EMPRESAS, :PkContasLancamentos, :P_FK_EMPRESAS, :FkTipoContas, 
       :FkContas, null, null, :FkCadastros, null, :DscOrdm, :P_DTA_LAN, 
       :P_VLR_LAN, :FlagES);
/* insert or update data to generic document table */
    if (FlagTDoc is null) then exit;
    TypeLan = null;
    select FLAG_TDOC
      from VINCULO_DOCUMENTOS
     where FK_EMPRESAS        = :P_FK_EMPRESAS
       and FK_DOCUMENTOS      = :P_PK_PEDIDOS
       and FK_CADASTROS       = :FkCadastros
       and FK_TIPO_DOCUMENTOS = :P_FK_TIPO_PEDIDOS
      into :TypeLan;
    if (TypeLan is null) then
    begin
      TypeLan = 0;
      insert into VINCULO_DOCUMENTOS
        (FK_EMPRESAS, FK_DOCUMENTOS, FK_CADASTROS, FK_TIPO_DOCUMENTOS, FLAG_TDOC)
      values
        (:P_FK_EMPRESAS, :P_PK_PEDIDOS, :FkCadastros,
         :P_PK_PEDIDOS, :FlagTDoc);
    end
/* insert a link between generic document and flow cash */
    insert into CONTAS_DOCUMENTOS
      (FK_EMPRESAS, FK_CONTAS_LANCAMENTOS,
       FK_DOCUMENTOS, FK_TIPO_DOCUMENTOS, FK_CADASTROS, FLAG_TDOC)
    values
      (:P_FK_EMPRESAS, :PkContasLancamentos, :P_PK_PEDIDOS, 
      :P_FK_TIPO_PEDIDOS, :FkCadastros, :FlagTDoc);
/* insert links between generic document and finance classification */
    if (FlagTDoc is null) then exit;
    TypeLan = null;
    select FLAG_TDOC
      from VINCULO_DOCUMENTOS
     where FK_EMPRESAS        = :P_FK_EMPRESAS
       and FK_DOCUMENTOS      = :P_PK_PEDIDOS
       and FK_CADASTROS       = :FkCadastros
       and FK_TIPO_DOCUMENTOS = :P_FK_TIPO_PEDIDOS
      into :TypeLan;
    if (TypeLan is null) then
    begin
      TypeLan = 0;
      insert into VINCULO_DOCUMENTOS
        (FK_EMPRESAS, FK_DOCUMENTOS, FK_CADASTROS, FK_TIPO_DOCUMENTOS, FLAG_TDOC)
      values
        (:P_FK_EMPRESAS, :P_PK_PEDIDOS, :FkCadastros,
         :P_PK_PEDIDOS, :FlagTDoc);
    end
/* insert a link between generic document and flow cash */
    insert into CONTAS_DOCUMENTOS
      (FK_EMPRESAS, FK_CONTAS_LANCAMENTOS,  FK_DOCUMENTOS, 
       FK_TIPO_DOCUMENTOS, FK_CADASTROS, FLAG_TDOC)
    values
      (:P_FK_EMPRESAS, :PkContasLancamentos, :P_PK_PEDIDOS, 
       :P_FK_TIPO_PEDIDOS, :FkCadastros, :FlagTDoc);
/* insert links between generic document and finance classification */
    for select Pim.FK_CLASSIFICACAO, Ped.DTA_PED, Ped.DTA_LIB,
               Sum(Pim.TOT_ITEM)
          from PEDIDOS Ped, PEDIDOS_ITENS Pim
         where Ped.FK_EMPRESAS     = :P_FK_EMPRESAS
           and Ped.FK_TIPO_PEDIDOS = :P_FK_TIPO_PEDIDOS
           and Ped.PK_PEDIDOS      = :P_PK_PEDIDOS
           and Pim.FK_EMPRESAS     = Ped.FK_EMPRESAS
           and Pim.FK_TIPO_PEDIDOS = Ped.FK_TIPO_PEDIDOS
           and Pim.FK_PEDIDOS      = Ped.PK_PEDIDOS
           and Pim.DTA_FAT is null
         group by Pim.FK_CLASSIFICACAO, Ped.DTA_PED, Ped.DTA_LIB
          into :FkClassificacao, :P_VLR_LAN, :DtaLan, :DtaLib do
    begin
      if ((DtaLib is null) or (DtaLib = 0)) then
        TypeLan = 0;
      else
        TypeLan = 1;
      if ((P_QTD_PARC < 0) and (TypeLan > 0)) then
      begin
        R_STATUS = -25; /* Don't get to determine data for insert classification */
        exit;
      end
      if ((FkClassificacao is not null) and (FkClassificacao > 0)) then
      begin
        if (P_QTD_PARC > 0) then
          P_VLR_LAN  = P_VLR_LAN / P_QTD_PARC;
        else
          P_DTA_LAN = DtaLan;
        if (P_QTD_PARC > 0) then
          DscLan = DscOrdm;
        insert into CLASSIFICACAO_DOCUMENTOS
          (FK_EMPRESAS, FK_CLASSIFICACAO, FK_DOCUMENTOS, FK_TIPO_DOCUMENTOS,
           FK_CADASTROS, FLAG_TDOC, FLAG_PREV, DTA_LAN, VLR_LAN, DSC_LAN,
           PK_CLASSIFICACAO_DOCUMENTOS, FLAG_DBCR)
        values
          (:P_FK_EMPRESAS, :FkClassificacao, :P_PK_PEDIDOS,
           :P_FK_TIPO_PEDIDOS, :FkCadastros, :FlagTDoc, 1, :P_DTA_LAN,
           :P_VLR_LAN, :DscLan, 0, :FlagES);
        if ((P_QTD_PARC <= 0) and (TypeLan = 0)) then
        begin
          update PEDIDOS set
                 DTA_LIB = current_date
           where FK_EMPRESAS     = :P_FK_EMPRESAS
             and FK_TIPO_PEDIDOS = :P_FK_TIPO_PEDIDOS
             and PK_PEDIDOS      = :P_PK_PEDIDOS;
        end
      end
    end
    R_STATUS = 0;
  end
  suspend;
end ^

set term ;^;

grant EXECUTE on procedure STP_INSERT_PREVISION_FROM_ORDER to PUBLIC;


set term ^;

create procedure STP_SET_STATUS_TO_ORDER (
  P_FK_EMPRESAS       integer,
  P_FK_TIPO_PEDIDOS   smallint,
  P_PK_PEDIDOS        integer
)
returns (
  R_STATUS smallint
)
as
  declare variable QtdItems            integer;
  declare variable QtdRows             integer;
  declare variable QtdParc             integer;
  declare variable FkCadastros         integer;
  declare variable FkTipoStatusPedidos smallint;
  declare variable FkTipoPagamentos    smallint;
  declare variable FkGruposMovimentos  smallint;
  declare variable FlagEstq            smallint;
  declare variable FlagGFin            smallint;
  declare variable FlagOpen            smallint;
  declare variable FlagRecb            smallint;
  declare variable FlagLib             smallint;
  declare variable FlagCanc            smallint;
  declare variable FlagProd            smallint;
  declare variable FlagProdPed         smallint;
  declare variable FlagFat             smallint;
  declare variable FlagLiq             smallint;
  declare variable FlagInstallments    smallint;
  declare variable DiaPrevEntr         smallint;
  declare variable MesPrevEntr         smallint;
  declare variable AnoPrevEntr         smallint;
  declare variable NumParc             smallint;
  declare variable DscHist             varchar(50);
  declare variable LstPrz              varchar(50);
  declare variable StrDate             varchar(20);
  declare variable DtaPed              date;
  declare variable DtaLiq              date;
  declare variable DtaRecb             date;
  declare variable DtaCanc             date;
  declare variable DtaFat              date;
  declare variable DtaLib              date;
  declare variable DtaLan              date;
  declare variable DtaPrevEntr         date;
  declare variable TotPed              numeric(18, 4);
  declare variable VlrLan              numeric(18, 4);
begin
  R_STATUS = -1;
  if ((P_FK_EMPRESAS     is null) or (P_FK_EMPRESAS     <= 0) or
     ( P_FK_TIPO_PEDIDOS is null) or (P_FK_TIPO_PEDIDOS <= 0) or
     ( P_PK_PEDIDOS      is null) or (P_PK_PEDIDOS      <= 0)) then
  begin
    suspend;
    exit;
  end
  select Tst.FLAG_OPEN, Tst.FLAG_RECB, Tst.FLAG_LIB, Tst.FLAG_CANC,
         Tst.FLAG_PROD, Tst.FLAG_FAT, Tst.FLAG_LIQ, Grm.FLAG_ESTQ,
         Ped.FK_TIPO_STATUS_PEDIDOS, Ped.DTA_PED, Ped.DTA_LIQ,
         Ped.DTA_RECB, Ped.FLAG_PROD, Ped.DTA_CANC, Ped.DTA_FAT,
         Ped.DTA_LIB, Grm.FLAG_GFIN, Ped.DTA_ENTR, Ped.MES_PREV_ENTR,
         Ped.ANO_PREV_ENTR, Ped.FK_TIPO_PAGAMENTOS, Ped.FK_CADASTROS,
         Ped.LST_PRZ, Ped.TOT_PED, Ped.QTD_DUPL
    from PEDIDOS Ped, TIPO_STATUS_PEDIDOS Tst, GRUPOS_MOVIMENTOS Grm
   where Ped.FK_EMPRESAS            = :P_FK_EMPRESAS
     and Ped.FK_TIPO_PEDIDOS        = :P_FK_TIPO_PEDIDOS
     and Ped.PK_PEDIDOS             = :P_PK_PEDIDOS
     and Tst.PK_TIPO_STATUS_PEDIDOS = Ped.FK_TIPO_STATUS_PEDIDOS
     and Grm.PK_GRUPOS_MOVIMENTOS   = Tst.FK_GRUPOS_MOVIMENTOS
    into :FlagOpen, :FlagRecb, :FlagLib, :FlagCanc, :FlagProd,
         :FlagFat, :FlagLiq, :FlagEstq, :FkTipoStatusPedidos,
         :DtaPed, DtaLiq, :DtaRecb, :FlagProdPed, :DtaCanc, :DtaFat,
         :DtaLib, :FlagGFin, :DtaPrevEntr, :MesPrevEntr,
         :AnoPrevEntr, :FkTipoPagamentos, :FkCadastros,
         :LstPrz, :TotPed, :QtdParc;
  if ((DtaLiq  is not null) or (DtaLiq  > 0)  or
     ( DtaCanc is not null) or (DtaCanc > 0)  or
     ( FkCadastros is null)) then
  begin
    suspend;
    exit;
  end
  if (FlagEstq is null) then
    FlagEstq = 0;
  if ((FlagOpen = 1) and (DtaPed is null)) then
  begin
    DtaPed  = current_date;
    DscHist = 'Abertura do Pedido';
    insert into PEDIDOS_HISTORICOS
      (FK_EMPRESAS, FK_TIPO_PEDIDOS, FK_PEDIDOS, PK_PEDIDOS_HISTORICOS,
       FK_TIPO_STATUS_PEDIDOS, FLAG_BXASTT, DSC_HIST, DTHR_HIST)
    values
      (:P_FK_EMPRESAS, :P_FK_TIPO_PEDIDOS, :P_PK_PEDIDOS, 0,
       :FkTipoStatusPedidos, :FlagEstq, :DscHist, current_timestamp);
  end
  if ((FlagRecb = 1) and (DtaRecb is null)) then
  begin
    DtaRecb = current_date;
    DscHist = 'Recebimento do Pedido';
    insert into PEDIDOS_HISTORICOS
      (FK_EMPRESAS, FK_TIPO_PEDIDOS, FK_PEDIDOS, PK_PEDIDOS_HISTORICOS,
       FK_TIPO_STATUS_PEDIDOS, FLAG_BXASTT, DSC_HIST, DTHR_HIST)
    values
      (:P_FK_EMPRESAS, :P_FK_TIPO_PEDIDOS, :P_PK_PEDIDOS, 0,
       :FkTipoStatusPedidos, :FlagEstq, :DscHist, current_timestamp);
  end
  select Count(*) from PEDIDOS_ITENS
   where FK_EMPRESAS     = :P_FK_EMPRESAS
     and FK_TIPO_PEDIDOS = :P_FK_TIPO_PEDIDOS
     and FK_PEDIDOS      = :P_PK_PEDIDOS
    into :QtdItems;
  if ((QtdItems is null) or (QtdItems = 0)) then
  begin
    suspend;
    exit;
  end
  if ((FlagProd = 1) and (FlagProdPed > 0)) then
  begin
    DscHist = 'Pedido entrou na producao';
    insert into PEDIDOS_HISTORICOS
      (FK_EMPRESAS, FK_TIPO_PEDIDOS, FK_PEDIDOS, PK_PEDIDOS_HISTORICOS,
       FK_TIPO_STATUS_PEDIDOS, FLAG_BXASTT, DSC_HIST, DTHR_HIST)
    values
      (:P_FK_EMPRESAS, :P_FK_TIPO_PEDIDOS, :P_PK_PEDIDOS, 0,
       :FkTipoStatusPedidos, :FlagEstq, :DscHist, current_timestamp);
  end
  QtdRows = 0;
  select Count(DTA_FAT) from PEDIDOS_ITENS
   where FK_EMPRESAS     = :P_FK_EMPRESAS
     and FK_TIPO_PEDIDOS = :P_FK_TIPO_PEDIDOS
     and FK_PEDIDOS      = :P_PK_PEDIDOS
     and DTA_FAT is not null
    into :QtdRows;
  if (FlagCanc = 1) then
  begin
    DtaCanc = current_date;
    DscHist = 'Cancelamento do Pedido';
    insert into PEDIDOS_HISTORICOS
      (FK_EMPRESAS, FK_TIPO_PEDIDOS, FK_PEDIDOS, PK_PEDIDOS_HISTORICOS,
       FK_TIPO_STATUS_PEDIDOS, FLAG_BXASTT, DSC_HIST, DTHR_HIST)
    values
      (:P_FK_EMPRESAS, :P_FK_TIPO_PEDIDOS, :P_PK_PEDIDOS, 0,
       :FkTipoStatusPedidos, :FlagEstq, :DscHist, current_timestamp);
    if (FlagGFin = 1) then
    begin /* if can generate finance then delete prevision cash */
      if ((QtdRows < QtdItems) and (DtaLib is not null) and (DtaLib > 0)) then
      begin
        select R_STATUS
          from STP_DELETE_ORDER_PREVISION(:P_FK_EMPRESAS, :P_FK_TIPO_PEDIDOS,
                 :P_PK_PEDIDOS, :FkTipoPagamentos, :LstPrz, :DtaLiq, :DtaCanc)
          into :R_STATUS;
        if (R_STATUS <> 0) then
        begin
          R_STATUS = -10; /* Error on deleting prevision cash */
          suspend;
          exit;
        end
      end
    end
  end
  if ((FlagLib = 1) and (DtaLib is null))  then
  begin
    DtaLib  = current_date;
    DscHist = 'Liberacao do Pedido no financeiro';
    insert into PEDIDOS_HISTORICOS
      (FK_EMPRESAS, FK_TIPO_PEDIDOS, FK_PEDIDOS, PK_PEDIDOS_HISTORICOS,
       FK_TIPO_STATUS_PEDIDOS, FLAG_BXASTT, DSC_HIST, DTHR_HIST)
    values
      (:P_FK_EMPRESAS, :P_FK_TIPO_PEDIDOS, :P_PK_PEDIDOS, 0,
       :FkTipoStatusPedidos, :FlagEstq, :DscHist, current_timestamp);
    if (FlagGFin = 1) then /* se pode gerar Financeiro */
    begin
      FlagInstallments = 0;
      for select PK_PEDIDOS_PARCELAS, VLR_PARC, NUM_PARC
            from PEDIDOS_PARCELAS
           where FK_EMPRESAS     = :P_FK_EMPRESAS
             and FK_TIPO_PEDIDOS = :P_FK_TIPO_PEDIDOS
             and FK_PEDIDOS      = :P_PK_PEDIDOS
            into :DtaLan, :VlrLan, :NumParc do
      begin
        select R_STATUS
          from STP_INSERT_PREVISION_FROM_ORDER(:P_FK_EMPRESAS,
                 :P_FK_TIPO_PEDIDOS, :P_PK_PEDIDOS, :DtaLan,
                 :VlrLan, :NumParc, :TotPed, :QtdParc)
          into :R_STATUS;
        if (R_STATUS <> 0) then
        begin
          R_STATUS = -15; /* Error when  insertion prevision cash */
          suspend;
          exit;
        end
        FlagInstallments = 1;
      end
      if (FlagInstallments = 0) then
      begin /* if cash sale then calc the delivery date to insert prevision */
        if ((DtaPrevEntr is null) and (DtaPrevEntr = 0)) then
        begin
          if ((MesPrevEntr is null) or (MesPrevEntr = 0) or
             ( AnoPrevEntr is null) or (AnoPrevEntr = 0)) then
          begin
            R_STATUS = -15; /* Don't found the prevision cash */
            suspend;
            exit;
          end
          else
          begin
            DiaPrevEntr = Extract(Day from DtaPed);
            StrDate     = Cast(MesPrevEntr as varchar(2)) || '/' ||
                          Cast(DiaPrevEntr as varchar(2)) || '/' ||
                          Cast(AnoPrevEntr as varchar(4));
            DtaPrevEntr = Cast(StrDate as date);
          end
        end
        select R_STATUS
          from STP_INSERT_PREVISION_FROM_ORDER(:P_FK_EMPRESAS,
                 :P_FK_TIPO_PEDIDOS, :P_PK_PEDIDOS, :DtaPrevEntr,
                 :TotPed, 1, :TotPed, 0)
          into :R_STATUS;
        if (R_STATUS <> 0) then
        begin
          R_STATUS = -15; /* Error when  insertion prevision cash */
          suspend;
          exit;
        end
      end
    end
  end
  if (FlagFat = 1) then
  begin
    DtaFat = current_date;
    if (QtdRows = QtdItems) then
      DscHist = 'Faturamento total parcial do pedido';
    else
      DscHist = 'Faturamento parcial do pedido';
    insert into PEDIDOS_HISTORICOS
      (FK_EMPRESAS, FK_TIPO_PEDIDOS, FK_PEDIDOS, PK_PEDIDOS_HISTORICOS,
       FK_TIPO_STATUS_PEDIDOS, FLAG_BXASTT, DSC_HIST, DTHR_HIST)
    values
      (:P_FK_EMPRESAS, :P_FK_TIPO_PEDIDOS, :P_PK_PEDIDOS, 0,
       :FkTipoStatusPedidos, :FlagEstq, :DscHist, current_timestamp);
    if ((QtdRows = QtdItems) and (FlagLiq <> 1)) then
    begin
      for select PK_TIPO_STATUS_PEDIDOS, FLAG_LIQ
            from TIPO_STATUS_PEDIDOS
           where FK_GRUPOS_MOVIMENTOS = :FkGruposMovimentos
             and FLAG_LIQ = 1
            into :FkTipoStatusPedidos, :FlagLiq do
      begin
        break;
      end
    end
    if (FlagGFin = 1) then
    begin
      /* delete prevision cash from this document */
      select R_STATUS
        from STP_DELETE_ORDER_PREVISION(:P_FK_EMPRESAS, :P_FK_TIPO_PEDIDOS,
             :P_PK_PEDIDOS, :FkTipoPagamentos, :LstPrz, :DtaLiq, :DtaCanc)
        into :R_STATUS;
      if (R_STATUS <> 0) then
      begin
        R_STATUS = -10; /* Error on deleting prevision cash */
        suspend;
        exit;
      end
      /* insert all itens not invoiced to prevision cash */
      TotPed = 0;
      select Sum(TOT_ITEM) from PEDIDOS_ITENS
       where FK_EMPRESAS     = :P_FK_EMPRESAS
         and FK_TIPO_PEDIDOS = :P_FK_TIPO_PEDIDOS
         and FK_PEDIDOS      = :P_PK_PEDIDOS
        into :TotPed;
      TotPed = TotPed / QtdParc;
      if (TotPed > 0) then
      begin
        FlagInstallments = 0;
        for select PK_PEDIDOS_PARCELAS, NUM_PARC
              from PEDIDOS_PARCELAS
             where FK_EMPRESAS     = :P_FK_EMPRESAS
               and FK_TIPO_PEDIDOS = :P_FK_TIPO_PEDIDOS
               and FK_PEDIDOS      = :P_PK_PEDIDOS
              into :DtaLan, :NumParc do
        begin
          select R_STATUS
            from STP_INSERT_PREVISION_FROM_ORDER(:P_FK_EMPRESAS,
                   :P_FK_TIPO_PEDIDOS, :P_PK_PEDIDOS, :DtaLan,
                   :TotPed, :NumParc, :TotPed, :QtdParc)
            into :R_STATUS;
          if (R_STATUS <> 0) then
          begin
            R_STATUS = -15; /* Error when  insertion prevision cash */
            suspend;
            exit;
          end
          FlagInstallments = 1;
        end
        if (FlagInstallments = 0) then
        begin /* if cash sale then calc the delivery date to insert prevision */
          if ((DtaPrevEntr is null) and (DtaPrevEntr = 0)) then
          begin
            if ((MesPrevEntr is null) or (MesPrevEntr = 0) or
               ( AnoPrevEntr is null) or (AnoPrevEntr = 0)) then
            begin
              R_STATUS = -15; /* Don't found the prevision cash */
              suspend;
              exit;
            end
            else
            begin
              DiaPrevEntr = Extract(Day from DtaPed);
              StrDate     = Cast(MesPrevEntr as varchar(2)) || '/' ||
                            Cast(DiaPrevEntr as varchar(2)) || '/' ||
                            Cast(AnoPrevEntr as varchar(4));
              DtaPrevEntr = Cast(StrDate as date);
            end
          end
          select R_STATUS
            from STP_INSERT_PREVISION_FROM_ORDER(:P_FK_EMPRESAS,
                 :P_FK_TIPO_PEDIDOS, :P_PK_PEDIDOS, :DtaPrevEntr,
                 :TotPed, 1, :TotPed, 0)
            into :R_STATUS;
          if (R_STATUS <> 0) then
          begin
            R_STATUS = -15; /* Error when  insertion prevision cash */
            suspend;
            exit;
          end
        end
      end
    end
  end
  if (FlagLiq = 1) then
  begin
    DtaFat = current_date;
    DtaLiq = current_date;
    DscHist = 'Liquidacao do pedido';
    insert into PEDIDOS_HISTORICOS
      (FK_EMPRESAS, FK_TIPO_PEDIDOS, FK_PEDIDOS, PK_PEDIDOS_HISTORICOS,
       FK_TIPO_STATUS_PEDIDOS, FLAG_BXASTT, DSC_HIST, DTHR_HIST)
    values
      (:P_FK_EMPRESAS, :P_FK_TIPO_PEDIDOS, :P_PK_PEDIDOS, 0,
       :FkTipoStatusPedidos, :FlagEstq, :DscHist, current_timestamp);
    if (FlagGFin = 1) then
    begin
      R_STATUS = 10; /* singnal to finish this document
      /* delete prevision cash from this document when transform
         it in the official document then insert into cash system */
      select R_STATUS
        from STP_DELETE_ORDER_PREVISION(:P_FK_EMPRESAS, :P_FK_TIPO_PEDIDOS,
             :P_PK_PEDIDOS, :FkTipoPagamentos, :LstPrz, :DtaLiq, :DtaCanc)
        into :R_STATUS;
      if (R_STATUS <> 0) then
      begin
        R_STATUS = -10; /* Error on deleting prevision cash */
        suspend;
        exit;
      end
    end
  end
  update PEDIDOS set
         DTA_RECB = :DtaRecb,
         DTA_PED  = :DtaPed,
         DTA_Lib  = :DtaLib,
         DTA_FAT  = :DtaFat,
         DTA_LIQ  = :DtaLiq,
         FK_TIPO_STATUS_PEDIDOS = :FkTipoStatusPedidos
   where FK_EMPRESAS     = :P_FK_EMPRESAS
     and FK_TIPO_PEDIDOS = :P_FK_TIPO_PEDIDOS
     and PK_PEDIDOS      = :P_PK_PEDIDOS;
  R_STATUS = 0;
  suspend;
end ^

set term ;^;

grant EXECUTE on procedure STP_SET_STATUS_TO_ORDER to PUBLIC;


/*  Update trigger "TBU0_BANCOS" for table "BANCOS"  */
set term ^;

create trigger TBU0_BANCOS for BANCOS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  execute procedure STP_INSERT_HISTORIC ('BANCOS', 'BANCOS',
    'atualização de registro', 'UPD');
end^

set term ;^;


/*  Update trigger "TBU0_BANCOS_AGENCIAS" for table "BANCOS_AGENCIAS"  */
set term ^;

create trigger TBU0_BANCOS_AGENCIAS for BANCOS_AGENCIAS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  execute procedure STP_INSERT_HISTORIC ('BANCOS_AGENCIAS', 'BANCOS_AGENCIAS',
    'atualização de registro', 'UPD');
end^

set term ;^;


/*  Update trigger "TBU0_BANCOS_CONTAS" for table "BANCOS_CONTAS"  */
set term ^;

create trigger TBU0_BANCOS_CONTAS for BANCOS_CONTAS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  execute procedure STP_INSERT_HISTORIC ('BANCOS_CONTAS', 'BANCOS_CONTAS',
    'atualização de registro', 'UPD');
end^

set term ;^;


/*  Update trigger "TBU0_CLASSIFICACAO_DOCUMENTOS" for table "CLASSIFICACAO_DOCUMENTOS"  */
set term ^;

create trigger TBU0_CLASSIFICACAO_DOCUMENTOS for CLASSIFICACAO_DOCUMENTOS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  execute procedure STP_INSERT_HISTORIC ('CLASSIFICACAO_DOCUMENTOS', 'CLASSIFICACAO_DOCUMENTOS',
    'atualização de registro', 'UPD');
end^

set term ;^;


/*  Insert trigger "TAI0_CLASSIFICACAO_DOCUMENTOS" for table "CLASSIFICACAO_DOCUMENTOS"  */
set term ^;

create trigger TAI0_CLASSIFICACAO_DOCUMENTOS for CLASSIFICACAO_DOCUMENTOS
  after insert as
  declare variable DtaSld          date;
  declare variable DtaSldClas      date;
  declare variable DtaSldPrev      date;
  declare variable LastSldClas     numeric(18, 4);
  declare variable LastSldPrev     numeric(18, 4);
  declare variable PkClassificacao integer;
  declare variable SldClas         numeric(18, 4);
  declare variable SldPrev         numeric(18, 4);
  declare variable VlrLan          numeric(18, 4);
begin
  if (New.FLAG_DBCR = 0) then
    VlrLan = New.VLR_LAN * -1;
  else
    VlrLan = New.VLR_LAN;
  for select R_PK_CLASSIFICACAO from STP_GET_CLASSIFICACAO_FATHER(
             New.FK_CLASSIFICACAO)
        into :PkClassificacao do
  begin  
    select SLD_CLAS, SLD_PREV, DTA_SLD_CLAS, DTA_SLD_PREV
      from CLASSIFICACAO
     where PK_CLASSIFICACAO = :PkClassificacao
      into :LastSldClas, :LastSldPrev, :DtaSldClas, :DtaSldPrev;
    if (New.FLAG_PREV = 1) then
    begin
      if ((DtaSldPrev is null) or (DtaSldPrev < New.DTA_LAN)) then
        DtaSldPrev = New.DTA_LAN;
      LastSldPrev  = LastSldPrev + VlrLan;
    end
    else
    begin
      if ((DtaSldClas is null) or (DtaSldClas < New.DTA_LAN)) then
        DtaSldClas = New.DTA_LAN;
      LastSldClas = LastSldClas + VlrLan;
    end
    update CLASSIFICACAO set
           SLD_CLAS     = :LastSldClas,
           SLD_PREV     = :LastSldPrev,
           DTA_SLD_CLAS = :DtaSldClas,
           DTA_SLD_PREV = :DtaSldPrev
     where PK_CLASSIFICACAO = :PkClassificacao;
    LastSldPrev = null;
    LastSldClas = null;
    DtaSld      = null;
    for select SLD_PREV, SLD_CLAS, PK_CLASSIFICACAO_SALDOS 
          from CLASSIFICACAO_SALDOS
         where FK_EMPRESAS             =  New.FK_EMPRESAS
           and FK_CLASSIFICACAO        =  :PkClassificacao
           and PK_CLASSIFICACAO_SALDOS <= New.DTA_LAN
         order by PK_CLASSIFICACAO_SALDOS desc
          into :LastSldPrev, :LastSldClas, :DtaSld do
    begin
      break;
    end
    if (LastSldPrev is null) then
      LastSldPrev = 0;
    if (LastSldClas is null) then
      LastSldClas = 0;
    if ((DtaSld is null) or (DtaSld <> New.DTA_LAN)) then
    begin
      insert into CLASSIFICACAO_SALDOS
        (FK_EMPRESAS, FK_CLASSIFICACAO, PK_CLASSIFICACAO_SALDOS, SLD_CLAS, SLD_PREV)
      values
        (New.FK_EMPRESAS, :PkClassificacao, New.DTA_LAN, :LastSldClas, :LastSldPrev);
    end
    /* loop for update all balances */ 
    DtaSld = null;
    for select PK_CLASSIFICACAO_SALDOS , SLD_PREV, SLD_CLAS
          from CLASSIFICACAO_SALDOS
         where FK_EMPRESAS              = New.FK_EMPRESAS
           and FK_CLASSIFICACAO         = :PkClassificacao
           and PK_CLASSIFICACAO_SALDOS >= New.DTA_LAN
         order by PK_CLASSIFICACAO_SALDOS asc
          into :DtaSld, :SldPrev, :SldClas do
    begin
      if (SldPrev is null) then
        SldPrev = 0;
      if (SldClas is null) then
        SldClas = 0;
      if (New.FLAG_PREV = 1) then
        SldPrev = SldPrev + VlrLan;
      else
        SldClas = SldClas + VlrLan;
      update CLASSIFICACAO_SALDOS set
             SLD_PREV = :SldPrev,
             SLD_CLAS = :SldClas
       where FK_EMPRESAS             = New.FK_EMPRESAS
         and FK_CLASSIFICACAO        = :PkClassificacao
         and PK_CLASSIFICACAO_SALDOS = :DtaSld;
    end
  end
end^

set term ;^;


/*  Insert trigger "TBIG_CLASSIFICACAO_DOCUMENTOS" for table "CLASSIFICACAO_DOCUMENTOS"  */
set term ^;

create trigger TBIG_CLASSIFICACAO_DOCUMENTOS for CLASSIFICACAO_DOCUMENTOS
  before insert as
begin
  if ((New.PK_CLASSIFICACAO_DOCUMENTOS is null) or 
     ( New.PK_CLASSIFICACAO_DOCUMENTOS = 0)) then
  begin
    select R_PK_CLASSIFICACAO_DOCUMENTOS 
      from STP_GET_KC_CLASSIFICACAO_DOC (New.FK_CLASSIFICACAO)
      into New.PK_CLASSIFICACAO_DOCUMENTOS;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
end^

set term ;^;


/*  Delete trigger "TAD0_CLASSIFICACAO_DOCUMENTOS" for table "CLASSIFICACAO_DOCUMENTOS"  */
set term ^;

create trigger TAD0_CLASSIFICACAO_DOCUMENTOS for CLASSIFICACAO_DOCUMENTOS
after delete as
  declare variable DtaSld          date;
  declare variable DtaSldClas      date;
  declare variable DtaSldPrev      date;
  declare variable LastSldClas     numeric(18, 4);
  declare variable LastSldPrev     numeric(18, 4);
  declare variable PkClassificacao integer;
  declare variable SldClas         numeric(18, 4);
  declare variable SldPrev         numeric(18, 4);
  declare variable VlrLan          numeric(18, 4);
begin
  if (Old.FLAG_DBCR = 0) then
    VlrLan = Old.VLR_LAN * -1;
  else
    VlrLan = Old.VLR_LAN;
  for select R_PK_CLASSIFICACAO from STP_GET_CLASSIFICACAO_FATHER(
             Old.FK_CLASSIFICACAO)
        into :PkClassificacao do
  begin  
    select SLD_CLAS, SLD_PREV, DTA_SLD_CLAS, DTA_SLD_PREV
      from CLASSIFICACAO
     where PK_CLASSIFICACAO = :PkClassificacao
      into :LastSldClas, :LastSldPrev, :DtaSldClas, :DtaSldPrev;
    if (Old.FLAG_PREV = 1) then
    begin
      if ((DtaSldPrev is null) or (DtaSldPrev < Old.DTA_LAN)) then
        DtaSldPrev = Old.DTA_LAN;
      LastSldPrev  = LastSldPrev - VlrLan;
    end
    else
    begin
      if ((DtaSldClas is null) or (DtaSldClas < Old.DTA_LAN)) then
        DtaSldClas = Old.DTA_LAN;
      LastSldClas = LastSldClas - VlrLan;
    end
    update CLASSIFICACAO set
           SLD_CLAS     = :LastSldClas,
           SLD_PREV     = :LastSldPrev,
           DTA_SLD_CLAS = :DtaSldClas,
           DTA_SLD_PREV = :DtaSldPrev
     where PK_CLASSIFICACAO = :PkClassificacao;
    LastSldPrev = null;
    LastSldClas = null;
    DtaSld      = null;
    for select SLD_PREV, SLD_CLAS, PK_CLASSIFICACAO_SALDOS 
          from CLASSIFICACAO_SALDOS
         where FK_EMPRESAS             =  Old.FK_EMPRESAS
           and FK_CLASSIFICACAO        =  :PkClassificacao
           and PK_CLASSIFICACAO_SALDOS <= Old.DTA_LAN
         order by PK_CLASSIFICACAO_SALDOS desc
          into :LastSldPrev, :LastSldClas, :DtaSld do
    begin
      break;
    end
    if ((DtaSld is not null) or (DtaSld = Old.DTA_LAN)) then
    begin
      if ((Old.FLAG_PREV = 1) and (LastSldPrev is not null)) then
        LastSldPrev = LastSldPrev - VlrLan;
      if ((Old.FLAG_PREV = 0) and (LastSldClas is not null)) then
        LastSldClas = LastSldClas - VlrLan;
      if (((LastSldPrev is null) or (LastSldPrev = 0))  and 
         (( LastSldClas is null) or (LastSldClas = 0))) then
      begin
        delete from CLASSIFICACAO_SALDOS
         where FK_EMPRESAS             = Old.FK_EMPRESAS
           and FK_CLASSIFICACAO        = :PkClassificacao
           and PK_CLASSIFICACAO_SALDOS = Old.DTA_LAN;
      end
    end
    /* loop for update all balances */ 
    DtaSld = null;
    for select PK_CLASSIFICACAO_SALDOS , SLD_PREV, SLD_CLAS
          from CLASSIFICACAO_SALDOS
         where FK_EMPRESAS              = Old.FK_EMPRESAS
           and FK_CLASSIFICACAO         = :PkClassificacao
           and PK_CLASSIFICACAO_SALDOS >= Old.DTA_LAN
         order by PK_CLASSIFICACAO_SALDOS asc
          into :DtaSld, :SldPrev, :SldClas do
    begin
      if (SldPrev is null) then
        SldPrev = 0;
      if (SldClas is null) then
        SldClas = 0;
      if (Old.FLAG_PREV = 1) then
        SldPrev = SldPrev - VlrLan;
      else
        SldClas = SldClas - VlrLan;
      update CLASSIFICACAO_SALDOS set
             SLD_PREV = :SldPrev,
             SLD_CLAS = :SldClas
       where FK_EMPRESAS             = Old.FK_EMPRESAS
         and FK_CLASSIFICACAO        = :PkClassificacao
         and PK_CLASSIFICACAO_SALDOS = :DtaSld;
    end
  end
end ^

set term ;^;


/*  Update trigger "TBU0_CLASSIFICACAO_SALDOS" for table "CLASSIFICACAO_SALDOS"  */
set term ^;

create trigger TBU0_CLASSIFICACAO_SALDOS for CLASSIFICACAO_SALDOS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  execute procedure STP_INSERT_HISTORIC ('CLASSIFICACAO_SALDOS', 'CLASSIFICACAO_SALDOS',
    'atualização de registro', 'UPD');
end^

set term ;^;


/*  Update trigger "TBU0_CONTAS" for table "CONTAS"  */
set term ^;

create trigger TBU0_CONTAS for CONTAS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  execute procedure STP_INSERT_HISTORIC ('CONTAS', 'CONTAS',
    'atualização de registro', 'UPD');
end^

set term ;^;


/*  Insert trigger "TBIG_CONTAS" for table "CONTAS"  */
set term ^;

create trigger TBIG_CONTAS for CONTAS
before insert as
  declare variable MaxValue integer;
begin
  if ((New.PK_CONTAS is null) or (New.PK_CONTAS = 0)) then
  begin
    select R_PK_CONTAS from STP_GET_KC_CONTAS (New.FK_TIPO_CONTAS)
      into New.PK_CONTAS;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
end^

set term ;^;


/*  Update trigger "TBU0_CONTAS_DOCUMENTOS" for table "CONTAS_DOCUMENTOS"  */
set term ^;

create trigger TBU0_CONTAS_DOCUMENTOS for CONTAS_DOCUMENTOS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  execute procedure STP_INSERT_HISTORIC ('CONTAS_DOCUMENTOS', 'CONTAS_DOCUMENTOS',
    'atualização de registro', 'UPD');
end^

set term ;^;


/*  Update trigger "TAD0_CONTAS_DOCUMENTOS" for table "CONTAS_DOCUMENTOS"  */
set term ^;

create trigger TAD0_CONTAS_DOCUMENTOS for CONTAS_DOCUMENTOS
  after update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  execute procedure STP_INSERT_HISTORIC ('CONTAS_DOCUMENTOS', 'CONTAS_DOCUMENTOS',
    'atualização de registro', 'UPD');
end^

set term ;^;


/*  Insert trigger "TAI0_CONTAS_DOCUMENTOS" for table "CONTAS_DOCUMENTOS"  */
set term ^;

create trigger TAI0_CONTAS_DOCUMENTOS for CONTAS_DOCUMENTOS
  after insert as
begin
  execute procedure STP_INSERT_HISTORIC ('CONTAS_DOCUMENTOS', 'CONTAS_DOCUMENTOS',
    'inserção de registro', 'INC');
end^

set term ;^;


create exception EX_MISSING_ACCOUNT 'Para quitar um documento, uma conta deve ser informada';

/*  Update trigger "TBU0_CONTAS_LANCAMENTOS" for table "CONTAS_LANCAMENTOS"  */
set term ^;

create trigger TBU0_CONTAS_LANCAMENTOS for CONTAS_LANCAMENTOS
before update as
  declare variable DtaLan  date;
  declare variable DtaSld  date;
  declare variable LastSld numeric(18, 4);
  declare variable SldCta  numeric(18, 4);
  declare variable LastSGn numeric(18, 4);
  declare variable SldGen  numeric(18, 4);
  declare variable VlrLan  numeric(18, 4);
  declare variable FlagTrf   smallint;
  declare variable FlagEst   smallint;
  declare variable FlagGSld  smallint;
  declare variable FlagBaixa smallint;
begin
  FlagTrf   = 0;
  FlagEst   = 0;
  FlagGSld  = 1;
  FlagBaixa = 0;
  if (Old.FK_OPERACOES_FINANCEIRAS is null) then
  begin
    select FLAG_TRF, FLAG_EST, FLAG_GSLD, FLAG_BAIXA
      from OPERACOES_FINANCEIRAS
     where PK_OPERACOES_FINANCEIRAS = Old.FK_OPERACOES_FINANCEIRAS
      into :FlagTrf, :FlagEst, :FlagGSld, :FlagBaixa;
  end
  if ((FlagGSld = 1) and (New.DTA_QUIT is not null) and (Old.DTA_QUIT is null)) then
  begin
    /* if Account not informed then exception */
    if ((New.FK_EMPRESAS__CTA is null) or (New.FK_TIPO_CONTAS is null) or
       ( New.FK_CONTAS is null)) then
      exception EX_MISSING_ACCOUNT;
    if (New.FLAG_DBCR = 0) then
      VlrLan = New.VLR_LAN * -1;
    else
      VlrLan = New.VLR_LAN;
    if (FlagEst = 1) then
      VlrLan = VlrLan * -1;
    /* select record to know last balance and update it */
    select SLD_CTA, DTA_SLD from CONTAS
     where FK_EMPRESAS      = New.FK_EMPRESAS
       and FK_TIPO_CONTAS   = New.FK_TIPO_CONTAS
       and PK_CONTAS        = New.FK_CONTAS
      into :LastSld, :DtaSld;
    DtaLan = New.DTA_LAN;
    if ((DtaSld is null) or (DtaLan > DtaSld)) then
      DtaSld = DtaLan;
    update CONTAS set
           SLD_CTA          = :LastSld + :VlrLan,
           DTA_SLD          = :DtaSld
     where FK_EMPRESAS      = New.FK_EMPRESAS
       and FK_TIPO_CONTAS   = New.FK_TIPO_CONTAS
       and PK_CONTAS        = New.FK_CONTAS;
    DtaSld = null;
    /* select record to know if exists a record on date if no insert it */
    for select SLD_GER, SLD_CTA, PK_CONTAS_SALDOS
          from CONTAS_SALDOS
         where FK_EMPRESAS      = New.FK_EMPRESAS
           and PK_CONTAS_SALDOS <= :DtaLan
         order by PK_CONTAS_SALDOS desc
          into :LastSGn, :LastSld, :DtaSld do
    begin
      break;
    end
    if (LastSld is null) then LastSld = 0;
    if (LastSGn is null) then LastSGn = 0;
    /* if don't exist record into CONTAS_SALDOS table then insert it */
    if ((DtaSld is null) or (DtaSld <> DtaLan)) then
      insert into CONTAS_SALDOS
        (FK_EMPRESAS, FK_CONTAS_LANCAMENTOS, FK_EMPRESAS__CTA, FK_TIPO_CONTAS,
         FK_CONTAS, PK_CONTAS_SALDOS, SLD_CTA, SLD_GER)
      values
        (New.FK_EMPRESAS, New.PK_CONTAS_LANCAMENTOS, New.FK_EMPRESAS__CTA,
         New.FK_TIPO_CONTAS, New.FK_CONTAS, :DtaLan, :LastSld, :LastSGn);
    /* update balance to last date if previnous record was inserted */
    for select SLD_GER, SLD_CTA, PK_CONTAS_SALDOS
          from CONTAS_SALDOS
         where FK_EMPRESAS      = New.FK_EMPRESAS
           and PK_CONTAS_SALDOS >= :DtaLan
         order by PK_CONTAS_SALDOS asc
          into :SldGen, :SldCta, :DtaSld do
    begin
       SldCta = SldCta + VlrLan;
       update CONTAS_SALDOS set
              SLD_GER           = :SldGen,
              SLD_CTA           = :SldCta
        where FK_EMPRESAS       = New.FK_EMPRESAS
          and PK_CONTAS_SALDOS  = :DtaSld;
       SldCta = 0;
    end
  end
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  execute procedure STP_INSERT_HISTORIC ('CONTAS_LANCAMENTOS', 'CONTAS_LANCAMENTOS',
    'atualizacao de registro', 'UPD');
end ^

set term ;^;


/*  Insert trigger "TBIG_CONTAS_LANCAMENTOS" for table "CONTAS_LANCAMENTOS"  */
set term ^;

create trigger TBIG_CONTAS_LANCAMENTOS for CONTAS_LANCAMENTOS
  before insert as
begin
  if ((New.PK_CONTAS_LANCAMENTOS is null) or (New.PK_CONTAS_LANCAMENTOS = 0)) then
  begin
    select R_PK_CONTAS_LANCAMENTOS from STP_GET_KC_CONTAS_LANCAMENTOS (
           New.FK_EMPRESAS)
      into New.PK_CONTAS_LANCAMENTOS;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
  execute procedure STP_INSERT_HISTORIC ('CONTAS_LANCAMENTOS', 'CONTAS_LANCAMENTOS',
    'inserção de registro', 'INC');
end^

set term ;^;


/*  Insert trigger "TAI0_CONTAS_LANCAMENTOS" for table "CONTAS_LANCAMENTOS"  */
set term ^;

create trigger TAI0_CONTAS_LANCAMENTOS for CONTAS_LANCAMENTOS
  after insert as
  declare variable DtaLan  date;
  declare variable DtaSld  date;
  declare variable LastSld numeric(18, 4);
  declare variable SldCta  numeric(18, 4);
  declare variable LastSGn numeric(18, 4);
  declare variable SldGen  numeric(18, 4);
  declare variable VlrLan  numeric(18, 4);
  declare variable FlagCta smallint;
  declare variable FlagTrf   smallint;
  declare variable FlagEst   smallint;
  declare variable FlagGSld  smallint;
  declare variable FlagBaixa smallint;
begin
  FlagTrf   = 0;
  FlagEst   = 0;
  FlagGSld  = 1;
  FlagBaixa = 0;
  if (New.FK_OPERACOES_FINANCEIRAS is null) then
  begin
    select FLAG_TRF, FLAG_EST, FLAG_GSLD, FLAG_BAIXA
      from OPERACOES_FINANCEIRAS
     where PK_OPERACOES_FINANCEIRAS = New.FK_OPERACOES_FINANCEIRAS
      into :FlagTrf, :FlagEst, :FlagGSld, :FlagBaixa;
  end
  if (FlagGSld = 1) then
  begin
    /* select record to know last balance and update it */
    if (New.FLAG_DBCR = 0) then
      VlrLan = New.VLR_LAN * -1;
    else
      VlrLan = New.VLR_LAN;
    if (FlagEst = 1) then
      VlrLan = VlrLan * -1;
    FlagCta = 0; /* without account */
    /* select record to know last balance and update it if the account exists */
    if ((New.FK_EMPRESAS__CTA is not null) and (New.FK_TIPO_CONTAS is not null) and
       ( New.FK_CONTAS is not null)) then
    begin
      FlagCta = 1; /* without account */
      select SLD_CTA, DTA_SLD from CONTAS
       where FK_EMPRESAS      = New.FK_EMPRESAS
         and FK_TIPO_CONTAS   = New.FK_TIPO_CONTAS
         and PK_CONTAS        = New.FK_CONTAS
        into :LastSld, :DtaSld;
      DtaLan = New.DTA_LAN;
      if ((DtaSld is null) or (DtaLan > DtaSld)) then
        DtaSld = DtaLan;
      update CONTAS set
             SLD_CTA          = :LastSld + :VlrLan,
             DTA_SLD          = :DtaSld
       where FK_EMPRESAS      = New.FK_EMPRESAS
         and FK_TIPO_CONTAS   = New.FK_TIPO_CONTAS
         and PK_CONTAS        = New.FK_CONTAS;
      DtaSld = null;
    end
    /* select record to know if exists a record on date if no insert it */
    for select SLD_GER, SLD_CTA, PK_CONTAS_SALDOS
          from CONTAS_SALDOS
         where FK_EMPRESAS      = New.FK_EMPRESAS
           and PK_CONTAS_SALDOS <= :DtaLan
         order by PK_CONTAS_SALDOS desc
          into :LastSGn, :LastSld, :DtaSld do
    begin
      break;
    end
    if (LastSld is null) then LastSld = 0;
    if (LastSGn is null) then LastSGn = 0;
    /* if don't exist record into CONTAS_SALDOS table then insert it */
    if ((DtaSld is null) or (DtaSld <> DtaLan)) then
      insert into CONTAS_SALDOS
        (FK_EMPRESAS, FK_CONTAS_LANCAMENTOS, FK_EMPRESAS__CTA, FK_TIPO_CONTAS,
         FK_CONTAS, PK_CONTAS_SALDOS, SLD_CTA, SLD_GER)
      values
        (New.FK_EMPRESAS, New.PK_CONTAS_LANCAMENTOS, New.FK_EMPRESAS__CTA,
         New.FK_TIPO_CONTAS, New.FK_CONTAS, :DtaLan, :LastSld, :LastSGn);
    /* update balance to last date if previnous record was inserted */
    for select SLD_GER, SLD_CTA, PK_CONTAS_SALDOS
          from CONTAS_SALDOS
         where FK_EMPRESAS      = New.FK_EMPRESAS
           and PK_CONTAS_SALDOS >= :DtaLan
         order by PK_CONTAS_SALDOS asc
          into :SldGen, :SldCta, :DtaSld do
    begin
      if ((FlagTrf = 0) and (FlagBaixa = 0)) then
        SldGen = SldGen + VlrLan;
      if (FlagCta = 1) then
        SldCta = SldCta + VlrLan;
      update CONTAS_SALDOS set
             SLD_GER           = :SldGen,
             SLD_CTA           = :SldCta
       where FK_EMPRESAS       = New.FK_EMPRESAS
         and PK_CONTAS_SALDOS  = :DtaSld;
      SldCta = 0;
    end
  end
end ^

set term ;^;


/*  Delete trigger "TAD0_CONTAS_LANCAMENTOS" for table "CONTAS_LANCAMENTOS"  */
set term ^;

create trigger TAD0_CONTAS_LANCAMENTOS for CONTAS_LANCAMENTOS
after delete as
  declare variable DtaLan    date;
  declare variable DtaSld    date;
  declare variable LastSld   numeric(18, 4);
  declare variable SldCta    numeric(18, 4);
  declare variable LastSGn   numeric(18, 4);
  declare variable SldGen    numeric(18, 4);
  declare variable VlrLan    numeric(18, 4);
  declare variable FlagCta   smallint;
  declare variable FlagTrf   smallint;
  declare variable FlagEst   smallint;
  declare variable FlagGSld  smallint;
  declare variable FlagBaixa smallint;
begin
  FlagTrf   = 0;
  FlagEst   = 0;
  FlagGSld  = 1;
  FlagBaixa = 0;
  if (Old.FK_OPERACOES_FINANCEIRAS is null) then
  begin
    select FLAG_TRF, FLAG_EST, FLAG_GSLD, FLAG_BAIXA
      from OPERACOES_FINANCEIRAS
     where PK_OPERACOES_FINANCEIRAS = Old.FK_OPERACOES_FINANCEIRAS
      into :FlagTrf, :FlagEst, :FlagGSld, :FlagBaixa;
  end
  if (FlagGSld = 1) then
  begin
    if (Old.FLAG_DBCR = 0) then
      VlrLan = Old.VLR_LAN * -1;
    else
      VlrLan = Old.VLR_LAN;
     if (FlagEst = 1) then
      VlrLan = VlrLan * -1;
    FlagCta = 0; /* without account */
    /* select record to know last balance and update it if the account exists */
    if ((Old.FK_EMPRESAS__CTA is not null) and (Old.FK_TIPO_CONTAS is not null) and
       ( Old.FK_CONTAS is not null)) then
    begin
      FlagCta = 1; /* without account */
      select SLD_CTA, DTA_SLD from CONTAS
       where FK_EMPRESAS      = Old.FK_EMPRESAS__CTA
         and FK_TIPO_CONTAS   = Old.FK_TIPO_CONTAS
         and PK_CONTAS        = Old.FK_CONTAS
        into :LastSld, :DtaSld;
      DtaLan = Old.DTA_LAN;
      if ((DtaSld is null) or (DtaLan > DtaSld)) then
        DtaSld = DtaLan;
      update CONTAS set
             SLD_CTA          = :LastSld - :VlrLan,
             DTA_SLD          = :DtaSld
       where FK_EMPRESAS      = Old.FK_EMPRESAS
         and FK_TIPO_CONTAS   = Old.FK_TIPO_CONTAS
         and PK_CONTAS        = Old.FK_CONTAS;
      DtaSld = null;
      LastSld = null;
    end
    /* select record to know if exists a record on date if no insert it */
    for select SLD_GER, SLD_CTA, PK_CONTAS_SALDOS
          from CONTAS_SALDOS
         where FK_EMPRESAS      = Old.FK_EMPRESAS
           and PK_CONTAS_SALDOS <= :DtaLan
         order by PK_CONTAS_SALDOS desc
          into :LastSGn, :LastSld, :DtaSld do
    begin
      break;
    end
    if ((LastSld is not null) and (DtaSld is not null) and (DtaSld = DtaLan)) then
    begin
      if ((FlagTrf = 0) and (FlagBaixa = 0)) then
        LastSGn = LastSGn - VlrLan;
      if (FlagCta = 1) then
        LastSld = LastSld - VlrLan;
      if ((LastSld = 0) and (LastSGn = 0)) then
      begin
        delete from CONTAS_SALDOS
         where FK_EMPRESAS      = Old.FK_EMPRESAS
           and PK_CONTAS_SALDOS = :DtaLan;
      end
    end
    /* update balance to last date if previnous record was inserted */
    for select SLD_GER, SLD_CTA, PK_CONTAS_SALDOS
          from CONTAS_SALDOS
         where FK_EMPRESAS      = Old.FK_EMPRESAS
           and PK_CONTAS_SALDOS >= :DtaLan
         order by PK_CONTAS_SALDOS asc
          into :SldGen, :SldCta, :DtaSld do
    begin
      if ((FlagTrf = 0) or (FlagBaixa = 0)) then
         SldGen = SldGen - VlrLan;
       if (FlagCta = 1) then
         SldCta = SldCta - VlrLan;
       update CONTAS_SALDOS set
              SLD_GER          = :SldGen,
              SLD_CTA          = :SldCta
        where FK_EMPRESAS      = Old.FK_EMPRESAS
          and PK_CONTAS_SALDOS = :DtaSld;
       SldCta = 0;
    end
  end
  execute procedure STP_INSERT_HISTORIC ('CONTAS_LANCAMENTOS', 'CONTAS_LANCAMENTOS',
    'exclusao de registro', 'DEL');
end ^

set term ;^;


/*  Insert trigger "TBIG_CONTAS_LANCAMENTOS_TRF" for table "CONTAS_LANCAMENTOS_TRF"  */
set term ^;

create trigger TBIG_CONTAS_LANCAMENTOS_TRF for CONTAS_LANCAMENTOS_TRF
before insert as
begin
  if ((New.PK_CONTAS_LANCAMENTOS_TRF is null) or (New.PK_CONTAS_LANCAMENTOS_TRF = 0)) then
  begin
    select R_PK_CONTAS_LANCAMENTOS_TRF from STP_GET_KC_CONTAS_LANC_TRF (
           New.FK_EMPRESAS)
      into New.PK_CONTAS_LANCAMENTOS_TRF;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
  execute procedure STP_INSERT_HISTORIC ('CONTAS_LANCAMENTOS_TRF', 'CONTAS_LANCAMENTOS_TRF',
    'inserção de registro', 'INC');
end^

set term ;^;


/*  Update trigger "TAU0_CONTAS_LANCAMENTOS_TRF" for table "CONTAS_LANCAMENTOS_TRF"  */
set term ^;

create trigger TAU0_CONTAS_LANCAMENTOS_TRF for CONTAS_LANCAMENTOS_TRF
  after update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  execute procedure STP_INSERT_HISTORIC ('CONTAS_LANCAMENTOS_TRF', 'CONTAS_LANCAMENTOS_TRF',
    'atualização de registro', 'UPD');
end^

set term ;^;


/*  Delete trigger "TAD0_CONTAS_LANCAMENTOS_TRF" for table "CONTAS_LANCAMENTOS_TRF"  */
set term ^;

create trigger TAD0_CONTAS_LANCAMENTOS_TRF for CONTAS_LANCAMENTOS_TRF
  after delete as
begin
  execute procedure STP_INSERT_HISTORIC ('CONTAS_LANCAMENTOS_TRF', 'CONTAS_LANCAMENTOS_TRF',
    'exclusão de registro', 'DEL');
end^

set term ;^;


/*  Update trigger "TBU0_CONTAS_SALDOS" for table "CONTAS_SALDOS"  */
set term ^;

create trigger TBU0_CONTAS_SALDOS for CONTAS_SALDOS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  execute procedure STP_INSERT_HISTORIC ('CONTAS_SALDOS', 'CONTAS_SALDOS',
    'atualização de registro', 'UPD');
end^

set term ;^;


/*  Delete trigger "TAD0_CONTAS_SALDOS" for table "CONTAS_SALDOS"  */
set term ^;

create trigger TAD0_CONTAS_SALDOS for CONTAS_SALDOS
  after delete as
begin
  execute procedure STP_INSERT_HISTORIC ('CONTAS_SALDOS', 'CONTAS_SALDOS',
    'exclusão de registro', 'DEL');
end^

set term ;^;


/*  Insert trigger "TAI0_CONTAS_SALDOS" for table "CONTAS_SALDOS"  */
set term ^;

create trigger TAI0_CONTAS_SALDOS for CONTAS_SALDOS
  after insert as
begin
  execute procedure STP_INSERT_HISTORIC ('CONTAS_SALDOS', 'CONTAS_SALDOS',
    'inserção de registro', 'INC');
end^

set term ;^;


/*  Update trigger "TBU0_HISTORICOS_PADRAO" for table "HISTORICOS_PADRAO"  */
set term ^;

create trigger TBU0_HISTORICOS_PADRAO for HISTORICOS_PADRAO
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  execute procedure STP_INSERT_HISTORIC ('HISTORICOS_PADRAO', 'HISTORICOS_PADRAO',
    'atualização de registro', 'UPD');
end^

set term ;^;


/*  Insert trigger "TBIG_HISTORICOS_PADRAO" for table "HISTORICOS_PADRAO"  */
set term ^;

create trigger TBIG_HISTORICOS_PADRAO for HISTORICOS_PADRAO
before insert as
begin
  if ((New.PK_HITORICOS_PADRAO is null) or (New.PK_HITORICOS_PADRAO = 0)) then
    New.PK_HITORICOS_PADRAO = Gen_Id(HISTORICOS_PADRAO, 1);
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
  execute procedure STP_INSERT_HISTORIC ('HISTORICOS_PADRAO', 'HISTORICOS_PADRAO',
    'inserção de registro', 'INC');
end^

set term ;^;


/*  Update trigger "TBU0_OPERACOES_FINANCEIRAS" for table "OPERACOES_FINANCEIRAS"  */
set term ^;

create trigger TBU0_OPERACOES_FINANCEIRAS for OPERACOES_FINANCEIRAS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  execute procedure STP_INSERT_HISTORIC ('OPERACOES_FINANCEIRAS', 'OPERACOES_FINANCEIRAS',
    'atualização de registro', 'UPD');
end^

set term ;^;


/*  Insert trigger "TBIG_OPERACOES_FINANCEIRAS" for table "OPERACOES_FINANCEIRAS"  */
set term ^;

create trigger TBIG_OPERACOES_FINANCEIRAS for OPERACOES_FINANCEIRAS
before insert as
begin
  if ((New.PK_OPERACOES_FINANCEIRAS is null) or (New.PK_OPERACOES_FINANCEIRAS = 0)) then
    New.PK_OPERACOES_FINANCEIRAS = Gen_Id(OPERACOES_FINANCEIRAS, 1);
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
  execute procedure STP_INSERT_HISTORIC ('OPERACOES_FINANCEIRAS', 'OPERACOES_FINANCEIRAS',
    'inserção de registro', 'INC');
end^

set term ;^;

;


/*  Insert trigger "TAI0_PARAMETROS_PDV" for table "PARAMETROS_PDV"  */
set term ^;

create trigger TAI0_PARAMETROS_PDV for PARAMETROS_PDV
  after insert as
begin
  execute procedure STP_INSERT_HISTORIC ('PARAMETROS_PDV', 'PARAMETROS_PDV',
    'inserção de registro', 'INC');
end^

set term ;^;


/*  Update trigger "TAU0_PARAMETROS_PDV" for table "PARAMETROS_PDV"  */
set term ^;

create trigger TAU0_PARAMETROS_PDV for PARAMETROS_PDV
  after update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  execute procedure STP_INSERT_HISTORIC ('PARAMETROS_PDV', 'PARAMETROS_PDV',
    'atualização de registro', 'UPD');
end^

set term ;^;


/*  Delete trigger "TAD0_PARAMETROS_PDV" for table "PARAMETROS_PDV"  */
set term ^;

create trigger TAD0_PARAMETROS_PDV for PARAMETROS_PDV
  after delete as
begin
  execute procedure STP_INSERT_HISTORIC ('PARAMETROS_PDV', 'PARAMETROS_PDV',
    'exclusão de registro', 'DEL');
end^

set term ;^;


/*  Insert trigger "TBIG_PARAMETROS_PDV" for table "PARAMETROS_PDV"  */
set term ^;

create trigger TBIG_PARAMETROS_PDV for PARAMETROS_PDV
before insert as
  declare variable MaxValue integer;
begin
  if ((New.PK_PARAMETROS_PDV is null) or (New.PK_PARAMETROS_PDV = 0)) then
  begin
    select KC_PARAMETROS_PDV from MOD_BCCX_KEYS
     where FK_EMPRESAS = New.FK_EMPRESAS
      into :MaxValue;
    if (MaxValue is null) then
      MaxValue   = 0;
    New.PK_PARAMETROS_PDV = MaxValue + 1;
    update MOD_BCCX_KEYS set
           KC_PARAMETROS_PDV = New.PK_PARAMETROS_PDV  
     where FK_EMPRESAS = New.FK_EMPRESAS;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
end^

set term ;^;


/*  Update trigger "TBU0_TIPO_CONTAS" for table "TIPO_CONTAS"  */
set term ^;

create trigger TBU0_TIPO_CONTAS for TIPO_CONTAS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  execute procedure STP_INSERT_HISTORIC ('TIPO_CONTAS', 'TIPO_CONTAS',
    'atualização de registro', 'UPD');
end^

set term ;^;


/*  Insert trigger "TBIG_TIPO_CONTAS" for table "TIPO_CONTAS"  */
set term ^;

create trigger TBIG_TIPO_CONTAS for TIPO_CONTAS
before insert as
begin
  if ((New.PK_TIPO_CONTAS is null) or (New.PK_TIPO_CONTAS = 0)) then
    New.PK_TIPO_CONTAS = Gen_Id(TIPO_CONTAS, 1);
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
  execute procedure STP_INSERT_HISTORIC ('TIPO_CONTAS', 'TIPO_CONTAS',
    'inserção de registro', 'INC');
end^

set term ;^;


/*  Update trigger "TBU0_VINCULO_DOCUMENTOS" for table "VINCULO_DOCUMENTOS"  */
set term ^;

create trigger TBU0_VINCULO_DOCUMENTOS for VINCULO_DOCUMENTOS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  execute procedure STP_INSERT_HISTORIC ('VINCULO_DOCUMENTOS', 'VINCULO_DOCUMENTOS',
    'atualização de registro', 'UPD');
end^

set term ;^;

