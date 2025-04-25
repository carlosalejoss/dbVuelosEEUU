#!/bin/bash
# Script para poblar las tablas de la base de datos
sqlldr a872342@barret.danae04.unizar.es control=datosAeropuerto.ctl <<EOF
clomp183
EOF
sqlldr a872342@barret.danae04.unizar.es control=datosCompagnia.ctl <<EOF
clomp183
EOF
sqlldr a872342@barret.danae04.unizar.es control=datosModelo.ctl <<EOF
clomp183
EOF
sqlldr a872342@barret.danae04.unizar.es control=datosAvion.ctl <<EOF
clomp183
EOF
sqlldr a872342@barret.danae04.unizar.es control=datosVuelo.ctl <<EOF
clomp183
EOF
sqlldr a872342@barret.danae04.unizar.es control=datosIncidencia.ctl <<EOF
clomp183
EOF
sqlldr a872342@barret.danae04.unizar.es control=datosRetraso.ctl <<EOF
clomp183
EOF
sqlldr a872342@barret.danae04.unizar.es control=datosDesvio.ctl <<EOF
clomp183
EOF
sqlldr a872342@barret.danae04.unizar.es control=datosCancelacion.ctl <<EOF
clomp183
EOF