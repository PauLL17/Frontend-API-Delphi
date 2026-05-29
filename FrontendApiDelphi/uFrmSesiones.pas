unit uFrmSesiones;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.DBGrids, Vcl.Mask,
  Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Intf,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  REST.Client, REST.Types, System.JSON,
  Vcl.ComCtrls, System.DateUtils, System.Generics.Collections,
  FireDAC.Stan.Option, Data.Bind.Components, Data.Bind.ObjectScope, Vcl.Grids,
  Vcl.Buttons;

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
    dtpFecha: TDateTimePicker;
    dtpHora: TDateTimePicker;
    DBGrid1: TDBGrid;
    FDMemTable1: TFDMemTable;
    DataSource1: TDataSource;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    procedure FDMemTable1AfterPost(DataSet: TDataSet);
    procedure FDMemTable1BeforeDelete(DataSet: TDataSet);
    procedure FDMemTable1AfterRefresh(DataSet: TDataSet);
    procedure FDMemTable1BeforeEdit(DataSet: TDataSet);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure dtpFechaChange(Sender: TObject);
    procedure dtpHoraChange(Sender: TObject);
    procedure FDMemTable1AfterInsert(DataSet: TDataSet);
    procedure FDMemTable1BeforePost(DataSet: TDataSet);
  private
    nOrigPelicula    : Integer;
    nOrigSala        : Integer;
    sOrigFecha       : string;
    FUpdatingControls: Boolean;
    procedure CargarDatos;
    procedure CargarDiccionarios(out DictPeliculas, DictSalas: TDictionary<Integer, string>);
    procedure ActualizarDateTimePickers;
    procedure GuardarFechaEnDataset;
    function TryISO8601ToDateTime(const s: string; out dt: TDateTime): Boolean;
    function DateTimeToISO8601(dt: TDateTime): string;
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses
  uAPI;

{$R *.dfm}

constructor TFrame4.Create(AOwner: TComponent);
var
  fId             : TIntegerField;
  fPelicula       : TIntegerField;
  fSala           : TIntegerField;
  fFechaHora      : TStringField;
  fTituloPelicula : TStringField;
  fNombreSala     : TStringField;
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

  fTituloPelicula := TStringField.Create(FDMemTable1);
  fTituloPelicula.FieldName := 'titulo_pelicula';
  fTituloPelicula.Size      := 50;
  fTituloPelicula.DataSet   := FDMemTable1;

  fNombreSala := TStringField.Create(FDMemTable1);
  fNombreSala.FieldName := 'nombre_sala';
  fNombreSala.Size      := 50;
  fNombreSala.DataSet   := FDMemTable1;

  FDMemTable1.CreateDataSet;

  dtpFecha.Kind  := dtkDate;
  dtpHora.Kind   := dtkTime;
  dtpHora.Format := 'HH:mm:ss';

  FUpdatingControls := False;

  FDMemTable1.BeforeEdit   := FDMemTable1BeforeEdit;
  FDMemTable1.BeforePost   := FDMemTable1BeforePost;
  FDMemTable1.AfterInsert  := FDMemTable1AfterInsert;
  DataSource1.OnDataChange := DataSource1DataChange;

  CargarDatos;
end;

procedure TFrame4.CargarDiccionarios(out DictPeliculas, DictSalas: TDictionary<Integer, string>);
var
  jArray : TJSONArray;
  jObj   : TJSONObject;
  i      : Integer;
