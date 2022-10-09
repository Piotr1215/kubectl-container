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

RUN echo '[STEP 1] Creating directory for kubectl config' \
    mkdir /root/.kube

# Install kubectl
ARG TARGETARCH=amd64
# renovate: datasource=github-releases depName=kubernetes/kubernetes
ARG KUBECTL_VERSION=v1.25.1
RUN set -x && \
    curl -sLO "https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/${TARGETARCH}/kubectl" && \
    chmod +x kubectl && \
    ./kubectl version --client
# Bootstrap kubectl

# renovate: datasource=github-releases depName=derailed/k9s
ARG K9S_VERSION=v0.26.6
RUN echo '[STEP 2] Installing k9s awesomeness' \
	set -x && wget -c https://github.com/derailed/k9s/releases/download/"${K9S_VERSION}"/k9s_Linux_x86_64.tar.gz -O - \
        | tar -xz && \
        chmod +x k9s && \
        mv k9s /usr/local/bin/

RUN chmod +x bootstrap.sh && ./bootstrap.sh

COPY .zshrc ./

RUN exec zsh

ENTRYPOINT ["/bin/zsh"]
