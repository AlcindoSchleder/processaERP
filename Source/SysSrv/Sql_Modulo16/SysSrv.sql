/*==============================================================*/
/* Database name:  PROCESSA                                     */
/* DBMS name:      InterBase 6.x                                */
/* Created on:     30/03/2006 17:58:38                          */
/*==============================================================*/


create generator ORDENS_SERVICOS_BLQ;

create generator TIPO_ORDENS_SERVICOS;

create generator TIPO_STATUS_OS;

/*==============================================================*/
/* Table: LIMITES_MUNICIPIOS                                    */
/*==============================================================*/
create table LIMITES_MUNICIPIOS (
FK_EMPRESAS          VALORI                         not null,
FK_RODOVIAS          VALORS                         not null,
PK_LIMITES_MUNICIPIOS VALORI                         not null,
FK_PAISES            VALORI                         not null,
FK_ESTADOS           UF                             not null,
FK_MUNICIPIOS        VALORI                         not null,
FK_UNIDADES          VALORS                         not null,
KM_INI               NUMERO_PEQUENO_4CD             not null,
KM_FIN               NUMERO_PEQUENO_4CD             not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_LIMITES_MUNICIPIOS primary key (FK_EMPRESAS, FK_RODOVIAS, PK_LIMITES_MUNICIPIOS)
);

grant all on LIMITES_MUNICIPIOS to public;
/*==============================================================*/
/* Table: ORDENS_SERVICOS                                       */
/*==============================================================*/
create table ORDENS_SERVICOS (
FK_EMPRESAS          VALORI                         not null,
PK_ORDENS_SERVICOS   VALORI                         not null,
FK_CADASTROS         VALORI,
FK_RODOVIAS          VALORS,
FK_TIPO_ORDENS_SERVICOS VALORS,
FK_TIPO_STATUS_OS    VALORS,
FK_TIPO_PAGAMENTOS   VALORS,
FK_GRUPOS_MOVIMENTOS VALORS,
FK_TIPO_MOVIMENTOS   VALORS,
DSC_ORD              DESCRICAO_100,
LST_PRZ              DESCRICAO_50,
DTA_INI              DATA                           not null,
DTA_FIN              DATA                           not null,
DTA_APR              DATA,
DTA_LIB_FIN          DATA,
DTA_OS               DATA_DEF,
DTA_CANC             DATA,
DTA_LIQ              DATA,
DTA_BLQ              VALORS,
SUB_TOT              NUMERO_GRANDE_4CD,
VLR_ACR_DSCT         NUMERO_PEQUENO_4CD,
TOT_ORD              NUMERO_GRANDE_4CD,
QTD_ITEMS            VALORS,
COD_AUT              VALORI,
KEY_ITEMS            VALORS                         not null,
FLAG_LPREV           FLAG_SIM_NAO                   not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_ORDENS_SERVICOS primary key (PK_ORDENS_SERVICOS, FK_EMPRESAS)
);

grant all on ORDENS_SERVICOS to public;
/*==============================================================*/
/* Index: IDX_ORDENS_SERVICOS001                                */
/*==============================================================*/
create asc index IDX_ORDENS_SERVICOS001 on ORDENS_SERVICOS (
FK_EMPRESAS,
DTA_OS,
PK_ORDENS_SERVICOS
);

/*==============================================================*/
/* Table: ORDENS_SERVICOS_ITENS                                 */
/*==============================================================*/
create table ORDENS_SERVICOS_ITENS (
FK_EMPRESAS          VALORI                         not null,
FK_ORDENS_SERVICOS   VALORI                         not null,
PK_ORDENS_SERVICOS_ITENS VALORS                         not null,
FK_CLASSIFICACAO     VALORI                         not null,
FK_PRODUTOS_SERVICOS VALORI,
DTA_FAT              DATA,
FLAG_PERS            FLAG_SIM_NAO                   not null,
FLAG_TQTD            FLAG,
QTD_SRV              NUMERO_PEQUENO_4CD             not null,
ALT_SRV              NUMERO_PEQUENO_4CD,
LARG_SRV             NUMERO_PEQUENO_4CD,
COMP_SRV             NUMERO_PEQUENO_4CD,
VLR_UNIT             NUMERO_MEDIO_4CD               not null,
TOT_SRV              NUMERO_MEDIO_4CD               not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_ORDENS_SERVICOS_ITENS primary key (FK_EMPRESAS, FK_ORDENS_SERVICOS, PK_ORDENS_SERVICOS_ITENS)
);

