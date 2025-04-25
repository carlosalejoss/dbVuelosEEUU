CREATE OR REPLACE TRIGGER trg_incidencia_exclusividad_cancelacion
BEFORE INSERT OR UPDATE ON CANCELACION
FOR EACH ROW
DECLARE
    v_count_retraso NUMBER := 0;
    v_count_desvio NUMBER := 0;
    v_count_misma_cancelacion NUMBER := 0;  
BEGIN
    -- Verificar si la incidencia ya existe en RETRASO o en DESVIO
    SELECT COUNT(*) INTO v_count_retraso FROM RETRASO WHERE idIncidencia = :NEW.idIncidencia;
    SELECT COUNT(*) INTO v_count_desvio FROM DESVIO WHERE idIncidencia = :NEW.idIncidencia;
    
    -- Excluir el registro actual en caso de UPDATE
    SELECT COUNT(*) INTO v_count_misma_cancelacion
    FROM CANCELACION
    WHERE idIncidencia = :NEW.idIncidencia
    AND idCancelacion != NVL(:NEW.idCancelacion, -999); -- Si es INSERT, :NEW.idCancelacion sera NULL
    
    -- Si ya existe en otra tabla, rechazar la insercion
    IF v_count_retraso > 0 THEN
        RAISE_APPLICATION_ERROR(-20105, 'La incidencia ' || :NEW.idIncidencia || 
                               ' ya esta registrada como retraso. Una incidencia solo puede ser de un tipo.');
    END IF;
    
    IF v_count_desvio > 0 THEN
        RAISE_APPLICATION_ERROR(-20106, 'La incidencia ' || :NEW.idIncidencia || 
                               ' ya esta registrada como desvio. Una incidencia solo puede ser de un tipo.');
    END IF;
    
    IF v_count_misma_cancelacion > 0 THEN
        RAISE_APPLICATION_ERROR(-20107, 'La incidencia ' || :NEW.idIncidencia || 
                               ' ya esta registrada como cancelacion. No se permiten duplicados.');
    END IF;
END;
/