begin
  DictPeliculas := TDictionary<Integer, string>.Create;
  DictSalas     := TDictionary<Integer, string>.Create;

  RESTRequest1.Params.Clear;
  RESTRequest1.Method   := rmGET;
  RESTRequest1.Resource := 'Peliculas';
  RESTRequest1.AddParameter('Authorization', 'Bearer ' + sTokenJWT,
                             pkHTTPHEADER, [poDoNotEncode]);
  RESTRequest1.Execute;
  if RESTResponse1.StatusCode = 200 then
  begin
    jArray := RESTResponse1.JSONValue as TJSONArray;
    if Assigned(jArray) then
      for i := 0 to jArray.Count - 1 do
      begin
        jObj := jArray.Items[i] as TJSONObject;
        DictPeliculas.AddOrSetValue(
          StrToIntDef(jObj.GetValue<string>('id_pelicula'), 0),
          jObj.GetValue<string>('titulo'));
      end;
  end;

  RESTRequest1.Params.Clear;
  RESTRequest1.Method   := rmGET;
  RESTRequest1.Resource := 'Salas';
  RESTRequest1.AddParameter('Authorization', 'Bearer ' + sTokenJWT,
                             pkHTTPHEADER, [poDoNotEncode]);
  RESTRequest1.Execute;
  if RESTResponse1.StatusCode = 200 then
  begin
    jArray := RESTResponse1.JSONValue as TJSONArray;
    if Assigned(jArray) then
      for i := 0 to jArray.Count - 1 do
      begin
        jObj := jArray.Items[i] as TJSONObject;
        DictSalas.AddOrSetValue(
          StrToIntDef(jObj.GetValue<string>('id_sala'), 0),
          jObj.GetValue<string>('nombre'));
      end;
  end;
end;

procedure TFrame4.CargarDatos;
var
  jArray        : TJSONArray;
  jObj          : TJSONObject;
  i             : Integer;
  DictPeliculas : TDictionary<Integer, string>;
  DictSalas     : TDictionary<Integer, string>;
  sTitulo       : string;
  sNombreSala   : string;
  nIdPelicula   : Integer;
  nIdSala       : Integer;
begin
  CargarDiccionarios(DictPeliculas, DictSalas);
  try
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
        jObj        := jArray.Items[i] as TJSONObject;
        nIdPelicula := StrToIntDef(jObj.GetValue<string>('id_pelicula'), 0);
        nIdSala     := StrToIntDef(jObj.GetValue<string>('id_sala'), 0);

        if not DictPeliculas.TryGetValue(nIdPelicula, sTitulo) then
          sTitulo := '';
        if not DictSalas.TryGetValue(nIdSala, sNombreSala) then
          sNombreSala := '';

        FDMemTable1.Append;
        FDMemTable1.FieldByName('id_sesion').AsInteger   := StrToIntDef(jObj.GetValue<string>('id_sesion'), 0);
        FDMemTable1.FieldByName('id_pelicula').AsInteger := nIdPelicula;
        FDMemTable1.FieldByName('id_sala').AsInteger     := nIdSala;
        FDMemTable1.FieldByName('fecha_hora').AsString   := jObj.GetValue<string>('fecha_hora');
        FDMemTable1.FieldByName('titulo_pelicula').AsString := sTitulo;
        FDMemTable1.FieldByName('nombre_sala').AsString     := sNombreSala;
        FDMemTable1.Post;
      end;

      if FDMemTable1.RecordCount > 0 then
        FDMemTable1.First;
    finally
      FDMemTable1.AfterPost := FDMemTable1AfterPost;
      FDMemTable1.EnableControls;
    end;

    DataSource1DataChange(nil, nil);
  finally
    DictPeliculas.Free;
    DictSalas.Free;
  end;
end;

function TFrame4.TryISO8601ToDateTime(const s: string; out dt: TDateTime): Boolean;
var
  y, m, d, h, n, sec: Word;
  sDate, sTime: string;
begin
  Result := False;
  if Length(s) >= 19 then
  begin
    sDate := Copy(s, 1, 10);
    sTime := Copy(s, 12, 8);
    y   := StrToIntDef(Copy(sDate, 1, 4), 0);
    m   := StrToIntDef(Copy(sDate, 6, 2), 0);
    d   := StrToIntDef(Copy(sDate, 9, 2), 0);
    h   := StrToIntDef(Copy(sTime, 1, 2), 0);
    n   := StrToIntDef(Copy(sTime, 4, 2), 0);
    sec := StrToIntDef(Copy(sTime, 7, 2), 0);
    if (y > 0) and (m > 0) and (d > 0) then
    begin
      dt     := EncodeDateTime(y, m, d, h, n, sec, 0);
      Result := True;
    end;
  end;
