/*==============================================================*/
/* Database name:  PROCESSA                                     */
/* DBMS name:      Friebird15x                                  */
/* Created on:     7/9/2006 18:30:58                            */
/*==============================================================*/



set term ^;

create procedure STP_INSERE_EXPOSITORES_FUNC
(
    FkEmpresa    INTEGER,
    FkCadastro   INTEGER,
    FkContrato   INTEGER,
    NomFunc      VARCHAR(50),
    CargoFunc    VARCHAR(30)
)
RETURNS 
(
    Cod_Funcionario INTEGER
)
AS
begin
  Select Max(PK_EXPOSITORES_FUNC)
    from EXPOSITORES_FUNC
   where FK_CADASTROS = :FkCadastro
    into :Cod_Funcionario;
  if (Cod_Funcionario is null) then
    Cod_Funcionario   = 0;
  Cod_Funcionario = Cod_Funcionario + 1;
  /* Seleciona o proximo codigo */
  insert into EXPOSITORES_FUNC
    (FK_CADASTROS, PK_EXPOSITORES_FUNC, NOM_FUNC, CARGO_FUNC)
  values
    (:FkCadastro, :Cod_Funcionario, :NomFunc, :CargoFunc);
  /* Linka o evento e o Cadastro a empresa */
  insert into CONTRATO_EXPFUNC_VINC
    (FK_EMPRESAS, FK_CADASTROS, FK_CONTRATOS, FK_EXPOSITORES_FUNC)
  values
    (:fkEmpresa, :FkCadastro, :FkContrato, :Cod_Funcionario);
  suspend;
end^

set term ;^;

grant EXECUTE on procedure STP_INSERE_EXPOSITORES_FUNC to PUBLIC;


set term ^;

create procedure STP_INSERE_INSCRICAO
(
    PkEmpresas   INTEGER,
    TipoEvento   INTEGER,
    Evento       INTEGER,
    FlagCad      SMALLINT,
    DocPri       VARCHAR(14),
    DocSec       VARCHAR(30),
    NomIns       VARCHAR(50),
    NomFan       VARCHAR(50),
    FkPaises     INTEGER,
    FkEstados    CHAR(02),
    FkMunicipios INTEGER,
    EndCad       VARCHAR(50),
    NumEnd       INTEGER,
    CmpEnd       VARCHAR(50),
    CepCad       INTEGER,
    FonCad       VARCHAR(20),
    FaxCad       VARCHAR(20),
    CrgIns       VARCHAR(50),
    eMailCad     VARCHAR(50),
    VlrIns       NUMERIC(9,4),
    FkCadastros  INTEGER
)
RETURNS 
(
    Cod_Inscricao INTEGER
)
AS
  declare variable TipoStatus SMALLINT;
begin
  /* Seleciona o Status de Cadastro */
  select PK_TIPO_STATUS 
    from TIPO_STATUS
   where FLAG_CAD = 1
    into :TipoStatus;
  /* Seleciona o proximo codigo */
  Cod_Inscricao = Gen_Id(INSCRICOES, 1);
  /* Seleciona o proximo codigo */
  insert into INSCRICOES
    (PK_INSCRICOES, FLAG_CAD, DOC_PRI, DOC_SEC, NOM_INS, NOM_FAN,
     FK_PAISES, FK_ESTADOS, FK_MUNICIPIOS, END_CAD, NUM_END, CMP_END, 
     CEP_CAD, FON_CAD, FAX_CAD, CRG_INS, EMAIL_CAD, FLAG_ETQ, FLAG_EXP,
     FK_TIPO_STATUS, DTA_UAC, VLR_INS)
  values
    (:Cod_Inscricao, :FlagCad, :DocPri, :DocSec, :NomIns, :NomFan, :FkPaises,
     :FkEstados, :FkMunicipios, :EndCad, :NumEnd, :CmpEnd, :CepCad, 
     :FonCad, :FaxCad, :CrgIns, :eMailCad, 0, 0, 
     :TipoStatus, null, :VlrIns);
  /* Linka o evento na inscricao */
  insert into INSCRICOES_EVENTOS_VINC
    (FK_EMPRESAS, FK_TIPO_EVENTOS, FK_EVENTOS, FK_INSCRICOES, FK_CADASTROS)
  values
    (:PkEmpresas, :TipoEvento, :Evento, :Cod_Inscricao, :FkCadastros);
  suspend;
end^

set term ;^;

