/*==============================================================*/
/* Database name:  PROCESSA                                     */
/* DBMS name:      Friebird15x                                  */
/* Created on:     11/9/2006 11:26:51                           */
/*==============================================================*/



set term ^;

create procedure STP_GET_CONF_COMPO_TREF (
  P_FK_EMPRESAS         integer,
  P_FK_TABELA_PRECOS    smallint,
  P_FK_PRODUTOS         integer,
  P_FK_COMPONENTES      smallint,
  P_FK_TIPO_REFERENCIAS integer,
  P_FK_TIPO_ACABAMENTOS integer
 )
returns (
  R_PRE_VDA             numeric(11, 4),
  R_QTD_PDR             numeric(09, 4),
  R_QTD_PERS            numeric(09, 4),
  R_PRE_UNT_PDR         numeric(09, 4),
  R_PRE_UNT_PERS        numeric(09, 4),
  R_TOT_INS_BXA         numeric(09, 4),
  R_TOT_INS_CLC         numeric(09, 4)
)
as
  declare variable PrecoUnitario double precision;
  declare variable FlagOutRange  smallint;
begin
  select Acp.PRE_VDA, Aca.QTD_PDR, Aca.QTD_PERS
    from TIPO_ACABAMENTOS Tac, ACABAMENTOS Aca,
         TIPO_REFERENCIAS Tre, ACABAMENTO_PRECOS Acp
   where Acp.FK_EMPRESAS         = :P_FK_EMPRESAS
     and Acp.fk_produtos         = Aca.FK_PRODUTOS
     and Acp.FK_TIPO_ACABAMENTOS = Tre.FK_TIPO_ACABAMENTOS
     and Acp.FK_TIPO_ACABAMENTOS = :P_FK_TIPO_ACABAMENTOS
     and Acp.FK_TIPO_REFERENCIAS = Tre.PK_TIPO_REFERENCIAS
     and Acp.FK_TIPO_REFERENCIAS = :P_FK_TIPO_REFERENCIAS
     and Acp.FK_TABELA_PRECOS    = :P_FK_TABELA_PRECOS
     and Aca.FK_PRODUTOS         = :P_FK_PRODUTOS
     and ((Aca.FK_COMPONENTES    = :P_FK_COMPONENTES)
      or (0                      = :P_FK_COMPONENTES))
     and Tac.PK_TIPO_ACABAMENTOS = Aca.FK_TIPO_ACABAMENTOS
     and Tre.FK_TIPO_ACABAMENTOS = Aca.FK_TIPO_ACABAMENTOS
    order by Tac.DSC_ACABM, Tre.DSC_REF
     into :R_PRE_VDA, :R_QTD_PDR, :R_QTD_PERS;
    if (R_PRE_VDA is null) then
      R_PRE_VDA = 0;
    if (R_QTD_PDR is null) then
      R_QTD_PDR = 0;
    if (R_QTD_PERS is null) then
      R_QTD_PERS = 0;
    FlagOutRange = 0;
    select sum(Aca.QTD_PDR * Cmp.QTD_COMP),
           sum(Aca.QTD_PDR * Cmp.QTD_COMP)
      from ACABAMENTOS Aca, COMPONENTES Cmp
     where Cmp.FK_PRODUTOS         = :P_FK_PRODUTOS
       and Aca.FK_PRODUTOS         = Cmp.FK_PRODUTOS
       and Aca.FK_COMPONENTES      = Cmp.FK_TIPO_COMPONENTES
       and Aca.FK_TIPO_ACABAMENTOS = :P_FK_TIPO_ACABAMENTOS
      into :R_TOT_INS_BXA, :R_TOT_INS_CLC;
    if ((R_TOT_INS_BXA is null) or (R_TOT_INS_BXA = 0) or
       ( R_TOT_INS_CLC is null) or (R_TOT_INS_CLC = 0)) then
    begin
      R_TOT_INS_BXA = 1;
      R_TOT_INS_CLC = 1;
      FlagOutRange  = -1;
    end
    PrecoUnitario  = R_PRE_VDA     / R_TOT_INS_CLC;
    R_PRE_UNT_PERS = PrecoUnitario * R_QTD_PERS;
    PrecoUnitario  = R_PRE_VDA     / R_TOT_INS_BXA;
    R_PRE_UNT_PDR  = PrecoUnitario * R_QTD_PDR;
    if (FlagOutRange = -1) then
    begin
      R_TOT_INS_BXA = 0;
      R_TOT_INS_CLC = 0;
    end
    suspend;
end^

set term ;^;

grant EXECUTE on procedure STP_GET_CONF_COMPO_TREF to PUBLIC;


set term ^;

create procedure STP_GET_ORDER_ITEMS (
    P_FK_EMPRESAS     integer,
    P_FK_PEDIDOS      integer
)
returns (
    R_FK_EMPRESAS          integer,
    R_FK_PEDIDOS           integer,
    R_FK_PRODUTOS          integer,
    R_FK_FINANCEIRO_CONTAS integer,
    R_FK_CARGAS_PRODUCAO   integer,
    R_PK_PEDIDOS_ITENS     smallint,
    R_FK_LOTACOES          smallint,
    R_FK_ALMOXARIFADOS     smallint,
    R_FK_TABELA_PRECOS     smallint,
    R_FK_UNIDADES          smallint,
    R_FK_TIPO_MOVIMENTOS   smallint,
    R_FK_GRUPOS_MOVIMENTOS smallint,
    R_COD_ISS_ECF          smallint,
    R_COD_ICMS_ECF         smallint,
    R_COD_ICMSS_ECF        smallint,
    R_COD_IPI_ECF          smallint,
    R_COD_OTR_ECF          smallint,
    R_FLAG_CONF            smallint,
    R_FLAG_PRM             smallint,
    R_FLAG_PEND            smallint,
    R_FLAG_SRV             smallint,
    R_FLAG_BXASTT          smallint,
    R_REF_PRODUTO          varchar(20),
    R_DSC_PROD             varchar(50),
    R_MNMO_UNI             varchar(02),
    R_DSC_TAB              varchar(30),
    R_DSC_UNI              varchar(30),
    R_DSC_TMOV             varchar(30),
    R_DSC_GMOV             varchar(30),
    R_DSC_ALMX             varchar(30),
    R_DSC_CTA              varchar(50),
    R_SIT_TRIB             varchar(03),
    R_LOT_ITEM             varchar(10),
    R_RUA_LOT              varchar(10),
    R_BOX_LOT              varchar(10),
    R_NIVEL_LOT            varchar(10),
    R_NUM_EXT              varchar(20),
    R_QTD_ITEM             numeric(09, 04),
    R_VLR_UNIT             numeric(09, 04),
    R_TOT_ITEM             numeric(09, 04),
    R_ALQ_ISS              numeric(05, 02),
    R_ALQ_ICMS             numeric(05, 02),
    R_ALQ_ICMSS            numeric(05, 02),
    R_ALQ_IPI              numeric(05, 02),
    R_ALQ_OTR              numeric(05, 02),
    R_VLR_ACR_DSCT         numeric(09, 04),
    R_VLR_TAB              numeric(09, 04),
    R_SUB_TOT              numeric(11, 04),
    R_DTA_LIQ              date,
    R_DTA_FAT              date,
/* Produto Configurator Data */
    R_PK_PEDIDOS_ITENS_CONF smallint,
    R_FK_COMPONENTES        smallint,
    R_FK_ACABAMENTOS        smallint,
    R_FK_TIPO_REFERENCIAS   smallint,
    R_FK_TIPO_DOCUMENTOS    smallint,
    R_QTD_COMP              smallint,
    R_QTD_COMP_TOT          smallint,
    R_FLAG_FRNCLI           smallint,
    R_FLAG_PEND_C           smallint,
    R_FLAG_CNTR             smallint,
    R_FLAG_BXASTT_C         smallint,
    R_FK_INSUMOS            integer,
    R_NUM_DOC_LIB           integer,
    R_COD_REF               varchar(20),
    R_DSC_CONF              varchar(50),
    R_DSC_INS               varchar(50),
    R_VLR_ITM               numeric(09, 04),
    R_QTD_INS               numeric(09, 04),
    R_PER_DSCT_INS          numeric(05, 02)
)
as
  declare variable DscTComp varchar(30);
  declare variable DscAcabm varchar(30);
  declare variable DscRef   varchar(30);
