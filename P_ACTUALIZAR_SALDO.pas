program P_ACTUALIZAR_SALDO;
{$mode objfpc}{$H+}

uses
  crt, U_CL_VISTA, U_CL_TARJ_CRED, U_CL_TARJ_DEB, U_CL_TARJ_PREP, SysUtils;

var
  titulo_marco: string;
  v_opc: Integer;
  v_no_tarj: string;
  v_valid_tarj: boolean;
  v_lim_cred, v_taza_int, v_saldo, v_monto_c, v_monto_tot, v_sobregiro, v_cap_pago: Real;
  v_comparacion: boolean;

  interfaz: CL_VISTA;
  obj_cred: CL_TARJ_CRED;
  obj_deb: CL_TARJ_DEB;
  obj_prep: CL_TARJ_PREP;

begin
  interfaz := CL_VISTA.Create;
  obj_cred := CL_TARJ_CRED.Create;
  obj_deb := CL_TARJ_DEB.Create;
  obj_prep := CL_TARJ_PREP.Create;

  repeat
    titulo_marco := '*                                 COMPRAR                                 *';
    interfaz.crear_marco(titulo_marco);
    interfaz.set_mensaje('SELECCIONE LA OPCIÓN QUE CORRESPONDA A SU TARJETA BANCARIA');
    interfaz.informar(11, 11);
    interfaz.set_mensaje('1.- TARJETA DE CRÉDITO');
    interfaz.informar(25, 14);
    interfaz.set_mensaje('2.- TARJETA DE DÉBITO');
    interfaz.informar(25, 16);
    interfaz.set_mensaje('3.- TARJETA DE PREPAGO');
    interfaz.informar(25, 18);
    interfaz.set_mensaje('4.- SALIR');
    interfaz.informar(25, 20);
    interfaz.set_mensaje('DIGITE LA OPCIÓN QUE ELIGIÓ:');
    interfaz.informar(17, 23);
    interfaz.recibir(46, 23);
    v_opc := StrToInt(interfaz.get_dato);

    case v_opc of
      1: begin
        titulo_marco := '*                             TARJETA DE CRÉDITO                             *';
        interfaz.crear_marco(titulo_marco);
        interfaz.set_mensaje('INGRESE SU NÚMERO DE TARJETA:');
        interfaz.informar(9, 17);
        interfaz.recibir(39, 17);
        v_no_tarj := interfaz.get_dato;
        v_valid_tarj := obj_cred.set_no_tarjeta(v_no_tarj);

        if v_valid_tarj then begin
          interfaz.crear_marco(titulo_marco);
          interfaz.set_mensaje('LIMITE DE CREDITO:');
          interfaz.informar(9, 12);
          interfaz.set_mensaje('TAZA DE INTERÉS MENSUAL:');
          interfaz.informar(9, 15);
          interfaz.set_mensaje('SALDO ACTUAL:');
          interfaz.informar(9, 18);
          interfaz.set_mensaje('MONTO DE LA COMPRA:');
          interfaz.informar(9, 21);
          interfaz.set_mensaje('MONTO MÁS INTERÉS:');
          interfaz.informar(44, 21);
          interfaz.recibir(28, 12);
          v_lim_cred := StrToFloat(interfaz.get_dato);
          interfaz.recibir(34, 15);
          v_taza_int := StrToFloat(interfaz.get_dato);
          interfaz.recibir(23, 18);
          v_saldo := StrToFloat(interfaz.get_dato);
          interfaz.recibir(29, 21);
          v_monto_c := StrToFloat(interfaz.get_dato);

          obj_cred.set_lim_cred(v_lim_cred);
          obj_cred.set_taza_int(v_taza_int);
          obj_cred.set_saldo_bancario(v_saldo);
          v_monto_tot := obj_cred.calc_monto_total(v_monto_c);
          v_comparacion := obj_cred.comparar_saldo_y_credito(v_monto_tot);
          interfaz.set_mensaje(FloatToStr(v_monto_tot));
          interfaz.informar(63, 21);

          if v_comparacion then begin
            obj_cred.actualizar_saldo(v_monto_tot);
            v_saldo := obj_cred.get_saldo_bancario;
            interfaz.set_mensaje('SU SALDO SE HA ACTUALIZADO CORRECTAMENTE A $' + FloatToStr(v_saldo) + ' mxn');
            interfaz.informar(9, 24);
            interfaz.set_mensaje('PRESIONA ENTER PARA REGRESAR AL MENÚ PRINCIPAL');
            interfaz.informar(9, 27);
            interfaz.recibir(55, 27);
          end else begin
            interfaz.crear_marco(titulo_marco);
            interfaz.set_mensaje('COMPRA RECHAZADA POR REVASAR EL LÍMITE DE CRÉDITO');
            interfaz.informar(17, 18);
            interfaz.set_mensaje('PRESIONA ENTER PARA REGRESAR AL MENÚ PRINCIPAL');
            interfaz.informar(9, 27);
            interfaz.recibir(55, 27);
          end;
        end else begin
          interfaz.crear_marco(titulo_marco);
          interfaz.set_mensaje('EL NÚMERO DE TARJETA PROPORCIONADO ES INCORRECTO');
          interfaz.informar(17, 17);
          interfaz.set_mensaje('FAVOR DE INTENTAR NUEVAMENTE');
          interfaz.informar(25, 18);
          interfaz.set_mensaje('PRESIONA ENTER PARA REGRESAR AL MENÚ PRINCIPAL');
          interfaz.informar(9, 27);
          interfaz.recibir(55, 27);
        end;
      end;
      2: begin
        titulo_marco := '*                            TARJETA DE DÉBITO                                 *';
        interfaz.crear_marco(titulo_marco);
        interfaz.set_mensaje('INGRESE SU NÚMERO DE TARJETA:');
        interfaz.informar(9, 17);
        interfaz.recibir(39, 17);
        v_no_tarj := interfaz.get_dato;
        v_valid_tarj := obj_deb.set_no_tarjeta(v_no_tarj);

        if v_valid_tarj = True then
        begin
          interfaz.crear_marco(titulo_marco);
          interfaz.set_mensaje('PORCENTAJE DE CAPACIDAD DE SOBREGIRO:');
          interfaz.informar(9, 12);
          interfaz.set_mensaje('SALDO ACTUAL:');
          interfaz.informar(9, 15);
          interfaz.set_mensaje('MÁXIMA CAPACIDAD DE PAGO:');
          interfaz.informar(9, 18);
          interfaz.set_mensaje('MONTO DE LA COMPRA:');
          interfaz.informar(9, 21);
          interfaz.recibir(47, 12);
          v_sobregiro := StrToFloat(interfaz.get_dato);
          interfaz.recibir(23, 15);
          v_saldo := StrToFloat(interfaz.get_dato);
          obj_deb.set_p_sobregiro(v_sobregiro);
          obj_deb.set_saldo_bancario(v_saldo);
          obj_deb.calc_capacidad_pago;
          v_cap_pago := obj_deb.get_capacidad_pago;
          interfaz.set_mensaje('$' + FloatToStr(v_cap_pago));
          interfaz.informar(35, 18);
          interfaz.recibir(29, 21);
          v_monto_c := StrToFloat(interfaz.get_dato);
          v_comparacion := obj_deb.comparar_monto_y_cap_pago(v_monto_c);

          if v_comparacion = True then
          begin
            obj_deb.actualizar_saldo(v_monto_c);
            v_saldo := obj_deb.get_saldo_bancario;
            interfaz.set_mensaje('SU SALDO SE HA ACTUALIZADO CORRECTAMENTE A $' + FloatToStr(v_saldo) + ' mxn');
            interfaz.informar(9, 24);
            interfaz.set_mensaje('PRESIONA ENTER PARA REGRESAR AL MENÚ PRINCIPAL');
            interfaz.informar(9, 27);
            interfaz.recibir(55, 27);
          end
          else
          begin
            interfaz.crear_marco(titulo_marco);
            interfaz.set_mensaje('COMPRA RECHAZADA POR REBASAR LA CAPACIDAD DE PAGO');
            interfaz.informar(17, 18);
            interfaz.set_mensaje('PRESIONA ENTER PARA REGRESAR AL MENÚ PRINCIPAL');
            interfaz.informar(9, 27);
            interfaz.recibir(55, 27);
          end;
        end
        else
        begin
          interfaz.crear_marco(titulo_marco);
          interfaz.set_mensaje('EL NÚMERO DE TARJETA PROPORCIONADO ES INCORRECTO');
          interfaz.informar(17, 17);
          interfaz.set_mensaje('FAVOR DE INTENTAR NUEVAMENTE');
          interfaz.informar(25, 18);
          interfaz.set_mensaje('PRESIONA ENTER PARA REGRESAR AL MENÚ PRINCIPAL');
          interfaz.informar(9, 27);
          interfaz.recibir(55, 27);
        end;
      end;

      3: begin
        titulo_marco := '*                            TARJETA DE PREPAGO                              *';
        interfaz.crear_marco(titulo_marco);
        interfaz.set_mensaje('INGRESE SU NÚMERO DE TARJETA:');
        interfaz.informar(9, 17);
        interfaz.recibir(39, 17);
        v_no_tarj := interfaz.get_dato;
        v_valid_tarj := obj_prep.set_no_tarjeta(v_no_tarj);

        if v_valid_tarj = True then
        begin
          interfaz.crear_marco(titulo_marco);
          interfaz.set_mensaje('SALDO ACTUAL:');
          interfaz.informar(9, 14);
          interfaz.set_mensaje('MONTO DE COMPRA:');
          interfaz.informar(9, 18);
          interfaz.recibir(23, 14);
          v_saldo := StrToFloat(interfaz.get_dato);
          interfaz.recibir(26, 18);
          v_monto_c := StrToFloat(interfaz.get_dato);
          obj_prep.set_saldo_bancario(v_saldo);
          v_comparacion := obj_prep.comparar_monto_y_saldo(v_monto_c);

          if v_comparacion = True then
          begin
            obj_prep.actualizar_saldo(v_monto_c);
            v_saldo := obj_prep.get_saldo_bancario;
            interfaz.set_mensaje('SU SALDO SE HA ACTUALIZADO CORRECTAMENTE A $' + FloatToStr(v_saldo) + ' mxn');
            interfaz.informar(9, 24);
            interfaz.set_mensaje('PRESIONA ENTER PARA REGRESAR AL MENÚ PRINCIPAL');
            interfaz.informar(9, 27);
            interfaz.recibir(55, 27);
          end
          else
          begin
            interfaz.crear_marco(titulo_marco);
            interfaz.set_mensaje('COMPRA RECHAZADA POR SALDO INSUFICIENTE');
            interfaz.informar(17, 18);
            interfaz.set_mensaje('PRESIONA ENTER PARA REGRESAR AL MENÚ PRINCIPAL');
            interfaz.informar(9, 27);
            interfaz.recibir(55, 27);
          end;
        end
        else
        begin
          interfaz.crear_marco(titulo_marco);
          interfaz.set_mensaje('EL NÚMERO DE TARJETA PROPORCIONADO ES INCORRECTO');
          interfaz.informar(17, 17);
          interfaz.set_mensaje('FAVOR DE INTENTAR NUEVAMENTE');
          interfaz.informar(25, 18);
          interfaz.set_mensaje('PRESIONA ENTER PARA REGRESAR AL MENÚ PRINCIPAL');
          interfaz.informar(9, 27);
          interfaz.recibir(55, 27);
        end;
      end;
    end;
  until v_opc = 4;
end.
