unit U_CL_VENTA;
{$mode objfpc}{$H+}

interface

uses
    U_CL_LINEA_DETALLE;

type
  ArrayDetalles=array [1..10] of CL_LINEA_DETALLE;
  CL_VENTA = class
  private
    Numero: Integer;
    Total: Real;
    Fecha: String;
    Detalles: ArrayDetalles;
  public
    procedure set_Numero(x: Integer);
    procedure set_Total(x: Real);
    procedure set_Fecha(x: String);
    procedure set_Detalles(x: ArrayDetalles);
    function get_Numero: Integer;
    function get_Total: Real;
    function get_Fecha: String;
    function get_Detalles: ArrayDetalles;
    procedure calcular_total(subtotal: Real);
  end;

implementation

procedure CL_VENTA.set_Numero(x: Integer);
begin
  Numero := x;
end;

procedure CL_VENTA.set_Total(x: Real);
begin
  Total := x;
end;

procedure CL_VENTA.set_Fecha(x: String);
begin
  Fecha := x;
end;

procedure CL_VENTA.set_Detalles(x: ArrayDetalles);
begin
  Detalles := x;
end;

function CL_VENTA.get_Numero: Integer;
begin
  Result := Numero;
end;

function CL_VENTA.get_Total: Real;
begin
  Result := Total;
end;

function CL_VENTA.get_Fecha: String;
begin
  Result := Fecha;
end;

function CL_VENTA.get_Detalles:ArrayDetalles;
begin
  Result := Detalles;
end;

procedure CL_VENTA.calcular_total(subtotal: Real);
begin
  Total := Total + subtotal;
end;

end.
