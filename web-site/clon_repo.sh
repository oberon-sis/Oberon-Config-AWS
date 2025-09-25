#!/bin/bash

SEPARATOR="══════════════════════════════════════════════════════════════════════════════════"

# Variáveis do Repositório
TARGET_DIR="oberon" 
REPO_NAME="Oberon-Aplicacao-Web"

print_separator() {
    echo "║$SEPARATOR║"
}

print_header() {
    echo ""
    echo "$SEPARATOR"
    echo "║  $1"
    echo "$SEPARATOR"
    echo ""
}

configure_env_files() {
    local SUBTITULO="ENTRADA DE VARIÁVEIS DE AMBIENTE"

    print_header "CONFIGURAÇÃO DE ARQUIVOS .ENV"
    
    # 1. Validação e Navegação para o diretório TARGET_DIR/REPO_NAME
    
    # Navega para a pasta 'oberon' dentro da HOME
    if [ ! -d "$TARGET_DIR" ]; then
        echo "ERRO: O diretório '$TARGET_DIR' não foi encontrado. Execute o setup inicial."
        return 1
    fi
    cd "$TARGET_DIR"

    # Navega para o repositório Web DENTRO da pasta 'oberon'
    if [ ! -d "$REPO_NAME" ]; then
        echo "ERRO: O repositório '$REPO_NAME' não foi encontrado em '$(pwd)'."
        echo "-> Verifique se a clonagem da aplicação Web foi concluída com sucesso."
        cd .. # Retorna para a HOME antes de falhar
        return 1
    fi

    cd "$REPO_NAME"
    echo "-> Configurando .env no diretório: $(pwd)"

    print_header "$SUBTITULO"

    # 2. Entrada Interativa
    echo "Credenciais de acesso ao Banco de Dados e Aplicação"
    read -p "Insira o IP do host (ou nome do serviço Docker, ex: db): " HOST
    read -p "Insira o user para o banco: " USER
    read -p "Insira a senha do user $USER: " SENHA
    echo ""
    read -p "Insira o database: " DATABASE
    read -p "Insira a porta da aplicação: " PORTA
    read -p "Insira o IP/host da aplicação: " IP
    echo ""

    # 3. Cria o arquivo .env
    cat > '.env' <<EOF
HOST_DB = '$HOST'
USER_DB = '$USER'
PASSWORD_DB = '$SENHA'
DATABASE_DB = '$DATABASE'
APP_PORT = '$PORTA'
APP_HOST = '$IP'
EOF

    # 4. Cria o arquivo .env.dev
    cat > '.env.dev' <<EOF
HOST_DB = '$HOST'
USER_DB = '$USER'
PASSWORD_DB = '$SENHA'
DATABASE_DB = '$DATABASE'
APP_PORT = '$PORTA'
APP_HOST = '$IP'
EOF
    
    # 5. Output de Confirmação
    print_separator
    echo "║ As credenciais configuradas em '.env' e '.env.dev' são: "
    print_separator
    cat '.env'
    print_separator

    cd ~
    
    echo "CONFIGURAÇÃO CONCLUÍDA. DIRETÓRIO ATUAL: $(pwd)"
}

configure_env_files