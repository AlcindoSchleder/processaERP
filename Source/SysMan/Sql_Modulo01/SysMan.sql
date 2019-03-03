/*==============================================================*/
/* Database name:  PROCESSA                                     */
/* DBMS name:      Friebird15x                                  */
/* Created on:     7/9/2006 01:13:38                            */
/*==============================================================*/


create generator HISTORICOS;

create generator MASCARAS;

create generator MODULOS;

create generator RESOURCES;

create generator ROTINAS;

create generator TIPO_DOCUMENTOS;

/*==============================================================*/
/* Domain: BLOB_BINARIO                                         */
/*==============================================================*/
create domain BLOB_BINARIO as BLOB SUB_TYPE 0 SEGMENT SIZE 80;

/*==============================================================*/
/* Domain: BLOB_TEXTO                                           */
/*==============================================================*/
create domain BLOB_TEXTO as BLOB SUB_TYPE 1 SEGMENT SIZE 80;

/*==============================================================*/
/* Domain: CNPJ                                                 */
/*==============================================================*/
create domain CNPJ as VARCHAR(14);

/*==============================================================*/
/* Domain: CODIGO_BARRAS                                        */
/*==============================================================*/
create domain CODIGO_BARRAS as VARCHAR(30);

/*==============================================================*/
/* Domain: CODIGO_CONTA                                         */
/*==============================================================*/
create domain CODIGO_CONTA as VARCHAR(15);

/*==============================================================*/
/* Domain: CODIGO_GER_REFERENCIA                                */
/*==============================================================*/
create domain CODIGO_GER_REFERENCIA as VARCHAR(3)  not null;

/*==============================================================*/
/* Domain: CODIGO_IMPOSTO_ECF                                   */
/*==============================================================*/
create domain CODIGO_IMPOSTO_ECF as CHAR(3);

/*==============================================================*/
/* Domain: CODIGO_PRODUTO                                       */
/*==============================================================*/
create domain CODIGO_PRODUTO as VARCHAR(20);

/*==============================================================*/
/* Domain: CODIGO_UNIDADES                                      */
/*==============================================================*/
create domain CODIGO_UNIDADES as CHAR(2);

/*==============================================================*/
/* Domain: COMLEMENTO_NAT_OPERACAO                              */
/*==============================================================*/
create domain COMLEMENTO_NAT_OPERACAO as CHAR(3) default '001' not null;

/*==============================================================*/
/* Domain: CONTROLE_DRIVER                                      */
/*==============================================================*/
create domain CONTROLE_DRIVER as VARCHAR(20);

/*==============================================================*/
/* Domain: CPF                                                  */
/*==============================================================*/
create domain CPF as VARCHAR(11);

/*==============================================================*/
/* Domain: DATA                                                 */
/*==============================================================*/
create domain DATA as DATE;

/*==============================================================*/
/* Domain: DATA_DEF                                             */
/*==============================================================*/
create domain DATA_DEF as DATE default current_date;

/*==============================================================*/
/* Domain: DATA_HORA                                            */
/*==============================================================*/
create domain DATA_HORA as TIMESTAMP;

/*==============================================================*/
/* Domain: DATA_HORA_DEF                                        */
/*==============================================================*/
create domain DATA_HORA_DEF as TIMESTAMP default current_timestamp;

/*==============================================================*/
/* Domain: DESCRICAO_10                                         */
/*==============================================================*/
create domain DESCRICAO_10 as VARCHAR(10);

/*==============================================================*/
/* Domain: DESCRICAO_100                                        */
/*==============================================================*/
create domain DESCRICAO_100 as VARCHAR(100);

/*==============================================================*/
/* Domain: DESCRICAO_100RQ                                      */
/*==============================================================*/
create domain DESCRICAO_100RQ as VARCHAR(100)  not null;

/*==============================================================*/
/* Domain: DESCRICAO_20                                         */
/*==============================================================*/
create domain DESCRICAO_20 as VARCHAR(20);

/*==============================================================*/
/* Domain: DESCRICAO_20RQ                                       */
/*==============================================================*/
create domain DESCRICAO_20RQ as VARCHAR(20)  not null;

/*==============================================================*/
/* Domain: DESCRICAO_30                                         */
/*==============================================================*/
create domain DESCRICAO_30 as VARCHAR(30);

/*==============================================================*/
/* Domain: DESCRICAO_30RQ                                       */
/*==============================================================*/
create domain DESCRICAO_30RQ as VARCHAR(30)  not null;

/*==============================================================*/
/* Domain: DESCRICAO_50                                         */
/*==============================================================*/
create domain DESCRICAO_50 as VARCHAR(50);

/*==============================================================*/
/* Domain: DESCRICAO_50RQ                                       */
/*==============================================================*/
create domain DESCRICAO_50RQ as VARCHAR(50)  not null;

/*==============================================================*/
/* Domain: FLAG                                                 */
/*==============================================================*/
create domain FLAG as SMALLINT default 0;

/*==============================================================*/
/* Domain: FLAG_CARGO                                           */
/*==============================================================*/
create domain FLAG_CARGO as SMALLINT default 4 not null
      check (value in (0,1,2,3,4));

/*==============================================================*/
/* Domain: FLAG_COMISSAO_ITEM                                   */
/*==============================================================*/
create domain FLAG_COMISSAO_ITEM as SMALLINT default 0 not null
      check (value in (0,1,2,3));

/*==============================================================*/
/* Domain: FLAG_DATA_BASE                                       */
/*==============================================================*/
create domain FLAG_DATA_BASE as SMALLINT default 0 not null
      check (value in (0,1,2,3));

/*==============================================================*/
/* Domain: FLAG_DEBITO_CREDITO                                  */
/*==============================================================*/
create domain FLAG_DEBITO_CREDITO as SMALLINT default 0 not null
      check (value in (0,1));

/*==============================================================*/
/* Domain: FLAG_DIRECTION                                       */
/*==============================================================*/
create domain FLAG_DIRECTION as SMALLINT default 0 not null
      check (value in (0,1));

/*==============================================================*/
/* Domain: FLAG_EMITE_CHEQUE                                    */
/*==============================================================*/
create domain FLAG_EMITE_CHEQUE as SMALLINT default 0 not null
      check (value in (0,1,2,3));

/*==============================================================*/
/* Domain: FLAG_ENTRADA_SAIDA                                   */
/*==============================================================*/
create domain FLAG_ENTRADA_SAIDA as SMALLINT default 0 not null
      check (value in (0,1));

/*==============================================================*/
/* Domain: FLAG_ESTADO_CIVIL                                    */
/*==============================================================*/
create domain FLAG_ESTADO_CIVIL as SMALLINT default 0 not null
      check (value in (0,1,2,3,4,5));

/*==============================================================*/
/* Domain: FLAG_ESTOQUES_NEGATIVO                               */
/*==============================================================*/
create domain FLAG_ESTOQUES_NEGATIVO as SMALLINT default 0 not null
      check (value in (0,1,2));

