/*==============================================================*/
/* Database name:  PROCESSA                                     */
/* DBMS name:      Friebird15x                                  */
/* Created on:     11/9/2006 15:07:59                           */
/*==============================================================*/


/*==============================================================*/
/* Table: DOCUMENTOS                                            */
/*==============================================================*/
create table DOCUMENTOS (
FK_EMPRESAS          VALORI                         not null,
FK_TIPO_DOCUMENTOS   VALORS                         not null,
FK_CADASTROS         VALORI                         not null,
PK_DOCUMENTOS        VALORI                         not null,
FK_GRUPOS_MOVIMENTOS VALORS,
DATA_DOC             DATA_DEF                       not null,
DTA_EMB              DATA,
DTA_EMB_EXT          DATA,
FLAG_BXAC            FLAG_SIM_NAO                   not null,
FLAG_CANC            FLAG_SIM_NAO                   not null,
FLAG_CTB             FLAG_SIM_NAO                   not null,
VLR_STOT             NUMERO_GRANDE_4CD,
VLR_ENTR             NUMERO_MEDIO_4CD,
VLR_ACR_DSCT         NUMERO_MEDIO_4CD,
VLR_DSP_ACES         NUMERO_PEQUENO_4CD,
VLR_FRE              NUMERO_PEQUENO_4CD,
VLR_SEG              NUMERO_PEQUENO_4CD,
VLR_BICMS            NUMERO_GRANDE_4CD,
VLR_ICMS             NUMERO_MEDIO_4CD,
VLR_BICMSS           NUMERO_GRANDE_4CD,
VLR_ICMSS            NUMERO_MEDIO_4CD,
VLR_BISNT            NUMERO_MEDIO_4CD,
VLR_BIPI             NUMERO_GRANDE_4CD,
VAL_IPI              NUMERO_MEDIO_4CD,
VLR_BISS             NUMERO_GRANDE_4CD,
VLR_ISS              NUMERO_MEDIO_4CD,
VAL_TOT              NUMERO_GRANDE_4CD,
QTD_ITEM             VALORS,
QTD_DUPL             VALORS,
QTD_VOL              VALORS,
PES_LIQ              NUMERO_MEDIO_4CD,
PES_BRU              NUMERO_MEDIO_4CD,
NUM_VOL              VALORS,
TIPO_VOL             DESCRICAO_20,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_DOCUMENTOS primary key (FK_EMPRESAS, FK_TIPO_DOCUMENTOS, FK_CADASTROS, PK_DOCUMENTOS)
);

/*==============================================================*/
/* Index: IDX_DOCUMENTOS_01                                     */
/*==============================================================*/
create asc index IDX_DOCUMENTOS_01 on DOCUMENTOS (
FK_EMPRESAS,
FK_CADASTROS
);

grant SELECT,UPDATE,INSERT,DELETE on DOCUMENTOS to PUBLIC;

/*==============================================================*/
/* Table: DOCUMENTOS_CANCELADOS                                 */
/*==============================================================*/
create table DOCUMENTOS_CANCELADOS (
FK_EMPRESAS          VALORI                         not null,
FK_TIPO_DOCUMENTOS   VALORS                         not null,
FK_CADASTROS         VALORI                         not null,
FK_DOCUMENTOS        VALORI                         not null,
FK_GRUPOS_MOVIMENTOS VALORS                         not null,
FK_TIPO_MOVIMENTOS   VALORS                         not null,
DTA_CANC             DATA                           not null,
MOT_CANC             BLOB_TEXTO                     not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_DOCUMENTOS_CANCELADOS primary key (FK_EMPRESAS, FK_TIPO_DOCUMENTOS, FK_CADASTROS, FK_DOCUMENTOS)
);

grant SELECT,UPDATE,INSERT,DELETE on DOCUMENTOS_CANCELADOS to PUBLIC;

