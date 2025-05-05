WITH AvionesEnAeropuertos AS (
    -- Extraer el año de fechaSalida para calcular la edad real del avión cuando hizo el vuelo
    SELECT v.aeropuertoSalida AS codigo_aeropuerto, v.avion, a.agnoFabricacion, TO_NUMBER(SUBSTR(v.fechaSalida, 7, 4)) AS anio_vuelo  -- Extrae el año de 'DD/MM/YYYY'
    FROM VUELO v
    JOIN AVION a ON v.avion = a.matricula
    UNION ALL
    SELECT v.aeropuertoLlegada AS codigo_aeropuerto, v.avion, a.agnoFabricacion, TO_NUMBER(SUBSTR(v.fechaLlegada, 7, 4)) AS anio_vuelo  -- Extrae el año de 'DD/MM/YYYY'
    FROM VUELO v
    JOIN AVION a ON v.avion = a.matricula
),
EdadPromedioPorAeropuerto AS (
    -- Calcular la edad del avión en el momento del vuelo
    SELECT codigo_aeropuerto, AVG(anio_vuelo - agnoFabricacion) AS edad_promedio
    FROM AvionesEnAeropuertos
    GROUP BY codigo_aeropuerto
),
AeropuertoConAvionesJovenes AS (
    -- Encontrar el aeropuerto con la flota más joven en promedio
    SELECT codigo_aeropuerto, edad_promedio
    FROM EdadPromedioPorAeropuerto
    WHERE edad_promedio = (SELECT MIN(edad_promedio) FROM EdadPromedioPorAeropuerto)
)
SELECT a.IATA, a.nombre, aaj.edad_promedio
FROM AeropuertoConAvionesJovenes aaj
JOIN AEROPUERTO a ON aaj.codigo_aeropuerto = a.IATA;