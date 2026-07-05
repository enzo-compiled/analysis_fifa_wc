.PHONY: all load clean eda model report

all: load clean eda model report

load:
	Rscript R/load.R

clean:
	Rscript R/clean.R

eda:
	Rscript R/eda.R

model:
	Rscript R/modeling.R

report:
	Rscript -e "rmarkdown::render('report/mini-proyecto.Rmd')"
