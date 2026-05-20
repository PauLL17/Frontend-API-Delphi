unit MainScreen;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  System.Actions, Vcl.ActnList, Vcl.ActnMan, Vcl.ActnMenus, Vcl.ActnCtrls,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.ImgList, System.ImageList,
  Vcl.ToolWin, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    ActionMainMenuBar1: TActionMainMenuBar;
    tbHorizontal: TActionToolBar;
    tbNavLateral: TActionToolBar;
    pnlCentral: TPanel;
    ImageList1: TImageList;
    ActionManager1: TActionManager;
    actPeliculas: TAction;
    actSalas: TAction;
    actClientes: TAction;
    actSesiones: TAction;
    actEntradas: TAction;
    actSalir: TAction;
    procedure FormCreate(Sender: TObject);
    procedure actPeliculasExecute(Sender: TObject);
    procedure actSalasExecute(Sender: TObject);
    procedure actClientesExecute(Sender: TObject);
    procedure actSesionesExecute(Sender: TObject);
    procedure actEntradasExecute(Sender: TObject);
    procedure actSalirExecute(Sender: TObject);
  private
    procedure CargarFrame(AFrame: TFrame);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  uLogin, uAPI;

{$R *.dfm}

{ CargarFrame
    - Destruye cualquier frame que haya en pnlCentral
    - Asigna el nuevo frame como hijo de pnlCentral
    - Lo alinea para que ocupe todo el panel }
procedure TForm1.CargarFrame(AFrame: TFrame);
var
  i: Integer;
begin

  for i := pnlCentral.ControlCount - 1 downto 0 do
    pnlCentral.Controls[i].Free;

  AFrame.Parent := pnlCentral;
  AFrame.Align  := alClient;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  fLogin := TfLogin.Create(Application);
  try
    if fLogin.ShowModal = mrOk then
      Caption := 'CineElxVirtual  |  ' + sNombreUsuario + ' (' + sRolUsuario + ')'
    else
      Application.Terminate;
  finally
    fLogin.Free;
  end;
end;

procedure TForm1.actPeliculasExecute(Sender: TObject);
begin
  {CargarFrame(TFrmPeliculas.Create(pnlCentral)) }
end;

procedure TForm1.actSalasExecute(Sender: TObject);
begin
  {CargarFrame(TFrmSalas.Create(pnlCentral)) }
end;

procedure TForm1.actClientesExecute(Sender: TObject);
begin
  {CargarFrame(TFrmClientes.Create(pnlCentral)) }
end;

procedure TForm1.actSesionesExecute(Sender: TObject);
begin
  {CargarFrame(TFrmSesiones.Create(pnlCentral)) }
end;

procedure TForm1.actEntradasExecute(Sender: TObject);
begin
  {CargarFrame(TFrmEntradas.Create(pnlCentral)) }
end;

procedure TForm1.actSalirExecute(Sender: TObject);
begin
  { Acción Salir - pide confirmación y cierra la aplicación }
  if MessageDlg('¿Seguro que quieres salir?',
                mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    Application.Terminate;
end;

end.