/*==============================================================*/
/* Table: DOCUMENTOS_CENTRO_CUSTOS                              */
/*==============================================================*/
create table DOCUMENTOS_CENTRO_CUSTOS (
FK_EMPRESAS          VALORI                         not null,
FK_TIPO_DOCUMENTOS   VALORS                         not null,
FK_CADASTROS         VALORI                         not null,
FK_DOCUMENTOS        VALORI                         not null,
FK_CENTRO_CUSTOS     VALORS                         not null,
FK_DOCUMENTOS_ITENS  VALORI,
PERC_CC              NUMERO_PERCENTUAL              not null
      constraint CKC_PERC_CC_DOCUMENT check (PERC_CC between 0.01 and 100),
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_DOCUMENTOS_CENTRO_CUSTOS primary key (FK_EMPRESAS, FK_TIPO_DOCUMENTOS, FK_CADASTROS, FK_DOCUMENTOS, FK_CENTRO_CUSTOS)
);

/*==============================================================*/
/* Table: DOCUMENTOS_FATURAMENTOS                               */
/*==============================================================*/
create table DOCUMENTOS_FATURAMENTOS (
FK_EMPRESAS          VALORI                         not null,
FK_TIPO_DOCUMENTOS   VALORS                         not null,
FK_CADASTROS         VALORI                         not null,
FK_DOCUMENTOS        VALORI                         not null,
FK_EMPRESAS_PEDIDOS  VALORI,
FK_PEDIDOS           VALORI,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_DOCUMENTOS_FATURAMENTOS primary key (FK_EMPRESAS, FK_TIPO_DOCUMENTOS, FK_CADASTROS, FK_DOCUMENTOS)
);

grant SELECT,UPDATE,INSERT,DELETE on DOCUMENTOS_FATURAMENTOS to PUBLIC;

/*==============================================================*/
/* Table: DOCUMENTOS_FRETES                                     */
/*==============================================================*/
create table DOCUMENTOS_FRETES (
FK_EMPRESAS          VALORI                         not null,
FK_TIPO_DOCUMENTOS   VALORS                         not null,
FK_CADASTROS         VALORI                         not null,
FK_DOCUMENTOS        VALORI                         not null,
FK_VW_TRANSPORTADORAS VALORI                         not null,
FK_TIPO_FRETES       VALORS                         not null,
NUM_CONH             VALORI,
VLR_FRE              NUMERO_MEDIO_4CD,
PLC_VEI              DESCRICAO_10,
QTD_VOL              VALORS,
PES_LIQ              NUMERO_PEQUENO_4CD,
PES_BRU              NUMERO_PEQUENO_4CD,
NUM_VOL              VALORI,
TIPO_VOL             DESCRICAO_20,
MARCA_VOL            DESCRICAO_20,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
OPE_INC              NOME_OPERADOR_DEF,
constraint PK_DOCUMENTOS_FRETES primary key (FK_EMPRESAS, FK_TIPO_DOCUMENTOS, FK_CADASTROS, FK_DOCUMENTOS, FK_VW_TRANSPORTADORAS, FK_TIPO_FRETES)
);

grant SELECT,UPDATE,INSERT,DELETE on DOCUMENTOS_FRETES to PUBLIC;

