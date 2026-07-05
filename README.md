# FIFA World Cup Analysis (1930–2018)

Análisis exploratorio y modelado predictivo sobre datos históricos de la Copa del Mundo FIFA.

## Dataset

- **Fuente:** [FIFA World Cup, Kaggle](https://www.kaggle.com/datasets/evangower/fifa-world-cup)
- Archivos: `worldcups.csv`, `wcmatches.csv`.

## Requisitos

- R (>= 4.1.0) 
- Paquetes: `tidyverse`, `nnet`, `MASS`, `glmnet`, `caret`

```r
install.packages(c("tidyverse", "nnet", "MASS", "glmnet", "caret"))
```

## Estructura del proyecto

```bash  
fifa-worldcup-analysis/
├── R/
│   ├── load.R
│   ├── clean.R
│   ├── eda.R
│   ├── modeling.R
│   └── utils.R
├── data/
│   ├── raw/
│   └── processed/
├── output/plots/
├── report/
├── Makefile
├── README.md
└── .gitignore
```

## Uso

### Linux/Mac
```bash
make all
```

### Windows
```bash
#Instalar make con Chocolatey (una vez)
choco install make

make all
```

### Targets disponibles
| Target | Descripción |
|--------|-------------|
| `make all` | Ejecuta pipeline completo |
| `make load` | Carga datos |
| `make clean` | Limpieza |
| `make eda` | Análisis exploratorio |
| `make model` | Modelado |
| `make report` | Renderiza informe |
El reporte es almacenado en el directorio `reporte` con formato html.
