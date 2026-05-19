unit MainScreen;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  System.Actions, Vcl.ActnList, Vcl.ActnMan, Vcl.ActnMenus, Vcl.ActnCtrls,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.ImgList, System.ImageList,
  Vcl.ToolWin, Vcl.Imaging.Jpeg;

type
  TForm1 = class(TForm)
    ActionMainMenuBar1: TActionMainMenuBar;
    tbHorizontal: TActionToolBar;
    tbNavLateral: TActionToolBar;
    ImageList1: TImageList;
    ActionManager1: TActionManager;
    actPeliculas: TAction;
    actSalas: TAction;
    actClientes: TAction;
    actSesiones: TAction;
    actEntradas: TAction;
    actSalir: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actPeliculasExecute(Sender: TObject);
    procedure actSalasExecute(Sender: TObject);
    procedure actClientesExecute(Sender: TObject);
    procedure actSesionesExecute(Sender: TObject);
    procedure actEntradasExecute(Sender: TObject);
    procedure actSalirExecute(Sender: TObject);
  private
    FOldMDIProc: Pointer;
    procedure CargarFondoMDI(const sRuta: string);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  uLogin, uAPI;

{$R *.dfm}

var
  _FondoBitmap: TBitmap;

function MDIClientWndProc(hWnd: HWND; Msg: UINT;
  wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
var
  oCanvas : TCanvas;
  rRect   : TRect;
begin
  { MDIClientWndProc
    - Intercepta WM_ERASEBKGND del área MDI
    - Si hay bitmap de fondo lo dibuja estirado
    - Si no, llama al procedimiento original }
  if (Msg = WM_ERASEBKGND) and Assigned(_FondoBitmap) then
  begin
    oCanvas := TCanvas.Create;
    try
      oCanvas.Handle := HDC(wParam);
      GetClientRect(hWnd, rRect);
      oCanvas.StretchDraw(rRect, _FondoBitmap);
    finally
      oCanvas.Free;
    end;
    Result := 1;
  end
  else
    Result := CallWindowProc(Form1.FOldMDIProc,
                             hWnd, Msg, wParam, lParam);
end;

procedure TForm1.CargarFondoMDI(const sRuta: string);
var
  oJpeg: TJpegImage;
begin
  { CargarFondoMDI
    - Carga la imagen JPG desde la ruta indicada
    - La convierte a Bitmap para el pintado
    - Subclasifica la ventana MDI client para interceptar el pintado }
  if not FileExists(sRuta) then
  begin
    ShowMessage('No se encontró la imagen: ' + sRuta);
    Exit;
  end;

  if not Assigned(_FondoBitmap) then
    _FondoBitmap := TBitmap.Create;

  oJpeg := TJpegImage.Create;
  try
    oJpeg.LoadFromFile(sRuta);
    _FondoBitmap.Assign(oJpeg);
  finally
    oJpeg.Free;
  end;

  FOldMDIProc := Pointer(GetWindowLong(ClientHandle, GWL_WNDPROC));
  SetWindowLong(ClientHandle, GWL_WNDPROC,
                LongInt(@MDIClientWndProc));

  InvalidateRect(ClientHandle, nil, True);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  { FormCreate de MainScreen
    - Muestra fLogin como modal antes de mostrar el principal
    - Si login correcto (mrOk): actualiza el caption con usuario y rol
    - Si se cancela: termina la aplicación
    - Carga la imagen de fondo del área MDI }
  fLogin := TfLogin.Create(Application);
  try
    if fLogin.ShowModal = mrOk then
      Caption := 'CineElxVirtual  |  ' + sNombreUsuario + ' (' + sRolUsuario + ')'
    else
      Application.Terminate;
  finally
    fLogin.Free;
  end;

  CargarFondoMDI('fondo.jpg');
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  { Libera el bitmap de fondo al cerrar }
  FreeAndNil(_FondoBitmap);
end;

procedure TForm1.actPeliculasExecute(Sender: TObject);
begin
  { TODO: abrir fPeliculas como MDI child }
end;

procedure TForm1.actSalasExecute(Sender: TObject);
begin
  { TODO: abrir fSalas como MDI child }
end;

procedure TForm1.actClientesExecute(Sender: TObject);
begin
  { TODO: abrir fClientes como MDI child }
end;

procedure TForm1.actSesionesExecute(Sender: TObject);
begin
  { TODO: abrir fSesiones como MDI child }
end;

procedure TForm1.actEntradasExecute(Sender: TObject);
begin
  { TODO: abrir fEntradas como MDI child }
end;

procedure TForm1.actSalirExecute(Sender: TObject);
begin
  { Acción Salir - pide confirmación y cierra la aplicación }
  if MessageDlg('¿Seguro que quieres salir?',
                mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    Application.Terminate;
end;

end.
