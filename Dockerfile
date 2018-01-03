FROM jupyter/datascience-notebook:c7fb6660d096

USER root

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    curl \
    wget \
    zip \
    zlib1g-dev \
    time \
    samtools \
    bedtools \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN wget -qO- https://github.com/lomereiter/sambamba/releases/download/v0.6.7/sambamba_v0.6.7_linux.tar.bz2 \
  | tar xj -C /usr/local/bin

RUN pip install --upgrade pip
ADD requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

USER jovyan
