/*==============================================================*/
/* Database name:  PROCESSA                                     */
/* DBMS name:      Friebird15x                                  */
/* Created on:     11/9/2006 10:47:31                           */
/*==============================================================*/



set term ^;

create procedure STP_CALC_AVERANGE (
  P_FK_EMPRESAS integer,
  P_FK_PRODUTOS integer
)
returns (
  R_AVG_IN  double precision,
  R_AVG_OUT double precision
)
as
  declare variable TotalIn       double precision;
  declare variable TotalOut      double precision;
  declare variable TotalDays     integer;
  declare variable QtdDCMed      integer;
  declare variable DateIni       date;
  declare variable QtdDays       integer;
begin
/* select the quantity of days for the averange consuption and the period of calc
   stored in the table PARAMETROS_GLOBAIS */
  select QTD_DCMED, PER_CVMED 
    from PARAMETROS_GLOBAIS
   where PK_PARAMETROS_GLOBAIS = 1
    into :QtdDCMed, :TotalDays;
/* select sale quantity of the product */
  select Min(DTHR_SLD)
    from PRODUTOS_SALDOS
   where FK_EMPRESAS = :P_FK_EMPRESAS
     and FK_PRODUTOS = :P_FK_PRODUTOS
     and FLAG_TSLD   < 2
     and DTHR_SLD   <= current_timestamp
    into :DateIni;
  if (DateIni is null) then
    QtdDays = 1;
  else
    QtdDays = Cast((Cast(DateIni as date) - current_date) as integer);
  if (QtdDays = 0) then
    QtdDays = 1;
  DateIni = current_timestamp - TotalDays;
  if (QtdDays < TotalDays) then
    TotalDays = QtdDays;
  select Sum(QTD_ENTRADA), Sum(QTD_SAIDA)
    from PRODUTOS_SALDOS
   where FK_EMPRESAS = :P_FK_EMPRESAS
     and FK_PRODUTOS = :P_FK_PRODUTOS
     and FLAG_TSLD   < 2
     and DTHR_SLD   >= :DateIni
    into :TotalIn, :TotalOut;
   if (TotalIn is null) then
     TotalIn = 0;
   if (TotalOut is null) then
     TotalOut = 0;
/* calc the day consuption of the product dividing then sales total by total days */
  R_AVG_IN  = TotalIn / TotalDays;
  R_AVG_OUT = TotalOut / TotalDays;
  suspend;
end ^

set term ;^;

grant EXECUTE on procedure STP_CALC_AVERANGE to PUBLIC;


set term ^;

create procedure STP_GENERATE_REFERENCE (
  P_PK_PRODUTOS_GRUPOS smallint
)
returns (
  R_FK_PRODUTOS_GRUPOS smallint,
  R_COD_GREF           varchar(3),
  R_SEQUENCE           smallint,
  R_REFERENCE          varchar(20)
)
as
  declare variable AlfaRef varchar(3);
  declare variable SeqRef  integer;
begin
  select Pgr.FK_PRODUTOS_GRUPOS, Prf.COD_GREF, Prf.SEQ_REF 
    from PRODUTOS_GRUPOS Pgr, PRODUTOS_REFERENCIAS Prf
   where Pgr.PK_PRODUTOS_GRUPOS = :P_PK_PRODUTOS_GRUPOS
     and Prf.FK_PRODUTOS_GRUPOS = Pgr.PK_PRODUTOS_GRUPOS
    into :R_FK_PRODUTOS_GRUPOS, :AlfaRef, :SeqRef;
  if (SeqRef is null) then
    SeqRef   = 0;
  SeqRef               = SeqRef + 1;
  R_COD_GREF           = AlfaRef;
  R_SEQUENCE           = SeqRef;
  R_REFERENCE          = Cast(R_FK_PRODUTOS_GRUPOS as varchar(03)) || '-' ||
           AlfaRef || '-' || Cast(SeqRef as varchar(04));
  update PRODUTOS_REFERENCIAS set
    SEQ_REF = :SeqRef
   where FK_PRODUTOS_GRUPOS = :P_PK_PRODUTOS_GRUPOS;
  suspend;
end ^

set term  ;^;

grant EXECUTE on procedure STP_GENERATE_REFERENCE to PUBLIC;


set term ^;

create procedure STP_GET_ALL_TAXES_FROM_INSUMO (
  P_PK_PRODUTOS integer
)
returns (
  R_FK_EMPRESAS      integer, 
  R_DSC_IMPS         varchar(30),
  R_RAZ_SOC          varchar(50),
  R_FK_TIPO_IMPOSTOS smallint,
  R_FK_PRODUTOS      integer
) as
begin
  for select PK_EMPRESAS, RAZ_SOC
        from EMPRESAS
       order by PK_EMPRESAS
        into :R_FK_EMPRESAS, :R_RAZ_SOC do
  begin
    R_FK_TIPO_IMPOSTOS = null;
    R_DSC_IMPS         = null;
    for select PK_TIPO_IMPOSTOS, DSC_IMPS
          from TIPO_IMPOSTOS
         order by DSC_IMPS
          into :R_FK_TIPO_IMPOSTOS, :R_DSC_IMPS do
    begin
      R_FK_PRODUTOS = null;
      select FK_PRODUTOS from PRODUTOS_IMPOSTOS
       where FK_EMPRESAS      = :R_FK_EMPRESAS
         and FK_PRODUTOS      = :P_PK_PRODUTOS
         and FK_TIPO_IMPOSTOS = :R_FK_TIPO_IMPOSTOS
        into :R_FK_PRODUTOS;
      if (R_FK_PRODUTOS is null) then
        R_FK_PRODUTOS = 0;
      suspend;
    end
    R_FK_EMPRESAS = null;
    R_RAZ_SOC     = null;
  end
end ^

set term ;^;

grant EXECUTE on procedure STP_GET_ALL_TAXES_FROM_INSUMO to PUBLIC;


set term ^;

create procedure STP_GET_CHILD_PRODUCTS_GROUPS (
  P_PK_PRODUTOS_GRUPOS integer
)
returns (
  R_PK_PRODUTOS_GRUPOS integer,
  R_FK_PRODUTOS_GRUPOS integer,
  R_MASK_CLASS         varchar(50),
  R_DSC_PGRU           varchar(30),
  R_LEV_CLASS          smallint,
  R_SEQ_CLASS          smallint,
  R_FLAG_LAST_LEVEL    smallint
)
as
  declare variable FkProdutosGrupos integer;
begin
  for select PK_PRODUTOS_GRUPOS, FK_PRODUTOS_GRUPOS, MASK_CLASS,
             DSC_PGRU, LEV_CLASS, SEQ_CLASS, FLAG_LAST_LEVEL
        from PRODUTOS_GRUPOS
       where PK_PRODUTOS_GRUPOS <> FK_PRODUTOS_GRUPOS
         and FK_PRODUTOS_GRUPOS = :P_PK_PRODUTOS_GRUPOS
       order by MASK_CLASS
        into :FkProdutosGrupos, :R_FK_PRODUTOS_GRUPOS, :R_MASK_CLASS, 
             :R_DSC_PGRU, :R_LEV_CLASS, :R_SEQ_CLASS, :R_FLAG_LAST_LEVEL do
  begin
    R_PK_PRODUTOS_GRUPOS = FkProdutosGrupos;
    suspend;
    for select R_PK_PRODUTOS_GRUPOS, R_FK_PRODUTOS_GRUPOS, R_MASK_CLASS, 
               R_DSC_PGRU, R_LEV_CLASS, R_SEQ_CLASS, R_FLAG_LAST_LEVEL
          from STP_GET_CHILD_PRODUCTS_GROUPS(:FkProdutosGrupos)
          into :R_PK_PRODUTOS_GRUPOS, :R_FK_PRODUTOS_GRUPOS, :R_MASK_CLASS,
               :R_DSC_PGRU, :R_LEV_CLASS, :R_SEQ_CLASS, :R_FLAG_LAST_LEVEL do
    begin
      suspend;
    end
  end
end ^

set term ;^;

grant EXECUTE on procedure STP_GET_CHILD_PRODUCTS_GROUPS to PUBLIC;


set term ^;

create procedure STP_GET_PK_PRODUCTS (
  P_FK_EMPRESAS          smallint,
  P_PRODUCT_CODE         varchar(30),
  P_CODE_TYPE            smallint
)
returns (
  R_PK_PRODUTOS         integer,
  R_FK_UNIDADES         integer,
  R_DSC_PROD            varchar(50),
  R_FLAG_FRAC           smallint,
  R_FLAG_FUNI           smallint,
  R_FLAG_TUNI           smallint,
  R_FLAG_ATV            smallint,
  R_FLAG_EMP            smallint,
  R_FLAG_CMPR           smallint,
  R_FAT_CONV            numeric(18, 6),
  R_QTD_ESTQ            numeric(09, 4),
  R_QTD_RSRV            numeric(09, 4),
  R_QTD_GRNT            numeric(09, 4),
  R_QTD_TOT             numeric(11, 4),
  R_MNMO_UNI            char(2)
)
as
begin
/* Types of P_CODE_TYPE must be:*/
/* 0 ==> Product Reference     */
/* 1 ==> Product Code          */
/* 2 ==> Bar Code              */
/* 3 ==> Supplier Code         */
  R_PK_PRODUTOS = 0;
  if ((P_CODE_TYPE is null) or (P_CODE_TYPE < 0) or (P_CODE_TYPE > 3)) then exit;
  select Prd.PK_PRODUTOS, Prd.DSC_PROD, Uni.FLAG_FRAC,
         Prd.FLAG_ATV, Pet.FLAG_EMP, Pcm.FLAG_CMPR,
         Pct.QTD_ESTQ, Pct.QTD_RSRV, Pct.QTD_GRNT,
         Prd.QTD_UNI, Uni.FLAG_FUNI, Uni.FLAG_TUNI,
         Uni.MNMO_UNI, Uni.PK_UNIDADES
    from PRODUTOS_CODIGOS Pcd
    join PRODUTOS Prd
      on Prd.PK_PRODUTOS         = Pcd.FK_PRODUTOS
    join UNIDADES Uni
      on Uni.PK_UNIDADES         = Prd.FK_UNIDADES
    left outer join PRODUTOS_ESTOQUES Pet
      on Pet.FK_PRODUTOS         = Pcd.FK_PRODUTOS
    left outer join PRODUTOS_COMPRAS Pcm
      on Pcm.FK_PRODUTOS         = Pcd.FK_PRODUTOS
    left outer join PRODUTOS_CUSTOS Pct
      on Pct.FK_EMPRESAS         = :P_FK_EMPRESAS
     and Pct.FK_PRODUTOS         = Pcd.FK_PRODUTOS
   where Pcd.PK_PRODUTOS_CODIGOS = :P_PRODUCT_CODE
     and Pcd.FLAG_TCODE          = :P_CODE_TYPE
    into :R_PK_PRODUTOS, :R_DSC_PROD, :R_FLAG_FRAC,
         :R_FLAG_ATV, :R_FLAG_EMP, :R_FLAG_CMPR,
         :R_QTD_ESTQ, :R_QTD_RSRV, :R_QTD_GRNT,
         :R_FAT_CONV, :R_FLAG_FUNI, :R_FLAG_TUNI,
         :R_MNMO_UNI, :R_FK_UNIDADES;
  if (R_QTD_ESTQ is null) then R_QTD_ESTQ = 0;
  if (R_QTD_RSRV is null) then R_QTD_RSRV = 0;
  if (R_QTD_GRNT is null) then R_QTD_GRNT = 0;
  if ((R_PK_PRODUTOS is null) or (R_PK_PRODUTOS <= 0)) then
    R_QTD_TOT = 0;
  else
    R_QTD_TOT = R_QTD_ESTQ - (R_QTD_RSRV + R_QTD_GRNT);
  suspend;
end ^

set term  ;^;

grant EXECUTE on procedure STP_GET_PK_PRODUCTS to PUBLIC;


set term ^;

