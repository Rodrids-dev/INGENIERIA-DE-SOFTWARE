unit U_GESTOR_ARCH_PRODUCTO;
{$mode objfpc}{$H+}

interface

uses
    U_CL_PRODUCTO;

type
    GESTOR_ARCH_PRODUCTO = class
    private
        porcentaje_uso_log: Real;
        porcentaje_uso_fis: Real;
    public
        procedure set_porcentaje_uso_log(x: Real);
        procedure set_porcentaje_uso_fis(x: Real);
        function get_porcentaje_uso_log: Real;
        function get_porcentaje_uso_fis: Real;
        procedure crear_arch_producto(tam: Integer);
        function guardar_producto(producto: CL_PRODUCTO): Boolean;
        function consultar_producto(clave: Integer;var producto: CL_PRODUCTO): Boolean;
        function modificar_producto(clave: Integer; producto: CL_PRODUCTO): Boolean;
        function eliminar_producto(clave: Integer): Boolean;
        procedure borrado_fisico;
        procedure obtener_porcentaje_uso_log(tam:Integer);
        procedure obtener_porcentaje_uso_fis(tam:Integer);
        function obtener_diferencia_uso:Real;
    end;

implementation

uses
    SysUtils;

{ GESTOR_ARCH_PRODUCTO }

procedure GESTOR_ARCH_PRODUCTO.set_porcentaje_uso_log(x: Real);
begin
    porcentaje_uso_log := x;
end;

procedure GESTOR_ARCH_PRODUCTO.set_porcentaje_uso_fis(x: Real);
begin
    porcentaje_uso_fis := x;
end;

function GESTOR_ARCH_PRODUCTO.get_porcentaje_uso_log: Real;
begin
    Result := porcentaje_uso_log;
end;

function GESTOR_ARCH_PRODUCTO.get_porcentaje_uso_fis: Real;
begin
    Result := porcentaje_uso_fis;
end;

procedure GESTOR_ARCH_PRODUCTO.crear_arch_producto(tam: Integer);
type
    reg_producto = record
        campo_clave: Integer;
        campo_nombre: string[25];
        campo_precio: Real;
        campo_disponible: Integer;
    end;
var
    f_producto: file of reg_producto;
    v_reg_producto: reg_producto;
    i: Integer;
begin
    AssignFile(f_producto, 'Archivos\PRODUCTOS.rod');
    Rewrite(f_producto);
    v_reg_producto.campo_clave := 0;
    v_reg_producto.campo_nombre := '';
    v_reg_producto.campo_precio := 0;
    v_reg_producto.campo_disponible := -99;
    for i := 1 to tam do
        Write(f_producto, v_reg_producto);
    CloseFile(f_producto);
end;

function GESTOR_ARCH_PRODUCTO.guardar_producto(producto: CL_PRODUCTO): Boolean;
type
    reg_producto = record
        campo_clave: Integer;
        campo_nombre: string[25];
        campo_precio: Real;
        campo_disponible: Integer;
    end;
var
    v_reg_producto, v_leer_reg: reg_producto;
    f_producto: file of reg_producto;
    v_pos, v_disponible: Integer;
    v_retorno: Boolean;
begin
    v_retorno := False;
    v_reg_producto.campo_clave := producto.get_Clave;
    v_reg_producto.campo_nombre := producto.get_Nombre;
    v_reg_producto.campo_precio := producto.get_Precio;
    v_reg_producto.campo_disponible := 1;

    { HASH MODULO 99 }
    v_pos := v_reg_producto.campo_clave mod 99;

    { REGISTRAR PRODUCTO }
    AssignFile(f_producto, 'Archivos\PRODUCTOS.rod');
    Reset(f_producto);
    Seek(f_producto, v_pos);
    Read(f_producto, v_leer_reg);
    if v_leer_reg.campo_disponible = -99 then
    begin
        Seek(f_producto, v_pos);
        Write(f_producto, v_reg_producto);
        v_retorno := True;
    end
    else { COLISION }
    begin
        if v_leer_reg.campo_clave <> producto.get_Clave then
        begin
            v_pos := 99;
            Seek(f_producto, v_pos);
            repeat
                Read(f_producto, v_leer_reg);
                v_disponible := v_leer_reg.campo_disponible;
                v_pos := v_pos + 1;
            until (v_disponible = -99) or (v_pos = 110);
            Write(f_producto, v_reg_producto);
            v_retorno := True;
        end;
    end;
    CloseFile(f_producto);
    Result := v_retorno;
