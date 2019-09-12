FROM ubuntu:16.04
MAINTAINER Onur Yukselen <onur.yukselen@umassmed.edu>

ENV PATH="/bin:/sbin:/data/sratoolkit.2.9.6-1-ubuntu64/bin:${PATH}"

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get dist-upgrade
RUN apt-get -y install unzip libsqlite3-dev libbz2-dev libssl-dev python python-dev \
    python-pip git libxml2-dev software-properties-common wget tree vim sed \
    subversion g++ gcc gfortran libcurl4-openssl-dev curl zlib1g-dev build-essential libffi-dev  python-lzo

### SRA-toolkit
RUN mkdir -p /data /project /nl /share
RUN cd /data && wget https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/2.9.6-1/sratoolkit.2.9.6-1-ubuntu64.tar.gz
RUN tar -xvzf sratoolkit.2.9.6-1-ubuntu64.tar.gz
     
###S3CMD
RUN apt-get -y upgrade
RUN apt-get -y install python-setuptools
RUN wget http://netix.dl.sourceforge.net/project/s3tools/s3cmd/1.6.0/s3cmd-1.6.0.tar.gz
RUN tar xvfz s3cmd-1.6.0.tar.gz
RUN cd s3cmd-1.6.0
RUN python setup.py install
RUN apt-get -y autoremove
RUN echo "DONE!"
