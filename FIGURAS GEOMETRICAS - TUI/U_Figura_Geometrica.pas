unit U_Figura_Geometrica;

{$mode objfpc}{$H+}

interface

type
  { Clase Figura_Geometrica }
  FIGURA_GEOMETRICA = class
  protected
    area: Real; // Atributo protegido
  public
    // Métodos
    procedure set_area(x: Real);
    function get_area: Real;
  end;

implementation

{ Implementación de los métodos }

procedure FIGURA_GEOMETRICA.set_area(x: Real);
begin
  area := x;
end;

function FIGURA_GEOMETRICA.get_area: Real;
begin
  Result := area;
end;

end.
