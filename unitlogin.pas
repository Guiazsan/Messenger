unit unitLogin;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, sqldb, FileUtil, Forms, Controls, Graphics,
  Dialogs, StdCtrls, ExtCtrls, LCLType, Buttons, UnitMenu, UnitCadastro;

type

  { TLogin }

  TLogin = class(TForm)
    CBLembraConta: TCheckBox;
    CBLembraSenha: TCheckBox;
    DSLogin: TDataSource;
    EditUser: TEdit;
    EditSenha: TEdit;
    ImageList1: TImageList;
    LkCad: TLabel;
    PnEntrar: TPanel;
    PnClose: TPanel;
    PnMinimize: TPanel;
    PnTop: TPanel;
    Q_Login: TSQLQuery;
    procedure LkCadClick(Sender: TObject);
    procedure PnCloseClick(Sender: TObject);
    procedure PnCloseMouseEnter(Sender: TObject);
    procedure PnCloseMouseLeave(Sender: TObject);
    procedure PnEntrarClick(Sender: TObject);
    procedure PnMinimizeClick(Sender: TObject);
    procedure PnMinimizeMouseEnter(Sender: TObject);
    procedure PnMinimizeMouseLeave(Sender: TObject);
    procedure PnTopMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer; var Key: Word);
  private

  public

  end;

var
  Login: TLogin;
  cCod_conta : Integer;

implementation


{$R *.lfm}

{ TLogin }

procedure TLogin.PnCloseClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TLogin.LkCadClick(Sender: TObject);
begin
  Application.CreateForm(TCadastro,Cadastro);
  Cadastro.Show;
  Login.Deactivate;
end;

procedure TLogin.PnCloseMouseEnter(Sender: TObject);
begin
  PnClose.Color := $009C9C1F;
end;

procedure TLogin.PnCloseMouseLeave(Sender: TObject);
begin
  PnClose.Color := $00DBDB44;
end;

procedure TLogin.PnEntrarClick(Sender: TObject);
begin
   Q_Login.Close;
   Q_Login.SQL.Clear;
   Q_Login.SQL.Add(' select * '+
                   ' from '+
                   ' conta '+
                   ' where '+
                   ' username = ' + QuotedStr(EditUser.Text)
   );
   Q_Login.Open;
   if (EditSenha.Text = Q_Login.FieldByName('senha').AsString) and not(Q_Login.FieldByName('senha').AsString.isEmpty) then
      begin
        cCod_conta := Q_Login.FieldByName('cod_conta').AsInteger;
        Menu1.getCod(cCod_conta);
        Application.CreateForm(TMenu1,Menu1);
        //Q_Login.Close;
        Menu1.Show;
        Login.Hide;
      end;
end;

procedure TLogin.PnMinimizeClick(Sender: TObject);
begin
  Application.Minimize;
end;

procedure TLogin.PnMinimizeMouseEnter(Sender: TObject);
begin
  PnMinimize.Color := $009C9C1F;
end;

procedure TLogin.PnMinimizeMouseLeave(Sender: TObject);
begin
  PnMinimize.Color := $00DBDB44;
end;

procedure TLogin.PnTopMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer; var Key: Word);
begin
  if Key = VK_LBUTTON then
     begin
        Login.Left := Mouse.CursorPos.x - 150;
        Login.Top := Mouse.CursorPos.y - 10;
     end;
end;

end.

