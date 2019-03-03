/*==============================================================*/
/* Database name:  PROCESSA                                     */
/* DBMS name:      InterBase 6.x                                */
/* Created on:     20/04/2006 11:03:30                          */
/*==============================================================*/


create generator HISTORICOS_PADRAO;

create generator OPERACOES_FINANCEIRAS;

create generator TIPO_CONTAS;

/*==============================================================*/
/* Table: BANCOS                                                */
/*==============================================================*/
create table BANCOS (
PK_BANCOS            VALORS                         not null,
DSC_BCO              DESCRICAO_50RQ                 not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_BANCOS primary key (PK_BANCOS)
);

alter table CLIENTES
   add constraint FK_BANCOS_CLIENTES foreign key (FK_BANCOS)
      references BANCOS (PK_BANCOS);

grant SELECT,UPDATE,INSERT,DELETE on BANCOS to PUBLIC;

/*==============================================================*/
/* Table: BANCOS_AGENCIAS                                       */
/*==============================================================*/
create table BANCOS_AGENCIAS (
FK_BANCOS            VALORS                         not null,
PK_AGENCIAS          DESCRICAO_20RQ                 not null,
FK_CADASTROS         VALORI,
DSC_AGE              DESCRICAO_50RQ                 not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_BANCOS_AGENCIAS primary key (FK_BANCOS, PK_AGENCIAS)
);

grant SELECT,UPDATE,INSERT,DELETE on BANCOS_AGENCIAS to PUBLIC;

/*==============================================================*/
/* Table: BANCOS_CONTAS                                         */
/*==============================================================*/
create table BANCOS_CONTAS (
FK_EMPRESAS          VALORI                         not null,
FK_TIPO_CONTAS       VALORI                         not null,
FK_AGENCIAS          DESCRICAO_20RQ                 not null,
FK_BANCOS            VALORS                         not null,
FK_CONTAS            VALORS                         not null,
COD_CTA              DESCRICAO_20RQ                 not null,
NUM_INITL            VALORI,
PAG_NUM              VALORS,
NUM_CHQ              VALORI,
NUM_REM              VALORI,
SLD_PRVST            NUMERO_GRANDE_4CD,
SLD_REAL             NUMERO_GRANDE_4CD,
NUM_CTR              DESCRICAO_20,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_BANCOS_CONTAS primary key (FK_BANCOS, FK_AGENCIAS, FK_EMPRESAS, FK_TIPO_CONTAS, FK_CONTAS)
);

grant SELECT,UPDATE,INSERT,DELETE on BANCOS_CONTAS to PUBLIC;

/*==============================================================*/
/* Table: CLASSIFICACAO_DOCUMENTOS                              */
/*==============================================================*/
create table CLASSIFICACAO_DOCUMENTOS (
FK_EMPRESAS          VALORI                         not null,
FK_CLASSIFICACAO     VALORI                         not null,
PK_CLASSIFICACAO_DOCUMENTOS VALORI                         not null,
FK_DOCUMENTOS        VALORI                         not null,
FK_TIPO_DOCUMENTOS   VALORS                         not null,
FK_CADASTROS         VALORI                         not null,
DSC_LAN              DESCRICAO_50RQ                 not null,
FLAG_PREV            FLAG_SIM_NAO                   not null,
FLAG_TDOC            FLAG_TIPO_DOCUMENTO            not null,
DTA_LAN              DATA_DEF                       not null,
VLR_LAN              NUMERO_MEDIO_4CD               not null,
FLAG_DBCR            FLAG_DEBITO_CREDITO            not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_CLASSIFICACAO_DOCUMENTOS primary key (FK_EMPRESAS, FK_CLASSIFICACAO, PK_CLASSIFICACAO_DOCUMENTOS)
);

grant all on CLASSIFICACAO_DOCUMENTOS to public;
/*==============================================================*/
/* Table: CLASSIFICACAO_SALDOS                                  */
/*==============================================================*/
create table CLASSIFICACAO_SALDOS (
FK_EMPRESAS          VALORI                         not null,
FK_CLASSIFICACAO     VALORI                         not null,
PK_CLASSIFICACAO_SALDOS DATA_DEF                       not null,
SLD_CLAS             NUMERO_GRANDE_4CD,
SLD_PREV             NUMERO_GRANDE_4CD,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_CLASSIFICACAO_SALDOS primary key (FK_EMPRESAS, FK_CLASSIFICACAO, PK_CLASSIFICACAO_SALDOS)
);