create procedure STP_GET_PK_PRODUTOS_COMPOSICOES (
  P_FK_PRODUTOS smallint
)
returns (
  R_PK_PRODUTOS_COMPOSICOES smallint
)
as
begin
  R_PK_PRODUTOS_COMPOSICOES = -1;
  if ((P_FK_PRODUTOS is not null) and (P_FK_PRODUTOS > 0)) then 
  begin
    select KC_PRODUTOS_COMPOSICOES 
      from PRODUTOS
     where PK_PRODUTOS = :P_FK_PRODUTOS
      into :R_PK_PRODUTOS_COMPOSICOES;
    if ((R_PK_PRODUTOS_COMPOSICOES is not null) and 
       ( R_PK_PRODUTOS_COMPOSICOES >= 0)) then
    begin
      R_PK_PRODUTOS_COMPOSICOES = R_PK_PRODUTOS_COMPOSICOES + 10;
      update PRODUTOS set
             KC_PRODUTOS_COMPOSICOES = :R_PK_PRODUTOS_COMPOSICOES
       where PK_PRODUTOS = :P_FK_PRODUTOS;
    end
  end
  suspend;
end ^

set term ;^;

grant EXECUTE on procedure STP_GET_PK_PRODUTOS_COMPOSICOES to PUBLIC;


set term ^;

create procedure STP_GET_PK_PRODUTOS_FORN_COMP (
  P_FK_EMPRESAS        integer,
  P_FK_PRODUTOS        smallint,
  P_FK_VW_FORNECEDORES smallint
)
returns (
  R_PK_PRODUTOS_FONECEDORES_COMP smallint
)
as
begin
  R_PK_PRODUTOS_FONECEDORES_COMP = -1;
  if ((P_FK_EMPRESAS        is not null) and (P_FK_EMPRESAS        > 0)  and
      (P_FK_PRODUTOS        is not null) and (P_FK_PRODUTOS        > 0)  and
      (P_FK_VW_FORNECEDORES is not null) and (P_FK_VW_FORNECEDORES > 0)) then
  begin
    select KC_PRODUTOS_FONECEDORES_COMP 
      from PRODUTOS_FORNECEDORES
     where FK_EMPRESAS        = :P_FK_EMPRESAS
       and FK_PRODUTOS        = :P_FK_PRODUTOS
       and FK_VW_FORNECEDORES = :P_FK_VW_FORNECEDORES
      into :R_PK_PRODUTOS_FONECEDORES_COMP;
    if ((R_PK_PRODUTOS_FONECEDORES_COMP is not null) and 
       ( R_PK_PRODUTOS_FONECEDORES_COMP >= 0)) then
    begin
      R_PK_PRODUTOS_FONECEDORES_COMP = R_PK_PRODUTOS_FONECEDORES_COMP + 10;
      update PRODUTOS_FORNECEDORES set
             KC_PRODUTOS_FONECEDORES_COMP = :R_PK_PRODUTOS_FONECEDORES_COMP
       where FK_EMPRESAS        = :P_FK_EMPRESAS
         and FK_PRODUTOS        = :P_FK_PRODUTOS
         and FK_VW_FORNECEDORES = :P_FK_VW_FORNECEDORES;
    end
  end
  suspend;
end ^

set term ;^;

grant EXECUTE on procedure STP_GET_PK_PRODUTOS_FORN_COMP to PUBLIC;


set term ^;

create procedure STP_GET_PK_PRODUTOS_GRUPOS
returns (
  R_PK_PRODUTOS_GRUPOS integer
)
as
begin
  R_PK_PRODUTOS_GRUPOS = Gen_Id(PRODUTOS_GRUPOS, 1);
  suspend;
end ^

set term ;^;


set term ^;

create procedure STP_GET_PK_PRODUTOS_HISTORICOS (
  P_FK_EMPRESAS        integer,
  P_FK_PRODUTOS        smallint
)
returns (
  R_PK_PRODUTOS_HISTORICOS smallint
)
as
begin
  R_PK_PRODUTOS_HISTORICOS = -1;
  if ((P_FK_EMPRESAS is not null) and (P_FK_EMPRESAS > 0)  and
      (P_FK_PRODUTOS is not null) and (P_FK_PRODUTOS > 0)) then
  begin
    select KC_PRODUTOS_HISTORICOS 
      from PRODUTOS_CUSTOS
     where FK_EMPRESAS = :P_FK_EMPRESAS
       and FK_PRODUTOS = :P_FK_PRODUTOS
      into :R_PK_PRODUTOS_HISTORICOS;
    if ((R_PK_PRODUTOS_HISTORICOS is not null) and 
       ( R_PK_PRODUTOS_HISTORICOS >= 0)) then
    begin
      R_PK_PRODUTOS_HISTORICOS = R_PK_PRODUTOS_HISTORICOS + 1;
      update PRODUTOS_CUSTOS set
             KC_PRODUTOS_HISTORICOS = :R_PK_PRODUTOS_HISTORICOS
       where FK_EMPRESAS = :P_FK_EMPRESAS
         and FK_PRODUTOS = :P_FK_PRODUTOS;
    end
  end
  suspend;
end ^

set term ;^;

grant EXECUTE on procedure STP_GET_PK_PRODUTOS_HISTORICOS to PUBLIC;


set term ^;

create procedure STP_GET_PK_PRODUTOS_SALDOS (
  P_FK_EMPRESAS        integer
)
returns (
  R_PK_PRODUTOS_SALDOS integer
)
as
begin
  R_PK_PRODUTOS_SALDOS = null;
  if ((P_FK_EMPRESAS is not null) and (P_FK_EMPRESAS > 0)) then
  begin
    select KC_PRODUTOS_SALDOS
      from PARAMETROS_ESTQ
     where FK_EMPRESAS = :P_FK_EMPRESAS
      into :R_PK_PRODUTOS_SALDOS;
    if (R_PK_PRODUTOS_SALDOS is not null) then
    begin
      R_PK_PRODUTOS_SALDOS = R_PK_PRODUTOS_SALDOS + 1;
      update PARAMETROS_ESTQ set
             KC_PRODUTOS_SALDOS = :R_PK_PRODUTOS_SALDOS
       where FK_EMPRESAS        = :P_FK_EMPRESAS;
    end
  end
  suspend;
end ^

set term ;^;

grant EXECUTE on procedure STP_GET_PK_PRODUTOS_SALDOS to PUBLIC;


set term ^;

create procedure STP_GET_PK_PRODUTOS_SALDO_ALMX (
  P_FK_EMPRESAS        integer
)
returns (
  R_PK_PRODUTOS_SALDO_ALMX integer
)
as
begin
  R_PK_PRODUTOS_SALDO_ALMX = null;
  if ((P_FK_EMPRESAS is not null) and (P_FK_EMPRESAS > 0)) then
  begin
    select KC_PRODUTOS_SALDO_ALMX
      from PARAMETROS_ESTQ
     where FK_EMPRESAS = :P_FK_EMPRESAS
      into :R_PK_PRODUTOS_SALDO_ALMX;
    if (R_PK_PRODUTOS_SALDO_ALMX is not null) then
    begin
      R_PK_PRODUTOS_SALDO_ALMX = R_PK_PRODUTOS_SALDO_ALMX + 1;
      update PARAMETROS_ESTQ set
             KC_PRODUTOS_SALDO_ALMX = :R_PK_PRODUTOS_SALDO_ALMX
       where FK_EMPRESAS            = :P_FK_EMPRESAS;
    end
  end
  suspend;
end ^

set term ;^;


set term ^;

create procedure STP_GET_PK_TIPO_PRODUTOS
returns (
  R_PK_TIPO_PRODUTOS integer
)
as
begin
  R_PK_TIPO_PRODUTOS = Gen_Id(TIPO_PRODUTOS, 1);
  suspend;
end ^

set term ;^;


set term ^;

create procedure STP_GET_PRODUCT_GROUPS
returns (
  R_PK_PRODUTOS_GRUPOS integer,
  R_FK_PRODUTOS_GRUPOS integer,
  R_MASK_CLASS         varchar(50),
  R_DSC_PGRU           varchar(30),
  R_LEV_CLASS          smallint,
  R_SEQ_CLASS          smallint,
  R_FLAG_LAST_LEVEL    smallint
)
as
begin
  for select PK_PRODUTOS_GRUPOS, FK_PRODUTOS_GRUPOS, MASK_CLASS,
             DSC_PGRU, LEV_CLASS, SEQ_CLASS, FLAG_LAST_LEVEL
        from PRODUTOS_GRUPOS
       where PK_PRODUTOS_GRUPOS = FK_PRODUTOS_GRUPOS
       order by PK_PRODUTOS_GRUPOS, SEQ_CLASS
        into :R_PK_PRODUTOS_GRUPOS, :R_FK_PRODUTOS_GRUPOS, :R_MASK_CLASS, 
             :R_DSC_PGRU, :R_LEV_CLASS, :R_SEQ_CLASS, :R_FLAG_LAST_LEVEL do
  begin
    suspend;
    for select R_PK_PRODUTOS_GRUPOS, R_FK_PRODUTOS_GRUPOS, R_MASK_CLASS, 
               R_DSC_PGRU, R_LEV_CLASS, R_SEQ_CLASS, R_FLAG_LAST_LEVEL
          from STP_GET_CHILD_PRODUCTS_GROUPS(:R_PK_PRODUTOS_GRUPOS)
          into :R_PK_PRODUTOS_GRUPOS, :R_FK_PRODUTOS_GRUPOS, :R_MASK_CLASS,
               :R_DSC_PGRU, :R_LEV_CLASS, :R_SEQ_CLASS, :R_FLAG_LAST_LEVEL do
    begin
      suspend;
    end
  end
end ^


set term ;^;

grant EXECUTE on procedure STP_GET_PRODUCT_GROUPS to PUBLIC;


set term ^;

create procedure STP_SET_NEW_PRICES_PER_LINE (
    P_FK_EMPRESAS      integer,
    P_FK_TABELA_PRECOS integer,
    P_FK_LINHAS        integer,
    P_IDX_RJST         numeric(9, 4)
)
returns (
    R_STATUS           smallint
)
as
  declare variable QtdRows    integer;
  declare variable PkProdutos integer;
  declare variable FkEmpresas integer;
  declare variable TabPre     integer;
  declare variable PreVda     double precision;
begin
  R_STATUS = 0;
  if ((P_FK_EMPRESAS is null) or
     ((P_FK_TABELA_PRECOS is null) or (P_FK_TABELA_PRECOS = 0)) or
     ((P_FK_LINHAS is null) or (P_FK_LINHAS = 0)) or
     ((P_IDX_RJST is null) or (P_IDX_RJST = 0))) then
  begin
    R_STATUS = -1;
    suspend;
    exit;
  end
  select Count(*) from TABELA_PRECOS
   where PK_TABELA_PRECOS = :P_FK_TABELA_PRECOS
    into :TabPre;
  if ((TabPre is null) or (TabPre = 0)) then
  begin
    R_STATUS = -5;
    suspend;
    exit;
  end
  for select Prd.PK_PRODUTOS, Ppr.FK_TABELA_PRECOS, Ppr.PRE_VDA,
             Ppr.FK_EMPRESAS
        from PRODUTOS Prd, PRODUTOS_VENDAS Pvd,
             PRODUTOS_PRECOS Ppr
       where Pvd.FK_LINHAS     = :P_FK_LINHAS
         and Prd.PK_PRODUTOS   = Pvd.FK_PRODUTOS
         and ((Ppr.FK_EMPRESAS = :P_FK_EMPRESAS)
          or ( 0               = :P_FK_EMPRESAS))
         and Ppr.FK_PRODUTOS   = Prd.PK_PRODUTOS
        into :PkProdutos, :TabPre, PreVda, :FkEmpresas do
  begin
    if (PreVda is null) then PreVda = 0;
    if ((TabPre is not null) and (TabPre > 0)) then
    begin
      if (PreVda > 0) then
        PreVda = PreVda * P_IDX_RJST;
      select Count(*) from PRODUTOS_PRECOS
       where ((FK_EMPRESAS    = :P_FK_EMPRESAS)
          or ( 0              = :P_FK_EMPRESAS))
         and FK_PRODUTOS      = :PkProdutos
         and FK_TABELA_PRECOS = :TabPre
        into :QtdRows;
      if (QtdRows is null) then QtdRows = 0;
      if (QtdRows = 0) then
        update PRODUTOS_PRECOS set
               PRE_VDA          = :PreVda,
               FK_TABELA_PRECOS = :P_FK_TABELA_PRECOS
         where ((FK_EMPRESAS    = :P_FK_EMPRESAS)
            or ( 0              = :P_FK_EMPRESAS))
           and FK_PRODUTOS      = :PkProdutos
           and FK_TABELA_PRECOS = :TabPre;
      else
        insert into PRODUTOS_PRECOS
          (FK_EMPRESAS, FK_PRODUTOS, FK_TABELA_PRECOS, PRE_VDA, FLAG_FIX)
        values
          (:FkEmpresas, :PkProdutos, :P_FK_TABELA_PRECOS, :PreVda, 0);
    end
  end
  suspend;
