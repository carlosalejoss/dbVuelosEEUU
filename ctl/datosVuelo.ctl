LOAD DATA
INFILE './Vuelo.csv'
INTO TABLE VUELO
FIELDS TERMINATED BY ';'
(numeroVuelo, fecha, horaSalida, horaLlegada, aeropuertoSalida, aeropuertoLlegada, compagnia, avion)
