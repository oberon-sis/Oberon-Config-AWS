#!/bin/bash

SEPARATOR="══════════════════════════════════════════════════════════════════════════════════"

REPO_URL="https://github.com/oberon-sis/Oberon-Banco-De-Dados.git"
REPO_NAME="Oberon-Banco-De-Dados"

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

clon_repo_bd() {
    print_header "CLONAGEM DE REPOSITÓRIO: $REPO_NAME"

    echo "-> Diretório atual para clonagem: $(pwd)"

    if [ -d "$REPO_NAME" ]; then
        echo "-> Repositório '$REPO_NAME' já existe. Nenhuma ação de clonagem necessária."
    else
        echo "-> Clonando repositório '$REPO_NAME' de $REPO_URL..."
        git clone "$REPO_URL"
        
        if [ $? -ne 0 ]; then
            echo "ERRO: Falha ao clonar o repositório. Abortando provisionamento."
            return 1
        fi
    fi

    echo ""
    echo "CLONAGEM CONCLUÍDA. Diretório de trabalho permanece: $(pwd)"
}

# Execução do Script
clon_repo_bd