end ^

set term ;^;

grant EXECUTE on procedure STP_SET_NEW_PRICES_PER_LINE to PUBLIC;


set term ^;

create procedure STP_UPDATE_ALM_ESTQ (
  P_FK_EMPRESAS        integer,
  P_FK_PRODUTOS        integer,
  P_FK_TIPO_MOVIM_ESTQ integer,
  P_FK_TIPO_DOCUMENTOS integer,
  P_FK_CADASTROS       integer,
  P_FK_ALMOXARIFADOS   integer,
  P_FK_LOTACAO         integer,
  P_NUM_DOC            integer,
  P_QTD_BAIXA          numeric(9, 4)
)
returns (
 R_STATUS integer
)
as
   declare variable FlagTMov        smallint;
   declare variable FlagMvEstq      smallint;
   declare variable FlagMvRsrv      smallint;
   declare variable FlagMvGrnt      smallint;
   declare variable FlagMvQrnt      smallint;
   declare variable FlagOpEstq      smallint;
   declare variable FlagOpRsrv      smallint;
   declare variable FlagOpGrnt      smallint;
   declare variable FlagOpQrnt      smallint;
   declare variable FlagGenHst      smallint;
   declare variable FkProduct       integer;
   declare variable DtaInv          date;
   declare variable DtaRsrv         date;
   declare variable QtdEntrada      double precision;
   declare variable QtdSaida        double precision;
   declare variable QtdSaldo        double precision;
   declare variable QtdEstqTab      double precision;
   declare variable QtdEstq         double precision;
   declare variable QtdRsrv         double precision;
   declare variable QtdGrnt         double precision;
   declare variable QtdQrnt         double precision;
begin
  R_STATUS = 0;
  if ((P_FK_EMPRESAS        is null) or
      (P_FK_EMPRESAS        <= 0)    or
      (P_FK_PRODUTOS        is null) or
      (P_FK_PRODUTOS        <= 0)    or
      (P_FK_TIPO_MOVIM_ESTQ is null) or
      (P_FK_TIPO_MOVIM_ESTQ <= 0)    or
      (P_FK_TIPO_DOCUMENTOS is null) or
      (P_FK_TIPO_DOCUMENTOS <= 0)    or
      (P_FK_ALMOXARIFADOS   is null) or
      (P_FK_ALMOXARIFADOS   <= 0)    or
      (P_NUM_DOC            is null) or
      (P_NUM_DOC            <= 0)    or
      (P_QTD_BAIXA          is null) or
      (P_QTD_BAIXA          <= 0))   then
  begin
    R_STATUS = -1;
    suspend;
    exit;
  end
/* select flags from TIPO_MOVIM_ESTQ to know the actions of supllies */
  select FLAG_MVESTQ, FLAG_MVRSRV, FLAG_MVGRNT, FLAG_MVQRNT,
         FLAG_OPESTQ, FLAG_OPRSRV, FLAG_OPGRNT, FLAG_OPQRNT,
         FLAG_GENHST, FLAG_TMOV
    from TIPO_MOVIM_ESTQ
   where PK_TIPO_MOVIM_ESTQ = :P_FK_TIPO_MOVIM_ESTQ
    into :FlagMvEstq, :FlagMvRsrv, :FlagMvGrnt, :FlagMvQrnt,
         :FlagOpEstq, :FlagOpRsrv, :FlagOpGrnt, :FlagOpQrnt,
         :FlagGenHst, :FlagTMov;
/* select quantity of suplly from PRODUTOS_ESTOQUES */
  select QTD_ESTQ, QTD_RSRV, QTD_GRNT, QTD_ESTQ_QR,
         DTA_UINV, DTA_URSV, FK_PRODUTOS
    from PRODUTOS_ESTOQUES
   where FK_EMPRESAS      = :P_FK_EMPRESAS
     and FK_ALMOXARIFADOS = :P_FK_ALMOXARIFADOS
     and FK_PRODUTOS      = :P_FK_PRODUTOS
    into :QtdEstqTab, :QtdRsrv, :QtdGrnt, :QtdQrnt,
         :DtaInv, :DtaRsrv, :FkProduct;
/* apply operations */
  if (FkProduct is null) then
  begin
    QtdQrnt    = 0;
    QtdEstqTab = 0;
    QtdEstq    = 0;
    QtdGrnt    = 0;
    QtdRsrv    = 0;
    insert into PRODUTOS_ESTOQUES
      (FK_EMPRESAS, FK_PRODUTOS, FK_ALMOXARIFADOS, 
       QTD_ESTQ, QTD_GRNT, QTD_RSRV, QTD_EMAX, QTD_EMIN,
       QTD_ESTQ_QR, FLAG_EMP)
    values
      (:P_FK_EMPRESAS, :P_FK_PRODUTOS, :P_FK_ALMOXARIFADOS, 
       :QtdEstq, :QtdGrnt, :QtdRsrv, 0, 0, :QtdQrnt, 1);
  end
  else
    QtdEstq = QtdEstqTab;
  if (FlagMvEstq = 1) then
    if (FlagOpEstq = 0) then
      QtdEstq = P_QTD_BAIXA;
    else
      if (FlagOpEstq = 1) then
        QtdEstq = QtdEstqTab + P_QTD_BAIXA;
      else
        QtdEstq = QtdEstqTab - P_QTD_BAIXA;
  if (FlagMvRsrv = 1) then
  begin
    DtaRsrv = current_date;
    if (FlagOpRsrv = 0) then
      QtdRsrv = P_QTD_BAIXA;
    else
      if (FlagOpRsrv = 1) then
        QtdRsrv = QtdRsrv + P_QTD_BAIXA;
      else
        QtdRsrv = QtdRsrv - P_QTD_BAIXA;
  end
  if (FlagMvGrnt = 1) then
    if (FlagOpGrnt = 0) then
      QtdGrnt = P_QTD_BAIXA;
    else
      if (FlagOpGrnt = 1) then
        QtdGrnt = QtdGrnt + P_QTD_BAIXA;
      else
        QtdGrnt = QtdGrnt - P_QTD_BAIXA;
  if (FlagMvQrnt = 1) then
    if (FlagOpQrnt = 0) then
      QtdGrnt = P_QTD_BAIXA;
    else
      if (FlagOpQrnt = 1) then
        QtdGrnt = QtdQrnt + P_QTD_BAIXA;
      else
        QtdGrnt = QtdQrnt - P_QTD_BAIXA;
  if (FlagTMov = 3) then
    DtaInv = current_date;
  /* update INSUMOS_ESTOQUES */
  update PRODUTOS_ESTOQUES set
         QTD_ESTQ    = :QtdEstq,
         QTD_RSRV    = :QtdRsrv,
         QTD_GRNT    = :QtdGrnt,
         QTD_ESTQ_QR = :QtdQrnt,
         DTA_UMOV    = current_date,
         DTA_UINV    = :DtaInv,
         DTA_URSV    = :DtaRsrv
   where FK_EMPRESAS      = :P_FK_EMPRESAS
     and FK_ALMOXARIFADOS = :P_FK_ALMOXARIFADOS
     and FK_PRODUTOS      = :P_FK_PRODUTOS;
  QtdEntrada = 0;
  QtdSaida   = 0;
  if ((FlagGenHst = 1) and (FlagMvEstq = 1)) then
  begin
    select first(1) SLD_INS
      from PRODUTOS_SALDO_ALMX
     where FK_EMPRESAS      = :P_FK_EMPRESAS
       and FK_ALMOXARIFADOS = :P_FK_ALMOXARIFADOS
       and FK_PRODUTOS      = :P_FK_PRODUTOS
     order by DTHR_SLD desc
      into :QtdSaldo;
    if (QtdSaldo is null) then
      if (FkProduct is null) then
        QtdSaldo = QtdEstq;
      else
        QtdSaldo = QtdEstqTab;
    if (FlagTMov = 0) then
    begin
      QtdEntrada = P_QTD_BAIXA;
      QtdSaldo   = QtdSaldo + QtdEntrada;
    end
    if (FlagTMov in (1, 2)) then
    begin
      QtdSaida   = P_QTD_BAIXA;
      QtdSaldo   = QtdSaldo - QtdSaida;
    end
    if (FlagTMov = 3) then
    begin
      if (P_QTD_BAIXA > QtdSaldo) then
        QtdEntrada = P_QTD_BAIXA - QtdSaldo;
      else
        QtdSaida   = QtdSaldo - P_QTD_BAIXA;
      QtdSaldo   = P_QTD_BAIXA;
    end
    insert into PRODUTOS_SALDO_ALMX
      (FK_EMPRESAS, FK_PRODUTOS, FK_ALMOXARIFADOS, DTHR_SLD,
       NUM_DOC, FK_CADASTROS, FK_TIPO_MOVIM_ESTQ, FK_TIPO_DOCUMENTOS, 
       QTD_ENTRADA, QTD_SAIDA, FLAG_TSLD, SLD_INS)
    values
      (:P_FK_EMPRESAS, :P_FK_PRODUTOS, :P_FK_ALMOXARIFADOS,
       current_timestamp, :P_NUM_DOC, :P_FK_CADASTROS,
       :P_FK_TIPO_MOVIM_ESTQ, :P_FK_TIPO_DOCUMENTOS, 
       :QtdEntrada, :QtdSaida, :FlagTMov,  :QtdSaldo);
  end
  if ((FlagMvEstq = 1) and (P_FK_LOTACAO is not null) and (P_FK_LOTACAO > 0)) then
  begin
    /* Calcula os estoques da lotacao do item */
    FkProduct = null;
    select QTD_LOT, FK_PRODUTOS
      from PRODUTOS_LOTACOES
     where FK_EMPRESAS      = :P_FK_EMPRESAS
       and FK_PRODUTOS      = :P_FK_PRODUTOS
       and FK_ALMOXARIFADOS = :P_FK_ALMOXARIFADOS
       and FK_LOTACOES      = :P_FK_LOTACAO
      into :QtdEstq, :FkProduct;
    if (FkProduct is null) then
    begin
      insert into PRODUTOS_LOTACOES 
        (FK_EMPRESAS, FK_PRODUTOS, FK_ALMOXARIFADOS, FK_LOTACOES, QTD_LOT)
      values
        (:P_FK_EMPRESAS, :P_FK_PRODUTOS, :P_FK_ALMOXARIFADOS, :P_FK_LOTACAO, 0);
      QtdEstq = 0;
    end
    if (FlagOpEstq = 0) then
      QtdEstq = P_QTD_BAIXA;
    else
      if (FlagOpEstq = 1) then
        QtdEstq = QtdEstq + P_QTD_BAIXA;
      else
        QtdEstq = QtdEstq - P_QTD_BAIXA;
    update PRODUTOS_LOTACOES set
           QTD_LOT  = :QtdEstq
     where FK_EMPRESAS      = :P_FK_EMPRESAS
       and FK_PRODUTOS      = :P_FK_PRODUTOS
       and FK_ALMOXARIFADOS = :P_FK_ALMOXARIFADOS
       and FK_LOTACOES      = :P_FK_LOTACAO;
  end
  suspend;
end ^

set term  ;^;

grant EXECUTE on procedure STP_UPDATE_ALM_ESTQ to PUBLIC;


set term ^;

