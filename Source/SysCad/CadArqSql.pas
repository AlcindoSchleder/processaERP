unit CadArqSql;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 10/04/2003 - DD/MM/YYYY                                      *}
{* Modified: 10/04/2003 - DD/MM/YYYY                                     *}
{* Version: 1.0.0.0                                                      *}
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

uses CmmConst;

resourcestring
  GenMunicipios         = 'select (Max(PK_MUNICIPIOS) + 1) as PK_MUNICIPIOS ' + NL +
                          '  from MUNICIPIOS  '                               + NL +
                          ' where FK_PAISES  = :FkPaises '                    + NL +
                          '   and FK_ESTADOS = :FkEstados';

  GenBairros            = 'select (Max(PK_BAIRROS) + 1) as PK_BAIRROS ' + NL +
                          '  from BAIRROS  '                            + NL +
                          ' where FK_PAISES     = :FkPaises '           + NL +
                          '   and FK_ESTADOS    = :FkEstados '          + NL +
                          '   and FK_MUNICIPIOS = :FkMunicipios';
  GenLogradouro         = 'select (Max(PK_LOGRADOUROS) + 1) as PK_LOGRADOUROS ' + NL +
                          '  from LOGRADOUROS  '                                + NL +
                          ' where FK_PAISES     = :FkPaises '                   + NL +
                          '   and FK_ESTADOS    = :FkEstados '                  + NL +
                          '   and FK_MUNICIPIOS = :FkMunicipios'                + NL +
                          '   and FK_BAIRROS    = :FkBairros';

  SqlDelContacts   = 'delete from CADASTROS ' + NL +
                     ' where PK_CADASTROS  = :PkCadastros';

  SqlCadEvents     = 'select * from CADASTROS_EVENTOS ' + NL +
                     ' where FK_CADASTROS = :FkCadastros';

  SqlDelEvents     = 'delete from CADASTROS_EVENTOS ' + NL +
                     ' where FK_CADASTROS = :FkCadastros';

  SqlInsEvents     = 'insert into CADASTROS_EVENTOS '                   + NL +
                     '  (FK_CADASTROS, PK_CADASTROS_EVENTOS, DSC_EVT, ' + NL +
                     '   FLAG_INC_EVT) '                                + NL +
                     'values '                                          + NL +
                     '  (:FkCadastros, :PkCadastrosEventos, :DscEvt, :FlagIncEvt)';

  SqlPkCadastros   = 'select Cad.*, Tal.DSC_ALIAS, Pais.DSC_PAIS, '  + NL +
                     '       Est.DSC_UF, Mun.DSC_MUN '               + NL +
                     '  from CADASTROS Cad '                         + NL +
                     '  left outer join TIPO_ALIAS Tal '             + NL +
                     '    on Tal.PK_TIPO_ALIAS = Cad.FK_TIPO_ALIAS ' + NL +
                     '  join PAISES Pais '                           + NL +
                     '    on Pais.PK_PAISES    = Cad.FK_PAISES '     + NL +
                     '  join ESTADOS Est '                           + NL +
                     '    on Est.FK_PAISES     = Cad.FK_PAISES '     + NL +
                     '   and Est.PK_ESTADOS    = Cad.FK_ESTADOS '    + NL +
                     '  join MUNICIPIOS Mun '                        + NL +
                     '    on Mun.FK_PAISES     = Cad.FK_PAISES '     + NL +
                     '   and Mun.FK_ESTADOS    = Cad.FK_ESTADOS '    + NL +
                     '   and Mun.PK_MUNICIPIOS = Cad.FK_MUNICIPIOS ' + NL +
                     ' where Cad.PK_CADASTROS = :PkCadastros';

  SqlAllContacts   = 'select Cad.PK_CADASTROS, Cad.RAZ_SOC, Tal.DSC_ALIAS, ' + NL +
                     '       Cnt.DSC_CNT, Cnt.CNT_CNT, Cnt.FLAG_DEF ' + NL +
                     '  from CADASTROS Cad ' + NL +
                     '  left outer join TIPO_ALIAS Tal ' + NL +
                     '    on Tal.PK_TIPO_ALIAS = Cad.FK_TIPO_ALIAS ' + NL +
                     '  join CADASTROS_CONTATOS Cnt ' + NL +
                     '    on Cnt.FK_CADASTROS  = Cad.PK_CADASTROS ' + NL +
                     ' where Cad.FK_CONTATOS   = :PkCadastros ' + NL +
                     ' order by Cad.RAZ_SOC';


  SqlCadCategory   = 'select Cat.PK_CATEGORIAS, Cat.DSC_CAT, FLAG_CAT, ' + NL +
                     '       Vin.FK_CADASTROS, Vin.FLAG_ATV '            + NL +
                     '  from CADASTROS Cad, VINCULOS_CAD_CAT Vin, '      + NL +
                     '       CATEGORIAS Cat '                            + NL +
                     ' where Cad.PK_CADASTROS  = :PkCadastros '          + NL +
                     '   and Vin.FK_CADASTROS  = Cad.PK_CADASTROS '      + NL +
                     '   and Cat.PK_CATEGORIAS = Vin.FK_CATEGORIAS '     + NL +
                     ' order by DSC_CAT';

  SqlCadInternet   = 'select * from CADASTROS_INTERNET '     + NL +
                     ' where FK_CADASTROS  = :FkCadastros';

  SqlDelInternet   = 'delete from CADASTROS_INTERNET '     + NL +
                     ' where FK_CADASTROS  = :FkCadastros';

  SqlInsInternet   = 'insert into CADASTROS_INTERNET '                   + NL +
                     '  (FK_CADASTROS, PK_CADASTROS_INTERNET, END_CNT, ' + NL +
                     '   DSC_END, FLAG_DEF) '             + NL +
                     'values '                                           + NL +
                     '  (:FkCadastros, :PkCadastrosInternet, :EndCnt, '  + NL +
                     '   :DscEnd, :FlagDef)';

  SqlCadContacts   = 'select * from CADASTROS_CONTATOS ' + NL +
                     ' where FK_CADASTROS = :FkCadastros';

  SqlDelCadCnt     = 'delete from CADASTROS_CONTATOS ' + NL +
                     ' where FK_CADASTROS = :FkCadastros';

  SqlInsCadCnt     = 'insert into CADASTROS_CONTATOS '                   + NL +
                     '  (FK_CADASTROS, PK_CADASTROS_CONTATOS, DSC_CNT, ' + NL +
                     '   CNT_CNT, FLAG_DEF) '                          + NL +
                     'values '                                           + NL +
                     '  (:FkCadastros, :PkCadastrosContatos, :DscCnt, '  + NL +
                     '   :CntCnt, :FlagDef)';

  SqlPhoneList     = 'select Cad.RAZ_SOC, Ccn.FLAG_MCNT, Ccn.FLAG_DEF, Ccn.DSC_CNT ' + NL +
                     '  from CADASTROS Cad, CADASTROS_CONTATOS Ccn ' + NL +
                     ' where Cad.FK_CONTATOS  = :PkCadastros ' + NL +
                     '   and Ccn.FK_CADASTROS = Cad.PK_CADASTROS ' + NL +
                     ' order by Cad.RAZ_SOC, Ccn.DSC_CNT';

  SqlDelCategories = 'delete from VINCULOS_CAD_CAT '        + NL +
                     ' where FK_CADASTROS  = :FkCadastros';

  SqlDelCategory   = 'delete from VINCULOS_CAD_CAT '        + NL +
                     ' where FK_CADASTROS  = :FkCadastros ' + NL +
                     '   and FK_CATEGORIAS = :FkCategorias ';

  SqlInsCategory   = 'insert into VINCULOS_CAD_CAT '        + NL +
                     '  (FK_CADASTROS, FK_CATEGORIAS, FK_EMPRESAS, FLAG_ATV) ' + NL +
                     'values ' + NL +
                     '  (:FkCadastros, :FkCategorias, :FkEmpresas, :FlagAtv)';

  SqlUpdCategory   = 'update VINCULOS_CAD_CAT set '         + NL +
                     '       FLAG_ATV      = :FlagAtv '    + NL +
                     ' where FK_CADASTROS  = :FkCadastros ' + NL +
                     '   and FK_CATEGORIAS = :FkCategorias ';

  SqlOwnerImage    = 'select FK_CADASTROS, IMG_CAD, FLAG_TIMG ' + NL +
                     '  from CADASTROS_IMAGENS ' + NL +
                     ' where FK_CADASTROS = :FkCadastros ';

  SqlOwnerInsertIm = 'insert into CADASTROS_IMAGENS '   + NL +
                     '  (FK_CADASTROS, FLAG_TIMG, IMG_CAD) ' + NL +
                     'values ' + NL +
                     '  (:FkCadastros, :FlagTImg, :ImgCad)';

  SqlOwnerUpdateIm = 'update CADASTROS_IMAGENS set '   + NL +
                     '       FLAG_TIMG    = :FlagTImg, ' + NL +
                     '       IMG_CAD      = :ImgCad ' + NL +
                     ' where FK_CADASTROS = :FkCadastros';

  SqlOwnerObs      = 'select FK_CADASTROS, OBS_CAD ' + NL +
                     '  from CADASTROS_OBSERVACOES ' + NL +
                     ' where FK_CADASTROS = :FkCadastros ';

  SqlOwnerInsertOb = 'insert into CADASTROS_OBSERVACOES '   + NL +
                     ' (FK_CADASTROS, OBS_CAD) ' + NL +
                     'values ' + NL +
                     ' (:FkCadastros, :ObsCad)';

  SqlOwnerUpdateOb      = 'update CADASTROS_OBSERVACOES set ' + NL +
                          '       OBS_CAD      = :ObsCad ' + NL +
                          ' where FK_CADASTROS = :FkCadastros';

  SqlEmployee           = 'select * from FUNCIONARIOS ' + NL +
                          ' where FK_CADASTROS = :FkCadastros';

  SqlCompanies          = 'select RAZ_SOC, PK_CADASTROS, FLAG_TCAD ' + NL +
                          '  from CADASTROS '                        + NL +
                          ' where FLAG_TCAD = 0 '                    + NL +
                          '   and FK_CONTATOS is null '              + NL +
                          ' order by RAZ_SOC';

  SqlGenPkCountry       = 'select R_PK_PAISES as PK_PAISES ' + NL +
                          '  from STP_GET_PK_PAISES';

  SqlCountries          = 'select * from PAISES ' + NL +
                          ' where ((FLAG_ATU = :FlagAtu) ' + NL +
                          '    or ( -1       = :FlagAtu)) ' + NL +
                          ' order by DSC_PAIS';

  SqlCountry            = 'select * from PAISES ' + NL +
                          ' where PK_PAISES = :PkPaises';

  SqlDeleteCountry      = 'delete from PAISES ' + NL +
                          ' where PK_PAISES = :PkPaises';

  SqlInsertCountry      = 'insert into PAISES ' + NL +
                          '  (PK_PAISES, DSC_PAIS, FK_LINGUAGENS, NAC_PAIS, ' + NL +
                          '   FK_TIPO_MOEDAS, FLAG_ACM)' + NL +
                          'values ' + NL +
                          '  (:PkPaises, :DscPais, :FkLinguagens, :NacPais, ' + NL +
                          '   :FkTipoMoedas, :FlagAcm)';

  SqlUpdateCountry      = 'update PAISES set ' + NL +
                          '       DSC_PAIS       = :DscPais, ' + NL +
                          '       FK_LINGUAGENS  = :FkLinguagens, ' + NL +
                          '       NAC_PAIS       = :NacPais, ' + NL +
                          '       FK_TIPO_MOEDAS = :FkTipoMoedas, ' + NL +
                          '       FLAG_ACM       = :FlagAcm ' + NL +
                          ' where PK_PAISES = :PkPaises';

  SqlStates             = 'select * from ESTADOS '        + NL +
                          ' where FK_PAISES = :FkPaises ' + NL +
                          ' order by DSC_UF';

  SqlState              = 'select * from ESTADOS '        + NL +
                          ' where FK_PAISES  = :FkPaises ' + NL +
                          '   and PK_ESTADOS = :PkEstados ';

  SqlDeleteState        = 'delete from ESTADOS '        + NL +
                          ' where FK_PAISES  = :FkPaises ' + NL +
                          '   and PK_ESTADOS = :PkEstados ';

  SqlInsertState        = 'insert into ESTADOS '        + NL +
                          '  (FK_PAISES, PK_ESTADOS, DSC_UF, FK_CARGAS_REGIOES, ' + NL +
                          '   KC_MUNICIPIOS) ' + NL +
                          'values ' + NL +
                          '  (:FkPaises, :PkEstados, :DscUf, :FkCargasRegioes, 0)';

  SqlUpdateState        = 'update ESTADOS set ' + NL +
                          '       DSC_UF            = :DscUf, ' + NL +
                          '       FK_CARGAS_REGIOES = :FkCargasRegioes ' + NL +
                          ' where FK_PAISES         = :FkPaises ' + NL +
                          '   and PK_ESTADOS        = :PkEstados ';

  SqlGenPkCity          = 'select R_PK_MUNICIPIOS as PK_MUNICIPIOS ' + NL +
                          '  from STP_GET_PK_MUNICIPIOS(:FkPaises, :FkEstados)';

  SqlCities             = 'select * from MUNICIPIOS '       + NL +
                          ' where FK_PAISES  = :FkPaises  ' + NL +
                          '   and FK_ESTADOS = :FkEstados ' + NL +
                          ' order by DSC_MUN';

  SqlCity               = 'select * from MUNICIPIOS ' + NL +
                          ' where FK_PAISES     = :FkPaises ' + NL +
                          '   and FK_ESTADOS    = :FkEstados ' + NL +
                          '   and PK_MUNICIPIOS = :PkMunicipios';

  SqlDeleteCity         = 'delete from MUNICIPIOS ' + NL +
                          ' where FK_PAISES     = :FkPaises ' + NL +
                          '   and FK_ESTADOS    = :FkEstados ' + NL +
                          '   and PK_MUNICIPIOS = :PkMunicipios';

  SqlInsertCity         = 'insert into MUNICIPIOS ' + NL +
                          '  (FK_PAISES, FK_ESTADOS, PK_MUNICIPIOS, DSC_MUN, ' + NL +
                          '   FK_CARGAS_REGIOES, ALQ_ISS, CEP_MUN, FLAG_CAP, ' + NL +
                          '   KC_BAIRROS) ' + NL +
                          'values ' + NL +
                          '  (:FkPaises, :FkEstados, :PkMunicipios, :DscMun, ' + NL +
                          '   :FkCargasRegioes, :AlqIss, :CepMun, :FlagCap, 0)';

  SqlUpdateCity         = 'update MUNICIPIOS set ' + NL +
                          '       DSC_MUN           = :DscMun, ' + NL +
                          '       FK_CARGAS_REGIOES = :FkCargasRegioes, ' + NL +
                          '       ALQ_ISS           = :AlqIss, ' + NL +
                          '       CEP_MUN           = :CepMun, ' + NL +
                          '       FLAG_CAP          = :FlagCap ' + NL +
                          ' where FK_PAISES         = :FkPaises ' + NL +
                          '   and FK_ESTADOS        = :FkEstados ' + NL +
                          '   and PK_MUNICIPIOS     = :PkMunicipios';

  SqlPrinterTaxes       = 'select Spp.PK_SUPORTED_PRINTERS, Spp.DSC_IMP, ' + NL +
                          '       Mal.COD_ISS_ECF ' + NL +
                          '  from MUNICIPIOS_ALIQUOTAS Mal ' + NL +
                          '  left outer join SUPORTED_PRINTERS Spp ' + NL +
                          '    on Spp.PK_SUPORTED_PRINTERS = Mal.FK_SUPORTED_PRINTERS ' + NL +
                          ' where Mal.FK_PAISES     = :FkPaises ' +
                          '   and Mal.FK_ESTADOS    = :FkEstados ' + NL +
                          '   and Mal.FK_MUNICIPIOS = :FkMunicipios ' + NL +
                          ' order by Spp.DSC_IMP';

  SqlDeletePrinterTaxes = 'delete from MUNICIPIOS_ALIQUOTAS ' + NL +
                          ' where FK_PAISES     = :FkPaises ' +
                          '   and FK_ESTADOS    = :FkEstados ' + NL +
                          '   and FK_MUNICIPIOS = :FkMunicipios ';

  SqlInsertPrinterTaxes = 'insert into MUNICIPIOS_ALIQUOTAS ' + NL +
                          '  (FK_PAISES, FK_ESTADOS, FK_MUNICIPIOS, COD_ISS_ECF) ' + NL +
                          'values ' + NL +
                          '  (:FkPaises, :FkEstados, :FkMunicipios, :CodIssEcf)';

  SqlGenPkDistrict      = 'select R_PK_BAIRROS as PK_BAIRROS ' + NL +
                          '  from STP_GET_PK_BAIRROS(:FkPaises, :FkEstados, :FkMunicipios)';

  SqlDistrict           = 'select * from BAIRROS ' + NL +
                          ' where FK_PAISES     = :FkPaises ' +
                          '   and FK_ESTADOS    = :FkEstados ' + NL +
                          '   and FK_MUNICIPIOS = :FkMunicipios ' + NL +
                          '   and PK_BAIRROS    = :PkBairros';

  SqlDeleteDistrict     = 'delete from BAIRROS ' + NL +
                          ' where FK_PAISES     = :FkPaises ' +
                          '   and FK_ESTADOS    = :FkEstados ' + NL +
                          '   and FK_MUNICIPIOS = :FkMunicipios ' + NL +
                          '   and PK_BAIRROS    = :PkBairros';

  SqlInsertDistrict     = 'insert into BAIRROS ' + NL +
                          '  (FK_PAISES, FK_ESTADOS, FK_MUNICIPIOS, PK_BAIRROS, ' + NL +
                          '   DSC_BAI, CEP_BAI) ' + NL +
                          'values ' + NL +
                          '  (:FkPaises, :FkEstados, :FkMunicipios, :PkBairros, ' + NL +
                          '   :DscBai, :CepBai)';

  SqlUpdateDistrict     = 'update BAIRROS set ' + NL +
                          '       DSC_BAI = :DscBai, ' + NL +
                          '       CEP_BAI = :CepBai ' + NL +
                          ' where FK_PAISES     = :FkPaises ' +
                          '   and FK_ESTADOS    = :FkEstados ' + NL +
                          '   and FK_MUNICIPIOS = :FkMunicipios ' + NL +
                          '   and PK_BAIRROS    = :PkBairros';

  SqlGenPkLocales       = 'select R_PK_LOGRADOUROS as PK_LOGRADOUROS ' + NL +
                          '  from STP_GET_PK_LOGRADOUROS(:FkPaises, :FkEstados, ' + NL +
                          '         :FkMunicipios, :FkBairros)';

  SqlLocales            = 'select * from LOGRADOUROS ' + NL +
                          ' where FK_PAISES     = :FkPais             ' + NL +
                          '   and FK_ESTADOS    = :FkEstado           ' + NL +
                          '   and FK_MUNICIPIOS = :FkMunicipio        ' + NL +
                          '   and FK_BAIRROS    = :FkBairro           ' + NL +
                          ' order by DSC_LOC';

  SqlLocale             = 'select * from LOGRADOUROS ' + NL +
                          ' where FK_PAISES      = :FkPaiss ' + NL +
                          '   and FK_ESTADOS     = :FkEstados ' + NL +
                          '   and FK_MUNICIPIOS  = :FkMunicipios ' + NL +
                          '   and FK_BAIRROS     = :FkBairros ' + NL +
                          '   and PK_LOGRADOUROS = :PkLogradouros';

  SqlDeleteLocale       = 'delete into LOGRADOUROS ' + NL +
                          ' where FK_PAISES      = :FkPaiss ' + NL +
                          '   and FK_ESTADOS     = :FkEstados ' + NL +
                          '   and FK_MUNICIPIOS  = :FkMunicipios ' + NL +
                          '   and FK_BAIRROS     = :FkBairros ' + NL +
                          '   and PK_LOGRADOUROS = :PkLogradouros';

  SqlInsertLocale       = 'insert into LOGRADOUROS ' + NL +
                          '  (FK_PAISES, FK_ESTADOS, FK_MUNICIPIOS, FK_BAIRROS, ' + NL +
                          '   PK_LOGRADOUROS, DSC_LOC, CEP_LOC, NUM_INI, ' + NL +
                          '   NUM_FIN, FLAG_LADO) ' + NL +
                          'values ' + NL +
                          '  (:FkPaises :FkEstados, :FkMunicipios , :FkBairros, ' + NL +
                          '   :PkLogradouros, :DscLoc, :CepLoc, :NumIni, ' + NL +
                          '   :NumFin, :FlagLado';

  SqlUpdateLocale       = 'update LOGRADOUROS set ' + NL +
                          '       DSC_LOC        = :DscLoc, ' + NL +
                          '       CEP_LOC        = :CepLoc, ' + NL +
                          '       NUM_INI        = :NumIni, ' + NL +
                          '       NUM_FIN        = :NumFin, ' + NL +
                          '       FLAG_LADO      = :FlagLado ' + NL +
                          ' where FK_PAISES      = :FkPaiss ' + NL +
                          '   and FK_ESTADOS     = :FkEstados ' + NL +
                          '   and FK_MUNICIPIOS  = :FkMunicipios ' + NL +
                          '   and FK_BAIRROS     = :FkBairros ' + NL +
                          '   and PK_LOGRADOUROS = :PkLogradouros';

  SqlGenPkTypeAddress   = 'select R_PK_TIPO_ENDERECOS as PK_TIPO_ENDERECOS ' + NL +
                          '  from STP_GET_PK_TIPO_ENDERECOS';

  SqlTypeAddresses      = 'select * from TIPO_ENDERECOS  ' + NL +
                          ' order by DSC_TPE';

  SqlTypeAddress        = 'select * from TIPO_ENDERECOS ' + NL +
                          ' where PK_TIPO_ENDERECOS = :PkTipoEnderecos';

  SqlDeleteTypeAddress  = 'delete from TIPO_ENDERECOS ' + NL +
                          ' where PK_TIPO_ENDERECOS = :PkTipoEnderecos';

  SqlInsertTypeAddress  = 'insert into TIPO_ENDERECOS ' + NL +
                          '  (PK_TIPO_ENDERECOS, DSC_TPE) ' + NL +
                          ' values ' + NL +
                          '  (:PkTipoEnderecos, :DscTpe)';

  SqlUpdateTypeAddress  = 'update TIPO_ENDERECOS set ' + NL +
                          '       DSC_TPE = :DscTpe ' + NL +
                          ' where PK_TIPO_ENDERECOS = :PkTipoEnderecos';

  SqlGenPkRegions       = 'select R_PK_CARGAS_REGIOES as PK_CARGAS_REGIOES ' + NL +
                          '  from STP_GET_PK_CARGAS_REGIOES';

  SqlRegions            = 'select * from CARGAS_REGIOES  ' + NL +
                          ' order by DSC_REG';

  SqlRegion             = 'select * from CARGAS_REGIOES  ' + NL +
                          ' where PK_CARGAS_REGIOES = :PkCargasRegioes';

  SqlDeleteRegion       = 'delete from CARGAS_REGIOES  ' + NL +
                          ' where PK_CARGAS_REGIOES = :PkCargasRegioes';

  SqlInsertRegion       = 'insert into CARGAS_REGIOES  ' + NL +
                          '  (PK_CARGAS_REGIOES, DSC_REG, REF_REG, FLAG_GENERIC) ' + NL +
                          'values ' + NL +
                          '  (:PkCargasRegioes, :DscReg, :RefReg, :FlagGeneric)';

  SqlUpdateRegion       = 'update CARGAS_REGIOES set ' + NL +
                          '       DSC_REG           = :DscReg, ' + NL +
                          '       REF_REG           = :RefReg, ' + NL +
                          '       FLAG_GENERIC      = :FlagGeneric ' + NL +
                          ' where PK_CARGAS_REGIOES = :PkCargasRegioes';

  SqlTypeComissions     = 'select * from TIPO_COMISSOES ' + NL +
                          ' order by DSC_COM';

  SqlTypeComission      = 'select * from TIPO_COMISSOES ' + NL +
                          ' where PK_TIPO_COMISSOES = :PkTipoComissoes';

  SqlGenTypeComissions  = 'select R_PK_TIPO_COMISSOES as PK_TIPO_COMISSOES ' + NL +
                          '  from STP_GET_PK_TIPO_COMISSOES';

  SqlDelTypeComission   = 'delete from TIPO_COMISSOES ' + NL +
                          ' where PK_TIPO_COMISSOES = :PkTipoComissoes';

  SqlInsTypeComission   = 'insert into TIPO_COMISSOES ' + NL +
                          '  (PK_TIPO_COMISSOES, FK_FINANCEIRO_CONTAS__CR, ' + NL +
                          '   FK_FINANCEIRO_CONTAS__DB, FLAG_TCOM, DSC_COM, ' + NL +
                          '   PERC_COM) ' + NL +
                          'values ' + NL +
                          '  (:PkTipoComissoes, :FkFinanceiroContsCr, ' + NL +
                          '   :FkFinanceiroContasDB, :FlagTCom, :DscCom, ' + NL +
                          '   :PercCom)';

  SqlUpdTypeComission   = 'update TIPO_COMISSOES set ' + NL +
                          '       FK_FINANCEIRO_CONTAS__CR = :FkFinanceiroContsCr, ' + NL +
                          '       FK_FINANCEIRO_CONTAS__DB = :FkFinanceiroContsDb, ' + NL +
                          '       FLAG_TCOM                = :FlagTCom, ' + NL +
                          '       DSC_COM                  = :DscCom, ' + NL +
                          '       PERC_COM                 = :PercCom ' + NL +
                          ' where PK_TIPO_COMISSOES        = :PkTipoComissoes';

  SqlReductComission01  = 'select Cast(0 as smallint) as FK_TIPO_COMISSOES, ' + NL +
                          '       Cast(-1 as smallint) as PK_COMISSOES_REDUCOES, ' + NL +
                          '       Cast(''Prazo Médio'' as varchar(30)) as DSC_RED, ' + NL +
                          '       Cast(0 as smallint) as PK_COMISSOES_FAIXAS, ' + NL +
                          '       Cast(0.0 as numeric(11, 04)) as VLR_INI, ' + NL +
                          '       Cast(0.0 as numeric(11, 04)) as VLR_FIN, ' + NL +
                          '       Cast(0.0 as numeric(05, 02)) as PERC_RED ' + NL +
                          '  from PARAMETROS_GLOBAIS Par ' + NL +
                          ' where Par.PK_PARAMETROS_GLOBAIS = 1 ' + NL +
                          'union ' + NL;
  SqlReductComission02  = 'select Crd.FK_TIPO_COMISSOES, Crd.PK_COMISSOES_REDUCOES, ' + NL +
                          '       Crd.DSC_RED, Cfx.PK_COMISSOES_FAIXAS, Cfx.VLR_INI, ' + NL +
                          '       Cfx.VLR_FIN, Cfx.PERC_RED ' + NL +
                          '  from COMISSOES_REDUCOES Crd ' + NL +
                          '  left outer join COMISSOES_FAIXAS Cfx ' + NL +
                          '    on Cfx.FK_TIPO_COMISSOES     = Crd.FK_TIPO_COMISSOES ' + NL +
                          '   and Cfx.FK_COMISSOES_REDUCOES = Crd.PK_COMISSOES_REDUCOES ' + NL +
                          ' where Crd.FK_TIPO_COMISSOES     = :FkTipoComissoes ' + NL +
                          '   and Crd.PK_COMISSOES_REDUCOES = 0 ' + NL +
                          'union ' + NL;
  SqlReductComission03  = 'select Cast(0 as smallint) as FK_TIPO_COMISSOES, ' + NL +
                          '       Cast(-1 as smallint) as PK_COMISSOES_REDUCOES, ' + NL +
                          '       Cast(''Descontos Concedidos'' as varchar(30)) as DSC_RED, ' + NL +
                          '       Cast(0 as smallint) as PK_COMISSOES_FAIXAS, ' + NL +
                          '       Cast(0.0 as numeric(11, 04)) as VLR_INI, ' + NL +
                          '       Cast(0.0 as numeric(11, 04)) as VLR_FIN, ' + NL +
                          '       Cast(0.0 as numeric(05, 02)) as PERC_RED ' + NL +
                          '  from PARAMETROS_GLOBAIS Par ' + NL +
                          ' where Par.PK_PARAMETROS_GLOBAIS = 1 ' + NL +
                          'union ' + NL;
  SqlReductComission04  = 'select Crd.FK_TIPO_COMISSOES, Crd.PK_COMISSOES_REDUCOES, ' + NL +
                          '       Crd.DSC_RED, Cfx.PK_COMISSOES_FAIXAS, Cfx.VLR_INI, ' + NL +
                          '       Cfx.VLR_FIN, Cfx.PERC_RED ' + NL +
                          '  from COMISSOES_REDUCOES Crd ' + NL +
                          '  left outer join COMISSOES_FAIXAS Cfx ' + NL +
                          '    on Cfx.FK_TIPO_COMISSOES     = Crd.FK_TIPO_COMISSOES ' + NL +
                          '   and Cfx.FK_COMISSOES_REDUCOES = Crd.PK_COMISSOES_REDUCOES ' + NL +
                          ' where Crd.FK_TIPO_COMISSOES     = :FkTipoComissoes ' + NL +
                          '   and Crd.PK_COMISSOES_REDUCOES = 1 ' + NL +
                          ' order by 2, 5, 6';

  SqlDelRedComission    = 'delete from COMISSOES_REDUCOES ' + NL +
                          ' where FK_TIPO_COMISSOES = :FkTipoComissoes';

  SqlInsRedComission    = 'insert into COMISSOES_REDUCOES ' + NL +
                          '  (FK_TIPO_COMISSOES, PK_COMISSOES_REDUCOES, DSC_RED) ' + NL +
                          'values ' + NL +
                          '  (:FkTipoComissoes, :PkComissoesReducoes, :DscRed)';

  SqlGenRangeComission  = 'select R_PK_COMISSOES_FAIXAS as PK_COMISSOES_FAIXAS ' + NL +
                          '  from STP_GET_PK_COMISSOES_FAIXAS(:FkTipoComissoes, :FkComissoesReducoes)';

  SqlInsRangeComission  = 'insert into COMISSOES_FAIXAS ' + NL +
                          '  (FK_TIPO_COMISSOES, FK_COMISSOES_REDUCOES ' + NL +
                          '   PK_COMISSOES_FAIXAS, VLR_INI, VLR_FIN, PERC_RED) ' + NL +
                          'values ' + NL +
                          '  (:FkTipoComissoes, :FkComissoesReducoes, ' + NL +
                          '   :PkComissoesFaixas, :VlIni, :VlrFin, :PercRed)';

