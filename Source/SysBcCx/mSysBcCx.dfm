object dmSysBcCx: TdmSysBcCx
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 408
  Top = 245
  Height = 208
  Width = 326
  object qrFinance: TSQLQuery
    Params = <>
    Left = 16
    Top = 8
  end
  object qrAccounts: TSQLQuery
    Params = <>
    Left = 96
    Top = 8
  end
  object qrSqlAux: TSQLQuery
    Params = <>
    Left = 256
    Top = 120
  end
  object qrTypeAccount: TSQLQuery
    Params = <>
    Left = 176
    Top = 8
  end
  object qrAgency: TSQLQuery
    Params = <>
    Left = 256
    Top = 8
  end
  object qrBank: TSQLQuery
    Params = <>
    Left = 16
    Top = 56
  end
  object qrAccount: TSQLQuery
    Params = <>
    Left = 96
    Top = 56
  end
  object qrBankAccount: TSQLQuery
    Params = <>
    Left = 176
    Top = 56
  end
  object qrFinanceOperation: TSQLQuery
    Params = <>
    Left = 96
    Top = 104
  end
  object qrTicket: TSQLQuery
    Params = <>
    Left = 256
    Top = 56
  end
end
