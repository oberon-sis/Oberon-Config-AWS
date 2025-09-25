#!/bin/bash

SEPARATOR="══════════════════════════════════════════════════════════════════════════════════"
TARGET_DIR="oberon" 

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

create_target_directory() {
    print_header "SETUP INICIAL DE DIRETÓRIOS"
    
    read -p "O diretório '$TARGET_DIR' será criado em sua home (~/$TARGET_DIR). Continuar? (S/N): " RESPOSTA
    if [[ "$RESPOSTA" =~ ^[Ss]$ ]]; then
        mkdir -p "$TARGET_DIR"
        echo "-> Diretório '$TARGET_DIR' criado ou já existente."
        cd "$TARGET_DIR" 
        echo "-> Diretório atual: $(pwd)"
    else
        echo "-> Criação de diretório cancelada. Abortando Setup."
        exit 1
    fi
}

function create_users_and_permissions() {
    print_header "CRIAÇÃO DE USUÁRIOS E PERMISSÕES"
    read -p 'Criar usuários da Oberon? (S/N): ' RESPOSTA
    
    if [[ "$RESPOSTA" =~ ^[Ss]$ ]]; then
        echo '-> Criando e configurando usuários...'
        cd .. 
        source user-config/user.sh
        cd "$TARGET_DIR"
        echo '-> Configuração de usuários concluída.'
    else
        echo '-> Criação de usuários foi ignorada.'
    fi
}

function clone_repository() {
    print_header "CLONAGEM DE REPOSITÓRIOS - WEB"
    read -p 'Clonar o repositório da Oberon-Aplicação-Web? (S/N): ' RESPOSTA
    
    if [[ "$RESPOSTA" =~ ^[Ss]$ ]]; then
        echo '-> Clonando repositório de site...'
        source ../web-site/clon_repo.sh
        echo '-> Clonagem concluída.'
    else
        echo '-> Clonagem de site foi ignorada.'
    fi
}

function clone_repository_banco() {
    print_header "CLONAGEM DE REPOSITÓRIOS - BANCO DE DADOS"
    read -p 'Clonar o repositório da Oberon-Banco-De-Dados? (S/N): ' RESPOSTA
    
    if [[ "$RESPOSTA" =~ ^[Ss]$ ]]; then
        echo '-> Clonando repositório de banco de dados...'
        source ../database/clon_repo.sh
        echo '-> Clonagem concluída.'
    else
        echo '-> Clonagem de banco de dados foi ignorada.'
    fi
}

function configure_env_files() {
    print_header "CONFIGURAÇÃO DE ARQUIVOS .ENV "
    read -p 'Configurar o .env e .env.dev? (S/N): ' RESPOSTA
    
    if [[ "$RESPOSTA" =~ ^[Ss]$ ]]; then
        echo '-> Configurando variáveis de ambiente...'
        source ../web-site/config_env.sh 
        echo '-> Configuração de .env concluída.'
    else
        echo '-> Configuração de .env foi ignorada.'
    fi
}

function install_docker_prerequisites() {
    print_header "SETUP DE PRÉ-REQUISITOS DO HOST"
    
    read -p 'Verificar e instalar o Docker ? (S/N): ' RESPOSTA
    if [[ "$RESPOSTA" =~ ^[Ss]$ ]]; then
        echo '-> Verificando status do Docker...'
        source ../docker_config/docker_config.sh
        echo '-> Verificação de Docker concluída.'
    else
        echo '-> Verificação de Docker foi ignorada.'
    fi
}

print_separator
echo "║             SCRIPT DE CONFIGURAÇÃO INICIAL DA OBERON                     ║"
print_separator
echo """
      ███████    ███████████  ██████████ ███████████      ███████    ██████   █████
    ███▒▒▒▒▒███ ▒▒███▒▒▒▒▒███▒▒███▒▒▒▒▒█▒▒███▒▒▒▒▒███   ███▒▒▒▒▒███ ▒▒██████ ▒▒███ 
  ███     ▒▒███ ▒███    ▒███ ▒███  █ ▒  ▒███    ▒███  ███     ▒▒███ ▒███▒███ ▒███ 
  ▒███      ▒███ ▒██████████  ▒██████    ▒██████████  ▒███      ▒███ ▒███▒▒███▒███ 
  ▒███      ▒███ ▒███▒▒▒▒▒███ ▒███▒▒█    ▒███▒▒▒▒▒███ ▒███      ▒███ ▒███ ▒▒██████ 
  ▒▒███     ███  ▒███    ▒███ ▒███ ▒   █ ▒███    ▒███ ▒▒███     ███  ▒███  ▒▒█████ 
  ▒▒▒███████▒   ███████████  ██████████ █████   █████ ▒▒▒███████▒   █████  ▒▒█████
    ▒▒▒▒▒▒▒    ▒▒▒▒▒▒▒▒▒▒▒  ▒▒▒▒▒▒▒▒▒▒ ▒▒▒▒▒   ▒▒▒▒▒    ▒▒▒▒▒▒▒    ▒▒▒▒▒    ▒▒▒▒▒    
"""
print_separator
echo "║             CONFIGURAÇÃO DO AMBIENTE VIRTUAL DA OBERON                     ║"
print_separator

cd ~ 

create_target_directory
# create_users_and_permissions
clone_repository
clone_repository_banco
configure_env_files
install_docker_prerequisites

print_header "FINALIZAÇÃO DO SETUP"
echo "O script de configuração foi concluído. Verifique o output para erros."
echo "Os repositórios foram clonados em (~/$TARGET_DIR)."
echo "Próximo passo: Use 'docker compose up' para iniciar os serviços!"
print_separator

