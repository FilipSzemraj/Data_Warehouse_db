LOAD DATA
INFILE 'CSV\salon.csv'
BADFILE 'BAD\salon.bad'
DISCARDFILE 'DSC\salon.dsc'
APPEND INTO TABLE salon
FIELDS TERMINATED BY ","
TRAILING NULLCOLS
(id_salon,nazwa,ulica_id_ulica)