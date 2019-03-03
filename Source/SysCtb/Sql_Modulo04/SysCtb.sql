/*==============================================================*/
/* Database name:  PROCESSA                                     */
/* DBMS name:      Friebird15x                                  */
/* Created on:     7/9/2006 18:47:32                            */
/*==============================================================*/


create generator CENARIOS_FINANCEIROS;

create generator HISTORICOS_PADROES;

create generator TIPO_CFOP;

create generator TIPO_IMPOSTOS;

/*==============================================================*/
/* Table: ALIQUOTAS                                             */
/*==============================================================*/
create table ALIQUOTAS (
FK_EMPRESAS          VALORI                         not null,
FK_PAISES            VALORI                         not null,
FK_ESTADOS           UF                             not null,
FK_TIPO_IMPOSTOS     VALORS                         not null,
PK_ALIQUOTAS         FLAG_ENTRADA_SAIDA             not null,
ALQT_IMPST           NUMERO_PERCENTUAL              not null,
ALQT_CNSF            NUMERO_PERCENTUAL              not null,
ALQT_ARBT            NUMERO_PERCENTUAL,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_ALIQUOTAS primary key (FK_TIPO_IMPOSTOS, FK_ESTADOS, FK_PAISES, PK_ALIQUOTAS, FK_EMPRESAS)
);

grant SELECT,UPDATE,INSERT,DELETE on ALIQUOTAS to PUBLIC;

/*==============================================================*/
/* Table: ALIQUOTAS_IMP_FISCAL                                  */
/*==============================================================*/
create table ALIQUOTAS_IMP_FISCAL (
FK_TIPO_IMPOSTOS     VALORS                         not null,
FK_EMPRESAS          VALORI                         not null,
FK_ESTADOS           UF                             not null,
FK_PAISES            VALORI                         not null,
FK_ALIQUOTAS         FLAG_ENTRADA_SAIDA             not null,
PK_ALIQUOTAS_IMP_FISCAL VALORS                         not null,
COD_ALQT             VALORS                         not null,
COD_ALQT_CNSF        VALORS                         not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_ALIQUOTAS_IMP_FISCAL primary key (FK_EMPRESAS, PK_ALIQUOTAS_IMP_FISCAL, FK_TIPO_IMPOSTOS, FK_ESTADOS, FK_PAISES, FK_ALIQUOTAS)
);

grant SELECT,UPDATE,INSERT,DELETE on ALIQUOTAS_IMP_FISCAL to PUBLIC;

/*==============================================================*/
/* Table: CENARIOS_FINANCEIROS                                  */
/*==============================================================*/
create table CENARIOS_FINANCEIROS (
PK_CENARIOS_FINANCEIROS VALORS                         not null,
FK_EMPRESAS          VALORI                         not null,
DSC_CEN              DESCRICAO_50RQ                 not null,
FLAG_TPCEN           FLAG_SIM_NAO                   not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_CENARIOS_FINANCEIROS primary key (PK_CENARIOS_FINANCEIROS)
);

grant SELECT,UPDATE,INSERT,DELETE on CENARIOS_FINANCEIROS to PUBLIC;

/*==============================================================*/
/* Table: CLASSIFICACAO_FISCAL                                  */
/*==============================================================*/
create table CLASSIFICACAO_FISCAL (
PK_CLASSIFICACAO_FISCAL DESCRICAO_20RQ                 not null,
DSC_CLSF             DESCRICAO_50RQ                 not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_CLASSIFICACAO_FISCAL primary key (PK_CLASSIFICACAO_FISCAL)
);

grant INSERT,UPDATE,SELECT,DELETE on CLASSIFICACAO_FISCAL to PUBLIC;

