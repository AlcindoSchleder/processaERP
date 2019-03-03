/*==============================================================*/
/* Database name:  PROCESSA                                     */
/* DBMS name:      Friebird15x                                  */
/* Created on:     7/9/2006 02:12:11                            */
/*==============================================================*/



set term ^;

create procedure STP_ELIMINA_VINCULO  (
  COD_CADASTRO INTEGER, 
  TIPO_CATEGORIA INTEGER )
as
  declare variable CodCat integer;
  declare variable Zumbi integer;
begin
  select count(*) from VINCULOS_CAD_CAT Vin, CATEGORIAS Cat 
   where Vin.FK_CADASTROS  = :COD_CADASTRO     and
         Vin.FK_CATEGORIAS = Cat.PK_CATEGORIAS and
         Cat.FLAG_CAT     <> :TIPO_CATEGORIA
    into :Zumbi;
  if (Zumbi is null) then Zumbi = 0;
  for select PK_CATEGORIAS 
        from CATEGORIAS 
       where FLAG_CAT = :TIPO_CATEGORIA
        into :CodCat do
  begin
    if (CodCat is null) then
      exit;
    delete from VINCULOS_CAD_CAT 
      where FK_CADASTROS  = :COD_CADASTRO and
            FK_CATEGORIAS = :CodCat;
  end
  if (Zumbi = 0) then
    update CADASTROS set
      FLAG_ZUMBI = 1
     where PK_CADASTROS = :COD_CADASTRO; 
end;^

set term ;^;

grant EXECUTE on procedure STP_ELIMINA_VINCULO to PUBLIC;


set term ^;

create procedure STP_GET_CHILD_FINANCEIRO_CONTAS (
  P_FLAG_TCTA            smallint,
  P_PK_FINANCEIRO_CONTAS integer
)
returns (
  R_PK_FINANCEIRO_CONTAS integer,
  R_FK_FINANCEIRO_CONTAS integer,
  R_FK_PLANO_CONTAS      integer,
  R_MASK_CTA             varchar(50),
  R_DSC_CTA              varchar(50),
  R_GRAU_CTA             smallint,
  R_SEQ_CTA              smallint,
  R_FLAG_ANL_SNT         smallint,
  R_FLAG_TCTA            smallint,
  R_FLAG_ID              smallint
)
as
  declare variable FkFinanceiroContas integer;
begin
  for select PK_FINANCEIRO_CONTAS, FK_FINANCEIRO_CONTAS, FK_PLANO_CONTAS,
             MASK_CTA, DSC_CTA, GRAU_CTA, SEQ_CTA, FLAG_ANL_SNT, FLAG_TCTA,
             FLAG_ID
        from FINANCEIRO_CONTAS
       where PK_FINANCEIRO_CONTAS <> FK_FINANCEIRO_CONTAS
         and FK_FINANCEIRO_CONTAS = :P_PK_FINANCEIRO_CONTAS
         and FLAG_TCTA            = :P_FLAG_TCTA
       order by SEQ_CTA
        into :FkFinanceiroContas, :R_FK_FINANCEIRO_CONTAS, :R_FK_PLANO_CONTAS,
             :R_MASK_CTA, :R_DSC_CTA, :R_GRAU_CTA, :R_SEQ_CTA, :R_FLAG_ANL_SNT,
             :R_FLAG_TCTA, :R_FLAG_ID do
  begin
    R_PK_FINANCEIRO_CONTAS = FkFinanceiroContas;
    suspend;
    for select R_PK_FINANCEIRO_CONTAS, R_FK_FINANCEIRO_CONTAS, R_FK_PLANO_CONTAS,
               R_MASK_CTA, R_DSC_CTA, R_GRAU_CTA, R_SEQ_CTA, R_FLAG_ANL_SNT,
               R_FLAG_TCTA, R_FLAG_ID
          from STP_GET_CHILD_FINANCEIRO_CONTAS(:P_FLAG_TCTA, :FkFinanceiroContas)
          into :R_PK_FINANCEIRO_CONTAS, :R_FK_FINANCEIRO_CONTAS, :R_FK_PLANO_CONTAS,
               :R_MASK_CTA, :R_DSC_CTA, :R_GRAU_CTA, :R_SEQ_CTA, :R_FLAG_ANL_SNT,
               :R_FLAG_TCTA, :R_FLAG_ID do
    begin
      suspend;
    end
  end
end ^

set term ;^;

grant EXECUTE on procedure STP_GET_CHILD_FINANCEIRO_CONTAS to PUBLIC;


set term ^;

create procedure STP_GET_CHILD_PLANO_CONTAS (
  P_FLAG_TCTA       smallint,
  P_PK_PLANO_CONTAS integer
)
returns (
  R_PK_PLANO_CONTAS integer,
  R_FK_PLANO_CONTAS integer,
  R_MASK_CTA        varchar(50),
  R_DSC_CTA         varchar(50),
  R_GRAU_CTA        smallint,
  R_SEQ_CTA         smallint,
  R_FLAG_ANL_SNT    smallint,
  R_FLAG_TCTA       smallint,
  R_FLAG_ID         smallint
)
as
  declare variable FkPlanoContas integer;
begin
  for select PK_PLANO_CONTAS, FK_PLANO_CONTAS, MASK_CTA, DSC_CTA,
             GRAU_CTA, SEQ_PLCTA, FLAG_ANL_SNT, FLAG_TCTA, FLAG_ID
        from PLANO_CONTAS
       where PK_PLANO_CONTAS <> FK_PLANO_CONTAS
         and FK_PLANO_CONTAS = :P_PK_PLANO_CONTAS
         and FLAG_TCTA       = :P_FLAG_TCTA
       order by SEQ_PLCTA
        into :FkPlanoContas, :R_FK_PLANO_CONTAS, :R_MASK_CTA, :R_DSC_CTA,
             :R_GRAU_CTA, :R_SEQ_CTA, :R_FLAG_ANL_SNT, :R_FLAG_TCTA, :R_FLAG_ID do
  begin
    R_PK_PLANO_CONTAS = :FkPlanoContas;
    suspend;
    for select R_PK_PLANO_CONTAS, R_FK_PLANO_CONTAS, R_MASK_CTA, R_DSC_CTA,
               R_GRAU_CTA, R_SEQ_CTA, R_FLAG_ANL_SNT, R_FLAG_TCTA, R_FLAG_ID
          from STP_GET_CHILD_PLANO_CONTAS(:P_FLAG_TCTA, :FkPlanoContas)
          into :R_PK_PLANO_CONTAS, :R_FK_PLANO_CONTAS, :R_MASK_CTA, :R_DSC_CTA,
               :R_GRAU_CTA, :R_SEQ_CTA, :R_FLAG_ANL_SNT, :R_FLAG_TCTA, :R_FLAG_ID do
    begin
      suspend;
    end
  end