grant EXECUTE on procedure STP_INSERE_INSCRICAO to PUBLIC;


set term ^;

create procedure STP_INSERE_TERCERIZADA
(
    PkEmpresas   INTEGER,
    FkCadastro   INTEGER,
    FkContrato   INTEGER,
    FlagCad      SMALLINT,
    DocPri       VARCHAR(14),
    DocSec       VARCHAR(30),
    NomIns       VARCHAR(50),
    NomFan       VARCHAR(50),
    FkPaises     INTEGER,
    FkEstados    CHAR(02),
    FkMunicipios INTEGER,
    EndCad       VARCHAR(50),
    NumEnd       INTEGER,
    CmpEnd       VARCHAR(50),
    CepCad       INTEGER,
    FonCad       VARCHAR(20),
    FaxCad       VARCHAR(20),
    CelCad       VARCHAR(20),
    eMailCad     VARCHAR(50),
    LogTrc       VARCHAR(10),
    SenTrc       VARCHAR(10),
    SenhaCripto  VARCHAR(30)
)
RETURNS 
(
    Cod_Tercerizada INTEGER
)
AS
begin
  Cod_Tercerizada = Gen_Id(TERCERIZADAS, 1);
  /* Seleciona o proximo codigo */
  insert into TERCERIZADAS
    (PK_TERCERIZADAS, FLAG_CAD, DOC_PRI, DOC_SEC, NOM_INS, NOM_FAN,
     FK_PAISES, FK_ESTADOS, FK_MUNICIPIOS, END_CAD, NUM_END, CMP_END, 
     CEP_CAD, FON_CAD, FAX_CAD, CEL_CAD, EMAIL_CAD, LOG_TRC,
     SEN_TRC, SENHA_CRIPTO)
  values
    (:Cod_Tercerizada, :FlagCad, :DocPri, :DocSec, :NomIns, :NomFan, 
     :FkPaises, :FkEstados, :FkMunicipios, :EndCad, :NumEnd, :CmpEnd, 
     :CepCad, :FonCad, :FaxCad, :CelCad, :eMailCad, :LogTrc, 
     :SenTrc, :SenhaCripto);
  /* Linka o evento e o Cadastro a empresa */
  insert into CONTRATOS_TERC_VINC
    (FK_EMPRESAS, FK_CADASTROS, FK_CONTRATOS, FK_TERCERIZADAS)
  values
    (:PkEmpresas, :FkCadastro, :FkContrato, :Cod_Tercerizada);
  suspend;
end^

set term ;^;

grant EXECUTE on procedure STP_INSERE_TERCERIZADA to PUBLIC;


set term ^;

create procedure STP_INSERE_TERCERIZADAS_FUNC
(
    FkEmpresa     INTEGER,
    FkCadastro    INTEGER,
    FkContrato    INTEGER,
    FkTercerizada INTEGER,
    NomFunc       VARCHAR(50),
    CargoFunc     VARCHAR(30)
)
RETURNS 
(
    Cod_Funcionario INTEGER
)
AS
begin
  Select Max(PK_TERCERIZADAS_FUNC)
    from TERCERIZADAS_FUNC
   where FK_TERCERIZADAS = :FkTercerizada
    into :Cod_Funcionario;
  if (Cod_Funcionario is null) then
    Cod_Funcionario   = 0;
  Cod_Funcionario = Cod_Funcionario + 1;
  /* Seleciona o proximo codigo */
  insert into TERCERIZADAS_FUNC
    (FK_TERCERIZADAS, PK_TERCERIZADAS_FUNC, NOM_FUNC, CARGO_FUNC)
  values
    (:FkTercerizada, :Cod_Funcionario, :NomFunc, :CargoFunc);
  /* Linka o evento e o Cadastro a empresa */
  insert into TERC_FUNC_CTR_VINC
    (FK_EMPRESAS, FK_CADASTROS, FK_CONTRATOS, FK_TERCERIZADAS, FK_TERCERIZADAS_FUNC)
  values
    (:fkEmpresa, :FkCadastro, :FkContrato, :FkTercerizada, :Cod_Funcionario);
  suspend;
end^

set term ;^;

grant EXECUTE on procedure STP_INSERE_TERCERIZADAS_FUNC to PUBLIC;


/*  Update trigger "TBU0_CONTRATOS" for table "CONTRATOS"  */
set term ^;

create trigger TBU0_CONTRATOS for CONTRATOS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'CONTRATOS', 3, 'CONTRATOS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TAI0_CONTRATOS" for table "CONTRATOS"  */
set term ^;

