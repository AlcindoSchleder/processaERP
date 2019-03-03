/*==============================================================*/
/* Database name:  PROCESSA                                     */
/* DBMS name:      InterBase 6.x                                */
/* Created on:     20/04/2006 11:07:22                          */
/*==============================================================*/



/*  Insert trigger "TBIG_TIPO_CARGOS" for table "TIPO_CARGOS"  */
set term ^;

create trigger TBIG_TIPO_CARGOS for TIPO_CARGOS
before insert as
begin
  if ((New.PK_TIPO_CARGOS is null) or (New.PK_TIPO_CARGOS = 0)) then
    New.PK_TIPO_CARGOS = Gen_Id(TIPO_CARGOS, 1);
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
  execute procedure STP_INSERT_HISTORIC ('TIPO_CARGOS', 'TIPO_CARGOS',
    'inserção de registro', 'INC');
end^

set term ;^;


/*  Update trigger "TBU0_TIPO_CARGOS" for table "TIPO_CARGOS"  */
set term ^;

create trigger TBU0_TIPO_CARGOS for TIPO_CARGOS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  execute procedure STP_INSERT_HISTORIC ('TIPO_CARGOS', 'TIPO_CARGOS',
    'atualização de registro', 'UPD');
end^

set term ;^;


/*  Insert trigger "TAD0_TIPO_CARGOS" for table "TIPO_CARGOS"  */
set term ^;

create trigger TAD0_TIPO_CARGOS for TIPO_CARGOS
  after delete as
begin
  execute procedure STP_INSERT_HISTORIC ('TIPO_CARGOS', 'TIPO_CARGOS',
    'exclusão de registro', 'DEL');
end^

set term ;^;


/*  Insert trigger "TBIG_TIPO_TURNOS" for table "TIPO_TURNOS"  */
set term ^;

create trigger TBIG_TIPO_TURNOS for TIPO_TURNOS
before insert as
begin
  if ((New.PK_TIPO_TURNOS is null) or (New.PK_TIPO_TURNOS = 0)) then
    New.PK_TIPO_TURNOS = Gen_Id(TIPO_TURNOS, 1);
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
  execute procedure STP_INSERT_HISTORIC ('TIPO_TURNOS', 'TIPO_TURNOS',
    'inserção de registro', 'INC');
end^

set term ;^;


/*  Delete trigger "TAD0_TIPO_TURNOS" for table "TIPO_TURNOS"  */
set term ^;

create trigger TAD0_TIPO_TURNOS for TIPO_TURNOS
  after delete as
begin
  execute procedure STP_INSERT_HISTORIC ('TIPO_TURNOS', 'TIPO_TURNOS',
    'exclusão de registro', 'DEL');
end^

set term ;^;


/*  Update trigger "TAU0_TIPO_TURNOS" for table "TIPO_TURNOS"  */
set term ^;

create trigger TAU0_TIPO_TURNOS for TIPO_TURNOS
  after update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  execute procedure STP_INSERT_HISTORIC ('TIPO_TURNOS', 'TIPO_TURNOS',
    'atualização de registro', 'UPD');
end^

set term ;^;


/*  Update trigger "TBU0_VINCULO_CC_DP_CR" for table "VINCULO_CC_DP_CR"  */
set term ^;

create trigger TBU0_VINCULO_CC_DP_CR for VINCULO_CC_DP_CR
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  execute procedure STP_INSERT_HISTORIC ('VINCULO_CC_DP_CR', 'VINCULO_CC_DP_CR',
    'atualização de registro', 'UPD');
end^

set term ;^;

