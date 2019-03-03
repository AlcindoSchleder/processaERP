/*==============================================================*/
/* Database name:  PROCESSA                                     */
/* DBMS name:      Friebird15x                                  */
/* Created on:     11/9/2006 11:26:29                           */
/*==============================================================*/


create generator FINALIZADORAS;

create generator GRUPOS_MOVIMENTOS;

create generator TIPO_DESCONTOS;

create generator TIPO_FRETES;

create generator TIPO_PAGAMENTOS;

create generator TIPO_PEDIDOS;

create generator TIPO_PRAZO_ENTREGA;

create generator TIPO_STATUS_PEDIDOS;

/*==============================================================*/
/* Table: DESCONTOS                                             */
/*==============================================================*/
create table DESCONTOS (
FK_TIPO_DESCONTOS    VALORS                         not null,
PK_DESCONTOS         VALORS                         not null,
FK_CATEGORIAS        VALORS,
FK_PAISES            VALORI,
FK_ESTADOS           UF,
IDX_DSCT             NUMERO_INDICE,
FLAG_TDSCT           FLAG_TIPO_DESCONTO             not null,
FLAG_DSTQ            FLAG_SIM_NAO                   not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_DESCONTOS primary key (FK_TIPO_DESCONTOS, PK_DESCONTOS)
);

grant SELECT,UPDATE,INSERT,DELETE on DESCONTOS to PUBLIC;

/*==============================================================*/
/* Table: FINALIZADORAS                                         */
/*==============================================================*/
create table FINALIZADORAS (
PK_FINALIZADORAS     VALORS                         not null,
FK_FINALIZADORAS__DB VALORS,
FK_FINALIZADORAS__CR VALORS,
DSC_MPGT             DESCRICAO_30RQ                 not null,
COD_TECLA            VALORS,
FLAG_TRC             FLAG_SIM_NAO                   not null,
FLAG_CLI             FLAG_SIM_NAO                   not null,
FLAG_BNC             FLAG_SIM_NAO                   not null,
FLAG_TEF             FLAG_SIM_NAO                   not null,
FLAG_TFIN            FLAG_TIPO_FINALIZADORA_PGT     not null,
FLAG_BAIXA           FLAG_SIM_NAO                   not null,
FLAG_TRF             FLAG_SIM_NAO                   not null,
FLAG_EST             FLAG_SIM_NAO                   not null,
FLAG_GSLD_CTA        FLAG_SIM_NAO                   not null,
FLAG_GSLD_FIN        FLAG_SIM_NAO                   not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_FINALIZADORAS primary key (PK_FINALIZADORAS)
);

alter table CLIENTES
   add constraint FK_FINALIZADORAS_CLIENTES foreign key (FK_FINALIZADORAS)
      references FINALIZADORAS (PK_FINALIZADORAS);

grant SELECT,UPDATE,INSERT,DELETE on FINALIZADORAS to PUBLIC;

/*==============================================================*/
/* Table: GRUPOS_MOVIMENTOS                                     */
/*==============================================================*/
create table GRUPOS_MOVIMENTOS (
PK_GRUPOS_MOVIMENTOS VALORS                         not null,
DSC_GMOV             DESCRICAO_30RQ                 not null,
FLAG_ES              FLAG_ENTRADA_SAIDA             not null,
FLAG_DEV             FLAG_SIM_NAO                   not null,
FLAG_ESTQ            FLAG_SIM_NAO                   not null,
FLAG_GRNT            FLAG_TIPO_GARANTIA             not null,
FLAG_DSPA            FLAG_SIM_NAO                   not null,
FLAG_COD             FLAG_TIPO_CODIGO_PRODUTO       not null,
FLAG_ORGM            FLAG_ORIGEM_DESTINO            not null,
FLAG_DSTI            FLAG_ORIGEM_DESTINO            not null,
FLAG_GFIN            FLAG_SIM_NAO                   not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_GRUPOS_MOVIMENTOS primary key (PK_GRUPOS_MOVIMENTOS)
);

grant DELETE,INSERT,UPDATE,SELECT on GRUPOS_MOVIMENTOS to PUBLIC;

/*==============================================================*/
/* Table: PARAMETROS_PED                                        */
/*==============================================================*/
create table PARAMETROS_PED (
FK_EMPRESAS          VALORI                         not null,
FK_STATUS_PEDIDOS    VALORS,
FK_TIPO_PRAZO_ENTREGA VALORS,
PRZ_VAL_ORC          VALORS                         default 1,
PRZ_ENTR             VALORS                         default 0 not null,
FLAG_ITM_DSCT        FLAG_SIM_NAO                   not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PARAMETROS_PED primary key (FK_EMPRESAS)
);

grant SELECT,UPDATE,INSERT,DELETE on PARAMETROS_PED to PUBLIC;

