CREATE OR REPLACE TRIGGER trg_incidencia_exclusividad
BEFORE INSERT OR UPDATE ON RETRASO
FOR EACH ROW
DECLARE
    v_count_desvio NUMBER := 0;
    v_count_cancelacion NUMBER := 0;
    v_count_mismo_retraso NUMBER := 0;
BEGIN
    -- Verificar si la incidencia ya existe en DESVIO o CANCELACION 
    SELECT COUNT(*) INTO v_count_desvio FROM DESVIO WHERE idIncidencia = :NEW.idIncidencia;
    SELECT COUNT(*) INTO v_count_cancelacion FROM CANCELACION WHERE idIncidencia = :NEW.idIncidencia;
    
    -- Excluir el registro actual en caso de UPDATE
    SELECT COUNT(*) INTO v_count_mismo_retraso
    FROM RETRASO
    WHERE idIncidencia = :NEW.idIncidencia
    AND idRetraso != NVL(:NEW.idRetraso, -999); -- Si es INSERT, :NEW.idRetraso será NULL
    
    IF v_count_desvio > 0 THEN
        RAISE_APPLICATION_ERROR(-20101, 'La incidencia ' || :NEW.idIncidencia || 
                               ' ya está registrada como desvío. Una incidencia solo puede ser de un tipo.');
    END IF;
    
    IF v_count_cancelacion > 0 THEN
        RAISE_APPLICATION_ERROR(-20102, 'La incidencia ' || :NEW.idIncidencia || 
                               ' ya está registrada como cancelación. Una incidencia solo puede ser de un tipo.');
    END IF;
    
    IF v_count_mismo_retraso > 0 THEN
        RAISE_APPLICATION_ERROR(-20103, 'La incidencia ' || :NEW.idIncidencia || 
                               ' ya está registrada como retraso. No se permiten duplicados.');
    END IF;
END;
/