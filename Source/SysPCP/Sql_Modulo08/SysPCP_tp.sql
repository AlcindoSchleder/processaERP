/*==============================================================*/
/* Database name:  PROCESSA                                     */
/* DBMS name:      Friebird15x                                  */
/* Created on:     8/9/2006 08:30:28                            */
/*==============================================================*/



set term ^;

create procedure STP_GET_INSUMOS_FICHA (
  P_FK_PRODUTOS      integer
)
returns (
  R_PK_FASES_PRODUCAO integer,
  R_PK_OPERACOES      integer,
  R_DSC_FASE          varchar(30),
  R_DSC_OPE           varchar(30),
  R_SEQ_OPE           smallint,
  R_ALT_MAX           numeric(09, 04),
  R_LARG_MAX          numeric(09, 04),
  R_PROF_MAX          numeric(09, 04),
  R_ALT_MIN           numeric(09, 04),
  R_LARG_MIN          numeric(09, 04),
  R_PROF_MIN          numeric(09, 04),
  R_TEMPO_MEDIO       numeric(09, 04),
  R_QTD_DET           numeric(09, 04),
  R_PERC_PERDA        numeric(09, 04),
  R_DSC_DET           varchar(50)
)
as
  declare variable PkTipoFasesProducao smallint;
  declare variable PkTipoOperacoes     smallint;
  declare variable FkTipoDetalhe       integer;
  declare variable FkProdutosPecas     integer;
  declare variable FlagTDet            smallint;
begin
  for select Tfs.PK_TIPO_FASES_PRODUCAO, Tfs.DSC_FASE, Fas.FK_PRODUTOS_PECAS,  
             Fas.PK_FASES_PRODUCAO, Top.PK_TIPO_OPERACOES, Top.DSC_OPE, 
             Ope.PK_OPERACOES, Ope.SEQ_OPE, Ope.ALT_MAX, Ope.LARG_MAX, 
             Ope.PROF_MAX, Ope.ALT_MIN, Ope.LARG_MIN, Ope.PROF_MIN, 
             Ope.TEMPO_MEDIO,  Odt.FK_TIPO_DETALHE, Odt.FLAG_TDET, Odt.QTD_DET,
             Odt.PERC_PERDA
        from FASES_PRODUCAO Fas
        left outer join TIPO_FASES_PRODUCAO Tfs
          on Tfs.PK_TIPO_FASES_PRODUCAO  = Fas.FK_TIPO_FASES_PRODUCAO
        left outer join OPERACOES           Ope
          on Ope.FK_PRODUTOS_PECAS       = Fas.FK_PRODUTOS_PECAS
         and Ope.FK_FASES_PRODUCAO       = Fas.PK_FASES_PRODUCAO
        left outer join TIPO_OPERACOES      Top
          on Top.PK_TIPO_OPERACOES       = Ope.FK_TIPO_OPERACOES
        left outer join OPERACOES_DETALHES  Odt
          on Odt.FK_PRODUTOS_PECAS       = Ope.FK_PRODUTOS_PECAS
         and Odt.FK_FASES_PRODUCAO       = Ope.FK_FASES_PRODUCAO
         and Odt.FK_OPERACOES            = Ope.PK_OPERACOES
       where Fas.FK_PRODUTOS_PECAS       = :P_FK_PRODUTOS
       order by Fas.SEQ_FASE, Ope.SEQ_OPE
        into :PkTipoFasesProducao, :R_DSC_FASE, :FkProdutosPecas,
             :R_PK_FASES_PRODUCAO, :PkTipoOperacoes, :R_DSC_OPE, 
             :R_PK_OPERACOES, :R_SEQ_OPE, :R_ALT_MAX, :R_LARG_MAX, 
             :R_PROF_MAX, :R_ALT_MIN, :R_LARG_MIN, :R_PROF_MIN, 
             :R_TEMPO_MEDIO, :FkTipoDetalhe, :FlagTDet, :R_QTD_DET, 
             :R_PERC_PERDA do
  begin
    /* Tipo de Detalhe (FlagTdet)
       0 ==> Insumos
       1 ==> Servicos
       2 ==> Tipo de Acabamento
    */
    if ((FkTipoDetalhe is not null) or (FkTipoDetalhe > 0)) then
    begin
      if (FlagTDet in (0, 1)) then
        select DSC_PROD from PRODUTOS
         where PK_PRODUTOS = :FkTipoDetalhe
          into :R_DSC_DET;
      if (FlagTDet = 2) then
         select DSC_ACABM
          from TIPO_ACABAMENTOS
         where PK_TIPO_ACABAMENTOS = :FkTipoDetalhe
         into :R_DSC_DET;
    end
    else
      R_DSC_DET = '';
    suspend;
  end
