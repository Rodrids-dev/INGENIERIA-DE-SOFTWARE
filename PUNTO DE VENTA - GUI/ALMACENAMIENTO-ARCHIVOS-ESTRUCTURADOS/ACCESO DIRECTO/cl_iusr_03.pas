unit CL_IUSR_03;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  U_CL_PRODUCTO,U_CL_VISTA_MENSAJE,U_GESTOR_ARCH_PRODUCTO,U_CL_LINEA_DETALLE,
  U_CL_VENTA,U_GESTOR_ARCH_VENTA,CL_ICONF_01;

type

  { TIUSR_03 }

  TIUSR_03 = class(TForm)
    btn_cerrar: TButton;
    btn_buscar_producto: TButton;
    btn_calcular_importe: TButton;
    btn_confirmar_venta: TButton;
    btn_calcular_total: TButton;
    btn_terminar_venta: TButton;
    ct_clave_producto: TEdit;
    ct_clave_venta: TEdit;
    ct_precio_producto: TEdit;
    ct_nombre_producto: TEdit;
    ct_clave_buscar_prod: TEdit;
    ct_unidades_adquiridas: TEdit;
    ct_importe_venta: TEdit;
    ct_total_venta: TEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label2: TLabel;
    lbl_fecha: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    procedure evt_buscar_producto(Sender: TObject);
    procedure evt_calcular_importe(Sender: TObject);
    procedure evt_calcular_total(Sender: TObject);
    procedure evt_cerrar(Sender: TObject);
    procedure evt_confirmar_venta(Sender: TObject);
    procedure evt_terminar_venta(Sender: TObject);
    procedure iniciar_venta(Sender: TObject);
  private

  public

  end;

var
  IUSR_03: TIUSR_03;

implementation

var
  obj_venta: CL_VENTA;
  numero_linea_detalle: Integer;
  v_Detalles: array [1..10] of CL_LINEA_DETALLE;

{$R *.lfm}

{ TIUSR_03 }

procedure TIUSR_03.evt_buscar_producto(Sender: TObject);
var
  v_buscar_producto,v_nombre,v_precio, v_clave:String;
  mensaje: CL_VISTA_MENSAJE;
  gestor: GESTOR_ARCH_PRODUCTO;
  producto: CL_PRODUCTO;
  v_encontrado: Boolean;
begin
  mensaje:=CL_VISTA_MENSAJE.Create;
  gestor:=GESTOR_ARCH_PRODUCTO.Create;
  v_buscar_producto:=IUSR_03.ct_clave_buscar_prod.Text;
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
         IUSR_03.ct_clave_producto.Text:=v_clave;
         IUSR_03.ct_nombre_producto.Text:=v_nombre;
         IUSR_03.ct_precio_producto.Text:=v_precio;
         producto.Free;
       end else
       begin
         mensaje.set_mensaje('El producto no ha sido encontrado');
	 mensaje.mostrar_mensaje;
         IUSR_03.ct_clave_producto.Text:='';
         IUSR_03.ct_nombre_producto.Text:='';
         IUSR_03.ct_precio_producto.Text:='';
       end;
     end else
     begin
       mensaje.set_mensaje('Verifica que la clave del producto que estás buscando tenga 4 dígitos.');
       mensaje.mostrar_mensaje;
     end;
  end else
  begin
    mensaje.set_mensaje('Para buscar un producto ingresa la clave del producto en el campo ubicado en la parte izquierda.');
    mensaje.mostrar_mensaje;
  end;
  mensaje.Free;
  gestor.Free;
end;

procedure TIUSR_03.evt_calcular_importe(Sender: TObject);
var
  producto_ld: CL_PRODUCTO;
  linead: CL_LINEA_DETALLE;
  mensaje: CL_VISTA_MENSAJE;
  v_precio,v_unidades: String;
  v_subtotal: Real;
begin
  mensaje:=CL_VISTA_MENSAJE.Create;
  v_precio := IUSR_03.ct_precio_producto.Text;
  v_unidades := IUSR_03.ct_unidades_adquiridas.Text;
  If NOT(v_precio='') then
  begin
     If NOT(v_unidades='') then
     begin
        producto_ld:=CL_PRODUCTO.Create(0,'',StrToFloat(v_precio));
	linead:=CL_LINEA_DETALLE.Create(0,StrToInt(v_unidades),producto_ld);
	linead.calcular_subtotal;
	v_subtotal := linead.get_Subtotal;
	IUSR_03.ct_importe_venta.Text:=FloatToStr(v_subtotal);
	producto_ld.Free;
	linead.Free;
     end else
     begin
        mensaje.set_mensaje('Para calcular el importe debes ingresar las unidades a adquirir del producto encontrado.');
	mensaje.mostrar_mensaje;
     end;
  end else
  begin
     mensaje.set_mensaje('Para poder calcular el importe debes primero haber buscado y encontrado un producto anteriormente.');
     mensaje.mostrar_mensaje;
  end;
  mensaje.Free;
end;

procedure TIUSR_03.evt_calcular_total(Sender: TObject);
var
  v_total_venta:Real;
begin
  v_total_venta:=obj_venta.get_Total;
  IUSR_03.ct_total_venta.Text:=FloatToStr(v_total_venta);
