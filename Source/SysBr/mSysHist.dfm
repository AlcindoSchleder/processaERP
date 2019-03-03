object dmHistoric: TdmHistoric
  OldCreateOrder = False
  Left = 192
  Top = 114
  Height = 150
  Width = 215
  object ConnHist: TSQLConnection
    ConnectionName = 'UIB FireBird15 Connection'
    DriverName = 'UIB FireBird15'
    GetDriverFunc = 'getSQLDriverINTERBASE'
    LibraryName = 'dbexpUIBfire15.dll'
    Params.Strings = (
      'BlobSize=-1'
      'CommitRetain=False'
      'Database=database.fb'
      'DriverName=UIB FireBird15'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'Password=masterkey'
      'RoleName=RoleName'
      'ServerCharSet='
      'SQLDialect=3'
      'Interbase TransIsolation=ReadCommited'
      'User_Name=SYSDBA'
      'WaitOnLocks=True')
    VendorLib = 'fbclient.dll'
    Left = 32
    Top = 16
  end
  object qrHistoric: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = ConnHist
    Left = 96
    Top = 16
  end
end
