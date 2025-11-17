unit U_GESTOR_ARCH_VENTA;
{$mode objfpc}{$H+}

interface

uses
    U_CL_LINEA_DETALLE, U_CL_VENTA,SysUtils;

type
    GESTOR_ARCH_VENTA = class
    private
        
    public
        procedure crear_arch_venta;
        procedure guardar_venta(venta: CL_VENTA);
        procedure generar_reporte_ventas_dia(fecha:String);
        procedure generar_reporte_ventas_mes(mes: String);
        function obtener_numero_venta:Integer;
    end;

implementation

procedure GESTOR_ARCH_VENTA.crear_arch_venta;
type
    reg_venta = record
        campo_numero: Integer;
        campo_fecha: string[10];
        campo_linea_det: array [1..10] of CL_LINEA_DETALLE;
	campo_total: Real;
    end;
var
    f_venta: file of reg_venta;
begin
    AssignFile(f_venta, 'Archivos\VENTAS.rod');
    Rewrite(f_venta);
    CloseFile(f_venta);
end;

procedure GESTOR_ARCH_VENTA.guardar_venta(venta: CL_VENTA);
type
    reg_venta = record
        campo_numero: Integer;
        campo_fecha: string[10];
        campo_linea_det: array [1..10] of CL_LINEA_DETALLE;
	campo_total: Real;
    end;
var
    v_reg_venta: reg_venta;
    f_venta: file of reg_venta;
begin
    AssignFile(f_venta, 'Archivos\VENTAS.rod');
    Reset(f_venta);
    While (EOF(f_venta)=False) do
    begin
    	Read(f_venta, v_reg_venta);
    end;
	v_reg_venta.campo_numero := venta.get_Numero;
    v_reg_venta.campo_fecha := venta.get_Fecha;
    v_reg_venta.campo_linea_det := venta.get_Detalles;
    v_reg_venta.campo_total := venta.get_Total;
    Write(f_venta, v_reg_venta);
    CloseFile(f_venta);
end;

procedure GESTOR_ARCH_VENTA.generar_reporte_ventas_dia(fecha:String);
type
    reg_venta = record
        campo_numero: Integer;
        campo_fecha: string[10];
        campo_linea_det: array [1..10] of CL_LINEA_DETALLE;
	campo_total: Real;
    end;
var
    v_reg_venta: reg_venta;
    f_venta: file of reg_venta;
    f_reporte: Text;
    registro_encontrado:String;
    total_dia:Real;
begin
    total_dia:=0;
    Assign(f_reporte,'REPORTES\REPORTE-DIA.txt');
    REWRITE(f_reporte);
    WriteLn(f_reporte,'REPORTE DE VENTAS DEL DÍA '+ fecha);
    WriteLn(' ');
    WriteLn(f_reporte,'NO. VENTA'+' | '+'  FECHA  '+' | '+'TOTAL VENTA');
    Assign(f_venta,'Archivos\VENTAS.rod');
    Reset(f_venta);
    While EOF(f_venta)=False do
    begin
        Read(f_venta,v_reg_venta);
        If v_reg_venta.campo_fecha=fecha then
        begin
          registro_encontrado:= '     '+IntToStr(v_reg_venta.campo_numero)+'   '+' | '+v_reg_venta.campo_fecha+' | '+'   '+FloatToStr(v_reg_venta.campo_total);
          WriteLn(f_reporte,registro_encontrado);
          total_dia:=total_dia+v_reg_venta.campo_total;
        end;
    end;
    WriteLn(f_reporte,'TOTAL VENDIDO EN EL DÍA: '+FloatToStr(total_dia));
    Close(f_reporte);
    Close(f_venta);
end;

procedure GESTOR_ARCH_VENTA.generar_reporte_ventas_mes(mes: String);
type
    reg_venta = record
        campo_numero: Integer;
        campo_fecha: string[10];
        campo_linea_det: array [1..10] of CL_LINEA_DETALLE;
	campo_total: Real;
    end;
var
    v_reg_venta: reg_venta;
    f_venta: file of reg_venta;
    f_reporte: Text;
    registro_encontrado, mes_registrado:String;
    total_mes:Real;
begin
    total_mes:=0;
    Assign(f_reporte,'REPORTES\REPORTE-MES.txt');
    REWRITE(f_reporte);
    WriteLn(f_reporte,'REPORTE DE VENTAS DEL MES '+ mes);
    WriteLn(' ');
    WriteLn(f_reporte,'NO. VENTA'+' | '+'  FECHA  '+' | '+'TOTAL VENTA');
    Assign(f_venta,'Archivos\VENTAS.rod');
    Reset(f_venta);
    While EOF(f_venta)=False do
    begin
        Read(f_venta,v_reg_venta);
        mes_registrado:=v_reg_venta.campo_fecha;
        mes_registrado:=Copy(mes_registrado,4,7);
        If mes_registrado=mes then
        begin
          registro_encontrado:= '     '+IntToStr(v_reg_venta.campo_numero)+'   '+' | '+v_reg_venta.campo_fecha+' | '+'   '+FloatToStr(v_reg_venta.campo_total);
          WriteLn(f_reporte,registro_encontrado);
          total_mes:=total_mes+v_reg_venta.campo_total;
        end;
    end;
    WriteLn(f_reporte,'TOTAL VENDIDO EN EL MES: '+FloatToStr(total_mes));
    Close(f_reporte);
    Close(f_venta);
end;

function GESTOR_ARCH_VENTA.obtener_numero_venta:Integer;
type
    reg_venta = record
        campo_numero: Integer;
        campo_fecha: string[10];
        campo_linea_det: array [1..10] of CL_LINEA_DETALLE;
	campo_total: Real;
    end;
var
    v_reg_venta: reg_venta;
    f_venta: file of reg_venta;
    v_retorno: Integer;
begin
    AssignFile(f_venta, 'Archivos\VENTAS.rod');
    Reset(f_venta);
    v_retorno:=0;
    While (EOF(f_venta)=False) do
    begin
    	Read(f_venta, v_reg_venta);
        v_retorno:=v_reg_venta.campo_numero;
    end;
    CloseFile(f_venta);
    Result:=v_retorno;
end;

end.
