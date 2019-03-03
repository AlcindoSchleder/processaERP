/*==============================================================*/
/* Database name:  PROCESSA                                     */
/* DBMS name:      Friebird15x                                  */
/* Created on:     7/9/2006 00:53:06                            */
/*==============================================================*/



set term ^;

create procedure STP_GET_PK_ACESSOS (
  P_FK_OPERATOR varchar(10)
)
returns (
 R_PK_ACESSOS integer
)
as
begin
  R_PK_ACESSOS = null;
  if (P_FK_OPERATOR is not null) then
  begin
    select KC_ACESSOS from OPERADORES
     where PK_OPERADORES = :P_FK_OPERATOR
      into :R_PK_ACESSOS;
    if (R_PK_ACESSOS is null) then
      R_PK_ACESSOS = 0;
    R_PK_ACESSOS = R_PK_ACESSOS + 1;
    update OPERADORES set
           KC_ACESSOS = :R_PK_ACESSOS
     where PK_OPERADORES = :P_FK_OPERATOR;
  end
  suspend;
end^

set term ;^;

grant EXECUTE on procedure STP_GET_PK_ACESSOS to PUBLIC;


set term ^;

create procedure STP_GET_PK_DOCUMENT (
  P_FK_COMPANY       integer,
  P_FK_TYPE_DOCUMENT smallint
)
returns (
 R_PK_DOCUMENT integer
)
as
begin
  R_PK_DOCUMENT = null;
  if ((P_FK_COMPANY is not null) and (P_FK_TYPE_DOCUMENT  is not null))  then
  begin
    select NUM_DOC from TIPO_DOCUMENTOS_NUMERACAO
     where FK_EMPRESAS        = :P_FK_COMPANY
       and FK_TIPO_DOCUMENTOS = :P_FK_TYPE_DOCUMENT
      into :R_PK_DOCUMENT;
    if (R_PK_DOCUMENT is null) then
    begin
      insert into TIPO_DOCUMENTOS_NUMERACAO
        (FK_EMPRESAS, FK_TIPO_DOCUMENTOS, NUM_DOC)
      values
        (:P_FK_COMPANY, :P_FK_TYPE_DOCUMENT, 0);
      R_PK_DOCUMENT = 0;
    end
    R_PK_DOCUMENT = R_PK_DOCUMENT + 1;
    update TIPO_DOCUMENTOS_NUMERACAO set
           NUM_DOC            = :R_PK_DOCUMENT
     where FK_EMPRESAS        = :P_FK_COMPANY
       and FK_TIPO_DOCUMENTOS = :P_FK_TYPE_DOCUMENT;
  end
  suspend;
end^

set term ;^;

grant EXECUTE on procedure STP_GET_PK_DOCUMENT to PUBLIC;


set term ^;

create procedure STP_GET_PK_MASCARAS
returns (
  R_PK_MASCARAS smallint 
)
as
begin
  R_PK_MASCARAS = Gen_Id(MASCARAS, 1);
end ^

set term ;^;

grant EXECUTE on procedure STP_GET_PK_MASCARAS to PUBLIC;


set term ^;

create procedure STP_GET_PK_MENSAGENS (
  P_FK_LINGUAGENS varchar(05)
)
returns (
  R_PK_MENSAGENS smallint
)
as
begin
  R_PK_MENSAGENS = null;
  if ((P_FK_LINGUAGENS is null) or (P_FK_LINGUAGENS = '')) then
  begin
    suspend;
    exit;
  end
  select KC_MENSAGENS 
    from LINGUAGENS
   where PK_LINGUAGENS = :P_FK_LINGUAGENS
    into :R_PK_MENSAGENS;
  if (R_PK_MENSAGENS is null) then
    R_PK_MENSAGENS = 0;
  R_PK_MENSAGENS = R_PK_MENSAGENS + 1;
  update LINGUAGENS set
         KC_MENSAGENS  = :R_PK_MENSAGENS
   where PK_LINGUAGENS = :P_FK_LINGUAGENS;
  suspend;
end ^

set term ;^;

grant EXECUTE on procedure STP_GET_PK_MENSAGENS to PUBLIC;


set term ^;

create procedure STP_GET_PK_MODULOS
returns (
  R_PK_MODULOS smallint 
)
as
begin
  R_PK_MODULOS = Gen_Id(MODULOS, 1);
