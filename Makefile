ZSH = piotrzan/kubectl-comp:zsh
BASH = piotrzan/kubectl-comp

.PHONY: all run-detatch-zsh run-zsh run-detatch-bash run-bash copy attach zsh-run bash-run

all: zsh-run

run-detatch-zsh:
	docker run -d --network=host --name=kubectl-host --rm -it $(ZSH)

run-zsh:
	docker run --network=host --name=kubectl-host --rm -it $(ZSH)

run-detatch-bash:
	docker run -d --network=host --name=kubectl-host --rm -it $(BASH)

run-bash:
	docker run --network=host --name=kubectl-host --rm -it $(BASH)

copy:
	kubectl config view --raw > config
	docker cp config kubectl-host:./root/.kube

attach:
	docker attach kubectl-host

zsh-run: run-detatch-zsh copy attach

bash-run: run-detatch-bash copy attach