// Select SQL for the aux tables from this module
  SqlTypeRegions        = 'select * from CARGAS_REGIOES ' + NL +
                          ' where FLAG_GENERIC = :FlagGeneric ' + NL +
                          ' order by DSC_REG';

  SqlBairros            = 'select * from BAIRROS '                + NL +
                          ' where FK_PAISES     = :FkPaises '     + NL +
                          '   and FK_ESTADOS    = :FkEstados '    + NL +
                          '   and FK_MUNICIPIOS = :FkMunicipios ' + NL +
                          ' order by DSC_BAI';

  SqlLogradouros        = 'select Loc.FK_PAISES, Loc.FK_ESTADOS, Loc.FK_MUNICIPIOS,   ' + NL +
                          '       Loc.DSC_LOC, Loc.CMP_LOC, Bai.DSC_BAI, Tpe.DSC_TPE, ' + NL +
                          '       Loc.CEP_LOC                           ' + NL +
                          '  from LOGRADOUROS Loc                       ' + NL +
                          '  left outer join BAIRROS Bai                ' + NL +
                          '    on Bai.FK_PAISES     = Loc.FK_PAISES     ' + NL +
                          '   and Bai.FK_ESTADOS    = Loc.FK_ESTADOS    ' + NL +
                          '   and Bai.FK_MUNICIPIOS = Loc.FK_MUNICIPIOS ' + NL +
                          '   and Bai.PK_BAIRROS    = Loc.FK_BAIRROS    ' + NL +
                          '  left outer join TIPO_ENDERECOS Tpe         ' + NL +
                          '    on Tpe.PK_TIPO_ENDERECOS = Loc.FK_TIPO_ENDERECOS ' + NL +
                          ' where Loc.FK_PAISES     = :Pais             ' + NL +
                          '   and Loc.FK_ESTADOS    = :Estado           ' + NL +
                          '   and Loc.FK_MUNICIPIOS = :Municipio        ' + NL +
                          '   and Loc.FK_BAIRROS    = :Bairro           ' + NL +
                          ' order by Loc.DSC_LOC';

  SqlPkCategorias       = 'select Cat.PK_CATEGORIAS, Cat.DSC_CAT, '       + NL +
                          '       Cat.FLAG_CAT, Vin.FK_CADASTROS, '       + NL +
                          '       Vin.FLAG_ATV '                          + NL +
                          '  from CATEGORIAS Cat '                        + NL +
                          '  left outer join VINCULOS_CAD_CAT Vin '       + NL +
                          '    on Vin.FK_CADASTROS  = :FkCadastros '      + NL +
                          '   and Vin.FK_CATEGORIAS = Cat.PK_CATEGORIAS ' + NL +
                          '  left outer join CADASTROS Cad '              + NL +
                          '    on Cad.PK_CADASTROS = Vin.FK_CADASTROS '   + NL +
                          ' where Cat.PK_CATEGORIAS > 0 '                 + NL +
                          ' order by DSC_CAT';

  SqlCategorias         = 'select * from CATEGORIAS ' + NL +
                          ' order by DSC_CAT';

  SqlCategoria          = 'select * from CATEGORIAS ' + NL +
                          ' where PK_CATEGORIAS = :PkCategorias';

  SqlDeleteCat          = 'delete from CATEGORIAS ' + NL +
                          ' where PK_CATEGORIAS = :PkCategorias';

  SqlInsertCat          = 'Insert into CATEGORIAS ' + NL +
                          '  (PK_CATEGORIAS, DSC_CAT, FLAG_CAT, ' + NL +
                          '   FK_FINANCEIRO_CONTAS, FK_FINANCEIRO_CONTAS_ACM) ' + NL +
                          'Values ' + NL +
                          '  (:PkCategorias, :DscCat, :FlagCat, ' + NL +
                          '   :FkFinanceiroContas, :FkFinanceiroContasAcm)';

  SqlUpdateCat          = 'Update CATEGORIAS Set '      + NL +
                          '       DSC_CAT                  = :DscCat, '  + NL +
                          '       FLAG_CAT                 = :FlagCat, ' + NL +
                          '       FK_FINANCEIRO_CONTAS     = :FkFinanceiroContas, ' + NL +
                          '       FK_FINANCEIRO_CONTAS_ACM = :FkFinanceiroContasAcm ' + NL +
                          ' where PK_CATEGORIAS            = :PkCategorias';

  SqlGenPKCat           = 'select R_PK_CATEGORIAS as PK_CATEGORIAS ' + NL +
                          '  from STP_GET_PK_CATEGORIAS';

  SqlEstabelecimentos   = 'select * from TIPO_ESTABELECIMENTOS ' + NL +
                          '  order by DSC_TEST';

  SqlEstabelecimento    = 'select * from TIPO_ESTABELECIMENTOS ' + NL +
                          '  where PK_TIPO_ESTABELECIMENTOS = :PkTipoEstabelecimentos';

  SqlDeleteEstblc       = 'delete from TIPO_ESTABELECIMENTOS ' + NL +
                          '  where PK_TIPO_ESTABELECIMENTOS = :PkTipoEstabelecimentos';

  SqlInsertEstblc       = 'insert into TIPO_ESTABELECIMENTOS ' + NL +
                          '  (PK_TIPO_ESTABELECIMENTOS,DSC_TEST) ' + NL +
                          'Values ' + NL +
                          '  (:PkTipoEstabelecimentos,:DscTest)';

  SqlUpdateEstblc       = 'update TIPO_ESTABELECIMENTOS Set '   + NL +
                          '        DSC_TEST = :DscTest'        + NL +
                          '  where PK_TIPO_ESTABELECIMENTOS = :PkTipoEstabelecimentos';

  SqlGenPKEstblc        = 'select R_PK_TIPO_ESTABELECIMENTOS as PK_TIPO_ESTABELECIMENTOS ' + NL +
                          '  from STP_GET_PK_TIPO_ESTABELECIMENTO';

  SqlVinculoCad         = 'select * from VINCULOS_CAD_CAT    ' + NL +
                          ' where FK_CADASTROS  = :Cadastro  ' + NL +
                          '   and FK_CATEGORIAS = :Categoria ';

  SqlVinculoCadCat      = 'select * from VINCULOS_CAD_CAT   ' + NL +
                          ' where FK_CADASTROS  = :Cadastro ' + NL +
                          '   and FK_CATEGORIAS = :Categoria';

  SqlVinculo            = 'select Vin.FK_CATEGORIAS, Vin.FK_CADASTROS,  ' + NL +
                          '       Cat.DSC_CAT, Cad.RAZ_SOC, Vin.FLAG_ATV' + NL +
                          '  from VINCULOS_CAD_CAT Vin, CATEGORIAS Cat, ' + NL +
                          '       CADASTROS Cad                         ' + NL +
                          ' where Vin.FK_CADASTROS  = :Cadastro         ' + NL +
                          '   and Vin.FK_CATEGORIAS = :Categoria        ' + NL +
                          '   and Vin.FLAG_ATV     <> :FlagAtv          ' + NL +
                          '   and Cat.PK_CATEGORIAS = Vin.FK_CATEGORIAS ' + NL +
                          '   and Cad.PK_CADASTROS  = Vin.FK_CADASTROS  ' + NL +
                          ' order by DSC_CAT ';

  SqlCategoriasCad      = 'select Vin.FK_CATEGORIAS, Vin.FK_CADASTROS   ' + NL +
                          '  from VINCULOS_CAD_CAT Vin, CATEGORIAS Cat, ' + NL +
                          '       CADASTROS Cad                         ' + NL +
                          ' where Vin.FK_CADASTROS  = :Cadastro         ' + NL +
                          '   and Vin.FK_CATEGORIAS = Cat.PK_CATEGORIAS ' + NL +
                          '   and Cat.FLAG_CAT      = :FlagCat          ' + NL +
                          '   and Cad.PK_CADASTROS  = Vin.FK_CADASTROS  ' + NL +
                          ' order by DSC_CAT ';

  SqlGenPkTypeBlocks    = 'select R_PK_TIPO_BLOQUEIOS as PK_TIPO_BLOQUEIOS ' + NL +
                          '  from STP_GET_PK_TIPO_BLOQUEIOS';

  SqlSelectTypeBlocks   = 'select * from TIPO_BLOQUEIOS ' + NL +
                          ' order by DSC_TBL';

  SqlSelectTypeBlock    = 'select * from TIPO_BLOQUEIOS ' + NL +
                          ' where PK_TIPO_BLOQUEIOS = :PkTipoBloqueios';

  SqlInsertTypeBlock    = 'insert into TIPO_BLOQUEIOS ' + NL +
                          '  (PK_TIPO_BLOQUEIOS, DSC_TBL, FLAG_BLQ, FLAG_VAVS, ' + NL +
                          '   FLAG_MPGT, FLAG_DTABAS, FLAG_CONDP, FLAG_LIMCR) ' + NL +
                          'values ' + NL +
                          '  (:PkTipoBloqueios, :DscTbl, :FlagBlq, :FlagVaVs, ' + NL +
                          '   :FlagMpgt, :FlagDtaBas, :FlagCondP, :FlagLimCr)';

  SqlUpdateTypeBlock    = 'update TIPO_BLOQUEIOS set ' + NL +
                          '       DSC_TBL     = :DscTbl, ' + NL +
                          '       FLAG_BLQ    = :FlagBlq, ' + NL +
                          '       FLAG_VAVS   = :FlagVaVs, ' + NL +
                          '       FLAG_MPGT   = :FlagMpgt, ' + NL +
                          '       FLAG_DTABAS = :FlagDtaBas, ' + NL +
                          '       FLAG_CONDP  = :FlagCondP, ' + NL +
                          '       FLAG_LIMCR  = :FlagLimCr ' + NL +
                          ' where PK_TIPO_BLOQUEIOS = :PkTipoBloqueios';

  SqlDeleteTypeBlock    = 'delete from TIPO_BLOQUEIOS ' + NL +
                          ' where PK_TIPO_BLOQUEIOS = :PkTipoBloqueios';

  SqlClientSalesMan     = 'select  * from  CLIENTES                 ' + NL +
                          ' where  FK_CADASTROS         = :Cadastro ' + NL +
                          '   and (FK_VW_VENDEDORES     = :Vendedor ' + NL +
                          '    or  FK_VW_REPRESENTANTES = :Representante)';

  SqlOwnerMoviments     = 'select Gmv.PK_GRUPOS_MOVIMENTOS, Gmv.DSC_GMOV, ' + NL +
                          '       Gmv.FLAG_ES, Gmv.FLAG_DEV, Tmv.DSC_TMOV, ' + NL +
                          '       Tmv.NAT_OPE_DE, Tmv.NAT_OPE_FE, Tmv.NAT_OPE_EX, ' + NL +
                          '       Tmv.PK_TIPO_MOVIMENTOS,  Cmv.FK_CADASTROS, ' + NL +
                          '       Cast(3 as integer) as STATUS ' + NL +
                          '  from GRUPOS_MOVIMENTOS Gmv ' + NL +
                          '  join TIPO_MOVIMENTOS Tmv ' + NL +
                          '    on Tmv.FK_GRUPOS_MOVIMENTOS = Gmv.PK_GRUPOS_MOVIMENTOS ' + NL +
                          '  left outer join CADASTROS_MOVIMENTOS Cmv ' + NL +
                          '    on Cmv.FK_GRUPOS_MOVIMENTOS = Gmv.PK_GRUPOS_MOVIMENTOS ' + NL +
                          '   and Cmv.FK_TIPO_MOVIMENTOS   = Tmv.PK_TIPO_MOVIMENTOS ' + NL +
                          '   and Cmv.FK_CADASTROS         = :FkCadastros ' + NL +
                          ' where Gmv.PK_GRUPOS_MOVIMENTOS > 0 ' + NL +
                          '   and Gmv.FLAG_ES = :FlagES ' + NL +
                          ' order by Gmv.FLAG_DEV, Tmv.DSC_TMOV';

  SqlDeleteOwnerMov     = 'delete from CADASTROS_MOVIMENTOS ' + NL +
                          ' where FK_GRUPOS_MOVIMENTOS = :FkGruposMovimentos ' + NL +
                          '   and FK_TIPO_MOVIMENTOS   = :FkTipoMovimentos ' + NL +
                          '   and FK_CADASTROS         = :FkCadastros';

  SqlInsertOwnerMov     = 'insert into CADASTROS_MOVIMENTOS ' + NL +
                          '  (FK_GRUPOS_MOVIMENTOS, FK_TIPO_MOVIMENTOS, FK_CADASTROS) ' + NL +
                          'values ' + NL +
                          '  (:FkGruposMovimentos, :FkTipoMovimentos, :FkCadastros)';

