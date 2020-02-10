IMAGE?=piotrzan/kubectl-comp:zsh
#piotrzan/kubectl-comp:zsh
#piotrzan/kubectl-comp

.PHONY: all run-detatch-zsh run-zsh run-detatch-bash run-bash copy attach zsh-run bash-run

all: zsh-run

run-detatch-zsh:
	docker run -d --network=host --name=kubectl-host --rm -it $(IMAGE)

run-zsh:
	docker run --network=host --name=kubectl-host --rm -it $(IMAGE)

copy:
	kubectl config view --raw > config
	docker cp config kubectl-host:./root/.kube

attach:
	docker attach kubectl-host

zsh-run: run-detatch-zsh copy attach