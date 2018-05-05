unit UnitConversa;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, sqldb, FileUtil, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ExtCtrls, DBGrids, DbCtrls, UnitDM;

type

  { TConversa }

  TConversa = class(TForm)
    DS_Mensagens: TDataSource;
    DSConversa: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    qTexto: TSQLQuery;
    Q_Conversa: TSQLQuery;
    qAux: TSQLQuery;
    Q_Mensagens: TSQLQuery;
    Q_Mensagensautor: TStringField;
    Q_Mensagenstexto: TStringField;
    ScrollBox1: TScrollBox;
    Texto: TMemo;
    Panel1: TPanel;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure TextoChange(Sender: TObject);
    procedure getCod(Cod : Integer);
    procedure getAmigoCod(CodA : Integer);
  private

  public

  end;

var
  Conversa: TConversa;
  cCod_conta : Integer;
  cCod_amigo : Integer;

implementation

{$R *.lfm}

{ TConversa }

procedure TConversa.TextoChange(Sender: TObject);
begin
  Label2.Caption := (280 - Length(Texto.Text)).ToString + ' Caracteres Restantes';
  if Length(Texto.Text) > 280 then
     Label2.Font.Color := $005551FF
  else
     Label2.Font.Color := clWhite;
end;

procedure TConversa.FormCreate(Sender: TObject);
begin
  Q_Conversa.Close;
  Q_Conversa.Sql.Clear;
  Q_Conversa.Sql.Add( ' select * '+
                      ' from conversa '+
                      ' where cod_amigo = ' + cCod_Amigo.ToString +
                      ' and cod_conta = ' + cCod_conta.ToString
  );
  Q_Conversa.Open;
  if Q_Conversa.RecordCount = 0 then
     Begin
        try
          qAux.SQL.Clear;
          qAux.Sql.Add(' select cod_conversa from conversa ');
          qAux.Open;

          Q_Conversa.Close;
          Q_Conversa.Sql.Clear;
          Q_Conversa.Sql.Add( ' insert into '+
                              ' conversa(cod_conversa,cod_conta,cod_amigo)'+
                              ' values ' +
                              ' (' + (qAux.RecordCount + 1).ToString + ', '+
                                     cCod_conta.ToString + ', ' +
                                     cCod_amigo.ToString + ')'
          );
          Q_Conversa.ExecSQL;
          Form1.SQLTransaction1.Commit;
        finally
          qAux.Close;
          FreeAndNil(qAux);
        end;

     end;

  Q_Conversa.Close;
  Q_Conversa.Sql.Clear;
  Q_Conversa.Sql.Add( ' select '+
                      ' apelido '+
                      ' from amigo '+
                      ' where cod_amigo = ' + cCod_Amigo.ToString
  );
  Q_Conversa.Open;
  Label1.Caption := Q_Conversa.FieldByName('apelido').AsString;
  Conversa.Caption := Q_Conversa.FieldByName('apelido').AsString;
  Q_Conversa.Close;
end;

procedure TConversa.FormActivate(Sender: TObject);
begin
  Q_Mensagens.Open;
end;

procedure TConversa.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Q_Mensagens.Close;
end;

procedure TConversa.Panel1Click(Sender: TObject);
var mensagem: String;
begin
  mensagem := Texto.Text;
  mensagem := mensagem.Replace(' ','');
  if( mensagem <> '') then
  try
    qAux.SQL.Clear;
    qAux.Sql.Add(' select cod_texto from texto_tab ');
    qAux.Open;

    qTexto.Close;
    qTexto.SQL.Clear;
    qTexto.SQL.Add(' insert into texto_tab(cod_texto, texto, autor, cod_conversa) values '+
                  ' (' + (qAux.RecordCount + 1).ToString + ', '+
                  QuotedStr(Texto.Text) + ', ' + '(select username from conta'+
                  ' where cod_conta = '+ cCod_conta.ToString + '),' + '(select '+
                  'cod_conversa from conversa where cod_conta = '+ cCod_conta.ToString() +
                  ' and cod_amigo = '+ cCod_amigo.ToString + '))');
    qTexto.ExecSQL;
    Form1.SQLTransaction1.Commit;
    Texto.Text := '';
  finally
    qAux.Close;
    FreeAndNil(qAux);
  end;
end;

procedure TConversa.getCod(Cod: Integer);
begin
  cCod_conta := Cod;
end;

procedure TConversa.getAmigoCod(CodA: Integer);
begin
  cCod_amigo := CodA;
end;

end.

