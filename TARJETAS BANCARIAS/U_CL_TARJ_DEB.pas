unit U_CL_TARJ_DEB;

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
  CL_TARJ_DEB = class(CL_TARJ_BANCARIA)
  private
    p_sobregiro: Real;
    capacidad_pago: Real;
  public
    procedure set_p_sobregiro(x: Real);
    procedure set_capacidad_pago(x: Real);
    function get_p_sobregiro: Real;
    function get_capacidad_pago: Real;
    procedure calc_capacidad_pago;
    function comparar_monto_y_cap_pago(monto_compra: Real): Boolean;
    procedure actualizar_saldo(monto_compra: Real);
  end;

implementation

procedure CL_TARJ_DEB.set_p_sobregiro(x: Real);
begin
  p_sobregiro := x;
end;

procedure CL_TARJ_DEB.set_capacidad_pago(x: Real);
begin
  capacidad_pago := x;
end;

function CL_TARJ_DEB.get_p_sobregiro: Real;
begin
  Result := p_sobregiro;
end;

function CL_TARJ_DEB.get_capacidad_pago: Real;
begin
  Result := capacidad_pago;
end;

procedure CL_TARJ_DEB.calc_capacidad_pago;
begin
  capacidad_pago := saldo_bancario + (saldo_bancario * p_sobregiro / 100);
end;

function CL_TARJ_DEB.comparar_monto_y_cap_pago(monto_compra: Real): Boolean;
var
  v_comparacion: Boolean;
begin
  if (monto_compra <= capacidad_pago) then
    v_comparacion := True
  else
    v_comparacion := False; 
  Result := v_comparacion;
end;

procedure CL_TARJ_DEB.actualizar_saldo(monto_compra: Real);
begin
  saldo_bancario := saldo_bancario - monto_compra;
end;

end.
