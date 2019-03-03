/*==============================================================*/
/* Database name:  PROCESSA                                     */
/* DBMS name:      Friebird15x                                  */
/* Created on:     8/9/2006 08:09:28                            */
/*==============================================================*/



set term ^;

create procedure STP_COPY_ACABAMENTO_STRUCT (
  FK_EMPRESAS      Integer, 
  FK_PRODUTOS_FROM Integer, 
  FK_PRODUTOS_TO   Integer
)
RETURNS (
  TOTAL_COMPONENTES_INCLUIDOS integer, 
  TOTAL_ACABAMENTOS_INCLUIDOS integer, 
  TOTAL_REFERENCIAS_INCLUIDAS integer
  )
AS
  declare variable Last_Fk_Tipo_Componentes integer;
  declare variable Last_Fk_Tipo_Acabamentos integer;
  declare variable Last_Fk_Tipo_Referencias integer;
  declare variable Fk_Tipo_Componentes      integer;
  declare variable Qtd_Comp                 float;
  declare variable Fk_Tipo_Acabamentos      integer;
  declare variable Flag_TAcbm               integer;
  declare variable Qtd_Pdr                  float;
  declare variable Qtd_Pers                 float;
  declare variable Fk_Tipo_Referencias      integer;
  declare variable Total_Componentes        integer;
begin
  select Count(*) 
    from COMPONENTES 
   where FK_PRODUTOS = :fk_produtos_to 
    into :total_componentes;
  if(total_componentes > 0) then
  begin
    total_componentes_incluidos = -1;
    total_acabamentos_incluidos = -1;
    total_referencias_incluidas = -1;
    suspend;
    exit;
  end
  last_fk_tipo_componentes    = -1;
  last_fk_tipo_acabamentos    = -1;
  last_fk_tipo_referencias    = -1;    
  total_componentes_incluidos = 0;
  total_acabamentos_incluidos = 0;
  total_referencias_incluidas = 0;
  for select c.fk_tipo_componentes, c.qtd_comp, a.fk_tipo_acabamentos, 
             a.flag_tacbm, a.qtd_pdr, a.qtd_pers, r.fk_tipo_referencias
        from componentes c 
        left outer join acabamentos a 
        left outer join referencias r 
          on ((r.fk_empresas=:fk_empresas) 
         and (r.fk_acabamentos=a.fk_tipo_acabamentos)
         and (r.fk_componentes=a.fk_componentes)
         and (r.fk_produtos=a.fk_produtos))
          on ((a.fk_produtos=c.fk_produtos)
         and (a.fk_componentes=c.fk_tipo_componentes))
       where c.fk_produtos=:fk_produtos_from
       order by c.fk_tipo_componentes, c.qtd_comp, a.fk_tipo_acabamentos, 
                a.flag_tacbm, a.qtd_pdr, a.qtd_pers, r.fk_tipo_referencias
        into :fk_tipo_componentes, :qtd_comp, :fk_tipo_acabamentos, 
             :flag_tacbm, :qtd_pdr, :qtd_pers, :fk_tipo_referencias do
  begin
    if (fk_tipo_componentes <> last_fk_tipo_componentes) then
    begin
      last_fk_tipo_componentes = fk_tipo_componentes;      
      last_fk_tipo_acabamentos = -1;
      last_fk_tipo_referencias = -1;
      insert into componentes
        (fk_produtos, fk_tipo_componentes, qtd_comp)
      values
        (:fk_produtos_to, :fk_tipo_componentes, :qtd_comp);
      total_componentes_incluidos = total_componentes_incluidos + 1;
    end
    if ((fk_tipo_acabamentos is not null) and 
       (fk_tipo_acabamentos <> last_fk_tipo_acabamentos)) then
    begin
      last_fk_tipo_acabamentos = fk_tipo_acabamentos;
      last_fk_tipo_referencias = -1;
      insert into acabamentos
        (fk_produtos, fk_componentes, fk_tipo_acabamentos, flag_tacbm, 
         qtd_pdr, qtd_pers)
      values
        (:fk_produtos_to, :fk_tipo_componentes, :fk_tipo_acabamentos, :flag_tacbm, 
         :qtd_pdr, :qtd_pers);
      total_acabamentos_incluidos = total_acabamentos_incluidos + 1;
    end
    if ((fk_tipo_referencias is not null) and 
       (fk_tipo_referencias <> last_fk_tipo_referencias)) then
    begin
      last_fk_tipo_referencias = fk_tipo_referencias;
      last_fk_tipo_referencias = -1;
      insert into referencias
        (fk_empresas, fk_produtos, fk_componentes, fk_acabamentos, 
         fk_tipo_referencias)
      values
        (:fk_empresas, :fk_produtos_to, :fk_tipo_componentes, :fk_tipo_acabamentos, 
         :fk_tipo_referencias);
      total_referencias_incluidas = total_referencias_incluidas + 1;
    end
  end
  suspend;
