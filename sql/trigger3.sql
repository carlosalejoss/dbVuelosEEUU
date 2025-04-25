CREATE OR REPLACE TRIGGER trg_validate_desvio_aeropuerto
BEFORE INSERT OR UPDATE ON DESVIO
FOR EACH ROW
DECLARE
    v_aeropuerto_llegada VARCHAR2(4);
BEGIN
    -- Obtener el aeropuerto de llegada original del vuelo asociado a esta incidencia
    SELECT v.aeropuertoLlegada
    INTO v_aeropuerto_llegada
    FROM VUELO v
    JOIN INCIDENCIA i ON v.idVuelo = i.idVuelo
    WHERE i.idIncidencia = :NEW.idIncidencia;
    
    -- Comprobar si el aeropuerto de desvío es el mismo que el de llegada original
    IF :NEW.aeropuertoDesvio = v_aeropuerto_llegada THEN
        RAISE_APPLICATION_ERROR(-20201, 'El aeropuerto de desvio (' || :NEW.aeropuertoDesvio || 
                              ') no puede ser el mismo que el aeropuerto de llegada original del vuelo.');
    END IF;
END;
/

INSERT INTO DESVIO (numeroDesvio, aeropuertoDesvio, idIncidencia)
        VALUES (1, 'ORD', 13024);

INSERT INTO DESVIO (numeroDesvio, aeropuertoDesvio, idIncidencia)
        VALUES (2, 'SJC', 13024);