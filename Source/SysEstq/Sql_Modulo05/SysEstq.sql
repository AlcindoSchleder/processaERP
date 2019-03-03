/*==============================================================*/
/* Database name:  PROCESSA                                     */
/* DBMS name:      Friebird15x                                  */
/* Created on:     11/9/2006 10:47:03                           */
/*==============================================================*/


create generator ALMOXARIFADOS;

create generator LINHAS;

create generator PRODUTOS;

create generator PRODUTOS_GRUPOS;

create generator SIMILARES;

create generator TABELA_PRECOS;

create generator TIPO_MOVIM_ESTQ;

create generator TIPO_PRODUTOS;

create generator TIPO_SITUACAO_ESTOQUES;

create generator UNIDADES;

/*==============================================================*/
/* Table: ALMOXARIFADOS                                         */
/*==============================================================*/
create table ALMOXARIFADOS (
PK_ALMOXARIFADOS     VALORS                         not null,
DSC_ALMX             DESCRICAO_30RQ                 not null,
LOCAL_AMLX           BLOB_TEXTO,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_ALMOXARIFADOS primary key (PK_ALMOXARIFADOS)
);

grant SELECT,UPDATE,INSERT,DELETE on ALMOXARIFADOS to PUBLIC;

/*==============================================================*/
/* Table: COMPOSICOES                                           */
/*==============================================================*/
create table COMPOSICOES (
FK_PRODUTOS          VALORI                         not null,
FK_TIPO_COMPOSICOES  VALORI                         not null,
PK_COMPOSICOES       VALORS                         not null,
FK_INSUMOS           VALORI                         not null,
QTD_PROD             NUMERO_PEQUENO_4CD             not null,
FLAG_TCOMP           FLAG_SIM_NAO                   not null,
SEQ_COMP             VALORS                         not null,
FLAG_DEF             FLAG_SIM_NAO                   not null,
MED_DEF              NUMERO_PEQUENO_4CD             not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_COMPOSICOES primary key (FK_PRODUTOS, FK_TIPO_COMPOSICOES, PK_COMPOSICOES)
);

grant SELECT,UPDATE,INSERT,DELETE on COMPOSICOES to PUBLIC;

/*==============================================================*/
/* Table: LINHAS                                                */
/*==============================================================*/
create table LINHAS (
PK_LINHAS            VALORS                         not null,
DSC_LIN              DESCRICAO_30RQ                 not null,
COM_LIN              NUMERO_INDICE,
FONT_LIN             DESCRICAO_50,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
constraint PK_LINHAS primary key (PK_LINHAS)
);

grant DELETE,INSERT,UPDATE,SELECT on LINHAS to PUBLIC;

/*==============================================================*/
/* Table: LOTACOES                                              */
/*==============================================================*/
create table LOTACOES (
FK_EMPRESAS          VALORI                         not null,
FK_ALMOXARIFADOS     VALORS                         not null,
PK_LOTACOES          VALORS                         not null,
RUA_LOT              DESCRICAO_10                   not null,
NIVEL_LOT            DESCRICAO_10                   not null,
BOX_LOT              DESCRICAO_10                   not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_LOTACOES primary key (FK_EMPRESAS, PK_LOTACOES, FK_ALMOXARIFADOS)
);

/*==============================================================*/
/* Index: IDX_LOTACOES01                                        */
/*==============================================================*/
create unique asc index IDX_LOTACOES01 on LOTACOES (
FK_EMPRESAS,
FK_ALMOXARIFADOS,
RUA_LOT,
NIVEL_LOT,
BOX_LOT
);

grant DELETE,INSERT,UPDATE,SELECT on LOTACOES to PUBLIC;

/*==============================================================*/
/* Table: PARAMETROS_ESTQ                                       */
/*==============================================================*/
create table PARAMETROS_ESTQ (
FK_EMPRESAS          VALORI                         not null,
FK_ALMOXARIFADOS     VALORS,
FK_TIPO_MOVIM_ESTQ__ENTR VALORS,
FK_TIPO_MOVIM_ESTQ__SAI VALORS,
FK_TABELA_PRECOS     VALORS                         not null,
FLAG_TMRGM           FLAG_TIPO_MARGEM               not null,
FLAG_TCUSTO          FLAG_TIPO_CUSTOS               not null,
FLAG_TACABM          FLAG                           not null,
KC_PRODUTOS_SALDOS   VALORI                         default 0,
KC_PRODUTOS_SALDO_ALMX VALORI                         default 0,
MRG_DEF              NUMERO_INDICE,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PARAMETROS_ESTQ primary key (FK_EMPRESAS)
);

grant SELECT,UPDATE,INSERT,DELETE on PARAMETROS_ESTQ to PUBLIC;

/*==============================================================*/
/* Table: PRODUTOS                                              */
/*==============================================================*/
create table PRODUTOS (
PK_PRODUTOS          VALORI                         not null,
FK_PRODUTOS_GRUPOS   VALORS                         not null,
FK_UNIDADES          VALORS                         not null,
DSC_PROD             DESCRICAO_50RQ                 not null,
DSC_PROD_RED         DESCRICAO_30,
FLAG_ATV             FLAG_SIM_NAO                   not null,
FLAG_NEG             FLAG_ESTOQUES_NEGATIVO         not null,
FAT_CONV             NUMERO_GRANDE_6CD,
QTD_UNI              NUMERO_PEQUENO_4CD,
KC_PRODUTOS_COMPOSICOES VALORS                         default 0,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PRODUTOS primary key (PK_PRODUTOS)
);

/*==============================================================*/
/* Index: PRODUTOS_IDX1                                         */
/*==============================================================*/
create asc index PRODUTOS_IDX1 on PRODUTOS (
FLAG_ATV,
DSC_PROD
);

grant SELECT,UPDATE,INSERT,DELETE on PRODUTOS to PUBLIC;

/*==============================================================*/
/* Table: PRODUTOS_CARACTERISTICAS                              */
/*==============================================================*/
create table PRODUTOS_CARACTERISTICAS (
FK_PRODUTOS          VALORI                         not null,
CRT_PROD             BLOB_TEXTO                     not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PRODUTOS_CARACTERISTICAS primary key (FK_PRODUTOS)
);

grant DELETE,INSERT,UPDATE,SELECT on PRODUTOS_CARACTERISTICAS to PUBLIC;

/*==============================================================*/
/* Table: PRODUTOS_CODIGOS                                      */
/*==============================================================*/
create table PRODUTOS_CODIGOS (
FK_PRODUTOS          VALORI                         not null,
PK_PRODUTOS_CODIGOS  VALORS                         not null,
COD_REF              CODIGO_PRODUTO,
DSC_CODE             DESCRICAO_30RQ                 not null,
FLAG_TCODE           FLAG_TIPO_CODIGO_PRODUTO       not null,
FLAG_TBARCODE        FLAG_TIPO_CODIGO_BARRAS        not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PRODUTOS_CODIGOS primary key (FK_PRODUTOS, PK_PRODUTOS_CODIGOS)
);

/*==============================================================*/
/* Index: IDX_PRODUTOS_CODIGOS_01                               */
/*==============================================================*/
create asc index IDX_PRODUTOS_CODIGOS_01 on PRODUTOS_CODIGOS (
COD_REF,
FLAG_TCODE
);

grant SELECT,UPDATE,INSERT,DELETE on PRODUTOS_CODIGOS to PUBLIC;

/*==============================================================*/
/* Table: PRODUTOS_COMPOSICOES                                  */
/*==============================================================*/
create table PRODUTOS_COMPOSICOES (
FK_PRODUTOS          VALORI                         not null,
PK_PRODUTOS_COMPOSICOES VALORI                         not null,
FK_INSUMOS           VALORI                         not null,
QTD_PROD             NUMERO_PEQUENO_4CD             not null,
FLAG_TCOMP           FLAG_SIM_NAO                   not null,
SEQ_COMP             VALORS,
FLAG_DEF             FLAG_SIM_NAO                   not null,
MED_DEF              NUMERO_PEQUENO_4CD             not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PRODUTOS_COMPOSICOES primary key (FK_PRODUTOS, PK_PRODUTOS_COMPOSICOES)
);