create procedure STP_UPDATE_GEN_ESTQ (
  P_FK_EMPRESAS        integer,
  P_FK_PRODUTOS        integer,
  P_FK_TIPO_MOVIM_ESTQ integer,
  P_FK_TIPO_DOCUMENTOS integer,
  P_FK_CADASTROS       integer,
  P_NUM_DOC            integer,
  P_QTD_BAIXA          numeric(9, 4)
)
returns (
  R_STATUS integer
)
as
  declare variable FlagTMov        smallint;
  declare variable FlagMvEstq      smallint;
  declare variable FlagMvRsrv      smallint;
  declare variable FlagMvGrnt      smallint;
  declare variable FlagMvQrnt      smallint;
  declare variable FlagMvPedF      smallint;
  declare variable FlagOpEstq      smallint;
  declare variable FlagOpRsrv      smallint;
  declare variable FlagOpGrnt      smallint;
  declare variable FlagOpQrnt      smallint;
  declare variable FlagOpPedF      smallint;
  declare variable FlagGenHst      smallint;
  declare variable FkProduct       integer;
  declare variable DiasEstqIn      integer;
  declare variable DiasEstq        double precision;
  declare variable DtaInv          date;
  declare variable DtaRsrv         date;
  declare variable QtdEntrada      double precision;
  declare variable QtdSaida        double precision;
  declare variable QtdSaldo        double precision;
  declare variable QtdEstqTab      double precision;
  declare variable QtdEstq         double precision;
  declare variable QtdRsrv         double precision;
  declare variable QtdGrnt         double precision;
  declare variable QtdQrnt         double precision;
  declare variable QtdPedF         double precision;
  declare variable AvgIn           double precision;
  declare variable AvgOut          double precision;
begin
  R_STATUS = 0;
  if ((P_FK_EMPRESAS        is null) or
      (P_FK_EMPRESAS        <= 0)    or
      (P_FK_PRODUTOS        is null) or
      (P_FK_PRODUTOS        <= 0)    or
      (P_FK_TIPO_MOVIM_ESTQ is null) or
      (P_FK_TIPO_MOVIM_ESTQ <= 0)    or
      (P_FK_TIPO_DOCUMENTOS is null) or
      (P_FK_TIPO_DOCUMENTOS <= 0)    or
      (P_NUM_DOC            is null) or
      (P_NUM_DOC            <= 0)    or
      (P_QTD_BAIXA          is null) or
      (P_QTD_BAIXA          <= 0))   then
  begin
    R_STATUS = -1;
    suspend;
    exit;
  end
/* select flags from TIPO_MOVIM_ESTQ to know the actions of supllies */
  select FLAG_MVESTQ, FLAG_MVRSRV, FLAG_MVGRNT, FLAG_MVQRNT, FLAG_MVPEDF,
         FLAG_OPESTQ, FLAG_OPRSRV, FLAG_OPGRNT, FLAG_OPQRNT, FLAG_OPPEDF,
         FLAG_GENHST, FLAG_TMOV
    from TIPO_MOVIM_ESTQ
   where PK_TIPO_MOVIM_ESTQ = :P_FK_TIPO_MOVIM_ESTQ
    into :FlagMvEstq, :FlagMvRsrv, :FlagMvGrnt, :FlagMvQrnt, :FlagMvPedF,
         :FlagOpEstq, :FlagOpRsrv, :FlagOpGrnt, :FlagOpQrnt, :FlagOpPedF,
         :FlagGenHst, :FlagTMov;
/* select quantity of suplly from INSUMOS_CUSTOS or PECAS_ESTOQUES*/
  select QTD_ESTQ, QTD_RSRV, QTD_GRNT, QTD_ESTQ_QR, QTD_PEDF,
         DTA_UINV, DTA_URSV, FK_PRODUTOS
    from PRODUTOS_CUSTOS
   where FK_EMPRESAS = :P_FK_EMPRESAS
     and FK_PRODUTOS = :P_FK_PRODUTOS
    into :QtdEstqTab, :QtdRsrv, :QtdGrnt, :QtdQrnt, :QtdPedF,
         :DtaInv, :DtaRsrv, :FkProduct;
  /* if product not exist in the table then insert it */
  if (FkProduct is null) then
  begin
    QtdEstqTab = 0;
    QtdRsrv    = 0;
    QtdGrnt    = 0;
    QtdQrnt    = 0;
    QtdPedF    = 0;
    insert into PRODUTOS_CUSTOS
      (FK_EMPRESAS, FK_PRODUTOS, FLAG_RJST)
    values
      (:P_FK_EMPRESAS, :P_FK_PRODUTOS, 0);
  end
  else
    QtdEstq = QtdEstqTab;
/* apply operations */
  if (FlagMvEstq = 1) then
    if (FlagOpEstq = 0) then
      QtdEstq = P_QTD_BAIXA;
    else
      if (FlagOpEstq = 1) then
        QtdEstq = QtdEstqTab + P_QTD_BAIXA;
      else
        QtdEstq = QtdEstqTab - P_QTD_BAIXA;
  if (FlagMvRsrv = 1) then
  begin
    DtaRsrv = current_date;
    if (FlagOpRsrv = 0) then
      QtdRsrv = P_QTD_BAIXA;
    else
      if (FlagOpRsrv = 1) then
        QtdRsrv = QtdRsrv + P_QTD_BAIXA;
      else
        QtdRsrv = QtdRsrv - P_QTD_BAIXA;
  end
  if (FlagMvGrnt = 1) then
    if (FlagOpGrnt = 0) then
      QtdGrnt = P_QTD_BAIXA;
    else
      if (FlagOpGrnt = 1) then
        QtdGrnt = QtdGrnt + P_QTD_BAIXA;
      else
        QtdGrnt = QtdGrnt - P_QTD_BAIXA;
  if (FlagMvQrnt = 1) then
    if (FlagOpQrnt = 0) then
      QtdQrnt = P_QTD_BAIXA;
    else
      if (FlagOpQrnt = 1) then
        QtdQrnt = QtdQrnt + P_QTD_BAIXA;
      else
        QtdQrnt = QtdQrnt - P_QTD_BAIXA;
  if (FlagMvPedF = 1) then
    if (FlagOpPedF = 0) then
      QtdPedF = P_QTD_BAIXA;
    else
      if (FlagOpPedF = 1) then
        QtdPedF = QtdPedF + P_QTD_BAIXA;
      else
        QtdPedF = QtdPedF - P_QTD_BAIXA;
  if (FlagTMov = 3) then
    DtaInv = current_date;
  QtdEntrada = 0;
  QtdSaida   = 0;
  if ((FlagGenHst = 1) and (FlagMvEstq = 1) and (P_QTD_BAIXA > 0)) then
  begin
    select First(1) SLD_INS
      from PRODUTOS_SALDOS
     where FK_EMPRESAS = :P_FK_EMPRESAS
       and FK_PRODUTOS = :P_FK_PRODUTOS
     order by DTHR_SLD desc
      into :QtdSaldo;
    if (QtdSaldo is null) then
      if (FkProduct is null) then
        QtdSaldo = QtdEstq;
      else
        QtdSaldo = QtdEstqTab;
    if (FlagTMov = 0) then
    begin
      QtdEntrada = P_QTD_BAIXA;
      QtdSaldo   = QtdSaldo + QtdEntrada;
    end
    if ((FlagTMov = 1) or (FlagTMov = 2)) then
    begin
      QtdSaida   = P_QTD_BAIXA;
      QtdSaldo   = QtdSaldo - QtdSaida;
    end
    if (FlagTMov = 3) then
    begin
      if (P_QTD_BAIXA > QtdSaldo) then
        QtdEntrada = P_QTD_BAIXA - QtdSaldo;
      else
        QtdSaida   = QtdSaldo - P_QTD_BAIXA;
      QtdSaldo   = P_QTD_BAIXA;
    end
    insert into PRODUTOS_SALDOS
      (FK_EMPRESAS, FK_PRODUTOS, DTHR_SLD, FK_CADASTROS, FK_TIPO_MOVIM_ESTQ,
       FK_TIPO_DOCUMENTOS, NUM_DOC, QTD_ENTRADA, QTD_SAIDA, FLAG_TSLD, SLD_INS)
    values
      (:P_FK_EMPRESAS, :P_FK_PRODUTOS, current_timestamp, :P_FK_CADASTROS,
       :P_FK_TIPO_MOVIM_ESTQ, :P_FK_TIPO_DOCUMENTOS, :P_NUM_DOC,
       :QtdEntrada, :QtdSaida, :FlagTMov, :QtdSaldo);
  end
/* calc midle consuption */
  select R_AVG_IN, R_AVG_OUT
    from STP_CALC_AVERANGE(:P_FK_EMPRESAS, :P_FK_PRODUTOS)
    into :AvgIn, :AvgOut;
  DiasEstq = 0;
  if (AvgOut > 0) then
    DiasEstq = QtdEstq / AvgOut;
  DiasEstqIn = Cast(DiasEstq as integer);
  /* update PRODUTOS_CUSTOS */
  update PRODUTOS_CUSTOS set
         QTD_ESTQ      = :QtdEstq,
         QTD_RSRV      = :QtdRsrv,
         QTD_GRNT      = :QtdGrnt,
         QTD_ESTQ_QR   = :QtdQrnt,
         QTD_PEDF      = :QtdPedF,
         DTA_UMOV      = current_date,
         QTD_CMP_MED   = :AvgOut,
         QTD_CNS_MED   = :AvgIn,
         QTD_DIAS_ESTQ = :DiasEstqIn,
         DTA_UINV      = :DtaInv,
         DTA_URSV      = :DtaRsrv
   where FK_EMPRESAS = :P_FK_EMPRESAS
     and FK_PRODUTOS = :P_FK_PRODUTOS;
  suspend;
end ^

set term  ;^;

grant EXECUTE on procedure STP_UPDATE_GEN_ESTQ to PUBLIC;


set term ^;

create procedure STP_UPDATE_SUPPLIES (
  P_FK_EMPRESAS        integer,
  P_FK_PRODUTOS        integer,
  P_FK_TIPO_MOVIM_ESTQ integer,
  P_FK_TIPO_DOCUMENTOS integer,
  P_FK_ALMOXARIFADOS   integer,
  P_FK_ALMOXARIFADOS_D integer,
  P_FK_LOTACOES        integer,
  P_FK_LOTACOES_D      integer,
  P_FK_CADASTROS       integer,
  P_NUM_DOC            integer,
  P_QTD_BAIXA          numeric(9, 4)
)
returns (
 R_STATUS integer
)
as
  declare variable FlagTBaixa      smallint;
  declare variable FlagTMov        smallint;
  declare variable FkTipoMovimEstq smallint;
  declare variable FkAlmoxOutput   smallint;
  declare variable FkAlmoxInput    smallint;
begin
  R_STATUS = 0;
  if ((P_FK_EMPRESAS        is not null) and
      (P_FK_EMPRESAS        > 0)         and
      (P_FK_PRODUTOS        is not null) and
      (P_FK_PRODUTOS        > 0)         and
      (P_FK_TIPO_MOVIM_ESTQ is not null) and
      (P_FK_TIPO_MOVIM_ESTQ > 0)         and
      (P_FK_TIPO_DOCUMENTOS is not null) and
      (P_FK_TIPO_DOCUMENTOS > 0)         and
      (P_NUM_DOC            is not null) and
      (P_NUM_DOC            > 0)         and
      (P_QTD_BAIXA          is not null) and
      (P_QTD_BAIXA          > 0))        then
  begin
  /* select flags from TIPO_MOVIM_ESTQ to know the actions of supllies */
    select FLAG_TBAIXA, FLAG_TMOV, FK_TIPO_MOVIM_ESTQ
      from TIPO_MOVIM_ESTQ
     where PK_TIPO_MOVIM_ESTQ = :P_FK_TIPO_MOVIM_ESTQ
      into :FlagTBaixa, :FlagTMov, :FkTipoMovimEstq;
