{
pagina 11 del PDF
Se dispone de la información de los participantes inscriptos a una carrera (a lo sumo 5000). De cada 
participante se tiene DNI, nombre y apellido, categoría (1..5) y fecha de inscripción. Se pide implementar un 
programa que guarde en una estructura adecuada los participantes de aquellas categorías que posean a lo sumo 50 
inscriptos. Se sabe que cada participante se puede anotar en una sola categoría.
}
program silksong;
const 
    maxCat = 5;
    maxAlumnos = 5000;
type
    rangoCat = 1..maxCat;
    alumno = record
        DNI:integer;
        nom_ape:String[25];
        categoría: rangoCat;
    end;
    alumnos = array[1..maxAlumnos] of alumno;

    lista = ^nodo;
    nodo = record
        a: alumno;
        sig: lista;
    end;

    contadores = array[rangoCat] of integer;

procedure cargarAlumnos(var v:alumnos; var dimL:integer); // se dispone

procedure contarAlumnos(v:alumnos; dimL:integer; var c:contadores);
    procedure inicializar(var c:contadores);
    var i: integer;
    begin
        for i:= 1 to maxCat do 
            c[i]:=0;
    end;
var
    i:integer;
begin
    inicializar(c);
    for i:= 1 to dimL do
        c[v[i].categoría]:= c[v[i].categoría] + 1;
end;

procedure cargarNuevaLista(c:contadores; dimL:integer; v:alumnos; var l:lista);
var 
    i:integer;
begin
    for i:= 1 to dimL do begin
        if(c[v[i].categoria] <= 50) then
            agregar(l,v[i]);
    end;
end;

procedure agregar(var l: lista; a:alumno);
var aux:lista;
begin
    new(aux);
    aux^.a:=a;
    aux^.sig:=l;
    l:=aux;
end;

var
    v:alumnos;
    dimL:integer;
    l:lista;
    c:contadores;
begin
    l:= nil;
    cargarAlumnos(v, dimL); //se dispone
    contarAlumnos(v, dimL, c);
    cargarNuevaLista(c, dimL, v, l);
end;

{
2. Indique para las siguientes proposiciones, si son Verdaderas o Falsas. Justifique cada caso.
- No es posible la utilización de las variables globales para la comunicación entre los módulos de un programa.
    Falso, la comunicacion por variables globales es una de las maneras de comunicarse con los modulos pero no es una buena practica porque puede resultar confuso por ende dar resultados no esperados.
- Siempre es posible realizar la eliminación de un elemento en un vector.
    Falso, si el vector al que le voy a eliminar un elemento esta vacio no se podra hacer.
- Un programa modularizado puede no ser correcto.
    Verdadero, ya que la modularizacion y un programa correcto son dos conceptos independientes, un programa puede estar bien modularizado pero no lograr lo esperado.
- El acceso a un elemento de una estructura de datos lineal sólo es posible a través de un recorrido secuencial.
    Falso, por ejemplo un vector es una estructura de datos lineal y se puede acceder a cualquier elemento sin necesidad de acceder a su predecesor

3.Dada la siguiente declaración de tipos de datos y variables, justificar para cada sentencia numeradas si 
son válidas o inválidas:

program ejercicio_3;
type
  cadena50 = string[50];
  cliente = record
    DNI: cadena50;
    ape_nom: cadena50;
  end;
  clientes = ^nodo;
  nodo = record
    dato: cliente;
    sig: clientes;
  end;
var
  c: cliente;
  cli: clientes;
  cli_esp: clientes;
begin
  1. read(c); invalido, hay que leer campo por campo.
  2. new(c); invalido, el new es para reservar espacio en memoria y solo funciona con variables de tipo puntero.
  3. cli := nil; valido, este puntero no apunto a ningun espacio en memoria.
  4. new(cli); valido, reserva un espacio en memoria y se le asigna el valor de ese espacio a la variable.
  5. cli_esp := cli; valido, le asigna el mismo espacio en memoria que a cli.
  6. dispose(cli); valido, elimina el espacio en memoria.
  7. read(cli_esp^.DNI); invalido, cli ahora no apunta a nada.
  8. write(cli_esp^.DNI); invalido, lo mismo que el 7
end.

4. Describa las formas de comunicacion entre modulos vistas en la materia.
-Comunicacion por parametros:
    Pasados por valor: envia una copia del valor mandado por parametro, por ende este no se vera afectado en el modulo donde fue llamado.
    Pasados por referencia: envia una referencia al espacio en memoria donde se encuentra la variable pasada, de esta manera cualquier cambio en el modulo se va a reflejar en su modulo original.
-Comunicacion por variables globales:
    Estas variables se declaran por debajo de la declaracion de tipos, estas pueden modificarse desde cualquier punto del programa sin necesidad de pasarse por parametro. No se recomienda usarla porque puede ser compleja y confusa al momento de leer y entender el codigo.
}