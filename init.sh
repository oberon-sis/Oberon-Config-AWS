#!/bin/bash


SEPARATOR="══════════════════════════════════════════════════════════════════════════════════"
# TARGET_DIR agora é global e centraliza o nome da pasta
TARGET_DIR="oberon" 

PROJECT_ROOT=$(pwd) 

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
        echo "-> Diretório atual: $(pwd)"
    else
        echo "-> Criação de diretório cancelada. Abortando Setup."
    fi
}

function create_users_and_permissions() {
    print_header "CRIAÇÃO DE USUÁRIOS E PERMISSÕES"
    read -p 'Criar usuários da Oberon? (S/N): ' RESPOSTA
    
    if [[ "$RESPOSTA" =~ ^[Ss]$ ]]; then
        echo '-> Criando e configurando usuários...'
        source "Oberon-Config-AWS/user_config/user_group.sh" #
        echo '-> Configuração de usuários concluída.'
    else
        echo '-> Criação de usuários foi ignorada.'
    fi
    # NOTA: Não é necessário 'cd ..' e 'cd $TARGET_DIR' aqui, pois não alteramos o diretório de trabalho.
}

function clone_repository() {
    print_header "CLONAGEM DE REPOSITÓRIOS - WEB"
    read -p 'Clonar o repositório da Oberon-Aplicação-Web? (S/N): ' RESPOSTA
    
    if [[ "$RESPOSTA" =~ ^[Ss]$ ]]; then
        echo '-> Clonando repositório de site...'
        source "Oberon-Config-AWS/web-site/clon_repo.sh"
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
        source "Oberon-Config-AWS/database/clon_repo.sh"
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
        source "Oberon-Config-AWS/web-site/config_env.sh"
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
        source "Oberon-Config-AWS/docker_config/docker_config.sh"
        echo '-> Verificação de Docker concluída.'
    else
        echo '-> Verificação de Docker foi ignorada.'
    fi
}

function run_container_banco() {
    print_header "INICIANDO CONTAINER DE BANCO DE DADOS"
    read -p 'Criar e iniciar o container do Banco de Dados? (S/N): ' RESPOSTA
    
    if [[ "$RESPOSTA" =~ ^[Ss]$ ]]; then
        echo '-> Construindo e iniciando container do DB...'
        cd
        source "Oberon-Config-AWS/docker_config/config_docker_banco_de_dados.sh"
        echo '-> Container do DB iniciado.'
    else
        echo '-> Container do DB ignorado.'
    fi
}

function run_container_site() {
    print_header "INICIANDO CONTAINER DA APLICAÇÃO WEB"
    
    read -p 'Criar e iniciar o container da Aplicação Web? (S/N): ' RESPOSTA
    if [[ "$RESPOSTA" =~ ^[Ss]$ ]]; then
        echo '-> Construindo e iniciando container do Site...'
        cd
        source "Oberon-Config-AWS/docker_config/config_docker_site.sh"
        echo '-> Container do Site iniciado.'
    else
        echo '-> Container do Site ignorado.'
    fi
}

print_separator
echo "║             SCRIPT DE CONFIGURAÇÃO INICIAL DA OBERON                     ║"
print_separator
echo """
      ███████     ███████████  ██████████ ███████████        ███████     ██████   █████
    ███▒▒▒▒▒███ ▒▒███▒▒▒▒▒███▒▒███▒▒▒▒▒█▒▒███▒▒▒▒▒███    ███▒▒▒▒▒███ ▒▒██████ ▒▒███ 
  ███     ▒▒███ ▒███    ▒███ ▒███  █ ▒  ▒███    ▒███  ███     ▒▒███ ▒███▒███ ▒███ 
  ▒███      ▒███ ▒██████████  ▒██████    ▒██████████  ▒███      ▒███ ▒███▒▒███▒███ 
  ▒███      ▒███ ▒███▒▒▒▒▒███ ▒███▒▒█    ▒███▒▒▒▒▒███ ▒███      ▒███ ▒███ ▒▒██████ 
  ▒▒███     ███  ▒███    ▒███ ▒███ ▒  █ ▒███    ▒███ ▒▒███     ███  ▒███  ▒▒█████ 
  ▒▒▒███████▒  ███████████  ██████████ █████  █████ ▒▒▒███████▒  █████  ▒▒█████
    ▒▒▒▒▒▒▒    ▒▒▒▒▒▒▒▒▒▒▒  ▒▒▒▒▒▒▒▒▒▒ ▒▒▒▒▒  ▒▒▒▒▒    ▒▒▒▒▒▒▒    ▒▒▒▒▒    ▒▒▒▒▒    
"""
print_separator
echo "║             CONFIGURAÇÃO DO AMBIENTE VIRTUAL DA OBERON                     ║"
print_separator

cd ~ 
create_target_directory # Cria e navega para ~/oberon

# 2. FLUXO DE SETUP
clone_repository
clone_repository_banco
configure_env_files

install_docker_prerequisites 

cd "$PROJECT_ROOT" 

run_container_banco
run_container_site

print_header "FINALIZAÇÃO DO SETUP"
echo "O script de configuração foi concluído. Verifique o output para erros."
echo "Os repositórios foram clonados em (~/$TARGET_DIR)."
echo "Próximo passo: Use os comandos de start (run_db.sh e run_web.sh) para iniciar os serviços!"
print_separator
