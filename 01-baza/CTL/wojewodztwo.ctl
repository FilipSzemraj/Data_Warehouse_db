LOAD DATA
INFILE 'CSV\wojewodztwo.csv'
BADFILE 'BAD\wojewodztwo.bad'
DISCARDFILE 'DSC\wojewodztwo.dsc'
APPEND INTO TABLE wojewodztwo
FIELDS TERMINATED BY ","
TRAILING NULLCOLS
(id_wojewodztwa,nazwa)