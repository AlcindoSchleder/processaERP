/*==============================================================*/
/* Database name:  PROCESSA                                     */
/* DBMS name:      Friebird15x                                  */
/* Created on:     8/9/2006 08:30:05                            */
/*==============================================================*/


create generator CARGAS_REGIOES;

create generator ORDENS_OPERACOES;

create generator ORDENS_TIPO_STATUS;

create generator TMP_HIERARQUIA_REFERENCIA;

/*==============================================================*/
/* Table: CARGAS_PRODUCAO                                       */
/*==============================================================*/
create table CARGAS_PRODUCAO (
FK_EMPRESAS          VALORI                         not null,
PK_CARGAS_PRODUCAO   VALORI                         not null,
DSC_CRG              DESCRICAO_50,
REF_CRG              DESCRICAO_10                   not null,
DTA_CRG              DATA_DEF                       not null,
FLAG_ATIVO           FLAG_SIM_NAO                   not null,
DTA_LIM              DATA,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_CARGAS_PRODUCAO primary key (FK_EMPRESAS, PK_CARGAS_PRODUCAO)
);

/*==============================================================*/
/* Index: IDX_CARGAS_PRODUCAO001                                */
/*==============================================================*/
create unique asc index IDX_CARGAS_PRODUCAO001 on CARGAS_PRODUCAO (
FK_EMPRESAS,
REF_CRG
);

grant SELECT,UPDATE,INSERT,DELETE on CARGAS_PRODUCAO to PUBLIC;

/*==============================================================*/
/* Table: CARGAS_REGIOES                                        */
/*==============================================================*/
create table CARGAS_REGIOES (
PK_CARGAS_REGIOES    VALORS                         not null,
REF_REG              DESCRICAO_10                   not null,
DSC_REG              DESCRICAO_30RQ                 not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_CARGAS_REGIOES primary key (PK_CARGAS_REGIOES)
);

alter table MUNICIPIOS
   add constraint FK_MUNICIPIOS_CARGAS_REGIOES foreign key (PK_CARGAS_REGIOES)
      references CARGAS_REGIOES (PK_CARGAS_REGIOES);

/*==============================================================*/
/* Index: IDX_CARGAS_REGIOES001                                 */
/*==============================================================*/
create unique asc index IDX_CARGAS_REGIOES001 on CARGAS_REGIOES (
REF_REG
);

grant SELECT,UPDATE,INSERT,DELETE on CARGAS_REGIOES to PUBLIC;

/*==============================================================*/
/* Table: MOD_PCP_KEYS                                          */
/*==============================================================*/
create table MOD_PCP_KEYS (
FK_EMPRESAS          VALORI                         not null,
KC_CARGAS_PRODUCAO   VALORI,
constraint PK_MOD_PCP_KEYS primary key (FK_EMPRESAS)
);

grant DELETE,INSERT,UPDATE,SELECT on MOD_PCP_KEYS to PUBLIC;

/*==============================================================*/
/* Table: ORDENS_ALOCACAO_FERRAMENTAS                           */
/*==============================================================*/
create table ORDENS_ALOCACAO_FERRAMENTAS (
FK_ORDENS_OPERACOES  VALORI                         not null,
FK_PRODUTOS_COMPRAS  VALORI                         not null,
FK_PRODUTOS_MAQUINAS VALORS                         not null,
DTA_ALOC_FIN         DATA_HORA,
DTA_ALOC_INI         DATA_HORA_DEF,
DTHR_ALT             DATA_HORA,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
constraint PK_ORDENS_ALOCACAO_FERRAMENTAS primary key (FK_ORDENS_OPERACOES, FK_PRODUTOS_MAQUINAS, FK_PRODUTOS_COMPRAS)
);

grant SELECT,UPDATE,INSERT,DELETE on ORDENS_ALOCACAO_FERRAMENTAS to PUBLIC;

/*==============================================================*/
/* Table: ORDENS_ALOCACAO_MAQUINAS                              */
/*==============================================================*/
create table ORDENS_ALOCACAO_MAQUINAS (
FK_ORDENS_OPERACOES  VALORI                         not null,
FK_PRODUTOS_MAQUINAS VALORS                         not null,
DTHR_INI             DATA_HORA_DEF,
DTHR_ENCR            DATA_HORA,
FLAG_ATIVA           FLAG_SIM_NAO                   not null,
FLAG_MOD             FLAG_SIM_NAO                   not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_ORDENS_ALOCACAO_MAQUINAS primary key (FK_ORDENS_OPERACOES, FK_PRODUTOS_MAQUINAS)
);

