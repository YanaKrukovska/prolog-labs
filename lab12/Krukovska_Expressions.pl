% Похідна (sin x) = (cos x). VD - похідна V = d(V)/dX  
d(sin(V), X, VD * cos(V)) :- d(V, X, VD), !.

% Похідна (cos x) = -(sin x). VD - похідна V = d(V)/dX  
d(cos(V), X, -(VD * sin(V))) :- d(V, X, VD), !. 

% Похідна e^x = e^x. VD - похідна V = d(V)/dX  
d(exp(V), X, VD * exp(V)) :- d(V, X, VD), !. 

% Похідна tg(x) = 1/(cos(x)^2). VD - похідна V = d(V)/dX  
d(tg(V), X, VD * 1/(cos(V)^2)) :- d(V, X, VD), !.

% Похідна ctg(x) = -1/(sin(x)^2). VD - похідна V = d(V)/dX  
d(ctg(V), X, VD * -1/(sin(V)^2)) :- d(V, X, VD), !.

% Запити
% d(sin(x), x, Res).
% Результат: Res = 1*cos(x).
% d(sin(x+5), x, Res).
% Результат: Res = (1+0)*cos(x+5).
% d(sin(x^2), x, Res).
% Результат: Res = 2*x^(2-1)*1*cos(x^2).

% d(cos(x), x, Res).
% Результат: Res = - (1*sin(x)).
% d(cos(10+x), x, Res).
% Результат: Res = - ((0+1)*sin(10+x)).
% d(cos(x^5), x, Res).
% Результат: Res = - (5*x^(5-1)*1*sin(x^5)).

% d(exp(x), x, Res).
% Результат: Res = 1*exp(x).
% d(exp(5), x, Res).
% Результат: Res = 0*exp(5).
% d(exp(x^2), x, Res).
% Результат: Res = 2*x^(2-1)*1*exp(x^2).

% d(tg(x), x, Res).
% Результат: Res = 1*1/cos(x)^2.
% d(tg(x-9), x, Res).
% Результат: Res =  (1-0)*1/cos(x-9)^2.
% d(tg(x^2), x, Res).
% Результат: Res = 2*x^(2-1)*1*1/cos(x^2)^2.

% d(ctg(x), x, Res).
% Результат: Res = 1* -1/sin(x)^2.
% d(ctg(x+5), x, Res).
% Результат: Res =  (1+0)* -1/sin(x+5)^2.
% d(ctg(x^3), x, Res).
% Результат: Res = 3*x^(3-1)*1* -1/sin(x^3)^2.


% Дані предикати
d(X, X, 1) :- !. 
d(C, _, 0) :- atomic(C). 
d(-U, X, -A) :- d(U, X, A), !.
d(U + V, X, A + B) :- d(U, X, A), d(V, X, B), !.
d(U - V, X, A - B) :- d(U, X, A), d(V, X, B), !.
d(C * U, X, C * A) :- atomic(C), C \= X, d(U, X, A), !.
d(U * V, X, B * U + A * V) :- d(U, X, A), d(V, X, B), !.
d(U / V, X, A) :- d(U * V^(-1), X, A), !.
d(U ^ C, X, C * U^(C - 1) * W) :- atomic(C), C \= X, d(U, X, W), !.
d(U_V_X, X, DV * DU):- U_V_X =..[_, V_X], d(U_V_X, V_X, DU), d(V_X, X, DV).
d(log(U), X, A * U^(-1)) :- d(U, X, A).

