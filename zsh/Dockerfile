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
ARG KUBECTL_VERSION=v1.25.2
RUN set -x && \
    curl -sLO "https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/${TARGETARCH}/kubectl" && \
    chmod +x kubectl && \
    ./kubectl version --client

# Bootstrap kubectl
RUN chmod +x bootstrap.sh && ./bootstrap.sh

COPY .zshrc ./

RUN exec zsh

ENTRYPOINT ["/bin/zsh"]
