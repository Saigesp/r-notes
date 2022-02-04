# packages
library(lubridate)
library(tidyverse)
library(terra)
library(rnaturalearth) 
library(fs) # nuevo paquete
library(sf)


## ----------------------------------------------------------------------------
comprimidos <- dir_ls('data', regexp = "tar") 

walk(comprimidos, untar, exdir = './data/archivos')


## ----------------------------------------------------------------------------
files <- dir_ls('./data/archivos')
head(files)

r <- rast(files)
r


## ----------------------------------------------------------------------------
# media de todos los meses
r_media_mens <- app(r, mean)

# límites 
pi <- ne_countries(scale = 10, 
                   country = c("Spain", "Portugal"),
                   returnclass = "sf") %>% 
       st_crop(xmin = -10, xmax = 5, ymin = 35, ymax = 44)

# recortar y enmascarar
r_media_mens <- crop(r_media_mens, pi) %>% mask(vect(pi))

# mapa
plot(r_media_mens)
plot(pi, add = TRUE, col = NA)


## ----------------------------------------------------------------------------
# media de todos los años
dates <- seq(ymd("1983-01-01"), ymd("2020-12-01"), "month")
years <- year(dates)

# suma anual
r_year <- tapp(r, index = years, fun = sum)
r_year

# promedio anual
r_media_year <- app(r_year, mean)


## ----------------------------------------------------------------------------
# anomalías anuales
r_anom_year <- r_year*100/r_media_year

# mapa
plot(r_anom_year)


## ----------------------------------------------------------------------------
# puntos de interés
puntos <- data.frame(ciudad = c('SAN', 'ZGZ', 'SEV', 'OPO', 'MAR', 'MAL'),
                     lon = c(-8.5,-0.9,-6,-8.3,-8,2.6), 
                     lat = c(42.8, 41.6,37.4,41.2,31.6,39.6))

# extracción
media_anual <- terra::extract(r_media_year, puntos[,2:3])
head(media_anual)

# añadir la extracción a la tabla
puntos <- mutate(puntos, media_anual[, 2]) %>% 
           rename(horas_sol = 4)

puntos



## ----------------------------------------------------------------------------
# paquetes adicionales
library(ggtext)
library(classInt)


## ----------------------------------------------------------------------------
# recortamos y enmascaramos
r_anom_year <- crop(r_anom_year, pi) %>% mask(vect(pi))

# raster a data.frame
anom_mat <- as.data.frame(r_anom_year, xy = TRUE)

# renombramos las columnas
names(anom_mat)[3:40] <- str_c("yr", 1983:2020)

# structura final
#str(anom_mat)


## ----------------------------------------------------------------------------
# formato largo de tabla
anom_mat <- pivot_longer(anom_mat, 
                         3:40, 
                         names_to = "yr", 
                         values_to = "anom") %>% 
               mutate(yr = str_remove(yr, "yr") 
                                %>% as.numeric()
                      )

# resumen 
summary(anom_mat)



## ----------------------------------------------------------------------------
# vector de las anomalias
anom_val <- anom_mat$anom/100
# posibles clases
classInt::classIntervals(anom_val[anom_val > 1.03], 4)

# clases en ratio (NO %)
cutp <- c(0.70, 0.90, 0.93, 0.95, 0.97,
          1.03, 
          1.05, 1.08, 1.10, 1.15, 1.20, 1.30)

# nuestros colores 
col_reds <- colorRampPalette(c('#67001f','#b2182b','#d6604d','#f4a582','#fddbc7'))
col_rb <- c(col_reds(6) ,'#f7f7f7','#d1e5f0','#92c5de','#4393c3','#2166ac') # con azules

# clasificamos las anomalías
anom_mat <- mutate(anom_mat, anom_cut = cut(anom/100, cutp)) # ratio!!


## ----------------------------------------------------------------------------
# primera parte 
g <- ggplot() +
        geom_raster(data = anom_mat, 
                aes(x, y, 
                fill = anom_cut)) +
        geom_sf(data = pi, 
                fill = "transparent", 
               colour = "grey70", 
                size = 0.05) +
      facet_wrap(yr ~ ., 
                 ncol = 7, 
                 strip.position = "bottom") +
      coord_sf(xlim = c(-10, 5), ylim = c(35.96, 44)) 


# segunda parte
g <- g + scale_fill_manual(values = rev(col_rb),
                   labels = scales::percent_format(accuracy = 1)) +
         guides(fill = guide_colorsteps(barwidth = 20, barheight = .4))

# tercera parte
g <- g + labs(x = "", 
              y = "", 
              fill = "",
              title = "¿Qué años fueron
              <span style='color:#b2182b;'><strong>más</strong></span> o
              <span style='color:#2166ac;'><strong>menos</strong></span>
              soleados en la Península Ibérica?",
              subtitle = "Anomalía de horas anuales de sol 1983-2020.
              Período normal de referencia 1983-2010.",
              caption = "Datos: EUMETSAT/CMSAF")

# definiciones finales
g <- g + theme_minimal() +
         theme(legend.position = "top",
               panel.grid = element_blank(),
               panel.spacing = unit(1, "lines"),
               axis.text = element_blank(),
               legend.justification = "left",
               plot.caption = element_text(size = 12, 
                                          margin = margin(b = 5, t = 10, unit = "pt")),
               
               plot.title = element_textbox(size = 18, 
                                          margin = margin(b = 1, t = 2, unit = "pt")),
               
               plot.subtitle = element_textbox(size = 12, 
                                          margin = margin(b = 7, t = 2, unit = "pt")),
               
               strip.text = element_text(margin = margin(t = 0.3, unit = "line"), 
                                         size = 12, hjust = 0.3, face = "bold"))


## ----------------------------------------------------------------------------
ggsave("horas_sol_anomalias.png", 
       g, 
       width = 15, 
       height = 12, 
       units = "in",
       bg = "white")
