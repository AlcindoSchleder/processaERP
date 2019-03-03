/*==============================================================*/
/* Database name:  PROCESSA                                     */
/* DBMS name:      Friebird15x                                  */
/* Created on:     11/9/2006 15:08:14                           */
/*==============================================================*/



set term ^;

create procedure STP_GEN_DOCUMENT_FROM_ORDER (
  P_FK_EMPRESAS        integer,
  P_PK_PEDIDOS         integer,
  P_PK_PEDIDOS_ITENS   integer,
  P_QTD_PROD           numeric(18, 4)
)
returns (
  R_STATUS             smallint,
  R_FK_EMPRESAS        integer,
  R_FK_TIPO_DOCUMENTOS integer,
  R_FK_CADASTROS       integer,
  R_PK_DOCUMENTOS      integer
)
as
  declare variable FkTabelaPrecos     integer;
  declare variable FkProdutos         integer;
  declare variable FkGroupMovement    integer;
  declare variable FkTipoMovimentos   integer;
  declare variable FkTypeDiscount     integer;
  declare variable PkPedidosItens     integer;
  declare variable FkUnidades         integer;
  declare variable FkFinanceiroContas integer;
  declare variable QtdItem            integer;
  declare variable QtdDupl            integer;
  declare variable QtdVol             integer;
  declare variable NumVol             integer;
  declare variable CodIcmsEcf         smallint;
  declare variable CodIcmssEcf        smallint;
  declare variable CodIssEcf          smallint;
  declare variable CodIpiEcf          smallint;
  declare variable LstPrz             varchar(50);
  declare variable LotItem            varchar(10);
  declare variable TipoVol            varchar(20);
  declare variable RefProd            varchar(20);
  declare variable SitTrib            char(20);
  declare variable QtdProd            numeric(18, 4);
  declare variable VlrSTot            numeric(18, 4);
  declare variable VlrEntr            numeric(18, 4);
  declare variable VlrAcrDsct         numeric(18, 4);
  declare variable VlrDspAces         numeric(18, 4);
  declare variable VlrFre             numeric(18, 4);
  declare variable VlrSeg             numeric(18, 4);
  declare variable VlrBICMS           numeric(18, 4);
  declare variable VlrBICMSS          numeric(18, 4);
  declare variable VlrBISNT           numeric(18, 4);
  declare variable VlrBISS            numeric(18, 4);
  declare variable VlrBIPI            numeric(18, 4);
  declare variable VlrBOtr            numeric(18, 4);
  declare variable VlrICMS            numeric(18, 4);
  declare variable VlrICMSS           numeric(18, 4);
  declare variable VlrIPI             numeric(18, 4);
  declare variable VlrIpiItm          numeric(18, 4);
  declare variable VlrISS             numeric(18, 4);
  declare variable VlrOtr             numeric(18, 4);
  declare variable AlqtIcms           numeric(09, 4);
  declare variable AlqtIcmss          numeric(09, 4);
  declare variable AlqtIpi            numeric(09, 4);
  declare variable AlqtIss            numeric(09, 4);
  declare variable AlqtOtr            numeric(09, 4);
  declare variable VlrTot             numeric(18, 4);
  declare variable PesLiq             numeric(18, 4);
  declare variable PesBru             numeric(18, 4);