/*==============================================================*/
/* Domain: FLAG_FORMATO_IMPRESSAO                               */
/*==============================================================*/
create domain FLAG_FORMATO_IMPRESSAO as SMALLINT default 0 not null
      check (value in (0,1,2,3,4));

/*==============================================================*/
/* Domain: FLAG_GRAU_INSTRUCAO                                  */
/*==============================================================*/
create domain FLAG_GRAU_INSTRUCAO as SMALLINT default 0 not null
      check (value in (0,1,2,3,4));

/*==============================================================*/
/* Domain: FLAG_IMPOSTO                                         */
/*==============================================================*/
create domain FLAG_IMPOSTO as SMALLINT default 0 not null
      check (value in (0,1,2,3,4,5,6,7,8));

/*==============================================================*/
/* Domain: FLAG_INTERNET                                        */
/*==============================================================*/
create domain FLAG_INTERNET as SMALLINT default 0 
      check (value is null or (value in (0,1,2,3,4)));

/*==============================================================*/
/* Domain: FLAG_LADO_ED                                         */
/*==============================================================*/
create domain FLAG_LADO_ED as SMALLINT default 0 not null
      check (value in (0,1,2));

/*==============================================================*/
/* Domain: FLAG_MOTIVO_OPERACAO                                 */
/*==============================================================*/
create domain FLAG_MOTIVO_OPERACAO as SMALLINT default 0 not null
      check (value in (0,1,2,3,4));

/*==============================================================*/
/* Domain: FLAG_NATUREZA_CONTA                                  */
/*==============================================================*/
create domain FLAG_NATUREZA_CONTA as SMALLINT default 0 not null
      check (value in (0,1,2,3,4));

/*==============================================================*/
/* Domain: FLAG_OPCIONAL                                        */
/*==============================================================*/
create domain FLAG_OPCIONAL as SMALLINT default 0 not null
      check (value in (0,1));

/*==============================================================*/
/* Domain: FLAG_OPERACAO                                        */
/*==============================================================*/
create domain FLAG_OPERACAO as SMALLINT default 0 not null
      check (value in (0,1,2));

/*==============================================================*/
/* Domain: FLAG_ORIGEM_DESTINO                                  */
/*==============================================================*/
create domain FLAG_ORIGEM_DESTINO as SMALLINT default 0 not null
      check (value in (0,1,2,3,4));

/*==============================================================*/
/* Domain: FLAG_PARCELA                                         */
/*==============================================================*/
create domain FLAG_PARCELA as SMALLINT default 0 not null
      check (value in (0,1,2,3));

/*==============================================================*/
/* Domain: FLAG_RECEBER_PAGAR                                   */
/*==============================================================*/
create domain FLAG_RECEBER_PAGAR as SMALLINT default 0 not null
      check (value in (0,1));

/*==============================================================*/
/* Domain: FLAG_RECEITA_DESPESA                                 */
/*==============================================================*/
create domain FLAG_RECEITA_DESPESA as SMALLINT default 0 not null
      check (value in (0,1));

/*==============================================================*/
/* Domain: FLAG_SEXO                                            */
/*==============================================================*/
create domain FLAG_SEXO as SMALLINT default 0 not null
      check (value in (0,1));

/*==============================================================*/
/* Domain: FLAG_SIM_NAO                                         */
/*==============================================================*/
create domain FLAG_SIM_NAO as SMALLINT default 0 not null
      check (value in (0,1));

/*==============================================================*/
/* Domain: FLAG_STATUS_CONTATO                                  */
/*==============================================================*/
create domain FLAG_STATUS_CONTATO as SMALLINT default 0 not null
      check (value in (0,1,2,3));

/*==============================================================*/
/* Domain: FLAG_STATUS_OP                                       */
/*==============================================================*/
create domain FLAG_STATUS_OP as SMALLINT default 0 not null
      check (value in (0,1,2,3,4));

/*==============================================================*/
/* Domain: FLAG_TIPO_ACABAMENTO                                 */
/*==============================================================*/
create domain FLAG_TIPO_ACABAMENTO as SMALLINT default 0 not null
      check (value in (0,1,2));

/*==============================================================*/
/* Domain: FLAG_TIPO_ARQUIVO_OCORR                              */
/*==============================================================*/
create domain FLAG_TIPO_ARQUIVO_OCORR as SMALLINT default 0 not null
      check (value in (0,1,2,3,4));

/*==============================================================*/
/* Domain: FLAG_TIPO_BAIXA_ESTQ                                 */
/*==============================================================*/
create domain FLAG_TIPO_BAIXA_ESTQ as SMALLINT default 0 not null
      check (value in (0,1,2));

/*==============================================================*/
/* Domain: FLAG_TIPO_CADASTRO                                   */
/*==============================================================*/
create domain FLAG_TIPO_CADASTRO as SMALLINT default 0 not null
      check (value in (0,1));

/*==============================================================*/
/* Domain: FLAG_TIPO_CAMPO_DOC                                  */
/*==============================================================*/
create domain FLAG_TIPO_CAMPO_DOC as SMALLINT default 2 not null
      check (value in (2,0,1));

/*==============================================================*/
/* Domain: FLAG_TIPO_CATEGORIA                                  */
/*==============================================================*/
create domain FLAG_TIPO_CATEGORIA as SMALLINT default 0 not null
      check (value in (0,1,2,3,4,5));

/*==============================================================*/
/* Domain: FLAG_TIPO_CATEGORIA_CNT                              */
/*==============================================================*/
create domain FLAG_TIPO_CATEGORIA_CNT as SMALLINT default 0 not null
      check (value in (0,1,2,3,4));

/*==============================================================*/
/* Domain: FLAG_TIPO_CODIGO_BARRAS                              */
/*==============================================================*/
create domain FLAG_TIPO_CODIGO_BARRAS as SMALLINT default 0 not null
      check (value in (0,1,2,3,4,5));

/*==============================================================*/
/* Domain: FLAG_TIPO_CODIGO_PRODUTO                             */
/*==============================================================*/
create domain FLAG_TIPO_CODIGO_PRODUTO as SMALLINT default 0 not null
      check (value in (0,1,2,3));

/*==============================================================*/
/* Domain: FLAG_TIPO_CONTA                                      */
/*==============================================================*/
create domain FLAG_TIPO_CONTA as SMALLINT default 0 not null
      check (value in (0,1,2));

/*==============================================================*/
/* Domain: FLAG_TIPO_CUSTOS                                     */
/*==============================================================*/
create domain FLAG_TIPO_CUSTOS as SMALLINT default 1 not null
      check (value in (0,1,2,3,4));

/*==============================================================*/
/* Domain: FLAG_TIPO_DESCONTO                                   */
/*==============================================================*/
create domain FLAG_TIPO_DESCONTO as SMALLINT default 0 not null
      check (value in (0,1,2,3));

/*==============================================================*/
/* Domain: FLAG_TIPO_DESCR_INSUMO                               */
/*==============================================================*/
create domain FLAG_TIPO_DESCR_INSUMO as SMALLINT default 0 not null
      check (value in (0,1,2,3));

