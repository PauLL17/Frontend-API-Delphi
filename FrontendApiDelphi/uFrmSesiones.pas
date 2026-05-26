unit uFrmSesiones;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.DBGrids, Vcl.Mask,
  Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  REST.Client, REST.Types, System.JSON, Data.Bind.Components,
  Data.Bind.ObjectScope, Vcl.Grids, Vcl.Buttons;

type
  TFrame4 = class(TFrame)
    pnlSuperior: TPanel;
    lblTitulo: TLabel;
    Panel1: TPanel;
    DBNavigator1: TDBNavigator;
    pnlFormulario: TPanel;
    lblIdPelicula: TLabel;
    lblIdSala: TLabel;
    lblFechaHora: TLabel;
    DBEdtIdPelicula: TDBEdit;
    DBEdtIdSala: TDBEdit;
    DBEdtFechaHora: TDBEdit;
    DBGrid1: TDBGrid;
    FDMemTable1: TFDMemTable;
    DataSource1: TDataSource;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    procedure FDMemTable1AfterPost(DataSet: TDataSet);
    procedure FDMemTable1BeforeDelete(DataSet: TDataSet);
  private
    nOrigPelicula : Integer;
    nOrigSala     : Integer;
    sOrigFecha    : string;
    procedure CargarDatos;
    procedure FDMemTable1BeforeEdit(DataSet: TDataSet);
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses
  uAPI;

{$R *.dfm}

constructor TFrame4.Create(AOwner: TComponent);
var
  fId        : TIntegerField;
  fPelicula  : TIntegerField;
  fSala      : TIntegerField;
  fFechaHora : TStringField;
begin
  inherited Create(AOwner);

  fId := TIntegerField.Create(FDMemTable1);
  fId.FieldName := 'id_sesion';
  fId.DataSet   := FDMemTable1;

  fPelicula := TIntegerField.Create(FDMemTable1);
  fPelicula.FieldName := 'id_pelicula';
  fPelicula.DataSet   := FDMemTable1;

  fSala := TIntegerField.Create(FDMemTable1);
  fSala.FieldName := 'id_sala';
  fSala.DataSet   := FDMemTable1;

  fFechaHora := TStringField.Create(FDMemTable1);
  fFechaHora.FieldName := 'fecha_hora';
  fFechaHora.Size      := 30;
  fFechaHora.DataSet   := FDMemTable1;

  FDMemTable1.CreateDataSet;
  FDMemTable1.BeforeEdit := FDMemTable1BeforeEdit;
  CargarDatos;
end;

procedure TFrame4.CargarDatos;
var
  jArray : TJSONArray;
  jObj   : TJSONObject;
  i      : Integer;
begin
  RESTRequest1.Params.Clear;
  RESTRequest1.Method   := rmGET;
  RESTRequest1.Resource := 'Sesiones';
  RESTRequest1.AddParameter('Authorization', 'Bearer ' + sTokenJWT,
                             pkHTTPHEADER, [poDoNotEncode]);
  RESTRequest1.Execute;

  if RESTResponse1.StatusCode <> 200 then
  begin
    ShowMessage('Error al cargar sesiones: ' + RESTResponse1.Content);
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
      FDMemTable1.FieldByName('id_sesion').AsInteger :=
        StrToIntDef(jObj.GetValue<string>('id_sesion'), 0);
      FDMemTable1.FieldByName('id_pelicula').AsInteger :=
        StrToIntDef(jObj.GetValue<string>('id_pelicula'), 0);
      FDMemTable1.FieldByName('id_sala').AsInteger :=
        StrToIntDef(jObj.GetValue<string>('id_sala'), 0);
      FDMemTable1.FieldByName('fecha_hora').AsString :=
        jObj.GetValue<string>('fecha_hora');
      FDMemTable1.Post;
    end;

    if FDMemTable1.RecordCount > 0 then
      FDMemTable1.First;
  finally
    FDMemTable1.AfterPost := FDMemTable1AfterPost;
    FDMemTable1.EnableControls;
  end;
end;

