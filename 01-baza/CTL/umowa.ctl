LOAD DATA
INFILE 'CSV\umowa.csv'
BADFILE 'BAD\umowa.bad'
DISCARDFILE 'DSC\umowa.dsc'
APPEND INTO TABLE umowa
FIELDS TERMINATED BY ","
TRAILING NULLCOLS
(id_umowa,data DATE "DD-MM-YYYY",pracownicy_id_pracownik,klient_id_klient,cena,ilosc,magazyn_id_magazyn)