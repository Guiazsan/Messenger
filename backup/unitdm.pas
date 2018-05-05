unit unitDM;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, pqconnection, FileUtil, Forms,
  Controls, Graphics, Dialogs;

type

  { TForm1 }

  TForm1 = class(TForm)
    DataMaster: TPQConnection;
    SQLTransaction1: TSQLTransaction;
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

end.

