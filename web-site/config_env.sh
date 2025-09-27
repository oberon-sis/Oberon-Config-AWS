#!/bin/bash

SEPARATOR="══════════════════════════════════════════════════════════════════════════════════"

REPO_NAME="oberon/Oberon-Aplicacao-Web"

print_separator() {
    echo "║$SEPARATOR║"
}

print_header() {
    echo "$SEPARATOR"
    echo "║  $1"
    echo "$SEPARATOR"
}

configure_env_files() {
    local SUBTITULO="ENTRADA DE VARIÁVEIS DE AMBIENTE"

    print_header "CONFIGURAÇÃO DE ARQUIVOS .ENV"
    
    if [ ! -d "$REPO_NAME" ]; then
        echo "ERRO: O diretório '$REPO_NAME' não foi encontrado. Por favor, clone-o primeiro."
        return 1
    fi

    cd "$REPO_NAME"
    echo "-> Configurando .env no diretório: $(pwd)"

    print_header "$SUBTITULO"

    echo "Credenciais de acesso ao Banco de Dados e Aplicação"
    read -p "Insira o ip do host [HOST_DB] : " HOST
    read -p "Insira o database [DATABASE_DB]: " DATABASE
    read -p "Insira o user para inserção no banco [USER_DB]: " USER
    read -p "Insira a senha do user $USER [PASSWORD_DB]: " SENHA
    read -p "Insira a porta da aplicação [PORT_DB]: " PORTA
    echo ""
    read -p "Insira a porta da aplicação [APP_HOST] : " PORTA_APP
    read -p "Insira o ip/host da aplicação [APP_HOST]: " IP
    echo ""

    cat > '.env' <<EOF
HOST_DB = '$HOST'
DATABASE_DB = '$DATABASE'
USER_DB = '$USER'
PASSWORD_DB = '$SENHA'
PORT_DB = '$PORTA'
APP_PORT = '$PORTA_APP'
APP_HOST = '$IP'
EOF

    cat > '.env.dev' <<EOF
HOST_DB = '$HOST'
DATABASE_DB = '$DATABASE'
USER_DB = '$USER'
PASSWORD_DB = '$SENHA'
PORT_DB = '$PORTA'
APP_PORT = '$PORTA_APP'
APP_HOST = '$IP'
EOF
    
    print_separator
    echo "║ As credenciais configuradas em '.env' e '.env.dev' são: "
    print_separator
    cat '.env'
    print_separator

    cd ..
    echo "CONFIGURAÇÃO CONCLUÍDA. DIRETÓRIO ATUAL: $(pwd)"
}

# Execução do Script
configure_env_files