procedure TFrame4.FDMemTable1BeforeEdit(DataSet: TDataSet);
begin
  nOrigPelicula := DataSet.FieldByName('id_pelicula').AsInteger;
  nOrigSala     := DataSet.FieldByName('id_sala').AsInteger;
  sOrigFecha    := DataSet.FieldByName('fecha_hora').AsString;
end;

procedure TFrame4.FDMemTable1AfterPost(DataSet: TDataSet);
var
  jDatos : TJSONObject;
  nID    : Integer;
begin
  nID    := DataSet.FieldByName('id_sesion').AsInteger;
  jDatos := TJSONObject.Create;
  try
    if nID = 0 then
    begin
      jDatos.AddPair('id_pelicula', DataSet.FieldByName('id_pelicula').AsString);
      jDatos.AddPair('id_sala',     DataSet.FieldByName('id_sala').AsString);
      jDatos.AddPair('fecha_hora',  DataSet.FieldByName('fecha_hora').AsString);

      RESTRequest1.Params.Clear;
      RESTRequest1.ClearBody;
      RESTRequest1.AddParameter('Authorization', 'Bearer ' + sTokenJWT,
                                 pkHTTPHEADER, [poDoNotEncode]);
      RESTRequest1.AddBody(jDatos.ToJSON, TRESTContentType.ctAPPLICATION_JSON);
      RESTRequest1.Method   := rmPOST;
      RESTRequest1.Resource := 'Sesiones';
      RESTRequest1.Execute;

      if RESTResponse1.StatusCode in [200, 201] then
      begin
        ShowMessage('Sesión creada correctamente.');
        CargarDatos;
      end
      else
        ShowMessage('Error al crear: ' + RESTResponse1.Content);
    end
    else
    begin
      if DataSet.FieldByName('id_pelicula').AsInteger <> nOrigPelicula then
        jDatos.AddPair('id_pelicula', DataSet.FieldByName('id_pelicula').AsString);
      if DataSet.FieldByName('id_sala').AsInteger <> nOrigSala then
        jDatos.AddPair('id_sala', DataSet.FieldByName('id_sala').AsString);
      if DataSet.FieldByName('fecha_hora').AsString <> sOrigFecha then
        jDatos.AddPair('fecha_hora', DataSet.FieldByName('fecha_hora').AsString);

      if jDatos.Count > 0 then
      begin
        RESTRequest1.Params.Clear;
        RESTRequest1.ClearBody;
        RESTRequest1.AddParameter('Authorization', 'Bearer ' + sTokenJWT,
                                   pkHTTPHEADER, [poDoNotEncode]);
        RESTRequest1.AddBody(jDatos.ToJSON, TRESTContentType.ctAPPLICATION_JSON);
        RESTRequest1.Method   := rmPATCH;
        RESTRequest1.Resource := 'Sesiones/' + IntToStr(nID);
        RESTRequest1.Execute;

        if RESTResponse1.StatusCode in [200, 201] then
          ShowMessage('Sesión actualizada correctamente.')
        else
          ShowMessage('Error al actualizar: ' + RESTResponse1.Content);
      end;
    end;
  finally
    jDatos.Free;
  end;
end;

procedure TFrame4.FDMemTable1BeforeDelete(DataSet: TDataSet);
var
  nID: Integer;
begin
  nID := DataSet.FieldByName('id_sesion').AsInteger;

  if nID = 0 then
  begin
    Abort;
    Exit;
  end;

  if MessageDlg('¿Seguro que quieres eliminar esta sesión?',
                mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
  begin
    Abort;
    Exit;
  end;

  RESTRequest1.Params.Clear;
  RESTRequest1.Method   := rmDELETE;
  RESTRequest1.Resource := 'Sesiones/' + IntToStr(nID);
  RESTRequest1.AddParameter('Authorization', 'Bearer ' + sTokenJWT,
                             pkHTTPHEADER, [poDoNotEncode]);
  RESTRequest1.Execute;

  if not (RESTResponse1.StatusCode in [200, 204]) then
  begin
    ShowMessage('Error al eliminar: ' + RESTResponse1.Content);
    Abort;
  end
  else
    ShowMessage('Sesión eliminada correctamente.');
end;

end.
