unit uLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfLogin = class(TForm)
    pnlTitulo: TPanel;
    lblUsuario: TLabel;
    lblClave: TLabel;
    edtUsuario: TEdit;
    edtClave: TEdit;
    btnAceptar: TButton;
    procedure btnAceptarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fLogin: TfLogin;

implementation

{$R *.dfm}

procedure TfLogin.btnAceptarClick(Sender: TObject);
begin
  { Botón Aceptar del formulario de login
    - Valida que los campos no estén vacíos
    - llamar a uAPI (POST /login) cuando esté implementada
    - si login OK, abrir fPrincipal y cerrar este form }
  if Trim(edtUsuario.Text) = '' then
  begin
    ShowMessage('Introduce un nombre de usuario.');
    edtUsuario.SetFocus;
    Exit;
  end;

  if Trim(edtClave.Text) = '' then
  begin
    ShowMessage('Introduce la clave.');
    edtClave.SetFocus;
    Exit;
  end;

  ShowMessage('Login pendiente de implementar (uAPI).');
end;

end.