end ^

set term ;^;


set term ^;

create procedure STP_GET_FINANCEIRO_CONTAS
returns (
  R_PK_FINANCEIRO_CONTAS integer,
  R_FK_FINANCEIRO_CONTAS integer,
  R_FK_PLANO_CONTAS      integer,
  R_MASK_CTA             varchar(50),
  R_DSC_CTA              varchar(50),
  R_GRAU_CTA             smallint,
  R_SEQ_CTA              smallint,
  R_FLAG_ANL_SNT         smallint,
  R_FLAG_TCTA            smallint,
  R_FLAG_ID              smallint
)
as
begin
  for select PK_FINANCEIRO_CONTAS, FK_FINANCEIRO_CONTAS, FK_PLANO_CONTAS,
             MASK_CTA, DSC_CTA, GRAU_CTA, SEQ_CTA, FLAG_ANL_SNT, FLAG_TCTA,
             FLAG_ID
        from FINANCEIRO_CONTAS
       where PK_FINANCEIRO_CONTAS = FK_FINANCEIRO_CONTAS
       order by PK_FINANCEIRO_CONTAS, SEQ_CTA
        into :R_PK_FINANCEIRO_CONTAS, :R_FK_FINANCEIRO_CONTAS, :R_FK_PLANO_CONTAS,
             :R_MASK_CTA, :R_DSC_CTA, :R_GRAU_CTA, :R_SEQ_CTA, :R_FLAG_ANL_SNT,
             :R_FLAG_TCTA, :R_FLAG_ID do
  begin
    suspend;
    for select R_PK_FINANCEIRO_CONTAS, R_FK_FINANCEIRO_CONTAS, R_FK_PLANO_CONTAS,
               R_MASK_CTA, R_DSC_CTA, R_GRAU_CTA, R_SEQ_CTA, R_FLAG_ANL_SNT,
               R_FLAG_TCTA, R_FLAG_ID
          from STP_GET_CHILD_FINANCEIRO_CONTAS(:R_FLAG_TCTA, :R_FK_FINANCEIRO_CONTAS)
          into :R_PK_FINANCEIRO_CONTAS, :R_FK_FINANCEIRO_CONTAS, :R_FK_PLANO_CONTAS,
               :R_MASK_CTA, :R_DSC_CTA, :R_GRAU_CTA, :R_SEQ_CTA, :R_FLAG_ANL_SNT,
               :R_FLAG_TCTA, :R_FLAG_ID do
    begin
      suspend;
    end
  end
end ^

set term ;^;

grant EXECUTE on procedure STP_GET_FINANCEIRO_CONTAS to PUBLIC;


set term ^;

create procedure STP_GET_PK_CADASTROS
returns (
  R_PK_CADASTROS integer
)
as
begin
  R_PK_CADASTROS = Gen_Id(CADASTROS, 1);
end ^

set term ;^;

grant EXECUTE on procedure STP_GET_PK_CADASTROS to PUBLIC;


set term ^;

create procedure STP_GET_PK_CATEGORIAS
returns (
  R_PK_CATEGORIAS integer
)
as
begin
  R_PK_CATEGORIAS = Gen_Id(CATEGORIAS, 1);
  suspend;
end ^

set term ;^;

grant EXECUTE on procedure STP_GET_PK_CATEGORIAS to PUBLIC;


set term ^;

create procedure STP_GET_PK_CENTRO_CUSTOS
returns (
  R_PK_CENTRO_CUSTOS integer
)
as
begin
  R_PK_CENTRO_CUSTOS = Gen_Id(CENTRO_CUSTOS, 1);
  suspend;
end ^

set term ;^;


set term ^;

create procedure STP_GET_PK_FINANCEIRO_CONTAS (
  P_FK_FINANCEIRO_CONTAS integer,
  P_SEQ_CTA              integer
)
returns (
  R_PK_FINANCEIRO_CONTAS integer,
  R_FK_FINANCEIRO_CONTAS integer,
  R_SEQ_CTA              integer
)
as
   declare variable Rows integer;
begin
  R_PK_FINANCEIRO_CONTAS = Gen_Id(FINANCEIRO_CONTAS, 1);
  if ((P_FK_FINANCEIRO_CONTAS is null) or (P_FK_FINANCEIRO_CONTAS = 0)) then
    R_FK_FINANCEIRO_CONTAS = R_PK_FINANCEIRO_CONTAS;
  if (P_SEQ_CTA is null) then
  begin
    R_SEQ_CTA = 0;
    if (R_FK_FINANCEIRO_CONTAS <> R_PK_FINANCEIRO_CONTAS) then
    begin
      select Max(SEQ_CTA)
        from FINANCEIRO_CONTAS
       where FK_FINANCEIRO_CONTAS = :R_PK_FINANCEIRO_CONTAS
        into :Rows;
      if (Rows is null) then Rows = 0;
      Rows = Rows + 1;
      R_SEQ_CTA = Rows;
    end
  end
  else
    R_SEQ_CTA = P_SEQ_CTA;
  suspend;
end ^

set term ;^;

grant EXECUTE on procedure STP_GET_PK_FINANCEIRO_CONTAS to PUBLIC;


set term ^;

create procedure STP_GET_PK_PLANO_CONTAS (
  P_FK_PLANO_CONTAS integer,
  P_SEQ_CTA              integer
)
returns (
  R_PK_PLANO_CONTAS integer,
  R_FK_PLANO_CONTAS integer,
  R_SEQ_CTA              integer
)
as
  declare variable QtdRows integer;
