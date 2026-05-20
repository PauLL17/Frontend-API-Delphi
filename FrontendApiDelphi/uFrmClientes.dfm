object Frame3: TFrame3
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
      Width = 107
      Height = 15
      Caption = 'Gesti'#243'n de Clientes'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object pnlBotones: TPanel
    Left = 0
    Top = 40
    Width = 640
    Height = 40
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object btnNuevo: TButton
      Left = 5
      Top = 8
      Width = 80
      Height = 25
      Caption = 'Nuevo'
      TabOrder = 0
      OnClick = btnNuevoClick
    end
    object btnGuardar: TButton
      Left = 90
      Top = 8
      Width = 80
      Height = 25
      Caption = 'Guardar'
      TabOrder = 1
      OnClick = btnGuardarClick
    end
    object btnEliminar: TButton
      Left = 175
      Top = 8
      Width = 80
      Height = 25
      Caption = 'Eliminar'
      TabOrder = 2
      OnClick = btnEliminarClick
    end
    object btnCancelar: TButton
      Left = 260
      Top = 8
      Width = 80
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 3
      OnClick = btnCancelarClick
    end
  end
  object pnlFormulario: TPanel
    Left = 0
    Top = 80
    Width = 640
    Height = 110
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object lblNombre: TLabel
      Left = 10
      Top = 15
      Width = 47
      Height = 15
      Caption = 'Nombre:'
    end
    object lblEmail: TLabel
      Left = 10
      Top = 50
      Width = 32
      Height = 15
      Caption = 'Email:'
    end
    object lblTelefono: TLabel
      Left = 10
      Top = 85
      Width = 49
      Height = 15
      Caption = 'Tel'#233'fono:'
    end
    object edtNombre: TEdit
      Left = 100
      Top = 12
      Width = 300
      Height = 23
      TabOrder = 0
    end
    object edtEmail: TEdit
      Left = 100
      Top = 47
      Width = 300
      Height = 23
      TabOrder = 1
    end
    object edtTelefono: TEdit
      Left = 100
      Top = 82
      Width = 150
      Height = 23
      TabOrder = 2
    end
  end
  object grdClientes: TStringGrid
    Left = 0
    Top = 190
    Width = 640
    Height = 290
    Align = alClient
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
    TabOrder = 3
    OnClick = grdClientesClick
    ExplicitTop = 191
    ColWidths = (
      50
      150
      200
      100
      130)
  end
end
