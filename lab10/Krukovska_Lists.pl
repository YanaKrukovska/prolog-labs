% 1. Напишіть предикат, який перетворює вихідний список у список позицій від'ємних елементів.
findIndeces(Input, Res) :- findIndeces(Input, [], 0, Res), !.
findIndeces([], X, _, Res) :- reverse(X, Res), !.
findIndeces([H|T], X, I, Res) :- I1 is I + 1, (H < 0 -> findIndeces(T, [I|X], I1, Res); findIndeces(T, X, I1, Res)).

% 2. Напишіть предикат, що замінює всі входження заданого елемента на символ change_done.
replaceElement(ToReplace, Input, Res) :- replaceElementHelper(ToReplace, "change_done", Input, Res).
replaceElementHelper(_, _, [], []).
replaceElementHelper(ToReplace, New, [ToReplace|T1], [New|T2]) :- replaceElementHelper(ToReplace, New, T1, T2),!.
replaceElementHelper(ToReplace, New, [Y|T1], [Y|T2]) :- ToReplace \= Y, replaceElementHelper(ToReplace, New, T1, T2).

% 3. Напишіть предикат, що перетворює будь-який список арабських чисел (від 1 до 50) у список відповідних їм римських чисел.
convertToRomanHelper(N, _):- N < 0, !.
convertToRomanHelper(0, []).
convertToRomanHelper(N, ['I'|Roman]) :- N < 4, N1 is N - 1, convertToRomanHelper(N1, Roman).
convertToRomanHelper(4, ['IV']).
convertToRomanHelper(5, ['V']).
convertToRomanHelper(N, ['V'|Roman]) :- N < 9, N1 is N - 5, convertToRomanHelper(N1, Roman).
convertToRomanHelper(9, ['IX']).
convertToRomanHelper(N, ['X'|Roman]) :- N < 40, N1 is N - 10, convertToRomanHelper(N1, Roman).
convertToRomanHelper(N, ['XL'|Roman]) :- N < 50, N1 is N - 40, convertToRomanHelper(N1, Roman).
convertToRomanHelper(50, ['L']).
convertToRomanHelper(N, ["_"]) :- N > 50, !.
toRoman(Input, Res) :- convertToRomanHelper(Input, Converted), atomics_to_string(Converted, Res), !.
convertToRoman(Input, Res) :- maplist(toRoman, Input, Res).

% 4. Напишіть предикат, що здійснює циклічний зсув елементів списку на один вправо.
shiftRight(Input, [H|T]) :- append(T, [H], Input), !.

% 5. Напишіть предикат, що реалізує множення матриці (список списків) на вектор.
multiplyMatrix([], _, []).
multiplyMatrix([R|M], V, [A|T]) :- multiplyRow(R, V, A), multiplyMatrix(M, V, T).
 
multiplyRow([], _, 0).
multiplyRow([E1|T1],[E2|T2], Res) :- multiplyRow(T1, T2, TempRes), Res is TempRes + E1 * E2.
