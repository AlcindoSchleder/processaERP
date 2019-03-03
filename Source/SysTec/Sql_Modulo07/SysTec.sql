/*==============================================================*/
/* Database name:  PROCESSA                                     */
/* DBMS name:      Friebird15x                                  */
/* Created on:     8/9/2006 08:11:45                            */
/*==============================================================*/


create generator TIPO_FASES_PRODUCAO;

create generator TIPO_OPERACOES;

/*==============================================================*/
/* Table: FASES_PRODUCAO                                        */
/*==============================================================*/
create table FASES_PRODUCAO (
FK_PRODUTOS_PECAS    VALORI                         not null,
PK_FASES_PRODUCAO    VALORS                         not null,
FK_TIPO_FASES_PRODUCAO VALORS                         not null,
SEQ_FASE             VALORS,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_FASES_PRODUCAO primary key (PK_FASES_PRODUCAO, FK_PRODUTOS_PECAS)
);

grant SELECT,UPDATE,INSERT,DELETE on FASES_PRODUCAO to PUBLIC;

/*==============================================================*/
/* Table: OPERACOES                                             */
/*==============================================================*/
create table OPERACOES (
FK_PRODUTOS_PECAS    VALORI                         not null,
FK_FASES_PRODUCAO    VALORS                         not null,
PK_OPERACOES         VALORS                         not null,
FK_TIPO_OPERACOES    VALORI                         not null,
FK_TIPO_DOCUMENTOS   VALORS                         not null,
SEQ_OPE              VALORS,
COD_REF              REFERENCIA_PRODUTOS,
ALT_MAX              NUMERO_PEQUENO_4CD,
LARG_MAX             NUMERO_PEQUENO_4CD,
PROF_MAX             NUMERO_PEQUENO_4CD,
ALT_MIN              NUMERO_PEQUENO_4CD,
LARG_MIN             NUMERO_PEQUENO_4CD,
PROF_MIN             NUMERO_PEQUENO_4CD,
TEMPO_MEDIO          NUMERO_PEQUENO_4CD,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_OPERACOES primary key (FK_FASES_PRODUCAO, FK_PRODUTOS_PECAS, PK_OPERACOES)
);

grant DELETE,INSERT,UPDATE,SELECT on OPERACOES to PUBLIC;

/*==============================================================*/
/* Table: OPERACOES_DETALHES                                    */
/*==============================================================*/
create table OPERACOES_DETALHES (
FK_PRODUTOS_PECAS    VALORI                         not null,
FK_FASES_PRODUCAO    VALORS                         not null,
FK_OPERACOES         VALORS                         not null,
PK_OPERACOES_DETALHES VALORS                         not null,
FK_TIPO_DETALHE      VALORS,
FLAG_TDET            FLAG_TIPO_DETALHE              not null,
QTD_DET              NUMERO_PEQUENO_4CD,
PERC_PERDA           NUMERO_PEQUENO,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_OPERACOES_DETALHES primary key (FK_FASES_PRODUCAO, FK_PRODUTOS_PECAS, FK_OPERACOES, PK_OPERACOES_DETALHES)
);

create exception EX_PREVENT_INTEGRITY 'Erro: Operação cancelada para previnir a integridade dos dados';

/*  Update trigger "TBU0_TIPO_ACABAMENTOS" for table "TIPO_ACABAMENTOS"  */
set term ^;

alter trigger TBU0_TIPO_ACABAMENTOS
before update as
  declare variable NumRows integer;
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  if (New.PK_TIPO_ACABAMENTOS <> Old.PK_TIPO_ACABAMENTOS) then
  begin
    select Count(*)
      from OPERACOES_DETALHES
     where FLAG_TDET = 1
       and FK_TIPO_DETALHE = Old.PK_TIPO_ACABAMENTOS
      into :NumRows;
    if (NumRows is null) then
      NumRows = 0;
    if (NumRows > 0) then
      exception EX_PREVENT_INTEGRITY;
  end
end ^

set term ;^


grant SELECT,UPDATE,INSERT,DELETE on OPERACOES_DETALHES to PUBLIC;

