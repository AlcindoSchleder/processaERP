/*==============================================================*/
/* Database name:  PROCESSA                                     */
/* DBMS name:      Friebird15x                                  */
/* Created on:     7/9/2006 18:30:01                            */
/*==============================================================*/


create generator INSCRICOES;

create generator INSCRICOES_TMP;

create generator SEGMENTOS;

create generator TERCERIZADAS;

create generator TIPO_AREAS_ATUACAO;

create generator TIPO_EVENTOS;

create generator TIPO_SERVICOS;

create generator TIPO_STATUS;

/*==============================================================*/
/* Table: CONTRATOS                                             */
/*==============================================================*/
create table CONTRATOS (
FK_EMPRESAS          VALORI                         not null,
FK_CADASTROS         VALORI                         not null,
PK_CONTRATOS         VALORI                         not null,
FK_TIPO_EVENTOS      VALORS                         not null,
FK_EVENTOS           VALORI                         not null,
FK_TIPO_PAGAMENTOS   VALORS,
LST_PRZ              DESCRICAO_50,
DTA_CTR              DATA                           not null,
VLR_CTR              NUMERO_GRANDE                  not null,
OBS_CTR              BLOB_TEXTO,
MTR_STD              NUMERO_GRANDE_4CD              not null,
RUA_STD              DESCRICAO_10,
NUM_STD              VALORS,
NOM_STD              DESCRICAO_30RQ                 not null,
LOG_EXP              DESCRICAO_10                   not null,
SEN_EXP              DESCRICAO_10                   not null,
SENHA_CRIPTO         DESCRICAO_30RQ                 not null,
FLAG_ENV             FLAG_SIM_NAO                   not null,
FLAG_RET             FLAG_SIM_NAO                   not null,
QTD_CONV             VALORS,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_CONTRATOS primary key (FK_EMPRESAS, FK_CADASTROS, PK_CONTRATOS)
);

grant DELETE,INSERT,UPDATE,SELECT on CONTRATOS to PUBLIC;

/*==============================================================*/
/* Table: CONTRATOS_SERVICOS                                    */
/*==============================================================*/
create table CONTRATOS_SERVICOS (
FK_EMPRESAS          VALORI                         not null,
PK_CONTRATOS         VALORI                         not null,
FK_CADASTROS         VALORI                         not null,
FK_TIPO_SERVICOS     VALORS                         not null,
QTD_SRV              NUMERO_PEQUENO_4CD             not null,
TOT_SRV              NUMERO_MEDIO                   not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_CONTRATOS_SERVICOS primary key (FK_EMPRESAS, PK_CONTRATOS, FK_CADASTROS, FK_TIPO_SERVICOS)
);

grant DELETE,INSERT,UPDATE,SELECT on CONTRATOS_SERVICOS to PUBLIC;

/*==============================================================*/
/* Table: CONTRATOS_TERC_VINC                                   */
/*==============================================================*/
create table CONTRATOS_TERC_VINC (
FK_EMPRESAS          VALORI                         not null,
FK_CADASTROS         VALORI                         not null,
FK_CONTRATOS         VALORI                         not null,
FK_TERCERIZADAS      VALORI                         not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_CONTRATOS_TERC_VINC primary key (FK_EMPRESAS, FK_CADASTROS, FK_CONTRATOS, FK_TERCERIZADAS)
);

grant DELETE,INSERT,UPDATE,SELECT on CONTRATOS_TERC_VINC to PUBLIC;

/*==============================================================*/
/* Table: CONTRATO_EXPFUNC_VINC                                 */
/*==============================================================*/
create table CONTRATO_EXPFUNC_VINC (
FK_EMPRESAS          VALORI                         not null,
FK_CADASTROS         VALORI                         not null,
FK_CONTRATOS         VALORI                         not null,
FK_EXPOSITORES_FUNC  VALORS                         not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_CONTRATO_EXPFUNC_VINC primary key (FK_EMPRESAS, FK_CADASTROS, FK_CONTRATOS, FK_EXPOSITORES_FUNC)
);

