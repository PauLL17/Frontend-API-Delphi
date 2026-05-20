unit uFrmSalas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids;

type
  TFrame2 = class(TFrame)
    pnlSuperior: TPanel;
    lblTitulo: TLabel;
    pnlBotones: TPanel;
    btnNuevo: TButton;
    btnGuardar: TButton;
    btnEliminar: TButton;
    btnCancelar: TButton;
    pnlFormulario: TPanel;
    lblNombre: TLabel;
    lblCapacidad: TLabel;
    edtNombre: TEdit;
    edtCapacidad: TEdit;
    grdSalas: TStringGrid;
    procedure grdSalasClick(Sender: TObject);
    procedure btnNuevoClick(Sender: TObject);
    procedure btnGuardarClick(Sender: TObject);
    procedure btnEliminarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TFrame2.grdSalasClick(Sender: TObject);
begin
//
end;

procedure TFrame2.btnNuevoClick(Sender: TObject);
begin
//
end;

procedure TFrame2.btnGuardarClick(Sender: TObject);
begin
//
end;

procedure TFrame2.btnEliminarClick(Sender: TObject);
begin
//
end;

procedure TFrame2.btnCancelarClick(Sender: TObject);
begin
//
end;

end.