grant SELECT,UPDATE,INSERT,DELETE on PRODUTOS_COMPOSICOES to PUBLIC;

/*==============================================================*/
/* Table: PRODUTOS_COMPRAS                                      */
/*==============================================================*/
create table PRODUTOS_COMPRAS (
FK_PRODUTOS          VALORI                         not null,
FK_TIPO_ACABAMENTOS  VALORS,
FK_TIPO_REFERENCIAS  VALORS,
FK_UNIDADES          VALORS,
FK_CENTRO_CUSTOS     VALORS                         not null,
FLAG_EMP             FLAG_SIM_NAO                   not null,
FLAG_CMPR            FLAG_SIM_NAO                   not null,
FLAG_TMAT            FLAG_TIPO_MATERIAL             not null,
VLR_UNIT             NUMERO_PEQUENO_4CD,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PRODUTOS_COMPRAS primary key (FK_PRODUTOS)
);

grant DELETE,INSERT,UPDATE,SELECT on PRODUTOS_COMPRAS to PUBLIC;

/*==============================================================*/
/* Table: PRODUTOS_CONTAS                                       */
/*==============================================================*/
create table PRODUTOS_CONTAS (
FK_PRODUTOS_GRUPOS   VALORI                         not null,
FK_TIPO_CFOP         VALORS                         not null,
FK_NATUREZA_OPERACOES VALORS                         not null,
FK_FINANCEIRO_CONTAS VALORI                         not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PRODUTOS_CONTAS primary key (FK_PRODUTOS_GRUPOS, FK_TIPO_CFOP, FK_NATUREZA_OPERACOES)
);

grant SELECT,UPDATE,INSERT,DELETE on PRODUTOS_CONTAS to PUBLIC;

/*==============================================================*/
/* Table: PRODUTOS_CUSTOS                                       */
/*==============================================================*/
create table PRODUTOS_CUSTOS (
FK_EMPRESAS          VALORI                         not null,
FK_PRODUTOS          VALORI                         not null,
FK_VW_FORNECEDORES   VALORI,
QTD_PEDF             NUMERO_PEQUENO_4CD,
CUST_FINAL           NUMERO_MEDIO_4CD,
CUST_FORN            NUMERO_MEDIO_4CD,
CUST_RJST            NUMERO_MEDIO_4CD,
CUST_UFRN            NUMERO_MEDIO_4CD,
CUST_REAL            NUMERO_MEDIO_4CD,
CUST_MED             NUMERO_MEDIO_4CD,
DTA_USLD             DATA,
DTA_UCMP             DATA,
FLAG_RJST            FLAG_SIM_NAO                   not null,
DTA_PRV_ENTR_COMPRA  DATA,
QTD_DIAS_REP         VALORS,
QTD_GRNT             NUMERO_PEQUENO_4CD,
QTD_DIAS_ENTR        VALORS,
QTD_CMP_MED          NUMERO_PEQUENO_4CD,
QTD_CNS_MED          NUMERO_PEQUENO_4CD,
QTD_DIAS_ESTQ        NUMERO_PEQUENO_4CD,
QTD_ESTQ             NUMERO_PEQUENO_4CD,
QTD_RSRV             NUMERO_PEQUENO_4CD,
QTD_EMAX             NUMERO_PEQUENO_4CD,
QTD_EMIN             NUMERO_PEQUENO_4CD,
QTD_ESTQ_QR          NUMERO_PEQUENO_4CD,
DTA_UMOV             DATA,
DTA_URSV             DATA,
DTA_UINV             DATA,
KC_PRODUTOS_HISTORICOS VALORI,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PRODUTOS_CUSTOS primary key (FK_EMPRESAS, FK_PRODUTOS)
);

grant SELECT,UPDATE,INSERT,DELETE on PRODUTOS_CUSTOS to PUBLIC;

/*==============================================================*/
/* Table: PRODUTOS_ESTOQUES                                     */
/*==============================================================*/
create table PRODUTOS_ESTOQUES (
FK_EMPRESAS          VALORI                         not null,
FK_PRODUTOS          VALORI                         not null,
FK_ALMOXARIFADOS     VALORS                         not null,
FK_TIPO_SITUACAO_ESTOQUES VALORS,
QTD_ESTQ             NUMERO_PEQUENO_4CD,
QTD_GRNT             NUMERO_PEQUENO_4CD,
QTD_RSRV             NUMERO_PEQUENO_4CD,
QTD_EMAX             NUMERO_PEQUENO_4CD,
QTD_EMIN             NUMERO_PEQUENO_4CD,
QTD_ESTQ_QR          NUMERO_PEQUENO_4CD,
DTA_UMOV             DATA,
DTA_URSV             DATA,
DTA_UINV             DATA,
FLAG_EMP             FLAG_SIM_NAO                   not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PRODUTOS_ESTOQUES primary key (FK_EMPRESAS, FK_PRODUTOS, FK_ALMOXARIFADOS)
);

grant DELETE,INSERT,UPDATE,SELECT on PRODUTOS_ESTOQUES to PUBLIC;

/*==============================================================*/
/* Table: PRODUTOS_ESTOQUES_VERSAO                              */
/*==============================================================*/
create table PRODUTOS_ESTOQUES_VERSAO (
FK_EMPRESAS          VALORI                         not null,
FK_PRODUTOS          VALORI                         not null,
PK_PRODUTOS_ESTOQUES_VERSAO VALORI                         not null,
PROD_VERSAO          VALORS                         not null,
QTD_ESTQ             NUMERO_MEDIO_4CD,
QTD_RSRV             NUMERO_MEDIO_4CD,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PRODUTOS_ESTOQUES_VERSAO primary key (FK_EMPRESAS, FK_PRODUTOS, PK_PRODUTOS_ESTOQUES_VERSAO)
);

grant SELECT,UPDATE,INSERT,DELETE on PRODUTOS_ESTOQUES_VERSAO to PUBLIC;

/*==============================================================*/
/* Table: PRODUTOS_FORNECEDORES                                 */
/*==============================================================*/
create table PRODUTOS_FORNECEDORES (
FK_EMPRESAS          VALORI                         not null,
FK_PRODUTOS          VALORI                         not null,
FK_VW_FORNECEDORES   VALORI                         not null,
FK_UNIDADES          VALORS,
FK_TIPO_DESCONTOS    VALORS,
SIT_TRIB             SITUACAO_TRIBUTARIA            not null,
QTD_UNI              NUMERO_PEQUENO_4CD             not null,
QTD_GRNT             NUMERO_PEQUENO_4CD,
FLAG_RJST            FLAG_SIM_NAO                   not null,
FLAG_INSP            FLAG_TIPO_INSPECAO             not null,
PRE_TAB              NUMERO_PEQUENO_4CD,
PRE_FINAL            NUMERO_PEQUENO_4CD,
FRETE_INS            NUMERO_PEQUENO_4CD,
QTD_DIAS_ENTR        VALORS,
FLAG_DEF             FLAG_SIM_NAO                   not null,
OBS_FORN             BLOB_TEXTO,
DTA_GRNT             DATA,
KC_PRODUTOS_FONECEDORES_COMP VALORS,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_INSUMO_FORNECEDORES primary key (FK_EMPRESAS, FK_PRODUTOS, FK_VW_FORNECEDORES)
);

grant SELECT,UPDATE,INSERT,DELETE on PRODUTOS_FORNECEDORES to PUBLIC;

