object dmCargas: TdmCargas
  OldCreateOrder = False
  Left = 102
  Top = 114
  Height = 376
  Width = 853
  object tr: TIBTransaction
    DefaultDatabase = Dados.Conexao
    Left = 108
    Top = 60
  end
  object qrItemsPedidos: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      
        'select p.flag_vinc_ped, p.dta_ped, p.flag_entr_parc, p.fk_tipo_p' +
        'edidos, i.fk_pedidos, i.pk_pedidos_itens, i.cod_ref_item, i.qtd_' +
        'item, f.fk_pecas, f.pk_ficha_tecnica as fk_ficha_tecnica,'
      'f.dsc_pec,'
      'pr.alt_prod, pr.prof_prod, pr.larg_prod,'
      'c.raz_soc,'
      'm.fk_cargas_regioes, r.ref_reg, r.dsc_reg, 0.0 As M3'
      'from pedidos_itens i, pedidos p, vw_clientes c, municipios m,'
      'produtos pr, pecas pc, ficha_tecnica f, cargas_regioes r'
      'where p.fk_empresas=:fk_empresas'
      
        'and i.fk_empresas=p.fk_empresas and i.fk_tipo_pedidos=p.fk_tipo_' +
        'pedidos'
      'and i.fk_pedidos=p.pk_pedidos and i.fk_cargas_producao is null'
      'and c.fk_cadastros=p.fk_cadastros'
      
        'and m.fk_paises=c.fk_paises and m.fk_estados=c.fk_estados and m.' +
        'pk_municipios=c.fk_municipios'
      'and pr.pk_produtos=i.cod_produto'
      'and pc.pk_pecas=pr.fk_pecas'
      
        'and f.fk_pecas=pc.pk_pecas and f.maj_ver=pc.maj_ver and f.min_ve' +
        'r=pc.min_ver'
      'and r.pk_cargas_regioes=m.fk_cargas_regioes'
      'And i.fk_cargas_producao is null'
      'order by p.fk_tipo_pedidos,i.fk_pedidos, i.pk_pedidos_itens')
    Left = 170
    Top = 6
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_empresas'
        ParamType = ptInput
      end>
  end
  object qrRegioes: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      'select pk_cargas_regioes, ref_reg, dsc_reg'
      'from cargas_regioes'
      'order by ref_reg, dsc_reg')
    Left = 172
    Top = 58
  end
  object qrClientes: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      'select raz_soc, fk_cadastros from vw_clientes'
      'order by raz_soc')
    Left = 176
    Top = 116
  end
  object qrTiposPedidos: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      'select * from tipo_pedidos'
      'order by dsc_tped')
    Left = 264
    Top = 62
  end
  object qrVinculosPedido: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      
        'select v.fk_tipo_pedidos, v.fk_pedidos, v.fk_tipo_pedidos_vinc, ' +
        'v.fk_pedidos_vinc'
      'from pedidos_vinculos v, pedidos p'
      'where v.fk_empresas=p.fk_empresas'
      
        'and (((p.flag_vinc_ped=1)And(p.fk_tipo_pedidos=v.fk_tipo_pedidos' +
        ')And(p.pk_pedidos=v.fk_pedidos))'
      
        'Or((p.flag_vinc_ped=0)And(p.fk_tipo_pedidos=v.fk_tipo_pedidos_vi' +
        'nc)And(p.pk_pedidos=v.fk_pedidos_vinc)))'
      
        'And p.fk_empresas=:fk_empresas and p.fk_tipo_pedidos=:fk_tipo_pe' +
        'didos and p.pk_pedidos=:pk_pedidos'
      
        'order by v.fk_tipo_pedidos, v.fk_pedidos, v.fk_tipo_pedidos_vinc' +
        ', v.fk_pedidos_vinc')
    Left = 262
    Top = 122
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_empresas'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_tipo_pedidos'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'pk_pedidos'
        ParamType = ptInput
      end>
  end
  object qrCheckReferenciaCarga: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      'select * from cargas_producao'
      'where fk_empresas=:fk_empresas'
      'and ref_crg=:ref_crg')
    Left = 176
    Top = 190
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_empresas'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ref_crg'
        ParamType = ptInput
      end>
  end
  object qrInsertCargaProducao: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      
        'insert into cargas_producao(fk_empresas, dsc_crg, ref_crg, flag_' +
        'ativo, dta_lim)'
      'values(:fk_empresas, :dsc_crg, :ref_crg, :flag_ativo, :dta_lim)')
    Left = 380
    Top = 64
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_empresas'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'dsc_crg'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ref_crg'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'flag_ativo'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'dta_lim'
        ParamType = ptInput
      end>
  end
  object qrMaxCargaProducao: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      
        'select max(pk_cargas_producao) as pk_cargas_producao from cargas' +
        '_producao'
      'where fk_empresas=:fk_empresas and ref_crg=:ref_crg')
    Left = 378
    Top = 122
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_empresas'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ref_crg'
        ParamType = ptInput
      end>
  end
  object qrUpdatePedidosItems: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      'update pedidos_itens set fk_cargas_producao=:fk_cargas_producao'
      
        'where fk_empresas=:fk_empresas and fk_tipo_pedidos=:fk_tipo_pedi' +
        'dos and fk_pedidos=:fk_pedidos and pk_pedidos_itens=:pk_pedidos_' +
        'itens')
    Left = 368
    Top = 198
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_cargas_producao'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_empresas'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_tipo_pedidos'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_pedidos'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'pk_pedidos_itens'
        ParamType = ptInput
      end>
  end
  object qrItemsCargas: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      
        'select cg.*, p.dta_ped, p.fk_tipo_pedidos, i.fk_pedidos, i.pk_pe' +
        'didos_itens,'
      
        'i.cod_ref_item, i.qtd_item, f.fk_pecas, f.pk_ficha_tecnica as fk' +
        '_ficha_tecnica,'
      'f.dsc_pec, pr.alt_prod, pr.prof_prod, pr.larg_prod, c.raz_soc,'
      'm.fk_cargas_regioes, r.ref_reg, r.dsc_reg, 0.0 As M3'
      
        'from cargas_producao cg, pedidos_itens i, pedidos p, vw_clientes' +
        ' c, municipios m,'
      'produtos pr, pecas pc, ficha_tecnica f, cargas_regioes r'
      'where cg.fk_empresas=:fk_empresas'
      'and p.fk_empresas=cg.fk_empresas'
      
        'and i.fk_empresas=p.fk_empresas and i.fk_tipo_pedidos=p.fk_tipo_' +
        'pedidos'
      
        'and i.fk_pedidos=p.pk_pedidos and i.fk_cargas_producao=cg.pk_car' +
        'gas_producao'
      'and c.fk_cadastros=p.fk_cadastros'
      
        'and m.fk_paises=c.fk_paises and m.fk_estados=c.fk_estados and m.' +
        'pk_municipios=c.fk_municipios'
      'and pr.pk_produtos=i.cod_produto'
      'and pc.pk_pecas=pr.fk_pecas'
      
        'and f.fk_pecas=pc.pk_pecas and f.maj_ver=pc.maj_ver and f.min_ve' +
        'r=pc.min_ver'
      'and r.pk_cargas_regioes=m.fk_cargas_regioes'
      
        'order by cg.ref_crg, p.fk_tipo_pedidos, i.fk_pedidos, i.pk_pedid' +
        'os_itens')
    Left = 180
    Top = 266
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_empresas'
        ParamType = ptInput
      end>
  end
  object qrAtivaCargaProducao: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      'update cargas_producao set flag_ativo=1'
      'where fk_empresas=:fk_empresas'
      'and pk_cargas_producao=:pk_cargas_producao')
    Left = 364
    Top = 268
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_empresas'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'pk_cargas_producao'
        ParamType = ptInput
      end>
  end
  object qrDeleteCargaProducao: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      'delete from cargas_producao'
      'where fk_empresas=:fk_empresas'
      'and pk_cargas_producao=:pk_cargas_producao')
    Left = 520
    Top = 58
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_empresas'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'pk_cargas_producao'
        ParamType = ptInput
      end>
  end
  object qrClearItemPedidoCargaProducao: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      'update pedidos_itens set fk_cargas_producao=Null'
      
        'where fk_empresas=:fk_empresas and fk_cargas_producao=:fk_cargas' +
        '_producao')
    Left = 508
    Top = 196
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_empresas'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_cargas_producao'
        ParamType = ptInput
      end>
  end
end
