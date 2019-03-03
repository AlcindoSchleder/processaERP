/*==============================================================*/
/* Database name:  PROCESSA                                     */
/* DBMS name:      Friebird15x                                  */
/* Created on:     7/9/2006 02:11:52                            */
/*==============================================================*/


create generator CADASTROS;

create generator CATEGORIAS;

create generator CENTRO_CUSTOS;

create generator DEPARTAMENTOS;

create generator FINANCEIRO_CONTAS;

create generator PAISES;

create generator PLANO_CONTAS;

create generator PORTOS;

create generator TIPO_ALIAS;

create generator TIPO_BLOQUEIOS;

create generator TIPO_COMISSOES;

create generator TIPO_ENDERECOS;

create generator TIPO_ESTABELECIMENTOS;

create generator TIPO_MOEDAS;

/*==============================================================*/
/* Table: BAIRROS                                               */
/*==============================================================*/
create table BAIRROS (
FK_PAISES            VALORI                         not null,
FK_ESTADOS           UF                             not null,
FK_MUNICIPIOS        VALORI                         not null,
PK_BAIRROS           VALORI                         not null,
DSC_BAI              DESCRICAO_50RQ                 not null,
CEP_BAI              VALORI,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_BAIRROS primary key (FK_PAISES, FK_ESTADOS, FK_MUNICIPIOS, PK_BAIRROS)
);

/*==============================================================*/
/* Index: IDX_BAIRROS01                                         */
/*==============================================================*/
create asc index IDX_BAIRROS01 on BAIRROS (
FK_PAISES,
CEP_BAI
);

grant SELECT,UPDATE,INSERT,DELETE on BAIRROS to PUBLIC;

/*==============================================================*/
/* Table: CADASTROS                                             */
/*==============================================================*/
create table CADASTROS (
PK_CADASTROS         VALORI                         not null,
FLAG_TCAD            FLAG_TIPO_CADASTRO             not null,
DOC_PRI              CNPJ,
DOC_SEQ              DESCRICAO_30,
TRT_CNT              DESCRICAO_20,
CRC_CNT              DESCRICAO_30,
CAT_CNT              VALORS,
RAZ_SOC              DESCRICAO_50RQ                 not null,
FK_PAISES            VALORI                         not null,
FK_ESTADOS           UF                             not null,
FK_MUNICIPIOS        VALORI                         not null,
FK_CONTATOS          VALORI,
FK_TIPO_ALIAS        VALORS,
END_CAD              DESCRICAO_50,
NUM_END              VALORI,
CMP_END              DESCRICAO_30,
CEP_CAD              VALORI,
CXP_CAD              DESCRICAO_10,
FLAG_ETQ             FLAG_SIM_NAO                   not null,
FLAG_ZUMBI           FLAG_SIM_NAO                   not null,
AREA_ATU             DESCRICAO_50,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_CADASTRO primary key (PK_CADASTROS)
);

/*==============================================================*/
/* Index: IDX_CADASTROS001                                      */
/*==============================================================*/
create asc index IDX_CADASTROS001 on CADASTROS (
FLAG_TCAD,
DOC_PRI
);

/*==============================================================*/
/* Index: IDX_CADASTROS002                                      */
/*==============================================================*/
create asc index IDX_CADASTROS002 on CADASTROS (
RAZ_SOC
);

grant SELECT,UPDATE,INSERT,DELETE on CADASTROS to PUBLIC;

/*==============================================================*/
/* Table: CADASTROS_CONTATOS                                    */
/*==============================================================*/
create table CADASTROS_CONTATOS (
FK_CADASTROS         VALORI                         not null,
PK_CADASTROS_CONTATOS VALORS                         not null,
DSC_CNT              DESCRICAO_30RQ                 not null,
CNT_CNT              DESCRICAO_30RQ                 not null,
FLAG_DEF             FLAG_SIM_NAO                   not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_CADASTROS_CONTATOS primary key (FK_CADASTROS, PK_CADASTROS_CONTATOS)
);

grant SELECT,UPDATE,INSERT,DELETE on CADASTROS_CONTATOS to PUBLIC;

/*==============================================================*/
/* Table: CADASTROS_EVENTOS                                     */
/*==============================================================*/
create table CADASTROS_EVENTOS (
FK_CADASTROS         VALORI                         not null,
PK_CADASTROS_EVENTOS DATA                           not null,
DSC_EVT              DESCRICAO_50RQ                 not null,
FLAG_TEVT            FLAG                           not null,
FLAG_INC_EVT         FLAG_SIM_NAO                   not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_CADASTROS_EVENTOS primary key (FK_CADASTROS, PK_CADASTROS_EVENTOS)
);

grant DELETE,UPDATE,INSERT,SELECT on CADASTROS_EVENTOS to PUBLIC;

/*==============================================================*/
/* Table: CADASTROS_IMAGENS                                     */
/*==============================================================*/
create table CADASTROS_IMAGENS (
FK_CADASTROS         VALORI                         not null,
IMG_CAD              BLOB_BINARIO                   not null,
FLAG_TIMG            FLAG_TIPO_IMAGEM               not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_CADASTROS_IMAGENS primary key (FK_CADASTROS)
);

grant SELECT,UPDATE,INSERT,DELETE on CADASTROS_IMAGENS to PUBLIC;

/*==============================================================*/
/* Table: CADASTROS_INTERNET                                    */
/*==============================================================*/
create table CADASTROS_INTERNET (
FK_CADASTROS         VALORI                         not null,
PK_CADASTROS_INTERNET VALORI                         not null,
END_CNT              DESCRICAO_100RQ                not null,
DSC_END              DESCRICAO_30,
FLAG_DEF             FLAG_SIM_NAO                   not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_CADASTROS_INTERNET primary key (FK_CADASTROS, PK_CADASTROS_INTERNET)
);

grant SELECT,UPDATE,INSERT,DELETE on CADASTROS_INTERNET to PUBLIC;

/*==============================================================*/
/* Table: CADASTROS_OBSERVACOES                                 */
/*==============================================================*/
create table CADASTROS_OBSERVACOES (
FK_CADASTROS         VALORI                         not null,
OBS_CAD              BLOB_TEXTO,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_CADASTROS_OBSERVACOES primary key (FK_CADASTROS)
);

grant SELECT,UPDATE,INSERT,DELETE on CADASTROS_OBSERVACOES to PUBLIC;

/*==============================================================*/
/* Table: CATEGORIAS                                            */
/*==============================================================*/
create table CATEGORIAS (
PK_CATEGORIAS        VALORS                         not null,
FK_FINANCEIRO_CONTAS VALORI,
DSC_CAT              DESCRICAO_30RQ                 not null,
FLAG_CAT             FLAG_TIPO_CATEGORIA            not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_CATEGORIAS primary key (PK_CATEGORIAS)
);

grant SELECT,UPDATE,INSERT,DELETE on CATEGORIAS to PUBLIC;

/*==============================================================*/
/* Table: CENTRO_CUSTOS                                         */
/*==============================================================*/
create table CENTRO_CUSTOS (
PK_CENTRO_CUSTOS     VALORS                         not null,
DSC_CCST             DESCRICAO_30RQ                 not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_CENTRO_CUSTOS primary key (PK_CENTRO_CUSTOS)
);