begin
  for select Pit.PK_PEDIDOS_ITENS, Pit.FLAG_PEND, Pit.REF_PRODUTO,
             Pit.QTD_ITEM, Pit.VLR_TAB, Pit.VLR_UNIT, Pit.TOT_ITEM,
             Pit.FLAG_PRM, Pit.SIT_TRIB, Pit.LOT_ITEM, Pit.FK_EMPRESAS,
             Pit.FK_PEDIDOS, Pit.FK_GRUPOS_MOVIMENTOS, Pit.FK_LOTACOES, 
             Pit.FK_TIPO_MOVIMENTOS, Pit.FK_TABELA_PRECOS, Pit.FK_UNIDADES, 
             Pit.FK_ALMOXARIFADOS, Pit.FK_FINANCEIRO_CONTAS, Pit.ALQ_ISS, 
             Pit.ALQ_ICMS, Pit.ALQ_ICMSS, Pit.ALQ_IPI, Pit.ALQ_OTR, 
             Pit.COD_ISS_ECF, Pit.COD_ICMS_ECF, Pit.DTA_LIQ,
             Pit.COD_ICMSS_ECF, Pit.COD_IPI_ECF, Pit.COD_OTR_ECF,
             Pit.FLAG_SRV, Pit.FLAG_CONF, Pit.DTA_FAT, Pit.NUM_EXT,
             Pit.FLAG_BXASTT, Pit.VLR_ACR_DSCT, Pit.SUB_TOT,
             Pit.FK_PRODUTOS, Pit.FK_CARGAS_PRODUCAO, Prd.DSC_PROD,
             Uni.DSC_UNI, Uni.MNMO_UNI, Alm.DSC_ALMX, Lot.RUA_LOT,
             Lot.BOX_LOT, Lot.NIVEL_LOT, Tpr.DSC_TAB, Gmv.DSC_GMOV,
             Fct.DSC_CTA, Tmv.DSC_TMOV
        from PEDIDOS_ITENS Pit
        join PRODUTOS Prd
          on Prd.PK_PRODUTOS            = Pit.FK_PRODUTOS
        join GRUPOS_MOVIMENTOS Gmv
          on Gmv.PK_GRUPOS_MOVIMENTOS   = Pit.FK_GRUPOS_MOVIMENTOS
        join TIPO_MOVIMENTOS Tmv
          on Tmv.FK_GRUPOS_MOVIMENTOS   = Pit.FK_GRUPOS_MOVIMENTOS
         and Tmv.PK_TIPO_MOVIMENTOS     = Pit.FK_TIPO_MOVIMENTOS
        join UNIDADES Uni
          on Uni.PK_UNIDADES            = Pit.FK_UNIDADES
        left outer join TABELA_PRECOS Tpr
          on Tpr.PK_TABELA_PRECOS       = Pit.FK_TABELA_PRECOS
        left outer join ALMOXARIFADOS Alm
          on Alm.PK_ALMOXARIFADOS       = Pit.FK_ALMOXARIFADOS
        left outer join LOTACOES Lot
          on Lot.FK_EMPRESAS            = Pit.FK_EMPRESAS
         and Lot.FK_ALMOXARIFADOS       = Pit.FK_ALMOXARIFADOS
         and Lot.PK_LOTACOES            = Pit.FK_LOTACOES
        left outer join FINANCEIRO_CONTAS Fct
          on Fct.PK_FINANCEIRO_CONTAS   = Pit.FK_FINANCEIRO_CONTAS
       where Pit.FK_EMPRESAS            = :P_FK_EMPRESAS
         and Pit.FK_PEDIDOS             = :P_FK_PEDIDOS
       order by Pit.FK_EMPRESAS, Pit.FK_PEDIDOS, Pit.PK_PEDIDOS_ITENS
        into :R_PK_PEDIDOS_ITENS, :R_FLAG_PEND, :R_REF_PRODUTO,
             :R_QTD_ITEM, :R_VLR_TAB, :R_VLR_UNIT, :R_TOT_ITEM,
             :R_FLAG_PRM, :R_SIT_TRIB, :R_LOT_ITEM, :R_FK_EMPRESAS,
             :R_FK_PEDIDOS, :R_FK_GRUPOS_MOVIMENTOS, :R_FK_LOTACOES, 
             :R_FK_TIPO_MOVIMENTOS, :R_FK_TABELA_PRECOS, :R_FK_UNIDADES, 
             :R_FK_ALMOXARIFADOS, :R_FK_FINANCEIRO_CONTAS, :R_ALQ_ISS, 
             :R_ALQ_ICMS, :R_ALQ_ICMSS, :R_ALQ_IPI, :R_ALQ_OTR, 
             :R_COD_ISS_ECF, :R_COD_ICMS_ECF, :R_DTA_LIQ,
             :R_COD_ICMSS_ECF, :R_COD_IPI_ECF, :R_COD_OTR_ECF,
             :R_FLAG_SRV, :R_FLAG_CONF, :R_DTA_FAT, :R_NUM_EXT,
             :R_FLAG_BXASTT, :R_VLR_ACR_DSCT, :R_SUB_TOT,
             :R_FK_PRODUTOS, :R_FK_CARGAS_PRODUCAO, :R_DSC_PROD,
             :R_DSC_UNI, :R_MNMO_UNI, :R_DSC_ALMX, :R_RUA_LOT,
             :R_BOX_LOT, :R_NIVEL_LOT, :R_DSC_TAB, :R_DSC_GMOV,
             :R_DSC_CTA, :R_DSC_TMOV do
  begin
    R_PK_PEDIDOS_ITENS_CONF = null;
    R_FK_INSUMOS            = null;
    R_FK_COMPONENTES        = null;
    R_FK_ACABAMENTOS        = null;
    R_FK_TIPO_REFERENCIAS   = null;
    R_FK_TIPO_DOCUMENTOS    = null;
    R_COD_REF               = null;
    R_VLR_ITM               = null;
    R_QTD_COMP              = null;
    R_QTD_COMP_TOT          = null;
    R_QTD_INS               = null;
    R_FLAG_FRNCLI           = null;
    R_FLAG_PEND_C           = null;
    R_FLAG_CNTR             = null;
    R_FLAG_BXASTT_C         = null;
    R_NUM_DOC_LIB           = null;
    R_PER_DSCT_INS          = null;
    DscTComp                = null;
    DscAcabm                = null;
    DscRef                  = null;
    R_DSC_INS               = null;
    R_DSC_CONF              = null;
    suspend;
    if (:R_FLAG_CONF > 0) then
    begin
      for select Pcf.PK_PEDIDOS_ITENS_CONF, Pcf.FK_INSUMOS,
                 Pcf.FK_COMPONENTES, Pcf.FK_ACABAMENTOS,
                 Pcf.FK_TIPO_REFERENCIAS, Pcf.FK_TIPO_DOCUMENTOS,
                 Pcf.COD_REF, Pcf.VLR_ITM, Pcf.QTD_COMP,
                 Pcf.QTD_COMP_TOT, Pcf.QTD_INS, Pcf.FLAG_FRNCLI,
                 Pcf.FLAG_PEND, Pcf.FLAG_CNTR, Pcf.FLAG_BXASTT,
                 Pcf.NUM_DOC_LIB, Pcf.PER_DSCT_INS, Tcm.DSC_TCOMP,
                 Tca.DSC_ACABM, Trf.DSC_REF, Prd.DSC_PROD
            from PEDIDOS_ITENS_CONF Pcf
            left outer join PRODUTOS Prd
              on Prd.PK_PRODUTOS         = Pcf.FK_INSUMOS
            left outer join TIPO_COMPONENTES Tcm
              on Tcm.PK_TIPO_COMPONENTES = Pcf.FK_COMPONENTES
            left outer join TIPO_ACABAMENTOS Tca
              on Tca.PK_TIPO_ACABAMENTOS = Pcf.FK_ACABAMENTOS
            left outer join TIPO_REFERENCIAS Trf
              on Trf.FK_TIPO_ACABAMENTOS = Pcf.FK_ACABAMENTOS
             and Trf.PK_TIPO_REFERENCIAS = Pcf.FK_TIPO_REFERENCIAS
           where Pcf.FK_EMPRESAS         = :P_FK_EMPRESAS
             and Pcf.FK_PEDIDOS          = :P_FK_PEDIDOS
             and Pcf.FK_PEDIDOS_ITENS    = :R_PK_PEDIDOS_ITENS
            into :R_PK_PEDIDOS_ITENS_CONF, :R_FK_INSUMOS,
                 :R_FK_COMPONENTES, :R_FK_ACABAMENTOS,
                 :R_FK_TIPO_REFERENCIAS, :R_FK_TIPO_DOCUMENTOS,
                 :R_COD_REF, :R_VLR_ITM, :R_QTD_COMP,
                 :R_QTD_COMP_TOT, :R_QTD_INS, :R_FLAG_FRNCLI,
                 :R_FLAG_PEND_C, :R_FLAG_CNTR, :R_FLAG_BXASTT_C,
                 :R_NUM_DOC_LIB, :R_PER_DSCT_INS, :DscTComp,
                 :DscAcabm, :DscRef, :R_DSC_INS do
      begin
        R_DSC_CONF = Cast(DscTComp as varchar(20)) ||
                     Cast(DscAcabm as varchar(10)) ||
                     Cast(DscRef   as varchar(10));
        suspend;
      end
    end
  end
end^

set term  ;^;

grant EXECUTE on procedure STP_GET_ORDER_ITEMS to PUBLIC;


set term ^;

create procedure STP_GET_PK_DESCONTOS (
  P_FK_TIPO_DESCONTOS integer
)
returns (
  R_PK_DESCONTOS smallint
)
as
begin
  R_PK_DESCONTOS = -1;
  if ((P_FK_TIPO_DESCONTOS is not null) and (P_FK_TIPO_DESCONTOS > 0)) then
  begin
    select KC_DESCONTOS 
      from TIPO_DESCONTOS
     where PK_TIPO_DESCONTOS = :P_FK_TIPO_DESCONTOS
      into :R_PK_DESCONTOS;
    if ((R_PK_DESCONTOS is not null) and  (R_PK_DESCONTOS >= 0)) then
    begin
      R_PK_DESCONTOS = R_PK_DESCONTOS + 1;
      update TIPO_DESCONTOS set
             KC_DESCONTOS = :R_PK_DESCONTOS
       where PK_TIPO_DESCONTOS = :P_FK_TIPO_DESCONTOS;
    end
  end
  suspend;
end ^

set term ;^;

grant EXECUTE on procedure STP_GET_PK_DESCONTOS to PUBLIC;


set term ^;

create procedure STP_GET_PK_PEDIDOS (
  P_FK_EMPRESAS            integer,
  P_FK_TIPO_STATUS_PEDIDOS smallint
)
returns (
 R_PK_PEDIDOS integer
)
as
  declare variable FkTypeDocument  integer;
begin
  R_PK_PEDIDOS = null;
  if ((P_FK_TIPO_STATUS_PEDIDOS is not null) and
      (P_FK_TIPO_STATUS_PEDIDOS > 0)) then
  begin
    select FK_TIPO_DOCUMENTOS
      from TIPO_STATUS_PEDIDOS
     where PK_TIPO_STATUS_PEDIDOS = :P_FK_TIPO_STATUS_PEDIDOS
      into :FkTypeDocument;
    if ((FkTypeDocument is not null) and (FkTypeDocument > 0)) then
    begin
      select NUM_DOC from TIPO_DOCUMENTOS_NUMERACAO
       where FK_EMPRESAS        = :P_FK_EMPRESAS
         and FK_TIPO_DOCUMENTOS = :FkTypeDocument
        into :R_PK_PEDIDOS;
      if (R_PK_PEDIDOS is null) then
      begin
        insert into TIPO_DOCUMENTOS_NUMERACAO
          (FK_EMPRESAS, FK_TIPO_DOCUMENTOS, NUM_DOC)
        values
          (:P_FK_EMPRESAS, :FkTypeDocument, 0);
        R_PK_PEDIDOS = 0;
      end
      R_PK_PEDIDOS = R_PK_PEDIDOS + 1;
      update TIPO_DOCUMENTOS_NUMERACAO set
             NUM_DOC            = :R_PK_PEDIDOS
       where FK_EMPRESAS        = :P_FK_EMPRESAS
         and FK_TIPO_DOCUMENTOS = :FkTypeDocument;
    end
  end
  suspend;
end^

set term ;^;

grant EXECUTE on procedure STP_GET_PK_PEDIDOS to PUBLIC;


set term ^;

create procedure STP_GET_PK_PEDIDOS_DESCONTOS (
  P_FK_EMPRESAS     integer,
  P_FK_PEDIDOS      integer
)
returns (
  R_PK_PEDIDOS_DESCONTOS smallint
)
as
begin
  R_PK_PEDIDOS_DESCONTOS = -1;
  if ((P_FK_EMPRESAS     is not null) and (P_FK_EMPRESAS     > 0) and
     ( P_FK_PEDIDOS      is not null) and (P_FK_PEDIDOS      > 0)) then 
  begin
    select KC_PEDIDOS_DESCONTOS 
      from PEDIDOS
     where FK_EMPRESAS     = :P_FK_EMPRESAS
       and PK_PEDIDOS      = :P_FK_PEDIDOS
      into :R_PK_PEDIDOS_DESCONTOS;
    if (R_PK_PEDIDOS_DESCONTOS is null) then
      R_PK_PEDIDOS_DESCONTOS = 0;
    begin
      R_PK_PEDIDOS_DESCONTOS = R_PK_PEDIDOS_DESCONTOS + 1;
      update PEDIDOS set
             KC_PEDIDOS_DESCONTOS = :R_PK_PEDIDOS_DESCONTOS
       where FK_EMPRESAS     = :P_FK_EMPRESAS
         and PK_PEDIDOS      = :P_FK_PEDIDOS;
    end
  end
  suspend;
end ^

set term ;^;

grant EXECUTE on procedure STP_GET_PK_PEDIDOS_DESCONTOS to PUBLIC;


set term ^;

