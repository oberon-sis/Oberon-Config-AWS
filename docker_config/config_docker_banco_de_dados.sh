#!/bin/bash

SEPARATOR="══════════════════════════════════════════════════════════════════════════════════"

DB_IMAGE_NAME="oberon-banco-image"
DB_CONTAINER_NAME="oberon-banco-c"
ROOT_PASSWORD="urubu100"

# O caminho para o Dockerfile do banco de dados, a partir da raiz do projeto
DOCKERFILE_PATH="Oberon-Config-AWS/Docker/banco_de_dados/Dockerfile" 
# NOTA: O PROJECT_ROOT deve ser definido no init.sh e herdado aqui.

print_header() {
    echo ""
    echo "$SEPARATOR"
    echo "║  $1"
    echo "$SEPARATOR"
    echo ""
}

run_db() {
    print_header "SETUP: INICIANDO BANCO DE DADOS (MYSQL)"

    echo "-> 1/3: Garantindo containers limpos..."
    sudo docker stop $DB_CONTAINER_NAME 2> /dev/null
    sudo docker rm $DB_CONTAINER_NAME 2> /dev/null

    echo "-> 2/3: Construindo imagem '$DB_IMAGE_NAME' a partir do Dockerfile..."
    
    # AÇÃO CRÍTICA: Muda o diretório de trabalho para a HOME (Contexto)
    cd ~
    
    # Execução do build com Contexto = Home (.), resolvendo o problema do COPY
    sudo docker build -t $DB_IMAGE_NAME -f $DOCKERFILE_PATH .

    if [ $? -ne 0 ]; then
        echo "ERRO: Falha na construção da imagem '$DB_IMAGE_NAME'. Abortando."
        # RESTAURAÇÃO DE FLUXO ANTES DE FALHAR
        cd "$PROJECT_ROOT" 
        return 1
    fi

    echo "-> 3/3: Iniciando container '$DB_CONTAINER_NAME' na rede padrão..."
    sudo docker run -d \
        --name $DB_CONTAINER_NAME \
        -p 3306:3306 \
        -e MYSQL_ROOT_PASSWORD=$ROOT_PASSWORD \
        $DB_IMAGE_NAME

    if [ $? -ne 0 ]; then
        echo "ERRO: Falha ao iniciar o container do DB. Verifique os logs."
        return 1
    fi
    
    # RESTAURAÇÃO DE FLUXO: VOLTA PARA A RAIZ DO PROJETO ANTES DE TERMINAR
    cd "$PROJECT_ROOT" 

    print_header "BANCO DE DADOS INICIADO"
    echo "Container: $DB_CONTAINER_NAME rodando na rede padrão (bridge)."
    echo "Porta Mapeada: 3306 -> 3306"
    echo "Para verificar o status: sudo docker ps -a"
}

run_db