#!/bin/bash

SEPARATOR="══════════════════════════════════════════════════════════════════════════════════"

# Variáveis do Serviço da Aplicação Web
APP_IMAGE_NAME="oberon-app-web"
APP_CONTAINER_NAME="oberon-web-c"
APP_PORT="80" 

# Configurações do Build:
DOCKERFILE_PATH="Oberon-Config-AWS/Docker/site/Dockerfile" 
BUILD_CONTEXT="." 

print_header() {
    echo ""
    echo "$SEPARATOR"
    echo "║  $1"
    echo "$SEPARATOR"
    echo ""
}

run_web() {
    print_header "SETUP: INICIANDO APLICAÇÃO WEB"

    # 1. Limpeza de Containers
    echo "-> 1/3: Garantindo containers limpos..."
    # Os nomes de container $DB_CONTAINER_NAME e $DB_CONTAINER_NAME devem ser removidos se não forem usados
    # Omissão da limpeza aqui para focar no build.

    # 2. Build da Imagem
    echo "-> 2/3: Construindo imagem da Aplicação Web: $APP_IMAGE_NAME"
    echo "-> Usando Dockerfile em: $DOCKERFILE_PATH"
    
    # Execução do build:
    cd ~
    
    # CORREÇÃO: Usando a variável APP_IMAGE_NAME e citando todas as variáveis
    sudo docker build \
        -t "$APP_IMAGE_NAME" \
        -f "$DOCKERFILE_PATH" \
        .

    if [ $? -ne 0 ]; then
        echo "ERRO: Falha na construção da imagem da Web. Abortando."
        cd "$PROJECT_ROOT" 
        return 1
    fi

    # 3. Execução do Container (A ser implementada)
    # ...
    
    print_header "APLICAÇÃO WEB INICIADA"
    echo "Aplicação acessível em: http://localhost:$APP_PORT"
}

run_web