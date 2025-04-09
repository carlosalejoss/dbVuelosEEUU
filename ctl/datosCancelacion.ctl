LOAD DATA
INFILE './Cancelacion.csv'
INTO TABLE CANCELACION
FIELDS TERMINATED BY ';'
(motivo, idIncidencia)