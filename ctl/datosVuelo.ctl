LOAD DATA
INFILE './Vuelo.csv'
INTO TABLE VUELO
FIELDS TERMINATED BY ';'
SKIP 1
(numeroVuelo, fecha, horaSalida, horaLlegada, aeropuertoSalida, aeropuertoLlegada, compagnia, avion)