grant SELECT,UPDATE,INSERT,DELETE on CENTRO_CUSTOS to PUBLIC;

/*==============================================================*/
/* Table: CLIENTES                                              */
/*==============================================================*/
create table CLIENTES (
FK_CADASTROS         VALORI                         not null,
FK_TIPO_PAGAMENTOS   VALORS,
FK_TIPO_DESCONTOS    VALORS,
FK_BANCOS            VALORS,
FK_VW_VENDEDORES     VALORI,
FK_VW_REPRESENTANTES VALORI,
FK_VW_TRANSPORTADORAS VALORI,
FK_VW_CADASTROS      VALORI,
FK_TIPO_ESTABELECIMENTOS VALORS,
FK_PORTOS__EMB       VALORS,
FK_PORTOS__DST       VALORS,
FK_FINALIZADORAS     VALORS,
FK_TIPO_PRAZO_ENTREGA VALORS,
FK_TIPO_BLOQUEIOS    VALORS,
FK_TABELA_PRECOS     VALORS,
DIA_EMS              VALORS                         default 0,
DSCT_AUT             NUMERO_PEQUENO,
DSCT_ATC             NUMERO_PEQUENO,
FLAG_CNSM            FLAG_SIM_NAO                   not null,
FLAG_PENP            FLAG_SIM_NAO                   not null,
FLAG_PABR            FLAG_SIM_NAO                   not null,
FLAG_DTABAS          FLAG_DATA_BASE                 not null,
LIM_CRD              NUMERO_GRANDE,
LST_PRZ              DESCRICAO_50,
OPE_AUT              NOME_OPERADOR,
OPE_LIB              NOME_OPERADOR,
SIT_BLOCK_ANT        VALORS,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_CLIENTES primary key (FK_CADASTROS)
);

grant SELECT,UPDATE,INSERT,DELETE on CLIENTES to PUBLIC;

/*==============================================================*/
/* Table: COBRANCAS                                             */
/*==============================================================*/
create table COBRANCAS (
FK_CLIENTES          VALORI                         not null,
FK_PAISES            VALORI,
FK_ESTADOS           UF                             not null,
FK_MUNICIPIOS        VALORI,
END_CBR              DESCRICAO_50RQ                 not null,
NUM_CBR              VALORI,
CMP_CBR              DESCRICAO_30,
CEP_CBR              VALORI,
CXP_CBR              DESCRICAO_10,
FON_CBR              PHONE,
FAX_CBR              PHONE,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_COBRANCAS primary key (FK_CLIENTES)
);

grant DELETE,INSERT,UPDATE,SELECT on COBRANCAS to PUBLIC;

/*==============================================================*/
/* Table: DADOS_PESSOAIS                                        */
/*==============================================================*/
create table DADOS_PESSOAIS (
FK_CLIENTES          VALORI                         not null,
EMP_TRB              DESCRICAO_30,
FON_EMP              PHONE,
DTA_ADM              DATA,
CRG_CLI              DESCRICAO_30,
SAL_CLI              NUMERO_GRANDE,
NUM_CNH              DESCRICAO_20,
DTA_EXP              DATA,
VAL_CNH              DATA,
ESC_CAD              DESCRICAO_20,
PRF_CLI              DESCRICAO_20,
FLAG_SEX             FLAG_SEXO                      not null,
CMP_SAL              NUMERO_PEQUENO,
VLR_ALG              NUMERO_PEQUENO,
FK_PAISES            VALORI,
FK_ESTADOS           UF                             not null,
FK_MUNICIPIOS        VALORI                         not null,
NOM_PAI              DESCRICAO_50RQ                 not null,
NOM_MAE              DESCRICAO_50RQ                 not null,
OBS_PES              BLOB_TEXTO,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_DADOS_PESSOAIS primary key (FK_CLIENTES)
);

grant SELECT,UPDATE,INSERT,DELETE on DADOS_PESSOAIS to PUBLIC;

/*==============================================================*/
/* Table: DEPARTAMENTOS                                         */
/*==============================================================*/
create table DEPARTAMENTOS (
PK_DEPARTAMENTOS     VALORS                         not null,
DSC_DPTO             DESCRICAO_30RQ                 not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_DEPARTAMENTOS primary key (PK_DEPARTAMENTOS)
);

grant DELETE,INSERT,UPDATE,SELECT on DEPARTAMENTOS to PUBLIC;

/*==============================================================*/
/* Table: ENTREGAS                                              */
/*==============================================================*/
create table ENTREGAS (
FK_CLIENTES          VALORI                         not null,
FK_PAISES            VALORI,
FK_ESTADOS           UF                             not null,
FK_MUNICIPIOS        VALORI,
CNPJ_ENTR            CNPJ,
IE_ENTR              INSCRICAO_ESTADUAL_RG,
END_ENT              DESCRICAO_50RQ                 not null,
NUM_ENT              VALORI,
CMP_ENT              DESCRICAO_30,
CEP_ENT              VALORI,
CXP_ENT              DESCRICAO_10,
FON_ENT              PHONE,
FAX_ENT              PHONE,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_ENTREGAS primary key (FK_CLIENTES)
);

grant SELECT,UPDATE,INSERT,DELETE on ENTREGAS to PUBLIC;

/*==============================================================*/
/* Table: ESTADOS                                               */
/*==============================================================*/
create table ESTADOS (
FK_PAISES            VALORI                         not null,
PK_ESTADOS           UF                             not null,
DSC_UF               DESCRICAO_30RQ                 not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_ESTADOS primary key (FK_PAISES, PK_ESTADOS)
);

grant DELETE,INSERT,UPDATE,SELECT on ESTADOS to PUBLIC;

/*==============================================================*/
/* Table: FINANCEIRO_CONTAS                                     */
/*==============================================================*/
create table FINANCEIRO_CONTAS (
PK_FINANCEIRO_CONTAS VALORI                         not null,
FK_FINANCEIRO_CONTAS VALORI,
SEQ_CTA              VALORS                         not null,
FK_PLANO_CONTAS      VALORI,
DSC_CTA              DESCRICAO_50RQ                 not null,
MASK_CTA             DESCRICAO_50RQ                 not null,
GRAU_CTA             VALORS,
FLAG_ID              FLAG_TIPO_CONTA                not null,
FLAG_TCTA            FLAG_NATUREZA_CONTA            not null,
FLAG_ANL_SNT         FLAG_SIM_NAO                   not null,
KC_FINANCEIRO_LANCAMENTOS VALORI                         default 0 not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_FINANCEIRO_CONTAS primary key (PK_FINANCEIRO_CONTAS)
);

/*==============================================================*/
/* Index: IDX_FINANCEIRO_CONTAS_01                              */
/*==============================================================*/
create asc index IDX_FINANCEIRO_CONTAS_01 on FINANCEIRO_CONTAS (
FK_FINANCEIRO_CONTAS,
SEQ_CTA
);

grant SELECT,UPDATE,INSERT,DELETE on FINANCEIRO_CONTAS to PUBLIC;

