# readr

Leer archivos "rectangulares" a un **tibble** (dataframe con esteroides)

Documentación: (https://readr.tidyverse.org/reference/)

```R
install.packages("readr")
```

#### read_delim()

Importar datos de un archivo tabular. (https://readr.tidyverse.org/reference/read_delim.html)

```R
# read_delim(file, delim = NULL, quote = "\"", ...)
movies <- read_delim('movies.csv', delim=";", col_types= "cldi")
```
> `col_types` puede representarse como string: **c**haracter, **l**ogical, **d**ouble, **i**nteger...

#### read_csv()

```R
# read_csv(file, col_names = TRUE, col_types = NULL, ...)
movies <- read_csv('movies.csv')
```

#### read_tsv()

```R
# read_tsv(file, col_names = TRUE, col_types = NULL, ...)
movies <- read_tsv('movies.csv')
```