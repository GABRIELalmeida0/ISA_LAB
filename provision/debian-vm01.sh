#!/bin/bash

apt -y update && apt upgrade 
apt install net-tools
apt install -y vim-common tzdata
timedatectl set-timezone America/Sao_Paulo

useradd -m aluno01
echo "aluno01:ifrn"|chpasswd