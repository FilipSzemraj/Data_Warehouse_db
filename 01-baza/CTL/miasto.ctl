LOAD DATA
INFILE 'CSV\miasto.csv'
BADFILE 'BAD\miasto.bad'
DISCARDFILE 'DSC\miasto.dsc'
APPEND INTO TABLE miasta
FIELDS TERMINATED BY ","
TRAILING NULLCOLS
(id_miasta,nazwa,wojewodztwo_id_wojewodztwa)