/*==============================================================*/
/* Database name:  PROCESSA                                     */
/* DBMS name:      Friebird15x                                  */
/* Created on:     31/10/2006 21:00:10                          */
/*==============================================================*/


create generator MANIFESTOS_STATUS;

create generator TIPO_MANIFESTOS;

create generator VEICULOS_MARCAS;

/*==============================================================*/
/* Table: FORNECEDORES_MARCAS                                   */
/*==============================================================*/
create table FORNECEDORES_MARCAS (
FK_CADASTROS         VALORI                         not null,
FK_VEICULOS_MARCAS   VALORS                         not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA,
constraint PK_FORNECEDORES_MARCAS primary key (FK_CADASTROS, FK_VEICULOS_MARCAS)
);

grant SELECT,UPDATE,INSERT,DELETE on FORNECEDORES_MARCAS to PUBLIC;

/*==============================================================*/
/* Table: FORNECEDORES_REGIOES                                  */
/*==============================================================*/
create table FORNECEDORES_REGIOES (
FK_CADASTROS         VALORI                         not null,
FK_CARGAS_REGIOES    VALORS                         not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA,
constraint PK_FORNECEDORES_REGIOES primary key (FK_CADASTROS, FK_CARGAS_REGIOES)
);

grant SELECT,UPDATE,INSERT,DELETE on FORNECEDORES_REGIOES to PUBLIC;

/*==============================================================*/
/* Table: MANIFESTOS                                            */
/*==============================================================*/
create table MANIFESTOS (
FK_EMPRESAS          VALORI                         not null,
PK_MANIFESTOS        VALORS                         not null,
FK_TIPO_MANIFESTOS   VALORS,
FK_VEICULOS_MARCAS   VALORS,
FK_VEICULOS_MODELOS  VALORS,
FK_VEICULOS          VALORS,
FK_FUNCIONARIOS__MOTORISTA VALORI,
FK_AGREGADO          VALORI,
FK_FUNCIONARIOS__CARGA VALORI                         not null,
FK_FUNCIONARIOS__CONFERENCIA VALORI                         not null,
DTA_EMI              DATA_DEF                       not null,
DTA_SAI              DATA_DEF                       not null,
FLAG_TOT             FLAG_SIM_NAO                   not null,
TOT_CNH              NUMERO_MEDIO_4CD,
VLR_PDG              NUMERO_PEQUENO_4CD,
VLR_MRC              NUMERO_GRANDE_4CD,
VLR_FRT_VST          NUMERO_PEQUENO_4CD,
VLR_REMB             NUMERO_MEDIO_4CD,
KC_MANIFESTOS_CONHECIMENTOS VALORS                         default 0 not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_MANIFESTOS primary key (FK_EMPRESAS, PK_MANIFESTOS)
);

grant SELECT,UPDATE,INSERT,DELETE on MANIFESTOS to PUBLIC;

/*==============================================================*/
/* Table: MANIFESTOS_CONHECIMENTOS                              */
/*==============================================================*/
create table MANIFESTOS_CONHECIMENTOS (
FK_EMPRESAS          VALORI                         not null,
FK_MANIFESTOS        VALORS                         not null,
PK_MANIFESTOS_CONHECIMENTOS VALORS                         not null,
FLAG_IMP_REC         FLAG_SIM_NAO                   not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_MANIFESTOS_CONHECIMENTOS primary key (FK_EMPRESAS, FK_MANIFESTOS, PK_MANIFESTOS_CONHECIMENTOS)
);

grant SELECT,UPDATE,INSERT,DELETE on MANIFESTOS_CONHECIMENTOS to PUBLIC;

/*==============================================================*/
/* Table: MANIFESTOS_OCORRENCIAS                                */
/*==============================================================*/
create table MANIFESTOS_OCORRENCIAS (
FK_EMPRESAS          VALORI                         not null,
FK_MANIFESTOS        VALORS                         not null,
FK_MANIFESTOS_CONHECIMENTOS VALORS                         not null,
PK_MANIFESTOS_OCORRENCIAS VALORI                         not null,
FK_MANIFESTOS_STATUS VALORS                         not null,
CMPL_OCC             BLOB_TEXTO,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_MANIFESTOS_OCORRENCIAS primary key (FK_EMPRESAS, FK_MANIFESTOS, FK_MANIFESTOS_CONHECIMENTOS, PK_MANIFESTOS_OCORRENCIAS)
);

