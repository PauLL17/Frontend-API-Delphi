unit unit6;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  REST.Types, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Vcl.DBCtrls, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons;

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
    // Eventos que puedes enlazar después si lo necesitas
    procedure FDMemTable1BeforeEdit(DataSet: TDataSet);
    procedure FDMemTable1AfterPost(DataSet: TDataSet);
    procedure FDMemTable1BeforeDelete(DataSet: TDataSet);
    procedure FDMemTable1AfterRefresh(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

// Métodos de ejemplo para los eventos (puedes adaptarlos a tu API)
procedure TuFrmUsuarios.FDMemTable1BeforeEdit(DataSet: TDataSet);
begin
  // Lógica antes de editar
end;

procedure TuFrmUsuarios.FDMemTable1AfterPost(DataSet: TDataSet);
begin
  // Lógica después de guardar
end;

procedure TuFrmUsuarios.FDMemTable1BeforeDelete(DataSet: TDataSet);
begin
  // Confirmación o lógica antes de borrar
end;

procedure TuFrmUsuarios.FDMemTable1AfterRefresh(DataSet: TDataSet);
begin
  // Lógica después de refrescar datos
end;

end.
