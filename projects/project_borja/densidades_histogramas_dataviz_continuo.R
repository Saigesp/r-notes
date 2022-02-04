# ----- Visualizar datos continuos: densidades, histogramas, etc -----

# ----- Carga y preprocesamiento -----

# Datos: percepción de la probabilidad
# Se preguntó a una serie de personas que probabilidad asignaría
# a experiones como «casi seguro», «probablemente», etc
datos <-
  read_csv("https://raw.githubusercontent.com/zonination/perceptions/master/probly.csv")
datos


# Convirtiendo a tidy data
datos_pivot <-
  datos %>%
  pivot_longer(cols = everything(),
               names_to = "termino", values_to = "prob")
datos_pivot

# Filtramos solo algunos términos
datos_final <-
  datos_pivot %>%
  filter(termino %in% c("Almost No Chance", "Chances Are Slight",
                        "Improbable", "About Even",
                        "Probable", "Almost Certainly"))
datos_final

# Reordenamos los términos convirtiendo a factor
datos_final <-
  datos_final %>%
  mutate(termino = fct_reorder(termino, prob))
datos_final

# Media de las probabilidades de cada término
datos_resumen <-
  datos_final %>%
  group_by(termino) %>%
  summarise(media = mean(prob))
datos_resumen

# ----- Diagrama de barras de las medias de las probabilidades -----

# Barras: geom_col
# Mapeado: x --> termino, y --> media, fill --> termino
ggplot(datos_resumen,
       aes(x = termino, y = media, fill = termino)) +
  geom_col()

# Tema
library(showtext)
font_add_google(family = "Roboto",
                name = "Roboto")
showtext_auto()
theme_set(theme_minimal(base_family = "Roboto"))
theme_update(
  # Color de fondo
  plot.background = 
    element_rect(fill = "white", color = "white"),
  # Título
  plot.title = element_text(color = "black",
                            face = "bold", size = 27))
  
# Barras: geom_col
# Mapeado: x --> termino, y --> media, fill --> termino
# Alpha: 0.8
# Escala de colores: paleta de rojo a azul para probs 
ggplot(datos_resumen,
       aes(x = termino, y = media, fill = termino)) +
  geom_col(alpha = 0.8) +
  scale_fill_brewer(palette = "RdBu") +
  labs(fill = "Términos",
       y = "Probabilidad (%)",
       title = "Percepción de la probabilidad")
 
# ----- Visualizando puntos: geom_quasirandom -----

# SIN RESUMIR LOS DATOS
# Puntos repartidos: geom_quasirandom (para que no salgan todos verticales)
# Mapeado: x --> termino, y --> prob, color --> termino
# Alpha: 0.7
# Dentro de geom_quasirandom --> width anchura de como se dispersan
library(ggbeeswarm)
ggplot(datos_final,
      aes(x = termino, y = prob,
          color = termino)) +
 geom_quasirandom(size = 3.5, width = 0.5, alpha = 0.7)

# Añadimos escala de colores de rojo a azul
ggplot(datos_final,
      aes(x = termino, y = prob,
          color = termino)) +
  geom_quasirandom(size = 3.5, width = 0.5,
                  alpha = 0.7) +
  scale_color_brewer(palette = "RdBu") #<<

# Añadimos títulos, ejes, etc
ggplot(datos_final,
      aes(x = termino, y = prob, color = termino)) +
  geom_quasirandom(size = 3.5, width = 0.5, alpha = 0.7) +
  scale_color_brewer(palette = "RdBu") +
  labs(color = "Términos", x = "Términos",
       y = "Probabilidad (%)",
       title = "Percepción de la probabilidad")


# ----- Gráficos de cajas y bigotes -----

# con geom_boxplot
ggplot(datos_final,
       aes(x = termino, y = prob, fill = termino)) +
  geom_boxplot(alpha = 0.8) +
  scale_fill_brewer(palette = "RdBu") +
  labs(fill = "Términos", y = "Probabilidad (%)",
       title = "Percepción de la probabilidad")


  