grant DELETE,INSERT,UPDATE,SELECT on ORDENS_ALOCACAO_MAQUINAS to PUBLIC;

/*==============================================================*/
/* Table: ORDENS_HISTORICOS                                     */
/*==============================================================*/
create table ORDENS_HISTORICOS (
PK_ORDENS_HISTORICOS VALORI                         not null,
FK_EMPRESAS          VALORI                         not null,
FK_TIPO_DOCUMENTOS   VALORS                         not null,
FK_ORDENS_PRODUCAO   VALORI                         not null,
FK_TIPO_ORDENS_PRODUCAO VALORS                         not null,
FK_PRODUTOS_PECAS    VALORI                         not null,
DTHR_HIS             DATA_HORA_DEF                  not null,
QTD_HIST             NUMERO_MEDIO_4CD               not null,
FLAG_EMP             FLAG_SIM_NAO                   not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_ORDENS_HISTORICOS primary key (PK_ORDENS_HISTORICOS)
);

grant SELECT,UPDATE,INSERT,DELETE on ORDENS_HISTORICOS to PUBLIC;

/*==============================================================*/
/* Table: ORDENS_OPERACOES                                      */
/*==============================================================*/
create table ORDENS_OPERACOES (
PK_ORDENS_OPERACOES  VALORI                         not null,
FK_EMPRESAS          VALORI                         not null,
FK_TIPO_DOCUMENTOS   VALORS                         not null,
FK_ORDENS_PRODUCAO   VALORI                         not null,
FK_PRODUTOS_PECAS    VALORI                         not null,
FK_FASES_PRODUCAO    VALORS                         not null,
FK_OPERACOES         VALORS                         not null,
DTHR_INI             DATA_HORA,
DTHR_FIN             DATA_HORA,
FLAG_MOT             FLAG_MOTIVO_OPERACAO           not null,
QTD_OPE              NUMERO_PEQUENO_4CD,
COD_AUT              VALORI,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_ORDENS_OPERACOES primary key (PK_ORDENS_OPERACOES)
);

/*==============================================================*/
/* Index: IDX_ORDENS_OPERACOES_01                               */
/*==============================================================*/
create unique asc index IDX_ORDENS_OPERACOES_01 on ORDENS_OPERACOES (
FK_PRODUTOS_PECAS,
FK_FASES_PRODUCAO,
FK_OPERACOES
);

grant DELETE,INSERT,UPDATE,SELECT on ORDENS_OPERACOES to PUBLIC;

/*==============================================================*/
/* Table: ORDENS_OPER_TERCERIZADA                               */
/*==============================================================*/
create table ORDENS_OPER_TERCERIZADA (
FK_ORDENS_OPERACOES  VALORI                         not null,
FK_CADASTROS         VALORI                         not null,
FK_PRODUTOS_SERVICOS VALORS                         not null,
DTA_INI              DATA_DEF,
DTA_PREV_ENTR        DATA,
QTD_SRV              NUMERO_PEQUENO_4CD,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_ORDENS_OPER_TERCERIZADA primary key (FK_ORDENS_OPERACOES, FK_CADASTROS, FK_PRODUTOS_SERVICOS)
);

grant UPDATE,SELECT,INSERT,DELETE on ORDENS_OPER_TERCERIZADA to PUBLIC;

/*==============================================================*/
/* Table: ORDENS_PECAS                                          */
/*==============================================================*/
create table ORDENS_PECAS (
FK_EMPRESAS          VALORI                         not null,
FK_TIPO_DOCUMENTOS   VALORS                         not null,
FK_ORDENS_PRODUCAO   VALORI                         not null,
FK_PRODUTOS_PECAS    VALORI                         not null,
QTD_SUG              NUMERO_PEQUENO_4CD,
QTD_FABR             NUMERO_PEQUENO_4CD,
QTD_ESTQ             NUMERO_PEQUENO_4CD,
DTHR_INI             DATA_HORA,
DTHR_ENCR            DATA_HORA,
SEQ_PROD             VALORS,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_ORDENS_PECAS primary key (FK_EMPRESAS, FK_TIPO_DOCUMENTOS, FK_ORDENS_PRODUCAO, FK_PRODUTOS_PECAS)
);

