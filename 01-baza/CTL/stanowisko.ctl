LOAD DATA
INFILE 'CSV\stanowisko.csv'
BADFILE 'BAD\stanowisko.bad'
DISCARDFILE 'DSC\stanowisko.dsc'
APPEND INTO TABLE stanowisko
FIELDS TERMINATED BY ","
TRAILING NULLCOLS
(id_stanowiska,nazwa,pensja)