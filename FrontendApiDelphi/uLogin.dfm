object fLogin: TfLogin
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'CineElxVirtual'
  ClientHeight = 223
  ClientWidth = 343
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object lblUsuario: TLabel
    Left = 30
    Top = 72
    Width = 43
    Height = 15
    Caption = 'Usuario:'
  end
  object lblClave: TLabel
    Left = 30
    Top = 107
    Width = 32
    Height = 15
    Caption = 'Clave:'
  end
  object pnlTitulo: TPanel
    Left = 0
    Top = 0
    Width = 343
    Height = 45
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Iniciar Sesi'#243'n'
    Color = clHotLight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 3
    ExplicitWidth = 310
  end
  object edtUsuario: TEdit
    Left = 110
    Top = 69
    Width = 170
    Height = 23
    TabOrder = 0
  end
  object edtClave: TEdit
    Left = 110
    Top = 104
    Width = 170
    Height = 23
    PasswordChar = '*'
    TabOrder = 1
  end
  object btnAceptar: TButton
    Left = 105
    Top = 150
    Width = 100
    Height = 30
    Caption = #10003' Aceptar'
    Default = True
    TabOrder = 2
    OnClick = btnAceptarClick
  end
  object RESTClient1: TRESTClient
    BaseURL = 'https://borjapau2026.fabricomiweb.com'
    Params = <>
    SynchronizedEvents = False
    Left = 296
    Top = 48
  end
  object RESTRequest1: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient1
    Method = rmPOST
    Params = <
      item
        Kind = pkREQUESTBODY
        Name = 'body6BFF7C5C278C48808BACF3605D39CFFF'
        Value = '{'#13#10'    "username": "pau",'#13#10'    "password": "1234"'#13#10'}'
        ContentTypeStr = 'application/json'
      end>
    Resource = 'Login'
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 288
    Top = 152
  end
  object RESTResponse1: TRESTResponse
    Left = 288
    Top = 96
  end
end