create trigger TAI0_CONTRATOS for CONTRATOS
  after insert as
begin
  update EVENTOS set
    NUM_EXP = NUM_EXP + 1
   where FK_EMPRESAS     = New.FK_EMPRESAS
     and FK_TIPO_EVENTOS = New.FK_TIPO_EVENTOS
     and PK_EVENTOS      = New.FK_EVENTOS;
end;^

set term ;^;


/*  Insert trigger "TBIG_CONTRATOS" for table "CONTRATOS"  */
set term ^;

create trigger TBIG_CONTRATOS for CONTRATOS
before insert as
  declare variable MaxValue integer;
begin
  Select Max(PK_CONTRATOS)
    from CONTRATOS
   where FK_EMPRESAS = New.FK_EMPRESAS
    into :MaxValue;
  if (MaxValue is null) then
    MaxValue       = 0;
  New.PK_CONTRATOS = MaxValue + 1;
  New.OPE_INC      = user;
  New.DTHR_INC     = current_timestamp;
end;^

set term ;^;


/*  Update trigger "TBU0_SERVICOS" for table "CONTRATOS_SERVICOS"  */
set term ^;

create trigger TBU0_SERVICOS for CONTRATOS_SERVICOS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'CONTRATOS_SERVICOS', 3, 'CONTRATOS_SERVICOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_CONTRATOS_TERC_VINC" for table "CONTRATOS_TERC_VINC"  */
set term ^;

create trigger TBU0_CONTRATOS_TERC_VINC for CONTRATOS_TERC_VINC
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'CONTRATOS_TERC_VINC', 3, 'CONTRATOS_TERC_VINC', current_timestamp);
end^

set term ;^;

;


/*  Update trigger "TBU0_EVENTOS" for table "EVENTOS"  */
set term ^;

create trigger TBU0_EVENTOS for EVENTOS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'EVENTOS', 3, 'EVENTOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_EXPOSITORES_FUNC" for table "EXPOSITORES_FUNC"  */
set term ^;

create trigger TBU0_EXPOSITORES_FUNC for EXPOSITORES_FUNC
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'EXPOSITORES_FUNC', 3, 'EXPOSITORES_FUNC', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_EXPOSITORES_FUNC" for table "EXPOSITORES_FUNC"  */
set term ^;

create trigger TBIG_EXPOSITORES_FUNC for EXPOSITORES_FUNC
before insert as
  declare variable MaxValue integer;
begin
  if ((New.PK_EXPOSITORES_FUNC = 0) or
     (New.PK_EXPOSITORES_FUNC is null)) then
  begin
    Select Max(PK_EXPOSITORES_FUNC)
      from EXPOSITORES_FUNC
     where FK_CADASTROS = New.FK_CADASTROS
      into :MaxValue;
    if (MaxValue is null) then
      MaxValue   = 0;
    New.PK_EXPOSITORES_FUNC = MaxValue + 1;
  end
  New.OPE_INC             = user;
  New.DTHR_INC            = current_timestamp;
end;^

set term ;^;


/*  Update trigger "TBU0_INSCRICOES" for table "INSCRICOES"  */
set term ^;

create trigger TBU0_INSCRICOES for INSCRICOES
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'INSCRICOES', 3, 'INSCRICOES', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_INSCRICOES" for table "INSCRICOES"  */
set term ^;

create trigger TBIG_INSCRICOES for INSCRICOES
before insert as
  declare variable MaxValue integer;
begin
  if ((New.PK_INSCRICOES = 0) or
     (New.PK_INSCRICOES is null)) then
  begin
    New.PK_INSCRICOES = Gen_Id(INSCRICOES, 1);
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
end;^

set term ;^;


/*  Update trigger "TBU0_INSCRICOES_EVENTOS_VINC" for table "INSCRICOES_EVENTOS_VINC"  */
set term ^;

create trigger TBU0_INSCRICOES_EVENTOS_VINC for INSCRICOES_EVENTOS_VINC
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'INSCRICOES_EVENTOS_VINC', 3, 'INSCRICOES_EVENTOS_VINC', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TAI0_INSCRICOES_EVENTOS_VINC" for table "INSCRICOES_EVENTOS_VINC"  */
set term ^;

create trigger TAI0_INSCRICOES_EVENTOS_VINC for INSCRICOES_EVENTOS_VINC
  after insert as
