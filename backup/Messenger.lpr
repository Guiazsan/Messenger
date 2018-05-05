program Messenger;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, lazcontrols, anchordockpkg, unitLogin, unitDM, UnitMenu, UnitCadastro,
  UnitAdd, UnitConversa
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Initialize;
  Application.CreateForm(TLogin, Login);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TMenu1, Menu1);
  Application.CreateForm(TCadastro, Cadastro);
  Application.CreateForm(TAdd, Add);
  Application.CreateForm(TConversa, Conversa);
  Application.Run;
end.

