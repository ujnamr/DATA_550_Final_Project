
pan_bio_Rmd = Urinary_biomarkers_pancancer.Rmd
output_report_html = output/Urinary_biomarkers_pancancer.html
output_directory = output

# Rule
$(output_report_html): $(pan_bio_Rmd)
	Rscript -e "rmarkdown::render('$(pan_bio_Rmd)', output_file = '$(output_report_html)')"

# Phony target for final report
final_report: $(output_report_html)

# Phony target to clean output directory
clean:
	rm -rf $(output_directory)

# target to run all necessary tasks
all: clean final_report
