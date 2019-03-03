/*==============================================================*/
/* Database name:  PROCESSA                                     */
/* DBMS name:      Friebird15x                                  */
/* Created on:     9/9/2006 15:30:09                            */
/*==============================================================*/


/*==============================================================*/
/* Table: COTACOES                                              */
/*==============================================================*/
create table COTACOES (
FK_EMPRESAS          VALORI                         not null,
PK_COTACOES          VALORI                         not null,
DSC_TCOT             DESCRICAO_30RQ                 not null,
DTA_COT              DATA_DEF                       not null,
DTA_VAL              DATA                           not null,
DTA_ENC              VALORI,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_COTACOES primary key (FK_EMPRESAS, PK_COTACOES)
);

grant SELECT,UPDATE,INSERT,DELETE on COTACOES to PUBLIC;

/*==============================================================*/
/* Table: COTACOES_FORNECEDOR                                   */
/*==============================================================*/
create table COTACOES_FORNECEDOR (
FK_EMPRESAS          VALORI                         not null,
FK_COTACOES          VALORI                         not null,
FK_INSUMOS           VALORI                         not null,
FK_VW_FORNECEDORES   VALORI                         not null,
CUST_TAB             NUMERO_PEQUENO_4CD,
VLR_ACDS             NUMERO_PEQUENO_4CD,
CUST_LIQ             NUMERO_PEQUENO_4CD,
FLAG_SEL             FLAG_SIM_NAO                   not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_COTACOES_FORNECEDOR primary key (FK_EMPRESAS, FK_COTACOES, FK_INSUMOS, FK_VW_FORNECEDORES)
);

grant SELECT,INSERT,UPDATE,DELETE on COTACOES_FORNECEDOR to PUBLIC;

/*==============================================================*/
/* Table: COTACOES_MRP                                          */
/*==============================================================*/
create table COTACOES_MRP (
FK_EMPRESAS          VALORI                         not null,
FK_INSUMOS           VALORI                         not null,
DTA_GER              DATA_DEF                       not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_COTACOES_MRP primary key (FK_EMPRESAS, FK_INSUMOS)
);

grant SELECT,UPDATE,INSERT,DELETE on COTACOES_MRP to PUBLIC;

/*==============================================================*/
/* Table: COTACOES_PRODUTOS                                     */
/*==============================================================*/
create table COTACOES_PRODUTOS (
FK_EMPRESAS          VALORI                         not null,
FK_COTACOES          VALORI                         not null,
FK_INSUMOS           VALORI                         not null,
QTD_PED              NUMERO_PEQUENO_4CD             not null,
CUST_UCMP            NUMERO_PEQUENO_4CD,
CUST_FORN            NUMERO_PEQUENO_4CD,
CUST_IMPST           NUMERO_PEQUENO_4CD,
CUST_REAL            NUMERO_PEQUENO_4CD,
CUST_MED             NUMERO_PEQUENO_4CD,
CUST_FINAL           VALORS,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_COTACOES_PRODUTOS primary key (FK_COTACOES, FK_EMPRESAS, FK_INSUMOS)
);

grant SELECT,UPDATE,INSERT,DELETE on COTACOES_PRODUTOS to PUBLIC;

/*==============================================================*/
/* Table: MOD_BUY_KEYS                                          */
/*==============================================================*/
create table MOD_BUY_KEYS (
FK_EMPRESAS          VALORI                         not null,
KC_COTACOES          VALORI,
constraint PK_MOD_BUY_KEYS primary key (FK_EMPRESAS)
);

grant SELECT,UPDATE,INSERT,DELETE on MOD_BUY_KEYS to PUBLIC;

alter table COTACOES
   add constraint FK_COTACOES_EMPRESAS foreign key (FK_EMPRESAS)
      references EMPRESAS (PK_EMPRESAS);

alter table COTACOES_FORNECEDOR
   add constraint FK_COTACOES_FORN_COTACOES_PROD foreign key (FK_COTACOES, FK_EMPRESAS, FK_INSUMOS)
      references COTACOES_PRODUTOS (FK_COTACOES, FK_EMPRESAS, FK_INSUMOS)
      on delete cascade;

alter table COTACOES_MRP
   add constraint FK_COTACOES_MRP_EMPRESAS foreign key (FK_EMPRESAS)
      references EMPRESAS (PK_EMPRESAS);

alter table COTACOES_PRODUTOS
   add constraint FK_COTACOES_PROD_COTACOES foreign key (FK_EMPRESAS, FK_COTACOES)
      references COTACOES (FK_EMPRESAS, PK_COTACOES)
      on delete cascade;

alter table MOD_BUY_KEYS
   add constraint FK_MOD_BUY_KEYS_EMPRESAS foreign key (FK_EMPRESAS)
      references EMPRESAS (PK_EMPRESAS);

