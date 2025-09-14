program final;
const
	maxSucu = 5;
type
	sucursales = 1..maxSucu;
	factura = record
		numero:integer;
		codSuc:sucursales;
		montoTotal:real;
	end;
	
	lista = ^nodo;
	nodo = record
		fact: factura;
		sig: lista;
	end;
	
// modulos
procedure eliminarOcurrencias(var l:lista; cod:sucursales; var monto:real);
var
	act,ant:lista;
begin
	act:=l;
	ant:=l;
	while(act<>nil) do begin
		if(act^.fact.codSuc = cod) then begin
			monto:= monto + act^.fact.montoTotal;
			if (act = ant) then
				l:=l^.sig
			else
				ant^.sig:= act^.sig;
			dispose(act);
			act:=ant;
		end else begin
		ant:= act;
		act:=act^.sig;
		end;
	end;
end;

//principal program
var
	l:lista;
	cod:sucursales;
	monto:real;
Begin
	cargarFacturas(l); //se dispone
	writeln('Ingrese un codigo de sucursal');
	readln(cod);
	monto:=0;
	eliminarOcurrencias(l,cod,monto);
	writeln('El monto total eliminado es: ', monto);
End.
