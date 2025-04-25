#!/bin/bash
# Script para poblar las tablas de la base de datos
sqlldr a872342@barret.danae04.unizar.es control=datosAeropuerto.ctl <<EOF
underc35
EOF
sqlldr a872342@barret.danae04.unizar.es control=datosCompagnia.ctl <<EOF
underc35
EOF
sqlldr a872342@barret.danae04.unizar.es control=datosModelo.ctl <<EOF
underc35
EOF
sqlldr a872342@barret.danae04.unizar.es control=datosAvion.ctl <<EOF
underc35
EOF
sqlldr a872342@barret.danae04.unizar.es control=datosVuelo.ctl <<EOF
underc35
EOF
sqlldr a872342@barret.danae04.unizar.es control=datosIncidencia.ctl <<EOF
underc35
EOF
sqlldr a872342@barret.danae04.unizar.es control=datosRetraso.ctl <<EOF
underc35
EOF
sqlldr a872342@barret.danae04.unizar.es control=datosDesvio.ctl <<EOF
underc35
EOF
sqlldr a872342@barret.danae04.unizar.es control=datosCancelacion.ctl <<EOF
underc35
EOF