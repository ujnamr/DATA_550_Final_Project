
library(gtsummary)

here::i_am("Final_Project/code/descriptive_table.R")

modified_panc_data <- readRDS(
  file = here::here("Final_Project/clean_data/panc_biomarkers_modified.rds")
)

table_1 <- modified_panc_data %>%
  select("age", "sex", "diagnosis_desc", "stage", "plasma_CA19_9", "creatinine", "LYVE1", "TFF1", "REG1A", "REG1B") %>%
  tbl_summary(by = diagnosis_desc) %>%
  add_overall() %>%
  add_p()


table_1

saveRDS(
  table_1,
  file = here::here("Final_Project/output/table_1.rds")
)