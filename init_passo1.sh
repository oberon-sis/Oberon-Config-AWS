#!/bin/bash
echo ''
echo '----Script de configuração de ambiente da UPFINITY----'
echo ''
echo """
      ███████    ███████████  ██████████ ███████████      ███████    ██████   █████
    ███▒▒▒▒▒███ ▒▒███▒▒▒▒▒███▒▒███▒▒▒▒▒█▒▒███▒▒▒▒▒███   ███▒▒▒▒▒███ ▒▒██████ ▒▒███ 
  ███     ▒▒███ ▒███    ▒███ ▒███  █ ▒  ▒███    ▒███  ███     ▒▒███ ▒███▒███ ▒███ 
  ▒███      ▒███ ▒██████████  ▒██████    ▒██████████  ▒███      ▒███ ▒███▒▒███▒███ 
  ▒███      ▒███ ▒███▒▒▒▒▒███ ▒███▒▒█    ▒███▒▒▒▒▒███ ▒███      ▒███ ▒███ ▒▒██████ 
  ▒▒███     ███  ▒███    ▒███ ▒███ ▒   █ ▒███    ▒███ ▒▒███     ███  ▒███  ▒▒█████ 
  ▒▒▒███████▒   ███████████  ██████████ █████   █████ ▒▒▒███████▒   █████  ▒▒█████
    ▒▒▒▒▒▒▒    ▒▒▒▒▒▒▒▒▒▒▒  ▒▒▒▒▒▒▒▒▒▒ ▒▒▒▒▒   ▒▒▒▒▒    ▒▒▒▒▒▒▒    ▒▒▒▒▒    ▒▒▒▒▒     
    
    ║══════════════════════════════════════════════════════════════════════════════════╣
    ║                CONFIGURAÇÃO DO AMBIENTE VIRTUAL DA OBERON                        ║
    ║══════════════════════════════════════════════════════════════════════════════════╣
    """
echo 'Informe as credenciais para criação do ambiente'
echo ''
echo ''


read -p 'Clonar o repositorio do Projeto de pi - site ? (S/N)' RESPOSTA
if [ "$RESPOSTA" = "S" ] || [ "$RESPOSTA" = "s" ]; then
    echo 'Clonando repositorio de site...'
    source web-site/clon_repo.sh
else
    echo 'Clone de site foi interrompida'
fi
echo ''

echo ''
echo "Criando configurações do env"
echo "Configure arquivo de configuração '.env' abaixo"
echo ''

echo ''
echo "Credenciais de acesso ao MySql Server"
read -p "Insira o ip do host: " HOST
read -p "Insira o user para inserção no banco: " USER
read -p "Insira a senha do user $USER: " SENHA
echo ''
read -p "Insira o database: " DATABASE
echo ''

cat > '.env' <<EOF
HOST_DB = '$HOST'
USER_DB = '$USER'
PASSWORD_DB = '$SENHA'
DATABASE_DB = '$DATABASE'
EOF

echo ''
echo 'As credenciais configuradas são:'
echo '--------------------------------'
cat '.env'
echo '--------------------------------'
