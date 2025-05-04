CREATE MATERIALIZED VIEW MV_COMPAGNIA_MAX_AVIONES
BUILD IMMEDIATE
REFRESH ON DEMAND AS
SELECT v.compagnia, COUNT(DISTINCT v.avion) as num_aviones
FROM VUELO v
GROUP BY v.compagnia
ORDER BY num_aviones DESC;

/*
Para ver la mejora fisica habría que hacer lo siguiente:
    > @mejora1
    
    > EXPLAIN PLAN FOR
        WITH CompagniaPrincipal AS (
            SELECT c.compagnia
            FROM MV_COMPAGNIA_MAX_AVIONES c
            WHERE c.num_aviones = (SELECT MAX(num_aviones) FROM MV_COMPAGNIA_MAX_AVIONES)
        ),
        AeropuertosOperadosPorCompagniaPrincipal AS (
            SELECT DISTINCT v.aeropuertoSalida AS codigo_aeropuerto
            FROM VUELO v
            JOIN CompagniaPrincipal cp ON v.compagnia = cp.compagnia
            UNION
            SELECT DISTINCT v.aeropuertoLlegada AS codigo_aeropuerto
            FROM VUELO v
            JOIN CompagniaPrincipal cp ON v.compagnia = cp.compagnia
        )
        SELECT a.IATA, a.nombre, a.ciudad, a.estado
        FROM AEROPUERTO a
        WHERE (a.estado = 'AK' OR a.estado = 'CA')
        AND a.IATA NOT IN (
                SELECT codigo_aeropuerto
                FROM AeropuertosOperadosPorCompagniaPrincipal
        )
        ORDER BY a.estado, a.ciudad, a.nombre;

    > SELECT PLAN_TABLE_OUTPUT FROM TABLE(DBMS_XPLAN.DISPLAY());
*/