grant SELECT,UPDATE,INSERT,DELETE on CLASSIFICACAO_SALDOS to PUBLIC;

/*==============================================================*/
/* Table: CONTAS                                                */
/*==============================================================*/
create table CONTAS (
FK_EMPRESAS          VALORI                         not null,
FK_TIPO_CONTAS       VALORI                         not null,
PK_CONTAS            VALORS                         not null,
DSC_CTA              DESCRICAO_30RQ                 not null,
SLD_CTA              NUMERO_GRANDE_4CD              not null,
SLD_PREV             NUMERO_GRANDE_4CD,
SLD_INI              NUMERO_GRANDE_4CD              not null,
DTA_FCH              DATA,
DTA_ABR              DATA,
DTA_SLD              DATA,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_CONTACOR primary key (FK_EMPRESAS, FK_TIPO_CONTAS, PK_CONTAS)
);

grant SELECT,UPDATE,INSERT,DELETE on CONTAS to PUBLIC;

/*==============================================================*/
/* Table: CONTAS_DOCUMENTOS                                     */
/*==============================================================*/
create table CONTAS_DOCUMENTOS (
FK_EMPRESAS          VALORI                         not null,
FK_CONTAS_LANCAMENTOS VALORI                         not null,
FK_DOCUMENTOS        VALORI                         not null,
FK_TIPO_DOCUMENTOS   VALORS                         not null,
FK_CADASTROS         VALORI                         not null,
FLAG_TDOC            FLAG_TIPO_DOCUMENTO            not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_CONTAS_DOCUMENTOS primary key (FK_EMPRESAS, FK_DOCUMENTOS, FK_TIPO_DOCUMENTOS, FK_CADASTROS, FK_CONTAS_LANCAMENTOS)
);

grant SELECT,UPDATE,INSERT,DELETE on CONTAS_DOCUMENTOS to PUBLIC;

/*==============================================================*/
/* Table: CONTAS_LANCAMENTOS                                    */
/*==============================================================*/
create table CONTAS_LANCAMENTOS (
FK_EMPRESAS          VALORI                         not null,
PK_CONTAS_LANCAMENTOS VALORI                         not null,
FK_EMPRESAS__CTA     VALORI,
FK_TIPO_CONTAS       VALORI,
FK_CONTAS            VALORS,
FK_FINALIZADORAS     VALORS,
FK_OPERACOES_FINANCEIRAS VALORS                         not null,
FK_CADASTROS         VALORI                         not null,
FK_HITORICOS_PADRAO  VALORS,
DSC_LAN              DESCRICAO_50RQ                 not null,
NUM_DOC_QUIT         VALORI,
DTA_QUIT             DATA_HORA,
DTA_LAN              DATA                           not null,
VLR_LAN              NUMERO_GRANDE_4CD              not null,
FLAG_DBCR            FLAG_DEBITO_CREDITO            not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_CONTAS_LANCAMENTOS primary key (FK_EMPRESAS, PK_CONTAS_LANCAMENTOS)
);

grant SELECT,UPDATE,INSERT,DELETE on CONTAS_LANCAMENTOS to PUBLIC;

/*==============================================================*/
/* Table: CONTAS_LANCAMENTOS_TRF                                */
/*==============================================================*/
create table CONTAS_LANCAMENTOS_TRF (
FK_EMPRESAS          VALORI                         not null,
PK_CONTAS_LANCAMENTOS_TRF VALORI                         not null,
FK_EMPRESAS__DB      VALORI,
FK_CONTAS_LANCAMENTOS__DB VALORI                         not null,
FK_EMPRESAS__CR      VALORI                         not null,
FK_CONTAS_LANCAMENTOS__CR VALORI                         not null,
FK_TIPO_CONTAS__DB   VALORI,
FK_CONTAS__DB        VALORS,
FK_TIPO_CONTAS__CR   VALORI                         not null,
FK_CONTAS__CR        VALORS                         not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_CONTAS_LANCAMENTOS_TRF primary key (FK_EMPRESAS, PK_CONTAS_LANCAMENTOS_TRF)
);