/*==============================================================*/
/* Table: DOCUMENTOS_ITENS                                      */
/*==============================================================*/
create table DOCUMENTOS_ITENS (
FK_EMPRESAS          VALORI                         not null,
FK_TIPO_DOCUMENTOS   VALORS                         not null,
FK_CADASTROS         VALORI                         not null,
FK_DOCUMENTOS        VALORI                         not null,
PK_DOCUMENTOS_ITENS  VALORS                         not null,
FK_GRUPOS_MOVIMENTOS VALORS                         not null,
FK_TIPO_MOVIMENTOS   VALORS                         not null,
FK_PRODUTOS          VALORI                         not null,
FK_CLASSIFICACAO_FISCAL CODIGO_PRODUTO,
FK_FINANCEIRO_CONTAS VALORI,
FK_UNIDADES          VALORS,
DTA_DOC              DATA_DEF                       not null,
COD_REF              CODIGO_PRODUTO                 not null,
LOT_ITEM             DESCRICAO_10,
QTD_ITEM             NUMERO_PEQUENO_4CD             not null,
VLR_UNIT             NUMERO_PEQUENO_4CD             not null,
DSCT_ITEM            NUMERO_INDICE,
SIT_TRIB             SITUACAO_TRIBUTARIA            not null,
ALQ_ICMS             NUMERO_PERCENTUAL,
ALQ_ICMSS            NUMERO_PERCENTUAL,
ALQ_ISS              NUMERO_PERCENTUAL,
ALQ_IPI              NUMERO_PERCENTUAL,
COD_ICMS_ECF         CODIGO_IMPOSTO_ECF,
COD_ICMSS_ECF        CODIGO_IMPOSTO_ECF,
COD_ISS_ECF          CODIGO_IMPOSTO_ECF,
COD_IPI_ECF          CODIGO_IMPOSTO_ECF,
TOT_ITEM             NUMERO_MEDIO_4CD               not null,
TOT_SEM_DSCT         NUMERO_MEDIO_4CD,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_ALT             DATA_HORA,
OPE_ALT              NOME_OPERADOR,
DTHR_INC             DATA_HORA_DEF,
constraint PK_DOCUMENTOS_ITENS primary key (FK_EMPRESAS, FK_TIPO_DOCUMENTOS, FK_CADASTROS, FK_DOCUMENTOS, PK_DOCUMENTOS_ITENS)
);

grant SELECT,UPDATE,INSERT,DELETE on DOCUMENTOS_ITENS to PUBLIC;

/*==============================================================*/
/* Table: DOCUMENTOS_OBSERVACOES                                */
/*==============================================================*/
create table DOCUMENTOS_OBSERVACOES (
FK_EMPRESAS          VALORI                         not null,
FK_TIPO_DOCUMENTOS   VALORS                         not null,
FK_CADASTROS         VALORI                         not null,
FK_DOCUMENTOS        VALORI                         not null,
OBS_DOC              BLOB_TEXTO,
constraint PK_DOCUMENTOS_OBSERVACOES primary key (FK_EMPRESAS, FK_TIPO_DOCUMENTOS, FK_CADASTROS, FK_DOCUMENTOS)
);

grant SELECT,UPDATE,INSERT,DELETE on DOCUMENTOS_OBSERVACOES to PUBLIC;

/*==============================================================*/
/* Table: DUPLICATAS                                            */
/*==============================================================*/
create table DUPLICATAS (
FK_EMPRESAS          VALORI                         not null,
FK_TIPO_DOCUMENTOS   VALORS                         not null,
FK_CADASTROS         VALORI                         not null,
FK_DOCUMENTOS        VALORI                         not null,
PK_DUPLICATAS        VALORS                         not null,
NUM_BOL              NUMERO_BOLETO,
DTA_VENC             DATA                           not null,
VLR_VENC             NUMERO_MEDIO_4CD,
VLR_ACR_DSCT         NUMERO_PEQUENO_4CD,
VLR_DSP_CBR          NUMERO_PEQUENO_4CD,
VLR_ODSP             NUMERO_PEQUENO_4CD,
DTA_PGTO             DATA,
VLR_PGTO             NUMERO_MEDIO_4CD,
FLAG_CBR_JUR         FLAG_SIM_NAO                   not null,
FLAG_CTB             FLAG_SIM_NAO                   not null,
FLAG_EMIB            FLAG_SIM_NAO                   not null,
FLAG_BAIXA           FLAG_SIM_NAO                   not null,
FLAG_BXAB            FLAG_SIM_NAO                   not null,
FLAG_PRE             FLAG_SIM_NAO                   not null,
FLAG_PARC            FLAG_SIM_NAO                   not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_DUPLICATAS primary key (FK_EMPRESAS, FK_TIPO_DOCUMENTOS, FK_CADASTROS, FK_DOCUMENTOS, PK_DUPLICATAS)
);

/*==============================================================*/
/* Index: IDX_DUPLICATAS_01                                     */
/*==============================================================*/
create asc index IDX_DUPLICATAS_01 on DUPLICATAS (
FK_EMPRESAS,
FK_CADASTROS,
NUM_BOL
);

grant SELECT,UPDATE,INSERT,DELETE on DUPLICATAS to PUBLIC;

