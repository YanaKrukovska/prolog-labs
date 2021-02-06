% лектор(кл, прізвище, дата_народження, кп, ставка, кк)
лектор(1, піб("Іванов", "Іван", "Іванович"), date(14, 08, 1978), 1, 20000, 1).
лектор(2, піб("Петров", "Петро", "Петрович"), date(21, 10, 1960), 3, 11000, 2).
лектор(3, піб("Мельник", "Марія", "Михайлівна"), date(05, 05, 1999), 3, 10000, 3).
лектор(4, піб("Ярова", "Ярина", "Ярославівна"), date(28, 02, 1968), 2, 19000, 1).
лектор(5, піб("Палій", "Павло", "Павлович"), date(05, 05, 1999), 3, 8000, 3).
лектор(6, піб("Кобзар", "Кирило", "Кирилович"), date(29, 11, 1959), 1, 7000, 3).

% предмет(кп, назва)
предмет(1, "логічне програмування").
предмет(2, "бази даних").
предмет(3, "веб-технології").
предмет(4, "американська проза").
предмет(5, "основи літературної творчості").
предмет(6, "література європи").

% кафедра(кк, найменування)
кафедра(1, "інформатики").
кафедра(2, "мультимедійних систем").
кафедра(3, "літературознавство"). 

% посада(кп, назва)
посада(1, "доцент").
посада(2, "викладач").
посада(3, "співробітник").

% розклад(кл, кп, день, пара).
розклад(1, 2, "пн", 1).
розклад(1, 2, "пн", 2).
розклад(1, 3, "вт", 1).

розклад(2, 2, "пн", 1).
розклад(2, 2, "вт", 1).
розклад(2, 2, "сб", 1).

розклад(3, 4, "пн", 1).
розклад(3, 4, "вт", 3).

розклад(4, 1, "ср", 1).
розклад(4, 1, "ср", 2).
розклад(4, 1, "ср", 3).
розклад(4, 3, "ср", 4).
розклад(4, 3, "ср", 5).

розклад(5, 4, "пн", 3).
розклад(5, 4, "вт", 2).
розклад(5, 5, "чт", 1).
розклад(5, 5, "чт", 2).
розклад(5, 5, "чт", 3).
розклад(5, 5, "пт", 1).
розклад(5, 4, "сб", 3).

розклад(6, 6, "ср", 3).

% 1 (9) Скільки годин веде певний викладач по певній дисципліні? Дозволяє знаходити кількість пар, які проводить їх викладач, та їх загальну тривалість (одна пара = 1,5 години)
% getHours(+Surname, +Subject, -ClassesAmount, -Hours)
getHours(Surname, Subject, ClassesAmount, Hours) :- лектор(Id, піб(Surname, _, _), _, _, _, _), предмет(SubId, Subject), findall(1,  розклад(Id, SubId, _, _), Classes), length(Classes, ClassesAmount), Hours is ClassesAmount * 1.5.

% 2 (1) Визначити наймолодшого (може бути не один) викладача певної кафедри
%  youngestLectorInDepartment(+Department, -Surname)
youngestLectorInDepartment(Department, Surname) :- кафедра(Id, Department), лектор(_, піб(Surname, _, _), Date, _, _, Id) , \+ (лектор(_, _, AnotherDate, _, _, Id), AnotherDate @< Date).

% 3 (4.1) Які викладачі (прізвище, ставка, посада) читать по тим самих дням (усім тим і тільки тим), що і певний викладач?
% onlyTheSameDays(+CertainLector, -ResIds, -ResSur, -Salary, -Position)
onlyTheSameDays(CertainLector, ResIds, ResSur, Salary, Position) :- allDays(CertainLector, ResIds, ResSur, _), not(doNotWorkAtLeastOneDay(CertainLector, ResIds)),
лектор(ResIds, піб(ResSur, _, _), _, PosId, Salary, _), посада(PosId, Position).

% Знаходить дні, в які не працює певний лектор
% daysNotWork(+CertainLector, -Days)
daysNotWork(CertainLector, Days) :- лектор(Id, піб(CertainLector, _, _), _, _, _, _), розклад(_, _, Days, _), not(розклад(Id, _, Days, _)).

% Знаходить коди тих викладачів, що не читають в один з днів, в який викладає певний викладач
% doNotWorkAtLeastOneDay(+CertainLector, -Ids)
doNotWorkAtLeastOneDay(CertainLector, Ids) :- лектор(Ids, _, _, _, _, _), daysNotWork(CertainLector, Days), розклад(Ids, _, Days, _).

% Знаходить усі дні, в які працює викладач з кодом Id
% allDaysOfLector(+Id, -Days)
allDaysOfLector(Id, Days) :- лектор(Id, _, _, _, _, _),  розклад(Id, _, Days, _).

% 3 (4.2) Які викладачі (прізвище, кафедра) читать в усі ті дні (в усі ті та, можливо, в інші), що і певний викладач?
% allDays(+CertainLector, -ResIds, -ResSur, -ResDepartment)
allDays(CertainLector, ResIds, ResSur, ResDepartment) :- лектор(Id, піб(CertainLector, _, _), _, _, _, _), лектор(ResIds, піб(ResSur, _, _), _, _, _, DepId),
кафедра(DepId, ResDepartment), not(noMatchOneOfDays(Id, ResIds)), Id \= ResIds.

% Знаходить коди тих викладачів, що не читають у хоч один з днів, в який викладає викладач з кл Id
% noMatchOneOfDays(+Id, -ResIds)
noMatchOneOfDays(Id, ResIds) :- лектор(Id, _, _, _, _, _), allDaysOfLector(Id, Days), лектор(ResIds, _, _, _, _, _), not(розклад(ResIds, _, Days, _)).


% Запити
% getHours("Палій", "основи літературної творчості", Classes, Hours). Результат = { Classes = 4, Hours = 6.0.}
% getHours("Палій", "американська проза", Classes, Hours).  Результат = { Classes = 3, Hours = 4.5.}
% getHours("Петров", "бази даних", Classes, Hours).  Результат = { Classes = 3, Hours = 4.5.}

% youngestLectorInDepartment("літературознавство", Surname). Результат = {Surname = "Мельник" ; Surname = "Палій" ;}
% youngestLectorInDepartment("інформатики", Surname). Результат = {Surname = "Іванов" ;}

% onlyTheSameDays("Іванов", Id, Surname, Salary, Position). Результат = {Id = 3, Surname = "Мельник", Salary = 10000, Position = "співробітник" ;}
% onlyTheSameDays("Кобзар", Id, Surname, Salary, Position). Результат = {Id = 4, Surname = "Ярова", Salary = 19000, Position = "викладач" ;}

% allDays("Мельник", Id, Surname, Department). Результат = {Id = 1, Surname = "Іванов", Department = "інформатики" ; Id = 2, Surname = "Петров", Department = "мультимедійних систем" ; Id = 5, Surname = "Палій", Department = "літературознавство" ;}
% allDays("Петров", Id, Surname, Department). Результат = {Id = 5, Surname = "Палій", Department = "літературознавство" ;} 
%