/*==============================================================*/
/* Table: PRODUTOS_FORN_HISTORICOS                              */
/*==============================================================*/
create table PRODUTOS_FORN_HISTORICOS (
FK_EMPRESAS          VALORI                         not null,
FK_PRODUTOS          VALORI                         not null,
FK_VW_FORNECEDORES   VALORI                         not null,
DTHR_INC             DATA_HORA_DEF                  not null,
PRE_TAB              NUMERO_PEQUENO_4CD,
PRE_FINAL            NUMERO_PEQUENO_4CD,
FRETE_INS            NUMERO_PEQUENO_4CD,
PRE_TAB_ANT          NUMERO_PEQUENO_4CD,
PRE_FINAL_ANT        NUMERO_PEQUENO_4CD,
FRETE_INS_ANT        NUMERO_PEQUENO_4CD,
OPE_INC              NOME_OPERADOR_DEF,
constraint PK_PRODUTOS_FORN_HISTORICOS primary key (FK_EMPRESAS, FK_PRODUTOS, FK_VW_FORNECEDORES, DTHR_INC)
);

grant DELETE,INSERT,UPDATE,SELECT on PRODUTOS_FORN_HISTORICOS to PUBLIC;

/*==============================================================*/
/* Table: PRODUTOS_GRUPOS                                       */
/*==============================================================*/
create table PRODUTOS_GRUPOS (
PK_PRODUTOS_GRUPOS   VALORI                         not null,
FK_PRODUTOS_GRUPOS   VALORI,
DSC_PGRU             DESCRICAO_30RQ                 not null,
SEQ_CLASS            VALORS                         not null,
LEV_CLASS            VALORS                         not null,
MASK_CLASS           DESCRICAO_50RQ                 not null,
FLAG_LAST_LEVEL      FLAG_SIM_NAO                   not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PRODUTOS_GRUPOS primary key (PK_PRODUTOS_GRUPOS)
);

grant SELECT,UPDATE,INSERT,DELETE on PRODUTOS_GRUPOS to PUBLIC;

/*==============================================================*/
/* Table: PRODUTOS_HISTORICOS                                   */
/*==============================================================*/
create table PRODUTOS_HISTORICOS (
FK_EMPRESAS          VALORI                         not null,
FK_PRODUTOS          VALORI                         not null,
PK_PRODUTOS_HISTORICOS VALORI                         not null,
FK_CADASTROS         VALORI,
CUST_FORN            NUMERO_MEDIO_4CD,
CUST_UFRN            NUMERO_MEDIO_4CD,
CUST_REAL            NUMERO_MEDIO_4CD,
CUST_MED             NUMERO_MEDIO_4CD,
CUST_FINAL           NUMERO_MEDIO_4CD,
FK_CADASTROS_ANT     VALORI,
CUST_FORN_ANT        NUMERO_MEDIO_4CD,
CUST_UFRN_ANT        NUMERO_MEDIO_4CD,
CUST_REAL_ANT        NUMERO_MEDIO_4CD,
CUST_MED_ANT         NUMERO_MEDIO_4CD,
CUST_FINAL_ANT       NUMERO_MEDIO_4CD,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
constraint PK_PRODUTOS_HISTORICOS primary key (FK_EMPRESAS, FK_PRODUTOS, PK_PRODUTOS_HISTORICOS)
);

/*==============================================================*/
/* Index: IDX_PRODUTOS_HISTORICOS_01                            */
/*==============================================================*/
create asc index IDX_PRODUTOS_HISTORICOS_01 on PRODUTOS_HISTORICOS (
FK_EMPRESAS,
FK_PRODUTOS,
DTHR_INC
);

grant DELETE,INSERT,UPDATE,SELECT on PRODUTOS_HISTORICOS to PUBLIC;

/*==============================================================*/
/* Table: PRODUTOS_IMAGENS                                      */
/*==============================================================*/
create table PRODUTOS_IMAGENS (
FK_PRODUTOS          VALORI                         not null,
FLAG_TIMG            FLAG_TIPO_IMAGEM               not null,
IMG_PROD             BLOB_BINARIO,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PRODUTOS_IMAGENS primary key (FK_PRODUTOS)
);

grant SELECT,UPDATE,INSERT,DELETE on PRODUTOS_IMAGENS to PUBLIC;

/*==============================================================*/
/* Table: PRODUTOS_IMPOSTOS                                     */
/*==============================================================*/
create table PRODUTOS_IMPOSTOS (
FK_EMPRESAS          VALORI                         not null,
FK_PRODUTOS          VALORI                         not null,
FK_TIPO_IMPOSTOS     VALORS                         not null,
FK_CLASSIFICACAO_FISCAL DESCRICAO_20,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PRODUTOS_IMPOSTOS primary key (FK_EMPRESAS, FK_PRODUTOS, FK_TIPO_IMPOSTOS)
);

grant DELETE,INSERT,UPDATE,SELECT on PRODUTOS_IMPOSTOS to PUBLIC;

/*==============================================================*/
/* Table: PRODUTOS_LOTACOES                                     */
/*==============================================================*/
create table PRODUTOS_LOTACOES (
FK_EMPRESAS          VALORI                         not null,
FK_PRODUTOS          VALORI                         not null,
FK_ALMOXARIFADOS     VALORS                         not null,
FK_LOTACOES          VALORS                         not null,
QTD_LOT              NUMERO_PEQUENO_4CD             not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PRODUTOS_LOTACOES primary key (FK_EMPRESAS, FK_PRODUTOS, FK_ALMOXARIFADOS, FK_LOTACOES)
);

grant SELECT,UPDATE,INSERT,DELETE on PRODUTOS_LOTACOES to PUBLIC;

/*==============================================================*/
/* Table: PRODUTOS_MARGEM                                       */
/*==============================================================*/
create table PRODUTOS_MARGEM (
FK_EMPRESAS          VALORI                         not null,
FK_PRODUTOS          VALORI                         not null,
FK_SITUACAO_TRIBUTARIAS VALORS                         default 0,
FK_ORIGENS_TRIBUTARIAS VALORS                         default 0,
FK_CLASSIFICACAO_FISCAL DESCRICAO_20,
SIT_TRIB             SITUACAO_TRIBUTARIA            not null,
MRG_LCR              NUMERO_INDICE                  not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PRODUTOS_MARGEM primary key (FK_EMPRESAS, FK_PRODUTOS)
);

grant DELETE,INSERT,UPDATE,SELECT on PRODUTOS_MARGEM to PUBLIC;

/*==============================================================*/
/* Table: PRODUTOS_PRECOS                                       */
/*==============================================================*/
create table PRODUTOS_PRECOS (
FK_EMPRESAS          VALORI                         not null,
FK_PRODUTOS          VALORI                         not null,
FK_TABELA_PRECOS     VALORS                         not null,
PRE_VDA              NUMERO_MEDIO_4CD,
FLAG_FIX             FLAG_SIM_NAO                   not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PRODUTOS_PRECOS primary key (FK_EMPRESAS, FK_PRODUTOS, FK_TABELA_PRECOS)
);

/*==============================================================*/
/* Index: IDX_PRODUTOS_PRECOS_01                                */
/*==============================================================*/
create asc index IDX_PRODUTOS_PRECOS_01 on PRODUTOS_PRECOS (
FK_TABELA_PRECOS,
FLAG_FIX
);

grant SELECT,UPDATE,INSERT,DELETE on PRODUTOS_PRECOS to PUBLIC;

/*==============================================================*/
/* Table: PRODUTOS_REFERENCIAS                                  */
/*==============================================================*/
create table PRODUTOS_REFERENCIAS (
FK_PRODUTOS_GRUPOS   VALORS                         not null,
DSCT_PROD            NUMERO_PERCENTUAL,
MRGM_REF             NUMERO_INDICE,
COM_SGRU             NUMERO_INDICE,
COD_GREF             CODIGO_GER_REFERENCIA          not null,
SEQ_REF              VALORI,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PRODUTOS_REFERENCIAS primary key (FK_PRODUTOS_GRUPOS)
);

grant SELECT,UPDATE,INSERT,DELETE on PRODUTOS_REFERENCIAS to PUBLIC;

