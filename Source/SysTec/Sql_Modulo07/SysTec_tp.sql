/*==============================================================*/
/* Database name:  PROCESSA                                     */
/* DBMS name:      Friebird15x                                  */
/* Created on:     8/9/2006 08:18:44                            */
/*==============================================================*/



set term ^;

create procedure STP_APECAS_IS_CHILD_OF (
  P_FK_PRODUTOS_PECAS     integer,
  P_FK_PRODUTOS_PECAS_MNT integer
)
returns (
  R_RESULT            integer
)
as
  declare variable tmpResult              integer;
  declare variable TotalChildren          integer;
  declare variable FkPecasMontagem        integer;
  declare variable FkFichaTecnicaMontagem integer;
begin
  if ((P_FK_PRODUTOS_PECAS < 1) or (P_FK_PRODUTOS_PECAS_MNT < 1) or
     ( P_FK_PRODUTOS_PECAS = P_FK_PRODUTOS_PECAS_MNT)) then
  begin
    R_RESULT = 0;
    suspend;
    exit;
  end
  else
  begin
    TotalChildren = 0;
    select count(*)
      from PECAS_COMPONENTES
     where FK_PRODUTOS_PECAS     = :P_FK_PRODUTOS_PECAS
       and FK_PRODUTOS_PECAS_MNT = :P_FK_PRODUTOS_PECAS_MNT
      into :TotalChildren;
    if ((TotalChildren is null) or (TotalChildren = 0)) then
    begin
      for select FK_PRODUTOS_PECAS_MNT
            from PECAS_COMPONENTES
           where FK_PRODUTOS_PECAS  = :P_FK_PRODUTOS_PECAS
             and FK_PRODUTOS_PECAS <> FK_PRODUTOS_PECAS_MNT
            into :FkPecasMontagem do
      begin
        if ((tmpResult is not null) and (tmpResult > 0)) then
        begin
          R_RESULT = tmpResult;
          suspend;
          exit;
        end
      end
      R_RESULT = 0;
      suspend;
      exit;
    end
    else
    begin
      R_RESULT = :P_FK_PRODUTOS_PECAS;
      suspend;
      exit;
    end
  end
end ^

set term  ;^;



grant EXECUTE on procedure STP_APECAS_IS_CHILD_OF to PUBLIC;


set term ^;

create procedure STP_CALC_MATERIALS_COST (
    P_FK_EMPRESAS     integer,
    P_FK_TIPO_DETALHE integer,
    P_FLAG_TDET       integer,
    P_FLAG_TCUSTO     smallint,
    P_FLAG_TACABM     smallint,
    P_QTD_DET         double precision
)
returns (
    R_COD_REF  varchar(20),
    R_DSC_DET  varchar(50),
    R_CUST_DET double precision
)
as
  declare variable CustMed      double precision;
  declare variable CustFinal    double precision;
  declare variable CustForn     double precision;
  declare variable CustReal     double precision;
  declare variable CustMedMax   double precision;
  declare variable CustFinalMax double precision;
  declare variable CustFornMax  double precision;
  declare variable CustRealMax  double precision;
  declare variable CustFinalMin double precision;
  declare variable CustFornMin  double precision;
  declare variable CustRealMin  double precision;
  declare variable CustMedMin   double precision;
  declare variable CustoCalc    double precision;
begin
/* Map of P_FlagTCusto
   0 ==>
   1 ==> CustMed;
   2 ==> CustReal;
   3 ==> CustFinal;
   4 ==> CustForn;
*/
  R_CUST_DET = 0;
  if ((P_FLAG_TDET < 0) or (P_FLAG_TDET > 2)) then exit;
  select Prd.DSC_PROD, Pcd.COD_REF, Prc.CUST_FINAL,
         Prc.CUST_FORN, Prc.CUST_REAL, Prc.CUST_MED
    from PRODUTOS Prd, PRODUTOS_CODIGOS Pcd, PRODUTOS_CUSTOS Prc
   where Prd.PK_PRODUTOS = :P_FK_TIPO_DETALHE
     and Prd.FLAG_ATV    = 0
     and Pcd.FK_PRODUTOS = Prd.PK_PRODUTOS
     and Pcd.FLAG_TCODE  = 0
     and Prc.FK_EMPRESAS = :P_FK_EMPRESAS
     and Prc.FK_PRODUTOS = :P_FK_TIPO_DETALHE
    into :R_DSC_DET, :R_COD_REF, :CustFinal,
         :CustForn, :CustReal, :CustMed;
  if (P_FLAG_TCUSTO = 0) then
    suspend;
  if (P_FLAG_TCUSTO = 1) then
    CustoCalc = CustMed;
  if (P_FLAG_TCUSTO = 2) then
    CustoCalc = CustReal;
  if (P_FLAG_TCUSTO = 3) then
    CustoCalc = CustFinal;
  if (P_FLAG_TCUSTO = 4) then
    CustoCalc = CustForn;
  if ((P_FLAG_TDET = 1) and (P_FLAG_TCUSTO > 0)) then
  begin
    R_Cod_Ref = 'All';
    select Min(Pct.CUST_FINAL), Avg(Pct.CUST_FINAL), Max(Pct.CUST_FINAL),
           Min(Pct.CUST_FORN) , Avg(Pct.CUST_FORN) , Max(Pct.CUST_FORN),
           Min(Pct.CUST_REAL) , Avg(Pct.CUST_REAL) , Max(Pct.CUST_REAL),
           Min(Pct.CUST_MED)  , Avg(Pct.CUST_MED)  , Max(Pct.CUST_MED)
      from PRODUTOS Prd, PRODUTOS_COMPRAS Pcm, PRODUTOS_CUSTOS Pct
     where Prd.PK_PRODUTOS         > 0
       and Prd.FLAG_ATV            = 0
       and Pcm.FK_PRODUTOS         = Prd.PK_PRODUTOS
       and Pcm.FK_TIPO_ACABAMENTOS = :P_FK_TIPO_DETALHE
       and Pct.FK_EMPRESAS         = :P_FK_EMPRESAS
       and Pct.FK_PRODUTOS         = Prd.PK_PRODUTOS
      into :CustFinalMin, :CustFinal, :CustFinalMax,
           :CustFornMin , :CustForn , :CustFornMax,
           :CustRealMin , :CustReal , :CustRealMax,
           :CustMedMin  , :CustMed  , :CustMedMax;
    select DSC_ACABM
      from TIPO_ACABAMENTOS
     where PK_TIPO_ACABAMENTOS = :P_FK_TIPO_DETALHE
      into :R_DSC_DET;