begin
  update EVENTOS set
    NUM_INS = NUM_INS + 1
   where FK_EMPRESAS     = New.FK_EMPRESAS
     and FK_TIPO_EVENTOS = New.FK_TIPO_EVENTOS
     and PK_EVENTOS      = New.FK_EVENTOS;
end;^

set term ;^;


/*  Insert trigger "TBIG_INSCRICOES_TMP" for table "INSCRICOES_TMP"  */
set term ^;

create trigger TBIG_INSCRICOES_TMP for INSCRICOES_TMP
before insert as
  declare variable MaxValue integer;
begin
  if ((New.PK_INSCRICOES_TMP is null) or (New.PK_INSCRICOES_TMP = 0)) then
  begin
    select Max(PK_INSCRICOES_TMP)
      from INSCRICOES_TMP
     where PK_INSCRICOES_TMP = New.PK_INSCRICOES_TMP
      into :MaxValue;
    if (MaxValue is null) then
      MaxValue   = 0;
    New.PK_INSCRICOES_TMP = MaxValue + 1;
  end
end^

set term ;^;


/*  Update trigger "TBU0_PRECO_SEGMENTOS" for table "PRECO_SEGMENTOS"  */
set term ^;

create trigger TBU0_PRECO_SEGMENTOS for PRECO_SEGMENTOS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PRECO_SEGMENTOS', 3, 'PRECO_SEGMENTOS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TAI0_PRECO_SEGMENTOS" for table "PRECO_SEGMENTOS"  */
set term ^;

create trigger TAI0_PRECO_SEGMENTOS for PRECO_SEGMENTOS
  after insert as
begin
  update EVENTOS set
    NUM_CAT = NUM_CAT + 1
   where FK_EMPRESAS     = New.FK_EMPRESAS
     and FK_TIPO_EVENTOS = New.FK_TIPO_EVENTOS
     and PK_EVENTOS      = New.FK_EVENTOS;
end;^

set term ;^;


/*  Insert trigger "TBIG_SEGMENTOS" for table "SEGMENTOS"  */
set term ^;

create trigger TBIG_SEGMENTOS for SEGMENTOS
before insert as
begin
  if ((New.PK_SEGMENTOS is null) or (New.PK_SEGMENTOS = 0)) then
    New.PK_SEGMENTOS = Gen_Id(SEGMENTOS, 1);
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'SEGMENTOS', 2, 'SEGMENTOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_SEGMENTOS" for table "SEGMENTOS"  */
set term ^;

create trigger TBU0_SEGMENTOS for SEGMENTOS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'SEGMENTOS', 3, 'SEGMENTOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_TERCERIZADAS" for table "TERCERIZADAS"  */
set term ^;

create trigger TBU0_TERCERIZADAS for TERCERIZADAS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TERCERIZADAS', 3, 'TERCERIZADAS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_TERCERIZADAS" for table "TERCERIZADAS"  */
set term ^;

create trigger TBIG_TERCERIZADAS for TERCERIZADAS
before insert as
begin
  if ((New.PK_TERCERIZADAS = 0) or
     ( New.PK_TERCERIZADAS is null)) then
    New.PK_TERCERIZADAS = Gen_Id(TERCERIZADAS, 1);
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
end;^

set term ;^;


/*  Insert trigger "TBIG_TERCERIZADAS_FUNC" for table "TERCERIZADAS_FUNC"  */
set term ^;

create trigger TBIG_TERCERIZADAS_FUNC for TERCERIZADAS_FUNC
before insert as
  declare variable MaxValue integer;
begin
  if ((New.PK_TERCERIZADAS_FUNC = 0) or
     (New.PK_TERCERIZADAS_FUNC is null)) then
  begin
    Select Max(PK_TERCERIZADAS_FUNC)
      from TERCERIZADAS_FUNC
     where FK_TERCERIZADAS = New.FK_TERCERIZADAS
      into :MaxValue;
    if (MaxValue is null) then
      MaxValue   = 0;
    New.PK_TERCERIZADAS_FUNC = MaxValue + 1;
  end
  New.OPE_INC              = user;
  New.DTHR_INC             = current_timestamp;
end;^

set term ;^;


/*  Update trigger "TBU0_TERCERIZADAS_FUNC" for table "TERCERIZADAS_FUNC"  */
set term ^;