end;

function GESTOR_ARCH_PRODUCTO.consultar_producto(clave: Integer;var producto: CL_PRODUCTO): Boolean;
type
    reg_producto = record
        campo_clave: Integer;
        campo_nombre: string[25];
        campo_precio: Real;
        campo_disponible: Integer;
    end;
var
    f_producto: file of reg_producto;
    v_reg_producto: reg_producto;
    v_retorno: Boolean;
    v_pos: Integer;
begin
    AssignFile(f_producto, 'Archivos\PRODUCTOS.rod');
    Reset(f_producto);
    v_retorno := False;
    v_pos := clave mod 99;
    Seek(f_producto, v_pos);
    Read(f_producto, v_reg_producto);
    if v_reg_producto.campo_disponible <> -99 then
    begin
        v_retorno := True;
        producto.set_Clave(v_reg_producto.campo_clave);
        producto.set_Nombre(v_reg_producto.campo_nombre);
        producto.set_Precio(v_reg_producto.campo_precio);
    end;
    CloseFile(f_producto);
    Result := v_retorno;
end;

function GESTOR_ARCH_PRODUCTO.modificar_producto(clave: Integer; producto: CL_PRODUCTO): Boolean;
type
    reg_producto = record
        campo_clave: Integer;
        campo_nombre: string[25];
        campo_precio: Real;
        campo_disponible: Integer;
    end;
var
    f_producto: file of reg_producto;
    v_reg_producto, v_reg_leer: reg_producto;
    v_retorno: Boolean;
    v_pos, v_contador: Integer;
begin
    AssignFile(f_producto, 'Archivos\PRODUCTOS.rod');
    Reset(f_producto);
    v_retorno := False;
    v_pos := clave mod 99;
    v_reg_producto.campo_clave := producto.get_Clave;
    v_reg_producto.campo_nombre := producto.get_Nombre;
    v_reg_producto.campo_precio := producto.get_Precio;
    v_reg_producto.campo_disponible := 1;

    Seek(f_producto, v_pos);
    Read(f_producto, v_reg_leer);

    if (v_reg_leer.campo_disponible = 1) and (v_reg_leer.campo_clave = clave) then
    begin
        v_retorno := True;
        Seek(f_producto, v_pos);
        Write(f_producto, v_reg_producto); // Sobrescribe el registro
    end
    else
    begin
        Seek(f_producto, 99); // Zona de colisiones
        v_contador := 99;
        while not Eof(f_producto) do
        begin
            Read(f_producto, v_reg_leer);
            v_contador := v_contador + 1;

            if (v_reg_leer.campo_clave = clave) and (v_reg_leer.campo_disponible = 1) then
            begin
                v_retorno := True;
                Seek(f_producto, v_contador - 1);
                Write(f_producto, v_reg_producto);
            end;
        end;
    end;

    CloseFile(f_producto);
    Result := v_retorno;
end;

function GESTOR_ARCH_PRODUCTO.eliminar_producto(clave: Integer): Boolean;
type
    reg_producto = record
        campo_clave: Integer;
        campo_nombre: string[25];
        campo_precio: Real;
        campo_disponible: Integer;
    end;
var
    f_producto: file of reg_producto;
    v_reg_producto: reg_producto;
    v_retorno: Boolean;
    v_pos, v_contador: Integer;
