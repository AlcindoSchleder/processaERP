/*==============================================================*/
/* Database name:  PROCESSA                                     */
/* DBMS name:      InterBase 6.x                                */
/* Created on:     30/03/2006 17:59:02                          */
/*==============================================================*/



set term ^;

create procedure STP_GET_KC_LIMITES_MUNICIPIOS (
  P_FK_EMPRESAS integer,
  P_FK_RODOVIAS smallint
)
returns (
  R_PK_LIMITES_MUNICIPIOS smallint
)
as
begin
  R_PK_LIMITES_MUNICIPIOS = -1;
  if ((P_FK_EMPRESAS is not null) and (P_FK_EMPRESAS > 0) and
     ( P_FK_RODOVIAS is not null) and (P_FK_RODOVIAS > 0)) then 
  begin
    select KC_LIMITES_MUNICIPIOS 
      from RODOVIAS
     where FK_EMPRESAS = :P_FK_EMPRESAS
       and PK_RODOVIAS = :P_FK_RODOVIAS
      into :R_PK_LIMITES_MUNICIPIOS;
    if ((R_PK_LIMITES_MUNICIPIOS is not null) and 
       ( R_PK_LIMITES_MUNICIPIOS >= 0)) then
    begin
      R_PK_LIMITES_MUNICIPIOS = R_PK_LIMITES_MUNICIPIOS + 1;
      update RODOVIAS set
             KC_LIMITES_MUNICIPIOS = :R_PK_LIMITES_MUNICIPIOS
       where FK_EMPRESAS = :P_FK_EMPRESAS
         and PK_RODOVIAS = :P_FK_RODOVIAS;
    end
  end
  suspend;
end ^

set term ;^;

grant execute on procedure STP_GET_KC_LIMITES_MUNICIPIOS to public;

set term ^;

create procedure STP_GET_KC_TIPO_ORDENS_SERVICOS
returns (
  R_PK_TIPO_ORDENS_SERVICOS smallint
)
as
begin
  R_PK_TIPO_ORDENS_SERVICOS = Gen_Id(TIPO_ORDENS_SERVICOS, 1);
end ^

set term ;^;

grant execute on procedure STP_GET_KC_TIPO_ORDENS_SERVICOS to public;

set term ^;

create procedure STP_GET_KC_TIPO_STATUS_OS
returns (
  R_PK_TIPO_STATUS_OS smallint
)
as
begin
  R_PK_TIPO_STATUS_OS = Gen_Id(TIPO_STATUS_OS, 1);
end ^

set term ;^;

grant execute on procedure STP_GET_KC_TIPO_STATUS_OS to public;

set term ^;

create procedure STP_GET_KC_TRECHOS_GERENCIAIS (
  P_FK_EMPRESAS integer,
  P_FK_RODOVIAS smallint
)
returns (
  R_PK_TRECHOS_GERENCIAIS smallint
)
as
begin
  R_PK_TRECHOS_GERENCIAIS = -1;
  if ((P_FK_EMPRESAS is not null) and (P_FK_EMPRESAS > 0)  and 
     ( P_FK_RODOVIAS is not null) and (P_FK_RODOVIAS > 0)) then 
  begin
    select KC_TRECHOS_GERENCIAIS 
      from RODOVIAS
     where FK_EMPRESAS = :P_FK_EMPRESAS
       and PK_RODOVIAS = :P_FK_RODOVIAS
      into :R_PK_TRECHOS_GERENCIAIS;
    if ((R_PK_TRECHOS_GERENCIAIS is not null) and 
       ( R_PK_TRECHOS_GERENCIAIS >= 0)) then
    begin
      R_PK_TRECHOS_GERENCIAIS = R_PK_TRECHOS_GERENCIAIS + 1;
      update RODOVIAS set
             KC_TRECHOS_GERENCIAIS = :R_PK_TRECHOS_GERENCIAIS
       where FK_EMPRESAS = :P_FK_EMPRESAS
         and PK_RODOVIAS = :P_FK_RODOVIAS;
    end
  end
  suspend;
end ^

set term ;^;

grant execute on procedure STP_GET_KC_TRECHOS_GERENCIAIS to public;

set term ^;

