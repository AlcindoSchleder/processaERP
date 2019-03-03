/*==============================================================*/
/* Database name:  PROCESSA                                     */
/* DBMS name:      Friebird15x                                  */
/* Created on:     7/9/2006 18:48:06                            */
/*==============================================================*/



set term ^;

create procedure STP_DELETE_FINANCEIRO_CONTAS (
  P_PK_FINANCEIRO_CONTAS integer
)
as
  declare variable PkFinanceiroContas integer;
begin
  if ((P_PK_FINANCEIRO_CONTAS is null) or (P_PK_FINANCEIRO_CONTAS = 0)) then
    P_PK_FINANCEIRO_CONTAS = -1;
  for select PK_FINANCEIRO_CONTAS from FINANCEIRO_CONTAS
       where ((PK_FINANCEIRO_CONTAS = :P_PK_FINANCEIRO_CONTAS)
          or (-1 = :P_PK_FINANCEIRO_CONTAS))
       order by PK_FINANCEIRO_CONTAS desc
        into :PkFinanceiroContas do
  begin
    delete from FINANCEIRO_CONTAS
     where PK_FINANCEIRO_CONTAS = :PkFinanceiroContas;
  end
end^

set term ;^;

grant EXECUTE on procedure STP_DELETE_FINANCEIRO_CONTAS to PUBLIC;


set term ^;

create procedure STP_GET_FINANCEIRO_CONTA_FATHER (
  P_PK_FINANCEIRO_CONTAS integer
)
returns (
  R_PK_FINANCEIRO_CONTAS integer,
  R_DSC_CTA              varchar(50),
  R_FK_FINANCEIRO_CONTAS integer
)
as
begin
  select FK_FINANCEIRO_CONTAS, PK_FINANCEIRO_CONTAS, DSC_CTA
        from FINANCEIRO_CONTAS
       where PK_FINANCEIRO_CONTAS = :P_PK_FINANCEIRO_CONTAS
        into :R_FK_FINANCEIRO_CONTAS, :R_PK_FINANCEIRO_CONTAS, :R_DSC_CTA;
    suspend;
    if (R_FK_FINANCEIRO_CONTAS = R_PK_FINANCEIRO_CONTAS) then exit;
    for select R_PK_FINANCEIRO_CONTAS, R_DSC_CTA, R_FK_FINANCEIRO_CONTAS
          from STP_GET_FINANCEIRO_CONTA_FATHER (:R_FK_FINANCEIRO_CONTAS)
          into :R_PK_FINANCEIRO_CONTAS, :R_DSC_CTA, :R_FK_FINANCEIRO_CONTAS do
    begin
      suspend;
    end
end^

set term ;^;



grant EXECUTE on procedure STP_GET_FINANCEIRO_CONTA_FATHER to PUBLIC;


set term ^;

create procedure STP_GET_PK_CENARIOS_FINANCEIROS
returns (
  R_PK_CENARIOS_FINANCEIROS smallint
)
as
begin
  R_PK_CENARIOS_FINANCEIROS = Gen_Id(CENARIOS_FINANCEIROS, 1);
end ^

set term ;^;

grant EXECUTE on procedure STP_GET_PK_CENARIOS_FINANCEIROS to PUBLIC;


set term ^;

create procedure STP_GET_PK_TIPO_IMPOSTOS
returns (
  R_PK_TIPO_IMPOSTOS smallint
)
as
begin
  R_PK_TIPO_IMPOSTOS = Gen_Id(TIPO_IMPOSTOS, 1);
  suspend;
end ^

set term ;^;

grant EXECUTE on procedure STP_GET_PK_TIPO_IMPOSTOS to PUBLIC;


/*  Update trigger "TBU0_ALIQUOTAS" for table "ALIQUOTAS"  */
set term ^;

create trigger TBU0_ALIQUOTAS for ALIQUOTAS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'ALIQUOTAS', 3, 'ALIQUOTAS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TAI0_ALIQUOTAS" for table "ALIQUOTAS"  */
set term ^;

create trigger TAI0_ALIQUOTAS for ALIQUOTAS
  after insert as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'ALIQUOTAS', 2, 'ALIQUOTAS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_ALIQUOTAS" for table "ALIQUOTAS"  */
