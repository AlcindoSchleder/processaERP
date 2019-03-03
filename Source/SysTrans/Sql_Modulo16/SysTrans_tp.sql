/*==============================================================*/
/* Database name:  PROCESSA                                     */
/* DBMS name:      Friebird15x                                  */
/* Created on:     31/10/2006 21:57:55                          */
/*==============================================================*/



set term ^;

create procedure STP_GET_MANIFESTOS_CONHECIMENTO (
  P_FK_EMPRESAS   integer,
  P_FK_MANIFESTOS integer
)
returns (
  R_PK_MANIFESTOS_CONHECIMENTOS smallint
  )
as
begin
  if ((P_FK_EMPRESAS   is null) or (P_FK_EMPRESAS   = 0)  or
     ( P_FK_MANIFESTOS is null) or (P_FK_MANIFESTOS = 0)) then
  begin
    R_PK_MANIFESTOS_CONHECIMENTOS = null;
    suspend;
    exit;
  end
  select KC_MANIFESTOS_CONHECIMENTOS 
    from MANIFESTOS
   where FK_EMPRESAS   = :P_FK_EMPRESAS
     and PK_MANIFESTOS = :P_FK_MANIFESTOS
    into :R_PK_MANIFESTOS_CONHECIMENTOS;
  if (R_PK_MANIFESTOS_CONHECIMENTOS is null) then
    R_PK_MANIFESTOS_CONHECIMENTOS = 0;
  R_PK_MANIFESTOS_CONHECIMENTOS = R_PK_MANIFESTOS_CONHECIMENTOS + 1;
  update MANIFESTOS set
         KC_MANIFESTOS_CONHECIMENTOS = :R_PK_MANIFESTOS_CONHECIMENTOS
   where FK_EMPRESAS   = :P_FK_EMPRESAS
     and PK_MANIFESTOS = :P_FK_MANIFESTOS;
  suspend;
end ^

set term ;^;

grant EXECUTE on procedure STP_GET_MANIFESTOS_CONHECIMENTO to PUBLIC;


set term ^;

create procedure STP_GET_PK_MANIFESTOS (
  P_FK_EMPRESAS        integer,
  P_FK_TIPO_MANIFESTOS smallint
)
returns (
 R_PK_MANIFESTOS integer
)
as
  declare variable FkTypeDocument  integer;
begin
  R_PK_MANIFESTOS = null;
  if ((P_FK_TIPO_MANIFESTOS is not null) and
      (P_FK_TIPO_MANIFESTOS > 0)) then
  begin
    select FK_TIPO_DOCUMENTOS
      from TIPO_MANIFESTOS
     where PK_TIPO_MANIFESTOS = :P_FK_TIPO_MANIFESTOS
      into :FkTypeDocument;
    if ((FkTypeDocument is not null) and (FkTypeDocument > 0)) then
    begin
      select NUM_DOC from TIPO_DOCUMENTOS_NUMERACAO
       where FK_EMPRESAS        = :P_FK_EMPRESAS
         and FK_TIPO_DOCUMENTOS = :FkTypeDocument
        into :R_PK_MANIFESTOS;
      if (R_PK_MANIFESTOS is null) then
      begin
        insert into TIPO_DOCUMENTOS_NUMERACAO
          (FK_EMPRESAS, FK_TIPO_DOCUMENTOS, NUM_DOC)
        values
          (:P_FK_EMPRESAS, :FkTypeDocument, 0);
        R_PK_MANIFESTOS = 0;
      end
      R_PK_MANIFESTOS = R_PK_MANIFESTOS + 1;
      update TIPO_DOCUMENTOS_NUMERACAO set
             NUM_DOC            = :R_PK_MANIFESTOS
       where FK_EMPRESAS        = :P_FK_EMPRESAS
         and FK_TIPO_DOCUMENTOS = :FkTypeDocument;
    end
  end
  suspend;
end^

set term ;^;

