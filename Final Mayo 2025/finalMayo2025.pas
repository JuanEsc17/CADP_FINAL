program final;
type
	producto = record
		cod: integer;
		precio: real;
		stock: integer;
		codFab: integer;
	end;
	
	lista = ^nodo
	nodo = record
		prod: producto;
		sig: lista;
	end;
	
	fab = record
		codFab:integer;
		cant:integer;
	end;
	listFab = ^nodoFab
	nodoFab = record
		fab: fab;
		sig: listaFab;
	end;
	
// modulos
procedure agregarFab(var l:listFab; cod,cant:integer);
var
	aux:listFab;
begin
	new(aux);
	aux^.fab.codFab:= cod;
	aux^.fab.cant:= cant;
	aux^.sig:= l;
	l:=aux;
end;

procedure procesar(listaEmp:lista; listaProv:lista; var porcentaje:real; var cants: listFab);
var
	total, aumento, codAct, totalFab:integer; auxProv:listFab;
begin
	total:= 0;
	aumento:= 0;
	cants:= nil;
	while (listaEmp <> nil) do begin
		codAct:= listaEmp^.prod.codFab;
		totalFab:= 0;
		auxProv:= listaProv;
		while (auxProv <> nil) do begin
			if (auxProv^.prod.codFab = codAct) then begin
				total:= total + 1;
				totalFab:= totalFab + 1;
				if (auxProv^.prod.precio > listaEmp^.prod.precio) then
					aumento: = aumento + 1;
				if (auxProv^.prod.stock > listaEmp^.prod.stock) then
					listaEmp^.prod.stock:= 0
				else
					listaEmp^.prod.stock:= listaEmp^.prod.stock - auxProv^.prod.stock;
			end;
			auxProv:= auxProv^.sig;
		end;
		agregarFab(cants, codAct, totalFab);
		listaEmp:= listaEmp^.sig;
	end;
	porcentaje:= (aumento / total) * 100
end;
	
	