grant all on ORDENS_SERVICOS_ITENS to public;
/*==============================================================*/
/* Table: ORDENS_SERVICOS_ITENS_INSUMO                          */
/*==============================================================*/
create table ORDENS_SERVICOS_ITENS_INSUMO (
FK_EMPRESAS          VALORI                         not null,
FK_ORDENS_SERVICOS   VALORI                         not null,
FK_OS_ITENS          VALORS                         not null,
SEQ_ITEM             VALORI                         not null,
FK_INSUMO            VALORI                         not null,
FLAG_TINS            FLAG_TIPO_ITEM_OS              not null,
FLAG_FRN             FLAG_SIM_NAO                   not null,
FLAG_QTD             FLAG                           not null,
QTD_INS              NUMERO_PEQUENO_4CD,
ALT_INS              NUMERO_PEQUENO_4CD,
LARG_INS             NUMERO_PEQUENO_4CD,
COMP_INS             NUMERO_PEQUENO_4CD,
VLR_UNIT             NUMERO_MEDIO_4CD,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_ORDENS_SERVICOS_ITENS_INSUM primary key (FK_EMPRESAS, FK_ORDENS_SERVICOS, FK_OS_ITENS, SEQ_ITEM)
);

grant all on ORDENS_SERVICOS_ITENS_INSUMO to public;
/*==============================================================*/
/* Table: ORDENS_SERVICOS_ITENS_LOCAL                           */
/*==============================================================*/
create table ORDENS_SERVICOS_ITENS_LOCAL (
FK_EMPRESAS          VALORI                         not null,
FK_ORDENS_SERVICOS   VALORI                         not null,
FK_ORDENS_SERVICOS_ITENS VALORS                         not null,
LOC_INI              NUMERO_PEQUENO_4CD,
LOC_FIN              NUMERO_PEQUENO_4CD,
FLAG_SIDE            FLAG_LADO_ED                   not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_ORDENS_SERVICOS_ITENS_LOCAL primary key (FK_EMPRESAS, FK_ORDENS_SERVICOS, FK_ORDENS_SERVICOS_ITENS)
);

grant all on ORDENS_SERVICOS_ITENS_LOCAL to public;
/*==============================================================*/
/* Table: OS_HISTORICOS                                         */
/*==============================================================*/
create table OS_HISTORICOS (
FK_EMPRESAS          VALORI                         not null,
FK_ORDENS_SERVICOS   VALORI                         not null,
PK_OS_HISTORICOS     VALORI                         not null,
FK_TIPO_STATUS_OS    VALORS,
FK_ORDENS_SERVICOS_ITENS VALORI,
SEQ_INS              VALORI,
DTA_HIST             DATA_HORA_DEF                  not null,
COD_AUT              VALORI,
DSC_HIST             DESCRICAO_30RQ                 not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_OS_HISTORICOS primary key (FK_ORDENS_SERVICOS, FK_EMPRESAS, PK_OS_HISTORICOS)
);

grant all on OS_HISTORICOS to public;
/*==============================================================*/
/* Table: PARAMETROS_SRV                                        */
/*==============================================================*/
create table PARAMETROS_SRV (
FK_EMPRESAS          VALORI                         not null,
FK_TIPO_STATUS_OS    VALORS,
FK_TIPO_ORDENS_SERVICOS VALORS,
FLAG_EDTSRV          FLAG_SIM_NAO                   not null,
FLAG_EDTCOMP         FLAG_SIM_NAO                   not null,
FLAG_EDTVAL_ABRT     FLAG_SIM_NAO                   not null,
KEY_RODOVIAS         VALORS                         not null,
KEY_PRACAS           VALORS                         not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PARAMETROS_SRV primary key (FK_EMPRESAS)
);

grant all on PARAMETROS_SRV to public;
/*==============================================================*/
/* Table: PRACAS                                                */
/*==============================================================*/
create table PRACAS (
FK_EMPRESAS          VALORI                         not null,
PK_PRACAS            VALORS                         not null,
FK_RODOVIAS          VALORS                         not null,
DSC_PRC              DESCRICAO_30RQ                 not null,
POS_TRC              NUMERO_PEQUENO_4CD             not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PRACAS primary key (FK_EMPRESAS, PK_PRACAS)
);