/*==============================================================*/
/* Domain: FLAG_TIPO_DETALHE                                    */
/*==============================================================*/
create domain FLAG_TIPO_DETALHE as SMALLINT default 0 not null
      check (value in (0,1,2));

/*==============================================================*/
/* Domain: FLAG_TIPO_DOCUMENTO                                  */
/*==============================================================*/
create domain FLAG_TIPO_DOCUMENTO as SMALLINT default 0 not null
      check (value in (0,1,2,3,4,5,6,7,8,9));

/*==============================================================*/
/* Domain: FLAG_TIPO_EMPRESA                                    */
/*==============================================================*/
create domain FLAG_TIPO_EMPRESA as SMALLINT default 0 not null
      check (value in (0,1,2));

/*==============================================================*/
/* Domain: FLAG_TIPO_FINALIZADORA_PGT                           */
/*==============================================================*/
create domain FLAG_TIPO_FINALIZADORA_PGT as SMALLINT default 0 not null
      check (value in (0,1,2,3,4,5,6,7,8,9));

/*==============================================================*/
/* Domain: FLAG_TIPO_FRETE                                      */
/*==============================================================*/
create domain FLAG_TIPO_FRETE as SMALLINT default 1 not null
      check (value in (1,2,3));

/*==============================================================*/
/* Domain: FLAG_TIPO_GARANTIA                                   */
/*==============================================================*/
create domain FLAG_TIPO_GARANTIA as SMALLINT default 0 not null
      check (value in (0,1,2));

/*==============================================================*/
/* Domain: FLAG_TIPO_IMAGEM                                     */
/*==============================================================*/
create domain FLAG_TIPO_IMAGEM as SMALLINT default 0 not null
      check (value in (-1,0,1,2));

/*==============================================================*/
/* Domain: FLAG_TIPO_INSPECAO                                   */
/*==============================================================*/
create domain FLAG_TIPO_INSPECAO as SMALLINT default 0 not null
      check (value in (0,1,2,3));

/*==============================================================*/
/* Domain: FLAG_TIPO_INTERVALO_TEMPO                            */
/*==============================================================*/
create domain FLAG_TIPO_INTERVALO_TEMPO as SMALLINT default 0 not null
      check (value in (0,1,2));

/*==============================================================*/
/* Domain: FLAG_TIPO_ITEM_OS                                    */
/*==============================================================*/
create domain FLAG_TIPO_ITEM_OS as SMALLINT default 0 not null
      check (value in (0,1,2));

/*==============================================================*/
/* Domain: FLAG_TIPO_MARGEM                                     */
/*==============================================================*/
create domain FLAG_TIPO_MARGEM as SMALLINT default 0 not null
      check (value in (0,1));

/*==============================================================*/
/* Domain: FLAG_TIPO_MATERIAL                                   */
/*==============================================================*/
create domain FLAG_TIPO_MATERIAL as SMALLINT default 0 not null
      check (value in (0,1,2));

/*==============================================================*/
/* Domain: FLAG_TIPO_OBJETO                                     */
/*==============================================================*/
create domain FLAG_TIPO_OBJETO as SMALLINT default 0 not null
      check (value in (0,1,2,3));

/*==============================================================*/
/* Domain: FLAG_TIPO_OCORRENCIA                                 */
/*==============================================================*/
create domain FLAG_TIPO_OCORRENCIA as SMALLINT default 0 not null
      check (value in (0,1,2,3,4));

/*==============================================================*/
/* Domain: FLAG_TIPO_OPERACAO                                   */
/*==============================================================*/
create domain FLAG_TIPO_OPERACAO as SMALLINT default 0 not null
      check (value in (0,1,2,3,4));

/*==============================================================*/
/* Domain: FLAG_TIPO_PECA                                       */
/*==============================================================*/
create domain FLAG_TIPO_PECA as SMALLINT default 0 
      check (value is null or (value in (0,1,2,3,4)));

/*==============================================================*/
/* Domain: FLAG_TIPO_PEDIDOS                                    */
/*==============================================================*/
create domain FLAG_TIPO_PEDIDOS as SMALLINT default 0 not null
      check (value in (0,1,2,3,4,5,6,7));

/*==============================================================*/
/* Domain: FLAG_TIPO_PHONE                                      */
/*==============================================================*/
create domain FLAG_TIPO_PHONE as SMALLINT default 4 not null
      check (value in (0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16));

/*==============================================================*/
/* Domain: FLAG_TIPO_PLANO_CONTAS                               */
/*==============================================================*/
create domain FLAG_TIPO_PLANO_CONTAS as SMALLINT default 0 not null
      check (value in (0,1,2,3));

/*==============================================================*/
/* Domain: FLAG_TIPO_PRODUTO                                    */
/*==============================================================*/
create domain FLAG_TIPO_PRODUTO as SMALLINT default 0 not null
      check (value in (0,1,2,3,4));

/*==============================================================*/
/* Domain: FLAG_TIPO_RPT_EVENTO                                 */
/*==============================================================*/
create domain FLAG_TIPO_RPT_EVENTO as SMALLINT default 0 not null
      check (value in (0,1,2,3,4,5,6,8));

/*==============================================================*/
/* Domain: FLAG_TIPO_SALARIO                                    */
/*==============================================================*/
create domain FLAG_TIPO_SALARIO as SMALLINT default 0 not null
      check (value in (0,1,2,3,4,5,6));

/*==============================================================*/
/* Domain: FLAG_TIPO_SALDO                                      */
/*==============================================================*/
create domain FLAG_TIPO_SALDO as SMALLINT default 0 not null
      check (value in (0,1,2,3));

/*==============================================================*/
/* Domain: FLAG_TIPO_STATUS_OS                                  */
/*==============================================================*/
create domain FLAG_TIPO_STATUS_OS as SMALLINT default 0 not null
      check (value in (0,1,2,3,4,5));

/*==============================================================*/
/* Domain: FLAG_TIPO_TABELA                                     */
/*==============================================================*/
create domain FLAG_TIPO_TABELA as SMALLINT default 0 not null
      check (value in (0,1,2));

/*==============================================================*/
/* Domain: FLAG_TIPO_TICKET                                     */
/*==============================================================*/
create domain FLAG_TIPO_TICKET as SMALLINT default 0 not null
      check (value in (0,1));

/*==============================================================*/
/* Domain: FLAG_TIPO_VALOR                                      */
/*==============================================================*/
create domain FLAG_TIPO_VALOR as SMALLINT default 0 not null
      check (value in (0,1));

/*==============================================================*/
/* Domain: FLAG_TIPO_VENDA                                      */
/*==============================================================*/
create domain FLAG_TIPO_VENDA as SMALLINT default 0 not null
      check (value in (0,1,2,3));

/*==============================================================*/
/* Domain: HORA                                                 */
/*==============================================================*/
create domain HORA as TIME;

/*==============================================================*/
/* Domain: HORA_DEF                                             */
/*==============================================================*/
create domain HORA_DEF as TIME default current_time;

