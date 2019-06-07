# Gamybos planavimo uždavinys #

<b>Tikslas</b> – apskaičiuoti maksimalų pelną kuri gaus gamykla, kai duoti duomenys:

Gamybos terminas - dvi darbo savaitės, t.y., 10 darbo dienų. Darbininkų darbo laiko ištekliai per 10 darbo dienų - <b>780 val.</b>
Analogiška nelygybė *1 klasės sąnaudoms.* Per dvi darbo savaites turi būti sunaudota ne daugiau kaip <b>520.</b>

Tokia pat nelygybė *2 klasės sąnaudoms.* Per dvi darbo savaites turi būti sunaudota ne daugiau kaip <b>760.</b>

*3 klasės sąnaudos* apribojimų neturi, jų kaina yra 50 eurų už sunaudotą vienetą.

Apribojimas: gaminių A, B, C, D per 10 dienų turi būti pagaminta > negu <b>310</b>

|                                                                     	| "A" 	| "B" 	| "C" 	| "D" 	|
|---------------------------------------------------------------------	|-----	|-----	|-----	|-----	|
| Vieno darbininko darbo laikas vienos rūšies gaminio gamybai, (val.) 	| 5   	| 4   	| 1   	| 5   	|
| 1 klasės sąnaudos vienam gaminiui                                   	| 7   	| 4   	| 5   	| 5   	|
| 2 klasės sąnaudos vienam gaminiui                                   	| 13  	| 7   	| 7   	| 3   	|
| 3 klasės sąnaudos vienam gaminiui                                   	| 2   	| 8   	| 5   	| 1   	|
| Pardavimo kaina, vnt.                                               	| 70  	| 50  	| 38  	| 82  	|

 ## Užduotys: ##
 
 ### 1. ###
 
