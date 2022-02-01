# dplyr (tidyverse)

Funciones

```R
install.packages("tidyverse")
library(dplyr)
```

### glimpse()

Muestra información sobre la variable

```R
glimpse(starwars)
# > glimpse(starwars)
# Rows: 87
# Columns: 14
# $ name       <chr> "Luke Skywalker", "C-3PO", "R2-D2", "Darth Vader"…
# $ height     <int> 172, 167, 96, 202, 150, 178, 165, 97, 183, 182…
# ...
```

### between()

Compara una variable en un rango de valores

```R
between(x, left, right)
# > between(10, 30, 5)
# [1] FALSE
```

## Operaciones con filas


### filter()

Filtra un dataframe en base a algún filtro lógico.

```R
dataframe %>% filter(eye_color == "brown")
dataframe %>% filter(is.na(eye_color) == TRUE)
```

### drop_na()

Elimina las filas con NA en una o varias columnas

```R
starwars %>% drop_na(mass)
starwars %>% drop_na(mass, height)
```

### slice()

Obtiene la fila indicada

```R
dataframe %>% slice(1)
```
> `slice_head(n)` para la primera file y `slice_tail(n)` para la última. `slice_min(var, n)` y `slice_max(var, n)` selecciona el valor más alto/bajo de una variable

### slice_sample()

Obtiene filas aleatorias

```R
slice(n)
dataframe %>% slice_sample(n=4) # 4 rows aleatorias
```

### distinct()

Elimina filas idénticas

```R
dataframe %>% distinct(eye_color) # Valores únicos
dataframe %>% distinct(eye_color, .keep_all = T) # Filas distinct
```

### arrange()

Ordenar las filas

```R
starwars %>% arrange(mass) # Ascendente
starwars %>% arrange(desc(mass)) # Descendente
```

## Operaciones con columnas

### select()

Selecciona columnas

```R
starwars %>% select(name) # Columna name
starwars %>% select(where(is.numeric)) # Solo columnas de tipo numero
```

### mutate()

Mutar columnas (crear/editar)

```R
people %>% mutate(full_name = paste(f_name, l_name)) # Nueva columna full_name
```

### transmutate()

Como `mutate`, pero sin modificar la tabla

```R
people %>% transmutate(full_name = paste(f_name, l_name)) # Nueva columna full_name
```

### group_by()

Agrupar por una variable

```R
starwars %>% drop_na(mass) %>% group_by(sex) %>% summarize(mean(mass))
```

### ungroup()

Desagrupar

### summarize()

Sacar estadísticas

```R
starwars %>% drop_na(mass) %>% summarize(mean(mass))
```