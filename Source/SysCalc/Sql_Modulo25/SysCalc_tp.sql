/*==============================================================*/
/* Database name:  PROCESSA                                     */
/* DBMS name:      InterBase 6.x                                */
/* Created on:     8/3/2004 11:00:39                            */
/*==============================================================*/



set term ^;

create procedure STP_CALC_MOTORS (
    P_FK_EMPRESAS      INTEGER,
    P_PK_CALCULOS      INTEGER
    )
RETURNS (
    R_NOM_CLI         VARCHAR(50),
    R_FON_CLI         VARCHAR(20),
    R_DSC_MOT         VARCHAR(50),
    R_POT_MOT         NUMERIC(9,4),
    R_ROT_MOT         INTEGER,
    R_LOC_MOT         VARCHAR(30),
    R_DSC_MOT_VND     VARCHAR(50),
    R_CNS_PONTA_ATU   DOUBLE PRECISION,
    R_CNS_FPONTA_ATU  DOUBLE PRECISION,
    R_CNS_TOTAL_ATU   DOUBLE PRECISION,
    R_CNS_PONTA_NEW   DOUBLE PRECISION,
    R_CNS_FPONTA_NEW  DOUBLE PRECISION,
    R_CNS_TOTAL_NEW   DOUBLE PRECISION,
    R_ECON_ENERG      DOUBLE PRECISION,
    R_ECON_ENERGF     DOUBLE PRECISION,
    R_VALOR_ECON      DOUBLE PRECISION,
    R_VALOR_ECONF     DOUBLE PRECISION,
    R_VALOR_ECONT     DOUBLE PRECISION,
    R_RET_INV_ANO_NEW NUMERIC(18,2),
    R_RET_INV_MES_NEW NUMERIC(18,2),
    R_RET_INV_ANO_ATU NUMERIC(18,2),
    R_RET_INV_MES_ATU NUMERIC(18,2),
    R_STATUS          SMALLINT)
