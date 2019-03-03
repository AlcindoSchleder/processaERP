unit ArqSqlTrans;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder                                           *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created  : 03/06/2003 - DD/MM/YYYY                                    *}
{* Modified : 03/06/2003 - DD/MM/YYYY                                    *}
{* Version  : 1.0.0.0                                                    *}
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

  SqlTypePriceTable     = 'select Tab.PK_TABELA_PRECOS, Tab.DSC_TAB, Tab.DTA_INI, ' + NL +
                          '       Tab.DTA_FIN, Tab.FLAG_DEFTAB, Tab.PERC_DSCT, ' + NL +
                          '       Tfr.PK_TIPO_TABELA_FRACAO, Tfr.DSC_TAB as DSC_FRAC, ' + NL +
                          '       Tfr.FLAG_TIPO, Tod.PK_TABELA_ORIGEM_DESTINO, ' + NL +
                          '       Tod.VLR_MIN ' + NL +
                          '  from TABELA_PRECOS Tab, TABELA_TRANSPORTES Ttr, ' + NL +
                          '       TABELA_ORIGEM_DESTINO Tod, TIPO_TABELA_FRACAO Tfr ' + NL +
                          ' where Tab.FLAG_DEFTAB               = :FlagDef ' + NL +
                          '   and Ttr.FK_TABELA_PRECOS          = Tab.PK_TABELA_PRECOS ' + NL +
                          '   and Tod.PK_TABELA_ORIGEM_DESTINO = :FkCalculoOrigemDestino ' + NL +
                          '   and Ttr.FK_TABELA_ORIGEM_DESTINO = Tod.PK_TABELA_ORIGEM_DESTINO ' + NL +
                          '   and Tfr.PK_TIPO_TABELA_FRACAO    = Ttr.FK_TIPO_TABELA_FRACAO ' + NL +
                          ' order by Tab.DSC_TAB, Tfr.DSC_TAB';

  SqlCarrierOrder       = 'select Pfr.*, Pfl.PK_PEDIDOS_FRETES_LOCAL, Pfl.FK_PAISES, ' + NL +
                          '       Pfl.FK_ESTADOS, Pfl.FK_MUNICIPIOS, Pfl.DSC_REG ' + NL +
                          '       Rem.DOC_PRI as CNPJ_REM, Dst.DOC_PRI as CNPJ_DST, ' + NL +
                          '       Cns.DOC_PRI as CNPJ_Cns ' + NL +
                          '  from PEDIDOS_FRETES Pfr ' + NL +
                          '  left outer join PEDIDOS_FRETES_LOCAL Pfl ' + NL +
                          '    on Pfl.FK_EMPRESAS  = Pfr.FK_EMPRESAS ' + NL +
                          '   and Pfl.FK_PEDIDOS   = Pfr.FK_PEDIDOS ' + NL +
                          '  left outer join CADASTROS Rem ' + NL +
                          '    on Rem.PK_CADASTROS = Pfr.FK_REMETENTE ' + NL +
                          '  left outer join CADASTROS Dst ' + NL +
                          '    on Dst.PK_CADASTROS = Pfr.FK_DESTINATARIO ' + NL +
                          '  left outer join CADASTROS Cns ' + NL +
                          '    on Cns.PK_CADASTROS = Pfr.FK_CONSIGNATARIO ' + NL +
                          ' where Pfr.FK_EMPRESAS  = :FkEmpresas ' + NL +
                          '   and Pfr.FK_PEDIDOS   = :FkPedidos ';


  SqlInsertCarrierOrder = 'insert into PEDIDOS_FRETES ' + NL +
                          '  (FK_EMPRESAS, FK_PEDIDOS, FK_REMETENTE, FK_DESTINATARIO, ' + NL +
                          '   FK_CONSIGNATARIO, FK_TIPO_TABELA_FRACAO, ' + NL +
                          '   FK_TABELA_PRECOS, FK_TABELA_ORIGEM_DESTINO, ' + NL +
                          '   FK_PRODUTOS_FRETES, FLAG_ES, FLAG_REMB, FLAG_TP_FRE, ' + NL +
                          '   NUM_NF, VLR_NF, VLR_FRE_PESO, FRE_VLR, VLR_SECAT, ' + NL +
                          '   VLR_GRIS, VLR_PEDG, VLR_DIF_ACC, ALQT_ICMS, QTD_PROD) ' + NL +
                          'values ' + NL +
                          '  (:FkEmpresas, :FkPedidos, :FkRemetente, :FkDestinatario, ' + NL +
                          '   :FkConsignatario, :FkTipoTabelaFracao, ' + NL +
                          '   :FkTabelaPrecos, :FkTabelaOrigemDestino, ' + NL +
                          '   :FkProdutosFretes, :FlagES, :FlagRemb, :FlagTpFre, ' + NL +
                          '   :NumNF, :VlrNF, :VlrFrePeso, :FreVlr, :VlrSecat, ' + NL +
                          '   :VlrGris, :VlrPedg, :VlrDifAcc, :AlqtIcms, :QtdProd)';

  SqlUpdateCarrierOrder = 'update PEDIDOS_FRETES set ' + NL +
                          '       FK_REMETENTE             = :FkRemetente, ' + NL +
                          '       FK_DESTINATARIO          = :FkDestinatario, ' + NL +
                          '       FK_CONSIGNATARIO         = :FkConsignatario, ' + NL +
                          '       FK_TIPO_TABELA_FRACAO    = :FkTipoTabelaFracao, ' + NL +
                          '       FK_TABELA_PRECOS         = :FkTabelaPrecos, ' + NL +
                          '       FK_TABELA_ORIGEM_DESTINO = :FkTabelaOrigemDestino, ' + NL +
                          '       FK_PRODUTOS_FRETES       = :FkProdutosFretes, ' + NL +
                          '       FLAG_ES                  = :FlagES, ' + NL +
                          '       FLAG_REMB                = :FlagRemb, ' + NL +
                          '       FLAG_TP_FRE              = :FlagTpFre, ' + NL +
                          '       NUM_NF                   = :NumNF, ' + NL +
                          '       VLR_NF                   = :VlrNF, ' + NL +
                          '       VLR_FRE_PESO             = :VlrFrePeso, ' + NL +
                          '       FRE_VLR                  = :FreVlr, ' + NL +
                          '       VLR_SECAT                = :VlrSecat, ' + NL +
                          '       VLR_GRIS                 = :VlrGris, ' + NL +
                          '       VLR_PEDG                 = :VlrPedg, ' + NL +
                          '       VLR_DIF_ACC              = :VlrDifAcc, ' + NL +
                          '       ALQT_ICMS                = :AlqtIcms, ' + NL +
                          '       QTD_PROD                 = :QtdProd ' + NL +
                          ' where FK_EMPRESAS              = :FkEmpresas ' + NL +
                          '   and FK_PEDIDOS               = :FkPedidos';

  SqlSelCarrierOrdWght  = 'select * from FRETES_MEDIDAS ' + NL +
                          ' where FK_EMPRESAS       = :FkEmpresas ' + NL +
                          '   and FK_PEDIDOS_FRETES = :FkPedidosFretes';

  SqlDelCarrierOrdWght  = 'delete from FRETES_MEDIDAS ' + NL +
                          ' where FK_EMPRESAS       = :FkEmpresas ' + NL +
                          '   and FK_PEDIDOS_FRETES = :FkPedidosFretes';

  SqlInsCarrierOrdWght  = 'insert into FRETES_MEDIDAS ' + NL +
                          '  (FK_EMPRESAS, FK_PEDIDOS_FRETES, PK_FRETES_MEDIDAS, ' + NL +
                          '   ALT_VOL, LARG_VOL, PROF_VOL) ' + NL +
                          'values ' + NL +
                          '  (:FkEmpresas, :FkPedidosFretes, :PkFretesMedidas, ' + NL +
                          '   :AltVol, :LargVol, :ProfVol)';

  SqlSelCarrierOrdOrDt  = 'select * from PEDIDOS_FRETES_LOCAL ' + NL +
                          ' where FK_EMPRESAS = :FkEmpresas ' + NL +
                          '   and FK_PEDIDOS  = :FkPedidos ' + NL +
                          '   and PK_PEDIDOS_FRETES_LOCAL = :PkPedidosFretesLocal';

  SqlDelCarrierOrdOrDt  = 'delete from PEDIDOS_FRETES_LOCAL ' + NL +
                          ' where FK_EMPRESAS = :FkEmpresas ' + NL +
                          '   and FK_PEDIDOS  = :FkPedidos ' + NL +
                          '   and PK_PEDIDOS_FRETES_LOCAL = :PkPedidosFretesLocal';

  SqlInsCarrierOrdOrDt  = 'insert into PEDIDOS_FRETES_LOCAL ' + NL +
                          '  (FK_EMPRESAS, FK_PEDIDOS, PK_PEDIDOS_FRETES_LOCAL, ' + NL +
                          '   FK_PAISES, FK_ESTADOS, FK_MUNICIPIOS, DSC_REG) ' + NL +
                          'values ' + NL +
                          '  (:FkEmpresas, :FkPedidos, :PkPedidosFretesLocal, ' + NL +
                          '   :FkPaises, :FkEstados, :FkMunicipios, :DscReg)';

  SqlSelCarrierOrdPrtn  = 'select * from FRETES_PARCEIROS ' + NL +
                          ' where FK_EMPRESAS = :FkEmpresas ' + NL +
                          '   and FK_PEDIDOS  = :FkPedidos';

  SqlDelCarrierOrdPrtn  = 'delete from FRETES_PARCEIROS ' + NL +
                          ' where FK_EMPRESAS = :FkEmpresas ' + NL +
                          '   and FK_PEDIDOS  = :FkTipoDocumentos';

  SqlInsCarrierOrdPrtn  = 'insert into FRETES_PARCEIROS ' + NL +
                          '  (FK_EMPRESAS, FK_PEDIDOS, FK_PARCEIRO, FRE_VLR, ' + NL +
                          '   VLR_FRE_PESO, VLR_SECAT, VLR_GRIS, VLR_PEDG, ' + NL +
                          '   VLR_DIF_ACC, PERC_FRE, VLR_NF, NUM_NF) ' + NL +
                          'values ' + NL +
                          '  (:FkEmpresas, :FkPedidos, :FkParceiro, :FreVlr, ' + NL +
                          '   :VlrFrePeso, :VlrSecat, :VlrGris, :VlrPedg, ' + NL +
                          '   :VlrDifAcc, :PercFre, :VlrNF, :NumNF)';

  SqlSelCarrierDocPrtn  = 'select * from CONHECIMENTO_PARCEIROS ' + NL +
                          ' where FK_EMPRESAS        = :FkEmpresas ' + NL +
                          '   and FK_TIPO_DOCUMENTOS = :FkTipoDocumentos ' + NL +
                          '   and FK_CADASTROS       = :FkCadastros ' + NL +
                          '   and FK_DOCUMENTOS      = :FkDocumentos';

  SqlDelCarrierDocPrtn  = 'delete from CONHECIMENTO_PARCEIROS ' + NL +
                          ' where FK_EMPRESAS        = :FkEmpresas ' + NL +
                          '   and FK_TIPO_DOCUMENTOS = :FkTipoDocumentos ' + NL +
                          '   and FK_CADASTROS       = :FkCadastros ' + NL +
                          '   and FK_DOCUMENTOS      = :FkDocumentos';

  SqlInsCarrierDocPrtn  = 'insert into CONHECIMENTO_PARCEIROS ' + NL +
                          '  (FK_EMPRESAS, FK_TIPO_DOCUMENTOS, FK_CADASTROS, ' + NL +
                          '   FK_DOCUMENTOS, FK_PARCEIRO, FRE_VLR, VLR_FRE_PESO, ' + NL +
                          '   VLR_SECAT, VLR_GRIS, VLR_PEDG, VLR_DIF_ACC, ' + NL +
                          '   PERC_FRE, VLR_NF, NUM_NF) ' + NL +
                          'values ' + NL +
                          '  (:FkEmpresas, :FkTipoDocumentos, :FkCadastros, ' + NL +
                          '   :FkDocumentos, :FkParceiro, :FreVlr, :VlrFrePeso, ' + NL +
                          '   :VlrSecat, :VlrGris, :VlrPedg, :VlrDifAcc, ' + NL +
                          '   :PercFre, :VlrNF, :NumNF)';

  SqlCarrierOrdProduct  = 'select * from PEDIDOS_ITENS  ' + NL +
                          ' where FK_EMPRESAS       = :FkEmpresas ' + NL +
                          '   and FK_PEDIDOS_FRETES = :FkPedidos';

  SqlCarrierOrdWeights  = 'select * from FRETE_MEDIDAS  ' + NL +
                          ' where FK_EMPRESAS       = :FkEmpresas ' + NL +
                          '   and FK_PEDIDOS_FRETES = :FkPedidos';

  SqlCarrierOrdPartner  = 'select * from FRETE_PARCEIRO ' + NL +
                          ' where FK_EMPRESAS        = :FkEmpresas ' + NL +
                          '   and FK_PEDIDOS_FRETES  = :FkPedidos';

  SqlGetCarrierPrices   = 'select * from STP_GET_CARRIER_PRICES(:FkCompany, ' + NL +
                          '       :FkProducts, :FkTablePrice, :FkTipoFractionTable, ' + NL +
                          '       :FkTableOrgmDstn, :FkAddressee, :FkCustomer, ' + NL +
                          '       :TypeCstm, :VlrAcrDsct, :QtdProd, :VlrNF)';

  SqlGetPkOrder         = 'select R_PK_PEDIDOS as PK_PEDIDOS from STP_GET_PK_PEDIDOS ' + NL +
                          '       (:FkEmpresas, :FkTipoStatusPedidos)';

  SqlGetPkCarrierDoc    = 'select R_PK_DOCUMENTOS as PK_DOCUMENTOS ' + NL +
                          '  from STP_GET_PK_DOCUMENTOS(:FkEmpresas, :FkTipoDocumentos)';

  SqlDeleteOrder        = 'delete from PEDIDOS ' + NL +
                          ' where FK_EMPRESAS = :FkEmpresas ' + NL +
                          '   and PK_PEDIDOS  = :PkPedidos';

  SqlSelectOrderDsct    = 'select * from PEDIDOS_DESCONTOS '           + NL +
                          ' where FK_EMPRESAS     = :FkEmpresas '    + NL +
                          '   and FK_PEDIDOS      = :FkPedidos ' + NL +
                          ' order by PK_PEDIDOS_DESCONTOS';

  SqlDelOrderDsct       = 'delete from PEDIDOS_DESCONTOS '           + NL +
                          ' where FK_EMPRESAS     = :FkEmpresas '    + NL +
                          '   and FK_PEDIDOS      = :FkPedidos';

  SqlInsOrderDsct       = 'insert into PEDIDOS_DESCONTOS ' + NL +
                          '  (FK_EMPRESAS, FK_PEDIDOS, ' + NL +
                          '   PK_PEDIDOS_DESCONTOS, DSC_DSCT, IDX_DSCT, FLAG_TDSCT) ' + NL +
                          'values ' + NL +
                          '  (:FkEmpresas, :FkPedidos, ' + NL +
                          '   :PkPedidosDescontos, :DscDsct, :IdxDsct, :FlagTDsct)';

  SqlSelectOrderItm     = 'select * from PEDIDOS_ITENS ' + NL +
                          ' where FK_EMPRESAS     = :FkEmpresas '    + NL +
                          '   and FK_PEDIDOS      = :FkPedidos ' + NL +
                          ' order by PK_PEDIDOS_ITENS';

  SqlSelectDocMsg       = 'select * from DOCUMENTOS_OBSERVACOES ' + NL +
                          ' where FK_EMPRESAS        = :FkEmpresas ' + NL +
                          '   and FK_TIPO_DOCUMENTOS = :FkTipoDocumentos ' + NL +
                          '   and FK_CADASTROS       = :FkCadastros ' + NL +
                          '   and FK_DOCUMENTOS      = :FkDocumentos ';

  SqlSelectOrderMsg     = 'select * from PEDIDOS_MENSAGENS '           + NL +
                          ' where FK_EMPRESAS     = :FkEmpresas '    + NL +
                          '   and FK_PEDIDOS      = :FkPedidos ' + NL +
                          ' order by DTHR_MSG';

  SqlDelOrderMsg        = 'delete from PEDIDOS_MENSAGENS '           + NL +
                          ' where FK_EMPRESAS     = :FkEmpresas '    + NL +
                          '   and FK_PEDIDOS      = :FkPedidos ';

  SqlInsOrderMsg        = 'insert into PEDIDOS_MENSAGENS ' + NL +
                          '  (FK_EMPRESAS, FK_PEDIDOS, PK_PEDIDOS_MENSAGENS, ' + NL +
                          '   DTHR_MSG, DTHR_RCBM, TEXT_MSG) ' + NL +
                          'values ' + NL +
                          '  (:FkEmpresas, :FkPedidos, :PkPedidosMensagens, '     + NL +
                          '   :DtHrMsg, :DtHrRcbm, :TextMsg)';

  SqlSelectPayOrder     = 'select * from PEDIDOS_PARCELAS ' + NL +
                          ' where FK_EMPRESAS     = :FkEmpresas '    + NL +
                          '   and FK_PEDIDOS      = :FkPedidos ' + NL +
                          ' order by PK_PEDIDOS_PARCELAS';

  SqlDelPayOrder        = 'delete from PEDIDOS_PARCELAS '            + NL +
                          ' where FK_EMPRESAS     = :FkEmpresas '    + NL +
                          '   and FK_PEDIDOS      = :FkPedidos ';

  SqlInsPayOrder        = 'insert into PEDIDOS_PARCELAS ' + NL +
                          '  (FK_EMPRESAS, FK_PEDIDOS, '     + NL +
                          '   PK_PEDIDOS_PARCELAS, NUM_PARC, VLR_PARC) '      + NL +
                          'values '                                           + NL +
                          '  (:FkEmpresas, :FkPedidos, '      + NL +
                          '   :PkPedidosParcelas, :NumParc, :VlrParc)';

  SqlSelectDocumentItem = 'select * from DOCUMENTOS_ITENS ' + NL +
                          '   and FK_TIPO_DOCUMENTOS = :FkTipoDocumentos ' + NL +
                          '   and FK_CADASTROS       = :FkCadastros ' + NL +
                          '   and FK_DOCUMENTOS      = :FkDocumentos ' + NL +
                          ' order by PK_DOCUMENTOS_ITENS';

  SqlCarrierDocument    = 'select Dch.*, Rem.DOC_PRI as CNPJ_REM, Dst.DOC_PRI as CNPJ_DST, ' + NL +
                          '       Cns.DOC_PRI as CNPJ_CNS ' + NL +
                          '  from DOCUMENTOS_CONHECIMENTOS Dch ' + NL +
                          '  join CADASTROS Rem ' + NL +
                          '    on Rem.PK_CADASTROS       = Dch.FK_REMETENTE ' + NL +
                          '  join CADASTROS Dst ' + NL +
                          '    on Dst.PK_CADASTROS       = Dch.FK_DESTINATARIO ' + NL +
                          '  left outer join CADASTROS Cns ' + NL +
                          '    on Cns.PK_CADASTROS       = Dch.FK_CONSIGNATARIO ' + NL +
                          ' where Dch.FK_EMPRESAS        = :FkEmpresas ' + NL +
                          '   and Dch.FK_TIPO_DOCUMENTOS = :FkTipoDocumentos ' + NL +
                          '   and Dch.FK_CADASTROS       = :FkCadastros ' + NL +
                          '   and Dch.FK_DOCUMENTOS      = :FkDocumentos ';

  SqlInsertCarrierDoc   = 'insert into DOCUMENTOS_CONHECIMENTOS ' + NL +
                          '  (FK_EMPRESAS, FK_TIPO_DOCUMENTOS, FK_CADASTROS, ' + NL +
                          '   FK_DOCUMENTOS, FK_REMETENTE, FK_DESTINATARIO, ' + NL +
                          '   FK_CONSIGNATARIO, FK_PRODUTOS_FRETES, FK_GRUPOS_MOVIMENTOS, ' + NL +
                          '   FK_TIPO_TABELA_FRACAO, FK_TABELA_ORIGEM_DESTINO, ' + NL +
                          '   FLAG_ES, FLAG_REMB, FLAG_TP_FRE, VLR_FRE, PLC_VEI, ' + NL +
                          '   QTD_PROD, QTD_VOL, PES_LIQ, PES_BRU, NUM_VOL, TIPO_VOL, ' + NL +
                          '   MARCA_VOL, NUM_NF, VLR_NF, VLR_FRE_PESO, FRE_VLR, VLR_SECAT, ' + NL +
                          '   VLR_GRIS, VLR_PEDG, VLR_DIF_ACC, ALQT_ICMS, FK_TIPO_MOVIMENTOS) ' + NL +
                          'values ' + NL +
                          '  (:FkEmpresas, :FkTipoDocumentos, :FkCadastros, ' + NL +
                          '   :FkDocumentos, :FkRemetente, :FkDestinatario, ' + NL +
                          '   :FkConsignatario, :FkProdutosFretes, :FkGruposMovimentos, ' + NL +
                          '   :FkTipoTabelaFracao, :FkTabelaOrigemDestino, ' + NL +
                          '   :FlagES, :FlagRemb, :FlagTpFre, :VlrFre, :PlcVei, ' + NL +
                          '   :QtdProd, :QtdVol, :PesLiq, :PesBru, :NumVol, :TipoVol, ' + NL +
                          '   :MarcaVol, :NumNF, :VlrNF, :VlrFrePeso, :FreVlr, :VlrSecat, ' + NL +
                          '   :VlrGris, :VlrPedg, :VlrDifAcc, :AlqtIcms, :FkTipoMovimentos)';

  SqlSelCarrierDocWght  = 'select * from CONHECIMENTO_MEDIDAS ' + NL +
                          ' where FK_EMPRESAS        = :FkEmpresas ' + NL +
                          '   and FK_TIPO_DOCUMENTOS = :FkTipoDocumentos ' + NL +
                          '   and FK_CADASTROS       = :FkCadastros ' + NL +
                          '   and FK_DOCUMENTOS      = :FkDocumentos';

  SqlDelCarrierDocWght  = 'delete from CONHECIMENTO_MEDIDAS ' + NL +
                          ' where FK_EMPRESAS        = :FkEmpresas ' + NL +
                          '   and FK_TIPO_DOCUMENTOS = :FkTipoDocumentos ' + NL +
                          '   and FK_CADASTROS       = :FkCadastros ' + NL +
                          '   and FK_DOCUMENTOS      = :FkDocumentos';

  SqlInsCarrierDocWght  = 'insert into CONHECIMENTO_MEDIDAS ' + NL +
                          '  (FK_EMPRESAS, FK_TIPO_DOCUMENTOS, FK_CADASTROS, ' + NL +
                          '   FK_DOCUMENTOS, PK_CONHECIMENTO_MEDIDAS, ' + NL +
                          '   ALT_VOL, LARG_VOL, PROF_VOL) ' + NL +
                          'values ' + NL +
                          '  (:FkEmpresas, :FkTipoDocumentos, :FkCadastros, ' + NL +
                          '   :FkDocumentos, :PkConhecimentoMedidas, ' + NL +
                          '   :AltVol, :LargVol, :ProfVol)';

  SqlSelectDocumentItm  = 'select * from DOCUMENTOS_ITENS  ' + NL +
                          ' where FK_EMPRESAS        = :FkEmpresas ' + NL +
                          '   and FK_TIPO_DOCUMENTOS = :FkTipoDocumentos ' + NL +
                          '   and FK_CADASTROS       = :FkCadastros ' + NL +
                          '   and FK_DOCUMENTOS      = :FkDocumentos ' + NL +
                          ' order by PK_DOCUMENTOS_ITENS';

  SqlSelectDocumentMsg  = 'select * from DOCUMENTOS_OBSERVACOES '           + NL +
                          ' where FK_EMPRESAS        = :FkEmpresas ' + NL +
                          '   and FK_TIPO_DOCUMENTOS = :FkTipoDocumentos ' + NL +
                          '   and FK_CADASTROS       = :FkCadastros ' + NL +
                          '   and FK_DOCUMENTOS      = :FkDocumentos ' + NL +
                          ' order by DTHR_MSG';

  SqlDeleteDocumentMsg  = 'delete from DOCUMENTOS_OBSERVACOES '           + NL +
                          ' where FK_EMPRESAS        = :FkEmpresas ' + NL +
                          '   and FK_TIPO_DOCUMENTOS = :FkTipoDocumentos ' + NL +
                          '   and FK_CADASTROS       = :FkCadastros ' + NL +
                          '   and FK_DOCUMENTOS      = :FkDocumentos';

  SqlInsertDocumentMsg  = 'insert into DOCUMENTOS_OBSERVACOES ' + NL +
                          '  (FK_EMPRESAS, FK_TIPO_DOCUMENTOS, FK_CADASTROS, ' + NL +
                          '   FK_DOCUMENTOS, OBS_DOC) ' + NL +
                          'values ' + NL +
                          '  (:FkEmpresas, :FkTipoDocumentos, :FkCadastros, '     + NL +
                          '   :FkDocumentos, :ObsDoc)';

  SqlCarrierDocumentPrn = 'select Dch.*, Doc.*, Rem.DOC_PRI as CNPJ_REM, ' + NL +
                          '       Dst.DOC_PRI as CNPJ_DST, Cns.DOC_PRI as CNPJ_CNS ' + NL +
                          '  from DOCUMENTOS Doc ' + NL +
                          '  join DOCUMENTOS_CONHECIMENTOS Dch ' + NL +
                          '    on Dch.FK_EMPRESAS        = Doc.FK_EMPRESAS ' + NL +
                          '   and Dch.FK_TIPO_DOCUMENTOS = Doc.FK_TIPO_DOCUMENTOS ' + NL +
                          '   and Dch.FK_CADASTROS       = Doc.FK_CADASTROS ' + NL +
                          '   and Dch.FK_DOCUMENTOS      = Doc.PK_DOCUMENTOS  ' + NL +
                          '  join CADASTROS Rem ' + NL +
                          '    on Rem.PK_CADASTROS       = Dch.FK_REMETENTE ' + NL +
                          '  join CADASTROS Dst ' + NL +
                          '    on Dst.PK_CADASTROS       = Dch.FK_DESTINATARIO ' + NL +
                          '  left outer join CADASTROS Cns ' + NL +
                          '    on Cns.PK_CADASTROS       = Dch.FK_CONSIGNATARIO ' + NL +
                          ' where Doc.FK_EMPRESAS        = :FkEmpresas ' + NL +
                          '   and Doc.FK_TIPO_DOCUMENTOS = :FkTipoDocumentos ' + NL +
                          '   and Doc.FK_CADASTROS       = :FkCadastros ' + NL +
                          '   and Doc.PK_DOCUMENTOS      = :PkDocumentos ';

  SqlGenPkTypeManifest  = 'select R_PK_TIPO_MANIFESTOS as PK_TIPO_MANIFESTOS ' + NL +
                          '  from STP_GET_PK_TIPO_MANIFESTOS';

  SqlTypeManifests      = 'select * from TIPO_MANIFESTOS ' + NL +
                          ' order by DSC_TMNF';

  SqlTypeManifest       = 'select * from TIPO_MANIFESTOS ' + NL +
                          ' where PK_TIPO_MANIFESTOS = :PkTipoManifestos';

  SqlDeleteTypeManifest = 'delete from TIPO_MANIFESTOS ' + NL +
                          ' where PK_TIPO_MANIFESTOS = :PkTipoManifestos';

  SqlInsertTypeManifest = 'insert into TIPO_MANIFESTOS ' + NL +
                          '  (PK_TIPO_MANIFESTOS, FK_TIPO_DOCUMENTOS, DSC_TMNF, ' + NL +
                          '   FLAG_TCNH) ' + NL +
                          'values ' + NL +
                          '  (:PkTipoManifestos, :FkTipoDocumentos, :DscTMnf, ' + NL +
                          '   :FlagTCnh)';

  SqlUpdateTypeManifest = 'update TIPO_MANIFESTOS set ' + NL +
                          '       FK_TIPO_DOCUMENTOS = :FkTipoDocumentos, ' + NL +
                          '       DSC_TMNF           = :DscTMnf, ' + NL +
                          '       FLAG_TCNH          = :FlagTCnh ' + NL +
                          ' where PK_TIPO_MANIFESTOS = :PkTipoManifestos';

  SqlGenPkManifestStt   = 'select R_PK_MANIFESTOS_STATUS as PK_MANIFESTOS_STATUS ' + NL +
                          '  from STP_GET_PK_MANIFESTOS_STATUS';

  SqlManifestsStatus    = 'select * from MANIFESTOS_STATUS ' + NL +
                          ' order by DSC_MSTT';

  SqlManifestStatus     = 'select * from MANIFESTOS_STATUS ' + NL +
                          ' where PK_MANIFESTOS_STATUS = :PkManifestosStatus';

  SqlDeleteManifestStt  = 'delete from MANIFESTOS_STATUS ' + NL +
                          ' where PK_MANIFESTOS_STATUS = :PkManifestosStatus';

  SqlInsertManifestStt  = 'insert into MANIFESTOS_STATUS ' + NL +
                          '  (PK_MANIFESTOS_STATUS, DSC_MSTT, FLAG_NIV_OCC) ' + NL +
                          'values ' + NL +
                          '  (:PkManifestosStatus, :DscMStt, :FlagNivOcc)';

  SqlUpdateManifestStt  = 'update MANIFESTOS_STATUS set ' + NL +
                          '       DSC_MSTT             = :DscMStt, ' + NL +
                          '       FLAG_NIV_OCC         = :FlagNivOcc ' + NL +
                          ' where PK_MANIFESTOS_STATUS = :PkManifestosStatus';

  SqlGenPkManifest      = 'select R_PK_MANIFESTOS as PK_MANIFESTOS ' + NL +
                          '  from STP_GET_PK_MANIFESTOS';

  SqlManifests          = 'select * from MANIFESTOS ' + NL +
                          ' order by DTA_EMI';

  SqlManifest           = 'select * from MANIFESTOS ' + NL +
                          ' where FK_EMPRESAS   = :FkEmpresas ' + NL +
                          '   and PK_MANIFESTOS = :PkManifestos';

  SqlDeleteManifest     = 'delete from MANIFESTOS ' + NL +
                          ' where FK_EMPRESAS   = :FkEmpresas ' + NL +
                          '   and PK_MANIFESTOS = :PkManifestos';

  SqlInsertManifest     = 'insert into MANIFESTOS ' + NL +
                          '  (FK_EMPRESAS, PK_MANIFESTOS, FK_TIPO_MANIFESTOS, ' + NL +
                          '   FK_VEICULOS_MARCAS, FK_VEICULOS_MODELOS, ' + NL +
                          '   FK_VEICULOS, FK_FUNCIONARIOS__MOTORISTA, ' + NL +
                          '   FK_AGREGADO, FK_FUNCIONARIOS__CARGA, ' + NL +
                          '   FK_FUNCIONARIOS__CONFERENCIA, DTA_EMI, DTA_SAI, ' + NL +
                          '   FLAG_TOT, TOT_CNH, VLR_PDG, VLR_MRC, VLR_FRT_VST, ' + NL +
                          '   VLR_REMB) ' + NL +
                          'values ' + NL +
                          '  (:FkEmpresas, :PkManifestos, :FkTipoManifestos, ' + NL +
                          '   :FkVeiculosMarcas, :FkVeiculosModelos, ' + NL +
                          '   :FkVeiculos, :FkFuncionariosMotorista, ' + NL +
                          '   :FkAgregado, :FkFuncionariosCarga, ' + NL +
                          '   :FkFuncionariosConferencia, :DtaEmi, :DtaSai, ' + NL +
                          '   :FlagTot, :TotCnh, :VlrPdg, :VlrMrc, VlrFrtVst, ' + NL +
                          '   :VlrRemb)';

  SqlUpdateManifest     = 'update MANIFESTOS set ' + NL +
                          '       FK_TIPO_MANIFESTOS           = :FkTipoManifestos, ' + NL +
                          '       FK_VEICULOS_MARCAS           = :FkVeiculosMarcas, ' + NL +
                          '       FK_VEICULOS_MODELOS          = :FkVeiculosModelos, ' + NL +
                          '       FK_VEICULOS                  = :FkVeiculos, ' + NL +
                          '       FK_FUNCIONARIOS__MOTORISTA   = :FkFuncionariosMotorista, ' + NL +
                          '       FK_AGREGADO                  = :FkAgregado, ' + NL +
                          '       FK_FUNCIONARIOS__CARGA       = :FkFuncionariosCarga, ' + NL +
                          '       FK_FUNCIONARIOS__CONFERENCIA = :FkFuncionariosConferencia, ' + NL +
                          '       DTA_EMI                      = :DtaEmi, ' + NL +
                          '       DTA_SAI                      = :DtaSai, ' + NL +
                          '       FLAG_TOT                     = :FlagTot, ' + NL +
                          '       TOT_CNH                      = :TotCnh, ' + NL +
                          '       VLR_PDG                      = :VlrPdg, ' + NL +
                          '       VLR_MRC                      = :VlrMrc, ' + NL +
                          '       VLR_FRT_VST                  = :VlrFrtVst, ' + NL +
                          '       VLR_REMB                     = :VlrRemb ' + NL +
                          ' where FK_EMPRESAS                  = :FkEmpresas ' + NL +
                          '       PK_MANIFESTOS                = :PkManifestos';

  SqlManifestDocs       = 'select Mch.*, Dch.NUM_NF, Dch.FLAG_REMB, Dch.FLAG_TP_FRE, ' + NL +
                          '       Doc.DATA_DOC, Org.RAZ_SOC as DSC_ORGM, ' + NL +
                          '       Dst.RAZ_SOC as DSC_DSTN, Dch.VLR_FRE ' + NL +
                          '  from MANIFESTOS_CONHECIMENTOS Mch, DOCUMENTOS_CONHECIMENTOS Dch, ' + NL +
                          '       DOCUMENTOS Doc, CADASTROS Org, CADASTROS Dst ' + NL +
                          ' where Mch.FK_EMPRESAS        = :FkEmpresas ' + NL +
                          '   and Mch.FK_MANIFESTOS      = :FkManifestos ' + NL +
                          '   and Doc.FK_EMPRESAS        = Mch.FK_EMPRESAS ' + NL +
                          '   and Doc.FK_TIPO_DOCUMENTOS = Mch.FK_TIPO_DOCUMENTOS ' + NL +
                          '   and Doc.FK_CADASTROS       = Mch.FK_CADASTROS ' + NL +
                          '   and Doc.PK_DOCUMENTOS      = Mch.FK_DOCUMENTOS ' + NL +
                          '   and Dch.FK_EMPRESAS        = Mch.FK_EMPRESAS ' + NL +
                          '   and Dch.FK_TIPO_DOCUMENTOS = Mch.FK_TIPO_DOCUMENTOS ' + NL +
                          '   and Dch.FK_CADASTROS       = Mch.FK_CADASTROS ' + NL +
                          '   and Dch.FK_DOCUMENTOS      = Mch.FK_DOCUMENTOS ' + NL +
                          '   and Org.PK_CADASTROS       = Dch.FK_REMETENTE ' + NL +
                          '   and Dst.PK_CADASTROS       = Dch.FK_DESTINATARIO ' + NL +
                          ' order by Mch.FK_TIPO_DOCUMENTOS, Mch.FK_CADASTROS, Mch.FK_DOCUMENTOS';

  SqlDeleteManifestDoc  = 'delete from MANIFESTOS_CONHECIMENTOS ' + NL +
                          ' where FK_EMPRESAS        = :FkEmpresas ' + NL +
                          '   and FK_TIPO_DOCUMENTOS = :FkTipoDocumentos ' + NL +
                          '   and FK_CADASTROS       = :FkCadastros ' + NL +
                          '   and FK_DOCUMENTOS      = :FkDocumentos' + NL +
                          '   and FK_MANIFESTOS      = :FkManifestos';

  SqlInsertManifestDoc  = 'insert into MANIFESTOS_CONHECIMENTOS ' + NL +
                          '  (FK_EMPRESAS, FK_MANIFESTOS, FK_TIPO_DOCUMENTOS, ' + NL +
                          '   FK_CADASTROS, FK_DOCUMENTOS, FLAG_IMP_REC) ' + NL +
                          'values ' + NL +
                          '  (:FkEmpresas, :FkManifestos, :FkTipoDocumentos, ' + NL +
                          '   :FkCadastros, :FkDocumentos, :FlagImpRec)';

  SqlUpdateManifestDoc  = 'update MANIFESTOS set ' + NL +
                          '       FLAG_IMP_REC       = :FlagImpRec ' + NL +
                          ' where FK_EMPRESAS        = :FkEmpresas ' + NL +
                          '   and FK_TIPO_DOCUMENTOS = :FkTipoDocumentos ' + NL +
                          '   and FK_CADASTROS       = :FkCadastros ' + NL +
                          '   and FK_DOCUMENTOS      = :FkDocumentos' + NL +
                          '   and FK_MANIFESTOS      = :FkManifestos';

  SqlSelectAllVehicles1 = 'select Cast(0 as integer) as PK_TYPE_VEHICLE, ' + NL +
                          '       Cast(''Veículos Próprios'' as varchar(30)) as DSC_TVEI, ' + NL +
                          '       Pvl.FK_PRODUTOS as PK_OWNER, Mrc.PK_VEICULOS_MARCAS, ' + NL +
                          '       Mrc.DSC_MRC, Mod.PK_VEICULOS_MODELOS, ' + NL +
                          '       Mod.DSC_MOD, Vei.PK_VEICULOS, Prd.DSC_PROD as DSC_VEI ' + NL +
                          '  from PARAMETROS_GLOBAIS Pgb ' + NL +
                          '  left outer join VEICULOS_MARCAS Mrc ' + NL +
                          '    left outer join VEICULOS_MODELOS Mod ' + NL +
                          '      left join PATRIMONIO_VEICULOS Pvl ' + NL +
                          '        join VEICULOS Vei ' + NL +
                          '          on Vei.FK_VEICULOS_MARCAS  = Pvl.FK_VEICULOS_MARCAS ' + NL +
                          '         and Vei.FK_VEICULOS_MODELOS = Pvl.FK_VEICULOS_MODELOS ' + NL +
                          '        join PRODUTOS Prd ' + NL +
                          '          on Prd.PK_PRODUTOS         = Pvl.FK_PRODUTOS ' + NL +
                          '        on Pvl.FK_VEICULOS_MARCAS  = Mrc.PK_VEICULOS_MARCAS ' + NL +
                          '       and Pvl.FK_VEICULOS_MODELOS = Mod.PK_VEICULOS_MODELOS ' + NL +
                          '       and Vei.PK_VEICULOS         = Pvl.FK_VEICULOS ' + NL +
                          '      on Mod.FK_VEICULOS_MARCAS  = Mrc.PK_VEICULOS_MARCAS ' + NL +
                          '    on Mrc.PK_VEICULOS_MARCAS  > 0 ' + NL +
                          ' where Pgb.PK_PARAMETROS_GLOBAIS = 1 ';
  SqlSelectAllVehicles2 = 'union ';
  SqlSelectAllVehicles3 = 'select Cast(1 as integer) as PK_TYPE_VEHICLE, ' + NL +
                          '       Cast(''Veículos Tercerizados'' as varchar(30)) as DSC_TVEI, ' + NL +
                          '       Tvl.FK_CADASTROS as PK_OWNER, Mrc.PK_VEICULOS_MARCAS, ' + NL +
                          '       Mrc.DSC_MRC, Mod.PK_VEICULOS_MODELOS, ' + NL +
                          '       Mod.DSC_MOD, Vei.PK_VEICULOS, Tvl.DSC_VEI ' + NL +
                          '  from PARAMETROS_GLOBAIS Pgb ' + NL +
                          '  left outer join VEICULOS_MARCAS Mrc ' + NL +
                          '    left outer join VEICULOS_MODELOS Mod ' + NL +
                          '     left join TRANSPORTADORAS_VEICULOS Tvl ' + NL +
                          '       join VEICULOS Vei ' + NL +
                          '         on Vei.FK_VEICULOS_MARCAS  = Tvl.FK_VEICULOS_MARCAS ' + NL +
                          '        and Vei.FK_VEICULOS_MODELOS = Tvl.FK_VEICULOS_MODELOS ' + NL +
                          '        and Vei.PK_VEICULOS         = Tvl.FK_VEICULOS ' + NL +
                          '        on Tvl.FK_VEICULOS_MARCAS  = Mrc.PK_VEICULOS_MARCAS ' + NL +
                          '       and Tvl.FK_VEICULOS_MODELOS = Mod.PK_VEICULOS_MODELOS ' + NL +
                          '      on Mod.FK_VEICULOS_MARCAS  = Mrc.PK_VEICULOS_MARCAS ' + NL +
                          '    on Mrc.PK_VEICULOS_MARCAS  > 0 ' + NL +
                          ' where Pgb.PK_PARAMETROS_GLOBAIS = 1 ';
  SqlSelectAllVehicles4 = 'order by 1, 2, 5, 7';

  SqlPkGeneratorMark    = 'select R_PK_VEICULOS_MARCAS as PK_VEICULOS_MARCAS ' + NL +
                          '  from STP_GET_PK_VEICULOS_MARCAS';

  SqlSelectMarks        = 'select * from VEICULOS_MARCAS ' + NL +
                          ' order by DSC_MRC';

  SqlSelectMark         = 'select * from VEICULOS_MARCAS ' + NL +
                          ' where PK_VEICULOS_MARCAS = :PkVeiculosMarcas';

  SqlDeleteMark         = 'delete from VEICULOS_MARCAS ' + NL +
                          ' where PK_VEICULOS_MARCAS = :PkVeiculosMarcas';

  SqlUpdateMark         = 'update VEICULOS_MARCAS set ' + NL +
                          '       DSC_MRC            = :DscMrc ' + NL +
                          ' where PK_VEICULOS_MARCAS = :PkVeiculosMarcas';

  SqlInsertMark         = 'insert into VEICULOS_MARCAS ' + NL +
                          '  (PK_VEICULOS_MARCAS, DSC_MRC) ' + NL +
                          'values ' + NL +
                          '  (:PkVeiculosMarcas, :DscMrc)';

  SqlSelectMarkSupplier = 'select Fmr.FK_CADASTROS,  Fmr.FK_VEICULOS_MARCAS ' + NL +
                          '  from FORNECEDORES_MARCAS Fmr, CADASTROS Cad ' + NL +
                          ' where Fmr.FK_VEICULOS_MARCAS = :FkVeiculosMarcas ' + NL +
                          '   and Cad.PK_CADASTROS       = Fmr.FK_CADASTROS ' + NL +
                          ' order by RAZ_SOC';

  SqlDeleteMarkSupplier = 'delete from FORNECEDORES_MARCAS ' + NL +
                          ' where FK_VEICULOS_MARCAS = :FkVeiculosMarcas ' + NL +
                          '   and FK_CADASTROS       = :FkCadastros';

  SqlInsertMarkSupplier = 'insert into VEICULOS_MARCAS ' + NL +
                          '  (FK_VEICULOS_MARCAS, FK_CADASTROS) ' + NL +
                          'values ' + NL +
                          '  (:FkVeiculosMarcas, :FkCadastros)';

  SqlPkGeneratorModel   = 'select R_PK_VEICULOS_MODELOS as PK_VEICULOS_MODELOS ' + NL +
                          '  from STP_GET_PK_VEICULOS_MODELOS(:FkVeiculosMarcas)';

  SqlSelectModels       = 'select * from VEICULOS_MODELOS ' + NL +
                          ' where FK_VEICULOS_MARCAS  = :FkVeiculosMarcas ' + NL +
                          ' order by DSC_MOD';

  SqlSelectModel        = 'select * from VEICULOS_MODELOS ' + NL +
                          ' where FK_VEICULOS_MARCAS  = :FkVeiculosMarcas ' + NL +
                          '   and PK_VEICULOS_MODELOS = :PkVeiculosModelos';

  SqlDeleteModel        = 'delete from VEICULOS_MODELOS ' + NL +
                          ' where FK_VEICULOS_MARCAS  = :FkVeiculosMarcas ' + NL +
                          '   and PK_VEICULOS_MODELOS = :PkVeiculosModelos';

  SqlUpdateModel        = 'update VEICULOS_MODELOS set ' + NL +
                          '       DSC_MOD             = :DscMod, ' + NL +
                          '       ANO_FINI            = :AnoFIni, ' + NL +
                          '       ANO_FFIN            = :AnoFFin ' + NL +
                          ' where FK_VEICULOS_MARCAS  = :FkVeiculosMarcas ' + NL +
                          '   and PK_VEICULOS_MODELOS = :PkVeiculosModelos';

  SqlInsertModel        = 'insert into VEICULOS_MODELOS ' + NL +
                          '  (FK_VEICULOS_MARCAS, PK_VEICULOS_MODELOS, DSC_MOD, ' + NL +
                          '   ANO_FINI, ANO_FFIN) ' + NL +
                          'values ' + NL +
                          '  (:FkVeiculosMarcas, :PkVeiculosModelos, :DscMod, ' + NL +
                          '   :AnoFIni, :AnoFFin)';

  SqlPkGeneratorVehicle = 'select R_PK_VEICULOS as PK_VEICULOS ' + NL +
                          '  from STP_GET_PK_VEICULOS(:FkVeiculosMarcas, :FkVeiculosModelos)';

  SqlSelectVehicles1    = 'select Cast(0 as integer) as PK_TYPE_VEHICLE, ' + NL +
                          '       Cast(''Veículos Próprios'' as varchar(30)) as DSC_TVEI, ' + NL +
                          '       Pvl.FK_PRODUTOS as PK_OWNER, Mrc.PK_VEICULOS_MARCAS, ' + NL +
                          '       Mrc.DSC_MRC, Mod.PK_VEICULOS_MODELOS, ' + NL +
                          '       Mod.DSC_MOD, Vei.PK_VEICULOS, Prd.DSC_PROD as DSC_VEI, ' + NL +
                          '       Vei.PLACA_VCL, Vei.CPCD_VCL, Vei.ANO_VCL ' + NL +
                          '  from PARAMETROS_GLOBAIS Pgb ' + NL;
  SqlSelectVehicles2    = '  left outer join VEICULOS_MARCAS Mrc ' + NL +
                          '    left outer join VEICULOS_MODELOS Mod ' + NL +
                          '      left join PATRIMONIO_VEICULOS Pvl ' + NL +
                          '        join VEICULOS Vei ' + NL +
                          '          on Vei.FK_VEICULOS_MARCAS  = Pvl.FK_VEICULOS_MARCAS ' + NL +
                          '         and Vei.FK_VEICULOS_MODELOS = Pvl.FK_VEICULOS_MODELOS ' + NL +
                          '        join PRODUTOS Prd ' + NL +
                          '          on Prd.PK_PRODUTOS         = Pvl.FK_PRODUTOS ' + NL +
                          '        on Pvl.FK_VEICULOS_MARCAS  = Mrc.PK_VEICULOS_MARCAS ' + NL +
                          '       and Pvl.FK_VEICULOS_MODELOS = Mod.PK_VEICULOS_MODELOS ' + NL +
                          '       and Vei.PK_VEICULOS         = Pvl.FK_VEICULOS ' + NL +
                          '      on Mod.FK_VEICULOS_MARCAS  = Mrc.PK_VEICULOS_MARCAS ' + NL +
                          '     and Mod.PK_VEICULOS_MODELOS = :FkVeiculosModelos ' + NL +
                          '    on Mrc.PK_VEICULOS_MARCAS  = :FkVeiculosMarcas ' + NL +
                          ' where Pgb.PK_PARAMETROS_GLOBAIS = 1 ' + NL +
                          'union ' + NL;
  SqlSelectVehicles3    = 'select Cast(1 as integer) as PK_TYPE_VEHICLE, ' + NL +
                          '       Cast(''Veículos Tercerizados'' as varchar(30)) as DSC_TVEI, ' + NL +
                          '       Tvl.FK_CADASTROS as PK_OWNER, Mrc.PK_VEICULOS_MARCAS, ' + NL +
                          '       Mrc.DSC_MRC, Mod.PK_VEICULOS_MODELOS, ' + NL +
                          '       Mod.DSC_MOD, Vei.PK_VEICULOS, Tvl.DSC_VEI, ' + NL +
                          '       Vei.PLACA_VCL, Vei.CPCD_VCL, Vei.ANO_VCL ' + NL +
                          '  from PARAMETROS_GLOBAIS Pgb ' + NL +
                          '  left outer join VEICULOS_MARCAS Mrc ' + NL +
                          '    left outer join VEICULOS_MODELOS Mod ' + NL +
                          '     left join TRANSPORTADORAS_VEICULOS Tvl ' + NL +
                          '       join VEICULOS Vei ' + NL +
                          '         on Vei.FK_VEICULOS_MARCAS  = Tvl.FK_VEICULOS_MARCAS ' + NL +
                          '        and Vei.FK_VEICULOS_MODELOS = Tvl.FK_VEICULOS_MODELOS ' + NL +
                          '        and Vei.PK_VEICULOS         = Tvl.FK_VEICULOS ' + NL +
                          '        on Tvl.FK_VEICULOS_MARCAS  = Mrc.PK_VEICULOS_MARCAS ' + NL +
                          '       and Tvl.FK_VEICULOS_MODELOS = Mod.PK_VEICULOS_MODELOS ' + NL +
                          '      on Mod.FK_VEICULOS_MARCAS  = Mrc.PK_VEICULOS_MARCAS ' + NL +
                          '     and Mod.PK_VEICULOS_MODELOS = :FkVeiculosModelos ' + NL +
                          '    on Mrc.PK_VEICULOS_MARCAS  = :FkVeiculosMarcas ' + NL;
  SqlSelectVehicles4    = ' where Pgb.PK_PARAMETROS_GLOBAIS = 1 ' + NL +
                          ' order by 1, 2, 5';

  SqlSelectVehicle      = 'select * from VEICULOS ' + NL +
                          ' where FK_VEICULOS_MARCAS  = :FkVeiculosMarcas ' + NL +
                          '   and FK_VEICULOS_MODELOS = :FkVeiculosModelos ' + NL +
                          '   and PK_VEICULOS         = :PkVeiculos';

  SqlDeleteVehicle      = 'delete from VEICULOS ' + NL +
                          ' where FK_VEICULOS_MARCAS  = :FkVeiculosMarcas ' + NL +
                          '   and FK_VEICULOS_MODELOS = :FkVeiculosModelos ' + NL +
                          '   and PK_VEICULOS         = :PkVeiculos';

  SqlUpdateVehicle      = 'update VEICULOS set ' + NL +
                          '       FK_CENTRO_CUSTOS    = :FkCentroCustos, ' + NL +
                          '       ANO_VCL             = :AnoVcl, ' + NL +
                          '       CPCD_VCL            = :CpCdVcl, ' + NL +
                          '       PLACA_VCL           = :PlacaVcl ' + NL +
                          ' where FK_VEICULOS_MARCAS  = :FkVeiculosMarcas ' + NL +
                          '   and FK_VEICULOS_MODELOS = :FkVeiculosModelos ' + NL +
                          '   and PK_VEICULOS         = :PkVeiculos';

  SqlInsertVehicle      = 'insert into VEICULOS ' + NL +
                          '  (FK_VEICULOS_MARCAS, FK_VEICULOS_MODELOS, PK_VEICULOS, ' + NL +
                          '   ANO_VCL, CPCD_VCL, PLACA_VCL) ' + NL +
                          'values ' + NL +
                          '  (:FkVeiculosMarcas, :FkVeiculosModelos, :PkVeiculos, ' + NL +
                          '   :AnoVcl, :CpCdVcl, :PlacaVcl)';

  SqlSelectVehicleObs   = 'select * from VEICULOS_OBSERVACOES ' + NL +
                          ' where FK_VEICULOS_MARCAS  = :FkVeiculosMarcas ' + NL +
                          '   and FK_VEICULOS_MODELOS = :FkVeiculosModelos ' + NL +
                          '   and FK_VEICULOS         = :FkVeiculos';

  SqlDeleteVehicleObs   = 'delete from VEICULOS_OBSERVACOES ' + NL +
                          ' where FK_VEICULOS_MARCAS  = :FkVeiculosMarcas ' + NL +
                          '   and FK_VEICULOS_MODELOS = :FkVeiculosModelos ' + NL +
                          '   and FK_VEICULOS         = :FkVeiculos';

  SqlInsertVehicleObs   = 'insert into VEICULOS_OBSERVACOES ' + NL +
                          '  (FK_VEICULOS_MARCAS, FK_VEICULOS_MODELOS, FK_VEICULOS, ' + NL +
                          '   OBS_VCL) ' + NL +
                          'values ' + NL +
                          '  (:FkVeiculosMarcas, :FkVeiculosModelos, :FkVeiculos, ' + NL +
                          '   :ObsVcl)';

  SqlUpdateVehicleObs   = 'update VEICULOS_OBSERVACOES set ' + NL +
                          '       OBS_VCL             = :ObsVcl ' + NL +
                          ' where FK_VEICULOS_MARCAS  = :FkVeiculosMarcas ' + NL +
                          '   and FK_VEICULOS_MODELOS = :FkVeiculosModelos ' + NL +
                          '   and FK_VEICULOS         = :FkVeiculos';

  SqlPkGenVehicleImage  = 'select R_PK_VEICULOS_IMAGENS as PK_VEICULOS_IMAGENS ' + NL +
                          '  from STP_GET_PK_VEICULOS_IMAGENS(:FkVeiculosMarcas, :FkVeiculosModelos, :FkVeiculos)';

  SqlSelectVehicleImage = 'select * from VEICULOS_IMAGENS ' + NL +
                          ' where FK_VEICULOS_MARCAS  = :FkVeiculosMarcas ' + NL +
                          '   and FK_VEICULOS_MODELOS = :FkVeiculosModelos ' + NL +
                          '   and FK_VEICULOS         = :FkVeiculos ' + NL +
                          ' order by PK_VEICULOS_IMAGENS';

  SqlDeleteVehicleImage = 'delete from VEICULOS_IMAGENS ' + NL +
                          ' where FK_VEICULOS_MARCAS  = :FkVeiculosMarcas ' + NL +
                          '   and FK_VEICULOS_MODELOS = :FkVeiculosModelos ' + NL +
                          '   and FK_VEICULOS         = :FkVeiculos ' + NL +
                          '   and PK_VEICULOS_IMAGENS = :PkVeiculosImagens';

  SqlInsertVehicleImage = 'insert into VEICULOS_IMAGENS ' + NL +
                          '  (FK_VEICULOS_MARCAS, FK_VEICULOS_MODELOS, PK_VEICULOS, ' + NL +
                          '   PK_VEICULOS_IMAGENS, IMG_VCL) ' + NL +
                          'values ' + NL +
                          '  (:FkVeiculosMarcas, :FkVeiculosModelos, :FkVeiculos, ' + NL +
                          '   :PkVeiculosImagens, :ImgVcl)';

  SqlUpdateVehicleImage = 'update VEICULOS_IMAGENS set ' + NL +
                          '       IMG_VCL             = :ImgVcl ' + NL +
                          ' where FK_VEICULOS_MARCAS  = :FkVeiculosMarcas ' + NL +
                          '   and FK_VEICULOS_MODELOS = :FkVeiculosModelos ' + NL +
                          '   and FK_VEICULOS         = :FkVeiculos ' + NL +
                          '   and PK_VEICULOS_IMAGENS = :PkVeiculosImagens';

  SqlSelectPropVehicle  = 'select Prd.*, Ptv.FK_PRODUTOS ' + NL +
                          '  from PATRIMONIO_VEICULOS Ptv, PRODUTOS Prd' + NL +
                          ' where Ptv.FK_VEICULOS_MARCAS  = :FkVeiculosMarcas ' + NL +
                          '   and Ptv.FK_VEICULOS_MODELOS = :FkVeiculosModelos ' + NL +
                          '   and Ptv.FK_VEICULOS         = :FkVeiculos ' + NL +
                          '   and Prd.PK_PRODUTOS         = Ptv.FK_PRODUTOS';

  SqlInsertPropVehicle  = 'insert into PATRIMONIO_VEICULOS ' + NL +
                          '  (FK_VEICULOS_MARCAS, FK_VEICULOS_MODELOS, FK_VEICULOS, ' + NL +
                          '   FK_PRODUTOS) ' + NL +
                          'values ' + NL +
                          '  (:FkVeiculosMarcas, :FkVeiculosModelos, :FkVeiculos, ' + NL +
                          '   :FkProdutos)';

  SqlSelectOwnerVehicle = 'select * from TRANSPORTADORAS_VEICULOS ' + NL +
                          ' where FK_VEICULOS_MARCAS  = :FkVeiculosMarcas ' + NL +
                          '   and FK_VEICULOS_MODELOS = :FkVeiculosModelos ' + NL +
                          '   and FK_VEICULOS         = :FkVeiculos';

  SqlDeleteOwnerVehicle = 'delete from TRANSPORTADORAS_VEICULOS ' + NL +
                          ' where FK_VEICULOS_MARCAS  = :FkVeiculosMarcas ' + NL +
                          '   and FK_VEICULOS_MODELOS = :FkVeiculosModelos ' + NL +
                          '   and FK_VEICULOS         = :FkVeiculos';

  SqlInsertOwnerVehicle = 'insert into TRANSPORTADORAS_VEICULOS ' + NL +
                          '  (FK_VEICULOS_MARCAS, FK_VEICULOS_MODELOS, FK_VEICULOS, ' + NL +
                          '   FK_CADASTROS) ' + NL +
                          'values ' + NL +
                          '  (:FkVeiculosMarcas, :FkVeiculosModelos, :FkVeiculos, ' + NL +
                          '   :FkCadastros)';

  SqlSearchCarrierDocs  = 'select Dch.NUM_NF, Dch.FLAG_REMB, Dch.FLAG_TP_FRE, ' + NL +
                          '       Doc.DATA_DOC, Org.RAZ_SOC as DSC_ORGM, ' + NL +
                          '       Dst.RAZ_SOC as DSC_DSTN, Dch.VLR_FRE ' + NL +
                          '  from DOCUMENTOS_CONHECIMENTOS Dch, ' + NL +
                          '       DOCUMENTOS Doc, CADASTROS Org, CADASTROS Dst ' + NL +
                          ' where Dch.FK_EMPRESAS        = :FkEmpresas ' + NL +
                          '   and ((Dch.FK_DOCUMENTOS    = :FkDocumentos) ' + NL +
                          '    or ( 0                    = :FkDocumentos)) ' + NL +
                          '   and ((Dhc.NUM_NF           = :NumNf) ' + NL +
                          '    or ( 0                    = :NumNf) ' + NL +
                          '   and Org.PK_CADASTROS       = Dch.FK_REMETENTE ' + NL +
                          '   and Dst.PK_CADASTROS       = Dch.FK_DESTINATARIO ' + NL +
                          '   and Doc.FK_EMPRESAS        = Dch.FK_EMPRESAS ' + NL +
                          '   and Doc.FK_TIPO_DOCUMENTOS = Dch.FK_TIPO_DOCUMENTOS ' + NL +
                          '   and Doc.FK_CADASTROS       = Dch.FK_CADASTROS ' + NL +
                          '   and Doc.PK_DOCUMENTOS      = Dch.FK_DOCUMENTOS ' + NL +
                          '   and ((Doc.DATA_DOC        >= :StartDate) ' + NL +
                          '    or ( Cast(0 as Date)      = :StartDate)) ' + NL +
                          '   and ((Doc.DATA_DOC        >= :EndDate) ' + NL +
                          '    or ( Cast(0 as Date)      = :EndDate)) ' + NL +
                          ' order by Doc.DATA_DOC, Doc.PK_DOCUMENTOS';

  // Sql for other modules

  SqlGeneratePkProduct  = 'select R_PK_PRODUTOS as PK_PRODUTOS ' + NL +
                          '  from STP_GET_PK_PRODUTOS';

  SqlDeleteProduct      = 'delete from PRODUTOS '             + NL +
                          ' where PK_PRODUTOS = :PkProdutos ';

  SqlUpdateProduct      = 'update PRODUTOS set '                 + NL +
                          '       FK_PRODUTOS_GRUPOS = :FkProdutosGrupos, ' + NL +
                          '       FK_UNIDADES  = :FkUnidades, '  + NL +
                          '       DSC_PROD     = :DscProd, '     + NL +
                          '       FLAG_ATV     = :FlagAtv '      + NL +
                          ' where PK_PRODUTOS  = :PkProdutos';

  SqlInsertProduct      = 'insert into PRODUTOS '                                + NL +
                          '  (FK_PRODUTOS_GRUPOS, FK_UNIDADES, ' + NL +
                          '   DSC_PROD, FLAG_ATV, PK_PRODUTOS) '                 + NL +
                          'values '                                              + NL +
                          '  (:FkProdutosGrupos, :FkUnidades, ' + NL +
                          '   :DscProd, :FlagAtv, :PkProdutos)';

  SqlModuleParams       = 'select Ppd.FK_TIPO_STATUS_PEDIDOS, Tps.FK_GRUPOS_MOVIMENTOS, ' + NL +
                          '       Ptr.IDX_CONV, Ptr.FK_TIPO_PAGAMENTOS, ' + NL +
                          '       Ptr.FK_TIPO_MOVIMENTOS, Ptr.FK_CARGOS_MOTORISTAS, ' + NL +
                          '       Ptr.FK_CARGOS_CONFERENTES, Ptr.FK_CARGOS_CARREGADORES, ' + NL +
                          '       Pgl.FK_CLIENTES, Pft.FK_TIPO_DOCUMENTOS ' + NL +
                          '  from PARAMETROS_PED Ppd ' + NL +
                          '  join PARAMETROS_GLOBAIS Pgl ' + NL +
                          '    on Pgl.PK_PARAMETROS_GLOBAIS = 1 ' + NL +
                          '  join TIPO_STATUS_PEDIDOS Tps ' + NL +
                          '    on Tps.PK_TIPO_STATUS_PEDIDOS = Ppd.FK_TIPO_STATUS_PEDIDOS ' + NL +
                          '  left outer join PARAMETROS_TRANS Ptr ' + NL +
                          '    on Ptr.PK_PARAMETROS_TRANS    = 1 ' + NL +
                          '  left outer join PARAMETROS_FAT Pft ' + NL +
                          '    on Pft.PK_PARAMETROS_FAT      = 1 ' + NL +
                          ' where Ppd.FK_EMPRESAS            = :FkEmpresas ' + NL +
                          '   and Ppd.PK_PARAMETROS_PED      = :PkParametrosPed';

  SqlOrder              = 'select * from PEDIDOS ' + NL +
                          ' where FK_EMPRESAS = :FkEmpresas ' + NL +
                          '   and PK_PEDIDOS  = :PkPedidos ';

  SqlTypeDocument       = 'select * from TIPO_DOCUMENTOS ' + NL +
                          ' order by DSC_TDOC';

  SqlCostsCenter        = 'select * from CENTRO_CUSTOS ' + NL +
                          ' order by DSC_CCST';

  SqlUnidades           = 'select * from UNIDADES ' + NL +
                          ' order by DSC_UNI';

  SqlSelectGroups       = 'select * from STP_GET_PRODUCT_GROUPS';

  SqlDocument           = 'select * from DOCUMENTOS ' + NL +
                          ' where FK_EMPRESAS        = :FkEmpresas ' + NL +
                          '   and FK_TIPO_DOCUMENTOS = :FkTipoDocumentos ' + NL +
                          '   and FK_CADASTROS       = :FkCadastros ' + NL +
                          '   and PK_DOCUMENTOS      = :PkDocumentos';

  SqlCountries          = 'select * from PAISES ' + NL +
                          ' where FLAG_ATU = 1 ' + NL +
                          ' order by DSC_PAIS';

  SqlStates             = 'select Pai.PK_PAISES, Pai.DSC_PAIS, Est.PK_ESTADOS, ' + NL +
                          '       Est.DSC_UF, Est.FK_CARGAS_REGIOES ' + NL +
                          '  from PAISES Pai, ESTADOS Est ' + NL +
                          ' where Pai.PK_PAISES = :FkPaises ' + NL +
                          '   and Est.FK_PAISES = Pai.PK_PAISES ' + NL +
                          ' order by Est.DSC_UF';

  SqlCities             = 'select Pai.PK_PAISES, Pai.DSC_PAIS, Est.PK_ESTADOS, ' + NL +
                          '       Est.DSC_UF, Mun.DSC_MUN, Mun.PK_MUNICIPIOS, ' + NL +
                          '       Est.FK_CARGAS_REGIOES as FK_CARGAS_REGIOES_EST, ' + NL +
                          '       Mun.FK_CARGAS_REGIOES as FK_CARGAS_REGIOES_MUN ' + NL +
                          '  from PAISES Pai, ESTADOS Est, MUNICIPIOS Mun' + NL +
                          ' where Pai.PK_PAISES  = :FkPaises ' + NL +
                          '   and Est.FK_PAISES  = Pai.PK_PAISES ' + NL +
                          '   and Est.PK_ESTADOS = :FkEstados ' + NL +
                          '   and Mun.FK_PAISES  = Pai.PK_PAISES ' + NL +
                          '   and Mun.FK_ESTADOS = Est.PK_ESTADOS ' + NL +
                          ' order by DSC_MUN';

  SqlRegions            = 'select * from CARGAS_REGIOES ' + NL +
                          ' where PK_CARGAS_REGIOES = :FkCargasRegioes ' + NL +
                          ' order by DSC_REG';

  SqlPriceTables1       = 'select Tab.PK_TABELA_PRECOS, Tab.DSC_TAB, Tab.FLAG_DEFTAB, ' + NL +
                          '       Tab.PERC_DSCT, Tfr.PK_TIPO_TABELA_FRACAO, ' + NL +
                          '       Tfr.DSC_TAB as DSC_FRAC, Tfr.FLAG_TIPO, ' + NL +
                          '       Tod.PK_TABELA_ORIGEM_DESTINO ' + NL +
                          '  from TABELA_TRANSPORTES Ttr, TABELA_PRECOS Tab, ' + NL +
                          '       TIPO_TABELA_FRACAO Tfr, TABELA_ORIGEM_DESTINO Tod, ' + NL +
                          '       CARGAS_REGIOES Org, CARGAS_REGIOES Dst ';
  SqlPriceTables2       = ' where ((Ttr.FK_TABELA_PRECOS        = :FkTabelaPrecos) ' + NL +
                          '    or ( 0                           = :FkTabelaPrecos)) ' + NL +
                          '   and Tab.PK_TABELA_PRECOS          = Ttr.FK_TABELA_PRECOS ' + NL +
                          '   and ((Tab.FLAG_DEFTAB             = :FlagDefTab) ' + NL +
                          '    or ( -1                          = :FlagDefTab)) ' + NL +
                          '   and DTA_INI                      <= current_date ' + NL +
                          '   and ((DTA_FIN                    >= current_date) ' + NL +
                          '    or ( DTA_FIN                    is null)) ' + NL +
                          '   and Tfr.PK_TIPO_TABELA_FRACAO     = Ttr.FK_TIPO_TABELA_FRACAO ' + NL +
                          '   and Tod.PK_TABELA_ORIGEM_DESTINO  = Ttr.FK_TABELA_ORIGEM_DESTINO ' + NL +
                          '   and Tod.FK_CARGAS_REGIOES__ORG    = :FkCargasRegioesOrg ' + NL +
                          '   and Tod.FK_CARGAS_REGIOES__DST    = :FkCargasRegioesDst ' + NL +
                          '   and Org.PK_CARGAS_REGIOES         = Tod.FK_CARGAS_REGIOES__ORG ' + NL +
                          '   and Dst.PK_CARGAS_REGIOES         = Tod.FK_CARGAS_REGIOES__DST ' + NL +
                          ' order by Tab.DSC_TAB, Tfr.DSC_TAB';

  SqlProducts           = 'select * from VW_FRETES order by DSC_PROD';

  SqlOwnerRegion        = 'select Est.FK_CARGAS_REGIOES as FK_REGIOES_UF, ' + NL +
                          '       Mun.FK_CARGAS_REGIOES as FK_REGIOES_MUN ' + NL +
                          '  from CADASTROS Cad, PAISES Pais, ESTADOS Est, ' + NL +
                          '       MUNICIPIOS Mun ' + NL +
                          ' where Cad.PK_CADASTROS  = :FkCadastros ' + NL +
                          '   and Pais.PK_PAISES    = Cad.FK_PAISES ' + NL +
                          '   and Est.FK_PAISES     = Cad.FK_PAISES ' + NL +
                          '   and Est.PK_ESTADOS    = Cad.FK_ESTADOS ' + NL +
                          '   and Mun.FK_PAISES     = Cad.FK_PAISES ' + NL +
                          '   and Mun.FK_ESTADOS    = Cad.FK_ESTADOS ' + NL +
                          '   and Mun.PK_MUNICIPIOS = Cad.FK_MUNICIPIOS';

  SqlCustomerFromPk     = 'select Cad.*, Cli.*, Pais.DSC_PAIS, Uf.DSC_UF, ' + NL +
                          '       Uf.FK_CARGAS_REGIOES as FK_REGION_UF, ' + NL +
                          '       Mun.FK_CARGAS_REGIOES as FK_REGION_MUN, ' + NL +
                          '       Mun.DSC_MUN, Ali.PK_TIPO_ALIAS, Ali.DSC_ALIAS ' + NL +
                          '  from CADASTROS Cad ' + NL +
                          '  left outer join TIPO_ALIAS Ali ' + NL +
                          '    on Ali.PK_TIPO_ALIAS = Cad.FK_TIPO_ALIAS ' + NL +
                          '  left outer join CLIENTES Cli ' + NL +
                          '    on Cli.FK_CADASTROS  = Cad.PK_CADASTROS ' + NL +
                          '  join PAISES Pais ' + NL +
                          '    on Pais.PK_PAISES    = Cad.FK_PAISES ' + NL +
                          '  join ESTADOS Uf ' + NL +
                          '    on Uf.FK_PAISES      = Cad.FK_PAISES ' + NL +
                          '   and Uf.PK_ESTADOS     = Cad.FK_ESTADOS ' + NL +
                          '  join MUNICIPIOS Mun ' + NL +
                          '    on Mun.FK_PAISES     = Cad.FK_PAISES ' + NL +
                          '   and Mun.FK_ESTADOS    = Cad.FK_ESTADOS ' + NL +
                          '   and Mun.PK_MUNICIPIOS = Cad.FK_MUNICIPIOS ' + NL +
                          ' where Cad.PK_CADASTROS  = :PkCadastros';

  SqlCustomerFromDoc    = 'select Cad.*, Cli.*, Pais.DSC_PAIS, Uf.DSC_UF, ' + NL +
                          '       Uf.FK_CARGAS_REGIOES as FK_REGION_UF, ' + NL +
                          '       Mun.FK_CARGAS_REGIOES as FK_REGION_MUN, ' + NL +
                          '       Mun.DSC_MUN, Ali.PK_TIPO_ALIAS, Ali.DSC_ALIAS ' + NL +
                          '  from CADASTROS Cad ' + NL +
                          '  left outer join TIPO_ALIAS Ali ' + NL +
                          '    on Ali.PK_TIPO_ALIAS = Cad.FK_TIPO_ALIAS ' + NL +
                          '  left outer join CLIENTES Cli ' + NL +
                          '    on Cli.FK_CADASTROS  = Cad.PK_CADASTROS ' + NL +
                          '  join PAISES Pais ' + NL +
                          '    on Pais.PK_PAISES    = Cad.FK_PAISES ' + NL +
                          '  join ESTADOS Uf ' + NL +
                          '    on Uf.FK_PAISES      = Cad.FK_PAISES ' + NL +
                          '   and Uf.PK_ESTADOS     = Cad.FK_ESTADOS ' + NL +
                          '  join MUNICIPIOS Mun ' + NL +
                          '    on Mun.FK_PAISES     = Cad.FK_PAISES ' + NL +
                          '   and Mun.FK_ESTADOS    = Cad.FK_ESTADOS ' + NL +
                          '   and Mun.PK_MUNICIPIOS = Cad.FK_MUNICIPIOS ' + NL +
                          ' where Cad.FLAG_TCAD     = :FlagTCad ' + NL +
                          '   and Cad.DOC_PRI       = :DocPri';

  SqlSupplierFromDoc    = 'select Cad.*, Frn.*, Pais.DSC_PAIS, Uf.DSC_UF, ' + NL +
                          '       Uf.FK_CARGAS_REGIOES as FK_REGION_UF,  ' + NL +
                          '       Mun.FK_CARGAS_REGIOES as FK_REGION_MUN, '  + NL +
                          '       Mun.DSC_MUN ' + NL +
                          '       Mun.DSC_MUN, Ali.PK_TIPO_ALIAS, Ali.DSC_ALIAS ' + NL +
                          '  from CADASTROS Cad ' + NL +
                          '  left outer join TIPO_ALIAS Ali ' + NL +
                          '    on Ali.PK_TIPO_ALIAS = Cad.FK_TIPO_ALIAS ' + NL +
                          '  join FORNECEDORES Frn ' + NL +
                          '    on Frn.FK_CADASTROS  = Cad.PK_CADASTROS ' + NL +
                          '  join PAISES Pais ' + NL +
                          '    on Pais.PK_PAISES    = Cad.FK_PAISES ' + NL +
                          '  join ESTADOS Uf ' + NL +
                          '    on Uf.FK_PAISES      = Cad.FK_PAISES ' + NL +
                          '   and Uf.PK_ESTADOS     = Cad.FK_ESTADOS ' + NL +
                          '  join MUNICIPIOS Mun ' + NL +
                          '    on Mun.FK_PAISES     = Cad.FK_PAISES ' + NL +
                          '   and Mun.FK_ESTADOS    = Cad.FK_ESTADOS ' + NL +
                          '   and Mun.PK_MUNICIPIOS = Cad.FK_MUNICIPIOS ' + NL +
                          ' where Cad.FLAG_TCAD     = :FlagTCad ' + NL +
                          '   and Cad.DOC_PRI       = :DocPri';

  SqlPartners           = 'select * from VW_REPRESENTANTES ' + NL +
                          ' order by RAZ_SOC';

  SqlSalers             = 'select * from VW_VENDEDORES ' + NL +
                          ' order by RAZ_SOC';

  SqlCarriers           = 'select * from VW_TRANSPORTADORAS ' + NL +
                          ' order by RAZ_SOC';

  SqlEmployees          = 'select Cad.*, Fun.FK_TIPO_CARGOS  ' + NL +
                          '  from CADASTROS Cad, FUNCIONARIOS Fun ' + NL +
                          ' where Fun.FK_CADASTROS   = Cad.PK_CADASTROS ' + NL +
                          '   and Fun.FK_TIPO_CARGOS = :FkTipoCargos ' + NL +
                          ' order by RAZ_SOC';

  SqlSuppliers          = 'select PK_CADASTROS, RAZ_SOC, ' + NL +
                          '       Cast(3 as smallint) as STATUS ' + NL +
                          '  from VW_FORNECEDORES ' + NL +
                          ' order by RAZ_SOC';

  SqlVinculoTProd       = 'select Tpr.DSC_TPRD, Tpr.FLAG_TPROD, '               + NL +
                          '       Tpr.PK_TIPO_PRODUTOS, Pxt.FK_PRODUTOS, '      + NL +
                          '       Cast(3 as smallint) as STATUS '               + NL +
                          '  from TIPO_PRODUTOS Tpr '                           + NL +
                          '  left outer join PRODUTOS_TIPO_PRODUTOS Pxt '     + NL +
                          '    on Pxt.FK_TIPO_PRODUTOS = Tpr.PK_TIPO_PRODUTOS ' + NL +
                          '   and Pxt.FK_PRODUTOS      = :FkProdutos '          + NL +
                          ' where Tpr.PK_TIPO_PRODUTOS > 0 '                    + NL +
                          '   and Tpr.FLAG_TPROD       = 4 ' + NL +
                          ' order by Tpr.DSC_TPRD';

implementation

end.
