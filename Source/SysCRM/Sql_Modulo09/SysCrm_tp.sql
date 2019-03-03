/*==============================================================*/
/* Database name:  PROCESSA                                     */
/* DBMS name:      Friebird15x                                  */
/* Created on:     8/9/2006 08:34:02                            */
/*==============================================================*/



/*  Insert trigger "TBIG_EVENTS" for table "EVENTS"  */
set term ^;

create trigger TBIG_EVENTS for EVENTS
before insert as
begin
  if ((New.PK_EVENTS is null) or (New.PK_EVENTS = 0)) then
    New.PK_EVENTS = Gen_Id(EVENTS, 1);
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'EVENTS', 2, 'EVENTS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_EVENTS" for table "EVENTS"  */
set term ^;

create trigger TBU0_EVENTS for EVENTS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'EVENTS', 3, 'EVENTS', current_timestamp);
end^

set term ;^;

;


/*  Insert trigger "TBIG_MESSAGES" for table "MESSAGES"  */
set term ^;

create trigger TBIG_MESSAGES for MESSAGES
before insert as
begin
  if ((New.PK_MESSAGES is null) or (New.PK_MESSAGES = 0)) then
    New.PK_MESSAGES = Gen_Id(MESSAGES, 1);
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'MESSAGES', 2, 'MESSAGES', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_MESSAGES" for table "MESSAGES"  */
set term ^;

create trigger TBU0_MESSAGES for MESSAGES
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'MESSAGES', 3, 'MESSAGES', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_RECOURCES_X_CONTACTS" for table "RECOURCES_X_CONTACTS"  */
set term ^;

create trigger TBU0_RECOURCES_X_CONTACTS for RECOURCES_X_CONTACTS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'RECOURCES_X_CONTACTS', 3, 'RECOURCES_X_CONTACTS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_TASKS" for table "TASKS"  */
set term ^;

create trigger TBIG_TASKS for TASKS
before insert as
begin
  if ((New.PK_TASKS is null) or (New.PK_TASKS = 0)) then
    New.PK_TASKS = Gen_Id(TASKS, 1);
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TASKS', 2, 'TASKS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_TASKS" for table "TASKS"  */
set term ^;

create trigger TBU0_TASKS for TASKS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TASKS', 3, 'TASKS', current_timestamp);
end^

set term ;^;

