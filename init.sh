#!/bin/bash
echo ''
echo '----Script de configuração de ambiente da UPFINITY----'
echo ''
echo """
    ║══════════════════════════════════════════════════════════════════════════════════╣                                                                 
    ║             ██    ██ ██████  ███████ ██ ███    ██ ██ ████████ ██    ██           ║
    ║             ██    ██ ██   ██ ██      ██ ████   ██ ██    ██     ██  ██            ║
    ║             ██    ██ ██████  █████   ██ ██ ██  ██ ██    ██      ████             ║
    ║             ██    ██ ██      ██      ██ ██  ██ ██ ██    ██       ██              ║
    ║              ██████  ██      ██      ██ ██   ████ ██    ██       ██              ║
    ║══════════════════════════════════════════════════════════════════════════════════╣
    ║                CONFIGURAÇÃO DO AMBIENTE VIRTUAL DA UPFINITY                      ║
    ║══════════════════════════════════════════════════════════════════════════════════╣
    """
echo 'Informe as credenciais para criação do ambiente'
echo ''

echo ''
read -p 'Instalar o Mysql? (S/N)' RESPOSTA
if [ "$RESPOSTA" = "S" ] || [ "$RESPOSTA" = "s" ]; then
    echo 'Instalando o mysql ...'
    source database/mysql_download.sh
else
    echo 'Instalação do mysql foi cancelada'
fi
echo ''

echo ''
read -p 'Clonar o repositorio do banco de dados? (S/N)' RESPOSTA
if [ "$RESPOSTA" = "S" ] || [ "$RESPOSTA" = "s" ]; then
    echo 'Clonando repositorio de banco de dados...'
    source database/clon_repo.sh
else
    echo 'Clone de banco de dados foi interrompida'
fi
echo ''

echo ''
read -p 'Configurar os usuarios e grupos? (S/N)' RESPOSTA
if [ "$RESPOSTA" = "S" ] || [ "$RESPOSTA" = "s" ]; then
    echo 'Configurando os usuarios e grupos...'
    source user_config/user_group.sh
else
    echo 'Configuração dos usuarios e grupos foi interrompido'
fi
echo ''