begin
  R_PK_PLANO_CONTAS = Gen_Id(PLANO_CONTAS, 1);
  if ((P_FK_PLANO_CONTAS is null) or (P_FK_PLANO_CONTAS = 0)) then
    R_FK_PLANO_CONTAS = R_PK_PLANO_CONTAS;
  if (P_SEQ_CTA is null) then
  begin
    R_SEQ_CTA = 0;
    if (R_FK_PLANO_CONTAS <> R_PK_PLANO_CONTAS) then
    begin
      select Max(SEQ_PLCTA)
        from PLANO_CONTAS
       where FK_PLANO_CONTAS = :R_PK_PLANO_CONTAS
        into :QtdRows;
      if (QtdRows is null) then QtdRows = 0;
      QtdRows = QtdRows + 1;
      R_SEQ_CTA = QtdRows;
    end
  end
  else
    R_SEQ_CTA = P_SEQ_CTA;
  suspend;
end ^

set term ;^;


set term ^;

create procedure STP_GET_PK_TIPO_COMISSOES
returns (
  R_PK_TIPO_COMISSOES integer
)
as
begin
  R_PK_TIPO_COMISSOES = Gen_Id(TIPO_COMISSOES, 1);
  suspend;
end ^

set term ;^;

grant EXECUTE on procedure STP_GET_PK_TIPO_COMISSOES to PUBLIC;


set term ^;

create procedure STP_GET_PLANO_CONTAS
returns (
  R_PK_PLANO_CONTAS integer,
  R_FK_PLANO_CONTAS integer,
  R_MASK_CTA        varchar(50),
  R_DSC_CTA         varchar(50),
  R_GRAU_CTA        smallint,
  R_SEQ_CTA         smallint,
  R_FLAG_ANL_SNT    smallint,
  R_FLAG_TCTA       smallint,
  R_FLAG_ID         smallint
)
as
  declare variable FkPlanoContas integer;
begin
  for select PK_PLANO_CONTAS, FK_PLANO_CONTAS, MASK_CTA, DSC_CTA,
             GRAU_CTA, SEQ_PLCTA, FLAG_ANL_SNT, FLAG_TCTA, FLAG_ID
        from PLANO_CONTAS
       where PK_PLANO_CONTAS = FK_PLANO_CONTAS
       order by PK_PLANO_CONTAS, SEQ_PLCTA
        into :R_PK_PLANO_CONTAS, :R_FK_PLANO_CONTAS, :R_MASK_CTA, :R_DSC_CTA,
             :R_GRAU_CTA, :R_SEQ_CTA, :R_FLAG_ANL_SNT, :R_FLAG_TCTA, :R_FLAG_ID do
  begin
    suspend;
    for select R_PK_PLANO_CONTAS, R_FK_PLANO_CONTAS, R_MASK_CTA, R_DSC_CTA,
               R_GRAU_CTA, R_SEQ_CTA, R_FLAG_ANL_SNT, R_FLAG_TCTA, R_FLAG_ID
          from STP_GET_CHILD_PLANO_CONTAS(:R_FLAG_TCTA, :R_FK_PLANO_CONTAS)
          into :R_PK_PLANO_CONTAS, :R_FK_PLANO_CONTAS, :R_MASK_CTA, :R_DSC_CTA,
               :R_GRAU_CTA, :R_SEQ_CTA, :R_FLAG_ANL_SNT, :R_FLAG_TCTA, :R_FLAG_ID do
    begin
      suspend;
    end
  end
end ^

set term ;^;


set term ^;

create procedure STP_INSERT_HISTORIC (
  P_NOM_FORM varchar(50),
  P_NOM_ARQ  varchar(50),
  P_DSC_OPE  varchar(30),
  P_COD_OPE     char(03)
)
as
  declare variable FlagTOpe smallint;
begin
  if ((P_NOM_FORM is null) or (P_NOM_FORM = '')  or
     ( P_NOM_ARQ  is null) or (P_NOM_ARQ  = '')  or
     ( P_DSC_OPE  is null) or (P_DSC_OPE  = '')  or
     ( P_COD_OPE  is null) or (P_COD_OPE  = '')) then
    exit;
  if (P_COD_OPE = 'BRW') then
    FlagTOpe = 0;
  if (P_COD_OPE = 'FND') then
    FlagTOpe = 1;
  if (P_COD_OPE = 'INS') then
    FlagTOpe = 2;
  if (P_COD_OPE = 'UPD') then
    FlagTOpe = 3;
  if (P_COD_OPE = 'DEL') then
    FlagTOpe = 4;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, :P_NOM_FORM, :FlagTOpe, :P_NOM_ARQ, current_timestamp);
end ^

set term ;^;

grant EXECUTE on procedure STP_INSERT_HISTORIC to PUBLIC;


set term ^;

create procedure STP_TYPE_ALIAS_MANAGER (
  P_PK_TIPO_ALIAS integer,
  P_DSC_ALIAS     varchar(50),
  P_FLAG_DEL      smallint
)
returns (
  R_PK_TIPO_ALIAS integer,
  R_STATUS        integer
)
as
  declare variable DscAlias varchar(50);
begin
  R_STATUS = 0;
  if (P_PK_TIPO_ALIAS is null) then
  begin
    R_STATUS = -1; /* invalid P_PK_TIPO_ALIAS */
    suspend;
    exit;
  end
  if ((P_FLAG_DEL is not null) and (P_FLAG_DEL > 0)) then
  begin
    if (P_PK_TIPO_ALIAS = 0) then
    begin
      R_STATUS = -1; /* invalid P_PK_TIPO_ALIAS */
      suspend;
      exit;
    end
    delete from TIPO_ALIAS 
     where PK_TIPO_ALIAS = :P_PK_TIPO_ALIAS;
  end
  if ((P_DSC_ALIAS is null) or (P_DSC_ALIAS = ''))  then
  begin
    R_STATUS = -2; /* invalid P_DSC_ALIAS */
    suspend;
    exit;
  end
  select DSC_ALIAS from TIPO_ALIAS
   where DSC_ALIAS = :P_DSC_ALIAS
    into :DscAlias;
  if ((DscAlias is not null) and (DscAlias <> '') and
      (P_PK_TIPO_ALIAS = 0)) then
  begin
    R_STATUS = -3; /* P_DSC_ALIAS already exists*/
    suspend;
    exit;
  end
  if (P_PK_TIPO_ALIAS = 0) then
  begin
    P_PK_TIPO_ALIAS = Gen_Id(TIPO_ALIAS, 1);
    insert into TIPO_ALIAS
      (PK_TIPO_ALIAS, DSC_ALIAS) 
    values
      (:P_PK_TIPO_ALIAS, :P_DSC_ALIAS);
  end
  else
    update TIPO_ALIAS set
           DSC_ALIAS = :P_DSC_ALIAS
     where PK_TIPO_ALIAS = :P_PK_TIPO_ALIAS;
  R_PK_TIPO_ALIAS = P_PK_TIPO_ALIAS;
  suspend;