/*==============================================================*/
/* Domain: INSCRICAO_ESTADUAL_RG                                */
/*==============================================================*/
create domain INSCRICAO_ESTADUAL_RG as VARCHAR(20);

/*==============================================================*/
/* Domain: LINGUAGEM                                            */
/*==============================================================*/
create domain LINGUAGEM as VARCHAR(5) default 'pt_br' not null;

/*==============================================================*/
/* Domain: MAPEAMENTO_IMPRESSORA                                */
/*==============================================================*/
create domain MAPEAMENTO_IMPRESSORA as VARCHAR(5) default 'LPT1';

/*==============================================================*/
/* Domain: MENSAGEM                                             */
/*==============================================================*/
create domain MENSAGEM as VARCHAR(80);

/*==============================================================*/
/* Domain: MES_ANO                                              */
/*==============================================================*/
create domain MES_ANO as CHAR(6);

/*==============================================================*/
/* Domain: NATUREZA_DA_OPERACAO                                 */
/*==============================================================*/
create domain NATUREZA_DA_OPERACAO as VARCHAR(5);

/*==============================================================*/
/* Domain: NOME_FORMULARIO                                      */
/*==============================================================*/
create domain NOME_FORMULARIO as VARCHAR(50);

/*==============================================================*/
/* Domain: NOME_OPERADOR                                        */
/*==============================================================*/
create domain NOME_OPERADOR as VARCHAR(10);

/*==============================================================*/
/* Domain: NOME_OPERADOR_DEF                                    */
/*==============================================================*/
create domain NOME_OPERADOR_DEF as VARCHAR(10) default user;

/*==============================================================*/
/* Domain: NOMOPER                                              */
/*==============================================================*/
create domain NOMOPER as VARCHAR(10);

/*==============================================================*/
/* Domain: NUMERO_BOLETO                                        */
/*==============================================================*/
create domain NUMERO_BOLETO as VARCHAR(20);

/*==============================================================*/
/* Domain: NUMERO_GRANDE                                        */
/*==============================================================*/
create domain NUMERO_GRANDE as NUMERIC(18,2) default 0.0;

/*==============================================================*/
/* Domain: NUMERO_GRANDE_4CD                                    */
/*==============================================================*/
create domain NUMERO_GRANDE_4CD as NUMERIC(18,4) default 0.0;

/*==============================================================*/
/* Domain: NUMERO_GRANDE_6CD                                    */
/*==============================================================*/
create domain NUMERO_GRANDE_6CD as NUMERIC(18,6) default 0.0;

/*==============================================================*/
/* Domain: NUMERO_INDICE                                        */
/*==============================================================*/
create domain NUMERO_INDICE as NUMERIC(9,4) default 0.0;

/*==============================================================*/
/* Domain: NUMERO_MEDIO                                         */
/*==============================================================*/
create domain NUMERO_MEDIO as NUMERIC(11,2) default 0.0;

/*==============================================================*/
/* Domain: NUMERO_MEDIO_4CD                                     */
/*==============================================================*/
create domain NUMERO_MEDIO_4CD as NUMERIC(11,4) default 0.0;

/*==============================================================*/
/* Domain: NUMERO_PEQUENO                                       */
/*==============================================================*/
create domain NUMERO_PEQUENO as NUMERIC(9,2) default 0.0;

/*==============================================================*/
/* Domain: NUMERO_PEQUENO_4CD                                   */
/*==============================================================*/
create domain NUMERO_PEQUENO_4CD as NUMERIC(9,4) default 0.0;

/*==============================================================*/
/* Domain: NUMERO_PERCENTUAL                                    */
/*==============================================================*/
create domain NUMERO_PERCENTUAL as NUMERIC(5,2) default 0.0;

/*==============================================================*/
/* Domain: PATH                                                 */
/*==============================================================*/
create domain PATH as VARCHAR(255);

/*==============================================================*/
/* Domain: PHONE                                                */
/*==============================================================*/
create domain PHONE as VARCHAR(20);

/*==============================================================*/
/* Domain: REFERENCIA_PRODUTOS                                  */
/*==============================================================*/
create domain REFERENCIA_PRODUTOS as VARCHAR(20);

/*==============================================================*/
/* Domain: SENHA                                                */
/*==============================================================*/
create domain SENHA as VARCHAR(14);

/*==============================================================*/
/* Domain: SITUACAO_TRIBUTARIA                                  */
/*==============================================================*/
create domain SITUACAO_TRIBUTARIA as CHAR(3)  not null;

/*==============================================================*/
/* Domain: UF                                                   */
/*==============================================================*/
create domain UF as CHAR(2)  not null;

/*==============================================================*/
/* Domain: UF_NULL                                              */
/*==============================================================*/
create domain UF_NULL as CHAR(2);

/*==============================================================*/
/* Domain: VALORI                                               */
/*==============================================================*/
create domain VALORI as INTEGER;

/*==============================================================*/
/* Domain: VALORS                                               */
/*==============================================================*/
create domain VALORS as SMALLINT;

/*==============================================================*/
/* Table: ACESSOS                                               */
/*==============================================================*/
create table ACESSOS (
FK_OPERADORES        NOME_OPERADOR                  not null,
PK_ACESSOS           VALORI                         not null,
FK_MODULOS           VALORS                         not null,
FK_ROTINAS           VALORI                         not null,
FK_PROGRAMAS         VALORI                         not null,
FLAG_BRW             FLAG_SIM_NAO                   not null,
FLAG_FND             FLAG_SIM_NAO                   not null,
FLAG_INS             FLAG_SIM_NAO                   not null,
FLAG_UPD             FLAG_SIM_NAO                   not null,
FLAG_DEL             FLAG_SIM_NAO                   not null,
FLAG_VIS             FLAG_SIM_NAO                   not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_ACESSOS primary key (FK_OPERADORES, PK_ACESSOS)
);

/*==============================================================*/
/* Index: IDX_ACESSOS                                           */
/*==============================================================*/
create unique asc index IDX_ACESSOS on ACESSOS (
FK_OPERADORES,
FK_MODULOS,
FK_ROTINAS,
FK_PROGRAMAS
);

grant SELECT,UPDATE,INSERT,DELETE on ACESSOS to PUBLIC;

/*==============================================================*/
/* Table: DATABASE_TRANSACTIONS                                 */
/*==============================================================*/
create table DATABASE_TRANSACTIONS (
PK_DATABASE_TRANSACTIONS VALORI                         not null,
DATASET              DESCRICAO_50RQ                 not null,
DTHR_TRNS            DATA_HORA_DEF                  not null,
constraint PK_DATABASE_TRANSACTIONS primary key (PK_DATABASE_TRANSACTIONS)
);

grant SELECT,UPDATE,INSERT,DELETE on DATABASE_TRANSACTIONS to PUBLIC;

