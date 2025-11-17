unit U_CL_PRODUCTO;
{$mode objfpc}{$H+}

interface

uses
    SysUtils;

type
  CL_PRODUCTO = class
  private
    Clave: Integer;
    Nombre: String;
    Precio: Real;
  public
    constructor Create(clv: Integer; nom: String; prc: Real);
    procedure set_Clave(x: Integer);
    procedure set_Nombre(x: String);
    procedure set_Precio(x: Real);
    function get_Clave: Integer;
    function get_Nombre: String;
    function get_Precio: Real;
  end;

implementation

constructor CL_PRODUCTO.Create(clv: Integer; nom: String; prc: Real);
begin
  Self.Clave := clv;
  Self.Nombre := nom;
  Self.Precio := prc;
end;

procedure CL_PRODUCTO.set_Clave(x: Integer);
begin
  Clave := x;
end;

procedure CL_PRODUCTO.set_Nombre(x: String);
begin
  Nombre := x;
end;

procedure CL_PRODUCTO.set_Precio(x: Real);
begin
  Precio := x;
end;

function CL_PRODUCTO.get_Clave: Integer;
begin
  Result := Clave;
end;

function CL_PRODUCTO.get_Nombre: String;
begin
  Result := Nombre;
end;

function CL_PRODUCTO.get_Precio: Real;
begin
  Result := Precio;
end;

end.