/*
0 ==> Menor Valor dos acabamentos do mesmo tipo
1 ==> Valor Médio dos acabamentos do mesmo tipo
2 ==> Maior Valor dos acabamentos do mesmo tipo
*/
    if (P_FLAG_TACABM = 0) then
    begin
      if (P_FLAG_TCUSTO = 1) then
        CustoCalc = CustMedMin;
      if (P_FLAG_TCUSTO = 2) then
        CustoCalc = CustRealMin;
      if (P_FLAG_TCUSTO = 3) then
        CustoCalc = CustFinalMin;
      if (P_FLAG_TCUSTO = 3) then
        CustoCalc = CustFornMin;
    end
    if (P_FLAG_TACABM = 1) then
    begin
      if (P_FLAG_TCUSTO = 1) then
        CustoCalc = CustMed;
      if (P_FLAG_TCUSTO = 2) then
        CustoCalc = CustReal;
      if (P_FLAG_TCUSTO = 3) then
        CustoCalc = CustFinal;
      if (P_FLAG_TCUSTO = 3) then
        CustoCalc = CustForn;
    end
    if (P_FLAG_TACABM = 0) then
    begin
      if (P_FLAG_TCUSTO = 1) then
        CustoCalc = CustMedMax;
      if (P_FLAG_TCUSTO = 2) then
        CustoCalc = CustRealMax;
      if (P_FLAG_TCUSTO = 3) then
        CustoCalc = CustFinalMax;
      if (P_FLAG_TCUSTO = 3) then
        CustoCalc = CustFornMax;
    end
  end
  R_CUST_DET = CustoCalc * P_QTD_DET;
  suspend;
end^

set term  ;^;

grant EXECUTE on procedure STP_CALC_MATERIALS_COST to PUBLIC;


set term ^;

create procedure STP_COPY_FICHA_TECNICA (
  P_FK_PRODUTOS_PECAS_FROM integer,
  P_FK_PRODUTOS_PECAS_TO   integer,
  P_MAJ_VER_TO             smallint,
  P_MIN_VER_TO             smallint
)
returns
(
  R_TOTAL_COMPONENTES_INCLUIDOS integer,
  R_TOTAL_FASES_INCLUIDAS       integer,
  R_TOTAL_OPERACOES             integer,
  R_TOTAL_PECAS                 integer,
  R_TOTAL_OPERACOES_DETALHES    integer,
  R_TOTAL_MAQUINAS              integer,
  R_TOTAL_FERRAMENTAS           integer
)
as
  declare variable FkPecasMontagem        integer;
  declare variable QtdPec                 float;
  declare variable FkTipoFasesProducao    integer;
  declare variable SeqFase                integer;
  declare variable FkFasesProducao        integer;
  declare variable PkFasesProducao        integer;
  declare variable fkOperacoes            integer;
  declare variable PkOperacoes            integer;
  declare variable FkTipoOperacoes        integer;
  declare variable SeqOpe                 integer;
  declare variable TempoMedio             float;
  declare variable SeqMont                integer;
  declare variable FkTipoDetalhe          integer;
  declare variable FlagTDet               integer;
  declare variable QtdDet                 float;
  declare variable FkMaquinas             integer;
  declare variable TmpStp                 float;
  declare variable TmpOper                float;
  declare variable FlagDef                integer;
  declare variable FkInsumos              integer;
  declare variable FkTipoDocumentos       integer;
  declare variable CodRef                 varchar(20);
  declare variable AltMax                 float;
  declare variable LargMax                float;
  declare variable ProfMax                float;
  declare variable AltMin                 float;
  declare variable LargMin                float;
  declare variable ProfMin                float;
  declare variable PercPerda              float;
  declare variable ThisPecaIsAChild       integer;
  declare variable FlagAtivDestino        integer;
  declare variable FlagOpDestino          integer;
  declare variable FkFichaTecnicaTemplate integer;
  declare variable FkFichaTecnicaDestino  integer;
  declare variable HasRecords             smallint;