end^

set term ;^;

grant EXECUTE on procedure STP_GET_INSUMOS_FICHA to PUBLIC;


set term ^;

create procedure STP_GET_KC_TO_CARGAS_PRODUCAO (
  P_FK_EMPRESAS integer
)
returns (
  R_PK_CARGAS_PRODUCAO smallint
)
as
begin
  R_PK_CARGAS_PRODUCAO = -1;
  if ((P_FK_EMPRESAS is not null) or (P_FK_EMPRESAS > 0)) then 
  begin
    select KC_CARGAS_PRODUCAO
      from MOD_PCP_KEYS
     where FK_EMPRESAS = :P_FK_EMPRESAS
      into :R_PK_CARGAS_PRODUCAO;
    if ((R_PK_CARGAS_PRODUCAO is null) or (R_PK_CARGAS_PRODUCAO = -1)) then
    begin
      insert into MOD_PCP_KEYS
        (FK_EMPRESAS, KC_CARGAS_PRODUCAO)
      values
        (:P_FK_EMPRESAS, 0);
      R_PK_CARGAS_PRODUCAO = 0;
    end
    R_PK_CARGAS_PRODUCAO = R_PK_CARGAS_PRODUCAO + 1;
    update MOD_PCP_KEYS set
           KC_CARGAS_PRODUCAO = :R_PK_CARGAS_PRODUCAO
     where FK_EMPRESAS = :P_FK_EMPRESAS;
  end
  suspend;
end ^

set term ;^;

grant EXECUTE on procedure STP_GET_KC_TO_CARGAS_PRODUCAO to PUBLIC;


set term ^;

create procedure STP_HIERARQUIA_PRODUTO (
    P_FK_PRODUTOS      integer,
    P_LEVEL            integer
)
returns (
    R_CURRLEVEL             integer,
    R_FK_PRODUTOS_PECAS     integer,
    R_FK_PRODUTOS_PECAS_MNT integer,
    R_QTD_PEC               smallint,
    R_QTD_GER               smallint,
    R_QTD_CALC              smallint,
    R_COD_REF               varchar(20),
    R_DSC_PEC               varchar(50),
    R_IMG_PEC               blob sub_type 0 segment size 80,
    R_OBS_PEC               blob sub_type 1 segment size 80,
    R_FLAG_TIMG             integer,
    R_MOT_NVER              varchar(50),
    R_ALT_PEC               numeric(9, 04),
    R_LARG_PEC              numeric(9, 04),
    R_PROF_PEC              numeric(9, 04)
)
as
  declare variable Level2         integer;
  declare variable Level3         integer;
  declare variable FkPecas        integer;
