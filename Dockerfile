FROM jupyter/datascience-notebook:latest

# Installing via pip fails
# RUN conda install numpy=1.14.5 pandas=0.23.3 scipy==1.1.0

ADD requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

USER $NB_USER