set term ^;

create trigger TAD0_ALIQUOTAS for ALIQUOTAS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'ALIQUOTAS', 4, 'ALIQUOTAS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_ALIQUOTAS_IMP_FISCAL" for table "ALIQUOTAS_IMP_FISCAL"  */
set term ^;

create trigger TBU0_ALIQUOTAS_IMP_FISCAL for ALIQUOTAS_IMP_FISCAL
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'ALIQUOTAS_IMP_FISCAL', 3, 'ALIQUOTAS_IMP_FISCAL', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_ALIQUOTAS_IMP_FISCAL" for table "ALIQUOTAS_IMP_FISCAL"  */
set term ^;

create trigger TAD0_ALIQUOTAS_IMP_FISCAL for ALIQUOTAS_IMP_FISCAL
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'ALIQUOTAS_IMP_FISCAL', 4, 'ALIQUOTAS_IMP_FISCAL', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TAI0_ALIQUOTAS_IMP_FISCAL" for table "ALIQUOTAS_IMP_FISCAL"  */
set term ^;

create trigger TAI0_ALIQUOTAS_IMP_FISCAL for ALIQUOTAS_IMP_FISCAL
  after insert as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'ALIQUOTAS_IMP_FISCAL', 2, 'ALIQUOTAS_IMP_FISCAL', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_CENARIOS_FINANCEIROS" for table "CENARIOS_FINANCEIROS"  */
create exception CANT_CREATE_2BASE_CENARY 'Só pode ser criado 1 cenário base por empresa';

set term ^;

create trigger TBIG_CENARIOS_FINANCEIROS for CENARIOS_FINANCEIROS
  before insert as
  declare variable Rows integer;
begin
  if (New.FLAG_TPCEN = 1) then
  begin
    select Count(*) from CENARIOS_FINANCEIROS 
     where FK_EMPRESAS = New.FK_EMPRESAS 
       and FLAG_TPCEN  = 1
      into :Rows;
    if ((Rows is not null) and (Rows > 0)) then
      exception CANT_CREATE_2BASE_CENARY;
  end
  if ((New.PK_CENARIOS_FINANCEIROS is null) or (New.PK_CENARIOS_FINANCEIROS = 0)) then
  begin
    select R_PK_CENARIOS_FINANCEIROS from STP_GET_PK_CENARIOS_FINANCEIROS
      into New.PK_CENARIOS_FINANCEIROS;
  end
  update PARAMETROS set
         FK_CENARIOS_FINANCEIROS = New.PK_CENARIOS_FINANCEIROS
   where FK_EMPRESAS = New.FK_EMPRESAS;
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'CENARIOS_FINANCEIROS', 2, 'CENARIOS_FINANCEIROS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_CENARIOS_FINANCEIROS" for table "CENARIOS_FINANCEIROS"  */
set term ^;

create trigger TBU0_CENARIOS_FINANCEIROS for CENARIOS_FINANCEIROS
  after update as
  declare variable Rows integer;
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  if ((Old.FLAG_TPCEN = 0) and (New.FLAG_TPCEN = 1)) then
  begin
    select Count(*) from CENARIOS_FINANCEIROS 
     where FK_EMPRESAS = New.FK_EMPRESAS 
       and FLAG_TPCEN  = 1
      into :Rows;
    if ((Rows is not null) and (Rows > 0)) then
      exception CANT_CREATE_2BASE_CENARY;
  end
  update PARAMETROS set
         FK_CENARIOS_FINANCEIROS = New.PK_CENARIOS_FINANCEIROS
   where FK_EMPRESAS = New.FK_EMPRESAS;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'CENARIOS_FINANCEIROS', 3, 'CENARIOS_FINANCEIROS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBD0_CENARIOS_FINANCEIROS" for table "CENARIOS_FINANCEIROS"  */
set term ^;

create trigger TBD0_CENARIOS_FINANCEIROS for CENARIOS_FINANCEIROS
before delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'CENARIOS_FINANCEIROS', 4, 'CENARIOS_FINANCEIROS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_CLASSIFICACAO_FISCAL" for table "CLASSIFICACAO_FISCAL"  */
set term ^;

