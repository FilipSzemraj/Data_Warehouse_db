LOAD DATA
INFILE 'CSV\klient.csv'
BADFILE 'BAD\klient.bad'
DISCARDFILE 'DSC\klient.dsc'
APPEND INTO TABLE klient
FIELDS TERMINATED BY ","
TRAILING NULLCOLS
(id_klient,imie,nazwisko,nr_telefonu,nr_dowodu_osobistego,ulica_id_ulica)