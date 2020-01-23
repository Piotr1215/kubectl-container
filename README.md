# Kubectl with auto-completion in a docker container

The purpose of this tool is to have a fully portable <code>kubectl</code> command line tool with a few convinience utilities.
Quick testing of a cluster with well-known/customized <code>kubectl</code> setup.

## What is included
- <code>kubectl</code> v 1.17.2
- <code>kubectl</code> bash completion
- <code>krew</code> plugin
- common .bashrc aliases

## How to use:
After running docker container, all the clusters running on the localhost should be available for <code>kubectl</code> command.

## How the image was build:
docker build --rm -f "Dockerfile" -t piotrzan/kubectl-comp "."

## Convinient scripts to run the contianer:
Use `run.ps1` or `run.sh` for windows or linux respectivels

### Linux Example
\# **Run contianer with passthrough to local network**
`docker run -d --network=host --name=kubectl-host --rm -it piotrzan/kubectl-comp`

\# **Generate raw config from kubeclt on localhost and copy the config to the container**
`kubeclt config view --raw > config
docker cp ./config kubectl-host:./root/.kube`

\# **Attach back to the contianer with kubeconfig file containing info about clusters running on localhost**
`docker attach kubectl-host`

## Extending the image
If you would like to add your own customization or <code>krew</code> plugins, you can easily do it and use `docker commit` to create your own version of the image.