grant DELETE,INSERT,UPDATE,SELECT on ORDENS_PECAS to PUBLIC;

/*==============================================================*/
/* Table: ORDENS_PEDIDOS                                        */
/*==============================================================*/
create table ORDENS_PEDIDOS (
TIP_FK_EMPRESAS      VALORI                         not null,
FK_EMPRESAS          VALORI                         not null,
FK_TIPO_DOCUMENTOS   VALORS                         not null,
FK_TIPO_ORDENS_PRODUCAO VALORS                         not null,
PK_ORDENS_PRODUCAO   VALORI                         not null,
FK_PEDIDOS           VALORI                         not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_ORDENS_PEDIDOS primary key (TIP_FK_EMPRESAS, FK_EMPRESAS, FK_TIPO_DOCUMENTOS, FK_TIPO_ORDENS_PRODUCAO, PK_ORDENS_PRODUCAO, FK_PEDIDOS)
);

grant SELECT,UPDATE,INSERT,DELETE on ORDENS_PEDIDOS to PUBLIC;

/*==============================================================*/
/* Table: ORDENS_PRODUCAO                                       */
/*==============================================================*/
create table ORDENS_PRODUCAO (
FK_EMPRESAS          VALORI                         not null,
FK_TIPO_DOCUMENTOS   VALORS                         not null,
PK_ORDENS_PRODUCAO   VALORI                         not null,
FK_ORDENS_TIPO_STATUS VALORS,
NUM_OPE              VALORI,
MNM_OP               CODIGO_GER_REFERENCIA          not null,
QTD_PEC              NUMERO_PEQUENO_4CD,
DTA_OP               DATA_DEF                       not null,
DTA_ALOC_INI         DATA_HORA,
DTA_ALOC_FIN         DATA_HORA,
OBS_OP               BLOB_TEXTO,
DTHR_INI             DATA_HORA_DEF,
DTHR_ENCR            DATA_HORA_DEF,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_ORDENS_PRODUCAO primary key (FK_EMPRESAS, FK_TIPO_DOCUMENTOS, PK_ORDENS_PRODUCAO)
);

/*==============================================================*/
/* Index: IDX_ORDENS_PRODUCAO_01                                */
/*==============================================================*/
create asc index IDX_ORDENS_PRODUCAO_01 on ORDENS_PRODUCAO (
FK_EMPRESAS,
NUM_OPE
);

grant DELETE,INSERT,UPDATE,SELECT on ORDENS_PRODUCAO to PUBLIC;

/*==============================================================*/
/* Table: ORDENS_TIPO_STATUS                                    */
/*==============================================================*/
create table ORDENS_TIPO_STATUS (
PK_ORDENS_TIPO_STATUS VALORS                         not null,
FK_TIPO_MOVIM_ESTQ   VALORS,
DSC_STT              DESCRICAO_30RQ                 not null,
FLAG_STATUS          FLAG_STATUS_OP                 not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_ORDENS_TIPO_STATUS primary key (PK_ORDENS_TIPO_STATUS)
);

grant SELECT,UPDATE,INSERT,DELETE on ORDENS_TIPO_STATUS to PUBLIC;

/*==============================================================*/
/* Table: TMP_HIERARQUIA_REFERENCIA                             */
/*==============================================================*/
create table TMP_HIERARQUIA_REFERENCIA (
PK_TMP_HIERARQUIA_REFERENCIA VALORI                         not null,
HLEVEL               VALORI                         not null,
QTD                  NUMERO_GRANDE_6CD              not null,
constraint PK_TMP_HIERARQUIA_REFERENCIA primary key (PK_TMP_HIERARQUIA_REFERENCIA)
);

grant DELETE,INSERT,UPDATE,SELECT on TMP_HIERARQUIA_REFERENCIA to PUBLIC;

alter table CARGAS_PRODUCAO
   add constraint FK_CARGAS_PRODUC_EMPRESAS foreign key (FK_EMPRESAS)
      references EMPRESAS (PK_EMPRESAS);

