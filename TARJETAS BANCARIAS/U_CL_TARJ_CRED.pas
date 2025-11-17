unit U_CL_TARJ_CRED;

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
  CL_TARJ_CRED = class(CL_TARJ_BANCARIA)
  private
    lim_cred: Real;
    taza_int: Real;
  public
    procedure set_lim_cred(x: Real);
    procedure set_taza_int(x: Real);
    function get_lim_cred: Real;
    function get_taza_int: Real;
    function calc_monto_total(monto_compra: Real): Real;
    function comparar_saldo_y_credito(monto_total: Real): Boolean;
    procedure actualizar_saldo(monto_total: Real);
  end;

implementation

procedure CL_TARJ_CRED.set_lim_cred(x: Real);
begin
  lim_cred := x;
end;

procedure CL_TARJ_CRED.set_taza_int(x: Real);
begin
  taza_int := x;
end;

function CL_TARJ_CRED.get_lim_cred: Real;
begin
  Result := lim_cred;
end;

function CL_TARJ_CRED.get_taza_int: Real;
begin
  Result := taza_int;
end;

function CL_TARJ_CRED.calc_monto_total(monto_compra: Real): Real;
var
  monto_total: Real;
begin
  monto_total := monto_compra + (monto_compra * taza_int / 100);
  Result := monto_total;
end;

function CL_TARJ_CRED.comparar_saldo_y_credito(monto_total: Real): Boolean;
var
  v_comparacion: Boolean;
  v_nuevo_saldo: Real;
begin
  v_nuevo_saldo := saldo_bancario + monto_total;
  if (v_nuevo_saldo <= lim_cred) then
    v_comparacion := True
  else
    v_comparacion := False; 
  Result := v_comparacion;
end;

procedure CL_TARJ_CRED.actualizar_saldo(monto_total: Real);
begin
  saldo_bancario := saldo_bancario + monto_total;
end;

end.