create procedure STP_GET_PK_PEDIDOS_HISTORICOS (
  P_FK_EMPRESAS     integer,
  P_FK_PEDIDOS      integer
)
returns (
  R_PK_PEDIDOS_HISTORICOS smallint
)
as
begin
  R_PK_PEDIDOS_HISTORICOS = null;
  if ((P_FK_EMPRESAS     is not null) and (P_FK_EMPRESAS     > 0)  and
     ( P_FK_PEDIDOS      is not null) and (P_FK_PEDIDOS      > 0)) then 
  begin
    select KC_PEDIDOS_HISTORICOS 
      from PEDIDOS
     where FK_EMPRESAS     = :P_FK_EMPRESAS
       and PK_PEDIDOS      = :P_FK_PEDIDOS
      into :R_PK_PEDIDOS_HISTORICOS;
    if (R_PK_PEDIDOS_HISTORICOS is null) then
      R_PK_PEDIDOS_HISTORICOS = 0;
    R_PK_PEDIDOS_HISTORICOS = R_PK_PEDIDOS_HISTORICOS + 1;
    update PEDIDOS set
           KC_PEDIDOS_HISTORICOS = :R_PK_PEDIDOS_HISTORICOS
     where FK_EMPRESAS     = :P_FK_EMPRESAS
       and PK_PEDIDOS      = :P_FK_PEDIDOS;
  end
  suspend;
end ^

set term ;^;

grant EXECUTE on procedure STP_GET_PK_PEDIDOS_HISTORICOS to PUBLIC;


set term ^;

create procedure STP_GET_PK_PEDIDOS_ITENS (
  P_FK_EMPRESAS integer,
  P_FK_PEDIDOS  integer
)
returns (
  R_PK_PEDIDOS_ITENS integer
)
as
begin
  R_PK_PEDIDOS_ITENS = null;
  if ((P_FK_EMPRESAS is not null) and (P_FK_EMPRESAS > 0)  and
     ( P_FK_PEDIDOS  is not null) and (P_FK_PEDIDOS  > 0)) then
  begin
    select QTD_ITEM
      from PEDIDOS
     where FK_EMPRESAS = :P_FK_EMPRESAS
       and PK_PEDIDOS  = :P_FK_PEDIDOS
      into :R_PK_PEDIDOS_ITENS;
    if (R_PK_PEDIDOS_ITENS is null) then
      R_PK_PEDIDOS_ITENS = 0;
    R_PK_PEDIDOS_ITENS   = R_PK_PEDIDOS_ITENS + 1;
    update PEDIDOS set
           QTD_ITEM    = :R_PK_PEDIDOS_ITENS
     where FK_EMPRESAS = :P_FK_EMPRESAS
       and PK_PEDIDOS  = :P_FK_PEDIDOS;
  end
  suspend;
end ^

set term ;^;

grant EXECUTE on procedure STP_GET_PK_PEDIDOS_ITENS to PUBLIC;


set term ^;

create procedure STP_GET_PK_PEDIDOS_ITENS_CONF (
  P_FK_EMPRESAS integer,
  P_FK_PEDIDOS  integer,
  P_FK_PEDIDOS_ITENS smallint
)
returns (
  R_PK_PEDIDOS_ITENS_CONF smallint
)
as
begin
  R_PK_PEDIDOS_ITENS_CONF = null;
  if ((P_FK_EMPRESAS      is null) and (P_FK_EMPRESAS      > 0)  and
     ( P_FK_PEDIDOS       is null) and (P_FK_PEDIDOS       > 0)  and
     ( P_FK_PEDIDOS_ITENS is null) and (P_FK_PEDIDOS_ITENS > 0)) then
  begin
    select QTD_CONF from PEDIDOS_ITENS
     where FK_EMPRESAS      = :P_FK_EMPRESAS
       and FK_PEDIDOS       = :P_FK_PEDIDOS
       and PK_PEDIDOS_ITENS = :P_FK_PEDIDOS_ITENS
      into :R_PK_PEDIDOS_ITENS_CONF;
    if (R_PK_PEDIDOS_ITENS_CONF is null) then R_PK_PEDIDOS_ITENS_CONF = 0;
    R_PK_PEDIDOS_ITENS_CONF = R_PK_PEDIDOS_ITENS_CONF + 1;
    update PEDIDOS_ITENS set 
           QTD_CONF = :R_PK_PEDIDOS_ITENS_CONF
     where FK_EMPRESAS      = :P_FK_EMPRESAS
       and FK_PEDIDOS       = :P_FK_PEDIDOS
       and PK_PEDIDOS_ITENS = :P_FK_PEDIDOS_ITENS;
  end
  suspend;
end ^

set term ;^;

grant EXECUTE on procedure STP_GET_PK_PEDIDOS_ITENS_CONF to PUBLIC;


set term ^;

create procedure STP_GET_PK_PEDIDOS_MENSAGENS (
  P_FK_EMPRESAS  integer,
  P_FK_PEDIDOS   integer
)
returns (
  R_PK_PEDIDOS_MENSAGENS integer
)
as
begin
  R_PK_PEDIDOS_MENSAGENS = null;
  if ((P_FK_EMPRESAS is not null) and (P_FK_EMPRESAS > 0)  and 
     ( P_FK_PEDIDOS  is not null) and (P_FK_PEDIDOS  > 0)) then
  begin
    select KC_PEDIDOS_MENSAGENS 
      from PEDIDOS
     where FK_EMPRESAS     = :P_FK_EMPRESAS
       and PK_PEDIDOS      = :P_FK_PEDIDOS
      into :R_PK_PEDIDOS_MENSAGENS;
    if (R_PK_PEDIDOS_MENSAGENS is null) then
      R_PK_PEDIDOS_MENSAGENS = 0;
    R_PK_PEDIDOS_MENSAGENS   = R_PK_PEDIDOS_MENSAGENS + 1;
    update PEDIDOS set
           KC_PEDIDOS_MENSAGENS = :R_PK_PEDIDOS_MENSAGENS
     where FK_EMPRESAS          = :P_FK_EMPRESAS
       and PK_PEDIDOS           = :P_FK_PEDIDOS;
  end
  suspend;
end ^

set term ;^;

grant EXECUTE on procedure STP_GET_PK_PEDIDOS_MENSAGENS to PUBLIC;


set term ^;

create procedure STP_GET_PK_PRODUCT (
  P_FK_PRODUTO           varchar(30),
  P_CODE_TYPE            smallint
)
returns (
  R_PK_PRODUCT           integer
)
as
begin
/* 0 ==> Referencia do Produto */
/* 1 ==> Codigo do Produto     */
/* 2 ==> Codigo de Barras      */
/* 3 ==> Codigo do Fornecedor  */
  R_PK_PRODUCT = 0;
  if (P_CODE_TYPE = 1) then
  begin
    R_PK_PRODUCT = cast(P_FK_PRODUTO as Integer);
    suspend;
  end
  begin
    select FK_PRODUTOS from PRODUTOS_CODIGOS
     where COD_REF    = :P_FK_PRODUTO
       and FLAG_TCODE = :P_CODE_TYPE
      into :R_PK_PRODUCT;
    suspend;
  end
end ^

set term  ;^;

grant EXECUTE on procedure STP_GET_PK_PRODUCT to PUBLIC;


set term ^;

create procedure STP_GET_PRODUCT_ATAXES (
  P_FK_EMPRESAS   integer,
  P_FK_PRODUTOS   integer,
  P_FLAG_ES       smallint,
  P_FLAG_CNS      smallint,
  P_FK_PAISES     smallint,
  P_FK_ESTADOS    varchar(02),
  P_FK_MUNICIPIOS integer,
  P_TYPE_PRINTER  integer
)
returns (
  R_RED_BASC      numeric(5, 02),
  R_ALQ_ICMS      numeric(5, 02),
  R_ALQ_ICMSS     numeric(5, 02),
  R_ALQ_ISS       numeric(5, 02),
  R_ALQ_IPI       numeric(5, 02),
  R_ALQ_OTR       numeric(5, 02),
  R_COD_ICMS_ECF  smallint,
  R_COD_ICMSS_ECF smallint,
  R_COD_IPI_ECF   smallint,
  R_COD_ISS_ECF   smallint,
  R_COD_OTR_ECF   smallint,
  R_FLAG_SRV      smallint,
  R_STATUS        smallint
)
as
  declare variable FkTipoImpostos smallint;
  declare variable FlagImpst      smallint;
  declare variable FlagRange      smallint;
  declare variable AlqtSaiCons    numeric(5, 2);
  declare variable AlqtSai        numeric(5, 2);
  declare variable ArbtIcmss      numeric(5, 2);
  declare variable CodAlqtSaiCons smallint;
  declare variable CodAlqtSai     smallint;
begin
  R_RED_BASC      = 0.0;
  R_ALQ_ICMS      = 0.0;
  R_ALQ_ICMSS     = 0.0;
  R_ALQ_ISS       = 0.0;
  R_ALQ_IPI       = 0.0;
  R_ALQ_OTR       = 0.0;
  R_COD_ICMS_ECF  = 0;
  R_COD_ICMSS_ECF = 0;
  R_COD_IPI_ECF   = 0;
  R_COD_ISS_ECF   = 0;
  R_COD_OTR_ECF   = 0;
  R_FLAG_SRV      = 0;
  R_STATUS        = 0;
  /* select fisco info
     0 ==> Base para ICMS
     1 ==> Base para ICMS Substituicao
     2 ==> Base para ICMS Isento
     3 ==> Base para IPI
     4 ==> Base para ISS
     5 ==> Base para Outros
  */
  for select Pri.FK_TIPO_IMPOSTOS, Tim.FLAG_IMPST, Tim.RED_BASC
        from PRODUTOS_IMPOSTOS Pri, TIPO_IMPOSTOS Tim
       where Pri.FK_EMPRESAS       = :P_FK_EMPRESAS
         and Pri.FK_PRODUTOS       = :P_FK_PRODUTOS
         and Tim.PK_TIPO_IMPOSTOS  = Pri.FK_TIPO_IMPOSTOS
         and Tim.FLAG_RANGE        = 0
        into :FkTipoImpostos, :FlagImpst, :R_RED_BASC do
  begin
    select ALQT_CNSF, ALQT_IMPST, ALQT_ARBT
      from ALIQUOTAS
     where FK_EMPRESAS      = :P_FK_EMPRESAS
       and FK_PAISES        = :P_FK_PAISES
       and FK_ESTADOS       = :P_FK_ESTADOS
       and FK_TIPO_IMPOSTOS = :FkTipoImpostos
      into :AlqtSaiCons, :AlqtSai, :ArbtIcmss;
    if (((AlqtSai is null) or (AlqtSai <= 0)) and
       (FlagImpst not in (1, 2))) then
      R_STATUS = 30; /* Tax of product not found */
    R_ALQ_ICMS  = 0;
    R_ALQ_ICMSS = 0;
    R_ALQ_IPI   = 0;
    R_ALQ_OTR   = 0;
    if (FlagImpst    = 0) then
      if (P_FLAG_CNS = 1) then
        R_ALQ_ICMS   = AlqtSaiCons;
      else
        R_ALQ_ICMS   = AlqtSai;
    if (FlagImpst    = 1) then
      if (P_FLAG_CNS = 1) then
        R_ALQ_ICMSS = AlqtSaiCons;
      else
        R_ALQ_ICMSS = AlqtSai;
    if (FlagImpst   = 3) then
      R_ALQ_IPI     = AlqtSai;
    if (FlagImpst   = 4) then
    begin
      select ALQ_ISS
        from MUNICIPIOS
       where FK_PAISES               = :P_FK_PAISES
         and FK_ESTADOS              = :P_FK_ESTADOS
         and PK_MUNICIPIOS           = :P_FK_MUNICIPIOS
        into :R_ALQ_ISS;
      R_FLAG_SRV = 1;
    end
    if (FlagImpst   = 5) then
      R_ALQ_OTR     = AlqtSai;
    if ((P_FLAG_CNS  = 1) and (P_TYPE_PRINTER is not null) and
       (P_TYPE_PRINTER > 0)) then
    begin
      select COD_ALQT_CNSF, COD_ALQT
        from ALIQUOTAS_IMP_FISCAL
       where FK_EMPRESAS             = :P_FK_EMPRESAS
         and FK_PAISES               = :P_FK_PAISES
         and FK_ESTADOS              = :P_FK_ESTADOS
         and FK_TIPO_IMPOSTOS        = :FkTipoImpostos
         and PK_ALIQUOTAS_IMP_FISCAL = :P_TYPE_PRINTER
        into :CodAlqtSaiCons, :CodAlqtSai;
      R_COD_ICMS_ECF   = 0;
      R_COD_ICMSS_ECF  = 0;
      R_COD_IPI_ECF    = 0;
      R_COD_ISS_ECF    = 0;
      R_COD_OTR_ECF    = 0;
      if (FlagImpst    = 0) then
        if (P_FLAG_CNS = 1) then
          R_COD_ICMS_ECF = CodAlqtSaiCons;
        else
          R_COD_ICMS_ECF = CodAlqtSai;
      if (FlagImpst    = 1) then
        if (P_FLAG_CNS = 1) then
          R_COD_ICMSS_ECF = CodAlqtSaiCons;
        else
          R_COD_ICMSS_ECF = CodAlqtSai;
      if (FlagImpst = 3) then
        R_COD_IPI_ECF = CodAlqtSai;
      if (FlagImpst = 4) then
      begin
        select COD_ISS_ECF
          from MUNICIPIOS_ALIQUOTAS
         where FK_PAISES               = :P_FK_PAISES
           and FK_ESTADOS              = :P_FK_ESTADOS
           and FK_MUNICIPIOS           = :P_FK_MUNICIPIOS
           and PK_MUNICIPIOS_ALIQUOTAS = :P_TYPE_PRINTER
          into :R_COD_ISS_ECF;
        R_FLAG_SRV = 1;
      end /* end of if */
      if (FlagImpst = 5) then
        R_COD_OTR_ECF = CodAlqtSai;
    end /* end of if */
  end
  if (((R_FLAG_SRV    = 1)     and 
     (( R_ALQ_ISS     is null)  or (  R_ALQ_ISS      = 0)   or 
     (  R_COD_ISS_ECF is null)  or (  R_COD_ISS_ECF  = 0))) or 
     (  FlagImpst     is null)) then
    R_STATUS = 40; /* whithout fiscal classification */
  suspend;
