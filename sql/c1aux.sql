WITH RetrasosCompagnia AS (
    -- Contamos los retrasos y sumamos su duración para una compañía específica
    SELECT 
        c.codigo, 
        c.nombre AS nombre_compagnia,
        COUNT(*) AS cantidad_retrasos,
        SUM(r.duracion) AS duracion_total_retrasos,
        AVG(r.duracion) AS duracion_promedio
    FROM 
        VUELO v
    JOIN 
        INCIDENCIA i ON v.idVuelo = i.idVuelo
    JOIN 
        RETRASO r ON i.idIncidencia = r.idIncidencia
    JOIN 
        COMPAGNIA c ON v.compagnia = c.codigo
    WHERE 
        c.codigo = 'MQ'  -- Código de la compañía aérea
    GROUP BY 
        c.codigo, c.nombre
)
SELECT 
    rc.nombre_compagnia,
    rc.cantidad_retrasos,
    rc.duracion_total_retrasos || ' minutos' AS duracion_total,
    ROUND(rc.duracion_promedio, 2) || ' minutos' AS duracion_promedio_retraso,
    (SELECT COUNT(*) FROM VUELO WHERE compagnia = rc.codigo) AS total_vuelos,
    ROUND((rc.cantidad_retrasos / (SELECT COUNT(*) FROM VUELO WHERE compagnia = rc.codigo)) * 100, 2) || '%' AS porcentaje_vuelos_retrasados
FROM 
    RetrasosCompagnia rc;