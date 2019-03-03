object CdAgenda: TCdAgenda
  Left = 195
  Top = 114
  Width = 799
  Height = 550
  Caption = 'CdAgenda'
  Color = 16776176
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = mMain
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object sSeparator: TSplitter
    Left = 522
    Top = 0
    Width = 5
    Height = 483
    Align = alRight
    Beveled = True
    Color = 16776176
    ParentColor = False
  end
  object sbStatus: TStatusBar
    Left = 0
    Top = 483
    Width = 791
    Height = 19
    Panels = <
      item
        Width = 200
      end
      item
        Width = 300
      end
      item
        Width = 300
      end>
    ParentColor = True
  end
  object pTasks: TPanel
    Left = 527
    Top = 0
    Width = 264
    Height = 483
    Align = alRight
    BevelOuter = bvNone
    Color = 16776176
    TabOrder = 1
    object vpTasks: TVpTaskList
      Left = 0
      Top = 173
      Width = 264
      Height = 310
      DataStore = vpDS
      ControlLink = vpLink
      Color = 16776176
      Align = alClient
      TabStop = True
      TabOrder = 0
      ReadOnly = False
      DisplayOptions.CheckBGColor = clWindow
      DisplayOptions.CheckColor = cl3DDkShadow
      DisplayOptions.CheckStyle = csCheck
      DisplayOptions.DueDateFormat = 'd/M/yyyy'
      DisplayOptions.ShowCompletedTasks = False
      DisplayOptions.ShowAll = False
      DisplayOptions.ShowDueDate = True
      DisplayOptions.OverdueColor = clRed
      DisplayOptions.NormalColor = clBlack
      DisplayOptions.CompletedColor = clGray
      LineColor = clGray
      MaxVisibleTasks = 250
      TaskHeadAttributes.Color = clInfoBk
      TaskHeadAttributes.Font.Charset = DEFAULT_CHARSET
      TaskHeadAttributes.Font.Color = clBlue
      TaskHeadAttributes.Font.Height = -13
      TaskHeadAttributes.Font.Name = 'MS Sans Serif'
      TaskHeadAttributes.Font.Style = [fsBold]
      DrawingStyle = dsFlat
      ShowResourceName = True
      OnOwnerEditTask = vpTasksOwnerEditTask
    end
    object pOperator: TPanel
      Left = 0
      Top = 0
      Width = 264
      Height = 33
      Align = alTop
      BevelInner = bvLowered
      ParentColor = True
      TabOrder = 1
      object lChooseOperator: TLabel
        Left = 31
        Top = 10
        Width = 95
        Height = 13
        Alignment = taRightJustify
        Caption = 'lChooseOperator'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object cbResources: TComboBox
        Left = 129
        Top = 6
        Width = 129
        Height = 22
        BevelKind = bkFlat
        Style = csOwnerDrawFixed
        ItemHeight = 16
        TabOrder = 0
        OnDrawItem = cbResourcesDrawItem
        OnMeasureItem = cbResourcesMeasureItem
        OnSelect = cbResourcesSelect
      end
    end
    object vpCalendar: TVpCalendar
      Left = 0
      Top = 33
      Width = 264
      Height = 140
      BevelInner = bvNone
      BevelOuter = bvNone
      BevelKind = bkFlat
      DataStore = vpDS
      ControlLink = vpLink
      Color = clInfoBk
      Ctl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Align = alTop
      BorderStyle = bsNone
      Colors.ActiveDay = clRed
      Colors.ColorScheme = cscalCustom
      Colors.DayNames = clGreen
      Colors.Days = clMaroon
      Colors.InactiveDays = clBlack
      Colors.MonthAndYear = clGreen
      Colors.Weekend = clBlack
      Colors.EventDays = clLime
      DateFormat = dfLong
      DayNameWidth = 3
      Options = [cdoShortNames, cdoShowYear, cdoShowRevert, cdoShowToday, cdoShowNavBtns, cdoHighlightSat, cdoHighlightSun]
      ParentCtl3D = False
      ReadOnly = False
      TabOrder = 2
      TabStop = True
      WantDblClicks = True
      WeekStarts = dtSunday
      OnChange = vpDSDateChanged
      OnDrawItem = vpCalendarDrawItem
    end
  end
  object pWork: TPanel
    Left = 0
    Top = 0
    Width = 522
    Height = 483
    Align = alClient
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 2
    object vpNavigator: TVpNavBar
      Left = 0
      Top = 0
      Width = 137
      Height = 483
      ActiveFolder = 0
      AllowRearrange = True
      BackgroundColor = clInactiveCaption
      BackgroundMethod = bmNormal
      BorderStyle = bsSingle
      ButtonHeight = 20
      DrawingStyle = dsStandardTab
      FolderCollection = <
        item
          Version = 'v1.03'
          Caption = 'nfDisplay'
          Enabled = True
          FolderType = ftDefault
          ItemCollection = <
            item
              Version = 'v1.03'
              Caption = 'nvDayCalendar'
              IconIndex = 15
              Name = 'nvDayCalendar'
              Tag = 0
            end
            item
              Version = 'v1.03'
              Caption = 'nvWeekCalendar'
              IconIndex = 21
              Name = 'nvWeekCalendar'
              Tag = 0
            end
            item
              Version = 'v1.03'
              Caption = 'nvContacts'
              IconIndex = 20
              Name = 'nvContacts'
              Tag = 0
            end
            item
              Version = 'v1.03'
              Caption = 'nvTasks'
              IconIndex = 46
              Name = 'nvTasks'
              Tag = 0
            end
            item
              Version = 'v1.03'
              Caption = 'nvSelection'
              IconIndex = 84
              Name = 'nvSelection'
              Tag = 0
            end
            item
              Version = 'v1.03'
              Caption = 'miChartSchedule'
              IconIndex = 67
              Name = 'miChartSchedule'
              Tag = 0
            end>
          IconSize = isLarge
          Name = 'nfDisplay'
          Tag = 0
        end
        item
          Version = 'v1.03'
          Caption = 'nfMessages'
          Enabled = True
          FolderType = ftDefault
          ItemCollection = <
            item
              Version = 'v1.03'
              Caption = 'nvNew'
              IconIndex = 53
              Name = 'nvNew'
              Tag = 0
            end
            item
              Version = 'v1.03'
              Caption = 'nvGet'
              IconIndex = 20
              Name = 'nvGet'
              Tag = 0
            end
            item
              Version = 'v1.03'
              Caption = 'nvList'
              IconIndex = 46
              Name = 'nvList'
              Tag = 0
            end
            item
              Version = 'v1.03'
              Caption = 'nvSendTo'
              IconIndex = 51
              Name = 'nvSendTo'
              Tag = 0
            end>
          IconSize = isLarge
          Name = 'nfMessages'
          Tag = 0
        end
        item
          Version = 'v1.03'
          Caption = 'nfContainer'
          Enabled = True
          FolderType = ftContainer
          ItemCollection = <>
          IconSize = isLarge
          Name = 'nfContainer'
          Tag = 0
          ContainerIndex = 0.000000000000000000
        end>
      ItemFont.Charset = DEFAULT_CHARSET
      ItemFont.Color = clWhite
      ItemFont.Height = -11
      ItemFont.Name = 'MS Sans Serif'
      ItemFont.Style = []
      ItemSpacing = 14
      PlaySounds = False
      SelectedItem = -1
      SelectedItemFont.Charset = DEFAULT_CHARSET
      SelectedItemFont.Color = clWhite
      SelectedItemFont.Height = -11
      SelectedItemFont.Name = 'MS Sans Serif'
      SelectedItemFont.Style = []
      ShowButtons = True
      SoundAlias = 'MenuCommand'
      OnItemClick = vpNavigatorItemClick
      Align = alLeft
      ParentColor = False
      object Container0: TVpFolderContainer
        Left = 0
        Top = 60
        Width = 0
        Height = 0
        BevelOuter = bvNone
        Color = clInactiveCaption
        TabOrder = 0
        Visible = False
        object vplEvents: TVpLEDLabel
          Left = 24
          Top = 80
          Width = 85
          Height = 30
          Caption = '0'
          Columns = 5
          OffColor = 930866
          OnColor = clLime
        end
        object lLoadEvents: TLabel
          Left = 24
          Top = 64
          Width = 59
          Height = 13
          Caption = 'lLoadEvents'
        end
        object lContacts: TLabel
          Left = 24
          Top = 136
          Width = 44
          Height = 13
          Caption = 'lContacts'
        end
        object vplContacts: TVpLEDLabel
          Left = 24
          Top = 152
          Width = 85
          Height = 30
          Caption = '0'
          Columns = 5
          OffColor = 930866
          OnColor = clLime
        end
        object lTasks: TLabel
          Left = 24
          Top = 208
          Width = 31
          Height = 13
          Caption = 'lTasks'
        end
        object vplTasks: TVpLEDLabel
          Left = 24
          Top = 224
          Width = 85
          Height = 30
          Caption = '0'
          Columns = 5
          OffColor = 930866
          OnColor = clLime
        end
        object vpClock: TVpClock
          Left = 0
          Top = 16
          Width = 136
          Height = 30
          Active = True
          ClockMode = cmClock
          DigitalOptions.MilitaryTime = True
          DigitalOptions.OnColor = clLime
          DigitalOptions.OffColor = 930866
          DigitalOptions.BgColor = clBlack
          DigitalOptions.Size = 2
          DigitalOptions.ShowSeconds = True
          DisplayMode = dmDigital
          AnalogOptions.DrawMarks = True
          AnalogOptions.HourHandColor = clBlack
          AnalogOptions.HourHandLength = 60
          AnalogOptions.HourHandWidth = 4
          AnalogOptions.MinuteHandColor = clBlack
          AnalogOptions.MinuteHandLength = 80
          AnalogOptions.MinuteHandWidth = 3
          AnalogOptions.SecondHandColor = clRed
          AnalogOptions.SecondHandLength = 90
          AnalogOptions.SecondHandWidth = 1
          AnalogOptions.ShowSecondHand = True
          AnalogOptions.SolidHands = True
          MinuteOffset = 0
          SecondOffset = 0
          HourOffset = 0
        end
      end
    end
  end
  object mMain: TMainMenu
    Left = 568
    Top = 432
    object miFolders: TMenuItem
      Caption = 'miFolders'
      object miDisplay: TMenuItem
        Caption = 'miDisplay'
        ImageIndex = 23
        object miDayCalendar: TMenuItem
          Caption = 'miDayCalendar'
          ImageIndex = 15
          ShortCut = 16452
          OnClick = miDayCalendarClick
        end
        object miWeekCalendar: TMenuItem
          Caption = 'miWeekCalendar'
          ImageIndex = 21
          ShortCut = 16471
          OnClick = miWeekCalendarClick
        end
        object miViewContacts: TMenuItem
          Caption = 'miViewContacts'
          ImageIndex = 20
          ShortCut = 16463
          OnClick = miViewContactsClick
        end
        object miViewTasks: TMenuItem
          Caption = 'miViewTasks'
          ImageIndex = 46
          ShortCut = 16468
          OnClick = miViewTasksClick
        end
        object miSelection: TMenuItem
          Caption = 'miSelection'
          Hint = 'miSelection'
          ImageIndex = 84
          ShortCut = 16467
          OnClick = miSelectionClick
        end
        object miChartSchedule: TMenuItem
          Caption = 'miChartSchedule'
          ImageIndex = 67
          ShortCut = 16455
          OnClick = miMonthChartClick
        end
      end
      object miMessages: TMenuItem
        Caption = 'miMessages'
        ImageIndex = 13
        object miNew: TMenuItem
          Caption = 'miNew'
          ImageIndex = 53
        end
        object miGet: TMenuItem
          Caption = 'miGet'
          ImageIndex = 20
          OnClick = miGetClick
        end
        object miList: TMenuItem
          Caption = 'miLis'
          ImageIndex = 46
          OnClick = miListClick
        end
        object miSendTo: TMenuItem
          Caption = 'miSendTo'
          ImageIndex = 51
          OnClick = miSendToClick
        end
      end
      object miContainer: TMenuItem
        Caption = 'miContainer'
        ImageIndex = 7
        ShortCut = 8308
        OnClick = miContainerClick
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object miClose: TMenuItem
        Caption = 'miClose'
        ImageIndex = 41
        ShortCut = 27
        OnClick = miCloseClick
      end
    end
    object miHelp: TMenuItem
      Caption = 'miHelp'
      object miTopics: TMenuItem
        Caption = 'miTopics'
        ImageIndex = 25
        OnClick = miTopicsClick
      end
      object miContents: TMenuItem
        Caption = 'miContents'
        ImageIndex = 25
        OnClick = miContentsClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object miAbout: TMenuItem
        Caption = 'miAbout'
        ImageIndex = 17
        OnClick = miAboutClick
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object miSendMail: TMenuItem
        Caption = 'miSendMail'
        ImageIndex = 58
        OnClick = miSendMailClick
      end
    end
  end
  object vpNotification: TVpNotificationDialog
    Version = 'v1.03'
    DataStore = vpDS
    Placement.Position = mpCustom
    Placement.Top = 10
    Placement.Left = 10
    Placement.Height = 250
    Placement.Width = 412
    Left = 568
    Top = 400
  end
  object trIcon: TRxTrayIcon
    Active = False
    Icon.Data = {
      0000010001002020000001001800A80C00001600000028000000200000004000
      00000100180000000000800C0000232E0000232E000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000303030000
      00392114583320563321573422573524583726593828593A295B3C2C5E3E2F5F
      41335F42365E43385E443860473A61493D624B3F634D42644F44655147665349
      67554C68564E695850695A526A5B546B5D556C5E576C5F586D605A8C7E790000
      007C462BC06E44BB6D45BC6F49BE724CBF7550C37A55C57E5CBF7D5EAF76579F
      6D499A6936AF7D38CC9D59D5A376D49F85D7A48BD9A990DBAD96DEB29CE0B6A1
      E2BAA7E4BEABE6C2B0E7C6B4E9C9B8EACCBCECCFC0EDD1C3EFD4C6E7CFC60000
      00774227B7673EB2663FB36843B66C46B86F4DAA6B4A905E33875B16966404B2
      7A00CF9924D3A159CD9873CA9479CE9A80D09F86D1A38CD4A892D6AD98D8B19D
      DAB5A2DBB9A7DDBDACDFC0B0E1C3B4E2C6B8E4C9BBE5CBBEE7CEC2E0CAC10000
      00764025B5643BB1633CB36640AF6744935C2C93620BB37800D08A00DF9B0AD9
      A345C68E69B77F68BB856CC79378BE9078C1957FD0A38DCFA694D3AC9AD8B29F
      DBB7A5DDBBAADFBFAEE0C2B3E2C6B7E4C9BBE5CCBEE6CEC2E8D1C5E0CBC30000
      00753E22B46137B16139A75F3B925E18B67A00D79001DE9401DB980BCC954ABD
      7E63BF8055A06B0E7A561AB78F79676361504B49BD9275926623785B32D3AF9D
      DDBAA9DEBDADE0C2B2E2C5B6E3C8BBE5CCBEE7CEC2E8D1C5E9D4C9E1CCC40000
      00743C20B35E34A75B369D6513C98800DE9403DD9402D79203C48D3EB97558BB
      7A5CC78651F0A402AD760ABC9782989A9C656669C1936EE297009F6F10D0AF9E
      DEBDACDFC0B0E2C5B6E3C8BAE5CCBEE7CFC2E8D1C6E9D4C9EBD7CCE2CDC60000
      00733A1DAF5931A3651ACF8B00DE9503DC9403DB9300C1891FB6724EB87250BB
      7757C58658ECB340D59F45C2957BA4908797837CCCA17BFDBF2BD9A437D6B6A4
      DFBFB0E1C4B4E3C8BAE5CCBFE7CFC3E8D2C6EAD5CAEBD7CDEDDAD0E2CFC70000
      0072371CAC5C28CA8704DE9502DC9403DD9503D08D02AF7435B46947B76F4BBA
      7552BB7C5DA87966A97C68C38E73C18F77C89A83D3A993CDAE96CBAF99DBBBAB
      E1C3B3E3C7B9E5CCBFE7CFC3E9D3C7EAD6CBEBD8CEECDBD1EEDED5E3D0C90000
      006F331ABF711ADF9701DC9403DB9403DE9501BE820BAA663BB36540B56B46B9
      704CB581666D6E6F4B4A4BAE7F5C9563117A5923C0A2916B6A6A514E4DCBB0A2
      E5C9BAE5CCBFE7D0C4E9D4C9EBD7CDECDAD0EDDCD3EEDED6F0E1D9E4D2CB0000
      006D3117D6840FE19802DC9403DC9403DE9501AD770FA75E38B06139B26640B5
      6A44BB866B989C9E67696CB58359EEA102B57D10C8AD9D909294646363CBB2A5
      E8CEC1E7D1C5EAD5CAEBD8CEEDDBD2EEDED6EFE0D8F0E2DBF2E5DEE5D3CD0000
      006D3014E49110E19802DC9403DC9403DF9602A8720CA25730AE5B32AF6038B3
      663EB477589980748C7369C08F66F4C244E2AF4FCFB19F9D97958B8480D6BFB3
      EAD3C7EAD6CCECDAD1EEDDD5EFE0D8F0E3DBF2E5DEF2E7E0F4E9E3E5D5CF0000
      006A2A10E08F12E69E03DB9303DC9403DF9603B07704924D23AC552BAC592FAF
      5F37B2663FB86E4ABF7C5AC4896EC89887D2AA9CD9B7A9DEC2B6E9D0C6EFDAD0
      F0DDD4EFDED6EFE0D8F1E3DCF2E5DFF3E8E1F4E9E4F5EBE6F6EEE9E6D6D10000
      0068260BCA7819F3B415DB9101DC9403DE9503CA8801844F17A74D24A85126AA
      562CAE5D35B46942C28152C59257BC8C37B0812C986E2C896836907551A48F78
      C4B4A9E7DAD6F9EEE9F7EDE7F5EBE6F6EDE8F6EEEAF7EFEBF9F2EEE7D8D30000
      00692607A9470EF0B728E7A20CDB9202DC9403DD95029665068E431AA6481BA5
      4C20A85227AC5A31B56B43C48862D9AC78ECC56FF0BC38E29F01C37F00A16900
      875A037E5E269F8E76DFD8D4FEF9F7FAF4F0F9F3F0F9F4F1FBF7F4E8DAD50000
      006825039C3404B96511FAC21BE59C05DB9202DD9502CD8A017C4F0C933E14A2
      3F0FA04314A3481BA85227B36945CEA08BE6CFCAF1E5DDFBE7B1FFCD41F4A900
      DD9200C98500A169007A5818A79B89F8F6F6FEFCFBFCF9F7FDFCFAE9DCD80000
      006722019E3501952E01C07011FABB11ECA204DD9303DE9503BD800271470A89
      360C9E37059B37069C3A09A14417D6AE99F8F3EFFAF7F5FBFAFFFCFBF6FFE283
      F8B60CE29903DE9403CF8900925F008B7753EEEEEDFFFFFFFFFFFEEADDD90000
      006824029F38049A3604973205B56114EEAC16F8AF06E89C01E19602BF800278
      50097B3E159D461DAA5126B46842D1A48DE9D4CAF1E5DEF5ECE7F7F0EEF8F5F9
      FDE491F6BB1BDD9403DD9402DD9402A96D008A754CF5F3F3FFFEFDE9DCD80000
      00692807A23D0B9D3C0C9E3D0D9B390DA44916CD8421F1AD18FAB00AF5A703DE
      9500A26E017A4F0F875229AB7153C89883DCBAABE6CEC3ECDAD1F0E1DAF2E7E2
      F4ECECFCDC77ECAA11DB9201DC9403DF9503A36900A6977BFEFDFDE8DAD50000
      006B2A0BA44211A04112A04214A14415A143179F421AA85324C0762CDA972BED
      A924F6B11CEBA712CD9311BA871BBA8D3DC8A471DCBEA5E7CEC2EAD6CCEDDCD3
      F0E2DDF3E4CFF8C433DF9501DB9303DD9403DA9100916612E2DCD6EADBD70000
      006C2D0EA74717A24618A3471AA4491CA54B1FA64E22A74F25A75029A85530AE
      603AB77147BD8253C38D5ED09B6BD3A57FD6AE94DCB9A6E5C7B7EBD1C4EAD4C9
      ECD9CFEEDFDEF5CA69E69B00DB9303DC9403DF9602B67700BBAD96EBDCD90000
      006E3012A94B1CA44A1DA54C20A64E23A85125A95328AB572CAD5B31AF6038B3
      653EB075586D6867575151AE7D5F956727856439C8AA99867D7978706BD7C0B4
      EAD4C8EAD9D4EECC97EA9E01DB9303DC9403DD9503CB8500B1996FE9DAD80000
      006F3315AB4F22A74F23A85125A95328AA552BAB592FAD5C33B06139B2663FB5
      6A44BA8468919495656668B58359E09600A87410C7AB9C838687555555CAB2A5
      E8CFC2E8D3CBE7C6A2E89C04DB9302DC9403DD9503CE8800B79D6CE8D8D60000
      00703518AD5327A95328AA552AAB572DAC5A31AE5D35B0613AB2663FB56B45B8
      6F4BBB856A9994927A7372BC8C62FDBD25DEA42FCBAD9A9A9897787471CDB1A3
      E5C9BBE6CFC5DFBA90E29601DC9402DC9403DD9503CC8700CBB388E7D6D30000
      0072381BAF572BAA562CAB592FAD5B32AE5E36B0623AB2663FB46A44B76F4BBA
      7552BA7A5AAE7960B38169C79276C99E80CDA588D2A994CEAB9CD4B3A4DDBDAC
      E1C3B4E4CBC2D2A260DE9300DC9403DC9403DD9301C78C0FE2D1BCE4D2CD0000
      00733A1DB15A2FAC5A30AD5C33AF5F37B0623BB2663FB46944B66E49B9734FBC
      7858BC7C5190611373511EB990796E6868544E4DC0977CA4773D8F704BD7B6A4
      E1C2B2D8BAACC7891DDE9401DC9403DC9403D88F00D3AF62EDDDD7E2CFC80000
      00743C20B25E33AE5D34AF6037B0623BB2663FB46943B66D48B8714DBA7653BC
      7A5CC78550EA9F02A87209BC9681929395616264C0936DDD9200996A0FD1B09F
      E0C0B4BA8D55D28B00DD9402DC9302DD9200D9A736E7D3C2ECD8CFE2CEC60000
      00753E22B46137AF6038B1633BB2663FB46943B56C47B7704CB97451BB7857BD
      7C5EC88B5AF5B92FD7A033C199809B9390857C79C79B75FCBD24D5A02FD6B4A5
      B6906DBE7E05DD9402DD9301E39600E2AE38E5CFB4E8D2CAE9D4C9E1CCC40000
      00754024B5643AB1633CB2663FB36843B56B46B76F4BB8724FBA7654BC7B59BF
      7F5FC28566C58D70C99376C99478C8967DCB9D85D2A58CDAB395D6B298A9825A
      B17504DE9300E59800E9A40FE8BE61E5CCB7E5CCC3E6CEC2E8D1C5E1CBC30000
      00774127B7663EB2663FB36842B56B46B66E4AB8714EBA7552BC7957BE7D5CC0
      8161C28567C48A6DC78E73C99479CD9A7FCF9F87CD9F8BB98D70A37229C68200
      EDA101F0AD1AEDBC51E5C798E1C6BAE2C6BAE4C9BBE5CCBFE7CFC2E0CAC20000
      00743F23B6653CB2643DB36740B46A44B66D48B8704CB97451BB7855BD7C5ABF
      805FC28465C4896BC68E71C89277C9957AC9986FCD9F53D6A329ECB232F1BC52
      E7BE78E0BE9BDDBCAEDEBDB0E0C1B1E1C4B4E3C7B8E4C9BBE6CCBEE0C9C01916
      169B7767CB9881C79680C89882C89983C99B85CA9C88CB9E8ACCA08CCDA28ECE
      A491CFA693D0A896D1AA99D2AC9CD2AD9CD5B29CDBBCA4DCBEA7D9BCAED8BBB2
      D8BBB3DABDB3DBBFB3DCC1B5DDC3B7DEC4B9DFC6BBDFC7BDE0C8BEDDC7C00000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000}
    PopupMenu = pmTray
    OnDblClick = pmiShowScheduleClick
    Left = 600
    Top = 336
  end
  object pmTray: TPopupMenu
    Left = 599
    Top = 368
    object pmiShowSchedule: TMenuItem
      Caption = 'pmiShowSchedule'
      ImageIndex = 21
      OnClick = pmiShowScheduleClick
    end
    object pmiHideSchedule: TMenuItem
      Caption = 'pmiHideSchedule'
      ImageIndex = 41
      OnClick = pmiHideScheduleClick
    end
    object pmiCloseLibrary: TMenuItem
      Caption = 'pmiCloseLibrary'
      ImageIndex = 56
      OnClick = miCloseClick
    end
  end
  object pmEventos: TPopupMenu
    Left = 600
    Top = 400
    object miSelAllCustumers: TMenuItem
      Caption = 'miSelAllCustumers'
      ImageIndex = 51
    end
  end
  object pmTypeContact: TPopupMenu
    Left = 631
    Top = 432
    object miCompany: TMenuItem
      Caption = 'miCompany'
      ImageIndex = 66
      OnClick = miCompanyClick
    end
    object miPeople: TMenuItem
      Tag = 1
      Caption = 'miPeople'
      ImageIndex = 51
      OnClick = miCompanyClick
    end
  end
  object pmFields: TPopupMenu
    Left = 599
    Top = 432
    object pmEqual: TMenuItem
      Caption = 'pmEqual'
      Checked = True
    end
    object pmNoEqual: TMenuItem
      Tag = 1
      Caption = 'pmNoEqual'
      OnClick = pmFilterClick
    end
    object pmStartWith: TMenuItem
      Tag = 2
      Caption = 'pmStartWith'
      OnClick = pmFilterClick
    end
    object pmNoStartWith: TMenuItem
      Tag = 3
      Caption = 'pmNoStartWith'
      OnClick = pmFilterClick
    end
    object pmFinishWith: TMenuItem
      Tag = 4
      Caption = 'pmFinishWith'
      OnClick = pmFilterClick
    end
    object pmNoFinishWith: TMenuItem
      Tag = 5
      Caption = 'pmNoFinishWith'
      OnClick = pmFilterClick
    end
    object pmContaining: TMenuItem
      Tag = 6
      Caption = 'pmContaining'
      OnClick = pmFilterClick
    end
    object pmNoContaining: TMenuItem
      Tag = 7
      Caption = 'pmNoContaining'
      OnClick = pmFilterClick
    end
  end
  object vpDS: TVirtualData
    AutoConnect = False
    AutoCreate = False
    CategoryColorMap.Category0.Color = clNavy
    CategoryColorMap.Category0.Description = 'Categoria 0'
    CategoryColorMap.Category1.Color = clRed
    CategoryColorMap.Category1.Description = 'Categoria 1'
    CategoryColorMap.Category2.Color = clYellow
    CategoryColorMap.Category2.Description = 'Categoria 2'
    CategoryColorMap.Category3.Color = clLime
    CategoryColorMap.Category3.Description = 'Categoria 3'
    CategoryColorMap.Category4.Color = clPurple
    CategoryColorMap.Category4.Description = 'Categoria 4'
    CategoryColorMap.Category5.Color = clTeal
    CategoryColorMap.Category5.Description = 'Categoria 5'
    CategoryColorMap.Category6.Color = clFuchsia
    CategoryColorMap.Category6.Description = 'Categoria 6'
    CategoryColorMap.Category7.Color = clOlive
    CategoryColorMap.Category7.Description = 'Categoria 7'
    CategoryColorMap.Category8.Color = clAqua
    CategoryColorMap.Category8.Description = 'Categoria 8'
    CategoryColorMap.Category9.Color = clMaroon
    CategoryColorMap.Category9.Description = 'Categoria 9'
    DefaultEventSound = 
      'C:\Documents and Settings\Alcindo\Meus documentos\Minhas m'#250'sicas' +
      '\miranda.wav'
    EnableEventTimer = True
    PlayEventSounds = True
    OnAlert = vpDSAlert
    OnDateChanged = vpDSDateChanged
    OnLoadContacts = vpDSLoadContacts
    OnLoadEvents = vpDSLoadEvents
    OnLoadTasks = vpDSLoadTasks
    Left = 567
    Top = 336
  end
  object vpLink: TVpControlLink
    DataStore = vpDS
    Printer.DayStart = h_08
    Printer.DayEnd = h_05
    Printer.Granularity = gr30Min
    Printer.MarginUnits = imAbsolutePixel
    Printer.PrintFormats = <>
    Left = 567
    Top = 368
  end
end