/*==============================================================*/
/* Table: FINANCEIROS_SALDOS_EXERCICIO                          */
/*==============================================================*/
create table FINANCEIROS_SALDOS_EXERCICIO (
FK_EMPRESAS          VALORI                         not null,
FK_FINANCEIRO_CONTAS VALORI                         not null,
FK_CENARIOS_FINANCEIROS VALORS                         not null,
PK_FINANCEIROS_SALDOS_EXERCICIO MES_ANO                        not null,
DTA_SLD              DATA_DEF                       not null,
SLD_CTA              NUMERO_GRANDE_4CD              not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_FINANCEIROS_SALDOS_EXERCICIO primary key (FK_EMPRESAS, FK_FINANCEIRO_CONTAS, FK_CENARIOS_FINANCEIROS, PK_FINANCEIROS_SALDOS_EXERCICIO)
);

/*==============================================================*/
/* Table: FINANCEIRO_CONTAS_SALDO                               */
/*==============================================================*/
create table FINANCEIRO_CONTAS_SALDO (
FK_EMPRESAS          VALORI                         not null,
FK_FINANCEIRO_CONTAS VALORI                         not null,
FK_CENARIOS_FINANCEIROS VALORS                         not null,
DTA_SLD              DATA_DEF                       not null,
SLD_CTA              NUMERO_GRANDE_4CD              not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_FINANCEIRO_CONTAS_SALDO primary key (FK_EMPRESAS, FK_FINANCEIRO_CONTAS, FK_CENARIOS_FINANCEIROS)
);

grant SELECT,UPDATE,INSERT,DELETE on FINANCEIRO_CONTAS_SALDO to PUBLIC;

/*==============================================================*/
/* Table: NATUREZA_OPERACOES                                    */
/*==============================================================*/
create table NATUREZA_OPERACOES (
FK_TIPO_CFOP         VALORS                         not null,
PK_NATUREZA_OPERACOES VALORS                         not null,
FK_FINANCEIRO_CONTAS VALORI,
DSC_NTOP             DESCRICAO_50RQ                 not null,
COD_CFOP             NATUREZA_DA_OPERACAO           not null,
CMPL_CFOP            COMLEMENTO_NAT_OPERACAO        not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_NATUREZA_OPERACOES primary key (FK_TIPO_CFOP, PK_NATUREZA_OPERACOES)
);

/*==============================================================*/
/* Index: IDX_NATUREZA_OPERACOES_01                             */
/*==============================================================*/
create unique asc index IDX_NATUREZA_OPERACOES_01 on NATUREZA_OPERACOES (
COD_CFOP,
CMPL_CFOP
);

grant SELECT,UPDATE,INSERT,DELETE on NATUREZA_OPERACOES to PUBLIC;

/*==============================================================*/
/* Table: ORIGENS_TRIBUTARIAS                                   */
/*==============================================================*/
create table ORIGENS_TRIBUTARIAS (
PK_ORIGENS_TRIBUTARIAS VALORS                         not null,
DSC_ORGM             DESCRICAO_50RQ                 not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_ORIGENS_TRIBUTARIAS primary key (PK_ORIGENS_TRIBUTARIAS)
);

grant DELETE,INSERT,UPDATE,SELECT on ORIGENS_TRIBUTARIAS to PUBLIC;

/*==============================================================*/
/* Table: SITUACAO_TRIBUTARIAS                                  */
/*==============================================================*/
create table SITUACAO_TRIBUTARIAS (
PK_SITUACAO_TRIBUTARIAS VALORS                         not null,
DSC_IMPST            DESCRICAO_50RQ                 not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_SITUACAO_TRIBUTARIAS primary key (PK_SITUACAO_TRIBUTARIAS)
);

grant SELECT,UPDATE,INSERT,DELETE on SITUACAO_TRIBUTARIAS to PUBLIC;

/*==============================================================*/
/* Table: TAX_RANGE                                             */
/*==============================================================*/
create table TAX_RANGE (
FK_TIPO_IMPOSTOS     VALORS                         not null,
PK_START_RANGE       NUMERO_GRANDE                  not null,
PK_END_RANGE         NUMERO_GRANDE                  not null,
ALQT_IMPST           NUMERO_PERCENTUAL,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_TAX_RANGE primary key (FK_TIPO_IMPOSTOS, PK_START_RANGE, PK_END_RANGE)
);