end ^

set term ;^;

grant EXECUTE on procedure STP_GET_PK_MODULOS to PUBLIC;


set term ^;

create procedure STP_GET_PK_PARAMETROS_PRG (
  P_FK_MODULOS   smallint,
  P_FK_ROTINAS   smallint,
  P_FK_PROGRAMAS smallint
)
returns (
  R_PK_PARAMETROS_PRG smallint
)
as
begin
  select QTD_PARAM     from PROGRAMAS 
   where FK_MODULOS   = :P_FK_MODULOS
     and FK_ROTINAS   = :P_FK_ROTINAS
     and PK_PROGRAMAS = :P_FK_PROGRAMAS
    into :R_PK_PARAMETROS_PRG;
  if (R_PK_PARAMETROS_PRG is null) then
    R_PK_PARAMETROS_PRG = 0;
  R_PK_PARAMETROS_PRG = R_PK_PARAMETROS_PRG + 1;
  update PROGRAMAS set 
         QTD_PARAM    = :R_PK_PARAMETROS_PRG
   where FK_MODULOS   = :P_FK_MODULOS
     and FK_ROTINAS   = :P_FK_ROTINAS
     and PK_PROGRAMAS = :P_FK_PROGRAMAS;
  suspend;
end ^

set term ;^;

grant EXECUTE on procedure STP_GET_PK_PARAMETROS_PRG to PUBLIC;


set term ^;

create procedure STP_GET_PK_RELATORIOS (
  P_FK_LINGUAGENS varchar(05),
  P_FK_MODULOS    smallint
)
returns (
  R_PK_RELATORIOS smallint
)
as
begin
  R_PK_RELATORIOS = null;
  if ((P_FK_LINGUAGENS is null) or (P_FK_LINGUAGENS = '')  or
     ( P_FK_MODULOS    is null) or (P_FK_MODULOS    = 0 )) then
  begin
    suspend;
    exit;
  end
  select KC_RELATORIOS 
    from MODULOS
   where FK_LINGUAGENS = :P_FK_LINGUAGENS
     and PK_MODULOS    = :P_FK_MODULOS
    into :R_PK_RELATORIOS;
  if (R_PK_RELATORIOS is null) then
    R_PK_RELATORIOS = 0;
  R_PK_RELATORIOS = R_PK_RELATORIOS + 1;
  update MODULOS set
         KC_RELATORIOS = :R_PK_RELATORIOS
   where FK_LINGUAGENS = :P_FK_LINGUAGENS
     and PK_MODULOS    = :P_FK_MODULOS;
  suspend;
end ^

set term ;^;

grant EXECUTE on procedure STP_GET_PK_RELATORIOS to PUBLIC;


set term ^;

create procedure STP_GET_PK_ROTINAS
returns (
  R_PK_ROTINAS smallint 
)
as
begin
  R_PK_ROTINAS = Gen_Id(ROTINAS, 1);
end ^

set term ;^;

grant EXECUTE on procedure STP_GET_PK_ROTINAS to PUBLIC;


set term ^;

create procedure STP_GET_PK_TIPO_DOCUMENTOS
returns (
  R_PK_TIPO_DOCUMENTOS smallint 
)
as
begin
  R_PK_TIPO_DOCUMENTOS = Gen_Id(TIPO_DOCUMENTOS, 1);
end ^

set term ;^;

grant EXECUTE on procedure STP_GET_PK_TIPO_DOCUMENTOS to PUBLIC;


set term ^;