/*==============================================================*/
/* Table: DUPLICATAS_PARCIAL                                    */
/*==============================================================*/
create table DUPLICATAS_PARCIAL (
FK_EMPRESAS          VALORI                         not null,
FK_TIPO_DOCUMENTOS   VALORS                         not null,
FK_CADASTROS         VALORI                         not null,
FK_DOCUMENTOS        VALORI                         not null,
FK_DUPLICATAS        VALORS                         not null,
PK_DUPLICATAS_PARCIAL DATA_DEF                       not null,
VLR_PGTO             NUMERO_GRANDE_4CD              not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_DUPLICATAS_PARCIAL primary key (FK_EMPRESAS, FK_TIPO_DOCUMENTOS, FK_CADASTROS, FK_DOCUMENTOS, FK_DUPLICATAS, PK_DUPLICATAS_PARCIAL)
);

grant SELECT,UPDATE,INSERT,DELETE on DUPLICATAS_PARCIAL to PUBLIC;

alter table DOCUMENTOS
   add constraint FK_DOCUMENTOS_CADASTROS foreign key (FK_CADASTROS)
      references CADASTROS (PK_CADASTROS);

alter table DOCUMENTOS
   add constraint FK_DOCUMENTOS_EMPRESAS foreign key (FK_EMPRESAS)
      references EMPRESAS (PK_EMPRESAS);

alter table DOCUMENTOS
   add constraint FK_DOCUMENTOS_GRUPOS_MOVIME foreign key (FK_GRUPOS_MOVIMENTOS)
      references GRUPOS_MOVIMENTOS (PK_GRUPOS_MOVIMENTOS);

alter table DOCUMENTOS
   add constraint FK_DOCUMENTOS_TIPO_DOCUMENTOS foreign key (FK_TIPO_DOCUMENTOS)
      references TIPO_DOCUMENTOS (PK_TIPO_DOCUMENTOS);

alter table DOCUMENTOS_CANCELADOS
   add constraint FK_DOCUMENTOS_CA_DOCUMENTOS foreign key (FK_EMPRESAS, FK_TIPO_DOCUMENTOS, FK_CADASTROS, FK_DOCUMENTOS)
      references DOCUMENTOS (FK_EMPRESAS, FK_TIPO_DOCUMENTOS, FK_CADASTROS, PK_DOCUMENTOS);

alter table DOCUMENTOS_CANCELADOS
   add constraint FK_CANCELAMENTOS_TIPO_MOVIMENTO foreign key (FK_GRUPOS_MOVIMENTOS, FK_TIPO_MOVIMENTOS)
      references TIPO_MOVIMENTOS (FK_GRUPOS_MOVIMENTOS, PK_TIPO_MOVIMENTOS);

alter table DOCUMENTOS_CENTRO_CUSTOS
   add constraint FK_DOCUMENTOS_CE_CENTRO_CUSTOS foreign key (FK_CENTRO_CUSTOS)
      references CENTRO_CUSTOS (PK_CENTRO_CUSTOS);

alter table DOCUMENTOS_CENTRO_CUSTOS
   add constraint FK_DOCUMENTOS_CE_DOCUMENTOS foreign key (FK_EMPRESAS, FK_TIPO_DOCUMENTOS, FK_CADASTROS, FK_DOCUMENTOS)
      references DOCUMENTOS (FK_EMPRESAS, FK_TIPO_DOCUMENTOS, FK_CADASTROS, PK_DOCUMENTOS);

alter table DOCUMENTOS_FATURAMENTOS
   add constraint FK_DOCUMENT_INVOICE_DOCUMENT foreign key (FK_EMPRESAS, FK_TIPO_DOCUMENTOS, FK_CADASTROS, FK_DOCUMENTOS)
      references DOCUMENTOS (FK_EMPRESAS, FK_TIPO_DOCUMENTOS, FK_CADASTROS, PK_DOCUMENTOS);

alter table DOCUMENTOS_FATURAMENTOS
   add constraint FK_DOCUMENT_INVOICE_PEDIDOS foreign key (FK_EMPRESAS_PEDIDOS, FK_PEDIDOS)
      references PEDIDOS (FK_EMPRESAS, PK_PEDIDOS);