begin
  R_STATUS             = 0;
  R_FK_EMPRESAS        = P_FK_EMPRESAS;
  R_FK_TIPO_DOCUMENTOS = 0;
  R_FK_CADASTROS       = 0;
  R_PK_DOCUMENTOS      = 0;
  if ((P_FK_EMPRESAS     = 0) or (P_FK_EMPRESAS     is null)  or
      (P_PK_PEDIDOS      = 0) or (P_PK_PEDIDOS      is null)) then
  begin
    R_STATUS = -1; /* invalid parameters */
    suspend;
    exit;
  end
  VlrBICMS  = 0;
  VlrICMS   = 0;
  VlrBICMSS = 0;
  VlrICMSS  = 0;
  VlrBISNT  = 0;
  VlrBIPI   = 0;
  VlrIPI    = 0;
  VlrBISS   = 0;
  VlrISS    = 0;
  select FK_TABELA_PRECOS, FK_GRUPOS_MOVIMENTOS, FK_TIPO_DESCONTOS,
         QTD_ITEM, QTD_DUPL, QTD_VOL, NUM_VOL, LST_PRZ, TIPO_VOL,
         SUB_TOT, VLR_ENTR, VLR_ACR_DSCT, DSP_ACES, VLR_FRET, VLR_SEG,
         TOT_PED, PES_LIQ, PES_BRU, FK_CADASTROS
    from PEDIDOS
   where FK_EMPRESAS     = :P_FK_EMPRESAS
     and PK_PEDIDOS      = :P_PK_PEDIDOS
    into :FkTabelaPrecos, :FkGroupMovement, :FkTypeDiscount,
         :QtdItem, :QtdDupl, :QtdVol, :NumVol, :LstPrz, :TipoVol,
         :VlrSTot, :VlrEntr, :VlrAcrDsct, :VlrDspAces, :VlrFre, :VlrSeg,
         :VlrTot, :PesLiq, :PesBru, :R_FK_CADASTROS;
  if ((FkTabelaPrecos is null) or (FkTabelaPrecos = 0)) then
  begin
    R_STATUS = -5; /* Order not found */
    suspend;
    exit;
  end
  for select PK_TIPO_DOCUMENTOS
        from TIPO_DOCUMENTOS
       where FLAG_TDOC = 0
        into :R_FK_TIPO_DOCUMENTOS do
  begin
    break;
  end
  if ((R_FK_TIPO_DOCUMENTOS is null) or (R_FK_TIPO_DOCUMENTOS = 0)) then
  begin
    R_STATUS = -10; /* Type document not found */
    suspend;
    exit;
  end
  select R_PK_DOCUMENT
    from STP_GET_PK_DOCUMENT(:P_FK_EMPRESAS, :R_FK_TIPO_DOCUMENTOS)
    into :R_PK_DOCUMENTOS;
  if ((R_PK_DOCUMENTOS = 0) or (R_PK_DOCUMENTOS is null)) then
  begin
    R_STATUS = -20; /* can't generate primary key */
    suspend;
    exit;
  end
  insert into DOCUMENTOS
    (FK_EMPRESAS, FK_TIPO_DOCUMENTOS, FK_CADASTROS, PK_DOCUMENTOS,
     FK_GRUPOS_MOVIMENTOS, DATA_DOC, DTA_EMB, DTA_EMB_EXT,
     FLAG_BXAC, FLAG_CANC, FLAG_CTB, VLR_STOT, VLR_ENTR,
     VLR_ACR_DSCT, VLR_DSP_ACES, VLR_FRE, VLR_SEG, VLR_BICMS,
     VLR_ICMS, VLR_BICMSS, VLR_ICMSS, VLR_BISNT, VLR_BIPI, VAL_IPI,
     VLR_BISS, VLR_ISS, VAL_TOT, QTD_ITEM, QTD_DUPL, QTD_VOL, PES_LIQ,
     PES_BRU, NUM_VOL, TIPO_VOL)
  values
    (:P_FK_EMPRESAS, :R_FK_TIPO_DOCUMENTOS, :R_FK_CADASTROS, :R_PK_DOCUMENTOS,
     :FkGroupMovement, current_date, null, null,
     1, 0, 0, :VlrSTot, :VlrEntr,
     :VlrAcrDsct, :VlrDspAces, :VlrFre, :VlrSeg, :VlrBICMS,
     :VlrICMS, :VlrBICMSS, :VlrICMSS, :VlrBISNT, :VlrBIPI, :VlrIPI,
     :VlrBISS, :VlrISS, :VlrTot, :QtdItem, :QtdDupl, :QtdVol, :PesLiq,
     :PesBru, :NumVol, :TipoVol);
  insert into DOCUMENTOS_CENTRO_CUSTOS
    (FK_EMPRESAS, FK_TIPO_DOCUMENTOS, FK_CADASTROS, FK_DOCUMENTOS,
     FK_CENTRO_CUSTOS, FK_DOCUMENTOS_ITENS, PERC_CC)
     select :P_FK_EMPRESAS, :R_FK_TIPO_DOCUMENTOS, :R_FK_CADASTROS, :R_PK_DOCUMENTOS,
            FK_CENTRO_CUSTOS, null, PERC_CC
       from PEDIDOS_CENTRO_CUSTOS
      where FK_EMPRESAS      = :P_FK_EMPRESAS
        and FK_PEDIDOS       = :P_PK_PEDIDOS
        and ((FK_PEDIDOS_ITENS is null)
         or ( FK_PEDIDOS_ITENS = 0));
  QtdItem   = 0;
  if (P_QTD_PROD is null) then
    P_QTD_PROD         = 0;
  if (P_PK_PEDIDOS_ITENS is null) then
    P_PK_PEDIDOS_ITENS = 0;
  for select FK_PRODUTOS, FK_TABELA_PRECOS, ALQ_ICMS, ALQ_ICMSS,
             ALQ_IPI, ALQ_ISS, ALQ_OTR, REF_PRODUTO, SIT_TRIB,
             COD_ICMS_ECF, COD_ICMSS_ECF, COD_ISS_ECF, FK_UNIDADES,
             FK_FINANCEIRO_CONTAS, FK_TABELA_PRECOS, FK_TIPO_MOVIMENTOS,
             VLR_UNIT, QTD_ITEM, VLR_ACR_DSCT, TOT_ITEM, PK_PEDIDOS_ITENS
        from PEDIDOS_ITENS
       where FK_EMPRESAS        = :P_FK_EMPRESAS
         and FK_PEDIDOS         = :P_PK_PEDIDOS
         and ((PK_PEDIDOS_ITENS = :P_PK_PEDIDOS_ITENS)
          or  (0                = :P_PK_PEDIDOS_ITENS))
        into :FkProdutos, :FkTabelaPrecos, :AlqtIcms, :AlqtIcmss,
             :AlqtIpi, :AlqtIss,  :AlqtOtr, :RefProd, :SitTrib,
             :CodIcmsEcf, :CodIcmssEcf, :CodIssEcf, :FkUnidades,
             :FkFinanceiroContas, :FkTabelaPrecos, :FkTipoMovimentos,
             :VlrSTot, :QtdProd, :VlrAcrDsct, :VlrTot, :PkPedidosItens do
  begin
    if ((FkProdutos is null) or (FkProdutos = 0)) then
    begin
      R_STATUS = -25; /* can't generate primary key */
      suspend;
      exit;
    end
    if (((P_PK_PEDIDOS_ITENS > 0) or (P_QTD_PROD > 0)) and
       (  P_QTD_PROD < QtdProd)) then
    begin
      QtdProd = QtdProd - P_QTD_PROD;
      update PEDIDOS_ITENS set
             QTD_ITEM = :QtdProd
       where FK_EMPRESAS      = :P_FK_EMPRESAS
         and FK_PEDIDOS       = :P_PK_PEDIDOS
         and PK_PEDIDOS_ITENS = :P_PK_PEDIDOS_ITENS;
      P_QTD_PROD = QtdProd;
    end
    QtdItem = QtdItem + 1;
    VlrSTot = VlrSTot * P_QTD_PROD;
    VlrTot  = VlrSTot + VlrAcrDsct;
    if (VlrTot > 0) then
    begin
      if (AlqtIcms > 0) then
      begin
        VlrBIcms = VlrBIcms + VlrTot;
        VlrIcms  = (VlrBIcms * AlqtIcms) / 100;
      end
      if (AlqtIcmss > 0) then
      begin
        VlrBIcmss = VlrBIcmss + VlrTot;
        VlrIcmss  = (VlrBIcmss * AlqtIcmss) / 100;
      end
      if (AlqtIpi > 0) then
      begin
        VlrBIpi    = VlrBIpi + VlrTot;
        VlrIpiItm  = (VlrTot * AlqtIpi) / 100;
        VlrIpi     = (VlrBIpi * AlqtIpi) / 100;
      end
      if (AlqtIss > 0) then
      begin
        VlrBIss = VlrBIss + VlrTot;
        VlrIss  = (VlrBIss * AlqtIss) / 100;
      end
      if (AlqtOtr > 0) then
      begin
        VlrBOtr  = VlrBOtr + VlrTot;
        VlrOtr =  (VlrBOtr * AlqtOtr) / 100;
      end
      if ((AlqtIcmss > 0) or (AlqtOtr > 0) or (AlqtIss > 0) or
         ( AlqtIpi > 0) or (AlqtIcms > 0)) then
      begin
        VlrBIsnt = VlrBIsnt + VlrTot;
      end
      insert into DOCUMENTOS_ITENS
        (FK_EMPRESAS, FK_TIPO_DOCUMENTOS, FK_CADASTROS, FK_DOCUMENTOS,
         PK_DOCUMENTOS_ITENS, FK_GRUPOS_MOVIMENTOS,FK_TIPO_MOVIMENTOS,
         FK_FINANCEIRO_CONTAS, FK_UNIDADES, DTA_DOC,
         COD_REF, LOT_ITEM, QTD_ITEM, VLR_UNIT, DSCT_ITEM,
         SIT_TRIB, ALQ_ICMS, ALQ_ICMSS, ALQ_ISS, COD_ICMS_ECF, COD_ICMSS_ECF,
         COD_ISS_ECF, COD_IPI_ECF, ALQ_IPI, TOT_ITEM, TOT_SEM_DSCT)
      values
        (:P_FK_EMPRESAS, :R_FK_TIPO_DOCUMENTOS, :R_FK_CADASTROS, :R_PK_DOCUMENTOS,
         :QtdItem, :FkGroupMovement, :FkTipoMovimentos,
         :FkFinanceiroContas, :FkUnidades, current_date,
         :RefProd, :LotItem, :P_QTD_PROD, :VlrSTot, :VlrAcrDsct,
         :SitTrib, :AlqtIcms, :AlqtIcmss, :AlqtIss, :CodIcmsEcf, :CodIcmssEcf,
         :CodIssEcf, :CodIpiECF, :AlqtIpi, :VlrTot, :VlrSTot);
      insert into DOCUMENTOS_CENTRO_CUSTOS
        (FK_EMPRESAS, FK_TIPO_DOCUMENTOS, FK_CADASTROS, FK_DOCUMENTOS,
         FK_CENTRO_CUSTOS, FK_DOCUMENTOS_ITENS, PERC_CC)
         select :P_FK_EMPRESAS, :R_FK_TIPO_DOCUMENTOS, :R_FK_CADASTROS, :R_PK_DOCUMENTOS,
                FK_CENTRO_CUSTOS, :QtdItem, PERC_CC
           from PEDIDOS_CENTRO_CUSTOS
          where FK_EMPRESAS      = :P_FK_EMPRESAS
            and FK_PEDIDOS       = :P_PK_PEDIDOS
            and FK_PEDIDOS_ITENS = :PkPedidosItens;
    end
  end
  /* update taxes and qtd items */
  update DOCUMENTOS set
         QTD_ITEM     = :QtdItem,
         VLR_BICMS    = :VlrBICMSS,
         VLR_ICMS     = :VlrICMS,
         VLR_BICMSS   = :VlrBICMSS,
         VLR_ICMSS    = :VlrICMSS,
         VLR_BISS     = :VlrISS,
         VLR_ISS      = :VlrIss,
         VLR_BIPI     = :VlrBIPI,
         VAL_IPI      = :VlrIPI,
         VLR_STOT     = :VlrSTot,
         VLR_ACR_DSCT = :VlrSTot,
         VAL_TOT      = :VlrTot
   where FK_EMPRESAS        = :P_FK_EMPRESAS
     and FK_TIPO_DOCUMENTOS = :R_FK_TIPO_DOCUMENTOS
     and FK_CADASTROS       = :R_FK_CADASTROS
     and PK_DOCUMENTOS      = :R_PK_DOCUMENTOS;