end ^

set term ;^;

grant EXECUTE on procedure STP_GET_PRODUCT_ATAXES to PUBLIC;


set term ^;

create procedure STP_GET_PRODUCT_BOX (
  P_FK_EMPRESAS integer, 
  P_PK_PRODUTOS integer,
  P_QTD_PROD    numeric(9, 4)
)
returns (
  R_FK_ALMOXARIFADOS smallint,
  R_FK_LOTACOES      smallint,
  R_QTD_ESTQ_ALMX    numeric(11, 4),
  R_QTD_ESTQ_LOT     numeric(11, 4),
  R_LOT_PROD         varchar(20)
)
as
  declare variable Rua   varchar(6);
  declare variable Nivel varchar(6);
  declare variable Box   varchar(6);
begin
  if (P_QTD_PROD is null) then
    P_QTD_PROD = 0;
  for select (Pes.QTD_ESTQ - (Pes.QTD_GRNT + Pes.QTD_RSRV +
              Pes.QTD_ESTQ_QR + Pes.QTD_GRNT)) as ESTOQUES, 
              Pes.FK_ALMOXARIFADOS, Plo.QTD_LOT, Lot.RUA_LOT, 
              Lot.NIVEL_LOT, Lot.BOX_LOT, Lot.PK_LOTACOES
         from PRODUTOS_ESTOQUES Pes
         left outer join PRODUTOS_LOTACOES Plo
           on Plo.FK_EMPRESAS      = Pes.FK_EMPRESAS
          and Plo.FK_ALMOXARIFADOS = Pes.FK_ALMOXARIFADOS
          and Plo.FK_PRODUTOS      = Pes.FK_PRODUTOS
         left outer join LOTACOES Lot
           on Lot.FK_EMPRESAS      = Pes.FK_EMPRESAS
          and Lot.FK_ALMOXARIFADOS = Pes.FK_ALMOXARIFADOS
          and Lot.PK_LOTACOES      = Plo.FK_LOTACOES
        where Pes.FK_EMPRESAS      = :P_FK_EMPRESAS
          and Pes.FK_PRODUTOS      = :P_PK_PRODUTOS
         into :R_FK_ALMOXARIFADOS, :R_QTD_ESTQ_ALMX, :R_QTD_ESTQ_LOT, :Rua, 
              :Nivel, :Box, :R_FK_LOTACOES do
  begin
    if ((P_QTD_PROD = 0) or (P_QTD_PROD <= R_QTD_ESTQ_ALMX)) then
    begin
      R_LOT_PROD = Rua || '-' || Nivel || '-' || Box;
      suspend;
    end
  end
end ^

set term ;^;

grant EXECUTE on procedure STP_GET_PRODUCT_BOX to PUBLIC;


set term ^;

create procedure STP_GET_PRODUCT_ITEM (
  P_FK_EMPRESA           integer,
  P_FK_CADASTRO          integer,
  P_FK_PRODUTO           varchar(30),
  P_CODE_TYPE            smallint,
  P_FK_TABELA_PRECOS     smallint,
  P_FK_GRUPOS_MOVIMENTOS smallint,
  P_FK_TIPO_MOVIMENTOS   smallint,
  P_TYPE_VOLUME          smallint,
  P_QTD_PROD             numeric(18, 04)
)
returns (
  R_STATUS               smallint,
  R_PK_PRODUTOS          integer,
  R_FK_TABELA_PRECOS     smallint,
  R_FK_UNIDADES          smallint,
  R_FK_ALMOXARIFADOS     smallint,
  R_FK_LOTACOES          smallint,
  R_FK_EMPRESAS          integer,
  R_FK_FINANCEIRO_CONTAS integer,
  R_FK_CENTRO_CUSTOS     integer,
  R_DSC_TAB              varchar(30),
  R_COD_REF              varchar(20),
  R_COD_BARRA            varchar(30),
  R_DSC_PROD             varchar(50),
  R_DSC_RED              varchar(30),
  R_LOT_PROD             varchar(20),
  R_MNM_UNI              varchar(02),
  R_SIT_TRIB             varchar(03),
  R_CLASS_FISCAL         varchar(20),
  R_COD_ICMS_ECF         varchar(03),
  R_COD_ICMSS_ECF        varchar(03),
  R_COD_IPI_ECF          varchar(03),
  R_COD_ISS_ECF          varchar(03),
  R_COD_OTR_ECF          varchar(03),
  R_NOM_EMP              varchar(50),
  R_COD_CFOP             varchar(5),
  R_QTD_ESTQ             numeric(09, 04),
  R_QTD_ESTQ_ALMX        numeric(09, 04),
  R_QTD_ESTQ_LOT         numeric(09, 04),
  R_QTD_ITEM             numeric(09, 04),
  R_VLR_TAB              numeric(09, 04),
  R_VLR_UNIT             numeric(09, 04),
  R_VLR_DSCT             numeric(09, 04),
  R_DSCT_ITEM            numeric(09, 04),
  R_PES_LIQ              numeric(09, 04),
  R_PES_BRU              numeric(09, 04),
  R_ALQ_OTR              numeric(05, 02),
  R_ALQ_ISS              numeric(05, 02),
  R_ALQ_ICMS             numeric(05, 02),
  R_ALQ_ICMSS            numeric(05, 02),
  R_ALQ_IPI              numeric(05, 02),
  R_COM_PROD             numeric(05, 02),
  R_RED_BASC             numeric(05, 02),
  R_PERC_DSCT            numeric(05, 02),
  R_VOL_PROD             double precision,
  R_FLAG_FRAC            smallint,
  R_FLAG_SRV             smallint,
  R_FLAG_DEFTAB          smallint,
  R_FLAG_TAB             smallint,
  R_FLAG_NEG             smallint,
  R_FLAG_CONF            smallint
)
as
  declare variable PkTipoCfop     integer;
  declare variable FkProductGroup integer;
  declare variable PkNatureOper   integer;
  declare variable FlagES         smallint;
  declare variable FlagCns        smallint;
  declare variable FlagExp        smallint;
  declare variable FlagCusto      smallint;
  declare variable FkPaises       smallint;
  declare variable FkEstados      char(02);
  declare variable FkPaisesEmp    smallint;
  declare variable FkEstadosEmp   char(02);
  declare variable ComSGru        numeric(05, 02);
  declare variable PkTabelaPrecos smallint;
  declare variable VlrTab         numeric(11, 04);
  declare variable CustFinal      numeric(09, 04);
  declare variable CustForn       numeric(09, 04);
  declare variable CustReal       numeric(09, 04);
  declare variable CustMed        numeric(09, 04);
  declare variable FlagPrm        smallint;
  declare variable DscTab         varchar(30);
  declare variable FlagFix        smallint;
  declare variable Height         numeric(09, 04);
  declare variable Width          numeric(09, 04);
  declare variable Depth          numeric(09, 04);
  declare variable FkLanguage     varchar(05);
  declare variable FkMunicipios   integer;
  declare variable FlagBoxSus     smallint;
  declare variable CodCfopDE      varchar(05);
  declare variable CodCfopFE      varchar(05);
  declare variable CodCfopEX      varchar(05);
begin
  R_STATUS = 0; /* All conditions was attended */
  R_FLAG_SRV  = 0;
  if ((P_QTD_PROD is null) or (P_QTD_PROD = 0)) then
    R_QTD_ITEM = 1;
  else
    R_QTD_ITEM = :P_QTD_PROD;