grant SELECT,UPDATE,INSERT,DELETE on MANIFESTOS_OCORRENCIAS to PUBLIC;

/*==============================================================*/
/* Table: MANIFESTOS_STATUS                                     */
/*==============================================================*/
create table MANIFESTOS_STATUS (
PK_MANIFESTOS_STATUS VALORS                         not null,
DSC_MSTT             DESCRICAO_30RQ                 not null,
FLAG_NIV_OCC         FLAG_OCORRENCIA_FRETES         not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_MANIFESTOS_STATUS primary key (PK_MANIFESTOS_STATUS)
);

grant SELECT,UPDATE,INSERT,DELETE on MANIFESTOS_STATUS to PUBLIC;

/*==============================================================*/
/* Table: MANIFESTOS_TOTAIS                                     */
/*==============================================================*/
create table MANIFESTOS_TOTAIS (
FK_EMPRESAS          VALORI                         not null,
FK_MANIFESTOS        VALORS                         not null,
FLAG_TMNFST          FLAG                           not null
      constraint CKC_FLAG_TMNFST_MANIFEST check (FLAG_TMNFST in (0,1)),
TOT_TMNFST           VALORS                         not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_MANIFESTOS_TOTAIS primary key (FK_EMPRESAS, FK_MANIFESTOS, FLAG_TMNFST)
);

grant SELECT,UPDATE,INSERT,DELETE on MANIFESTOS_TOTAIS to PUBLIC;

/*==============================================================*/
/* Table: PATRIMONIO_VEICULOS                                   */
/*==============================================================*/
create table PATRIMONIO_VEICULOS (
FK_PRODUTOS          VALORI                         not null,
FK_VEICULOS_MARCAS   VALORS                         not null,
FK_VEICULOS_MODELOS  VALORS                         not null,
FK_VEICULOS          VALORS                         not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA,
constraint PK_PATRIMONIO_VEICULOS primary key (FK_PRODUTOS, FK_VEICULOS_MARCAS, FK_VEICULOS_MODELOS, FK_VEICULOS)
);

grant SELECT,UPDATE,INSERT,DELETE on PATRIMONIO_VEICULOS to PUBLIC;

/*==============================================================*/
/* Table: PEDIDOS_FRETES                                        */
/*==============================================================*/
create table PEDIDOS_FRETES (
FK_EMPRESAS          VALORI                         not null,
FK_PEDIDOS           VALORI                         not null,
FK_REMETENTE         VALORI                         not null,
FK_DESTINATARIO      VALORI                         not null,
FK_CONSIGNATARIO     VALORI,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA,
constraint PK_PEDIDOS_FRETES primary key (FK_EMPRESAS, FK_PEDIDOS)
);

grant SELECT,UPDATE,INSERT,DELETE on PEDIDOS_FRETES to PUBLIC;

/*==============================================================*/
/* Table: PRODUTOS_FRETES                                       */
/*==============================================================*/
create table PRODUTOS_FRETES (
FK_PRODUTOS          VALORI                         not null,
FLAG_TP_FRE          FLAG_TIPO_FRETE                not null,
FLAG_RDSP            FLAG_SIM_NAO                   not null,
FLAG_REMB            FLAG_SIM_NAO                   not null,
FLAG_ES              FLAG_ENTRADA_SAIDA             not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PRODUTOS_FRETES primary key (FK_PRODUTOS)
);

grant DELETE,INSERT,UPDATE,SELECT on PRODUTOS_FRETES to PUBLIC;