/*==============================================================*/
/* Table: FORNECEDORES                                          */
/*==============================================================*/
create table FORNECEDORES (
FK_CADASTROS         VALORI                         not null,
FK_VW_TRANSPORTADORAS VALORI,
FK_VW_CADASTROS      VALORI,
FK_PORTOS__EMB       VALORS,
FK_PORTOS__DST       VALORS,
FK_TIPO_PAGAMENTOS   VALORS,
FK_DESCONTOS         VALORS,
NOM_VND              DESCRICAO_50RQ                 not null,
LST_PRZ              DESCRICAO_50,
FLAG_TRN             FLAG_SIM_NAO                   not null,
FLAG_PROD_DEF        FLAG_SIM_NAO                   not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA,
constraint PK_FORNECEDORES primary key (FK_CADASTROS)
);

grant SELECT,UPDATE,INSERT,DELETE on FORNECEDORES to PUBLIC;

/*==============================================================*/
/* Table: FUNCIONARIOS                                          */
/*==============================================================*/
create table FUNCIONARIOS (
FK_CADASTROS         VALORI                         not null,
FK_EMPRESAS          VALORI                         not null,
FK_DEPARTAMENTOS     VALORS,
FK_SETOR             VALORS,
FK_CENTRO_CUSTOS     VALORS,
FK_TIPO_CARGOS       VALORS,
FK_TIPO_COMISSOES    VALORS,
FK_BANCOS            VALORS,
FK_BANCOS__FGTS      VALORS,
FK_PAISES            VALORS,
FK_ESTADOS           UF_NULL,
FK_MUNICIPIOS        VALORI,
NUM_FUNC             VALORS,
COM_VND              NUMERO_PERCENTUAL,
LOT_FUN              DESCRICAO_20,
FLAG_CRG             FLAG_CARGO                     not null,
REF_LIVRO            VALORI,
NUM_CTPS             VALORI,
SER_CTPS             DESCRICAO_10,
DTA_EXP              DATA,
UF_CTPS              UF_NULL,
DTA_EMI_RG           DATA,
NUM_TIT              DESCRICAO_30,
ZONA_TIT             DESCRICAO_10,
SECAO_TIT            DESCRICAO_10,
PIS_FUNC             DESCRICAO_30,
DTA_CAD              DATA,
DTA_NASC             DATA,
FLAG_SEXO            FLAG_SEXO                      not null,
FLAG_ESTCV           FLAG_ESTADO_CIVIL              not null,
FLAG_GRINSTR         FLAG_GRAU_INSTRUCAO            not null,
HAB_PROF             DESCRICAO_10,
NOM_CONSLH           DESCRICAO_10,
NUM_REG              DESCRICAO_10,
ANO_CHEG             VALORS,
TIPO_VISTO           DESCRICAO_20,
RACA_COR             DESCRICAO_10,
FLAG_APST            FLAG_SIM_NAO                   not null,
DTA_APST             DATA,
SIT_APST             DESCRICAO_20,
FLAG_DEF             FLAG_SIM_NAO                   not null,
DTA_ADM              DATA,
FLAG_TEMPR           FLAG_SIM_NAO                   not null,
CONTA                DESCRICAO_10,
CONTA_VINC           DESCRICAO_10,
PERC_INS             NUMERO_PERCENTUAL,
PERC_PERIC           NUMERO_PERCENTUAL,
FLAG_OPPRV           FLAG_SIM_NAO                   not null,
FLAG_TSAL            FLAG_TIPO_SALARIO              not null,
NOM_SIND             DESCRICAO_30,
VINC_FUNC            DESCRICAO_30,
QTD_HORAS            VALORS,
VLR_SAL              NUMERO_MEDIO_4CD,
NUM_DEP_IR           VALORS,
QTD_FILHO            VALORS,
DTA_NASC_FILHO       DATA,
NOM_PAI              DESCRICAO_50,
NOM_MAE              DESCRICAO_50,
DSCT_MAX             NUMERO_PEQUENO,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_FUNCIONARIOS primary key (FK_CADASTROS)
);

grant DELETE,INSERT,UPDATE,SELECT on FUNCIONARIOS to PUBLIC;

/*==============================================================*/
/* Table: INFO_COMERCIAL                                        */
/*==============================================================*/
create table INFO_COMERCIAL (
FK_EMPRESAS          VALORI                         not null,
FK_CADASTROS         VALORI                         not null,
DTA_PCMP             DATA,
DTA_UCMP             DATA,
DTA_UPED             DATA,
DTA_UVISITA          DATA_HORA,
QTD_DPLAVC           VALORS,
QTD_DPLVC            VALORS,
PRZ_VISITA           VALORS,
PRZ_MEDEN            VALORS,
PRZ_MED_PGTO         VALORS,
PRZ_MED_ATR          VALORS,
VLR_UCMP             NUMERO_GRANDE,
TOT_CMP              NUMERO_GRANDE,
VLR_UPED             NUMERO_GRANDE,
TOT_PED              NUMERO_GRANDE,
MAX_DUPLA            NUMERO_GRANDE,
MAX_PED              NUMERO_GRANDE,
MAX_CMP              NUMERO_GRANDE,
MIN_CMP              NUMERO_MEDIO,
TOT_PEDA             NUMERO_GRANDE,
TOT_DPLA             NUMERO_GRANDE,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_INFO_COMERCIAL primary key (FK_EMPRESAS, FK_CADASTROS)
);

grant SELECT,UPDATE,INSERT,DELETE on INFO_COMERCIAL to PUBLIC;

/*==============================================================*/
/* Table: LOGRADOUROS                                           */
/*==============================================================*/
create table LOGRADOUROS (
FK_PAISES            VALORI                         not null,
FK_ESTADOS           UF                             not null,
FK_MUNICIPIOS        VALORI                         not null,
FK_BAIRROS           VALORI                         not null,
PK_LOGRADOUROS       VALORI                         not null,
FK_TIPO_ENDERECOS    VALORS,
DSC_LOC              DESCRICAO_50RQ                 not null,
CEP_LOC              VALORI                         not null,
CMPL_LOC             DESCRICAO_30RQ                 not null,
NUM_INI              VALORI,
NUM_FIN              VALORI,
FLAG_LADO            FLAG_LADO_ED                   not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_LOGRADOUROS primary key (FK_PAISES, FK_ESTADOS, FK_MUNICIPIOS, FK_BAIRROS, PK_LOGRADOUROS)
);

/*==============================================================*/
/* Index: IDX_LOGRADOUROS01                                     */
/*==============================================================*/
create unique asc index IDX_LOGRADOUROS01 on LOGRADOUROS (
FK_PAISES,
FK_ESTADOS,
FK_MUNICIPIOS,
CEP_LOC
);

/*==============================================================*/
/* Index: IDX_LOGRADOUROS02                                     */
/*==============================================================*/
create unique asc index IDX_LOGRADOUROS02 on LOGRADOUROS (
FK_PAISES,
CEP_LOC
);

grant DELETE,INSERT,UPDATE,SELECT on LOGRADOUROS to PUBLIC;

/*==============================================================*/
/* Table: MOEDAS                                                */
/*==============================================================*/
create table MOEDAS (
FK_TIPO_MOEDAS       VALORS                         not null,
PK_MOEDAS            DATA_DEF                       not null,
IND_MD               NUMERO_INDICE                  not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_MOEDAS_LOG primary key (FK_TIPO_MOEDAS, PK_MOEDAS)
);

