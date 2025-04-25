CREATE OR REPLACE TRIGGER trg_incidencia_coherencia
BEFORE INSERT OR UPDATE ON RETRASO
FOR EACH ROW
DECLARE
    v_existe_cancelacion NUMBER := 0;
BEGIN
    -- Verificar si existe una cancelación para el vuelo asociado a esta incidencia
    SELECT COUNT(*)
    INTO v_existe_cancelacion
    FROM CANCELACION c
    JOIN INCIDENCIA i ON c.idIncidencia = i.idIncidencia
    WHERE i.idVuelo = (SELECT idVuelo FROM INCIDENCIA WHERE idIncidencia = :NEW.idIncidencia);
    
    -- Si existe cancelación, no permitir la inserción de retraso
    IF v_existe_cancelacion > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'No se puede registrar un retraso en un vuelo cancelado');
    END IF;
END;
/

/*
INSERT INTO VUELO (idVuelo, numeroVuelo, fecha, horaSalida, horaLlegada, 
                  aeropuertoSalida, aeropuertoLlegada, compagnia, avion)
VALUES (secVuelo.NEXTVAL, 9999, '16/04/2024', '0800', '1000', 
       'RNO', 'SJC', 'WN', 'N551WN');

INSERT INTO INCIDENCIA (idIncidencia, idVuelo)
    VALUES (secIncidencia.NEXTVAL, 48422);

INSERT INTO CANCELACION (idCancelacion, motivo, idIncidencia)
    VALUES (secCancelacion.NEXTVAL, 'Prueba de trigger', 13024);

INSERT INTO RETRASO (idRetraso, causa, duracion, idIncidencia)
    VALUES (secRetraso.NEXTVAL, 'Prueba', 30, 13022);
*/