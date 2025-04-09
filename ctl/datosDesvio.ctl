LOAD DATA
INFILE './Desvio.csv'
INTO TABLE DESVIO
FIELDS TERMINATED BY ';'
SKIP 1
(numeroDesvio, aeropuertoDesvio, idIncidencia)
