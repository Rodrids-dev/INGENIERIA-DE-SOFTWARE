unit U_CL_TARJ_BANCARIA;

{$mode objfpc}{$H+}

{
NOMBRE: RODRIGO DÍAZ SALGUERO
FECHA: 02/12/2024
ACTUALIZACIÓN: ---
}

interface

type
  CL_TARJ_BANCARIA = class
  protected
    saldo_bancario: Real;
    no_tarjeta: String;
  public
    procedure set_saldo_bancario(x: Real);
    function set_no_tarjeta(x: String): Boolean;
    function get_saldo_bancario: Real;
    function get_no_tarjeta: String;
  end;

implementation

procedure CL_TARJ_BANCARIA.set_saldo_bancario(x: Real);
begin
  saldo_bancario := x;
end;

function CL_TARJ_BANCARIA.set_no_tarjeta(x: String): Boolean;
var
  long_tarj: Integer;
begin
  long_tarj := Length(x);
  if (long_tarj = 16) then
  begin
	no_tarjeta := x;
    Result := True; 
  end
  else
    Result := False;
end;

function CL_TARJ_BANCARIA.get_saldo_bancario: Real;
begin
  Result := saldo_bancario;
end;

function CL_TARJ_BANCARIA.get_no_tarjeta: String;
begin
  Result := no_tarjeta;
end;

end.
