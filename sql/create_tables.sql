CREATE TABLE AEROPUERTO (
    IATA VARCHAR(4) PRIMARY KEY,
    nombre VARCHAR(64) NOT NULL,
    ciudad VARCHAR(64) NOT NULL,
    estado VARCHAR(8) NOT NULL
);

CREATE TABLE COMPAGNIA (
    codigo VARCHAR(8) PRIMARY KEY,
    nombre VARCHAR(128) NOT NULL
);

CREATE TABLE MODELO (
    nombre VARCHAR(32) PRIMARY KEY,
    fabricante VARCHAR(32) NOT NULL,
    motor VARCHAR(32) NOT NULL
);

CREATE TABLE AVION (
    matricula VARCHAR(8) PRIMARY KEY,
    agnoFabricacion NUMBER(4),
    modelo VARCHAR(32),
    FOREIGN KEY (modelo) REFERENCES MODELO(nombre)
);

CREATE TABLE VUELO (
    idVuelo NUMBER(8) PRIMARY KEY,
    numeroVuelo NUMBER(8) NOT NULL,
    fechaSalida VARCHAR(10) NOT NULL,
    fechaLlegada VARCHAR(10) NOT NULL,
    horaSalida VARCHAR(4) NOT NULL,
    horaLlegada VARCHAR(4) NOT NULL,
    aeropuertoSalida VARCHAR(4) NOT NULL,
    aeropuertoLlegada VARCHAR(4) NOT NULL,
    compagnia VARCHAR(8) NOT NULL,
    avion VARCHAR(8) NULL, -- Hay vuelos cancelados que no tienen avion asignado
    FOREIGN KEY (aeropuertoSalida) REFERENCES AEROPUERTO(IATA),
    FOREIGN KEY (aeropuertoLlegada) REFERENCES AEROPUERTO(IATA),
    FOREIGN KEY (compagnia) REFERENCES COMPAGNIA(codigo),
    FOREIGN KEY (avion) REFERENCES AVION(matricula),
    CONSTRAINT chk_vuelo_unico UNIQUE (fechaSalida, fechaLlegada, horaSalida, horaLlegada, avion),
    CONSTRAINT chk_aeropuertos_distintos CHECK ( aeropuertoSalida <> aeropuertoLlegada ),
    CONSTRAINT chk_formato_fechas CHECK (
        -- Validación de fechaSalida
        LENGTH(fechaSalida) = 10 AND
        TO_DATE(fechaSalida, 'DD/MM/YYYY') IS NOT NULL
        AND
        -- Validación de fechaLlegada
        LENGTH(fechaLlegada) = 10 AND
        TO_DATE(fechaLlegada, 'DD/MM/YYYY') IS NOT NULL
    ),
    CONSTRAINT chk_coherencia_fechas CHECK (
        -- Caso 1: Fechas diferentes - la fecha de salida puede ser anterior a la de llegada
        (TO_DATE(fechaSalida, 'DD/MM/YYYY') < TO_DATE(fechaLlegada, 'DD/MM/YYYY'))
        OR
        -- Caso 2: Misma fecha - la hora de salida debe ser menor o igual a la de llegada
        (TO_DATE(fechaSalida, 'DD/MM/YYYY') = TO_DATE(fechaLlegada, 'DD/MM/YYYY') 
         AND TO_NUMBER(horaSalida) <= TO_NUMBER(horaLlegada))
    )
);

CREATE TABLE INCIDENCIA (
    idIncidencia NUMBER(8) PRIMARY KEY,
    idVuelo NUMBER(8) NOT NULL,
    FOREIGN KEY (idVuelo) REFERENCES VUELO(idVuelo)
);

CREATE TABLE RETRASO (
    idRetraso NUMBER(8) PRIMARY KEY,
    causa VARCHAR(32) NOT NULL,
    duracion NUMBER(8) NOT NULL,
    idIncidencia NUMBER(8) NOT NULL,
    FOREIGN KEY (idIncidencia) REFERENCES INCIDENCIA(idIncidencia),
    CONSTRAINT chk_duracion CHECK ( duracion > 0 )
);

CREATE TABLE DESVIO (
    idDesvio NUMBER(8) PRIMARY KEY,
    numeroDesvio NUMBER(2) NOT NULL,
    aeropuertoDesvio VARCHAR(4) NOT NULL,
    avionDesvio VARCHAR(8),
    idIncidencia NUMBER(8) NOT NULL,
    FOREIGN KEY (idIncidencia) REFERENCES INCIDENCIA(idIncidencia),
    FOREIGN KEY (aeropuertoDesvio) REFERENCES AEROPUERTO(IATA),
    FOREIGN KEY (avionDesvio) REFERENCES AVION(matricula)
);

CREATE TABLE CANCELACION (
    idCancelacion NUMBER(8) PRIMARY KEY,
    motivo VARCHAR(32) NOT NULL,
    idIncidencia NUMBER(8) NOT NULL,
    FOREIGN KEY (idIncidencia) REFERENCES INCIDENCIA(idIncidencia)
);


-- SECUENCIAS Y TRIGGERS

-- Secuencia para la tabla VUELO
CREATE SEQUENCE secVuelo
    START WITH 1
    INCREMENT BY 1;
-- Trigger para la secuencia en la clave artificial idVuelo de la tabla VUELO
CREATE OR REPLACE TRIGGER trg_vuelo_id
BEFORE INSERT ON VUELO
FOR EACH ROW
BEGIN
    :NEW.idVuelo := secVuelo.NEXTVAL;
END;
/

-- Secuencia para la tabla INCIDENCIA
CREATE SEQUENCE secIncidencia
    START WITH 1
    INCREMENT BY 1;
-- Trigger para la secuencia en la clave artificial idIncidencia de la tabla INCIDENCIA
CREATE OR REPLACE TRIGGER trg_incidencia_id
BEFORE INSERT ON INCIDENCIA
FOR EACH ROW
BEGIN
    :NEW.idIncidencia := secIncidencia.NEXTVAL;
END;
/

-- Secuencia para la tabla RETRASO
CREATE SEQUENCE secRetraso
    START WITH 1
    INCREMENT BY 1;
-- Trigger para la secuencia en la clave artificial idRetraso de la tabla RETRASO
CREATE OR REPLACE TRIGGER trg_retraso_id
BEFORE INSERT ON RETRASO
FOR EACH ROW
BEGIN
    :NEW.idRetraso := secRetraso.NEXTVAL;
END;
/

-- Secuencia para la tabla DESVIO
CREATE SEQUENCE secDesvio
    START WITH 1
    INCREMENT BY 1;
-- Trigger para la secuencia en la clave artificial idDesvio de la tabla DESVIO
CREATE OR REPLACE TRIGGER trg_desvio_id
BEFORE INSERT ON DESVIO
FOR EACH ROW
BEGIN
    :NEW.idDesvio := secDesvio.NEXTVAL;
END;
/

-- Secuencia para la tabla CANCELACION
CREATE SEQUENCE secCancelacion
    START WITH 1
    INCREMENT BY 1;
-- Trigger para la secuencia en la clave artificial idCancelacion de la tabla CANCELACION
CREATE OR REPLACE TRIGGER trg_cancelacion_id
BEFORE INSERT ON CANCELACION
FOR EACH ROW
BEGIN
    :NEW.idCancelacion := secCancelacion.NEXTVAL;
END;
/