/*==============================================================*/
/* Table: PRODUTOS_SALDOS                                       */
/*==============================================================*/
create table PRODUTOS_SALDOS (
FK_EMPRESAS          VALORI                         not null,
PK_PRODUTOS_SALDOS   VALORI                         not null,
FK_PRODUTOS          VALORI                         not null,
FK_TIPO_MOVIM_ESTQ   VALORS                         not null,
DTHR_SLD             DATA_HORA_DEF                  not null,
FK_CADASTROS         VALORI                         not null,
FK_TIPO_DOCUMENTOS   VALORS                         not null,
NUM_DOC              VALORI                         not null,
QTD_ENTRADA          NUMERO_PEQUENO_4CD             not null,
QTD_SAIDA            NUMERO_PEQUENO_4CD             not null,
FLAG_TSLD            FLAG_TIPO_SALDO                not null,
SLD_INS              NUMERO_PEQUENO_4CD             not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PRODUTOS_SALDOS primary key (FK_EMPRESAS, PK_PRODUTOS_SALDOS)
);

/*==============================================================*/
/* Index: IDX_PRODUTOS_SALDOS_01                                */
/*==============================================================*/
create asc index IDX_PRODUTOS_SALDOS_01 on PRODUTOS_SALDOS (
FK_EMPRESAS,
FK_PRODUTOS,
DTHR_SLD
);

/*==============================================================*/
/* Index: IDX_PRODUTOS_SALDOS_02                                */
/*==============================================================*/
create asc index IDX_PRODUTOS_SALDOS_02 on PRODUTOS_SALDOS (
FK_EMPRESAS,
FK_PRODUTOS,
DTHR_SLD,
FK_CADASTROS
);

grant SELECT,UPDATE,INSERT,DELETE on PRODUTOS_SALDOS to PUBLIC;

/*==============================================================*/
/* Table: PRODUTOS_SALDO_ALMX                                   */
/*==============================================================*/
create table PRODUTOS_SALDO_ALMX (
FK_EMPRESAS          VALORI                         not null,
PK_PRODUTOS_SALDO_ALMX VALORI                         not null,
FK_PRODUTOS          VALORI                         not null,
FK_ALMOXARIFADOS     VALORS                         not null,
FK_TIPO_MOVIM_ESTQ   VALORS                         not null,
DTHR_SLD             DATA_HORA_DEF                  not null,
FK_CADASTROS         VALORI                         not null,
FK_TIPO_DOCUMENTOS   VALORS                         not null,
NUM_DOC              VALORI                         not null,
QTD_ENTRADA          NUMERO_PEQUENO_4CD             not null,
QTD_SAIDA            NUMERO_PEQUENO_4CD             not null,
FLAG_TSLD            FLAG_TIPO_SALDO                not null,
SLD_INS              NUMERO_PEQUENO_4CD             not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PRODUTOS_SALDO_ALMX primary key (FK_EMPRESAS, PK_PRODUTOS_SALDO_ALMX)
);

/*==============================================================*/
/* Index: IDX_PRODUTOS_SALDO_ALMX_02                            */
/*==============================================================*/
create asc index IDX_PRODUTOS_SALDO_ALMX_02 on PRODUTOS_SALDO_ALMX (
FK_EMPRESAS,
FK_PRODUTOS,
FK_ALMOXARIFADOS,
DTHR_SLD,
FK_CADASTROS
);

/*==============================================================*/
/* Index: IDX_PRODUTOS_SALDO_ALMX_01                            */
/*==============================================================*/
create asc index IDX_PRODUTOS_SALDO_ALMX_01 on PRODUTOS_SALDO_ALMX (
FK_EMPRESAS,
FK_PRODUTOS,
FK_ALMOXARIFADOS,
DTHR_SLD
);

grant SELECT,UPDATE,INSERT,DELETE on PRODUTOS_SALDO_ALMX to PUBLIC;

/*==============================================================*/
/* Table: PRODUTOS_SERVICOS                                     */
/*==============================================================*/
create table PRODUTOS_SERVICOS (
FK_PRODUTOS          VALORI                         not null,
VLR_UNIT             NUMERO_PEQUENO_4CD,
FLAG_ATV             FLAG_SIM_NAO                   not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PRODUTOS_SERVICOS primary key (FK_PRODUTOS)
);

grant SELECT,UPDATE,INSERT,DELETE on PRODUTOS_SERVICOS to PUBLIC;

/*==============================================================*/
/* Table: PRODUTOS_VENDAS                                       */
/*==============================================================*/
create table PRODUTOS_VENDAS (
FK_PRODUTOS          VALORI                         not null,
FK_SIMILARES         VALORS,
FK_LINHAS            VALORS,
DSC_PROD_RED         DESCRICAO_30RQ                 not null,
FLAG_TPROD           FLAG_SIM_NAO                   not null,
FLAG_IMP             FLAG_SIM_NAO                   not null,
FAT_CONV_CUB         NUMERO_GRANDE_4CD              not null,
VLR_CUB              NUMERO_PEQUENO_4CD,
PES_LIQ              NUMERO_PEQUENO_4CD,
PES_BRU              NUMERO_PEQUENO_4CD,
COM_ITEM             NUMERO_INDICE,
ALT_PROD             NUMERO_MEDIO,
PROF_PROD            NUMERO_MEDIO,
LARG_PROD            NUMERO_MEDIO,
ALT_IPROD            NUMERO_MEDIO,
PROF_IPROD           NUMERO_MEDIO,
LARG_IPROD           NUMERO_MEDIO,
ALT_EPROD            NUMERO_MEDIO,
PROF_EPROD           NUMERO_MEDIO,
LARG_EPROD           NUMERO_MEDIO,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PRODUTOS_VENDAS primary key (FK_PRODUTOS)
);

grant DELETE,INSERT,UPDATE,SELECT on PRODUTOS_VENDAS to PUBLIC;

/*==============================================================*/
/* Table: PRODUTOS_VERSOES_LOTACAO                              */
/*==============================================================*/
create table PRODUTOS_VERSOES_LOTACAO (
FK_EMPRESAS          VALORI                         not null,
FK_PRODUTOS          VALORI                         not null,
FK_PRODUTOS_ESTOQUES_VERSAO VALORI                         not null,
FK_ALMOXARIFADOS     VALORS                         not null,
FK_LOTACOES          VALORS                         not null,
QTD_LOT              NUMERO_MEDIO_4CD,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PRODUTOS_VERSOES_LOTACAO primary key (FK_EMPRESAS, FK_PRODUTOS, FK_PRODUTOS_ESTOQUES_VERSAO, FK_ALMOXARIFADOS, FK_LOTACOES)
);

grant SELECT,UPDATE,INSERT,DELETE on PRODUTOS_VERSOES_LOTACAO to PUBLIC;

/*==============================================================*/
/* Table: PRODUTOS_X_TIPO_PRODUTOS                              */
/*==============================================================*/
create table PRODUTOS_X_TIPO_PRODUTOS (
FK_TIPO_PRODUTOS     VALORS                         not null,
FK_PRODUTOS          VALORI                         not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PRODUTOS_X_TIPO_PRODUTOS primary key (FK_TIPO_PRODUTOS, FK_PRODUTOS)
);

grant DELETE,INSERT,UPDATE,SELECT on PRODUTOS_X_TIPO_PRODUTOS to PUBLIC;

/*==============================================================*/
/* Table: REQUISICOES                                           */
/*==============================================================*/
create table REQUISICOES (
FK_EMPRESAS          VALORI                         not null,
PK_REQUISICOES       VALORI                         not null,
FK_TIPO_MOVIM_ESTQ   VALORS                         not null,
FK_ALMOXARIFADOS     VALORS,
FK_ALMOXARIFADOS__DST VALORS,
FK_FUNCIONARIOS      VALORI,
FK_TIPO_DOCUMENTOS   VALORS                         not null,
DTA_DOC              DATA_DEF,
NUM_DOC              VALORI                         not null,
DTA_REQ              DATA_DEF,
OBS_REQ              BLOB_TEXTO,
FLAG_BXA             FLAG_SIM_NAO                   not null,
QTD_ITEMS            VALORI                         not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_REQUISICOES primary key (FK_EMPRESAS, PK_REQUISICOES)
);

/*==============================================================*/
/* Index: IDX_REQUISICOS01                                      */
/*==============================================================*/
create unique asc index IDX_REQUISICOS01 on REQUISICOES (
FK_EMPRESAS,
NUM_DOC
);

