OPTIONS (SKIP=1)
LOAD DATA
INFILE './Retraso.csv'
INTO TABLE RETRASO
FIELDS TERMINATED BY ';'
(causa, duracion, idIncidencia)