grant EXECUTE on procedure STP_GET_PK_MANIFESTOS to PUBLIC;


set term ^;

create procedure STP_GET_PK_MANIFESTOS_STATUS
returns (
  R_PK_MANIFESTOS_STATUS smallint
  )
as
begin
  R_PK_MANIFESTOS_STATUS = Gen_Id(MANIFESTOS_STATUS, 1);
  suspend;
end ^

set term ;^;

grant EXECUTE on procedure STP_GET_PK_MANIFESTOS_STATUS to PUBLIC;


set term ^;

create procedure STP_GET_PK_TIPO_MANIFESTOS
returns (
  R_PK_TIPO_MANIFESTOS smallint
  )
as
begin
  R_PK_TIPO_MANIFESTOS = Gen_Id(TIPO_MANIFESTOS, 1);
  suspend;
end ^

set term ;^;

grant EXECUTE on procedure STP_GET_PK_TIPO_MANIFESTOS to PUBLIC;


set term ^;

create procedure STP_GET_PK_VEICULOS (
  P_FK_VEICULOS_MARCAS   smallint,
  P_FK_VEICULOS_MODELOS  smallint
)
returns (
  R_PK_VEICULOS smallint
  )
as
begin
  R_PK_VEICULOS = 0;
  if ((P_FK_VEICULOS_MARCAS  is not null) and (P_FK_VEICULOS_MARCAS  = 0)  and
     ( P_FK_VEICULOS_MODELOS is not null) and (P_FK_VEICULOS_MODELOS = 0)) then
  begin
    select KC_VEICULOS 
      from VEICULOS_MODELOS
     where FK_VEICULOS_MARCAS  = :P_FK_VEICULOS_MARCAS
       and PK_VEICULOS_MODELOS = :P_FK_VEICULOS_MODELOS
      into :R_PK_VEICULOS;
    if (R_PK_VEICULOS is null) then
      R_PK_VEICULOS = 0;
    R_PK_VEICULOS = :R_PK_VEICULOS + 1;
    update VEICULOS_MODELOS set
           KC_VEICULOS = :R_PK_VEICULOS
     where FK_VEICULOS_MARCAS  = :P_FK_VEICULOS_MARCAS
       and PK_VEICULOS_MODELOS = :P_FK_VEICULOS_MODELOS;
  end 
  suspend;
end ^

set term ;^;

grant EXECUTE on procedure STP_GET_PK_VEICULOS to PUBLIC;


set term ^;

create procedure STP_GET_PK_VEICULOS_IMAGENS (
  P_FK_VEICULOS_MARCAS  smallint,
  P_FK_VEICULOS_MODELOS smallint,
  P_FK_VEICULOS         smallint
)
returns (
  R_PK_VEICULOS_IMAGENS smallint
)
as
begin
  R_PK_VEICULOS_IMAGENS = 0;
  if ((P_FK_VEICULOS_MARCAS   is not null) and (P_FK_VEICULOS_MARCAS   = 0)  and
     ( P_FK_VEICULOS_MODELOS  is not null) and (P_FK_VEICULOS_MODELOS  = 0)  and
     ( P_FK_VEICULOS          is not null) and (P_FK_VEICULOS          = 0)) then
  begin
    select KC_VEICULOS_IMAGENS
      from VEICULOS
     where FK_VEICULOS_MARCAS   = :P_FK_VEICULOS_MARCAS
       and FK_VEICULOS_MODELOS  = :P_FK_VEICULOS_MODELOS
       and PK_VEICULOS          = :P_FK_VEICULOS
      into :R_PK_VEICULOS_IMAGENS;
    if (R_PK_VEICULOS_IMAGENS is null) then
      R_PK_VEICULOS_IMAGENS = 0;
    R_PK_VEICULOS_IMAGENS = :R_PK_VEICULOS_IMAGENS + 1;
    update VEICULOS set
           KC_VEICULOS_IMAGENS  = :R_PK_VEICULOS_IMAGENS
     where FK_VEICULOS_MARCAS   = :P_FK_VEICULOS_MARCAS
       and FK_VEICULOS_MODELOS  = :P_FK_VEICULOS_MODELOS
       and PK_VEICULOS          = :P_FK_VEICULOS;
  end 
  suspend;
