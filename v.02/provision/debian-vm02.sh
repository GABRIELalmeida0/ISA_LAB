#!/bin/bash

apt -y update && apt upgrade 
apt install -y vim-common net-tools tzdata keyboard-configuration

# Configuração do layout do teclado para br-abnt2
echo -e "\nConfigurando o layout do teclado para br-abnt2..."
debconf-set-selections <<< "keyboard-configuration keyboard-configuration/layout select Portuguese"
debconf-set-selections <<< "keyboard-configuration keyboard-configuration/layoutcode select pt"
dpkg-reconfigure -f noninteractive keyboard-configuration

useradd -m aluno -s /bin/bash
echo "aluno:v4gr4n1"|chpasswd
echo 'root:v4gr4n1' | chpasswd

echo -e "\nConfigurando o layout do teclado para br-abnt2..."
localectl set-keymap br-abnt2

echo -e "\nAtualizando a configuração do sistema..."
localectl

shutdown now