create procedure STP_GET_PK_VALOR_CAMPOS (
  P_FK_LINGUAGENS        varchar(05),
  P_FK_DICIONARIOS__NA   varchar(31),
  P_FK_DICIONARIOS__NC   varchar(31)
)
returns (
  R_PK_VALOR_CAMPOS smallint
)
as
begin
  R_PK_VALOR_CAMPOS = null;
  if ((P_FK_LINGUAGENS      is null) or (P_FK_LINGUAGENS      = '')  or
     ( P_FK_DICIONARIOS__NA is null) or (P_FK_DICIONARIOS__NA = '')  or
     ( P_FK_DICIONARIOS__NC is null) or (P_FK_DICIONARIOS__NC = '')) then
  begin
    suspend;
    exit;
  end
  select KC_VALOR_CAMPOS 
    from DICIONARIOS
   where FK_LINGUAGENS      = :P_FK_LINGUAGENS
     and PK_DICIONARIOS__NA = :P_FK_DICIONARIOS__NA
     and PK_DICIONARIOS__NC = :P_FK_DICIONARIOS__NC
    into :R_PK_VALOR_CAMPOS;
  if (R_PK_VALOR_CAMPOS is null) then
    R_PK_VALOR_CAMPOS = 0;
  R_PK_VALOR_CAMPOS = R_PK_VALOR_CAMPOS + 1;
  update DICIONARIOS set
         KC_VALOR_CAMPOS    = :R_PK_VALOR_CAMPOS
   where FK_LINGUAGENS      = :P_FK_LINGUAGENS
     and PK_DICIONARIOS__NA = :P_FK_DICIONARIOS__NA
     and PK_DICIONARIOS__NC = :P_FK_DICIONARIOS__NC;
  suspend;
end ^

set term ;^;

grant EXECUTE on procedure STP_GET_PK_VALOR_CAMPOS to PUBLIC;


set term ^;

create procedure STP_LOG_USER (
  P_TYPE_LOG smallint
)
as 
  declare variable NomForm      varchar(31);
  declare variable PkOperadores varchar(10);
  declare variable DtHrLogin    timestamp;
  declare variable DtHrLogout   timestamp;
begin
/*
  P_TYPE_LOG must be: 
  0 ==> not connected 
  1 ==> connected
*/
  select FK_OPERADORES 
    from EMPRESA_ATIVA 
   where FK_OPERADORES = Cast(user as varchar(10))
    into :PkOperadores;
  if (PkOperadores is null)then
  begin
    DtHrLogin  = current_timestamp;
    DtHrLogout = current_timestamp;
    PkOperadores = Cast(user as varchar(10));
    insert into EMPRESA_ATIVA
      (FK_EMPRESAS, FK_OPERADORES, FK_LINGUAGENS, DTHR_LOGIN, DTHR_LOGOUT)
    values
      (1, :PkOperadores, 'pt_br', :DtHrLogin, :DtHrLogout);
  end
  DtHrLogin  = null;
  DtHrLogout = null;
  if (P_TYPE_LOG = 1) then
    DtHrLogin  = current_timestamp;
  else
    DtHrLogout = current_timestamp;
  update EMPRESA_ATIVA set
    DTHR_LOGIN  = :DtHrLogin,
    DTHR_LOGOUT = :DtHrLogout
   where FK_OPERADORES = :PkOperadores;
  if (P_TYPE_LOG = 1) then
    NomForm = 'Login Processa System';
  else
    NomForm = 'Logout Processa System';
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, :NomForm, 0, 'EMPRESA_ATIVA', current_timestamp);
end^

set term ;^;

grant EXECUTE on procedure STP_LOG_USER to PUBLIC;


set term ^;

create procedure STP_UPDATE_ACTIVE_USER (
  P_FK_EMPRESAS   smallint,
  P_FK_LINGUAGENS smallint
)
as 
  declare variable FkEmpresas   integer;
  declare variable FkLinguagens varchar(05);
  declare variable FkOperadores varchar(10);
begin
  select FK_OPERADORES, FK_EMPRESAS, FK_LINGUAGENS
    from EMPRESA_ATIVA 
   where FK_OPERADORES = Cast(user as varchar(10))
    into :FkOperadores, :FkEmpresas, :FkLinguagens;
  if (FkOperadores is null) then
  begin
    FkEmpresas   = 1;
    FkLinguagens = 'pt_br';
    insert into EMPRESA_ATIVA
      (FK_EMPRESAS, FK_OPERADORES, FK_LINGUAGENS, DTHR_LOGIN, DTHR_LOGOUT)
    values
      (:FkEmpresas, :FkOperadores, :FkLinguagens, current_timestamp, current_timestamp);
  end
  if (FkEmpresas <> P_FK_EMPRESAS) then
    FkEmpresas = P_FK_EMPRESAS;
  if (FkLinguagens <> P_FK_LINGUAGENS) then
    FkLinguagens = P_FK_LINGUAGENS;
  update EMPRESA_ATIVA set
    FK_EMPRESAS   = :FkEmpresas,
    FK_LINGUAGENS = :FkLinguagens
   where FK_OPERADORES = :FkOperadores;
