#!/bin/sh

# Checa Parametros vazios
if [ ! "$#" -ge 1 ]; then
    echo "Parametros: $0 {size}"
    echo "Exemplo: $0 2G"
    echo "Path opcional: Parametros: $0 {size} {path}"
    exit 1
fi


# Mensagens
echo "=========================================================="
echo "Bem Vindo ao Script de Criação de SWAP - EdisonCosta"
echo "Este script de instalação cria automaticamente um arquivo de swap."
echo "=========================================================="
echo ""

# Setup variaveis
SWAP_SIZE=$1
SWAP_PATH="/swapfile"
if [ ! -z "$2" ]; then
    SWAP_PATH=$2
fi


# Inicia script
sudo fallocate -l $SWAP_SIZE $SWAP_PATH
sudo chmod 600 $SWAP_PATH
sudo mkswap $SWAP_PATH
sudo swapon $SWAP_PATH
echo "$SWAP_PATH   none    swap    sw    0   0" | sudo tee /etc/fstab -a
sudo sysctl vm.swappiness=10
echo "vm.swappiness=10" | sudo tee /etc/sysctl.conf -a
sudo sysctl vm.vfs_cache_pressure=50
echo "vm.vfs_cache_pressure=50" | sudo tee /etc/sysctl.conf -a


# Finalizado
echo ""
echo "=========================================================="
echo "Finalizado! Para aplicar as alterações reinicie o Servidor:"
echo "$ reboot now"
echo "=========================================================="
echo ""
