object dmSysPCP: TdmSysPCP
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 271
  Top = 163
  Height = 359
  Width = 578
  object pAccess: TDataSetProvider
    DataSet = dsAccess
    Options = [poAllowCommandText]
    UpdateMode = upWhereKeyOnly
    Left = 112
    Top = 56
  end
  object dsAccess: TIBQuery
    Database = Dados.Conexao
    Transaction = TrMain
    AfterClose = dsAccessAfterClose
    SQL.Strings = (
      'select * from cadastro')
    UniDirectional = True
    Left = 256
    Top = 56
  end
  object TrMain: TIBTransaction
    DefaultDatabase = Dados.Conexao
    Left = 184
    Top = 56
  end
  object FichaTecn: TClientDataSet
    Aggregates = <>
    CommandText = 'select * from ficha_tecnica'
    Params = <>
    ProviderName = 'pAccess'
    AfterEdit = FichaTecnAfterEdit
    AfterScroll = FichaTecnAfterScroll
    OnNewRecord = FichaTecnNewRecord
    OnReconcileError = ReconcileErrorHandler
    Left = 32
    Top = 8
  end
  object PecaEstq: TClientDataSet
    Aggregates = <>
    CommandText = 'select * from pecas_estoques'
    Params = <>
    ProviderName = 'pAccess'
    BeforeOpen = PecaEstqBeforeOpen
    AfterScroll = PecaEstqAfterScroll
    OnNewRecord = PecaEstqNewRecord
    OnReconcileError = ReconcileErrorHandler
    Left = 176
    Top = 8
  end
  object TrPCP: TIBTransaction
    DefaultDatabase = Dados.Conexao
    Left = 32
    Top = 128
  end
  object PecLotacoes: TIBQuery
    Database = Dados.Conexao
    Transaction = TrPCP
    BeforeOpen = PecLotacoesBeforeOpen
    Left = 112
    Top = 128
  end
  object Secoes: TIBQuery
    Database = Dados.Conexao
    Transaction = TrPCP
    Left = 184
    Top = 128
  end
  object Grupos: TIBQuery
    Database = Dados.Conexao
    Transaction = TrPCP
    BeforeOpen = GruposBeforeOpen
    Left = 256
    Top = 128
  end
  object SubGrupos: TIBQuery
    Database = Dados.Conexao
    Transaction = TrPCP
    BeforeOpen = SubGruposBeforeOpen
    Left = 328
    Top = 128
  end
  object Almoxarifados: TIBQuery
    Database = Dados.Conexao
    Transaction = TrPCP
    Left = 408
    Top = 128
  end
  object TrAux: TIBTransaction
    DefaultDatabase = Dados.Conexao
    Left = 32
    Top = 184
  end
  object qrySearch: TIBQuery
    Database = Dados.Conexao
    Transaction = TrAux
    Left = 112
    Top = 184
  end
  object PecaCusto: TClientDataSet
    Aggregates = <>
    CommandText = 'select * from pecas_custos'
    Params = <>
    ProviderName = 'pAccess'
    BeforeOpen = PecaEstqBeforeOpen
    OnNewRecord = PecaEstqNewRecord
    OnReconcileError = ReconcileErrorHandler
    Left = 112
    Top = 8
  end
end
