unit U_CL_VISTA;

{$mode objfpc}{$H+}

{
Autor: Rodrigo Díaz Salguero
Fecha: 16/10/2024
Actualización: ---
}

interface

uses
  Crt;

type
  CL_VISTA = class
  private
    mensaje: String;
    dato: String;
  public
    procedure set_mensaje(x: String);
    procedure set_dato(x: String);
    function get_mensaje: String;
    function get_dato: String;
    procedure informar(x, y: Integer);
    procedure recibir(x, y: Integer);
	procedure informar_LD(ld:CL_LINEA_DETALLE, y:Integer)
    procedure crear_marco(titulo_marco: String);
  end;

implementation

procedure CL_VISTA.set_mensaje(x: String);
begin
  mensaje := x;
end;

procedure CL_VISTA.set_dato(x: String);
begin
  dato := x;
end;

function CL_VISTA.get_mensaje: String;
begin
  Result := mensaje;
end;

function CL_VISTA.get_dato: String;
begin
  Result := dato;
end;

procedure CL_VISTA.informar(x, y: Integer);
begin
  GotoXY(x, y);
  WriteLn(mensaje);
end;

procedure CL_VISTA.recibir(x, y: Integer);
begin
  GotoXY(x, y); 
  ReadLn(dato);
end;

procedure CL_VISTA.crear_marco(titulo_marco: String);
var
  v_asteriscos_80: String;
  v_aste_esp_aste: String;
begin
  // BORRAR LA PANTALLA ANTES DE CREAR UN MARCO NUEVO
  ClrScr; 

  v_asteriscos_80 := '********************************************************************************';
  v_aste_esp_aste := '*                                                                              *';

  GotoXY(1, 5); WriteLn(v_asteriscos_80);
  GotoXY(1, 6); WriteLn(v_aste_esp_aste);
  GotoXY(1, 7); WriteLn(titulo_marco);
  GotoXY(1, 8); WriteLn(v_aste_esp_aste);
  GotoXY(1, 9); WriteLn(v_asteriscos_80);
  
  GotoXY(1, 10); WriteLn(v_aste_esp_aste);
  GotoXY(1, 11); WriteLn(v_aste_esp_aste);
  GotoXY(1, 12); WriteLn(v_aste_esp_aste);
  GotoXY(1, 13); WriteLn(v_aste_esp_aste);
  GotoXY(1, 14); WriteLn(v_aste_esp_aste);
  GotoXY(1, 15); WriteLn(v_aste_esp_aste);
  GotoXY(1, 16); WriteLn(v_aste_esp_aste);
  GotoXY(1, 17); WriteLn(v_aste_esp_aste);
  GotoXY(1, 18); WriteLn(v_aste_esp_aste);
  GotoXY(1, 19); WriteLn(v_aste_esp_aste);
  GotoXY(1, 20); WriteLn(v_aste_esp_aste);
  GotoXY(1, 21); WriteLn(v_aste_esp_aste);
  GotoXY(1, 22); WriteLn(v_aste_esp_aste);
  GotoXY(1, 23); WriteLn(v_aste_esp_aste);
  GotoXY(1, 24); WriteLn(v_aste_esp_aste);
  GotoXY(1, 25); WriteLn(v_aste_esp_aste);
  GotoXY(1, 26); WriteLn(v_aste_esp_aste);
  GotoXY(1, 27); WriteLn(v_aste_esp_aste);
  GotoXY(1, 28); WriteLn(v_aste_esp_aste);
  GotoXY(1, 29); WriteLn(v_asteriscos_80);
end;

end.
