library(readr)
library(readxl)
library(tidyverse)

# Escribir directorio donde están guardados los archivos. Caso Ignacio
Ruta <- "/home/ignacio/Documents/Tareas USM/Proyecto modelación MAT282/Data/"

Matricula_2024 <- read_delim(paste0(Ruta, "2024/Matricula/ArchivoMatr_Adm2024.csv"), 
                             delim = ";", escape_double = FALSE, locale = locale(decimal_mark = ",", 
                                                                                 grouping_mark = "."), trim_ws = TRUE) 

ArchivoD_2024 <- read_delim(paste0(Ruta, "2024/Postulacion/PostulaciónySelección_Admisión2024 (archivo D)/ArchivoD_Adm2024.csv"), 
                            delim = ";", escape_double = FALSE, locale = locale(decimal_mark = ",", 
                                                                                grouping_mark = "."), trim_ws = TRUE)

INDICADORES_POR_CARRERA_PROMEDIO_OBLIGATORIAS_2024 <- read_delim(paste0(Ruta, "2024/Postulacion/Estadistica de seleccion/ADM2024_INDICADORES_POR_CARRERA_PROMEDIO_OBLIGATORIAS_20250120.csv"), 
                                                                 delim = ";", escape_double = FALSE, locale = locale(), 
                                                                 trim_ws = TRUE)

Libro_CódigosADM2024_ArchivoMatricula <- read_excel(paste0(Ruta, "2024/Matricula/Libro_CódigosADM2024_ArchivoMatricula.xlsx"))

# ¿Cómo mejor distinguirlos?