unit CL_IUSR_02;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, cl_iconf_01, U_CL_PRODUCTO, U_GESTOR_ARCH_PRODUCTO, U_CL_VISTA_MENSAJE;

type

  { TIUSR_02 }

  TIUSR_02 = class(TForm)
    btn_cerrar: TButton;
    btn_buscar_producto: TButton;
    ct_clave_producto: TEdit;
    ct_porcentaje_fisico_p: TEdit;
    ct_nombre_producto: TEdit;
    ct_porcentaje_logico_p: TEdit;
    ct_precio_producto: TEdit;
    ct_buscar_clave_prod: TEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label2: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel1: TPanel;
    panel_crud_productos: TPanel;
    btn_agg_producto: TSpeedButton;
    btn_modif_producto: TSpeedButton;
    btn_elim_producto: TSpeedButton;
    procedure evt_agg_producto(Sender: TObject);
    procedure evt_buscar_producto(Sender: TObject);
    procedure evt_cerrar(Sender: TObject);
    procedure evt_elim_producto(Sender: TObject);
    procedure evt_modif_producto(Sender: TObject);
  private

  public

  end;

var
  IUSR_02: TIUSR_02;

implementation

{$R *.lfm}

{ CONTROL}

procedure TIUSR_02.evt_cerrar(Sender: TObject);
begin
  IUSR_02.Close;
end;

procedure TIUSR_02.evt_elim_producto(Sender: TObject);
var
  v_conf: Integer;
  v_clave: String;
  mensaje: CL_VISTA_MENSAJE;
  gestor: GESTOR_ARCH_PRODUCTO;
  v_producto_eliminado:Boolean;
  v_diferencia: Real;
begin
  mensaje:=CL_VISTA_MENSAJE.Create;
  gestor:=GESTOR_ARCH_PRODUCTO.Create;
  ICONF_01.lbl_pregunta.Caption:='¿Estas seguro que deseas eliminar el producto'+LineEnding+'encontrado del registro?';
  v_conf:=ICONF_01.ShowModal;
  If v_conf=mrYes then
  begin
    ICONF_01.Close;
    v_clave:=(IUSR_02.ct_clave_producto.Text);
    If NOT(v_clave='') then
    begin
      If(Length(v_clave)=4) then
      begin
        v_producto_eliminado:=gestor.eliminar_producto(StrToInt(v_clave));
        If NOT(v_producto_eliminado=True) then
        begin
          mensaje.set_mensaje('El producto que intentas eliminar no existe, verifica la clave del producto.');
	  mensaje.mostrar_mensaje;
        end else
        begin
          mensaje.set_mensaje('Producto eliminado satisfactoriamente.');
	  mensaje.mostrar_mensaje;
          IUSR_02.ct_clave_producto.Text:='';
          IUSR_02.ct_nombre_producto.Text:='';
          IUSR_02.ct_precio_producto.Text:='';
          IUSR_02.ct_buscar_clave_prod.Text:='';
          gestor.obtener_porcentaje_uso_log(110);
          gestor.obtener_porcentaje_uso_fis(110);
          IUSR_02.ct_porcentaje_logico_p.Text:=FloatToStr(gestor.get_porcentaje_uso_log);
          IUSR_02.ct_porcentaje_fisico_p.Text:=FloatToStr(gestor.get_porcentaje_uso_fis);
          v_diferencia:=gestor.obtener_diferencia_uso;
          If v_diferencia>=50 then
          begin
              ICONF_01.lbl_pregunta.Caption:='¿Deseas realizar un borrado físico de'+LineEnding+
                                               'los registros lógicamente eliminados?';
              v_conf:=ICONF_01.ShowModal;
              If v_conf=mrYes then
              begin
                ICONF_01.Close;
                gestor.borrado_fisico;
                gestor.obtener_porcentaje_uso_fis(110);
                IUSR_02.ct_porcentaje_fisico_p.Text:=FloatToStr(gestor.get_porcentaje_uso_fis);
              end else
              begin
                ICONF_01.Close;
              end;
          end;
        end;
      end else
      begin
        mensaje.set_mensaje('La clave del producto debe ser un número entero con 4 digitos');
	mensaje.mostrar_mensaje;
      end;
    end else
    begin
      mensaje.set_mensaje('Verifica haber buscado un producto, para poder eliminarlo del registro.');
      mensaje.mostrar_mensaje;
    end;
  end else
  begin
    ICONF_01.Close;
    IUSR_02.ct_clave_producto.Text:='';
    IUSR_02.ct_nombre_producto.Text:='';
    IUSR_02.ct_precio_producto.Text:='';
    IUSR_02.ct_buscar_clave_prod.Text:='';
  end;
  mensaje.Free;
  gestor.Free;
