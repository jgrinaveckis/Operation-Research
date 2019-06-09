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