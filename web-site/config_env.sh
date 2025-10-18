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

    cat > '.env' <<EOF
AMBIENTE_PROCESSO=producao

DB_HOST = 'localhost'
DB_DATABASE = 'bdOberon'
DB_USER = 'servidorOberon'
DB_PASSWORD = 'Urubu100'
DB_PORT = '3306'

APP_PORT = '80'
APP_HOST = 'localhost'
EOF

    cat > '.env.dev' <<EOF
AMBIENTE_PROCESSO=desenvolvimento

DB_HOST = 'localhost'
DB_DATABASE = 'bdOberon'
DB_USER = 'servidorOberon'
DB_PASSWORD = 'Urubu100'
DB_PORT = '3306'

APP_PORT = '80'
APP_HOST = 'localhost'
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