# r-training

Notas y apuntes de R

## Ayuda

`?<funcion>`: Consulta información sobre la función

```R
?gsub
```

`str(<var>)`: Obtener información estructurada de una variable

```R
vars <- c(16, 9, 13, 5, 2, 17, 14)
str(vars)
```

## lapply, sapply y vapply

Funciones para aplicar sobre iterables

`lapply(X, FUN, ...)`: Aplicar función a iterable y devuelve una **lista**

```R
low_pioners <- lapply(pioneers, tolower)
```

`sapply(X, FUN, ..., simplify = TRUE, USE.NAMES = TRUE)`: Aplicar función a iterable y devuelve una lista/vector/loquesea (lo intenta **simplificar**)

```R
lapply(pioneers, function(x) { nchar(x) + 1 })
```

`vapply(X, FUN, FUN.VALUE, ..., USE.NAMES = TRUE)`: Aplicar función a iterable y devuelve un **vector** con formato definido

```R
vapply(temp, basics, FUN.VALUE=numeric(3))
```
> numeric(3): el resultado de cada iteración de `temp` es un vector con 3 números. También existe `character()` o `logical()`