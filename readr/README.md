# readr

Paquete para importar datos tabulares a un objeto **tibble** (dataframe con esteroides).

Documentación: https://readr.tidyverse.org/reference/

```R
install.packages("readr")
library(readr)
```

### read_delim()

Importar datos de un archivo tabular. https://readr.tidyverse.org/reference/read_delim.html

```R
# read_delim(file, delim = NULL, quote = "\"", ...)
movies <- read_delim('movies.csv', delim=";", col_types= "cldi")
```
> `col_types` puede representarse como string: **c**haracter, **l**ogical, **d**ouble, **i**nteger...

Para determinar los tipos de columna `col_types`, pueden usarse colectores:

```R
fac <- col_factor(levels = c("Beef", "Meat", "Poultry"))
int <- col_integer()

hotdogs <- read_tsv("hotdogs.txt",
    col_names = c("type", "calories", "sodium"),
    col_types = list(fac, int, int))

```

### read_csv()

```R
# read_csv(file, col_names = TRUE, col_types = NULL, ...)
movies <- read_csv('movies.csv')
```

### read_tsv()

```R
# read_tsv(file, col_names = TRUE, col_types = NULL, ...)
movies <- read_tsv('movies.csv')
```