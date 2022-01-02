# R training

Notas y apuntes de R mientras voy aprendiendo. Puede que lo elimine en el futuro

## Ayuda

### ?

Consulta información sobre una función

```R
# ?FUN
?gsub
```

### str()

Obtener información de la estructura de una variable

```R
# str(object, ...)
str(var)
```

### summary()

Obtener información de una variable dependiendo de su clase

```R
# summary(object, ...)
summary(var)
```

### head()

Devuelve las primeras filas de un objeto

```R
# head(x, n = 6L, addrownums, ...)
head(var)
```

### tail()

Devuelve las últimas filas de un objeto

```R
# tail(x, n = 6L, addrownums, ...)
tail(var)
```

### system.time()

Consulta el uso de la CPU de una expresión

```R
# system.time(expr, ...)
system.time(seq(5e8, 1, -2))
```

## Funciones para imprimir por consola

### print()

Imprime por pantalla

```R
# print(X, ...)
print('hola')
```

### paste()

Concatena valores (y convierte a strings)

```R
# paste (..., sep = " ", collapse = NULL, recycle0 = FALSE)
paste('hola', 'mundo')
```

## Comparación de valores

### identical()

Compara dos valores

```R
# identical(x, y, ...)
identical(1, 2) # FALSE
identical(c("a","b"), sort(c('b', 'a'))) # TRUE
```

### is.list()

Comprueba si un valor es una lista

```R
# is.list(x)
is.list(list(1, 2, 3)) # TRUE
is.list(c(1, 2, 3)) # FALSE
```


## Utilidades matemáticas

### abs()

Valor absoluto

```R
# abs(x)
abs(-20) # 20
abs(c(-1, -2, 3)) # 1 2 3
```

### round()

Redondear valores

```R
# round(x, digits = 0)
round(2.25)
round(1.39, 1) # 1.3
round(c(1.1, 2.5, 3.9)) # 1 2 4
```

### ceiling()

Redondear valores al entero superior

```R
# ceiling(x)
ceiling(1.4) # 2
ceiling(c(1.4, 2.0)) # 2 2
```

### floor()

Redondear valores al entero inferior

```R
# floor(x)
floor(1.8) # 1
floor(c(1.4, 2.9)) # 1 2
```

### sum()

Sumar valores

```R
# sum(..., na.rm = FALSE)
sum(1, 4, 5) # 10
sum(c(1, 4, 5)) # 10
```

### mean()

Calcular media (average)

```R
# mean(x, ...)
mean(c(2, 4, 6)) # 4
```

## Funciones para estructuras de datos

### seq()

Generar secuencia de datos

```R
# seq(from = 1, to = 1, by = ((to - from)/(length.out - 1)), ...)
seq(1, 5) # 1 2 3 4 5
seq(5, 1, -2) # 5 3 1
```

### rep()

Replica los valores de x (vector o lista normalmente)

```R
# rep(x, times = 1, length.out = NA, each = 1)
rep(23, 3) # 23 23 23
rep(c(1, 2, 3), times=2) # 1 2 3 1 2 3
rep(c(1, 2, 3), each=2) # 1 1 2 2 3 3
```

### sort()

Ordena los valores de x

```R
# sort(x, decreasing = FALSE, ...)
sort(c(3,1,2)) # 1 2 3
sort(c(3,1,2), decreasing=TRUE) # 3 2 1
sort(c('lorem', 'ipsum', 'dolor')) # "dolor" "ipsum" "lorem"
```

### unlist()

Convierte una lista a un vector

```R
# unlist(x, recursive = TRUE, use.names = TRUE)
unlist(list(1, 2, 3)) # 1 2 3
unlist(list(1, 2, 'a')) # "1" "2" "a"
```

### append()

Añade elementos a un vector

```R
# append(x, values, after = length(x))
append(c(1, 2), 3) # 1 2 3
append(c(1, 2), c(3, 4)) # 1 2 3 4
```

### rev()

Invierte el orden del elemento

```R
# rev(x)
rev(c(1, 2, 3)) # 3 2 1
```

## Expresiones regulares

### grep()

Devuelve las posiciones del vector/lista que hacen match

```R
# grep(pattern, x, ignore.case = FALSE, value = FALSE, ...)
grep('a', c("gato", "perro", "caballo")) # 1 3
```

### grepl()

Devuelve un vector lógico con los matchs

```R
# grepl(pattern, x, ignore.case = FALSE, ...)
grepl('a', c("gato", "perro", "caballo")) # TRUE FALSE TRUE
```

