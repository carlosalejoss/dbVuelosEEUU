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
    SELECT codigo_aeropuerto,AVG(2024 - agnoFabricacion) AS edad_promedio
    FROM AvionesEnAeropuertos
    GROUP BY codigo_aeropuerto
),
AeropuertoConAvionesJovenes AS (
    SELECT codigo_aeropuerto, edad_promedio
    FROM EdadPromedioPorAeropuerto
    WHERE edad_promedio = (SELECT MIN(edad_promedio) FROM EdadPromedioPorAeropuerto)
)
SELECT a.codigoIATA, a.nombre, aaj.edad_promedio AS media_edad_aviones
FROM AeropuertoConAvionesJovenes aaj
JOIN AEROPUERTO a ON aaj.codigo_aeropuerto = a.codigoIATA;