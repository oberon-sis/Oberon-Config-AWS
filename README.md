# Oberon - Config AWS

Este repositório contém os scripts e configurações para a infraestrutura do projeto Oberon na Amazon Web Services (AWS), focando no monitoramento de computadores de CFTV.

## 📋 Status do Projeto
✅ Em desenvolvimento

## Funcionalidades
O script principal (init.sh) automatiza todo o ciclo de vida do ambiente de desenvolvimento e produção.

### ⚙️ Provisionamento do Host e Setup de Sistema
- Instalação e Configuração: Realiza a instalação e configuração do ambiente em máquinas Ubuntu.

- Base de Diretórios: Executa a Criação de diretorios de trabalho essenciais.

- Provisionamento de Ferramentas: Gerencia o processo de Baixar docker e configuração (Instalação do Docker CE e plugins) no host.

- Segurança e Acesso: Suporta a Configuração de credenciais e segurança para acesso aos serviços AWS e a Criação e configuração de usuários e grupos de sistema.

### 💾 Gestão de Código e Configuração
- Clonagem de Repositórios: Suporta a Clonagem de repositórios privados, especificamente:

- Clonar repositorio da Oberon-Aplicacao-Web

- Clonar repositorio da Oberon-Banco-De-Dados

- Configuração de Ambiente: Gerencia a Configuração do arquivo .env para a aplicação web de forma interativa.

### 🐳 Construção e Execução de Containers
- Container do Banco de Dados: Automatiza a Criação de container com imagem da oberom para o banco de dados (Faz o build e o run do container MySQL).

- Container da Aplicação: Automatiza a Criação de container com imagem da oberom para a aplicação web (Faz o build e o run do container Web/Node.js).

##  Estrutura do Repositório
- `database/`: Contém os scripts de configuração do banco de dados e clonagem de repositórios.

- `init.sh`: O script principal para orquestrar a instalação e configuração do ambiente.

## Estrutura de Arquivos

Essa é a visualização da estrutura de pastas do seu repositório principal OBERON-CONFIG-AWS, padronizada para documentação, incluindo comentários sobre a função de cada diretório e script, conforme discutimos ao longo da nossa conversa.

    ---
    OBERON-CONFIG-AWS/
    │
    ├── database/ 					        # Scripts de suporte para o Banco de Dados
    │   ├── clon_repo_sprint1 copy.sh 	
    │   ├── clon_repo.sh 			        # Script de clonagem do repositório de Banco de Dados
    │   └── mysql_download.sh 		        # Script para instalação do MySQL no Host (via apt)
    │
    ├── Docker/ 					        # Definições de imagem Docker
    │   ├── banco_de_dados/
    │   │   └── Dockerfile 			        # Dockerfile para a imagem do MySQL customizada
    │   └── site/
    │       └── Dockerfile 			        # Dockerfile para a imagem Node.js/Web
    │
    ├── docker_config/ 				        # Scripts de Build e Run 
    │   ├── config_docker_banco_de_dados.sh # Script para Build e Run do Container DB
    │   ├── config_docker_site.sh 	        # Script para Build e Run do Container Web
    │   └── docker_config.sh 		        # Script para instalação do Docker (Provisionamento do Host)
    │
    ├── user_config/ 				        # Scripts de administração de usuários do sistema
    │   └── user_group.sh 			        # Script para criação de usuários e grupos no Host
    │
    ├── web-site/ 					        # Scripts de Setup e Clonagem da Aplicação Web
    │   ├── clon_repo.sh 			        # Script de clonagem do repositório Web
    │   ├── config_env.sh 			        # Script para configuração interativa de .env 
    │   └── node_download.sh 		        # Script de instalação de pré-requisitos Node.js/Host
    │
    ├── init_passo1.sh 				        # Setup: Passos antigos (Configuração da EC2 sem Containers)
    ├── init_passo2.sh 				        # Setup: Passos antigos (Configuração da EC2 com containers)
    ├── init.sh 					        # Script principal de orquestração e fluxo de setup (Configuração da EC2 com Dockerfile)
    └── README.md 					        # Documentação do repositório

## 🚀 Tecnologias
- Linguagem: Shell Script

- Plataforma: Ubuntu (Linux)

## 📌 Como usar
1- Clone este repositório para o seu ambiente local.

    git clone https://github.com/oberon-sis/Oberon-Config-AWS.git
    

2- Navegue até o diretório principal: 

    cd Oberon-Config-AWS

3- Execute o script principal: 

    ./init.sh.

Siga as instruções exibidas no terminal para: 



## 📖 Documentação
Mais detalhes sobre a arquitetura e as configurações na AWS estão disponíveis na documentação principal do projeto.

`Nota: Este repositório é privado e contém informações sensíveis de configuração. Não compartilhe publicamente.`