end ^

set term ;^;

grant EXECUTE on procedure STP_TYPE_ALIAS_MANAGER to PUBLIC;


set term ^;

create procedure STP_CREATE_FINANCE_OWNER (
  P_PK_CADASTROS integer
)
returns (
  R_QTD_REG_CONV smallint
)
as
  declare variable Pk                 integer;
  declare variable FkPlanoContas      integer;
  declare variable PkFinanceiroContas integer;
  declare variable PkCadastros        integer;
  declare variable PkCategorias       smallint;
  declare variable FlagCat            smallint;
  declare variable FlagTCta           smallint;
  declare variable GrauCta            smallint;
  declare variable SeqCta             smallint;
  declare variable RazSoc             varchar(50);
  declare variable MaskCta            varchar(50);
begin
  R_QTD_REG_CONV = 0;
  if (P_PK_CADASTROS is null) then P_PK_CADASTROS = 0;
  for select Cad.PK_CADASTROS, Cad.RAZ_SOC, Cat.PK_CATEGORIAS,
             Cat.FLAG_CAT, Cat.FK_FINANCEIRO_CONTAS
        from CADASTROS Cad,  VINCULOS_CAD_CAT Vcc,
             CATEGORIAS Cat
       where ((Cad.PK_CADASTROS = :P_PK_CADASTROS)
          or ( 0                = :P_PK_CADASTROS))
         and Vcc.FK_CADASTROS   = Cad.PK_CADASTROS
         and Vcc.FK_FINANCEIRO_CONTAS is null
         and Cat.PK_CATEGORIAS  = Vcc.FK_CATEGORIAS
         and Cat.FK_FINANCEIRO_CONTAS > 0
         and Cat.FLAG_CAT             < 4
       order by PK_CADASTROS
        into :PkCadastros, :RazSoc, :PkCategorias, :FlagCat,
             :PkFinanceiroContas do
  begin
    select MASK_CTA, GRAU_CTA, FLAG_TCTA, FK_PLANO_CONTAS
      from FINANCEIRO_CONTAS
     where PK_FINANCEIRO_CONTAS = :PkFinanceiroContas
      into :MaskCta, :GrauCta, :FlagTCta, :FkPlanoContas;
    if (MaskCta is null) then
      MaskCta = '';
    if (GrauCta is null) then
      GrauCta = 0;
    select Max(SEQ_CTA) from FINANCEIRO_CONTAS
     where FK_FINANCEIRO_CONTAS = :PkFinanceiroContas
      into :SeqCta;
    if (SeqCta is null) then SeqCta = 0;
    SeqCta = SeqCta + 1;
    GrauCta = GrauCta + 1;
    MaskCta = MaskCta || '.' || Cast(SeqCta as varchar(10));
    select R_PK_FINANCEIRO_CONTAS
      from STP_GET_PK_FINANCEIRO_CONTAS(:PkFinanceiroContas, :SeqCta)
      into :Pk;
    insert into FINANCEIRO_CONTAS
     (PK_FINANCEIRO_CONTAS, FK_FINANCEIRO_CONTAS, SEQ_CTA,
      FK_PLANO_CONTAS, DSC_CTA, MASK_CTA, GRAU_CTA, FLAG_ID,
      FLAG_TCTA, FLAG_ANL_SNT, KC_FINANCEIRO_LANCAMENTOS)
    values
      (:Pk, :PkFinanceiroContas, :SeqCta, :FkPlanoContas,
       :RazSoc, :MaskCta, :GrauCta, 0, :FlagTCta, 1, 0);
    update VINCULOS_CAD_CAT set
           FK_FINANCEIRO_CONTAS = :PkFinanceiroContas
     where FK_CADASTROS  = :PkCadastros
       and FK_CATEGORIAS = :PkCategorias;
    R_QTD_REG_CONV = R_QTD_REG_CONV + 1;
  end
  suspend;
end ^

set term ;^;

grant EXECUTE on procedure STP_CREATE_FINANCE_OWNER to PUBLIC;


set term ^;

create procedure STP_CREATE_FINANCE_CATEGORY (
  P_PK_CADASTROS         integer,
  P_PK_CATEGORIAS        smallint
)
returns (
  R_PK_FINANCEIRO_CONTAS smallint
)
as
  declare variable FkPlanoContas      integer;
  declare variable PkFinanceiroContas integer;
  declare variable PkCadastros        integer;
  declare variable PkCategorias       smallint;
  declare variable FlagCat            smallint;
  declare variable FlagTCta           smallint;
  declare variable GrauCta            smallint;
  declare variable SeqCta             smallint;
  declare variable RazSoc             varchar(50);
  declare variable MaskCta            varchar(50);
