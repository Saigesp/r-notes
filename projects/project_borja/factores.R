# ----- factores: cualitativas

# La variable `estado` actualmente es de tipo texto, de tipo `chr`,
# algo que podemos comprobar con `class(estado)`.
estado <-
  c("grave", "leve", "sano", "sano", "sano", "grave",
    "grave", "leve", "grave", "sano", "sano")
estado
class(estado)

# Convertir a factor
library(tidyverse)
estado_fct <- as_factor(estado)
estado_fct
class(estado_fct)

# nos aparece la frase `Levels: grave leve sano`:
# son las modalidades o niveles de nuestra cualitativa.
# Imagina que ese día en el hospital no tuviésemos a nadie en estado grave:
# aunque ese día nuestra variable no tome dicho valor, el estado `grave`
# es un nivel permitido que podríamos tener, así que aunque lo eliminemos,
# por ser un factor, el nivel permanece (no lo tenemos ahora pero es un nivel permitido).
estado_fct[estado_fct %in% c("sano", "leve")]

# Eliminar nivel
fct_drop(estado_fct[estado_fct %in% c("sano", "leve")])

# Ampliar niveles
fct_expand(estado_fct, c("UCI", "fallecido"))

# Contar
fct_count(estado_fct)

# Ordenar por frecuencia
fct_infreq(estado_fct)

# Reagrupar niveles por tamaño mínimo
fct_lump_min(estado_fct, min = 3)
fct_lump_min(estado_fct, min = 5)
fct_lump_min(estado_fct, min = 5, other_level = "otros")