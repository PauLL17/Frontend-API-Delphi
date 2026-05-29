unit uFrmClientes;

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
  TFrame3 = class(TFrame)
    pnlSuperior: TPanel;
    lblTitulo: TLabel;
    Panel1: TPanel;
    DBNavigator1: TDBNavigator;
    pnlFormulario: TPanel;
    lblNombre: TLabel;
    lblEmail: TLabel;
    lblTelefono: TLabel;
    DBEdtNombre: TDBEdit;
    DBEdtEmail: TDBEdit;
    DBEdtTelefono: TDBEdit;
    DBGrid1: TDBGrid;
    FDMemTable1: TFDMemTable;
    DataSource1: TDataSource;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    btnDetach: TSpeedButton;
    procedure FDMemTable1AfterPost(DataSet: TDataSet);
    procedure FDMemTable1BeforeDelete(DataSet: TDataSet);
    procedure FDMemTable1BeforeEdit(DataSet: TDataSet);
    procedure FDMemTable1AfterRefresh(DataSet: TDataSet);
    procedure btnDetachClick(Sender: TObject);
  private
    sOrigNombre  : string;
    sOrigEmail   : string;
    sOrigTelefono: string;
    procedure CargarDatos;
    procedure VentanaClose(Sender: TObject; var Action: TCloseAction);
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses
  uAPI;

{$R *.dfm}

constructor TFrame3.Create(AOwner: TComponent);
var
  fId      : TIntegerField;
  fNombre  : TStringField;
  fEmail   : TStringField;
  fTelefono: TStringField;
begin
  inherited Create(AOwner);

  fId := TIntegerField.Create(FDMemTable1);
  fId.FieldName := 'id_cliente';
  fId.DataSet   := FDMemTable1;

  fNombre := TStringField.Create(FDMemTable1);
  fNombre.FieldName := 'nombre';
  fNombre.Size      := 200;
  fNombre.DataSet   := FDMemTable1;

  fEmail := TStringField.Create(FDMemTable1);
  fEmail.FieldName := 'email';
  fEmail.Size      := 200;
  fEmail.DataSet   := FDMemTable1;

  fTelefono := TStringField.Create(FDMemTable1);
  fTelefono.FieldName := 'telefono';
  fTelefono.Size      := 30;
  fTelefono.DataSet   := FDMemTable1;

  FDMemTable1.CreateDataSet;
  CargarDatos;
end;

procedure TFrame3.CargarDatos;
var
  jArray : TJSONArray;
  jObj   : TJSONObject;
  i      : Integer;
begin
  RESTRequest1.Params.Clear;
  RESTRequest1.Method   := rmGET;
  RESTRequest1.Resource := 'Clientes';
  RESTRequest1.AddParameter('Authorization', 'Bearer ' + sTokenJWT,
                             pkHTTPHEADER, [poDoNotEncode]);
  RESTRequest1.Execute;

  if RESTResponse1.StatusCode <> 200 then
  begin
    ShowMessage('Error al cargar clientes: ' + RESTResponse1.Content);
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
      FDMemTable1.FieldByName('id_cliente').AsInteger :=
        StrToIntDef(jObj.GetValue<string>('id_cliente'), 0);
      FDMemTable1.FieldByName('nombre').AsString :=
        jObj.GetValue<string>('nombre');
      FDMemTable1.FieldByName('email').AsString :=
        jObj.GetValue<string>('email');
      FDMemTable1.FieldByName('telefono').AsString :=
        jObj.GetValue<string>('telefono');
      FDMemTable1.Post;
    end;

    if FDMemTable1.RecordCount > 0 then
      FDMemTable1.First;
  finally
    FDMemTable1.AfterPost := FDMemTable1AfterPost;
    FDMemTable1.EnableControls;
  end;
end;

procedure TFrame3.FDMemTable1BeforeEdit(DataSet: TDataSet);
begin
  sOrigNombre   := DataSet.FieldByName('nombre').AsString;
  sOrigEmail    := DataSet.FieldByName('email').AsString;
  sOrigTelefono := DataSet.FieldByName('telefono').AsString;
end;

procedure TFrame3.FDMemTable1AfterPost(DataSet: TDataSet);
var
  jDatos : TJSONObject;
  nID    : Integer;
