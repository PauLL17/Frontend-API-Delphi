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

uses
  uAPI;

{$R *.dfm}

procedure TfLogin.btnAceptarClick(Sender: TObject);
var
  sMensaje: string;
begin
  { Botón Aceptar del login
    - Valida campos no vacíos
    - Llama a LoginAPI con las credenciales
    - Si OK: muestra bienvenida y cierra el modal con mrOk
    - Si error: muestra el mensaje devuelto por la API }
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

  btnAceptar.Enabled := False;
  try
    if LoginAPI(edtUsuario.Text, edtClave.Text, sMensaje) then
    begin
      ShowMessage('Bienvenido, ' + sNombreUsuario + ' (' + sRolUsuario + ')');
      ModalResult := mrOk;
    end
    else
      ShowMessage('Error al iniciar sesión: ' + sMensaje);
  finally
    btnAceptar.Enabled := True;
  end;
end;

end.