grant DELETE,INSERT,UPDATE,SELECT on CONTRATO_EXPFUNC_VINC to PUBLIC;

/*==============================================================*/
/* Table: EVENTOS                                               */
/*==============================================================*/
create table EVENTOS (
FK_EMPRESAS          VALORI                         not null,
FK_TIPO_EVENTOS      VALORS                         not null,
PK_EVENTOS           VALORI                         not null,
DTA_INI              DATA,
DTA_FIN              DATA,
DTA_CR_EXP           DATA,
DTA_CR_MONT          DATA,
DTA_ES_MERC          DATA,
DTA_SRV              DATA,
DTA_EQUIP            DATA,
DTA_CONV             DATA,
NUM_EXP              VALORS,
NUM_CAT              VALORS,
NUM_INS              VALORI,
VLR_MT2              NUMERO_PEQUENO,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_EVENTOS primary key (FK_EMPRESAS, FK_TIPO_EVENTOS, PK_EVENTOS)
);

grant DELETE,INSERT,UPDATE,SELECT on EVENTOS to PUBLIC;

/*==============================================================*/
/* Table: EXPOSITORES_FUNC                                      */
/*==============================================================*/
create table EXPOSITORES_FUNC (
FK_CADASTROS         VALORI                         not null,
PK_EXPOSITORES_FUNC  VALORS                         not null,
NOM_FUNC             DESCRICAO_50RQ                 not null,
CARGO_FUNC           DESCRICAO_30RQ                 not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_EXPOSITORES_FUNC primary key (FK_CADASTROS, PK_EXPOSITORES_FUNC)
);

grant DELETE,INSERT,UPDATE,SELECT on EXPOSITORES_FUNC to PUBLIC;

/*==============================================================*/
/* Table: INSCRICOES                                            */
/*==============================================================*/
create table INSCRICOES (
PK_INSCRICOES        VALORI                         not null,
FK_VW_CLIENTES       VALORI,
FLAG_CAD             FLAG_TIPO_CADASTRO             not null,
DOC_PRI              CNPJ                           not null,
DOC_SEC              DESCRICAO_30,
NOM_INS              DESCRICAO_50RQ                 not null,
NOM_FAN              DESCRICAO_50,
FK_PAISES            VALORI                         not null,
FK_ESTADOS           UF                             not null,
FK_MUNICIPIOS        VALORI,
END_CAD              DESCRICAO_50,
NUM_END              VALORI,
CMP_END              DESCRICAO_30,
CEP_CAD              VALORI,
FON_CAD              PHONE,
FAX_CAD              PHONE,
CRG_INS              DESCRICAO_50RQ                 not null,
EMAIL_CAD            DESCRICAO_50,
FLAG_ETQ             FLAG_SIM_NAO                   not null,
FLAG_EXP             FLAG_SIM_NAO                   not null,
FK_TIPO_STATUS       VALORS                         not null,
DTA_UAC              DATA,
VLR_INS              NUMERO_PEQUENO_4CD,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_INSCRICOES primary key (PK_INSCRICOES)
);

grant SELECT,UPDATE,INSERT,DELETE on INSCRICOES to PUBLIC;

/*==============================================================*/
/* Table: INSCRICOES_EVENTOS_VINC                               */
/*==============================================================*/
create table INSCRICOES_EVENTOS_VINC (
FK_EMPRESAS          VALORI                         not null,
FK_TIPO_EVENTOS      VALORS                         not null,
FK_EVENTOS           VALORI                         not null,
FK_INSCRICOES        VALORI                         not null,
FK_CADASTROS         VALORI,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_INSCRICOES_EVENTOS_VINC primary key (FK_INSCRICOES, FK_EMPRESAS, FK_TIPO_EVENTOS, FK_EVENTOS)
);

grant SELECT,UPDATE,INSERT,DELETE on INSCRICOES_EVENTOS_VINC to PUBLIC;

