program Ej4;
const
    cantServicios = 3;
type
    listaTicket = ^nodo;
    ticket = record
        DNI: string;
        cod: integer;
        paisOrigen: string;
        paisDestino: string;
        valor: integer;
    end;
    nodo = record
        dato: ticket;
        sig: listaTicket;
    end;
    
    
    contadorVuelos = array[1..cantServicios] of integer;
/////////////////////////////////////////
procedure inicializarContadorVuelos(var c: contadorVuelos);
var i: integer;
begin
    for i:=1 to cantServicios do c[i] := 0;
end;
/////////////////////////////////////////
procedure cargarTicket(var t:ticket);
begin
    readln(t.DNI);
    if (t.DNI <> '-1') then begin
        readln(t.cod);
        readln(t.paisOrigen);
        readln(t.paisDestino);
        readln(t.valor);
    end;
end;
/////////////////////////////////////////
procedure agregarLista(var l: listaTicket; t: ticket);
var nue, ant, act: listaTicket;
begin
    new(nue);
    nue^.dato := t;
    
    ant := l;
    act := l;
    
    while(act <> nil) do begin
        ant := act;
        act := act^.sig;
    end;
    
    if(ant = act) then l := nue
                  else ant^.sig := nue;
    nue^.sig := act;
                 
end;
/////////////////////////////////////////
procedure cargarLista(var l:listaTicket);
var t:ticket;
begin
    cargarTicket(t);
    while(t.DNI <> '-1') do begin
        agregarLista(l,t);
        cargarTicket(t);
    end;
end;
/////////////////////////////////////////
procedure imprimirLista(l:listaTicket);
begin
    writeln('---------------------------------');
    while(l <> nil) do begin
        writeln('DNI: ', l^.dato.DNI);
        writeln('Codigo de servicio de vuelo: ', l^.dato.cod);
        writeln('Pais origen: ', l^.dato.paisOrigen);
        writeln('Pais destino: ', l^.dato.paisDestino);
        writeln('Valor: $', l^.dato.valor);
        writeln('---------------------------------');
        l := l^.sig;
    end;
end;
/////////////////////////////////////////
function PuntoA(l: listaTicket): integer;
var c: contadorVuelos; i, cant, max, contadorValor: integer; maxDNI, actDNI : string;
begin
    max := 0;

    inicializarContadorVuelos(c);
    while (l <> nil) do begin
        actDNI := l^.dato.DNI;
        contadorValor := 0;
        while ((l <> nil) and (actDNI = l^.dato.DNI)) do begin
            c[l^.dato.cod] := c[l^.dato.cod] + 1; 
            contadorValor := contadorValor + l^.dato.valor;
            l := l^.sig;
        end;
        
        if(contadorValor > max) then begin
            max := contadorValor;
            maxDNI := actDNI;
        end;
    end;
    cant := 0;
    for i := 1 to cantServicios do if(c[i] > 2) then cant := cant + 1;
    writeln('DNI con mayor cantidad de dinero gastado: ', maxDNI, ' con un gasto de: $', max);
    PuntoA := cant;
end;
/////////////////////////////////////////
var l:listaTicket; cantVuelosA : integer;
begin
    cargarLista(l);
    imprimirLista(l);
    cantVuelosA := PuntoA(l);
    writeln(cantVuelosA);
end.