grant SELECT,UPDATE,INSERT,DELETE on REQUISICOES to PUBLIC;

/*==============================================================*/
/* Table: REQUISICOES_ITEMS                                     */
/*==============================================================*/
create table REQUISICOES_ITEMS (
FK_EMPRESAS          VALORI                         not null,
FK_REQUISICOES       VALORI                         not null,
PK_REQUISICOES_ITEMS VALORI                         not null,
FK_PRODUTOS          VALORI,
FK_LOTACAO_ORGM      VALORI,
FK_LOTACAO_DSTN      VALORI,
COD_PROD             CODIGO_PRODUTO                 not null,
QTD_ITM              NUMERO_PEQUENO_4CD             not null,
STT_BXA              VALORS                         default 0,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_REQUISICOES_ITEMS primary key (FK_EMPRESAS, FK_REQUISICOES, PK_REQUISICOES_ITEMS)
);

grant DELETE,INSERT,UPDATE,SELECT on REQUISICOES_ITEMS to PUBLIC;

/*==============================================================*/
/* Table: SIMILARES                                             */
/*==============================================================*/
create table SIMILARES (
PK_SIMILARES         VALORS                         not null,
DSC_SIM              DESCRICAO_30RQ                 not null,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
constraint PK_SIMILARES primary key (PK_SIMILARES)
);

grant SELECT,UPDATE,INSERT,DELETE on SIMILARES to PUBLIC;

/*==============================================================*/
/* Table: TABELA_PRECOS                                         */
/*==============================================================*/
create table TABELA_PRECOS (
PK_TABELA_PRECOS     VALORS                         not null,
DSC_TAB              DESCRICAO_30RQ                 not null,
DTA_INI              DATA,
DTA_FIN              DATA,
FLAG_DEFTAB          FLAG_SIM_NAO                   not null,
PERC_DSCT            NUMERO_PERCENTUAL,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_TABELA_PRECOS primary key (PK_TABELA_PRECOS)
);

grant DELETE,INSERT,UPDATE,SELECT on TABELA_PRECOS to PUBLIC;

/*==============================================================*/
/* Table: TIPO_COMPOSICOES                                      */
/*==============================================================*/
create table TIPO_COMPOSICOES (
FK_PRODUTOS          VALORI                         not null,
PK_TIPO_COMPOSICOES  VALORI                         not null,
DSC_COMP             DESCRICAO_100RQ                not null,
FLAG_ATV             FLAG_SIM_NAO                   not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_TIPO_COMPOSICOES primary key (FK_PRODUTOS, PK_TIPO_COMPOSICOES)
);

grant SELECT,UPDATE,INSERT,DELETE on TIPO_COMPOSICOES to PUBLIC;

/*==============================================================*/
/* Table: TIPO_MOVIM_ESTQ                                       */
/*==============================================================*/
create table TIPO_MOVIM_ESTQ (
PK_TIPO_MOVIM_ESTQ   VALORS                         not null,
FK_TIPO_MOVIM_ESTQ   VALORS,
DSC_TMOV             DESCRICAO_30RQ                 not null,
FLAG_TBAIXA          FLAG_TIPO_BAIXA_ESTQ           not null,
FLAG_TMOV            FLAG_TIPO_SALDO                not null,
FLAG_TCOD            FLAG_TIPO_CODIGO_PRODUTO       not null,
FLAG_GENHST          FLAG_SIM_NAO                   not null,
FLAG_OPESTQ          FLAG_OPERACAO                  not null,
FLAG_MVESTQ          FLAG_SIM_NAO                   not null,
FLAG_OPRSRV          FLAG_OPERACAO                  not null,
FLAG_MVRSRV          FLAG_SIM_NAO                   not null,
FLAG_OPGRNT          FLAG_OPERACAO                  not null,
FLAG_MVGRNT          FLAG_SIM_NAO                   not null,
FLAG_OPQRNT          FLAG_OPERACAO                  not null,
FLAG_MVQRNT          FLAG_SIM_NAO                   not null,
FLAG_OPPEDF          FLAG_OPERACAO                  not null,
FLAG_MVPEDF          FLAG_SIM_NAO                   not null,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
constraint PK_TIPO_MOVIM_ESTQ primary key (PK_TIPO_MOVIM_ESTQ)
);

grant DELETE,INSERT,UPDATE,SELECT on TIPO_MOVIM_ESTQ to PUBLIC;

/*==============================================================*/
/* Table: TIPO_PRODUTOS                                         */
/*==============================================================*/
create table TIPO_PRODUTOS (
PK_TIPO_PRODUTOS     VALORS                         not null,
DSC_TPRD             DESCRICAO_30RQ                 not null,
FLAG_TPROD           FLAG_TIPO_PRODUTO              not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_TIPO_PRODUTOS primary key (PK_TIPO_PRODUTOS)
);

grant SELECT,UPDATE,INSERT,DELETE on TIPO_PRODUTOS to PUBLIC;

/*==============================================================*/
/* Table: TIPO_PRODUTOS_NATURE_OPER                             */
/*==============================================================*/
create table TIPO_PRODUTOS_NATURE_OPER (
FK_TIPO_PRODUTOS     VALORS                         not null,
FK_TIPO_CFOP         VALORS                         not null,
FK_NATUREZA_OPERACOES VALORS                         not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_TIPO_PRODUTOS_NATURE_OPER primary key (FK_TIPO_PRODUTOS, FK_TIPO_CFOP, FK_NATUREZA_OPERACOES)
);

grant SELECT,UPDATE,INSERT,DELETE on TIPO_PRODUTOS_NATURE_OPER to PUBLIC;

/*==============================================================*/
/* Table: TIPO_SITUACAO_ESTOQUES                                */
/*==============================================================*/
create table TIPO_SITUACAO_ESTOQUES (
PK_TIPO_SITUACAO_ESTOQUES VALORS                         not null,
DSC_TSE              DESCRICAO_30RQ                 not null,
FLAG_BLOQ            FLAG_SIM_NAO                   not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_TIPO_SITUACAO_ESTOQUES primary key (PK_TIPO_SITUACAO_ESTOQUES)
);

grant SELECT,UPDATE,INSERT,DELETE on TIPO_SITUACAO_ESTOQUES to PUBLIC;

/*==============================================================*/
/* Table: UNIDADES                                              */
/*==============================================================*/
create table UNIDADES (
PK_UNIDADES          VALORS                         not null,
DSC_UNI              DESCRICAO_30RQ                 not null,
FLAG_FRAC            FLAG_SIM_NAO                   not null,
MNMO_UNI             CODIGO_UNIDADES                not null,
FLAG_QTD             FLAG_SIM_NAO                   not null,
FLAG_ALT             FLAG_SIM_NAO                   not null,
FLAG_LARG            FLAG_SIM_NAO                   not null,
FLAG_COMP            FLAG_SIM_NAO                   not null,
FLAG_FUNI            FLAG,
FLAG_TUNI            FLAG,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_UNIDADES primary key (PK_UNIDADES)
);

alter table CLIENTES
   add constraint FK_CLIENTES_TABELA_PRECOS foreign key (FK_TABELA_PRECOS)
      references TABELA_PRECOS (PK_TABELA_PRECOS);


grant SELECT,UPDATE,INSERT,DELETE on UNIDADES to PUBLIC;