grant SELECT,UPDATE,INSERT,DELETE on MOEDAS to PUBLIC;

/*==============================================================*/
/* Table: MUNICIPIOS                                            */
/*==============================================================*/
create table MUNICIPIOS (
FK_PAISES            VALORI                         not null,
FK_ESTADOS           UF                             not null,
PK_MUNICIPIOS        VALORI                         not null,
PK_CARGAS_REGIOES    VALORS,
DSC_MUN              DESCRICAO_50RQ                 not null,
CEP_MUN              VALORI,
ALQ_ISS              NUMERO_PERCENTUAL,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_MUNCIPIOS primary key (FK_PAISES, FK_ESTADOS, PK_MUNICIPIOS)
);

/*==============================================================*/
/* Index: IDX_MUNICIPIOS01                                      */
/*==============================================================*/
create asc index IDX_MUNICIPIOS01 on MUNICIPIOS (
FK_PAISES,
FK_ESTADOS,
DSC_MUN
);

/*==============================================================*/
/* Index: IDX_MUNICIPIOS02                                      */
/*==============================================================*/
create asc index IDX_MUNICIPIOS02 on MUNICIPIOS (
FK_PAISES,
CEP_MUN
);

grant SELECT,UPDATE,INSERT,DELETE on MUNICIPIOS to PUBLIC;

/*==============================================================*/
/* Table: MUNICIPIOS_ALIQUOTAS                                  */
/*==============================================================*/
create table MUNICIPIOS_ALIQUOTAS (
FK_PAISES            VALORI                         not null,
FK_ESTADOS           UF                             not null,
FK_MUNICIPIOS        VALORI                         not null,
PK_MUNICIPIOS_ALIQUOTAS VALORS                         not null,
COD_ISS_ECF          VALORS                         not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_MUNICIPIOS_ALIQUOTAS primary key (FK_PAISES, FK_ESTADOS, FK_MUNICIPIOS, PK_MUNICIPIOS_ALIQUOTAS)
);

grant SELECT,UPDATE,INSERT,DELETE on MUNICIPIOS_ALIQUOTAS to PUBLIC;

/*==============================================================*/
/* Table: PAISES                                                */
/*==============================================================*/
create table PAISES (
PK_PAISES            VALORI                         not null,
FK_LINGUAGENS        LINGUAGEM                      not null,
FK_TIPO_MOEDAS       VALORS,
DSC_PAIS             DESCRICAO_50RQ                 not null,
NAC_PAIS             DESCRICAO_50RQ                 not null,
FLAG_ACM             FLAG_SIM_NAO                   not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PAISES primary key (PK_PAISES)
);

grant DELETE,INSERT,UPDATE,SELECT on PAISES to PUBLIC;

/*==============================================================*/
/* Table: PLANO_CONTAS                                          */
/*==============================================================*/
create table PLANO_CONTAS (
PK_PLANO_CONTAS      VALORI                         not null,
FK_PLANO_CONTAS      VALORI,
SEQ_PLCTA            VALORS                         not null,
DSC_CTA              DESCRICAO_50RQ                 not null,
MASK_CTA             DESCRICAO_50RQ                 not null,
GRAU_CTA             VALORS,
FLAG_TCTA            FLAG_NATUREZA_CONTA            not null,
FLAG_ID              FLAG_TIPO_CONTA                not null,
FLAG_ANL_SNT         FLAG_SIM_NAO                   not null,
KC_LANCAMENTOS       VALORI,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PLANO_CONTAS primary key (PK_PLANO_CONTAS)
);

/*==============================================================*/
/* Index: IDX_PLANO_CONTAS_01                                   */
/*==============================================================*/
create asc index IDX_PLANO_CONTAS_01 on PLANO_CONTAS (
SEQ_PLCTA,
FK_PLANO_CONTAS
);

grant SELECT,UPDATE,INSERT,DELETE on PLANO_CONTAS to PUBLIC;

/*==============================================================*/
/* Table: PORTOS                                                */
/*==============================================================*/
create table PORTOS (
PK_PORTOS            VALORI                         not null,
FK_PAISES            VALORI                         not null,
FK_ESTADOS           UF                             not null,
FK_MUNICIPIOS        VALORI                         not null,
DSC_PORTO            DESCRICAO_50RQ                 not null,
CNT_PORTO            DESCRICAO_30,
FON_PORTO            PHONE,
FAX_PORTO            PHONE,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PORTOS primary key (PK_PORTOS)
);

grant SELECT,INSERT,DELETE,UPDATE on PORTOS to PUBLIC;

/*==============================================================*/
/* Table: REFERENCIA_COMERCIAIS                                 */
/*==============================================================*/
create table REFERENCIA_COMERCIAIS (
FK_CLIENTES          VALORI                         not null,
PK_REFERENCIA_COMERCIAIS VALORI                         not null,
NOM_REF              DESCRICAO_50RQ                 not null,
FON_REF              PHONE,
FLAG_CNF             FLAG_SIM_NAO                   not null,
MAIL_REF             DESCRICAO_50,
OBS_REF              BLOB_TEXTO,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_REFERENCIA_COMERCIAIS primary key (FK_CLIENTES, PK_REFERENCIA_COMERCIAIS)
);

grant SELECT,UPDATE,INSERT,DELETE on REFERENCIA_COMERCIAIS to PUBLIC;

/*==============================================================*/
/* Table: SOCIOS                                                */
/*==============================================================*/
create table SOCIOS (
FK_CLIENTES          VALORI                         not null,
PK_SOCIOS            CPF                            not null,
NOM_SOC              DESCRICAO_50RQ                 not null,
FK_PAISES            VALORS,
FK_ESTADOS           UF,
FK_MUNICIPIOS        VALORI,
END_SOC              DESCRICAO_50,
NUM_SOC              VALORI,
CEP_SOC              VALORI,
CMP_SOC              DESCRICAO_30,
MAIL_SOC             DESCRICAO_50,
DTA_NAS              DATA,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_SOCIOS primary key (FK_CLIENTES, PK_SOCIOS)
);

grant SELECT,UPDATE,INSERT,DELETE on SOCIOS to PUBLIC;

/*==============================================================*/
/* Table: TIPO_ALIAS                                            */
/*==============================================================*/
create table TIPO_ALIAS (
PK_TIPO_ALIAS        VALORS                         not null,
DSC_ALIAS            DESCRICAO_50RQ                 not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_TIPO_ALIAS primary key (PK_TIPO_ALIAS)
);

grant DELETE,INSERT,UPDATE,SELECT on TIPO_ALIAS to PUBLIC;

/*==============================================================*/
/* Table: TIPO_BLOQUEIOS                                        */
/*==============================================================*/
create table TIPO_BLOQUEIOS (
PK_TIPO_BLOQUEIOS    VALORS                         not null,
DSC_TBL              DESCRICAO_30RQ                 not null,
FLAG_BLQ             FLAG_SIM_NAO                   not null,
FLAG_VAVS            FLAG_SIM_NAO                   not null,
FLAG_MPGT            FLAG_SIM_NAO                   not null,
FLAG_DTABAS          FLAG_SIM_NAO                   not null,
FLAG_CONDP           FLAG_SIM_NAO                   not null,
FLAG_LIMCR           FLAG_SIM_NAO                   not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_TIPO_BLOQUEIOS primary key (PK_TIPO_BLOQUEIOS)
);

