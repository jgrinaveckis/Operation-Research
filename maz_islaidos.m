function [q, t, x_min_mid, f_min, islaidos, iteration, lenght, xfminbnd, yfminbnd] = maz_islaidos(start, endp)
  [x_min_mid, f_min, new_start, new_endp, iteration, lenght, xpoint, xvalue] = dalijimas_pusiau(start, endp);
  vidurio_taskas = (new_start+new_endp)/2; 
  vid_tasko_apacia = floor(vidurio_taskas);          
  f_apacia = tikslo_funkcija(vid_tasko_apacia);    
  vid_tasko_virsus = ceil(vidurio_taskas);            
  f_virsus = tikslo_funkcija(vid_tasko_virsus);      
  
  if(f_apacia > f_virsus)                         
    islaidos = f_virsus; %i�saugoma vir�utine reik�me
    t = vid_tasko_virsus; %i�saugoma reik�me
  else 
    islaidos = f_apacia; %i�saugoma apatine reik�me
    t = vid_tasko_apacia; %i�saugoma reik�me
  end
 
  x = start:1:endp; %vektorius nuo prad�ios iki pabaigos
  y = tikslo_funkcija(x); %i�laidos kiekviename ta�ke
 
  %aukso pjuvio ir kvadratines interpoliacijos metodo naudojimas
  optimizacija = optimset('Display', 'iter','MaxFunEvals', 1000,'PlotFcns', @optimplotfval , 'TolX', lenght);
  [xfminbnd, yfminbnd] = fminbnd(@tikslo_funkcija, start, endp, optimizacija);
  
  figure % grafikas
  plot(x, y, '.-', xpoint, xvalue, '.-'), legend('Kiekviename ta�ke', 'Dalijant intervala pusiau'); 
  title('Prekybos bazes islaidu kitimas pagal perioda t');
  xlabel('Prekiu ve�imo periodas (t)');
  ylabel('Prekybos bazes i�laidos per diena'); 
  
  b = mod(20132760, 7)/2 + 2.5; 
  q = t * b;
  
end
% intervalo dalijimo pusiau metodo funkcija
function [x_min_mid, f_min, new_start, new_endp, iteration, lenght1, xpoint, xvalue] = dalijimas_pusiau(start, endp)
    iteration = 1;               
    x_mid = (start + endp)/2; %vidurio ta�kas
    fx_mid = tikslo_funkcija(x_mid);    %turimo matematinio modelio reik�m? intervalo vidurio ta�ke
    x_min_mid = x_mid;           %turima minimali intervalo vidurio koordinat?
    fx_mid1 = fx_mid;            %nauja funkcijos reik�m?
    fx_mid2 = fx_mid;            %nauja funkcijos reik�m?  
    xpoint(iteration) = x_mid;   %i�saugomas ta�kas
    xvalue(iteration) = fx_mid1; %i�saugoma f-jos reik�m? x_mid ta�ke 
    new_start = start;     
    new_endp = endp;     
    lenght = endp - start;  %turimas intervalo ilgis
    lenght1 = lenght;            %i�saugomas intervalo ilgis
 
    while fx_mid2 >= fx_mid1
    iteration = iteration + 1; 
        x1 = start + lenght/4; %+ ketvirtis ilgio prie pradinio ta�ko ir gausime nauj? prad�i?
        x2 = endp - lenght/4; %nauja intervalo pabaiga
        fx1 = tikslo_funkcija(x1); %funkcija naujoje intervalo prad�ioje
        fx2 = tikslo_funkcija(x2); %funkcija naujoje intervalo pabaigoje
        
        %Jeigu funkcijos reik�m? naujoje intervalo prad�ioje yra ma�esne u�
        %matematinio modelio reik�m? buvusiame vidurio ta�ke
        if(fx1 < fx_mid)
            endp = x_mid;     %intervalo pabaiga = buv?s vidurio ta�kas
            x_mid = x1;          %buv?s vidurio ta�kas tampa nauja intervalo prad�ia
        else 
        %Kitu atveju, jei funkcijos reik�m? naujoje intervalo pabaigoje yra ma�esn?
        %u� matematinio modelio reik�m? buvusiame vidurio ta�ke, tuomet
            if(fx2 < fx_mid)                
                start = x_mid; %intervalo prad�ia yra lygi buvusiam vidurio ta�kui
                x_mid = x2;      %buv?s vidurio ta�kas tampa intervalo pabaiga
            else
                start = x1;    %intervalo prad�ia pasistumia ketvirtadaliu viso intervalo ilgio
                endp = x2;      %intervalo pabaiga atsitraukia ketvirtadaliu ilgio
            end
        end
        
        fx_mid1 = tikslo_funkcija(x_mid); %modelio reik�m? naujame vidurio ta�ke
        xpoint(iteration) = x_mid;   %i�saugomas ta�kas
        xvalue(iteration) = fx_mid1; %i�saugoma reik�m?
        lenght = endp - start;  %naujas intervalo ilgis
        if(fx_mid2 > fx_mid1)      %jeigu tenkina s?lyg?, perra�omos reik�m?s  
            lenght1 = lenght;        
            new_start = start; 
            new_endp = endp; 
            x_min_mid = x_mid;       
            fx_mid2 = fx_mid1;       
        end
    end
    f_min = fx_mid2;
 end
function ft =  tikslo_funkcija(t)
    b = mod(20132760, 7)/2 + 2.5; 
    c2 = mod(20132760, 30) + 150;
    c = mod(20132760, 5) + 3;
    %Matematinis modelis
    ft = b*c*t + c2./t;
end