/*==============================================================*/
/* Table: PEDIDOS                                               */
/*==============================================================*/
create table PEDIDOS (
FK_EMPRESAS          VALORI                         not null,
PK_PEDIDOS           VALORI                         not null,
FK_TIPO_MOVIMENTOS   VALORS                         not null,
FK_CADASTROS         VALORI                         not null,
FK_TIPO_PAGAMENTOS   VALORS,
FK_TIPO_DESCONTOS    VALORS,
FK_VW_VENDEDORES     VALORI,
FK_VW_REPRESENTANTES VALORI,
FK_VW_TRANSPORTADORAS VALORI,
FK_VW_AGENTE         VALORI,
FK_PORTOS_EMB        VALORS,
FK_PORTOS_DST        VALORS,
FK_ORDEM_COMPRA      VALORI,
FK_TABELA_PRECOS     VALORS,
FK_TIPO_STATUS_PEDIDOS VALORS,
FK_TIPO_PRAZO_ENTREGA VALORS,
FK_GRUPOS_MOVIMENTOS VALORS,
KC_PEDIDOS_HISTORICOS VALORS,
KC_PEDIDOS_MENSAGENS VALORS,
KC_PEDIDOS_DESCONTOS VALORS,
MES_PREV_ENTR        VALORS                        
      constraint CKC_MES_PREV_ENTR_PEDIDOS check (MES_PREV_ENTR is null or (MES_PREV_ENTR between 01 and 12)),
ANO_PREV_ENTR        VALORS,
NUM_EXTR             DESCRICAO_20,
NUM_PRO_FORMA        VALORI,
DTA_PED              DATA_DEF                       not null,
DTA_RECB             DATA,
DTA_FAT              DATA,
DTA_LIB              DATA,
DTA_LIQ              DATA,
DTA_CANC             DATA,
DTA_ENTR             DATA,
DTA_BAS              DATA,
LST_PRZ              DESCRICAO_50,
FLAG_ENTR_PARC       FLAG_SIM_NAO                   not null,
FLAG_VINC_PED        FLAG_SIM_NAO                   not null,
FLAG_PEND            FLAG_SIM_NAO                   not null,
FLAG_CPRVE           FLAG_SIM_NAO                   not null,
FLAG_IMP             FLAG_SIM_NAO                   not null,
FLAG_PROD            FLAG_SIM_NAO                   not null,
FLAG_EDRT_RDSP       FLAG_SIM_NAO                   not null,
FLAG_DTABAS          FLAG_DATA_BASE                 not null,
QTD_DUPL             VALORS,
QTD_ITEM             VALORS,
VLR_FRET             NUMERO_PEQUENO_4CD,
VLR_SEG              NUMERO_PEQUENO_4CD,
VLR_ENTR             NUMERO_PEQUENO_4CD,
DSP_ACES             NUMERO_PEQUENO_4CD,
VLR_ACR_DSCT         NUMERO_PEQUENO_4CD,
SUB_TOT              NUMERO_GRANDE_4CD,
TOT_PED              NUMERO_GRANDE_4CD,
QTD_VOL              VALORS,
PES_LIQ              NUMERO_PEQUENO_4CD,
PES_BRU              NUMERO_PEQUENO_4CD,
NUM_VOL              VALORS,
TIPO_VOL             DESCRICAO_20,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PEDIDOS primary key (FK_EMPRESAS, PK_PEDIDOS)
);

/*==============================================================*/
/* Index: IDX_PEDIDOS01                                         */
/*==============================================================*/
create asc index IDX_PEDIDOS01 on PEDIDOS (
FK_EMPRESAS,
FK_CADASTROS,
PK_PEDIDOS
);

/*==============================================================*/
/* Index: IDX_PEDIDOS02                                         */
/*==============================================================*/
create asc index IDX_PEDIDOS02 on PEDIDOS (
FK_CADASTROS,
NUM_EXTR,
FK_EMPRESAS
);

grant DELETE,INSERT,UPDATE,SELECT on PEDIDOS to PUBLIC;

/*==============================================================*/
/* Table: PEDIDOS_CENTRO_CUSTOS                                 */
/*==============================================================*/
create table PEDIDOS_CENTRO_CUSTOS (
FK_EMPRESAS          VALORI                         not null,
FK_PEDIDOS           VALORI                         not null,
FK_CENTRO_CUSTOS     VALORS                         not null,
FK_PEDIDOS_ITENS     VALORS,
PERC_CC              NUMERO_PERCENTUAL              not null
      constraint CKC_PERC_CC_PEDIDOS_ check (PERC_CC between 0.01 and 100),
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PEDIDOS_CENTRO_CUSTOS primary key (FK_EMPRESAS, FK_PEDIDOS, FK_CENTRO_CUSTOS)
);

/*==============================================================*/
/* Table: PEDIDOS_DESCONTOS                                     */
/*==============================================================*/
create table PEDIDOS_DESCONTOS (
FK_EMPRESAS          VALORI                         not null,
FK_PEDIDOS           VALORI                         not null,
PK_PEDIDOS_DESCONTOS VALORS                         not null,
DSC_DSCT             DESCRICAO_30RQ                 not null,
IDX_DSCT             NUMERO_PEQUENO_4CD             not null,
FLAG_TDSCT           FLAG_TIPO_DESCONTO             not null,
FLAG_DSTQ            FLAG_SIM_NAO                   not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PEDIDOS_DESCONTOS primary key (FK_EMPRESAS, FK_PEDIDOS, PK_PEDIDOS_DESCONTOS)
);

grant SELECT,UPDATE,INSERT,DELETE on PEDIDOS_DESCONTOS to PUBLIC;

/*==============================================================*/
/* Table: PEDIDOS_ENTREGA                                       */
/*==============================================================*/
create table PEDIDOS_ENTREGA (
FK_EMPRESAS          VALORI                         not null,
FK_PEDIDOS           VALORI                         not null,
UF_ENTR              UF                             not null,
MUN_ENTR             VALORI                         not null,
END_ENTR             BLOB_TEXTO                     not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PEDIDOS_ENTREGA primary key (FK_EMPRESAS, FK_PEDIDOS)
);

grant DELETE,INSERT,UPDATE,SELECT on PEDIDOS_ENTREGA to PUBLIC;

/*==============================================================*/
/* Table: PEDIDOS_FINALIZADORAS                                 */
/*==============================================================*/
create table PEDIDOS_FINALIZADORAS (
FK_EMPRESAS          VALORI                         not null,
FK_TIPO_PEDIDOS      VALORS                         not null,
FK_PEDIDOS           VALORI                         not null,
FK_FINALIZADORAS     VALORS                         not null,
VLR_FIN              NUMERO_MEDIO_4CD               not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PEDIDOS_FINALIZADORAS primary key (FK_EMPRESAS, FK_TIPO_PEDIDOS, FK_PEDIDOS, FK_FINALIZADORAS)
);

