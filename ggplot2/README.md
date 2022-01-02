# ggplot2

Paquete para generar gráficos.

Documentación: https://www.rdocumentation.org/packages/ggplot2/versions/3.3.5

```R
install.packages("ggplot2")
library(ggplot2)
```

### ggplot()

Inicializa un objeto ggplot para añadirle componentes.

```R
# ggplot(data = NULL, mapping = aes(), ...)
ggplot(data, aes(data$year, data$cost))
```
> Por sí solo no muestra nada

### geom_point()

Crea un scatterplot sobre un objeto ggplot.

![geom_point() example](https://github.com/Saigesp/r-training/blob/master/_media/ggplot2-geom_point.jpg?raw=true)

```R
# geom_point(mapping = NULL, data = NULL, ...)
ggplot(data, aes(data$year, data$cost)) + geom_point()
```

### geom_smooth

Muestra posibles patrones.

![geom_smooth() example](https://github.com/Saigesp/r-training/blob/master/_media/ggplot2-geom_smooth.jpg?raw=true)

```R
# geom_smooth(mapping = NULL, data = NULL, stat = "smooth", ...)
ggplot(data, aes(data$year, data$cost)) + geom_point() + geom_smooth()
```