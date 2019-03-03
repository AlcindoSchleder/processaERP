object dmFichaTecnica: TdmFichaTecnica
  OldCreateOrder = False
  Left = 93
  Top = 38
  Height = 696
  Width = 884
  object tr: TIBTransaction
    DefaultDatabase = Dados.Conexao
    Left = 40
    Top = 8
  end
  object qrPecasComponentes: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      
        'select PCOMP.fk_pecas, PCOMP.fk_ficha_tecnica, PCOMP.fk_pecas_mo' +
        'ntagem, PCOMP.fk_ficha_tecnica_montagem,'
      'PCOMP.QTD_PEC,PCOMP.QTD_GER,'
      'F.* from PECAS_COMPONENTES PCOMP, FICHA_TECNICA F'
      
        'Where F.FK_PECAS=PCOMP.fk_pecas_montagem And F.pk_ficha_tecnica=' +
        'PCOMP.fk_ficha_tecnica_montagem'
      
        'And PCOMP.fk_pecas=:fk_pecas and PCOMP.fk_ficha_tecnica=:fk_fich' +
        'a_tecnica')
    Left = 456
    Top = 8
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_pecas'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_ficha_tecnica'
        ParamType = ptInput
      end>
  end
  object qrReferencia: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      'select fk_tipo_referencias'
      '  from referencias '
      'where fk_empresas = :fk_empresas '
      '   and fk_produtos = :fk_produtos '
      '   and fk_componentes = :fk_tipo_componentes'
      '   and fk_acabamentos = :fk_tipo_acabamentos'
      '   and fk_tipo_referencias = :fk_tipo_referencias ')
    Left = 40
    Top = 241
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_empresas'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_produtos'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_tipo_componentes'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_tipo_acabamentos'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_tipo_referencias'
        ParamType = ptInput
      end>
  end
  object qrSecoes: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      'select pk_secoes, dsc_sec '
      '  from secoes'
      ' order by dsc_sec')
    Left = 40
    Top = 66
  end
  object qrGrupos: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      'select pk_grupos, dsc_gru '
      '  from grupos'
      'where fk_secoes = :fk_secoes'
      '  order by dsc_gru')
    Left = 40
    Top = 124
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_secoes'
        ParamType = ptInput
      end>
  end
  object qrReferenciaPeca: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      
        'select f.COD_REF, f.fk_pecas, f.fk_secoes, f.fk_grupos, f.fk_sub' +
        'grupos,'
      '          f.dsc_pec, (select count(*) from pecas_componentes pc'
      '           where pc.fk_pecas = f.fk_pecas) as total_componentes'
      '  from ficha_tecnica f'
      'where f.cod_ref = :cod_ref')
    Left = 128
    Top = 124
    ParamData = <
      item
        DataType = ftString
        Name = 'cod_ref'
        ParamType = ptInput
      end>
  end
  object qrCopyFichaTecnica: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      'select * from  stp_copy_ficha_tecnica('
      '  :fkPecasFrom,'
      '  :fkFichaTecnicaFrom, '
      '  :fkPecasTo, :MajVerTo, :MinVerTo)')
    Left = 40
    Top = 292
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fkPecasFrom'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fkFichaTecnicaFrom'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fkPecasTo'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'MajVerTo'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'MinVerTo'
        ParamType = ptInput
      end>
  end
  object qrFasesPeca: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      
        'select pco.fk_pecas, pco.fk_pecas_montagem, pco.fk_fases_produca' +
        'o, pco.fk_operacoes,'
      
        'pco.seq_mont, f.pk_fases_producao, f.fk_tipo_fases_producao, f.s' +
        'eq_fase, tf.dsc_fase, tf.niv_fase, tope.dsc_ope, o.fk_tipo_opera' +
        'coes, o.seq_ope, o.cod_ref,'
      
        'o.cod_barras, o.alt_max, o.larg_max, o.prof_max, o.alt_min, o.la' +
        'rg_min, o.prof_min,  o.tempo_medio'
      'from pecas_compo_oper pco, fases_producao f,'
      '     tipo_fases_producao tf, tipo_operacoes tope, operacoes o'
      
        'where f.fk_pecas=pco.fk_pecas_montagem and f.pk_fases_producao=p' +
        'co.fk_fases_producao'
      'and tf.pk_tipo_fases_producao=f.fk_tipo_fases_producao'
      'and tope.pk_tipo_operacoes=o.fk_tipo_operacoes'
      
        'and o.fk_pecas=pco.fk_pecas and o.fk_fases_producao=pco.fk_fases' +
        '_producao'
      'and o.pk_operacoes=pco.fk_operacoes'
      
        'and pco.fk_pecas=:fk_pecas and pco.fk_pecas_montagem=:fk_pecas_m' +
        'ontagem'
      'order by pco.seq_mont')
    Left = 128
    Top = 178
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_pecas'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_pecas_montagem'
        ParamType = ptInput
      end>
  end
  object qrPeca: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      
        'select p.pk_pecas, p.maj_ver As MajVerPeca, p.min_ver As MinVerP' +
        'eca, '
      
        '          p.version, f.*, p.version As MaiorVersao, p.version As' +
        ' Versoes, '
      '          p.version As CurrVersao, p.version as VersaoAtiva'
      '  from Pecas P, Ficha_Tecnica F'
      ' where F.fk_pecas=p.pk_pecas'
      
        '   and F.fk_pecas=:pk_pecas and f.pk_ficha_tecnica=:fk_ficha_tec' +
        'nica'
      ' order by F.dsc_pec, F.fk_pecas, F.maj_ver desc, F.min_ver desc')
    Left = 128
    Top = 66
    ParamData = <
      item
        DataType = ftInteger
        Name = 'pk_pecas'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_ficha_tecnica'
        ParamType = ptInput
      end>
  end
  object qrPecas: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      
        'select p.pk_pecas, p.maj_ver As MajVerPeca, p.min_ver As MinVerP' +
        'eca, p.version, '
      ''
      'F.Cod_Ref, F.dsc_pec, F.pk_ficha_tecnica,'
      'p.pk_pecas as fk_pecas, F.pk_ficha_tecnica as fk_ficha_tecnica,'
      'f.maj_ver, f.min_ver, f.flag_atv,'
      ''
      
        'p.version As MaiorVersao, p.version As Versoes, p.version As Cur' +
        'rVersao, p.version as VersaoAtiva,'
      '(select count(*) from pecas_componentes pcomp'
      
        '  where pcomp.fk_ficha_tecnica=f.pk_ficha_tecnica and pcomp.fk_p' +
        'ecas=f.fk_pecas'
      
        '  and ((pcomp.fk_ficha_tecnica<>pcomp.fk_ficha_tecnica_montagem)' +
        ' or (pcomp.fk_pecas<>pcomp.fk_pecas_montagem))'
      ') As TotalComponentes'
      'from Pecas P, Ficha_Tecnica F'
      'Where F.fk_pecas=p.pk_pecas'
      
        'order by F.cod_ref, F.dsc_pec, F.fk_pecas, F.maj_ver desc, F.min' +
        '_ver desc')
    Left = 128
    Top = 8
  end
  object qrInsertPecaComponente: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      
        'insert into pecas_componentes(fk_pecas, fk_ficha_tecnica, fk_pec' +
        'as_montagem, fk_ficha_tecnica_montagem, qtd_pec, qtd_ger)'
      
        'values(:fk_pecas, :fk_ficha_tecnica, :fk_pecas_montagem, :fk_fic' +
        'ha_tecnica_montagem, :qtd_pec,:qtd_ger)')
    Left = 456
    Top = 178
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_pecas'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_ficha_tecnica'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_pecas_montagem'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_ficha_tecnica_montagem'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'qtd_pec'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'qtd_ger'
        ParamType = ptInput
      end>
  end
  object qrUpdatePecaComponente: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      'update pecas_componentes'
      'set qtd_pec=:qtd_pec, qtd_ger=:qtd_ger where fk_pecas=:fk_pecas '
      'and fk_ficha_tecnica=:fk_ficha_tecnica'
      'and fk_pecas_montagem=:fk_pecas_montagem'
      'and fk_ficha_tecnica_montagem=:fk_ficha_tecnica_montagem')
    Left = 456
    Top = 241
    ParamData = <
      item
        DataType = ftInteger
        Name = 'qtd_pec'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'qtd_ger'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_pecas'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_ficha_tecnica'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_pecas_montagem'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_ficha_tecnica_montagem'
        ParamType = ptInput
      end>
  end
  object qrPecaComponente: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      
        'select PCOMP.fk_pecas, PCOMP.fk_ficha_tecnica, PCOMP.fk_pecas_mo' +
        'ntagem, PCOMP.fk_ficha_tecnica_montagem,'
      'PCOMP.QTD_PEC, PCOMP.QTD_GER,'
      'F.* from PECAS_COMPONENTES PCOMP, FICHA_TECNICA F'
      
        'Where F.FK_PECAS=PCOMP.fk_pecas_montagem And F.pk_ficha_tecnica=' +
        'PCOMP.fk_ficha_tecnica_montagem'
      
        'And PCOMP.fk_pecas=:fk_pecas And PCOMP.fk_ficha_tecnica=:fk_fich' +
        'a_tecnica'
      
        'and PCOMP.fk_pecas_montagem=:fk_pecas_montagem and PCOMP.fk_fich' +
        'a_tecnica_montagem=:fk_ficha_tecnica_montagem')
    Left = 456
    Top = 66
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_pecas'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_ficha_tecnica'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_pecas_montagem'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_ficha_tecnica_montagem'
        ParamType = ptInput
      end>
  end
  object qrSubGrupos: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      
        'select * from subgrupos where fk_secoes=:fk_secoes and ((fk_grup' +
        'os=:fk_grupos)Or(1>:fk_grupos))'
      'order by dsc_sgru')
    Left = 40
    Top = 178
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'fk_secoes'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'fk_grupos'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'fk_grupos'
        ParamType = ptUnknown
      end>
  end
  object qrDelPecasComponentes: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      'delete from PECAS_COMPONENTES'
      
        'where fk_pecas=:fk_pecas and fk_pecas_montagem=:fk_pecas_montage' +
        'm'
      'and fk_pecas<>fk_pecas_montagem')
    Left = 456
    Top = 124
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_pecas'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_pecas_montagem'
        ParamType = ptInput
      end>
  end
  object qrDelPecasCompoOper: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      'delete from PECAS_COMPO_OPER'
      
        'where fk_pecas=:fk_pecas and fk_pecas_montagem=:fk_pecas_montage' +
        'm')
    Left = 610
    Top = 8
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_pecas'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_pecas_montagem'
        ParamType = ptInput
      end>
  end
  object qrOperacoes: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      
        'select f.fk_pecas, f.fk_ficha_tecnica, f.pk_fases_producao, f.fk' +
        '_tipo_fases_producao, f.seq_fase, '
      'tf.dsc_fase, tf.niv_fase, o.*, tp.dsc_ope'
      'from tipo_fases_producao tf,'
      '     fases_producao f left outer join'
      
        '                      operacoes o left outer join tipo_operacoes' +
        ' tp on tp.pk_tipo_operacoes=o.fk_tipo_operacoes'
      
        '                      on o.fk_pecas=f.fk_pecas and o.fk_ficha_te' +
        'cnica=f.fk_ficha_tecnica and o.fk_fases_producao=f.pk_fases_prod' +
        'ucao'
      
        'where tf.pk_tipo_fases_producao=f.fk_tipo_fases_producao and f.f' +
        'k_pecas=:fk_pecas and f.fk_ficha_tecnica=:fk_ficha_tecnica'
      'order by tf.niv_fase, f.seq_fase, o.seq_ope')
    Left = 330
    Top = 8
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_pecas'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_ficha_tecnica'
        ParamType = ptInput
      end>
  end
  object qrPecasOperacao: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      
        'select pc.fk_pecas_montagem, pc.fk_ficha_tecnica_montagem, f.cod' +
        '_ref, f.dsc_pec, po.seq_mont'
      'from ficha_tecnica f,'
      '     pecas_componentes pc left outer join pecas_compo_oper po'
      
        '                               on po.fk_pecas=pc.fk_pecas and po' +
        '.fk_ficha_tecnica=pc.fk_ficha_tecnica'
      
        '                               and po.fk_pecas_montagem=pc.fk_pe' +
        'cas_montagem and po.fk_ficha_tecnica_montagem=pc.fk_ficha_tecnic' +
        'a_montagem'
      
        '                               and po.fk_fases_producao=:fk_fase' +
        's_producao'
      '                               and po.fk_operacoes=:fk_operacoes'
      
        'where pc.fk_pecas=:fk_pecas and pc.fk_ficha_tecnica=:fk_ficha_te' +
        'cnica'
      '  and pc.fk_pecas<>pc.fk_pecas_montagem'
      '  and f.fk_pecas=pc.fk_pecas_montagem'
      '  and f.pk_ficha_tecnica=pc.fk_ficha_tecnica_montagem'
      'order by po.seq_mont, f.cod_ref, f.dsc_pec')
    Left = 330
    Top = 346
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_fases_producao'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_operacoes'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_pecas'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_ficha_tecnica'
        ParamType = ptInput
      end>
  end
  object qrOperacao: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      
        'select f.fk_pecas, f.fk_ficha_tecnica, f.pk_fases_producao, f.fk' +
        '_tipo_fases_producao, f.seq_fase,'
      'tf.dsc_fase, tf.niv_fase, o.*, tp.dsc_ope'
      'from tipo_fases_producao tf,'
      '     fases_producao f left outer join'
      
        '                      operacoes o left outer join tipo_operacoes' +
        ' tp on tp.pk_tipo_operacoes=o.fk_tipo_operacoes'
      
        '                      on o.fk_pecas=f.fk_pecas and o.fk_fases_pr' +
        'oducao=f.pk_fases_producao'
      'and o.pk_operacoes=:pk_operacoes'
      
        'where tf.pk_tipo_fases_producao=f.fk_tipo_fases_producao and f.f' +
        'k_pecas=:fk_pecas and f.fk_ficha_tecnica=:fk_ficha_tecnica '
      'and f.pk_fases_producao=:pk_fases_producao')
    Left = 330
    Top = 66
    ParamData = <
      item
        DataType = ftInteger
        Name = 'pk_operacoes'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_pecas'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_ficha_tecnica'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'pk_fases_producao'
        ParamType = ptInput
      end>
  end
  object qrTipoFasesProducao: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      'select * from tipo_fases_producao'
      'order by dsc_fase')
    Left = 228
    Top = 66
  end
  object qrTipoOperacoes: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      'select * from tipo_operacoes')
    Left = 230
    Top = 8
  end
  object qrDeleteComponentesOperacao: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      'delete from pecas_compo_oper'
      'where fk_pecas=:fk_pecas'
      'and fk_ficha_tecnica=:fk_ficha_tecnica'
      'and fk_fases_producao=:fk_fases_producao'
      'and fk_operacoes=:fk_operacoes')
    Left = 610
    Top = 124
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_pecas'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_ficha_tecnica'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_fases_producao'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_operacoes'
        ParamType = ptInput
      end>
  end
  object qrInsertComponenteOperacao: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      
        'insert into pecas_compo_oper(fk_pecas, fk_ficha_tecnica, fk_peca' +
        's_montagem, fk_ficha_tecnica_montagem,'
      'fk_fases_producao, fk_operacoes, seq_mont)'
      
        'values(:fk_pecas, :fk_ficha_tecnica, :fk_pecas_montagem, :fk_fic' +
        'ha_tecnica_montagem,'
      ':fk_fases_producao, :fk_operacoes, :seq_mont)')
    Left = 610
    Top = 66
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_pecas'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_ficha_tecnica'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_pecas_montagem'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_ficha_tecnica_montagem'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_fases_producao'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_operacoes'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'seq_mont'
        ParamType = ptInput
      end>
  end
  object qrInsertOperacao: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      
        'insert into operacoes(fk_pecas, fk_ficha_tecnica, fk_fases_produ' +
        'cao,'
      'fk_tipo_documentos,'
      ' fk_tipo_operacoes,'
      
        'seq_ope, cod_ref, cod_barras, alt_max, larg_max, prof_max, alt_m' +
        'in, larg_min, prof_min, '
      'tempo_medio)'
      'values(:fk_pecas, :fk_ficha_tecnica, :fk_fases_producao, '
      ':fk_tipo_documentos,'
      ':fk_tipo_operacoes,'
      
        ':seq_ope, :cod_ref, :cod_barras, :alt_max, :larg_max, :prof_max,' +
        ' :alt_min, '
      ':larg_min, :prof_min, :tempo_medio)')
    Left = 330
    Top = 124
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_pecas'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_ficha_tecnica'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_fases_producao'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_tipo_documentos'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_tipo_operacoes'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'seq_ope'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'cod_ref'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'cod_barras'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'alt_max'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'larg_max'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'prof_max'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'alt_min'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'larg_min'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'prof_min'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'tempo_medio'
        ParamType = ptInput
      end>
  end
  object qrUpdateOperacao: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      'update operacoes set fk_tipo_operacoes=:fk_tipo_operacoes,'
      'fk_tipo_documentos=:fk_tipo_documentos,'
      ' seq_ope=:seq_ope, cod_ref=:cod_ref,'
      'cod_barras=:cod_barras, '
      'alt_max=:alt_max, '
      'larg_max=:larg_max,'
      'prof_max=:prof_max, '
      'alt_min=:alt_min, '
      'larg_min=:larg_min,'
      'prof_min=:prof_min, '
      'tempo_medio=:tempo_medio '
      'where fk_pecas=:fk_pecas'
      'and fk_ficha_tecnica=:fk_ficha_tecnica '
      'and fk_fases_producao=:fk_fases_producao'
      'and pk_operacoes=:pk_operacoes')
    Left = 330
    Top = 178
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_tipo_operacoes'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_tipo_documentos'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'seq_ope'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'cod_ref'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'cod_barras'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'alt_max'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'larg_max'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'prof_max'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'alt_min'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'larg_min'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'prof_min'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'tempo_medio'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_pecas'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_ficha_tecnica'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_fases_producao'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'pk_operacoes'
        ParamType = ptInput
      end>
  end
  object qrMaxOperacao: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      'select max(pk_operacoes) as fkOperacao from operacoes'
      'where fk_pecas=:fk_pecas and fk_ficha_tecnica=:fk_ficha_tecnica '
      'and fk_fases_producao=:fk_fases_producao')
    Left = 330
    Top = 292
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_pecas'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_ficha_tecnica'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_fases_producao'
        ParamType = ptInput
      end>
  end
  object qrDeleteOperacoesDetalhes: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      'delete from operacoes_detalhes'
      'where fk_pecas=:fk_pecas'
      'and fk_ficha_tecnica=:fk_ficha_tecnica'
      'and fk_fases_producao=:fk_fases_producao'
      'and fk_operacoes=:fk_operacoes')
    Left = 218
    Top = 394
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_pecas'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_ficha_tecnica'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_fases_producao'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_operacoes'
        ParamType = ptInput
      end>
  end
  object qrDeleteOperacao: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      'delete from operacoes'
      'where fk_pecas=:fk_pecas'
      'and fk_ficha_tecnica=:fk_ficha_tecnica'
      'and fk_fases_producao=:fk_fases_producao'
      'and pk_operacoes=:pk_operacoes')
    Left = 330
    Top = 241
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_pecas'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_ficha_tecnica'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_fases_producao'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'pk_operacoes'
        ParamType = ptInput
      end>
  end
  object qrOperacoesOld: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      
        'select o.*, tp.dsc_ope, f.seq_fase, f.fk_tipo_fases_producao,tf.' +
        'dsc_fase'
      
        'from operacoes o, tipo_operacoes tp, fases_producao f, tipo_fase' +
        's_producao tf'
      
        'where tp.pk_tipo_operacoes=o.fk_tipo_operacoes and f.pk_fases_pr' +
        'oducao=o.fk_fases_producao'
      'and tf.pk_tipo_fases_producao=f.fk_tipo_fases_producao'
      'and o.fk_pecas=:fk_pecas'
      'order by f.seq_fase,o.seq_ope,tp.dsc_ope')
    Left = 40
    Top = 350
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_pecas'
        ParamType = ptInput
      end>
  end
  object qrOperacaoOld: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      
        'select o.*, tp.dsc_ope, f.seq_fase, f.fk_tipo_fases_producao,tf.' +
        'dsc_fase'
      
        'from operacoes o, tipo_operacoes tp, fases_producao f, tipo_fase' +
        's_producao tf'
      
        'where tp.pk_tipo_operacoes=o.fk_tipo_operacoes and f.pk_fases_pr' +
        'oducao=o.fk_fases_producao'
      'and tf.pk_tipo_fases_producao=f.fk_tipo_fases_producao'
      'and o.fk_pecas=:fk_pecas'
      'and o.fk_fases_producao=:fk_fases_producao'
      'and o.pk_operacoes=:pk_operacoes')
    Left = 40
    Top = 398
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_pecas'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_fases_producao'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'pk_operacoes'
        ParamType = ptInput
      end>
  end
  object qrDeleteComponentesFaseProducao: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      'delete from pecas_compo_oper'
      'where fk_pecas=:fk_pecas'
      'and fk_ficha_tecnica=:fk_ficha_tecnica'
      'and fk_fases_producao=:fk_fases_producao')
    Left = 610
    Top = 178
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_pecas'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_ficha_tecnica'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_fases_producao'
        ParamType = ptInput
      end>
  end
  object qrDeleteOperacoesDetalhesFaseProducao: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      'delete from operacoes_detalhes'
      'where fk_pecas=:fk_pecas'
      'and fk_ficha_tecnica=:fk_ficha_tecnica'
      'and fk_fases_producao=:fk_fases_producao')
    Left = 220
    Top = 446
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_pecas'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_ficha_tecnica'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_fases_producao'
        ParamType = ptInput
      end>
  end
  object qrDeleteOperacoesFaseProducao: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      'delete from operacoes'
      'where fk_pecas=:fk_pecas'
      'and fk_ficha_tecnica=:fk_ficha_tecnica'
      'and fk_fases_producao=:fk_fases_producao')
    Left = 222
    Top = 491
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_pecas'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_ficha_tecnica'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_fases_producao'
        ParamType = ptInput
      end>
  end
  object qrDeleteFaseProducao: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      'delete from fases_producao'
      'where fk_pecas=:fk_pecas'
      'and fk_ficha_tecnica=:fk_ficha_tecnica'
      'and pk_fases_producao=:pk_fases_producao')
    Left = 612
    Top = 241
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_pecas'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_ficha_tecnica'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'pk_fases_producao'
        ParamType = ptInput
      end>
  end
  object qrFaseProducao: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      'select f.*, tf.dsc_fase, tf.niv_fase'
      'from tipo_fases_producao tf,'
      '     fases_producao f'
      'where tf.pk_tipo_fases_producao=f.fk_tipo_fases_producao'
      'and f.fk_pecas=:fk_pecas '
      
        'and f.fk_ficha_tecnica=:fk_ficha_tecnica and f.pk_fases_producao' +
        '=:pk_fases_producao')
    Left = 616
    Top = 300
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_pecas'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_ficha_tecnica'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'pk_fases_producao'
        ParamType = ptInput
      end>
  end
  object qrInsertFaseProducao: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      
        'insert into fases_producao(fk_pecas, fk_ficha_tecnica, fk_tipo_f' +
        'ases_producao, seq_Fase)'
      
        'values(:fk_pecas, :fk_ficha_tecnica, :fk_tipo_fases_producao, :s' +
        'eq_Fase)')
    Left = 620
    Top = 354
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_pecas'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_ficha_tecnica'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_tipo_fases_producao'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'seq_Fase'
        ParamType = ptInput
      end>
  end
  object qrUpdateFaseProducao: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      
        'update fases_producao set fk_tipo_fases_producao=:fk_tipo_fases_' +
        'producao, seq_fase=:seq_fase'
      
        'where fk_pecas=:fk_pecas and fk_ficha_tecnica=:fk_ficha_tecnica ' +
        'and pk_fases_producao=:pk_fases_producao')
    Left = 624
    Top = 402
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_tipo_fases_producao'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'seq_Fase'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_pecas'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_ficha_tecnica'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'pk_fases_producao'
        ParamType = ptInput
      end>
  end
  object qrMaxFaseProducao: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      'select max(pk_fases_producao) as pk_fases_producao'
      'from fases_producao'
      'where fk_pecas=:fk_pecas and fk_ficha_tecnica=:fk_ficha_tecnica')
    Left = 628
    Top = 446
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_pecas'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_ficha_tecnica'
        ParamType = ptInput
      end>
  end
  object qrServicosOperacao: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      
        'select od.*,ts.dsc_srv from operacoes_detalhes od, servicos_ind ' +
        ' ts'
      'where od.fk_pecas=:fk_pecas'
      'and od.fk_ficha_tecnica=:fk_ficha_tecnica'
      'and od.fk_fases_producao=:fk_fases_producao'
      'and od.fk_operacoes=:fk_operacoes'
      'and od.flag_tdet=1 and ts.pk_servicos_ind=od.fk_tipo_detalhe'
      'order by ts.dsc_srv')
    Left = 458
    Top = 290
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_pecas'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_ficha_tecnica'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_fases_producao'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_operacoes'
        ParamType = ptInput
      end>
  end
  object qrAcabamentosOperacao: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      
        'select od.*,ta.dsc_acabm from operacoes_detalhes od, tipo_acabam' +
        'entos ta'
      'where od.fk_pecas=:fk_pecas and'
      'od.fk_ficha_tecnica=:fk_ficha_tecnica'
      'and od.fk_fases_producao=:fk_fases_producao'
      'and od.fk_operacoes=:fk_operacoes'
      'and od.flag_tdet=2 and ta.pk_tipo_acabamentos=od.fk_tipo_detalhe'
      'order by ta.dsc_acabm')
    Left = 458
    Top = 346
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_pecas'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_ficha_tecnica'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_fases_producao'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_operacoes'
        ParamType = ptInput
      end>
  end
  object qrInsumosOperacao: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      
        'select od.*,i.cod_ref, i.dsc_ins from operacoes_detalhes od, ins' +
        'umos i'
      'where od.fk_pecas=:fk_pecas and '
      'od.fk_ficha_tecnica=:fk_ficha_tecnica and'
      'od.fk_fases_producao=:fk_fases_producao'
      'and od.fk_operacoes=:fk_operacoes'
      'and od.flag_tdet=0 and i.pk_insumos=od.fk_tipo_detalhe'
      
        'And Not(i.pk_insumos in (select distinct fk_insumos from produto' +
        's))'
      'order by i.cod_ref, i.dsc_ins')
    Left = 458
    Top = 396
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_pecas'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_ficha_tecnica'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_fases_producao'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_operacoes'
        ParamType = ptInput
      end>
  end
  object qrInsertOperacoesDetalhes: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      
        'insert into operacoes_detalhes(fk_pecas, fk_ficha_tecnica, fk_fa' +
        'ses_producao, fk_operacoes, fk_tipo_detalhe, flag_tdet, qtd_det,' +
        ' perc_perda)'
      
        'values(:fk_pecas, :fk_ficha_tecnica, :fk_fases_producao, :fk_ope' +
        'racoes, :fk_tipo_detalhe, :flag_tdet, :qtd_det, :perc_perda)')
    Left = 460
    Top = 442
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_pecas'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_ficha_tecnica'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_fases_producao'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_operacoes'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_tipo_detalhe'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'flag_tdet'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'qtd_det'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'perc_perda'
        ParamType = ptInput
      end>
  end
  object qrTipoServicos: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      'select * from servicos_Ind'
      'order by dsc_srv')
    Left = 230
    Top = 124
  end
  object qrTipoAcabamentos: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      'select * from tipo_acabamentos'
      'order by dsc_acabm')
    Left = 224
    Top = 176
  end
  object qrInsumos: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      'select * from Insumos'
      
        'Where fk_Secoes=:fk_Secoes And ((fk_Grupos=:fk_Grupos)Or(1>:fk_G' +
        'rupos))'
      'And ((fk_SubGrupos=:fk_SubGrupos)Or(1>:fk_SubGrupos))'
      'Order by cod_ref')
    Left = 128
    Top = 242
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_Secoes'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_Grupos'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_Grupos'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_SubGrupos'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_SubGrupos'
        ParamType = ptInput
      end>
  end
  object qrCheckPecaComponente: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      'select PCOMP.fk_pecas_montagem'
      'from PECAS_COMPONENTES PCOMP, PECAS PC'
      'Where PC.PK_PECAS=PCOMP.fk_pecas_montagem'
      'And PCOMP.fk_pecas=:fk_pecas'
      'And PCOMP.fk_pecas<>PCOMP.fk_pecas_montagem')
    Left = 222
    Top = 296
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_pecas'
        ParamType = ptInput
      end>
  end
  object qrFerramentasOperacao: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      
        'select pm.fk_maquinas, m.dsc_maq, pm.tmp_stp, pm.tmp_oper, pm.fl' +
        'ag_def, pf.fk_insumos, i.dsc_ins'
      'from pecas_maquinas pm left outer join pecas_ferramentas pf'
      
        '                                       left outer join insumos i' +
        ' on i.pk_insumos=pf.fk_insumos'
      
        '                       on pf.fk_pecas=pm.fk_pecas and pf.fk_fich' +
        'a_tecnica=pm.fk_ficha_tecnica and'
      
        '                          pf.fk_fases_producao=pm.fk_fases_produ' +
        'cao and'
      '                          pf.fk_operacoes=pm.fk_operacoes and'
      '                          pf.fk_maquinas=pm.fk_maquinas,'
      '     maquinas m'
      'where m.pk_maquinas=pm.fk_maquinas and'
      '      pm.fk_pecas=:fk_pecas and'
      'pm.fk_ficha_tecnica=:fk_ficha_tecnica'
      
        'and pm.fk_fases_producao=:fk_fases_producao and pm.fk_operacoes=' +
        ':fk_operacoes'
      'order by pm.fk_maquinas, pf.fk_insumos')
    Left = 220
    Top = 346
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_pecas'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_ficha_tecnica'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_fases_producao'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_operacoes'
        ParamType = ptInput
      end>
  end
  object qrMaquinas: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      'select * from maquinas'
      'order by cod_ref')
    Left = 38
    Top = 450
  end
  object qrFerramentas: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      'select i.pk_insumos, i.cod_ref, i.dsc_ins from insumos i'
      
        'where i.flag_tins=3 And Not(i.pk_insumos in (select distinct fk_' +
        'insumos from produtos))'
      'order by i.cod_ref')
    Left = 38
    Top = 498
  end
  object qrDeleteMaquinasOperacao: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      'delete from pecas_maquinas'
      'where fk_pecas=:fk_pecas'
      'and fk_ficha_tecnica=:fk_ficha_tecnica'
      'and fk_fases_producao=:fk_fases_producao'
      'and fk_operacoes=:fk_operacoes')
    Left = 456
    Top = 498
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_pecas'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_ficha_tecnica'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_fases_producao'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_operacoes'
        ParamType = ptInput
      end>
  end
  object qrDeleteFerramentasOperacao: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      'delete from pecas_ferramentas'
      'where fk_pecas=:fk_pecas'
      'and fk_ficha_tecnica=:fk_ficha_tecnica'
      'and fk_fases_producao=:fk_fases_producao'
      'and fk_operacoes=:fk_operacoes')
    Left = 626
    Top = 498
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_pecas'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_ficha_tecnica'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_fases_producao'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_operacoes'
        ParamType = ptInput
      end>
  end
  object qrInsertMaquinaOperacao: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      
        'insert into pecas_maquinas(fk_pecas, fk_ficha_tecnica, fk_fases_' +
        'producao, fk_operacoes,'
      'fk_maquinas, tmp_stp, tmp_oper, flag_def)'
      
        'values(:fk_pecas, :fk_ficha_tecnica, :fk_fases_producao, :fk_ope' +
        'racoes,'
      ':fk_maquinas, :tmp_stp, :tmp_oper, :flag_def)')
    Left = 456
    Top = 548
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_pecas'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_ficha_tecnica'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_fases_producao'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_operacoes'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_maquinas'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'tmp_stp'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'tmp_oper'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'flag_def'
        ParamType = ptInput
      end>
  end
  object qrInsertFerramentaOperacao: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      
        'insert into pecas_ferramentas(fk_pecas, fk_ficha_tecnica, fk_fas' +
        'es_producao, fk_operacoes,'
      'fk_maquinas, fk_insumos)'
      
        'values(:fk_pecas, :fk_ficha_tecnica, :fk_fases_producao, :fk_ope' +
        'racoes,'
      ':fk_maquinas, :fk_insumos)')
    Left = 222
    Top = 542
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_pecas'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_ficha_tecnica'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_fases_producao'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_operacoes'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_maquinas'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_insumos'
        ParamType = ptInput
      end>
  end
  object qrUnidades: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      'select * from unidades'
      'order by dsc_uni')
    Left = 224
    Top = 242
  end
  object qrServicosInd: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      'select * from servicos_Ind'
      'where fk_secoes=:fk_secoes'
      'and fk_grupos=:fk_grupos'
      'and fk_subgrupos=:fk_subgrupos'
      'and fk_unidades=:fk_unidades'
      'order by dsc_srv')
    Left = 114
    Top = 394
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_secoes'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_grupos'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_subgrupos'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_unidades'
        ParamType = ptInput
      end>
  end
  object qrServicoInd: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      'select * from servicos_Ind'
      'where pk_servicos_ind=:pk_servicos_ind'
      'order by cod_ref')
    Left = 330
    Top = 398
    ParamData = <
      item
        DataType = ftInteger
        Name = 'pk_servicos_ind'
        ParamType = ptInput
      end>
  end
  object qrServicoIndByDescricao: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      'select * from servicos_Ind'
      'where dsc_srv=:dsc_srv')
    Left = 34
    Top = 544
    ParamData = <
      item
        DataType = ftString
        Name = 'dsc_srv'
        ParamType = ptUnknown
      end>
  end
  object qrChaveFichaTecnica: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      'select pk_ficha_tecnica from ficha_tecnica'
      'where fk_pecas=:fk_pecas and maj_ver=:maj_ver'
      'and min_ver=:min_ver')
    Left = 124
    Top = 300
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_pecas'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'maj_ver'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'min_ver'
        ParamType = ptInput
      end>
  end
  object qrPecasAtivas: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      
        'select distinct p.pk_pecas, F.Cod_Ref, F.dsc_pec, F.pk_ficha_tec' +
        'nica,'
      'p.pk_pecas as fk_pecas, F.pk_ficha_tecnica as fk_ficha_tecnica'
      'from Pecas P, Ficha_Tecnica F'
      'Where F.fk_pecas=p.pk_pecas'
      'And ((1>=:fk_pecas)Or(F.fk_pecas=:fk_pecas))'
      'and F.fk_secoes=:fk_secoes '
      'and F.fk_grupos=:fk_grupos '
      'and F.fk_subgrupos=:fk_subgrupos'
      'order by F.Cod_Ref, F.dsc_pec, F.Cod_Ref, p.pk_pecas')
    Left = 112
    Top = 450
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_pecas'
        ParamType = ptInput
        Value = '0'
      end
      item
        DataType = ftInteger
        Name = 'fk_pecas'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_secoes'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_grupos'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_subgrupos'
        ParamType = ptInput
      end>
  end
  object qrTipoDocumentos: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      'select * from tipo_documentos')
    Left = 332
    Top = 446
  end
  object qrCheckFichaAtiva: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      'select pk_ficha_tecnica, maj_ver, min_ver'
      'from ficha_tecnica'
      'where flag_atv=1 and fk_pecas=:fk_pecas')
    Left = 336
    Top = 492
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_pecas'
        ParamType = ptInput
      end>
  end
  object qrUpdateFlagAtvFichaTecnica: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      'update ficha_tecnica set flag_atv=:flag_atv'
      'where fk_pecas=:fk_pecas and pk_ficha_tecnica=:pk_ficha_tecnica')
    Left = 336
    Top = 546
    ParamData = <
      item
        DataType = ftInteger
        Name = 'flag_atv'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_pecas'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'pk_ficha_tecnica'
        ParamType = ptInput
      end>
  end
  object qrFichaTecnicaByVersion: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      'select pk_ficha_tecnica, flag_atv, flag_op'
      'from ficha_tecnica where fk_pecas=:fk_pecas and maj_ver=:maj_ver'
      'and min_ver=:min_ver')
    Left = 110
    Top = 498
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_pecas'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'maj_ver'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'min_ver'
        ParamType = ptInput
      end>
  end
  object qrVersaoAtivaFicha: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      'select pk_ficha_tecnica, maj_ver, min_ver'
      'from ficha_tecnica where fk_pecas=:fk_pecas and flag_atv=1')
    Left = 114
    Top = 550
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_pecas'
        ParamType = ptInput
      end>
  end
  object qrUltimaVersaoFicha: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      'select max(f.maj_ver) as maj_ver,'
      
        '(select max(min_ver) from ficha_tecnica f2 where f2.fk_pecas=:fk' +
        '_pecas and f2.maj_ver=f.maj_ver) as min_ver'
      ' from ficha_tecnica f where f.fk_pecas=:fk_pecas')
    Left = 630
    Top = 550
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_pecas'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_pecas'
        ParamType = ptInput
      end>
  end
  object qrPecasAtivasOriginal: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      
        'select distinct p.pk_pecas, F.Cod_Ref, F.dsc_pec, F.pk_ficha_tec' +
        'nica,'
      'p.pk_pecas as fk_pecas, F.pk_ficha_tecnica as fk_ficha_tecnica'
      'from Pecas P, Ficha_Tecnica F'
      'Where F.fk_pecas=p.pk_pecas'
      'And ((F.flag_atv=1)Or(F.fk_pecas=:fk_pecas))'
      'and F.fk_secoes=:fk_secoes '
      'and F.fk_grupos=:fk_grupos '
      'and F.fk_subgrupos=:fk_subgrupos'
      'order by F.dsc_pec, F.Cod_Ref, p.pk_pecas')
    Left = 738
    Top = 400
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_pecas'
        ParamType = ptInput
        Value = '0'
      end
      item
        DataType = ftInteger
        Name = 'fk_secoes'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_grupos'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_subgrupos'
        ParamType = ptInput
      end>
  end
  object qrReferenciaMaquina: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      'select pk_maquinas from maquinas where cod_ref=:cod_ref')
    Left = 736
    Top = 302
    ParamData = <
      item
        DataType = ftString
        Name = 'cod_ref'
        ParamType = ptInput
      end>
  end
  object qrProdutosPeca: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      
        'select R_FK_PECAS As fk_pecas, R_FK_FICHA_TECNICA As fk_Ficha_Te' +
        'cnica, R_MAJ_VER As Maj_Ver, R_MIN_VER As Min_Ver, R_QTD_PEC As ' +
        'Qtd_Pec, R_COD_REF As Cod_Ref, R_DSC_PEC As Dsc_Pec '
      'from stp_show_top_father(:P_FK_PECAS,:P_FK_FICHA_TECNICA)'
      'Order by R_COD_REF')
    Left = 742
    Top = 12
    ParamData = <
      item
        DataType = ftInteger
        Name = 'P_FK_PECAS'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'P_FK_FICHA_TECNICA'
        ParamType = ptInput
      end>
  end
  object qrDeleteFerramentasOperacaoFaseProducao: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      'delete from pecas_ferramentas'
      'where fk_pecas=:fk_pecas'
      'and fk_ficha_tecnica=:fk_ficha_tecnica'
      'and fk_fases_producao=:fk_fases_producao')
    Left = 332
    Top = 608
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_pecas'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_ficha_tecnica'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_fases_producao'
        ParamType = ptInput
      end>
  end
  object qrDeleteMaquinasOperacaoFaseProducao: TIBQuery
    Database = Dados.Conexao
    Transaction = tr
    SQL.Strings = (
      'delete from pecas_maquinas'
      'where fk_pecas=:fk_pecas'
      'and fk_ficha_tecnica=:fk_ficha_tecnica'
      'and fk_fases_producao=:fk_fases_producao')
    Left = 630
    Top = 608
    ParamData = <
      item
        DataType = ftInteger
        Name = 'fk_pecas'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_ficha_tecnica'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_fases_producao'
        ParamType = ptInput
      end>
  end
end