grant SELECT,UPDATE,INSERT,DELETE on PEDIDOS_FINALIZADORAS to PUBLIC;

/*==============================================================*/
/* Table: PEDIDOS_HISTORICOS                                    */
/*==============================================================*/
create table PEDIDOS_HISTORICOS (
FK_EMPRESAS          VALORI                         not null,
FK_PEDIDOS           VALORI                         not null,
PK_PEDIDOS_HISTORICOS VALORS                         not null,
FK_TIPO_STATUS_PEDIDOS VALORS                         not null,
FLAG_TSTT            FLAG                           not null,
FLAG_BXASTT          FLAG_SIM_NAO                   not null,
DSC_HIST             DESCRICAO_100RQ                not null,
DTHR_HIST            DATA_HORA_DEF                  not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PEDIDOS_HISTORICOS primary key (FK_EMPRESAS, FK_PEDIDOS, PK_PEDIDOS_HISTORICOS)
);

grant SELECT,UPDATE,INSERT,DELETE on PEDIDOS_HISTORICOS to PUBLIC;

/*==============================================================*/
/* Table: PEDIDOS_ITENS                                         */
/*==============================================================*/
create table PEDIDOS_ITENS (
FK_EMPRESAS          VALORI                         not null,
FK_PEDIDOS           VALORI                         not null,
PK_PEDIDOS_ITENS     VALORS                         not null,
FK_TABELA_PRECOS     VALORS,
FK_GRUPOS_MOVIMENTOS VALORS,
FK_TIPO_MOVIMENTOS   VALORS                         not null,
FK_UNIDADES          VALORS,
FK_CARGAS_PRODUCAO   VALORI,
FK_PRODUTOS          VALORI                         not null,
FK_ALMOXARIFADOS     VALORS,
FK_LOTACOES          VALORS,
FK_FINANCEIRO_CONTAS VALORI,
REF_PRODUTO          CODIGO_PRODUTO,
COD_CFOP             NATUREZA_DA_OPERACAO           not null,
LOT_ITEM             DESCRICAO_10,
QTD_ITEM             NUMERO_PEQUENO_4CD             not null,
VLR_TAB              NUMERO_PEQUENO_4CD             not null,
VLR_UNIT             NUMERO_PEQUENO_4CD             not null,
SUB_TOT              NUMERO_MEDIO_4CD,
VLR_ACR_DSCT         NUMERO_PEQUENO_4CD,
TOT_ITEM             NUMERO_MEDIO_4CD               not null,
SIT_TRIB             SITUACAO_TRIBUTARIA            not null,
ALQ_ISS              NUMERO_PERCENTUAL,
ALQ_ICMS             NUMERO_PERCENTUAL,
ALQ_ICMSS            NUMERO_PERCENTUAL,
ALQ_IPI              NUMERO_PERCENTUAL,
ALQ_OTR              NUMERO_PERCENTUAL,
COD_ISS_ECF          CODIGO_IMPOSTO_ECF,
COD_ICMS_ECF         CODIGO_IMPOSTO_ECF,
COD_ICMSS_ECF        CODIGO_IMPOSTO_ECF,
COD_IPI_ECF          CODIGO_IMPOSTO_ECF,
COD_OTR_ECF          VALORS,
FLAG_PRM             FLAG_SIM_NAO                   not null,
FLAG_PEND            FLAG_SIM_NAO                   not null,
FLAG_BXASTT          FLAG_SIM_NAO                   not null,
FLAG_SRV             FLAG_SIM_NAO                   not null,
FLAG_CONF            FLAG_SIM_NAO                   not null,
DTA_FAT              DATA,
DTA_LIQ              DATA,
NUM_EXT              DESCRICAO_20,
QTD_CONF             VALORS                         default 0,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_ALT             DATA_HORA,
OPE_ALT              NOME_OPERADOR,
DTHR_INC             DATA_HORA_DEF,
constraint PK_PEDIDOS_ITENS primary key (FK_EMPRESAS, FK_PEDIDOS, PK_PEDIDOS_ITENS)
);

grant DELETE,INSERT,UPDATE,SELECT on PEDIDOS_ITENS to PUBLIC;

/*==============================================================*/
/* Table: PEDIDOS_ITENS_CONF                                    */
/*==============================================================*/
create table PEDIDOS_ITENS_CONF (
FK_EMPRESAS          VALORI                         not null,
FK_PEDIDOS           VALORI                         not null,
FK_PEDIDOS_ITENS     VALORS                         not null,
PK_PEDIDOS_ITENS_CONF VALORS                         not null,
FK_PRODUTOS          VALORI                         not null,
FK_COMPONENTES       VALORS,
FK_ACABAMENTOS       VALORS,
FK_TIPO_REFERENCIAS  VALORS,
FK_INSUMOS           VALORI,
COD_REF              CODIGO_PRODUTO,
VLR_ITM              NUMERO_MEDIO_4CD,
QTD_COMP             VALORS                         not null,
QTD_COMP_TOT         VALORS                         not null,
QTD_INS              NUMERO_PEQUENO_4CD,
FLAG_FRNCLI          FLAG_SIM_NAO                   not null,
FLAG_PEND            FLAG_SIM_NAO                   not null,
FLAG_CNTR            FLAG_SIM_NAO                   not null,
FLAG_BXASTT          FLAG_SIM_NAO                   not null,
FK_TIPO_DOCUMENTOS   VALORS,
NUM_DOC_LIB          VALORI,
PER_DSCT_INS         NUMERO_PERCENTUAL,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PEDIDOS_ITENS_CONF primary key (FK_EMPRESAS, FK_PEDIDOS, FK_PEDIDOS_ITENS, PK_PEDIDOS_ITENS_CONF)
);

