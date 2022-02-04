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
ggplot(data, aes(year, cost)) # Better
```
> Por sí solo no muestra nada

## Geometrias

### geom_point()

Crea un scatterplot sobre un objeto ggplot.

![geom_point() example](https://github.com/Saigesp/r-training/blob/master/_media/ggplot2-geom_point.jpg?raw=true)

```R
# geom_point(mapping = NULL, data = NULL, ...)
ggplot(data, aes(year, years)) + geom_point()
```

### geom_smooth()

Muestra posibles patrones.

![geom_smooth() example](https://github.com/Saigesp/r-training/blob/master/_media/ggplot2-geom_smooth.jpg?raw=true)

```R
# geom_smooth(mapping = NULL, data = NULL, stat = "smooth", ...)
ggplot(data, aes(year, years)) + geom_point() + geom_smooth()
```

### geom_boxplot()

Crea un boxplot sobre un objeto ggplot.

![geom_boxplot() example](https://github.com/Saigesp/r-training/blob/master/_media/ggplot2-geom_boxplot.jpg?raw=true)

```R
# geom_boxplot(mapping = NULL, data = NULL, ...)
ggplot(data, aes(genre, year)) + geom_boxplot()
```

### scale_color_brewer()

Escalas de colors brewer

```R
# scale_color_brewer(palette, ...)
ggplot(gapminder_1997, aes(x = lifeExp, y = gdpPercap, color=continent))+ geom_point() + scale_color_brewer(palette='Spectral')
```
> Más escalas de colores instalando el package `ggthemes`, como `scale_color_tableau()`


### scale_color_manual()

Mapea la escala de color manualmente

```R
# scale_color_manual(values, ...)
ggplot(gapminder_1997, aes(x = lifeExp, y = gdpPercap, color=continent))+ geom_point(alpha=0.5) + scale_color_manual(values = c('red', 'blue', 'purple', 'green', 'orange'))
```

### scale_y_log10()

Aplicar escala logarítmica

```R
ggplot(gapminder_1997, aes(x = lifeExp, y = gdpPercap, color=continent, size=pop))+ geom_point() + scale_y_log10()
```

## Facets

(~Multiples gráficos separados por 1 dimensión)

```R
ggplot(gapminder_1997, aes(x = lifeExp, y = gdpPercap))+ geom_point() + facet_wrap(~continent)
```

## Labels

```R
ggplot(gapminder_1997, aes(x = lifeExp, y = gdpPercap, color=continent))+ geom_point(alpha=0.5) + scale_y_log10() + labs(title="title here", caption="this is a caption", subtitle="lorem ipsum")
```
![geom_boxplot() example](https://github.com/Saigesp/r-training/blob/master/_media/ggplot2-lab.png?raw=true)

Otro ejemplo:

```R
data <- starwars %>% drop_na(mass, height, eye_color) %>% filter(mass < 1000) %>% mutate(
    eye_color=case_when(
        eye_color=='blue-gray' ~ 'blue',
        eye_color=='hazel' ~ 'brown',
        eye_color=='green, yellow' ~ 'green',
        eye_color=='unknow' ~ 'grey',
        TRUE ~ eye_color
    )

ggplot(data), aes(x=height, y=mass, size=mass, color=eye_color)) +
geom_point(alpha=0.6) +
guides(size='none') +
labs(
    eye_color='Color de ojos',
    title="Título",
    subtitle="Subtítulo",
    caption="No mires abajo") +
scale_x_continuous(breaks=seq(60, 240, by=30)) +
scale_y_continuous(seq(20, 160, 20))
```
![geom_boxplot() example](https://github.com/Saigesp/r-training/blob/master/_media/ggplot2-all-example.png?raw=true)