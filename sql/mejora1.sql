-- Vista materializada para los vuelos por compañía por día
CREATE MATERIALIZED VIEW MV_VUELOS_POR_COMPAGNIA_DIA
REFRESH ON DEMAND
AS
SELECT 
    v.compagnia, 
    v.fechaSalida, 
    COUNT(*) AS vuelos_por_dia
FROM VUELO v
GROUP BY v.compagnia, v.fechaSalida;

-- Vista materializada para retrasos
CREATE MATERIALIZED VIEW MV_RETRASOS_VUELO
REFRESH ON DEMAND
AS
SELECT v.idVuelo, v.compagnia, r.duracion
FROM VUELO v
JOIN INCIDENCIA i ON v.idVuelo = i.idVuelo
JOIN RETRASO r ON i.idIncidencia = r.idIncidencia;