/* select product info */
  R_PK_PRODUTOS = 0;
  if (P_CODE_TYPE = 1) then
  begin
    R_PK_PRODUTOS = Cast(P_FK_PRODUTO as integer);
    P_FK_PRODUTO = '';
    when SqlCode -413 do
    begin
      R_STATUS = -7; /* I can't to convert the string product code to numeric product code */
      suspend;
      exit;
    end
  end
  select Prc.FK_PRODUTOS, Prc.COD_REF, Prd.FK_UNIDADES, Prd.DSC_PROD,
         Prd.DSC_PROD_RED, Prd.FK_PRODUTOS_GRUPOS, Uni.MNMO_UNI,
         Uni.FLAG_FRAC, Prd.FLAG_NEG
    from PRODUTOS_CODIGOS Prc, PRODUTOS Prd, UNIDADES Uni
   where ((Prc.COD_REF             = :P_FK_PRODUTO)
      or ( cast('' as varchar(30)) = :P_FK_PRODUTO))
     and ((Prc.FLAG_TCODE          = :P_CODE_TYPE)
      or ( 1                       = :P_CODE_TYPE))
     and ((Prc.FK_PRODUTOS         = :R_PK_PRODUTOS)
      or ( 0                       = :R_PK_PRODUTOS))
     and Prd.PK_PRODUTOS           = Prc.FK_PRODUTOS
     and Uni.PK_UNIDADES           = Prd.FK_UNIDADES
    into :R_PK_PRODUTOS, :R_COD_REF, :R_FK_UNIDADES, :R_DSC_PROD,
         :R_DSC_RED, :FkProductGroup, :R_MNM_UNI,
         :R_FLAG_FRAC, :R_FLAG_NEG;
  if ((R_COD_REF is null) or (R_COD_REF = '')) then
  begin
    R_STATUS = -10; /* Product not Found */
    suspend;
    exit;
  end /* end of if */
  if (P_CODE_TYPE = 2) then
  begin
    R_COD_BARRA = R_COD_REF;
    select COD_REF
      from PRODUTOS_CODIGOS Prc, PRODUTOS Prd
     where Prc.FK_PRODUTOS = :R_PK_PRODUTOS
       and Prc.FLAG_TCODE  = 2
      into :R_COD_REF;
  end  /* end of if */
  else
    R_COD_BARRA = '';
  select Gmv.FLAG_ES, Tmv.FLAG_CNS, Tmv.FLAG_EXP, /* select type of customer and Type of movementation*/
         Tmv.NAT_OPE_DE, Tmv.NAT_OPE_FE, Tmv.NAT_OPE_EX
    from GRUPOS_MOVIMENTOS Gmv, TIPO_MOVIMENTOS Tmv
   where Gmv.PK_GRUPOS_MOVIMENTOS = :P_FK_GRUPOS_MOVIMENTOS
     and Tmv.FK_GRUPOS_MOVIMENTOS = Gmv.PK_GRUPOS_MOVIMENTOS
     and Tmv.PK_TIPO_MOVIMENTOS   = :P_FK_TIPO_MOVIMENTOS
    into :FlagES, :FlagCns, :FlagExp,
         :CodCfopDE, :CodCfopFE, :CodCfopEX;
  if (FlagES is null) then
  begin
    R_STATUS = -20; /* Movementation not found */
    suspend;
    exit;
  end  /* end of if */
  select Cad.FK_PAISES, Cad.FK_ESTADOS, Pais.FK_LINGUAGENS,
         Mun.ALQ_ISS, Mun.PK_MUNICIPIOS
    from CADASTROS Cad, PAISES Pais, MUNICIPIOS Mun
   where Cad.PK_CADASTROS  = :P_FK_CADASTRO
     and Pais.PK_PAISES    = Cad.FK_PAISES
     and Mun.FK_PAISES     = Cad.FK_PAISES
     and Mun.FK_ESTADOS    = Cad.FK_ESTADOS
     and Mun.PK_MUNICIPIOS = Cad.FK_MUNICIPIOS
    into :FkPaises, :FkEstados, :FkLanguage,
         :R_ALQ_ISS, :FkMunicipios;
  if (R_ALQ_ISS is null) then R_ALQ_ISS = 0.0;
  if (FlagES = 1) then
  begin
    if ((P_FK_TABELA_PRECOS = 0) or (P_FK_TABELA_PRECOS is null)) then
    begin
      R_STATUS = -5; /* I can't to calc the price */
      suspend;
      exit;
    end /* end of if */
    select Prv.PES_LIQ, Prv.PES_BRU, Lin.COM_LIN /* Get Comission and Weight of Product */
      from PRODUTOS_VENDAS Prv
      left outer join LINHAS Lin
        on Lin.PK_LINHAS   = Prv.FK_LINHAS
     where Prv.FK_PRODUTOS = :R_PK_PRODUTOS
      into :R_PES_LIQ, :R_PES_BRU, :R_COM_PROD;
    /* Calc volume of the product */
    select ALT_EPROD, PROF_EPROD, LARG_EPROD
      from PRODUTOS_VENDAS
     where FK_PRODUTOS = :R_PK_PRODUTOS
      into :Height, :Width, :Depth;
    if (P_TYPE_VOLUME = 1) then
      select ALT_IPROD, PROF_IPROD, LARG_IPROD
        from PRODUTOS_VENDAS
       where FK_PRODUTOS = :R_PK_PRODUTOS
        into :Height, :Width, :Depth;
    if (P_TYPE_VOLUME = 2) then
      select ALT_PROD, PROF_PROD, LARG_PROD
        from PRODUTOS_VENDAS
       where FK_PRODUTOS = :R_PK_PRODUTOS
        into :Height, :Width, :Depth;
    R_VOL_PROD = Height * Width * Depth;
  end
  else
  begin
    select FK_UNIDADES, FK_CENTRO_CUSTOS 
/*           FLAG_EMP, FLAG_TMAT, VLR_UNIT */
      from PRODUTOS_COMPRAS
     where FK_PRODUTOS = :R_PK_PRODUTOS
       and FLAG_CMPR   = 1
      into :R_FK_UNIDADES, :R_FK_CENTRO_CUSTOS;
    if ((R_FK_CENTRO_CUSTOS = 0) or (R_FK_CENTRO_CUSTOS is null)) then
    begin
      R_STATUS = -7; /* Can't determine costs center */
      suspend;
      exit;
    end /* end of if */
  end
  /* select suply for the product */
  for select (Pct.QTD_ESTQ - (Pct.QTD_GRNT + Pct.QTD_RSRV +
              Pct.QTD_ESTQ_QR + Pct.QTD_GRNT)) as ESTOQUES,
              Pct.CUST_FINAL, Pct.CUST_FORN, Pct.CUST_MED,
              Pct.CUST_REAL, FK_EMPRESAS
        from PRODUTOS_CUSTOS Pct
       where ((Pct.FK_EMPRESAS    = :P_FK_EMPRESA)
          or ( 0                  = :P_FK_EMPRESA))
         and Pct.FK_PRODUTOS      = :R_PK_PRODUTOS
        into :R_QTD_ESTQ, :CustFinal, CustForn, CustMed,
             :CustReal, :R_FK_EMPRESAS do
  begin
    if (R_FK_EMPRESAS is null) then
    begin
      R_STATUS = -50; /* whithout Stoks and Cost */
      suspend;
      exit;
    end
    /* Select name of active company */
    select RAZ_SOC, FK_PAISES, FK_ESTADOS
      from EMPRESAS
     where PK_EMPRESAS = :R_FK_EMPRESAS
      into :R_NOM_EMP, :FkPaisesEmp, FkEstadosEmp;
    if (FkPaisesEmp <> FkPaises) then
      R_COD_CFOP = CodCfopEX;
    else
      if (FkEstadosEmp <> FkEstados) then
        R_COD_CFOP = CodCfopFE;
      else
        R_COD_CFOP = CodCfopFE;
    select FK_TIPO_CFOP, PK_NATUREZA_OPERACOES
      from NATUREZA_OPERACOES
     where COD_CFOP = :R_COD_CFOP
      into :PkTipoCfop, :PkNatureOper;
    if ((PkTipoCfop   is null) or (PkTipoCfop   = 0)  or
       ( PkNatureOper is null) or (PkNatureOper = 0)) then
    begin
      R_STATUS = -25; /* Can't determine the operation for this product */
      suspend;
      exit;
    end
    select FK_FINANCEIRO_CONTAS
      from PRODUTOS_CONTAS
     where FK_PRODUTOS_GRUPOS    = :FkProductGroup
       and FK_TIPO_CFOP          = :PkTipoCfop
       and FK_NATUREZA_OPERACOES = :PkNatureOper
      into :R_FK_FINANCEIRO_CONTAS;
    if ((R_FK_FINANCEIRO_CONTAS is null) or (R_FK_FINANCEIRO_CONTAS = 0)) then
    begin
      R_STATUS = -30; /* Can't determine finance account for this product */
      suspend;
      exit;
    end
    /* Verify if the procuct has a configuration */
    select count(*) from ACABAMENTO_PRECOS
     where FK_EMPRESAS = :R_FK_EMPRESAS
       and FK_PRODUTOS = :R_PK_PRODUTOS
      into :R_FLAG_CONF;
    if (R_FLAG_CONF is null) then
      R_FLAG_CONF = 0;
    if (R_FLAG_CONF > 1) then
      R_FLAG_CONF = 1;
    select R_RED_BASC, R_ALQ_ICMS, R_ALQ_ICMSS, R_ALQ_ISS, R_ALQ_IPI, R_ALQ_OTR,
           R_COD_ICMS_ECF, R_COD_ICMSS_ECF, R_COD_IPI_ECF, R_COD_ISS_ECF,
           R_COD_OTR_ECF, R_FLAG_SRV, R_STATUS
      from STP_GET_PRODUCT_ATAXES (:R_FK_EMPRESAS, :R_PK_PRODUTOS, :FlagES,
           :FlagCns, :FkPaises, :FkEstados, :FkMunicipios, 0) /* Set here the flag that indicate the fiscal printer*/
      into :R_RED_BASC, :R_ALQ_ICMS, :R_ALQ_ICMSS, :R_ALQ_ISS, :R_ALQ_IPI,
           :R_ALQ_OTR, :R_COD_ICMS_ECF, :R_COD_ICMSS_ECF, :R_COD_IPI_ECF,
           :R_COD_ISS_ECF, :R_COD_OTR_ECF, :R_FLAG_SRV, :R_STATUS;
    if (FlagES = 1) then /* Sale of product */
    begin
      /* select price info */
      R_FK_TABELA_PRECOS = 0;
      R_VLR_TAB          = 0;
      select Pmr.SIT_TRIB, Pim.FK_CLASSIFICACAO_FISCAL
        from PRODUTOS_MARGEM Pmr, PRODUTOS_IMPOSTOS Pim
       where Pmr.FK_EMPRESAS = :R_FK_EMPRESAS
         and Pmr.FK_PRODUTOS = :R_PK_PRODUTOS
         and Pim.FK_EMPRESAS = Pmr.FK_EMPRESAS
         and Pim.FK_PRODUTOS = Pmr.FK_PRODUTOS
        into :R_SIT_TRIB, :R_CLASS_FISCAL;
      select Tpr.PK_TABELA_PRECOS, Prp.PRE_VDA, Tpr.DSC_TAB,
             Prp.FLAG_FIX, Tpr.PERC_DSCT, Tpr.FLAG_DEFTAB
        from PRODUTOS_PRECOS Prp, TABELA_PRECOS Tpr
       where Tpr.DTA_INI         <= current_date
         and ((Tpr.DTA_FIN       >= current_date)
          or ( Tpr.DTA_FIN       is null))
         and Prp.FK_EMPRESAS      = :R_FK_EMPRESAS
         and Prp.FK_PRODUTOS      = :R_PK_PRODUTOS
         and Prp.FK_TABELA_PRECOS = Tpr.PK_TABELA_PRECOS
        into :PkTabelaPrecos, :VlrTab, :DscTab, :FlagFix,
             :R_PERC_DSCT, :R_FLAG_DEFTAB;
      if (R_PERC_DSCT is null) then
        R_PERC_DSCT = 0;
      R_FK_TABELA_PRECOS = PkTabelaPrecos;
      R_VLR_TAB          = VlrTab;
      R_DSC_TAB          = DscTab;
      if (P_FK_TABELA_PRECOS = PkTabelaPrecos) then
        R_FLAG_TAB = 1;
      else
        R_FLAG_TAB = 0;
      /* calc Discounts if FlagFix = 0 */
      if (FlagFix = 0) then
      begin
        /* select discount for product group */
        select DSCT_PROD, COM_SGRU
          from PRODUTOS_REFERENCIAS
         where FK_PRODUTOS_GRUPOS = :FkProductGroup
          into :R_DSCT_ITEM, :ComSgru;
        if (R_DSCT_ITEM is null) then
          R_DSCT_ITEM = 0;
        /* Calc of the unit value with discount */
        VlrTab = R_VLR_TAB;
        if (R_DSCT_ITEM > 0) then
          VlrTab = VlrTab - ((VlrTab * R_DSCT_ITEM) / 100);
        if ((R_PERC_DSCT > 0) and (FlagPrm > 0)) then
          VlrTab = VlrTab - ((VlrTab * R_PERC_DSCT) / 100);
        R_VLR_UNIT     = VlrTab;
        R_VLR_DSCT     = R_VLR_TAB - R_VLR_UNIT;
      end
    end
    if ((R_SIT_TRIB is null) or (R_SIT_TRIB = '')) then
      R_STATUS = 30; /* Taxes not found */
    if (FlagES = 0) then  /* Purchase product */
    begin
      R_VLR_TAB  = 0;
      R_VLR_UNIT = CustReal;
      select FLAG_TCUSTO from PARAMETROS_ESTQ
       where FK_EMPRESAS = :R_FK_EMPRESAS
        into :FlagCusto;
    /*
      0 ==> Custo Medio
      1 ==> Custo Real (PMZ)
      2 ==> Custo Fornecedor Final
      3 ==> Custo Fornecedor Tabela
      4 ==> Custo Referencia
    */
      if (FlagCusto = 0) then
        R_VLR_TAB = CustMed;
      if (FlagCusto = 1) then
        R_VLR_TAB = CustReal;
      if (FlagCusto = 2) then
        R_VLR_TAB = CustForn; /* verificar o que incide sobre este custo */
      if (FlagCusto = 3) then
        R_VLR_TAB = CustForn;
      if (FlagCusto = 4) then
        R_VLR_TAB = CustFinal;
    end
    FlagBoxSus = 0;
    R_QTD_ESTQ_ALMX = 0.0;
    R_QTD_ESTQ_LOT  = 0.0;
    R_LOT_PROD      = '';
    for select R_QTD_ESTQ_ALMX, R_QTD_ESTQ_LOT, R_LOT_PROD,
               R_FK_LOTACOES, R_FK_ALMOXARIFADOS
          from STP_GET_PRODUCT_BOX (:R_FK_EMPRESAS, :R_PK_PRODUTOS, 0)
          into :R_QTD_ESTQ_ALMX, :R_QTD_ESTQ_LOT, :R_LOT_PROD,
               :R_FK_LOTACOES, :R_FK_ALMOXARIFADOS do
    begin
      suspend;
      FlagBoxSus = 1;
    end
    if (FlagBoxSus = 0) then
      suspend;
  end
