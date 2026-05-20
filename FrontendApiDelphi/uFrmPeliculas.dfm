object Frame1: TFrame1
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
    Color = 10510110
    TabOrder = 0
    object lblTitulo: TLabel
      Left = 10
      Top = 12
      Width = 110
      Height = 15
      Caption = 'Gesti'#243'n de Peliculas'
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
    object lblTituloF: TLabel
      Left = 10
      Top = 15
      Width = 31
      Height = 15
      Caption = 'T'#237'tulo'
    end
    object lblDuracion: TLabel
      Left = 10
      Top = 50
      Width = 48
      Height = 15
      Caption = 'Duraci'#243'n'
    end
    object lblGenero: TLabel
      Left = 10
      Top = 85
      Width = 41
      Height = 15
      Caption = 'G'#233'nero:'
    end
    object edtTitulo: TEdit
      Left = 100
      Top = 12
      Width = 300
      Height = 23
      TabOrder = 0
    end
    object edtDuracion: TEdit
      Left = 100
      Top = 47
      Width = 100
      Height = 23
      TabOrder = 1
    end
    object edtGenero: TEdit
      Left = 100
      Top = 82
      Width = 200
      Height = 23
      TabOrder = 2
    end
  end
  object grdPeliculas: TStringGrid
    Left = 0
    Top = 190
    Width = 640
    Height = 290
    Align = alClient
    ColCount = 4
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
    TabOrder = 3
    OnClick = grdPeliculasClick
    ColWidths = (
      50
      250
      80
      150)
  end
end
