% Ділення з остачею, D - ціла частина, R - остача
getDivRemainder(X, Y, D, R) :- getDivRemainderHelper(X, Y, 0, D, R), !.
getDivRemainderHelper(X, Y, D, D, X) :- X >= 0, X < Y.
getDivRemainderHelper(X, Y, C, D, R) :- X >= Y, X1 is X - Y, C1 is C + 1, getDivRemainderHelper(X1, Y, C1, D, R).

% Піднесення до степеню 
power(_, 0, 1) :- !.
power(X, N, R) :- N1 is N - 1, power(X, N1, R1), R is R1 * X.

% Числа Фібоначчі 
fibonacci(0, 0) :- !.
fibonacci(1, 1) :- !.
fibonacci(N, R) :- fibHelper(N, 0, 1, R).

fibHelper(0, R, _, R) :- !.
fibHelper(N, P1, P2, R):- N > 0, PrevSum is P1 + P2, N1 is N - 1, fibHelper(N1, P2, PrevSum, R).

% Розклад числа на прості множники
findPrime(X, Res) :- primeHelper(X, 2, Res).
primeHelper(X, Prime, Prime) :- 0 is X mod Prime.
primeHelper(X, P, Res) :- P < X, (0 is X mod P  -> (X1 is X / P, primeHelper(X1, P, Res));  (P1 is P + 1, primeHelper(X, P1, Res))).

% Обрахувати сумму 1/1! + 1/2! + 1/3! + ... 1/n!
factorialDivSum(0, 0) :- !.
factorialDivSum(N, Res) :- N > 0, N1 is N - 1, factorialDivSum(N1, R1), factorial(N, F), Res is R1 + 1/F.

factorial(0, 1) :- !.
factorial(N, R) :-  N1 is N - 1, factorial(N1, S), R is S * N.

% Алгоритм Евкліда (пошуку НСД)
gcd(0, Y, Y) :- !.
gcd(X, 0, X) :- !.
gcd(X, Y, Res) :- X < Y, X1 is Y - X, gcd(X1, X, Res).
gcd(X, Y, Res) :- X >= Y, X1 is X - Y, gcd(X1, Y, Res).
