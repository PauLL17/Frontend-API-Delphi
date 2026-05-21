unit uLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, REST.Client, REST.Types, System.JSON,
  Data.Bind.Components, Data.Bind.ObjectScope;

type
  TfLogin = class(TForm)
    pnlTitulo: TPanel;
    lblUsuario: TLabel;
    lblClave: TLabel;
    edtUsuario: TEdit;
    edtClave: TEdit;
    btnAceptar: TButton;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
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

{ Botón Aceptar del login
    - Valida campos no vacíos
    - Construye el JSON con las credenciales
    - Llama a POST /Login con RESTRequest
    - Si 200: guarda token, rol y usuario en uAPI y cierra con mrOk
    - Si error: muestra el mensaje devuelto por la API }
procedure TfLogin.btnAceptarClick(Sender: TObject);
var
  jBody   : TJSONObject;
  jResp   : TJSONObject;
  sMensaje: string;
begin
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
    { Construir el body JSON }
    jBody := TJSONObject.Create;
    try
      jBody.AddPair('username', edtUsuario.Text);
      jBody.AddPair('password', edtClave.Text);

      RESTRequest1.ClearBody;
      RESTRequest1.AddBody(jBody.ToJSON, TRESTContentType.ctAPPLICATION_JSON);
    finally
      jBody.Free;
    end;

    { Ejecutar la petición }
    RESTRequest1.Execute;

    if RESTResponse1.StatusCode = 200 then
    begin
      jResp := RESTResponse1.JSONValue as TJSONObject;
      if Assigned(jResp) then
      begin
        sTokenJWT     := jResp.GetValue<string>('token');
        sNombreUsuario := jResp.GetValue<TJSONObject>('user').GetValue<string>('username');
        sRolUsuario   := jResp.GetValue<TJSONObject>('user').GetValue<string>('role');
      end;
      ShowMessage('Bienvenido, ' + sNombreUsuario + ' (' + sRolUsuario + ')');
      ModalResult := mrOk;
    end
    else
    begin
      jResp := RESTResponse1.JSONValue as TJSONObject;
      if Assigned(jResp) then
        sMensaje := jResp.GetValue<string>('message')
      else
        sMensaje := RESTResponse1.Content;
      ShowMessage('Error al iniciar sesión: ' + sMensaje);
    end;

  except
    on E: Exception do
      ShowMessage('Error de conexión: ' + E.Message);
  end;

  btnAceptar.Enabled := True;
end;

end.