grant SELECT,UPDATE,INSERT,DELETE on PEDIDOS_ITENS_CONF to PUBLIC;

/*==============================================================*/
/* Table: PEDIDOS_ITENS_IMPOSTOS                                */
/*==============================================================*/
create table PEDIDOS_ITENS_IMPOSTOS (
FK_EMPRESAS          VALORI                         not null,
FK_PEDIDOS           VALORI                         not null,
FK_PEDIDOS_ITENS     VALORS                         not null,
FK_TIPO_IMPOSTOS     VALORS                         not null,
FK_FINANCEIRO_CONTAS VALORI                         not null,
VLR_IMPST            NUMERO_PEQUENO_4CD             not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PEDIDOS_ITENS_IMPOSTOS primary key (FK_EMPRESAS, FK_PEDIDOS, FK_PEDIDOS_ITENS, FK_TIPO_IMPOSTOS, FK_FINANCEIRO_CONTAS)
);

grant SELECT,UPDATE,INSERT,DELETE on PEDIDOS_ITENS_IMPOSTOS to PUBLIC;

/*==============================================================*/
/* Table: PEDIDOS_MENSAGENS                                     */
/*==============================================================*/
create table PEDIDOS_MENSAGENS (
FK_EMPRESAS          VALORI                         not null,
FK_PEDIDOS           VALORI                         not null,
PK_PEDIDOS_MENSAGENS VALORI                         not null,
FK_DEPARTAMENTOS     VALORS                         not null,
DTHR_MSG             DATA_HORA_DEF                  not null,
DTHR_RCBM            DATA_HORA,
TEXT_MSG             BLOB_TEXTO                     not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PEDIDOS_MENSAGENS primary key (FK_EMPRESAS, FK_PEDIDOS, PK_PEDIDOS_MENSAGENS)
);

grant DELETE,INSERT,UPDATE,SELECT on PEDIDOS_MENSAGENS to PUBLIC;

/*==============================================================*/
/* Table: PEDIDOS_PARCELAS                                      */
/*==============================================================*/
create table PEDIDOS_PARCELAS (
FK_EMPRESAS          VALORI                         not null,
FK_PEDIDOS           VALORI                         not null,
PK_PEDIDOS_PARCELAS  DATA                           not null,
NUM_PARC             VALORS                         not null,
VLR_PARC             NUMERO_MEDIO_4CD               not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PEDIDOS_PARCELAS primary key (FK_EMPRESAS, FK_PEDIDOS, PK_PEDIDOS_PARCELAS)
);

grant SELECT,UPDATE,INSERT,DELETE on PEDIDOS_PARCELAS to PUBLIC;

/*==============================================================*/
/* Table: PEDIDOS_PENDENCIAS                                    */
/*==============================================================*/
create table PEDIDOS_PENDENCIAS (
FK_EMPRESAS          VALORI                         not null,
FK_PEDIDOS           VALORI                         not null,
FK_PEDIDOS_ITEMS     VALORS                         not null,
FK_PRODUTOS          VALORI                         not null,
QTD_PEND             NUMERO_PEQUENO_4CD,
VLR_UNIT             NUMERO_PEQUENO_4CD,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PEDIDOS_PENDENCIAS primary key (FK_EMPRESAS, FK_PEDIDOS, FK_PEDIDOS_ITEMS, FK_PRODUTOS)
);

grant DELETE,UPDATE,INSERT,SELECT on PEDIDOS_PENDENCIAS to PUBLIC;

/*==============================================================*/
/* Table: PEDIDOS_VINCULOS                                      */
/*==============================================================*/
create table PEDIDOS_VINCULOS (
FK_EMPRESAS          VALORI                         not null,
FK_TIPO_PEDIDOS      VALORS                         not null,
FK_PEDIDOS           VALORI                         not null,
FK_EMPRESAS_VINC     VALORI                         not null,
FK_TIPO_PEDIDOS_VINC VALORS                         not null,
FK_PEDIDOS_VINC      VALORI                         not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PEDIDOS_VINCULOS primary key (FK_EMPRESAS, FK_TIPO_PEDIDOS, FK_PEDIDOS, FK_EMPRESAS_VINC, FK_TIPO_PEDIDOS_VINC, FK_PEDIDOS_VINC)
);

grant SELECT,UPDATE,INSERT,DELETE on PEDIDOS_VINCULOS to PUBLIC;

/*==============================================================*/
/* Table: TIPO_DESCONTOS                                        */
/*==============================================================*/
create table TIPO_DESCONTOS (
PK_TIPO_DESCONTOS    VALORS                         not null,
FK_GRUPOS_MOVIMENTOS VALORS,
DSC_TDSCT            DESCRICAO_30RQ                 not null,
KC_DESCONTOS         VALORS,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_TIPO_DESCONTOS primary key (PK_TIPO_DESCONTOS)
);

alter table PRODUTOS_FORNECEDORES
   add constraint FK_PRODUTOS_FORN_TIPO_DESCONTO foreign key (FK_TIPO_DESCONTOS)
      references TIPO_DESCONTOS (PK_TIPO_DESCONTOS);

alter table CLIENTES
   add constraint FK_CLIENTES_TIPO_DESCONTOS foreign key (FK_TIPO_DESCONTOS)
      references TIPO_DESCONTOS (PK_TIPO_DESCONTOS);

grant SELECT,UPDATE,INSERT,DELETE on TIPO_DESCONTOS to PUBLIC;

