# Fetch ubuntu image
FROM ubuntu:24.04

#Install build tools
RUN apt update && \
    apt install -y wget build-essential autoconf automake libtool

#Copy project into image
RUN mkdir /project
COPY src /project/src
COPY tests /project/tests
COPY Makefile /project/Makefile

# Download and get CPPUTest
RUN mkdir /project/tools/ && \
    cd /project/ && \
    wget https://github.com/cpputest/cpputest/releases/download/v4.0/cpputest-4.0.tar.gz && \
    tar xf cpputest-4.0.tar.gz && \
    mv cpputest-4.0/ tools/cpputest/ && \
    cd tools/cpputest/ && \
    autoreconf -i && \
    ./configure && \
    make
    
# Execute script
ENTRYPOINT ["make", "test", "-C", "/project/"]