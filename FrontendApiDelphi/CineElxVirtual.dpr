program CineElxVirtual;

uses
  Vcl.Forms,
  System.UITypes,
  uAPI in 'uAPI.pas',
  uLogin in 'uLogin.pas' {fLogin},
  MainScreen in 'MainScreen.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
