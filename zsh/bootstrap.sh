#!/bin/bash
echo 'Bootstrap steps start here:'

echo '[STEP 1] Creating directory for kubectl config'
mkdir /root/.kube

# renovate: datasource=github-releases depName=derailed/k9s
K9S_VERSION=v0.25.18
echo '[STEP 2] Installing k9s awesomeness'
(
	set -x &&
		wget -c https://github.com/derailed/k9s/releases/download/"${K9S_VERSION}"/k9s_Linux_x86_64.tar.gz -O - | tar -xz &&
		chmod +x k9s &&
		mv k9s /usr/local/bin/
)

echo '[STEP 3] Installing Oh-My-Zsh'
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echo '[STEP 4] Installing zsh-autosuggestions plugin'
git clone https://github.com/zsh-users/zsh-autosuggestions /root/.oh-my-zsh/custom/plugins/zsh-autosuggestions

echo '[STEP 5] Installing stern'
(
	wget https://github.com/wercker/stern/releases/download/1.11.0/stern_linux_amd64 &&
		chmod +x stern_linux_amd64 &&
		mv stern_linux_amd64 /usr/local/bin/stern
)

echo '[STEP 6] Installing kubectx and kubens - quickly switch kubernetes context and namespace'
(
	git clone https://github.com/ahmetb/kubectx /opt/kubectx &&
		ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx &&
		ln -s /opt/kubectx/kubens /usr/local/bin/kubens
)

echo '[STEP 7] Installing Okteto for local development'
curl https://get.okteto.com -sSfL | sh

echo '[STEP 8] Install tmux with cool customizations'
git clone https://github.com/samoshkin/tmux-config.git
./tmux-config/install.sh

echo '[STEP 9] Install krew kubectl plugin'
set -x
cd "$(mktemp -d)" &&
	curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/download/v0.3.4/krew.{tar.gz,yaml}" &&
	tar zxvf krew.tar.gz &&
	KREW=./krew-"$(uname | tr '[:upper:]' '[:lower:]')_amd64" &&
	"$KREW" install --manifest=krew.yaml --archive=krew.tar.gz &&
	"$KREW" update

echo 'export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"' >>~/.zshrc

echo '[STEP 10] Setting zsh as default shell'
chsh -s $(which zsh)
