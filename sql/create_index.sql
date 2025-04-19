CREATE INDEX idx_vuelo_avion ON VUELO(avion);
CREATE INDEX idx_avion_agno ON AVION(agnoFabricacion);
CREATE INDEX idx_vuelo_aero_salida ON VUELO(aeropuertoSalida);
CREATE INDEX idx_vuelo_aero_llegada ON VUELO(aeropuertoLlegada);