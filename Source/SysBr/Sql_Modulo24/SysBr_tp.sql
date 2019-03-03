/*==============================================================*/
/* Database name:  PROCESSA                                     */
/* DBMS name:      InterBase 6.x                                */
/* Created on:     20/04/2006 11:12:33                          */
/*==============================================================*/



set term ^;

create procedure STP_GENERATE_OCCURRENCE (
  P_FK_TIPO_OCORRENCIAS    smallint,
  P_PK_PRACAS_OCORRENCIAS  integer,
  P_FK_EMPRESAS            integer,
  P_FK_PRACAS              smallint,
  P_FK_PRACAS_PISTAS       smallint,
  P_FK_TIPO_TURNOS         smallint,
  P_FK_PRACAS_OPERADORES   smallint,
  P_FK_CATEGORIAS_PRODUTOS smallint,
  P_FK_FINALIZADORAS       smallint,
  P_DTHR_OCR               timestamp,
  P_FLAG_TOCR              smallint,
  P_STT_PAS                smallint,
  P_VLR_OCC                numeric(09, 04),
  P_DSCT_PASS              numeric(09, 04)
)
returns (
  R_STATUS smallint
)
as
  declare variable QtdRows    integer;
  declare variable FlagGFin   smallint;
  declare variable PkProdutos integer;
  declare variable PreVda     numeric(09, 04);
begin
  R_STATUS = 0;
  select FLAG_GFIN
    from TIPO_OCORRENCIAS
   where PK_TIPO_OCORRENCIAS = :P_FK_TIPO_OCORRENCIAS
    into :FlagGFin;
  if (FlagGFin is null) then
  begin
    R_STATUS = -2;  /* type ocurrences don't informed */
    suspend;
    exit;
  end
  select Count(*) from PRACAS
   where FK_EMPRESAS = :P_FK_EMPRESAS
     and PK_PRACAS   = :P_FK_PRACAS
    into :QtdRows;
  if ((QtdRows is null) or (QtdRows = 0)) then
  begin
    R_STATUS = -4; /* square don't informed */
    suspend;
    exit;
  end
  select Count(*) from PRACAS_PISTAS
   where FK_EMPRESAS      = :P_FK_EMPRESAS
     and FK_PRACAS        = :P_FK_PRACAS
     and PK_PRACAS_PISTAS = :P_FK_PRACAS_PISTAS
    into :QtdRows;
  if ((QtdRows is null) or (QtdRows = 0)) then
  begin
    R_STATUS = -6; /* Track don't informed */
    suspend;
    exit;
  end
  if (P_FLAG_TOCR is null) then
  begin
    R_STATUS = -8; /* Field FLAG_TORC don't informed */
    suspend;
    exit;
  end
  if (P_FLAG_TOCR = 1) then
  begin
    select Count(*) from TIPO_TURNOS
     where PK_TIPO_TURNOS = :P_FK_TIPO_TURNOS
      into :QtdRows;
    if ((QtdRows is null) or (QtdRows = 0)) then
    begin
      R_STATUS = -10; /* Shift don't informed */
      suspend;
      exit;
    end
    select Count(*) from PRACAS_OPERADORES
     where PK_PRACAS_OPERADORES = :P_FK_PRACAS_OPERADORES
      into :QtdRows;
    if ((QtdRows is null) or (QtdRows = 0)) then
    begin
      R_STATUS = -12; /* Operator don't informed */
      suspend;
      exit;
    end
  end
  if (P_FLAG_TOCR = 4) then
  begin
    select Prd.PK_PRODUTOS, Ppr.PRE_VDA
      from CATEGORIAS_PRODUTOS Cpr, PRODUTOS Prd,
           PRODUTOS_PRECOS Ppr
     where Cpr.FK_EMPRESAS = :P_FK_EMPRESAS
       and Cpr.FK_PRACAS   = :P_FK_PRACAS
       and Cpr.PK_CATEGORIAS_PRODUTOS = :P_FK_CATEGORIAS_PRODUTOS
       and Prd.PK_PRODUTOS = Cpr.FK_PRODUTOS
       and Ppr.FK_EMPRESAS > Cpr.FK_EMPRESAS
       and Ppr.FK_PRODUTOS > Cpr.FK_PRODUTOS
       and Prd.FLAG_ATV    = 1
      into :PkProdutos, :PreVda;
    if ((PkProdutos is null) or (PkProdutos = 0) or (PreVda is null)) then
    begin
      R_STATUS = -12; /* Value of category not found */
      suspend;
      exit;
    end
  end
  if (FlagGFin > 0) then
  begin
    select Count(*) from FINALIZADORAS
     where PK_FINALIZADORAS = :P_FK_FINALIZADORAS
      into :QtdRows;
    if ((QtdRows is null) or (QtdRows = 0)) then
    begin
      R_STATUS = -14; /* PaymentWay don't informed */
      suspend;
      exit;
    end
  end
  insert into PRACAS_OCORRENCIAS
    (FK_TIPO_OCORRENCIA, PK_PRACAS_OCORRENCIAS, FK_EMPRESAS,
     FK_PRACAS, FK_PRACAS_PISTAS, FK_TIPO_TURNOS,
     FK_PRACAS_OPERADORES, FK_CATEGORIAS_PRODUTOS, FK_FINALIZADORAS,
     DTHR_OCR, FLAG_TOCR, FLAG_GEN, STT_PAS, VLR_OCC, DSCT_PASS)
  values
    (:P_FK_TIPO_OCORRENCIAS, :P_PK_PRACAS_OCORRENCIAS, :P_FK_EMPRESAS,
     :P_FK_PRACAS, :P_FK_PRACAS_PISTAS, :P_FK_TIPO_TURNOS,
     :P_FK_PRACAS_OPERADORES, :P_FK_CATEGORIAS_PRODUTOS, :P_FK_FINALIZADORAS,
     :P_DTHR_OCR, :P_FLAG_TOCR, 0, :P_STT_PAS, :PreVda, :P_DSCT_PASS);
  suspend;
