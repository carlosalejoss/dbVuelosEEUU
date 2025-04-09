load data
infile './(Compagnia.csv)'
into table (COMPAGNIA)
fields terminated by ';'
SKIP 1
(codigo, nombre)