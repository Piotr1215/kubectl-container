FROM ubuntu:rolling
LABEL maintainer="Piotr Zaniewski <piotrzan@gmail.com>"

WORKDIR /root

COPY bootstrap.sh ./

RUN apt-get update && apt-get -y install --no-install-recommends \
    gnupg \
    curl \
    wget \
    git \
    apt-transport-https \
    ca-certificates \
    zsh \
    tmux \
    && rm -rf /var/lib/apt/lists/*

ENV SHELL /usr/bin/zsh

# Install kubectl
# renovate: datasource=github-releases depName=kubernetes/kubernetes
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list && \
    apt-get update && apt-get -y install --no-install-recommends kubectl

# Bootstrap kubectl
RUN chmod +x bootstrap.sh && ./bootstrap.sh

COPY .zshrc ./

RUN exec zsh

ENTRYPOINT ["/bin/zsh"]