end ^

set term ;^;

grant EXECUTE on procedure STP_GET_PK_VEICULOS_IMAGENS to PUBLIC;


set term ^;

create procedure STP_GET_PK_VEICULOS_MARCAS
returns (
  R_PK_VEICULOS_MARCAS smallint
  )
as
begin
  R_PK_VEICULOS_MARCAS = Gen_Id(VEICULOS_MARCAS, 1);
  suspend;
end ^

set term ;^;

grant EXECUTE on procedure STP_GET_PK_VEICULOS_MARCAS to PUBLIC;


set term ^;

create procedure STP_GET_PK_VEICULOS_MODELOS (
  P_FK_VEICULOS_MARCAS smallint
)
returns (
  R_PK_VEICULOS_MODELOS smallint
  )
as
begin
  R_PK_VEICULOS_MODELOS = 0;
  if ((P_FK_VEICULOS_MARCAS is not null) and (P_FK_VEICULOS_MARCAS = 0)) then
  begin
    select KC_VEICULOS_MODELOS
      from VEICULOS_MARCAS
     where PK_VEICULOS_MARCAS   = :P_FK_VEICULOS_MARCAS
      into :R_PK_VEICULOS_MODELOS;
    if (R_PK_VEICULOS_MODELOS is null) then
      R_PK_VEICULOS_MODELOS = 0;
    R_PK_VEICULOS_MODELOS = :R_PK_VEICULOS_MODELOS + 1;
    update VEICULOS_MARCAS set
           KC_VEICULOS_MODELOS = :R_PK_VEICULOS_MODELOS
     where PK_VEICULOS_MARCAS  = :P_FK_VEICULOS_MARCAS;
  end 
  suspend;
end ^

set term ;^;

grant EXECUTE on procedure STP_GET_PK_VEICULOS_MODELOS to PUBLIC;


/*  Delete trigger "TAD0_FORNECEDORES_MARCAS" for table "FORNECEDORES_MARCAS"  */
set term ^;

create trigger TAD0_FORNECEDORES_MARCAS for FORNECEDORES_MARCAS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'FORNECEDORES_MARCAS', 4, 'FORNECEDORES_MARCAS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TAI0_FORNECEDORES_MARCAS" for table "FORNECEDORES_MARCAS"  */
set term ^;

create trigger TAI0_FORNECEDORES_MARCAS for FORNECEDORES_MARCAS
  after insert as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'FORNECEDORES_MARCAS', 2, 'FORNECEDORES_MARCAS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_FORNECEDORES_MARCAS" for table "FORNECEDORES_MARCAS"  */
set term ^;

create trigger TBU0_FORNECEDORES_MARCAS for FORNECEDORES_MARCAS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'FORNECEDORES_MARCAS', 3, 'FORNECEDORES_MARCAS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TAI0_FORNECEDORES_REGIOES" for table "FORNECEDORES_REGIOES"  */
set term ^;

create trigger TAI0_FORNECEDORES_REGIOES for FORNECEDORES_REGIOES
  after insert as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'FORNECEDORES_REGIOES', 2, 'FORNECEDORES_REGIOES', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_FORNECEDORES_REGIOES" for table "FORNECEDORES_REGIOES"  */
set term ^;

create trigger TAD0_FORNECEDORES_REGIOES for FORNECEDORES_REGIOES
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'FORNECEDORES_REGIOES', 4, 'FORNECEDORES_REGIOES', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_FORNECEDORES_REGIOES" for table "FORNECEDORES_REGIOES"  */
set term ^;