alter table DOCUMENTOS_FRETES
   add constraint FK_DOCUMENTOS_FRETES_CADASTROS foreign key (FK_VW_TRANSPORTADORAS)
      references CADASTROS (PK_CADASTROS);

alter table DOCUMENTOS_FRETES
   add constraint FK_DOCUMENTOS_FR_DOCUMENTOS foreign key (FK_EMPRESAS, FK_TIPO_DOCUMENTOS, FK_CADASTROS, FK_DOCUMENTOS)
      references DOCUMENTOS (FK_EMPRESAS, FK_TIPO_DOCUMENTOS, FK_CADASTROS, PK_DOCUMENTOS);

alter table DOCUMENTOS_FRETES
   add constraint FK_DOCUMENTOS_FR_TIPO_FRETES foreign key (FK_TIPO_FRETES)
      references TIPO_FRETES (PK_TIPO_FRETES);

alter table DOCUMENTOS_ITENS
   add constraint FK_DOCUMENTOS_ITENS_PRODUTOS foreign key (FK_PRODUTOS)
      references PRODUTOS (PK_PRODUTOS);

alter table DOCUMENTOS_ITENS
   add constraint FK_DOCUMENTOS_ITM_CLASSIFICACAO foreign key (FK_CLASSIFICACAO_FISCAL)
      references CLASSIFICACAO_FISCAL (PK_CLASSIFICACAO_FISCAL);

alter table DOCUMENTOS_ITENS
   add constraint FK_DOCUMENTOS_IT_DOCUMENTOS foreign key (FK_EMPRESAS, FK_TIPO_DOCUMENTOS, FK_CADASTROS, FK_DOCUMENTOS)
      references DOCUMENTOS (FK_EMPRESAS, FK_TIPO_DOCUMENTOS, FK_CADASTROS, PK_DOCUMENTOS);

alter table DOCUMENTOS_ITENS
   add constraint FK_DOCUMENTOS_IT_FINANCEIRO_CO foreign key (FK_FINANCEIRO_CONTAS)
      references FINANCEIRO_CONTAS (PK_FINANCEIRO_CONTAS);

alter table DOCUMENTOS_ITENS
   add constraint FK_DOCUMENTOS_IT_TIPO_MOVIMENT foreign key (FK_GRUPOS_MOVIMENTOS, FK_TIPO_MOVIMENTOS)
      references TIPO_MOVIMENTOS (FK_GRUPOS_MOVIMENTOS, PK_TIPO_MOVIMENTOS);

alter table DOCUMENTOS_ITENS
   add constraint FK_DOCUMENTOS_IT_UNIDADES foreign key (FK_UNIDADES)
      references UNIDADES (PK_UNIDADES);

alter table DOCUMENTOS_OBSERVACOES
   add constraint FK_DOCUMENTOS_OBS_DOCUMENTOS foreign key (FK_EMPRESAS, FK_TIPO_DOCUMENTOS, FK_CADASTROS, FK_DOCUMENTOS)
      references DOCUMENTOS (FK_EMPRESAS, FK_TIPO_DOCUMENTOS, FK_CADASTROS, PK_DOCUMENTOS);

alter table DUPLICATAS
   add constraint FK_DUPLICATAS_DOCUMENTOS foreign key (FK_EMPRESAS, FK_TIPO_DOCUMENTOS, FK_CADASTROS, FK_DOCUMENTOS)
      references DOCUMENTOS (FK_EMPRESAS, FK_TIPO_DOCUMENTOS, FK_CADASTROS, PK_DOCUMENTOS);

alter table DUPLICATAS_PARCIAL
   add constraint FK_DUPLICATAS_PA_DUPLICATAS foreign key (FK_EMPRESAS, FK_TIPO_DOCUMENTOS, FK_CADASTROS, FK_DOCUMENTOS, FK_DUPLICATAS)
      references DUPLICATAS (FK_EMPRESAS, FK_TIPO_DOCUMENTOS, FK_CADASTROS, FK_DOCUMENTOS, PK_DUPLICATAS);

