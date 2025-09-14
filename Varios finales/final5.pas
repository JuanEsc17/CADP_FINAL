{
1. Un comercio dispone de la información de sus clientes. De cada cliente se conoce su DNI, fecha y monto 
de la compra. La información está ordenada por el DNI del cliente. Se pide implementar un programa que 
genere una estructura de datos que contenga DNI del cliente, la cantidad de compras que realizó y el 
monto total de las compras, solo con los clientes que realizaron más de 5 compras.
}
program final;
type
    cliente = record
        DNI: integer;
        fecha: String[10];
        monto: real;
    end;
    lista = ^nodo;
    nodo = record
        c: cliente;
        sig: lista;
    end;

    cliente2 = record
        DNI: integer;
        cantidad: integer;
        montoTotal: real;
    end;
    lista2 = ^nodo2;
    nodo2 = record
        cli: cliente2;
        sig: lista2;
    end;

procedure cargarClientes(var l:lista);// se dispone

procedure agregarCliente(dni,cant:integer; monto:real; var l:lista2);
var aux:lista2;
begin
    new(aux);
    aux^.cli.DNI:= dni;
    aux^.cli.cantidad:= cant;
    aux^.cli.montoTotal:= monto;
    aux^.sig:= l;
    l:=aux;
end;

procedure procesarClientes(var l2:lista2; l:lista);
var contadorCant, actual: integer; contadorMonto:real;
begin
    while(l <> nil)do begin
        actual:= l^.c.DNI;
        contadorCant:=0;
        contadorMonto:=0;
        while(l <> nil) and (l^.c.DNI = actual) do begin
            contadorCant:= contadorCant + 1;
            contadorMonto:= contadorMonto + l^.c.monto;
            l:= l^.sig;
        end;
        if (contadorCant > 5) then
            agregarCliente(actual, contadorCant, contadorMonto, l2);
    end;
end;

var
    l:lista;
    l2:lista2;
begin
    l2:= nil;
    cargarClientes(l);
    procesarClientes(l2,l);
end.
{
2. Dada la siguiente declaración y los siguientes módulos, indique para cada opción si incrementa en 1 cada 
uno de los elementos del vector. Justifique para cada caso.

Const dimF = 50; 
Type 
    rango = 1..dimF; 
    tVector = array[rango] of ^integer;
    vector = record 
        vec: tVector; 
        diml: integer; 
    end;

Opcion A:
Procedure inicializar (v: vector);
var i: rango;
begin
    for i := 1 to v.diml do begin
        new(v.vec[i]);
        v.vec[i]^:= v.vec[i]^ + 1;
    end;
end;

Opcion B:
Procedure inicializar (var v: vector);
var i: rango;
begin
    for i := 1 to diml do begin
        v.vec[i] := v.vec[i] + 1;
    end;
end;

-La opcion A no incrementa correctamente los valores porque al crear un espacio en memoria con new, este elemento no tiene ningun valor como para incrementar.
-La opcion B tampoco incrementa correctamente porque el campo vec de v es un puntero y para poder modificar los valores del lugar al que apunta el puntero se requiere accederlo con ^.
Ademas de que no se necesitaria pasar el parametro v por referencia.
for i:= 1 to v.diml do
    v.vec[i]^:= v.vec[i]^ + 1;

3. Calcule e indique la cantidad de memoria estática y dinámica que utiliza el siguiente programa. Mostrar 
los valores intermedios para llegar al resultado y justificar.
program ejercicio3;
type
  cadena25 = string[25]; -> 26 bytes
  lista = ^nodo; -> 4 bytes
  nodo = record -> 26 + 4 + 4 = 34 bytes
    nombre: cadena25;
    nota: integer;
    sig: lista;
  end;
  alumno = record -> 26 + 4 = 30 bytes
    ape_nom: cadena25;
    materias: lista;
  end;
  vector = array [1..40] of ^alumno; 4*40 = 160 bytes

var MEMORIA ESTATICA = 160 + 30 + 4 = 194 bytes
  v: vector; 
  a: alumno;
  i: integer;

begin MEMORIA DINAMICA = (10 * 30) - 30 = 270 bytes
  for i := 20 downto 10 do begin
    read(a.ape_nom);
    a.materias := nil;
    new(v[i]);  -> 10 * 30 = 300 bytes de memoria dinamica
    v[i]^ := a;
  end;
  v[15]:=nil;
  dispose(v[10]); -> 300 - 30 = 270 bytes de memoria dinamica
end.

Char      1 byte
Integer   4 bytes
Real      8 bytes
Boolean   1 byte
String    Longitud + 1 byte
Puntero   4 bytes

Tiempo de ejecucion:
(3*n) + 2 + n(cuerpo)
for= 3*11 + 2 + 11(2ut) = 33 + 2 + 22ut = 57ut
ultima asignacion = 57ut + 1ut = 58ut

T(algoritmo) = 58ut
}