end^

set term ;^;

grant EXECUTE on procedure STP_UPDATE_ACTIVE_USER to PUBLIC;


/*  Insert trigger "TBIG_ACESSOS" for table "ACESSOS"  */
set term ^;

create trigger TBIG_ACESSOS for ACESSOS
  before insert as
begin
  if ((New.PK_ACESSOS is null) or (New.PK_ACESSOS = 0)) then
  begin
    select R_PK_ACESSOS from STP_GET_PK_ACESSOS(New.FK_OPERADORES)
      into New.PK_ACESSOS;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'ACESSOS', 2, 'ACESSOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TAU0_ACESSOS" for table "ACESSOS"  */
set term ^;

create trigger TAU0_ACESSOS for ACESSOS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'ACESSOS', 3, 'ACESSOS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_ACESSOS" for table "ACESSOS"  */
set term ^;

create trigger TAD0_ACESSOS for ACESSOS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'ACESSOS', 4, 'ACESSOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TAU0_DICIONARIOS" for table "DICIONARIOS"  */
set term ^;

create trigger TAU0_DICIONARIOS for DICIONARIOS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'DICIONARIOS', 3, 'DICIONARIOS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TAI0_DICIONARIOS" for table "DICIONARIOS"  */
set term ^;

create trigger TAI0_DICIONARIOS for DICIONARIOS
  after insert as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'DICIONARIOS', 2, 'DICIONARIOS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_DICIONARIOS" for table "DICIONARIOS"  */
set term ^;

create trigger TAD0_DICIONARIOS for DICIONARIOS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'DICIONARIOS', 4, 'DICIONARIOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TAU0_EMPRESAS" for table "EMPRESAS"  */
set term ^;

create trigger TAU0_EMPRESAS for EMPRESAS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'EMPRESAS', 3, 'EMPRESAS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_EMPRESAS" for table "EMPRESAS"  */
set term ^;

create trigger TAD0_EMPRESAS for EMPRESAS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'EMPRESAS', 4, 'EMPRESAS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TAI0_EMPRESAS" for table "EMPRESAS"  */
set term ^;

create trigger TAI0_EMPRESAS for EMPRESAS
  after insert as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'EMPRESAS', 2, 'EMPRESAS', current_timestamp);
  insert into PARAMETROS 
    (FK_EMPRESAS, FLAG_COM_TPGTO, FLAG_COM_DESC, FLAG_COM_ITEM, FLAG_DESC_ITEM)
  values
    (New.PK_EMPRESAS, 0, 0, 0, 0);
end^

set term ;^;


/*  Update trigger "TBU0_EMPRESA_ATIVA" for table "EMPRESA_ATIVA"  */
set term ^;

create trigger TBU0_EMPRESA_ATIVA for EMPRESA_ATIVA
before update as
begin
  New.FK_OPERADORES  = user;
end^

set term ;^;


/*  Insert trigger "TAI0_EMPRESA_ATIVA" for table "EMPRESA_ATIVA"  */
set term ^;

create trigger TAI0_EMPRESA_ATIVA for EMPRESA_ATIVA
  after insert as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'EMPRESA_ATIVA', 2, 'First time user login', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_EMPRESA_ATIVA" for table "EMPRESA_ATIVA"  */
set term ^;

create trigger TAD0_EMPRESA_ATIVA for EMPRESA_ATIVA
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'EMPRESA_ATIVA', 4, 'Last time user logout', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_HISTORICOS" for table "HISTORICOS"  */
set term ^;

create trigger TBIG_HISTORICOS for HISTORICOS
before insert as
begin
  New.PK_HISTORICOS  = Gen_Id(HISTORICOS, 1);
end;^

set term ;^;


/*  Update trigger "TAU0_LINGUAGENS" for table "LINGUAGENS"  */
set term ^;

create trigger TAU0_LINGUAGENS for LINGUAGENS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'LINGUAGENS', 3, 'LINGUAGENS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_LINGUAGENS" for table "LINGUAGENS"  */
set term ^;

create trigger TAD0_LINGUAGENS for LINGUAGENS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'LINGUAGENS', 4, 'LINGUAGENS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TAI0_LINGUAGENS" for table "LINGUAGENS"  */
set term ^;