/*==============================================================*/
/* Table: INSCRICOES_TMP                                        */
/*==============================================================*/
create table INSCRICOES_TMP (
PK_INSCRICOES_TMP    VALORI                         not null,
NOM_INS              DESCRICAO_50,
CRG_INS              DESCRICAO_50,
NOM_FAN              DESCRICAO_50,
RAZ_SOC              DESCRICAO_50,
DOC_SEC              DESCRICAO_30,
ATIVIDADE            DESCRICAO_50,
CEP_INS              DESCRICAO_10,
END_INS              DESCRICAO_50,
CMP_END              DESCRICAO_50,
CIDADE               DESCRICAO_50,
UF                   CHAR(2),
PAIS                 DESCRICAO_50,
FON_CAD              PHONE,
FAX_CAD              PHONE,
EMAIL_CAD            DESCRICAO_50,
constraint PK_INSCRICOES_TMP primary key (PK_INSCRICOES_TMP)
);

grant SELECT,UPDATE,INSERT,DELETE on INSCRICOES_TMP to PUBLIC;

/*==============================================================*/
/* Table: PRECO_SEGMENTOS                                       */
/*==============================================================*/
create table PRECO_SEGMENTOS (
FK_EMPRESAS          VALORI                         not null,
FK_TIPO_EVENTOS      VALORS                         not null,
FK_EVENTOS           VALORI                         not null,
FK_SEGMENTOS         VALORS                         not null,
PRE_SEG              NUMERO_PEQUENO,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PRECO_SEGMENTOS primary key (FK_EMPRESAS, FK_TIPO_EVENTOS, FK_EVENTOS, FK_SEGMENTOS)
);

grant SELECT,UPDATE,INSERT,DELETE on PRECO_SEGMENTOS to PUBLIC;

/*==============================================================*/
/* Table: SEGMENTOS                                             */
/*==============================================================*/
create table SEGMENTOS (
PK_SEGMENTOS         VALORS                         not null,
DSC_SEG              DESCRICAO_30RQ                 not null,
FLAG_AREA            FLAG_SIM_NAO                   not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_SEGMENTOS primary key (PK_SEGMENTOS)
);

grant DELETE,INSERT,UPDATE,SELECT on SEGMENTOS to PUBLIC;

/*==============================================================*/
/* Table: TERCERIZADAS                                          */
/*==============================================================*/
create table TERCERIZADAS (
PK_TERCERIZADAS      VALORI                         not null,
FLAG_CAD             FLAG_TIPO_CADASTRO             not null,
DOC_PRI              CNPJ                           not null,
DOC_SEC              DESCRICAO_30,
NOM_INS              DESCRICAO_50RQ                 not null,
NOM_FAN              DESCRICAO_50,
FK_PAISES            VALORI                         not null,
FK_ESTADOS           UF                             not null,
FK_MUNICIPIOS        VALORI,
END_CAD              DESCRICAO_50,
NUM_END              VALORI,
CMP_END              DESCRICAO_30,
CEP_CAD              VALORI,
FON_CAD              PHONE,
FAX_CAD              PHONE,
CEL_CAD              PHONE,
EMAIL_CAD            DESCRICAO_50,
LOG_TRC              DESCRICAO_10                   not null,
SEN_TRC              DESCRICAO_10                   not null,
SENHA_CRIPTO         DESCRICAO_30RQ                 not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_TERCERIZADAS primary key (PK_TERCERIZADAS)
);

grant DELETE,INSERT,UPDATE,SELECT on TERCERIZADAS to PUBLIC;

/*==============================================================*/
/* Table: TERCERIZADAS_FUNC                                     */
/*==============================================================*/
create table TERCERIZADAS_FUNC (
FK_TERCERIZADAS      VALORI                         not null,
PK_TERCERIZADAS_FUNC VALORS                         not null,
NOM_FUNC             DESCRICAO_50RQ                 not null,
CARGO_FUNC           DESCRICAO_30RQ                 not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_TERCERIZADAS_FUNC primary key (FK_TERCERIZADAS, PK_TERCERIZADAS_FUNC)
);

grant SELECT,UPDATE,INSERT,DELETE on TERCERIZADAS_FUNC to PUBLIC;

