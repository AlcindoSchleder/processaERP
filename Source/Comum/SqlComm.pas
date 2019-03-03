unit SqlComm;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 10/04/2003 - DD/MM/YYYY                                      *}
{* Modified: 10/04/2003 - DD/MM/YYYY                                     *}
{* Version: 1.1.0.0                                                      *}
{* License: you can freely use and distribute the included code          *}
{*         for any purpouse, but you cannot remove this copyright        *}
{*         notice. Send me any comments and updates, they are really     *}
{*         appreciated. This software is licensed under MPL License,     *}
{*         see http://www.mozilla.org/MPL/ for datails                   *}
{* Contact: (alcindo@sistemaprocessa.com.br)                             *}
{*         http://www.sistemaprocessa.com.br                             *}
{*                                                                       *}
{*************************************************************************}

interface

const
  NL = #10 + #13;

resourcestring
// sql aux strings
  GlobalSelectCountF    = 'select Count(*) from ';
  GlobalSelectCount     = 'select Count(*)';
  GlobalSelect          = 'select * from ';
  GlobalWhere           = ' where ';
  SqlAnd                = '   and ';
  GlobalLike            = ' like ''';
  GlobalNull            = ' is Null ';
  GlobalOrder           = ' order by ';
  GlobalOccurs          = 'Ocorrenc.txt';
// Commom Sql for all modules
  SqlUserLogin = 'select * from OPERADORES where PK_OPERADORES = :FkOperadores';

  SqlEmpresa    = 'select PK_EMPRESAS, RAZ_SOC, FK_PAISES, ' + NL +
                  '       LOGO_EMP, FLAG_TIMG '              + NL +
                  '  from EMPRESAS '                         + NL +
                  ' where ((PK_EMPRESAS = :PkEmpresas) '   + NL +
                  '    or (0            = :PkEmpresas)) '  + NL +
                  ' order by RAZ_SOC';

  SqlParamEmp   = 'select * from VW_EMPRESAS_PARAM where FK_EMPRESAS = :Empresa';

  SqlAutorizar  = 'select * from OPERADORES where PK_OPERADORES = :PkOperadores';

  SqlGravaHistorico = 'execute procedure GRAVA_HISTORICOS ' + NL +
                      '  (:CODEMPR, :NOMOPE, :NOMFORM, :DSCOPE, :CODOPE, :NOMARQ)';

  SqlDictionary  = 'select * from DICIONARIOS              ' + NL +
                   ' where FK_LINGUAGENS      = :Linguagem ' + NL +
                   '   and PK_DICIONARIOS__NA = :NameFile  ' + NL +
                   ' order by POS_FLD';

  SqlDicField    = 'select * from DICIONARIOS              ' + NL +
                   ' where FK_LINGUAGENS      = :Linguagem ' + NL +
                   '   and PK_DICIONARIOS__NA = :NameFile  ' + NL +
                   '   and PK_DICIONARIOS__NC = :NameField ' + NL +
                   ' order by POS_FLD';

  SqlValorCampos = 'select * from VALOR_CAMPOS             ' + NL +
                   ' where FK_LINGUAGENS      = :Linguagem ' + NL +
                   '   and FK_DICIONARIOS__NA = :NameFile  ' + NL +
                   '   and FK_DICIONARIOS__NC = :NameField ';

  SqlSelCnstMsg  = 'select * from MENSAGENS ' + NL +
                   ' where FK_LINGUAGENS = :Linguagem ' + NL +
                   '   and NOM_CNST      = :NomCnst   ';

  SqlSelFromMsg  = 'select * from MENSAGENS                   ' + NL +
                   ' where FK_LINGUAGENS = :Linguagem         ' + NL +
                   '   and FK_MODULOS    = :Modulo            ' + NL +
                   '   and FK_ROTINAS    = :Rotina            ' + NL +
                   '   and FK_PROGRAMAS  = :Programa          ' + NL +
                   ' order by NOM_CNST';

  SqlFindAccess  = 'select Count(*) as QTD           ' + NL +
                   '  from VW_ACESSOS_PRG            ' + NL +
                   ' where NOM_FRM       = :Form ' + NL +
                   '   and FK_OPERADORES = :Operador';

  SqlGetAccess        = 'select * from VW_ACESSOS_PRG ' + NL +
                        ' where NOM_FRM       = :NomFrm ' + NL +
                        '   and FK_OPERADORES = :FkOperadores';

  SqlGetProgramLib    = 'select * ' + NL +
                        '  from PROGRAMAS ' + NL +
                        ' where FK_MODULOS = :FkModulos '  + NL +
                        '   and NOM_FRM    = :NomFrm ';

  SqlDscPrg           = 'select DSC_PRG from PROGRAMAS where NOM_FRM = :NameForm';

  SqlCadastros        = 'select * from CADASTROS ' + NL +
                        ' where PK_CADASTROS = :Cadastro             ' + NL +
                        ' order by RAZ_SOC';

  SqlOperadores       = 'select * from OPERADORES         order by PK_OPERADORES';

  SqlParametroGlobais = 'select * from PARAMETRO_GLOBAIS';

  SqlFuncionarios     = 'select * from VW_FUNCIONARIOS    order by RAZ_SOC';

  SqlAdministracao    = 'select * from VW_ADMINISTRACAO   order by RAZ_SOC';

  SqlFornecedores     = 'select * from VW_FORNECEDORES    order by RAZ_SOC';

  SqlTecnicos         = 'select * from VW_TECNICOS        order by RAZ_SOC';

  SqlTransportadoras  = 'select * from VW_TRANSPORTADORAS order by RAZ_SOC';

  SqlVendedores       = 'select * from VW_VENDEDORES         ' + NL +
                        ' union                              ' + NL +
                        'select * from VW_REPRESENTANTES     ' + NL +
                        ' order by 2 ';

  SqlRepresentantes   = 'select * from VW_REPRESENTANTES  order by RAZ_SOC';

  SqlClientes         = 'select * from VW_CLIENTES order by RAZ_SOC';

  SqlNMClientes       = 'select PK_CADASTROS, RAZ_SOC, EMAIL_CAD ' + NL +
                        '  from VW_CLIENTES order by RAZ_SOC';

  SqlCityPostalCode   = 'select * from MUNICIPIOS ' + NL +
                        ' where CEP_MUN = :CepMun';

  SqlDistrictPostalCode = 'select * from BAIRROS ' + NL +
                          ' where CEP_BAI = :CepBai';

  SqlLocalityPostalCode = 'select Loc.FK_PAISES, Loc.FK_ESTADOS, Loc.FK_MUNICIPIOS, ' + NL +
                          '       Loc.DSC_LOC, Loc.CMPL_LOC, Bai.DSC_BAI, ' + NL +
                          '       Tpe.DSC_TPE, Loc.CEP_LOC, Loc.FK_BAIRROS ' + NL +
                          '  from LOGRADOUROS Loc                       ' + NL +
                          '  left outer join BAIRROS Bai                ' + NL +
                          '    on Bai.FK_PAISES     = Loc.FK_PAISES     ' + NL +
                          '   and Bai.FK_ESTADOS    = Loc.FK_ESTADOS    ' + NL +
                          '   and Bai.FK_MUNICIPIOS = Loc.FK_MUNICIPIOS ' + NL +
                          '   and Bai.PK_BAIRROS    = Loc.FK_BAIRROS    ' + NL +
                          '  left outer join TIPO_ENDERECOS Tpe         ' + NL +
                          '    on Tpe.PK_TIPO_ENDERECOS = Loc.FK_TIPO_ENDERECOS ' + NL +
                          ' where Loc.CEP_LOC = :Cep                    ' + NL +
                          ' order by Loc.DSC_LOC';

  SqlRelProgram         = 'select * from RELATORIOS          ' + NL +
                          ' where FK_LINGUAGENS = :Linguagem ' + NL +
                          '   and FK_MODULOS    = :Modulo    ' + NL +
                          '   and PK_RELATORIOS = :Relatorio ';

  SqlCompanyReport      = 'select Emp.*, Pais.DSC_PAIS, Est.DSC_UF, Mun.DSC_MUN ' + NL +
                          '  from EMPRESAS Emp, PAISES Pais, ' + NL +
                          '       ESTADOS Est, MUNICIPIOS Mun ' + NL +
                          ' where Emp.PK_EMPRESAS   = :PkEmpresas ' + NL +
                          '   and Pais.PK_PAISES    = Emp.FK_PAISES ' + NL +
                          '   and Est.FK_PAISES     = Emp.FK_PAISES ' + NL +
                          '   and Est.PK_ESTADOS    = Emp.FK_ESTADOS ' + NL +
                          '   and Mun.FK_PAISES     = Emp.FK_PAISES ' + NL +
                          '   and Mun.FK_ESTADOS    = Emp.FK_ESTADOS ' + NL +
                          '   and Mun.PK_MUNICIPIOS = Emp.FK_MUNICIPIOS';

implementation

end.
