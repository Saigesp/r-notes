# package
library(terra)

## ---------------------------------------------------------------------------
x <- rast()
x

x <- rast(ncol=36, nrow=18, xmin=-1000, xmax=1000, ymin=-100, ymax=900)
res(x) #nos permite ver la resolución espacial

res(x) <- 100

crs(x) <- "+proj=utm +zone=48 +datum=WGS84"
x
ncol(x) <- 25
nrow(x) <- 25

values(x) <- 1:ncell(x)
values(x)[1:30]

plot(x, main='Esto es un raster')


## ---------------------------------------------------------------------------
# Cargamos la temperatura media anual a 5min de res. esp. extraida de WorldClim
archivo <- './data/wc2.1_5m_bio_1.tif'

r <- rast(archivo)
sources(r)
hasValues(r)

plot(r, main='Temperatura media anual (1970-2000)')
terra::image(r)
terra::contour(r)
terra::contour(r, filled =TRUE)


## ---------------------------------------------------------------------------
library(rnaturalearth)

wld <- ne_countries(returnclass = "sf")

plot(r, main='Temperatura media anual (1970-2000)')
plot(wld, add = TRUE, col = NA)


## ---------------------------------------------------------------------------
r1 <- r+1
r2 <- r+2
r3 <- r+3
r4 <- r+4

# Podemos combinarlos en uno solo
s <- c(r1, r2, r3, r4)
s
nlyr(s)

brks <- seq(-5,40,5)
cols <- rev(terrain.colors(length(brks)-1))
plot(s, breaks = brks, col = cols)

# si queremos añadir los países:
paises <- function(){plot(wld, add = TRUE, col = NA)}
plot(s, breaks = brks, col = cols, fun = paises)

# en caso de que tengas problemas de RAM
# rm(r1, r2, r3, r4)
# gc()


## ---------------------------------------------------------------------------
# dim(s)

s <- s * sqrt(r) + 5
s[s == 5] <- 15


sclas <- classify(s, seq(-5,250,25))
plot(sclas,  type="interval", breaks = 1:11, 
     plg=list(legend=c("-5,20", "20,45", "45,70", "70,95", "95,120",
                       "120,145", "145,170", "170,195", "195,220", "220,245")),
     fun = paises)


## ---------------------------------------------------------------------------
a <- mean(r,s,10)
b <- sum(r,s)
all <- c(a, b)
all_sum <- sum(all)
all_sum
plot(all_sum, fun = paises)


## ---------------------------------------------------------------------------
global(s, 'mean', na.rm = TRUE)


## ---------------------------------------------------------------------------
r_recortado <- crop(r, ext(20,60,5,35)) # xmin, xmax, ymin, ymax

plot(r_recortado)


## ---------------------------------------------------------------------------
egipto <- vect('./data/egy_admbnda_adm0_capmas_itos_20170421.shp')

plot(r_recortado)
terra::lines(egipto)
 
egipto_raster <- mask(r, egipto)
plot(egipto_raster, xlim = ext(egipto)[1:2], ylim = ext(egipto)[3:4])


## ---------------------------------------------------------------------------
rr1 <- crop(r, ext(20,60,5,35))
rr2 <- crop(r, ext(20,60,-30,5))
 
m <- merge(rr1, rr2, filename='test.grd', overwrite=TRUE)
plot(m)


## ---------------------------------------------------------------------------
library(sf)
# creamos una serie de puntos aleatorios dentro del raster
set.seed(1234)
newpoints <- data.frame(lon = sample(-10:5, 10), 
                        lat = sample(30:45, 10))

# creamos nuestro objeto espacial sf
newpoints <- st_as_sf(newpoints, coords = c("lon", "lat"),
                      crs = 4326)
# extraemos los puntos
newpoints_val <- terra::extract(r, vect(newpoints))
newpoints_val


## ---------------------------------------------------------------------------
# define la proyección Mollweide 
# https://epsg.io/54009
mollCRS <- 'ESRI:54009'

#lee el erchivo
rast_bio <- rast("./data/wc2.1_5m_bio_1.tif")

#reproyecta ambos objetos
temp_moll <- terra::project(rast_bio, mollCRS)

wrld_moll <- st_transform(wld, mollCRS)
 
#plotea el mapa
plot(temp_moll)
plot(wrld_moll, add=TRUE, col = NA)


## ---------------------------------------------------------------------------
writeRaster(r, "temperatura_mundial.tif", overwrite=TRUE)

