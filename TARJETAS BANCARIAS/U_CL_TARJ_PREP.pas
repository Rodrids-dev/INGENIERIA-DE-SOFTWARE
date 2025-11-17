unit U_CL_TARJ_PREP;

{$mode objfpc}{$H+}

{
NOMBRE: RODRIGO DÍAZ SALGUERO
FECHA: 02/12/2024
ACTUALIZACIÓN: ---
}

interface

uses
  U_CL_TARJ_BANCARIA;

type
  CL_TARJ_PREP = class(CL_TARJ_BANCARIA)
  public
    function comparar_monto_y_saldo(monto_compra: Real): Boolean;
    procedure actualizar_saldo(monto_compra: Real);
  end;

implementation

function CL_TARJ_PREP.comparar_monto_y_saldo(monto_compra: Real): Boolean;
var
  v_comparacion: Boolean;
begin
  if (monto_compra <= saldo_bancario) then
    v_comparacion := True
  else
    v_comparacion := False; 
  Result := v_comparacion;
end;

procedure CL_TARJ_PREP.actualizar_saldo(monto_compra: Real);
begin
  saldo_bancario := saldo_bancario - monto_compra;
end;

end.
