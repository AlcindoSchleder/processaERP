/*==============================================================*/
/* Database name:  PROCESSA                                     */
/* DBMS name:      Friebird15x                                  */
/* Created on:     8/9/2006 08:09:12                            */
/*==============================================================*/


create generator TIPO_ACABAMENTOS;

create generator TIPO_COMPONENTES;

/*==============================================================*/
/* Table: ACABAMENTOS                                           */
/*==============================================================*/
create table ACABAMENTOS (
FK_PRODUTOS          VALORI                         not null,
FK_COMPONENTES       VALORS                         not null,
FK_TIPO_ACABAMENTOS  VALORS                         not null,
FLAG_TACBM           FLAG_OPCIONAL                  not null,
QTD_PDR              NUMERO_PEQUENO_4CD             not null,
QTD_PERS             NUMERO_PEQUENO_4CD,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_ACABAMENTOS primary key (FK_PRODUTOS, FK_COMPONENTES, FK_TIPO_ACABAMENTOS)
);

grant SELECT,UPDATE,INSERT,DELETE on ACABAMENTOS to PUBLIC;

/*==============================================================*/
/* Table: ACABAMENTO_PRECOS                                     */
/*==============================================================*/
create table ACABAMENTO_PRECOS (
FK_EMPRESAS          VALORI                         not null,
FK_PRODUTOS          VALORI                         not null,
FK_TIPO_ACABAMENTOS  VALORS                         not null,
FK_TIPO_REFERENCIAS  VALORS                         not null,
FK_TABELA_PRECOS     VALORS                         not null,
PRE_VDA              NUMERO_MEDIO_4CD               not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_ACABAMENTO_PRECOS primary key (FK_EMPRESAS, FK_PRODUTOS, FK_TIPO_ACABAMENTOS, FK_TIPO_REFERENCIAS, FK_TABELA_PRECOS)
);

grant DELETE,INSERT,UPDATE,SELECT on ACABAMENTO_PRECOS to PUBLIC;

/*==============================================================*/
/* Table: COMPONENTES                                           */
/*==============================================================*/
create table COMPONENTES (
FK_PRODUTOS          VALORI                         not null,
FK_TIPO_COMPONENTES  VALORS                         not null,
QTD_COMP             NUMERO_PEQUENO_4CD,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_COMPONENTES primary key (FK_PRODUTOS, FK_TIPO_COMPONENTES)
);

grant SELECT,UPDATE,INSERT,DELETE on COMPONENTES to PUBLIC;

/*==============================================================*/
/* Table: REFERENCIAS                                           */
/*==============================================================*/
create table REFERENCIAS (
FK_EMPRESAS          VALORI                         not null,
FK_PRODUTOS          VALORI                         not null,
FK_COMPONENTES       VALORS                         not null,
FK_ACABAMENTOS       VALORS                         not null,
FK_TIPO_REFERENCIAS  VALORS                         not null,
FLAG_ATIVO           FLAG_SIM_NAO                   not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_REFERENCIAS primary key (FK_EMPRESAS, FK_PRODUTOS, FK_COMPONENTES, FK_ACABAMENTOS, FK_TIPO_REFERENCIAS)
);

grant DELETE,INSERT,UPDATE,SELECT on REFERENCIAS to PUBLIC;

/*==============================================================*/
/* Table: TIPO_ACABAMENTOS                                      */
/*==============================================================*/
create table TIPO_ACABAMENTOS (
PK_TIPO_ACABAMENTOS  VALORS                         not null,
DSC_ACABM            DESCRICAO_30RQ                 not null,
FLAG_TDSC            FLAG_TIPO_DESCR_INSUMO         not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_TIPO_ACABAMENTOS primary key (PK_TIPO_ACABAMENTOS)
);

grant SELECT,UPDATE,INSERT,DELETE on TIPO_ACABAMENTOS to PUBLIC;

/*==============================================================*/
/* Table: TIPO_COMPONENTES                                      */
/*==============================================================*/
create table TIPO_COMPONENTES (
PK_TIPO_COMPONENTES  VALORS                         not null,
DSC_TCOMP            DESCRICAO_30RQ                 not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_TIPO_COMPONENTES primary key (PK_TIPO_COMPONENTES)
);

grant SELECT,UPDATE,INSERT,DELETE on TIPO_COMPONENTES to PUBLIC;

/*==============================================================*/
/* Table: TIPO_REFERENCIAS                                      */
/*==============================================================*/
create table TIPO_REFERENCIAS (
FK_TIPO_ACABAMENTOS  VALORS                         not null,
PK_TIPO_REFERENCIAS  VALORS                         not null,
DSC_REF              DESCRICAO_30RQ                 not null,
FAIXA_CUST_INI       NUMERO_PEQUENO_4CD,
FAIXA_CUST_FIN       NUMERO_PEQUENO_4CD,
FLAG_TINS            FLAG_TIPO_ACABAMENTO           not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_TIPO_REFERENCIAS primary key (FK_TIPO_ACABAMENTOS, PK_TIPO_REFERENCIAS)
);