/*  FlagTMov
0 ==> Entrada
1 ==> Saída
2 ==> Transferência
3 ==> Ajuste / Inventario
*/
    if (FlagTBaixa > 0) then
    begin
      /* if P_FK_ALMOXARIFADOS is null then select default almox */
      if ((FlagTMov in (1, 2)) and
         ((P_FK_ALMOXARIFADOS is null) or (P_FK_ALMOXARIFADOS = 0))) then
      begin
        select FK_ALMOXARIFADOS
          from PARAMETROS_ESTQ
         where FK_EMPRESAS = :P_FK_EMPRESAS
          into :FkAlmoxOutput;
        if (FkAlmoxOutput is null) then
        begin
          R_STATUS = -10; /* Missing Almox */
          suspend;
          exit;
        end
      end
      else
        FkAlmoxOutput = P_FK_ALMOXARIFADOS;
      if ((FlagTMov in (0, 2, 3)) and
         ((P_FK_ALMOXARIFADOS_D is null) or (P_FK_ALMOXARIFADOS_D = 0))) then
      begin
        select FK_ALMOXARIFADOS
          from PARAMETROS_ESTQ
         where FK_EMPRESAS = :P_FK_EMPRESAS
          into :FkAlmoxInput;
        if (FkAlmoxInput is null) then
        begin
          R_STATUS = -5; /* Missing Destination Almox */
          suspend;
          exit;
        end
      end
      else
        FkAlmoxInput = P_FK_ALMOXARIFADOS_D;
    end
/*  FlagTBaixa
  0 ==> Estoque Geral
  1 ==> Estoque Almoxarifados
  2 ==> Estoque Geral e Almoxarifados
*/
  /* apply operations in supplies of general supply */
    if (FlagTBaixa in (0, 2)) then
      select R_STATUS from STP_UPDATE_GEN_ESTQ(:P_FK_EMPRESAS, :P_FK_PRODUTOS,
             :P_FK_TIPO_MOVIM_ESTQ, :P_FK_TIPO_DOCUMENTOS, :P_FK_CADASTROS,
             :P_NUM_DOC, :P_QTD_BAIXA)
        into :R_STATUS;
  /* apply operations in supplies of the almox */
    if (FlagTBaixa in (1, 2)) then
    begin
      if (FlagTMov in (1, 2)) then
        select R_STATUS from STP_UPDATE_ALM_ESTQ(:P_FK_EMPRESAS, :P_FK_PRODUTOS,
               :P_FK_TIPO_MOVIM_ESTQ, :P_FK_TIPO_DOCUMENTOS, :P_FK_CADASTROS,
               :FkAlmoxOutput, :P_FK_LOTACOES, :P_NUM_DOC, :P_QTD_BAIXA)
          into :R_STATUS;
    /* apply operations in supplies of the destination almox */
      if (FlagTMov in (0, 2, 3)) then
        select R_STATUS from STP_UPDATE_ALM_ESTQ(:P_FK_EMPRESAS, :P_FK_PRODUTOS,
               :P_FK_TIPO_MOVIM_ESTQ, :P_FK_TIPO_DOCUMENTOS, :P_FK_CADASTROS,
               :FkAlmoxInput, :P_FK_LOTACOES_D, :P_NUM_DOC, :P_QTD_BAIXA)
          into :R_STATUS;
    end
  end
  suspend;
end ^

set term  ;^;

grant EXECUTE on procedure STP_UPDATE_SUPPLIES to PUBLIC;


/*  Insert trigger "TBIG_ALMOXARIFADOS" for table "ALMOXARIFADOS"  */
set term ^;

create trigger TBIG_ALMOXARIFADOS for ALMOXARIFADOS
before insert as
begin
  if ((New.PK_ALMOXARIFADOS is null) or (New.PK_ALMOXARIFADOS = 0)) then
    New.PK_ALMOXARIFADOS = Gen_Id(ALMOXARIFADOS, 1);
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'ALMOXARIFADOS', 2, 'ALMOXARIFADOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_ALMOXARIFADOS" for table "ALMOXARIFADOS"  */
set term ^;

create trigger TBU0_ALMOXARIFADOS for ALMOXARIFADOS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'ALMOXARIFADOS', 3, 'ALMOXARIFADOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_COMPOSICOES" for table "COMPOSICOES"  */
set term ^;

create trigger TBU0_COMPOSICOES for COMPOSICOES
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'COMPOSICOES', 3, 'COMPOSICOES', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_COMPOSICOES" for table "COMPOSICOES"  */
set term ^;

create trigger TBIG_COMPOSICOES for COMPOSICOES
before insert as
  declare variable MaxValue integer;
begin
  if ((New.PK_COMPOSICOES is null) or (New.PK_COMPOSICOES = 0)) then
  begin
    select Max(PK_COMPOSICOES)
      from COMPOSICOES
     where FK_PRODUTOS         = New.FK_PRODUTOS
       and FK_TIPO_COMPOSICOES = New.FK_TIPO_COMPOSICOES
      into :MaxValue;
    if (MaxValue is null) then
      MaxValue   = 0;
    New.PK_COMPOSICOES = MaxValue + 1;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
end^

set term ;^;


/*  Insert trigger "TBIG_LINHAS" for table "LINHAS"  */
set term ^;

create trigger TBIG_LINHAS for LINHAS
before insert as
begin
  if ((New.PK_LINHAS is null) or (New.PK_LINHAS = 0)) then
    New.PK_LINHAS = Gen_Id(LINHAS, 1);
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'LINHAS', 2, 'LINHAS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_LINHAS" for table "LINHAS"  */
set term ^;

create trigger TBU0_LINHAS for LINHAS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'LINHAS', 3, 'LINHAS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_LOTACOES" for table "LOTACOES"  */
set term ^;

create trigger TBIG_LOTACOES for LOTACOES
before insert as
  declare variable MaxValue integer;
begin
  if ((New.PK_LOTACOES is null) or (New.PK_LOTACOES = 0)) then
  begin
    select Max(PK_LOTACOES)
      from LOTACOES
     where FK_EMPRESAS      = New.FK_EMPRESAS
       and FK_ALMOXARIFADOS = New.FK_ALMOXARIFADOS
      into :MaxValue;
    if (MaxValue is null) then
      MaxValue   = 0;
    New.PK_LOTACOES = MaxValue + 1;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
end^

set term ;^;


/*  Update trigger "TBU0_LOTACOES" for table "LOTACOES"  */
set term ^;

create trigger TBU0_LOTACOES for LOTACOES
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'LOTACOES', 3, 'LOTACOES', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_PARAMETROS_ESTQ" for table "PARAMETROS_ESTQ"  */
set term ^;

create trigger TBU0_PARAMETROS_ESTQ for PARAMETROS_ESTQ
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PARAMETROS_ESTQ', 3, 'PARAMETROS_ESTQ', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_PRODUTOS" for table "PRODUTOS"  */
set term ^;

create trigger TBU0_PRODUTOS for PRODUTOS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
end;^

set term ;^;


/*  Insert trigger "TBIG_PRODUTOS" for table "PRODUTOS"  */
set term ^;

create trigger TBIG_PRODUTOS for PRODUTOS
before insert as
begin
  if ((New.PK_PRODUTOS is null) or (New.PK_PRODUTOS = 0)) then
    New.PK_PRODUTOS = Gen_Id(PRODUTOS, 1);
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PRODUTOS', 2, 'PRODUTOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_PRODUTOS_CARACTERISTICA" for table "PRODUTOS_CARACTERISTICAS"  */
set term ^;

create trigger TBU0_PRODUTOS_CARACTERISTICA for PRODUTOS_CARACTERISTICAS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PRODUTOS_CARACTERISTICAS', 3, 'PRODUTOS_CARACTERISTICAS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_PRODUTOS_CODIGOS" for table "PRODUTOS_CODIGOS"  */
set term ^;

create trigger TBU0_PRODUTOS_CODIGOS for PRODUTOS_CODIGOS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PRODUTOS_CODIGOS', 3, 'PRODUTOS_CODIGOS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_PRODUTOS_CODIGOS" for table "PRODUTOS_CODIGOS"  */
set term ^;

create trigger TBIG_PRODUTOS_CODIGOS for PRODUTOS_CODIGOS
before insert as
  declare variable MaxValue integer;
begin
  if ((New.PK_PRODUTOS_CODIGOS is null) or (New.PK_PRODUTOS_CODIGOS = 0)) then
  begin
    select Max(PK_PRODUTOS_CODIGOS)
      from PRODUTOS_CODIGOS
     where FK_PRODUTOS = New.FK_PRODUTOS
      into :MaxValue;
    if (MaxValue is null) then
      MaxValue   = 0;
    New.PK_PRODUTOS_CODIGOS = MaxValue + 1;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
end^

set term ;^;


/*  Update trigger "TBU0_PRODUTOS_COMPOSICOES" for table "PRODUTOS_COMPOSICOES"  */
set term ^;

create trigger TBU0_PRODUTOS_COMPOSICOES for PRODUTOS_COMPOSICOES
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PRODUTOS_COMPOSICOES', 3, 'PRODUTOS_COMPOSICOES', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_PRODUTOS_COMPOSICOES" for table "PRODUTOS_COMPOSICOES"  */
set term ^;

create trigger TBIG_PRODUTOS_COMPOSICOES for PRODUTOS_COMPOSICOES
  before insert as
begin
  if ((New.PK_PRODUTOS_COMPOSICOES is null) or
     ( New.PK_PRODUTOS_COMPOSICOES = 0)) then
  begin
    select R_PK_PRODUTOS_COMPOSICOES 
      from STP_GET_PK_PRODUTOS_COMPOSICOES(New.FK_PRODUTOS)
      into New.PK_PRODUTOS_COMPOSICOES;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
end^

set term ;^;


/*  Update trigger "TBU0_PRODUTOS_COMPRAS" for table "PRODUTOS_COMPRAS"  */
set term ^;

create trigger TBU0_PRODUTOS_COMPRAS for PRODUTOS_COMPRAS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PRODUTOS_COMPRAS', 3, 'PRODUTOS_COMPRAS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TAI0_PRODUTOS_COMPRAS" for table "PRODUTOS_COMPRAS"  */
set term ^;

create trigger TAI0_PRODUTOS_COMPRAS for PRODUTOS_COMPRAS
  after insert as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PRODUTOS_COMPRAS', 2, 'PRODUTOS_COMPRAS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_PRODUTOS_COMPRAS" for table "PRODUTOS_COMPRAS"  */
set term ^;

create trigger TAD0_PRODUTOS_COMPRAS for PRODUTOS_COMPRAS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PRODUTOS_COMPRAS', 4, 'PRODUTOS_COMPRAS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_PRODUTOS_CONTAS" for table "PRODUTOS_CONTAS"  */
set term ^;

create trigger TAD0_PRODUTOS_CONTAS for PRODUTOS_CONTAS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PRODUTOS_CONTAS', 4, 'PRODUTOS_CONTAS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TAI0_PRODUTOS_CONTAS" for table "PRODUTOS_CONTAS"  */
set term ^;

create trigger TAI0_PRODUTOS_CONTAS for PRODUTOS_CONTAS
  after insert as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PRODUTOS_CONTAS', 2, 'PRODUTOS_CONTAS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_PRODUTOS_CONTAS" for table "PRODUTOS_CONTAS"  */
set term ^;

create trigger TBU0_PRODUTOS_CONTAS for PRODUTOS_CONTAS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PRODUTOS_CONTAS', 3, 'PRODUTOS_CONTAS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_PRODUTOS_CUSTOS" for table "PRODUTOS_CUSTOS"  */
set term ^;

create trigger TBU0_PRODUTOS_CUSTOS for PRODUTOS_CUSTOS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PRODUTOS_CUSTOS', 3, 'PRODUTOS_CUSTOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_PRODUTOS_ESTOQUES" for table "PRODUTOS_ESTOQUES"  */
set term ^;

create trigger TBU0_PRODUTOS_ESTOQUES for PRODUTOS_ESTOQUES
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PRODUTOS_ESTOQUES', 3, 'PRODUTOS_ESTOQUES', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_PRODUTOS_ESTOQUES_VERSAO" for table "PRODUTOS_ESTOQUES_VERSAO"  */
set term ^;

create trigger TBIG_PRODUTOS_ESTOQUES_VERSAO for PRODUTOS_ESTOQUES_VERSAO
before insert as
  declare variable MaxValue integer;
begin
  if ((New.PK_PRODUTOS_ESTOQUES_VERSAO is null) or 
      (New.PK_PRODUTOS_ESTOQUES_VERSAO = 0)) then
  begin
    select Max(PK_PRODUTOS_ESTOQUES_VERSAO)
      from PRODUTOS_ESTOQUES_VERSAO
     where FK_EMPRESAS = New.FK_EMPRESAS
       and FK_PRODUTOS = New.FK_PRODUTOS
      into :MaxValue;
    if (MaxValue is null) then
      MaxValue   = 0;
    New.PK_PRODUTOS_ESTOQUES_VERSAO = MaxValue + 1;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
