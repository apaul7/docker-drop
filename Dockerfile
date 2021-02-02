FROM continuumio/miniconda3:4.9.2
MAINTAINER Alexander Paul <alex.paul@.wustl.edu>

LABEL \
  description="Image for running drop, https://github.com/gagneurlab/drop"

RUN apt-get update && apt-get install -y \
  build-essential \
  git \
  vim

RUN conda install -c conda-forge r-base r-essentials
#RUN conda install -c conda-forge -c bioconda snakemake drop
RUN conda install -c conda-forge -c bioconda snakemake
RUN pip install git+git://github.com/gagneurlab/drop@dev
WORKDIR /drop-demo
RUN drop demo
RUN snakemake -n 
RUN R -e "BiocManager::install('BSgenome.Hsapiens.UCSC.hg38')"
RUN R -e "BiocManager::install('BSgenome.Hsapiens.NCBI.GRCh38')"
#RUN R -e "install.packages('XML',dependencies=TRUE, repos='http://cran.rstudio.com/')"
#RUN R -e "install.packages('ggrepel',dependencies=TRUE, repos='http://cran.rstudio.com/')"
#RUN apt-get install -y libgit2-dev
#RUN R -e "BiocManager::install('GenomicFeatures')"
#RUN R -e "BiocManager::install('XML')"
#ENV LIBXML_LIBDIR="/opt/conda/include/libxml2/libxml/"
#ENV LIBXML_INCDIR="/opt/conda/include/libxml2/libxml/"
#ENV XML_CONFIG="/opt/conda/bin/xml2-config"
#RUN R -e "BiocManager::install('c-mertes/FRASER', dependencies=TRUE, update=FALSE)"
WORKDIR /