end ^

set term ;^;

grant EXECUTE on procedure STP_GEN_DOCUMENT_FROM_ORDER to PUBLIC;


set term ^;

create procedure STP_GET_PK_DOCUMENTOS_ITENS (
  P_FK_EMPRESAS         integer,
  P_FK_TIPO_DOCUMENTOS  smallint,
  P_FK_CADASTROS        integer,
  P_FK_DOCUMENTOS       integer
)
returns (
  R_PK_DOCUMENTOS_ITENS smallint
)
as
begin
  R_PK_DOCUMENTOS_ITENS = null;
  if ((P_FK_EMPRESAS        is not null) and (P_FK_EMPRESAS        > 0)  and
     ( P_FK_TIPO_DOCUMENTOS is not null) and (P_FK_TIPO_DOCUMENTOS > 0)  and
     ( P_FK_CADASTROS       is not null) and (P_FK_CADASTROS       > 0)  and
     ( P_FK_DOCUMENTOS      is not null) and (P_FK_DOCUMENTOS      > 0)) then
  begin
    select QTD_ITEM
      from DOCUMENTOS
     where FK_EMPRESAS        = :P_FK_EMPRESAS
       and FK_TIPO_DOCUMENTOS = :P_FK_TIPO_DOCUMENTOS
       and FK_CADASTROS       = :P_FK_CADASTROS
       and PK_DOCUMENTOS      = :P_FK_DOCUMENTOS
      into :R_PK_DOCUMENTOS_ITENS;
    if (R_PK_DOCUMENTOS_ITENS is null) then
      R_PK_DOCUMENTOS_ITENS   = 0;
    R_PK_DOCUMENTOS_ITENS = R_PK_DOCUMENTOS_ITENS + 1;
    update DOCUMENTOS set
           QTD_ITEM = :R_PK_DOCUMENTOS_ITENS
     where FK_EMPRESAS        = :P_FK_EMPRESAS
       and FK_TIPO_DOCUMENTOS = :P_FK_TIPO_DOCUMENTOS
       and FK_CADASTROS       = :P_FK_CADASTROS
       and PK_DOCUMENTOS      = :P_FK_DOCUMENTOS;
  end
  suspend;