begin
  nID    := DataSet.FieldByName('id_cliente').AsInteger;
  jDatos := TJSONObject.Create;
  try
    if nID = 0 then
    begin
      jDatos.AddPair('nombre',   DataSet.FieldByName('nombre').AsString);
      jDatos.AddPair('email',    DataSet.FieldByName('email').AsString);
      jDatos.AddPair('telefono', DataSet.FieldByName('telefono').AsString);

      RESTRequest1.Params.Clear;
      RESTRequest1.ClearBody;
      RESTRequest1.AddParameter('Authorization', 'Bearer ' + sTokenJWT,
                                 pkHTTPHEADER, [poDoNotEncode]);
      RESTRequest1.AddBody(jDatos.ToJSON, TRESTContentType.ctAPPLICATION_JSON);
      RESTRequest1.Method   := rmPOST;
      RESTRequest1.Resource := 'Clientes';
      RESTRequest1.Execute;

      if RESTResponse1.StatusCode in [200, 201] then
      begin
        ShowMessage('Cliente creado correctamente.');
        CargarDatos;
      end
      else
        ShowMessage('Error al crear: ' + RESTResponse1.Content);
    end
    else
    begin
      if DataSet.FieldByName('nombre').AsString <> sOrigNombre then
        jDatos.AddPair('nombre', DataSet.FieldByName('nombre').AsString);
      if DataSet.FieldByName('email').AsString <> sOrigEmail then
        jDatos.AddPair('email', DataSet.FieldByName('email').AsString);
      if DataSet.FieldByName('telefono').AsString <> sOrigTelefono then
        jDatos.AddPair('telefono', DataSet.FieldByName('telefono').AsString);

      if jDatos.Count > 0 then
      begin
        RESTRequest1.Params.Clear;
        RESTRequest1.ClearBody;
        RESTRequest1.AddParameter('Authorization', 'Bearer ' + sTokenJWT,
                                   pkHTTPHEADER, [poDoNotEncode]);
        RESTRequest1.AddBody(jDatos.ToJSON, TRESTContentType.ctAPPLICATION_JSON);
        RESTRequest1.Method   := rmPATCH;
        RESTRequest1.Resource := 'Clientes/' + IntToStr(nID);
        RESTRequest1.Execute;

        if RESTResponse1.StatusCode in [200, 201] then
          ShowMessage('Cliente actualizado correctamente.')
        else
          ShowMessage('Error al actualizar: ' + RESTResponse1.Content);
      end;
    end;
  finally
    jDatos.Free;
  end;
end;

procedure TFrame3.FDMemTable1BeforeDelete(DataSet: TDataSet);
var
  nID: Integer;
begin
  nID := DataSet.FieldByName('id_cliente').AsInteger;

  if nID = 0 then
  begin
    Abort;
    Exit;
  end;

  if MessageDlg('Seguro que quieres eliminar este cliente?',
                mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
  begin
    Abort;
    Exit;
  end;

  RESTRequest1.Params.Clear;
  RESTRequest1.Method   := rmDELETE;
  RESTRequest1.Resource := 'Clientes/' + IntToStr(nID);
  RESTRequest1.AddParameter('Authorization', 'Bearer ' + sTokenJWT,
                             pkHTTPHEADER, [poDoNotEncode]);
  RESTRequest1.Execute;

  if not (RESTResponse1.StatusCode in [200, 204]) then
  begin
    ShowMessage('Error al eliminar: ' + RESTResponse1.Content);
    Abort;
  end
  else
    ShowMessage('Cliente eliminado correctamente.');
end;

procedure TFrame3.FDMemTable1AfterRefresh(DataSet: TDataSet);
begin
  CargarDatos;
end;

procedure TFrame3.btnDetachClick(Sender: TObject);
var
  ventana: TForm;
begin
  ventana          := TForm.Create(Application);
  ventana.Caption  := lblTitulo.Caption;
  ventana.Width    := 900;
  ventana.Height   := 600;
  ventana.Position := poScreenCenter;
  ventana.OnClose  := VentanaClose;

  Owner.RemoveComponent(Self);
  ventana.InsertComponent(Self);

  Parent := ventana;
  Align  := alClient;

  btnDetach.Visible := False;
  ventana.Show;
end;

procedure TFrame3.VentanaClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