/*==============================================================*/
/* Table: DICIONARIOS                                           */
/*==============================================================*/
create table DICIONARIOS (
FK_LINGUAGENS        LINGUAGEM                      not null,
PK_DICIONARIOS__NA   DESCRICAO_30RQ                 not null,
PK_DICIONARIOS__NC   DESCRICAO_30RQ                 not null,
NOM_OBJ              DESCRICAO_30RQ                 not null,
DSC_FLD              DESCRICAO_50RQ                 not null,
DSC_LBL              DESCRICAO_50RQ                 not null,
DSC_FRGN             DESCRICAO_50,
FLAG_VAL             FLAG_SIM_NAO                   not null,
FLAG_KEY             FLAG_SIM_NAO                   not null,
FLAG_EDIT            FLAG_SIM_NAO                   not null,
FLAG_QRY             FLAG_SIM_NAO                   not null,
FLAG_FIND            FLAG_SIM_NAO                   not null,
FLAG_VIS             FLAG_SIM_NAO                   not null,
FLAG_FRGN            FLAG_SIM_NAO                   not null,
FLAG_FLAG            FLAG_SIM_NAO                   not null,
FLAG_OBJV            FLAG_SIM_NAO                   not null,
FLAG_TOBJ            FLAG_TIPO_OBJETO               not null,
MSK_FLD              DESCRICAO_50,
VLR_DEF              DESCRICAO_20,
POS_FLD              VALORS                         not null,
OPE_INC              NOME_OPERADOR_DEF,
KC_VALOR_CAMPOS      VALORS,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_DICIONARIOS primary key (FK_LINGUAGENS, PK_DICIONARIOS__NA, PK_DICIONARIOS__NC)
);

grant SELECT,UPDATE,INSERT,DELETE on DICIONARIOS to PUBLIC;

/*==============================================================*/
/* Table: EMPRESAS                                              */
/*==============================================================*/
create table EMPRESAS (
PK_EMPRESAS          VALORI                         not null,
CNPJ_EMP             CNPJ                           not null,
RAZ_SOC              DESCRICAO_50RQ                 not null,
NOM_FAN              DESCRICAO_50RQ                 not null,
INSCR_EST            INSCRICAO_ESTADUAL_RG,
FK_PAISES            VALORI,
FK_ESTADOS           UF                             not null,
FK_MUNICIPIOS        VALORI,
FK_TIPO_ENDERECOS    VALORS,
END_EMP              DESCRICAO_50RQ                 not null,
NUM_END              VALORI                         not null,
CMP_EMP              DESCRICAO_50,
CEP_EMP              VALORI                         not null,
COD_ATV              DESCRICAO_10,
TIP_EMP              FLAG_TIPO_EMPRESA              not null,
FON_CMCL             PHONE,
FON_FAX              PHONE,
LOGO_EMP             BLOB_BINARIO,
QTD_TAB              VALORS,
FLAG_TIMG            FLAG_TIPO_IMAGEM               not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_EMPRESAS primary key (PK_EMPRESAS)
);

grant SELECT,INSERT,UPDATE,DELETE on EMPRESAS to PUBLIC;

/*==============================================================*/
/* Table: EMPRESA_ATIVA                                         */
/*==============================================================*/
create table EMPRESA_ATIVA (
FK_OPERADORES        NOME_OPERADOR                  not null,
FK_EMPRESAS          VALORI                         not null,
FK_LINGUAGENS        LINGUAGEM                      not null,
DTHR_LOGIN           DATA_HORA_DEF,
DTHR_LOGOUT          DATA_HORA,
constraint PK_EMPRESA_ATIVA primary key (FK_OPERADORES)
);

grant SELECT,UPDATE,INSERT,DELETE on EMPRESA_ATIVA to PUBLIC;

/*==============================================================*/
/* Table: HISTORICOS                                            */
/*==============================================================*/
create table HISTORICOS (
PK_HISTORICOS        VALORI                         not null,
NOM_USU              VARCHAR(31)                    default user not null,
NOM_FORM             NOME_FORMULARIO                not null,
NOM_ARQ              VARCHAR(31)                    not null,
FLAG_TOPE            FLAG_TIPO_OPERACAO             not null,
DTHR_OPE             DATA_HORA_DEF                  not null,
constraint PK_HISTORICOS primary key (PK_HISTORICOS)
);

grant SELECT,UPDATE,INSERT,DELETE on HISTORICOS to PUBLIC;

/*==============================================================*/
/* Table: HISTORICOS_REGISTROS                                  */
/*==============================================================*/
create table HISTORICOS_REGISTROS (
FK_HISTORICOS        VALORI                         not null,
REG_HIST_ATU         BLOB_BINARIO,
REG_HIST_ANT         BLOB_BINARIO,
constraint PK_HISTORICOS_REGISTROS primary key (FK_HISTORICOS)
);

grant SELECT,UPDATE,INSERT,DELETE on HISTORICOS_REGISTROS to PUBLIC;

/*==============================================================*/
/* Table: LINGUAGENS                                            */
/*==============================================================*/
create table LINGUAGENS (
PK_LINGUAGENS        LINGUAGEM                      not null,
DSC_LANG             DESCRICAO_30RQ                 not null,
KC_MENSAGENS         VALORI,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_LINGUAGENS primary key (PK_LINGUAGENS)
);

grant SELECT,UPDATE,INSERT,DELETE on LINGUAGENS to PUBLIC;

/*==============================================================*/
/* Table: MASCARAS                                              */
/*==============================================================*/
create table MASCARAS (
PK_MASCARAS          VALORS                         not null,
FK_LINGUAGENS        LINGUAGEM                      not null,
DSC_MSK              DESCRICAO_30RQ                 not null,
MSK_MSK              DESCRICAO_30RQ                 not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_MASCARAS primary key (PK_MASCARAS)
);

grant SELECT,UPDATE,INSERT,DELETE on MASCARAS to PUBLIC;

/*==============================================================*/
/* Table: MENSAGENS                                             */
/*==============================================================*/
create table MENSAGENS (
FK_LINGUAGENS        LINGUAGEM                      not null,
PK_MENSAGENS         VALORS                         not null,
FK_MODULOS           VALORI                         not null,
FK_ROTINAS           VALORI                         not null,
FK_PROGRAMAS         VALORI                         not null,
NOM_CNST             DESCRICAO_20                   not null,
DSC_CNST             DESCRICAO_100RQ                not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_MENSAGENS primary key (FK_LINGUAGENS, PK_MENSAGENS)
);

/*==============================================================*/
/* Index: IDX_MENSAGENS01                                       */
/*==============================================================*/
create unique asc index IDX_MENSAGENS01 on MENSAGENS (
FK_LINGUAGENS,
FK_MODULOS,
FK_ROTINAS,
FK_PROGRAMAS,
NOM_CNST
);

/*==============================================================*/
/* Index: IDX_MENSAGENS02                                       */
/*==============================================================*/
create asc index IDX_MENSAGENS02 on MENSAGENS (
FK_LINGUAGENS,
NOM_CNST
);

grant SELECT,UPDATE,INSERT,DELETE on MENSAGENS to PUBLIC;

