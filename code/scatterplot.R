library(ggplot2)

here::i_am("code/scatterplot.R")

modified_panc_data <- readRDS(
  file = here::here("clean_data/panc_biomarkers_modified.rds")
)



scatterplot <- 
  ggplot(modified_panc_data, aes(x = age, y = LYVE1)) +
  geom_point() +
  geom_smooth(method = lm) +
  theme_bw()

ggsave(
  here::here("output/scatterplot.png"),
  plot = scatterplot,
  device = "png"
)