create procedure STP_GET_KEY_FOR_ORD_SRV_ITEMS (
  P_FK_EMPRESAS        integer,
  P_PK_ORDENS_SERVICOS integer
)
returns (
  R_PK_ORDENS_SERVICOS_ITEMS smallint
)
as
begin
  R_PK_ORDENS_SERVICOS_ITEMS = -1;
  if (((P_FK_EMPRESAS is not null)        or (P_FK_EMPRESAS > 0))        and
     ((P_PK_ORDENS_SERVICOS is not null) or (P_PK_ORDENS_SERVICOS > 0))) then 
  begin
    select KEY_ITEMS 
      from ORDENS_SERVICOS
     where FK_EMPRESAS        = :P_FK_EMPRESAS
       and PK_ORDENS_SERVICOS = :P_PK_ORDENS_SERVICOS
      into :R_PK_ORDENS_SERVICOS_ITEMS;
    if (R_PK_ORDENS_SERVICOS_ITEMS is null) then
      R_PK_ORDENS_SERVICOS_ITEMS = -1;
    if (R_PK_ORDENS_SERVICOS_ITEMS >= 0) then
    begin
      R_PK_ORDENS_SERVICOS_ITEMS = R_PK_ORDENS_SERVICOS_ITEMS + 1;
      update ORDENS_SERVICOS set
             KEY_ITEMS          = :R_PK_ORDENS_SERVICOS_ITEMS
       where FK_EMPRESAS        = :P_FK_EMPRESAS
         and PK_ORDENS_SERVICOS = :R_PK_ORDENS_SERVICOS_ITEMS;
    end
  end
  suspend;
end ^

set term ;^;

grant execute on procedure STP_GET_KEY_FOR_ORD_SRV_ITEMS to public;

set term ^;

create procedure STP_GET_KEY_FOR_PRACAS (
  P_FK_EMPRESAS integer
)
returns (
  R_PK_PRACAS smallint
)
as
begin
  R_PK_PRACAS = -1;
  if ((P_FK_EMPRESAS is not null) or (P_FK_EMPRESAS > 0)) then 
  begin
    select KEY_PRACAS 
      from PARAMETROS_SRV
     where FK_EMPRESAS = :P_FK_EMPRESAS
      into :R_PK_PRACAS;
    if ((R_PK_PRACAS is null) or (R_PK_PRACAS = -1)) then
    begin
      insert into PARAMETROS_SRV
        (FK_EMPRESAS, FK_TIPO_STATUS_OS, FK_TIPO_ORDENS_SERVICOS,
         FLAG_EDTSRV, FLAG_EDTCOMP, FLAG_EDTVAL_ABRT, KEY_RODOVIAS,
         KEY_PRACAS)
      values
        (:P_FK_EMPRESAS, null, null, 0, 0, 1, 0, 0);
      R_PK_PRACAS = 0;
    end
    R_PK_PRACAS = R_PK_PRACAS + 1;
    update PARAMETROS_SRV set
           KEY_PRACAS  = :R_PK_PRACAS
     where FK_EMPRESAS = :P_FK_EMPRESAS;
  end
  suspend;
end ^

set term ;^;

grant execute on procedure STP_GET_KEY_FOR_PRACAS to public;

set term ^;

create procedure STP_GET_KEY_FOR_RODOVIAS (
  P_FK_EMPRESAS integer
)
returns (
  R_PK_RODOVIAS smallint
)
as
begin
  R_PK_RODOVIAS = -1;
  if ((P_FK_EMPRESAS is not null) or (P_FK_EMPRESAS > 0)) then 
  begin
    select KEY_RODOVIAS 
      from PARAMETROS_SRV
     where FK_EMPRESAS = :P_FK_EMPRESAS
      into :R_PK_RODOVIAS;
    if ((R_PK_RODOVIAS is null) or (R_PK_RODOVIAS = -1)) then
    begin
      insert into PARAMETROS_SRV
        (FK_EMPRESAS, FK_TIPO_STATUS_OS, FK_TIPO_ORDENS_SERVICOS,
         FLAG_EDTSRV, FLAG_EDTCOMP, FLAG_EDTVAL_ABRT, KEY_RODOVIAS,
         KEY_PRACAS)
      values
        (:P_FK_EMPRESAS, null, null, 0, 0, 1, 0, 0);
      R_PK_RODOVIAS = 0;
    end
    R_PK_RODOVIAS = R_PK_RODOVIAS + 1;
    update PARAMETROS_SRV set
           KEY_RODOVIAS = :R_PK_RODOVIAS
     where FK_EMPRESAS = :P_FK_EMPRESAS;
  end
  suspend;
end ^

set term ;^;

grant execute on procedure STP_GET_KEY_FOR_RODOVIAS to public;

set term ^;

