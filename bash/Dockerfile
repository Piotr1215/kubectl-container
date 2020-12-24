FROM alpine:3.7 as stage
LABEL maintainer="Piotr Zaniewski <piotrzan@gmail.com>"

ARG KUBECTL_VERSION="v1.20.0"
ENV ENV_KUBECTL_VERSION=${KUBECTL_VERSION}

WORKDIR /root

COPY .bashrc .bash_profile bootstrap.sh ./

ADD https://storage.googleapis.com/kubernetes-release/release/$KUBECTL_VERSION/bin/linux/amd64/kubectl /usr/local/bin/kubectl

RUN apk add --no-cache \
    bash-completion \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Bootstrap kubectl
RUN set -x && \
    apk add --no-cache curl ca-certificates && \
    chmod +x /usr/local/bin/kubectl && \
    kubectl version --client

FROM alpine:3.7 as app

WORKDIR /root

RUN mkdir /root/.kube \
    && rm -rf /var/lib/apt/lists/*

RUN /bin/sh -c "apk add --no-cache bash"

COPY --from=stage ["/usr/local/bin/kubectl", "/usr/local/bin/"]

COPY .bashrc .bash_profile ./

ENTRYPOINT ["/bin/bash"]