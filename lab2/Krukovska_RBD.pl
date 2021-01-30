is_pharmacy(1, firstStreet, 380670123451).
is_pharmacy(2, secondStreet, 380970123452).
is_pharmacy(3, secondStreet, 380670654323).
is_pharmacy(4, thirdStreet, 380680124894).
is_pharmacy(5, fifthStreet, 380980263445).

is_medication(111111, flucloxacillin, antibiotics). 
is_medication(111112, tetracycline, antibiotics). 
is_medication(111113, ibuprofen, analgesics).
is_medication(111114, morphine, analgesics).
is_medication(111115, lithium, mood_stabilizer).

has_pharmacy(1, 111111, 1, 250.00, 2025).
has_pharmacy(2, 111111, 20, 9.99, 2010).
has_pharmacy(1, 111112, 19, 1499.49, 2023).
has_pharmacy(3, 111112, 1, 0.01, 2018).
has_pharmacy(1, 111113, 1000, 52.30, 2020).
has_pharmacy(2, 111113, 10, 55.0, 2021).
has_pharmacy(3, 111113, 2567, 60.00, 2024).
has_pharmacy(3, 111114, 2, 10000000.00, 2034).
has_pharmacy(1, 111115, 78, 499.99, 2023).
has_pharmacy(2, 111115, 6, 498.99, 2022).
has_pharmacy(4, 111115, 9, 500.00, 2023).

getCurrentYear(Year) :- get_time(Stamp), stamp_date_time(Stamp, DateTime, local), date_time_value(year, DateTime, Year).

% Телефон аптеки, де є потрібні ліки
findPhoneNumberByMed(MedicationName, PhoneNumber) :- is_medication(MedicationId, MedicationName, _), has_pharmacy(PharmacyId, MedicationId, _, _, _), is_pharmacy(PharmacyId, _, PhoneNumber).

% В якій аптеці ціна на задані ліки є меншою за визначену величину
pharmacyWithCheaperMeds(MedicationName, Price, PharmacyId) :- is_medication(MedicationId, MedicationName, _), has_pharmacy(PharmacyId, MedicationId, _, MedPrice, _), MedPrice < Price.

% В яких ліків термін придатності перевищено
findOutdatedMeds(MedName, Year) :- has_pharmacy(_, MedicationId, _, _, Year), getCurrentYear(CurrentYear), CurrentYear > Year, is_medication(MedicationId, MedName, _).

% Аптеки, що розташовані на конкретній вулиці
pharmacyByAddress(Address, PharmacyId) :- is_pharmacy(PharmacyId, Address, _).

% Аптеки, в яких закінчуються конкретні ліки
runsOutOfMeds(MedicationName, PharmacyId) :- is_medication(MedicationId, MedicationName, _), has_pharmacy(PharmacyId, MedicationId, Amount, _, _), Amount @=< 10 .

% Чи ціна в першій аптеці нижча за ціну на той самий препарат в другій
comparePrices(MedName, Phone1, Phone2) :- is_pharmacy(Id1,_, Phone1), is_pharmacy(Id2,_, Phone2), is_medication(MedId, MedName, _), has_pharmacy(Id1, MedId, _, Price1, _),  has_pharmacy(Id2, MedId, _, Price2, _), Price1 < Price2, !. 


% Запити
% findPhoneNumberByMed(lithium, X).
% findPhoneNumberByMed(morphine, X).

% pharmacyWithCheaperMeds(ibuprofen, 55.10, X).
% pharmacyWithCheaperMeds(tetracycline, 1499, X).

% findOutdatedMeds(X, Y).

% pharmacyByAddress(firstStreet, X).
% pharmacyByAddress(secondStreet, X).

% runsOutOfMeds(X, Y).
% runsOutOfMeds(lithium, Y).

% comparePrices(lithium, 380970123452, 380680124894).
% comparePrices(lithium, 380680124894, 380970123452).
