CREATE OR REPLACE TRIGGER trg_incidencia_exclusividad_desvio
BEFORE INSERT ON DESVIO
FOR EACH ROW
DECLARE
    v_count_retraso NUMBER := 0;
    v_count_cancelacion NUMBER := 0;
BEGIN
    -- Verificar si la incidencia ya existe en RETRASO o en CANCELACION o en DESVIO
    SELECT COUNT(*) INTO v_count_retraso FROM RETRASO r WHERE r.idIncidencia = :NEW.idIncidencia;
    SELECT COUNT(*) INTO v_count_cancelacion FROM CANCELACION c WHERE c.idIncidencia = :NEW.idIncidencia;
   
    -- Si ya existe en otra tabla, rechazar la insercion
    IF v_count_retraso > 0 THEN
        RAISE_APPLICATION_ERROR(-20104, 'La incidencia ' || :NEW.idIncidencia || 
                               ' ya esta registrada como retraso. Una incidencia solo puede ser de un tipo.');
    END IF;
    
    IF v_count_cancelacion > 0 THEN
        RAISE_APPLICATION_ERROR(-20105, 'La incidencia ' || :NEW.idIncidencia || 
                               ' ya esta registrada como cancelacion. Una incidencia solo puede ser de un tipo.');
    END IF;
END;
/