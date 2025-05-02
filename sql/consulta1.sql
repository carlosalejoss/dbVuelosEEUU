WITH DiasTotales AS (
    -- Obtener todos los días distintos en los que hay vuelos
    SELECT DISTINCT fechaSalida AS dia
    FROM VUELO
),
VuelosPorCompaniaPorDia AS (
    -- Contar vuelos de cada compañía por día
    SELECT v.compagnia, v.fechaSalida, COUNT(*) AS vuelos_por_dia
    FROM VUELO v
    GROUP BY v.compagnia, v.fechaSalida
),
DiasOperativosPorCompania AS (
    -- Contar en cuántos días cada compañía tuvo 1000+ vuelos
    SELECT vpcd.compagnia, COUNT(*) AS dias_con_1000_vuelos
    FROM VuelosPorCompaniaPorDia vpcd
    WHERE vpcd.vuelos_por_dia >= 1000
    GROUP BY vpcd.compagnia
),
CompaniasCalificadas AS (
    -- Seleccionar compañías que tuvieron 1000+ vuelos en TODOS los días
    SELECT dopc.compagnia
    FROM DiasOperativosPorCompania dopc
    JOIN (SELECT COUNT(*) AS total_dias FROM DiasTotales) dt ON dopc.dias_con_1000_vuelos = dt.total_dias
),
RetrasoPromedio AS (
    -- Calcular el retraso promedio para las compañías calificadas
    SELECT v.compagnia, AVG(r.duracion) AS retraso_promedio
    FROM VUELO v
    JOIN INCIDENCIA i ON v.idVuelo = i.idVuelo
    JOIN RETRASO r ON i.idIncidencia = r.idIncidencia
    WHERE v.compagnia IN (SELECT compagnia FROM CompaniasCalificadas)
    GROUP BY v.compagnia
)
SELECT c.nombre AS nombre_compania, rp.retraso_promedio
FROM RetrasoPromedio rp
JOIN COMPAGNIA c ON rp.compagnia = c.codigo
ORDER BY rp.retraso_promedio ASC;