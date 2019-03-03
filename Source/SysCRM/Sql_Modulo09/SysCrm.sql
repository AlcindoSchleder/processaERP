/*==============================================================*/
/* Database name:  PROCESSA                                     */
/* DBMS name:      Friebird15x                                  */
/* Created on:     8/9/2006 08:33:48                            */
/*==============================================================*/


create generator EVENTS;

create generator MESSAGES;

create generator TASKS;

/*==============================================================*/
/* Table: EVENTS                                                */
/*==============================================================*/
create table EVENTS (
PK_EVENTS            VALORI                         not null,
FK_RESOURCES         VALORS,
DTHR_INI             DATA_HORA_DEF                  not null,
DTHR_FIN             DATA_HORA,
DSC_EVENT            DESCRICAO_100RQ                not null,
OBS_EVT              BLOB_TEXTO,
CTA_EVT              VALORS,
FLAG_ALLDAY          FLAG_SIM_NAO                   not null,
DING_PATH            PATH,
FLAG_ALARM           FLAG_SIM_NAO                   not null,
INTRV_ALARM          VALORS,
FLAG_TALARM          FLAG_TIPO_INTERVALO_TEMPO      not null,
DTHR_RPT_EVT         DATA_HORA,
FLAG_TREPEAT         FLAG_TIPO_RPT_EVENTO           not null,
DTHR_RPD_FIM         DATA_HORA,
INTRV_RPT            VALORS,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_EVENTS primary key (PK_EVENTS)
);

grant SELECT,UPDATE,INSERT,DELETE on EVENTS to PUBLIC;

/*==============================================================*/
/* Table: EVENTS_X_CADASTROS                                    */
/*==============================================================*/
create table EVENTS_X_CADASTROS (
FK_CADASTROS         VALORI                         not null,
FK_EVENTS            VALORI                         not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_EVENTS_X_CADASTROS primary key (FK_CADASTROS, FK_EVENTS)
);

grant SELECT,UPDATE,INSERT,DELETE on EVENTS_X_CADASTROS to PUBLIC;

/*==============================================================*/
/* Table: MESSAGES                                              */
/*==============================================================*/
create table MESSAGES (
PK_MESSAGES          VALORI                         not null,
FK_RESOURCES         VALORS,
TITLE_MSG            DESCRICAO_30RQ                 not null,
DTHR_MSG             DATA_HORA_DEF                  not null,
DSC_MSG              BLOB_TEXTO,
FLAG_ATV             FLAG_SIM_NAO                   not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_MESSAGES primary key (PK_MESSAGES)
);

grant SELECT,UPDATE,INSERT,DELETE on MESSAGES to PUBLIC;

/*==============================================================*/
/* Table: RECOURCES_X_CONTACTS                                  */
/*==============================================================*/
create table RECOURCES_X_CONTACTS (
FK_RESOURCES         VALORS                         not null,
FK_CADASTROS         VALORI                         not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_RECOURCES_X_CONTACTS primary key (FK_RESOURCES, FK_CADASTROS)
);

grant SELECT,UPDATE,INSERT,DELETE on RECOURCES_X_CONTACTS to PUBLIC;

/*==============================================================*/
/* Table: TASKS                                                 */
/*==============================================================*/
create table TASKS (
PK_TASKS             VALORI                         not null,
FK_RESOURCES         VALORS,
DSC_TASK             DESCRICAO_100RQ                not null,
DET_TASK             BLOB_TEXTO,
FLAG_CMPL            FLAG_SIM_NAO                   not null,
DTA_CRTK             DATA                           not null,
FLAG_PRTY            VALORS,
CAT_TASK             VALORS,
DTA_CMPL_TASK        DATA,
DTHR_TASK            DATA_HORA_DEF,
OBS_USER             BLOB_TEXTO,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_TASKS primary key (PK_TASKS)
);

grant SELECT,UPDATE,INSERT,DELETE on TASKS to PUBLIC;

alter table EVENTS
   add constraint FK_EVENTS_RESOURCES foreign key (FK_RESOURCES)
      references RESOURCES (PK_RESOURCES)
      on delete cascade;

alter table EVENTS_X_CADASTROS
   add constraint FK_EVENTS_X_CADATROS_EVENTS foreign key (FK_EVENTS)
      references EVENTS (PK_EVENTS)
      on delete cascade
      on update cascade;

alter table MESSAGES
   add constraint FK_MESSAGES_RESOURCES foreign key (FK_RESOURCES)
      references RESOURCES (PK_RESOURCES);

alter table RECOURCES_X_CONTACTS
   add constraint FK_RECOURCES_X_CONTAC_CADASTROS foreign key (FK_CADASTROS)
      references CADASTROS (PK_CADASTROS)
      on delete cascade
      on update cascade;

alter table RECOURCES_X_CONTACTS
   add constraint FK_RECOURCES_X_CONTAC_RESOURCES foreign key (FK_RESOURCES)
      references RESOURCES (PK_RESOURCES)
      on delete cascade
      on update cascade;

alter table TASKS
   add constraint FK_TASKS_RESOURCES foreign key (FK_RESOURCES)
      references RESOURCES (PK_RESOURCES)
      on delete cascade
      on update cascade;