/*==============================================================*/
/* Table: TIPO_MANIFESTOS                                       */
/*==============================================================*/
create table TIPO_MANIFESTOS (
PK_TIPO_MANIFESTOS   VALORS                         not null,
FK_TIPO_DOCUMENTOS   VALORS,
DSC_TMNF             DESCRICAO_30RQ                 not null,
FLAG_TCNH            FLAG_TIPO_CONHECIMENTO         not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_TIPO_MANIFESTOS primary key (PK_TIPO_MANIFESTOS)
);

grant SELECT,UPDATE,INSERT,DELETE on TIPO_MANIFESTOS to PUBLIC;

/*==============================================================*/
/* Table: TRANSPORTADORAS_VEICULOS                              */
/*==============================================================*/
create table TRANSPORTADORAS_VEICULOS (
FK_CADASTROS         VALORI                         not null,
FK_VEICULOS_MARCAS   VALORS                         not null,
FK_VEICULOS_MODELOS  VALORS                         not null,
FK_VEICULOS          VALORS                         not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA,
constraint PK_TRANSPORTADORAS_VEICULOS primary key (FK_CADASTROS, FK_VEICULOS_MARCAS, FK_VEICULOS_MODELOS, FK_VEICULOS)
);

grant SELECT,UPDATE,INSERT,DELETE on TRANSPORTADORAS_VEICULOS to PUBLIC;

/*==============================================================*/
/* Table: VEICULOS                                              */
/*==============================================================*/
create table VEICULOS (
FK_VEICULOS_MARCAS   VALORS                         not null,
FK_VEICULOS_MODELOS  VALORS                         not null,
PK_VEICULOS          VALORS                         not null,
FK_CENTRO_CUSTOS     VALORS,
ANO_VCL              VALORS                         not null
      constraint CKC_ANO_VCL_VEICULOS check (ANO_VCL >= 1960),
PLACA_VCL            DESCRICAO_20RQ                 not null,
CPCD_VCL             NUMERO_PEQUENO_4CD             not null,
KC_VEICULOS_IMAGENS  VALORS,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA,
constraint PK_VEICULOS primary key (FK_VEICULOS_MARCAS, FK_VEICULOS_MODELOS, PK_VEICULOS)
);

grant SELECT,UPDATE,INSERT,DELETE on VEICULOS to PUBLIC;

/*==============================================================*/
/* Table: VEICULOS_IMAGENS                                      */
/*==============================================================*/
create table VEICULOS_IMAGENS (
FK_VEICULOS_MARCAS   VALORS                         not null,
FK_VEICULOS_MODELOS  VALORS                         not null,
FK_VEICULOS          VALORS                         not null,
PK_VEICULOS_IMAGENS  VALORS                         not null,
IMG_VCL              BLOB_BINARIO                   not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA,
constraint PK_VEICULOS_IMAGENS primary key (FK_VEICULOS_MARCAS, FK_VEICULOS_MODELOS, FK_VEICULOS, PK_VEICULOS_IMAGENS)
);

grant SELECT,UPDATE,INSERT,DELETE on VEICULOS_IMAGENS to PUBLIC;

/*==============================================================*/
/* Table: VEICULOS_MARCAS                                       */
/*==============================================================*/
create table VEICULOS_MARCAS (
PK_VEICULOS_MARCAS   VALORS                         not null,
DSC_MRC              DESCRICAO_30RQ                 not null,
KC_VEICULOS_MODELOS  VALORS                         default 0 not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA,
constraint PK_VEICULOS_MARCAS primary key (PK_VEICULOS_MARCAS)
);

grant SELECT,UPDATE,INSERT,DELETE on VEICULOS_MARCAS to PUBLIC;

/*==============================================================*/
/* Table: VEICULOS_MODELOS                                      */
/*==============================================================*/
create table VEICULOS_MODELOS (
FK_VEICULOS_MARCAS   VALORS                         not null,
PK_VEICULOS_MODELOS  VALORS                         not null,
DSC_MOD              DESCRICAO_50RQ                 not null,
ANO_FINI             VALORS,
ANO_FFIN             VALORS,
KC_VEICULOS          VALORS                         default 0 not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA,
constraint PK_VEICULOS_MODELOS primary key (FK_VEICULOS_MARCAS, PK_VEICULOS_MODELOS)
);