begin
  R_PK_FINANCEIRO_CONTAS = 0;
  for select Cad.PK_CADASTROS, Cad.RAZ_SOC, Cat.PK_CATEGORIAS,
             Cat.FLAG_CAT, Cat.FK_FINANCEIRO_CONTAS
        from CADASTROS Cad,  VINCULOS_CAD_CAT Vcc,
             CATEGORIAS Cat
       where Cad.PK_CADASTROS  = :P_PK_CADASTROS
         and Vcc.FK_CADASTROS  = Cad.PK_CADASTROS
         and Vcc.FK_CATEGORIAS = :P_PK_CATEGORIAS
         and Vcc.FK_FINANCEIRO_CONTAS is null
         and Cat.PK_CATEGORIAS = Vcc.FK_CATEGORIAS
         and Cat.FK_FINANCEIRO_CONTAS > 0
         and Cat.FLAG_CAT             < 4
       order by PK_CADASTROS
        into :PkCadastros, :RazSoc, :PkCategorias, :FlagCat,
             :PkFinanceiroContas do
  begin
    select MASK_CTA, GRAU_CTA, FLAG_TCTA, FK_PLANO_CONTAS
      from FINANCEIRO_CONTAS
     where PK_FINANCEIRO_CONTAS = :PkFinanceiroContas
      into :MaskCta, :GrauCta, :FlagTCta, :FkPlanoContas;
    if (MaskCta is null) then
      MaskCta = '';
    if (GrauCta is null) then
      GrauCta = 0;
    select Max(SEQ_CTA) from FINANCEIRO_CONTAS
     where FK_FINANCEIRO_CONTAS = :PkFinanceiroContas
      into :SeqCta;
    if (SeqCta is null) then SeqCta = 0;
    SeqCta = SeqCta + 1;
    GrauCta = GrauCta + 1;
    MaskCta = MaskCta || '.' || Cast(SeqCta as varchar(10));
    select R_PK_FINANCEIRO_CONTAS
      from STP_GET_PK_FINANCEIRO_CONTAS(:PkFinanceiroContas, :SeqCta)
      into :R_PK_FINANCEIRO_CONTAS;
    insert into FINANCEIRO_CONTAS
     (PK_FINANCEIRO_CONTAS, FK_FINANCEIRO_CONTAS, SEQ_CTA,
      FK_PLANO_CONTAS, DSC_CTA, MASK_CTA, GRAU_CTA, FLAG_ID,
      FLAG_TCTA, FLAG_ANL_SNT, KC_FINANCEIRO_LANCAMENTOS)
    values
      (:R_PK_FINANCEIRO_CONTAS, :PkFinanceiroContas, :SeqCta, 
       :FkPlanoContas, :RazSoc, :MaskCta, :GrauCta, 0, 
       :FlagTCta, 1, 0);
    update VINCULOS_CAD_CAT set
           FK_FINANCEIRO_CONTAS = :R_PK_FINANCEIRO_CONTAS
     where FK_CADASTROS  = :PkCadastros
       and FK_CATEGORIAS = :PkCategorias;
  end
  suspend;
end ^

set term ;^;


/*  Update trigger "TBU0_BAIRROS" for table "BAIRROS"  */
set term ^;

create trigger TBU0_BAIRROS for BAIRROS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'BAIRROS', 3, 'BAIRROS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TAU0_CADASTROS" for table "CADASTROS"  */
set term ^;

create trigger TAU0_CADASTROS for CADASTROS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'CADASTROS', 3, 'CADASTROS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_CADASTROS" for table "CADASTROS"  */
set term ^;

create trigger TBIG_CADASTROS for CADASTROS
  before insert as
begin
  if ((New.PK_CADASTROS is null) or (New.PK_CADASTROS = 0)) then
  begin
    select R_PK_CADASTROS from STP_GET_PK_CADASTROS
      into New.PK_CADASTROS;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'CADASTROS', 2, 'CADASTROS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_CADASTROS" for table "CADASTROS"  */
set term ^;

create trigger TAD0_CADASTROS for CADASTROS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'CADASTROS', 4, 'CADASTROS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_CADASTROS_CONTATOS" for table "CADASTROS_CONTATOS"  */
set term ^;

create trigger TBIG_CADASTROS_CONTATOS for CADASTROS_CONTATOS
before insert as
  declare variable MaxValue integer;
begin
  if ((New.PK_CADASTROS_CONTATOS is null) or (New.PK_CADASTROS_CONTATOS = 0)) then
  begin
    select Max(PK_CADASTROS_CONTATOS)
      from CADASTROS_CONTATOS
     where FK_CADASTROS = New.FK_CADASTROS
      into :MaxValue;
    if (MaxValue is null) then
      MaxValue   = 0;
    New.PK_CADASTROS_CONTATOS = MaxValue + 1;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
end^

set term ;^;


/*  Update trigger "TBU0_CADASTROS_CONTATOS" for table "CADASTROS_CONTATOS"  */
set term ^;

create trigger TBU0_CADASTROS_CONTATOS for CADASTROS_CONTATOS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'CADASTROS_CONTATOS', 3, 'CADASTROS_CONTATOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_CADASTROS_EVENTOS" for table "CADASTROS_EVENTOS"  */
set term ^;

create trigger TBU0_CADASTROS_EVENTOS for CADASTROS_EVENTOS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'CADASTROS_EVENTOS', 3, 'CADASTROS_EVENTOS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TAI0_CADASTROS_IMAGENS" for table "CADASTROS_IMAGENS"  */
set term ^;

create trigger TAI0_CADASTROS_IMAGENS for CADASTROS_IMAGENS
  after insert as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'CADASTROS_IMAGENS', 2, 'CADASTROS_IMAGENS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TAU0_CADASTROS_IMAGENS" for table "CADASTROS_IMAGENS"  */
set term ^;

create trigger TAU0_CADASTROS_IMAGENS for CADASTROS_IMAGENS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'CADASTROS_IMAGENS', 3, 'CADASTROS_IMAGENS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_CADASTROS_IMAGENS" for table "CADASTROS_IMAGENS"  */
set term ^;

create trigger TAD0_CADASTROS_IMAGENS for CADASTROS_IMAGENS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'CADASTROS_IMAGENS', 4, 'CADASTROS_IMAGENS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_CADASTROS_INTERNET" for table "CADASTROS_INTERNET"  */
set term ^;

create trigger TBU0_CADASTROS_INTERNET for CADASTROS_INTERNET
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'CADASTROS_INTERNET', 3, 'CADASTROS_INTERNET', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_CADASTROS_INTERNET" for table "CADASTROS_INTERNET"  */
set term ^;

create trigger TBIG_CADASTROS_INTERNET for CADASTROS_INTERNET
before insert as
  declare variable MaxValue integer;
begin
  if ((New.PK_CADASTROS_INTERNET is null) or 
     ( New.PK_CADASTROS_INTERNET = 0)) then
  begin
    select Max(PK_CADASTROS_INTERNET)
      from CADASTROS_INTERNET
     where FK_CADASTROS = New.FK_CADASTROS
      into :MaxValue;
    if (MaxValue is null) then
      MaxValue   = 0;
    New.PK_CADASTROS_INTERNET = MaxValue + 1;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
end^

set term ;^;


/*  Insert trigger "TAI0_CADASTROS_OBSERVACOES" for table "CADASTROS_OBSERVACOES"  */
set term ^;

create trigger TAI0_CADASTROS_OBSERVACOES for CADASTROS_OBSERVACOES
  after insert as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'CADASTROS_OBSERVACOES', 2, 'CADASTROS_OBSERVACOES', current_timestamp);
end^