end ^

set term  ;^;

grant EXECUTE on procedure STP_GET_PRODUCT_ITEM to PUBLIC;


set term ^;

create procedure STP_PROMOVE_PEDIDO (
  P_FK_EMPRESAS                integer,
  P_FK_TIPO_STATUS_PEDIDOS     integer,
  P_PK_PEDIDOS                 integer,
  P_FK_TIPO_STATUS_PEDIDOS_NEW integer)
returns (
  R_PK_PEDIDOS integer
 )
as
  declare variable FlagTDoc         smallint;
begin
  R_PK_PEDIDOS = 0;
/*
0 ==> Nota Fiscal
1 ==> Boleto Bancario
2 ==> Ordem de Servicos 
3 ==> Recibos
4 ==> Requisicoes
5 ==> Cheques
6 ==> Pedidos
7 ==> Ordens de Producao
8 ==> Controle Interno
9 ==> Orcamentos
*/
  select Tdc.FLAG_TDOC 
    from TIPO_DOCUMENTOS Tdc, TIPO_STATUS_PEDIDOS Tsp
   where Tsp.PK_TIPO_STATUS_PEDIDOS = :P_FK_TIPO_STATUS_PEDIDOS
    into :FlagTDoc;
  if ((FlagTDoc is not null) and (FlagTDoc in (6, 9))) then
  begin
    select R_PK_PEDIDOS from STP_GET_PK_PEDIDOS(:P_FK_EMPRESAS,
           :P_FK_TIPO_STATUS_PEDIDOS_NEW)
      into :R_PK_PEDIDOS;
    if (R_PK_PEDIDOS > 0) then
    begin
      update PEDIDOS set
             PK_PEDIDOS             = :R_PK_PEDIDOS,
             FK_TIPO_STATUS_PEDIDOS = :P_FK_TIPO_STATUS_PEDIDOS_NEW
       where FK_EMPRESAS            = :P_FK_EMPRESAS
         and FK_TIPO_STATUS_PEDIDOS = :P_FK_TIPO_STATUS_PEDIDOS
         and PK_PEDIDOS             = :P_PK_PEDIDOS;
    end
  end
  suspend;
end ^

set term  ;^;

grant EXECUTE on procedure STP_PROMOVE_PEDIDO to PUBLIC;


set term ^;

create procedure STP_UPDATE_SUPPLIERS_FROM_ITEMS (
  P_FK_EMPRESAS        integer,
  P_FK_PEDIDOS         integer,
  P_FK_TIPO_MOVIM_ESTQ smallint,
  P_FK_CADASTROS       integer
)
returns (
  R_STATUS smallint
)
as
  declare variable PkTipoStatusPedidos smallint;
  declare variable PkTipoMovimEstq     smallint;
  declare variable PkTipoDocumentos    smallint;
  declare variable PkProdutos          smallint;
  declare variable PkAlmoxarifados     smallint;
  declare variable PkLotacoes          smallint;
  declare variable QtdItem             numeric(9, 4);
begin
  R_STATUS = -1;
  if ((P_FK_EMPRESAS       is null) or (P_FK_EMPRESAS       = 0)  or
     ( P_FK_PEDIDOS        is null) or (P_FK_PEDIDOS        = 0)) then
  begin 
    suspend;
    exit;
  end
  select FK_TIPO_STATUS_PEDIDOS from PEDIDOS
   where FK_EMPRESAS = :P_FK_EMPRESAS
     and PK_PEDIDOS  = :P_FK_PEDIDOS
    into :PkTipoStatusPedidos;
  if ((PkTipoStatusPedidos is null) and (PkTipoStatusPedidos = 0)) then
  begin
    suspend;
    exit;
  end
  select FK_TIPO_DOCUMENTOS, FK_TIPO_MOVIM_ESTQ from TIPO_STATUS_PEDIDOS
   where PK_TIPO_STATUS_PEDIDOS = :PkTipoStatusPedidos
    into :PkTipoDocumentos, :PkTipoMovimEstq;
  if ((PkTipoMovimEstq <> P_FK_TIPO_MOVIM_ESTQ) or
     ( PkTipoDocumentos is null) or (PkTipoDocumentos = 0)) then
  begin
    suspend;
    exit;
  end
  for select FK_PRODUTOS, QTD_ITEM, FK_ALMOXARIFADOS, FK_LOTACOES
        from PEDIDOS_ITENS Pdi
       where FK_EMPRESAS     = :P_FK_EMPRESAS
         and FK_PEDIDOS      = :P_FK_PEDIDOS
        into :PkProdutos, :QtdItem, :PkAlmoxarifados, :PkLotacoes do
  begin
    select R_STATUS 
      from STP_UPDATE_SUPPLIES(:P_FK_EMPRESAS,
                               :PkProdutos,
                               :PkTipoMovimEstq,
                               :PkTipoDocumentos,
                               :PkAlmoxarifados, 
                               0,
                               :PkLotacoes,
                               0,
                               :P_FK_CADASTROS,
                               :P_FK_PEDIDOS,
                               :QtdItem)
      into :R_STATUS;
  end
  suspend;
end ^

set term ;^;

grant EXECUTE on procedure STP_UPDATE_SUPPLIERS_FROM_ITEMS to PUBLIC;


/*  Insert trigger "TBIG_DESCONTOS" for table "DESCONTOS"  */
set term ^;

create trigger TBIG_DESCONTOS for DESCONTOS
before insert as
begin
  if ((New.PK_DESCONTOS is null) or (New.PK_DESCONTOS = 0)) then
  begin
    select R_PK_DESCONTOS 
      from STP_GET_PK_DESCONTOS(New.FK_TIPO_DESCONTOS)
      into New.PK_DESCONTOS;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
end^

set term ;^;


/*  Update trigger "TBU0_DESCONTOS" for table "DESCONTOS"  */
set term ^;

create trigger TBU0_DESCONTOS for DESCONTOS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'DESCONTOS', 3, 'DESCONTOS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_FINALIZADORAS" for table "FINALIZADORAS"  */
set term ^;

create trigger TBIG_FINALIZADORAS for FINALIZADORAS
before insert as
begin
  if ((New.PK_FINALIZADORAS is null) or (New.PK_FINALIZADORAS = 0)) then
    New.PK_FINALIZADORAS = Gen_Id(FINALIZADORAS, 1);
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'FINALIZADORAS', 2, 'FINALIZADORAS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_FINALIZADORAS" for table "FINALIZADORAS"  */
set term ^;

create trigger TBU0_FINALIZADORAS for FINALIZADORAS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'FINALIZADORAS', 3, 'FINALIZADORAS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_FINALIZADORAS" for table "FINALIZADORAS"  */
set term ^;

create trigger TAD0_FINALIZADORAS for FINALIZADORAS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'FINALIZADORAS', 4, 'FINALIZADORAS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_GRUPOS_MOVIMENTOS" for table "GRUPOS_MOVIMENTOS"  */
set term ^;

create trigger TBIG_GRUPOS_MOVIMENTOS for GRUPOS_MOVIMENTOS
before insert as
begin
  if ((New.PK_GRUPOS_MOVIMENTOS is null) or (New.PK_GRUPOS_MOVIMENTOS = 0)) then
    New.PK_GRUPOS_MOVIMENTOS = Gen_Id(GRUPOS_MOVIMENTOS, 1);
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'GRUPOS_MOVIMENTOS', 2, 'GRUPOS_MOVIMENTOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_GRUPOS_MOVIMENTOS" for table "GRUPOS_MOVIMENTOS"  */
set term ^;

create trigger TBU0_GRUPOS_MOVIMENTOS for GRUPOS_MOVIMENTOS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'GRUPOS_MOVIMENTOS', 3, 'GRUPOS_MOVIMENTOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_PARAMETROS_PED" for table "PARAMETROS_PED"  */
set term ^;

create trigger TBU0_PARAMETROS_PED for PARAMETROS_PED
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PARAMETROS_PED', 3, 'PARAMETROS_PED', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_PEDIDOS" for table "PEDIDOS"  */
set term ^;

create trigger TBIG_PEDIDOS for PEDIDOS
  before insert as
begin
  if ((New.PK_PEDIDOS is null) or (New.PK_PEDIDOS = 0)) then
  begin
    select R_PK_PEDIDOS from STP_GET_PK_PEDIDOS(New.FK_EMPRESAS, New.FK_TIPO_STATUS_PEDIDOS)
      into New.PK_PEDIDOS;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PEDIDOS', 2, 'PEDIDOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_PEDIDOS" for table "PEDIDOS"  */
set term ^;

create trigger TBU0_PEDIDOS for PEDIDOS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PEDIDOS', 3, 'PEDIDOS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_PEDIDOS" for table "PEDIDOS"  */
set term ^;

create trigger TAD0_PEDIDOS for PEDIDOS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PEDIDOS', 4, 'PEDIDOS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TAI0_PEDIDOS_CENTRO_CUSTOS" for table "PEDIDOS_CENTRO_CUSTOS"  */
set term ^;

create trigger TAI0_PEDIDOS_CENTRO_CUSTOS for PEDIDOS_CENTRO_CUSTOS
  after insert as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PEDIDOS_CENTRO_CUSTOS', 2, 'PEDIDOS_CENTRO_CUSTOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_PEDIDOS_CENTRO_CUSTOS" for table "PEDIDOS_CENTRO_CUSTOS"  */
set term ^;

