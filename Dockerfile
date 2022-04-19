FROM debian:bullseye-20220228
#FROM node:17.9-bullseye
# https://hub.docker.com/_/debian


RUN apt update -y
RUN apt remove -y python3-distutils python3 && \
    apt install -y curl git \
                   software-properties-common build-essential \
                   libnss3-dev zlib1g-dev libgdbm-dev libncurses5-dev \
                   libssl-dev libffi-dev libreadline-dev libsqlite3-dev libbz2-dev

WORKDIR /usr/src



## ■ Python
# https://computingforgeeks.com/how-to-install-python-latest-debian/
ENV PYTHONVERSION 3.10.2
ENV PYTHONVERSIONBIN 3.10

RUN curl -s -o /tmp/Python-$PYTHONVERSION.tgz  https://www.python.org/ftp/python/$PYTHONVERSION/Python-$PYTHONVERSION.tgz && \
    tar xvf /tmp/Python-$PYTHONVERSION.tgz && \
    rm -rf /tmp/Python-$PYTHONVERSION.tgz && \
    cd /usr/src/Python-$PYTHONVERSION && \
    ./configure --enable-optimizations && \
    make altinstall && \
    ln -s /usr/local/bin/python$PYTHONVERSIONBIN /usr/local/bin/python3 && \
    ln -s /usr/local/bin/pip$PYTHONVERSIONBIN /usr/local/bin/pip3

RUN python3 -m pip install --upgrade pip

# ■ go言語
# https://go.dev/dl/
ENV ARCH amd64
ENV GOVERSION 1.18
ENV HOME /root
ENV PATH $PATH:/usr/local/go/bin
ENV GOPATH $HOME/work
ENV PATH $GOPATH/bin:$PATH

WORKDIR /usr/local
RUN curl -s -o /tmp/go.tar.gz https://storage.googleapis.com/golang/go$GOVERSION.linux-$ARCH.tar.gz && \
    tar xvf /tmp/go.tar.gz && \
    rm /tmp/go.tar.gz


## ■ Node.js17.x

RUN curl -fsSL https://deb.nodesource.com/setup_17.x | bash - && \
    apt-get install -y nodejs


ENTRYPOINT ["/bin/sh", "-c", "while :; do sleep 10; done"]