end ^

set term ;^

grant execute on procedure STP_GENERATE_OCCURRENCE to public;

grant EXECUTE on procedure STP_GENERATE_OCCURRENCE to PUBLIC;


/*  Insert trigger "TAI0_CATEGORIAS_PRODUTOS" for table "CATEGORIAS_PRODUTOS"  */
set term ^;

create trigger TAI0_CATEGORIAS_PRODUTOS for CATEGORIAS_PRODUTOS
  after insert as
begin
  execute procedure STP_INSERT_HISTORIC ('CATEGORIAS_PRODUTOS', 'CATEGORIAS_PRODUTOS',
    'insercao de registro', 'INC');
end^

set term ;^;


/*  Delete trigger "TAD0_CATEGORIAS_PRODUTOS" for table "CATEGORIAS_PRODUTOS"  */
set term ^;

create trigger TAD0_CATEGORIAS_PRODUTOS for CATEGORIAS_PRODUTOS
  after delete as
begin
  execute procedure STP_INSERT_HISTORIC ('CATEGORIAS_PRODUTOS', 'CATEGORIAS_PRODUTOS',
    'exclusao de registro', 'DEL');
end^

set term ;^;


/*  Update trigger "TAU0_CATEGORIAS_PRODUTOS" for table "CATEGORIAS_PRODUTOS"  */
set term ^;

create trigger TAU0_CATEGORIAS_PRODUTOS for CATEGORIAS_PRODUTOS
  after update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  execute procedure STP_INSERT_HISTORIC ('CATEGORIAS_PRODUTOS', 'CATEGORIAS_PRODUTOS',
    'atualizacao de registro', 'UPD');
end^

set term ;^;


/*  Insert trigger "TAI0_PRACAS_OCORRENCIAS" for table "PRACAS_OCORRENCIAS"  */
set term ^;

create trigger TAI0_PRACAS_OCORRENCIAS for PRACAS_OCORRENCIAS
  after insert as
begin
  execute procedure STP_INSERT_HISTORIC ('PRACAS_OCORRENCIAS', 'PRACAS_OCORRENCIAS',
    'insercao de registro', 'INC');
end^

set term ;^;


/*  Delete trigger "TAD0_PRACAS_OCORRENCIAS" for table "PRACAS_OCORRENCIAS"  */
set term ^;

create trigger TAD0_PRACAS_OCORRENCIAS for PRACAS_OCORRENCIAS
  after delete as
begin
  execute procedure STP_INSERT_HISTORIC ('PRACAS_OCORRENCIAS', 'PRACAS_OCORRENCIAS',
    'exclusao de registro', 'DEL');
end^

set term ;^;


/*  Update trigger "TAU0_PRACAS_OCORRENCIAS" for table "PRACAS_OCORRENCIAS"  */
set term ^;

create trigger TAU0_PRACAS_OCORRENCIAS for PRACAS_OCORRENCIAS
  after update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  execute procedure STP_INSERT_HISTORIC ('PRACAS_OCORRENCIAS', 'PRACAS_OCORRENCIAS',
    'atualizacao de registro', 'UPD');
end^

set term ;^;


/*  Insert trigger "TAI0_PRACAS_OPERADORES" for table "PRACAS_OPERADORES"  */
set term ^;

create trigger TAI0_PRACAS_OPERADORES for PRACAS_OPERADORES
  after insert as
begin
  execute procedure STP_INSERT_HISTORIC ('PRACAS_OPERADORES', 'PRACAS_OPERADORES',
    'insercao de registro', 'INC');
end^

set term ;^;


/*  Delete trigger "TAD0_PRACAS_OPERADORES" for table "PRACAS_OPERADORES"  */
set term ^;

create trigger TAD0_PRACAS_OPERADORES for PRACAS_OPERADORES
  after delete as
begin
  execute procedure STP_INSERT_HISTORIC ('PRACAS_OPERADORES', 'PRACAS_OPERADORES',
    'exclusao de registro', 'DEL');
