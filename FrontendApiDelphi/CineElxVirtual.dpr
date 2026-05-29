program CineElxVirtual;

uses
  Vcl.Forms,
  System.UITypes,
  uAPI in 'uAPI.pas',
  uLogin in 'uLogin.pas' {fLogin},
  MainScreen in 'MainScreen.pas' {Form1},
  uFrmPeliculas in 'uFrmPeliculas.pas' {Frame1: TFrame},
  uFrmSalas in 'uFrmSalas.pas' {Frame2: TFrame},
  uFrmClientes in 'uFrmClientes.pas' {Frame3: TFrame},
  uFrmSesiones in 'uFrmSesiones.pas' {Frame4: TFrame},
  uFrmEntradas in 'uFrmEntradas.pas' {Frame5: TFrame},
  uFrmUsuarios in 'uFrmUsuarios.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
