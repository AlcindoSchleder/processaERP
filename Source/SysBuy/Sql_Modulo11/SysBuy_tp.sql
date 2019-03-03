/*==============================================================*/
/* Database name:  PROCESSA                                     */
/* DBMS name:      Friebird15x                                  */
/* Created on:     9/9/2006 15:30:25                            */
/*==============================================================*/



set term ^;

create procedure STP_GET_PK_COTACOES (
    P_FK_EMPRESAS INTEGER
)
returns (
    R_PK_COTACOES SMALLINT
)
as
begin
  R_PK_COTACOES = null;
  if ((P_FK_EMPRESAS is not null) or (P_FK_EMPRESAS > 0)) then 
  begin
    select KC_COTACOES 
      from MOD_BUY_KEYS
     where FK_EMPRESAS = :P_FK_EMPRESAS
      into :R_PK_COTACOES;
    if ((R_PK_COTACOES is null) or (R_PK_COTACOES = -1)) then
    begin
      insert into MOD_BUY_KEYS
        (FK_EMPRESAS, KC_COTACOES)
      values
        (:P_FK_EMPRESAS, 0);
      R_PK_COTACOES = 0;
    end
    R_PK_COTACOES = R_PK_COTACOES + 1;
    update MOD_BUY_KEYS set
           KC_COTACOES = :R_PK_COTACOES
     where FK_EMPRESAS = :P_FK_EMPRESAS;
  end
  suspend;
end^

set term ;^;

grant EXECUTE on procedure STP_GET_PK_COTACOES to PUBLIC;


/*  Insert trigger "TBIG_COTACOES" for table "COTACOES"  */
set term ^;

create trigger TBIG_COTACOES for COTACOES
  before insert as
begin
  if ((New.PK_COTACOES is null) or (New.PK_COTACOES = 0)) then
  begin
    select R_PK_COTACOES from STP_GET_PK_COTACOES(New.FK_EMPRESAS)
      into New.PK_COTACOES;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'COTACOES', 2, 'COTACOES', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_COTACOES" for table "COTACOES"  */
set term ^;

create trigger TBU0_COTACOES for COTACOES
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'COTACOES', 3, 'COTACOES', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_COTACOES" for table "COTACOES"  */
set term ^;

create trigger TAD0_COTACOES for COTACOES
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'COTACOES', 4, 'COTACOES', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_COTACOES_FORNECEDOR" for table "COTACOES_FORNECEDOR"  */
set term ^;

create trigger TBU0_COTACOES_FORNECEDOR for COTACOES_FORNECEDOR
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'COTACOES_FORNECEDOR', 3, 'COTACOES_FORNECEDOR', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TAI0_COTACOES_FORNECEDOR" for table "COTACOES_FORNECEDOR"  */
set term ^;

create trigger TAI0_COTACOES_FORNECEDOR for COTACOES_FORNECEDOR
  after insert as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'COTACOES_FORNECEDOR', 2, 'COTACOES_FORNECEDOR', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_COTACOES_FORNECEDOR" for table "COTACOES_FORNECEDOR"  */
set term ^;

create trigger TAD0_COTACOES_FORNECEDOR for COTACOES_FORNECEDOR
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'COTACOES_FORNECEDOR', 4, 'COTACOES_FORNECEDOR', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_COTACOES_MRP" for table "COTACOES_MRP"  */
set term ^;

create trigger TBU0_COTACOES_MRP for COTACOES_MRP
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'COTACOES_MRP', 3, 'COTACOES_MRP', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_COTACOES_MRP" for table "COTACOES_MRP"  */
set term ^;

create trigger TAD0_COTACOES_MRP for COTACOES_MRP
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'COTACOES_MRP', 4, 'COTACOES_MRP', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TAI0_COTACOES_MRP" for table "COTACOES_MRP"  */
set term ^;

create trigger TAI0_COTACOES_MRP for COTACOES_MRP
  after insert as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'COTACOES_MRP', 2, 'COTACOES_MRP', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_COTACOES_PRODUTOS" for table "COTACOES_PRODUTOS"  */
set term ^;

create trigger TBU0_COTACOES_PRODUTOS for COTACOES_PRODUTOS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'COTACOES_PRODUTOS', 3, 'COTACOES_PRODUTOS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_COTACOES_PRODUTOS" for table "COTACOES_PRODUTOS"  */
set term ^;

create trigger TAD0_COTACOES_PRODUTOS for COTACOES_PRODUTOS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'COTACOES_PRODUTOS', 4, 'COTACOES_PRODUTOS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TAI0_COTACOES_PRODUTOS" for table "COTACOES_PRODUTOS"  */
set term ^;

create trigger TAI0_COTACOES_PRODUTOS for COTACOES_PRODUTOS
  after insert as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'COTACOES_PRODUTOS', 2, 'COTACOES_PRODUTOS', current_timestamp);
end^

set term ;^;

