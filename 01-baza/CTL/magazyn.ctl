LOAD DATA
INFILE 'CSV\magazyn.csv'
BADFILE 'BAD\magazyn.bad'
DISCARDFILE 'DSC\magazyn.dsc'
APPEND INTO TABLE magazyn
FIELDS TERMINATED BY ","
TRAILING NULLCOLS
(id_magazyn,ilosc,telefony_id_telefon,salon_id_salon)