grant SELECT,UPDATE,INSERT,DELETE on TAX_RANGE to PUBLIC;

/*==============================================================*/
/* Table: TIPO_CFOP                                             */
/*==============================================================*/
create table TIPO_CFOP (
PK_TIPO_CFOP         VALORS                         not null,
DSC_TMRC             DESCRICAO_30RQ                 not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_TIPO_CFOP primary key (PK_TIPO_CFOP)
);

grant SELECT,UPDATE,INSERT,DELETE on TIPO_CFOP to PUBLIC;

/*==============================================================*/
/* Table: TIPO_IMPOSTOS                                         */
/*==============================================================*/
create table TIPO_IMPOSTOS (
PK_TIPO_IMPOSTOS     VALORS                         not null,
DSC_IMPS             DESCRICAO_30RQ                 not null,
FLAG_CALC            FLAG_SIM_NAO                   not null,
FLAG_IMPST           FLAG_IMPOSTO                   not null,
FLAG_RET             FLAG_SIM_NAO                   not null,
FLAG_ALQT_UNICA      FLAG_SIM_NAO                   not null,
FLAG_RANGE           FLAG_SIM_NAO                   not null,
FLAG_DSTC            FLAG_SIM_NAO                   not null,
RED_BASC             NUMERO_INDICE,
MSG_IMP              BLOB_TEXTO,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_TIPO_IMPOSTOS primary key (PK_TIPO_IMPOSTOS)
);

grant SELECT,UPDATE,INSERT,DELETE on TIPO_IMPOSTOS to PUBLIC;

/*==============================================================*/
/* Table: TIPO_IMPOSTOS_FINANCEIRO                              */
/*==============================================================*/
create table TIPO_IMPOSTOS_FINANCEIRO (
FK_TIPO_IMPOSTOS     VALORS                         not null,
PK_TIPO_IMPOSTOS_FINANCEIRO FLAG_DEBITO_CREDITO            not null,
FK_FINANCEIRO_CONTAS__CR VALORI                         not null,
FK_FINANCEIRO_CONTAS__DB VALORI                         not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_TIPO_IMPOSTOS_FINANCEIRO primary key (FK_TIPO_IMPOSTOS, PK_TIPO_IMPOSTOS_FINANCEIRO)
);

grant SELECT,UPDATE,INSERT,DELETE on TIPO_IMPOSTOS_FINANCEIRO to PUBLIC;

/*==============================================================*/
/* View: VW_ALL_TAXES                                           */
/*==============================================================*/
create view VW_ALL_TAXES
(
    PK_EMPRESAS,
    RAZ_SOC,
    FLAG_ES,
    DSC_TIMP,
    PK_TIPO_IMPOSTOS,
    DSC_IMPS,
    FK_PAISES,
    FK_ESTADOS,
    FK_EMPRESAS,
    ALQT_IMPST,
    ALQT_CNSF,
    ALQT_ARBT,
    DSC_PAIS,
    DSC_UF,
    PK_SUPORTED_PRINTERS,
    DSC_IMP,
    PK_ALIQUOTAS_IMP_FISCAL,
    COD_ALQT,
    COD_ALQT_CNSF,
    PK_ALIQUOTAS
) as
select Emp.PK_EMPRESAS, Emp.RAZ_SOC, Cast(0 as smallint) as FLAG_ES,
       Cast('Impostos sobre Compras' as varchar(30)) as DSC_TIMP,
       Tim.PK_TIPO_IMPOSTOS, Tim.DSC_IMPS, Alq.FK_PAISES,
       Alq.FK_ESTADOS, Alq.FK_EMPRESAS, Alq.ALQT_IMPST, Alq.ALQT_CNSF,
       Alq.ALQT_ARBT, Pai.DSC_PAIS, Est.DSC_UF, Spr.DSC_IMP,
       Spr.PK_SUPORTED_PRINTERS, Aif.PK_ALIQUOTAS_IMP_FISCAL,
       Aif.COD_ALQT, Aif.COD_ALQT_CNSF, Alq.PK_ALIQUOTAS
  from TIPO_IMPOSTOS Tim
  join EMPRESAS Emp
    on Emp.PK_EMPRESAS          > 0
  left outer join ALIQUOTAS Alq
    on Alq.FK_EMPRESAS          = Emp.PK_EMPRESAS
   and Alq.FK_TIPO_IMPOSTOS     = Tim.PK_TIPO_IMPOSTOS
   and Alq.PK_ALIQUOTAS         = 0
  left outer join PAISES Pai
    on Pai.PK_PAISES            = Alq.FK_PAISES
  left outer join ESTADOS Est
    on Est.FK_PAISES            = Alq.FK_PAISES
   and Est.PK_ESTADOS           = Alq.FK_ESTADOS
  left outer join ALIQUOTAS_IMP_FISCAL Aif
       left outer join SUPORTED_PRINTERS Spr
    on Aif.FK_EMPRESAS          = Alq.FK_EMPRESAS
   and Aif.FK_TIPO_IMPOSTOS     = Alq.FK_TIPO_IMPOSTOS
   and Aif.FK_PAISES            = Alq.FK_PAISES
   and Aif.FK_ESTADOS           = Alq.FK_ESTADOS
         on Spr.PK_SUPORTED_PRINTERS = Aif.PK_ALIQUOTAS_IMP_FISCAL
 where Tim.PK_TIPO_IMPOSTOS > 0
