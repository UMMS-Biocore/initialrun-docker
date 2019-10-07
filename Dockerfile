FROM ubuntu:16.04
MAINTAINER Onur Yukselen <onur.yukselen@umassmed.edu>

ENV PATH="/bin:/sbin:/usr/bin/samtools-1.9:/usr/bin/sratoolkit.2.10.0-ubuntu64/bin:${PATH}"

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get dist-upgrade
RUN apt-get -y install unzip libsqlite3-dev libbz2-dev libssl-dev python python-dev  liblzma-dev \
    python-pip git libxml2-dev software-properties-common wget tree vim sed make libncurses5-dev libncursesw5-dev\
    subversion g++ gcc gfortran libcurl4-openssl-dev curl zlib1g-dev build-essential libffi-dev  python-lzo libxml-libxml-perl

### SRA-toolkit
RUN mkdir -p /data /project /nl /share
RUN cd /usr/bin && wget https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/2.10.0/sratoolkit.2.10.0-ubuntu64.tar.gz && \ 
    tar -xvzf sratoolkit.2.10.0-ubuntu64.tar.gz 

     
### S3CMD
RUN apt-get -y upgrade
RUN apt-get -y install python-setuptools
RUN cd /usr/bin && wget http://netix.dl.sourceforge.net/project/s3tools/s3cmd/1.6.0/s3cmd-1.6.0.tar.gz && \
    tar xvfz s3cmd-1.6.0.tar.gz && cd s3cmd-1.6.0 && python setup.py install
RUN apt-get -y autoremove

### Samtools
RUN cd /usr/bin && wget https://github.com/samtools/samtools/releases/download/1.9/samtools-1.9.tar.bz2 && \
    tar -vxjf samtools-1.9.tar.bz2 && cd samtools-1.9 && make

### AWS CLI
RUN pip install awscli==1.16.170

RUN echo "DONE!"
