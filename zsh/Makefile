NAME = piotrzan/kubectl-comp:zsh

default: run-copy-attach

run-detatch:
		docker run -d --network=host --name=kubectl-host --rm -it $(NAME)

run:
		docker run --network=host --name=kubectl-host --rm -it $(NAME)

copy:
		kubectl config view --raw > config
		docker cp config kubectl-host:./root/.kube

attach:
		docker attach kubectl-host

run-copy-attach: run-detatch copy attach