# lubridate

Paquete para trabajar con fechas.

```R
install.packages("lubridate")
library(lubridate)
```

## Fecha y hora del sistema

```R
# today
today()
```

```R
# now
now()
```

## Extración de valores

### year()

Devuelve el año de una fecha (int)

```R
# year(Date, ...)
year(today())
```

### month()

Devuelve el mes de una fecha (int)
```R
# month(Date, ...)
month(today())
```

### day()

Devuelve el día de una fecha (int)

```R
# day(Date, ...)
day(today())
```