/*==============================================================*/
/* Table: MODULOS                                               */
/*==============================================================*/
create table MODULOS (
PK_MODULOS           VALORS                         not null,
DSC_MOD              DESCRICAO_30RQ                 not null,
FK_LINGUAGENS        LINGUAGEM                      not null,
VERSAO               DESCRICAO_10,
VER_2                VALORS                         not null,
VER_1                VALORS                         not null,
VER_3                VALORS                         not null,
VER_4                VALORS                         not null,
KC_RELATORIOS        VALORS,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_MODULOS primary key (PK_MODULOS)
);

grant SELECT,UPDATE,INSERT,DELETE on MODULOS to PUBLIC;

/*==============================================================*/
/* Table: OPERADORES                                            */
/*==============================================================*/
create table OPERADORES (
PK_OPERADORES        NOME_OPERADOR                  not null,
FK_EMPRESAS          VALORI                         not null,
FK_LINGUAGENS        LINGUAGEM                      not null,
FK_CADASTROS         VALORI,
DSCT_MAX             NUMERO_PERCENTUAL,
SEN_NET              SENHA,
EMAIL_OPE            DESCRICAO_50,
FLAG_LSEN            FLAG_SIM_NAO                   not null,
FLAG_BRW             FLAG_SIM_NAO                   not null,
FLAG_FND             FLAG_SIM_NAO                   not null,
FLAG_INS             FLAG_SIM_NAO                   not null,
FLAG_UPD             FLAG_SIM_NAO                   not null,
FLAG_DEL             FLAG_SIM_NAO                   not null,
DTHR_LOGIN           DATA_HORA,
KC_ACESSOS           VALORS                         default 0,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_OPERADORES primary key (PK_OPERADORES)
);

grant SELECT,UPDATE,INSERT,DELETE on OPERADORES to PUBLIC;

/*==============================================================*/
/* Table: PARAMETROS                                            */
/*==============================================================*/
create table PARAMETROS (
FK_EMPRESAS          VALORI                         not null,
FK_CENARIOS_FINANCEIROS VALORS,
DSCT_MAX             NUMERO_PERCENTUAL,
TAX_JURM             NUMERO_PERCENTUAL,
CUST_FIX             NUMERO_PERCENTUAL,
MRGL_PDR             NUMERO_INDICE,
FLAG_COM_TPGTO       FLAG_SIM_NAO                   not null,
FLAG_COM_DESC        FLAG_SIM_NAO                   not null,
FLAG_COM_ITEM        FLAG_COMISSAO_ITEM             not null,
FLAG_DESC_ITEM       FLAG_SIM_NAO                   not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PARAMETROS primary key (FK_EMPRESAS)
);

grant SELECT,UPDATE,INSERT,DELETE on PARAMETROS to PUBLIC;

/*==============================================================*/
/* Table: PARAMETROS_GLOBAIS                                    */
/*==============================================================*/
create table PARAMETROS_GLOBAIS (
PK_PARAMETROS_GLOBAIS VALORS                         not null,
FK_CLIENTES          VALORI,
NUM_CAS_DEC          VALORS                         default 2,
NUM_CAS_DEC_QTD      VALORS                         default 2,
DIAS_ATR             VALORS,
PER_CVMED            VALORS                         default 365,
QTD_DVMED            VALORS                         default 30,
QTD_DCMED            VALORS,
QTD_DTOL             VALORS,
FLAG_LAN_PARC        FLAG_SIM_NAO                   not null,
FLAG_MULTI           FLAG_SIM_NAO                   not null,
LAST_VERSION         DESCRICAO_10,
VERSAO               DESCRICAO_20RQ                 not null,
VER_1                VALORS                         not null,
VER_2                VALORS                         not null,
VER_3                VALORS                         not null,
VER_4                VALORS                         not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PARAMETROS_GLOBAIS primary key (PK_PARAMETROS_GLOBAIS)
);

grant SELECT,UPDATE,INSERT,DELETE on PARAMETROS_GLOBAIS to PUBLIC;

/*==============================================================*/
/* Table: PARAMETROS_PRG                                        */
/*==============================================================*/
create table PARAMETROS_PRG (
FK_MODULOS           VALORS                         not null,
FK_ROTINAS           VALORI                         not null,
FK_PROGRAMAS         VALORI                         not null,
PK_PARAMETROS_PRG    VALORS                         not null,
DSC_PARAM            DESCRICAO_30RQ                 not null,
NOM_PROP             DESCRICAO_30RQ                 not null,
VAL_PROP             DESCRICAO_30RQ                 not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PARAMETROS_PRG primary key (FK_MODULOS, FK_ROTINAS, FK_PROGRAMAS, PK_PARAMETROS_PRG)
);

grant INSERT,DELETE,UPDATE,SELECT on PARAMETROS_PRG to PUBLIC;

/*==============================================================*/
/* Table: PROGRAMAS                                             */
/*==============================================================*/
create table PROGRAMAS (
FK_MODULOS           VALORS                         not null,
FK_ROTINAS           VALORI                         not null,
PK_PROGRAMAS         VALORI                         not null,
FK_LINGUAGENS        LINGUAGEM                      not null,
FK_RELATORIOS        VALORS,
DSC_PRG              DESCRICAO_30RQ                 not null,
NOM_LIB              DESCRICAO_20                   not null,
FLAG_VIS             FLAG_SIM_NAO                   not null,
FLAG_REL             FLAG_SIM_NAO                   not null,
NOM_FRM              NOME_FORMULARIO,
QTD_PARAM            VALORS,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PROGRAMAS primary key (FK_MODULOS, FK_ROTINAS, PK_PROGRAMAS)
);

grant SELECT,UPDATE,INSERT,DELETE on PROGRAMAS to PUBLIC;

/*==============================================================*/
/* Table: PROGRAMAS_RELATORIOS                                  */
/*==============================================================*/
create table PROGRAMAS_RELATORIOS (
FK_MODULOS           VALORS                         not null,
FK_ROTINAS           VALORI                         not null,
FK_PROGRAMAS         VALORI                         not null,
FK_LINGUAGENS        LINGUAGEM                      not null,
FK_RELATORIOS        VALORS                         not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_PROGRAMAS_RELATORIOS primary key (FK_MODULOS, FK_ROTINAS, FK_PROGRAMAS, FK_LINGUAGENS, FK_RELATORIOS)
);

grant UPDATE,INSERT,DELETE,SELECT on PROGRAMAS_RELATORIOS to PUBLIC;

/*==============================================================*/
/* Table: RELATORIOS                                            */
/*==============================================================*/
create table RELATORIOS (
FK_LINGUAGENS        LINGUAGEM                      not null,
FK_MODULOS           VALORS                         not null,
PK_RELATORIOS        VALORS                         not null,
DSC_REL              DESCRICAO_50,
DSC_GRAPH            DESCRICAO_50,
SQL_REL              BLOB_TEXTO,
SQL_GRAPH            BLOB_TEXTO,
REL_SYS              BLOB_BINARIO,
FLAG_GRAPH           FLAG_SIM_NAO                   not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_RELATORIOS primary key (FK_LINGUAGENS, FK_MODULOS, PK_RELATORIOS)
);