begin
  if (P_LEVEL is null) then P_LEVEL = 0;
  R_CURRLEVEL = P_LEVEL;
  for select Pcm.FK_PRODUTOS_PECAS, Pcm.FK_PRODUTOS_PECAS_MNT,
             Pcm.QTD_PEC, Pcm.QTD_GER, Prd.DSC_PROD, Pcd.PK_PRODUTOS_CODIGOS, 
             Pim.IMG_PROD, Pim.FLAG_TIMG, Pcr.CRT_PROD, Ppc.MOT_NVER,
             Ppc.ALT_PEC, Ppc.LARG_PEC, Ppc.PROF_PEC
        from PECAS_COMPONENTES Pcm
        join PRODUTOS_PECAS Ppc
          on Ppc.FK_PRODUTOS        = Pcm.FK_PRODUTOS_PECAS_MNT
        join PRODUTOS Prd
          on Prd.PK_PRODUTOS        = Ppc.FK_PRODUTOS
        join PRODUTOS_CODIGOS Pcd
          on Pcd.FK_PRODUTOS        = Prd.PK_PRODUTOS
         and Pcd.FLAG_TCODE         = 0 
        left outer join PRODUTOS_IMAGENS Pim
          on Pim.FK_PRODUTOS        = Prd.PK_PRODUTOS
        left outer join PRODUTOS_CARACTERISTICAS Pcr
          on Pcr.FK_PRODUTOS        = Prd.PK_PRODUTOS
       where Pcm.FK_PRODUTOS_PECAS  = :P_FK_PRODUTOS
         and Pcm.FK_PRODUTOS_PECAS <> Pcm.FK_PRODUTOS_PECAS_MNT
       into :R_FK_PRODUTOS_PECAS, :R_FK_PRODUTOS_PECAS_MNT,
            :R_QTD_PEC, :R_QTD_GER, :R_DSC_PEC, :R_COD_REF, 
            :R_IMG_PEC, :R_FLAG_TIMG, :R_OBS_PEC, :R_MOT_NVER, 
            :R_ALT_PEC, :R_LARG_PEC, :R_PROF_PEC do
  begin
    R_CURRLEVEL = P_LEVEL;    
    R_QTD_CALC  = R_QTD_PEC;
    suspend;
    Level2         = P_LEVEL + 1;
    FkPecas        = R_FK_PRODUTOS_PECAS_MNT;
    for select R_CURRLEVEL, R_FK_PRODUTOS_PECAS, R_FK_PRODUTOS_PECAS_MNT, 
               R_QTD_PEC, R_QTD_GER, R_COD_REF, R_DSC_PEC, R_IMG_PEC, R_FLAG_TIMG,
               R_OBS_PEC, R_MOT_NVER, R_ALT_PEC, R_LARG_PEC, R_PROF_PEC
          from STP_HIERARQUIA_PRODUTO(:FkPecas, :Level2)
          into :Level3, :R_FK_PRODUTOS_PECAS, :R_FK_PRODUTOS_PECAS_MNT,
               :R_QTD_PEC, :R_QTD_GER, :R_COD_REF, :R_DSC_PEC, :R_IMG_PEC, 
               :R_FLAG_TIMG, :R_OBS_PEC, :R_MOT_NVER, :R_ALT_PEC, :R_LARG_PEC, 
               :R_PROF_PEC do
    begin
      R_CURRLEVEL = Level3; 
      suspend;
    end
  end
end ^

set term ;^;

grant EXECUTE on procedure STP_HIERARQUIA_PRODUTO to PUBLIC;


set term ^;

create procedure STP_HIERARQUIA_REFERENCIA (
    P_QTD_PEC integer,
    P_COD_REF varchar(20),
    P_MAJ_VER integer,
    P_MIN_VER integer
)
returns (
    R_CURRLEVEL             integer,
    R_FK_PRODUTOS_PECAS     integer,
    R_FK_PRODUTOS_PECAS_MNT integer,
    R_QTD_PEC               integer,
    R_QTD_CALC              integer,
    R_QTD_GER               integer,
    R_COD_REF               varchar(20),
    R_DSC_PEC               varchar(50),
    R_IMG_PEC               blob sub_type 0 segment size 80,
    R_OBS_PEC               blob sub_type 1 segment size 80,
    R_FLAG_TIMG             integer,
    R_MOT_NVER              varchar(50),
    R_ALT_PEC               numeric(9, 04),
    R_LARG_PEC              numeric(9, 04),
    R_PROF_PEC              numeric(9, 04)
)
as
  declare variable FkPecas         integer;
  declare variable QtdTotTemp      double precision;
  declare variable QtdGerTemp      double precision;
  declare variable QtdTemp         double precision;
  declare variable FkTmpHierarquia integer;
  declare variable ParentLevel     integer;
  declare variable QtdPai          double precision;