set term ;^;


/*  Update trigger "TAU0_CADASTROS_OBSERVACOES" for table "CADASTROS_OBSERVACOES"  */
set term ^;

create trigger TAU0_CADASTROS_OBSERVACOES for CADASTROS_OBSERVACOES
  after update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  execute procedure STP_INSERT_HISTORIC ('CADASTROS_OBSERVACOES', 'CADASTROS_OBSERVACOES',
    'atualização de registro', 'UPD');
end^

set term ;^;


/*  Update trigger "TAD0_CADASTROS_OBSERVACOES" for table "CADASTROS_OBSERVACOES"  */
set term ^;

create trigger TAD0_CADASTROS_OBSERVACOES for CADASTROS_OBSERVACOES
before delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'CADASTROS_OBSERVACOES', 4, 'CADASTROS_OBSERVACOES', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_CATEGORIAS" for table "CATEGORIAS"  */
set term ^;

create trigger TBIG_CATEGORIAS for CATEGORIAS
  before insert as
begin
  if ((New.PK_CATEGORIAS is null) or (New.PK_CATEGORIAS = 0)) then
  begin
    select R_PK_CATEGORIAS from STP_GET_PK_CATEGORIAS
      into New.PK_CATEGORIAS;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'CATEGORIAS', 2, 'CATEGORIAS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_CATEGORIAS" for table "CATEGORIAS"  */
set term ^;

create trigger TBU0_CATEGORIAS for CATEGORIAS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'CATEGORIAS', 3, 'CATEGORIAS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_CATEGORIAS" for table "CATEGORIAS"  */
set term ^;

create trigger TAD0_CATEGORIAS for CATEGORIAS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'CATEGORIAS', 4, 'CATEGORIAS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_CENTRO_CUSTOS" for table "CENTRO_CUSTOS"  */
set term ^;

create trigger TBIG_CENTRO_CUSTOS for CENTRO_CUSTOS
  before insert as
begin
  if ((New.PK_CENTRO_CUSTOS is null) or (New.PK_CENTRO_CUSTOS = 0)) then
  begin
    select R_PK_CENTRO_CUSTOS from STP_GET_PK_CENTRO_CUSTOS
      into New.PK_CENTRO_CUSTOS;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'CENTRO_CUSTOS', 2, 'CENTRO_CUSTOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_CENTRO_CUSTOS" for table "CENTRO_CUSTOS"  */
set term ^;

create trigger TBU0_CENTRO_CUSTOS for CENTRO_CUSTOS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'CENTRO_CUSTOS', 3, 'CENTRO_CUSTOS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_CENTRO_CUSTOS" for table "CENTRO_CUSTOS"  */
set term ^;

create trigger TAD0_CENTRO_CUSTOS for CENTRO_CUSTOS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'CENTRO_CUSTOS', 4, 'CENTRO_CUSTOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_CLIENTES" for table "CLIENTES"  */
set term ^;

create trigger TBU0_CLIENTES for CLIENTES
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'CLIENTES', 3, 'CLIENTES', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_COBRANCAS" for table "COBRANCAS"  */
set term ^;

create trigger TBU0_COBRANCAS for COBRANCAS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'COBRANCAS', 3, 'COBRANCAS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_DADOS_PESSOAIS" for table "DADOS_PESSOAIS"  */
set term ^;

create trigger TBU0_DADOS_PESSOAIS for DADOS_PESSOAIS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'DADOS_PESSOAIS', 3, 'DADOS_PESSOAIS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_DEPARTAMENTOS" for table "DEPARTAMENTOS"  */
set term ^;

create trigger TBIG_DEPARTAMENTOS for DEPARTAMENTOS
before insert as
begin
  if ((New.PK_DEPARTAMENTOS is null) or (New.PK_DEPARTAMENTOS = 0)) then
    New.PK_DEPARTAMENTOS = Gen_Id(DEPARTAMENTOS, 1);
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'DEPARTAMENTOS', 2, 'DEPARTAMENTOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_DEPARTAMENTOS" for table "DEPARTAMENTOS"  */
set term ^;

create trigger TBU0_DEPARTAMENTOS for DEPARTAMENTOS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'DEPARTAMENTOS', 3, 'DEPARTAMENTOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_ENTREGAS" for table "ENTREGAS"  */
set term ^;

create trigger TBU0_ENTREGAS for ENTREGAS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'ENTREGAS', 3, 'ENTREGAS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_ESTADOS" for table "ESTADOS"  */
set term ^;

create trigger TBU0_ESTADOS for ESTADOS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'ESTADOS', 3, 'ESTADOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TAU0_FINANCEIRO_CONTAS" for table "FINANCEIRO_CONTAS"  */
set term ^;

create trigger TAU0_FINANCEIRO_CONTAS for FINANCEIRO_CONTAS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'FINANCEIRO_CONTAS', 3, 'FINANCEIRO_CONTAS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_FINANCEIRO_CONTAS" for table "FINANCEIRO_CONTAS"  */
set term ^;

create trigger TBIG_FINANCEIRO_CONTAS for FINANCEIRO_CONTAS
  before insert as
begin
  if ((New.PK_FINANCEIRO_CONTAS is null) or (New.PK_FINANCEIRO_CONTAS = 0)) then
  begin
    select R_PK_FINANCEIRO_CONTAS, R_FK_FINANCEIRO_CONTAS, R_SEQ_CTA
      from STP_GET_PK_FINANCEIRO_CONTAS(New.FK_FINANCEIRO_CONTAS, New.SEQ_CTA)
      into New.PK_FINANCEIRO_CONTAS, New.FK_FINANCEIRO_CONTAS, New.SEQ_CTA;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'FINANCEIRO_CONTAS', 2, 'FINANCEIRO_CONTAS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_FINANCEIRO_CONTAS" for table "FINANCEIRO_CONTAS"  */
set term ^;

create trigger TAD0_FINANCEIRO_CONTAS for FINANCEIRO_CONTAS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'FINANCEIRO_CONTAS', 4, 'FINANCEIRO_CONTAS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_FORNECEDORES" for table "FORNECEDORES"  */
set term ^;

create trigger TBU0_FORNECEDORES for FORNECEDORES
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
end;^

set term ;^;


/*  Update trigger "TBU0_FUNCIONARIOS" for table "FUNCIONARIOS"  */
set term ^;

