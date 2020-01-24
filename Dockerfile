FROM ubuntu:18.10
LABEL maintainer="Piotr Zaniewski <piotrzan@gmail.com>"

WORKDIR /root

COPY .bashrc .bash_profile bootstrap.sh ./

RUN apt-get update && apt-get -y install --no-install-recommends \
    gnupg \
    curl \
    git \
    bash-completion \
    apt-transport-https \
    ca-certificates \
    figlet \
    && rm -rf /var/lib/apt/lists/*

ENV SHELL /usr/bin/bash

# Install kubectl
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list && \
    apt-get update && apt-get -y install --no-install-recommends kubectl

# Bootstrap kubectl
RUN chmod +x bootstrap.sh && ./bootstrap.sh

ENTRYPOINT ["/bin/bash"]
