# packages
library(sf)
library(tidyverse)
library(units)

## ---------------------------------------------------------------------------------
datos <- data.frame(lon = c(-3.703889, -8.533333, -5.9925, 2.166667, -3.8,
                             -1.644167, -0.9),
                   lat = c(40.4125, 42.883333, 37.3925, 41.4, 43.466667,
                             42.818333, 41.65),
                   nombre = c("Madrid", "Santiago", "Sevilla", "Barcelona",
                                "Santander", "Pamplona", "Zaragoza"))


## ---------------------------------------------------------------------------------
points_sf <- st_as_sf(datos, 
                      coords = c("lon", "lat"), 
                      crs = 4326)

class(points_sf) #clase del objeto
st_geometry(points_sf) #tipo de geometría 


## ---------------------------------------------------------------------------------
paises <- st_read("./data/world_countries.shp")
ciudades <- st_read("./data/World_Cities.shp")

paises[,1:3]
ciudades[,1:3]


## ---------------------------------------------------------------------------------
plot(ciudades)

plot(ciudades["POP_RANK"])


## ---------------------------------------------------------------------------------
#extraer coordinadas
st_coordinates(ciudades) %>% head()

#extraer CRS
st_crs(ciudades)

#proyectar
paises_rob <- st_transform(paises, "ESRI:54030") # Robinson EPSG
plot(paises_rob["gdp_md_est"])


## ---------------------------------------------------------------------------------
paises2 <- mutate(paises, 
                    area = st_area(paises) %>% set_units(km2),
                    pop_est = parse_number(pop_est),
                    densidad = pop_est/area)

dplyr::select(paises2, name, area:densidad)

dplyr::select(paises2, name, area:densidad) %>% slice(5)

plot(paises2["area"])



## ---------------------------------------------------------------------------------

#filtrar
paises_subset <- filter(paises2, area < set_units(1000, km2))

plot(paises_subset["area"])


#ordenar
dplyr::select(paises2, densidad, name) %>% arrange(desc(densidad))
dplyr::select(paises_subset, area, name) %>% arrange(desc(area))



## ---------------------------------------------------------------------------------
# s2 es geometría esférica
sf_use_s2(FALSE) 

#paises2 <- st_transform(paises2, "ESRI:54030")

#disolver según continentes
paises_group <- group_by(paises2, continent) %>%
                        summarise(area_continent = sum(area))
head(paises_group)


#Lo que hicimos es disolver los poligonos por continente
plot(paises_group["area_continent"])



## ---------------------------------------------------------------------------------

paises_Eu <- filter(paises2, continent == "Europe",
                             name != "Russia")

paises_Afr <- filter(paises2, continent == "Africa")

plot(paises_Eu["area"])

EuroAsia <- bind_rows(paises_Eu, paises_Afr)

plot(EuroAsia["area"])



## ---------------------------------------------------------------------------------
df <- data.frame(name = paises$name, var_dummy=rnorm(255))
head(df)

paises_df <- left_join(paises, df)
paises_df <- left_join(paises, df, by = "name")

names(paises_df)[90:96]



## ---------------------------------------------------------------------------------
int <- st_intersection(ciudades, paises)
head(int[,1:5])


int_spr <- st_intersects(paises, ciudades)
int_spr


## ---------------------------------------------------------------------------------
# Creamos un polígono con la dimensión de Francia

spain <- filter(paises, name == "Spain")

poly_sp <- st_bbox(spain)%>%
               st_as_sfc()%>%
                 st_transform(4326)

# Calculamos la diferencia entre las dos geometrías
diff_pol <- st_difference(paises, poly_sp)
diff_pol[,1:5]

plot(diff_pol['admin'], 
     xlim = c(-20, 10),
     ylim = c(30, 55))


## ---------------------------------------------------------------------------------
recort_sp <- st_crop(paises, poly_sp)
plot(recort_sp['admin'])


## ---------------------------------------------------------------------------------
st_area(paises) %>% head()

area <- st_area(paises) %>%
            set_units(km2)
head(area)


## ---------------------------------------------------------------------------------
#matriz de distancia
dist_ciudades <- st_distance(ciudades)%>%
                        set_units(km)
dim(dist_ciudades) #matrix
# head(dist_ciudades)

#distancia entre un único punto y otros
p <- data.frame(lon = 0, lat = 40) %>%
          st_as_sf(coords = c("lon", "lat")) %>% 
            st_set_crs(4326)

p_dist <- st_distance(ciudades, p)
dim(p_dist)



## ---------------------------------------------------------------------------------
#buffer de 10 kilómetros alrededor de Austria
buf_ic <- paises %>%
            dplyr::filter(name == "Austria") %>%
                      st_transform(3055) %>%
                         st_buffer(10000) 

austria <- paises %>%
            dplyr::filter(name == "Austria") %>%
                      st_transform(3055)

plot(austria['name'], reset=FALSE) # usamos reset para poder añadir el otro mapa encima
plot(buf_ic['name'], col=NA, border = 'red', add = T) # add=T añade el buffer


## ---------------------------------------------------------------------------------
# Convertimos los polígonos de los países a líneas
pol_to_line <- st_cast(paises, "MULTILINESTRING")

# Perímetro de todos los polígonos
perim <- st_cast(paises, "MULTILINESTRING") %>% st_length()
head(perim)



## ---------------------------------------------------------------------------------
#eliminar geometría 
paises_df <- dplyr::select(paises2, area, name) %>% 
                       st_set_geometry(NULL)

head(paises_df) #data.frame (es irreversible sin lon, lat)

# para exportar debemos eliminar la clase unit 
paises <- mutate(paises2, across(c(pop_est, area, densidad), as.numeric))

# sf a sp
paises_sp <- as(paises, "Spatial")
class(paises_sp)

#sp a sf
paises_sf <- st_as_sf(paises_sp)
class(paises_sf)



## ---------------------------------------------------------------------------------
# Exportación a shapefile de ESRI
st_write(paises_sf, "paises_sf.shp")
 
# Exportación a GeoJSON
st_write(paises_sf, "paises_sf.geojson")


## ---------------------------------------------------------------------------------
install.packages("rnaturalearth")
devtools::install_github("ropensci/rnaturalearthdata") # resolución media
devtools::install_github("ropensci/rnaturalearthhires") # resolución alta
# package
library(rnaturalearth)


## ---------------------------------------------------------------------------------
# limites administrativos
wld <- ne_countries(scale = 50, returnclass = "sf")

# mapamundi
ggplot(wld) +
  geom_sf(fill = "grey90", colour = "white") +
  coord_sf(crs = "ESRI:54009") +
  theme_void()


## ---------------------------------------------------------------------------------
# importamos los husos horarios
tz <- st_read("./data/ne_10m_time_zones.shp")

# primer mapa
ggplot(tz) +
  geom_sf()

# mapamundi sin 'expansión'
ggplot(tz) +
  geom_sf() +
  coord_sf(expand = FALSE)

# con otra proyección y colorado por el huso
ggplot(tz) +
  geom_sf(aes(fill = zone), colour = "white") +
   coord_sf(crs = "ESRI:54009") +
   theme_void()

# con más ajustes
ggplot() +
  geom_sf(data = wld, fill = "grey80", colour = NA) +
  geom_sf(data = tz, 
          aes(fill = zone), 
          colour = "white", 
          alpha = 0.5) +
   scale_fill_gradient2() +
   coord_sf(crs = "ESRI:54009") +
   theme_void()


