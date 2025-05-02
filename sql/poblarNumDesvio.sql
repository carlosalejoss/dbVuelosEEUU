UPDATE DESVIO d
SET numeroDesvio = (
    SELECT COUNT(*) + 1
    FROM DESVIO d2, INCIDENCIA i1, INCIDENCIA i2
    WHERE d2.idIncidencia = i1.idIncidencia
    AND d.idIncidencia = i2.idIncidencia
    AND i1.idVuelo = i2.idVuelo
    AND d2.idDesvio < d.idDesvio
)
WHERE numeroDesvio = 0;
