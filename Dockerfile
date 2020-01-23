FROM ubuntu:18.10

COPY ./.bashrc /root/.bashrc

RUN apt-get update && apt-get -y install \
    gnupg \
    curl \
    git

# Install kubectl
RUN apt-get -y install apt-transport-https
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
RUN echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list
RUN apt-get update && apt-get install -y kubectl

# Configure auto-complete for bash
#RUN echo "source <(kubectl completion bash)" >> ~/.bashrcource <(kubectl completion bash) # setup autocomplete in bash into the current shell, bash-completion package should be installed first. \
#    source ~/.bashrc # add autocomplete permanently to your bash shell.

ENV SHELL /usr/bin/bash

WORKDIR /root
ENTRYPOINT ["/bin/bash"]