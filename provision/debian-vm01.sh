#!/bin/bash

apt -y update && apt upgrade 
apt install -y vim-common net-tools tzdata keyboard-configuration

# Configuração do layout do teclado para br-abnt2
echo -e "\nConfigurando o layout do teclado para br-abnt2..."
debconf-set-selections <<< "keyboard-configuration keyboard-configuration/layout select Portuguese"
debconf-set-selections <<< "keyboard-configuration keyboard-configuration/layoutcode select pt"
dpkg-reconfigure -f noninteractive keyboard-configuration

useradd -m aluno -s /bin/bash
echo "aluno:ifrn"|chpasswd
echo 'root:ifrn' | chpasswd

echo -e "\nConfigurando o layout do teclado para br-abnt2..."
localectl set-keymap br-abnt2

echo -e "\nAtualizando a configuração do sistema..."
localectl

echo "Configurando o arquivo /etc/network/interfaces"

cat <<EOL > /etc/network/interfaces
auto lo
iface lo inet loopback

auto interface1
iface interface1 inet network

auto interface2
iface interface2 inet network

auto interface3
iface interface3 inet network
EOL

cat <<EOL > /etc/default/grub
# If you change this file, run 'update-grub' afterwards to update
# /boot/grub/grub.cfg.
# For full documentation of the options in this file, see:
#   info -f grub -n 'Simple configuration'

GRUB_DEFAULT=0
GRUB_TIMEOUT_STYLE=hidden
GRUB_TIMEOUT=0
GRUB_DISTRIBUTOR=`lsb_release -i -s 2> /dev/null || echo Debian`
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"
GRUB_CMDLINE_LINUX=""

# Uncomment to enable BadRAM filtering, modify to suit your needs
# This works with Linux (no patch required) and with any kernel that obtains
# the memory map information from GRUB (GNU Mach, kernel of FreeBSD ...)
#GRUB_BADRAM="0x01234567,0xfefefefe,0x89abcdef,0xefefefef"

# Uncomment to disable graphical terminal (grub-pc only)
#GRUB_TERMINAL=console

# The resolution used on graphical terminal
# note that you can use only modes which your graphic card supports via VBE
# you can see them in real GRUB with the command 'vbeinfo'
#GRUB_GFXMODE=640x480

# Uncomment if you don't want GRUB to pass "root=UUID=xxx" parameter to Linux
#GRUB_DISABLE_LINUX_UUID=true

# Uncomment to disable generation of recovery mode menu entries
#GRUB_DISABLE_RECOVERY="true"

# Uncomment to get a beep at grub start
#GRUB_INIT_TUNE="480 440 1"
EOL
update-grub