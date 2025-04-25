CREATE OR REPLACE TRIGGER trg_incidencia_exclusividad_retraso
BEFORE INSERT ON RETRASO
FOR EACH ROW
DECLARE
    v_count_desvio NUMBER := 0;
    v_count_cancelacion NUMBER := 0;
    v_count_retraso NUMBER := 0;
BEGIN
    -- Verificar si la incidencia ya existe en DESVIO o en CANCELACION o en RETRASO
    SELECT COUNT(*) INTO v_count_desvio FROM DESVIO WHERE idIncidencia = :NEW.idIncidencia;
    SELECT COUNT(*) INTO v_count_cancelacion FROM CANCELACION WHERE idIncidencia = :NEW.idIncidencia;
    SELECT COUNT(*) INTO v_countretraso FROM RETRASO WHERE idIncidencia = :NEW.idIncidencia;
    
    -- Si ya existe en otra tabla, rechazar la insercion
    IF v_count_desvio > 0 THEN
        RAISE_APPLICATION_ERROR(-20101, 'La incidencia ' || :NEW.idIncidencia || 
                               ' ya esta registrada como desvio. Una incidencia solo puede ser de un tipo.');
    END IF;
    
    IF v_count_cancelacion > 0 THEN
        RAISE_APPLICATION_ERROR(-20102, 'La incidencia ' || :NEW.idIncidencia || 
                               ' ya esta registrada como cancelacion. Una incidencia solo puede ser de un tipo.');
    END IF;
    
    IF v_count_retraso > 0 THEN
        RAISE_APPLICATION_ERROR(-20103, 'La incidencia ' || :NEW.idIncidencia || 
                               ' ya esta registrada como retraso. No se permiten duplicados.');
    END IF;
END;
/