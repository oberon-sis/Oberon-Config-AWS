#!/bin/bash

SEPARATOR="══════════════════════════════════════════════════════════════════════════════════"

# Variáveis do Serviço de Banco de Dados
DB_IMAGE_NAME="minha-image-banco" # Nome de imagem usado no material
DB_CONTAINER_NAME="meu-container" # Nome de container usado no material
NETWORK_NAME="oberon-net"
ROOT_PASSWORD="urubu100" # Senha de root definida no Dockerfile [cite: 80]

print_header() {
    echo ""
    echo "$SEPARATOR"
    echo "║  $1"
    echo "$SEPARATOR"
    echo ""
}

run_db() {
    print_header "SETUP: INICIANDO BANCO DE DADOS (MYSQL)"

    # 1. Limpeza e Rede (Garantindo um início limpo)
    echo "-> 1/3: Garantindo rede e containers limpos..."
    sudo docker stop $DB_CONTAINER_NAME 2> /dev/null
    sudo docker rm $DB_CONTAINER_NAME 2> /dev/null
    sudo docker network rm $NETWORK_NAME 2> /dev/null
    
    # Cria a rede para comunicação
    sudo docker network create $NETWORK_NAME
    echo "-> Rede '$NETWORK_NAME' criada com sucesso."

    # 2. Build da Imagem
    # Construir a imagem usando o Dockerfile no diretório atual [cite: 106]
    echo "-> 2/3: Construindo imagem '$DB_IMAGE_NAME' a partir do Dockerfile..."
    # A tag usada no material é 'minha-image-banco' [cite: 107]
    sudo docker build -t $DB_IMAGE_NAME .

    if [ $? -ne 0 ]; then
        echo "ERRO: Falha na construção da imagem '$DB_IMAGE_NAME'. Abortando."
        return 1
    fi

    # 3. Execução do Container
    # Inicia o container, mapeando a porta 3306 e usando o nome 'meu-container' [cite: 110]
    echo "-> 3/3: Iniciando container '$DB_CONTAINER_NAME'..."
    sudo docker run -d \
        --name $DB_CONTAINER_NAME \
        --network $NETWORK_NAME \
        -p 3306:3306 \
        -e MYSQL_ROOT_PASSWORD=$ROOT_PASSWORD \
        $DB_IMAGE_NAME

    if [ $? -ne 0 ]; then
        echo "ERRO: Falha ao iniciar o container do DB. Verifique os logs."
        return 1
    fi

    print_header "BANCO DE DADOS INICIADO"
    echo "Container: $DB_CONTAINER_NAME rodando na rede '$NETWORK_NAME'."
    echo "Porta Mapeada: 3306 -> 3306"
    echo "Para verificar o status: sudo docker ps -a"
}

run_db