/*==============================================================*/
/* Table: PECAS_COMPONENTES                                     */
/*==============================================================*/
create table PECAS_COMPONENTES (
FK_PRODUTOS_PECAS    VALORI                         not null,
FK_PRODUTOS_PECAS_MNT VALORI                         not null,
QTD_PEC              VALORS,
QTD_GER              VALORS,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PECAS_COMPONENTES primary key (FK_PRODUTOS_PECAS, FK_PRODUTOS_PECAS_MNT)
);

grant DELETE,INSERT,UPDATE,SELECT on PECAS_COMPONENTES to PUBLIC;

/*==============================================================*/
/* Table: PECAS_COMPO_OPER                                      */
/*==============================================================*/
create table PECAS_COMPO_OPER (
FK_PRODUTOS_PECAS    VALORI                         not null,
FK_PRODUTOS_PECAS_MNT VALORI                         not null,
FK_FASES_PRODUCAO    VALORS                         not null,
FK_OPERACOES         VALORS                         not null,
SEQ_MONT             VALORS,
PERC_PERDA           NUMERO_PEQUENO,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PECAS_COMPO_OPER primary key (FK_PRODUTOS_PECAS, FK_PRODUTOS_PECAS_MNT, FK_FASES_PRODUCAO, FK_OPERACOES)
);

grant SELECT,UPDATE,INSERT,DELETE on PECAS_COMPO_OPER to PUBLIC;

/*==============================================================*/
/* Table: PECAS_FERRAMENTAS                                     */
/*==============================================================*/
create table PECAS_FERRAMENTAS (
FK_PRODUTOS_PECAS    VALORI                         not null,
FK_FASES_PRODUCAO    VALORS                         not null,
FK_OPERACOES         VALORS                         not null,
FK_PRODUTOS_MAQUINAS VALORS                         not null,
FK_PRODUTOS_COMPRAS  VALORI                         not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PECAS_FERRAMENTAS primary key (FK_FASES_PRODUCAO, FK_PRODUTOS_PECAS, FK_OPERACOES, FK_PRODUTOS_MAQUINAS, FK_PRODUTOS_COMPRAS)
);

grant DELETE,INSERT,SELECT,UPDATE on PECAS_FERRAMENTAS to PUBLIC;

/*==============================================================*/
/* Table: PECAS_MAQUINAS                                        */
/*==============================================================*/
create table PECAS_MAQUINAS (
FK_PRODUTOS_PECAS    VALORI                         not null,
FK_FASES_PRODUCAO    VALORS                         not null,
FK_OPERACOES         VALORS                         not null,
FK_PRODUTOS_MAQUINAS VALORS                         not null,
TMP_STP              NUMERO_PEQUENO_4CD,
TMP_OPER             NUMERO_PEQUENO_4CD,
FLAG_DEF             FLAG_SIM_NAO                   not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PECAS_MAQUINAS primary key (FK_FASES_PRODUCAO, FK_PRODUTOS_PECAS, FK_OPERACOES, FK_PRODUTOS_MAQUINAS)
);

grant SELECT,UPDATE,INSERT,DELETE on PECAS_MAQUINAS to PUBLIC;

/*==============================================================*/
/* Table: PRODUTOS_MAQUINAS                                     */
/*==============================================================*/
create table PRODUTOS_MAQUINAS (
FK_PRODUTOS          VALORS                         not null,
FK_VW_FORNECEDORES   VALORI,
DTA_AQU              DATA,
POT_MAQ              NUMERO_PEQUENO_4CD,
NUM_OPE              VALORS,
DTA_URVS             DATA_HORA,
TMMP_MAQ             VALORS,
MTBF_MAQ             VALORS,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PRODUTOS_MAQUINAS primary key (FK_PRODUTOS)
);

grant DELETE,INSERT,UPDATE,SELECT on PRODUTOS_MAQUINAS to PUBLIC;

