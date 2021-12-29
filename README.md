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

##### lapply

Aplica una función a un iterable y devuelve una **lista**

```R
# lapply(X, FUN, ...)
low_pioners <- lapply(pioneers, tolower)
```

##### sapply

Aplica una función a un iterable y devuelve una lista/vector/loquesea (lo intenta **simplificar**)

```R
# sapply(X, FUN, ..., simplify = TRUE, USE.NAMES = TRUE)
sapply(pioneers, function(x) { nchar(x) + 1 })
```

##### vapply

Aplica una función a un iterable y devuelve un **vector** con formato definido

```R
# vapply(X, FUN, FUN.VALUE, ..., USE.NAMES = TRUE)
vapply(temp, basics, FUN.VALUE=numeric(3))
```
> numeric(3): el resultado de cada iteración de `temp` es un vector con 3 números. También existe `character()` o `logical()`