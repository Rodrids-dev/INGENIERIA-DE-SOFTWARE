unit CL_ICONF_01;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

  { TICONF_01 }

  TICONF_01 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Image1: TImage;
    lbl_pregunta: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private

  public

  end;

var
  ICONF_01: TICONF_01;

implementation

{$R *.lfm}

{ TICONF_01 }

procedure TICONF_01.Button1Click(Sender: TObject);
begin
  ModalResult:=mrYes;
  //ICONF_01.Close;
end;

procedure TICONF_01.Button2Click(Sender: TObject);
begin
  ModalResult:=mrNo;
  ICONF_01.Close;
end;

end.