/*==============================================================*/
/* Table: PRODUTOS_PECAS                                        */
/*==============================================================*/
create table PRODUTOS_PECAS (
FK_PRODUTOS          VALORI                         not null,
MAJ_VER              VALORS                         default 1 not null,
MIN_VER              VALORS                         default 0 not null,
VERSION              DESCRICAO_10                   default '1.0' not null,
ALT_PEC              NUMERO_MEDIO,
PROF_PEC             NUMERO_MEDIO,
LARG_PEC             NUMERO_MEDIO,
FLAG_TCOMP           FLAG_TIPO_PECA,
MOT_NVER             DESCRICAO_50RQ                 not null,
FLAG_OP              FLAG_SIM_NAO                   not null,
DTA_LAST_PRD         DATA,
DTA_FIRST_LIB        DATA,
DTA_LAST_LIB         DATA,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PRODUTOS_PECAS primary key (FK_PRODUTOS)
);

grant SELECT,UPDATE,INSERT,DELETE on PRODUTOS_PECAS to PUBLIC;

/*==============================================================*/
/* Table: PRODUTOS_PECAS_HISTORICOS                             */
/*==============================================================*/
create table PRODUTOS_PECAS_HISTORICOS (
FK_PRODUTOS_PECAS    VALORI                         not null,
MAJ_VER              VALORS                         not null,
MIN_VER              VALORS                         not null,
COD_REF              REFERENCIA_PRODUTOS            not null,
DSC_PEC              DESCRICAO_50RQ                 not null,
ALT_PEC              NUMERO_MEDIO,
PROF_PEC             NUMERO_MEDIO,
LARG_PEC             NUMERO_MEDIO,
IMG_PEC              DESCRICAO_100RQ                not null,
FLAG_TIMG            FLAG_TIPO_IMAGEM               not null,
FLAG_TCOMP           FLAG_TIPO_PECA,
FLAG_ATV             FLAG_SIM_NAO                   not null,
FLAG_OP              FLAG_SIM_NAO                   not null,
OBS_PEC              BLOB_TEXTO,
MOT_NVER             DESCRICAO_50RQ                 not null,
DTA_LAST_PRD         DATA,
DTA_FIRST_LIB        DATA,
DTA_LAST_LIB         DATA,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PRODUTOS_PECAS_HISTORICOS primary key (FK_PRODUTOS_PECAS, MAJ_VER, MIN_VER)
);

/*==============================================================*/
/* Index: IDX_FICHA_TECNICA_01                                  */
/*==============================================================*/
create asc index IDX_FICHA_TECNICA_01 on PRODUTOS_PECAS_HISTORICOS (
COD_REF,
MAJ_VER,
MIN_VER
);

grant DELETE,INSERT,UPDATE,SELECT on PRODUTOS_PECAS_HISTORICOS to PUBLIC;

/*==============================================================*/
/* Table: TIPO_FASES_PRODUCAO                                   */
/*==============================================================*/
create table TIPO_FASES_PRODUCAO (
PK_TIPO_FASES_PRODUCAO VALORS                         not null,
DSC_FASE             DESCRICAO_30RQ                 not null,
NIV_FASE             VALORS                         default 10 not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_TIPO_FASE_PRODUCAO primary key (PK_TIPO_FASES_PRODUCAO)
);

grant SELECT,UPDATE,INSERT,DELETE on TIPO_FASES_PRODUCAO to PUBLIC;

/*==============================================================*/
/* Table: TIPO_OPERACOES                                        */
/*==============================================================*/
create table TIPO_OPERACOES (
PK_TIPO_OPERACOES    VALORS                         not null,
DSC_OPE              DESCRICAO_30RQ                 not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_TIPO_OPERACOES primary key (PK_TIPO_OPERACOES)
);

grant SELECT,UPDATE,INSERT,DELETE on TIPO_OPERACOES to PUBLIC;

alter table FASES_PRODUCAO
   add constraint FK_FASES_PRODUCA_PRODUTOS_PECA foreign key (FK_PRODUTOS_PECAS)
      references PRODUTOS_PECAS (FK_PRODUTOS);

alter table FASES_PRODUCAO
   add constraint FK_FASES_PRODUCA_TIPO_FASES_PR foreign key (FK_TIPO_FASES_PRODUCAO)
      references TIPO_FASES_PRODUCAO (PK_TIPO_FASES_PRODUCAO);

