object fLogin: TfLogin
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'CineElxVirtual'
  ClientHeight = 290
  ClientWidth = 370
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object pnlTitulo: TPanel
    Left = 0
    Top = 0
    Width = 370
    Height = 45
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Iniciar Sesion'
    Color = clHotLight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
  end
  object pgcLogin: TPageControl
    Left = 0
    Top = 45
    Width = 370
    Height = 245
    ActivePage = tabRegistro
    Align = alClient
    TabOrder = 1
    OnChange = pgcLoginChange
    object tabLogin: TTabSheet
      Caption = 'Iniciar Sesion'
      object lblUsuario: TLabel
        Left = 20
        Top = 32
        Width = 43
        Height = 15
        Caption = 'Usuario:'
      end
      object lblClave: TLabel
        Left = 20
        Top = 67
        Width = 32
        Height = 15
        Caption = 'Clave:'
      end
      object edtUsuario: TEdit
        Left = 90
        Top = 29
        Width = 180
        Height = 23
        TabOrder = 0
      end
      object edtClave: TEdit
        Left = 90
        Top = 64
        Width = 180
        Height = 23
        PasswordChar = '*'
        TabOrder = 1
      end
      object btnAceptar: TButton
        Left = 120
        Top = 113
        Width = 100
        Height = 30
        Caption = #10003' Aceptar'
        Default = True
        TabOrder = 2
        OnClick = btnAceptarClick
      end
    end
    object tabRegistro: TTabSheet
      Caption = 'Registro'
      object lblRegUsuario: TLabel
        Left = 20
        Top = 20
        Width = 43
        Height = 15
        Caption = 'Usuario:'
      end
      object lblRegClave: TLabel
        Left = 20
        Top = 55
        Width = 32
        Height = 15
        Caption = 'Clave:'
      end
      object edtRegUsuario: TEdit
        Left = 90
        Top = 17
        Width = 180
        Height = 23
        TabOrder = 0
      end
      object edtRegClave: TEdit
        Left = 90
        Top = 52
        Width = 180
        Height = 23
        PasswordChar = '*'
        TabOrder = 1
      end
      object btnRegistrarse: TButton
        Left = 115
        Top = 100
        Width = 120
        Height = 30
        Caption = #10003' Registrarse'
        TabOrder = 2
        OnClick = btnRegistrarseClick
      end
    end
  end
  object RESTClient1: TRESTClient
    BaseURL = 'https://borjapau2026.fabricomiweb.com'
    Params = <>
    SynchronizedEvents = False
    Left = 300
    Top = 60
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Method = rmPOST
    Params = <>
    Resource = 'Login'
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 300
    Top = 120
  end
  object RESTResponse1: TRESTResponse
    Left = 300
    Top = 180
  end
end
