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