create procedure STP_GET_PK_ORDENS_SERVICOS (
  P_FK_EMPRESAS        integer,
  P_FK_TIPO_DOCUMENTOS integer
)
returns (
  R_PK_ORDENS_SERVICOS smallint
)
as
begin
  R_PK_ORDENS_SERVICOS = null;
  if ((P_FK_EMPRESAS        is not null) and (P_FK_EMPRESAS       > 0)   and
     ( P_FK_TIPO_DOCUMENTOS is not null) and (P_FK_TIPO_DOCUMENTOS > 0)) then
  begin
    select NUM_DOC from TIPO_DOCUMENTOS_NUMERACAO
     where FK_EMPRESAS        = :P_FK_EMPRESAS
       and FK_TIPO_DOCUMENTOS = :P_FK_TIPO_DOCUMENTOS
      into :R_PK_ORDENS_SERVICOS;
    if (R_PK_ORDENS_SERVICOS is null) then
    begin
      insert into TIPO_DOCUMENTOS_NUMERACAO
        (FK_EMPRESAS, FK_TIPO_DOCUMENTOS, NUM_DOC)
      values
        (:P_FK_EMPRESAS, :P_FK_TIPO_DOCUMENTOS, 0);
      R_PK_ORDENS_SERVICOS = 0;
    end
    R_PK_ORDENS_SERVICOS = R_PK_ORDENS_SERVICOS + 1;
    update TIPO_DOCUMENTOS_NUMERACAO set
           NUM_DOC = :R_PK_ORDENS_SERVICOS
     where FK_EMPRESAS        = :P_FK_EMPRESAS
       and FK_TIPO_DOCUMENTOS = :P_FK_TIPO_DOCUMENTOS;
  end
  suspend;
end ^

set term ;^

grant execute on procedure STP_GET_PK_ORDENS_SERVICOS to public;


set term ^;

create procedure STP_GET_SERVICES_WITH_INSUMOS
returns (
  R_PK_PRODUTOS      integer,
  R_FK_INSUMOS       integer,
  R_FK_UNIDADES      integer,
  R_COD_REF          varchar(30),
  R_FK_CLASSIFICACAO integer,
  R_DSC_PROD         varchar(60),
  R_FLAG_QTD         smallint,
  R_FLAG_ALT         smallint,
  R_FLAG_LARG        smallint,
  R_FLAG_COMP        smallint,
  R_VLR_UNIT         numeric(9, 4),
  R_QTD_INS          numeric(9, 4),
  R_CFC_CONV         numeric(9, 4),
  R_SEQ_INS          integer,
  R_FLAG_TINS        smallint,
  R_FLAG_DEF         smallint,
  R_FLAG_TUNI        smallint,
  R_FLAG_FUNI        smallint,
  R_MED_DEF          numeric(9,4)
)
as
begin
  for select PK_PRODUTOS, COD_REF, FK_CLASSIFICACAO,
             DSC_PROD, FLAG_QTD, FLAG_ALT, FLAG_LARG,
             FLAG_COMP, QTD_UNI, VLR_UNIT, FLAG_TUNI,
             FLAG_FUNI, PK_UNIDADES
        from VW_SERVICES
       order by DSC_PROD
        into :R_PK_PRODUTOS, :R_COD_REF, :R_FK_CLASSIFICACAO,
             :R_DSC_PROD, :R_FLAG_QTD, :R_FLAG_ALT, :R_FLAG_LARG,
             :R_FLAG_COMP, :R_CFC_CONV, :R_VLR_UNIT, :R_FLAG_TUNI,
             :R_FLAG_FUNI, :R_FK_UNIDADES do
  begin
    R_FLAG_TINS = -1;
    suspend;
    for select FLAG_TCOMP, FK_INSUMOS, QTD_PROD, SEQ_COMP, FLAG_DEF,
               MED_DEF
          from PRODUTOS_COMPOSICOES
         where FK_PRODUTOS = :R_PK_PRODUTOS
         order by SEQ_COMP
          into :R_FLAG_TINS, :R_FK_INSUMOS, :R_QTD_INS, :R_SEQ_INS,
               :R_FLAG_DEF, :R_MED_DEF do
    begin
      R_PK_PRODUTOS = 0;
      R_DSC_PROD    = '';
      R_COD_REF     = '';
      R_FLAG_QTD    = 0;
      R_FLAG_ALT    = 0;
      R_FLAG_LARG   = 0;
      R_FLAG_COMP   = 0;
      R_CFC_CONV    = 0.0;
      R_VLR_UNIT    = 0.0;
      if (R_FLAG_TINS = 0) then
      begin
        select PK_PRODUTOS, DSC_PROD, COD_REF, FLAG_QTD,
               FLAG_ALT, FLAG_LARG, FLAG_COMP,
               QTD_UNI, VLR_UNIT, PK_UNIDADES
          from VW_ATIVIDADES
         where PK_PRODUTOS = :R_FK_INSUMOS
          into :R_PK_PRODUTOS, :R_DSC_PROD, :R_COD_REF,
               :R_FLAG_QTD, :R_FLAG_ALT, :R_FLAG_LARG,
               :R_FLAG_COMP, :R_CFC_CONV, :R_VLR_UNIT,
               :R_FK_UNIDADES;
      end
      if (R_FLAG_TINS = 1) then
      begin
        select PK_PRODUTOS, DSC_PROD, COD_REF, FLAG_QTD,
               FLAG_ALT, FLAG_LARG, FLAG_COMP,
               QTD_UNI, VLR_UNIT, PK_UNIDADES
          from VW_MATERIAL
         where PK_PRODUTOS = :R_FK_INSUMOS
          into :R_PK_PRODUTOS, :R_DSC_PROD, :R_COD_REF,
               :R_FLAG_QTD, :R_FLAG_ALT, :R_FLAG_LARG,
               :R_FLAG_COMP, :R_CFC_CONV, :R_VLR_UNIT,
               :R_FK_UNIDADES;
      end
      suspend;
    end
  end
