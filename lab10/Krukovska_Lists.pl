% 1. Напишіть предикат, який перетворює вихідний список у список позицій від'ємних елементів. findIndeces(+вхідний_список, -результат)
findIndeces(Input, Res) :- findIndeces(Input, Res, 0, []), !.
findIndeces([], Res, _, Temp) :- reverse(Temp, Res), !.
findIndeces([H|T], Res, I, Temp) :- I1 is I + 1, (H < 0 -> findIndeces(T, Res, I1, [I|Temp]); findIndeces(T, Res, I1, Temp)).

% 2. Напишіть предикат, що замінює всі входження заданого елемента на символ change_done. replaceElement(+символ_який_треба_замінити, +символ_на_який_замінити, +вхідний_список, -результат)
replaceElement(_, _, [], []).
replaceElement(ToReplace, New, [ToReplace|T1], [New|T2]) :- replaceElement(ToReplace, New, T1, T2),!.
replaceElement(ToReplace, New, [H|T1], [H|T2]) :- ToReplace \= H, replaceElement(ToReplace, New, T1, T2).

% 3. Напишіть предикат, що перетворює будь-який список арабських чисел (від 1 до 50) у список відповідних їм римських чисел. convertToRoman(+вхідне_число, -результат)
convertToRoman(Input, Res) :- maplist(toRoman, Input, Res).

% Допоміжний: викликає метод підбору римських цифр toRoman(+вхідний_список, -результат)
toRoman(Input, Res) :- convertToRomanHelper(Input, Converted), atomics_to_string(Converted, Res), !.

% Допоміжний: викликає метод підбору римських цифр convertToRomanHelper(+вхідне_число, -список_римських_цифр)
convertToRomanHelper(N, _):- N < 0, !.
convertToRomanHelper(0, []).
convertToRomanHelper(N, ['I'|Res]) :- N < 4, N1 is N - 1, convertToRomanHelper(N1, Res).
convertToRomanHelper(4, ['IV']).
convertToRomanHelper(5, ['V']).
convertToRomanHelper(N, ['V'|Res]) :- N < 9, N1 is N - 5, convertToRomanHelper(N1, Res).
convertToRomanHelper(9, ['IX']).
convertToRomanHelper(N, ['X'|Res]) :- N < 40, N1 is N - 10, convertToRomanHelper(N1, Res).
convertToRomanHelper(N, ['XL'|Res]) :- N < 50, N1 is N - 40, convertToRomanHelper(N1, Res).
convertToRomanHelper(50, ['L']).
convertToRomanHelper(N, [""]) :- N > 50, !.

% 4. Напишіть предикат, що здійснює циклічний зсув елементів списку на один вправо. shiftRight(+вхідний_список, -результат)
shiftRight(Input, [H|T]) :- append(T, [H], Input), !.

% 5. Напишіть предикат, що реалізує множення матриці (список списків) на вектор. multiplyMatrix(+вхідна_матриця, +вектор, -результат)
multiplyMatrix([], _, []).
multiplyMatrix([R|M], V, [A|T]) :- multiplyRow(R, V, A), multiplyMatrix(M, V, T).

% Допоміжний: множення рядка на вектор. multiplyRow(+рядок_матриці, +вектор, -результат)
multiplyRow([], _, 0).
multiplyRow([E1|T1],[E2|T2], Res) :- multiplyRow(T1, T2, TempRes), Res is TempRes + E1 * E2.

% Запити
% findIndeces([-1,2,-3,2,3,-2], Res).
% Результат - Res = [0, 2, 5].
% findIndeces([-1,-2,-3,-2,-3,-2], Res).
% Результат - Res = [0, 1, 2, 3, 4, 5].
% findIndeces([1,2,3,2,3,2], Res).
% Результат - Res = [].

% replaceElement(0, "*", [0, 2, 4, 0, 10], Res).
% Результат - Res = ["*", 2, 4, "*", 10].
% replaceElement(1, 0, [1, 1, 1, 1], Res).
% Результат - Res = [0, 0, 0, 0].
% replaceElement("!", 1, [0, 1, 2, 3], Res).
% Результат - Res = [0, 1, 2, 3].

% convertToRoman([0, 1, 4, 5, 9, 10], Res).
% Результат - Res = ["", "I", "IV", "V", "IX", "X"].
% convertToRoman([11, 15, 19, 20, 34], Res).
% Результат - Res = ["XI", "XV", "XIX", "XX", "XXXIV"].
% convertToRoman([48, 49, 50, 60], Res).
% Результат - Res = ["XLVIII", "XLIX", "L", ""].

% shiftRight([ 1, 2, 3, 0], Res).
% Результат - Res = [0, 1, 2, 3].

% multiplyMatrix([[2, 4, 0],[-2, 1, 3],[-1, 0, 1]],[1, 2, -1], Res).
% Результат - Res = [10, -3, -2].
% multiplyMatrix([[1, 2, 3],[4, 5, 6],[7, 8, 9]],[2, 1, 3], Res).
% Результат - Res = [13, 31, 49].
