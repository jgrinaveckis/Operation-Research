# Prekybos bazės uždavinys #

Prekybos bazė įsipareigojo saugoti prekes ir išduoti jas vartotojui kiekvieną dieną po 𝑏∗ tonų. Ji gali
gauti prekes periodiškai kas 𝑡 parų vienodo dydžio partijomis po 𝑞 tonų. Vienos prekių partijos
priėmimas ir pakrovimas į sandėlį kainuoja 𝑐2 Lt. Vienos tonos vidutinės išdavimo išlaidos 𝑐1 = 𝑐∗ ∙ 𝑡 Lt.
Naujos prekės vežamos paskutinę anksčiau atvežtų prekių išdavimo dieną. Reikia nustatyti optimalią
vienos prekių partijos apimtį 𝑞 ir jos vežimo periodą 𝑡, kad prekybos bazės išlaidos per parą būtų
mažiausios.

![](https://latex.codecogs.com/png.latex?b%5E*%20%3D%20%5Cfrac%7Bstud_n_r%20%5Ccdot%20mod%5C%3A7%7D%7B2%7D%20%3D%20%5Cfrac%7B20132760%5C%3A%20mod%5C%3A%207%7D%7B2%7D%20%3D%204.5)

![](https://latex.codecogs.com/png.latex?c_2%20%3D%20%28stud_n_r%5C%3B%20mod%5C%3B%2030%29%20&plus;%20150%20%3D%20%2820132760%5C%3B%20mod%5C%3B%2030%29%20&plus;%20150%20%3D%200&plus;150%3D150)

![](https://latex.codecogs.com/png.latex?c%5E*%20%3D%20%28stud_n_r%5C%3B%20mod%5C%3B%205%29&plus;3%20%3D%20%2820132760%5C%3B%20mod%5C%3B%205%29&plus;3%20%3D%200&plus;3%3D3)

## 1. Uždavinio matematinis modelis ##

Vienkartinės (vienos dienos) prekių išdavimo išlaidos - ![](https://latex.codecogs.com/gif.latex?c_1%5C%3B%20%5Ccdot%20b%5E*%5C%3A%20Lt)

Vienos dienos prekių priėmimo ir pakrovimo į sandėlį išlaidos - ![](https://latex.codecogs.com/gif.latex?t%5C%3B%20Lt)

Prekybos bazės išlaidos per parą aprašomos kintamojo 𝑡 funkcija: ![](https://latex.codecogs.com/gif.latex?c%28t%29%20%3D%5Cfrac%7Bc_2%7D%7Bt%7D%20&plus;%20c%5E*%5Ccdot%20t%5Ccdot%20b%5E*)

Be to, žinome, kad ![](https://latex.codecogs.com/gif.latex?t%3D%5Cfrac%7Bq%7D%7Bb%7D), todėl ![](https://latex.codecogs.com/gif.latex?q%3Dt%5Ccdot%20b)

Taigi, uždavinio matematinis modelis: ![](https://latex.codecogs.com/gif.latex?c%28t%29%20%3Dmin%28%5Cfrac%7Bc_2%7D%7Bt%7D%20&plus;%20c%5E*%5Ccdot%20t%5Ccdot%20b%5E*%29)

## 2. Tikslo funkcija ##

Tikslo funkcija - ![](https://latex.codecogs.com/gif.latex?c%28t%29%3Dmin%28%5Cfrac%7B150%7D%7Bt%7D&plus;3%5Ccdot%20t%5Ccdot%204.5%29%3Dmin%28%5Cfrac%7B150%7D%7Bt%7D&plus;13.5t%29)

## 3. Intervalo dalijimo pusiau metodas ##
1. Tikslo funkcija MATLAB aplinkoje su konkrečiais parametrais
```matlab
function [ft] =  tikslo_funkcija(t)
    b = mod(20132760, 7)/2 + 2.5; 
    c2 = mod(20132760, 30) + 150;
    c = mod(20132760, 5) + 3;
    %Matematinis modelis
    ft = b*c*t + c2./t;
end
```
2. Intervalo dalijimo pusiau metodas

```matlab
function [x_min_mid, f_min, new_start, new_endp, iteration, lenght1, xpoint, xvalue] = dalijimas_pusiau(start, endp)
    iteration = 1;               
    x_mid = (start + endp)/2; %vidurio taškas
    fx_mid = tikslo_funkcija(x_mid);    %turimo matematinio modelio reikšmė intervalo vidurio taške
    x_min_mid = x_mid;           %turima minimali intervalo vidurio koordinatė
    fx_mid1 = fx_mid;            %nauja funkcijos reikšmė
    fx_mid2 = fx_mid;            %nauja funkcijos reikšmė  
    xpoint(iteration) = x_mid;   %išsaugomas taškas
    xvalue(iteration) = fx_mid1; %išsaugoma f-jos reikšmė x_mid taške 
    new_start = start;     
    new_endp = endp;     
    lenght = endp - start;  %turimas intervalo ilgis
    lenght1 = lenght;            %išsaugomas intervalo ilgis
 
    while fx_mid2 >= fx_mid1
    iteration = iteration + 1; 
        x1 = start + lenght/4; %+ ketvirtis ilgio prie pradinio taško ir gausime naują pradžią
        x2 = endp - lenght/4; %nauja intervalo pabaiga
        fx1 = tikslo_funkcija(x1); %funkcija naujoje intervalo pradžioje
        fx2 = tikslo_funkcija(x2); %funkcija naujoje intervalo pabaigoje
        
        %Jeigu funkcijos reikšmė naujoje intervalo pradžioje yra mažesne už
        %matematinio modelio reikšmę buvusiame vidurio taške
        if(fx1 < fx_mid)
            endp = x_mid;     %intervalo pabaiga = buvęs vidurio taškas
            x_mid = x1;          %buvęs vidurio taškas tampa nauja intervalo pradžia
        else 
        %Kitu atveju, jei funkcijos reikšmė naujoje intervalo pabaigoje yra mažesnė
        %už matematinio modelio reikšmę buvusiame vidurio taške, tuomet
            if(fx2 < fx_mid)                
                start = x_mid; %intervalo pradžia yra lygi buvusiam vidurio taškui
                x_mid = x2;      %buvęs vidurio taškas tampa intervalo pabaiga
            else
                start = x1;    %intervalo pradžia pasistumia ketvirtadaliu viso intervalo ilgio
                endp = x2;      %intervalo pabaiga atsitraukia ketvirtadaliu ilgio
            end
        end
        
        fx_mid1 = tikslo_funkcija(x_mid); %modelio reikšmė naujame vidurio taške
        xpoint(iteration) = x_mid;   %išsaugomas taškas
        xvalue(iteration) = fx_mid1; %išsaugoma reikšmė
        lenght = endp - start;  %naujas intervalo ilgis
        if(fx_mid2 > fx_mid1)      %jeigu tenkina sąlygą, perrašomos reikšmės  
            lenght1 = lenght;        
            new_start = start; 
            new_endp = endp; 
            x_min_mid = x_mid;       
            fx_mid2 = fx_mid1;       
        end
    end
    f_min = fx_mid2 % rastas matematinio modelio min taškas
 end
```
## 4. Tikslo funkcijos minimumas (mažiausios prekybos bazės išlaidos) ir minimumo taškas (prekių vežimo intervalas) ##

```matlab
function [q, t, x_min_mid, f_min, islaidos, iteration, lenght] = maz_islaidos(start, endp)
  [x_min_mid, f_min, new_start, new_end, iteration, lenght, xpoint, xvalue] = dalijimas_pusiau(start, endp);
  vidurio_taskas = (new_start+new_endp)/2; 
  vid_tasko_apacia = floor(vidurio_taskas);          
  f_apacia = tikslo_funkcija(vid_tasko_apacia);    
  vid_tasko_virsus = ceil(vidurio_taskas);            
  f_virsus = tikslo_funkcija(vid_tasko_virsus);      
  
  if(f_apacia > f_virsus)                         
    islaidos = f_virsus; %išsaugoma viršutine reikšme
    t = vid_tasko_virsus; %išsaugoma reikšme
  else 
    islaidos = f_apacia;     %išsaugoma apatine reikšme
    t = vid_tasko_apacia;    %išsaugoma reikšme
  end
 
  x = start:1:endp; %vektorius nuo pradžios iki pabaigos
  y = tikslo_funkcija(x);
 
  %aukso pjuvio ir kvadratines interpoliacijos metodo naudojimas
  optimizacija = optimset('Display', 'iter','MaxFunEvals', 1000,'PlotFcns', @optimplotfval , 'TolX', lenght);
  [xfminbnd, yfminbnd] = fminbnd(@tikslo_funkcija, start, endp, optimizacija);
  
  figure % grafikas
  plot(x, y, '.-', xpoint, xvalue, '.-'), legend('Kiekviename taške', 'Dalijant intervala pusiau'); 
  title('Prekybos bazes islaidu kitimas pagal perioda t');
  xlabel('Prekiu vežimo periodas (t)');
  ylabel('Prekybos bazes išlaidos per diena'); 
  
  b = mod(20132760, 7)/2 + 2.5; 
  q = t * b; %vienos partijos dydis
  xfminbnd;
  yfminbnd;
end
```

Tikslo funkcijos minimumas - f_min = 91.3021;

Optimalus prekių vežimo periodas - t = 3;

Optimali partijos apimtis - q = 13.5;

Tikslo funkcijos minimumo taškas - x_min_mid = 2.8125;

Optimalios išlaidos - islaidos = 90.5000;

## 5. Iteracijų skaičius ##

Kiek iteracijų reikia atlikti, norint gauti rezultatą norimu tikslumu (tikslumas nurodomas intervalo ilgiu)

Iteracijų skaičius - iteration = 5;

Ilgis - lenght = 5;

## 6. Išlaidų grafikas ##

<p align="center">
  <img src="https://github.com/jgrinaveckis/Operation-Research/blob/1-LD/Islaidos.jpg">
</p>

<p align="center">
    Dalijimo pusiau grafikas
</p>

## 7. Kvadratinė interpoliacija ir auksinio pjūvio metodas ##

<p align="center">
  <img src="https://github.com/jgrinaveckis/Operation-Research/blob/1-LD/Optimization.jpg">
</p>

<p align="center">
    Kvadratinės interpoliacijos ir auksinio pjūvio grafikas
</p>

    Func-count   x          f(x)        Procedure

    1         12.077       175.46        initial
    
    2         18.923      263.387        golden
    
    3        7.84597      125.039        golden
    
    4        5.23104      99.2941        golden
    
    5        3.61493      90.2961        golden
    
    6        2.40659      94.8178        parabolic
    
Minimalus taškas - xfminbnd = 3.61493

Minimali reikšmė - yfminbnd = 90.2961 
