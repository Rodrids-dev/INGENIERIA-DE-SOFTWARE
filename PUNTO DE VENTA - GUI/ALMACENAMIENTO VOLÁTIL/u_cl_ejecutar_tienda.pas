unit u_cl_ejecutar_tienda;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  u_cl_iusr_02,u_cl_iusr_03;

type

  { TIUSR_01 }

  TIUSR_01 = class(TForm)
    btn_registrar: TButton;
    btn_venta: TButton;
    btn_salir: TButton;
    Label1: TLabel;
    procedure evt_mostrar_registrar(Sender: TObject);
    procedure evt_mostrar_venta(Sender: TObject);
    procedure evt_terminar_ejecucion(Sender: TObject);
  private

  public

  end;

var
  IUSR_01: TIUSR_01;

implementation

{$R *.lfm}

{ TIUSR_01 }

procedure TIUSR_01.evt_mostrar_registrar(Sender: TObject);
begin
   IUSR_02.ShowModal;
end;

procedure TIUSR_01.evt_mostrar_venta(Sender: TObject);
begin
    IUSR_03.ShowModal;
end;

procedure TIUSR_01.evt_terminar_ejecucion(Sender: TObject);
begin
  IUSR_01.Close;
end;

end.

