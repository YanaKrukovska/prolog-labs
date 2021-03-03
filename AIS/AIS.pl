% артист(+id_артиста, +ім'я_артиста_або_гурту, +дата_народження_або_заснування).
artist(1, "Oleg Vynnyk", date(1973, 07, 31)).
artist(2, "Oasis", date(1991, 08, 1)).
artist(3, "Liam Gallagher", date(1972, 09, 21)).

% альбом(+id_альбому, +назва_альбому, +дата_релізу_альбому).
album(1, "Roksolana", date(2013, 10, 25)).
album(2, "(What's the Story) Morning Glory?", date(1995, 10, 2)).
album(3, "MTV Unplugged (Live at Hull City Hall)", date(2020, 06, 12)).

% пісня(+id_пісні, +id_артиста, +назва_пісні, жанри(перший_жанр, другий_жанр)). Наперед визначена кількість жанрів = 2
song(1, 1, "Vovchytsia", genres("pop", "pop rock")).
song(2, 2, "Don't Look Back In Anger", genres("britpop", "rock")).
song(3, 2, "Champagne Supernova", genres("britpop", "rock")).
song(4, 3, "Champagne Supernova", genres("britpop", "rock")).

% прослуховування(+id_прослуховування, +id_користувача, +id_пісні, +дата_прослуховування).
scrobble(1, 1, 1, datetime(2021, 3, 3, 12, 08, 56)).
scrobble(2, 1, 1, datetime(2021, 3, 3, 12, 13, 15)).
scrobble(3, 1, 2, datetime(2021, 3, 3, 12, 16, 44)).
scrobble(4, 2, 2, datetime(2020, 12, 31, 00, 00, 21)).
scrobble(5, 3, 2, datetime(2021, 2, 28, 10, 05, 21)).

% користувач(+id_користувача, +ім'я_користувача, +пошта, +дата_народження).
user(1, full_name("Vasya", "Ivanovich"), "vasya@gmail.com", date(1978, 4, 20), ["android", "web"]).
user(2, full_name("Elon", "Mask"), "elon@gmail.com", date(1990, 1, 1), ["ios"]).
user(3, full_name("John", "Doe"), "ivan@gmail.com", date(1980, 7, 30), ["ios", "web"]).

% Декомпозиція атрибуту "видання" у альбому
% альбом_має_видання(+id_альбому, +назва_видання).
has_edition(2, "Japanese Bonus Track Edition").
has_edition(2, "Remastered").
has_edition(2, "Vynil Version").

% Реалізація зв'язку N до М між сутностями "пісня" та "альбом"
містить_пісні(+id_альбому, +id_пісні).
has_songs(1, 1).
has_songs(2, 2).
has_songs(2, 3).
has_songs(3, 4).

belongs( X, [X | _ ]).
belongs( X, [_ | L ]) :- belongs( X, L).


:- op(10, xfx, слухає_альбом).
Користувач слухає_альбом Альбом :- album(AlbumId, Альбом, _), has_songs(AlbumId, SongId), scrobble(_, UserId, SongId, _), user(UserId, Користувач, _, _, _).

:- op(15, xfx, з_програми).
Користувач з_програми Програма :- user(_, Користувач, _, _, Applications), belongs(Програма, Applications).

Користувач слухає_альбом Альбом з_програми Програма :- Користувач слухає_альбом Альбом, Користувач з_програми Програма.

% Хто слухає_альбом "(What's the Story) Morning Glory?" з_програми "ios".
% Хто слухає_альбом "(What's the Story) Morning Glory?" з_програми "web".