end^

set term ;^;


/*  Update trigger "TBU0_PRODUTOS_ESTOQUES_VERSAO" for table "PRODUTOS_ESTOQUES_VERSAO"  */
set term ^;

create trigger TBU0_PRODUTOS_ESTOQUES_VERSAO for PRODUTOS_ESTOQUES_VERSAO
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PRODUTOS_ESTOQUES_VERSAO', 3, 'PRODUTOS_ESTOQUES_VERSAO', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_PRODUTOS_FORNECEDORES" for table "PRODUTOS_FORNECEDORES"  */
set term ^;

create trigger TBU0_PRODUTOS_FORNECEDORES for PRODUTOS_FORNECEDORES
before update as
  declare variable Rows integer;
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  select FLAG_PROD_DEF from FORNECEDORES 
   where FK_CADASTROS = New.FK_VW_FORNECEDORES
    into :Rows;
  /* Set into supplier record the same value of New.FLAG_DEF */
  if ((Rows is not null) and (New.FLAG_DEF <> Rows)) then
    update FORNECEDORES set
           FLAG_PROD_DEF = :Rows
     where FK_CADASTROS = New.FK_VW_FORNECEDORES;
  execute procedure STP_INSERT_HISTORIC ('PRODUTOS_FORNECEDORES', 'PRODUTOS_FORNECEDORES',
    'atualização de registro', 'UPD');
end^

set term ;^;


/*  Insert trigger "TAD0_PRODUTOS_FORNECEDORES" for table "PRODUTOS_FORNECEDORES"  */
set term ^;

create trigger TAD0_PRODUTOS_FORNECEDORES for PRODUTOS_FORNECEDORES
  after delete as
  declare variable Rows integer;
begin
  select Count(*) from PRODUTOS_MARGEM
   where FK_EMPRESAS = Old.FK_EMPRESAS
     and FK_PRODUTOS = Old.FK_PRODUTOS
    into :Rows;
  if ((Rows is null) or (Rows = 0)) then
  begin
    select Count(*) from PRODUTOS_FORNECEDORES
     where FK_EMPRESAS = Old.FK_EMPRESAS
       and FK_PRODUTOS = Old.FK_PRODUTOS
      into :Rows;
    if ((Rows is null) or (Rows = 0)) then
    begin
      delete from PRODUTOS_CUSTOS
       where FK_EMPRESAS = Old.FK_EMPRESAS
         and FK_PRODUTOS = Old.FK_PRODUTOS;
    end
  end
  update FORNECEDORES set
         FLAG_PROD_DEF = 0
   where FK_CADASTROS = Old.FK_VW_FORNECEDORES;
  execute procedure STP_INSERT_HISTORIC ('PRODUTOS_FORNECEDORES', 'PRODUTOS_FORNECEDORES',
    'exclusão de registro', 'DEL');
end^

set term ;^;


/*  Insert trigger "TBI0_PRODUTOS_FORNECEDORES" for table "PRODUTOS_FORNECEDORES"  */
set term ^;

create trigger TBI0_PRODUTOS_FORNECEDORES for PRODUTOS_FORNECEDORES
  before insert as
  declare variable Rows integer;
begin
  select Count(*) from PRODUTOS_CUSTOS 
   where FK_EMPRESAS = New.FK_EMPRESAS
     and FK_PRODUTOS = New.FK_PRODUTOS
    into :Rows;
  if ((Rows is null) or (Rows = 0)) then
  begin
    insert into PRODUTOS_CUSTOS 
      (FK_EMPRESAS, FK_PRODUTOS, FLAG_RJST)
    values
      (New.FK_EMPRESAS, New.FK_PRODUTOS, 0);
  end
  select FLAG_PROD_DEF from FORNECEDORES 
   where FK_CADASTROS = New.FK_VW_FORNECEDORES
    into :Rows;
  /* Set into supplier record the same value of New.FLAG_DEF */
  if ((Rows is not null) and (New.FLAG_DEF <> Rows)) then
    update FORNECEDORES set
           FLAG_PROD_DEF = :Rows
     where FK_CADASTROS = New.FK_VW_FORNECEDORES;
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
  execute procedure STP_INSERT_HISTORIC ('PRODUTOS_FORNECEDORES', 'PRODUTOS_FORNECEDORES',
    'inserção de registro', 'INC');
end^

set term ;^;


/*  Delete trigger "TAD0_PRODUTOS_GRUPOS" for table "PRODUTOS_GRUPOS"  */
set term ^;

create trigger TAD0_PRODUTOS_GRUPOS for PRODUTOS_GRUPOS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PRODUTOS_GRUPOS', 4, 'PRODUTOS_GRUPOS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBI0_PRODUTOS_GRUPOS" for table "PRODUTOS_GRUPOS"  */
set term ^;

create trigger TBI0_PRODUTOS_GRUPOS for PRODUTOS_GRUPOS
  before insert as
begin
  if ((New.PK_PRODUTOS_GRUPOS is null) or (New.PK_PRODUTOS_GRUPOS = 0)) then
  begin
    select R_PK_PRODUTOS_GRUPOS from STP_GET_PK_PRODUTOS_GRUPOS
      into New.PK_PRODUTOS_GRUPOS;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PRODUTOS_GRUPOS', 2, 'PRODUTOS_GRUPOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_PRODUTOS_GRUPOS" for table "PRODUTOS_GRUPOS"  */
set term ^;

create trigger TBU0_PRODUTOS_GRUPOS for PRODUTOS_GRUPOS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PRODUTOS_GRUPOS', 3, 'PRODUTOS_GRUPOS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_PRODUTOS_HISTORICOS" for table "PRODUTOS_HISTORICOS"  */
set term ^;

create trigger TBIG_PRODUTOS_HISTORICOS for PRODUTOS_HISTORICOS
before insert as
begin
  if ((New.PK_PRODUTOS_HISTORICOS is null) or
     ( New.PK_PRODUTOS_HISTORICOS = 0)) then
  begin
    select R_PK_PRODUTOS_HISTORICOS 
      from STP_GET_PK_PRODUTOS_HISTORICOS(New.FK_EMPRESAS, New.FK_PRODUTOS)
      into New.PK_PRODUTOS_HISTORICOS;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
end;^

set term ;^;


/*  Update trigger "TBU0_PRODUTOS_IMAGENS" for table "PRODUTOS_IMAGENS"  */
set term ^;

create trigger TBU0_PRODUTOS_IMAGENS for PRODUTOS_IMAGENS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PRODUTOS_IMAGENS', 3, 'PRODUTOS_IMAGENS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_PRODUTOS_IMPOSTOS" for table "PRODUTOS_IMPOSTOS"  */
set term ^;

create trigger TBU0_PRODUTOS_IMPOSTOS for PRODUTOS_IMPOSTOS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PRODUTOS_IMPOSTOS', 3, 'PRODUTOS_IMPOSTOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_PRODUTOS_LOTACOES" for table "PRODUTOS_LOTACOES"  */
set term ^;

create trigger TBU0_PRODUTOS_LOTACOES for PRODUTOS_LOTACOES
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PRODUTOS_LOTACOES', 3, 'PRODUTOS_LOTACOES', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBI0_PRODUTOS_LOTACOES" for table "PRODUTOS_LOTACOES"  */
set term ^;

create trigger TBI0_PRODUTOS_LOTACOES for PRODUTOS_LOTACOES
  before insert as
  declare variable FkProdutos integer;
begin
  select FK_PRODUTOS from PRODUTOS_CUSTOS
   where FK_EMPRESAS = New.FK_EMPRESAS
     and FK_PRODUTOS = New.FK_PRODUTOS
    into :FkProdutos;
  if (FkProdutos is null) then
    insert into PRODUTOS_CUSTOS 
      (FK_EMPRESAS, FK_PRODUTOS, FLAG_RJST)
    values
      (New.FK_EMPRESAS, New.FK_PRODUTOS, 0);
  FkProdutos = null;
  select FK_PRODUTOS from PRODUTOS_ESTOQUES 
   where FK_EMPRESAS      = New.FK_EMPRESAS
     and FK_PRODUTOS      = New.FK_PRODUTOS
     and FK_ALMOXARIFADOS = New.FK_ALMOXARIFADOS
    into :FkProdutos;
  if (FkProdutos is null) then
    insert into PRODUTOS_ESTOQUES
      (FK_EMPRESAS, FK_PRODUTOS, FK_ALMOXARIFADOS, FLAG_EMP)
    values
      (New.FK_EMPRESAS, New.FK_PRODUTOS, New.FK_ALMOXARIFADOS, 1);
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
  execute procedure STP_INSERT_HISTORIC ('PRODUTOS_LOTACOES', 'PRODUTOS_LOTACOES',
    'inserção de registro', 'INC');
end^

set term ;^;


/*  Update trigger "TBU0_PRODUTOS_MARGEM" for table "PRODUTOS_MARGEM"  */
set term ^;

create trigger TBU0_PRODUTOS_MARGEM for PRODUTOS_MARGEM
before update as
begin
  if (New.SIT_TRIB is null) then
  begin
    New.SIT_TRIB = '0' || Cast(New.FK_SITUACAO_TRIBUTARIAS as char(01)) ||
                           Cast(New.FK_ORIGENS_TRIBUTARIAS as char(01));
  end
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
end;^

set term ;^;


/*  Insert trigger "TBI0_PRODUTOS_MARGEM" for table "PRODUTOS_MARGEM"  */
set term ^;

create trigger TBI0_PRODUTOS_MARGEM for PRODUTOS_MARGEM
  after insert as
begin
  if (New.SIT_TRIB is null) then
  begin
    New.SIT_TRIB = '0' || Cast(New.FK_SITUACAO_TRIBUTARIAS as char(01)) ||
                           Cast(New.FK_ORIGENS_TRIBUTARIAS as char(01));
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
end^

set term ;^;


/*  Insert trigger "TAD0_PRODUTOS_MARGEM" for table "PRODUTOS_MARGEM"  */
set term ^;

create trigger TAD0_PRODUTOS_MARGEM for PRODUTOS_MARGEM
  after delete as
begin
  delete from PRODUTOS_CUSTOS 
   where FK_EMPRESAS = Old.FK_EMPRESAS
     and FK_PRODUTOS = Old.FK_PRODUTOS;
end^

set term ;^;


/*  Insert trigger "TAI0_PRODUTOS_MARGEM" for table "PRODUTOS_MARGEM"  */
set term ^;

create trigger TAI0_PRODUTOS_MARGEM for PRODUTOS_MARGEM
  after insert as
  declare variable Rows integer;
begin
  select Count(*) from PRODUTOS_CUSTOS
   where FK_EMPRESAS = New.FK_EMPRESAS
     and FK_PRODUTOS = New.FK_PRODUTOS
    into :Rows;
  if ((Rows is null) or (Rows = 0)) then
  begin
    insert into PRODUTOS_CUSTOS
      (FK_EMPRESAS, FK_PRODUTOS)
    values
      (New.FK_EMPRESAS, New.FK_PRODUTOS);
  end
end^

set term ;^;


/*  Update trigger "TBU0_PRODUTOS_PRECOS" for table "PRODUTOS_PRECOS"  */
set term ^;

create trigger TBU0_PRODUTOS_PRECOS for PRODUTOS_PRECOS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PRODUTOS_PRECOS', 3, 'PRODUTOS_PRECOS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TAI0_PRODUTOS_REFERENCIAS" for table "PRODUTOS_REFERENCIAS"  */
set term ^;

create trigger TAI0_PRODUTOS_REFERENCIAS for PRODUTOS_REFERENCIAS
  after insert as
  declare variable FlagLast smallint;
begin
  select Pgr.FLAG_LAST_LEVEL
    from PRODUTOS_GRUPOS Pgr
   where Pgr.PK_PRODUTOS_GRUPOS = New.FK_PRODUTOS_GRUPOS
    into :FlagLast;
  if ((FlagLast is null) or (FlagLast = 0)) then
    update PRODUTOS_GRUPOS set
           FLAG_LAST_LEVEL    = 1
     where PK_PRODUTOS_GRUPOS = New.FK_PRODUTOS_GRUPOS;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PRODUTOS_REFERENCIAS', 2, 'PRODUTOS_REFERENCIAS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_PRODUTOS_REFERENCIAS" for table "PRODUTOS_REFERENCIAS"  */