create trigger TBU0_PEDIDOS_CENTRO_CUSTOS for PEDIDOS_CENTRO_CUSTOS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PEDIDOS_CENTRO_CUSTOS', 3, 'PEDIDOS_CENTRO_CUSTOS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_PEDIDOS_CENTRO_CUSTOS" for table "PEDIDOS_CENTRO_CUSTOS"  */
set term ^;

create trigger TAD0_PEDIDOS_CENTRO_CUSTOS for PEDIDOS_CENTRO_CUSTOS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PEDIDOS_CENTRO_CUSTOS', 4, 'PEDIDOS_CENTRO_CUSTOS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_PEDIDOS_DESCONTOS" for table "PEDIDOS_DESCONTOS"  */
set term ^;

create trigger TBIG_PEDIDOS_DESCONTOS for PEDIDOS_DESCONTOS
  before insert as
begin
  if ((New.PK_PEDIDOS_DESCONTOS is null) or (New.PK_PEDIDOS_DESCONTOS = 0)) then
  begin
    select R_PK_PEDIDOS_DESCONTOS from STP_GET_PK_PEDIDOS_DESCONTOS(New.FK_EMPRESAS, New.FK_PEDIDOS)
      into New.PK_PEDIDOS_DESCONTOS;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PEDIDOS_DESCONTOS', 2, 'PEDIDOS_DESCONTOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_PEDIDOS_DESCONTOS" for table "PEDIDOS_DESCONTOS"  */
set term ^;

create trigger TBU0_PEDIDOS_DESCONTOS for PEDIDOS_DESCONTOS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PEDIDOS_DESCONTOS', 3, 'PEDIDOS_DESCONTOS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_PEDIDOS_DESCONTOS" for table "PEDIDOS_DESCONTOS"  */
set term ^;

create trigger TAD0_PEDIDOS_DESCONTOS for PEDIDOS_DESCONTOS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PEDIDOS_DESCONTOS', 4, 'PEDIDOS_DESCONTOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_PEDIDOS_ENTREGA" for table "PEDIDOS_ENTREGA"  */
set term ^;

create trigger TBU0_PEDIDOS_ENTREGA for PEDIDOS_ENTREGA
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PEDIDOS_ENTREGA', 3, 'PEDIDOS_ENTREGA', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_PEDIDOS_ENTREGA" for table "PEDIDOS_ENTREGA"  */
set term ^;

create trigger TAD0_PEDIDOS_ENTREGA for PEDIDOS_ENTREGA
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PEDIDOS_ENTREGA', 4, 'PEDIDOS_ENTREGA', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TAI0_PEDIDOS_ENTREGA" for table "PEDIDOS_ENTREGA"  */
set term ^;

create trigger TAI0_PEDIDOS_ENTREGA for PEDIDOS_ENTREGA
  after insert as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PEDIDOS_ENTREGA', 2, 'PEDIDOS_ENTREGA', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_PEDIDOS_FINALIZADORAS" for table "PEDIDOS_FINALIZADORAS"  */
set term ^;

create trigger TAD0_PEDIDOS_FINALIZADORAS for PEDIDOS_FINALIZADORAS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PEDIDOS_FINALIZADORAS', 4, 'PEDIDOS_FINALIZADORAS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TAI0_PEDIDOS_FINALIZADORAS" for table "PEDIDOS_FINALIZADORAS"  */
set term ^;

create trigger TAI0_PEDIDOS_FINALIZADORAS for PEDIDOS_FINALIZADORAS
  after insert as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PEDIDOS_FINALIZADORAS', 2, 'PEDIDOS_FINALIZADORAS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TAU0_PEDIDOS_FINALIZADORAS" for table "PEDIDOS_FINALIZADORAS"  */
set term ^;

create trigger TAU0_PEDIDOS_FINALIZADORAS for PEDIDOS_FINALIZADORAS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PEDIDOS_FINALIZADORAS', 3, 'PEDIDOS_FINALIZADORAS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_PEDIDOS_HISTORICOS" for table "PEDIDOS_HISTORICOS"  */
set term ^;

create trigger TBU0_PEDIDOS_HISTORICOS for PEDIDOS_HISTORICOS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PEDIDOS_HISTORICOS', 3, 'PEDIDOS_HISTORICOS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_PEDIDOS_HISTORICOS" for table "PEDIDOS_HISTORICOS"  */
set term ^;

create trigger TBIG_PEDIDOS_HISTORICOS for PEDIDOS_HISTORICOS
  before insert as
begin
  if ((New.PK_PEDIDOS_HISTORICOS is null) or (New.PK_PEDIDOS_HISTORICOS = 0)) then
  begin
    select R_PK_PEDIDOS_HISTORICOS from STP_GET_PK_PEDIDOS_HISTORICOS(New.FK_EMPRESAS, New.FK_PEDIDOS)
      into New.PK_PEDIDOS_HISTORICOS;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PEDIDOS_HISTORICOS', 2, 'PEDIDOS_HISTORICOS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_PEDIDOS_HISTORICOS" for table "PEDIDOS_HISTORICOS"  */
set term ^;

create trigger TAD0_PEDIDOS_HISTORICOS for PEDIDOS_HISTORICOS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PEDIDOS_HISTORICOS', 4, 'PEDIDOS_HISTORICOS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_PEDIDOS_ITENS" for table "PEDIDOS_ITENS"  */
set term ^;

create trigger TBIG_PEDIDOS_ITENS for PEDIDOS_ITENS
  before insert as
  declare variable FlagImpst            smallint;
  declare variable FkTipoImpostos       smallint;
  declare variable FkFinanceiroContasCR integer;
  declare variable FkFinanceiroContasDB integer;
  declare variable VlrImpst             numeric(09, 04);
  declare variable FlagES               smallint;
  declare variable FlagDev              smallint;
begin
  if ((New.PK_PEDIDOS_ITENS is null) or (New.PK_PEDIDOS_ITENS = 0)) then
  begin
    select R_PK_PEDIDOS_ITENS from STP_GET_PK_PEDIDOS_ITENS(
           New.FK_EMPRESAS, New.FK_PEDIDOS)
      into New.PK_PEDIDOS_ITENS;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
  if ((New.FK_CARGAS_PRODUCAO is not null) and
     ( New.FK_CARGAS_PRODUCAO > 0)) then
    update PEDIDOS set
           FLAG_PROD = 1
     where FK_EMPRESAS     = New.FK_EMPRESAS
       and PK_PEDIDOS      = New.FK_PEDIDOS;
  select FLAG_ES, FLAG_DEV from GRUPOS_MOVIMENTOS
   where PK_GRUPOS_MOVIMENTOS = New.FK_GRUPOS_MOVIMENTOS
    into :FlagEs, :FlagDev;
  if (FlagDev = 1) then
    if (FlagES = 0) then
      FlagEs = 1;
    else
      FlagES = 0;
  for select Pri.FK_TIPO_IMPOSTOS, Tif.FK_FINANCEIRO_CONTAS__CR,
             Tif.FK_FINANCEIRO_CONTAS__DB, Tim.FLAG_IMPST
        from PRODUTOS_IMPOSTOS Pri, TIPO_IMPOSTOS Tim,
             TIPO_IMPOSTOS_FINANCEIRO Tif
       where Pri.FK_EMPRESAS       = New.FK_EMPRESAS
         and Pri.FK_PRODUTOS       = New.FK_PRODUTOS
         and Tif.FK_TIPO_IMPOSTOS  = Pri.FK_TIPO_IMPOSTOS
         and Tif.PK_TIPO_IMPOSTOS_FINANCEIRO = :FlagEs
         and Tim.PK_TIPO_IMPOSTOS  = Pri.FK_TIPO_IMPOSTOS
        into :FkTipoImpostos, :FkFinanceiroContasCR,
             :FkFinanceiroContasDB, :FlagImpst do
  begin
/*
0 ==> Base para ICMS
1 ==> Base para ICMS Substituicao
2 ==> Base para ICMS Isento
3 ==> Base para IPI
4 ==> Base para ISSQN
5 ==> Base para INSS
6 ==> Base para IR
7 ==> Base para PIS/COFINS/Contribuicao Social
8 ==> Base para Outros
*/
    if (FlagImpst = 0) then
      VlrImpst = (New.TOT_ITEM * New.ALQ_ICMS) / 100;
    if (FlagImpst = 1) then
      VlrImpst = (New.TOT_ITEM * New.ALQ_ICMSS) / 100;
    if (FlagImpst = 3) then
      VlrImpst = (New.TOT_ITEM * New.ALQ_IPI) / 100;
    if (FlagImpst = 4) then
      VlrImpst = (New.TOT_ITEM * New.ALQ_ISS) / 100;
    if ((FkFinanceiroContasCR is not null) and
       ( FkFinanceiroContasDB is not null) and (VlrImpst > 0)) then
    begin
      insert into PEDIDOS_ITENS_IMPOSTOS
        (FK_EMPRESAS, FK_PEDIDOS, FK_PEDIDOS_ITENS,
         FK_TIPO_IMPOSTOS, FK_FINANCEIRO_CONTAS, VLR_IMPST)
      values
        (New.FK_EMPRESAS,  New.FK_PEDIDOS, New.PK_PEDIDOS_ITENS,
         :FkTipoImpostos, :FkFinanceiroContasCR, :VlrImpst);
      VlrImpst = VlrImpst * -1;
      insert into PEDIDOS_ITENS_IMPOSTOS
        (FK_EMPRESAS, FK_PEDIDOS, FK_PEDIDOS_ITENS,
         FK_TIPO_IMPOSTOS, FK_FINANCEIRO_CONTAS, VLR_IMPST)
      values
        (New.FK_EMPRESAS,  New.FK_PEDIDOS, New.PK_PEDIDOS_ITENS,
        :FkTipoImpostos, :FkFinanceiroContasDB, :VlrImpst);
    end
  end
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PEDIDOS_ITENS', 2, 'PEDIDOS_ITENS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_PEDIDOS_ITENS" for table "PEDIDOS_ITENS"  */
set term ^;

create trigger TBU0_PEDIDOS_ITENS for PEDIDOS_ITENS
  after update as
begin
  if ((New.FK_CARGAS_PRODUCAO is not null) and 
     ( New.FK_CARGAS_PRODUCAO > 0)) then
    update PEDIDOS set
           FLAG_PROD = 1
     where FK_EMPRESAS     = New.FK_EMPRESAS
       and PK_PEDIDOS      = New.FK_PEDIDOS;
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PEDIDOS_ITENS', 3, 'PEDIDOS_ITENS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_PEDIDOS_ITENS" for table "PEDIDOS_ITENS"  */
set term ^;

create trigger TAD0_PEDIDOS_ITENS for PEDIDOS_ITENS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PEDIDOS_ITENS', 4, 'PEDIDOS_ITENS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_PEDIDOS_ITENS_CONF" for table "PEDIDOS_ITENS_CONF"  */
set term ^;

create trigger TBU0_PEDIDOS_ITENS_CONF for PEDIDOS_ITENS_CONF
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PEDIDOS_ITENS_CONF', 3, 'PEDIDOS_ITENS_CONF', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_PEDIDOS_ITENS_CONF" for table "PEDIDOS_ITENS_CONF"  */
set term ^;

create trigger TBIG_PEDIDOS_ITENS_CONF for PEDIDOS_ITENS_CONF
  before insert as
