# Render the R Markdown report
pancreatic_biomarkers.html: pancreatic_biomarkers.Rmd code/render_report.R
	Rscript code/render_report.R

# Clean the data
clean_data/panc_biomarkers_modified.rds: code/clean.R data/Debernardi\ et\ al\ 2020\ data.csv
	Rscript code/clean.R

# Create table_1.rds
output/table_1.rds: code/descriptive_table.R clean_data/panc_biomarkers_modified.rds
	Rscript code/descriptive_table.R

# Create scatterplot.png
output/scatterplot.png: code/scatterplot.R clean_data/panc_biomarkers_modified.rds
	Rscript code/scatterplot.R

.PHONY: clean
clean:
	rm -f output/*.rds
	rm -f output/*.png
	rm -f pancreatic_biomarkers.html

# Renv
.PHONY: install
install:
	Rscript -e "renv::restore(prompt = FALSE)"
	

# Docker	
FILES= pancreatic_biomarkers.Rmd code/clean.R code/descriptive_table.R code/scatterplot.R code/render_report.R Makefile
RENV= renv.lock renv/activate.R renv/settings.json

#rule to build image
docker_image: Dockerfile $(FILES) $(RENV)
	docker build -t final_project_data550 .
	touch $@

#rule to auto build report in container
pancbiomarkers.html:
	docker run -v "$$(pwd)"/report:/home/rstudio/Final_Project/report ujnamr/final_project_data550
	 