/*==============================================================*/
/* Table: TIPO_FRETES                                           */
/*==============================================================*/
create table TIPO_FRETES (
PK_TIPO_FRETES       VALORS                         not null,
FK_TIPO_PAGAMENTOS   VALORS                         not null,
FK_FINANCEIRO_CONTAS VALORI,
DSC_TPFRE            DESCRICAO_30RQ                 not null,
FLAG_TP_FRE          FLAG_TIPO_FRETE                not null,
FLAG_FIN             FLAG_SIM_NAO                   not null,
FLAG_ACU             FLAG_SIM_NAO                   not null,
FLAG_NF              FLAG_SIM_NAO                   not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_TIPO_FRETES primary key (PK_TIPO_FRETES)
);

grant DELETE,INSERT,UPDATE,SELECT on TIPO_FRETES to PUBLIC;

/*==============================================================*/
/* Table: TIPO_MOVIMENTOS                                       */
/*==============================================================*/
create table TIPO_MOVIMENTOS (
FK_GRUPOS_MOVIMENTOS VALORS                         not null,
PK_TIPO_MOVIMENTOS   VALORS                         not null,
DSC_TMOV             DESCRICAO_30RQ                 not null,
FLAG_EXP             FLAG_SIM_NAO                   not null,
FLAG_CNS             FLAG_SIM_NAO                   not null,
FLAG_LDV             FLAG_SIM_NAO                   not null,
NAT_OPE_DE           NATUREZA_DA_OPERACAO,
NAT_OPE_FE           NATUREZA_DA_OPERACAO,
NAT_OPE_EX           NATUREZA_DA_OPERACAO,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_TIPO_MOVIMENTOS primary key (FK_GRUPOS_MOVIMENTOS, PK_TIPO_MOVIMENTOS)
);

grant SELECT,INSERT,UPDATE,DELETE on TIPO_MOVIMENTOS to PUBLIC;

/*==============================================================*/
/* Table: TIPO_PAGAMENTOS                                       */
/*==============================================================*/
create table TIPO_PAGAMENTOS (
PK_TIPO_PAGAMENTOS   VALORS                         not null,
FK_GRUPOS_MOVIMENTOS VALORS                         not null,
FK_TIPO_DESCONTOS    VALORS,
FK_FINANCEIRO_CONTAS VALORI,
DSC_TPG              DESCRICAO_50RQ                 not null,
LST_PRZ              DESCRICAO_50,
FLAG_SEN             FLAG_SIM_NAO                   not null,
FLAG_TINT            FLAG_PARCELA                   not null,
FLAG_TVDA            FLAG_TIPO_VENDA                not null,
FLAG_ALT_LST         FLAG_SIM_NAO                   not null,
FLAG_DATA_BASE       FLAG_DATA_BASE                 not null,
FLAG_DEF_USER        FLAG_SIM_NAO                   not null,
QTD_PAR              VALORS,
INTRV_TAB            VALORS,
IND_TPGT             NUMERO_INDICE,
PER_JUR              NUMERO_PERCENTUAL,
DSCT_TPG             NUMERO_INDICE,
IND_ENTR             NUMERO_INDICE,
QTD_ENTR             VALORS,
PER_ENTR             NUMERO_PERCENTUAL,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_TIPO_PAGAMENTOS primary key (PK_TIPO_PAGAMENTOS)
);

alter table CLIENTES
   add constraint FK_TIPO_PAGAMENTOS_CLIENTES foreign key (FK_TIPO_PAGAMENTOS)
      references TIPO_PAGAMENTOS (PK_TIPO_PAGAMENTOS);

grant SELECT,UPDATE,INSERT,DELETE on TIPO_PAGAMENTOS to PUBLIC;

/*==============================================================*/
/* Table: TIPO_PRAZO_ENTREGA                                    */
/*==============================================================*/
create table TIPO_PRAZO_ENTREGA (
PK_TIPO_PRAZO_ENTREGA VALORS                         not null,
DSC_PRZE             DESCRICAO_30RQ                 not null,
QTD_PRV              VALORS,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_TIPO_PRAZO_ENTREGA primary key (PK_TIPO_PRAZO_ENTREGA)
);

alter table CLIENTES
   add constraint FK_TIPO_PRAZO_ENTREGA_CLIENTES foreign key (FK_TIPO_PRAZO_ENTREGA)
      references TIPO_PRAZO_ENTREGA (PK_TIPO_PRAZO_ENTREGA);

grant SELECT,UPDATE,INSERT,DELETE on TIPO_PRAZO_ENTREGA to PUBLIC;

/*==============================================================*/
/* Table: TIPO_STATUS_PEDIDOS                                   */
/*==============================================================*/
create table TIPO_STATUS_PEDIDOS (
PK_TIPO_STATUS_PEDIDOS VALORS                         not null,
FK_GRUPOS_MOVIMENTOS VALORS,
FK_TIPO_MOVIM_ESTQ   VALORS,
FK_FINANCEIRO_CENARIOS VALORS,
FK_TIPO_DOCUMENTOS   VALORS                         not null,
DSC_STT              DESCRICAO_20RQ                 not null,
QTD_DAYS_NEXT        VALORS,
FLAG_OPEN            FLAG_SIM_NAO                   not null,
FLAG_RECB            FLAG_SIM_NAO                   not null,
FLAG_LIB             FLAG_SIM_NAO                   not null,
FLAG_CANC            FLAG_SIM_NAO                   not null,
FLAG_PROD            FLAG_SIM_NAO                   not null,
FLAG_FAT             FLAG_SIM_NAO                   not null,
FLAG_LIQ             FLAG_SIM_NAO                   not null,
FLAG_TPED            FLAG_TIPO_PEDIDOS              not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_TIPO_STATUS_PEDIDOS primary key (PK_TIPO_STATUS_PEDIDOS)
);

