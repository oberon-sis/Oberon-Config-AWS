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
    local default_host="localhost"
    local db_host_input
    local app_host_input

    print_header "CONFIGURAÇÃO DE ARQUIVOS .ENV"
    
    if [ ! -d "$REPO_NAME" ]; then
        echo "ERRO: O diretório '$REPO_NAME' não foi encontrado. Por favor, clone-o primeiro."
        return 1
    fi
    
    # ----------------------------------------------------
    # 1. SOLICITAÇÃO DE ENTRADA DO USUÁRIO
    # ----------------------------------------------------
    print_header "$SUBTITULO"
    echo "Por favor, insira o HOST para o banco de dados e aplicação."
    echo "Se deixar em branco, será usado o valor padrão: '$default_host'"
    print_separator

    # Solicita o HOST do Banco de Dados (DB_HOST)
    read -r -p "║ DB_HOST (Padrão: $default_host): " db_host_input
    DB_HOST_CONFIG="${db_host_input:-$default_host}" # Usa a entrada ou o padrão se vazia

    # Solicita o HOST da Aplicação (APP_HOST)
    read -r -p "║ APP_HOST (Padrão: $default_host): " app_host_input
    APP_HOST_CONFIG="${app_host_input:-$default_host}" # Usa a entrada ou o padrão se vazia

    print_separator
    echo "║ DB_HOST configurado para: $DB_HOST_CONFIG"
    echo "║ APP_HOST configurado para: $APP_HOST_CONFIG"
    print_separator

    # ----------------------------------------------------
    # 2. GERAÇÃO DOS ARQUIVOS COM OS NOVOS VALORES
    # ----------------------------------------------------
    cd "$REPO_NAME"
    echo "-> Configurando .env no diretório: $(pwd)"

    # Arquivo .env (Produção)
    cat > '.env' <<EOF
AMBIENTE_PROCESSO=producao

DB_HOST = '$DB_HOST_CONFIG'
DB_DATABASE = 'bdOberon'
DB_USER = 'servidorOberon'
DB_PASSWORD = 'Urubu100'
DB_PORT = '3306'

APP_PORT = '80'
APP_HOST = '$APP_HOST_CONFIG'
EOF

    # Arquivo .env.dev (Desenvolvimento)
    cat > '.env.dev' <<EOF
AMBIENTE_PROCESSO=desenvolvimento

DB_HOST = '$DB_HOST_CONFIG'
DB_DATABASE = 'bdOberon'
DB_USER = 'servidorOberon'
DB_PASSWORD = 'Urubu100'
DB_PORT = '3306'

APP_PORT = '80'
APP_HOST = '$APP_HOST_CONFIG'
EOF
    
    # ----------------------------------------------------
    # 3. EXIBIÇÃO E FINALIZAÇÃO
    # ----------------------------------------------------
    print_separator
    echo "║ As credenciais configuradas em '.env' são: "
    print_separator
    cat '.env'
    print_separator

    cd ..
    echo "CONFIGURAÇÃO CONCLUÍDA. DIRETÓRIO ATUAL: $(pwd)"
}
# Execução do Script
configure_env_files