# glue

Interpolación de texto

## glue()

```R
a <- 'lorem ipsum'
b <- 10
glue('{a} dolor sit amet {b}')
# lorem ipsum dolor sit amet 10
```

```R
a <- c(10, 12, 13)
glue('Valor {a}')
# Valor 10
# Valor 12
# Valor 13
```