/*==============================================================*/
/* View: VW_ATIVIDADES                                          */
/*==============================================================*/
create view VW_ATIVIDADES
(
PK_PRODUTOS, 
DSC_PROD,
VLR_UNIT, 
QTD_PROD, 
COD_REF,
FLAG_QTD, 
FLAG_ALT, 
FLAG_LARG,
FLAG_COMP, 
SEQ_COMP, 
QTD_UNI,
FLAG_TUNI, 
FLAG_FUNI, 
PK_UNIDADES
)
as
select Prd.PK_PRODUTOS, Cast(Prd.DSC_PROD || ' ==> '
       || Uni.MNMO_UNI as varchar(60)) as DSC_PROD,
       Psv.VLR_UNIT, 0.0 as QTD_PROD, Pcd.COD_REF,
       Uni.FLAG_QTD, Uni.FLAG_ALT, Uni.FLAG_LARG,
       Uni.FLAG_COMP, 0 as SEQ_COMP, Prd.QTD_UNI,
       Uni.FLAG_TUNI, Uni.FLAG_FUNI, Uni.PK_UNIDADES
  from PRODUTOS_SERVICOS Psv 
  join PRODUTOS Prd 
    on Prd.PK_PRODUTOS = Psv.FK_PRODUTOS 
   and Prd.FLAG_ATV    = 1
  join UNIDADES Uni 
    on PK_UNIDADES     = Prd.FK_UNIDADES 
  join PRODUTOS_CODIGOS Pcd 
    on Pcd.FK_PRODUTOS = Prd.PK_PRODUTOS 
   and Pcd.FLAG_TCODE  = 0
 where Psv.FK_PRODUTOS > 0
   and Psv.FLAG_ATV    = 1;

grant SELECT on VW_ATIVIDADES to PUBLIC;

/*==============================================================*/
/* View: VW_MATERIAL                                            */
/*==============================================================*/
create view VW_MATERIAL
(
  PK_PRODUTOS,
  DSC_PROD,
  VLR_UNIT,
  QTD_PROD,
  COD_REF,
  FLAG_QTD,
  FLAG_ALT,
  FLAG_LARG,
  FLAG_COMP,
  SEQ_COMP,
  QTD_UNI,
  FLAG_TUNI,
  FLAG_FUNI,
  PK_UNIDADES) as
select Prd.PK_PRODUTOS, Cast(Prd.DSC_PROD || ' ==> ' 
       || Uni.MNMO_UNI as varchar(60)) as DSC_PROD, 
       Pcp.VLR_UNIT, 0.0 as QTD_PROD, Pcd.COD_REF,
       Uni.FLAG_QTD, Uni.FLAG_ALT, Uni.FLAG_LARG, 
       Uni.FLAG_COMP, 0 as SEQ_COMP, Prd.QTD_UNI,
       Uni.FLAG_TUNI, Uni.FLAG_FUNI, Uni.PK_UNIDADES
  from PRODUTOS_COMPRAS Pcp 
  join PRODUTOS Prd 
    on Prd.PK_PRODUTOS = Pcp.FK_PRODUTOS 
   and Prd.FLAG_ATV    = 1 
  join UNIDADES Uni 
    on Uni.PK_UNIDADES = Prd.FK_UNIDADES 
  join PRODUTOS_CODIGOS Pcd 
    on Pcd.FK_PRODUTOS = Prd.PK_PRODUTOS 
   and Pcd.FLAG_TCODE  = 0;

grant SELECT on VW_MATERIAL to PUBLIC;

/*==============================================================*/
/* View: VW_SERVICES                                            */
/*==============================================================*/
create view VW_SERVICES
(
PK_PRODUTOS, 
DSC_PROD,
VLR_UNIT, 
QTD_PROD, 
COD_REF,
FLAG_QTD, 
FLAG_ALT, 
FLAG_LARG,
FLAG_COMP, 
SEQ_COMP, 
QTD_UNI,
FLAG_TUNI, 
FLAG_FUNI, 
PK_UNIDADES
)
as
select Prd.PK_PRODUTOS, Cast(Prd.DSC_PROD || ' ==> '
       || Uni.MNMO_UNI as varchar(60)) as DSC_PROD,
       Psv.VLR_UNIT, 0.0 as QTD_PROD, Pcd.COD_REF,
       Uni.FLAG_QTD, Uni.FLAG_ALT, Uni.FLAG_LARG,
       Uni.FLAG_COMP, 0 as SEQ_COMP, Prd.QTD_UNI,
       Uni.FLAG_TUNI, Uni.FLAG_FUNI, Uni.PK_UNIDADES
  from PRODUTOS_SERVICOS Psv 
  join PRODUTOS Prd 
    on Prd.PK_PRODUTOS = Psv.FK_PRODUTOS 
   and Prd.FLAG_ATV    = 1
  join UNIDADES Uni 
    on PK_UNIDADES     = Prd.FK_UNIDADES 
  join PRODUTOS_CODIGOS Pcd 
    on Pcd.FK_PRODUTOS = Prd.PK_PRODUTOS 
   and Pcd.FLAG_TCODE  = 0
 where Psv.FK_PRODUTOS > 0
   and Psv.FLAG_ATV    = 0;

grant SELECT on VW_SERVICES to PUBLIC;

alter table COMPOSICOES
   add constraint FK_COMPOSICOES_TIPO_COMPOSICOES foreign key (FK_PRODUTOS, FK_TIPO_COMPOSICOES)
      references TIPO_COMPOSICOES (FK_PRODUTOS, PK_TIPO_COMPOSICOES)
      on delete cascade
      on update cascade;

alter table LOTACOES
   add constraint FK_LOTACOES_ALMOXARIFADOS foreign key (FK_ALMOXARIFADOS)
      references ALMOXARIFADOS (PK_ALMOXARIFADOS);

alter table PARAMETROS_ESTQ
   add constraint FK_PARAMETROS_ALMOXARIFADOS foreign key (FK_ALMOXARIFADOS)
      references ALMOXARIFADOS (PK_ALMOXARIFADOS);

alter table PARAMETROS_ESTQ
   add constraint FK_PARAMETROS_ESTQ_EMPRESAS foreign key (FK_EMPRESAS)
      references EMPRESAS (PK_EMPRESAS);

alter table PARAMETROS_ESTQ
   add constraint FK_PARAMETROS_ES_TABELA_PRECOS foreign key (FK_TABELA_PRECOS)
      references TABELA_PRECOS (PK_TABELA_PRECOS);

alter table PARAMETROS_ESTQ
   add constraint FK_PARAMETROS_TIPO_MOVES_ENTR foreign key (FK_TIPO_MOVIM_ESTQ__ENTR)
      references TIPO_MOVIM_ESTQ (PK_TIPO_MOVIM_ESTQ);

alter table PARAMETROS_ESTQ
   add constraint FK_PARAMETROS_TIPO_MOVES_SAI foreign key (FK_TIPO_MOVIM_ESTQ__SAI)
      references TIPO_MOVIM_ESTQ (PK_TIPO_MOVIM_ESTQ);

alter table PRODUTOS
   add constraint FK_PRODUTOS_PRODUTOS_REF foreign key (FK_PRODUTOS_GRUPOS)
      references PRODUTOS_REFERENCIAS (FK_PRODUTOS_GRUPOS);

alter table PRODUTOS
   add constraint FK_PRODUTOS_UNIDADES foreign key (FK_UNIDADES)
      references UNIDADES (PK_UNIDADES);

alter table PRODUTOS_CARACTERISTICAS
   add constraint FK_PRODUTOS_CARACT_PRODUTOS foreign key (FK_PRODUTOS)
      references PRODUTOS (PK_PRODUTOS)
      on delete cascade
      on update cascade;

alter table PRODUTOS_CODIGOS
   add constraint FK_PRODUTOS_CODIGOS_PRODUTOS foreign key (FK_PRODUTOS)
      references PRODUTOS (PK_PRODUTOS)
      on delete cascade
      on update cascade;

alter table PRODUTOS_COMPOSICOES
   add constraint FK_PRODUTOS_COMP_PRODUTOS foreign key (FK_PRODUTOS)
      references PRODUTOS (PK_PRODUTOS)
      on delete cascade
      on update cascade;

alter table PRODUTOS_COMPRAS
   add constraint FK_PRODUTOS_COMPRAS_PRODUTOS foreign key (FK_PRODUTOS)
      references PRODUTOS (PK_PRODUTOS)
      on delete cascade
      on update cascade;

alter table PRODUTOS_COMPRAS
   add constraint FK_PRODUTOS_COMPRA_UNIDADES foreign key (FK_UNIDADES)
      references UNIDADES (PK_UNIDADES);

