unit uFrmPeliculas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.DBGrids, Vcl.Mask,
  Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Intf,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  REST.Client, REST.Types, System.JSON, FireDAC.Stan.Option,
  Data.Bind.Components, Data.Bind.ObjectScope, Vcl.Grids, Vcl.Buttons;

type
  TFrame1 = class(TFrame)
    pnlSuperior: TPanel;
    lblTitulo: TLabel;
    Panel1: TPanel;
    DBNavigator1: TDBNavigator;
    pnlFormulario: TPanel;
    lblTituloF: TLabel;
    lblDuracion: TLabel;
    lblGenero: TLabel;
    DBEdtTitulo: TDBEdit;
    DBEdtDuracion: TDBEdit;
    DBEdtGenero: TDBEdit;
    DBGrid1: TDBGrid;
    FDMemTable1: TFDMemTable;
    DataSource1: TDataSource;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    procedure FDMemTable1AfterPost(DataSet: TDataSet);
    procedure FDMemTable1BeforeDelete(DataSet: TDataSet);
  private
    procedure CargarDatos;
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses
  uAPI;

{$R *.dfm}

constructor TFrame1.Create(AOwner: TComponent);
var
  fId      : TIntegerField;
  fTitulo  : TStringField;
  fDuracion: TIntegerField;
  fGenero  : TStringField;
begin
  inherited Create(AOwner);

  fId := TIntegerField.Create(FDMemTable1);
  fId.FieldName := 'id_pelicula';
  fId.DataSet   := FDMemTable1;

  fTitulo := TStringField.Create(FDMemTable1);
  fTitulo.FieldName := 'titulo';
  fTitulo.Size      := 200;
  fTitulo.DataSet   := FDMemTable1;

  fDuracion := TIntegerField.Create(FDMemTable1);
  fDuracion.FieldName := 'duracion';
  fDuracion.DataSet   := FDMemTable1;

  fGenero := TStringField.Create(FDMemTable1);
  fGenero.FieldName := 'genero';
  fGenero.Size      := 100;
  fGenero.DataSet   := FDMemTable1;

  FDMemTable1.CreateDataSet;
  CargarDatos;
end;

procedure TFrame1.CargarDatos;
var
  jArray : TJSONArray;
  jObj   : TJSONObject;
  i      : Integer;
begin
  RESTRequest1.Params.Clear;
  RESTRequest1.Method   := rmGET;
  RESTRequest1.Resource := 'Peliculas';
  RESTRequest1.AddParameter('Authorization', 'Bearer ' + sTokenJWT,
                             pkHTTPHEADER, [poDoNotEncode]);
  RESTRequest1.Execute;

  if RESTResponse1.StatusCode <> 200 then
  begin
    ShowMessage('Error al cargar peliculas: ' + RESTResponse1.Content);
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
      FDMemTable1.FieldByName('id_pelicula').AsInteger :=
        StrToIntDef(jObj.GetValue<string>('id_pelicula'), 0);
      FDMemTable1.FieldByName('titulo').AsString :=
        jObj.GetValue<string>('titulo');
      FDMemTable1.FieldByName('duracion').AsInteger :=
        StrToIntDef(jObj.GetValue<string>('duracion'), 0);
      FDMemTable1.FieldByName('genero').AsString :=
        jObj.GetValue<string>('genero');
      FDMemTable1.Post;
    end;

    if FDMemTable1.RecordCount > 0 then
      FDMemTable1.First;
  finally
    FDMemTable1.AfterPost := FDMemTable1AfterPost;  // Restaurar evento
    FDMemTable1.EnableControls;
  end;
end;

procedure TFrame1.FDMemTable1AfterPost(DataSet: TDataSet);
var
  jDatos : TJSONObject;
  nID    : Integer;
begin
  ShowMessage('AfterPost disparado');
  nID := DataSet.FieldByName('id_pelicula').AsInteger;

  jDatos := TJSONObject.Create;
  try
    jDatos.AddPair('titulo',   DataSet.FieldByName('titulo').AsString);
    jDatos.AddPair('duracion', DataSet.FieldByName('duracion').AsString);
    jDatos.AddPair('genero',   DataSet.FieldByName('genero').AsString);

    RESTRequest1.Params.Clear;
    RESTRequest1.ClearBody;
    RESTRequest1.AddParameter('Authorization', 'Bearer ' + sTokenJWT,
                               pkHTTPHEADER, [poDoNotEncode]);
    RESTRequest1.AddBody(jDatos.ToJSON, TRESTContentType.ctAPPLICATION_JSON);

    if nID = 0 then
    begin
      RESTRequest1.Method   := rmPOST;
      RESTRequest1.Resource := 'Peliculas';
    end
    else
    begin
      RESTRequest1.Method   := rmPUT;
      RESTRequest1.Resource := 'Peliculas/' + IntToStr(nID);
    end;

    RESTRequest1.Execute;
    ShowMessage('Status: ' + IntToStr(RESTResponse1.StatusCode) + ' - ' + RESTResponse1.Content);

    if RESTResponse1.StatusCode in [200, 201] then
    begin
      if nID = 0 then
      begin
        ShowMessage('Pelicula creada correctamente.');
        CargarDatos;
      end
      else
        ShowMessage('Pelicula actualizada correctamente.');
    end
    else
      ShowMessage('Error al guardar: ' + RESTResponse1.Content);
  finally
    jDatos.Free;
  end;
end;

procedure TFrame1.FDMemTable1BeforeDelete(DataSet: TDataSet);
var
  nID: Integer;
begin
  nID := DataSet.FieldByName('id_pelicula').AsInteger;

  if nID = 0 then
  begin
    Abort;
    Exit;
  end;

  if MessageDlg('Seguro que quieres eliminar esta pelicula?',
                mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
  begin
    Abort;
    Exit;
  end;

  RESTRequest1.Params.Clear;
  RESTRequest1.Method   := rmDELETE;
  RESTRequest1.Resource := 'Peliculas/' + IntToStr(nID);
  RESTRequest1.AddParameter('Authorization', 'Bearer ' + sTokenJWT,
                             pkHTTPHEADER, [poDoNotEncode]);
  RESTRequest1.Execute;

  if not (RESTResponse1.StatusCode in [200, 204]) then
  begin
    ShowMessage('Error al eliminar: ' + RESTResponse1.Content);
    Abort;
  end
  else
    ShowMessage('Pelicula eliminada correctamente.');
end;

end.
