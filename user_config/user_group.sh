#!/bin/bash

# Este script cria grupos e usuários, e os associa aos grupos.
# Use este script com cuidado e com as permissões de superusuário (sudo).

echo "--- Configuração de Usuários e Grupos ---"

# --- Criação de grupos ---
echo "Criando grupos..."
# O grupo 'admin' não é criado, pois o usuário 'nathan' será adicionado diretamente ao grupo 'sudo'.
sudo groupadd infra
sudo groupadd banco_de_dados
sudo groupadd desenvolvedor

# --- Criação de usuários e associação a grupos ---
echo "Criando usuários e os associando a grupos..."

# Exemplo de usuário de desenvolvimento
# useradd -m cria o diretório home do usuário se ele não existir
# -g define o grupo principal
# -G define grupos secundários
sudo useradd -m -g desenvolvedor -G sudo,infra,banco_de_dados -s /bin/bash -c "Nathan" nathan
echo "nathan:sua_senha_aqui" | sudo chpasswd
echo "Usuário nathan criado e adicionado aos grupos desenvolvedor, infra, sudo e banco_de_dados."

# Exemplo de usuário de infraestrutura
sudo useradd -m -g infra -G desenvolvedor,banco_de_dados -s /bin/bash -c "Jhoel" jhoel
echo "jhoel:sua_senha_aqui" | sudo chpasswd
echo "Usuário jhoel criado e adicionado aos grupos infra, desenvolvedor e banco_de_dados."

# Exemplo de usuário de banco de dados
sudo useradd -m -g banco_de_dados -G desenvolvedor -s /bin/bash -c "Dandara" dandara
echo "dandara:sua_senha_aqui" | sudo chpasswd
echo "Usuário dandara criado e adicionado aos grupos banco_de_dados e desenvolvedor."

# Exemplo de usuário de desenvolvimento
sudo useradd -m -g desenvolvedor -G infra -s /bin/bash -c "Miguel" miguel
echo "miguel:sua_senha_aqui" | sudo chpasswd
echo "Usuário miguel criado e adicionado aos grupos desenvolvedor e infra."

# Exemplo de usuário de desenvolvimento
sudo useradd -m -g desenvolvedor -s /bin/bash -c "Bruna" bruna
echo "bruna:sua_senha_aqui" | sudo chpasswd
echo "Usuário bruna criado e adicionado ao grupo desenvolvedor."

# Adicionando o usuário Pedro
sudo useradd -m -g desenvolvedor -s /bin/bash -c "Pedro" pedro
echo "pedro:sua_senha_aqui" | sudo chpasswd
echo "Usuário pedro criado e adicionado ao grupo desenvolvedor."


echo "--- Verificação ---"
echo "Verificando os grupos criados:"
getent group infra
getent group banco_de_dados
getent group desenvolvedor
# Não há mais verificação para o grupo 'admin'

echo "Verificando os usuários criados:"
id nathan
id jhoel
id miguel
id dandara
id bruna
id pedro

echo "Configuração de usuários e grupos concluída."