create trigger TBU0_TERCERIZADAS_FUNC for TERCERIZADAS_FUNC
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TERCERIZADAS_FUNC', 3, 'TERCERIZADAS_FUNC', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_TERCERIZADAS_INDICADAS" for table "TERCERIZADAS_INDICADAS"  */
set term ^;

create trigger TBU0_TERCERIZADAS_INDICADAS for TERCERIZADAS_INDICADAS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TERCERIZADAS_INDICADAS', 3, 'TERCERIZADAS_INDICADAS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_TERCERIZADAS_FUNC_VINCULO" for table "TERC_FUNC_CTR_VINC"  */
set term ^;

create trigger TBU0_TERCERIZADAS_FUNC_VINCULO for TERC_FUNC_CTR_VINC
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TERC_FUNC_CTR_VINC', 3, 'TERC_FUNC_CTR_VINC', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_TIPO_AREAS_ATUACAO" for table "TIPO_AREAS_ATUACAO"  */
set term ^;

create trigger TBIG_TIPO_AREAS_ATUACAO for TIPO_AREAS_ATUACAO
before insert as
begin
  if ((New.PK_TIPO_AREAS_ATUACAO is null) or (New.PK_TIPO_AREAS_ATUACAO = 0)) then
    New.PK_TIPO_AREAS_ATUACAO = Gen_Id(TIPO_AREAS_ATUACAO, 1);
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_AREAS_ATUACAO', 2, 'TIPO_AREAS_ATUACAO', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_TIPO_AREAS_ATUACAO" for table "TIPO_AREAS_ATUACAO"  */
set term ^;

create trigger TBU0_TIPO_AREAS_ATUACAO for TIPO_AREAS_ATUACAO
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_AREAS_ATUACAO', 3, 'TIPO_AREAS_ATUACAO', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_TIPO_EVENTOS" for table "TIPO_EVENTOS"  */
set term ^;

create trigger TBIG_TIPO_EVENTOS for TIPO_EVENTOS
before insert as
begin
  if ((New.PK_TIPO_EVENTOS is null) or (New.PK_TIPO_EVENTOS = 0)) then
    New.PK_TIPO_EVENTOS = Gen_Id(TIPO_EVENTOS, 1);
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_EVENTOS', 2, 'TIPO_EVENTOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_TIPO_EVENTOS" for table "TIPO_EVENTOS"  */
set term ^;

create trigger TBU0_TIPO_EVENTOS for TIPO_EVENTOS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_EVENTOS', 3, 'TIPO_EVENTOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_TIPO_EVENTOS_AREA_VINC" for table "TIPO_EVENTOS_AREA_VINC"  */
set term ^;

create trigger TBU0_TIPO_EVENTOS_AREA_VINC for TIPO_EVENTOS_AREA_VINC
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_EVENTOS_AREA_VINC', 3, 'TIPO_EVENTOS_AREA_VINC', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_TIPO_SERVICOS" for table "TIPO_SERVICOS"  */
set term ^;

create trigger TBIG_TIPO_SERVICOS for TIPO_SERVICOS
before insert as
begin
  if ((New.PK_TIPO_SERVICOS is null) or (New.PK_TIPO_SERVICOS = 0)) then
    New.PK_TIPO_SERVICOS = Gen_Id(TIPO_SERVICOS, 1);
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_SERVICOS', 2, 'TIPO_SERVICOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_TIPO_SERVICOS" for table "TIPO_SERVICOS"  */
set term ^;

create trigger TBU0_TIPO_SERVICOS for TIPO_SERVICOS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_SERVICOS', 3, 'TIPO_SERVICOS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_TIPO_STATUS" for table "TIPO_STATUS"  */
set term ^;

create trigger TBIG_TIPO_STATUS for TIPO_STATUS
before insert as
begin
  if ((New.PK_TIPO_STATUS is null) or (New.PK_TIPO_STATUS = 0)) then
    New.PK_TIPO_STATUS = Gen_Id(TIPO_STATUS, 1);
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_STATUS', 2, 'TIPO_STATUS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_TIPO_STATUS" for table "TIPO_STATUS"  */
set term ^;

create trigger TBU0_TIPO_STATUS for TIPO_STATUS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_STATUS', 3, 'TIPO_STATUS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_VINCULOS_SEG_INS" for table "VINCULOS_SEG_INS"  */
set term ^;

create trigger TBU0_VINCULOS_SEG_INS for VINCULOS_SEG_INS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'VINCULOS_SEG_INS', 3, 'VINCULOS_SEG_INS', current_timestamp);
end^

set term ;^;