union
select Emp.PK_EMPRESAS, Emp.RAZ_SOC, Cast(1 as smallint) as FLAG_ES,
       Cast('Impostos sobre Vendas' as varchar(30)) as DSC_TIMP,
       Tim.PK_TIPO_IMPOSTOS, Tim.DSC_IMPS, Alq.FK_PAISES,
       Alq.FK_ESTADOS, Alq.FK_EMPRESAS, Alq.ALQT_IMPST, Alq.ALQT_CNSF,
       Alq.ALQT_ARBT, Pai.DSC_PAIS, Est.DSC_UF, Spr.DSC_IMP,
       Spr.PK_SUPORTED_PRINTERS, Aif.PK_ALIQUOTAS_IMP_FISCAL,
       Aif.COD_ALQT, Aif.COD_ALQT_CNSF, Alq.PK_ALIQUOTAS 
  from TIPO_IMPOSTOS Tim
  join EMPRESAS Emp
    on Emp.PK_EMPRESAS          > 0
  left outer join ALIQUOTAS Alq
    on Alq.FK_EMPRESAS          = Emp.PK_EMPRESAS
   and Alq.FK_TIPO_IMPOSTOS     = Tim.PK_TIPO_IMPOSTOS
   and Alq.PK_ALIQUOTAS         = 1
  left outer join PAISES Pai
    on Pai.PK_PAISES            = Alq.FK_PAISES
  left outer join ESTADOS Est
    on Est.FK_PAISES            = Alq.FK_PAISES
   and Est.PK_ESTADOS           = Alq.FK_ESTADOS
  left outer join ALIQUOTAS_IMP_FISCAL Aif
    on Aif.FK_EMPRESAS          = Alq.FK_EMPRESAS
   and Aif.FK_TIPO_IMPOSTOS     = Alq.FK_TIPO_IMPOSTOS
   and Aif.FK_PAISES            = Alq.FK_PAISES
   and Aif.FK_ESTADOS           = Alq.FK_ESTADOS
  left outer join SUPORTED_PRINTERS Spr
    on Spr.PK_SUPORTED_PRINTERS = Aif.PK_ALIQUOTAS_IMP_FISCAL
 where Tim.PK_TIPO_IMPOSTOS > 0;

grant SELECT,UPDATE,INSERT,DELETE on VW_ALL_TAXES to PUBLIC;

alter table ALIQUOTAS
   add constraint FK_ALIQUOTAS_EMPRESAS foreign key (FK_EMPRESAS)
      references EMPRESAS (PK_EMPRESAS);

alter table ALIQUOTAS
   add constraint FK_ALIQUOTAS_ESTADOS foreign key (FK_PAISES, FK_ESTADOS)
      references ESTADOS (FK_PAISES, PK_ESTADOS);

