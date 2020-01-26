# Kubectl with auto-completion in a docker container

The purpose of this tool is to have a fully portable `kubectl` command line tool with a few convinience utilities.
Quick testing of a cluster with well-known/customized `kubectl` setup.

## What is included

- ``kubectl`` v 1.17.2
- ``kubectl`` bash completion
- ``krew`` plugin
- ``k9s`` cluster monitoring tool
- common .bashrc aliases

## How to use

After running docker container, all the clusters running on the localhost should be available for `kubectl` command.

## Supported tags

- zsh

## How the images are build

docker build --rm -f "./bash/Dockerfile" -t piotrzan/kubectl-comp "." - __this builds image with bash shell__

docker build --rm -f "./zsh/Dockerfile" -t piotrzan/kubectl-comp:zsh "." - __this builds image with zsh shell__

## Convinient scripts to run the contianer

Use `run.ps1` or `run.sh` for windows or linux respectivels.
Alternatively use docker-compose.yaml, this works by mounting a volume on the $HOME/.kube folder on the host.

### Linux Example

**Run contianer with passthrough to local network**
`docker run -d --network=host --name=kubectl-host --rm -it piotrzan/kubectl-comp`

**Generate raw config from kubeclt on localhost and copy the config to the container**
`kubeclt config view --raw > config
docker cp ./config kubectl-host:./root/.kube`

**Attach back to the contianer with kubeconfig file containing info about clusters running on localhost**
`docker attach kubectl-host`

## Extending the image

If you would like to add your own customization or ``krew`` plugins, you can easily do it and use `docker commit` to create your own version of the image.