/*==============================================================*/
/* Table: TIPO_COMISSOES                                        */
/*==============================================================*/
create table TIPO_COMISSOES (
PK_TIPO_COMISSOES    VALORS                         not null,
FK_FINANCEIRO_CONTAS VALORI,
DSC_COM              DESCRICAO_30RQ                 not null,
PERC_COM             NUMERO_PERCENTUAL              not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_TIPO_COMISSOES primary key (PK_TIPO_COMISSOES)
);

grant DELETE,INSERT,UPDATE,SELECT on TIPO_COMISSOES to PUBLIC;

/*==============================================================*/
/* Table: TIPO_ENDERECOS                                        */
/*==============================================================*/
create table TIPO_ENDERECOS (
PK_TIPO_ENDERECOS    VALORS                         not null,
DSC_TPE              DESCRICAO_30RQ                 not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_TIPO_ENDERECOS primary key (PK_TIPO_ENDERECOS)
);

grant SELECT,UPDATE,INSERT,DELETE on TIPO_ENDERECOS to PUBLIC;

/*==============================================================*/
/* Table: TIPO_ESTABELECIMENTOS                                 */
/*==============================================================*/
create table TIPO_ESTABELECIMENTOS (
PK_TIPO_ESTABELECIMENTOS VALORS                         not null,
DSC_TEST             DESCRICAO_30RQ                 not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_TIPO_ESTABELECIMENTOS primary key (PK_TIPO_ESTABELECIMENTOS)
);

grant DELETE,INSERT,UPDATE,SELECT on TIPO_ESTABELECIMENTOS to PUBLIC;

/*==============================================================*/
/* Table: TIPO_MOEDAS                                           */
/*==============================================================*/
create table TIPO_MOEDAS (
PK_TIPO_MOEDAS       VALORS                         not null,
DSC_MD               DESCRICAO_50RQ                 not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_TIPO_MOEDAS primary key (PK_TIPO_MOEDAS)
);

alter table PAISES
   add constraint FK_PAISES_TIPO_MOEDAS foreign key (FK_TIPO_MOEDAS)
      references TIPO_MOEDAS (PK_TIPO_MOEDAS);

grant SELECT,UPDATE,INSERT,DELETE on TIPO_MOEDAS to PUBLIC;

/*==============================================================*/
/* Table: VINCULOS_CAD_CAT                                      */
/*==============================================================*/
create table VINCULOS_CAD_CAT (
FK_CADASTROS         VALORI                         not null,
FK_CATEGORIAS        VALORS                         not null,
FK_EMPRESAS          VALORI,
FK_FINANCEIRO_CONTAS VALORI,
FLAG_ATV             FLAG_SIM_NAO                   not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_VINCULOS_CAD_CAT primary key (FK_CADASTROS, FK_CATEGORIAS)
);

grant DELETE,INSERT,UPDATE,SELECT on VINCULOS_CAD_CAT to PUBLIC;

/*==============================================================*/
/* View: VW_ADMINISTRACAO                                       */
/*==============================================================*/
create view VW_ADMINISTRACAO
as
select distinct Cad.*, Vcc.FK_FINANCEIRO_CONTAS, 
       Vcc.FLAG_ATV
  from CADASTROS Cad
  join VINCULOS_CAD_CAT Vcc
    on Vcc.FK_CADASTROS  = Cad.PK_CADASTROS
   and Vcc.FLAG_ATV      = 1
  join CATEGORIAS Cat
    on Cat.PK_CATEGORIAS = Vcc.FK_CATEGORIAS
   and Cat.FLAG_CAT      = 2
  join FUNCIONARIOS Fun
    on Fun.FK_CADASTROS  = Cad.PK_CADASTROS
   and Fun.FLAG_CRG      = 5
 where PK_CADASTROS > 0;

grant SELECT on VW_ADMINISTRACAO to PUBLIC;

/*==============================================================*/
/* View: VW_AGENTES                                             */
/*==============================================================*/
create view VW_AGENTES
as
select distinct Cad.*, Vcc.FK_FINANCEIRO_CONTAS, Vcc.FLAG_ATV
  from CADASTROS Cad
  join VINCULOS_CAD_CAT Vcc
    on Vcc.FK_CADASTROS  = Cad.PK_CADASTROS
   and Vcc.FLAG_ATV      = 1
  join CATEGORIAS Cat
    on Cat.PK_CATEGORIAS = Vcc.FK_CATEGORIAS
   and Cat.FLAG_CAT      = 4
 where PK_CADASTROS > 0;

grant SELECT on VW_AGENTES to PUBLIC;

/*==============================================================*/
/* View: VW_CADASTROS                                           */
/*==============================================================*/
create view VW_CADASTROS
as
select distinct Cad.*, Vcc.FK_FINANCEIRO_CONTAS, Vcc.FLAG_ATV
  from CADASTROS Cad
  join VINCULOS_CAD_CAT Vcc
    on Vcc.FK_CADASTROS  = Cad.PK_CADASTROS
   and Vcc.FLAG_ATV      = 1
  join CATEGORIAS Cat
    on Cat.PK_CATEGORIAS = Vcc.FK_CATEGORIAS
   and Cat.FLAG_CAT      = 5
 where PK_CADASTROS > 0;

grant SELECT on VW_CADASTROS to PUBLIC;

/*==============================================================*/
/* View: VW_CLIENTES                                            */
/*==============================================================*/
create view VW_CLIENTES
as
select Cad.PK_CADASTROS, Cad.FLAG_TCAD, Cad.DOC_PRI, Cad.DOC_SEQ,
       Cad.RAZ_SOC, Cad.FK_PAISES, Cad.FK_ESTADOS, Cad.FK_MUNICIPIOS,
       Cad.END_CAD, Cad.NUM_END, Cad.CMP_END, Cad.CEP_CAD,
       Cad.CXP_CAD, Cob.OBS_CAD, Cad.FLAG_ETQ, Cad.FLAG_ZUMBI,
       Cad.AREA_ATU, Cli.*, Cat.PK_CATEGORIAS, Cat.DSC_CAT,
       Tal.DSC_ALIAS, Cad.FK_TIPO_ALIAS, Vcc.FK_FINANCEIRO_CONTAS,
       Vcc.FLAG_ATV
  from CADASTROS Cad
  join VINCULOS_CAD_CAT Vcc
    on Vcc.FK_CADASTROS  = Cad.PK_CADASTROS
   and Vcc.FLAG_ATV      = 1
  join CATEGORIAS Cat
    on Cat.PK_CATEGORIAS = Vcc.FK_CATEGORIAS
   and Cat.FLAG_CAT      = 0
  left outer join CLIENTES Cli
    on Cli.FK_CADASTROS  = Cad.PK_CADASTROS
  left outer join TIPO_ALIAS Tal
    on Tal.PK_TIPO_ALIAS = Cad.FK_TIPO_ALIAS
  left outer join CADASTROS_OBSERVACOES Cob
    on Cob.FK_CADASTROS  = Cad.PK_CADASTROS
 where PK_CADASTROS > 0;