Darbininkų darbo valandų turimų išteklių patenkinimo nelygybė - ![](https://latex.codecogs.com/gif.latex?5x_1&plus;4x_2&plus;x_3&plus;5x_4%20%5Cleqslant%20780)
 
1 klasės sąnaudų turimų išteklių patenkinimo nelygybė - ![](https://latex.codecogs.com/gif.latex?7x_1&plus;4x_2&plus;5x_3&plus;5x_4%20%5Cleqslant%20520)

2 klasės sąnaudų turimų išteklių patenkinimo nelygybė - ![](https://latex.codecogs.com/gif.latex?13x_1&plus;7x_2&plus;7x_3&plus;3x_4%20%5Cleqslant%20760)

3 klasės sąnaudų turimų išteklių sąnaudoms apribojimų nėra, todėl išlaidos sudarys - ![](https://latex.codecogs.com/gif.latex?100x_1&plus;400x_2&plus;250x_3&plus;50x_4) eurų.

Pardavę pagamintus gaminius gautume ![](https://latex.codecogs.com/gif.latex?70x_1&plus;50x_2&plus;38x_3&plus;82x_4) eurų pelno, tačiau atėmus 3 klasės sąnaudas gauname pelno funkciją - ![](https://latex.codecogs.com/gif.latex?-30x_1-350x_2-222x_3&plus;32x_4) Tai ir bus funkcija, kurios maximumo (maksimalaus pelno) ieškosime.

Dar vienas apribojimas - gaminių A, B, C ir D per dvi darbo savaites turi būti pagaminta nemažiau nei 310 vienetų - ![](https://latex.codecogs.com/gif.latex?x_1&plus;x_2&plus;x_3&plus;x_4%20%5Cgeqslant%20310) Kadangi visos nelygybės buvo mažiau arba lygu atvejui, šią nelygybę padarykite taip pat ekvivalenčią - ![](https://latex.codecogs.com/gif.latex?-x_1-x_2-x_3-x_4%20%5Cleqslant%20-310)

#### Pradinė simplekso lentelė ####

|    	| -x1 	| -x2 	| -x3 	| -x4 	|      	|
|----	|-----	|-----	|-----	|-----	|------	|
| y1 	| 5   	| 4   	| 1   	| 5   	| 780  	|
| y2 	| 7   	| 4   	| 5   	| 5   	| 520  	|
| y3 	| 13  	| 7   	| 7   	| 3   	| 760  	|
| y4 	| -1  	| -1  	| -1  	| -1  	| -310 	|
|    	| 30  	| 350 	| 222 	| -32 	|      	|

Apačioje nurodytas programinis kodas, skirtas rasti optimalų sprendimą siekiant maksimizuoti pelną iš gaminamų gaminių. 

```matlab
function [x,sol,fval,exitflag] = simplextableautest()
%nurodomi kintamieji ir ju apatines ribos (0)
%kadangi virsutiniu ribu nera, ju galime nenurodyti, automatiskai
%bus priskirta begalybe
x1 = optimvar('x1','LowerBound',0);
x2 = optimvar('x2','LowerBound',0);
x3 = optimvar('x3','LowerBound',0);
x4 = optimvar('x4','LowerBound',0);
%optimizuojama problema, nurodoma tikslo funkcija, pasirenkamas tipas (min
%arba max)
prob = optimproblem('Objective',-30*x1-350*x2-222*x3+32*x4,'ObjectiveSense','max');
%nurodomos apribojimu tikslo funkcijos
prob.Constraints.c1 = 5*x1+4*x2+x3+5*x4 <= 780;
prob.Constraints.c2 = 7*x1+4*x2+5*x3+5*x4 <= 520;
prob.Constraints.c3 = 13*x1+7*x2+7*x3+3*x4 <= 760;
prob.Constraints.c4 = -x1-x2-x3-x4 <= 310;
%suformuluojamas apribojimu ir problemos bendras objektas
problem = prob2struct(prob);
%Sprendziamas uzdavinys
[x,sol,fval,exitflag]=linprog(problem);
end
```

Naudojama funkcija 'linprog' išveda sprendinių vektorių (kintamasis 'x'), maksimalų pelną ('sol') ir kitus ('fval' bei 'exitflag') parametrus apie patį sprendimą. Pagal gautus rezultatus (x = [0, 0, 0, 104] ir sol = -3328) galime daryti išvada, jog būtų gaminami tik "D" rūšies gaminiai, nes kitos vertės x vektoriuje yra lygios 0 (x(1) = A = 0, x(2) = B = 0, x(3) = C = 0, <b>x(4) = D = 104</b>) ir maksimalus pelnas yra <b>3328</b> eurų. Atsakymui gauti prireikė tik <b>1</b> iteracijos. Atsakyme gautas skaičius yra lygus -3328, tačiau naudojant 'optimproblem' funkciją ir pasirinkus maksimizavimo tipą funkcija viduje šį uždavinį pakeičia į minimizavimo uždavinį su neigiamu ženklu, todėl gautą atsakymą reikia padauginti iš (-1). Taigi turint gaminamų gaminių skaičių vektorių, galime ir patys apsiskaičiuoti maksimalų pelną ir patikrinti gautą atsakymą - ![](https://latex.codecogs.com/gif.latex?0%5Ccdot-30%5Ccdot-0%5Ccdot350%5Ccdot%20-0%5Ccdot222%5Ccdot&plus;104%5Ccdot32%3D3328). Jis įrodo, jog apskaičiuotas atsakymas yra tikrai teisingas.

#### Galutinė lentelė ####

|    | -x1  | -x2   | -x3 | -y2  |      |
|----|------|-------|-----|------|------|
| y1 | -2   | 0     | 4   | -1   | 260  |
| x4 | 1,4  | 0,8   | 1   | 0,2  | 104  |
| y3 | 8,8  | 4,6   | 4   | -0,6 | 448  |
| y4 | 0,4  | -0,2  | 0   | 0,2  | -206 |
|    | 74,8 | 375,6 | 254 | 6,4  | 3328 |

Lentelė gauta naudojant įrankį [šiame puslapyje](https://www.zweigmedia.com/RealWorld/simplex.html) arba galima naudoti funkciją, kurios programinis kodas nemokamai patalpintas [čia](https://www.12000.org/my_notes/simplex/index.htm). 

Skaitant lentelės duomenis galima surašyti visus gautus rezultatus:

* Gaminami bus tik D rūšies gaminiai (104 vienetai)
* 1 klasės sąnaudos bus panaudotos pilnai (y2 = 0)
* Darbo valandų bus likę dar 260 (y1 = 260)
* 2 klasės sąnaudų liks 448 vienetai (y3 = 448)
* Bendras gaminių kiekis bus mažesnis 206 vienetais (prisiminkime, kad bus gaminami tik D rūšies gaminiai ir jų bus 106 vienetai). Todėl reikės papildomai užsakyti 206 vienetus gaminių.
* Pelnas maksimalus - 3328 eurai.

### Papildomos rušies gaminio įvedimas ###

|                                                                      | A  | B  | C  | D  | E   |
|----------------------------------------------------------------------|----|----|----|----|-----|
| Vieno darbininko darbo laikas  vienos rūšies gaminio gamybai, (val.) | 5  | 4  | 1  | 5  | 3   |
| 1 klasės sąnaudos vienam gaminiui                                    | 7  | 4  | 5  | 5  | 4   |
| 2 klasės sąnaudos vienam gaminiui                                    | 13 | 7  | 7  | 6  | 1   |
| 3 klasės sąnaudos vienam gaminiui                                    | 2  | 8  | 5  | 1  | 1   |
| Pardavimo kaina, vnt.                                                | 70 | 50 | 38 | 82 | 80  |

Naujo gaminio sąnaudos - pagaminimui reikia 3 val., 1 klasės sąnaudų - 4 vnt., 2 klasės sąnaudų - 1 vnt., 3 klasės sąnaudų - 1 vnt., pardavimo kaina - 100 eu./vnt.

#### Pradinė simplekso lentelė ####

|    | -x1 | -x2 | -x3 | -x4 | -x5 |      |
|----|-----|-----|-----|-----|-----|------|
| y1 | 5   | 4   | 1   | 5   | 3   | 780  |
| y2 | 7   | 4   | 5   | 5   | 4   | 520  |
| y3 | 13  | 7   | 7   | 3   | 6   | 760  |
| y4 | -1  | -1  | -1  | -1  | -1  | -310 |
|    | 30  | 350 | 222 | -32 | -50 |      |

```matlab
function [x,sol,fval,exitflag] = simplextableautest()
%nurodomi kintamieji ir ju apatines ribos (0)
%kadangi virsutiniu ribu nera, ju galime nenurodyti, automatiskai
%bus priskirta begalybe
x1 = optimvar('x1','LowerBound',0);
x2 = optimvar('x2','LowerBound',0);
x3 = optimvar('x3','LowerBound',0);
x4 = optimvar('x4','LowerBound',0);
x5 = optimvar('x5','LowerBound',0);
%optimizuojama problema, nurodoma tikslo funkcija, pasirenkamas tipas (min
%arba max)
prob = optimproblem('Objective',-30*x1-350*x2-222*x3+32*x4+50*x5,'ObjectiveSense','max');
%nurodomos apribojimu tikslo funkcijos
prob.Constraints.c1 = 5*x1+4*x2+x3+5*x4+3*x5 <= 780;
prob.Constraints.c2 = 7*x1+4*x2+5*x3+5*x4+4*x5 <= 520;
prob.Constraints.c3 = 13*x1+7*x2+7*x3+3*x4+6*x5 <= 760;
prob.Constraints.c4 = -x1-x2-x3-x4-x5 <= 310;
%suformuluojamas apribojimu ir problemos bendras objektas
problem = prob2struct(prob);
%apskaiciuojamas
[x,sol,fval,exitflag]=linprog(problem);
end
```

```

Optimal solution found.
x =

         0
         0
         0
    4.4444
  124.4444


sol =

  -6.3644e+03
  
fval =

     1

exitflag = 
  struct with fields:

         iterations: 3
    constrviolation: 2.2737e-13
            message: 'Optimal solution found.'
          algorithm: 'dual-simplex'
      firstorderopt: 1.5411e-12
```

Sprendimui reikalinga logika išlieka tokia pati kaip ir pradiniam variantui, tiesiog įvedamas naujas gaminys (x5) su atitinkamais parametrais.

Pagal gautus atsakymus matome, jog reikėjo 3 iteracijų rasti optimaliam sprendimui. Bus gaminami "D" ir "E" tipo gaminiai atitinkamai 4.44 ir 124.44 vienetai (x = [0, 0, 0, 4.44, 124.44]). Maksimalus gautas pelnas - 6360 eurai.

#### Tarpinė ir galutinė lentelės ####

Tarpinė lentelė:

|    | -x1  | -x2   | -x3 | -y2  | -x5  |      |
|----|------|-------|-----|------|------|------|
| y1 | -2   | 0     | -4  | -1   | -1   | 260  |
| x4 | 1.4  | 0.8   | 1   | 0,2  | 0,8  | 104  |
| y3 | 8.8  | 4.6   | 4   | -0,6 | 3,6  | 448  |
| y4 | 0.4  | -0.2  | 0   | 0,2  | -0,2 | -206 |
|    | 74.8 | 375.6 | 254 | 6,4  | -4,4 | 3328 |

Matome, jog apatinėje eilutėje yra neigiamas skaičius stulpelyje (-x5), todėl reikalinga dar viena iteracija rasti optimaliam sprendimui

Galutinė lentelė:

|    | -x1    | -x2    | -x3   | -y2    | -y3    |      |
|----|--------|--------|-------|--------|--------|------|
| y1 | 0.444  | 1.28   | -2.89 | -1.17  | 0.278  | 384  |
| x4 | -0.556 | -0.222 | 0.111 | 0.333  | -0.222 | 4.44 |
| x5 | 2.44   | 1.28   | 1.11  | -0.167 | 0.278  | 124  |
| y4 | 0.889  | 0.0556 | 0.222 | 0.167  | 0.0556 | -181 |
|    | 85.6   | 381    | 259   | 5.67   | 1.22   | 6360 |

Matome, jog apatinėje eilutėje neigiamų skaičių nebėra, todėl galime daryti išvadą, jog optimalus sprendimas rastas. Gauti rezultatai - 

* Gaminami bus "D" ir "E" rūšies gaminiai atitinkamai "D" = 4.44 (mažiausiai 5 gaminiai), "E" = 124
* 1 ir 2 klasės sąnaudos bus panaudotos pilnai (y2 ir y3 = 0)
* Liks nepanaudotos 384 darbininkų valandos
* Bus pagaminta 181 gaminiu per mažai, todėl bus reikalingas papildomas užsakymas
* Maksimalus gautas pelnas - 6360 eurai.