begin
  R_TOTAL_COMPONENTES_INCLUIDOS = 0;
  R_TOTAL_FASES_INCLUIDAS       = 0;
  R_TOTAL_OPERACOES             = 0;
  R_TOTAL_PECAS                 = 0;
  R_TOTAL_MAQUINAS              = 0;
  R_TOTAL_FERRAMENTAS           = 0;
  select count(*) from PRODUTOS_PECAS
   where FK_PRODUTOS = :P_FK_PRODUTOS_PECAS_TO
    into :R_TOTAL_PECAS;
  if (R_TOTAL_PECAS < 1) then
  begin
    R_TOTAL_COMPONENTES_INCLUIDOS = -7; /* Peca Destino nao existe  */
    suspend;
    exit;
  end
  R_TOTAL_PECAS = 1;
  select count(*) from OPERACOES
   where FK_PRODUTOS_PECAS = :P_FK_PRODUTOS_PECAS_FROM
    into :R_TOTAL_OPERACOES;
  if (R_TOTAL_OPERACOES < 1) then
  begin
    R_TOTAL_COMPONENTES_INCLUIDOS = -6; /* Ficha Tecnica Origem Vazia ou peça de origem não existe */
    suspend;
    exit;
  end
  ThisPecaIsAChild = 0;
  select R_RESULT
    from STP_APECAS_IS_CHILD_OF(
         :P_FK_PRODUTOS_PECAS_FROM, :P_FK_PRODUTOS_PECAS_TO)
    into :ThisPecaIsAChild;
  if ((ThisPecaIsAChild is not null) and (ThisPecaIsAChild > 0)) then
  begin
    R_TOTAL_COMPONENTES_INCLUIDOS = -8; /* Peca Destino ja e filha da peca origem */
    suspend;
    exit;
  end
  FkFichaTecnicaTemplate = -1;
  select FK_PRODUTOS
    from PRODUTOS_PECAS
   where FK_PRODUTOS = :P_FK_PRODUTOS_PECAS_TO
    into :FkFichaTecnicaTemplate;
  if ((FkFichaTecnicaTemplate is null) or (FkFichaTecnicaTemplate < 1)) then
  begin
    FkFichaTecnicaDestino = -1;
    select Gen_Id(PRODUTOS, 1) from PARAMETROS_GLOBAIS
      into :P_FK_PRODUTOS_PECAS_TO;
    insert into PRODUTOS
      (PK_PRODUTOS, FK_PRODUTOS_GRUPOS, FK_UNIDADES,
       DSC_PROD, FLAG_ATV, FAT_CONV, QTD_UNI)
      select :P_FK_PRODUTOS_PECAS_TO, FK_PRODUTOS_GRUPOS,
             FK_UNIDADES, DSC_PROD, 1, 0.0, QTD_UNI
        from PRODUTOS
       where PK_PRODUTOS      = :P_FK_PRODUTOS_PECAS_FROM;
    insert into PRODUTOS_CODIGOS
      (FK_PRODUTOS, PK_PRODUTOS_CODIGOS, COD_REF, DSC_CODE,
       FLAG_TCODE, FLAG_TBARCODE)
      select :P_FK_PRODUTOS_PECAS_TO, PK_PRODUTOS_CODIGOS, COD_REF,
       'Referência', FLAG_TCODE, FLAG_TBARCODE
        from PRODUTOS_CODIGOS
       where FK_PRODUTOS = :P_FK_PRODUTOS_PECAS_FROM;
    select Count(*) from PRODUTOS_IMAGENS
     where FK_PRODUTOS = :P_FK_PRODUTOS_PECAS_FROM
      into HasRecords;
    if ((HasRecords is not null) or (HasRecords > 0)) then
    begin
      insert into PRODUTOS_IMAGENS
        (FK_PRODUTOS, IMG_PROD, FLAG_TIMG)
        select :P_FK_PRODUTOS_PECAS_TO, IMG_PROD, FLAG_TIMG
          from PRODUTOS_IMAGENS
         where FK_PRODUTOS = :P_FK_PRODUTOS_PECAS_FROM;
    end
    HasRecords = 0;
    select Count(*) from PRODUTOS_CARACTERISTICAS
     where FK_PRODUTOS = :P_FK_PRODUTOS_PECAS_FROM
      into HasRecords;
    if ((HasRecords is not null) or (HasRecords > 0)) then
    begin
      insert into PRODUTOS_CARACTERISTICAS
        (FK_PRODUTOS, CRT_PROD)
        select :P_FK_PRODUTOS_PECAS_TO, CRT_PROD
          from PRODUTOS_CARACTERISTICAS
         where FK_PRODUTOS = :P_FK_PRODUTOS_PECAS_FROM;
    end
    insert into PRODUTOS_PECAS
      (FK_PRODUTOS, MAJ_VER, MIN_VER, MOT_NVER, ALT_PEC,
       PROF_PEC, LARG_PEC, FLAG_TCOMP, FLAG_OP)
      select :P_FK_PRODUTOS_PECAS_TO, :P_MAJ_VER_TO, :P_MIN_VER_TO,
             'COPIA DE FICHA TECNICA', ALT_PEC,
             PROF_PEC, LARG_PEC, FLAG_TCOMP, FLAG_OP
        from PRODUTOS_PECAS
       where FK_PRODUTOS = :P_FK_PRODUTOS_PECAS_FROM;
  end
  else
  begin
    FlagAtivDestino = -1;
    FlagOpDestino   = -1;
    select Prd.FLAG_ATV, Ppc.FLAG_OP
      from PRODUTOS Prd, PRODUTOS_PECAS Ppc
     where Prd.PK_PRODUTOS = :P_FK_PRODUTOS_PECAS_TO
       and Ppc.FK_PRODUTOS = Prd.PK_PRODUTOS
      into :FlagAtivDestino, :FlagOpDestino;
    if ((FlagAtivDestino is not null) and (FlagAtivDestino = 1)) then
    begin
      R_TOTAL_COMPONENTES_INCLUIDOS = -11; /* Ficha Tecnica de Destino esta ativa */
      suspend;
    exit;
  end
  if ((FlagOpDestino is not null) and (FlagOpDestino = 1)) then
  begin
    R_TOTAL_COMPONENTES_INCLUIDOS = -12; /* Ficha Tecnica de Destino tem OP */
    suspend;
    exit;
  end
  delete from PECAS_FERRAMENTAS
   where FK_PRODUTOS_PECAS = :P_FK_PRODUTOS_PECAS_TO;
  delete from PECAS_MAQUINAS
   where FK_PRODUTOS_PECAS = :P_FK_PRODUTOS_PECAS_TO;
  delete from OPERACOES_DETALHES
   where FK_PRODUTOS_PECAS = :P_FK_PRODUTOS_PECAS_TO;
  delete from PECAS_COMPO_OPER
   where FK_PRODUTOS_PECAS = :P_FK_PRODUTOS_PECAS_TO;
  delete from OPERACOES
   where FK_PRODUTOS_PECAS = :P_FK_PRODUTOS_PECAS_TO;
  delete from FASES_PRODUCAO
   where FK_PRODUTOS_PECAS = :P_FK_PRODUTOS_PECAS_TO;
  delete from PECAS_COMPONENTES
   where FK_PRODUTOS_PECAS = :P_FK_PRODUTOS_PECAS_TO;
  update PRODUTOS_PECAS set
    MOT_NVER = 'COPIA DE FICHA TECNICA'
   where FK_PRODUTOS      = :P_FK_PRODUTOS_PECAS_TO;
  end
  select QTD_PEC from PECAS_COMPONENTES
   where FK_PRODUTOS_PECAS     = :P_FK_PRODUTOS_PECAS_FROM
     and FK_PRODUTOS_PECAS_MNT = FK_PRODUTOS_PECAS_MNT
    into :QtdPec;
  insert into PECAS_COMPONENTES
    (FK_PRODUTOS_PECAS, FK_PRODUTOS_PECAS_MNT, QTD_PEC)
  values
    (:P_FK_PRODUTOS_PECAS_TO, :P_FK_PRODUTOS_PECAS_TO, :QtdPec);
  R_TOTAL_COMPONENTES_INCLUIDOS = R_TOTAL_COMPONENTES_INCLUIDOS + 1;
  for select FK_PRODUTOS_PECAS_MNT, QTD_PEC
        from PECAS_COMPONENTES
       where FK_PRODUTOS_PECAS =  :P_FK_PRODUTOS_PECAS_FROM
         and FK_PRODUTOS_PECAS <> FK_PRODUTOS_PECAS_MNT
        into :FkPecasMontagem, :QtdPec do
  begin
    insert into PECAS_COMPONENTES
      (FK_PRODUTOS_PECAS, FK_PRODUTOS_PECAS_MNT, QTD_PEC)
    values
      (:P_FK_PRODUTOS_PECAS_TO, :FkPecasMontagem, :QtdPec);
    R_TOTAL_COMPONENTES_INCLUIDOS = R_TOTAL_COMPONENTES_INCLUIDOS + 1;
  end
  for select PK_FASES_PRODUCAO, FK_TIPO_FASES_PRODUCAO, SEQ_FASE
        from FASES_PRODUCAO
       where FK_PRODUTOS_PECAS = :P_FK_PRODUTOS_PECAS_FROM
        into :FkFasesProducao, :FkTipoFasesProducao, :SeqFase do
  begin
    insert into FASES_PRODUCAO
      (FK_PRODUTOS_PECAS, FK_TIPO_FASES_PRODUCAO, SEQ_FASE)
    values
      (:P_FK_PRODUTOS_PECAS_TO, :FkTipoFasesProducao, :SeqFase);
    select max(PK_FASES_PRODUCAO)
      from FASES_PRODUCAO
     where FK_PRODUTOS_PECAS = :P_FK_PRODUTOS_PECAS_TO
      into :PkFasesProducao;
    R_TOTAL_FASES_INCLUIDAS = R_TOTAL_FASES_INCLUIDAS + 1;
    for select PK_OPERACOES, FK_TIPO_OPERACOES, FK_TIPO_DOCUMENTOS, SEQ_OPE,
               COD_REF, ALT_MAX, LARG_MAX, PROF_MAX, ALT_MIN,
               LARG_MIN, PROF_MIN, TEMPO_MEDIO
          from OPERACOES
         where FK_PRODUTOS_PECAS = :P_FK_PRODUTOS_PECAS_FROM
           and FK_FASES_PRODUCAO = :FkFasesProducao
          into :fkOperacoes, :FkTipoOperacoes, :FkTipoDocumentos, :SeqOpe,
               :CodRef, :AltMax, :LargMax, :ProfMax, :AltMin,
               :LargMin, :ProfMin, :TempoMedio do
    begin
      insert into OPERACOES
        (FK_PRODUTOS_PECAS, FK_FASES_PRODUCAO, FK_TIPO_OPERACOES,
         FK_TIPO_DOCUMENTOS, SEQ_OPE, COD_REF, ALT_MAX, LARG_MAX,
         PROF_MAX, ALT_MIN, LARG_MIN, PROF_MIN, TEMPO_MEDIO)
      values
        (:P_FK_PRODUTOS_PECAS_TO, :PkFasesProducao, :FkTipoOperacoes,
         :FkTipoDocumentos, :SeqOpe, :CodRef, :AltMax, :LargMax,
         :ProfMax, :AltMin, :LargMin, :ProfMin, :TempoMedio);
      select max(PK_OPERACOES)
        from OPERACOES
       where FK_PRODUTOS_PECAS = :P_FK_PRODUTOS_PECAS_TO
         and FK_FASES_PRODUCAO = :PkFasesProducao
        into :PkOperacoes;
      R_TOTAL_OPERACOES = R_TOTAL_OPERACOES + 1;
      for select FK_PRODUTOS_PECAS_MNT, SEQ_MONT, PERC_PERDA
            from PECAS_COMPO_OPER
           where FK_PRODUTOS_PECAS = :P_FK_PRODUTOS_PECAS_FROM
             and FK_FASES_PRODUCAO = :FkFasesProducao
             and FK_OPERACOES      = :FkOperacoes
            into :FkPecasMontagem, :SeqMont, :PercPerda do
      begin
        insert into PECAS_COMPO_OPER
          (FK_PRODUTOS_PECAS, FK_FASES_PRODUCAO, FK_OPERACOES,
           FK_PRODUTOS_PECAS_MNT, SEQ_MONT, PERC_PERDA)
        values
          (:P_FK_PRODUTOS_PECAS_TO, :PkFasesProducao, :PkOperacoes,
           :FkPecasMontagem, :SeqMont, :PercPerda);
        R_TOTAL_PECAS = R_TOTAL_PECAS + 1;
      end
      for select FK_TIPO_DETALHE, FLAG_TDET, QTD_DET, PERC_PERDA
            from OPERACOES_DETALHES
           where FK_PRODUTOS_PECAS = :P_FK_PRODUTOS_PECAS_FROM
             and FK_FASES_PRODUCAO = :FkFasesProducao
             and FK_OPERACOES      = :fkOperacoes
            into :FkTipoDetalhe, :FlagTDet, :QtdDet, :PercPerda do
      begin
        insert into OPERACOES_DETALHES
          (FK_PRODUTOS_PECAS, FK_FASES_PRODUCAO, FK_TIPO_DETALHE,
           FK_OPERACOES, FLAG_TDET, QTD_DET, PERC_PERDA)
        values
          (:P_FK_PRODUTOS_PECAS_TO, :PkFasesProducao, :FkTipoDetalhe,
           :PkOperacoes, :FlagTDet, :QtdDet, :PercPerda);
        R_TOTAL_OPERACOES_DETALHES = R_TOTAL_OPERACOES_DETALHES + 1;
      end
      for select FK_PRODUTOS_MAQUINAS, TMP_STP, TMP_OPER, FLAG_DEF
            from PECAS_MAQUINAS
           where FK_PRODUTOS_PECAS = :P_FK_PRODUTOS_PECAS_FROM
             and FK_FASES_PRODUCAO = :FkFasesProducao
             and FK_OPERACOES      = :FkOperacoes
            into :FkMaquinas, :TmpStp, :TmpOper, :FlagDef do
      begin
        insert into PECAS_MAQUINAS
          (FK_PRODUTOS_PECAS, FK_FASES_PRODUCAO, FK_OPERACOES,
           FK_PRODUTOS_MAQUINAS, TMP_STP, TMP_OPER, FLAG_DEF)
        values
          (:P_FK_PRODUTOS_PECAS_TO, :PkFasesProducao, :PkOperacoes,
           :FkMaquinas, :TmpStp, :TmpOper, :FlagDef);
        R_TOTAL_MAQUINAS = R_TOTAL_MAQUINAS + 1;
      end
      for select FK_PRODUTOS_MAQUINAS, FK_PRODUTOS_COMPRAS
            from PECAS_FERRAMENTAS
           where FK_PRODUTOS_PECAS = :P_FK_PRODUTOS_PECAS_FROM
             and FK_FASES_PRODUCAO = :FkFasesProducao
             and FK_OPERACOES      = :fkOperacoes
            into :FkMaquinas, :FkInsumos do
      begin
        insert into PECAS_FERRAMENTAS
          (FK_PRODUTOS_PECAS, FK_FASES_PRODUCAO, FK_OPERACOES,
           FK_PRODUTOS_MAQUINAS, FK_PRODUTOS_COMPRAS)
        values
          (:P_FK_PRODUTOS_PECAS_TO, :PkFasesProducao, :PkOperacoes,
          :FkMaquinas, :FkInsumos);
        R_TOTAL_FERRAMENTAS = R_TOTAL_FERRAMENTAS + 1;
      end
    end
  end
  suspend;
