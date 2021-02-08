FROM continuumio/miniconda3:4.9.2
MAINTAINER Alexander Paul <alex.paul@.wustl.edu>

LABEL \
  description="Image for running drop, https://github.com/gagneurlab/drop"

RUN apt-get update && apt-get install -y \
  bc \
  build-essential \
  graphviz \
  git \
  vim

RUN conda create -y -c conda-forge -c bioconda -n drop \
  "drop=1.0.3" \
  snakemake

RUN echo "conda activate drop" >> ~/.bashrc
ENV PATH "/opt/conda/envs/drop/bin:$PATH"

WORKDIR /drop-demo
RUN drop demo
RUN snakemake -n 

WORKDIR /
