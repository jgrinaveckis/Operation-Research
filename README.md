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

Tikslo funkcija - ![](https://latex.codecogs.com/gif.latex?c%28t%29%20%3Dmin%28%5Cfrac%7B150%7D%7Bt%7D%20&plus;%203%5Ccdot%20t%5Ccdot%204.5%29%3Dmin%28%5Cfrac%7B150%7D%7Bt%7D&plus;13.5t%29%3Dmin%28150&plus;13.5t%5E2%29)

## 3. Intervalo dalijimo pusiau metodas ##