end ^

set term  ;^;

grant EXECUTE on procedure STP_COPY_FICHA_TECNICA to PUBLIC;


set term ^;

create procedure STP_GET_DATA_COMPONENT (
  P_FK_EMPRESAS integer,
  P_FK_PRODUTOS integer
)
returns (
  R_FK_PRODUTOS integer,
  R_DSC_PROD    varchar(50),
  R_DSC_DET     varchar(50),
  R_COD_REF     varchar(20),
  R_COD_REF_DET varchar(20),
  R_SOMA_NIVEL  double precision
)
as
  declare variable FkTipoDetalhe  integer;
  declare variable PkOperacoes    integer;
  declare variable FlagTDet       smallint;
  declare variable FlagTCusto     smallint;
  declare variable FlagAcbMed     smallint;
  declare variable TempoMedio     double precision;
  declare variable CustDet        double precision;
  declare variable QtdDet         double precision;
  declare variable PercPerda      double precision;
begin
  select FLAG_TCUSTO, FLAG_TACABM
    from PARAMETROS_ESTQ 
   where FK_EMPRESAS = :P_FK_EMPRESAS
    into :FlagTCusto, :FlagAcbMed;
  if (:P_FK_PRODUTOS is not null) then
  begin
    select Pcd.PK_PRODUTOS_CODIGOS, DSC_PROD
      from PRODUTOS Prd, PRODUTOS_CODIGOS Pcd
     where Prd.PK_PRODUTOS   = :P_FK_PRODUTOS
       and Pcd.FK_PRODUTOS   = Prd.PK_PRODUTOS
       and Pcd.FLAG_TCODE    = 0 
       and Pcd.FLAG_TBARCODE = 0 
      into :R_COD_REF, :R_DSC_PROD;
      
    for select TEMPO_MEDIO, PK_OPERACOES
          from OPERACOES
         where FK_PRODUTOS_PECAS = :P_FK_PRODUTOS
          into :TempoMedio, :PkOperacoes do
    begin
      if (PkOperacoes is not null) then
      begin
        for select FK_TIPO_DETALHE, FLAG_TDET, QTD_DET,
                   PERC_PERDA
              from OPERACOES_DETALHES
             where FK_PRODUTOS_PECAS = :P_FK_PRODUTOS
               and FK_OPERACOES      = :PkOperacoes
              into :FkTipoDetalhe, :FlagTDet, :QtdDet,
                   :PercPerda do
        begin
          if (FkTipoDetalhe is not null) then
            select R_COD_REF, R_DSC_DET, R_CUST_DET
              from STP_CALC_MATERIALS_COST (:FkTipoDetalhe, :FlagTDet, 
                   :FlagTCusto, :FlagAcbMed, :QtdDet, :TempoMedio)
              into :R_COD_REF_DET, :R_DSC_DET, :CustDet;
          R_FK_PRODUTOS = P_FK_PRODUTOS;
          R_SOMA_NIVEL  = R_SOMA_NIVEL + CustDet;
          suspend;
        end /* for operacoes_detalhes */
      end /* if Pk_Operacoes */
    end /* for operacoes */
  end /* if P_FkPecas */
