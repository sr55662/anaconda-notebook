FROM debian:7.4

MAINTAINER Travis Swicegood

RUN apt-get update && apt-get install -y wget bzip2 ca-certificates
RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/archive/Anaconda-2.2.0-Linux-x86_64.sh && \
    /bin/bash /Anaconda-2.2.0-Linux-x86_64.sh -b -p /opt/conda && \
    rm /Anaconda-2.2.0-Linux-x86_64.sh && \
    /opt/conda/bin/conda install --yes conda==3.10.1

ENV PATH /opt/conda/bin:$PATH

# Create conda user, get anaconda by web or locally
RUN useradd --create-home --home-dir /home/condauser --shell /bin/bash condauser

# Setup our environment for running the ipython notebook
# Setting user here makes sure ipython notebook is run as user, not root
EXPOSE 8888
USER condauser
ENV HOME=/home/condauser
ENV SHELL=/bin/bash
ENV USER=condauser
WORKDIR /home/condauser/notebooks

CMD ipython notebook 
