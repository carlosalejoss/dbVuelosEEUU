CREATE MATERIALIZED VIEW MV_AEROPUERTOS_AVIONES_JOVENES
REFRESH COMPLETE ON DEMAND
AS
WITH AvionesEnAeropuertos AS (
    SELECT v.aeropuertoSalida AS codigo_aeropuerto, v.avion, a.agnoFabricacion
    FROM VUELO v
    JOIN AVION a ON v.avion = a.matricula
    UNION
    SELECT v.aeropuertoLlegada AS codigo_aeropuerto, v.avion, a.agnoFabricacion
    FROM VUELO v
    JOIN AVION a ON v.avion = a.matricula
),
EdadPromedioPorAeropuerto AS (
    SELECT codigo_aeropuerto, AVG(2025 - agnoFabricacion) AS edad_promedio
    FROM AvionesEnAeropuertos
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

/* Para ejecutar los comando para ver el resultado de la vista materializada, 
   primero se debe crear la vista materializada y luego ejecutar el siguiente código
   
   EXPLAIN PLAN FOR 
   SELECT * FROM MV_AEROPUERTOS_AVIONES_JOVENES;

   SELECT PLAN_TABLE_OUTPUT FROM TABLE(DBMS_XPLAN.DISPLAY());
   
   */