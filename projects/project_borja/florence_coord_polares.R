# ----- Gráficos en coordenadas polares -----

# ----- Carga y preprocesamiento -----
library(HistData)
Nightingale
glimpse(Nightingale)

# Seleccionamos solo variables de fecha y que contengan rate
datos <-
  Nightingale %>% 
  select(Date, Month, Year, contains("rate"))
datos

# Tidy data y renombramos a castellano columnas
datos <-
  datos %>%
  pivot_longer(cols = 4:6, names_to = "causa",
               values_to = "tasa") %>%
  rename(fecha = Date, mes = Month, year = Year) 
datos

# Eliminamos "rate" de las causas
# Recategorizamos a castellano
# Añadimos una nueva variable para que nos indique el periodo:
# antes de una fecha o después
datos <-
  datos %>%
  mutate(causa = gsub(".rate", "", causa),
         causa =
           case_when(causa == "Disease" ~ "infecciosas",
                     causa == "Wounds" ~ "heridas",
                     causa == "Other" ~ "otras",
                     TRUE ~ "otras"),
         periodo =
           factor(ifelse(fecha >= as.Date("1855-04-01"),
                         "APRIL 1855 TO MARCH 1856",
                         "APRIL 1854 TO MARCH 1855"),
                  levels = c("APRIL 1855 TO MARCH 1856",
                             "APRIL 1854 TO MARCH 1855")))
datos

# ----- Barras -----

# Para cada periodo por separado
# Mapeado: x --> mes, y --> tasa, fill --> causa
ggplot(datos %>%
         filter(periodo == "APRIL 1854 TO MARCH 1855"),
       aes(x = mes, y = tasa, fill = causa)) + 
  geom_col() +
  labs(fill = "Causas",
       title = "DIAGRAM OF THE CAUSES OF MORTALITY",
       subtitle = "IN THE ARMY IN THE EAST (April 1854 - March 1855)",
       caption = "Author: J. Álvarez Liébana | Data: HistData")

ggplot(datos %>%  filter(periodo == "APRIL 1855 TO MARCH 1856"),
       aes(x = mes, y = tasa, fill = causa)) + 
  geom_col() +
  labs(fill = "Causas",
       title = "DIAGRAM OF THE CAUSES OF MORTALITY",
       subtitle = "IN THE ARMY IN THE EAST (April 1855 - March 1856)",
       caption = "Author: J. Álvarez Liébana | Data: HistData")

# Componemos ambos periodos con facet
ggplot(datos, aes(x = mes, y = tasa, fill = causa)) + 
  geom_col() +
  facet_wrap( ~ periodo) +
  labs(fill = "Causas",
       title = "DIAGRAM OF THE CAUSES OF MORTALITY",
       subtitle = "IN THE ARMY IN THE EAST",
       caption = "Author: J. Álvarez Liébana | Data: HistData")

# Colores similares al gráfico de Florence
ggplot(datos, aes(x = mes, y = tasa, fill = causa)) + 
  geom_col() +
  facet_wrap( ~ periodo)  +
  scale_fill_manual(values = c("#C42536", "#5aa7d1", "#6B6B6B")) +
  labs(fill = "Causas",
       title = "DIAGRAM OF THE CAUSES OF MORTALITY",
       subtitle = "IN THE ARMY IN THE EAST",
       caption = "Author: J. Álvarez Liébana | Data: HistData")

# Nuestros datos abarcan dos periodos: de abril 1854 a marzo 1855,
# y de abril 1855 a marzo 1856. Para tener los datos ordenados
# cronológicamente, vamos a indicarle que el año irá desde abril
# a marzo, en ese orden los meses, con `fct_relevel`, del paquete
# `{forcats}` incluido en `{tidyverse}`.
datos <- 
  datos %>%
  mutate(mes =
           fct_relevel(mes, "Apr", "May", "Jun", "Jul",
                       "Aug", "Sep", "Oct", "Nov", "Dec",
                       "Jan", "Feb", "Mar"))
gg <-
  ggplot(datos, aes(x = mes, y = tasa, fill = causa)) + 
  geom_col() +
  facet_wrap( ~ periodo)  +
  scale_fill_manual(values =
                      c("#C42536", "#5aa7d1", "#6B6B6B")) +
  labs(fill = "Causas",
       title = "DIAGRAM OF THE CAUSES OF MORTALITY",
       subtitle = "IN THE ARMY IN THE EAST",
       caption = "Author: J. Álvarez Liébana | Data: HistData")
gg

# ----- Coordenadas polares -----

# El gráfico original tiene los gajos el orden de julio a junio
datos <- 
  datos %>%
  mutate(mes =
           fct_relevel(mes, "Jul", "Aug", "Sep", "Oct",
                       "Nov", "Dec", "Jan", "Feb",
                       "Mar", "Apr", "May", "Jun"))

# Dibujamos un diagrama de barras y luego... coord_polar() 
ggplot(datos, aes(x = mes, y = tasa, fill = causa)) + 
  geom_col(width = 1) +
  coord_polar() +
  scale_fill_manual(values =
                      c("#C42536", "#5aa7d1", "#6B6B6B")) +
  facet_wrap( ~ periodo) +
  labs(fill = "Causas",
       title = "DIAGRAM OF THE CAUSES OF MORTALITY",
       subtitle = "IN THE ARMY IN THE EAST",
       caption = "Author: J. Álvarez Liébana | Data: HistData")


# Para que sea mejor cambiamos la escala de y haciendo su raíz cuadrada
gg <- 
  ggplot(datos, aes(mes, tasa, fill = causa)) + 
  geom_col(width = 1) +
  coord_polar() +
  scale_fill_manual(values =
                      c("#C42536", "#5aa7d1", "#6B6B6B")) +
  scale_y_sqrt() +
  scale_x_discrete(labels =
                     c("JULY", "AUGUST", "SEPT.",
                       "OCTOBER", "NOVEMBER", "DECEMBER",
                       "JANUARY", "FEBRUARY", "MARCH",
                       "APRIL", "MAY", "JUNE")) +
  facet_wrap( ~ periodo) +
  labs(fill = "Causas",
       title = "DIAGRAM OF THE CAUSES OF MORTALITY",
       subtitle = "IN THE ARMY IN THE EAST",
       caption = "Author: J. Álvarez Liébana | Data: HistData") 

# Temas
library(sysfonts)
library(showtext)
font_add_google(family = "Roboto",
                name = "Roboto")
font_add_google(family = "Cinzel Decorative",
                name = "Cinzel Decorative")
font_add_google(family = "Quattrocento",
                name = "Quattrocento")

showtext_auto()

# ángulo de las etiquetas que se mostrarán
angulo <- seq(-20, -340, length.out = 12)
gg + theme_void() +
  theme(
    # Eje y limpio
    axis.title.y = element_blank(),
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank(),
    # Eje x (el radial)
    axis.text.x =
      element_text(face = "bold", size = 9, angle = angulo,
                   family = "Roboto"),
    panel.grid.major.x = element_line(size = 0.01, color = "black"),
    legend.position = "bottom",
    plot.background = element_rect(fill = alpha("cornsilk", 0.5)),
    plot.title =
      element_text(hjust = 0.5, size = 21,
                   family = "Cinzel Decorative"),
    plot.subtitle =
      element_text(hjust = 0.5, size = 15,
                   family = "Cinzel Decorative"),
    plot.caption =
      element_text(size = 9, family = "Quattrocento"),
    strip.text =
      element_text(hjust = 0.5, size = 7,
                   family = "Quattrocento"),
    plot.margin = margin(t = 5, r = 7, b = 5, l = 7, "pt"))

