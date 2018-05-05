unit UnitAdd;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, sqldb, FileUtil, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls;

type

  { TAdd }

  TAdd = class(TForm)
    DSAdd: TDataSource;
    EditNome: TEdit;
    EditNome1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    PnAdd: TPanel;
    PnCancelar: TPanel;
    Q_Add: TSQLQuery;
    procedure FormCreate(Sender: TObject);
    procedure PnAddClick(Sender: TObject);
    procedure PnCancelarClick(Sender: TObject);
    procedure getCod(Cod : Integer);
  private

  public

  end;

var
  Add: TAdd;
  codAmigo : Integer;
  cCod_conta: Integer;

implementation

{$R *.lfm}

{ TAdd }

procedure TAdd.PnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TAdd.PnAddClick(Sender: TObject);
begin
  Q_Add.Close;
  Q_Add.Sql.Clear;
  Q_Add.Sql.Add( ' select cod_conta, username '+
                 ' from conta '+
                 ' where username = ' + QuotedStr(EditNome.Text)
  );
  Q_Add.Open;
  if Q_Add.RecordCount = 0 then
     ShowMessage('Usuário Não Encontrado')
  else
     try
       Q_Add.Close;
       Q_Add.Sql.Clear;
       Q_Add.Sql.Add( ' insert into amigo(cod_amigo,username,apelido,cod_conta) '+
                      ' values (' + codAmigo.ToString +
                      ' , ' + QuotedStr(EditNome.Text) +
                      ' , ' + QuotedStr(EditNome1.Text) +
                      ' , ' + cCod_conta.ToString + ') '
        );
       Q_Add.ExecSQL;
     finally
       Q_Add.Close;
       Close;
     end;

end;

procedure TAdd.FormCreate(Sender: TObject);
begin
  Q_Add.Close;
  Q_Add.Sql.Clear;
  Q_Add.Sql.Add( ' select * from amigo ' );
  Q_Add.Open;
  codAmigo := Q_Add.RecordCount + 1;
  Q_Add.Close;
end;

procedure TAdd.getCod(Cod: Integer);
begin
  cCod_conta := Cod;
end;

end.

