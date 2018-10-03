FROM ubuntu:18.04

RUN apt-get update && apt-get install -y \
    wget make gcc\

RUN wget https://github.com/stamatak/standard-RAxML/archive/v8.2.12.tar.gz && \
    tar zxvf v8.2.12.tar.gz && \
    rm v8.2.12.tar.gz && \
    mv standard-RAxML-8.2.12 raxml

RUN cd /raxml && make -f Makefile.SSE3.PTHREADS.gcc \
    rm *.o && cp raxmlHPC-PTHREADS-SSE3 /usr/bin/.

RUN mkdir /working_dir
WORKDIR /working_dir
