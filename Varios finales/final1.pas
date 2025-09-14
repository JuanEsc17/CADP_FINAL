program final1;
const
	maxTipo = 12; //6 bytes
type
	tiposPub = 1..maxTipo;// 6 bytes
	publicacion = record// 16 + 31 + 6 + 6 = 49 bytes
		titulo: String[15];// 16
		autor: String[30];// 31
		dni: integer;// 6
		tipo: tiposPub;//6
	end;
	
	contadores = array[tiposPub] of integer;// 12*6 = 72 bytes
	
procedure inicializarContadores(var c:contadores);
var i: tiposPub;
begin
	for i:= 1 to maxTipo do
		c[i]:=0;
end;

function calcularMaximo(c:contadores): integer;
var i: tiposPub; maxCant, max:integer;
begin
	maxCant:=-1;
	max:=-1;
	for i:= 1 to maxTipo do begin
		if (c[i] > maxCant) then begin
			maxCant:=c[i];
			max:=i;
		end;
	end;
	calcularMaximo:= max;
end;

procedure leer(var p:publicacion);
begin
	writeln('Ingrese DNI, (ingrese 0 para finalizar)');
	readln(p.dni);
	if(p.dni <> 0)then begin
		writeln('ingrese titulo');
		readln(p.titulo);
		writeln('ingrese autor');
		readln(p.autor);
		writeln('ingrese el tipo de publicacion');
		readln(p.tipo);
	end;
end;

var // Memoria estatica: 72 + 6*2 + 49 = 133bytes (?
	c:contadores;// 72bytes
	act:integer;// 6 bytes
	contadorActual:integer;// 6 bytes
	p:publicacion;// 49 bytes
Begin
	inicializarContadores(c);
	leer(p);
	while(p.dni <> 0) do begin
		act:=p.dni;
		contadorActual:=0;
		while((p.dni = act) and (p.dni <> 0))do begin
			contadorActual:= contadorActual + 1;
			c[p.tipo]:= c[p.tipo] + 1;
			leer(p);
		end;
		writeln('El autor con DNI ',act,' tiene ',contadorActual,' publicaciones');
	end;
	writeln('tipo con mayor cantidad de publicaciones: ',calcularMaximo(c));
End.