grant all on PRACAS to public;
/*==============================================================*/
/* Table: RODOVIAS                                              */
/*==============================================================*/
create table RODOVIAS (
FK_EMPRESAS          VALORI                         not null,
PK_RODOVIAS          VALORS                         not null,
DSC_ROD              DESCRICAO_30RQ                 not null,
KM_INI               NUMERO_PEQUENO_4CD,
KM_FIN               NUMERO_PEQUENO_4CD,
EXT_TOT_ROD          NUMERO_MEDIO_4CD,
EXT_ROD_POLO         NUMERO_MEDIO_4CD               not null,
KC_TRECHOS_GERENCIAIS VALORS,
KC_LIMITES_MUNICIPIOS VALORS,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_RODOVIAS primary key (FK_EMPRESAS, PK_RODOVIAS)
);

grant all on RODOVIAS to public;
/*==============================================================*/
/* Table: TIPO_ORDENS_SERVICOS                                  */
/*==============================================================*/
create table TIPO_ORDENS_SERVICOS (
PK_TIPO_ORDENS_SERVICOS VALORS                         not null,
FK_TIPO_DOCUMENTOS   VALORS,
FK_GRUPOS_MOVIMENTOS VALORS,
DSC_TOS              DESCRICAO_30RQ                 not null,
FLAG_TOS             FLAG                           not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_TIPO_ORDENS_SERVICOS primary key (PK_TIPO_ORDENS_SERVICOS)
);

grant all on TIPO_ORDENS_SERVICOS to public;
/*==============================================================*/
/* Index: IDX_TIPO_ORDENS_SERVICOS_001                          */
/*==============================================================*/
create asc index IDX_TIPO_ORDENS_SERVICOS_001 on TIPO_ORDENS_SERVICOS (
FK_GRUPOS_MOVIMENTOS,
PK_TIPO_ORDENS_SERVICOS
);

/*==============================================================*/
/* Table: TIPO_STATUS_OS                                        */
/*==============================================================*/
create table TIPO_STATUS_OS (
PK_TIPO_STATUS_OS    VALORS                         not null,
DSC_STT              DESCRICAO_30RQ                 not null,
FLAG_STT             FLAG_TIPO_STATUS_OS            not null,
FLAG_AUT             FLAG_SIM_NAO                   not null,
OPE_MSG              NOME_OPERADOR,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_TIPO_STATUS_OS primary key (PK_TIPO_STATUS_OS)
);

grant all on TIPO_STATUS_OS to public;
/*==============================================================*/
/* Table: TRECHOS_GERENCIAIS                                    */
/*==============================================================*/
create table TRECHOS_GERENCIAIS (
FK_EMPRESAS          VALORI                         not null,
FK_RODOVIAS          VALORS                         not null,
PK_TRECHOS_GERENCIAIS VALORS                         not null,
KM_INI               NUMERO_PEQUENO_4CD             not null,
KM_FIN               NUMERO_PEQUENO_4CD             not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_TRECHOS_GERENCIAIS primary key (PK_TRECHOS_GERENCIAIS, FK_RODOVIAS, FK_EMPRESAS)
);

grant all on TRECHOS_GERENCIAIS to public;
alter table LIMITES_MUNICIPIOS
   add constraint FK_LIMITES_MUNIC_RODOVIAS foreign key (FK_EMPRESAS, FK_RODOVIAS)
      references RODOVIAS (FK_EMPRESAS, PK_RODOVIAS);

alter table ORDENS_SERVICOS
   add constraint FK_ORDENS_SERVIC_CADASTROS foreign key (FK_CADASTROS)
      references CADASTROS (PK_CADASTROS);

alter table ORDENS_SERVICOS
   add constraint FK_ORDENS_SERVIC_EMPRESAS foreign key (FK_EMPRESAS)
      references EMPRESAS (PK_EMPRESAS);

alter table ORDENS_SERVICOS
   add constraint FK_ORDENS_SERVIC_RODOVIAS foreign key (FK_EMPRESAS, FK_RODOVIAS)
      references RODOVIAS (FK_EMPRESAS, PK_RODOVIAS);

alter table ORDENS_SERVICOS
   add constraint FK_ORDENS_SERVIC_TIPO_MOVIMENT foreign key (FK_GRUPOS_MOVIMENTOS, FK_TIPO_MOVIMENTOS)
      references TIPO_MOVIMENTOS (FK_GRUPOS_MOVIMENTOS, PK_TIPO_MOVIMENTOS);

alter table ORDENS_SERVICOS
   add constraint FK_ORDENS_SERVIC_TIPO_PAGAMENT foreign key (FK_TIPO_PAGAMENTOS)
      references TIPO_PAGAMENTOS (PK_TIPO_PAGAMENTOS);

