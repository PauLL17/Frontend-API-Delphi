unit uFrmUsuarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  REST.Types, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Vcl.DBCtrls, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, System.JSON, Vcl.Buttons;

type
  TuFrmUsuarios = class(TFrame)
    pnlSuperior: TPanel;
    lblTitulo: TLabel;
    Panel1: TPanel;
    DBNavigator1: TDBNavigator;
    DBGrid1: TDBGrid;
    FDMemTable1: TFDMemTable;
    DataSource1: TDataSource;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    pnlFormulario: TPanel;
    lblUsername: TLabel;
    DBEdtUsername: TDBEdit;
    lblRol: TLabel;
    DBComboRol: TDBComboBox;
    lblFechaRegistro: TLabel;
    DBEdtFechaRegistro: TDBEdit;
    procedure FDMemTable1BeforeEdit(DataSet: TDataSet);
    procedure FDMemTable1AfterPost(DataSet: TDataSet);
    procedure FDMemTable1BeforeDelete(DataSet: TDataSet);
    procedure FDMemTable1AfterRefresh(DataSet: TDataSet);
  private
    FToken: string;
    sOrigRol: string;
    procedure CargarDatos;
    procedure FechaGetText(Sender: TField; var Text: string; DisplayText: Boolean);
  public
    constructor Create(AOwner: TComponent); override;
    property Token: string read FToken write FToken;
  end;

implementation

{$R *.dfm}

uses
  uAPI;  // Aquí se define sTokenJWT

// -----------------------------------------------------------------
// Parsea cadenas con formato "YYYY-MM-DD" a TDateTime
// -----------------------------------------------------------------
function TryParseYYYYMMDD(const FechaStr: string; out Fecha: TDateTime): Boolean;
var
  s: string;
  anio, mes, dia: Integer;
begin
  Result := False;
  s := Trim(FechaStr);
  if (s = '') or (s = 'null') then Exit;
  if Length(s) >= 10 then
    s := Copy(s, 1, 10)   // Trunca si viene con hora
  else
    Exit;

  if (s[5] = '-') and (s[8] = '-') then
  begin
    anio := StrToIntDef(Copy(s, 1, 4), 0);
    mes  := StrToIntDef(Copy(s, 6, 2), 0);
    dia  := StrToIntDef(Copy(s, 9, 2), 0);
    if (anio >= 1) and (anio <= 9999) and (mes in [1..12]) and (dia in [1..31]) then
      Result := TryEncodeDate(anio, mes, dia, Fecha);
  end;
end;

constructor TuFrmUsuarios.Create(AOwner: TComponent);
var
  fId      : TIntegerField;
  fUsername: TStringField;
  fRol     : TStringField;
  fFecha   : TDateTimeField;
begin
  inherited Create(AOwner);

  // Definir campos de la memoria
  fId := TIntegerField.Create(FDMemTable1);
  fId.FieldName := 'id_usuario';
  fId.DataSet   := FDMemTable1;

  fUsername := TStringField.Create(FDMemTable1);
  fUsername.FieldName := 'username';
  fUsername.Size      := 100;
  fUsername.DataSet   := FDMemTable1;

  fRol := TStringField.Create(FDMemTable1);
  fRol.FieldName := 'rol';
  fRol.Size      := 20;
  fRol.DataSet   := FDMemTable1;

  fFecha := TDateTimeField.Create(FDMemTable1);
  fFecha.FieldName := 'fecha_registro';
  fFecha.DataSet   := FDMemTable1;
  fFecha.OnGetText := FechaGetText;  // Formatea la visualización

  FDMemTable1.CreateDataSet;

  // Configurar el combobox de roles
  DBComboRol.Items.Clear;
  DBComboRol.Items.Add('admin');
  DBComboRol.Items.Add('usuario');
  DBComboRol.Items.Add('empleado');
  DBComboRol.Items.Add('gerente');

  // *** CAMBIO IMPORTANTE: Incluir nbPost para que aparezca el tick ***
  DBNavigator1.VisibleButtons := [nbEdit, nbPost, nbCancel, nbDelete, nbRefresh];

  CargarDatos;
end;

procedure TuFrmUsuarios.CargarDatos;
var
  jArray: TJSONArray;
  jObj  : TJSONObject;
  i     : Integer;
  fechaStr: string;
  fechaVal: TDateTime;