end ^

set term ;^;

grant EXECUTE on procedure STP_GET_PK_DOCUMENTOS_ITENS to PUBLIC;


set term ^;

create procedure STP_GET_PK_DUPLICATAS (
  P_FK_EMPRESAS         integer,
  P_FK_TIPO_DOCUMENTOS  smallint,
  P_FK_CADASTROS        integer,
  P_FK_DOCUMENTOS       integer
)
returns (
  R_PK_DUPLICATAS smallint
)
as
begin
  R_PK_DUPLICATAS = null;
  if ((P_FK_EMPRESAS        is not null) and (P_FK_EMPRESAS        > 0)  and
     ( P_FK_TIPO_DOCUMENTOS is not null) and (P_FK_TIPO_DOCUMENTOS > 0)  and
     ( P_FK_CADASTROS       is not null) and (P_FK_CADASTROS       > 0)  and
     ( P_FK_DOCUMENTOS      is not null) and (P_FK_DOCUMENTOS      > 0)) then
  begin
    select QTD_DUPL
      from DOCUMENTOS
     where FK_EMPRESAS        = :P_FK_EMPRESAS
       and FK_TIPO_DOCUMENTOS = :P_FK_TIPO_DOCUMENTOS
       and FK_CADASTROS       = :P_FK_CADASTROS
       and PK_DOCUMENTOS      = :P_FK_DOCUMENTOS
      into :R_PK_DUPLICATAS;
    if (R_PK_DUPLICATAS is null) then
      R_PK_DUPLICATAS = 0;
    R_PK_DUPLICATAS = R_PK_DUPLICATAS + 1;
    update DOCUMENTOS set
           QTD_DUPL = :R_PK_DUPLICATAS
     where FK_EMPRESAS        = :P_FK_EMPRESAS
       and FK_TIPO_DOCUMENTOS = :P_FK_TIPO_DOCUMENTOS
       and FK_CADASTROS       = :P_FK_CADASTROS
       and PK_DOCUMENTOS      = :P_FK_DOCUMENTOS;
  end
  suspend;