grant SELECT,UPDATE,INSERT,DELETE on RELATORIOS to PUBLIC;

/*==============================================================*/
/* Table: RESOURCES                                             */
/*==============================================================*/
create table RESOURCES (
PK_RESOURCES         VALORS                         not null,
FK_OPERADORES        NOME_OPERADOR,
DSC_RES              BLOB_TEXTO,
OBS_RES              BLOB_TEXTO,
IMAGE_INDEX          VALORS,
OBS_USER             BLOB_TEXTO,
FLAG_ATV             FLAG_SIM_NAO                   not null,
FLAG_SUPER           FLAG_SIM_NAO                   not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_RESOURCES primary key (PK_RESOURCES)
);

grant SELECT,UPDATE,INSERT,DELETE on RESOURCES to PUBLIC;

/*==============================================================*/
/* Table: ROTINAS                                               */
/*==============================================================*/
create table ROTINAS (
PK_ROTINAS           VALORS                         not null,
DSC_ROT              DESCRICAO_30RQ                 not null,
FK_LINGUAGENS        LINGUAGEM                      not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_ROTINAS primary key (PK_ROTINAS)
);

grant SELECT,UPDATE,INSERT,DELETE on ROTINAS to PUBLIC;

/*==============================================================*/
/* Table: SUPORTED_PRINTERS                                     */
/*==============================================================*/
create table SUPORTED_PRINTERS (
PK_SUPORTED_PRINTERS VALORS                         not null,
DSC_IMP              DESCRICAO_30RQ                 not null,
constraint PK_SUPORTED_PRINTERS primary key (PK_SUPORTED_PRINTERS)
);

insert into SUPORTED_PRINTERS 
  (PK_SUPORTED_PRINTERS, DSC_IMP)
 values
   (1, 'Genérica - Arquivo');
insert into SUPORTED_PRINTERS 
  (PK_SUPORTED_PRINTERS, DSC_IMP)
 values
   (2, 'Bematech MP20 FI II');
insert into SUPORTED_PRINTERS 
  (PK_SUPORTED_PRINTERS, DSC_IMP)
 values
   (3, 'Bematech MP40 FI II');
insert into SUPORTED_PRINTERS 
  (PK_SUPORTED_PRINTERS, DSC_IMP)
 values
   (4, 'Sweda');
insert into SUPORTED_PRINTERS 
  (PK_SUPORTED_PRINTERS, DSC_IMP)
 values
   (5, 'Daruma FS345');
   
grant SELECT,UPDATE,INSERT,DELETE on SUPORTED_PRINTERS to PUBLIC;

/*==============================================================*/
/* Table: TIPO_DOCUMENTOS                                       */
/*==============================================================*/
create table TIPO_DOCUMENTOS (
PK_TIPO_DOCUMENTOS   VALORS                         not null,
DSC_TDOC             DESCRICAO_50RQ                 not null,
OBS_TDOC             BLOB_TEXTO,
QTD_ITM              VALORS,
FLAG_EXT             FLAG_SIM_NAO                   not null,
FLAG_TDOC            FLAG_TIPO_DOCUMENTO            not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_TIPO_DOCUMENTOS primary key (PK_TIPO_DOCUMENTOS)
);

grant SELECT,UPDATE,INSERT,DELETE on TIPO_DOCUMENTOS to PUBLIC;

/*==============================================================*/
/* Table: TIPO_DOCUMENTOS_NUMERACAO                             */
/*==============================================================*/
create table TIPO_DOCUMENTOS_NUMERACAO (
FK_EMPRESAS          VALORI                         not null,
FK_TIPO_DOCUMENTOS   VALORS                         not null,
NUM_DOC              VALORI                         not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_TIPO_DOCUMENTOS_NUMERACAO primary key (FK_TIPO_DOCUMENTOS, FK_EMPRESAS)
);

grant SELECT,UPDATE,INSERT,DELETE on TIPO_DOCUMENTOS_NUMERACAO to PUBLIC;

/*==============================================================*/
/* Table: VALOR_CAMPOS                                          */
/*==============================================================*/
create table VALOR_CAMPOS (
FK_LINGUAGENS        LINGUAGEM                      not null,
FK_DICIONARIOS__NA   DESCRICAO_30RQ                 not null,
FK_DICIONARIOS__NC   DESCRICAO_30RQ                 not null,
PK_VALOR_CAMPOS      VALORS                         not null,
CMP_VAL              DESCRICAO_10                   not null,
DSC_VAL              DESCRICAO_30RQ                 not null,
OPE_INC              NOME_OPERADOR_DEF,
DTHR_INC             DATA_HORA_DEF,
OPE_ALT              NOME_OPERADOR,
DTHR_ALT             DATA_HORA,
constraint PK_VALOR_CAMPOS primary key (FK_LINGUAGENS, FK_DICIONARIOS__NA, FK_DICIONARIOS__NC, PK_VALOR_CAMPOS)
);

grant SELECT,UPDATE,INSERT,DELETE on VALOR_CAMPOS to PUBLIC;

/*==============================================================*/
/* View: VW_ACESSOS_MOD_ROT                                     */
/*==============================================================*/
create view VW_ACESSOS_MOD_ROT as
select distinct Ace.FK_MODULOS, Mod.DSC_MOD, Ace.FK_ROTINAS, 
       Rot.DSC_ROT, Ace.FK_OPERADORES, Ace.FLAG_VIS
  from MODULOS Mod, ROTINAS Rot, ACESSOS Ace
 where Mod.PK_MODULOS = Ace.FK_MODULOS 
   and Rot.PK_ROTINAS = Ace.FK_ROTINAS;

grant SELECT on VW_ACESSOS_MOD_ROT to PUBLIC;

/*==============================================================*/
/* View: VW_ACESSOS_PRG                                         */
/*==============================================================*/
create view VW_ACESSOS_PRG as
select Prg.DSC_PRG, Ace.FK_OPERADORES, Ace.FLAG_BRW, Ace.FLAG_INS,
       Ace.FLAG_FND, Ace.FLAG_UPD, Ace.FLAG_DEL, Prg.FK_MODULOS,
       Prg.NOM_LIB, Prg.FK_ROTINAS, Prg.PK_PROGRAMAS, Prg.NOM_FRM,
       Prg.FLAG_VIS, Prg.FK_RELATORIOS, Ope.EMAIL_OPE, Ope.FK_CADASTROS
  from PROGRAMAS Prg, ACESSOS Ace, OPERADORES Ope
 where Ope.PK_OPERADORES = Ace.FK_OPERADORES
   and Prg.FK_MODULOS = Ace.FK_MODULOS
   and Prg.FK_ROTINAS = Ace.FK_ROTINAS
   and Prg.PK_PROGRAMAS = Ace.FK_PROGRAMAS;

grant SELECT on VW_ACESSOS_PRG to PUBLIC;