set term ^;

create trigger TBU0_PRODUTOS_REFERENCIAS for PRODUTOS_REFERENCIAS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PRODUTOS_REFERENCIAS', 3, 'PRODUTOS_REFERENCIAS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_PRODUTOS_REFERENCIAS" for table "PRODUTOS_REFERENCIAS"  */
set term ^;

create trigger TAD0_PRODUTOS_REFERENCIAS for PRODUTOS_REFERENCIAS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PRODUTOS_REFERENCIAS', 4, 'PRODUTOS_REFERENCIAS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBI0_PRODUTOS_SALDOS" for table "PRODUTOS_SALDOS"  */
set term ^;

create trigger TBI0_PRODUTOS_SALDOS for PRODUTOS_SALDOS
  before insert as
begin
  if ((New.PK_PRODUTOS_SALDOS is null) or (New.PK_PRODUTOS_SALDOS = 0)) then
  begin
    select R_PK_PRODUTOS_SALDOS from STP_GET_PK_PRODUTOS_SALDOS(New.FK_EMPRESAS)
      into New.PK_PRODUTOS_SALDOS;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PRODUTOS_SALDOS', 2, 'PRODUTOS_SALDOS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_PRODUTOS_SALDOS" for table "PRODUTOS_SALDOS"  */
set term ^;

create trigger TAD0_PRODUTOS_SALDOS for PRODUTOS_SALDOS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PRODUTOS_SALDOS', 4, 'PRODUTOS_SALDOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TAU0_PRODUTOS_SALDOS" for table "PRODUTOS_SALDOS"  */
set term ^;

create trigger TAU0_PRODUTOS_SALDOS for PRODUTOS_SALDOS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PRODUTOS_SALDOS', 3, 'PRODUTOS_SALDOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TAU0_PRODUTOS_SALDO_ALMX" for table "PRODUTOS_SALDO_ALMX"  */
set term ^;

create trigger TAU0_PRODUTOS_SALDO_ALMX for PRODUTOS_SALDO_ALMX
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PRODUTOS_SALDO_ALMX', 3, 'PRODUTOS_SALDO_ALMX', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_PRODUTOS_SALDO_ALMX" for table "PRODUTOS_SALDO_ALMX"  */
set term ^;

create trigger TAD0_PRODUTOS_SALDO_ALMX for PRODUTOS_SALDO_ALMX
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PRODUTOS_SALDO_ALMX', 4, 'PRODUTOS_SALDO_ALMX', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBI0_PRODUTOS_SALDO_ALMX" for table "PRODUTOS_SALDO_ALMX"  */
set term ^;

create trigger TBI0_PRODUTOS_SALDO_ALMX for PRODUTOS_SALDO_ALMX
  before insert as
begin
  if ((New.PK_PRODUTOS_SALDO_ALMX is null) or (New.PK_PRODUTOS_SALDO_ALMX = 0)) then
  begin
    select R_PK_PRODUTOS_SALDO_ALMX from STP_GET_PK_PRODUTOS_SALDO_ALMX(New.FK_EMPRESAS)
      into New.PK_PRODUTOS_SALDO_ALMX;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PRODUTOS_SALDO_ALMX', 2, 'PRODUTOS_SALDO_ALMX', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_PRODUTOS_SERVICOS" for table "PRODUTOS_SERVICOS"  */
set term ^;

create trigger TBU0_PRODUTOS_SERVICOS for PRODUTOS_SERVICOS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PRODUTOS_SERVICOS', 3, 'PRODUTOS_SERVICOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_PRODUTOS_VENDAS" for table "PRODUTOS_VENDAS"  */
set term ^;

create trigger TBU0_PRODUTOS_VENDAS for PRODUTOS_VENDAS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PRODUTOS_VENDAS', 3, 'PRODUTOS_VENDAS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_PRODUTOS_VERSOES_LOTACAO" for table "PRODUTOS_VERSOES_LOTACAO"  */
set term ^;

create trigger TBU0_PRODUTOS_VERSOES_LOTACAO for PRODUTOS_VERSOES_LOTACAO
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PRODUTOS_VERSOES_LOTACAO', 3, 'PRODUTOS_VERSOES_LOTACAO', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_PRODUTOS_X_TIPO_PRODUTOS" for table "PRODUTOS_X_TIPO_PRODUTOS"  */
set term ^;

create trigger TBU0_PRODUTOS_X_TIPO_PRODUTOS for PRODUTOS_X_TIPO_PRODUTOS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PRODUTOS_X_TIPO_PRODUTOS', 3, 'PRODUTOS_X_TIPO_PRODUTOS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TAI0_PRODUTOS_X_TIPO_PRODUTOS" for table "PRODUTOS_X_TIPO_PRODUTOS"  */
set term ^;

create trigger TAI0_PRODUTOS_X_TIPO_PRODUTOS for PRODUTOS_X_TIPO_PRODUTOS
  after insert as
  declare variable FlagLast            smallint;
  declare variable FkAccount           integer;
  declare variable PkAccount           integer;
  declare variable PkProductGroup      smallint;
  declare variable FkTipoCfop          smallint;
  declare variable FkNaturezaOperacoes smallint;
  declare variable MaskCta             varchar(50);
  declare variable DscSGru             varchar(50);
  declare variable GrauCta             smallint;
  declare variable SeqCta              smallint;
  declare variable FlagId              smallint;
  declare variable FlagTCta            smallint;
begin
  select Prd.FK_PRODUTOS_GRUPOS, Pgr.FLAG_LAST_LEVEL
    from PRODUTOS Prd, PRODUTOS_GRUPOS Pgr
   where Prd.PK_PRODUTOS        = New.FK_PRODUTOS
     and Pgr.PK_PRODUTOS_GRUPOS = Prd.FK_PRODUTOS_GRUPOS
    into :PkProductGroup, :FlagLast;
  if ((FlagLast is null) or (FlagLast = 0)) then
    update PRODUTOS_GRUPOS set
           FLAG_LAST_LEVEL    = 1
     where PK_PRODUTOS_GRUPOS = :PkProductGroup;
  for select Nat.FK_TIPO_CFOP, Nat.PK_NATUREZA_OPERACOES,
             Nat.FK_FINANCEIRO_CONTAS
        from TIPO_PRODUTOS_NATURE_OPER Tpn, NATUREZA_OPERACOES Nat,
             FINANCEIRO_CONTAS Fin
       where Tpn.FK_TIPO_PRODUTOS      = New.FK_TIPO_PRODUTOS
         and Nat.FK_TIPO_CFOP          = Tpn.FK_TIPO_CFOP
         and Nat.PK_NATUREZA_OPERACOES = Tpn.FK_NATUREZA_OPERACOES
         and Fin.PK_FINANCEIRO_CONTAS  = Nat.FK_FINANCEIRO_CONTAS
         and Fin.FLAG_ANL_SNT          = 0
        into :FkTipoCfop, :FkNaturezaOperacoes, :FkAccount do
  begin
    PkAccount = null;
    select DSC_PGRU from PRODUTOS_GRUPOS
     where PK_PRODUTOS_GRUPOS = :PkProductGroup
      into :DscSGru;
    select FK_FINANCEIRO_CONTAS
      from PRODUTOS_CONTAS
     where FK_PRODUTOS_GRUPOS    = :PkProductGroup
       and FK_TIPO_CFOP          = :FkTipoCfop
       and FK_NATUREZA_OPERACOES = :FkNaturezaOperacoes
      into :PkAccount;
    if ((PkAccount is null) or (PkAccount = 0)) then
    begin
      select PK_FINANCEIRO_CONTAS
        from FINANCEIRO_CONTAS
       where DSC_CTA = :DscSGru
         and FK_FINANCEIRO_CONTAS = :FkAccount
        into :PkAccount;
      if ((PkAccount is null) or (PkAccount = 0)) then
      begin
        select MASK_CTA, GRAU_CTA, FLAG_ID, FLAG_TCTA
          from FINANCEIRO_CONTAS
         where PK_FINANCEIRO_CONTAS = :FkAccount
          into :MaskCta, :GrauCta, :FlagId, :FlagTCta;
        if (MaskCta is null) then MaskCta = '';
        if (GrauCta is null) then GrauCta = 0;
        select Max(SEQ_CTA) from FINANCEIRO_CONTAS
         where FK_FINANCEIRO_CONTAS = :FkAccount
          into :SeqCta;
        if (SeqCta is null) then SeqCta = 0;
        SeqCta = SeqCta + 1;
        GrauCta = GrauCta + 1;
        MaskCta = MaskCta || '.' || Cast(SeqCta as varchar(10));
        select R_PK_FINANCEIRO_CONTAS
          from STP_GET_PK_FINANCEIRO_CONTAS(:FkAccount, :SeqCta)
          into :PkAccount;
        insert into FINANCEIRO_CONTAS
          (PK_FINANCEIRO_CONTAS, FK_FINANCEIRO_CONTAS, SEQ_CTA,
           FK_PLANO_CONTAS, DSC_CTA, MASK_CTA, GRAU_CTA, FLAG_ID,
           FLAG_TCTA, FLAG_ANL_SNT, KC_FINANCEIRO_LANCAMENTOS)
        values
          (:PkAccount, :FkAccount, :SeqCta,
            null, :DscSGru, :MaskCta, :GrauCta, :FlagID,
            :FlagTCta, 1, 0);
      end
      insert into PRODUTOS_CONTAS
        (FK_PRODUTOS_GRUPOS, FK_TIPO_CFOP, FK_NATUREZA_OPERACOES, FK_FINANCEIRO_CONTAS)
      values
        (:PkProductGroup, :FkTipoCfop, :FkNaturezaOperacoes, :PkAccount);
    end
    else
    begin
      update PRODUTOS_CONTAS set
             FK_FINANCEIRO_CONTAS  = :PkAccount
       where FK_PRODUTOS_GRUPOS    = New.FK_TIPO_PRODUTOS
         and FK_TIPO_CFOP          = :FkTipoCfop
         and FK_NATUREZA_OPERACOES = :FkNaturezaOperacoes;
    end
  end
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PRODUTOS_X_TIPO_PRODUTOS', 2, 'PRODUTOS_X_TIPO_PRODUTOS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_PRODUTOS_X_TIPO_PRODUTOS" for table "PRODUTOS_X_TIPO_PRODUTOS"  */
set term ^;

create trigger TAD0_PRODUTOS_X_TIPO_PRODUTOS for PRODUTOS_X_TIPO_PRODUTOS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PRODUTOS_X_TIPO_PRODUTOS', 4, 'PRODUTOS_X_TIPO_PRODUTOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_REQUISICOES" for table "REQUISICOES"  */
set term ^;

create trigger TBU0_REQUISICOES for REQUISICOES
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'REQUISICOES', 3, 'REQUISICOES', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_REQUISICOES" for table "REQUISICOES"  */
set term ^;

create trigger TBIG_REQUISICOES for REQUISICOES
before insert as
  declare variable MaxValue integer;
begin
  if ((New.PK_REQUISICOES is null) or (New.PK_REQUISICOES = 0)) then
  begin
    select Max(PK_REQUISICOES)
      from REQUISICOES
     where FK_EMPRESAS = New.FK_EMPRESAS
      into :MaxValue;
    if (MaxValue is null) then
      MaxValue   = 0;
    New.PK_REQUISICOES = MaxValue + 1;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
end^

set term ;^;


/*  Insert trigger "TIBG_REQUISICOES_ITEMS" for table "REQUISICOES_ITEMS"  */
set term ^;

create trigger TIBG_REQUISICOES_ITEMS for REQUISICOES_ITEMS
before insert as
  declare variable MaxValue integer;
begin
  if ((New.PK_REQUISICOES_ITEMS is null) or 
     (New.PK_REQUISICOES_ITEMS = 0)) then
  begin
    select Max(PK_REQUISICOES_ITEMS)
      from REQUISICOES_ITEMS
     where FK_EMPRESAS    = New.FK_EMPRESAS 
       and FK_REQUISICOES = New.FK_REQUISICOES
      into :MaxValue;
    if (MaxValue is null) then
      MaxValue   = 0;
    New.PK_REQUISICOES_ITEMS = MaxValue + 1;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
