#!/bin/bash

SEPARATOR="══════════════════════════════════════════════════════════════════════════════════"

REPO_NAME="oberon"
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

check_and_clone_repo() {
    print_header "VERIFICAÇÃO DE AMBIENTE E CLONAGEM"

    echo "-> Iniciando verificação a partir de: $(pwd)"

    if [ -d "$TARGET_DIR" ]; then
        echo "-> Diretório '$TARGET_DIR' encontrado. Navegando..."
        cd "$TARGET_DIR"
        echo "-> Diretório atual: $(pwd)"
    else
        echo "ERRO: O diretório '$TARGET_DIR' não foi encontrado em sua Home (~)."
        echo "Por favor, execute o setup inicial (init.sh) para criar a pasta."
        exit 1 
    fi

    # 2. Lógica de Clonagem (dentro de ~/oberon)
    print_header "CLONAGEM DO REPOSITÓRIO: $REPO_NAME"

    if [ -d "$REPO_NAME" ]; then
        echo "-> Repositório '$REPO_NAME' já existe. Nenhuma ação de clonagem necessária."
    else
        echo "-> Clonando repositório '$REPO_NAME' de $REPO_URL..."
        git clone "$REPO_URL"
        
        if [ $? -ne 0 ]; then
            echo "ERRO: Falha ao clonar o repositório. Abortando provisão."
            cd .. # Volta para a Home antes de falhar
            exit 1
        fi
    fi

    # 3. Retorno para o diretório Home (Mantém o fluxo limpo)
    cd ~
    echo ""
    echo "CLONAGEM CONCLUÍDA. Retornando ao diretório: $(pwd)"
}

# Execução do Script
check_and_clone_repo