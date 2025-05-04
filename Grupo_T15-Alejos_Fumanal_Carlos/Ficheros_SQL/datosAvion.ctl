OPTIONS (SKIP=1)
LOAD DATA
INFILE './Avion.csv'
INTO TABLE AVION
FIELDS TERMINATED BY ';'
(matricula, agnoFabricacion, modelo)