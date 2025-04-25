WITH CompagniaConMasAviones AS (
    SELECT v.compagnia, COUNT(DISTINCT v.avion) AS num_aviones
    FROM VUELO v
    GROUP BY v.compagnia
    ORDER BY num_aviones DESC
),
CompagniaPrincipal AS (
    SELECT compagnia
    FROM CompagniaConMasAviones
    WHERE ROWNUM = 1
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