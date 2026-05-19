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
  // Validar campos vacíos
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

  // Deshabilitar botón para evitar doble llamada
  btnAceptar.Enabled := False;
  try
    // Intentar login
    if LoginAPI(edtUsuario.Text, edtClave.Text, sMensaje) then
    begin
      // Mostrar mensaje de bienvenida
      ShowMessage('Login correcto. Bienvenido, ' + sNombreUsuario + ' (' +
        sRolUsuario + ')');

      // Cerrar el formulario con resultado OK
      ModalResult := mrOk;
      Close;
    end
    else
    begin
      // Mostrar error
      ShowMessage('Error al iniciar sesión: ' + sMensaje);
    end;
  finally
    btnAceptar.Enabled := True;
  end;
end;

end.
