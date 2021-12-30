# R training

Notas y apuntes de R mientras voy aprendiendo. Puede que lo elimine en el futuro

## Ayuda

#### ?

Consulta información sobre una función

```R
# ?FUN
?gsub
```

#### str()

Obtener información estructurada de una variable

```R
# str(object, ...)
str(vars)
```

## Funciones para imprimir por consola

#### print()

Imprime por pantalla

```R
# print(X, ...)
print('hola')
```

#### paste()

Concatena valores (y convierte a strings)

```R
# paste (..., sep = " ", collapse = NULL, recycle0 = FALSE)
paste('hola', 'mundo')
```

## Utilidades matemáticas

#### abs()

Valor absoluto

```R
# abs(x)
abs(-20) # 20
abs(c(-1, -2, 3)) # 1 2 3
```

#### round()

Redondear valores

```R
# round(x, digits = 0)
round(1.39, 1) # 1.3
round(c(1.1, 2.5, 3.9)) # 1 2 4
```

#### ceiling()

Redondear valores al entero superior

```R
# ceiling(x)
ceiling(1.4) # 2
ceiling(c(1.4, 2.0)) # 2 2
```

#### floor()

Redondear valores al entero inferior

```R
# floor(x)
floor(1.8) # 1
floor(c(1.4, 2.9)) # 1 2
```

#### sum()

Sumar valores

```R
# sum(..., na.rm = FALSE)
sum(1, 4, 5) # 10
sum(c(1, 4, 5)) # 10
```

#### mean()

Calcular media (average)

```R
# mean(x, ...)
mean(c(2, 4, 6)) # 4
```

## Funciones para estructuras de datos

#### seq()

Generar secuencia de datos

```R
# seq(from = 1, to = 1, by = ((to - from)/(length.out - 1)), length.out = NULL, along.with = NULL, ...)
seq(1, 5) # 1 2 3 4 5
seq(5, 1, -2) # 5 3 1
```

#### rep()

Replica los valores de x (vector o lista normalmente)

```R
# rep(x, times = 1, length.out = NA, each = 1)
rep(23, 3) # 23 23 23
rep(c(1, 2, 3), times=2) # 1 2 3 1 2 3
rep(c(1, 2, 3), each=2) # 1 1 2 2 3 3
```

#### sort()

Ordena los valores de x

```R
# sort.int(x, partial = NULL, na.last = NA, decreasing = FALSE, method = c("auto", "shell", "quick", "radix"), index.return = FALSE)
sort(c(3,1,2)) # 1 2 3
sort(c(3,1,2), decreasing=TRUE) # 3 2 1
sort(c('lorem', 'ipsum', 'dolor')) # "dolor" "ipsum" "lorem"
```

## lapply, sapply y vapply

Funciones para aplicar sobre iterables

#### lapply()

Aplica una función a un iterable y devuelve una **lista**

```R
# lapply(X, FUN, ...)
low_pioners <- lapply(pioneers, tolower)
```

#### sapply()

Aplica una función a un iterable y devuelve una lista/vector/loquesea (lo intenta **simplificar**)

```R
# sapply(X, FUN, ..., simplify = TRUE, USE.NAMES = TRUE)
sapply(pioneers, function(x) { nchar(x) + 1 })
```

#### vapply()

Aplica una función a un iterable y devuelve un **vector** con formato definido

```R
# vapply(X, FUN, FUN.VALUE, ..., USE.NAMES = TRUE)
vapply(temp, basics, FUN.VALUE=numeric(3))
```
> `numeric(3)`: el resultado de cada iteración de `temp` es un vector con 3 números. También existe `character()` o `logical()`