begin
  FkPecas        = null;
  if ((P_MAJ_VER < 1) or (P_MAJ_VER is null)  or
     (P_MIN_VER < 0)  or (P_MIN_VER is null)) then
  begin
    select Pcd.FK_PRODUTOS
      from PRODUTOS_CODIGOS Pcd, PRODUTOS Prd
     where Pcd.PK_PRODUTOS_CODIGOS = :P_COD_REF
       and Pcd.FLAG_TCODE          = 0
       and Prd.Flag_Atv = 1
      into :FkPecas;
    if (FkPecas is null) then
    begin
      R_CURRLEVEL = -1; /* Peca nao encontrada    */
      suspend;
      exit;
    end
  end
  FkTmpHierarquia = Gen_Id(TMP_HIERARQUIA_REFERENCIA, 1);
  if ((P_QTD_PEC is null) or (P_QTD_PEC < 1)) then
    P_QTD_PEC = 1;
  R_CURRLEVEL = 0;
  for select Pcm.FK_PRODUTOS_PECAS, Pcm.FK_PRODUTOS_PECAS_MNT,
             Pcm.QTD_PEC, Prd.DSC_PROD, Pcd.PK_PRODUTOS_CODIGOS, 
             Pim.IMG_PROD, Pim.FLAG_TIMG, Pcr.CRT_PROD, Ppc.MOT_NVER,
             Ppc.ALT_PEC, Ppc.LARG_PEC, Ppc.PROF_PEC
        from PECAS_COMPONENTES Pcm
        join PRODUTOS_PECAS Ppc
          on Ppc.FK_PRODUTOS           = Pcm.FK_PRODUTOS_PECAS_MNT
        join PRODUTOS Prd
          on Prd.PK_PRODUTOS           = Ppc.FK_PRODUTOS
        join PRODUTOS_CODIGOS Pcd
          on Pcd.FK_PRODUTOS           = Prd.PK_PRODUTOS
         and Pcd.FLAG_TCODE            = 0 
        left outer join PRODUTOS_IMAGENS Pim
          on Pim.FK_PRODUTOS           = Prd.PK_PRODUTOS
        left outer join PRODUTOS_CARACTERISTICAS Pcr
          on Pcr.FK_PRODUTOS           = Prd.PK_PRODUTOS
       where Pcm.FK_PRODUTOS_PECAS     = :FkPecas
         and Pcm.FK_PRODUTOS_PECAS_MNT = Pcm.FK_PRODUTOS_PECAS
       into :R_FK_PRODUTOS_PECAS, :R_FK_PRODUTOS_PECAS_MNT,
            :R_QTD_PEC, :R_DSC_PEC, :R_COD_REF, :R_IMG_PEC, 
            :R_FLAG_TIMG, :R_OBS_PEC, :R_MOT_NVER, 
            :R_ALT_PEC, :R_LARG_PEC, :R_PROF_PEC do
  if (R_QTD_GER is null) then
    R_QTD_GER = R_QTD_PEC;
  if ((R_QTD_PEC is null) or (R_QTD_PEC = 0)) then
    R_QTD_PEC = 1;
  R_QTD_CALC = R_QTD_PEC * P_QTD_PEC;
  QtdTemp = Cast(R_QTD_CALC as double precision);                                     /* JOP */
  delete from TMP_HIERARQUIA_REFERENCIA
   where PK_TMP_HIERARQUIA_REFERENCIA = :FkTmpHierarquia 
     and HLEVEL                       = :R_CURRLEVEL;     /* JOP */
  insert into TMP_HIERARQUIA_REFERENCIA
    (PK_TMP_HIERARQUIA_REFERENCIA, HLEVEL, QTD)           /* JOP */
  values
    (:FkTmpHierarquia, :R_CURRLEVEL, :QtdTemp);           /* JOP */
  suspend;
  R_CURRLEVEL = R_CURRLEVEL + 1;
  for select R_CURRLEVEL, R_FK_PRODUTOS_PECAS, R_FK_PRODUTOS_PECAS_MNT,
             R_QTD_PEC, R_QTD_GER, R_QTD_CALC, R_COD_REF, R_DSC_PEC, 
             R_IMG_PEC, R_FLAG_TIMG, R_OBS_PEC, R_MOT_NVER, R_ALT_PEC, 
             R_LARG_PEC, R_PROF_PEC
        from STP_HIERARQUIA_PRODUTO(:FkPecas, :R_CURRLEVEL)
        into :R_CURRLEVEL, :R_FK_PRODUTOS_PECAS, :R_FK_PRODUTOS_PECAS_MNT, 
             :R_QTD_PEC, :R_QTD_GER, :R_QTD_CALC, :R_COD_REF, :R_DSC_PEC, 
             :R_IMG_PEC, :R_FLAG_TIMG, :R_OBS_PEC, :R_MOT_NVER, :R_ALT_PEC, 
             :R_LARG_PEC, :R_PROF_PEC do
  begin
    if ((R_QTD_GER is null) or (R_QTD_GER = 0)) then
      R_QTD_GER = 1;
    ParentLevel = R_CURRLEVEL - 1;                                  /* JOP */
    select QTD 
      from TMP_HIERARQUIA_REFERENCIA 
     where PK_TMP_HIERARQUIA_REFERENCIA = :FkTmpHierarquia 
       and HLEVEL                       = :ParentLevel              /* JOP */
      into :QtdPai;                                                 /* JOP */
    if ((QtdPai is null) or (QtdPai <= 0)) then QtdPai = 1;         /* JOP */
    if (R_CURRLEVEL > 0) then QtdPai = QtdPai * R_QTD_PEC;          /* JOP */
    QtdTotTemp = Cast(QtdPai as double precision);                  /* JOP */
    QtdGerTemp = Cast(R_QTD_GER as double precision);               /* JOP */
    QtdTemp    = Cast(QtdTotTemp / QtdGerTemp as double precision); /* JOP */
    R_QTD_CALC = Cast(QtdTemp as Integer);                          /* JOP */
    delete from TMP_HIERARQUIA_REFERENCIA 
     where PK_TMP_HIERARQUIA_REFERENCIA = :FkTmpHierarquia 
     and   HLEVEL = :R_CURRLEVEL;                                   /* JOP */
    insert into TMP_HIERARQUIA_REFERENCIA
      (PK_TMP_HIERARQUIA_REFERENCIA, HLEVEL, QTD)                      /* JOP */
    values
      (:FkTmpHierarquia, :R_CURRLEVEL, :QtdTemp);                   /* JOP */
    suspend;
  end
  delete from TMP_HIERARQUIA_REFERENCIA 
   where PK_TMP_HIERARQUIA_REFERENCIA = :FkTmpHierarquia;           /* JOP */
