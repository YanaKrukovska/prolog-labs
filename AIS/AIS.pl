% артист(+id_артиста, +ім'я_артиста_або_гурту, +дата_народження_або_заснування).
artist(1, "Oleg Vynnyk", date(1973, 07, 31)).
artist(2, "Oasis", date(1991, 08, 1)).
artist(3, "Liam Gallagher", date(1972, 09, 21)).
artist(4, "Queen", date(1972, 09, 21)).
artist(5, "Rammstein", date(1994, 01, 01)).

% альбом(+id_альбому, +назва_альбому, +дата_релізу_альбому).
album(1, "Roksolana", date(2013, 10, 25)).
album(2, "(What's the Story) Morning Glory?", date(1995, 10, 2)).
album(3, "MTV Unplugged (Live at Hull City Hall)", date(2020, 06, 12)).
album(4, "Innuendo", date(1990, 06, 12)).
album(5, "Mutter", date(2001, 04, 02)).

% пісня(+id_пісні, +id_артиста, +назва_пісні, жанри(перший_жанр, другий_жанр)). Наперед визначена кількість жанрів = 2
song(1, 1, "Vovchytsia", genres("pop", "pop rock")).
song(2, 2, "Don't Look Back In Anger", genres("britpop", "rock")).
song(3, 2, "Champagne Supernova", genres("britpop", "rock")).
song(4, 4, "Show Must Go On", genres("classic rock", "rock")).
song(5, 5, "Mein Herz Brennt", genres("industrial metal", "symphonic metal")).

% прослуховування(+id_прослуховування, +id_користувача, +id_пісні, +дата_прослуховування).
scrobble(1, 1, 1, datetime(2021, 3, 3, 12, 08, 56)).
scrobble(2, 1, 1, datetime(2021, 3, 3, 12, 13, 15)).
scrobble(3, 1, 2, datetime(2021, 3, 3, 12, 16, 44)).
scrobble(10, 1, 3, datetime(2021, 2, 28, 10, 05, 21)).
scrobble(4, 2, 2, datetime(2020, 12, 31, 00, 00, 21)).
scrobble(5, 2, 3, datetime(2021, 2, 28, 10, 05, 21)).
scrobble(11, 2, 4, datetime(2021, 2, 28, 10, 05, 21)).
scrobble(6, 3, 1, datetime(2021, 2, 28, 10, 05, 21)).
scrobble(7, 3, 2, datetime(2021, 2, 28, 10, 05, 21)).
scrobble(8, 3, 3, datetime(2021, 2, 28, 10, 05, 21)).
scrobble(9, 3, 4, datetime(2021, 2, 28, 10, 05, 21)).
scrobble(12, 4, 1, datetime(2021, 2, 28, 10, 05, 21)).
scrobble(13, 4, 2, datetime(2021, 2, 28, 10, 05, 21)).
scrobble(14, 4, 3, datetime(2021, 2, 28, 10, 05, 21)).
scrobble(15, 5, 4, datetime(2021, 2, 28, 10, 05, 21)).
scrobble(16, 6, 5, datetime(2021, 4, 5, 00, 07, 19)).
scrobble(17, 7, 5, datetime(2021, 4, 5, 01, 22, 40)).

% користувач(+id_користувача, +ім'я_користувача, +пошта, +дата_народження).
user(1, full_name("Vasya", "Ivanovich"), "vasya@gmail.com", date(1980, 4, 20), ["android", "web"]).
user(2, full_name("Elon", "Mask"), "elon@gmail.com", date(1990, 1, 1), ["ios"]).
user(3, full_name("John", "Doe"), "john@gmail.com", date(1980, 7, 30), ["ios", "web"]).
user(4, full_name("Artem", "Budaiev"), "budaiev@gmail.com", date(2001, 01, 25), ["ios", "web"]).
user(5, full_name("Poopa", "Lupovich"), "poopa@gmail.com", date(2010, 01, 25), ["web"]).
user(6, full_name("Yana", "Krukovska"), "yana@gmail.com", date(2001, 09, 05), ["android"]).
user(7, full_name("Jane", "Doe"), "jane@gmail.com", date(1960, 05, 17), ["android", "web"]).

% Декомпозиція атрибуту "видання" у альбому
% альбом_має_видання(+id_альбому, +назва_видання).
has_edition(2, "Japanese Bonus Track Edition").
has_edition(2, "Remastered").
has_edition(5, "Limited Tour Edition").
has_edition(5, "Turkish Cassette").

% Реалізація зв'язку N до М між сутностями "пісня" та "альбом"
містить_пісні(+id_альбому, +id_пісні).
has_songs(1, 1).
has_songs(2, 2).
has_songs(2, 3).
has_songs(3, 4).
has_songs(4, 4).
has_songs(5, 5).


% Допоміжні правила

% Перевірка, чи належить елемент списку. belongs(+елемент_який_перевіряємо, +список_у_якому_шукаємо)
belongs(X, [X | _ ]).
belongs(X, [_ | L ]) :- belongs( X, L).

% слухають_ті_самі_пісні(+певний_користувач, -id_користувача_що_слухає_ті_самі_пісні).
listen_same_songs(UserId, Id):-
	scrobble(_, UserId, SongId, _),
	scrobble(_, Id, SongId, _),
	Id \= UserId.

% слухає_не_всі_пісні(+чиї_пісні, -хто_слухає).
listen_not_all_songs(UserId, Id):-
	user(UserId, _, _, _, _),
	scrobble(_, UserId, SongId, _),
	user(Id, _, _, _, _),
	not(scrobble(_, Id, SongId, _)),
	Id \= UserId.


% Запити

% Запит №1:  Які користувачі слухають ТІ пісні, що і певний користувач? request1(+пошта_певного_користувача, -результат_пошуку)
request1(Email, ResEmails):- setof(ResEmail, same(Email, ResEmail), ResEmails).

% Допоміжний запит, що шукає поштові адреси користувачів, що слухають ті пісні, що і певний користувач. same(+пошта_користувача_з_яким_порівнюємо, -результат_пошуку)
same(Email, ResEmail):-
	user(UserId, _, Email, _, _),
	listen_same_songs(UserId, ResUser),
	user(ResUser, _, ResEmail, _, _).

% Запит №2:  Які користувачі слухають ТІЛЬКИ ТІ пісні, що і певний користувач? request2(+пошта_певного_користувача, -результат_пошуку)
request2(Email, ResEmails):- setof(ResEmail, only_same(Email, ResEmail), ResEmails).

% Допоміжний запит, що шукає поштові адреси користувачів, що слухають тільки ті пісні, що і певний користувач. only_same(+пошта_користувача_з_яким_порівнюємо, -результат_пошуку)
only_same(Email, ResEmail):-
	user(UserId, _, Email, _, _),
	user(ResId, _, _, _, _),
	not(listen_not_all_songs(ResId, UserId)),
	ResId \= UserId,
	user(ResId, _, ResEmail, _, _).

% Запит №3:  Які користувачі слухають ВСІ ТІ пісні, що і певний користувач? request3(+пошта_певного_користувача, -результат_пошуку)
request3(Email, ResEmails):- setof(ResEmail, all_same(Email, ResEmail), ResEmails).

% Допоміжний запит, що шукає поштові адреси користувачів, що слухають всі ті пісні, що і певний користувач. only_same(+пошта_користувача_з_яким_порівнюємо, -результат_пошуку)
all_same(Email, ResEmail):-
	user(UserId, _, Email, _, _),
	listen_same_songs(UserId, ResUser),	
	not(listen_not_all_songs(UserId, ResUser)),
	user(ResUser, _, ResEmail, _, _).

% Запит №4:  Які користувачі слухають ВСІ ТІ ТА ТІЛЬКИ ТІ пісні, що і певний користувач? request4(+пошта_певного_користувача, -результат_пошуку)
request4(Email, ResEmails):- setof(ResEmail, all_same_and_only_same(Email, ResEmail), ResEmails).

% Допоміжний запит, що шукає поштові адреси користувачів, що слухають всі ті і тільки ті пісні, що і певний користувач. all_same_and_only_same(+пошта_користувача_з_яким_порівнюємо, -результат_пошуку)
all_same_and_only_same(Email, ResEmail):-
	all_same(Email, ResEmail),
	only_same(Email, ResEmail).

% Запит №5:  СЕРЕДНІЙ ВІК користувачів, які слухають певного виконавця. request5(+ім'я_певного_виконавця, -середній_вік)
request5(Name, AvrgAge) :- setof(UserId, listener(Name, UserId), UserIds), ages(UserIds, Ages), sum_list(Ages, Sum), length(Ages, Length), AvrgAge is Sum / Length.

% Допоміжний запит, що шукає id всіх слухачів певного артиста. listener(+ім'я_артиста, -результат_пошуку)
listener(Artist, Id):-
	artist(ArtistId, Artist, _),
	song(SongId, ArtistId, _, _),
	scrobble(_, Id, SongId, _).

% Допоміжний запит, що рахує вік наданих користувачів. listener(+список_id_користувачів, -список_віку_користувачів)
ages([],[]).
ages([Id|Ids], Ages):-
	ages(Ids, NewAges),
	user(Id, _, _, date(Year, _, _), _),
	Age is 2021 - Year,
	Ages = [Age|NewAges].

% Оператори

% Оператор, що повертає всіх поштові адреси користувачів, що слухають певний альбом
:- op(10, xfx, слухає_альбом).
Користувач слухає_альбом Альбом :- album(AlbumId, Альбом, _), has_songs(AlbumId, SongId), scrobble(_, UserId, SongId, _), user(UserId, _, Користувач, _, _).

% Оператор, що повертає всіх поштові адреси користувачів, що користуються певною програмою
:- op(15, xfx, з_програми).
Користувач з_програми Програма :- user(_, _, Користувач, _, Applications), belongs(Програма, Applications).

% Запит, що повертає поштові адреси користувачів, що слухають певний альбом з певної програми
Користувач слухає_альбом Альбом з_програми Програма :- setof(К ,((К слухає_альбом Альбом), (К з_програми Програма)), Користувач).



% Тестова частина

% Запит №1

:- writeln("Які користувачі слухають ТІ пісні, що і користувач з логіном poopa@gmail.com?").
:- request1("poopa@gmail.com", X), writeln(X).
% Результат: X = [elon@gmail.com, john@gmail.com]

:- writeln("Які користувачі слухають ТІ пісні, що і користувач з логіном vasya@gmail.com?").
:- request1("vasya@gmail.com", X), writeln(X).
% Результат: X = [budaiev@gmail.com, elon@gmail.com, john@gmail.com]


% Запит №2

:- writeln("Які користувачі слухають ТІЛЬКИ ТІ пісні, що і користувач з логіном john@gmail.com?").
:- request2("john@gmail.com", X), writeln(X).
% Результат: X = [budaiev@gmail.com, elon@gmail.com, poopa@gmail.com, vasya@gmail.com]

:- writeln("Які користувачі слухають ТІЛЬКИ ТІ пісні, що і користувач з логіном vasya@gmail.com?").
:- request2("vasya@gmail.com", X), writeln(X).
% Результат: X = [budaiev@gmail.com]


% Запит №3

:- writeln("Які користувачі слухають ВСІ ТІ пісні, що і користувач з логіном john@gmail.com?").
:- forall(request3("john@gmail.com", X), writeln(X)).
% Результат: X = []

:- writeln("Які користувачі слухають ВСІ ТІ пісні, що і користувач з логіном elon@gmail.com?").
:- request3("elon@gmail.com", X), writeln(X).
% Результат: X = [john@gmail.com]


% Запит №4

:- writeln("Які користувачі слухають ВСІ ТІ І ТІЛЬКИ ТІ пісні, що і користувач з логіном yana@gmail.com?").
:- request4("yana@gmail.com", X), writeln(X).
% Результат: X = [jane@gmail.com]

:- writeln("Які користувачі слухають ВСІ ТІ І ТІЛЬКИ ТІ пісні, що і користувач з логіном budaiev@gmail.com?").
:- request4("budaiev@gmail.com", X), writeln(X).
% Результат: X = [vasya@gmail.com]


% Запит №5

:- writeln("СЕРЕДНІЙ ВІК користувачів, які слухають виконавця Oleg Vynnyk").
:- request5("Oleg Vynnyk", X), writeln(X).
% Результат: X = 34

:- writeln("СЕРЕДНІЙ ВІК користувачів, які слухають виконавця Rammstein").
:- request5("Rammstein", X), writeln(X).
% Результат: X = 40.5


% Оператор

:- writeln("Хто слухає_альбом (What's the Story) Morning Glory? з_програми ios").
:- Хто слухає_альбом "(What's the Story) Morning Glory?" з_програми "ios", writeln(Хто).
% Хто = ["budaiev@gmail.com", "elon@gmail.com", "john@gmail.com"].

:- writeln("Хто слухає_альбом (What's the Story) Morning Glory? з_програми android").
:- Хто слухає_альбом "(What's the Story) Morning Glory?" з_програми "android", writeln(Хто).
% Хто = ["vasya@gmail.com"].