end ^

set term ;^;


/*  Update trigger "TBU0_DOCUMENTOS" for table "DOCUMENTOS"  */
set term ^;

create trigger TBU0_DOCUMENTOS for DOCUMENTOS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'DOCUMENTOS', 3, 'DOCUMENTOS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_DOCUMENTOS" for table "DOCUMENTOS"  */
set term ^;

create trigger TBIG_DOCUMENTOS for DOCUMENTOS
  before insert as
begin
  if ((New.PK_DOCUMENTOS is null) or (New.PK_DOCUMENTOS = 0)) then
  begin
    select R_PK_DOCUMENT 
      from STP_GET_PK_DOCUMENT(New.FK_EMPRESAS,
                               New.FK_TIPO_DOCUMENTOS)
      into New.PK_DOCUMENTOS;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'DOCUMENTOS', 2, 'DOCUMENTOS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_DOCUMENTOS" for table "DOCUMENTOS"  */
set term ^;

create trigger TAD0_DOCUMENTOS for DOCUMENTOS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'DOCUMENTOS', 4, 'DOCUMENTOS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_DOCUMENTOS_CANCELADOS" for table "DOCUMENTOS_CANCELADOS"  */
set term ^;

create trigger TAD0_DOCUMENTOS_CANCELADOS for DOCUMENTOS_CANCELADOS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'DOCUMENTOS_CANCELADOS', 4, 'DOCUMENTOS_CANCELADOS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TAI0_DOCUMENTOS_CANCELADOS" for table "DOCUMENTOS_CANCELADOS"  */
set term ^;

