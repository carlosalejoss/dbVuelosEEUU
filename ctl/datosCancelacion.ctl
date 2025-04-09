LOAD DATA
INFILE './Cancelacion.csv'
INTO TABLE CANCELACION
FIELDS TERMINATED BY ';'
SKIP 1
(motivo, idIncidencia)