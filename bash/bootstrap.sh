#!/bin/bash

mkdir /root/.kube

echo "source <(kubectl completion bash)" >> ~/.bashrcource <(kubectl completion bash) # setup autocomplete in bash into the current shell, bash-completion package should be installed first. \

# Add krew to path to call it from kubectl
source ~/.bashrc