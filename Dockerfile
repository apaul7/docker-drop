FROM continuumio/miniconda3:4.9.2
MAINTAINER Alexander Paul <alex.paul@.wustl.edu>

LABEL \
  description="Image for running drop, https://github.com/gagneurlab/drop"

RUN apt-get update && apt-get install -y \
  build-essential \
  git \
  libxml2-dev \
  vim

RUN conda install -c conda-forge -c bioconda snakemake drop
WORKDIR /drop-demo
RUN drop demo
RUN snakemake -n 

WORKDIR /
