#!/bin/bash

echo "--- Instalação do node no Ubuntu ---"

# Atualiza a lista de pacotes
echo "Atualizando a lista de pacotes..."
sudo apt update

# Instala o node Server
echo "Instalando o node Server..."
sudo apt update && sudo apt upgrade -y 
sudo apt install -y nodejs

# Verifica se a instalação foi bem-sucedida
if [ $? -eq 0 ]; then
    echo "node instalado com sucesso!"
    echo "Agora, execute o script de configuração."
else
    echo "Erro: A instalação do node falhou."
fi