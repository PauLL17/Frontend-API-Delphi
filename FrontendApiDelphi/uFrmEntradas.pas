unit uFrmEntradas;

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
  TFrame5 = class(TFrame)
    pnlSuperior: TPanel;
    lblTitulo: TLabel;
    Panel1: TPanel;
    DBNavigator1: TDBNavigator;
    pnlFormulario: TPanel;
    lblIdSesion: TLabel;
    lblIdCliente: TLabel;
    lblCantidad: TLabel;
    lblPrecio: TLabel;
    DBEdtIdSesion: TDBEdit;
    DBEdtIdCliente: TDBEdit;
    DBEdtCantidad: TDBEdit;
    DBEdtPrecio: TDBEdit;
    DBGrid1: TDBGrid;
    FDMemTable1: TFDMemTable;
    DataSource1: TDataSource;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    procedure FDMemTable1AfterPost(DataSet: TDataSet);
    procedure FDMemTable1BeforeDelete(DataSet: TDataSet);
    procedure FDMemTable1BeforeEdit(DataSet: TDataSet);
    procedure FDMemTable1AfterRefresh(DataSet: TDataSet);
  private
    nOrigSesion  : Integer;
    nOrigCliente : Integer;
    nOrigCantidad: Integer;
    fOrigPrecio  : Double;
    procedure CargarDatos;
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses
  uAPI;

{$R *.dfm}

constructor TFrame5.Create(AOwner: TComponent);
var
  fId      : TIntegerField;
  fSesion  : TIntegerField;
  fCliente : TIntegerField;
  fCantidad: TIntegerField;
  fPrecio  : TFloatField;
begin
  inherited Create(AOwner);

  fId := TIntegerField.Create(FDMemTable1);
  fId.FieldName := 'id_entrada';
  fId.DataSet   := FDMemTable1;

  fSesion := TIntegerField.Create(FDMemTable1);
  fSesion.FieldName := 'id_sesion';
  fSesion.DataSet   := FDMemTable1;

  fCliente := TIntegerField.Create(FDMemTable1);
  fCliente.FieldName := 'id_cliente';
  fCliente.DataSet   := FDMemTable1;

  fCantidad := TIntegerField.Create(FDMemTable1);
  fCantidad.FieldName := 'cantidad_asientos';
  fCantidad.DataSet   := FDMemTable1;

  fPrecio := TFloatField.Create(FDMemTable1);
  fPrecio.FieldName := 'precio_base';
  fPrecio.DataSet   := FDMemTable1;

  FDMemTable1.CreateDataSet;
  CargarDatos;
end;

procedure TFrame5.CargarDatos;
var
  jArray : TJSONArray;
  jObj   : TJSONObject;
  i      : Integer;
begin
  RESTRequest1.Params.Clear;
  RESTRequest1.Method   := rmGET;
  RESTRequest1.Resource := 'Entradas';
  RESTRequest1.AddParameter('Authorization', 'Bearer ' + sTokenJWT,
                             pkHTTPHEADER, [poDoNotEncode]);
  RESTRequest1.Execute;

  if RESTResponse1.StatusCode <> 200 then
  begin
    ShowMessage('Error al cargar entradas: ' + RESTResponse1.Content);
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
      FDMemTable1.FieldByName('id_entrada').AsInteger :=
        StrToIntDef(jObj.GetValue<string>('id_entrada'), 0);
      FDMemTable1.FieldByName('id_sesion').AsInteger :=
        StrToIntDef(jObj.GetValue<string>('id_sesion'), 0);
      FDMemTable1.FieldByName('id_cliente').AsInteger :=
        StrToIntDef(jObj.GetValue<string>('id_cliente'), 0);
      FDMemTable1.FieldByName('cantidad_asientos').AsInteger :=
        StrToIntDef(jObj.GetValue<string>('cantidad_asientos'), 0);
      FDMemTable1.FieldByName('precio_base').AsFloat :=
        StrToFloatDef(jObj.GetValue<string>('precio_base'), 0.0);
      FDMemTable1.Post;
    end;

    if FDMemTable1.RecordCount > 0 then
      FDMemTable1.First;
  finally
    FDMemTable1.AfterPost := FDMemTable1AfterPost;
    FDMemTable1.EnableControls;
  end;
end;

procedure TFrame5.FDMemTable1BeforeEdit(DataSet: TDataSet);
begin
  nOrigSesion   := DataSet.FieldByName('id_sesion').AsInteger;
  nOrigCliente  := DataSet.FieldByName('id_cliente').AsInteger;
  nOrigCantidad := DataSet.FieldByName('cantidad_asientos').AsInteger;
  fOrigPrecio   := DataSet.FieldByName('precio_base').AsFloat;
