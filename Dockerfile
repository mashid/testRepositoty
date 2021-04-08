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
	
#Samtools
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

# Install biobambam2 - 2.0.50
RUN mkdir /SOFT/biobambam2/  &&\
	mkdir /SOFT/biobambam2/bin/ && \
	mkdir /SOFT/biobambam2/etc/ &&\
	mkdir /SOFT/biobambam2/lib/ &&\
	mkdir /SOFT/biobambam2/share/

RUN curl -ksSL -o tmp.tar.gz --retry 10 https://github.com/gt1/biobambam2/releases/download/2.0.50-release-20160705161609/biobambam2-2.0.50-release-20160705161609-x86_64-etch-linux-gnu.tar.gz && \
    tar --strip-components 1 -zxf tmp.tar.gz && \
    cp -r /SOFT/bin/* /SOFT/biobambam2/bin/. && \
    cp -r /SOFT/etc/* /SOFT/biobambam2/etc/. && \
    cp -r /SOFT/lib/* /SOFT/biobambam2/lib/. && \
    cp -r /SOFT/share/* /SOFT/biobambam2/share/. &&\
    rm -r /SOFT/bin/ &&\
	rm -r /SOFT/etc/ &&\
	rm -r /SOFT/lib/ &&\
	rm -r /SOFT/share/ &&\
	rm -r /SOFT/build/ &&\
	rm tmp.tar.gz &&\
	rm README
	
ENV PATH=${PATH}:/SOFT/biobambam2/bin

WORKDIR /tmp