end ^

set term  ;^;

grant EXECUTE on procedure STP_GET_DATA_COMPONENT to PUBLIC;


set term ^;

create procedure STP_GET_PECAS_CUSTOS (
    P_FK_EMPRESAS integer,
    P_FK_PRODUTOS integer
)
returns (
    R_FK_PRODUTOS integer,
    R_DSC_PROD    varchar(50),
    R_DSC_DET     varchar(50),
    R_COD_REF     varchar(20),
    R_COD_REF_DET varchar(20),
    R_SOMA_NIVEL  double precision
)
as
  declare variable FkProdutosPecaMnt integer;
  declare variable CustDet           double precision;
begin
  R_SOMA_NIVEL = 0;
  CustDet      = 0;
  select R_FK_PRODUTOS, R_DSC_PROD, R_DSC_DET,
             R_COD_REF, R_COD_REF_DET, R_SOMA_NIVEL
        from STP_GET_DATA_COMPONENT(:P_FK_EMPRESAS, :P_FK_PRODUTOS)
        into :R_FK_PRODUTOS, :R_DSC_PROD, :R_DSC_DET,
             :R_COD_REF, :R_COD_REF_DET, :R_SOMA_NIVEL;
  suspend;
  for select FK_PRODUTOS_PECAS_MNT
    from PECAS_COMPONENTES
   where FK_PRODUTOS_PECAS = :P_FK_PRODUTOS
    into :FkProdutosPecaMnt do
  begin
    if (FkProdutosPecaMnt <> R_FK_PRODUTOS) then
    begin
      suspend;
      /* get data from the same procedure with recursive mode */
      for select R_FK_PRODUTOS, R_COD_REF, R_DSC_PROD, R_SOMA_NIVEL
        from STP_GET_PECAS_CUSTOS(:P_FK_EMPRESAS, :FkProdutosPecaMnt)
        into :R_FK_PRODUTOS, :R_COD_REF, :R_DSC_PROD, :R_SOMA_NIVEL do
      begin
        select R_FK_PRODUTOS, R_DSC_PROD, R_DSC_DET,
               R_COD_REF, R_COD_REF_DET, R_SOMA_NIVEL
          from STP_GET_DATA_COMPONENT(:P_FK_EMPRESAS, :R_FK_PRODUTOS)
          into :R_FK_PRODUTOS, :R_DSC_PROD, :R_DSC_DET,
               :R_COD_REF, :R_COD_REF_DET, :R_SOMA_NIVEL;
        suspend;
      end
    end /* if FkPecaMontagem <> P_FkPecas */
  end /* for PECAS_COMPONENTES */
