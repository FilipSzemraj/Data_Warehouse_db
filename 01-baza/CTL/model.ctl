LOAD DATA
INFILE 'CSV\model.csv'
BADFILE 'BAD\model.bad'
DISCARDFILE 'DSC\model.dsc'
APPEND INTO TABLE model
FIELDS TERMINATED BY ","
TRAILING NULLCOLS
(id_model,nazwa,marka_id_marka)