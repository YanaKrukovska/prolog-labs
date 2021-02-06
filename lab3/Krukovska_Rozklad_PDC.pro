domains 
	day=Integer
	month=Integer
	year=Integer
	birthDate=date(day, month, year)

predicates
	lector(Integer, String, birthDate, Integer, Integer, Integer)
	predmet(Integer, String)
	kafedra(Integer, String)
	posada(Integer, String)
	rozklad(Integer, Integer, String, Integer)
	getHours(String, String, Integer, Integer)
	youngestLectorInDepartment(String, String)
	onlyTheSameDays(String, Integer, String, Integer, String)
	daysNotWork(String, String)
	doNotWorkAtLeastOneDay(String, Integer)
	allDaysOfLector(Integer, String)
	allDays(String, Integer, String, String)
	badLectors(Integer, Integer)
	getZero(Integer). 

clauses
	lector(1, "Ivanov", date(14, 08, 1978), 1, 20000, 1).
	lector(2, "Petrov", date(21, 10, 1960), 3, 11000, 2).
	lector(3, "Melnyk", date(05, 05, 1999), 3, 10000, 3).
	lector(4, "Yarova", date(28, 02, 1968), 2, 19000, 1).
	lector(5, "Paliy", date(05, 05, 1999), 3, 8000, 3).
	lector(6, "Kobzar", date(29, 11, 1959), 1, 7000, 3).

	predmet(1, "logical programming").
	predmet(2, "data bases").
	predmet(3, "web-technologies").
	predmet(4, "american novel").
	predmet(5, "creative writing").
	predmet(6, "european literature").

	kafedra(1, "informatics").
	kafedra(2, "multimedia systems").
	kafedra(3, "literature"). 

	posada(1, "docent").
	posada(2, "researcher").
	posada(3, "professor").

	rozklad(1, 2, "monday", 1).
	rozklad(1, 2, "monday", 2).
	rozklad(1, 3, "tuesday", 1).

	rozklad(2, 2, "monday", 1).
	rozklad(2, 2, "tuesday", 1).
	rozklad(2, 2, "saturday", 1).

	rozklad(3, 4, "monday", 1).
	rozklad(3, 4, "tuesday", 3).

	rozklad(4, 1, "wednesday", 1).
	rozklad(4, 1, "wednesday", 2).
	rozklad(4, 1, "wednesday", 3).
	rozklad(4, 3, "wednesday", 4).
	rozklad(4, 3, "wednesday", 5).

	rozklad(5, 4, "monday", 3).
	rozklad(5, 4, "tuesday", 2).
	rozklad(5, 5, "thursday", 1).
	rozklad(5, 5, "thursday", 2).
	rozklad(5, 5, "thursday", 3).
	rozklad(5, 5, "friday", 1).
	rozklad(5, 4, "saturday", 3).

	rozklad(6, 6, "wednesday", 3).
	
% 1 (9) Skilki godin vede pevnij vikladach po pevnij disciplini? Dozvolyaye znahoditi kilkist par, yaki provodit yih vikladach, ta yih zagalnu trivalist (odna para = 1,5 godini)
getHours(Surname, Subject, ClassesAmount, Hours) :- lector(Id, Surname, _, _, _, _), predmet(SubId, Subject), findall(X, rozklad(Id, _, _, _), Classes), length(Classes, ClassesAmount), Hours is ClassesAmount * 1.5.

% 2 (1) Viznachiti najmolodshogo (mozhe buti ne odin) vikladacha pevnoyi kafedri
youngestLectorInDepartment(Department, Surname) :- kafedra(Id, Department), lector(_, Surname, Date, _, _, Id) , not(lector(_, _, AnotherDate, _, _, Id)), not(AnotherDate < Date).

% 3 (4.1) Yaki vikladachi (prizvishe, stavka, posada) chitat po tim samih dnyam (usim tim i tilki tim), sho i pevnij vikladach?
onlyTheSameDays(CertainLector, ResIds, ResSur, Salary, Position) :- allDays(CertainLector, ResIds, ResSur, _), not(doNotWorkAtLeastOneDay(CertainLector, ResIds)),
lector(ResIds, ResSur, _, PosId, Salary, _), posada(PosId, Position).

% Znahodit dni, v yaki ne pracyuye pevnij lektor
daysNotWork(CertainLector, Days) :- lector(Id, CertainLector, _, _, _, _), rozklad(_, _, Days, _), not(rozklad(Id, _, Days, _)).

% Znahodit kodi tih vikladachiv, sho ne chitayut v odin z dniv, v yakij vikladaye pevnij vikladach
doNotWorkAtLeastOneDay(CertainLector, Ids) :- lector(Ids, _, _, _, _, _), daysNotWork(CertainLector, Days), rozklad(Ids, _, Days, _).

% Znahodit usi dni, v yaki pracyuye vikladach z kodom Id
allDaysOfLector(Id, Days) :- lector(Id, _, _, _, _, _),  rozklad(Id, _, Days, _).

% 3 (4.2) Yaki vikladachi (prizvishe, kafedra) chitat v usi ti dni (v usi ti ta, mozhlivo, v inshi), sho i pevnij vikladach?
allDays(CertainLector, ResIds, ResSur, ResDepartment) :- lector(Id, CertainLector, _, _, _, _), lector(ResIds, ResSur, _, _, _, DepId), kafedra(DepId, ResDepartment), not(badLectors(Id, ResIds)), not(Id = ResIds).

% Znahodit kodi tih vikladachiv, sho ne chitayut u hoch odin z dniv, v yakij vikladaye vikladach z kl Id
badLectors(Id, ResIds) :- lector(Id, _, _, _, _, _), allDaysOfLector(Id, Days), lector(ResIds, _, _, _, _, _), not(rozklad(ResIds, _, Days, _)).

 goal 
% getHours("Paliy", "creative writing", Classes, Hours).
% getHours("Paliy", "american novel", Classes, Hours).
% getHours("Petrov", "data bases", Classes, Hours).

% youngestLectorInDepartment("literature", Surname).
% youngestLectorInDepartment("informatics", Surname).

% onlyTheSameDays("Ivanov", Id, Surname, Salary, Position).
% onlyTheSameDays("Kobzar", Id, Surname, Salary, Position).

% allDays("Melnyk", Id, Surname, Department).
% allDays("Petrov", Id, Surname, Department).