create trigger TBU0_CLASSIFICACAO_FISCAL for CLASSIFICACAO_FISCAL
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'CLASSIFICACAO_FISCAL', 3, 'CLASSIFICACAO_FISCAL', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TAI0_FINANCEIROS_SALDOS_EXERCIC" for table "FINANCEIROS_SALDOS_EXERCICIO"  */
set term ^;

create trigger TAI0_FINANCEIROS_SALDOS_EXERCIC for FINANCEIROS_SALDOS_EXERCICIO
  before insert as
  declare variable IMonth smallint;
  declare variable SMonth char(2);
  declare variable SYear  char(4);
begin
  if ((New.PK_FINANCEIROS_SALDOS_EXERCICIO is null) or (New.PK_FINANCEIROS_SALDOS_EXERCICIO = 0)) then
  begin
    IMonth = Extract(Month from New.DTA_SLD);
    SYear  = Cast(Extract(Year  from New.DTA_SLD) as char(4));
    if (IMonth < 10) then
      SMonth = Cast('0' || Cast(IMonth as char(1)) as char(2));
    else
      SMonth = Cast(IMonth as char(2));
    New.PK_FINANCEIROS_SALDOS_EXERCICIO = cast(SYear || SMonth as char(6));
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'FINANCEIROS_SALDOS_EXERCICIO', 2, 'FINANCEIROS_SALDOS_EXERCICIO', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_FINANCEIROS_SALDOS_EXERCIC" for table "FINANCEIROS_SALDOS_EXERCICIO"  */
set term ^;

create trigger TAD0_FINANCEIROS_SALDOS_EXERCIC for FINANCEIROS_SALDOS_EXERCICIO
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'FINANCEIROS_SALDOS_EXERCICIO', 4, 'FINANCEIROS_SALDOS_EXERCICIO', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_FINANCEIROS_SALDOS_EXERCIC" for table "FINANCEIROS_SALDOS_EXERCICIO"  */
set term ^;

create trigger TBU0_FINANCEIROS_SALDOS_EXERCIC for FINANCEIROS_SALDOS_EXERCICIO
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'FINANCEIROS_SALDOS_EXERCICIO', 3, 'FINANCEIROS_SALDOS_EXERCICIO', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_FINANCEIRO_CONTAS_SALDO" for table "FINANCEIRO_CONTAS_SALDO"  */
set term ^;

create trigger TAD0_FINANCEIRO_CONTAS_SALDO for FINANCEIRO_CONTAS_SALDO
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'FINANCEIRO_CONTAS_SALDO', 4, 'FINANCEIRO_CONTAS_SALDO', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TAI0_FINANCEIRO_CONTAS_SALDO" for table "FINANCEIRO_CONTAS_SALDO"  */
set term ^;

create trigger TAI0_FINANCEIRO_CONTAS_SALDO for FINANCEIRO_CONTAS_SALDO
  after insert as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'FINANCEIRO_CONTAS_SALDO', 2, 'FINANCEIRO_CONTAS_SALDO', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_FINANCEIRO_CONTAS_SALDO" for table "FINANCEIRO_CONTAS_SALDO"  */
set term ^;

create trigger TBU0_FINANCEIRO_CONTAS_SALDO for FINANCEIRO_CONTAS_SALDO
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'FINANCEIRO_CONTAS_SALDO', 3, 'FINANCEIRO_CONTAS_SALDO', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_NATUREZA_OPERACOES" for table "NATUREZA_OPERACOES"  */
set term ^;

create trigger TBU0_NATUREZA_OPERACOES for NATUREZA_OPERACOES
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'NATUREZA_OPERACOES', 3, 'NATUREZA_OPERACOES', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_NATUREZA_OPERACOES" for table "NATUREZA_OPERACOES"  */
set term ^;

create trigger TBIG_NATUREZA_OPERACOES for NATUREZA_OPERACOES
before insert as
  declare variable MaxValue integer;