grant SELECT on VW_CLIENTES to PUBLIC;

/*==============================================================*/
/* View: VW_CLIENTES_EXPORTACAO                                 */
/*==============================================================*/
create view VW_CLIENTES_EXPORTACAO
as
select Cad.PK_CADASTROS, Cad.FLAG_TCAD, Cad.DOC_PRI, Cad.DOC_SEQ,
       Cad.RAZ_SOC, Cad.FK_PAISES, Cad.FK_ESTADOS,
       Cad.FK_MUNICIPIOS, Cad.END_CAD, Cad.NUM_END, Cad.CMP_END,
       Cad.CEP_CAD, Cad.CXP_CAD, Cob.OBS_CAD, Cad.FLAG_ETQ,
       Cad.FLAG_ZUMBI, Cad.AREA_ATU, Cli.*, Emp.PK_EMPRESAS,
       Cat.PK_CATEGORIAS, Cat.DSC_CAT, Tal.DSC_ALIAS, Cad.FK_TIPO_ALIAS, 
       Vcc.FK_FINANCEIRO_CONTAS, Vcc.FLAG_ATV
  from CADASTROS Cad
  join VINCULOS_CAD_CAT Vcc
    on Vcc.FK_CADASTROS  = Cad.PK_CADASTROS
   and Vcc.FLAG_ATV      = 1
  join CATEGORIAS Cat
    on Cat.PK_CATEGORIAS = Vcc.FK_CATEGORIAS
   and Cat.FLAG_CAT      = 0
  join EMPRESAS Emp
    on Emp.PK_EMPRESAS   = Vcc.FK_EMPRESAS
   and Emp.FK_PAISES    <> Cad.FK_PAISES
  left outer join CLIENTES Cli
    on Cli.FK_CADASTROS  = Cad.PK_CADASTROS
  left outer join TIPO_ALIAS Tal
    on Tal.PK_TIPO_ALIAS = Cad.FK_TIPO_ALIAS
  left outer join CADASTROS_OBSERVACOES Cob
    on Cob.FK_CADASTROS  = Cad.PK_CADASTROS
 where Cad.PK_CADASTROS  > 0
   and Cad.FK_PAISES    <> Emp.FK_PAISES;

grant SELECT on VW_CLIENTES_EXPORTACAO to PUBLIC;

/*==============================================================*/
/* View: VW_FORNECEDORES                                        */
/*==============================================================*/
create view VW_FORNECEDORES
as
select distinct Cad.PK_CADASTROS, Cad.FLAG_TCAD, Cad.DOC_PRI,
       Cad.DOC_SEQ, Cad.TRT_CNT, Cad.CRC_CNT, Cad.CAT_CNT, 
       Cad.RAZ_SOC, Cad.FK_PAISES, Cad.FK_ESTADOS, Cad.FK_MUNICIPIOS,
       Cad.FK_CONTATOS, Cad.FK_TIPO_ALIAS, Cad.END_CAD, Cad.NUM_END,
       Cad.CMP_END, Cad.CEP_CAD, Cad.CXP_CAD, Cad.FLAG_ETQ,
       Cad.FLAG_ZUMBI, Cad.AREA_ATU, Frn.FK_VW_TRANSPORTADORAS, 
       Frn.FK_VW_CADASTROS, Frn.FK_PORTOS__EMB, Frn.FK_PORTOS__DST, 
       Frn.FK_TIPO_PAGAMENTOS, Frn.FK_DESCONTOS, Frn.NOM_VND, 
       Frn.LST_PRZ, Frn.FLAG_TRN, Cat.PK_CATEGORIAS, Cat.DSC_CAT, 
       Tal.DSC_ALIAS, Vcc.FK_FINANCEIRO_CONTAS, Vcc.FLAG_ATV
  from CADASTROS Cad
  join VINCULOS_CAD_CAT Vcc
    on Vcc.FK_CADASTROS  = Cad.PK_CADASTROS
   and Vcc.FLAG_ATV      = 1
  join CATEGORIAS Cat
    on Cat.PK_CATEGORIAS = Vcc.FK_CATEGORIAS
   and Cat.FLAG_CAT      = 1
  left outer join FORNECEDORES Frn
    on Frn.FK_CADASTROS  = Cad.PK_CADASTROS
   and Frn.FLAG_TRN      = 0
  left outer join TIPO_ALIAS Tal
    on Tal.PK_TIPO_ALIAS = Cad.FK_TIPO_ALIAS
 where Cad.PK_CADASTROS > 0;

grant SELECT on VW_FORNECEDORES to PUBLIC;

/*==============================================================*/
/* View: VW_FUNCIONARIOS                                        */
/*==============================================================*/
create view VW_FUNCIONARIOS
as
select Cad.*, Cim.IMG_CAD, Cim.FLAG_TIMG, Fun.LOT_FUN, 
       Vcc.FK_FINANCEIRO_CONTAS, Vcc.FLAG_ATV
  from CADASTROS Cad
  join VINCULOS_CAD_CAT Vcc
    on Vcc.FK_CADASTROS  = Cad.PK_CADASTROS
   and Vcc.FLAG_ATV      = 1
  join CATEGORIAS Cat
    on Cat.PK_CATEGORIAS = Vcc.FK_CATEGORIAS
   and Cat.FLAG_CAT      = 2
  left outer join CADASTROS_IMAGENS Cim
    on Cim.FK_CADASTROS = Cad.PK_CADASTROS
  left outer join FUNCIONARIOS Fun
    on Fun.FK_CADASTROS  = Cad.PK_CADASTROS
 where PK_CADASTROS > 0;

grant SELECT on VW_FUNCIONARIOS to PUBLIC;

/*==============================================================*/
/* View: VW_REPRESENTANTES                                      */
/*==============================================================*/
create view VW_REPRESENTANTES
as
select distinct Cad.*, Vcc.FK_FINANCEIRO_CONTAS, Vcc.FLAG_ATV
  from CADASTROS Cad
  join VINCULOS_CAD_CAT Vcc
    on Vcc.FK_CADASTROS  = Cad.PK_CADASTROS
   and Vcc.FLAG_ATV      = 1
  join CATEGORIAS Cat
    on Cat.PK_CATEGORIAS = Vcc.FK_CATEGORIAS
   and Cat.FLAG_CAT      = 3
 where PK_CADASTROS > 0;

grant SELECT on VW_REPRESENTANTES to PUBLIC;

/*==============================================================*/
/* View: VW_TECNICOS                                            */
/*==============================================================*/
create view VW_TECNICOS
as
select distinct Cad.*, Fun.LOT_FUN, Vcc.FK_FINANCEIRO_CONTAS, 
       Vcc.FLAG_ATV
  from CADASTROS Cad
  join VINCULOS_CAD_CAT Vcc
    on Vcc.FK_CADASTROS  = Cad.PK_CADASTROS
   and Vcc.FLAG_ATV      = 1
  join CATEGORIAS Cat
    on Cat.PK_CATEGORIAS = Vcc.FK_CATEGORIAS
   and Cat.FLAG_CAT      = 2
  join FUNCIONARIOS Fun
    on Fun.FK_CADASTROS  = Cad.PK_CADASTROS
   and Fun.FLAG_CRG      = 3
 where PK_CADASTROS > 0;

