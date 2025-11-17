unit U_CL_LINEA_DETALLE;
{$mode objfpc}{$H+}

interface

uses U_CL_PRODUCTO;

type
  CL_LINEA_DETALLE = class
  private
    Clave: Integer;
    Unidades_Adquiridas: Integer;
    Subtotal: Real;
    Producto: CL_PRODUCTO;
  public
    constructor Create(clv: Integer; ua: Integer; prod: CL_PRODUCTO);
    procedure set_Clave(x: Integer);
    procedure set_Unidades_Adquiridas(x: Integer);
    procedure set_Subtotal(x: Real);
    procedure set_Producto(x: CL_PRODUCTO);
    function get_Clave: Integer;
    function get_Unidades_Adquiridas: Integer;
    function get_Subtotal: Real;
    function get_Producto: CL_PRODUCTO;
    procedure calcular_subtotal;
  end;

implementation

constructor CL_LINEA_DETALLE.Create(clv: Integer; ua: Integer; prod: CL_PRODUCTO);
begin
  Self.Clave := clv;
  Self.Unidades_Adquiridas := ua;
  Self.Subtotal := 0;
  Self.Producto := prod;
end;

procedure CL_LINEA_DETALLE.set_Clave(x: Integer);
begin
  Clave := x;
end;

procedure CL_LINEA_DETALLE.set_Unidades_Adquiridas(x: Integer);
begin
  Unidades_Adquiridas := x;
end;

procedure CL_LINEA_DETALLE.set_Subtotal(x: Real);
begin
  Subtotal := x;
end;

procedure CL_LINEA_DETALLE.set_Producto(x: CL_PRODUCTO);
begin
  Producto := x;
end;

function CL_LINEA_DETALLE.get_Clave: Integer;
begin
  Result := Clave;
end;

function CL_LINEA_DETALLE.get_Unidades_Adquiridas: Integer;
begin
  Result := Unidades_Adquiridas;
end;

function CL_LINEA_DETALLE.get_Subtotal: Real;
begin
  Result := Subtotal;
end;

function CL_LINEA_DETALLE.get_Producto: CL_PRODUCTO;
begin
  Result := Producto;
end;

procedure CL_LINEA_DETALLE.calcular_subtotal;
begin
  Subtotal := Producto.get_Precio * Unidades_Adquiridas;
end;

end.