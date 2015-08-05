#!/bin/sh

# Mensagens
echo "=================================================================="
echo "Bem Vindo ao Script de Criacao de SWAP - EdisonCosta"
echo " SWAP para Vultr.com - Tamanho padao de 2G."
echo "Este script de instalacao cria automaticamente um arquivo de swap."
echo "=================================================================="
echo ""

# Inicia script
dd if=/dev/zero of=/swapfile count=2048 bs=1M
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo "/swapfile   none    swap    sw    0   0" | tee /etc/fstab -a
sysctl vm.swappiness=10
echo "vm.swappiness=10" | tee /etc/sysctl.conf -a
sysctl vm.vfs_cache_pressure=50
echo "vm.vfs_cache_pressure=50" | tee /etc/sysctl.conf -a

# Finalizado
echo ""
echo "=============================================================="
echo "Finalizado! Para aplicar as alteracoes reinicie o Servidor:"
echo "$ reboot now"
echo "=============================================================="
echo ""
