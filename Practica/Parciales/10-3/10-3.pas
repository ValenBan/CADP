Program Ej2;
const
    cantPlanes = 3;
type
    listaCliente = ^nodo;
    
    plan = record
        costo: integer;
        sesiones: integer;
    end;
    
    cliente = record
        nombre: string;
        DNI: string;
        ciudad: string;
        codPlan: 1..cantPlanes;
        finalizado: boolean;
    end;
    
    nodo = record
        dato: cliente;
        sig : listaCliente;
    end;
    
    planes = array[1..cantPlanes] of plan;
    
    

////////////////////////////////////////////////////////////
procedure inicializarPlanes(var p: planes);
begin
   p[1].costo := 100;
   p[1].sesiones := 10;

   p[2].costo := 200;
   p[2].sesiones := 20;
   
   p[3].costo := 300;
   p[3].sesiones := 30;
end;
////////////////////////////////////////////////////////////
procedure cargarCliente(var c: cliente);
var fin : string;
begin
    readln(c.nombre);
    readln(c.DNI);
    if((c.nombre <> 'Mirtha Legrand') or (c.DNI <> '44933907')) then begin

        readln(c.ciudad);
        readln(c.codPlan);
        readln(fin);
        if(fin = 'true') then c.finalizado := true
                         else c.finalizado := false;
    
    end;

end;
////////////////////////////////////////////////////////////
procedure agregarAdelante(var l: listaCliente; c: cliente);
var nue, ant, act: listaCliente;
begin
    new(nue);
    nue^.dato := c;
    
    ant := l;
    act := l;
    
    while (act <> nil) do begin
        ant := act;
        act :=  act^.sig;
    end;
    
    if(ant = act) then l := nue
                  else ant^.sig := nue;
    nue^.sig := act;

end;
////////////////////////////////////////////////////////////
procedure cargarLista(var l:listaCliente);
var c: cliente;
begin

    cargarCliente(c);
    while((c.nombre <> 'Mirtha Legrand') or (c.DNI <> '44933907')) do begin
        agregarAdelante(l, c);
        cargarCliente(c); 
    end;

end;
////////////////////////////////////////////////////////////
procedure imprimirLista(l:listaCliente);
begin
    writeln('-------------------------');
    while(l <> nil) do begin
        writeln('Nombre: ', l^.dato.nombre);
        writeln('DNI: ', l^.dato.DNI);
        writeln('Ciudad: ', l^.dato.ciudad);
        writeln('codido de plan: ', l^.dato.codPlan);
        writeln('Tratamiento finalizado: ', l^.dato.finalizado);
        writeln('-------------------------');
        l := l^.sig;
    end;
    
end;
////////////////////////////////////////////////////////////
function contadorClientes(l: listaCliente): integer;
var contador: integer;
begin
    contador := 0;
    while (l <> nil) do begin
        
        if((not l^.dato.finalizado) and (l^.dato.ciudad = 'Bragado')) then contador := contador + 1;
        
        l := l^.sig;
    
    end;
    contadorClientes := contador;
    
end;
////////////////////////////////////////////////////////////
function contadorGanancias(l: listaCliente; p:planes): integer;
var contador: integer;
begin
    contador := 0;
    while (l <> nil) do begin
        
        contador := contador + p[l^.dato.codPlan].costo;
        
        l := l^.sig;
    
    end;
    contadorGanancias := contador;
    
end;
////////////////////////////////////////////////////////////
var l: listaCliente; p: planes; cantClientes: integer; gananciaTotal: integer;
begin
    inicializarPlanes(p);
    cargarLista(l);
    imprimirLista(l);
    cantClientes := contadorClientes(l);
    gananciaTotal := contadorGanancias(l, p);
    writeln(cantClientes);
    writeln(gananciaTotal);
end.