alter table ALIQUOTAS
   add constraint FK_ALIQUOTAS_TIPO_IMPOSTOS foreign key (FK_TIPO_IMPOSTOS)
      references TIPO_IMPOSTOS (PK_TIPO_IMPOSTOS);

alter table ALIQUOTAS_IMP_FISCAL
   add constraint FK_ALIQUOTAS_IMP_ALIQUOTAS foreign key (FK_TIPO_IMPOSTOS, FK_ESTADOS, FK_PAISES, FK_ALIQUOTAS, FK_EMPRESAS)
      references ALIQUOTAS (FK_TIPO_IMPOSTOS, FK_ESTADOS, FK_PAISES, PK_ALIQUOTAS, FK_EMPRESAS)
      on delete cascade
      on update cascade;

alter table CENARIOS_FINANCEIROS
   add constraint FK_FINANCEIRO_CENARIOS_EMPRESAS foreign key (FK_EMPRESAS)
      references EMPRESAS (PK_EMPRESAS);

alter table FINANCEIROS_SALDOS_EXERCICIO
   add constraint FK_FINANCEIROS_S_FINANCEIRO_CO foreign key (FK_EMPRESAS, FK_FINANCEIRO_CONTAS, FK_CENARIOS_FINANCEIROS)
      references FINANCEIRO_CONTAS_SALDO (FK_EMPRESAS, FK_FINANCEIRO_CONTAS, FK_CENARIOS_FINANCEIROS);

alter table FINANCEIRO_CONTAS_SALDO
   add constraint FK_FINANCEIRO_CONTAS_EMPRESAS foreign key (FK_EMPRESAS)
      references EMPRESAS (PK_EMPRESAS);

alter table FINANCEIRO_CONTAS_SALDO
   add constraint FK_FINANCEIRO_CO_CENARIOS_FINA foreign key (FK_CENARIOS_FINANCEIROS)
      references CENARIOS_FINANCEIROS (PK_CENARIOS_FINANCEIROS);

alter table FINANCEIRO_CONTAS_SALDO
   add constraint FK_FINANC_CONTA_FINANC_SALDO foreign key (FK_FINANCEIRO_CONTAS)
      references FINANCEIRO_CONTAS (PK_FINANCEIRO_CONTAS)
      on delete cascade
      on update cascade;

alter table NATUREZA_OPERACOES
   add constraint FK_NATUREZA_OPER_FINANCEIRO_CTA foreign key (FK_FINANCEIRO_CONTAS)
      references FINANCEIRO_CONTAS (PK_FINANCEIRO_CONTAS);

alter table NATUREZA_OPERACOES
   add constraint FK_NATUREZA_OPER_TIPO_CFOP foreign key (FK_TIPO_CFOP)
      references TIPO_CFOP (PK_TIPO_CFOP);

alter table TAX_RANGE
   add constraint FK_TAX_RANGE_TIPO_IMPOSTOS foreign key (FK_TIPO_IMPOSTOS)
      references TIPO_IMPOSTOS (PK_TIPO_IMPOSTOS);

alter table TIPO_IMPOSTOS_FINANCEIRO
   add constraint FK_TIPO_IMPOSTOS_FINANCEIRO__CR foreign key (FK_FINANCEIRO_CONTAS__CR)
      references FINANCEIRO_CONTAS (PK_FINANCEIRO_CONTAS);

alter table TIPO_IMPOSTOS_FINANCEIRO
   add constraint FK_TIPO_IMPOSTOS_FINANCEIRO__DB foreign key (FK_FINANCEIRO_CONTAS__DB)
      references FINANCEIRO_CONTAS (PK_FINANCEIRO_CONTAS);

alter table TIPO_IMPOSTOS_FINANCEIRO
   add constraint FK_TIPO_IMPOSTOS_TIPO_IMPOSTOS foreign key (FK_TIPO_IMPOSTOS)
      references TIPO_IMPOSTOS (PK_TIPO_IMPOSTOS);