grant SELECT,UPDATE,INSERT,DELETE on VEICULOS_MODELOS to PUBLIC;

/*==============================================================*/
/* Table: VEICULOS_OBSERVACOES                                  */
/*==============================================================*/
create table VEICULOS_OBSERVACOES (
FK_VEICULOS_MARCAS   VALORS                         not null,
FK_VEICULOS_MODELOS  VALORS                         not null,
FK_VEICULOS          VALORS                         not null,
OBS_VCL              BLOB_TEXTO,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA,
constraint PK_VEICULOS_OBSERVACOES primary key (FK_VEICULOS_MARCAS, FK_VEICULOS_MODELOS, FK_VEICULOS)
);

grant SELECT,UPDATE,INSERT,DELETE on VEICULOS_OBSERVACOES to PUBLIC;

alter table FORNECEDORES_MARCAS
   add constraint FK_FORNECEDORES_FORN_MARCAS foreign key (FK_CADASTROS)
      references FORNECEDORES (FK_CADASTROS);

alter table FORNECEDORES_MARCAS
   add constraint FK_FORNECEDORES__VEICULOS_MARC foreign key (FK_VEICULOS_MARCAS)
      references VEICULOS_MARCAS (PK_VEICULOS_MARCAS);

alter table FORNECEDORES_REGIOES
   add constraint FK_FORNECEDORES__FORNECEDORES foreign key (FK_CADASTROS)
      references FORNECEDORES (FK_CADASTROS)
      on delete cascade
      on update cascade;

alter table FORNECEDORES_REGIOES
   add constraint FK_FORNECEDORES__CARGAS_REGIOE foreign key (FK_CARGAS_REGIOES)
      references CARGAS_REGIOES (PK_CARGAS_REGIOES)
      on delete cascade
      on update cascade;

alter table MANIFESTOS
   add constraint FK_MANIFESTOS_EMPRESAS foreign key (FK_EMPRESAS)
      references EMPRESAS (PK_EMPRESAS);

alter table MANIFESTOS
   add constraint FK_MANIFESTOS_TIPO_MANIFEST foreign key (FK_TIPO_MANIFESTOS)
      references TIPO_MANIFESTOS (PK_TIPO_MANIFESTOS);

alter table MANIFESTOS
   add constraint FK_MANIFESTOS_VEICULOS foreign key (FK_VEICULOS_MARCAS, FK_VEICULOS_MODELOS, FK_VEICULOS)
      references VEICULOS (FK_VEICULOS_MARCAS, FK_VEICULOS_MODELOS, PK_VEICULOS);

alter table MANIFESTOS_CONHECIMENTOS
   add constraint FK_MANIFESTOS_CONHEC_MANIFESTOS foreign key (FK_EMPRESAS, FK_MANIFESTOS)
      references MANIFESTOS (FK_EMPRESAS, PK_MANIFESTOS);

alter table MANIFESTOS_OCORRENCIAS
   add constraint FK_MANIFESTOS_OC_MANIFESTOS_CO foreign key (FK_EMPRESAS, FK_MANIFESTOS, FK_MANIFESTOS_CONHECIMENTOS)
      references MANIFESTOS_CONHECIMENTOS (FK_EMPRESAS, FK_MANIFESTOS, PK_MANIFESTOS_CONHECIMENTOS);

alter table MANIFESTOS_OCORRENCIAS
   add constraint FK_MANIFESTOS_OC_MANIFESTOS_ST foreign key (FK_MANIFESTOS_STATUS)
      references MANIFESTOS_STATUS (PK_MANIFESTOS_STATUS);

alter table MANIFESTOS_TOTAIS
   add constraint FK_MANIFESTOS_TO_MANIFESTOS foreign key (FK_EMPRESAS, FK_MANIFESTOS)
      references MANIFESTOS (FK_EMPRESAS, PK_MANIFESTOS)
      on delete cascade
      on update cascade;

alter table PATRIMONIO_VEICULOS
   add constraint FK_PATRIMONIO_VE_PRODUTOS foreign key (FK_PRODUTOS)
      references PRODUTOS (PK_PRODUTOS)
      on delete cascade
      on update cascade;

