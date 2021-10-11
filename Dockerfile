# Base image https://hub.docker.com/u/rocker/
FROM rocker/shiny:latest

RUN install2.r bookdown knitr rmarkdown psych dplyr

# system libraries of general use
## install debian packages
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
    libxml2-dev \
    libcairo2-dev \
    libsqlite3-dev \
    libmariadbd-dev \
    libpq-dev \
    libssh2-1-dev \
    unixodbc-dev \
    libcurl4-openssl-dev \
    libssl-dev
## update system libraries
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get clean

WORKDIR /home/r-kurs-buch
COPY _bookdown.yml   _bookdown.yml
COPY _output.yml  _output.yml
COPY _pkgdown.yml  _pkgdown.yml
COPY book.bib   book.bib
COPY packages.bib   packages.bib
COPY preamble.tex preamble.tex
COPY DESCRIPTION DESCRIPTION
COPY index.Rmd  index.Rmd
COPY README.md  README.md
COPY deploy.R deploy.R
COPY /chapters ./chapters
COPY /docs ./docs
COPY starwars.RDS starwars.RDS
COPY style.css  style.css
CMD Rscript deploy.R
