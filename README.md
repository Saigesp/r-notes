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

## lapply(), sapply() y vapply()

`lapply`: Aplicar función a iterable y devuelve una **lista**
`sapply`: Aplicar función a iterable y devuelve una lista/vector/loquesea (lo intenta **simplificar**)
`lapply`: Aplicar función a iterable y devuelve un **vector** con formato definido

```R
# Aplicación básica
low_pioners <- lapply(pioneers, tolower)

# Con función anónima
lapply(pioneers, function(x) { nchar(x) + 1 })

# vapply requiere especificar formato
vapply(temp, basics, FUN.VALUE=numeric(3))
```
> numeric(3): el resultado de cada iteración de `temp` es un vector con 3 números. También existe `character()` o `logical()`