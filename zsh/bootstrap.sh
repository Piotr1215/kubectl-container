#!/bin/bash
echo 'Bootstrap steps start here:'

echo '[STEP 1] Creating directory for kubectl config'
mkdir /root/.kube

echo '[STEP 2] Installing k9s awesomeness'
(
  set -x &&
  wget -c https://github.com/derailed/k9s/releases/download/v0.13.4/k9s_0.13.4_Linux_x86_64.tar.gz -O - | tar -xz &&
  chmod +x k9s &&
  mv k9s /usr/local/bin/
)

echo '[STEP 3] Installing Oh-My-Zsh'
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echo '[STEP 4] Installing zsh-autosuggestions plugin'
git clone https://github.com/zsh-users/zsh-autosuggestions /root/.oh-my-zsh/custom/plugins/zsh-autosuggestions

echo '[STEP 5] Setting zsh as default shell'
chsh -s $(which zsh)