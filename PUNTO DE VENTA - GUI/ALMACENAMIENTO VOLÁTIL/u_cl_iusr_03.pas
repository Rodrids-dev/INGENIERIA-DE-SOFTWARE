unit u_cl_iusr_03;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  u_cl_iusr_02, U_CL_LINEA_DETALLE, U_CL_VENTA;

type

  { TIUSR_03 }

  TIUSR_03 = class(TForm)
    btn_buscar: TButton;
    btn_conf_LD: TButton;
    btn_term_vta: TButton;
    btn_cerrar: TButton;
    ct_nombre_busc: TEdit;
    ct_prod_enc: TEdit;
    ct_preprod_enc: TEdit;
    ct_unidades: TEdit;
    ct_total: TEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label2: TLabel;
    lbl_fecha: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lbl_fecha1: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    panel_02: TPanel;
    panel_03: TPanel;
    procedure evt_buscar_producto(Sender: TObject);
    procedure evt_cerrar_iusr_03(Sender: TObject);
    procedure evt_conf_LD(Sender: TObject);
    procedure evt_iniciar_venta(Sender: TObject);
    procedure evt_term_vta(Sender: TObject);
    procedure panel_03Click(Sender: TObject);
  private

  public

  end;

var
  v_nombre_busc, v_nombre_p,v_unidades:String;
  v_encontrado:Boolean;
  i, v_i_encontrado: Integer;
  v_cont_LD:Integer=0;
  v_subtotal, v_total:Real;
  LINEA_DETALLE: array[1..500] of CL_LINEA_DETALLE;
  v_cont_venta:Integer=0;
  v_fecha: TDateTime;
  VENTA: array[1..500] of CL_VENTA;
  IUSR_03: TIUSR_03;

implementation

{$R *.lfm}
{ TIUSR_03 }


procedure TIUSR_03.evt_cerrar_iusr_03(Sender: TObject);
begin
  If v_cont_LD>0 THEN
  BEGIN
       v_cont_LD:=0;
       IUSR_03.Close;
  end;
  If v_cont_LD=0 then
  begin
       VENTA[v_cont_venta].Destroy;
       v_cont_venta:=v_cont_venta-1;
       IUSR_03.Close;
  end;
  IUSR_03.ct_total.Text:=' ';
end;

procedure TIUSR_03.evt_conf_LD(Sender: TObject);
begin
     v_unidades:= IUSR_03.ct_unidades.Text;
     If NOT(v_unidades='') then
     begin
          v_cont_LD:= v_cont_LD+1;
          LINEA_DETALLE[v_cont_LD]:= CL_LINEA_DETALLE.Create(v_cont_LD,StrToInt(v_unidades),PRODUCTOS[v_i_encontrado]);
          LINEA_DETALLE[v_cont_LD].calcular_subtotal;
          v_subtotal:= LINEA_DETALLE[v_cont_LD].get_Subtotal;
          VENTA[v_cont_venta].calcular_total(v_subtotal);
          mensaje.set_mensaje('SE HA CONFIRMADO LA COMPRA DE '+v_unidades+' UNIDADES DE '+LINEA_DETALLE[v_cont_LD].get_Producto.get_Nombre);
          mensaje.mostrar_mensaje;
          IUSR_03.ct_unidades.Text:=' ';
          IUSR_03.panel_03.Enabled:=True;
     end
     else
     begin
          mensaje.set_mensaje('Por favor llene el campo UNIDADES ADQUIRIDAS para confirmar la Linea de Detalle');
          mensaje.mostrar_mensaje;
          IUSR_03.panel_03.Enabled:=False;
     end;
end;

procedure TIUSR_03.evt_iniciar_venta(Sender: TObject);
{EVENTO ONSHOW}
begin
    v_cont_venta:=v_cont_venta+1;
    v_fecha:=Date;
    VENTA[v_cont_venta]:=CL_VENTA.Create(v_cont_venta,DateToStr(v_fecha));
    IUSR_03.lbl_fecha.Caption:=DateToStr(v_fecha);
    IUSR_03.ct_prod_enc.Enabled:=False;
    IUSR_03.ct_preprod_enc.Enabled:=False;
    IUSR_03.panel_02.Enabled:=False;
    IUSR_03.panel_03.Enabled:=False;
end;

procedure TIUSR_03.evt_term_vta(Sender: TObject);
begin
     v_total:= VENTA[v_cont_venta].get_Total;
     IUSR_03.ct_total.Text:=FloatToStr(v_total);
end;

procedure TIUSR_03.panel_03Click(Sender: TObject);
begin

end;

procedure TIUSR_03.evt_buscar_producto(Sender: TObject);
begin
  v_nombre_busc:=IUSR_03.ct_nombre_busc.Text;
  If v_nombre_busc='' then
  begin
     mensaje.set_mensaje('PARA BUSCAR UN PRODUCTO, INGRESE EL NOMBRE EN EL CAMPO CORRESPONDIENTE');
     mensaje.mostrar_mensaje;
  end else
  begin
     v_encontrado := False;
     //MI METODO DE BUSQUEDA
     for i:=1 to v_cont_prod do
     begin
          v_nombre_p := PRODUCTOS[i].get_Nombre;
	  if v_nombre_p = v_nombre_busc then
	  begin
	       v_i_encontrado := i;
	       v_encontrado := True;
	  end;
     end;
     If v_encontrado=True then
     begin
          v_nombre_prod:=PRODUCTOS[v_i_encontrado].get_Nombre;
          v_precio_prod:=FloatToStr(PRODUCTOS[v_i_encontrado].get_Precio);
          mensaje.set_mensaje('PRODUCTO ENCONTRADO');
          mensaje.mostrar_mensaje;
          IUSR_03.ct_prod_enc.Text:=v_nombre_prod;
          IUSR_03.ct_preprod_enc.Text:=v_precio_prod;
          IUSR_03.ct_nombre_busc.Text:=' ';
          IUSR_03.panel_02.Enabled:=True;
     end else
     begin
        mensaje.set_mensaje('PRODUCTO NO ENCONTRADO');
        mensaje.mostrar_mensaje;
        IUSR_03.ct_prod_enc.Text:=' ';
        IUSR_03.ct_preprod_enc.Text:=' ';
        IUSR_03.ct_nombre_busc.Text:=' ';
        IUSR_03.panel_02.Enabled:=False;
     end;
   end;
end;

end.

