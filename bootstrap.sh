#!/bin/bash

mkdir /root/.kube

echo "source <(kubectl completion bash)" >> ~/.bashrcource <(kubectl completion bash) # setup autocomplete in bash into the current shell, bash-completion package should be installed first. \

(
  set -x; cd "$(mktemp -d)" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/download/v0.3.3/krew.{tar.gz,yaml}" &&
  tar zxvf krew.tar.gz &&
  KREW=./krew-"$(uname | tr '[:upper:]' '[:lower:]')_amd64" &&
  "$KREW" install --manifest=krew.yaml --archive=krew.tar.gz &&
  "$KREW" update
)

(
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
)

# Add krew to path to call it from kubectl
source ~/.bashrc