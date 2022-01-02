# data.table

Paquete para trabajar con datos tabulares con el objeto **data.table** (dataframe con esteroides).

Documentación: https://cran.r-project.org/web/packages/data.table/vignettes/datatable-intro.html

```R
install.packages("data.table")
library(data.table)
```

### fread()

Similar a read.table pero más rápido y cómodo: https://www.rdocumentation.org/packages/data.table/versions/1.14.2/topics/fread

```R
# fread(input, file, text, cmd, sep="auto", sep2="auto", dec=".", quote="\"", ...)
datum <- fread('file.csv')
datum <- fread('file.csv', drop=2:4) # No importar columnas 2, 3 y 4
datum <- fread("file.csv", select=c(1, 5)) # Importar solo columnas 1 y 5
datum <- fread("file.csv", drop=c("name", "age")) # No importar columnas "name" ni "age"
```