# COn geom_jitter añadimos además los puntos reales desperdigados
ggplot(datos_final,
       aes(x = termino, y = prob, color = termino, fill = termino)) +
  geom_boxplot(alpha = 0.8) +
  geom_jitter(alpha = 0.25, size = 1.5) +
  scale_fill_brewer(palette = "RdBu") +
  scale_color_brewer(palette = "RdBu") +
  guides(color = "none", fill = "none")
  labs(fill = "Términos",
       y = "Probabilidad (%)",
       title = "Percepción de la probabilidad")
  
  
# Con `coord_flip()` podemos invertir los ejes
ggplot(datos_final,
       aes(x = termino, y = prob,
           color = termino, fill = termino)) +
  geom_boxplot(alpha = 0.8) +
  geom_jitter(alpha = 0.25, size = 1.5) +
  coord_flip() +
  scale_fill_brewer(palette = "RdBu") +
  scale_color_brewer(palette = "RdBu") +
  guides(color = "none", fill = "none") +
  labs(fill = "Términos", y = "Probabilidad (%)",
       title = "Percepción de la probabilidad")

# ----- Histograma, densidad y violín -----


# Histogramas con geom_histogram:
# SOLO UNA VARIABLE
datos_pivot
ggplot(datos_pivot %>% filter(termino == "Probable"),
       aes(x = prob)) +
  geom_histogram(alpha = 0.4) + #<<
  labs(fill = "Términos",
       y = "Probabilidad (%)",
       title = "Percepción de probabilidad")
  
# Componemos con facet
ggplot(datos_pivo,
       aes(x = prob, color = termino,
           fill = termino)) +
  geom_histogram(alpha = 0.4) +
  facet_wrap(~ termino, scale = "free_y") +
  labs(fill = "Términos", y = "Probabilidad (%)",
       title = "Percepción de probabilidad")

# Con escalas de colores      
ggplot(datos_pivot,
       aes(x = prob, color = termino,
           fill = termino)) +
  geom_histogram(alpha = 0.4) +
  scale_fill_viridis_d() + #<<
  scale_color_viridis_d() + #<<
  facet_wrap(~ termino, scale = "free_y") +
  guides(color = "none", fill = "none") + #<<
  labs(fill = "Términos", y = "Probabilidad (%)",
       title = "Percepción de probabilidad")
           
# Reordenamos niveles de factor para ir de menos a mas
datos_pivot <-
  datos_pivot %>%
  mutate(termino = fct_reorder(termino, prob)) #<<
           
ggplot(datos_pivot,
       aes(x = prob, color = termino, fill = termino)) +
  geom_histogram(alpha = 0.4) +
  scale_fill_viridis_d() +  scale_color_viridis_d() + 
  facet_wrap(~ termino, scale = "free_y") +
  guides(color = "none", fill = "none") +
  labs(fill = "Términos",
       y = "Probabilidad (%)",
       title = "Percepción de probabilidad")
          
# el parámetro bins nos marca el número de barras del histograma
ggplot(datos_pivot,
      aes(x = prob, color = termino,
          fill = termino)) +
 geom_histogram(alpha = 0.4,
                bins = 10) + #<<
 scale_fill_viridis_d() + 
 scale_color_viridis_d() + 
 facet_wrap(~ termino,
            scale = "free_y") +
 guides(color = "none",
        fill = "none") + 
 labs(fill = "Términos",
      y = "Probabilidad (%)",
      title = "Percepción de probabilidad")
           
# ----- densidad -----

# Basta cambiar `geom_histogram()` por `geom_density()`
ggplot(datos_final,
       aes(x = prob, color = termino,
           fill = termino)) +
  geom_density(alpha = 0.4) + #<<
  scale_fill_brewer(palette = "RdBu") +
  scale_color_brewer(palette = "RdBu") +
  guides(color = "none") +
  labs(fill = "Términos",
       y = "Probabilidad (%)",
       title = "Percepción de probabilidad")
 

# Con ggridge podemos superponer densidades
library(ggridges)
ggplot(datos_pivot %>%
         # Reordenamos niveles de factor de menor a mayor
         mutate(termino = fct_reorder(termino, prob)),
       aes(y = termino, x = prob, fill = termino)) +
  geom_density_ridges(alpha = 0.4) + #<<
  scale_fill_viridis_d() + scale_color_viridis_d() +
  guides(color = "none", fill = "none")  +
  labs(fill = "Términos", y = "Probabilidad (%)",
       title = "Percepción de la probabilidad")
  