create trigger TAI0_LINGUAGENS for LINGUAGENS
  after insert as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'LINGUAGENS', 2, 'LINGUAGENS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_MASCARAS" for table "MASCARAS"  */
set term ^;

create trigger TBIG_MASCARAS for MASCARAS
  before insert as
begin
  if ((New.PK_MASCARAS is null) or (New.PK_MASCARAS = 0)) then
  begin
    select R_PK_MASCARAS from STP_GET_PK_MASCARAS
      into New.PK_MASCARAS;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'MASCARAS', 2, 'MASCARAS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TAU0_MASCARAS" for table "MASCARAS"  */
set term ^;

create trigger TAU0_MASCARAS for MASCARAS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'MASCARAS', 3, 'MASCARAS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_MASCARAS" for table "MASCARAS"  */
set term ^;

create trigger TAD0_MASCARAS for MASCARAS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'MASCARAS', 4, 'MASCARAS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_MENSAGENS" for table "MENSAGENS"  */
set term ^;

create trigger TBIG_MENSAGENS for MENSAGENS
  before insert as
begin
  if ((New.PK_MENSAGENS is null) or (New.PK_MENSAGENS = 0)) then
  begin
    select R_PK_MENSAGENS from STP_GET_PK_MENSAGENS(New.FK_LINGUAGENS)
      into New.PK_MENSAGENS;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'MENSAGENS', 2, 'MENSAGENS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TAU0_MENSAGENS" for table "MENSAGENS"  */
set term ^;

create trigger TAU0_MENSAGENS for MENSAGENS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'MENSAGENS', 3, 'MENSAGENS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_MENSAGENS" for table "MENSAGENS"  */
set term ^;

create trigger TAD0_MENSAGENS for MENSAGENS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'MENSAGENS', 4, 'MENSAGENS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_MODULOS" for table "MODULOS"  */
set term ^;

create trigger TBIG_MODULOS for MODULOS
  before insert as
begin
  if ((New.PK_MODULOS is null) or (New.PK_MODULOS = 0)) then
  begin
    select R_PK_MODULOS from STP_GET_PK_MODULOS
      into New.PK_MODULOS;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'MODULOS', 2, 'MODULOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TAU0_MODULOS" for table "MODULOS"  */
set term ^;

create trigger TAU0_MODULOS for MODULOS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'MODULOS', 3, 'MODULOS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_MODULOS" for table "MODULOS"  */
set term ^;

create trigger TAD0_MODULOS for MODULOS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'MODULOS', 4, 'MODULOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_OPERADORES" for table "OPERADORES"  */
set term ^;

create trigger TBU0_OPERADORES for OPERADORES
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'OPERADORES', 3, 'OPERADORES', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TAI0_OPERADORES" for table "OPERADORES"  */
set term ^;

create trigger TAI0_OPERADORES for OPERADORES
  after insert as
begin
  insert into RESOURCES 
    (PK_RESOURCES, FK_OPERADORES, DSC_RES, OBS_RES, IMAGE_INDEX,
     OBS_USER, FLAG_ATV, FLAG_SUPER)
  values
    (0, New.PK_OPERADORES, New.PK_OPERADORES, null, 0, null, 1, 0);
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'OPERADORES', 2, 'OPERADORES', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_OPERADORES" for table "OPERADORES"  */
set term ^;

create trigger TAD0_OPERADORES for OPERADORES
  after delete as
begin
  delete from HISTORICOS 
   where NOM_USU = Old.PK_OPERADORES;
end^

set term ;^;


/*  Update trigger "TAU0_PARAMETROS" for table "PARAMETROS"  */
set term ^;

create trigger TAU0_PARAMETROS for PARAMETROS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PARAMETROS', 3, 'PARAMETROS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TAI0_PARAMETROS" for table "PARAMETROS"  */
set term ^;

create trigger TAI0_PARAMETROS for PARAMETROS
  after insert as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PARAMETROS', 2, 'PARAMETROS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_PARAMETROS" for table "PARAMETROS"  */
set term ^;

create trigger TAD0_PARAMETROS for PARAMETROS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PARAMETROS', 4, 'PARAMETROS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_PARAMETROS_GLOBAIS" for table "PARAMETROS_GLOBAIS"  */
set term ^;