end ^

set term ;^

grant execute on procedure STP_GET_SERVICES_WITH_INSUMOS to public;


set term ^;

create procedure STP_INSERT_PREVISION_FROM_OS (
  P_FK_EMPRESAS             integer ,
  P_FK_TIPO_ORDENS_SERVICOS smallint,
  P_PK_ORDENS_SERVICOS      integer,
  P_DTA_LAN                 date,
  P_VLR_LAN                 numeric (11, 4),
  P_NUM_PARC                smallint,
  P_TOT_PARC                smallint,
  P_QTD_PARC                smallint
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
  declare variable DscOS               varchar(50);
  declare variable DtaLan              date;
  declare variable PkContasLancamentos integer;
  declare variable PkTipoDocumentos    smallint;
  declare variable TypeLan             smallint;
  declare variable FlagES              smallint;
  declare variable DscLan              varchar(50);
begin
  R_STATUS = -1;
  TypeLan  = 0;
  if ((P_FK_EMPRESAS             is not null) and (P_FK_EMPRESAS             > 0)  and
     ( P_FK_TIPO_ORDENS_SERVICOS is not null) and (P_FK_TIPO_ORDENS_SERVICOS > 0)  and
     ( P_DTA_LAN                 is not null) and
     ( P_VLR_LAN                 is not null) and (P_VLR_LAN                 > 0)  and
     ( P_PK_ORDENS_SERVICOS      is not null) and (P_PK_ORDENS_SERVICOS      > 0)) then
  begin
    select Tdc.PK_TIPO_DOCUMENTOS, Tdc.FLAG_TDOC, Grm.FLAG_ES
      from TIPO_ORDENS_SERVICOS Tos, TIPO_DOCUMENTOS Tdc,
           GRUPOS_MOVIMENTOS Grm
     where Tos.PK_TIPO_ORDENS_SERVICOS = :P_FK_TIPO_ORDENS_SERVICOS
       and Tdc.PK_TIPO_DOCUMENTOS      = Tos.FK_TIPO_DOCUMENTOS
       and Grm.PK_GRUPOS_MOVIMENTOS    = Tos.FK_GRUPOS_MOVIMENTOS
      into :PkTipoDocumentos, :FlagTDoc, :FlagES;
    select FK_TIPO_CONTAS, FK_CONTAS
      from PARAMETROS
     where FK_EMPRESAS = :P_FK_EMPRESAS
      into :FkTipoContas, :FkContas;
    if ((FkTipoContas is null) or (FkTipoContas = 0)  or
       ( FkContas     is null) or (FkContas     = 0)) then
      exit;
    select FK_CADASTROS, Cast(DSC_ORD as varchar(50))
      from ORDENS_SERVICOS
     where FK_EMPRESAS        = :P_FK_EMPRESAS
       and PK_ORDENS_SERVICOS = :P_PK_ORDENS_SERVICOS
      into :FkCadastros, :DscLan;
    if ((FkCadastros is null) or (FkCadastros = 0)  or
       ( DscLan      is null)) then
      exit;
    DscOS = Cast(DscLan as varchar(33));
    select R_PK_CONTAS_LANCAMENTOS from STP_GET_KC_CONTAS_LANCAMENTOS (
           :P_FK_EMPRESAS)
      into PkContasLancamentos;
    if ((PkContasLancamentos is null) or (PkContasLancamentos = 0)) then
      exit;
    DscOS = DscOS || ' Parcela: ' || Cast(P_NUM_PARC as varchar(3)) || '/' ||
            Cast(P_TOT_PARC as varchar(3));
    insert into CONTAS_LANCAMENTOS
      (FK_EMPRESAS, PK_CONTAS_LANCAMENTOS, FK_EMPRESAS__CTA, FK_TIPO_CONTAS, 
       FK_CONTAS, FK_FINALIZADORAS, FK_OPERACOES_FINANCEIRAS, FK_CADASTROS,
       FK_HITORICOS_PADRAO, DSC_LAN, DTA_LAN, VLR_LAN, FLAG_DBCR)
    values
      (:P_FK_EMPRESAS, :PkContasLancamentos, :P_FK_EMPRESAS, :FkTipoContas, 
       :FkContas,  null, null, :FkCadastros, null, :DscOS, :P_DTA_LAN, 
       :P_VLR_LAN, :FLagES);
/* insert or update data to generic document table */
    if (FlagTDoc is null) then exit;
    TypeLan = null;
    select FLAG_TDOC
      from VINCULO_DOCUMENTOS
     where FK_EMPRESAS        = :P_FK_EMPRESAS
       and FK_DOCUMENTOS      = :P_PK_ORDENS_SERVICOS
       and FK_CADASTROS       = :FkCadastros
       and FK_TIPO_DOCUMENTOS = :P_FK_TIPO_ORDENS_SERVICOS
      into :TypeLan;
    if (TypeLan is null) then
    begin
      TypeLan = 0;
      insert into VINCULO_DOCUMENTOS
        (FK_EMPRESAS, FK_DOCUMENTOS, FK_CADASTROS, FK_TIPO_DOCUMENTOS, FLAG_TDOC)
      values
        (:P_FK_EMPRESAS, :P_PK_ORDENS_SERVICOS, :FkCadastros,
         :P_FK_TIPO_ORDENS_SERVICOS, :FlagTDoc);
    end
/* insert a link between generic document and flow cash */
    insert into CONTAS_DOCUMENTOS
      (FK_EMPRESAS, FK_CONTAS_LANCAMENTOS, FK_DOCUMENTOS, FK_TIPO_DOCUMENTOS, 
       FK_CADASTROS, FLAG_TDOC)
    values
      (:P_FK_EMPRESAS, :PkContasLancamentos, :P_PK_ORDENS_SERVICOS, 
       :P_FK_TIPO_ORDENS_SERVICOS, :FkCadastros, :FlagTDoc);
/* insert links between generic document and finance classification */
    for select Osi.FK_CLASSIFICACAO, Osi.TOT_SRV, Os.DTA_OS, Os.FLAG_LPREV
          from ORDENS_SERVICOS Os, ORDENS_SERVICOS_ITENS Osi
         where Os.FK_EMPRESAS         = :P_FK_EMPRESAS
           and Os.PK_ORDENS_SERVICOS  = :P_PK_ORDENS_SERVICOS
           and Osi.FK_EMPRESAS        = Os.FK_EMPRESAS
           and Osi.FK_ORDENS_SERVICOS = Os.PK_ORDENS_SERVICOS
          into :FkClassificacao, :P_VLR_LAN, :DtaLan, :TypeLan do
    begin
      if ((P_QTD_PARC <= 0) and (TypeLan > 0)) then exit;
      if ((FkClassificacao is not null) and (FkClassificacao > 0)) then
      begin
        if (P_QTD_PARC > 0) then
          P_VLR_LAN  = P_VLR_LAN / P_QTD_PARC;
        else
          P_DTA_LAN = DtaLan;
        if (P_QTD_PARC > 0) then
          DscLan = DscOS;
        insert into CLASSIFICACAO_DOCUMENTOS
          (FK_EMPRESAS, FK_CLASSIFICACAO, FK_DOCUMENTOS, FK_TIPO_DOCUMENTOS,
           FK_CADASTROS, FLAG_TDOC, FLAG_PREV, DTA_LAN, VLR_LAN, DSC_LAN,
           PK_CLASSIFICACAO_DOCUMENTOS, FLAG_DBCR)
        values
          (:P_FK_EMPRESAS, :FkClassificacao, :P_PK_ORDENS_SERVICOS,
           :P_FK_TIPO_ORDENS_SERVICOS, :FkCadastros, :FlagTDoc, 1, :P_DTA_LAN,
           :P_VLR_LAN, :DscLan, 0, :FLagES);
        if ((P_QTD_PARC <= 0) and (TypeLan = 0)) then
        begin
          update ORDENS_SERVICOS set
                 FLAG_LPREV = 1
           where FK_EMPRESAS             = :P_FK_EMPRESAS
             and FK_TIPO_ORDENS_SERVICOS = :P_FK_TIPO_ORDENS_SERVICOS
             and PK_ORDENS_SERVICOS      = :P_PK_ORDENS_SERVICOS;
        end
      end
    end
    R_STATUS = 0;
  end
  suspend;
end ^

set term ;^;

grant EXECUTE on procedure STP_INSERT_PREVISION_FROM_OS to PUBLIC;


/*  Insert trigger "TBIG_LIMITES_MUNICIPIOS" for table "LIMITES_MUNICIPIOS"  */
set term ^;

create trigger TBIG_LIMITES_MUNICIPIOS for LIMITES_MUNICIPIOS
  before insert as
begin
  if ((New.PK_LIMITES_MUNICIPIOS is null) or (New.PK_LIMITES_MUNICIPIOS = 0)) then
  begin
    select R_PK_LIMITES_MUNICIPIOS 
      from STP_GET_KC_LIMITES_MUNICIPIOS(New.FK_EMPRESAS, New.FK_RODOVIAS)
      into New.PK_LIMITES_MUNICIPIOS;
    if (New.PK_LIMITES_MUNICIPIOS = -1) then
      New.PK_LIMITES_MUNICIPIOS = null;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
end^

set term ;^;


/*  Update trigger "TBU0_LIMITES_MUNICIPIOS" for table "LIMITES_MUNICIPIOS"  */
set term ^;

create trigger TBU0_LIMITES_MUNICIPIOS for LIMITES_MUNICIPIOS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  execute procedure STP_INSERT_HISTORIC ('LIMITES_MUNICIPIOS', 'LIMITES_MUNICIPIOS',
    'atualização de registro', 'UPD');
end^

set term ;^;


/*  Insert trigger "TBIG_ORDENS_SERVICOS" for table "ORDENS_SERVICOS"  */
set term ^;

create trigger TBIG_ORDENS_SERVICOS for ORDENS_SERVICOS
  before insert as
  declare variable FkTipoDocumentos integer;
begin
  if ((New.PK_ORDENS_SERVICOS is null) or (New.PK_ORDENS_SERVICOS = 0)) then
  begin
    select FK_TIPO_DOCUMENTOS 
      from TIPO_ORDENS_SERVICOS
     where PK_TIPO_ORDENS_SERVICOS = New.FK_TIPO_ORDENS_SERVICOS
      into :FkTipoDocumentos;
    select R_PK_ORDENS_SERVICOS 
      from STP_GET_PK_ORDENS_SERVICOS(New.FK_EMPRESAS, :FkTipoDocumentos)
      into New.PK_ORDENS_SERVICOS;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
end^

set term ;^;


/*  Update trigger "TBU0_ORDENS_SERVICOS" for table "ORDENS_SERVICOS"  */
set term ^;

create trigger TBU0_ORDENS_SERVICOS for ORDENS_SERVICOS
before update as
  declare variable PkContasLancamentos integer;
  declare variable FkTipoContas        smallint;
  declare variable FkContas            smallint;
  declare variable FlagTDoc            smallint;
begin
  if (((Old.FK_TIPO_PAGAMENTOS is not null)                          and
     (  New.FK_TIPO_PAGAMENTOS <> Old.FK_TIPO_PAGAMENTOS))           or
     (( Old.LST_PRZ is not null) and (New.LST_PRZ <> Old.LST_PRZ))   or 
     (( New.FK_TIPO_PAGAMENTOS > 0) and (New.DTA_LIQ is not null))   or
     (( New.FK_TIPO_PAGAMENTOS > 0) and (New.DTA_CANC is not null))) then
  begin
    /* select from table PARAMETROS default type account and account */
    select FK_TIPO_CONTAS, FK_CONTAS
      from PARAMETROS
     where FK_EMPRESAS = New.FK_EMPRESAS
      into :FkTipoContas, :FkContas;
    /* find type of documento */
    select Tdc.FLAG_TDOC
      from TIPO_ORDENS_SERVICOS Tos, TIPO_DOCUMENTOS Tdc
     where Tos.PK_TIPO_ORDENS_SERVICOS = New.FK_TIPO_ORDENS_SERVICOS
       and Tdc.PK_TIPO_DOCUMENTOS      = Tos.FK_TIPO_DOCUMENTOS
      into :FlagTDoc;
    /* delete all records from CONTAS_LANCAMENTOS of old installments */
    for select FK_CONTAS_LANCAMENTOS from CONTAS_DOCUMENTOS
         where FK_EMPRESAS        = New.FK_EMPRESAS
           and FK_DOCUMENTOS      = New.PK_ORDENS_SERVICOS
           and FK_TIPO_DOCUMENTOS = New.FK_TIPO_ORDENS_SERVICOS
           and FK_CADASTROS       = New.FK_CADASTROS
           and FLAG_TDOC          = :FlagTDoc
          into :PkContasLancamentos do
    begin
      delete from CONTAS_DOCUMENTOS
       where FK_EMPRESAS           = New.FK_EMPRESAS
         and FK_DOCUMENTOS         = New.PK_ORDENS_SERVICOS
         and FK_TIPO_DOCUMENTOS    = New.FK_TIPO_ORDENS_SERVICOS
         and FK_CADASTROS          = New.FK_CADASTROS
         and FK_CONTAS_LANCAMENTOS = :PkContasLancamentos;
      delete from CONTAS_LANCAMENTOS
       where FK_EMPRESAS           = New.FK_EMPRESAS
         and FK_EMPRESAS__CTA      = New.FK_EMPRESAS
         and FK_TIPO_CONTAS        = :FkTipoContas
         and FK_CONTAS             = :FkContas
         and PK_CONTAS_LANCAMENTOS = :PkContasLancamentos;
    end
    /* delete all records from VINCULOS_DOCUMENTOS that delete automaticaly 
       all records from  tables CONTAS_DOCUMENTOS and CLASSIFICACAO_LANCAMENTOS */
    delete from VINCULO_DOCUMENTOS
     where FK_EMPRESAS        = New.FK_EMPRESAS
       and FK_DOCUMENTOS      = New.PK_ORDENS_SERVICOS
       and FK_CADASTROS       = New.FK_CADASTROS
       and FK_TIPO_DOCUMENTOS = New.FK_TIPO_ORDENS_SERVICOS;
  end
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
end^

set term ;^;


/*  Insert trigger "TBIG_ORDENS_SERVICOS_ITENS" for table "ORDENS_SERVICOS_ITENS"  */
set term ^;

create trigger TBIG_ORDENS_SERVICOS_ITENS for ORDENS_SERVICOS_ITENS
before insert as
begin
  if ((New.PK_ORDENS_SERVICOS_ITENS is null) or (New.PK_ORDENS_SERVICOS_ITENS = 0)) then
  begin
    select R_PK_ORDENS_SERVICOS_ITEMS
      from STP_GET_KEY_FOR_ORD_SRV_ITEMS(New.FK_EMPRESAS, New.FK_ORDENS_SERVICOS)
      into New.PK_ORDENS_SERVICOS_ITENS;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
end^

set term ;^;


/*  Update trigger "TBU0_ORDENS_SERVICOS_ITENS" for table "ORDENS_SERVICOS_ITENS"  */
set term ^;

create trigger TBU0_ORDENS_SERVICOS_ITENS for ORDENS_SERVICOS_ITENS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  execute procedure STP_INSERT_HISTORIC ('ORDENS_SERVICOS_ITENS', 'ORDENS_SERVICOS_ITENS',
    'atualização de registro', 'UPD');
end^

set term ;^;


/*  Update trigger "TBU0_ORDENS_SERVICOS_ITENS_INS" for table "ORDENS_SERVICOS_ITENS_INSUMO"  */
set term ^;

create trigger TBU0_ORDENS_SERVICOS_ITENS_INS for ORDENS_SERVICOS_ITENS_INSUMO
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  execute procedure STP_INSERT_HISTORIC ('ORDENS_SERVICOS_ITENS_INSUMO', 'ORDENS_SERVICOS_ITENS_INSUMO',
    'atualização de registro', 'UPD');
end^

set term ;^;


/*  Update trigger "TBU0_ORDENS_SERVICOS_ITENS_LOCA" for table "ORDENS_SERVICOS_ITENS_LOCAL"  */
set term ^;

create trigger TBU0_ORDENS_SERVICOS_ITENS_LOCA for ORDENS_SERVICOS_ITENS_LOCAL
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  execute procedure STP_INSERT_HISTORIC ('ORDENS_SERVICOS_ITENS_LOCAL', 'ORDENS_SERVICOS_ITENS_LOCAL',
    'atualização de registro', 'UPD');
end^

set term ;^;


/*  Update trigger "TBU0_OS_HISTORICOS" for table "OS_HISTORICOS"  */
set term ^;

create trigger TBU0_OS_HISTORICOS for OS_HISTORICOS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  execute procedure STP_INSERT_HISTORIC ('OS_HISTORICOS', 'OS_HISTORICOS',
    'atualização de registro', 'UPD');
end^

set term ;^;


/*  Update trigger "TBU0_PARAMETROS_SRV" for table "PARAMETROS_SRV"  */
set term ^;

create trigger TBU0_PARAMETROS_SRV for PARAMETROS_SRV
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  execute procedure STP_INSERT_HISTORIC ('PARAMETROS_SRV', 'PARAMETROS_SRV',
    'atualização de registro', 'UPD');
end^

set term ;^;


/*  Insert trigger "TBIG_PRACAS" for table "PRACAS"  */
set term ^;

create trigger TBIG_PRACAS for PRACAS
before insert as
begin
  if ((New.PK_PRACAS is null) or (New.PK_PRACAS = 0)) then
  begin
    select R_PK_PRACAS
      from STP_GET_KEY_FOR_PRACAS(New.FK_EMPRESAS)
      into New.PK_PRACAS;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
end^

set term ;^;


/*  Update trigger "TBU0_PRACAS" for table "PRACAS"  */
set term ^;

create trigger TBU0_PRACAS for PRACAS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  execute procedure STP_INSERT_HISTORIC ('PRACAS', 'PRACAS',
    'atualização de registro', 'UPD');
end^

set term ;^;


/*  Insert trigger "TBIG_RODOVIAS" for table "RODOVIAS"  */
set term ^;

create trigger TBIG_RODOVIAS for RODOVIAS
before insert as
begin
  if ((New.PK_RODOVIAS is null) or (New.PK_RODOVIAS = 0)) then
  begin
    select R_PK_RODOVIAS 
      from STP_GET_KEY_FOR_RODOVIAS(New.FK_EMPRESAS)
      into New.PK_RODOVIAS;
  end
  New.KC_TRECHOS_GERENCIAIS = 0;
  New.KC_LIMITES_MUNICIPIOS = 0;
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
end^

set term ;^;


/*  Update trigger "TBU0_RODOVIAS" for table "RODOVIAS"  */
set term ^;

create trigger TBU0_RODOVIAS for RODOVIAS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  execute procedure STP_INSERT_HISTORIC ('RODOVIAS', 'RODOVIAS',
    'atualização de registro', 'UPD');
end^

set term ;^;


/*  Insert trigger "TBIG_TIPO_ORDENS_SERVICOS" for table "TIPO_ORDENS_SERVICOS"  */
set term ^;

create trigger TBIG_TIPO_ORDENS_SERVICOS for TIPO_ORDENS_SERVICOS
before insert as
begin
  if ((New.PK_TIPO_ORDENS_SERVICOS is null) or (New.PK_TIPO_ORDENS_SERVICOS = 0)) then
    New.PK_TIPO_ORDENS_SERVICOS = Gen_Id(TIPO_ORDENS_SERVICOS, 1);
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
  execute procedure STP_INSERT_HISTORIC ('TIPO_ORDENS_SERVICOS', 'TIPO_ORDENS_SERVICOS',
    'inserção de registro', 'INC');
end^

set term ;^;


/*  Update trigger "TBU0_TIPO_ORDENS_SERVICOS" for table "TIPO_ORDENS_SERVICOS"  */
set term ^;

create trigger TBU0_TIPO_ORDENS_SERVICOS for TIPO_ORDENS_SERVICOS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  execute procedure STP_INSERT_HISTORIC ('TIPO_ORDENS_SERVICOS', 'TIPO_ORDENS_SERVICOS',
    'atualização de registro', 'UPD');
end^

set term ;^;


/*  Insert trigger "TBIG_TIPO_STATUS_OS" for table "TIPO_STATUS_OS"  */
set term ^;

create trigger TBIG_TIPO_STATUS_OS for TIPO_STATUS_OS
before insert as
begin
  if ((New.PK_TIPO_STATUS_OS is null) or (New.PK_TIPO_STATUS_OS = 0)) then
    New.PK_TIPO_STATUS_OS = Gen_Id(TIPO_STATUS_OS, 1);
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
  execute procedure STP_INSERT_HISTORIC ('TIPO_STATUS_OS', 'TIPO_STATUS_OS',
    'inserção de registro', 'INC');
end^

set term ;^;


/*  Update trigger "TBU0_TIPO_STATUS_OS" for table "TIPO_STATUS_OS"  */
set term ^;

create trigger TBU0_TIPO_STATUS_OS for TIPO_STATUS_OS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  execute procedure STP_INSERT_HISTORIC ('TIPO_STATUS_OS', 'TIPO_STATUS_OS',
    'atualização de registro', 'UPD');
end^

set term ;^;


/*  Insert trigger "TBIG_TRECHOS_GERENCIAIS" for table "TRECHOS_GERENCIAIS"  */
set term ^;

create trigger TBIG_TRECHOS_GERENCIAIS for TRECHOS_GERENCIAIS
  before insert as
begin
  if ((New.PK_TRECHOS_GERENCIAIS is null) or (New.PK_TRECHOS_GERENCIAIS = 0)) then
  begin
    select R_PK_TRECHOS_GERENCIAIS 
      from STP_GET_KC_TRECHOS_GERENCIAIS(New.FK_EMPRESAS, New.FK_RODOVIAS)
      into New.PK_TRECHOS_GERENCIAIS;
    if (New.PK_TRECHOS_GERENCIAIS = -1) then
      New.PK_TRECHOS_GERENCIAIS = null;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
end^

set term ;^;


/*  Update trigger "TBU0_TRECHOS_GERENCIAIS" for table "TRECHOS_GERENCIAIS"  */
set term ^;

create trigger TBU0_TRECHOS_GERENCIAIS for TRECHOS_GERENCIAIS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  execute procedure STP_INSERT_HISTORIC ('TRECHOS_GERENCIAIS', 'TRECHOS_GERENCIAIS',
    'atualização de registro', 'UPD');
end^

set term ;^;

