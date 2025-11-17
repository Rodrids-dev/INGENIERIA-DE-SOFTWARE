unit U_CL_Rectangulo;

{$mode objfpc}{$H+}

interface

uses
  U_Figura_Geometrica;

type
  { Clase CL_Rectangulo derivada de Figura_Geometrica }
  CL_RECTANGULO = class(FIGURA_GEOMETRICA)
  private
    largo: Real; // Atributo privado
    ancho: Real; // Atributo privado
  public
    // Métodos
    constructor Create(p_largo: Real; p_ancho: Real);
    procedure set_largo(x: Real);
    procedure set_ancho(x: Real);
    function get_largo: Real;
    function get_ancho: Real;
    procedure calcular_area_rec;
  end;

implementation

{ Implementación de los métodos }

constructor CL_RECTANGULO.Create(p_largo: Real; p_ancho: Real);
begin
  largo := p_largo;
  ancho := p_ancho;
end;

procedure CL_RECTANGULO.set_largo(x: Real);
begin
  largo := x;
end;

procedure CL_RECTANGULO.set_ancho(x: Real);
begin
  ancho := x;
end;

function CL_RECTANGULO.get_largo: Real;
begin
  Result := largo;
end;

function CL_RECTANGULO.get_ancho: Real;
begin
  Result := ancho;
end;

procedure CL_RECTANGULO.calcular_area_rec;
begin
  area := largo * ancho;
end;

end.