end ^

set term  ;^;

grant EXECUTE on procedure STP_COPY_ACABAMENTO_STRUCT to PUBLIC;


set term ^;

create procedure STP_GET_CONF_COMPONENTS (
    P_FK_PRODUTOS         integer
)
returns (
    R_DSC_TCOMP           varchar(30),
    R_DSC_ACABM           varchar(30),
    R_PK_TIPO_COMPONENTES integer,
    R_PK_TIPO_ACABAMENTOS integer,
    R_QTD_REC             smallint,
    R_QTD_COMP            numeric(09, 04),
    R_QTD_PDR             numeric(09, 04),
    R_QTD_PERS            numeric(09, 04),
    R_TOT_INS_BXA         numeric(09, 04),
    R_TOT_INS_CLC         numeric(09, 04),
    R_FLAG_TDSC           smallint
)
as
begin
 /* select all components that are child of P_FK_TIPO_ACABAMENTOS */
  R_QTD_REC = 0;
  for select distinct Tcm.DSC_TCOMP, Tac.DSC_ACABM, Tac.FLAG_TDSC, 
             Tcm.PK_TIPO_COMPONENTES, Tac.PK_TIPO_ACABAMENTOS,
             Aca.QTD_PDR, Aca.QTD_PERS, Cmp.QTD_COMP
        from COMPONENTES Cmp, TIPO_COMPONENTES Tcm,
             ACABAMENTOS Aca, TIPO_ACABAMENTOS Tac
       where Cmp.FK_PRODUTOS         = :P_FK_PRODUTOS
         and Tcm.PK_TIPO_COMPONENTES = Cmp.FK_TIPO_COMPONENTES
         and Aca.FK_PRODUTOS         = Cmp.FK_PRODUTOS
         and Aca.FK_COMPONENTES      = Cmp.FK_TIPO_COMPONENTES
         and Tac.PK_TIPO_ACABAMENTOS = Aca.FK_TIPO_ACABAMENTOS
       order by Tcm.PK_TIPO_COMPONENTES, Tac.PK_TIPO_ACABAMENTOS
        into :R_DSC_TCOMP, :R_DSC_ACABM, :R_FLAG_TDSC, 
             :R_PK_TIPO_COMPONENTES, :R_PK_TIPO_ACABAMENTOS,
             :R_QTD_PDR, :R_QTD_PERS, :R_QTD_COMP do
  begin
 /* sum quantities of the R_PK_TIPO_ACABAMENTOS */
    select Sum(Aca.QTD_PDR * Cmp.QTD_COMP),
           Sum(Aca.QTD_PDR * Cmp.QTD_COMP)
      from ACABAMENTOS Aca, COMPONENTES Cmp
     where Cmp.FK_PRODUTOS         = :P_FK_PRODUTOS
       and Aca.FK_PRODUTOS         = Cmp.FK_PRODUTOS
       and Aca.FK_COMPONENTES      = Cmp.FK_TIPO_COMPONENTES
       and Aca.FK_TIPO_ACABAMENTOS = :R_PK_TIPO_ACABAMENTOS
      into :R_TOT_INS_BXA, :R_TOT_INS_CLC;
    if ((R_TOT_INS_BXA is null) or (R_TOT_INS_CLC is null)) then
    begin
      R_TOT_INS_BXA = 0;
      R_TOT_INS_CLC = 0;
    end
    R_QTD_REC = R_QTD_REC + 1;
    suspend;
  end
