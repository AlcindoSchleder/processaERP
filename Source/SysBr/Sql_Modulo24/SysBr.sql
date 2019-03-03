/*==============================================================*/
/* Database name:  PROCESSA                                     */
/* DBMS name:      InterBase 6.x                                */
/* Created on:     20/04/2006 11:12:16                          */
/*==============================================================*/


create generator TIPO_OCORRENCIAS;

/*==============================================================*/
/* Table: CATEGORIAS_PRODUTOS                                   */
/*==============================================================*/
create table CATEGORIAS_PRODUTOS (
FK_EMPRESAS          VALORI                         not null,
FK_PRACAS            VALORS                         not null,
PK_CATEGORIAS_PRODUTOS VALORS                         not null,
FK_PRODUTOS          VALORI                         not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_CATEGORIAS_PRODUTOS primary key (FK_EMPRESAS, FK_PRACAS, PK_CATEGORIAS_PRODUTOS)
);

grant SELECT,UPDATE,INSERT,DELETE on CATEGORIAS_PRODUTOS to PUBLIC;

/*==============================================================*/
/* Table: PRACAS_OCORRENCIAS                                    */
/*==============================================================*/
create table PRACAS_OCORRENCIAS (
FK_TIPO_OCORRENCIA   VALORS                         not null,
PK_PRACAS_OCORRENCIAS VALORI                         not null,
FK_EMPRESAS          VALORI                         not null,
FK_PRACAS            VALORS                         not null,
FK_PRACAS_PISTAS     VALORS                         not null,
FK_TIPO_TURNOS       VALORS                         not null,
FK_PRACAS_OPERADORES VALORS                         not null,
FK_CATEGORIAS_PRODUTOS VALORS                         not null,
FK_FINALIZADORAS     VALORS                         not null,
DTHR_OCR             DATA_HORA                      not null,
FLAG_TOCR            FLAG_TIPO_OCORRENCIA           not null,
FLAG_GEN             FLAG_SIM_NAO                   not null,
STT_PAS              VALORS,
VLR_OCC              NUMERO_MEDIO_4CD               not null,
DSCT_PASS            NUMERO_PEQUENO_4CD             not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PRACAS_OCORRENCIAS primary key (FK_TIPO_OCORRENCIA, PK_PRACAS_OCORRENCIAS)
);

grant all on PRACAS_OCORRENCIAS to public;
/*==============================================================*/
/* Table: PRACAS_OPERADORES                                     */
/*==============================================================*/
create table PRACAS_OPERADORES (
FK_EMPRESAS          VALORI                         not null,
FK_PRACAS            VALORS                         not null,
PK_PRACAS_OPERADORES VALORS                         not null,
FK_CADASTROS         VALORI                         not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PRACAS_OPERADORES primary key (FK_EMPRESAS, FK_PRACAS, PK_PRACAS_OPERADORES)
);

grant all on PRACAS_OPERADORES to public;
/*==============================================================*/
/* Table: PRACAS_PISTAS                                         */
/*==============================================================*/
create table PRACAS_PISTAS (
FK_EMPRESAS          VALORI                         not null,
FK_PRACAS            VALORS                         not null,
PK_PRACAS_PISTAS     VALORS                         not null,
DSC_PISTA            DESCRICAO_30RQ                 not null,
FLAG_DRT             FLAG_DIRECTION                 not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PRACAS_PISTAS primary key (FK_EMPRESAS, FK_PRACAS, PK_PRACAS_PISTAS)
);

grant all on PRACAS_PISTAS to public;
/*==============================================================*/
/* Table: TIPO_OCORRENCIAS                                      */
/*==============================================================*/
create table TIPO_OCORRENCIAS (
PK_TIPO_OCORRENCIAS  VALORS                         not null,
DSC_TOCR             DESCRICAO_50RQ                 not null,
FLAG_GFIN            FLAG_SIM_NAO                   not null,
PREFIX_FILE          DESCRICAO_10                   not null,
DTA_LREAD            DATA,
FLAG_TOCR            FLAG_TIPO_ARQUIVO_OCORR        not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_TIPO_OCORRENCIAS primary key (PK_TIPO_OCORRENCIAS)
);