end ^

set term ;^;

grant EXECUTE on procedure STP_HIERARQUIA_REFERENCIA to PUBLIC;


/*  Insert trigger "TBIG_CARGAS_PRODUCAO" for table "CARGAS_PRODUCAO"  */
set term ^;

create trigger TBIG_CARGAS_PRODUCAO for CARGAS_PRODUCAO
before insert as
begin
  if ((New.PK_CARGAS_PRODUCAO is null) or (New.PK_CARGAS_PRODUCAO = 0)) then
  begin
    select R_PK_CARGAS_PRODUCAO 
      from STP_GET_KC_TO_CARGAS_PRODUCAO(New.FK_EMPRESAS)
      into New.PK_CARGAS_PRODUCAO;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
end^

set term ;^;


/*  Update trigger "TBU0_CARGAS_PRODUCAO" for table "CARGAS_PRODUCAO"  */
set term ^;

create trigger TBU0_CARGAS_PRODUCAO for CARGAS_PRODUCAO
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'CARGAS_PRODUCAO', 3, 'CARGAS_PRODUCAO', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_CARGAS_REGIOES" for table "CARGAS_REGIOES"  */
set term ^;

create trigger TBIG_CARGAS_REGIOES for CARGAS_REGIOES
before insert as
begin
  if ((New.PK_CARGAS_REGIOES is null) or (New.PK_CARGAS_REGIOES = 0)) then
    New.PK_CARGAS_REGIOES = Gen_Id(CARGAS_REGIOES, 1);
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'CARGAS_REGIOES', 2, 'CARGAS_REGIOES', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_CARGAS_REGIOES" for table "CARGAS_REGIOES"  */
set term ^;

create trigger TBU0_CARGAS_REGIOES for CARGAS_REGIOES
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'CARGAS_REGIOES', 3, 'CARGAS_REGIOES', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_ORDENS_ALOCACAO_FERRAMENTA" for table "ORDENS_ALOCACAO_FERRAMENTAS"  */
set term ^;

create trigger TBU0_ORDENS_ALOCACAO_FERRAMENTA for ORDENS_ALOCACAO_FERRAMENTAS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'ORDENS_ALOCACAO_FERRAMENTAS', 3, 'ORDENS_ALOCACAO_FERRAMENTAS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_ORDENS_ALOCACAO_MAQUINA" for table "ORDENS_ALOCACAO_MAQUINAS"  */
set term ^;

create trigger TBU0_ORDENS_ALOCACAO_MAQUINA for ORDENS_ALOCACAO_MAQUINAS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'ORDENS_ALOCACAO_MAQUINAS', 3, 'ORDENS_ALOCACAO_MAQUINAS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_ORDENS_HISTORICOS" for table "ORDENS_HISTORICOS"  */
set term ^;

create trigger TBIG_ORDENS_HISTORICOS for ORDENS_HISTORICOS
before insert as
  declare variable MaxValue integer;
begin
  if ((New.PK_ORDENS_HISTORICOS is null) or (New.PK_ORDENS_HISTORICOS = 0)) then
  begin
    select Max(PK_ORDENS_HISTORICOS)
      from ORDENS_HISTORICOS
     where PK_ORDENS_HISTORICOS = New.PK_ORDENS_HISTORICOS
      into :MaxValue;
    if (MaxValue is null) then
      MaxValue   = 0;
    New.PK_ORDENS_HISTORICOS = MaxValue + 1;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