grant SELECT,UPDATE,INSERT,DELETE on TIPO_REFERENCIAS to PUBLIC;

/*==============================================================*/
/* Table: TP_REF_PRODUTOS                                       */
/*==============================================================*/
create table TP_REF_PRODUTOS (
FK_EMPRESAS          VALORI                         not null,
FK_PRODUTOS          VALORI                         not null,
FK_TIPO_ACABAMENTOS  VALORS                         not null,
FK_TIPO_REFERENCIAS  VALORS                         not null,
PRE_SJST             NUMERO_MEDIO_4CD,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_TP_REF_PRODUTOS primary key (FK_EMPRESAS, FK_PRODUTOS, FK_TIPO_ACABAMENTOS, FK_TIPO_REFERENCIAS)
);

grant DELETE,INSERT,UPDATE,SELECT on TP_REF_PRODUTOS to PUBLIC;

alter table ACABAMENTOS
   add constraint FK_ACABAMENTOS_COMPONENTES foreign key (FK_PRODUTOS, FK_COMPONENTES)
      references COMPONENTES (FK_PRODUTOS, FK_TIPO_COMPONENTES)
      on delete cascade
      on update cascade;

alter table ACABAMENTOS
   add constraint FK_ACABAMENTOS_TIPO_ACABAMEN foreign key (FK_TIPO_ACABAMENTOS)
      references TIPO_ACABAMENTOS (PK_TIPO_ACABAMENTOS);

alter table ACABAMENTO_PRECOS
   add constraint FK_ACABAMENTO_PREC_TP_REF_PRODU foreign key (FK_EMPRESAS, FK_PRODUTOS, FK_TIPO_ACABAMENTOS, FK_TIPO_REFERENCIAS)
      references TP_REF_PRODUTOS (FK_EMPRESAS, FK_PRODUTOS, FK_TIPO_ACABAMENTOS, FK_TIPO_REFERENCIAS)
      on delete cascade
      on update cascade;

alter table ACABAMENTO_PRECOS
   add constraint FK_ACABAMENTO_PR_TABELA_PRECOS foreign key (FK_TABELA_PRECOS)
      references TABELA_PRECOS (PK_TABELA_PRECOS);

alter table COMPONENTES
   add constraint FK_COMPONENTES_PRODUTOS foreign key (FK_PRODUTOS)
      references PRODUTOS (PK_PRODUTOS)
      on delete cascade
      on update cascade;

alter table COMPONENTES
   add constraint FK_COMPONENTES_TIPO_COMPONEN foreign key (FK_TIPO_COMPONENTES)
      references TIPO_COMPONENTES (PK_TIPO_COMPONENTES);

alter table REFERENCIAS
   add constraint FK_REFERENCIAS_ACABAMENTOS foreign key (FK_PRODUTOS, FK_COMPONENTES, FK_ACABAMENTOS)
      references ACABAMENTOS (FK_PRODUTOS, FK_COMPONENTES, FK_TIPO_ACABAMENTOS)
      on delete cascade
      on update cascade;

alter table REFERENCIAS
   add constraint FK_REFERENCIAS_TIPO_REFERENC foreign key (FK_ACABAMENTOS, FK_TIPO_REFERENCIAS)
      references TIPO_REFERENCIAS (FK_TIPO_ACABAMENTOS, PK_TIPO_REFERENCIAS);

alter table TIPO_REFERENCIAS
   add constraint FK_TIPO_REFERENC_TIPO_ACABAMEN foreign key (FK_TIPO_ACABAMENTOS)
      references TIPO_ACABAMENTOS (PK_TIPO_ACABAMENTOS);

alter table TP_REF_PRODUTOS
   add constraint FK_TP_REF_PRODUTOS_EMPRESAS foreign key (FK_EMPRESAS)
      references EMPRESAS (PK_EMPRESAS);

alter table TP_REF_PRODUTOS
   add constraint FK_TP_REF_PRODUTOS_PRODUTOS foreign key (FK_PRODUTOS)
      references PRODUTOS (PK_PRODUTOS)
      on delete cascade
      on update cascade;

alter table TP_REF_PRODUTOS
   add constraint FK_TP_REF_PRODUT_TIPO_REFERENC foreign key (FK_TIPO_ACABAMENTOS, FK_TIPO_REFERENCIAS)
      references TIPO_REFERENCIAS (FK_TIPO_ACABAMENTOS, PK_TIPO_REFERENCIAS)
      on delete cascade
      on update cascade;