/*==============================================================*/
/* Table: TERCERIZADAS_INDICADAS                                */
/*==============================================================*/
create table TERCERIZADAS_INDICADAS (
FK_TIPO_EVENTOS      VALORI                         not null,
PK_TERCERIZADAS      VALORI                         not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_TERCERIZADAS_INDICADAS primary key (FK_TIPO_EVENTOS, PK_TERCERIZADAS)
);

grant DELETE,INSERT,UPDATE,SELECT on TERCERIZADAS_INDICADAS to PUBLIC;

/*==============================================================*/
/* Table: TERC_FUNC_CTR_VINC                                    */
/*==============================================================*/
create table TERC_FUNC_CTR_VINC (
FK_EMPRESAS          VALORI                         not null,
FK_CADASTROS         VALORI                         not null,
FK_CONTRATOS         VALORI                         not null,
FK_TERCERIZADAS      VALORI                         not null,
FK_TERCERIZADAS_FUNC VALORS                         not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_TERC_FUNC_CTR_VINC primary key (FK_EMPRESAS, FK_CADASTROS, FK_CONTRATOS, FK_TERCERIZADAS_FUNC, FK_TERCERIZADAS)
);

grant SELECT,UPDATE,INSERT,DELETE on TERC_FUNC_CTR_VINC to PUBLIC;

/*==============================================================*/
/* Table: TIPO_AREAS_ATUACAO                                    */
/*==============================================================*/
create table TIPO_AREAS_ATUACAO (
PK_TIPO_AREAS_ATUACAO VALORI                         not null,
DSC_TARA             DESCRICAO_30RQ                 not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_TIPO_AREAS_ATUACAO primary key (PK_TIPO_AREAS_ATUACAO)
);

grant SELECT,UPDATE,INSERT,DELETE on TIPO_AREAS_ATUACAO to PUBLIC;

/*==============================================================*/
/* Table: TIPO_EVENTOS                                          */
/*==============================================================*/
create table TIPO_EVENTOS (
PK_TIPO_EVENTOS      VALORI                         not null,
FK_CATEGORIAS        VALORS                         not null,
DSC_TEVT             DESCRICAO_30RQ                 not null,
MTRG_PROM            NUMERO_MEDIO,
QTD_BONUS            NUMERO_PEQUENO,
EMAIL_EVT            DESCRICAO_50RQ                 not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_TIPO_EVENTOS primary key (PK_TIPO_EVENTOS)
);

grant SELECT,UPDATE,INSERT,DELETE on TIPO_EVENTOS to PUBLIC;

/*==============================================================*/
/* Table: TIPO_EVENTOS_AREA_VINC                                */
/*==============================================================*/
create table TIPO_EVENTOS_AREA_VINC (
FK_TIPO_EVENTOS      VALORI                         not null,
FK_TIPO_AREAS_ATUACAO VALORS                         not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_TIPO_EVENTOS_AREA_VINC primary key (FK_TIPO_EVENTOS, FK_TIPO_AREAS_ATUACAO)
);

grant DELETE,INSERT,UPDATE,SELECT on TIPO_EVENTOS_AREA_VINC to PUBLIC;

/*==============================================================*/
/* Table: TIPO_SERVICOS                                         */
/*==============================================================*/
create table TIPO_SERVICOS (
PK_TIPO_SERVICOS     VALORS                         not null,
DSC_TSRV             DESCRICAO_30RQ                 not null,
VLR_TSRV             NUMERO_PEQUENO                 not null,
FK_UNIDADES          VALORS                         not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_TIPO_SERVICOS primary key (PK_TIPO_SERVICOS)
);

grant DELETE,INSERT,UPDATE,SELECT on TIPO_SERVICOS to PUBLIC;

/*==============================================================*/
/* Table: TIPO_STATUS                                           */
/*==============================================================*/
create table TIPO_STATUS (
PK_TIPO_STATUS       VALORS                         not null,
DSC_STT              DESCRICAO_30RQ                 not null,
FLAG_CAD             FLAG_SIM_NAO                   not null,
FLAG_BLOQ            FLAG_SIM_NAO                   not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_TIPO_STATUS primary key (PK_TIPO_STATUS)
);