end;

procedure TIUSR_02.evt_agg_producto(Sender: TObject);
var
  v_conf: Integer;
  v_nombre, v_clave, v_precio: String;
  mensaje: CL_VISTA_MENSAJE;
  producto: CL_PRODUCTO;
  gestor: GESTOR_ARCH_PRODUCTO;
  v_producto_guardado:Boolean;
  v_diferencia: Real;
begin
  mensaje:=CL_VISTA_MENSAJE.Create;
  gestor:=GESTOR_ARCH_PRODUCTO.Create;
  ICONF_01.lbl_pregunta.Caption:='¿Estas seguro que deseas agregar el producto'+LineEnding+'proporcionado al registro?';
  v_conf:=ICONF_01.ShowModal;
  If v_conf=mrYes then
  begin
    ICONF_01.Close;
    v_clave:=(IUSR_02.ct_clave_producto.Text);
    v_nombre:=IUSR_02.ct_nombre_producto.Text;
    v_precio:=(IUSR_02.ct_precio_producto.Text);
    If NOT(v_clave='') AND NOT(v_nombre='') AND NOT(v_precio='') then
    begin
      If(Length(v_clave)=4) then
      begin
        producto:=CL_PRODUCTO.Create(StrToInt(v_clave),v_nombre,StrToFloat(v_precio));
        v_producto_guardado:=gestor.guardar_producto(producto);
        producto.Free;
        If NOT(v_producto_guardado=True) then
        begin
          mensaje.set_mensaje('El producto que intentas guardar ya existe, verifica la clave del producto.');
	  mensaje.mostrar_mensaje;
        end else
        begin
          mensaje.set_mensaje('Producto guardado satisfactoriamente.');
	  mensaje.mostrar_mensaje;
          IUSR_02.ct_clave_producto.Text:='';
          IUSR_02.ct_nombre_producto.Text:='';
          IUSR_02.ct_precio_producto.Text:='';
          gestor.obtener_porcentaje_uso_log(110);
          gestor.obtener_porcentaje_uso_fis(110);
          IUSR_02.ct_porcentaje_logico_p.Text:=FloatToStr(gestor.get_porcentaje_uso_log);
          IUSR_02.ct_porcentaje_fisico_p.Text:=FloatToStr(gestor.get_porcentaje_uso_fis);
          v_diferencia:=gestor.obtener_diferencia_uso;
          If v_diferencia>=50 then
          begin
              ICONF_01.lbl_pregunta.Caption:='¿Deseas realizar un borrado físico de'+LineEnding+
                                               'los registros lógicamente eliminados?';
              v_conf:=ICONF_01.ShowModal;
              If v_conf=mrYes then
              begin
                ICONF_01.Close;
                gestor.borrado_fisico;
                gestor.obtener_porcentaje_uso_fis(110);
                IUSR_02.ct_porcentaje_fisico_p.Text:=FloatToStr(gestor.get_porcentaje_uso_fis);
              end else
              begin
                ICONF_01.Close;
              end;
          end;
        end;
      end else
      begin
        mensaje.set_mensaje('La clave del producto debe ser un número entero con 4 digitos');
	mensaje.mostrar_mensaje;
      end;
    end else
    begin
      mensaje.set_mensaje('Verifica llenar los campos CLAVE, NOMBRE y PRECIO, para poder agregar un producto.');
      mensaje.mostrar_mensaje;
    end;
  end else
  begin
    ICONF_01.Close;
    IUSR_02.ct_clave_producto.Text:='';
    IUSR_02.ct_nombre_producto.Text:='';
    IUSR_02.ct_precio_producto.Text:='';
  end;
  mensaje.Free;
  gestor.Free;
end;

procedure TIUSR_02.evt_buscar_producto(Sender: TObject);
var
  v_buscar_producto,v_clave,v_nombre,v_precio:String;
  mensaje: CL_VISTA_MENSAJE;
  gestor: GESTOR_ARCH_PRODUCTO;
  producto: CL_PRODUCTO;
  v_encontrado: Boolean;
