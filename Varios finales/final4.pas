{
1. Un comercio dispone de una estructura de datos con las facturas (como máximo 2000 facturas)
realizadas durante marzo de 2023. De cada factura se conoce el número de factura, código 
de cliente, código de sucursal y monto total. Las facturas se encuentran ordenadas por código de sucursal. Se pide implementar 
un programa con un módulo que reciba la estructura que se dispone y devuelva el código de sucursal con mayor 
cantidad de facturas. El programa debe informar el valor retornado por el módulo.
}
program final;
const
    maxFacturas = 2000;
type
    factura = record
        numero: integer;
        codCli: integer;
        codSuc: integer;
        monto: real;
    end;

    totalFacturas = array[1..maxFacturas] of factura;
// procedures
procedure cargarFacturas(var v:totalFacturas; var dimensionLogica:integer); // se dispone

function procesarFacturas(v:totalFacturas; dimL:integer): integer;
var i, max, act, contador, contMax: integer;
begin
    max:= -1;
    i:= 1;
    contMax:= -1;
    while(i <= dimL)do begin
        contador:=0;
        act:= v[i].codSuc;
        while(i <= dimL) and (v[i].codSuc = act) do begin
            contador:= contador + 1;
            i:= i + 1;
        end;
        if (contador >= contMax) then begin
            contMax:= contador;
            max:= act;
        end;
    end;
    procesarFacturas:= max;
end;

var
    v:totalFacturas;
    dimL, cod: integer;
begin
    cargarFacturas(v,dimL);
    writeln(procesarFacturas(v,dimL));
end.
{
2. Dada la siguiente declaración y los siguientes procesos, indique para cada uno de los procesos si son 
correctos o no. El objetivo es duplicar el contenido del último nodo de la lista. Justifique su respuesta.

type
  milista = ^nodo;
  nodo = record
    dato: integer;
    sig: milista;
  end;
  lista = record
    pri: milista;
    ult: milista;
  end;

A)
Procedure duplicar1 (L: lista);
begin
  L.ult^.dato := L.ult^.dato * 2;
end;

B)
Procedure duplicar2 (L: lista);
var aux: milista;
begin
  aux := L.pri;
  while (aux^.sig <> nil) do
    aux := aux^.sig;
  aux^.dato := aux^.dato * 2;
end;

-Ambas son correctas pero la B la considero mejor porque asegura de que se accede al ultimo nodo de la lista

3. Calcule e indique la cantidad de memoria estática y 
dinámica que utiliza el siguiente programa. Mostrar 
los valores intermedios para llegar al resultado y 
justificar.

program ejercicio3;
const
  dimF = 2000;
type
  cadena31 = string[31]; -> 32 bytes
  alumno = record -> 32 + 8 = 40 bytes
    ape_nom: cadena31;
    promedio: real;
  end;
  vector = array [1..dimF] of ^alumno; -> 2000*4 = 8000 bytes
  lista = ^nodo; -> 4 bytes
  nodo = record -> 40 + 4 = 44 bytes
    datos: alumno;
    sig: lista;
  end;
var MEMORIA ESTATICA: 8000 + 40 + 16 + 4 = 8060 bytes
  v: vector; -> 8000 bytes
  a: alumno; -> 40 bytes
  nota, i, sum, cant: integer; -> 4 * 4 = 16 bytes
  aux: lista; -> 4 bytes
begin MEMORIA DINAMICA: 80000 bytes
  for i := 1 to dimF do -> 3*2000 + 2 + 2000(cuerpo) moooor 🚢🚢🚢
  begin
    read(a.ape_nom); read(nota); cant := 0; sum := 0; -> 2ut
    while (nota <> -1) do -> N*1 + N(4)
    begin
      sum := sum + nota; cant := cant + 1; -> 4ut
      read(nota);
    end;
    if (cant <> 0) then -> 1 + 2ut = 3ut
      a.promedio := sum / cant
    else
      a.promedio := 0;
    new(v[i]); -> 40 * 2000 = 80000 bytes
    v[i]^ := a; -> 1ut
  end;
end.

Referencias:
Char      1 byte
Integer   4 bytes
Real      8 bytes
Boolean   1 byte
String    Longitud + 1 byte
Puntero   4 bytes

4. Calcule el tiempo de ejecución del programa del punto 3. Mostrar los valores intermedios para llegar
al resultado y justificar.
- 3*2000 + 2000(2ut + (N + N(4)) + 3ut + 1ut) = 6000 + 2000(6 + 5N) = 6000 + 12000 + 5N = (18000 + 5N)ut

5.Indique Verdadero o Falso. Justifique en todos los casos: 
    a. Antes de utilizar una variable puntero siempre se debe reservar memoria.
        Verdadero, porque si no le asginas un espacio en memoria no tiene donde acceder para realizar operaciones. (Creo que se refiere a eso)
    b. La comunicación mediante parámetros asegura que un programa es correcto.
        Falso, un programa que se comunique correctamente con parametros no asegura que el programa sea correcto. Un programa correcto es un programa que logra lo pedido, independientemente de la comunicacion por parametros.
    c. La invocación al módulo otro es válida.
    program ejercicioX;
    var a, b: real;
    procedure calcular (var x: real; c: real);
        function otro (una: integer): integer;
        begin
            ...
        end;
    begin
        ...
    end;

    begin
        ...
        write (otro (40));
        ...
    end.
        Falso, no puede acceder al modulo otro porque es un modulo local al procedure calcular.
    d. Siempre es posible eliminar el primer elemento en una lista.
        Falso, si la lista no tiene elementos no va a ser posible eliminar.
    e. Las instrucciones dentro de una estructura de control repeat...until se pueden ejecutar 0, 1 o más veces.
        Falso, las intrucciones dentro de repeat until se ejecutan al menos una vez ya que evalua la condicion al final de ejecutar el conjunto de instrucciones.
    f.El siguiente programa muestra por pantalla: 
    Valor de a: 200 Valor de b: 30 Valor de c: 20
    program imprimir;
    var a, c: integer;
    procedure calcular (b: integer; var x: integer);
    begin
    x := 10;
    c := c + b; c = 15 + 20 = 35
    a := (b + x) * 5; a = (20 + 10) * 5 = 150
    b := (a + b) MOD 10; b = (150 + 20) MOD 10 = 0
    end;
    var b: integer;
    begin
    b := 20;
    c := b - 5; -> 15
    calcular(b, c); (20, 15)
    writeln('Valor de a:', 150, ' Valor de b:', 20, ' Valor de c: ', 15);
    end; NUNCA ME SALEEEEEEEEEEEEEEEEEEE AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA 🚢🚢🚢🚢🚢🚢🚢🚢🚢🚢🚢🚢🚢🚢🚢🚢🚢🚢
}