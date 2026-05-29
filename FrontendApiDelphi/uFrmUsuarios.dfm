object uFrmUsuarios: TuFrmUsuarios
  Left = 0
  Top = 0
  Width = 961
  Height = 579
  TabOrder = 0
  object pnlSuperior: TPanel
    Left = 0
    Top = 0
    Width = 961
    Height = 40
    Align = alTop
    BevelOuter = bvNone
    Color = clHotLight
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 640
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
    object btnDetach: TSpeedButton
      Left = 921
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
    Width = 961
    Height = 73
    Align = alTop
    BevelOuter = bvNone
    Color = 15765991
    ParentBackground = False
    TabOrder = 1
    ExplicitWidth = 640
    object DBNavigator1: TDBNavigator
      AlignWithMargins = True
      Left = 331
      Top = 3
      Width = 622
      Height = 62
      Margins.Left = 8
      Margins.Right = 8
      Margins.Bottom = 8
      DataSource = DataSource1
      Align = alRight
      TabOrder = 0
      ExplicitLeft = 10
    end
  end
  object pnlFormulario: TPanel
    Left = 0
    Top = 113
    Width = 961
    Height = 90
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitWidth = 640
    object lblUsername: TLabel
      Left = 10
      Top = 15
      Width = 56
      Height = 15
      Caption = 'Username:'
    end
    object lblRol: TLabel
      Left = 10
      Top = 50
      Width = 20
      Height = 15
      Caption = 'Rol:'
    end
    object lblFechaRegistro: TLabel
      Left = 330
      Top = 15
      Width = 77
      Height = 15
      Caption = 'Fecha registro:'
    end
    object DBEdtUsername: TDBEdit
      Left = 100
      Top = 12
      Width = 200
      Height = 23
      DataField = 'username'
      DataSource = DataSource1
      ReadOnly = True
      TabOrder = 0
    end
    object DBComboRol: TDBComboBox
      Left = 100
      Top = 47
      Width = 150
      Height = 23
      DataField = 'rol'
      DataSource = DataSource1
      Items.Strings = (
        'admin'
        'usuario'
        'empleado'
        'gerente')
      TabOrder = 1
    end
    object DBEdtFechaRegistro: TDBEdit
      Left = 420
      Top = 12
      Width = 150
      Height = 23
      DataField = 'fecha_registro'
      DataSource = DataSource1
      ReadOnly = True
      TabOrder = 2
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 203
    Width = 961
    Height = 376
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
    Left = 200
    Top = 280
  end
  object DataSource1: TDataSource
    DataSet = FDMemTable1
    Left = 280
    Top = 280
  end
  object RESTClient1: TRESTClient
    BaseURL = 'https://borjapau2026.fabricomiweb.com'
    Params = <>
    SynchronizedEvents = False
    Left = 360
    Top = 280
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <>
    Resource = 'Usuarios'
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 440
    Top = 280
  end
  object RESTResponse1: TRESTResponse
    Left = 520
    Top = 280
  end
end