end ^

set term  ;^;

grant EXECUTE on procedure STP_GET_CONF_COMPONENTS to PUBLIC;


set term ^;

create procedure STP_INSERE_TP_REF_PRODUTOS (
    P_FK_EMPRESAS    integer,
    P_FK_PRODUTOS    integer,
    P_FK_ACABAMENTOS integer,
    P_FK_REFERENCIAS integer
)
as
  declare variable QtdRegs     integer;
  declare variable MediaCusto  double precision;
  declare variable PrecoSuges  double precision;
  declare variable PrecoAnt    double precision;
  declare variable MargemLucro float;
  declare variable QtdPadrao   float;
begin
  select MRG_LCR from PRODUTOS_MARGEM 
   where FK_EMPRESAS = :P_FK_EMPRESAS
     and FK_PRODUTOS = :P_FK_PRODUTOS
    into :MargemLucro;
  if ((MargemLucro is null) or (MargemLucro = 0)) then
    MargemLucro = 0.55;
    
  select Sum(Acb.QTD_PDR)
    from ACABAMENTOS Acb
   where Acb.FK_PRODUTOS = :P_FK_PRODUTOS
    into :QtdPadrao;
    
  select Avg(Pct.CUST_MED)
    from PRODUTOS_COMPRAS Pcm, PRODUTOS_CUSTOS Pct
   where Pcm.FK_PRODUTOS         = :P_FK_PRODUTOS
     and Pcm.FK_TIPO_ACABAMENTOS = :P_FK_ACABAMENTOS
     and Pcm.FK_TIPO_REFERENCIAS = :P_FK_REFERENCIAS
     and Pct.FK_EMPRESAS         = :P_FK_EMPRESAS
     and Pct.FK_PRODUTOS         = Pcm.FK_PRODUTOS
    into :MediaCusto;
    
  if (MediaCusto is null) then
    MediaCusto = 0;
  PrecoSuges = (MediaCusto / MargemLucro) * QtdPadrao;
  select Count(PRE_SJST), PRE_SJST 
    from TP_REF_PRODUTOS
   where FK_EMPRESAS         = :P_FK_EMPRESAS
     and FK_PRODUTOS         = :P_FK_PRODUTOS
     and FK_TIPO_ACABAMENTOS = :P_FK_ACABAMENTOS
     and FK_TIPO_REFERENCIAS = :P_FK_REFERENCIAS
   group by PRE_SJST
    into :QtdRegs, :PrecoAnt;
  if (QtdRegs is null) then
    QtdRegs = 0;
  if (QtdRegs = 0) then
    insert into TP_REF_PRODUTOS
      (FK_EMPRESAS, FK_PRODUTOS, FK_TIPO_ACABAMENTOS, FK_TIPO_REFERENCIAS, PRE_SJST)
    values
      (:P_FK_EMPRESAS, :P_FK_PRODUTOS, :P_FK_ACABAMENTOS, :P_FK_REFERENCIAS, :PrecoSuges);
  else
    if (PrecoAnt <> PrecoSuges) then
      update TP_REF_PRODUTOS set
        PRE_SJST = :PrecoSuges
      where FK_EMPRESAS         = :P_FK_EMPRESAS
        and FK_PRODUTOS         = :P_FK_PRODUTOS
        and FK_TIPO_ACABAMENTOS = :P_FK_ACABAMENTOS
        and FK_TIPO_REFERENCIAS = :P_FK_REFERENCIAS;
end ^

set term  ;^;

grant EXECUTE on procedure STP_INSERE_TP_REF_PRODUTOS to PUBLIC;


/*  Update trigger "TBU0_ACABAMENTOS" for table "ACABAMENTOS"  */
set term ^;

create trigger TBU0_ACABAMENTOS for ACABAMENTOS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'ACABAMENTOS', 3, 'ACABAMENTOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_ACABAMENTO_PRECOS" for table "ACABAMENTO_PRECOS"  */
set term ^;

create trigger TBU0_ACABAMENTO_PRECOS for ACABAMENTO_PRECOS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'ACABAMENTO_PRECOS', 3, 'ACABAMENTO_PRECOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_COMPONENTES" for table "COMPONENTES"  */
set term ^;