begin
  mensaje:=CL_VISTA_MENSAJE.Create;
  gestor:=GESTOR_ARCH_PRODUCTO.Create;
  v_buscar_producto:=IUSR_02.ct_buscar_clave_prod.Text;
  If NOT(v_buscar_producto='') then
  begin
     If(Length(v_buscar_producto)=4) then
     begin
       producto:=CL_PRODUCTO.Create(0,'',0);
       v_encontrado:=gestor.consultar_producto(StrToInt(v_buscar_producto),producto);
       If v_encontrado=True then
       begin
         mensaje.set_mensaje('Producto encontrado.');
	 mensaje.mostrar_mensaje;
	 v_clave:= IntToStr(producto.get_Clave);
	 v_nombre:= producto.get_Nombre;
	 v_precio:= FloatToStr(producto.get_Precio);
         IUSR_02.ct_clave_producto.Text:=v_clave;
         IUSR_02.ct_nombre_producto.Text:=v_nombre;
         IUSR_02.ct_precio_producto.Text:=v_precio;
         producto.Free;
       end else
       begin
         mensaje.set_mensaje('El producto no ha sido encontrado');
	 mensaje.mostrar_mensaje;
         IUSR_02.ct_clave_producto.Text:='';
         IUSR_02.ct_nombre_producto.Text:='';
         IUSR_02.ct_precio_producto.Text:='';
       end;
     end else
     begin
       mensaje.set_mensaje('Verifica que la clave del producto que estás buscando tenga 4 dígitos');
       mensaje.mostrar_mensaje;
     end;
  end else
  begin
    mensaje.set_mensaje('Para buscar un producto ingresa la clave del producto en el campo de la parte inferiror');
    mensaje.mostrar_mensaje;
  end;
  mensaje.Free;
  gestor.Free;
end;

procedure TIUSR_02.evt_modif_producto(Sender: TObject);
var
  gestor: GESTOR_ARCH_PRODUCTO;
  producto: CL_PRODUCTO;
  mensaje: CL_VISTA_MENSAJE;
  v_conf: Integer;
  v_clave_nueva,v_nombre_nuevo,v_precio_nuevo,
  v_clave_anterior,instrucciones: String;
  v_existe_producto_nuevo, v_existe_producto_anterior,r: Boolean;
  v_diferencia: Real;