create trigger TBU0_PARAMETROS_GLOBAIS for PARAMETROS_GLOBAIS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  if ((Old.VER_1 <> New.VER_1) or (Old.VER_2 <> New.VER_2) or
     ( Old.VER_3 <> New.VER_3) or (Old.VER_4 <> New.VER_4)) then
  begin
    New.LAST_VERSION = Old.VERSAO;
    New.VERSAO  = Cast(New.VER_1 as varchar(1)) || '.' || 
                  Cast(New.VER_2 as varchar(1)) || '.' ||
                  Cast(New.VER_3 as varchar(1)) || '.' || 
                  Cast(New.VER_4 as varchar(1));
  end
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PARAMETROS_GLOBAIS', 3, 'PARAMETROS_GLOBAIS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBI0_PARAMETROS_GLOBAIS" for table "PARAMETROS_GLOBAIS"  */
create exception CANT_INSERT_ROWS 'Não posso inserir mais que um registro nesta tabela';

set term ^;

create trigger TBI0_PARAMETROS_GLOBAIS for PARAMETROS_GLOBAIS
  before insert as
  declare variable Rows integer;
begin
  select Count(*) from PARAMETROS_GLOBAIS
    into Rows;
  if ((Rows is not null) and (Rows > 0)) then
    exception CANT_INSERT_ROWS;
  if ((New.PK_PARAMETROS_GLOBAIS is null) or (New.PK_PARAMETROS_GLOBAIS = 0)) then
    New.PK_PARAMETROS_GLOBAIS = 1;
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PARAMETROS_GLOBAIS', 2, 'PARAMETROS_GLOBAIS', current_timestamp);
end^

set term ;^;


create exception CANT_DELETE_ROWS 'Não posso excluir registros desta tabela';

/*  Update trigger "TBD0_PARAMETROS_GLOBAIS" for table "PARAMETROS_GLOBAIS"  */
set term ^;

create trigger TBD0_PARAMETROS_GLOBAIS for PARAMETROS_GLOBAIS
before delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PARAMETROS_GLOBAIS', 4, 'PARAMETROS_GLOBAIS', current_timestamp);
  exception CANT_DELETE_ROWS;
end^

set term ;^;


/*  Update trigger "TAU0_PARAMETROS_PRG" for table "PARAMETROS_PRG"  */
set term ^;

create trigger TAU0_PARAMETROS_PRG for PARAMETROS_PRG
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PARAMETROS_PRG', 3, 'PARAMETROS_PRG', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_PARAMETROS_PRG" for table "PARAMETROS_PRG"  */
set term ^;

create trigger TBIG_PARAMETROS_PRG for PARAMETROS_PRG
  before insert as
begin
  if ((New.PK_PARAMETROS_PRG is null) or (New.PK_PARAMETROS_PRG = 0)) then
  begin
    select R_PK_PARAMETROS_PRG from STP_GET_PK_PARAMETROS_PRG(
           New.FK_MODULOS, New.FK_ROTINAS, New.FK_PROGRAMAS)
      into New.PK_PARAMETROS_PRG;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PARAMETROS_PRG', 2, 'PARAMETROS_PRG', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_PARAMETROS_PRG" for table "PARAMETROS_PRG"  */
set term ^;

create trigger TAD0_PARAMETROS_PRG for PARAMETROS_PRG
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PARAMETROS_PRG', 4, 'PARAMETROS_PRG', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_PROGRAMAS" for table "PROGRAMAS"  */
set term ^;

create trigger TBIG_PROGRAMAS for PROGRAMAS
before insert as
  declare variable MaxValue integer;
begin
  if ((New.PK_PROGRAMAS = 0) or (New.PK_PROGRAMAS is null)) then
  begin
    select Max(PK_PROGRAMAS)
      from PROGRAMAS
     where FK_MODULOS = New.FK_MODULOS
       and FK_ROTINAS = New.FK_ROTINAS
      into :MaxValue;
    if (MaxValue is null) then
      MaxValue   = 0;
    New.PK_PROGRAMAS  = MaxValue + 1;
  end
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PROGRAMAS', 2, 'PROGRAMAS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TAU0_PROGRAMAS" for table "PROGRAMAS"  */
set term ^;

