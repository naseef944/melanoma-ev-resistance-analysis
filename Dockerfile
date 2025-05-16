FROM rocker/binder:4.2.2

COPY install.R /tmp/install.R
RUN Rscript /tmp/install.R
