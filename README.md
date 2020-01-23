# Kubectl with auto-mpletion in a docker container

The purpose of this tool is to have a fully portable `kubectl` command line tool with a few convinience utilities.
Quick testing of a cluster with well-known/customized kubectl setup.

## What is included
- kubectl v 1.17.2
- kubectl bash completion
- krew plugin
- common .bashrc aliases

## How to use:
After running docker container, all the clusters running on the localhost should be available for kubectl command.

## How the image was build:
docker build --rm -f "Dockerfile" -t piotrzan/kubectl-comp "."

## Convinient scripts to run the contianer:
Use `run.ps1` or `run.sh` for windows or linux respectivels

### Linux Example
\# **Run contianer with passthrough to local network**
docker run -d --network=host --name=kubectl-host --rm -it piotrzan/kubectl-comp

\# **Generate raw config from kubeclt on localhost and copy the config to the container**
kubeclt config view --raw > config
docker cp ./config kubectl-host:./root/.kube

\# **Attach back to the contianer with kubeconfig file containing info about clusters running on localhost**
docker attach kubectl-host