create trigger TBU0_COMPONENTES for COMPONENTES
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'COMPONENTES', 3, 'COMPONENTES', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TAU0_REFERENCIAS" for table "REFERENCIAS"  */
set term ^;

create trigger TAU0_REFERENCIAS for REFERENCIAS
  after update as
begin
  execute procedure STP_INSERE_TP_REF_PRODUTOS(New.FK_EMPRESAS, 
                                               New.FK_PRODUTOS, 
                                               New.FK_ACABAMENTOS, 
                                               New.FK_TIPO_REFERENCIAS);
end;^

set term ;^;


/*  Update trigger "TBU0_REFERENCIAS" for table "REFERENCIAS"  */
set term ^;

create trigger TBU0_REFERENCIAS for REFERENCIAS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'REFERENCIAS', 3, 'REFERENCIAS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TAI0_REFERENCIAS" for table "REFERENCIAS"  */
set term ^;

create trigger TAI0_REFERENCIAS for REFERENCIAS
  after insert as
begin
  execute procedure STP_INSERE_TP_REF_PRODUTOS(New.FK_EMPRESAS, 
                                               New.FK_PRODUTOS, 
                                               New.FK_ACABAMENTOS, 
                                               New.FK_TIPO_REFERENCIAS);
end;^

set term ;^;


/*  Insert trigger "TBIG_TIPO_ACABAMENTOS" for table "TIPO_ACABAMENTOS"  */
set term ^;

create trigger TBIG_TIPO_ACABAMENTOS for TIPO_ACABAMENTOS
before insert as
begin
  if ((New.PK_TIPO_ACABAMENTOS is null) or (New.PK_TIPO_ACABAMENTOS = 0)) then
    New.PK_TIPO_ACABAMENTOS = Gen_Id(TIPO_ACABAMENTOS, 1);
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_ACABAMENTOS', 2, 'TIPO_ACABAMENTOS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_TIPO_ACABAMENTOS" for table "TIPO_ACABAMENTOS"  */
set term ^;

create trigger TBU0_TIPO_ACABAMENTOS for TIPO_ACABAMENTOS
before update as
declare variable NumRows integer;
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
end;^

set term ;^;


/*  Insert trigger "TBIG_TIPO_COMPONENTES" for table "TIPO_COMPONENTES"  */
set term ^;

create trigger TBIG_TIPO_COMPONENTES for TIPO_COMPONENTES
before insert as
begin
  if ((New.PK_TIPO_COMPONENTES is null) or (New.PK_TIPO_COMPONENTES = 0)) then
    New.PK_TIPO_COMPONENTES = Gen_Id(TIPO_COMPONENTES, 1);
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_COMPONENTES', 2, 'TIPO_COMPONENTES', current_timestamp);
end^

set term ;^;

;


/*  Insert trigger "TBIG_TIPO_REFERENCIAS" for table "TIPO_REFERENCIAS"  */
set term ^;

create trigger TBIG_TIPO_REFERENCIAS for TIPO_REFERENCIAS
before insert as
  declare variable MaxValue integer;
begin
  Select Max(PK_TIPO_REFERENCIAS)
    from TIPO_REFERENCIAS
   where FK_TIPO_ACABAMENTOS = New.FK_TIPO_ACABAMENTOS
    into :MaxValue;
  if (MaxValue is null) then
    MaxValue   = 0;
  New.PK_TIPO_REFERENCIAS = MaxValue + 1;
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
end;^

set term ;^;


/*  Update trigger "TBU0_TIPO_REFERENCIAS" for table "TIPO_REFERENCIAS"  */
set term ^;

create trigger TBU0_TIPO_REFERENCIAS for TIPO_REFERENCIAS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_REFERENCIAS', 3, 'TIPO_REFERENCIAS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_TP_REF_PRODUTOS" for table "TP_REF_PRODUTOS"  */
set term ^;

create trigger TBU0_TP_REF_PRODUTOS for TP_REF_PRODUTOS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TP_REF_PRODUTOS', 3, 'TP_REF_PRODUTOS', current_timestamp);
end^

set term ;^;

