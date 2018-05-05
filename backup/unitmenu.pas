unit UnitMenu;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, DBGrids, StdCtrls, Menus, Grids, UnitAdd, UnitConversa;

type

  { TMenu1 }

  TMenu1 = class(TForm)
    DSMenu: TDataSource;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    Logoff: TMenuItem;
    Sair: TMenuItem;
    PnAdd: TPanel;
    PnMenu: TPanel;
    PnClose: TPanel;
    PnMinimize: TPanel;
    PcnTop: TPanel;
    PnTop: TPanel;
    PopupMenu1: TPopupMenu;
    Q_Menu: TSQLQuery;
    Notificacao: TShape;
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormActivate(Sender: TObject);
    procedure LogoffClick(Sender: TObject);
    procedure PnAddClick(Sender: TObject);
    procedure PnAddMouseEnter(Sender: TObject);
    procedure PnAddMouseLeave(Sender: TObject);
    procedure PnCloseClick(Sender: TObject);
    procedure PnCloseMouseEnter(Sender: TObject);
    procedure PnCloseMouseLeave(Sender: TObject);
    procedure PnMenuClick(Sender: TObject);
    procedure PnMenuMouseEnter(Sender: TObject);
    procedure PnMenuMouseLeave(Sender: TObject);
    procedure PnMinimizeClick(Sender: TObject);
    procedure PnMinimizeMouseEnter(Sender: TObject);
    procedure PnMinimizeMouseLeave(Sender: TObject);
    procedure getCod(Cod : Integer);
    procedure SairClick(Sender: TObject);
  private

  public

  end;

var
  Menu1: TMenu1;
  cCod_conta: Integer;

implementation

{$R *.lfm}

{ TMenu1 }

procedure TMenu1.PnCloseClick(Sender: TObject);
begin
     Application.Terminate;
end;

procedure TMenu1.FormActivate(Sender: TObject);
begin
  Q_Menu.Close;
  Q_Menu.SQL.Clear;
  Q_Menu.SQL.Add( ' select '+
                  ' cod_amigo ,apelido '+
                  ' from '+
                  ' amigo '+
                  ' where'+
                  ' cod_conta = '+ QuotedStr(cCod_conta.ToString) +
                  ' and status_aceito = false'
  );
  Q_Menu.Open;
  if Q_Menu.RecordCount > 0 then
  begin
    Notificacao.Visible := true;
    Label1.Visible := true;
    Label1.Text := Q_Menu.RecordCount.ToString;
  end;

  Q_Menu.Close;
  Q_Menu.SQL.Clear;
  Q_Menu.SQL.Add( ' select '+
                  ' cod_amigo ,apelido '+
                  ' from '+
                  ' amigo '+
                  ' where'+
                  ' cod_conta = '+ QuotedStr(cCod_conta.ToString) +
                  ' and status_aceito = true'
  );
  Q_Menu.Open;
  DBGrid1.Columns[0].Visible := false;
end;

procedure TMenu1.DBGrid1CellClick(Column: TColumn);
begin
  Conversa.getCod(cCod_conta);
  Conversa.getAmigoCod(DSMenu.DataSet.FieldValues['cod_amigo']);
  Application.CreateForm(TConversa,Conversa);
  Conversa.Show;
end;

procedure TMenu1.LogoffClick(Sender: TObject);
begin
  Menu1.Hide;
end;

procedure TMenu1.PnAddClick(Sender: TObject);
begin
  Add.getCod(cCod_conta);
  Application.CreateForm(TAdd,Add);
  Add.Show;
end;

procedure TMenu1.PnAddMouseEnter(Sender: TObject);
begin
     PnAdd.Color := $009C9C1F;
end;

procedure TMenu1.PnAddMouseLeave(Sender: TObject);
begin
     PnAdd.Color := $00DBDB44;
end;

procedure TMenu1.PnCloseMouseEnter(Sender: TObject);
begin
     PnClose.Color := $009C9C1F;
end;

procedure TMenu1.PnCloseMouseLeave(Sender: TObject);
begin
     PnClose.Color := $00DBDB44;
end;

procedure TMenu1.PnMenuClick(Sender: TObject);
begin
    PopupMenu1.Popup( Mouse.CursorPos.x, Mouse.CursorPos.Y);
end;

procedure TMenu1.PnMenuMouseEnter(Sender: TObject);
begin
     PnMenu.Color := $009C9C1F;
end;

procedure TMenu1.PnMenuMouseLeave(Sender: TObject);
begin
     PnMenu.Color := $00DBDB44;
end;

procedure TMenu1.PnMinimizeClick(Sender: TObject);
begin
     Application.Minimize;
end;

procedure TMenu1.PnMinimizeMouseEnter(Sender: TObject);
begin
     PnMinimize.Color := $009C9C1F;
end;

procedure TMenu1.PnMinimizeMouseLeave(Sender: TObject);
begin
     PnMinimize.Color := $00DBDB44;
end;

procedure TMenu1.getCod(Cod: Integer);
begin
  cCod_conta := Cod;
end;

procedure TMenu1.SairClick(Sender: TObject);
begin
  Application.Terminate;
end;

end.

