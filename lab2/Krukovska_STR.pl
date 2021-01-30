 info( pharmacy(firstStreet, 380670123451),
     [
	 product(medication(ibuprofen, analgesics), 1000, 52.30, date( 2020, 12, 31)),
	 product(medication(flucloxacillin, antibiotics), 1, 250.00, date( 2025, 9, 28)),
	 product(medication(tetracycline, analgesics), 19, 1499.49, date( 2023, 8, 4)),
	 product(medication(lithium, moodStabilizer), 78, 499.99, date( 2023, 7, 15))
	 ]).
 info( pharmacy(secondStreet, 380979876592),
     [
	 product(medication(flucloxacillin, antibiotics), 20, 9.99, date( 2010, 9, 28)),
	 product(medication(ibuprofen, analgesics), 10, 55.0, date( 2021, 1, 31)),
	 product(medication(lithium, mood_stabilizer), 6, 498.99, date( 2022, 2, 28))
	 ]).
 info( pharmacy(secondStreet, 380670654323),
     [
	 product(medication(tetracycline, antibiotics), 1, 0.01, date( 2018, 12, 31)),
	 product(medication(ibuprofen, analgesics), 2567, 60.00, date( 2024, 4, 13)),
	 product(medication(morphine, analgesics), 2, 10000000.00, date( 2034, 10, 28))
	 ]).
 info( pharmacy(thirdStreet, 380680124894),
     [product(medication(lithium, mood_stabilizer), 9, 500.00, date( 2023, 10, 11))
	 ]).
 info( pharmacy(fifthStreet, 380980263445),
     []).
	 
  pharmacy(X) :- info( X, _ ).

  item(X) :-  info( _, Y),  belongs( X, Y).
			  
  belongs( X, [X | _ ]).

  belongs( X, [_ | L ]) :-  belongs( X, L).

  getPhoneNumber(pharmacy( _, PhoneNumber ), PhoneNumber).
  
  expirationDate(product(medication(_, _), _, _, ExprDate), ExprDate).
  
  pharmacyAddress(pharmacy(Address, _), Address).

% Телефон аптеки, де є потрібні ліки
findPhoneByMed(MedName, PhoneNumber) :- info(P, Meds), belongs(product(medication(MedName, _), _, _, _), Meds), getPhoneNumber(P, PhoneNumber).

% В якій аптеці ціна на задані ліки є меншою за визначену величину
pharmacyCheaperMeds(MedName, Price, P) :- info(P, Medications), belongs(product(medication(MedName, _), _, MedPrice, _), Medications), MedPrice < Price.

% В яких ліків термін придатності перевищено
findOutdatedMedications(X) :- date(CurrentDate), item(X), expirationDate(X, ExprDate), ExprDate @<  CurrentDate.

% Аптеки, що розташовані на конкретній вулиці
findPharmacyByAddress(Address, Pharmacy) :- info(Pharmacy, _), pharmacyAddress(Pharmacy, Address).

% Аптеки, в якій закінчуються конкретні ліки
runsOutOfMedication(MedName, P) :- info(P, Medications), belongs(product(medication(MedName, _), Amount, _, _), Medications), Amount @=< 10.

% Чи ціна в першій аптеці нижча за ціну на той самий препарат в другій
compareTwoPrices(MedName, Phone1, Phone2) :- info(pharmacy(_, Phone1), Meds1), info(pharmacy(_, Phone2), Meds2),  belongs(product(medication(MedName, _), _, Price1, _), Meds1),  belongs(product(medication(MedName, _), _, Price2, _), Meds2), Price1 < Price2, !.

% Знайти аптеки, де продається, як мінімум три препарати.
moreThanThreeProducts(P) :- info(P, [ _, _, _ | _ ]).


% Запити
% findPhoneByMed(lithium, X).
% findPhoneByMed(morphine, X).

% pharmacyCheaperMeds(ibuprofen, 55.10, X).
% pharmacyCheaperMeds(tetracycline, 1499, X).

% findOutdatedMedications(X).

% findPharmacyByAddress(firstStreet, X).
% findPharmacyByAddress(secondStreet, X).

% runsOutOfMedication(X, Y).
% runsOutOfMedication(lithium, Y).

% compareTwoPrices(lithium, 380979876592, 380680124894).
% compareTwoPrices(lithium, 380680124894, 380970123452).