begin
    v_retorno := False;
    v_pos := clave mod 99;
    AssignFile(f_producto, 'Archivos\PRODUCTOS.rod');
    Reset(f_producto);
    Seek(f_producto, v_pos);
    Read(f_producto, v_reg_producto);
    if (v_reg_producto.campo_disponible = 1) and (v_reg_producto.campo_clave = clave) then
    begin
        Seek(f_producto, v_pos);
        v_reg_producto.campo_disponible := -99;
        Write(f_producto, v_reg_producto);
        v_retorno := True;
    end
    else
    begin
        Seek(f_producto, 99);
        v_contador := 99;
        while not Eof(f_producto) do
        begin
            Read(f_producto, v_reg_producto);
            v_contador := v_contador + 1;
            if (v_reg_producto.campo_clave = clave) and (v_reg_producto.campo_disponible = 1) then
            begin
                v_reg_producto.campo_disponible := -99;
                Seek(f_producto, v_contador - 1);
                Write(f_producto, v_reg_producto);
                v_retorno := True;
            end;
        end;
    end;
    CloseFile(f_producto);
    Result := v_retorno;
end;

procedure GESTOR_ARCH_PRODUCTO.borrado_fisico;
type
    reg_producto = record
        campo_clave: Integer;
        campo_nombre: string[25];
        campo_precio: Real;
        campo_disponible: Integer;
    end;
var
    f_producto, f_temporal: file of reg_producto;
    v_reg_producto: reg_producto;
    v_marca, v_contador: Integer;
begin
    v_contador := 0;
    AssignFile(f_temporal, 'Archivos\TEMPORAL.rod');
    Rewrite(f_temporal);
    AssignFile(f_producto, 'Archivos\PRODUCTOS.rod');
    Reset(f_producto);
    while not Eof(f_producto) do
    begin
        Read(f_producto, v_reg_producto);
        v_contador := v_contador + 1;
        v_marca := v_reg_producto.campo_disponible;
        if v_marca <> -99 then
        begin
            Seek(f_temporal, v_contador);
            Write(f_temporal, v_reg_producto);
        end;
    end;
    CloseFile(f_producto);
    DeleteFile('Archivos\PRODUCTOS.rod');
    CloseFile(f_temporal);
    RenameFile('Archivos\TEMPORAL.rod', 'Archivos\PRODUCTOS.rod');
end;

procedure GESTOR_ARCH_PRODUCTO.obtener_porcentaje_uso_log(tam:Integer);
type
    reg_producto = record
        campo_clave: Integer;
        campo_nombre: string[25];
        campo_precio: Real;
        campo_disponible: Integer;
    end;
var
    f_producto: file of reg_producto;
    v_reg_producto: reg_producto;
    v_contador, cant_reg_log: Integer;
begin
    v_contador:=1;
    cant_reg_log:=0;
    AssignFile(f_producto,'Archivos\PRODUCTOS.rod');
    Reset(f_producto);
    repeat
        Seek(f_producto,v_contador);
        Read(f_producto,v_reg_producto);
        If v_reg_producto.campo_disponible=1 then
        begin
            cant_reg_log:=cant_reg_log+1;
        end;
        v_contador:=v_contador+1;
    until v_contador=tam;
    CloseFile(f_producto);
    //Porcentaje de uo lógico
    porcentaje_uso_log:=(cant_reg_log/tam)*100;
end;

procedure GESTOR_ARCH_PRODUCTO.obtener_porcentaje_uso_fis(tam:Integer);
type
    reg_producto = record
        campo_clave: Integer;
        campo_nombre: string[25];
        campo_precio: Real;
        campo_disponible: Integer;
    end;
var
    f_producto: file of reg_producto;
    v_reg_producto: reg_producto;
    v_contador, cant_reg_fis: Integer;
begin
    v_contador:=1;
    cant_reg_fis:=0;
    AssignFile(f_producto,'Archivos\PRODUCTOS.rod');
    Reset(f_producto);
    repeat
        Seek(f_producto,v_contador);
        Read(f_producto,v_reg_producto);
        If v_reg_producto.campo_clave<>0 then
        begin
            cant_reg_fis:=cant_reg_fis+1;
        end;
        v_contador:=v_contador+1;
    until v_contador=tam;
    CloseFile(f_producto);
    //Porcentaje de uo físico
    porcentaje_uso_fis:=(cant_reg_fis/tam)*100;
end;

function GESTOR_ARCH_PRODUCTO.obtener_diferencia_uso:Real;
var
   diferencia: Real;
begin
   diferencia:= Abs(porcentaje_uso_log-porcentaje_uso_fis);
   Result:=diferencia;
end;

end.
