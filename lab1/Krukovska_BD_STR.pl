       family( member( tom, fox, date( 7, may, 1934), works( bbc, 15200) ),
              member( anne, fox, date( 9, may, 1950), unemployed),
              [member( pat, fox, date( 5, may, 1973), unemployed),
              member( jim, fox, date( 5, may, 1981), works( cnn, 9000))] ).
		family( member( homer, simpson, date( 12, may, 1956), works( nuclearPlant, 9000) ),
              member( marge, simpson, date( 1, october, 1956), unemployed),
              [member( bart, simpson, date( 23, february, 1979), works(security, 5000)),
              member( lisa, simpson, date( 9, may, 1981), works( government, 100000)),
			   member( maggie, simpson, date( 18, december, 1989), unemployed)
			  ] ).
		family( member( john, doe, date( 15, march, 1989), unemployed),
              member( jane, doe, date( 5, august, 1989), works( abc, 10000)),
              [] ).

       husband(X) :-
              family( X, _, _ ).

       wife(X) :-
              family( _, X, _ ).

       child(X) :-
              family( _, _, Y),
              belongs( X, Y).

       belongs( X, [X | _ ]).

       belongs( X, [_ | L ]) :-
               belongs( X, L).

       exists(X) :-
            husband(X);
            wife(X);
            child(X).

       birthday( member( _, _, Date, _ ), Date).

       wage( member( _, _, _, works( _, S) ), S).

       wage( member( _, _, _, unemployed), 0).
	   
	   % Task 1 всіх дітей, які народилися у 1981.
	   children1981(X) :- child(X), birthday(X, date(_, _, 1981)).
	   
	   % Task 2 всіх жінок, які не працюють.
	   notWorkingWives(Name, Surname) :- wife(member(Name, Surname, _, unemployed)).
	   
	   % Task 3 всіх людей, які не працюють, але не досягли пенсійного віку.
	   unemployedYouth(Name, Surname, Year) :- child(member(Name, Surname, date(_, _, Year), unemployed)), Year > 1955.
	   
	   % Task 4 всіх людей, які народилися до 1961, та чий прибуток менше 10000.
	   earningLittlePre1961(Name, Surname, Year, Salary) :- exists(member(Name, Surname, date(_, _, Year), works(_, Salary))), Year =< 1961, Salary < 10000.
	   
	   % Task 5 прізвища людей, які мають хоча б трьох дітей.
	   atLeastThreeKids(Name, Surname) :- family( member(Name, Surname, _, _ ), _, [ _, _, _ | _ ]).
	   
	   % Task 6 родини без дітей.
	   withoutKids(Surname) :- family( member(_, Surname, _, _ ), _, []).
	   
	   % Task 7 всіх працюючих дітей.
	   workingKids(Name, Surname) :- child(member(Name, Surname, _, works(_, _))).
	   
	   % Task 8 родини, де жінка працює, а чоловік ні.
	   unemployedHusbands(Surname) :- family( member(_, Surname, _, unemployed ), member(_, Surname, _, works(_,_) ), _).
	   
	   % Task 9 всіх дітей, для яких різниця у віці їх батьків більше 15 років.
	   parents15YearsAgeDifference(Children) :- family(H, W, Children), birthday(H, date(_, _, HY)), birthday(W, date(_, _, WY)),
	   (HY - WY >= 15; WY - HY >= 15).
	 