grant INSERT,UPDATE,SELECT,DELETE on TIPO_STATUS to PUBLIC;

/*==============================================================*/
/* Table: VINCULOS_SEG_INS                                      */
/*==============================================================*/
create table VINCULOS_SEG_INS (
FK_INSCRICOES        VALORI                         not null,
FK_SEGMENTOS         VALORS                         not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_VINCULOS_SEG_INS primary key (FK_INSCRICOES, FK_SEGMENTOS)
);

grant SELECT,UPDATE,INSERT,DELETE on VINCULOS_SEG_INS to PUBLIC;

alter table CONTRATOS
   add constraint FK_CONTRATOS_CADASTROS foreign key (FK_CADASTROS)
      references CADASTROS (PK_CADASTROS);

alter table CONTRATOS
   add constraint FK_CONTRATOS_EVENTOS foreign key (FK_EMPRESAS, FK_TIPO_EVENTOS, FK_EVENTOS)
      references EVENTOS (FK_EMPRESAS, FK_TIPO_EVENTOS, PK_EVENTOS);

alter table CONTRATOS_SERVICOS
   add constraint FK_CONTRATOS_SER_CONTRATOS foreign key (FK_EMPRESAS, FK_CADASTROS, PK_CONTRATOS)
      references CONTRATOS (FK_EMPRESAS, FK_CADASTROS, PK_CONTRATOS);

alter table CONTRATOS_SERVICOS
   add constraint FK_SERVICOS_TIPO_SERVICOS foreign key (FK_TIPO_SERVICOS)
      references TIPO_SERVICOS (PK_TIPO_SERVICOS);

alter table CONTRATOS_TERC_VINC
   add constraint FK_CONTRATOS_TER_TERCERIZADAS foreign key (FK_TERCERIZADAS)
      references TERCERIZADAS (PK_TERCERIZADAS);

alter table CONTRATOS_TERC_VINC
   add constraint FK_CTRTERCVINC_CONTRATOS foreign key (FK_EMPRESAS, FK_CADASTROS, FK_CONTRATOS)
      references CONTRATOS (FK_EMPRESAS, FK_CADASTROS, PK_CONTRATOS)
      on delete cascade
      on update cascade;

alter table CONTRATO_EXPFUNC_VINC
   add constraint FK_CTREXPFVINC_CONTRATOS foreign key (FK_EMPRESAS, FK_CADASTROS, FK_CONTRATOS)
      references CONTRATOS (FK_EMPRESAS, FK_CADASTROS, PK_CONTRATOS)
      on delete cascade
      on update cascade;

alter table CONTRATO_EXPFUNC_VINC
   add constraint FK_EXPOSITORES_FUNC_CTREXPFVINC foreign key (FK_CADASTROS, FK_EXPOSITORES_FUNC)
      references EXPOSITORES_FUNC (FK_CADASTROS, PK_EXPOSITORES_FUNC)
      on delete cascade
      on update cascade;

alter table EVENTOS
   add constraint FK_EVENTOS_EMPRESAS foreign key (FK_EMPRESAS)
      references EMPRESAS (PK_EMPRESAS);

alter table EVENTOS
   add constraint FK_EVENTOS_TIPO_EVENTOS foreign key (FK_TIPO_EVENTOS)
      references TIPO_EVENTOS (PK_TIPO_EVENTOS);

alter table EXPOSITORES_FUNC
   add constraint FK_EXPOSITORES_FUNC_CADASTROS foreign key (FK_CADASTROS)
      references CADASTROS (PK_CADASTROS)
      on delete cascade
      on update cascade;

alter table INSCRICOES
   add constraint FK_INSCRICOES_EVT_TIPO_STATUS foreign key (FK_TIPO_STATUS)
      references TIPO_STATUS (PK_TIPO_STATUS);

alter table INSCRICOES_EVENTOS_VINC
   add constraint FK_INSCRICOES_EV_CADASTROS foreign key (FK_CADASTROS)
      references CADASTROS (PK_CADASTROS);