end^

set term ;^;


/*  Update trigger "TBU0_ORDENS_HISTORICOS" for table "ORDENS_HISTORICOS"  */
set term ^;

create trigger TBU0_ORDENS_HISTORICOS for ORDENS_HISTORICOS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'ORDENS_HISTORICOS', 3, 'ORDENS_HISTORICOS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_ORDENS_OPERACOES" for table "ORDENS_OPERACOES"  */
set term ^;

create trigger TBIG_ORDENS_OPERACOES for ORDENS_OPERACOES
before insert as
begin
  if ((New.PK_ORDENS_OPERACOES is null) or (New.PK_ORDENS_OPERACOES = 0)) then
    New.PK_ORDENS_OPERACOES = Gen_Id(ORDENS_OPERACOES, 1);
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'ORDENS_OPERACOES', 2, 'ORDENS_OPERACOES', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_ORDENS_OPERACOES" for table "ORDENS_OPERACOES"  */
set term ^;

create trigger TBU0_ORDENS_OPERACOES for ORDENS_OPERACOES
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'ORDENS_OPERACOES', 3, 'ORDENS_OPERACOES', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_ORDENS_OPER_TERCERIZADA" for table "ORDENS_OPER_TERCERIZADA"  */
set term ^;

create trigger TBU0_ORDENS_OPER_TERCERIZADA for ORDENS_OPER_TERCERIZADA
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'ORDENS_OPER_TERCERIZADA', 3, 'ORDENS_OPER_TERCERIZADA', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_ORDENS_PECAS" for table "ORDENS_PECAS"  */
set term ^;

create trigger TBU0_ORDENS_PECAS for ORDENS_PECAS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'ORDENS_PECAS', 3, 'ORDENS_PECAS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_ORDENS_PEDIDOS" for table "ORDENS_PEDIDOS"  */
set term ^;

create trigger TBU0_ORDENS_PEDIDOS for ORDENS_PEDIDOS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'ORDENS_PEDIDOS', 3, 'ORDENS_PEDIDOS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_ORDENS_PRODUCAO" for table "ORDENS_PRODUCAO"  */
set term ^;

create trigger TBIG_ORDENS_PRODUCAO for ORDENS_PRODUCAO
before insert as
  declare variable MaxValue integer;
begin
  if ((New.PK_ORDENS_PRODUCAO is null) or (New.PK_ORDENS_PRODUCAO = 0)) then
  begin
    select Max(PK_ORDENS_PRODUCAO) 
      from ORDENS_PRODUCAO
     where FK_EMPRESAS        = New.FK_EMPRESAS
       and FK_TIPO_DOCUMENTOS = New.FK_TIPO_DOCUMENTOS
      into :MaxValue;
    if (MaxValue is null) then
      MaxValue   = 0;
    MaxValue = MaxValue + 1;
    New.PK_ORDENS_PRODUCAO = MaxValue;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
end^

set term ;^;


/*  Update trigger "TBU0_ORDENS_PRODUCAO" for table "ORDENS_PRODUCAO"  */
set term ^;

create trigger TBU0_ORDENS_PRODUCAO for ORDENS_PRODUCAO
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'ORDENS_PRODUCAO', 3, 'ORDENS_PRODUCAO', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_ORDENS_TIPO_STATUS" for table "ORDENS_TIPO_STATUS"  */
set term ^;

create trigger TBIG_ORDENS_TIPO_STATUS for ORDENS_TIPO_STATUS
before insert as
begin
  if ((New.PK_ORDENS_TIPO_STATUS is null) or (New.PK_ORDENS_TIPO_STATUS = 0)) then
    New.PK_ORDENS_TIPO_STATUS = Gen_Id(ORDENS_TIPO_STATUS, 1);
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'ORDENS_TIPO_STATUS', 2, 'ORDENS_TIPO_STATUS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_ORDENS_TIPO_STATUS" for table "ORDENS_TIPO_STATUS"  */
set term ^;

create trigger TBU0_ORDENS_TIPO_STATUS for ORDENS_TIPO_STATUS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'ORDENS_TIPO_STATUS', 3, 'ORDENS_TIPO_STATUS', current_timestamp);
end^

set term ;^;