grant all on TIPO_OCORRENCIAS to public;
/*==============================================================*/
/* Table: VINCULO_TOCORR_PRACAS                                 */
/*==============================================================*/
create table VINCULO_TOCORR_PRACAS (
FK_EMPRESAS          VALORI                         not null,
FK_PRACAS            VALORS                         not null,
FK_TIPO_OCORRENCIA   VALORS                         not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_VINCULO_TOCORR_PRACAS primary key (FK_EMPRESAS, FK_PRACAS, FK_TIPO_OCORRENCIA)
);

grant all on VINCULO_TOCORR_PRACAS to public;
alter table CATEGORIAS_PRODUTOS
   add constraint FK_CATEGORIAS_PRODUTOS_PRACAS foreign key (FK_EMPRESAS, FK_PRACAS)
      references PRACAS (FK_EMPRESAS, PK_PRACAS);

alter table CATEGORIAS_PRODUTOS
   add constraint FK_CATEGORIAS_PRODUTOS_PRODUTOS foreign key (FK_PRODUTOS)
      references PRODUTOS (PK_PRODUTOS);

alter table PRACAS_OCORRENCIAS
   add constraint FK_PRACAS_OCORRENCIAS_PR_PISTAS foreign key (FK_EMPRESAS, FK_PRACAS, FK_PRACAS_PISTAS)
      references PRACAS_PISTAS (FK_EMPRESAS, FK_PRACAS, PK_PRACAS_PISTAS);

alter table PRACAS_OCORRENCIAS
   add constraint FK_PRACAS_OCORRENCIAS_TIPO_TURN foreign key (FK_TIPO_TURNOS)
      references TIPO_TURNOS (PK_TIPO_TURNOS);

alter table PRACAS_OCORRENCIAS
   add constraint FK_PRACAS_OCORRE_CATEGORIAS_PR foreign key (FK_EMPRESAS, FK_PRACAS, FK_CATEGORIAS_PRODUTOS)
      references CATEGORIAS_PRODUTOS (FK_EMPRESAS, FK_PRACAS, PK_CATEGORIAS_PRODUTOS);

alter table PRACAS_OCORRENCIAS
   add constraint FK_PRACAS_OCORRE_FINALIZADORAS foreign key (FK_FINALIZADORAS)
      references FINALIZADORAS (PK_FINALIZADORAS);

alter table PRACAS_OCORRENCIAS
   add constraint FK_PRACAS_OCORRE_PRACAS_OPERAD foreign key (FK_EMPRESAS, FK_PRACAS, FK_PRACAS_OPERADORES)
      references PRACAS_OPERADORES (FK_EMPRESAS, FK_PRACAS, PK_PRACAS_OPERADORES);

alter table PRACAS_OCORRENCIAS
   add constraint FK_PRACAS_OCORRE_TIPO_OCORRENC foreign key (FK_TIPO_OCORRENCIA)
      references TIPO_OCORRENCIAS (PK_TIPO_OCORRENCIAS);

alter table PRACAS_OPERADORES
   add constraint FK_PRACAS_OPERADERES_PRACAS foreign key (FK_EMPRESAS, FK_PRACAS)
      references PRACAS (FK_EMPRESAS, PK_PRACAS);

alter table PRACAS_OPERADORES
   add constraint FK_PRACAS_OPERADORES_CADASTROS foreign key (FK_CADASTROS)
      references CADASTROS (PK_CADASTROS);

alter table PRACAS_PISTAS
   add constraint FK_PRACAS_PISTAS_PRACAS foreign key (FK_EMPRESAS, FK_PRACAS)
      references PRACAS (FK_EMPRESAS, PK_PRACAS);

alter table VINCULO_TOCORR_PRACAS
   add constraint FK_VINCULO_TOCOR_PRACAS_PRACAS foreign key (FK_EMPRESAS, FK_PRACAS)
      references PRACAS (FK_EMPRESAS, PK_PRACAS);

alter table VINCULO_TOCORR_PRACAS
   add constraint FK_VINCULO_TOCOR_TIPO_OCORRENC foreign key (FK_TIPO_OCORRENCIA)
      references TIPO_OCORRENCIAS (PK_TIPO_OCORRENCIAS);