end;

procedure TFrame5.FDMemTable1AfterPost(DataSet: TDataSet);
var
  jDatos : TJSONObject;
  nID    : Integer;
begin
  nID    := DataSet.FieldByName('id_entrada').AsInteger;
  jDatos := TJSONObject.Create;
  try
    if nID = 0 then
    begin
      jDatos.AddPair('id_sesion',         DataSet.FieldByName('id_sesion').AsString);
      jDatos.AddPair('id_cliente',        DataSet.FieldByName('id_cliente').AsString);
      jDatos.AddPair('cantidad_asientos', DataSet.FieldByName('cantidad_asientos').AsString);
      jDatos.AddPair('precio_base',       DataSet.FieldByName('precio_base').AsString);

      RESTRequest1.Params.Clear;
      RESTRequest1.ClearBody;
      RESTRequest1.AddParameter('Authorization', 'Bearer ' + sTokenJWT,
                                 pkHTTPHEADER, [poDoNotEncode]);
      RESTRequest1.AddBody(jDatos.ToJSON, TRESTContentType.ctAPPLICATION_JSON);
      RESTRequest1.Method   := rmPOST;
      RESTRequest1.Resource := 'Entradas';
      RESTRequest1.Execute;

      if RESTResponse1.StatusCode in [200, 201] then
      begin
        ShowMessage('Entrada creada correctamente.');
        CargarDatos;
      end
      else
        ShowMessage('Error al crear: ' + RESTResponse1.Content);
    end
    else
    begin
      if DataSet.FieldByName('id_sesion').AsInteger <> nOrigSesion then
        jDatos.AddPair('id_sesion', DataSet.FieldByName('id_sesion').AsString);
      if DataSet.FieldByName('id_cliente').AsInteger <> nOrigCliente then
        jDatos.AddPair('id_cliente', DataSet.FieldByName('id_cliente').AsString);
      if DataSet.FieldByName('cantidad_asientos').AsInteger <> nOrigCantidad then
        jDatos.AddPair('cantidad_asientos', DataSet.FieldByName('cantidad_asientos').AsString);
      if DataSet.FieldByName('precio_base').AsFloat <> fOrigPrecio then
        jDatos.AddPair('precio_base', DataSet.FieldByName('precio_base').AsString);

      if jDatos.Count > 0 then
      begin
        RESTRequest1.Params.Clear;
        RESTRequest1.ClearBody;
        RESTRequest1.AddParameter('Authorization', 'Bearer ' + sTokenJWT,
                                   pkHTTPHEADER, [poDoNotEncode]);
        RESTRequest1.AddBody(jDatos.ToJSON, TRESTContentType.ctAPPLICATION_JSON);
        RESTRequest1.Method   := rmPATCH;
        RESTRequest1.Resource := 'Entradas/' + IntToStr(nID);
        RESTRequest1.Execute;

        if RESTResponse1.StatusCode in [200, 201] then
          ShowMessage('Entrada actualizada correctamente.')
        else
          ShowMessage('Error al actualizar: ' + RESTResponse1.Content);
      end;
    end;
  finally
    jDatos.Free;
  end;
end;

procedure TFrame5.FDMemTable1BeforeDelete(DataSet: TDataSet);
var
  nID: Integer;
begin
  nID := DataSet.FieldByName('id_entrada').AsInteger;

  if nID = 0 then
  begin
    Abort;
    Exit;
  end;

  if MessageDlg('Seguro que quieres eliminar esta entrada?',
                mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
  begin
    Abort;
    Exit;
  end;

  RESTRequest1.Params.Clear;
  RESTRequest1.Method   := rmDELETE;
  RESTRequest1.Resource := 'Entradas/' + IntToStr(nID);
  RESTRequest1.AddParameter('Authorization', 'Bearer ' + sTokenJWT,
                             pkHTTPHEADER, [poDoNotEncode]);
  RESTRequest1.Execute;

  if not (RESTResponse1.StatusCode in [200, 204]) then
  begin
    ShowMessage('Error al eliminar: ' + RESTResponse1.Content);
    Abort;
  end
  else
    ShowMessage('Entrada eliminada correctamente.');
end;

procedure TFrame5.FDMemTable1AfterRefresh(DataSet: TDataSet);
begin
  CargarDatos;
end;

end.
