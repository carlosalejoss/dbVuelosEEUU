LOAD DATA
INFILE './Avion.csv'
INTO TABLE AVION
FIELDS TERMINATED BY ';'
(matricula, agnoFabricacion, modelo, fabricante, motor)