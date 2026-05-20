unit uFrmClientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids;

type
  TFrame3 = class(TFrame)
    pnlSuperior: TPanel;
    lblTitulo: TLabel;
    pnlBotones: TPanel;
    btnNuevo: TButton;
    btnGuardar: TButton;
    btnEliminar: TButton;
    btnCancelar: TButton;
    pnlFormulario: TPanel;
    lblNombre: TLabel;
    lblEmail: TLabel;
    lblTelefono: TLabel;
    edtNombre: TEdit;
    edtEmail: TEdit;
    edtTelefono: TEdit;
    grdClientes: TStringGrid;
    procedure grdClientesClick(Sender: TObject);
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

procedure TFrame3.grdClientesClick(Sender: TObject);
begin
//
end;

procedure TFrame3.btnNuevoClick(Sender: TObject);
begin
//
end;

procedure TFrame3.btnGuardarClick(Sender: TObject);
begin
//
end;

procedure TFrame3.btnEliminarClick(Sender: TObject);
begin
//
end;

procedure TFrame3.btnCancelarClick(Sender: TObject);
begin
//
end;

end.
