#!/bin/bash

echo "--- Instalação do MySQL no Ubuntu ---"

# Atualiza a lista de pacotes
echo "Atualizando a lista de pacotes..."
sudo apt update

# Instala o MySQL Server
echo "Instalando o MySQL Server..."
sudo apt install -y mysql-server

# Verifica se a instalação foi bem-sucedida
if [ $? -eq 0 ]; then
    echo "MySQL instalado com sucesso!"
    echo "Agora, execute o script de configuração."
else
    echo "Erro: A instalação do MySQL falhou."
fi