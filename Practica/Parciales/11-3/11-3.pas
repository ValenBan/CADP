Program Ej3;
const
cantModelos = 3;
type

    listaVentas = ^nodo;
    
    precioModelos = array[1..cantModelos] of integer;
    contadorPagos = array[1..6] of integer;
    
    venta = record
        modelo: 1..cantModelos;
        marca: string;
        codCliente: integer;
        medioPago: 1..6;
    end;
    
    nodo = record
        dato : venta;
        sig: listaVentas;
    end;
////////////////////////////////////////////////////////////////////
procedure inicializarContadorPagos(var cp: contadorPagos);
var i: integer;
begin
    for i:=1 to 6 do cp[i] := 0;
end;
////////////////////////////////////////////////////////////////////
procedure inicializarPrecioModelos(var pm: precioModelos);
var i: integer;
begin

    for i:=1 to cantModelos do begin
        pm[i] := i*100;
    end;
    
end;
////////////////////////////////////////////////////////////////////
procedure cargarVenta(var v: venta);
begin
    readln(v.codCliente);
    if(v.codCliente <> -1) then begin
        readln(v.modelo);
        readln(v.marca);
        readln(v.medioPago);
    end;

end;
////////////////////////////////////////////////////////////////////
procedure agregarAdelante(var l: listaVentas; v: venta);
var nue, ant, act: listaVentas;
begin
    new(nue);
    nue^.dato := v;
    
    ant := l;
    act := l;
    
    while (act <> nil) do begin
        ant := act;
        act := act^.sig;
    end;
    
    if(ant = act) then l := nue
                  else ant^.sig := nue;
    nue^.sig := act;

end;
////////////////////////////////////////////////////////////////////
procedure cargarListaVentas(var l: listaVentas);
var v: venta;
begin
    cargarVenta(v);
    while(v.codCliente <> -1) do begin
        agregarAdelante(l, v);
        cargarVenta(v);
    end;
end;
////////////////////////////////////////////////////////////////////
procedure leerLista(l: listaVentas);
begin
    writeln('--------------------------------');
    while(l <> nil) do begin
        writeln('Codigo de cliente: ', l^.dato.codCliente);
        writeln('Modelo: ', l^.dato.modelo);
        writeln('Marca: ', l^.dato.marca);
        writeln('Metodo de pago: ', l^.dato.medioPago);
        writeln('--------------------------------');
        l := l^.sig;
    end;
end;
////////////////////////////////////////////////////////////////////
procedure procesarPagos(var maxPago, maxPago2: integer; cp: contadorPagos);
var max, max2,i : integer;
begin
    max := 0;
    max2 := 0;
    for i:= 1 to 6 do begin
        if(cp[i] >  max) then begin
            max2 := max;
            maxPago2 := maxPago;
            max := cp[i];
            maxPago := i;
        end
        else begin
            if(cp[i] > max2) then begin
                max2 := cp[i];
                maxPago2 := i;
            end;
        end;
    end;
    
    writeln('El medio de pago el mayor monto total de ventas es: ', maxPago, ' con un total de: $', max);
    writeln('El segundo medio de pago el mayor monto total de ventas es: ', maxPago2, ' con un total de: $', max2);

end;
////////////////////////////////////////////////////////////////////
procedure puntoB(l: listaVentas; pm: precioModelos);
var cp: contadorPagos; maxPago, maxPago2: integer;
begin
    inicializarContadorPagos(cp);
    while(l <> nil) do begin
        cp[l^.dato.medioPago] := cp[l^.dato.medioPago] + pm[l^.dato.modelo];
        l := l^.sig;
    end;
    
    
    procesarPagos(maxPago, maxPago2, cp);
end;
////////////////////////////////////////////////////////////////////
function contadorLenovos(l: listaVentas): integer;
var contador: integer;
begin

    contador := 0;
    
    while(l<>nil) do begin
        if((l^.dato.marca = 'Lenovo') and (l^.dato.codCliente mod 2 = 0)) then contador := contador + 1;
        l := l^.sig;
    end;
    contadorLenovos := contador;
end;
////////////////////////////////////////////////////////////////////

var l: listaVentas; pm: precioModelos; cantLenovosCodPar: integer;
begin

    //inicializarPrecioModelos(pm);
    cargarListaVentas(l);
    //PuntoB(l, pm);
    cantLenovosCodPar := contadorLenovos(l);
    //leerLista(l);
    writeln('Cantidad de computadoras Lenovo con numero de clientre par: ', cantLenovosCodPar);
end.