end^

set term  ;^;

grant EXECUTE on procedure STP_GET_PECAS_CUSTOS to PUBLIC;


set term ^;

create procedure STP_GET_TOP_FATHER (
    P_FK_PRODUTOS_PECAS integer,
    P_MULT              integer
)
RETURNS (
    R_FK_PRODUTOS_PECAS integer,
    R_MAJ_VER           integer,
    R_MIN_VER           integer,
    R_QTD_PEC           float,
    R_COD_REF           varchar(30),
    R_DSC_PROD          varchar(50)
)
as
  declare variable FkPecasPesquisa        integer;
  declare variable FkPecasPai             integer;
  declare variable MajVerPai              integer;
  declare variable MinVerPai              integer;
  declare variable QtdPecPai              float;
  declare variable CodRefPai              varchar(20);
  declare variable DscPecPai              varchar(50);
  declare variable FkPecasPai2            integer;
  declare variable MajVerPai2             integer;
  declare variable MinVerPai2             integer;
  declare variable QtdPecPai2             float;
  declare variable CodRefPai2             varchar(20);
  declare variable DscPecPai2             varchar(50);
  declare variable TotalFathers           integer;
  declare variable TotalGrandFathers      integer;
  declare variable AMult                  integer;
begin
  if ((P_MULT is null) or (P_MULT < 1)) then P_MULT = 1;
  TotalFathers = 0;
  for select Ppc.FK_PRODUTOS, Ppc.MAJ_VER, Ppc.MIN_VER,
             Pcc.QTD_PEC, Pcd.PK_PRODUTOS_CODIGOS, Prd.DSC_PROD
        from PECAS_COMPONENTES Pcc, PRODUTOS_PECAS Ppc,
             PRODUTOS Prd, PRODUTOS_CODIGOS Pcd
       where Pcc.FK_PRODUTOS_PECAS    <> Pcc.FK_PRODUTOS_PECAS_MNT
         and Pcc.FK_PRODUTOS_PECAS_MNT = :P_FK_PRODUTOS_PECAS
         and Ppc.FK_PRODUTOS           = Pcc.FK_PRODUTOS_PECAS
         and Prd.PK_PRODUTOS           = Pcc.FK_PRODUTOS_PECAS
         and Pcd.FK_PRODUTOS           = Pcc.FK_PRODUTOS_PECAS
        into :FkPecasPai, :MajVerPai, :MinVerPai,
             :QtdPecPai, :CodRefPai, :DscPecPai do
  begin
    TotalGrandFathers = 0;
    TotalFathers      = TotalFathers + 1;
    FkPecasPesquisa   = FkPecasPai;
    AMult = P_MULT * QtdPecPai;
    for select R_FK_PRODUTOS_PECAS, R_MAJ_VER, R_MIN_VER, R_QTD_PEC, 
               R_COD_REF, R_DSC_PROD
          from STP_GET_TOP_FATHER(:FkPecasPesquisa, :AMult)
          into :FkPecasPai2, :MajVerPai2, :MinVerPai2, :QtdPecPai2, 
               :CodRefPai2, :DscPecPai2 do
    begin
      TotalGrandFathers   = TotalGrandFathers + 1;
      R_FK_PRODUTOS_PECAS = FkPecasPai2;
      R_MAJ_VER           = MajVerPai2;
      R_MIN_VER           = MinVerPai2;
      R_QTD_PEC           = P_MULT * QtdPecPai2;
      R_COD_REF           = CodRefPai2;
      R_DSC_PROD          = DscPecPai2;
      suspend;
    end
    if (TotalGrandFathers < 1) then
    begin
      R_FK_PRODUTOS_PECAS = FkPecasPai;
      R_MAJ_VER           = MajVerPai;
      R_MIN_VER           = MinVerPai;
      R_QTD_PEC           = P_MULT * QtdPecPai;
      R_COD_REF           = CodRefPai;
      R_DSC_PROD          = DscPecPai;
      suspend;
    end
  end
  if (TotalFathers < 1) then
  begin
    R_FK_PRODUTOS_PECAS = P_FK_PRODUTOS_PECAS;
    select Ppc.MAJ_VER, Ppc.MIN_VER, Pcc.QTD_PEC, 
           Pcd.PK_PRODUTOS_CODIGOS, Prd.DSC_PROD
      from PECAS_COMPONENTES Pcc, PRODUTOS_PECAS Ppc,
           PRODUTOS Prd, PRODUTOS_CODIGOS Pcd
     where Pcc.FK_PRODUTOS_PECAS     = Pcc.FK_PRODUTOS_PECAS_MNT
       and Pcc.FK_PRODUTOS_PECAS_MNT = :P_FK_PRODUTOS_PECAS
      into :R_MAJ_VER, :R_MIN_VER, :R_QTD_PEC, 
           :R_COD_REF, :R_DSC_PROD;
    if ((R_COD_REF is not null) and (R_QTD_PEC is not null)) then
    begin
      R_QTD_PEC = P_MULT * R_QTD_PEC;
      suspend;
    end
  end
