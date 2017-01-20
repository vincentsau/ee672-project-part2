FROM ubuntu:14.04
MAINTAINER Vincent <vincentiverson03@gmail.com>

WORKDIR /opt
RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get install -y python wget tar gzip zip
RUN apt-get install -y cmake gfortran

#install lapack
RUN wget https://nchc.dl.sourceforge.net/project/math-atlas/Stable/3.10.3/atlas3.10.3.tar.bz2
RUN wget http://www.netlib.org/lapack/lapack-3.7.0.tgz
RUN tar zxvf lapack-3.7.0.tgz
WORKDIR /opt/lapack-3.7.0
RUN mv make.inc.example make.inc
