function [q, t, x_min_mid, f_min, islaidos, iteration, lenght, xfminbnd, yfminbnd] = maz_islaidos(start, endp)
  [x_min_mid, f_min, new_start, new_endp, iteration, lenght, xpoint, xvalue] = dalijimas_pusiau(start, endp);
  vidurio_taskas = (new_start+new_endp)/2; 
  vid_tasko_apacia = floor(vidurio_taskas);          
  f_apacia = tikslo_funkcija(vid_tasko_apacia);    
  vid_tasko_virsus = ceil(vidurio_taskas);            
  f_virsus = tikslo_funkcija(vid_tasko_virsus);      
  
  if(f_apacia > f_virsus)                         
    islaidos = f_virsus; %išsaugoma viršutine reikšme
    t = vid_tasko_virsus; %išsaugoma reikšme
  else 
    islaidos = f_apacia; %išsaugoma apatine reikšme
    t = vid_tasko_apacia; %išsaugoma reikšme
  end
 
  x = start:1:endp; %vektorius nuo pradžios iki pabaigos
  y = tikslo_funkcija(x); %išlaidos kiekviename taške
 
  %aukso pjuvio ir kvadratines interpoliacijos metodo naudojimas
  optimizacija = optimset('Display', 'iter','MaxFunEvals', 1000,'PlotFcns', @optimplotfval , 'TolX', lenght);
  [xfminbnd, yfminbnd] = fminbnd(@tikslo_funkcija, start, endp, optimizacija);
  
  figure % grafikas
  plot(x, y, '.-', xpoint, xvalue, '.-'), legend('Kiekviename taške', 'Dalijant intervala pusiau'); 
  title('Prekybos bazes islaidu kitimas pagal perioda t');
  xlabel('Prekiu vežimo periodas (t)');
  ylabel('Prekybos bazes išlaidos per diena'); 
  
  b = mod(20132760, 7)/2 + 2.5; 
  q = t * b;
  
end
% intervalo dalijimo pusiau metodo funkcija
function [x_min_mid, f_min, new_start, new_endp, iteration, lenght1, xpoint, xvalue] = dalijimas_pusiau(start, endp)
    iteration = 1;               
    x_mid = (start + endp)/2; %vidurio taškas
    fx_mid = tikslo_funkcija(x_mid);    %turimo matematinio modelio reikšm? intervalo vidurio taške
    x_min_mid = x_mid;           %turima minimali intervalo vidurio koordinat?
    fx_mid1 = fx_mid;            %nauja funkcijos reikšm?
    fx_mid2 = fx_mid;            %nauja funkcijos reikšm?  
    xpoint(iteration) = x_mid;   %išsaugomas taškas
    xvalue(iteration) = fx_mid1; %išsaugoma f-jos reikšm? x_mid taške 
    new_start = start;     
    new_endp = endp;     
    lenght = endp - start;  %turimas intervalo ilgis
    lenght1 = lenght;            %išsaugomas intervalo ilgis
 
    while fx_mid2 >= fx_mid1
    iteration = iteration + 1; 
        x1 = start + lenght/4; %+ ketvirtis ilgio prie pradinio taško ir gausime nauj? pradži?
        x2 = endp - lenght/4; %nauja intervalo pabaiga
        fx1 = tikslo_funkcija(x1); %funkcija naujoje intervalo pradžioje
        fx2 = tikslo_funkcija(x2); %funkcija naujoje intervalo pabaigoje
        
        %Jeigu funkcijos reikšm? naujoje intervalo pradžioje yra mažesne už
        %matematinio modelio reikšm? buvusiame vidurio taške
        if(fx1 < fx_mid)
            endp = x_mid;     %intervalo pabaiga = buv?s vidurio taškas
            x_mid = x1;          %buv?s vidurio taškas tampa nauja intervalo pradžia
        else 
        %Kitu atveju, jei funkcijos reikšm? naujoje intervalo pabaigoje yra mažesn?
        %už matematinio modelio reikšm? buvusiame vidurio taške, tuomet
            if(fx2 < fx_mid)                
                start = x_mid; %intervalo pradžia yra lygi buvusiam vidurio taškui
                x_mid = x2;      %buv?s vidurio taškas tampa intervalo pabaiga
            else
                start = x1;    %intervalo pradžia pasistumia ketvirtadaliu viso intervalo ilgio
                endp = x2;      %intervalo pabaiga atsitraukia ketvirtadaliu ilgio
            end
        end
        
        fx_mid1 = tikslo_funkcija(x_mid); %modelio reikšm? naujame vidurio taške
        xpoint(iteration) = x_mid;   %išsaugomas taškas
        xvalue(iteration) = fx_mid1; %išsaugoma reikšm?
        lenght = endp - start;  %naujas intervalo ilgis
        if(fx_mid2 > fx_mid1)      %jeigu tenkina s?lyg?, perrašomos reikšm?s  
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