end ^

set term ;^;

grant EXECUTE on procedure STP_GET_TOP_FATHER to PUBLIC;


/*  Insert trigger "TBIG_FASES_PRODUCAO" for table "FASES_PRODUCAO"  */
set term ^;

create trigger TBIG_FASES_PRODUCAO for FASES_PRODUCAO
before insert as
  declare variable MaxValue integer;
begin
  if ((New.PK_FASES_PRODUCAO is null) or
     (New.PK_FASES_PRODUCAO = 0)) then
  begin
    select Max(PK_FASES_PRODUCAO)
      from FASES_PRODUCAO
     where FK_PRODUTOS_PECAS = New.FK_PRODUTOS_PECAS
      into :MaxValue;
    if (MaxValue is null) then
      MaxValue   = 0;
    New.PK_FASES_PRODUCAO = MaxValue + 1;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
end^

set term ;^;


/*  Update trigger "TBU0_FASES_PRODUCAO" for table "FASES_PRODUCAO"  */
set term ^;

create trigger TBU0_FASES_PRODUCAO for FASES_PRODUCAO
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'FASES_PRODUCAO', 3, 'FASES_PRODUCAO', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_OPERACOES" for table "OPERACOES"  */
set term ^;

create trigger TBIG_OPERACOES for OPERACOES
before insert as
  declare variable MaxValue integer;
begin
  if ((New.PK_OPERACOES is null) or (New.PK_OPERACOES = 0)) then
  begin
   select Max(PK_OPERACOES)
      from OPERACOES
     where FK_PRODUTOS_PECAS = New.FK_PRODUTOS_PECAS
       and FK_FASES_PRODUCAO = New.FK_FASES_PRODUCAO
      into :MaxValue;
    if (MaxValue is null) then
      MaxValue   = 0;
    New.PK_OPERACOES = MaxValue + 1;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
end^

set term ;^;


/*  Update trigger "TBU0_OPERACOES" for table "OPERACOES"  */
set term ^;