end^

set term ;^;


/*  Update trigger "TBU0_REQUISICOES_ITEMS" for table "REQUISICOES_ITEMS"  */
set term ^;

create trigger TBU0_REQUISICOES_ITEMS for REQUISICOES_ITEMS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'REQUISICOES_ITEMS', 3, 'REQUISICOES_ITEMS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TAI0_REQUISICOES_ITEMS" for table "REQUISICOES_ITEMS"  */
set term ^;

create trigger TAI0_REQUISICOES_ITEMS for REQUISICOES_ITEMS
  after insert as
  declare variable FkAlmoxarifados    integer;
  declare variable FkAlmoxarifadosDst integer;
  declare variable FkTipoMovimEstq    integer;
  declare variable FkTipoDocumentos   integer;
  declare variable FkCadastros        integer;
  declare variable LastItem           integer;
  declare variable Status             smallint;
begin
  Status = 0;
  select FK_ALMOXARIFADOS, FK_ALMOXARIFADOS__DST,
         FK_TIPO_MOVIM_ESTQ, QTD_ITEMS, FK_FUNCIONARIOS,
         FK_TIPO_DOCUMENTOS
    from REQUISICOES
   where PK_REQUISICOES = New.FK_REQUISICOES
    into :FkAlmoxarifados, :FkAlmoxarifadosDst, :FkTipoMovimEstq,
         :LastItem, :FkCadastros, :FkTipoDocumentos;
  if ((FkTipoMovimEstq is not null) or
     (FkTipoMovimEstq > 0))         then
  begin
    select R_STATUS
      from STP_UPDATE_SUPPLIES(New.FK_EMPRESAS,
                               New.FK_PRODUTOS,
                               :FkTipoMovimEstq,
                               :FkTipoDocumentos,
                               :FkAlmoxarifados,
                               :FkAlmoxarifadosDst,
                               New.FK_LOTACAO_ORGM,
                               New.FK_LOTACAO_DSTN,
                               :FkCadastros,
                               New.FK_REQUISICOES,
                               New.QTD_ITM)
      into New.STT_BXA;
    if (Status = 0) then Status = New.STT_BXA;
  end
  if ((Status = 0) and (LastItem = New.PK_REQUISICOES_ITEMS)) then
  begin
    update REQUISICOES set
           FLAG_BXA = 1
     where FK_EMPRESAS = New.FK_EMPRESAS
       and PK_REQUISICOES = New.FK_REQUISICOES;
  end
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'REQUISICOES_ITEMS', 2, 'REQUISICOES_ITEMS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_REQUISICOES_ITEMS" for table "REQUISICOES_ITEMS"  */
set term ^;

create trigger TAD0_REQUISICOES_ITEMS for REQUISICOES_ITEMS
  after delete as
  declare variable FkAlmoxarifados    integer;
  declare variable FkAlmoxarifadosDst integer;
  declare variable FkTipoMovimEstq    integer;
  declare variable FkTipoDocumentos   integer;
  declare variable FkCadastros        integer;
begin
  select FK_ALMOXARIFADOS, FK_ALMOXARIFADOS__DST,
         FK_TIPO_MOVIM_ESTQ, FK_FUNCIONARIOS,
         FK_TIPO_DOCUMENTOS
    from REQUISICOES
   where PK_REQUISICOES = Old.FK_REQUISICOES
    into :FkAlmoxarifados, :FkAlmoxarifadosDst, :FkTipoMovimEstq,
         :FkCadastros, :FkTipoDocumentos;
  if ((FkTipoMovimEstq is not null) or
     (FkTipoMovimEstq > 0))         then
  begin
    select R_STATUS
      from STP_UPDATE_SUPPLIES(Old.FK_EMPRESAS,
                               Old.FK_PRODUTOS,
                               :FkTipoMovimEstq,
                               :FkTipoDocumentos,
                               :FkAlmoxarifados,
                               :FkAlmoxarifadosDst,
                               Old.FK_LOTACAO_ORGM,
                               Old.FK_LOTACAO_DSTN,
                               :FkCadastros,
                               Old.FK_REQUISICOES,
                               Old.QTD_ITM * -1)
      into Old.STT_BXA;
  end
  update REQUISICOES set
         FLAG_BXA = 0
   where FK_EMPRESAS    = Old.FK_EMPRESAS
     and PK_REQUISICOES = Old.FK_REQUISICOES;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'REQUISICOES_ITEMS', 4, 'REQUISICOES_ITEMS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_SIMILARES" for table "SIMILARES"  */
set term ^;

create trigger TBIG_SIMILARES for SIMILARES
before insert as
begin
  if ((New.PK_SIMILARES is null) or (New.PK_SIMILARES = 0)) then
    New.PK_SIMILARES = Gen_Id(SIMILARES, 1);
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'SIMILARES', 2, 'SIMILARES', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_SIMILARES" for table "SIMILARES"  */
set term ^;

create trigger TBU0_SIMILARES for SIMILARES
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'SIMILARES', 3, 'SIMILARES', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_TABELA_PRECOS" for table "TABELA_PRECOS"  */
set term ^;

create trigger TBU0_TABELA_PRECOS for TABELA_PRECOS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  if (New.DTA_FIN < New.DTA_INI) then
    New.DTA_FIN = null;
  execute procedure STP_INSERT_HISTORIC ('TABELA_PRECOS', 'TABELA_PRECOS',
    'atualização de registro', 'UPD');
end^

set term ;^;


/*  Insert trigger "TBIG_TABELA_PRECOS" for table "TABELA_PRECOS"  */
set term ^;

create trigger TBIG_TABELA_PRECOS for TABELA_PRECOS
before insert as
begin
  if ((New.PK_TABELA_PRECOS is null) or (New.PK_TABELA_PRECOS = 0)) then
    New.PK_TABELA_PRECOS = Gen_Id(TABELA_PRECOS, 1);
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
  if (New.DTA_FIN < New.DTA_INI) then
    New.DTA_FIN = null;
  execute procedure STP_INSERT_HISTORIC ('TABELA_PRECOS', 'TABELA_PRECOS',
    'inserção de registro', 'INC');
end^

set term ;^;


/*  Delete trigger "TAD0_TABELA_PRECOS" for table "TABELA_PRECOS"  */
set term ^;

create trigger TAD0_TABELA_PRECOS for TABELA_PRECOS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TABELA_PRECOS', 4, 'TABELA_PRECOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_TIPO_COMPOSICOES" for table "TIPO_COMPOSICOES"  */
set term ^;

create trigger TBU0_TIPO_COMPOSICOES for TIPO_COMPOSICOES
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_COMPOSICOES', 3, 'TIPO_COMPOSICOES', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_TIPO_COMPOSICOES" for table "TIPO_COMPOSICOES"  */
set term ^;

create trigger TBIG_TIPO_COMPOSICOES for TIPO_COMPOSICOES
before insert as
  declare variable MaxValue integer;
begin
  if ((New.PK_TIPO_COMPOSICOES is null) or (New.PK_TIPO_COMPOSICOES = 0)) then
  begin
    select Max(PK_TIPO_COMPOSICOES)
      from TIPO_COMPOSICOES
     where FK_PRODUTOS = New.FK_PRODUTOS
      into :MaxValue;
    if (MaxValue is null) then
      MaxValue   = 0;
    New.PK_TIPO_COMPOSICOES = MaxValue + 1;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
end^

set term ;^;


/*  Insert trigger "TBIG_TIPO_MOVIM_ESTQ" for table "TIPO_MOVIM_ESTQ"  */
set term ^;

create trigger TBIG_TIPO_MOVIM_ESTQ for TIPO_MOVIM_ESTQ
before insert as
begin
  if ((New.PK_TIPO_MOVIM_ESTQ is null) or (New.PK_TIPO_MOVIM_ESTQ = 0)) then
    New.PK_TIPO_MOVIM_ESTQ = Gen_Id(TIPO_MOVIM_ESTQ, 1);
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_MOVIM_ESTQ', 2, 'TIPO_MOVIM_ESTQ', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_TIPO_MOVIM_ESTQ" for table "TIPO_MOVIM_ESTQ"  */
set term ^;

create trigger TBU0_TIPO_MOVIM_ESTQ for TIPO_MOVIM_ESTQ
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_MOVIM_ESTQ', 3, 'TIPO_MOVIM_ESTQ', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_TIPO_PRODUTOS" for table "TIPO_PRODUTOS"  */
set term ^;

create trigger TBU0_TIPO_PRODUTOS for TIPO_PRODUTOS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_PRODUTOS', 3, 'TIPO_PRODUTOS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_TIPO_PRODUTOS" for table "TIPO_PRODUTOS"  */
set term ^;

create trigger TBIG_TIPO_PRODUTOS for TIPO_PRODUTOS
  before insert as
begin
  if ((New.PK_TIPO_PRODUTOS is null) or (New.PK_TIPO_PRODUTOS = 0)) then
  begin
    select R_PK_TIPO_PRODUTOS from STP_GET_PK_TIPO_PRODUTOS
      into New.PK_TIPO_PRODUTOS;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_PRODUTOS', 2, 'TIPO_PRODUTOS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_TIPO_PRODUTOS" for table "TIPO_PRODUTOS"  */
set term ^;

create trigger TAD0_TIPO_PRODUTOS for TIPO_PRODUTOS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_PRODUTOS', 4, 'TIPO_PRODUTOS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_TIPO_PRODUTOS_NATURE_OPER" for table "TIPO_PRODUTOS_NATURE_OPER"  */
set term ^;

create trigger TAD0_TIPO_PRODUTOS_NATURE_OPER for TIPO_PRODUTOS_NATURE_OPER
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_PRODUTOS_NATURE_OPER', 4, 'TIPO_PRODUTOS_NATURE_OPER', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TAI0_TIPO_PRODUTOS_NATURE_OPER" for table "TIPO_PRODUTOS_NATURE_OPER"  */
set term ^;

create trigger TAI0_TIPO_PRODUTOS_NATURE_OPER for TIPO_PRODUTOS_NATURE_OPER
  after insert as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_PRODUTOS_NATURE_OPER', 2, 'TIPO_PRODUTOS_NATURE_OPER', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_TIPO_PRODUTOS_NATURE_OPER" for table "TIPO_PRODUTOS_NATURE_OPER"  */
set term ^;

create trigger TBU0_TIPO_PRODUTOS_NATURE_OPER for TIPO_PRODUTOS_NATURE_OPER
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_PRODUTOS_NATURE_OPER', 3, 'TIPO_PRODUTOS_NATURE_OPER', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_TIPO_SITUACAO_ESTOQUES" for table "TIPO_SITUACAO_ESTOQUES"  */
set term ^;

create trigger TBIG_TIPO_SITUACAO_ESTOQUES for TIPO_SITUACAO_ESTOQUES
before insert as
begin
  if ((New.PK_TIPO_SITUACAO_ESTOQUES is null) or (New.PK_TIPO_SITUACAO_ESTOQUES = 0)) then
    New.PK_TIPO_SITUACAO_ESTOQUES = Gen_Id(TIPO_SITUACAO_ESTOQUES, 1);
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_SITUACAO_ESTOQUES', 2, 'TIPO_SITUACAO_ESTOQUES', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_TIPO_SITUACAO_ESTOQUES" for table "TIPO_SITUACAO_ESTOQUES"  */
set term ^;

create trigger TBU0_TIPO_SITUACAO_ESTOQUES for TIPO_SITUACAO_ESTOQUES
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_SITUACAO_ESTOQUES', 3, 'TIPO_SITUACAO_ESTOQUES', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_UNIDADES" for table "UNIDADES"  */
set term ^;

create trigger TBU0_UNIDADES for UNIDADES
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'UNIDADES', 3, 'UNIDADES', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_UNIDADES" for table "UNIDADES"  */
set term ^;

create trigger TBIG_UNIDADES for UNIDADES
before insert as
begin
  if ((New.PK_UNIDADES is null) or (New.PK_UNIDADES = 0)) then
    New.PK_UNIDADES = Gen_Id(UNIDADES, 1);
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'UNIDADES', 2, 'UNIDADES', current_timestamp);
end^

set term ;^;

