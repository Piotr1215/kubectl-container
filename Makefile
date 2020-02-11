IMAGE?=piotrzan/kubectl-comp:zsh
#piotrzan/kubectl-comp:zsh
#piotrzan/kubectl-comp

.PHONY: all run-detatch-zsh run-zsh run-detatch-bash run-bash copy attach zsh-run bash-run run-with-mount

default: run-with-mount

run-with-mount:
ifeq ($(OS),Windows_NT)
	docker run --network=host --name=kubectl-host -v ${USERPROFILE}/.kube:/root/.kube --rm -it $(IMAGE)
else
	docker run --network=host --name=kubectl-host -v /root/.kube:/root/.kube --rm -it $(IMAGE)
endif

run-detatch-zsh:
	docker run -d --network=host --name=kubectl-host --rm -it $(IMAGE)

run-zsh:
	docker run --network=host --name=kubectl-host

copy:
	kubectl config view --raw > config
	docker cp config kubectl-host:./root/.kube

attach:
	docker attach kubectl-host

zsh-run: run-detatch-zsh copy attach