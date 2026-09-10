library(readr)
library(readxl)
library(tidyverse)

# Escribir directorio donde están guardados los archivos. Caso Ignacio
Ruta <- "/home/ignacio/Documents/Tareas USM/Proyecto modelación MAT282/datos/datos 2024/"

Matricula_2024 <- read_delim(paste0(Ruta, "Matricula/ArchivoMatr_Adm2024.csv"), 
                             delim = ";", escape_double = FALSE, locale = locale(decimal_mark = ",", 
                                                                                 grouping_mark = "."), trim_ws = TRUE) 

ArchivoD_2024 <- read_delim(paste0(Ruta, "Postulacion/PostulaciónySelección_Admisión2024 (archivo D)/ArchivoD_Adm2024.csv"), 
                            delim = ";", escape_double = FALSE, locale = locale(decimal_mark = ",", 
                                                                                grouping_mark = "."), trim_ws = TRUE)

INDICADORES_POR_CARRERA_PROMEDIO_OBLIGATORIAS_2024 <- read_delim(paste0(Ruta, "Postulacion/Estadistica de seleccion/ADM2024_INDICADORES_POR_CARRERA_PROMEDIO_OBLIGATORIAS_20250120.csv"), 
                                                                 delim = ";", escape_double = FALSE, locale = locale(), 
                                                                 trim_ws = TRUE)

Libro_CódigosADM2024_ArchivoMatricula <- read_excel(paste0(Ruta, "Matricula/Libro_CódigosADM2024_ArchivoMatricula.xlsx"))

# ¿Cómo mejor distinguirlos?
OfertaAcadémica_2024 <- read_excel(paste0(Ruta, "Postulacion/OfertaAcadémica_Admisión2024.xlsx"))

OfertaAcademica2_2024 <- read_excel(paste0(Ruta, "Postulacion/PostulaciónySelección_Admisión2024 (archivo D)/Libro_CódigosADM2024_ArchivoD.xlsx"), 
                                    sheet = "Anexo -  Oferta académica")

Libro_CódigosADM2024_ArchivoD <- read_excel(paste0(Ruta, "Postulacion/PostulaciónySelección_Admisión2024 (archivo D)/Libro_CódigosADM2024_ArchivoD.xlsx"))

Libro_CódigosADM2024_IndicadoresCarreraPromedioObligatorias <- read_excel(paste0(Ruta, "2024/Postulacion/Estadistica de seleccion/Libro_CódigosADM2024_IndicadoresCarreraPromedioObligatorias.xlsx"), 
                                                                          sheet = "IndicadoresPromedioObligatorias")

ponderacion <- function(n) {
  poder <- 0
  for (i in n) {
    # Exponencial inversa
    poder <- poder + exp(-i + 1)
  }
  return (poder)
}


# Lee la oferta académica, filtra por fila, y hace una tabla
# Oferta académica
oferta = INDICADORES_POR_CARRERA_PROMEDIO_OBLIGATORIAS_2024 %>%
  dplyr::select(CODIGO_CARRERA,NOMBRE_CARRERA)
postulaciones = ArchivoD_2024 %>%
  dplyr::filter(TIPO_PREF == "REGULAR" & ORDEN_PREF <= 3) %>%
  dplyr::left_join(oferta, by = c("COD_CARRERA_PREF" = "CODIGO_CARRERA")) %>%
  dplyr::group_by(NOMBRE_CARRERA) %>%
  dplyr::summarise(Cantidad = ponderacion(ORDEN_PREF)) %>%
  dplyr:: arrange(desc(Cantidad)) %>%
  head(100)
postulaciones %>%
  knitr::kable(format.args = list(big.mark = ","))