alter table INSCRICOES_EVENTOS_VINC
   add constraint FK_INSCRICOES_EV_EVENTOS foreign key (FK_EMPRESAS, FK_TIPO_EVENTOS, FK_EVENTOS)
      references EVENTOS (FK_EMPRESAS, FK_TIPO_EVENTOS, PK_EVENTOS);

alter table INSCRICOES_EVENTOS_VINC
   add constraint FK_INSCRICOES_EV_INSCRICOES foreign key (FK_INSCRICOES)
      references INSCRICOES (PK_INSCRICOES);

alter table PRECO_SEGMENTOS
   add constraint FK_PRECOS_SEGMENTO_EVENTOS foreign key (FK_EMPRESAS, FK_TIPO_EVENTOS, FK_EVENTOS)
      references EVENTOS (FK_EMPRESAS, FK_TIPO_EVENTOS, PK_EVENTOS)
      on delete cascade
      on update cascade;

alter table PRECO_SEGMENTOS
   add constraint FK_PRECO_SEGMENTOS_SEGMENTOS foreign key (FK_SEGMENTOS)
      references SEGMENTOS (PK_SEGMENTOS);

alter table TERCERIZADAS_FUNC
   add constraint FK_TERCERIZADAS__TERCERIZADAS foreign key (FK_TERCERIZADAS)
      references TERCERIZADAS (PK_TERCERIZADAS)
      on delete cascade
      on update cascade;

alter table TERCERIZADAS_INDICADAS
   add constraint FK_TERCE_IND_TERCERIZADAS foreign key (PK_TERCERIZADAS)
      references TERCERIZADAS (PK_TERCERIZADAS)
      on delete cascade
      on update cascade;

alter table TERCERIZADAS_INDICADAS
   add constraint FK_TERCE_IND_TIPO_EVENTOS foreign key (FK_TIPO_EVENTOS)
      references TIPO_EVENTOS (PK_TIPO_EVENTOS)
      on delete cascade
      on update cascade;

alter table TERC_FUNC_CTR_VINC
   add constraint FK_TERC_FUNC_CTR_CONTRATOS_TER foreign key (FK_EMPRESAS, FK_CADASTROS, FK_CONTRATOS, FK_TERCERIZADAS)
      references CONTRATOS_TERC_VINC (FK_EMPRESAS, FK_CADASTROS, FK_CONTRATOS, FK_TERCERIZADAS)
      on delete cascade
      on update cascade;

alter table TERC_FUNC_CTR_VINC
   add constraint FK_TERCE_F_TERCE_F foreign key (FK_TERCERIZADAS, FK_TERCERIZADAS_FUNC)
      references TERCERIZADAS_FUNC (FK_TERCERIZADAS, PK_TERCERIZADAS_FUNC);

alter table TIPO_EVENTOS
   add constraint FK_TIPO_EVENTOS_CATEGORIAS foreign key (FK_CATEGORIAS)
      references CATEGORIAS (PK_CATEGORIAS);

alter table TIPO_EVENTOS_AREA_VINC
   add constraint FK_TIPO_EVENTOS_TPEVAREAVINC foreign key (FK_TIPO_EVENTOS)
      references TIPO_EVENTOS (PK_TIPO_EVENTOS);

alter table TIPO_EVENTOS_AREA_VINC
   add constraint FK_TPEVTAREAVINC_TIPO_AREAS foreign key (FK_TIPO_AREAS_ATUACAO)
      references TIPO_AREAS_ATUACAO (PK_TIPO_AREAS_ATUACAO);

alter table VINCULOS_SEG_INS
   add constraint FK_SEGMENTO_INSCRICAO_SEGMENTO foreign key (FK_INSCRICOES)
      references INSCRICOES (PK_INSCRICOES)
      on delete cascade
      on update cascade;

alter table VINCULOS_SEG_INS
   add constraint FK_VINCULOS_SEG_SEGMENTO foreign key (FK_SEGMENTOS)
      references SEGMENTOS (PK_SEGMENTOS);