create trigger TAI0_DOCUMENTOS_CANCELADOS for DOCUMENTOS_CANCELADOS
  after insert as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'DOCUMENTOS_CANCELADOS', 2, 'DOCUMENTOS_CANCELADOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_DOCUMENTOS_CANCELADOS" for table "DOCUMENTOS_CANCELADOS"  */
set term ^;

create trigger TBU0_DOCUMENTOS_CANCELADOS for DOCUMENTOS_CANCELADOS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'DOCUMENTOS_CANCELADOS', 3, 'DOCUMENTOS_CANCELADOS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TAI0_DOCUMENTOS_CENTRO_CUSTOS" for table "DOCUMENTOS_CENTRO_CUSTOS"  */
set term ^;

create trigger TAI0_DOCUMENTOS_CENTRO_CUSTOS for DOCUMENTOS_CENTRO_CUSTOS
  after insert as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'DOCUMENTOS_CENTRO_CUSTOS', 2, 'DOCUMENTOS_CENTRO_CUSTOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_DOCUMENTOS_CENTRO_CUSTOS" for table "DOCUMENTOS_CENTRO_CUSTOS"  */
set term ^;

create trigger TBU0_DOCUMENTOS_CENTRO_CUSTOS for DOCUMENTOS_CENTRO_CUSTOS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'DOCUMENTOS_CENTRO_CUSTOS', 3, 'DOCUMENTOS_CENTRO_CUSTOS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_DOCUMENTOS_CENTRO_CUSTOS" for table "DOCUMENTOS_CENTRO_CUSTOS"  */
set term ^;

create trigger TAD0_DOCUMENTOS_CENTRO_CUSTOS for DOCUMENTOS_CENTRO_CUSTOS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'DOCUMENTOS_CENTRO_CUSTOS', 4, 'DOCUMENTOS_CENTRO_CUSTOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_DOCUMENTOS_FATURAMENTOS" for table "DOCUMENTOS_FATURAMENTOS"  */
set term ^;

create trigger TBU0_DOCUMENTOS_FATURAMENTOS for DOCUMENTOS_FATURAMENTOS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'DOCUMENTOS_FATURAMENTOS', 3, 'DOCUMENTOS_FATURAMENTOS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TAI0_DOCUMENTOS_FATURAMENTOS" for table "DOCUMENTOS_FATURAMENTOS"  */
set term ^;

create trigger TAI0_DOCUMENTOS_FATURAMENTOS for DOCUMENTOS_FATURAMENTOS
  after insert as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'DOCUMENTOS_FATURAMENTOS', 2, 'DOCUMENTOS_FATURAMENTOS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_DOCUMENTOS_FATURAMENTOS" for table "DOCUMENTOS_FATURAMENTOS"  */
set term ^;

create trigger TAD0_DOCUMENTOS_FATURAMENTOS for DOCUMENTOS_FATURAMENTOS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'DOCUMENTOS_FATURAMENTOS', 4, 'DOCUMENTOS_FATURAMENTOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_DOCUMENTOS_FRETES" for table "DOCUMENTOS_FRETES"  */
set term ^;

create trigger TBU0_DOCUMENTOS_FRETES for DOCUMENTOS_FRETES
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'DOCUMENTOS_FRETES', 3, 'DOCUMENTOS_FRETES', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TAI0_DOCUMENTOS_FRETES" for table "DOCUMENTOS_FRETES"  */
set term ^;