end;

procedure TIUSR_03.evt_cerrar(Sender: TObject);
begin
  IUSR_03.Close;
end;

procedure TIUSR_03.evt_confirmar_venta(Sender: TObject);
var
  v_detalle: CL_LINEA_DETALLE;
  producto: CL_PRODUCTO;
  mensaje: CL_VISTA_MENSAJE;
  v_clave,v_nombre,v_precio,v_unidades:String;
  v_conf:Integer;
  v_subtotal:Real;
begin
  mensaje:=CL_VISTA_MENSAJE.Create;
  v_clave:=IUSR_03.ct_clave_producto.Text;
  v_nombre:=IUSR_03.ct_nombre_producto.Text;
  v_precio:=IUSR_03.ct_precio_producto.Text;
  v_unidades:=IUSR_03.ct_unidades_adquiridas.Text;
  If Not((v_clave='')and(v_nombre='')and(v_precio='')and(v_unidades='')) then
  begin
     ICONF_01.lbl_pregunta.Caption:='Estas seguro que deseas confirmar la venta de:'+LineEnding+
     v_unidades+' unidades de '+v_nombre+' de '+v_precio+'$ c/u';
     v_conf:=ICONF_01.ShowModal;
     If v_conf=mrYes then
     begin
        ICONF_01.Close;
        numero_linea_detalle:=numero_linea_detalle+1;
        producto:=CL_PRODUCTO.Create(StrToInt(v_clave),v_nombre,StrToFloat(v_precio));
        v_detalle:=CL_LINEA_DETALLE.Create(numero_linea_detalle,StrToInt(v_unidades),producto);
        v_detalle.calcular_subtotal;
        v_Detalles[numero_linea_detalle]:=v_detalle;
        v_subtotal:=v_detalle.get_Subtotal;
        obj_venta.calcular_total(v_subtotal);
        IUSR_03.ct_clave_producto.Text:='';
        IUSR_03.ct_nombre_producto.Text:='';
        IUSR_03.ct_precio_producto.Text:='';
        IUSR_03.ct_unidades_adquiridas.Text:='';
        producto.Free;
        v_detalle.Free;
     end else
     begin
        ICONF_01.Close;
     end;
  end else
  begin
     mensaje.set_mensaje('Para poder confirmar una venta asegurate de buscar un producto anteriormente y colocar las unidades a adquirir del mismo.');
     mensaje.mostrar_mensaje;
  end;
  mensaje.Free;
end;

procedure TIUSR_03.evt_terminar_venta(Sender: TObject);
var
  gestor_venta: GESTOR_ARCH_VENTA;
  mensaje: CL_VISTA_MENSAJE;
  numero_venta: String;
  v_conf,i: Integer;
  v_total_venta: Real;
begin
  gestor_venta:=GESTOR_ARCH_VENTA.Create;
  mensaje:=CL_VISTA_MENSAJE.Create;
  numero_venta:=IUSR_03.ct_clave_venta.Text;
  v_total_venta:=obj_venta.get_Total;
  ICONF_01.lbl_pregunta.Caption:='¿Estas seguro que deseas terminar la venta No. '+numero_venta+LineEnding+
  'con total de $'+FloatToStr(v_total_venta)+' mxn';
  v_conf:=ICONF_01.ShowModal;
  If v_conf=mrYes then
  begin
     ICONF_01.Close;
     obj_venta.set_Detalles(v_Detalles);
     gestor_venta.guardar_venta(obj_venta);
     mensaje.set_mensaje('Venta finalizada correctamente');
     mensaje.mostrar_mensaje;
     IUSR_03.ct_clave_buscar_prod.Text:='';
     IUSR_03.ct_clave_producto.Text:='';
     IUSR_03.ct_nombre_producto.Text:='';
     IUSR_03.ct_precio_producto.Text:='';
     IUSR_03.ct_unidades_adquiridas.Text:='';
     IUSR_03.ct_importe_venta.Text:='';
     IUSR_03.ct_total_venta.Text:='';
     IUSR_03.Close;
     gestor_venta.Free;
     obj_venta.Free;
     For i:=1 to 10 do
     begin
        v_Detalles[i]:=CL_LINEA_DETALLE.Create(0,0,NIL);
        v_Detalles[i].Free;
     end;
  end else
  begin
     ICONF_01.Close;
  end;
end;

procedure TIUSR_03.iniciar_venta(Sender: TObject);
var
  gestor_venta: GESTOR_ARCH_VENTA;
  v_fecha: TDate;
  numero_venta: Integer;
begin
  gestor_venta:=GESTOR_ARCH_VENTA.Create;
  numero_venta:=gestor_venta.obtener_numero_venta;
  numero_venta:=numero_venta+1;
  v_fecha:=Date;
  obj_venta:=CL_VENTA.Create;
  obj_venta.set_Numero(numero_venta);
  obj_venta.set_Fecha(DateToStr(v_fecha));
  obj_venta.set_Total(0);
  IUSR_03.lbl_fecha.Caption:=DateToStr(v_fecha);
  IUSR_03.ct_clave_venta.Text:=IntToStr(numero_venta);
  numero_linea_detalle:=0;
end;

end.

