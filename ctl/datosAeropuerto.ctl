LOAD DATA
INFILE './Aeropuerto.csv'
INTO TABLE AEROPUERTO
FIELDS TERMINATED BY ';'
(codigoIATA, nombre, ciudad, estado)