begin
  mensaje:=CL_VISTA_MENSAJE.Create;
  gestor:=GESTOR_ARCH_PRODUCTO.Create;
  instrucciones := 'Para poder modificar un registro;'+LineEnding+
  '1.- Busca el producto a modificar'+LineEnding+
  '2.- Realiza los cambios en los 3 campos de la izquierda'+LineEnding+
  '3.- Da click en el botón "Modificar"'+LineEnding+
  '4.- Da click en "Aceptar"'+LineEnding+
  'Nota: El registro a modificar será el buscado en al campo de la parte inferior.';
  mensaje.set_mensaje(instrucciones);
  mensaje.mostrar_mensaje;
  v_conf := ICONF_01.ShowModal;
  If v_conf=mrYes then
  begin
     v_clave_nueva := IUSR_02.ct_clave_producto.Text;
     v_nombre_nuevo := IUSR_02.ct_nombre_producto.Text;
     v_precio_nuevo := IUSR_02.ct_precio_producto.Text;
     v_clave_anterior := IUSR_02.ct_buscar_clave_prod.Text;
     If NOT((v_clave_nueva='') AND (v_nombre_nuevo='') AND (v_precio_nuevo='') AND (v_clave_anterior='')) AND ((Length(v_clave_nueva)=4) AND (Length(v_clave_anterior)=4)) then
     begin
        If v_clave_nueva=v_clave_anterior then
        begin
           producto:=CL_PRODUCTO.Create(0,'',0);
	   v_existe_producto_anterior := gestor.consultar_producto(StrToInt(v_clave_anterior),producto);
           producto.Free;
	   If v_existe_producto_anterior = True then
           begin
	      producto:=CL_PRODUCTO.Create(StrToInt(v_clave_nueva),v_nombre_nuevo,StrToFloat(v_precio_nuevo));
	      r:=gestor.eliminar_producto(StrToInt(v_clave_anterior));
	      r:=gestor.guardar_producto(producto);
	      producto.Free;
              IUSR_02.ct_clave_producto.Text:='';
              IUSR_02.ct_nombre_producto.Text:='';
              IUSR_02.ct_precio_producto.Text:='';
              IUSR_02.ct_buscar_clave_prod.Text:='';
              mensaje.set_mensaje('Producto modificado satisfactoriamente.');
              mensaje.mostrar_mensaje;
	      gestor.obtener_porcentaje_uso_log(110);
	      gestor.obtener_porcentaje_uso_fis(110);
	      v_diferencia := gestor.obtener_diferencia_uso;
	      IUSR_02.ct_porcentaje_logico_p.Text:=FloatToStr(gestor.get_porcentaje_uso_log);
	      IUSR_02.ct_porcentaje_fisico_p.Text:=FloatToStr(gestor.get_porcentaje_uso_fis);
	      If v_diferencia>=50 then
              begin
	         ICONF_01.lbl_pregunta.Caption:='¿Desea realizar un borrado físico de los registros lógicamente eliminados del archivo?';
		 v_conf := ICONF_01.ShowModal;
		 If v_conf=mrYes then
                 begin
		    ICONF_01.Close;
		    gestor.borrado_fisico;
		    gestor.obtener_porcentaje_uso_fis(110);
		    IUSR_02.ct_porcentaje_fisico_p.Text:=FloatToStr(gestor.get_porcentaje_uso_fis);
		 end else
                 begin
		    ICONF_01.Close;
		 end;
	      end;
	   end else
           begin
	      mensaje.set_mensaje('El producto que está intentando modificar no existe, asegurese de buscar un producto correctamente.');
	      mensaje.mostrar_mensaje;
	   end;
	end else
        begin
           producto:=CL_PRODUCTO.Create(0,'',0);
	   v_existe_producto_nuevo := gestor.consultar_producto(StrToInt(v_clave_nueva),producto);
	   v_existe_producto_anterior := gestor.consultar_producto(StrToInt(v_clave_anterior),producto);
           producto.Free;
	   If v_existe_producto_anterior=True then
           begin
	      If v_existe_producto_nuevo=False then
              begin
	         producto:=CL_PRODUCTO.Create(StrToInt(v_clave_nueva),v_nombre_nuevo,StrToFloat(v_precio_nuevo));
		 r:=gestor.eliminar_producto(StrToInt(v_clave_anterior));
		 r:=gestor.guardar_producto(producto);
		 producto.Free;
                 IUSR_02.ct_clave_producto.Text:='';
                 IUSR_02.ct_nombre_producto.Text:='';
                 IUSR_02.ct_precio_producto.Text:='';
                 IUSR_02.ct_buscar_clave_prod.Text:='';
                 mensaje.set_mensaje('Producto modificado satisfactoriamente.');
                 mensaje.mostrar_mensaje;
		 gestor.obtener_porcentaje_uso_log(110);
		 gestor.obtener_porcentaje_uso_fis(110);
		 v_diferencia := gestor.obtener_diferencia_uso;
		 IUSR_02.ct_porcentaje_logico_p.Text:=FloatToStr(gestor.get_porcentaje_uso_log);
	         IUSR_02.ct_porcentaje_fisico_p.Text:=FloatToStr(gestor.get_porcentaje_uso_fis);
		 If v_diferencia>=50 then
                 begin
	              ICONF_01.lbl_pregunta.Caption:='¿Desea realizar un borrado físico de los registros lógicamente eliminados del archivo?';
		      v_conf := ICONF_01.ShowModal;
		      If v_conf=mrYes then
                      begin
		           ICONF_01.Close;
		           gestor.borrado_fisico;
		           gestor.obtener_porcentaje_uso_fis(110);
		           IUSR_02.ct_porcentaje_fisico_p.Text:=FloatToStr(gestor.get_porcentaje_uso_fis);
		      end else
                      begin
		           ICONF_01.Close;
		      end;
	         end;
	      end else
              begin
	         mensaje.set_mensaje('El producto con clave '+v_clave_nueva+' ya existe, verifica tu modificación.');
		 mensaje.mostrar_mensaje;
	      end;
	   end else
           begin
	      mensaje.set_mensaje('El producto que intentas modificar no existe, verifica que hayas buscado el producto correctamente.');
	      mensaje.mostrar_mensaje;
	   end;
	end;
     end else
     begin
        mensaje.set_mensaje('Verifica haber buscado el producto correctamente, la clave del producto a modificar y la clave nueva deben de ser numeros enteros de 4 dígitos.');
	mensaje.mostrar_mensaje;
     end;
  end else
  begin
     ICONF_01.Close;
  end;
  mensaje.Free;
  gestor.Free;
end;

end.