begin
  if ((New.PK_NATUREZA_OPERACOES is null) or 
      (New.PK_NATUREZA_OPERACOES = 0)) then
  begin
    select Max(New.PK_NATUREZA_OPERACOES)
      from NATUREZA_OPERACOES
     where FK_TIPO_CFOP = New.FK_TIPO_CFOP
      into :MaxValue;
    if (MaxValue is null) then
      MaxValue   = 0;
    New.PK_NATUREZA_OPERACOES = MaxValue + 1;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
end^

set term ;^;


/*  Update trigger "TBU0_ORIGENS_TRIBUTARIAS" for table "ORIGENS_TRIBUTARIAS"  */
set term ^;

create trigger TBU0_ORIGENS_TRIBUTARIAS for ORIGENS_TRIBUTARIAS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'ORIGENS_TRIBUTARIAS', 3, 'ORIGENS_TRIBUTARIAS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TAU0_SITUACAO_TRIBUTARIAS" for table "SITUACAO_TRIBUTARIAS"  */
set term ^;

create trigger TAU0_SITUACAO_TRIBUTARIAS for SITUACAO_TRIBUTARIAS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'SITUACAO_TRIBUTARIAS', 3, 'SITUACAO_TRIBUTARIAS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TAI0_SITUACAO_TRIBUTARIAS" for table "SITUACAO_TRIBUTARIAS"  */
set term ^;

create trigger TAI0_SITUACAO_TRIBUTARIAS for SITUACAO_TRIBUTARIAS
  after insert as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'SITUACAO_TRIBUTARIAS', 2, 'SITUACAO_TRIBUTARIAS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_SITUACAO_TRIBUTARIAS" for table "SITUACAO_TRIBUTARIAS"  */
set term ^;

create trigger TAD0_SITUACAO_TRIBUTARIAS for SITUACAO_TRIBUTARIAS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'SITUACAO_TRIBUTARIAS', 4, 'SITUACAO_TRIBUTARIAS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_TAX_RANGE" for table "TAX_RANGE"  */
set term ^;

create trigger TBU0_TAX_RANGE for TAX_RANGE
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TAX_RANGE', 3, 'TAX_RANGE', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_TIPO_CFOP" for table "TIPO_CFOP"  */
set term ^;

create trigger TBU0_TIPO_CFOP for TIPO_CFOP
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_CFOP', 3, 'TIPO_CFOP', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_TIPO_CFOP" for table "TIPO_CFOP"  */
set term ^;

create trigger TBIG_TIPO_CFOP for TIPO_CFOP
before insert as
begin
  if ((New.PK_TIPO_CFOP is null) or (New.PK_TIPO_CFOP = 0)) then
    New.PK_TIPO_CFOP = Gen_Id(TIPO_CFOP, 1);
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_CFOP', 2, 'TIPO_CFOP', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_TIPO_IMPOSTOS" for table "TIPO_IMPOSTOS"  */
set term ^;

create trigger TBIG_TIPO_IMPOSTOS for TIPO_IMPOSTOS
  before insert as
begin
  if ((New.PK_TIPO_IMPOSTOS is null) or (New.PK_TIPO_IMPOSTOS = 0)) then
  begin
    select R_PK_TIPO_IMPOSTOS from STP_GET_PK_TIPO_IMPOSTOS
      into New.PK_TIPO_IMPOSTOS;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_IMPOSTOS', 2, 'TIPO_IMPOSTOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TAU0_TIPO_IMPOSTOS" for table "TIPO_IMPOSTOS"  */
set term ^;

create trigger TAU0_TIPO_IMPOSTOS for TIPO_IMPOSTOS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_IMPOSTOS', 3, 'TIPO_IMPOSTOS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_TIPO_IMPOSTOS" for table "TIPO_IMPOSTOS"  */
set term ^;

create trigger TAD0_TIPO_IMPOSTOS for TIPO_IMPOSTOS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_IMPOSTOS', 4, 'TIPO_IMPOSTOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_TIPO_IMPOSTOS_FINANCEIRO" for table "TIPO_IMPOSTOS_FINANCEIRO"  */
set term ^;

create trigger TBU0_TIPO_IMPOSTOS_FINANCEIRO for TIPO_IMPOSTOS_FINANCEIRO
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_IMPOSTOS_FINANCEIRO', 3, 'TIPO_IMPOSTOS_FINANCEIRO', current_timestamp);
end^

set term ;^;

