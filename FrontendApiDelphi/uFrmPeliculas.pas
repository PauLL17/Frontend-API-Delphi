unit uFrmPeliculas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids;

type
  TFrame1 = class(TFrame)
    pnlSuperior: TPanel;
    lblTitulo: TLabel;
    pnlBotones: TPanel;
    btnNuevo: TButton;
    btnGuardar: TButton;
    btnEliminar: TButton;
    btnCancelar: TButton;
    pnlFormulario: TPanel;
    lblTituloF: TLabel;
    lblDuracion: TLabel;
    lblGenero: TLabel;
    edtTitulo: TEdit;
    edtDuracion: TEdit;
    edtGenero: TEdit;
    grdPeliculas: TStringGrid;
    procedure grdPeliculasClick(Sender: TObject);
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

procedure TFrame1.grdPeliculasClick(Sender: TObject);
begin
//
end;

procedure TFrame1.btnNuevoClick(Sender: TObject);
begin
//
end;

procedure TFrame1.btnGuardarClick(Sender: TObject);
begin
//
end;

procedure TFrame1.btnEliminarClick(Sender: TObject);
begin
//
end;

procedure TFrame1.btnCancelarClick(Sender: TObject);
begin
//
end;

end.