grant SELECT,UPDATE,INSERT,DELETE on TIPO_STATUS_PEDIDOS to PUBLIC;

/*==============================================================*/
/* Table: VINCULO_TPGTO_FINALIZ                                 */
/*==============================================================*/
create table VINCULO_TPGTO_FINALIZ (
FK_FINALIZADORAS     VALORS                         not null,
FK_TIPO_PAGAMENTOS   VALORS                         not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_VINCULO_TPGTO_FINALIZ primary key (FK_FINALIZADORAS, FK_TIPO_PAGAMENTOS)
);

grant DELETE,INSERT,UPDATE,SELECT on VINCULO_TPGTO_FINALIZ to PUBLIC;

alter table DESCONTOS
   add constraint FK_DESCONTOS_CATEGORIAS foreign key (FK_CATEGORIAS)
      references CATEGORIAS (PK_CATEGORIAS);

alter table DESCONTOS
   add constraint FK_DESCONTOS_ESTADOS foreign key (FK_PAISES, FK_ESTADOS)
      references ESTADOS (FK_PAISES, PK_ESTADOS);

alter table DESCONTOS
   add constraint FK_DESCONTOS_TIPO_DESCONTO foreign key (FK_TIPO_DESCONTOS)
      references TIPO_DESCONTOS (PK_TIPO_DESCONTOS);

alter table FINALIZADORAS
   add constraint FK_FINALIZADORAS_CREDITO foreign key (FK_FINALIZADORAS__CR)
      references FINALIZADORAS (PK_FINALIZADORAS);

alter table FINALIZADORAS
   add constraint FK_FINALIZADORAS_DEBITO foreign key (FK_FINALIZADORAS__DB)
      references FINALIZADORAS (PK_FINALIZADORAS);

alter table PARAMETROS_PED
   add constraint FK_PARAMETROS_PES_EMPRESAS foreign key (FK_EMPRESAS)
      references EMPRESAS (PK_EMPRESAS);

alter table PARAMETROS_PED
   add constraint FK_PARAMETROS_PE_TIPO_PRAZO_EN foreign key (FK_TIPO_PRAZO_ENTREGA)
      references TIPO_PRAZO_ENTREGA (PK_TIPO_PRAZO_ENTREGA);

alter table PARAMETROS_PED
   add constraint FK_PARAMETROS_PE_TIPO_STATUS_P foreign key (FK_STATUS_PEDIDOS)
      references TIPO_STATUS_PEDIDOS (PK_TIPO_STATUS_PEDIDOS);

alter table PEDIDOS
   add constraint FK_PEDIDOS_EMPRESAS foreign key (FK_EMPRESAS)
      references EMPRESAS (PK_EMPRESAS);

alter table PEDIDOS
   add constraint FK_PEDIDOS_CADASTROS foreign key (FK_CADASTROS)
      references CADASTROS (PK_CADASTROS);

alter table PEDIDOS
   add constraint FK_PEDIDOS_REPRESENTANTES foreign key (FK_VW_REPRESENTANTES)
      references CADASTROS (PK_CADASTROS);

alter table PEDIDOS
   add constraint FK_PEDIDOS_TABELA_PRECOS foreign key (FK_TABELA_PRECOS)
      references TABELA_PRECOS (PK_TABELA_PRECOS);

alter table PEDIDOS
   add constraint FK_PEDIDOS_TIPO_DESCONTO foreign key (FK_TIPO_DESCONTOS)
      references TIPO_DESCONTOS (PK_TIPO_DESCONTOS);

alter table PEDIDOS
   add constraint FK_PEDIDOS_TIPO_MOVIMENTOS foreign key (FK_GRUPOS_MOVIMENTOS, FK_TIPO_MOVIMENTOS)
      references TIPO_MOVIMENTOS (FK_GRUPOS_MOVIMENTOS, PK_TIPO_MOVIMENTOS);

alter table PEDIDOS
   add constraint FK_PEDIDOS_TIPO_PAGAMENT foreign key (FK_TIPO_PAGAMENTOS)
      references TIPO_PAGAMENTOS (PK_TIPO_PAGAMENTOS);

alter table PEDIDOS
   add constraint FK_PEDIDOS_TIPO_PRAZO_EN foreign key (FK_TIPO_PRAZO_ENTREGA)
      references TIPO_PRAZO_ENTREGA (PK_TIPO_PRAZO_ENTREGA);

alter table PEDIDOS
   add constraint FK_PEDIDOS_TIPO_STATUS_PEDIDOS foreign key (FK_TIPO_STATUS_PEDIDOS)
      references TIPO_STATUS_PEDIDOS (PK_TIPO_STATUS_PEDIDOS);

alter table PEDIDOS
   add constraint FK_PEDIDOS_TRANSPORTADORAS foreign key (FK_VW_TRANSPORTADORAS)
      references CADASTROS (PK_CADASTROS);

alter table PEDIDOS
   add constraint FK_PEDIDOS_VENDEDORES foreign key (FK_VW_VENDEDORES)
      references CADASTROS (PK_CADASTROS);

alter table PEDIDOS_CENTRO_CUSTOS
   add constraint FK_PEDIDOS_CENTR_CENTRO_CUSTOS foreign key (FK_CENTRO_CUSTOS)
      references CENTRO_CUSTOS (PK_CENTRO_CUSTOS);

alter table PEDIDOS_CENTRO_CUSTOS
   add constraint FK_PEDIDOS_CENTR_PEDIDOS foreign key (FK_EMPRESAS, FK_PEDIDOS)
      references PEDIDOS (FK_EMPRESAS, PK_PEDIDOS);