grant SELECT,UPDATE,INSERT,DELETE on CONTAS_LANCAMENTOS_TRF to PUBLIC;

/*==============================================================*/
/* Table: CONTAS_SALDOS                                         */
/*==============================================================*/
create table CONTAS_SALDOS (
FK_EMPRESAS          VALORI                         not null,
PK_CONTAS_SALDOS     DATA_DEF                       not null,
FK_CONTAS_LANCAMENTOS VALORI                         not null,
FK_EMPRESAS__CTA     VALORI,
FK_TIPO_CONTAS       VALORI,
FK_CONTAS            VALORS,
SLD_GER              NUMERO_GRANDE_4CD              not null,
SLD_CTA              NUMERO_GRANDE_4CD              not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_CONTAS_SALDOS primary key (FK_EMPRESAS, PK_CONTAS_SALDOS)
);

grant SELECT,UPDATE,INSERT,DELETE on CONTAS_SALDOS to PUBLIC;

/*==============================================================*/
/* Table: HISTORICOS_PADRAO                                     */
/*==============================================================*/
create table HISTORICOS_PADRAO (
PK_HITORICOS_PADRAO  VALORS                         not null,
DSC_HST              DESCRICAO_50RQ                 not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_HISTORICOS_PADRAO primary key (PK_HITORICOS_PADRAO)
);

grant SELECT,INSERT,UPDATE,DELETE on HISTORICOS_PADRAO to PUBLIC;

/*==============================================================*/
/* Table: MOD_BCCX_KEYS                                         */
/*==============================================================*/
create table MOD_BCCX_KEYS (
FK_EMPRESAS          VALORI                         not null,
KC_CONTAS_LANCAMENTOS VALORI                         default 0 not null,
KC_CONTAS_LANCAMENTOS_TRF VALORI                         default 0 not null,
KC_PARAMETROS_PDV    VALORS                         not null,
constraint PK_MOD_BCCX_KEYS primary key (FK_EMPRESAS)
);

grant SELECT,UPDATE,INSERT,DELETE on MOD_BCCX_KEYS to PUBLIC;

/*==============================================================*/
/* Table: OPERACOES_FINANCEIRAS                                 */
/*==============================================================*/
create table OPERACOES_FINANCEIRAS (
PK_OPERACOES_FINANCEIRAS VALORS                         not null,
FK_OPERACOES_FINANCEIRAS__DB VALORS,
FK_OPERACOES_FINANCEIRAS__CR VALORS,
DSC_OPE              DESCRICAO_30RQ                 not null,
FLAG_DBCR            FLAG_DEBITO_CREDITO            not null,
FLAG_BAIXA           FLAG_SIM_NAO                   not null,
FLAG_TRF             FLAG_SIM_NAO                   not null,
FLAG_EST             FLAG_SIM_NAO                   not null,
FLAG_GSLD            FLAG_SIM_NAO                   not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_OPERACOES_FINANCEIRAS primary key (PK_OPERACOES_FINANCEIRAS)
);

grant all on OPERACOES_FINANCEIRAS to public;
/*==============================================================*/
/* Table: OPERACOES_FIN_X_TIPO_DOCUMENTOS                       */
/*==============================================================*/
create table OPERACOES_FIN_X_TIPO_DOCUMENTOS (
FK_OPERACOES_FINANCEIRAS VALORS                         not null,
FK_TIPO_DOCUMENTOS   VALORS                         not null,
FLAG_DEF             FLAG_SIM_NAO                   not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_OPER_FIN_X_TIPO_DOC primary key (FK_OPERACOES_FINANCEIRAS, FK_TIPO_DOCUMENTOS)
);

grant SELECT,UPDATE,INSERT,DELETE on OPERACOES_FIN_X_TIPO_DOCUMENTOS to PUBLIC;

