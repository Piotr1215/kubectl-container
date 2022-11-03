FROM ubuntu:rolling
LABEL maintainer="Piotr Zaniewski <piotrzan@gmail.com>"

WORKDIR /root
ARG TARGETARCH=amd64

RUN apt-get update && apt-get -y install --no-install-recommends \
    gnupg \
    curl \
    wget \
    git \
    apt-transport-https \
    ca-certificates \
    zsh \
    tmux \
    vim \
    fzf \
    && rm -rf /var/lib/apt/lists/*

ENV SHELL /usr/bin/zsh

RUN echo '[STEP 1] Creating directory for kubectl config' && \
    mkdir /root/.kube

# renovate: datasource=github-releases depName=kubernetes/kubernetes
ARG KUBECTL_VERSION=v1.25.3
RUN echo '[STEP 2] Installing kubectl' && \
    set -x && \
    curl -sLO "https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/${TARGETARCH}/kubectl" && \
    chmod +x kubectl && \
    ./kubectl version --client && \
    mv kubectl /usr/local/bin/

# renovate: datasource=github-releases depName=derailed/k9s
ARG K9S_VERSION=v0.26.7
RUN echo '[STEP 3] Installing k9s awesomeness'  && \
    set -x && \
    wget -c https://github.com/derailed/k9s/releases/download/"${K9S_VERSION}"/k9s_Linux_x86_64.tar.gz -O - | tar -xz && \
    chmod +x k9s && \
    mv k9s /usr/local/bin/

RUN echo '[STEP 4] Installing Oh-My-Zsh' && \
    wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true

RUN echo '[STEP 5] Installing zsh-autosuggestions plugin' && \
    git clone https://github.com/zsh-users/zsh-autosuggestions /root/.oh-my-zsh/custom/plugins/zsh-autosuggestions

COPY .zshrc ./

RUN echo '[STEP 6] Install tmux with cool customizations' && \
    git clone https://github.com/samoshkin/tmux-config.git && \
    ./tmux-config/install.sh

# renovate: datasource=github-releases depName=kubernetes-sigs/krew
ARG KREW_VERSION=v0.4.3
RUN echo '[STEP 7] Install krew kubectl plugin' \
    set -x && \
    wget https://github.com/kubernetes-sigs/krew/releases/download/"${KREW_VERSION}"/krew-linux_amd64.tar.gz && \
    tar zxvf krew-linux_amd64.tar.gz && \
    ./krew-linux_amd64 install krew 

RUN echo '[STEP 8] Installing stern' && \
    ./krew-linux_amd64 install stern && \
    ./krew-linux_amd64 install ns && \
    ./krew-linux_amd64 install ctx

# renovate: datasource=github-releases depName=kubernetes-sigs/krew
ARG KUBESEAL_VERSION=0.18.0
RUN echo '[STEP 9] Install kubeseal' && \
    wget https://github.com/bitnami-labs/sealed-secrets/releases/download/v0.18.0/kubeseal-"${KUBESEAL_VERSION}"-linux-amd64.tar.gz && \
    tar -xvf kubeseal-"${KUBESEAL_VERSION}"-linux-amd64.tar.gz && \
    cp kubeseal /usr/local/bin/

RUN echo '[STEP 10] Setting zsh as default shell' && \
    chsh -s $(which zsh)

CMD ["k9s"]

ENTRYPOINT ["/usr/bin/zsh", "-c"]
