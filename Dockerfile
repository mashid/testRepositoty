FROM ubuntu:18.04

MAINTAINER Maria Pilipenko <mash_id@hotmail.com>

RUN apt-get update && apt-get -y upgrade && \
	apt-get install -y build-essential wget \
	curl \
	libncurses5-dev zlib1g-dev libbz2-dev liblzma-dev libcurl3-dev && \
	apt-get clean && apt-get purge && apt-get install unzip && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /SOFT

RUN wget https://github.com/ebiggers/libdeflate/archive/refs/heads/master.zip && \
	unzip master.zip && \
	rm master.zip && \
	cd libdeflate-master && \
	make && \
	make install
	
#Samtools - 1.12
RUN wget https://github.com/samtools/samtools/releases/download/1.12/samtools-1.12.tar.bz2 && \
	tar jxf samtools-1.12.tar.bz2 && \
	rm samtools-1.12.tar.bz2 && \
	cd samtools-1.12 && \
	mkdir /SOFT/samtools &&\
	./configure --prefix=/SOFT/samtools/ && \
	make all all-htslib && \
	make install install-htslib
	
ENV PATH=${PATH}:/SOFT/samtools/bin

RUN cp /SOFT/libdeflate-master/libdeflate.so.0 /usr/lib/x86_64-linux-gnu/ &&\
	rm -r /SOFT/libdeflate-master/ &&\
	rm -r /SOFT/samtools-1.12/

# biobambam2 - 2.0.87
RUN mkdir /SOFT/biobambam2/  

RUN curl -ksSL -o tmp.tar.gz --retry 10 https://github.com/gt1/biobambam2/releases/download/2.0.87-release-20180301132713/biobambam2-2.0.87-release-20180301132713-x86_64-etch-linux-gnu.tar.gz && \
    tar --strip-components 1 -zxf tmp.tar.gz && \
	rm tmp.tar.gz &&\
	cp -r /SOFT/2.0.87-release-20180301132713/x86_64-etch-linux-gnu/* /SOFT/biobambam2/. &&\
	rm -r 2.0.87-release-20180301132713
	

ENV PATH=${PATH}:/SOFT/biobambam2/bin

WORKDIR /tmp