alter table ORDENS_SERVICOS
   add constraint FK_ORDENS_SERVIC_TIPO_STATUS_O foreign key (FK_TIPO_STATUS_OS)
      references TIPO_STATUS_OS (PK_TIPO_STATUS_OS);

alter table ORDENS_SERVICOS
   add constraint FK_ORDENS_SERVIC_TIPO_ORDENS_S foreign key (FK_TIPO_ORDENS_SERVICOS)
      references TIPO_ORDENS_SERVICOS (PK_TIPO_ORDENS_SERVICOS);

alter table ORDENS_SERVICOS_ITENS
   add constraint FK_ORDENS_SERVIC_CLASSIFICACAO foreign key (FK_CLASSIFICACAO)
      references CLASSIFICACAO (PK_CLASSIFICACAO);

alter table ORDENS_SERVICOS_ITENS
   add constraint FK_ORDENS_SERVIC_ORDSRV_ITENS foreign key (FK_ORDENS_SERVICOS, FK_EMPRESAS)
      references ORDENS_SERVICOS (PK_ORDENS_SERVICOS, FK_EMPRESAS)
      on delete cascade;

alter table ORDENS_SERVICOS_ITENS
   add constraint FK_ORDENS_SERVIC_PRODUTOS_SERV foreign key (FK_PRODUTOS_SERVICOS)
      references PRODUTOS_SERVICOS (FK_PRODUTOS);

alter table ORDENS_SERVICOS_ITENS_INSUMO
   add constraint FK_OS_ITENS_OS_ITENS_INSUMOS foreign key (FK_EMPRESAS, FK_ORDENS_SERVICOS, FK_OS_ITENS)
      references ORDENS_SERVICOS_ITENS (FK_EMPRESAS, FK_ORDENS_SERVICOS, PK_ORDENS_SERVICOS_ITENS)
      on delete cascade;

alter table ORDENS_SERVICOS_ITENS_LOCAL
   add constraint FK_ORDENS_SERVICOS_ORDENS_LOCAL foreign key (FK_EMPRESAS, FK_ORDENS_SERVICOS, FK_ORDENS_SERVICOS_ITENS)
      references ORDENS_SERVICOS_ITENS (FK_EMPRESAS, FK_ORDENS_SERVICOS, PK_ORDENS_SERVICOS_ITENS)
      on delete cascade;

alter table OS_HISTORICOS
   add constraint FK_OS_HISTORICOS_ORDENS_SERVIC foreign key (FK_ORDENS_SERVICOS, FK_EMPRESAS)
      references ORDENS_SERVICOS (PK_ORDENS_SERVICOS, FK_EMPRESAS)
      on delete cascade
      on update cascade;

alter table OS_HISTORICOS
   add constraint FK_OS_HISTORICOS_TIPO_STATUS_O foreign key (FK_TIPO_STATUS_OS)
      references TIPO_STATUS_OS (PK_TIPO_STATUS_OS);

alter table PARAMETROS_SRV
   add constraint FK_PARAMETROS_SRV_EMPRESAS foreign key (FK_EMPRESAS)
      references EMPRESAS (PK_EMPRESAS);

alter table PRACAS
   add constraint FK_PRACAS_EMPRESAS foreign key (FK_EMPRESAS)
      references EMPRESAS (PK_EMPRESAS);

alter table PRACAS
   add constraint FK_PRACAS_RODOVIAS foreign key (FK_EMPRESAS, FK_RODOVIAS)
      references RODOVIAS (FK_EMPRESAS, PK_RODOVIAS);

alter table RODOVIAS
   add constraint FK_RODOVIAS_EMPRESAS foreign key (FK_EMPRESAS)
      references EMPRESAS (PK_EMPRESAS);

alter table TIPO_ORDENS_SERVICOS
   add constraint FK_TIPO_ORDENS_S_GRUPOS_MOVIME foreign key (FK_GRUPOS_MOVIMENTOS)
      references GRUPOS_MOVIMENTOS (PK_GRUPOS_MOVIMENTOS);

alter table TIPO_ORDENS_SERVICOS
   add constraint FK_TIPO_ORDENS_S_TIPO_DOCUMENT foreign key (FK_TIPO_DOCUMENTOS)
      references TIPO_DOCUMENTOS (PK_TIPO_DOCUMENTOS);

alter table TRECHOS_GERENCIAIS
   add constraint FK_TRECHOS_GEREN_RODOVIAS foreign key (FK_EMPRESAS, FK_RODOVIAS)
      references RODOVIAS (FK_EMPRESAS, PK_RODOVIAS);

