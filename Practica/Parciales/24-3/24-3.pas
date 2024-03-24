Program ejVentasAutos;
type
    venta = record
        cod: integer;
        modelo: string;
        DNI: integer;
        dia: integer;
    end;
    
    ventas = ^nodo;
    
    nodo = record
        dato: venta;
        sig : ventas;
    end;
    
    resumenVenta = record
        modelo: string;
        cantidad: integer;
    end;
    
    resumenesDeVentas = ^nodoResumen;
    
    nodoResumen = record
        dato: resumenVenta;
        sig: resumenesDeVentas;
    end;
    
    
    diasMes = array[1..28] of integer;    
    
    
//////////////////////////////////////////////////////////////
procedure inicializarArreglo(var d: diasMes);
var i: integer;
begin
    for i:=1 to 28 do d[i] := 0;
end;
/////////////////////////////////////////////////////////////
procedure cargarVenta(var v:venta);
begin

    readln(v.modelo);
    
    if(v.modelo <> 'ZZZ') then begin
        readln(v.cod);
        readln(v.DNI);
        readln(v.dia);
    end;

end;
/////////////////////////////////////////////////////////////
procedure anadirAdelanteVenta(var l: ventas; v: venta);
var act, nue, ant: ventas;
begin
    
    new(nue);
    nue^.dato := v;
    
    act := l;
    ant := l;
    
    while (act <> nil) do begin
        ant := act;
        act := act^.sig;
    end;
    
    if(act = ant) then l := nue
                else ant^.sig :=  nue;
    
    nue^.sig := act;
    
end;
/////////////////////////////////////////////////////////////
procedure anadirAdelanteResumenVentas(var l: resumenesDeVentas; v: resumenVenta);
var act, nue, ant: resumenesDeVentas;
begin
    
    new(nue);
    nue^.dato := v;
    
    act := l;
    ant := l;
    
    while (act <> nil) do begin
        ant := act;
        act := act^.sig;
    end;
    
    if(act = ant) then l := nue
                else ant^.sig :=  nue;
    
    nue^.sig := act;
    
end;
/////////////////////////////////////////////////////////////
procedure cargarListaVentas(var l: ventas);
var v: venta;
begin

    cargarVenta(v);
    while(v.modelo <> 'ZZZ') do begin
        anadirAdelanteVenta(l,v);
        cargarVenta(v);
    end;

end;
/////////////////////////////////////////////////////////////
procedure imprimirListaVenta(l: ventas);
begin
    writeln('----------------------------------');
    while(l <> nil) do begin
        writeln('Codigo de venta: ', l^.dato.cod);
        writeln('Modelo: ', l^.dato.modelo);
        writeln('DNI del comprador: ', l^.dato.DNI);
        writeln('Dia en el que se compro: ', l^.dato.dia);
        l := l^.sig;
        writeln('----------------------------------');
    end;

end;

/////////////////////////////////////////////////////////////
procedure imprimirListaResumenesDeVentas(l: resumenesDeVentas);
begin
    writeln('----------------------------------');
    while(l <> nil) do begin
        writeln('Modelo: ', l^.dato.modelo);
        writeln('Cantidad de ventas: ', l^.dato.cantidad);
        l := l^.sig;
        writeln('----------------------------------');
    end;

end;
/////////////////////////////////////////////////////////////
procedure procesar(l: ventas);
var act: string; lista: resumenesDeVentas; cantVentas: integer; resumen: resumenVenta; dias: diasMes; i, max, maxDia: integer;  ventasPar, totalVentas: real;
begin
    lista := nil;
    ventasPar := 0;
    totalVentas := 0;
    max := 0;
    
    inicializarArreglo(dias);
    while(l <> nil) do begin
        act := l^.dato.modelo;
        cantVentas := 0;
        while ((l <> nil) and (act = l^.dato.modelo)) do begin
            cantVentas := cantVentas + 1;
            totalVentas := totalVentas + 1;
            if((l^.dato.DNI mod 2) = 1) then dias[l^.dato.dia] := dias[l^.dato.dia] + 1
                                        else ventasPar := ventasPar + 1;
            l := l^.sig;
        end;
        
        resumen.modelo := act;
        resumen.cantidad := cantVentas;
        
        anadirAdelanteResumenVentas(lista, resumen);
    end;
    
    for i:= 1 to 28 do begin
        if(dias[i] >= max) then begin
            max := dias[i];
            maxDia := i;
        end;
    end;
    imprimirListaResumenesDeVentas(lista);
    writeln('Dia con mas ventas: ', maxDia, ' con una cantidad de: ', max, ' ventas');
    writeln('Porcentaje de dni pares: ', (ventasPar / totalVentas) * 100);
    
end;
/////////////////////////////////////////////////////////////
var l: ventas;
begin
    cargarListaVentas(l);
    //imprimirListaVenta(l);
    //procesar(l);
end.