### sub()

Substituye strings con expresiones regulares (solo primer match de cada item)

```R
# sub(pattern, replacement, x, ignore.case = FALSE, ...)
sub('a', 'A', c("gato", "perro", "caballo")) # "gAto" "perro" "cAballo"
```

### gsub()

Substituye strings con expresiones regulares (global)

```R
# gsub(pattern, replacement, x, ignore.case = FALSE, ...)
gsub('a', 'A', c("gato", "perro", "caballo")) # "gAto" "perro" "cAbAllo"
```

## Fecha y tiempo

### Sys.Date()

Devuelve la fecha del sistema

```R
Sys.Date() # "2021-12-30"
```

### Sys.time()

Devuelve la fecha y hora del sistema

```R
Sys.time() # "2021-12-30 15:03:32 CET"
```

### as.Date()

Genera fecha con el string introducido

```R
# as.Date(x, format, ...)
as.Date('2021-11-30') # "2021-11-30"
as.Date('30-12-2021', format='%d-%m-%Y') # "2021-11-30"
as.Date(c('21-12-01', '21-12-02'), '%y-%m-%d') # "2021-12-01" "2021-12-02"
```

### as.POSIXct

Genera fecha y hora con string introducido

```R
# as.POSIXct(x, tz = "", ...)
as.POSIXct('2021-12-30 12:12:60') "2021-12-30 12:13:00 CET"
```
> Módulos útiles para trabajar con fechas: `lubridate`, `zoo`, `xts`

### format()

Formatear objeto

```R
# format(x ...)
format(Sys.Date(), '%d/%m/%Y') # "31/12/2021"
format(c(as.Date('2021-12-25'), as.Date('2021-12-26')), '%d') "25" "26"
```

## lapply, sapply y vapply

Funciones para aplicar sobre iterables

### lapply()

Aplica una función a un iterable y devuelve una **lista**

```R
# lapply(X, FUN, ...)
low_pioners <- lapply(pioneers, tolower)
```

### sapply()

Aplica una función a un iterable y devuelve una lista/vector **simplificado**

```R
# sapply(X, FUN, ..., simplify = TRUE, USE.NAMES = TRUE)
sapply(pioneers, function(x) { nchar(x) + 1 })
```

### vapply()

Aplica una función a un iterable y devuelve un **vector** con formato definido

```R
# vapply(X, FUN, FUN.VALUE, ..., USE.NAMES = TRUE)
vapply(temp, basics, FUN.VALUE=numeric(3))
```
> `numeric(3)`: el resultado de cada iteración de `temp` es un vector numérico de longitud 3. También existe `character()` o `logical()`


## Importar datos

### read.csv()

Importar datos de un csv como data.frame

```R
# read.csv(file, header = TRUE, sep = ",", quote = "\"", stringsAsFactors = FALSE, ...)
movies <- read.csv('movies.csv')
actors <- read.csv(file.path('~', 'repo', 'actors.csv'))
```

### read.delim()

Importar datos de un csv separado por otros caractéres

```R
# read.delim(file, header = TRUE, sep = "\t", quote = "\"", ...)
movies <- read.delim('movies.csv', sep=";")
```

### read.table()

Importar datos de un archivo tabular

```R
# read.table(file, header = FALSE, sep = "", quote = "\"'", row.names, col.names, ...)
movies <- read.table('movies.csv', sep=";", fileEncoding="latin-1")
```
> Módulos útiles: [readr](/readr/README.md), [data.table](/data.table/README.md), [readxl](/readxl/README.md)

## Previsualizar datos

### plot()

Genera scatterplots de un objeto

![plot() example](https://github.com/Saigesp/r-training/blob/master/_media/root-scatterplot.jpg?raw=true)

```R
# plot(x, y = NULL, type = "p", ...)
plot(datum)
plot(datum$first_date, datum$last_date)
```
> `type` es el tipo de gráfico que debe dibujar: **l**ineas, **h**istogramas, etc

### hist()

Genera un histogramas de un vector

![hist() example](https://github.com/Saigesp/r-training/blob/master/_media/root-histogram.jpg?raw=true)

```R
# hist(x, ...)
hist(data$total_expenses)
```

## Generar imágenes

### jpeg()

Genera una imagen JPEG del output. Debe llamar a `dev.off()` para generar la imagen:

```R
# jpeg(filename, width = 480, height = 480, ...)
jpeg('test.jpg', width=800)
hist(data$total_expenses)
dev.off()
```
> También existen las funciones `png`, `bmp` y `tiff`