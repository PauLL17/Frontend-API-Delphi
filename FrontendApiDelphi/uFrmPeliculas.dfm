object Frame1: TFrame1
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
      Width = 110
      Height = 15
      Caption = 'Gestion de Peliculas'
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
    object lblTituloF: TLabel
      Left = 10
      Top = 15
      Width = 31
      Height = 15
      Caption = 'Titulo'
    end
    object lblDuracion: TLabel
      Left = 10
      Top = 50
      Width = 48
      Height = 15
      Caption = 'Duracion'
    end
    object lblGenero: TLabel
      Left = 10
      Top = 85
      Width = 41
      Height = 15
      Caption = 'Genero:'
    end
    object DBEdtTitulo: TDBEdit
      Left = 100
      Top = 12
      Width = 300
      Height = 23
      DataField = 'titulo'
      DataSource = DataSource1
      TabOrder = 0
    end
    object DBEdtDuracion: TDBEdit
      Left = 100
      Top = 47
      Width = 100
      Height = 23
      DataField = 'duracion'
      DataSource = DataSource1
      TabOrder = 1
    end
    object DBEdtGenero: TDBEdit
      Left = 100
      Top = 82
      Width = 200
      Height = 23
      DataField = 'genero'
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
    BeforeEdit = FDMemTable1BeforeEdit
    AfterPost = FDMemTable1AfterPost
    BeforeDelete = FDMemTable1BeforeDelete
    AfterRefresh = FDMemTable1AfterRefresh
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
    Resource = 'Peliculas'
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
