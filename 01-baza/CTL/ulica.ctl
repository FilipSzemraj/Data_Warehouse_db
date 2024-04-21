LOAD DATA
INFILE 'CSV\ulica.csv'
BADFILE 'BAD\ulica.bad'
DISCARDFILE 'DSC\ulica.dsc'
APPEND INTO TABLE ulica
FIELDS TERMINATED BY ","
TRAILING NULLCOLS
(miasta_id_miasta,id_ulica,nazwa)