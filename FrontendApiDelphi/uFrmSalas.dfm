object Frame2: TFrame2
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
      Width = 90
      Height = 15
      Caption = 'Gesti'#243'n de Salas'
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
    end
    object btnGuardar: TButton
      Left = 90
      Top = 8
      Width = 80
      Height = 25
      Caption = 'Guardar'
      TabOrder = 1
    end
    object btnEliminar: TButton
      Left = 175
      Top = 8
      Width = 80
      Height = 25
      Caption = 'Eliminar'
      TabOrder = 2
    end
    object btnCancelar: TButton
      Left = 260
      Top = 8
      Width = 80
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 3
    end
  end
  object pnlFormulario: TPanel
    Left = 0
    Top = 80
    Width = 640
    Height = 80
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
    object lblCapacidad: TLabel
      Left = 10
      Top = 50
      Width = 59
      Height = 15
      Caption = 'Capacidad:'
    end
    object edtNombre: TEdit
      Left = 100
      Top = 12
      Width = 300
      Height = 23
      TabOrder = 0
    end
    object edtCapacidad: TEdit
      Left = 100
      Top = 47
      Width = 100
      Height = 23
      TabOrder = 1
    end
  end
  object grdSalas: TStringGrid
    Left = 0
    Top = 160
    Width = 640
    Height = 320
    Align = alClient
    ColCount = 3
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
    TabOrder = 3
    ColWidths = (
      50
      250
      100)
  end
end
