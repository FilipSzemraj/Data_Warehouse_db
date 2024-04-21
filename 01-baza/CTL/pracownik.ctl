LOAD DATA
INFILE 'CSV\pracownik.csv'
BADFILE 'BAD\pracownicy.bad'
DISCARDFILE 'DSC\pracownicy.dsc'
APPEND INTO TABLE pracownicy
FIELDS TERMINATED BY ","
TRAILING NULLCOLS
(id_pracownik,imie,salon_id_salon,stanowisko_id_stanowiska,nazwisko)