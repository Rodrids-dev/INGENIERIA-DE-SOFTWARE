unit U_CL_VENTA;
{$mode objfpc}{$H+}

interface

type
  CL_VENTA = class
  private
    Clave: Integer;
    Total: Real;
    Fecha: String;
  public
    constructor Create(clv: Integer; fech: String);
    procedure set_Clave(x: Integer);
    procedure set_Total(x: Real);
    procedure set_Fecha(x: String);
    function get_Clave: Integer;
    function get_Total: Real;
    function get_Fecha: String;
    procedure calcular_total(subtotal: Real);
  end;

implementation

constructor CL_VENTA.Create(clv: Integer; fech: String);
begin
  Self.Clave := clv;
  Self.Total := 0;
  Self.Fecha := fech;
end;

procedure CL_VENTA.set_Clave(x: Integer);
begin
  Clave := x;
end;

procedure CL_VENTA.set_Total(x: Real);
begin
  Total := x;
end;

procedure CL_VENTA.set_Fecha(x: String);
begin
  Fecha := x;
end;

function CL_VENTA.get_Clave: Integer;
begin
  Result := Clave;
end;

function CL_VENTA.get_Total: Real;
begin
  Result := Total;
end;

function CL_VENTA.get_Fecha: String;
begin
  Result := Fecha;
end;

procedure CL_VENTA.calcular_total(subtotal: Real);
begin
  Total := Total + subtotal;
end;

end.