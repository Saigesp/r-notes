# readxl

Importar datos desde archivos Excel (xls y xlsx).

Documentación: (https://rdocumentation.org/packages/readxl/versions/1.3.1)

```R
install.packages("readxl")
library(readxl)
```

#### excel_sheets()

Listar las hojas del excel

#### read_excel()

Importar datos desde excel a un objeto **tibble** (dataframe con esteroides).

```R
# read_excel(path, sheet = NULL, range = NULL, col_names = TRUE, col_types = NULL, n_max = Inf, ...)
datum <- read_excel('file.xls', sheet=2)
datum <- read_excel('file.xls', sheet="year_2008")
```