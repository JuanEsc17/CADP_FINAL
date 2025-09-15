program final;
const
    filas = 20;
    columnas = 15;
type
    tablero = array[1..columnas] of columnas;
    columnas = array[1..filas] of boolean;

function dameNumeroFila():integer; // se dispone
function dameNumeroColumna():integer; //se dispone

procedure inicializarTablero(var t:tablero);
var f,c:integer;
begin
    for f:= 1 to filas do begin
        for c:= 1 to columnas do
            t[f][c]:= false;
    end;
end;

procedure asignarBarcos(var t:tablero);
var i, f, c:integer;
begin
    for i:= 1 to barcos do begin
        f:= dameNumeroFila();
        c:= dameNumeroColumna();
        t[f][c]:= true;
    end;
end;

function jugar(t:tablero; f,c:integer):boolean;
begin
    jugar:= t[f][c];
end;

procedure jugada(var t:tablero; var puntos:integer);
var
    f,c:integer;
begin
    f:= dameNumeroFila();
    c:= dameNumeroColumna();
    if (jugar(t, f, c)) then begin
        writeln('barco hundido!');
        t[f][c]:= false;
        puntos:= puntos + 1; 
    end else writeln('agua')
end;

var
    puntos1,puntos2,f,c,i:integer;
    tablero1, tablero2:tablero;
begin
    inicializarTablero(tablero1);
    inicializarTablero(tablero2);
    asignarBarcos(tablero1);
    asignarBarcos(tablero2);
    puntos1:= 0;
    puntos2:= 0;
    for i:= 1 to 10 do begin
        jugada(tablero1, puntos1);
        jugada(tablero2, puntos2);
    end;
    writeln('puntaje final');
    writeln('Puntos del jugador 1:', puntos1);
    writeln('Puntos del jugador 2:', puntos2);
    if (puntos1 > puntos2) then writeln('Ganador jugador 1')
    else if (puntos2 > puntos1) then writeln('Ganador jugador 2')
    else writeln('Empate');
end.

