Program Ejercicio1;
const
    DimFCostos = 20;
    DimFMeses = 12;
type
    viaje = record
        cod: integer;
        mes: 1..12;
        destino: 1..20;
        cantPasajeros : integer;
    end;
    
    lista = ^nodo;
    
    nodo = record 
        dato: viaje;
        sig: lista;
    end;
    
    costos = array [1..20] of integer;
    recaudacionMeses = array [1..12] of integer;

    
    resultadoA = record
        cod: integer;
        cantViajes : integer;
    end;
    
    listaResultadoA = ^nodoLista;
    
    nodoLista = record
        dato: resultadoA;
        sig: listaResultadoA;
    end;
    
//////////////////////////////////////////////////////////////////////  
procedure cargarViaje(var v : viaje);
begin
    readln(v.cod);
    if(v.cod <> -1) then begin
        readln(v.cantPasajeros);
        readln(v.mes);
        readln(v.destino);
    end;
end;
/////////////////////////////////////////////////////////////////////
procedure agregarLista(var l: lista; v : viaje);
var nue, act, ant: lista;
begin

    new(nue);
    nue^.dato := v;
    ant := l;
    act := l;
    
    while (act <> nil) do begin
    	ant := act;
    	act := act^.sig;
    end;
    
    if(ant = act) then
        l := nue
    else
        ant^.sig := nue;
        
    nue^.sig := nil;

end;
//////////////////////////////////////////////////////////////////////

procedure cargarLista(var l:lista);
var v:viaje;
begin
    
    cargarViaje(v);
    while(v.cod <> -1) do begin
        agregarLista(l, v);
        cargarViaje(v);    
    end;

end;

//////////////////////////////////////////////////////////////////////
procedure imprimirLista(l:lista);
begin

    while(l <> nil) do begin
        writeln('Codigo de viaje');
        writeln(l^.dato.cod);
        writeln('Cantidad de pasajeros');
        writeln(l^.dato.cantPasajeros);
        writeln('Mes del viaje');
        writeln(l^.dato.mes);
        writeln('Codigo de la ciudad destino');
        writeln(l^.dato.destino);
        l := l^.sig;
        writeln('--------------------');
    end;

end;
//////////////////////////////////////////////////////////////////////
procedure cargarCostos(var c: costos);
var i: integer;
begin

    for i := 1 to DimFCostos do begin
       c[i] := i+3;
    end;

end;
//////////////////////////////////////////////////////////////////////

procedure agregarListaResultadoA(var l: listaResultadoA; a : resultadoA);
var nue, act, ant: listaResultadoA;
begin

    new(nue);
    nue^.dato := a;
    ant := l;
    act := l;
    
    while (act <> nil) do begin
    	ant := act;
    	act := act^.sig;
    end;
    
    if(ant = act) then
        l := nue
    else
        ant^.sig := nue;
        
    nue^.sig := act;

end;
//////////////////////////////////////////////////////////////////////
procedure PuntoA(listaViajes: lista; var lis: listaResultadoA);
var codActual: integer; cantViajes: integer; res: resultadoA;
begin

    while (listaViajes <> nil) do begin
        codActual := listaViajes^.dato.cod;
        cantViajes := 0;
        while ((listaViajes <> nil) and (codActual = listaViajes^.dato.cod)) do begin
            cantViajes := cantViajes + 1;
            listaViajes := listaViajes^.sig;
        end;
        res.cod := codActual;
        res.cantViajes := cantViajes;
        agregarListaResultadoA(lis, res);
    end;

end;


//////////////////////////////////////////////////////////////////////
procedure imprimirListaResultadoA(l:listaResultadoA);
begin

    while(l <> nil) do begin
        writeln('Codigo de viaje');
        writeln(l^.dato.cod);
        writeln('Cantidad de viajes');
        writeln(l^.dato.cantViajes);
        l := l^.sig;
        writeln('--------------------');
    end;
    

end;
//////////////////////////////////////////////////////////////////////
procedure inicializarRecaudacionMeses(var m: recaudacionMeses);
var i: integer;
begin
    for i:= 1 to DimFMeses do m[i] := 0;
end;
//////////////////////////////////////////////////////////////////////
procedure calcularMaximo(m: recaudacionMeses);
var i,max, mesMax: integer;
begin
    max := -1;
    for i:= 1 to DimFMeses do begin
        if(m[i] > max) then begin
            max := m[i];
            mesMax := i;
        end;
    end;
    
    writeln('El mes: ', mesMax, ' fue el mes que mas recaudo con la cantidad de: ', max);
    
end;
//////////////////////////////////////////////////////////////////////
procedure PuntoB(lis: lista; var m : recaudacionMeses; c: costos);
var mesMaximo : integer;
begin
    while(lis <> nil) do begin
        m[lis^.dato.mes] := m[lis^.dato.mes] + c[lis^.dato.destino];
        lis := lis^.sig;
    end;
    
    calcularMaximo(m);
    
end;
//////////////////////////////////////////////////////////////////////

var listaViajes : lista; c : costos; lis : listaResultadoA; meses : recaudacionMeses;
begin
   listaViajes := nil;
   cargarCostos(c);
   cargarLista(listaViajes);
   imprimirLista(listaViajes);
   PuntoA(listaViajes, lis);
   imprimirListaResultadoA(lis);
   inicializarRecaudacionMeses(meses);
   PuntoB(listaViajes, meses, c);
end.