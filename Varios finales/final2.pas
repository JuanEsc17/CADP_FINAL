program final2;
const
	exactProds = 5;
	dimF = 500;
type
	venta = record
		numero:integer;
		monto:real;
		productos:lista;
	end;
	producto = record
		codigo:integer;
		cant:integer;
	end;
	lista = ^nodo;
	nodo = record
		p:producto;
		sig:lista;
	end;
	
	ventas = ^nodoV;
	nodoV = record
		v:venta;
		sig:ventas;
	end;

procedure cargarVentas(var v:ventas); // se dispone

procedure eliminarProductos(var l:lista);
var act:lista;
begin
	while(l<>nil)do begin
		act:=l;
		l:=l^.sig;
		dipose(act);
	end;
end;

function hasFiveProds(l:lista):boolean;
var cont:integer;
begin
	while(cont <= exactProds and l <> nil) do begin
		cont:= cont + 1;
		l:= l^.sig;
	end;
	hasFiveProds:= cont = exactProds;
end

procedure procesarVentas(var l:ventas);
var
	act, ant: ventas;
begin
	ant:=l;
	act:=l;
	while(act<>nil)do begin
		if(hasFiveProds(act^.v.productos))then begin
			if(act = ant) then
				l:=l^.sig
			else
				ant^.sig:=act^.sig;
			eliminarProductos(act^.v.productos);
			dispose(act);
			act:=ant;
		end else begin
			ant:=act;
			act:=act^.sig;
		end;
	end;	
end

var
	ventas:ventas;
Begin
	cargarVentas(ventas); // se dispone
	procesarVentas(ventas);
End.
