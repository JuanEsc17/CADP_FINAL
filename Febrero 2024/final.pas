program final;
type
    venta = record
        numero: integer;
        cant: integer;
        tipo: boolean; // true = efectivo, false = tarjeta
    end;

    lista = ^nodo;
    nodo = record
        v: venta;
        sig: lista;
    end;

procedure cargarVentas(var l:lista); //se dispone

function masPares(num: integer):boolean;
var pares, impares, aux:integer;
begin
    pares:= 0; impares:= 0;
    while (num <> 0) do begin
        aux:= num MOD 10;
        num:= num DIV 10;
        if (aux MOD 2 = 0) then
            pares:= pares + 1
        else
            impares:= impares + 1;
    end;
    masPares:= pares > impares;
end;

procedure agregarAtras(var lNueva, ult: lista; v:venta);
var aux:lista;
begin
    new(aux);
    aux^.v:= v;
    aux^.sig:= nil;
    if (lNueva = nil) then
        lNueva:= aux
    else
        ult^.sig:= aux;
    ult:= aux;
end;

procedure agregar(var l:lista; v:venta);
var aux:lista;
begin
    new(aux);
    aux^.v:= v;
    aux^.sig:= l;
    l:= aux;
end;

procedure procesarVentas(l:lista; var lNueva:lista);
var ult:lista;
begin
    lNueva:= nil; ult:=nil;
    while(l<>nil) do begin
        if (masPares(l^.v.cant)) then begin
            if (l^.v.tipo) then
                agregar(lNueva, l^.v)
            else
                agregarAtras(lNueva, ult, l^.v);
        end;
        l:= l^.sig;
    end;
end;

var
    l, lNueva:lista;
begin
    l:=nil;
    cargarVentas(l);
    procesarVentas(l, lNueva);
end.
{
2.
    Ambos son verdaderos y realizan la misma funcionalidad solo que en el program uno declara el tipo de dato 'datos' en el apartado de type y luego se lo declara a la variable d, y en el program dos declara la variable con su tipo directamente desde el var.

program ejercicio3;
type 
    info = record -> 256 + 6 + 4 = 266 bytes
        nombre: string; -> 256 bytes
        nota: integer; -> 6 bytes
        datos: ^integer; -> 4 bytes
    end;
    vector = array [1..100] of info; -> 100 * 266 = 26600 bytes

var MEMORIA ESTATICA = 26600 + 12 + 266 = 26878 bytes
    v: vector; 
    i, j: integer; 
    e: info;

begin
    read(e.nombre);
    i := 0; 1ut
    while (i < 100) and (e.nombre <> 'ZZZ') do -> 100(3) + 100(4) = 700ut
    begin
        read(e.nota); 
        e.datos := nil; 1ut
        i := i + 1; 2ut
        v[i] := e; 1ut
        read(e.nombre);
    end;
    for j := 1 to i do begin -> 3*100 + 2 + 100(2)
        new(v[j].datos); -> 100*6 = 600 bytes
        v[j].datos^ := v[j].nota MOD 10; 2ut
    end;
end.

T(ejercicio3) = 1ut + 700ut + 502ut = 1203ut
MEMORIA DINAMICA = 600 bytes
MEMORIA ESTATICA = 26878 bytes
}