alter table PRODUTOS_COMPRAS
   add constraint FK_PRODUTOS_COMP_CENTRO_CUSTOS foreign key (FK_CENTRO_CUSTOS)
      references CENTRO_CUSTOS (PK_CENTRO_CUSTOS);

alter table PRODUTOS_CONTAS
   add constraint FK_PRODUTOS_CONT_NATUREZA_OPER foreign key (FK_TIPO_CFOP, FK_NATUREZA_OPERACOES)
      references NATUREZA_OPERACOES (FK_TIPO_CFOP, PK_NATUREZA_OPERACOES);

alter table PRODUTOS_CONTAS
   add constraint FK_PRODUTOS_CTA_FINANCEIRO_CTA foreign key (FK_FINANCEIRO_CONTAS)
      references FINANCEIRO_CONTAS (PK_FINANCEIRO_CONTAS)
      on delete cascade
      on update cascade;

alter table PRODUTOS_CONTAS
   add constraint FK_PRODUTOS_CTA_PRODUTOS_GRUPOS foreign key (FK_PRODUTOS_GRUPOS)
      references PRODUTOS_GRUPOS (PK_PRODUTOS_GRUPOS)
      on delete cascade
      on update cascade;

alter table PRODUTOS_CUSTOS
   add constraint FK_PRODUTOS_CUSTOS_CADASTROS foreign key (FK_VW_FORNECEDORES)
      references CADASTROS (PK_CADASTROS);

alter table PRODUTOS_CUSTOS
   add constraint FK_PRODUTOS_CUSTOS_EMPRESAS foreign key (FK_EMPRESAS)
      references EMPRESAS (PK_EMPRESAS);

alter table PRODUTOS_CUSTOS
   add constraint FK_PRODUTOS_CUSTOS_PRODUTOS foreign key (FK_PRODUTOS)
      references PRODUTOS (PK_PRODUTOS)
      on delete cascade
      on update cascade;

alter table PRODUTOS_ESTOQUES
   add constraint FK_PRODUTOS_ESTO_ALMOXARIFADOS foreign key (FK_ALMOXARIFADOS)
      references ALMOXARIFADOS (PK_ALMOXARIFADOS);

alter table PRODUTOS_ESTOQUES
   add constraint FK_PRODUTOS_ESTO_PRODUTOS_CUSTO foreign key (FK_EMPRESAS, FK_PRODUTOS)
      references PRODUTOS_CUSTOS (FK_EMPRESAS, FK_PRODUTOS)
      on delete cascade
      on update cascade;

alter table PRODUTOS_ESTOQUES
   add constraint FK_PRODUTOS_ESTO_TIPO_SITUACAO foreign key (FK_TIPO_SITUACAO_ESTOQUES)
      references TIPO_SITUACAO_ESTOQUES (PK_TIPO_SITUACAO_ESTOQUES);

alter table PRODUTOS_ESTOQUES_VERSAO
   add constraint FK_PRODUTOS_ESTO_PRODUTOS_CUST foreign key (FK_EMPRESAS, FK_PRODUTOS)
      references PRODUTOS_CUSTOS (FK_EMPRESAS, FK_PRODUTOS);

alter table PRODUTOS_FORNECEDORES
   add constraint FK_PRODUTOS_FORN_CADASTROS foreign key (FK_VW_FORNECEDORES)
      references CADASTROS (PK_CADASTROS);

alter table PRODUTOS_FORNECEDORES
   add constraint FK_PRODUTOS_FORN_PRODUTOS_CUSTO foreign key (FK_EMPRESAS, FK_PRODUTOS)
      references PRODUTOS_CUSTOS (FK_EMPRESAS, FK_PRODUTOS)
      on delete cascade
      on update cascade;

alter table PRODUTOS_FORNECEDORES
   add constraint FK_PRODUTOS_FORN_UNIDADES foreign key (FK_UNIDADES)
      references UNIDADES (PK_UNIDADES);

alter table PRODUTOS_FORN_HISTORICOS
   add constraint FK_PRODUTOS_FORNH_PRODUTOS_FORN foreign key (FK_EMPRESAS, FK_PRODUTOS, FK_VW_FORNECEDORES)
      references PRODUTOS_FORNECEDORES (FK_EMPRESAS, FK_PRODUTOS, FK_VW_FORNECEDORES)
      on delete cascade
      on update cascade;

alter table PRODUTOS_GRUPOS
   add constraint FK_PRODUTOS_GRUP_PRODUTOS_GRUP foreign key (FK_PRODUTOS_GRUPOS)
      references PRODUTOS_GRUPOS (PK_PRODUTOS_GRUPOS);

alter table PRODUTOS_HISTORICOS
   add constraint FK_PRODUTOS_HIST_CADASTROS foreign key (FK_CADASTROS)
      references CADASTROS (PK_CADASTROS);

alter table PRODUTOS_HISTORICOS
   add constraint FK_PRODUTOS_HIST_CADASTROS_ANT foreign key (FK_CADASTROS_ANT)
      references CADASTROS (PK_CADASTROS);

alter table PRODUTOS_HISTORICOS
   add constraint FK_PRODUTOS_HIST_PRODUTOS_CUSTO foreign key (FK_EMPRESAS, FK_PRODUTOS)
      references PRODUTOS_CUSTOS (FK_EMPRESAS, FK_PRODUTOS)
      on delete cascade
      on update cascade;

alter table PRODUTOS_IMAGENS
   add constraint FK_PRODUTOS_IMAGENS_PRODUTOS foreign key (FK_PRODUTOS)
      references PRODUTOS (PK_PRODUTOS)
      on delete cascade
      on update cascade;

alter table PRODUTOS_IMPOSTOS
   add constraint FK_PRODUTOS_IMPOSTOS_CLAS_FISC foreign key (FK_CLASSIFICACAO_FISCAL)
      references CLASSIFICACAO_FISCAL (PK_CLASSIFICACAO_FISCAL);

alter table PRODUTOS_IMPOSTOS
   add constraint FK_PRODUTOS_IMPO_EMPRESAS foreign key (FK_EMPRESAS)
      references EMPRESAS (PK_EMPRESAS);

alter table PRODUTOS_IMPOSTOS
   add constraint FK_PRODUTOS_IMPO_PRODUTOS foreign key (FK_PRODUTOS)
      references PRODUTOS (PK_PRODUTOS)
      on delete cascade
      on update cascade;

alter table PRODUTOS_IMPOSTOS
   add constraint FK_PRODUTOS_IMPO_TIPO_IMPOSTOS foreign key (FK_TIPO_IMPOSTOS)
      references TIPO_IMPOSTOS (PK_TIPO_IMPOSTOS);

alter table PRODUTOS_LOTACOES
   add constraint FK_PRODUTOS_LOTACOES_LOTACOES foreign key (FK_EMPRESAS, FK_LOTACOES, FK_ALMOXARIFADOS)
      references LOTACOES (FK_EMPRESAS, PK_LOTACOES, FK_ALMOXARIFADOS);

alter table PRODUTOS_LOTACOES
   add constraint FK_PRODUTOS_LOTA_PRODUTOS_ESTO foreign key (FK_EMPRESAS, FK_PRODUTOS, FK_ALMOXARIFADOS)
      references PRODUTOS_ESTOQUES (FK_EMPRESAS, FK_PRODUTOS, FK_ALMOXARIFADOS)
      on delete cascade
      on update cascade;

alter table PRODUTOS_MARGEM
   add constraint FK_PRODUTOS_MARGEM_CLAS_FISCAL foreign key (FK_CLASSIFICACAO_FISCAL)
      references CLASSIFICACAO_FISCAL (PK_CLASSIFICACAO_FISCAL);

alter table PRODUTOS_MARGEM
   add constraint FK_PRODUTOS_MARG_EMPRESAS foreign key (FK_EMPRESAS)
      references EMPRESAS (PK_EMPRESAS);

alter table PRODUTOS_MARGEM
   add constraint FK_PRODUTOS_MARG_PRODUTOS foreign key (FK_PRODUTOS)
      references PRODUTOS (PK_PRODUTOS)
      on delete cascade
      on update cascade;

