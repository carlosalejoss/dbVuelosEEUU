LOAD DATA
INFILE './Aeropuerto.csv'
INTO TABLE AEROPUERTO
FIELDS TERMINATED BY ';'
SKIP 1
(codigoIATA, nombre, ciudad, estado)