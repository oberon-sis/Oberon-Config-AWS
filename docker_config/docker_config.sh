#!/bin/bash

SEPARATOR="══════════════════════════════════════════════════════════════════════════════════"

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

install_docker() {
    print_header "SETUP DE INSTALAÇÃO DO DOCKER E COMPOSE"

    echo "-> Atualizando e instalando dependências iniciais..."
    sudo apt update
    sudo apt upgrade -y
    sudo apt install -y ca-certificates curl gnupg lsb-release

    echo "-> Adicionando chave GPG oficial do Docker e repositório..."
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    echo "-> Instalando Docker CE, Containerd e Compose Plugin..."
    sudo apt update
    sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    print_header "FINALIZAÇÃO DA INSTALAÇÃO"

    if command -v docker &> /dev/null; then
        echo "Docker instalado com sucesso. Versão: $(sudo docker --version)"
        echo ""
        echo "===================================================================================="
        echo "AVISO: O Docker foi configurado para **exigir o uso de 'sudo'**."
        echo "       Para executar, use: sudo docker [comando]"
        echo "===================================================================================="
    else
        echo "ERRO: A instalação do Docker pode ter falhado."
    fi
}

install_docker