end^

set term ;^;


/*  Update trigger "TAU0_PRACAS_OPERADORES" for table "PRACAS_OPERADORES"  */
set term ^;

create trigger TAU0_PRACAS_OPERADORES for PRACAS_OPERADORES
  after update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  execute procedure STP_INSERT_HISTORIC ('PRACAS_OPERADORES', 'PRACAS_OPERADORES',
    'atualizacao de registro', 'UPD');
end^

set term ;^;


/*  Insert trigger "TAI0_PRACAS_PISTAS" for table "PRACAS_PISTAS"  */
set term ^;

create trigger TAI0_PRACAS_PISTAS for PRACAS_PISTAS
  after insert as
begin
  execute procedure STP_INSERT_HISTORIC ('PRACAS_PISTAS', 'PRACAS_PISTAS',
    'insercao de registro', 'INC');
end^

set term ;^;


/*  Delete trigger "TAD0_PRACAS_PISTAS" for table "PRACAS_PISTAS"  */
set term ^;

create trigger TAD0_PRACAS_PISTAS for PRACAS_PISTAS
  after delete as
begin
  execute procedure STP_INSERT_HISTORIC ('PRACAS_PISTAS', 'PRACAS_PISTAS',
    'exclusao de registro', 'DEL');
end^

set term ;^;


/*  Update trigger "TAU0_PRACAS_PISTAS" for table "PRACAS_PISTAS"  */
set term ^;

create trigger TAU0_PRACAS_PISTAS for PRACAS_PISTAS
  after update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  execute procedure STP_INSERT_HISTORIC ('PRACAS_PISTAS', 'PRACAS_PISTAS',
    'atualizacao de registro', 'UPD');
end^

set term ;^;


/*  Delete trigger "TAD0_TIPO_OCORRENCIAS" for table "TIPO_OCORRENCIAS"  */
set term ^;

create trigger TAD0_TIPO_OCORRENCIAS for TIPO_OCORRENCIAS
  after delete as
begin
  execute procedure STP_INSERT_HISTORIC ('TIPO_OCORRENCIAS', 'TIPO_OCORRENCIAS',
    'exclusao de registro', 'DEL');
end^

set term ;^;


/*  Insert trigger "TBIG_TIPO_OCORRENCIAS" for table "TIPO_OCORRENCIAS"  */
set term ^;

create trigger TBIG_TIPO_OCORRENCIAS for TIPO_OCORRENCIAS
before insert as
begin
  if ((New.PK_TIPO_OCORRENCIAS is null) or (New.PK_TIPO_OCORRENCIAS = 0)) then
    New.PK_TIPO_OCORRENCIAS = Gen_Id(TIPO_OCORRENCIAS, 1);
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
  execute procedure STP_INSERT_HISTORIC ('TIPO_OCORRENCIAS', 'TIPO_OCORRENCIAS',
    'insercao de registro', 'INC');
end^

set term ;^;


/*  Update trigger "TAU0_TIPO_OCORRENCIAS" for table "TIPO_OCORRENCIAS"  */
set term ^;

create trigger TAU0_TIPO_OCORRENCIAS for TIPO_OCORRENCIAS
  after update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  execute procedure STP_INSERT_HISTORIC ('TIPO_OCORRENCIAS', 'TIPO_OCORRENCIAS',
    'atualizacao de registro', 'UPD');
end^

set term ;^;


/*  Delete trigger "TAD0_VINCULO_TOCORR_PRACAS" for table "VINCULO_TOCORR_PRACAS"  */
set term ^;

create trigger TAD0_VINCULO_TOCORR_PRACAS for VINCULO_TOCORR_PRACAS
  after delete as
begin
  execute procedure STP_INSERT_HISTORIC ('VINCULO_TOCORR_PRACAS', 'VINCULO_TOCORR_PRACAS',
    'exclusao de registro', 'DEL');
end^

set term ;^;


/*  Insert trigger "TAI0_VINCULO_TOCORR_PRACAS" for table "VINCULO_TOCORR_PRACAS"  */
set term ^;

create trigger TAI0_VINCULO_TOCORR_PRACAS for VINCULO_TOCORR_PRACAS
  after insert as
begin
  execute procedure STP_INSERT_HISTORIC ('VINCULO_TOCORR_PRACAS', 'VINCULO_TOCORR_PRACAS',
    'insercao de registro', 'INC');
end^

set term ;^;


/*  Update trigger "TAU0_VINCULO_TOCORR_PRACAS" for table "VINCULO_TOCORR_PRACAS"  */
set term ^;

create trigger TAU0_VINCULO_TOCORR_PRACAS for VINCULO_TOCORR_PRACAS
  after update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  execute procedure STP_INSERT_HISTORIC ('VINCULO_TOCORR_PRACAS', 'VINCULO_TOCORR_PRACAS',
    'atualizacao de registro', 'UPD');
end^

set term ;^;

