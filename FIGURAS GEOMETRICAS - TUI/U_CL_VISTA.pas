unit U_CL_VISTA;

{$mode objfpc}{$H+}

interface

uses
  crt; // Necesario para usar GotoXY

type
  CL_VISTA = class
  private
    mensaje: string;
    dato: string;
  public
    procedure set_mensaje(x: string);
    procedure set_dato(x: string);
    function get_mensaje: string;
    function get_dato: string;
    procedure informar(x: integer; y: integer);
    procedure recibir(x: integer; y: integer);
  end;

implementation
{
procedure POSICIONAR(x: integer; y: integer);
begin
  GotoXY(x, y); // Posiciona el cursor en la consola en las coordenadas (x, y)
end;}

procedure CL_VISTA.set_mensaje(x: string);
begin
  mensaje := x;
end;

procedure CL_VISTA.set_dato(x: string);
begin
  dato := x;
end;

function CL_VISTA.get_mensaje: string;
begin
  Result := mensaje;
end;

function CL_VISTA.get_dato: string;
begin
  Result := dato;
end;

procedure CL_VISTA.informar(x: integer; y: integer);
begin
  GotoXY(x, y);
  WriteLn(mensaje);
end;

procedure CL_VISTA.recibir(x: integer; y: integer);
begin
  GotoXY(x, y);
  ReadLn(dato);
end;

end.