alter table PEDIDOS_DESCONTOS
   add constraint FK_PEDIDOS_DESCO_PEDIDOS foreign key (FK_EMPRESAS, FK_PEDIDOS)
      references PEDIDOS (FK_EMPRESAS, PK_PEDIDOS)
      on delete cascade
      on update cascade;

alter table PEDIDOS_ENTREGA
   add constraint FK_PEDIDOS_ENTRE_PEDIDOS foreign key (FK_EMPRESAS, FK_PEDIDOS)
      references PEDIDOS (FK_EMPRESAS, PK_PEDIDOS)
      on delete cascade
      on update cascade;

alter table PEDIDOS_FINALIZADORAS
   add constraint FK_PEDIDOS_FINAL_FINALIZADORAS foreign key (FK_FINALIZADORAS)
      references FINALIZADORAS (PK_FINALIZADORAS);

alter table PEDIDOS_FINALIZADORAS
   add constraint FK_PEDIDOS_FINAL_PEDIDOS foreign key (FK_EMPRESAS, FK_PEDIDOS)
      references PEDIDOS (FK_EMPRESAS, PK_PEDIDOS);

alter table PEDIDOS_HISTORICOS
   add constraint FK_PEDIDOS_HISTORICOS_PEDIDOS foreign key (FK_EMPRESAS, FK_PEDIDOS)
      references PEDIDOS (FK_EMPRESAS, PK_PEDIDOS)
      on delete cascade
      on update cascade;

alter table PEDIDOS_HISTORICOS
   add constraint FK_PEDIDOS_HISTO_TIPO_STATUS_P foreign key (FK_TIPO_STATUS_PEDIDOS)
      references TIPO_STATUS_PEDIDOS (PK_TIPO_STATUS_PEDIDOS);

alter table PEDIDOS_ITENS
   add constraint FK_PEDIDOS_ITENS_CARGAS_PRODUC foreign key (FK_EMPRESAS, FK_CARGAS_PRODUCAO)
      references CARGAS_PRODUCAO (FK_EMPRESAS, PK_CARGAS_PRODUCAO);

alter table PEDIDOS_ITENS
   add constraint FK_PEDIDOS_ITENS_FINANCEIRO_CO foreign key (FK_FINANCEIRO_CONTAS)
      references FINANCEIRO_CONTAS (PK_FINANCEIRO_CONTAS);

alter table PEDIDOS_ITENS
   add constraint FK_PEDIDOS_ITENS_LOTACOES foreign key (FK_EMPRESAS, FK_LOTACOES, FK_ALMOXARIFADOS)
      references LOTACOES (FK_EMPRESAS, PK_LOTACOES, FK_ALMOXARIFADOS);

alter table PEDIDOS_ITENS
   add constraint FK_PEDIDOS_ITENS_PRODUTOS foreign key (FK_PRODUTOS)
      references PRODUTOS (PK_PRODUTOS);

alter table PEDIDOS_ITENS
   add constraint FK_PEDIDOS_ITENS_TABELA_PRECOS foreign key (FK_TABELA_PRECOS)
      references TABELA_PRECOS (PK_TABELA_PRECOS);

alter table PEDIDOS_ITENS
   add constraint FK_PEDIDOS_ITENS_TIPO_MOVIMENT foreign key (FK_GRUPOS_MOVIMENTOS, FK_TIPO_MOVIMENTOS)
      references TIPO_MOVIMENTOS (FK_GRUPOS_MOVIMENTOS, PK_TIPO_MOVIMENTOS);

alter table PEDIDOS_ITENS
   add constraint FK_PEDIDOS_ITENS_UNIDADES foreign key (FK_UNIDADES)
      references UNIDADES (PK_UNIDADES);

alter table PEDIDOS_ITENS
   add constraint FK_PEDIDOS_PEDIDOS_ITENS foreign key (FK_EMPRESAS, FK_PEDIDOS)
      references PEDIDOS (FK_EMPRESAS, PK_PEDIDOS)
       
      on update cascade;

alter table PEDIDOS_ITENS_CONF
   add constraint FK_PEDIDOS_ITENS_CONF_PRODUTOS foreign key (FK_PRODUTOS)
      references PRODUTOS (PK_PRODUTOS);

alter table PEDIDOS_ITENS_CONF
   add constraint FK_PEDIDOS_ITENS_PEDIDOS_ITENS foreign key (FK_EMPRESAS, FK_PEDIDOS, FK_PEDIDOS_ITENS)
      references PEDIDOS_ITENS (FK_EMPRESAS, FK_PEDIDOS, PK_PEDIDOS_ITENS)
      on delete cascade
      on update cascade;

alter table PEDIDOS_ITENS_CONF
   add constraint FK_PEDIDOS_ITENS_REFERENCIAS foreign key (FK_EMPRESAS, FK_PRODUTOS, FK_COMPONENTES, FK_ACABAMENTOS, FK_TIPO_REFERENCIAS)
      references REFERENCIAS (FK_EMPRESAS, FK_PRODUTOS, FK_COMPONENTES, FK_ACABAMENTOS, FK_TIPO_REFERENCIAS);

alter table PEDIDOS_ITENS_IMPOSTOS
   add constraint FK_PEDIDOS_ITENS_PEDIDOS_IMPST foreign key (FK_EMPRESAS, FK_PEDIDOS, FK_PEDIDOS_ITENS)
      references PEDIDOS_ITENS (FK_EMPRESAS, FK_PEDIDOS, PK_PEDIDOS_ITENS)
      on delete cascade
      on update cascade;

alter table PEDIDOS_ITENS_IMPOSTOS
   add constraint FK_PEDIDOS_IT_IMPST_FINAN_CTA foreign key (FK_FINANCEIRO_CONTAS)
      references FINANCEIRO_CONTAS (PK_FINANCEIRO_CONTAS);

