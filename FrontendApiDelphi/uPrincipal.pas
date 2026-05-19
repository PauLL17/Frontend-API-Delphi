unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfPrincipal = class(TForm)
    pnlSuperior: TPanel;
    lblBienvenido: TLabel;
    pnlLateral: TPanel;
    btnPeliculas: TButton;
    btnSalas: TButton;
    btnClientes: TButton;
    btnSesiones: TButton;
    btnEntradas: TButton;
    btnSalir: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnPeliculasClick(Sender: TObject);
    procedure btnSalasClick(Sender: TObject);
    procedure btnClientesClick(Sender: TObject);
    procedure btnSesionesClick(Sender: TObject);
    procedure btnEntradasClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fPrincipal: TfPrincipal;

implementation

uses
  uLogin, uAPI;

{$R *.dfm}

procedure TfPrincipal.FormCreate(Sender: TObject);
begin
  { FormCreate de fPrincipal
    - Muestra fLogin como ventana modal antes de mostrar el principal
    - Si login correcto (mrOk): muestra bienvenida con usuario y rol
    - Si se cancela o falla: termina la aplicación }
  fLogin := TfLogin.Create(Application);
  try
    if fLogin.ShowModal = mrOk then
      lblBienvenido.Caption := 'Bienvenido, ' + sNombreUsuario +
                               '  |  Rol: ' + sRolUsuario
    else
      Application.Terminate;
  finally
    fLogin.Free;
  end;
end;

procedure TfPrincipal.btnPeliculasClick(Sender: TObject);
begin
  { TODO: abrir fPeliculas como MDI child }
end;

procedure TfPrincipal.btnSalasClick(Sender: TObject);
begin
  { TODO: abrir fSalas como MDI child }
end;

procedure TfPrincipal.btnClientesClick(Sender: TObject);
begin
  { TODO: abrir fClientes como MDI child }
end;

procedure TfPrincipal.btnSesionesClick(Sender: TObject);
begin
  { TODO: abrir fSesiones como MDI child }
end;

procedure TfPrincipal.btnEntradasClick(Sender: TObject);
begin
  { TODO: abrir fEntradas como MDI child }
end;

procedure TfPrincipal.btnSalirClick(Sender: TObject);
begin
  { Botón Salir - pide confirmación y cierra la aplicación }
  if MessageDlg('¿Seguro que quieres salir?',
                mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    Application.Terminate;
end;

end.
