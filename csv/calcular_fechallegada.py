import csv
from datetime import datetime, timedelta

def calcular_fecha_llegada(fecha_salida, hora_salida_str, hora_llegada_str):
    """
    Calcula la fecha de llegada basada en la fecha de salida y las horas en formato HHMM.
    
    Args:
        fecha_salida: Fecha de salida en formato 'DD/MM/YYYY'
        hora_salida_str: Hora de salida como string (3-4 dígitos)
        hora_llegada_str: Hora de llegada como string (3-4 dígitos)
    
    Returns:
        Fecha de llegada en formato 'DD/MM/YYYY'
    """
    formato_fecha = "%d/%m/%Y"
    
    # Formatear las horas correctamente
    hora_salida_str = hora_salida_str.zfill(4)  # Asegurar 4 dígitos
    hora_llegada_str = hora_llegada_str.zfill(4)  # Asegurar 4 dígitos
    
    hora_salida = int(hora_salida_str[:2])
    minuto_salida = int(hora_salida_str[2:])
    hora_llegada = int(hora_llegada_str[:2])
    minuto_llegada = int(hora_llegada_str[2:])
    
    # Convertir la fecha de salida a datetime
    fecha_salida_dt = datetime.strptime(fecha_salida, formato_fecha)
    
    # Crear objetos datetime para salida y llegada
    fecha_hora_salida = fecha_salida_dt.replace(hour=hora_salida, minute=minuto_salida)
    fecha_hora_llegada = fecha_salida_dt.replace(hour=hora_llegada, minute=minuto_llegada)
    
    # Si la hora de llegada es anterior a la de salida, añadir un día
    if fecha_hora_llegada < fecha_hora_salida:
        fecha_hora_llegada += timedelta(days=1)
    
    # Formatear la fecha de llegada
    fecha_llegada = fecha_hora_llegada.strftime(formato_fecha)
    
    return fecha_llegada

# Archivo de entrada y salida
archivo_entrada = "Vuelo.csv"
archivo_salida = "vuelo_con_llegada.csv"

# Leer datos del CSV de entrada y escribir en el CSV de salida
with open(archivo_entrada, 'r', encoding='utf-8') as entrada, open(archivo_salida, 'w', newline='', encoding='utf-8') as salida:
    lector = csv.reader(entrada, delimiter=';')  # Usar punto y coma como delimitador
    escritor = csv.writer(salida, delimiter=';')  # Mantener el mismo delimitador
    
    # Leer la primera fila (encabezados) y añadir el nuevo campo
    encabezados = next(lector)
    encabezados[2] = 'fechaLlegada'  # Ya existe la columna, solo la renombramos
    escritor.writerow(encabezados)
    
    # Procesar el resto de filas
    for fila in lector:
        # Saltar filas de comentarios o vacías
        if not fila or fila[0].startswith('//'):
            continue
        
        if len(fila) >= 5:  # Verificar que hay suficientes columnas
            try:
                numero_vuelo = fila[0]
                fecha_salida = fila[1]
                hora_salida = fila[3]
                hora_llegada = fila[4]
                
                # Si hay datos válidos, calcular la fecha de llegada
                if fecha_salida and hora_salida and hora_llegada and not fecha_salida.startswith('fechaSalida'):
                    fecha_llegada = calcular_fecha_llegada(fecha_salida, hora_salida, hora_llegada)
                    fila[2] = fecha_llegada  # Asignar a la columna existente
                
                escritor.writerow(fila)
            except Exception as e:
                print(f"Error al procesar fila {fila}: {e}")
                escritor.writerow(fila)  # Mantener la fila original
        else:
            print(f"Fila con formato incorrecto: {fila}")
            escritor.writerow(fila)  # Escribir la fila tal como está

print(f"Proceso completado. Datos guardados en '{archivo_salida}'")