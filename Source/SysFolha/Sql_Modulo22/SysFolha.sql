/*==============================================================*/
/* Database name:  PROCESSA                                     */
/* DBMS name:      InterBase 6.x                                */
/* Created on:     20/04/2006 11:06:52                          */
/*==============================================================*/


create generator TIPO_CARGOS;

create generator TIPO_TURNOS;

/*==============================================================*/
/* Table: TIPO_CARGOS                                           */
/*==============================================================*/
create table TIPO_CARGOS (
PK_TIPO_CARGOS       VALORS                         not null,
DSC_CRG              DESCRICAO_30RQ                 not null,
FLAG_CRG             FLAG_CARGO                     not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_TIPO_CARGOS primary key (PK_TIPO_CARGOS)
);

grant all on TIPO_CARGOS to public;

alter table FUNCIONARIOS
   add constraint FK_FUNCIONARIOS_TIPO_CARGOS foreign key (FK_TIPO_CARGOS)
      references TIPO_CARGOS (PK_TIPO_CARGOS);
/*==============================================================*/
/* Table: TIPO_TURNOS                                           */
/*==============================================================*/
create table TIPO_TURNOS (
PK_TIPO_TURNOS       VALORS                         not null,
DSC_TRN              DESCRICAO_50RQ                 not null,
HOR_INI              HORA                           not null,
HOR_FIN              HORA                           not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_TIPO_TURNOS primary key (PK_TIPO_TURNOS)
);

/*==============================================================*/
/* Table: VINCULO_CC_DP_CR                                      */
/*==============================================================*/
create table VINCULO_CC_DP_CR (
FK_CENTRO_CUSTOS     VALORS                         not null,
FK_DEPARTAMENTOS     VALORS                         not null,
FK_CARGOS            VALORS                         not null,
FLAG_EMPR            FLAG_SIM_NAO                   not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_VINCULO_CC_DP_CR primary key (FK_CENTRO_CUSTOS, FK_DEPARTAMENTOS, FK_CARGOS)
);

grant SELECT,UPDATE,INSERT,DELETE on VINCULO_CC_DP_CR to PUBLIC;

alter table VINCULO_CC_DP_CR
   add constraint FK_VINCULO_CC_DP_TIPO_CARGOS foreign key (FK_CARGOS)
      references TIPO_CARGOS (PK_TIPO_CARGOS);

alter table VINCULO_CC_DP_CR
   add constraint FK_VINCULO_CC_DP_CENTRO_CUSTOS foreign key (FK_CENTRO_CUSTOS)
      references CENTRO_CUSTOS (PK_CENTRO_CUSTOS);

alter table VINCULO_CC_DP_CR
   add constraint FK_VINCULO_CC_DP_DEPARTAMENTOS foreign key (FK_DEPARTAMENTOS)
      references DEPARTAMENTOS (PK_DEPARTAMENTOS);

