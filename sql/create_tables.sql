CREATE TABLE AEROPUERTO (
    IATA VARCHAR(4) PRIMARY KEY,
    nombre VARCHAR(64),
    ciudad VARCHAR(64),
    estado VARCHAR(8)
);

CREATE TABLE COMPAGNIA (
    codigo VARCHAR(8) PRIMARY KEY,
    nombre VARCHAR(128)
);

CREATE TABLE MODELO (
    nombre VARCHAR(32) PRIMARY KEY,
    fabricante VARCHAR(32),
    motor VARCHAR(32)
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
    fecha VARCHAR(10),
    horaSalida VARCHAR(4),
    horaLlegada VARCHAR(4),
    aeropuertoSalida VARCHAR(4),
    aeropuertoLlegada VARCHAR(4),
    compagnia VARCHAR(8),
    avion VARCHAR(8),
    FOREIGN KEY (aeropuertoSalida) REFERENCES AEROPUERTO(IATA),
    FOREIGN KEY (aeropuertoLlegada) REFERENCES AEROPUERTO(IATA),
    FOREIGN KEY (compagnia) REFERENCES COMPAGNIA(codigo),
    FOREIGN KEY (avion) REFERENCES AVION(matricula),
    CONSTRAINT chk_airports_not_equal CHECK ( aeropuertoSalida <> aeropuertoLlegada ),
    CONSTRAINT chk_flight_time CHECK ( horaSalida < horaLlegada ),
    CONSTRAINT chk_time_valid CHECK ( horaSalida BETWEEN '0000' AND '2359' AND horaLlegada BETWEEN '0000' AND '2359' )
);

CREATE TABLE INCIDENCIA (
    idIncidencia NUMBER(8) PRIMARY KEY,
    idVuelo NUMBER(8) NOT NULL,
    FOREIGN KEY (idVuelo) REFERENCES VUELO(idVuelo)
);

CREATE TABLE RETRASO (
    idRetraso NUMBER(8) PRIMARY KEY,
    causa VARCHAR(32),
    duracion NUMBER(8),
    idIncidencia NUMBER(8) NOT NULL,
    FOREIGN KEY (idIncidencia) REFERENCES INCIDENCIA(idIncidencia),
    CONSTRAINT chk_duration CHECK ( duracion > 0 )
);

CREATE TABLE DESVIO (
    idDesvio NUMBER(8) PRIMARY KEY,
    numeroDesvio NUMBER(2) NOT NULL,
    aeropuertoDesvio VARCHAR(4) NOT NULL,
    idIncidencia NUMBER(8) NOT NULL,
    FOREIGN KEY (idIncidencia) REFERENCES INCIDENCIA(idIncidencia),
    FOREIGN KEY (aeropuertoDesvio) REFERENCES AEROPUERTO(IATA)
);

CREATE TABLE CANCELACION (
    idCancelacion NUMBER(8) PRIMARY KEY,
    motivo VARCHAR(32),
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