create trigger TBU0_FORNECEDORES_REGIOES for FORNECEDORES_REGIOES
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'FORNECEDORES_REGIOES', 3, 'FORNECEDORES_REGIOES', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_MANIFESTOS" for table "MANIFESTOS"  */
set term ^;

create trigger TAD0_MANIFESTOS for MANIFESTOS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'MANIFESTOS', 4, 'MANIFESTOS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBI0_MANIFESTOS" for table "MANIFESTOS"  */
set term ^;

create trigger TBI0_MANIFESTOS for MANIFESTOS
  before insert as
begin
  if ((New.PK_MANIFESTOS is null) or (New.PK_MANIFESTOS = 0)) then
  begin
    select R_PK_MANIFESTOS from STP_GET_PK_MANIFESTOS(New.FK_EMPRESAS, New.FK_TIPO_MANIFESTOS)
      into New.PK_MANIFESTOS;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'MANIFESTOS', 2, 'MANIFESTOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_MANIFESTOS" for table "MANIFESTOS"  */
set term ^;

create trigger TBU0_MANIFESTOS for MANIFESTOS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'MANIFESTOS', 3, 'MANIFESTOS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_MANIFESTOS_CONHECIMENTOS" for table "MANIFESTOS_CONHECIMENTOS"  */
set term ^;

create trigger TAD0_MANIFESTOS_CONHECIMENTOS for MANIFESTOS_CONHECIMENTOS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'MANIFESTOS_CONHECIMENTOS', 4, 'MANIFESTOS_CONHECIMENTOS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBI0_MANIFESTOS_CONHECIMENTOS" for table "MANIFESTOS_CONHECIMENTOS"  */
set term ^;

create trigger TBI0_MANIFESTOS_CONHECIMENTOS for MANIFESTOS_CONHECIMENTOS
  before insert as
begin
  if ((New.PK_MANIFESTOS_CONHECIMENTOS is null) or (New.PK_MANIFESTOS_CONHECIMENTOS = 0)) then
  begin
    select R_PK_MANIFESTOS_CONHECIMENTOS from STP_GET_MANIFESTOS_CONHECIMENTO(New.FK_EMPRESAS, New.FK_MANIFESTOS)
      into New.PK_MANIFESTOS_CONHECIMENTOS;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'MANIFESTOS_CONHECIMENTOS', 2, 'MANIFESTOS_CONHECIMENTOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_MANIFESTOS_CONHECIMENTOS" for table "MANIFESTOS_CONHECIMENTOS"  */
set term ^;

create trigger TBU0_MANIFESTOS_CONHECIMENTOS for MANIFESTOS_CONHECIMENTOS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'MANIFESTOS_CONHECIMENTOS', 3, 'MANIFESTOS_CONHECIMENTOS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_MANIFESTOS_OCORRENCIAS" for table "MANIFESTOS_OCORRENCIAS"  */
set term ^;

create trigger TAD0_MANIFESTOS_OCORRENCIAS for MANIFESTOS_OCORRENCIAS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'MANIFESTOS_OCORRENCIAS', 4, 'MANIFESTOS_OCORRENCIAS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TAI0_MANIFESTOS_OCORRENCIAS" for table "MANIFESTOS_OCORRENCIAS"  */
set term ^;

create trigger TAI0_MANIFESTOS_OCORRENCIAS for MANIFESTOS_OCORRENCIAS
  after insert as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'MANIFESTOS_OCORRENCIAS', 2, 'MANIFESTOS_OCORRENCIAS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_MANIFESTOS_OCORRENCIAS" for table "MANIFESTOS_OCORRENCIAS"  */
set term ^;

create trigger TBU0_MANIFESTOS_OCORRENCIAS for MANIFESTOS_OCORRENCIAS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'MANIFESTOS_OCORRENCIAS', 3, 'MANIFESTOS_OCORRENCIAS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_MANIFESTOS_STATUS" for table "MANIFESTOS_STATUS"  */
set term ^;

