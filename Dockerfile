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
RUN tar -zxvf lapack-3.7.0.tgz
WORKDIR /opt/lapack-3.7.0
RUN mv make.inc.example make.inc
RUN sed -i 's/\#lib: blaslib variants lapacklib tmglib/lib: blaslib lapacklib tmglib/g' Makefile
RUN sed -i 's/lib: lapacklib tmglib/\#lib: lapacklib tmglib/g' Makefile
RUN make

#install atlas
RUN tar -jxvf atlas3.10.3.tar.bz2
RUN mv ATLAS atlas_src
WORKDIR /opt/atlas_src
RUN mkdir atlas_build
WORKDIR /opt/atlas_src/atlas_build
RUN ../configure -b 64 -D c -DPentiumCPS=2593 -Fa alg -fPIC --with-netlib-lapack-tarfile=/opt/lapack-3.7.0.tgz --prefix=/opt/atlas
RUN make build
RUN make check
RUN make time
RUN make install

#install cvxopt
WORKDIR /opt
RUN wget https://codeload.github.com/cvxopt/cvxopt/zip/master
RUN mv master cvxopt-master.zip
RUN unzip cvxopt-master.zip
RUN mv cvxopt-master cvxopt
RUN wget http://faculty.cse.tamu.edu/davis/SuiteSparse/SuiteSparse-4.5.3.tar.gz
RUN tar -xf SuiteSparse-4.5.3.tar.gz
RUN export CVXOPT_SUITESPARSE_SRC_DIR=$(pwd)/SuiteSparse