//  SqlOwnerCustomer      = 'select * from STP_GET_OWNER_DATA(:PkCadastro, null, null)';

  SqlFornecCad          = 'select * from FORNECEDORES  ' + NL +
                          ' where FK_CADASTROS = :FkCadastros ';

  SqlFuncionarioCad     = 'select * from FUNCIONARIOS  ' + NL +
                          ' where FK_EMPRESAS  = :FkEmpresas ' + NL +
                          '   and FK_CADASTROS = :FkCadastros';

  SqlOwnerCustomer      = 'select Cad.FLAG_TCAD, Cad.FK_PAISES, Cli.* '  + NL +
                          '  from CADASTROS Cad ' + NL +
                          '  left outer join CLIENTES Cli ' + NL +
                          '    on Cli.FK_CADASTROS = Cad.PK_CADASTROS ' + NL +
                          ' where Cad.PK_CADASTROS = :FkCadastros';

  SqlPortos             = 'select * from PORTOS '         + NL +
                          ' where FK_PAISES = :FkPaises ' + NL +
                          ' order by DSC_PORTO';

  SqlAgentes            = 'select * from VW_CADASTROS     ' + NL +
                          ' order by RAZ_SOC';

  SqlCollection         = 'select * from COBRANCAS ' + NL +
                          ' where FK_CLIENTES = :FkCadastros';

  SqlDelivery           = 'select * from ENTREGAS ' + NL +
                          ' where FK_CLIENTES = :FkCadastros';

  SqlReferences         = 'select * from REFERENCIA_COMERCIAIS ' + NL +
                          ' where FK_CLIENTES = :FkCadastros';

  SqlDeleteReferences   = 'delete from REFERENCIA_COMERCIAIS ' + NL +
                          ' where FK_CLIENTES = :FkCadastros';

  SqlPartners           = 'select * from SOCIOS ' + NL +
                          ' where FK_CLIENTES = :FkCadastros';

  SqlDeletePartners     = 'delete from SOCIOS ' + NL +
                          ' where FK_CLIENTES = :FkCadastros';

  SqlPersonalData       = 'select * from DADOS_PESSOAIS ' + NL +
                          ' where FK_CLIENTES = :FkCadastros';

  SqlContatos           = 'select * from CONTATOS ' + NL +
                          ' where FK_CADASTROS = :Cadastro';

  SqlSelectAlias   = 'select PK_TIPO_ALIAS, DSC_ALIAS from TIPO_ALIAS order by DSC_ALIAS';

  SqlGetAlias      = 'select * from TIPO_ALIAS ' + NL +
                     ' where DSC_ALIAS = :DscAlias';

  SqlGenPkAlias    = 'select R_PK_TIPO_ALIAS as PK_TIPO_ALIAS ' + NL +
                     '  from STP_GET_PK_TIPO_ALIAS';

  SqlInsertAlias   = 'insert into TIPO_ALIAS ' + NL +
                     '  (PK_TIPO_ALIAS, DSC_ALIAS) ' + NL +
                     'values ' + NL +
                     '  (:PkTipoAlias, :DscAlias)';

  SqlManagerAlias  = 'select R_STATUS from STP_TYPE_ALIAS_MANAGER( ' +
                            ':PkTipoAlias, :DscAlias, :FlagDel)';

  SqlCadastro      = 'select Cad.PK_CADASTROS, Cad.RAZ_SOC, Tal.DSC_ALIAS, ' + NL +
                     '       Cat.FLAG_CAT, Cat.DSC_CAT ' + NL +
                     '  from CADASTROS Cad ' + NL +
                     '  left outer join TIPO_ALIAS Tal ' + NL +
                     '    on Tal.PK_TIPO_ALIAS = Cad.FK_TIPO_ALIAS ' + NL +
                     '  left outer join VINCULOS_CAD_CAT Vin ' + NL +
                     '  join CATEGORIAS Cat ' + NL +
                     '    on Vin.FK_CADASTROS  = Cad.PK_CADASTROS ' + NL +
                     '    on Cat.PK_CATEGORIAS = Vin.FK_CATEGORIAS ' + NL +
                     ' where PK_CADASTROS = :PkCadastros';

  SqlCheckDoc      = 'select Count(*) as QTD, Cast(0 as Integer) as PK_CADASTROS, ' + NL +
                     '       Cast('''' as varchar(50)) as RAZ_SOC ' + NL +
                     '  from CADASTROS ' + NL +
                     ' where ((DOC_PRI = :DocPri) ' + NL +
                     '    or (Cast('''' as varchar(30)) = :DocPri)) ' + NL +
                     '   and ((DOC_SEQ = :DocSec) ' + NL +
                     '    or (Cast('''' as varchar(30)) = :DocSec))';

  SqlCheckDocs     = 'select Cast(1 as Integer) as QTD, PK_CADASTROS, RAZ_SOC ' + NL +
                     '  from CADASTROS ' + NL +
                     ' where DOC_PRI = :DocPri ' + NL +
                     '   and DOC_SEQ = :DocSec';


// Select SQL for the aux tables from other modules
  SqlSupportedPrinters  = 'select PK_SUPORTED_PRINTERS, DSC_IMP, ' + NL +
                          '       Cast(0 as integer) as COD_ISS_ECF ' + NL +
                          '  from SUPORTED_PRINTERS ' + NL +
                          ' order by DSC_IMP';

  SqlLinguagens         = 'select * from LINGUAGENS     order by DSC_LANG';

  SqlMoedas             = 'select * from TIPO_MOEDAS    order by DSC_MD';

  SqlTypeDiscounts      = 'select Tds.* '                                     + NL +
                          '  from TIPO_DESCONTOS Tds, GRUPOS_MOVIMENTOS Gmv ' + NL +
                          ' where Gmv.PK_GRUPOS_MOVIMENTOS = Tds.FK_GRUPOS_MOVIMENTOS ' + NL +
                          '   and Gmv.FLAG_ES = :FlagEs '                     + NL +
                          '   and Gmv.FLAG_DEV = 0 '                          + NL +
                          ' order by Tds.DSC_TDSCT';

  SqlPaymentWay         = 'select Fin.*, Tpf.FK_FINANCEIRO_CONTAS ' + NL +
                          '  from FINALIZADORAS Fin, TIPO_PAGAMENTO_FINALIZADORA Tpf ' + NL +
                          ' where Tpf.FK_TIPO_PAGAMENTOS = :FkTipoPagamentos ' + NL +
                          '   and Fin.PK_FINALIZADORAS   = Tpf.FK_FINALIZADORAS ' + NL +
                          '    order by DSC_MPGT';

  SqlBancos             = 'select * from BANCOS ' + NL +
                          ' order by DSC_BCO';

  SqlTabelaPrecos       = 'select * from TABELA_PRECOS ' + NL +
                          ' order by DSC_TAB';

  SqlTypeFraction       = 'select * from TIPO_TABELA_FRACAO ' + NL +
                          ' order by DSC_TAB';

  SqlTypeEstablisment   = 'select * from TIPO_ESTABELECIMENTOS ' + NL +
                          ' order by DSC_TEST';

  SqlTypeDeliveryPeriod = 'select * from TIPO_PRAZO_ENTREGA ' + NL +
                          ' order by DSC_PRZE';

  SqlTypeFractionTable  = 'select distinct Ttf.* ' + NL +
                          '  from TABELA_TRANSPORTES Ttr, TIPO_TABELA_FRACAO Ttf ' + NL +
                          ' where Ttr.FK_TABELA_PRECOS      = :FkTabelaPrecos ' + NL +
                          '   and Ttf.PK_TIPO_TABELA_FRACAO = Ttr.FK_TIPO_TABELA_FRACAO ' + NL +
                          ' order by DSC_TAB';

  SqlGenCadastros       = 'select R_PK_CADASTROS as PK_CADASTROS ' + NL +
                          '  from STP_GET_PK_CADASTROS';

  SqlTypePayment        = 'select Tpg.*, Tpi.PK_TIPO_PAGAMENTOS_INTERVALOS, ' + NL +
                          '       Tpi.QTD_INTRV, Tpi.OPE_INTRV, Tpi.IDX_INTRV ' + NL +
                          '  from TIPO_PAGAMENTOS Tpg, GRUPOS_MOVIMENTOS Gmv ' + NL +
                          '  left outer join TIPO_PAGAMENTOS_INTERVALOS Tpi ' + NL +
                          '    on Tpi.FK_TIPO_PAGAMENTOS   = Tpg.PK_TIPO_PAGAMENTOS ' + NL +
                          ' where Tpg.FK_GRUPOS_MOVIMENTOS = Gmv.PK_GRUPOS_MOVIMENTOS ' + NL +
                          '   and Gmv.FLAG_ES  = :FlagEs ' + NL +
                          '   and Gmv.FLAG_DEV = 0 ' + NL +
                          ' order by Tpg.DSC_TPG';

  SqlFinanceAccounts    = 'select * from STP_GET_FINANCEIRO_CONTAS ' + NL +
                          ' where ((R_FLAG_TCTA    = :FlagTCta) ' + NL +
                          '    or ( -1             = :FlagTCta)) ' + NL +
                          '   and ((R_FLAG_ANL_SNT = :FlagAnlSnt) ' + NL +
                          '    or ( -1             = :FlagAnlSnt))';

  SqlRegsAccCount       = 'select Count(*) as QTD_REG from STP_GET_FINANCEIRO_CONTAS ' + NL +
                          ' where ((R_FLAG_TCTA    = :FlagTCta) ' + NL +
                          '    or ( -1             = :FlagTCta)) ' + NL +
                          '   and ((R_FLAG_ANL_SNT = :FlagAnlSnt) ' + NL +
                          '    or ( -1             = :FlagAnlSnt))';

var
  Variables: array of string;

implementation

end.