begin
  if ((New.PK_PEDIDOS_ITENS_CONF is null) or (New.PK_PEDIDOS_ITENS_CONF = 0)) then
  begin
    select R_PK_PEDIDOS_ITENS_CONF from STP_GET_PK_PEDIDOS_ITENS_CONF(New.FK_EMPRESAS,
           New.FK_PEDIDOS, New.FK_PEDIDOS_ITENS)
      into New.PK_PEDIDOS_ITENS_CONF;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PEDIDOS_ITENS_CONF', 2, 'PEDIDOS_ITENS_CONF', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_PEDIDOS_ITENS_CONF" for table "PEDIDOS_ITENS_CONF"  */
set term ^;

create trigger TAD0_PEDIDOS_ITENS_CONF for PEDIDOS_ITENS_CONF
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PEDIDOS_ITENS_CONF', 4, 'PEDIDOS_ITENS_CONF', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_PEDIDOS_ITENS_IMPOSTOS" for table "PEDIDOS_ITENS_IMPOSTOS"  */
set term ^;

create trigger TAD0_PEDIDOS_ITENS_IMPOSTOS for PEDIDOS_ITENS_IMPOSTOS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PEDIDOS_ITENS_IMPOSTOS', 4, 'PEDIDOS_ITENS_IMPOSTOS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TAI0_PEDIDOS_ITENS_IMPOSTOS" for table "PEDIDOS_ITENS_IMPOSTOS"  */
set term ^;

create trigger TAI0_PEDIDOS_ITENS_IMPOSTOS for PEDIDOS_ITENS_IMPOSTOS
  after insert as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PEDIDOS_ITENS_IMPOSTOS', 2, 'PEDIDOS_ITENS_IMPOSTOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_PEDIDOS_ITENS_IMPOSTOS" for table "PEDIDOS_ITENS_IMPOSTOS"  */
set term ^;

create trigger TBU0_PEDIDOS_ITENS_IMPOSTOS for PEDIDOS_ITENS_IMPOSTOS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PEDIDOS_ITENS_IMPOSTOS', 3, 'PEDIDOS_ITENS_IMPOSTOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TAU0_PEDIDOS_MENSAGENS" for table "PEDIDOS_MENSAGENS"  */
set term ^;

create trigger TAU0_PEDIDOS_MENSAGENS for PEDIDOS_MENSAGENS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PEDIDOS_MENSAGENS', 3, 'PEDIDOS_MENSAGENS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_PEDIDOS_MENSAGENS" for table "PEDIDOS_MENSAGENS"  */
set term ^;

create trigger TBIG_PEDIDOS_MENSAGENS for PEDIDOS_MENSAGENS
  before insert as
begin
  if ((New.PK_PEDIDOS_MENSAGENS is null) or (New.PK_PEDIDOS_MENSAGENS = 0)) then
  begin
    select R_PK_PEDIDOS_MENSAGENS from STP_GET_PK_PEDIDOS_MENSAGENS(New.FK_EMPRESAS, New.FK_PEDIDOS)
      into New.PK_PEDIDOS_MENSAGENS;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PEDIDOS_MENSAGENS', 2, 'PEDIDOS_MENSAGENS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_PEDIDOS_PARCELAS" for table "PEDIDOS_PARCELAS"  */
set term ^;

create trigger TBU0_PEDIDOS_PARCELAS for PEDIDOS_PARCELAS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PEDIDOS_PARCELAS', 3, 'PEDIDOS_PARCELAS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TAI0_PEDIDOS_PARCELAS" for table "PEDIDOS_PARCELAS"  */
set term ^;

create trigger TAI0_PEDIDOS_PARCELAS for PEDIDOS_PARCELAS
  after insert as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PEDIDOS_PARCELAS', 2, 'PEDIDOS_PARCELAS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_PEDIDOS_PARCELAS" for table "PEDIDOS_PARCELAS"  */
set term ^;

create trigger TAD0_PEDIDOS_PARCELAS for PEDIDOS_PARCELAS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PEDIDOS_PARCELAS', 4, 'PEDIDOS_PARCELAS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_PEDIDOS_PENDENCIAS" for table "PEDIDOS_PENDENCIAS"  */
set term ^;

create trigger TBU0_PEDIDOS_PENDENCIAS for PEDIDOS_PENDENCIAS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PEDIDOS_PENDENCIAS', 3, 'PEDIDOS_PENDENCIAS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_PEDIDOS_PENDENCIAS" for table "PEDIDOS_PENDENCIAS"  */
set term ^;

create trigger TAD0_PEDIDOS_PENDENCIAS for PEDIDOS_PENDENCIAS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PEDIDOS_PENDENCIAS', 4, 'PEDIDOS_PENDENCIAS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TAI0_PEDIDOS_PENDENCIAS" for table "PEDIDOS_PENDENCIAS"  */
set term ^;

create trigger TAI0_PEDIDOS_PENDENCIAS for PEDIDOS_PENDENCIAS
  after insert as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PEDIDOS_PENDENCIAS', 2, 'PEDIDOS_PENDENCIAS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TAU0_PEDIDOS_VINCULOS" for table "PEDIDOS_VINCULOS"  */
set term ^;

create trigger TAU0_PEDIDOS_VINCULOS for PEDIDOS_VINCULOS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PEDIDOS_VINCULOS', 3, 'PEDIDOS_VINCULOS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_PEDIDOS_VINCULOS" for table "PEDIDOS_VINCULOS"  */
set term ^;

create trigger TAD0_PEDIDOS_VINCULOS for PEDIDOS_VINCULOS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PEDIDOS_VINCULOS', 4, 'PEDIDOS_VINCULOS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TAI0_PEDIDOS_VINCULOS" for table "PEDIDOS_VINCULOS"  */
set term ^;

create trigger TAI0_PEDIDOS_VINCULOS for PEDIDOS_VINCULOS
  after insert as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PEDIDOS_VINCULOS', 2, 'PEDIDOS_VINCULOS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_TIPO_DESCONTOS" for table "TIPO_DESCONTOS"  */
set term ^;

create trigger TBIG_TIPO_DESCONTOS for TIPO_DESCONTOS
before insert as
begin
  if ((New.PK_TIPO_DESCONTOS is null) or (New.PK_TIPO_DESCONTOS = 0)) then
    New.PK_TIPO_DESCONTOS = Gen_Id(TIPO_DESCONTOS, 1);
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_DESCONTOS', 2, 'TIPO_DESCONTOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_TIPO_DESCONTOS" for table "TIPO_DESCONTOS"  */
set term ^;

create trigger TBU0_TIPO_DESCONTOS for TIPO_DESCONTOS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_DESCONTOS', 3, 'TIPO_DESCONTOS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_TIPO_FRETES" for table "TIPO_FRETES"  */
set term ^;

create trigger TBIG_TIPO_FRETES for TIPO_FRETES
before insert as
begin
  if ((New.PK_TIPO_FRETES is null) or (New.PK_TIPO_FRETES = 0)) then
    New.PK_TIPO_FRETES = Gen_Id(TIPO_FRETES, 1);
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_FRETES', 2, 'TIPO_FRETES', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_TIPO_FRETES" for table "TIPO_FRETES"  */
set term ^;

create trigger TBU0_TIPO_FRETES for TIPO_FRETES
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_FRETES', 3, 'TIPO_FRETES', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_TIPO_MOVIMENTOS" for table "TIPO_MOVIMENTOS"  */
set term ^;

create trigger TBIG_TIPO_MOVIMENTOS for TIPO_MOVIMENTOS
before insert as
  declare variable MaxValue integer;
begin
  if ((New.PK_TIPO_MOVIMENTOS is null) or (New.PK_TIPO_MOVIMENTOS = 0)) then
  begin
    select Max(PK_TIPO_MOVIMENTOS)
      from TIPO_MOVIMENTOS
     where FK_GRUPOS_MOVIMENTOS = New.FK_GRUPOS_MOVIMENTOS
      into :MaxValue;
    if (MaxValue is null) then
      MaxValue   = 0;
    New.PK_TIPO_MOVIMENTOS = MaxValue + 1;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
end^

set term ;^;


/*  Update trigger "TBU0_TIPO_MOVIMENTOS" for table "TIPO_MOVIMENTOS"  */
set term ^;

create trigger TBU0_TIPO_MOVIMENTOS for TIPO_MOVIMENTOS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_MOVIMENTOS', 3, 'TIPO_MOVIMENTOS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_TIPO_PAGAMENTOS" for table "TIPO_PAGAMENTOS"  */
set term ^;

create trigger TBIG_TIPO_PAGAMENTOS for TIPO_PAGAMENTOS
before insert as
begin
  if ((New.PK_TIPO_PAGAMENTOS is null) or (New.PK_TIPO_PAGAMENTOS = 0)) then
    New.PK_TIPO_PAGAMENTOS = Gen_Id(TIPO_PAGAMENTOS, 1);
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_PAGAMENTOS', 2, 'TIPO_PAGAMENTOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_TIPO_PAGAMENTOS" for table "TIPO_PAGAMENTOS"  */
set term ^;

create trigger TBU0_TIPO_PAGAMENTOS for TIPO_PAGAMENTOS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_PAGAMENTOS', 3, 'TIPO_PAGAMENTOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_TIPO_PRAZO_ENTREGA" for table "TIPO_PRAZO_ENTREGA"  */
set term ^;

create trigger TBU0_TIPO_PRAZO_ENTREGA for TIPO_PRAZO_ENTREGA
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_PRAZO_ENTREGA', 3, 'TIPO_PRAZO_ENTREGA', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_TIPO_PRAZO_ENTREGA" for table "TIPO_PRAZO_ENTREGA"  */
set term ^;

create trigger TBIG_TIPO_PRAZO_ENTREGA for TIPO_PRAZO_ENTREGA
before insert as
begin
  if ((New.PK_TIPO_PRAZO_ENTREGA is null) or (New.PK_TIPO_PRAZO_ENTREGA = 0)) then
    New.PK_TIPO_PRAZO_ENTREGA = Gen_Id(TIPO_PRAZO_ENTREGA, 1);
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_PRAZO_ENTREGA', 2, 'TIPO_PRAZO_ENTREGA', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_TIPO_PRAZO_ENTREGA" for table "TIPO_PRAZO_ENTREGA"  */
set term ^;

create trigger TAD0_TIPO_PRAZO_ENTREGA for TIPO_PRAZO_ENTREGA
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_PRAZO_ENTREGA', 4, 'TIPO_PRAZO_ENTREGA', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_TIPO_STATUS_PEDIDOS" for table "TIPO_STATUS_PEDIDOS"  */
set term ^;

create trigger TBIG_TIPO_STATUS_PEDIDOS for TIPO_STATUS_PEDIDOS
before insert as
begin
  if ((New.PK_TIPO_STATUS_PEDIDOS is null) or (New.PK_TIPO_STATUS_PEDIDOS = 0)) then
    New.PK_TIPO_STATUS_PEDIDOS = Gen_Id(TIPO_STATUS_PEDIDOS, 1);
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_STATUS_PEDIDOS', 2, 'TIPO_STATUS_PEDIDOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_TIPO_STATUS_PEDIDOS" for table "TIPO_STATUS_PEDIDOS"  */
set term ^;

create trigger TBU0_TIPO_STATUS_PEDIDOS for TIPO_STATUS_PEDIDOS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_STATUS_PEDIDOS', 3, 'TIPO_STATUS_PEDIDOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_VINCULO_TPGTO_FINALIZ" for table "VINCULO_TPGTO_FINALIZ"  */
set term ^;

create trigger TBU0_VINCULO_TPGTO_FINALIZ for VINCULO_TPGTO_FINALIZ
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'VINCULO_TPGTO_FINALIZ', 3, 'VINCULO_TPGTO_FINALIZ', current_timestamp);
end^

set term ;^;

