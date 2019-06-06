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
