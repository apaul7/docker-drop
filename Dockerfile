FROM continuumio/miniconda3:24.11.1-0

LABEL \
  description="Image for running drop, https://github.com/gagneurlab/drop" \
  mainteiner="Alexander Paul <alex.paul@wustl.edu>"

RUN apt-get update && apt-get install -y \
  bc \
  build-essential \
  graphviz \
  git \
  unzip \
  vim

WORKDIR /tmp/
RUN wget https://www.cmm.in.tum.de/public/paper/drop_analysis/DROP_1.4.0.yaml
RUN conda install conda-forge::mamba
RUN mamba env create -f DROP_1.4.0.yaml
WORKDIR /