/*==============================================================*/
/* View: VW_EMPRESAS_PARAM                                      */
/*==============================================================*/
create view VW_EMPRESAS_PARAM as
select Par.FK_EMPRESAS, Par.DSCT_MAX, Par.MRGL_PDR,
       Emp.CNPJ_EMP, Emp.RAZ_SOC, Emp.NOM_FAN, Emp.FK_PAISES,
       Emp.FK_ESTADOS, Emp.FK_MUNICIPIOS, Pgl.NUM_CAS_DEC,
       Pgl.FK_CLIENTES, Pgl.DIAS_ATR, Pgl.QTD_DTOL,
       Pgl.FLAG_LAN_PARC, Pgl.FLAG_MULTI, Pgl.NUM_CAS_DEC_QTD,
       Pgl.VERSAO, Pgl.VER_1, Pgl.VER_2, Pgl.VER_3, Pgl.VER_4
  from PARAMETROS Par, EMPRESAS Emp, PARAMETROS_GLOBAIS Pgl
 where Par.FK_EMPRESAS = Emp.PK_EMPRESAS
   and Pgl.PK_PARAMETROS_GLOBAIS = 1;

grant SELECT on VW_EMPRESAS_PARAM to PUBLIC;

alter table ACESSOS
   add constraint FK_ACESSOS_OPERADOR foreign key (FK_OPERADORES)
      references OPERADORES (PK_OPERADORES)
      on delete cascade
      on update cascade;

alter table ACESSOS
   add constraint FK_ACESSOS_PROGRAMAS foreign key (FK_MODULOS, FK_ROTINAS, FK_PROGRAMAS)
      references PROGRAMAS (FK_MODULOS, FK_ROTINAS, PK_PROGRAMAS)
      on delete cascade
      on update cascade;

alter table DICIONARIOS
   add constraint FK_DICIONARIOS_LINGUAGENS foreign key (FK_LINGUAGENS)
      references LINGUAGENS (PK_LINGUAGENS);

alter table EMPRESA_ATIVA
   add constraint FK_EMPRESA_ATIVA_EMPRESAS foreign key (FK_EMPRESAS)
      references EMPRESAS (PK_EMPRESAS)
      on delete cascade
      on update cascade;

alter table EMPRESA_ATIVA
   add constraint FK_EMPRESA_ATIVA_OPERADORES foreign key (FK_OPERADORES)
      references OPERADORES (PK_OPERADORES)
      on delete cascade
      on update cascade;

alter table HISTORICOS_REGISTROS
   add constraint FK_HISTORICOS_REGIST_HISTORICOS foreign key (FK_HISTORICOS)
      references HISTORICOS (PK_HISTORICOS)
      on delete cascade
      on update cascade;

alter table MASCARAS
   add constraint FK_MASCARAS_LINGUAGENS foreign key (FK_LINGUAGENS)
      references LINGUAGENS (PK_LINGUAGENS);

alter table MENSAGENS
   add constraint FK_MENSAGENS_LINGUAGENS foreign key (FK_LINGUAGENS)
      references LINGUAGENS (PK_LINGUAGENS);

alter table MODULOS
   add constraint FK_MODULOS_LINGUAGENS foreign key (FK_LINGUAGENS)
      references LINGUAGENS (PK_LINGUAGENS);

alter table OPERADORES
   add constraint FK_OPERADORES_EMPRESAS foreign key (FK_EMPRESAS)
      references EMPRESAS (PK_EMPRESAS);

alter table OPERADORES
   add constraint FK_OPERADORES_LINGUAGENS foreign key (FK_LINGUAGENS)
      references LINGUAGENS (PK_LINGUAGENS);

alter table PARAMETROS
   add constraint FK_PARAMETROS_EMPRESAS foreign key (FK_EMPRESAS)
      references EMPRESAS (PK_EMPRESAS)
      on delete cascade
      on update cascade;

alter table PARAMETROS_PRG
   add constraint FK_PARAMETROS_PR_PROGRAMAS foreign key (FK_MODULOS, FK_ROTINAS, FK_PROGRAMAS)
      references PROGRAMAS (FK_MODULOS, FK_ROTINAS, PK_PROGRAMAS)
      on delete cascade
      on update cascade;

alter table PROGRAMAS
   add constraint FK_PROGRAMAS_MODULOS foreign key (FK_MODULOS)
      references MODULOS (PK_MODULOS)
      on delete cascade
      on update cascade;

alter table PROGRAMAS
   add constraint FK_PROGRAMAS_RELATORIOS foreign key (FK_LINGUAGENS, FK_MODULOS, FK_RELATORIOS)
      references RELATORIOS (FK_LINGUAGENS, FK_MODULOS, PK_RELATORIOS);

alter table PROGRAMAS
   add constraint FK_PROGRAMAS_ROTINAS foreign key (FK_ROTINAS)
      references ROTINAS (PK_ROTINAS)
      on delete cascade
      on update cascade;

alter table PROGRAMAS
   add constraint FK_PROGRAMA_LINGUAGENS foreign key (FK_LINGUAGENS)
      references LINGUAGENS (PK_LINGUAGENS);

alter table PROGRAMAS_RELATORIOS
   add constraint FK_PROGRAMAS_REL_PROGRAMAS foreign key (FK_MODULOS, FK_ROTINAS, FK_PROGRAMAS)
      references PROGRAMAS (FK_MODULOS, FK_ROTINAS, PK_PROGRAMAS)
      on delete cascade
      on update cascade;

alter table PROGRAMAS_RELATORIOS
   add constraint FK_PROGRAMAS_REL_RELATORIOS foreign key (FK_LINGUAGENS, FK_MODULOS, FK_RELATORIOS)
      references RELATORIOS (FK_LINGUAGENS, FK_MODULOS, PK_RELATORIOS)
      on delete cascade
      on update cascade;

alter table RESOURCES
   add constraint FK_RESOURCES_OPERADORES foreign key (FK_OPERADORES)
      references OPERADORES (PK_OPERADORES)
      on delete cascade
      on update cascade;

alter table ROTINAS
   add constraint FK_ROTINAS_LINGUAGENS foreign key (FK_LINGUAGENS)
      references LINGUAGENS (PK_LINGUAGENS);

alter table TIPO_DOCUMENTOS_NUMERACAO
   add constraint FK_TIPO_DOCUMENT_PARAMETROS foreign key (FK_EMPRESAS)
      references PARAMETROS (FK_EMPRESAS);

alter table TIPO_DOCUMENTOS_NUMERACAO
   add constraint FK_TIPO_DOCUMENT_TIPO_DOCUMENT foreign key (FK_TIPO_DOCUMENTOS)
      references TIPO_DOCUMENTOS (PK_TIPO_DOCUMENTOS);

alter table VALOR_CAMPOS
   add constraint FK_VALOR_CAMPOS_DICIONARIOS foreign key (FK_LINGUAGENS, FK_DICIONARIOS__NA, FK_DICIONARIOS__NC)
      references DICIONARIOS (FK_LINGUAGENS, PK_DICIONARIOS__NA, PK_DICIONARIOS__NC)
      on delete cascade
      on update cascade;