alter table PATRIMONIO_VEICULOS
   add constraint FK_PATRIMONIO_VE_VEICULOS foreign key (FK_VEICULOS_MARCAS, FK_VEICULOS_MODELOS, FK_VEICULOS)
      references VEICULOS (FK_VEICULOS_MARCAS, FK_VEICULOS_MODELOS, PK_VEICULOS)
      on delete cascade
      on update cascade;

alter table PEDIDOS_FRETES
   add constraint FK_PEDIDOS_FRETE_CONSIGNATARIO foreign key (FK_CONSIGNATARIO)
      references CADASTROS (PK_CADASTROS);

alter table PEDIDOS_FRETES
   add constraint FK_PEDIDOS_FRETE_DESTINATARIO foreign key (FK_DESTINATARIO)
      references CADASTROS (PK_CADASTROS);

alter table PEDIDOS_FRETES
   add constraint FK_PEDIDOS_FRETE_PEDIDOS foreign key (FK_EMPRESAS, FK_PEDIDOS)
      references PEDIDOS (FK_EMPRESAS, PK_PEDIDOS);

alter table PEDIDOS_FRETES
   add constraint FK_PEDIDOS_FRETE_REMETENTE foreign key (FK_REMETENTE)
      references CADASTROS (PK_CADASTROS);

alter table PRODUTOS_FRETES
   add constraint FK_PRODUTOS_FRETES_PRODUTOS foreign key (FK_PRODUTOS)
      references PRODUTOS (PK_PRODUTOS);

alter table TIPO_MANIFESTOS
   add constraint FK_TIPO_MANIFEST_TIPO_DOCUMENT foreign key (FK_TIPO_DOCUMENTOS)
      references TIPO_DOCUMENTOS (PK_TIPO_DOCUMENTOS);

alter table TRANSPORTADORAS_VEICULOS
   add constraint FK_TRANSPORTADOR_FORNECEDORES foreign key (FK_CADASTROS)
      references FORNECEDORES (FK_CADASTROS)
      on delete cascade
      on update cascade;

alter table TRANSPORTADORAS_VEICULOS
   add constraint FK_TRANSPORTADOR_VEICULOS foreign key (FK_VEICULOS_MARCAS, FK_VEICULOS_MODELOS, FK_VEICULOS)
      references VEICULOS (FK_VEICULOS_MARCAS, FK_VEICULOS_MODELOS, PK_VEICULOS);

alter table VEICULOS
   add constraint FK_VEICULOS_CENTRO_CUSTOS foreign key (FK_CENTRO_CUSTOS)
      references CENTRO_CUSTOS (PK_CENTRO_CUSTOS);

alter table VEICULOS
   add constraint FK_VEICULOS_VEICULOS_MODE foreign key (FK_VEICULOS_MARCAS, FK_VEICULOS_MODELOS)
      references VEICULOS_MODELOS (FK_VEICULOS_MARCAS, PK_VEICULOS_MODELOS);

alter table VEICULOS_IMAGENS
   add constraint FK_VEICULOS_IMAG_VEICULOS foreign key (FK_VEICULOS_MARCAS, FK_VEICULOS_MODELOS, FK_VEICULOS)
      references VEICULOS (FK_VEICULOS_MARCAS, FK_VEICULOS_MODELOS, PK_VEICULOS)
      on delete cascade
      on update cascade;

alter table VEICULOS_MODELOS
   add constraint FK_VEICULOS_MODE_VEICULOS_MARC foreign key (FK_VEICULOS_MARCAS)
      references VEICULOS_MARCAS (PK_VEICULOS_MARCAS);

alter table VEICULOS_OBSERVACOES
   add constraint FK_VEICULOS_OBSE_VEICULOS foreign key (FK_VEICULOS_MARCAS, FK_VEICULOS_MODELOS, FK_VEICULOS)
      references VEICULOS (FK_VEICULOS_MARCAS, FK_VEICULOS_MODELOS, PK_VEICULOS)
      on delete cascade
      on update cascade;