create trigger TAU0_PROGRAMAS for PROGRAMAS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PROGRAMAS', 3, 'PROGRAMAS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_PROGRAMAS" for table "PROGRAMAS"  */
set term ^;

create trigger TAD0_PROGRAMAS for PROGRAMAS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PROGRAMAS', 4, 'PROGRAMAS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TAU0_PROGRAMAS_RELATORIOS" for table "PROGRAMAS_RELATORIOS"  */
set term ^;

create trigger TAU0_PROGRAMAS_RELATORIOS for PROGRAMAS_RELATORIOS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PROGRAMAS_RELATORIOS', 3, 'PROGRAMAS_RELATORIOS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TAI0_PROGRAMAS_RELATORIOS" for table "PROGRAMAS_RELATORIOS"  */
set term ^;

create trigger TAI0_PROGRAMAS_RELATORIOS for PROGRAMAS_RELATORIOS
  after insert as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PROGRAMAS_RELATORIOS', 2, 'PROGRAMAS_RELATORIOS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_PROGRAMAS_RELATORIOS" for table "PROGRAMAS_RELATORIOS"  */
set term ^;

create trigger TAD0_PROGRAMAS_RELATORIOS for PROGRAMAS_RELATORIOS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PROGRAMAS_RELATORIOS', 4, 'PROGRAMAS_RELATORIOS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_RELATORIOS" for table "RELATORIOS"  */
set term ^;

create trigger TBIG_RELATORIOS for RELATORIOS
  before insert as
begin
  if ((New.PK_RELATORIOS is null) or (New.PK_RELATORIOS = 0)) then
  begin
    select R_PK_RELATORIOS from STP_GET_PK_RELATORIOS(New.FK_LINGUAGENS, New.FK_MODULOS)
      into New.PK_RELATORIOS;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'RELATORIOS', 2, 'RELATORIOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TAU0_RELATORIOS" for table "RELATORIOS"  */
set term ^;

create trigger TAU0_RELATORIOS for RELATORIOS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'RELATORIOS', 3, 'RELATORIOS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_RELATORIOS" for table "RELATORIOS"  */
set term ^;

create trigger TAD0_RELATORIOS for RELATORIOS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'RELATORIOS', 4, 'RELATORIOS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_RESOURCES" for table "RESOURCES"  */
set term ^;

create trigger TBIG_RESOURCES for RESOURCES
before insert as
begin
  if ((New.PK_RESOURCES is null) or (New.PK_RESOURCES = 0)) then
    New.PK_RESOURCES = Gen_Id(RESOURCES, 1);
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'RESOURCES', 2, 'RESOURCES', current_timestamp);
end^

set term ;^;


/*  Update trigger "TAU0_RESOURCES" for table "RESOURCES"  */
set term ^;

create trigger TAU0_RESOURCES for RESOURCES
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'RESOURCES', 3, 'RESOURCES', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_RESOURCES" for table "RESOURCES"  */
set term ^;

create trigger TAD0_RESOURCES for RESOURCES
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'RESOURCES', 4, 'RESOURCES', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_ROTINAS" for table "ROTINAS"  */
set term ^;

create trigger TBIG_ROTINAS for ROTINAS
  before insert as
begin
  if ((New.PK_ROTINAS is null) or (New.PK_ROTINAS = 0)) then
  begin
    select R_PK_ROTINAS from STP_GET_PK_ROTINAS
      into New.PK_ROTINAS;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'ROTINAS', 2, 'ROTINAS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TAU0_ROTINAS" for table "ROTINAS"  */
set term ^;

create trigger TAU0_ROTINAS for ROTINAS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'ROTINAS', 3, 'ROTINAS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_ROTINAS" for table "ROTINAS"  */
set term ^;

create trigger TAD0_ROTINAS for ROTINAS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'ROTINAS', 4, 'ROTINAS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_TIPO_DOCUMENTOS" for table "TIPO_DOCUMENTOS"  */
set term ^;

create trigger TBIG_TIPO_DOCUMENTOS for TIPO_DOCUMENTOS
  before insert as
begin
  if ((New.PK_TIPO_DOCUMENTOS is null) or (New.PK_TIPO_DOCUMENTOS = 0)) then
  begin
    select R_PK_TIPO_DOCUMENTOS from STP_GET_PK_TIPO_DOCUMENTOS
      into New.PK_TIPO_DOCUMENTOS;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_DOCUMENTOS', 2, 'TIPO_DOCUMENTOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TAU0_TIPO_DOCUMENTOS" for table "TIPO_DOCUMENTOS"  */