alter table PEDIDOS_ITENS_IMPOSTOS
   add constraint FK_PEDIDOS_IT_IMPST_TYPE_TAX foreign key (FK_TIPO_IMPOSTOS)
      references TIPO_IMPOSTOS (PK_TIPO_IMPOSTOS);

alter table PEDIDOS_MENSAGENS
   add constraint FK_PEDIDOS_MENSAGENS_PEDIDOS foreign key (FK_EMPRESAS, FK_PEDIDOS)
      references PEDIDOS (FK_EMPRESAS, PK_PEDIDOS)
      on delete cascade
      on update cascade;

alter table PEDIDOS_MENSAGENS
   add constraint FK_PEDIDOS_MENSA_DEPARTAMENTOS foreign key (FK_DEPARTAMENTOS)
      references DEPARTAMENTOS (PK_DEPARTAMENTOS);

alter table PEDIDOS_PARCELAS
   add constraint FK_PEDIDOS_PARCE_PEDIDOS foreign key (FK_EMPRESAS, FK_PEDIDOS)
      references PEDIDOS (FK_EMPRESAS, PK_PEDIDOS)
      on delete cascade
      on update cascade;

alter table PEDIDOS_PENDENCIAS
   add constraint FK_PEDIDOS_PENDE_PEDIDOS_ITENS foreign key (FK_EMPRESAS, FK_PEDIDOS, FK_PEDIDOS_ITEMS)
      references PEDIDOS_ITENS (FK_EMPRESAS, FK_PEDIDOS, PK_PEDIDOS_ITENS)
      on delete cascade
      on update cascade;

alter table PEDIDOS_VINCULOS
   add constraint FK_VINCULO_PEDID_PEDIDOS_VINC foreign key (FK_EMPRESAS_VINC, FK_PEDIDOS_VINC)
      references PEDIDOS (FK_EMPRESAS, PK_PEDIDOS)
      on delete cascade
      on update cascade;

alter table PEDIDOS_VINCULOS
   add constraint FK_PEDIDOS_VINCU_PEDIDOS foreign key (FK_EMPRESAS, FK_PEDIDOS)
      references PEDIDOS (FK_EMPRESAS, PK_PEDIDOS)
      on delete cascade
      on update cascade;

alter table TIPO_DESCONTOS
   add constraint FK_TIPO_DESCONTO_GRUPOS_MOVIME foreign key (FK_GRUPOS_MOVIMENTOS)
      references GRUPOS_MOVIMENTOS (PK_GRUPOS_MOVIMENTOS);

alter table TIPO_FRETES
   add constraint FK_TIPO_FRETES_TIPO_PAGAMENT foreign key (FK_TIPO_PAGAMENTOS)
      references TIPO_PAGAMENTOS (PK_TIPO_PAGAMENTOS);

alter table TIPO_FRETES
   add constraint FK_TIPO_FRETES_FINANCEIRO_CO foreign key (FK_FINANCEIRO_CONTAS)
      references FINANCEIRO_CONTAS (PK_FINANCEIRO_CONTAS);

alter table TIPO_MOVIMENTOS
   add constraint FK_TIPO_MOVIMENT_GRUPOS_MOVIME foreign key (FK_GRUPOS_MOVIMENTOS)
      references GRUPOS_MOVIMENTOS (PK_GRUPOS_MOVIMENTOS)
      on delete cascade
      on update cascade;

alter table TIPO_PAGAMENTOS
   add constraint FK_TIPO_PAGAMENT_FINANCEIRO_CO foreign key (FK_FINANCEIRO_CONTAS)
      references FINANCEIRO_CONTAS (PK_FINANCEIRO_CONTAS);

alter table TIPO_PAGAMENTOS
   add constraint FK_TIPO_PAGAMENT_GRUPOS_MOVIME foreign key (FK_GRUPOS_MOVIMENTOS)
      references GRUPOS_MOVIMENTOS (PK_GRUPOS_MOVIMENTOS);

alter table TIPO_PAGAMENTOS
   add constraint FK_TIPO_PAGAMENT_TIPO_DESCONTO foreign key (FK_TIPO_DESCONTOS)
      references TIPO_DESCONTOS (PK_TIPO_DESCONTOS);

alter table TIPO_STATUS_PEDIDOS
   add constraint FK_TIPO_STATUS_GRUPOS_MOVIM foreign key (FK_GRUPOS_MOVIMENTOS)
      references GRUPOS_MOVIMENTOS (PK_GRUPOS_MOVIMENTOS);

alter table TIPO_STATUS_PEDIDOS
   add constraint FK_TIPO_STATUS_P_CENARIOS_FINA foreign key (FK_FINANCEIRO_CENARIOS)
      references CENARIOS_FINANCEIROS (PK_CENARIOS_FINANCEIROS);

alter table TIPO_STATUS_PEDIDOS
   add constraint FK_TIPO_STATUS_P_TIPO_MOVIM_ES foreign key (FK_TIPO_MOVIM_ESTQ)
      references TIPO_MOVIM_ESTQ (PK_TIPO_MOVIM_ESTQ);

alter table VINCULO_TPGTO_FINALIZ
   add constraint FK_VINCULO_TPGTO_FINALIZADORAS foreign key (FK_FINALIZADORAS)
      references FINALIZADORAS (PK_FINALIZADORAS);

alter table VINCULO_TPGTO_FINALIZ
   add constraint FK_VINCULO_TPGTO_TIPO_PAGAMENT foreign key (FK_TIPO_PAGAMENTOS)
      references TIPO_PAGAMENTOS (PK_TIPO_PAGAMENTOS)
      on delete cascade
      on update cascade;

