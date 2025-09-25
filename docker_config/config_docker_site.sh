#!/bin/bash

SEPARATOR="══════════════════════════════════════════════════════════════════════════════════"

# Variáveis do Serviço da Aplicação Web
APP_IMAGE_NAME="oberon-app-web"
APP_CONTAINER_NAME="oberon-web-c"
APP_PORT="80" 

# Configurações do Build:
DOCKERFILE_PATH="Docker/site/Dockerfile"
BUILD_CONTEXT="." # O contexto é a raiz do projeto (Oberon-Config-AWS)

print_header() {
    echo ""
    echo "$SEPARATOR"
    echo "║  $1"
    echo "$SEPARATOR"
    echo ""
}

run_web() {
    print_header "SETUP: INICIANDO APLICAÇÃO WEB"

    # 1. Limpeza de Containers (Omitido por brevidade no exemplo)
    
    # 2. Build da Imagem
    echo "-> 2/3: Construindo imagem da Aplicação Web: $APP_IMAGE_NAME"
    echo "-> Usando Dockerfile em: $DOCKERFILE_PATH"
    
    # Execução do build: -f aponta para o Dockerfile, e o '.' é o contexto (raiz)
    sudo docker build -t $APP_IMAGE_NAME -f $DOCKERFILE_PATH $BUILD_CONTEXT

    if [ $? -ne 0 ]; then
        echo "ERRO: Falha na construção da imagem da Web. Abortando."
        return 1
    fi

    # 3. Execução do Container (Omitido por brevidade no exemplo)
    # ... comandos de sudo docker run aqui ...

    print_header "APLICAÇÃO WEB INICIADA"
    echo "Aplicação acessível em: http://localhost:$APP_PORT"
}

run_web