create trigger TAD0_MANIFESTOS_STATUS for MANIFESTOS_STATUS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'MANIFESTOS_STATUS', 4, 'MANIFESTOS_STATUS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBI0_MANIFESTOS_STATUS" for table "MANIFESTOS_STATUS"  */
set term ^;

create trigger TBI0_MANIFESTOS_STATUS for MANIFESTOS_STATUS
  before insert as
begin
  if ((New.PK_MANIFESTOS_STATUS is null) or (New.PK_MANIFESTOS_STATUS = 0)) then
  begin
    select R_PK_MANIFESTOS_STATUS from STP_GET_PK_MANIFESTOS_STATUS
      into New.PK_MANIFESTOS_STATUS;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'MANIFESTOS_STATUS', 2, 'MANIFESTOS_STATUS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_MANIFESTOS_STATUS" for table "MANIFESTOS_STATUS"  */
set term ^;

create trigger TBU0_MANIFESTOS_STATUS for MANIFESTOS_STATUS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'MANIFESTOS_STATUS', 3, 'MANIFESTOS_STATUS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_MANIFESTOS_TOTAIS" for table "MANIFESTOS_TOTAIS"  */
set term ^;

create trigger TAD0_MANIFESTOS_TOTAIS for MANIFESTOS_TOTAIS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'MANIFESTOS_TOTAIS', 4, 'MANIFESTOS_TOTAIS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TAI0_MANIFESTOS_TOTAIS" for table "MANIFESTOS_TOTAIS"  */
set term ^;

create trigger TAI0_MANIFESTOS_TOTAIS for MANIFESTOS_TOTAIS
  after insert as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'MANIFESTOS_TOTAIS', 2, 'MANIFESTOS_TOTAIS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_MANIFESTOS_TOTAIS" for table "MANIFESTOS_TOTAIS"  */
set term ^;

create trigger TBU0_MANIFESTOS_TOTAIS for MANIFESTOS_TOTAIS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'MANIFESTOS_TOTAIS', 3, 'MANIFESTOS_TOTAIS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_PATRIMONIO_VEICULOS" for table "PATRIMONIO_VEICULOS"  */
set term ^;

create trigger TAD0_PATRIMONIO_VEICULOS for PATRIMONIO_VEICULOS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PATRIMONIO_VEICULOS', 4, 'PATRIMONIO_VEICULOS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TAI0_PATRIMONIO_VEICULOS" for table "PATRIMONIO_VEICULOS"  */
set term ^;

create trigger TAI0_PATRIMONIO_VEICULOS for PATRIMONIO_VEICULOS
  after insert as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PATRIMONIO_VEICULOS', 2, 'PATRIMONIO_VEICULOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_PATRIMONIO_VEICULOS" for table "PATRIMONIO_VEICULOS"  */
set term ^;

create trigger TBU0_PATRIMONIO_VEICULOS for PATRIMONIO_VEICULOS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PATRIMONIO_VEICULOS', 3, 'PATRIMONIO_VEICULOS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_PRODUTOS_FRETES" for table "PRODUTOS_FRETES"  */
set term ^;

create trigger TAD0_PRODUTOS_FRETES for PRODUTOS_FRETES
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PRODUTOS_FRETES', 4, 'PRODUTOS_FRETES', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TAI0_PRODUTOS_FRETES" for table "PRODUTOS_FRETES"  */
set term ^;

create trigger TAI0_PRODUTOS_FRETES for PRODUTOS_FRETES
  after insert as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PRODUTOS_FRETES', 2, 'PRODUTOS_FRETES', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_PRODUTOS_FRETES" for table "PRODUTOS_FRETES"  */
set term ^;

create trigger TBU0_PRODUTOS_FRETES for PRODUTOS_FRETES
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PRODUTOS_FRETES', 3, 'PRODUTOS_FRETES', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBI0_TIPO_MANIFESTOS" for table "TIPO_MANIFESTOS"  */
set term ^;