create trigger TBU0_FUNCIONARIOS for FUNCIONARIOS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'FUNCIONARIOS', 3, 'FUNCIONARIOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TAU0_INFO_COMERCIAL" for table "INFO_COMERCIAL"  */
set term ^;

create trigger TAU0_INFO_COMERCIAL for INFO_COMERCIAL
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'INFO_COMERCIAL', 3, 'INFO_COMERCIAL', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TAI0_INFO_COMERCIAL" for table "INFO_COMERCIAL"  */
set term ^;

create trigger TAI0_INFO_COMERCIAL for INFO_COMERCIAL
  after insert as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'INFO_COMERCIAL', 2, 'INFO_COMERCIAL', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_INFO_COMERCIAL" for table "INFO_COMERCIAL"  */
set term ^;

create trigger TAD0_INFO_COMERCIAL for INFO_COMERCIAL
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'INFO_COMERCIAL', 4, 'INFO_COMERCIAL', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_LOGRADOUROS" for table "LOGRADOUROS"  */
set term ^;

create trigger TBU0_LOGRADOUROS for LOGRADOUROS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'LOGRADOUROS', 3, 'LOGRADOUROS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_MOEDAS" for table "MOEDAS"  */
set term ^;

create trigger TBU0_MOEDAS for MOEDAS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
end;^

set term ;^;


/*  Update trigger "TBU0_MUNICIPIOS" for table "MUNICIPIOS"  */
set term ^;

create trigger TBU0_MUNICIPIOS for MUNICIPIOS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'MUNICIPIOS', 3, 'MUNICIPIOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_MUNICIPIOS_ALIQUOTAS" for table "MUNICIPIOS_ALIQUOTAS"  */
set term ^;

create trigger TBU0_MUNICIPIOS_ALIQUOTAS for MUNICIPIOS_ALIQUOTAS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'MUNICIPIOS_ALIQUOTAS', 3, 'MUNICIPIOS_ALIQUOTAS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TAI0_MUNICIPIOS_ALIQUOTAS" for table "MUNICIPIOS_ALIQUOTAS"  */
set term ^;

create trigger TAI0_MUNICIPIOS_ALIQUOTAS for MUNICIPIOS_ALIQUOTAS
  after insert as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'MUNICIPIOS_ALIQUOTAS', 2, 'MUNICIPIOS_ALIQUOTAS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_MUNICIPIOS_ALIQUOTAS" for table "MUNICIPIOS_ALIQUOTAS"  */
set term ^;

create trigger TAD0_MUNICIPIOS_ALIQUOTAS for MUNICIPIOS_ALIQUOTAS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'MUNICIPIOS_ALIQUOTAS', 4, 'MUNICIPIOS_ALIQUOTAS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_PAISES" for table "PAISES"  */
set term ^;

create trigger TBIG_PAISES for PAISES
before insert as
begin
  if ((New.PK_PAISES is null) or (New.PK_PAISES = 0)) then
    New.PK_PAISES = Gen_Id(PAISES, 1);
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PAISES', 2, 'PAISES', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_PAISES" for table "PAISES"  */
set term ^;

create trigger TBU0_PAISES for PAISES
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PAISES', 3, 'PAISES', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_PLANO_CONTAS" for table "PLANO_CONTAS"  */
set term ^;

create trigger TBU0_PLANO_CONTAS for PLANO_CONTAS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PLANO_CONTAS', 3, 'PLANO_CONTAS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_PLANO_CONTAS" for table "PLANO_CONTAS"  */
set term ^;

create trigger TBIG_PLANO_CONTAS for PLANO_CONTAS
  before insert as
begin
  if ((New.PK_PLANO_CONTAS is null) or (New.PK_PLANO_CONTAS = 0)) then
  begin
    select R_PK_PLANO_CONTAS from STP_GET_PK_PLANO_CONTAS(New.FK_PLANO_CONTAS, New.SEQ_PLCTA)
      into New.PK_PLANO_CONTAS;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PLANO_CONTAS', 2, 'PLANO_CONTAS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_PLANO_CONTAS" for table "PLANO_CONTAS"  */
set term ^;

create trigger TAD0_PLANO_CONTAS for PLANO_CONTAS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PLANO_CONTAS', 4, 'PLANO_CONTAS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_PORTOS" for table "PORTOS"  */
set term ^;

create trigger TBU0_PORTOS for PORTOS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PORTOS', 3, 'PORTOS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_PORTOS" for table "PORTOS"  */
set term ^;

create trigger TBIG_PORTOS for PORTOS
before insert as
begin
  if ((New.PK_PORTOS is null) or (New.PK_PORTOS = 0)) then
    New.PK_PORTOS = Gen_Id(PORTOS, 1);
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PORTOS', 2, 'PORTOS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_REFERENCIA_COMERCIAIS" for table "REFERENCIA_COMERCIAIS"  */
set term ^;

create trigger TBIG_REFERENCIA_COMERCIAIS for REFERENCIA_COMERCIAIS
before insert as
  declare variable MaxValue integer;
begin
  Select Max(PK_REFERENCIA_COMERCIAIS)
    from REFERENCIA_COMERCIAIS
   where FK_CLIENTES = New.FK_CLIENTES
    into :MaxValue;
  if (MaxValue is null) then
    MaxValue   = 0;
  New.PK_REFERENCIA_COMERCIAIS  = MaxValue + 1;
  New.OPE_INC                   = user;
  New.DTHR_INC                  = current_timestamp;
end;^

set term ;^;


/*  Update trigger "TBU0_REFERENCIA_COMERCIAIS" for table "REFERENCIA_COMERCIAIS"  */
set term ^;

create trigger TBU0_REFERENCIA_COMERCIAIS for REFERENCIA_COMERCIAIS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'REFERENCIA_COMERCIAIS', 3, 'REFERENCIA_COMERCIAIS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_SOCIOS" for table "SOCIOS"  */
set term ^;

create trigger TBU0_SOCIOS for SOCIOS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'SOCIOS', 3, 'SOCIOS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_TIPO_ALIAS" for table "TIPO_ALIAS"  */
set term ^;

create trigger TBIG_TIPO_ALIAS for TIPO_ALIAS
before insert as
begin
  if ((New.PK_TIPO_ALIAS is null) or (New.PK_TIPO_ALIAS = 0)) then
    New.PK_TIPO_ALIAS = Gen_Id(TIPO_ALIAS, 1);
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_ALIAS', 2, 'TIPO_ALIAS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_TIPO_ALIAS" for table "TIPO_ALIAS"  */
set term ^;

