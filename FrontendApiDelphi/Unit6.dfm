object uFrmUsuarios: TuFrmUsuarios
  Left = 0
  Top = 0
  Width = 640
  Height = 480
  TabOrder = 0
  object pnlSuperior: TPanel
    Left = 0
    Top = 0
    Width = 640
    Height = 40
    Align = alTop
    BevelOuter = bvNone
    Color = clHotLight
    ParentBackground = False
    TabOrder = 0
    object lblTitulo: TLabel
      Left = 10
      Top = 12
      Width = 106
      Height = 15
      Caption = 'Listado de Usuarios'
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
    Width = 640
    Height = 73
    Align = alTop
    BevelOuter = bvNone
    Color = 15765991
    ParentBackground = False
    TabOrder = 1
    object DBNavigator1: TDBNavigator
      AlignWithMargins = True
      Left = 10
      Top = 3
      Width = 622
      Height = 62
      Margins.Left = 8
      Margins.Right = 8
      Margins.Bottom = 8
      DataSource = DataSource1
      Align = alRight
      TabOrder = 0
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 113
    Width = 640
    Height = 367
    Align = alClient
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 2
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
    Left = 200
    Top = 200
  end
  object DataSource1: TDataSource
    DataSet = FDMemTable1
    Left = 280
    Top = 200
  end
  object RESTClient1: TRESTClient
    BaseURL = 'https://borjapau2026.fabricomiweb.com'
    Params = <>
    SynchronizedEvents = False
    Left = 360
    Top = 200
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <>
    Resource = 'Usuarios'
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 440
    Top = 200
  end
  object RESTResponse1: TRESTResponse
    Left = 520
    Top = 200
  end
end
