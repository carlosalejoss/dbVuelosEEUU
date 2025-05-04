#!/bin/bash
# Script para poblar las tablas de la base de datos.
# Para ejecutar este script, asegurarse de tener los archivos de control y los datos necesarios en el mismo directorio.
# Habría que cambiar <NIP> por el número de identificación personal del usuario 
# y <contraseña> por la contraseña correspondiente de Oracle.
# Hay que ejecutarlo en lab000 y dar permiso de ejecución al script.
# Para dar permiso de ejecución al script, usar el siguiente comando:
# chmod +x poblarTablas.sh
# Para ejecutar el script, usar el siguiente comando:
# ./poblarTablas.sh

sqlldr a<NIP>@barret.danae04.unizar.es control=datosAeropuerto.ctl <<EOF
<contraseña>
EOF
sqlldr a<NIP>@barret.danae04.unizar.es control=datosCompagnia.ctl <<EOF
<contraseña>
EOF
sqlldr a<NIP>@barret.danae04.unizar.es control=datosModelo.ctl <<EOF
<contraseña>
EOF
sqlldr a<NIP>@barret.danae04.unizar.es control=datosAvion.ctl <<EOF
<contraseña>
EOF
sqlldr a<NIP>@barret.danae04.unizar.es control=datosVuelo.ctl <<EOF
<contraseña>
EOF
sqlldr a<NIP>@barret.danae04.unizar.es control=datosIncidencia.ctl <<EOF
<contraseña>
EOF
sqlldr a<NIP>@barret.danae04.unizar.es control=datosRetraso.ctl <<EOF
<contraseña>
EOF
sqlldr a<NIP>@barret.danae04.unizar.es control=datosDesvio.ctl <<EOF
<contraseña>
EOF
sqlldr a<NIP>@barret.danae04.unizar.es control=datosCancelacion.ctl <<EOF
<contraseña>
EOF