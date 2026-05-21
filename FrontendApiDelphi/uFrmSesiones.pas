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
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TFrame4.FDMemTable1AfterPost(DataSet: TDataSet);
begin
//
end;

procedure TFrame4.FDMemTable1BeforeDelete(DataSet: TDataSet);
begin
//
end;

end.
