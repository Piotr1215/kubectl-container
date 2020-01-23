#!/bin/bash

mkdir /root/.kube

echo "source <(kubectl completion bash)" >> ~/.bashrcource <(kubectl completion bash) # setup autocomplete in bash into the current shell, bash-completion package should be installed first. \
source ~/.bashrc # add autocomplete permanently to your bash shell.