unit UnitCadastro;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, sqldb, FileUtil, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ExtCtrls, UnitDM;

type

  { TCadastro }

  TCadastro = class(TForm)
    CBTermos: TCheckBox;
    DS_Cad: TDataSource;
    EditPas1: TEdit;
    EditUser: TEdit;
    EditPas: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    PnCadastrar: TPanel;
    Q_Cad: TSQLQuery;
    procedure EditUserExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure PnCadastrarClick(Sender: TObject);
  private

  public

  end;

var
  Cadastro: TCadastro;
  Cod : Integer;

implementation

{$R *.lfm}

{ TCadastro }

procedure TCadastro.PnCadastrarClick(Sender: TObject);
begin
  if (EditPas.Text = EditPas1.Text) and (CBTermos.Checked) then
  begin
    try
      Q_Cad.Close;
      Q_Cad.Sql.Clear;
      Q_Cad.SQL.Add( ' insert into conta(cod_conta,username,senha) values '+
                     ' ( '+ Cod.ToString + ', '+ QuotedStr(EditUser.Text) +
                     ', ' + QuotedStr(EditPas.Text) + ')'

      );
      Q_Cad.ExecSQL;
      Form1.SQLTransaction1.Commit;
    finally
      Q_Cad.Close;
      Close;
    end;
  end
  else
  if not(CBTermos.Checked) then
    ShowMessage('Você Deve Aceitar os Temos de Uso');
  if not(EditPas.Text = EditPas1.Text) then
    ShowMessage('Senha não confere');

end;

procedure TCadastro.FormCreate(Sender: TObject);
begin
  Q_Cad.Sql.Clear;
  Q_Cad.Sql.Add( ' select cod_conta '+
                 ' from '+
                 ' conta '
  );
  Q_Cad.Open;
  Cod := Q_Cad.RecordCount + 1;
  Q_Cad.Close;
end;

procedure TCadastro.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Q_Cad.Close;
end;

procedure TCadastro.EditUserExit(Sender: TObject);
begin
  if EditUser.Text <> '' then
    begin
      Q_Cad.Close;
      Q_Cad.Sql.Clear;
      Q_Cad.Sql.Add( ' select username '+
                     ' from '+
                     ' conta '+
                     ' where '+
                     ' username = '+ QuotedStr(EditUser.Text)
      );
      Q_Cad.Open;
      if Q_Cad.RecordCount <> 0 then
         EditUser.Color := $005551FF //vermelho
      else
         EditUser.Color := $0079F376; //verde
    end;
end;

end.