end;

function TFrame4.DateTimeToISO8601(dt: TDateTime): string;
begin
  Result := FormatDateTime('yyyy-mm-dd HH:nn:ss', dt);
end;

procedure TFrame4.ActualizarDateTimePickers;
var
  sFecha: string;
  dt    : TDateTime;
begin
  if FUpdatingControls then Exit;
  if FDMemTable1.Active and not FDMemTable1.IsEmpty then
  begin
    sFecha := FDMemTable1.FieldByName('fecha_hora').AsString;
    if TryISO8601ToDateTime(sFecha, dt) then
    begin
      FUpdatingControls := True;
      try
        dtpFecha.Date := DateOf(dt);
        dtpHora.Time  := TimeOf(dt);
      finally
        FUpdatingControls := False;
      end;
    end;
  end;
end;

procedure TFrame4.GuardarFechaEnDataset;
var
  dt: TDateTime;
begin
  if not (FDMemTable1.State in [dsEdit, dsInsert]) then Exit;
  dt := DateOf(dtpFecha.Date) + TimeOf(dtpHora.Time);
  FDMemTable1.FieldByName('fecha_hora').AsString := DateTimeToISO8601(dt);
end;

procedure TFrame4.dtpFechaChange(Sender: TObject);
begin
  if FUpdatingControls then Exit;
  if not (FDMemTable1.State in [dsEdit, dsInsert]) then
    FDMemTable1.Edit;
  GuardarFechaEnDataset;
end;

procedure TFrame4.dtpHoraChange(Sender: TObject);
begin
  if FUpdatingControls then Exit;
  if not (FDMemTable1.State in [dsEdit, dsInsert]) then
    FDMemTable1.Edit;
  GuardarFechaEnDataset;
end;

procedure TFrame4.DataSource1DataChange(Sender: TObject; Field: TField);
begin
  if FDMemTable1.Active and not FDMemTable1.IsEmpty then
  begin
    nOrigPelicula := FDMemTable1.FieldByName('id_pelicula').AsInteger;
    nOrigSala     := FDMemTable1.FieldByName('id_sala').AsInteger;
    sOrigFecha    := FDMemTable1.FieldByName('fecha_hora').AsString;
  end;
  ActualizarDateTimePickers;
end;

procedure TFrame4.FDMemTable1BeforeEdit(DataSet: TDataSet);
begin
  nOrigPelicula := DataSet.FieldByName('id_pelicula').AsInteger;
  nOrigSala     := DataSet.FieldByName('id_sala').AsInteger;
  sOrigFecha    := DataSet.FieldByName('fecha_hora').AsString;
  ActualizarDateTimePickers;
end;

procedure TFrame4.FDMemTable1AfterInsert(DataSet: TDataSet);
begin
  dtpFecha.Date := Date;
  dtpHora.Time  := Time;
  GuardarFechaEnDataset;
end;

procedure TFrame4.FDMemTable1BeforePost(DataSet: TDataSet);
begin
  if DataSet.FieldByName('id_sesion').AsInteger = 0 then
    GuardarFechaEnDataset;
end;

procedure TFrame4.FDMemTable1AfterPost(DataSet: TDataSet);
var
  jDatos: TJSONObject;
  nID   : Integer;
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
        ShowMessage('Sesion creada correctamente.');
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
          ShowMessage('Sesion actualizada correctamente.')
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

  if MessageDlg('Seguro que quieres eliminar esta sesion?',
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
    ShowMessage('Sesion eliminada correctamente.');
end;

procedure TFrame4.FDMemTable1AfterRefresh(DataSet: TDataSet);
begin
  CargarDatos;
end;

end.
