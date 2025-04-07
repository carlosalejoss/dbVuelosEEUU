CREATE TABLE AEROPUERTO (
    idAeropuerto NUMBER(10) PRIMARY KEY,
    codigoIATA VARCHAR(3) NOT NULL,
    nombre VARCHAR(50),
    ciudad VARCHAR(50),
    estado VARCHAR(50)
);

CREATE TABLE COMPAGNIA (
    idCompagnia NUMBER(10) PRIMARY KEY,
    --codigo VARCHAR(3),
    --nombre VARCHAR(50),
);

--CREATE TABLE alberga (
--    idAeropuerto NUMBER(10) NOT NULL,
--    idCompagnia NUMBER(10) NOT NULL,
--    PRIMARY KEY (idAeropuerto, idCompagnia),
--    FOREIGN KEY (idAeropuerto) REFERENCES AEROPUERTO(idAeropuerto),
--    FOREIGN KEY (idCompagnia) REFERENCES COMPAGNIA(idCompagnia)
--);

CREATE TABLE AVION (
    idAvion NUMBER(10) PRIMARY KEY,
    matricula VARCHAR(20) NOT NULL,
    agnoFabricacion NUMBER(4),
    modelo VARCHAR(255),
    fabricante VARCHAR(255),
    motor VARCHAR(255)
);

CREATE TABLE VUELO (
    idVuelo NUMBER(10) PRIMARY KEY,
    numeroVuelo VARCHAR(10) NOT NULL,
    fechaSalida VARCHAR(10) NOT NULL,
    horaSalida NUMBER(10) NOT NULL,
    fechaLlegada VARCHAR(10) NOT NULL,
    horaLlegada NUMBER(10) NOT NULL,
    aeropuertoSalida NUMBER(10) NOT NULL,
    aeropuertoLlegada NUMBER(10) NOT NULL,
    compagnia NUMBER(10) NOT NULL,
    avion NUMBER(10) NOT NULL,
    FOREIGN KEY (aeropuertoSalida) REFERENCES AEROPUERTO(idAeropuerto),
    FOREIGN KEY (aeropuertoLlegada) REFERENCES AEROPUERTO(idAeropuerto),
    FOREIGN KEY (compagnia) REFERENCES COMPAGNIA(idCompagnia),
    FOREIGN KEY (avion) REFERENCES AVION(idAvion)
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
    aeropuertoDesvio NUMBER(10) NOT NULL,
    -- numeroDesvio NUMBER(2) NOT NULL,
    idIncidencia NUMBER(10) NOT NULL,
    FOREIGN KEY (idIncidencia) REFERENCES INCIDENCIA(idIncidencia),
    FOREIGN KEY (aeropuertoDesvio) REFERENCES AEROPUERTO(idAeropuerto)
);

CREATE TABLE CANCELACION (
    idCancelacion NUMBER(10) PRIMARY KEY,
    idIncidencia NUMBER(10) NOT NULL,
    FOREIGN KEY (idIncidencia) REFERENCES INCIDENCIA(idIncidencia)
);

-- SECUENCIAS Y TRIGGERS

-- Secuencia para la tabla AEROPUERTO
CREATE SEQUENCE secAeropuerto
    START WITH 1
    INCREMENT BY 1;
-- Trigger para la secuencia en la clave artificial idAeropuerto de la tabla AEROPUERTO
CREATE OR REPLACE TRIGGER trg_aeropuerto_id
BEFORE INSERT ON AEROPUERTO
FOR EACH ROW
BEGIN
    :NEW.idAeropuerto := secAeropuerto.NEXTVAL;
END;
/

-- Secuencia para la tabla COMPAGNIA
CREATE SEQUENCE secCompagnia
    START WITH 1
    INCREMENT BY 1;
-- Trigger para la secuencia en la clave artificial idCompagnia de la tabla COMPAGNIA
CREATE OR REPLACE TRIGGER trg_compagnia_id
BEFORE INSERT ON COMPAGNIA
FOR EACH ROW
BEGIN
    :NEW.idCompagnia := secCompagnia.NEXTVAL;
END;
/

-- Secuencia para la tabla AVION
CREATE SEQUENCE secAvion
    START WITH 1
    INCREMENT BY 1;
-- Trigger para la secuencia en la clave artificial idAvion de la tabla AVION
CREATE OR REPLACE TRIGGER trg_avion_id
BEFORE INSERT ON AVION
FOR EACH ROW
BEGIN
    :NEW.idAvion := secAvion.NEXTVAL;
END;
/

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
