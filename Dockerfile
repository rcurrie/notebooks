FROM jupyter/datascience-notebook:latest

# Installing via pip fails
RUN conda install numpy=1.14.3 pandas=0.23.0

# USER root

# RUN apt-get update -y && apt-get install -y --no-install-recommends \
#     curl \
#     wget \
#     zip \
#     zlib1g-dev \
#     time \
#     samtools \
#     bedtools \
#   && apt-get clean \
#   && rm -rf /var/lib/apt/lists/*


# RUN curl -sSL https://get.docker.com/ | sh
# RUN usermod -aG docker jovyan

# RUN wget -qO- https://github.com/lomereiter/sambamba/releases/download/v0.6.7/sambamba_v0.6.7_linux.tar.bz2 \
#   | tar xj -C /usr/local/bin

# # The order of these is intentional to work around conflicts
# RUN conda install --yes pytorch torchvision -c pytorch

# RUN conda install --yes tensorflow keras

ADD requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# RUN pip install git+git://github.com/slundberg/shap@f610db02a4eaa0d0b008582eecd8a67cfa9a8926#egg=shap
RUN pip install git+git://github.com/slundberg/shap#egg=shap

USER $NB_USER
