fill(-1) :- !.
fill(X) :- asserta(d(X)), X1 is X-1, fill(X1).

% У тризначному числi, всi цифри якого непаpнi, закpеслили середню цифру. Виявилось, що отpимане двозначне число є дiльником вихiдного числа. Знайдiть всi такi тризначнi числа.
findThreeDigit(X):- d(A), d(B), d(C), mod(A, 2) =:= 1, mod(B, 2) =:= 1, mod(C, 2) =:= 1, X is A * 100 + B * 10 + C, Y is A * 10 + C, mod(X,Y) =:= 0.

% Знайдiть чотиризначне число, яке є точним квадратом, у якого двi першi цифри однаковi та двi останнi також однаковi.
findFourDigit(X) :- d(A), d(B), A > 2, B > 1, X is (A * 10 + B) * (A * 10 + B), 0 is (X // 100) mod 11, ((X mod 100) mod 11) =:= 0,!.
 
% Скiльки iснує цiлих чисел вiд 1 до 1998, якi не дiляться на жодне з чисел 6, 10, 15?
findAmount(X) :- findAmount(X, 1999, 1, 0),!.
findAmount(X, 1999, 1999, X).
findAmount(X, 1999, N, Counter) :- (N mod 6) =\= 0, (N mod 10) =\= 0, (N mod 15) =\= 0, N1 is N + 1, X1 is Counter + 1, findAmount(X, 1999, N1, X1).
findAmount(X, 1999, N, Counter) :- N1 is N + 1, findAmount(X, 1999, N1, Counter).
findAmountHelper(X) :- d(N), N > 0, N < 1999, (N mod 6) =\= 0, (N mod 10) =\= 0, (N mod 15) =\= 0, X is N.
 
% Знайти найменше натуральне число M, яке має наступну властивiсть: сума квадратiв одинадцяти послiдовних натуральних чисел, починаючи з M, є точним квадратом?
findSmallest(X) :- findSmallestHelper(X, 1, 506).
findSmallestHelper(X, X, R) :- N1 is sqrt(R), N2 is (truncate(sqrt(R)) + 0.0), N1 = N2,!.
findSmallestHelper(X, N, R) :- N1 is N + 1, T1 is N * N, N2 is (N + 11), T2 is N2 * N2, S1 is (R - T1 + T2), findSmallestHelper(X, N1, S1).

% В послiдовностi 1998737... кождна цифра, починаючи з п'ятої, дорiвнює останнiй цифрi суми чотирьох попеpеднiх цифр. Через скiльки цифр знову зустрiнитья початкова комбiнацiя 1998 (тобто скiльки цифр в перiодi)?
findGap(X):- findGapHelper(1, 9, 9, 8, X, 0).
findGapHelper(1, 9, 9, 8, R, T):- T > 0, R is T, !.
findGapHelper(A, B, C, D, R, T):- S is A + B + C + D, N is (S mod 10), R1 is T + 1, findGapHelper(B, C, D, N, R, R1).

% Запити

% findThreeDigit(X). = 135, 195, 315
% findFourDigit(X). = 7744
% findAmount(X). = 1465
% findSmallest(X). = 18
% findGap(X). = 1560

d(0).
d(1).
d(2).
d(3).
d(4).
d(5).
d(6).
d(7).
d(8).
d(9).
