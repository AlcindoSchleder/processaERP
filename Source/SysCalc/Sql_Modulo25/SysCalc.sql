/*==============================================================*/
/* Database name:  PROCESSA                                     */
/* DBMS name:      InterBase 6.x                                */
/* Created on:     8/3/2004 11:00:25                            */
/*==============================================================*/


create generator PARAMETROS_CALC;

create generator TIPOS_MOTORES;

/*==============================================================*/
/* Table: CALCULOS                                              */
/*==============================================================*/
create table CALCULOS (
FK_EMPRESAS          VALORI                         not null,
PK_CALCULOS          VALORI                         not null,
FK_CADASTROS         VALORI                         not null,
FK_PARAMETROS_CALC   VALORS                         not null,
DSC_CALC             DESCRICAO_50RQ                 not null,
DTA_CALC             DATA_DEF                       not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_CALCULOS primary key (FK_EMPRESAS, PK_CALCULOS)
);

grant all on CALCULOS to public;
/*==============================================================*/
/* Table: MOTORES                                               */
/*==============================================================*/
create table MOTORES (
FK_EMPRESAS          VALORI                         not null,
FK_CALCULOS          VALORI                         not null,
PK_MOTORES           VALORI                         not null,
FK_TIPOS_MOTORES     VALORS                         not null,
FK_TIPOS_MOTORES__VND VALORS                         not null,
DSC_MOT              DESCRICAO_30,
QTD_MOT              VALORS                         not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_MOTORES primary key (FK_EMPRESAS, FK_CALCULOS, PK_MOTORES)
);

grant all on MOTORES to public;
/*==============================================================*/
/* Table: PARAMETROS_CALC                                       */
/*==============================================================*/
create table PARAMETROS_CALC (
PK_PARAMETROS_CALC   VALORS                         not null,
DSC_PARAM            DESCRICAO_50RQ                 not null,
PARAM_NHF            VALORS                         not null,
PARAM_NHH            VALORS                         not null,
PARAM_NDM            VALORS                         not null,
PARAM_NMA            VALORS                         not null,
CUSTO_NHF            NUMERO_PEQUENO_4CD             not null,
CUSTO_NHH            NUMERO_PEQUENO_4CD,
PERC_TROCA           NUMERO_PERCENTUAL,
KWH_MOT              NUMERO_PEQUENO_4CD,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PARAMETROS_CALC primary key (PK_PARAMETROS_CALC)
);

grant all on PARAMETROS_CALC to public;
/*==============================================================*/
/* Table: TIPOS_MOTORES                                         */
/*==============================================================*/
create table TIPOS_MOTORES (
PK_TIPOS_MOTORES     VALORS                         not null,
DSC_MOT              DESCRICAO_50RQ                 not null,
QTD_POLO             VALORS                         not null,
CV_MOT               NUMERO_PEQUENO                 not null,
FLAG_VND             FLAG_SIM_NAO                   not null,
RPM_MOT              VALORI,
PRECO_MOT            NUMERO_PEQUENO,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_TIPOS_MOTORES primary key (PK_TIPOS_MOTORES)
);

grant all on TIPOS_MOTORES to public;

commit work;
execute procedure apply_indexnames;
commit work;
alter table CALCULOS
   add constraint FK_CALCULOS_CADASTROS foreign key (FK_CADASTROS)
      references CADASTROS (PK_CADASTROS)
      on delete cascade
      on update cascade;

alter table CALCULOS
   add constraint FK_CALCULOS_EMPRESAS foreign key (FK_EMPRESAS)
      references EMPRESAS (PK_EMPRESAS)
      on delete cascade
      on update cascade;

alter table CALCULOS
   add constraint FK_CALCULOS_PARAMETROS_CA foreign key (FK_PARAMETROS_CALC)
      references PARAMETROS_CALC (PK_PARAMETROS_CALC)
      on delete cascade
      on update cascade;

alter table MOTORES
   add constraint FK_MOTORES_CALCULOS foreign key (FK_EMPRESAS, FK_CALCULOS)
      references CALCULOS (FK_EMPRESAS, PK_CALCULOS)
      on delete cascade
      on update cascade;

alter table MOTORES
   add constraint FK_MOTORES_TIPOS_MOTORES foreign key (FK_TIPOS_MOTORES)
      references TIPOS_MOTORES (PK_TIPOS_MOTORES);

alter table MOTORES
   add constraint FK_MOTORES_TIPOS_MOTORES__VND foreign key (FK_TIPOS_MOTORES__VND)
      references TIPOS_MOTORES (PK_TIPOS_MOTORES);

