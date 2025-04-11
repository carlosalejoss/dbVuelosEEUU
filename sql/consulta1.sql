WITH VuelosPorDia AS (
    SELECT v.compagnia, v.fecha, COUNT(*) AS vuelos_por_dia
    FROM VUELO v
    GROUP BY v.compagnia, v.fecha
    HAVING COUNT(*) >= 1000
),
CompaniasCalificadas AS (
    SELECT DISTINCT vpd.compagnia
    FROM VuelosPorDia vpd
),
RetrasoPromedio AS (
    SELECT v.compagnia, AVG(r.duracion) AS retraso_promedio
    FROM VUELO v
    JOIN INCIDENCIA i ON v.idVuelo = i.idVuelo
    JOIN RETRASO r ON i.idIncidencia = r.idIncidencia
    JOIN CompaniasCalificadas cc ON v.compagnia = cc.compagnia
    GROUP BY v.compagnia
)
SELECT c.nombre AS nombre_compania, rp.retraso_promedio
FROM RetrasoPromedio rp
JOIN COMPAGNIA c ON rp.compagnia = c.codigo
ORDER BY rp.retraso_promedio ASC