create trigger TAI0_DOCUMENTOS_FRETES for DOCUMENTOS_FRETES
  after insert as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'DOCUMENTOS_FRETES', 2, 'DOCUMENTOS_FRETES', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_DOCUMENTOS_FRETES" for table "DOCUMENTOS_FRETES"  */
set term ^;

create trigger TAD0_DOCUMENTOS_FRETES for DOCUMENTOS_FRETES
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'DOCUMENTOS_FRETES', 4, 'DOCUMENTOS_FRETES', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_DOCUMENTOS_ITENS" for table "DOCUMENTOS_ITENS"  */
set term ^;

create trigger TBU0_DOCUMENTOS_ITENS for DOCUMENTOS_ITENS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'DOCUMENTOS_ITENS', 3, 'DOCUMENTOS_ITENS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_DOCUMENTOS_ITENS" for table "DOCUMENTOS_ITENS"  */
set term ^;

create trigger TBIG_DOCUMENTOS_ITENS for DOCUMENTOS_ITENS
  before insert as
begin
  if ((New.PK_DOCUMENTOS_ITENS is null) or (New.PK_DOCUMENTOS_ITENS = 0)) then
  begin
    select R_PK_DOCUMENTOS_ITENS from STP_GET_PK_DOCUMENTOS_ITENS(New.FK_EMPRESAS,
           New.FK_TIPO_DOCUMENTOS, New.FK_CADASTROS, New.FK_DOCUMENTOS)
      into New.PK_DOCUMENTOS_ITENS;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'DOCUMENTOS_ITENS', 2, 'DOCUMENTOS_ITENS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_DOCUMENTOS_ITENS" for table "DOCUMENTOS_ITENS"  */
set term ^;

create trigger TAD0_DOCUMENTOS_ITENS for DOCUMENTOS_ITENS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'DOCUMENTOS_ITENS', 4, 'DOCUMENTOS_ITENS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_DUPLICATAS" for table "DUPLICATAS"  */
set term ^;

create trigger TBU0_DUPLICATAS for DUPLICATAS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'DUPLICATAS', 3, 'DUPLICATAS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_DUPLICATAS" for table "DUPLICATAS"  */
set term ^;

create trigger TBIG_DUPLICATAS for DUPLICATAS
  before insert as
begin
  if ((New.PK_DUPLICATAS is null) or (New.PK_DUPLICATAS = 0)) then
  begin
    select R_PK_DUPLICATAS from STP_GET_PK_DUPLICATAS(New.FK_EMPRESAS,
           New.FK_TIPO_DOCUMENTOS, New.FK_CADASTROS, New.FK_DOCUMENTOS)
      into New.PK_DUPLICATAS;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'DUPLICATAS', 2, 'DUPLICATAS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_DUPLICATAS" for table "DUPLICATAS"  */
set term ^;

create trigger TAD0_DUPLICATAS for DUPLICATAS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'DUPLICATAS', 4, 'DUPLICATAS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_DUPLICATAS_PARCIAL" for table "DUPLICATAS_PARCIAL"  */
set term ^;

create trigger TBU0_DUPLICATAS_PARCIAL for DUPLICATAS_PARCIAL
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'DUPLICATAS_PARCIAL', 3, 'DUPLICATAS_PARCIAL', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TAI0_DUPLICATAS_PARCIAL" for table "DUPLICATAS_PARCIAL"  */
set term ^;

create trigger TAI0_DUPLICATAS_PARCIAL for DUPLICATAS_PARCIAL
  after insert as
begin
  update DUPLICATAS set
         FLAG_PARC = 1
   where FK_EMPRESAS        = New.FK_EMPRESAS
     and FK_TIPO_DOCUMENTOS = New.FK_TIPO_DOCUMENTOS
     and FK_DOCUMENTOS      = New.FK_DOCUMENTOS
     and PK_DUPLICATAS      = New.FK_DUPLICATAS;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'DUPLICATAS_PARCIAL', 2, 'DUPLICATAS_PARCIAL', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_DUPLICATAS_PARCIAL" for table "DUPLICATAS_PARCIAL"  */
set term ^;

create trigger TAD0_DUPLICATAS_PARCIAL for DUPLICATAS_PARCIAL
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'DUPLICATAS_PARCIAL', 4, 'DUPLICATAS_PARCIAL', current_timestamp);
end^

set term ;^;

