program Calcular_Area;
{$mode objfpc}{$H+}

uses
  U_CL_VISTA, U_CL_CIRCULO, U_CL_TRIANGULO, U_CL_RECTANGULO, SysUtils, crt;

var
  margen_sup, margen_ver, encabezado, div_encabezado, margen_inf, cadena_vacia: string;
  v_opc: Integer;
  v_radio, v_base, v_altura, v_largo, v_ancho, v_area: Real;
  interfaz: CL_VISTA;
  obj_circulo: CL_CIRCULO;
  obj_triangulo: CL_TRIANGULO;
  obj_rectangulo: CL_RECTANGULO;

begin
  // INICIALIZO LAS VARIABLES CON LAS CADENAS QUE SE SETEAN A LA CLASE VISTA
  margen_sup := '********************************************************************************';
  margen_ver := '*';
  encabezado := '*                     CALCULAR AREAS DE FIGURAS GEOMETRICAS                   *';
  div_encabezado := '********************************************************************************';
  margen_inf := '********************************************************************************';
  cadena_vacia := '                                                  ';

  // INSTANCIA DE CL_VISTA
  interfaz := CL_VISTA.Create;
  interfaz.set_mensaje(margen_sup);
  interfaz.informar(1,1);
  interfaz.set_mensaje(margen_ver);
  interfaz.informar(1,2);
  interfaz.informar(80,2);
  interfaz.set_mensaje(encabezado);
  interfaz.informar(1,3);
  interfaz.set_mensaje(margen_ver);
  interfaz.informar(1,4);
  interfaz.informar(80,4);
  interfaz.set_mensaje(div_encabezado);
  interfaz.informar(1,5);
  interfaz.set_mensaje(margen_ver);
  interfaz.informar(1,6);
  interfaz.informar(1,7);
  interfaz.informar(1,8);
  interfaz.informar(1,9);
  interfaz.informar(1,10);
  interfaz.informar(1,11);
  interfaz.informar(1,12);
  interfaz.informar(1,13);
  interfaz.informar(1,14);
  interfaz.informar(1,15);
  interfaz.informar(1,16);
  interfaz.informar(1,17);
  interfaz.informar(1,18);
  interfaz.informar(1,19);
  interfaz.informar(80,6);
  interfaz.informar(80,7);
  interfaz.informar(80,8);
  interfaz.informar(80,9);
  interfaz.informar(80,10);
  interfaz.informar(80,11);
  interfaz.informar(80,12);
  interfaz.informar(80,13);
  interfaz.informar(80,14);
  interfaz.informar(80,15);
  interfaz.informar(80,16);
  interfaz.informar(80,17);
  interfaz.informar(80,18);
  interfaz.informar(80,19);
  interfaz.set_mensaje(margen_inf);
  interfaz.informar(1,20);
  interfaz.set_mensaje('MENU');
  interfaz.informar(39,7);
  interfaz.set_mensaje('1.- AREA DEL CIRCULO');
  interfaz.informar(25,9);
  interfaz.set_mensaje('2.- AREA DEL TRIANGULO');
  interfaz.informar(25,11);
  interfaz.set_mensaje('3.- AREA DEL RECTANGULO');
  interfaz.informar(25,13);
  interfaz.set_mensaje('INGRESE EL NUMERO DE LA OPERACION A REALIZAR: ');
  interfaz.informar(9,17);
  interfaz.recibir(55,17);
  v_opc := StrToInt(interfaz.get_dato);

  // SELECCIÓN MÚLTIPLE SEGÚN LO QUE SELECCIONE EL USUARIO
  case v_opc of
    1:
      begin
        interfaz.set_mensaje(cadena_vacia);
        interfaz.informar(9,7);
        interfaz.informar(9,9);
        interfaz.informar(9,11);
        interfaz.informar(9,13);
        interfaz.informar(9,17);
        interfaz.set_mensaje('CIRCULO');
        interfaz.informar(36,7);
        interfaz.set_mensaje('INGRESE EL VALOR DEL RADIO: ');
        interfaz.informar(19,10);
        interfaz.recibir(47,10);
        v_radio := StrToFloat(interfaz.get_dato);
        obj_circulo := CL_CIRCULO.Create(v_radio);
        obj_circulo.calcular_area_cir;
        v_area := obj_circulo.get_area;
        interfaz.set_mensaje('EL AREA DEL CIRCULO ES: ' + FloatToStr(v_area));
        interfaz.informar(19,14);
      end;
    2:
      begin
        interfaz.set_mensaje(cadena_vacia);
        interfaz.informar(9,7);
        interfaz.informar(9,9);
        interfaz.informar(9,11);
        interfaz.informar(9,13);
        interfaz.informar(9,17);
        interfaz.set_mensaje('TRIANGULO');
        interfaz.informar(34,7);
        interfaz.set_mensaje('INGRESE EL VALOR DE LA BASE: ');
        interfaz.informar(19,10);
        interfaz.set_mensaje('INGRESE EL VALOR DE LA ALTURA: ');
        interfaz.informar(19,12);
        interfaz.recibir(48,10);
        v_base := StrToFloat(interfaz.get_dato);
        interfaz.recibir(50,12);
        v_altura := StrToFloat(interfaz.get_dato);
        obj_triangulo := CL_TRIANGULO.Create(v_base, v_altura);
        obj_triangulo.calcular_area_tri;
        v_area := obj_triangulo.get_area;
        interfaz.set_mensaje('EL AREA DEL TRIANGULO ES: ' + FloatToStr(v_area));
        interfaz.informar(19,15);
      end;
    3:
      begin
        interfaz.set_mensaje(cadena_vacia);
        interfaz.informar(9,7);
        interfaz.informar(9,9);
        interfaz.informar(9,11);
        interfaz.informar(9,13);
        interfaz.informar(9,17);
        interfaz.set_mensaje('RECTANGULO');
        interfaz.informar(35,7);
        interfaz.set_mensaje('INGRESE EL VALOR DEL LARGO: ');
        interfaz.informar(19,10);
        interfaz.set_mensaje('INGRESE EL VALOR DEL ANCHO: ');
        interfaz.informar(19,12);
        interfaz.recibir(48,10);
        v_largo := StrToFloat(interfaz.get_dato);
        interfaz.recibir(50,12);
        v_ancho := StrToFloat(interfaz.get_dato);
        obj_rectangulo := CL_RECTANGULO.Create(v_largo, v_ancho);
        obj_rectangulo.calcular_area_rec;
        v_area := obj_rectangulo.get_area;
        interfaz.set_mensaje('EL AREA DEL RECTANGULO ES: ' + FloatToStr(v_area));
        interfaz.informar(19,16);
      end;
    else
      interfaz.set_mensaje('OPCION INVALIDA');
      interfaz.informar(39,19);
  end;

  interfaz.Free;
end.
