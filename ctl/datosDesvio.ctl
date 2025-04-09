LOAD DATA
INFILE './Desvio.csv'
INTO TABLE DESVIO
FIELDS TERMINATED BY ';'
(numeroDesvio, aeropuertoDesvio, idIncidencia)