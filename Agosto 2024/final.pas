program final;
const
    maxAlumnos = 1000;
type
    noCumplen = array[1..maxAlumnos] of integer;

    estudiante = record
        DNI: integer;
        apellido: String[15];
        legajo: String[8];
    end;

    lista = ^nodo;
    nodo = record
        e:estudiante;
        sig:lista;
    end;

procedure cargarAlumnosQueNoCumplen(var v:noCumplen; var dimL:integer); //se dispone
procedure cargarAlumnos(var l:lista); // se dispone

procedure eliminar(var l:lista; dni:integer);
var ant, act:lista;
begin
    ant:=l;
    act:=l;
    while (act <> nil) and (act^.e.DNI < dni) do begin
        ant:= act;
        act:= act^.sig;
    end;
    if (act <> nil) and (act^.e.DNI = dni) then begin
        if (act = ant) then
            l:= l^.sig
        else
            ant^.sig:= act^.sig;
        dispose(act);
        act:= ant;
    end;
end;

procedure eliminarAlumnos(var l:lista; v:noCumplen; dimL:integer);
var i:integer; aux:lista;
begin
    for i:= 1 to dimL do begin
        aux:=l;
        eliminar(aux, v[i])
    end;
end;

var
    dimL:integer;
    v:noCumplen;
    l:lista;
begin
    cargarAlumnosQueNoCumplen(v, dimL);
    cargarAlumnos(l);
    eliminar(l, v, dimL);
end.
{
2.
    A: Es incorrecto porque al hacer while (l^.sig <> nil) el ultimo nodo nunca se procesaria.
    B: El dos es correcto ya que accede a cada nodo y frena cuando ya no apunte a ningun nodo.
    C: Es incorrecto porque pasa el parametro por referencia cosa que no esta bien ya que no es necesario. Adems de que pierde el puntero al primer nodo y tambien dentro del while primero avanza de nodo y luego duplica osea que nunca duplicaria el primer nodo.

4.
    a: Falso, ya que case solo interpreta datos ordinarios.
    b: Verdadero, si se tiene la dimension logica solo habria que verificar si la dimension logica actual es menor a la fisica y luego aumentar la dimension logica y agregar el elemento, en cambio con una lista hay que recorrerla hasta el final y agregar.
    c: Verdadero, ya que todo el tiempo pueden encontrarse errores en el codigo.
    d: Falso, no siempre es mejor tener un vector ya que si se declara un vector de 100 posiciones de 10 bytes cada una y solo se van a ocupar 5 posiciones es mejor tener una lista que ocupa lo justo y necesario.
    e: Verdadero, ya que para modificar los valores contenidos de una lista no es necesario cambiar el valor del puntero.
    f: Falso, T(algoritmo) = 43ut
    g: Verdadero, la memoria estatica requerida por el programa es de 82 bytes

program ejercicio4;
const
  dimF = 15;
type
  vector = array [5..dimF] of ^integer; -> 11*4 = 44bytes

  info = record -> 16 + 10 + 44 = 70 bytes
    nombre: string[15];
    prom: real;
    datos: vector;
  end;

var
  i, nota: integer; -> 12 bytes
  e: info; -> 70 bytes

begin
  read(e.nombre); 
  read(e.prom);
  i := 4; -> 1ut
  read(nota);
  while ((i < 11) and (nota <> -1)) do begin -> N(cond) + N(cuerpo) = 7(3) + 7(3) = 42ut
    i := i + 1; -> 2ut
    new(e.datos[i]);
    e.datos[i]^ := nota; -> 1ut
    read(nota);
  end;
end.
}