alter table OPERACOES
   add constraint FK_OPERACOES_FASES_PRODUCA foreign key (FK_FASES_PRODUCAO, FK_PRODUTOS_PECAS)
      references FASES_PRODUCAO (PK_FASES_PRODUCAO, FK_PRODUTOS_PECAS);

alter table OPERACOES
   add constraint FK_OPERACOES_TIPO_OPERACOE foreign key (FK_TIPO_OPERACOES)
      references TIPO_OPERACOES (PK_TIPO_OPERACOES);

alter table OPERACOES_DETALHES
   add constraint FK_OPERACOES_DET_OPERACOES foreign key (FK_FASES_PRODUCAO, FK_PRODUTOS_PECAS, FK_OPERACOES)
      references OPERACOES (FK_FASES_PRODUCAO, FK_PRODUTOS_PECAS, PK_OPERACOES);

alter table PECAS_COMPONENTES
   add constraint FK_PECAS_COMPONENT_PRODUTOS_PEC foreign key (FK_PRODUTOS_PECAS_MNT)
      references PRODUTOS_PECAS (FK_PRODUTOS);

alter table PECAS_COMPONENTES
   add constraint FK_PECAS_COMPONE_PRODUTOS_PECA foreign key (FK_PRODUTOS_PECAS)
      references PRODUTOS_PECAS (FK_PRODUTOS);

alter table PECAS_COMPO_OPER
   add constraint FK_PECAS_COMPO_O_OPERACOES foreign key (FK_FASES_PRODUCAO, FK_PRODUTOS_PECAS, FK_OPERACOES)
      references OPERACOES (FK_FASES_PRODUCAO, FK_PRODUTOS_PECAS, PK_OPERACOES);

alter table PECAS_COMPO_OPER
   add constraint FK_PECAS_COMPO_O_PECAS_COMPONE foreign key (FK_PRODUTOS_PECAS, FK_PRODUTOS_PECAS_MNT)
      references PECAS_COMPONENTES (FK_PRODUTOS_PECAS, FK_PRODUTOS_PECAS_MNT);

alter table PECAS_FERRAMENTAS
   add constraint FK_PECAS_FERRAME_PECAS_MAQUINA foreign key (FK_FASES_PRODUCAO, FK_PRODUTOS_PECAS, FK_OPERACOES, FK_PRODUTOS_MAQUINAS)
      references PECAS_MAQUINAS (FK_FASES_PRODUCAO, FK_PRODUTOS_PECAS, FK_OPERACOES, FK_PRODUTOS_MAQUINAS);

alter table PECAS_MAQUINAS
   add constraint FK_PECAS_MAQUINA_PRODUTOS_MAQU foreign key (FK_PRODUTOS_MAQUINAS)
      references PRODUTOS_MAQUINAS (FK_PRODUTOS);

alter table PECAS_MAQUINAS
   add constraint FK_PECAS_MAQUINA_OPERACOES foreign key (FK_FASES_PRODUCAO, FK_PRODUTOS_PECAS, FK_OPERACOES)
      references OPERACOES (FK_FASES_PRODUCAO, FK_PRODUTOS_PECAS, PK_OPERACOES);

alter table PRODUTOS_MAQUINAS
   add constraint FK_PRODUTOS_MAQU_CADASTROS foreign key (FK_VW_FORNECEDORES)
      references CADASTROS (PK_CADASTROS);

alter table PRODUTOS_MAQUINAS
   add constraint FK_PRODUTOS_MAQUINAS_PRODUTOS foreign key (FK_PRODUTOS)
      references PRODUTOS (PK_PRODUTOS)
      on delete cascade
      on update cascade;

alter table PRODUTOS_PECAS
   add constraint FK_PRODUTOS_PECAS_PRODUTOS foreign key (FK_PRODUTOS)
      references PRODUTOS (PK_PRODUTOS);

alter table PRODUTOS_PECAS_HISTORICOS
   add constraint FK_PRODUTOS_PECAS_PRODUTOS_PHST foreign key (FK_PRODUTOS_PECAS)
      references PRODUTOS_PECAS (FK_PRODUTOS);

