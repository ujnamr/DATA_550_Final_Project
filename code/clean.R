
library(labelled)
library(gtsummary)
library(dplyr)

here::i_am("code/clean.R")
data_filepath <- here::here("data", "Debernardi et al 2020 data.csv")
pancreatic_biomarkers_raw <- read.csv(data_filepath, header = TRUE)

# New column 'diagnosis_desc' based on 'diagnosis' column
pancreatic_biomarkers_raw <- pancreatic_biomarkers_raw %>%
  mutate(diagnosis_desc = case_when(
    diagnosis == 1 ~ "No Pancreatic Disease",
    diagnosis == 2 ~ "Benign Pancreatic Disease",
    diagnosis == 3 ~ "Pancreatic Ductal Adenocarcinoma",
    TRUE ~ as.character(diagnosis)  # Handle unexpected values
  ))


var_label(pancreatic_biomarkers_raw) <- list(
  age = "Age",
  sex = "Sex",
  diagnosis = "Diagnosis",
  stage = "Stage",
  plasma_CA19_9 = "Plasma CA 19-9",
  creatinine = "Creatinine",
  diagnosis_desc = "Description of diagnosis"
)

saveRDS(
  pancreatic_biomarkers_raw, 
  file = here::here("clean_data/panc_biomarkers_modified.rds")
)



