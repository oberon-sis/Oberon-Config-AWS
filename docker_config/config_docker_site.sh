#!/bin/bash

SEPARATOR="══════════════════════════════════════════════════════════════════════════════════"

APP_IMAGE_NAME="oberon-app-web"
APP_CONTAINER_NAME="oberon-web-c"
DB_CONTAINER_NAME="oberonWebContainer" 
NETWORK_NAME="oberon-net"
HOST_PORT="80" 

print_header() {
    echo ""
    echo "$SEPARATOR"
    echo "║  $1"
    echo "$SEPARATOR"
    echo ""
}

run_web() {
    print_header "SETUP: INICIANDO APLICAÇÃO WEB"

    # 1. Verificação de Dependência
    if ! sudo docker network ls | grep -q $NETWORK_NAME; then
        echo "ERRO: A rede '$NETWORK_NAME' não existe. Por favor, rode './run_db.sh' primeiro."
        return 1
    fi

    # 2. Limpeza
    echo "-> 1/3: Limpando containers anteriores..."
    sudo docker stop $APP_CONTAINER_NAME 2> /dev/null
    sudo docker rm $APP_CONTAINER_NAME 2> /dev/null

    # 3. Build da Imagem
    echo "-> 2/3: Construindo imagem da Aplicação Web: $APP_IMAGE_NAME"
    # Assumindo que o Dockerfile do App Web está na pasta 'web-site'
    sudo docker build -t $APP_IMAGE_NAME ./web-site

    if [ $? -ne 0 ]; then
        echo "ERRO: Falha na construção da imagem da Web. Abortando."
        return 1
    fi

    # 4. Execução do Container
    echo "-> 3/3: Iniciando container '$APP_CONTAINER_NAME'..."
    # O App se conecta ao DB usando o nome do container do DB ($DB_CONTAINER_NAME)
    sudo docker run -d \
        --name $APP_CONTAINER_NAME \
        --network $NETWORK_NAME \
        -p $HOST_PORT:80 \
        -e DB_HOST=$DB_CONTAINER_NAME \
        -e DB_PORT=3306 \
        $APP_IMAGE_NAME

    if [ $? -ne 0 ]; then
        echo "ERRO: Falha ao iniciar o container da Web. Verifique os logs."
        return 1
    fi

    print_header "APLICAÇÃO WEB INICIADA"
    echo "Aplicação acessível em: http://localhost:$HOST_PORT"
    echo "Para ver logs: sudo docker logs -f $APP_CONTAINER_NAME"
}

run_web