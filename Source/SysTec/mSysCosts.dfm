object dmSysCosts: TdmSysCosts
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 280
  Top = 88
  Height = 367
  Width = 396
  object pAccess: TDataSetProvider
    DataSet = dsAccess
    Options = [poAllowCommandText]
    UpdateMode = upWhereKeyOnly
    Left = 168
    Top = 64
  end
  object dsAccess: TIBQuery
    Database = Dados.Conexao
    Transaction = TrMain
    AfterClose = dsAccessAfterClose
    SQL.Strings = (
      'select * from insumos_barras')
    UniDirectional = True
    Left = 248
    Top = 64
  end
  object TrMain: TIBTransaction
    DefaultDatabase = Dados.Conexao
    Left = 328
    Top = 64
  end
  object Secoes: TIBQuery
    Database = Dados.Conexao
    Transaction = trAux
    SQL.Strings = (
      'select * from secoes')
    Left = 16
    Top = 192
  end
  object Unidades: TIBQuery
    Database = Dados.Conexao
    Transaction = trAux
    SQL.Strings = (
      'select * from unidades')
    Left = 248
    Top = 192
  end
  object Grupos: TIBQuery
    Database = Dados.Conexao
    Transaction = trAux
    BeforeOpen = GruposBeforeOpen
    SQL.Strings = (
      'select * from grupos')
    Left = 96
    Top = 192
  end
  object SubGrupos: TIBQuery
    Database = Dados.Conexao
    Transaction = trAux
    BeforeOpen = SubGruposBeforeOpen
    SQL.Strings = (
      'select * from subgrupos')
    Left = 168
    Top = 192
  end
  object Fornecedores: TIBQuery
    Database = Dados.Conexao
    Transaction = trAux
    SQL.Strings = (
      'select * from vw_fornecedores')
    Left = 168
    Top = 240
  end
  object TrCosts: TIBTransaction
    DefaultDatabase = Dados.Conexao
    Left = 16
    Top = 112
  end
  object QueryAux: TIBQuery
    Database = Dados.Conexao
    Transaction = TrCosts
    Left = 96
    Top = 112
  end
  object pRecord: TDataSetProvider
    DataSet = dsRecord
    Options = [poAllowCommandText]
    UpdateMode = upWhereKeyOnly
    Left = 168
    Top = 112
  end
  object dsRecord: TIBQuery
    Database = Dados.Conexao
    Transaction = trRecord
    AfterClose = dsRecordAfterClose
    SQL.Strings = (
      'select * from cadastro')
    UniDirectional = True
    Left = 248
    Top = 112
  end
  object trRecord: TIBTransaction
    DefaultDatabase = Dados.Conexao
    Left = 328
    Top = 112
  end
  object TipoFases: TIBQuery
    Database = Dados.Conexao
    Transaction = trAux
    Left = 16
    Top = 240
  end
  object Servicos: TIBQuery
    Database = Dados.Conexao
    Transaction = trAux
    Left = 96
    Top = 240
  end
  object Servico: TClientDataSet
    Aggregates = <>
    CommandText = 'select * from servicos_ind'
    Params = <>
    ProviderName = 'pAccess'
    AfterOpen = ServicoAfterOpen
    AfterPost = ServicoAfterPost
    AfterScroll = ServicoAfterScroll
    OnNewRecord = ServicoNewRecord
    OnReconcileError = ReconcileErrorHandler
    Left = 96
    Top = 8
  end
  object TFaseProd: TClientDataSet
    Aggregates = <>
    CommandText = 'select * from TIPO_FASES_PRODUCAO'
    Params = <>
    ProviderName = 'pAccess'
    OnNewRecord = TFaseProdNewRecord
    OnReconcileError = ReconcileErrorHandler
    Left = 168
    Top = 8
  end
  object TipoOper: TClientDataSet
    Aggregates = <>
    CommandText = 'select * from TIPO_OPERACOES'
    Params = <>
    ProviderName = 'pAccess'
    OnNewRecord = TipoOperNewRecord
    OnReconcileError = ReconcileErrorHandler
    Left = 248
    Top = 8
  end
  object Maquina: TClientDataSet
    Aggregates = <>
    CommandText = 'select * from MAQUINAS'
    Params = <>
    ProviderName = 'pAccess'
    AfterOpen = MaquinaAfterOpen
    AfterPost = MaquinaAfterPost
    AfterScroll = MaquinaAfterScroll
    OnNewRecord = MaquinaNewRecord
    OnReconcileError = ReconcileErrorHandler
    Left = 16
    Top = 8
  end
  object trAux: TIBTransaction
    DefaultDatabase = Dados.Conexao
    Left = 16
    Top = 64
  end
end
