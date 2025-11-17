unit u_cl_iusr_02;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, U_CL_PRODUCTO, U_CL_VISTA_MENSAJE;

type

  { TIUSR_02 }

  TIUSR_02 = class(TForm)
    btn_cerrar: TButton;
    btn_registrar_prod: TButton;
    ct_nombre_prod: TEdit;
    ct_clave_prod: TEdit;
    ct_precio_prod: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure evt_cerrar_iusr_02(Sender: TObject);
    procedure evt_registrar_prod(Sender: TObject);

  private

  public

  end;

var
  v_nombre_prod, v_clave_prod, v_precio_prod: String;
  v_cont_prod: Integer=0;
  PRODUCTOS: array[1..500] of CL_PRODUCTO;
  IUSR_02: TIUSR_02;
  mensaje: CL_VISTA_MENSAJE;

implementation

{$R *.lfm}

{ TIUSR_02 }


procedure TIUSR_02.evt_cerrar_iusr_02(Sender: TObject);
begin
   IUSR_02.Close;
end;

procedure TIUSR_02.evt_registrar_prod(Sender: TObject);
begin

     mensaje:=CL_VISTA_MENSAJE.Create;
     v_nombre_prod:= IUSR_02.ct_nombre_prod.Text;
     v_clave_prod:= IUSR_02.ct_clave_prod.Text;
     v_precio_prod:= IUSR_02.ct_precio_prod.Text;
     IF NOT(v_nombre_prod='') AND NOT(v_clave_prod='') AND NOT(v_precio_prod='') then
     begin
          v_cont_prod:= v_cont_prod+1;
          PRODUCTOS[v_cont_prod]:= CL_PRODUCTO.Create(StrToInt(v_clave_prod),v_nombre_prod,StrToFloat(v_precio_prod));
          mensaje.set_mensaje('PRODUCTO REGISTRADO');
          mensaje.mostrar_mensaje;
          IUSR_02.ct_nombre_prod.Text:=' ';
          IUSR_02.ct_clave_prod.Text:=' ';
          IUSR_02.ct_precio_prod.Text:=' ';
     end
     else
     begin
          mensaje.set_mensaje('VERIFIQUE QUE LAS CAJAS DE TEXTO CONTENGAN DATOS');
          mensaje.mostrar_mensaje;
     end;

end;

end.

