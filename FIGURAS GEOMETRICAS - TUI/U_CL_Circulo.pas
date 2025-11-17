unit U_CL_Circulo;

{$mode objfpc}{$H+}

interface

uses
  U_Figura_Geometrica;

type
  { Clase CL_Circulo derivada de Figura_Geometrica }
  CL_CIRCULO = class(FIGURA_GEOMETRICA)
  private
    r: Real; // Atributo privado
  public
    // Métodos
    constructor Create(radio: Real);
    procedure set_r(x: Real);
    function get_r: Real;
    procedure calcular_area_cir;
  end;

implementation

{ Implementación de los métodos }

constructor CL_CIRCULO.Create(radio: Real);
begin
  r := radio;
end;

procedure CL_CIRCULO.set_r(x: Real);
begin
  r := x;
end;

function CL_CIRCULO.get_r: Real;
begin
  Result := r;
end;

procedure CL_CIRCULO.calcular_area_cir;
begin
  area := Pi * r * r;
end;

end.
