 unit U_CL_NUM_COMPLEJO;
{$mode objfpc}{$H+}

interface

type
  CL_NUM_COMPLEJO = class
  private
    parte_real: Real;
    parte_imaginaria: Real;
  public
    procedure set_parte_real(x: Real);
    procedure set_parte_imaginaria(x: Real);
    function get_parte_real: Real;
    function get_parte_imaginaria: Real;
    procedure sumar_complejo(x: CL_NUM_COMPLEJO; y: CL_NUM_COMPLEJO);
  end;

implementation

procedure CL_NUM_COMPLEJO.set_parte_real(x: Real);
begin
  parte_real := x;
end;

procedure CL_NUM_COMPLEJO.set_parte_imaginaria(x: Real);
begin
  parte_imaginaria := x;
end;

function CL_NUM_COMPLEJO.get_parte_real: Real;
begin
  Result := parte_real;
end;

function CL_NUM_COMPLEJO.get_parte_imaginaria: Real;
begin
  Result := parte_imaginaria;
end;

procedure CL_NUM_COMPLEJO.sumar_complejo(x: CL_NUM_COMPLEJO; y: CL_NUM_COMPLEJO);
begin
  y.set_parte_real(parte_real + x.get_parte_real);
  y.set_parte_imaginaria(parte_imaginaria + x.get_parte_imaginaria);
end;

end.
