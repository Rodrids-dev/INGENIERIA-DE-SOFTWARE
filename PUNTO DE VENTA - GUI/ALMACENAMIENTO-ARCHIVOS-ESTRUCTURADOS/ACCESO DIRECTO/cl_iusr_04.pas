unit CL_IUSR_04;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, U_CL_VISTA_MENSAJE,U_GESTOR_ARCH_VENTA;

type

  { TIUSR_04 }

  TIUSR_04 = class(TForm)
    btn_reporte_diario: TButton;
    btn_reporte_mensual: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lbl_fecha: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Panel1: TPanel;
    btn_cerrar: TSpeedButton;
    procedure evt_cerrar(Sender: TObject);
    procedure evt_generar_reporte_diario(Sender: TObject);
    procedure evt_generar_reporte_mensual(Sender: TObject);
    procedure evt_mostrar_fecha(Sender: TObject);
  private

  public

  end;

var
  IUSR_04: TIUSR_04;

implementation

{$R *.lfm}

{ TIUSR_04 }

procedure TIUSR_04.evt_cerrar(Sender: TObject);
begin
  IUSR_04.Close;
end;

procedure TIUSR_04.evt_generar_reporte_diario(Sender: TObject);
var
  v_fecha:TDate;
  gestor_venta: GESTOR_ARCH_VENTA;
  mensaje: CL_VISTA_MENSAJE;
begin
  v_fecha:=Date;
  gestor_venta:=GESTOR_ARCH_VENTA.Create;
  gestor_venta.generar_reporte_ventas_dia(DateToStr(v_fecha));
  mensaje:=CL_VISTA_MENSAJE.Create;
  mensaje.set_mensaje('Se ha generado satisfactoriamente el reporte de ventas del día: '+DateToStr(v_fecha));
  mensaje.mostrar_mensaje;
end;

procedure TIUSR_04.evt_generar_reporte_mensual(Sender: TObject);
var
  v_fecha:TDate;
  v_mes: String;
  gestor_venta: GESTOR_ARCH_VENTA;
  mensaje: CL_VISTA_MENSAJE;
begin
  v_fecha:=Date;
  v_mes:= Copy(DateToStr(v_fecha),4,7);
  gestor_venta:=GESTOR_ARCH_VENTA.Create;
  gestor_venta.generar_reporte_ventas_mes(v_mes);
  mensaje:=CL_VISTA_MENSAJE.Create;
  mensaje.set_mensaje('Se ha generado satisfactoriamente el reporte de ventas del mes: '+v_mes);
  mensaje.mostrar_mensaje;
end;

procedure TIUSR_04.evt_mostrar_fecha(Sender: TObject);
var
  v_fecha: TDate;
begin
  v_fecha:=Date;
  IUSR_04.lbl_fecha.Caption:=DateToStr(v_fecha);
end;

end.

