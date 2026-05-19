object fPrincipal: TfPrincipal
  Left = 0
  Top = 0
  Caption = 'CineElxVirtual'
  ClientHeight = 600
  ClientWidth = 950
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIForm
  WindowState = wsMaximized
  TextHeight = 15
  object pnlSuperior: TPanel
    Left = 0
    Top = 0
    Width = 950
    Height = 40
    Align = alTop
    BevelOuter = bvNone
    Color = 10510110
    TabOrder = 0
    object lblBienvenido: TLabel
      Left = 10
      Top = 12
      Width = 3
      Height = 15
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object pnlLateral: TPanel
    Left = 0
    Top = 40
    Width = 160
    Height = 560
    Align = alLeft
    BevelOuter = bvNone
    Color = 15921906
    TabOrder = 1
    object btnPeliculas: TButton
      Left = 5
      Top = 10
      Width = 150
      Height = 55
      Caption = 'Pel'#195#173'culas'
      TabOrder = 0
      OnClick = btnPeliculasClick
    end
    object btnSalas: TButton
      Left = 5
      Top = 75
      Width = 150
      Height = 55
      Caption = 'Salas'
      TabOrder = 1
      OnClick = btnSalasClick
    end
    object btnClientes: TButton
      Left = 5
      Top = 140
      Width = 150
      Height = 55
      Caption = 'Clientes'
      TabOrder = 2
      OnClick = btnClientesClick
    end
    object btnSesiones: TButton
      Left = 5
      Top = 205
      Width = 150
      Height = 55
      Caption = 'Sesiones'
      TabOrder = 3
      OnClick = btnSesionesClick
    end
    object btnEntradas: TButton
      Left = 5
      Top = 270
      Width = 150
      Height = 55
      Caption = 'Entradas'
      TabOrder = 4
      OnClick = btnEntradasClick
    end
    object btnSalir: TButton
      Left = 5
      Top = 490
      Width = 150
      Height = 55
      Caption = 'Salir'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      OnClick = btnSalirClick
    end
  end
end
