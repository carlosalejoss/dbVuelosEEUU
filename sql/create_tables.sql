CREATE TABLE AEROPUERTO (
    codigoIATA VARCHAR(3) PRIMARY KEY,
    nombre VARCHAR(50),
    ciudad VARCHAR(50),
    estado VARCHAR(50)
);

CREATE TABLE COMPAGNIA (
    codigo VARCHAR(7) PRIMARY KEY,
    nombre VARCHAR(50),
);

CREATE TABLE AVION (
    matricula VARCHAR(6) PRIMARY KEY,
    agnoFabricacion NUMBER(4),
    modelo VARCHAR(255),
    fabricante VARCHAR(255),
    motor VARCHAR(255)
);

CREATE TABLE VUELO (
    idVuelo NUMBER(10) PRIMARY KEY,
    numeroVuelo VARCHAR(10),
    fecha VARCHAR(10),
    horaSalida VARCHAR(4),
    horaLlegada VARCHAR(4),
    aeropuertoSalida VARCHAR(3),
    aeropuertoLlegada VARCHAR(3),
    compagnia VARCHAR(7),
    avion VARCHAR(6),
    FOREIGN KEY (aeropuertoSalida) REFERENCES AEROPUERTO(codigoIATA),
    FOREIGN KEY (aeropuertoLlegada) REFERENCES AEROPUERTO(codigoIATA),
    FOREIGN KEY (compagnia) REFERENCES COMPAGNIA(codigo),
    FOREIGN KEY (avion) REFERENCES AVION(matricula)
);

CREATE TABLE INCIDENCIA (
    idIncidencia NUMBER(10) PRIMARY KEY,
    idVuelo NUMBER(10) NOT NULL,
    FOREIGN KEY (idVuelo) REFERENCES VUELO(idVuelo)
);

CREATE TABLE RETRASO (
    idRetraso NUMBER(10) PRIMARY KEY,
    causa VARCHAR(255),
    duracion NUMBER(10),
    idIncidencia NUMBER(10) NOT NULL,
    FOREIGN KEY (idIncidencia) REFERENCES INCIDENCIA(idIncidencia)
);

CREATE TABLE DESVIO (
    idDesvio NUMBER(10) PRIMARY KEY,
    numeroDesvio NUMBER(2) NOT NULL,
    aeropuertoDesvio VARCHAR(3) NOT NULL,
    idIncidencia NUMBER(10) NOT NULL,
    FOREIGN KEY (idIncidencia) REFERENCES INCIDENCIA(idIncidencia),
    FOREIGN KEY (aeropuertoDesvio) REFERENCES AEROPUERTO(codigoIATA)
);

CREATE TABLE CANCELACION (
    idCancelacion NUMBER(10) PRIMARY KEY,
    motivo VARCHAR(255),
    idIncidencia NUMBER(10) NOT NULL,
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
