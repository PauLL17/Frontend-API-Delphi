unit uLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  REST.Client, REST.Types, System.JSON, Data.Bind.Components,
  Data.Bind.ObjectScope;

type
  TfLogin = class(TForm)
    pnlTitulo: TPanel;
    pgcLogin: TPageControl;
    tabLogin: TTabSheet;
    lblUsuario: TLabel;
    lblClave: TLabel;
    edtUsuario: TEdit;
    edtClave: TEdit;
    btnAceptar: TButton;
    tabRegistro: TTabSheet;
    lblRegUsuario: TLabel;
    lblRegClave: TLabel;
    edtRegUsuario: TEdit;
    edtRegClave: TEdit;
    btnRegistrarse: TButton;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnRegistrarseClick(Sender: TObject);
    procedure pgcLoginChange(Sender: TObject);
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

procedure TfLogin.pgcLoginChange(Sender: TObject);
begin
  if pgcLogin.ActivePage = tabLogin then
    pnlTitulo.Caption := 'Iniciar Sesión'
  else
    pnlTitulo.Caption := 'Registro';
end;

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
    jBody := TJSONObject.Create;
    try
      jBody.AddPair('username', edtUsuario.Text);
      jBody.AddPair('password', edtClave.Text);
      RESTRequest1.Params.Clear;
      RESTRequest1.ClearBody;
      RESTRequest1.Method   := rmPOST;
      RESTRequest1.Resource := 'Login';
      RESTRequest1.AddBody(jBody.ToJSON, TRESTContentType.ctAPPLICATION_JSON);
    finally
      jBody.Free;
    end;

    RESTRequest1.Execute;

    if RESTResponse1.StatusCode = 200 then
    begin
      jResp := RESTResponse1.JSONValue as TJSONObject;
      if Assigned(jResp) then
      begin
        sTokenJWT      := jResp.GetValue<string>('token');
        sNombreUsuario := jResp.GetValue<TJSONObject>('user').GetValue<string>('username');
        sRolUsuario    := jResp.GetValue<TJSONObject>('user').GetValue<string>('role');
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
      ShowMessage('Error al iniciar sesion: ' + sMensaje);
    end;
  except
    on E: Exception do
      ShowMessage('Error de conexión: ' + E.Message);
  end;

  btnAceptar.Enabled := True;
end;

procedure TfLogin.btnRegistrarseClick(Sender: TObject);
var
  jBody   : TJSONObject;
  jResp   : TJSONObject;
  sMensaje: string;
begin
  if Trim(edtRegUsuario.Text) = '' then
  begin
    ShowMessage('Introduce un nombre de usuario.');
    edtRegUsuario.SetFocus;
    Exit;
  end;

  if Trim(edtRegClave.Text) = '' then
  begin
    ShowMessage('Introduce una clave.');
    edtRegClave.SetFocus;
    Exit;
  end;

  btnRegistrarse.Enabled := False;
  try
    jBody := TJSONObject.Create;
    try
      jBody.AddPair('username', edtRegUsuario.Text);
      jBody.AddPair('password', edtRegClave.Text);
      jBody.AddPair('rol',      'usuario');
      RESTRequest1.Params.Clear;
      RESTRequest1.ClearBody;
      RESTRequest1.Method   := rmPOST;
      RESTRequest1.Resource := 'Registro';
      RESTRequest1.AddBody(jBody.ToJSON, TRESTContentType.ctAPPLICATION_JSON);
    finally
      jBody.Free;
    end;

    RESTRequest1.Execute;

    if RESTResponse1.StatusCode in [200, 201] then
    begin
      ShowMessage('Usuario registrado correctamente. Ya puedes iniciar sesion.');
      edtRegUsuario.Text := '';
      edtRegClave.Text := '';
      pgcLogin.ActivePage := tabLogin;
    end
    else
    begin
      jResp := RESTResponse1.JSONValue as TJSONObject;
      if Assigned(jResp) then
        sMensaje := jResp.GetValue<string>('mensaje')
      else
        sMensaje := RESTResponse1.Content;
      ShowMessage('Error al registrar: ' + sMensaje);
    end;
  except
    on E: Exception do
      ShowMessage('Error de conexión: ' + E.Message);
  end;

  btnRegistrarse.Enabled := True;
end;

end.
