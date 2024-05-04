FROM rocker/rstudio as base
RUN mkdir -p /home/rstudio/Final_project
WORKDIR /home/rstudio/Final_Project

RUN apt-get update && apt-get install -y \
    zlib1g-dev \
    pandoc \
    libxml2-dev
    
RUN mkdir -p renv
COPY renv.lock renv.lock
COPY .Rprofile .Rprofile
COPY renv/activate.R renv/activate.R
COPY renv/settings.json renv/settings.json

RUN mkdir renv/.cache
ENV RENV_PATHS_CACHE renv/.cache

RUN R -e "renv::restore(prompt=FALSE)"

RUN mkdir -p code data clean_data output
COPY code /code
COPY data /data
COPY clean_data /clean_data
COPY Makefile .
COPY pancreatic_biomarkers.Rmd .
COPY README.Rmd .

ENV WHICH_CONFIG="default"

RUN mkdir -p report
WORKDIR /home/rstudio/Final_Project

CMD make && mv pancreatic_biomarkers.html report



