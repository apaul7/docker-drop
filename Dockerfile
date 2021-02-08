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
  bcftools \
  gatk4 \
  git \
  pip \
  "python>=3.8" \
  "r-base>=4.0.3" \
  r-essentials \
  r-xml \
  samtools

RUN echo "conda activate drop" >> ~/.bashrc
ENV PATH "/opt/conda/envs/drop/bin:$PATH"

RUN R -e "install.packages(c('BiocManager', 'XML'), dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "BiocManager::install(c('cowplot', 'data.table', 'DelayedMatrixStats', 'devtools', 'dplyr', 'ggplot2', 'ggthemes', 'knitr', 'magrittr', 'remotes', 'rmarkdown', 'tidyr', 'VariantAnnotation'), ask=FALSE)"

RUN R -e "BiocManager::install(c('gagneurlab/OUTRIDER', 'c-mertes/FRASER', 'mumichae/tMAE'), ask=FALSE, update=FALSE)"
RUN R -e "BiocManager::install(c('BSgenome.Hsapiens.UCSC.hg19', 'BSgenome.Hsapiens.UCSC.hg38', 'BSgenome.Hsapiens.NCBI.GRCh38'), ask=FALSE, update=FALSE)"


# it was af0b1accc29da921988526437fb11908322aff54 built 2/8/21
#RUN pip install git+git://github.com/gagneurlab/drop@dev

ENV DROP_COMMIT af0b1accc29da921988526437fb11908322aff54
WORKDIR /git
RUN git clone https://github.com/gagneurlab/drop.git
WORKDIR /git/drop
RUN git checkout $DROP_COMMIT
RUN pip install -e /git/drop/

# check if install worked
#WORKDIR /drop-demo
#RUN drop demo
#RUN snakemake -n

WORKDIR /