AS
declare variable FkCadastros      integer;
declare variable FkParametrosCalc integer;
declare variable FkTipoMotores    integer;
declare variable FkTipoMotoresVnd integer;
declare variable QtdPolo          smallint;
declare variable KwhMot           double precision;
declare variable QtdPoloVnd       smallint;
declare variable CvMotVnd         double precision;
declare variable Nhf              smallint;
declare variable Nhh              smallint;
declare variable Ndm              smallint;
declare variable Nma              smallint;
declare variable CustoAux         double precision;
declare variable CustoNhf         double precision;
declare variable CustoNhh         double precision;
declare variable PrecoMot         double precision;
declare variable PercTroca        double precision;
begin
  R_STATUS = -1;
  /* select tabsheet data */
  select FK_CADASTROS, FK_PARAMETROS_CALC
    from CALCULOS
   where FK_EMPRESAS = :P_FK_EMPRESAS
     and PK_CALCULOS = :P_PK_CALCULOS
    into :FkCadastros, :FkParametrosCalc;
  /* select custumer data */
  select RAZ_SOC, FON_CAD from VW_CLIENTES
   where PK_CADASTROS = :FkCadastros
    into :R_NOM_CLI, :R_FON_CLI;
  /* select parameter data */
  select PARAM_NHF, PARAM_NHH, PARAM_NDM, PARAM_NMA, CUSTO_NHF,
         CUSTO_NHH, PERC_TROCA, KWH_MOT
    from PARAMETROS_CALC
   where PK_PARAMETROS_CALC = :FkParametrosCalc
    into :Nhf, :Nhh, :Ndm, :Nma, :CustoNhf, :CustoNhh, :PercTroca,
         :KwhMot;
  /* select custumer motor data */
  for select FK_TIPOS_MOTORES, FK_TIPOS_MOTORES__VND, DSC_MOT
        from MOTORES
       where FK_EMPRESAS = :P_FK_EMPRESAS
         and FK_CALCULOS = :P_PK_CALCULOS
        into :FkTipoMotores, :FkTipoMotoresVnd, R_LOC_MOT do
  begin
    select DSC_MOT, QTD_POLO, CV_MOT, RPM_MOT
      from TIPOS_MOTORES
     where PK_TIPOS_MOTORES = :FkTipoMotores
      into :R_DSC_MOT, :QtdPolo, :R_POT_MOT, :R_ROT_MOT;
    /* select sale motor data */
    select DSC_MOT, QTD_POLO, CV_MOT, PRECO_MOT
      from TIPOS_MOTORES
     where PK_TIPOS_MOTORES = :FkTipoMotoresVnd
      into :R_DSC_MOT_VND, :QtdPoloVnd, :CvMotVnd, :PrecoMot;
    /* Consumo no horário de ponta do motor atual */
    R_CNS_PONTA_ATU  = KwhMot * R_POT_MOT;
    R_CNS_PONTA_ATU  = R_CNS_PONTA_ATU * Nhf;
    R_CNS_PONTA_ATU  = R_CNS_PONTA_ATU * Ndm;
    R_CNS_PONTA_ATU  = R_CNS_PONTA_ATU * Nma;
    R_CNS_PONTA_ATU  = R_CNS_PONTA_ATU * 100.0;
    R_CNS_PONTA_ATU  = R_CNS_PONTA_ATU / 73.5;

    R_CNS_FPONTA_ATU = KwhMot * R_POT_MOT;
    R_CNS_FPONTA_ATU = R_CNS_PONTA_ATU * Nhh;
    R_CNS_FPONTA_ATU = R_CNS_PONTA_ATU * Ndm;
    R_CNS_FPONTA_ATU = R_CNS_PONTA_ATU * Nma;
    R_CNS_FPONTA_ATU = R_CNS_PONTA_ATU * 100.0;
    R_CNS_FPONTA_ATU = R_CNS_PONTA_ATU / 73.5;

    R_CNS_TOTAL_ATU  = R_CNS_PONTA_ATU + R_CNS_FPONTA_ATU;
    /* Consumo no horário de ponta do motor proposto */
    R_CNS_PONTA_NEW  = KwhMot * CvMotVnd;
    R_CNS_PONTA_NEW  = R_CNS_PONTA_ATU * Nhf;
    R_CNS_PONTA_NEW  = R_CNS_PONTA_ATU * Ndm;
    R_CNS_PONTA_NEW  = R_CNS_PONTA_ATU * Nma;
    R_CNS_PONTA_NEW  = R_CNS_PONTA_ATU * 100.0;
    R_CNS_PONTA_NEW  = R_CNS_PONTA_ATU / 73.5;

    R_CNS_FPONTA_NEW = KwhMot * CvMotVnd;
    R_CNS_FPONTA_NEW = R_CNS_PONTA_ATU * Nhh;
    R_CNS_FPONTA_NEW = R_CNS_PONTA_ATU * Ndm;
    R_CNS_FPONTA_NEW = R_CNS_PONTA_ATU * Nma;
    R_CNS_FPONTA_NEW = R_CNS_PONTA_ATU * 100.0;
    R_CNS_FPONTA_NEW = R_CNS_PONTA_ATU / 73.5;

    R_CNS_TOTAL_NEW   = R_CNS_PONTA_ATU + R_CNS_FPONTA_NEW;
    /* Economia de Energia no horário de ponta */
    R_ECON_ENERG      = R_CNS_PONTA_ATU - R_CNS_PONTA_NEW;
    R_VALOR_ECON      = R_ECON_ENERG * CustoNhf;
    /* Economia de Energia fora do horário de ponta */
    R_ECON_ENERGF     = R_CNS_FPONTA_ATU - R_CNS_FPONTA_NEW;
    R_VALOR_ECONF     = R_ECON_ENERGF * CustoNhh;
    R_VALOR_ECONT     = R_VALOR_ECONF + R_VALOR_ECON;
    /* Retorno do investimento com aquisição e descarte */
    R_RET_INV_ANO_NEW = 0;
    R_RET_INV_MES_NEW = 0;
    if (R_VALOR_ECONT > 0) then
    begin
      R_RET_INV_ANO_NEW = PrecoMot / R_VALOR_ECONT;
      R_RET_INV_MES_NEW = R_RET_INV_ANO_NEW * Nma;
    end
    /* Retorno do investimento a base de troca */
    R_RET_INV_ANO_ATU = 0;
    R_RET_INV_MES_ATU = 0;
    if (R_VALOR_ECONT > 0) then
    begin
      CustoAux = (PrecoMot * PercTroca) / 100;
      PrecoMot = PrecoMot - CustoAux;
      R_RET_INV_ANO_ATU =  PrecoMot / R_VALOR_ECONT;
      R_RET_INV_MES_ATU = R_RET_INV_ANO_ATU * Nma;
    end
    R_STATUS = 0;
    suspend;
  end
