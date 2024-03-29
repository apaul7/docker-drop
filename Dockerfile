FROM continuumio/miniconda3:4.12.0
MAINTAINER Alexander Paul <alex.paul@.wustl.edu>

LABEL \
  description="Image for running drop, https://github.com/gagneurlab/drop"

RUN apt-get update && apt-get install -y \
  bc \
  build-essential \
  graphviz \
  git \
  unzip \
  vim

RUN conda create -y -c conda-forge -c bioconda -n drop \
  "drop=1.2.1" \
  snakemake

RUN echo "conda activate drop" >> ~/.bashrc
ENV PATH "/opt/conda/envs/drop/bin:$PATH"

WORKDIR /
