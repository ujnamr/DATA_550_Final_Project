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
