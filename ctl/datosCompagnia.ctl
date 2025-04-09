OPTIONS (SKIP=1)
load data
infile './Compagnia.csv'
into table COMPAGNIA
fields terminated by ';'
(codigo, nombre)
