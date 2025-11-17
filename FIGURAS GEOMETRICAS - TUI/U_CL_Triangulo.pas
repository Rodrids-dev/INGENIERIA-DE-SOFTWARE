unit U_CL_Triangulo;

{$mode objfpc}{$H+}

interface

uses
  U_Figura_Geometrica;

type
  { Clase CL_Triangulo derivada de Figura_Geometrica }
  CL_TRIANGULO = class(FIGURA_GEOMETRICA)
  private
    base: Real;   // Atributo privado
    altura: Real; // Atributo privado
  public
    // Métodos
    constructor Create(p_base: Real; p_altura: Real);
    procedure set_base(x: Real);
    procedure set_altura(x: Real);
    function get_base: Real;
    function get_altura: Real;
    procedure calcular_area_tri;
  end;

implementation

{ Implementación de los métodos }

constructor CL_TRIANGULO.Create(p_base: Real; p_altura: Real);
begin
  base := p_base;
  altura := p_altura;
end;

procedure CL_TRIANGULO.set_base(x: Real);
begin
  base := x;
end;

procedure CL_TRIANGULO.set_altura(x: Real);
begin
  altura := x;
end;

function CL_TRIANGULO.get_base: Real;
begin
  Result := base;
end;

function CL_TRIANGULO.get_altura: Real;
begin
  Result := altura;
end;

procedure CL_TRIANGULO.calcular_area_tri;
begin
  area := (base * altura) / 2;
end;

end.