grant SELECT on VW_TECNICOS to PUBLIC;

/*==============================================================*/
/* View: VW_TRANSPORTADORAS                                     */
/*==============================================================*/
create view VW_TRANSPORTADORAS
as
select distinct Cad.*, Vcc.FK_FINANCEIRO_CONTAS, Vcc.FLAG_ATV
  from CADASTROS Cad
  join VINCULOS_CAD_CAT Vcc
    on Vcc.FK_CADASTROS  = Cad.PK_CADASTROS
   and Vcc.FLAG_ATV      = 1
  join CATEGORIAS Cat
    on Cat.PK_CATEGORIAS = Vcc.FK_CATEGORIAS
   and Cat.FLAG_CAT      = 1
  join FORNECEDORES Frn
    on Frn.FK_CADASTROS  = Cad.PK_CADASTROS
   and Frn.FLAG_TRN      = 1
 where PK_CADASTROS > 0;

grant SELECT on VW_TRANSPORTADORAS to PUBLIC;

/*==============================================================*/
/* View: VW_VENDEDORES                                          */
/*==============================================================*/
create view VW_VENDEDORES
as
select distinct Cad.*, Vcc.FK_FINANCEIRO_CONTAS, Vcc.FLAG_ATV
  from CADASTROS Cad
  join VINCULOS_CAD_CAT Vcc
    on Vcc.FK_CADASTROS  = Cad.PK_CADASTROS
   and Vcc.FLAG_ATV      = 1
  join CATEGORIAS Cat
    on Cat.PK_CATEGORIAS = Vcc.FK_CATEGORIAS
   and Cat.FLAG_CAT      = 2
  join FUNCIONARIOS Fun
    on Fun.FK_CADASTROS  = Cad.PK_CADASTROS
   and Fun.FLAG_CRG      in (0, 1, 2)
 where PK_CADASTROS > 0;

grant SELECT on VW_VENDEDORES to PUBLIC;

alter table BAIRROS
   add constraint FK_BAIRROS_MUNICIPIOS foreign key (FK_PAISES, FK_ESTADOS, FK_MUNICIPIOS)
      references MUNICIPIOS (FK_PAISES, FK_ESTADOS, PK_MUNICIPIOS);

alter table CADASTROS
   add constraint FK_CADASTROS_CADASTROS foreign key (FK_CONTATOS)
      references CADASTROS (PK_CADASTROS)
      on delete cascade
      on update cascade;

alter table CADASTROS
   add constraint FK_CADASTROS_MUNICIPIOS foreign key (FK_PAISES, FK_ESTADOS, FK_MUNICIPIOS)
      references MUNICIPIOS (FK_PAISES, FK_ESTADOS, PK_MUNICIPIOS);

alter table CADASTROS
   add constraint FK_CADASTROS_TIPO_ALIAS foreign key (FK_TIPO_ALIAS)
      references TIPO_ALIAS (PK_TIPO_ALIAS);

alter table CADASTROS_CONTATOS
   add constraint FK_CADASTROS_CONTATOS_CADASTROS foreign key (FK_CADASTROS)
      references CADASTROS (PK_CADASTROS)
      on delete cascade
      on update cascade;

alter table CADASTROS_EVENTOS
   add constraint FK_CADASTROS_EVENTOS_CADASTROS foreign key (FK_CADASTROS)
      references CADASTROS (PK_CADASTROS)
      on delete cascade
      on update cascade;

alter table CADASTROS_IMAGENS
   add constraint FK_CADASTROS_IMA_CADASTROS foreign key (FK_CADASTROS)
      references CADASTROS (PK_CADASTROS)
      on delete cascade
      on update cascade;

alter table CADASTROS_INTERNET
   add constraint FK_CADASTROS_INTERNET_CADASTROS foreign key (FK_CADASTROS)
      references CADASTROS (PK_CADASTROS)
      on delete cascade
      on update cascade;

alter table CADASTROS_OBSERVACOES
   add constraint FK_CADASTROS_OBS_CADASTROS foreign key (FK_CADASTROS)
      references CADASTROS (PK_CADASTROS)
      on delete cascade
      on update cascade;

alter table CATEGORIAS
   add constraint FK_CATEGORIAS_FINANCEIRO_CTA foreign key (FK_FINANCEIRO_CONTAS)
      references FINANCEIRO_CONTAS (PK_FINANCEIRO_CONTAS);

alter table CLIENTES
   add constraint FK_CLIENTES_CADASTRO foreign key (FK_CADASTROS)
      references CADASTROS (PK_CADASTROS)
      on delete cascade
      on update cascade;

alter table CLIENTES
   add constraint FK_CLIENTES_PORTOS_DST foreign key (FK_PORTOS__DST)
      references PORTOS (PK_PORTOS);

alter table CLIENTES
   add constraint FK_CLIENTES_PORTOS_EMB foreign key (FK_PORTOS__EMB)
      references PORTOS (PK_PORTOS);

alter table CLIENTES
   add constraint FK_CLIENTES_TIPO_BLOQUEIOS foreign key (FK_TIPO_BLOQUEIOS)
      references TIPO_BLOQUEIOS (PK_TIPO_BLOQUEIOS);

alter table CLIENTES
   add constraint FK_CLIENTES_TIPO_ESTABELEC foreign key (FK_TIPO_ESTABELECIMENTOS)
      references TIPO_ESTABELECIMENTOS (PK_TIPO_ESTABELECIMENTOS);

alter table CLIENTES
   add constraint FK_VW_CADASTROS_CLIENTES foreign key (FK_VW_CADASTROS)
      references CADASTROS (PK_CADASTROS)
      on delete cascade
      on update cascade;

alter table CLIENTES
   add constraint FK_VW_REPRESENTANTES_CLIENTES foreign key (FK_VW_REPRESENTANTES)
      references CADASTROS (PK_CADASTROS)
      on delete cascade
      on update cascade;

alter table CLIENTES
   add constraint FK_VW_TRANSPORTADORAS_CLIENTES foreign key (FK_VW_TRANSPORTADORAS)
      references CADASTROS (PK_CADASTROS)
      on delete cascade
      on update cascade;

alter table CLIENTES
   add constraint FK_CLIENTES_CADASTROS_VND foreign key (FK_VW_VENDEDORES)
      references CADASTROS (PK_CADASTROS)
      on delete cascade
      on update cascade;

alter table COBRANCAS
   add constraint FK_COBRANCAS_CLIENTES foreign key (FK_CLIENTES)
      references CLIENTES (FK_CADASTROS)
      on delete cascade;

alter table COBRANCAS
   add constraint FK_COBRANCAS_MUNICIPIOS foreign key (FK_PAISES, FK_ESTADOS, FK_MUNICIPIOS)
      references MUNICIPIOS (FK_PAISES, FK_ESTADOS, PK_MUNICIPIOS);

alter table DADOS_PESSOAIS
   add constraint FK_DADOS_PESOAIS_CLIENTES foreign key (FK_CLIENTES)
      references CLIENTES (FK_CADASTROS)
      on delete cascade;