create trigger TBI0_TIPO_MANIFESTOS for TIPO_MANIFESTOS
  before insert as
begin
  if ((New.PK_TIPO_MANIFESTOS is null) or (New.PK_TIPO_MANIFESTOS = 0)) then
  begin
    select R_PK_TIPO_MANIFESTOS from STP_GET_PK_TIPO_MANIFESTOS
      into New.PK_TIPO_MANIFESTOS;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_MANIFESTOS', 2, 'TIPO_MANIFESTOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_TIPO_MANIFESTOS" for table "TIPO_MANIFESTOS"  */
set term ^;

create trigger TBU0_TIPO_MANIFESTOS for TIPO_MANIFESTOS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_MANIFESTOS', 3, 'TIPO_MANIFESTOS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_TIPO_MANIFESTOS" for table "TIPO_MANIFESTOS"  */
set term ^;

create trigger TAD0_TIPO_MANIFESTOS for TIPO_MANIFESTOS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_MANIFESTOS', 4, 'TIPO_MANIFESTOS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TAI0_TRANSPORTADORAS_VEICULOS" for table "TRANSPORTADORAS_VEICULOS"  */
set term ^;

create trigger TAI0_TRANSPORTADORAS_VEICULOS for TRANSPORTADORAS_VEICULOS
  after insert as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TRANSPORTADORAS_VEICULOS', 2, 'TRANSPORTADORAS_VEICULOS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_TRANSPORTADORAS_VEICULOS" for table "TRANSPORTADORAS_VEICULOS"  */
set term ^;

create trigger TAD0_TRANSPORTADORAS_VEICULOS for TRANSPORTADORAS_VEICULOS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TRANSPORTADORAS_VEICULOS', 4, 'TRANSPORTADORAS_VEICULOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_TRANSPORTADORAS_VEICULOS" for table "TRANSPORTADORAS_VEICULOS"  */
set term ^;

create trigger TBU0_TRANSPORTADORAS_VEICULOS for TRANSPORTADORAS_VEICULOS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TRANSPORTADORAS_VEICULOS', 3, 'TRANSPORTADORAS_VEICULOS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBI0_VEICULOS" for table "VEICULOS"  */
set term ^;

create trigger TBI0_VEICULOS for VEICULOS
  before insert as
begin
  if ((New.PK_VEICULOS is null) or (New.PK_VEICULOS = 0)) then
  begin
    select R_PK_VEICULOS from STP_GET_PK_VEICULOS(New.FK_VEICULOS_MARCAS, New.FK_VEICULOS_MODELOS)
      into New.PK_VEICULOS;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'VEICULOS', 2, 'VEICULOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_VEICULOS" for table "VEICULOS"  */
set term ^;

create trigger TBU0_VEICULOS for VEICULOS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'VEICULOS', 3, 'VEICULOS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_VEICULOS" for table "VEICULOS"  */
set term ^;

create trigger TAD0_VEICULOS for VEICULOS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'VEICULOS', 4, 'VEICULOS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_VEICULOS_IMAGENS" for table "VEICULOS_IMAGENS"  */
set term ^;

create trigger TAD0_VEICULOS_IMAGENS for VEICULOS_IMAGENS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'VEICULOS_IMAGENS', 4, 'VEICULOS_IMAGENS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBI0_VEICULOS_IMAGENS" for table "VEICULOS_IMAGENS"  */
set term ^;

create trigger TBI0_VEICULOS_IMAGENS for VEICULOS_IMAGENS
  before insert as
begin
  if ((New.PK_VEICULOS_IMAGENS is null) or (New.PK_VEICULOS_IMAGENS = 0)) then
  begin
    select R_PK_VEICULOS_IMAGENS from STP_GET_PK_VEICULOS_IMAGENS(New.FK_VEICULOS_MARCAS, New.FK_VEICULOS_MODELOS, New.FK_VEICULOS)
      into New.PK_VEICULOS_IMAGENS;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'VEICULOS_IMAGENS', 2, 'VEICULOS_IMAGENS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_VEICULOS_IMAGENS" for table "VEICULOS_IMAGENS"  */
