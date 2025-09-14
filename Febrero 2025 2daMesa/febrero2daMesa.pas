program final;
const
	codigoMax = 15;
type
	codigos = 1..15;
	prestamo = record
		codigo: codigos;
		fecha: String[10];
		codLibro: integer;
	end;
	contadores = array[codigos] of integer;
	lista = ^nodo;
	nodo = record
		p: prestamo;
		sig: lista;
	end;

procedure procesarLista(l:lista; var conts:contadores);
begin
	while(l <> nil) do begin
		conts[l^.p.codigo]:= conts[l^.p.codigo] + 1;
		l:=l^.sig;
	end;
end;

procedure calcularValores(conts:contadores; var codMax:integer);
var
	cantMax:integer; i:codigos;
begin
	cantMax:=-1;
	codMax:=-1;
	for i:= 1 to codigoMax do begin
		if (conts[i] > cantMax) then begin
			codMax:= i;
			cantMax:=conts[i];
		end;
		writeln('Cantidad de prestamos con codigo ',i,' es: ', conts[i]);
	end;
end;

procedure inicializarContadores(var conts:contadores);
var i:codigos;
begin
	for i:= 1 to codigoMax do
		conts[i]:= 0;
end;

var
	l:lista;
	conts:contadores;
	codMax:integer;
Begin
	cargarLista(l);// se dispone
	inicializarContadores(conts);
	procesarLista(l,conts)
	calcularValores(conts, codMax);
	writeln('Codigo con mayor cantidad de prestamos: ',codMax);
end.
	