create trigger TBU0_OPERACOES for OPERACOES
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'OPERACOES', 3, 'OPERACOES', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_OPERACOES_DETALHES" for table "OPERACOES_DETALHES"  */
set term ^;

create trigger TBIG_OPERACOES_DETALHES for OPERACOES_DETALHES
before insert as
  declare variable MaxValue integer;
begin
  if ((New.PK_OPERACOES_DETALHES is null) or
     (New.PK_OPERACOES_DETALHES = 0)) then
  begin
    select Max(PK_OPERACOES_DETALHES)
      from OPERACOES_DETALHES
     where FK_PRODUTOS_PECAS = New.FK_PRODUTOS_PECAS
       and FK_FASES_PRODUCAO = New.FK_FASES_PRODUCAO
       and FK_OPERACOES      = New.FK_OPERACOES
      into :MaxValue;
    if (MaxValue is null) then
      MaxValue   = 0;
    New.PK_OPERACOES_DETALHES = MaxValue + 1;
  end
  New.OPE_INC  = user;
  New.DTHR_INC = current_timestamp;
end^

set term ;^;


/*  Update trigger "TBU0_OPERACOES_DETALHES" for table "OPERACOES_DETALHES"  */
set term ^;

create trigger TBU0_OPERACOES_DETALHES for OPERACOES_DETALHES
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'OPERACOES_DETALHES', 3, 'OPERACOES_DETALHES', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_PECAS_COMPONENTES" for table "PECAS_COMPONENTES"  */
set term ^;

create trigger TBU0_PECAS_COMPONENTES for PECAS_COMPONENTES
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PECAS_COMPONENTES', 3, 'PECAS_COMPONENTES', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_PECAS_COMPO_OPER" for table "PECAS_COMPO_OPER"  */
set term ^;

create trigger TBU0_PECAS_COMPO_OPER for PECAS_COMPO_OPER
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PECAS_COMPO_OPER', 3, 'PECAS_COMPO_OPER', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_PECAS_FERRAMENTAS" for table "PECAS_FERRAMENTAS"  */
set term ^;

create trigger TBU0_PECAS_FERRAMENTAS for PECAS_FERRAMENTAS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PECAS_FERRAMENTAS', 3, 'PECAS_FERRAMENTAS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_PECAS_MAQUINAS" for table "PECAS_MAQUINAS"  */
set term ^;

create trigger TBU0_PECAS_MAQUINAS for PECAS_MAQUINAS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PECAS_MAQUINAS', 3, 'PECAS_MAQUINAS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_PRODUTOS_MAQUINAS" for table "PRODUTOS_MAQUINAS"  */
set term ^;

create trigger TBU0_PRODUTOS_MAQUINAS for PRODUTOS_MAQUINAS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PRODUTOS_MAQUINAS', 3, 'PRODUTOS_MAQUINAS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_PRODUTOS_PECAS" for table "PRODUTOS_PECAS"  */
set term ^;

create trigger TBU0_PRODUTOS_PECAS for PRODUTOS_PECAS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PRODUTOS_PECAS', 3, 'PRODUTOS_PECAS', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_PRODUTOS_PECAS_HISTORICOS" for table "PRODUTOS_PECAS_HISTORICOS"  */
set term ^;

create trigger TBU0_PRODUTOS_PECAS_HISTORICOS for PRODUTOS_PECAS_HISTORICOS
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'PRODUTOS_PECAS_HISTORICOS', 3, 'PRODUTOS_PECAS_HISTORICOS', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_TIPO_FASES_PRODUCAO" for table "TIPO_FASES_PRODUCAO"  */
set term ^;

create trigger TBIG_TIPO_FASES_PRODUCAO for TIPO_FASES_PRODUCAO
before insert as
begin
  if ((New.PK_TIPO_FASES_PRODUCAO is null) or (New.PK_TIPO_FASES_PRODUCAO = 0)) then
    New.PK_TIPO_FASES_PRODUCAO = Gen_Id(TIPO_FASES_PRODUCAO, 1);
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_FASES_PRODUCAO', 2, 'TIPO_FASES_PRODUCAO', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_TIPO_FASES_PRODUCAO" for table "TIPO_FASES_PRODUCAO"  */
set term ^;

create trigger TBU0_TIPO_FASES_PRODUCAO for TIPO_FASES_PRODUCAO
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_FASES_PRODUCAO', 3, 'TIPO_FASES_PRODUCAO', current_timestamp);
end^

set term ;^;


/*  Insert trigger "TBIG_TIPO_OPERACOES" for table "TIPO_OPERACOES"  */
set term ^;

create trigger TBIG_TIPO_OPERACOES for TIPO_OPERACOES
before insert as
begin
  if ((New.PK_TIPO_OPERACOES is null) or (New.PK_TIPO_OPERACOES = 0)) then
    New.PK_TIPO_OPERACOES = Gen_Id(TIPO_OPERACOES, 1);
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_OPERACOES', 2, 'TIPO_OPERACOES', current_timestamp);
end^

set term ;^;


/*  Update trigger "TBU0_TIPO_OPERACOES" for table "TIPO_OPERACOES"  */
set term ^;

create trigger TBU0_TIPO_OPERACOES for TIPO_OPERACOES
before update as
begin
  New.OPE_ALT  = user;
  New.DTHR_ALT = current_timestamp;
  insert into HISTORICOS
    (PK_HISTORICOS, NOM_USU, NOM_FORM, FLAG_TOPE, NOM_ARQ, DTHR_OPE)
  values
    (0, user, 'TIPO_OPERACOES', 3, 'TIPO_OPERACOES', current_timestamp);
end^

set term ;^;

