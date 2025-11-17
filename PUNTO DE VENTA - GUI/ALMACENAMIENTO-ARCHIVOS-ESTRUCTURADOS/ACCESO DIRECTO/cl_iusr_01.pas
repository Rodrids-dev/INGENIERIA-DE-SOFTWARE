unit CL_IUSR_01;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  cl_iusr_02, cl_iusr_03, cl_iusr_04;

type

  { TIUSR_01 }

  TIUSR_01 = class(TForm)
    btn_gestionar: TButton;
    btn_reg_venta: TButton;
    btn_gen_reporte: TButton;
    btn_term_ejecucion: TButton;
    Label1: TLabel;
    Panel1: TPanel;
    procedure evt_mostrar_gen_reporte(Sender: TObject);
    procedure evt_term_ejecucion(Sender: TObject);
    procedure evt_mostrar_gestionar(Sender: TObject);
    procedure evt_mostrar_reg_venta(Sender: TObject);
  private

  public

  end;

var
  IUSR_01: TIUSR_01;

implementation

{$R *.lfm}

{ TIUSR_01 }

procedure TIUSR_01.evt_mostrar_gestionar(Sender: TObject);
begin
   IUSR_02.ShowModal;
end;

procedure TIUSR_01.evt_term_ejecucion(Sender: TObject);
begin
   IUSR_01.Close;
end;

procedure TIUSR_01.evt_mostrar_gen_reporte(Sender: TObject);
begin
   IUSR_04.ShowModal;
end;

procedure TIUSR_01.evt_mostrar_reg_venta(Sender: TObject);
begin
   IUSR_03.ShowModal;
end;

end.

