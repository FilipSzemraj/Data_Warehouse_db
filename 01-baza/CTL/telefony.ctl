LOAD DATA
INFILE 'CSV\telefony.csv'
BADFILE 'BAD\telefony.bad'
DISCARDFILE 'DSC\telefony.dsc'
APPEND INTO TABLE telefony
FIELDS TERMINATED BY ","
TRAILING NULLCOLS
(id_telefon,kolor_id_kolor,model_id_model)