/*==============================================================*/
/* Table: PARAMETROS_PDV                                        */
/*==============================================================*/
create table PARAMETROS_PDV (
FK_EMPRESAS          VALORI                         not null,
PK_PARAMETROS_PDV    VALORS                         not null,
FK_EMPRESAS_CONTAS   VALORI,
FK_TIPO_CONTAS       VALORI,
FK_CONTAS            VALORS,
FK_OPERACOES_ABERTURA VALORS                         not null,
FK_OPERACOES_VENDA   VALORS,
FK_OPERACOES_ESTORNO VALORS                         not null,
FK_OPERACOES_SANGRIA VALORS                         not null,
FK_OPERACOES_NUMERARIO VALORS                         not null,
FK_OPERACOES_FECHAMENTO VALORS                         not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PARAMETROS_PDV primary key (FK_EMPRESAS, PK_PARAMETROS_PDV)
);

grant SELECT,UPDATE,INSERT,DELETE on PARAMETROS_PDV to PUBLIC;

/*==============================================================*/
/* Table: TIPO_CONTAS                                           */
/*==============================================================*/
create table TIPO_CONTAS (
PK_TIPO_CONTAS       VALORI                         not null,
DSC_TCTA             DESCRICAO_30RQ                 not null,
FLAG_TCTA            FLAG_TIPO_CONTA                not null,
KC_CONTAS            VALORS                         default 0,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_TIPO_CONTAS primary key (PK_TIPO_CONTAS)
);

grant SELECT,UPDATE,INSERT,DELETE on TIPO_CONTAS to PUBLIC;

/*==============================================================*/
/* Table: VINCULO_DOCUMENTOS                                    */
/*==============================================================*/
create table VINCULO_DOCUMENTOS (
FK_EMPRESAS          VALORI                         not null,
FK_CADASTROS         VALORI                         not null,
FK_TIPO_DOCUMENTOS   VALORS                         not null,
FK_DOCUMENTOS        VALORI                         not null,
FLAG_TDOC            FLAG_TIPO_DOCUMENTO            not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_VINCULO_DOCUMENTOS primary key (FK_EMPRESAS, FK_DOCUMENTOS, FK_TIPO_DOCUMENTOS, FK_CADASTROS)
);

grant SELECT,UPDATE,INSERT,DELETE on VINCULO_DOCUMENTOS to PUBLIC;

alter table BANCOS_AGENCIAS
   add constraint FK_BANCOS_AGENCIAS_BANCOS foreign key (FK_BANCOS)
      references BANCOS (PK_BANCOS);

alter table BANCOS_AGENCIAS
   add constraint FK_BANCOS_AGENCI_CADASTROS foreign key (FK_CADASTROS)
      references CADASTROS (PK_CADASTROS);

alter table BANCOS_CONTAS
   add constraint FK_BANCOS_CONTAS_BANCOS_AGENCIA foreign key (FK_BANCOS, FK_AGENCIAS)
      references BANCOS_AGENCIAS (FK_BANCOS, PK_AGENCIAS);

alter table BANCOS_CONTAS
   add constraint FK_BANCOS_CONTAS_CONTAS foreign key (FK_EMPRESAS, FK_TIPO_CONTAS, FK_CONTAS)
      references CONTAS (FK_EMPRESAS, FK_TIPO_CONTAS, PK_CONTAS);

alter table CLASSIFICACAO_DOCUMENTOS
   add constraint FK_CLASSIFICACAO_CLASSIFICA_DOC foreign key (FK_CLASSIFICACAO)
      references CLASSIFICACAO (PK_CLASSIFICACAO);

alter table CLASSIFICACAO_DOCUMENTOS
   add constraint FK_CLASSIFICACAO_VINCULO_DOCUM foreign key (FK_EMPRESAS, FK_DOCUMENTOS, FK_TIPO_DOCUMENTOS, FK_CADASTROS)
      references VINCULO_DOCUMENTOS (FK_EMPRESAS, FK_DOCUMENTOS, FK_TIPO_DOCUMENTOS, FK_CADASTROS)
      on delete cascade
      on update cascade;

alter table CLASSIFICACAO_SALDOS
   add constraint FK_CLASSIFICACAO_SLD_EMPRESAS foreign key (FK_EMPRESAS)
      references EMPRESAS (PK_EMPRESAS);

alter table CLASSIFICACAO_SALDOS
   add constraint FK_CLASSIFICA_CLASSIFICACAO_SLD foreign key (FK_CLASSIFICACAO)
      references CLASSIFICACAO (PK_CLASSIFICACAO);

alter table CONTAS
   add constraint FK_CONTAS_EMPRESAS foreign key (FK_EMPRESAS)
      references EMPRESAS (PK_EMPRESAS);