create trigger TBU0_TIPO_ALIAS for TIPO_ALIAS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_ALIAS', 3, 'TIPO_ALIAS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBD0_TIPO_ALIAS" for table "TIPO_ALIAS"  */
set term ^;

create trigger TBD0_TIPO_ALIAS for TIPO_ALIAS
before delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_ALIAS', 4, 'TIPO_ALIAS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_TIPO_BLOQUEIOS" for table "TIPO_BLOQUEIOS"  */
set term ^;

create trigger TBIG_TIPO_BLOQUEIOS for TIPO_BLOQUEIOS
before insert as
begin
  if ((New.PK_TIPO_BLOQUEIOS is null) or (New.PK_TIPO_BLOQUEIOS = 0)) then
    New.PK_TIPO_BLOQUEIOS = Gen_Id(TIPO_BLOQUEIOS, 1);
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_BLOQUEIOS', 2, 'TIPO_BLOQUEIOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_TIPO_BLOQUEIOS" for table "TIPO_BLOQUEIOS"  */
set term ^;

create trigger TBU0_TIPO_BLOQUEIOS for TIPO_BLOQUEIOS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_BLOQUEIOS', 3, 'TIPO_BLOQUEIOS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_TIPO_COMISSOES" for table "TIPO_COMISSOES"  */
set term ^;

create trigger TBIG_TIPO_COMISSOES for TIPO_COMISSOES
  before insert as
begin
  if ((New.PK_TIPO_COMISSOES is null) or (New.PK_TIPO_COMISSOES = 0)) then
  begin
    select R_PK_TIPO_COMISSOES from STP_GET_PK_TIPO_COMISSOES
      into New.PK_TIPO_COMISSOES;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_COMISSOES', 2, 'TIPO_COMISSOES', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_TIPO_COMISSOES" for table "TIPO_COMISSOES"  */
set term ^;

create trigger TBU0_TIPO_COMISSOES for TIPO_COMISSOES
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_COMISSOES', 3, 'TIPO_COMISSOES', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_TIPO_COMISSOES" for table "TIPO_COMISSOES"  */
set term ^;

create trigger TAD0_TIPO_COMISSOES for TIPO_COMISSOES
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_COMISSOES', 4, 'TIPO_COMISSOES', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_TIPO_ENDERECOS" for table "TIPO_ENDERECOS"  */
set term ^;

create trigger TBIG_TIPO_ENDERECOS for TIPO_ENDERECOS
before insert as
begin
  if ((New.PK_TIPO_ENDERECOS is null) or (New.PK_TIPO_ENDERECOS = 0)) then
    New.PK_TIPO_ENDERECOS = Gen_Id(TIPO_ENDERECOS, 1);
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_ENDERECOS', 2, 'TIPO_ENDERECOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_TIPO_ENDERECOS" for table "TIPO_ENDERECOS"  */
set term ^;

create trigger TBU0_TIPO_ENDERECOS for TIPO_ENDERECOS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_ENDERECOS', 3, 'TIPO_ENDERECOS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_TIPO_ESTABELECIMENTOS" for table "TIPO_ESTABELECIMENTOS"  */
set term ^;

create trigger TBIG_TIPO_ESTABELECIMENTOS for TIPO_ESTABELECIMENTOS
before insert as
begin
  if ((New.PK_TIPO_ESTABELECIMENTOS is null) or (New.PK_TIPO_ESTABELECIMENTOS = 0)) then
    New.PK_TIPO_ESTABELECIMENTOS = Gen_Id(TIPO_ESTABELECIMENTOS, 1);
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_ESTABELECIMENTOS', 2, 'TIPO_ESTABELECIMENTOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_TIPO_ESTABELECIMENTOS" for table "TIPO_ESTABELECIMENTOS"  */
set term ^;

create trigger TBU0_TIPO_ESTABELECIMENTOS for TIPO_ESTABELECIMENTOS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_ESTABELECIMENTOS', 3, 'TIPO_ESTABELECIMENTOS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_TIPO_MOEDAS" for table "TIPO_MOEDAS"  */
set term ^;

create trigger TBIG_TIPO_MOEDAS for TIPO_MOEDAS
before insert as
begin
  if ((New.PK_TIPO_MOEDAS is null) or (New.PK_TIPO_MOEDAS = 0)) then
    New.PK_TIPO_MOEDAS = Gen_Id(TIPO_MOEDAS, 1);
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_MOEDAS', 2, 'TIPO_MOEDAS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_TIPO_MOEDAS" for table "TIPO_MOEDAS"  */
set term ^;

create trigger TBU0_TIPO_MOEDAS for TIPO_MOEDAS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_MOEDAS', 3, 'TIPO_MOEDAS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_VINCULOS_CAD_CAT" for table "VINCULOS_CAD_CAT"  */
set term ^;

create trigger TBU0_VINCULOS_CAD_CAT for VINCULOS_CAD_CAT
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'VINCULOS_CAD_CAT', 3, 'VINCULOS_CAD_CAT', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TAI0_VINCULOS_CAD_CAT" for table "VINCULOS_CAD_CAT"  */
set term ^;

create trigger TAI0_VINCULOS_CAD_CAT for VINCULOS_CAD_CAT
  after insert as
  declare variable QtdRegs integer;
begin
  select R_PK_FINANCEIRO_CONTAS 
    from STP_CREATE_FINANCE_CATEGORY (New.FK_CADASTROS, New.FK_CATEGORIAS)
    into :QtdRegs;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'VINCULOS_CAD_CAT', 2, 'VINCULOS_CAD_CAT', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_VINCULOS_CAD_CAT" for table "VINCULOS_CAD_CAT"  */
set term ^;

create trigger TAD0_VINCULOS_CAD_CAT for VINCULOS_CAD_CAT
  after delete as
begin
  if (Old.FK_FINANCEIRO_CONTAS is not null) then
    delete from FINANCEIRO_CONTAS 
     where PK_FINANCEIRO_CONTAS = Old.FK_FINANCEIRO_CONTAS;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'VINCULOS_CAD_CAT', 4, 'VINCULOS_CAD_CAT', current_timestamp);
end^

set term ;^;

