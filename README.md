# Simplekso metodas #

**Tikslas** - rasti funkcijos ![](https://latex.codecogs.com/gif.latex?f%28x_1%2C%20x_2%29%3D100%28x_2-x_1%5E2%29%5E2&plus;%281-x_1%29%5E2) minimumą ir minimumo tašką.

## 1. Tikslo funckijos matematinė formulė ##

Tikslo funkcijos aprašymas MATLAB aplinkoje:

```matlab
function [y] = tikslo_f(x)
 y = 100* (x(2)-(x(1))^2)^2 + (1-x(1))^2;
end
```

## 3. Funkcijos, aprašytos MATLAB aplinkoje ##

Paprastojo simplekso metodas:

```matlab
function [xres, fres, iteration] = simplex(x0, n, alfa)
    m = 100; % iteraciju kiekis
    iteration = 0; %kintamasis iteraciju skaiciui
    stop_ = 0; %reikalingas operaciju nutraukimui
    sigma1 = (sqrt(n+1) + n - 1)* alfa/(n * sqrt(2));
    sigma2 = (sqrt(n+1) - 1) * alfa/(n * sqrt(2));
  
    for i = 1:n%randamos kitos virsunes      
        for j = 1:n
            if j == i
              x1(j) =  x0(j) + sigma2;
            else
              x1(j) =  x0(j) + sigma1;
            end
        end
       x{i} = x1;
    end

    %vykdom, kol nepasiekiam tam tikru salygu (nurodytos zemiau)
    while stop_ == 0 
        %Randamos funkcijos reiksmes visiems taskams
        fx0 = tikslo_f(x0);
        for i = 1:n
           fx(i) = tikslo_f(x{i});
        end
        
        %Svorio centro koordinates
        for i = 1:n
            xc(i) = 0;
            for j = 1:n
                xc(i) = xc(i) + x{i}(j);
            end
            xc(i) = xc(i) / n;
        end
                
        newx = -x0 + 2 * xc;%Nauja simplekso virsune
        fnewx = tikslo_f(newx);%f-jos reiksme virsuneje
        
        %max fjos reiksme
        maxi = 1;
        fmaxx = fx(maxi); 
        for i = 1:n
            if(fx(i) > fmaxx)
                fmaxx = fx(i);%maksimali funkcijos reiksme
                maxi = i;
            end
        end
 
        %jei virsijam iteraciju skaiciu - nutraukiam
        if(iteration > m)
            stop_ = 1;
        end
        
        %jei fjos reiksme naujoj simplekso virsuneje yra didziausia - nutraukiam skaiciavima
        if(fmaxx < fnewx)
            stop_ = 1;
        else 
            x{maxi} = newx;
        end
        iteration = iteration + 1; 
    end
 
    %min funkcijos reiksme
    mini = 1;
    fminx = fx(maxi);
    
    for i = 1:n
        if(fx(i) < fminx)
            fminx = fx(i);%minimali funkcijos reiksme
            imin = i;
        end
    end
 
    xres = x{mini};
    fres = fminx;
end
```

Bendra funkcija, kurioje iškviečiama tiek fminsearch tiek simplekso funkcija:

```matlab
function [x0, alfa, x, fval, xres, fres, iteration] = bendra(x01, x02, alfa)
   stud_nr = 20132760;
   %x01 ir x02 yra skirti keisti pradini taska
   %bendru atveju pradzia x(1, 1)
   x0 = [mod(stud_nr, 10)/2 + x01,  mod(stud_nr, 10)/2 + x02]; 
   n = 2; 
 
   options = optimset('Display', 'iter' , 'TolX', alfa, 'PlotFcns',@optimplotfval);
   
   %Grafikas
   [X1, X2] = meshgrid(-5:0.1:5, -5:0.1:5);

   y = 100.*(X2-X1.^2).^2 + (1-X1).^2;
 
   surf(X1,X2,y);
   xlabel('x1');
   ylabel('x2');
   zlabel('F(x1,x2)');
   title('Rozenbroko f-ja');
    
   %iskvieciam reikalingas funkcijas
   [x,fval] = fminsearch(@tikslo_f, x0, options); 
   [xres, fres, iteration] = simplex(x0, n, alfa); 
   
end
```

## 4. Rezultatai ##

Kiekvieną kartą keičiant duomenis nurodyta lentelė, kurioje atvaizduota informaciją apie kiekvieną iteraciją naudojant deformuoto simplekso (fminsearch) funkciją.
### Rezultatai, esant pradinėms reikšmėms (alfa = 0.5, x = (1, 1)): ###

| Iteration 	| Func-count 	| min f(x) 	|    Procedure    	|
|:---------:	|:----------:	|:--------:	|:---------------:	|
|     0     	|      1     	|     0    	|                 	|
|     1     	|      3     	|     0    	| initial simplex 	|
|     2     	|      5     	|     0    	| contract inside 	|
|     3     	|      7     	|     0    	| contract inside 	|
|     4     	|      9     	|     0    	| contract inside 	|
|     5     	|     11     	|     0    	| contract inside 	|
|     6     	|     13     	|     0    	| contract inside 	|
|     7     	|     15     	|     0    	| contract inside 	|
|     8     	|     17     	|     0    	| contract inside 	|
|     9     	|     19     	|     0    	| contract inside 	|
|     10    	|     21     	|     0    	| contract inside 	|


* Funkcijos minimumas fminsearch metodu - fval = 0
* x reikšmės fminsearch metodu - (1, 1)
* Funkcijos minimumas paprastojo simplekso (simplex) metodu - fres = 4.3181
* x reikšmės paprastojo simplekso metodu - x = (1.1294, 1.4830)
* Iteracijų skaičius paprastojo simplekso metodu - 4
* Įteracijų skaičius deformuoto simplekso metodu (fminsearch) - 11

### Rezultatai, esant reikšmėms (alfa = 0.5, x = (6, 6)): ###

| Iteration 	| Func-count 	|   min f(x)  	|     Procedure    	|
|:---------:	|:----------:	|:-----------:	|:----------------:	|
|     0     	|      1     	|    90025    	|                  	|
|     1     	|      3     	|    88234    	|  initial simplex 	|
|     2     	|      5     	|   51593.8   	|      expand      	|
|     3     	|      7     	|   35681.1   	|      expand      	|
|     4     	|      9     	|   3976.56   	|      expand      	|
|     5     	|     11     	|   1094.89   	|      expand      	|
|     6     	|     13     	|   1094.89   	| contract outside 	|
|     7     	|     15     	|    36.46    	|  contract inside 	|
|     8     	|     16     	|    36.46    	|      reflect     	|
|     9     	|     18     	|    36.46    	|  contract inside 	|
|     10    	|     20     	|    36.46    	|  contract inside 	|
|     11    	|     22     	|   28.4879   	|  contract inside 	|
|     12    	|     24     	|   9.00574   	|  contract inside 	|
|     13    	|     25     	|   9.00574   	|      reflect     	|
|     14    	|     27     	|    5.1796   	|  contract inside 	|
|     15    	|     28     	|    5.1796   	|      reflect     	|
|     16    	|     30     	|   4.01059   	|  contract inside 	|
|     17    	|     32     	|   4.01059   	| contract outside 	|
|     18    	|     34     	|   4.01059   	|  contract inside 	|
|     19    	|     36     	|    3.9791   	|      reflect     	|
|     20    	|     38     	|   3.92059   	|      reflect     	|
|     21    	|     39     	|   3.92059   	|      reflect     	|
|     22    	|     41     	|   3.82745   	|      reflect     	|
|     23    	|     43     	|   3.75913   	|  contract inside 	|
|     24    	|     45     	|   3.68921   	|      reflect     	|
|     25    	|     47     	|   3.68921   	|  contract inside 	|
|     26    	|     49     	|   3.62185   	|      expand      	|
|     27    	|     51     	|   3.49776   	|      expand      	|
|     28    	|     53     	|   3.24458   	|      expand      	|
|     29    	|     55     	|   3.21066   	|      reflect     	|
|     30    	|     57     	|   2.80678   	|      expand      	|
|     31    	|     59     	|   2.80678   	|  contract inside 	|
|     32    	|     61     	|   2.57414   	|      expand      	|
|     33    	|     63     	|   2.57414   	|  contract inside 	|
|     34    	|     65     	|   2.30265   	|      expand      	|
|     35    	|     67     	|   2.30265   	|  contract inside 	|
|     36    	|     68     	|   2.30265   	|      reflect     	|
|     37    	|     69     	|   2.30265   	|      reflect     	|
|     38    	|     71     	|   2.10924   	|      reflect     	|
|     39    	|     73     	|   2.10924   	|  contract inside 	|
|     40    	|     75     	|   1.87533   	|      expand      	|
|     41    	|     76     	|   1.87533   	|      reflect     	|
|     42    	|     78     	|   1.86161   	|      reflect     	|
|     43    	|     80     	|   1.66668   	|      expand      	|
|     44    	|     82     	|    1.6461   	|      reflect     	|
|     45    	|     84     	|   1.50628   	|      reflect     	|
|     46    	|     85     	|   1.50628   	|      reflect     	|
|     47    	|     87     	|   1.32311   	|      reflect     	|
|     48    	|     89     	|   1.31587   	|  contract inside 	|
|     49    	|     91     	|   1.22075   	|      reflect     	|
|     50    	|     93     	|   1.22075   	|  contract inside 	|
|     51    	|     95     	|   1.04688   	|      expand      	|
|     52    	|     97     	|   1.04688   	|  contract inside 	|
|     53    	|     99     	|   0.972282  	|      expand      	|
|     54    	|     101    	|   0.817512  	|      expand      	|
|     55    	|     103    	|   0.569932  	|      expand      	|
|     56    	|     105    	|   0.569932  	|  contract inside 	|
|     57    	|     106    	|   0.569932  	|      reflect     	|
|     58    	|     108    	|   0.455313  	|      reflect     	|
|     59    	|     110    	|   0.455313  	|  contract inside 	|
|     60    	|     112    	|   0.338416  	|      expand      	|
|     61    	|     114    	|   0.338416  	| contract outside 	|
|     62    	|     116    	|   0.181616  	|      expand      	|
|     63    	|     118    	|   0.181616  	|  contract inside 	|
|     64    	|     120    	|   0.181616  	| contract outside 	|
|     65    	|     121    	|   0.181616  	|      reflect     	|
|     66    	|     123    	|   0.122725  	|      expand      	|
|     67    	|     124    	|   0.122725  	|      reflect     	|
|     68    	|     126    	|  0.0744261  	|      reflect     	|
|     69    	|     128    	|  0.0744261  	|  contract inside 	|
|     70    	|     129    	|  0.0744261  	|      reflect     	|
|     71    	|     131    	|   0.046739  	|      reflect     	|
|     72    	|     133    	|   0.046739  	|  contract inside 	|
|     73    	|     134    	|   0.046739  	|      reflect     	|
|     74    	|     136    	|  0.0295985  	|      reflect     	|
|     75    	|     138    	|  0.0295985  	|  contract inside 	|
|     76    	|     140    	|  0.0278209  	|      expand      	|
|     77    	|     142    	|  0.0116579  	|      reflect     	|
|     78    	|     143    	|  0.0116579  	|      reflect     	|
|     79    	|     145    	|   0.008331  	|      reflect     	|
|     80    	|     147    	|  0.00617855 	|  contract inside 	|
|     81    	|     149    	|  0.00593003 	|      reflect     	|
|     82    	|     151    	|  0.00392327 	|      reflect     	|
|     83    	|     153    	|  0.00297246 	|  contract inside 	|
|     84    	|     155    	|  0.00162312 	|  contract inside 	|
|     85    	|     157    	|  0.00162312 	|  contract inside 	|
|     86    	|     159    	| 0.000870017 	|      reflect     	|
|     87    	|     161    	| 0.000870017 	|  contract inside 	|
|     88    	|     162    	| 0.000870017 	|      reflect     	|
|     89    	|     164    	| 0.000379556 	|      reflect     	|
|     90    	|     166    	| 0.000379556 	|  contract inside 	|
|     91    	|     168    	| 0.000277996 	|      reflect     	|
|     92    	|     170    	| 0.000104303 	|      expand      	|
|     93    	|     172    	| 8.61076e-06 	|      reflect     	|
|     94    	|     174    	| 8.61076e-06 	|  contract inside 	|

* Funkcijos minimumas fminsearch metodu - fval = 8.6108e-06
* x reikšmės fminsearch metodu - x = (0.9997, 0.9997)
* Funkcijos minimumas paprastojo simplekso (simplex) metodu - fres = 9.6665e+04
* x reikšmės paprastojo simplekso metodu - xres = (6.1294, 6.4830)
* Iteracijų skaičius paprastojo simplekso metodu - 1
* Įteracijų skaičius deformuoto simplekso metodu (fminsearch) - 95

### Rezultatai, esant reikšmėms (alfa = 0.5, x = (10, 10)): ###

| Iteration 	| Func-count 	|   min f(x)  	|     Procedure    	|
|:---------:	|:----------:	|:-----------:	|:----------------:	|
|     0     	|      1     	|    810081   	|                  	|
|     1     	|      3     	|    801106   	|  initial simplex 	|
|     2     	|      5     	|    493570   	|      expand      	|
|     3     	|      7     	|    364570   	|      expand      	|
|     4     	|      9     	|   68279.1   	|      expand      	|
|     5     	|     11     	|   177.954   	|      expand      	|
|     6     	|     12     	|   177.954   	|      reflect     	|
|     7     	|     14     	|   177.954   	| contract outside 	|
|     8     	|     15     	|   177.954   	|      reflect     	|
|     9     	|     17     	|   177.954   	|  contract inside 	|
|     10    	|     19     	|   177.954   	|  contract inside 	|
|     11    	|     21     	|   177.954   	|  contract inside 	|
|     12    	|     23     	|   41.6885   	|  contract inside 	|
|     13    	|     24     	|   41.6885   	|      reflect     	|
|     14    	|     26     	|   13.7852   	|  contract inside 	|
|     15    	|     28     	|   13.7852   	| contract outside 	|
|     16    	|     30     	|   11.5016   	|  contract inside 	|
|     17    	|     31     	|   11.5016   	|      reflect     	|
|     18    	|     33     	|   8.84774   	|  contract inside 	|
|     19    	|     34     	|   8.84774   	|      reflect     	|
|     20    	|     36     	|   8.84774   	|  contract inside 	|
|     21    	|     38     	|   8.73108   	|  contract inside 	|
|     22    	|     40     	|   8.73108   	|  contract inside 	|
|     23    	|     42     	|   8.45128   	|      expand      	|
|     24    	|     43     	|   8.45128   	|      reflect     	|
|     25    	|     45     	|   8.00505   	|      expand      	|
|     26    	|     47     	|   7.99647   	|      reflect     	|
|     27    	|     49     	|   7.16824   	|      expand      	|
|     28    	|     50     	|   7.16824   	|      reflect     	|
|     29    	|     52     	|   7.16824   	|  contract inside 	|
|     30    	|     53     	|   7.16824   	|      reflect     	|
|     31    	|     55     	|   6.77816   	|      expand      	|
|     32    	|     57     	|   6.66343   	|      reflect     	|
|     33    	|     59     	|   5.71463   	|      expand      	|
|     34    	|     61     	|   5.71463   	|  contract inside 	|
|     35    	|     62     	|   5.71463   	|      reflect     	|
|     36    	|     64     	|   5.10325   	|      reflect     	|
|     37    	|     66     	|   5.10325   	| contract outside 	|
|     38    	|     67     	|   5.10325   	|      reflect     	|
|     39    	|     69     	|   4.88129   	|      reflect     	|
|     40    	|     70     	|   4.88129   	|      reflect     	|
|     41    	|     72     	|   4.57468   	|      reflect     	|
|     42    	|     74     	|   4.57468   	|  contract inside 	|
|     43    	|     76     	|   4.51914   	|      reflect     	|
|     44    	|     78     	|   4.22925   	|      expand      	|
|     45    	|     80     	|   4.16273   	|      expand      	|
|     46    	|     82     	|   3.76996   	|      reflect     	|
|     47    	|     83     	|   3.76996   	|      reflect     	|
|     48    	|     85     	|   3.50547   	|      reflect     	|
|     49    	|     87     	|   3.50547   	|  contract inside 	|
|     50    	|     89     	|   3.02205   	|      expand      	|
|     51    	|     90     	|   3.02205   	|      reflect     	|
|     52    	|     92     	|    2.9215   	|      reflect     	|
|     53    	|     94     	|   2.85071   	|      reflect     	|
|     54    	|     96     	|   2.56253   	|      reflect     	|
|     55    	|     97     	|   2.56253   	|      reflect     	|
|     56    	|     99     	|   2.31875   	|      reflect     	|
|     57    	|     101    	|   2.31875   	|  contract inside 	|
|     58    	|     103    	|   2.21316   	|      reflect     	|
|     59    	|     105    	|    2.1633   	|      reflect     	|
|     60    	|     107    	|   2.02691   	|      reflect     	|
|     61    	|     108    	|   2.02691   	|      reflect     	|
|     62    	|     110    	|    1.8314   	|      reflect     	|
|     63    	|     112    	|    1.8314   	|  contract inside 	|
|     64    	|     114    	|   1.81696   	|      reflect     	|
|     65    	|     116    	|   1.57544   	|      expand      	|
|     66    	|     118    	|   1.57544   	|  contract inside 	|
|     67    	|     119    	|   1.57544   	|      reflect     	|
|     68    	|     121    	|   1.47347   	|      expand      	|
|     69    	|     123    	|     1.31    	|      expand      	|
|     70    	|     125    	|   1.07043   	|      reflect     	|
|     71    	|     127    	|   1.07043   	|  contract inside 	|
|     72    	|     128    	|   1.07043   	|      reflect     	|
|     73    	|     130    	|   0.928032  	|      reflect     	|
|     74    	|     132    	|   0.928032  	|  contract inside 	|
|     75    	|     134    	|   0.745993  	|      expand      	|
|     76    	|     135    	|   0.745993  	|      reflect     	|
|     77    	|     137    	|   0.684242  	|      reflect     	|
|     78    	|     139    	|   0.67698   	|      reflect     	|
|     79    	|     141    	|   0.570419  	|      reflect     	|
|     80    	|     142    	|   0.570419  	|      reflect     	|
|     81    	|     144    	|   0.506852  	|      reflect     	|
|     82    	|     146    	|   0.491154  	|  contract inside 	|
|     83    	|     148    	|   0.416297  	|      reflect     	|
|     84    	|     150    	|   0.416297  	|  contract inside 	|
|     85    	|     152    	|   0.392021  	|      reflect     	|
|     86    	|     154    	|   0.313558  	|      expand      	|
|     87    	|     155    	|   0.313558  	|      reflect     	|
|     88    	|     157    	|   0.227982  	|      expand      	|
|     89    	|     158    	|   0.227982  	|      reflect     	|
|     90    	|     160    	|   0.20943   	|      reflect     	|
|     91    	|     162    	|   0.177136  	|  contract inside 	|
|     92    	|     164    	|  0.0896418  	|      expand      	|
|     93    	|     166    	|  0.0896418  	|  contract inside 	|
|     94    	|     168    	|  0.0896418  	|  contract inside 	|
|     95    	|     169    	|  0.0896418  	|      reflect     	|
|     96    	|     171    	|  0.0589355  	|      reflect     	|
|     97    	|     173    	|  0.0589355  	|  contract inside 	|
|     98    	|     175    	|  0.0476031  	|      expand      	|
|     99    	|     177    	|  0.0322084  	|      reflect     	|
|    100    	|     179    	|  0.00895191 	|      expand      	|
|    101    	|     181    	|  0.00895191 	|  contract inside 	|
|    102    	|     182    	|  0.00895191 	|      reflect     	|
|    103    	|     184    	|  0.00418004 	| contract outside 	|
|    104    	|     186    	|  0.00418004 	|  contract inside 	|
|    105    	|     188    	|  0.00108496 	|      expand      	|
|    106    	|     190    	|  0.00108496 	|  contract inside 	|
|    107    	|     192    	|  0.00108496 	|  contract inside 	|
|    108    	|     194    	| 5.06692e-06 	|      reflect     	|
|    109    	|     196    	| 5.06692e-06 	|  contract inside 	|
|    110    	|     198    	| 5.06692e-06 	| contract outside 	|
|    111    	|     200    	| 5.06692e-06 	|  contract inside 	|
|    112    	|     202    	| 5.06692e-06 	| contract outside 	|
|    113    	|     204    	| 5.06692e-06 	| contract outside 	|

* Funkcijos minimumas fminsearch metodu - fval = 5.0669e-06
* x reikšmės fminsearch metodu - x = (0.9978, 0.9955)
* Funkcijos minimumas paprastojo simplekso (simplex) metodu - fres = 8.4873e+05
* x reikšmės paprastojo simplekso metodu - xres = (10.1294, 10.4830)
* Iteracijų skaičius paprastojo simplekso metodu - 1
* Įteracijų skaičius deformuoto simplekso metodu (fminsearch) - 114

### Rezultatai, esant reikšmėms (alfa = 0.1, x = (10, 10)): ###

| Iteration 	| Func-count 	|   min f(x)  	|     Procedure    	|
|:---------:	|:----------:	|:-----------:	|:----------------:	|
|     0     	|      1     	|    810081   	|                  	|
|     1     	|      3     	|    801106   	|  initial simplex 	|
|     2     	|      5     	|    493570   	|      expand      	|
|     3     	|      7     	|    364570   	|      expand      	|
|     4     	|      9     	|   68279.1   	|      expand      	|
|     5     	|     11     	|   177.954   	|      expand      	|
|     6     	|     12     	|   177.954   	|      reflect     	|
|     7     	|     14     	|   177.954   	| contract outside 	|
|     8     	|     15     	|   177.954   	|      reflect     	|
|     9     	|     17     	|   177.954   	|  contract inside 	|
|     10    	|     19     	|   177.954   	|  contract inside 	|
|     11    	|     21     	|   177.954   	|  contract inside 	|
|     12    	|     23     	|   41.6885   	|  contract inside 	|
|     13    	|     24     	|   41.6885   	|      reflect     	|
|     14    	|     26     	|   13.7852   	|  contract inside 	|
|     15    	|     28     	|   13.7852   	| contract outside 	|
|     16    	|     30     	|   11.5016   	|  contract inside 	|
|     17    	|     31     	|   11.5016   	|      reflect     	|
|     18    	|     33     	|   8.84774   	|  contract inside 	|
|     19    	|     34     	|   8.84774   	|      reflect     	|
|     20    	|     36     	|   8.84774   	|  contract inside 	|
|     21    	|     38     	|   8.73108   	|  contract inside 	|
|     22    	|     40     	|   8.73108   	|  contract inside 	|
|     23    	|     42     	|   8.45128   	|      expand      	|
|     24    	|     43     	|   8.45128   	|      reflect     	|
|     25    	|     45     	|   8.00505   	|      expand      	|
|     26    	|     47     	|   7.99647   	|      reflect     	|
|     27    	|     49     	|   7.16824   	|      expand      	|
|     28    	|     50     	|   7.16824   	|      reflect     	|
|     29    	|     52     	|   7.16824   	|  contract inside 	|
|     30    	|     53     	|   7.16824   	|      reflect     	|
|     31    	|     55     	|   6.77816   	|      expand      	|
|     32    	|     57     	|   6.66343   	|      reflect     	|
|     33    	|     59     	|   5.71463   	|      expand      	|
|     34    	|     61     	|   5.71463   	|  contract inside 	|
|     35    	|     62     	|   5.71463   	|      reflect     	|
|     36    	|     64     	|   5.10325   	|      reflect     	|
|     37    	|     66     	|   5.10325   	| contract outside 	|
|     38    	|     67     	|   5.10325   	|      reflect     	|
|     39    	|     69     	|   4.88129   	|      reflect     	|
|     40    	|     70     	|   4.88129   	|      reflect     	|
|     41    	|     72     	|   4.57468   	|      reflect     	|
|     42    	|     74     	|   4.57468   	|  contract inside 	|
|     43    	|     76     	|   4.51914   	|      reflect     	|
|     44    	|     78     	|   4.22925   	|      expand      	|
|     45    	|     80     	|   4.16273   	|      expand      	|
|     46    	|     82     	|   3.76996   	|      reflect     	|
|     47    	|     83     	|   3.76996   	|      reflect     	|
|     48    	|     85     	|   3.50547   	|      reflect     	|
|     49    	|     87     	|   3.50547   	|  contract inside 	|
|     50    	|     89     	|   3.02205   	|      expand      	|
|     51    	|     90     	|   3.02205   	|      reflect     	|
|     52    	|     92     	|    2.9215   	|      reflect     	|
|     53    	|     94     	|   2.85071   	|      reflect     	|
|     54    	|     96     	|   2.56253   	|      reflect     	|
|     55    	|     97     	|   2.56253   	|      reflect     	|
|     56    	|     99     	|   2.31875   	|      reflect     	|
|     57    	|     101    	|   2.31875   	|  contract inside 	|
|     58    	|     103    	|   2.21316   	|      reflect     	|
|     59    	|     105    	|    2.1633   	|      reflect     	|
|     60    	|     107    	|   2.02691   	|      reflect     	|
|     61    	|     108    	|   2.02691   	|      reflect     	|
|     62    	|     110    	|    1.8314   	|      reflect     	|
|     63    	|     112    	|    1.8314   	|  contract inside 	|
|     64    	|     114    	|   1.81696   	|      reflect     	|
|     65    	|     116    	|   1.57544   	|      expand      	|
|     66    	|     118    	|   1.57544   	|  contract inside 	|
|     67    	|     119    	|   1.57544   	|      reflect     	|
|     68    	|     121    	|   1.47347   	|      expand      	|
|     69    	|     123    	|     1.31    	|      expand      	|
|     70    	|     125    	|   1.07043   	|      reflect     	|
|     71    	|     127    	|   1.07043   	|  contract inside 	|
|     72    	|     128    	|   1.07043   	|      reflect     	|
|     73    	|     130    	|   0.928032  	|      reflect     	|
|     74    	|     132    	|   0.928032  	|  contract inside 	|
|     75    	|     134    	|   0.745993  	|      expand      	|
|     76    	|     135    	|   0.745993  	|      reflect     	|
|     77    	|     137    	|   0.684242  	|      reflect     	|
|     78    	|     139    	|   0.67698   	|      reflect     	|
|     79    	|     141    	|   0.570419  	|      reflect     	|
|     80    	|     142    	|   0.570419  	|      reflect     	|
|     81    	|     144    	|   0.506852  	|      reflect     	|
|     82    	|     146    	|   0.491154  	|  contract inside 	|
|     83    	|     148    	|   0.416297  	|      reflect     	|
|     84    	|     150    	|   0.416297  	|  contract inside 	|
|     85    	|     152    	|   0.392021  	|      reflect     	|
|     86    	|     154    	|   0.313558  	|      expand      	|
|     87    	|     155    	|   0.313558  	|      reflect     	|
|     88    	|     157    	|   0.227982  	|      expand      	|
|     89    	|     158    	|   0.227982  	|      reflect     	|
|     90    	|     160    	|   0.20943   	|      reflect     	|
|     91    	|     162    	|   0.177136  	|  contract inside 	|
|     92    	|     164    	|  0.0896418  	|      expand      	|
|     93    	|     166    	|  0.0896418  	|  contract inside 	|
|     94    	|     168    	|  0.0896418  	|  contract inside 	|
|     95    	|     169    	|  0.0896418  	|      reflect     	|
|     96    	|     171    	|  0.0589355  	|      reflect     	|
|     97    	|     173    	|  0.0589355  	|  contract inside 	|
|     98    	|     175    	|  0.0476031  	|      expand      	|
|     99    	|     177    	|  0.0322084  	|      reflect     	|
|    100    	|     179    	|  0.00895191 	|      expand      	|
|    101    	|     181    	|  0.00895191 	|  contract inside 	|
|    102    	|     182    	|  0.00895191 	|      reflect     	|
|    103    	|     184    	|  0.00418004 	| contract outside 	|
|    104    	|     186    	|  0.00418004 	|  contract inside 	|
|    105    	|     188    	|  0.00108496 	|      expand      	|
|    106    	|     190    	|  0.00108496 	|  contract inside 	|
|    107    	|     192    	|  0.00108496 	|  contract inside 	|
|    108    	|     194    	| 5.06692e-06 	|      reflect     	|
|    109    	|     196    	| 5.06692e-06 	|  contract inside 	|
|    110    	|     198    	| 5.06692e-06 	| contract outside 	|
|    111    	|     200    	| 5.06692e-06 	|  contract inside 	|
|    112    	|     202    	| 5.06692e-06 	| contract outside 	|
|    113    	|     204    	| 5.06692e-06 	| contract outside 	|

* Funkcijos minimumas fminsearch metodu - fval = 5.0669e-06
* x reikšmės fminsearch metodu - x = (0.9978, 0.9955)
* Funkcijos minimumas paprastojo simplekso (simplex) metodu - fres = 8.1769e+05
* x reikšmės paprastojo simplekso metodu - xres = (10.0259, 10.0966)
* Iteracijų skaičius paprastojo simplekso metodu - 1
* Įteracijų skaičius deformuoto simplekso metodu (fminsearch) - 114

**Bendri rezultatai**

|                                                          	| x0=(1,1), alfa=0.5 	| x0=(6,6), alfa=0.5 	| x0=(10,10), alfa=0.5 	| x0=(10,10), alfa=0.1 	|
|:--------------------------------------------------------:	|:------------------:	|:------------------:	|:--------------------:	|:--------------------:	|
|                           xres                           	|  (1.1294, 1.4830)  	|  (6.1294, 6.4830)  	|  (10.1294, 10.4830)  	|  (10.0259, 10.0966)  	|
|                           fres                           	|       4.3181       	|     9.6665e+04     	|      8.4873e+05      	|      8.1769e+05      	|
|  Iteracijų skaičius naudojant paprasto simplekso metodą  	|          4         	|          1         	|           1          	|           1          	|
|                             x                            	|       (1, 1)       	|  (0.9997, 0.9997)  	|   (0.9978, 0.9955)   	|   (0.9978, 0.9955)   	|
|                           fval                           	|          0         	|     8.6108e-06     	|      5.0669e-06      	|      5.0669e-06      	|
| Iteracijų skaičius naudojant deformuoto simplekso metodą 	|         11         	|         95         	|          114         	|          114         	|
