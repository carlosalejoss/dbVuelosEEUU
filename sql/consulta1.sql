WITH DiasTotales AS (
    -- Obtener todos los días distintos en los que hay vuelos
    SELECT DISTINCT fechaSalida AS dia
    FROM VUELO
),
NumDias AS (
    -- Contar el número total de días
    SELECT COUNT(*) AS total_dias
    FROM DiasTotales
),
VuelosPorCompaniaPorDia AS (
    -- Contar vuelos de cada compañía por día
    SELECT v.compagnia, v.fechaSalida, COUNT(*) AS vuelos_por_dia
    FROM VUELO v
    GROUP BY v.compagnia, v.fechaSalida
),
DiasConMilVuelos AS (
    -- Días con 1000+ vuelos por compañía
    SELECT vpcd.compagnia, COUNT(*) AS dias_con_1000_vuelos
    FROM VuelosPorCompaniaPorDia vpcd
    WHERE vpcd.vuelos_por_dia >= 1000
    GROUP BY vpcd.compagnia
),
CompaniasCalificadas AS (
    -- Seleccionar compañías que tuvieron 1000+ vuelos en TODOS los días
    SELECT dcmv.compagnia
    FROM DiasConMilVuelos dcmv, NumDias nd
    WHERE dcmv.dias_con_1000_vuelos = nd.total_dias
),
RetrasosPorVuelo AS (
    -- Obtener la duración del retraso para cada vuelo (solo si existe retraso)
    SELECT v.idVuelo, v.compagnia, r.duracion
    FROM VUELO v
    JOIN INCIDENCIA i ON v.idVuelo = i.idVuelo
    JOIN RETRASO r ON i.idIncidencia = r.idIncidencia
    WHERE v.compagnia IN (SELECT compagnia FROM CompaniasCalificadas)
),
TotalRetrasosPorCompania AS (
    -- Sumar las duraciones de los retrasos por compañía
    SELECT compagnia, SUM(duracion) AS total_minutos_retraso
    FROM RetrasosPorVuelo
    GROUP BY compagnia
),
TotalVuelosPorCompania AS (
    -- Contar el total de vuelos por compañía
    SELECT compagnia, COUNT(*) AS total_vuelos
    FROM VUELO
    WHERE compagnia IN (SELECT compagnia FROM CompaniasCalificadas)
    GROUP BY compagnia
),
RetrasoCompletoCompania AS (
    -- Combinar totales con retraso y sin retraso
    SELECT tvpc.compagnia, tvpc.total_vuelos, retrasos_aux.total_minutos_retraso
    FROM TotalVuelosPorCompania tvpc
    LEFT JOIN (SELECT trpc.compagnia, trpc.total_minutos_retraso FROM TotalRetrasosPorCompania trpc) retrasos_aux ON tvpc.compagnia = retrasos_aux.compagnia
),
PromediosConRetraso AS (
    -- Calcular promedio para compañías con retrasos
    SELECT compagnia, total_minutos_retraso / total_vuelos AS retraso_promedio
    FROM RetrasoCompletoCompania
    WHERE total_minutos_retraso IS NOT NULL
),
PromediosSinRetraso AS (
    -- Asignar 0 como promedio para compañías sin retrasos
    SELECT compagnia, 0 AS retraso_promedio
    FROM RetrasoCompletoCompania
    WHERE total_minutos_retraso IS NULL
),
PromediosCombinados AS (
    -- Combinar ambos conjuntos
    SELECT * FROM PromediosConRetraso
    UNION
    SELECT * FROM PromediosSinRetraso
)
SELECT c.nombre AS nombre_compania, pc.retraso_promedio AS retraso_promedio_por_vuelo_total
FROM PromediosCombinados pc
JOIN COMPAGNIA c ON pc.compagnia = c.codigo
ORDER BY retraso_promedio_por_vuelo_total ASC;