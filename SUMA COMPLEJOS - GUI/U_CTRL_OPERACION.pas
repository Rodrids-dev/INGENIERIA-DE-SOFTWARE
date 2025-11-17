  unit U_CTRL_OPERACION;
{$mode objfpc}{$H+}

interface

uses
  U_CL_NUM_COMPLEJO, U_CL_VISTA, SysUtils, Dialogs;

type
  CTRL_OPERACION = class
  public
    procedure click_btn_sumar;
    procedure click_btn_borrar;
  private
    obj_num_complejo1: CL_NUM_COMPLEJO;
    obj_num_complejo2: CL_NUM_COMPLEJO;
    obj_complejo_res: CL_NUM_COMPLEJO;
  end;

var
   obj_control: CTRL_OPERACION;

implementation

procedure CTRL_OPERACION.click_btn_sumar;
var
  v_img1, v_img2, v_real1, v_real2: Real;
begin
  obj_complejo_res:= CL_NUM_COMPLEJO.Create;
  obj_num_complejo2:= CL_NUM_COMPLEJO.Create;
  obj_num_complejo1:= CL_NUM_COMPLEJO.Create;
  // OBTENER VALORES REALES E IMAGINARIOS DE LOS NUMEROS
  v_real1 := StrToFloat(interfaz.get_ct_real1);
  v_img1 := StrToFloat(interfaz.get_ct_img1);
  v_real2 := StrToFloat(interfaz.get_ct_real2);
  v_img2 := StrToFloat(interfaz.get_ct_img2);

  // SETEAR VALORES
  obj_num_complejo1.set_parte_real(v_real1);
  obj_num_complejo1.set_parte_imaginaria(v_img1);

  obj_num_complejo2.set_parte_real(v_real2);
  obj_num_complejo2.set_parte_imaginaria(v_img2);

  // SUMAR COMPLEJOS
  obj_num_complejo2.sumar_complejo(obj_num_complejo1, obj_complejo_res);

  // OBTENER RESULTADOS DE obj_complejo_res
  v_real1 := obj_complejo_res.get_parte_real;
  v_img1 := obj_complejo_res.get_parte_imaginaria;

  // SETEAR EL RESULTADO A UNA CAJA DE TEXTO
  interfaz.ct_real_res.Text := FloatToStr(v_real1);
  interfaz.ct_img_res.Text := FloatToStr(v_img1);

  //DESTRUIR OBJETOS
  obj_num_complejo1.Free;
  obj_num_complejo2.Free;
  obj_complejo_res.Free;
end;

procedure CTRL_OPERACION.click_btn_borrar;
begin
  interfaz.ct_real1.Text := '';
  interfaz.ct_img1.Text := '';
  interfaz.ct_real2.Text := '';
  interfaz.ct_img2.Text := '';
  interfaz.ct_real_res.Text := '';
  interfaz.ct_img_res.Text := '';
end;

end.
