import csv
import argparse

# Configurar argumentos de línea de comandos
parser = argparse.ArgumentParser(description="Procesar incidencias de vuelos dividiendo retrasos en filas separadas.")
parser.add_argument("input_file", help="Nombre del archivo CSV de entrada.")
args = parser.parse_args()

# Archivo de salida
output_file = "Incidencia.csv"

# Columnas de retrasos
delay_columns = ["carrierDelay", "weatherDelay", "nasDelay", "securityDelay", "lateAircraftDelay"]

# Procesar el archivo
with open(args.input_file, mode="r", newline="", encoding="utf-8") as infile, \
     open(output_file, mode="w", newline="", encoding="utf-8") as outfile:
    
    reader = csv.DictReader(infile, delimiter=";")
    fieldnames = reader.fieldnames
    writer = csv.DictWriter(outfile, fieldnames=fieldnames, delimiter=";")
    
    # Escribir encabezados en el archivo de salida
    writer.writeheader()
    
    for row in reader:
        # Verificar si hay algún retraso mayor a 0
        has_delay = any(int(row[delay]) > 0 for delay in delay_columns if row[delay].isdigit())
        
        if has_delay:
            # Dividir la fila en múltiples filas para cada retraso
            for delay in delay_columns:
                if row[delay].isdigit() and int(row[delay]) > 0:
                    new_row = row.copy()
                    # Poner a 0 los retrasos en otras columnas
                    for other_delay in delay_columns:
                        new_row[other_delay] = "0" if other_delay != delay else row[delay]
                    writer.writerow(new_row)
        else:
            # Si no hay retrasos, copiar la fila tal cual
            writer.writerow(row)