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

read -p 'Baixar node? (S/N)' RESPOSTA
if [ "$RESPOSTA" = "S" ] || [ "$RESPOSTA" = "s" ]; then
    echo 'Baixando o node...'
    source web-site/node_download.sh
else
    echo 'Clone de site foi interrompida'
fi
echo ''


read -p 'Configurar o env? (S/N)' RESPOSTA
if [ "$RESPOSTA" = "S" ] || [ "$RESPOSTA" = "s" ]; then
    echo 'Baixando o node...'
    source web-site/node_download.sh
else
    echo 'Clone de site foi interrompida'
fi
echo ''

cd 
cd Oberon-Config-AWS/Docker/site
sudo docker build -t minha-image-banco . 

