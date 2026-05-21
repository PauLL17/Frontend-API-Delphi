object Frame4: TFrame4
  Left = 0
  Top = 0
  Width = 1078
  Height = 634
  TabOrder = 0
  object pnlSuperior: TPanel
    Left = 0
    Top = 0
    Width = 1078
    Height = 40
    Align = alTop
    BevelOuter = bvNone
    Color = clHotLight
    ParentBackground = False
    TabOrder = 0
    object lblTitulo: TLabel
      Left = 10
      Top = 12
      Width = 111
      Height = 15
      Caption = 'Gesti'#243'n de Sesiones'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 40
    Width = 1078
    Height = 73
    Align = alTop
    BevelOuter = bvNone
    Color = 15765991
    ParentBackground = False
    TabOrder = 1
    object DBNavigator1: TDBNavigator
      AlignWithMargins = True
      Left = 584
      Top = 3
      Width = 486
      Height = 62
      Margins.Left = 8
      Margins.Right = 8
      Margins.Bottom = 8
      DataSource = DataSource1
      Align = alRight
      TabOrder = 0
    end
  end
  object pnlFormulario: TPanel
    Left = 0
    Top = 113
    Width = 1078
    Height = 110
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object lblIdPelicula: TLabel
      Left = 10
      Top = 15
      Width = 58
      Height = 15
      Caption = 'ID Pel'#237'cula:'
    end
    object lblIdSala: TLabel
      Left = 10
      Top = 50
      Width = 38
      Height = 15
      Caption = 'ID Sala:'
    end
    object lblFechaHora: TLabel
      Left = 10
      Top = 85
      Width = 65
      Height = 15
      Caption = 'Fecha/Hora:'
    end
    object DBEdtIdPelicula: TDBEdit
      Left = 100
      Top = 12
      Width = 100
      Height = 23
      DataField = 'id_pelicula'
      DataSource = DataSource1
      TabOrder = 0
    end
    object DBEdtIdSala: TDBEdit
      Left = 100
      Top = 47
      Width = 100
      Height = 23
      DataField = 'id_sala'
      DataSource = DataSource1
      TabOrder = 1
    end
    object DBEdtFechaHora: TDBEdit
      Left = 100
      Top = 82
      Width = 200
      Height = 23
      DataField = 'fecha_hora'
      DataSource = DataSource1
      TabOrder = 2
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 223
    Width = 1078
    Height = 411
    Align = alClient
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
  object FDMemTable1: TFDMemTable
    AfterPost = FDMemTable1AfterPost
    BeforeDelete = FDMemTable1BeforeDelete
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 440
    Top = 112
  end
  object DataSource1: TDataSource
    DataSet = FDMemTable1
    Left = 520
    Top = 112
  end
  object RESTClient1: TRESTClient
    BaseURL = 'https://borjapau2026.fabricomiweb.com'
    Params = <>
    SynchronizedEvents = False
    Left = 600
    Top = 112
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <>
    Resource = 'Sesiones'
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 680
    Top = 112
  end
  object RESTResponse1: TRESTResponse
    Left = 760
    Top = 112
  end
end