set term ^;

create trigger TAU0_TIPO_DOCUMENTOS for TIPO_DOCUMENTOS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_DOCUMENTOS', 3, 'TIPO_DOCUMENTOS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_TIPO_DOCUMENTOS" for table "TIPO_DOCUMENTOS"  */
set term ^;

create trigger TAD0_TIPO_DOCUMENTOS for TIPO_DOCUMENTOS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_DOCUMENTOS', 4, 'TIPO_DOCUMENTOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TAU0_TIPO_DOCUMENTOS_NUMERACAO" for table "TIPO_DOCUMENTOS_NUMERACAO"  */
set term ^;

create trigger TAU0_TIPO_DOCUMENTOS_NUMERACAO for TIPO_DOCUMENTOS_NUMERACAO
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_DOCUMENTOS_NUMERACAO', 3, 'TIPO_DOCUMENTOS_NUMERACAO', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TAI0_TIPO_DOCUMENTOS_NUMERACAO" for table "TIPO_DOCUMENTOS_NUMERACAO"  */
set term ^;

create trigger TAI0_TIPO_DOCUMENTOS_NUMERACAO for TIPO_DOCUMENTOS_NUMERACAO
  after insert as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_DOCUMENTOS_NUMERACAO', 2, 'TIPO_DOCUMENTOS_NUMERACAO', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_TIPO_DOCUMENTOS_NUMERACAO" for table "TIPO_DOCUMENTOS_NUMERACAO"  */
set term ^;

create trigger TAD0_TIPO_DOCUMENTOS_NUMERACAO for TIPO_DOCUMENTOS_NUMERACAO
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_DOCUMENTOS_NUMERACAO', 4, 'TIPO_DOCUMENTOS_NUMERACAO', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_VALOR_CAMPOS" for table "VALOR_CAMPOS"  */
set term ^;

create trigger TBIG_VALOR_CAMPOS for VALOR_CAMPOS
  before insert as
begin
  if ((New.PK_VALOR_CAMPOS is null) or (New.PK_VALOR_CAMPOS = 0)) then
  begin
    select R_PK_VALOR_CAMPOS from STP_GET_PK_VALOR_CAMPOS(
      New.FK_LINGUAGENS, New.FK_DICIONARIOS__NA, New.FK_DICIONARIOS__NC)
      into New.PK_VALOR_CAMPOS;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'VALOR_CAMPOS', 2, 'VALOR_CAMPOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TAU0_VALOR_CAMPOS" for table "VALOR_CAMPOS"  */
set term ^;

create trigger TAU0_VALOR_CAMPOS for VALOR_CAMPOS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'VALOR_CAMPOS', 3, 'VALOR_CAMPOS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_VALOR_CAMPOS" for table "VALOR_CAMPOS"  */
set term ^;

create trigger TAD0_VALOR_CAMPOS for VALOR_CAMPOS
  after delete as
  declare variable SeqVal  integer;
  declare variable Counter integer;
begin
  Counter = 1;
  for select PK_VALOR_CAMPOS from VALOR_CAMPOS
       where FK_LINGUAGENS      = Old.FK_LINGUAGENS 
         and FK_DICIONARIOS__NA = Old.FK_DICIONARIOS__NA
         and FK_DICIONARIOS__NC = Old.FK_DICIONARIOS__NC
       order by FK_LINGUAGENS, FK_DICIONARIOS__NA, FK_DICIONARIOS__NC, 
                PK_VALOR_CAMPOS
        into :SeqVal do
  begin
    if (SeqVal <> Counter) then
      update VALOR_CAMPOS set
        PK_VALOR_CAMPOS = :Counter
       where FK_LINGUAGENS      = Old.FK_LINGUAGENS 
         and FK_DICIONARIOS__NA = Old.FK_DICIONARIOS__NA
         and FK_DICIONARIOS__NC = Old.FK_DICIONARIOS__NC
         and PK_VALOR_CAMPOS   = :SeqVal;
    Counter = Counter + 1;
  end
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'VALOR_CAMPOS', 4, 'VALOR_CAMPOS', current_timestamp);
end^

set term ;^;

