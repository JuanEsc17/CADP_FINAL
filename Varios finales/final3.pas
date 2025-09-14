{
Práctica: Se dispone de la información de los productos de un supermercado. De cada producto se tiene Código,
Nombre, Rubro [1..20] y precio. Se pide implementar un programa que guarde en una estructura adecuada los
productos de los rubros que tengan 10 productos.
}
program final;
const
    maxRubro = 20;
type
    rangorubros = 1..maxRubro;
    producto = record
        codigo: integer;
        nombre: String[20];
        rubro: rangorubros;
        precio: real;
    end;

    lista = ^nodo;

    nodo = record
        p: producto;
        sig: lista;
    end;

    contadores = array[rangorubros] of integer;

procedure cargarProductos(var l:lista); //se dispone

procedure inicializarContadores(var c:contadores);
var i: rangorubros;
begin
    for i:= 1 to maxRubro do
        c[i]:= 0;
end;

procedure contarProductos(var c:contadores; l:lista);
begin
    while(l <> nil) do begin
        c[l^.p.rubro]:= c[l^.p.rubro] + 1;
        l:= l^.sig;
    end;
end;

procedure agregar(var l:lista; p:producto);
var aux:lista;
begin
    new(aux)
    aux^.p:=p;
    aux^.sig:=l;
    l:=aux
end;

procedure agregarProductos(var nuevaLista:lista; l:lista; c:contadores);
begin
    while(l<>nil)do begin
        if(c[l^.p.rubro] = 10) then
            agregar(nuevaLista,l^.p);
        l:=l^.sig;
    end;
end;

var 
    nuevaLista:lista;
    l:lista;
    c:contadores;
begin
    l:=nil;
    nuevaLista:=nil;
    cargarProductos(l);//se dispone
    inicializarContadores(c);
    contarProductos(c,l);
    agregarProductos(nuevaLista,l,c);
end.

{
Verdadero o Falso:
- En la tecnica de correcion de debugging es necesario analizar los casos limites del problema.
    Falso, eso es parte de la tecnica de testing. El debugging se encarga de corregir los errores de los casos limites testeados.
- Un vector siempre se utiliza teniendo en cuenta la dimension logica.
    Falso, no siempre se utiliza dependiendo su dimension logica. Ejemplo de un caso en el que no hay uso de DL:
    type
        compra = record
            mes: integer;
            monto: real;
        end;
    
    leer(compra);
    total[compra.mes]:= total[compra.mes]+1;
- Una funcion puede devolver un tipo de dato registro, real, booleano, entre otros.
    Falso, una funcion no puede devolver datos definidos por el usuario, en este caso un registro.
- Un programa que utiliza solo variables globales no requiere modularizacion.
    Falso, las variables globales y la modularizacion son dos conceptos independientes, aunque modularizar mucho en programas donde se utilizan variables globales pueden ser poco legibles e incluso pueden dar resultados no esperados.

Dada la siguiente declaración de tipos de datos y variables, justificar para cada sentencia numeradas si son válidas o inválidas:
program ejercicio3;
type
  cadena100 = string[100];
  cliente = record
    codigo: integer;
    tel: integer;
    dir: cadena100;
  end;
  clientes = ^nodo;
  nodo = record
    datos: cliente;
    sig: clientes;
  end;
var
  c: cliente;
  cli: clientes;

begin
  1. read(c); No es valido, no se puede leer un registro de esta manera, hay que leer campo por campo
  2. new(c); No es valido, no hacer a un new a un tipo de dato que no sea puntero
  3. read(cli); Es valido, se puede leer a un tipo de dato puntero (no es buena practica asignarle manualmente la posicion de memoria a un puntero)
  4. cli := nil; Es valido, cli ahora no apunta a otro lugar de la memoria
  5. cli^ := nil; No es valido, no se puede asignar nil a un registro
  6. dispose(cli); No es valido, cli actualmente apunta a nil, no hay nada a lo que hacer dispose
  7. read(cli^.codigo); No es valido, primero hay que asignarle un nodo a cli para poder asignarle un valor a uno de sus campos
  8. write(c.codigo); Es valido, este imprime basura.
end.

Describa las caracteristicas de una estructura del tipo de dato vector y describa los pasos necesarios de la operacion de busqueda de un elemento en dicha estructura.
- Un vector es una estructura de datos ordinal, indexada y compuesta por N cantidad de datos del mismo tipo (homogenea). Puede accederse a cualquier posicion del vector sin necesidad de ir accediendo secuencialmente uno por uno.
- Asumiendo que el vector no esta ordenado. Defino una variable OK de tipo boolean inicializada en false, y mientras el indice sea menor a la dimension logica del vector y OK sea false comparo si el valor buscado es igual al valor actual del vector, si lo es OK pasa a ser verdadero.

Teniendo en cuenta las referencias, calcule e indique la cantidad de memoria estática y el tiempo de ejecución. Muestre cómo obtiene resultado.
program ejercicio5;
type
  cadena20 = string[20]; -> 21 bytes
  notas = 2..10; -> 4 bytes
  alumno = record -> 21 + 4 = 25 bytes
    ape_nom: cadena20;
    nota: integer;
  end;
  vector = array [1..10] of ^alumno; -> 10 * 4 = 40 bytes
var MEMORIA ESTATICA: 40 + 4 * 3 + 21 = 73 bytes
  v: vector; -> 40
  i: integer; -> 4
  sum: integer; -> 4
  nota: notas; -> 4
  apeNom: cadena20; -> 21
begin 
  for i := 1 to 10 do -> 3 * 10 + 2 + 10(3) = 32 + 30 = 60ut
  begin
    new(v[i]);
    read(nota);
    read(apeNom);
    v[i]^.nota := nota; 1ut
    v[i]^.ape_nom := apeNom; 1ut
    sum := 0; 1ut
  end;
  while (sum < 200) do -> (200 * 1) + 200(2) = 600ut
  begin
    read(nota);
    sum := sum + nota;
  end;
end. TIEMPO DE EJECUCION =  660ut

Referencia
  Char      : 1 byte
  Integer   : 4 bytes
  Real      : 8 bytes
  Boolean   : 1 byte
  String    : Longitud + 1
  Puntero   : 4 bytes
}