#!/bin/bash
# Script para poblar las tablas de la base de datos
sqlldr a870421@barret.danae04.unizar.es control=datosAeropuerto.ctl <<EOF
monteagudo9
EOF
sqlldr a870421@barret.danae04.unizar.es control=datosCompagnia.ctl <<EOF
monteagudo9
EOF
sqlldr a870421@barret.danae04.unizar.es control=datosModelo.ctl <<EOF
monteagudo9
EOF
sqlldr a870421@barret.danae04.unizar.es control=datosAvion.ctl <<EOF
monteagudo9
EOF
sqlldr a870421@barret.danae04.unizar.es control=datosVuelo.ctl <<EOF
monteagudo9
EOF
sqlldr a870421@barret.danae04.unizar.es control=datosIncidencia.ctl <<EOF
monteagudo9
EOF
sqlldr a870421@barret.danae04.unizar.es control=datosRetraso.ctl <<EOF
monteagudo9
EOF
sqlldr a870421@barret.danae04.unizar.es control=datosDesvio.ctl <<EOF
monteagudo9
EOF
sqlldr a870421@barret.danae04.unizar.es control=datosCancelacion.ctl <<EOF
monteagudo9
EOF