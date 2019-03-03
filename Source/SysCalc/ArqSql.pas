unit ArqSql;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 03/06/2003 - DD/MM/YYYY                                      *}
{* Modified: 03/06/2003 - DD/MM/YYYY                                     *}
{* Version: 1.0.0.0                                                      *}
{* License: you can freely use and distribute the included code          *}
{*         for any purpouse, but you cannot remove this copyright        *}
{*         notice. Send me any comments and updates, they are really     *}
{*         appreciated. This software is licensed under MPL License,     *}
{*         see http://www.mozilla.org/MPL/ for details                   *}
{* Contact: (alcindo@sistemaprocessa.com.br)                             *}
{*         http://www.sistemaprocessa.com.br                             *}
{*                                                                       *}
{*************************************************************************}

interface

uses CmmConst;

resourcestring
  SqlClientes          = 'select * from VW_CLIENTES order by RAZ_SOC';

  SqlTiposMotores      = 'select * from TIPOS_MOTORES         ' + NL +
                         ' where FLAG_VND = 1                 ' + NL +
                         ' order by DSC_MOT, QTD_POLO, CV_MOT ';

  SqlMotores           = 'select PK_MOTORES, FK_TIPOS_MOTORES, DSC_MOT, ' + NL +
                         '       QTD_POLOS, POT_MOT, ROT_MOT, CRR_MED,  ' + NL +
                         '       CRR_TRC, QTD_MOT                       ' + NL +
                         '  from MOTORES                                ' + NL +
                         ' where FK_EMPRESAS = :Empresa                 ' + NL +
                         '   and FK_CALCULOS = :Calculo                 ' + NL +
                         ' order by PK_MOTORES                          ';

  SqlDeleteInsMotors   = 'delete from MOTORES           ' + NL +
                         ' where FK_EMPRESAS = :Empresa ' + NL +
                         '   and FK_CALCULOS = :Calculo ';

  SqlInsertInsMotors   = 'insert into MOTORES                               ' + NL +
                         '  (FK_EMPRESAS, FK_CALCULOS, PK_MOTORES, DSC_MOT, ' + NL +
                         '   FK_TIPOS_MOTORES, QTD_POLOS, POT_MOT, ROT_MOT, ' + NL +
                         '   CRR_MED, CRR_TRC, QTD_MOT)                     ' + NL +
                         'values                                            ' + NL +
                         '  (:FkEmpresas, :FkCalculos, :PkMotores, :DscMot, ' + NL +
                         '   :FkTiposMotores, :QtdPolos, :PotMot, :RotMot,  ' + NL +
                         '   :CrrMed, :CrrTrc, :QtdMot)                     ';

  SqlParametros        = 'select * from PARAMETROS_CALC order by DSC_PARAM';

  SqlCalculos          = 'select R_NOM_CLI, R_FON_CLI, R_DSC_MOT, R_POT_MOT, ' + NL +
                         '       R_ROT_MOT, R_LOC_MOT, R_DSC_MOT_VND,        ' + NL +
                         '       R_CNS_PONTA_ATU, R_CNS_FPONTA_ATU,          ' + NL +
                         '       R_CNS_TOTAL_ATU, R_CNS_PONTA_NEW,           ' + NL +
                         '       R_CNS_FPONTA_NEW, R_CNS_TOTAL_NEW,          ' + NL +
                         '       R_ECON_ENERG, R_ECON_ENERGF, R_VALOR_ECON,  ' + NL +
                         '       R_VALOR_ECONF, R_VALOR_ECONT,               ' + NL +
                         '       R_RET_INV_ANO_NEW, R_RET_INV_MES_NEW,       ' + NL +
                         '       R_RET_INV_ANO_ATU, R_RET_INV_MES_ATU        ' + NL +
                         '  from STP_CALC_MOTORS(:Empresa, :Calculo)         ';


var
  Variables: array of string;

implementation

end.