set term ^;

create trigger TBU0_VEICULOS_IMAGENS for VEICULOS_IMAGENS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'VEICULOS_IMAGENS', 3, 'VEICULOS_IMAGENS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBI0_VEICULOS_MARCAS" for table "VEICULOS_MARCAS"  */
set term ^;

create trigger TBI0_VEICULOS_MARCAS for VEICULOS_MARCAS
  before insert as
begin
  if ((New.PK_VEICULOS_MARCAS is null) or (New.PK_VEICULOS_MARCAS = 0)) then
  begin
    select R_PK_VEICULOS_MARCAS from STP_GET_PK_VEICULOS_MARCAS
      into New.PK_VEICULOS_MARCAS;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'VEICULOS_MARCAS', 2, 'VEICULOS_MARCAS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_VEICULOS_MARCAS" for table "VEICULOS_MARCAS"  */
set term ^;

create trigger TBU0_VEICULOS_MARCAS for VEICULOS_MARCAS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'VEICULOS_MARCAS', 3, 'VEICULOS_MARCAS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_VEICULOS_MARCAS" for table "VEICULOS_MARCAS"  */
set term ^;

create trigger TAD0_VEICULOS_MARCAS for VEICULOS_MARCAS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'VEICULOS_MARCAS', 4, 'VEICULOS_MARCAS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_VEICULOS_MODELOS" for table "VEICULOS_MODELOS"  */
set term ^;

create trigger TAD0_VEICULOS_MODELOS for VEICULOS_MODELOS
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'VEICULOS_MODELOS', 4, 'VEICULOS_MODELOS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBI0_VEICULOS_MODELOS" for table "VEICULOS_MODELOS"  */
set term ^;

create trigger TBI0_VEICULOS_MODELOS for VEICULOS_MODELOS
  before insert as
begin
  if ((New.PK_VEICULOS_MODELOS is null) or (New.PK_VEICULOS_MODELOS = 0)) then
  begin
    select R_PK_VEICULOS_MODELOS from STP_GET_PK_VEICULOS_MODELOS(New.FK_VEICULOS_MARCAS)
      into New.PK_VEICULOS_MODELOS;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'VEICULOS_MODELOS', 2, 'VEICULOS_MODELOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_VEICULOS_MODELOS" for table "VEICULOS_MODELOS"  */
set term ^;

create trigger TBU0_VEICULOS_MODELOS for VEICULOS_MODELOS
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'VEICULOS_MODELOS', 3, 'VEICULOS_MODELOS', current_timestamp);
end^

set term ;^;


/*  Delete trigger "TAD0_VEICULOS_OBSERVACOES" for table "VEICULOS_OBSERVACOES"  */
set term ^;

create trigger TAD0_VEICULOS_OBSERVACOES for VEICULOS_OBSERVACOES
  after delete as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'VEICULOS_OBSERVACOES', 4, 'VEICULOS_OBSERVACOES', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TAI0_VEICULOS_OBSERVACOES" for table "VEICULOS_OBSERVACOES"  */
set term ^;

create trigger TAI0_VEICULOS_OBSERVACOES for VEICULOS_OBSERVACOES
  after insert as
begin
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'VEICULOS_OBSERVACOES', 2, 'VEICULOS_OBSERVACOES', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_VEICULOS_OBSERVACOES" for table "VEICULOS_OBSERVACOES"  */
set term ^;

create trigger TBU0_VEICULOS_OBSERVACOES for VEICULOS_OBSERVACOES
  before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'VEICULOS_OBSERVACOES', 3, 'VEICULOS_OBSERVACOES', current_timestamp);
end^

set term ;^;

