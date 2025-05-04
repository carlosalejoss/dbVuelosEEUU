CREATE OR REPLACE TRIGGER trg_incidencia_exclusividad_cancelacion
BEFORE INSERT ON CANCELACION
FOR EACH ROW
DECLARE
    v_count_retraso NUMBER := 0;
    v_count_desvio NUMBER := 0;
BEGIN
    -- Verificar si la incidencia ya existe en RETRASO o en DESVIO o en CANCELACION
    SELECT COUNT(*) INTO v_count_retraso FROM RETRASO r WHERE r.idIncidencia = :NEW.idIncidencia;

    SELECT COUNT(*) INTO v_count_desvio FROM DESVIO d WHERE d.idIncidencia = :NEW.idIncidencia;
    
    -- Si ya existe en otra tabla, rechazar la insercion
    IF v_count_retraso > 0 THEN
        RAISE_APPLICATION_ERROR(-20107, 'La incidencia ' || :NEW.idIncidencia || 
                               ' ya esta registrada como retraso. Una incidencia solo puede ser de un tipo.');
    END IF;
    
    IF v_count_desvio > 0 THEN
        RAISE_APPLICATION_ERROR(-20108, 'La incidencia ' || :NEW.idIncidencia || 
                               ' ya esta registrada como desvio. Una incidencia solo puede ser de un tipo.');
    END IF;
END;
/