alter table PRODUTOS_PRECOS
   add constraint FK_PRODUTOS_PREC_PRODUTOS_MARG foreign key (FK_EMPRESAS, FK_PRODUTOS)
      references PRODUTOS_MARGEM (FK_EMPRESAS, FK_PRODUTOS)
      on delete cascade
      on update cascade;

alter table PRODUTOS_PRECOS
   add constraint FK_PRODUTO_PRECOS_TABELA_PRECOS foreign key (FK_TABELA_PRECOS)
      references TABELA_PRECOS (PK_TABELA_PRECOS);

alter table PRODUTOS_REFERENCIAS
   add constraint FK_PRODUTOS_GRUPOS_PRODUTOS_REF foreign key (FK_PRODUTOS_GRUPOS)
      references PRODUTOS_GRUPOS (PK_PRODUTOS_GRUPOS)
      on delete cascade
      on update cascade;

alter table PRODUTOS_SALDOS
   add constraint FK_INSUMOS_SALDO_GEN_CADASTROS foreign key (FK_CADASTROS)
      references CADASTROS (PK_CADASTROS);

alter table PRODUTOS_SALDOS
   add constraint FK_INSUMOS_SALDO_GEN_TIPO_MOV foreign key (FK_TIPO_MOVIM_ESTQ)
      references TIPO_MOVIM_ESTQ (PK_TIPO_MOVIM_ESTQ);

alter table PRODUTOS_SALDOS
   add constraint FK_PRODUTOS_SALD_PRODUTOS_CUST foreign key (FK_EMPRESAS, FK_PRODUTOS)
      references PRODUTOS_CUSTOS (FK_EMPRESAS, FK_PRODUTOS)
      on delete cascade
      on update cascade;

alter table PRODUTOS_SALDOS
   add constraint FK_PRODUTOS_SALD_TIPO_DOCUMENT foreign key (FK_TIPO_DOCUMENTOS)
      references TIPO_DOCUMENTOS (PK_TIPO_DOCUMENTOS);

alter table PRODUTOS_SALDO_ALMX
   add constraint FK_PRODUTOS_SALDOS_AL_CADASTROS foreign key (FK_CADASTROS)
      references CADASTROS (PK_CADASTROS);

alter table PRODUTOS_SALDO_ALMX
   add constraint FK_PRODUTOS_SALD_PRODUTOS_ESTO foreign key (FK_EMPRESAS, FK_PRODUTOS, FK_ALMOXARIFADOS)
      references PRODUTOS_ESTOQUES (FK_EMPRESAS, FK_PRODUTOS, FK_ALMOXARIFADOS)
      on delete cascade
      on update cascade;

alter table PRODUTOS_SALDO_ALMX
   add constraint FK_PRODUTOS_SALD_TIPO_MOVIM_ES foreign key (FK_TIPO_MOVIM_ESTQ)
      references TIPO_MOVIM_ESTQ (PK_TIPO_MOVIM_ESTQ);

alter table PRODUTOS_SALDO_ALMX
   add constraint FK_PRODUTOS_SLD_ALMX_TDOCUMENTO foreign key (FK_TIPO_DOCUMENTOS)
      references TIPO_DOCUMENTOS (PK_TIPO_DOCUMENTOS);

alter table PRODUTOS_SERVICOS
   add constraint FK_PRODUTOS_SERVICOS_PRODUTOS foreign key (FK_PRODUTOS)
      references PRODUTOS (PK_PRODUTOS);

alter table PRODUTOS_VENDAS
   add constraint FK_PRODUTOS_VENDAS_LINHAS foreign key (FK_LINHAS)
      references LINHAS (PK_LINHAS);

alter table PRODUTOS_VENDAS
   add constraint FK_PRODUTOS_VENDAS_PRODUTOS foreign key (FK_PRODUTOS)
      references PRODUTOS (PK_PRODUTOS)
      on delete cascade
      on update cascade;

alter table PRODUTOS_VENDAS
   add constraint FK_PRODUTOS_VENDAS_SIMILARES foreign key (FK_SIMILARES)
      references SIMILARES (PK_SIMILARES);

alter table PRODUTOS_VERSOES_LOTACAO
   add constraint FK_PRODUTOS_VERS_PRODUTOS_ESTO foreign key (FK_EMPRESAS, FK_PRODUTOS, FK_PRODUTOS_ESTOQUES_VERSAO)
      references PRODUTOS_ESTOQUES_VERSAO (FK_EMPRESAS, FK_PRODUTOS, PK_PRODUTOS_ESTOQUES_VERSAO);

alter table PRODUTOS_VERSOES_LOTACAO
   add constraint FK_PRODUTOS_VERS_PRODUTOS_LOTA foreign key (FK_EMPRESAS, FK_PRODUTOS, FK_ALMOXARIFADOS, FK_LOTACOES)
      references PRODUTOS_LOTACOES (FK_EMPRESAS, FK_PRODUTOS, FK_ALMOXARIFADOS, FK_LOTACOES);

alter table PRODUTOS_X_TIPO_PRODUTOS
   add constraint FK_PRODUTOS_X_TI_PRODUTOS foreign key (FK_PRODUTOS)
      references PRODUTOS (PK_PRODUTOS)
      on delete cascade
      on update cascade;

alter table PRODUTOS_X_TIPO_PRODUTOS
   add constraint FK_PRODUTOS_X_TI_TIPO_PRODUTOS foreign key (FK_TIPO_PRODUTOS)
      references TIPO_PRODUTOS (PK_TIPO_PRODUTOS);

alter table REQUISICOES
   add constraint FK_REQUISICOES_ALMOXARIFADOS foreign key (FK_ALMOXARIFADOS)
      references ALMOXARIFADOS (PK_ALMOXARIFADOS);

alter table REQUISICOES
   add constraint FK_REQUISICOES_ALMOXARIFADOS_DS foreign key (FK_ALMOXARIFADOS__DST)
      references ALMOXARIFADOS (PK_ALMOXARIFADOS);

alter table REQUISICOES
   add constraint FK_REQUISICOES_TIPO_MOVIM_ES foreign key (FK_TIPO_MOVIM_ESTQ)
      references TIPO_MOVIM_ESTQ (PK_TIPO_MOVIM_ESTQ);

alter table REQUISICOES_ITEMS
   add constraint FK_REQUISICOES_I_PRODUTOS foreign key (FK_PRODUTOS)
      references PRODUTOS (PK_PRODUTOS);

alter table REQUISICOES_ITEMS
   add constraint FK_REQUISICOES_I_REQUISICOES foreign key (FK_EMPRESAS, FK_REQUISICOES)
      references REQUISICOES (FK_EMPRESAS, PK_REQUISICOES);

alter table TIPO_COMPOSICOES
   add constraint FK_TIPO_COMPOSIC_PRODUTOS foreign key (FK_PRODUTOS)
      references PRODUTOS (PK_PRODUTOS)
      on delete cascade
      on update cascade;

alter table TIPO_MOVIM_ESTQ
   add constraint FK_TIPO_MOVIM_ES_TIPO_MOVIM_ES foreign key (FK_TIPO_MOVIM_ESTQ)
      references TIPO_MOVIM_ESTQ (PK_TIPO_MOVIM_ESTQ)
      on delete cascade
      on update cascade;

alter table TIPO_PRODUTOS_NATURE_OPER
   add constraint FK_TIPO_PRODUTOS_NATUREZA_OPER foreign key (FK_TIPO_CFOP, FK_NATUREZA_OPERACOES)
      references NATUREZA_OPERACOES (FK_TIPO_CFOP, PK_NATUREZA_OPERACOES)
      on delete cascade
      on update cascade;

alter table TIPO_PRODUTOS_NATURE_OPER
   add constraint FK_TIPO_PRODUTOS_TIPO_PRODUTOS foreign key (FK_TIPO_PRODUTOS)
      references TIPO_PRODUTOS (PK_TIPO_PRODUTOS)
      on delete cascade
      on update cascade;

