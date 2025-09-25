#!/bin/bash

# --- Variáveis de configuração ---
# Substitua com a URL do seu repositório
REPO_URL="https://github.com/oberon-sis/Oberon-Aplicacao-Web.git"

# Substitua com o nome do seu repositório
REPO_NAME="Oberon-Aplicacao-Web"

# Substitua com o nome do script que configura o banco de dados dentro do seu repositório
DB_SCRIPT_NAME="init.sh"

# --- Script principal ---
# Cria a pasta 'oberon' se ela não existir
echo "Criando a pasta 'oberon'..."
cd ..
mkdir -p oberon

# Entra na pasta 'oberon'
cd oberon

# Clona o repositório
echo "Clonando o repositório '$REPO_NAME'..."
git clone $REPO_URL

# Entra no diretório do repositório clonado
cd $REPO_NAME

# Pergunta ao usuário se ele deseja criar o ambiente do banco
echo ""
read -p "Deseja criar o ambiente do banco de dados agora? (S/N): " confirm_db_setup

if [[ "$confirm_db_setup" =~ ^[Ss]$ ]]; then
    # Verifica se o script de configuração do banco de dados existe e o executa
    if [ -f "$DB_SCRIPT_NAME" ]; then
        echo "Executando o script de configuração do banco de dados '$DB_SCRIPT_NAME'..."
        chmod +x "$DB_SCRIPT_NAME"  # Garante que o script seja executável
        ./$DB_SCRIPT_NAME
    else
        echo "Erro: O script '$DB_SCRIPT_NAME' não foi encontrado."
    fi
else
    echo "Operação cancelada. O ambiente do banco de dados não foi criado."
fi

echo "Processo finalizado."