alter table MOD_PCP_KEYS
   add constraint FK_KEY_CONTROL_PCP_EMPRESAS foreign key (FK_EMPRESAS)
      references EMPRESAS (PK_EMPRESAS);

alter table ORDENS_ALOCACAO_FERRAMENTAS
   add constraint FK_ORDENS_ALOCAC_ORDENS_ALOCAC foreign key (FK_ORDENS_OPERACOES, FK_PRODUTOS_MAQUINAS)
      references ORDENS_ALOCACAO_MAQUINAS (FK_ORDENS_OPERACOES, FK_PRODUTOS_MAQUINAS);

alter table ORDENS_ALOCACAO_MAQUINAS
   add constraint FK_ORDENS_ALOCAC_PRODUTOS_MAQU foreign key (FK_PRODUTOS_MAQUINAS)
      references PRODUTOS_MAQUINAS (FK_PRODUTOS);

alter table ORDENS_ALOCACAO_MAQUINAS
   add constraint FK_ORDENS_ALOCAC_ORDENS_OPERAC foreign key (FK_ORDENS_OPERACOES)
      references ORDENS_OPERACOES (PK_ORDENS_OPERACOES);

alter table ORDENS_HISTORICOS
   add constraint FK_ORDENS_HISTOR_ORDENS_PRODUC foreign key (FK_EMPRESAS, FK_TIPO_DOCUMENTOS, FK_ORDENS_PRODUCAO)
      references ORDENS_PRODUCAO (FK_EMPRESAS, FK_TIPO_DOCUMENTOS, PK_ORDENS_PRODUCAO);

alter table ORDENS_OPERACOES
   add constraint FK_ORDENS_OPERAC_OPERACOES foreign key (FK_FASES_PRODUCAO, FK_PRODUTOS_PECAS, FK_OPERACOES)
      references OPERACOES (FK_FASES_PRODUCAO, FK_PRODUTOS_PECAS, PK_OPERACOES);

alter table ORDENS_OPERACOES
   add constraint FK_ORDENS_OPERAC_ORDENS_PRODUC foreign key (FK_EMPRESAS, FK_TIPO_DOCUMENTOS, FK_ORDENS_PRODUCAO)
      references ORDENS_PRODUCAO (FK_EMPRESAS, FK_TIPO_DOCUMENTOS, PK_ORDENS_PRODUCAO);

alter table ORDENS_OPER_TERCERIZADA
   add constraint FK_ORDENS_OPER_T_ORDENS_OPERAC foreign key (FK_ORDENS_OPERACOES)
      references ORDENS_OPERACOES (PK_ORDENS_OPERACOES);

alter table ORDENS_PECAS
   add constraint FK_ORDENS_PECAS_ORDENS_PRODUC foreign key (FK_EMPRESAS, FK_TIPO_DOCUMENTOS, FK_ORDENS_PRODUCAO)
      references ORDENS_PRODUCAO (FK_EMPRESAS, FK_TIPO_DOCUMENTOS, PK_ORDENS_PRODUCAO);

alter table ORDENS_PEDIDOS
   add constraint FK_ORDENS_PEDIDO_ORDENS_PRODUC foreign key (FK_EMPRESAS, FK_TIPO_DOCUMENTOS, PK_ORDENS_PRODUCAO)
      references ORDENS_PRODUCAO (FK_EMPRESAS, FK_TIPO_DOCUMENTOS, PK_ORDENS_PRODUCAO);

alter table ORDENS_PRODUCAO
   add constraint FK_ORDENS_PRODUC_EMPRESAS foreign key (FK_EMPRESAS)
      references EMPRESAS (PK_EMPRESAS);

alter table ORDENS_PRODUCAO
   add constraint FK_ORDENS_PRODUC_ORDENS_TIPO_S foreign key (FK_ORDENS_TIPO_STATUS)
      references ORDENS_TIPO_STATUS (PK_ORDENS_TIPO_STATUS);

alter table ORDENS_PRODUCAO
   add constraint FK_ORDENS_PRODUC_TIPO_DOCUMENT foreign key (FK_TIPO_DOCUMENTOS)
      references TIPO_DOCUMENTOS (PK_TIPO_DOCUMENTOS);

