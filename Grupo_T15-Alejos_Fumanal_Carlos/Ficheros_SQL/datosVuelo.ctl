OPTIONS (SKIP=1)
LOAD DATA
INFILE './Vuelo.csv'
INTO TABLE VUELO
FIELDS TERMINATED BY ';'
(numeroVuelo, fechaSalida, fechaLlegada, horaSalida, horaLlegada, aeropuertoSalida, aeropuertoLlegada, compagnia, avion)