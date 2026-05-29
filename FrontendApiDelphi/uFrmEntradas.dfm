object Frame5: TFrame5
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
      Caption = 'Gesti'#243'n de Entradas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btnDetach: TSpeedButton
      Left = 1038
      Top = 0
      Width = 40
      Height = 40
      Align = alRight
      Caption = #9633
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      Hint = 'Abrir en ventana independiente'
      ParentFont = False
      ShowHint = True
      OnClick = btnDetachClick
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
    Height = 130
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object lblIdSesion: TLabel
      Left = 10
      Top = 15
      Width = 51
      Height = 15
      Caption = 'ID Sesi'#243'n:'
    end
    object lblIdCliente: TLabel
      Left = 10
      Top = 50
      Width = 54
      Height = 15
      Caption = 'ID Cliente:'
    end
    object lblCantidad: TLabel
      Left = 10
      Top = 85
      Width = 97
      Height = 15
      Caption = 'Cantidad asientos:'
    end
    object lblPrecio: TLabel
      Left = 10
      Top = 113
      Width = 63
      Height = 15
      Caption = 'Precio base:'
    end
    object DBEdtIdSesion: TDBEdit
      Left = 130
      Top = 12
      Width = 100
      Height = 23
      DataField = 'id_sesion'
      DataSource = DataSource1
      TabOrder = 0
    end
    object DBEdtIdCliente: TDBEdit
      Left = 130
      Top = 47
      Width = 100
      Height = 23
      DataField = 'id_cliente'
      DataSource = DataSource1
      TabOrder = 1
    end
    object DBEdtCantidad: TDBEdit
      Left = 130
      Top = 82
      Width = 100
      Height = 23
      DataField = 'cantidad_asientos'
      DataSource = DataSource1
      TabOrder = 2
    end
    object DBEdtPrecio: TDBEdit
      Left = 130
      Top = 110
      Width = 100
      Height = 23
      DataField = 'precio_base'
      DataSource = DataSource1
      TabOrder = 3
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 243
    Width = 1078
    Height = 391
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
    Resource = 'Entradas'
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