alter table CONTAS
   add constraint FK_CONTAS_TIPO_CONTAS foreign key (FK_TIPO_CONTAS)
      references TIPO_CONTAS (PK_TIPO_CONTAS);

alter table CONTAS_DOCUMENTOS
   add constraint FK_CONTAS_DOCUME_VINCULO_DOCUM foreign key (FK_EMPRESAS, FK_DOCUMENTOS, FK_TIPO_DOCUMENTOS, FK_CADASTROS)
      references VINCULO_DOCUMENTOS (FK_EMPRESAS, FK_DOCUMENTOS, FK_TIPO_DOCUMENTOS, FK_CADASTROS)
      on delete cascade
      on update cascade;

alter table CONTAS_DOCUMENTOS
   add constraint FK_CONTAS_DOCUME_CONTAS_LANCAM foreign key (FK_EMPRESAS, FK_CONTAS_LANCAMENTOS)
      references CONTAS_LANCAMENTOS (FK_EMPRESAS, PK_CONTAS_LANCAMENTOS);

alter table CONTAS_LANCAMENTOS
   add constraint FK_CONTAS_LANCAMENTOS_CONTAS foreign key (FK_EMPRESAS__CTA, FK_TIPO_CONTAS, FK_CONTAS)
      references CONTAS (FK_EMPRESAS, FK_TIPO_CONTAS, PK_CONTAS);

alter table CONTAS_LANCAMENTOS
   add constraint FK_CONTAS_LANCAM_CADASTROS foreign key (FK_CADASTROS)
      references CADASTROS (PK_CADASTROS);

alter table CONTAS_LANCAMENTOS
   add constraint FK_CONTAS_LANCAM_FINALIZADORAS foreign key (FK_FINALIZADORAS)
      references FINALIZADORAS (PK_FINALIZADORAS);

alter table CONTAS_LANCAMENTOS
   add constraint FK_CONTAS_LANCAM_HISTORICOS_PA foreign key (FK_HITORICOS_PADRAO)
      references HISTORICOS_PADRAO (PK_HITORICOS_PADRAO);

alter table CONTAS_LANCAMENTOS
   add constraint FK_CONTAS_LANCAM_OPERACOES_FIN foreign key (FK_OPERACOES_FINANCEIRAS)
      references OPERACOES_FINANCEIRAS (PK_OPERACOES_FINANCEIRAS);

alter table CONTAS_LANCAMENTOS_TRF
   add constraint FK_CONTAS_LANCAM_CONTAS foreign key (FK_EMPRESAS__CR, FK_TIPO_CONTAS__CR, FK_CONTAS__CR)
      references CONTAS (FK_EMPRESAS, FK_TIPO_CONTAS, PK_CONTAS);

alter table CONTAS_LANCAMENTOS_TRF
   add constraint FK_CONTAS_LANCAM_CONTAS__CR foreign key (FK_EMPRESAS__DB, FK_TIPO_CONTAS__DB, FK_CONTAS__DB)
      references CONTAS (FK_EMPRESAS, FK_TIPO_CONTAS, PK_CONTAS);

alter table CONTAS_LANCAMENTOS_TRF
   add constraint FK_CONTAS_LANCAM_CTA_LANCAM_CR foreign key (FK_EMPRESAS__CR, FK_CONTAS_LANCAMENTOS__CR)
      references CONTAS_LANCAMENTOS (FK_EMPRESAS, PK_CONTAS_LANCAMENTOS);

alter table CONTAS_LANCAMENTOS_TRF
   add constraint FK_CONTAS_LANCAM_CTA_LANCAM_DB foreign key (FK_EMPRESAS__DB, FK_CONTAS_LANCAMENTOS__DB)
      references CONTAS_LANCAMENTOS (FK_EMPRESAS, PK_CONTAS_LANCAMENTOS);

alter table CONTAS_LANCAMENTOS_TRF
   add constraint FK_CONTAS_LANCAM_TRF_EMPRESAS foreign key (FK_EMPRESAS)
      references EMPRESAS (PK_EMPRESAS);

