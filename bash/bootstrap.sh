#!/bin/bash

mkdir /root/.kube

echo "source <(kubectl completion bash)" >> ~/.bashrcource <(kubectl completion bash) # setup autocomplete in bash into the current shell, bash-completion package should be installed first. \

(
  set -x &&
  wget -c https://github.com/derailed/k9s/releases/download/v0.13.4/k9s_0.13.4_Linux_x86_64.tar.gz -O - | tar -xz &&
  chmod +x k9s &&
  mv k9s /usr/local/bin/
)

# Add krew to path to call it from kubectl
source ~/.bashrc