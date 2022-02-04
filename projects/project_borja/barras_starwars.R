# ----- diagrama de barras -----


# Filtramos ausentes en especies y los contamos: vamos a visualizar
# las frecuencias, los n que salen del count()
starwars_filtro <-
  starwars %>%
  filter(!is.na(species)) %>%
  count(species)

# Diagrama de barras
# geom_col()
# Mapeado: x --> n (frecuencias), y --> species
ggplot(starwars_filtro,
       aes(y = species, x = n)) +
  geom_col() #<<


# Diagrama de barras
# geom_col()
# Mapeado: x --> n (frecuencias), y --> species
#          fill --> n
# En las barras: fill --> relleno, color --> borde
# El n para R es algo continuo --> scale_fill_continuous
ggplot(starwars_filtro,
       aes(y = species, x = n, fill = n)) +
  geom_col() +
  scale_fill_continuous_tableau() + #<<
  labs(fill = "Frecuencia absoluta",
       x = "Número de personajes",
       y = "Especies")

# Si convertimos n a factor (categoría) --> scale_fill
ggplot(starwars_filtro,
       aes(y = species, x = n, fill = as.factor(n))) +
  geom_col() +
  scale_fill_tableau() + #<<
  labs(fill = "Frecuencia absoluta",
       x = "Número de personajes",
       y = "Especies")


# Para que no salgan tantas barras vamos a reagrupar niveles
# con pocas categorías
starwars_filtro <-
  starwars %>%
  filter(!is.na(species)) %>%
  mutate(species =
           fct_lump_min(species, min = 3,
                        other_level =
                          "Otras especies")) %>%
  count(species)


ggplot(starwars_filtro,
       aes(y = species, x = n, fill = n)) +
  geom_col() +
  scale_fill_continuous_tableau() +
  labs(fill = "Frecuencia absoluta",
       x = "Número de personajes", y = "Especies")