alter table CONTAS_SALDOS
   add constraint FK_CONTAS_SALDOS_CONTAS foreign key (FK_EMPRESAS__CTA, FK_TIPO_CONTAS, FK_CONTAS)
      references CONTAS (FK_EMPRESAS, FK_TIPO_CONTAS, PK_CONTAS)
      on delete cascade
      on update cascade;

alter table CONTAS_SALDOS
   add constraint FK_CONTAS_SALDOS_CONTAS_LANCAM foreign key (FK_EMPRESAS, FK_CONTAS_LANCAMENTOS)
      references CONTAS_LANCAMENTOS (FK_EMPRESAS, PK_CONTAS_LANCAMENTOS)
      on delete cascade
      on update cascade;

alter table MOD_BCCX_KEYS
   add constraint FK_MOD_BCCX_KEYS_EMPRESAS foreign key (FK_EMPRESAS)
      references EMPRESAS (PK_EMPRESAS);

alter table OPERACOES_FINANCEIRAS
   add constraint FK_OPERACOES_OPERACOES_CR foreign key (FK_OPERACOES_FINANCEIRAS__CR)
      references OPERACOES_FINANCEIRAS (PK_OPERACOES_FINANCEIRAS)
      on delete cascade
      on update cascade;

alter table OPERACOES_FINANCEIRAS
   add constraint FK_OPERACOES_OPERACOES_DB foreign key (FK_OPERACOES_FINANCEIRAS__DB)
      references OPERACOES_FINANCEIRAS (PK_OPERACOES_FINANCEIRAS)
      on delete cascade
      on update cascade;

alter table OPERACOES_FIN_X_TIPO_DOCUMENTOS
   add constraint FK_OPERACOES_FIN_OPERACOES_FIN foreign key (FK_OPERACOES_FINANCEIRAS)
      references OPERACOES_FINANCEIRAS (PK_OPERACOES_FINANCEIRAS)
      on delete cascade
      on update cascade;

alter table OPERACOES_FIN_X_TIPO_DOCUMENTOS
   add constraint FK_OPERACOES_FIN_TIPO_DOCUMENT foreign key (FK_TIPO_DOCUMENTOS)
      references TIPO_DOCUMENTOS (PK_TIPO_DOCUMENTOS);

alter table PARAMETROS_PDV
   add constraint FK_PARAMETROS_PDV_CONTAS foreign key (FK_EMPRESAS_CONTAS, FK_TIPO_CONTAS, FK_CONTAS)
      references CONTAS (FK_EMPRESAS, FK_TIPO_CONTAS, PK_CONTAS);

alter table PARAMETROS_PDV
   add constraint FK_PARAMETROS_PDV_EMPRESAS foreign key (FK_EMPRESAS)
      references EMPRESAS (PK_EMPRESAS);

alter table PARAMETROS_PDV
   add constraint FK_PARAMETROS_PDV_OPERACOES_ABR foreign key (FK_OPERACOES_ABERTURA)
      references OPERACOES_FINANCEIRAS (PK_OPERACOES_FINANCEIRAS);

alter table PARAMETROS_PDV
   add constraint FK_PARAMETROS_PDV_OPERACOES_EST foreign key (FK_OPERACOES_ESTORNO)
      references OPERACOES_FINANCEIRAS (PK_OPERACOES_FINANCEIRAS);

alter table PARAMETROS_PDV
   add constraint FK_PARAMETROS_PDV_OPERACOES_FCH foreign key (FK_OPERACOES_FECHAMENTO)
      references OPERACOES_FINANCEIRAS (PK_OPERACOES_FINANCEIRAS);

alter table PARAMETROS_PDV
   add constraint FK_PARAMETROS_PDV_OPERACOES_NUM foreign key (FK_OPERACOES_NUMERARIO)
      references OPERACOES_FINANCEIRAS (PK_OPERACOES_FINANCEIRAS);

alter table PARAMETROS_PDV
   add constraint FK_PARAMETROS_PDV_OPERACOES_SNG foreign key (FK_OPERACOES_SANGRIA)
      references OPERACOES_FINANCEIRAS (PK_OPERACOES_FINANCEIRAS);

alter table PARAMETROS_PDV
   add constraint FK_PARAMETROS_PDV_OPERACOES_VND foreign key (FK_OPERACOES_VENDA)
      references OPERACOES_FINANCEIRAS (PK_OPERACOES_FINANCEIRAS);

