CREATE MATERIALIZED VIEW MV_AEROPUERTOS_AVIONES_JOVENES
REFRESH COMPLETE ON DEMAND
AS
SELECT v.aeropuertoSalida AS codigo_aeropuerto, v.avion, a.agnoFabricacion
FROM VUELO v
JOIN AVION a ON v.avion = a.matricula
UNION
SELECT v.aeropuertoLlegada AS codigo_aeropuerto, v.avion, a.agnoFabricacion
FROM VUELO v
JOIN AVION a ON v.avion = a.matricula;

/* 
Para ver la mejora fisica habría que hacer lo siguiente:
    > @mejora3
    
    > EXPLAIN PLAN FOR
        WITH EdadPromedioPorAeropuerto AS (
            SELECT codigo_aeropuerto, AVG(2025 - agnoFabricacion) AS edad_promedio
            FROM MV_AEROPUERTOS_AVIONES_JOVENES
            GROUP BY codigo_aeropuerto
        ),
        AeropuertoConAvionesJovenes AS (
            SELECT codigo_aeropuerto, edad_promedio
            FROM EdadPromedioPorAeropuerto
            WHERE edad_promedio = (SELECT MIN(edad_promedio) FROM EdadPromedioPorAeropuerto)
        )
        SELECT a.IATA, a.nombre, aaj.edad_promedio AS media_edad_aviones
        FROM AeropuertoConAvionesJovenes aaj
        JOIN AEROPUERTO a ON aaj.codigo_aeropuerto = a.IATA;

    > SELECT PLAN_TABLE_OUTPUT FROM TABLE(DBMS_XPLAN.DISPLAY());
*/