end ^

set term  ;^;

grant execute on procedure STP_CALC_MOTORS to public;

/*  Update trigger "TBU0_CALCULOS" for table "CALCULOS"  */
set term ^;

create trigger TBU0_CALCULOS for CALCULOS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
end^

set term ;^


/*  Insert trigger "TBIG_CALCULOS" for table "CALCULOS"  */
set term ^;

create trigger TBIG_CALCULOS for CALCULOS
before insert as
  declare variable MaxValue integer;
begin
  if ((New.PK_CALCULOS is null) or (New.PK_CALCULOS = 0)) then
  begin
    select Max(PK_CALCULOS)
      from CALCULOS
     where FK_EMPRESAS = New.FK_EMPRESAS
      into :MaxValue;
    if (MaxValue is null) then
      MaxValue   = 0;
    New.PK_CALCULOS = MaxValue + 1;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
end^

set term ;^


/*  Update trigger "TBU0_MOTORES" for table "MOTORES"  */
set term ^;

create trigger TBU0_MOTORES for MOTORES
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
end^

set term ;^


/*  Insert trigger "TBIG_MOTORES" for table "MOTORES"  */
set term ^;

create trigger TBIG_MOTORES for MOTORES
before insert as
  declare variable MaxValue integer;
begin
  if ((New.PK_MOTORES is null) or (New.PK_MOTORES = 0)) then
  begin
    select Max(PK_MOTORES)
      from MOTORES
     where FK_EMPRESAS = New.FK_EMPRESAS
       and FK_CALCULOS = New.FK_CALCULOS
      into :MaxValue;
    if (MaxValue is null) then
      MaxValue   = 0;
    New.PK_MOTORES = MaxValue + 1;
  end  
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
end^

set term ;^


/*  Insert trigger "TBIG_PARAMETROS_CALC" for table "PARAMETROS_CALC"  */
set term ^;

create trigger TBIG_PARAMETROS_CALC for PARAMETROS_CALC
before insert as
begin
  if ((New.PK_PARAMETROS_CALC is null) or (New.PK_PARAMETROS_CALC = 0)) then
    New.PK_PARAMETROS_CALC = Gen_Id(PARAMETROS_CALC, 1);
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
end^

set term ;^


/*  Update trigger "TBU0_PARAMETROS_CALC" for table "PARAMETROS_CALC"  */
set term ^;

create trigger TBU0_PARAMETROS_CALC for PARAMETROS_CALC
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
end^

set term ;^


/*  Insert trigger "TBIG_TIPOS_MOTORES" for table "TIPOS_MOTORES"  */
set term ^;

create trigger TBIG_TIPOS_MOTORES for TIPOS_MOTORES
before insert as
begin
  if ((New.PK_TIPOS_MOTORES is null) or (New.PK_TIPOS_MOTORES = 0)) then
    New.PK_TIPOS_MOTORES = Gen_Id(TIPOS_MOTORES, 1);
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
end^

set term ;^


/*  Update trigger "TBU0_TIPOS_MOTORES" for table "TIPOS_MOTORES"  */
set term ^;

create trigger TBU0_TIPOS_MOTORES for TIPOS_MOTORES
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
end^

set term ;^