alter table DADOS_PESSOAIS
   add constraint FK_DADOS_PESSOAIS_MUNICIPIO foreign key (FK_PAISES, FK_ESTADOS, FK_MUNICIPIOS)
      references MUNICIPIOS (FK_PAISES, FK_ESTADOS, PK_MUNICIPIOS);

alter table ENTREGAS
   add constraint FK_ENTREGAS_CLIENTES foreign key (FK_CLIENTES)
      references CLIENTES (FK_CADASTROS)
      on delete cascade;

alter table ENTREGAS
   add constraint FK_ENTREGAS_MUNICIPIOS foreign key (FK_PAISES, FK_ESTADOS, FK_MUNICIPIOS)
      references MUNICIPIOS (FK_PAISES, FK_ESTADOS, PK_MUNICIPIOS);

alter table ESTADOS
   add constraint FK_ESTADOS_PAISES foreign key (FK_PAISES)
      references PAISES (PK_PAISES);

alter table FINANCEIRO_CONTAS
   add constraint FK_FINANCEIRO_PLANO_CONTAS foreign key (FK_PLANO_CONTAS)
      references PLANO_CONTAS (PK_PLANO_CONTAS);

alter table FINANCEIRO_CONTAS
   add constraint FK_FINANCEIRO_CT_FINANCEIRO_CT foreign key (FK_FINANCEIRO_CONTAS)
      references FINANCEIRO_CONTAS (PK_FINANCEIRO_CONTAS)
      on delete cascade
      on update cascade;

alter table FORNECEDORES
   add constraint FK_FORNECEDORES_CADASTROS foreign key (FK_CADASTROS)
      references CADASTROS (PK_CADASTROS)
      on delete cascade
      on update cascade;

alter table FORNECEDORES
   add constraint FK_FORNECEDORES_DESPACHANTE foreign key (FK_VW_CADASTROS)
      references CADASTROS (PK_CADASTROS);

alter table FORNECEDORES
   add constraint FK_FORNECEDORES_PORTOS_DST foreign key (FK_PORTOS__DST)
      references PORTOS (PK_PORTOS);

alter table FORNECEDORES
   add constraint FK_FORNECEDORES_PORTOS_EMB foreign key (FK_PORTOS__EMB)
      references PORTOS (PK_PORTOS);

alter table FORNECEDORES
   add constraint FK_FORNECEDORES_TRANSPORTADORAS foreign key (FK_VW_TRANSPORTADORAS)
      references CADASTROS (PK_CADASTROS)
       
      on update cascade;

alter table FUNCIONARIOS
   add constraint FK_FUNCIONARIOS_CENTRO_CUSTOS foreign key (FK_CENTRO_CUSTOS)
      references CENTRO_CUSTOS (PK_CENTRO_CUSTOS);

alter table FUNCIONARIOS
   add constraint FK_FUNCIONARIOS_DEPARTAMENTOS foreign key (FK_DEPARTAMENTOS)
      references DEPARTAMENTOS (PK_DEPARTAMENTOS);

alter table FUNCIONARIOS
   add constraint FK_FUNCIONARIOS_EMPRESAS foreign key (FK_EMPRESAS)
      references EMPRESAS (PK_EMPRESAS);

alter table FUNCIONARIOS
   add constraint FK_FUNCIONARIOS_TIPO_COMISSOES foreign key (FK_TIPO_COMISSOES)
      references TIPO_COMISSOES (PK_TIPO_COMISSOES);

alter table FUNCIONARIOS
   add constraint FK_FUNCIONARIO_CADASTRO foreign key (FK_CADASTROS)
      references CADASTROS (PK_CADASTROS)
      on delete cascade
      on update cascade;

alter table INFO_COMERCIAL
   add constraint FK_INFO_COMERCIAL_CADASTROS foreign key (FK_CADASTROS)
      references CADASTROS (PK_CADASTROS);

alter table LOGRADOUROS
   add constraint FK_LOGRADOUROS_BAIRROS foreign key (FK_PAISES, FK_ESTADOS, FK_MUNICIPIOS, FK_BAIRROS)
      references BAIRROS (FK_PAISES, FK_ESTADOS, FK_MUNICIPIOS, PK_BAIRROS);

alter table LOGRADOUROS
   add constraint FK_LOGRADOUROS_TIPO_ENDERECOS foreign key (FK_TIPO_ENDERECOS)
      references TIPO_ENDERECOS (PK_TIPO_ENDERECOS);

alter table MOEDAS
   add constraint FK_MOEDAS_TIPO_MOEDAS foreign key (FK_TIPO_MOEDAS)
      references TIPO_MOEDAS (PK_TIPO_MOEDAS);

alter table MUNICIPIOS
   add constraint FK_MUNICIPIOS_ESTADOS foreign key (FK_PAISES, FK_ESTADOS)
      references ESTADOS (FK_PAISES, PK_ESTADOS);

alter table MUNICIPIOS_ALIQUOTAS
   add constraint FK_MUNICIPIOS_AL_MUNICIPIOS foreign key (FK_PAISES, FK_ESTADOS, FK_MUNICIPIOS)
      references MUNICIPIOS (FK_PAISES, FK_ESTADOS, PK_MUNICIPIOS);

alter table PLANO_CONTAS
   add constraint FK_PLANO_CONTAS_PLANO_CONTAS foreign key (FK_PLANO_CONTAS)
      references PLANO_CONTAS (PK_PLANO_CONTAS)
      on delete cascade
      on update cascade;

alter table PORTOS
   add constraint FK_PORTOS_MUNICIPIOS foreign key (FK_PAISES, FK_ESTADOS, FK_MUNICIPIOS)
      references MUNICIPIOS (FK_PAISES, FK_ESTADOS, PK_MUNICIPIOS);

alter table REFERENCIA_COMERCIAIS
   add constraint FK_REF_COMERCIAIS_CLIENTES foreign key (FK_CLIENTES)
      references CLIENTES (FK_CADASTROS)
      on delete cascade;

alter table SOCIOS
   add constraint FK_SOCIOS_CLIENTES foreign key (FK_CLIENTES)
      references CLIENTES (FK_CADASTROS)
      on delete cascade;

alter table TIPO_COMISSOES
   add constraint FK_TIPO_COMISSOE_FINANCEIRO_CO foreign key (FK_FINANCEIRO_CONTAS)
      references FINANCEIRO_CONTAS (PK_FINANCEIRO_CONTAS);

alter table VINCULOS_CAD_CAT
   add constraint FK_CATEGORIAS_VINCULOS_CAD_CAT foreign key (FK_CATEGORIAS)
      references CATEGORIAS (PK_CATEGORIAS)
      on delete cascade
      on update cascade;

alter table VINCULOS_CAD_CAT
   add constraint FK_VINCULOS_CAD_CAT_CADASTROS foreign key (FK_CADASTROS)
      references CADASTROS (PK_CADASTROS)
      on delete cascade;

alter table VINCULOS_CAD_CAT
   add constraint FK_VINCULOS_CAD__FINANCEIRO_CO foreign key (FK_FINANCEIRO_CONTAS)
      references FINANCEIRO_CONTAS (PK_FINANCEIRO_CONTAS);

alter table VINCULOS_CAD_CAT
   add constraint FK_VINCULO_CAD_EMPRESAS foreign key (FK_EMPRESAS)
      references EMPRESAS (PK_EMPRESAS);

