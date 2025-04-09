LOAD DATA
INFILE './Avion.csv'
INTO TABLE AVION
FIELDS TERMINATED BY ';'
SKIP 1
(matricula, agnoFabricacion, modelo, fabricante, motor)
