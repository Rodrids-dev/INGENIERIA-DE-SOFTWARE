unit U_CL_VISTA_MENSAJE;

{$mode objfpc}{$H+}

{
Autor: Rodrigo Díaz Salguero
Fecha: 16/10/2024
Actualización: ---
}

interface

uses
  Crt, SysUtils, Dialogs;

type
  CL_VISTA_MENSAJE = class
  private
    mensaje: String;
  public
    procedure set_mensaje(x: String);
    function get_mensaje: String;
    procedure mostrar_mensaje;
  end;

implementation

procedure CL_VISTA_MENSAJE.set_mensaje(x: String);
begin
  mensaje := x;
end;

function CL_VISTA_MENSAJE.get_mensaje: String;
begin
  Result := mensaje;
end;

procedure CL_VISTA_MENSAJE.mostrar_mensaje;
begin
  ShowMessage(mensaje);
end;

end.
