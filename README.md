# Kubectl with auto-completion in a docker container

The purpose of this tool is to have a fully portable `kubectl` command line tool with a few convinience utilities.
Quick testing of a cluster with well-known/customized `kubectl` setup.

## What is included

There are two images, one for bash shell and one for zsh.

- `kubectl` v 1.17.2, bash/zsh completion
- `zsh-autosuggestions` for zsh shell
- `k9s` cluster monitoring tool
- popular tools: `curl, wget, git`
- useful .bashrc/.zshrc aliases

## How to use

After running docker container, all the clusters running on the localhost should be available for `kubectl` command.

## Supported tags

- **zsh**
  docker pull piotrzan/kubectl-comp:zsh
  [Dockerfile](https://github.com/Piotr1215/kubectl-container/blob/master/zsh/Dockerfile)

- **bash**
  docker pull piotrzan/kubectl-comp
  [Dockerfile](https://github.com/Piotr1215/kubectl-container/blob/master/bash/Dockerfile)

## How the images are build

### Build image with bash shell

docker build --rm -f "Dockerfile" -t piotrzan/kubectl-comp "."

### Build image with zsh shell

docker build --rm -f "Dockerfile" -t piotrzan/kubectl-comp:zsh "."

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

If you would like to add your own customization, you can easily do it and use `docker commit` to create your own version of the image.
