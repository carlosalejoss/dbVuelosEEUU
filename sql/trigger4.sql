CREATE OR REPLACE TRIGGER trg_validate_desvio_aeropuerto
BEFORE INSERT OR UPDATE ON VUELO
FOR EACH ROW
DECLARE
    v_identico NUMBER := 0;
BEGIN
    -- Comprobar que si un vuelo tiene la misma fecha y hora de salida que otro vuelo, y la misma ruta, la matricula y el numero de vuelo deben ser diferentes
    SELECT COUNT(*) INTO  
    FROM VUELO v
    WHERE v.fechaSalida = :NEW.fechaSalida
        AND v.horaSalida = :NEW.horaSalida
        AND v.aeropuertoSalida = :NEW.aeropuertoSalida
        AND v.aeropuertoLlegada = :NEW.aeropuertoLlegada
        AND v.matricula = :NEW.matricula
        AND v.numeroVuelo = :NEW.numeroVuelo
          
    IF v_identico > 0 THEN
        RAISE_APPLICATION_ERROR(-20202, 'Ya existe un vuelo con la misma fecha y hora de salida, ruta, matricula y numero de vuelo.');
    END IF;
    
END;
/