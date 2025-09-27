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

## 🚀 Como Usar o Oberon-Config-AWS

Para que o script funcione corretamente, é **obrigatório** que o **AWS Command Line Interface (AWS CLI)** esteja instalado e configurado em seu ambiente local com as credenciais (Access Keys) e permissões de IAM adequadas para a criação dos recursos na AWS.

### 🔒 Configuração de Acesso (Security Groups)
Para que o Oberon consiga se comunicar e operar corretamente com os recursos da AWS (como instâncias EC2, bancos de dados, etc.), é fundamental que as seguintes portas estejam habilitadas nas regras de entrada (Inbound Rules) dos seus Security Groups (SGs).

Você deve garantir que os Security Groups associados aos seus recursos permitam o tráfego de entrada (Inbound) nas portas e protocolos listados abaixo, a partir da origem que for necessária:

| Tipo de Tráfego | Protocolo | Porta | Descrição (Baseado na infraestrutura) |
| :--- | :--- | :--- | :--- |
| **HTTP** | TCP | **80** | Acesso web padrão (para um balanceador de carga ou servidor web, por exemplo). |
| **MySQL/Aurora** | TCP | **3306** | Conexão com o banco de dados MySQL ou Amazon Aurora. **Restrinja a origem!** |
| **SSH** | TCP | **22** | Acesso seguro ao shell do servidor (Linux/EC2). **Restrinja a origem!** |



1. Clonar o Repositório

Abra seu terminal e clone o projeto para o seu ambiente local:

    git clone https://github.com/oberon-sis/Oberon-Config-AWS.git

2. Navegar até o Diretório
Acesse o diretório principal do projeto clonado:
````bash
    cd Oberon-Config-AWS
`````


3. Executar o Script de Inicialização
Execute o script principal (init.sh). Este script irá guiar você através do processo de configuração:
````bash
    ./init.sh
`````


****Siga as instruções exibidas no terminal para fornecer os parâmetros e credenciais necessários para a criação dos recursos AWS.****



⚠️ Aviso de Segurança

Restrição de Origem é Crítica: É uma prática de segurança obrigatória restringir o campo "Origem" (Source) para os serviços de infraestrutura (como SSH na porta 22 e Banco de Dados na porta 3306). Nunca use 0.0.0.0/0 (permitir acesso de qualquer lugar da internet) para estas portas em um ambiente de produção, a menos que seja estritamente necessário e gerenciado por regras de rede mais rígidas.

Verifique os SGs: Verifique se os Security Groups que serão utilizados pelo Oberon já contêm essas 



## 📖 Documentação
Mais detalhes sobre a arquitetura e as configurações na AWS estão disponíveis na documentação principal do projeto.

`Nota: Este repositório é privado e contém informações sensíveis de configuração. Não compartilhe publicamente.`


