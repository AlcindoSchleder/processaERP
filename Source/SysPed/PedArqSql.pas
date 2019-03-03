unit PedArqSql;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder                                           *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created  : 03/06/2003 - DD/MM/YYYY                                    *}
{* Modified : 03/06/2003 - DD/MM/YYYY                                    *}
{* Version  : 2.0.0.0                                                    *}
{* License  : you can freely use and distribute the included code        *}
{*            for any purpouse, but you cannot remove this copyright     *}
{*            notice. Send me any comments and updates, they are really  *}
{*            appreciated. This software is licensed under MPL License,  *}
{*            see http://www.mozilla.org/MPL/ for details                *}
{* Contact  : alcindo@sistemaprocessa.com.br                             *}
{*            http://www.sistemaprocessa.com.br                          *}
{*                                                                       *}
{*************************************************************************}

interface

uses CmmConst;

resourcestring
// Sql instrictions for autonumeration of primary keys
  SqlGenFinalizadora = 'select R_PK_FINALIZADORAS as PK_FINALIZADORAS ' + NL +
                       '  from STP_GET_PK_FINALIZADORAS';

// Slq instrunctions for tables of this modules

  SqlDiscounts       = 'select PK_DESCONTOS, IDX_DSCT, FLAG_PERC,   ' + NL +
                       '       FLAG_IMULT, FLAG_DSTQ,               ' + NL +
                       '       FK_REGIOES_DSCT, FK_CATEGORIAS       ' + NL +
                       '  from DESCONTOS                            ' + NL +
                       ' where FK_TIPO_DESCONTOS = :FkTipoDescontos ' + NL +
                       ' order by PK_DESCONTOS                      ';

  SqlInsertDiscounts = 'insert into DESCONTOS '  + NL +
                       '  (FK_TIPO_DESCONTOS, PK_DESCONTOS, FK_CATEGORIAS, ' + NL +
                       '   FK_PAISES, FK_ESTADOS, IDX_DSCT, FLAG_DSTQ, ' + NL +
                       '   FLAG_TDSCT) ' + NL +
                       'values ' + NL +
                       '  (:FkTipoDescontos, :PkDescontos, :FkCategorias, ' + NL +
                       '   :FkPaises, :FkEstados, :IdxDsct, :FlagDstq, ' + NL +
                       '   :FlagTDsct)';

  SqlDeleteDiscounts = 'delete from DIESCONTOS ' + NL +
                       ' where FK_TIPO_DESCONTOS = :FkTipoDescontos';

  SqlTipoDescontos   = 'select * from TIPO_DESCONTOS '                     + NL +
                       ' where FK_GRUPOS_MOVIMENTOS = :FkGruposMovimentos ' + NL +
                       ' order by DSC_TDSCT ';

  SqlGenTypeDiscount = 'select Gen_Id(TIPO_DESCONTOS, 1) as PK_TIPO_DESCONTOS ' + NL +
                       '  from PARAMETRO_GLOBAIS';

  SqlTypeDiscount    = 'select Tds.PK_TIPO_DESCONTOS, Tds.DSC_TDSCT, ' + NL +
                       '       Dsc.PK_DESCONTOS, Dsc.FK_PAISES, ' + NL +
                       '       Dsc.FK_ESTADOS, Dsc.FK_CATEGORIAS, ' + NL +
                       '       Dsc.IDX_DSCT, Dsc.FLAG_TDSCT, Dsc.FLAG_DSTQ, ' + NL +
                       '       Cat.DSC_CAT, Pai.DSC_PAIS, Est.DSC_UF ' + NL +
                       '  from TIPO_DESCONTOS Tds ' + NL +
                       '  left outer join DESCONTOS Dsc ' + NL +
                       '       left outer join CATEGORIAS Cat ' + NL +
                       '         on Cat.PK_CATEGORIAS   = Dsc.FK_CATEGORIAS ' + NL +
                       '       left outer join PAISES Pai ' + NL +
                       '         on Pai.PK_PAISES       = Dsc.FK_PAISES ' + NL +
                       '       left outer join ESTADOS Est ' + NL +
                       '         on Est.FK_PAISES       = Pai.PK_PAISES ' + NL +
                       '        and Est.PK_ESTADOS      = Dsc.FK_ESTADOS ' + NL +
                       '    on Dsc.FK_TIPO_DESCONTOS    = Tds.PK_TIPO_DESCONTOS ' + NL +
                       ' where Tds.FK_GRUPOS_MOVIMENTOS = :FkGruposMovimentos ' + NL +
                       '   and Tds.PK_TIPO_DESCONTOS    = :PkTipoDescontos ' + NL +
                       ' order by Tds.DSC_TDSCT, Dsc.PK_DESCONTOS';

  SqlInsTypeDiscount = 'insert into TIPO_DESCONTOS ' + NL +
                       '  (PK_TIPO_DESCONTOS, FK_GRUPOS_MOVIMENTOS, ' + NL +
                       '   DSC_TDSCT, KC_DESCONTOS) ' + NL +
                       'values ' + NL +
                       '  (:PkTipoDescontos, :FkGruposMovimentos, ' + NL +
                       '   :DscTDcst, :KcDescontos) ';

  SqlUpdTypeDiscount = 'update TIPO_DESCONTOS set ' + NL +
                       '       DSC_TDSCT    = :DscTDcst, ' + NL +
                       '       KC_DESCONTOS = :KcDescontos ' + NL +
                       ' where FK_GRUPOS_MOVIMENTOS = :FkGruposMovimentos ' + NL +
                       '   and PK_TIPO_DESCONTOS    = :PkTipoDescontos ';

  SqlDelTypeDiscount = 'delete from TIPO_DESCONTOS ' + NL +
                       ' where FK_GRUPOS_MOVIMENTOS = :FkGruposMovimentos ' + NL +
                       '   and PK_TIPO_DESCONTOS    = :PkTipoDescontos ';

  SqlMoviments       = 'select * ' + NL +
                       '  from TIPO_MOVIMENTOS ' + NL +
                       ' where FK_GRUPOS_MOVIMENTOS = :FkGruposMovimentos ' + NL +
                       ' order by DSC_TMOV';

  SqlGruposMov       = 'select Grm.*, Cast(0 as integer) as TYPE_DATA, ' + NL +
                       '       Cast(''Grupos Movimentos'' as varchar(30)) as DSC_TDATA, ' + NL +
                       '       Cast(0 as integer) as TYPE_NODE ' + NL +
                       '  from GRUPOS_MOVIMENTOS Grm ' + NL +
                       ' order by DSC_GMOV';

  SqlTipoPedidos     = 'select Tpd.FK_TIPO_DOCUMENTOS, ' + NL +
                       '       Tpd.FK_GRUPOS_MOVIMENTOS, Tpd.DSC_TPED, '      + NL +
                       '       Tpd.FLAG_TPED, Tdc.DSC_TDOC, Tdc.FLAG_TDOC, '  + NL +
                       '       Grm.DSC_GMOV, Grm.FLAG_ES '                    + NL +
                       '  from TIPO_DOCUMENTOS Tdc, '       + NL +
                       '       GRUPOS_MOVIMENTOS Grm '                        + NL +
                       ' where Tdc.PK_TIPO_DOCUMENTOS   = Tpd.FK_TIPO_DOCUMENTOS ' + NL +
                       '   and Grm.PK_GRUPOS_MOVIMENTOS = Tpd.FK_GRUPOS_MOVIMENTOS';

  SqlGenTypePayment  = 'select R_PK_TIPO_PAGAMENTOS as PK_TIPO_PAGAMENTOS ' + NL +
                       '  from STP_GET_PK_TIPO_PAGAMENTOS';

  SqlTypePayments    = 'select * from TIPO_PAGAMENTOS ' + NL +
                       ' where FK_GRUPOS_MOVIMENTOS = :FkGruposMovimentos';

  SqlTypePayment     = 'select * from TIPO_PAGAMENTOS ' + NL +
                       ' where FK_GRUPOS_MOVIMENTOS = :FkGruposMovimentos ' + NL +
                       '   and PK_TIPO_PAGAMENTOS   = :PkTipoPagamentos';

  SqlDeleteTypePgto  = 'delete from TIPO_PAGAMENTOS ' + NL +
                       ' where FK_GRUPOS_MOVIMENTOS = :FkGruposMovimentos ' + NL +
                       '   and PK_TIPO_PAGAMENTOS   = :PkTipoPagamentos';

  SqlGetTypePayWays  = 'select Tpf.FK_TIPO_PAGAMENTOS, Tpf.FK_FINANCEIRO_CONTAS, ' + NL +
                       '       Fin.*, Cast(3 as integer) as STATUS ' + NL +
                       '  from TIPO_PAGAMENTO_FINALIZADORA Tpf, FINALIZADORAS Fin' + NL +
                       ' where Tpf.FK_TIPO_PAGAMENTOS = :FkTipoPagamentos ' + NL +
                       '   and Fin.PK_FINALIZADORAS   = Tpf.FK_FINALIZADORAS ' + NL +
                       '   and Fin.FLAG_TFIN         <> 8 ' + NL +
                       'order by DSC_MPGT';

  SqlGetPaymentWays  = 'select Tpf.FK_TIPO_PAGAMENTOS, Tpf.FK_FINANCEIRO_CONTAS, ' + NL +
                       '       Fin.*, Cast(3 as integer) as STATUS ' + NL +
                       '  from FINALIZADORAS Fin ' + NL +
                       '  left outer join TIPO_PAGAMENTO_FINALIZADORA Tpf ' + NL +
                       '    on FK_FINALIZADORAS = Fin.PK_FINALIZADORAS ' + NL +
                       '   and FK_TIPO_PAGAMENTOS = :FkTipoPagamentos ' + NL +
                       ' where Fin.PK_FINALIZADORAS > 0 ' + NL +
                       '   and Fin.FLAG_TFIN <> 8 ' + NL +
                       'order by DSC_MPGT';

  SqlDeletePgtWay    = 'delete from TIPO_PAGAMENTO_FINALIZADORA ' + NL +
                       ' where FK_FINALIZADORAS   = :FkFinalizadoras '+ NL +
                       '   and FK_TIPO_PAGAMENTOS = :FkTipoPagamentos';

  SqlInsertPgtWay    = 'insert into TIPO_PAGAMENTO_FINALIZADORA ' + NL +
                       '  (FK_FINALIZADORAS, FK_TIPO_PAGAMENTOS, FK_FINANCEIRO_CONTAS) ' + NL +
                       'values ' + NL +
                       '  (:FkFinalizadoras, :FkTipoPagamentos, :FkFinanceiroContas)';

  SqlUpdatePgtWay    = 'update TIPO_PAGAMENTO_FINALIZADORA set ' + NL +
                       '       FK_FINANCEIRO_CONTAS = :FkFinanceiroContas ' + NL +
                       ' where FK_FINALIZADORAS     = :FkFinalizadoras '+ NL +
                       '   and FK_TIPO_PAGAMENTOS   = :FkTipoPagamentos';

  SqlMovimentos      = 'select Gmv.*, Tmo.DSC_TMOV, Tmo.PK_TIPO_MOVIMENTOS, '        + NL +
                       '       Tmo.FLAG_LDV, Tmo.NAT_OPE_DE, Tmo.NAT_OPE_FE, '       + NL +
                       '       Tmo.NAT_OPE_EX, Tmo.FLAG_CNS '                        + NL +
                       '  from GRUPOS_MOVIMENTOS Gmv, TIPO_MOVIMENTOS Tmo '          + NL +
                       ' where Tmo.FK_GRUPOS_MOVIMENTOS = Gmv.PK_GRUPOS_MOVIMENTOS ' + NL +
                       '   and ((Gmv.PK_GRUPOS_MOVIMENTOS = :PkGruposMovimentos) '   + NL +
                       '    or (0 = :PkGruposMovimentos)) '                          + NL +
                       '   and ((Gmv.FLAG_ES = :FlagEs) '                            + NL +
                       '    or (-1 = :FlagEs)) '                                     + NL +
                       '   and ((Gmv.FLAG_DEV = :FlagDev) '                          + NL +
                       '    or (-1 = :FlagDev)) '                                    + NL +
                       ' order by DSC_GMOV';

  SqlPedidosItems    = 'select * from STP_GET_ORDER_ITEMS ' + NL +
                       '(:FkEmpresas, :FkPedidos)';

  SqlStpGetProduct   = 'select * from STP_GET_PRODUCT_ITEM (:FkEmpresa, ' + NL +
                       '       :FkCadastro, :FkProduto, :CodeType, '      + NL +
                       '       :FkTabelaPrecos, :FkGruposMovimentos, '    + NL +
                       '       :FkTipoMovimentos, :TypeVol, :QtdProd)';

  SqlGruposMovements = 'select * from GRUPOS_MOVIMENTOS ' + NL +
                       ' order by DSC_GMOV ';

  SqlGenPkGrMovement = 'select Gen_Id(GRUPOS_MOVIMENTOS, 1) as PK_GRUPOS_MOVIMENTOS ' + NL +
                       ' from PARAMETRO_GLOBAIS';

  SqlGroupMovement   = 'select * from GRUPOS_MOVIMENTOS ' + NL +
                       ' where PK_GRUPOS_MOVIMENTOS = :PkGruposMovimentos';

  SqlDelGrMovement   = 'delete from GRUPOS_MOVIMENTOS ' + NL +
                       ' where PK_GRUPOS_MOVIMENTOS = :PkGruposMovimentos';

  SqlUpdGrMovement   = 'update GRUPOS_MOVIMENTOS set ' + NL +
                       '       DSC_GMOV  = :DscGMov, ' + NL +
                       '       FLAG_ES   = :FlagES, ' + NL +
                       '       FLAG_DEV  = :FlagDev, ' + NL +
                       '       FLAG_ESTQ = :FlagEstq, ' + NL +
                       '       FLAG_GRNT = :FlagGrnt, ' + NL +
                       '       FLAG_DSPA = :FlagDspa, ' + NL +
                       '       FLAG_COD  = :FlagCod, ' + NL +
                       '       FLAG_ORGM = :FlagOrgm, ' + NL +
                       '       FLAG_DSTI = :FlagDsti, ' + NL +
                       '       FLAG_GFIN = :FlagGFin ' + NL +
                       ' where PK_GRUPOS_MOVIMENTOS = :PkGruposMovimentos';

  SqlInsGrMovement   = 'insert into GRUPOS_MOVIMENTOS ' + NL +
                       '  (PK_GRUPOS_MOVIMENTOS, DSC_GMOV, FLAG_ES, FLAG_DEV, ' + NL +
                       '   FLAG_ESTQ, FLAG_GRNT, FLAG_DSPA, FLAG_COD, ' + NL +
                       '   FLAG_ORGM, FLAG_DSTI, FLAG_GFIN) ' + NL +
                       'values ' + NL +
                       '  (:PkGruposMovimentos, :DscGMov, :FlagES, :FlagDev, ' + NL +
                       '   :FlagEstq, :FlagGrnt, :FlagDspa, :FlagCod, ' + NL +
                       '   :FlagOrgm, :FlagDsti, :FlagGFin)';

  SqlGenPkTypeMov    = '    select Cast(Max(PK_TIPO_MOVIMENTOS) + 1 as Integer) as ' + NL +
                       '           PK_TIPO_MOVIMENTOS ' + NL +
                       '      from TIPO_MOVIMENTOS ' + NL +
                       '     where FK_GRUPOS_MOVIMENTOS = :FkGruposMovimentos';


  SqlTypeMovement    = 'select * from TIPO_MOVIMENTOS ' + NL +
                       ' where FK_GRUPOS_MOVIMENTOS = :FkGruposMovimentos ' + NL +
                       '   and PK_TIPO_MOVIMENTOS   = :PkTipoMovimentos';

  SqlDelTpMovement   = 'delete from TIPO_MOVIMENTOS ' + NL +
                       ' where FK_GRUPOS_MOVIMENTOS = :FkGruposMovimentos ' + NL +
                       '   and PK_TIPO_MOVIMENTOS   = :PkTipoMovimentos';

  SqlUpdTpMovement   = 'update TIPO_MOVIMENTOS set ' + NL +
                       '       DSC_TMOV         = :DscTMov, ' + NL +
                       '       FLAG_CNS         = :FlagCns, ' + NL +
                       '       FLAG_EXP         = :FlagExp, ' + NL +
                       '       FLAG_LDV         = :FlagLdv, ' + NL +
                       '       NAT_OPE_DE       = :NatOpeDe, ' + NL +
                       '       NAT_OPE_FE       = :NatOpeFe, ' + NL +
                       '       NAT_OPE_EX       = :NatOpeEx ' + NL +
                       ' where FK_GRUPOS_MOVIMENTOS = :FkGruposMovimentos ' + NL +
                       '   and PK_TIPO_MOVIMENTOS   = :PkTipoMovimentos';

  SqlInsTpMovement   = 'insert into TIPO_MOVIMENTOS ' + NL +
                       '  (FK_GRUPOS_MOVIMENTOS, PK_TIPO_MOVIMENTOS, ' + NL +
                       '   DSC_TMOV, FLAG_CNS, FLAG_EXP, FLAG_LDV, ' + NL +
                       '   NAT_OPE_DE, NAT_OPE_FE, NAT_OPE_EX) ' + NL +
                       'values ' + NL +
                       '  (:FkGruposMovimentos, :PkTipoMovimentos, ' + NL +
                       '   :DscTMov, :FlagCns, :FlagExp, :FlagLdv, ' + NL +
                       '   :NatOpeDe, :NatOpeFe, :NatOpeEx)';

  SqlDescontos       = 'select Tds.PK_TIPO_DESCONTOS, Tds.DSC_TDSCT, ' + NL +
                       '       Dsc.PK_DESCONTOS, Dsc.FK_PAISES, ' + NL +
                       '       Dsc.FK_ESTADOS, Dsc.FK_CATEGORIAS, ' + NL +
                       '       Dsc.IDX_DSCT, Dsc.FLAG_TDSCT, Dsc.FLAG_DSTQ ' + NL +
                       '  from TIPO_DESCONTOS Tds, DESCONTOS Dsc ' + NL +
                       ' where Tds.FK_GRUPOS_MOVIMENTOS = :FkGruposMovimentos ' + NL +
                       '   and Dsc.FK_TIPO_DESCONTOS    = Tds.PK_TIPO_DESCONTOS ' + NL +
                       ' order by DSC_TDSCT, Dsc.PK_DESCONTOS';

  SqlPedidos         = 'select * from PEDIDOS ' + NL +
                       ' where FK_EMPRESAS      = :FkEmpresas '             + NL +
                       '   and PK_PEDIDOS       = :PkPedidos';

  SqlPedidosEntrega  = 'select * from PEDIDOS_ENTREGA ' + NL +
                       ' where FK_EMPRESAS      = :FkEmpresas '             + NL +
                       '   and FK_PEDIDOS       = :PkPedidos';

  SqlDeletePedEntr   = 'delete from PEDIDOS_ENTREGA '             + NL +
                       ' where FK_EMPRESAS     = :FkEmpresas '    + NL +
                       '   and FK_PEDIDOS      = :FkPedidos ';

  SqlInsertPedEntr   = 'insert into PEDIDOS_ENTREGA '                   + NL +
                       '  (FK_EMPRESAS, FK_PEDIDOS, '  + NL +
                       '   UF_ENTR, MUN_ENTR, END_ENTR) '               + NL +
                       'values '                                        + NL +
                       '  (:FkEmpresas, :FkPedidos, '   + NL +
                       '   :UfEntr, :MunEntr, :EndEntr)';

  SqlUpdatePedEntr   = 'update PEDIDOS_ENTREGA set '              + NL +
                       '       UF_ENTR         = :UfEntr, '       + NL +
                       '       MUN_ENTR        = :MunEntr, '      + NL +
                       '       END_ENTR        = :EndEntr '       + NL +
                       ' where FK_EMPRESAS     = :FkEmpresas '    + NL +
                       '   and FK_PEDIDOS      = :FkPedidos ';

  SqlPedidosVinculo  = 'select Vnp.FK_PEDIDOS_VINC, Cad.RAZ_SOC, '               + NL +
                       '       Vnp.FK_EMPRESAS, Vnp.PK_VINCULO_PEDIDOS, '        + NL +
                       '       Cad.FK_CADASTROS '      + NL +
                       '  from VINCULO_PEDIDOS Vnp, PEDIDOS Ped, CADASTROS Cad ' + NL +
                       ' where Vnp.FK_EMPRESAS      = :FkEmpresas '              + NL +
                       '   and Vnp.PK_PEDIDOS       = :PkPedidos '               + NL +
                       '   and Ped.FK_EMPRESAS      = :FkEmpresas '              + NL +
                       '   and Ped.PK_PEDIDOS       = :PkPedidos '               + NL +
                       '   and Cad.FK_CADASTROS     = Ped.FK_CADASTROS ';

  SqlDeletePedVinc   = 'delete from VINCULO_PEDIDOS '              + NL +
                       ' where FK_EMPRESAS      = :FkEmpresas '    + NL +
                       '   and PK_PEDIDOS       = :PkPedidos ';

  SqlInsertPedVinc   = 'insert into VINCULO_PEDIDOS '                           + NL +
                       '  (FK_EMPRESAS, PK_VINCULO_PEDIDOS,  '  + NL +
                       '   FK_PEDIDOS,  FK_PEDIDOS_VINC) ' + NL +
                       'values '                                                + NL +
                       '  (:FkEmpresas, 0, :FkPedidos, :FkPedidosVinc)';

  SqlSelectPedVinc   = 'select Ped.PK_PEDIDOS, Cad.RAZ_SOC, '              + NL +
                       '       Ped.FK_EMPRESAS, 0 as PK_VINCULO_PEDIDOS, ' + NL +
                       '       Cad.PK_CADASTROS '     + NL +
                       '  from PEDIDOS Ped, CADASTROS Cad '                + NL +
                       ' where Ped.FK_EMPRESAS  = :FkEmpresas '            + NL +
                       '   and Ped.PK_PEDIDOS   = :PkPedidos '             + NL +
                       '   and Ped.DTA_LIB     is null '                   + NL +
                       '   and Ped.FK_CADASTROS = :FkCadastros '           + NL +
                       '   and Cad.PK_CADASTROS = Ped.FK_CADASTROS';

  SqlPedItemsConf    = 'select * from PEDIDOS_ITENS_CONF '            + NL +
                       ' where FK_EMPRESAS        = :FkEmpresas '     + NL +
                       '   and FK_PEDIDOS         = :FkPedidos '      + NL +
                       '   and FK_PEDIDOS_ITENS   = :FkPedidosItens ' + NL +
                       '   and FK_PRODUTOS        = :FkProdutos '     + NL +
                       ' order by FK_ACABAMENTOS';

  SqlGetPkOrder      = 'select R_PK_ORDER as PK_PEDIDOS from STP_GET_PK_ORDER ' + NL +
                       '       (:FkEmpresas)';


  SqlDelOrderItems   = 'delete from PEDIDOS_ITENS '                + NL +
                       ' where FK_EMPRESAS     = :FkEmpresas '    + NL +
                       '   and FK_PEDIDOS      = :FkPedidos ';

  SqlInsOrderItmConf = 'insert into PEDIDOS_ITENS_CONF '             + NL +
                       '  (FK_EMPRESAS, FK_PEDIDOS, ' + NL +
                       '   FK_PEDIDOS_ITENS, PK_PEDIDOS_ITENS_CONF, ' + NL +
                       '   FK_PRODUTOS, FK_COMPONENTES, FK_ACABAMENTOS, ' + NL +
                       '   FK_TIPO_REFERENCIAS, FK_INSUMOS, COD_REF, '   + NL +
                       '   VLR_ITM, FLAG_FRNCLI, FLAG_PEND, FLAG_CNTR, ' + NL +
                       '   NUM_DOC_LIB, QTD_COMP, QTD_COMP_TOT, QTD_INS, ' + NL +
                       '   FLAG_BXASTT, PER_DSCT_INS) ' + NL +
                       'values ' + NL +
                       '  (:FkEmpresas, :FkPedidos, ' + NL +
                       '   :FkPedidosItens, :FkPedidosItensConf, ' + NL +
                       '   :FkProdutos, :FkComponentes, :FkAcabamentos, ' + NL +
                       '   :FkTipoReferencias, :FkInsumos, :CodRef, '    + NL +
                       '   :VlrItm, :FlagFrnCli, :FlagPend, :FlagCntr, ' + NL +
                       '   :NumDocLib, :QtdComp, :QtdCompTot, :QtdIns, ' + NL +
                       '   :FlagBxaStt, :PerDsctIns)';

  SqlInsOrderPend    = 'insert into PEDIDOS_PENDENCIAS '               + NL +
                       '  (FK_EMPRESAS, FK_PEDIDOS, ' + NL +
                       '   FK_PEDIDOS_ITEMS, FK_PRODUTOS, QTD_PEND, VLR_UNIT) ' + NL +
                       'values ' + NL +
                       '  (:FkEmpresas, :FkPedidos, ' + NL +
                       '   :FkPedidosItens, :FkProdutos, :QtdPend, :VlrUnit)';

  SqlSelPayOrder     = 'select * from PEDIDOS_PARCELAS '          + NL +
                       ' where FK_EMPRESAS     = :FkEmpresas '    + NL +
                       '   and FK_PEDIDOS      = :FkPedidos '     + NL +
                       ' order by PK_PEDIDOS_PARCELAS';

  SqlDeletePayOrder  = 'delete from PEDIDOS_PARCELAS '            + NL +
                       ' where FK_EMPRESAS     = :FkEmpresas '    + NL +
                       '   and FK_PEDIDOS      = :FkPedidos ';

  SqlInsPayOrder     = 'insert into PEDIDOS_PARCELAS ' + NL +
                       '  (FK_EMPRESAS, FK_PEDIDOS, '     + NL +
                       '   PK_PEDIDOS_PARCELAS, NUM_PARC, VLR_PARC) '      + NL +
                       'values '                                           + NL +
                       '  (:FkEmpresas, :FkPedidos, '      + NL +
                       '   :PkPedidosParcelas, :NumParc, :VlrParc)';

  SqlSelOrderDsct    = 'select * from PEDIDOS_DESCONTOS '         + NL +
                       ' where FK_EMPRESAS     = :FkEmpresas '    + NL +
                       '   and FK_PEDIDOS      = :FkPedidos '     + NL +
                       ' order by PK_PEDIDOS_DESCONTOS';

  SqlDelOrderDsct    = 'delete from PEDIDOS_DESCONTOS '           + NL +
                       ' where FK_EMPRESAS     = :FkEmpresas '    + NL +
                       '   and FK_PEDIDOS      = :FkPedidos ';

  SqlInsOrderDsct    = 'insert into PEDIDOS_DESCONTOS ' + NL +
                       '  (FK_EMPRESAS, FK_PEDIDOS, ' + NL +
                       '   PK_PEDIDOS_DESCONTOS, DSC_DSCT, IDX_DSCT, FLAG_TDSCT) ' + NL +
                       'values ' + NL +
                       '  (:FkEmpresas, :FkPedidos, ' + NL +
                       '   :PkPedidosDescontos, :DscDsct, :IdxDsct, :FlagTDsct)';

  SqlSelOrderMsg     = 'select Pms.*, Dpt.DSC_DPTO '                         + NL +
                       '  from PEDIDOS_MENSAGENS Pms '                       + NL +
                       '  left outer join DEPARTAMENTOS Dpt '                + NL +
                       '    on Dpt.PK_DEPARTAMENTOS = Pms.FK_DEPARTAMENTOS ' + NL +
                       ' where Pms.FK_EMPRESAS      = :FkEmpresas '          + NL +
                       '   and Pms.FK_PEDIDOS       = :FkPedidos '           + NL +
                       ' order by Pms.DTHR_MSG';

  SqlDelOrderMsg     = 'delete from PEDIDOS_MENSAGENS '           + NL +
                       ' where FK_EMPRESAS     = :FkEmpresas '    + NL +
                       '   and FK_PEDIDOS      = :FkPedidos ';

  SqlInsOrderMsg     = 'insert into PEDIDOS_MENSAGENS ' + NL +
                       '  (FK_EMPRESAS, FK_PEDIDOS, '    + NL +
                       '   PK_PEDIDOS_MENSAGENS, FK_DEPARTAMENTOS, '      + NL +
                       '   DTHR_MSG, DTHR_RCBM, TEXT_MSG) '               + NL +
                       'values '                                          + NL +
                       '  (:FkEmpresas, :FkPedidos, '     + NL +
                       '   :PkPedidosMensagens, :FkDepartamentos, '       + NL +
                       '   :DtHrMsg, :DtHrRcbm, :TextMsg)';

  SqlSelOrderLinks   = 'select * from PEDIDOS_VINCULOS '          + NL +
                       ' where FK_EMPRESAS     = :FkEmpresas '    + NL +
                       '   and FK_PEDIDOS      = :FkPedidos '     + NL +
                       ' order by FK_EMPRESAS_VINC, '             + NL +
                       '          FK_PEDIDOS_VINC';

  SqlDelOrderLinks   = 'delete from PEDIDOS_VINCULOS '           + NL +
                       ' where FK_EMPRESAS     = :FkEmpresas '    + NL +
                       '   and FK_PEDIDOS      = :FkPedidos ';

  SqlInsOrderLinks   = 'insert into PEDIDOS_VINCULOS ' + NL +
                       '  (FK_EMPRESAS, FK_PEDIDOS, '   + NL +
                       '   FK_EMPRESAS_VINC, FK_PEDIDOS_VINC) '   + NL +
                       'values '                                         + NL +
                       '  (:FkEmpresas, :FkPedidos, '    + NL +
                       '   :FkEmpresasVinc, :FkPedidosVinc)';

  SqlSelOrderHist    = 'select Pdh.*, Tsp.DSC_STT '                   + NL +
                       '  from PEDIDOS_HISTORICOS Pdh'                + NL +
                       '  left outer join TIPO_STATUS_PEDIDOS Tsp '   + NL +
                       '    on Tsp.PK_TIPO_STATUS_PEDIDOS = Pdh.FK_TIPO_STATUS_PEDIDOS ' + NL +
                       ' where Pdh.FK_EMPRESAS     = :FkEmpresas '    + NL +
                       '   and Pdh.FK_PEDIDOS      = :FkPedidos '     + NL +
                       ' order by Pdh.DTHR_HIST';

  SqlDelOrderHist    = 'delete from PEDIDOS_HISTORICOS '          + NL +
                       ' where FK_EMPRESAS     = :FkEmpresas '    + NL +
                       '   and FK_PEDIDOS      = :FkPedidos ';

  SqlInsOrderHist    = 'insert into PEDIDOS_HISTORICOS '  + NL +
                       '  (FK_EMPRESAS, FK_PEDIDOS, '      + NL +
                       '   PK_PEDIDOS_HISTORICOS, FK_TIPO_STATUS_PEDIDOS, ' + NL +
                       '   FLAG_BXASTT, DSC_HIST, DTHR_HIST) '              + NL +
                       'values '                                            + NL +
                       '  (:FkEmpresas, :FkPedidos, '       + NL +
                       '   :PkPedidosHistoricos, :FkTipoStatusPedidos, '    + NL +
                       '   :FlagBxaStt, :DscHist, :DtHrHist)';

  SqlTipoStatus      = 'select * from TIPO_STATUS_PEDIDOS ' + NL +
                       ' where ((FK_GRUPOS_MOVIMENTOS = :FkGruposMovimentos) ' + NL +
                       '    or ( 0                    = :FkGruposMovimentos)) ' + NL +
                       ' order by DSC_STT';

  SqlTypeStatus      = 'select * from TIPO_STATUS_PEDIDOS ' + NL +
                       ' where FK_GRUPOS_MOVIMENTOS   = :FkGruposMovimentos ' + NL +
                       '   and PK_TIPO_STATUS_PEDIDOS = :PkTipoStatusPedidos';

  SqlGenTypeStatus   = 'select Gen_Id(TIPO_STATUS_PEDIDOS, 1) as PK_TIPO_STATUS_PEDIDOS ' + NL +
                       '  from PARAMETRO_GLOBAIS';

  SqlInsertTypeStt   = 'insert into TIPO_STATUS_PEDIDOS ' + NL +
                       '  (PK_TIPO_STATUS_PEDIDOS, FK_GRUPOS_MOVIMENTOS, ' + NL +
                       '   FK_TIPO_MOVIM_ESTQ, DSC_STT, QTD_DAYS_NEXT, ' + NL +
                       '   FLAG_OPEN, FLAG_RECB, FLAG_LIB, FLAG_CANC, ' + NL +
                       '   FLAG_PROD, FLAG_FAT, FLAG_LIQ, FLAG_TPED) ' + NL +
                       'values ' + NL +
                       '  (:PkTipoStatusPedidos, :FkGruposMovimentos, ' + NL +
                       '   :FkTipoMovimEstq, :DscStt, :QtdDaysNext, ' + NL +
                       '   :FlagOpen, :FlagRecb, :FlagLib, :FlagCanc, ' + NL +
                       '   :FlagProd, :FlagFat, :FlagLiq, :FlagTPed)';

  SqlUpdateTypeStt   = 'update TIPO_STATUS_PEDIDOS set ' + NL +
                       '       FK_TIPO_MOVIM_ESTQ     = :FkTipoMovimEstq, ' + NL +
                       '       DSC_STT                = :DscStt, ' + NL +
                       '       QTD_DAYS_NEXT          = :QtdDaysNext, ' + NL +
                       '       FLAG_OPEN              = :FlagOpen, ' + NL +
                       '       FLAG_RECB              = :FlagRecb, ' + NL +
                       '       FLAG_LIB               = :FlagLib, ' + NL +
                       '       FLAG_CANC              = :FlagCanc, ' + NL +
                       '       FLAG_PROD              = :FlagProd, ' + NL +
                       '       FLAG_FAT               = :FlagFat, ' + NL +
                       '       FLAG_LIQ               = :FlagLiq, ' + NL +
                       '       FLAG_TPED              = :FlagTPed ' + NL +
                       ' where FK_GRUPOS_MOVIMENTOS   = :FkGruposMovimentos ' + NL +
                       '   and PK_TIPO_STATUS_PEDIDOS = :PkTipoStatusPedidos';

  SqlDeleteTypeStt   = 'delete from TIPO_STATUS_PEDIDOS ' + NL +
                       ' where FK_GRUPOS_MOVIMENTOS   = :FkGruposMovimentos ' + NL +
                       '   and PK_TIPO_STATUS_PEDIDOS = :PkTipoStatusPedidos';

  SqlDeliveryPeriods = 'select * from TIPO_PRAZO_ENTREGA ' + NL +
                       ' order by DSC_PRZE';

  SqlDeliveryPeriod  = 'select * from TIPO_PRAZO_ENTREGA ' + NL +
                       ' where PK_TIPO_PRAZO_ENTREGA = :PkTipoPrazoEntrega ';

  SqlGenPkDelivery   = 'select Gen_Id(TIPO_PRAZO_ENTREGA, 1) as PK_TIPO_PRAZO_ENTREGA ' + NL +
                       '  from PARAMETRO_GLOBAIS';

  SqlDeleteDelivery  = 'delete from TIPO_PRAZO_ENTREGA ' + NL +
                       ' where PK_TIPO_PRAZO_ENTREGA = :PkTipoPrazoEntrega ';

  SqlInsertDelivery  = 'insert into TIPO_PRAZO_ENTREGA ' + NL +
                       '  (PK_TIPO_PRAZO_ENTREGA, DSC_PRZE, QTD_PRV) ' + NL +
                       'values ' + NL +
                       '  (:PkTipoPrazoEntrega, :DscPrzE, :QtdPrv)';

  SqlUpdateDelivery  = 'update TIPO_PRAZO_ENTREGA set ' + NL +
                       '       DSC_PRZE = :DscPrzE, ' + NL +
                       '       QTD_PRV  = :QtdPrv ' + NL +
                       ' where PK_TIPO_PRAZO_ENTREGA = :PkTipoPrazoEntrega ';

  SqlGenPkTpFreight  = 'select Gen_Id(TIPO_FRETES, 1) as PK_TIPO_FRETES ' + NL +
                       '  from PARAMETRO_GLOBAIS';

  SqlTypeFreights    = 'select * from TIPO_FRETES ' + NL +
                       ' order by DSC_TPFRE';

  SqlTypeFreight     = 'select * from TIPO_FRETES ' + NL +
                       ' where PK_TIPO_FRETES = :PkTipoFretes';

  SqlDelTypeFreight  = 'delete from TIPO_FRETES ' + NL +
                       ' where PK_TIPO_FRETES = :PkTipoFretes';

  SqlUpdTypeFreight  = 'update TIPO_FRETES set ' + NL +
                       '       FK_TIPO_PAGAMENTOS = :FkTipoPagamentos, ' + NL +
                       '       FK_CLASSIFICACAO   = :FkClassificacao, ' + NL +
                       '       DSC_TPFRE          = :DscTpFre, ' + NL +
                       '       FLAG_TP_FRE        = :FlagTpFre, ' + NL +
                       '       FLAG_FIN           = :FlagFin, ' + NL +
                       '       FLAG_ACU           = :FlagAcu, ' + NL +
                       '       FLAG_NF            = :FlagNf ' + NL +
                       ' where PK_TIPO_FRETES     = :PkTipoFretes';

  SqlInsTypeFreight  = 'insert into TIPO_FRETES ' + NL +
                       '  (PK_TIPO_FRETES, FK_TIPO_PAGAMENTOS, FK_CLASSIFICACAO, ' + NL +
                       '   DSC_TPFRE, FLAG_TP_FRE, FLAG_FIN, FLAG_ACU, FLAG_NF) ' + NL +
                       'values ' + NL +
                       '  (:PkTipoFretes, :FkTipoPagamentos, :FkClassificacao, ' + NL +
                       '   :DscTpFre, :FlagTpFre, :FlagFin, :FlagAcu, :FlagNf)';

  SqlAllParams       = 'select Prm.*, Emp.RAZ_SOC ' + NL +
                       '  from PARAMETROS_PED Prm, EMPRESAS Emp ' + NL +
                       ' where Prm.FK_EMPRESAS = :FkEmpresas ' + NL +
                       '   and Emp.PK_EMPRESAS = Prm.FK_EMPRESAS ' + NL +
                       ' order by Prm.PK_PARAMETROS_PED';

  SqlParamPed        = 'select * from PARAMETROS_PED ' + NL +
                       ' where FK_EMPRESAS = :FkEmpresas ';

  SqlDeleteParamPed  = 'delete from PARAMETROS_PED ' + NL +
                       ' where FK_EMPRESAS = :FkEmpresas ';

  SqlUpdateParamPed  = 'update PARAMETROS_PED set ' + NL +
                       '       FK_TIPO_PRAZO_ENTREGA  = :FkTipoPrazoEntrega, ' + NL +
                       '       FK_TIPO_STATUS_PEDIDOS = :FkStatusPedidos, ' + NL +
                       '       PRZ_VAL_ORC            = :PrzValOrc, ' + NL +
                       '       PRZ_ENTR               = :PrzEntr, ' + NL +
                       '       FLAG_ITM_DSCT          = :FlagItmDsct ' + NL +
                       ' where FK_EMPRESAS = :FkEmpresas';

  SqlInsertParamPed  = 'insert into PARAMETROS_PED ' + NL +
                       '  (FK_EMPRESAS, FK_TIPO_PRAZO_ENTREGA, ' + NL +
                       '   FK_TIPO_STATUS_PEDIDOS, PRZ_VAL_ORC, PRZ_ENTR, FLAG_ITM_DSCT) ' + NL +
                       'values ' + NL +
                       '  (:FkEmpresas, :FkTipoPrazoEntrega, ' + NL +
                       '   :FkStatusPedidos, :PrzValOrc, :PrzEntr, :FlagItmDsct)';

  SqlSetStatusOrder  = 'select * from STP_SET_STATUS_TO_ORDER(:FkEmpresas, ' + NL +
                       '         :PkPedidos, :PkPedidosItens, ' + NL +
                       '         :QtdProd, :FkTipoContas, :FkContas)';

  SqlPurchaseOrders  = 'select Ctf.FK_INSUMOS, Cot.PK_COTACOES, Cot.DSC_TCOT, ' + NL +
                       '       Ctf.CUST_TAB, Ctf.VLR_ACDS ' + NL +
                       '  from COTACOES Cot, COTACOES_FORNECEDOR Ctf ' + NL +
                       ' where Ctf.FK_EMPRESAS        = :FkEmpresas ' + NL +
                       '   and Ctf.FK_VW_FORNECEDORES = :FkFornecedores ' + NL +
                       '   and Ctf.FLAG_SEL           = 1 ' + NL +
                       '   and Cot.FK_EMPRESAS        = Ctf.FK_EMPRESAS ' + NL +
                       '   and Cot.PK_COTACOES        = Ctf.FK_COTACOES ' + NL +
                       '   and Cot.DTA_ENC            is not null ';

// Slq instrunctions for tables of other modules
  SqlTipoDocumentos  = 'select * from TIPO_DOCUMENTOS ' + NL +
                       ' where ((FLAG_TDOC = :FlagTDoc) ' + NL +
                       '    or ( -1        = :FlagTDoc)) ' + NL +
                       ' order by DSC_TDOC';

  SqlGruposFin       = 'select * from GRUPOS_FINANCEIRO order by DSC_GRU';

  SqlSubGruposFin    = 'select * from SUBGRUPOS_FINANCEIRO                ' + NL +
                       ' where FK_GRUPOS_FINANCEIRO = :FkGruposFinanceiro ' + NL +
                       ' order by DSC_SGRU';

  SqlNatureOperation = 'select * from NATUREZA_OPERACOES  ' + NL +
                       ' where FK_TIPO_CFOP = :FkTipoCfop ' + NL +
                       ' order by DSC_NTOP';

  SqlUnits           = 'select * from UNIDADES order by DSC_UNI';

  SqlAllCadastros    = '  select Vw_Cad.DSC_CAT, Vw_Cad.RAZ_SOC, Vw_Cad.NOM_FAN, ' + NL +
                       '         Vw_Cad.PK_CADASTROS, Vw_Cad.PK_CATEGORIAS ' + NL +
                       '    from VW_CLIENTES Vw_Cad                        ' + NL +
                       'union                                              ' + NL +
                       '  select Vw_Frn.DSC_CAT, Vw_Frn.RAZ_SOC, Vw_Frn.NOM_FAN, ' + NL +
                       '         Vw_Frn.PK_CADASTROS, Vw_Frn.PK_CATEGORIAS ' + NL +
                       '    from VW_FORNECEDORES Vw_Frn                    ' + NL +
                       '   order by 1, 2';

  SqlClientesEx      = 'select * from VW_CLIENTES_EXPORTACAO ' + NL +
                       ' where PK_EMPRESAS = :PkEmpresas     ' + NL +
                       ' order by RAZ_SOC         ';

  SqlOrdensCompra    = 'select * from ORDEM_COMPRAS          ' + NL +
                       ' where PK_EMPRESAS = :PkEmpresas     ' + NL +
                       ' order by DTA_EMI, PK_ORDEM_COMPRAS  ';

  SqlFornecedor      = 'select * from VW_FORNECEDORES   ' + NL +
                       ' where PK_CADASTROS = :Cadastro ' + NL +
                       ' order by RAZ_SOC               ';

  SqlAgentes         = 'select * from VW_AGENTES order by RAZ_SOC';

  SqlCliente         = 'select * from VW_CLIENTES       ' + NL +
                       ' where PK_CADASTROS = :Cadastro ' + NL +
                       ' order by RAZ_SOC               ';

  SqlDicionarios     = 'select * from DICIONARIOS '               + NL +
                       ' where PK_DICIONARIOS__NA = ''PEDIDOS'' ' + NL +
                       ' order by DSC_FLD';

  SqlClassDBCR       = 'select * from STP_GET_FINANCEIRO_CONTAS ' + NL +
                       ' where R_FLAG_TCTA = :FlagTCta';

  SqlPaises          = 'select * from PAISES ' + NL +
                       ' order by DSC_PAIS';

  SqlEstados         = 'select * from ESTADOS ' + NL +
                       ' where FK_PAISES = :FkPaises';

  SqlMunicipios      = 'select * from MUNICIPIOS '     + NL +
                       ' where FK_PAISES  = :FkPaises ' + NL +
                       '   and FK_ESTADOS = :FkEstados';

  SqlCategorias      = 'select * from CATEGORIAS '   + NL +
                       ' where FLAG_CAT in (0, 1) ' + NL +
                       ' order by DSC_CAT';

  SqlMovimEstq       = 'select * from TIPO_MOVIM_ESTQ ' + NL +
                       ' where FLAG_TMOV = :FlagTMov ' + NL +
                       ' order by DSC_TMOV';

  SqlTabPrecos       = 'select * from TABELA_PRECOS ' + NL +
                       ' where DTA_INI <= current_date ' + NL +
                       '   and ((DTA_FIN >= current_date) ' + NL +
                       '    or (DTA_FIN is null)) ' + NL +
                       ' order by DSC_TAB';

  SqlTipoEntrega     = 'select * from TIPO_PRAZO_ENTREGA order by DSC_PRZE ';


  SqlComponents      = 'select Tcp.DSC_TCOMP, Cmp.FK_TIPO_COMPONENTES, '             + NL +
                       '       Cmp.QTD_COMP '                                        + NL +
                       '  from COMPONENTES Cmp, TIPO_COMPONENTES Tcp '               + NL +
                       ' where Tcp.PK_TIPO_COMPONENTES   = Cmp.FK_TIPO_COMPONENTES ' + NL +
                       '   and Cmp.FK_PRODUTOS           = :FkProdutos '             + NL +
                       ' order by Tcp.DSC_TCOMP';

  SqlFinishes        = 'select Tac.PK_TIPO_ACABAMENTOS, Tac.DSC_ACABM, '           + NL +
                       '       Trf.DSC_REF, Acb.QTD_PERS, Acb.QTD_PDR, '           + NL +
                       '       Apr.PRE_VDA, Ref.FK_TIPO_REFERENCIAS, '             + NL +
                       '       Ref.FLAG_ATIVO, Trf.FLAG_TINS '                     + NL +
                       '  from ACABAMENTOS Acb '                                   + NL +
                       '  join TIPO_ACABAMENTOS Tac '                              + NL +
                       '    on Tac.PK_TIPO_ACABAMENTOS = Acb.FK_TIPO_ACABAMENTOS ' + NL +
                       '  join REFERENCIAS Ref '                                   + NL +
                       '    on Ref.FK_EMPRESAS         = :FkEmpresas '             + NL +
                       '   and Ref.FK_PRODUTOS         = Acb.FK_PRODUTOS '         + NL +
                       '   and Ref.FK_COMPONENTES      = Acb.FK_COMPONENTES '      + NL +
                       '   and Ref.FK_ACABAMENTOS      = Acb.FK_TIPO_ACABAMENTOS ' + NL +
                       '  join TIPO_REFERENCIAS Trf '                              + NL +
                       '    on Trf.FK_TIPO_ACABAMENTOS = Acb.FK_TIPO_ACABAMENTOS ' + NL +
                       '   and Trf.PK_TIPO_REFERENCIAS = Ref.FK_TIPO_REFERENCIAS ' + NL +
                       '  left outer join ACABAMENTO_PRECOS Apr '                  + NL +
                       '    on Apr.FK_EMPRESAS         = Ref.FK_EMPRESAS '         + NL +
                       '   and Apr.FK_PRODUTOS         = Acb.FK_PRODUTOS '         + NL +
                       '   and Apr.FK_TIPO_ACABAMENTOS = Acb.FK_TIPO_ACABAMENTOS ' + NL +
                       '   and Apr.FK_TIPO_REFERENCIAS = Ref.FK_TIPO_REFERENCIAS ' + NL +
                       ' where Acb.FK_PRODUTOS         = :FkProdutos '             + NL +
                       '   and Acb.FK_COMPONENTES      = :FkComponentes '          + NL +
                       ' order by Tac.DSC_ACABM, Trf.DSC_REF';

  SqlInsumos         = 'select Prd.* '                                        + NL +
                       '  from PRODUTOS Prd, PRODUTOS_COMPRAS Pcp '           + NL +
                       ' where Prd.PK_PRODUTOS         = Pcp.FK_PRODUTOS '    + NL +
                       '   and Prd.FLAG_ATV            = 1 '                  + NL +
                       '   and Pcp.FK_TIPO_ACABAMENTOS = :FkTipoAcabamentos ' + NL +
                       '   and Pcp.FK_TIPO_REFERENCIAS = :FkTipoReferencias ' + NL +
                       ' order by Prd.DSC_PROD';

  SqlPortos          = 'select * from PORTOS '         + NL +
                       ' where FK_PAISES = :FkPaises ' + NL +
                       ' order by DSC_PORTO';

  SqlDepartamentos   = 'select * from DEPARTAMENTOS ' + NL +
                       ' order by DSC_DPTO';


  SqlSearchProdutos0 = 'select Prd.*, Pcd.COD_REF, Pcd.FLAG_TCODE, ' + NL +
                       '       Pim.IMG_PROD, Pim.FLAG_TIMG, '        + NL +
                       '       Uni.DSC_UNI, (Pct.QTD_ESTQ - ' + NL +
                       '       (Pct.QTD_RSRV + Pct.QTD_GRNT + ' + NL +
                       '        Pct.QTD_ESTQ_QR)) as QTD_ESTQ ' + NL +
                       '  from PRODUTOS Prd '                        + NL +
                       '  join PRODUTOS_CUSTOS Pct '                        + NL +
                       '    on Pct.FK_EMPRESAS  = :FkEmpresas '  + NL +
                       '   and Pct.FK_PRODUTOS  = Prd.PK_PRODUTOS '  + NL +
                       '  join UNIDADES Uni '                        + NL +
                       '    on Uni.PK_UNIDADES  = Prd.FK_UNIDADES '  + NL +
                       '  left outer join PRODUTOS_IMAGENS Pim '     + NL +
                       '    on Pim.FK_PRODUTOS  = Prd.PK_PRODUTOS '  + NL +
                       '  join PRODUTOS_CODIGOS Pcd '                + NL +
                       '    on Pcd.FK_PRODUTOS  = Prd.PK_PRODUTOS '  + NL +
                       '   and ((Pcd.FLAG_TCODE = :FlagTCode) '      + NL +
                       '    or ( -1             = :FlagTCode))';
  SqlSearchProdutos1 = ' where Prd.FLAG_ATV     = :FlagAtv ';
  SqlSearchProdutos2 = ' order by Prd.FK_SECOES, Prd.FK_GRUPOS, '    + NL +
                       '          Prd.FK_SUBGRUPOS, Prd.DSC_PROD';

  SqlSecoes          = 'select * from SECOES '             + NL +
                       ' order by DSC_SEC';

  SqlGrupos          = 'select * from GRUPOS '         + NL +
                       ' where FK_SECOES = :FkSecoes ' + NL +
                       ' order by DSC_GRU';

  SqlSubGrupos       = 'select * from SUBGRUPOS '      + NL +
                       ' where FK_SECOES = :FkSecoes ' + NL +
                       ' and FK_GRUPOS   = :FkGrupos ' + NL +
                       ' order by DSC_SGRU';

var
  Variables: array of string;

implementation

end.