begin
  RESTRequest1.Params.Clear;
  RESTRequest1.Method   := rmGET;
  RESTRequest1.Resource := 'Usuarios';
  RESTRequest1.AddParameter('Authorization', 'Bearer ' + sTokenJWT,
                            pkHTTPHEADER, [poDoNotEncode]);
  RESTRequest1.Execute;

  if RESTResponse1.StatusCode <> 200 then
  begin
    ShowMessage('Error al cargar usuarios: ' + RESTResponse1.Content);
    Exit;
  end;

  FDMemTable1.DisableControls;
  FDMemTable1.AfterPost := nil;
  try
    FDMemTable1.EmptyDataSet;
    jArray := RESTResponse1.JSONValue as TJSONArray;
    if not Assigned(jArray) then Exit;

    for i := 0 to jArray.Count - 1 do
    begin
      jObj := jArray.Items[i] as TJSONObject;
      FDMemTable1.Append;
      FDMemTable1.FieldByName('id_usuario').AsInteger :=
        StrToIntDef(jObj.GetValue<string>('id_usuario'), 0);
      FDMemTable1.FieldByName('username').AsString :=
        jObj.GetValue<string>('username');
      FDMemTable1.FieldByName('rol').AsString :=
        jObj.GetValue<string>('rol');

      fechaStr := jObj.GetValue<string>('fecha_registro');
      if TryParseYYYYMMDD(fechaStr, fechaVal) then
        FDMemTable1.FieldByName('fecha_registro').AsDateTime := fechaVal
      else
        FDMemTable1.FieldByName('fecha_registro').Clear;

      FDMemTable1.Post;
    end;

    if FDMemTable1.RecordCount > 0 then
      FDMemTable1.First;
  finally
    FDMemTable1.AfterPost := FDMemTable1AfterPost;
    FDMemTable1.EnableControls;
  end;
end;

// Muestra la fecha en formato dd/mm/aaaa (si no es nula)
procedure TuFrmUsuarios.FechaGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if not Sender.IsNull then
    Text := FormatDateTime('dd/mm/yyyy', Sender.AsDateTime)
  else
    Text := '';
end;

procedure TuFrmUsuarios.FDMemTable1BeforeEdit(DataSet: TDataSet);
begin
  sOrigRol := DataSet.FieldByName('rol').AsString;
end;

procedure TuFrmUsuarios.FDMemTable1AfterPost(DataSet: TDataSet);
var
  jDatos: TJSONObject;
  nID   : Integer;
begin
  nID := DataSet.FieldByName('id_usuario').AsInteger;

  if nID = 0 then
  begin
    ShowMessage('No se pueden crear nuevos usuarios desde esta interfaz.');
    CargarDatos;
    Exit;
  end;

  if DataSet.FieldByName('rol').AsString <> sOrigRol then
  begin
    jDatos := TJSONObject.Create;
    try
      jDatos.AddPair('rol', DataSet.FieldByName('rol').AsString);

      RESTRequest1.Params.Clear;
      RESTRequest1.ClearBody;
      RESTRequest1.AddParameter('Authorization', 'Bearer ' + sTokenJWT,
                                pkHTTPHEADER, [poDoNotEncode]);
      RESTRequest1.AddBody(jDatos.ToJSON, TRESTContentType.ctAPPLICATION_JSON);
      RESTRequest1.Method   := rmPATCH;
      RESTRequest1.Resource := 'Usuarios/' + IntToStr(nID);
      RESTRequest1.Execute;

      if RESTResponse1.StatusCode = 200 then
        ShowMessage('Rol actualizado correctamente.')
      else
        ShowMessage('Error al actualizar: ' + RESTResponse1.Content);
    finally
      jDatos.Free;
    end;
  end;
end;

procedure TuFrmUsuarios.FDMemTable1BeforeDelete(DataSet: TDataSet);
var
  nID: Integer;
begin
  nID := DataSet.FieldByName('id_usuario').AsInteger;
  if nID = 0 then
  begin
    Abort;
    Exit;
  end;

  if MessageDlg('¿Seguro que quieres eliminar este usuario?',
                mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
  begin
    Abort;
    Exit;
  end;

  RESTRequest1.Params.Clear;
  RESTRequest1.Method   := rmDELETE;
  RESTRequest1.Resource := 'Usuarios/' + IntToStr(nID);
  RESTRequest1.AddParameter('Authorization', 'Bearer ' + sTokenJWT,
                            pkHTTPHEADER, [poDoNotEncode]);
  RESTRequest1.Execute;

  if RESTResponse1.StatusCode = 200 then
    ShowMessage('Usuario eliminado correctamente.')
  else
  begin
    ShowMessage('Error al eliminar: ' + RESTResponse1.Content);
    Abort;
  end;
end;

procedure TuFrmUsuarios.FDMemTable1AfterRefresh(DataSet: TDataSet);
begin
  CargarDatos;
end;

end.
