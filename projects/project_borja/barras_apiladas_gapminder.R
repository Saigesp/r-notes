# ----- barras gapminder -----

# Barras: geom_col()
# Mapeado: x --> year, y --> gdpPercap
library(gapminder)
ggplot(gapminder,
       aes(y = gdpPercap, x = year)) +
  geom_col()
     

# Medias por año y continent
gapminder_por_continente <-
  gapminder %>% group_by(year, continent) %>%
  summarise(sum_gdpPercap = mean(gdpPercap))
gapminder_por_continente

# Barras APILADAS: geom_col()
# Mapeado: x --> year, y --> gdpPercap, fill --> continent
ggplot(gapminder_por_continente,
              aes(y = sum_gdpPercap, x = year,
                  fill = continent)) +
  geom_col() +
  scale_fill_tableau()

# Barras SIN APILAR: geom_col()
# Mapeado: x --> year, y --> gdpPercap, fill --> continent
ggplot(gapminder_por_continente,
       aes(y = sum_gdpPercap, x = year, fill = continent)) +
  geom_col(position = "dodge2") +
  scale_fill_tableau()


# Barras FILL (MISMA ESCALA TODOS): geom_col()
# Mapeado: x --> year, y --> gdpPercap, fill --> continent
ggplot(gapminder_por_continente,
       aes(y = sum_gdpPercap, x = year,
           fill = continent)) +
  geom_col(position = "fill") +
  scale_fill_tableau()
       

# Barras APILADAS: geom_col()
# Mapeado: x --> year, y --> gdpPercap, fill --> continent
# Invertimos coordenadas con coord_flip()
ggplot(gapminder_por_continente,
      aes(y = sum_gdpPercap, x = year,
          fill = continent)) +
  geom_col() +
  coord_flip() + #<<
  scale_fill_tableau() +
  labs(x = "Renta per cápita", y = "Año",
       color = "Continente",
       title = "EJEMPLO DE DIAGRAMA DE BARRAS",
       subtitle =
          "Barras horizontales (agrupadas por continente y año)",
       caption = "J. Álvarez Liébana | Datos: gapminder")
       